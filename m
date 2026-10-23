Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB8606A328
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D3FE40DD8;
	Fri, 23 Oct 2026 15:44:12 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9625A40A87
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:05 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 64890200047;
 Fri, 23 Oct 2026 15:44:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2F8720002B;
 Fri, 23 Oct 2026 15:44:04 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6D79D180006C;
 Fri, 23 Oct 2026 21:44:03 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 12/65] The dpaa2 PMD so far supported only two Tx buffer
 release schemes: direct release by hardware,
 and an absolute Tx confirmation mode (drv_tx_conf=1) where every transmitted
 buffer is returned on a Tx confirmation queue that software must poll to free
 the buffers. Absolute confirmation adds a confirmation descriptor and a poll
 cost for all packets, even those the hardware could free on its own.
Date: Fri, 23 Oct 2026 19:12:52 +0530
Message-ID: <20261023134346.37727-13-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Add a dynamic Tx confirmation mode in which only the buffers that the
hardware cannot release directly (for example indirect, external or
shared buffers) are returned on the Tx confirmation queue, while
ordinary buffers from the known hardware pool are still freed by the
hardware. This keeps the fast path cheap and limits confirmation
polling to the cases that actually need it. The mode is enabled with
the new device argument drv_tx_dyn_conf=1.

The Tx path is reworked to build either a simple or a scatter-gather
FD with per-buffer confirmation decided at enqueue time
(dpaa2_dev_tx_mbuf_to_simple_fd / dpaa2_dev_tx_mbuf_to_sg_fd and the
confirm/no-confirm SGE helpers), the FAEAD is programmed accordingly
(dpaa2_dev_tx_config_dynamic_confirm), and dpaa2_dev_tx_conf() drains
the confirmation queue and frees only the buffers that were handed
back. The Rx FD-to-mbuf helpers are exported so the confirmation path
can reuse them. Documentation and the device argument string are
updated for the new option.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 doc/guides/nics/dpaa2.rst                    |   11 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |    2 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c             |   67 +-
 drivers/net/dpaa2/dpaa2_ethdev.h             |   27 +-
 drivers/net/dpaa2/dpaa2_ptp.c                |    6 +-
 drivers/net/dpaa2/dpaa2_rxtx.c               | 1436 ++++++++----------
 7 files changed, 683 insertions(+), 872 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 60ca695f59..4480a5f652 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -476,10 +476,17 @@ Refer to the document :doc:`build_and_test` for details.
   of the packet pull command which is issued  in the previous cycle.
   e.g. ``fslmc:dpni.1,drv_no_prefetch=1``
 
-* Use dev arg option  ``drv_tx_conf=1`` to enable TX confirmation mode.
-  In this mode tx conf queues need to be polled to free the buffers.
+* Use dev arg option  ``drv_tx_conf=1`` to enable absolute TX confirmation mode.
+  In this mode every transmitted buffer is returned on a tx conf queue which
+  needs to be polled to free the buffers.
   e.g. ``fslmc:dpni.1,drv_tx_conf=1``
 
+* Use dev arg option  ``drv_tx_dyn_conf=1`` to enable dynamic TX confirmation
+  mode. In this mode only buffers that cannot be released directly by the
+  hardware (for example indirect, external or shared buffers) are returned on
+  a tx conf queue which needs to be polled to free the buffers.
+  e.g. ``fslmc:dpni.1,drv_tx_dyn_conf=1``
+
 * Use dev arg option ``drv_rx_parse_drop=1`` to configure the system
   to start dropping the error packets in hardware (parse errors).
   e.g. ``fslmc:dpni.1,drv_rx_parse_drop=1``
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 83694133f1..5f4268f0d7 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -482,7 +482,7 @@ dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
 	 */
 
 	/* ... rx buffer layout ... */
-	if (priv->flags & DPAA2_TX_DYNAMIC_CONF_ENABLE) {
+	if (priv->tx_conf_type == DPAA2_TX_DYNAMIC_CONF) {
 		int out_min_hdr_room, in_min_hdr_room;
 		/** Additional headroom layout for IPSec with TX configure
 		 * dynamic enabled.
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
index a670098958..b06fa3f644 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2019,2022,2024 NXP
+ *   Copyright 2016,2019,2022,2024-2026 NXP
  *
  */
 
@@ -281,6 +281,10 @@ struct dpaa2_faead {
 /*UPD (Update prepended data)*/
 #define DPAA2_ANNOT_FAEAD_UPD		0x00000010
 
+#define DPAA2_TX_CONFIRM_ENABLE \
+	(DPAA2_ANNOT_FAEAD_A4V | DPAA2_ANNOT_FAEAD_EBDD | \
+	DPAA2_ANNOT_FAEAD_EBDDV)
+
 /* Debug frame, otherwise supposed to be discarded */
 #define DPAA2_ETH_FAS_DISC	      0x80000000
 /* MACSEC frame */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0e515d560e..f4ed12f45a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -38,6 +38,29 @@ static const struct rte_mbuf_dynfield s_dpaa2_rx_protocol_pos_dyn = {
 	.align = __alignof__(struct dpaa2_dyn_rx_protocol_pos),
 };
 
+#define DRIVER_TX_CONF "drv_tx_conf"
+#define DRIVER_TX_DYNAMIC_CONF "drv_tx_dyn_conf"
+
+static void
+dpaa2_dev_args_set_tx_conf(void *vdev,
+	const struct rte_kvargs_pair *pair)
+{
+	struct rte_eth_dev *dev = vdev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int val = pair->value ? atoi(pair->value) : 0;
+
+	if (!strcmp(DRIVER_TX_CONF, pair->key) && val) {
+		priv->tx_conf_type = DPAA2_TX_ABSOLUTE_CONF;
+	} else if (!strcmp(DRIVER_TX_DYNAMIC_CONF, pair->key) && val) {
+		priv->tx_conf_type = DPAA2_TX_DYNAMIC_CONF;
+	} else {
+		priv->tx_conf_type = DPAA2_TX_NO_CONF;
+		return;
+	}
+
+	DPAA2_PMD_INFO("%s Enabled", pair->key);
+}
+
 static void
 dpaa2_dev_args_parser_offset_en(void *vdev,
 	const struct rte_kvargs_pair *pair)
@@ -68,7 +91,8 @@ dpaa2_dev_args_parser_offset_en(void *vdev,
 #define DPAA2_DEVARGS(ENTRY) \
 	ENTRY("drv_loopback", NULL, DPAA2_RX_LOOPBACK_MODE) \
 	ENTRY("drv_no_prefetch", NULL, DPAA2_NO_PREFETCH_RX) \
-	ENTRY("drv_tx_conf", NULL, DPAA2_TX_CONF_ENABLE) \
+	ENTRY(DRIVER_TX_CONF, dpaa2_dev_args_set_tx_conf, 0) \
+	ENTRY(DRIVER_TX_DYNAMIC_CONF, dpaa2_dev_args_set_tx_conf, 0) \
 	ENTRY("drv_rx_parse_drop", NULL, DPAA2_PARSE_ERR_DROP) \
 	ENTRY("drv_rx_print_parser_result", NULL, DPAA2_RX_PRINT_PSR_RESULT_FLAG) \
 	ENTRY("drv_err_queue", NULL, DPAA2_RX_ERROR_QUEUE_FLAG) \
@@ -561,7 +585,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (priv->flags & DPAA2_TX_CONF_ENABLE)
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF)
 		tot_queues = priv->nb_rx_queues + 2 * priv->nb_tx_queues;
 	else
 		tot_queues = priv->nb_rx_queues + priv->nb_tx_queues;
@@ -617,7 +641,7 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
 		/*Setup tx confirmation queues*/
 		for (i = 0; i < priv->nb_tx_queues; i++) {
 			mc_q->eth_data = dev->data;
@@ -732,7 +756,7 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 			rte_free(dpaa2_q->cscn);
 			priv->tx_vq[i] = NULL;
 		}
-		if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+		if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
 			/* cleanup tx conf queue storage */
 			for (i = 0; i < priv->nb_tx_queues; i++) {
 				dpaa2_q = priv->tx_conf_vq[i];
@@ -1181,6 +1205,13 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Tx deferred start is not supported */
+	if (tx_conf->tx_deferred_start) {
+		DPAA2_PMD_ERR("%s:Tx deferred start not supported",
+			dev->data->name);
+		return -EINVAL;
+	}
+
 	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = tx_conf->offloads;
 
@@ -1260,7 +1291,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->cb_eqresp_free = dpaa2_dev_free_eqresp_buf;
 	dev->data->tx_queues[tx_queue_id] = dpaa2_q;
 
-	if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
 		tc_id = dpaa2_tx_conf_q->tc_index;
 		flow_id = dpaa2_tx_conf_q->flow_id;
 		dpaa2_q->tx_conf_queue = dpaa2_tx_conf_q;
@@ -3579,7 +3610,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	for (i = 0; i < priv->num_channels; i++) {
 		/*Set tx-conf and error configuration*/
-		if (priv->flags & DPAA2_TX_CONF_ENABLE) {
+		if (priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF) {
 			ret = dpni_set_tx_confirmation_mode(dpni_dev,
 				CMD_PRI_LOW, priv->token, i, DPNI_CONF_AFFINE);
 		} else {
@@ -3616,34 +3647,22 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	/* ... tx buffer layout ... */
 	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
-	if (priv->flags & DPAA2_TX_CONF_ENABLE) {
-		layout.options = DPNI_BUF_LAYOUT_OPT_FRAME_STATUS |
-				 DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
+	if (priv->tx_conf_type != DPAA2_TX_NO_CONF) {
+		layout.options = DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
 		layout.pass_timestamp = true;
-	} else {
-		layout.options = DPNI_BUF_LAYOUT_OPT_FRAME_STATUS;
 	}
+	layout.options |= DPNI_BUF_LAYOUT_OPT_FRAME_STATUS;
 	layout.pass_frame_status = 1;
 	ret = dpni_set_buffer_layout(dpni_dev, CMD_PRI_LOW, priv->token,
-				     DPNI_QUEUE_TX, &layout);
+			DPNI_QUEUE_TX, &layout);
 	if (ret) {
 		DPAA2_PMD_ERR("Error (%d) in setting tx buffer layout", ret);
 		goto init_err;
 	}
-
-	/* ... tx-conf and error buffer layout ... */
-	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
-	if (priv->flags & DPAA2_TX_CONF_ENABLE) {
-		layout.options = DPNI_BUF_LAYOUT_OPT_TIMESTAMP;
-		layout.pass_timestamp = true;
-	}
-	layout.options |= DPNI_BUF_LAYOUT_OPT_FRAME_STATUS;
-	layout.pass_frame_status = 1;
 	ret = dpni_set_buffer_layout(dpni_dev, CMD_PRI_LOW, priv->token,
-				     DPNI_QUEUE_TX_CONFIRM, &layout);
+			DPNI_QUEUE_TX_CONFIRM, &layout);
 	if (ret) {
-		DPAA2_PMD_ERR("Error (%d) in setting tx-conf buffer layout",
-			     ret);
+		DPAA2_PMD_ERR("Error (%d) in setting tx conf buffer layout", ret);
 		goto init_err;
 	}
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 55027d6afb..28d6eb04ac 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -95,20 +95,12 @@
 
 #define DPAA2_TX_DPNI_LOOPBACK_MODE	RTE_BIT32(7)
 
-/* Tx confirmation enabled */
-#define DPAA2_TX_CONF_ENABLE	RTE_BIT32(8)
-
-/* Tx dynamic confirmation enabled,
- * only valid with Tx confirmation enabled.
- */
-#define DPAA2_TX_DYNAMIC_CONF_ENABLE	RTE_BIT32(9)
-
 /* Disable data stashing (prefetch of packet data into CPU cache) */
-#define DPAA2_RX_DATA_STASHING_OFF_FLAG		RTE_BIT32(10)
+#define DPAA2_RX_DATA_STASHING_OFF_FLAG		RTE_BIT32(8)
 
-#define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
+#define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(9)
 
-#define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
+#define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(10)
 
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
@@ -433,6 +425,12 @@ struct extract_s {
 	uint8_t *tc_extract_param[MAX_TCS];
 };
 
+enum dpaa2_tx_conf_type {
+	DPAA2_TX_NO_CONF,
+	DPAA2_TX_ABSOLUTE_CONF,
+	DPAA2_TX_DYNAMIC_CONF
+};
+
 struct dpaa2_dev_priv {
 	void *hw;
 	int32_t hw_id;
@@ -448,6 +446,7 @@ struct dpaa2_dev_priv {
 	void *tx_conf_vq[MAX_TX_QUEUES];
 	void *rx_err_vq;
 	uint32_t flags; /*dpaa2 config flags */
+	enum dpaa2_tx_conf_type tx_conf_type;
 	uint32_t psr_dynfield_offset;
 	uint8_t max_mac_filters;
 	uint8_t max_vlan_filters;
@@ -487,10 +486,10 @@ struct dpaa2_dev_priv {
 	/*stores timestamp of last received tx confirmation packet on dev*/
 	uint64_t tx_timestamp;
 
-	/* stores pointer to next tx_conf queue that should be processed,
+	/* stores next tx queue to be confirmed that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
-	struct dpaa2_queue *next_tx_conf_queue;
+	struct dpaa2_queue *next_txq_to_cnf;
 
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
@@ -621,7 +620,7 @@ uint16_t dpaa2_dev_tx_multi_txq_ordered(void **queue,
 
 void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
 void dpaa2_flow_clean(struct rte_eth_dev *dev);
-uint16_t dpaa2_dev_tx_conf(void *queue)  __rte_unused;
+uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
 int dpaa2_timesync_enable(struct rte_eth_dev *dev);
 int dpaa2_timesync_disable(struct rte_eth_dev *dev);
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..2863cad4dd 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2019, 2023 NXP
+ * Copyright 2019, 2023-2026 NXP
  */
 
 #include <sys/queue.h>
@@ -111,9 +111,9 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	if (priv->next_tx_conf_queue) {
+	if (priv->next_txq_to_cnf) {
 		while (!priv->tx_timestamp)
-			dpaa2_dev_tx_conf(priv->next_tx_conf_queue);
+			dpaa2_dev_tx_conf(priv->next_txq_to_cnf, false);
 	} else {
 		return -1;
 	}
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index ebad66fd5e..24631b16c5 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -133,6 +133,24 @@ rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	DPAA2_RESET_FD_FLC(_fd);		\
 } while (0)
 
+/* Build a contiguous FD which is returned on the Tx confirmation queue.
+ * The buffer is not released by the hardware, so an invalid buffer pool
+ * ID is programmed and the mbuf is carried in the FLC to be freed once
+ * the confirmation is dequeued.
+ */
+static inline void
+dpaa2_mbuf_to_conf_contig_fd(struct rte_mbuf *mbuf, struct qbman_fd *fd)
+{
+	DPAA2_SET_FD_ADDR(fd, DPAA2_MBUF_VADDR_TO_IOVA(mbuf));
+	DPAA2_SET_FD_LEN(fd, mbuf->data_len);
+	DPAA2_SET_ONLY_FD_BPID(fd, MAX_BPID);
+	DPAA2_SET_FD_IVP(fd);
+	DPAA2_SET_FD_OFFSET(fd, mbuf->data_off);
+	DPAA2_SET_FD_FRC(fd, 0);
+	DPAA2_RESET_FD_CTRL(fd);
+	DPAA2_SET_FD_FLC(fd, mbuf);
+}
+
 static inline void
 dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
 	const struct qbman_fd *fd)
@@ -247,13 +265,6 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 			"(4)=0x%" PRIx64 "\t",
 			annotation->word3, annotation->word4);
 
-#if defined(RTE_LIBRTE_IEEE1588)
-	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_PTP)) {
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
-		mbuf->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
-	}
-#endif
-
 	if (BIT_ISSET_AT_POS(annotation->word3, L2_VLAN_1_PRESENT)) {
 		vlan_tci = rte_pktmbuf_mtod_offset(mbuf, uint16_t *,
 			(VLAN_TCI_OFFSET_1(annotation->word5) >> 16));
@@ -394,9 +405,9 @@ static inline struct rte_mbuf *__rte_hot
 dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	struct qbman_sge *sgt, *sge;
-	size_t sg_addr, fd_addr;
+	size_t fd_addr;
 	int i = 0, is_vlan = false;
-	void *hw_annot_addr;
+	void *hw_annot_addr, *sg_addr;
 	struct rte_mbuf *first_seg, *next_seg, *cur_seg, *temp;
 
 	if (unlikely(dpaa2_svr_family == SVR_LX2160A &&
@@ -410,7 +421,7 @@ dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	sgt = (struct qbman_sge *)(fd_addr + DPAA2_GET_FD_OFFSET(fd));
 
 	sge = &sgt[i++];
-	sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
+	sg_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
 
 	/* First Scatter gather entry */
 	first_seg = DPAA2_INLINE_MBUF_FROM_BUF(sg_addr,
@@ -438,7 +449,7 @@ dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	cur_seg = first_seg;
 	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
 		sge = &sgt[i++];
-		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
+		sg_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
 		next_seg = DPAA2_INLINE_MBUF_FROM_BUF(sg_addr,
 			rte_dpaa2_bpid_info[DPAA2_GET_FLE_BPID(sge)].meta_data_size);
 		next_seg->buf_addr = (uint8_t *)sg_addr;
@@ -521,119 +532,259 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	return mbuf;
 }
 
+static inline struct rte_mbuf *
+dpaa2_dev_mbuf_copy_one_seg(const struct rte_mbuf *sgm, struct rte_mempool *mp)
+{
+	struct rte_mbuf *mc = rte_pktmbuf_alloc(mp);
+
+	if (!mc)
+		return NULL;
+	if ((mc->data_off + sgm->data_len) > mc->buf_len) {
+		rte_pktmbuf_free(mc);
+		return NULL;
+	}
+	rte_memcpy(rte_pktmbuf_mtod(mc, void *),
+		rte_pktmbuf_mtod(sgm, void *), sgm->data_len);
+	mc->pkt_len = sgm->data_len;
+	mc->data_len = sgm->data_len;
+	mc->next = NULL;
+
+	return mc;
+}
+
+static inline void
+dpaa2_dev_tx_config_dynamic_confirm(struct qbman_fd *fd,
+	struct dpaa2_queue *txq, int enable)
+{
+	struct dpaa2_faead *fd_faead;
+	void *fd_va = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+
+	DPAA2_SET_FD_FRC(fd, DPAA2_GET_FD_FRC(fd) | DPAA2_FD_FRC_FAEADV);
+	/* enable update of confirmation frame annotation */
+	fd_faead = (void *)((size_t)fd_va +
+			DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
+	if (enable) {
+		fd_faead->fqid = txq->tx_conf_queue->fqid;
+		fd_faead->ctrl = DPAA2_TX_CONFIRM_ENABLE;
+	} else {
+		fd_faead->fqid = 0;
+		fd_faead->ctrl &= (~DPAA2_TX_CONFIRM_ENABLE);
+	}
+}
+
+static int
+dpaa2_dev_tx_no_conf_mbuf_to_sge(struct qbman_sge *sgt,
+	struct rte_mbuf *mbuf, uint16_t nb_segs, struct rte_mbuf *sg_mbuf,
+	struct rte_mempool *hw_mp)
+{
+	int i;
+	struct qbman_sge *sge = NULL;
+	struct rte_mbuf *cur_seg, *mi, *prev, *copy_mbuf;
+
+	cur_seg = mbuf;
+	prev = NULL;
+	for (i = 0; i < nb_segs; i++) {
+		sge = &sgt[i];
+		/*Resetting the buffer pool id and offset field*/
+		sge->fin_bpid_offset = 0;
+		if (unlikely(RTE_MBUF_CLONED(cur_seg))) {
+			copy_mbuf = dpaa2_dev_mbuf_copy_one_seg(cur_seg, hw_mp);
+			if (!copy_mbuf)
+				return -ENOMEM;
+			mi = rte_mbuf_from_indirect(cur_seg);
+			if (rte_mbuf_refcnt_read(mi) > 1)
+				rte_mbuf_refcnt_update(mi, -1);
+			else
+				rte_pktmbuf_free_seg(mi);
+			copy_mbuf->next = cur_seg->next;
+			if (prev)
+				prev->next = copy_mbuf;
+			rte_pktmbuf_init(cur_seg->pool, NULL, cur_seg, 0);
+			rte_pktmbuf_free_seg(cur_seg);
+			cur_seg = copy_mbuf;
+		}
+		if (unlikely(RTE_MBUF_HAS_EXTBUF(cur_seg) ||
+			cur_seg->pool->ops_index != hw_mp->ops_index)) {
+			copy_mbuf = dpaa2_dev_mbuf_copy_one_seg(cur_seg, hw_mp);
+			if (!copy_mbuf)
+				return -ENOMEM;
+
+			copy_mbuf->next = cur_seg->next;
+
+			if (prev)
+				prev->next = copy_mbuf;
+			if (rte_mbuf_refcnt_read(cur_seg) > 1)
+				rte_mbuf_refcnt_update(cur_seg, -1);
+			else
+				rte_pktmbuf_free_seg(cur_seg);
+			cur_seg = copy_mbuf;
+		}
+		DPAA2_SET_FLE_ADDR(sge, DPAA2_MBUF_VADDR_TO_IOVA(cur_seg));
+		DPAA2_SET_FLE_OFFSET(sge, cur_seg->data_off);
+		DPAA2_SET_FLE_LEN(sge, cur_seg->data_len);
+		if (unlikely(rte_mbuf_refcnt_read(cur_seg) > 1)) {
+			DPAA2_SET_FLE_BPID(sge, MAX_BPID);
+			DPAA2_SET_FLE_IVP(sge);
+			rte_mbuf_refcnt_update(cur_seg, -1);
+		} else {
+			DPAA2_SET_FLE_BPID(sge, mempool_to_bpid(cur_seg->pool));
+		}
+		if (sg_mbuf == cur_seg)
+			DPAA2_SG_SET_FORMAT(sge, qbman_fd_list);
+		prev = cur_seg;
+		cur_seg = cur_seg->next;
+	}
+
+	if (likely(sge))
+		DPAA2_SG_SET_FINAL(sge, true);
+
+	return 0;
+}
+
+static void
+dpaa2_dev_tx_conf_mbuf_to_sge(struct qbman_sge *sgt,
+	struct rte_mbuf *mbuf, uint16_t nb_segs, struct rte_mbuf *sg_mbuf)
+{
+	int i;
+	struct qbman_sge *sge = NULL;
+	struct rte_mbuf *cur_seg = mbuf, *mi, *prev;
+
+	prev = NULL;
+	for (i = 0; i < nb_segs; i++) {
+		sge = &sgt[i];
+		/*Resetting the buffer pool id and offset field*/
+		sge->fin_bpid_offset = 0;
+		if (unlikely(RTE_MBUF_CLONED(cur_seg))) {
+			mi = rte_mbuf_from_indirect(cur_seg);
+			mi->next = cur_seg->next;
+			if (prev)
+				prev->next = mi;
+			rte_pktmbuf_init(cur_seg->pool, NULL, cur_seg, 0);
+			rte_pktmbuf_free_seg(cur_seg);
+			cur_seg = mi;
+		}
+		DPAA2_SET_FLE_ADDR(sge, DPAA2_MBUF_VADDR_TO_IOVA(cur_seg));
+		DPAA2_SET_FLE_OFFSET(sge, cur_seg->data_off);
+		DPAA2_SET_FLE_LEN(sge, cur_seg->data_len);
+		DPAA2_SET_FLE_BPID(sge, MAX_BPID);
+		DPAA2_SET_FLE_IVP(sge);
+		if (sg_mbuf == cur_seg)
+			DPAA2_SG_SET_FORMAT(sge, qbman_fd_list);
+		prev = cur_seg;
+		cur_seg = cur_seg->next;
+	}
+
+	if (likely(sge))
+		DPAA2_SG_SET_FINAL(sge, true);
+}
+
 static int __rte_noinline __rte_hot
-eth_mbuf_to_sg_fd(struct rte_mbuf *mbuf,
-		  struct qbman_fd *fd,
-		  struct sw_buf_free *free_buf,
-		  uint32_t *free_count,
-		  uint32_t pkt_id,
-		  uint16_t bpid)
+dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
+	struct rte_mbuf *mbuf, struct qbman_fd *fd,
+	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
+	uint8_t *dy_conf)
 {
-	struct rte_mbuf *cur_seg = mbuf, *mi, *temp;
-	struct qbman_sge *sgt, *sge = NULL;
-	int i, offset = 0;
+	struct rte_mbuf *cur_seg = mbuf, *sg_mbuf;
+	struct qbman_sge *sgt;
+	int offset = 0, ret, need_dyconf = false, need_conf = false;
+	uint16_t nb_segs = mbuf->nb_segs;
+	uint32_t sg_size = nb_segs * sizeof(struct qbman_sge);
+	struct rte_mempool *mp;
 
-#ifdef RTE_LIBRTE_IEEE1588
-	/* annotation area for timestamp in first buffer */
-	offset = 0x64;
-#endif
-	if (RTE_MBUF_DIRECT(mbuf) &&
-		(mbuf->data_off > (mbuf->nb_segs * sizeof(struct qbman_sge)
-		+ offset))) {
-		temp = mbuf;
-		if (rte_mbuf_refcnt_read(temp) > 1) {
-			/* If refcnt > 1, invalid bpid is set to ensure
-			 * buffer is not freed by HW
-			 */
-			fd->simple.bpid_offset = 0;
+	if (conf == DPAA2_TX_DYNAMIC_CONF) {
+		while (cur_seg) {
+			if (!RTE_MBUF_DIRECT(cur_seg) ||
+				cur_seg->pool->ops_index != hw_mp->ops_index ||
+				rte_mbuf_refcnt_read(cur_seg) > 1) {
+				need_dyconf = true;
+				break;
+			}
+			cur_seg = cur_seg->next;
+		}
+		cur_seg = mbuf;
+	}
+	if (need_dyconf || conf == DPAA2_TX_ABSOLUTE_CONF)
+		need_conf = true;
+
+	if (need_dyconf)
+		offset = DPAA2_FD_PTA_SIZE + DPAA2_DYN_TX_MIN_FD_OFFSET;
+
+	if (mbuf->pool->ops_index == hw_mp->ops_index &&
+		RTE_MBUF_DIRECT(mbuf) &&
+		mbuf->data_off > RTE_ALIGN(sg_size + offset, 8)) {
+		sg_mbuf = mbuf;
+		mp = mbuf->pool;
+		if (need_conf) {
+			DPAA2_SET_ONLY_FD_BPID(fd, MAX_BPID);
 			DPAA2_SET_FD_IVP(fd);
-			rte_mbuf_refcnt_update(temp, -1);
 		} else {
-			DPAA2_SET_ONLY_FD_BPID(fd, bpid);
+			if (unlikely(rte_mbuf_refcnt_read(sg_mbuf) > 1)) {
+				DPAA2_SET_ONLY_FD_BPID(fd, MAX_BPID);
+				DPAA2_SET_FD_IVP(fd);
+				rte_mbuf_refcnt_update(sg_mbuf, -1);
+			} else {
+				DPAA2_SET_ONLY_FD_BPID(fd, mempool_to_bpid(mp));
+			}
+		}
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-			rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
-					(void **)&temp, 1, 0);
+		rte_mempool_check_cookies(rte_mempool_from_obj(sg_mbuf),
+			(void **)&sg_mbuf, 1, 0);
 #endif
-		}
 		DPAA2_SET_FD_OFFSET(fd, offset);
 	} else {
-		temp = rte_pktmbuf_alloc(dpaa2_tx_sg_pool);
-		if (temp == NULL) {
+		sg_mbuf = NULL;
+		if (dpaa2_tx_sg_pool)
+			sg_mbuf = rte_pktmbuf_alloc(dpaa2_tx_sg_pool);
+		if (!sg_mbuf) {
 			DPAA2_PMD_DP_DEBUG("No memory to allocate S/G table");
 			return -ENOMEM;
 		}
-		DPAA2_SET_ONLY_FD_BPID(fd, mempool_to_bpid(dpaa2_tx_sg_pool));
-		DPAA2_SET_FD_OFFSET(fd, temp->data_off);
+		if (need_conf) {
+			if (need_dyconf)
+				sg_mbuf->data_off = RTE_ALIGN(offset, 8);
+			else
+				sg_mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+			DPAA2_SET_ONLY_FD_BPID(fd, MAX_BPID);
+			DPAA2_SET_FD_IVP(fd);
+		} else {
+			DPAA2_SET_ONLY_FD_BPID(fd, mempool_to_bpid(dpaa2_tx_sg_pool));
+		}
+		DPAA2_SET_FD_OFFSET(fd, sg_mbuf->data_off);
+		offset = sg_mbuf->data_off;
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-		rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
-			(void **)&temp, 1, 0);
+		rte_mempool_check_cookies(rte_mempool_from_obj(sg_mbuf),
+			(void **)&sg_mbuf, 1, 0);
 #endif
 	}
-	DPAA2_SET_FD_ADDR(fd, DPAA2_MBUF_VADDR_TO_IOVA(temp));
+
+	/*Set Scatter gather table and Scatter gather entries*/
+	sgt = (void *)((size_t)sg_mbuf->buf_addr + offset);
+	DPAA2_SET_FD_ADDR(fd, DPAA2_MBUF_VADDR_TO_IOVA(sg_mbuf));
 	DPAA2_SET_FD_LEN(fd, mbuf->pkt_len);
 	DPAA2_FD_SET_FORMAT(fd, qbman_fd_sg);
 	DPAA2_RESET_FD_FRC(fd);
 	DPAA2_RESET_FD_CTRL(fd);
-	DPAA2_RESET_FD_FLC(fd);
-	/*Set Scatter gather table and Scatter gather entries*/
-	sgt = (struct qbman_sge *)(
-			(size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd))
-			+ DPAA2_GET_FD_OFFSET(fd));
+	if (need_conf)
+		DPAA2_SET_FD_FLC(fd, sg_mbuf);
+	else
+		DPAA2_RESET_FD_FLC(fd);
+	if (need_dyconf)
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
 
-	for (i = 0; i < mbuf->nb_segs; i++) {
-		sge = &sgt[i];
-		/*Resetting the buffer pool id and offset field*/
-		sge->fin_bpid_offset = 0;
-		DPAA2_SET_FLE_ADDR(sge, rte_pktmbuf_iova(cur_seg));
-		sge->length = cur_seg->data_len;
-		if (RTE_MBUF_DIRECT(cur_seg)) {
-			/* if we are using inline SGT in same buffers
-			 * set the FLE FMT as Frame Data Section
-			 */
-			if (temp == cur_seg) {
-				DPAA2_SG_SET_FORMAT(sge, qbman_fd_list);
-				DPAA2_SET_FLE_IVP(sge);
-			} else {
-				if (rte_mbuf_refcnt_read(cur_seg) > 1) {
-				/* If refcnt > 1, invalid bpid is set to ensure
-				 * buffer is not freed by HW
-				 */
-					DPAA2_SET_FLE_IVP(sge);
-					rte_mbuf_refcnt_update(cur_seg, -1);
-				} else {
-					DPAA2_SET_FLE_BPID(sge,
-						mempool_to_bpid(cur_seg->pool));
-#ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-				rte_mempool_check_cookies(rte_mempool_from_obj((void *)cur_seg),
-					(void **)&cur_seg, 1, 0);
-#endif
-				}
-			}
-		} else if (RTE_MBUF_HAS_EXTBUF(cur_seg)) {
-			free_buf[*free_count].seg = cur_seg;
-			free_buf[*free_count].pkt_id = pkt_id;
-			++*free_count;
-			DPAA2_SET_FLE_IVP(sge);
-		} else {
-			/* Get owner MBUF from indirect buffer */
-			mi = rte_mbuf_from_indirect(cur_seg);
-			if (rte_mbuf_refcnt_read(mi) > 1) {
-				/* If refcnt > 1, invalid bpid is set to ensure
-				 * owner buffer is not freed by HW
-				 */
-				DPAA2_SET_FLE_IVP(sge);
-			} else {
-				DPAA2_SET_FLE_BPID(sge,
-						   mempool_to_bpid(mi->pool));
-				rte_mbuf_refcnt_update(mi, 1);
-			}
-			free_buf[*free_count].seg = cur_seg;
-			free_buf[*free_count].pkt_id = pkt_id;
-			++*free_count;
-		}
-		cur_seg = cur_seg->next;
+	if (cur_seg != sg_mbuf && need_conf)
+		sg_mbuf->next = cur_seg;
+
+	if (need_conf) {
+		dpaa2_dev_tx_conf_mbuf_to_sge(sgt, cur_seg, nb_segs, sg_mbuf);
+	} else {
+		ret = dpaa2_dev_tx_no_conf_mbuf_to_sge(sgt, cur_seg, nb_segs,
+			sg_mbuf, hw_mp);
+		if (ret)
+			return ret;
 	}
-	DPAA2_SG_SET_FINAL(sge, true);
+	if (dy_conf && need_dyconf)
+		*dy_conf = true;
+
 	return 0;
 }
 
@@ -654,101 +805,54 @@ dpaa2_dev_prefetch_next_psr(const struct qbman_result *dq)
 	rte_prefetch0(&annotation->word3);
 }
 
-static void
-eth_mbuf_to_fd(struct rte_mbuf *mbuf,
-	       struct qbman_fd *fd,
-	       struct sw_buf_free *buf_to_free,
-	       uint32_t *free_count,
-	       uint32_t pkt_id,
-	       uint16_t bpid) __rte_unused;
-
-static void __rte_noinline __rte_hot
-eth_mbuf_to_fd(struct rte_mbuf *mbuf,
-	       struct qbman_fd *fd,
-	       struct sw_buf_free *buf_to_free,
-	       uint32_t *free_count,
-	       uint32_t pkt_id,
-	       uint16_t bpid)
+static int __rte_noinline __rte_hot
+dpaa2_dev_tx_mbuf_to_simple_fd(struct rte_mempool *hw_mp,
+	struct rte_mbuf *mbuf, struct qbman_fd *fd,
+	struct dpaa2_queue *txq, enum dpaa2_tx_conf_type conf,
+	uint8_t *dy_conf)
 {
-	DPAA2_MBUF_TO_CONTIG_FD(mbuf, fd, bpid);
+	int need_dyconf = false, need_conf = false;
+	struct rte_mbuf *mi;
+	struct rte_mbuf *copy_mbuf;
+	int ret = 0;
 
-	DPAA2_PMD_DP_DEBUG("mbuf =%p, mbuf->buf_addr =%p, off = %d,"
-		"fd_off=%d fd =%" PRIx64 ", meta = %d  bpid =%d, len=%d",
-		mbuf, mbuf->buf_addr, mbuf->data_off,
-		DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ADDR(fd),
-		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size,
-		DPAA2_GET_FD_BPID(fd), DPAA2_GET_FD_LEN(fd));
-	if (RTE_MBUF_DIRECT(mbuf)) {
+	if (unlikely(RTE_MBUF_CLONED(mbuf))) {
+		mi = rte_mbuf_from_indirect(mbuf);
 		if (rte_mbuf_refcnt_read(mbuf) > 1) {
-			DPAA2_SET_FD_IVP(fd);
 			rte_mbuf_refcnt_update(mbuf, -1);
+		} else {
+			rte_pktmbuf_init(mbuf->pool, NULL, mbuf, 0);
+			rte_pktmbuf_free(mbuf);
 		}
-#ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-		else
-			rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
-				(void **)&mbuf, 1, 0);
-#endif
-	} else if (RTE_MBUF_HAS_EXTBUF(mbuf)) {
-		buf_to_free[*free_count].seg = mbuf;
-		buf_to_free[*free_count].pkt_id = pkt_id;
-		++*free_count;
-		DPAA2_SET_FD_IVP(fd);
+		mbuf = mi;
+	}
+	if (conf == DPAA2_TX_DYNAMIC_CONF &&
+		(mbuf->pool->ops_index != hw_mp->ops_index ||
+		RTE_MBUF_HAS_EXTBUF(mbuf) ||
+		rte_mbuf_refcnt_read(mbuf) > 1))
+		need_dyconf = true;
+	if (conf == DPAA2_TX_ABSOLUTE_CONF || need_dyconf)
+		need_conf = true;
+
+	if (need_conf) {
+		dpaa2_mbuf_to_conf_contig_fd(mbuf, fd);
+	} else if (mbuf->pool->ops_index == hw_mp->ops_index) {
+		DPAA2_MBUF_TO_CONTIG_FD(mbuf, fd, mempool_to_bpid(mbuf->pool));
 	} else {
-		struct rte_mbuf *mi;
-
-		mi = rte_mbuf_from_indirect(mbuf);
-		if (rte_mbuf_refcnt_read(mi) > 1)
-			DPAA2_SET_FD_IVP(fd);
-		else
-			rte_mbuf_refcnt_update(mi, 1);
-
-		buf_to_free[*free_count].seg = mbuf;
-		buf_to_free[*free_count].pkt_id = pkt_id;
-		++*free_count;
+		copy_mbuf = dpaa2_dev_mbuf_copy_one_seg(mbuf, hw_mp);
+		if (!copy_mbuf)
+			return -ENOMEM;
+		DPAA2_MBUF_TO_CONTIG_FD(copy_mbuf, fd, mempool_to_bpid(hw_mp));
+		rte_pktmbuf_free(mbuf);
 	}
-}
-
-static inline int __rte_hot
-eth_copy_mbuf_to_fd(struct rte_mbuf *mbuf,
-		    struct qbman_fd *fd, uint16_t bpid)
-{
-	struct rte_mbuf *m;
-	void *mb = NULL;
 
-	if (rte_dpaa2_mbuf_alloc_bulk(
-		rte_dpaa2_bpid_info[bpid].bp_list->mp, &mb, 1)) {
-		DPAA2_PMD_DP_DEBUG("Unable to allocated DPAA2 buffer");
-		return -1;
+	if (need_dyconf) {
+		dpaa2_dev_tx_config_dynamic_confirm(fd, txq, true);
+		if (dy_conf)
+			*dy_conf = true;
 	}
-	m = (struct rte_mbuf *)mb;
-	memcpy((char *)m->buf_addr + mbuf->data_off,
-	       (void *)((char *)mbuf->buf_addr + mbuf->data_off),
-		mbuf->pkt_len);
-
-	/* Copy required fields */
-	m->data_off = mbuf->data_off;
-	m->ol_flags = mbuf->ol_flags;
-	m->packet_type = mbuf->packet_type;
-	m->tx_offload = mbuf->tx_offload;
 
-	DPAA2_MBUF_TO_CONTIG_FD(m, fd, bpid);
-
-#ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-	rte_mempool_check_cookies(rte_mempool_from_obj((void *)m),
-		(void **)&m, 1, 0);
-#endif
-	DPAA2_PMD_DP_DEBUG(
-		"mbuf: %p, BMAN buf addr: %p, fdaddr: %" PRIx64 ", bpid: %d,"
-		" meta: %d, off: %d, len: %d",
-		(void *)mbuf,
-		mbuf->buf_addr,
-		DPAA2_GET_FD_ADDR(fd),
-		DPAA2_GET_FD_BPID(fd),
-		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size,
-		DPAA2_GET_FD_OFFSET(fd),
-		DPAA2_GET_FD_LEN(fd));
-
-return 0;
+	return ret;
 }
 
 static void
@@ -832,7 +936,6 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
 			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
-
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
 		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
 			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
@@ -1253,12 +1356,6 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
 				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
-#if defined(RTE_LIBRTE_IEEE1588)
-		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
-			priv->rx_timestamp =
-				*dpaa2_timestamp_dynfield(bufs[num_rx]);
-		}
-#endif
 			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 			dq_storage++;
@@ -1289,151 +1386,204 @@ dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return dpaa2_dev_rx_common(queue, bufs, nb_pkts, true);
 }
 
-uint16_t dpaa2_dev_tx_conf(void *queue)
+static inline int
+dpaa2_dev_is_mbuf_from_spec_pool(struct rte_mempool *mp,
+	struct rte_mbuf *mbuf)
 {
-	/* Function receive frames for a given device and VQ */
-	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
-	struct qbman_result *dq_storage;
-	uint32_t fqid = dpaa2_q->fqid, num_tx_conf = 0, num_pulled;
-	int ret;
-	uint8_t pending, status;
+	while (mbuf) {
+		if (mbuf->pool != mp)
+			return false;
+		mbuf = mbuf->next;
+	}
+
+	return true;
+}
+
+uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
+{
+	/* Function receive frames for a given device and VQ*/
+	struct dpaa2_queue *dpaa2_txq = txq;
+	struct dpaa2_queue *dpaa2_q = dpaa2_txq->tx_conf_queue;
+	struct qbman_result *dq_storage, *dq_storage1 = NULL;
+	uint32_t fqid = dpaa2_q->fqid;
+	int ret, pull_size, total = 0, bulk_free;
+	uint8_t pending, status, idx, buf_idx;
 	struct qbman_swp *swp;
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
-	struct qbman_release_desc releasedesc;
-	uint32_t bpid;
-	uint64_t buf;
-#if defined(RTE_LIBRTE_IEEE1588)
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
-	struct dpaa2_annot_hdr *annotation;
-	void *v_addr;
-	struct rte_mbuf *mbuf;
-#endif
+	struct queue_storage_info_t *q_storage;
+	struct qbman_result *rst;
 
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		ret = dpaa2_affine_qbman_swp();
+	struct rte_mbuf *mbufs[dpaa2_dqrr_size];
+	struct rte_mempool *mp = NULL;
+	#define swp_idx (DPAA2_PER_LCORE_ETHRX_DPIO->index)
+
+conf_again:
+	bulk_free = true;
+	idx = 0;
+	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
+	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+		ret = dpaa2_affine_qbman_ethrx_swp();
 		if (ret) {
-			DPAA2_PMD_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
+			DPAA2_PMD_ERR("Failure in affining portal");
 			return 0;
 		}
 	}
-	swp = DPAA2_PER_LCORE_PORTAL;
 
-	do {
-		dq_storage = dpaa2_q->q_storage[0]->dq_storage[0];
+	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	pull_size = dpaa2_dqrr_size;
+	if (unlikely(!q_storage->active_dqs)) {
+		q_storage->toggle = 0;
+		dq_storage = q_storage->dq_storage[q_storage->toggle];
+		q_storage->last_num_pkts = pull_size;
 		qbman_pull_desc_clear(&pulldesc);
+		qbman_pull_desc_set_numframes(&pulldesc,
+			q_storage->last_num_pkts);
 		qbman_pull_desc_set_fq(&pulldesc, fqid);
 		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
-				(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
-
-		qbman_pull_desc_set_numframes(&pulldesc, dpaa2_dqrr_size);
-
+			DPAA2_VADDR_TO_IOVA(dq_storage), 1);
+		if (check_swp_active_dqs(swp_idx)) {
+			rst = get_swp_active_dqs(swp_idx);
+			while (!qbman_check_command_complete(rst))
+				;
+			clear_swp_active_dqs(swp_idx);
+		}
 		while (1) {
 			if (qbman_swp_pull(swp, &pulldesc)) {
-				DPAA2_PMD_DP_DEBUG("VDQ command is not issued."
-						   "QBMAN is busy");
+				DPAA2_PMD_DP_DEBUG("QBMAN is busy (1)");
 				/* Portal was busy, try again */
 				continue;
 			}
 			break;
 		}
+		q_storage->active_dqs = dq_storage;
+		q_storage->active_dpio_id = swp_idx;
+		set_swp_active_dqs(swp_idx, dq_storage);
+	}
 
-		rte_prefetch0((void *)((size_t)(dq_storage + 1)));
-		/* Check if the previous issued command is completed. */
-		while (!qbman_check_command_complete(dq_storage))
-			;
+	dq_storage = q_storage->active_dqs;
+	rte_prefetch0((void *)(dq_storage));
+	rte_prefetch0((void *)(dq_storage + 1));
 
-		num_pulled = 0;
-		pending = 1;
-		do {
-			/* Loop until the dq_storage is updated with
-			 * new token by QBMAN
-			 */
-			while (!qbman_check_new_result(dq_storage))
-				;
-			rte_prefetch0((void *)((size_t)(dq_storage + 2)));
-			/* Check whether Last Pull command is Expired and
-			 * setting Condition for Loop termination
-			 */
-			if (qbman_result_DQ_is_pull_complete(dq_storage)) {
-				pending = 0;
-				/* Check for valid frame. */
-				status = qbman_result_DQ_flags(dq_storage);
-				if (unlikely((status &
-					QBMAN_DQ_STAT_VALIDFRAME) == 0))
-					continue;
-			}
-			if (dpaa2_svr_family != SVR_LX2160A)
-				/** Packet type is parsed from FRC for LX2160A.*/
-				dpaa2_dev_prefetch_next_psr(dq_storage);
+	/* Prepare next pull descriptor. This will give space for the
+	 * prefetching done on DQRR entries
+	 */
+	q_storage->toggle ^= 1;
+	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
+	qbman_pull_desc_clear(&pulldesc);
+	qbman_pull_desc_set_numframes(&pulldesc, pull_size);
+	qbman_pull_desc_set_fq(&pulldesc, fqid);
+	qbman_pull_desc_set_storage(&pulldesc, dq_storage1,
+		DPAA2_VADDR_TO_IOVA(dq_storage1), 1);
 
-			fd = qbman_result_DQ_fd(dq_storage);
-			bpid = DPAA2_GET_FD_BPID(fd);
+	/* Check if the previous issued command is completed.
+	 * Also seems like the SWP is shared between the Ethernet Driver
+	 * and the SEC driver.
+	 */
+	while (!qbman_check_command_complete(dq_storage))
+		;
+	if (dq_storage == get_swp_active_dqs(q_storage->active_dpio_id))
+		clear_swp_active_dqs(q_storage->active_dpio_id);
 
-			/* Create a release descriptor required for releasing
-			 * buffers into QBMAN
-			 */
-			qbman_release_desc_clear(&releasedesc);
-			qbman_release_desc_set_bpid(&releasedesc, bpid);
+	pending = 1;
 
-			buf = DPAA2_GET_FD_ADDR(fd);
-			/* feed them to bman */
-			do {
-				ret = qbman_swp_release(swp, &releasedesc,
-							&buf, 1);
-			} while (ret == -EBUSY);
+	do {
+		/* Loop until the dq_storage is updated with
+		 * new token by QBMAN
+		 */
+		while (!qbman_check_new_result(dq_storage))
+			;
+		rte_prefetch0((void *)(dq_storage + 2));
+		/* Check whether Last Pull command is Expired and
+		 * setting Condition for Loop termination
+		 */
+		if (qbman_result_DQ_is_pull_complete(dq_storage)) {
+			pending = 0;
+			/* Check for valid frame. */
+			status = qbman_result_DQ_flags(dq_storage);
+			if (unlikely((status & QBMAN_DQ_STAT_VALIDFRAME) == 0))
+				continue;
+		}
 
-			dq_storage++;
-			num_tx_conf++;
-			num_pulled++;
-#if defined(RTE_LIBRTE_IEEE1588)
-			v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
-			mbuf = DPAA2_INLINE_MBUF_FROM_BUF(v_addr,
-				rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
-
-			if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
-				annotation = (struct dpaa2_annot_hdr *)((size_t)
-					DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd)) +
-					DPAA2_FD_PTA_SIZE);
-				priv->tx_timestamp = annotation->word2;
-			}
-#endif
-		} while (pending);
+		fd = qbman_result_DQ_fd(dq_storage);
+		mbufs[idx] = (void *)DPAA2_GET_FD_FLC(fd);
+		if (unlikely(!mp))
+			mp = mbufs[idx]->pool;
+		if (unlikely(rte_mbuf_refcnt_read(mbufs[idx]) > 1))
+			bulk_free = false;
+		if (bulk_free &&
+			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
+			bulk_free = false;
+		idx++;
+		dq_storage++;
+		if (idx >= dpaa2_dqrr_size)
+			break;
+	} while (pending);
 
-	/* Last VDQ provided all packets and more packets are requested */
-	} while (num_pulled == dpaa2_dqrr_size);
+	if (check_swp_active_dqs(swp_idx)) {
+		rst = get_swp_active_dqs(swp_idx);
+		while (!qbman_check_command_complete(rst))
+			;
+		clear_swp_active_dqs(swp_idx);
+	}
+	/* issue a volatile dequeue command for next pull */
+	while (1) {
+		if (qbman_swp_pull(swp, &pulldesc)) {
+			DPAA2_PMD_DP_DEBUG("QBMAN is busy (2)");
+			continue;
+		}
+		break;
+	}
+	q_storage->active_dqs = dq_storage1;
+	q_storage->active_dpio_id = swp_idx;
+	set_swp_active_dqs(swp_idx, dq_storage1);
 
-	dpaa2_q->rx_pkts += num_tx_conf;
+	if (bulk_free) {
+		rte_pktmbuf_free_bulk(mbufs, idx);
+	} else {
+		for (buf_idx = 0; buf_idx < idx; buf_idx++)
+			rte_pktmbuf_free(mbufs[buf_idx]);
+	}
+
+	dpaa2_q->rx_pkts += idx;
+	total += idx;
+	if (drain && pending)
+		goto conf_again;
 
-	return num_tx_conf;
+	return total;
 }
 
-#ifdef RTE_LIBRTE_IEEE1588
-/* Configure the egress frame annotation for timestamp update */
-static void enable_tx_tstamp(struct qbman_fd *fd)
+static inline int
+dpaa2_dev_tx_fast_mbuf_to_fd(struct rte_eth_dev_data *dev,
+	struct rte_mbuf *buf, struct qbman_fd *fd,
+	enum dpaa2_tx_conf_type conf)
 {
-	struct dpaa2_faead *fd_faead;
-
-	/* Set frame annotation status field as valid */
-	(fd)->simple.frc |= DPAA2_FD_FRC_FASV;
-
-	/* Set frame annotation egress action descriptor as valid */
-	(fd)->simple.frc |= DPAA2_FD_FRC_FAEADV;
-
-	/* Set Annotation Length as 128B */
-	(fd)->simple.ctrl |= DPAA2_FD_CTRL_ASAL;
+	struct rte_mempool *mp = buf->pool;
+	struct dpaa2_dev_priv *priv = dev->dev_private;
+
+	if (likely(RTE_MBUF_DIRECT(buf) &&
+		mp && mp->ops_index ==
+		priv->bp_list->dpaa2_ops_index &&
+		buf->nb_segs == 1 &&
+		rte_mbuf_refcnt_read(buf) == 1)) {
+		if (unlikely(buf->next)) {
+			DPAA2_PMD_WARN("Single mbuf has next segment(%p)",
+				buf->next);
+		}
+		if (unlikely(conf == DPAA2_TX_ABSOLUTE_CONF))
+			dpaa2_mbuf_to_conf_contig_fd(buf, fd);
+		else
+			DPAA2_MBUF_TO_CONTIG_FD(buf, fd, mempool_to_bpid(mp));
+#ifdef RTE_LIBRTE_MEMPOOL_DEBUG
+		rte_mempool_check_cookies(rte_mempool_from_obj(buf),
+			(void **)&buf, 1, 0);
+#endif
+		return 0;
+	}
 
-	/* enable update of confirmation frame annotation */
-	fd_faead = (struct dpaa2_faead *)((size_t)
-			DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd)) +
-			DPAA2_FD_PTA_SIZE + DPAA2_FD_HW_ANNOT_FAEAD_OFFSET);
-	fd_faead->ctrl = DPAA2_ANNOT_FAEAD_A2V | DPAA2_ANNOT_FAEAD_UPDV |
-				DPAA2_ANNOT_FAEAD_UPD;
+	return -EAGAIN;
 }
-#endif
+
 /*
  * Callback to handle sending packets through WRIOP based interface
  */
@@ -1441,28 +1591,24 @@ uint16_t
 dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to given device and VQ*/
-	uint32_t loop, retry_count;
+	uint32_t loop, retry_count, i;
 	int32_t ret;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	struct rte_mbuf *mi;
 	uint32_t frames_to_send;
-	struct rte_mempool *mp;
 	struct qbman_eq_desc eqdesc;
-	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
+	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_swp *swp;
 	uint16_t num_tx = 0;
-	uint16_t bpid;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+	struct rte_mempool *hw_mp;
 	uint32_t flags[MAX_TX_RING_SLOTS] = {0};
-	struct sw_buf_free buf_to_free[DPAA2_MAX_SGS * dpaa2_dqrr_size];
-	uint32_t free_count = 0;
+	uint8_t dy_conf[MAX_TX_RING_SLOTS];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
 		if (ret) {
-			DPAA2_PMD_ERR(
-				"Failed to allocate IO portal, tid: %d",
+			DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d",
 				rte_gettid());
 			return 0;
 		}
@@ -1470,19 +1616,17 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	swp = DPAA2_PER_LCORE_PORTAL;
 
 	DPAA2_PMD_DP_DEBUG("===> eth_data =%p, fqid =%d",
-			eth_data, dpaa2_q->fqid);
+		eth_data, dpaa2_q->fqid);
 
-#ifdef RTE_LIBRTE_IEEE1588
-	/* IEEE1588 driver need pointer to tx confirmation queue
-	 * corresponding to last packet transmitted for reading
-	 * the timestamp
-	 */
-	if ((*bufs)->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
-		priv->next_tx_conf_queue = dpaa2_q->tx_conf_queue;
-		dpaa2_dev_tx_conf(dpaa2_q->tx_conf_queue);
-		priv->tx_timestamp = 0;
+	if (unlikely(!priv->bp_list)) {
+		DPAA2_PMD_ERR("%s's buffer pool not initialized!",
+			eth_data->name);
+		return 0;
 	}
-#endif
+	hw_mp = priv->bp_list->mp;
+
+	if (dpaa2_q->tx_conf_queue)
+		dpaa2_dev_tx_conf(dpaa2_q, false);
 
 	/*Prepare enqueue descriptor*/
 	qbman_eq_desc_clear(&eqdesc);
@@ -1490,214 +1634,104 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	qbman_eq_desc_set_fq(&eqdesc, dpaa2_q->fqid);
 
 	/*Clear the unused FD fields before sending*/
-	while (nb_pkts) {
-		/*Check if the queue is congested*/
-		retry_count = 0;
-		while (qbman_result_SCN_state(dpaa2_q->cscn)) {
-			retry_count++;
-			/* Retry for some time before giving up */
-			if (retry_count > CONG_RETRY_COUNT) {
-				if (dpaa2_q->tm_sw_td)
-					goto sw_td;
-				goto skip_tx;
-			}
-		}
-
-		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
-			dpaa2_eqcr_size : nb_pkts;
 
-		for (loop = 0; loop < frames_to_send; loop++) {
-			if (*dpaa2_seqn(*bufs)) {
-				uint8_t dqrr_index = *dpaa2_seqn(*bufs) - 1;
-
-				flags[loop] = QBMAN_ENQUEUE_FLAG_DCA |
-						dqrr_index;
-				DPAA2_PER_LCORE_DQRR_SIZE--;
-				DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
-				*dpaa2_seqn(*bufs) = DPAA2_INVALID_MBUF_SEQN;
-			}
+tx_again:
+	/*Check if the queue is congested*/
+	retry_count = 0;
+	while (qbman_result_SCN_state(dpaa2_q->cscn)) {
+		retry_count++;
+		/* Retry for some time before giving up */
+		if (retry_count > CONG_RETRY_COUNT)
+			goto skip_tx;
+	}
 
-			if (likely(RTE_MBUF_DIRECT(*bufs))) {
-				mp = (*bufs)->pool;
-				/* Check the basic scenario and set
-				 * the FD appropriately here itself.
-				 */
-				if (likely(mp && mp->ops_index ==
-				    priv->bp_list->dpaa2_ops_index &&
-				    (*bufs)->nb_segs == 1 &&
-				    rte_mbuf_refcnt_read((*bufs)) == 1)) {
-					if (unlikely((*bufs)->ol_flags
-						& RTE_MBUF_F_TX_VLAN)) {
-						ret = rte_vlan_insert(bufs);
-						if (ret)
-							goto send_n_return;
-					}
-					DPAA2_MBUF_TO_CONTIG_FD((*bufs),
-					&fd_arr[loop], mempool_to_bpid(mp));
-#ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-					rte_mempool_check_cookies
-						(rte_mempool_from_obj((void *)*bufs),
-						(void **)bufs, 1, 0);
-#endif
-					bufs++;
-#ifdef RTE_LIBRTE_IEEE1588
-					enable_tx_tstamp(&fd_arr[loop]);
-#endif
-					continue;
-				}
-			} else {
-				mi = rte_mbuf_from_indirect(*bufs);
-				mp = mi->pool;
-			}
+	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
+		dpaa2_eqcr_size : nb_pkts;
 
-			if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs))) {
-				if (unlikely((*bufs)->nb_segs > 1)) {
-					mp = (*bufs)->pool;
-					if (eth_mbuf_to_sg_fd(*bufs,
-							      &fd_arr[loop],
-							      buf_to_free,
-							      &free_count,
-							      loop,
-							      mempool_to_bpid(mp)))
-						goto send_n_return;
-				} else {
-					eth_mbuf_to_fd(*bufs,
-							&fd_arr[loop],
-							buf_to_free,
-							&free_count,
-							loop, 0);
-				}
-				bufs++;
-#ifdef RTE_LIBRTE_IEEE1588
-				enable_tx_tstamp(&fd_arr[loop]);
-#endif
-				continue;
-			}
+	for (loop = 0; loop < frames_to_send; loop++) {
+		dy_conf[loop] = false;
+		if (*dpaa2_seqn(*bufs)) {
+			uint8_t dqrr_index = *dpaa2_seqn(*bufs) - 1;
+
+			flags[loop] = QBMAN_ENQUEUE_FLAG_DCA | dqrr_index;
+			DPAA2_PER_LCORE_DQRR_SIZE--;
+			DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
+			*dpaa2_seqn(*bufs) = DPAA2_INVALID_MBUF_SEQN;
+		}
 
-			/* Not a hw_pkt pool allocated frame */
-			if (unlikely(!mp || !priv->bp_list)) {
-				DPAA2_PMD_ERR("Err: No buffer pool attached");
+		if (unlikely((*bufs)->ol_flags
+		 & RTE_MBUF_F_TX_VLAN)) {
+			ret = rte_vlan_insert(bufs);
+			if (ret)
 				goto send_n_return;
-			}
+		}
 
-			if (unlikely((*bufs)->ol_flags & RTE_MBUF_F_TX_VLAN)) {
-				int ret = rte_vlan_insert(bufs);
-				if (ret)
-					goto send_n_return;
-			}
-			if (mp->ops_index != priv->bp_list->dpaa2_ops_index) {
-				DPAA2_PMD_WARN("Non DPAA2 buffer pool");
-				/* alloc should be from the default buffer pool
-				 * attached to this interface
-				 */
-				bpid = priv->bp_list->buf_pool.bpid;
-
-				if (unlikely((*bufs)->nb_segs > 1)) {
-					DPAA2_PMD_ERR("S/G support not added"
-						" for non hw offload buffer");
-					goto send_n_return;
-				}
-				if (eth_copy_mbuf_to_fd(*bufs,
-							&fd_arr[loop], bpid)) {
-					goto send_n_return;
-				}
-				/* free the original packet */
-				rte_pktmbuf_free(*bufs);
-			} else {
-				bpid = mempool_to_bpid(mp);
-				if (unlikely((*bufs)->nb_segs > 1)) {
-					if (eth_mbuf_to_sg_fd(*bufs,
-							&fd_arr[loop],
-							buf_to_free,
-							&free_count,
-							loop,
-							bpid))
-						goto send_n_return;
-				} else {
-					eth_mbuf_to_fd(*bufs,
-							&fd_arr[loop],
-							buf_to_free,
-							&free_count,
-							loop, bpid);
-				}
-			}
-#ifdef RTE_LIBRTE_IEEE1588
-			enable_tx_tstamp(&fd_arr[loop]);
-#endif
+		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
+			*bufs, &fd_arr[loop], priv->tx_conf_type);
+		if (likely(!ret)) {
 			bufs++;
+			continue;
 		}
 
-		loop = 0;
-		retry_count = 0;
-		while (loop < frames_to_send) {
-			ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
-					&fd_arr[loop], &flags[loop],
-					frames_to_send - loop);
-			if (unlikely(ret < 0)) {
-				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-					num_tx += loop;
-					nb_pkts -= loop;
-					goto send_n_return;
-				}
-			} else {
-				loop += ret;
-				retry_count = 0;
-			}
+		if (unlikely((*bufs)->nb_segs > 1)) {
+			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
+		} else {
+			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q, priv->tx_conf_type, &dy_conf[loop]);
 		}
-
-		num_tx += loop;
-		nb_pkts -= loop;
+		if (ret)
+			goto send_n_return;
+		bufs++;
 	}
-	dpaa2_q->tx_pkts += num_tx;
 
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
+	loop = 0;
+	retry_count = 0;
+	while (loop < frames_to_send) {
+		ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
+				&fd_arr[loop], &flags[loop],
+				frames_to_send - loop);
+		if (unlikely(ret < 0)) {
+			retry_count++;
+			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
+				num_tx += loop;
+				nb_pkts -= loop;
+				goto send_n_return;
+			}
+		} else {
+			loop += ret;
+			retry_count = 0;
+		}
 	}
 
+	num_tx += loop;
+	nb_pkts -= loop;
+	if (nb_pkts > 0)
+		goto tx_again;
+
+	dpaa2_q->tx_pkts += num_tx;
+
 	return num_tx;
 
 send_n_return:
 	/* send any already prepared fd */
-	if (loop) {
-		unsigned int i = 0;
-
-		retry_count = 0;
-		while (i < loop) {
-			ret = qbman_swp_enqueue_multiple(swp, &eqdesc,
-							 &fd_arr[i],
-							 &flags[i],
-							 loop - i);
-			if (unlikely(ret < 0)) {
-				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
-					break;
-			} else {
-				i += ret;
-				retry_count = 0;
-			}
+	retry_count = 0;
+	i = 0;
+	while (i < loop) {
+		ret = qbman_swp_enqueue_multiple(swp, &eqdesc, &fd_arr[i],
+			&flags[i], loop - i);
+		if (unlikely(ret < 0)) {
+			retry_count++;
+			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
+				break;
+		} else {
+			i += ret;
+			retry_count = 0;
 		}
-		num_tx += i;
-	}
-skip_tx:
-	dpaa2_q->tx_pkts += num_tx;
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
-	}
-
-	return num_tx;
-sw_td:
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
 	}
+	num_tx += i;
 
-	/* free the pending buffers */
-	rte_pktmbuf_free_bulk(bufs, nb_pkts);
-
-	num_tx += nb_pkts;
+skip_tx:
 	dpaa2_q->tx_pkts += num_tx;
 
 	return num_tx;
@@ -1772,149 +1806,108 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered)
 uint16_t
 dpaa2_dev_tx_multi_txq_ordered(void **queue,
-		struct rte_mbuf **bufs, uint16_t nb_pkts)
+	struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	/* Function to transmit the frames to multiple queues respectively.*/
-	uint32_t loop, i, retry_count;
-	int32_t ret;
+	uint32_t loop, retry_count, sent = 0;
+	int32_t ret = 0;
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	uint32_t frames_to_send, num_free_eq_desc = 0;
-	struct rte_mempool *mp;
+	struct rte_mempool *hw_mp;
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	struct dpaa2_queue *dpaa2_q[MAX_TX_RING_SLOTS];
 	struct qbman_swp *swp;
-	uint16_t bpid;
-	struct rte_mbuf *mi;
 	struct rte_eth_dev_data *eth_data;
 	struct dpaa2_dev_priv *priv;
 	struct dpaa2_queue *order_sendq;
-	struct sw_buf_free buf_to_free[DPAA2_MAX_SGS * dpaa2_dqrr_size];
-	uint32_t free_count = 0;
+	uint8_t dy_conf[MAX_TX_RING_SLOTS];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
 		if (ret) {
-			DPAA2_PMD_ERR(
-				"Failed to allocate IO portal, tid: %d",
+			DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d",
 				rte_gettid());
 			return 0;
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
 
+tx_again:
 	frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
 		dpaa2_eqcr_size : nb_pkts;
 
 	for (loop = 0; loop < frames_to_send; loop++) {
-		dpaa2_q[loop] = (struct dpaa2_queue *)queue[loop];
+		dpaa2_q[loop] = queue[loop];
+		if (dpaa2_q[loop]->tx_conf_queue)
+			dpaa2_dev_tx_conf(dpaa2_q[loop], false);
 		eth_data = dpaa2_q[loop]->eth_data;
 		priv = eth_data->dev_private;
-		if (!priv->en_loose_ordered) {
-			if (*dpaa2_seqn(*bufs) & DPAA2_ENQUEUE_FLAG_ORP) {
+		dy_conf[loop] = false;
+		if (unlikely(!priv->bp_list)) {
+			DPAA2_PMD_ERR("%s's buffer pool not initialized!",
+				eth_data->name);
+			ret = -ENOMEM;
+			goto send_frames;
+		}
+		hw_mp = priv->bp_list->mp;
+		if (!priv->en_loose_ordered &&
+			(*dpaa2_seqn(*bufs) & DPAA2_ENQUEUE_FLAG_ORP)) {
+			if (!num_free_eq_desc) {
+				num_free_eq_desc = dpaa2_free_eq_descriptors();
 				if (!num_free_eq_desc) {
-					num_free_eq_desc = dpaa2_free_eq_descriptors();
-					if (!num_free_eq_desc)
-						goto send_frames;
+					ret = -EIO;
+					goto send_frames;
 				}
-				num_free_eq_desc--;
 			}
+			num_free_eq_desc--;
 		}
 
 		DPAA2_PMD_DP_DEBUG("===> eth_data =%p, fqid =%d",
-				   eth_data, dpaa2_q[loop]->fqid);
+			eth_data, dpaa2_q[loop]->fqid);
 
 		/* Check if the queue is congested */
 		retry_count = 0;
 		while (qbman_result_SCN_state(dpaa2_q[loop]->cscn)) {
 			retry_count++;
 			/* Retry for some time before giving up */
-			if (retry_count > CONG_RETRY_COUNT)
+			if (retry_count > CONG_RETRY_COUNT) {
+				ret = -ETIME;
 				goto send_frames;
+			}
 		}
 
 		/* Prepare enqueue descriptor */
 		qbman_eq_desc_clear(&eqdesc[loop]);
 
 		if (*dpaa2_seqn(*bufs) && priv->en_ordered) {
-			order_sendq = (struct dpaa2_queue *)priv->tx_vq[0];
-			dpaa2_set_enqueue_descriptor(order_sendq,
-						     (*bufs),
-						     &eqdesc[loop]);
+			order_sendq = priv->tx_vq[0];
+			dpaa2_set_enqueue_descriptor(order_sendq, *bufs,
+				&eqdesc[loop]);
 		} else {
-			qbman_eq_desc_set_no_orp(&eqdesc[loop],
-							 DPAA2_EQ_RESP_ERR_FQ);
-			qbman_eq_desc_set_fq(&eqdesc[loop],
-						     dpaa2_q[loop]->fqid);
+			qbman_eq_desc_set_no_orp(&eqdesc[loop], DPAA2_EQ_RESP_ERR_FQ);
+			qbman_eq_desc_set_fq(&eqdesc[loop], dpaa2_q[loop]->fqid);
 		}
 
-		if (likely(RTE_MBUF_DIRECT(*bufs))) {
-			mp = (*bufs)->pool;
-			/* Check the basic scenario and set
-			 * the FD appropriately here itself.
-			 */
-			if (likely(mp && mp->ops_index ==
-				priv->bp_list->dpaa2_ops_index &&
-				(*bufs)->nb_segs == 1 &&
-				rte_mbuf_refcnt_read((*bufs)) == 1)) {
-				if (unlikely((*bufs)->ol_flags
-					& RTE_MBUF_F_TX_VLAN)) {
-					ret = rte_vlan_insert(bufs);
-					if (ret)
-						goto send_frames;
-				}
-				DPAA2_MBUF_TO_CONTIG_FD((*bufs),
-					&fd_arr[loop],
-					mempool_to_bpid(mp));
-				bufs++;
-				continue;
-			}
-		} else {
-			mi = rte_mbuf_from_indirect(*bufs);
-			mp = mi->pool;
-		}
-		/* Not a hw_pkt pool allocated frame */
-		if (unlikely(!mp || !priv->bp_list)) {
-			DPAA2_PMD_ERR("Err: No buffer pool attached");
-			goto send_frames;
+		ret = dpaa2_dev_tx_fast_mbuf_to_fd(eth_data,
+				*bufs, &fd_arr[loop], priv->tx_conf_type);
+		if (likely(!ret)) {
+			if (priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF)
+				dy_conf[loop] = true;
+			bufs++;
+			continue;
 		}
 
-		if (mp->ops_index != priv->bp_list->dpaa2_ops_index) {
-			DPAA2_PMD_WARN("Non DPAA2 buffer pool");
-			/* alloc should be from the default buffer pool
-			 * attached to this interface
-			 */
-			bpid = priv->bp_list->buf_pool.bpid;
-
-			if (unlikely((*bufs)->nb_segs > 1)) {
-				DPAA2_PMD_ERR(
-					"S/G not supp for non hw offload buffer");
-				goto send_frames;
-			}
-			if (eth_copy_mbuf_to_fd(*bufs,
-						&fd_arr[loop], bpid)) {
-				goto send_frames;
-			}
-			/* free the original packet */
-			rte_pktmbuf_free(*bufs);
+		if (unlikely((*bufs)->nb_segs > 1)) {
+			ret = dpaa2_dev_tx_mbuf_to_sg_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
 		} else {
-			bpid = mempool_to_bpid(mp);
-			if (unlikely((*bufs)->nb_segs > 1)) {
-				if (eth_mbuf_to_sg_fd(*bufs,
-						      &fd_arr[loop],
-						      buf_to_free,
-						      &free_count,
-						      loop,
-						      bpid))
-					goto send_frames;
-			} else {
-				eth_mbuf_to_fd(*bufs,
-						&fd_arr[loop],
-						buf_to_free,
-						&free_count,
-						loop, bpid);
-			}
+			ret = dpaa2_dev_tx_mbuf_to_simple_fd(hw_mp, *bufs, &fd_arr[loop],
+				dpaa2_q[loop], priv->tx_conf_type, &dy_conf[loop]);
 		}
-
+		if (ret)
+			goto send_frames;
+		if (priv->tx_conf_type == DPAA2_TX_ABSOLUTE_CONF)
+			dy_conf[loop] = true;
 		bufs++;
 	}
 
@@ -1935,237 +1928,26 @@ dpaa2_dev_tx_multi_txq_ordered(void **queue,
 				break;
 		}
 	}
+	nb_pkts -= loop;
+	sent += loop;
+	if (nb_pkts > 0 && !ret)
+		goto tx_again;
 
-	for (i = 0; i < free_count; i++) {
-		if (buf_to_free[i].pkt_id < loop)
-			rte_pktmbuf_free_seg(buf_to_free[i].seg);
-	}
-	return loop;
+	return sent;
 }
 
 /* Callback to handle sending ordered packets through WRIOP based interface */
 uint16_t
-dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs,
+	uint16_t nb_pkts)
 {
-	/* Function to transmit the frames to given device and VQ*/
-	struct dpaa2_queue *dpaa2_q = (struct dpaa2_queue *)queue;
-	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
-	struct dpaa2_queue *order_sendq = (struct dpaa2_queue *)priv->tx_vq[0];
-	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
-	struct rte_mbuf *mi;
-	struct rte_mempool *mp;
-	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
-	struct qbman_swp *swp;
-	uint32_t frames_to_send, num_free_eq_desc;
-	uint32_t loop, retry_count;
-	int32_t ret;
-	uint16_t num_tx = 0;
-	uint16_t bpid;
-	struct sw_buf_free buf_to_free[DPAA2_MAX_SGS * dpaa2_dqrr_size];
-	uint32_t free_count = 0;
-
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		ret = dpaa2_affine_qbman_swp();
-		if (ret) {
-			DPAA2_PMD_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
-			return 0;
-		}
-	}
-	swp = DPAA2_PER_LCORE_PORTAL;
-
-	DPAA2_PMD_DP_DEBUG("===> eth_data =%p, fqid =%d",
-			   eth_data, dpaa2_q->fqid);
-
-	/* This would also handle normal and atomic queues as any type
-	 * of packet can be enqueued when ordered queues are being used.
-	 */
-	while (nb_pkts) {
-		/*Check if the queue is congested*/
-		retry_count = 0;
-		while (qbman_result_SCN_state(dpaa2_q->cscn)) {
-			retry_count++;
-			/* Retry for some time before giving up */
-			if (retry_count > CONG_RETRY_COUNT) {
-				if (dpaa2_q->tm_sw_td)
-					goto sw_td;
-				goto skip_tx;
-			}
-		}
-
-		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
-			dpaa2_eqcr_size : nb_pkts;
-
-		if (!priv->en_loose_ordered) {
-			if (*dpaa2_seqn(*bufs) & DPAA2_ENQUEUE_FLAG_ORP) {
-				num_free_eq_desc = dpaa2_free_eq_descriptors();
-				if (num_free_eq_desc < frames_to_send)
-					frames_to_send = num_free_eq_desc;
-			}
-		}
-
-		for (loop = 0; loop < frames_to_send; loop++) {
-			/*Prepare enqueue descriptor*/
-			qbman_eq_desc_clear(&eqdesc[loop]);
-
-			if (*dpaa2_seqn(*bufs)) {
-				/* Use only queue 0 for Tx in case of atomic/
-				 * ordered packets as packets can get unordered
-				 * when being transmitted out from the interface
-				 */
-				dpaa2_set_enqueue_descriptor(order_sendq,
-							     (*bufs),
-							     &eqdesc[loop]);
-			} else {
-				qbman_eq_desc_set_no_orp(&eqdesc[loop],
-							 DPAA2_EQ_RESP_ERR_FQ);
-				qbman_eq_desc_set_fq(&eqdesc[loop],
-						     dpaa2_q->fqid);
-			}
-
-			if (likely(RTE_MBUF_DIRECT(*bufs))) {
-				mp = (*bufs)->pool;
-				/* Check the basic scenario and set
-				 * the FD appropriately here itself.
-				 */
-				if (likely(mp && mp->ops_index ==
-				    priv->bp_list->dpaa2_ops_index &&
-				    (*bufs)->nb_segs == 1 &&
-				    rte_mbuf_refcnt_read((*bufs)) == 1)) {
-					if (unlikely((*bufs)->ol_flags
-						& RTE_MBUF_F_TX_VLAN)) {
-					  ret = rte_vlan_insert(bufs);
-					  if (ret)
-						goto send_n_return;
-					}
-					DPAA2_MBUF_TO_CONTIG_FD((*bufs),
-						&fd_arr[loop],
-						mempool_to_bpid(mp));
-					bufs++;
-					continue;
-				}
-			} else {
-				mi = rte_mbuf_from_indirect(*bufs);
-				mp = mi->pool;
-			}
-			/* Not a hw_pkt pool allocated frame */
-			if (unlikely(!mp || !priv->bp_list)) {
-				DPAA2_PMD_ERR("Err: No buffer pool attached");
-				goto send_n_return;
-			}
+	uint16_t i;
+	void *mq[nb_pkts];
 
-			if (mp->ops_index != priv->bp_list->dpaa2_ops_index) {
-				DPAA2_PMD_WARN("Non DPAA2 buffer pool");
-				/* alloc should be from the default buffer pool
-				 * attached to this interface
-				 */
-				bpid = priv->bp_list->buf_pool.bpid;
-
-				if (unlikely((*bufs)->nb_segs > 1)) {
-					DPAA2_PMD_ERR(
-						"S/G not supp for non hw offload buffer");
-					goto send_n_return;
-				}
-				if (eth_copy_mbuf_to_fd(*bufs,
-							&fd_arr[loop], bpid)) {
-					goto send_n_return;
-				}
-				/* free the original packet */
-				rte_pktmbuf_free(*bufs);
-			} else {
-				bpid = mempool_to_bpid(mp);
-				if (unlikely((*bufs)->nb_segs > 1)) {
-					if (eth_mbuf_to_sg_fd(*bufs,
-							      &fd_arr[loop],
-							      buf_to_free,
-							      &free_count,
-							      loop,
-							      bpid))
-						goto send_n_return;
-				} else {
-					eth_mbuf_to_fd(*bufs,
-							&fd_arr[loop],
-							buf_to_free,
-							&free_count,
-							loop, bpid);
-				}
-			}
-			bufs++;
-		}
+	for (i = 0; i < nb_pkts; i++)
+		mq[i] = queue;
 
-		loop = 0;
-		retry_count = 0;
-		while (loop < frames_to_send) {
-			ret = qbman_swp_enqueue_multiple_desc(swp,
-					&eqdesc[loop], &fd_arr[loop],
-					frames_to_send - loop);
-			if (unlikely(ret < 0)) {
-				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-					num_tx += loop;
-					nb_pkts -= loop;
-					goto send_n_return;
-				}
-			} else {
-				loop += ret;
-				retry_count = 0;
-			}
-		}
-
-		num_tx += loop;
-		nb_pkts -= loop;
-	}
-	dpaa2_q->tx_pkts += num_tx;
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
-	}
-
-	return num_tx;
-
-send_n_return:
-	/* send any already prepared fd */
-	if (loop) {
-		unsigned int i = 0;
-
-		retry_count = 0;
-		while (i < loop) {
-			ret = qbman_swp_enqueue_multiple_desc(swp,
-				       &eqdesc[i], &fd_arr[i], loop - i);
-			if (unlikely(ret < 0)) {
-				retry_count++;
-				if (retry_count > DPAA2_MAX_TX_RETRY_COUNT)
-					break;
-			} else {
-				i += ret;
-				retry_count = 0;
-			}
-		}
-		num_tx += i;
-	}
-skip_tx:
-	dpaa2_q->tx_pkts += num_tx;
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
-	}
-
-	return num_tx;
-sw_td:
-	for (loop = 0; loop < free_count; loop++) {
-		if (buf_to_free[loop].pkt_id < num_tx)
-			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
-	}
-
-	/* free the pending buffers */
-	rte_pktmbuf_free_bulk(bufs, nb_pkts);
-
-	num_tx += nb_pkts;
-	dpaa2_q->tx_pkts += num_tx;
-
-	return num_tx;
+	return dpaa2_dev_tx_multi_txq_ordered(mq, bufs, nb_pkts);
 }
 
 /* This function loopbacks all the received packets.*/
-- 
2.43.0

