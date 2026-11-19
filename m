Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD9606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n807HEqN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCECD402F0;
	Thu, 19 Nov 2026 06:15:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 677D8402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 06:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795065295; x=1826601295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wCPzMqnD/9A8dp9rezewGMensXv6h4TjwdJaBoRLnF8=;
 b=n807HEqNv4sxK/fgVylFMm0bYdAnB8JAYPxPGCRlGSLtRKOb/8dl1MoX
 ehJdwnMgHWT/aTL+8ae7O3H4o6zTG/8INhNjtXaiVXo+Fqq4QwqFtrlTX
 SclP54IDk9+1vP6kCNA3IkoKFMV08FWG5/le1GxaQpx6hJFZLmAmrVNVj
 EBmTzZbLKqrCfPVA5KfmDvWGC1+odOhPZ1nwaPlhbdXu/tURnIMJZecuB
 AJj99XGQK+o2Aibsin3cCaV4UhN/wOpOyShTV67rGoKH6a8OfdLTeJkZI
 ovmpr3MOXRSlJFezRW9xWG06f6rUsmt9BU9iHHAvWzWs1DnARYNfdwNuB Q==;
X-CSE-ConnectionGUID: 8/ysC/DKRAmbIwv74yyqig==
X-CSE-MsgGUID: bb+OD0b5RkyS8qXH9E1cEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3929079"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3929079"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 21:14:53 -0800
X-CSE-ConnectionGUID: eIj6BHRYR66Wq3EsMvceAw==
X-CSE-MsgGUID: LuGJYZaNRsyvoBsnLJ7HBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10328878"
Received: from gnrd03.iind.intel.com ([10.190.213.135])
 by fmviesa004.fm.intel.com with ESMTP; 18 Nov 2026 21:14:51 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com
Cc: manoj.kumar.subbarao@intel.com
Subject: [PATCH v1 1/2] net/ice: fix Rx timestamp and PTP on vector path
Date: Thu, 19 Nov 2026 10:43:59 +0530
Message-ID: <20261119051418.2852033-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119051418.2852033-1-soumyadeep.hore@intel.com>
References: <20261119051418.2852033-1-soumyadeep.hore@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling Rx timestamp offload on the AVX2/AVX512 vector paths
introduced several issues:

- PTP packets were no longer flagged. Applications that start the
  port with Rx timestamp offload and enable timesync afterwards
  (e.g. ptpclient) get a vector Rx path, which never set
  RTE_MBUF_F_RX_IEEE1588_PTP, mbuf timesync or the queue time_high.
  ptpclient therefore dropped all PTP frames and printed no T1-T4.
- The dynamic timestamp flag was merged through a 32-bit SIMD lane,
  so it was lost when the registered flag bit is 32 or higher.
- For scattered packets the first segment kept the timestamp of the
  first descriptor, as reassembly does not copy the dynfield, and
  non-EOP descriptors were fed into the rollover tracking.
- The 32b to 64b conversion ran before the burst was trimmed for
  alignment, updating the state with a packet not yet returned.

Move the post-loop processing into a common helper which runs after
the trim, sets the timestamp flag on ol_flags, converts only EOP
descriptors and stores the result on the first segment, and flags
PTP packets like the scalar path. time_high is updated only for PTP
packets so the timesync read returns the PTP packet timestamp.

Fixes: 332eb4ec8ff0 ("net/ice: support Rx timestamp offload on vector path")

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 57 +++----------------
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 57 +++----------------
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 61 +++++++++++++++++++++
 3 files changed, 79 insertions(+), 96 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index d1b31bb452..1e468d819b 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -46,6 +46,9 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union ci_rx_flex_desc *rxdp = rxq->rx_flex_ring + rxq->rx_tail;
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	const uint8_t *split_flags = split_packet;
+#endif
 
 	rte_prefetch0(rxdp);
 
@@ -559,9 +562,6 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						rxq->ts_offset, uint32_t *) =
 						_mm256_extract_epi32(raw_desc_bh6_7, 7);
-
-					mbuf_flags = _mm256_or_si256(mbuf_flags,
-						_mm256_set1_epi32((int)rxq->ts_flag));
 				} /* if() on Rx timestamp parsing */
 			} /* if() on RSS hash or Rx timestamp parsing */
 #endif
@@ -698,51 +698,6 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			break;
 	}
 
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-	/**
-	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
-	 * were actually received, tracking the register rollover. This mirrors
-	 * the scalar Rx path and is only done over valid (received) packets, so
-	 * timestamps of non-DD descriptors never corrupt the rollover state.
-	 */
-	if (offload && received > 0 &&
-			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
-		struct ice_vsi *vsi = rxq->ice_vsi;
-		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-		struct ice_adapter *ad = vsi->adapter;
-		uint64_t ts_ns;
-		bool is_tsinit = false;
-		uint64_t sw_cur_time =
-			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
-			is_tsinit = true;
-
-		for (uint16_t k = 0; k < received; k++) {
-			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
-					rxq->ts_offset, uint32_t *);
-
-			rxq->time_high = ts_high;
-			if (unlikely(is_tsinit)) {
-				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
-								   ts_high);
-				rxq->hw_time_low = (uint32_t)ts_ns;
-				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
-				is_tsinit = false;
-			} else {
-				if (ts_high < rxq->hw_time_low)
-					rxq->hw_time_high += 1;
-				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
-				rxq->hw_time_low = ts_high;
-			}
-			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
-					   rte_mbuf_timestamp_t *) = ts_ns;
-		}
-		rxq->hw_time_update = rte_get_timer_cycles() /
-				      (rte_get_timer_hz() / 1000);
-	}
-#endif
-
 	/* update tail pointers */
 	rxq->rx_tail += received;
 	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
@@ -751,6 +706,12 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		received--;
 	}
 	rxq->rxrearm_nb += received;
+
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	if (offload && received > 0 &&
+			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
+		ice_rx_vec_ts_finalize(rxq, rx_pkts, received, split_flags);
+#endif
 	return received;
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 81eaa47842..ef189803d6 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -47,6 +47,9 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 			0, rxq->mbuf_initializer);
 	struct ci_rx_entry *sw_ring = &rxq->sw_ring[rxq->rx_tail];
 	volatile union ci_rx_flex_desc *rxdp = rxq->rx_flex_ring + rxq->rx_tail;
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	const uint8_t *split_flags = split_packet;
+#endif
 
 	rte_prefetch0(rxdp);
 
@@ -581,9 +584,6 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
 						rxq->ts_offset, uint32_t *) =
 						_mm256_extract_epi32(raw_desc_bh6_7, 7);
-
-					mbuf_flags = _mm256_or_si256(mbuf_flags,
-						_mm256_set1_epi32((int)rxq->ts_flag));
 				} /* if() on Rx timestamp parsing */
 			} /* if() on RSS hash or Rx timestamp parsing */
 #endif
@@ -724,51 +724,6 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 			break;
 	}
 
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-	/**
-	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
-	 * were actually received, tracking the register rollover. This mirrors
-	 * the scalar Rx path and is only done over valid (received) packets, so
-	 * timestamps of non-DD descriptors never corrupt the rollover state.
-	 */
-	if (do_offload && received > 0 &&
-			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
-		struct ice_vsi *vsi = rxq->ice_vsi;
-		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
-		struct ice_adapter *ad = vsi->adapter;
-		uint64_t ts_ns;
-		bool is_tsinit = false;
-		uint64_t sw_cur_time =
-			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
-
-		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
-			is_tsinit = true;
-
-		for (uint16_t k = 0; k < received; k++) {
-			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
-					rxq->ts_offset, uint32_t *);
-
-			rxq->time_high = ts_high;
-			if (unlikely(is_tsinit)) {
-				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
-								   ts_high);
-				rxq->hw_time_low = (uint32_t)ts_ns;
-				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
-				is_tsinit = false;
-			} else {
-				if (ts_high < rxq->hw_time_low)
-					rxq->hw_time_high += 1;
-				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
-				rxq->hw_time_low = ts_high;
-			}
-			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
-					   rte_mbuf_timestamp_t *) = ts_ns;
-		}
-		rxq->hw_time_update = rte_get_timer_cycles() /
-				      (rte_get_timer_hz() / 1000);
-	}
-#endif
-
 	/* update tail pointers */
 	rxq->rx_tail += received;
 	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
@@ -777,6 +732,12 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 		received--;
 	}
 	rxq->rxrearm_nb += received;
+
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	if (do_offload && received > 0 &&
+			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
+		ice_rx_vec_ts_finalize(rxq, rx_pkts, received, split_flags);
+#endif
 	return received;
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index d5ef213e08..54413eebd3 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -5,9 +5,70 @@
 #ifndef _ICE_RXTX_VEC_COMMON_H_
 #define _ICE_RXTX_VEC_COMMON_H_
 
+#include <rte_cycles.h>
+#include <rte_mbuf_dyn.h>
+
 #include "../common/rx.h"
 #include "ice_rxtx.h"
 
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+/*
+ * Extend the 32b Rx timestamps stashed in the mbuf dynfield by the vector
+ * loop to 64b, set the timestamp flag and mark PTP packets. Only EOP
+ * descriptors carry the timestamp; it is stored on the packet's first segment.
+ */
+static inline void
+ice_rx_vec_ts_finalize(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+		       uint16_t nb_bufs, const uint8_t *split_flags)
+{
+	struct ice_vsi *vsi = rxq->ice_vsi;
+	struct ice_adapter *ad = vsi->adapter;
+	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
+	const uint64_t ms_hz = rte_get_timer_hz() / 1000;
+	bool is_tsinit = rte_get_timer_cycles() / ms_hz - rxq->hw_time_update > 4;
+	/* first segment of a packet that started in a previous burst */
+	struct rte_mbuf *head = split_flags != NULL ? rxq->pkt_first_seg : NULL;
+	uint16_t k;
+
+	for (k = 0; k < nb_bufs; k++) {
+		struct rte_mbuf *mb = rx_pkts[k];
+		uint32_t ts_high;
+		uint64_t ts_ns;
+
+		if (head == NULL)
+			head = mb;
+		if (split_flags != NULL && split_flags[k] != 0)
+			continue;
+
+		ts_high = *RTE_MBUF_DYNFIELD(mb, rxq->ts_offset, uint32_t *);
+		if (unlikely(is_tsinit)) {
+			ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1, ts_high);
+			rxq->hw_time_low = (uint32_t)ts_ns;
+			rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+			is_tsinit = false;
+		} else {
+			if (ts_high < rxq->hw_time_low)
+				rxq->hw_time_high += 1;
+			ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
+			rxq->hw_time_low = ts_high;
+		}
+		*RTE_MBUF_DYNFIELD(head, rxq->ts_offset, rte_mbuf_timestamp_t *) = ts_ns;
+		/* reassembly copies ol_flags from the EOP segment to the head */
+		mb->ol_flags |= rxq->ts_flag;
+
+		if (ad->ptp_ena && (mb->packet_type & RTE_PTYPE_L2_MASK) ==
+				RTE_PTYPE_L2_ETHER_TIMESYNC) {
+			rxq->time_high = ts_high;
+			head->timesync = rxq->queue_id;
+			mb->timesync = rxq->queue_id;
+			mb->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+		}
+		head = NULL;
+	}
+	rxq->hw_time_update = rte_get_timer_cycles() / ms_hz;
+}
+#endif
+
 static inline int
 ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
 {
-- 
2.43.0

