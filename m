Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1554CA5FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63434027A;
	Fri,  9 Oct 2026 08:22:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1710F4026D
 for <dev@dpdk.org>; Fri,  9 Oct 2026 08:22:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791526941; x=1823062941;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6EksIa4slxkKG38JLOGLRydNgm6QX92hzQ/AVdNKVNE=;
 b=dpL2ZgmHb5k0P4TtRDql9RyWlguB9l9yyLHrlh9qwnZYGmBrxAgd/ZsF
 XQByc8bIvmIsPLALy1wfsXDn7MabaBzarLIKgRfv0aJgu+TTj5b7a1Q5X
 EDIDMOHRxIAKoYGHsXJR6fSWN+kr8YM8csfATn0aqIKr5l2LrBs1wNwB9
 Fy/1GMD7gRInT+saO4D5Ie6FCC4dYyQoVuDBSHbSaqfTPEndYQLmWIdj7
 H2u4uAMqE4LxsQ1onGuHUPtJUniahqBUPXLoNPyP1dSzxvmxdY7dVnXoG
 nuA1CpFKMPEiRWK8RXWgQSxXS+FBmL4a9HF7I7AoYT1wFS2974c28udam w==;
X-CSE-ConnectionGUID: tBFZ9VG3T56qcF+0Se4KSg==
X-CSE-MsgGUID: Nf9rkLtnRb2FP5ruIoJQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="429527"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="429527"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 23:22:19 -0700
X-CSE-ConnectionGUID: AYJN9TOcRt2V82VbXOSysg==
X-CSE-MsgGUID: J1Z6nLvcQtqUkRR1ZSazWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="184345"
Received: from client-08.iind.intel.com ([10.190.203.152])
 by orviesa009.jf.intel.com with ESMTP; 08 Oct 2026 23:22:18 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/i40e: enable vector Rx with IEEE1588 timestamping
Date: Fri,  9 Oct 2026 05:34:49 +0000
Message-ID: <20261009053449.843546-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.43.0
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

Enabling IEEE1588 support at build time forced all ports to fall back
to the scalar Rx path, as the vector paths did not propagate either
the PTP flags or the hardware timestamp register index.
As a result, applications incurred the performance cost of scalar Rx
on all traffic, even when packet timestamping was never enabled
at runtime.

The hardware does not embed timestamps in Rx descriptors.
Instead, it latches each timestamp into one of four dedicated
registers and reports only a validity bit along with a 2-bit
register index.
Propagating these to the mbuf requires a per-packet store
that SIMD cannot accelerate.

To remove this limitation, the vector Rx paths now perform a
lightweight scalar pass over the descriptors consumed in each
burst, populating the same PTP flags and timestamp register
index as the scalar implementation.
The timestamp decoding logic is shared between the scalar and
vector paths to ensure consistent behavior.

Applications requiring PTP hardware timestamping therefore no
longer need to choose between hardware timestamp support and
vector Rx throughput.

Scattered Rx reassembly already propagated the offload flags from the
last segment to the head mbuf, but it did not propagate the timestamp
register index.
Consequently, a segmented PTP packet could carry a valid timestamp flag
while retaining a stale register index.
The reassembly path now propagates the timestamp index as well, ensuring
consistent metadata for multi-segment packets.

Tx path selection remains unchanged, and builds without IEEE1588 support
are unaffected.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/common/rx.h                 |  3 +++
 drivers/net/intel/i40e/i40e_rxtx.c            | 24 -------------------
 drivers/net/intel/i40e/i40e_rxtx.h            | 24 +++++++++++++++++++
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    | 10 ++++++++
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  8 +++++++
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  8 +++++++
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 24 +++++++++++++++----
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   | 10 ++++++++
 8 files changed, 82 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index e0bf520ebd..8f4454d477 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -167,6 +167,9 @@ ci_rx_reassemble_packets(struct rte_mbuf **rx_bufs, uint16_t nb_bufs, uint8_t *s
 				start->hash = end->hash;
 				start->vlan_tci = end->vlan_tci;
 				start->ol_flags = end->ol_flags;
+#ifdef RTE_LIBRTE_IEEE1588
+				start->timesync = end->timesync;
+#endif
 				/* we need to strip crc for the whole packet */
 				start->pkt_len -= crc_len;
 				if (end->data_len > crc_len) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 8bfd1e07d2..77ebcd915e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -194,30 +194,6 @@ i40e_rxd_error_to_pkt_flags(uint64_t qword)
 	return flags;
 }
 
-/* Function to check and set the ieee1588 timesync index and get the
- * appropriate flags.
- */
-#ifdef RTE_LIBRTE_IEEE1588
-static inline uint64_t
-i40e_get_iee15888_flags(struct rte_mbuf *mb, uint64_t qword)
-{
-	uint64_t pkt_flags = 0;
-	uint16_t tsyn = (qword & (I40E_RXD_QW1_STATUS_TSYNVALID_MASK
-				  | I40E_RXD_QW1_STATUS_TSYNINDX_MASK))
-				    >> I40E_RX_DESC_STATUS_TSYNINDX_SHIFT;
-
-	if ((mb->packet_type & RTE_PTYPE_L2_MASK)
-			== RTE_PTYPE_L2_ETHER_TIMESYNC)
-		pkt_flags = RTE_MBUF_F_RX_IEEE1588_PTP;
-	if (tsyn & 0x04) {
-		pkt_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
-		mb->timesync = tsyn & 0x03;
-	}
-
-	return pkt_flags;
-}
-#endif
-
 static inline uint64_t
 i40e_rxd_build_fdir(volatile union ci_rx_desc *rxdp, struct rte_mbuf *mb)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 0977342064..1532736bd2 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -107,6 +107,30 @@ enum i40e_header_split_mode {
 
 #define I40E_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
 
+/* Function to check and set the ieee1588 timesync index and get the
+ * appropriate flags.
+ */
+#ifdef RTE_LIBRTE_IEEE1588
+static inline uint64_t
+i40e_get_iee15888_flags(struct rte_mbuf *mb, uint64_t qword)
+{
+	uint64_t pkt_flags = 0;
+	uint16_t tsyn = (qword & (I40E_RXD_QW1_STATUS_TSYNVALID_MASK
+				  | I40E_RXD_QW1_STATUS_TSYNINDX_MASK))
+				    >> I40E_RX_DESC_STATUS_TSYNINDX_SHIFT;
+
+	if ((mb->packet_type & RTE_PTYPE_L2_MASK)
+			== RTE_PTYPE_L2_ETHER_TIMESYNC)
+		pkt_flags = RTE_MBUF_F_RX_IEEE1588_PTP;
+	if (tsyn & 0x04) {
+		pkt_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+		mb->timesync = tsyn & 0x03;
+	}
+
+	return pkt_flags;
+}
+#endif
+
 int i40e_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int i40e_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id);
 int i40e_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 68667bdc9b..f909cad001 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -122,6 +122,9 @@ _recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union ci_rx_desc *rxdp;
+#ifdef RTE_LIBRTE_IEEE1588
+	volatile union ci_rx_desc *rxdp_burst;
+#endif
 	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
@@ -145,6 +148,9 @@ _recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 * going to cost about 7 cycles
 	 */
 	rxdp = rxq->rx_ring + rxq->rx_tail;
+#ifdef RTE_LIBRTE_IEEE1588
+	rxdp_burst = rxdp;
+#endif
 
 	rte_prefetch0(rxdp);
 
@@ -365,6 +371,10 @@ _recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	rxq->rx_tail = (uint16_t)(rxq->rx_tail & (rxq->nb_rx_desc - 1));
 	rxq->rxrearm_nb = (uint16_t)(rxq->rxrearm_nb + nb_pkts_recd);
 
+#ifdef RTE_LIBRTE_IEEE1588
+	i40e_rx_vec_desc_to_timesync(rxdp_burst, rx_pkts, nb_pkts_recd);
+#endif
+
 	return nb_pkts_recd;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index dd06e258ad..d39fe68b9f 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -115,6 +115,9 @@ _recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			0, rxq->mbuf_initializer);
 	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+#ifdef RTE_LIBRTE_IEEE1588
+	volatile union ci_rx_desc *rxdp_burst = rxdp;
+#endif
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 	rte_prefetch0(rxdp);
 
@@ -602,6 +605,11 @@ _recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		received--;
 	}
 	rxq->rxrearm_nb += received;
+
+#ifdef RTE_LIBRTE_IEEE1588
+	i40e_rx_vec_desc_to_timesync(rxdp_burst, rx_pkts, received);
+#endif
+
 	return received;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index ea2e6dc024..63d3f54670 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -116,6 +116,9 @@ _recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			0, rxq->mbuf_initializer);
 	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union ci_rx_desc *rxdp = rxq->rx_ring + rxq->rx_tail;
+#ifdef RTE_LIBRTE_IEEE1588
+	volatile union ci_rx_desc *rxdp_burst = rxdp;
+#endif
 
 	rte_prefetch0(rxdp);
 
@@ -669,6 +672,11 @@ _recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		received--;
 	}
 	rxq->rxrearm_nb += received;
+
+#ifdef RTE_LIBRTE_IEEE1588
+	i40e_rx_vec_desc_to_timesync(rxdp_burst, rx_pkts, received);
+#endif
+
 	return received;
 }
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index 292a39501e..832179fa7a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -50,10 +50,28 @@ _i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 	memset(rxq->sw_ring, 0, sizeof(rxq->sw_ring[0]) * rxq->nb_rx_desc);
 }
 
+#ifdef RTE_LIBRTE_IEEE1588
+/* The hardware latches Rx timestamps into one of four registers and only
+ * reports the register index in the descriptor, so there is nothing to
+ * extract in SIMD and this is done one descriptor at a time.
+ */
+static inline void
+i40e_rx_vec_desc_to_timesync(volatile union ci_rx_desc *rxdp,
+		struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	for (uint16_t i = 0; i < nb_pkts; i++) {
+		struct rte_mbuf *mb = rx_pkts[i];
+		const uint64_t qword1 =
+			rte_le_to_cpu_64(rxdp[i].wb.qword1.status_error_len);
+
+		mb->ol_flags |= i40e_get_iee15888_flags(mb, qword1);
+	}
+}
+#endif
+
 static inline int
 i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 {
-#ifndef RTE_LIBRTE_IEEE1588
 	/**
 	 * Vector mode is allowed only when number of Rx queue
 	 * descriptor is power of 2.
@@ -67,10 +85,6 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 	}
 
 	return 0;
-#else
-	RTE_SET_USED(dev);
-	return -1;
-#endif
 }
 
 #endif
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index debc9bda28..2189876833 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -284,6 +284,9 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
 	volatile union ci_rx_desc *rxdp;
+#ifdef RTE_LIBRTE_IEEE1588
+	volatile union ci_rx_desc *rxdp_burst;
+#endif
 	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
 	int pos;
@@ -322,6 +325,9 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 	 * going to cost about 7 cycles
 	 */
 	rxdp = rxq->rx_ring + rxq->rx_tail;
+#ifdef RTE_LIBRTE_IEEE1588
+	rxdp_burst = rxdp;
+#endif
 
 	rte_prefetch_non_temporal(rxdp);
 
@@ -513,6 +519,10 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 	rxq->rx_tail = (uint16_t)(rxq->rx_tail & (rxq->nb_rx_desc - 1));
 	rxq->rxrearm_nb = (uint16_t)(rxq->rxrearm_nb + nb_pkts_recd);
 
+#ifdef RTE_LIBRTE_IEEE1588
+	i40e_rx_vec_desc_to_timesync(rxdp_burst, rx_pkts, nb_pkts_recd);
+#endif
+
 	return nb_pkts_recd;
 }
 
-- 
2.43.0

