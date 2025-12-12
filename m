Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FEFD44176
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1AD640B8D;
	Fri, 12 Dec 2025 11:33:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3ECA4400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 11:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535617; x=1797071617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4IFoMVXAkCYIiR/5Oe1BqH4hHwSnDOAt7FREgcUNI1o=;
 b=G2QpXZtR2+8GgKSpnY/b9/0URgNahAbVh0qm4kZizcTwQRi+EtRCFE0s
 M/ftSaAwZo2+Be3DVA0EBVf5YeuKe47ZhJJlUcoWhlw+GlQO760aNzJAB
 P0p6F+4OuRwRG+p4YYKIPRqGYKKe2edY2AzNxE06RnKBG1kbsoaRAqw0p
 YFvzWYVJuDJpPvftDbg4t/qCCADvVgWXzww2fnqPJH25Cknc/aPG18NJx
 fYtFT/lwRWMzzpkHv+qOg/Pa+ihEPYaBDZrl5wuuCsMgxBexNRdFKObNN
 KFBo29k7UmpWxNeapooq8eEtpY6zUVpFB9qjbI0BhOPwOsoDGLRBlbWs0 g==;
X-CSE-ConnectionGUID: GR2faS36Thmhr+FfBz/sPQ==
X-CSE-MsgGUID: CGc72NKDTh+LxRX4HVGXQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522879"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:36 -0800
X-CSE-ConnectionGUID: jEG4FHA1RROYyeQu1UaIAg==
X-CSE-MsgGUID: v6QgN0fNSkKfbZK78RA7JA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:31 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 03/10] net/iavf: use common Tx path selection infrastructure
Date: Fri, 12 Dec 2025 10:33:16 +0000
Message-ID: <20251212103323.1481307-4-ciara.loftus@intel.com>
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

Introduce two new features "disabled" and "context desc" to the common
infrastructure which represents whether or not the path is disabled, or
if it uses a context descriptor.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Merged the patch which consolidates path selection among process types
with the introduction of the new infrastructure.
---
 drivers/net/intel/common/tx.h                 |  14 +
 drivers/net/intel/iavf/iavf.h                 |   2 -
 drivers/net/intel/iavf/iavf_ethdev.c          |   9 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 240 +++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.h            |  46 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  39 +--
 6 files changed, 166 insertions(+), 184 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 04d9aa8473..60b1bd642a 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -122,6 +122,8 @@ struct ci_tx_path_features {
 	uint32_t tx_offloads;
 	enum rte_vect_max_simd simd_width;
 	bool simple_tx;
+	bool ctx_desc;
+	bool disabled;
 };
 
 struct ci_tx_path_info {
@@ -304,10 +306,18 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 	for (unsigned int i = 0; i < num_paths; i++) {
 		const struct ci_tx_path_features *path_features = &infos[i].features;
 
+		/* Do not select a disabled tx path. */
+		if (path_features->disabled)
+			continue;
+
 		/* Do not use a simple tx path if not requested. */
 		if (path_features->simple_tx && !req_features->simple_tx)
 			continue;
 
+		/* If a context descriptor is requested, ensure the path supports it. */
+		if (!path_features->ctx_desc && req_features->ctx_desc)
+			continue;
+
 		/* Ensure the path supports the requested TX offloads. */
 		if ((path_features->tx_offloads & req_features->tx_offloads) !=
 				req_features->tx_offloads)
@@ -329,6 +339,10 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 					rte_popcount32(path_features->tx_offloads) >
 					rte_popcount32(chosen_path_features->tx_offloads))
 				continue;
+
+			/* Don't use a context descriptor unless necessary */
+			if (path_features->ctx_desc && !chosen_path_features->ctx_desc)
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
index 15e49fe248..bf1186c20f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -666,10 +666,8 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 		return -EIO;
 
 	ad->rx_bulk_alloc_allowed = true;
-	/* Initialize to TRUE. If any of Rx queues doesn't meet the
-	 * vector Rx/Tx preconditions, it will be reset.
-	 */
-	ad->tx_vec_allowed = true;
+
+	ad->tx_func_type = IAVF_TX_DEFAULT;
 
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
@@ -2795,8 +2793,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	eth_dev->tx_pkt_prepare = &iavf_prep_pkts;
 
 	/* For secondary processes, we don't initialise any further as primary
-	 * has already done this work. Only check if we need a different RX
-	 * and TX function.
+	 * has already done this work.
 	 */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		iavf_set_rx_function(eth_dev);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d8662fd815..794232c5dd 100644
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
+			.disabled = true
+		}
+	},
+	[IAVF_TX_DEFAULT] = {
+		.pkt_burst = iavf_xmit_pkts,
+		.info = "Scalar",
+		.features = {
+			.tx_offloads = IAVF_TX_SCALAR_OFFLOADS,
+			.ctx_desc = true
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
+			.ctx_desc = true
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
+			.ctx_desc = true
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
@@ -4229,109 +4266,62 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	enum iavf_tx_func_type tx_func_type;
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
-
-	check_ret = iavf_tx_vec_dev_check(dev);
-
-	if (check_ret >= 0 &&
-	    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-		/* SSE not support offload path yet. */
-		if (check_ret == IAVF_VECTOR_PATH) {
-			use_sse = true;
-		}
+	struct ci_tx_path_features req_features = {
+		.tx_offloads = dev->data->dev_conf.txmode.offloads,
+		.simd_width = RTE_VECT_SIMD_DISABLED,
+	};
+
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
 
-		use_avx2 = tx_simd_path == RTE_VECT_SIMD_256;
-		use_avx512 = tx_simd_path == RTE_VECT_SIMD_512;
+#ifdef RTE_ARCH_X86
+	if (iavf_tx_vec_dev_check(dev) != -1)
+		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-		if (!use_sse && !use_avx2 && !use_avx512)
-			goto normal;
+	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+		req_features.ctx_desc = true;
 
-		if (use_sse) {
-			PMD_DRV_LOG(DEBUG, "Using Vector Tx (port %d).",
-				    dev->data->port_id);
-			tx_func_type = IAVF_TX_SSE;
-		}
-		if (!use_avx512 && use_avx2) {
-			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_func_type = IAVF_TX_AVX2;
-				PMD_DRV_LOG(DEBUG, "Using AVX2 Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_CTX_OFFLOAD_PATH) {
-				PMD_DRV_LOG(DEBUG,
-					"AVX2 does not support requested Tx offloads.");
-				goto normal;
-			} else {
-				tx_func_type = IAVF_TX_AVX2_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX2 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			}
-		}
-#ifdef CC_AVX512_SUPPORT
-		if (use_avx512) {
-			if (check_ret == IAVF_VECTOR_PATH) {
-				tx_func_type = IAVF_TX_AVX512;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_OFFLOAD_PATH) {
-				tx_func_type = IAVF_TX_AVX512_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			} else if (check_ret == IAVF_VECTOR_CTX_PATH) {
-				tx_func_type = IAVF_TX_AVX512_CTX;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT Vector Tx (port %d).",
-						dev->data->port_id);
-			} else {
-				tx_func_type = IAVF_TX_AVX512_CTX_OFFLOAD;
-				PMD_DRV_LOG(DEBUG, "Using AVX512 CONTEXT OFFLOAD Vector Tx (port %d).",
-					    dev->data->port_id);
-			}
-		}
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (!txq)
+			continue;
+		if (txq->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT &&
+				txq->vlan_flag == IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
+			req_features.ctx_desc = true;
+	}
 #endif
 
+	adapter->tx_func_type = ci_tx_path_select(&req_features,
+						&iavf_tx_path_infos[0],
+						RTE_DIM(iavf_tx_path_infos),
+						IAVF_TX_DEFAULT);
+
+out:
+	if (iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0) {
 		for (i = 0; i < dev->data->nb_tx_queues; i++) {
 			txq = dev->data->tx_queues[i];
 			if (!txq)
 				continue;
 			iavf_txq_vec_setup(txq);
+			txq->use_ctx =
+				iavf_tx_path_infos[adapter->tx_func_type].features.ctx_desc;
 		}
-
-		if (no_poll_on_link_down) {
-			adapter->tx_func_type = tx_func_type;
-			dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
-		} else if (mbuf_check) {
-			adapter->tx_func_type = tx_func_type;
-			dev->tx_pkt_burst = iavf_xmit_pkts_check;
-		} else {
-			dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
-		}
-		return;
 	}
 
-normal:
-#endif
-	PMD_DRV_LOG(DEBUG, "Using Basic Tx callback (port=%d).",
-		    dev->data->port_id);
-	tx_func_type = IAVF_TX_DEFAULT;
-
-	if (no_poll_on_link_down) {
-		adapter->tx_func_type = tx_func_type;
+	if (no_poll_on_link_down)
 		dev->tx_pkt_burst = iavf_xmit_pkts_no_poll;
-	} else if (mbuf_check) {
-		adapter->tx_func_type = tx_func_type;
+	else if (mbuf_check)
 		dev->tx_pkt_burst = iavf_xmit_pkts_check;
-	} else {
-		dev->tx_pkt_burst = iavf_tx_pkt_burst_ops[tx_func_type].pkt_burst;
-	}
+	else
+		dev->tx_pkt_burst = iavf_tx_path_infos[adapter->tx_func_type].pkt_burst;
+
+	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
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

