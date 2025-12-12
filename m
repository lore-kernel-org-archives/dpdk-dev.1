Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEFD4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:07:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1C3140E37;
	Fri, 12 Dec 2025 12:06:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7738540E1C
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765537603; x=1797073603;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q64CJ27kH7mngT0nr7ORnMN4PvKOxgm/ntNMf9JpO/k=;
 b=GvKxhojpwdWEFDR/QUMX7JdajZyhBnjkv+0TICSxbMxH8KaQ6A8YfMYe
 0RDd57dFilPX/QWuZhrenroQbN7WK3L5EoY6AOptKjq948VpX4+5W7rCu
 uSGcQQPus8UP1Umypmouk0jfffTXd2TmHuhgELLwNB4jhqvelxEic55d2
 1xXjUWZerV75B8pKjaZTZNRjfIdCE56A+rGUqWcgFsWEsVW5F6Uew11JS
 rvxHRu3y2H1V9dmM80btu9OnQ4GNeD+6x6ei5T7HUUOLdTRwOoQ+4H81Y
 SbAx4elNPvba1JO2M8yiTGtnPJptMqP1R7mrpDFMdysfkcR4ovdcDnqHw g==;
X-CSE-ConnectionGUID: k6pqA+GjRNWgZ2XgCJkurw==
X-CSE-MsgGUID: zfD7OJANT72oCX83hUo5iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67472054"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; d="scan'208";a="67472054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 03:06:42 -0800
X-CSE-ConnectionGUID: GazG8WfHTFenRhlwnwqEtg==
X-CSE-MsgGUID: NF3Qig8ZQjSIosHDdlYqMA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 03:06:41 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 06/10] net/cpfl: use common Tx path selection infrastructure
Date: Fri, 12 Dec 2025 11:06:24 +0000
Message-ID: <20251212110628.1634703-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212110628.1634703-1-ciara.loftus@intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
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

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* removed unnecessary tx_vec_allowed
---
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 120 ++++++------------
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  10 --
 drivers/net/intel/idpf/idpf_common_device.h   |   2 -
 3 files changed, 37 insertions(+), 95 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 453ec975d5..b6bf4094f1 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1462,97 +1462,51 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
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
+		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
+	};
+
+	/* The primary process selects the tx path for all processes. */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto out;
+
+#ifdef RTE_ARCH_X86
+	if (cpfl_tx_vec_dev_check_default(dev) == CPFL_VECTOR_PATH)
+		req_features.simd_width = cpfl_get_max_simd_bitwidth();
+#endif
+
+	ad->tx_func_type = ci_tx_path_select(&req_features,
+					&idpf_tx_path_infos[0],
+					IDPF_TX_MAX,
+					IDPF_TX_DEFAULT);
+
+out:
+	dev->tx_pkt_burst = idpf_tx_path_infos[ad->tx_func_type].pkt_burst;
+	dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+	PMD_DRV_LOG(NOTICE, "Using %s Tx (port %d).",
+			idpf_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 #ifdef RTE_ARCH_X86
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
-		if (vport->tx_vec_allowed) {
-#ifdef CC_AVX512_SUPPORT
-			if (tx_simd_width == RTE_VECT_SIMD_512) {
-				PMD_DRV_LOG(NOTICE,
-					    "Using Split AVX512 Vector Tx (port %d).",
-					    dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx512;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
-#endif /* CC_AVX512_SUPPORT */
-		}
-		PMD_DRV_LOG(NOTICE,
-			    "Using Split Scalar Tx (port %d).",
-			    dev->data->port_id);
-		dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts;
-		dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-	} else {
-		if (vport->tx_vec_allowed) {
 #ifdef CC_AVX512_SUPPORT
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
-#endif /* CC_AVX512_SUPPORT */
-			if (tx_simd_width == RTE_VECT_SIMD_256) {
-				PMD_DRV_LOG(NOTICE,
-						"Using Single AVX2 Vector Tx (port %d).",
-						dev->data->port_id);
-				dev->tx_pkt_burst = idpf_dp_singleq_xmit_pkts_avx2;
-				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
-				return;
-			}
+	if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256 &&
+			idpf_tx_path_infos[ad->tx_func_type].features.single_queue) {
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			txq = dev->data->tx_queues[i];
+			if (txq == NULL)
+				continue;
+			if (idpf_tx_path_infos[ad->tx_func_type].features.simd_width ==
+					RTE_VECT_SIMD_512)
+				idpf_qc_tx_vec_avx512_setup(txq);
 		}
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
 	}
+#endif /* CC_AVX512_SUPPORT */
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
 
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index eff04a83eb..b31ae0bd5f 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -164,8 +164,6 @@ struct idpf_vport {
 
 	uint16_t devarg_id;
 
-	bool tx_vec_allowed;
-
 	struct virtchnl2_vport_stats eth_stats_offset;
 
 	/* Event from ipf */
-- 
2.43.0

