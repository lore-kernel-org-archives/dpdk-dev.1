Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AD4CA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 10:59:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B5340662;
	Mon, 18 Aug 2025 12:59:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 92B8A4042F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514777; x=1787050777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tv+P626bsG4TIjwONMgVibH4WVzx3AzEUbP9s+judm4=;
 b=kD1H2wfF1H3lpnsoYP+4JkvCn+rU/7MbunNvGsrlHq/yWoyjvfJbbrjT
 BCFXuFsNpd8yFinFNP31Lbngh3UphXHW0Jbq0zqgMeddSq2NsuwcYTdHG
 ChmdwXYYw36G4jdwQvCoHHvaoS/7IMOL5PDkKD5FHhnrXmevWEZPrHGLc
 e90KiYU31BM/6+MEeNOz+5STuiEtro1FunZO5d7tFGo5R1+9+FTc3/hOi
 ruqffY6mhgz8YIq8AHTxR9HlH43PN33vo0YfUynVk0wt2yONpoPQ9fKaj
 3EG4jwXZyPWWO7q3rxvZNtAbYduc0oYZvGg6yeHLbQzaq4a06wWLk6+m9 g==;
X-CSE-ConnectionGUID: VXoMJ+nNRyy1peD3GqJH2Q==
X-CSE-MsgGUID: x3VVDI1bQviTq+KFGBybRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165422"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:35 -0700
X-CSE-ConnectionGUID: UrTqdHd/TdGHhPicmGlsjQ==
X-CSE-MsgGUID: 0XmJoppEQ3iDirXBxPmRcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722936"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:33 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 04/15] net/i40e: use the same Rx path across process types
Date: Mon, 18 Aug 2025 10:59:03 +0000
Message-Id: <20250818105914.169732-5-ciara.loftus@intel.com>
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

In the interest of simplicity, let the primary process select the Rx
path to be used by all processes using the given device.

The many logs which report individual Rx path selections have been
consolidated into one single log

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h |  20 +++-
 drivers/net/intel/i40e/i40e_rxtx.c   | 168 ++++++++++++---------------
 2 files changed, 93 insertions(+), 95 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 44864292d0..c38cb5f340 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1226,6 +1226,22 @@ struct i40e_vsi_vlan_pvid_info {
 #define I40E_MBUF_CHECK_F_TX_SEGMENT     (1ULL << 2)
 #define I40E_MBUF_CHECK_F_TX_OFFLOAD     (1ULL << 3)
 
+enum i40e_rx_func_type {
+	I40E_RX_DEFAULT,
+	I40E_RX_SCATTERED,
+	I40E_RX_BULK_ALLOC,
+	I40E_RX_SSE,
+	I40E_RX_SSE_SCATTERED,
+	I40E_RX_AVX2,
+	I40E_RX_AVX2_SCATTERED,
+	I40E_RX_AVX512,
+	I40E_RX_AVX512_SCATTERED,
+	I40E_RX_NEON,
+	I40E_RX_NEON_SCATTERED,
+	I40E_RX_ALTIVEC,
+	I40E_RX_ALTIVEC_SCATTERED,
+};
+
 /*
  * Structure to store private data for each PF/VF instance.
  */
@@ -1242,6 +1258,8 @@ struct i40e_adapter {
 	bool tx_simple_allowed;
 	bool tx_vec_allowed;
 
+	enum i40e_rx_func_type rx_func_type;
+
 	uint64_t mbuf_check; /* mbuf check flags. */
 	uint16_t max_pkt_len; /* Maximum packet length */
 	eth_tx_burst_t tx_pkt_burst;
@@ -1262,8 +1280,6 @@ struct i40e_adapter {
 	uint8_t rss_reta_updated;
 
 	/* used only on x86, zero on other architectures */
-	bool rx_use_avx2;
-	bool rx_use_avx512;
 	bool tx_use_avx2;
 	bool tx_use_avx512;
 };
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index aba3c11ee5..c89359e625 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3310,6 +3310,31 @@ get_avx_supported(bool request_avx512)
 }
 #endif /* RTE_ARCH_X86 */
 
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} i40e_rx_burst_infos[] = {
+	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar" },
+	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered" },
+	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
+#ifdef RTE_ARCH_X86
+	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE" },
+	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered" },
+	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2" },
+	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
+#ifdef CC_AVX512_SUPPORT
+	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512" },
+	[I40E_RX_AVX512_SCATTERED] = {
+		i40e_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
+#endif
+#elif defined(RTE_ARCH_ARM64)
+	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon" },
+	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered" },
+#elif defined(RTE_ARCH_PPC_64)
+	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec" },
+	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered" },
+#endif
+};
 
 void __rte_cold
 i40e_set_rx_function(struct rte_eth_dev *dev)
@@ -3317,109 +3342,86 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint16_t vector_rx, i;
+
+	/* The primary process selects the rx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
 	/* In order to allow Vector Rx there are a few configuration
 	 * conditions to be met and Rx Bulk Allocation should be allowed.
 	 */
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 #ifdef RTE_ARCH_X86
-		ad->rx_use_avx512 = false;
-		ad->rx_use_avx2 = false;
+	bool rx_use_avx512 = false, rx_use_avx2 = false;
 #endif
-		if (i40e_rx_vec_dev_conf_condition_check(dev) ||
-		    !ad->rx_bulk_alloc_allowed) {
-			PMD_INIT_LOG(DEBUG, "Port[%d] doesn't meet"
-				     " Vector Rx preconditions",
-				     dev->data->port_id);
+	if (i40e_rx_vec_dev_conf_condition_check(dev) || !ad->rx_bulk_alloc_allowed) {
+		PMD_INIT_LOG(DEBUG, "Port[%d] doesn't meet"
+				" Vector Rx preconditions",
+				dev->data->port_id);
 
-			ad->rx_vec_allowed = false;
-		}
-		if (ad->rx_vec_allowed) {
-			for (i = 0; i < dev->data->nb_rx_queues; i++) {
-				struct ci_rx_queue *rxq =
-					dev->data->rx_queues[i];
+		ad->rx_vec_allowed = false;
+	}
+	if (ad->rx_vec_allowed) {
+		for (i = 0; i < dev->data->nb_rx_queues; i++) {
+			struct ci_rx_queue *rxq =
+				dev->data->rx_queues[i];
 
-				if (rxq && i40e_rxq_vec_setup(rxq)) {
-					ad->rx_vec_allowed = false;
-					break;
-				}
+			if (rxq && i40e_rxq_vec_setup(rxq)) {
+				ad->rx_vec_allowed = false;
+				break;
 			}
+		}
 #ifdef RTE_ARCH_X86
-			ad->rx_use_avx512 = get_avx_supported(1);
+		rx_use_avx512 = get_avx_supported(1);
 
-			if (!ad->rx_use_avx512)
-				ad->rx_use_avx2 = get_avx_supported(0);
+		if (!rx_use_avx512)
+			rx_use_avx2 = get_avx_supported(0);
 #endif
-		}
 	}
 
-	if (ad->rx_vec_allowed  &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
+	if (ad->rx_vec_allowed && rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 #ifdef RTE_ARCH_X86
 		if (dev->data->scattered_rx) {
-			if (ad->rx_use_avx512) {
+			if (rx_use_avx512) {
 #ifdef CC_AVX512_SUPPORT
-				PMD_DRV_LOG(NOTICE,
-					"Using AVX512 Vector Scattered Rx (port %d).",
-					dev->data->port_id);
-				dev->rx_pkt_burst =
-					i40e_recv_scattered_pkts_vec_avx512;
+				ad->rx_func_type = I40E_RX_AVX512_SCATTERED;
 #endif
 			} else {
-				PMD_INIT_LOG(DEBUG,
-					"Using %sVector Scattered Rx (port %d).",
-					ad->rx_use_avx2 ? "avx2 " : "",
-					dev->data->port_id);
-				dev->rx_pkt_burst = ad->rx_use_avx2 ?
-					i40e_recv_scattered_pkts_vec_avx2 :
-					i40e_recv_scattered_pkts_vec;
+				ad->rx_func_type = rx_use_avx2 ?
+					I40E_RX_AVX2_SCATTERED :
+					I40E_RX_SCATTERED;
 				dev->recycle_rx_descriptors_refill =
 					i40e_recycle_rx_descriptors_refill_vec;
 			}
 		} else {
-			if (ad->rx_use_avx512) {
+			if (rx_use_avx512) {
 #ifdef CC_AVX512_SUPPORT
-				PMD_DRV_LOG(NOTICE,
-					"Using AVX512 Vector Rx (port %d).",
-					dev->data->port_id);
-				dev->rx_pkt_burst =
-					i40e_recv_pkts_vec_avx512;
+				ad->rx_func_type = I40E_RX_AVX512;
 #endif
 			} else {
-				PMD_INIT_LOG(DEBUG,
-					"Using %sVector Rx (port %d).",
-					ad->rx_use_avx2 ? "avx2 " : "",
-					dev->data->port_id);
-				dev->rx_pkt_burst = ad->rx_use_avx2 ?
-					i40e_recv_pkts_vec_avx2 :
-					i40e_recv_pkts_vec;
+				ad->rx_func_type = rx_use_avx2 ?
+					I40E_RX_AVX2 :
+					I40E_RX_SSE;
 				dev->recycle_rx_descriptors_refill =
 					i40e_recycle_rx_descriptors_refill_vec;
 			}
 		}
-#else /* RTE_ARCH_X86 */
+#elif defined(RTE_ARCH_ARM64)
 		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
-		if (dev->data->scattered_rx) {
-			PMD_INIT_LOG(DEBUG,
-				     "Using Vector Scattered Rx (port %d).",
-				     dev->data->port_id);
-			dev->rx_pkt_burst = i40e_recv_scattered_pkts_vec;
-		} else {
-			PMD_INIT_LOG(DEBUG, "Using Vector Rx (port %d).",
-				     dev->data->port_id);
-			dev->rx_pkt_burst = i40e_recv_pkts_vec;
-		}
+		if (dev->data->scattered_rx)
+			ad->rx_func_type = I40E_RX_NEON_SCATTERED;
+		else
+			ad->rx_func_type = I40E_RX_NEON;
+#elif defined(RTE_ARCH_PPC_64)
+		dev->recycle_rx_descriptors_refill = i40e_recycle_rx_descriptors_refill_vec;
+		if (dev->data->scattered_rx)
+			ad->rx_func_type = I40E_RX_ALTIVEC_SCATTERED;
+		else
+			ad->rx_func_type = I40E_RX_ALTIVEC;
 #endif /* RTE_ARCH_X86 */
 	} else if (!dev->data->scattered_rx && ad->rx_bulk_alloc_allowed) {
-		PMD_INIT_LOG(DEBUG, "Rx Burst Bulk Alloc Preconditions are "
-				    "satisfied. Rx Burst Bulk Alloc function "
-				    "will be used on port=%d.",
-			     dev->data->port_id);
-
 		dev->rx_pkt_burst = i40e_recv_pkts_bulk_alloc;
 	} else {
 		/* Simple Rx Path. */
-		PMD_INIT_LOG(DEBUG, "Simple Rx path will be used on port=%d.",
-			     dev->data->port_id);
 		dev->rx_pkt_burst = dev->data->scattered_rx ?
 					i40e_recv_scattered_pkts :
 					i40e_recv_pkts;
@@ -3444,32 +3446,12 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 				rxq->vector_rx = vector_rx;
 		}
 	}
-}
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} i40e_rx_burst_infos[] = {
-	{ i40e_recv_scattered_pkts,          "Scalar Scattered" },
-	{ i40e_recv_pkts_bulk_alloc,         "Scalar Bulk Alloc" },
-	{ i40e_recv_pkts,                    "Scalar" },
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	{ i40e_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
-	{ i40e_recv_pkts_vec_avx512,           "Vector AVX512" },
-#endif
-	{ i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
-	{ i40e_recv_pkts_vec_avx2,           "Vector AVX2" },
-	{ i40e_recv_scattered_pkts_vec,      "Vector SSE Scattered" },
-	{ i40e_recv_pkts_vec,                "Vector SSE" },
-#elif defined(RTE_ARCH_ARM64)
-	{ i40e_recv_scattered_pkts_vec,      "Vector Neon Scattered" },
-	{ i40e_recv_pkts_vec,                "Vector Neon" },
-#elif defined(RTE_ARCH_PPC_64)
-	{ i40e_recv_scattered_pkts_vec,      "Vector AltiVec Scattered" },
-	{ i40e_recv_pkts_vec,                "Vector AltiVec" },
-#endif
-};
+out:
+	dev->rx_pkt_burst = i40e_rx_burst_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
+		i40e_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+}
 
 int
 i40e_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.34.1

