Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0800C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F28B42EAB;
	Tue, 15 Sep 2026 15:37:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 224B442E7D
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479449; x=1821015449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T0Ag3ayzmlcA9GRaSv6ftqZ/GOID9LXswLI7cRKrBzI=;
 b=gisDIT1nu8oeK6ukm6V6Qyo4R+hzbAKjlWHiTcQpS6sybsCAycuiVlr9
 p0+ixyfEdMvaYQbn0ek1L/rrC8Wul5ay0Wn0vc9QHhEfUn3lNYJyEyNk/
 eu4kA5FNpFF6zIdSVSdxH/Cdg7s2Kgdk8D0ZxhvG0QjADeKUbOqg1f7Bv
 466BrHv4uBgV+S4dQseCx38AhUwUOrOOyGEr8scRTF9fD6Mh+7ZMmUNWk
 Cbmf84Lulba56V5opXUUSui9n9MGSVf4SFGrxYot8XOv9/jZysIl5GEdJ
 H0+i32sHHFAcyZzO13beqsbYwKT625pH2bCuHwkknti2fFFsDUaZZBScI g==;
X-CSE-ConnectionGUID: OBfFnHEWRVWr2mEQXcnaNQ==
X-CSE-MsgGUID: fh5zKUIXRZ6NzJp8Wsb2rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972538"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972538"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:28 -0700
X-CSE-ConnectionGUID: Xy1LxmUtQkWH84mAwc+3nA==
X-CSE-MsgGUID: h+iYP+McRn6xH9HkWNSrrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800774"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 14/15] net/ice: enable context desc offloads for vector Tx
Date: Tue, 15 Sep 2026 14:36:51 +0100
Message-ID: <20260915133654.278780-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915133654.278780-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
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

Use the context descriptor Tx vector paths from intel/common in ice
driver to enable more offloads on the vector path for ice driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst      |  6 ++++
 drivers/net/intel/ice/ice_ethdev.h          |  3 ++
 drivers/net/intel/ice/ice_rxtx.c            | 31 ++++++++++++++++++---
 drivers/net/intel/ice/ice_rxtx.h            | 11 ++++++++
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 24 ++++++++++++++++
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 24 ++++++++++++++++
 6 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6c29513041..c1c51c62ec 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -69,6 +69,12 @@ New Features
   Added ``fdir_buffer_size`` devarg to select the Flow Director table size
   (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
 
+* **Updated Intel ice driver.**
+
+  * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx
+    paths, enabling QinQ tag insertion and outer IPv4/UDP checksum
+    offloads on those paths.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 1d038016af..3cfd7afbae 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -213,8 +213,10 @@ enum ice_tx_func_type {
 	ICE_TX_SIMPLE,
 	ICE_TX_AVX2,
 	ICE_TX_AVX2_OFFLOAD,
+	ICE_TX_AVX2_CTX_OFFLOAD,
 	ICE_TX_AVX512,
 	ICE_TX_AVX512_OFFLOAD,
+	ICE_TX_AVX512_CTX_OFFLOAD,
 	ICE_TX_NEON,
 };
 
@@ -676,6 +678,7 @@ struct ice_adapter {
 	bool rx_bulk_alloc_allowed;
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
+	bool use_ctx;
 	enum ice_rx_func_type rx_func_type;
 	enum ice_tx_func_type tx_func_type;
 	/* ptype mapping table */
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 06920745ed..50cacadc44 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -890,6 +890,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	/* record what kind of descriptor cleanup we need on teardown */
 	txq->use_vec_entry = ad->tx_vec_allowed || ad->tx_simple_allowed;
+	txq->use_ctx = ad->use_ctx;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_set_txtime_qgrp *ts_elem;
@@ -1200,7 +1201,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	ice_reset_tx_queue(txq);
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1263,7 +1264,7 @@ ice_fdir_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	txq->qtx_tail = NULL;
 
 	return 0;
@@ -1751,7 +1752,7 @@ ice_tx_queue_release(void *txq)
 		return;
 	}
 
-	ci_txq_release_all_mbufs(q, false);
+	ci_txq_release_all_mbufs(q, q->use_ctx);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
 	if (q->tsq) {
@@ -3533,7 +3534,8 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.features = {
 			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
 		},
-		.pkt_prep = ice_prep_pkts
+		.pkt_prep = ice_prep_pkts,
+		.supports_ctx = true
 	},
 	[ICE_TX_SIMPLE] = {
 		.pkt_burst = ice_xmit_pkts_simple,
@@ -3563,6 +3565,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		},
 		.pkt_prep = ice_prep_pkts
 	},
+	[ICE_TX_AVX2_CTX_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2_ctx_offload,
+		.info = "Offload Vector AVX2 Ctx",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.pkt_prep = ice_prep_pkts,
+		.supports_ctx = true
+	},
 #ifdef CC_AVX512_SUPPORT
 	[ICE_TX_AVX512] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512,
@@ -3582,6 +3594,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		},
 		.pkt_prep = ice_prep_pkts
 	},
+	[ICE_TX_AVX512_CTX_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512_ctx_offload,
+		.info = "Offload Vector AVX512 Ctx",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.pkt_prep = ice_prep_pkts,
+		.supports_ctx = true
+	},
 #endif
 #elif defined(RTE_ARCH_ARM64)
 	[ICE_TX_NEON] = {
@@ -3795,6 +3817,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	ad->tx_vec_allowed =
 		(ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128);
 #endif
+	ad->use_ctx = ice_tx_path_infos[ad->tx_func_type].supports_ctx;
 
 	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
 					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 999b6b30d6..bee8a464f5 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -135,6 +135,12 @@
 	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
 	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
 	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
+/* vector ctx offload path: QinQ outer tag + outer/tunnel checksum via ctx desc */
+#define ICE_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (	\
+	ICE_TX_VECTOR_OFFLOAD_OFFLOADS |	\
+	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
@@ -284,6 +290,8 @@ uint16_t ice_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts);
 uint16_t ice_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts);
+uint16_t ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
+					uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				  uint16_t nb_pkts);
 uint16_t ice_recv_pkts_vec_avx512_offload(void *rx_queue,
@@ -300,6 +308,9 @@ uint16_t ice_xmit_pkts_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
 					  struct rte_mbuf **tx_pkts,
 					  uint16_t nb_pkts);
+uint16_t ice_xmit_pkts_vec_avx512_ctx_offload(void *tx_queue,
+					  struct rte_mbuf **tx_pkts,
+					  uint16_t nb_pkts);
 int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
 int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
index 00b5d51aab..056b2dc49b 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
@@ -810,6 +810,30 @@ ice_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return ice_xmit_pkts_vec_avx2_common(tx_queue, tx_pkts, nb_pkts, true);
 }
 
+uint16_t
+ice_xmit_pkts_vec_avx2_ctx_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		/* cross rs_thresh boundary is not allowed */
+		num = (uint16_t)RTE_MIN(nb_pkts << 1, txq->tx_rs_thresh);
+		num = num >> 1;
+		ret = ci_xmit_fixed_burst_vec_ctx_avx2(tx_queue, &tx_pkts[nb_tx], num,
+				true, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC, NULL);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
 int __rte_cold
 ice_rxq_vec_setup(struct ci_rx_queue *rxq)
 {
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
index d8ede5cb42..0548c293bb 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
@@ -882,3 +882,27 @@ ice_xmit_pkts_vec_avx512_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	return ice_xmit_pkts_vec_avx512_common(tx_queue, tx_pkts, nb_pkts, true);
 }
+
+uint16_t
+ice_xmit_pkts_vec_avx512_ctx_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
+				     uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		/* cross rs_thresh boundary is not allowed */
+		num = (uint16_t)RTE_MIN(nb_pkts << 1, txq->tx_rs_thresh);
+		num = num >> 1;
+		ret = ci_xmit_fixed_burst_vec_ctx_avx512(tx_queue, &tx_pkts[nb_tx], num,
+				true, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC, NULL);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
-- 
2.53.0

