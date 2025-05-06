Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F97C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:28:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14A34060C;
	Tue,  6 May 2025 15:28:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id C7C2D4060B
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538094; x=1778074094;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jN0EeWcgqv7CR252c7+BurDpLPXE/1FTGDlWokbra4Q=;
 b=O/z3t1CfISXOXEhImkeevsk+My4XbuIFoZAynJ7burTUcbCgXGnkIU05
 sOyGWWkz3YaW01tzfzvzr/NrnnswB1RB6C5usfmblxmew7A5pXCIl42eN
 lJMVUQLlTk1sQbwNLYgItgYejY/UWNuk9Vy6PIotgO29/prMJsWCaLPB6
 vXCQx9tT8Uydo4jik94FujfbMKkBn27hoqQDEX6nD5sDXoy4cyNSrf355
 4Z3RFPmbs87UGKIouAxwg/SksVDyJsRE31zSfoEXxeoXQ9fTk2tcGxFVu
 c1ab8KD1ZKidTBUc1mE74v1+xXVFsGWRDsrmpSX0K9EE8RM6Xs9HEUc3E g==;
X-CSE-ConnectionGUID: zpyZ1LkCTiaUoMCk8t8iIA==
X-CSE-MsgGUID: ceW+/0FLTcmNQR6YjftnqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215277"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215277"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:13 -0700
X-CSE-ConnectionGUID: glic7Mk7RLq64OjBskEXOw==
X-CSE-MsgGUID: aLxxqjqMRVOQ+13OkNuTnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010767"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 03/13] net/ixgbe: create common Rx queue structure
Date: Tue,  6 May 2025 14:27:52 +0100
Message-ID: <17856bd49753429a2a4f155f3a14ebabae8fb27f.1746538072.git.anatoly.burakov@intel.com>
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

In preparation for deduplication effort, generalize the Rx queue structure.

Most of the fields are simply moved to common/rx.h, clarifying the comments
where necessary. There are some instances where the field is renamed when
moving, to make it more consistent with the rest of the codebase.

Specifically, the following fields are renamed:

- rdt_reg_addr -> qrx_tail (Rx ring tail register address)
- rx_using_sse -> vector_rx (indicates if vectorized path is enabled)
- mb_pool -> mp (other drivers use this name)

Additionally, some per-driver defines are now also moved to aforementioned
common Rx header, and re-defined in the driver using said common values.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/rx.h                 |  62 ++++++++
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    |   8 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 149 +++++++++---------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  67 +-------
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  22 +--
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  22 +--
 8 files changed, 172 insertions(+), 170 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index abb01ba5e7..524de39f9c 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -11,6 +11,68 @@
 #include <rte_ethdev.h>
 
 #define CI_RX_BURST 32
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
+			/** indicates that IPsec RX feature is in use */
+			uint8_t using_ipsec;
+			/** Packet type mask for different NICs. */
+			uint16_t pkt_type_mask;
+			/** UDP frames with a 0 checksum can be marked as checksum errors. */
+			uint8_t rx_udp_csum_zero_err;
+			/** flags to set in mbuf when a vlan is detected. */
+			uint64_t vlan_flags;
+		};
+	};
+};
 
 static inline uint16_t
 ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *split_flags,
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index f1fd271a0a..df1eecc3c1 100644
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
@@ -5789,7 +5789,7 @@ ixgbevf_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue, int on)
 static int
 ixgbevf_vlan_offload_config(struct rte_eth_dev *dev, int mask)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint16_t i;
 	int on = 0;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
index c1b086ef6d..1df1787c7f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
@@ -11,15 +11,15 @@
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
@@ -42,7 +42,7 @@ ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 			(rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
 
 	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
 }
 
 uint16_t
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0c07ce3186..4e4afd81e4 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1423,11 +1423,11 @@ int
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
 
@@ -1567,10 +1567,10 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status, uint16_t pkt_info,
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
@@ -1582,7 +1582,7 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
 	uint64_t vlan_flags = rxq->vlan_flags;
 
 	/* get references to current descriptor and S/W ring entry */
-	rxdp = &rxq->rx_ring[rxq->rx_tail];
+	rxdp = &rxq->ixgbe_rx_ring[rxq->rx_tail];
 	rxep = &rxq->sw_ring[rxq->rx_tail];
 
 	status = rxdp->wb.upper.status_error;
@@ -1667,10 +1667,10 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
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
@@ -1679,12 +1679,12 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
 	/* allocate buffers in bulk directly into the S/W ring */
 	alloc_idx = rxq->rx_free_trigger - (rxq->rx_free_thresh - 1);
 	rxep = &rxq->sw_ring[alloc_idx];
-	diag = rte_mempool_get_bulk(rxq->mb_pool, (void *)rxep,
+	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 	if (unlikely(diag != 0))
 		return -ENOMEM;
 
-	rxdp = &rxq->rx_ring[alloc_idx];
+	rxdp = &rxq->ixgbe_rx_ring[alloc_idx];
 	for (i = 0; i < rxq->rx_free_thresh; ++i) {
 		/* populate the static rte mbuf fields */
 		mb = rxep[i].mbuf;
@@ -1711,7 +1711,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
 }
 
 static inline uint16_t
-ixgbe_rx_fill_from_stage(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+ixgbe_rx_fill_from_stage(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
 	struct rte_mbuf **stage = &rxq->rx_stage[rxq->rx_next_avail];
@@ -1735,7 +1735,7 @@ static inline uint16_t
 rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	     uint16_t nb_pkts)
 {
-	struct ixgbe_rx_queue *rxq = (struct ixgbe_rx_queue *)rx_queue;
+	struct ci_rx_queue *rxq = (struct ci_rx_queue *)rx_queue;
 	uint16_t nb_rx = 0;
 
 	/* Any previously recv'd pkts will be returned from the Rx stage */
@@ -1778,8 +1778,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		/* update tail pointer */
 		rte_wmb();
-		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr,
-					    cur_free_trigger);
+		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->qrx_tail, cur_free_trigger);
 	}
 
 	if (rxq->rx_tail >= rxq->nb_rx_desc)
@@ -1825,11 +1824,11 @@ uint16_t
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
@@ -1847,7 +1846,7 @@ ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	nb_hold = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
-	rx_ring = rxq->rx_ring;
+	rx_ring = rxq->ixgbe_rx_ring;
 	sw_ring = rxq->sw_ring;
 	vlan_flags = rxq->vlan_flags;
 	while (nb_rx < nb_pkts) {
@@ -1908,7 +1907,7 @@ ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) rx_id, (unsigned) staterr,
 			   (unsigned) rte_le_to_cpu_16(rxd.wb.upper.length));
 
-		nmb = rte_mbuf_raw_alloc(rxq->mb_pool);
+		nmb = rte_mbuf_raw_alloc(rxq->mp);
 		if (nmb == NULL) {
 			PMD_RX_LOG(DEBUG, "RX mbuf alloc failed port_id=%u "
 				   "queue_id=%u", (unsigned) rxq->port_id,
@@ -2017,7 +2016,7 @@ ixgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   (unsigned) nb_rx);
 		rx_id = (uint16_t) ((rx_id == 0) ?
 				     (rxq->nb_rx_desc - 1) : (rx_id - 1));
-		IXGBE_PCI_REG_WC_WRITE(rxq->rdt_reg_addr, rx_id);
+		IXGBE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
 		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
@@ -2052,7 +2051,7 @@ static inline void
 ixgbe_fill_cluster_head_buf(
 	struct rte_mbuf *head,
 	union ixgbe_adv_rx_desc *desc,
-	struct ixgbe_rx_queue *rxq,
+	struct ci_rx_queue *rxq,
 	uint32_t staterr)
 {
 	uint32_t pkt_info;
@@ -2114,10 +2113,10 @@ static inline uint16_t
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
@@ -2125,10 +2124,10 @@ ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 
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
@@ -2165,7 +2164,7 @@ ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 			   rte_le_to_cpu_16(rxd.wb.upper.length));
 
 		if (!bulk_alloc) {
-			nmb = rte_mbuf_raw_alloc(rxq->mb_pool);
+			nmb = rte_mbuf_raw_alloc(rxq->mp);
 			if (nmb == NULL) {
 				PMD_RX_LOG(DEBUG, "RX mbuf alloc failed "
 						  "port_id=%u queue_id=%u",
@@ -2181,7 +2180,7 @@ ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 			if (!ixgbe_rx_alloc_bufs(rxq, false)) {
 				rte_wmb();
 				IXGBE_PCI_REG_WC_WRITE_RELAXED(
-							rxq->rdt_reg_addr,
+							rxq->qrx_tail,
 							next_rdt);
 				nb_hold -= rxq->rx_free_thresh;
 			} else {
@@ -2347,7 +2346,7 @@ ixgbe_recv_pkts_lro(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts,
 			   rxq->port_id, rxq->queue_id, rx_id, nb_hold, nb_rx);
 
 		rte_wmb();
-		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr, prev_id);
+		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->qrx_tail, prev_id);
 		nb_hold = 0;
 	}
 
@@ -2969,12 +2968,12 @@ ixgbe_free_sc_cluster(struct rte_mbuf *m)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	unsigned i;
 
 	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->rx_using_sse) {
+	if (rxq->vector_rx) {
 		ixgbe_rx_queue_release_mbufs_vec(rxq);
 		return;
 	}
@@ -3006,7 +3005,7 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 }
 
 static void __rte_cold
-ixgbe_rx_queue_release(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release(struct ci_rx_queue *rxq)
 {
 	if (rxq != NULL) {
 		ixgbe_rx_queue_release_mbufs(rxq);
@@ -3032,7 +3031,7 @@ ixgbe_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
  *           function must be used.
  */
 static inline int __rte_cold
-check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
+check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
 {
 	int ret = 0;
 
@@ -3069,7 +3068,7 @@ check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
 
 /* Reset dynamic ixgbe_rx_queue fields back to defaults */
 static void __rte_cold
-ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
+ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ci_rx_queue *rxq)
 {
 	static const union ixgbe_adv_rx_desc zeroed_desc = {{0}};
 	unsigned i;
@@ -3090,7 +3089,7 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
 	 * reads extra memory as zeros.
 	 */
 	for (i = 0; i < len; i++) {
-		rxq->rx_ring[i] = zeroed_desc;
+		rxq->ixgbe_rx_ring[i] = zeroed_desc;
 	}
 
 	/*
@@ -3205,7 +3204,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			 struct rte_mempool *mp)
 {
 	const struct rte_memzone *rz;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ixgbe_hw     *hw;
 	uint16_t len;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
@@ -3234,11 +3233,11 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* First allocate the rx queue data structure */
-	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct ixgbe_rx_queue),
+	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct ci_rx_queue),
 				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (rxq == NULL)
 		return -ENOMEM;
-	rxq->mb_pool = mp;
+	rxq->mp = mp;
 	rxq->nb_rx_desc = nb_desc;
 	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
 	rxq->queue_id = queue_idx;
@@ -3297,14 +3296,14 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * Modified to setup VFRDT for Virtual Function
 	 */
 	if (ixgbe_is_vf(dev))
-		rxq->rdt_reg_addr =
+		rxq->qrx_tail =
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
 	else
-		rxq->rdt_reg_addr =
+		rxq->qrx_tail =
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_RDT(rxq->reg_idx));
 
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union ixgbe_adv_rx_desc *) rz->addr;
+	rxq->ixgbe_rx_ring = (union ixgbe_adv_rx_desc *)rz->addr;
 
 	/*
 	 * Certain constraints must be met in order to use the bulk buffer
@@ -3329,7 +3328,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		len += RTE_PMD_IXGBE_RX_MAX_BURST;
 
 	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
-					  sizeof(struct ixgbe_rx_entry) * len,
+					  sizeof(struct ci_rx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq->sw_ring) {
 		ixgbe_rx_queue_release(rxq);
@@ -3346,7 +3345,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	rxq->sw_sc_ring =
 		rte_zmalloc_socket("rxq->sw_sc_ring",
-				   sizeof(struct ixgbe_scattered_rx_entry) * len,
+				   sizeof(struct ci_rx_entry_sc) * len,
 				   RTE_CACHE_LINE_SIZE, socket_id);
 	if (!rxq->sw_sc_ring) {
 		ixgbe_rx_queue_release(rxq);
@@ -3355,7 +3354,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_LOG(DEBUG, "sw_ring=%p sw_sc_ring=%p hw_ring=%p "
 			    "dma_addr=0x%"PRIx64,
-		     rxq->sw_ring, rxq->sw_sc_ring, rxq->rx_ring,
+		     rxq->sw_ring, rxq->sw_sc_ring, rxq->ixgbe_rx_ring,
 		     rxq->rx_ring_phys_addr);
 
 	if (!rte_is_power_of_2(nb_desc)) {
@@ -3379,11 +3378,11 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
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
@@ -3391,7 +3390,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
 		desc += IXGBE_RXQ_SCAN_INTERVAL;
 		rxdp += IXGBE_RXQ_SCAN_INTERVAL;
 		if (rxq->rx_tail + desc >= rxq->nb_rx_desc)
-			rxdp = &(rxq->rx_ring[rxq->rx_tail +
+			rxdp = &(rxq->ixgbe_rx_ring[rxq->rx_tail +
 				desc - rxq->nb_rx_desc]);
 	}
 
@@ -3401,7 +3400,7 @@ ixgbe_dev_rx_queue_count(void *rx_queue)
 int
 ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 {
-	struct ixgbe_rx_queue *rxq = rx_queue;
+	struct ci_rx_queue *rxq = rx_queue;
 	volatile uint32_t *status;
 	uint32_t nb_hold, desc;
 
@@ -3409,7 +3408,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		return -EINVAL;
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	if (rxq->rx_using_sse)
+	if (rxq->vector_rx)
 		nb_hold = rxq->rxrearm_nb;
 	else
 #endif
@@ -3421,7 +3420,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 	if (desc >= rxq->nb_rx_desc)
 		desc -= rxq->nb_rx_desc;
 
-	status = &rxq->rx_ring[desc].wb.upper.status_error;
+	status = &rxq->ixgbe_rx_ring[desc].wb.upper.status_error;
 	if (*status & rte_cpu_to_le_32(IXGBE_RXDADV_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
@@ -3506,7 +3505,7 @@ ixgbe_dev_clear_queues(struct rte_eth_dev *dev)
 	}
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
 		if (rxq != NULL) {
 			ixgbe_rx_queue_release_mbufs(rxq);
@@ -4668,16 +4667,16 @@ ixgbe_vmdq_tx_hw_configure(struct ixgbe_hw *hw)
 }
 
 static int __rte_cold
-ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
+ixgbe_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 {
-	struct ixgbe_rx_entry *rxe = rxq->sw_ring;
+	struct ci_rx_entry *rxe = rxq->sw_ring;
 	uint64_t dma_addr;
 	unsigned int i;
 
 	/* Initialize software ring entries */
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
 		volatile union ixgbe_adv_rx_desc *rxd;
-		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mp);
 
 		if (mbuf == NULL) {
 			PMD_INIT_LOG(ERR, "RX mbuf alloc failed queue_id=%u",
@@ -4690,7 +4689,7 @@ ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
 
 		dma_addr =
 			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
-		rxd = &rxq->rx_ring[i];
+		rxd = &rxq->ixgbe_rx_ring[i];
 		rxd->read.hdr_addr = 0;
 		rxd->read.pkt_addr = dma_addr;
 		rxe[i].mbuf = mbuf;
@@ -5109,9 +5108,9 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 		dev->rx_pkt_burst == ixgbe_recv_pkts_vec);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 
-		rxq->rx_using_sse = rx_using_sse;
+		rxq->vector_rx = rx_using_sse;
 #ifdef RTE_LIB_SECURITY
 		rxq->using_ipsec = !!(dev->data->dev_conf.rxmode.offloads &
 				RTE_ETH_RX_OFFLOAD_SECURITY);
@@ -5187,7 +5186,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
 
 	/* Per-queue RSC configuration (chapter 4.6.7.2.2 of 82599 Spec) */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		uint32_t srrctl =
 			IXGBE_READ_REG(hw, IXGBE_SRRCTL(rxq->reg_idx));
 		uint32_t rscctl =
@@ -5217,7 +5216,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
 		 */
 
 		rscctl |= IXGBE_RSCCTL_RSCEN;
-		rscctl |= ixgbe_get_rscctl_maxdesc(rxq->mb_pool);
+		rscctl |= ixgbe_get_rscctl_maxdesc(rxq->mp);
 		psrtype |= IXGBE_PSRTYPE_TCPHDR;
 
 		/*
@@ -5263,7 +5262,7 @@ int __rte_cold
 ixgbe_dev_rx_init(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint64_t bus_addr;
 	uint32_t rxctrl;
 	uint32_t fctrl;
@@ -5374,7 +5373,7 @@ ixgbe_dev_rx_init(struct rte_eth_dev *dev)
 		 * The value is in 1 KB resolution. Valid values can be from
 		 * 1 KB to 16 KB.
 		 */
-		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mp) -
 			RTE_PKTMBUF_HEADROOM);
 		srrctl |= ((buf_size >> IXGBE_SRRCTL_BSIZEPKT_SHIFT) &
 			   IXGBE_SRRCTL_BSIZEPKT_MASK);
@@ -5559,7 +5558,7 @@ ixgbe_dev_rxtx_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
 	struct ci_tx_queue *txq;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t txdctl;
 	uint32_t dmatxctl;
 	uint32_t rxctrl;
@@ -5646,7 +5645,7 @@ int __rte_cold
 ixgbe_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t rxdctl;
 	int poll_ms;
 
@@ -5689,7 +5688,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
 	struct ixgbe_hw     *hw;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t rxdctl;
 	int poll_ms;
 
@@ -5823,11 +5822,11 @@ void
 ixgbe_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_rxq_info *qinfo)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 
 	rxq = dev->data->rx_queues[queue_id];
 
-	qinfo->mp = rxq->mb_pool;
+	qinfo->mp = rxq->mp;
 	qinfo->scattered_rx = dev->data->scattered_rx;
 	qinfo->nb_desc = rxq->nb_rx_desc;
 
@@ -5861,13 +5860,13 @@ void
 ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct ixgbe_adapter *adapter = dev->data->dev_private;
 
 	rxq = dev->data->rx_queues[queue_id];
 
 	recycle_rxq_info->mbuf_ring = (void *)rxq->sw_ring;
-	recycle_rxq_info->mp = rxq->mb_pool;
+	recycle_rxq_info->mp = rxq->mp;
 	recycle_rxq_info->mbuf_ring_size = rxq->nb_rx_desc;
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
@@ -5889,7 +5888,7 @@ int __rte_cold
 ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 	uint32_t frame_size = dev->data->mtu + IXGBE_ETH_OVERHEAD;
 	uint64_t bus_addr;
@@ -5972,7 +5971,7 @@ ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
 		 * The value is in 1 KB resolution. Valid values can be from
 		 * 1 KB to 16 KB.
 		 */
-		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mp) -
 			RTE_PKTMBUF_HEADROOM);
 		srrctl |= ((buf_size >> IXGBE_SRRCTL_BSIZEPKT_SHIFT) &
 			   IXGBE_SRRCTL_BSIZEPKT_MASK);
@@ -6076,7 +6075,7 @@ ixgbevf_dev_rxtx_start(struct rte_eth_dev *dev)
 {
 	struct ixgbe_hw     *hw;
 	struct ci_tx_queue *txq;
-	struct ixgbe_rx_queue *rxq;
+	struct ci_rx_queue *rxq;
 	uint32_t txdctl;
 	uint32_t rxdctl;
 	uint16_t i;
@@ -6270,7 +6269,7 @@ ixgbe_recv_scattered_pkts_vec(
 }
 
 int
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue __rte_unused *rxq)
+ixgbe_rxq_vec_setup(struct ci_rx_queue __rte_unused * rxq)
 {
 	return -1;
 }
@@ -6290,7 +6289,7 @@ ixgbe_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
 }
 
 void
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue __rte_unused *rxq)
+ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue __rte_unused * rxq)
 {
 	return;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 20a5c5a0af..84e28eb254 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -5,6 +5,7 @@
 #ifndef _IXGBE_RXTX_H_
 #define _IXGBE_RXTX_H_
 
+#include "../common/rx.h"
 #include "../common/tx.h"
 
 /*
@@ -30,7 +31,7 @@
 #define	IXGBE_MAX_RING_DESC	8192
 
 #define RTE_PMD_IXGBE_TX_MAX_BURST 32
-#define RTE_PMD_IXGBE_RX_MAX_BURST 32
+#define RTE_PMD_IXGBE_RX_MAX_BURST CI_RX_MAX_BURST
 #define RTE_IXGBE_TX_MAX_FREE_BUF_SZ 64
 
 #define RTE_IXGBE_DESCS_PER_LOOP    4
@@ -66,66 +67,6 @@
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
-	struct rte_mempool  *mb_pool; /**< mbuf pool to populate RX ring. */
-	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
-	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
-	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
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
-	uint8_t            rx_using_sse;
-	/**< indicates that vector RX is in use */
-#ifdef RTE_LIB_SECURITY
-	uint8_t            using_ipsec;
-	/**< indicates that IPsec RX feature is in use */
-#endif
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
-	uint16_t            rxrearm_nb;     /**< number of remaining to be re-armed */
-	uint16_t            rxrearm_start;  /**< the idx we start the re-arming from */
-#endif
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
-	struct rte_mbuf *rx_stage[RTE_PMD_IXGBE_RX_MAX_BURST*2];
-	const struct rte_memzone *mz;
-};
-
 /**
  * IXGBE CTX Constants
  */
@@ -230,8 +171,8 @@ uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 uint16_t ixgbe_recv_scattered_pkts_vec(void *rx_queue,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 int ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
-int ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq);
-void ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq);
+int ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq);
+void ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 int ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt);
 
 extern const uint32_t ptype_table[IXGBE_PACKET_TYPE_MAX];
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 018010820f..0ba3d7a4c0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -69,7 +69,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 }
 
 static inline void
-_ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
+_ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	unsigned int i;
 
@@ -173,7 +173,7 @@ ixgbe_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 		return -1;
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
-		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
+		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
 		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 9ccd8eba25..630a2e6a1d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -12,22 +12,22 @@
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
-	if (unlikely(rte_mempool_get_bulk(rxq->mb_pool,
+	if (unlikely(rte_mempool_get_bulk(rxq->mp,
 					  (void *)rxep,
 					  RTE_IXGBE_RXQ_REARM_THRESH) < 0)) {
 		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
@@ -76,7 +76,7 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
 
 	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
 }
 
 static inline void
@@ -282,11 +282,11 @@ desc_to_ptype_v(uint64x2_t descs[4], uint16_t pkt_type_mask,
  * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
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
 	uint8_t split_flags[RTE_IXGBE_MAX_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -634,7 +634,7 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_ixgbe_rx_queue_release_mbufs_vec(rxq);
 }
@@ -657,7 +657,7 @@ static const struct ixgbe_txq_ops vec_txq_ops = {
 };
 
 int __rte_cold
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
+ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index e125f52cc5..ecfb0d6ba6 100644
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
@@ -26,10 +26,10 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 
 	const __m128i hba_msk = _mm_set_epi64x(0, UINT64_MAX);
 
-	rxdp = rxq->rx_ring + rxq->rxrearm_start;
+	rxdp = rxq->ixgbe_rx_ring + rxq->rxrearm_start;
 
 	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mb_pool,
+	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
 				 RTE_IXGBE_RXQ_REARM_THRESH) < 0) {
 		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
@@ -86,7 +86,7 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
 
 	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WC_WRITE(rxq->rdt_reg_addr, rx_id);
+	IXGBE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
 }
 
 #ifdef RTE_LIB_SECURITY
@@ -327,11 +327,11 @@ desc_to_ptype_v(__m128i descs[4], uint16_t pkt_type_mask,
  * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
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
 	uint8_t split_flags[RTE_IXGBE_MAX_RX_BURST] = {0};
 
 	/* get some new buffers */
@@ -755,7 +755,7 @@ ixgbe_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 void __rte_cold
-ixgbe_rx_queue_release_mbufs_vec(struct ixgbe_rx_queue *rxq)
+ixgbe_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 {
 	_ixgbe_rx_queue_release_mbufs_vec(rxq);
 }
@@ -778,7 +778,7 @@ static const struct ixgbe_txq_ops vec_txq_ops = {
 };
 
 int __rte_cold
-ixgbe_rxq_vec_setup(struct ixgbe_rx_queue *rxq)
+ixgbe_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
 	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
 	return 0;
-- 
2.47.1

