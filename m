Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD86AD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 11:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7902E40B90;
	Tue,  9 Dec 2025 12:27:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D9EBC40A77
 for <dev@dpdk.org>; Tue,  9 Dec 2025 12:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765279632; x=1796815632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hW8QZKxd4MeUTKAFGq+1r4T81QLUwD1NLKEJgDd3JJo=;
 b=GfZns1BVN7Axz012Xoq6sYjC/hXyV4lcNu/1YBDMhZFKekJQLwIlTERn
 gKBIpe7DcSecstbqU+1hguDW1TMdCHfR413YYQ5dsPE3+KizKbzHA9D6x
 vRbjx8X1i/nAoO08OOHXL0zib8NlK95taiWYRXkk3aQdFZ7chC2TGbH07
 d5y+Od/Lb4g/ZJlYiZijFrApIUZ3gNYYGfILnoUzLfzHz9ePXd0pwrnZC
 JuqsnyHfrwppYGZR0TGe9rov0DurG3N0RVbrN9olPrLd/OlEeIAQKR14o
 VaFlELwO3P4003OdKeiywjnCtMQ8BqC8YdEQFs0NYJWJ3+TDolvuzNL23 Q==;
X-CSE-ConnectionGUID: cC+Sa8MOToi2Ppw7lKg/NA==
X-CSE-MsgGUID: 1YOjYFh7TzaLh82EY7DgXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="67117040"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="67117040"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2025 03:27:11 -0800
X-CSE-ConnectionGUID: 75xBtNMYQWCrsWJ4PWU9TA==
X-CSE-MsgGUID: 2DlNQtJvTZ2MNuKBA9yNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; d="scan'208";a="195270209"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 09 Dec 2025 03:27:10 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 05/13] net/iavf: use common Tx path selection infrastructure
Date: Tue,  9 Dec 2025 11:26:44 +0000
Message-ID: <20251209112652.963981-6-ciara.loftus@intel.com>
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
function. Introduce two new features "disabled" and "context desc" to
the common infrastructure which represents whether or not the path is
disabled, or if it uses a context descriptor.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h                 |  14 ++
 drivers/net/intel/iavf/iavf.h                 |   2 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   4 -
 drivers/net/intel/iavf/iavf_rxtx.c            | 193 ++++++++++--------
 drivers/net/intel/iavf/iavf_rxtx.h            |  46 +++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  39 +---
 6 files changed, 153 insertions(+), 145 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 3480c5e07c..5d965a86c9 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -120,6 +120,8 @@ struct ci_tx_queue {
 
 struct ci_tx_path_features_extra {
 	bool simple_tx;
+	bool ctx_desc;
+	bool disabled;
 };
 
 struct ci_tx_path_features {
@@ -308,6 +310,10 @@ ci_tx_path_select(struct ci_tx_path_features req_features,
 	for (i = 0; i < num_paths; i++) {
 		const struct ci_tx_path_features *path_features = &infos[i].features;
 
+		/* Do not select a disabled tx path. */
+		if (path_features->extra.disabled)
+			continue;
+
 		/* Do not use a simple tx path if not requested. */
 		if (path_features->extra.simple_tx && !req_features.extra.simple_tx)
 			continue;
@@ -321,6 +327,10 @@ ci_tx_path_select(struct ci_tx_path_features req_features,
 		if (path_features->simd_width > req_features.simd_width)
 			continue;
 
+		/* If a context descriptor is requested, ensure the path supports it. */
+		if (!path_features->extra.ctx_desc && req_features.extra.ctx_desc)
+			continue;
+
 		/* Do not select the path if it is less suitable than the chosen path. */
 		if (chosen_path_features != NULL) {
 			/* Do not select paths with lower SIMD width than the chosen path. */
@@ -333,6 +343,10 @@ ci_tx_path_select(struct ci_tx_path_features req_features,
 					rte_popcount32(path_features->tx_offloads) >
 					rte_popcount32(chosen_path_features->tx_offloads))
 				continue;
+
+			/* Don't use a context descriptor unless necessary */
+			if (path_features->extra.ctx_desc && !chosen_path_features->extra.ctx_desc)
+				continue;
 		}
 
 		/* Finally, select the path since it has met all the requirements. */
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index d78582e05c..921bf0a607 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -375,8 +375,6 @@ struct iavf_adapter {
 	struct iavf_security_ctx *security_ctx;
 
 	bool rx_bulk_alloc_allowed;
-	/* For vector PMD */
-	bool tx_vec_allowed;
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[IAVF_MAX_PKT_TYPE];
 	bool stopped;
 	bool closed;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ab65e99f68..bf1186c20f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -666,10 +666,6 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 		return -EIO;
 
 	ad->rx_bulk_alloc_allowed = true;
-	/* Initialize to TRUE. If any of Rx queues doesn't meet the
-	 * vector Rx/Tx preconditions, it will be reset.
-	 */
-	ad->tx_vec_allowed = true;
 
 	ad->tx_func_type = IAVF_TX_DEFAULT;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 055b2b0ae0..a8c19fd031 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -208,19 +208,6 @@ check_tx_thresh(uint16_t nb_desc, uint16_t tx_rs_thresh,
 	return 0;
 }
 
-static inline bool
-check_tx_vec_allow(struct ci_tx_queue *txq)
-{
-	if (!(txq->offloads & IAVF_TX_NO_VECTOR_FLAGS) &&
-	    txq->tx_rs_thresh >= IAVF_VPMD_TX_BURST &&
-	    txq->tx_rs_thresh <= IAVF_VPMD_TX_MAX_FREE_BUF) {
-		PMD_INIT_LOG(DEBUG, "Vector tx can be enabled on this txq.");
-		return true;
-	}
-	PMD_INIT_LOG(DEBUG, "Vector Tx cannot be enabled on this txq.");
-	return false;
-}
-
 static inline bool
 check_rx_bulk_allow(struct ci_rx_queue *rxq)
 {
@@ -861,12 +848,6 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	dev->data->tx_queues[queue_idx] = txq;
 	txq->qtx_tail = hw->hw_addr + IAVF_QTX_TAIL1(queue_idx);
 
-	if (check_tx_vec_allow(txq) == false) {
-		struct iavf_adapter *ad =
-			IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-		ad->tx_vec_allowed = false;
-	}
-
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS &&
 	    vf->tm_conf.committed) {
 		int tc;
@@ -4002,26 +3983,82 @@ iavf_rx_burst_mode_get(struct rte_eth_dev *dev,
 	return -EINVAL;
 }
 
-static const struct {
-	eth_tx_burst_t pkt_burst;
-	const char *info;
-} iavf_tx_pkt_burst_ops[] = {
-	[IAVF_TX_DISABLED] = {iavf_xmit_pkts_no_poll, "Disabled"},
-	[IAVF_TX_DEFAULT] = {iavf_xmit_pkts, "Scalar"},
+static const struct ci_tx_path_info iavf_tx_path_infos[] = {
+	[IAVF_TX_DISABLED] = {
+		.pkt_burst = iavf_xmit_pkts_no_poll,
+		.info = "Disabled",
+		.features = {
+			.extra.disabled = true
+		}
+	},
+	[IAVF_TX_DEFAULT] = {
+		.pkt_burst = iavf_xmit_pkts,
+		.info = "Scalar",
+		.features = {
+			.tx_offloads = IAVF_TX_SCALAR_OFFLOADS,
+			.extra.ctx_desc = true
+		}
+	},
 #ifdef RTE_ARCH_X86
-	[IAVF_TX_SSE] = {iavf_xmit_pkts_vec, "Vector SSE"},
-	[IAVF_TX_AVX2] = {iavf_xmit_pkts_vec_avx2, "Vector AVX2"},
-	[IAVF_TX_AVX2_OFFLOAD] = {iavf_xmit_pkts_vec_avx2_offload,
-		"Vector AVX2 Offload"},
+	[IAVF_TX_SSE] = {
+		.pkt_burst = iavf_xmit_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128
+		}
+	},
+	[IAVF_TX_AVX2] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		}
+	},
+	[IAVF_TX_AVX2_OFFLOAD] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx2_offload,
+		.info = "Vector AVX2 Offload",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		}
+	},
 #ifdef CC_AVX512_SUPPORT
-	[IAVF_TX_AVX512] = {iavf_xmit_pkts_vec_avx512, "Vector AVX512"},
-	[IAVF_TX_AVX512_OFFLOAD] = {iavf_xmit_pkts_vec_avx512_offload,
-		"Vector AVX512 Offload"},
-	[IAVF_TX_AVX512_CTX] = {iavf_xmit_pkts_vec_avx512_ctx,
-		"Vector AVX512 Ctx"},
+	[IAVF_TX_AVX512] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		}
+	},
+	[IAVF_TX_AVX512_OFFLOAD] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx512_offload,
+		.info = "Vector AVX512 Offload",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512
+		}
+	},
+	[IAVF_TX_AVX512_CTX] = {
+		.pkt_burst = iavf_xmit_pkts_vec_avx512_ctx,
+		.info = "Vector AVX512 Ctx",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.ctx_desc = true
+		}
+	},
 	[IAVF_TX_AVX512_CTX_OFFLOAD] = {
-		iavf_xmit_pkts_vec_avx512_ctx_offload,
-		"Vector AVX512 Ctx Offload"},
+		.pkt_burst = iavf_xmit_pkts_vec_avx512_ctx_offload,
+		.info = "Vector AVX512 Ctx Offload",
+		.features = {
+			.tx_offloads = IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.ctx_desc = true
+		}
+	},
 #endif
 #endif
 };
@@ -4034,10 +4071,10 @@ iavf_tx_burst_mode_get(struct rte_eth_dev *dev,
 	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
 	size_t i;
 
-	for (i = 0; i < RTE_DIM(iavf_tx_pkt_burst_ops); i++) {
-		if (pkt_burst == iavf_tx_pkt_burst_ops[i].pkt_burst) {
+	for (i = 0; i < RTE_DIM(iavf_tx_path_infos); i++) {
+		if (pkt_burst == iavf_tx_path_infos[i].pkt_burst) {
 			snprintf(mode->info, sizeof(mode->info), "%s",
-				 iavf_tx_pkt_burst_ops[i].info);
+				 iavf_tx_path_infos[i].info);
 			return 0;
 		}
 	}
@@ -4073,7 +4110,7 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	tx_func_type = txq->iavf_vsi->adapter->tx_func_type;
 
-	return iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst(tx_queue,
+	return iavf_tx_path_infos[tx_func_type].pkt_burst(tx_queue,
 								tx_pkts, nb_pkts);
 }
 
@@ -4158,7 +4195,7 @@ iavf_xmit_pkts_check(void *tx_queue, struct rte_mbuf **tx_pkts,
 			return 0;
 	}
 
-	return iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
+	return iavf_tx_path_infos[tx_func_type].pkt_burst(tx_queue, tx_pkts, good_pkts);
 }
 
 /* choose rx function*/
@@ -4231,79 +4268,59 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int mbuf_check = adapter->devargs.mbuf_check;
 	int no_poll_on_link_down = adapter->devargs.no_poll_on_link_down;
-#ifdef RTE_ARCH_X86
 	struct ci_tx_queue *txq;
 	int i;
-	int check_ret;
-	bool use_sse = false;
-	bool use_avx2 = false;
-	bool use_avx512 = false;
-	enum rte_vect_max_simd tx_simd_path = iavf_get_max_simd_bitwidth();
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
 
 	/* The primary process selects the tx path for all processes. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		goto out;
 
-	check_ret = iavf_tx_vec_dev_check(dev);
-
-	if (check_ret >= 0 &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		/* SSE not support offload path yet. */
-		if (check_ret == IAVF_VECTOR_PATH) {
-			use_sse = true;
-		}
-
-		use_avx2 = tx_simd_path == RTE_VECT_SIMD_256;
-		use_avx512 = tx_simd_path == RTE_VECT_SIMD_512;
-
-		if (!use_sse && !use_avx2 && !use_avx512)
-			goto out;
+#ifdef RTE_ARCH_X86
+	if (iavf_tx_vec_dev_check(dev) != -1)
+		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-		if (use_sse)
-			adapter->tx_func_type = IAVF_TX_SSE;
+	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+		req_features.extra.ctx_desc = true;
 
-		if (!use_avx512 && use_avx2) {
-			if (check_ret == IAVF_VECTOR_PATH)
-				adapter->tx_func_type = IAVF_TX_AVX2;
-			else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH)
-				goto out;
-			else
-				adapter->tx_func_type = IAVF_TX_AVX2_OFFLOAD;
-		}
-#ifdef CC_AVX512_SUPPORT
-		if (use_avx512) {
-			if (check_ret == IAVF_VECTOR_PATH)
-				adapter->tx_func_type = IAVF_TX_AVX512;
-			else if (check_ret == IAVF_VECTOR_OFFLOAD_PATH)
-				adapter->tx_func_type = IAVF_TX_AVX512_OFFLOAD;
-			else if (check_ret == IAVF_VECTOR_CTX_PATH)
-				adapter->tx_func_type = IAVF_TX_AVX512_CTX;
-			else
-				adapter->tx_func_type = IAVF_TX_AVX512_CTX_OFFLOAD;
-		}
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (!txq)
+			continue;
+		if (txq->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT &&
+				txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
+			req_features.extra.ctx_desc = true;
+	}
 #endif
 
+	adapter->tx_func_type = ci_tx_path_select(req_features,
+						&iavf_tx_path_infos[0],
+						RTE_DIM(iavf_tx_path_infos),
+						IAVF_TX_DEFAULT);
+
+	if (iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0) {
 		for (i = 0; i < dev->data->nb_tx_queues; i++) {
 			txq = dev->data->tx_queues[i];
 			if (!txq)
 				continue;
 			iavf_txq_vec_setup(txq);
+			txq->use_ctx =
+				iavf_tx_path_infos[adapter->tx_func_type].features.extra.ctx_desc;
 		}
-
-		goto out;
 	}
-#endif
-
 out:
 	if (no_poll_on_link_down)
 		dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
 	else if (mbuf_check)
 		dev->tx_pkt_burst = iavf_xmit_pkts_check;
 	else
-		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[adapter->tx_func_type].pkt_burst;
+		dev->tx_pkt_burst = iavf_tx_path_infos[adapter->tx_func_type].pkt_burst;
 
 	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
-		 iavf_tx_pkt_burst_ops[adapter->tx_func_type].info, dev->data->port_id);
+		 iavf_tx_path_infos[adapter->tx_func_type].info, dev->data->port_id);
 }
 
 static int
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 8efb3bd04e..bff456e509 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -35,22 +35,38 @@
 #define IAVF_VPMD_DESCS_PER_LOOP_WIDE  CI_VPMD_DESCS_PER_LOOP_WIDE
 #define IAVF_VPMD_TX_MAX_FREE_BUF      64
 
-#define IAVF_TX_NO_VECTOR_FLAGS (				 \
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		 \
-		RTE_ETH_TX_OFFLOAD_TCP_TSO |		 \
-		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	 \
-		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	 \
-		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	 \
-		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	 \
-		RTE_ETH_TX_OFFLOAD_SECURITY)
-
-#define IAVF_TX_VECTOR_OFFLOAD (				 \
-		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		 \
-		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		 \
-		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		 \
+/* basic scalar path */
+#define IAVF_TX_SCALAR_OFFLOADS (			\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
+		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |	\
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
+		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |	\
+		RTE_ETH_TX_OFFLOAD_SECURITY |		\
+		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM)
+/* basic vector path */
+#define IAVF_TX_VECTOR_OFFLOADS RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+/* offload vector path */
+#define IAVF_TX_VECTOR_OFFLOAD_OFFLOADS (		\
+		IAVF_TX_VECTOR_OFFLOADS |		\
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
-
-#define IAVF_TX_VECTOR_OFFLOAD_CTX (			\
+/* offload vector path with context descriptor */
+#define IAVF_TX_VECTOR_CTX_OFFLOAD_OFFLOADS (		\
+		IAVF_TX_VECTOR_OFFLOADS |		\
+		IAVF_TX_VECTOR_OFFLOAD_OFFLOADS |	\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 66f65b46e9..f1ea57034f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -73,8 +73,6 @@ iavf_rx_vec_queue_default(struct ci_rx_queue *rxq)
 static inline int
 iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 {
-	bool vlan_offload = false, vlan_needs_ctx = false;
-
 	if (!txq)
 		return -1;
 
@@ -82,35 +80,7 @@ iavf_tx_vec_queue_default(struct ci_tx_queue *txq)
 	    txq->tx_rs_thresh > IAVF_VPMD_TX_MAX_FREE_BUF)
 		return -1;
 
-	if (txq->offloads & IAVF_TX_NO_VECTOR_FLAGS)
-		return -1;
-
-	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0) {
-		txq->use_ctx = 1;
-		return IAVF_VECTOR_CTX_PATH;
-	}
-
-	/* Vlan tci needs to be inserted via ctx desc, if the vlan_flag is L2TAG2. */
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT) {
-		vlan_offload = true;
-		if (txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
-			vlan_needs_ctx = true;
-	}
-
-	/**
-	 * Tunneling parameters and other fields need be configured in ctx desc
-	 * if the outer checksum offload is enabled.
-	 */
-	if (txq->offloads & (IAVF_TX_VECTOR_OFFLOAD | IAVF_TX_VECTOR_OFFLOAD_CTX) || vlan_offload) {
-		if (txq->offloads & IAVF_TX_VECTOR_OFFLOAD_CTX || vlan_needs_ctx) {
-			txq->use_ctx = 1;
-			return IAVF_VECTOR_CTX_OFFLOAD_PATH;
-		} else {
-			return IAVF_VECTOR_OFFLOAD_PATH;
-		}
-	} else {
-		return IAVF_VECTOR_PATH;
-	}
+	return 0;
 }
 
 static inline int
@@ -137,19 +107,16 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 	int i;
 	struct ci_tx_queue *txq;
 	int ret;
-	int result = 0;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		ret = iavf_tx_vec_queue_default(txq);
 
 		if (ret < 0)
-			return -1;
-		if (ret > result)
-			result = ret;
+			break;
 	}
 
-	return result;
+	return ret;
 }
 
 /******************************************************************************
-- 
2.43.0

