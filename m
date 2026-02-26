Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FDCFC5913
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0A62402EF;
	Thu, 26 Feb 2026 10:45:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D9EE1400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:45:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772099148; x=1803635148;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xfmZBHAYZ3rh+aKR73Xkzzo5RKHQltycuuqVEgGmrX8=;
 b=lWjZYUwSDNXYODXxQlf1Wpv/LM3uPpF3OLuIm1AqHMQ4SaP430fqWCmp
 IvmTcCvUHCJZyYDgOETiGno2e2qln9reVRD/B86bh/tqsYEOJAqGevmKe
 y23K6WPypaEkI0Wh2P8rZKr6qJGmItXTH5cSpL+5eGLrAC5dDaz15s47P
 lMphUH8k0ipg+wkkLQe5VDQNgCOpICzQZ8as5E7o9d6F2RMro3IGBWi4I
 QHZCzOGilBkvlb9LAWSyvjlZhZ1UYujllWNmtHRcWd/s4dZPMDzOaQvzi
 DjX6hGiywgEN/4wwweQmbrViSR9oIAMVxn9JEe5JW9szAlaFiko2P4RlK Q==;
X-CSE-ConnectionGUID: erYFTyyNTKGfQSFpWou0+A==
X-CSE-MsgGUID: Q6nz1L2sR0SqRsoyzBPaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73259094"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73259094"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 01:45:48 -0800
X-CSE-ConnectionGUID: lsQCIDVHS7CJn9Ig+1k2cw==
X-CSE-MsgGUID: eR7kfVl/SIC/TtRQsTWlXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="221021306"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2026 01:45:46 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v14 1/3] net/idpf: enable AVX2 for split queue Rx
Date: Thu, 26 Feb 2026 15:12:20 +0530
Message-Id: <20260226094222.1393288-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226094222.1393288-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260226094222.1393288-1-shaiq.wani@intel.com>
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

Add AVX2 vectorized split queue Rx path.
In case some CPUs don't support AVX512. Enable AVX2 for
them to get better per-core performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 +++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 151 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 -------
 5 files changed, 216 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index bbc969c734..1424046a16 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -70,6 +70,7 @@ enum idpf_rx_func_type {
 	IDPF_RX_SINGLEQ,
 	IDPF_RX_SINGLEQ_SCATTERED,
 	IDPF_RX_SINGLEQ_AVX2,
+	IDPF_RX_AVX2,
 	IDPF_RX_AVX512,
 	IDPF_RX_SINGLEQ_AVX512,
 	IDPF_RX_MAX
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index b8f6418d4a..ead31fd0f8 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -253,6 +253,58 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
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
+			(void *)rxp, IDPF_RXQ_REARM_THRESH) < 0) {
+		if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
+				rx_bufq->nb_rx_desc) {
+			for (i = 0; i < IDPF_VPMD_DESCS_PER_LOOP; i++) {
+				rxp[i] = &rx_bufq->fake_mbuf;
+				rxdp[i] = (union virtchnl2_rx_buf_desc){0};
+			}
+		}
+		rte_atomic_fetch_add_explicit(&rx_bufq->rx_stats.mbuf_alloc_failed,
+			IDPF_RXQ_REARM_THRESH, rte_memory_order_relaxed);
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
@@ -1506,6 +1558,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
 			.single_queue = true}},
+	[IDPF_RX_AVX2] = {
+		.pkt_burst = idpf_dp_splitq_recv_pkts_avx2,
+		.info = "Split AVX2 Vector",
+		.features = {
+			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			}},
 #ifdef CC_AVX512_SUPPORT
 	[IDPF_RX_AVX512] = {
 		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 914cab0f25..256e9ff54c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -197,6 +197,8 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq);
 __rte_internal
+void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
+__rte_internal
 void idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_rx_queue_release(void *rxq);
@@ -249,6 +251,9 @@ __rte_internal
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
index e228b72fa5..0122c82951 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -482,6 +482,157 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx2)
+uint16_t
+idpf_dp_splitq_recv_pkts_avx2(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct idpf_rx_queue *queue = (struct idpf_rx_queue *)rxq;
+	const uint32_t *ptype_tbl = queue->adapter->ptype_tbl;
+	struct rte_mbuf **sw_ring = &queue->bufq2->sw_ring[queue->rx_tail];
+	volatile union virtchnl2_rx_desc *rxdp =
+		(volatile union virtchnl2_rx_desc *)queue->rx_ring + queue->rx_tail;
+	const __m256i mbuf_init = _mm256_set_epi64x(0, 0, 0, queue->mbuf_initializer);
+	uint64_t head_gen;
+	uint16_t received = 0;
+	int i;
+
+	/* Shuffle mask: picks fields from each 16-byte descriptor pair into the
+	 * layout that will be merged into mbuf->rearm_data candidates.
+	 */
+	const __m256i shuf = _mm256_set_epi8(
+		/* high 128 bits (desc 3 then desc 2 lanes) */
+		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
+		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF,
+		/* low 128 bits (desc 1 then desc 0 lanes) */
+		0xFF, 0xFF, 0xFF, 0xFF, 11, 10, 5, 4,
+		0xFF, 0xFF, 5, 4, 0xFF, 0xFF, 0xFF, 0xFF
+	);
+
+	/* mask that clears bits 14 and 15 of the packet length word  */
+	const __m256i len_mask = _mm256_set_epi32(
+		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff,
+		0xffffffff, 0xffffffff, 0xffff3fff, 0xffffffff
+	);
+
+	const __m256i ptype_mask = _mm256_set1_epi16(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M);
+
+	rte_prefetch0(rxdp);
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IDPF_VPMD_DESCS_PER_LOOP);
+
+	if (queue->bufq2->rxrearm_nb > IDPF_RXQ_REARM_THRESH)
+		idpf_splitq_rearm_common(queue->bufq2);
+
+	/* check if there is at least one packet available */
+	head_gen = rxdp->flex_adv_nic_3_wb.pktlen_gen_bufq_id;
+	if (((head_gen >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+		 VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) != queue->expected_gen_id)
+		return 0;
+
+	for (i = 0; i < nb_pkts;
+	     i += IDPF_VPMD_DESCS_PER_LOOP,
+	     rxdp += IDPF_VPMD_DESCS_PER_LOOP) {
+		uint16_t pktlen_gen0, pktlen_gen1, pktlen_gen2, pktlen_gen3;
+		uint8_t stat0, stat1, stat2, stat3;
+		bool valid0, valid1, valid2, valid3;
+		uint16_t burst;
+		uint16_t ptype0, ptype1, ptype2, ptype3;
+		__m128i d0, d1, d2, d3;
+		__m256i d01, d23, desc01, desc23;
+		__m256i mb10, mb32, pt10, pt32;
+		__m256i rearm0, rearm1, rearm2, rearm3;
+
+		/* copy mbuf pointers (harmless for invalid descs) */
+		memcpy(&rx_pkts[i], &sw_ring[i],
+			sizeof(rx_pkts[0]) * IDPF_VPMD_DESCS_PER_LOOP);
+		d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
+		rte_compiler_barrier();
+		d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
+		rte_compiler_barrier();
+		d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
+		rte_compiler_barrier();
+		d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
+
+		d23 = _mm256_set_m128i(d3, d2);
+		d01 = _mm256_set_m128i(d1, d0);
+
+		/* mask length and shuffle to build mbuf rearm data */
+		desc01 = _mm256_and_si256(d01, len_mask);
+		desc23 = _mm256_and_si256(d23, len_mask);
+		mb10 = _mm256_shuffle_epi8(desc01, shuf);
+		mb32 = _mm256_shuffle_epi8(desc23, shuf);
+
+		/* Extract ptypes */
+		pt10 = _mm256_and_si256(d01, ptype_mask);
+		pt32 = _mm256_and_si256(d23, ptype_mask);
+
+		ptype0 = (uint16_t)_mm256_extract_epi16(pt10, 1);
+		ptype1 = (uint16_t)_mm256_extract_epi16(pt10, 9);
+		ptype2 = (uint16_t)_mm256_extract_epi16(pt32, 1);
+		ptype3 = (uint16_t)_mm256_extract_epi16(pt32, 9);
+
+		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype1], 2);
+		mb10 = _mm256_insert_epi32(mb10, (int)ptype_tbl[ptype0], 0);
+		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype3], 2);
+		mb32 = _mm256_insert_epi32(mb32, (int)ptype_tbl[ptype2], 0);
+
+		/* Build rearm data for each mbuf */
+		rearm0 = _mm256_permute2f128_si256(mbuf_init, mb10, 0x20);
+		rearm1 = _mm256_blend_epi32(mbuf_init, mb10, 0xF0);
+		rearm2 = _mm256_permute2f128_si256(mbuf_init, mb32, 0x20);
+		rearm3 = _mm256_blend_epi32(mbuf_init, mb32, 0xF0);
+
+		/* Write out mbuf rearm data */
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 0]->rearm_data, rearm0);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 1]->rearm_data, rearm1);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 2]->rearm_data, rearm2);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i + 3]->rearm_data, rearm3);
+
+		/* Extract DD and generation bits from the already-loaded
+		 * descriptor data (d0-d3) */
+		stat0 = (uint8_t)_mm_extract_epi8(d0, 1);
+		stat1 = (uint8_t)_mm_extract_epi8(d1, 1);
+		stat2 = (uint8_t)_mm_extract_epi8(d2, 1);
+		stat3 = (uint8_t)_mm_extract_epi8(d3, 1);
+
+		pktlen_gen0 = (uint16_t)_mm_extract_epi16(d0, 2);
+		pktlen_gen1 = (uint16_t)_mm_extract_epi16(d1, 2);
+		pktlen_gen2 = (uint16_t)_mm_extract_epi16(d2, 2);
+		pktlen_gen3 = (uint16_t)_mm_extract_epi16(d3, 2);
+
+		valid0 = (stat0 & 1) &&
+			 (((pktlen_gen0 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+		valid1 = (stat1 & 1) &&
+			 (((pktlen_gen1 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+		valid2 = (stat2 & 1) &&
+			 (((pktlen_gen2 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+		valid3 = (stat3 & 1) &&
+			 (((pktlen_gen3 >> VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S) &
+			   VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) == queue->expected_gen_id);
+
+		/* count valid descriptors (holes are impossible because
+		 * descriptors are read in reverse order while the NIC
+		 * completes them in forward order)
+		 */
+		burst = valid0 + valid1 + valid2 + valid3;
+		received += burst;
+		if (burst != IDPF_VPMD_DESCS_PER_LOOP)
+			break;
+	}
+
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
 static inline void
 idpf_singleq_vtx1(volatile struct ci_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index fe870617bc..eda5f929cf 100644
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

