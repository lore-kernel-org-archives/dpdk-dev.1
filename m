Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9206D44176
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B77DE4026F;
	Fri, 12 Dec 2025 11:33:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id AF4124026F
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535618; x=1797071618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Eouy+9UyqROtMpx/VssEQiHyWaSenHEv35hw5Uf9kw=;
 b=U2i4zbVQ/wiuCMTHgtUrxYDmtkLBXvyNZvs/HabkWRy6uqIbiUVGiBK3
 X0M5o63I9iERhd6AFwwMfBCmwCT1aqKJz9q0BXx7NiVgj8Ybwkj0O2gR+
 7D2oCdspJf0MlRg+3zz1GKnegw4QvqwwsN5igNnsfHD3Uiyt7dFIbE0lT
 hD3mT9Gzvd3HYCViRir+8rpcg4R5K+WwjKq9Uj2mhKqGkmXtc5UWv0C5U
 upJbJyHO80O4JyPnuQAVCrEUoh8q7ZnU6w4zgDP9CLFNI5GMPV8NqMYlQ
 hp9OPLSVteuij5/RS6UPZKDDQO5f/1fjMdGZvMM2F01/96m56LQuNY+d0 A==;
X-CSE-ConnectionGUID: p/tzfrB9Qb275ELPpMaZlQ==
X-CSE-MsgGUID: KEHfdMICRvi0XGFWxiC0VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522881"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522881"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:36 -0800
X-CSE-ConnectionGUID: +z/praAiRGakEODpl05YsQ==
X-CSE-MsgGUID: iRPr1bv8QhKh3kzDHoFZyA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:33 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 05/10] net/idpf: use common Tx path selection infrastructure
Date: Fri, 12 Dec 2025 10:33:18 +0000
Message-ID: <20251212103323.1481307-6-ciara.loftus@intel.com>
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

Introduce a new feature "single queue" to the common infrastructure
which represents whether single or split queue mode is used in the given
path.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* removed unnecessary tx_vec_allowed
---
 drivers/net/intel/common/tx.h                 |   5 +
 drivers/net/intel/idpf/idpf_common_device.h   |  10 ++
 drivers/net/intel/idpf/idpf_common_rxtx.c     |  49 ++++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 ++
 drivers/net/intel/idpf/idpf_rxtx.c            | 118 ++++++------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  10 --
 6 files changed, 112 insertions(+), 92 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 60b1bd642a..24fcfbe225 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -124,6 +124,7 @@ struct ci_tx_path_features {
 	bool simple_tx;
 	bool ctx_desc;
 	bool disabled;
+	bool single_queue;
 };
 
 struct ci_tx_path_info {
@@ -318,6 +319,10 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 		if (!path_features->ctx_desc && req_features->ctx_desc)
 			continue;
 
+		/* If requested, ensure the path supports single queue TX. */
+		if (path_features->single_queue != req_features->single_queue)
+			continue;
+
 		/* Ensure the path supports the requested TX offloads. */
 		if ((path_features->tx_offloads & req_features->tx_offloads) !=
 				req_features->tx_offloads)
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index c32dcfbb12..eff04a83eb 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -75,6 +75,15 @@ enum idpf_rx_func_type {
 	IDPF_RX_MAX
 };
 
+enum idpf_tx_func_type {
+	IDPF_TX_DEFAULT,
+	IDPF_TX_SINGLEQ,
+	IDPF_TX_SINGLEQ_AVX2,
+	IDPF_TX_AVX512,
+	IDPF_TX_SINGLEQ_AVX512,
+	IDPF_TX_MAX
+};
+
 struct idpf_adapter {
 	struct idpf_hw hw;
 	struct virtchnl2_version_info virtchnl_version;
@@ -92,6 +101,7 @@ struct idpf_adapter {
 	uint64_t time_hw;
 
 	enum idpf_rx_func_type rx_func_type;
+	enum idpf_tx_func_type tx_func_type;
 };
 
 struct idpf_chunks_info {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a5d0795057..cfeab8a1e4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1701,3 +1701,52 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 #endif /* CC_AVX512_SUPPORT */
 #endif /* RTE_ARCH_X86 */
 };
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_tx_path_infos)
+const struct ci_tx_path_info idpf_tx_path_infos[] = {
+	[IDPF_TX_DEFAULT] = {
+		.pkt_burst = idpf_dp_splitq_xmit_pkts,
+		.info = "Split Scalar",
+		.features = {
+			.tx_offloads = IDPF_TX_SCALAR_OFFLOADS
+		}
+	},
+	[IDPF_TX_SINGLEQ] = {
+		.pkt_burst = idpf_dp_singleq_xmit_pkts,
+		.info = "Single Scalar",
+		.features = {
+			.tx_offloads = IDPF_TX_SCALAR_OFFLOADS,
+			.single_queue = true
+		}
+	},
+#ifdef RTE_ARCH_X86
+	[IDPF_TX_SINGLEQ_AVX2] = {
+		.pkt_burst = idpf_dp_singleq_xmit_pkts_avx2,
+		.info = "Single AVX2",
+		.features = {
+			.tx_offloads = IDPF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.single_queue = true
+		}
+	},
+#ifdef CC_AVX512_SUPPORT
+	[IDPF_TX_AVX512] = {
+		.pkt_burst = idpf_dp_splitq_xmit_pkts_avx512,
+		.info = "Split AVX512",
+		.features = {
+			.tx_offloads = IDPF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		}
+	},
+	[IDPF_TX_SINGLEQ_AVX512] = {
+		.pkt_burst = idpf_dp_singleq_xmit_pkts_avx512,
+		.info = "Single AVX512",
+		.features = {
+			.tx_offloads = IDPF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.single_queue = true
+		}
+	},
+#endif /* CC_AVX512_SUPPORT */
+#endif /* RTE_ARCH_X86 */
+};
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 3bc3323af4..7c6ff5d047 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -106,6 +106,17 @@
 		RTE_ETH_RX_OFFLOAD_SCATTER)
 #define IDPF_RX_VECTOR_OFFLOADS 0
 
+#define IDPF_TX_SCALAR_OFFLOADS (		\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |	\
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+
+#define IDPF_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+
 struct idpf_rx_stats {
 	RTE_ATOMIC(uint64_t) mbuf_alloc_failed;
 };
@@ -264,5 +275,6 @@ uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
 					uint16_t nb_pkts);
 
 extern const struct ci_rx_path_info idpf_rx_path_infos[IDPF_RX_MAX];
+extern const struct ci_tx_path_info idpf_tx_path_infos[IDPF_TX_MAX];
 
 #endif /* _IDPF_COMMON_RXTX_H_ */
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 4796d8b862..3e2bccd279 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -813,97 +813,51 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
 #ifdef RTE_ARCH_X86
-	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
 #ifdef CC_AVX512_SUPPORT
 	struct ci_tx_queue *txq;
 	int i;
 #endif /* CC_AVX512_SUPPORT */
-
-	if (idpf_tx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		vport->tx_vec_allowed = true;
-		tx_simd_width = idpf_get_max_simd_bitwidth();
-#ifdef CC_AVX512_SUPPORT
-		if (tx_simd_width == RTE_VECT_SIMD_512) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
-				txq = dev->data->tx_queues[i];
-				idpf_qc_tx_vec_avx512_setup(txq);
-			}
-		}
-#else
-		PMD_DRV_LOG(NOTICE,
-			    "AVX512 is not supported in build env");
-#endif /* CC_AVX512_SUPPORT */
-	} else {
-		vport->tx_vec_allowed = false;
-	}
 #endif /* RTE_ARCH_X86 */
+	struct idpf_adapter *ad = vport->adapter;
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+	};
+
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
+#ifdef RTE_ARCH_X86
+	if (idpf_tx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH)
+		req_features.simd_width = idpf_get_max_simd_bitwidth();
+#endif
+
+	ad->tx_func_type = ci_tx_path_select(&req_features,
+					&idpf_tx_path_infos[0],
+					IDPF_TX_MAX,
+					IDPF_TX_DEFAULT);
+
+out:
+	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
+			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 #ifdef RTE_ARCH_X86
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		if (vport->tx_vec_allowed) {
-#ifdef CC_AVX512_SUPPORT
-			if (tx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Split AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx512;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	} else {
-		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
-			if (tx_simd_width == RTE_VECT_SIMD_512) {
-				for (i = 0; i < dev->data->nb_tx_queues; i++) {
-					txq = dev->data->tx_queues[i];
-					if (txq == NULL)
-						continue;
-					idpf_qc_tx_vec_avx512_setup(txq);
-				}
-				PMD_DRV_LOG(NOTICE,
-					    "Using Single AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx512;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
-			if (tx_simd_width == RTE_VECT_SIMD_256) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Single AVX2 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
+	if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256 &&
+			idpf_tx_path_infos[ad->tx_func_type].features.single_queue) {
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			txq = dev->data->tx_queues[i];
+			if (txq == NULL)
+				continue;
+			if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width ==
+					RTE_VECT_SIMD_512)
+				idpf_qc_tx_vec_avx512_setup(txq);
 		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Single Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	}
-#else
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	} else {
-		PMD_DRV_LOG(NOTICE,
-			    "Using Single Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
 	}
+#endif /* CC_AVX512_SUPPORT */
 #endif /* RTE_ARCH_X86 */
 }
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index ecdf2f0e23..425f0792a1 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -23,13 +23,6 @@
 		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
-#define IDPF_TX_NO_VECTOR_FLAGS (		\
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |	\
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
 
 static inline int
 idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
@@ -74,9 +67,6 @@ idpf_tx_vec_queue_default(struct ci_tx_queue *txq)
 	    (txq->tx_rs_thresh & 3) != 0)
 		return IDPF_SCALAR_PATH;
 
-	if ((txq->offloads & IDPF_TX_NO_VECTOR_FLAGS) != 0)
-		return IDPF_SCALAR_PATH;
-
 	return IDPF_VECTOR_PATH;
 }
 
-- 
2.43.0

