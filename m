Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61014D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 139DF40A73;
	Tue,  9 Dec 2025 12:27:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 46D414025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279628; x=1796815628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xJVul7y730DNAJaJKXFU1imI73GAoVs2cZmW9XbOHaI=;
 b=PUPugcCxNPwSknoaHPtg9+sG4GXtgim1WPjGRXLE0+Fx8Y4LQcXh7wZH
 GmcyJ4LcL0kOjwCX73QT6I3K3cwlYEHk4pBy5f4G+96mkyOnuDOPOIaRz
 +MjIb4kPsqhiV4RAxmvIgtokm7FvjU/jnNO/zARBge6zt/ae+QZk+Jv0Y
 Xif4u9GVnxkRXDRxDrThJVXryQ5jNFQnrXvC7octz/g7mCUiCVPc4wBVa
 Bc+u/XMy/1GmgdViGpNSmreMTLuT3CzafqMFh90D1N8WwdKFr5kn0oi5B
 HBd68gkWwDlgchZ1ANtcSvC6ByGl6DmkFUTuZ4Q28a3/L+kREmf1YbhHY A==;
X-CSE-ConnectionGUID: coLJ1RiUTJWY72UYzitpAg==
X-CSE-MsgGUID: hze1lGVyQkOP0H/2X62zFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117032"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:08 -0800
X-CSE-ConnectionGUID: Ed/R6CvMTmO6oUnHrk6ytQ==
X-CSE-MsgGUID: GBlQhcQRTlaqaTfu5VxnGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270184"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:07 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 02/13] net/ice: use same Tx path across processes
Date: Tue,  9 Dec 2025 11:26:41 +0000
Message-ID: <20251209112652.963981-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209112652.963981-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
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

In the interest of simplicity, let the primary process select the Tx
path to be used by all processes using the given device.

The many logs which report individual Tx path selections have been
consolidated into one single log.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c |   1 +
 drivers/net/intel/ice/ice_ethdev.h |  12 ++-
 drivers/net/intel/ice/ice_rxtx.c   | 139 ++++++++++++++++-------------
 3 files changed, 87 insertions(+), 65 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c721d135f5..a805e78d03 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3900,6 +3900,7 @@ ice_dev_configure(struct rte_eth_dev *dev)
 	ad->tx_simple_allowed = true;
 
 	ad->rx_func_type = ICE_RX_DEFAULT;
+	ad->tx_func_type = ICE_TX_DEFAULT;
 
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 72ed65f13b..0b8af339d1 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -208,6 +208,16 @@ enum ice_rx_func_type {
 	ICE_RX_AVX512_SCATTERED_OFFLOAD,
 };
 
+enum ice_tx_func_type {
+	ICE_TX_DEFAULT,
+	ICE_TX_SIMPLE,
+	ICE_TX_SSE,
+	ICE_TX_AVX2,
+	ICE_TX_AVX2_OFFLOAD,
+	ICE_TX_AVX512,
+	ICE_TX_AVX512_OFFLOAD,
+};
+
 struct ice_adapter;
 
 /**
@@ -658,6 +668,7 @@ struct ice_adapter {
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
 	enum ice_rx_func_type rx_func_type;
+	enum ice_tx_func_type tx_func_type;
 	/* ptype mapping table */
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[ICE_MAX_PKT_TYPE];
 	bool is_safe_mode;
@@ -679,7 +690,6 @@ struct ice_adapter {
 	/* Set bit if the engine is disabled */
 	unsigned long disabled_engine_mask;
 	struct ice_parser *psr;
-	enum rte_vect_max_simd tx_simd_width;
 	bool rx_vec_offload_support;
 };
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..f05ca83e5b 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4091,6 +4091,44 @@ ice_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return i;
 }
 
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} ice_tx_burst_infos[] = {
+	[ICE_TX_DEFAULT] = {
+		.pkt_burst = ice_xmit_pkts,
+		.info = "Scalar"
+	},
+	[ICE_TX_SIMPLE] = {
+		.pkt_burst = ice_xmit_pkts_simple,
+		.info = "Scalar Simple"
+	},
+#ifdef RTE_ARCH_X86
+	[ICE_TX_SSE] = {
+		.pkt_burst = ice_xmit_pkts_vec,
+		.info = "Vector SSE"
+	},
+	[ICE_TX_AVX2] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2,
+		.info = "Vector AVX2"
+	},
+	[ICE_TX_AVX2_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
+		.info = "Offload Vector AVX2"
+	},
+#ifdef CC_AVX512_SUPPORT
+	[ICE_TX_AVX512] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512,
+		.info = "Vector AVX512"
+	},
+	[ICE_TX_AVX512_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
+		.info = "Offload Vector AVX512"
+	},
+#endif
+#endif
+};
+
 void __rte_cold
 ice_set_tx_function(struct rte_eth_dev *dev)
 {
@@ -4101,74 +4139,58 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	struct ci_tx_queue *txq;
 	int i;
 	int tx_check_ret = -1;
+	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
 
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
-		tx_check_ret = ice_tx_vec_dev_check(dev);
-		ad->tx_simd_width = ice_get_max_simd_bitwidth();
-		if (tx_check_ret >= 0 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-			ad->tx_vec_allowed = true;
-
-			if (ad->tx_simd_width < RTE_VECT_SIMD_256 &&
-				tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
-				ad->tx_vec_allowed = false;
-
-			if (ad->tx_vec_allowed) {
-				for (i = 0; i < dev->data->nb_tx_queues; i++) {
-					txq = dev->data->tx_queues[i];
-					if (txq && ice_txq_vec_setup(txq)) {
-						ad->tx_vec_allowed = false;
-						break;
-					}
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
+	tx_check_ret = ice_tx_vec_dev_check(dev);
+	tx_simd_width = ice_get_max_simd_bitwidth();
+	if (tx_check_ret >= 0 &&
+		rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
+		ad->tx_vec_allowed = true;
+
+		if (tx_simd_width < RTE_VECT_SIMD_256 &&
+			tx_check_ret == ICE_VECTOR_OFFLOAD_PATH)
+			ad->tx_vec_allowed = false;
+
+		if (ad->tx_vec_allowed) {
+			for (i = 0; i < dev->data->nb_tx_queues; i++) {
+				txq = dev->data->tx_queues[i];
+				if (txq && ice_txq_vec_setup(txq)) {
+					ad->tx_vec_allowed = false;
+					break;
 				}
 			}
-		} else {
-			ad->tx_vec_allowed = false;
 		}
+	} else {
+		ad->tx_vec_allowed = false;
 	}
 
 	if (ad->tx_vec_allowed) {
 		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
-		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
+		if (tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX512 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst =
-					ice_xmit_pkts_vec_avx512_offload;
+				ad->tx_func_type = ICE_TX_AVX512_OFFLOAD;
 				dev->tx_pkt_prepare = ice_prep_pkts;
 			} else {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = ice_xmit_pkts_vec_avx512;
+				ad->tx_func_type = ICE_TX_AVX512;
 			}
 #endif
 		} else {
 			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX2 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst =
-					ice_xmit_pkts_vec_avx2_offload;
+				ad->tx_func_type = ICE_TX_AVX2_OFFLOAD;
 				dev->tx_pkt_prepare = ice_prep_pkts;
 			} else {
-				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    ice_xmit_pkts_vec_avx2 :
-						    ice_xmit_pkts_vec;
+				ad->tx_func_type = tx_simd_width == RTE_VECT_SIMD_256 ?
+						    ICE_TX_AVX2 :
+						    ICE_TX_SSE;
 			}
 		}
 
-		if (mbuf_check) {
-			ad->tx_pkt_burst = dev->tx_pkt_burst;
-			dev->tx_pkt_burst = ice_xmit_pkts_check;
-		}
-		return;
+		goto out;
 	}
 #endif
 
@@ -4186,24 +4208,13 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 		ad->tx_pkt_burst = dev->tx_pkt_burst;
 		dev->tx_pkt_burst = ice_xmit_pkts_check;
 	}
-}
 
-static const struct {
-	eth_tx_burst_t pkt_burst;
-	const char *info;
-} ice_tx_burst_infos[] = {
-	{ ice_xmit_pkts_simple,   "Scalar Simple" },
-	{ ice_xmit_pkts,          "Scalar" },
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	{ ice_xmit_pkts_vec_avx512, "Vector AVX512" },
-	{ ice_xmit_pkts_vec_avx512_offload, "Offload Vector AVX512" },
-#endif
-	{ ice_xmit_pkts_vec_avx2,         "Vector AVX2" },
-	{ ice_xmit_pkts_vec_avx2_offload, "Offload Vector AVX2" },
-	{ ice_xmit_pkts_vec,              "Vector SSE" },
-#endif
-};
+out:
+	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
+					 ice_tx_burst_infos[ad->tx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		ice_tx_burst_infos[ad->tx_func_type].info, dev->data->port_id);
+}
 
 int
 ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.43.0

