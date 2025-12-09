Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E763D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC93940C35;
	Tue,  9 Dec 2025 12:27:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE4C40A6C
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279634; x=1796815634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HFbf4fVMFxXveNqzpmyXGHtawkU36HgZb0n5/lais9k=;
 b=jagojAUY2UaVVdziLJZI/QHYcyKJoGXAdN3ButscVompr4MwPn6GsvQ5
 ag/UB6UcUgY+SxtfQqSrta1/1hu6ElUehsgKgxcBspZDS3wgaxJNhaj3+
 Gcd9t01cOxBaCkh9O9ZfxFAZZRW3PHbBMnN+OcwxvTNgI/s35E482ZfZy
 AOW3W0o4hPssC3f/RY7ebYm23mzm+rVAN3Op0O0lFVOUOlXm1F3ke8EwY
 piGYFCJZjlwWPTCK0CoKeDOvWNI7Fb8ZSpj/qjHlMnkuoptOrgKTxFbUV
 znSqOqNvWqDYiSckcShFccWngqQlpxD176RixbhKyB2+trRS6n/DfGu3q A==;
X-CSE-ConnectionGUID: 1i113F0xSW+93ptov5Y3SA==
X-CSE-MsgGUID: 4ndWXr4iSR+Qpa1eOeLdjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117043"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117043"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:13 -0800
X-CSE-ConnectionGUID: 8QdvSPVrTFCSt1LgzU1shw==
X-CSE-MsgGUID: r7m8AScGRxSMHhD7E8JT8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270223"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:12 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 07/13] net/i40e: use common Tx path selection infrastructure
Date: Tue,  9 Dec 2025 11:26:46 +0000
Message-ID: <20251209112652.963981-8-ciara.loftus@intel.com>
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
function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h          |   2 -
 drivers/net/intel/i40e/i40e_rxtx.c            | 112 +++++++++---------
 drivers/net/intel/i40e/i40e_rxtx.h            |  20 +++-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 -
 6 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 9a89f94f0e..8a86e26858 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1290,8 +1290,6 @@ struct i40e_adapter {
 
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
-
-	enum rte_vect_max_simd tx_simd_width;
 };
 
 /**
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 04c3a6c311..1f9ccd2aa7 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2375,8 +2375,7 @@ i40e_dev_tx_queue_setup_runtime(struct rte_eth_dev *dev,
 
 	/* check vector conflict */
 	if (ad->tx_vec_allowed) {
-		if (txq->tx_rs_thresh > I40E_TX_MAX_FREE_BUF_SZ ||
-		    i40e_txq_vec_setup(txq)) {
+		if (txq->tx_rs_thresh > I40E_TX_MAX_FREE_BUF_SZ) {
 			PMD_DRV_LOG(ERR, "Failed vector tx setup.");
 			return -EINVAL;
 		}
@@ -3519,42 +3518,73 @@ i40e_set_tx_function_flag(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 				txq->queue_id);
 }
 
-static const struct {
-	eth_tx_burst_t pkt_burst;
-	const char *info;
-} i40e_tx_burst_infos[] = {
+static const struct ci_tx_path_info i40e_tx_path_infos[] = {
 	[I40E_TX_DEFAULT] = {
 		.pkt_burst = i40e_xmit_pkts,
 		.info = "Scalar",
+		.features = {
+			.tx_offloads = I40E_TX_SCALAR_OFFLOADS,
+		},
+		.pkt_prep = i40e_prep_pkts,
 	},
 	[I40E_TX_SCALAR_SIMPLE] = {
 		.pkt_burst = i40e_xmit_pkts_simple,
 		.info = "Scalar Simple",
+		.features = {
+			.tx_offloads = I40E_TX_SCALAR_OFFLOADS,
+			.extra.simple_tx = true
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #ifdef RTE_ARCH_X86
 	[I40E_TX_SSE] = {
 		.pkt_burst = i40e_xmit_pkts_vec,
 		.info = "Vector SSE",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 	[I40E_TX_AVX2] = {
 		.pkt_burst = i40e_xmit_pkts_vec_avx2,
 		.info = "Vector AVX2",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #ifdef CC_AVX512_SUPPORT
 	[I40E_TX_AVX512] = {
 		.pkt_burst = i40e_xmit_pkts_vec_avx512,
 		.info = "Vector AVX512",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #endif
 #elif defined(RTE_ARCH_ARM64)
 	[I40E_TX_NEON] = {
 		.pkt_burst = i40e_xmit_pkts_vec,
 		.info = "Vector Neon",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #elif defined(RTE_ARCH_PPC_64)
 	[I40E_TX_ALTIVEC] = {
 		.pkt_burst = i40e_xmit_pkts_vec,
 		.info = "Vector AltiVec",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #endif
 };
@@ -3565,64 +3595,40 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint64_t mbuf_check = ad->mbuf_check;
-	int i;
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.extra.simple_tx = ad->tx_simple_allowed
+	};
 
 	/* The primary process selects the tx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto out;
-#ifdef RTE_ARCH_X86
-	ad->tx_simd_width = i40e_get_max_simd_bitwidth();
-#endif
-	if (ad->tx_vec_allowed) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			struct ci_tx_queue *txq =
-				dev->data->tx_queues[i];
-
-			if (txq && i40e_txq_vec_setup(txq)) {
-				ad->tx_vec_allowed = false;
-				break;
-			}
-		}
-	}
 
-	if (rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_128)
-		ad->tx_vec_allowed = false;
-
-	if (ad->tx_simple_allowed) {
-		if (ad->tx_vec_allowed) {
+	if (ad->tx_vec_allowed) {
 #ifdef RTE_ARCH_X86
-			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				ad->tx_func_type = I40E_TX_AVX512;
+		req_features.simd_width = i40e_get_max_simd_bitwidth();
 #else
-				ad->tx_func_type = I40E_TX_DEFAULT;
+		req_features.simd_width = rte_vect_get_max_simd_bitwidth();
 #endif
-			} else {
-				ad->tx_func_type = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    I40E_TX_AVX2 :
-						    I40E_TX_SSE;
-				dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-			}
-#else /* RTE_ARCH_X86 */
-			ad->tx_func_type = I40E_TX_SSE;
-			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-#endif /* RTE_ARCH_X86 */
-		} else {
-			ad->tx_func_type = I40E_TX_SCALAR_SIMPLE;
-			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-		}
-		dev->tx_pkt_prepare = i40e_simple_prep_pkts;
-	} else {
-		ad->tx_func_type = I40E_TX_DEFAULT;
-		dev->tx_pkt_prepare = i40e_prep_pkts;
 	}
 
+	ad->tx_func_type = ci_tx_path_select(req_features, &i40e_tx_path_infos[0],
+						RTE_DIM(i40e_tx_path_infos), I40E_TX_DEFAULT);
+
 out:
 	dev->tx_pkt_burst = mbuf_check ? i40e_xmit_pkts_check :
-					i40e_tx_burst_infos[ad->tx_func_type].pkt_burst;
+					i40e_tx_path_infos[ad->tx_func_type].pkt_burst;
 
 	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
-		i40e_tx_burst_infos[ad->tx_func_type].info, dev->data->port_id);
+		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
+
+	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
+			ad->tx_func_type == I40E_TX_SSE ||
+			ad->tx_func_type == I40E_TX_NEON ||
+			ad->tx_func_type == I40E_TX_ALTIVEC ||
+			ad->tx_func_type == I40E_TX_AVX2)
+		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
 }
 
 int
@@ -3633,10 +3639,10 @@ i40e_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(i40e_tx_burst_infos); ++i) {
-		if (pkt_burst == i40e_tx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(i40e_tx_path_infos); ++i) {
+		if (pkt_burst == i40e_tx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 i40e_tx_burst_infos[i].info);
+				 i40e_tx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index b5a901794f..ed173d8f17 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -91,6 +91,25 @@ enum i40e_header_split_mode {
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
+#define I40E_TX_SCALAR_OFFLOADS (			\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+
+#define I40E_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+
 /** Offload features */
 union i40e_tx_offload {
 	uint64_t data;
@@ -165,7 +184,6 @@ uint16_t i40e_recv_scattered_pkts_vec(void *rx_queue,
 				      uint16_t nb_pkts);
 int i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
 int i40e_rxq_vec_setup(struct ci_rx_queue *rxq);
-int i40e_txq_vec_setup(struct ci_tx_queue *txq);
 void i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 uint16_t i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 87a57e7520..bbb6d907cf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -547,12 +547,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue __rte_unused * txq)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index c9098e4c1a..b5be0c1b59 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -697,12 +697,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index c035408dcc..c209135890 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -704,12 +704,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
-- 
2.43.0

