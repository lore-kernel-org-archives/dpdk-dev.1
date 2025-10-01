Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00012CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2078F40B9F;
	Wed,  1 Oct 2025 09:56:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DF20B400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759305390; x=1790841390;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mr5q1J59YwfzBciurPBgFtugejIKGMy3arCLkrmOIb8=;
 b=dujWedcKMtaPCQ3Pcp7kVVNYKCf+jPlr5b3cMNCv0N4Ki7SS3qnqI178
 cf8Q36F/0iXsLAzbQPYsroyS/dOL4TD/Sfmor8cJRW3cxiKaeqYL61jok
 JYmRKldp7dOrWrWyc+YhNhzXTg2hpkdRBH/DGmiMdp6Y9kHrcPSPn/yGf
 hVc1G8+UjTwnb4osVNaXx7jF9T9S383nrQfCnmDfu808BK8i+X41WkTan
 pRPfCuJFqtpML8D6X/B/J/kF94zIla4NpllIJOPycHejJxwrCZUhcmIha
 sTxB9elO4JITJrnvwpXsjEIba43URt8NKqeDw62jQyx4L+EpqWiOgI9Ez w==;
X-CSE-ConnectionGUID: axlCYtQETmydbLLZO6srQg==
X-CSE-MsgGUID: 7TJre+jkRcqfBnQoAjuCPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79222923"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="79222923"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 00:56:29 -0700
X-CSE-ConnectionGUID: T233lkoUQxeENtnDHnTtoQ==
X-CSE-MsgGUID: aPQVICD0S7aFLM/WAJJ86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208";a="183912604"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa005.jf.intel.com with ESMTP; 01 Oct 2025 00:56:28 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 1/2] net/idpf: enable AVX2 for split queue Rx
Date: Wed,  1 Oct 2025 13:26:08 +0530
Message-Id: <20251001075609.2608021-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001075609.2608021-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20251001075609.2608021-1-shaiq.wani@intel.com>
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
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  65 +++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 162 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ------
 5 files changed, 233 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 3b95d519c6..ed459e6f54 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -49,6 +49,7 @@ enum idpf_rx_func_type {
 	IDPF_RX_SINGLEQ,
 	IDPF_RX_SINGLEQ_SCATTERED,
 	IDPF_RX_SINGLEQ_AVX2,
+	IDPF_RX_AVX2,
 	IDPF_RX_AVX512,
 	IDPF_RX_SINGLQ_AVX512,
 	IDPF_RX_MAX
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a2b8c372d6..dfc9d09632 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -5,6 +5,7 @@
 #include <eal_export.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_errno.h>
+#include <rte_vect.h>
 
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
@@ -250,6 +251,63 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 	cq->expected_gen_id = 1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_splitq_rearm_common)
+void
+idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
+{
+	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
+	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
+	uint16_t rx_id;
+	int i;
+
+	rxdp += rx_bufq->rxrearm_start;
+
+	/* Pull 'n' more MBUFs into the software ring */
+	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
+				 (void *)rxp,
+				 IDPF_RXQ_REARM_THRESH) < 0) {
+		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
+		    rx_bufq->nb_rx_desc) {
+			__m128i dma_addr0;
+
+			dma_addr0 = _mm_setzero_si128();
+			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i] = &rx_bufq->fake_mbuf;
+				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
+						dma_addr0);
+			}
+		}
+	rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
+			   IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
+		return;
+	}
+
+	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
+	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
+			i += 8, rxp += 8, rxdp += 8) {
+		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
+		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
+	}
+
+	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
+	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
+		rx_bufq->rxrearm_start = 0;
+
+	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
+
+	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
+			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
+
+	/* Update the tail pointer on the NIC */
+	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
 void
 idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
@@ -1656,6 +1714,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.extra.single_queue = true}},
+	[IDPF_RX_AVX2] = {
+	    .pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
+	    .info = "Split AVX2 Vector",
+	    .features = {
+			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+	       }},
 #ifdef CC_AVX512_SUPPORT
 	[IDPF_RX_AVX512] = {
 		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 3bc3323af4..87f6895c4c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -203,6 +203,8 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
 __rte_internal
+void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
+__rte_internal
 void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_rx_queue_release(void *rxq);
@@ -252,6 +254,9 @@ __rte_internal
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
index 21c8f79254..0837c9cef3 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -482,6 +482,168 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
 
+uint16_t
+idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
+	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
+	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
+	volatile union virtchnl2_rx_desc *rxdp =
+		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
+	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
+
+	rte_prefetch0(rxdp);
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, 4); /* 4 desc per AVX2 iteration */
+
+	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
+		idpf_splitq_rearm_common(queue->bufq2);
+
+	/* head gen check */
+	uint64_t head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
+		return 0;
+
+	uint16_t received = 0;
+
+	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
+	 * layout that will be merged into mbuf->rearm_data candidates.
+	 */
+	const __m256i shuf = _mm256_set_epi8(
+		/* high 128 bits (desc 3 then desc 2 lanes) */
+		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
+		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF,
+		/* low 128 bits (desc 1 then desc 0 lanes) */
+		(char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF, 11, 10, 5, 4,
+		(char)0xFF, (char)0xFF, 5, 4, (char)0xFF, (char)0xFF, (char)0xFF, (char)0xFF
+	);
+
+	/* mask that clears the high 16 bits of packet length word */
+	const __m256i len_mask = _mm256_set_epi32(
+		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
+		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
+	);
+
+	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
+
+	for (uint16_t i = 0; i < nb_pkts;
+		 i += IDPF_VPMD_DESCS_PER_LOOP,
+		 rxdp += IDPF_VPMD_DESCS_PER_LOOP) {
+		/* Step 1: copy 4 mbuf pointers (64-bit each) into rx_pkts[] */
+#ifdef RTE_ARCH_X86_64
+		__m128i ptrs_lo = _mm_loadu_si128((const __m128i *)&sw_ring[i]);
+		__m128i ptrs_hi = _mm_loadu_si128((const __m128i *)&sw_ring[i + 2]);
+		_mm_storeu_si128((__m128i *)&rx_pkts[i], ptrs_lo);
+		_mm_storeu_si128((__m128i *)&rx_pkts[i + 2], ptrs_hi);
+#else
+		for (int j = 0; j < IDPF_VPMD_DESCS_PER_LOOP; ++j)
+			rx_pkts[i + j] = sw_ring[i + j];
+#endif
+		/* Step 2: load four 128-bit descriptors */
+		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
+		rte_compiler_barrier();
+		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
+		rte_compiler_barrier();
+		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
+		rte_compiler_barrier();
+		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
+
+		/* Build 256-bit descriptor-pairs */
+		__m256i d01 = _mm256_set_m128i(d1, d0); /* low lane: d0, d1 */
+		__m256i d23 = _mm256_set_m128i(d3, d2); /* high lane: d2, d3 */
+
+		/* mask off high pkt_len bits  */
+		__m256i desc01 = _mm256_and_si256(d01, len_mask);
+		__m256i desc23 = _mm256_and_si256(d23, len_mask);
+
+		/* Step 3: shuffle relevant bytes into mbuf rearm candidates */
+		__m256i mb01 = _mm256_shuffle_epi8(desc01, shuf);
+		__m256i mb23 = _mm256_shuffle_epi8(desc23, shuf);
+
+		/* Step 4: extract ptypes from descriptors and translate via table */
+		__m256i pt01 = _mm256_and_si256(d01, ptype_mask);
+		__m256i pt23 = _mm256_and_si256(d23, ptype_mask);
+
+		uint16_t ptype0 = (uint16_t)_mm256_extract_epi16(pt01, 1);
+		uint16_t ptype1 = (uint16_t)_mm256_extract_epi16(pt01, 9);
+		uint16_t ptype2 = (uint16_t)_mm256_extract_epi16(pt23, 1);
+		uint16_t ptype3 = (uint16_t)_mm256_extract_epi16(pt23, 9);
+
+		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype1], 2);
+		mb01 = _mm256_insert_epi32(mb01, (int)ptype_tbl[ptype0], 0);
+		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype3], 2);
+		mb23 = _mm256_insert_epi32(mb23, (int)ptype_tbl[ptype2], 0);
+
+		/* Step 5: build rearm vectors */
+		__m128i mb01_lo = _mm256_castsi256_si128(mb01);
+		__m128i mb01_hi = _mm256_extracti128_si256(mb01, 1);
+		__m128i mb23_lo = _mm256_castsi256_si128(mb23);
+		__m128i mb23_hi = _mm256_extracti128_si256(mb23, 1);
+
+		__m256i rearm0 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i(mb01_hi, mb01_lo), 0x20);
+		__m256i rearm1 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i(mb01_hi, mb01_lo), 0xF0);
+		__m256i rearm2 = _mm256_permute2f128_si256(mbuf_init, _mm256_set_m128i(mb23_hi, mb23_lo), 0x20);
+		__m256i rearm3 = _mm256_blend_epi32(mbuf_init, _mm256_set_m128i(mb23_hi, mb23_lo), 0xF0);
+
+		/* Step 6: per-descriptor scalar validity checks */
+		bool valid0 = false, valid1 = false, valid2 = false, valid3 = false;
+		{
+			uint64_t g0 = rxdp[0].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+			uint64_t g1 = rxdp[1].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+			uint64_t g2 = rxdp[2].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+			uint64_t g3 = rxdp[3].flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+
+			bool dd0 = (g0 & 1ULL) != 0ULL;
+			bool dd1 = (g1 & 1ULL) != 0ULL;
+			bool dd2 = (g2 & 1ULL) != 0ULL;
+			bool dd3 = (g3 & 1ULL) != 0ULL;
+
+			uint64_t gen0 = (g0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
+			uint64_t gen1 = (g1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
+			uint64_t gen2 = (g2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
+			uint64_t gen3 = (g3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+						VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M;
+
+			valid0 = dd0 && (gen0 == queue->expected_gen_id);
+			valid1 = dd1 && (gen1 == queue->expected_gen_id);
+			valid2 = dd2 && (gen2 == queue->expected_gen_id);
+			valid3 = dd3 && (gen3 == queue->expected_gen_id);
+		}
+
+		unsigned int mask = (valid0 ? 1U : 0U) | (valid1 ? 2U : 0U)
+					| (valid2 ? 4U : 0U) | (valid3 ? 8U : 0U);
+		uint16_t burst = (uint16_t)__builtin_popcount(mask);
+
+		/* Step 7: store rearm_data only for validated descriptors */
+		if (valid0)
+			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 0]->rearm_data, rearm0);
+		if (valid1)
+			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 1]->rearm_data, rearm1);
+		if (valid2)
+			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
+		if (valid3)
+			_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
+
+		received += burst;
+		if (burst != 4)
+			break;
+	}
+	queue->rx_tail += received;
+	queue->expected_gen_id ^= ((queue->rx_tail & queue->nb_rx_desc) != 0);
+	queue->rx_tail &= (queue->nb_rx_desc - 1);
+	if ((queue->rx_tail & 1) == 1 && received > 1) {
+		queue->rx_tail--;
+		received--;
+	}
+	queue->bufq2->rxrearm_nb += received;
+	return received;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
+
 static inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index bc2cadd738..d3a161c763 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -540,62 +540,6 @@ idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return _idpf_singleq_recv_raw_pkts_avx512(rx_queue, rx_pkts, nb_pkts);
 }
 
-static __rte_always_inline void
-idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq)
-{
-	struct rte_mbuf **rxp = &rx_bufq->sw_ring[rx_bufq->rxrearm_start];
-	volatile union virtchnl2_rx_buf_desc *rxdp = rx_bufq->rx_ring;
-	uint16_t rx_id;
-	int i;
-
-	rxdp += rx_bufq->rxrearm_start;
-
-	/* Pull 'n' more MBUFs into the software ring */
-	if (rte_mbuf_raw_alloc_bulk(rx_bufq->mp,
-				 (void *)rxp,
-				 IDPF_RXQ_REARM_THRESH) < 0) {
-		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
-		    rx_bufq->nb_rx_desc) {
-			__m128i dma_addr0;
-
-			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i] = &rx_bufq->fake_mbuf;
-				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]),
-						dma_addr0);
-			}
-		}
-	rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
-			   IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
-		return;
-	}
-
-	/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-	for (i = 0; i < IDPF_RXQ_REARM_THRESH;
-			i += 8, rxp += 8, rxdp += 8) {
-		rxdp[0].split_rd.pkt_addr = rxp[0]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[1].split_rd.pkt_addr = rxp[1]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[2].split_rd.pkt_addr = rxp[2]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[3].split_rd.pkt_addr = rxp[3]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[4].split_rd.pkt_addr = rxp[4]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[5].split_rd.pkt_addr = rxp[5]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[6].split_rd.pkt_addr = rxp[6]->buf_iova + RTE_PKTMBUF_HEADROOM;
-		rxdp[7].split_rd.pkt_addr = rxp[7]->buf_iova + RTE_PKTMBUF_HEADROOM;
-	}
-
-	rx_bufq->rxrearm_start += IDPF_RXQ_REARM_THRESH;
-	if (rx_bufq->rxrearm_start >= rx_bufq->nb_rx_desc)
-		rx_bufq->rxrearm_start = 0;
-
-	rx_bufq->rxrearm_nb -= IDPF_RXQ_REARM_THRESH;
-
-	rx_id = (uint16_t)((rx_bufq->rxrearm_start == 0) ?
-			     (rx_bufq->nb_rx_desc - 1) : (rx_bufq->rxrearm_start - 1));
-
-	/* Update the tail pointer on the NIC */
-	IDPF_PCI_REG_WRITE(rx_bufq->qrx_tail, rx_id);
-}
-
 static __rte_always_inline void
 idpf_splitq_rearm(struct idpf_rx_queue *rx_bufq)
 {
-- 
2.34.1

