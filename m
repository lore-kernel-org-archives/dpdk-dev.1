Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E7C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:55:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82AAF42E83;
	Thu, 10 Sep 2026 15:52:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D2B4542E0C
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:37 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B3929200431;
 Thu, 10 Sep 2026 15:52:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C9B920003A;
 Thu, 10 Sep 2026 15:52:37 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 231FB18000B1;
 Thu, 10 Sep 2026 21:52:35 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 30/47] net/dpaa2: rename Rx queue flags
Date: Thu, 10 Sep 2026 19:21:41 +0530
Message-ID: <20260910135158.2181141-31-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Rename the Rx-side device flags to a consistent DPAA2_RX_*_FLAG naming:
DPAAX_RX_ERROR_QUEUE_FLAG becomes DPAA2_RX_ERROR_QUEUE_FLAG and
DPAA2_DATA_STASHING_OFF becomes DPAA2_RX_DATA_STASHING_OFF_FLAG.

This is a mechanical rename with no functional change; it prepares the
flag namespace for the Tx confirmation rework that follows.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 10 +++++-----
 drivers/net/dpaa2/dpaa2_ethdev.h |  4 ++--
 drivers/net/dpaa2/dpaa2_rxtx.c   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 57c6e8e90b..15a886b3e8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -547,7 +547,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 			goto fail;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		priv->rx_err_vq = rte_zmalloc("dpni_rx_err",
 			sizeof(struct dpaa2_queue), 0);
 		if (!priv->rx_err_vq) {
@@ -1041,7 +1041,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		qopt |= DPNI_QUEUE_OPT_FLC;
 		cfg->flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg->flc.value);
-		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
+		if (priv->flags & DPAA2_RX_DATA_STASHING_OFF_FLAG) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg->flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -1499,7 +1499,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_q->fqid = qid.fqid;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 				     DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
 		if (ret) {
@@ -3462,7 +3462,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING) ||
 	    getenv("DPAA2_DATA_STASHING_OFF")) {
-		priv->flags |= DPAA2_DATA_STASHING_OFF;
+		priv->flags |= DPAA2_RX_DATA_STASHING_OFF_FLAG;
 		DPAA2_PMD_INFO("Data stashing disabled");
 	}
 
@@ -3592,7 +3592,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_ERROR_QUEUE)) {
-		priv->flags |= DPAAX_RX_ERROR_QUEUE_FLAG;
+		priv->flags |= DPAA2_RX_ERROR_QUEUE_FLAG;
 		DPAA2_PMD_INFO("Enable error queue");
 	}
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 65c5378547..bdd8855023 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -100,9 +100,9 @@
 #define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
 
 /* Disable data stashing (prefetch of packet data into CPU cache) */
-#define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
+#define DPAA2_RX_DATA_STASHING_OFF_FLAG		RTE_BIT32(10)
 
-#define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+#define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
 #define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
 
 /* DPDMUX index for DPMAC */
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index ccb4bbe7dc..a03e3fd8db 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -870,7 +870,7 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
@@ -1142,7 +1142,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-	if (!by_channel && unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+	if (!by_channel && unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (by_channel) {
-- 
2.43.0

