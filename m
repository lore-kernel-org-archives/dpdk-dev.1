Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5382BC87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C60406BC;
	Fri, 25 Jul 2025 14:50:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id CDEDD40693
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447821; x=1784983821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5yd7paFjs6zFQCpYgvPj/IzLFNB+K5Hbj81+kCJEZyo=;
 b=JHK7UikuvvLRgpMJEbR7TdnMEajRUZpt9jgyGew4BT8ydKYn66R2fzqh
 GCb/OW1LHVzlbq9jsbJ7TiDm9UBwZf91hGFpP49aiQAjgwNyAI4ij3vd/
 tGsJC+guqwv0vd7fn4BXYpd8Tx84zJYI5a1OxoBr8Vk9R538lOPuNxSn2
 /BvhN77t5V7JDAnqwo1ROee7QZA9xZ9iPat4ZK06PqYmiokjHEctq5PF+
 csg8N8vurXTDbAzzB8icH4hDH8HTrEpPGLEQlsgZdX9kKL21XedmSfftf
 bvrWWK5kGl1rkv0Z2KBsT3nAvRv76h8C+yGmNopS8E/+6my0dYuSNGLwb w==;
X-CSE-ConnectionGUID: USiIdtuZQEiKikrNtH9S2w==
X-CSE-MsgGUID: lOFwBCqYSc+ZZyLvxJ4fTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480164"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480164"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:20 -0700
X-CSE-ConnectionGUID: Mh6SVLIQR6298kq95s74Nw==
X-CSE-MsgGUID: KJIQXfCXSlypDDQGowLkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152357"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:19 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 14/14] net/i40e: use the common Rx path selection
 infrastructure
Date: Fri, 25 Jul 2025 12:49:19 +0000
Message-Id: <20250725124919.3564890-15-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

Replace the existing complicated logic with the use of the common function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c            | 145 +++++++++---------
 drivers/net/intel/i40e/i40e_rxtx.h            |  15 ++
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
 5 files changed, 98 insertions(+), 83 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c0e217cd73..5adb134667 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3284,29 +3284,43 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 }
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} i40e_rx_burst_infos[] = {
-	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered" },
-	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
-	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar" },
+static const struct ci_rx_burst_info i40e_rx_burst_infos[] = {
+	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_SCATTERED}},
+	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_NO_FEATURES}},
 #ifdef RTE_ARCH_X86
 #ifdef CC_AVX512_SUPPORT
-	[I40E_RX_AVX512_SCATTERED] = {
-		i40e_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
-	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512" },
+	[I40E_RX_AVX512_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx512,
+		"Vector AVX512 Scattered", {I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
-	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
-	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2" },
-	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered" },
-	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE" },
-#elif defined(RTE_ARCH_ARM64)
-	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered" },
-	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon" },
+	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+#elif defined(RTE_ARCH_ARM64) /* TODO: update offloads for NEON and Altivec */
+	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #elif defined(RTE_ARCH_PPC_64)
-	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered" },
-	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec" },
+	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
 };
 
@@ -3315,7 +3329,13 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 {
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ci_rx_burst_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.other_features_mask = CI_RX_BURST_NO_FEATURES
+	};
 	uint16_t vector_rx, i;
+	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 
 	/* The primary process selects the rx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
@@ -3324,76 +3344,51 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	/* In order to allow Vector Rx there are a few configuration
 	 * conditions to be met and Rx Bulk Allocation should be allowed.
 	 */
-#ifdef RTE_ARCH_X86
-	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
-#endif
+
 	if (i40e_rx_vec_dev_conf_condition_check(dev) || !ad->rx_bulk_alloc_allowed) {
 		PMD_INIT_LOG(DEBUG, "Port[%d] doesn't meet"
 				" Vector Rx preconditions",
 				dev->data->port_id);
 
-		ad->rx_vec_allowed = false;
+		rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	}
-	if (ad->rx_vec_allowed) {
+	if (rx_simd_width != RTE_VECT_SIMD_DISABLED) {
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
 			struct ci_rx_queue *rxq =
 				dev->data->rx_queues[i];
 
 			if (rxq && i40e_rxq_vec_setup(rxq)) {
-				ad->rx_vec_allowed = false;
+				rx_simd_width = RTE_VECT_SIMD_DISABLED;
 				break;
 			}
 		}
 	}
 
-	if (ad->rx_vec_allowed && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-#ifdef RTE_ARCH_X86
-		if (dev->data->scattered_rx) {
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				ad->rx_func_type = I40E_RX_AVX512_SCATTERED;
-#endif
-			} else {
-				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
-					I40E_RX_AVX2_SCATTERED :
-					I40E_RX_SCATTERED;
-				dev->recycle_rx_descriptors_refill =
-					i40e_recycle_rx_descriptors_refill_vec;
-			}
-		} else {
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				ad->rx_func_type = I40E_RX_AVX512;
-#endif
-			} else {
-				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
-					I40E_RX_AVX2 :
-					I40E_RX_SSE;
-				dev->recycle_rx_descriptors_refill =
-					i40e_recycle_rx_descriptors_refill_vec;
-			}
-		}
-#elif defined(RTE_ARCH_ARM64)
+	req_features.simd_width = rx_simd_width;
+	if (dev->data->scattered_rx)
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_SCATTERED;
+	if (ad->rx_bulk_alloc_allowed)
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_BULK_ALLOC;
+
+	ad->rx_func_type = ci_rx_burst_mode_select(&i40e_rx_burst_infos[0],
+						req_features,
+						RTE_DIM(i40e_rx_burst_infos),
+						I40E_RX_DEFAULT);
+	if (i40e_rx_burst_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		/* Vector function selected. Prepare the rxq accordingly. */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			if (dev->data->rx_queues[i])
+				i40e_rxq_vec_setup(dev->data->rx_queues[i]);
+
+	if (i40e_rx_burst_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128 &&
+			i40e_rx_burst_infos[ad->rx_func_type].features.simd_width <
+				RTE_VECT_SIMD_512)
 		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
-		if (dev->data->scattered_rx)
-			ad->rx_func_type = I40E_RX_NEON_SCATTERED;
-		else
-			ad->rx_func_type = I40E_RX_NEON;
-#elif defined(RTE_ARCH_PPC_64)
-		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
-		if (dev->data->scattered_rx)
-			ad->rx_func_type = I40E_RX_ALTIVEC_SCATTERED;
-		else
-			ad->rx_func_type = I40E_RX_ALTIVEC;
-#endif /* RTE_ARCH_X86 */
-	} else if (!dev->data->scattered_rx && ad->rx_bulk_alloc_allowed) {
-		dev->rx_pkt_burst = i40e_recv_pkts_bulk_alloc;
-	} else {
-		/* Simple Rx Path. */
-		dev->rx_pkt_burst = dev->data->scattered_rx ?
-					i40e_recv_scattered_pkts :
-					i40e_recv_pkts;
-	}
+
+out:
+	dev->rx_pkt_burst = i40e_rx_burst_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+			i40e_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
 
 	/* Propagate information about RX function choice through all queues. */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
@@ -3415,10 +3410,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 		}
 	}
 
-out:
-	dev->rx_pkt_burst = i40e_rx_burst_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
-		i40e_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+	ad->rx_vec_allowed = i40e_rx_burst_infos[ad->rx_func_type].features.simd_width >=
+				RTE_VECT_SIMD_128;
 }
 
 int
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index b867e18daf..5d5d4e08b0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -67,6 +67,21 @@ enum i40e_header_split_mode {
 			       I40E_HEADER_SPLIT_UDP_TCP | \
 			       I40E_HEADER_SPLIT_SCTP)
 
+#define I40E_RX_SCALAR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+		RTE_ETH_RX_OFFLOAD_SCATTER |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
+
+#define I40E_RX_VECTOR_OFFLOADS I40E_RX_SCALAR_OFFLOADS
+
 /** Offload features */
 union i40e_tx_offload {
 	uint64_t data;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 8a4a1a77bf..87a57e7520 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -558,3 +558,9 @@ i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
 	return i40e_rx_vec_dev_conf_condition_check_default(dev);
 }
+
+enum rte_vect_max_simd
+i40e_get_max_simd_bitwidth(void)
+{
+	return rte_vect_get_max_simd_bitwidth();
+}
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
index d19b9e4bf4..e118df9ce0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
@@ -54,8 +54,6 @@ static inline int
 i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 {
 #ifndef RTE_LIBRTE_IEEE1588
-	struct i40e_adapter *ad =
-		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 
 	/* no QinQ support */
@@ -66,15 +64,12 @@ i40e_rx_vec_dev_conf_condition_check_default(struct rte_eth_dev *dev)
 	 * Vector mode is allowed only when number of Rx queue
 	 * descriptor is power of 2.
 	 */
-	ad->rx_vec_allowed = true;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		struct ci_rx_queue *rxq = dev->data->rx_queues[i];
 		if (!rxq)
 			continue;
-		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads)) {
-			ad->rx_vec_allowed = false;
-			break;
-		}
+		if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
+			return -1;
 	}
 
 	return 0;
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index 64ffb2f6df..c9098e4c1a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -708,3 +708,9 @@ i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
 	return i40e_rx_vec_dev_conf_condition_check_default(dev);
 }
+
+enum rte_vect_max_simd
+i40e_get_max_simd_bitwidth(void)
+{
+	return rte_vect_get_max_simd_bitwidth();
+}
-- 
2.34.1

