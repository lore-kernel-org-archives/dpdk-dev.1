Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E74CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 05:28:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E112402E3;
	Wed, 17 Sep 2025 07:28:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 67909402C5
 for <dev@dpdk.org>; Wed, 17 Sep 2025 07:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758086878; x=1789622878;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7ejly6XKrAgkzH54UvXf0sL2KCxtiXT5/dRYLPxbGuk=;
 b=ewhzn6W1Ja/y8E0yPBQ/wV1jVVH8zuTCP8CkMW4osIzp1sCwsMd9uJxI
 DGgPo3MMhHyQjDVUt0OcuiNDns1gpmdrsobOJ4IA2GJgo33PYSMx15Gbu
 tIvOpE4tGgFeT/OXKSocQuK7diH2+oGi2coqsfy47lnSvGf86IXXcHFST
 /Oga3A8T3xzKwgnPOA20SyqLuwjXrZRPMeqtqYYBBrwMEcZxJoUR90KGB
 nDzDMOo/bVTuyom7n1nr7DrQZgplCallPkhB2K24g7LLj/d74nzgzdc+n
 h9aKRKPCpVFmirbH8aY6twHZSybM0h5tWK0+AHUYfdDCf4pt/OMAiXs/g w==;
X-CSE-ConnectionGUID: tAeEHFAKQti6ZzemCCu4bA==
X-CSE-MsgGUID: SbviSP5NRsuXo4tHTeWQdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60250209"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60250209"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 22:27:57 -0700
X-CSE-ConnectionGUID: vWBNjuRPQlq+1ar7/oAldA==
X-CSE-MsgGUID: QL3sfxyiQw2wZg+eBCu3PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="206101434"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa001.fm.intel.com with ESMTP; 16 Sep 2025 22:27:55 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 2/2] net/idpf: enable AVX2 for split queue Rx
Date: Wed, 17 Sep 2025 10:56:58 +0530
Message-Id: <20250917052658.582872-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917052658.582872-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 246 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c            |  11 +-
 3 files changed, 258 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 82ddcf3310..d7c0e91256 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -242,6 +242,9 @@ __rte_internal
 uint16_t idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 					 uint16_t nb_pkts);
 __rte_internal
+uint16_t idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts,
+				     uint16_t nb_pkts);
+__rte_internal
 uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts);
 __rte_internal
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index d0c37cbfc7..cef13b3249 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -482,6 +482,252 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
 
+static __rte_always_inline void
+idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
+{
+	int i;
+	uint16_t rx_id;
+	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
+	struct rte_mbuf **rxep = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
+
+	rxdp += rx_bufq->rxrearm_start;
+
+	/* Try to bulk allocate mbufs from mempool */
+	if (rte_mempool_get_bulk(rx_bufq->mp,
+				(void **)rxep,
+				IDPF_RXQ_REARM_THRESH) < 0) {
+		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >= rx_bufq->nb_rx_desc) {
+			__m128i zero_dma = _mm_setzero_si128();
+
+			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
+				rxep[i] = &rx_bufq->fake_mbuf;
+				_mm_storeu_si128((__m128i *)(uintptr_t)&rxdp[i], zero_dma);
+			}
+		}
+			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
+							IDPF_RXQ_REARM_THRESH,
+							rte_memory_order_relaxed);
+		return;
+	}
+
+	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
+
+	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += 2, rxep += 2, rxdp += 2) {
+		struct rte_mbuf *mb0 = rxep[0];
+		struct rte_mbuf *mb1 = rxep[1];
+
+		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+
+		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
+		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
+
+		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
+		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
+
+		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
+		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
+	}
+
+	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
+	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
+		rx_bufq->rxrearm_start = 0;
+
+	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
+
+	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
+			(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
+
+	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
+}
+
+static __rte_always_inline void
+idpf_splitq_rearm_avx2(struct idpf_rx_queue *rx_bufq)
+{
+	int i;
+	uint16_t rx_id;
+	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
+	struct rte_mempool_cache *cache =
+		rte_mempool_default_cache(rx_bufq->mp, rte_lcore_id());
+	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
+
+	rxdp += rx_bufq->rxrearm_start;
+
+	if (unlikely(!cache)) {
+		idpf_splitq_rearm_common(rx_bufq);
+		return;
+	}
+
+	if (cache->len < IDPF_RXQ_REARM_THRESH) {
+		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size - cache->len);
+		int ret = rte_mempool_ops_dequeue_bulk(rx_bufq->mp,
+						&cache->objs[cache->len], req);
+		if (ret == 0) {
+			cache->len += req;
+		} else {
+			if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
+				rx_bufq->nb_rx_desc) {
+				__m128i dma_addr0 = _mm_setzero_si128();
+				for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
+					rxp[i] = &rx_bufq->fake_mbuf;
+					_mm_storeu_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
+					dma_addr0);
+				}
+			}
+			rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
+				IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
+			return;
+		}
+	}
+	__m128i headroom = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM, RTE_PKTMBUF_HEADROOM);
+	const int step = 2;
+
+	for (i = 0; i < IDPF_RXQ_REARM_THRESH; i += step, rxp += step, rxdp += step) {
+		struct rte_mbuf *mb0 = (struct rte_mbuf *)cache->objs[--cache->len];
+		struct rte_mbuf *mb1 = (struct rte_mbuf *)cache->objs[--cache->len];
+		rxp[0] = mb0;
+		rxp[1] = mb1;
+
+		__m128i buf_addr0 = _mm_loadu_si128((__m128i *)&mb0->buf_addr);
+		__m128i buf_addr1 = _mm_loadu_si128((__m128i *)&mb1->buf_addr);
+
+		__m128i dma_addr0 = _mm_unpackhi_epi64(buf_addr0, buf_addr0);
+		__m128i dma_addr1 = _mm_unpackhi_epi64(buf_addr1, buf_addr1);
+
+		dma_addr0 = _mm_add_epi64(dma_addr0, headroom);
+		dma_addr1 = _mm_add_epi64(dma_addr1, headroom);
+
+		rxdp[0].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr0);
+		rxdp[1].split_rd.pkt_addr = _mm_cvtsi128_si64(dma_addr1);
+	}
+
+	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
+	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
+		rx_bufq->rxrearm_start = 0;
+
+	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
+
+	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
+				(rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
+
+	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
+}
+static __rte_always_inline uint16_t
+_idpf_splitq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq,
+					struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	const uint32_t *ptype_tbl = rxq->adapter->ptype_tbl;
+	struct rte_mbuf **sw_ring = &rxq->bufq2->sw_ring[rxq->rx_tail];
+	volatile union virtchnl2_rx_desc *rxdp =
+		(volatile union virtchnl2_rx_desc *)rxq->rx_ring + rxq->rx_tail;
+
+	rte_prefetch0(rxdp);
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
+
+	if (rxq->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
+		idpf_splitq_rearm_avx2(rxq->bufq2);
+
+	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != rxq->expected_gen_id)
+		return 0;
+
+	const __m128i gen_mask =
+		_mm_set1_epi64x(((uint64_t)rxq->expected_gen_id) << 46);
+
+	uint16_t received = 0;
+	for (uint16_t i = 0; i < nb_pkts; i += 4, rxdp += 4) {
+		/* Step 1: pull mbufs */
+		__m128i ptrs = _mm_loadu_si128((__m128i *)&sw_ring[i]);
+		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs);
+
+		/* Step 2: load descriptors */
+		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
+		rte_compiler_barrier();
+		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
+		rte_compiler_barrier();
+		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
+		rte_compiler_barrier();
+		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
+
+		/* Step 3: shuffle out pkt_len, data_len, vlan, rss */
+		const __m256i shuf = _mm256_set_epi8(
+			/* descriptor 3 */
+			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
+			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
+			/* descriptor 2 */
+			0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
+			0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
+		);
+		__m128i d01_lo = d0, d01_hi = d1;
+		__m128i d23_lo = d2, d23_hi = d3;
+
+		__m256i m23 = _mm256_shuffle_epi8(_mm256_set_m128i(d23_hi, d23_lo), shuf);
+		__m256i m01 = _mm256_shuffle_epi8(_mm256_set_m128i(d01_hi, d01_lo), shuf);
+
+		/* Step 4: extract ptypes */
+		const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
+		__m256i pt23 = _mm256_and_si256(_mm256_set_m128i(d23_hi, d23_lo), ptype_mask);
+		__m256i pt01 = _mm256_and_si256(_mm256_set_m128i(d01_hi, d01_lo), ptype_mask);
+
+		uint16_t ptype2 = _mm256_extract_epi16(pt23, 1);
+		uint16_t ptype3 = _mm256_extract_epi16(pt23, 9);
+		uint16_t ptype0 = _mm256_extract_epi16(pt01, 1);
+		uint16_t ptype1 = _mm256_extract_epi16(pt01, 9);
+
+		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype3], 2);
+		m23 = _mm256_insert_epi32(m23, ptype_tbl[ptype2], 0);
+		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype1], 2);
+		m01 = _mm256_insert_epi32(m01, ptype_tbl[ptype0], 0);
+
+		/* Step 5: extract gen bits */
+		__m128i sts0 = _mm_srli_epi64(d0, 46);
+		__m128i sts1 = _mm_srli_epi64(d1, 46);
+		__m128i sts2 = _mm_srli_epi64(d2, 46);
+		__m128i sts3 = _mm_srli_epi64(d3, 46);
+
+		__m128i merged_lo = _mm_unpacklo_epi64(sts0, sts2);
+		__m128i merged_hi = _mm_unpacklo_epi64(sts1, sts3);
+		__m128i valid = _mm_and_si128(_mm_and_si128(merged_lo, merged_hi),
+						  _mm_unpacklo_epi64(gen_mask, gen_mask));
+		__m128i cmp = _mm_cmpeq_epi64(valid, _mm_unpacklo_epi64(gen_mask, gen_mask));
+		int burst = _mm_movemask_pd(_mm_castsi128_pd(cmp));
+
+		/* Step 6: write rearm_data safely */
+		__m128i m01_lo = _mm256_castsi256_si128(m01);
+		__m128i m23_lo = _mm256_castsi256_si128(m23);
+
+		*(uint64_t *)&rx_pkts[i]->rearm_data = _mm_extract_epi64(m01_lo, 0);
+		*(uint64_t *)&rx_pkts[i + 1]->rearm_data = _mm_extract_epi64(m01_lo, 1);
+		*(uint64_t *)&rx_pkts[i + 2]->rearm_data = _mm_extract_epi64(m23_lo, 0);
+		*(uint64_t *)&rx_pkts[i + 3]->rearm_data = _mm_extract_epi64(m23_lo, 1);
+
+		received += burst;
+		if (burst != 4)
+			break;
+	}
+
+	rxq->rx_tail += received;
+	if (received & 1) {
+		rxq->rx_tail &= ~(uint16_t)1;
+		received--;
+	}
+	rxq->rx_tail &= (rxq->nb_rx_desc - 1);
+	rxq->expected_gen_id ^= ((rxq->rx_tail & rxq->nb_rx_desc) != 0);
+	rxq->bufq2->rxrearm_nb += received;
+
+	return received;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
+uint16_t
+idpf_dp_splitq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
+				 uint16_t nb_pkts)
+{
+	return _idpf_splitq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
+}
+
+
 static inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 7d5d8b9c48..413902ca21 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -803,10 +803,17 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (vport->rx_use_avx2) {
+				PMD_DRV_LOG(NOTICE,
+						"Using Split AVX2 Vector Rx (port %d).",
+						dev->data->port_id);
+				dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts_avx2;
+				return;
+			}
 		}
 		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Rx (port %d).",
-			    dev->data->port_id);
+				"Using Split Scalar Rx (port %d).",
+				dev->data->port_id);
 		dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts;
 	} else {
 		if (vport->rx_vec_allowed) {
-- 
2.34.1

