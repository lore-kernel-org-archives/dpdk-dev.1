Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC05D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E75340A87;
	Tue,  9 Dec 2025 12:27:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8CEBB40B92
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279636; x=1796815636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k6TXs5inzI1i0km/RqOimM9CDySSVnm5jMcoCk+NFv4=;
 b=L3RuSBFK0aTUxeiYyIhuJ4wGqdSwTLkLk1viyiPMG+gjAJP6u+spjUTL
 0X2PxYgxxa+kLA073kmj/baYC8pVnRpRYdHHP6oUWsbqfoMr90RDajp4g
 4wJl65qTn1iU03iEsN3wyhYnEKyPUut8PzE7hDoMKpQedtJ9oVhxRuL02
 I2i/9e0vqvE9ZhDUD+xtOutSjHEttog86KX0hm4Xu5l0FfVAxhBBq25rw
 WItYW1XT/W7wW+Ucz6bUIWN89BrDE+St/mqaFGKPA2eMWkGPNufhzlX+c
 VV0LLjs+hEYMKrrIcdWiQClJLLTr4hvctbs/+G6qP2naVPhkHrywUQZ3E g==;
X-CSE-ConnectionGUID: 7Bwd8P4lSa2Qw/YqH5hggw==
X-CSE-MsgGUID: F9jucGizQnCXvHZmziZ4uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117046"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:15 -0800
X-CSE-ConnectionGUID: 3eA0q0sCQdWZU8pxfgxDbQ==
X-CSE-MsgGUID: hxlpYjKzQZyib3Erk2/XKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270232"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:14 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 09/13] net/cpfl: use common Tx path selection infrastructure
Date: Tue,  9 Dec 2025 11:26:48 +0000
Message-ID: <20251209112652.963981-10-ciara.loftus@intel.com>
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

Replace the existing complicated logic with the use of the common
function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 114 +++++-------------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  10 --
 2 files changed, 32 insertions(+), 92 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 453ec975d5..2bf66159b5 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1462,97 +1462,47 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 #ifdef RTE_ARCH_X86
-	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
 #ifdef CC_AVX512_SUPPORT
-	struct cpfl_tx_queue *cpfl_txq;
+	struct ci_tx_queue *txq;
 	int i;
 #endif /* CC_AVX512_SUPPORT */
-
-	if (cpfl_tx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		vport->tx_vec_allowed = true;
-		tx_simd_width = cpfl_get_max_simd_bitwidth();
-#ifdef CC_AVX512_SUPPORT
-		if (tx_simd_width == RTE_VECT_SIMD_512) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
-				cpfl_txq = dev->data->tx_queues[i];
-				idpf_qc_tx_vec_avx512_setup(&cpfl_txq->base);
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
+		.extra.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+	};
 
 #ifdef RTE_ARCH_X86
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		if (vport->tx_vec_allowed) {
+	if (cpfl_tx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH)
+		req_features.simd_width = cpfl_get_max_simd_bitwidth();
+#endif
+
+	ad->tx_func_type = ci_tx_path_select(req_features,
+					&idpf_tx_path_infos[0],
+					IDPF_TX_MAX,
+					IDPF_TX_DEFAULT);
+
+	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
+			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
+
+#ifdef RTE_ARCH_X86
+	if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256 &&
+			idpf_tx_path_infos[ad->tx_func_type].features.extra.single_queue) {
 #ifdef CC_AVX512_SUPPORT
-			if (tx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Split AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx512;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			txq = dev->data->tx_queues[i];
+			if (txq == NULL)
+				continue;
+			if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width ==
+					RTE_VECT_SIMD_512)
+				idpf_qc_tx_vec_avx512_setup(txq);
 		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	} else {
-		if (vport->tx_vec_allowed) {
-#ifdef CC_AVX512_SUPPORT
-			if (tx_simd_width == RTE_VECT_SIMD_512) {
-				for (i = 0; i < dev->data->nb_tx_queues; i++) {
-					cpfl_txq = dev->data->tx_queues[i];
-					if (cpfl_txq == NULL)
-						continue;
-					idpf_qc_tx_vec_avx512_setup(&cpfl_txq->base);
-				}
-				PMD_DRV_LOG(NOTICE,
-					    "Using Single AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx512;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
 #endif /* CC_AVX512_SUPPORT */
-			if (tx_simd_width == RTE_VECT_SIMD_256) {
-				PMD_DRV_LOG(NOTICE,
-						"Using Single AVX2 Vector Tx (port %d).",
-						dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
-		}
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
+		vport->tx_vec_allowed = true;
 	}
 #endif /* RTE_ARCH_X86 */
 }
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index 525ca9a6e0..f0daa1eb30 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -23,13 +23,6 @@
 		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP)
-#define CPFL_TX_NO_VECTOR_FLAGS (		\
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |	\
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |	\
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |	\
-		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
 
 static inline int
 cpfl_rx_vec_queue_default(struct idpf_rx_queue *rxq)
@@ -62,9 +55,6 @@ cpfl_tx_vec_queue_default(struct ci_tx_queue *txq)
 	    (txq->tx_rs_thresh & 3) != 0)
 		return CPFL_SCALAR_PATH;
 
-	if ((txq->offloads & CPFL_TX_NO_VECTOR_FLAGS) != 0)
-		return CPFL_SCALAR_PATH;
-
 	return CPFL_VECTOR_PATH;
 }
 
-- 
2.43.0

