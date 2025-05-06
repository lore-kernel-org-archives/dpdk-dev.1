Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F13C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81C4440671;
	Tue,  6 May 2025 15:28:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id F0F2C40650
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538100; x=1778074100;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=TQmD4yijR8IuPU517Wp91BfVri4Ghgq/IDdBIYt+nvQ=;
 b=KMUort2idHyGKGdS/GQuoOd0h3oeTUimpkKhnjuW9Qlm9AZFaHD/umTf
 AP4iCo3SEtwaAmgPUkaFa+v5oLtoDhIqpWYERuZf7MYe364wuWFpcjdRV
 47Hz8Heqv+TBHydbGCfqwNov4QaG7YjTiBEbuxsFU3Cnb90TpaONMzZOc
 Lal+HLxRN4bUgTywbSdSC2APb+p7ByJXG241JVQp6NrrGa62wnYphcxBY
 ImPXibTSs58Xq4JvHNZaOqbIEBfUoenTrBnwUCVJbFOP39oXBrJoI6jwa
 WNNics+mzKC39KYJR+S61k7Dydb2jaIlJ8/+L6QVs6+T4S7SCwOySQd6q w==;
X-CSE-ConnectionGUID: ns1j3GvEROWJdO4NcOFB1A==
X-CSE-MsgGUID: gz/yFA6TRRWuNpevMKvS3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215299"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215299"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:20 -0700
X-CSE-ConnectionGUID: UrXdTIPwRfqQhNOGrwzsgw==
X-CSE-MsgGUID: uguo7+hJQiSkoYDxyzogSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010807"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v1 06/13] net/iavf: use the common Rx queue structure
Date: Tue,  6 May 2025 14:27:55 +0100
Message-ID: <0bfd8c734682e56c2a5162aa9532a5bbfbfaf4f3.1746538072.git.anatoly.burakov@intel.com>
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

Make the iavf driver use the new common Rx queue structure.

Because the iavf driver supports both 16-byte and 32-byte descriptor
formats (controlled by RTE_LIBRTE_IAVF_16BYTE_RX_DESC define), the common
queue structure has to take that into account, so the ring queue structure
will have both, while the actual descriptor format is picked by iavf at
compile time using the above macro. Direct usage of Rx queue structure is
now meant to be replaced with a macro access that takes descriptor size
into account.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/rx.h                 |  12 ++
 drivers/net/intel/iavf/iavf.h                 |   4 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  12 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 192 +++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h            |  76 ++-----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  24 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  22 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  27 ++-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  12 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  46 ++---
 drivers/net/intel/iavf/iavf_vchnl.c           |   6 +-
 11 files changed, 198 insertions(+), 235 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index b4836e7914..507235f4c6 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -37,6 +37,8 @@ struct ci_rx_queue {
 		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
 		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
 		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
+		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
+		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
 	};
 	volatile uint8_t *qrx_tail;   /**< register address of tail */
 	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
@@ -79,6 +81,7 @@ struct ci_rx_queue {
 	union { /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct ice_vsi *ice_vsi;
+		struct iavf_vsi *iavf_vsi;
 	};
 	const struct rte_memzone *mz;
 	union {
@@ -107,6 +110,15 @@ struct ci_rx_queue {
 			uint32_t hw_time_low; /* low 32 bits of timestamp */
 			bool ts_enable; /* if rxq timestamp is enabled */
 		};
+		struct { /* iavf specific values */
+			const struct iavf_rxq_ops *ops; /**< queue ops */
+			struct iavf_rx_queue_stats *stats; /**< per-queue stats */
+			uint64_t phc_time; /**< HW timestamp */
+			uint8_t rel_mbufs_type; /**< type of release mbuf function */
+			uint8_t rx_flags; /**< Rx VLAN tag location flags */
+#define IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG1     BIT(0)
+#define IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG2_2   BIT(1)
+		};
 	};
 };
 
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 97e6b243fb..f81c939c96 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -97,7 +97,7 @@
 #define IAVF_L2TPV2_FLAGS_LEN	0x4000
 
 struct iavf_adapter;
-struct iavf_rx_queue;
+struct ci_rx_queue;
 struct ci_tx_queue;
 
 
@@ -555,7 +555,7 @@ int iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 		uint8_t *resp_msg, size_t resp_msg_len);
 extern const struct rte_tm_ops iavf_tm_ops;
 int iavf_get_ptp_cap(struct iavf_adapter *adapter);
-int iavf_get_phc_time(struct iavf_rx_queue *rxq);
+int iavf_get_phc_time(struct ci_rx_queue *rxq);
 int iavf_flow_sub(struct iavf_adapter *adapter,
 		  struct iavf_fsub_conf *filter);
 int iavf_flow_unsub(struct iavf_adapter *adapter,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 5babd587b3..4e843a3532 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -728,7 +728,7 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 }
 
 static int
-iavf_init_rxq(struct rte_eth_dev *dev, struct iavf_rx_queue *rxq)
+iavf_init_rxq(struct rte_eth_dev *dev, struct ci_rx_queue *rxq)
 {
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_eth_dev_data *dev_data = dev->data;
@@ -779,8 +779,8 @@ iavf_init_rxq(struct rte_eth_dev *dev, struct iavf_rx_queue *rxq)
 static int
 iavf_init_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue **rxq =
-		(struct iavf_rx_queue **)dev->data->rx_queues;
+	struct ci_rx_queue **rxq =
+		(struct ci_rx_queue **)dev->data->rx_queues;
 	int i, ret = IAVF_SUCCESS;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -955,7 +955,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 static int
 iavf_start_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int i;
 	uint16_t nb_txq, nb_rxq;
@@ -1867,9 +1867,9 @@ iavf_dev_update_ipsec_xstats(struct rte_eth_dev *ethdev,
 {
 	uint16_t idx;
 	for (idx = 0; idx < ethdev->data->nb_rx_queues; idx++) {
-		struct iavf_rx_queue *rxq;
+		struct ci_rx_queue *rxq;
 		struct iavf_ipsec_crypto_stats *stats;
-		rxq = (struct iavf_rx_queue *)ethdev->data->rx_queues[idx];
+		rxq = (struct ci_rx_queue *)ethdev->data->rx_queues[idx];
 		stats = &rxq->stats->ipsec_crypto;
 		ips->icount += stats->icount;
 		ips->ibytes += stats->ibytes;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d23d2df807..a9ce4b55d9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -128,12 +128,12 @@ iavf_monitor_callback(const uint64_t value,
 int
 iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile union iavf_rx_desc *rxdp;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
-	rxdp = &rxq->rx_ring[desc];
+	rxdp = IAVF_RX_RING_PTR(rxq, desc);
 	/* watch for changes in status bit */
 	pmc->addr = &rxdp->wb.qword1.status_error_len;
 
@@ -222,7 +222,7 @@ check_tx_vec_allow(struct ci_tx_queue *txq)
 }
 
 static inline bool
-check_rx_bulk_allow(struct iavf_rx_queue *rxq)
+check_rx_bulk_allow(struct ci_rx_queue *rxq)
 {
 	int ret = true;
 
@@ -243,7 +243,7 @@ check_rx_bulk_allow(struct iavf_rx_queue *rxq)
 }
 
 static inline void
-reset_rx_queue(struct iavf_rx_queue *rxq)
+reset_rx_queue(struct ci_rx_queue *rxq)
 {
 	uint16_t len;
 	uint32_t i;
@@ -254,12 +254,12 @@ reset_rx_queue(struct iavf_rx_queue *rxq)
 	len = rxq->nb_rx_desc + IAVF_RX_MAX_BURST;
 
 	for (i = 0; i < len * sizeof(union iavf_rx_desc); i++)
-		((volatile char *)rxq->rx_ring)[i] = 0;
+		((volatile char *)IAVF_RX_RING(rxq))[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
 
 	for (i = 0; i < IAVF_RX_MAX_BURST; i++)
-		rxq->sw_ring[rxq->nb_rx_desc + i] = &rxq->fake_mbuf;
+		rxq->sw_ring[rxq->nb_rx_desc + i].mbuf = &rxq->fake_mbuf;
 
 	/* for rx bulk */
 	rxq->rx_nb_avail = 0;
@@ -315,7 +315,7 @@ reset_tx_queue(struct ci_tx_queue *txq)
 }
 
 static int
-alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
+alloc_rxq_mbufs(struct ci_rx_queue *rxq)
 {
 	volatile union iavf_rx_desc *rxd;
 	struct rte_mbuf *mbuf = NULL;
@@ -326,8 +326,8 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		mbuf = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!mbuf)) {
 			for (j = 0; j < i; j++) {
-				rte_pktmbuf_free_seg(rxq->sw_ring[j]);
-				rxq->sw_ring[j] = NULL;
+				rte_pktmbuf_free_seg(rxq->sw_ring[j].mbuf);
+				rxq->sw_ring[j].mbuf = NULL;
 			}
 			PMD_DRV_LOG(ERR, "Failed to allocate mbuf for RX");
 			return -ENOMEM;
@@ -342,7 +342,7 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
 
-		rxd = &rxq->rx_ring[i];
+		rxd = IAVF_RX_RING_PTR(rxq, i);
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
 #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
@@ -350,14 +350,14 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		rxd->read.rsvd2 = 0;
 #endif
 
-		rxq->sw_ring[i] = mbuf;
+		rxq->sw_ring[i].mbuf = mbuf;
 	}
 
 	return 0;
 }
 
 static inline void
-release_rxq_mbufs(struct iavf_rx_queue *rxq)
+release_rxq_mbufs(struct ci_rx_queue *rxq)
 {
 	uint16_t i;
 
@@ -365,9 +365,9 @@ release_rxq_mbufs(struct iavf_rx_queue *rxq)
 		return;
 
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
-		if (rxq->sw_ring[i]) {
-			rte_pktmbuf_free_seg(rxq->sw_ring[i]);
-			rxq->sw_ring[i] = NULL;
+		if (rxq->sw_ring[i].mbuf) {
+			rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
+			rxq->sw_ring[i].mbuf = NULL;
 		}
 	}
 
@@ -395,7 +395,7 @@ struct iavf_rxq_ops iavf_rxq_release_mbufs_ops[] = {
 };
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ci_rx_queue *rxq,
 				    struct rte_mbuf *mb,
 				    volatile union iavf_rx_flex_desc *rxdp)
 {
@@ -420,7 +420,7 @@ iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
 }
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct ci_rx_queue *rxq,
 				       struct rte_mbuf *mb,
 				       volatile union iavf_rx_flex_desc *rxdp)
 {
@@ -462,7 +462,7 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
 }
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct ci_rx_queue *rxq,
 				       struct rte_mbuf *mb,
 				       volatile union iavf_rx_flex_desc *rxdp)
 {
@@ -517,7 +517,7 @@ iavf_rxd_to_pkt_fields_t rxd_to_pkt_fields_ops[IAVF_RXDID_LAST + 1] = {
 };
 
 static void
-iavf_select_rxd_to_pkt_fields_handler(struct iavf_rx_queue *rxq, uint32_t rxdid)
+iavf_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq, uint32_t rxdid)
 {
 	rxq->rxdid = rxdid;
 
@@ -572,7 +572,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct iavf_info *vf =
 		IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_vsi *vsi = &vf->vsi;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *mz;
 	uint32_t ring_size;
 	uint8_t proto_xtr;
@@ -610,7 +610,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket("iavf rxq",
-				 sizeof(struct iavf_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 	if (!rxq) {
@@ -668,7 +668,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->port_id = dev->data->port_id;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->rx_hdr_len = 0;
-	rxq->vsi = vsi;
+	rxq->iavf_vsi = vsi;
 	rxq->offloads = offloads;
 
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
@@ -713,7 +713,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Zero all the descriptors in the ring. */
 	memset(mz->addr, 0, ring_size);
 	rxq->rx_ring_phys_addr = mz->iova;
-	rxq->rx_ring = (union iavf_rx_desc *)mz->addr;
+	IAVF_RX_RING(rxq) = (union iavf_rx_desc *)mz->addr;
 
 	rxq->mz = mz;
 	reset_rx_queue(rxq);
@@ -905,7 +905,7 @@ iavf_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err = 0;
 
 	PMD_DRV_FUNC_TRACE();
@@ -997,7 +997,7 @@ iavf_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 
 	PMD_DRV_FUNC_TRACE();
@@ -1060,7 +1060,7 @@ iavf_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 void
 iavf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
-	struct iavf_rx_queue *q = dev->data->rx_queues[qid];
+	struct ci_rx_queue *q = dev->data->rx_queues[qid];
 
 	if (!q)
 		return;
@@ -1089,7 +1089,7 @@ iavf_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 static void
 iavf_reset_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int i;
 
@@ -1375,7 +1375,7 @@ iavf_flex_rxd_error_to_pkt_flags(uint16_t stat_err0)
  * from the hardware point of view.
  */
 static inline void
-iavf_update_rx_tail(struct iavf_rx_queue *rxq, uint16_t nb_hold, uint16_t rx_id)
+iavf_update_rx_tail(struct ci_rx_queue *rxq, uint16_t nb_hold, uint16_t rx_id)
 {
 	nb_hold = (uint16_t)(nb_hold + rxq->nb_rx_hold);
 
@@ -1397,9 +1397,9 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	volatile union iavf_rx_desc *rx_ring;
 	volatile union iavf_rx_desc *rxdp;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	union iavf_rx_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_entry rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -1416,8 +1416,8 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	rx_ring = IAVF_RX_RING(rxq);
+	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -1442,13 +1442,13 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		rxd = *rxdp;
 		nb_hold++;
 		rxe = rxq->sw_ring[rx_id];
-		rxq->sw_ring[rx_id] = nmb;
+		rxq->sw_ring[rx_id].mbuf = nmb;
 		rx_id++;
 		if (unlikely(rx_id == rxq->nb_rx_desc))
 			rx_id = 0;
 
 		/* Prefetch next mbuf */
-		rte_prefetch0(rxq->sw_ring[rx_id]);
+		rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 
 		/* When next RX descriptor is on a cache line boundary,
 		 * prefetch the next 4 RX descriptors and next 8 pointers
@@ -1456,9 +1456,9 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 */
 		if ((rx_id & 0x3) == 0) {
 			rte_prefetch0(&rx_ring[rx_id]);
-			rte_prefetch0(rxq->sw_ring[rx_id]);
+			rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 		}
-		rxm = rxe;
+		rxm = rxe.mbuf;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
 		rxdp->read.hdr_addr = 0;
@@ -1506,9 +1506,9 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 {
 	volatile union iavf_rx_desc *rx_ring;
 	volatile union iavf_rx_flex_desc *rxdp;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	union iavf_rx_flex_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_entry rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -1525,8 +1525,8 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	rx_ring = IAVF_RX_RING(rxq);
+	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -1559,13 +1559,13 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 		rxd = *rxdp;
 		nb_hold++;
 		rxe = rxq->sw_ring[rx_id];
-		rxq->sw_ring[rx_id] = nmb;
+		rxq->sw_ring[rx_id].mbuf = nmb;
 		rx_id++;
 		if (unlikely(rx_id == rxq->nb_rx_desc))
 			rx_id = 0;
 
 		/* Prefetch next mbuf */
-		rte_prefetch0(rxq->sw_ring[rx_id]);
+		rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 
 		/* When next RX descriptor is on a cache line boundary,
 		 * prefetch the next 4 RX descriptors and next 8 pointers
@@ -1573,9 +1573,9 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 		 */
 		if ((rx_id & 0x3) == 0) {
 			rte_prefetch0(&rx_ring[rx_id]);
-			rte_prefetch0(rxq->sw_ring[rx_id]);
+			rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 		}
-		rxm = rxe;
+		rxm = rxe.mbuf;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
 		rxdp->read.hdr_addr = 0;
@@ -1629,9 +1629,9 @@ uint16_t
 iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 				  uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	union iavf_rx_flex_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_entry rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -1643,9 +1643,9 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint64_t pkt_flags;
 	uint64_t ts_ns;
 
-	volatile union iavf_rx_desc *rx_ring = rxq->rx_ring;
+	volatile union iavf_rx_desc *rx_ring = IAVF_RX_RING(rxq);
 	volatile union iavf_rx_flex_desc *rxdp;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -1678,13 +1678,13 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxd = *rxdp;
 		nb_hold++;
 		rxe = rxq->sw_ring[rx_id];
-		rxq->sw_ring[rx_id] = nmb;
+		rxq->sw_ring[rx_id].mbuf = nmb;
 		rx_id++;
 		if (rx_id == rxq->nb_rx_desc)
 			rx_id = 0;
 
 		/* Prefetch next mbuf */
-		rte_prefetch0(rxq->sw_ring[rx_id]);
+		rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 
 		/* When next RX descriptor is on a cache line boundary,
 		 * prefetch the next 4 RX descriptors and next 8 pointers
@@ -1692,10 +1692,10 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 */
 		if ((rx_id & 0x3) == 0) {
 			rte_prefetch0(&rx_ring[rx_id]);
-			rte_prefetch0(rxq->sw_ring[rx_id]);
+			rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 		}
 
-		rxm = rxe;
+		rxm = rxe.mbuf;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
 
@@ -1806,9 +1806,9 @@ uint16_t
 iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	union iavf_rx_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_entry rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -1820,9 +1820,9 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
 
-	volatile union iavf_rx_desc *rx_ring = rxq->rx_ring;
+	volatile union iavf_rx_desc *rx_ring = IAVF_RX_RING(rxq);
 	volatile union iavf_rx_desc *rxdp;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -1847,13 +1847,13 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rxd = *rxdp;
 		nb_hold++;
 		rxe = rxq->sw_ring[rx_id];
-		rxq->sw_ring[rx_id] = nmb;
+		rxq->sw_ring[rx_id].mbuf = nmb;
 		rx_id++;
 		if (rx_id == rxq->nb_rx_desc)
 			rx_id = 0;
 
 		/* Prefetch next mbuf */
-		rte_prefetch0(rxq->sw_ring[rx_id]);
+		rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 
 		/* When next RX descriptor is on a cache line boundary,
 		 * prefetch the next 4 RX descriptors and next 8 pointers
@@ -1861,10 +1861,10 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 */
 		if ((rx_id & 0x3) == 0) {
 			rte_prefetch0(&rx_ring[rx_id]);
-			rte_prefetch0(rxq->sw_ring[rx_id]);
+			rte_prefetch0(rxq->sw_ring[rx_id].mbuf);
 		}
 
-		rxm = rxe;
+		rxm = rxe.mbuf;
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(nmb));
 
@@ -1963,12 +1963,12 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 #define IAVF_LOOK_AHEAD 8
 static inline int
-iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
+iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
 			    struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts)
 {
 	volatile union iavf_rx_flex_desc *rxdp;
-	struct rte_mbuf **rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t stat_err0;
 	uint16_t pkt_len;
@@ -1976,10 +1976,10 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 	int32_t i, j, nb_rx = 0;
 	int32_t nb_staged = 0;
 	uint64_t pkt_flags;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 	uint64_t ts_ns;
 
-	rxdp = (volatile union iavf_rx_flex_desc *)&rxq->rx_ring[rxq->rx_tail];
+	rxdp = (volatile union iavf_rx_flex_desc *)IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
@@ -2038,7 +2038,7 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 					  rxq->rx_tail +
 					  i * IAVF_LOOK_AHEAD + j);
 
-			mb = rxep[j];
+			mb = rxep[j].mbuf;
 			pkt_len = (rte_le_to_cpu_16(rxdp[j].wb.pkt_len) &
 				IAVF_RX_FLX_DESC_PKT_LEN_M) - rxq->crc_len;
 			mb->data_len = pkt_len;
@@ -2072,11 +2072,11 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 
 			/* Put up to nb_pkts directly into buffers */
 			if ((i + j) < nb_pkts) {
-				rx_pkts[i + j] = rxep[j];
+				rx_pkts[i + j] = rxep[j].mbuf;
 				nb_rx++;
 			} else {
 				/* Stage excess pkts received */
-				rxq->rx_stage[nb_staged] = rxep[j];
+				rxq->rx_stage[nb_staged] = rxep[j].mbuf;
 				nb_staged++;
 			}
 		}
@@ -2090,16 +2090,16 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 
 	/* Clear software ring entries */
 	for (i = 0; i < (nb_rx + nb_staged); i++)
-		rxq->sw_ring[rxq->rx_tail + i] = NULL;
+		rxq->sw_ring[rxq->rx_tail + i].mbuf = NULL;
 
 	return nb_rx;
 }
 
 static inline int
-iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+iavf_rx_scan_hw_ring(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t pkt_len;
 	uint64_t qword1;
@@ -2108,9 +2108,9 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 	int32_t i, j, nb_rx = 0;
 	int32_t nb_staged = 0;
 	uint64_t pkt_flags;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
@@ -2164,7 +2164,7 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 			IAVF_DUMP_RX_DESC(rxq, &rxdp[j],
 					 rxq->rx_tail + i * IAVF_LOOK_AHEAD + j);
 
-			mb = rxep[j];
+			mb = rxep[j].mbuf;
 			qword1 = rte_le_to_cpu_64
 					(rxdp[j].wb.qword1.status_error_len);
 			pkt_len = ((qword1 & IAVF_RXD_QW1_LENGTH_PBUF_MASK) >>
@@ -2190,10 +2190,10 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 
 			/* Put up to nb_pkts directly into buffers */
 			if ((i + j) < nb_pkts) {
-				rx_pkts[i + j] = rxep[j];
+				rx_pkts[i + j] = rxep[j].mbuf;
 				nb_rx++;
 			} else { /* Stage excess pkts received */
-				rxq->rx_stage[nb_staged] = rxep[j];
+				rxq->rx_stage[nb_staged] = rxep[j].mbuf;
 				nb_staged++;
 			}
 		}
@@ -2207,13 +2207,13 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 
 	/* Clear software ring entries */
 	for (i = 0; i < (nb_rx + nb_staged); i++)
-		rxq->sw_ring[rxq->rx_tail + i] = NULL;
+		rxq->sw_ring[rxq->rx_tail + i].mbuf = NULL;
 
 	return nb_rx;
 }
 
 static inline uint16_t
-iavf_rx_fill_from_stage(struct iavf_rx_queue *rxq,
+iavf_rx_fill_from_stage(struct ci_rx_queue *rxq,
 		       struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts)
 {
@@ -2232,10 +2232,10 @@ iavf_rx_fill_from_stage(struct iavf_rx_queue *rxq,
 }
 
 static inline int
-iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
+iavf_rx_alloc_bufs(struct ci_rx_queue *rxq)
 {
 	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx, i;
 	uint64_t dma_addr;
@@ -2252,13 +2252,13 @@ iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
 		return -ENOMEM;
 	}
 
-	rxdp = &rxq->rx_ring[alloc_idx];
+	rxdp = IAVF_RX_RING_PTR(rxq, alloc_idx);
 	for (i = 0; i < rxq->rx_free_thresh; i++) {
 		if (likely(i < (rxq->rx_free_thresh - 1)))
 			/* Prefetch next mbuf */
-			rte_prefetch0(rxep[i + 1]);
+			rte_prefetch0(rxep[i + 1].mbuf);
 
-		mb = rxep[i];
+		mb = rxep[i].mbuf;
 		rte_mbuf_refcnt_set(mb, 1);
 		mb->next = NULL;
 		mb->data_off = RTE_PKTMBUF_HEADROOM;
@@ -2284,7 +2284,7 @@ iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
 static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = (struct iavf_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	uint16_t nb_rx = 0;
 
 	if (!nb_pkts)
@@ -2312,11 +2312,11 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
 			rxq->rx_tail = (uint16_t)(rxq->rx_tail - (nb_rx + nb_staged));
 			for (i = 0, j = rxq->rx_tail; i < nb_rx; i++, j++) {
-				rxq->sw_ring[j] = rx_pkts[i];
+				rxq->sw_ring[j].mbuf = rx_pkts[i];
 				rx_pkts[i] = NULL;
 			}
 			for (i = 0, j = rxq->rx_tail + nb_rx; i < nb_staged; i++, j++) {
-				rxq->sw_ring[j] = rxq->rx_stage[i];
+				rxq->sw_ring[j].mbuf = rxq->rx_stage[i];
 				rx_pkts[i] = NULL;
 			}
 
@@ -3843,13 +3843,13 @@ static uint16_t
 iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 				uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	enum iavf_rx_burst_type rx_burst_type;
 
-	if (!rxq->vsi || rxq->vsi->adapter->no_poll)
+	if (!rxq->iavf_vsi || rxq->iavf_vsi->adapter->no_poll)
 		return 0;
 
-	rx_burst_type = rxq->vsi->adapter->rx_burst_type;
+	rx_burst_type = rxq->iavf_vsi->adapter->rx_burst_type;
 
 	return iavf_rx_pkt_burst_ops[rx_burst_type].pkt_burst(rx_queue,
 								rx_pkts, nb_pkts);
@@ -3965,7 +3965,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	enum iavf_rx_burst_type rx_burst_type;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 	int i;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	bool use_flex = true;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -4379,7 +4379,7 @@ void
 iavf_dev_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		     struct rte_eth_rxq_info *qinfo)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -4414,11 +4414,11 @@ iavf_dev_rxq_count(void *rx_queue)
 {
 #define IAVF_RXQ_SCAN_INTERVAL 4
 	volatile union iavf_rx_desc *rxdp;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint16_t desc = 0;
 
 	rxq = rx_queue;
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	while ((desc < rxq->nb_rx_desc) &&
 	       ((rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len) &
@@ -4431,8 +4431,8 @@ iavf_dev_rxq_count(void *rx_queue)
 		desc += IAVF_RXQ_SCAN_INTERVAL;
 		rxdp += IAVF_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
-			rxdp = &(rxq->rx_ring[rxq->rx_tail +
-					desc - rxq->nb_rx_desc]);
+			rxdp = IAVF_RX_RING_PTR(rxq,
+					rxq->rx_tail + desc - rxq->nb_rx_desc);
 	}
 
 	return desc;
@@ -4441,7 +4441,7 @@ iavf_dev_rxq_count(void *rx_queue)
 int
 iavf_dev_rx_desc_status(void *rx_queue, uint16_t offset)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint64_t *status;
 	uint64_t mask;
 	uint32_t desc;
@@ -4456,7 +4456,7 @@ iavf_dev_rx_desc_status(void *rx_queue, uint16_t offset)
 	if (desc >= rxq->nb_rx_desc)
 		desc -= rxq->nb_rx_desc;
 
-	status = &rxq->rx_ring[desc].wb.qword1.status_error_len;
+	status = &IAVF_RX_RING_PTR(rxq, desc)->wb.qword1.status_error_len;
 	mask = rte_le_to_cpu_64((1ULL << IAVF_RX_DESC_STATUS_DD_SHIFT)
 		<< IAVF_RXD_QW1_STATUS_SHIFT);
 	if (*status & mask)
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 62b5a67c84..c43ddc3c2f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -17,7 +17,7 @@
 #define IAVF_RING_BASE_ALIGN      128
 
 /* used for Rx Bulk Allocate */
-#define IAVF_RX_MAX_BURST         32
+#define IAVF_RX_MAX_BURST         CI_RX_MAX_BURST
 
 /* Max data buffer size must be 16K - 128 bytes */
 #define IAVF_RX_MAX_DATA_BUF_SIZE (16 * 1024 - 128)
@@ -198,17 +198,24 @@ union iavf_32b_rx_flex_desc {
 #ifdef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 #define iavf_rx_desc iavf_16byte_rx_desc
 #define iavf_rx_flex_desc iavf_16b_rx_flex_desc
+#define IAVF_RX_RING(rxq) \
+	((rxq)->iavf_rx_16b_ring)
 #else
 #define iavf_rx_desc iavf_32byte_rx_desc
 #define iavf_rx_flex_desc iavf_32b_rx_flex_desc
+#define IAVF_RX_RING(rxq) \
+	((rxq)->iavf_rx_32b_ring)
 #endif
 
-typedef void (*iavf_rxd_to_pkt_fields_t)(struct iavf_rx_queue *rxq,
+#define IAVF_RX_RING_PTR(rxq, entry) \
+	(IAVF_RX_RING(rxq) + (entry))
+
+typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 				struct rte_mbuf *mb,
 				volatile union iavf_rx_flex_desc *rxdp);
 
 struct iavf_rxq_ops {
-	void (*release_mbufs)(struct iavf_rx_queue *rxq);
+	void (*release_mbufs)(struct ci_rx_queue *rxq);
 };
 
 struct iavf_txq_ops {
@@ -221,59 +228,6 @@ struct iavf_rx_queue_stats {
 	struct iavf_ipsec_crypto_stats ipsec_crypto;
 };
 
-/* Structure associated with each Rx queue. */
-struct iavf_rx_queue {
-	struct rte_mempool *mp;       /* mbuf pool to populate Rx ring */
-	const struct rte_memzone *mz; /* memzone for Rx ring */
-	volatile union iavf_rx_desc *rx_ring; /* Rx ring virtual address */
-	uint64_t rx_ring_phys_addr;   /* Rx ring DMA address */
-	struct rte_mbuf **sw_ring;     /* address of SW ring */
-	uint16_t nb_rx_desc;          /* ring length */
-	uint16_t rx_tail;             /* current value of tail */
-	volatile uint8_t *qrx_tail;   /* register address of tail */
-	uint16_t rx_free_thresh;      /* max free RX desc to hold */
-	uint16_t nb_rx_hold;          /* number of held free RX desc */
-	struct rte_mbuf *pkt_first_seg; /* first segment of current packet */
-	struct rte_mbuf *pkt_last_seg;  /* last segment of current packet */
-	struct rte_mbuf fake_mbuf;      /* dummy mbuf */
-	uint8_t rxdid;
-	uint8_t rel_mbufs_type;
-
-	/* used for VPMD */
-	uint16_t rxrearm_nb;       /* number of remaining to be re-armed */
-	uint16_t rxrearm_start;    /* the idx we start the re-arming from */
-	uint64_t mbuf_initializer; /* value to init mbufs */
-
-	/* for rx bulk */
-	uint16_t rx_nb_avail;      /* number of staged packets ready */
-	uint16_t rx_next_avail;    /* index of next staged packets */
-	uint16_t rx_free_trigger;  /* triggers rx buffer allocation */
-	struct rte_mbuf *rx_stage[IAVF_RX_MAX_BURST * 2]; /* store mbuf */
-
-	uint16_t port_id;        /* device port ID */
-	uint8_t crc_len;        /* 0 if CRC stripped, 4 otherwise */
-	uint8_t fdir_enabled;   /* 0 if FDIR disabled, 1 when enabled */
-	uint16_t queue_id;      /* Rx queue index */
-	uint16_t rx_buf_len;    /* The packet buffer size */
-	uint16_t rx_hdr_len;    /* The header buffer size */
-	uint16_t max_pkt_len;   /* Maximum packet length */
-	struct iavf_vsi *vsi; /**< the VSI this queue belongs to */
-
-	bool q_set;             /* if rx queue has been configured */
-	bool rx_deferred_start; /* don't start this queue in dev start */
-	const struct iavf_rxq_ops *ops;
-	uint8_t rx_flags;
-#define IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG1     BIT(0)
-#define IAVF_RX_FLAGS_VLAN_TAG_LOC_L2TAG2_2   BIT(1)
-	uint8_t proto_xtr; /* protocol extraction type */
-	uint64_t xtr_ol_flag;
-		/* flexible descriptor metadata extraction offload flag */
-	struct iavf_rx_queue_stats *stats;
-	uint64_t offloads;
-	uint64_t phc_time;
-	uint64_t hw_time_update;
-};
-
 /* Offload features */
 union iavf_tx_offload {
 	uint64_t data;
@@ -691,7 +645,7 @@ uint16_t iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pk
 int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
-int iavf_rxq_vec_setup(struct iavf_rx_queue *rxq);
+int iavf_rxq_vec_setup(struct ci_rx_queue *rxq);
 int iavf_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t iavf_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts);
@@ -731,12 +685,12 @@ uint8_t iavf_proto_xtr_type_to_rxdid(uint8_t xtr_type);
 
 void iavf_set_default_ptype_table(struct rte_eth_dev *dev);
 void iavf_tx_queue_release_mbufs_avx512(struct ci_tx_queue *txq);
-void iavf_rx_queue_release_mbufs_sse(struct iavf_rx_queue *rxq);
+void iavf_rx_queue_release_mbufs_sse(struct ci_rx_queue *rxq);
 void iavf_tx_queue_release_mbufs_sse(struct ci_tx_queue *txq);
-void iavf_rx_queue_release_mbufs_neon(struct iavf_rx_queue *rxq);
+void iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq);
 
 static inline
-void iavf_dump_rx_descriptor(struct iavf_rx_queue *rxq,
+void iavf_dump_rx_descriptor(struct ci_rx_queue *rxq,
 			    const volatile void *desc,
 			    uint16_t rx_id)
 {
@@ -794,7 +748,7 @@ void iavf_dump_tx_descriptor(const struct ci_tx_queue *txq,
 #define FDIR_PROC_ENABLE_PER_QUEUE(ad, on) do { \
 	int i; \
 	for (i = 0; i < (ad)->dev_data->nb_rx_queues; i++) { \
-		struct iavf_rx_queue *rxq = (ad)->dev_data->rx_queues[i]; \
+		struct ci_rx_queue *rxq = (ad)->dev_data->rx_queues[i]; \
 		if (!rxq) \
 			continue; \
 		rxq->fdir_enabled = on; \
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 88e35dc3e9..f51fa4acf9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -7,7 +7,7 @@
 #include <rte_vect.h>
 
 static __rte_always_inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	iavf_rxq_rearm_common(rxq, false);
 }
@@ -15,21 +15,19 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 #define PKTLEN_SHIFT     10
 
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq,
 			     struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts, uint8_t *split_packet,
 			     bool offload)
 {
 #define IAVF_DESCS_PER_LOOP_AVX 8
 
-	/* const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl; */
-	const uint32_t *type_table = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *type_table = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	/* struct iavf_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail]; */
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union iavf_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union iavf_rx_desc *rxdp = IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 
 	rte_prefetch0(rxdp);
@@ -487,14 +485,14 @@ flex_rxd_to_fdir_flags_vec_avx2(const __m256i fdir_id0_7)
 }
 
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 				      struct rte_mbuf **rx_pkts,
 				      uint16_t nb_pkts, uint8_t *split_packet,
 				      bool offload)
 {
 #define IAVF_DESCS_PER_LOOP_AVX 8
 
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 
 #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
@@ -503,9 +501,9 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union iavf_rx_flex_desc *rxdp =
-		(volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+		(volatile union iavf_rx_flex_desc *)IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -1476,7 +1474,7 @@ static __rte_always_inline uint16_t
 iavf_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 
 	/* get some new buffers */
@@ -1565,7 +1563,7 @@ iavf_recv_scattered_burst_vec_avx2_flex_rxd(void *rx_queue,
 					    struct rte_mbuf **rx_pkts,
 					    uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index f2af028bef..80495f33cd 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -28,26 +28,26 @@
 #define IAVF_RX_TS_OFFLOAD
 
 static __rte_always_inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	iavf_rxq_rearm_common(rxq, true);
 }
 
 #define IAVF_RX_LEN_MASK 0x80808080
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 			       struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts, uint8_t *split_packet,
 			       bool offload)
 {
 #ifdef IAVF_RX_PTYPE_OFFLOAD
-	const uint32_t *type_table = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *type_table = rxq->iavf_vsi->adapter->ptype_tbl;
 #endif
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0,
 						    rxq->mbuf_initializer);
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union iavf_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union iavf_rx_desc *rxdp = IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -578,13 +578,13 @@ flex_rxd_to_fdir_flags_vec_avx512(const __m256i fdir_id0_7)
 }
 
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct ci_rx_queue *rxq,
 					struct rte_mbuf **rx_pkts,
 					uint16_t nb_pkts,
 					uint8_t *split_packet,
 					bool offload)
 {
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #endif
@@ -594,9 +594,9 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0,
 						    rxq->mbuf_initializer);
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union iavf_rx_flex_desc *rxdp =
-		(volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+		(volatile union iavf_rx_flex_desc *)IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -1653,7 +1653,7 @@ static __rte_always_inline uint16_t
 iavf_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 
 	/* get some new buffers */
@@ -1729,7 +1729,7 @@ iavf_recv_scattered_burst_vec_avx512_flex_rxd(void *rx_queue,
 					      uint16_t nb_pkts,
 					      bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 38e9a206d9..f0a7d19b6a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -8,7 +8,6 @@
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 
-#include "../common/rx.h"
 #include "iavf.h"
 #include "iavf_rxtx.h"
 
@@ -21,7 +20,7 @@ iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 }
 
 static inline void
-_iavf_rx_queue_release_mbufs_vec(struct iavf_rx_queue *rxq)
+_iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	const unsigned int mask = rxq->nb_rx_desc - 1;
 	unsigned int i;
@@ -32,15 +31,15 @@ _iavf_rx_queue_release_mbufs_vec(struct iavf_rx_queue *rxq)
 	/* free all mbufs that are valid in the ring */
 	if (rxq->rxrearm_nb == 0) {
 		for (i = 0; i < rxq->nb_rx_desc; i++) {
-			if (rxq->sw_ring[i])
-				rte_pktmbuf_free_seg(rxq->sw_ring[i]);
+			if (rxq->sw_ring[i].mbuf)
+				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
 		}
 	} else {
 		for (i = rxq->rx_tail;
 		     i != rxq->rxrearm_start;
 		     i = (i + 1) & mask) {
-			if (rxq->sw_ring[i])
-				rte_pktmbuf_free_seg(rxq->sw_ring[i]);
+			if (rxq->sw_ring[i].mbuf)
+				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
 		}
 	}
 
@@ -51,7 +50,7 @@ _iavf_rx_queue_release_mbufs_vec(struct iavf_rx_queue *rxq)
 }
 
 static inline int
-iavf_rx_vec_queue_default(struct iavf_rx_queue *rxq)
+iavf_rx_vec_queue_default(struct ci_rx_queue *rxq)
 {
 	if (!rxq)
 		return -1;
@@ -117,7 +116,7 @@ static inline int
 iavf_rx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int ret;
 	int result = 0;
 
@@ -240,14 +239,14 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 
 #ifdef RTE_ARCH_X86
 static __rte_always_inline void
-iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
+iavf_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = IAVF_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
@@ -259,7 +258,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 
 			dma_addr0 = _mm_setzero_si128();
 			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i] = &rxq->fake_mbuf;
+				rxp[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
@@ -278,8 +277,8 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 	for (i = 0; i < IAVF_RXQ_REARM_THRESH; i += 2, rxp += 2) {
 		__m128i vaddr0, vaddr1;
 
-		mb0 = rxp[0];
-		mb1 = rxp[1];
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
 
 		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
 		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index a583340f15..e1c8f3c7f9 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -15,7 +15,7 @@
 #include "iavf_rxtx_vec_common.h"
 
 static inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
@@ -75,7 +75,7 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 }
 
 static inline void
-desc_to_olflags_v(struct iavf_rx_queue *rxq, volatile union iavf_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union iavf_rx_desc *rxdp,
 		  uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
 {
 	RTE_SET_USED(rxdp);
@@ -193,7 +193,7 @@ desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct iavf_rx_queue *__rte_restrict rxq,
+_recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   struct rte_mbuf **__rte_restrict rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
@@ -203,7 +203,7 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *__rte_restrict rxq,
 	struct rte_mbuf **sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	/* mask to shuffle from desc. to mbuf */
 	uint8x16_t shuf_msk = {
@@ -394,13 +394,13 @@ iavf_recv_pkts_vec(void *__rte_restrict rx_queue,
 }
 
 void __rte_cold
-iavf_rx_queue_release_mbufs_neon(struct iavf_rx_queue *rxq)
+iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq)
 {
 	_iavf_rx_queue_release_mbufs_vec(rxq);
 }
 
 int __rte_cold
-iavf_rxq_vec_setup(struct iavf_rx_queue *rxq)
+iavf_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->rel_mbufs_type = IAVF_REL_MBUFS_NEON_VEC;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index 2e41079e88..f18dfd636c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -13,19 +13,19 @@
 #include <rte_vect.h>
 
 static inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 
 	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
 	__m128i dma_addr0, dma_addr1;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = IAVF_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp, (void *)rxp,
@@ -33,7 +33,7 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 		if (rxq->rxrearm_nb + rxq->rx_free_thresh >= rxq->nb_rx_desc) {
 			dma_addr0 = _mm_setzero_si128();
 			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i] = &rxq->fake_mbuf;
+				rxp[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
@@ -47,8 +47,8 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 	for (i = 0; i < rxq->rx_free_thresh; i += 2, rxp += 2) {
 		__m128i vaddr0, vaddr1;
 
-		mb0 = rxp[0];
-		mb1 = rxp[1];
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
 
 		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
 		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
@@ -88,7 +88,7 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 }
 
 static inline void
-desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
+desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4],
 		  struct rte_mbuf **rx_pkts)
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
@@ -206,11 +206,11 @@ flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 
 #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 static inline void
-flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
+flex_desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
 		       struct rte_mbuf **rx_pkts)
 #else
 static inline void
-flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4],
+flex_desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4],
 		       struct rte_mbuf **rx_pkts)
 #endif
 {
@@ -466,16 +466,16 @@ flex_desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__m128i shuf_msk;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	__m128i crc_adjust = _mm_set_epi16(
 				0, 0, 0,    /* ignore non-length fields */
@@ -500,7 +500,7 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -571,7 +571,7 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 #endif
 
 		/* B.1 load 2 (64 bit) or 4 (32 bit) mbuf points */
-		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos]);
+		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos].mbuf);
 		/* Read desc statuses backwards to avoid race condition */
 		/* A.1 load desc[3] */
 		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
@@ -714,16 +714,16 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
+_recv_raw_pkts_vec_flex_rxd(struct ci_rx_queue *rxq,
 			    struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union iavf_rx_flex_desc *rxdp;
-	struct rte_mbuf **sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 #ifndef RTE_LIBRTE_IAVF_16BYTE_RX_DESC
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #endif
@@ -779,7 +779,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = (volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+	rxdp = (volatile union iavf_rx_flex_desc *)IAVF_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -857,7 +857,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 #endif
 
 		/* B.1 load 2 (64 bit) or 4 (32 bit) mbuf points */
-		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos]);
+		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos].mbuf);
 		/* Read desc statuses backwards to avoid race condition */
 		/* A.1 load desc[3] */
 		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
@@ -1207,7 +1207,7 @@ static uint16_t
 iavf_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 	unsigned int i = 0;
 
@@ -1276,7 +1276,7 @@ iavf_recv_scattered_burst_vec_flex_rxd(void *rx_queue,
 				       struct rte_mbuf **rx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
 	unsigned int i = 0;
 
@@ -1449,7 +1449,7 @@ iavf_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-iavf_rx_queue_release_mbufs_sse(struct iavf_rx_queue *rxq)
+iavf_rx_queue_release_mbufs_sse(struct ci_rx_queue *rxq)
 {
 	_iavf_rx_queue_release_mbufs_vec(rxq);
 }
@@ -1462,7 +1462,7 @@ iavf_txq_vec_setup(struct ci_tx_queue *txq)
 }
 
 int __rte_cold
-iavf_rxq_vec_setup(struct iavf_rx_queue *rxq)
+iavf_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->rel_mbufs_type = IAVF_REL_MBUFS_SSE_VEC;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 6feca8435e..9f8bb07726 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1218,7 +1218,7 @@ int
 iavf_configure_queues(struct iavf_adapter *adapter,
 		uint16_t num_queue_pairs, uint16_t index)
 {
-	struct iavf_rx_queue **rxq = (struct iavf_rx_queue **)adapter->dev_data->rx_queues;
+	struct ci_rx_queue **rxq = (struct ci_rx_queue **)adapter->dev_data->rx_queues;
 	struct ci_tx_queue **txq = (struct ci_tx_queue **)adapter->dev_data->tx_queues;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vsi_queue_config_info *vc_config;
@@ -2258,9 +2258,9 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 }
 
 int
-iavf_get_phc_time(struct iavf_rx_queue *rxq)
+iavf_get_phc_time(struct ci_rx_queue *rxq)
 {
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_phc_time phc_time;
 	struct iavf_cmd_info args;
-- 
2.47.1

