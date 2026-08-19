Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C55C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026E14064F;
	Wed, 19 Aug 2026 12:50:14 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B1FD140041;
 Wed, 19 Aug 2026 12:50:10 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 896911A00B1;
 Wed, 19 Aug 2026 12:50:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5160D1A0097;
 Wed, 19 Aug 2026 12:50:10 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 94E6D18000B0;
 Wed, 19 Aug 2026 18:50:08 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v13 01/25] net/dpaa: fix device remove
Date: Wed, 19 Aug 2026 16:19:40 +0530
Message-Id: <20260819105004.2272880-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
References: <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260819105004.2272880-1-hemant.agrawal@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Adds a check to not to close device if already closed.

Fixes: 78ea4b4fcb52 ("bus/dpaa: improve cleanup")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 4dc4d1f10c..77730f16e3 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2677,9 +2677,12 @@ rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
-	ret = dpaa_eth_dev_close(eth_dev);
-	if (eth_dev->state !=  RTE_ETH_DEV_UNUSED) {
-		dpaa_eth_dev_close(eth_dev);
+	if (eth_dev && eth_dev->state != RTE_ETH_DEV_UNUSED) {
+		int close_ret = dpaa_eth_dev_close(eth_dev);
+
+		if (close_ret)
+			DPAA_PMD_WARN("%s: close failed (%d), releasing port anyway",
+				dpaa_dev->device.name, close_ret);
 		ret = rte_eth_dev_release_port(eth_dev);
 	}
 	dpaa_valid_dev--;
-- 
2.25.1

