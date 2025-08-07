Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9061C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E98AC40673;
	Thu,  7 Aug 2025 14:40:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B3B0F40664
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570401; x=1786106401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7T0B2OcVnviEFxjFwBrpCmUNC57SdVYKXYjwaQ5moU=;
 b=cgeFZAZ5Ek5UC5a8ByZ8mM5VX28OXdDet+Mh5v1VSncbG45l7+SzVxJv
 B0oTQ1m2rLzOP7MwaRI17LNwVMCDdE6L707b2CAAJf+u84vNpSsk0Pm0M
 DMKuS/Q69h/oq1JiF1JUvPNzecvBM5YN7d+k1jIyomL+91ZQ2OPF6yrzO
 c39Ia6JaeSxG5tXJoY0MsO46Mp48Iv7ZIaMG8x54YL6E7jv11xDFey7xA
 MqiPV5hoCFsa8o/wZpWoahZBuRKAXfhxh7G+k0f8E27XPpxFYeQbC418o
 9+hLWSO6T5lv68tgitpSnwwq65vgKmyzGU5XIoR9hm/1KbPutTnkoAXce A==;
X-CSE-ConnectionGUID: pAxvT1+OSrC5OHjmaj0OSg==
X-CSE-MsgGUID: A7JjKCqjSQygoH8WQZOt5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981121"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981121"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:01 -0700
X-CSE-ConnectionGUID: Dm9ItgSiTkSFPVsHAJm/6A==
X-CSE-MsgGUID: 8lplP708SLWf3euEJNzYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886734"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:00 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 06/15] net/ice: use the new common vector capability
 function
Date: Thu,  7 Aug 2025 12:39:40 +0000
Message-Id: <20250807123949.4063416-7-ciara.loftus@intel.com>
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

Use the new function for determining the maximum simd bitwidth in
the ice driver.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h       |  5 +--
 drivers/net/intel/ice/ice_rxtx.c         | 52 ++++++------------------
 drivers/net/intel/ice/ice_rxtx.h         |  1 +
 drivers/net/intel/ice/ice_rxtx_vec_sse.c |  6 +++
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 4505644f87..8d975c23de 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -11,6 +11,7 @@
 
 #include <ethdev_driver.h>
 #include <rte_tm_driver.h>
+#include <rte_vect.h>
 
 #include "base/ice_common.h"
 #include "base/ice_adminq_cmd.h"
@@ -674,9 +675,7 @@ struct ice_adapter {
 	/* Set bit if the engine is disabled */
 	unsigned long disabled_engine_mask;
 	struct ice_parser *psr;
-	/* used only on X86, zero on other Archs */
-	bool tx_use_avx2;
-	bool tx_use_avx512;
+	enum rte_vect_max_simd tx_simd_width;
 	bool rx_vec_offload_support;
 };
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 428e136bfe..8c197eefa9 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3703,7 +3703,7 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 	struct ci_rx_queue *rxq;
 	int i;
 	int rx_check_ret = -1;
-	bool rx_use_avx512 = false, rx_use_avx2 = false;
+	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
 
 	rx_check_ret = ice_rx_vec_dev_check(dev);
 	if (ad->ptp_ena)
@@ -3720,35 +3720,22 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 				break;
 			}
 		}
+		rx_simd_width = ice_get_max_simd_bitwidth();
 
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
-#ifdef CC_AVX512_SUPPORT
-			rx_use_avx512 = true;
-#else
-		PMD_DRV_LOG(NOTICE,
-			"AVX512 is not supported in build env");
-#endif
-		if (!rx_use_avx512 &&
-				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			rx_use_avx2 = true;
 	} else {
 		ad->rx_vec_allowed = false;
 	}
 
 	if (ad->rx_vec_allowed) {
 		if (dev->data->scattered_rx) {
-			if (rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				if (ad->rx_vec_offload_support)
 					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
 				else
 					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
 #endif
-			} else if (rx_use_avx2) {
+			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
 				if (ad->rx_vec_offload_support)
 					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
 				else
@@ -3757,14 +3744,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
 			}
 		} else {
-			if (rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				if (ad->rx_vec_offload_support)
 					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
 				else
 					ad->rx_func_type = ICE_RX_AVX512;
 #endif
-			} else if (rx_use_avx2) {
+			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
 				if (ad->rx_vec_offload_support)
 					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
 				else
@@ -4032,29 +4019,14 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	int tx_check_ret = -1;
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		ad->tx_use_avx2 = false;
-		ad->tx_use_avx512 = false;
+		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
 		tx_check_ret = ice_tx_vec_dev_check(dev);
+		ad->tx_simd_width = ice_get_max_simd_bitwidth();
 		if (tx_check_ret >= 0 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 			ad->tx_vec_allowed = true;
 
-			if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
-#ifdef CC_AVX512_SUPPORT
-				ad->tx_use_avx512 = true;
-#else
-			PMD_DRV_LOG(NOTICE,
-				"AVX512 is not supported in build env");
-#endif
-			if (!ad->tx_use_avx512 &&
-				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-				ad->tx_use_avx2 = true;
-
-			if (!ad->tx_use_avx2 && !ad->tx_use_avx512 &&
+			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
 				tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
 				ad->tx_vec_allowed = false;
 
@@ -4074,7 +4046,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 
 	if (ad->tx_vec_allowed) {
 		dev->tx_pkt_prepare = NULL;
-		if (ad->tx_use_avx512) {
+		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
 				PMD_DRV_LOG(NOTICE,
@@ -4100,9 +4072,9 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 				dev->tx_pkt_prepare = ice_prep_pkts;
 			} else {
 				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					    ad->tx_use_avx2 ? "avx2 " : "",
+					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
 					    dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_use_avx2 ?
+				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
 						    ice_xmit_pkts_vec_avx2 :
 						    ice_xmit_pkts_vec;
 			}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 0301d05888..8c3d6c413a 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -261,6 +261,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
 int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
 int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
+enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
 
 #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
 	int i; \
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index d818b3b728..1545bc3b6e 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -735,3 +735,9 @@ ice_tx_vec_dev_check(struct rte_eth_dev *dev)
 {
 	return ice_tx_vec_dev_check_default(dev);
 }
+
+enum rte_vect_max_simd
+ice_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
-- 
2.34.1

