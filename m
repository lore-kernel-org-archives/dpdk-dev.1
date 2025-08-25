Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7269CCA0FE9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89E2740671;
	Mon, 25 Aug 2025 14:36:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4A9BA4065E
 for <dev@dpdk.org>; Mon, 25 Aug 2025 14:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756125358; x=1787661358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sW/Ehi0Y4OrqJnz6ZbFWVAka5fQStPsIFZ8IlEOV4uI=;
 b=gzH14HtnyYhB7X4a47YKSG2lauURsv6Z0fucpDeEF/EKcyfncmpcsnOL
 yEYA0HDzDOLX5CBFzl8XW0MPJyfQ7SXTtMTtP7t1jzzi9Ro3i/mJDlDa5
 j7+8bP3hw+p6sjEZ14Z9G5gCDo0Ubzrh54wlwZCVR5wgT65C6e5Gkv5xg
 OYklkRgQfXTTTwHUbfD0CVCFNTKFkNXG/Po1CPl4cZXrp2hm1o+h2CAz9
 4bkI24SKja8H1mmTQs1VyR4s69KqJ5FPN/00e47EtIxHmxAsPO1AcvYH/
 N2i3+9Ywjg2CPG4L9Wud1hxU3JMCnlQnAi628E/eYhxeVKr6HEsB3JtVg w==;
X-CSE-ConnectionGUID: Zo+2cbMVTCq7FomvD2qoNA==
X-CSE-MsgGUID: csPHhyt7Sa2lXTWmZoIG2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="69049714"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="69049714"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 05:35:58 -0700
X-CSE-ConnectionGUID: xmDFfvSnS3C/uhSq+2QJlA==
X-CSE-MsgGUID: Lv+SxDYASTS0YmxEBkiyQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; d="scan'208";a="168791966"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa007.fm.intel.com with ESMTP; 25 Aug 2025 05:35:57 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/4] net/ice: remove SSE vector path
Date: Mon, 25 Aug 2025 12:35:47 +0000
Message-Id: <20250825123548.1177090-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825123548.1177090-1-ciara.loftus@intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
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

Modern x86 systems all support AVX2, if not AVX-512, so the SSE path
is no longer widely used. This change will not result in any feature
loss, as in the rare cases where the SSE path would have been used in
the absence of AVX2 or AVX-512, the fallback scalar path will be used
which has feature parity with SSE.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c          |  43 +-
 drivers/net/intel/ice/ice_rxtx.h          |   6 -
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c |  29 +
 drivers/net/intel/ice/ice_rxtx_vec_sse.c  | 743 ----------------------
 drivers/net/intel/ice/meson.build         |   1 -
 5 files changed, 49 insertions(+), 773 deletions(-)
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_vec_sse.c

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 7e5c0a9b29..e30d50a499 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -9,6 +9,10 @@
 #include "ice_rxtx.h"
 #include "ice_rxtx_vec_common.h"
 
+#ifdef RTE_ARCH_X86
+#include "../common/rx_vec_x86.h"
+#endif
+
 #define ICE_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |		 \
 		RTE_MBUF_F_TX_L4_MASK |		 \
 		RTE_MBUF_F_TX_TCP_SEG |		 \
@@ -2464,18 +2468,14 @@ ice_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		return ptypes;
 
 #ifdef RTE_ARCH_X86
-	if (dev->rx_pkt_burst == ice_recv_pkts_vec ||
-	    dev->rx_pkt_burst == ice_recv_scattered_pkts_vec ||
-#ifdef CC_AVX512_SUPPORT
-	    dev->rx_pkt_burst == ice_recv_pkts_vec_avx512 ||
-	    dev->rx_pkt_burst == ice_recv_pkts_vec_avx512_offload ||
-	    dev->rx_pkt_burst == ice_recv_scattered_pkts_vec_avx512 ||
-	    dev->rx_pkt_burst == ice_recv_scattered_pkts_vec_avx512_offload ||
-#endif
-	    dev->rx_pkt_burst == ice_recv_pkts_vec_avx2 ||
-	    dev->rx_pkt_burst == ice_recv_pkts_vec_avx2_offload ||
-	    dev->rx_pkt_burst == ice_recv_scattered_pkts_vec_avx2 ||
-	    dev->rx_pkt_burst == ice_recv_scattered_pkts_vec_avx2_offload)
+	if (ad->rx_func_type == ICE_RX_AVX2 ||
+			ad->rx_func_type == ICE_RX_AVX2_OFFLOAD ||
+			ad->rx_func_type == ICE_RX_AVX2_SCATTERED ||
+			ad->rx_func_type == ICE_RX_AVX2_SCATTERED_OFFLOAD ||
+			ad->rx_func_type == ICE_RX_AVX512 ||
+			ad->rx_func_type == ICE_RX_AVX512_OFFLOAD ||
+			ad->rx_func_type == ICE_RX_AVX512_SCATTERED ||
+			ad->rx_func_type == ICE_RX_AVX512_SCATTERED_OFFLOAD)
 		return ptypes;
 #endif
 
@@ -3479,6 +3479,12 @@ ice_tx_done_cleanup_vec(struct ci_tx_queue *txq __rte_unused,
 {
 	return -ENOTSUP;
 }
+
+enum rte_vect_max_simd
+ice_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
 #endif
 
 static int
@@ -3674,11 +3680,6 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 	[ICE_RX_BULK_ALLOC] = {ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
 		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
 #ifdef RTE_ARCH_X86
-	[ICE_RX_SSE] = {ice_recv_pkts_vec, "Vector SSE",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[ICE_RX_SSE_SCATTERED] = {ice_recv_scattered_pkts_vec, "Vector SSE Scattered",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
 	[ICE_RX_AVX2] = {ice_recv_pkts_vec_avx2, "Vector AVX2",
 		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
 	[ICE_RX_AVX2_SCATTERED] = {ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
@@ -4051,12 +4052,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 					ice_xmit_pkts_vec_avx2_offload;
 				dev->tx_pkt_prepare = ice_prep_pkts;
 			} else {
-				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
+				PMD_DRV_LOG(DEBUG, "Using avx2 Vector Tx (port %d).",
 					    dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    ice_xmit_pkts_vec_avx2 :
-						    ice_xmit_pkts_vec;
+				dev->tx_pkt_burst = ice_xmit_pkts_vec_avx2;
 			}
 		}
 
@@ -4097,7 +4095,6 @@ static const struct {
 #endif
 	{ ice_xmit_pkts_vec_avx2,         "Vector AVX2" },
 	{ ice_xmit_pkts_vec_avx2_offload, "Offload Vector AVX2" },
-	{ ice_xmit_pkts_vec,              "Vector SSE" },
 #endif
 };
 
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 488ba85562..7c7e58c286 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -251,12 +251,6 @@ int ice_rx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_tx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_rxq_vec_setup(struct ci_rx_queue *rxq);
 int ice_txq_vec_setup(struct ci_tx_queue *txq);
-uint16_t ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-			   uint16_t nb_pkts);
-uint16_t ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-				     uint16_t nb_pkts);
-uint16_t ice_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-			   uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx2_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index b952b8dddc..dbe0cac89f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -949,3 +949,32 @@ ice_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	return ice_xmit_pkts_vec_avx2_common(tx_queue, tx_pkts, nb_pkts, true);
 }
+
+int __rte_cold
+ice_rxq_vec_setup(struct ci_rx_queue *rxq)
+{
+	if (!rxq)
+		return -1;
+
+	rxq->rx_rel_mbufs = _ice_rx_queue_release_mbufs_vec;
+	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
+	return 0;
+}
+
+int __rte_cold
+ice_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
+{
+	return 0;
+}
+
+int __rte_cold
+ice_rx_vec_dev_check(struct rte_eth_dev *dev)
+{
+	return ice_rx_vec_dev_check_default(dev);
+}
+
+int __rte_cold
+ice_tx_vec_dev_check(struct rte_eth_dev *dev)
+{
+	return ice_tx_vec_dev_check_default(dev);
+}
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
deleted file mode 100644
index 1545bc3b6e..0000000000
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ /dev/null
@@ -1,743 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019 Intel Corporation
- */
-
-#include "ice_rxtx_vec_common.h"
-
-#include "../common/rx_vec_x86.h"
-
-#include <rte_vect.h>
-
-static inline __m128i
-ice_flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
-{
-#define FDID_MIS_MAGIC 0xFFFFFFFF
-	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR != (1 << 2));
-	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR_ID != (1 << 13));
-	const __m128i pkt_fdir_bit = _mm_set1_epi32(RTE_MBUF_F_RX_FDIR |
-			RTE_MBUF_F_RX_FDIR_ID);
-	/* desc->flow_id field == 0xFFFFFFFF means fdir mismatch */
-	const __m128i fdir_mis_mask = _mm_set1_epi32(FDID_MIS_MAGIC);
-	__m128i fdir_mask = _mm_cmpeq_epi32(fdir_id0_3,
-			fdir_mis_mask);
-	/* this XOR op results to bit-reverse the fdir_mask */
-	fdir_mask = _mm_xor_si128(fdir_mask, fdir_mis_mask);
-	const __m128i fdir_flags = _mm_and_si128(fdir_mask, pkt_fdir_bit);
-
-	return fdir_flags;
-}
-
-static inline void
-ice_rxq_rearm(struct ci_rx_queue *rxq)
-{
-	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
-}
-
-static inline void
-ice_rx_desc_to_olflags_v(struct ci_rx_queue *rxq, __m128i descs[4],
-			 struct rte_mbuf **rx_pkts)
-{
-	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
-	__m128i rearm0, rearm1, rearm2, rearm3;
-
-	__m128i tmp_desc, flags, rss_vlan;
-
-	/* mask everything except checksum, RSS and VLAN flags.
-	 * bit6:4 for checksum.
-	 * bit12 for RSS indication.
-	 * bit13 for VLAN indication.
-	 */
-	const __m128i desc_mask = _mm_set_epi32(0x30f0, 0x30f0,
-						0x30f0, 0x30f0);
-	const __m128i cksum_mask = _mm_set_epi32(RTE_MBUF_F_RX_IP_CKSUM_MASK |
-						 RTE_MBUF_F_RX_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-						 RTE_MBUF_F_RX_IP_CKSUM_MASK |
-						 RTE_MBUF_F_RX_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-						 RTE_MBUF_F_RX_IP_CKSUM_MASK |
-						 RTE_MBUF_F_RX_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-						 RTE_MBUF_F_RX_IP_CKSUM_MASK |
-						 RTE_MBUF_F_RX_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK |
-						 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD);
-
-	/* map the checksum, rss and vlan fields to the checksum, rss
-	 * and vlan flag
-	 */
-	const __m128i cksum_flags =
-		_mm_set_epi8((RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 |
-		 RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-		  RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		/**
-		 * shift right 20 bits to use the low two bits to indicate
-		 * outer checksum status
-		 * shift right 1 bit to make sure it not exceed 255
-		 */
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
-		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1);
-
-	const __m128i rss_vlan_flags = _mm_set_epi8(0, 0, 0, 0,
-			0, 0, 0, 0,
-			0, 0, 0, 0,
-			RTE_MBUF_F_RX_RSS_HASH | RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
-			RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
-			RTE_MBUF_F_RX_RSS_HASH, 0);
-
-	/* merge 4 descriptors */
-	flags = _mm_unpackhi_epi32(descs[0], descs[1]);
-	tmp_desc = _mm_unpackhi_epi32(descs[2], descs[3]);
-	tmp_desc = _mm_unpacklo_epi64(flags, tmp_desc);
-	tmp_desc = _mm_and_si128(tmp_desc, desc_mask);
-
-	/* checksum flags */
-	tmp_desc = _mm_srli_epi32(tmp_desc, 4);
-	flags = _mm_shuffle_epi8(cksum_flags, tmp_desc);
-	/* then we shift left 1 bit */
-	flags = _mm_slli_epi32(flags, 1);
-
-	__m128i l4_outer_mask = _mm_set_epi32(0x6, 0x6, 0x6, 0x6);
-	__m128i l4_outer_flags = _mm_and_si128(flags, l4_outer_mask);
-	l4_outer_flags = _mm_slli_epi32(l4_outer_flags, 20);
-
-	__m128i l3_l4_mask = _mm_set_epi32(~0x6, ~0x6, ~0x6, ~0x6);
-	__m128i l3_l4_flags = _mm_and_si128(flags, l3_l4_mask);
-	flags = _mm_or_si128(l3_l4_flags, l4_outer_flags);
-	/* we need to mask out the redundant bits introduced by RSS or
-	 * VLAN fields.
-	 */
-	flags = _mm_and_si128(flags, cksum_mask);
-
-	/* RSS, VLAN flag */
-	tmp_desc = _mm_srli_epi32(tmp_desc, 8);
-	rss_vlan = _mm_shuffle_epi8(rss_vlan_flags, tmp_desc);
-
-	/* merge the flags */
-	flags = _mm_or_si128(flags, rss_vlan);
-
-	if (rxq->fdir_enabled) {
-		const __m128i fdir_id0_1 =
-			_mm_unpackhi_epi32(descs[0], descs[1]);
-
-		const __m128i fdir_id2_3 =
-			_mm_unpackhi_epi32(descs[2], descs[3]);
-
-		const __m128i fdir_id0_3 =
-			_mm_unpackhi_epi64(fdir_id0_1, fdir_id2_3);
-
-		const __m128i fdir_flags =
-			ice_flex_rxd_to_fdir_flags_vec(fdir_id0_3);
-
-		/* merge with fdir_flags */
-		flags = _mm_or_si128(flags, fdir_flags);
-
-		/* write fdir_id to mbuf */
-		rx_pkts[0]->hash.fdir.hi =
-			_mm_extract_epi32(fdir_id0_3, 0);
-
-		rx_pkts[1]->hash.fdir.hi =
-			_mm_extract_epi32(fdir_id0_3, 1);
-
-		rx_pkts[2]->hash.fdir.hi =
-			_mm_extract_epi32(fdir_id0_3, 2);
-
-		rx_pkts[3]->hash.fdir.hi =
-			_mm_extract_epi32(fdir_id0_3, 3);
-	} /* if() on fdir_enabled */
-
-	/**
-	 * At this point, we have the 4 sets of flags in the low 16-bits
-	 * of each 32-bit value in flags.
-	 * We want to extract these, and merge them with the mbuf init data
-	 * so we can do a single 16-byte write to the mbuf to set the flags
-	 * and all the other initialization fields. Extracting the
-	 * appropriate flags means that we have to do a shift and blend for
-	 * each mbuf before we do the write.
-	 */
-	rearm0 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(flags, 8), 0x30);
-	rearm1 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(flags, 4), 0x30);
-	rearm2 = _mm_blend_epi16(mbuf_init, flags, 0x30);
-	rearm3 = _mm_blend_epi16(mbuf_init, _mm_srli_si128(flags, 4), 0x30);
-
-	/* write the rearm data and the olflags in one write */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
-			 offsetof(struct rte_mbuf, rearm_data) + 8);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
-			 RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
-	_mm_store_si128((__m128i *)&rx_pkts[0]->rearm_data, rearm0);
-	_mm_store_si128((__m128i *)&rx_pkts[1]->rearm_data, rearm1);
-	_mm_store_si128((__m128i *)&rx_pkts[2]->rearm_data, rearm2);
-	_mm_store_si128((__m128i *)&rx_pkts[3]->rearm_data, rearm3);
-}
-
-static inline void
-ice_rx_desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
-		       uint32_t *ptype_tbl)
-{
-	const __m128i ptype_mask = _mm_set_epi16(ICE_RX_FLEX_DESC_PTYPE_M, 0,
-						 ICE_RX_FLEX_DESC_PTYPE_M, 0,
-						 ICE_RX_FLEX_DESC_PTYPE_M, 0,
-						 ICE_RX_FLEX_DESC_PTYPE_M, 0);
-	__m128i ptype_01 = _mm_unpacklo_epi32(descs[0], descs[1]);
-	__m128i ptype_23 = _mm_unpacklo_epi32(descs[2], descs[3]);
-	__m128i ptype_all = _mm_unpacklo_epi64(ptype_01, ptype_23);
-
-	ptype_all = _mm_and_si128(ptype_all, ptype_mask);
-
-	rx_pkts[0]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 1)];
-	rx_pkts[1]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 3)];
-	rx_pkts[2]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 5)];
-	rx_pkts[3]->packet_type = ptype_tbl[_mm_extract_epi16(ptype_all, 7)];
-}
-
-/**
- * vPMD raw receive routine, only accept(nb_pkts >= ICE_VPMD_DESCS_PER_LOOP)
- *
- * Notice:
- * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a ICE_VPMD_DESCS_PER_LOOP power-of-two
- */
-static inline uint16_t
-_ice_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
-		       uint16_t nb_pkts, uint8_t *split_packet)
-{
-	volatile union ci_rx_flex_desc *rxdp;
-	struct ci_rx_entry *sw_ring;
-	uint16_t nb_pkts_recd;
-	int pos;
-	uint64_t var;
-	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
-	__m128i crc_adjust = _mm_set_epi16
-				(0, 0, 0,       /* ignore non-length fields */
-				 -rxq->crc_len, /* sub crc on data_len */
-				 0,          /* ignore high-16bits of pkt_len */
-				 -rxq->crc_len, /* sub crc on pkt_len */
-				 0, 0           /* ignore pkt_type field */
-				);
-	const __m128i zero = _mm_setzero_si128();
-	/* mask to shuffle from desc. to mbuf */
-	const __m128i shuf_msk = _mm_set_epi8
-			(0xFF, 0xFF,
-			 0xFF, 0xFF,  /* rss hash parsed separately */
-			 11, 10,      /* octet 10~11, 16 bits vlan_macip */
-			 5, 4,        /* octet 4~5, 16 bits data_len */
-			 0xFF, 0xFF,  /* skip high 16 bits pkt_len, zero out */
-			 5, 4,        /* octet 4~5, low 16 bits pkt_len */
-			 0xFF, 0xFF,  /* pkt_type set as unknown */
-			 0xFF, 0xFF   /* pkt_type set as unknown */
-			);
-	const __m128i eop_shuf_mask = _mm_set_epi8(0xFF, 0xFF,
-						   0xFF, 0xFF,
-						   0xFF, 0xFF,
-						   0xFF, 0xFF,
-						   0xFF, 0xFF,
-						   0xFF, 0xFF,
-						   0x04, 0x0C,
-						   0x00, 0x08);
-
-	/**
-	 * compile-time check the above crc_adjust layout is correct.
-	 * NOTE: the first field (lowest address) is given last in set_epi16
-	 * call above.
-	 */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
-
-	/* 4 packets DD mask */
-	const __m128i dd_check = _mm_set_epi64x(0x0000000100000001LL,
-						0x0000000100000001LL);
-	/* 4 packets EOP mask */
-	const __m128i eop_check = _mm_set_epi64x(0x0000000200000002LL,
-						 0x0000000200000002LL);
-
-	/* nb_pkts has to be floor-aligned to ICE_VPMD_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_VPMD_DESCS_PER_LOOP);
-
-	/* Just the act of getting into the function from the application is
-	 * going to cost about 7 cycles
-	 */
-	rxdp = rxq->rx_flex_ring + rxq->rx_tail;
-
-	rte_prefetch0(rxdp);
-
-	/* See if we need to rearm the RX queue - gives the prefetch a bit
-	 * of time to act
-	 */
-	if (rxq->rxrearm_nb > ICE_VPMD_RXQ_REARM_THRESH)
-		ice_rxq_rearm(rxq);
-
-	/* Before we start moving massive data around, check to see if
-	 * there is actually a packet available
-	 */
-	if (!(rxdp->wb.status_error0 &
-	      rte_cpu_to_le_32(1 << ICE_RX_FLEX_DESC_STATUS0_DD_S)))
-		return 0;
-
-	/**
-	 * Compile-time verify the shuffle mask
-	 * NOTE: some field positions already verified above, but duplicated
-	 * here for completeness in case of future modifications.
-	 */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
-			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
-
-	/* Cache is empty -> need to scan the buffer rings, but first move
-	 * the next 'n' mbufs into the cache
-	 */
-	sw_ring = &rxq->sw_ring[rxq->rx_tail];
-
-	/* A. load 4 packet in one loop
-	 * [A*. mask out 4 unused dirty field in desc]
-	 * B. copy 4 mbuf point from swring to rx_pkts
-	 * C. calc the number of DD bits among the 4 packets
-	 * [C*. extract the end-of-packet bit, if requested]
-	 * D. fill info. from desc to mbuf
-	 */
-
-	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-	     pos += ICE_VPMD_DESCS_PER_LOOP,
-	     rxdp += ICE_VPMD_DESCS_PER_LOOP) {
-		__m128i descs[ICE_VPMD_DESCS_PER_LOOP];
-		__m128i pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
-		__m128i staterr, sterr_tmp1, sterr_tmp2;
-		/* 2 64 bit or 4 32 bit mbuf pointers in one XMM reg. */
-		__m128i mbp1;
-#if defined(RTE_ARCH_X86_64)
-		__m128i mbp2;
-#endif
-
-		/* B.1 load 2 (64 bit) or 4 (32 bit) mbuf points */
-		mbp1 = _mm_loadu_si128((__m128i *)&sw_ring[pos]);
-		/* Read desc statuses backwards to avoid race condition */
-		/* A.1 load desc[3] */
-		descs[3] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 3));
-		rte_compiler_barrier();
-
-		/* B.2 copy 2 64 bit or 4 32 bit mbuf point into rx_pkts */
-		_mm_storeu_si128((__m128i *)&rx_pkts[pos], mbp1);
-
-#if defined(RTE_ARCH_X86_64)
-		/* B.1 load 2 64 bit mbuf points */
-		mbp2 = _mm_loadu_si128((__m128i *)&sw_ring[pos + 2]);
-#endif
-
-		/* A.1 load desc[2-0] */
-		descs[2] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 2));
-		rte_compiler_barrier();
-		descs[1] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp + 1));
-		rte_compiler_barrier();
-		descs[0] = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, rxdp));
-
-#if defined(RTE_ARCH_X86_64)
-		/* B.2 copy 2 mbuf point into rx_pkts  */
-		_mm_storeu_si128((__m128i *)&rx_pkts[pos + 2], mbp2);
-#endif
-
-		if (split_packet) {
-			rte_mbuf_prefetch_part2(rx_pkts[pos]);
-			rte_mbuf_prefetch_part2(rx_pkts[pos + 1]);
-			rte_mbuf_prefetch_part2(rx_pkts[pos + 2]);
-			rte_mbuf_prefetch_part2(rx_pkts[pos + 3]);
-		}
-
-		/* avoid compiler reorder optimization */
-		rte_compiler_barrier();
-
-		/* D.1 pkt 3,4 convert format from desc to pktmbuf */
-		pkt_mb3 = _mm_shuffle_epi8(descs[3], shuf_msk);
-		pkt_mb2 = _mm_shuffle_epi8(descs[2], shuf_msk);
-
-		/* D.1 pkt 1,2 convert format from desc to pktmbuf */
-		pkt_mb1 = _mm_shuffle_epi8(descs[1], shuf_msk);
-		pkt_mb0 = _mm_shuffle_epi8(descs[0], shuf_msk);
-
-		/* C.1 4=>2 filter staterr info only */
-		sterr_tmp2 = _mm_unpackhi_epi32(descs[3], descs[2]);
-		/* C.1 4=>2 filter staterr info only */
-		sterr_tmp1 = _mm_unpackhi_epi32(descs[1], descs[0]);
-
-		ice_rx_desc_to_olflags_v(rxq, descs, &rx_pkts[pos]);
-
-		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
-		pkt_mb3 = _mm_add_epi16(pkt_mb3, crc_adjust);
-		pkt_mb2 = _mm_add_epi16(pkt_mb2, crc_adjust);
-
-		/* D.2 pkt 1,2 set in_port/nb_seg and remove crc */
-		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
-		pkt_mb0 = _mm_add_epi16(pkt_mb0, crc_adjust);
-
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-		/**
-		 * needs to load 2nd 16B of each desc for RSS hash parsing,
-		 * will cause performance drop to get into this context.
-		 */
-		if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
-				RTE_ETH_RX_OFFLOAD_RSS_HASH) {
-			/* load bottom half of every 32B desc */
-			const __m128i raw_desc_bh3 =
-				_mm_load_si128
-					(RTE_CAST_PTR(const __m128i *, &rxdp[3].wb.status_error1));
-			rte_compiler_barrier();
-			const __m128i raw_desc_bh2 =
-				_mm_load_si128
-					(RTE_CAST_PTR(const __m128i *, &rxdp[2].wb.status_error1));
-			rte_compiler_barrier();
-			const __m128i raw_desc_bh1 =
-				_mm_load_si128
-					(RTE_CAST_PTR(const __m128i *, &rxdp[1].wb.status_error1));
-			rte_compiler_barrier();
-			const __m128i raw_desc_bh0 =
-				_mm_load_si128
-					(RTE_CAST_PTR(const __m128i *, &rxdp[0].wb.status_error1));
-
-			/**
-			 * to shift the 32b RSS hash value to the
-			 * highest 32b of each 128b before mask
-			 */
-			__m128i rss_hash3 =
-				_mm_slli_epi64(raw_desc_bh3, 32);
-			__m128i rss_hash2 =
-				_mm_slli_epi64(raw_desc_bh2, 32);
-			__m128i rss_hash1 =
-				_mm_slli_epi64(raw_desc_bh1, 32);
-			__m128i rss_hash0 =
-				_mm_slli_epi64(raw_desc_bh0, 32);
-
-			__m128i rss_hash_msk =
-				_mm_set_epi32(0xFFFFFFFF, 0, 0, 0);
-
-			rss_hash3 = _mm_and_si128
-					(rss_hash3, rss_hash_msk);
-			rss_hash2 = _mm_and_si128
-					(rss_hash2, rss_hash_msk);
-			rss_hash1 = _mm_and_si128
-					(rss_hash1, rss_hash_msk);
-			rss_hash0 = _mm_and_si128
-					(rss_hash0, rss_hash_msk);
-
-			pkt_mb3 = _mm_or_si128(pkt_mb3, rss_hash3);
-			pkt_mb2 = _mm_or_si128(pkt_mb2, rss_hash2);
-			pkt_mb1 = _mm_or_si128(pkt_mb1, rss_hash1);
-			pkt_mb0 = _mm_or_si128(pkt_mb0, rss_hash0);
-		} /* if() on RSS hash parsing */
-#endif
-
-		/* C.2 get 4 pkts staterr value  */
-		staterr = _mm_unpacklo_epi32(sterr_tmp1, sterr_tmp2);
-
-		/* D.3 copy final 3,4 data to rx_pkts */
-		_mm_storeu_si128
-			((void *)&rx_pkts[pos + 3]->rx_descriptor_fields1,
-			 pkt_mb3);
-		_mm_storeu_si128
-			((void *)&rx_pkts[pos + 2]->rx_descriptor_fields1,
-			 pkt_mb2);
-
-		/* C* extract and record EOP bit */
-		if (split_packet) {
-			/* and with mask to extract bits, flipping 1-0 */
-			__m128i eop_bits = _mm_andnot_si128(staterr, eop_check);
-			/* the staterr values are not in order, as the count
-			 * of dd bits doesn't care. However, for end of
-			 * packet tracking, we do care, so shuffle. This also
-			 * compresses the 32-bit values to 8-bit
-			 */
-			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
-			/* store the resulting 32-bit value */
-			*(int *)split_packet = _mm_cvtsi128_si32(eop_bits);
-			split_packet += ICE_VPMD_DESCS_PER_LOOP;
-		}
-
-		/* C.3 calc available number of desc */
-		staterr = _mm_and_si128(staterr, dd_check);
-		staterr = _mm_packs_epi32(staterr, zero);
-
-		/* D.3 copy final 1,2 data to rx_pkts */
-		_mm_storeu_si128
-			((void *)&rx_pkts[pos + 1]->rx_descriptor_fields1,
-			 pkt_mb1);
-		_mm_storeu_si128((void *)&rx_pkts[pos]->rx_descriptor_fields1,
-				 pkt_mb0);
-		ice_rx_desc_to_ptype_v(descs, &rx_pkts[pos], ptype_tbl);
-		/* C.4 calc available number of desc */
-		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
-		nb_pkts_recd += var;
-		if (likely(var != ICE_VPMD_DESCS_PER_LOOP))
-			break;
-	}
-
-	/* Update our internal tail pointer */
-	rxq->rx_tail = (uint16_t)(rxq->rx_tail + nb_pkts_recd);
-	rxq->rx_tail = (uint16_t)(rxq->rx_tail & (rxq->nb_rx_desc - 1));
-	rxq->rxrearm_nb = (uint16_t)(rxq->rxrearm_nb + nb_pkts_recd);
-
-	return nb_pkts_recd;
-}
-
-/**
- * Notice:
- * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
- * - nb_pkts > ICE_VPMD_RX_BURST, only scan ICE_VPMD_RX_BURST
- *   numbers of DD bits
- */
-uint16_t
-ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-		  uint16_t nb_pkts)
-{
-	return _ice_recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
-}
-
-/**
- * vPMD receive routine that reassembles single burst of 32 scattered packets
- *
- * Notice:
- * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
- */
-static uint16_t
-ice_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-			     uint16_t nb_pkts)
-{
-	struct ci_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
-
-	/* get some new buffers */
-	uint16_t nb_bufs = _ice_recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
-						  split_flags);
-	if (nb_bufs == 0)
-		return 0;
-
-	/* happy day case, full burst + no packets to be joined */
-	const uint64_t *split_fl64 = (uint64_t *)split_flags;
-
-	if (!rxq->pkt_first_seg &&
-	    split_fl64[0] == 0 && split_fl64[1] == 0 &&
-	    split_fl64[2] == 0 && split_fl64[3] == 0)
-		return nb_bufs;
-
-	/* reassemble any packets that need reassembly*/
-	unsigned int i = 0;
-
-	if (!rxq->pkt_first_seg) {
-		/* find the first split flag, and only reassemble then*/
-		while (i < nb_bufs && !split_flags[i])
-			i++;
-		if (i == nb_bufs)
-			return nb_bufs;
-		rxq->pkt_first_seg = rx_pkts[i];
-	}
-	return i + ci_rx_reassemble_packets(&rx_pkts[i], nb_bufs - i, &split_flags[i],
-			&rxq->pkt_first_seg, &rxq->pkt_last_seg, rxq->crc_len);
-}
-
-/**
- * vPMD receive routine that reassembles scattered packets.
- */
-uint16_t
-ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-			    uint16_t nb_pkts)
-{
-	uint16_t retval = 0;
-
-	while (nb_pkts > ICE_VPMD_RX_BURST) {
-		uint16_t burst;
-
-		burst = ice_recv_scattered_burst_vec(rx_queue,
-						     rx_pkts + retval,
-						     ICE_VPMD_RX_BURST);
-		retval += burst;
-		nb_pkts -= burst;
-		if (burst < ICE_VPMD_RX_BURST)
-			return retval;
-	}
-
-	return retval + ice_recv_scattered_burst_vec(rx_queue,
-						     rx_pkts + retval,
-						     nb_pkts);
-}
-
-static inline void
-ice_vtx1(volatile struct ice_tx_desc *txdp, struct rte_mbuf *pkt,
-	 uint64_t flags)
-{
-	uint64_t high_qw =
-		(ICE_TX_DESC_DTYPE_DATA |
-		 ((uint64_t)flags  << ICE_TXD_QW1_CMD_S) |
-		 ((uint64_t)pkt->data_len << ICE_TXD_QW1_TX_BUF_SZ_S));
-
-	__m128i descriptor = _mm_set_epi64x(high_qw, rte_pktmbuf_iova(pkt));
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static inline void
-ice_vtx(volatile struct ice_tx_desc *txdp, struct rte_mbuf **pkt,
-	uint16_t nb_pkts, uint64_t flags)
-{
-	int i;
-
-	for (i = 0; i < nb_pkts; ++i, ++txdp, ++pkt)
-		ice_vtx1(txdp, *pkt, flags);
-}
-
-static uint16_t
-ice_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-			 uint16_t nb_pkts)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ice_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = ICE_TD_CMD;
-	uint64_t rs = ICE_TX_DESC_CMD_RS | ICE_TD_CMD;
-	int i;
-
-	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, false);
-
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	nb_commit = nb_pkts;
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->ice_tx_ring[tx_id];
-	txep = &txq->sw_ring_vec[tx_id];
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++txdp)
-			ice_vtx1(txdp, *tx_pkts, flags);
-
-		ice_vtx1(txdp, *tx_pkts++, rs);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = &txq->ice_tx_ring[tx_id];
-		txep = &txq->sw_ring_vec[tx_id];
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	ice_vtx(txdp, tx_pkts, nb_commit, flags);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->ice_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS) <<
-					 ICE_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
-uint16_t
-ice_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-		  uint16_t nb_pkts)
-{
-	uint16_t nb_tx = 0;
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-
-	while (nb_pkts) {
-		uint16_t ret, num;
-
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
-		ret = ice_xmit_fixed_burst_vec(tx_queue, &tx_pkts[nb_tx], num);
-		nb_tx += ret;
-		nb_pkts -= ret;
-		if (ret < num)
-			break;
-	}
-
-	return nb_tx;
-}
-
-int __rte_cold
-ice_rxq_vec_setup(struct ci_rx_queue *rxq)
-{
-	if (!rxq)
-		return -1;
-
-	rxq->rx_rel_mbufs = _ice_rx_queue_release_mbufs_vec;
-	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
-	return 0;
-}
-
-int __rte_cold
-ice_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
-int __rte_cold
-ice_rx_vec_dev_check(struct rte_eth_dev *dev)
-{
-	return ice_rx_vec_dev_check_default(dev);
-}
-
-int __rte_cold
-ice_tx_vec_dev_check(struct rte_eth_dev *dev)
-{
-	return ice_tx_vec_dev_check_default(dev);
-}
-
-enum rte_vect_max_simd
-ice_get_max_simd_bitwidth(void)
-{
-	return ci_get_x86_max_simd_bitwidth();
-}
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 8a20d0f297..293577676f 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -31,7 +31,6 @@ else
 endif
 
 if arch_subdir == 'x86'
-    sources += files('ice_rxtx_vec_sse.c')
     sources_avx2 += files('ice_rxtx_vec_avx2.c')
     sources_avx512 += files('ice_rxtx_vec_avx512.c')
 endif
-- 
2.34.1

