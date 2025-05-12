Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2DC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 12:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B00A40659;
	Mon, 12 May 2025 14:54:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB904042F
 for <dev@dpdk.org>; Mon, 12 May 2025 14:54:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747054495; x=1778590495;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VcvTtmcIiNYyqu0yADx/A7uECjFNQwnyTRoryxH0KO4=;
 b=N2ZKzZH6bwZKNR8LJTNG89RWC1/Ruj7wg1zbBX7C5cPXiNRXn+lKaG4f
 mf2GQ8pH1FBptbEykad6KfjUbnIL318+++vm5WQV5shU4dPprgEZSlEZJ
 9ZmMYOWIBy38eZDBgeOjCz4IGzY1gZFJKgZ8WQVT2HNBGuAIsaHOjO0dC
 S9YKGc2IQWh8PosGO2JnxUD8siRRle0F9AvveVWw+S0g9o3kZpohSuvD1
 0LnlveNIiknBUgPrsRlaYODd6MZA+BtYOG+uUm01zPAqLV+1oFwpe/WV2
 9IxdXhZuSlRP6UEVUoyOSK4FL3asDTcon83nnuglJWBhxm/nFngfaLZ79 w==;
X-CSE-ConnectionGUID: LmMUCl7FQpSbUJLjzGuYNg==
X-CSE-MsgGUID: lKAuIH36SaSIFUBESCxHkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48096990"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48096990"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:54:54 -0700
X-CSE-ConnectionGUID: DycxhUvtShSShrv66hS7og==
X-CSE-MsgGUID: OLVS8oEiT+GHMVv3xfa7nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142251852"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 12 May 2025 05:54:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 05/13] net/ice: use the common Rx queue structure
Date: Mon, 12 May 2025 13:54:31 +0100
Message-ID: <aed76e2a2c5c8be3ef968291db2720fc07eba633.1747054471.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
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

Make the ice driver use the new common Rx queue structure.

Because the ice driver supports both 16-byte and 32-byte descriptor
formats (controlled by RTE_LIBRTE_ICE_16BYTE_RX_DESC define), the common
queue structure has to take that into account, so the ring queue
structure will have both, while the actual descriptor format is picked by
ice at compile time using the above macro. Direct usage of Rx queue
structure is now meant to be replaced with a macro access that takes
descriptor size into account.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Make xtr_field_offs of type ptrdiff_t instead of off_t to fix 32-bit compile
      issues

 drivers/net/intel/common/rx.h               |  23 +++
 drivers/net/intel/ice/ice_dcf.c             |   6 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c      |  22 +--
 drivers/net/intel/ice/ice_ethdev.c          |   2 +-
 drivers/net/intel/ice/ice_ethdev.h          |   5 +-
 drivers/net/intel/ice/ice_rxtx.c            | 158 ++++++++++----------
 drivers/net/intel/ice/ice_rxtx.h            |  78 ++--------
 drivers/net/intel/ice/ice_rxtx_common_avx.h |   6 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |  14 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c |  16 +-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |   6 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  22 +--
 12 files changed, 164 insertions(+), 194 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index db49db57d0..9a691971bc 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -5,6 +5,7 @@
 #ifndef _COMMON_INTEL_RX_H_
 #define _COMMON_INTEL_RX_H_
 
+#include <stddef.h>
 #include <stdint.h>
 #include <unistd.h>
 #include <rte_mbuf.h>
@@ -12,6 +13,7 @@
 
 #define CI_RX_BURST 32
 #define CI_RX_MAX_BURST 32
+#define CI_RX_MAX_NSEG 2
 
 struct ci_rx_queue;
 
@@ -23,6 +25,8 @@ struct ci_rx_entry_sc {
 	struct rte_mbuf *fbuf; /* First segment of the fragmented packet.*/
 };
 
+typedef void (*ci_rx_release_mbufs_t)(struct ci_rx_queue *rxq);
+
 /**
  * Structure associated with each RX queue.
  */
@@ -32,6 +36,8 @@ struct ci_rx_queue {
 		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
 		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
 		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;
+		volatile union ice_16b_rx_flex_desc *ice_rx_16b_ring;
+		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
 	};
 	volatile uint8_t *qrx_tail;   /**< register address of tail */
 	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
@@ -64,10 +70,16 @@ struct ci_rx_queue {
 	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
 	uint64_t mbuf_initializer; /**< value to init mbufs */
 	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
+	uint32_t rxdid; /**< RX descriptor format ID. */
+	uint32_t proto_xtr; /* protocol extraction type */
+	uint64_t xtr_ol_flag; /* flexible descriptor metadata extraction offload flag */
+	ptrdiff_t xtr_field_offs; /* Protocol extraction matedata offset*/
+	uint64_t hw_time_update; /**< Last time HW timestamp was updated */
 	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
 	struct rte_mbuf fake_mbuf;
 	union { /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
+		struct ice_vsi *ice_vsi;
 	};
 	const struct rte_memzone *mz;
 	union {
@@ -85,6 +97,17 @@ struct ci_rx_queue {
 			uint8_t hs_mode; /**< Header Split mode */
 			uint8_t dcb_tc; /**< Traffic class of rx queue */
 		};
+		struct { /* ice specific values */
+			ci_rx_release_mbufs_t rx_rel_mbufs; /**< release mbuf function */
+			/** holds buffer split information */
+			struct rte_eth_rxseg_split rxseg[CI_RX_MAX_NSEG];
+			struct ci_rx_entry *sw_split_buf; /**< Buffer split SW ring */
+			uint32_t rxseg_nb; /**< number of buffer split segments */
+			uint32_t time_high; /* high 32 bits of hardware timestamp register */
+			uint32_t hw_time_high; /* high 32 bits of timestamp */
+			uint32_t hw_time_low; /* low 32 bits of timestamp */
+			bool ts_enable; /* if rxq timestamp is enabled */
+		};
 	};
 };
 
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 65c18921f4..fddf5bbde5 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1175,8 +1175,8 @@ ice_dcf_init_rss(struct ice_dcf_hw *hw)
 int
 ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 {
-	struct ice_rx_queue **rxq =
-		(struct ice_rx_queue **)hw->eth_dev->data->rx_queues;
+	struct ci_rx_queue **rxq =
+		(struct ci_rx_queue **)hw->eth_dev->data->rx_queues;
 	struct ci_tx_queue **txq =
 		(struct ci_tx_queue **)hw->eth_dev->data->tx_queues;
 	struct virtchnl_vsi_queue_config_info *vc_config;
@@ -1211,7 +1211,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 
 		vc_qp->rxq.max_pkt_size = rxq[i]->max_pkt_len;
 		vc_qp->rxq.ring_len = rxq[i]->nb_rx_desc;
-		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_dma;
+		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
 		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
 
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index efff76afa8..53272ddd60 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -106,7 +106,7 @@ ice_dcf_xmit_pkts(__rte_unused void *tx_queue,
 }
 
 static int
-ice_dcf_init_rxq(struct rte_eth_dev *dev, struct ice_rx_queue *rxq)
+ice_dcf_init_rxq(struct rte_eth_dev *dev, struct ci_rx_queue *rxq)
 {
 	struct ice_dcf_adapter *dcf_ad = dev->data->dev_private;
 	struct rte_eth_dev_data *dev_data = dev->data;
@@ -145,8 +145,8 @@ ice_dcf_init_rxq(struct rte_eth_dev *dev, struct ice_rx_queue *rxq)
 static int
 ice_dcf_init_rx_queues(struct rte_eth_dev *dev)
 {
-	struct ice_rx_queue **rxq =
-		(struct ice_rx_queue **)dev->data->rx_queues;
+	struct ci_rx_queue **rxq =
+		(struct ci_rx_queue **)dev->data->rx_queues;
 	int i, ret;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -282,7 +282,7 @@ ice_dcf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 }
 
 static int
-alloc_rxq_mbufs(struct ice_rx_queue *rxq)
+alloc_rxq_mbufs(struct ci_rx_queue *rxq)
 {
 	volatile union ice_rx_flex_desc *rxd;
 	struct rte_mbuf *mbuf = NULL;
@@ -305,7 +305,7 @@ alloc_rxq_mbufs(struct ice_rx_queue *rxq)
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
 
-		rxd = &rxq->rx_ring[i];
+		rxd = ICE_RX_RING_PTR(rxq, i);
 		rxd->read.pkt_addr = dma_addr;
 		rxd->read.hdr_addr = 0;
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
@@ -324,7 +324,7 @@ ice_dcf_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ice_dcf_adapter *ad = dev->data->dev_private;
 	struct iavf_hw *hw = &ad->real_hw.avf;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err = 0;
 
 	if (rx_queue_id >= dev->data->nb_rx_queues)
@@ -358,7 +358,7 @@ ice_dcf_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 }
 
 static inline void
-reset_rx_queue(struct ice_rx_queue *rxq)
+reset_rx_queue(struct ci_rx_queue *rxq)
 {
 	uint16_t len;
 	uint32_t i;
@@ -369,7 +369,7 @@ reset_rx_queue(struct ice_rx_queue *rxq)
 	len = rxq->nb_rx_desc + ICE_RX_MAX_BURST;
 
 	for (i = 0; i < len * sizeof(union ice_rx_flex_desc); i++)
-		((volatile char *)rxq->rx_ring)[i] = 0;
+		((volatile char *)ICE_RX_RING(rxq))[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
 
@@ -429,7 +429,7 @@ ice_dcf_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ice_dcf_adapter *ad = dev->data->dev_private;
 	struct ice_dcf_hw *hw = &ad->real_hw;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 
 	if (rx_queue_id >= dev->data->nb_rx_queues)
@@ -511,7 +511,7 @@ ice_dcf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 static int
 ice_dcf_start_queues(struct rte_eth_dev *dev)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int nb_rxq = 0;
 	int nb_txq, i;
@@ -638,7 +638,7 @@ ice_dcf_stop_queues(struct rte_eth_dev *dev)
 {
 	struct ice_dcf_adapter *ad = dev->data->dev_private;
 	struct ice_dcf_hw *hw = &ad->real_hw;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ci_tx_queue *txq;
 	int ret, i;
 
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 2e163d706c..65cf586502 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6690,7 +6690,7 @@ ice_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_adapter *ad =
 			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t ts_high;
 	uint64_t ts_ns;
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index afe8dae497..0ed223d83e 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -257,9 +257,6 @@ struct ice_vsi_list {
 	struct ice_vsi *vsi;
 };
 
-struct ice_rx_queue;
-struct ci_tx_queue;
-
 /**
  * Structure that defines a VSI, associated with a adapter.
  */
@@ -409,7 +406,7 @@ struct ice_fdir_counter_pool_container {
 struct ice_fdir_info {
 	struct ice_vsi *fdir_vsi;     /* pointer to fdir VSI structure */
 	struct ci_tx_queue *txq;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	void *prg_pkt;                 /* memory for fdir program packet */
 	uint64_t dma_addr;             /* physic address of packet memory*/
 	const struct rte_memzone *mz;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 40ac01e782..4749ee729f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -37,11 +37,11 @@ int
 ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
-	rxdp = &rxq->rx_ring[desc];
+	rxdp = ICE_RX_RING_PTR(rxq, desc);
 	/* watch for changes in status bit */
 	pmc->addr = &rxdp->wb.status_error0;
 
@@ -73,7 +73,7 @@ ice_proto_xtr_type_to_rxdid(uint8_t xtr_type)
 }
 
 static inline void
-ice_rxd_to_pkt_fields_by_comms_generic(__rte_unused struct ice_rx_queue *rxq,
+ice_rxd_to_pkt_fields_by_comms_generic(__rte_unused struct ci_rx_queue *rxq,
 				       struct rte_mbuf *mb,
 				       volatile union ice_rx_flex_desc *rxdp)
 {
@@ -95,7 +95,7 @@ ice_rxd_to_pkt_fields_by_comms_generic(__rte_unused struct ice_rx_queue *rxq,
 }
 
 static inline void
-ice_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ice_rx_queue *rxq,
+ice_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ci_rx_queue *rxq,
 				   struct rte_mbuf *mb,
 				   volatile union ice_rx_flex_desc *rxdp)
 {
@@ -120,7 +120,7 @@ ice_rxd_to_pkt_fields_by_comms_ovs(__rte_unused struct ice_rx_queue *rxq,
 }
 
 static inline void
-ice_rxd_to_pkt_fields_by_comms_aux_v1(struct ice_rx_queue *rxq,
+ice_rxd_to_pkt_fields_by_comms_aux_v1(struct ci_rx_queue *rxq,
 				      struct rte_mbuf *mb,
 				      volatile union ice_rx_flex_desc *rxdp)
 {
@@ -164,7 +164,7 @@ ice_rxd_to_pkt_fields_by_comms_aux_v1(struct ice_rx_queue *rxq,
 }
 
 static inline void
-ice_rxd_to_pkt_fields_by_comms_aux_v2(struct ice_rx_queue *rxq,
+ice_rxd_to_pkt_fields_by_comms_aux_v2(struct ci_rx_queue *rxq,
 				      struct rte_mbuf *mb,
 				      volatile union ice_rx_flex_desc *rxdp)
 {
@@ -215,7 +215,7 @@ static const ice_rxd_to_pkt_fields_t rxd_to_pkt_fields_ops[] = {
 };
 
 void
-ice_select_rxd_to_pkt_fields_handler(struct ice_rx_queue *rxq, uint32_t rxdid)
+ice_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq, uint32_t rxdid)
 {
 	rxq->rxdid = rxdid;
 
@@ -243,17 +243,17 @@ ice_select_rxd_to_pkt_fields_handler(struct ice_rx_queue *rxq, uint32_t rxdid)
 }
 
 static int
-ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
+ice_program_hw_rx_queue(struct ci_rx_queue *rxq)
 {
-	struct ice_vsi *vsi = rxq->vsi;
+	struct ice_vsi *vsi = rxq->ice_vsi;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	struct ice_pf *pf = ICE_VSI_TO_PF(vsi);
-	struct rte_eth_dev_data *dev_data = rxq->vsi->adapter->pf.dev_data;
+	struct rte_eth_dev_data *dev_data = rxq->ice_vsi->adapter->pf.dev_data;
 	struct ice_rlan_ctx rx_ctx;
 	uint16_t buf_size;
 	uint32_t rxdid = ICE_RXDID_COMMS_OVS;
 	uint32_t regval;
-	struct ice_adapter *ad = rxq->vsi->adapter;
+	struct ice_adapter *ad = rxq->ice_vsi->adapter;
 	uint32_t frame_size = dev_data->mtu + ICE_ETH_OVERHEAD;
 	int err;
 
@@ -371,7 +371,7 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
 		rx_ctx.dtype = 0; /* No Protocol Based Buffer Split mode */
 	}
 
-	rx_ctx.base = rxq->rx_ring_dma / ICE_QUEUE_BASE_ADDR_UNIT;
+	rx_ctx.base = rxq->rx_ring_phys_addr / ICE_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
 	rx_ctx.dbuf = rxq->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
 	rx_ctx.hbuf = rxq->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
@@ -452,15 +452,15 @@ ice_program_hw_rx_queue(struct ice_rx_queue *rxq)
 
 /* Allocate mbufs for all descriptors in rx queue */
 static int
-ice_alloc_rx_queue_mbufs(struct ice_rx_queue *rxq)
+ice_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 {
-	struct ice_rx_entry *rxe = rxq->sw_ring;
+	struct ci_rx_entry *rxe = rxq->sw_ring;
 	uint64_t dma_addr;
 	uint16_t i;
 
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
 		volatile union ice_rx_flex_desc *rxd;
-		rxd = &rxq->rx_ring[i];
+		rxd = ICE_RX_RING_PTR(rxq, i);
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mp);
 
 		if (unlikely(!mbuf)) {
@@ -514,7 +514,7 @@ ice_alloc_rx_queue_mbufs(struct ice_rx_queue *rxq)
 
 /* Free all mbufs for descriptors in rx queue */
 static void
-_ice_rx_queue_release_mbufs(struct ice_rx_queue *rxq)
+_ice_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	uint16_t i;
 
@@ -591,7 +591,7 @@ ice_switch_rx_queue(struct ice_hw *hw, uint16_t q_idx, bool on)
 }
 
 static inline int
-ice_check_rx_burst_bulk_alloc_preconditions(struct ice_rx_queue *rxq)
+ice_check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
 {
 	int ret = 0;
 
@@ -618,9 +618,9 @@ ice_check_rx_burst_bulk_alloc_preconditions(struct ice_rx_queue *rxq)
 	return ret;
 }
 
-/* reset fields in ice_rx_queue back to default */
+/* reset fields in ci_rx_queue back to default */
 static void
-ice_reset_rx_queue(struct ice_rx_queue *rxq)
+ice_reset_rx_queue(struct ci_rx_queue *rxq)
 {
 	unsigned int i;
 	uint16_t len;
@@ -633,7 +633,7 @@ ice_reset_rx_queue(struct ice_rx_queue *rxq)
 	len = (uint16_t)(rxq->nb_rx_desc + ICE_RX_MAX_BURST);
 
 	for (i = 0; i < len * sizeof(union ice_rx_flex_desc); i++)
-		((volatile char *)rxq->rx_ring)[i] = 0;
+		((volatile char *)ICE_RX_RING(rxq))[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
 	for (i = 0; i < ICE_RX_MAX_BURST; ++i)
@@ -655,7 +655,7 @@ ice_reset_rx_queue(struct ice_rx_queue *rxq)
 int
 ice_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -715,7 +715,7 @@ ice_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 int
 ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
@@ -834,9 +834,9 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 }
 
 static int
-ice_fdir_program_hw_rx_queue(struct ice_rx_queue *rxq)
+ice_fdir_program_hw_rx_queue(struct ci_rx_queue *rxq)
 {
-	struct ice_vsi *vsi = rxq->vsi;
+	struct ice_vsi *vsi = rxq->ice_vsi;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	uint32_t rxdid = ICE_RXDID_LEGACY_1;
 	struct ice_rlan_ctx rx_ctx;
@@ -848,7 +848,7 @@ ice_fdir_program_hw_rx_queue(struct ice_rx_queue *rxq)
 
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
 
-	rx_ctx.base = rxq->rx_ring_dma / ICE_QUEUE_BASE_ADDR_UNIT;
+	rx_ctx.base = rxq->rx_ring_phys_addr / ICE_QUEUE_BASE_ADDR_UNIT;
 	rx_ctx.qlen = rxq->nb_rx_desc;
 	rx_ctx.dbuf = rxq->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
 	rx_ctx.hbuf = rxq->rx_hdr_len >> ICE_RLAN_CTX_HBUF_S;
@@ -909,7 +909,7 @@ ice_fdir_program_hw_rx_queue(struct ice_rx_queue *rxq)
 int
 ice_fdir_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
@@ -1099,7 +1099,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 int
 ice_fdir_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int err;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
@@ -1170,7 +1170,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz;
 	uint32_t ring_size, tlen;
 	uint16_t len;
@@ -1206,7 +1206,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket(NULL,
-				 sizeof(struct ice_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 socket_id);
 
@@ -1240,7 +1240,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 		rxq->crc_len = 0;
 
 	rxq->drop_en = rx_conf->rx_drop_en;
-	rxq->vsi = vsi;
+	rxq->ice_vsi = vsi;
 	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
 	rxq->proto_xtr = pf->proto_xtr != NULL ?
 			 pf->proto_xtr[queue_idx] : PROTO_XTR_NONE;
@@ -1274,8 +1274,8 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Zero all the descriptors in the ring. */
 	memset(rz->addr, 0, ring_size);
 
-	rxq->rx_ring_dma = rz->iova;
-	rxq->rx_ring = rz->addr;
+	rxq->rx_ring_phys_addr = rz->iova;
+	ICE_RX_RING(rxq) = rz->addr;
 
 	/* always reserve more for bulk alloc */
 	len = (uint16_t)(nb_desc + ICE_RX_MAX_BURST);
@@ -1287,7 +1287,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/* Allocate the software ring. */
 	rxq->sw_ring = rte_zmalloc_socket(NULL,
-					  sizeof(struct ice_rx_entry) * tlen,
+					  sizeof(struct ci_rx_entry) * tlen,
 					  RTE_CACHE_LINE_SIZE,
 					  socket_id);
 	if (!rxq->sw_ring) {
@@ -1324,7 +1324,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 void
 ice_rx_queue_release(void *rxq)
 {
-	struct ice_rx_queue *q = (struct ice_rx_queue *)rxq;
+	struct ci_rx_queue *q = (struct ci_rx_queue *)rxq;
 
 	if (!q) {
 		PMD_DRV_LOG(DEBUG, "Pointer to rxq is NULL");
@@ -1548,7 +1548,7 @@ void
 ice_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 		 struct rte_eth_rxq_info *qinfo)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -1586,11 +1586,11 @@ ice_rx_queue_count(void *rx_queue)
 {
 #define ICE_RXQ_SCAN_INTERVAL 4
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint16_t desc = 0;
 
 	rxq = rx_queue;
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 	while ((desc < rxq->nb_rx_desc) &&
 	       rte_le_to_cpu_16(rxdp->wb.status_error0) &
 	       (1 << ICE_RX_FLEX_DESC_STATUS0_DD_S)) {
@@ -1602,8 +1602,8 @@ ice_rx_queue_count(void *rx_queue)
 		desc += ICE_RXQ_SCAN_INTERVAL;
 		rxdp += ICE_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
-			rxdp = &(rxq->rx_ring[rxq->rx_tail +
-				 desc - rxq->nb_rx_desc]);
+			rxdp = ICE_RX_RING_PTR(rxq,
+					rxq->rx_tail + desc - rxq->nb_rx_desc);
 	}
 
 	return desc;
@@ -1695,25 +1695,25 @@ ice_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ice_rx_flex_desc *rxdp)
 #define ICE_PTP_TS_VALID 0x1
 
 static inline int
-ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
+ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 {
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t stat_err0;
 	uint16_t pkt_len, hdr_len;
 	int32_t s[ICE_LOOK_AHEAD], nb_dd;
 	int32_t i, j, nb_rx = 0;
 	uint64_t pkt_flags = 0;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
-	struct ice_vsi *vsi = rxq->vsi;
+	struct ice_vsi *vsi = rxq->ice_vsi;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-	struct ice_adapter *ad = rxq->vsi->adapter;
+	struct ice_adapter *ad = rxq->ice_vsi->adapter;
 #endif
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	stat_err0 = rte_le_to_cpu_16(rxdp->wb.status_error0);
@@ -1843,7 +1843,7 @@ ice_rx_scan_hw_ring(struct ice_rx_queue *rxq)
 }
 
 static inline uint16_t
-ice_rx_fill_from_stage(struct ice_rx_queue *rxq,
+ice_rx_fill_from_stage(struct ci_rx_queue *rxq,
 		       struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts)
 {
@@ -1862,10 +1862,10 @@ ice_rx_fill_from_stage(struct ice_rx_queue *rxq,
 }
 
 static inline int
-ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
+ice_rx_alloc_bufs(struct ci_rx_queue *rxq)
 {
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx, i;
 	uint64_t dma_addr;
@@ -1894,7 +1894,7 @@ ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
 		}
 	}
 
-	rxdp = &rxq->rx_ring[alloc_idx];
+	rxdp = ICE_RX_RING_PTR(rxq, alloc_idx);
 	for (i = 0; i < rxq->rx_free_thresh; i++) {
 		if (likely(i < (rxq->rx_free_thresh - 1)))
 			/* Prefetch next mbuf */
@@ -1933,7 +1933,7 @@ ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
 static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = (struct ice_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	uint16_t nb_rx = 0;
 
 	if (!nb_pkts)
@@ -1951,7 +1951,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (ice_rx_alloc_bufs(rxq) != 0) {
 			uint16_t i, j;
 
-			rxq->vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed +=
+			rxq->ice_vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed +=
 				rxq->rx_free_thresh;
 			PMD_RX_LOG(DEBUG, "Rx mbuf alloc failed for "
 				   "port_id=%u, queue_id=%u",
@@ -2006,12 +2006,12 @@ ice_recv_scattered_pkts(void *rx_queue,
 			struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = rx_queue;
-	volatile union ice_rx_flex_desc *rx_ring = rxq->rx_ring;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ice_rx_flex_desc *rx_ring = ICE_RX_RING(rxq);
 	volatile union ice_rx_flex_desc *rxdp;
 	union ice_rx_flex_desc rxd;
-	struct ice_rx_entry *sw_ring = rxq->sw_ring;
-	struct ice_rx_entry *rxe;
+	struct ci_rx_entry *sw_ring = rxq->sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
 	struct rte_mbuf *nmb; /* new allocated mbuf */
@@ -2023,13 +2023,13 @@ ice_recv_scattered_pkts(void *rx_queue,
 	uint16_t rx_stat_err0;
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
-	struct ice_vsi *vsi = rxq->vsi;
+	struct ice_vsi *vsi = rxq->ice_vsi;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-	struct ice_adapter *ad = rxq->vsi->adapter;
+	struct ice_adapter *ad = rxq->ice_vsi->adapter;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -2050,7 +2050,7 @@ ice_recv_scattered_pkts(void *rx_queue,
 		/* allocate mbuf */
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			rxq->vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
+			rxq->ice_vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
 			break;
 		}
 		rxd = *rxdp; /* copy descriptor in ring to temp variable*/
@@ -2319,7 +2319,7 @@ int
 ice_rx_descriptor_status(void *rx_queue, uint16_t offset)
 {
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint32_t desc;
 
 	if (unlikely(offset >= rxq->nb_rx_desc))
@@ -2332,7 +2332,7 @@ ice_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (desc >= rxq->nb_rx_desc)
 		desc -= rxq->nb_rx_desc;
 
-	rxdp = &rxq->rx_ring[desc];
+	rxdp = ICE_RX_RING_PTR(rxq, desc);
 	if (rte_le_to_cpu_16(rxdp->wb.status_error0) &
 	    (1 << ICE_RX_FLEX_DESC_STATUS0_DD_S))
 		return RTE_ETH_RX_DESC_DONE;
@@ -2459,7 +2459,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
 int
 ice_fdir_setup_rx_resources(struct ice_pf *pf)
 {
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	const struct rte_memzone *rz = NULL;
 	uint32_t ring_size;
 	struct rte_eth_dev *dev;
@@ -2473,7 +2473,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 
 	/* Allocate the RX queue data structure. */
 	rxq = rte_zmalloc_socket("ice fdir rx queue",
-				 sizeof(struct ice_rx_queue),
+				 sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE,
 				 SOCKET_ID_ANY);
 	if (!rxq) {
@@ -2499,12 +2499,12 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 	rxq->nb_rx_desc = ICE_FDIR_NUM_RX_DESC;
 	rxq->queue_id = ICE_FDIR_QUEUE_ID;
 	rxq->reg_idx = pf->fdir.fdir_vsi->base_queue;
-	rxq->vsi = pf->fdir.fdir_vsi;
+	rxq->ice_vsi = pf->fdir.fdir_vsi;
 
-	rxq->rx_ring_dma = rz->iova;
+	rxq->rx_ring_phys_addr = rz->iova;
 	memset(rz->addr, 0, ICE_FDIR_NUM_RX_DESC *
 	       sizeof(union ice_32byte_rx_desc));
-	rxq->rx_ring = (union ice_rx_flex_desc *)rz->addr;
+	ICE_RX_RING(rxq) = (union ice_rx_flex_desc *)rz->addr;
 
 	/*
 	 * Don't need to allocate software ring and reset for the fdir
@@ -2523,12 +2523,12 @@ ice_recv_pkts(void *rx_queue,
 	      struct rte_mbuf **rx_pkts,
 	      uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = rx_queue;
-	volatile union ice_rx_flex_desc *rx_ring = rxq->rx_ring;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ice_rx_flex_desc *rx_ring = ICE_RX_RING(rxq);
 	volatile union ice_rx_flex_desc *rxdp;
 	union ice_rx_flex_desc rxd;
-	struct ice_rx_entry *sw_ring = rxq->sw_ring;
-	struct ice_rx_entry *rxe;
+	struct ci_rx_entry *sw_ring = rxq->sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_mbuf *nmb; /* new allocated mbuf */
 	struct rte_mbuf *nmb_pay; /* new allocated payload mbuf */
 	struct rte_mbuf *rxm; /* pointer to store old mbuf in SW ring */
@@ -2540,13 +2540,13 @@ ice_recv_pkts(void *rx_queue,
 	uint16_t rx_stat_err0;
 	uint64_t dma_addr;
 	uint64_t pkt_flags;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 #ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
 	bool is_tsinit = false;
 	uint64_t ts_ns;
-	struct ice_vsi *vsi = rxq->vsi;
+	struct ice_vsi *vsi = rxq->ice_vsi;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-	struct ice_adapter *ad = rxq->vsi->adapter;
+	struct ice_adapter *ad = rxq->ice_vsi->adapter;
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
 		uint64_t sw_cur_time = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
@@ -2567,7 +2567,7 @@ ice_recv_pkts(void *rx_queue,
 		/* allocate header mbuf */
 		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (unlikely(!nmb)) {
-			rxq->vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
+			rxq->ice_vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
 			break;
 		}
 
@@ -2594,7 +2594,7 @@ ice_recv_pkts(void *rx_queue,
 			/* allocate payload mbuf */
 			nmb_pay = rte_mbuf_raw_alloc(rxq->rxseg[1].mp);
 			if (unlikely(!nmb_pay)) {
-				rxq->vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
+				rxq->ice_vsi->adapter->pf.dev_data->rx_mbuf_alloc_failed++;
 				rxe->mbuf = NULL;
 				nb_hold--;
 				if (unlikely(rx_id == 0))
@@ -3472,7 +3472,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 #ifdef RTE_ARCH_X86
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int i;
 	int rx_check_ret = -1;
 
@@ -4634,7 +4634,7 @@ ice_set_default_ptype_table(struct rte_eth_dev *dev)
  * tx queue
  */
 static inline int
-ice_check_fdir_programming_status(struct ice_rx_queue *rxq)
+ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
 	volatile union ice_32byte_rx_desc *rxdp;
 	uint64_t qword1;
@@ -4644,7 +4644,7 @@ ice_check_fdir_programming_status(struct ice_rx_queue *rxq)
 	int ret = -EAGAIN;
 
 	rxdp = (volatile union ice_32byte_rx_desc *)
-		(&rxq->rx_ring[rxq->rx_tail]);
+			ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
 	rx_status = (qword1 & ICE_RXD_QW1_STATUS_M)
 			>> ICE_RXD_QW1_STATUS_S;
@@ -4689,7 +4689,7 @@ int
 ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 {
 	struct ci_tx_queue *txq = pf->fdir.txq;
-	struct ice_rx_queue *rxq = pf->fdir.rxq;
+	struct ci_rx_queue *rxq = pf->fdir.rxq;
 	volatile struct ice_fltr_desc *fdirdp;
 	volatile struct ice_tx_desc *txdp;
 	uint32_t td_cmd;
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 276d40b57f..1a39770d7d 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -5,6 +5,7 @@
 #ifndef _ICE_RXTX_H_
 #define _ICE_RXTX_H_
 
+#include "../common/rx.h"
 #include "../common/tx.h"
 #include "ice_ethdev.h"
 
@@ -14,21 +15,28 @@
 #define ICE_DMA_MEM_ALIGN    4096
 #define ICE_RING_BASE_ALIGN  128
 
-#define ICE_RX_MAX_BURST 32
+#define ICE_RX_MAX_BURST CI_RX_MAX_BURST
 #define ICE_TX_MAX_BURST 32
 
 /* Maximal number of segments to split. */
-#define ICE_RX_MAX_NSEG 2
+#define ICE_RX_MAX_NSEG CI_RX_MAX_NSEG
 
 #define ICE_CHK_Q_ENA_COUNT        100
 #define ICE_CHK_Q_ENA_INTERVAL_US  100
 
 #ifdef RTE_LIBRTE_ICE_16BYTE_RX_DESC
 #define ice_rx_flex_desc ice_16b_rx_flex_desc
+#define ICE_RX_RING(rxq) \
+	((rxq)->ice_rx_16b_ring)
 #else
 #define ice_rx_flex_desc ice_32b_rx_flex_desc
+#define ICE_RX_RING(rxq) \
+	((rxq)->ice_rx_32b_ring)
 #endif
 
+#define ICE_RX_RING_PTR(rxq, entry) \
+	(ICE_RX_RING(rxq) + (entry))
+
 #define ICE_SUPPORT_CHAIN_NUM 5
 
 #define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
@@ -78,74 +86,16 @@ extern int ice_timestamp_dynfield_offset;
 
 #define ICE_TX_MTU_SEG_MAX	8
 
-typedef void (*ice_rx_release_mbufs_t)(struct ice_rx_queue *rxq);
-typedef void (*ice_rxd_to_pkt_fields_t)(struct ice_rx_queue *rxq,
+typedef void (*ice_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 					struct rte_mbuf *mb,
 					volatile union ice_rx_flex_desc *rxdp);
 
-struct ice_rx_entry {
-	struct rte_mbuf *mbuf;
-};
-
 enum ice_rx_dtype {
 	ICE_RX_DTYPE_NO_SPLIT       = 0,
 	ICE_RX_DTYPE_HEADER_SPLIT   = 1,
 	ICE_RX_DTYPE_SPLIT_ALWAYS   = 2,
 };
 
-struct ice_rx_queue {
-	struct rte_mempool *mp; /* mbuf pool to populate RX ring */
-	volatile union ice_rx_flex_desc *rx_ring;/* RX ring virtual address */
-	rte_iova_t rx_ring_dma; /* RX ring DMA address */
-	struct ice_rx_entry *sw_ring; /* address of RX soft ring */
-	uint16_t nb_rx_desc; /* number of RX descriptors */
-	uint16_t rx_free_thresh; /* max free RX desc to hold */
-	uint16_t rx_tail; /* current value of tail */
-	uint16_t nb_rx_hold; /* number of held free RX desc */
-	struct rte_mbuf *pkt_first_seg; /**< first segment of current packet */
-	struct rte_mbuf *pkt_last_seg; /**< last segment of current packet */
-	uint16_t rx_nb_avail; /**< number of staged packets ready */
-	uint16_t rx_next_avail; /**< index of next staged packets */
-	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	struct rte_mbuf fake_mbuf; /**< dummy mbuf */
-	struct rte_mbuf *rx_stage[ICE_RX_MAX_BURST * 2];
-
-	uint16_t rxrearm_nb;	/**< number of remaining to be re-armed */
-	uint16_t rxrearm_start;	/**< the idx we start the re-arming from */
-	uint64_t mbuf_initializer; /**< value to init mbufs */
-
-	uint16_t port_id; /* device port ID */
-	uint8_t crc_len; /* 0 if CRC stripped, 4 otherwise */
-	uint8_t fdir_enabled; /* 0 if FDIR disabled, 1 when enabled */
-	uint16_t queue_id; /* RX queue index */
-	uint16_t reg_idx; /* RX queue register index */
-	uint8_t drop_en; /* if not 0, set register bit */
-	volatile uint8_t *qrx_tail; /* register address of tail */
-	struct ice_vsi *vsi; /* the VSI this queue belongs to */
-	uint16_t rx_buf_len; /* The packet buffer size */
-	uint16_t rx_hdr_len; /* The header buffer size */
-	uint16_t max_pkt_len; /* Maximum packet length */
-	bool q_set; /* indicate if rx queue has been configured */
-	bool rx_deferred_start; /* don't start this queue in dev start */
-	uint8_t proto_xtr; /* Protocol extraction from flexible descriptor */
-	int xtr_field_offs; /*Protocol extraction matedata offset*/
-	uint64_t xtr_ol_flag; /* Protocol extraction offload flag */
-	uint32_t rxdid; /* Receive Flex Descriptor profile ID */
-	ice_rx_release_mbufs_t rx_rel_mbufs;
-	uint64_t offloads;
-	uint32_t time_high;
-	uint32_t hw_register_set;
-	const struct rte_memzone *mz;
-	uint32_t hw_time_high; /* high 32 bits of timestamp */
-	uint32_t hw_time_low; /* low 32 bits of timestamp */
-	uint64_t hw_time_update; /* SW time of HW record updating */
-	struct ice_rx_entry *sw_split_buf;
-	/* address of temp buffer for RX split mbufs */
-	struct rte_eth_rxseg_split rxseg[ICE_RX_MAX_NSEG];
-	uint32_t rxseg_nb;
-	bool ts_enable; /* if rxq timestamp is enabled */
-};
-
 /* Offload features */
 union ice_tx_offload {
 	uint64_t data;
@@ -249,12 +199,12 @@ int ice_tx_descriptor_status(void *tx_queue, uint16_t offset);
 void ice_set_default_ptype_table(struct rte_eth_dev *dev);
 const uint32_t *ice_dev_supported_ptypes_get(struct rte_eth_dev *dev,
 					     size_t *no_of_elements);
-void ice_select_rxd_to_pkt_fields_handler(struct ice_rx_queue *rxq,
+void ice_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq,
 					  uint32_t rxdid);
 
 int ice_rx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_tx_vec_dev_check(struct rte_eth_dev *dev);
-int ice_rxq_vec_setup(struct ice_rx_queue *rxq);
+int ice_rxq_vec_setup(struct ci_rx_queue *rxq);
 int ice_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts);
@@ -299,7 +249,7 @@ int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
 #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
 	int i; \
 	for (i = 0; i < (ad)->pf.dev_data->nb_rx_queues; i++) { \
-		struct ice_rx_queue *rxq = (ad)->pf.dev_data->rx_queues[i]; \
+		struct ci_rx_queue *rxq = (ad)->pf.dev_data->rx_queues[i]; \
 		if (!rxq) \
 			continue; \
 		rxq->fdir_enabled = on; \
diff --git a/drivers/net/intel/ice/ice_rxtx_common_avx.h b/drivers/net/intel/ice/ice_rxtx_common_avx.h
index c62e60c70e..7209c902db 100644
--- a/drivers/net/intel/ice/ice_rxtx_common_avx.h
+++ b/drivers/net/intel/ice/ice_rxtx_common_avx.h
@@ -9,14 +9,14 @@
 
 #ifdef __AVX2__
 static __rte_always_inline void
-ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
+ice_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = ICE_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 0c54b325c6..f4555369a2 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -8,7 +8,7 @@
 #include <rte_vect.h>
 
 static __rte_always_inline void
-ice_rxq_rearm(struct ice_rx_queue *rxq)
+ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	ice_rxq_rearm_common(rxq, false);
 }
@@ -33,17 +33,17 @@ ice_flex_rxd_to_fdir_flags_vec_avx2(const __m256i fdir_id0_7)
 }
 
 static __rte_always_inline uint16_t
-_ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts, uint8_t *split_packet,
 			    bool offload)
 {
 #define ICE_DESCS_PER_LOOP_AVX 8
 
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct ice_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union ice_rx_flex_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ice_rx_flex_desc *rxdp = ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 
 	rte_prefetch0(rxdp);
@@ -445,7 +445,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			 * needs to load 2nd 16B of each desc for RSS hash parsing,
 			 * will cause performance drop to get into this context.
 			 */
-			if (rxq->vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
+			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
 					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
 				/* load bottom half of every 32B desc */
 				const __m128i raw_desc_bh7 = _mm_load_si128
@@ -694,7 +694,7 @@ static __rte_always_inline uint16_t
 ice_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				  uint16_t nb_pkts, bool offload)
 {
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index bd49be07c9..6eea74d703 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -10,7 +10,7 @@
 #define ICE_DESCS_PER_LOOP_AVX 8
 
 static __rte_always_inline void
-ice_rxq_rearm(struct ice_rx_queue *rxq)
+ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	ice_rxq_rearm_common(rxq, true);
 }
@@ -35,17 +35,17 @@ ice_flex_rxd_to_fdir_flags_vec_avx512(const __m256i fdir_id0_7)
 }
 
 static __rte_always_inline uint16_t
-_ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
+_ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 			      struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts,
 			      uint8_t *split_packet,
 			      bool do_offload)
 {
-	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	const uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
-	struct ice_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
-	volatile union ice_rx_flex_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
+	volatile union ice_rx_flex_desc *rxdp = ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -467,7 +467,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 			 * needs to load 2nd 16B of each desc for RSS hash parsing,
 			 * will cause performance drop to get into this context.
 			 */
-			if (rxq->vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
+			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
 					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
 				/* load bottom half of every 32B desc */
 				const __m128i raw_desc_bh7 = _mm_load_si128
@@ -723,7 +723,7 @@ static uint16_t
 ice_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				    uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -765,7 +765,7 @@ ice_recv_scattered_burst_vec_avx512_offload(void *rx_queue,
 					    struct rte_mbuf **rx_pkts,
 					    uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 7933c26366..9430a99ba5 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -17,7 +17,7 @@ ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 }
 
 static inline void
-_ice_rx_queue_release_mbufs_vec(struct ice_rx_queue *rxq)
+_ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	const unsigned int mask = rxq->nb_rx_desc - 1;
 	unsigned int i;
@@ -79,7 +79,7 @@ _ice_rx_queue_release_mbufs_vec(struct ice_rx_queue *rxq)
 #define ICE_VECTOR_OFFLOAD_PATH	1
 
 static inline int
-ice_rx_vec_queue_default(struct ice_rx_queue *rxq)
+ice_rx_vec_queue_default(struct ci_rx_queue *rxq)
 {
 	if (!rxq)
 		return -1;
@@ -119,7 +119,7 @@ static inline int
 ice_rx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
-	struct ice_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	int ret = 0;
 	int result = 0;
 
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index 97f05ba45e..dc9d37226a 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -26,18 +26,18 @@ ice_flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 }
 
 static inline void
-ice_rxq_rearm(struct ice_rx_queue *rxq)
+ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 					  RTE_PKTMBUF_HEADROOM);
 	__m128i dma_addr0, dma_addr1;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = ICE_RX_RING_PTR(rxq, rxq->rxrearm_start);
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
@@ -105,7 +105,7 @@ ice_rxq_rearm(struct ice_rx_queue *rxq)
 }
 
 static inline void
-ice_rx_desc_to_olflags_v(struct ice_rx_queue *rxq, __m128i descs[4],
+ice_rx_desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4],
 			 struct rte_mbuf **rx_pkts)
 {
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
@@ -301,15 +301,15 @@ ice_rx_desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
  * - floor align nb_pkts to a ICE_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_ice_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union ice_rx_flex_desc *rxdp;
-	struct ice_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint64_t var;
-	uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
 	__m128i crc_adjust = _mm_set_epi16
 				(0, 0, 0,       /* ignore non-length fields */
 				 -rxq->crc_len, /* sub crc on data_len */
@@ -361,7 +361,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = ICE_RX_RING_PTR(rxq, rxq->rx_tail);
 
 	rte_prefetch0(rxdp);
 
@@ -482,7 +482,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		 * needs to load 2nd 16B of each desc for RSS hash parsing,
 		 * will cause performance drop to get into this context.
 		 */
-		if (rxq->vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
+		if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
 				RTE_ETH_RX_OFFLOAD_RSS_HASH) {
 			/* load bottom half of every 32B desc */
 			const __m128i raw_desc_bh3 =
@@ -608,7 +608,7 @@ static uint16_t
 ice_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
 {
-	struct ice_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -779,7 +779,7 @@ ice_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 int __rte_cold
-ice_rxq_vec_setup(struct ice_rx_queue *rxq)
+ice_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	if (!rxq)
 		return -1;
-- 
2.47.1

