Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B7C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5792340431;
	Thu,  7 Aug 2025 14:39:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 84F904027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570395; x=1786106395;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FC557gPVHf+k6SIz3f9V2PBpcExmDJcqQk3WW/480Gs=;
 b=Ph2SyGavmzz1nPTljakXNBRWbXfajdhvR7HLAGpAdR1ehV4Z5+G64brm
 vjNrt+Vgbf0sdOQMv1LUeyX4xmPYXTe/18X/81/gYWzVcUb8LczulKEHA
 T02jCyDBIQAW9RLY1Vq75fkPTNU1e+MxHipJMcm/b7aeMevdo+nS9Pk71
 VGqpztp+KZblIQKpHMcq+NBkeY1fTiNJ7N/LrTHwwKOTV0j8sn/n+iOMy
 ZI0GHwl/KFoM04MmmtGkr6HtPEtNDqq5B9RqqoRMGloZG0foRolPXxxE9
 TPcgZjVB/GCxiKS+hnoLssgTZpoPd4fSqfTknu03BIkcq487ZDees642H Q==;
X-CSE-ConnectionGUID: GjAOdpIvSMGU4V/zaPB+5A==
X-CSE-MsgGUID: SGUbXtizSDe1DtwI3iP6ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981112"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981112"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:39:55 -0700
X-CSE-ConnectionGUID: Hg1PPudDSrCnqvt2Rrnoeg==
X-CSE-MsgGUID: ihmOV0dcSxK/P4qVTE6cZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886707"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:39:54 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 01/15] net/ice: use the same Rx path across process types
Date: Thu,  7 Aug 2025 12:39:35 +0000
Message-Id: <20250807123949.4063416-2-ciara.loftus@intel.com>
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

In the interest of simplicity, let the primary process select the Rx
path to be used by all processes using the given device.

The many logs which report individual Rx path selections have been
consolidated into one single log.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
* reordered ice_rx_func_type and ice_rx_burst_infos elements
---
 drivers/net/intel/ice/ice_ethdev.c |   2 +
 drivers/net/intel/ice/ice_ethdev.h |  19 ++-
 drivers/net/intel/ice/ice_rxtx.c   | 234 ++++++++++++-----------------
 3 files changed, 113 insertions(+), 142 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..a8c570026a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3684,6 +3684,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
 	ad->rx_bulk_alloc_allowed = true;
 	ad->tx_simple_allowed = true;
 
+	ad->rx_func_type = ICE_RX_DEFAULT;
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8e5799f8b4..4505644f87 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -191,6 +191,22 @@ enum pps_type {
 	PPS_MAX,
 };
 
+enum ice_rx_func_type {
+	ICE_RX_DEFAULT,
+	ICE_RX_SCATTERED,
+	ICE_RX_BULK_ALLOC,
+	ICE_RX_SSE,
+	ICE_RX_SSE_SCATTERED,
+	ICE_RX_AVX2,
+	ICE_RX_AVX2_SCATTERED,
+	ICE_RX_AVX2_OFFLOAD,
+	ICE_RX_AVX2_SCATTERED_OFFLOAD,
+	ICE_RX_AVX512,
+	ICE_RX_AVX512_SCATTERED,
+	ICE_RX_AVX512_OFFLOAD,
+	ICE_RX_AVX512_SCATTERED_OFFLOAD,
+};
+
 struct ice_adapter;
 
 /**
@@ -637,6 +653,7 @@ struct ice_adapter {
 	bool rx_vec_allowed;
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
+	enum ice_rx_func_type rx_func_type;
 	/* ptype mapping table */
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[ICE_MAX_PKT_TYPE];
 	bool is_safe_mode;
@@ -658,8 +675,6 @@ struct ice_adapter {
 	unsigned long disabled_engine_mask;
 	struct ice_parser *psr;
 	/* used only on X86, zero on other Archs */
-	bool rx_use_avx2;
-	bool rx_use_avx512;
 	bool tx_use_avx2;
 	bool tx_use_avx512;
 	bool rx_vec_offload_support;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index da508592aa..428e136bfe 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3662,181 +3662,135 @@ ice_xmit_pkts_simple(void *tx_queue,
 	return nb_tx;
 }
 
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} ice_rx_burst_infos[] = {
+	[ICE_RX_DEFAULT] = { ice_recv_pkts, "Scalar" },
+	[ICE_RX_SCATTERED] = { ice_recv_scattered_pkts, "Scalar Scattered" },
+	[ICE_RX_BULK_ALLOC] = { ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
+#ifdef RTE_ARCH_X86
+	[ICE_RX_SSE] = { ice_recv_pkts_vec, "Vector SSE" },
+	[ICE_RX_SSE_SCATTERED] = { ice_recv_scattered_pkts_vec, "Vector SSE Scattered" },
+	[ICE_RX_AVX2] = { ice_recv_pkts_vec_avx2, "Vector AVX2" },
+	[ICE_RX_AVX2_SCATTERED] = { ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
+	[ICE_RX_AVX2_OFFLOAD] = { ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2" },
+	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
+		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
+#ifdef CC_AVX512_SUPPORT
+	[ICE_RX_AVX512] = { ice_recv_pkts_vec_avx512, "Vector AVX512" },
+	[ICE_RX_AVX512_SCATTERED] = {
+		ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
+	[ICE_RX_AVX512_OFFLOAD] = { ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512" },
+	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
+		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
+#endif
+#endif
+};
+
 void __rte_cold
 ice_set_rx_function(struct rte_eth_dev *dev)
 {
 	PMD_INIT_FUNC_TRACE();
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
+	/* The primary process selects the rx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
 #ifdef RTE_ARCH_X86
 	struct ci_rx_queue *rxq;
 	int i;
 	int rx_check_ret = -1;
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		ad->rx_use_avx512 = false;
-		ad->rx_use_avx2 = false;
-		rx_check_ret = ice_rx_vec_dev_check(dev);
-		if (ad->ptp_ena)
-			rx_check_ret = -1;
-		ad->rx_vec_offload_support =
-				(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
-		if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-			ad->rx_vec_allowed = true;
-			for (i = 0; i < dev->data->nb_rx_queues; i++) {
-				rxq = dev->data->rx_queues[i];
-				if (rxq && ice_rxq_vec_setup(rxq)) {
-					ad->rx_vec_allowed = false;
-					break;
-				}
+	bool rx_use_avx512 = false, rx_use_avx2 = false;
+
+	rx_check_ret = ice_rx_vec_dev_check(dev);
+	if (ad->ptp_ena)
+		rx_check_ret = -1;
+	ad->rx_vec_offload_support =
+			(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
+	if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
+			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
+		ad->rx_vec_allowed = true;
+		for (i = 0; i < dev->data->nb_rx_queues; i++) {
+			rxq = dev->data->rx_queues[i];
+			if (rxq && ice_rxq_vec_setup(rxq)) {
+				ad->rx_vec_allowed = false;
+				break;
 			}
+		}
 
-			if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
+		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
+				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
+				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
 #ifdef CC_AVX512_SUPPORT
-				ad->rx_use_avx512 = true;
+			rx_use_avx512 = true;
 #else
-			PMD_DRV_LOG(NOTICE,
-				"AVX512 is not supported in build env");
+		PMD_DRV_LOG(NOTICE,
+			"AVX512 is not supported in build env");
 #endif
-			if (!ad->rx_use_avx512 &&
-			(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-				ad->rx_use_avx2 = true;
-
-		} else {
-			ad->rx_vec_allowed = false;
-		}
+		if (!rx_use_avx512 &&
+				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
+				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
+				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			rx_use_avx2 = true;
+	} else {
+		ad->rx_vec_allowed = false;
 	}
 
 	if (ad->rx_vec_allowed) {
 		if (dev->data->scattered_rx) {
-			if (ad->rx_use_avx512) {
+			if (rx_use_avx512) {
 #ifdef CC_AVX512_SUPPORT
-				if (ad->rx_vec_offload_support) {
-					PMD_DRV_LOG(NOTICE,
-						"Using AVX512 OFFLOAD Vector Scattered Rx (port %d).",
-						dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_scattered_pkts_vec_avx512_offload;
-				} else {
-					PMD_DRV_LOG(NOTICE,
-						"Using AVX512 Vector Scattered Rx (port %d).",
-						dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_scattered_pkts_vec_avx512;
-				}
+				if (ad->rx_vec_offload_support)
+					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
+				else
+					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
 #endif
-			} else if (ad->rx_use_avx2) {
-				if (ad->rx_vec_offload_support) {
-					PMD_DRV_LOG(NOTICE,
-						    "Using AVX2 OFFLOAD Vector Scattered Rx (port %d).",
-						    dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_scattered_pkts_vec_avx2_offload;
-				} else {
-					PMD_DRV_LOG(NOTICE,
-						    "Using AVX2 Vector Scattered Rx (port %d).",
-						    dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_scattered_pkts_vec_avx2;
-				}
+			} else if (rx_use_avx2) {
+				if (ad->rx_vec_offload_support)
+					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
+				else
+					ad->rx_func_type = ICE_RX_AVX2_SCATTERED;
 			} else {
-				PMD_DRV_LOG(DEBUG,
-					"Using Vector Scattered Rx (port %d).",
-					dev->data->port_id);
-				dev->rx_pkt_burst = ice_recv_scattered_pkts_vec;
+				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
 			}
 		} else {
-			if (ad->rx_use_avx512) {
+			if (rx_use_avx512) {
 #ifdef CC_AVX512_SUPPORT
-				if (ad->rx_vec_offload_support) {
-					PMD_DRV_LOG(NOTICE,
-						"Using AVX512 OFFLOAD Vector Rx (port %d).",
-						dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_pkts_vec_avx512_offload;
-				} else {
-					PMD_DRV_LOG(NOTICE,
-						"Using AVX512 Vector Rx (port %d).",
-						dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_pkts_vec_avx512;
-				}
+				if (ad->rx_vec_offload_support)
+					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
+				else
+					ad->rx_func_type = ICE_RX_AVX512;
 #endif
-			} else if (ad->rx_use_avx2) {
-				if (ad->rx_vec_offload_support) {
-					PMD_DRV_LOG(NOTICE,
-						    "Using AVX2 OFFLOAD Vector Rx (port %d).",
-						    dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_pkts_vec_avx2_offload;
-				} else {
-					PMD_DRV_LOG(NOTICE,
-						    "Using AVX2 Vector Rx (port %d).",
-						    dev->data->port_id);
-					dev->rx_pkt_burst =
-						ice_recv_pkts_vec_avx2;
-				}
+			} else if (rx_use_avx2) {
+				if (ad->rx_vec_offload_support)
+					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
+				else
+					ad->rx_func_type = ICE_RX_AVX2;
 			} else {
-				PMD_DRV_LOG(DEBUG,
-					"Using Vector Rx (port %d).",
-					dev->data->port_id);
-				dev->rx_pkt_burst = ice_recv_pkts_vec;
+				ad->rx_func_type = ICE_RX_SSE;
 			}
 		}
-		return;
+		goto out;
 	}
 
 #endif
 
-	if (dev->data->scattered_rx) {
+	if (dev->data->scattered_rx)
 		/* Set the non-LRO scattered function */
-		PMD_INIT_LOG(DEBUG,
-			     "Using a Scattered function on port %d.",
-			     dev->data->port_id);
-		dev->rx_pkt_burst = ice_recv_scattered_pkts;
-	} else if (ad->rx_bulk_alloc_allowed) {
-		PMD_INIT_LOG(DEBUG,
-			     "Rx Burst Bulk Alloc Preconditions are "
-			     "satisfied. Rx Burst Bulk Alloc function "
-			     "will be used on port %d.",
-			     dev->data->port_id);
-		dev->rx_pkt_burst = ice_recv_pkts_bulk_alloc;
-	} else {
-		PMD_INIT_LOG(DEBUG,
-			     "Rx Burst Bulk Alloc Preconditions are not "
-			     "satisfied, Normal Rx will be used on port %d.",
-			     dev->data->port_id);
-		dev->rx_pkt_burst = ice_recv_pkts;
-	}
-}
+		ad->rx_func_type = ICE_RX_SCATTERED;
+	else if (ad->rx_bulk_alloc_allowed)
+		ad->rx_func_type = ICE_RX_BULK_ALLOC;
+	else
+		ad->rx_func_type = ICE_RX_DEFAULT;
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} ice_rx_burst_infos[] = {
-	{ ice_recv_scattered_pkts,          "Scalar Scattered" },
-	{ ice_recv_pkts_bulk_alloc,         "Scalar Bulk Alloc" },
-	{ ice_recv_pkts,                    "Scalar" },
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	{ ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
-	{ ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
-	{ ice_recv_pkts_vec_avx512,           "Vector AVX512" },
-	{ ice_recv_pkts_vec_avx512_offload,   "Offload Vector AVX512" },
-#endif
-	{ ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
-	{ ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
-	{ ice_recv_pkts_vec_avx2,           "Vector AVX2" },
-	{ ice_recv_pkts_vec_avx2_offload,   "Offload Vector AVX2" },
-	{ ice_recv_scattered_pkts_vec,      "Vector SSE Scattered" },
-	{ ice_recv_pkts_vec,                "Vector SSE" },
-#endif
-};
+out:
+	dev->rx_pkt_burst = ice_rx_burst_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
+		ice_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+}
 
 int
 ice_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.34.1

