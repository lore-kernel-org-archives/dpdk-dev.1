Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739FC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0EB640684;
	Thu,  7 Aug 2025 14:40:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2B9EA40650
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570417; x=1786106417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FTXb7fr92fvRRMP2b/MF7qXx+rUQFuuWihcsi+2kRAw=;
 b=BjLIG+kOqfy9/jr3V7gtxsn/xtQ6rrt4H0MW0V7LIAgz8+461czJ+pRp
 dTQluR9JRAQ+MyFccz3/d75PWMfuWKlT03oMAatm5m08+2dViImtb0K5M
 V7+uHZNxr5roidHeggtfaW3Am0QMXAIynTWAErlfcBThAUS5+9G0KytM1
 FDof7siH3ErDbr26QPXxhVz6BUY6RTdP1pMGA/B6SCXI9WhW/sL4XPimh
 GG+6JLxNW4E+Wa39+jBoHVGZJaR/B9x+WZVUT7/P/qIdTrNF5yToihP2Y
 ttj5Ew9Qhuskc2JG3ZOOnr99Wd6t7mCFNm+U9uLhZ3fKwj3x/DbXbCv8x A==;
X-CSE-ConnectionGUID: JHtLHHoKR/eKmKkdmt4arg==
X-CSE-MsgGUID: fOXjVpaVTSuI/AIqQ6eSbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981144"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981144"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:12 -0700
X-CSE-ConnectionGUID: Xzjr2CBlQROjHgyta4DUMQ==
X-CSE-MsgGUID: 72CZ/9FPTP6rt4BtMvjwqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886791"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 15/15] net/i40e: use the common Rx path selection
 infrastructure
Date: Thu,  7 Aug 2025 12:39:49 +0000
Message-Id: <20250807123949.4063416-16-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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
 drivers/net/intel/i40e/i40e_rxtx.c            | 148 +++++++++---------
 drivers/net/intel/i40e/i40e_rxtx.h            |  15 ++
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
 5 files changed, 99 insertions(+), 85 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2a6b74ecc7..f190928d08 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3284,29 +3284,43 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 }
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} i40e_rx_burst_infos[] = {
-	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar" },
-	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered" },
-	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
+static const struct ci_rx_path_info i40e_rx_path_infos[] = {
+	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, 0, 0}},
+	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_PATH_SCATTERED, 0, 0, 0}},
+	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #ifdef RTE_ARCH_X86
-	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE" },
-	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered" },
-	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2" },
-	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
+	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #ifdef CC_AVX512_SUPPORT
-	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512" },
-	[I40E_RX_AVX512_SCATTERED] = {
-		i40e_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
+	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512",
+		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_AVX512_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx512,
+		"Vector AVX512 Scattered", {I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #endif
 #elif defined(RTE_ARCH_ARM64)
-	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon" },
-	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered" },
+	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #elif defined(RTE_ARCH_PPC_64)
-	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec" },
-	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered" },
+	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered",
+		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #endif
 };
 
@@ -3315,7 +3329,12 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 {
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ci_rx_path_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 	uint16_t vector_rx, i;
+	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 
 	/* The primary process selects the rx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
@@ -3324,76 +3343,51 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
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
-		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
-		if (dev->data->scattered_rx)
-			ad->rx_func_type = I40E_RX_NEON_SCATTERED;
-		else
-			ad->rx_func_type = I40E_RX_NEON;
-#elif defined(RTE_ARCH_PPC_64)
+	req_features.simd_width = rx_simd_width;
+	if (dev->data->scattered_rx)
+		req_features.scattered = CI_RX_PATH_SCATTERED;
+	if (ad->rx_bulk_alloc_allowed)
+		req_features.bulk_alloc = CI_RX_PATH_BULK_ALLOC;
+
+	ad->rx_func_type = ci_rx_path_select(req_features,
+						&i40e_rx_path_infos[0],
+						RTE_DIM(i40e_rx_path_infos),
+						I40E_RX_DEFAULT);
+	if (i40e_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		/* Vector function selected. Prepare the rxq accordingly. */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			if (dev->data->rx_queues[i])
+				i40e_rxq_vec_setup(dev->data->rx_queues[i]);
+
+	if (i40e_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128 &&
+			i40e_rx_path_infos[ad->rx_func_type].features.simd_width <
+				RTE_VECT_SIMD_512)
 		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
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
+	dev->rx_pkt_burst = i40e_rx_path_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+			i40e_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 
 	/* Propagate information about RX function choice through all queues. */
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
@@ -3415,10 +3409,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 		}
 	}
 
-out:
-	dev->rx_pkt_burst = i40e_rx_burst_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
-		i40e_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+	ad->rx_vec_allowed = i40e_rx_path_infos[ad->rx_func_type].features.simd_width >=
+				RTE_VECT_SIMD_128;
 }
 
 int
@@ -3429,10 +3421,10 @@ i40e_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(i40e_rx_burst_infos); ++i) {
-		if (pkt_burst == i40e_rx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(i40e_rx_path_infos); ++i) {
+		if (pkt_burst == i40e_rx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 i40e_rx_burst_infos[i].info);
+				 i40e_rx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
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

