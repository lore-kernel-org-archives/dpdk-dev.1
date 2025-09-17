Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BFCA0EE8
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 09:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5887140431;
	Wed, 17 Sep 2025 11:17:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id D425040611
 for <dev@dpdk.org>; Wed, 17 Sep 2025 11:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758100661; x=1789636661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gk6rcQLTi4IHFNllGdXYo+AklpSkKamby6Zy9EYyy8o=;
 b=Dnmo0OaYe3DLMGn3xxgehVFGTpE3ocXUlOonheoY/Dp3QounCwMYrmx4
 X0bTmx3ukAJRm5uKaK8YlSo5XbMISjfBHGQ6nrFtiWwoZEU3HscHi91c8
 EFNgKyn3PhwPwYiEQLi6E3hYOu1jpsKbY2ZDxDLRWh5fl77hiCc+nket4
 kcqfU/3RqmaxPAimlsJEOj+6NPbvyeYrb0gQh+3Bpsqmfny4nNgXP74oJ
 CBgD2pIn9tyxAmTSBzuq3l9fEZAucla2J07hknJF8IVBjklDDkhcxNxQR
 n0bqS84SHk3ok5iVc6k42NpRk6VcCUt15orRUvSByAKCQo7amkEnzossB A==;
X-CSE-ConnectionGUID: sPVKxZETS0iyUi+zol52vg==
X-CSE-MsgGUID: z7hpZEPzRJ21FajkK/P/CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60464528"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="60464528"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 02:17:40 -0700
X-CSE-ConnectionGUID: /3nuxZJASMiCejCZCTm3pw==
X-CSE-MsgGUID: TJqPEg/8R9OwtWXWX/nUvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="174760562"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa009.jf.intel.com with ESMTP; 17 Sep 2025 02:17:39 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 3/5] net/idpf: use the common Rx path selection
 infrastructure
Date: Wed, 17 Sep 2025 09:17:29 +0000
Message-Id: <20250917091731.3632520-4-ciara.loftus@intel.com>
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

Update the common rx path selection infrastructure to include the
feature "single queue" which is relevant for the idpf and cpfl drivers.
Replace the existing complicated logic in the idpf driver with the use
of the common function.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Restored rx function names to match their original names
* Refactored the rx function infos array for better readability
---
 drivers/net/intel/common/rx.h               |   5 +
 drivers/net/intel/idpf/idpf_common_device.h |  12 +++
 drivers/net/intel/idpf/idpf_common_rxtx.c   |  51 ++++++++++
 drivers/net/intel/idpf/idpf_common_rxtx.h   |  12 +++
 drivers/net/intel/idpf/idpf_ethdev.c        |   2 +
 drivers/net/intel/idpf/idpf_rxtx.c          | 103 ++++++--------------
 6 files changed, 110 insertions(+), 75 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 770284f7ab..741808f573 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -131,6 +131,7 @@ struct ci_rx_path_features_extra {
 	bool flex_desc;
 	bool bulk_alloc;
 	bool disabled;
+	bool single_queue;
 };
 
 struct ci_rx_path_features {
@@ -278,6 +279,10 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 		if (path_features->extra.flex_desc != req_features.extra.flex_desc)
 			continue;
 
+		/* If requested, ensure the path supports single queue RX. */
+		if (path_features->extra.single_queue != req_features.extra.single_queue)
+			continue;
+
 		/* If requested, ensure the path supports scattered RX. */
 		if (path_features->extra.scattered != req_features.extra.scattered)
 			continue;
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 5f3e4a4fcf..62665ad286 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -44,6 +44,16 @@
 	(sizeof(struct virtchnl2_ptype) +				\
 	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
 
+enum idpf_rx_func_type {
+	IDPF_RX_DEFAULT,
+	IDPF_RX_SINGLEQ,
+	IDPF_RX_SINGLEQ_SCATTERED,
+	IDPF_RX_SINGLEQ_AVX2,
+	IDPF_RX_AVX512,
+	IDPF_RX_SINGLQ_AVX512,
+	IDPF_RX_MAX
+};
+
 struct idpf_adapter {
 	struct idpf_hw hw;
 	struct virtchnl2_version_info virtchnl_version;
@@ -59,6 +69,8 @@ struct idpf_adapter {
 
 	/* For timestamp */
 	uint64_t time_hw;
+
+	enum idpf_rx_func_type rx_func_type;
 };
 
 struct idpf_chunks_info {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index eb25b091d8..a2b8c372d6 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -7,6 +7,8 @@
 #include <rte_errno.h>
 
 #include "idpf_common_rxtx.h"
+#include "idpf_common_device.h"
+#include "../common/rx.h"
 
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
@@ -1622,3 +1624,52 @@ idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
 	rxq->bufq2->idpf_ops = &def_rx_ops_vec;
 	return idpf_rxq_vec_setup_default(rxq->bufq2);
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_rx_path_infos)
+const struct ci_rx_path_info idpf_rx_path_infos[] = {
+	[IDPF_RX_DEFAULT] = {
+		.pkt_burst = idpf_dp_splitq_recv_pkts,
+		.info = "Split Scalar",
+		.features = {
+			.rx_offloads = IDPF_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED}},
+	[IDPF_RX_SINGLEQ] = {
+		.pkt_burst = idpf_dp_singleq_recv_pkts,
+		.info = "Single Scalar",
+		.features = {
+			.rx_offloads = IDPF_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.single_queue = true}},
+	[IDPF_RX_SINGLEQ_SCATTERED] = {
+		.pkt_burst = idpf_dp_singleq_recv_scatter_pkts,
+		.info = "Single Scalar Scattered",
+		.features = {
+			.rx_offloads = IDPF_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.scattered = true,
+			.extra.single_queue = true}},
+#ifdef RTE_ARCH_X86
+	[IDPF_RX_SINGLEQ_AVX2] = {
+		.pkt_burst = idpf_dp_singleq_recv_pkts_avx2,
+		.info = "Single AVX2 Vector",
+		.features = {
+			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.single_queue = true}},
+#ifdef CC_AVX512_SUPPORT
+	[IDPF_RX_AVX512] = {
+		.pkt_burst = idpf_dp_splitq_recv_pkts_avx512,
+		.info = "Split AVX512 Vector",
+		.features = {
+			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512}},
+	[IDPF_RX_SINGLQ_AVX512] = {
+		.pkt_burst = idpf_dp_singleq_recv_pkts_avx512,
+		.info = "Single AVX512 Vector",
+		.features = {
+			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.single_queue = true}},
+#endif /* CC_AVX512_SUPPORT */
+#endif /* RTE_ARCH_X86 */
+};
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index f84a760334..3bc3323af4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -11,6 +11,7 @@
 
 #include "idpf_common_device.h"
 #include "../common/tx.h"
+#include "../common/rx.h"
 
 #define IDPF_RX_MAX_BURST		32
 
@@ -96,6 +97,15 @@
 #define IDPF_RX_SPLIT_BUFQ1_ID	1
 #define IDPF_RX_SPLIT_BUFQ2_ID	2
 
+#define IDPF_RX_SCALAR_OFFLOADS (			\
+		RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_TCP_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP | \
+		RTE_ETH_RX_OFFLOAD_SCATTER)
+#define IDPF_RX_VECTOR_OFFLOADS 0
+
 struct idpf_rx_stats {
 	RTE_ATOMIC(uint64_t) mbuf_alloc_failed;
 };
@@ -253,4 +263,6 @@ uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
 					struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts);
 
+extern const struct ci_rx_path_info idpf_rx_path_infos[IDPF_RX_MAX];
+
 #endif /* _IDPF_COMMON_RXTX_H_ */
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 90720909bf..c04842c9df 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -694,6 +694,8 @@ idpf_dev_configure(struct rte_eth_dev *dev)
 		(dev->data->mtu == 0) ? IDPF_DEFAULT_MTU : dev->data->mtu +
 		IDPF_ETH_OVERHEAD;
 
+	vport->adapter->rx_func_type = IDPF_RX_DEFAULT;
+
 	return 0;
 }
 
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index c9eb7f66d2..1c725065df 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -760,97 +760,50 @@ void
 idpf_set_rx_function(struct rte_eth_dev *dev)
 {
 	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *ad = vport->adapter;
+	struct ci_rx_path_features req_features = {
+		.rx_offloads = dev->data->dev_conf.rxmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 #ifdef RTE_ARCH_X86
 	struct idpf_rx_queue *rxq;
-	enum rte_vect_max_simd rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	int i;
 
 	if (idpf_rx_vec_dev_check_default(dev) == IDPF_VECTOR_PATH &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		vport->rx_vec_allowed = true;
-		rx_simd_width = idpf_get_max_simd_bitwidth();
-	} else {
-		vport->rx_vec_allowed = false;
-	}
+	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+		req_features.simd_width = idpf_get_max_simd_bitwidth();
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
-				rxq = dev->data->rx_queues[i];
-				(void)idpf_qc_splitq_rx_vec_setup(rxq);
-			}
-#ifdef CC_AVX512_SUPPORT
-			if (rx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Split AVX512 Vector Rx (port %d).",
-					    dev->data->port_id);
-				dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts_avx512;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Rx (port %d).",
-			    dev->data->port_id);
-		dev->rx_pkt_burst = idpf_dp_splitq_recv_pkts;
-	} else {
-		if (vport->rx_vec_allowed) {
-			for (i = 0; i < dev->data->nb_tx_queues; i++) {
 				rxq = dev->data->rx_queues[i];
 				(void)idpf_qc_singleq_rx_vec_setup(rxq);
 			}
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
-					    "Using Single AVX2 Vector Rx (port %d).",
-					    dev->data->port_id);
-				dev->rx_pkt_burst = idpf_dp_singleq_recv_pkts_avx2;
-				return;
+		} else {
+			for (i = 0; i < dev->data->nb_rx_queues; i++) {
+				rxq = dev->data->rx_queues[i];
+				(void)idpf_qc_splitq_rx_vec_setup(rxq);
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
 	}
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
-	}
-#endif /* RTE_ARCH_X86 */
+#endif
+
+	dev->rx_pkt_burst = idpf_rx_path_infos[ad->rx_func_type].pkt_burst;
+	PMD_DRV_LOG(NOTICE, "Using %s Rx (port %d).",
+			idpf_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
+
 }
 
 void
-- 
2.34.1

