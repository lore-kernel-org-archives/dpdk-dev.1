Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B3C2D0CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 06:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6681402C2;
	Thu, 15 May 2025 08:21:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B272E402B3
 for <dev@dpdk.org>; Thu, 15 May 2025 08:20:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747290060; x=1778826060;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gpu1+Cl4xmO68y57P9aA3IgXCCJz37jqyORN0PKmlJ4=;
 b=YncYAo5kTG4dyZw5zJqz76lKZqXO7l+EniybuuOfq7uojIMIR3aqr2gq
 3buJReiqvCS2dMKUjPaDy4B499K+6Sobze2b2REXVr9M71nOpyozvd58u
 An9WCIePB+ytoWbKmrVrbBsJhAG1uhcPge8U28O2JRegt2fUiEqxUERPz
 rqcI/X6qNDE8zoLArYx2wBcBwRsMII6IIjfMJ6RSVlyX94qI4czRLKZjr
 Uv2WzKzzsUHeSOyOXFQ+WNuI53GJjm7JQWGzmBxctPnnYJxmaBGOgmntI
 lTncw9xN7PWaL6o02+3EjaHBMr2cfQ/61lNq6VOUDsOFH073E6HwouPWz A==;
X-CSE-ConnectionGUID: I8cR/squSWOQOl9HlWfSnA==
X-CSE-MsgGUID: blVcqKlLTmKkGOMMpy5Nmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49372720"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="49372720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 23:20:58 -0700
X-CSE-ConnectionGUID: HMNRY8VURpWe5Y/boq70fA==
X-CSE-MsgGUID: 1N7EclzqRKSGqVmPOmk6yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="138139112"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa010.jf.intel.com with ESMTP; 14 May 2025 23:20:57 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2] net/intel: reduce size of common Tx queue struct
Date: Thu, 15 May 2025 11:51:30 +0530
Message-Id: <20250515062130.1396060-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514125733.1364644-1-shaiq.wani@intel.com>
References: <20250514125733.1364644-1-shaiq.wani@intel.com>
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

Removed redundant and unused fields from the idpf pmd specific field
in common Tx queue structure to reduce its memory footprint.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/common/tx.h                 |  6 +--
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  6 ---
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 13 +------
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 34 ++---------------
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  7 ----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 37 +++----------------
 drivers/net/intel/idpf/idpf_rxtx.c            |  9 +----
 7 files changed, 13 insertions(+), 99 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index c99bd5420f..b0a68bae44 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -106,16 +106,12 @@ struct ci_tx_queue {
 						struct idpf_flex_tx_sched_desc *desc_ring;
 						struct idpf_splitq_tx_compl_desc *compl_ring;
 				};
-				const struct idpf_txq_ops *idpf_ops;
 				struct ci_tx_queue *complq;
 				void **txqs;   /*only valid for split queue mode*/
-				bool q_started;   /* if tx queue has been started */
-				/* only valid for split queue mode */
 				uint32_t tx_start_qid;
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
-#define IDPF_TX_CTYPE_NUM	8
-				uint16_t ctype[IDPF_TX_CTYPE_NUM];
+				uint16_t rs_compl_count;
 				uint8_t expected_gen_id;
 		};
 	};
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index c94010bc51..6d7b23ad7a 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -958,8 +958,6 @@ cpfl_start_queues(struct rte_eth_dev *dev)
 			if (err)
 				PMD_DRV_LOG(ERR, "Failed to switch hairpin TX queue %u on",
 					    i);
-			else
-				cpfl_txq->base.q_started = true;
 		}
 	}
 
@@ -1273,7 +1271,6 @@ cpfl_hairpin_bind(struct rte_eth_dev *dev, uint16_t rx_port)
 				    i);
 			return err;
 		}
-		cpfl_txq->base.q_started = true;
 	}
 
 	err = cpfl_switch_hairpin_complq(cpfl_tx_vport, true);
@@ -1309,17 +1306,14 @@ cpfl_hairpin_unbind(struct rte_eth_dev *dev, uint16_t rx_port)
 	struct cpfl_vport *cpfl_tx_vport = dev->data->dev_private;
 	struct rte_eth_dev *peer_dev = &rte_eth_devices[rx_port];
 	struct cpfl_vport *cpfl_rx_vport = peer_dev->data->dev_private;
-	struct cpfl_tx_queue *cpfl_txq;
 	struct cpfl_rx_queue *cpfl_rxq;
 	int i;
 
 	/* disable hairpin queues */
 	for (i = cpfl_tx_vport->nb_data_txq; i < dev->data->nb_tx_queues; i++) {
-		cpfl_txq = dev->data->tx_queues[i];
 		cpfl_switch_hairpin_rxtx_queue(cpfl_tx_vport,
 					       i - cpfl_tx_vport->nb_data_txq,
 					       false, false);
-		cpfl_txq->base.q_started = false;
 	}
 
 	cpfl_switch_hairpin_complq(cpfl_tx_vport, false);
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index eba0fcbb07..02e81f7f34 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -115,10 +115,6 @@ static const struct idpf_rxq_ops def_rxq_ops = {
 	.release_mbufs = idpf_qc_rxq_mbufs_release,
 };
 
-static const struct idpf_txq_ops def_txq_ops = {
-	.release_mbufs = idpf_qc_txq_mbufs_release,
-};
-
 static const struct rte_memzone *
 cpfl_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		      uint16_t len, uint16_t queue_type,
@@ -332,7 +328,7 @@ cpfl_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->idpf_ops->release_mbufs(q);
+	ci_txq_release_all_mbufs(q, q->vector_tx);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_txq);
@@ -613,7 +609,6 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->idpf_ops = &def_txq_ops;
 	cpfl_vport->nb_data_txq++;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = cpfl_txq;
@@ -868,8 +863,6 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->qtx_tail = hw->hw_addr +
 		cpfl_hw_qtail_get(cpfl_vport->p2p_q_chunks_info->tx_qtail_start,
 				  logic_qid, cpfl_vport->p2p_q_chunks_info->tx_qtail_spacing);
-	txq->idpf_ops = &def_txq_ops;
-
 	if (cpfl_vport->p2p_tx_complq == NULL) {
 		cq = rte_zmalloc_socket("cpfl hairpin cq",
 					sizeof(struct ci_tx_queue),
@@ -1259,7 +1252,6 @@ cpfl_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		PMD_DRV_LOG(ERR, "Failed to switch TX queue %u on",
 			    tx_queue_id);
 	} else {
-		cpfl_txq->base.q_started = true;
 		dev->data->tx_queue_state[tx_queue_id] =
 			RTE_ETH_QUEUE_STATE_STARTED;
 	}
@@ -1343,8 +1335,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = &cpfl_txq->base;
-	txq->q_started = false;
-	txq->idpf_ops->release_mbufs(txq);
+	ci_txq_release_all_mbufs(txq, txq->vector_tx);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a734637a39..eb25b091d8 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -93,32 +93,6 @@ idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_txq_mbufs_release)
-void
-idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq)
-{
-	uint16_t nb_desc, i;
-
-	if (txq == NULL || txq->sw_ring == NULL) {
-		DRV_LOG(DEBUG, "Pointer to rxq or sw_ring is NULL");
-		return;
-	}
-
-	if (txq->sw_nb_desc != 0) {
-		/* For split queue model, descriptor ring */
-		nb_desc = txq->sw_nb_desc;
-	} else {
-		/* For single queue model */
-		nb_desc = txq->nb_tx_desc;
-	}
-	for (i = 0; i < nb_desc; i++) {
-		if (txq->sw_ring[i].mbuf != NULL) {
-			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
-			txq->sw_ring[i].mbuf = NULL;
-		}
-	}
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_descq_reset)
 void
 idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq)
@@ -250,7 +224,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	txq->sw_tail = 0;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
-	memset(txq->ctype, 0, sizeof(txq->ctype));
+	txq->rs_compl_count = 0;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
@@ -357,7 +331,7 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->idpf_ops->release_mbufs(q);
+	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
@@ -893,7 +867,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	uint8_t cmd_dtype;
 	uint16_t nb_ctx;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
 	txr = txq->desc_ring;
@@ -1390,7 +1364,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_tx = 0;
 	txq = tx_queue;
 
-	if (unlikely(txq == NULL) || unlikely(!txq->q_started))
+	if (unlikely(txq == NULL))
 		return nb_tx;
 
 	sw_ring = txq->sw_ring;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index fc68dddc90..f84a760334 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -57,7 +57,6 @@
 #define IDPF_VPMD_DESCS_PER_LOOP	4
 #define IDPF_RXQ_REARM_THRESH		64
 #define IDPD_TXQ_SCAN_CQ_THRESH	64
-#define IDPF_TX_CTYPE_NUM	8
 
 /* MTS */
 #define GLTSYN_CMD_SYNC_0_0	(PF_TIMESYNC_BASE + 0x0)
@@ -171,10 +170,6 @@ struct idpf_rxq_ops {
 	void (*release_mbufs)(struct idpf_rx_queue *rxq);
 };
 
-struct idpf_txq_ops {
-	void (*release_mbufs)(struct ci_tx_queue *txq);
-};
-
 extern int idpf_timestamp_dynfield_offset;
 extern uint64_t idpf_timestamp_dynflag;
 
@@ -186,8 +181,6 @@ int idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 __rte_internal
 void idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq);
 __rte_internal
-void idpf_qc_txq_mbufs_release(struct ci_tx_queue *txq);
-__rte_internal
 void idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_split_rx_bufq_reset(struct idpf_rx_queue *rxq);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 15b4c8a68e..06e73c8725 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1192,7 +1192,8 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 		txq_qid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
 			IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
 		txq = cq->txqs[txq_qid - cq->tx_start_qid];
-		txq->ctype[ctype]++;
+		if (ctype == IDPF_TXD_COMPLT_RS)
+			txq->rs_compl_count++;
 		cq_qid++;
 	}
 
@@ -1342,9 +1343,9 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 		uint16_t ret, num;
 		idpf_splitq_scan_cq_ring(txq->complq);
 
-		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->tx_free_thresh) {
+		if (txq->rs_compl_count > txq->tx_free_thresh) {
 			ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
-			txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->tx_rs_thresh;
+			txq->rs_compl_count -= txq->tx_rs_thresh;
 		}
 
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
@@ -1368,34 +1369,6 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return idpf_splitq_xmit_pkts_vec_avx512_cmn(tx_queue, tx_pkts, nb_pkts);
 }
 
-static inline void
-idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
-{
-	unsigned int i;
-	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
-	struct ci_tx_entry_vec *swr = (void *)txq->sw_ring;
-
-	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
-		return;
-
-	i = txq->tx_next_dd - txq->tx_rs_thresh + 1;
-	if (txq->tx_tail < i) {
-		for (; i < txq->nb_tx_desc; i++) {
-			rte_pktmbuf_free_seg(swr[i].mbuf);
-			swr[i].mbuf = NULL;
-		}
-		i = 0;
-	}
-	for (; i < txq->tx_tail; i++) {
-		rte_pktmbuf_free_seg(swr[i].mbuf);
-		swr[i].mbuf = NULL;
-	}
-}
-
-static const struct idpf_txq_ops avx512_tx_vec_ops = {
-	.release_mbufs = idpf_tx_release_mbufs_avx512,
-};
-
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
 int __rte_cold
 idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
@@ -1403,6 +1376,6 @@ idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 	if (!txq)
 		return 0;
 
-	txq->idpf_ops = &avx512_tx_vec_ops;
+	txq->vector_tx = true;
 	return 0;
 }
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index bf190b02ee..5510cbd30a 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -54,10 +54,6 @@ static const struct idpf_rxq_ops def_rxq_ops = {
 	.release_mbufs = idpf_qc_rxq_mbufs_release,
 };
 
-static const struct idpf_txq_ops def_txq_ops = {
-	.release_mbufs = idpf_qc_txq_mbufs_release,
-};
-
 static const struct rte_memzone *
 idpf_dma_zone_reserve(struct rte_eth_dev *dev, uint16_t queue_idx,
 		      uint16_t len, uint16_t queue_type,
@@ -486,7 +482,6 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->idpf_ops = &def_txq_ops;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
 
@@ -652,7 +647,6 @@ idpf_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		PMD_DRV_LOG(ERR, "Failed to switch TX queue %u on",
 			    tx_queue_id);
 	} else {
-		txq->q_started = true;
 		dev->data->tx_queue_state[tx_queue_id] =
 			RTE_ETH_QUEUE_STATE_STARTED;
 	}
@@ -712,8 +706,7 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = dev->data->tx_queues[tx_queue_id];
-	txq->q_started = false;
-	txq->idpf_ops->release_mbufs(txq);
+	ci_txq_release_all_mbufs(txq, false);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
-- 
2.34.1

