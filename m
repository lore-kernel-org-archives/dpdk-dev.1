Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FBAC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:14:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 666114278A;
	Thu, 12 Jun 2025 13:12:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7E456410ED
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726750; x=1781262750;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lp/k/YJJCIOp8AMZSGV3S26/vp7230O3azGVvZ9kVk8=;
 b=SrbcL1yZevy+Smpe/mbJLgJLUjbgJ0NVouZcXb4PZdjC4w7+rWyquMsY
 CTwU6jlGRcakPkhLbijY9M6NC+MFkjTrtI3tK1ldDQV6QJnY58wAKnMfD
 WPm0Yk7ky68v03/KUNs8d1gTqBqLplJIHJvBFiavegzgl1vjLBLUya3Hf
 AU5tWOKbYMsdEPt66mmO37S4+1X1R2dHCFX1dSaQd2N5Lg8j86OVdXICY
 ne/TDADDPfCp9tvm+7944pxaI5CNnuX8Q4c6WXy/H3r814ho+J7tL3aTU
 he8IOVJ2gdkaJ2RYoZmpPzdVAh5GWB1KqwDkcRFPQu/AqYKBuDF2Bxgn3 A==;
X-CSE-ConnectionGUID: oC+Dg4+gRdaHRks2k1ox1g==
X-CSE-MsgGUID: ZnEUa4K0S+mBcqlH0nTCUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177583"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177583"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:30 -0700
X-CSE-ConnectionGUID: HcwjwicZTBWpA8L8ya3NnQ==
X-CSE-MsgGUID: yqKaxpW/SYO8BHMaG96nng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371369"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 21/33] net/ice: clean up definitions
Date: Thu, 12 Jun 2025 12:11:27 +0100
Message-ID: <5a096d4b422ae8dff322d02285c268b299625e07.1749726639.git.anatoly.burakov@intel.com>
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

This commit does the following cleanups:

- Mark vector-PMD related definitions with ICE_VPMD_ prefix
- Remove unused definitions
- Create "descriptors per loop" for different vector implementations
  (regular for SSE, Neon, wide for AVX2, AVX512)

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ice/ice_rxtx.h            |  6 ++--
 drivers/net/intel/ice/ice_rxtx_common_avx.h | 18 +++++-----
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++-------
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 30 ++++++++--------
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    | 40 ++++++++++-----------
 5 files changed, 57 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index d2d521c4f5..52c753ba7c 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -35,10 +35,10 @@
 
 #define ICE_VPMD_RX_BURST           32
 #define ICE_VPMD_TX_BURST           32
-#define ICE_RXQ_REARM_THRESH        64
-#define ICE_MAX_RX_BURST            ICE_RXQ_REARM_THRESH
+#define ICE_VPMD_RXQ_REARM_THRESH   64
 #define ICE_TX_MAX_FREE_BUF_SZ      64
-#define ICE_DESCS_PER_LOOP          4
+#define ICE_VPMD_DESCS_PER_LOOP      4
+#define ICE_VPMD_DESCS_PER_LOOP_WIDE 8
 
 #define ICE_FDIR_PKT_LEN	512
 
diff --git a/drivers/net/intel/ice/ice_rxtx_common_avx.h b/drivers/net/intel/ice/ice_rxtx_common_avx.h
index a68cf8512d..d1c772bf06 100644
--- a/drivers/net/intel/ice/ice_rxtx_common_avx.h
+++ b/drivers/net/intel/ice/ice_rxtx_common_avx.h
@@ -21,20 +21,20 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 ICE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_RXQ_REARM_THRESH >=
+				 ICE_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + ICE_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			__m128i dma_addr0;
 
 			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < ICE_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_RXQ_REARM_THRESH;
+			ICE_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
@@ -44,7 +44,7 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxep[0].mbuf;
@@ -84,7 +84,7 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 		__m512i dma_addr0_3, dma_addr4_7;
 		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < ICE_RXQ_REARM_THRESH;
+		for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH;
 				i += 8, rxep += 8, rxdp += 8) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
@@ -163,7 +163,7 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 		__m256i dma_addr0_1, dma_addr2_3;
 		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < ICE_RXQ_REARM_THRESH;
+		for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH;
 				i += 4, rxep += 4, rxdp += 4) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m256i vaddr0_1, vaddr2_3;
@@ -216,11 +216,11 @@ ice_rxq_rearm_common(struct ice_rx_queue *rxq, __rte_unused bool avx512)
 
 #endif
 
-	rxq->rxrearm_start += ICE_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += ICE_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= ICE_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= ICE_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 6fe5ffa6f4..5ed669fc30 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -37,8 +37,6 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			    uint16_t nb_pkts, uint8_t *split_packet,
 			    bool offload)
 {
-#define ICE_DESCS_PER_LOOP_AVX 8
-
 	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
@@ -48,13 +46,13 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to ICE_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to ICE_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > ICE_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > ICE_VPMD_RXQ_REARM_THRESH)
 		ice_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -239,8 +237,8 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += ICE_DESCS_PER_LOOP_AVX,
-	     rxdp += ICE_DESCS_PER_LOOP_AVX) {
+	     i += ICE_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += ICE_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -286,7 +284,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < ICE_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < ICE_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -634,7 +632,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += ICE_DESCS_PER_LOOP_AVX;
+			split_packet += ICE_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -650,7 +648,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != ICE_DESCS_PER_LOOP_AVX)
+		if (burst != ICE_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -667,7 +665,7 @@ _ice_recv_raw_pkts_vec_avx2(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 /**
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 ice_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -688,7 +686,7 @@ ice_recv_pkts_vec_avx2_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
 /**
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static __rte_always_inline uint16_t
 ice_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -730,7 +728,7 @@ ice_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles scattered packets.
  * Main receive routine that can handle arbitrary burst sizes
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static __rte_always_inline uint16_t
 ice_recv_scattered_pkts_vec_avx2_common(void *rx_queue,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index 490d1ae059..e52e9e9ceb 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -7,8 +7,6 @@
 
 #include <rte_vect.h>
 
-#define ICE_DESCS_PER_LOOP_AVX 8
-
 static __rte_always_inline void
 ice_rxq_rearm(struct ice_rx_queue *rxq)
 {
@@ -49,13 +47,13 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to ICE_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to ICE_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > ICE_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > ICE_VPMD_RXQ_REARM_THRESH)
 		ice_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -224,8 +222,8 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += ICE_DESCS_PER_LOOP_AVX,
-	     rxdp += ICE_DESCS_PER_LOOP_AVX) {
+	     i += ICE_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += ICE_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -292,7 +290,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < ICE_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < ICE_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -660,7 +658,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += ICE_DESCS_PER_LOOP_AVX;
+			split_packet += ICE_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -676,7 +674,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != ICE_DESCS_PER_LOOP_AVX)
+		if (burst != ICE_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -693,7 +691,7 @@ _ice_recv_raw_pkts_vec_avx512(struct ice_rx_queue *rxq,
 
 /**
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 ice_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -704,7 +702,7 @@ ice_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 /**
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 ice_recv_pkts_vec_avx512_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -717,7 +715,7 @@ ice_recv_pkts_vec_avx512_offload(void *rx_queue, struct rte_mbuf **rx_pkts,
 /**
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 ice_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -758,7 +756,7 @@ ice_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 /**
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 ice_recv_scattered_burst_vec_avx512_offload(void *rx_queue,
@@ -801,7 +799,7 @@ ice_recv_scattered_burst_vec_avx512_offload(void *rx_queue,
  * vPMD receive routine that reassembles scattered packets.
  * Main receive routine that can handle arbitrary burst sizes
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 ice_recv_scattered_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -825,7 +823,7 @@ ice_recv_scattered_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles scattered packets.
  * Main receive routine that can handle arbitrary burst sizes
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 ice_recv_scattered_pkts_vec_avx512_offload(void *rx_queue,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index 719b37645e..36da5b5d1b 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -42,23 +42,23 @@ ice_rxq_rearm(struct ice_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 ICE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + ICE_RXQ_REARM_THRESH >=
+				 ICE_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + ICE_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < ICE_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < ICE_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			ICE_RXQ_REARM_THRESH;
+			ICE_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < ICE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < ICE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxep[0].mbuf;
@@ -91,11 +91,11 @@ ice_rxq_rearm(struct ice_rx_queue *rxq)
 		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += ICE_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += ICE_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= ICE_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= ICE_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
 			   (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
@@ -294,11 +294,11 @@ ice_rx_desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= ICE_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= ICE_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a ICE_DESCS_PER_LOOP power-of-two
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a ICE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
@@ -355,8 +355,8 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	const __m128i eop_check = _mm_set_epi64x(0x0000000200000002LL,
 						 0x0000000200000002LL);
 
-	/* nb_pkts has to be floor-aligned to ICE_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to ICE_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -368,7 +368,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > ICE_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > ICE_VPMD_RXQ_REARM_THRESH)
 		ice_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -406,9 +406,9 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 */
 
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-	     pos += ICE_DESCS_PER_LOOP,
-	     rxdp += ICE_DESCS_PER_LOOP) {
-		__m128i descs[ICE_DESCS_PER_LOOP];
+	     pos += ICE_VPMD_DESCS_PER_LOOP,
+	     rxdp += ICE_VPMD_DESCS_PER_LOOP) {
+		__m128i descs[ICE_VPMD_DESCS_PER_LOOP];
 		__m128i pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
 		__m128i staterr, sterr_tmp1, sterr_tmp2;
 		/* 2 64 bit or 4 32 bit mbuf pointers in one XMM reg. */
@@ -556,7 +556,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
 			/* store the resulting 32-bit value */
 			*(int *)split_packet = _mm_cvtsi128_si32(eop_bits);
-			split_packet += ICE_DESCS_PER_LOOP;
+			split_packet += ICE_VPMD_DESCS_PER_LOOP;
 		}
 
 		/* C.3 calc available number of desc */
@@ -573,7 +573,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		/* C.4 calc available number of desc */
 		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
 		nb_pkts_recd += var;
-		if (likely(var != ICE_DESCS_PER_LOOP))
+		if (likely(var != ICE_VPMD_DESCS_PER_LOOP))
 			break;
 	}
 
@@ -587,7 +587,7 @@ _ice_recv_raw_pkts_vec(struct ice_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 /**
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  * - nb_pkts > ICE_VPMD_RX_BURST, only scan ICE_VPMD_RX_BURST
  *   numbers of DD bits
  */
@@ -602,7 +602,7 @@ ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  *
  * Notice:
- * - nb_pkts < ICE_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 ice_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
-- 
2.47.1

