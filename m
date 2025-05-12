Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B74C3ABCD
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 12:55:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3752240676;
	Mon, 12 May 2025 14:55:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 10E6640671
 for <dev@dpdk.org>; Mon, 12 May 2025 14:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747054499; x=1778590499;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iO35GEqFe6NWhofo+QF/xYudNwtjII7d/2UA/5bt6A0=;
 b=QnaxiHMKQcJwSH0oKik5UTuaxlZHIE0JSSTZfW1JCL9RHV4LiYgL+2fM
 px5k6zYakq/ktOHqMrE3UDTwmSQm5To8fjppd/eg+jE8BWxg2mZlZmJIu
 JoJfbu9SGGa1xHRSV49aG6WfaY90j6tUToYrTbsmdORSH3AMLXEWa62/N
 BFzTkf5jvWcF6z2zPwY9jXfULSn7LgckM4IiJM5ikAfwvixtMYKhReLRe
 l14+IFTfSSPG8M6zZyDXOUx1TN6dsxuoZcpMnpTO5BYMnzqrZlEvwXNPw
 awGi8pBDEj4/L7uSin3B4+l8Hi33BuWCiLnAaSwUZw60BaXIvHGy7ZJu+ g==;
X-CSE-ConnectionGUID: Yq0FFjDhRR+8uD+aMYufmA==
X-CSE-MsgGUID: KCFZJL6gScqOemw6ClN1ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48096997"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="48096997"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 05:54:58 -0700
X-CSE-ConnectionGUID: 4eeQfw6hQuSIT7HnLzEH3A==
X-CSE-MsgGUID: 8oYMaEToRAWGRQZd83i6Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142251862"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 12 May 2025 05:54:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/13] net/intel: generalize vectorized Rx rearm
Date: Mon, 12 May 2025 13:54:33 +0100
Message-ID: <3c9411fcb3a01ac7dfc72011a5860c190d80ad4f.1747054471.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
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

The driver Rx rearm code used copious amounts of #ifdef-ery to
discriminate between 16- and 32-byte descriptor support, but we cannot do
that in the common code because we will not have access to those
definitions. So, instead, we use copious amounts of compile-time constant
propagation and force-inlining to ensure that the compiler generates
effectively the same code it generated back when it was in the driver. We
also add a compile-time definition for vectorization levels for x86
vector instructions to discriminate between different instruction sets.
This too is constant-propagated, and thus should not affect performance.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/rx.h               |   3 +
 drivers/net/intel/common/rx_vec_sse.h       | 323 ++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h            |   2 +-
 drivers/net/intel/ice/ice_rxtx_common_avx.h | 233 --------------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   |   5 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c |   5 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |  77 +----
 7 files changed, 336 insertions(+), 312 deletions(-)
 create mode 100644 drivers/net/intel/common/rx_vec_sse.h
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 2d9328ae89..65e920fdd1 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -14,6 +14,8 @@
 #define CI_RX_BURST 32
 #define CI_RX_MAX_BURST 32
 #define CI_RX_MAX_NSEG 2
+#define CI_VPMD_DESCS_PER_LOOP 4
+#define CI_VPMD_RX_REARM_THRESH 64
 
 struct ci_rx_queue;
 
@@ -40,6 +42,7 @@ struct ci_rx_queue {
 		volatile union ice_32b_rx_flex_desc *ice_rx_32b_ring;
 		volatile union iavf_16byte_rx_desc *iavf_rx_16b_ring;
 		volatile union iavf_32byte_rx_desc *iavf_rx_32b_ring;
+		volatile void *rx_ring; /**< Generic */
 	};
 	volatile uint8_t *qrx_tail;   /**< register address of tail */
 	struct ci_rx_entry *sw_ring; /**< address of RX software ring. */
diff --git a/drivers/net/intel/common/rx_vec_sse.h b/drivers/net/intel/common/rx_vec_sse.h
new file mode 100644
index 0000000000..6fe0baf38b
--- /dev/null
+++ b/drivers/net/intel/common/rx_vec_sse.h
@@ -0,0 +1,323 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_RX_VEC_SSE_H_
+#define _COMMON_INTEL_RX_VEC_SSE_H_
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
+_ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	volatile void *rxdp;
+	int i;
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	if (rte_mempool_get_bulk(rxq->mp,
+				 (void **)rxp,
+				 rearm_thresh) < 0) {
+		if (rxq->rxrearm_nb + rearm_thresh >= rxq->nb_rx_desc) {
+			__m128i dma_addr0;
+
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i].mbuf = &rxq->fake_mbuf;
+				const void *ptr = RTE_PTR_ADD(rxdp, i * desc_len);
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr),
+						dma_addr0);
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
+_ci_rxq_rearm_sse(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	const __m128i hdr_room = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
+	const __m128i zero = _mm_setzero_si128();
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	volatile void *rxdp;
+	int i;
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp = RTE_PTR_ADD(rxdp, 2 * desc_len)) {
+		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len);
+		__m128i vaddr0, vaddr1;
+		__m128i dma_addr0, dma_addr1;
+		struct rte_mbuf *mb0, *mb1;
+
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+
+		/* add headroom to address values */
+		vaddr0 = _mm_add_epi64(vaddr0, hdr_room);
+		vaddr1 = _mm_add_epi64(vaddr1, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
+		dma_addr0 = _mm_unpackhi_epi64(vaddr0, zero);
+		dma_addr1 = _mm_unpackhi_epi64(vaddr1, zero);
+#else
+		/* erase Header Buffer Address */
+		dma_addr0 = _mm_unpacklo_epi64(vaddr0, zero);
+		dma_addr1 = _mm_unpacklo_epi64(vaddr1, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr0), dma_addr0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr1), dma_addr1);
+	}
+}
+
+#ifdef __AVX2__
+/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
+static __rte_always_inline void
+_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	const size_t desc_len = 16;
+	volatile void *rxdp;
+	const __m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
+	const __m256i zero = _mm256_setzero_si256();
+	int i;
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp = RTE_PTR_ADD(rxdp, 4 * desc_len)) {
+		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 2);
+		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
+		__m256i vaddr0_1, vaddr2_3;
+		__m256i dma_addr0_1, dma_addr2_3;
+		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
+
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
+		mb2 = rxp[2].mbuf;
+		mb3 = rxp[3].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
+		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+
+		/**
+		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
+		 * into the high lanes. Similarly for 2 & 3
+		 */
+		vaddr0_1 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
+						vaddr1, 1);
+		vaddr2_3 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
+						vaddr3, 1);
+
+		/* add headroom to address values */
+		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
+		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+		dma_addr0_1 = _mm256_unpackhi_epi64(vaddr0_1, zero);
+		dma_addr2_3 = _mm256_unpackhi_epi64(vaddr2_3, zero);
+#else
+		/* erase Header Buffer Address */
+		dma_addr0_1 = _mm256_unpacklo_epi64(vaddr0_1, zero);
+		dma_addr2_3 = _mm256_unpacklo_epi64(vaddr2_3, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr0), dma_addr0_1);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr1), dma_addr2_3);
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
+	const size_t desc_len = 16;
+	volatile void *rxdp;
+	int i;
+	struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
+	struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
+	__m512i dma_addr0_3, dma_addr4_7;
+	__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
+	__m512i zero = _mm512_setzero_si512();
+
+	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
+
+	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
+	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp = RTE_PTR_ADD(rxdp, 8 * desc_len)) {
+		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 4);
+		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
+		__m128i vaddr4, vaddr5, vaddr6, vaddr7;
+		__m256i vaddr0_1, vaddr2_3;
+		__m256i vaddr4_5, vaddr6_7;
+		__m512i vaddr0_3, vaddr4_7;
+
+		mb0 = rxp[0].mbuf;
+		mb1 = rxp[1].mbuf;
+		mb2 = rxp[2].mbuf;
+		mb3 = rxp[3].mbuf;
+		mb4 = rxp[4].mbuf;
+		mb5 = rxp[5].mbuf;
+		mb6 = rxp[6].mbuf;
+		mb7 = rxp[7].mbuf;
+
+#if RTE_IOVA_IN_MBUF
+		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+				offsetof(struct rte_mbuf, buf_addr) + 8);
+#endif
+		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
+		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+		vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
+		vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
+		vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
+		vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
+
+		/**
+		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
+		 * into the high lanes. Similarly for 2 & 3, and so on.
+		 */
+		vaddr0_1 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
+						vaddr1, 1);
+		vaddr2_3 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
+						vaddr3, 1);
+		vaddr4_5 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr4),
+						vaddr5, 1);
+		vaddr6_7 =
+			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr6),
+						vaddr7, 1);
+		vaddr0_3 =
+			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
+						vaddr2_3, 1);
+		vaddr4_7 =
+			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
+						vaddr6_7, 1);
+
+		/* add headroom to address values */
+		vaddr0_3 = _mm512_add_epi64(vaddr0_3, hdr_room);
+		dma_addr4_7 = _mm512_add_epi64(dma_addr4_7, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+		dma_addr0_3 = _mm512_unpackhi_epi64(vaddr0_3, zero);
+		dma_addr4_7 = _mm512_unpackhi_epi64(vaddr4_7, zero);
+#else
+		/* erase Header Buffer Address */
+		dma_addr0_3 = _mm512_unpacklo_epi64(vaddr0_3, zero);
+		dma_addr4_7 = _mm512_unpacklo_epi64(vaddr4_7, zero);
+#endif
+
+		/* flush desc with pa dma_addr */
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr0), dma_addr0_3);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr1), dma_addr4_7);
+	}
+}
+#endif /* __AVX512VL__ */
+
+static __rte_always_inline void
+ci_rxq_rearm(struct ci_rx_queue *rxq, const size_t desc_len,
+		const enum ci_rx_vec_level vec_level)
+{
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	uint16_t rx_id;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (_ci_rxq_rearm_get_bufs(rxq, desc_len) < 0)
+		return;
+
+	if (desc_len == 16) {
+		switch (vec_level) {
+		case CI_RX_VEC_LEVEL_AVX512:
+#ifdef __AVX512VL__
+			_ci_rxq_rearm_avx512(rxq);
+			break;
+#else
+			/* fall back to AVX2 unless requested not to */
+			/* fall through */
+#endif
+		case CI_RX_VEC_LEVEL_AVX2:
+#ifdef __AVX2__
+			_ci_rxq_rearm_avx2(rxq);
+			break;
+#else
+			/* fall back to SSE if AVX2 isn't supported */
+			/* fall through */
+#endif
+		case CI_RX_VEC_LEVEL_SSE:
+			_ci_rxq_rearm_sse(rxq, desc_len);
+			break;
+		}
+	} else {
+		/* for 32-byte descriptors only support SSE */
+		_ci_rxq_rearm_sse(rxq, desc_len);
+	}
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
+#endif /* _COMMON_INTEL_RX_VEC_SSE_H_ */
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 1a39770d7d..72d0972587 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -43,7 +43,7 @@
 
 #define ICE_VPMD_RX_BURST           32
 #define ICE_VPMD_TX_BURST           32
-#define ICE_RXQ_REARM_THRESH        64
+#define ICE_RXQ_REARM_THRESH        CI_VPMD_RX_REARM_THRESH
 #define ICE_MAX_RX_BURST            ICE_RXQ_REARM_THRESH
 #define ICE_TX_MAX_FREE_BUF_SZ      64
 #define ICE_DESCS_PER_LOOP          4
diff --git a/drivers/net/intel/ice/ice_rxtx_common_avx.h b/drivers/net/intel/ice/ice_rxtx_common_avx.h
deleted file mode 100644
index 7209c902db..0000000000
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
-	volatile union ice_rx_flex_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-
-	rxdp = ICE_RX_RING_PTR(rxq, rxq->rxrearm_start);
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 ICE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			__m128i dma_addr0;
-
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_RXQ_REARM_THRESH;
-		return;
-	}
-
-#ifndef RTE_LIBRTE_ICE_16BYTE_RX_DESC
-	struct rte_mbuf *mb0, *mb1;
-	__m128i dma_addr0, dma_addr1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-			RTE_PKTMBUF_HEADROOM);
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-		for (i = 0; i < ICE_RXQ_REARM_THRESH;
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
-		for (i = 0; i < ICE_RXQ_REARM_THRESH;
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
-	rxq->rxrearm_start += ICE_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= ICE_RXQ_REARM_THRESH;
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
index f4555369a2..5ca3f92482 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -3,14 +3,15 @@
  */
 
 #include "ice_rxtx_vec_common.h"
-#include "ice_rxtx_common_avx.h"
+
+#include "../common/rx_vec_sse.h"
 
 #include <rte_vect.h>
 
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	ice_rxq_rearm_common(rxq, false);
+	ci_rxq_rearm(rxq, sizeof(union ice_rx_flex_desc), CI_RX_VEC_LEVEL_AVX2);
 }
 
 static __rte_always_inline __m256i
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 6eea74d703..883ea97c07 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -3,7 +3,8 @@
  */
 
 #include "ice_rxtx_vec_common.h"
-#include "ice_rxtx_common_avx.h"
+
+#include "../common/rx_vec_sse.h"
 
 #include <rte_vect.h>
 
@@ -12,7 +13,7 @@
 static __rte_always_inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	ice_rxq_rearm_common(rxq, true);
+	ci_rxq_rearm(rxq, sizeof(union ice_rx_flex_desc), CI_RX_VEC_LEVEL_AVX512);
 }
 
 static inline __m256i
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index dc9d37226a..fa0c7e8829 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -4,6 +4,8 @@
 
 #include "ice_rxtx_vec_common.h"
 
+#include "../common/rx_vec_sse.h"
+
 #include <rte_vect.h>
 
 static inline __m128i
@@ -28,80 +30,7 @@ ice_flex_rxd_to_fdir_flags_vec(const __m128i fdir_id0_3)
 static inline void
 ice_rxq_rearm(struct ci_rx_queue *rxq)
 {
-	int i;
-	uint16_t rx_id;
-	volatile union ice_rx_flex_desc *rxdp;
-	struct ci_rx_entry *rxep = &rxq->sw_ring[rxq->rxrearm_start];
-	struct rte_mbuf *mb0, *mb1;
-	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
-					  RTE_PKTMBUF_HEADROOM);
-	__m128i dma_addr0, dma_addr1;
-
-	rxdp = ICE_RX_RING_PTR(rxq, rxq->rxrearm_start);
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mempool_get_bulk(rxq->mp,
-				 (void *)rxep,
-				 ICE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_RXQ_REARM_THRESH >=
-		    rxq->nb_rx_desc) {
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_DESCS_PER_LOOP; i++) {
-				rxep[i].mbuf = &rxq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
-						dma_addr0);
-			}
-		}
-		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_RXQ_REARM_THRESH;
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
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
-	rxq->rxrearm_start += ICE_RXQ_REARM_THRESH;
-	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-		rxq->rxrearm_start = 0;
-
-	rxq->rxrearm_nb -= ICE_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
-			   (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	ICE_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
+	ci_rxq_rearm(rxq, sizeof(union ice_rx_flex_desc), CI_RX_VEC_LEVEL_SSE);
 }
 
 static inline void
-- 
2.47.1

