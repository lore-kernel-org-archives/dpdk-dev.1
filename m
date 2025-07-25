Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4E45406B8;
	Fri, 25 Jul 2025 14:50:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9A9A64067E
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447820; x=1784983820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L0Bx737AhgNmDDVj14I2n30E6RvbfoBkah86N0nMw00=;
 b=fIeJlfkxUYkGBuAcMxPilIJSTljvXtADyHooiyKbWvv+aEI7S89fHgdo
 tz2kFDnKxCeyiR6SjzbpY51NmgPDC6ao69NblFZHGpbU0mHJZFk6kf9LJ
 NG+g+QbOdR9WSg8DaUdnwg5EEWZdHVM1K59sHUbJrAt6Mk/oAgVj/SlCT
 V06DJwgT9YxRJjzMH82XsiFB6FUNk665P8BN7UjEiTzvr+WbZvaS1RgiD
 9JLao4FCxFVTCsX5EyAUw+aD7+m7XIKnZEetLqxTWxeaVAMxegXNLIh4v
 lzXwwDh/8VGK13oGX2awyUlCR1oUyxLCOOAxewG05uUtD2E82mC/XtqC6 w==;
X-CSE-ConnectionGUID: jXna0fViRqa7U3FGKxIEow==
X-CSE-MsgGUID: dKBZaMzySomRRHL1pJDQFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480163"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480163"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:19 -0700
X-CSE-ConnectionGUID: wL1bpWcnQxOSQU8KSU7IoQ==
X-CSE-MsgGUID: A7Ad0lTrSqWhU/hVgWXW7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152350"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:18 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 13/14] net/iavf: use the common Rx path selection
 infrastructure
Date: Fri, 25 Jul 2025 12:49:18 +0000
Message-Id: <20250725124919.3564890-14-ciara.loftus@intel.com>
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

Replace the existing complicated logic with the use of the common
function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c            | 292 +++++++-----------
 drivers/net/intel/iavf/iavf_rxtx.h            |  50 ++-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  14 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |   6 +
 4 files changed, 165 insertions(+), 197 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 367dde89ca..01a470ce0c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3690,70 +3690,105 @@ static uint16_t
 iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts);
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} iavf_rx_pkt_burst_ops[] = {
-	[IAVF_RX_DISABLED] = {iavf_recv_pkts_no_poll, "Disabled"},
-	[IAVF_RX_DEFAULT] = {iavf_recv_pkts, "Scalar"},
-	[IAVF_RX_FLEX_RXD] = {iavf_recv_pkts_flex_rxd, "Scalar Flex"},
-	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc,
-		"Scalar Bulk Alloc"},
-	[IAVF_RX_SCATTERED] = {iavf_recv_scattered_pkts,
-		"Scalar Scattered"},
-	[IAVF_RX_SCATTERED_FLEX_RXD] = {iavf_recv_scattered_pkts_flex_rxd,
-		"Scalar Scattered Flex"},
+static const struct ci_rx_burst_info iavf_rx_pkt_burst_infos[] = {
+	[IAVF_RX_DISABLED] = {iavf_recv_pkts_no_poll, "Disabled",
+		{IAVF_RX_NO_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_IS_DISABLED}},
+	[IAVF_RX_DEFAULT] = {iavf_recv_pkts, "Scalar",
+		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_NO_FEATURES}},
+	[IAVF_RX_FLEX_RXD] = {iavf_recv_pkts_flex_rxd, "Scalar Flex",
+		{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_FLEX}},
+	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
+		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_SCATTERED] = {iavf_recv_scattered_pkts, "Scalar Scattered",
+		{IAVF_RX_SCALAR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
+			CI_RX_BURST_FEATURE_SCATTERED}},
+	[IAVF_RX_SCATTERED_FLEX_RXD] = {iavf_recv_scattered_pkts_flex_rxd, "Scalar Scattered Flex",
+		{IAVF_RX_SCALAR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
+				CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED}},
 #ifdef RTE_ARCH_X86
-	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE"},
-	[IAVF_RX_AVX2] = {iavf_recv_pkts_vec_avx2, "Vector AVX2"},
-	[IAVF_RX_AVX2_OFFLOAD] = {iavf_recv_pkts_vec_avx2_offload,
-		"Vector AVX2 Offload"},
-	[IAVF_RX_SSE_FLEX_RXD] = {iavf_recv_pkts_vec_flex_rxd,
-		"Vector Flex SSE"},
-	[IAVF_RX_AVX2_FLEX_RXD] = {iavf_recv_pkts_vec_avx2_flex_rxd,
-		"Vector AVX2 Flex"},
+	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE",
+		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX2] = {iavf_recv_pkts_vec_avx2, "Vector AVX2",
+		{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX2_OFFLOAD] = {iavf_recv_pkts_vec_avx2_offload, "Vector AVX2 Offload",
+		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_SSE_FLEX_RXD] = {iavf_recv_pkts_vec_flex_rxd, "Vector Flex SSE",
+		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX2_FLEX_RXD] = {iavf_recv_pkts_vec_avx2_flex_rxd, "Vector AVX2 Flex",
+		{IAVF_RX_VECTOR_FLEX_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_pkts_vec_avx2_flex_rxd_offload,
-			"Vector AVX2 Flex Offload"},
-	[IAVF_RX_SSE_SCATTERED] = {iavf_recv_scattered_pkts_vec,
-		"Vector Scattered SSE"},
-	[IAVF_RX_AVX2_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx2,
-		"Vector Scattered AVX2"},
+		iavf_recv_pkts_vec_avx2_flex_rxd_offload, "Vector AVX2 Flex Offload",
+			{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+				CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_SSE_SCATTERED] = {iavf_recv_scattered_pkts_vec, "Vector Scattered SSE",
+		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX2_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx2, "Vector Scattered AVX2",
+		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX2_SCATTERED_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx2_offload,
-		"Vector Scattered AVX2 offload"},
+		iavf_recv_scattered_pkts_vec_avx2_offload, "Vector Scattered AVX2 offload",
+		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_SSE_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_flex_rxd,
-		"Vector Scattered SSE Flex"},
+		iavf_recv_scattered_pkts_vec_flex_rxd, "Vector Scattered SSE Flex",
+		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED |
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_avx2_flex_rxd,
-		"Vector Scattered AVX2 Flex"},
+		iavf_recv_scattered_pkts_vec_avx2_flex_rxd, "Vector Scattered AVX2 Flex",
+		{IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED |
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload,
-		"Vector Scattered AVX2 Flex Offload"},
+		"Vector Scattered AVX2 Flex Offload",
+		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED |
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #ifdef CC_AVX512_SUPPORT
-	[IAVF_RX_AVX512] = {iavf_recv_pkts_vec_avx512, "Vector AVX512"},
-	[IAVF_RX_AVX512_OFFLOAD] = {iavf_recv_pkts_vec_avx512_offload,
-		"Vector AVX512 Offload"},
-	[IAVF_RX_AVX512_FLEX_RXD] = {iavf_recv_pkts_vec_avx512_flex_rxd,
-		"Vector AVX512 Flex"},
+	[IAVF_RX_AVX512] = {iavf_recv_pkts_vec_avx512, "Vector AVX512",
+		{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX512_OFFLOAD] = {iavf_recv_pkts_vec_avx512_offload, "Vector AVX512 Offload",
+		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX512_FLEX_RXD] = {iavf_recv_pkts_vec_avx512_flex_rxd, "Vector AVX512 Flex",
+		{IAVF_RX_VECTOR_FLEX_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX512_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_pkts_vec_avx512_flex_rxd_offload,
-		"Vector AVX512 Flex Offload"},
-	[IAVF_RX_AVX512_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx512,
-		"Vector Scattered AVX512"},
+		iavf_recv_pkts_vec_avx512_flex_rxd_offload, "Vector AVX512 Flex Offload",
+		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[IAVF_RX_AVX512_SCATTERED] = {
+		iavf_recv_scattered_pkts_vec_avx512, "Vector Scattered AVX512",
+		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX512_SCATTERED_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx512_offload,
-		"Vector Scattered AVX512 offload"},
+		iavf_recv_scattered_pkts_vec_avx512_offload, "Vector Scattered AVX512 offload",
+		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_avx512_flex_rxd,
-		"Vector Scattered AVX512 Flex"},
+		iavf_recv_scattered_pkts_vec_avx512_flex_rxd, "Vector Scattered AVX512 Flex",
+		{IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
+				CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED |
+				CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx512_flex_rxd_offload,
-		"Vector Scattered AVX512 Flex offload"},
+		"Vector Scattered AVX512 Flex offload",
+		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_FLEX | CI_RX_BURST_FEATURE_SCATTERED |
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
 #elif defined RTE_ARCH_ARM
-	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector Neon"},
+	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector Neon",
+		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
 };
 
@@ -3765,10 +3800,10 @@ iavf_rx_burst_mode_get(struct rte_eth_dev *dev,
 	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
 	size_t i;
 
-	for (i = 0; i < RTE_DIM(iavf_rx_pkt_burst_ops); i++) {
-		if (pkt_burst == iavf_rx_pkt_burst_ops[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(iavf_rx_pkt_burst_infos); i++) {
+		if (pkt_burst == iavf_rx_pkt_burst_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 iavf_rx_pkt_burst_ops[i].info);
+				 iavf_rx_pkt_burst_infos[i].info);
 			return 0;
 		}
 	}
@@ -3831,7 +3866,7 @@ iavf_recv_pkts_no_poll(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 	rx_func_type = rxq->iavf_vsi->adapter->rx_func_type;
 
-	return iavf_rx_pkt_burst_ops[rx_func_type].pkt_burst(rx_queue,
+	return iavf_rx_pkt_burst_infos[rx_func_type].pkt_burst(rx_queue,
 								rx_pkts, nb_pkts);
 }
 
@@ -3942,10 +3977,16 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	enum iavf_rx_func_type default_path = IAVF_RX_DEFAULT;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
 	int i;
 	struct ci_rx_queue *rxq;
 	bool use_flex = true;
+	struct ci_rx_burst_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.other_features_mask = CI_RX_BURST_NO_FEATURES
+	};
 
 	/* The primary process selects the rx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
@@ -3964,143 +4005,32 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 		}
 	}
 
-#ifdef RTE_ARCH_X86
-	int check_ret;
-	bool use_avx2 = false;
-	bool use_avx512 = false;
-	enum rte_vect_max_simd rx_simd_path = iavf_get_max_simd_bitwidth();
-
-	check_ret = iavf_rx_vec_dev_check(dev);
-	if (check_ret >= 0 &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		use_avx2 = rx_simd_path == RTE_VECT_SIMD_256;
-		use_avx512 = rx_simd_path == RTE_VECT_SIMD_512;
-
-		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			rxq = dev->data->rx_queues[i];
-			(void)iavf_rxq_vec_setup(rxq);
-		}
-
-		if (dev->data->scattered_rx) {
-			if (use_flex) {
-				adapter->rx_func_type = IAVF_RX_SSE_SCATTERED_FLEX_RXD;
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type =
-							IAVF_RX_AVX2_SCATTERED_FLEX_RXD;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD;
-				}
-#ifdef CC_AVX512_SUPPORT
-				if (use_avx512) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type =
-							IAVF_RX_AVX512_SCATTERED_FLEX_RXD;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD;
-				}
-#endif
-			} else {
-				adapter->rx_func_type = IAVF_RX_SSE_SCATTERED;
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type =
-							IAVF_RX_AVX2_SCATTERED;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX2_SCATTERED_OFFLOAD;
-				}
-#ifdef CC_AVX512_SUPPORT
-				if (use_avx512) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type =
-							IAVF_RX_AVX512_SCATTERED;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX512_SCATTERED_OFFLOAD;
-				}
-#endif
-			}
-		} else {
-			if (use_flex) {
-				adapter->rx_func_type = IAVF_RX_SSE_FLEX_RXD;
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type = IAVF_RX_AVX2_FLEX_RXD;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX2_FLEX_RXD_OFFLOAD;
-				}
-#ifdef CC_AVX512_SUPPORT
-				if (use_avx512) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type = IAVF_RX_AVX512_FLEX_RXD;
-					else
-						adapter->rx_func_type =
-							IAVF_RX_AVX512_FLEX_RXD_OFFLOAD;
-				}
+	if (use_flex)
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_FLEX;
+	if (dev->data->scattered_rx)
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_SCATTERED;
+	if (adapter->rx_bulk_alloc_allowed) {
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_BULK_ALLOC;
+		default_path = IAVF_RX_BULK_ALLOC;
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+		if (iavf_rx_vec_dev_check(dev) != -1)
+			req_features.simd_width = iavf_get_max_simd_bitwidth();
 #endif
-			} else {
-				adapter->rx_func_type = IAVF_RX_SSE;
-				if (use_avx2) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type = IAVF_RX_AVX2;
-					else
-						adapter->rx_func_type = IAVF_RX_AVX2_OFFLOAD;
-				}
-#ifdef CC_AVX512_SUPPORT
-				if (use_avx512) {
-					if (check_ret == IAVF_VECTOR_PATH)
-						adapter->rx_func_type = IAVF_RX_AVX512;
-					else
-						adapter->rx_func_type = IAVF_RX_AVX512_OFFLOAD;
-				}
-#endif
-			}
-		}
-		goto out;
 	}
-#elif defined RTE_ARCH_ARM
-	int check_ret;
-
-	check_ret = iavf_rx_vec_dev_check(dev);
-	if (check_ret >= 0 &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		PMD_DRV_LOG(DEBUG, "Using a Vector Rx callback (port=%d).",
-			    dev->data->port_id);
-		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			rxq = dev->data->rx_queues[i];
-			(void)iavf_rxq_vec_setup(rxq);
-		}
-		adapter->rx_func_type = IAVF_RX_SSE;
 
-		goto out;
-	}
-#endif
-	if (dev->data->scattered_rx) {
-		if (use_flex)
-			adapter->rx_func_type = IAVF_RX_SCATTERED_FLEX_RXD;
-		else
-			adapter->rx_func_type = IAVF_RX_SCATTERED;
-	} else if (adapter->rx_bulk_alloc_allowed) {
-		adapter->rx_func_type = IAVF_RX_BULK_ALLOC;
-	} else {
-		if (use_flex)
-			adapter->rx_func_type = IAVF_RX_FLEX_RXD;
-		else
-			adapter->rx_func_type = IAVF_RX_DEFAULT;
-	}
+	adapter->rx_func_type = ci_rx_burst_mode_select(&iavf_rx_pkt_burst_infos[0],
+						req_features,
+						RTE_DIM(iavf_rx_pkt_burst_infos),
+						default_path);
 
 out:
 	if (no_poll_on_link_down)
 		dev->rx_pkt_burst = iavf_recv_pkts_no_poll;
 	else
-		dev->rx_pkt_burst = iavf_rx_pkt_burst_ops[adapter->rx_func_type].pkt_burst;
+		dev->rx_pkt_burst = iavf_rx_pkt_burst_infos[adapter->rx_func_type].pkt_burst;
 
-	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
-		iavf_rx_pkt_burst_ops[adapter->rx_func_type].info, dev->data->port_id);
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		iavf_rx_pkt_burst_infos[adapter->rx_func_type].info, dev->data->port_id);
 }
 
 /* choose tx function*/
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 36157003e3..2e85348cb2 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -56,12 +56,50 @@
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
 
-#define IAVF_RX_VECTOR_OFFLOAD (				 \
-		RTE_ETH_RX_OFFLOAD_CHECKSUM |		 \
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		 \
-		RTE_ETH_RX_OFFLOAD_VLAN |		 \
-		RTE_ETH_RX_OFFLOAD_RSS_HASH |    \
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
+#define IAVF_RX_NO_OFFLOADS 0
+/* basic scalar path */
+#define IAVF_RX_SCALAR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |		\
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_SCATTER |		\
+		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
+		RTE_ETH_RX_OFFLOAD_SCATTER |		\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+/* scalar path that uses the flex rx desc */
+#define IAVF_RX_SCALAR_FLEX_OFFLOADS (			\
+		IAVF_RX_SCALAR_OFFLOADS |		\
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
+		RTE_ETH_RX_OFFLOAD_SECURITY)
+/* basic vector paths */
+#define IAVF_RX_VECTOR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_SCATTER)
+/* vector paths that use the flex rx desc */
+#define IAVF_RX_VECTOR_FLEX_OFFLOADS (			\
+		IAVF_RX_VECTOR_OFFLOADS |		\
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
+		RTE_ETH_RX_OFFLOAD_SECURITY)
+/* vector offload paths */
+#define IAVF_RX_VECTOR_OFFLOAD_OFFLOADS (		\
+		IAVF_RX_VECTOR_OFFLOADS |		\
+		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_RX_OFFLOAD_VLAN |		\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
+/* vector offload paths that use the flex rx desc */
+#define IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS (		\
+		IAVF_RX_VECTOR_OFFLOAD_OFFLOADS |	\
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
+		RTE_ETH_RX_OFFLOAD_SECURITY)
+
 
 /**
  * According to the vlan capabilities returned by the driver and FW, the vlan tci
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 9b14fc7d12..0d0bde6cb3 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -67,10 +67,7 @@ iavf_rx_vec_queue_default(struct ci_rx_queue *rxq)
 	if (rxq->proto_xtr != IAVF_PROTO_XTR_NONE)
 		return -1;
 
-	if (rxq->offloads & IAVF_RX_VECTOR_OFFLOAD)
-		return IAVF_VECTOR_OFFLOAD_PATH;
-
-	return IAVF_VECTOR_PATH;
+	return 0;
 }
 
 static inline int
@@ -117,20 +114,17 @@ iavf_rx_vec_dev_check_default(struct rte_eth_dev *dev)
 {
 	int i;
 	struct ci_rx_queue *rxq;
-	int ret;
-	int result = 0;
+	int ret = 0;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
 		ret = iavf_rx_vec_queue_default(rxq);
 
 		if (ret < 0)
-			return -1;
-		if (ret > result)
-			result = ret;
+			break;
 	}
 
-	return result;
+	return ret;
 }
 
 static inline int
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 4ed4e9b336..28c90b2a72 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -360,3 +360,9 @@ iavf_rx_vec_dev_check(struct rte_eth_dev *dev)
 {
 	return iavf_rx_vec_dev_check_default(dev);
 }
+
+enum rte_vect_max_simd
+iavf_get_max_simd_bitwidth(void)
+{
+	return RTE_MIN(128, rte_vect_get_max_simd_bitwidth());
+}
-- 
2.34.1

