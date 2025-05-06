Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7E4C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:28:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6570D4065D;
	Tue,  6 May 2025 15:28:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0E4CB40650
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538096; x=1778074096;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=sdUMcQko0tvIRw+mMoB4R6PUmWiJVPf1eP6WOErnQpk=;
 b=hrwiWWgK6YltPQrR/k4tfGqYU26/Gn4jJuNJUgOjeBaYitLdeYj6a8U1
 o7UDCdySZU3wOQ9IDYzGZj3BxCLN5jK93WK4TaeEbbqrUVAXO75a8lsd5
 M2IFRy43Vi63mHt9fSHm7RyP2DWfhB5N7vlgiRS2le9weMWWsIc8/VrBt
 ZB4ZFbcZplEwP/9R6J/JikPpycVL/hl9FTGJMEp7ySvroEALMpw7ckhz4
 YVVjZnQqbwWVB00ztqgSV/ri7WYG4+zWxlA0JCEzAZlfXrd4tbbjX0FX7
 e8VmOq5I4TUcwvhv+tXggwbg9U//rEQO4cYOq6DXpBTIU7Oj0RHwhuk0Y w==;
X-CSE-ConnectionGUID: LYPrapOTR6W492XNad94MA==
X-CSE-MsgGUID: JSMDeEO5QBazo+P9UzpHJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215289"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:16 -0700
X-CSE-ConnectionGUID: 6aMEVcSuSXKoz2rr1/YGZQ==
X-CSE-MsgGUID: Skfa2cHLSCe620tEhdoqyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010783"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v1 04/13] net/i40e: use the common Rx queue structure
Date: Tue,  6 May 2025 14:27:53 +0100
Message-ID: <95eb2f92eb178442ddca4dee54a04d79cf17881c.1746538072.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Make the i40e driver use the new common Rx queue structure.

Because the i40e driver supports both 16-byte and 32-byte descriptor
formats (controlled by RTE_LIBRTE_I40E_16BYTE_RX_DESC define), the common
queue structure has to take that into account, so the ring queue structure
will have both, while the actual descriptor format is picked by i40e at
compile time using the above macro. Direct usage of Rx queue structure is
now meant to be replaced with a macro access that takes descriptor size
into account.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/rx.h                 |  14 ++
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  16 +--
 .../i40e/i40e_recycle_mbufs_vec_common.c      |   6 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 126 +++++++++---------
 drivers/net/intel/i40e/i40e_rxtx.h            |  74 +++-------
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h |   6 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  22 +--
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  12 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  12 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  24 ++--
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  24 ++--
 14 files changed, 160 insertions(+), 188 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 524de39f9c..db49db57d0 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -30,6 +30,8 @@ struct ci_rx_queue {
 	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
 	union { /* RX ring virtual address */
 		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
+		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
+		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
 	};
 	volatile uint8_t *qrx_tail;   /**< register address of tail */
 	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
@@ -51,14 +53,22 @@ struct ci_rx_queue {
 	uint16_t queue_id; /**< RX queue index. */
 	uint16_t port_id;  /**< Device port identifier. */
 	uint16_t reg_idx;  /**< RX queue register index. */
+	uint16_t rx_buf_len; /* The packet buffer size */
+	uint16_t rx_hdr_len; /* The header buffer size */
+	uint16_t max_pkt_len; /* Maximum packet length */
 	uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
+	bool q_set; /**< indicate if rx queue has been configured */
 	bool rx_deferred_start; /**< queue is not started on dev start. */
+	bool fdir_enabled; /* 0 if FDIR disabled, 1 when enabled */
 	bool vector_rx; /**< indicates that vector RX is in use */
 	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
 	uint64_t mbuf_initializer; /**< value to init mbufs */
 	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
 	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
 	struct rte_mbuf fake_mbuf;
+	union { /* the VSI this queue belongs to */
+		struct i40e_vsi *i40e_vsi;
+	};
 	const struct rte_memzone *mz;
 	union {
 		struct { /* ixgbe specific values */
@@ -71,6 +81,10 @@ struct ci_rx_queue {
 			/** flags to set in mbuf when a vlan is detected. */
 			uint64_t vlan_flags;
 		};
+		struct { /* i40e specific values */
+			uint8_t hs_mode; /**< Header Split mode */
+			uint8_t dcb_tc; /**< Traffic class of rx queue */
+		};
 	};
 };
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 90eba3419f..e0a865845b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6609,7 +6609,7 @@ i40e_dev_rx_init(struct i40e_pf *pf)
 	struct rte_eth_dev_data *data = pf->dev_data;
 	int ret = I40E_SUCCESS;
 	uint16_t i;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	i40e_pf_config_rss(pf);
 	for (i = 0; i < data->nb_rx_queues; i++) {
@@ -8974,7 +8974,7 @@ i40e_pf_calc_configured_queues_num(struct i40e_pf *pf)
 {
 	struct rte_eth_dev_data *data = pf->dev_data;
 	int i, num;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	num = 0;
 	for (i = 0; i < pf->lan_nb_qps; i++) {
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index ccc8732d7d..44864292d0 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -333,7 +333,7 @@ struct i40e_vsi_list {
 	struct i40e_vsi *vsi;
 };
 
-struct i40e_rx_queue;
+struct ci_rx_queue;
 struct ci_tx_queue;
 
 /* Bandwidth limit information */
@@ -739,7 +739,7 @@ struct i40e_fdir_info {
 	struct i40e_vsi *fdir_vsi;     /* pointer to fdir VSI structure */
 	uint16_t match_counter_index;  /* Statistic counter index used for fdir*/
 	struct ci_tx_queue *txq;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	void *prg_pkt[I40E_FDIR_PRG_PKT_CNT];     /* memory for fdir program packet */
 	uint64_t dma_addr[I40E_FDIR_PRG_PKT_CNT]; /* physic address of packet memory*/
 	/*
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 94e3ab44e3..eadcf63d1d 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -100,9 +100,9 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  bool add, bool wait_status);
 
 static int
-i40e_fdir_rx_queue_init(struct i40e_rx_queue *rxq)
+i40e_fdir_rx_queue_init(struct ci_rx_queue *rxq)
 {
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = I40E_SUCCESS;
 
@@ -139,7 +139,7 @@ i40e_fdir_rx_queue_init(struct i40e_rx_queue *rxq)
 		return err;
 	}
 	rxq->qrx_tail = hw->hw_addr +
-		I40E_QRX_TAIL(rxq->vsi->base_queue);
+		I40E_QRX_TAIL(rxq->i40e_vsi->base_queue);
 
 	rte_wmb();
 	/* Init the RX tail register. */
@@ -382,7 +382,7 @@ i40e_fdir_rx_proc_enable(struct rte_eth_dev *dev, bool on)
 	int32_t i;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		rxq->fdir_enabled = on;
@@ -929,7 +929,7 @@ i40e_build_ctob(uint32_t td_cmd,
  * tx queue
  */
 static inline int
-i40e_check_fdir_programming_status(struct i40e_rx_queue *rxq)
+i40e_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
 	volatile union i40e_rx_desc *rxdp;
 	uint64_t qword1;
@@ -938,7 +938,7 @@ i40e_check_fdir_programming_status(struct i40e_rx_queue *rxq)
 	uint32_t error;
 	int ret = 0;
 
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
 	rx_status = (qword1 & I40E_RXD_QW1_STATUS_MASK)
 			>> I40E_RXD_QW1_STATUS_SHIFT;
@@ -987,7 +987,7 @@ i40e_check_fdir_programming_status(struct i40e_rx_queue *rxq)
 }
 
 static inline void
-i40e_fdir_programming_status_cleanup(struct i40e_rx_queue *rxq)
+i40e_fdir_programming_status_cleanup(struct ci_rx_queue *rxq)
 {
 	uint16_t retry_count = 0;
 
@@ -1627,7 +1627,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf *pf,
 				  bool add, bool wait_status)
 {
 	struct ci_tx_queue *txq = pf->fdir.txq;
-	struct i40e_rx_queue *rxq = pf->fdir.rxq;
+	struct ci_rx_queue *rxq = pf->fdir.rxq;
 	const struct i40e_fdir_action *fdir_action = &filter->action;
 	volatile struct i40e_tx_desc *txdp;
 	volatile struct i40e_filter_program_desc *fdirdp;
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 2875c578af..aa7703216d 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -13,15 +13,15 @@
 void
 i40e_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
-	struct i40e_rx_entry *rxep;
+	struct ci_rx_queue *rxq = rx_queue;
+	struct ci_rx_entry *rxep;
 	volatile union i40e_rx_desc *rxdp;
 	uint16_t rx_id;
 	uint64_t paddr;
 	uint64_t dma_addr;
 	uint16_t i;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
 	rxep = &rxq->sw_ring[rxq->rxrearm_start];
 
 	for (i = 0; i < nb_mbufs; i++) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c3ff2e05c3..96490296ba 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -94,12 +94,12 @@ i40e_monitor_callback(const uint64_t value,
 int
 i40e_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile union i40e_rx_desc *rxdp;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
-	rxdp = &rxq->rx_ring[desc];
+	rxdp = I40E_RX_RING_PTR(rxq, desc);
 	/* watch for changes in status bit */
 	pmc->addr = &rxdp->wb.qword1.status_error_len;
 
@@ -416,9 +416,9 @@ i40e_xmit_cleanup(struct ci_tx_queue *txq)
 
 static inline int
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-check_rx_burst_bulk_alloc_preconditions(struct i40e_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
 #else
-check_rx_burst_bulk_alloc_preconditions(__rte_unused struct i40e_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(__rte_unused struct ci_rx_queue *rxq)
 #endif
 {
 	int ret = 0;
@@ -456,10 +456,10 @@ check_rx_burst_bulk_alloc_preconditions(__rte_unused struct i40e_rx_queue *rxq)
 #error "PMD I40E: I40E_LOOK_AHEAD must be 8\n"
 #endif
 static inline int
-i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
+i40e_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 {
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t pkt_len;
 	uint64_t qword1;
@@ -467,9 +467,9 @@ i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
 	int32_t s[I40E_LOOK_AHEAD], var, nb_dd;
 	int32_t i, j, nb_rx = 0;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
@@ -558,7 +558,7 @@ i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
 }
 
 static inline uint16_t
-i40e_rx_fill_from_stage(struct i40e_rx_queue *rxq,
+i40e_rx_fill_from_stage(struct ci_rx_queue *rxq,
 			struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
@@ -577,10 +577,10 @@ i40e_rx_fill_from_stage(struct i40e_rx_queue *rxq,
 }
 
 static inline int
-i40e_rx_alloc_bufs(struct i40e_rx_queue *rxq)
+i40e_rx_alloc_bufs(struct ci_rx_queue *rxq)
 {
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx, i;
 	uint64_t dma_addr;
@@ -597,7 +597,7 @@ i40e_rx_alloc_bufs(struct i40e_rx_queue *rxq)
 		return -ENOMEM;
 	}
 
-	rxdp = &rxq->rx_ring[alloc_idx];
+	rxdp = I40E_RX_RING_PTR(rxq, alloc_idx);
 	for (i = 0; i < rxq->rx_free_thresh; i++) {
 		if (likely(i < (rxq->rx_free_thresh - 1)))
 			/* Prefetch next mbuf */
@@ -629,7 +629,7 @@ i40e_rx_alloc_bufs(struct i40e_rx_queue *rxq)
 static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = (struct i40e_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	struct rte_eth_dev *dev;
 	uint16_t nb_rx = 0;
 
@@ -648,7 +648,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (i40e_rx_alloc_bufs(rxq) != 0) {
 			uint16_t i, j;
 
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed +=
 				rxq->rx_free_thresh;
 
@@ -707,12 +707,12 @@ i40e_recv_pkts_bulk_alloc(void __rte_unused *rx_queue,
 uint16_t
 i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	volatile union i40e_rx_desc *rx_ring;
 	volatile union i40e_rx_desc *rxdp;
 	union i40e_rx_desc rxd;
-	struct i40e_rx_entry *sw_ring;
-	struct i40e_rx_entry *rxe;
+	struct ci_rx_entry *sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -729,9 +729,9 @@ i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
+	rx_ring = I40E_RX_RING(rxq);
 	sw_ring = rxq->sw_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -745,7 +745,7 @@ i40e_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed++;
 			break;
 		}
@@ -837,12 +837,12 @@ i40e_recv_scattered_pkts(void *rx_queue,
 			 struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
-	volatile union i40e_rx_desc *rx_ring = rxq->rx_ring;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union i40e_rx_desc *rx_ring = I40E_RX_RING(rxq);
 	volatile union i40e_rx_desc *rxdp;
 	union i40e_rx_desc rxd;
-	struct i40e_rx_entry *sw_ring = rxq->sw_ring;
-	struct i40e_rx_entry *rxe;
+	struct ci_rx_entry *sw_ring = rxq->sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -853,7 +853,7 @@ i40e_recv_scattered_pkts(void *rx_queue,
 	uint64_t qword1;
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -867,7 +867,7 @@ i40e_recv_scattered_pkts(void *rx_queue,
 
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			dev = I40E_VSI_TO_ETH_DEV(rxq->vsi);
+			dev = I40E_VSI_TO_ETH_DEV(rxq->i40e_vsi);
 			dev->data->rx_mbuf_alloc_failed++;
 			break;
 		}
@@ -1798,7 +1798,7 @@ i40e_get_queue_offset_by_qindex(struct i40e_pf *pf, uint16_t queue_idx)
 int
 i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -1841,7 +1841,7 @@ i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 int
 i40e_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -2004,7 +2004,7 @@ i40e_dev_first_queue(uint16_t idx, void **queues, int num)
 
 static int
 i40e_dev_rx_queue_setup_runtime(struct rte_eth_dev *dev,
-				struct i40e_rx_queue *rxq)
+				struct ci_rx_queue *rxq)
 {
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -2081,7 +2081,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct i40e_vsi *vsi;
 	struct i40e_pf *pf = NULL;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz;
 	uint32_t ring_size;
 	uint16_t len, i;
@@ -2116,7 +2116,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket("i40e rx queue",
-				 sizeof(struct i40e_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 	if (!rxq) {
@@ -2135,7 +2135,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	else
 		rxq->crc_len = 0;
 	rxq->drop_en = rx_conf->rx_drop_en;
-	rxq->vsi = vsi;
+	rxq->i40e_vsi = vsi;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->offloads = offloads;
 
@@ -2164,14 +2164,14 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	memset(rz->addr, 0, ring_size);
 
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union i40e_rx_desc *)rz->addr;
+	I40E_RX_RING(rxq) = (union i40e_rx_desc *)rz->addr;
 
 	len = (uint16_t)(nb_desc + RTE_PMD_I40E_RX_MAX_BURST);
 
 	/* Allocate the software ring. */
 	rxq->sw_ring =
 		rte_zmalloc_socket("i40e rx sw ring",
-				   sizeof(struct i40e_rx_entry) * len,
+				   sizeof(struct ci_rx_entry) * len,
 				   RTE_CACHE_LINE_SIZE,
 				   socket_id);
 	if (!rxq->sw_ring) {
@@ -2242,7 +2242,7 @@ i40e_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 void
 i40e_rx_queue_release(void *rxq)
 {
-	struct i40e_rx_queue *q = (struct i40e_rx_queue *)rxq;
+	struct ci_rx_queue *q = (struct ci_rx_queue *)rxq;
 
 	if (!q) {
 		PMD_DRV_LOG(DEBUG, "Pointer to rxq is NULL");
@@ -2260,11 +2260,11 @@ i40e_dev_rx_queue_count(void *rx_queue)
 {
 #define I40E_RXQ_SCAN_INTERVAL 4
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint16_t desc = 0;
 
 	rxq = rx_queue;
-	rxdp = &(rxq->rx_ring[rxq->rx_tail]);
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 	while ((desc < rxq->nb_rx_desc) &&
 		((rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len) &
 		I40E_RXD_QW1_STATUS_MASK) >> I40E_RXD_QW1_STATUS_SHIFT) &
@@ -2277,8 +2277,8 @@ i40e_dev_rx_queue_count(void *rx_queue)
 		desc += I40E_RXQ_SCAN_INTERVAL;
 		rxdp += I40E_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
-			rxdp = &(rxq->rx_ring[rxq->rx_tail +
-					desc - rxq->nb_rx_desc]);
+			rxdp = I40E_RX_RING_PTR(rxq,
+					rxq->rx_tail + desc - rxq->nb_rx_desc);
 	}
 
 	return desc;
@@ -2287,7 +2287,7 @@ i40e_dev_rx_queue_count(void *rx_queue)
 int
 i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint64_t *status;
 	uint64_t mask;
 	uint32_t desc;
@@ -2302,7 +2302,7 @@ i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (desc >= rxq->nb_rx_desc)
 		desc -= rxq->nb_rx_desc;
 
-	status = &rxq->rx_ring[desc].wb.qword1.status_error_len;
+	status = &I40E_RX_RING_PTR(rxq, desc)->wb.qword1.status_error_len;
 	mask = rte_le_to_cpu_64((1ULL << I40E_RX_DESC_STATUS_DD_SHIFT)
 		<< I40E_RXD_QW1_STATUS_SHIFT);
 	if (*status & mask)
@@ -2628,12 +2628,12 @@ i40e_memzone_reserve(const char *name, uint32_t len, int socket_id)
 }
 
 void
-i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	uint16_t i;
 
 	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->rx_using_sse) {
+	if (rxq->vector_rx) {
 		i40e_rx_queue_release_mbufs_vec(rxq);
 		return;
 	}
@@ -2663,7 +2663,7 @@ i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq)
 }
 
 void
-i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
+i40e_reset_rx_queue(struct ci_rx_queue *rxq)
 {
 	unsigned i;
 	uint16_t len;
@@ -2681,7 +2681,7 @@ i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
 		len = rxq->nb_rx_desc;
 
 	for (i = 0; i < len * sizeof(union i40e_rx_desc); i++)
-		((volatile char *)rxq->rx_ring)[i] = 0;
+		((volatile char *)I40E_RX_RING(rxq))[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
 	for (i = 0; i < RTE_PMD_I40E_RX_MAX_BURST; ++i)
@@ -2898,9 +2898,9 @@ i40e_tx_queue_init(struct ci_tx_queue *txq)
 }
 
 int
-i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
+i40e_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 {
-	struct i40e_rx_entry *rxe = rxq->sw_ring;
+	struct ci_rx_entry *rxe = rxq->sw_ring;
 	uint64_t dma_addr;
 	uint16_t i;
 
@@ -2922,7 +2922,7 @@ i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
 
-		rxd = &rxq->rx_ring[i];
+		rxd = I40E_RX_RING_PTR(rxq, i);
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
 #ifndef RTE_LIBRTE_I40E_16BYTE_RX_DESC
@@ -2941,10 +2941,10 @@ i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq)
  * and maximum packet length.
  */
 static int
-i40e_rx_queue_config(struct i40e_rx_queue *rxq)
+i40e_rx_queue_config(struct ci_rx_queue *rxq)
 {
-	struct i40e_pf *pf = I40E_VSI_TO_PF(rxq->vsi);
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
+	struct i40e_pf *pf = I40E_VSI_TO_PF(rxq->i40e_vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
 	struct rte_eth_dev_data *data = pf->dev_data;
 	uint16_t buf_size;
 
@@ -2988,11 +2988,11 @@ i40e_rx_queue_config(struct i40e_rx_queue *rxq)
 
 /* Init the RX queue in hardware */
 int
-i40e_rx_queue_init(struct i40e_rx_queue *rxq)
+i40e_rx_queue_init(struct ci_rx_queue *rxq)
 {
 	int err = I40E_SUCCESS;
-	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->vsi);
-	struct rte_eth_dev_data *dev_data = I40E_VSI_TO_DEV_DATA(rxq->vsi);
+	struct i40e_hw *hw = I40E_VSI_TO_HW(rxq->i40e_vsi);
+	struct rte_eth_dev_data *dev_data = I40E_VSI_TO_DEV_DATA(rxq->i40e_vsi);
 	uint16_t pf_q = rxq->reg_idx;
 	uint16_t buf_size;
 	struct i40e_hmc_obj_rxq rx_ctx;
@@ -3166,7 +3166,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
 enum i40e_status_code
 i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz = NULL;
 	uint32_t ring_size;
 	struct rte_eth_dev *dev;
@@ -3180,7 +3180,7 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 
 	/* Allocate the RX queue data structure. */
 	rxq = rte_zmalloc_socket("i40e fdir rx queue",
-				  sizeof(struct i40e_rx_queue),
+				  sizeof(struct ci_rx_queue),
 				  RTE_CACHE_LINE_SIZE,
 				  SOCKET_ID_ANY);
 	if (!rxq) {
@@ -3206,11 +3206,11 @@ i40e_fdir_setup_rx_resources(struct i40e_pf *pf)
 	rxq->nb_rx_desc = I40E_FDIR_NUM_RX_DESC;
 	rxq->queue_id = I40E_FDIR_QUEUE_ID;
 	rxq->reg_idx = pf->fdir.fdir_vsi->base_queue;
-	rxq->vsi = pf->fdir.fdir_vsi;
+	rxq->i40e_vsi = pf->fdir.fdir_vsi;
 
 	rxq->rx_ring_phys_addr = rz->iova;
 	memset(rz->addr, 0, I40E_FDIR_NUM_RX_DESC * sizeof(union i40e_rx_desc));
-	rxq->rx_ring = (union i40e_rx_desc *)rz->addr;
+	I40E_RX_RING(rxq) = (union i40e_rx_desc *)rz->addr;
 
 	/*
 	 * Don't need to allocate software ring and reset for the fdir
@@ -3226,7 +3226,7 @@ void
 i40e_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -3264,7 +3264,7 @@ void
 i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
-	struct i40e_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
@@ -3335,7 +3335,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 		}
 		if (ad->rx_vec_allowed) {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
-				struct i40e_rx_queue *rxq =
+				struct ci_rx_queue *rxq =
 					dev->data->rx_queues[i];
 
 				if (rxq && i40e_rxq_vec_setup(rxq)) {
@@ -3438,10 +3438,10 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 			 dev->rx_pkt_burst == i40e_recv_pkts_vec_avx2);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+			struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 			if (rxq)
-				rxq->rx_using_sse = rx_using_sse;
+				rxq->vector_rx = rx_using_sse;
 		}
 	}
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 2f32fc5686..4b5a84d8ef 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -6,8 +6,9 @@
 #define _I40E_RXTX_H_
 
 #include "../common/tx.h"
+#include "../common/rx.h"
 
-#define RTE_PMD_I40E_RX_MAX_BURST 32
+#define RTE_PMD_I40E_RX_MAX_BURST CI_RX_MAX_BURST
 #define RTE_PMD_I40E_TX_MAX_BURST 32
 
 #define RTE_I40E_VPMD_RX_BURST        32
@@ -67,62 +68,19 @@ enum i40e_header_split_mode {
 			       I40E_HEADER_SPLIT_UDP_TCP | \
 			       I40E_HEADER_SPLIT_SCTP)
 
-/* HW desc structure, both 16-byte and 32-byte types are supported */
+/* HW desc structures, both 16-byte and 32-byte types are supported */
 #ifdef RTE_LIBRTE_I40E_16BYTE_RX_DESC
 #define i40e_rx_desc i40e_16byte_rx_desc
+#define I40E_RX_RING(rxq) \
+	((rxq)->i40e_rx_16b_ring)
 #else
 #define i40e_rx_desc i40e_32byte_rx_desc
+#define I40E_RX_RING(rxq) \
+	((rxq)->i40e_rx_32b_ring)
 #endif
 
-struct i40e_rx_entry {
-	struct rte_mbuf *mbuf;
-};
-
-/*
- * Structure associated with each RX queue.
- */
-struct i40e_rx_queue {
-	struct rte_mempool *mp; /**< mbuf pool to populate RX ring */
-	volatile union i40e_rx_desc *rx_ring;/**< RX ring virtual address */
-	uint64_t rx_ring_phys_addr; /**< RX ring DMA address */
-	struct i40e_rx_entry *sw_ring; /**< address of RX soft ring */
-	uint16_t nb_rx_desc; /**< number of RX descriptors */
-	uint16_t rx_free_thresh; /**< max free RX desc to hold */
-	uint16_t rx_tail; /**< current value of tail */
-	uint16_t nb_rx_hold; /**< number of held free RX desc */
-	struct rte_mbuf *pkt_first_seg; /**< first segment of current packet */
-	struct rte_mbuf *pkt_last_seg; /**< last segment of current packet */
-	struct rte_mbuf fake_mbuf; /**< dummy mbuf */
-#ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-	uint16_t rx_nb_avail; /**< number of staged packets ready */
-	uint16_t rx_next_avail; /**< index of next staged packets */
-	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	struct rte_mbuf *rx_stage[RTE_PMD_I40E_RX_MAX_BURST * 2];
-#endif
-
-	uint16_t rxrearm_nb;	/**< number of remaining to be re-armed */
-	uint16_t rxrearm_start;	/**< the idx we start the re-arming from */
-	uint64_t mbuf_initializer; /**< value to init mbufs */
-
-	uint16_t port_id; /**< device port ID */
-	uint8_t crc_len; /**< 0 if CRC stripped, 4 otherwise */
-	uint8_t fdir_enabled; /**< 0 if FDIR disabled, 1 when enabled */
-	uint16_t queue_id; /**< RX queue index */
-	uint16_t reg_idx; /**< RX queue register index */
-	uint8_t drop_en; /**< if not 0, set register bit */
-	volatile uint8_t *qrx_tail; /**< register address of tail */
-	struct i40e_vsi *vsi; /**< the VSI this queue belongs to */
-	uint16_t rx_buf_len; /* The packet buffer size */
-	uint16_t rx_hdr_len; /* The header buffer size */
-	uint16_t max_pkt_len; /* Maximum packet length */
-	uint8_t hs_mode; /* Header Split mode */
-	bool q_set; /**< indicate if rx queue has been configured */
-	bool rx_deferred_start; /**< don't start this queue in dev start */
-	uint16_t rx_using_sse; /**<flag indicate the usage of vPMD for rx */
-	uint8_t dcb_tc;         /**< Traffic class of rx queue */
-	uint64_t offloads; /**< Rx offload flags of RTE_ETH_RX_OFFLOAD_* */
-	const struct rte_memzone *mz;
-};
+#define I40E_RX_RING_PTR(rxq, entry) \
+	(I40E_RX_RING(rxq) + (entry))
 
 /** Offload features */
 union i40e_tx_offload {
@@ -172,16 +130,16 @@ uint16_t i40e_simple_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 uint16_t i40e_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
 int i40e_tx_queue_init(struct ci_tx_queue *txq);
-int i40e_rx_queue_init(struct i40e_rx_queue *rxq);
+int i40e_rx_queue_init(struct ci_rx_queue *rxq);
 void i40e_free_tx_resources(struct ci_tx_queue *txq);
-void i40e_free_rx_resources(struct i40e_rx_queue *rxq);
+void i40e_free_rx_resources(struct ci_rx_queue *rxq);
 void i40e_dev_clear_queues(struct rte_eth_dev *dev);
 void i40e_dev_free_queues(struct rte_eth_dev *dev);
-void i40e_reset_rx_queue(struct i40e_rx_queue *rxq);
+void i40e_reset_rx_queue(struct ci_rx_queue *rxq);
 void i40e_reset_tx_queue(struct ci_tx_queue *txq);
 int i40e_tx_done_cleanup(void *txq, uint32_t free_cnt);
-int i40e_alloc_rx_queue_mbufs(struct i40e_rx_queue *rxq);
-void i40e_rx_queue_release_mbufs(struct i40e_rx_queue *rxq);
+int i40e_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq);
+void i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq);
 
 uint32_t i40e_dev_rx_queue_count(void *rx_queue);
 int i40e_dev_rx_descriptor_status(void *rx_queue, uint16_t offset);
@@ -197,9 +155,9 @@ uint16_t i40e_recv_scattered_pkts_vec(void *rx_queue,
 				      struct rte_mbuf **rx_pkts,
 				      uint16_t nb_pkts);
 int i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
-int i40e_rxq_vec_setup(struct i40e_rx_queue *rxq);
+int i40e_rxq_vec_setup(struct ci_rx_queue *rxq);
 int i40e_txq_vec_setup(struct ci_tx_queue *txq);
-void i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq);
+void i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 uint16_t i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
 void i40e_set_rx_function(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
index b66a808f9f..fd9447014b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
@@ -13,14 +13,14 @@
 
 #ifdef __AVX2__
 static __rte_always_inline void
-i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
+i40e_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 42beff6e89..3e4109e82e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -16,13 +16,13 @@
 #include <rte_altivec.h>
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union i40e_rx_desc *rxdp;
 
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 
 	__vector unsigned long hdr_room = (__vector unsigned long){
@@ -30,7 +30,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 						RTE_PKTMBUF_HEADROOM};
 	__vector unsigned long dma_addr0, dma_addr1;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = I40E_RX_RING(rxq) + rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
@@ -195,16 +195,16 @@ desc_to_ptype_v(__vector unsigned long descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__vector unsigned char shuf_msk;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	__vector unsigned short crc_adjust = (__vector unsigned short){
 		0, 0,         /* ignore pkt_type field */
@@ -221,7 +221,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -465,7 +465,7 @@ static uint16_t
 i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -611,15 +611,15 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 9c406e7a6f..0f3f7430aa 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -16,7 +16,7 @@
 #include <rte_vect.h>
 
 static __rte_always_inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	i40e_rxq_rearm_common(rxq, false);
 }
@@ -105,16 +105,16 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 
 /* Force inline as some compilers will not inline by default. */
 static __rte_always_inline uint16_t
-_recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts, uint8_t *split_packet)
 {
 #define RTE_I40E_DESCS_PER_LOOP_AVX 8
 
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct i40e_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union i40e_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union i40e_rx_desc *rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 	rte_prefetch0(rxdp);
 
@@ -625,7 +625,7 @@ static uint16_t
 i40e_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index d8244556c0..f2292b45e8 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -18,7 +18,7 @@
 #define RTE_I40E_DESCS_PER_LOOP_AVX 8
 
 static __rte_always_inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	i40e_rxq_rearm_common(rxq, true);
 }
@@ -108,14 +108,14 @@ desc_fdir_processing_32b(volatile union i40e_rx_desc *rxdp,
 
 /* Force inline as some compilers will not inline by default. */
 static __rte_always_inline uint16_t
-_recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts, uint8_t *split_packet)
 {
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct i40e_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union i40e_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union i40e_rx_desc *rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -693,7 +693,7 @@ i40e_recv_scattered_burst_vec_avx512(void *rx_queue,
 				     struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts)
 {
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index ba72df8e13..d19b9e4bf4 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -21,7 +21,7 @@ i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 }
 
 static inline void
-_i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+_i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	const unsigned mask = rxq->nb_rx_desc - 1;
 	unsigned i;
@@ -68,7 +68,7 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 	 */
 	ad->rx_vec_allowed = true;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct i40e_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads)) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index d16ceb6b5d..814aa666dc 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -17,18 +17,18 @@
 #include "i40e_rxtx_vec_common.h"
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	uint64x2_t dma_addr0, dma_addr1;
 	uint64x2_t zero = vdupq_n_u64(0);
 	uint64_t paddr;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (unlikely(rte_mempool_get_bulk(rxq->mp,
@@ -203,7 +203,7 @@ descs_to_fdir_16b(uint32x4_t fltstat, uint64x2_t descs[4], struct rte_mbuf **rx_
 #endif
 
 static inline void
-desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
 		  uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
 {
 	uint32x4_t vlan0, vlan1, rss, l3_l4e;
@@ -332,15 +332,15 @@ desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
  * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
+_recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   struct rte_mbuf **__rte_restrict rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	/* mask to shuffle from desc. to mbuf */
 	uint8x16_t shuf_msk = {
@@ -374,7 +374,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch_non_temporal(rxdp);
 
@@ -592,7 +592,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -738,15 +738,15 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict tx_queue,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 774519265b..74cd59e245 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -15,18 +15,18 @@
 #include <rte_vect.h>
 
 static inline void
-i40e_rxq_rearm(struct i40e_rx_queue *rxq)
+i40e_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
 	__m128i dma_addr0, dma_addr1;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
@@ -207,7 +207,7 @@ descs_to_fdir_16b(__m128i fltstat, __m128i descs[4], struct rte_mbuf **rx_pkt)
 #endif
 
 static inline void
-desc_to_olflags_v(struct i40e_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union i40e_rx_desc *rxdp,
 		  __m128i descs[4], struct rte_mbuf **rx_pkts)
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
@@ -347,16 +347,16 @@ desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union i40e_rx_desc *rxdp;
-	struct i40e_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__m128i shuf_msk;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
 
 	__m128i crc_adjust = _mm_set_epi16(
 				0, 0, 0,    /* ignore non-length fields */
@@ -382,7 +382,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = I40E_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -609,7 +609,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 
-	struct i40e_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -755,15 +755,15 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct i40e_rx_queue *rxq)
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_i40e_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-i40e_rxq_vec_setup(struct i40e_rx_queue *rxq)
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
-	rxq->rx_using_sse = 1;
+	rxq->vector_rx = 1;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
 }
-- 
2.47.1

