Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5204C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E068040693;
	Mon, 31 Aug 2026 12:36:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0C8384065A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:36:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788172610; x=1819708610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JtCTiPvPt5Ja+c2MXe3rYAHq18mpS9G+au1SzFHj3l0=;
 b=i2n+FgX/o/W5MvYqo5NW92tOzvKL3ZR4UPn+f5HSnrtDgKvQp3u7f26m
 fLWmc/QC+CboT8YsPX8hDErX20tce+InsNfCpv+f5glOq3xqxikRXDoAO
 Pb4sp51mjZEABRagevxMEVb4pB6QTLBeDvKgO4HqL9XyzZvsaS+6KZ1dq
 ZKfNCQBNUYRvKwAGU/g8auiaHXJ8OhBk6So2bWJ79X3zeFViTaEgqhNv0
 vNUBRR1VPPw79YcRQ3OHgb82WtY/ike2ldzGIex2t79QA19NP8YGtkGdI
 LC/YFliwytbPubyuJDJMVHgVV52nlGGtWgif4RnvgXyJwPrIJhGORbNWH A==;
X-CSE-ConnectionGUID: EWjbF5SEQtCLTPwqwfHXMg==
X-CSE-MsgGUID: lJ69aNZ1TvOJRu/1qGTcLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625950"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88625950"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:36:49 -0700
X-CSE-ConnectionGUID: F7Mo4DqcToi+bA9BFUHkjA==
X-CSE-MsgGUID: 8cf5f93AQFaViOdVlBjz6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268807444"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:36:48 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 3/4] net/ice: add AVX2 context descriptor Tx path
Date: Mon, 31 Aug 2026 10:35:29 +0000
Message-Id: <eb8734d99fad03277c1f099854a7d3ad00517d58.1788171502.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788171502.git.anurag.mandal@intel.com>
References: <cover.1788171502.git.anurag.mandal@intel.com>
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

Added an AVX2 context descriptor path for tunneled
outer IPv4 and UDP checksum offloads.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst    |   5 +
 drivers/net/intel/ice/ice_dcf_ethdev.c    |   4 +-
 drivers/net/intel/ice/ice_ethdev.h        |   1 +
 drivers/net/intel/ice/ice_rxtx.c          |  39 +++++--
 drivers/net/intel/ice/ice_rxtx.h          |   8 ++
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c | 119 ++++++++++++++++++++++
 6 files changed, 166 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 907f9013ff..8ce1875843 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel ice driver.**
+
+  Added an AVX2 Tx path using context descriptors, allowing tunneled outer IPv4
+  and UDP checksum offloads without falling back to scalar Tx.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled while a
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index c78b290b0d..d1cdae6eb9 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -498,7 +498,7 @@ ice_dcf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = dev->data->tx_queues[tx_queue_id];
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	reset_tx_queue(txq);
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -648,7 +648,7 @@ ice_dcf_stop_queues(struct rte_eth_dev *dev)
 		txq = dev->data->tx_queues[i];
 		if (!txq)
 			continue;
-		ci_txq_release_all_mbufs(txq, false);
+		ci_txq_release_all_mbufs(txq, txq->use_ctx);
 		reset_tx_queue(txq);
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..0e74f8d776 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -213,6 +213,7 @@ enum ice_tx_func_type {
 	ICE_TX_SIMPLE,
 	ICE_TX_AVX2,
 	ICE_TX_AVX2_OFFLOAD,
+	ICE_TX_AVX2_CTX_OFFLOAD,
 	ICE_TX_AVX512,
 	ICE_TX_AVX512_OFFLOAD,
 	ICE_TX_NEON,
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..7e83541f5d 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -793,7 +793,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	struct ice_aqc_add_tx_qgrp *txq_elem;
 	struct ice_tlan_ctx tx_ctx;
 	int buf_len;
-	struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	u16 q_base, q_range, cgd_idx = 0;
 
 	PMD_INIT_FUNC_TRACE();
@@ -881,9 +880,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			return -EIO;
 		}
 
-	/* record what kind of descriptor cleanup we need on teardown */
-	txq->use_vec_entry = ad->tx_vec_allowed || ad->tx_simple_allowed;
-
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_set_txtime_qgrp *ts_elem;
 		struct ice_txtime_ctx txtime_ctx = { 0 };
@@ -1193,7 +1189,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	ice_reset_tx_queue(txq);
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1256,7 +1252,7 @@ ice_fdir_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	txq->qtx_tail = NULL;
 
 	return 0;
@@ -1744,7 +1740,7 @@ ice_tx_queue_release(void *txq)
 		return;
 	}
 
-	ci_txq_release_all_mbufs(q, false);
+	ci_txq_release_all_mbufs(q, q->use_ctx);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
 	if (q->tsq) {
@@ -3522,7 +3518,8 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_burst = ice_xmit_pkts,
 		.info = "Scalar",
 		.features = {
-			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
+			.tx_offloads = ICE_TX_SCALAR_OFFLOADS,
+			.ctx_desc = true
 		},
 		.pkt_prep = ice_prep_pkts
 	},
@@ -3554,6 +3551,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		},
 		.pkt_prep = ice_prep_pkts
 	},
+	[ICE_TX_AVX2_CTX_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2_ctx_offload,
+		.info = "Context Offload Vector AVX2",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.ctx_desc = true
+		},
+		.pkt_prep = ice_prep_pkts
+	},
 #ifdef CC_AVX512_SUPPORT
 	[ICE_TX_AVX512] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512,
@@ -3755,10 +3762,17 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	const struct ci_tx_path_features *selected_features;
+	struct ci_tx_queue *txq;
 	int mbuf_check = ad->devargs.mbuf_check;
+	int i;
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
+		/* outer checksum offloads are only encoded in a context descriptor */
+		.ctx_desc = (dev->data->dev_conf.txmode.offloads &
+			(RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+			 RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)) != 0,
 	};
 
 	/* If the device has started the function has already been selected. */
@@ -3785,6 +3799,15 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	ad->tx_vec_allowed =
 		(ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128);
 #endif
+	selected_features = &ice_tx_path_infos[ad->tx_func_type].features;
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (!txq)
+			continue;
+		txq->use_ctx = selected_features->ctx_desc;
+		txq->use_vec_entry = selected_features->simple_tx ||
+			selected_features->simd_width >= RTE_VECT_SIMD_128;
+	}
 
 	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
 					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 999b6b30d6..37e346fe39 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -136,6 +136,11 @@
 	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
 	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
 
+#define ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (	\
+	ICE_TX_VECTOR_OFFLOAD_OFFLOADS |		\
+	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
+
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
 
@@ -284,6 +289,9 @@ uint16_t ice_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts);
 uint16_t ice_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts);
+uint16_t ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue,
+					    struct rte_mbuf **tx_pkts,
+					    uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				  uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx512_offload(void *rx_queue,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index b72f69a47b..9bfd18d82b 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -837,6 +837,125 @@ ice_vtx(volatile struct ci_tx_desc *txdp,
 	}
 }
 
+static __rte_always_inline void
+ice_ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+	     uint64_t flags, bool offload)
+{
+	uint64_t high_data_qw = CI_TX_DESC_DTYPE_DATA |
+			(flags << CI_TXD_QW1_CMD_S) |
+			((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S);
+	const uint64_t low_ctx_qw = offload ? ice_txd_tunneling_ctx(pkt) : 0;
+
+	if (offload)
+		ice_txd_enable_offload(pkt, &high_data_qw);
+
+	const __m256i ctx_data_desc = _mm256_set_epi64x(high_data_qw,
+			rte_pktmbuf_iova(pkt), CI_TX_DESC_DTYPE_CTX, low_ctx_qw);
+
+	_mm256_store_si256(RTE_CAST_PTR(__m256i *, txdp), ctx_data_desc);
+}
+
+static __rte_always_inline void
+ice_ctx_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
+	    uint16_t nb_pkts, uint64_t flags, bool offload)
+{
+	while (nb_pkts) {
+		ice_ctx_vtx1(txdp, *pkt, flags, offload);
+		txdp += 2;
+		pkt++;
+		nb_pkts--;
+	}
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts, bool offload)
+{
+	struct ci_tx_queue *txq = tx_queue;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, nb_mbuf, tx_id;
+	const uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	const uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, true);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free,
+			(uint32_t)nb_pkts * 2);
+	nb_commit &= (uint16_t)~1;
+	if (unlikely(nb_commit == 0))
+		return 0;
+
+	nb_pkts = nb_commit >> 1;
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id >> 1];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+	if (nb_commit >= n) {
+		nb_mbuf = n >> 1;
+		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+		ice_ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload);
+		tx_pkts += nb_mbuf - 1;
+		txdp += n - 2;
+		ice_ctx_vtx1(txdp, *tx_pkts++, rs, offload);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		tx_id = 0;
+		txdp = txq->ci_tx_ring;
+		txep = txq->sw_ring_vec;
+	}
+
+	nb_mbuf = nb_commit >> 1;
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+	ice_ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload);
+	tx_id = (uint16_t)(tx_id + nb_commit);
+
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64((uint64_t)CI_TX_DESC_CMD_RS << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_pkts_vec_avx2_ctx_common(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts, bool offload)
+{
+	struct ci_tx_queue *txq = tx_queue;
+	uint16_t nb_tx = 0;
+
+	while (nb_pkts) {
+		const uint16_t num = RTE_MIN(nb_pkts, txq->tx_rs_thresh >> 1);
+		const uint16_t ret = ice_xmit_fixed_burst_vec_avx2_ctx(tx_queue,
+				&tx_pkts[nb_tx], num, offload);
+
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
+uint16_t
+ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue,
+		struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	return ice_xmit_pkts_vec_avx2_ctx_common(tx_queue, tx_pkts, nb_pkts, true);
+}
+
 static __rte_always_inline uint16_t
 ice_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts, bool offload)
-- 
2.34.1

