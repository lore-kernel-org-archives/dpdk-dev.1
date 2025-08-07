Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80406C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3090C40691;
	Thu,  7 Aug 2025 14:40:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 969854066F
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570403; x=1786106403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f5iL17gxW/WprB7I0E2gzz8WgQl1XOTFxVbxJNMjPkc=;
 b=UPyjtHxl2LLYyqSTyfVXA1HQJVlwE4E4NI6W9SUHUQONZc5FpYk2iEFx
 xZnouA0gkpIswDHU0X2d6hLVbeSlfz5On2xAFPiMozd8DW/3KnustO1/O
 aZKxVaozMEabBRm5gkeGwvGUelKSbXCK8rgvE5QkMZt7ihYVFlHkmt6Bb
 hPW7ZD4Er/HBn+fRIU/owRbcdpz1Eogh8HZlZh6sLhw5F/MkgDBOXcEiK
 YEy6FUKblSAPMbSvJI130bEyoiAIXEBHLHsgD+9YBpGKHz1u9cmA57cuP
 J7zpCrmtTLfBMGA7cIarXqsy4m2XxnziZsBIR11DyHITnnPNzwP80fJW6 w==;
X-CSE-ConnectionGUID: My4fKHkmTa27GQHxnyk61A==
X-CSE-MsgGUID: sAI4BsqsTM+apHkeO6xffw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981125"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:03 -0700
X-CSE-ConnectionGUID: dtqROT1zQ+SpNq/TREzx2w==
X-CSE-MsgGUID: uU9NTfl2QoyO4r2+6s0fgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886747"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:02 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 08/15] net/i40e: use the new common vector capability
 function
Date: Thu,  7 Aug 2025 12:39:42 +0000
Message-Id: <20250807123949.4063416-9-ciara.loftus@intel.com>
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
the i40e driver.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h       |  5 +-
 drivers/net/intel/i40e/i40e_rxtx.c         | 57 ++++------------------
 drivers/net/intel/i40e/i40e_rxtx.h         |  1 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c |  6 +++
 4 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index c38cb5f340..3fca089d6c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -15,6 +15,7 @@
 #include <rte_flow_driver.h>
 #include <rte_tm_driver.h>
 #include "rte_pmd_i40e.h"
+#include <rte_vect.h>
 
 #include "base/i40e_register.h"
 #include "base/i40e_type.h"
@@ -1279,9 +1280,7 @@ struct i40e_adapter {
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
 
-	/* used only on x86, zero on other architectures */
-	bool tx_use_avx2;
-	bool tx_use_avx512;
+	enum rte_vect_max_simd tx_simd_width;
 };
 
 /**
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c89359e625..2a6b74ecc7 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3284,32 +3284,6 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 }
 
-#ifdef RTE_ARCH_X86
-static inline bool
-get_avx_supported(bool request_avx512)
-{
-	if (request_avx512) {
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512 &&
-		rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-		rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
-#ifdef CC_AVX512_SUPPORT
-			return true;
-#else
-		PMD_DRV_LOG(NOTICE,
-			"AVX512 is not supported in build env");
-		return false;
-#endif
-	} else {
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256 &&
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
-				rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)
-			return true;
-	}
-
-	return false;
-}
-#endif /* RTE_ARCH_X86 */
-
 static const struct {
 	eth_rx_burst_t pkt_burst;
 	const char *info;
@@ -3351,7 +3325,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	 * conditions to be met and Rx Bulk Allocation should be allowed.
 	 */
 #ifdef RTE_ARCH_X86
-	bool rx_use_avx512 = false, rx_use_avx2 = false;
+	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 #endif
 	if (i40e_rx_vec_dev_conf_condition_check(dev) || !ad->rx_bulk_alloc_allowed) {
 		PMD_INIT_LOG(DEBUG, "Port[%d] doesn't meet"
@@ -3370,35 +3344,29 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 				break;
 			}
 		}
-#ifdef RTE_ARCH_X86
-		rx_use_avx512 = get_avx_supported(1);
-
-		if (!rx_use_avx512)
-			rx_use_avx2 = get_avx_supported(0);
-#endif
 	}
 
 	if (ad->rx_vec_allowed && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 #ifdef RTE_ARCH_X86
 		if (dev->data->scattered_rx) {
-			if (rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				ad->rx_func_type = I40E_RX_AVX512_SCATTERED;
 #endif
 			} else {
-				ad->rx_func_type = rx_use_avx2 ?
+				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
 					I40E_RX_AVX2_SCATTERED :
 					I40E_RX_SCATTERED;
 				dev->recycle_rx_descriptors_refill =
 					i40e_recycle_rx_descriptors_refill_vec;
 			}
 		} else {
-			if (rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				ad->rx_func_type = I40E_RX_AVX512;
 #endif
 			} else {
-				ad->rx_func_type = rx_use_avx2 ?
+				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
 					I40E_RX_AVX2 :
 					I40E_RX_SSE;
 				dev->recycle_rx_descriptors_refill =
@@ -3509,8 +3477,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 #ifdef RTE_ARCH_X86
-		ad->tx_use_avx2 = false;
-		ad->tx_use_avx512 = false;
+		ad->tx_simd_width = i40e_get_max_simd_bitwidth();
 #endif
 		if (ad->tx_vec_allowed) {
 			for (i = 0; i < dev->data->nb_tx_queues; i++) {
@@ -3522,12 +3489,6 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 					break;
 				}
 			}
-#ifdef RTE_ARCH_X86
-			ad->tx_use_avx512 = get_avx_supported(1);
-
-			if (!ad->tx_use_avx512)
-				ad->tx_use_avx2 = get_avx_supported(0);
-#endif
 		}
 	}
 
@@ -3537,7 +3498,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	if (ad->tx_simple_allowed) {
 		if (ad->tx_vec_allowed) {
 #ifdef RTE_ARCH_X86
-			if (ad->tx_use_avx512) {
+			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				PMD_DRV_LOG(NOTICE, "Using AVX512 Vector Tx (port %d).",
 					    dev->data->port_id);
@@ -3545,9 +3506,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 #endif
 			} else {
 				PMD_INIT_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					     ad->tx_use_avx2 ? "avx2 " : "",
+					     ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
 					     dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_use_avx2 ?
+				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
 						    i40e_xmit_pkts_vec_avx2 :
 						    i40e_xmit_pkts_vec;
 				dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 984532c507..b867e18daf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -167,6 +167,7 @@ uint16_t i40e_recv_scattered_pkts_vec_avx512(void *rx_queue,
 uint16_t i40e_xmit_pkts_vec_avx512(void *tx_queue,
 				   struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
+enum rte_vect_max_simd i40e_get_max_simd_bitwidth(void);
 
 /* For each value it means, datasheet of hardware can tell more details
  *
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index 15cf07e548..c035408dcc 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -715,3 +715,9 @@ i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
 	return i40e_rx_vec_dev_conf_condition_check_default(dev);
 }
+
+enum rte_vect_max_simd
+i40e_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
-- 
2.34.1

