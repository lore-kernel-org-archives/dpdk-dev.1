Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C1C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 07:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD66040695;
	Fri,  7 Aug 2026 09:02:47 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A1FDD402AC
 for <dev@dpdk.org>; Fri,  7 Aug 2026 09:02:43 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8771020017E;
 Fri,  7 Aug 2026 09:02:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E608200161;
 Fri,  7 Aug 2026 09:02:43 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AD5511800088;
 Fri,  7 Aug 2026 15:02:42 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 03/14] net/enetc: add RSC (hardware LRO) support for ENETC4
Date: Fri,  7 Aug 2026 12:32:30 +0530
Message-Id: <20260807070241.1151161-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807070241.1151161-1-g.singh@nxp.com>
References: <20260807034829.1030307-1-g.singh@nxp.com>
 <20260807070241.1151161-1-g.singh@nxp.com>
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

Add Receive Segment Coalesce (RSC) support, exposed as the DPDK
RTE_ETH_RX_OFFLOAD_TCP_LRO Rx offload, for the ENETC4 PF and VF on
i.MX95. RSC lets the HW coalesce multiple in-order TCP segments of a
flow into a single receive frame, reducing per-packet overhead.

RSC is a port-level offload driven by a dedicated Rx burst
(enetc_recv_pkts_rsc). When TCP LRO is requested the ring is switched
to 32B extended receive descriptors (RBaMR[BDS] = 1), the FCS is
stripped (RBaMR[CRC] = 0, so RSC is incompatible with KEEP_CRC),
interrupt coalescing is enabled (RBaICR0[ICEN] with a non-zero
RBaICR1[ICTT] hold timer that doubles as the RSC flush window), and
RBaRSCR[EN] is set with the coalesced-frame size clamped to the HW
maximum.

Because a 32B descriptor spans two 16B ring slots, the ring length
register (RBaLENR) and the consumer-index register are programmed in
HW-descriptor units (slot count / 2), while the internal SW indices
continue to track 16B slots. Coalesced clusters are delivered with the
RTE_MBUF_F_RX_LRO flag set when RSC_FRAMES > 1.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/enetc4.rst             |   4 +
 doc/guides/nics/features/enetc4.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   1 +
 drivers/net/enetc/base/enetc4_hw.h     |  74 ++++++++
 drivers/net/enetc/enetc.h              |   5 +
 drivers/net/enetc/enetc4_ethdev.c      | 102 ++++++++++-
 drivers/net/enetc/enetc4_vf.c          |   1 +
 drivers/net/enetc/enetc_rxtx.c         | 239 ++++++++++++++++++++++++-
 8 files changed, 418 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 4d27e4048e..e7f4348603 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -55,6 +55,10 @@ Key functionality includes:
 - Transmission: Packet transmission precedes reception, ensuring efficient data transfer.
 - TCP and UDP segmentation offload (TSO) on VFs, enabled per Tx queue
   when the TSO offload flag is requested.
+- Large receive offload (LRO) on the receive path via hardware Receive
+  Segment Coalesce (RSC), enabled when the TCP LRO Rx offload flag is
+  requested. RSC requires the FCS to be stripped, so it cannot be combined
+  with the KEEP_CRC Rx offload.
 
 
 Prerequisites
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 8ec1e8d00f..aae398e210 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -7,6 +7,7 @@
 Link status event    = Y
 Speed capabilities   = Y
 Link status          = Y
+LRO                  = Y
 TSO                  = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6a348ab4e0..0dd08e0259 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -62,6 +62,7 @@ New Features
 
   * Added KEEP_CRC Rx offload support for the ENETC4 PMD to preserve the Ethernet FCS.
   * Added TCP Segmentation Offload (TSO) support for the ENETC4 VF.
+  * Added Receive Segment Coalesce (RSC / hardware LRO) support for ENETC4 PF and VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 64c1a5e750..8ad8f169d2 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -103,7 +103,81 @@ struct enetc_tx_bd_ext {
 
 /* RBaMR[CRC]: 0 = FCS removed, 1 = FCS preserved (KEEP_CRC) */
 #define ENETC4_RBMR_CRC			BIT(8)
+/*
+ * RBaMR[BDS]: buffer descriptor size select for a receive ring.
+ * 0 = standard 16B descriptors, 1 = extended 32B descriptors.
+ * RSC requires 32B descriptors (BDS = 1). Matches the Linux enetc
+ * driver definition (ENETC_RBMR_BDS = BIT(2)).
+ */
+#define ENETC4_RBMR_BDS			BIT(2)
+
+/*
+ * Rx BDR a RSC register (RBaRSCR), offset 0x30 from the ring base.
+ * Controls Receive Segment Coalesce (RSC / LRO) for the ring.
+ */
+#define ENETC4_RBRSCR			0x30
+/* Enable RSC on this ring */
+#define ENETC4_RBRSCR_EN		BIT(31)
+/* Permit coalescing of TCP segments that carry the timestamp option */
+#define ENETC4_RBRSCR_CT		BIT(29)
+/* SIZE field (bits 15-0): maximum coalesced frame size produced by RSC */
+#define ENETC4_RBRSCR_SIZE(x)		((uint32_t)((x) & 0xffff))
+
+/*
+ * RBaICR0[ICEN]: interrupt coalescing enable. RSC requires interrupt
+ * coalescing to be enabled; the coalescing timer doubles as the RSC flush
+ * timer. ICPT (bits 8-0) is the packet-count threshold.
+ */
+#define ENETC4_RBICR0			0xa8
+#define ENETC4_RBICR0_ICEN		BIT(31)
+#define ENETC4_RBICR0_ICPT(x)		((uint32_t)((x) & 0x1ff))
+/* Rx BDR a interrupt coalescing register 1 (threshold timer) */
+#define ENETC4_RBICR1			0xac
+
+/*
+ * SI-level Rx interrupt detect register 0 (SIRXIDR0). W1C, one bit per Rx
+ * ring (RX0..RX23). The interrupt-coalescing timer (which also gates RSC
+ * coalescing) does not re-arm while a ring's detect bit stays set, so the
+ * poll-mode driver writes BIT(ring index) here every poll to keep RSC
+ * coalescing. The per-ring RBaIDR (0xa4) is read-only and cannot be used.
+ */
+#define ENETC_SIRXIDR			0xa28
+
+/*
+ * RSC (Receive Segment Coalesce) limits and defaults.
+ * Maximum coalesced frame size the HW will build (programmed in RBaRSCR[SIZE]).
+ * Bounded to 16 bits by the SIZE field width.
+ */
+#define ENETC4_RSC_MAX_FRAME		0xffff
+/* Default interrupt coalescing packet threshold used to satisfy RSC's ICEN
+ * precondition. The PMD is poll-mode, so this only gates the RSC flush timer.
+ */
+#define ENETC4_RSC_DEF_ICPT		1
+/*
+ * Default interrupt coalescing timer threshold (RBaICR1[ICTT]), in NETC
+ * platform clock cycles. This timer is the RSC coalesce-hold window: HW keeps
+ * a coalesced frame open while it runs and appends in-order segments. A value
+ * of 0 disables the timer and flushes every segment separately (no
+ * coalescing), so it must be non-zero for RSC to merge anything.
+ */
+#define ENETC4_RSC_DEF_ICTT		0x10000
+
+/*
+ * Extended 32B receive writeback buffer descriptor. Used only on RSC-enabled
+ * rings (RBaMR[BDS] = 1). The first 16 bytes match the standard descriptor
+ * writeback layout; the second 16 bytes carry the RSC and timestamp fields.
+ * RSC_FRAMES reports how many frames were coalesced (1 to 255; 1 means the
+ * frame was not coalesced).
+ */
+struct enetc_rx_bd_ext {
+	uint32_t timestamp;	/* offset 0x10: PTP timestamp */
+	uint32_t rsc_frames;	/* offset 0x14: RSC_FRAMES in bits 7-0 */
+	uint32_t rsc_abs_ts_delta; /* offset 0x18 */
+	uint32_t reserved;	/* offset 0x1c */
+};
 
+/* RSC_FRAMES occupies bits 7-0 of the rsc_frames word */
+#define ENETC4_RXBD_EXT_RSC_FRAMES(x)	((x) & 0xff)
 
 /* i.MX95 supports jumbo frame, but it is recommended to set the max frame
  * size to 2000 bytes.
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index db349e051b..67f8ce1919 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -101,6 +101,8 @@ struct enetc_bdr {
 	uint8_t rx_deferred_start;
 	uint8_t tx_deferred_start;
 	uint8_t lso_enable;
+	void *rbidr;
+	uint8_t rsc_enable;
 };
 
 struct enetc_eth_hw {
@@ -321,12 +323,15 @@ uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
+uint16_t enetc_recv_pkts_rsc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts);
 uint16_t enetc_xmit_pkts_cacheable(void *txq, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts_cacheable(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 
 int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
+int enetc_refill_rx_ring_rsc(struct enetc_bdr *rx_ring, const int buff_cnt);
 
 /*
  * Cache-maintenance constants for cacheable BD ring mode.
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 897e12e21f..7f95171b6d 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -16,7 +16,8 @@ static uint64_t dev_rx_offloads_sup =
 	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
 	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
 	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
-	RTE_ETH_RX_OFFLOAD_KEEP_CRC;
+	RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+	RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
 /* Supported Tx offloads */
 static uint64_t dev_tx_offloads_sup =
@@ -314,6 +315,8 @@ enetc4_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
 	dev_info->rx_offload_capa = dev_rx_offloads_sup;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup;
+	/* Max RSC (LRO) coalesced frame size; matches RBaRSCR[SIZE]. */
+	dev_info->max_lro_pkt_size = ENETC4_RSC_MAX_FRAME;
 	dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL;
 
 	return 0;
@@ -520,22 +523,29 @@ static int
 enetc4_alloc_rxbdr(struct enetc_bdr *rxr, uint16_t nb_desc)
 {
 	int size;
+	uint32_t ring_desc;
+
+	/*
+	 * RSC rings use 32B descriptors (RBaMR[BDS] = 1), i.e. two 16B slots
+	 * each, so allocate 2 * nb_desc slots. Non-RSC rings use 16B slots.
+	 */
+	ring_desc = rxr->rsc_enable ? (uint32_t)nb_desc * 2 : (uint32_t)nb_desc;
 
-	size = nb_desc * sizeof(struct enetc_swbd);
+	size = ring_desc * sizeof(struct enetc_swbd);
 	/* Zero q_swbd so buffer_addr is NULL for all uninitialized slots. */
 	rxr->q_swbd = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (rxr->q_swbd == NULL)
 		return -ENOMEM;
 
 	/* Allocate the RX BD ring: each BD is union enetc_rx_bd (16 bytes). */
-	size = nb_desc * sizeof(union enetc_rx_bd);
+	size = ring_desc * sizeof(union enetc_rx_bd);
 	rxr->bd_base = rte_zmalloc(NULL, size, ENETC_BD_RING_ALIGN);
 	if (rxr->bd_base == NULL) {
 		rte_free(rxr->q_swbd);
 		rxr->q_swbd = NULL;
 		return -ENOMEM;
 	}
-	rxr->bd_count = nb_desc;
+	rxr->bd_count = ring_desc;
 	rxr->next_to_clean = 0;
 	rxr->next_to_use = 0;
 	rxr->next_to_alloc = 0;
@@ -558,13 +568,30 @@ enetc4_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
 		       lower_32_bits((uint64_t)bd_address));
 	enetc4_rxbdr_wr(hw, idx, ENETC_RBBAR1,
 		       upper_32_bits((uint64_t)bd_address));
+	/*
+	 * RBaLENR counts HW descriptors. With RSC (BDS = 1) a descriptor is
+	 * 32B (two 16B slots), so program bd_count / 2; otherwise bd_count.
+	 */
 	enetc4_rxbdr_wr(hw, idx, ENETC_RBLENR,
-		       ENETC_RTBLENR_LEN(rx_ring->bd_count));
+		       ENETC_RTBLENR_LEN(rx_ring->rsc_enable ?
+				rx_ring->bd_count / 2 : rx_ring->bd_count));
 
 	rx_ring->mb_pool = mb_pool;
 	rx_ring->rcir = (void *)((size_t)hw->reg +
 			ENETC_BDR(RX, idx, ENETC_RBCIR));
-	enetc_refill_rx_ring(rx_ring, ENETC_BD_ALIGN_DOWN(enetc_bd_unused(rx_ring)));
+	/* RSC rings clear their Rx interrupt-detect event via SIRXIDR (see
+	 * enetc_clean_rx_ring_rsc); cache the register address here.
+	 */
+	if (rx_ring->rsc_enable)
+		rx_ring->rbidr = (void *)((size_t)hw->reg + ENETC_SIRXIDR);
+
+	/* RSC rings use the 2-slot-stride refill for 32B descriptors. */
+	if (rx_ring->rsc_enable)
+		enetc_refill_rx_ring_rsc(rx_ring,
+			ENETC_BD_ALIGN_DOWN(enetc_bd_unused(rx_ring)));
+	else
+		enetc_refill_rx_ring(rx_ring,
+			ENETC_BD_ALIGN_DOWN(enetc_bd_unused(rx_ring)));
 	buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rx_ring->mb_pool) -
 		   RTE_PKTMBUF_HEADROOM);
 	enetc4_rxbdr_wr(hw, idx, ENETC_RBBSR, buf_size);
@@ -587,7 +614,9 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 			ENETC_DEV_PRIVATE(data->dev_private);
 	uint64_t rx_offloads = data->dev_conf.rxmode.offloads;
 	uint32_t rx_enable;
+	uint32_t rsc_size;
 	bool keep_crc;
+	bool rsc_enable;
 
 	PMD_INIT_FUNC_TRACE();
 	if (nb_rx_desc > MAX_BD_COUNT)
@@ -604,6 +633,23 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	keep_crc = !!(rx_offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC);
 	rx_ring->crc_len = (uint8_t)(keep_crc ? RTE_ETHER_CRC_LEN : 0);
 
+	/*
+	 * RSC (LRO) is a port-level offload: the Rx burst is a single device
+	 * function pointer, so decide from port offloads (not per-queue
+	 * rx_conf) to keep all rings consistent. RSC needs HW FCS stripping
+	 * (RBaMR[CRC] = 0), so it is incompatible with KEEP_CRC.
+	 */
+	rsc_enable = !!(rx_offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO);
+	if (rsc_enable) {
+		if (keep_crc) {
+			ENETC_PMD_ERR("RSC (LRO) is incompatible with KEEP_CRC");
+			rte_free(rx_ring);
+			return -EINVAL;
+		}
+		rx_ring->rsc_enable = 1;
+		dev->rx_pkt_burst = &enetc_recv_pkts_rsc;
+	}
+
 	err = enetc4_alloc_rxbdr(rx_ring, nb_rx_desc);
 	if (err)
 		goto fail;
@@ -622,6 +668,49 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	else
 		rx_enable &= ~ENETC4_RBMR_CRC;
 
+	if (rsc_enable) {
+		/*
+		 * RSC preconditions (all must hold or RBaRSCR[EN] is ignored):
+		 * BDS = 1 (32B descriptors), CRC = 0 (FCS stripped, enforced
+		 * above), ICEN = 1 (its timer doubles as the RSC flush timer),
+		 * and RBaRSCR[EN] with CT for timestamped segments. SIZE caps
+		 * the coalesced frame; honor rxmode.max_lro_pkt_size clamped to
+		 * the HW max, falling back to the HW max when unset.
+		 */
+		rx_enable |= ENETC4_RBMR_BDS;
+
+		/*
+		 * Commit RBMR[BDS] to HW now (ring still disabled, EN clear)
+		 * so the 32B descriptor mode is active before RBaRSCR[EN] is
+		 * set. BDS = 1 is a hard RSC precondition: if RBaRSCR[EN] is
+		 * written while BDS is still 0 in HW, RSC may be silently
+		 * ignored. The ring-enable step below writes RBMR again with
+		 * EN added.
+		 */
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR,
+			       rx_enable);
+
+		rsc_size = data->dev_conf.rxmode.max_lro_pkt_size;
+		if (rsc_size == 0 || rsc_size > ENETC4_RSC_MAX_FRAME)
+			rsc_size = ENETC4_RSC_MAX_FRAME;
+
+		/*
+		 * Program ICTT FIRST (with ICEN = 0) then enable ICEN, as the
+		 * RM requires. ICTT is the RSC coalesce-hold window; a zero
+		 * value disables the timer and forces HW to flush every frame
+		 * (no coalescing), so use a non-zero default.
+		 */
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index,
+			       ENETC4_RBICR1, ENETC4_RSC_DEF_ICTT);
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index,
+			       ENETC4_RBICR0, ENETC4_RBICR0_ICEN |
+			       ENETC4_RBICR0_ICPT(ENETC4_RSC_DEF_ICPT));
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index,
+			       ENETC4_RBRSCR, ENETC4_RBRSCR_EN |
+			       ENETC4_RBRSCR_CT |
+			       ENETC4_RBRSCR_SIZE(rsc_size));
+	}
+
 	if (!rx_conf->rx_deferred_start) {
 		/* enable ring */
 		rx_enable |= ENETC_RBMR_EN;
@@ -643,7 +732,6 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	return err;
 }
 
-
 void
 enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 3083a56335..be79a18a39 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -53,6 +53,7 @@ static uint64_t dev_rx_offloads_sup =
 	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
 	RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 	RTE_ETH_RX_OFFLOAD_KEEP_CRC |
+	RTE_ETH_RX_OFFLOAD_TCP_LRO |
 	RTE_ETH_RX_OFFLOAD_SCATTER;
 
 /* Supported Tx offloads */
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index f19f32eace..3f2e85b871 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -816,7 +816,7 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd, rxbd_temp;
-	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL, *prev_seg = NULL;
 	uint32_t bd_status;
 	uint8_t *data;
 	uint32_t j;
@@ -905,6 +905,241 @@ enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
 	return enetc_clean_rx_ring_nc(rx_ring, rx_pkts, nb_pkts);
 }
 
+/*
+ * RSC (LRO) refill. buff_cnt is in 16B slots; each 32B descriptor is two
+ * slots. The even slot takes a fresh mbuf, the odd extension slot never owns
+ * a buffer, so walk the ring two slots at a time. Cache maintenance mirrors
+ * enetc_refill_rx_ring (dcbf per 64B line, i.e. two descriptors).
+ */
+int
+enetc_refill_rx_ring_rsc(struct enetc_bdr *rx_ring, const int buff_cnt)
+{
+	struct enetc_swbd *rx_swbd;
+	union enetc_rx_bd *rxbd, *grp_start_rxbd;
+	int i, j, k = ENETC_RXBD_BUNDLE;
+	struct rte_mbuf *m[ENETC_RXBD_BUNDLE];
+	struct rte_mempool *mb_pool;
+
+	i = rx_ring->next_to_use;
+	mb_pool = rx_ring->mb_pool;
+	rx_swbd = &rx_ring->q_swbd[i];
+	rxbd = ENETC_RXBD(*rx_ring, i);
+	grp_start_rxbd = rxbd;
+
+	for (j = 0; j < buff_cnt; j += 2) {
+		/* Bulk alloc one mbuf per descriptor (every two slots). */
+		if (k == ENETC_RXBD_BUNDLE) {
+			int want = (buff_cnt - j) / 2;
+			int m_cnt = RTE_MIN(want, ENETC_RXBD_BUNDLE);
+
+			k = 0;
+			if (rte_pktmbuf_alloc_bulk(mb_pool, m, m_cnt))
+				return -1;
+		}
+
+		rx_swbd->buffer_addr = m[k];
+		rxbd->w.addr = (uint64_t)(uintptr_t)
+			       rx_swbd->buffer_addr->buf_iova +
+			       rx_swbd->buffer_addr->data_off;
+		/* clear 'R' as well */
+		rxbd->r.lstatus = 0;
+		k++;
+
+		/* Extension (odd) slot never owns a buffer. */
+		rx_swbd[1].buffer_addr = NULL;
+
+		rx_swbd += 2;
+		rxbd += 2;
+		i += 2;
+
+		if (unlikely(i == rx_ring->bd_count)) {
+			/* Ring wrap: flush partial/full group before reset. */
+			dcbf((void *)grp_start_rxbd);
+			i = 0;
+			rxbd = ENETC_RXBD(*rx_ring, i);
+			rx_swbd = &rx_ring->q_swbd[i];
+			grp_start_rxbd = rxbd;
+		} else if ((i & ENETC_BD_PER_CL_MASK) == 0) {
+			/* Completed a full 4-slot (2-descriptor) cache line. */
+			dcbf((void *)grp_start_rxbd);
+			grp_start_rxbd = rxbd;
+		}
+	}
+
+	/* Flush any remaining partial group at the end of the fill. */
+	if (j && (i & ENETC_BD_PER_CL_MASK) != 0)
+		dcbf((void *)grp_start_rxbd);
+
+	if (likely(j)) {
+		rx_ring->next_to_alloc = i;
+		rx_ring->next_to_use = i;
+		/*
+		 * Internal indices track 16B slots, but the HW consumer-index
+		 * register counts 32B descriptors, so program i / 2.
+		 */
+		enetc_wr_reg(rx_ring->rcir, i / 2);
+	}
+
+	return j;
+}
+
+/*
+ * RSC (LRO) clean. Same non-cache-coherent discipline as
+ * enetc_clean_rx_ring_cacheable but walks 32B descriptors (two 16B slots
+ * each); the extension half at slot i+1 carries the RSC coalesce count.
+ * RSC_FRAMES > 1 flags the cluster RTE_MBUF_F_RX_LRO. RSC always strips the
+ * FCS (RBaMR[CRC] = 0), so no CRC trim is needed.
+ */
+static int
+enetc_clean_rx_ring_rsc(struct enetc_bdr *rx_ring,
+		    struct rte_mbuf **rx_pkts,
+		    int work_limit)
+{
+	int rx_frm_cnt = 0;
+	int cleaned_cnt, i;
+	struct enetc_swbd *rx_swbd;
+	union enetc_rx_bd *rxbd, rxbd_temp;
+	struct enetc_rx_bd_ext *rxbd_ext;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL;
+	uint32_t bd_status;
+	uint8_t *data;
+	uint32_t j;
+	struct rte_mbuf *seg;
+	uint16_t data_len;
+	uint8_t rsc_frames;
+
+	/* next descriptor to process */
+	i = rx_ring->next_to_clean;
+	rxbd = ENETC_RXBD(*rx_ring, i);
+	cleaned_cnt = enetc_bd_unused(rx_ring);
+	rx_swbd = &rx_ring->q_swbd[i];
+
+	/*
+	 * Always invalidate the cache line that contains next_to_clean before
+	 * the first status read. On RSC rings a 64B line holds two 32B
+	 * descriptors. See enetc_clean_rx_ring_cacheable for the full rationale
+	 * on why dccivac (clean+invalidate) is used from EL0 instead of DC IVAC.
+	 */
+	dccivac((void *)ENETC_RXBD(*rx_ring,
+			  (i & ~(int)ENETC_BD_PER_CL_MASK)));
+
+	while (likely(rx_frm_cnt < work_limit)) {
+		/* Atomically snapshot the 16B writeback half of the BD. */
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
+		/*
+		 * Extension half (odd slot) carries the RSC coalesce count.
+		 * Invariant: an RSC ring is allocated with bd_count = nb_desc * 2
+		 * (always even), next_to_clean starts at 0, and i only ever
+		 * advances by 2 with a wrap at i == bd_count. So i is always the
+		 * even (writeback) slot of a 32B descriptor and never exceeds
+		 * bd_count - 2; i + 1 is therefore always the matching odd
+		 * extension slot and stays in bounds (never wraps past the ring).
+		 */
+		rxbd_ext = (struct enetc_rx_bd_ext *)
+			   ENETC_RXBD(*rx_ring, i + 1);
+		rsc_frames = ENETC4_RXBD_EXT_RSC_FRAMES(rte_le_to_cpu_32(rxbd_ext->rsc_frames));
+
+		seg = rx_swbd->buffer_addr;
+		data_len = rte_le_to_cpu_16(rxbd_temp.r.buf_len);
+		seg->data_len = data_len;
+		if (!first_seg) {
+			first_seg = seg;
+			cur_seg = seg;
+			first_seg->pkt_len = data_len;
+			first_seg->ol_flags = 0;
+			enetc_dev_rx_parse(first_seg,
+						rxbd_temp.r.parse_summary);
+			first_seg->hash.rss = rxbd_temp.r.rss_hash;
+			/* RSC_FRAMES > 1 means HW coalesced segments (LRO). */
+			if (rsc_frames > 1)
+				first_seg->ol_flags |= RTE_MBUF_F_RX_LRO;
+		} else {
+			first_seg->pkt_len += data_len;
+			first_seg->nb_segs++;
+			cur_seg->next = seg;
+			cur_seg = seg;
+		}
+
+		/* Invalidate packet data so the CPU reads HW-DMA'd payload. */
+		data = rte_pktmbuf_mtod(seg, void *);
+		for (j = 0; j < data_len; j += RTE_CACHE_LINE_SIZE)
+			dccivac(data + j);
+		/*
+		 * Cover the last byte of an unaligned buffer. Guard against a
+		 * zero-length BD so data_len - 1 does not step before the
+		 * payload start.
+		 */
+		if (likely(data_len))
+			dccivac(data + (data_len - 1));
+
+		if (bd_status & ENETC_RXBD_LSTATUS_F) {
+			seg->next = NULL;
+			ENETC_PMD_DP_DEBUG("RSC_FRAMES=%u pkt_len=%u nb_segs=%u",
+					   rsc_frames, first_seg->pkt_len,
+					   first_seg->nb_segs);
+			rx_pkts[rx_frm_cnt] = first_seg;
+			rx_frm_cnt++;
+			first_seg = NULL;
+		}
+
+		/* Two 16B slots per 32B RSC descriptor. */
+		cleaned_cnt += 2;
+		rx_swbd += 2;
+		i += 2;
+		if (unlikely(i == rx_ring->bd_count)) {
+			i = 0;
+			rx_swbd = &rx_ring->q_swbd[i];
+		}
+		rxbd = ENETC_RXBD(*rx_ring, i);
+
+		/*
+		 * Crossed a 4-slot (cache-line, two-descriptor) boundary:
+		 * invalidate the new group so subsequent status reads fetch
+		 * fresh DDR data written by HW.
+		 */
+		if ((i & ENETC_BD_PER_CL_MASK) == 0 &&
+		    likely(rx_frm_cnt < work_limit))
+			dccivac((void *)rxbd);
+	}
+
+	rx_ring->next_to_clean = i;
+	enetc_refill_rx_ring_rsc(rx_ring, ENETC_BD_ALIGN_DOWN(cleaned_cnt));
+
+	/*
+	 * Write-1-to-clear this ring's event in SIRXIDR. Without this the
+	 * interrupt-coalescing timer never re-arms and HW stops coalescing
+	 * after the first RSC frame (this PMD is poll-mode and never services
+	 * the interrupt). SIRXIDR is W1C, one bit per ring; RBaIDR is
+	 * read-only. Matches the Linux driver's enetc_wr_reg_hot(idr, BIT()).
+	 */
+	enetc4_wr_reg(rx_ring->rbidr, BIT(rx_ring->index));
+
+	return rx_frm_cnt;
+}
+
+uint16_t
+enetc_recv_pkts_rsc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts)
+{
+	struct enetc_bdr *rx_ring = (struct enetc_bdr *)rxq;
+
+	return enetc_clean_rx_ring_rsc(rx_ring, rx_pkts, nb_pkts);
+}
+
+
 uint16_t
 enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
@@ -1041,7 +1276,7 @@ enetc_clean_rx_ring_cacheable(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd;
-	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL, *prev_seg = NULL;
 	uint32_t bd_status;
 	uint8_t *data;
 	uint32_t j;
-- 
2.25.1

