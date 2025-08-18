Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1406CA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70ABB4067E;
	Mon, 18 Aug 2025 12:59:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8D6804042F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514781; x=1787050781;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GMAiZTc60q4u9JpOVzcTVb6zOEmDw8tJE/lVsrUEvfg=;
 b=HteSTDB2t9oQDULB2gxzPOaPruRfLnv2CuOkGUF+lI091Ut10unaJvlT
 XuJiklc1g7cN4RYSJig9zFJy4M5XQLoBJlMD263Fwb2XG7vr/XhGvgorn
 0sq47KmqWGs/AUlixRlLWijdm5Su4iGfgiHXIimuxwKKEN02gZNa7kFrY
 vwF83Z0oWxE39Vo8aY8py+k6mSNiqQcdvQZy5o2PWtCu/CZ3eab5m8DFh
 m7sZHdZ7Xw02UaO26NdSXJ0Zi0jEoVPCHEPqh+l8fMRwvwQHXBWR6Xc+H
 GBNqPP36cEx3eoyai6ar1jQQnlvJGH89RIP2pBxlARwXxzwgYAkIxaTGu A==;
X-CSE-ConnectionGUID: 3U/FTZVSQd6BviBA5nYUuw==
X-CSE-MsgGUID: LkP57Zh9Shm0dKbPrbX+Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165435"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165435"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:40 -0700
X-CSE-ConnectionGUID: 6cFdmkc8S2+5VqSNaqT3jQ==
X-CSE-MsgGUID: x8wiuVQiTHGAXCKMQyfbXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722976"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 08/15] net/i40e: use the new common vector capability
 function
Date: Mon, 18 Aug 2025 10:59:07 +0000
Message-Id: <20250818105914.169732-9-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3:
* removed unnecessary #ifdef CC_AVX512_SUPPORT
* added error log for case when tx simd width is invalid
---
 drivers/net/intel/i40e/i40e_ethdev.h       |  5 +-
 drivers/net/intel/i40e/i40e_rxtx.c         | 66 +++++-----------------
 drivers/net/intel/i40e/i40e_rxtx.h         |  1 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c |  6 ++
 4 files changed, 23 insertions(+), 55 deletions(-)

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
index c89359e625..76d90be931 100644
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
@@ -3370,35 +3344,25 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
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
-#ifdef CC_AVX512_SUPPORT
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				ad->rx_func_type = I40E_RX_AVX512_SCATTERED;
-#endif
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
-#ifdef CC_AVX512_SUPPORT
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				ad->rx_func_type = I40E_RX_AVX512;
-#endif
 			} else {
-				ad->rx_func_type = rx_use_avx2 ?
+				ad->rx_func_type = (rx_simd_width == RTE_VECT_SIMD_256) ?
 					I40E_RX_AVX2 :
 					I40E_RX_SSE;
 				dev->recycle_rx_descriptors_refill =
@@ -3509,8 +3473,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 #ifdef RTE_ARCH_X86
-		ad->tx_use_avx2 = false;
-		ad->tx_use_avx512 = false;
+		ad->tx_simd_width = i40e_get_max_simd_bitwidth();
 #endif
 		if (ad->tx_vec_allowed) {
 			for (i = 0; i < dev->data->nb_tx_queues; i++) {
@@ -3522,12 +3485,6 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
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
 
@@ -3537,17 +3494,22 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	if (ad->tx_simple_allowed) {
 		if (ad->tx_vec_allowed) {
 #ifdef RTE_ARCH_X86
-			if (ad->tx_use_avx512) {
+			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 				PMD_DRV_LOG(NOTICE, "Using AVX512 Vector Tx (port %d).",
 					    dev->data->port_id);
 				dev->tx_pkt_burst = i40e_xmit_pkts_vec_avx512;
+#else
+				PMD_DRV_LOG(ERR, "Invalid Tx SIMD width reported, defaulting to "
+						"using scalar Tx (port %d).",
+						dev->data->port_id);
+				dev->tx_pkt_burst = i40e_xmit_pkts;
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

