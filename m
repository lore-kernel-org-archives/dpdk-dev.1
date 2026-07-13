Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F20C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:28:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8977D40EDF;
	Mon, 13 Jul 2026 11:26:46 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9914C40E72;
 Mon, 13 Jul 2026 11:26:44 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F0AD1A000C;
 Mon, 13 Jul 2026 11:26:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 54A131A0007;
 Mon, 13 Jul 2026 11:26:44 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A2F0918000B5;
 Mon, 13 Jul 2026 17:26:42 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4 18/18] net/dpaa: fix device remove
Date: Mon, 13 Jul 2026 14:56:16 +0530
Message-Id: <20260713092616.2902828-19-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713092616.2902828-1-hemant.agrawal@nxp.com>
References: <20260619103901.2274740-1-hemant.agrawal@nxp.com>
 <20260713092616.2902828-1-hemant.agrawal@nxp.com>
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

Add a check to avoid closing a device that is already closed,
preventing a double-close condition during device removal.

Note: this also removes the explicit dpaa_finish() call that was
made at last-device remove time (!dpaa_valid_dev). dpaa_finish() is
registered as RTE_FINI_PRIO(dpaa_finish, 103) and will still run at
process exit, so for the normal run-then-exit path behaviour is
unchanged. For a remove-all-then-re-probe scenario, is_global_init
will remain set until exit; re-probe in a running process is not a
supported use case for this driver.

Fixes: 78ea4b4fcb52 ("bus/dpaa: improve cleanup")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index f6d9dd6248..4dc4d1f10c 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2672,18 +2672,20 @@ static int
 rte_dpaa_remove(struct rte_dpaa_device *dpaa_dev)
 {
 	struct rte_eth_dev *eth_dev;
-	int ret;
+	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
 	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
-	dpaa_eth_dev_close(eth_dev);
-	ret = rte_eth_dev_release_port(eth_dev);
+	ret = dpaa_eth_dev_close(eth_dev);
+	if (eth_dev->state !=  RTE_ETH_DEV_UNUSED) {
+		dpaa_eth_dev_close(eth_dev);
+		ret = rte_eth_dev_release_port(eth_dev);
+	}
 	dpaa_valid_dev--;
-	if (!dpaa_valid_dev) {
+	if (!dpaa_valid_dev)
 		rte_mempool_free(dpaa_tx_sg_pool);
-		dpaa_finish();
-	}
+
 	return ret;
 }
 
-- 
2.25.1

