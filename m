Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB9C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B07640693;
	Fri, 30 May 2025 15:57:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C29A14066F
 for <dev@dpdk.org>; Fri, 30 May 2025 15:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613476; x=1780149476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YvF6fc70GJhuAEdW5OObW9s/FCkjtXUNQUNzYS5hQBg=;
 b=c9GB8QgXIrXfzGYGxrezPJuWQv1XztL/iwQl7XkgVnhE31PoGSGKOZSU
 Id7YDH66wl4ONYkT3wtqGgWplwHmYvXew/gEuUkKZCOaAgvmk2cZuoWdR
 XSkMH4Wr0K8Pv4cMJspkz7AgqKI4GQfSeoMH7qfTzrkbApYK/xaMNdOih
 JiMHY5z6SQQgZ83/RbtdLSOpDlA3LmB86bM0JYEsZtQcaksSp77qz05mU
 GO2pjBXNW1TgR8laB7G/GyO2qs1j17P3HJC8FydMfinkbEwGw0u4ZOhaZ
 dGpkuuKvIzQ2hTU4e2FcNIK25Uiemx7Hffjo/AnuMqQI4b7iMmCZFHSza Q==;
X-CSE-ConnectionGUID: 2J3HvN7hS5edoy5ZRDR5SQ==
X-CSE-MsgGUID: rT0DZyY0Tee7UHUr1/Zydw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809379"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809379"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:57:55 -0700
X-CSE-ConnectionGUID: l0cXsqLfQPeQwzCSYJ0ZlQ==
X-CSE-MsgGUID: CG3Ts/1bSSO0jdFO0q35mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887457"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:57:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 11/25] net/ixgbe: clean up definitions
Date: Fri, 30 May 2025 14:57:07 +0100
Message-ID: <8351f332545959ce99ad31c062fbacf413cb4f08.1748612803.git.anatoly.burakov@intel.com>
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

This patch does the following cleanups:

- Remove RTE_ prefix from internal definitions
- Mark vector-PMD related definitions with a special naming convention

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_ipsec.c         | 10 ++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 60 +++++++++----------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 22 +++----
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 56 ++++++++---------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 60 +++++++++----------
 6 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
index 778004cbe4..df0964a51d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ipsec.c
@@ -15,20 +15,20 @@
 #include "ixgbe_ethdev.h"
 #include "ixgbe_ipsec.h"
 
-#define RTE_IXGBE_REGISTER_POLL_WAIT_5_MS  5
+#define IXGBE_REGISTER_POLL_WAIT_5_MS  5
 
 #define IXGBE_WAIT_RREAD \
 	IXGBE_WRITE_REG_THEN_POLL_MASK(hw, IXGBE_IPSRXIDX, reg_val, \
-	IPSRXIDX_READ, RTE_IXGBE_REGISTER_POLL_WAIT_5_MS)
+	IPSRXIDX_READ, IXGBE_REGISTER_POLL_WAIT_5_MS)
 #define IXGBE_WAIT_RWRITE \
 	IXGBE_WRITE_REG_THEN_POLL_MASK(hw, IXGBE_IPSRXIDX, reg_val, \
-	IPSRXIDX_WRITE, RTE_IXGBE_REGISTER_POLL_WAIT_5_MS)
+	IPSRXIDX_WRITE, IXGBE_REGISTER_POLL_WAIT_5_MS)
 #define IXGBE_WAIT_TREAD \
 	IXGBE_WRITE_REG_THEN_POLL_MASK(hw, IXGBE_IPSTXIDX, reg_val, \
-	IPSRXIDX_READ, RTE_IXGBE_REGISTER_POLL_WAIT_5_MS)
+	IPSRXIDX_READ, IXGBE_REGISTER_POLL_WAIT_5_MS)
 #define IXGBE_WAIT_TWRITE \
 	IXGBE_WRITE_REG_THEN_POLL_MASK(hw, IXGBE_IPSTXIDX, reg_val, \
-	IPSRXIDX_WRITE, RTE_IXGBE_REGISTER_POLL_WAIT_5_MS)
+	IPSRXIDX_WRITE, IXGBE_REGISTER_POLL_WAIT_5_MS)
 
 #define CMP_IP(a, b) (\
 	(a).ipv6[0] == (b).ipv6[0] && \
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 3b49ef9fbb..22d0aea1a7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -103,7 +103,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 	struct ci_tx_entry *txep;
 	uint32_t status;
 	int i, nb_free = 0;
-	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
+	struct rte_mbuf *m, *free[IXGBE_TX_MAX_FREE_BUF_SZ];
 
 	/* check DD bit on threshold descriptor */
 	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
@@ -124,7 +124,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 		if (unlikely(m == NULL))
 			continue;
 
-		if (nb_free >= RTE_IXGBE_TX_MAX_FREE_BUF_SZ ||
+		if (nb_free >= IXGBE_TX_MAX_FREE_BUF_SZ ||
 		    (nb_free > 0 && m->pool != free[0]->pool)) {
 			rte_mempool_put_bulk(free[0]->pool,
 					     (void **)free, nb_free);
@@ -336,7 +336,7 @@ ixgbe_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return 0;
 
 	/* Try to transmit at least chunks of TX_MAX_BURST pkts */
-	if (likely(nb_pkts <= RTE_PMD_IXGBE_TX_MAX_BURST))
+	if (likely(nb_pkts <= IXGBE_TX_MAX_BURST))
 		return tx_xmit_pkts(tx_queue, tx_pkts, nb_pkts);
 
 	/* transmit more than the max burst, in chunks of TX_MAX_BURST */
@@ -344,7 +344,7 @@ ixgbe_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
 	while (nb_pkts) {
 		uint16_t ret, n;
 
-		n = (uint16_t)RTE_MIN(nb_pkts, RTE_PMD_IXGBE_TX_MAX_BURST);
+		n = (uint16_t)RTE_MIN(nb_pkts, IXGBE_TX_MAX_BURST);
 		ret = tx_xmit_pkts(tx_queue, &(tx_pkts[nb_tx]), n);
 		nb_tx = (uint16_t)(nb_tx + ret);
 		nb_pkts = (uint16_t)(nb_pkts - ret);
@@ -1590,7 +1590,7 @@ ixgbe_rx_scan_hw_ring(struct ixgbe_rx_queue *rxq)
 	 * Scan LOOK_AHEAD descriptors at a time to determine which descriptors
 	 * reference packets that are ready to be received.
 	 */
-	for (i = 0; i < RTE_PMD_IXGBE_RX_MAX_BURST;
+	for (i = 0; i < IXGBE_RX_MAX_BURST;
 	     i += LOOK_AHEAD, rxdp += LOOK_AHEAD, rxep += LOOK_AHEAD) {
 		/* Read desc statuses backwards to avoid race condition */
 		for (j = 0; j < LOOK_AHEAD; j++)
@@ -1787,7 +1787,7 @@ rx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return 0;
 }
 
-/* split requests into chunks of size RTE_PMD_IXGBE_RX_MAX_BURST */
+/* split requests into chunks of size IXGBE_RX_MAX_BURST */
 uint16_t
 ixgbe_recv_pkts_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts)
@@ -1797,7 +1797,7 @@ ixgbe_recv_pkts_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	if (likely(nb_pkts <= RTE_PMD_IXGBE_RX_MAX_BURST))
+	if (likely(nb_pkts <= IXGBE_RX_MAX_BURST))
 		return rx_recv_pkts(rx_queue, rx_pkts, nb_pkts);
 
 	/* request is relatively large, chunk it up */
@@ -1805,7 +1805,7 @@ ixgbe_recv_pkts_bulk_alloc(void *rx_queue, struct rte_mbuf **rx_pkts,
 	while (nb_pkts) {
 		uint16_t ret, n;
 
-		n = (uint16_t)RTE_MIN(nb_pkts, RTE_PMD_IXGBE_RX_MAX_BURST);
+		n = (uint16_t)RTE_MIN(nb_pkts, IXGBE_RX_MAX_BURST);
 		ret = rx_recv_pkts(rx_queue, &rx_pkts[nb_rx], n);
 		nb_rx = (uint16_t)(nb_rx + ret);
 		nb_pkts = (uint16_t)(nb_pkts - ret);
@@ -2510,8 +2510,8 @@ ixgbe_dev_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 #ifdef RTE_LIB_SECURITY
 			!(txq->using_ipsec) &&
 #endif
-			txq->tx_rs_thresh >= RTE_PMD_IXGBE_TX_MAX_BURST) {
-		if (txq->tx_rs_thresh <= RTE_IXGBE_TX_MAX_FREE_BUF_SZ &&
+			txq->tx_rs_thresh >= IXGBE_TX_MAX_BURST) {
+		if (txq->tx_rs_thresh <= IXGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
 					txq->sw_ring_vec != NULL)) {
@@ -2666,10 +2666,10 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 #ifdef RTE_LIB_SECURITY
 			!(txq->using_ipsec) &&
 #endif
-			(txq->tx_rs_thresh >= RTE_PMD_IXGBE_TX_MAX_BURST)) {
+			(txq->tx_rs_thresh >= IXGBE_TX_MAX_BURST)) {
 		PMD_INIT_LOG(DEBUG, "Using simple tx code path");
 		dev->tx_pkt_prepare = NULL;
-		if (txq->tx_rs_thresh <= RTE_IXGBE_TX_MAX_FREE_BUF_SZ &&
+		if (txq->tx_rs_thresh <= IXGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
 					ixgbe_txq_vec_setup(txq) == 0)) {
@@ -2684,9 +2684,9 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 				" - offloads = 0x%" PRIx64,
 				txq->offloads);
 		PMD_INIT_LOG(DEBUG,
-				" - tx_rs_thresh = %lu " "[RTE_PMD_IXGBE_TX_MAX_BURST=%lu]",
+				" - tx_rs_thresh = %lu [IXGBE_TX_MAX_BURST=%lu]",
 				(unsigned long)txq->tx_rs_thresh,
-				(unsigned long)RTE_PMD_IXGBE_TX_MAX_BURST);
+				(unsigned long)IXGBE_TX_MAX_BURST);
 		dev->tx_pkt_burst = ixgbe_xmit_pkts;
 		dev->tx_pkt_prepare = ixgbe_prep_pkts;
 	}
@@ -3031,17 +3031,17 @@ check_rx_burst_bulk_alloc_preconditions(struct ixgbe_rx_queue *rxq)
 
 	/*
 	 * Make sure the following pre-conditions are satisfied:
-	 *   rxq->rx_free_thresh >= RTE_PMD_IXGBE_RX_MAX_BURST
+	 *   rxq->rx_free_thresh >= IXGBE_RX_MAX_BURST
 	 *   rxq->rx_free_thresh < rxq->nb_rx_desc
 	 *   (rxq->nb_rx_desc % rxq->rx_free_thresh) == 0
 	 * Scattered packets are not supported.  This should be checked
 	 * outside of this function.
 	 */
-	if (!(rxq->rx_free_thresh >= RTE_PMD_IXGBE_RX_MAX_BURST)) {
+	if (!(rxq->rx_free_thresh >= IXGBE_RX_MAX_BURST)) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions: "
 			     "rxq->rx_free_thresh=%d, "
-			     "RTE_PMD_IXGBE_RX_MAX_BURST=%d",
-			     rxq->rx_free_thresh, RTE_PMD_IXGBE_RX_MAX_BURST);
+			     "IXGBE_RX_MAX_BURST=%d",
+			     rxq->rx_free_thresh, IXGBE_RX_MAX_BURST);
 		ret = -EINVAL;
 	} else if (!(rxq->rx_free_thresh < rxq->nb_rx_desc)) {
 		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions: "
@@ -3075,7 +3075,7 @@ ixgbe_reset_rx_queue(struct ixgbe_adapter *adapter, struct ixgbe_rx_queue *rxq)
 	 */
 	if (adapter->rx_bulk_alloc_allowed)
 		/* zero out extra memory */
-		len += RTE_PMD_IXGBE_RX_MAX_BURST;
+		len += IXGBE_RX_MAX_BURST;
 
 	/*
 	 * Zero out HW ring memory. Zero out extra memory at the end of
@@ -3319,7 +3319,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 */
 	len = nb_desc;
 	if (adapter->rx_bulk_alloc_allowed)
-		len += RTE_PMD_IXGBE_RX_MAX_BURST;
+		len += IXGBE_RX_MAX_BURST;
 
 	rxq->sw_ring = rte_zmalloc_socket("rxq->sw_ring",
 					  sizeof(struct ixgbe_rx_entry) * len,
@@ -4617,7 +4617,7 @@ ixgbe_vmdq_rx_hw_configure(struct rte_eth_dev *dev)
 	/* PFDMA Tx General Switch Control Enables VMDQ loopback */
 	if (cfg->enable_loop_back) {
 		IXGBE_WRITE_REG(hw, IXGBE_PFDTXGSWC, IXGBE_PFDTXGSWC_VT_LBEN);
-		for (i = 0; i < RTE_IXGBE_VMTXSW_REGISTER_COUNT; i++)
+		for (i = 0; i < IXGBE_VMTXSW_REGISTER_COUNT; i++)
 			IXGBE_WRITE_REG(hw, IXGBE_VMTXSW(i), UINT32_MAX);
 	}
 
@@ -5071,7 +5071,7 @@ ixgbe_set_rx_function(struct rte_eth_dev *dev)
 	} else if (adapter->rx_vec_allowed) {
 		PMD_INIT_LOG(DEBUG, "Vector rx enabled, please make sure RX "
 				    "burst size no less than %d (port=%d).",
-			     RTE_IXGBE_DESCS_PER_LOOP,
+			     IXGBE_VPMD_DESCS_PER_LOOP,
 			     dev->data->port_id);
 		dev->recycle_rx_descriptors_refill = ixgbe_recycle_rx_descriptors_refill_vec;
 		dev->rx_pkt_burst = ixgbe_recv_pkts_vec;
@@ -5655,7 +5655,7 @@ ixgbe_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	IXGBE_WRITE_REG(hw, IXGBE_RXDCTL(rxq->reg_idx), rxdctl);
 
 	/* Wait until RX Enable ready */
-	poll_ms = RTE_IXGBE_REGISTER_POLL_WAIT_10_MS;
+	poll_ms = IXGBE_REGISTER_POLL_WAIT_10_MS;
 	do {
 		rte_delay_ms(1);
 		rxdctl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(rxq->reg_idx));
@@ -5692,7 +5692,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	IXGBE_WRITE_REG(hw, IXGBE_RXDCTL(rxq->reg_idx), rxdctl);
 
 	/* Wait until RX Enable bit clear */
-	poll_ms = RTE_IXGBE_REGISTER_POLL_WAIT_10_MS;
+	poll_ms = IXGBE_REGISTER_POLL_WAIT_10_MS;
 	do {
 		rte_delay_ms(1);
 		rxdctl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(rxq->reg_idx));
@@ -5700,7 +5700,7 @@ ixgbe_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	if (!poll_ms)
 		PMD_INIT_LOG(ERR, "Could not disable Rx Queue %d", rx_queue_id);
 
-	rte_delay_us(RTE_IXGBE_WAIT_100_US);
+	rte_delay_us(IXGBE_WAIT_100_US);
 
 	ixgbe_rx_queue_release_mbufs(rxq);
 	ixgbe_reset_rx_queue(adapter, rxq);
@@ -5732,7 +5732,7 @@ ixgbe_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	/* Wait until TX Enable ready */
 	if (hw->mac.type == ixgbe_mac_82599EB) {
-		poll_ms = RTE_IXGBE_REGISTER_POLL_WAIT_10_MS;
+		poll_ms = IXGBE_REGISTER_POLL_WAIT_10_MS;
 		do {
 			rte_delay_ms(1);
 			txdctl = IXGBE_READ_REG(hw,
@@ -5768,9 +5768,9 @@ ixgbe_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	/* Wait until TX queue is empty */
 	if (hw->mac.type == ixgbe_mac_82599EB) {
-		poll_ms = RTE_IXGBE_REGISTER_POLL_WAIT_10_MS;
+		poll_ms = IXGBE_REGISTER_POLL_WAIT_10_MS;
 		do {
-			rte_delay_us(RTE_IXGBE_WAIT_100_US);
+			rte_delay_us(IXGBE_WAIT_100_US);
 			txtdh = IXGBE_READ_REG(hw,
 					       IXGBE_TDH(txq->reg_idx));
 			txtdt = IXGBE_READ_REG(hw,
@@ -5788,7 +5788,7 @@ ixgbe_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	/* Wait until TX Enable bit clear */
 	if (hw->mac.type == ixgbe_mac_82599EB) {
-		poll_ms = RTE_IXGBE_REGISTER_POLL_WAIT_10_MS;
+		poll_ms = IXGBE_REGISTER_POLL_WAIT_10_MS;
 		do {
 			rte_delay_ms(1);
 			txdctl = IXGBE_READ_REG(hw,
@@ -5861,7 +5861,7 @@ ixgbe_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	recycle_rxq_info->receive_tail = &rxq->rx_tail;
 
 	if (adapter->rx_vec_allowed) {
-		recycle_rxq_info->refill_requirement = RTE_IXGBE_RXQ_REARM_THRESH;
+		recycle_rxq_info->refill_requirement = IXGBE_VPMD_RXQ_REARM_THRESH;
 		recycle_rxq_info->refill_head = &rxq->rxrearm_start;
 	} else {
 		recycle_rxq_info->refill_requirement = rxq->rx_free_thresh;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index bcd5db87e8..5742e845cf 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -29,16 +29,16 @@
 #define	IXGBE_MIN_RING_DESC	64
 #define	IXGBE_MAX_RING_DESC	8192
 
-#define RTE_PMD_IXGBE_TX_MAX_BURST 32
-#define RTE_PMD_IXGBE_RX_MAX_BURST 32
-#define RTE_IXGBE_TX_MAX_FREE_BUF_SZ 64
+#define IXGBE_TX_MAX_BURST            32
+#define IXGBE_RX_MAX_BURST            32
+#define IXGBE_TX_MAX_FREE_BUF_SZ      64
 
-#define RTE_IXGBE_DESCS_PER_LOOP    4
+#define IXGBE_VPMD_DESCS_PER_LOOP     4
 
-#define RTE_IXGBE_RXQ_REARM_THRESH      32
-#define RTE_IXGBE_MAX_RX_BURST          RTE_IXGBE_RXQ_REARM_THRESH
+#define IXGBE_VPMD_RXQ_REARM_THRESH   32
+#define IXGBE_VPMD_RX_BURST           IXGBE_VPMD_RXQ_REARM_THRESH
 
-#define RX_RING_SZ ((IXGBE_MAX_RING_DESC + RTE_PMD_IXGBE_RX_MAX_BURST) * \
+#define RX_RING_SZ ((IXGBE_MAX_RING_DESC + IXGBE_RX_MAX_BURST) * \
 		    sizeof(union ixgbe_adv_rx_desc))
 
 #ifdef RTE_PMD_PACKET_PREFETCH
@@ -47,9 +47,9 @@
 #define rte_packet_prefetch(p)  do {} while(0)
 #endif
 
-#define RTE_IXGBE_REGISTER_POLL_WAIT_10_MS  10
-#define RTE_IXGBE_WAIT_100_US               100
-#define RTE_IXGBE_VMTXSW_REGISTER_COUNT     2
+#define IXGBE_REGISTER_POLL_WAIT_10_MS  10
+#define IXGBE_WAIT_100_US               100
+#define IXGBE_VMTXSW_REGISTER_COUNT     2
 
 #define IXGBE_TX_MAX_SEG                    40
 
@@ -118,7 +118,7 @@ struct ixgbe_rx_queue {
 	/** need to alloc dummy mbuf, for wraparound when scanning hw ring */
 	struct rte_mbuf fake_mbuf;
 	/** hold packets to return to application */
-	struct rte_mbuf *rx_stage[RTE_PMD_IXGBE_RX_MAX_BURST*2];
+	struct rte_mbuf *rx_stage[IXGBE_RX_MAX_BURST * 2];
 	const struct rte_memzone *mz;
 };
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 018010820f..4442dc7b39 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -19,7 +19,7 @@ ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
-	struct rte_mbuf *m, *free[RTE_IXGBE_TX_MAX_FREE_BUF_SZ];
+	struct rte_mbuf *m, *free[IXGBE_TX_MAX_FREE_BUF_SZ];
 
 	/* check DD bit on threshold descriptor */
 	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
index f8916d44e8..02d9dbb573 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c
@@ -29,24 +29,24 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (unlikely(rte_mempool_get_bulk(rxq->mp,
 					  (void *)rxep,
-					  RTE_IXGBE_RXQ_REARM_THRESH) < 0)) {
-		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
+					  IXGBE_VPMD_RXQ_REARM_THRESH) < 0)) {
+		if (rxq->rxrearm_nb + IXGBE_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
-			for (i = 0; i < RTE_IXGBE_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < IXGBE_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp[i].read),
 					  zero);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_IXGBE_RXQ_REARM_THRESH;
+			IXGBE_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	p = vld1_u8((uint8_t *)&rxq->mbuf_initializer);
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_IXGBE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < IXGBE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		mb0 = rxep[0].mbuf;
 		mb1 = rxep[1].mbuf;
 
@@ -66,11 +66,11 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 		vst1q_u64(RTE_CAST_PTR(uint64_t *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += RTE_IXGBE_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += IXGBE_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= RTE_IXGBE_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= IXGBE_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
@@ -275,11 +275,11 @@ desc_to_ptype_v(uint64x2_t descs[4], uint16_t pkt_type_mask,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= RTE_IXGBE_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= IXGBE_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts < IXGBE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
@@ -303,8 +303,8 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	uint8_t vlan_flags;
 	uint16_t udp_p_flag = 0; /* Rx Descriptor UDP header present */
 
-	/* nb_pkts has to be floor-aligned to RTE_IXGBE_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_IXGBE_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to IXGBE_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IXGBE_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -316,7 +316,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_IXGBE_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IXGBE_VPMD_RXQ_REARM_THRESH)
 		ixgbe_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -345,9 +345,9 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 * D. fill info. from desc to mbuf
 	 */
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-			pos += RTE_IXGBE_DESCS_PER_LOOP,
-			rxdp += RTE_IXGBE_DESCS_PER_LOOP) {
-		uint64x2_t descs[RTE_IXGBE_DESCS_PER_LOOP];
+			pos += IXGBE_VPMD_DESCS_PER_LOOP,
+			rxdp += IXGBE_VPMD_DESCS_PER_LOOP) {
+		uint64x2_t descs[IXGBE_VPMD_DESCS_PER_LOOP];
 		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		uint8x16x2_t sterr_tmp1, sterr_tmp2;
 		uint64x2_t mbp1, mbp2;
@@ -426,7 +426,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			/* and with mask to extract bits, flipping 1-0 */
 			*(int *)split_packet = ~stat & IXGBE_VPMD_DESC_EOP_MASK;
 
-			split_packet += RTE_IXGBE_DESCS_PER_LOOP;
+			split_packet += IXGBE_VPMD_DESCS_PER_LOOP;
 		}
 
 		/* C.4 expand DD bit to saturate UINT8 */
@@ -436,7 +436,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 					IXGBE_UINT8_BIT - 1));
 		stat = ~vgetq_lane_u32(vreinterpretq_u32_u8(staterr), 0);
 
-		rte_prefetch_non_temporal(rxdp + RTE_IXGBE_DESCS_PER_LOOP);
+		rte_prefetch_non_temporal(rxdp + IXGBE_VPMD_DESCS_PER_LOOP);
 
 		/* D.3 copy final 1,2 data to rx_pkts */
 		vst1q_u8((uint8_t *)&rx_pkts[pos + 1]->rx_descriptor_fields1,
@@ -448,7 +448,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 
 		/* C.5 calc available number of desc */
 		if (unlikely(stat == 0)) {
-			nb_pkts_recd += RTE_IXGBE_DESCS_PER_LOOP;
+			nb_pkts_recd += IXGBE_VPMD_DESCS_PER_LOOP;
 		} else {
 			nb_pkts_recd += rte_ctz32(stat) / IXGBE_UINT8_BIT;
 			break;
@@ -464,11 +464,11 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 }
 
 /**
- * vPMD receive routine, only accept(nb_pkts >= RTE_IXGBE_DESCS_PER_LOOP)
+ * vPMD receive routine, only accept(nb_pkts >= IXGBE_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts < IXGBE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESC_PER_LOOP power-of-two
  */
 uint16_t
 ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -481,15 +481,15 @@ ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles scattered packets
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts < IXGBE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static uint16_t
 ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
 {
 	struct ixgbe_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_IXGBE_MAX_RX_BURST] = {0};
+	uint8_t split_flags[IXGBE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
@@ -527,15 +527,15 @@ ixgbe_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_IXGBE_MAX_RX_BURST) {
+	while (nb_pkts > IXGBE_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = ixgbe_recv_scattered_burst_vec(rx_queue,
 						       rx_pkts + retval,
-						       RTE_IXGBE_MAX_RX_BURST);
+						       IXGBE_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_IXGBE_MAX_RX_BURST)
+		if (burst < IXGBE_VPMD_RX_BURST)
 			return retval;
 	}
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
index 9417e5b11f..ea57631932 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c
@@ -31,23 +31,23 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 	/* Pull 'n' more MBUFs into the software ring */
 	if (rte_mempool_get_bulk(rxq->mp,
 				 (void *)rxep,
-				 RTE_IXGBE_RXQ_REARM_THRESH) < 0) {
-		if (rxq->rxrearm_nb + RTE_IXGBE_RXQ_REARM_THRESH >=
+				 IXGBE_VPMD_RXQ_REARM_THRESH) < 0) {
+		if (rxq->rxrearm_nb + IXGBE_VPMD_RXQ_REARM_THRESH >=
 		    rxq->nb_rx_desc) {
 			dma_addr0 = _mm_setzero_si128();
-			for (i = 0; i < RTE_IXGBE_DESCS_PER_LOOP; i++) {
+			for (i = 0; i < IXGBE_VPMD_DESCS_PER_LOOP; i++) {
 				rxep[i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i].read),
 						dma_addr0);
 			}
 		}
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
-			RTE_IXGBE_RXQ_REARM_THRESH;
+			IXGBE_VPMD_RXQ_REARM_THRESH;
 		return;
 	}
 
 	/* Initialize the mbufs in vector, process 2 mbufs in one loop */
-	for (i = 0; i < RTE_IXGBE_RXQ_REARM_THRESH; i += 2, rxep += 2) {
+	for (i = 0; i < IXGBE_VPMD_RXQ_REARM_THRESH; i += 2, rxep += 2) {
 		__m128i vaddr0, vaddr1;
 
 		mb0 = rxep[0].mbuf;
@@ -76,11 +76,11 @@ ixgbe_rxq_rearm(struct ixgbe_rx_queue *rxq)
 		_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp++->read), dma_addr1);
 	}
 
-	rxq->rxrearm_start += RTE_IXGBE_RXQ_REARM_THRESH;
+	rxq->rxrearm_start += IXGBE_VPMD_RXQ_REARM_THRESH;
 	if (rxq->rxrearm_start >= rxq->nb_rx_desc)
 		rxq->rxrearm_start = 0;
 
-	rxq->rxrearm_nb -= RTE_IXGBE_RXQ_REARM_THRESH;
+	rxq->rxrearm_nb -= IXGBE_VPMD_RXQ_REARM_THRESH;
 
 	rx_id = (uint16_t) ((rxq->rxrearm_start == 0) ?
 			     (rxq->nb_rx_desc - 1) : (rxq->rxrearm_start - 1));
@@ -262,10 +262,10 @@ static inline uint32_t get_packet_type(int index,
 				       uint32_t etqf_check,
 				       uint32_t tunnel_check)
 {
-	if (etqf_check & (0x02 << (index * RTE_IXGBE_DESCS_PER_LOOP)))
+	if (etqf_check & (0x02 << (index * IXGBE_VPMD_DESCS_PER_LOOP)))
 		return RTE_PTYPE_UNKNOWN;
 
-	if (tunnel_check & (0x02 << (index * RTE_IXGBE_DESCS_PER_LOOP))) {
+	if (tunnel_check & (0x02 << (index * IXGBE_VPMD_DESCS_PER_LOOP))) {
 		pkt_info &= IXGBE_PACKET_TYPE_MASK_TUNNEL;
 		return ptype_table_tn[pkt_info];
 	}
@@ -320,11 +320,11 @@ desc_to_ptype_v(__m128i descs[4], uint16_t pkt_type_mask,
 }
 
 /**
- * vPMD raw receive routine, only accept(nb_pkts >= RTE_IXGBE_DESCS_PER_LOOP)
+ * vPMD raw receive routine, only accept(nb_pkts >= IXGBE_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts < IXGBE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static inline uint16_t
 _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
@@ -369,10 +369,10 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 * So we need to make some restrictions to ensure that
 	 * `rx_tail` will not exceed `rxrearm_start`.
 	 */
-	nb_pkts = RTE_MIN(nb_pkts, RTE_IXGBE_RXQ_REARM_THRESH);
+	nb_pkts = RTE_MIN(nb_pkts, IXGBE_VPMD_RXQ_REARM_THRESH);
 
-	/* nb_pkts has to be floor-aligned to RTE_IXGBE_DESCS_PER_LOOP */
-	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RTE_IXGBE_DESCS_PER_LOOP);
+	/* nb_pkts has to be floor-aligned to IXGBE_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IXGBE_VPMD_DESCS_PER_LOOP);
 
 	/* Just the act of getting into the function from the application is
 	 * going to cost about 7 cycles
@@ -384,7 +384,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	/* See if we need to rearm the RX queue - gives the prefetch a bit
 	 * of time to act
 	 */
-	if (rxq->rxrearm_nb > RTE_IXGBE_RXQ_REARM_THRESH)
+	if (rxq->rxrearm_nb > IXGBE_VPMD_RXQ_REARM_THRESH)
 		ixgbe_rxq_rearm(rxq);
 
 	/* Before we start moving massive data around, check to see if
@@ -446,9 +446,9 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	 * D. fill info. from desc to mbuf
 	 */
 	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
-			pos += RTE_IXGBE_DESCS_PER_LOOP,
-			rxdp += RTE_IXGBE_DESCS_PER_LOOP) {
-		__m128i descs[RTE_IXGBE_DESCS_PER_LOOP];
+			pos += IXGBE_VPMD_DESCS_PER_LOOP,
+			rxdp += IXGBE_VPMD_DESCS_PER_LOOP) {
+		__m128i descs[IXGBE_VPMD_DESCS_PER_LOOP];
 		__m128i pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		__m128i zero, staterr, sterr_tmp1, sterr_tmp2;
 		/* 2 64 bit or 4 32 bit mbuf pointers in one XMM reg. */
@@ -554,7 +554,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 			eop_bits = _mm_shuffle_epi8(eop_bits, eop_shuf_mask);
 			/* store the resulting 32-bit value */
 			*(int *)split_packet = _mm_cvtsi128_si32(eop_bits);
-			split_packet += RTE_IXGBE_DESCS_PER_LOOP;
+			split_packet += IXGBE_VPMD_DESCS_PER_LOOP;
 		}
 
 		/* C.3 calc available number of desc */
@@ -572,7 +572,7 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		/* C.4 calc available number of desc */
 		var = rte_popcount64(_mm_cvtsi128_si64(staterr));
 		nb_pkts_recd += var;
-		if (likely(var != RTE_IXGBE_DESCS_PER_LOOP))
+		if (likely(var != IXGBE_VPMD_DESCS_PER_LOOP))
 			break;
 	}
 
@@ -585,11 +585,11 @@ _recv_raw_pkts_vec(struct ixgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 }
 
 /**
- * vPMD receive routine, only accept(nb_pkts >= RTE_IXGBE_DESCS_PER_LOOP)
+ * vPMD receiIXGBE_VPMD_RX_BURSTt(nb_pkts >= IXGBE_VPMD_DESCS_PER_LOOP)
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts <IXGBE_VPMD_RX_BURSTOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 uint16_t
 ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
@@ -602,15 +602,15 @@ ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
  * vPMD receive routine that reassembles scattered packets
  *
  * Notice:
- * - nb_pkts < RTE_IXGBE_DESCS_PER_LOOP, just return no packet
- * - floor align nb_pkts to a RTE_IXGBE_DESC_PER_LOOP power-of-two
+ * - nb_pkts < IXGBE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IXGBE_VPMD_DESCS_PER_LOOP power-of-two
  */
 static uint16_t
 ixgbe_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
 {
 	struct ixgbe_rx_queue *rxq = rx_queue;
-	uint8_t split_flags[RTE_IXGBE_MAX_RX_BURST] = {0};
+	uint8_t split_flags[IXGBE_VPMD_RX_BURST] = {0};
 
 	/* get some new buffers */
 	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
@@ -648,15 +648,15 @@ ixgbe_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 {
 	uint16_t retval = 0;
 
-	while (nb_pkts > RTE_IXGBE_MAX_RX_BURST) {
+	while (nb_pkts > IXGBE_VPMD_RX_BURST) {
 		uint16_t burst;
 
 		burst = ixgbe_recv_scattered_burst_vec(rx_queue,
 						       rx_pkts + retval,
-						       RTE_IXGBE_MAX_RX_BURST);
+						       IXGBE_VPMD_RX_BURST);
 		retval += burst;
 		nb_pkts -= burst;
-		if (burst < RTE_IXGBE_MAX_RX_BURST)
+		if (burst < IXGBE_VPMD_RX_BURST)
 			return retval;
 	}
 
-- 
2.47.1

