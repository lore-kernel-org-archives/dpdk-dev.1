Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB6D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 743A940B9B;
	Tue,  9 Dec 2025 12:27:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 979C640A77
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279633; x=1796815633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qByL8nD98vhRj7cAXhrPgFYaatFdwE9xyT08GUsTTy8=;
 b=AyLJM8FPNJoXGerpqG+Y7RhOwppwt4+ZuG5hL1gB/0OCiDjma/zKTwdZ
 1ZRuFg0bT9ZukP9OXqg8RP9Pfc+Th/Bz0bzQsPdQN9Dv4iUFlMbwZmYa1
 CzpFr/T9aVWSGOCXL6u+VuVo6318aBtC104q3zaYPEFGG/YHO21K/Y2vr
 IL7R+6juqNiT3hsbKPhXw1a0VqXLV5RMndcvcDeAstWocc6jHvdrGvKH+
 hYwX9qQMh/xv1hVChqoHRDtZUqny7cLu6G44YRBiLm5su7apSBEaWD0G5
 WAt2CmN/v+nuwzlRgXYq+hOxahkdodEfmdeIiq5q9+vxDmbV4pNQHpEjf w==;
X-CSE-ConnectionGUID: G2MnM8PqREOxNhwreOPqAA==
X-CSE-MsgGUID: AKPQ1nYKQputrZWf6tUHRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117042"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:12 -0800
X-CSE-ConnectionGUID: sopzGYcUTwewLU5ODrGRRg==
X-CSE-MsgGUID: GrmtnfaARzSkkxRl/pdjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270217"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:11 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 06/13] net/i40e: use same Tx path across processes
Date: Tue,  9 Dec 2025 11:26:45 +0000
Message-ID: <20251209112652.963981-7-ciara.loftus@intel.com>
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
 drivers/net/intel/i40e/i40e_ethdev.h |  11 +++
 drivers/net/intel/i40e/i40e_rxtx.c   | 118 +++++++++++++++------------
 2 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3fca089d6c..9a89f94f0e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1243,6 +1243,16 @@ enum i40e_rx_func_type {
 	I40E_RX_ALTIVEC_SCATTERED,
 };
 
+enum i40e_tx_func_type {
+	I40E_TX_DEFAULT,
+	I40E_TX_SCALAR_SIMPLE,
+	I40E_TX_SSE,
+	I40E_TX_AVX2,
+	I40E_TX_AVX512,
+	I40E_TX_NEON,
+	I40E_TX_ALTIVEC,
+};
+
 /*
  * Structure to store private data for each PF/VF instance.
  */
@@ -1260,6 +1270,7 @@ struct i40e_adapter {
 	bool tx_vec_allowed;
 
 	enum i40e_rx_func_type rx_func_type;
+	enum i40e_tx_func_type tx_func_type;
 
 	uint64_t mbuf_check; /* mbuf check flags. */
 	uint16_t max_pkt_len; /* Maximum packet length */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..04c3a6c311 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3519,6 +3519,46 @@ i40e_set_tx_function_flag(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 				txq->queue_id);
 }
 
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} i40e_tx_burst_infos[] = {
+	[I40E_TX_DEFAULT] = {
+		.pkt_burst = i40e_xmit_pkts,
+		.info = "Scalar",
+	},
+	[I40E_TX_SCALAR_SIMPLE] = {
+		.pkt_burst = i40e_xmit_pkts_simple,
+		.info = "Scalar Simple",
+	},
+#ifdef RTE_ARCH_X86
+	[I40E_TX_SSE] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector SSE",
+	},
+	[I40E_TX_AVX2] = {
+		.pkt_burst = i40e_xmit_pkts_vec_avx2,
+		.info = "Vector AVX2",
+	},
+#ifdef CC_AVX512_SUPPORT
+	[I40E_TX_AVX512] = {
+		.pkt_burst = i40e_xmit_pkts_vec_avx512,
+		.info = "Vector AVX512",
+	},
+#endif
+#elif defined(RTE_ARCH_ARM64)
+	[I40E_TX_NEON] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector Neon",
+	},
+#elif defined(RTE_ARCH_PPC_64)
+	[I40E_TX_ALTIVEC] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector AltiVec",
+	},
+#endif
+};
+
 void __rte_cold
 i40e_set_tx_function(struct rte_eth_dev *dev)
 {
@@ -3527,19 +3567,20 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	uint64_t mbuf_check = ad->mbuf_check;
 	int i;
 
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
 #ifdef RTE_ARCH_X86
-		ad->tx_simd_width = i40e_get_max_simd_bitwidth();
+	ad->tx_simd_width = i40e_get_max_simd_bitwidth();
 #endif
-		if (ad->tx_vec_allowed) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
-				struct ci_tx_queue *txq =
-					dev->data->tx_queues[i];
+	if (ad->tx_vec_allowed) {
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			struct ci_tx_queue *txq =
+				dev->data->tx_queues[i];
 
-				if (txq && i40e_txq_vec_setup(txq)) {
-					ad->tx_vec_allowed = false;
-					break;
-				}
+			if (txq && i40e_txq_vec_setup(txq)) {
+				ad->tx_vec_allowed = false;
+				break;
 			}
 		}
 	}
@@ -3552,66 +3593,37 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
-				PMD_DRV_LOG(NOTICE, "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = i40e_xmit_pkts_vec_avx512;
+				ad->tx_func_type = I40E_TX_AVX512;
 #else
-				PMD_DRV_LOG(ERR, "Invalid Tx SIMD width reported, defaulting to "
-						"using scalar Tx (port %d).",
-						dev->data->port_id);
-				dev->tx_pkt_burst = i40e_xmit_pkts;
+				ad->tx_func_type = I40E_TX_DEFAULT;
 #endif
 			} else {
-				PMD_INIT_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					     ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
-					     dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    i40e_xmit_pkts_vec_avx2 :
-						    i40e_xmit_pkts_vec;
+				ad->tx_func_type = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
+						    I40E_TX_AVX2 :
+						    I40E_TX_SSE;
 				dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
 			}
 #else /* RTE_ARCH_X86 */
-			PMD_INIT_LOG(DEBUG, "Using Vector Tx (port %d).",
-				     dev->data->port_id);
-			dev->tx_pkt_burst = i40e_xmit_pkts_vec;
+			ad->tx_func_type = I40E_TX_SSE;
 			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
 #endif /* RTE_ARCH_X86 */
 		} else {
-			PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
-			dev->tx_pkt_burst = i40e_xmit_pkts_simple;
+			ad->tx_func_type = I40E_TX_SCALAR_SIMPLE;
 			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
 		}
 		dev->tx_pkt_prepare = i40e_simple_prep_pkts;
 	} else {
-		PMD_INIT_LOG(DEBUG, "Xmit tx finally be used.");
-		dev->tx_pkt_burst = i40e_xmit_pkts;
+		ad->tx_func_type = I40E_TX_DEFAULT;
 		dev->tx_pkt_prepare = i40e_prep_pkts;
 	}
 
-	if (mbuf_check) {
-		ad->tx_pkt_burst = dev->tx_pkt_burst;
-		dev->tx_pkt_burst = i40e_xmit_pkts_check;
-	}
-}
+out:
+	dev->tx_pkt_burst = mbuf_check ? i40e_xmit_pkts_check :
+					i40e_tx_burst_infos[ad->tx_func_type].pkt_burst;
 
-static const struct {
-	eth_tx_burst_t pkt_burst;
-	const char *info;
-} i40e_tx_burst_infos[] = {
-	{ i40e_xmit_pkts_simple,   "Scalar Simple" },
-	{ i40e_xmit_pkts,          "Scalar" },
-#ifdef RTE_ARCH_X86
-#ifdef CC_AVX512_SUPPORT
-	{ i40e_xmit_pkts_vec_avx512, "Vector AVX512" },
-#endif
-	{ i40e_xmit_pkts_vec_avx2, "Vector AVX2" },
-	{ i40e_xmit_pkts_vec,      "Vector SSE" },
-#elif defined(RTE_ARCH_ARM64)
-	{ i40e_xmit_pkts_vec,      "Vector Neon" },
-#elif defined(RTE_ARCH_PPC_64)
-	{ i40e_xmit_pkts_vec,      "Vector AltiVec" },
-#endif
-};
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		i40e_tx_burst_infos[ad->tx_func_type].info, dev->data->port_id);
+}
 
 int
 i40e_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
-- 
2.43.0

