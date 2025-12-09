Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75000D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A8D040A77;
	Tue,  9 Dec 2025 12:27:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6A254406BB
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279630; x=1796815630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F8zfcTQsqweYJ/1YKzOXv1DQ8xGyvNBNv+rGl+sj0oA=;
 b=RpgA+0Owei7NbJeO+BPHCHjtx0cYSxyneYvYwDiuL0gun5LKAvVZncod
 GYgw3dCEL/v+xSImKvLOJ23tCw6BUaA5zH9rynTrEdXRmAz2rWjWE0esI
 yJ7jna4Zi6z30FlClbc3q3fdBb6W8lQgcAVWRnoZBzd7qkIwapfMrYy8Z
 B44veSWSU0n5slogHzkJfovqRdcNe5BtDreMAW7zmMQCE9eYuSD1GpU+m
 UgoZu4lAFauBZjscNm5WDr+hzz+IZ9y8nWDg8Y1HGcwryXint3bgTB3Q9
 H1EbuOR9sxixuca5VW0rFzdhxEY+dfAcufs4olTj7GvY0IZ9chu69A31o A==;
X-CSE-ConnectionGUID: pmRXD12FRw+Eq7AYyE+oXg==
X-CSE-MsgGUID: xdGnh/hqSNmjFQojKKK7Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117034"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117034"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:09 -0800
X-CSE-ConnectionGUID: 5U7RBzmGTHO3nu8Hie4DCQ==
X-CSE-MsgGUID: d8dyiIfNSNemiFYKYPHH6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270193"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:08 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 03/13] net/ice: use common Tx path selection infrastructure
Date: Tue,  9 Dec 2025 11:26:42 +0000
Message-ID: <20251209112652.963981-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

Replace the existing complicated logic with the use of the common
function. Introduce a new feature "simple tx" to the common
infrastructure which represents whether or not a simplified transmit
path may be selected for the device.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h               |  10 ++
 drivers/net/intel/ice/ice_rxtx.c            | 142 +++++++++-----------
 drivers/net/intel/ice/ice_rxtx.h            |  30 ++++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  35 +----
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |   6 -
 5 files changed, 103 insertions(+), 120 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index c6c1904ba3..3480c5e07c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -118,15 +118,21 @@ struct ci_tx_queue {
 	};
 };
 
+struct ci_tx_path_features_extra {
+	bool simple_tx;
+};
+
 struct ci_tx_path_features {
 	uint32_t tx_offloads;
 	enum rte_vect_max_simd simd_width;
+	struct ci_tx_path_features_extra extra;
 };
 
 struct ci_tx_path_info {
 	eth_tx_burst_t pkt_burst;
 	const char *info;
 	struct ci_tx_path_features features;
+	eth_tx_prep_t pkt_prep;
 };
 
 static __rte_always_inline void
@@ -302,6 +308,10 @@ ci_tx_path_select(struct ci_tx_path_features req_features,
 	for (i = 0; i < num_paths; i++) {
 		const struct ci_tx_path_features *path_features = &infos[i].features;
 
+		/* Do not use a simple tx path if not requested. */
+		if (path_features->extra.simple_tx && !req_features.extra.simple_tx)
+			continue;
+
 		/* Ensure the path supports the requested TX offloads. */
 		if ((path_features->tx_offloads & req_features.tx_offloads) !=
 				req_features.tx_offloads)
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index f05ca83e5b..ca9cdc9618 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4091,39 +4091,70 @@ ice_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return i;
 }
 
-static const struct {
-	eth_tx_burst_t pkt_burst;
-	const char *info;
-} ice_tx_burst_infos[] = {
+static const struct ci_tx_path_info ice_tx_path_infos[] = {
 	[ICE_TX_DEFAULT] = {
 		.pkt_burst = ice_xmit_pkts,
-		.info = "Scalar"
+		.info = "Scalar",
+		.features = {
+			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
+		},
+		.pkt_prep = ice_prep_pkts
 	},
 	[ICE_TX_SIMPLE] = {
 		.pkt_burst = ice_xmit_pkts_simple,
-		.info = "Scalar Simple"
+		.info = "Scalar Simple",
+		.features = {
+			.tx_offloads = ICE_TX_SCALAR_OFFLOADS,
+			.extra.simple_tx = true
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
 	},
 #ifdef RTE_ARCH_X86
 	[ICE_TX_SSE] = {
 		.pkt_burst = ice_xmit_pkts_vec,
-		.info = "Vector SSE"
+		.info = "Vector SSE",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
 	},
 	[ICE_TX_AVX2] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx2,
-		.info = "Vector AVX2"
+		.info = "Vector AVX2",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
 	},
 	[ICE_TX_AVX2_OFFLOAD] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
-		.info = "Offload Vector AVX2"
+		.info = "Offload Vector AVX2",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.pkt_prep = ice_prep_pkts
 	},
 #ifdef CC_AVX512_SUPPORT
 	[ICE_TX_AVX512] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512,
-		.info = "Vector AVX512"
+		.info = "Vector AVX512",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
 	},
 	[ICE_TX_AVX512_OFFLOAD] = {
 		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
-		.info = "Offload Vector AVX512"
+		.info = "Offload Vector AVX512",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.pkt_prep = ice_prep_pkts
 	},
 #endif
 #endif
@@ -4135,85 +4166,36 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int mbuf_check = ad->devargs.mbuf_check;
-#ifdef RTE_ARCH_X86
-	struct ci_tx_queue *txq;
-	int i;
-	int tx_check_ret = -1;
-	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 
 	/* The primary process selects the tx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto out;
 
-	tx_check_ret = ice_tx_vec_dev_check(dev);
-	tx_simd_width = ice_get_max_simd_bitwidth();
-	if (tx_check_ret >= 0 &&
-		rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		ad->tx_vec_allowed = true;
-
-		if (tx_simd_width < RTE_VECT_SIMD_256 &&
-			tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
-			ad->tx_vec_allowed = false;
+	req_features.extra.simple_tx = ad->tx_simple_allowed;
 
-		if (ad->tx_vec_allowed) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
-				txq = dev->data->tx_queues[i];
-				if (txq && ice_txq_vec_setup(txq)) {
-					ad->tx_vec_allowed = false;
-					break;
-				}
-			}
-		}
-	} else {
-		ad->tx_vec_allowed = false;
-	}
-
-	if (ad->tx_vec_allowed) {
-		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
-		if (tx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				ad->tx_func_type = ICE_TX_AVX512_OFFLOAD;
-				dev->tx_pkt_prepare = ice_prep_pkts;
-			} else {
-				ad->tx_func_type = ICE_TX_AVX512;
-			}
-#endif
-		} else {
-			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				ad->tx_func_type = ICE_TX_AVX2_OFFLOAD;
-				dev->tx_pkt_prepare = ice_prep_pkts;
-			} else {
-				ad->tx_func_type = tx_simd_width == RTE_VECT_SIMD_256 ?
-						    ICE_TX_AVX2 :
-						    ICE_TX_SSE;
-			}
-		}
-
-		goto out;
-	}
+#ifdef RTE_ARCH_X86
+	if (ice_tx_vec_dev_check(dev) != -1)
+		req_features.simd_width = ice_get_max_simd_bitwidth();
 #endif
 
-	if (ad->tx_simple_allowed) {
-		PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
-		dev->tx_pkt_burst = ice_xmit_pkts_simple;
-		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
-	} else {
-		PMD_INIT_LOG(DEBUG, "Normal tx finally be used.");
-		dev->tx_pkt_burst = ice_xmit_pkts;
-		dev->tx_pkt_prepare = ice_prep_pkts;
-	}
+	ad->tx_func_type = ci_tx_path_select(req_features,
+						&ice_tx_path_infos[0],
+						RTE_DIM(ice_tx_path_infos),
+						ICE_TX_DEFAULT);
 
-	if (mbuf_check) {
-		ad->tx_pkt_burst = dev->tx_pkt_burst;
-		dev->tx_pkt_burst = ice_xmit_pkts_check;
-	}
+	if (ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		ad->tx_vec_allowed = true;
 
 out:
 	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
-					 ice_tx_burst_infos[ad->tx_func_type].pkt_burst;
+					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = ice_tx_path_infos[ad->tx_func_type].pkt_prep;
 	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
-		ice_tx_burst_infos[ad->tx_func_type].info, dev->data->port_id);
+		ice_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 }
 
 int
@@ -4224,10 +4206,10 @@ ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(ice_tx_burst_infos); ++i) {
-		if (pkt_burst == ice_tx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(ice_tx_path_infos); ++i) {
+		if (pkt_burst == ice_tx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 ice_tx_burst_infos[i].info);
+				 ice_tx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 141a62a7da..d7e8c1b0c4 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -108,6 +108,35 @@
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
+/* basic scalar path */
+#define ICE_TX_SCALAR_OFFLOADS (		\
+	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+	RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+	RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |	\
+	RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+/* basic vector path */
+#define ICE_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+/* vector offload paths */
+#define ICE_TX_VECTOR_OFFLOAD_OFFLOADS (	\
+	ICE_TX_VECTOR_OFFLOADS |		\
+	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
+
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
 
@@ -249,7 +278,6 @@ void ice_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq,
 int ice_rx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_tx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_rxq_vec_setup(struct ci_rx_queue *rxq);
-int ice_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts);
 uint16_t ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 39581cb7ae..ff46a8fb49 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -51,28 +51,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 	memset(rxq->sw_ring, 0, sizeof(rxq->sw_ring[0]) * rxq->nb_rx_desc);
 }
 
-#define ICE_TX_NO_VECTOR_FLAGS (			\
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
-		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
-
-#define ICE_TX_VECTOR_OFFLOAD (				\
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
-
-#define ICE_VECTOR_PATH		0
-#define ICE_VECTOR_OFFLOAD_PATH	1
-
 static inline int
 ice_rx_vec_queue_default(struct ci_rx_queue *rxq)
 {
@@ -98,13 +76,7 @@ ice_tx_vec_queue_default(struct ci_tx_queue *txq)
 	    txq->tx_rs_thresh > ICE_TX_MAX_FREE_BUF_SZ)
 		return -1;
 
-	if (txq->offloads & ICE_TX_NO_VECTOR_FLAGS)
-		return -1;
-
-	if (txq->offloads & ICE_TX_VECTOR_OFFLOAD)
-		return ICE_VECTOR_OFFLOAD_PATH;
-
-	return ICE_VECTOR_PATH;
+	return 0;
 }
 
 static inline int
@@ -130,18 +102,15 @@ ice_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	int i;
 	struct ci_tx_queue *txq;
 	int ret = 0;
-	int result = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		ret = ice_tx_vec_queue_default(txq);
 		if (ret < 0)
 			return -1;
-		if (ret == ICE_VECTOR_OFFLOAD_PATH)
-			result = ret;
 	}
 
-	return result;
+	return ret;
 }
 
 static inline void
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index 1545bc3b6e..4fc1b7e881 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -718,12 +718,6 @@ ice_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-ice_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 ice_rx_vec_dev_check(struct rte_eth_dev *dev)
 {
-- 
2.43.0

