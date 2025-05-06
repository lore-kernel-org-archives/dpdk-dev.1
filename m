Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E278C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD49640687;
	Tue,  6 May 2025 15:28:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC9E4065B
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538114; x=1778074114;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=q9+s+3vJXSBo1pMYvCMMWzYcvH9xsDrJGUfshaSh4xM=;
 b=eEyBtQioH9DsDk4Q2yeHXpUxjywLuZkZ4PK2ACb5SuUTlHcdMHPgxEyV
 1na+xxZeZ9RL19MU+ZR2PAEM/dVGR7eAJlXkno4CHwgG42jq1wn+ZnHzR
 01yg+tS1MGdGlRfXuCFseB3Dyq5YROw6nqnSqv8/kxp6VM702p55QozWq
 FMnZKvtgQ1PbW7stMkOQWe8YUWUzUN5WPtrVKvC4ptV13kj82s5EzsjRv
 ArYmYsTKpGdCiR0zR5KeKbLY2WMXD8jKafaCsFxywVRYFPh2tzei7xtKI
 iEMIqVuUP13jVeqABQLFxxiyTYyl5qJDJmJ16fMCzIt2HvCYItKrWYtG2 g==;
X-CSE-ConnectionGUID: PRdN6xXcSO6gQiSV758rOw==
X-CSE-MsgGUID: XsFXASbLQ9m/6QcbLOZz6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215333"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:33 -0700
X-CSE-ConnectionGUID: E0YZl9r6RRqUhksm4xhOpw==
X-CSE-MsgGUID: BpNPEyW/QZujiXBodUxojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010879"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 11/13] net/intel: support wider x86 vectors for Rx rearm
Date: Tue,  6 May 2025 14:28:00 +0100
Message-ID: <79e02f0bf9ce4fbb4b94d27974077bc80e2fbe5d.1746538072.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
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

Currently, for 32-byte descriptor format, only SSE instruction set is
supported. Add implementation for AVX2 and AVX512 instruction sets. This
implementation similarly constant-propagates everything at compile time and
thus should not affect performance of existing code paths. To improve code
readability and reduce code duplication due to supporting different sized
descriptors, the implementation is also refactored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/rx_vec_sse.h | 380 ++++++++++++++------------
 1 file changed, 205 insertions(+), 175 deletions(-)

diff --git a/drivers/net/intel/common/rx_vec_sse.h b/drivers/net/intel/common/rx_vec_sse.h
index 6fe0baf38b..0aeaac3dc9 100644
--- a/drivers/net/intel/common/rx_vec_sse.h
+++ b/drivers/net/intel/common/rx_vec_sse.h
@@ -48,223 +48,258 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq, const size_t desc_len)
 	return 0;
 }
 
-/*
- * SSE code path can handle both 16-byte and 32-byte descriptors with one code
- * path, as we only ever write 16 bytes at a time.
- */
-static __rte_always_inline void
-_ci_rxq_rearm_sse(struct ci_rx_queue *rxq, const size_t desc_len)
+static __rte_always_inline __m128i
+_ci_rxq_rearm_desc_sse(const __m128i vaddr)
 {
 	const __m128i hdr_room = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 	const __m128i zero = _mm_setzero_si128();
+	__m128i reg;
+
+	/* add headroom to address values */
+	reg = _mm_add_epi64(vaddr, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+			 offsetof(struct rte_mbuf, buf_addr) + 8);
+	/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
+	reg = _mm_unpackhi_epi64(reg, zero);
+#else
+	/* erase Header Buffer Address */
+	reg = _mm_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_sse(struct ci_rx_queue *rxq, const size_t desc_len)
+{
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
 	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint8_t desc_per_reg = 1;
+	const uint8_t desc_per_iter = desc_per_reg * 2;
 	volatile void *rxdp;
 	int i;
 
 	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp = RTE_PTR_ADD(rxdp, 2 * desc_len)) {
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp = RTE_PTR_ADD(rxdp, desc_per_iter * desc_len)) {
 		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
-		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len);
-		__m128i vaddr0, vaddr1;
-		__m128i dma_addr0, dma_addr1;
-		struct rte_mbuf *mb0, *mb1;
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * desc_per_reg);
+		const struct rte_mbuf *mb0 = rxp[0].mbuf;
+		const struct rte_mbuf *mb1 = rxp[1].mbuf;
 
-		mb0 = rxp[0].mbuf;
-		mb1 = rxp[1].mbuf;
+		const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
+		const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
 
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-		/* add headroom to address values */
-		vaddr0 = _mm_add_epi64(vaddr0, hdr_room);
-		vaddr1 = _mm_add_epi64(vaddr1, hdr_room);
-
-#if RTE_IOVA_IN_MBUF
-		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
-		dma_addr0 = _mm_unpackhi_epi64(vaddr0, zero);
-		dma_addr1 = _mm_unpackhi_epi64(vaddr1, zero);
-#else
-		/* erase Header Buffer Address */
-		dma_addr0 = _mm_unpacklo_epi64(vaddr0, zero);
-		dma_addr1 = _mm_unpacklo_epi64(vaddr1, zero);
-#endif
+		const __m128i reg0 = _ci_rxq_rearm_desc_sse(vaddr0);
+		const __m128i reg1 = _ci_rxq_rearm_desc_sse(vaddr1);
 
 		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr0), dma_addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr1), dma_addr1);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr0), reg0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, ptr1), reg1);
 	}
 }
 
 #ifdef __AVX2__
-/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
-static __rte_always_inline void
-_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
+static __rte_always_inline __m256i
+_ci_rxq_rearm_desc_avx2(const __m128i vaddr0, const __m128i vaddr1)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
-	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
-	const size_t desc_len = 16;
-	volatile void *rxdp;
 	const __m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 	const __m256i zero = _mm256_setzero_si256();
+	__m256i reg;
+
+	/* merge by casting 0 to 256-bit and inserting 1 into the high lanes */
+	reg =
+		_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
+					vaddr1, 1);
+
+	/* add headroom to address values */
+	reg = _mm256_add_epi64(reg, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+			offsetof(struct rte_mbuf, buf_addr) + 8);
+	/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+	reg = _mm256_unpackhi_epi64(reg, zero);
+#else
+	/* erase Header Buffer Address */
+	reg = _mm256_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq, const size_t desc_len)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	/* how many descriptors can fit into a register */
+	const uint8_t desc_per_reg = sizeof(__m256i) / desc_len;
+	/* how many descriptors can fit into one loop iteration */
+	const uint8_t desc_per_iter = desc_per_reg * 2;
+	volatile void *rxdp;
 	int i;
 
 	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
 
-	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp = RTE_PTR_ADD(rxdp, 4 * desc_len)) {
+	/* Initialize the mbufs in vector, process 2 or 4 mbufs in one loop */
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp = RTE_PTR_ADD(rxdp, desc_per_iter * desc_len)) {
 		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
-		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 2);
-		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-		__m256i vaddr0_1, vaddr2_3;
-		__m256i dma_addr0_1, dma_addr2_3;
-		struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * desc_per_reg);
+		__m256i reg0, reg1;
 
-		mb0 = rxp[0].mbuf;
-		mb1 = rxp[1].mbuf;
-		mb2 = rxp[2].mbuf;
-		mb3 = rxp[3].mbuf;
+		if (desc_per_iter == 2) {
+			/* 16 byte descriptor, 16 byte zero, times two */
+			const __m128i zero = _mm_setzero_si128();
+			const struct rte_mbuf *mb0 = rxp[0].mbuf;
+			const struct rte_mbuf *mb1 = rxp[1].mbuf;
 
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
+			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
 
-		/**
-		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-		 * into the high lanes. Similarly for 2 & 3
-		 */
-		vaddr0_1 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-						vaddr1, 1);
-		vaddr2_3 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-						vaddr3, 1);
+			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, zero);
+			reg1 = _ci_rxq_rearm_desc_avx2(vaddr1, zero);
+		} else {
+			/* 16 byte descriptor times four */
+			const struct rte_mbuf *mb0 = rxp[0].mbuf;
+			const struct rte_mbuf *mb1 = rxp[1].mbuf;
+			const struct rte_mbuf *mb2 = rxp[2].mbuf;
+			const struct rte_mbuf *mb3 = rxp[3].mbuf;
 
-		/* add headroom to address values */
-		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
-		vaddr0_1 = _mm256_add_epi64(vaddr0_1, hdr_room);
+			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
+			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
+			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
+			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
 
-#if RTE_IOVA_IN_MBUF
-		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
-		dma_addr0_1 = _mm256_unpackhi_epi64(vaddr0_1, zero);
-		dma_addr2_3 = _mm256_unpackhi_epi64(vaddr2_3, zero);
-#else
-		/* erase Header Buffer Address */
-		dma_addr0_1 = _mm256_unpacklo_epi64(vaddr0_1, zero);
-		dma_addr2_3 = _mm256_unpacklo_epi64(vaddr2_3, zero);
-#endif
+			reg0 = _ci_rxq_rearm_desc_avx2(vaddr0, vaddr1);
+			reg1 = _ci_rxq_rearm_desc_avx2(vaddr2, vaddr3);
+		}
 
 		/* flush desc with pa dma_addr */
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr0), dma_addr0_1);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr1), dma_addr2_3);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr0), reg0);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, ptr1), reg1);
 	}
 }
 #endif /* __AVX2__ */
 
 #ifdef __AVX512VL__
-/* AVX512 version for 16-byte descriptors, handles 8 buffers at a time */
+static __rte_always_inline __m512i
+_ci_rxq_rearm_desc_avx512(const __m128i vaddr0, const __m128i vaddr1,
+		const __m128i vaddr2, const __m128i vaddr3)
+{
+	const __m512i zero = _mm512_setzero_si512();
+	const __m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
+	__m256i vaddr0_1, vaddr2_3;
+	__m512i reg;
+
+	/**
+	 * merge 0 & 1, by casting 0 to 256-bit and inserting 1 into the high
+	 * lanes. Similarly for 2 & 3.
+	 */
+	vaddr0_1 =
+		_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
+					vaddr1, 1);
+	vaddr2_3 =
+		_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
+					vaddr3, 1);
+	/*
+	 * merge 0+1 & 2+3, by casting 0+1 to 512-bit and inserting 2+3 into the
+	 * high lanes.
+	 */
+	reg =
+		_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
+					vaddr2_3, 1);
+
+	/* add headroom to address values */
+	reg = _mm512_add_epi64(reg, hdr_room);
+
+#if RTE_IOVA_IN_MBUF
+	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+			offsetof(struct rte_mbuf, buf_addr) + 8);
+	/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+	reg = _mm512_unpackhi_epi64(reg, zero);
+#else
+	/* erase Header Buffer Address */
+	reg = _mm512_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
 static __rte_always_inline void
-_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
+_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq, const size_t desc_len)
 {
 	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
-	const size_t desc_len = 16;
+	/* how many descriptors can fit into a register */
+	const uint8_t desc_per_reg = sizeof(__m512i) / desc_len;
+	/* how many descriptors can fit into one loop iteration */
+	const uint8_t desc_per_iter = desc_per_reg * 2;
 	volatile void *rxdp;
 	int i;
-	struct rte_mbuf *mb0, *mb1, *mb2, *mb3;
-	struct rte_mbuf *mb4, *mb5, *mb6, *mb7;
-	__m512i dma_addr0_3, dma_addr4_7;
-	__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
-	__m512i zero = _mm512_setzero_si512();
 
 	rxdp = RTE_PTR_ADD(rxq->rx_ring, rxq->rxrearm_start * desc_len);
 
-	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp = RTE_PTR_ADD(rxdp, 8 * desc_len)) {
+	/* Initialize the mbufs in vector, process 4 or 8 mbufs in one loop */
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp = RTE_PTR_ADD(rxdp, desc_per_iter * desc_len)) {
 		volatile void *ptr0 = RTE_PTR_ADD(rxdp, 0);
-		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * 4);
-		__m128i vaddr0, vaddr1, vaddr2, vaddr3;
-		__m128i vaddr4, vaddr5, vaddr6, vaddr7;
-		__m256i vaddr0_1, vaddr2_3;
-		__m256i vaddr4_5, vaddr6_7;
-		__m512i vaddr0_3, vaddr4_7;
+		volatile void *ptr1 = RTE_PTR_ADD(rxdp, desc_len * desc_per_reg);
+		__m512i reg0, reg1;
 
-		mb0 = rxp[0].mbuf;
-		mb1 = rxp[1].mbuf;
-		mb2 = rxp[2].mbuf;
-		mb3 = rxp[3].mbuf;
-		mb4 = rxp[4].mbuf;
-		mb5 = rxp[5].mbuf;
-		mb6 = rxp[6].mbuf;
-		mb7 = rxp[7].mbuf;
+		if (desc_per_iter == 4) {
+			/* 16-byte descriptor, 16 byte zero, times four */
+			const __m128i zero = _mm_setzero_si128();
+			const struct rte_mbuf *mb0 = rxp[0].mbuf;
+			const struct rte_mbuf *mb1 = rxp[1].mbuf;
+			const struct rte_mbuf *mb2 = rxp[2].mbuf;
+			const struct rte_mbuf *mb3 = rxp[3].mbuf;
 
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-		vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-		vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-		vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
-		vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
-		vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
-		vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
+			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
+			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
+			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
+			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
 
-		/**
-		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-		 * into the high lanes. Similarly for 2 & 3, and so on.
-		 */
-		vaddr0_1 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr0),
-						vaddr1, 1);
-		vaddr2_3 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr2),
-						vaddr3, 1);
-		vaddr4_5 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr4),
-						vaddr5, 1);
-		vaddr6_7 =
-			_mm256_inserti128_si256(_mm256_castsi128_si256(vaddr6),
-						vaddr7, 1);
-		vaddr0_3 =
-			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1),
-						vaddr2_3, 1);
-		vaddr4_7 =
-			_mm512_inserti64x4(_mm512_castsi256_si512(vaddr4_5),
-						vaddr6_7, 1);
+			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, zero, vaddr1, zero);
+			reg1 = _ci_rxq_rearm_desc_avx512(vaddr2, zero, vaddr3, zero);
+		} else {
+			/* 16-byte descriptor times eight */
+			const struct rte_mbuf *mb0 = rxp[0].mbuf;
+			const struct rte_mbuf *mb1 = rxp[1].mbuf;
+			const struct rte_mbuf *mb2 = rxp[2].mbuf;
+			const struct rte_mbuf *mb3 = rxp[3].mbuf;
+			const struct rte_mbuf *mb4 = rxp[4].mbuf;
+			const struct rte_mbuf *mb5 = rxp[5].mbuf;
+			const struct rte_mbuf *mb6 = rxp[6].mbuf;
+			const struct rte_mbuf *mb7 = rxp[7].mbuf;
 
-		/* add headroom to address values */
-		vaddr0_3 = _mm512_add_epi64(vaddr0_3, hdr_room);
-		dma_addr4_7 = _mm512_add_epi64(dma_addr4_7, hdr_room);
+			const __m128i vaddr0 = _mm_loadu_si128((const __m128i *)&mb0->buf_addr);
+			const __m128i vaddr1 = _mm_loadu_si128((const __m128i *)&mb1->buf_addr);
+			const __m128i vaddr2 = _mm_loadu_si128((const __m128i *)&mb2->buf_addr);
+			const __m128i vaddr3 = _mm_loadu_si128((const __m128i *)&mb3->buf_addr);
+			const __m128i vaddr4 = _mm_loadu_si128((const __m128i *)&mb4->buf_addr);
+			const __m128i vaddr5 = _mm_loadu_si128((const __m128i *)&mb5->buf_addr);
+			const __m128i vaddr6 = _mm_loadu_si128((const __m128i *)&mb6->buf_addr);
+			const __m128i vaddr7 = _mm_loadu_si128((const __m128i *)&mb7->buf_addr);
 
-#if RTE_IOVA_IN_MBUF
-		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
-		dma_addr0_3 = _mm512_unpackhi_epi64(vaddr0_3, zero);
-		dma_addr4_7 = _mm512_unpackhi_epi64(vaddr4_7, zero);
-#else
-		/* erase Header Buffer Address */
-		dma_addr0_3 = _mm512_unpacklo_epi64(vaddr0_3, zero);
-		dma_addr4_7 = _mm512_unpacklo_epi64(vaddr4_7, zero);
-#endif
+			reg0 = _ci_rxq_rearm_desc_avx512(vaddr0, vaddr1, vaddr2, vaddr3);
+			reg1 = _ci_rxq_rearm_desc_avx512(vaddr4, vaddr5, vaddr6, vaddr7);
+		}
 
 		/* flush desc with pa dma_addr */
-		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr0), dma_addr0_3);
-		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr1), dma_addr4_7);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr0), reg0);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, ptr1), reg1);
 	}
 }
 #endif /* __AVX512VL__ */
@@ -280,31 +315,26 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const size_t desc_len,
 	if (_ci_rxq_rearm_get_bufs(rxq, desc_len) < 0)
 		return;
 
-	if (desc_len == 16) {
-		switch (vec_level) {
-		case CI_RX_VEC_LEVEL_AVX512:
+	switch (vec_level) {
+	case CI_RX_VEC_LEVEL_AVX512:
 #ifdef __AVX512VL__
-			_ci_rxq_rearm_avx512(rxq);
-			break;
+		_ci_rxq_rearm_avx512(rxq, desc_len);
+		break;
 #else
-			/* fall back to AVX2 unless requested not to */
-			/* fall through */
+		/* fall back to AVX2 unless requested not to */
+		/* fall through */
 #endif
-		case CI_RX_VEC_LEVEL_AVX2:
+	case CI_RX_VEC_LEVEL_AVX2:
 #ifdef __AVX2__
-			_ci_rxq_rearm_avx2(rxq);
+			_ci_rxq_rearm_avx2(rxq, desc_len);
 			break;
 #else
 			/* fall back to SSE if AVX2 isn't supported */
 			/* fall through */
 #endif
-		case CI_RX_VEC_LEVEL_SSE:
-			_ci_rxq_rearm_sse(rxq, desc_len);
-			break;
-		}
-	} else {
-		/* for 32-byte descriptors only support SSE */
+	case CI_RX_VEC_LEVEL_SSE:
 		_ci_rxq_rearm_sse(rxq, desc_len);
+		break;
 	}
 
 	rxq->rxrearm_start += rearm_thresh;
-- 
2.47.1

