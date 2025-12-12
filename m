Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5039FD4417E
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 033FC40DFD;
	Fri, 12 Dec 2025 12:06:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A2AF5400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:06:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537599; x=1797073599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W4l/g7IvMrM3VvzDdRV0p9NP86FmyRbVZxAEIC0HMnc=;
 b=J/6zcFP60gA+gq+PrYY05oJd50yezfWfArw3VyqrDWstq9P8ro0irVeo
 w51UiqNNcCGp62O6+ye8GKIIlW9rqce3ev4AUFGFJ3KYk8rYMoyyzTJLR
 m2kWdvx2uWjVilOJJ3iClno5aLkdsC/X354+xjS1Ngk7DDDBZjLGedH0n
 ZkieVvUCqfbAWLpqZZ+dsm/nHEUvzM1CxgrJEEEvPaviowHkenRuy9qcL
 AU8ZyJss+4ILQClv+Xv2twWM/XUkc8vVJkSZDIr4vv3yyV6dkqiQ+1HGu
 THIQZNSu/ZPUbbIafF1l7tJxdkkB/ZprEb5TikuAzaKjzEhf8C5zTPVph Q==;
X-CSE-ConnectionGUID: maVuP+mIRrecyqTmKoMb/w==
X-CSE-MsgGUID: UchI8Hj/QneCGNgiYX8AjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472047"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472047"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:38 -0800
X-CSE-ConnectionGUID: D7iCX+sMQ3CUACEz3edxWg==
X-CSE-MsgGUID: Mlu95Hy9TTOSpjY7gXYbSQ==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:37 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 02/10] net/ice: use common Tx path selection infrastructure
Date: Fri, 12 Dec 2025 11:06:20 +0000
Message-ID: <20251212110628.1634703-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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
function. Also let the primary process select the Tx path to be used by
all processes using the given device.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Fixed mbuf_check function
* Merged the patch which consolidates path selection among process types
with the introduction of the new infrastructure.
---
 drivers/net/intel/ice/ice_ethdev.c          |   1 +
 drivers/net/intel/ice/ice_ethdev.h          |  14 +-
 drivers/net/intel/ice/ice_rxtx.c            | 204 ++++++++++----------
 drivers/net/intel/ice/ice_rxtx.h            |  30 ++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h |  35 +---
 drivers/net/intel/ice/ice_rxtx_vec_sse.c    |   6 -
 6 files changed, 142 insertions(+), 148 deletions(-)

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
index 72ed65f13b..7fa2db1bd2 100644
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
@@ -658,14 +668,13 @@ struct ice_adapter {
 	bool tx_vec_allowed;
 	bool tx_simple_allowed;
 	enum ice_rx_func_type rx_func_type;
+	enum ice_tx_func_type tx_func_type;
 	/* ptype mapping table */
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[ICE_MAX_PKT_TYPE];
 	bool is_safe_mode;
 	struct ice_devargs devargs;
 	enum ice_pkg_type active_pkg_type; /* loaded ddp package type */
 	uint16_t fdir_ref_cnt;
-	/* For vector PMD */
-	eth_rx_burst_t tx_pkt_burst;
 	/* For PTP */
 	uint8_t ptp_tx_block;
 	uint8_t ptp_tx_index;
@@ -679,7 +688,6 @@ struct ice_adapter {
 	/* Set bit if the engine is disabled */
 	unsigned long disabled_engine_mask;
 	struct ice_parser *psr;
-	enum rte_vect_max_simd tx_simd_width;
 	bool rx_vec_offload_support;
 };
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..3fdb9fbf6e 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3929,6 +3929,75 @@ ice_check_empty_mbuf(struct rte_mbuf *tx_pkt)
 	return 0;
 }
 
+static const struct ci_tx_path_info ice_tx_path_infos[] = {
+	[ICE_TX_DEFAULT] = {
+		.pkt_burst = ice_xmit_pkts,
+		.info = "Scalar",
+		.features = {
+			.tx_offloads = ICE_TX_SCALAR_OFFLOADS
+		},
+		.pkt_prep = ice_prep_pkts
+	},
+	[ICE_TX_SIMPLE] = {
+		.pkt_burst = ice_xmit_pkts_simple,
+		.info = "Scalar Simple",
+		.features = {
+			.tx_offloads = ICE_TX_SCALAR_OFFLOADS,
+			.simple_tx = true
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
+	},
+#ifdef RTE_ARCH_X86
+	[ICE_TX_SSE] = {
+		.pkt_burst = ice_xmit_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
+	},
+	[ICE_TX_AVX2] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
+	},
+	[ICE_TX_AVX2_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx2_offload,
+		.info = "Offload Vector AVX2",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.pkt_prep = ice_prep_pkts
+	},
+#ifdef CC_AVX512_SUPPORT
+	[ICE_TX_AVX512] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
+	},
+	[ICE_TX_AVX512_OFFLOAD] = {
+		.pkt_burst = ice_xmit_pkts_vec_avx512_offload,
+		.info = "Offload Vector AVX512",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.pkt_prep = ice_prep_pkts
+	},
+#endif
+#endif
+};
+
 /* Tx mbuf check */
 static uint16_t
 ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
@@ -3941,6 +4010,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	const char *reason = NULL;
 	struct ice_adapter *adapter = txq->ice_vsi->adapter;
 	uint64_t ol_flags;
+	enum ice_tx_func_type tx_func_type = adapter->tx_func_type;
 
 	for (idx = 0; idx < nb_pkts; idx++) {
 		mb = tx_pkts[idx];
@@ -4025,7 +4095,7 @@ ice_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			return 0;
 	}
 
-	return adapter->tx_pkt_burst(tx_queue, tx_pkts, good_pkts);
+	return ice_tx_path_infos[tx_func_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
 }
 
 uint16_t
@@ -4097,113 +4167,37 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int mbuf_check = ad->devargs.mbuf_check;
-#ifdef RTE_ARCH_X86
-	struct ci_tx_queue *txq;
-	int i;
-	int tx_check_ret = -1;
-
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
-				}
-			}
-		} else {
-			ad->tx_vec_allowed = false;
-		}
-	}
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 
-	if (ad->tx_vec_allowed) {
-		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
-		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
-#ifdef CC_AVX512_SUPPORT
-			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX512 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst =
-					ice_xmit_pkts_vec_avx512_offload;
-				dev->tx_pkt_prepare = ice_prep_pkts;
-			} else {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = ice_xmit_pkts_vec_avx512;
-			}
-#endif
-		} else {
-			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using AVX2 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst =
-					ice_xmit_pkts_vec_avx2_offload;
-				dev->tx_pkt_prepare = ice_prep_pkts;
-			} else {
-				PMD_DRV_LOG(DEBUG, "Using %sVector Tx (port %d).",
-					    ad->tx_simd_width == RTE_VECT_SIMD_256 ? "avx2 " : "",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = ad->tx_simd_width == RTE_VECT_SIMD_256 ?
-						    ice_xmit_pkts_vec_avx2 :
-						    ice_xmit_pkts_vec;
-			}
-		}
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
 
-		if (mbuf_check) {
-			ad->tx_pkt_burst = dev->tx_pkt_burst;
-			dev->tx_pkt_burst = ice_xmit_pkts_check;
-		}
-		return;
-	}
+	req_features.simple_tx = ad->tx_simple_allowed;
+
+#ifdef RTE_ARCH_X86
+	if (ice_tx_vec_dev_check(dev) != -1)
+		req_features.simd_width = ice_get_max_simd_bitwidth();
 #endif
 
-	if (ad->tx_simple_allowed) {
-		PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
-		dev->tx_pkt_burst = ice_xmit_pkts_simple;
-		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
-	} else {
-		PMD_INIT_LOG(DEBUG, "Normal tx finally be used.");
-		dev->tx_pkt_burst = ice_xmit_pkts;
-		dev->tx_pkt_prepare = ice_prep_pkts;
-	}
+	ad->tx_func_type = ci_tx_path_select(&req_features,
+						&ice_tx_path_infos[0],
+						RTE_DIM(ice_tx_path_infos),
+						ICE_TX_DEFAULT);
 
-	if (mbuf_check) {
-		ad->tx_pkt_burst = dev->tx_pkt_burst;
-		dev->tx_pkt_burst = ice_xmit_pkts_check;
-	}
-}
+out:
+	if (ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		ad->tx_vec_allowed = true;
 
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
+	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
+					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = ice_tx_path_infos[ad->tx_func_type].pkt_prep;
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+		ice_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
+}
 
 int
 ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
@@ -4213,10 +4207,10 @@ ice_tx_burst_mode_get(struct rte_eth_dev *dev, __rte_unused uint16_t queue_id,
 	int ret = -EINVAL;
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(ice_tx_burst_infos); ++i) {
-		if (pkt_burst == ice_tx_burst_infos[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(ice_tx_path_infos); ++i) {
+		if (pkt_burst == ice_tx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 ice_tx_burst_infos[i].info);
+				 ice_tx_path_infos[i].info);
 			ret = 0;
 			break;
 		}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 141a62a7da..d7e8c1b0c4 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -108,6 +108,35 @@
 		RTE_ETH_RX_OFFLOAD_VLAN_FILTER |\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
+/* basic scalar path */
+#define ICE_TX_SCALAR_OFFLOADS (		\
+	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+	RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+	RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |	\
+	RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
+	RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
+	RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
+/* basic vector path */
+#define ICE_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+/* vector offload paths */
+#define ICE_TX_VECTOR_OFFLOAD_OFFLOADS (	\
+	ICE_TX_VECTOR_OFFLOADS |		\
+	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+	RTE_ETH_TX_OFFLOAD_SCTP_CKSUM)
+
 /* Max header size can be 2K - 64 bytes */
 #define ICE_RX_HDR_BUF_SIZE    (2048 - 64)
 
@@ -249,7 +278,6 @@ void ice_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq,
 int ice_rx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_tx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_rxq_vec_setup(struct ci_rx_queue *rxq);
-int ice_txq_vec_setup(struct ci_tx_queue *txq);
 uint16_t ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts);
 uint16_t ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 39581cb7ae..ff46a8fb49 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -51,28 +51,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 	memset(rxq->sw_ring, 0, sizeof(rxq->sw_ring[0]) * rxq->nb_rx_desc);
 }
 
-#define ICE_TX_NO_VECTOR_FLAGS (			\
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
-		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |    \
-		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)
-
-#define ICE_TX_VECTOR_OFFLOAD (				\
-		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |		\
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
-
-#define ICE_VECTOR_PATH		0
-#define ICE_VECTOR_OFFLOAD_PATH	1
-
 static inline int
 ice_rx_vec_queue_default(struct ci_rx_queue *rxq)
 {
@@ -98,13 +76,7 @@ ice_tx_vec_queue_default(struct ci_tx_queue *txq)
 	    txq->tx_rs_thresh > ICE_TX_MAX_FREE_BUF_SZ)
 		return -1;
 
-	if (txq->offloads & ICE_TX_NO_VECTOR_FLAGS)
-		return -1;
-
-	if (txq->offloads & ICE_TX_VECTOR_OFFLOAD)
-		return ICE_VECTOR_OFFLOAD_PATH;
-
-	return ICE_VECTOR_PATH;
+	return 0;
 }
 
 static inline int
@@ -130,18 +102,15 @@ ice_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	int i;
 	struct ci_tx_queue *txq;
 	int ret = 0;
-	int result = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		ret = ice_tx_vec_queue_default(txq);
 		if (ret < 0)
 			return -1;
-		if (ret == ICE_VECTOR_OFFLOAD_PATH)
-			result = ret;
 	}
 
-	return result;
+	return ret;
 }
 
 static inline void
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_sse.c b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
index 1545bc3b6e..4fc1b7e881 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_sse.c
+++ b/drivers/net/intel/ice/ice_rxtx_vec_sse.c
@@ -718,12 +718,6 @@ ice_rxq_vec_setup(struct ci_rx_queue *rxq)
 	return 0;
 }
 
-int __rte_cold
-ice_txq_vec_setup(struct ci_tx_queue *txq __rte_unused)
-{
-	return 0;
-}
-
 int __rte_cold
 ice_rx_vec_dev_check(struct rte_eth_dev *dev)
 {
-- 
2.43.0

