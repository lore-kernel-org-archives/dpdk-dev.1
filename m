Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB93CC6B24
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 05:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2CC940A76;
	Wed, 14 Oct 2026 07:44:27 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D542A4066C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 07:44:17 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B88AB200132;
 Wed, 14 Oct 2026 07:44:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B17020012F;
 Wed, 14 Oct 2026 07:44:17 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2633118000B6;
 Wed, 14 Oct 2026 13:44:16 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v10-S2 11/11] net/dpaa2: rename Rx queue flags
Date: Wed, 14 Oct 2026 11:14:00 +0530
Message-ID: <20261014054400.980123-12-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014054400.980123-1-prashant.gupta_3@nxp.com>
References: <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261014054400.980123-1-prashant.gupta_3@nxp.com>
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

This is a mechanical rename with no functional change.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 10 +++++-----
 drivers/net/dpaa2/dpaa2_ethdev.h |  6 ++++--
 drivers/net/dpaa2/dpaa2_rxtx.c   |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 4f5e738965..b3a1631923 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -550,7 +550,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 			goto fail;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		priv->rx_err_vq = rte_zmalloc("dpni_rx_err",
 			sizeof(struct dpaa2_queue), 0);
 		if (!priv->rx_err_vq) {
@@ -1041,7 +1041,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		options |= DPNI_QUEUE_OPT_FLC;
 		cfg.flc.stash_control = true;
 		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
-		if (priv->flags & DPAA2_DATA_STASHING_OFF) {
+		if (priv->flags & DPAA2_RX_DATA_STASHING_OFF_FLAG) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
 				&cfg.flc.value);
 			dpaa2_q->data_stashing_off = 1;
@@ -1521,7 +1521,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_q->fqid = qid.fqid;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG) {
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 				     DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
 		if (ret) {
@@ -3475,7 +3475,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_DATA_STASHING) ||
 	    getenv("DPAA2_DATA_STASHING_OFF")) {
-		priv->flags |= DPAA2_DATA_STASHING_OFF;
+		priv->flags |= DPAA2_RX_DATA_STASHING_OFF_FLAG;
 		DPAA2_PMD_INFO("Data stashing disabled");
 	}
 
@@ -3581,7 +3581,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_ERROR_QUEUE)) {
-		priv->flags |= DPAAX_RX_ERROR_QUEUE_FLAG;
+		priv->flags |= DPAA2_RX_ERROR_QUEUE_FLAG;
 		DPAA2_PMD_INFO("Enable error queue");
 	}
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 8e1852741c..23de2a7262 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -98,9 +98,11 @@
 #define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
 
 /* Disable data stashing (prefetch of packet data into CPU cache) */
-#define DPAA2_DATA_STASHING_OFF		RTE_BIT32(10)
+#define DPAA2_RX_DATA_STASHING_OFF_FLAG		RTE_BIT32(10)
 
-#define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+#define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+
+#define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
 
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 7da75649e2..85c8a4550b 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -839,7 +839,7 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	if (!by_channel) {
 		struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-		if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+		if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 			dump_err_pkts(priv->rx_err_vq);
 	}
 
@@ -1104,7 +1104,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-	if (!by_channel && unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+	if (!by_channel && unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (by_channel) {
-- 
2.43.0

