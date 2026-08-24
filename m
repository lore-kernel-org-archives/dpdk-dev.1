Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420CC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 10:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DFE14067C;
	Mon, 24 Aug 2026 12:23:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2277240671
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787566988; x=1819102988;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D/SfXtu25lTQmkYNM0JxEJvFQXh7o8gUD1hauI6m2q0=;
 b=HNpMaf8GhwGYnGwlQlRmrSBwqiCnlkniUBYDFTsyftJ9+y3jbKYD2+Ir
 PCbBQVRId0uVuoHSiksM85IKTWUd6xtvKJhaNeJF91tqy/SjnF2lcEd8A
 P2FKdKrD/zaJSFcDu/gmIa1Fm3sSnlo58sMouRfQiVee29e1fGjO5JIlW
 F/PZc1zWpGKZnSv/FUyLPKEdWfk28fXq/9KiyQzr9t3l1ZdbslrrA0++m
 xhtpkdODOBXUuH1DYsImjrD+yHkrzTnCpM+fFYs9yvT4rU1ukGmAmDH/F
 ga0KGHeozeS2UssikL5Ibgovr69pwT8mXkwMO2t84vxLTLdR/Fch4mRol w==;
X-CSE-ConnectionGUID: 3EPzoo4cQLi9Sty+Akiczg==
X-CSE-MsgGUID: OA762TigSQC8l9Z+Gm5s2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87884926"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87884926"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:23:08 -0700
X-CSE-ConnectionGUID: XBzmCXNVQFO3N+VDAHHzHQ==
X-CSE-MsgGUID: VWVWh4yBSMyBj45PWWbyNA==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 03:23:06 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 3/4] net/ice: add AVX2 context descriptor Tx path
Date: Mon, 24 Aug 2026 10:21:53 +0000
Message-Id: <b4330095555cd8da32f211062bca072348c98b3d.1787566677.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787566677.git.anurag.mandal@intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
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
 drivers/net/intel/ice/ice_rxtx.c          |  31 +++++-
 drivers/net/intel/ice/ice_rxtx.h          |   8 ++
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c | 119 ++++++++++++++++++++++
 6 files changed, 163 insertions(+), 5 deletions(-)

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
index c4b5454c53..5ec0b4d1fd 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1193,7 +1193,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	ice_reset_tx_queue(txq);
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1256,7 +1256,7 @@ ice_fdir_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	txq->qtx_tail = NULL;
 
 	return 0;
@@ -1744,7 +1744,7 @@ ice_tx_queue_release(void *txq)
 		return;
 	}
 
-	ci_txq_release_all_mbufs(q, false);
+	ci_txq_release_all_mbufs(q, q->use_ctx);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
 	if (q->tsq) {
@@ -3554,6 +3554,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
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
@@ -3755,11 +3765,17 @@ ice_set_tx_function(struct rte_eth_dev *dev)
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
 	};
+	req_features.ctx_desc = req_features.tx_offloads &
+		(RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		 RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM);
 
 	/* If the device has started the function has already been selected. */
 	if (dev->data->dev_started)
@@ -3785,6 +3801,15 @@ ice_set_tx_function(struct rte_eth_dev *dev)
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
index b72f69a47b..88a3dfb1b6 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -837,6 +837,125 @@ ice_vtx(volatile struct ci_tx_desc *txdp,
 	}
 }
 
+static inline void
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
+static inline void
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
+static inline uint16_t
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
+static inline uint16_t
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

