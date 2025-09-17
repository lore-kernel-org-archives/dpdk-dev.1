Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE21CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E2940665;
	Wed, 17 Sep 2025 11:17:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AF5B54025A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758100660; x=1789636660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H91O4lezYeJktXwjw0StSMjTUt8PQBCsc5EZadInKDk=;
 b=Zx1S3muuBewacLNts/vW3lOQ+1K5SVDsUBJgSMIHQJfSH54PZOlvCUKj
 9giAD/WO9EsgoKbMaFM1KmbinLZcT1I/1hdeM/zjcpaft4FZrJdaqDZdm
 0ftZQ42UY+g8SCihHd/Dcriwn0SF7zsgyMHVn2uXfDXpBDzggaKh9eSZo
 Sj5fvqcr4XVoWF7s86i/h6QjkqqyEhyg0V7udZ3mEXmJsYtlXVPRx1u8+
 RGSQOy4JNu7dlOr5lEgEWm1zzdOJHHozwzZlNC0L+/+zjBtVpGoYT8R37
 QmgwtNBgxRtatz1/rJia8lJfrcE2YCLvviAbWxhPtGEHgFn1E9cag/jsD Q==;
X-CSE-ConnectionGUID: /IBdEhvRRniR5XA37X4/iA==
X-CSE-MsgGUID: hVa0vxkGRPaUmnQX4UeCMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60464526"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60464526"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:17:39 -0700
X-CSE-ConnectionGUID: s9qSOf3cQyeklR2pVF/O3Q==
X-CSE-MsgGUID: /3+RHYVdT9WJ+0UEB8NeOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174760544"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 02:17:38 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/5] net/idpf: use the new common vector capability function
Date: Wed, 17 Sep 2025 09:17:28 +0000
Message-Id: <20250917091731.3632520-3-ciara.loftus@intel.com>
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

Use the new function for determining the maximum simd bitwidth in
the idpf driver.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Removed check for AVX512DQ in the driver code as it's in the common
code now.
---
 drivers/net/intel/idpf/idpf_rxtx.c            | 50 ++++++-------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h | 11 ++++
 2 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 5510cbd30a..c9eb7f66d2 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -762,26 +762,13 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 	struct idpf_vport *vport = dev->data->dev_private;
 #ifdef RTE_ARCH_X86
 	struct idpf_rx_queue *rxq;
+	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	int i;
 
 	if (idpf_rx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->rx_vec_allowed = true;
-
-		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			vport->rx_use_avx2 = true;
-
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
-#ifdef CC_AVX512_SUPPORT
-			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1 &&
-			    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ))
-				vport->rx_use_avx512 = true;
-#else
-		PMD_DRV_LOG(NOTICE,
-			    "AVX512 is not supported in build env");
-#endif /* CC_AVX512_SUPPORT */
+		rx_simd_width = idpf_get_max_simd_bitwidth();
 	} else {
 		vport->rx_vec_allowed = false;
 	}
@@ -795,7 +782,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 				(void)idpf_qc_splitq_rx_vec_setup(rxq);
 			}
 #ifdef CC_AVX512_SUPPORT
-			if (vport->rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Split AVX512 Vector Rx (port %d).",
 					    dev->data->port_id);
@@ -815,7 +802,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 				(void)idpf_qc_singleq_rx_vec_setup(rxq);
 			}
 #ifdef CC_AVX512_SUPPORT
-			if (vport->rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Single AVX512 Vector Rx (port %d).",
 					    dev->data->port_id);
@@ -823,7 +810,7 @@ idpf_set_rx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
-			if (vport->rx_use_avx2) {
+			if (rx_simd_width == RTE_VECT_SIMD_256) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Single AVX2 Vector Rx (port %d).",
 					    dev->data->port_id);
@@ -871,6 +858,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
 #ifdef RTE_ARCH_X86
+	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
 #ifdef CC_AVX512_SUPPORT
 	struct ci_tx_queue *txq;
 	int i;
@@ -879,22 +867,12 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	if (idpf_tx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->tx_vec_allowed = true;
-
-		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			vport->tx_use_avx2 = true;
-
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
+		tx_simd_width = idpf_get_max_simd_bitwidth();
 #ifdef CC_AVX512_SUPPORT
-		{
-			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
-				vport->tx_use_avx512 = true;
-			if (vport->tx_use_avx512) {
-				for (i = 0; i < dev->data->nb_tx_queues; i++) {
-					txq = dev->data->tx_queues[i];
-					idpf_qc_tx_vec_avx512_setup(txq);
-				}
+		if (tx_simd_width == RTE_VECT_SIMD_512) {
+			for (i = 0; i < dev->data->nb_tx_queues; i++) {
+				txq = dev->data->tx_queues[i];
+				idpf_qc_tx_vec_avx512_setup(txq);
 			}
 		}
 #else
@@ -910,7 +888,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
 		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
-			if (vport->tx_use_avx512) {
+			if (tx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Split AVX512 Vector Tx (port %d).",
 					    dev->data->port_id);
@@ -928,7 +906,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 	} else {
 		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
-			if (vport->tx_use_avx512) {
+			if (tx_simd_width == RTE_VECT_SIMD_512) {
 				for (i = 0; i < dev->data->nb_tx_queues; i++) {
 					txq = dev->data->tx_queues[i];
 					if (txq == NULL)
@@ -943,7 +921,7 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
-			if (vport->tx_use_avx2) {
+			if (tx_simd_width == RTE_VECT_SIMD_256) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Single AVX2 Vector Tx (port %d).",
 					    dev->data->port_id);
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index ff3ae56baf..ecdf2f0e23 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -11,6 +11,9 @@
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
 #include "../common/rx.h"
+#ifdef RTE_ARCH_X86
+#include "../common/rx_vec_x86.h"
+#endif
 
 #define IDPF_SCALAR_PATH		0
 #define IDPF_VECTOR_PATH		1
@@ -129,4 +132,12 @@ idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return IDPF_VECTOR_PATH;
 }
 
+#ifdef RTE_ARCH_X86
+static inline enum rte_vect_max_simd
+idpf_get_max_simd_bitwidth(void)
+{
+	return ci_get_x86_max_simd_bitwidth();
+}
+#endif
+
 #endif /*_IDPF_RXTX_VEC_COMMON_H_*/
-- 
2.34.1

