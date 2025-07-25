Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1195C87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C427640696;
	Fri, 25 Jul 2025 14:50:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5DB704066F
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447818; x=1784983818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XetIHsMhkO5xsuI298FYCAR5sirGW/Rmhjm3c7SGcBg=;
 b=J0XYqm6E6EGI+b5ylbZnMJLMC/bz79KDNPn6RmZw6VC5BSlgQZOj3Vp8
 e25KQWK+mhTOCXus5NXWtnSiRtUPYYluDrAitnkSx4pQuy1UoDOjeIxEL
 N3X8mSDW/b/WvUCzvYXj9xrTtxj+JppePMPU5ijy8rT+3brNx6JxLhU+4
 TTlNQNWUSvQwNsseGsXUTAQhSEXuFQb+QSbTagksLSNzoGosSH6mUF+il
 QR0gXw7+ff5WUEtXjvlq8blGfe3sfo/FX7LdaZy/5Z6WnQk6KJVGPnCD0
 zCon8ynw+cHh5RNs+K0b9vKroKMmrLH9VZsXN6MXkxAMjbsc/qLsN3IoB A==;
X-CSE-ConnectionGUID: cyhuKqNOQdWHsJ/BMYoCAQ==
X-CSE-MsgGUID: mxrBmk+PQyymlWVRJJKnbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480161"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:18 -0700
X-CSE-ConnectionGUID: s6AUymrnTFWTrep0IXj77Q==
X-CSE-MsgGUID: 0K5PSZrHSzC2e9fUCkP0gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152344"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:17 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 12/14] net/ice: use the common Rx path selection
 infrastructure
Date: Fri, 25 Jul 2025 12:49:17 +0000
Message-Id: <20250725124919.3564890-13-ciara.loftus@intel.com>
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
 drivers/net/intel/ice/ice_ethdev.h          |   1 -
 drivers/net/intel/ice/ice_rxtx.c            | 157 +++++++++-----------
 drivers/net/intel/ice/ice_rxtx.h            |  28 ++++
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  17 +--
 4 files changed, 100 insertions(+), 103 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 992fcc9175..5684fe27f6 100644
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
index 79217249b9..8887b06db2 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3662,29 +3662,46 @@ ice_xmit_pkts_simple(void *tx_queue,
 	return nb_tx;
 }
 
-static const struct {
-	eth_rx_burst_t pkt_burst;
-	const char *info;
-} ice_rx_burst_infos[] = {
-	[ICE_RX_SCATTERED] = { ice_recv_scattered_pkts, "Scalar Scattered" },
-	[ICE_RX_BULK_ALLOC] = { ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc" },
-	[ICE_RX_DEFAULT] = { ice_recv_pkts, "Scalar" },
+static const struct ci_rx_burst_info ice_rx_burst_infos[] = {
+	[ICE_RX_SCATTERED] = {ice_recv_scattered_pkts, "Scalar Scattered",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_SCATTERED}},
+	[ICE_RX_BULK_ALLOC] = {ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_DEFAULT] = {ice_recv_pkts, "Scalar",
+		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, CI_RX_BURST_NO_FEATURES}},
 #ifdef RTE_ARCH_X86
 #ifdef CC_AVX512_SUPPORT
-	[ICE_RX_AVX512_SCATTERED] = {
-		ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered" },
+	[ICE_RX_AVX512_SCATTERED] = {ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered" },
-	[ICE_RX_AVX512] = { ice_recv_pkts_vec_avx512, "Vector AVX512" },
-	[ICE_RX_AVX512_OFFLOAD] = { ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512" },
+		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_AVX512] = {ice_recv_pkts_vec_avx512, "Vector AVX512",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_AVX512_OFFLOAD] = {ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
-	[ICE_RX_AVX2_SCATTERED] = { ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered" },
+	[ICE_RX_AVX2_SCATTERED] = {ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
 	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered" },
-	[ICE_RX_AVX2] = { ice_recv_pkts_vec_avx2, "Vector AVX2" },
-	[ICE_RX_AVX2_OFFLOAD] = { ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2" },
-	[ICE_RX_SSE_SCATTERED] = { ice_recv_scattered_pkts_vec, "Vector SSE Scattered" },
-	[ICE_RX_SSE] = { ice_recv_pkts_vec, "Vector SSE" },
+		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_AVX2] = {ice_recv_pkts_vec_avx2, "Vector AVX2",
+		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_AVX2_OFFLOAD] = {ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_SSE_SCATTERED] = {ice_recv_scattered_pkts_vec, "Vector SSE Scattered",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_SCATTERED | CI_RX_BURST_FEATURE_BULK_ALLOC}},
+	[ICE_RX_SSE] = {ice_recv_pkts_vec, "Vector SSE",
+		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
+			CI_RX_BURST_FEATURE_BULK_ALLOC}},
 #endif
 };
 
@@ -3694,89 +3711,53 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
+	struct ci_rx_burst_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.other_features_mask = CI_RX_BURST_NO_FEATURES
+	};
+	int rx_func_type = ICE_RX_DEFAULT;
 
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
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_SCATTERED;
+	if (ad->rx_bulk_alloc_allowed)
+		req_features.other_features_mask |= CI_RX_BURST_FEATURE_BULK_ALLOC;
+
+	rx_func_type = ci_rx_burst_mode_select(&ice_rx_burst_infos[0],
+						req_features,
+						RTE_DIM(ice_rx_burst_infos),
+						ICE_RX_DEFAULT);
+#ifdef RTE_ARCH_X86
+	int i;
+
+	if (ice_rx_burst_infos[rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		/* Vector function selected. Prepare the rxq accordingly. */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			if (dev->data->rx_queues[i])
+				ice_rxq_vec_setup(dev->data->rx_queues[i]);
+#endif
 
 out:
-	dev->rx_pkt_burst = ice_rx_burst_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s Rx burst function (port %d).",
-		ice_rx_burst_infos[ad->rx_func_type].info, dev->data->port_id);
+	dev->rx_pkt_burst = ice_rx_burst_infos[rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+			ice_rx_burst_infos[rx_func_type].info, dev->data->port_id);
 }
 
 int
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

