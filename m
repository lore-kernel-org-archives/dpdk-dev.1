Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A28FC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CAD0427BF;
	Thu, 12 Jun 2025 13:12:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id F21A1427AC
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726749; x=1781262749;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DBlCO8foK3lANkwyvEFQ7gdDkxJJtpBzRNd7kUkV8XU=;
 b=EA06wZOOLtgnYzo5uY2uUiZGI4ZKt8xwfCVDAAtiDgOJxrpbirJ6y91J
 UVOGKcBcmF/eWSpIDKtp/X97w+laO6AZkKJbAAoWIkRiW7etrgdwgnBy8
 4r6JBtnIBRNweEjErtq5qRutR9/YaiAQpQlAGc3ABTlxgeqm6OnvHKpzd
 Qmi+RE5c52/tGAMY+CS4izYrRYQiIgzIC1D7vJcM5U33yhrRp7FX+looD
 b0Z2pKX0cF6L4OoNQgX0+VGn54bzcpV1tg0i5mnkoi7mzAscUL5no/m+9
 52JsbOW8hzvgxwuSRtGH5zZD0S+3xKUDDNy+VSd7pPwNewXzc7LJYKiZ3 w==;
X-CSE-ConnectionGUID: lIS1QqsMR0q7xVQrjJHRiQ==
X-CSE-MsgGUID: CCU3E2aVS/ioPkKiE59wAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177582"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:28 -0700
X-CSE-ConnectionGUID: /pUlLJsfSJ2N3LtFX51UCA==
X-CSE-MsgGUID: ySLa4ii9S3qQGjCsr4Y1+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371366"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:26 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 20/33] net/i40e: clean up definitions
Date: Thu, 12 Jun 2025 12:11:26 +0100
Message-ID: <52385c8af67613340126f3ff199e6176324752d3.1749726639.git.anatoly.burakov@intel.com>
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

- Remove RTE_ and RTE_PMD_ prefix from internal definitions
- Mark vector-PMD related definitions with I40E_VPMD_ prefix
- Remove unused definitions
- Create "descriptors per loop" for different vector implementations
  (regular for SSE, Neon, AltiVec, wide for AVX2, AVX512)

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/i40e/i40e_rxtx.c            | 42 +++++++--------
 drivers/net/intel/i40e/i40e_rxtx.h            | 17 +++---
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 18 +++----
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    | 48 ++++++++---------
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 32 ++++++-----
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 32 ++++++-----
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   | 53 +++++++++----------
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    | 48 ++++++++---------
 8 files changed, 142 insertions(+), 148 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 5f54bcc225..2e61076378 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -424,11 +424,11 @@ check_rx_burst_bulk_alloc_preconditions(__rte_unused struct i40e_rx_queue *rxq)
 	int ret = 0;
 
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
-	if (!(rxq->rx_free_thresh >= RTE_PMD_I40E_RX_MAX_BURST)) {
+	if (!(rxq->rx_free_thresh >= I40E_RX_MAX_BURST)) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions: "
 			     "rxq->rx_free_thresh=%d, "
-			     "RTE_PMD_I40E_RX_MAX_BURST=%d",
-			     rxq->rx_free_thresh, RTE_PMD_I40E_RX_MAX_BURST);
+			     "I40E_RX_MAX_BURST=%d",
+			     rxq->rx_free_thresh, I40E_RX_MAX_BURST);
 		ret = -EINVAL;
 	} else if (!(rxq->rx_free_thresh < rxq->nb_rx_desc)) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions: "
@@ -484,7 +484,7 @@ i40e_rx_scan_hw_ring(struct i40e_rx_queue *rxq)
 	 * Scan LOOK_AHEAD descriptors at a time to determine which
 	 * descriptors reference packets that are ready to be received.
 	 */
-	for (i = 0; i < RTE_PMD_I40E_RX_MAX_BURST; i+=I40E_LOOK_AHEAD,
+	for (i = 0; i < I40E_RX_MAX_BURST; i += I40E_LOOK_AHEAD,
 			rxdp += I40E_LOOK_AHEAD, rxep += I40E_LOOK_AHEAD) {
 		/* Read desc statuses backwards to avoid race condition */
 		for (j = I40E_LOOK_AHEAD - 1; j >= 0; j--) {
@@ -680,11 +680,11 @@ i40e_recv_pkts_bulk_alloc(void *rx_queue,
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	if (likely(nb_pkts <= RTE_PMD_I40E_RX_MAX_BURST))
+	if (likely(nb_pkts <= I40E_RX_MAX_BURST))
 		return rx_recv_pkts(rx_queue, rx_pkts, nb_pkts);
 
 	while (nb_pkts) {
-		n = RTE_MIN(nb_pkts, RTE_PMD_I40E_RX_MAX_BURST);
+		n = RTE_MIN(nb_pkts, I40E_RX_MAX_BURST);
 		count = rx_recv_pkts(rx_queue, &rx_pkts[nb_rx], n);
 		nb_rx = (uint16_t)(nb_rx + count);
 		nb_pkts = (uint16_t)(nb_pkts - count);
@@ -1334,9 +1334,9 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 	struct ci_tx_entry *txep;
 	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
 	uint16_t i = 0, j = 0;
-	struct rte_mbuf *free[RTE_I40E_TX_MAX_FREE_BUF_SZ];
-	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, RTE_I40E_TX_MAX_FREE_BUF_SZ);
-	const uint16_t m = tx_rs_thresh % RTE_I40E_TX_MAX_FREE_BUF_SZ;
+	struct rte_mbuf *free[I40E_TX_MAX_FREE_BUF_SZ];
+	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, I40E_TX_MAX_FREE_BUF_SZ);
+	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
 
 	if ((txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
 			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
@@ -1350,13 +1350,13 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 
 	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
 		if (k) {
-			for (j = 0; j != k; j += RTE_I40E_TX_MAX_FREE_BUF_SZ) {
-				for (i = 0; i < RTE_I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
+			for (j = 0; j != k; j += I40E_TX_MAX_FREE_BUF_SZ) {
+				for (i = 0; i < I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
 					free[i] = txep->mbuf;
 					txep->mbuf = NULL;
 				}
 				rte_mempool_put_bulk(free[0]->pool, (void **)free,
-						RTE_I40E_TX_MAX_FREE_BUF_SZ);
+						I40E_TX_MAX_FREE_BUF_SZ);
 			}
 		}
 
@@ -2146,7 +2146,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * Allocating a little more memory because vectorized/bulk_alloc Rx
 	 * functions doesn't check boundaries each time.
 	 */
-	len += RTE_PMD_I40E_RX_MAX_BURST;
+	len += I40E_RX_MAX_BURST;
 
 	ring_size = RTE_ALIGN(len * sizeof(union i40e_rx_desc),
 			      I40E_DMA_MEM_ALIGN);
@@ -2166,7 +2166,7 @@ i40e_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->rx_ring_phys_addr = rz->iova;
 	rxq->rx_ring = (union i40e_rx_desc *)rz->addr;
 
-	len = (uint16_t)(nb_desc + RTE_PMD_I40E_RX_MAX_BURST);
+	len = (uint16_t)(nb_desc + I40E_RX_MAX_BURST);
 
 	/* Allocate the software ring. */
 	rxq->sw_ring =
@@ -2370,7 +2370,7 @@ i40e_dev_tx_queue_setup_runtime(struct rte_eth_dev *dev,
 
 	/* check vector conflict */
 	if (ad->tx_vec_allowed) {
-		if (txq->tx_rs_thresh > RTE_I40E_TX_MAX_FREE_BUF_SZ ||
+		if (txq->tx_rs_thresh > I40E_TX_MAX_FREE_BUF_SZ ||
 		    i40e_txq_vec_setup(txq)) {
 			PMD_DRV_LOG(ERR, "Failed vector tx setup.");
 			return -EINVAL;
@@ -2379,7 +2379,7 @@ i40e_dev_tx_queue_setup_runtime(struct rte_eth_dev *dev,
 	/* check simple tx conflict */
 	if (ad->tx_simple_allowed) {
 		if ((txq->offloads & ~RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) != 0 ||
-				txq->tx_rs_thresh < RTE_PMD_I40E_TX_MAX_BURST) {
+				txq->tx_rs_thresh < I40E_TX_MAX_BURST) {
 			PMD_DRV_LOG(ERR, "No-simple tx is required.");
 			return -EINVAL;
 		}
@@ -2675,7 +2675,7 @@ i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
 
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
 	if (check_rx_burst_bulk_alloc_preconditions(rxq) == 0)
-		len = (uint16_t)(rxq->nb_rx_desc + RTE_PMD_I40E_RX_MAX_BURST);
+		len = (uint16_t)(rxq->nb_rx_desc + I40E_RX_MAX_BURST);
 	else
 #endif /* RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC */
 		len = rxq->nb_rx_desc;
@@ -2684,7 +2684,7 @@ i40e_reset_rx_queue(struct i40e_rx_queue *rxq)
 		((volatile char *)rxq->rx_ring)[i] = 0;
 
 	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
-	for (i = 0; i < RTE_PMD_I40E_RX_MAX_BURST; ++i)
+	for (i = 0; i < I40E_RX_MAX_BURST; ++i)
 		rxq->sw_ring[rxq->nb_rx_desc + i].mbuf = &rxq->fake_mbuf;
 
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
@@ -3276,7 +3276,7 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
 	if (ad->rx_vec_allowed) {
-		recycle_rxq_info->refill_requirement = RTE_I40E_RXQ_REARM_THRESH;
+		recycle_rxq_info->refill_requirement = I40E_VPMD_RXQ_REARM_THRESH;
 		recycle_rxq_info->refill_head = &rxq->rxrearm_start;
 	} else {
 		recycle_rxq_info->refill_requirement = rxq->rx_free_thresh;
@@ -3501,9 +3501,9 @@ i40e_set_tx_function_flag(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 	ad->tx_simple_allowed =
 		(txq->offloads ==
 		 (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
-		 txq->tx_rs_thresh >= RTE_PMD_I40E_TX_MAX_BURST);
+		 txq->tx_rs_thresh >= I40E_TX_MAX_BURST);
 	ad->tx_vec_allowed = (ad->tx_simple_allowed &&
-			txq->tx_rs_thresh <= RTE_I40E_TX_MAX_FREE_BUF_SZ);
+			txq->tx_rs_thresh <= I40E_TX_MAX_FREE_BUF_SZ);
 
 	if (ad->tx_vec_allowed)
 		PMD_INIT_LOG(DEBUG, "Vector Tx can be enabled on Tx queue %u.",
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 568f0536ac..3dca32b1ba 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -7,15 +7,14 @@
 
 #include "../common/tx.h"
 
-#define RTE_PMD_I40E_RX_MAX_BURST 32
-#define RTE_PMD_I40E_TX_MAX_BURST 32
+#define I40E_RX_MAX_BURST 32
+#define I40E_TX_MAX_BURST 32
 
-#define RTE_I40E_VPMD_RX_BURST        32
-#define RTE_I40E_VPMD_TX_BURST        32
-#define RTE_I40E_RXQ_REARM_THRESH      32
-#define RTE_I40E_MAX_RX_BURST          RTE_I40E_RXQ_REARM_THRESH
-#define RTE_I40E_TX_MAX_FREE_BUF_SZ    64
-#define RTE_I40E_DESCS_PER_LOOP    4
+#define I40E_VPMD_RX_BURST            32
+#define I40E_VPMD_RXQ_REARM_THRESH    32
+#define I40E_TX_MAX_FREE_BUF_SZ       64
+#define I40E_VPMD_DESCS_PER_LOOP      4
+#define I40E_VPMD_DESCS_PER_LOOP_WIDE 8
 
 #define I40E_RXBUF_SZ_1024 1024
 #define I40E_RXBUF_SZ_2048 2048
@@ -97,7 +96,7 @@ struct i40e_rx_queue {
 	uint16_t rx_nb_avail; /**< number of staged packets ready */
 	uint16_t rx_next_avail; /**< index of next staged packets */
 	uint16_t rx_free_trigger; /**< triggers rx buffer allocation */
-	struct rte_mbuf *rx_stage[RTE_PMD_I40E_RX_MAX_BURST * 2];
+	struct rte_mbuf *rx_stage[I40E_RX_MAX_BURST * 2];
 #endif
 
 	uint16_t rxrearm_nb;	/**< number of remaining to be re-armed */
diff --git a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
index 7d2bda624b..8fc7cd5bd4 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_common_avx.h
@@ -25,19 +25,19 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 RTE_I40E_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
+				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			__m128i dma_addr0;
 			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
+			I40E_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
@@ -47,7 +47,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 	__m128i hdr_room = _mm_set_epi64x(RTE_PKTMBUF_HEADROOM,
 			RTE_PKTMBUF_HEADROOM);
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxep[0].mbuf;
@@ -79,7 +79,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 		__m512i dma_addr0_3, dma_addr4_7;
 		__m512i hdr_room = _mm512_set1_epi64(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 8 mbufs in one loop */
-		for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH;
+		for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH;
 				i += 8, rxep += 8, rxdp += 8) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m128i vaddr4, vaddr5, vaddr6, vaddr7;
@@ -152,7 +152,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 		__m256i dma_addr0_1, dma_addr2_3;
 		__m256i hdr_room = _mm256_set1_epi64x(RTE_PKTMBUF_HEADROOM);
 		/* Initialize the mbufs in vector, process 4 mbufs in one loop */
-		for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH;
+		for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH;
 				i += 4, rxep += 4, rxdp += 4) {
 			__m128i vaddr0, vaddr1, vaddr2, vaddr3;
 			__m256i vaddr0_1, vaddr2_3;
@@ -197,7 +197,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 
 #endif
 
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
 	rx_id = rxq->rxrearm_start - 1;
 
 	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
@@ -205,7 +205,7 @@ i40e_rxq_rearm_common(struct i40e_rx_queue *rxq, __rte_unused bool avx512)
 		rx_id = rxq->nb_rx_desc - 1;
 	}
 
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
 
 	/* Update the tail pointer on the NIC */
 	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 01dee811ba..568891cfb2 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -35,23 +35,23 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 RTE_I40E_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
+				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			dma_addr0 = (__vector unsigned long){};
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				vec_st(dma_addr0, 0,
 					RTE_CAST_PTR(__vector unsigned long *, &rxdp[i].read));
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
+			I40E_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__vector unsigned long vaddr0, vaddr1;
 		uintptr_t p0, p1;
 
@@ -86,7 +86,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		vec_st(dma_addr1, 0, RTE_CAST_PTR(__vector unsigned long *, &rxdp++->read));
 	}
 
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
 	rx_id = rxq->rxrearm_start - 1;
 
 	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
@@ -94,7 +94,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		rx_id = rxq->nb_rx_desc - 1;
 	}
 
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
 
 	/* Update the tail pointer on the NIC */
 	I40E_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
@@ -188,11 +188,11 @@ desc_to_ptype_v(__vector unsigned long descs[4], struct rte_mbuf **rx_pkts,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= RTE_I40E_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= I40E_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
@@ -215,8 +215,8 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		};
 	__vector unsigned long dd_check, eop_check;
 
-	/* nb_pkts has to be floor-aligned to RTE_I40E_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_I40E_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -228,7 +228,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_I40E_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
 		i40e_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -271,9 +271,9 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 */
 
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-			pos += RTE_I40E_DESCS_PER_LOOP,
-			rxdp += RTE_I40E_DESCS_PER_LOOP) {
-		__vector unsigned long descs[RTE_I40E_DESCS_PER_LOOP];
+			pos += I40E_VPMD_DESCS_PER_LOOP,
+			rxdp += I40E_VPMD_DESCS_PER_LOOP) {
+		__vector unsigned long descs[I40E_VPMD_DESCS_PER_LOOP];
 		__vector unsigned char pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		__vector unsigned short staterr, sterr_tmp1, sterr_tmp2;
 		__vector unsigned long mbp1, mbp2; /* two mbuf pointer
@@ -406,7 +406,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			/* store the resulting 32-bit value */
 			*split_packet = (vec_ld(0,
 					 (__vector unsigned int *)&eop_bits))[0];
-			split_packet += RTE_I40E_DESCS_PER_LOOP;
+			split_packet += I40E_VPMD_DESCS_PER_LOOP;
 
 			/* zero-out next pointers */
 			rx_pkts[pos]->next = NULL;
@@ -433,7 +433,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		var = rte_popcount64((vec_ld(0,
 			(__vector unsigned long *)&staterr)[0]));
 		nb_pkts_recd += var;
-		if (likely(var != RTE_I40E_DESCS_PER_LOOP))
+		if (likely(var != I40E_VPMD_DESCS_PER_LOOP))
 			break;
 	}
 
@@ -446,7 +446,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 }
 
  /* Notice:
-  * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+  * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
   */
 uint16_t
 i40e_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -459,14 +459,14 @@ i40e_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			      uint16_t nb_pkts)
 {
 	struct i40e_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
+	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
@@ -505,15 +505,15 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_I40E_VPMD_RX_BURST) {
+	while (nb_pkts > I40E_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = i40e_recv_scattered_burst_vec(rx_queue,
 						      rx_pkts + retval,
-						      RTE_I40E_VPMD_RX_BURST);
+						      I40E_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_I40E_VPMD_RX_BURST)
+		if (burst < I40E_VPMD_RX_BURST)
 			return retval;
 	}
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
index 4469c73c56..a13dd9bc78 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
@@ -108,8 +108,6 @@ static __rte_always_inline uint16_t
 _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts, uint8_t *split_packet)
 {
-#define RTE_I40E_DESCS_PER_LOOP_AVX 8
-
 	const uint32_t *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
 	const __m256i mbuf_init = _mm256_set_epi64x(0, 0,
 			0, rxq->mbuf_initializer);
@@ -118,13 +116,13 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	const int avx_aligned = ((rxq->rx_tail & 1) == 0);
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to RTE_I40E_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_I40E_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_I40E_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
 		i40e_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -262,8 +260,8 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 	uint16_t i, received;
 	for (i = 0, received = 0; i < nb_pkts;
-			i += RTE_I40E_DESCS_PER_LOOP_AVX,
-			rxdp += RTE_I40E_DESCS_PER_LOOP_AVX) {
+			i += I40E_VPMD_DESCS_PER_LOOP_WIDE,
+			rxdp += I40E_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				_mm256_loadu_si256((void *)&sw_ring[i]));
@@ -299,7 +297,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 		if (split_packet) {
 			int j;
-			for (j = 0; j < RTE_I40E_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < I40E_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -577,7 +575,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 					12, 4, 14, 6);
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet = _mm_cvtsi128_si64(split_bits);
-			split_packet += RTE_I40E_DESCS_PER_LOOP_AVX;
+			split_packet += I40E_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -590,7 +588,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		burst += rte_popcount64(_mm_cvtsi128_si64(
 				_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != RTE_I40E_DESCS_PER_LOOP_AVX)
+		if (burst != I40E_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -607,7 +605,7 @@ _recv_raw_pkts_vec_avx2(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 /*
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -619,14 +617,14 @@ i40e_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 /*
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 i40e_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
 {
 	struct i40e_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
+	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec_avx2(rxq, rx_pkts, nb_pkts,
@@ -661,19 +659,19 @@ i40e_recv_scattered_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles scattered packets.
  * Main receive routine that can handle arbitrary burst sizes
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_scattered_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
 {
 	uint16_t retval = 0;
-	while (nb_pkts > RTE_I40E_VPMD_RX_BURST) {
+	while (nb_pkts > I40E_VPMD_RX_BURST) {
 		uint16_t burst = i40e_recv_scattered_burst_vec_avx2(rx_queue,
-				rx_pkts + retval, RTE_I40E_VPMD_RX_BURST);
+				rx_pkts + retval, I40E_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_I40E_VPMD_RX_BURST)
+		if (burst < I40E_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + i40e_recv_scattered_burst_vec_avx2(rx_queue,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
index bb25acf398..f0320a221c 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
@@ -15,8 +15,6 @@
 
 #include <rte_vect.h>
 
-#define RTE_I40E_DESCS_PER_LOOP_AVX 8
-
 static __rte_always_inline void
 i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 {
@@ -119,13 +117,13 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 	rte_prefetch0(rxdp);
 
-	/* nb_pkts has to be floor-aligned to RTE_I40E_DESCS_PER_LOOP_AVX */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_I40E_DESCS_PER_LOOP_AVX);
+	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP_WIDE */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP_WIDE);
 
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_I40E_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
 		i40e_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -245,8 +243,8 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	uint16_t i, received;
 
 	for (i = 0, received = 0; i < nb_pkts;
-			i += RTE_I40E_DESCS_PER_LOOP_AVX,
-			rxdp += RTE_I40E_DESCS_PER_LOOP_AVX) {
+			i += I40E_VPMD_DESCS_PER_LOOP_WIDE,
+			rxdp += I40E_VPMD_DESCS_PER_LOOP_WIDE) {
 		/* step 1, copy over 8 mbuf pointers to rx_pkts array */
 		_mm256_storeu_si256((void *)&rx_pkts[i],
 				_mm256_loadu_si256((void *)&sw_ring[i]));
@@ -312,7 +310,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		if (split_packet) {
 			int j;
 
-			for (j = 0; j < RTE_I40E_DESCS_PER_LOOP_AVX; j++)
+			for (j = 0; j < I40E_VPMD_DESCS_PER_LOOP_WIDE; j++)
 				rte_mbuf_prefetch_part2(rx_pkts[i + j]);
 		}
 
@@ -642,7 +640,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			split_bits = _mm_shuffle_epi8(split_bits, eop_shuffle);
 			*(uint64_t *)split_packet =
 				_mm_cvtsi128_si64(split_bits);
-			split_packet += RTE_I40E_DESCS_PER_LOOP_AVX;
+			split_packet += I40E_VPMD_DESCS_PER_LOOP_WIDE;
 		}
 
 		/* perform dd_check */
@@ -657,7 +655,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		burst += rte_popcount64(_mm_cvtsi128_si64
 				(_mm256_castsi256_si128(status0_7)));
 		received += burst;
-		if (burst != RTE_I40E_DESCS_PER_LOOP_AVX)
+		if (burst != I40E_VPMD_DESCS_PER_LOOP_WIDE)
 			break;
 	}
 
@@ -674,7 +672,7 @@ _recv_raw_pkts_vec_avx512(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 /**
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -686,7 +684,7 @@ i40e_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 /**
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 i40e_recv_scattered_burst_vec_avx512(void *rx_queue,
@@ -694,7 +692,7 @@ i40e_recv_scattered_burst_vec_avx512(void *rx_queue,
 				     uint16_t nb_pkts)
 {
 	struct i40e_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
+	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec_avx512(rxq, rx_pkts, nb_pkts,
@@ -729,7 +727,7 @@ i40e_recv_scattered_burst_vec_avx512(void *rx_queue,
  * vPMD receive routine that reassembles scattered packets.
  * Main receive routine that can handle arbitrary burst sizes
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
@@ -738,12 +736,12 @@ i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_I40E_VPMD_RX_BURST) {
+	while (nb_pkts > I40E_VPMD_RX_BURST) {
 		uint16_t burst = i40e_recv_scattered_burst_vec_avx512(rx_queue,
-				rx_pkts + retval, RTE_I40E_VPMD_RX_BURST);
+				rx_pkts + retval, I40E_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_I40E_VPMD_RX_BURST)
+		if (burst < I40E_VPMD_RX_BURST)
 			return retval;
 	}
 	return retval + i40e_recv_scattered_burst_vec_avx512(rx_queue,
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 695b4e1040..955382652c 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -33,21 +33,21 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (unlikely(rte_mempool_get_bulk(rxq->mp,
 					  (void *)rxep,
-					  RTE_I40E_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
+					  I40E_VPMD_RXQ_REARM_THRESH) < 0)) {
+		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read), zero);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
+			I40E_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		mb0 = rxep[0].mbuf;
 		mb1 = rxep[1].mbuf;
 
@@ -62,7 +62,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
 	rx_id = rxq->rxrearm_start - 1;
 
 	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
@@ -70,7 +70,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		rx_id = rxq->nb_rx_desc - 1;
 	}
 
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
 
 	rte_io_wmb();
 	/* Update the tail pointer on the NIC */
@@ -325,11 +325,11 @@ desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= RTE_I40E_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= I40E_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
@@ -368,8 +368,8 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 		0, 0, 0       /* ignore non-length fields */
 		};
 
-	/* nb_pkts has to be floor-aligned to RTE_I40E_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_I40E_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -381,7 +381,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_I40E_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
 		i40e_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -405,9 +405,9 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 	 */
 
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-			pos += RTE_I40E_DESCS_PER_LOOP,
-			rxdp += RTE_I40E_DESCS_PER_LOOP) {
-		uint64x2_t descs[RTE_I40E_DESCS_PER_LOOP];
+			pos += I40E_VPMD_DESCS_PER_LOOP,
+			rxdp += I40E_VPMD_DESCS_PER_LOOP) {
+		uint64x2_t descs[I40E_VPMD_DESCS_PER_LOOP];
 		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		uint16x8x2_t sterr_tmp1, sterr_tmp2;
 		uint64x2_t mbp1, mbp2;
@@ -502,9 +502,8 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 
 		desc_to_ptype_v(descs, &rx_pkts[pos], ptype_tbl);
 
-		if (likely(pos + RTE_I40E_DESCS_PER_LOOP < nb_pkts)) {
-			rte_prefetch_non_temporal(rxdp + RTE_I40E_DESCS_PER_LOOP);
-		}
+		if (likely(pos + I40E_VPMD_DESCS_PER_LOOP < nb_pkts))
+			rte_prefetch_non_temporal(rxdp + I40E_VPMD_DESCS_PER_LOOP);
 
 		/* C.1 4=>2 filter staterr info only */
 		sterr_tmp2 = vzipq_u16(vreinterpretq_u16_u64(descs[1]),
@@ -538,7 +537,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 			/* store the resulting 32-bit value */
 			vst1q_lane_u32((uint32_t *)split_packet,
 				       vreinterpretq_u32_u8(eop_bits), 0);
-			split_packet += RTE_I40E_DESCS_PER_LOOP;
+			split_packet += I40E_VPMD_DESCS_PER_LOOP;
 
 			/* zero-out next pointers */
 			rx_pkts[pos]->next = NULL;
@@ -555,7 +554,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 
 		/* C.4 calc available number of desc */
 		if (unlikely(stat == 0)) {
-			nb_pkts_recd += RTE_I40E_DESCS_PER_LOOP;
+			nb_pkts_recd += I40E_VPMD_DESCS_PER_LOOP;
 		} else {
 			nb_pkts_recd += rte_ctz64(stat) / I40E_UINT16_BIT;
 			break;
@@ -572,7 +571,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *__rte_restrict rxq,
 
  /*
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_pkts_vec(void *__rte_restrict rx_queue,
@@ -585,7 +584,7 @@ i40e_recv_pkts_vec(void *__rte_restrict rx_queue,
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -593,7 +592,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 
 	struct i40e_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
+	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
@@ -633,15 +632,15 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_I40E_VPMD_RX_BURST) {
+	while (nb_pkts > I40E_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = i40e_recv_scattered_burst_vec(rx_queue,
 						      rx_pkts + retval,
-						      RTE_I40E_VPMD_RX_BURST);
+						      I40E_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_I40E_VPMD_RX_BURST)
+		if (burst < I40E_VPMD_RX_BURST)
 			return retval;
 	}
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 920089fe3e..7e7f4c0895 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -31,23 +31,23 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 RTE_I40E_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_I40E_RXQ_REARM_THRESH >=
+				 I40E_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + I40E_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_I40E_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < I40E_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_I40E_RXQ_REARM_THRESH;
+			I40E_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_I40E_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < I40E_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxep[0].mbuf;
@@ -72,7 +72,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += I40E_VPMD_RXQ_REARM_THRESH;
 	rx_id = rxq->rxrearm_start - 1;
 
 	if (unlikely(rxq->rxrearm_start >= rxq->nb_rx_desc)) {
@@ -80,7 +80,7 @@ i40e_rxq_rearm(struct i40e_rx_queue *rxq)
 		rx_id = rxq->nb_rx_desc - 1;
 	}
 
-	rxq->rxrearm_nb -= RTE_I40E_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= I40E_VPMD_RXQ_REARM_THRESH;
 
 	/* Update the tail pointer on the NIC */
 	I40E_PCI_REG_WC_WRITE(rxq->qrx_tail, rx_id);
@@ -340,11 +340,11 @@ desc_to_ptype_v(__m128i descs[4], struct rte_mbuf **rx_pkts,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= RTE_I40E_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= I40E_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_I40E_DESCS_PER_LOOP power-of-two
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a I40E_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
@@ -376,8 +376,8 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
 	__m128i dd_check, eop_check;
 
-	/* nb_pkts has to be floor-aligned to RTE_I40E_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_I40E_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to I40E_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, I40E_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -389,7 +389,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_I40E_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > I40E_VPMD_RXQ_REARM_THRESH)
 		i40e_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -443,9 +443,9 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 */
 
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-			pos += RTE_I40E_DESCS_PER_LOOP,
-			rxdp += RTE_I40E_DESCS_PER_LOOP) {
-		__m128i descs[RTE_I40E_DESCS_PER_LOOP];
+			pos += I40E_VPMD_DESCS_PER_LOOP,
+			rxdp += I40E_VPMD_DESCS_PER_LOOP) {
+		__m128i descs[I40E_VPMD_DESCS_PER_LOOP];
 		__m128i pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		__m128i zero, staterr, sterr_tmp1, sterr_tmp2;
 		/* 2 64 bit or 4 32 bit mbuf pointers in one XMM reg. */
@@ -559,7 +559,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
 			/* store the resulting 32-bit value */
 			*(int *)split_packet = _mm_cvtsi128_si32(eop_bits);
-			split_packet += RTE_I40E_DESCS_PER_LOOP;
+			split_packet += I40E_VPMD_DESCS_PER_LOOP;
 		}
 
 		/* C.3 calc available number of desc */
@@ -575,7 +575,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		/* C.4 calc available number of desc */
 		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
 		nb_pkts_recd += var;
-		if (likely(var != RTE_I40E_DESCS_PER_LOOP))
+		if (likely(var != I40E_VPMD_DESCS_PER_LOOP))
 			break;
 	}
 
@@ -589,7 +589,7 @@ _recv_raw_pkts_vec(struct i40e_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
  /*
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 uint16_t
 i40e_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -602,7 +602,7 @@ i40e_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles single burst of 32 scattered packets
  *
  * Notice:
- * - nb_pkts < RTE_I40E_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts < I40E_VPMD_DESCS_PER_LOOP, just return no packet
  */
 static uint16_t
 i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -610,7 +610,7 @@ i40e_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 
 	struct i40e_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_I40E_VPMD_RX_BURST] = {0};
+	uint8_t split_flags[I40E_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
@@ -650,15 +650,15 @@ i40e_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_I40E_VPMD_RX_BURST) {
+	while (nb_pkts > I40E_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = i40e_recv_scattered_burst_vec(rx_queue,
 						      rx_pkts + retval,
-						      RTE_I40E_VPMD_RX_BURST);
+						      I40E_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_I40E_VPMD_RX_BURST)
+		if (burst < I40E_VPMD_RX_BURST)
 			return retval;
 	}
 
-- 
2.47.1

