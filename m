Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A8CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 06:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E349427B2;
	Wed, 30 Sep 2026 08:24:45 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D3FF140612;
 Wed, 30 Sep 2026 08:24:41 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B673F1A01B9;
 Wed, 30 Sep 2026 08:24:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80B3C1A019D;
 Wed, 30 Sep 2026 08:24:41 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A525718000BE;
 Wed, 30 Sep 2026 14:24:40 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v18 02/24] net/dpaa: fix resource leak on probe failure
Date: Wed, 30 Sep 2026 11:54:15 +0530
Message-Id: <20260930062437.3019096-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930062437.3019096-1-hemant.agrawal@nxp.com>
References: <20260929104519.1770698-1-hemant.agrawal@nxp.com>
 <20260930062437.3019096-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

When the shared Tx scatter-gather mempool cannot be created,
rte_dpaa_probe() returns -ENOMEM directly:

This is reached after dpaa_dev_init() has already succeeded, so the
early return abandons everything set up for the port.

Unwind through cleanup labels so the failure path closes the device and
releases the port, matching the existing dpaa_dev_init() failure path.

Fixes: 533c31cc8331 ("net/dpaa: use internal mempool for SG table")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 36 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index a5b02cc9a8..a8f5a93db4 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2601,24 +2601,30 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 
 	/* Invoke PMD device initialization function */
 	diag = dpaa_dev_init(eth_dev);
-	if (diag == 0) {
-		if (!dpaa_tx_sg_pool) {
-			dpaa_tx_sg_pool =
-				rte_pktmbuf_pool_create("dpaa_mbuf_tx_sg_pool",
-				DPAA_POOL_SIZE,
-				DPAA_POOL_CACHE_SIZE, 0,
-				DPAA_MAX_SGS * sizeof(struct qm_sg_entry),
-				rte_socket_id());
-			if (dpaa_tx_sg_pool == NULL) {
-				DPAA_PMD_ERR("SG pool creation failed");
-				return -ENOMEM;
-			}
+	if (diag != 0)
+		goto release_port;
+
+	if (dpaa_tx_sg_pool == NULL) {
+		dpaa_tx_sg_pool =
+			rte_pktmbuf_pool_create("dpaa_mbuf_tx_sg_pool",
+			DPAA_POOL_SIZE,
+			DPAA_POOL_CACHE_SIZE, 0,
+			DPAA_MAX_SGS * sizeof(struct qm_sg_entry),
+			rte_socket_id());
+		if (dpaa_tx_sg_pool == NULL) {
+			DPAA_PMD_ERR("SG pool creation failed");
+			diag = -ENOMEM;
+			goto close_dev;
 		}
-		rte_eth_dev_probing_finish(eth_dev);
-		dpaa_valid_dev++;
-		return 0;
 	}
 
+	rte_eth_dev_probing_finish(eth_dev);
+	dpaa_valid_dev++;
+	return 0;
+
+close_dev:
+	dpaa_eth_dev_close(eth_dev);
+release_port:
 	rte_eth_dev_release_port(eth_dev);
 	return diag;
 }
-- 
2.25.1

