Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760EC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34E4042DB4;
	Thu, 12 Jun 2025 13:12:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA3642DA3
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726769; x=1781262769;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o/p7xwBme9Puj8rOpDV63IhYnkFcBgIVoVXBE8N8jgI=;
 b=ewlSg2iNEmmvBas9U7aOWPBAwhzVvHwmAVJVW6+NGWukJm8Y2gziO443
 xFUfbUM4/fKrGtJasTUfBhGM+mIMCTD2HcbVjajav3qpoDFIyWI1o4XJq
 HVH36z6cG7jO5YaBU925pfF9MTDV3JyRcYqVabFaBDLkyI+wLKtZU0E/p
 3tEH+XsHeADZxItBVpZi9k/xz3+tfhza4yy47S/GEAKuE1Qx4ce7sLqPY
 tpNFEO7kPdZCDuXk/iQhZBdrEz18/R6OBGFeBQI9tEVxlAibwRJ3NL9H7
 /xGnuQ0+q7VxUJ+4HmvQEoaiW7M7FehlzqQfSyCWJzw1glmkIZLdRhEr3 g==;
X-CSE-ConnectionGUID: JD5wy2t/TOOqrW3tLXZWTw==
X-CSE-MsgGUID: 3PTMt8TwSAS/qyHF4lFOjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177624"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177624"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:49 -0700
X-CSE-ConnectionGUID: EBEuZqKaQkGcetBzn9X9Sg==
X-CSE-MsgGUID: NFqTIwerRTaedjEk9XrkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371428"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 31/33] net/intel: support wider x86 vectors for Rx rearm
Date: Thu, 12 Jun 2025 12:11:37 +0100
Message-ID: <81c601ac9cd8705c3fb7f33d04e1970f137d6c60.1749726640.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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
supported. Add implementation for AVX2 and AVX512 instruction sets. Since
we are using Rx descriptor definitions from common code, we can just use
the generic descriptor definition, as we only ever write the first 16 bytes
of it, and the layout is always the same for that part.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v7:
    - Fix stack overrun in AVX code paths due to copypaste error

 drivers/net/intel/common/rx_vec_x86.h | 368 ++++++++++++++------------
 1 file changed, 201 insertions(+), 167 deletions(-)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index ecab8b30a6..3d7343b1ff 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -43,206 +43,251 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-/*
- * SSE code path can handle both 16-byte and 32-byte descriptors with one code
- * path, as we only ever write 16 bytes at a time.
+/**
+ * Reformat data from mbuf to descriptor for one RX descriptor, using SSE instruction set.
+ *
+ * @param mhdr pointer to first 16 bytes of mbuf header
+ * @return 16-byte register in descriptor format.
  */
-static __rte_always_inline void
-_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
+static __rte_always_inline __m128i
+_ci_rxq_rearm_desc_sse(const __m128i *mhdr)
 {
 	const __m128i hdroom = _mm_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 	const __m128i zero = _mm_setzero_si128();
+
+	/* add headroom to address values */
+	__m128i reg = _mm_add_epi64(*mhdr, hdroom);
+
+#if RTE_IOVA_IN_MBUF
+	/* expect buf_addr (low 64 bit) and buf_iova (high 64bit) */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+			 offsetof(struct rte_mbuf, buf_addr) + 8);
+	/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
+	reg = _mm_unpackhi_epi64(reg, zero);
+#else
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_addr) != 0);
+	/* erase Header Buffer Address */
+	reg = _mm_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_sse(struct ci_rx_queue *rxq)
+{
 	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
 	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	/* SSE writes 16-bytes regardless of descriptor size */
+	const uint8_t desc_per_reg = 1;
+	const uint8_t desc_per_iter = desc_per_reg * 2;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 2, rxp += 2, rxdp += 2) {
-		struct rte_mbuf *mb0 = rxp[0].mbuf;
-		struct rte_mbuf *mb1 = rxp[1].mbuf;
-
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		__m128i addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		__m128i addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-
-		/* add headroom to address values */
-		addr0 = _mm_add_epi64(addr0, hdroom);
-		addr1 = _mm_add_epi64(addr1, hdroom);
-
-#if RTE_IOVA_IN_MBUF
-		/* move IOVA to Packet Buffer Address, erase Header Buffer Address */
-		addr0 = _mm_unpackhi_epi64(addr0, zero);
-		addr0 = _mm_unpackhi_epi64(addr1, zero);
-#else
-		/* erase Header Buffer Address */
-		addr0 = _mm_unpacklo_epi64(addr0, zero);
-		addr1 = _mm_unpacklo_epi64(addr1, zero);
-#endif
-
-		/* flush desc with pa dma_addr */
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), addr0);
-		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[1]), addr1);
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp += desc_per_iter) {
+		const __m128i reg0 = _ci_rxq_rearm_desc_sse(
+				RTE_CAST_PTR(const __m128i *, rxp[0].mbuf));
+		const __m128i reg1 = _ci_rxq_rearm_desc_sse(
+				RTE_CAST_PTR(const __m128i *, rxp[1].mbuf));
+
+		/* flush descriptors */
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[0]), reg0);
+		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[desc_per_reg]), reg1);
 	}
 }
 
-#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 #ifdef __AVX2__
-/* AVX2 version for 16-byte descriptors, handles 4 buffers at a time */
-static __rte_always_inline void
-_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
+/**
+ * Reformat data from mbuf to descriptor for one RX descriptor, using AVX2 instruction set.
+ *
+ * Note that for 32-byte descriptors, the second parameter must be zeroed out.
+ *
+ * @param mhdr0 pointer to first 16-bytes of 1st mbuf header.
+ * @param mhdr1 pointer to first 16-bytes of 2nd mbuf header.
+ *
+ * @return 32-byte register with two 16-byte descriptors in it.
+ */
+static __rte_always_inline __m256i
+_ci_rxq_rearm_desc_avx2(const __m128i *mhdr0, const __m128i *mhdr1)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
-	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
-	const __m256i hdroom = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
+	const __m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 	const __m256i zero = _mm256_setzero_si256();
+
+	/* merge by casting 0 to 256-bit and inserting 1 into the high lanes */
+	__m256i reg = _mm256_inserti128_si256(_mm256_castsi128_si256(*mhdr0), *mhdr1, 1);
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
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_addr) != 0);
+	/* erase Header Buffer Address */
+	reg = _mm256_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_avx2(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	/* how many descriptors can fit into a register */
+	const uint8_t desc_per_reg = sizeof(__m256i) / sizeof(union ci_rx_desc);
+	/* how many descriptors can fit into one loop iteration */
+	const uint8_t desc_per_iter = desc_per_reg * 2;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
-	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
-
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
-	/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 4, rxp += 4, rxdp += 4) {
-		struct rte_mbuf *mb0 = rxp[0].mbuf;
-		struct rte_mbuf *mb1 = rxp[1].mbuf;
-		struct rte_mbuf *mb2 = rxp[2].mbuf;
-		struct rte_mbuf *mb3 = rxp[3].mbuf;
+	/* Initialize the mbufs in vector, process 2 or 4 mbufs in one loop */
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp += desc_per_iter) {
+		__m256i reg0, reg1;
 
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
+		if (desc_per_iter == 2) {
+			/* no need to call AVX2 version as we only need two descriptors */
+			reg0 = _mm256_castsi128_si256(
+				_ci_rxq_rearm_desc_sse(
+					RTE_CAST_PTR(const __m128i *, rxp[0].mbuf)));
+			reg1 = _mm256_castsi128_si256(
+				_ci_rxq_rearm_desc_sse(
+					RTE_CAST_PTR(const __m128i *, rxp[1].mbuf)));
+		} else {
+			/* 16 byte descriptor times four */
+			reg0 = _ci_rxq_rearm_desc_avx2(
+					RTE_CAST_PTR(const __m128i *, rxp[0].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[1].mbuf));
+			reg1 = _ci_rxq_rearm_desc_avx2(
+					RTE_CAST_PTR(const __m128i *, rxp[2].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[3].mbuf));
+		}
 
-		/**
-		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-		 * into the high lanes. Similarly for 2 & 3
-		 */
-		const __m256i vaddr0_256 = _mm256_castsi128_si256(vaddr0);
-		const __m256i vaddr2_256 = _mm256_castsi128_si256(vaddr2);
-
-		__m256i addr0_1 = _mm256_inserti128_si256(vaddr0_256, vaddr1, 1);
-		__m256i addr2_3 = _mm256_inserti128_si256(vaddr2_256, vaddr3, 1);
-
-		/* add headroom to address values */
-		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
-		addr0_1 = _mm256_add_epi64(addr0_1, hdroom);
-
-#if RTE_IOVA_IN_MBUF
-		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
-		addr0_1 = _mm256_unpackhi_epi64(addr0_1, zero);
-		addr2_3 = _mm256_unpackhi_epi64(addr2_3, zero);
-#else
-		/* erase Header Buffer Address */
-		addr0_1 = _mm256_unpacklo_epi64(addr0_1, zero);
-		addr2_3 = _mm256_unpacklo_epi64(addr2_3, zero);
-#endif
-
-		/* flush desc with pa dma_addr */
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), addr0_1);
-		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[2]), addr2_3);
+		/* flush descriptors */
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[0]), reg0);
+		_mm256_store_si256(RTE_CAST_PTR(__m256i *, &rxdp[desc_per_reg]), reg1);
 	}
 }
 #endif /* __AVX2__ */
 
 #ifdef __AVX512VL__
-/* AVX512 version for 16-byte descriptors, handles 8 buffers at a time */
-static __rte_always_inline void
-_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
+/**
+ * Reformat data from mbuf to descriptor for one RX descriptor, using AVX512 instruction set.
+ *
+ * Note that for 32-byte descriptors, every second parameter must be zeroed out.
+ *
+ * @param mhdr0 pointer to first 16-bytes of 1st mbuf header.
+ * @param mhdr1 pointer to first 16-bytes of 2nd mbuf header.
+ * @param mhdr2 pointer to first 16-bytes of 3rd mbuf header.
+ * @param mhdr3 pointer to first 16-bytes of 4th mbuf header.
+ *
+ * @return 64-byte register with four 16-byte descriptors in it.
+ */
+static __rte_always_inline __m512i
+_ci_rxq_rearm_desc_avx512(const __m128i *mhdr0, const __m128i *mhdr1,
+		const __m128i *mhdr2, const __m128i *mhdr3)
 {
-	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
-	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
-	const __m512i hdroom = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
 	const __m512i zero = _mm512_setzero_si512();
+	const __m512i hdroom = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
+
+	/**
+	 * merge 0 & 1, by casting 0 to 256-bit and inserting 1 into the high
+	 * lanes. Similarly for 2 & 3.
+	 */
+	const __m256i vaddr0_1 = _mm256_inserti128_si256(_mm256_castsi128_si256(*mhdr0), *mhdr1, 1);
+	const __m256i vaddr2_3 = _mm256_inserti128_si256(_mm256_castsi128_si256(*mhdr2), *mhdr3, 1);
+	/*
+	 * merge 0+1 & 2+3, by casting 0+1 to 512-bit and inserting 2+3 into the
+	 * high lanes.
+	 */
+	__m512i reg = _mm512_inserti64x4(_mm512_castsi256_si512(vaddr0_1), vaddr2_3, 1);
+
+	/* add headroom to address values */
+	reg = _mm512_add_epi64(reg, hdroom);
+
+#if RTE_IOVA_IN_MBUF
+	/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
+			offsetof(struct rte_mbuf, buf_addr) + 8);
+	/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
+	reg = _mm512_unpackhi_epi64(reg, zero);
+#else
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_addr) != 0);
+	/* erase Header Buffer Address */
+	reg = _mm512_unpacklo_epi64(reg, zero);
+#endif
+	return reg;
+}
+
+static __rte_always_inline void
+_ci_rxq_rearm_avx512(struct ci_rx_queue *rxq)
+{
+	struct ci_rx_entry *rxp = &rxq->sw_ring[rxq->rxrearm_start];
+	const uint16_t rearm_thresh = CI_VPMD_RX_REARM_THRESH;
+	/* how many descriptors can fit into a register */
+	const uint8_t desc_per_reg = sizeof(__m512i) / sizeof(union ci_rx_desc);
+	/* how many descriptors can fit into one loop iteration */
+	const uint8_t desc_per_iter = desc_per_reg * 2;
 	volatile union ci_rx_desc *rxdp;
 	int i;
 
-	RTE_BUILD_BUG_ON(sizeof(union ci_rx_desc) != 16);
-
 	rxdp = &rxq->rx_ring[rxq->rxrearm_start];
 
-	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-	for (i = 0; i < rearm_thresh; i += 8, rxp += 8, rxdp += 8) {
-		struct rte_mbuf *mb0 = rxp[0].mbuf;
-		struct rte_mbuf *mb1 = rxp[1].mbuf;
-		struct rte_mbuf *mb2 = rxp[2].mbuf;
-		struct rte_mbuf *mb3 = rxp[3].mbuf;
-		struct rte_mbuf *mb4 = rxp[4].mbuf;
-		struct rte_mbuf *mb5 = rxp[5].mbuf;
-		struct rte_mbuf *mb6 = rxp[6].mbuf;
-		struct rte_mbuf *mb7 = rxp[7].mbuf;
+	/* Initialize the mbufs in vector, process 4 or 8 mbufs in one loop */
+	for (i = 0; i < rearm_thresh;
+			i += desc_per_iter,
+			rxp += desc_per_iter,
+			rxdp += desc_per_iter) {
+		__m512i reg0, reg1;
 
-#if RTE_IOVA_IN_MBUF
-		/* load buf_addr(lo 64bit) and buf_iova(hi 64bit) */
-		RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, buf_iova) !=
-				offsetof(struct rte_mbuf, buf_addr) + 8);
-#endif
-		const __m128i vaddr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
-		const __m128i vaddr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
-		const __m128i vaddr2 = _mm_loadu_si128((__m128i *)&mb2->buf_addr);
-		const __m128i vaddr3 = _mm_loadu_si128((__m128i *)&mb3->buf_addr);
-		const __m128i vaddr4 = _mm_loadu_si128((__m128i *)&mb4->buf_addr);
-		const __m128i vaddr5 = _mm_loadu_si128((__m128i *)&mb5->buf_addr);
-		const __m128i vaddr6 = _mm_loadu_si128((__m128i *)&mb6->buf_addr);
-		const __m128i vaddr7 = _mm_loadu_si128((__m128i *)&mb7->buf_addr);
+		if (desc_per_iter == 4) {
+			/* 16-byte descriptor, 16 byte zero, times four */
+			const __m128i zero = _mm_setzero_si128();
 
-		/**
-		 * merge 0 & 1, by casting 0 to 256-bit and inserting 1
-		 * into the high lanes. Similarly for 2 & 3, and so on.
-		 */
-		const __m256i addr0_256 = _mm256_castsi128_si256(vaddr0);
-		const __m256i addr2_256 = _mm256_castsi128_si256(vaddr2);
-		const __m256i addr4_256 = _mm256_castsi128_si256(vaddr4);
-		const __m256i addr6_256 = _mm256_castsi128_si256(vaddr6);
-
-		const __m256i addr0_1 = _mm256_inserti128_si256(addr0_256, vaddr1, 1);
-		const __m256i addr2_3 = _mm256_inserti128_si256(addr2_256, vaddr3, 1);
-		const __m256i addr4_5 = _mm256_inserti128_si256(addr4_256, vaddr5, 1);
-		const __m256i addr6_7 = _mm256_inserti128_si256(addr6_256, vaddr7, 1);
-
-		/**
-		 * merge 0_1 & 2_3, by casting 0_1 to 512-bit and inserting 2_3
-		 * into the high lanes. Similarly for 4_5 & 6_7, and so on.
-		 */
-		const __m512i addr0_1_512 = _mm512_castsi256_si512(addr0_1);
-		const __m512i addr4_5_512 = _mm512_castsi256_si512(addr4_5);
-
-		__m512i addr0_3 = _mm512_inserti64x4(addr0_1_512, addr2_3, 1);
-		__m512i addr4_7 = _mm512_inserti64x4(addr4_5_512, addr6_7, 1);
-
-		/* add headroom to address values */
-		addr0_3 = _mm512_add_epi64(addr0_3, hdroom);
-		addr4_7 = _mm512_add_epi64(addr4_7, hdroom);
-
-#if RTE_IOVA_IN_MBUF
-		/* extract IOVA addr into Packet Buffer Address, erase Header Buffer Address */
-		addr0_3 = _mm512_unpackhi_epi64(addr0_3, zero);
-		addr4_7 = _mm512_unpackhi_epi64(addr4_7, zero);
-#else
-		/* erase Header Buffer Address */
-		addr0_3 = _mm512_unpacklo_epi64(addr0_3, zero);
-		addr4_7 = _mm512_unpacklo_epi64(addr4_7, zero);
-#endif
+			reg0 = _ci_rxq_rearm_desc_avx512(
+					RTE_CAST_PTR(const __m128i *, rxp[0].mbuf),
+					&zero,
+					RTE_CAST_PTR(const __m128i *, rxp[1].mbuf),
+					&zero);
+			reg1 = _ci_rxq_rearm_desc_avx512(
+					RTE_CAST_PTR(const __m128i *, rxp[2].mbuf),
+					&zero,
+					RTE_CAST_PTR(const __m128i *, rxp[3].mbuf),
+					&zero);
+		} else {
+			/* 16-byte descriptor times eight */
+			reg0 = _ci_rxq_rearm_desc_avx512(
+					RTE_CAST_PTR(const __m128i *, rxp[0].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[1].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[2].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[3].mbuf));
+			reg1 = _ci_rxq_rearm_desc_avx512(
+					RTE_CAST_PTR(const __m128i *, rxp[4].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[5].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[6].mbuf),
+					RTE_CAST_PTR(const __m128i *, rxp[7].mbuf));
+		}
 
 		/* flush desc with pa dma_addr */
-		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), addr0_3);
-		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[4]), addr4_7);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[0]), reg0);
+		_mm512_store_si512(RTE_CAST_PTR(__m512i *, &rxdp[desc_per_reg]), reg1);
 	}
 }
 #endif /* __AVX512VL__ */
-#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 /**
  * Rearm the RX queue with new buffers.
@@ -266,7 +311,6 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
 	if (_ci_rxq_rearm_get_bufs(rxq) < 0)
 		return;
 
-#ifdef RTE_NET_INTEL_USE_16BYTE_DESC
 	switch (vec_level) {
 	case CI_RX_VEC_LEVEL_AVX512:
 #ifdef __AVX512VL__
@@ -288,16 +332,6 @@ ci_rxq_rearm(struct ci_rx_queue *rxq, const enum ci_rx_vec_level vec_level)
 		_ci_rxq_rearm_sse(rxq);
 		break;
 	}
-#else
-	/* for 32-byte descriptors only support SSE */
-	switch (vec_level) {
-	case CI_RX_VEC_LEVEL_AVX512:
-	case CI_RX_VEC_LEVEL_AVX2:
-	case CI_RX_VEC_LEVEL_SSE:
-		_ci_rxq_rearm_sse(rxq);
-		break;
-	}
-#endif /* RTE_NET_INTEL_USE_16BYTE_DESC */
 
 	rxq->rxrearm_start += rearm_thresh;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
-- 
2.47.1

