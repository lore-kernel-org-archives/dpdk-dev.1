Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18623D5CCB7
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 10:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E469740649;
	Tue, 16 Dec 2025 11:35:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B2B90402ED
 for <dev@dpdk.org>; Tue, 16 Dec 2025 11:35:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765881315; x=1797417315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qCyALJNfJqzzIkOeg8tkjzCg1fie3kgG5pw8aaRfUW4=;
 b=IMSExwIu0X3vLxOK1XNdhUGUrCMC4XT29jYvgKeb29QugV/BbnFO5fV/
 WxisuA2uPIB5zGl4C3hIl3ijNiu/AXFbjTqsn/+47KfGmXq3TDZnmABqC
 O5yozC0F1mbud4U4Ftbm7DM3ZIh/KLc9Br0bDOl7VdtEsjER7VFT9lFgr
 pqJ8DdWBHcwGd2TGsNJ7ZpU9VT+wORidWpm18FUPYGz6UrTK5ASyPWItp
 0u6KiInqYHZDOCjm/xuJdaTtdo2iUwYdMt/3bq5Bu8VtHZgYzY2R/cmyH
 VV/wny58xGWaCxtkUPHj8FCXa3gONbAKFS7M+tyYvHBdVdgqxF5H11Pw9 A==;
X-CSE-ConnectionGUID: z6IDJb2tRBKTQvzwJ0o9Xg==
X-CSE-MsgGUID: 4tiaqwulRcWvza25Sx3l0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79250836"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="79250836"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 02:35:14 -0800
X-CSE-ConnectionGUID: gRvcfMdwRIyCMZK9DpTgig==
X-CSE-MsgGUID: FfhL3ecYSxWtfzRThhafVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197259848"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 16 Dec 2025 02:35:13 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 3/3] net/intel: bring common Rx path selection in line with
 Tx
Date: Tue, 16 Dec 2025 10:35:04 +0000
Message-ID: <20251216103504.2624535-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216103504.2624535-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
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

The common Tx path selection infrastructure which was based off the Rx
infrastructure has recently been added. In the review process some
improvements were suggested for the Tx infrastructure which also apply
to the existing Rx infrastructure. This commit implements these
improvements for the Rx side.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h             |  38 ++++----
 drivers/net/intel/cpfl/cpfl_rxtx.c        |   8 +-
 drivers/net/intel/i40e/i40e_rxtx.c        |  40 ++++----
 drivers/net/intel/iavf/iavf_rxtx.c        | 106 +++++++++++-----------
 drivers/net/intel/ice/ice_rxtx.c          |  40 ++++----
 drivers/net/intel/idpf/idpf_common_rxtx.c |  10 +-
 drivers/net/intel/idpf/idpf_rxtx.c        |   8 +-
 7 files changed, 123 insertions(+), 127 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 83259f2737..54dc3d7464 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -126,7 +126,9 @@ struct ci_rx_queue {
 	};
 };
 
-struct ci_rx_path_features_extra {
+struct ci_rx_path_features {
+	uint32_t rx_offloads;
+	enum rte_vect_max_simd simd_width;
 	bool scattered;
 	bool flex_desc;
 	bool bulk_alloc;
@@ -134,12 +136,6 @@ struct ci_rx_path_features_extra {
 	bool single_queue;
 };
 
-struct ci_rx_path_features {
-	uint32_t rx_offloads;
-	enum rte_vect_max_simd simd_width;
-	struct ci_rx_path_features_extra extra;
-};
-
 struct ci_rx_path_info {
 	eth_rx_burst_t pkt_burst;
 	const char *info;
@@ -255,15 +251,15 @@ ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh)
  *   or default_path if no suitable path is found
  */
 static inline int
-ci_rx_path_select(struct ci_rx_path_features req_features,
+ci_rx_path_select(const struct ci_rx_path_features *req_features,
 			const struct ci_rx_path_info *infos,
-			int num_paths,
+			size_t num_paths,
 			int default_path)
 {
-	int i, idx = default_path;
+	int idx = default_path;
 	const struct ci_rx_path_features *chosen_path_features = NULL;
 
-	for (i = 0; i < num_paths; i++) {
+	for (unsigned int i = 0; i < num_paths; i++) {
 		const struct ci_rx_path_features *path_features = &infos[i].features;
 
 		/* Do not select a path with a NULL pkt_burst function. */
@@ -271,32 +267,32 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 			continue;
 
 		/* Do not select a disabled rx path. */
-		if (path_features->extra.disabled)
+		if (path_features->disabled)
 			continue;
 
 		/* If requested, ensure the path uses the flexible descriptor. */
-		if (path_features->extra.flex_desc != req_features.extra.flex_desc)
+		if (path_features->flex_desc != req_features->flex_desc)
 			continue;
 
 		/* If requested, ensure the path supports single queue RX. */
-		if (path_features->extra.single_queue != req_features.extra.single_queue)
+		if (path_features->single_queue != req_features->single_queue)
 			continue;
 
 		/* If requested, ensure the path supports scattered RX. */
-		if (path_features->extra.scattered != req_features.extra.scattered)
+		if (path_features->scattered != req_features->scattered)
 			continue;
 
 		/* Do not use a bulk alloc path if not requested. */
-		if (path_features->extra.bulk_alloc && !req_features.extra.bulk_alloc)
+		if (path_features->bulk_alloc && !req_features->bulk_alloc)
 			continue;
 
 		/* Ensure the path supports the requested RX offloads. */
-		if ((path_features->rx_offloads & req_features.rx_offloads) !=
-				req_features.rx_offloads)
+		if ((path_features->rx_offloads & req_features->rx_offloads) !=
+				req_features->rx_offloads)
 			continue;
 
 		/* Ensure the path's SIMD width is compatible with the requested width. */
-		if (path_features->simd_width > req_features.simd_width)
+		if (path_features->simd_width > req_features->simd_width)
 			continue;
 
 		/* Do not select the path if it is less suitable than the chosen path. */
@@ -314,8 +310,8 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 			/* Do not select paths without bulk alloc support if requested and the
 			 * chosen path already meets this requirement.
 			 */
-			if (!path_features->extra.bulk_alloc && req_features.extra.bulk_alloc &&
-					chosen_path_features->extra.bulk_alloc)
+			if (!path_features->bulk_alloc && req_features->bulk_alloc &&
+					chosen_path_features->bulk_alloc)
 				continue;
 		}
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index b6bf4094f1..2e4cf3b875 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1423,10 +1423,10 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 		req_features.simd_width = cpfl_get_max_simd_bitwidth();
 #endif /* RTE_ARCH_X86 */
 
-	req_features.extra.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
-	req_features.extra.scattered = dev->data->scattered_rx;
+	req_features.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
+	req_features.scattered = dev->data->scattered_rx;
 
-	ad->rx_func_type = ci_rx_path_select(req_features,
+	ad->rx_func_type = ci_rx_path_select(&req_features,
 						&idpf_rx_path_infos[0],
 						IDPF_RX_MAX,
 						IDPF_RX_DEFAULT);
@@ -1434,7 +1434,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 	if (idpf_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_256) {
 		/* Vector function selected. Prepare the rxq accordingly. */
-		if (idpf_rx_path_infos[ad->rx_func_type].features.extra.single_queue) {
+		if (idpf_rx_path_infos[ad->rx_func_type].features.single_queue) {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
 				cpfl_rxq = dev->data->rx_queues[i];
 				(void)idpf_qc_singleq_rx_vec_setup(&cpfl_rxq->base);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index a7d80e2bc0..2db58c6b24 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3373,7 +3373,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.info = "Scalar Scattered",
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
-			.extra.scattered = true
+			.scattered = true
 		}
 	},
 	[I40E_RX_BULK_ALLOC] = {
@@ -3381,7 +3381,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.info = "Scalar Bulk Alloc",
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 #ifdef RTE_ARCH_X86
@@ -3391,7 +3391,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_SSE_SCATTERED] = {
@@ -3400,8 +3400,8 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_AVX2] = {
@@ -3410,7 +3410,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_AVX2_SCATTERED] = {
@@ -3419,8 +3419,8 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #ifdef CC_AVX512_SUPPORT
@@ -3430,7 +3430,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_AVX512_SCATTERED] = {
@@ -3439,8 +3439,8 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #endif
@@ -3451,7 +3451,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_NEON_SCATTERED] = {
@@ -3460,8 +3460,8 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #elif defined(RTE_ARCH_PPC_64)
@@ -3471,7 +3471,7 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[I40E_RX_ALTIVEC_SCATTERED] = {
@@ -3480,8 +3480,8 @@ static const struct ci_rx_path_info i40e_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #endif
@@ -3517,11 +3517,11 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 
 	req_features.simd_width = rx_simd_width;
 	if (dev->data->scattered_rx)
-		req_features.extra.scattered = true;
+		req_features.scattered = true;
 	if (ad->rx_bulk_alloc_allowed)
-		req_features.extra.bulk_alloc = true;
+		req_features.bulk_alloc = true;
 
-	ad->rx_func_type = ci_rx_path_select(req_features,
+	ad->rx_func_type = ci_rx_path_select(&req_features,
 						&i40e_rx_path_infos[0],
 						RTE_DIM(i40e_rx_path_infos),
 						I40E_RX_DEFAULT);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 9ba8ff0979..ee53e6e802 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3693,7 +3693,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.pkt_burst = iavf_recv_pkts_no_poll,
 		.info = "Disabled",
 		.features = {
-			.extra.disabled = true
+			.disabled = true
 		}
 	},
 	[IAVF_RX_DEFAULT] = {
@@ -3708,7 +3708,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.info = "Scalar Scattered",
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			.extra.scattered = true
+			.scattered = true
 		}
 	},
 	[IAVF_RX_FLEX_RXD] = {
@@ -3716,7 +3716,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.info = "Scalar Flex",
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS,
-			.extra.flex_desc = true
+			.flex_desc = true
 		}
 	},
 	[IAVF_RX_SCATTERED_FLEX_RXD] = {
@@ -3724,8 +3724,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.info = "Scalar Scattered Flex",
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			.extra.scattered = true,
-			.extra.flex_desc = true
+			.scattered = true,
+			.flex_desc = true
 		}
 	},
 	[IAVF_RX_BULK_ALLOC] = {
@@ -3733,7 +3733,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.info = "Scalar Bulk Alloc",
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {
@@ -3741,8 +3741,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.info = "Scalar Bulk Alloc Flex",
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 #ifdef RTE_ARCH_X86
@@ -3752,7 +3752,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_SSE_SCATTERED] = {
@@ -3761,8 +3761,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_SSE_FLEX_RXD] = {
@@ -3771,8 +3771,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_SSE_SCATTERED_FLEX_RXD] = {
@@ -3782,9 +3782,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
 				       RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2] = {
@@ -3793,7 +3793,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_SCATTERED] = {
@@ -3802,8 +3802,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_OFFLOAD] = {
@@ -3812,7 +3812,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_SCATTERED_OFFLOAD] = {
@@ -3821,8 +3821,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_FLEX_RXD] = {
@@ -3831,8 +3831,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD] = {
@@ -3841,9 +3841,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] = {
@@ -3852,8 +3852,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] = {
@@ -3863,9 +3863,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
 				       RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 #ifdef CC_AVX512_SUPPORT
@@ -3875,7 +3875,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_SCATTERED] = {
@@ -3884,8 +3884,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_OFFLOAD] = {
@@ -3894,7 +3894,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_SCATTERED_OFFLOAD] = {
@@ -3903,8 +3903,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_FLEX_RXD] = {
@@ -3913,8 +3913,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD] = {
@@ -3923,9 +3923,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_FLEX_RXD_OFFLOAD] = {
@@ -3934,8 +3934,8 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD] = {
@@ -3945,9 +3945,9 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
 				       RTE_ETH_RX_OFFLOAD_SCATTER,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.flex_desc = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
 		}
 	},
 #endif
@@ -3958,7 +3958,7 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 #endif
@@ -4233,11 +4233,11 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	}
 
 	if (use_flex)
-		req_features.extra.flex_desc = true;
+		req_features.flex_desc = true;
 	if (dev->data->scattered_rx)
-		req_features.extra.scattered = true;
+		req_features.scattered = true;
 	if (adapter->rx_bulk_alloc_allowed) {
-		req_features.extra.bulk_alloc = true;
+		req_features.bulk_alloc = true;
 		default_path = IAVF_RX_BULK_ALLOC;
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
 		if (iavf_rx_vec_dev_check(dev) != -1)
@@ -4245,7 +4245,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 #endif
 	}
 
-	adapter->rx_func_type = ci_rx_path_select(req_features,
+	adapter->rx_func_type = ci_rx_path_select(&req_features,
 						&iavf_rx_path_infos[0],
 						RTE_DIM(iavf_rx_path_infos),
 						default_path);
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 3fdb9fbf6e..f5d484c1e6 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3698,7 +3698,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.info = "Scalar Scattered",
 		.features = {
 			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
-			.extra.scattered = true
+			.scattered = true
 		}
 	},
 	[ICE_RX_BULK_ALLOC] = {
@@ -3706,7 +3706,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.info = "Scalar Bulk Alloc",
 		.features = {
 			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 #ifdef RTE_ARCH_X86
@@ -3716,7 +3716,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_SSE_SCATTERED] = {
@@ -3725,8 +3725,8 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX2] = {
@@ -3735,7 +3735,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX2_SCATTERED] = {
@@ -3744,8 +3744,8 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX2_OFFLOAD] = {
@@ -3754,7 +3754,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
@@ -3763,8 +3763,8 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #ifdef CC_AVX512_SUPPORT
@@ -3774,7 +3774,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX512_SCATTERED] = {
@@ -3783,8 +3783,8 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX512_OFFLOAD] = {
@@ -3793,7 +3793,7 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.bulk_alloc = true
+			.bulk_alloc = true
 		}
 	},
 	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
@@ -3802,8 +3802,8 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.scattered = true,
-			.extra.bulk_alloc = true
+			.scattered = true,
+			.bulk_alloc = true
 		}
 	},
 #endif
@@ -3839,11 +3839,11 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 
 	req_features.simd_width = rx_simd_width;
 	if (dev->data->scattered_rx)
-		req_features.extra.scattered = true;
+		req_features.scattered = true;
 	if (ad->rx_bulk_alloc_allowed)
-		req_features.extra.bulk_alloc = true;
+		req_features.bulk_alloc = true;
 
-	ad->rx_func_type = ci_rx_path_select(req_features,
+	ad->rx_func_type = ci_rx_path_select(&req_features,
 						&ice_rx_path_infos[0],
 						RTE_DIM(ice_rx_path_infos),
 						ICE_RX_DEFAULT);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index cfeab8a1e4..797ee515dd 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1667,15 +1667,15 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IDPF_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_DISABLED,
-			.extra.single_queue = true}},
+			.single_queue = true}},
 	[IDPF_RX_SINGLEQ_SCATTERED] = {
 		.pkt_burst = idpf_dp_singleq_recv_scatter_pkts,
 		.info = "Single Scalar Scattered",
 		.features = {
 			.rx_offloads = IDPF_RX_SCALAR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_DISABLED,
-			.extra.scattered = true,
-			.extra.single_queue = true}},
+			.scattered = true,
+			.single_queue = true}},
 #ifdef RTE_ARCH_X86
 	[IDPF_RX_SINGLEQ_AVX2] = {
 		.pkt_burst = idpf_dp_singleq_recv_pkts_avx2,
@@ -1683,7 +1683,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_256,
-			.extra.single_queue = true}},
+			.single_queue = true}},
 #ifdef CC_AVX512_SUPPORT
 	[IDPF_RX_AVX512] = {
 		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
@@ -1697,7 +1697,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512,
-			.extra.single_queue = true}},
+			.single_queue = true}},
 #endif /* CC_AVX512_SUPPORT */
 #endif /* RTE_ARCH_X86 */
 };
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 3e2bccd279..47f8347b41 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -776,10 +776,10 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 		req_features.simd_width = idpf_get_max_simd_bitwidth();
 #endif /* RTE_ARCH_X86 */
 
-	req_features.extra.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
-	req_features.extra.scattered = dev->data->scattered_rx;
+	req_features.single_queue = (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE);
+	req_features.scattered = dev->data->scattered_rx;
 
-	ad->rx_func_type = ci_rx_path_select(req_features,
+	ad->rx_func_type = ci_rx_path_select(&req_features,
 						&idpf_rx_path_infos[0],
 						IDPF_RX_MAX,
 						IDPF_RX_DEFAULT);
@@ -787,7 +787,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 #ifdef RTE_ARCH_X86
 	if (idpf_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_256) {
 		/* Vector function selected. Prepare the rxq accordingly. */
-		if (idpf_rx_path_infos[ad->rx_func_type].features.extra.single_queue) {
+		if (idpf_rx_path_infos[ad->rx_func_type].features.single_queue) {
 			for (i = 0; i < dev->data->nb_rx_queues; i++) {
 				rxq = dev->data->rx_queues[i];
 				(void)idpf_qc_singleq_rx_vec_setup(rxq);
-- 
2.43.0

