Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12279C61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BC3D427E4;
	Thu, 12 Jun 2025 13:12:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id AD215427BB
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726755; x=1781262755;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=TZgNVwoP9y7rve+vWkdQ5l86v9cAogSyMrV0WW/49Pw=;
 b=FFjPcYjl+85n/GE+PrizS28cXk1YX/1Tqwj3IfrBG9Z4UGtSVaqO8TFF
 PvGxCoDSIiJv/1npoX0O6glpri/jJnH1FcfKsKgumzWIoGeScvmgAK8jR
 DS5x3rvMZqtVzoEGVqueJgjMsm7ehEa39dqQva8ZbV6IGvcmXQ+sDE71W
 8EBhZoBQMh6Fb2odU6vJOYLtjqsI6FQd61U2PC4bmCaFKNVc25+/o9ymZ
 Lm+x88PBP1s+SMhVyuL0WW70PtJhEnR+wYD/bxQhwhwPp7fOv9WiLGl4U
 JCCvUZEt9sUhxn5IvvYk+jLkVsy5ZBmSdvSuW0XimttxSJuriPme2DDVx g==;
X-CSE-ConnectionGUID: PW5Usob7SsCuELQZ+WyjPg==
X-CSE-MsgGUID: b1GZ2U9pQQGO16Iidt5SCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177589"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:34 -0700
X-CSE-ConnectionGUID: 6jjcyXqwRS6UA9BMdm8eQQ==
X-CSE-MsgGUID: ajPTu9NQSLeqQ3cQIV2b0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371383"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:32 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 23/33] net/ixgbe: create common Rx queue structure
Date: Thu, 12 Jun 2025 12:11:29 +0100
Message-ID: <8cf5c624f910d763903a134f70c605db94c5428f.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

In preparation for deduplication effort, generalize the Rx queue structure.

The entire Rx queue structure is moved to common/rx.h, clarifying the
comments where necessary, and separating common parts from ixgbe-specific
parts.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Sort ixgbe-specific fields by size
    
    v3 -> v4:
    - Separate out some of the changes from this commit into previous commits
    - Rename CI_RX_BURST to CI_RX_MAX_BURST to match the driver naming convention

 drivers/net/intel/common/rx.h                 |  67 ++++++++++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 108 +++++++++---------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  61 +---------
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |  12 +-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   5 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  14 +--
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  14 +--
 8 files changed, 146 insertions(+), 143 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index abb01ba5e7..b60ca24dfb 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -10,14 +10,75 @@
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
 
-#define CI_RX_BURST 32
+#define CI_RX_MAX_BURST 32
+
+struct ci_rx_queue;
+
+struct ci_rx_entry {
+	struct rte_mbuf *mbuf; /* mbuf associated with RX descriptor. */
+};
+
+struct ci_rx_entry_sc {
+	struct rte_mbuf *fbuf; /* First segment of the fragmented packet.*/
+};
+
+/**
+ * Structure associated with each RX queue.
+ */
+struct ci_rx_queue {
+	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
+	union { /* RX ring virtual address */
+		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
+	};
+	volatile uint8_t *qrx_tail;   /**< register address of tail */
+	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
+	struct ci_rx_entry_sc *sw_sc_ring; /**< address of scattered Rx software ring. */
+	rte_iova_t rx_ring_phys_addr; /**< RX ring DMA address. */
+	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
+	struct rte_mbuf *pkt_last_seg; /**< Last segment of current packet. */
+	/** hold packets to return to application */
+	struct rte_mbuf *rx_stage[CI_RX_MAX_BURST * 2];
+	uint16_t nb_rx_desc; /**< number of RX descriptors. */
+	uint16_t rx_tail;  /**< current value of tail register. */
+	uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app */
+	uint16_t nb_rx_hold; /**< number of held free RX desc. */
+	uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app */
+	uint16_t rx_free_thresh; /**< max free RX desc to hold. */
+	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
+	uint16_t rxrearm_nb;     /**< number of remaining to be re-armed */
+	uint16_t rxrearm_start;  /**< the idx we start the re-arming from */
+	uint16_t queue_id; /**< RX queue index. */
+	uint16_t port_id;  /**< Device port identifier. */
+	uint16_t reg_idx;  /**< RX queue register index. */
+	uint8_t crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
+	bool rx_deferred_start; /**< queue is not started on dev start. */
+	bool vector_rx; /**< indicates that vector RX is in use */
+	bool drop_en;  /**< if 1, drop packets if no descriptors are available. */
+	uint64_t mbuf_initializer; /**< value to init mbufs */
+	uint64_t offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
+	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
+	struct rte_mbuf fake_mbuf;
+	const struct rte_memzone *mz;
+	union {
+		struct { /* ixgbe specific values */
+			/** flags to set in mbuf when a vlan is detected. */
+			uint64_t vlan_flags;
+			/** Packet type mask for different NICs. */
+			uint16_t pkt_type_mask;
+			/** indicates that IPsec RX feature is in use */
+			uint8_t using_ipsec;
+			/** UDP frames with a 0 checksum can be marked as checksum errors. */
+			uint8_t rx_udp_csum_zero_err;
+		};
+	};
+};
 
 static inline uint16_t
 ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
 		struct rte_mbuf **pkt_first_seg, struct rte_mbuf **pkt_last_seg,
 		const uint8_t crc_len)
 {
-	struct rte_mbuf *pkts[CI_RX_BURST] = {0}; /*finished pkts*/
+	struct rte_mbuf *pkts[CI_RX_MAX_BURST] = {0}; /*finished pkts*/
 	struct rte_mbuf *start = *pkt_first_seg;
 	struct rte_mbuf *end = *pkt_last_seg;
 	unsigned int pkt_idx, buf_idx;
@@ -97,7 +158,7 @@ static inline bool
 ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh, uint64_t offloads)
 {
 	if (!rte_is_power_of_2(nb_desc) ||
-			rx_free_thresh < CI_RX_BURST ||
+			rx_free_thresh < CI_RX_MAX_BURST ||
 			(nb_desc % rx_free_thresh) != 0)
 		return false;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 928ac57a93..f8b99d4de5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2022,7 +2022,7 @@ ixgbe_vlan_hw_strip_bitmap_set(struct rte_eth_dev *dev, uint16_t queue, bool on)
 {
 	struct ixgbe_hwstrip *hwstrip =
 		IXGBE_DEV_PRIVATE_TO_HWSTRIP_BITMAP(dev->data->dev_private);
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	if (queue >= IXGBE_MAX_RX_QUEUE_NUM)
 		return;
@@ -2157,7 +2157,7 @@ ixgbe_vlan_hw_strip_config(struct rte_eth_dev *dev)
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 	uint32_t ctrl;
 	uint16_t i;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	bool on;
 
 	PMD_INIT_FUNC_TRACE();
@@ -2200,7 +2200,7 @@ ixgbe_config_vlan_strip_on_all_queues(struct rte_eth_dev *dev, int mask)
 {
 	uint16_t i;
 	struct rte_eth_rxmode *rxmode;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
 		rxmode = &dev->data->dev_conf.rxmode;
@@ -5782,7 +5782,7 @@ ixgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 static int
 ixgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint16_t i;
 	int on = 0;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 5b2067bc0e..bbe665a6ff 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1403,11 +1403,11 @@ int
 ixgbe_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
 {
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint16_t desc;
 
 	desc = rxq->rx_tail;
-	rxdp = &rxq->rx_ring[desc];
+	rxdp = &rxq->ixgbe_rx_ring[desc];
 	/* watch for changes in status bit */
 	pmc->addr = &rxdp->wb.upper.status_error;
 
@@ -1547,10 +1547,10 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status, uint16_t pkt_info,
 #error "PMD IXGBE: LOOK_AHEAD must be 8\n"
 #endif
 static inline int
-ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 {
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t pkt_len;
 	uint64_t pkt_flags;
@@ -1562,7 +1562,7 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
 	uint64_t vlan_flags = rxq->vlan_flags;
 
 	/* get references to current descriptor and S/W ring entry */
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = &rxq->ixgbe_rx_ring[rxq->rx_tail];
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	status = rxdp->wb.upper.status_error;
@@ -1647,10 +1647,10 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
 }
 
 static inline int
-ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
+ixgbe_rx_alloc_bufs(struct ci_rx_queue *rxq, bool reset_mbuf)
 {
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *rxep;
+	struct ci_rx_entry *rxep;
 	struct rte_mbuf *mb;
 	uint16_t alloc_idx;
 	__le64 dma_addr;
@@ -1664,7 +1664,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
 	if (unlikely(diag != 0))
 		return -ENOMEM;
 
-	rxdp = &rxq->rx_ring[alloc_idx];
+	rxdp = &rxq->ixgbe_rx_ring[alloc_idx];
 	for (i = 0; i < rxq->rx_free_thresh; ++i) {
 		/* populate the static rte mbuf fields */
 		mb = rxep[i].mbuf;
@@ -1691,7 +1691,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
 }
 
 static inline uint16_t
-ixgbe_rx_fill_from_stage(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+ixgbe_rx_fill_from_stage(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
 	struct rte_mbuf **stage = &rxq->rx_stage[rxq->rx_next_avail];
@@ -1715,7 +1715,7 @@ static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	     uint16_t nb_pkts)
 {
-	struct ixgbe_rx_queue *rxq = (struct ixgbe_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	uint16_t nb_rx = 0;
 
 	/* Any previously recv'd pkts will be returned from the Rx stage */
@@ -1804,11 +1804,11 @@ uint16_t
 ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	volatile union ixgbe_adv_rx_desc *rx_ring;
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *sw_ring;
-	struct ixgbe_rx_entry *rxe;
+	struct ci_rx_entry *sw_ring;
+	struct ci_rx_entry *rxe;
 	struct rte_mbuf *rxm;
 	struct rte_mbuf *nmb;
 	union ixgbe_adv_rx_desc rxd;
@@ -1826,7 +1826,7 @@ ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
+	rx_ring = rxq->ixgbe_rx_ring;
 	sw_ring = rxq->sw_ring;
 	vlan_flags = rxq->vlan_flags;
 	while (nb_rx < nb_pkts) {
@@ -2031,7 +2031,7 @@ static inline void
 ixgbe_fill_cluster_head_buf(
 	struct rte_mbuf *head,
 	union ixgbe_adv_rx_desc *desc,
-	struct ixgbe_rx_queue *rxq,
+	struct ci_rx_queue *rxq,
 	uint32_t staterr)
 {
 	uint32_t pkt_info;
@@ -2093,10 +2093,10 @@ static inline uint16_t
 ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 		    bool bulk_alloc)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
-	volatile union ixgbe_adv_rx_desc *rx_ring = rxq->rx_ring;
-	struct ixgbe_rx_entry *sw_ring = rxq->sw_ring;
-	struct ixgbe_scattered_rx_entry *sw_sc_ring = rxq->sw_sc_ring;
+	struct ci_rx_queue *rxq = rx_queue;
+	volatile union ixgbe_adv_rx_desc *rx_ring = rxq->ixgbe_rx_ring;
+	struct ci_rx_entry *sw_ring = rxq->sw_ring;
+	struct ci_rx_entry_sc *sw_sc_ring = rxq->sw_sc_ring;
 	uint16_t rx_id = rxq->rx_tail;
 	uint16_t nb_rx = 0;
 	uint16_t nb_hold = rxq->nb_rx_hold;
@@ -2104,10 +2104,10 @@ ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 
 	while (nb_rx < nb_pkts) {
 		bool eop;
-		struct ixgbe_rx_entry *rxe;
-		struct ixgbe_scattered_rx_entry *sc_entry;
-		struct ixgbe_scattered_rx_entry *next_sc_entry = NULL;
-		struct ixgbe_rx_entry *next_rxe = NULL;
+		struct ci_rx_entry *rxe;
+		struct ci_rx_entry_sc *sc_entry;
+		struct ci_rx_entry_sc *next_sc_entry = NULL;
+		struct ci_rx_entry *next_rxe = NULL;
 		struct rte_mbuf *first_seg;
 		struct rte_mbuf *rxm;
 		struct rte_mbuf *nmb = NULL;
@@ -2949,7 +2949,7 @@ ixgbe_free_sc_cluster(struct rte_mbuf *m)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_non_vec(struct ci_rx_queue *rxq)
 {
 	unsigned i;
 
@@ -2980,7 +2980,7 @@ ixgbe_rx_queue_release_mbufs_non_vec(struct ixgbe_rx_queue *rxq)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	if (rxq->vector_rx)
 		ixgbe_rx_queue_release_mbufs_vec(rxq);
@@ -2989,7 +2989,7 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release(struct ci_rx_queue *rxq)
 {
 	if (rxq != NULL) {
 		ixgbe_rx_queue_release_mbufs(rxq);
@@ -3015,7 +3015,7 @@ ixgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
  *           function must be used.
  */
 static inline int __rte_cold
-check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
 {
 	int ret = 0;
 
@@ -3052,7 +3052,7 @@ check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
 
 /* Reset dynamic ixgbe_rx_queue fields back to defaults */
 static void __rte_cold
-ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
+ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ci_rx_queue *rxq)
 {
 	static const union ixgbe_adv_rx_desc zeroed_desc = {{0}};
 	unsigned i;
@@ -3073,7 +3073,7 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
 	 * reads extra memory as zeros.
 	 */
 	for (i = 0; i < len; i++) {
-		rxq->rx_ring[i] = zeroed_desc;
+		rxq->ixgbe_rx_ring[i] = zeroed_desc;
 	}
 
 	/*
@@ -3185,7 +3185,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			 struct rte_mempool *mp)
 {
 	const struct rte_memzone *rz;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ixgbe_hw     *hw;
 	uint16_t len;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
@@ -3214,7 +3214,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct ixgbe_rx_queue),
+	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (rxq == NULL)
 		return -ENOMEM;
@@ -3284,7 +3284,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
 
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union ixgbe_adv_rx_desc *) rz->addr;
+	rxq->ixgbe_rx_ring = (union ixgbe_adv_rx_desc *)rz->addr;
 
 	/*
 	 * Certain constraints must be met in order to use the bulk buffer
@@ -3309,7 +3309,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		len += IXGBE_RX_MAX_BURST;
 
 	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
-					  sizeof(struct ixgbe_rx_entry) * len,
+					  sizeof(struct ci_rx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq->sw_ring) {
 		ixgbe_rx_queue_release(rxq);
@@ -3326,7 +3326,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	rxq->sw_sc_ring =
 		rte_zmalloc_socket("rxq->sw_sc_ring",
-				   sizeof(struct ixgbe_scattered_rx_entry) * len,
+				   sizeof(struct ci_rx_entry_sc) * len,
 				   RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq->sw_sc_ring) {
 		ixgbe_rx_queue_release(rxq);
@@ -3335,7 +3335,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_LOG(DEBUG, "sw_ring=%p sw_sc_ring=%p hw_ring=%p "
 			    "dma_addr=0x%"PRIx64,
-		     rxq->sw_ring, rxq->sw_sc_ring, rxq->rx_ring,
+		     rxq->sw_ring, rxq->sw_sc_ring, rxq->ixgbe_rx_ring,
 		     rxq->rx_ring_phys_addr);
 
 	if (!rte_is_power_of_2(nb_desc)) {
@@ -3359,11 +3359,11 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
 {
 #define IXGBE_RXQ_SCAN_INTERVAL 4
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t desc = 0;
 
 	rxq = rx_queue;
-	rxdp = &(rxq->rx_ring[rxq->rx_tail]);
+	rxdp = &rxq->ixgbe_rx_ring[rxq->rx_tail];
 
 	while ((desc < rxq->nb_rx_desc) &&
 		(rxdp->wb.upper.status_error &
@@ -3371,7 +3371,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
 		desc += IXGBE_RXQ_SCAN_INTERVAL;
 		rxdp += IXGBE_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
-			rxdp = &(rxq->rx_ring[rxq->rx_tail +
+			rxdp = &(rxq->ixgbe_rx_ring[rxq->rx_tail +
 				desc - rxq->nb_rx_desc]);
 	}
 
@@ -3381,7 +3381,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
 int
 ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint32_t *status;
 	uint32_t nb_hold, desc;
 
@@ -3399,7 +3399,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (desc >= rxq->nb_rx_desc)
 		desc -= rxq->nb_rx_desc;
 
-	status = &rxq->rx_ring[desc].wb.upper.status_error;
+	status = &rxq->ixgbe_rx_ring[desc].wb.upper.status_error;
 	if (*status & rte_cpu_to_le_32(IXGBE_RXDADV_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
@@ -3482,7 +3482,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
 	}
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 		if (rxq != NULL) {
 			ixgbe_rx_queue_release_mbufs(rxq);
@@ -4644,9 +4644,9 @@ ixgbe_vmdq_tx_hw_configure(struct ixgbe_hw *hw)
 }
 
 static int __rte_cold
-ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 {
-	struct ixgbe_rx_entry *rxe = rxq->sw_ring;
+	struct ci_rx_entry *rxe = rxq->sw_ring;
 	uint64_t dma_addr;
 	unsigned int i;
 
@@ -4666,7 +4666,7 @@ ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
 
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
-		rxd = &rxq->rx_ring[i];
+		rxd = &rxq->ixgbe_rx_ring[i];
 		rxd->read.hdr_addr = 0;
 		rxd->read.pkt_addr = dma_addr;
 		rxe[i].mbuf = mbuf;
@@ -5083,7 +5083,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 		dev->rx_pkt_burst == ixgbe_recv_pkts_vec);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 		rxq->vector_rx = rx_using_sse;
 #ifdef RTE_LIB_SECURITY
@@ -5161,7 +5161,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
 
 	/* Per-queue RSC configuration (chapter 4.6.7.2.2 of 82599 Spec) */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		uint32_t srrctl =
 			IXGBE_READ_REG(hw, IXGBE_SRRCTL(rxq->reg_idx));
 		uint32_t rscctl =
@@ -5237,7 +5237,7 @@ int __rte_cold
 ixgbe_dev_rx_init(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint64_t bus_addr;
 	uint32_t rxctrl;
 	uint32_t fctrl;
@@ -5533,7 +5533,7 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
 	struct ci_tx_queue *txq;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t txdctl;
 	uint32_t dmatxctl;
 	uint32_t rxctrl;
@@ -5620,7 +5620,7 @@ int __rte_cold
 ixgbe_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t rxdctl;
 	int poll_ms;
 
@@ -5663,7 +5663,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ixgbe_hw     *hw;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t rxdctl;
 	int poll_ms;
 
@@ -5797,7 +5797,7 @@ void
 ixgbe_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
@@ -5835,7 +5835,7 @@ void
 ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
 
 	rxq = dev->data->rx_queues[queue_id];
@@ -5861,7 +5861,7 @@ int __rte_cold
 ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 	uint32_t frame_size = dev->data->mtu + IXGBE_ETH_OVERHEAD;
 	uint64_t bus_addr;
@@ -6048,7 +6048,7 @@ ixgbevf_dev_rxtx_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
 	struct ci_tx_queue *txq;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t txdctl;
 	uint32_t rxdctl;
 	uint16_t i;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 9047ee4763..aad7ee81ee 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -7,6 +7,7 @@
 
 #include "ixgbe_type.h"
 
+#include "../common/rx.h"
 #include "../common/tx.h"
 
 /*
@@ -32,7 +33,7 @@
 #define	IXGBE_MAX_RING_DESC	8192
 
 #define IXGBE_TX_MAX_BURST            32
-#define IXGBE_RX_MAX_BURST            32
+#define IXGBE_RX_MAX_BURST            CI_RX_MAX_BURST
 #define IXGBE_TX_MAX_FREE_BUF_SZ      64
 
 #define IXGBE_VPMD_DESCS_PER_LOOP     4
@@ -66,64 +67,6 @@
 #define IXGBE_PACKET_TYPE_TN_MAX            0X100
 #define IXGBE_PACKET_TYPE_SHIFT             0X04
 
-/**
- * Structure associated with each descriptor of the RX ring of a RX queue.
- */
-struct ixgbe_rx_entry {
-	struct rte_mbuf *mbuf; /**< mbuf associated with RX descriptor. */
-};
-
-struct ixgbe_scattered_rx_entry {
-	struct rte_mbuf *fbuf; /**< First segment of the fragmented packet. */
-};
-
-/**
- * Structure associated with each RX queue.
- */
-struct ixgbe_rx_queue {
-	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
-	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
-	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
-	volatile uint32_t   *qrx_tail; /**< RDT register address. */
-	struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring. */
-	struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scattered Rx software ring. */
-	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
-	struct rte_mbuf *pkt_last_seg; /**< Last segment of current packet. */
-	uint64_t            mbuf_initializer; /**< value to init mbufs */
-	uint16_t            nb_rx_desc; /**< number of RX descriptors. */
-	uint16_t            rx_tail;  /**< current value of RDT register. */
-	uint16_t            nb_rx_hold; /**< number of held free RX desc. */
-	uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app */
-	uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app */
-	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	uint8_t            vector_rx;
-	/**< indicates that vector RX is in use */
-#ifdef RTE_LIB_SECURITY
-	uint8_t            using_ipsec;
-	/**< indicates that IPsec RX feature is in use */
-#endif
-	uint16_t            rxrearm_nb;     /**< number of remaining to be re-armed */
-	uint16_t            rxrearm_start;  /**< the idx we start the re-arming from */
-	uint16_t            rx_free_thresh; /**< max free RX desc to hold. */
-	uint16_t            queue_id; /**< RX queue index. */
-	uint16_t            reg_idx;  /**< RX queue register index. */
-	uint16_t            pkt_type_mask;  /**< Packet type mask for different NICs. */
-	uint16_t            port_id;  /**< Device port identifier. */
-	uint8_t             crc_len;  /**< 0 if CRC stripped, 4 otherwise. */
-	uint8_t             drop_en;  /**< If not 0, set SRRCTL.Drop_En. */
-	uint8_t             rx_deferred_start; /**< not in global dev start. */
-	/** UDP frames with a 0 checksum can be marked as checksum errors. */
-	uint8_t             rx_udp_csum_zero_err;
-	/** flags to set in mbuf when a vlan is detected. */
-	uint64_t            vlan_flags;
-	uint64_t	    offloads; /**< Rx offloads with RTE_ETH_RX_OFFLOAD_* */
-	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
-	struct rte_mbuf fake_mbuf;
-	/** hold packets to return to application */
-	struct rte_mbuf *rx_stage[IXGBE_RX_MAX_BURST * 2];
-	const struct rte_memzone *mz;
-};
-
 /**
  * IXGBE CTX Constants
  */
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index 707dc7f5f9..5f231b9012 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -61,7 +61,7 @@ ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)
 }
 
 void __rte_cold
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	unsigned int i;
 
@@ -90,7 +90,7 @@ ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
 }
 
 int __rte_cold
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
+ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
@@ -126,7 +126,7 @@ ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 		return -1;
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
@@ -173,15 +173,15 @@ ixgbe_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 void
 ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
-	struct ixgbe_rx_entry *rxep;
+	struct ci_rx_queue *rxq = rx_queue;
+	struct ci_rx_entry *rxep;
 	volatile union ixgbe_adv_rx_desc *rxdp;
 	uint16_t rx_id;
 	uint64_t paddr;
 	uint64_t dma_addr;
 	uint16_t i;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
 	rxep = &rxq->sw_ring[rxq->rxrearm_start];
 
 	for (i = 0; i < nb_mbufs; i++) {
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index e05696f584..e54f532497 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -12,9 +12,9 @@
 #include "ixgbe_rxtx.h"
 
 int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
-int ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
+int ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq);
 int ixgbe_txq_vec_setup(struct ci_tx_queue *txq);
-void ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
+void ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 void ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq);
 void ixgbe_tx_free_swring_vec(struct ci_tx_queue *txq);
 uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
@@ -79,5 +79,4 @@ ixgbe_tx_free_bufs_vec(struct ci_tx_queue *txq)
 
 	return txq->tx_rs_thresh;
 }
-
 #endif
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 2d42b7b1c1..ce492f2ff1 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -12,19 +12,19 @@
 #include "ixgbe_rxtx_vec_common.h"
 
 static inline void
-ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
+ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	uint64x2_t dma_addr0, dma_addr1;
 	uint64x2_t zero = vdupq_n_u64(0);
 	uint64_t paddr;
 	uint8x8_t p;
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (unlikely(rte_mempool_get_bulk(rxq->mp,
@@ -282,11 +282,11 @@ desc_to_ptype_v(uint64x2_t descs[4], uint16_t pkt_type_mask,
  * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
 	uint8x16_t shuf_msk = {
@@ -309,7 +309,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rx_tail;
 
 	rte_prefetch_non_temporal(rxdp);
 
@@ -488,7 +488,7 @@ static uint16_t
 ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IXGBE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index f5bb7eb0bd..f977489b95 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -13,12 +13,12 @@
 #include <rte_vect.h>
 
 static inline void
-ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
+ixgbe_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	int i;
 	uint16_t rx_id;
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
+	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
 	struct rte_mbuf *mb0, *mb1;
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
@@ -26,7 +26,7 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 
 	const __m128i hba_msk = _mm_set_epi64x(0, UINT64_MAX);
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
@@ -327,11 +327,11 @@ desc_to_ptype_v(__m128i descs[4], uint16_t pkt_type_mask,
  * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
-_recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union ixgbe_adv_rx_desc *rxdp;
-	struct ixgbe_rx_entry *sw_ring;
+	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 #ifdef RTE_LIB_SECURITY
 	uint8_t use_ipsec = rxq->using_ipsec;
@@ -377,7 +377,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
 	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rx_tail;
 
 	rte_prefetch0(rxdp);
 
@@ -609,7 +609,7 @@ static uint16_t
 ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	uint8_t split_flags[IXGBE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
-- 
2.47.1

