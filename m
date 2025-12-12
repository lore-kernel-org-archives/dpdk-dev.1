Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE0CD44176
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:33:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847FB40A7A;
	Fri, 12 Dec 2025 11:33:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4288C40268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535617; x=1797071617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tC2AXqcEyG+nsyuSVZwON19txQtF6GtWhmrSdZAazkI=;
 b=UxTQ9BwNrVdvyMR1RVyD/2dlK4d/WSCgz0cla+cc3Md5AaR3bwpKoRwi
 C2hjQJ87SGDtZOIwG+L+JNlx6TlrW/HW6F01Zat8+Uy0vAroEg2Gh0Sqo
 K0mUQw+sYJNusYfDJI0CN/gZbD5NOcO99Sfmg+p4QnDLs44qawyqW2rsS
 6/A6yY7e0CQborPeqbo/W3e6gSuJqwop9naFY4sQFq9bF2WCpHs/f3Cxo
 P1JVDbxvcw2PvBa4JUyjuZpIkqafJuSW0thXzs1h2HFb9hsIi/FfmGNp6
 H5rVMML+CTkDn5gVd+gaRyI3wznbuSefxKoULdvBdVL51ytUpzMyWfgO9 A==;
X-CSE-ConnectionGUID: Lsm3I2qnTIiRhQOWjWglsA==
X-CSE-MsgGUID: AogwYzIrS7u/2SOlONoORQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522880"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522880"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:36 -0800
X-CSE-ConnectionGUID: c1VDJ2IqQ6yRlKxi/Wp05w==
X-CSE-MsgGUID: +JnupgDZTJuCIhr8jyYhWw==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:32 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 04/10] net/i40e: use common Tx path selection infrastructure
Date: Fri, 12 Dec 2025 10:33:17 +0000
Message-ID: <20251212103323.1481307-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212103323.1481307-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251212103323.1481307-1-ciara.loftus@intel.com>
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
function. Let the primary process select the Tx path to be used by all
processes using the given device.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Merged the patch which consolidates path selection among process types
with the introduction of the new infrastructure.
* Fixed mbuf_check logic
* Fixed assignment of pkt_prepare function
---
 drivers/net/intel/i40e/i40e_ethdev.h          |  14 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 190 ++++++++++--------
 drivers/net/intel/i40e/i40e_rxtx.h            |  20 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 -
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 -
 6 files changed, 135 insertions(+), 107 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3fca089d6c..1fe504d0cd 100644
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
@@ -1260,10 +1270,10 @@ struct i40e_adapter {
 	bool tx_vec_allowed;
 
 	enum i40e_rx_func_type rx_func_type;
+	enum i40e_tx_func_type tx_func_type;
 
 	uint64_t mbuf_check; /* mbuf check flags. */
 	uint16_t max_pkt_len; /* Maximum packet length */
-	eth_tx_burst_t tx_pkt_burst;
 
 	/* For PTP */
 	struct rte_timecounter systime_tc;
@@ -1279,8 +1289,6 @@ struct i40e_adapter {
 
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
-
-	enum rte_vect_max_simd tx_simd_width;
 };
 
 /**
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..a7d80e2bc0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1550,6 +1550,77 @@ i40e_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
+static const struct ci_tx_path_info i40e_tx_path_infos[] = {
+	[I40E_TX_DEFAULT] = {
+		.pkt_burst = i40e_xmit_pkts,
+		.info = "Scalar",
+		.features = {
+			.tx_offloads = I40E_TX_SCALAR_OFFLOADS,
+		},
+		.pkt_prep = i40e_prep_pkts,
+	},
+	[I40E_TX_SCALAR_SIMPLE] = {
+		.pkt_burst = i40e_xmit_pkts_simple,
+		.info = "Scalar Simple",
+		.features = {
+			.tx_offloads = I40E_TX_SCALAR_OFFLOADS,
+			.simple_tx = true
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+#ifdef RTE_ARCH_X86
+	[I40E_TX_SSE] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+	[I40E_TX_AVX2] = {
+		.pkt_burst = i40e_xmit_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+#ifdef CC_AVX512_SUPPORT
+	[I40E_TX_AVX512] = {
+		.pkt_burst = i40e_xmit_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+#endif
+#elif defined(RTE_ARCH_ARM64)
+	[I40E_TX_NEON] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+#elif defined(RTE_ARCH_PPC_64)
+	[I40E_TX_ALTIVEC] = {
+		.pkt_burst = i40e_xmit_pkts_vec,
+		.info = "Vector AltiVec",
+		.features = {
+			.tx_offloads = I40E_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+		},
+		.pkt_prep = i40e_simple_prep_pkts,
+	},
+#endif
+};
+
 /* Tx mbuf check */
 static uint16_t
 i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
@@ -1562,6 +1633,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
 	const char *reason = NULL;
 	uint16_t good_pkts = nb_pkts;
 	struct i40e_adapter *adapter = txq->i40e_vsi->adapter;
+	enum i40e_tx_func_type tx_func_type = adapter->tx_func_type;
 
 	for (idx = 0; idx < nb_pkts; idx++) {
 		mb = tx_pkts[idx];
@@ -1652,7 +1724,7 @@ i40e_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts
 			return 0;
 	}
 
-	return adapter->tx_pkt_burst(tx_queue, tx_pkts, good_pkts);
+	return i40e_tx_path_infos[tx_func_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
 }
 
 /*********************************************************************
@@ -2375,8 +2447,7 @@ i40e_dev_tx_queue_setup_runtime(struct rte_eth_dev *dev,
 
 	/* check vector conflict */
 	if (ad->tx_vec_allowed) {
-		if (txq->tx_rs_thresh > I40E_TX_MAX_FREE_BUF_SZ ||
-		    i40e_txq_vec_setup(txq)) {
+		if (txq->tx_rs_thresh > I40E_TX_MAX_FREE_BUF_SZ) {
 			PMD_DRV_LOG(ERR, "Failed vector tx setup.");
 			return -EINVAL;
 		}
@@ -3525,93 +3596,42 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	struct i40e_adapter *ad =
 		I40E_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint64_t mbuf_check = ad->mbuf_check;
-	int i;
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-#ifdef RTE_ARCH_X86
-		ad->tx_simd_width = i40e_get_max_simd_bitwidth();
-#endif
-		if (ad->tx_vec_allowed) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
-				struct ci_tx_queue *txq =
-					dev->data->tx_queues[i];
-
-				if (txq && i40e_txq_vec_setup(txq)) {
-					ad->tx_vec_allowed = false;
-					break;
-				}
-			}
-		}
-	}
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.simple_tx = ad->tx_simple_allowed
+	};
 
-	if (rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_128)
-		ad->tx_vec_allowed = false;
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
 
-	if (ad->tx_simple_allowed) {
-		if (ad->tx_vec_allowed) {
+	if (ad->tx_vec_allowed) {
 #ifdef RTE_ARCH_X86
-			if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-				PMD_DRV_LOG(NOTICE, "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = i40e_xmit_pkts_vec_avx512;
+		req_features.simd_width = i40e_get_max_simd_bitwidth();
 #else
-				PMD_DRV_LOG(ERR, "Invalid Tx SIMD width reported, defaulting to "
-						"using scalar Tx (port %d).",
-						dev->data->port_id);
-				dev->tx_pkt_burst = i40e_xmit_pkts;
+		req_features.simd_width = rte_vect_get_max_simd_bitwidth();
 #endif
-			} else {
-				PMD_INIT_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					     ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
-					     dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    i40e_xmit_pkts_vec_avx2 :
-						    i40e_xmit_pkts_vec;
-				dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-			}
-#else /* RTE_ARCH_X86 */
-			PMD_INIT_LOG(DEBUG, "Using Vector Tx (port %d).",
-				     dev->data->port_id);
-			dev->tx_pkt_burst = i40e_xmit_pkts_vec;
-			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-#endif /* RTE_ARCH_X86 */
-		} else {
-			PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
-			dev->tx_pkt_burst = i40e_xmit_pkts_simple;
-			dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
-		}
-		dev->tx_pkt_prepare = i40e_simple_prep_pkts;
-	} else {
-		PMD_INIT_LOG(DEBUG, "Xmit tx finally be used.");
-		dev->tx_pkt_burst = i40e_xmit_pkts;
-		dev->tx_pkt_prepare = i40e_prep_pkts;
 	}
 
-	if (mbuf_check) {
-		ad->tx_pkt_burst = dev->tx_pkt_burst;
-		dev->tx_pkt_burst = i40e_xmit_pkts_check;
-	}
-}
+	ad->tx_func_type = ci_tx_path_select(&req_features, &i40e_tx_path_infos[0],
+						RTE_DIM(i40e_tx_path_infos), I40E_TX_DEFAULT);
 
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
+out:
+	dev->tx_pkt_burst = mbuf_check ? i40e_xmit_pkts_check :
+					 i40e_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = i40e_tx_path_infos[ad->tx_func_type].pkt_prep;
+
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
+
+	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
+			ad->tx_func_type == I40E_TX_SSE ||
+			ad->tx_func_type == I40E_TX_NEON ||
+			ad->tx_func_type == I40E_TX_ALTIVEC ||
+			ad->tx_func_type == I40E_TX_AVX2)
+		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
+}
 
 int
 i40e_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
@@ -3621,10 +3641,10 @@ i40e_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(i40e_tx_burst_infos); ++i) {
-		if (pkt_burst == i40e_tx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(i40e_tx_path_infos); ++i) {
+		if (pkt_burst == i40e_tx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 i40e_tx_burst_infos[i].info);
+				 i40e_tx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index b5a901794f..ed173d8f17 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -91,6 +91,25 @@ enum i40e_header_split_mode {
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |	\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
+#define I40E_TX_SCALAR_OFFLOADS (			\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+
+#define I40E_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+
 /** Offload features */
 union i40e_tx_offload {
 	uint64_t data;
@@ -165,7 +184,6 @@ uint16_t i40e_recv_scattered_pkts_vec(void *rx_queue,
 				      uint16_t nb_pkts);
 int i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev);
 int i40e_rxq_vec_setup(struct ci_rx_queue *rxq);
-int i40e_txq_vec_setup(struct ci_tx_queue *txq);
 void i40e_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq);
 uint16_t i40e_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 				   uint16_t nb_pkts);
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
index 87a57e7520..bbb6d907cf 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
@@ -547,12 +547,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue __rte_unused * txq)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
index c9098e4c1a..b5be0c1b59 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
@@ -697,12 +697,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
index c035408dcc..c209135890 100644
--- a/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
+++ b/drivers/net/intel/i40e/i40e_rxtx_vec_sse.c
@@ -704,12 +704,6 @@ i40e_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-i40e_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 i40e_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
-- 
2.43.0

