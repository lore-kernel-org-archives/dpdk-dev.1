Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927CBCAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 14:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 958F74065E;
	Thu, 11 Sep 2025 16:32:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB8240285
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757601126; x=1789137126;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HTZQ56fbTBcULJdxQEbKUUdXuNOLg+ygB2z5iopTqvg=;
 b=GUDWDj48Tigqs55K6K+nNORGLMIpGqBrF3F9p+CTMmo7cEhd8KSwo75x
 Y7ddZdLdAIbFdInm+NruWloag+O9X2bpSqjWaxTKKUfMcfq+DJGWg9wxN
 C5tmdQjjCZckuNoVKgRqnqEOxNRTUSAS+NOKVwwEkL9IS+j6Jkh3+LPoE
 f3ARtosYuV2DsXIWC6U4pOfV/Bd3TVPdN+8TYtFQrm+R9gihIaw0b4PlN
 yGvcbRl7BP9YR8Nd5Nzcbl+WzquCxHwIeyLnqd9c/EvcBo4T87heQdBEi
 hZ9ckGAp22oFnbHB5+dmoyJDIOJU/1v/5pSpHnwJyqSbeeRcdHoeTjJ5e A==;
X-CSE-ConnectionGUID: TfrI/cYQSnyZNAzMnG5IRA==
X-CSE-MsgGUID: Bukm4rf8Qwqke+sWJgGmcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="62562483"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="62562483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 07:32:04 -0700
X-CSE-ConnectionGUID: zOAvN170SY6vcQmidlO6zQ==
X-CSE-MsgGUID: um3L4hOqSdaDv9oW9ZEFKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="210845015"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 11 Sep 2025 07:32:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/4] net/idpf: use the new common vector capability function
Date: Thu, 11 Sep 2025 14:31:42 +0000
Message-Id: <20250911143145.3355960-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911143145.3355960-1-ciara.loftus@intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
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
the idpf driver. An additional check is required for the AVX512DQ flag
which is not performed in the common function. Since no other drivers
require this flag, the check will remain outside of the common function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/idpf/idpf_rxtx.c            | 50 ++++++-------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h | 19 +++++++
 2 files changed, 33 insertions(+), 36 deletions(-)

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
index ff3ae56baf..50992b7989 100644
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
@@ -129,4 +132,20 @@ idpf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return IDPF_VECTOR_PATH;
 }
 
+#ifdef RTE_ARCH_X86
+static inline enum rte_vect_max_simd
+idpf_get_max_simd_bitwidth(void)
+{
+	if (rte_vect_get_max_simd_bitwidth() == 512 &&
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) == 0) {
+		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2))
+			return RTE_VECT_SIMD_256;
+		else
+			return RTE_VECT_SIMD_DISABLED;
+	}
+
+	return ci_get_x86_max_simd_bitwidth();
+}
+#endif
+
 #endif /*_IDPF_RXTX_VEC_COMMON_H_*/
-- 
2.34.1

