Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CACAC58E
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 14:32:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 247BB40685;
	Thu, 11 Sep 2025 16:32:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id AB356402E9
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757601127; x=1789137127;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HENwCesPl4uQKlEncFNMmleV8/j5NS2uZ7GUjH+EFFE=;
 b=lwvwYJHQ+NW1+J45Am7H2619GdNwReS2XuqZOS3pL0BKdFqcsv6a7KNg
 qIgZ4omGOKydv472UOSXC2QSnksUljH/V9Y4vCfcOuqSlJVsuQNhrWvTW
 Lj+sEjAF/QWZYxcOuV+adAgOK/HVE2s1jH6Et7v5FSY/UUhuqvCEdBnJ8
 ZuuNb7JczBKMVVNMmd5CaqVgfWXWQRk2SRJyjtTLP77zopHOVFgc0XGOc
 CGgPGwrmfNqkiVN1U6vtAesMXxK1YBHbKiLOEbP/ttUQLaZe4IlICZ87W
 ar/JqEIEhM8Nca8Ki6uJtGbexOP82QK+4bievMjeuWEQbLD2AQN1HDLkK w==;
X-CSE-ConnectionGUID: knfHwLW0SPuxb+xGZt3Sfg==
X-CSE-MsgGUID: QmM/6A/KTQCe+aOSeDAoLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="62562490"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="62562490"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 07:32:06 -0700
X-CSE-ConnectionGUID: V/iuq1OLQBCUAhGBz/yQ6Q==
X-CSE-MsgGUID: 7GT5C3nzRFOynI8P8fDAHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="210845030"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 11 Sep 2025 07:32:06 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/4] net/cpfl: use the new common vector capability function
Date: Thu, 11 Sep 2025 14:31:44 +0000
Message-Id: <20250911143145.3355960-4-ciara.loftus@intel.com>
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
the cpfl driver. An additional check is added for the AVX512DQ CPU flag
as it is not present in the common function since it is not a common
requirement for all drivers. Also, remove unused elements related to AVX
capability from the idpf_vport structure, now that neither the idpf or
cpfl drivers use them.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 50 ++++++-------------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h | 20 ++++++++
 drivers/net/intel/idpf/idpf_common_device.h   |  4 --
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 02e81f7f34..0f5b645f89 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1411,26 +1411,13 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 	struct idpf_vport *vport = &cpfl_vport->base;
 #ifdef RTE_ARCH_X86
 	struct cpfl_rx_queue *cpfl_rxq;
+	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	int i;
 
 	if (cpfl_rx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
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
+		rx_simd_width = cpfl_get_max_simd_bitwidth();
 	} else {
 		vport->rx_vec_allowed = false;
 	}
@@ -1446,7 +1433,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 				(void)idpf_qc_splitq_rx_vec_setup(&cpfl_rxq->base);
 			}
 #ifdef CC_AVX512_SUPPORT
-			if (vport->rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Split AVX512 Vector Rx (port %d).",
 					    dev->data->port_id);
@@ -1466,7 +1453,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 				(void)idpf_qc_singleq_rx_vec_setup(&cpfl_rxq->base);
 			}
 #ifdef CC_AVX512_SUPPORT
-			if (vport->rx_use_avx512) {
+			if (rx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Single AVX512 Vector Rx (port %d).",
 					    dev->data->port_id);
@@ -1474,7 +1461,7 @@ cpfl_set_rx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
-			if (vport->rx_use_avx2) {
+			if (rx_simd_width == RTE_VECT_SIMD_256) {
 				PMD_DRV_LOG(NOTICE,
 						"Using Single AVX2 Vector Rx (port %d).",
 						dev->data->port_id);
@@ -1522,6 +1509,7 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
 #ifdef RTE_ARCH_X86
+	enum rte_vect_max_simd tx_simd_width = RTE_VECT_SIMD_DISABLED;
 #ifdef CC_AVX512_SUPPORT
 	struct cpfl_tx_queue *cpfl_txq;
 	int i;
@@ -1530,22 +1518,12 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	if (cpfl_tx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH &&
 	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
 		vport->tx_vec_allowed = true;
-
-		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			vport->tx_use_avx2 = true;
-
-		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
+		tx_simd_width = cpfl_get_max_simd_bitwidth();
 #ifdef CC_AVX512_SUPPORT
-		{
-			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
-			    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)
-				vport->tx_use_avx512 = true;
-			if (vport->tx_use_avx512) {
-				for (i = 0; i < dev->data->nb_tx_queues; i++) {
-					cpfl_txq = dev->data->tx_queues[i];
-					idpf_qc_tx_vec_avx512_setup(&cpfl_txq->base);
-				}
+		if (tx_simd_width == RTE_VECT_SIMD_512) {
+			for (i = 0; i < dev->data->nb_tx_queues; i++) {
+				cpfl_txq = dev->data->tx_queues[i];
+				idpf_qc_tx_vec_avx512_setup(&cpfl_txq->base);
 			}
 		}
 #else
@@ -1561,7 +1539,7 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
 		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
-			if (vport->tx_use_avx512) {
+			if (tx_simd_width == RTE_VECT_SIMD_512) {
 				PMD_DRV_LOG(NOTICE,
 					    "Using Split AVX512 Vector Tx (port %d).",
 					    dev->data->port_id);
@@ -1579,7 +1557,7 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 	} else {
 		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
-			if (vport->tx_use_avx512) {
+			if (tx_simd_width == RTE_VECT_SIMD_512) {
 				for (i = 0; i < dev->data->nb_tx_queues; i++) {
 					cpfl_txq = dev->data->tx_queues[i];
 					if (cpfl_txq == NULL)
@@ -1594,7 +1572,7 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
-			if (vport->tx_use_avx2) {
+			if (tx_simd_width == RTE_VECT_SIMD_256) {
 				PMD_DRV_LOG(NOTICE,
 						"Using Single AVX2 Vector Tx (port %d).",
 						dev->data->port_id);
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index f1e555b5f8..e2131e4d4d 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -11,6 +11,10 @@
 #include "cpfl_ethdev.h"
 #include "cpfl_rxtx.h"
 
+#ifdef RTE_ARCH_X86
+#include "../common/rx_vec_x86.h"
+#endif
+
 #define CPFL_SCALAR_PATH		0
 #define CPFL_VECTOR_PATH		1
 #define CPFL_RX_NO_VECTOR_FLAGS (		\
@@ -121,4 +125,20 @@ cpfl_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	return CPFL_VECTOR_PATH;
 }
 
+#ifdef RTE_ARCH_X86
+static inline enum rte_vect_max_simd
+cpfl_get_max_simd_bitwidth(void)
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
 #endif /*_CPFL_RXTX_VEC_COMMON_H_*/
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 62665ad286..11baa195e5 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -135,10 +135,6 @@ struct idpf_vport {
 
 	bool rx_vec_allowed;
 	bool tx_vec_allowed;
-	bool rx_use_avx2;
-	bool tx_use_avx2;
-	bool rx_use_avx512;
-	bool tx_use_avx512;
 
 	struct virtchnl2_vport_stats eth_stats_offset;
 
-- 
2.34.1

