Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF6C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20FBD42E72;
	Tue, 15 Sep 2026 15:37:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B84FB42E96
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479448; x=1821015448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R1CSNygQYTmXpWw1Uz0+PqZT7udBkSlhNoEYoVWltY8=;
 b=gkb97+JHStXrVSN1OtWXe/3OcCUD/n1R2bONITqLr1KxExZZEGcGBXo+
 ZAnyc9wayiGLJ5qDpVGZfaZm7L6E08NGbEwpS5ViEV0pUypmZauhNBrDZ
 uFmays80jrsCpcXlhVf0wE5GbnY54Lb87TAlxJaSKw6zJbZZNtElv3ub4
 uHHDzag4Hp2HC56+vDIkBWj1r9r375Y/DbiGk/XXMJRnw/Pbjnzb70lOH
 CA39M5o1/Rb80D1B2BKQlPDNXElQWoraYRSel1+9Z9x+XV3QUY/Dd6pDE
 2ehHUY2f480ZY1M3ooO7sdmOCNMAdC/MB+vnV/VeJNcNz/JY+ZY+hKm7T g==;
X-CSE-ConnectionGUID: RlAxL7mBRUGGF8j8TtlzpQ==
X-CSE-MsgGUID: f4X6yv7sSxm+6CAhY0fLIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972537"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972537"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:27 -0700
X-CSE-ConnectionGUID: BHPpuKByRGq/bIbpCf19zA==
X-CSE-MsgGUID: Sc9SHGn7QIyxWT8TdVoclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800769"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH v2 13/15] net/intel: improve Tx path selection logic
Date: Tue, 15 Sep 2026 14:36:50 +0100
Message-ID: <20260915133654.278780-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915133654.278780-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
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

Rework the relevant priority of context descriptor vs SIMD width when
selecting a Tx path so that presence of context descriptors is only
considered when all else is equal.

Normally, path select takes place without having to worry about context
descriptors, since offloads requiring context descriptors are specified
using the offloads bitmap for each Tx path. However, in some cases, the
need to use a context descriptor is not encodable via this offload path,
e.g. VLAN offload for iavf can sometimes use the data descriptor and
sometimes the context depending on what PF specifies at runtime. To
account for those cases, we separate out the use of contexts from the
path features, but instead note it as part of the path information, and
add an additional parameter to the Tx path selection for drivers to
mandate a context descriptor be present. Otherwise, ctx is largely
ignored in path selection, except as a last-resort tie-breaker between
two paths.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h      | 41 +++++++++++++++++---------
 drivers/net/intel/cpfl/cpfl_rxtx.c |  3 +-
 drivers/net/intel/i40e/i40e_rxtx.c |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c | 46 ++++++++++++++++--------------
 drivers/net/intel/ice/ice_rxtx.c   |  3 +-
 drivers/net/intel/idpf/idpf_rxtx.c |  3 +-
 6 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 630df8cb19..0f36989b32 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -249,7 +249,6 @@ struct ci_tx_path_features {
 	uint32_t tx_offloads;
 	enum rte_vect_max_simd simd_width;
 	bool simple_tx;
-	bool ctx_desc;
 	bool disabled;
 	bool single_queue;
 };
@@ -259,6 +258,7 @@ struct ci_tx_path_info {
 	const char *info;
 	struct ci_tx_path_features features;
 	eth_tx_prep_t pkt_prep;
+	bool supports_ctx;
 };
 
 static __rte_always_inline void
@@ -411,6 +411,11 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
  *   Number of available paths in the infos array
  * @param default_path
  *   Index of the default path to use if no suitable path is found
+ * @param force_ctx
+ *   If true, only paths that support context descriptors may be selected.
+ *   Use this for offloads that require a context descriptor but cannot be
+ *   discovered purely from req_features->tx_offloads (e.g. a driver-specific
+ *   devarg, or a runtime/hardware-negotiated tag placement).
  *
  * @return
  *   The packet burst function index that best matches the requested features,
@@ -420,10 +425,12 @@ static inline int
 ci_tx_path_select(const struct ci_tx_path_features *req_features,
 			const struct ci_tx_path_info *infos,
 			size_t num_paths,
-			int default_path)
+			int default_path,
+			bool force_ctx)
 {
 	int idx = default_path;
 	const struct ci_tx_path_features *chosen_path_features = NULL;
+	bool chosen_supports_ctx = false;
 
 	for (unsigned int i = 0; i < num_paths; i++) {
 		const struct ci_tx_path_features *path_features = &infos[i].features;
@@ -440,8 +447,8 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 		if (path_features->simple_tx && !req_features->simple_tx)
 			continue;
 
-		/* If a context descriptor is requested, ensure the path supports it. */
-		if (!path_features->ctx_desc && req_features->ctx_desc)
+		/* If a context descriptor is required, ensure the path supports it. */
+		if (!infos[i].supports_ctx && force_ctx)
 			continue;
 
 		/* If requested, ensure the path supports single queue TX. */
@@ -462,22 +469,28 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 			/* Do not select paths with lower SIMD width than the chosen path. */
 			if (path_features->simd_width < chosen_path_features->simd_width)
 				continue;
-			/* Do not select paths with more offloads enabled than the chosen path if
-			 * the SIMD widths are the same.
+			/* The following tie-breaks only matter when SIMD widths are tied;
+			 * a strictly wider path is always preferred regardless of offload
+			 * count or ctx-descriptor use.
 			 */
-			if (path_features->simd_width == chosen_path_features->simd_width &&
-					rte_popcount32(path_features->tx_offloads) >
-					rte_popcount32(chosen_path_features->tx_offloads))
-				continue;
-
-			/* Don't use a context descriptor unless necessary */
-			if (path_features->ctx_desc && !chosen_path_features->ctx_desc)
-				continue;
+			if (path_features->simd_width == chosen_path_features->simd_width) {
+				/* Do not select paths with more offloads enabled than the
+				 * chosen path.
+				 */
+				if (rte_popcount32(path_features->tx_offloads) >
+						rte_popcount32(chosen_path_features->tx_offloads))
+					continue;
+
+				/* Don't use a context descriptor unless necessary */
+				if (infos[i].supports_ctx && !chosen_supports_ctx)
+					continue;
+			}
 		}
 
 		/* Finally, select the path since it has met all the requirements. */
 		idx = i;
 		chosen_path_features = &infos[idx].features;
+		chosen_supports_ctx = infos[idx].supports_ctx;
 	}
 
 	return idx;
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 2f1641ea76..aba3a5e916 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1542,7 +1542,8 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	ad->tx_func_type = ci_tx_path_select(&req_features,
 					&idpf_tx_path_infos[0],
 					IDPF_TX_MAX,
-					IDPF_TX_DEFAULT);
+					IDPF_TX_DEFAULT,
+					false);
 
 	/* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e2fffdb70a..f289d26790 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3120,7 +3120,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 	}
 
 	ad->tx_func_type = ci_tx_path_select(&req_features, &i40e_tx_path_infos[0],
-						RTE_DIM(i40e_tx_path_infos), I40E_TX_DEFAULT);
+			RTE_DIM(i40e_tx_path_infos), I40E_TX_DEFAULT, false);
 
 out:
 	dev->tx_pkt_burst = mbuf_check ? i40e_xmit_pkts_check :
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 849fc33dac..3be8b00bbd 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3611,9 +3611,9 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.pkt_burst = iavf_xmit_pkts,
 		.info = "Scalar",
 		.features = {
-			.tx_offloads = IAVF_TX_SCALAR_OFFLOADS,
-			.ctx_desc = true
-		}
+			.tx_offloads = IAVF_TX_SCALAR_OFFLOADS
+		},
+		.supports_ctx = true
 	},
 #ifdef RTE_ARCH_X86
 	[IAVF_TX_AVX2] = {
@@ -3637,18 +3637,18 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.info = "Vector AVX2 Ctx",
 		.features = {
 			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_256,
-			.ctx_desc = true
-		}
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.supports_ctx = true
 	},
 	[IAVF_TX_AVX2_CTX_OFFLOAD] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx2_ctx_offload,
 		.info = "Vector AVX2 Ctx Offload",
 		.features = {
 			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_256,
-			.ctx_desc = true
-		}
+			.simd_width = RTE_VECT_SIMD_256
+		},
+		.supports_ctx = true
 	},
 #ifdef CC_AVX512_SUPPORT
 	[IAVF_TX_AVX512] = {
@@ -3672,18 +3672,18 @@ static const struct ci_tx_path_info iavf_tx_path_infos[] = {
 		.info = "Vector AVX512 Ctx",
 		.features = {
 			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_512,
-			.ctx_desc = true
-		}
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.supports_ctx = true
 	},
 	[IAVF_TX_AVX512_CTX_OFFLOAD] = {
 		.pkt_burst = iavf_xmit_pkts_vec_avx512_ctx_offload,
 		.info = "Vector AVX512 Ctx Offload",
 		.features = {
 			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
-			.simd_width = RTE_VECT_SIMD_512,
-			.ctx_desc = true
-		}
+			.simd_width = RTE_VECT_SIMD_512
+		},
+		.supports_ctx = true
 	},
 #endif
 #elif defined(RTE_ARCH_ARM64)
@@ -3918,12 +3918,13 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	struct ci_tx_queue *txq;
 	int i;
-	const struct ci_tx_path_features *selected_features;
+	const struct ci_tx_path_info *selected_info;
 #endif
 	struct ci_tx_path_features req_features = {
 		.tx_offloads = dev->data->dev_conf.txmode.offloads,
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
+	bool force_ctx = false;
 
 	/* If the device has started the function has already been selected. */
 	if (dev->data->dev_started)
@@ -3934,7 +3935,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
 	if (adapter->devargs.enable_lldp)
-		req_features.ctx_desc = true;
+		force_ctx = true;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
@@ -3942,24 +3943,25 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 			continue;
 		if (txq->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT &&
 				txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
-			req_features.ctx_desc = true;
+			force_ctx = true;
 	}
 #endif
 
 	adapter->tx_func_type = ci_tx_path_select(&req_features,
 						&iavf_tx_path_infos[0],
 						RTE_DIM(iavf_tx_path_infos),
-						IAVF_TX_DEFAULT);
+						IAVF_TX_DEFAULT,
+						force_ctx);
 
 out:
 #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
-	selected_features = &iavf_tx_path_infos[adapter->tx_func_type].features;
+	selected_info = &iavf_tx_path_infos[adapter->tx_func_type];
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		if (!txq)
 			continue;
-		txq->use_ctx = selected_features->ctx_desc;
-		txq->use_vec_entry = selected_features->simd_width >= RTE_VECT_SIMD_128;
+		txq->use_ctx = selected_info->supports_ctx;
+		txq->use_vec_entry = selected_info->features.simd_width >= RTE_VECT_SIMD_128;
 	}
 #endif
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 52d6984214..06920745ed 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3784,7 +3784,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	ad->tx_func_type = ci_tx_path_select(&req_features,
 						&ice_tx_path_infos[0],
 						RTE_DIM(ice_tx_path_infos),
-						ICE_TX_DEFAULT);
+						ICE_TX_DEFAULT,
+						false);
 
 out:
 #if defined(RTE_ARCH_X86)
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index bc3f9a0798..077a92a8a9 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -887,7 +887,8 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	ad->tx_func_type = ci_tx_path_select(&req_features,
 					&idpf_tx_path_infos[0],
 					IDPF_TX_MAX,
-					IDPF_TX_DEFAULT);
+					IDPF_TX_DEFAULT,
+					false);
 
 	/* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-- 
2.53.0

