Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60CBC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:59:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEACA40A71;
	Fri, 30 May 2025 15:58:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E945C40697
 for <dev@dpdk.org>; Fri, 30 May 2025 15:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613482; x=1780149482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mTJIEJA+UHnV9yxOMNJuDHoB8n9m4Xw6HPRlI5tEXw4=;
 b=Jdd/usrdv62HRRn4OaweL0qEBWpN7DMIt1a/u4TK+ilbW7S83hzA4A6Q
 VvF9hkFD/7NuAnIjfSxlAp8z2zQ7+Usha0iC5rwKUJbZo+p3NHsw41yUY
 XmZoDo0KGeQXqMvA3+fVfl0qJ8jv6FTOZNkCtfZ2xDpDZIEoJ3RbBKEOl
 dbnOyTQUlsmoifK1fq0eh6iSkeTm5eq8TqiYcZp831OPIeBPfb9ANN+Kp
 b550H8/aa3SmJuqzeRxj7uKcTzUX4xvI76hhRKM0W59L/MLK344iVSZXn
 eLWkoB8P5WUjIhtWBgOxSwsuB28raFBMP2K75XVTazcefY+uq/sLJZknO A==;
X-CSE-ConnectionGUID: v/+HPEpsSp+otOuY3L3Lgg==
X-CSE-MsgGUID: TpmvwI6gR4SWLPH6jtOUAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809395"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809395"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:58:01 -0700
X-CSE-ConnectionGUID: TeteY03oQ0CQEuAXRX/SpA==
X-CSE-MsgGUID: +iM2Tds/SgyhaQfZ5InYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887471"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:58:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 14/25] net/iavf: clean up definitions
Date: Fri, 30 May 2025 14:57:10 +0100
Message-ID: <cb9a7f1a509f4dcbfc12819097ceeab4b9873cb2.1748612803.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
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

- Mark vector-PMD related definitions with a special naming convention
- Create "descriptors per loop" for different vector implementations
  (regular for SSE, Neon, AltiVec, wide for AVX2, AVX512)
- Make definitions' names match naming conventions used in other drivers

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/iavf/iavf_rxtx.c            |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.h            | 11 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 52 +++++++++----------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 49 +++++++++--------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 20 +++----
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   | 14 ++---
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    | 20 +++----
 7 files changed, 82 insertions(+), 86 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index fd6c7d3a3e..2aed22800e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -212,7 +212,7 @@ static inline bool
 check_tx_vec_allow(struct ci_tx_queue *txq)
 {
 	if (!(txq->offloads & IAVF_TX_NO_VECTOR_FLAGS) &&
-	    txq->tx_rs_thresh >= IAVF_VPMD_TX_MAX_BURST &&
+	    txq->tx_rs_thresh >= IAVF_VPMD_TX_BURST &&
 	    txq->tx_rs_thresh <= IAVF_VPMD_TX_MAX_FREE_BUF) {
 		PMD_INIT_LOG(DEBUG, "Vector tx can be enabled on this txq.");
 		return true;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 6198643605..8c0bb5475d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -23,11 +23,12 @@
 #define IAVF_RX_MAX_DATA_BUF_SIZE (16 * 1024 - 128)
 
 /* used for Vector PMD */
-#define IAVF_VPMD_RX_MAX_BURST    32
-#define IAVF_VPMD_TX_MAX_BURST    32
-#define IAVF_RXQ_REARM_THRESH     32
-#define IAVF_VPMD_DESCS_PER_LOOP  4
-#define IAVF_VPMD_TX_MAX_FREE_BUF 64
+#define IAVF_VPMD_RX_BURST             32
+#define IAVF_VPMD_TX_BURST             32
+#define IAVF_VPMD_RXQ_REARM_THRESH     32
+#define IAVF_VPMD_DESCS_PER_LOOP       4
+#define IAVF_VPMD_DESCS_PER_LOOP_WIDE  8
+#define IAVF_VPMD_TX_MAX_FREE_BUF      64
 
 #define IAVF_TX_NO_VECTOR_FLAGS (				 \
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		 \
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index d94a8b0ae1..40b265183f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -20,8 +20,6 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 			     uint16_t nb_pkts, uint8_t *split_packet,
 			     bool offload)
 {
-#define IAVF_DESCS_PER_LOOP_AVX 8
-
 	/* const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl; */
 	const uint32_t *type_table = rxq->vsi->adapter->ptype_tbl;
 
@@ -34,13 +32,13 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to IAVF_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to IAVF_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > IAVF_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IAVF_VPMD_RXQ_REARM_THRESH)
 		iavf_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -178,8 +176,8 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += IAVF_DESCS_PER_LOOP_AVX,
-	     rxdp += IAVF_DESCS_PER_LOOP_AVX) {
+	     i += IAVF_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += IAVF_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -217,7 +215,7 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < IAVF_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < IAVF_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -436,7 +434,7 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += IAVF_DESCS_PER_LOOP_AVX;
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -452,7 +450,7 @@ _iavf_recv_raw_pkts_vec_avx2(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != IAVF_DESCS_PER_LOOP_AVX)
+		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -492,8 +490,6 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 				      uint16_t nb_pkts, uint8_t *split_packet,
 				      bool offload)
 {
-#define IAVF_DESCS_PER_LOOP_AVX 8
-
 	struct iavf_adapter *adapter = rxq->vsi->adapter;
 
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
@@ -509,13 +505,13 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to IAVF_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to IAVF_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > IAVF_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IAVF_VPMD_RXQ_REARM_THRESH)
 		iavf_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -725,8 +721,8 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += IAVF_DESCS_PER_LOOP_AVX,
-	     rxdp += IAVF_DESCS_PER_LOOP_AVX) {
+	     i += IAVF_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += IAVF_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -782,7 +778,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < IAVF_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < IAVF_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -1344,7 +1340,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += IAVF_DESCS_PER_LOOP_AVX;
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -1407,7 +1403,7 @@ _iavf_recv_raw_pkts_vec_avx2_flex_rxd(struct iavf_rx_queue *rxq,
 			rxq->hw_time_update = rte_get_timer_cycles() / (rte_get_timer_hz() / 1000);
 		}
 #endif
-		if (burst != IAVF_DESCS_PER_LOOP_AVX)
+		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -1477,7 +1473,7 @@ iavf_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 				   uint16_t nb_pkts, bool offload)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _iavf_recv_raw_pkts_vec_avx2(rxq, rx_pkts, nb_pkts,
@@ -1520,12 +1516,12 @@ iavf_recv_scattered_pkts_vec_avx2_common(void *rx_queue, struct rte_mbuf **rx_pk
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst = iavf_recv_scattered_burst_vec_avx2(rx_queue,
-				rx_pkts + retval, IAVF_VPMD_RX_MAX_BURST, offload);
+				rx_pkts + retval, IAVF_VPMD_RX_BURST, offload);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + iavf_recv_scattered_burst_vec_avx2(rx_queue,
@@ -1566,7 +1562,7 @@ iavf_recv_scattered_burst_vec_avx2_flex_rxd(void *rx_queue,
 					    uint16_t nb_pkts, bool offload)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _iavf_recv_raw_pkts_vec_avx2_flex_rxd(rxq,
@@ -1610,14 +1606,14 @@ iavf_recv_scattered_pkts_vec_avx2_flex_rxd_common(void *rx_queue,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst =
 			iavf_recv_scattered_burst_vec_avx2_flex_rxd
-			(rx_queue, rx_pkts + retval, IAVF_VPMD_RX_MAX_BURST,
+			(rx_queue, rx_pkts + retval, IAVF_VPMD_RX_BURST,
 			 offload);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + iavf_recv_scattered_burst_vec_avx2_flex_rxd(rx_queue,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 895b8717f7..53bc69ecf6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -6,7 +6,6 @@
 
 #include <rte_vect.h>
 
-#define IAVF_DESCS_PER_LOOP_AVX 8
 #define PKTLEN_SHIFT 10
 
 /******************************************************************************
@@ -51,13 +50,13 @@ _iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to IAVF_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to IAVF_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > IAVF_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IAVF_VPMD_RXQ_REARM_THRESH)
 		iavf_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -148,8 +147,8 @@ _iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += IAVF_DESCS_PER_LOOP_AVX,
-	     rxdp += IAVF_DESCS_PER_LOOP_AVX) {
+	     i += IAVF_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += IAVF_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -196,7 +195,7 @@ _iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < IAVF_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < IAVF_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -527,7 +526,7 @@ _iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += IAVF_DESCS_PER_LOOP_AVX;
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -543,7 +542,7 @@ _iavf_recv_raw_pkts_vec_avx512(struct iavf_rx_queue *rxq,
 				(_mm_cvtsi128_si64
 					(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != IAVF_DESCS_PER_LOOP_AVX)
+		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -600,13 +599,13 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to IAVF_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to IAVF_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > IAVF_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IAVF_VPMD_RXQ_REARM_THRESH)
 		iavf_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -716,8 +715,8 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-	     i += IAVF_DESCS_PER_LOOP_AVX,
-	     rxdp += IAVF_DESCS_PER_LOOP_AVX) {
+	     i += IAVF_VPMD_DESCS_PER_LOOP_WIDE,
+	     rxdp += IAVF_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				    _mm256_loadu_si256((void *)&sw_ring[i]));
@@ -765,7 +764,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < IAVF_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < IAVF_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -1532,7 +1531,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += IAVF_DESCS_PER_LOOP_AVX;
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -1597,7 +1596,7 @@ _iavf_recv_raw_pkts_vec_avx512_flex_rxd(struct iavf_rx_queue *rxq,
 		}
 #endif
 #endif
-		if (burst != IAVF_DESCS_PER_LOOP_AVX)
+		if (burst != IAVF_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -1654,7 +1653,7 @@ iavf_recv_scattered_burst_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts, bool offload)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _iavf_recv_raw_pkts_vec_avx512(rxq, rx_pkts, nb_pkts,
@@ -1697,12 +1696,12 @@ iavf_recv_scattered_pkts_vec_avx512_cmn(void *rx_queue, struct rte_mbuf **rx_pkt
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst = iavf_recv_scattered_burst_vec_avx512(rx_queue,
-				rx_pkts + retval, IAVF_VPMD_RX_MAX_BURST, offload);
+				rx_pkts + retval, IAVF_VPMD_RX_BURST, offload);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + iavf_recv_scattered_burst_vec_avx512(rx_queue,
@@ -1730,7 +1729,7 @@ iavf_recv_scattered_burst_vec_avx512_flex_rxd(void *rx_queue,
 					      bool offload)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _iavf_recv_raw_pkts_vec_avx512_flex_rxd(rxq,
@@ -1775,14 +1774,14 @@ iavf_recv_scattered_pkts_vec_avx512_flex_rxd_cmn(void *rx_queue,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst =
 			iavf_recv_scattered_burst_vec_avx512_flex_rxd
 				(rx_queue, rx_pkts + retval,
-				 IAVF_VPMD_RX_MAX_BURST, offload);
+				 IAVF_VPMD_RX_BURST, offload);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + iavf_recv_scattered_burst_vec_avx512_flex_rxd(rx_queue,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f577fd7f3e..c78bebe9b4 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -59,7 +59,7 @@ iavf_rx_vec_queue_default(struct iavf_rx_queue *rxq)
 	if (!rte_is_power_of_2(rxq->nb_rx_desc))
 		return -1;
 
-	if (rxq->rx_free_thresh < IAVF_VPMD_RX_MAX_BURST)
+	if (rxq->rx_free_thresh < IAVF_VPMD_RX_BURST)
 		return -1;
 
 	if (rxq->nb_rx_desc % rxq->rx_free_thresh)
@@ -80,7 +80,7 @@ iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 	if (!txq)
 		return -1;
 
-	if (txq->tx_rs_thresh < IAVF_VPMD_TX_MAX_BURST ||
+	if (txq->tx_rs_thresh < IAVF_VPMD_TX_BURST ||
 	    txq->tx_rs_thresh > IAVF_VPMD_TX_MAX_FREE_BUF)
 		return -1;
 
@@ -252,8 +252,8 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxp,
-				 IAVF_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + IAVF_RXQ_REARM_THRESH >=
+				 IAVF_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + IAVF_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			__m128i dma_addr0;
 
@@ -265,7 +265,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IAVF_RXQ_REARM_THRESH;
+			IAVF_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
@@ -275,7 +275,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IAVF_RXQ_REARM_THRESH; i += 2, rxp += 2) {
+	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxp += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxp[0];
@@ -307,7 +307,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 		__m512i dma_addr0_3, dma_addr4_7;
 		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < IAVF_RXQ_REARM_THRESH;
+		for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH;
 				i += 8, rxp += 8, rxdp += 8) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
@@ -378,7 +378,7 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 		__m256i dma_addr0_1, dma_addr2_3;
 		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < IAVF_RXQ_REARM_THRESH;
+		for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH;
 				i += 4, rxp += 4, rxdp += 4) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m256i vaddr0_1, vaddr2_3;
@@ -423,11 +423,11 @@ iavf_rxq_rearm_common(struct iavf_rx_queue *rxq, __rte_unused bool avx512)
 
 #endif
 
-	rxq->rxrearm_start += IAVF_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += IAVF_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= IAVF_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= IAVF_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index a583340f15..86f3a7839d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -31,8 +31,8 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (unlikely(rte_mempool_get_bulk(rxq->mp,
 					  (void *)rxep,
-					  IAVF_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + IAVF_RXQ_REARM_THRESH >=
+					  IAVF_VPMD_RXQ_REARM_THRESH) < 0)) {
+		if (rxq->rxrearm_nb + IAVF_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			for (i = 0; i < IAVF_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i] = &rxq->fake_mbuf;
@@ -40,12 +40,12 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			IAVF_RXQ_REARM_THRESH;
+			IAVF_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < IAVF_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < IAVF_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		mb0 = rxep[0];
 		mb1 = rxep[1];
 
@@ -60,11 +60,11 @@ iavf_rxq_rearm(struct iavf_rx_queue *rxq)
 		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += IAVF_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += IAVF_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= IAVF_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= IAVF_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
@@ -233,7 +233,7 @@ _recv_raw_pkts_vec(struct iavf_rx_queue *__rte_restrict rxq,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > IAVF_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IAVF_VPMD_RXQ_REARM_THRESH)
 		iavf_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
index 8ccdec7f8a..190c1dd869 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_sse.c
@@ -1175,7 +1175,7 @@ _recv_raw_pkts_vec_flex_rxd(struct iavf_rx_queue *rxq,
 
 /* Notice:
  * - nb_pkts < IAVF_DESCS_PER_LOOP, just return no packet
- * - nb_pkts > IAVF_VPMD_RX_MAX_BURST, only scan IAVF_VPMD_RX_MAX_BURST
+ * - nb_pkts > IAVF_VPMD_RX_BURST, only scan IAVF_VPMD_RX_BURST
  *   numbers of DD bits
  */
 uint16_t
@@ -1187,7 +1187,7 @@ iavf_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 /* Notice:
  * - nb_pkts < IAVF_DESCS_PER_LOOP, just return no packet
- * - nb_pkts > IAVF_VPMD_RX_MAX_BURST, only scan IAVF_VPMD_RX_MAX_BURST
+ * - nb_pkts > IAVF_VPMD_RX_BURST, only scan IAVF_VPMD_RX_BURST
  *   numbers of DD bits
  */
 uint16_t
@@ -1208,7 +1208,7 @@ iavf_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 	unsigned int i = 0;
 
 	/* get some new buffers */
@@ -1247,15 +1247,15 @@ iavf_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = iavf_recv_scattered_burst_vec(rx_queue,
 						      rx_pkts + retval,
-						      IAVF_VPMD_RX_MAX_BURST);
+						      IAVF_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 
@@ -1277,7 +1277,7 @@ iavf_recv_scattered_burst_vec_flex_rxd(void *rx_queue,
 				       uint16_t nb_pkts)
 {
 	struct iavf_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[IAVF_VPMD_RX_MAX_BURST] = {0};
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
 	unsigned int i = 0;
 
 	/* get some new buffers */
@@ -1317,15 +1317,15 @@ iavf_recv_scattered_pkts_vec_flex_rxd(void *rx_queue,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > IAVF_VPMD_RX_MAX_BURST) {
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = iavf_recv_scattered_burst_vec_flex_rxd(rx_queue,
 						rx_pkts + retval,
-						IAVF_VPMD_RX_MAX_BURST);
+						IAVF_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < IAVF_VPMD_RX_MAX_BURST)
+		if (burst < IAVF_VPMD_RX_BURST)
 			return retval;
 	}
 
-- 
2.47.1

