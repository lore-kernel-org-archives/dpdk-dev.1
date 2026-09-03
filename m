Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3D9C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D685D4281D;
	Thu,  3 Sep 2026 19:04:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 68CC2427E8
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788455067; x=1819991067;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XNOIMahCYtNKPLsQKD7iYXmo74s/djB1BlPn97fdtX4=;
 b=iYCqxGY4XMz9Y4guqVcGWiUCGb0s3VN1zi94MdsNkQaV4zViKqkvpwvo
 Y5poGOwEA/7ALibrw2co6ruyAKFC3qaoDPzt2LLmhiF8lcfim8lZbBxiI
 uUHr/CpGt4svguyXa6SdwP2ll2XfIFfTf2PSmjmNCxKUKktJsxxUKuWI6
 +P8vJHhI8s4Se5WCfWK9E8FzvZESyy+GrWSU6RAAJQRvYmkdco2EzTXnw
 VFNvehe4bGBEqT08f3+TAF/qRlKNSx9FPQt8rwjjeAtP0Pfwbfmeip2OF
 /BbrjwX2Cp5glQzxT/0V9OBBOVOatIbZJMhfTJ1LV8lk1LPtiSGx2unz+ g==;
X-CSE-ConnectionGUID: nGASabtSQyuI2gwgd3hgOw==
X-CSE-MsgGUID: gGb87zYUQ3itJ/oOiVAKzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100463277"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100463277"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:04:26 -0700
X-CSE-ConnectionGUID: HCm1qJyuQ8aRpYGnZ+cHCA==
X-CSE-MsgGUID: hLod7xkKQzmrAenEGGeMEw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2026 10:04:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 13/13] net/ice: enable context desc offloads for vector Tx
Date: Thu,  3 Sep 2026 18:04:21 +0100
Message-ID: <20260903170421.361293-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
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
index 907f9013ff..47eccd9401 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,12 @@ New Features
   * Renamed the ``enable_ptype_lldp`` devarg to ``enable_lldp``.
     The old name is no longer accepted.
 
+* **Updated Intel ice driver.**
+
+  * Added Tx context descriptor support to the AVX2 and AVX512 vector Tx
+    paths, enabling QinQ tag insertion and outer IPv4/UDP checksum
+    offloads on those paths.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..d357181a2a 100644
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
 
@@ -673,6 +675,7 @@ struct ice_adapter {
 	bool rx_bulk_alloc_allowed;
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
+	bool use_ctx;
 	enum ice_rx_func_type rx_func_type;
 	enum ice_tx_func_type tx_func_type;
 	/* ptype mapping table */
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 313cbd25d5..c6a464b2c1 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -883,6 +883,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	/* record what kind of descriptor cleanup we need on teardown */
 	txq->use_vec_entry = ad->tx_vec_allowed || ad->tx_simple_allowed;
+	txq->use_ctx = ad->use_ctx;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
 		struct ice_aqc_set_txtime_qgrp *ts_elem;
@@ -1193,7 +1194,7 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	ice_reset_tx_queue(txq);
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
@@ -1256,7 +1257,7 @@ ice_fdir_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return -EINVAL;
 	}
 
-	ci_txq_release_all_mbufs(txq, false);
+	ci_txq_release_all_mbufs(txq, txq->use_ctx);
 	txq->qtx_tail = NULL;
 
 	return 0;
@@ -1744,7 +1745,7 @@ ice_tx_queue_release(void *txq)
 		return;
 	}
 
-	ci_txq_release_all_mbufs(q, false);
+	ci_txq_release_all_mbufs(q, q->use_ctx);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
 	if (q->tsq) {
@@ -3526,7 +3527,8 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.features = {
 			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
 		},
-		.pkt_prep = ice_prep_pkts
+		.pkt_prep = ice_prep_pkts,
+		.supports_ctx = true
 	},
 	[ICE_TX_SIMPLE] = {
 		.pkt_burst = ice_xmit_pkts_simple,
@@ -3556,6 +3558,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
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
@@ -3575,6 +3587,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
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
@@ -3788,6 +3810,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
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

