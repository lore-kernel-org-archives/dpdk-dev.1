Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3574DCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4E1540DF8;
	Fri, 19 Jun 2026 20:44:41 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id D5F454028F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B91701A0025;
 Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 538171A0020;
 Fri, 19 Jun 2026 20:44:31 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D3ECF180004C;
 Sat, 20 Jun 2026 02:44:30 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 10/10] net/enetc4: add cacheable BD ring support with SW cache
 maintenance
Date: Sat, 20 Jun 2026 00:14:27 +0530
Message-Id: <20260619184427.522518-11-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

On non-cache-coherent platforms such as i.MX95, the BD ring memory
may be mapped as cacheable (normal memory) while the ENETC hardware
DMA engine writes and reads descriptors without CPU cache snooping.
SW must therefore perform explicit cache maintenance to keep CPU
caches and DDR coherent.

TX path (enetc_xmit_pkts_cacheable):
  - Flush each segment's payload cache lines to PoC (dcbf) before
    the BD is handed to HW, so HW DMA reads the correct data.
  - After all BDs for a burst are written, flush the BD cache lines
    (dcbf, one per 64-byte group of 4 BDs) so HW can read the
    updated descriptors.

RX refill (enetc_refill_rx_ring):
  - After writing each full 4-BD cache-line group, dcbf that group
    so HW sees the buffer addresses and cleared lstatus fields.
  - Flush any partial trailing group before updating the ring tail.

RX receive (enetc_recv_pkts_cacheable via enetc_clean_rx_ring_cacheable):
  - Before reading BD status, dccivac the current BD cache line so
    stale CPU-cached BD data is discarded and fresh HW-written
    content is fetched from DDR.
  - After a BD is consumed, dccivac each payload cache line so the
    CPU reads the DMA'd packet data, not stale cached bytes.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/enetc.h         |  21 +++
 drivers/net/enetc/enetc4_ethdev.c |  40 +++--
 drivers/net/enetc/enetc_rxtx.c    | 274 ++++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+), 15 deletions(-)

diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 99b1e91..9f98480 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -96,6 +96,7 @@ struct enetc_bdr {
 	uint64_t ierrors;
 	uint8_t rx_deferred_start;
 	uint8_t tx_deferred_start;
+	uint64_t bd_base_p;
 };
 
 struct enetc_eth_hw {
@@ -312,8 +313,28 @@ uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
+uint16_t enetc_xmit_pkts_cacheable(void *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts);
+uint16_t enetc_recv_pkts_cacheable(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts);
 
 int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
+
+/*
+ * Cache-maintenance constants for cacheable BD ring mode.
+ *
+ * BD = 16 bytes, cache line = 64 bytes => 4 BDs per cache line.
+ * Every dcbf in enetc_refill_rx_ring() flushes a full 64-byte cache line.
+ * To ensure each dcbf covers only fully-written BDs the caller
+ * must pass a count rounded DOWN to a multiple of ENETC_BD_PER_CL so that
+ * the last partial group is left in cache to be completed and flushed in
+ * the next call.
+ */
+#define ENETC_BD_PER_CL		(RTE_CACHE_LINE_SIZE / sizeof(union enetc_rx_bd))
+#define ENETC_BD_PER_CL_MASK	(ENETC_BD_PER_CL - 1)
+/* Round n DOWN to the nearest multiple of ENETC_BD_PER_CL. */
+#define ENETC_BD_ALIGN_DOWN(n)	((n) & ~(unsigned int)ENETC_BD_PER_CL_MASK)
+
 void enetc4_dev_hw_init(struct rte_eth_dev *eth_dev);
 void enetc_print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr);
 
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index d54051f..04dc306 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -281,12 +281,14 @@ enetc4_alloc_txbdr(struct enetc_bdr *txr, uint16_t nb_desc)
 	int size;
 
 	size = nb_desc * sizeof(struct enetc_swbd);
-	txr->q_swbd = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	/* Zero q_swbd so buffer_addr is NULL for all uninitialized slots. */
+	txr->q_swbd = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (txr->q_swbd == NULL)
 		return -ENOMEM;
 
-	size = nb_desc * sizeof(struct enetc_bdr);
-	txr->bd_base = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	/* Allocate the TX BD ring: each BD is struct enetc_tx_bd (16 bytes). */
+	size = nb_desc * sizeof(struct enetc_tx_bd);
+	txr->bd_base = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (txr->bd_base == NULL) {
 		rte_free(txr->q_swbd);
 		txr->q_swbd = NULL;
@@ -441,12 +443,14 @@ enetc4_alloc_rxbdr(struct enetc_bdr *rxr, uint16_t nb_desc)
 	int size;
 
 	size = nb_desc * sizeof(struct enetc_swbd);
-	rxr->q_swbd = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	/* Zero q_swbd so buffer_addr is NULL for all uninitialized slots. */
+	rxr->q_swbd = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (rxr->q_swbd == NULL)
 		return -ENOMEM;
 
-	size = nb_desc * sizeof(struct enetc_bdr);
-	rxr->bd_base = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	/* Allocate the RX BD ring: each BD is union enetc_rx_bd (16 bytes). */
+	size = nb_desc * sizeof(union enetc_rx_bd);
+	rxr->bd_base = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (rxr->bd_base == NULL) {
 		rte_free(rxr->q_swbd);
 		rxr->q_swbd = NULL;
@@ -481,7 +485,7 @@ enetc4_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 	rx_ring->mb_pool = mb_pool;
 	rx_ring->rcir = (void *)((size_t)hw->reg +
 			ENETC_BDR(RX, idx, ENETC_RBCIR));
-	enetc_refill_rx_ring(rx_ring, (enetc_bd_unused(rx_ring)));
+	enetc_refill_rx_ring(rx_ring, ENETC_BD_ALIGN_DOWN(enetc_bd_unused(rx_ring)));
 	buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rx_ring->mb_pool) -
 		   RTE_PKTMBUF_HEADROOM);
 	enetc4_rxbdr_wr(hw, idx, ENETC_RBBSR, buf_size);
@@ -743,12 +747,17 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	max_len = dev->data->dev_conf.rxmode.mtu + RTE_ETHER_HDR_LEN +
-		  RTE_ETHER_CRC_LEN;
-	enetc4_port_wr(enetc_hw, ENETC4_PM_MAXFRM(0), ENETC_SET_MAXFRM(max_len));
+	/* Port-level register writes are PF-only; skip for VF devices */
+	if (hw->device_id != ENETC4_DEV_ID_VF) {
+		max_len = dev->data->dev_conf.rxmode.mtu + RTE_ETHER_HDR_LEN +
+			  RTE_ETHER_CRC_LEN;
+		enetc4_port_wr(enetc_hw, ENETC4_PM_MAXFRM(0),
+			       ENETC_SET_MAXFRM(max_len));
 
-	val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
-	enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0), val | SDU_TYPE_MPDU);
+		val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
+		enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0),
+			       val | SDU_TYPE_MPDU);
+	}
 
 	/* Rx offloads which are enabled by default */
 	if (dev_rx_offloads_sup & ~rx_offloads) {
@@ -770,7 +779,8 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	if (rx_offloads & (RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM))
 		checksum &= ~L4_CKSUM;
 
-	enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
+	if (hw->device_id != ENETC4_DEV_ID_VF)
+		enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
 
 	/* Enable interrupts */
 	if (hw->device_id == ENETC4_DEV_ID_VF) {
@@ -1033,8 +1043,8 @@ enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
-	eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
+	eth_dev->rx_pkt_burst = &enetc_recv_pkts_cacheable;
+	eth_dev->tx_pkt_burst = &enetc_xmit_pkts_cacheable;
 
 	/* Retrieving and storing the HW base address of device */
 	hw->hw.reg = (void *)pci_dev->mem_resource[0].addr;
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index a37c835..c737b22 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -26,6 +26,7 @@ enetc_clean_tx_ring(struct enetc_bdr *tx_ring)
 	struct enetc_swbd *tx_swbd, *tx_swbd_base;
 	int i, hwci, bd_count;
 	struct rte_mbuf *m[ENETC_RXBD_BUNDLE];
+	struct enetc_tx_bd *txbd;
 
 	/* we don't need barriers here, we just want a relatively current value
 	 * from HW.
@@ -51,6 +52,13 @@ enetc_clean_tx_ring(struct enetc_bdr *tx_ring)
 		/* It seems calling rte_pktmbuf_free is wasting a lot of cycles,
 		 * make a list and call _free when it's done.
 		 */
+		/* Clear flags on the reclaimed BD so that dcbf in the
+		 * cacheable TX path never flushes a stale flags_F to memory
+		 * before the new BD fields are fully written.
+		 */
+		txbd = ENETC_TXBD(*tx_ring, i);
+		txbd->flags = 0;
+
 		if (tx_frm_cnt == ENETC_RXBD_BUNDLE) {
 			rte_pktmbuf_free_bulk(m, tx_frm_cnt);
 			tx_frm_cnt = 0;
@@ -217,6 +225,7 @@ enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 {
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd;
+	union enetc_rx_bd *grp_start_rxbd;
 	int i, j, k = ENETC_RXBD_BUNDLE;
 	struct rte_mbuf *m[ENETC_RXBD_BUNDLE];
 	struct rte_mempool *mb_pool;
@@ -225,6 +234,7 @@ enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 	mb_pool = rx_ring->mb_pool;
 	rx_swbd = &rx_ring->q_swbd[i];
 	rxbd = ENETC_RXBD(*rx_ring, i);
+	grp_start_rxbd = rxbd;
 	for (j = 0; j < buff_cnt; j++) {
 		/* bulk alloc for the next up to 8 BDs */
 		if (k == ENETC_RXBD_BUNDLE) {
@@ -246,12 +256,29 @@ enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 		i++;
 		k++;
 		if (unlikely(i == rx_ring->bd_count)) {
+			/*
+			 * Ring wrap: flush the current partial or full group
+			 * before resetting the pointer to index 0.
+			 */
+			dcbf((void *)grp_start_rxbd);
 			i = 0;
 			rxbd = ENETC_RXBD(*rx_ring, i);
 			rx_swbd = &rx_ring->q_swbd[i];
+			grp_start_rxbd = rxbd;
+		} else if ((i & ENETC_BD_PER_CL_MASK) == 0) {
+			/*
+			 * Completed a full 4-BD group (one cache line).
+			 * Flush it to PoC so HW sees the updated descriptors.
+			 */
+			dcbf((void *)grp_start_rxbd);
+			grp_start_rxbd = rxbd;
 		}
 	}
 
+	/* Flush any remaining partial group at the end of the fill. */
+	if (j && (i & ENETC_BD_PER_CL_MASK) != 0)
+		dcbf((void *)grp_start_rxbd);
+
 	if (likely(j)) {
 		rx_ring->next_to_alloc = i;
 		rx_ring->next_to_use = i;
@@ -597,3 +624,250 @@ enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 
 	return enetc_clean_rx_ring(rx_ring, rx_pkts, nb_pkts);
 }
+
+/* --- Cacheable BD ring TX path with SW cache maintenance (dcbf) --- */
+
+uint16_t
+enetc_xmit_pkts_cacheable(void *tx_queue,
+		struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts)
+{
+	int i, start, bds_to_use;
+	struct enetc_tx_bd *txbd;
+	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
+	unsigned int j;
+	uint8_t *data;
+	struct rte_mbuf *seg;
+	uint16_t seg_len, segs_per_pkt;
+	bool is_first_seg;
+	int first_bd_idx, bd_count;
+
+	i = tx_ring->next_to_use;
+	bds_to_use = enetc_bd_unused(tx_ring);
+	bd_count = tx_ring->bd_count;
+	start = 0;
+
+	/*
+	 * Remember the first BD index of this batch so we can flush the
+	 * BD cache lines to PoC after all descriptors are written.
+	 */
+	first_bd_idx = i;
+
+	while (start < nb_pkts) {
+		seg = tx_pkts[start];
+		segs_per_pkt = seg->nb_segs;
+
+		if (bds_to_use < segs_per_pkt)
+			break;
+
+		is_first_seg = true;
+		while (seg) {
+			tx_ring->q_swbd[i].buffer_addr = NULL;
+			seg_len = rte_pktmbuf_data_len(seg);
+			data = rte_pktmbuf_mtod(seg, void *);
+
+			/*
+			 * Flush packet data cache lines to PoC so HW DMA
+			 * reads the correct payload from memory.
+			 */
+			for (j = 0; j < seg_len; j += RTE_CACHE_LINE_SIZE)
+				dcbf(data + j);
+
+			/*
+			 * Cover the last byte of an unaligned buffer to
+			 * ensure the full payload is clean to the Point of
+			 * Coherency.
+			 */
+			dcbf(data + (seg_len - 1));
+			txbd = ENETC_TXBD(*tx_ring, i);
+			txbd->flags = 0;
+			if (is_first_seg) {
+				tx_ring->q_swbd[i].buffer_addr = seg;
+				txbd->frm_len = rte_pktmbuf_pkt_len(seg);
+				if (seg->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
+					enetc4_tx_offload_checksum(seg, txbd);
+				is_first_seg = false;
+			}
+
+			txbd->buf_len = rte_cpu_to_le_16(seg_len);
+			txbd->addr = rte_cpu_to_le_64(rte_mbuf_data_iova(seg));
+			seg = seg->next;
+			i++;
+			bds_to_use--;
+
+			if (unlikely(i == bd_count))
+				i = 0;
+		}
+
+		/*
+		 * Set the frame-last flag on the final BD of this packet.
+		 * This is the last write to the BD group; the cache flush
+		 * below will push all BDs to memory afterwards.
+		 */
+		txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
+		start++;
+	}
+
+	/*
+	 * Flush TX BDs to PoC so HW (non-cache-coherent i.MX95) can read
+	 * the descriptors from memory.  TX BDs are 16 B each; 4 BDs share
+	 * one 64-byte cache line.  Walk from the cache-line-aligned start
+	 * of first_bd_idx to just past the last written BD, one dcbf per
+	 * cache line.
+	 *
+	 * The flush must happen AFTER all BD fields (including flags_F) are
+	 * written, so HW never sees a partial descriptor.
+	 */
+	if (likely(start > 0)) {
+		int n = first_bd_idx & ~ENETC_BD_PER_CL_MASK;
+		int written = (i - n + bd_count) % bd_count;
+
+		if (written == 0)
+			written = bd_count;
+		written = (written + ENETC_BD_PER_CL_MASK) & ~ENETC_BD_PER_CL_MASK;
+
+		while (written > 0) {
+			dcbf((void *)ENETC_TXBD(*tx_ring, n));
+			n = (n + ENETC_BD_PER_CL) % bd_count;
+			written -= ENETC_BD_PER_CL;
+		}
+	}
+
+	enetc_clean_tx_ring(tx_ring);
+	tx_ring->next_to_use = i;
+	enetc_wr_reg(tx_ring->tcir, i);
+
+	return start;
+}
+
+/* --- Cacheable BD ring RX path with SW cache maintenance (dccivac) --- */
+
+static int
+enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
+		struct rte_mbuf **rx_pkts,
+		int work_limit)
+{
+	int rx_frm_cnt = 0;
+	int cleaned_cnt, i;
+	struct enetc_swbd *rx_swbd;
+	union enetc_rx_bd *rxbd, rxbd_temp;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL;
+	uint32_t bd_status;
+	uint8_t *data;
+	uint32_t j;
+	struct rte_mbuf *seg;
+	uint16_t data_len;
+
+	i = rx_ring->next_to_clean;
+	rxbd = ENETC_RXBD(*rx_ring, i);
+	cleaned_cnt = enetc_bd_unused(rx_ring);
+	rx_swbd = &rx_ring->q_swbd[i];
+
+	/*
+	 * On i.MX95 the BD ring is in cacheable hugepage memory but the
+	 * platform is non-cache-coherent.  HW writes RX BDs to DDR
+	 * without snooping the CPU cache, so stale cached copies of BD
+	 * status fields must be discarded before the CPU reads them.
+	 *
+	 * Ideal instruction: DC IVAC (invalidate only, no writeback).
+	 * ARM64 constraint: DC IVAC requires EL1 privilege; executing it
+	 * from EL0 (DPDK userspace) raises a fault.  The only EL0-safe
+	 * cache maintenance instruction that invalidates is DC CIVAC
+	 * (clean + invalidate, dccivac).
+	 *
+	 * Safety of using dccivac here:
+	 * enetc_refill_rx_ring() issues dcbf() on every BD group before
+	 * returning ownership to HW.  After dcbf the CPU cache lines are
+	 * marked clean (no dirty data).  When dccivac runs, the "clean"
+	 * phase finds nothing dirty to write back, so it behaves as a
+	 * pure invalidate - exactly what we need.
+	 *
+	 * Granularity: BD = 16 B, cache line = 64 B, so one dccivac
+	 * covers exactly 4 BDs.  Invalidate at each 4-BD boundary.
+	 */
+	dccivac((void *)ENETC_RXBD(*rx_ring,
+			(i & ~(int)ENETC_BD_PER_CL_MASK)));
+
+	while (likely(rx_frm_cnt < work_limit)) {
+#ifdef RTE_ARCH_32
+		rte_memcpy(&rxbd_temp, rxbd, 16);
+#else
+		__uint128_t *dst128 = (__uint128_t *)&rxbd_temp;
+		const __uint128_t *src128 = (const __uint128_t *)rxbd;
+		*dst128 = *src128;
+#endif
+		bd_status = rte_le_to_cpu_32(rxbd_temp.r.lstatus);
+
+		if (!(bd_status & ENETC_RXBD_LSTATUS_R))
+			break;
+		if (rxbd_temp.r.error)
+			rx_ring->ierrors++;
+
+		seg = rx_swbd->buffer_addr;
+		data_len = rte_le_to_cpu_16(rxbd_temp.r.buf_len);
+		seg->data_len = data_len;
+		if (!first_seg) {
+			first_seg = seg;
+			cur_seg = seg;
+			first_seg->pkt_len = data_len;
+			enetc_dev_rx_parse(first_seg,
+					   rxbd_temp.r.parse_summary);
+			first_seg->hash.rss = rxbd_temp.r.rss_hash;
+		} else {
+			first_seg->pkt_len += data_len;
+			first_seg->nb_segs++;
+			cur_seg->next = seg;
+			cur_seg = seg;
+		}
+
+		/*
+		 * Invalidate packet data cache lines so the CPU reads the
+		 * payload that HW DMA'd into memory, not stale cached bytes.
+		 */
+		data = rte_pktmbuf_mtod(seg, void *);
+		for (j = 0; j < data_len; j += RTE_CACHE_LINE_SIZE)
+			dccivac(data + j);
+		/* Cover the last byte of an unaligned buffer. */
+		dccivac(data + (data_len - 1));
+
+		if (bd_status & ENETC_RXBD_LSTATUS_F) {
+			seg->next = NULL;
+			first_seg->pkt_len -= rx_ring->crc_len;
+			rx_pkts[rx_frm_cnt] = first_seg;
+			rx_frm_cnt++;
+			first_seg = NULL;
+		}
+
+		cleaned_cnt++;
+		rx_swbd++;
+		i++;
+		if (unlikely(i == rx_ring->bd_count)) {
+			i = 0;
+			rx_swbd = &rx_ring->q_swbd[i];
+		}
+		rxbd = ENETC_RXBD(*rx_ring, i);
+
+		/*
+		 * Crossed a 4-BD (cache-line) boundary: invalidate the new
+		 * group so the next four status reads fetch fresh DDR data
+		 * written by HW.
+		 */
+		if ((i & ENETC_BD_PER_CL_MASK) == 0 &&
+		    likely(rx_frm_cnt < work_limit))
+			dccivac((void *)rxbd);
+	}
+
+	rx_ring->next_to_clean = i;
+	enetc_refill_rx_ring(rx_ring, ENETC_BD_ALIGN_DOWN(cleaned_cnt));
+
+	return rx_frm_cnt;
+}
+
+uint16_t
+enetc_recv_pkts_cacheable(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts)
+{
+	struct enetc_bdr *rx_ring = (struct enetc_bdr *)rxq;
+
+	return enetc_clean_rx_ring_cacheable(rx_ring, rx_pkts, nb_pkts);
+}
-- 
2.25.1

