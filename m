Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C54CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:18:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABF874068E;
	Wed, 17 Sep 2025 11:17:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0B92340671
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758100663; x=1789636663;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CuztWXcRkZIltYzhfeEC7H+M2Spi9+O4iy6tqdVew4s=;
 b=dPgGJ94pb6JLWdEyn5YVtMFSPyAcoPdFVydydpJ8M5ebyvzhnlhYyOkx
 SvOqnQaJnSgIic74jGoNIqk9dFphfyJLbxpftHLV/tORgZqlEALHI4Ysw
 c1MHgHEwgqQSZswpRFFqS3R/AIYz6lbL9KJk31TxNx/+wbSvuC5xVE6Uh
 X3AgR2jVhPapYjGK5kb8Q6qSHjFytiQdWExWlhvk+MoCrH1lJvBs2y3m0
 sxemVTsCmEXdjIL7njKdMvm0myWjRG0nN2PEMa8amXEsx2kFMlk2WQClQ
 345ft/MO7RLWrJRweglX6sMEd3tmTLk+oDNBSN6oOg/lKuaAIBczr67// A==;
X-CSE-ConnectionGUID: eiLO6n2eT9qNLtLajR7mUA==
X-CSE-MsgGUID: 4SzUhED8SbyOko5RIaF6fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60464539"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60464539"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:17:43 -0700
X-CSE-ConnectionGUID: UfudXTQ1T9eB1WS7wK/VGg==
X-CSE-MsgGUID: Z0QoQPkVQi2zLt8nc8XRUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174760578"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 02:17:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 5/5] net/cpfl: use the common Rx path selection
 infrastructure
Date: Wed, 17 Sep 2025 09:17:31 +0000
Message-Id: <20250917091731.3632520-6-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917091731.3632520-1-ciara.loftus@intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250917091731.3632520-1-ciara.loftus@intel.com>
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
 drivers/net/intel/cpfl/cpfl_rxtx.c          | 105 ++++++--------------
 drivers/net/intel/idpf/idpf_common_device.h |   1 -
 2 files changed, 29 insertions(+), 77 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 0f5b645f89..453ec975d5 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1409,98 +1409,51 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
+	struct idpf_adapter *ad = vport->adapter;
+	struct ci_rx_path_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 #ifdef RTE_ARCH_X86
 	struct cpfl_rx_queue *cpfl_rxq;
-	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	int i;
 
 	if (cpfl_rx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		vport->rx_vec_allowed = true;
-		rx_simd_width = cpfl_get_max_simd_bitwidth();
-	} else {
-		vport->rx_vec_allowed = false;
-	}
+	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+		req_features.simd_width = cpfl_get_max_simd_bitwidth();
 #endif /* RTE_ARCH_X86 */
 
+	req_features.extra.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
+	req_features.extra.scattered = dev->data->scattered_rx;
+
+	ad->rx_func_type = ci_rx_path_select(req_features,
+						&idpf_rx_path_infos[0],
+						IDPF_RX_MAX,
+						IDPF_RX_DEFAULT);
+
 #ifdef RTE_ARCH_X86
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		if (vport->rx_vec_allowed) {
+	if (idpf_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_256) {
+		/* Vector function selected. Prepare the rxq accordingly. */
+		if (idpf_rx_path_infos[ad->rx_func_type].features.extra.single_queue) {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
 				cpfl_rxq = dev->data->rx_queues[i];
-				if (cpfl_rxq->hairpin_info.hairpin_q)
-					continue;
-				(void)idpf_qc_splitq_rx_vec_setup(&cpfl_rxq->base);
-			}
-#ifdef CC_AVX512_SUPPORT
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Split AVX512 Vector Rx (port %d).",
-					    dev->data->port_id);
-				dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts_avx512;
-				return;
+				(void)idpf_qc_singleq_rx_vec_setup(&cpfl_rxq->base);
 			}
-#endif /* CC_AVX512_SUPPORT */
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Rx (port %d).",
-			    dev->data->port_id);
-		dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts;
-	} else {
-		if (vport->rx_vec_allowed) {
+		} else {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
 				cpfl_rxq = dev->data->rx_queues[i];
-				(void)idpf_qc_singleq_rx_vec_setup(&cpfl_rxq->base);
-			}
-#ifdef CC_AVX512_SUPPORT
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Single AVX512 Vector Rx (port %d).",
-					    dev->data->port_id);
-				dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts_avx512;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
-			if (rx_simd_width == RTE_VECT_SIMD_256) {
-				PMD_DRV_LOG(NOTICE,
-						"Using Single AVX2 Vector Rx (port %d).",
-						dev->data->port_id);
-				dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts_avx2;
-				return;
+				if (cpfl_rxq->hairpin_info.hairpin_q)
+					continue;
+				(void)idpf_qc_splitq_rx_vec_setup(&cpfl_rxq->base);
 			}
 		}
-		if (dev->data->scattered_rx) {
-			PMD_DRV_LOG(NOTICE,
-				    "Using Single Scalar Scatterd Rx (port %d).",
-				    dev->data->port_id);
-			dev->rx_pkt_burst = idpf_dp_singleq_recv_scatter_pkts;
-			return;
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Single Scalar Rx (port %d).",
-			    dev->data->port_id);
-		dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts;
-	}
-#else
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Rx (port %d).",
-			    dev->data->port_id);
-		dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts;
-	} else {
-		if (dev->data->scattered_rx) {
-			PMD_DRV_LOG(NOTICE,
-				    "Using Single Scalar Scatterd Rx (port %d).",
-				    dev->data->port_id);
-			dev->rx_pkt_burst = idpf_dp_singleq_recv_scatter_pkts;
-			return;
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Single Scalar Rx (port %d).",
-			    dev->data->port_id);
-		dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts;
 	}
-#endif /* RTE_ARCH_X86 */
+#endif
+
+	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
+			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
+
 }
 
 void
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 11baa195e5..3b95d519c6 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -133,7 +133,6 @@ struct idpf_vport {
 
 	uint16_t devarg_id;
 
-	bool rx_vec_allowed;
 	bool tx_vec_allowed;
 
 	struct virtchnl2_vport_stats eth_stats_offset;
-- 
2.34.1

