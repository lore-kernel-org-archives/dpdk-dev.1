Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B5BCA600D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 17:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED1FC40294;
	Thu,  8 Oct 2026 19:34:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5EE3640284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 19:34:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791480867; x=1823016867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mK/NxohS9QB5ZWKm5vQrn8nVfHWdTYzg/jueuBaYx7Q=;
 b=Ge1Q+bZSB7+2JGY9X7dcrl/2GzNAGXaxYh7i3kjQw6289/Z9jFcH3L8f
 W9U5uMJoooZDcwiroO8dLiXSSZGyF0WlAWiR4PwMMs82mTrR3uLtP2Kbj
 HIqBnm9/mm4LYu6K3ihH59OVp1BryQ3DMngnJOgMk9+H4lRisLbrf5cwB
 TFmdPwy7R7SFPqWkwKs0mOA4XCZoK9HB86s7q5L21MvhyTkwmHuqXaiE7
 b4Yxr2MtLwq/AWb8yhuI4u8NrrRg4cImvKSGBtmSCQfwuJo/XMqM/tWGr
 ylQ1gFv6zJIou0MSC3xcAGjjPiRz5Cqy3McYuf2IDqtfj6S6xnBKxsRl4 g==;
X-CSE-ConnectionGUID: MDHwir4LRu24qyqZXS3iqw==
X-CSE-MsgGUID: N8YyvdBARCmZ+m/qq0xzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="383168"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="383168"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:34:26 -0700
X-CSE-ConnectionGUID: Cq5lDlRdQNeIEH+DLfNu9A==
X-CSE-MsgGUID: b07ZSPbfRpKM7/Va/yLiow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="216769"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2026 10:34:25 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2] net/ice: support Rx timestamp offload on vector path
Date: Fri,  9 Oct 2026 00:36:30 +0000
Message-Id: <20261009003630.27749-1-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
References: <20260918210352.303512-1-sandeep.penigalapati@intel.com>
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

The ice PMD only supported Rx hardware timestamp offload
(RTE_ETH_RX_OFFLOAD_TIMESTAMP) on the scalar Rx path. Enabling the
offload forced a fallback from the AVX2/AVX512 vector Rx paths to the
scalar path, causing a significant performance drop on 800 series
adapters.

Add Rx timestamp support to the AVX2 and AVX512 vector Rx paths,
mirroring the existing iavf implementation: the 32-bit timestamp is
read from the flex descriptor in the vectorized loop and converted to
64 bits, with register rollover tracking, in a scalar pass over the
received packets after the loop.

Advertise the timestamp offload only on the x86 vector paths that
implement it, via a new ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS mask, so on
Arm the request still falls back to the scalar path.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
- rebased to current main; fixed release notes and ice.ini conflicts
- kept the offload check on two lines

 doc/guides/nics/features/ice.ini            |   2 +-
 doc/guides/rel_notes/release_26_11.rst      |   2 +
 drivers/net/intel/ice/ice_rxtx.c            |   8 +-
 drivers/net/intel/ice/ice_rxtx.h            |   4 +
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 157 +++++++++++++++-----
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 157 +++++++++++++++-----
 6 files changed, 257 insertions(+), 73 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 2bf1b2a42d..123ecb0da0 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -37,7 +37,7 @@ VLAN offload         = Y
 QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
-Timestamp offload    = P
+Timestamp offload    = Y
 Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Packet type parsing  = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 16d3a90723..912ffb8630 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,6 +100,8 @@ New Features
   * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx paths,
     enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
   * Added support for Tx rate limiting per queue.
+  * Added support for the Rx hardware timestamp offload
+    (``RTE_ETH_RX_OFFLOAD_TIMESTAMP``) in the AVX2 and AVX512 vector Rx paths.
 
 * **Updated Intel ixgbe driver.**
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..f8ac777e3e 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3313,7 +3313,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_pkts_vec_avx2_offload,
 		.info = "Offload Vector AVX2",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.bulk_alloc = true
 		}
@@ -3322,7 +3322,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_scattered_pkts_vec_avx2_offload,
 		.info = "Offload Vector AVX2 Scattered",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.scattered = true,
 			.bulk_alloc = true
@@ -3352,7 +3352,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_pkts_vec_avx512_offload,
 		.info = "Offload Vector AVX512",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
 			.bulk_alloc = true
 		}
@@ -3361,7 +3361,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.pkt_burst = ice_recv_scattered_pkts_vec_avx512_offload,
 		.info = "Offload Vector AVX512 Scattered",
 		.features = {
-			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
 			.scattered = true,
 			.bulk_alloc = true
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index cd23f7c56f..b450525ce3 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -103,6 +103,10 @@
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |	\
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
+/* vector offload paths that also support Rx timestamp (AVX2/AVX512 only) */
+#define ICE_RX_VECTOR_OFFLOAD_TS_OFFLOADS (	\
+		ICE_RX_VECTOR_OFFLOAD_OFFLOADS |\
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
 
 /* basic scalar path */
 #define ICE_TX_SCALAR_OFFLOADS (		\
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 056b2dc49b..d1b31bb452 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -8,6 +8,7 @@
 #include "../common/tx_vec_x86.h"
 
 #include <rte_vect.h>
+#include <rte_mbuf_dyn.h>
 
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
@@ -441,12 +442,15 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 		if (offload) {
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+			const uint64_t rxmode_offloads =
+				rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads;
 			/**
-			 * needs to load 2nd 16B of each desc for RSS hash parsing,
+			 * needs to load 2nd 16B of each desc for RSS hash parsing
+			 * or Rx timestamp offload,
 			 * will cause performance drop to get into this context.
 			 */
-			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
-					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
+			if (rxmode_offloads & (RTE_ETH_RX_OFFLOAD_RSS_HASH |
+					RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 				/* load bottom half of every 32B desc */
 				const __m128i raw_desc_bh7 = _mm_load_si128
 					(RTE_CAST_PTR(const __m128i *, &rxdp[7].wb.status_error1));
@@ -489,37 +493,77 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 						(_mm256_castsi128_si256(raw_desc_bh0),
 						raw_desc_bh1, 1);
 
-				/**
-				 * to shift the 32b RSS hash value to the
-				 * highest 32b of each 128b before mask
-				 */
-				__m256i rss_hash6_7 =
-					_mm256_slli_epi64(raw_desc_bh6_7, 32);
-				__m256i rss_hash4_5 =
-					_mm256_slli_epi64(raw_desc_bh4_5, 32);
-				__m256i rss_hash2_3 =
-					_mm256_slli_epi64(raw_desc_bh2_3, 32);
-				__m256i rss_hash0_1 =
-					_mm256_slli_epi64(raw_desc_bh0_1, 32);
-
-				__m256i rss_hash_msk =
-					_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
-							 0xFFFFFFFF, 0, 0, 0);
-
-				rss_hash6_7 = _mm256_and_si256
-						(rss_hash6_7, rss_hash_msk);
-				rss_hash4_5 = _mm256_and_si256
-						(rss_hash4_5, rss_hash_msk);
-				rss_hash2_3 = _mm256_and_si256
-						(rss_hash2_3, rss_hash_msk);
-				rss_hash0_1 = _mm256_and_si256
-						(rss_hash0_1, rss_hash_msk);
-
-				mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
-				mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
-				mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
-				mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
-			} /* if() on RSS hash parsing */
+				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH) {
+					/**
+					 * to shift the 32b RSS hash value to the
+					 * highest 32b of each 128b before mask
+					 */
+					__m256i rss_hash6_7 =
+						_mm256_slli_epi64(raw_desc_bh6_7, 32);
+					__m256i rss_hash4_5 =
+						_mm256_slli_epi64(raw_desc_bh4_5, 32);
+					__m256i rss_hash2_3 =
+						_mm256_slli_epi64(raw_desc_bh2_3, 32);
+					__m256i rss_hash0_1 =
+						_mm256_slli_epi64(raw_desc_bh0_1, 32);
+
+					__m256i rss_hash_msk =
+						_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
+								 0xFFFFFFFF, 0, 0, 0);
+
+					rss_hash6_7 = _mm256_and_si256
+							(rss_hash6_7, rss_hash_msk);
+					rss_hash4_5 = _mm256_and_si256
+							(rss_hash4_5, rss_hash_msk);
+					rss_hash2_3 = _mm256_and_si256
+							(rss_hash2_3, rss_hash_msk);
+					rss_hash0_1 = _mm256_and_si256
+							(rss_hash0_1, rss_hash_msk);
+
+					mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
+					mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
+					mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
+					mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
+				} /* if() on RSS hash parsing */
+
+				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+					/**
+					 * Extract the 32b Rx timestamp (flex_ts.ts_high),
+					 * located in the highest 32b of each 32B desc, and
+					 * stash it (low 32b) into the mbuf timestamp
+					 * dynfield. The 32b->64b conversion with rollover
+					 * tracking is performed in a scalar pass after the
+					 * main loop (see below), matching the scalar path.
+					 */
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh0_1, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 1],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh0_1, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 2],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh2_3, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 3],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh2_3, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 4],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh4_5, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 5],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh4_5, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 6],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh6_7, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh6_7, 7);
+
+					mbuf_flags = _mm256_or_si256(mbuf_flags,
+						_mm256_set1_epi32((int)rxq->ts_flag));
+				} /* if() on Rx timestamp parsing */
+			} /* if() on RSS hash or Rx timestamp parsing */
 #endif
 		}
 
@@ -654,6 +698,51 @@ _ice_recv_raw_pkts_vec_avx2(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			break;
 	}
 
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	/**
+	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
+	 * were actually received, tracking the register rollover. This mirrors
+	 * the scalar Rx path and is only done over valid (received) packets, so
+	 * timestamps of non-DD descriptors never corrupt the rollover state.
+	 */
+	if (offload && received > 0 &&
+			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+		struct ice_vsi *vsi = rxq->ice_vsi;
+		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
+		struct ice_adapter *ad = vsi->adapter;
+		uint64_t ts_ns;
+		bool is_tsinit = false;
+		uint64_t sw_cur_time =
+			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
+
+		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
+			is_tsinit = true;
+
+		for (uint16_t k = 0; k < received; k++) {
+			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
+					rxq->ts_offset, uint32_t *);
+
+			rxq->time_high = ts_high;
+			if (unlikely(is_tsinit)) {
+				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
+								   ts_high);
+				rxq->hw_time_low = (uint32_t)ts_ns;
+				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+				is_tsinit = false;
+			} else {
+				if (ts_high < rxq->hw_time_low)
+					rxq->hw_time_high += 1;
+				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
+				rxq->hw_time_low = ts_high;
+			}
+			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
+					   rte_mbuf_timestamp_t *) = ts_ns;
+		}
+		rxq->hw_time_update = rte_get_timer_cycles() /
+				      (rte_get_timer_hz() / 1000);
+	}
+#endif
+
 	/* update tail pointers */
 	rxq->rx_tail += received;
 	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 0548c293bb..81eaa47842 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -8,6 +8,7 @@
 #include "../common/tx_vec_x86.h"
 
 #include <rte_vect.h>
+#include <rte_mbuf_dyn.h>
 
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
@@ -463,12 +464,15 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 
 		if (do_offload) {
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+			const uint64_t rxmode_offloads =
+				rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads;
 			/**
-			 * needs to load 2nd 16B of each desc for RSS hash parsing,
+			 * needs to load 2nd 16B of each desc for RSS hash parsing
+			 * or Rx timestamp offload,
 			 * will cause performance drop to get into this context.
 			 */
-			if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
-					RTE_ETH_RX_OFFLOAD_RSS_HASH) {
+			if (rxmode_offloads & (RTE_ETH_RX_OFFLOAD_RSS_HASH |
+					RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
 				/* load bottom half of every 32B desc */
 				const __m128i raw_desc_bh7 = _mm_load_si128
 					(RTE_CAST_PTR(const __m128i *, &rxdp[7].wb.status_error1));
@@ -511,37 +515,77 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 						(_mm256_castsi128_si256(raw_desc_bh0),
 						raw_desc_bh1, 1);
 
-				/**
-				 * to shift the 32b RSS hash value to the
-				 * highest 32b of each 128b before mask
-				 */
-				__m256i rss_hash6_7 =
-					_mm256_slli_epi64(raw_desc_bh6_7, 32);
-				__m256i rss_hash4_5 =
-					_mm256_slli_epi64(raw_desc_bh4_5, 32);
-				__m256i rss_hash2_3 =
-					_mm256_slli_epi64(raw_desc_bh2_3, 32);
-				__m256i rss_hash0_1 =
-					_mm256_slli_epi64(raw_desc_bh0_1, 32);
-
-				__m256i rss_hash_msk =
-					_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
-							 0xFFFFFFFF, 0, 0, 0);
-
-				rss_hash6_7 = _mm256_and_si256
-						(rss_hash6_7, rss_hash_msk);
-				rss_hash4_5 = _mm256_and_si256
-						(rss_hash4_5, rss_hash_msk);
-				rss_hash2_3 = _mm256_and_si256
-						(rss_hash2_3, rss_hash_msk);
-				rss_hash0_1 = _mm256_and_si256
-						(rss_hash0_1, rss_hash_msk);
-
-				mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
-				mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
-				mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
-				mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
-			} /* if() on RSS hash parsing */
+				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH) {
+					/**
+					 * to shift the 32b RSS hash value to the
+					 * highest 32b of each 128b before mask
+					 */
+					__m256i rss_hash6_7 =
+						_mm256_slli_epi64(raw_desc_bh6_7, 32);
+					__m256i rss_hash4_5 =
+						_mm256_slli_epi64(raw_desc_bh4_5, 32);
+					__m256i rss_hash2_3 =
+						_mm256_slli_epi64(raw_desc_bh2_3, 32);
+					__m256i rss_hash0_1 =
+						_mm256_slli_epi64(raw_desc_bh0_1, 32);
+
+					__m256i rss_hash_msk =
+						_mm256_set_epi32(0xFFFFFFFF, 0, 0, 0,
+								 0xFFFFFFFF, 0, 0, 0);
+
+					rss_hash6_7 = _mm256_and_si256
+							(rss_hash6_7, rss_hash_msk);
+					rss_hash4_5 = _mm256_and_si256
+							(rss_hash4_5, rss_hash_msk);
+					rss_hash2_3 = _mm256_and_si256
+							(rss_hash2_3, rss_hash_msk);
+					rss_hash0_1 = _mm256_and_si256
+							(rss_hash0_1, rss_hash_msk);
+
+					mb6_7 = _mm256_or_si256(mb6_7, rss_hash6_7);
+					mb4_5 = _mm256_or_si256(mb4_5, rss_hash4_5);
+					mb2_3 = _mm256_or_si256(mb2_3, rss_hash2_3);
+					mb0_1 = _mm256_or_si256(mb0_1, rss_hash0_1);
+				} /* if() on RSS hash parsing */
+
+				if (rxmode_offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+					/**
+					 * Extract the 32b Rx timestamp (flex_ts.ts_high),
+					 * located in the highest 32b of each 32B desc, and
+					 * stash it (low 32b) into the mbuf timestamp
+					 * dynfield. The 32b->64b conversion with rollover
+					 * tracking is performed in a scalar pass after the
+					 * main loop (see below), matching the scalar path.
+					 */
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 0],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh0_1, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 1],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh0_1, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 2],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh2_3, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 3],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh2_3, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 4],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh4_5, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 5],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh4_5, 7);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 6],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh6_7, 3);
+					*RTE_MBUF_DYNFIELD(rx_pkts[i + 7],
+						rxq->ts_offset, uint32_t *) =
+						_mm256_extract_epi32(raw_desc_bh6_7, 7);
+
+					mbuf_flags = _mm256_or_si256(mbuf_flags,
+						_mm256_set1_epi32((int)rxq->ts_flag));
+				} /* if() on Rx timestamp parsing */
+			} /* if() on RSS hash or Rx timestamp parsing */
 #endif
 		}
 
@@ -680,6 +724,51 @@ _ice_recv_raw_pkts_vec_avx512(struct ci_rx_queue *rxq,
 			break;
 	}
 
+#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
+	/**
+	 * Convert the stashed 32b Rx timestamps to 64b for the packets that
+	 * were actually received, tracking the register rollover. This mirrors
+	 * the scalar Rx path and is only done over valid (received) packets, so
+	 * timestamps of non-DD descriptors never corrupt the rollover state.
+	 */
+	if (do_offload && received > 0 &&
+			(rxq->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+		struct ice_vsi *vsi = rxq->ice_vsi;
+		struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
+		struct ice_adapter *ad = vsi->adapter;
+		uint64_t ts_ns;
+		bool is_tsinit = false;
+		uint64_t sw_cur_time =
+			rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
+
+		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
+			is_tsinit = true;
+
+		for (uint16_t k = 0; k < received; k++) {
+			uint32_t ts_high = *RTE_MBUF_DYNFIELD(rx_pkts[k],
+					rxq->ts_offset, uint32_t *);
+
+			rxq->time_high = ts_high;
+			if (unlikely(is_tsinit)) {
+				ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
+								   ts_high);
+				rxq->hw_time_low = (uint32_t)ts_ns;
+				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+				is_tsinit = false;
+			} else {
+				if (ts_high < rxq->hw_time_low)
+					rxq->hw_time_high += 1;
+				ts_ns = (uint64_t)rxq->hw_time_high << 32 | ts_high;
+				rxq->hw_time_low = ts_high;
+			}
+			*RTE_MBUF_DYNFIELD(rx_pkts[k], rxq->ts_offset,
+					   rte_mbuf_timestamp_t *) = ts_ns;
+		}
+		rxq->hw_time_update = rte_get_timer_cycles() /
+				      (rte_get_timer_hz() / 1000);
+	}
+#endif
+
 	/* update tail pointers */
 	rxq->rx_tail += received;
 	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
-- 
2.34.1

