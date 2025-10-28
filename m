Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E1CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 05:29:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B740C402D6;
	Tue, 28 Oct 2025 06:29:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id AEC7A4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761629389; x=1793165389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iK58rMbdCqfoQBQRbvDn++QIX3VO4NXickjHYXTdxNo=;
 b=DXcEjh1ILCSBDPegVhMqZm1en6M0DH+Lf29Equ0ofku7XkVVPtKjS1m0
 Lg7O3XXsynBuEFhU1N/+Svwkc4dI8QlS70bLwJz6r5GPQRjXQmKF+CYaX
 ipOC7MnPeeHwR+9bCfgG/EsBKXNtjvrwB5jrqq1PBpQi7bdS3iAog98Na
 xjJU2iSEKm/z3v+tEtVheT07I3SX25DQ4mHtv8dc0MuELpH5qy3445rE4
 h5gqq39RIDChzCQDo7+E0CRxwUSDYFbKDRGS+Iqt14Oxg5/rNrqDREj98
 ukie4odnCyN1GuymePzZHefhMvLthruSnBczJj22VkAUCpdKcXqfJe866 Q==;
X-CSE-ConnectionGUID: OV9Dam7hRsyWd5bx4WoW1Q==
X-CSE-MsgGUID: NH3GI2RqQZ+etpMDgv2AtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86346430"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="86346430"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 22:29:49 -0700
X-CSE-ConnectionGUID: 1BJsl+WLTequhFDg16bA0w==
X-CSE-MsgGUID: sNsiWjN1TcGjJZXhT2PINg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="215904146"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa002.jf.intel.com with ESMTP; 27 Oct 2025 22:29:48 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v9 1/3] net/idpf: enable AVX2 for split queue Rx
Date: Tue, 28 Oct 2025 10:59:41 +0530
Message-Id: <20251028052943.121453-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028052943.121453-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028052943.121453-1-shaiq.wani@intel.com>
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
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 +++++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   5 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 121 ++++++++++++++++++
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 --------
 5 files changed, 186 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index c32dcfbb12..74a5495d59 100644
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
index a5d0795057..ab3d088899 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -250,6 +250,58 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
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
@@ -1684,6 +1736,13 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
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
index 21c8f79254..e78a453a8b 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -482,6 +482,127 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
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
+
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
+	for (int i = nb_pkts; i >= IDPF_VPMD_DESCS_PER_LOOP; i -= IDPF_VPMD_DESCS_PER_LOOP) {
+		rxdp -= IDPF_VPMD_DESCS_PER_LOOP;
+
+	  /* Check DD bits */
+		bool dd0 = (rxdp[0].flex_adv_nic_3_wb.status_err0_qw1 &
+				(1U << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_DD_S)) != 0;
+		bool dd1 = (rxdp[1].flex_adv_nic_3_wb.status_err0_qw1 &
+				(1U << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_DD_S)) != 0;
+		bool dd2 = (rxdp[2].flex_adv_nic_3_wb.status_err0_qw1 &
+				(1U << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_DD_S)) != 0;
+		bool dd3 = (rxdp[3].flex_adv_nic_3_wb.status_err0_qw1 &
+				(1U << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_DD_S)) != 0;
+
+		if (!(dd0 && dd1 && dd2 && dd3))
+			break;
+
+		/* copy mbuf pointers */
+		memcpy(&rx_pkts[i - IDPF_VPMD_DESCS_PER_LOOP],
+			&sw_ring[i - IDPF_VPMD_DESCS_PER_LOOP],
+			sizeof(rx_pkts[0]) * IDPF_VPMD_DESCS_PER_LOOP);
+
+		__m128i d3 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[3]));
+		__m128i d2 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[2]));
+		__m128i d1 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[1]));
+		__m128i d0 = _mm_load_si128(RTE_CAST_PTR(const __m128i *, &rxdp[0]));
+
+		__m256i d23 = _mm256_set_m128i(d3, d2);
+		__m256i d01 = _mm256_set_m128i(d1, d0);
+
+		/* mask length and shuffle to build mbuf rearm data */
+		__m256i desc01 = _mm256_and_si256(d01, len_mask);
+		__m256i desc23 = _mm256_and_si256(d23, len_mask);
+		__m256i mb01 = _mm256_shuffle_epi8(desc01, shuf);
+		__m256i mb23 = _mm256_shuffle_epi8(desc23, shuf);
+
+		/* ptype extraction */
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
+		/* build rearm data for each mbuf */
+		__m256i rearm0 = _mm256_permute2f128_si256(mbuf_init, mb01, 0x20);
+		__m256i rearm1 = _mm256_blend_epi32(mbuf_init, mb01, 0xF0);
+		__m256i rearm2 = _mm256_permute2f128_si256(mbuf_init, mb23, 0x20);
+		__m256i rearm3 = _mm256_blend_epi32(mbuf_init, mb23, 0xF0);
+
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 4]->rearm_data, rearm0);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 3]->rearm_data, rearm1);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 2]->rearm_data, rearm2);
+		_mm256_storeu_si256((__m256i *)&rx_pkts[i - 1]->rearm_data, rearm3);
+
+		received += IDPF_VPMD_DESCS_PER_LOOP;
+	}
+
+queue->rx_tail += received;
+queue->expected_gen_id ^= ((queue->rx_tail & queue->nb_rx_desc) != 0);
+queue->rx_tail &= (queue->nb_rx_desc - 1);
+if ((queue->rx_tail & 1) == 1 && received > 1) {
+	queue->rx_tail--;
+	received--;
+}
+queue->bufq2->rxrearm_nb += received;
+return received;
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

