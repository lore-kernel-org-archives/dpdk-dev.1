Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B61BC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:38:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A20FF41149;
	Mon,  9 Jun 2025 17:37:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7503F41143
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483472; x=1781019472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=09dg8NrAzZ41y7aeHduNJpsBbUKeg1wvlZRu7kZ9wH0=;
 b=giFteEdBmMV3vJ78lsiwAddjeMDZQgMWi2+ZjRv7sC8Y+m+76YCNYZ7u
 X6VfPOts1J5Oo4AYBlAfpAwT+oR3V7LR5xyQ5vol8ktDJFPUiGphl0V4B
 doGqa0E/V1VmnLi8a5ijGc+O7P5A/wjWtCTsg7eEx9tvZIbHJq+zciqab
 ApyR//955NQBCtBikhids0zfIya/UWuO5/gkxfcibnMNZJeSREb1/8OhX
 tleyJngoG+q1kTE6Hrz8XvAXspIYaOqQVe2gNRVIgsEO/Idg/rwqru/K9
 ejcAMZasb0Vn1neZCoriPEYqPa3Z62oV1EwChDwj5X3j5Ax5r6oXbkopY A==;
X-CSE-ConnectionGUID: ZZlaJnMATrOOveGngwlT4g==
X-CSE-MsgGUID: Gk94ngESSm6z3hL9OsaKQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012140"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012140"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:37:51 -0700
X-CSE-ConnectionGUID: avJndrU1SpaNOIIwffgXXg==
X-CSE-MsgGUID: gqpPgExdTvmHHQxeBWPSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419561"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:37:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 03/33] net/ixgbe: match variable names to other drivers
Date: Mon,  9 Jun 2025 16:37:01 +0100
Message-ID: <8cc442b025649d9bf764a2fc69fb05143caa5dac.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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

Currently, the ixgbe driver has variables that have the same semantics as
in other drivers, but have different names. Rename these variables to match
ones in other drivers:

- rdt_reg_addr -> qrx_tail (Rx ring tail register address)
- rx_using_sse -> vector_rx (indicates if vectorized path is enabled)
- mb_pool -> mp (other drivers use this name for mempool)

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Make this commit separate

 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 39 +++++++++----------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  6 +--
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  4 +-
 5 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
index c1b086ef6d..2ab7abbf4e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
@@ -42,7 +42,7 @@ ixgbe_recycle_rx_descriptors_refill_vec(void *rx_queue, uint16_t nb_mbufs)
 			(rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
 
 	/* Update the tail pointer on the NIC */
-	IXGBE_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+	IXGBE_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
 }
 
 uint16_t
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0c07ce3186..f75821029d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1679,7 +1679,7 @@ ixgbe_rx_alloc_bufs(struct ixgbe_rx_queue *rxq, bool reset_mbuf)
 	/* allocate buffers in bulk directly into the S/W ring */
 	alloc_idx = rxq->rx_free_trigger - (rxq->rx_free_thresh - 1);
 	rxep = &rxq->sw_ring[alloc_idx];
-	diag = rte_mempool_get_bulk(rxq->mb_pool, (void *)rxep,
+	diag = rte_mempool_get_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
 	if (unlikely(diag != 0))
 		return -ENOMEM;
@@ -1778,8 +1778,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		/* update tail pointer */
 		rte_wmb();
-		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr,
-					    cur_free_trigger);
+		IXGBE_PCI_REG_WC_WRITE_RELAXED(rxq->qrx_tail, cur_free_trigger);
 	}
 
 	if (rxq->rx_tail >= rxq->nb_rx_desc)
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
 
@@ -2974,7 +2973,7 @@ ixgbe_rx_queue_release_mbufs(struct ixgbe_rx_queue *rxq)
 	unsigned i;
 
 	/* SSE Vector driver has a different way of releasing mbufs. */
-	if (rxq->rx_using_sse) {
+	if (rxq->vector_rx) {
 		ixgbe_rx_queue_release_mbufs_vec(rxq);
 		return;
 	}
@@ -3238,7 +3237,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 				 RTE_CACHE_LINE_SIZE, socket_id);
 	if (rxq == NULL)
 		return -ENOMEM;
-	rxq->mb_pool = mp;
+	rxq->mp = mp;
 	rxq->nb_rx_desc = nb_desc;
 	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
 	rxq->queue_id = queue_idx;
@@ -3297,10 +3296,10 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -3409,7 +3408,7 @@ ixgbe_dev_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		return -EINVAL;
 
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	if (rxq->rx_using_sse)
+	if (rxq->vector_rx)
 		nb_hold = rxq->rxrearm_nb;
 	else
 #endif
@@ -4677,7 +4676,7 @@ ixgbe_alloc_rx_queue_mbufs(struct ixgbe_rx_queue *rxq)
 	/* Initialize software ring entries */
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
 		volatile union ixgbe_adv_rx_desc *rxd;
-		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mp);
 
 		if (mbuf == NULL) {
 			PMD_INIT_LOG(ERR, "RX mbuf alloc failed queue_id=%u",
@@ -5111,7 +5110,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		struct ixgbe_rx_queue *rxq = dev->data->rx_queues[i];
 
-		rxq->rx_using_sse = rx_using_sse;
+		rxq->vector_rx = rx_using_sse;
 #ifdef RTE_LIB_SECURITY
 		rxq->using_ipsec = !!(dev->data->dev_conf.rxmode.offloads &
 				RTE_ETH_RX_OFFLOAD_SECURITY);
@@ -5217,7 +5216,7 @@ ixgbe_set_rsc(struct rte_eth_dev *dev)
 		 */
 
 		rscctl |= IXGBE_RSCCTL_RSCEN;
-		rscctl |= ixgbe_get_rscctl_maxdesc(rxq->mb_pool);
+		rscctl |= ixgbe_get_rscctl_maxdesc(rxq->mp);
 		psrtype |= IXGBE_PSRTYPE_TCPHDR;
 
 		/*
@@ -5374,7 +5373,7 @@ ixgbe_dev_rx_init(struct rte_eth_dev *dev)
 		 * The value is in 1 KB resolution. Valid values can be from
 		 * 1 KB to 16 KB.
 		 */
-		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mp) -
 			RTE_PKTMBUF_HEADROOM);
 		srrctl |= ((buf_size >> IXGBE_SRRCTL_BSIZEPKT_SHIFT) &
 			   IXGBE_SRRCTL_BSIZEPKT_MASK);
@@ -5827,7 +5826,7 @@ ixgbe_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	rxq = dev->data->rx_queues[queue_id];
 
-	qinfo->mp = rxq->mb_pool;
+	qinfo->mp = rxq->mp;
 	qinfo->scattered_rx = dev->data->scattered_rx;
 	qinfo->nb_desc = rxq->nb_rx_desc;
 
@@ -5867,7 +5866,7 @@ ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq = dev->data->rx_queues[queue_id];
 
 	recycle_rxq_info->mbuf_ring = (void *)rxq->sw_ring;
-	recycle_rxq_info->mp = rxq->mb_pool;
+	recycle_rxq_info->mp = rxq->mp;
 	recycle_rxq_info->mbuf_ring_size = rxq->nb_rx_desc;
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
@@ -5972,7 +5971,7 @@ ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
 		 * The value is in 1 KB resolution. Valid values can be from
 		 * 1 KB to 16 KB.
 		 */
-		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
+		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mp) -
 			RTE_PKTMBUF_HEADROOM);
 		srrctl |= ((buf_size >> IXGBE_SRRCTL_BSIZEPKT_SHIFT) &
 			   IXGBE_SRRCTL_BSIZEPKT_MASK);
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 20a5c5a0af..c86714804f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -81,10 +81,10 @@ struct ixgbe_scattered_rx_entry {
  * Structure associated with each RX queue.
  */
 struct ixgbe_rx_queue {
-	struct rte_mempool  *mb_pool; /**< mbuf pool to populate RX ring. */
+	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
 	volatile union ixgbe_adv_rx_desc *rx_ring; /**< RX ring virtual address. */
 	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
-	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
+	volatile uint32_t   *qrx_tail; /**< RDT register address. */
 	struct ixgbe_rx_entry *sw_ring; /**< address of RX software ring. */
 	struct ixgbe_scattered_rx_entry *sw_sc_ring; /**< address of scattered Rx software ring. */
 	struct rte_mbuf *pkt_first_seg; /**< First segment of current packet. */
@@ -96,7 +96,7 @@ struct ixgbe_rx_queue {
 	uint16_t rx_nb_avail; /**< nr of staged pkts ready to ret to app */
 	uint16_t rx_next_avail; /**< idx of next staged pkt to ret to app */
 	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	uint8_t            rx_using_sse;
+	uint8_t            vector_rx;
 	/**< indicates that vector RX is in use */
 #ifdef RTE_LIB_SECURITY
 	uint8_t            using_ipsec;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index 9ccd8eba25..f8916d44e8 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -27,7 +27,7 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 	rxdp = rxq->rx_ring + rxq->rxrearm_start;
 
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
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index e125f52cc5..9417e5b11f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -29,7 +29,7 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 	rxdp = rxq->rx_ring + rxq->rxrearm_start;
 
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
-- 
2.47.1

