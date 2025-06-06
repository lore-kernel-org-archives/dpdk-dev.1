Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79AC61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4E8540B95;
	Fri,  6 Jun 2025 19:16:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id D513A40B95
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749230196; x=1780766196;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Aa7zYRVN5hJzy++pNVKpHzy4ioZfCrdzM5KX1CMuBr8=;
 b=nQTTENV0exZNUxJ/wjh5uXjNA6uP2B6itx17AnzPiEIC+UgdWE+p8/7p
 i5grw6k6DKP6NytavyrKreffAHfHX5ewIeEJdNSu3t/qQwvSB0gDtfjTJ
 KysAuuKD3IklNbde7iw86cIe8SUv4wQ0EHbmdXza42Oev2P/MNLGNwfH/
 4OewHBURwH3R+yF5/rAFpYZWjFpdulEq1wzmWb1Mm7U6dtRWH1SqX4weR
 8zR19K54kX47WvRgM8t0Pwa5Pql3r1jbQNzsBr7kdBg3MVjIuxcvWSNNQ
 kfwu6vvvPnTZJXZv7IiIVE1bdVgNxXTy6swBId6tnNrsb+hnK12uR9j/e A==;
X-CSE-ConnectionGUID: LQaQ46B6TneouwVJazKLSg==
X-CSE-MsgGUID: 23jCz1yyQQCItbbBDcb4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68829338"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68829338"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:16:35 -0700
X-CSE-ConnectionGUID: zJ+3ApSPRwK3q6NChW2zqg==
X-CSE-MsgGUID: enHI+9nAS/ygGZ5JLmSJ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="183076997"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa001.jf.intel.com with ESMTP; 06 Jun 2025 10:16:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v5 27/34] net/iavf: use the common Rx queue structure
Date: Fri,  6 Jun 2025 18:16:31 +0100
Message-ID: <56c4e91c66a52e20bba0c9e456276fe18cab02b5.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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

The iavf driver only supports 32-byte descriptors but they are of a common
format, so replace all usages of iavf-specific descriptors with the
common ones, and force the common queue structure to only use 32-byte
descriptor formats for IAVF driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Force to always use 32-byte descriptor format
    
    v3 -> v4:
    - Use the common descriptor format
    
    v2:
    - Fix compile issues for Arm

 drivers/net/intel/common/rx.h                 |  10 +
 drivers/net/intel/iavf/iavf.h                 |   4 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  11 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 228 +++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h            | 129 ++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  26 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  23 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  27 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  30 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  46 ++--
 drivers/net/intel/iavf/iavf_vchnl.c           |   6 +-
 11 files changed, 222 insertions(+), 318 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index c60d84e447..3e3fea76a7 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -79,6 +79,7 @@ struct ci_rx_queue {
 	union { /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct ice_vsi *ice_vsi;
+		struct iavf_vsi *iavf_vsi;
 	};
 	const struct rte_memzone *mz;
 	union {
@@ -108,6 +109,15 @@ struct ci_rx_queue {
 			int ts_offset; /* dynamic mbuf timestamp field offset */
 			uint64_t ts_flag; /* dynamic mbuf timestamp flag */
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
index 5babd587b3..02649c19b2 100644
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
@@ -779,8 +779,7 @@ iavf_init_rxq(struct rte_eth_dev *dev, struct iavf_rx_queue *rxq)
 static int
 iavf_init_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue **rxq =
-		(struct iavf_rx_queue **)dev->data->rx_queues;
+	struct ci_rx_queue **rxq = (struct ci_rx_queue **)dev->data->rx_queues;
 	int i, ret = IAVF_SUCCESS;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -955,7 +954,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 static int
 iavf_start_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int i;
 	uint16_t nb_txq, nb_rxq;
@@ -1867,9 +1866,9 @@ iavf_dev_update_ipsec_xstats(struct rte_eth_dev *ethdev,
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
index 5c798f2b6e..7033a74610 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -128,8 +128,8 @@ iavf_monitor_callback(const uint64_t value,
 int
 iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
-	volatile union iavf_rx_desc *rxdp;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ci_rx_desc *rxdp;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
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
@@ -253,13 +253,13 @@ reset_rx_queue(struct iavf_rx_queue *rxq)
 
 	len = rxq->nb_rx_desc + IAVF_RX_MAX_BURST;
 
-	for (i = 0; i < len * sizeof(union iavf_rx_desc); i++)
+	for (i = 0; i < len * sizeof(union ci_rx_desc); i++)
 		((volatile char *)rxq->rx_ring)[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
 
 	for (i = 0; i < IAVF_RX_MAX_BURST; i++)
-		rxq->sw_ring[rxq->nb_rx_desc + i] = &rxq->fake_mbuf;
+		rxq->sw_ring[rxq->nb_rx_desc + i].mbuf = &rxq->fake_mbuf;
 
 	/* for rx bulk */
 	rxq->rx_nb_avail = 0;
@@ -315,9 +315,9 @@ reset_tx_queue(struct ci_tx_queue *txq)
 }
 
 static int
-alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
+alloc_rxq_mbufs(struct ci_rx_queue *rxq)
 {
-	volatile union iavf_rx_desc *rxd;
+	volatile union ci_rx_desc *rxd;
 	struct rte_mbuf *mbuf = NULL;
 	uint64_t dma_addr;
 	uint16_t i, j;
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
@@ -348,14 +348,14 @@ alloc_rxq_mbufs(struct iavf_rx_queue *rxq)
 		rxd->read.rsvd1 = 0;
 		rxd->read.rsvd2 = 0;
 
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
 
@@ -363,9 +363,9 @@ release_rxq_mbufs(struct iavf_rx_queue *rxq)
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
 
@@ -393,9 +393,9 @@ struct iavf_rxq_ops iavf_rxq_release_mbufs_ops[] = {
 };
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ci_rx_queue *rxq,
 				    struct rte_mbuf *mb,
-				    volatile union iavf_rx_flex_desc *rxdp)
+				    volatile union ci_rx_flex_desc *rxdp)
 {
 	volatile struct iavf_32b_rx_flex_desc_comms_ovs *desc =
 			(volatile struct iavf_32b_rx_flex_desc_comms_ovs *)rxdp;
@@ -414,9 +414,9 @@ iavf_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct iavf_rx_queue *rxq,
 }
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct ci_rx_queue *rxq,
 				       struct rte_mbuf *mb,
-				       volatile union iavf_rx_flex_desc *rxdp)
+				       volatile union ci_rx_flex_desc *rxdp)
 {
 	volatile struct iavf_32b_rx_flex_desc_comms *desc =
 			(volatile struct iavf_32b_rx_flex_desc_comms *)rxdp;
@@ -454,9 +454,9 @@ iavf_rxd_to_pkt_fields_by_comms_aux_v1(struct iavf_rx_queue *rxq,
 }
 
 static inline void
-iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct iavf_rx_queue *rxq,
+iavf_rxd_to_pkt_fields_by_comms_aux_v2(struct ci_rx_queue *rxq,
 				       struct rte_mbuf *mb,
-				       volatile union iavf_rx_flex_desc *rxdp)
+				       volatile union ci_rx_flex_desc *rxdp)
 {
 	volatile struct iavf_32b_rx_flex_desc_comms *desc =
 			(volatile struct iavf_32b_rx_flex_desc_comms *)rxdp;
@@ -507,7 +507,7 @@ iavf_rxd_to_pkt_fields_t rxd_to_pkt_fields_ops[IAVF_RXDID_LAST + 1] = {
 };
 
 static void
-iavf_select_rxd_to_pkt_fields_handler(struct iavf_rx_queue *rxq, uint32_t rxdid)
+iavf_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq, uint32_t rxdid)
 {
 	rxq->rxdid = rxdid;
 
@@ -562,7 +562,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct iavf_info *vf =
 		IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_vsi *vsi = &vf->vsi;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *mz;
 	uint32_t ring_size;
 	uint8_t proto_xtr;
@@ -600,7 +600,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket("iavf rxq",
-				 sizeof(struct iavf_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 	if (!rxq) {
@@ -658,7 +658,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	rxq->port_id = dev->data->port_id;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->rx_hdr_len = 0;
-	rxq->vsi = vsi;
+	rxq->iavf_vsi = vsi;
 	rxq->offloads = offloads;
 
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
@@ -688,7 +688,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 * a little more to support bulk allocate.
 	 */
 	len = IAVF_MAX_RING_DESC + IAVF_RX_MAX_BURST;
-	ring_size = RTE_ALIGN(len * sizeof(union iavf_rx_desc),
+	ring_size = RTE_ALIGN(len * sizeof(union ci_rx_desc),
 			      IAVF_DMA_MEM_ALIGN);
 	mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
 				      ring_size, IAVF_RING_BASE_ALIGN,
@@ -703,7 +703,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	/* Zero all the descriptors in the ring. */
 	memset(mz->addr, 0, ring_size);
 	rxq->rx_ring_phys_addr = mz->iova;
-	rxq->rx_ring = (union iavf_rx_desc *)mz->addr;
+	rxq->rx_ring = (union ci_rx_desc *)mz->addr;
 
 	rxq->mz = mz;
 	reset_rx_queue(rxq);
@@ -895,7 +895,7 @@ iavf_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err = 0;
 
 	PMD_DRV_FUNC_TRACE();
@@ -987,7 +987,7 @@ iavf_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 
 	PMD_DRV_FUNC_TRACE();
@@ -1050,7 +1050,7 @@ iavf_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 void
 iavf_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
-	struct iavf_rx_queue *q = dev->data->rx_queues[qid];
+	struct ci_rx_queue *q = dev->data->rx_queues[qid];
 
 	if (!q)
 		return;
@@ -1079,7 +1079,7 @@ iavf_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 static void
 iavf_reset_queues(struct rte_eth_dev *dev)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int i;
 
@@ -1141,7 +1141,7 @@ iavf_stop_queues(struct rte_eth_dev *dev)
 	 (1 << IAVF_RX_FLEX_DESC_STATUS0_RXE_S))
 
 static inline void
-iavf_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union iavf_rx_desc *rxdp)
+iavf_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ci_rx_desc *rxdp)
 {
 	if (rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len) &
 		(1 << IAVF_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
@@ -1155,7 +1155,7 @@ iavf_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union iavf_rx_desc *rxdp)
 
 static inline void
 iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
-			  volatile union iavf_rx_flex_desc *rxdp)
+			  volatile union ci_rx_flex_desc *rxdp)
 {
 	if (rte_le_to_cpu_64(rxdp->wb.status_error0) &
 		(1 << IAVF_RX_FLEX_DESC_STATUS0_L2TAG1P_S)) {
@@ -1185,7 +1185,7 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
 
 static inline void
 iavf_flex_rxd_to_ipsec_crypto_said_get(struct rte_mbuf *mb,
-			  volatile union iavf_rx_flex_desc *rxdp)
+			  volatile union ci_rx_flex_desc *rxdp)
 {
 	volatile struct iavf_32b_rx_flex_desc_comms_ipsec *desc =
 		(volatile struct iavf_32b_rx_flex_desc_comms_ipsec *)rxdp;
@@ -1196,7 +1196,7 @@ iavf_flex_rxd_to_ipsec_crypto_said_get(struct rte_mbuf *mb,
 
 static inline void
 iavf_flex_rxd_to_ipsec_crypto_status(struct rte_mbuf *mb,
-			  volatile union iavf_rx_flex_desc *rxdp,
+			  volatile union ci_rx_flex_desc *rxdp,
 			  struct iavf_ipsec_crypto_stats *stats)
 {
 	uint16_t status1 = rte_le_to_cpu_64(rxdp->wb.status_error1);
@@ -1286,7 +1286,7 @@ iavf_rxd_to_pkt_flags(uint64_t qword)
 }
 
 static inline uint64_t
-iavf_rxd_build_fdir(volatile union iavf_rx_desc *rxdp, struct rte_mbuf *mb)
+iavf_rxd_build_fdir(volatile union ci_rx_desc *rxdp, struct rte_mbuf *mb)
 {
 	uint64_t flags = 0;
 	uint16_t flexbh;
@@ -1357,7 +1357,7 @@ iavf_flex_rxd_error_to_pkt_flags(uint16_t stat_err0)
  * from the hardware point of view.
  */
 static inline void
-iavf_update_rx_tail(struct iavf_rx_queue *rxq, uint16_t nb_hold, uint16_t rx_id)
+iavf_update_rx_tail(struct ci_rx_queue *rxq, uint16_t nb_hold, uint16_t rx_id)
 {
 	nb_hold = (uint16_t)(nb_hold + rxq->nb_rx_hold);
 
@@ -1377,11 +1377,11 @@ iavf_update_rx_tail(struct iavf_rx_queue *rxq, uint16_t nb_hold, uint16_t rx_id)
 uint16_t
 iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	volatile union iavf_rx_desc *rx_ring;
-	volatile union iavf_rx_desc *rxdp;
-	struct iavf_rx_queue *rxq;
-	union iavf_rx_desc rxd;
-	struct rte_mbuf *rxe;
+	volatile union ci_rx_desc *rx_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_queue *rxq;
+	union ci_rx_desc rxd;
+	struct ci_rx_entry rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -1399,7 +1399,7 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
 	rx_ring = rxq->rx_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -1424,13 +1424,13 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
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
@@ -1438,9 +1438,9 @@ iavf_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
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
@@ -1486,11 +1486,11 @@ uint16_t
 iavf_recv_pkts_flex_rxd(void *rx_queue,
 			struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	volatile union iavf_rx_desc *rx_ring;
-	volatile union iavf_rx_flex_desc *rxdp;
-	struct iavf_rx_queue *rxq;
-	union iavf_rx_flex_desc rxd;
-	struct rte_mbuf *rxe;
+	volatile union ci_rx_flex_desc *rx_ring;
+	volatile union ci_rx_flex_desc *rxdp;
+	struct ci_rx_queue *rxq;
+	union ci_rx_flex_desc rxd;
+	struct ci_rx_entry rxe;
 	struct rte_eth_dev *dev;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
@@ -1507,8 +1507,8 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
-	ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	rx_ring = rxq->rx_flex_ring;
+	ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -1521,7 +1521,7 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
 	}
 
 	while (nb_rx < nb_pkts) {
-		rxdp = (volatile union iavf_rx_flex_desc *)&rx_ring[rx_id];
+		rxdp = &rx_ring[rx_id];
 		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
 
 		/* Check the DD bit first */
@@ -1541,13 +1541,13 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
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
@@ -1555,9 +1555,9 @@ iavf_recv_pkts_flex_rxd(void *rx_queue,
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
@@ -1611,9 +1611,9 @@ uint16_t
 iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 				  uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
-	union iavf_rx_flex_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_queue *rxq = rx_queue;
+	union ci_rx_flex_desc rxd;
+	struct ci_rx_entry rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -1625,9 +1625,9 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint64_t pkt_flags;
 	uint64_t ts_ns;
 
-	volatile union iavf_rx_desc *rx_ring = rxq->rx_ring;
-	volatile union iavf_rx_flex_desc *rxdp;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	volatile union ci_rx_flex_desc *rx_ring = rxq->rx_flex_ring;
+	volatile union ci_rx_flex_desc *rxdp;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -1640,7 +1640,7 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
 	}
 
 	while (nb_rx < nb_pkts) {
-		rxdp = (volatile union iavf_rx_flex_desc *)&rx_ring[rx_id];
+		rxdp = &rx_ring[rx_id];
 		rx_stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
 
 		/* Check the DD bit */
@@ -1660,13 +1660,13 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
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
@@ -1674,10 +1674,10 @@ iavf_recv_scattered_pkts_flex_rxd(void *rx_queue, struct rte_mbuf **rx_pkts,
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
 
@@ -1788,9 +1788,9 @@ uint16_t
 iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
-	union iavf_rx_desc rxd;
-	struct rte_mbuf *rxe;
+	struct ci_rx_queue *rxq = rx_queue;
+	union ci_rx_desc rxd;
+	struct ci_rx_entry rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb, *rxm;
@@ -1802,9 +1802,9 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
 
-	volatile union iavf_rx_desc *rx_ring = rxq->rx_ring;
-	volatile union iavf_rx_desc *rxdp;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	volatile union ci_rx_desc *rx_ring = rxq->rx_ring;
+	volatile union ci_rx_desc *rxdp;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -1829,13 +1829,13 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
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
@@ -1843,10 +1843,10 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
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
 
@@ -1945,12 +1945,12 @@ iavf_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 #define IAVF_LOOK_AHEAD 8
 static inline int
-iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
+iavf_rx_scan_hw_ring_flex_rxd(struct ci_rx_queue *rxq,
 			    struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts)
 {
-	volatile union iavf_rx_flex_desc *rxdp;
-	struct rte_mbuf **rxep;
+	volatile union ci_rx_flex_desc *rxdp;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t stat_err0;
 	uint16_t pkt_len;
@@ -1958,10 +1958,10 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 	int32_t i, j, nb_rx = 0;
 	int32_t nb_staged = 0;
 	uint64_t pkt_flags;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 	uint64_t ts_ns;
 
-	rxdp = (volatile union iavf_rx_flex_desc *)&rxq->rx_ring[rxq->rx_tail];
+	rxdp = &rxq->rx_flex_ring[rxq->rx_tail];
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
@@ -2020,7 +2020,7 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 					  rxq->rx_tail +
 					  i * IAVF_LOOK_AHEAD + j);
 
-			mb = rxep[j];
+			mb = rxep[j].mbuf;
 			pkt_len = (rte_le_to_cpu_16(rxdp[j].wb.pkt_len) &
 				IAVF_RX_FLX_DESC_PKT_LEN_M) - rxq->crc_len;
 			mb->data_len = pkt_len;
@@ -2054,11 +2054,11 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 
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
@@ -2072,16 +2072,16 @@ iavf_rx_scan_hw_ring_flex_rxd(struct iavf_rx_queue *rxq,
 
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
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxep;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t pkt_len;
 	uint64_t qword1;
@@ -2090,7 +2090,7 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 	int32_t i, j, nb_rx = 0;
 	int32_t nb_staged = 0;
 	uint64_t pkt_flags;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	rxdp = &rxq->rx_ring[rxq->rx_tail];
 	rxep = &rxq->sw_ring[rxq->rx_tail];
@@ -2146,7 +2146,7 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 			IAVF_DUMP_RX_DESC(rxq, &rxdp[j],
 					 rxq->rx_tail + i * IAVF_LOOK_AHEAD + j);
 
-			mb = rxep[j];
+			mb = rxep[j].mbuf;
 			qword1 = rte_le_to_cpu_64
 					(rxdp[j].wb.qword1.status_error_len);
 			pkt_len = ((qword1 & IAVF_RXD_QW1_LENGTH_PBUF_MASK) >>
@@ -2172,10 +2172,10 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 
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
@@ -2189,13 +2189,13 @@ iavf_rx_scan_hw_ring(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts, uint1
 
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
@@ -2214,10 +2214,10 @@ iavf_rx_fill_from_stage(struct iavf_rx_queue *rxq,
 }
 
 static inline int
-iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
+iavf_rx_alloc_bufs(struct ci_rx_queue *rxq)
 {
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxep;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx, i;
 	uint64_t dma_addr;
@@ -2238,9 +2238,9 @@ iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
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
@@ -2266,7 +2266,7 @@ iavf_rx_alloc_bufs(struct iavf_rx_queue *rxq)
 static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = (struct iavf_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	uint16_t nb_rx = 0;
 
 	if (!nb_pkts)
@@ -2294,11 +2294,11 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 
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
 
@@ -3825,13 +3825,13 @@ static uint16_t
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
@@ -3947,7 +3947,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	enum iavf_rx_burst_type rx_burst_type;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 	int i;
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	bool use_flex = true;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -4361,7 +4361,7 @@ void
 iavf_dev_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		     struct rte_eth_rxq_info *qinfo)
 {
-	struct iavf_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -4395,8 +4395,8 @@ uint32_t
 iavf_dev_rxq_count(void *rx_queue)
 {
 #define IAVF_RXQ_SCAN_INTERVAL 4
-	volatile union iavf_rx_desc *rxdp;
-	struct iavf_rx_queue *rxq;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_queue *rxq;
 	uint16_t desc = 0;
 
 	rxq = rx_queue;
@@ -4423,7 +4423,7 @@ iavf_dev_rxq_count(void *rx_queue)
 int
 iavf_dev_rx_desc_status(void *rx_queue, uint16_t offset)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint64_t *status;
 	uint64_t mask;
 	uint32_t desc;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 258103e222..8abcccf8c2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -5,6 +5,11 @@
 #ifndef _IAVF_RXTX_H_
 #define _IAVF_RXTX_H_
 
+/* IAVF does not support 16-byte descriptors */
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
+#undef RTE_NET_INTEL_USE_16BYTE_DESC
+#endif
+
 #include "../common/rx.h"
 #include "../common/tx.h"
 
@@ -17,7 +22,7 @@
 #define IAVF_RING_BASE_ALIGN      128
 
 /* used for Rx Bulk Allocate */
-#define IAVF_RX_MAX_BURST         32
+#define IAVF_RX_MAX_BURST         CI_RX_MAX_BURST
 
 /* Max data buffer size must be 16K - 128 bytes */
 #define IAVF_RX_MAX_DATA_BUF_SIZE (16 * 1024 - 128)
@@ -123,63 +128,12 @@ extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
 extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
 
-/**
- * Rx Flex Descriptors
- * These descriptors are used instead of the legacy version descriptors
- */
-union iavf_32b_rx_flex_desc {
-	struct {
-		__le64 pkt_addr; /* Packet buffer address */
-		__le64 hdr_addr; /* Header buffer address */
-				 /* bit 0 of hdr_addr is DD bit */
-		__le64 rsvd1;
-		__le64 rsvd2;
-	} read;
-	struct {
-		/* Qword 0 */
-		u8 rxdid; /* descriptor builder profile ID */
-		u8 mir_id_umb_cast; /* mirror=[5:0], umb=[7:6] */
-		__le16 ptype_flex_flags0; /* ptype=[9:0], ff0=[15:10] */
-		__le16 pkt_len; /* [15:14] are reserved */
-		__le16 hdr_len_sph_flex_flags1; /* header=[10:0] */
-						/* sph=[11:11] */
-						/* ff1/ext=[15:12] */
-
-		/* Qword 1 */
-		__le16 status_error0;
-		__le16 l2tag1;
-		__le16 flex_meta0;
-		__le16 flex_meta1;
-
-		/* Qword 2 */
-		__le16 status_error1;
-		u8 flex_flags2;
-		u8 time_stamp_low;
-		__le16 l2tag2_1st;
-		__le16 l2tag2_2nd;
-
-		/* Qword 3 */
-		__le16 flex_meta2;
-		__le16 flex_meta3;
-		union {
-			struct {
-				__le16 flex_meta4;
-				__le16 flex_meta5;
-			} flex;
-			__le32 ts_high;
-		} flex_ts;
-	} wb; /* writeback */
-};
-
-#define iavf_rx_desc iavf_32byte_rx_desc
-#define iavf_rx_flex_desc iavf_32b_rx_flex_desc
-
-typedef void (*iavf_rxd_to_pkt_fields_t)(struct iavf_rx_queue *rxq,
+typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 				struct rte_mbuf *mb,
-				volatile union iavf_rx_flex_desc *rxdp);
+				volatile union ci_rx_flex_desc *rxdp);
 
 struct iavf_rxq_ops {
-	void (*release_mbufs)(struct iavf_rx_queue *rxq);
+	void (*release_mbufs)(struct ci_rx_queue *rxq);
 };
 
 struct iavf_txq_ops {
@@ -192,59 +146,6 @@ struct iavf_rx_queue_stats {
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
@@ -662,7 +563,7 @@ uint16_t iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pk
 int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
 int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
-int iavf_rxq_vec_setup(struct iavf_rx_queue *rxq);
+int iavf_rxq_vec_setup(struct ci_rx_queue *rxq);
 int iavf_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t iavf_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts);
@@ -702,16 +603,16 @@ uint8_t iavf_proto_xtr_type_to_rxdid(uint8_t xtr_type);
 
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
-	const volatile union iavf_32byte_rx_desc *rx_desc = desc;
+	const volatile union ci_rx_desc *rx_desc = desc;
 
 	printf("Queue %d Rx_desc %d: QW0: 0x%016"PRIx64" QW1: 0x%016"PRIx64
 	       " QW2: 0x%016"PRIx64" QW3: 0x%016"PRIx64"\n", rxq->queue_id,
@@ -757,7 +658,7 @@ void iavf_dump_tx_descriptor(const struct ci_tx_queue *txq,
 #define FDIR_PROC_ENABLE_PER_QUEUE(ad, on) do { \
 	int i; \
 	for (i = 0; i < (ad)->dev_data->nb_rx_queues; i++) { \
-		struct iavf_rx_queue *rxq = (ad)->dev_data->rx_queues[i]; \
+		struct ci_rx_queue *rxq = (ad)->dev_data->rx_queues[i]; \
 		if (!rxq) \
 			continue; \
 		rxq->fdir_enabled = on; \
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index b4fe77a98b..b0f36cb515 100644
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
@@ -15,19 +15,16 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 #define PKTLEN_SHIFT     10
 
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq,
 			     struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts, uint8_t *split_packet,
 			     bool offload)
 {
-	/* const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl; */
-	const uint32_t *type_table = rxq->vsi->adapter->ptype_tbl;
-
+	const uint32_t *type_table = rxq->iavf_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	/* struct iavf_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail]; */
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union iavf_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ci_rx_desc *rxdp = &rxq->rx_ring[rxq->rx_tail];
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 
 	rte_prefetch0(rxdp);
@@ -485,20 +482,19 @@ flex_rxd_to_fdir_flags_vec_avx2(const __m256i fdir_id0_7)
 }
 
 static __rte_always_inline uint16_t
-_iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
+_iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct ci_rx_queue *rxq,
 				      struct rte_mbuf **rx_pkts,
 				      uint16_t nb_pkts, uint8_t *split_packet,
 				      bool offload)
 {
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 	const uint32_t *type_table = adapter->ptype_tbl;
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union iavf_rx_flex_desc *rxdp =
-		(volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ci_rx_flex_desc *rxdp = rxq->rx_flex_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -1461,7 +1457,7 @@ static __rte_always_inline uint16_t
 iavf_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -1550,7 +1546,7 @@ iavf_recv_scattered_burst_vec_avx2_flex_rxd(void *rx_queue,
 					    struct rte_mbuf **rx_pkts,
 					    uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 6eac24baf5..bbba564329 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -27,26 +27,26 @@
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
+	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -577,13 +577,13 @@ flex_rxd_to_fdir_flags_vec_avx512(const __m256i fdir_id0_7)
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
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 #ifdef IAVF_RX_PTYPE_OFFLOAD
 	const uint32_t *type_table = adapter->ptype_tbl;
@@ -591,9 +591,8 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0,
 						    rxq->mbuf_initializer);
-	struct rte_mbuf **sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union iavf_rx_flex_desc *rxdp =
-		(volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ci_rx_flex_desc *rxdp = rxq->rx_flex_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -1642,7 +1641,7 @@ static __rte_always_inline uint16_t
 iavf_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts, bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -1718,7 +1717,7 @@ iavf_recv_scattered_burst_vec_avx512_flex_rxd(void *rx_queue,
 					      uint16_t nb_pkts,
 					      bool offload)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 8c31334570..90a9ac95eb 100644
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
 
@@ -240,12 +239,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 
 #ifdef RTE_ARCH_X86
 static __rte_always_inline void
-iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
+iavf_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
 
 	rxdp = rxq->rx_ring + rxq->rxrearm_start;
 
@@ -259,7 +258,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 
 			dma_addr0 = _mm_setzero_si128();
 			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i] = &rxq->fake_mbuf;
+				rxp[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
@@ -277,8 +276,8 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxp += 2) {
 		__m128i vaddr0, vaddr1;
 
-		mb0 = rxp[0];
-		mb1 = rxp[1];
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
 
 		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
 		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 86f3a7839d..562e574aab 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -15,12 +15,12 @@
 #include "iavf_rxtx_vec_common.h"
 
 static inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	uint64x2_t dma_addr0, dma_addr1;
 	uint64x2_t zero = vdupq_n_u64(0);
@@ -35,7 +35,7 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 		if (rxq->rxrearm_nb + IAVF_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i] = &rxq->fake_mbuf;
+				rxep[i].mbuf = &rxq->fake_mbuf;
 				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read), zero);
 			}
 		}
@@ -46,8 +46,8 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
 	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		mb0 = rxep[0];
-		mb1 = rxep[1];
+		mb0 = rxep[0].mbuf;
+		mb1 = rxep[1].mbuf;
 
 		paddr = mb0->buf_iova + RTE_PKTMBUF_HEADROOM;
 		dma_addr0 = vdupq_n_u64(paddr);
@@ -75,7 +75,7 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 }
 
 static inline void
-desc_to_olflags_v(struct iavf_rx_queue *rxq, volatile union iavf_rx_desc *rxdp,
+desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
 		  uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
 {
 	RTE_SET_USED(rxdp);
@@ -193,17 +193,17 @@ desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct iavf_rx_queue *__rte_restrict rxq,
+_recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   struct rte_mbuf **__rte_restrict rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	RTE_SET_USED(split_packet);
 
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **sw_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	/* mask to shuffle from desc. to mbuf */
 	uint8x16_t shuf_msk = {
@@ -283,8 +283,8 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *__rte_restrict rxq,
 		descs[0] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp), descs[0], 0);
 
 		/* B.1 load 4 mbuf point */
-		mbp1 = vld1q_u64((uint64_t *)&sw_ring[pos]);
-		mbp2 = vld1q_u64((uint64_t *)&sw_ring[pos + 2]);
+		mbp1 = vld1q_u64((uint64_t *)&sw_ring[pos].mbuf);
+		mbp2 = vld1q_u64((uint64_t *)&sw_ring[pos + 2].mbuf);
 
 		/* B.2 copy 4 mbuf point into rx_pkts  */
 		vst1q_u64((uint64_t *)&rx_pkts[pos], mbp1);
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
index 0633a0c33d..a30ba87a3e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -13,13 +13,13 @@
 #include <rte_vect.h>
 
 static inline void
-iavf_rxq_rearm(struct iavf_rx_queue *rxq)
+iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
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
@@ -205,7 +205,7 @@ flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 }
 
 static inline void
-flex_desc_to_olflags_v(struct iavf_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
+flex_desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4], __m128i descs_bh[4],
 		       struct rte_mbuf **rx_pkts)
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
@@ -456,16 +456,16 @@ flex_desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
-	volatile union iavf_rx_desc *rxdp;
-	struct rte_mbuf **sw_ring;
+	volatile union ci_rx_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
 	__m128i shuf_msk;
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->iavf_vsi->adapter->ptype_tbl;
 
 	__m128i crc_adjust = _mm_set_epi16(
 				0, 0, 0,    /* ignore non-length fields */
@@ -561,7 +561,7 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 #endif
 
 		/* B.1 load 2 (64 bit) or 4 (32 bit) mbuf points */
-		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos]);
+		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos].mbuf);
 		/* Read desc statuses backwards to avoid race condition */
 		/* A.1 load desc[3] */
 		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
@@ -704,16 +704,16 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
+_recv_raw_pkts_vec_flex_rxd(struct ci_rx_queue *rxq,
 			    struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts, uint8_t *split_packet)
 {
-	volatile union iavf_rx_flex_desc *rxdp;
-	struct rte_mbuf **sw_ring;
+	volatile union ci_rx_flex_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
-	struct iavf_adapter *adapter = rxq->vsi->adapter;
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	uint64_t offloads = adapter->dev_data->dev_conf.rxmode.offloads;
 	const uint32_t *ptype_tbl = adapter->ptype_tbl;
 	__m128i crc_adjust = _mm_set_epi16
@@ -767,7 +767,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = (volatile union iavf_rx_flex_desc *)rxq->rx_ring + rxq->rx_tail;
+	rxdp = rxq->rx_flex_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -840,7 +840,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 #endif
 
 		/* B.1 load 2 (64 bit) or 4 (32 bit) mbuf points */
-		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos]);
+		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos].mbuf);
 		/* Read desc statuses backwards to avoid race condition */
 		/* A.1 load desc[3] */
 		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
@@ -1182,7 +1182,7 @@ static uint16_t
 iavf_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 	unsigned int i = 0;
 
@@ -1251,7 +1251,7 @@ iavf_recv_scattered_burst_vec_flex_rxd(void *rx_queue,
 				       struct rte_mbuf **rx_pkts,
 				       uint16_t nb_pkts)
 {
-	struct iavf_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 	unsigned int i = 0;
 
@@ -1424,7 +1424,7 @@ iavf_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-iavf_rx_queue_release_mbufs_sse(struct iavf_rx_queue *rxq)
+iavf_rx_queue_release_mbufs_sse(struct ci_rx_queue *rxq)
 {
 	_iavf_rx_queue_release_mbufs_vec(rxq);
 }
@@ -1437,7 +1437,7 @@ iavf_txq_vec_setup(struct ci_tx_queue *txq)
 }
 
 int __rte_cold
-iavf_rxq_vec_setup(struct iavf_rx_queue *rxq)
+iavf_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->rel_mbufs_type = IAVF_REL_MBUFS_SSE_VEC;
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 2302d2bcf1..b1b7a5bf94 100644
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
@@ -2244,9 +2244,9 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
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

