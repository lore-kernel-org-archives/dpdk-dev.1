Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EFC61CE7
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CC2F40B9C;
	Fri,  6 Jun 2025 19:16:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0A62E40B9C
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749230203; x=1780766203;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lKQRtHxitU4S3gpwapDJvXLKpDpxSKNH7s6XXQm0gwA=;
 b=HhRyxCEccUxRtKAXSdHF+W6Tn2C9Hm/7SoesbuWMSSrkeOi9lj0Yqt3n
 ffMt31cJVj5M066d9AMSlX91GJhaP5YG86ilav0GNwbwlEiqYXiB8BsMN
 YKjrvsExgPCC+A3ZmmZpvkvB65X/l6V0R1aZB9LL2N79TRI8XrzciIyZG
 1C+dWz70lcuSE8fPm1pN6ldrD3drpW3NP8ZXryihm4JMbzVMrvkCowMvR
 pfSV097XwQZ67rFy23vnW8w5vaMg2h8FUkcnQhGuLMJZmeo7yzSwxtVXz
 mBunBpYELxrrk6si2FjHBj+PLF36dVE8uaUPkx+t9sQbR74gKNeXZKdn/ Q==;
X-CSE-ConnectionGUID: n0bP1c/CS26HA8FnKQBR9Q==
X-CSE-MsgGUID: 8wlCZKgiQuyksm+ONrkWig==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="50499222"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="50499222"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:16:42 -0700
X-CSE-ConnectionGUID: RSwGlraPQwGWOenXV44zmw==
X-CSE-MsgGUID: XH/yV/jJRoeZ1lqsRxQOwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="176760251"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 06 Jun 2025 10:16:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 28/34] net/intel: generalize vectorized Rx rearm
Date: Fri,  6 Jun 2025 18:16:39 +0100
Message-ID: <b90967306cef692cc27ff729a4aecce687e425c3.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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

There is certain amount of duplication between various drivers when it
comes to Rx ring rearm. This patch takes implementation from ice driver
as a base because it has support for no IOVA in mbuf as well as all
vector implementations, and moves them to a common file.

While we're at it, also make sure to use common definitions for things like
burst size, rearm threshold, and descriptors per loop, which is currently
defined separately in each driver.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/rx.h               |   4 +
 drivers/net/intel/common/rx_vec_x86.h       | 315 ++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h            |  12 +-
 drivers/net/intel/ice/ice_rxtx_common_avx.h | 233 ---------------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   5 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c |   5 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  77 +----
 7 files changed, 334 insertions(+), 317 deletions(-)
 create mode 100644 drivers/net/intel/common/rx_vec_x86.h
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 3e3fea76a7..b9ba2dcc98 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -15,6 +15,10 @@
 
 #define CI_RX_MAX_BURST 32
 #define CI_RX_MAX_NSEG 2
+#define CI_VPMD_RX_BURST            32
+#define CI_VPMD_DESCS_PER_LOOP      4
+#define CI_VPMD_DESCS_PER_LOOP_WIDE 8
+#define CI_VPMD_RX_REARM_THRESH     CI_VPMD_RX_BURST
 
 struct ci_rx_queue;
 
diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
new file mode 100644
index 0000000000..4ad8066630
--- /dev/null
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -0,0 +1,315 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_RX_VEC_X86_H_
+#define _COMMON_INTEL_RX_VEC_X86_H_
+
+#include <stdint.h>
+
+#include <ethdev_driver.h>
+#include <rte_io.h>
+
+#include "rx.h"
+
+enum ci_rx_vec_level {
+	CI_RX_VEC_LEVEL_SSE = 0,
+	CI_RX_VEC_LEVEL_AVX2,
+	CI_RX_VEC_LEVEL_AVX512,
+};
+
+static inline int
+_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	if (rte_mempool_get_bulk(rxq->mp, (void **)rxp, rearm_thresh) < 0) {
+		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
+			const __m128i zero = _mm_setzero_si128();
+
+			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i].mbuf = &rxq->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]), zero);
+			}
+		}
+		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed += rearm_thresh;
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * SSE code path can handle both 16-byte and 32-byte descriptors with one code
+ * path, as we only ever write 16 bytes at a time.
+ */
+static __rte_always_inline void
+_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
+{
+	const __m128i hdroom = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
+	const __m128i zero = _mm_setzero_si128();
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp += 2) {
+		struct rte_mbuf *mb0 = rxp[0].mbuf;
+		struct rte_mbuf *mb1 = rxp[1].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		__m128i addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		__m128i addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+
+		/* add headroom to address values */
+		addr0 = _mm_add_epi64(addr0, hdroom);
+		addr1 = _mm_add_epi64(addr1, hdroom);
+
+#if RTE_IOVA_IN_MBUF
+		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
+		addr0 = _mm_unpackhi_epi64(addr0, zero);
+		addr0 = _mm_unpackhi_epi64(addr1, zero);
+#else
+		/* erase Header Buffer Address */
+		addr0 = _mm_unpacklo_epi64(addr0, zero);
+		addr1 = _mm_unpacklo_epi64(addr1, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[1]), addr1);
+	}
+}
+
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
+#ifdef __AVX2__
+/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
+static __rte_always_inline void
+_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	const __m256i hdroom = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
+	const __m256i zero = _mm256_setzero_si256();
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp += 4) {
+		struct rte_mbuf *mb0 = rxp[0].mbuf;
+		struct rte_mbuf *mb1 = rxp[1].mbuf;
+		struct rte_mbuf *mb2 = rxp[2].mbuf;
+		struct rte_mbuf *mb3 = rxp[3].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
+		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+
+		/**
+		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
+		 * into the high lanes. Similarly for 2 & 3
+		 */
+		const __m256i vaddr0_256 = _mm256_castsi128_si256(vaddr0);
+		const __m256i vaddr2_256 = _mm256_castsi128_si256(vaddr2);
+
+		__m256i addr0_1 = _mm256_inserti128_si256(vaddr0_256, vaddr1, 1);
+		__m256i addr2_3 = _mm256_inserti128_si256(vaddr2_256, vaddr3, 1);
+
+		/* add headroom to address values */
+		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
+		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
+
+#if RTE_IOVA_IN_MBUF
+		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+		addr0_1 = _mm256_unpackhi_epi64(addr0_1, zero);
+		addr2_3 = _mm256_unpackhi_epi64(addr2_3, zero);
+#else
+		/* erase Header Buffer Address */
+		addr0_1 = _mm256_unpacklo_epi64(addr0_1, zero);
+		addr2_3 = _mm256_unpacklo_epi64(addr2_3, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), addr0_1);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), addr2_3);
+	}
+}
+#endif /* __AVX2__ */
+
+#ifdef __AVX512VL__
+/* AVX512 version for 16-byte descriptors, handles 8 buffers at a time */
+static __rte_always_inline void
+_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	const __m512i hdroom = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
+	const __m512i zero = _mm512_setzero_si512();
+	volatile union ci_rx_desc *rxdp;
+	int i;
+
+	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
+
+	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
+
+	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp += 8) {
+		struct rte_mbuf *mb0 = rxp[0].mbuf;
+		struct rte_mbuf *mb1 = rxp[1].mbuf;
+		struct rte_mbuf *mb2 = rxp[2].mbuf;
+		struct rte_mbuf *mb3 = rxp[3].mbuf;
+		struct rte_mbuf *mb4 = rxp[4].mbuf;
+		struct rte_mbuf *mb5 = rxp[5].mbuf;
+		struct rte_mbuf *mb6 = rxp[6].mbuf;
+		struct rte_mbuf *mb7 = rxp[7].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
+		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+		const __m128i vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
+		const __m128i vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
+		const __m128i vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
+		const __m128i vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
+
+		/**
+		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
+		 * into the high lanes. Similarly for 2 & 3, and so on.
+		 */
+		const __m256i addr0_256 = _mm256_castsi128_si256(vaddr0);
+		const __m256i addr2_256 = _mm256_castsi128_si256(vaddr2);
+		const __m256i addr4_256 = _mm256_castsi128_si256(vaddr4);
+		const __m256i addr6_256 = _mm256_castsi128_si256(vaddr6);
+
+		const __m256i addr0_1 = _mm256_inserti128_si256(addr0_256, vaddr1, 1);
+		const __m256i addr2_3 = _mm256_inserti128_si256(addr2_256, vaddr3, 1);
+		const __m256i addr4_5 = _mm256_inserti128_si256(addr4_256, vaddr5, 1);
+		const __m256i addr6_7 = _mm256_inserti128_si256(addr6_256, vaddr7, 1);
+
+		/**
+		 * merge 0_1 & 2_3, by casting 0_1 to 512-bit and inserting 2_3
+		 * into the high lanes. Similarly for 4_5 & 6_7, and so on.
+		 */
+		const __m512i addr0_1_512 = _mm512_castsi256_si512(addr0_1);
+		const __m512i addr4_5_512 = _mm512_castsi256_si512(addr4_5);
+
+		__m512i addr0_3 = _mm512_inserti64x4(addr0_1_512, addr2_3, 1);
+		__m512i addr4_7 = _mm512_inserti64x4(addr4_5_512, addr6_7, 1);
+
+		/* add headroom to address values */
+		addr0_3 = _mm512_add_epi64(addr0_3, hdroom);
+		addr4_7 = _mm512_add_epi64(addr4_7, hdroom);
+
+#if RTE_IOVA_IN_MBUF
+		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+		addr0_3 = _mm512_unpackhi_epi64(addr0_3, zero);
+		addr4_7 = _mm512_unpackhi_epi64(addr4_7, zero);
+#else
+		/* erase Header Buffer Address */
+		addr0_3 = _mm512_unpacklo_epi64(addr0_3, zero);
+		addr4_7 = _mm512_unpacklo_epi64(addr4_7, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), addr0_3);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), addr4_7);
+	}
+}
+#endif /* __AVX512VL__ */
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
+
+/**
+ * Rearm the RX queue with new buffers.
+ *
+ * This function is inlined, so the last parameter will be constant-propagated
+ * if specified at compile time, and thus all unnecessary branching will be
+ * eliminated.
+ *
+ * @param rxq
+ *   Pointer to the RX queue structure.
+ * @param vec_level
+ *   The vectorization level to use for rearming.
+ */
+static __rte_always_inline void
+ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
+{
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	uint16_t rx_id;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
+		return;
+
+#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
+	switch (vec_level) {
+	case CI_RX_VEC_LEVEL_AVX512:
+#ifdef __AVX512VL__
+		_ci_rxq_rearm_avx512(rxq);
+		break;
+#else
+		/* fall back to AVX2 */
+		/* fall through */
+#endif
+	case CI_RX_VEC_LEVEL_AVX2:
+#ifdef __AVX2__
+		_ci_rxq_rearm_avx2(rxq);
+		break;
+#else
+		/* fall back to SSE */
+		/* fall through */
+#endif
+	case CI_RX_VEC_LEVEL_SSE:
+		_ci_rxq_rearm_sse(rxq, desc_len);
+		break;
+	}
+#else
+	/* for 32-byte descriptors only support SSE */
+	switch (vec_level) {
+	case CI_RX_VEC_LEVEL_AVX512:
+	case CI_RX_VEC_LEVEL_AVX2:
+	case CI_RX_VEC_LEVEL_SSE:
+		_ci_rxq_rearm_sse(rxq);
+		break;
+	}
+#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
+
+	rxq->rxrearm_start += rearm_thresh;
+	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
+		rxq->rxrearm_start = 0;
+
+	rxq->rxrearm_nb -= rearm_thresh;
+
+	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
+			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
+
+	/* Update the tail pointer on the NIC */
+	rte_write32_wc(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
+}
+
+#endif /* _COMMON_INTEL_RX_VEC_X86_H_ */
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 62f98579f5..aa81859ec0 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -28,12 +28,12 @@
 
 #define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
 
-#define ICE_VPMD_RX_BURST           32
-#define ICE_VPMD_TX_BURST           32
-#define ICE_VPMD_RXQ_REARM_THRESH   64
-#define ICE_TX_MAX_FREE_BUF_SZ      64
-#define ICE_VPMD_DESCS_PER_LOOP      4
-#define ICE_VPMD_DESCS_PER_LOOP_WIDE 8
+#define ICE_VPMD_RX_BURST            CI_VPMD_RX_BURST
+#define ICE_VPMD_TX_BURST            32
+#define ICE_VPMD_RXQ_REARM_THRESH    CI_VPMD_RX_REARM_THRESH
+#define ICE_TX_MAX_FREE_BUF_SZ       64
+#define ICE_VPMD_DESCS_PER_LOOP      CI_VPMD_DESCS_PER_LOOP
+#define ICE_VPMD_DESCS_PER_LOOP_WIDE CI_VPMD_DESCS_PER_LOOP_WIDE
 
 #define ICE_FDIR_PKT_LEN	512
 
diff --git a/drivers/net/intel/ice/ice_rxtx_common_avx.h b/drivers/net/intel/ice/ice_rxtx_common_avx.h
deleted file mode 100644
index 7c65e7ed4d..0000000000
--- a/drivers/net/intel/ice/ice_rxtx_common_avx.h
+++ /dev/null
@@ -1,233 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019 Intel Corporation
- */
-
-#ifndef _ICE_RXTX_COMMON_AVX_H_
-#define _ICE_RXTX_COMMON_AVX_H_
-
-#include "ice_rxtx.h"
-
-#ifdef __AVX2__
-static __rte_always_inline void
-ice_rxq_rearm_common(struct ci_rx_queue *rxq, __rte_unused bool avx512)
-{
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_flex_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	rxdp = rxq->rx_flex_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 ICE_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			__m128i dma_addr0;
-
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
-	struct rte_mbuf *mb0, *mb1;
-	__m128i dma_addr0, dma_addr1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-#if RTE_IOVA_IN_MBUF
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
-#else
-		/* convert va to dma_addr hdr/data */
-		dma_addr0 = _mm_unpacklo_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpacklo_epi64(vaddr1, vaddr1);
-#endif
-
-		/* add headroom to pa values */
-		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
-		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
-	}
-#else
-#ifdef __AVX512VL__
-	if (avx512) {
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
-		__m512i dma_addr0_3, dma_addr4_7;
-		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH;
-				i += 8, rxep += 8, rxdp += 8) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
-			__m256i vaddr0_1, vaddr2_3;
-			__m256i vaddr4_5, vaddr6_7;
-			__m512i vaddr0_3, vaddr4_7;
-
-			mb0 = rxep[0].mbuf;
-			mb1 = rxep[1].mbuf;
-			mb2 = rxep[2].mbuf;
-			mb3 = rxep[3].mbuf;
-			mb4 = rxep[4].mbuf;
-			mb5 = rxep[5].mbuf;
-			mb6 = rxep[6].mbuf;
-			mb7 = rxep[7].mbuf;
-
-#if RTE_IOVA_IN_MBUF
-			/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-			RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-					offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-			vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-			vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-			vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-			vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-			vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
-			vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
-			vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
-			vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
-
-			/**
-			 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-			 * into the high lanes. Similarly for 2 & 3, and so on.
-			 */
-			vaddr0_1 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-							vaddr1, 1);
-			vaddr2_3 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-							vaddr3, 1);
-			vaddr4_5 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr4),
-							vaddr5, 1);
-			vaddr6_7 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr6),
-							vaddr7, 1);
-			vaddr0_3 =
-				_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
-						   vaddr2_3, 1);
-			vaddr4_7 =
-				_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
-						   vaddr6_7, 1);
-
-#if RTE_IOVA_IN_MBUF
-			/* convert pa to dma_addr hdr/data */
-			dma_addr0_3 = _mm512_unpackhi_epi64(vaddr0_3, vaddr0_3);
-			dma_addr4_7 = _mm512_unpackhi_epi64(vaddr4_7, vaddr4_7);
-#else
-			/* convert va to dma_addr hdr/data */
-			dma_addr0_3 = _mm512_unpacklo_epi64(vaddr0_3, vaddr0_3);
-			dma_addr4_7 = _mm512_unpacklo_epi64(vaddr4_7, vaddr4_7);
-#endif
-
-			/* add headroom to pa values */
-			dma_addr0_3 = _mm512_add_epi64(dma_addr0_3, hdr_room);
-			dma_addr4_7 = _mm512_add_epi64(dma_addr4_7, hdr_room);
-
-			/* flush desc with pa dma_addr */
-			_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp->read), dma_addr0_3);
-			_mm512_store_si512(RTE_CAST_PTR(__m512i *, &(rxdp + 4)->read), dma_addr4_7);
-		}
-	} else
-#endif /* __AVX512VL__ */
-	{
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-		__m256i dma_addr0_1, dma_addr2_3;
-		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
-		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH;
-				i += 4, rxep += 4, rxdp += 4) {
-			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-			__m256i vaddr0_1, vaddr2_3;
-
-			mb0 = rxep[0].mbuf;
-			mb1 = rxep[1].mbuf;
-			mb2 = rxep[2].mbuf;
-			mb3 = rxep[3].mbuf;
-
-#if RTE_IOVA_IN_MBUF
-			/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-			RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-					offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-			vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-			vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-			vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-			vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-
-			/**
-			 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-			 * into the high lanes. Similarly for 2 & 3
-			 */
-			vaddr0_1 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-							vaddr1, 1);
-			vaddr2_3 =
-				_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-							vaddr3, 1);
-
-#if RTE_IOVA_IN_MBUF
-			/* convert pa to dma_addr hdr/data */
-			dma_addr0_1 = _mm256_unpackhi_epi64(vaddr0_1, vaddr0_1);
-			dma_addr2_3 = _mm256_unpackhi_epi64(vaddr2_3, vaddr2_3);
-#else
-			/* convert va to dma_addr hdr/data */
-			dma_addr0_1 = _mm256_unpacklo_epi64(vaddr0_1, vaddr0_1);
-			dma_addr2_3 = _mm256_unpacklo_epi64(vaddr2_3, vaddr2_3);
-#endif
-
-			/* add headroom to pa values */
-			dma_addr0_1 = _mm256_add_epi64(dma_addr0_1, hdr_room);
-			dma_addr2_3 = _mm256_add_epi64(dma_addr2_3, hdr_room);
-
-			/* flush desc with pa dma_addr */
-			_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp->read), dma_addr0_1);
-			_mm256_store_si256(RTE_CAST_PTR(__m256i *, &(rxdp + 2)->read), dma_addr2_3);
-		}
-	}
-
-#endif
-
-	rxq->rxrearm_start += ICE_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= ICE_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	ICE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
-}
-#endif /* __AVX2__ */
-
-#endif /* _ICE_RXTX_COMMON_AVX_H_ */
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 5b1a13dd22..b952b8dddc 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -3,14 +3,15 @@
  */
 
 #include "ice_rxtx_vec_common.h"
-#include "ice_rxtx_common_avx.h"
+
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	ice_rxq_rearm_common(rxq, false);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX2);
 }
 
 static __rte_always_inline __m256i
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index b943caf0f0..7c6fe82072 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -3,14 +3,15 @@
  */
 
 #include "ice_rxtx_vec_common.h"
-#include "ice_rxtx_common_avx.h"
+
+#include "../common/rx_vec_x86.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	ice_rxq_rearm_common(rxq, true);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_AVX512);
 }
 
 static inline __m256i
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index cae2188279..d818b3b728 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -4,6 +4,8 @@
 
 #include "ice_rxtx_vec_common.h"
 
+#include "../common/rx_vec_x86.h"
+
 #include <rte_vect.h>
 
 static inline __m128i
@@ -28,80 +30,7 @@ ice_flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 static inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ci_rx_flex_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-					  RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	rxdp = rxq->rx_flex_ring + rxq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 ICE_VPMD_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_VPMD_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_VPMD_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_VPMD_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
-		__m128i vaddr0, vaddr1;
-
-		mb0 = rxep[0].mbuf;
-		mb1 = rxep[1].mbuf;
-
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				 offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-#if RTE_IOVA_IN_MBUF
-		/* convert pa to dma_addr hdr/data */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, vaddr1);
-#else
-		/* convert va to dma_addr hdr/data */
-		dma_addr0 = _mm_unpacklo_epi64(vaddr0, vaddr0);
-		dma_addr1 = _mm_unpacklo_epi64(vaddr1, vaddr1);
-#endif
-
-		/* add headroom to pa values */
-		dma_addr0 = _mm_add_epi64(dma_addr0, hdr_room);
-		dma_addr1 = _mm_add_epi64(dma_addr1, hdr_room);
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
-	}
-
-	rxq->rxrearm_start += ICE_VPMD_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= ICE_VPMD_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			   (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	ICE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, CI_RX_VEC_LEVEL_SSE);
 }
 
 static inline void
-- 
2.47.1

