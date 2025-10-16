Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D2FCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74156427BC;
	Thu, 16 Oct 2025 12:28:24 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1811341157
 for <dev@dpdk.org>; Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F3AE51A270D;
 Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF0CC1A26F1;
 Thu, 16 Oct 2025 12:28:11 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4DB6E180009C;
 Thu, 16 Oct 2025 18:28:11 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 11/15] net/dpaa2: replace global variable to driver flag
Date: Thu, 16 Oct 2025 15:58:01 +0530
Message-ID: <20251016102805.2453687-12-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

This patch replaces the various global variable with
driver specific flag and align.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 29 +++++++++++++++----------
 drivers/net/dpaa2/dpaa2_ethdev.h | 36 +++++++++++++++++++-------------
 drivers/net/dpaa2/dpaa2_rxtx.c   |  4 ++--
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 529856f704..56c23e4717 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -73,9 +73,6 @@ bool dpaa2_enable_ts[RTE_MAX_ETHPORTS];
 uint64_t dpaa2_timestamp_rx_dynflag;
 int dpaa2_timestamp_dynfield_offset = -1;
 
-/* Enable error queue */
-bool dpaa2_enable_err_queue;
-
 bool dpaa2_print_parser_result;
 
 #define MAX_NB_RX_DESC		11264
@@ -507,7 +504,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 			goto fail;
 	}
 
-	if (dpaa2_enable_err_queue) {
+	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
 		priv->rx_err_vq = rte_zmalloc("dpni_rx_err",
 			sizeof(struct dpaa2_queue), 0);
 		if (!priv->rx_err_vq) {
@@ -584,7 +581,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		priv->rx_vq[i--] = NULL;
 	}
 
-	if (dpaa2_enable_err_queue) {
+	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
 		dpaa2_q = priv->rx_err_vq;
 		dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
 	}
@@ -1331,7 +1328,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 		dpaa2_q->fqid = qid.fqid;
 	}
 
-	if (dpaa2_enable_err_queue) {
+	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
 		ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 				     DPNI_QUEUE_RX_ERR, 0, 0, &cfg, &qid);
 		if (ret) {
@@ -2797,6 +2794,17 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	dpni_dev->regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 	eth_dev->process_private = dpni_dev;
 
+	/* RX no prefetch mode? */
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_NO_PREFETCH_MODE)) {
+		priv->flags |= DPAA2_NO_PREFETCH_RX;
+		DPAA2_PMD_INFO("No RX prefetch mode");
+	}
+
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
+		priv->flags |= DPAA2_RX_LOOPBACK_MODE;
+		DPAA2_PMD_INFO("Rx loopback mode");
+	}
+
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		/* In case of secondary, only burst and ops API need to be
@@ -2804,10 +2812,9 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		 */
 		eth_dev->dev_ops = &dpaa2_ethdev_ops;
 		eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
-		if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE))
+		if (priv->flags & DPAA2_RX_LOOPBACK_MODE)
 			eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-		else if (dpaa2_get_devargs(dev->devargs,
-					DRIVER_NO_PREFETCH_MODE))
+		else if (priv->flags & DPAA2_NO_PREFETCH_RX)
 			eth_dev->rx_pkt_burst = dpaa2_dev_rx;
 		else
 			eth_dev->rx_pkt_burst = dpaa2_dev_prefetch_rx;
@@ -2898,8 +2905,8 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_ERROR_QUEUE)) {
-		dpaa2_enable_err_queue = 1;
-		DPAA2_PMD_INFO("Enable DMA error checks");
+		priv->flags |= DPAAX_RX_ERROR_QUEUE_FLAG;
+		DPAA2_PMD_INFO("Enable error queue");
 	}
 
 	if (getenv("DPAA2_PRINT_RX_PARSER_RESULT"))
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index c4133f604f..f4adb76bb6 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -68,26 +68,36 @@
 /* Enable TX Congestion control support
  * default is disable
  */
-#define DPAA2_TX_CGR_OFF	0x01
+#define DPAA2_TX_CGR_OFF	RTE_BIT32(0)
 
 /* Disable RX tail drop, default is enable */
-#define DPAA2_RX_TAILDROP_OFF	0x04
+#define DPAA2_RX_TAILDROP_OFF	RTE_BIT32(2)
+
+/* Disable prefetch Rx mode to get exact requested packets */
+#define DPAA2_NO_PREFETCH_RX	RTE_BIT32(3)
+
+/* Driver level loop mode to simply transmit the ingress traffic */
+#define DPAA2_RX_LOOPBACK_MODE	RTE_BIT32(4)
+
+/* HW loopback the egress traffic to self ingress*/
+#define DPAA2_TX_MAC_LOOPBACK_MODE	RTE_BIT32(5)
+
+#define DPAA2_TX_SERDES_LOOPBACK_MODE	RTE_BIT32(6)
+
+#define DPAA2_TX_DPNI_LOOPBACK_MODE	RTE_BIT32(7)
+
 /* Tx confirmation enabled */
-#define DPAA2_TX_CONF_ENABLE	0x08
+#define DPAA2_TX_CONF_ENABLE	RTE_BIT32(8)
 
 /* Tx dynamic confirmation enabled,
  * only valid with Tx confirmation enabled.
  */
-#define DPAA2_TX_DYNAMIC_CONF_ENABLE	0x10
-/* DPDMUX index for DPMAC */
-#define DPAA2_DPDMUX_DPMAC_IDX 0
-
-/* HW loopback the egress traffic to self ingress*/
-#define DPAA2_TX_MAC_LOOPBACK_MODE 0x20
+#define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
 
-#define DPAA2_TX_SERDES_LOOPBACK_MODE 0x40
+#define DPAAX_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
 
-#define DPAA2_TX_DPNI_LOOPBACK_MODE 0x80
+/* DPDMUX index for DPMAC */
+#define DPAA2_DPDMUX_DPMAC_IDX 0
 
 #define DPAA2_TX_LOOPBACK_MODE \
 	(DPAA2_TX_MAC_LOOPBACK_MODE | \
@@ -167,8 +177,6 @@ extern const struct rte_flow_ops dpaa2_flow_ops;
 
 extern const struct rte_tm_ops dpaa2_tm_ops;
 
-extern bool dpaa2_enable_err_queue;
-
 extern bool dpaa2_print_parser_result;
 
 #define DPAA2_FAPR_SIZE \
@@ -384,7 +392,7 @@ struct dpaa2_dev_priv {
 	struct dpaa2_bp_list *bp_list; /**<Attached buffer pool list */
 	void *tx_conf_vq[MAX_TX_QUEUES * DPAA2_MAX_CHANNELS];
 	void *rx_err_vq;
-	uint8_t flags; /*dpaa2 config flags */
+	uint32_t flags; /*dpaa2 config flags */
 	uint8_t max_mac_filters;
 	uint8_t max_vlan_filters;
 	uint8_t num_rx_tc;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index e57ec2057c..2b55165361 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -758,7 +758,7 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	if (unlikely(dpaa2_enable_err_queue))
+	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
@@ -999,7 +999,7 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-	if (unlikely(dpaa2_enable_err_queue))
+	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-- 
2.43.0

