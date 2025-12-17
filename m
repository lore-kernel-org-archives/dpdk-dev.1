Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683ED65C56
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 14:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9993A40609;
	Wed, 17 Dec 2025 15:32:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9364B4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 15:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765981957; x=1797517957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v3b8XKxZ9pP0S3SSrRFPLho2ns3OIHy9PTO728JqchA=;
 b=ZOOZn0gDEKjQIo3kmTbuiLH9kok0Oby2L8IaM7U1Q+RCZfhZA07Jh5J9
 bQYlzAHMKy7m+w5VnQe6OSECKak/nmmeW7xhZXhGVdhoXQ+rbFRG064WI
 xYTtI1ij5B3QcFu+cGReIIG3dj6ycY0xTWHml/02uijH9gdWxW8VPNJDE
 rDRibIwrnjj7PsUl/IGFn1zX8lu/4i2Z9bDVM6ZjAHWY+MV+7Ogyp8z4x
 8s36HBAAPEiawkFXjrTXTwdSJaB5he5zteh0NQAaQUcTKsztmIkgizsmC
 /utxeVoPxNOL0Ib9dMUbQfIGT6XgK4h9fhXtkWvIGCHfFg6RGgDv30WwR w==;
X-CSE-ConnectionGUID: TBwWAzSASgmM96Kozh30xw==
X-CSE-MsgGUID: mQ2Rl5hbQeSpktpcTM/x0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70495930"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="70495930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 06:32:37 -0800
X-CSE-ConnectionGUID: jdeq02S+SlueqZI1TCxHbQ==
X-CSE-MsgGUID: VfC5CmT8TTGyTo0ZrgktlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="202690327"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 06:32:36 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/5] net/i40e: remove SSE vector path
Date: Wed, 17 Dec 2025 14:32:19 +0000
Message-ID: <20251217143223.3208830-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217143223.3208830-1-ciara.loftus@intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20251217143223.3208830-1-ciara.loftus@intel.com>
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
 drivers/net/intel/i40e/i40e_ethdev.h        |   3 -
 drivers/net/intel/i40e/i40e_rxtx.c          |  72 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c |  20 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c  | 717 --------------------
 drivers/net/intel/i40e/meson.build          |   1 -
 5 files changed, 48 insertions(+), 765 deletions(-)
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 1fe504d0cd..e4a8317abd 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1231,8 +1231,6 @@ enum i40e_rx_func_type {
 	I40E_RX_DEFAULT,
 	I40E_RX_SCATTERED,
 	I40E_RX_BULK_ALLOC,
-	I40E_RX_SSE,
-	I40E_RX_SSE_SCATTERED,
 	I40E_RX_AVX2,
 	I40E_RX_AVX2_SCATTERED,
 	I40E_RX_AVX512,
@@ -1246,7 +1244,6 @@ enum i40e_rx_func_type {
 enum i40e_tx_func_type {
 	I40E_TX_DEFAULT,
 	I40E_TX_SCALAR_SIMPLE,
-	I40E_TX_SSE,
 	I40E_TX_AVX2,
 	I40E_TX_AVX512,
 	I40E_TX_NEON,
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2db58c6b24..5665685d48 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -31,6 +31,10 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 
+#ifdef RTE_ARCH_X86
+#include "../common/rx_vec_x86.h"
+#endif
+
 #define DEFAULT_TX_RS_THRESH   32
 #define DEFAULT_TX_FREE_THRESH 32
 
@@ -1527,6 +1531,7 @@ i40e_xmit_pkts_simple(void *tx_queue,
 	return nb_tx;
 }
 
+#ifndef RTE_ARCH_X86
 static uint16_t
 i40e_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 		   uint16_t nb_pkts)
@@ -1549,6 +1554,7 @@ i40e_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_tx;
 }
+#endif
 
 static const struct ci_tx_path_info i40e_tx_path_infos[] = {
 	[I40E_TX_DEFAULT] = {
@@ -1569,15 +1575,6 @@ static const struct ci_tx_path_info i40e_tx_path_infos[] = {
 		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #ifdef RTE_ARCH_X86
-	[I40E_TX_SSE] = {
-		.pkt_burst = i40e_xmit_pkts_vec,
-		.info = "Vector SSE",
-		.features = {
-			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_128,
-		},
-		.pkt_prep = i40e_simple_prep_pkts,
-	},
 	[I40E_TX_AVX2] = {
 		.pkt_burst = i40e_xmit_pkts_vec_avx2,
 		.info = "Vector AVX2",
@@ -2019,6 +2016,8 @@ i40e_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 const uint32_t *
 i40e_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 {
+	const struct i40e_adapter *ad = I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
 	static const uint32_t ptypes[] = {
 		/* refers to i40e_rxd_pkt_type_mapping() */
 		RTE_PTYPE_L2_ETHER,
@@ -2047,19 +2046,17 @@ i40e_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		RTE_PTYPE_INNER_L4_UDP,
 	};
 
-	if (dev->rx_pkt_burst == i40e_recv_pkts ||
-#ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-	    dev->rx_pkt_burst == i40e_recv_pkts_bulk_alloc ||
-#endif
-	    dev->rx_pkt_burst == i40e_recv_scattered_pkts ||
-	    dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec ||
-	    dev->rx_pkt_burst == i40e_recv_pkts_vec ||
-#ifdef CC_AVX512_SUPPORT
-	    dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec_avx512 ||
-	    dev->rx_pkt_burst == i40e_recv_pkts_vec_avx512 ||
-#endif
-	    dev->rx_pkt_burst == i40e_recv_scattered_pkts_vec_avx2 ||
-	    dev->rx_pkt_burst == i40e_recv_pkts_vec_avx2) {
+	if (ad->rx_func_type == I40E_RX_DEFAULT ||
+	    ad->rx_func_type == I40E_RX_BULK_ALLOC ||
+	    ad->rx_func_type == I40E_RX_SCATTERED ||
+	    ad->rx_func_type == I40E_RX_NEON_SCATTERED ||
+	    ad->rx_func_type == I40E_RX_NEON ||
+	    ad->rx_func_type == I40E_RX_ALTIVEC_SCATTERED ||
+	    ad->rx_func_type == I40E_RX_ALTIVEC ||
+	    ad->rx_func_type == I40E_RX_AVX512_SCATTERED ||
+	    ad->rx_func_type == I40E_RX_AVX512 ||
+	    ad->rx_func_type == I40E_RX_AVX2_SCATTERED ||
+	    ad->rx_func_type == I40E_RX_AVX2) {
 		*no_of_elements = RTE_DIM(ptypes);
 		return ptypes;
 	}
@@ -2708,7 +2705,7 @@ i40e_rx_queue_release_mbufs(struct ci_rx_queue *rxq)
 {
 	uint16_t i;
 
-	/* SSE Vector driver has a different way of releasing mbufs. */
+	/* Vector driver has a different way of releasing mbufs. */
 	if (rxq->vector_rx) {
 		i40e_rx_queue_release_mbufs_vec(rxq);
 		return;
@@ -3385,25 +3382,6 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		}
 	},
 #ifdef RTE_ARCH_X86
-	[I40E_RX_SSE] = {
-		.pkt_burst = i40e_recv_pkts_vec,
-		.info = "Vector SSE",
-		.features = {
-			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_128,
-			.bulk_alloc = true
-		}
-	},
-	[I40E_RX_SSE_SCATTERED] = {
-		.pkt_burst = i40e_recv_scattered_pkts_vec,
-		.info = "Vector SSE Scattered",
-		.features = {
-			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_128,
-			.scattered = true,
-			.bulk_alloc = true
-		}
-	},
 	[I40E_RX_AVX2] = {
 		.pkt_burst = i40e_recv_pkts_vec_avx2,
 		.info = "Vector AVX2",
@@ -3626,7 +3604,6 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
-			ad->tx_func_type == I40E_TX_SSE ||
 			ad->tx_func_type == I40E_TX_NEON ||
 			ad->tx_func_type == I40E_TX_ALTIVEC ||
 			ad->tx_func_type == I40E_TX_AVX2)
@@ -3725,7 +3702,14 @@ i40e_set_default_pctype_table(struct rte_eth_dev *dev)
 	}
 }
 
-#ifndef RTE_ARCH_X86
+#ifdef RTE_ARCH_X86
+enum rte_vect_max_simd
+i40e_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
+
+#else
 uint16_t
 i40e_recv_pkts_vec_avx2(void __rte_unused *rx_queue,
 			struct rte_mbuf __rte_unused **rx_pkts,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index aeb2756e7a..4e398b3140 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -820,3 +820,23 @@ i40e_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_tx;
 }
+
+void __rte_cold
+i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
+{
+	_i40e_rx_queue_release_mbufs_vec(rxq);
+}
+
+int __rte_cold
+i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
+{
+	rxq->vector_rx = 1;
+	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
+	return 0;
+}
+
+int __rte_cold
+i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
+{
+	return i40e_rx_vec_dev_conf_condition_check_default(dev);
+}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
deleted file mode 100644
index c209135890..0000000000
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ /dev/null
@@ -1,717 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2015 Intel Corporation
- */
-
-#include <stdint.h>
-#include <ethdev_driver.h>
-#include <rte_malloc.h>
-
-#include "base/i40e_prototype.h"
-#include "base/i40e_type.h"
-#include "i40e_ethdev.h"
-#include "i40e_rxtx.h"
-#include "i40e_rxtx_vec_common.h"
-
-#include "../common/rx_vec_x86.h"
-
-#include <rte_vect.h>
-
-static inline void
-i40e_rxq_rearm(struct ci_rx_queue *rxq)
-{
-	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
-}
-
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-/* SSE version of FDIR mark extraction for 4 32B descriptors at a time */
-static inline __m128i
-descs_to_fdir_32b(volatile union ci_rx_desc *rxdp, struct rte_mbuf **rx_pkt)
-{
-	/* 32B descriptors: Load 2nd half of descriptors for FDIR ID data */
-	__m128i desc0_qw23, desc1_qw23, desc2_qw23, desc3_qw23;
-	desc0_qw23 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, &(rxdp + 0)->wb.qword2));
-	desc1_qw23 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, &(rxdp + 1)->wb.qword2));
-	desc2_qw23 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, &(rxdp + 2)->wb.qword2));
-	desc3_qw23 = _mm_loadu_si128(RTE_CAST_PTR(const __m128i *, &(rxdp + 3)->wb.qword2));
-
-	/* FDIR ID data: move last u32 of each desc to 4 u32 lanes */
-	__m128i v_unpack_01, v_unpack_23;
-	v_unpack_01 = _mm_unpackhi_epi32(desc0_qw23, desc1_qw23);
-	v_unpack_23 = _mm_unpackhi_epi32(desc2_qw23, desc3_qw23);
-	__m128i v_fdir_ids = _mm_unpackhi_epi64(v_unpack_01, v_unpack_23);
-
-	/* Extended Status: extract from each lower 32 bits, to u32 lanes */
-	v_unpack_01 = _mm_unpacklo_epi32(desc0_qw23, desc1_qw23);
-	v_unpack_23 = _mm_unpacklo_epi32(desc2_qw23, desc3_qw23);
-	__m128i v_flt_status = _mm_unpacklo_epi64(v_unpack_01, v_unpack_23);
-
-	/* Shift u32 left and right to "mask away" bits not required.
-	 * Data required is 4:5 (zero based), so left shift by 26 (32-6)
-	 * and then right shift by 30 (32 - 2 bits required).
-	 */
-	v_flt_status = _mm_slli_epi32(v_flt_status, 26);
-	v_flt_status = _mm_srli_epi32(v_flt_status, 30);
-
-	/* Generate constant 1 in all u32 lanes and compare */
-	RTE_BUILD_BUG_ON(I40E_RX_DESC_EXT_STATUS_FLEXBH_FD_ID != 1);
-	__m128i v_zeros = _mm_setzero_si128();
-	__m128i v_ffff = _mm_cmpeq_epi32(v_zeros, v_zeros);
-	__m128i v_u32_one = _mm_srli_epi32(v_ffff, 31);
-
-	/* per desc mask, bits set if FDIR ID is valid */
-	__m128i v_fd_id_mask = _mm_cmpeq_epi32(v_flt_status, v_u32_one);
-
-	/* Mask ID data to zero if the FD_ID bit not set in desc */
-	v_fdir_ids = _mm_and_si128(v_fdir_ids, v_fd_id_mask);
-
-	/* Extract and store as u32. No advantage to combining into SSE
-	 * stores, there are no surrounding stores to around fdir.hi
-	 */
-	rx_pkt[0]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 0);
-	rx_pkt[1]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 1);
-	rx_pkt[2]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 2);
-	rx_pkt[3]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 3);
-
-	/* convert fdir_id_mask into a single bit, then shift as required for
-	 * correct location in the mbuf->olflags
-	 */
-	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR_ID != (1 << I40E_FDIR_ID_BIT_SHIFT));
-	v_fd_id_mask = _mm_srli_epi32(v_fd_id_mask, 31);
-	v_fd_id_mask = _mm_slli_epi32(v_fd_id_mask, I40E_FDIR_ID_BIT_SHIFT);
-
-	/* The returned value must be combined into each mbuf. This is already
-	 * being done for RSS and VLAN mbuf olflags, so return bits to OR in.
-	 */
-	return v_fd_id_mask;
-}
-
-#else /* 32 or 16B FDIR ID handling */
-
-/* Handle 16B descriptor FDIR ID flag setting based on FLM. See scalar driver
- * for scalar implementation of the same functionality.
- */
-static inline __m128i
-descs_to_fdir_16b(__m128i fltstat, __m128i descs[4], struct rte_mbuf **rx_pkt)
-{
-	/* unpack filter-status data from descriptors */
-	__m128i v_tmp_01 = _mm_unpacklo_epi32(descs[0], descs[1]);
-	__m128i v_tmp_23 = _mm_unpacklo_epi32(descs[2], descs[3]);
-	__m128i v_fdir_ids = _mm_unpackhi_epi64(v_tmp_01, v_tmp_23);
-
-	/* Generate one bit in each u32 lane */
-	__m128i v_zeros = _mm_setzero_si128();
-	__m128i v_ffff = _mm_cmpeq_epi32(v_zeros, v_zeros);
-	__m128i v_111_mask = _mm_srli_epi32(v_ffff, 29);
-	__m128i v_11_mask = _mm_srli_epi32(v_ffff, 30);
-
-	/* Top lane ones mask for FDIR isolation */
-	__m128i v_desc_fdir_mask = _mm_insert_epi32(v_zeros, UINT32_MAX, 1);
-
-	/* Compare and mask away FDIR ID data if bit not set */
-	__m128i v_u32_bits = _mm_and_si128(v_111_mask, fltstat);
-	__m128i v_fdir_id_mask = _mm_cmpeq_epi32(v_u32_bits, v_11_mask);
-	v_fdir_ids = _mm_and_si128(v_fdir_id_mask, v_fdir_ids);
-
-	/* Store data to fdir.hi in mbuf */
-	rx_pkt[0]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 0);
-	rx_pkt[1]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 1);
-	rx_pkt[2]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 2);
-	rx_pkt[3]->hash.fdir.hi = _mm_extract_epi32(v_fdir_ids, 3);
-
-	/* Move fdir_id_mask to correct lane, blend RSS to zero on hits */
-	__m128i v_desc3_shift = _mm_alignr_epi8(v_zeros, v_fdir_id_mask, 8);
-	__m128i v_desc3_mask = _mm_and_si128(v_desc_fdir_mask, v_desc3_shift);
-	descs[3] = _mm_blendv_epi8(descs[3], _mm_setzero_si128(), v_desc3_mask);
-
-	__m128i v_desc2_shift = _mm_alignr_epi8(v_zeros, v_fdir_id_mask, 4);
-	__m128i v_desc2_mask = _mm_and_si128(v_desc_fdir_mask, v_desc2_shift);
-	descs[2] = _mm_blendv_epi8(descs[2], _mm_setzero_si128(), v_desc2_mask);
-
-	__m128i v_desc1_shift = v_fdir_id_mask;
-	__m128i v_desc1_mask = _mm_and_si128(v_desc_fdir_mask, v_desc1_shift);
-	descs[1] = _mm_blendv_epi8(descs[1], _mm_setzero_si128(), v_desc1_mask);
-
-	__m128i v_desc0_shift = _mm_alignr_epi8(v_fdir_id_mask, v_zeros, 12);
-	__m128i v_desc0_mask = _mm_and_si128(v_desc_fdir_mask, v_desc0_shift);
-	descs[0] = _mm_blendv_epi8(descs[0], _mm_setzero_si128(), v_desc0_mask);
-
-	/* Shift to 1 or 0 bit per u32 lane, then to RTE_MBUF_F_RX_FDIR_ID offset */
-	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR_ID != (1 << I40E_FDIR_ID_BIT_SHIFT));
-	__m128i v_mask_one_bit = _mm_srli_epi32(v_fdir_id_mask, 31);
-	return _mm_slli_epi32(v_mask_one_bit, I40E_FDIR_ID_BIT_SHIFT);
-}
-#endif
-
-static inline void
-desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
-		  __m128i descs[4], struct rte_mbuf **rx_pkts)
-{
-	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
-	__m128i rearm0, rearm1, rearm2, rearm3;
-
-	__m128i vlan0, vlan1, rss, l3_l4e;
-
-	/* mask everything except RSS, flow director and VLAN flags
-	 * bit2 is for VLAN tag, bit11 for flow director indication
-	 * bit13:12 for RSS indication.
-	 */
-	const __m128i rss_vlan_msk = _mm_set_epi32(
-			0x1c03804, 0x1c03804, 0x1c03804, 0x1c03804);
-
-	const __m128i cksum_mask = _mm_set_epi32(
-			RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD |
-			RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-			RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-			RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD |
-			RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-			RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-			RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD |
-			RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-			RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
-			RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD |
-			RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD |
-			RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD);
-
-	/* map rss and vlan type to rss hash and vlan flag */
-	const __m128i vlan_flags = _mm_set_epi8(0, 0, 0, 0,
-			0, 0, 0, 0,
-			0, 0, 0, RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
-			0, 0, 0, 0);
-
-	const __m128i rss_flags = _mm_set_epi8(0, 0, 0, 0,
-			0, 0, 0, 0,
-			RTE_MBUF_F_RX_RSS_HASH | RTE_MBUF_F_RX_FDIR, RTE_MBUF_F_RX_RSS_HASH, 0, 0,
-			0, 0, RTE_MBUF_F_RX_FDIR, 0);
-
-	const __m128i l3_l4e_flags = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0,
-			/* shift right 1 bit to make sure it not exceed 255 */
-			(RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
-			 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-			(RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD  |
-			 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-			(RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-			 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-			(RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
-			 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-			(RTE_MBUF_F_RX_L4_CKSUM_BAD  | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-			(RTE_MBUF_F_RX_L4_CKSUM_BAD  | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
-			(RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
-			(RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1);
-
-	/* Unpack "status" from quadword 1, bits 0:32 */
-	vlan0 = _mm_unpackhi_epi32(descs[0], descs[1]);
-	vlan1 = _mm_unpackhi_epi32(descs[2], descs[3]);
-	vlan0 = _mm_unpacklo_epi64(vlan0, vlan1);
-
-	vlan1 = _mm_and_si128(vlan0, rss_vlan_msk);
-	vlan0 = _mm_shuffle_epi8(vlan_flags, vlan1);
-
-	const __m128i desc_fltstat = _mm_srli_epi32(vlan1, 11);
-	rss = _mm_shuffle_epi8(rss_flags, desc_fltstat);
-
-	l3_l4e = _mm_srli_epi32(vlan1, 22);
-	l3_l4e = _mm_shuffle_epi8(l3_l4e_flags, l3_l4e);
-	/* then we shift left 1 bit */
-	l3_l4e = _mm_slli_epi32(l3_l4e, 1);
-	/* we need to mask out the redundant bits */
-	l3_l4e = _mm_and_si128(l3_l4e, cksum_mask);
-
-	vlan0 = _mm_or_si128(vlan0, rss);
-	vlan0 = _mm_or_si128(vlan0, l3_l4e);
-
-	/* Extract FDIR ID only if FDIR is enabled to avoid useless work */
-	if (rxq->fdir_enabled) {
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-		__m128i v_fdir_ol_flags = descs_to_fdir_32b(rxdp, rx_pkts);
-#else
-		(void)rxdp; /* rxdp not required for 16B desc mode */
-		__m128i v_fdir_ol_flags = descs_to_fdir_16b(desc_fltstat,
-							    descs, rx_pkts);
-#endif
-		/* OR in ol_flag bits after descriptor specific extraction */
-		vlan0 = _mm_or_si128(vlan0, v_fdir_ol_flags);
-	}
-
-	/*
-	 * At this point, we have the 4 sets of flags in the low 16-bits
-	 * of each 32-bit value in vlan0.
-	 * We want to extract these, and merge them with the mbuf init data
-	 * so we can do a single 16-byte write to the mbuf to set the flags
-	 * and all the other initialization fields. Extracting the
-	 * appropriate flags means that we have to do a shift and blend for
-	 * each mbuf before we do the write.
-	 */
-	rearm0 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vlan0, 8), 0x10);
-	rearm1 = _mm_blend_epi16(mbuf_init, _mm_slli_si128(vlan0, 4), 0x10);
-	rearm2 = _mm_blend_epi16(mbuf_init, vlan0, 0x10);
-	rearm3 = _mm_blend_epi16(mbuf_init, _mm_srli_si128(vlan0, 4), 0x10);
-
-	/* write the rearm data and the olflags in one write */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
-			offsetof(struct rte_mbuf, rearm_data) + 8);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
-			RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
-	_mm_store_si128((__m128i *)&rx_pkts[0]->rearm_data, rearm0);
-	_mm_store_si128((__m128i *)&rx_pkts[1]->rearm_data, rearm1);
-	_mm_store_si128((__m128i *)&rx_pkts[2]->rearm_data, rearm2);
-	_mm_store_si128((__m128i *)&rx_pkts[3]->rearm_data, rearm3);
-}
-
-#define PKTLEN_SHIFT     10
-
-static inline void
-desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
-		uint32_t *ptype_tbl)
-{
-	__m128i ptype0 = _mm_unpackhi_epi64(descs[0], descs[1]);
-	__m128i ptype1 = _mm_unpackhi_epi64(descs[2], descs[3]);
-
-	ptype0 = _mm_srli_epi64(ptype0, 30);
-	ptype1 = _mm_srli_epi64(ptype1, 30);
-
-	rx_pkts[0]->packet_type = ptype_tbl[_mm_extract_epi8(ptype0, 0)];
-	rx_pkts[1]->packet_type = ptype_tbl[_mm_extract_epi8(ptype0, 8)];
-	rx_pkts[2]->packet_type = ptype_tbl[_mm_extract_epi8(ptype1, 0)];
-	rx_pkts[3]->packet_type = ptype_tbl[_mm_extract_epi8(ptype1, 8)];
-}
-
-/**
- * vPMD raw receive routine, only accept(nb_pkts >= I40E_VPMD_DESCS_PER_LOOP)
- *
- * Notice:
- * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
- */
-static inline uint16_t
-_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
-		   uint16_t nb_pkts, uint8_t *split_packet)
-{
-	volatile union ci_rx_desc *rxdp;
-	struct ci_rx_entry *sw_ring;
-	uint16_t nb_pkts_recd;
-	int pos;
-	uint64_t var;
-	__m128i shuf_msk;
-	uint32_t *ptype_tbl = rxq->i40e_vsi->adapter->ptype_tbl;
-
-	__m128i crc_adjust = _mm_set_epi16(
-				0, 0, 0,    /* ignore non-length fields */
-				-rxq->crc_len, /* sub crc on data_len */
-				0,          /* ignore high-16bits of pkt_len */
-				-rxq->crc_len, /* sub crc on pkt_len */
-				0, 0            /* ignore pkt_type field */
-			);
-	/*
-	 * compile-time check the above crc_adjust layout is correct.
-	 * NOTE: the first field (lowest address) is given last in set_epi16
-	 * call above.
-	 */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
-	__m128i dd_check, eop_check;
-
-	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP);
-
-	/* Just the act of getting into the function from the application is
-	 * going to cost about 7 cycles
-	 */
-	rxdp = rxq->rx_ring + rxq->rx_tail;
-
-	rte_prefetch0(rxdp);
-
-	/* See if we need to rearm the RX queue - gives the prefetch a bit
-	 * of time to act
-	 */
-	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
-		i40e_rxq_rearm(rxq);
-
-	/* Before we start moving massive data around, check to see if
-	 * there is actually a packet available
-	 */
-	if (!(rxdp->wb.qword1.status_error_len &
-			rte_cpu_to_le_32(1 << I40E_RX_DESC_STATUS_DD_SHIFT)))
-		return 0;
-
-	/* 4 packets DD mask */
-	dd_check = _mm_set_epi64x(0x0000000100000001LL, 0x0000000100000001LL);
-
-	/* 4 packets EOP mask */
-	eop_check = _mm_set_epi64x(0x0000000200000002LL, 0x0000000200000002LL);
-
-	/* mask to shuffle from desc. to mbuf */
-	shuf_msk = _mm_set_epi8(
-		7, 6, 5, 4,  /* octet 4~7, 32bits rss */
-		3, 2,        /* octet 2~3, low 16 bits vlan_macip */
-		15, 14,      /* octet 15~14, 16 bits data_len */
-		0xFF, 0xFF,  /* skip high 16 bits pkt_len, zero out */
-		15, 14,      /* octet 15~14, low 16 bits pkt_len */
-		0xFF, 0xFF,  /* pkt_type set as unknown */
-		0xFF, 0xFF  /*pkt_type set as unknown */
-		);
-	/*
-	 * Compile-time verify the shuffle mask
-	 * NOTE: some field positions already verified above, but duplicated
-	 * here for completeness in case of future modifications.
-	 */
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
-	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
-			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
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
-			pos += I40E_VPMD_DESCS_PER_LOOP,
-			rxdp += I40E_VPMD_DESCS_PER_LOOP) {
-		__m128i descs[I40E_VPMD_DESCS_PER_LOOP];
-		__m128i pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
-		__m128i zero, staterr, sterr_tmp1, sterr_tmp2;
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
-		mbp2 = _mm_loadu_si128((__m128i *)&sw_ring[pos+2]);
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
-		_mm_storeu_si128((__m128i *)&rx_pkts[pos+2], mbp2);
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
-		/* pkt 3,4 shift the pktlen field to be 16-bit aligned*/
-		const __m128i len3 = _mm_slli_epi32(descs[3], PKTLEN_SHIFT);
-		const __m128i len2 = _mm_slli_epi32(descs[2], PKTLEN_SHIFT);
-
-		/* merge the now-aligned packet length fields back in */
-		descs[3] = _mm_blend_epi16(descs[3], len3, 0x80);
-		descs[2] = _mm_blend_epi16(descs[2], len2, 0x80);
-
-		/* C.1 4=>2 filter staterr info only */
-		sterr_tmp2 = _mm_unpackhi_epi32(descs[3], descs[2]);
-		/* C.1 4=>2 filter staterr info only */
-		sterr_tmp1 = _mm_unpackhi_epi32(descs[1], descs[0]);
-
-		desc_to_olflags_v(rxq, rxdp, descs, &rx_pkts[pos]);
-
-		/* D.1 pkt 3,4 convert format from desc to pktmbuf */
-		pkt_mb4 = _mm_shuffle_epi8(descs[3], shuf_msk);
-		pkt_mb3 = _mm_shuffle_epi8(descs[2], shuf_msk);
-
-		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
-		pkt_mb4 = _mm_add_epi16(pkt_mb4, crc_adjust);
-		pkt_mb3 = _mm_add_epi16(pkt_mb3, crc_adjust);
-
-		/* pkt 1,2 shift the pktlen field to be 16-bit aligned*/
-		const __m128i len1 = _mm_slli_epi32(descs[1], PKTLEN_SHIFT);
-		const __m128i len0 = _mm_slli_epi32(descs[0], PKTLEN_SHIFT);
-
-		/* merge the now-aligned packet length fields back in */
-		descs[1] = _mm_blend_epi16(descs[1], len1, 0x80);
-		descs[0] = _mm_blend_epi16(descs[0], len0, 0x80);
-
-		/* D.1 pkt 1,2 convert format from desc to pktmbuf */
-		pkt_mb2 = _mm_shuffle_epi8(descs[1], shuf_msk);
-		pkt_mb1 = _mm_shuffle_epi8(descs[0], shuf_msk);
-
-		/* C.2 get 4 pkts staterr value  */
-		zero = _mm_xor_si128(dd_check, dd_check);
-		staterr = _mm_unpacklo_epi32(sterr_tmp1, sterr_tmp2);
-
-		/* D.3 copy final 3,4 data to rx_pkts */
-		_mm_storeu_si128((void *)&rx_pkts[pos+3]->rx_descriptor_fields1,
-				 pkt_mb4);
-		_mm_storeu_si128((void *)&rx_pkts[pos+2]->rx_descriptor_fields1,
-				 pkt_mb3);
-
-		/* D.2 pkt 1,2 set in_port/nb_seg and remove crc */
-		pkt_mb2 = _mm_add_epi16(pkt_mb2, crc_adjust);
-		pkt_mb1 = _mm_add_epi16(pkt_mb1, crc_adjust);
-
-		/* C* extract and record EOP bit */
-		if (split_packet) {
-			__m128i eop_shuf_mask = _mm_set_epi8(
-					0xFF, 0xFF, 0xFF, 0xFF,
-					0xFF, 0xFF, 0xFF, 0xFF,
-					0xFF, 0xFF, 0xFF, 0xFF,
-					0x04, 0x0C, 0x00, 0x08
-					);
-
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
-			split_packet += I40E_VPMD_DESCS_PER_LOOP;
-		}
-
-		/* C.3 calc available number of desc */
-		staterr = _mm_and_si128(staterr, dd_check);
-		staterr = _mm_packs_epi32(staterr, zero);
-
-		/* D.3 copy final 1,2 data to rx_pkts */
-		_mm_storeu_si128((void *)&rx_pkts[pos+1]->rx_descriptor_fields1,
-				 pkt_mb2);
-		_mm_storeu_si128((void *)&rx_pkts[pos]->rx_descriptor_fields1,
-				 pkt_mb1);
-		desc_to_ptype_v(descs, &rx_pkts[pos], ptype_tbl);
-		/* C.4 calc available number of desc */
-		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
-		nb_pkts_recd += var;
-		if (likely(var != I40E_VPMD_DESCS_PER_LOOP))
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
- /*
- * Notice:
- * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
- */
-uint16_t
-i40e_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-		   uint16_t nb_pkts)
-{
-	return _recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
-}
-
-/**
- * vPMD receive routine that reassembles single burst of 32 scattered packets
- *
- * Notice:
- * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
- */
-static uint16_t
-i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-			      uint16_t nb_pkts)
-{
-
-	struct ci_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
-
-	/* get some new buffers */
-	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
-			split_flags);
-	if (nb_bufs == 0)
-		return 0;
-
-	/* happy day case, full burst + no packets to be joined */
-	const uint64_t *split_fl64 = (uint64_t *)split_flags;
-
-	if (rxq->pkt_first_seg == NULL &&
-			split_fl64[0] == 0 && split_fl64[1] == 0 &&
-			split_fl64[2] == 0 && split_fl64[3] == 0)
-		return nb_bufs;
-
-	/* reassemble any packets that need reassembly*/
-	unsigned i = 0;
-
-	if (rxq->pkt_first_seg == NULL) {
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
-i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-			     uint16_t nb_pkts)
-{
-	uint16_t retval = 0;
-
-	while (nb_pkts > I40E_VPMD_RX_BURST) {
-		uint16_t burst;
-
-		burst = i40e_recv_scattered_burst_vec(rx_queue,
-						      rx_pkts + retval,
-						      I40E_VPMD_RX_BURST);
-		retval += burst;
-		nb_pkts -= burst;
-		if (burst < I40E_VPMD_RX_BURST)
-			return retval;
-	}
-
-	return retval + i40e_recv_scattered_burst_vec(rx_queue,
-						      rx_pkts + retval,
-						      nb_pkts);
-}
-
-static inline void
-vtx1(volatile struct i40e_tx_desc *txdp,
-		struct rte_mbuf *pkt, uint64_t flags)
-{
-	uint64_t high_qw = (I40E_TX_DESC_DTYPE_DATA |
-			((uint64_t)flags  << I40E_TXD_QW1_CMD_SHIFT) |
-			((uint64_t)pkt->data_len << I40E_TXD_QW1_TX_BUF_SZ_SHIFT));
-
-	__m128i descriptor = _mm_set_epi64x(high_qw,
-				pkt->buf_iova + pkt->data_off);
-	_mm_store_si128(RTE_CAST_PTR(__m128i *, txdp), descriptor);
-}
-
-static inline void
-vtx(volatile struct i40e_tx_desc *txdp,
-		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags)
-{
-	int i;
-
-	for (i = 0; i < nb_pkts; ++i, ++txdp, ++pkt)
-		vtx1(txdp, *pkt, flags);
-}
-
-uint16_t
-i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
-			  uint16_t nb_pkts)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct i40e_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
-	uint64_t flags = I40E_TD_CMD;
-	uint64_t rs = I40E_TX_DESC_CMD_RS | I40E_TD_CMD;
-	int i;
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, i40e_tx_desc_done, false);
-
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	tx_id = txq->tx_tail;
-	txdp = &txq->i40e_tx_ring[tx_id];
-	txep = &txq->sw_ring_vec[tx_id];
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-	if (nb_commit >= n) {
-		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
-
-		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++txdp)
-			vtx1(txdp, *tx_pkts, flags);
-
-		vtx1(txdp, *tx_pkts++, rs);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		tx_id = 0;
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-
-		/* avoid reach the end of ring */
-		txdp = &txq->i40e_tx_ring[tx_id];
-		txep = &txq->sw_ring_vec[tx_id];
-	}
-
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
-
-	vtx(txdp, tx_pkts, nb_commit, flags);
-
-	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->tx_next_rs) {
-		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
-						I40E_TXD_QW1_CMD_SHIFT);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	I40E_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-
-	return nb_pkts;
-}
-
-void __rte_cold
-i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
-{
-	_i40e_rx_queue_release_mbufs_vec(rxq);
-}
-
-int __rte_cold
-i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
-{
-	rxq->vector_rx = 1;
-	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
-	return 0;
-}
-
-int __rte_cold
-i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
-{
-	return i40e_rx_vec_dev_conf_condition_check_default(dev);
-}
-
-enum rte_vect_max_simd
-i40e_get_max_simd_bitwidth(void)
-{
-	return ci_get_x86_max_simd_bitwidth();
-}
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 49e7f899e6..bccae1ffc1 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -37,7 +37,6 @@ testpmd_sources = files('i40e_testpmd.c')
 deps += ['hash']
 
 if arch_subdir == 'x86'
-    sources += files('i40e_rxtx_vec_sse.c')
     sources_avx2 += files('i40e_rxtx_vec_avx2.c')
     sources_avx512 += files('i40e_rxtx_vec_avx512.c')
 elif arch_subdir == 'ppc'
-- 
2.43.0

