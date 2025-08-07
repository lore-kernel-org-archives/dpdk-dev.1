Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB6EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCBB840A79;
	Thu,  7 Aug 2025 14:40:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 42D224065C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570409; x=1786106409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T68G0Ksvk4C5UHbXJNHa5X0y5wFfNypWFsswvKfGctU=;
 b=TIQXs8q/Ed4LGSDxeXGOXgOqsk4g8SklshfEwqO0ZP+pb5Qc7FZsQr+V
 yen7jxAsz5SeQ+UTQk4hBhiaAn5H2xm7VpeyrMJ4PS3t1E56e61SD2Mzp
 8W6gbwb3/ZOENuU48Abb2I4DHRMWcmsjzwe4k/JyY6hMEADTNqBXbgcOy
 3HlRN66GWtoLWOpHQ+xhu2nKDNGzAhD9oyqoIY4rwn7lmeyqjXoC8O+Ah
 V/AF/EpEL4ONf6BOmYWHbD67BDoWGCYrBoeZt7MhQDr+PWDFvl3oEECKO
 VcnfkrNIN/RzKYXXy2xY6QFPlFrVx7u9RsLMQjDNOy1gzHTwXCzAroi/U w==;
X-CSE-ConnectionGUID: kxQ9fFpuTOO6QRcHo0RyZQ==
X-CSE-MsgGUID: dIaz9G1yQNOM3O1mvH4xTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981136"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981136"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:09 -0700
X-CSE-ConnectionGUID: 59+KlPJfTvyL6BFLl62EEA==
X-CSE-MsgGUID: Q+EdMwkMQQCVjTScV6kC0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886779"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:08 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 13/15] net/ice: use the common Rx path selection
 infrastructure
Date: Thu,  7 Aug 2025 12:39:47 +0000
Message-Id: <20250807123949.4063416-14-ciara.loftus@intel.com>
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

Replace the existing complicated logic with the use of the common
function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* use the new names for the renamed structs and functions
---
 drivers/net/intel/ice/ice_ethdev.h          |   1 -
 drivers/net/intel/ice/ice_rxtx.c            | 162 +++++++++-----------
 drivers/net/intel/ice/ice_rxtx.h            |  28 ++++
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 +-
 4 files changed, 102 insertions(+), 106 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8d975c23de..c9b0b86836 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -651,7 +651,6 @@ struct ice_adapter {
 	struct ice_hw hw;
 	struct ice_pf pf;
 	bool rx_bulk_alloc_allowed;
-	bool rx_vec_allowed;
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
 	enum ice_rx_func_type rx_func_type;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 8c197eefa9..b54edd7a6a 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3662,28 +3662,46 @@ ice_xmit_pkts_simple(void *tx_queue,
 	return nb_tx;
 }
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} ice_rx_burst_infos[] = {
-	[ICE_RX_DEFAULT] = { ice_recv_pkts, "Scalar" },
-	[ICE_RX_SCATTERED] = { ice_recv_scattered_pkts, "Scalar Scattered" },
-	[ICE_RX_BULK_ALLOC] = { ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
+static const struct ci_rx_path_info ice_rx_path_infos[] = {
+	[ICE_RX_DEFAULT] = {
+		ice_recv_pkts, "Scalar",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, 0, 0}},
+	[ICE_RX_SCATTERED] = {ice_recv_scattered_pkts, "Scalar Scattered",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_PATH_SCATTERED, 0, 0, 0}},
+	[ICE_RX_BULK_ALLOC] = {ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #ifdef RTE_ARCH_X86
-	[ICE_RX_SSE] = { ice_recv_pkts_vec, "Vector SSE" },
-	[ICE_RX_SSE_SCATTERED] = { ice_recv_scattered_pkts_vec, "Vector SSE Scattered" },
-	[ICE_RX_AVX2] = { ice_recv_pkts_vec_avx2, "Vector AVX2" },
-	[ICE_RX_AVX2_SCATTERED] = { ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
-	[ICE_RX_AVX2_OFFLOAD] = { ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2" },
+	[ICE_RX_SSE] = {ice_recv_pkts_vec, "Vector SSE",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
+			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_SSE_SCATTERED] = {ice_recv_scattered_pkts_vec, "Vector SSE Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_AVX2] = {ice_recv_pkts_vec_avx2, "Vector AVX2",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_AVX2_SCATTERED] = {ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_AVX2_OFFLOAD] = {ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
+			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
+		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #ifdef CC_AVX512_SUPPORT
-	[ICE_RX_AVX512] = { ice_recv_pkts_vec_avx512, "Vector AVX512" },
-	[ICE_RX_AVX512_SCATTERED] = {
-		ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
-	[ICE_RX_AVX512_OFFLOAD] = { ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512" },
+	[ICE_RX_AVX512] = {ice_recv_pkts_vec_avx512, "Vector AVX512",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, 0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_AVX512_SCATTERED] = {ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
+	[ICE_RX_AVX512_OFFLOAD] = {ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
+			0, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
+		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_PATH_SCATTERED, 0, CI_RX_PATH_BULK_ALLOC, 0}},
 #endif
 #endif
 };
@@ -3694,89 +3712,51 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
+	struct ci_rx_path_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 
 	/* The primary process selects the rx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-	struct ci_rx_queue *rxq;
-	int i;
-	int rx_check_ret = -1;
-	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
-
-	rx_check_ret = ice_rx_vec_dev_check(dev);
-	if (ad->ptp_ena)
-		rx_check_ret = -1;
-	ad->rx_vec_offload_support =
-			(rx_check_ret == ICE_VECTOR_OFFLOAD_PATH);
-	if (rx_check_ret >= 0 && ad->rx_bulk_alloc_allowed &&
-			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		ad->rx_vec_allowed = true;
-		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			rxq = dev->data->rx_queues[i];
-			if (rxq && ice_rxq_vec_setup(rxq)) {
-				ad->rx_vec_allowed = false;
-				break;
-			}
-		}
-		rx_simd_width = ice_get_max_simd_bitwidth();
-
+	if (ad->ptp_ena || !ad->rx_bulk_alloc_allowed) {
+		rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	} else {
-		ad->rx_vec_allowed = false;
-	}
-
-	if (ad->rx_vec_allowed) {
-		if (dev->data->scattered_rx) {
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				if (ad->rx_vec_offload_support)
-					ad->rx_func_type = ICE_RX_AVX512_SCATTERED_OFFLOAD;
-				else
-					ad->rx_func_type = ICE_RX_AVX512_SCATTERED;
-#endif
-			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
-				if (ad->rx_vec_offload_support)
-					ad->rx_func_type = ICE_RX_AVX2_SCATTERED_OFFLOAD;
-				else
-					ad->rx_func_type = ICE_RX_AVX2_SCATTERED;
-			} else {
-				ad->rx_func_type = ICE_RX_SSE_SCATTERED;
-			}
-		} else {
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				if (ad->rx_vec_offload_support)
-					ad->rx_func_type = ICE_RX_AVX512_OFFLOAD;
-				else
-					ad->rx_func_type = ICE_RX_AVX512;
-#endif
-			} else if (rx_simd_width == RTE_VECT_SIMD_256) {
-				if (ad->rx_vec_offload_support)
-					ad->rx_func_type = ICE_RX_AVX2_OFFLOAD;
-				else
-					ad->rx_func_type = ICE_RX_AVX2;
-			} else {
-				ad->rx_func_type = ICE_RX_SSE;
-			}
-		}
-		goto out;
+		rx_simd_width = ice_get_max_simd_bitwidth();
+		if (rx_simd_width >= RTE_VECT_SIMD_128)
+			if (ice_rx_vec_dev_check(dev) == -1)
+				rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	}
-
 #endif
 
+	req_features.simd_width = rx_simd_width;
 	if (dev->data->scattered_rx)
-		/* Set the non-LRO scattered function */
-		ad->rx_func_type = ICE_RX_SCATTERED;
-	else if (ad->rx_bulk_alloc_allowed)
-		ad->rx_func_type = ICE_RX_BULK_ALLOC;
-	else
-		ad->rx_func_type = ICE_RX_DEFAULT;
+		req_features.scattered = CI_RX_PATH_SCATTERED;
+	if (ad->rx_bulk_alloc_allowed)
+		req_features.bulk_alloc = CI_RX_PATH_BULK_ALLOC;
+
+	ad->rx_func_type = ci_rx_path_select(req_features,
+						&ice_rx_path_infos[0],
+						RTE_DIM(ice_rx_path_infos),
+						ICE_RX_DEFAULT);
+#ifdef RTE_ARCH_X86
+	int i;
+
+	if (ice_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		/* Vector function selected. Prepare the rxq accordingly. */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			if (dev->data->rx_queues[i])
+				ice_rxq_vec_setup(dev->data->rx_queues[i]);
+#endif
 
 out:
-	dev->rx_pkt_burst = ice_rx_burst_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
-		ice_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+	dev->rx_pkt_burst = ice_rx_path_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+			ice_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 }
 
 int
@@ -3787,10 +3767,10 @@ ice_rx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(ice_rx_burst_infos); ++i) {
-		if (pkt_burst == ice_rx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(ice_rx_path_infos); ++i) {
+		if (pkt_burst == ice_rx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 ice_rx_burst_infos[i].info);
+				 ice_rx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 8c3d6c413a..e6a18310a0 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -80,6 +80,34 @@
 #define ICE_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ ICE_TX_OFFLOAD_MASK)
 
+#define ICE_RX_NO_OFFLOADS 0
+/* basic scalar path */
+#define ICE_RX_SCALAR_OFFLOADS (				\
+			RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
+			RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+			RTE_ETH_RX_OFFLOAD_SCATTER |		\
+			RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
+			RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |		\
+			RTE_ETH_RX_OFFLOAD_UDP_CKSUM |		\
+			RTE_ETH_RX_OFFLOAD_TCP_CKSUM |		\
+			RTE_ETH_RX_OFFLOAD_QINQ_STRIP |		\
+			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+			RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |	\
+			RTE_ETH_RX_OFFLOAD_RSS_HASH |		\
+			RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
+			RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)
+/* basic vector paths */
+#define ICE_RX_VECTOR_OFFLOADS (				\
+			RTE_ETH_RX_OFFLOAD_KEEP_CRC |		\
+			RTE_ETH_RX_OFFLOAD_SCATTER |		\
+			RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM)
+/* vector offload paths */
+#define ICE_RX_VECTOR_OFFLOAD_OFFLOADS (	\
+		ICE_RX_VECTOR_OFFLOADS |	\
+		RTE_ETH_RX_OFFLOAD_CHECKSUM |	\
+		RTE_ETH_RX_OFFLOAD_VLAN |	\
+		RTE_ETH_RX_OFFLOAD_RSS_HASH)
+
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
 
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 5529e06a8d..07996ab2b7 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -69,11 +69,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
 
-#define ICE_RX_VECTOR_OFFLOAD (				\
-		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
-		RTE_ETH_RX_OFFLOAD_VLAN |			\
-		RTE_ETH_RX_OFFLOAD_RSS_HASH)
-
 #define ICE_VECTOR_PATH		0
 #define ICE_VECTOR_OFFLOAD_PATH	1
 
@@ -89,10 +84,7 @@ ice_rx_vec_queue_default(struct ci_rx_queue *rxq)
 	if (rxq->proto_xtr != PROTO_XTR_NONE)
 		return -1;
 
-	if (rxq->offloads & ICE_RX_VECTOR_OFFLOAD)
-		return ICE_VECTOR_OFFLOAD_PATH;
-
-	return ICE_VECTOR_PATH;
+	return 0;
 }
 
 static inline int
@@ -120,18 +112,15 @@ ice_rx_vec_dev_check_default(struct rte_eth_dev *dev)
 	int i;
 	struct ci_rx_queue *rxq;
 	int ret = 0;
-	int result = 0;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
 		ret = (ice_rx_vec_queue_default(rxq));
 		if (ret < 0)
-			return -1;
-		if (ret == ICE_VECTOR_OFFLOAD_PATH)
-			result = ret;
+			break;
 	}
 
-	return result;
+	return ret;
 }
 
 static inline int
-- 
2.34.1

