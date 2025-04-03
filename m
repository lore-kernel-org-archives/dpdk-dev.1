Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA6C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 11:23:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 038F840BA0;
	Thu,  3 Apr 2025 13:23:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 218E440B97
 for <dev@dpdk.org>; Thu,  3 Apr 2025 13:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743679403; x=1775215403;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=C9n/fLCwalT7ipud7/SYynuDk07tq56qEyCBCyhSwdc=;
 b=b50cn38oqMTJLw34+M14dI97Aiu+2X4A+ipl/m52Sl4fpGEfXTKPPUm0
 JLbvfaaU9NDWwlDjI0TBZcSt2sUpuwp6xevk1b+gg8oaNZ8IcaMqYxmah
 IHMDafPGnE8oZQHJuvRu4wqtS6io1RPEK+hI1vv9jgu9nubCiMi+YeOKq
 PkffOa4J10po0UzL8jkQrLWirSmqsTE1zcv24AoWnjVbcbmJsiUwJeiGX
 c3giuZ/qvHzhJ3y4SQrmrgV/pxPZBnV+Ae+ZnBc/usZAd2vvb5UcHcbUO
 iepHMQKss1bIA0Uev7lqfB0qGhJ/ISbs9qWj//w+YhgkXIgsGwxsxq8dy w==;
X-CSE-ConnectionGUID: qKI4ID+iQhaW0CQGHzGH7g==
X-CSE-MsgGUID: p6l/v2TzRUqmyNmNOZ+EEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45257315"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="45257315"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 04:23:23 -0700
X-CSE-ConnectionGUID: iF9Xy54PRNmFMxDiE8XwRA==
X-CSE-MsgGUID: xNJ4tq4zTDekzshh1V+ICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="127833206"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa009.fm.intel.com with ESMTP; 03 Apr 2025 04:23:21 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 1/4] net/intel: align Tx queue struct field names
Date: Thu,  3 Apr 2025 16:54:26 +0530
Message-Id: <20250403112429.2741138-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403112429.2741138-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250403112429.2741138-1-shaiq.wani@intel.com>
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

Align the Tx queue struct field names in idpf and
cpfl driver with the common Tx queue struct.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c            | 40 ++++-----
 drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  4 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 72 ++++++++--------
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 21 ++---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 44 +++++-----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 84 +++++++++----------
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  6 +-
 drivers/net/intel/idpf/idpf_rxtx.c            | 24 +++---
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  4 +-
 9 files changed, 150 insertions(+), 149 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 47351ca102..8eed8f16d5 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -249,7 +249,7 @@ cpfl_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	idpf_qc_split_rx_bufq_reset(bufq);
 	bufq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_buf_qtail_start +
 			 queue_idx * vport->chunks_info.rx_buf_qtail_spacing);
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 	bufq->q_set = true;
 
 	if (bufq_id == IDPF_RX_SPLIT_BUFQ1_ID) {
@@ -310,7 +310,7 @@ cpfl_rx_queue_release(void *rxq)
 	}
 
 	/* Single queue */
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_rxq);
@@ -332,7 +332,7 @@ cpfl_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(cpfl_txq);
@@ -426,7 +426,7 @@ cpfl_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_rx_queue_reset(rxq);
 		rxq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_qtail_start +
 				queue_idx * vport->chunks_info.rx_qtail_spacing);
-		rxq->ops = &def_rxq_ops;
+		rxq->idpf_ops = &def_rxq_ops;
 	} else {
 		idpf_qc_split_rx_descq_reset(rxq);
 
@@ -501,7 +501,7 @@ cpfl_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	cq->tx_ring_phys_addr = mz->iova;
+	cq->tx_ring_dma = mz->iova;
 	cq->compl_ring = mz->addr;
 	cq->mz = mz;
 	idpf_qc_split_tx_complq_reset(cq);
@@ -565,8 +565,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	is_splitq = !!(vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 	txq->nb_tx_desc = nb_desc;
-	txq->rs_thresh = tx_rs_thresh;
-	txq->free_thresh = tx_free_thresh;
+	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
 	txq->offloads = cpfl_tx_offload_convert(offloads);
@@ -585,7 +585,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
@@ -598,7 +598,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->tx_ring = mz->addr;
+		txq->idpf_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
@@ -613,7 +613,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 	cpfl_vport->nb_data_txq++;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = cpfl_txq;
@@ -663,7 +663,7 @@ cpfl_rx_hairpin_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *bufq,
 	bufq->rx_buf_len = CPFL_P2P_MBUF_SIZE - RTE_PKTMBUF_HEADROOM;
 
 	bufq->q_set = true;
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 
 	return 0;
 }
@@ -860,7 +860,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		goto err_txq_mz_rsv;
 	}
 
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->desc_ring = mz->addr;
 	txq->mz = mz;
 
@@ -868,7 +868,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->qtx_tail = hw->hw_addr +
 		cpfl_hw_qtail_get(cpfl_vport->p2p_q_chunks_info->tx_qtail_start,
 				  logic_qid, cpfl_vport->p2p_q_chunks_info->tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 
 	if (cpfl_vport->p2p_tx_complq == NULL) {
 		cq = rte_zmalloc_socket("cpfl hairpin cq",
@@ -898,7 +898,7 @@ cpfl_tx_hairpin_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			ret = -ENOMEM;
 			goto err_cq_mz_rsv;
 		}
-		cq->tx_ring_phys_addr = mz->iova;
+		cq->tx_ring_dma = mz->iova;
 		cq->compl_ring = mz->addr;
 		cq->mz = mz;
 
@@ -979,7 +979,7 @@ cpfl_hairpin_tx_complq_config(struct cpfl_vport *cpfl_vport)
 
 	memset(&txq_info, 0, sizeof(txq_info));
 
-	txq_info.dma_ring_addr = tx_complq->tx_ring_phys_addr;
+	txq_info.dma_ring_addr = tx_complq->tx_ring_dma;
 	txq_info.type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 	txq_info.queue_id = tx_complq->queue_id;
 	txq_info.ring_len = tx_complq->nb_tx_desc;
@@ -998,7 +998,7 @@ cpfl_hairpin_txq_config(struct idpf_vport *vport, struct cpfl_tx_queue *cpfl_txq
 
 	memset(&txq_info, 0, sizeof(txq_info));
 
-	txq_info.dma_ring_addr = txq->tx_ring_phys_addr;
+	txq_info.dma_ring_addr = txq->tx_ring_dma;
 	txq_info.type = VIRTCHNL2_QUEUE_TYPE_TX;
 	txq_info.queue_id = txq->queue_id;
 	txq_info.ring_len = txq->nb_tx_desc;
@@ -1296,12 +1296,12 @@ cpfl_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	rxq = &cpfl_rxq->base;
 	rxq->q_started = false;
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		rxq->ops->release_mbufs(rxq);
+		rxq->idpf_ops->release_mbufs(rxq);
 		idpf_qc_single_rx_queue_reset(rxq);
 	} else {
-		rxq->bufq1->ops->release_mbufs(rxq->bufq1);
+		rxq->bufq1->idpf_ops->release_mbufs(rxq->bufq1);
 		if (rxq->bufq2)
-			rxq->bufq2->ops->release_mbufs(rxq->bufq2);
+			rxq->bufq2->idpf_ops->release_mbufs(rxq->bufq2);
 		if (cpfl_rxq->hairpin_info.hairpin_q) {
 			cpfl_rx_hairpin_descq_reset(rxq);
 			cpfl_rx_hairpin_bufq_reset(rxq->bufq1);
@@ -1344,7 +1344,7 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = &cpfl_txq->base;
 	txq->q_started = false;
-	txq->ops->release_mbufs(txq);
+	txq->idpf_ops->release_mbufs(txq);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
index 5b98f86932..caf02295a3 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h
@@ -54,8 +54,8 @@ cpfl_tx_vec_queue_default(struct idpf_tx_queue *txq)
 	if (txq == NULL)
 		return CPFL_SCALAR_PATH;
 
-	if (txq->rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
-	    (txq->rs_thresh & 3) != 0)
+	if (txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
+	    (txq->tx_rs_thresh & 3) != 0)
 		return CPFL_SCALAR_PATH;
 
 	if ((txq->offloads & CPFL_TX_NO_VECTOR_FLAGS) != 0)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 7171e27b8d..df16aa3f06 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -233,16 +233,16 @@ idpf_qc_split_tx_descq_reset(struct idpf_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_used = 0;
+	txq->nb_tx_used = 0;
 
 	/* Use this as next to clean for split desc queue */
 	txq->last_desc_cleaned = 0;
 	txq->sw_tail = 0;
-	txq->nb_free = txq->nb_tx_desc - 1;
+	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
 	memset(txq->ctype, 0, sizeof(txq->ctype));
-	txq->next_dd = txq->rs_thresh - 1;
-	txq->next_rs = txq->rs_thresh - 1;
+	txq->tx_next_dd = txq->tx_rs_thresh - 1;
+	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
 void
@@ -278,11 +278,11 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 	txe = txq->sw_ring;
 	size = sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
-		((volatile char *)txq->tx_ring)[i] = 0;
+		((volatile char *)txq->idpf_tx_ring)[i] = 0;
 
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		txq->tx_ring[i].qw1 =
+		txq->idpf_tx_ring[i].qw1 =
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
 		txe[i].mbuf =  NULL;
 		txe[i].last_id = i;
@@ -291,13 +291,13 @@ idpf_qc_single_tx_queue_reset(struct idpf_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_used = 0;
+	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = txq->nb_tx_desc - 1;
-	txq->nb_free = txq->nb_tx_desc - 1;
+	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
-	txq->next_dd = txq->rs_thresh - 1;
-	txq->next_rs = txq->rs_thresh - 1;
+	txq->tx_next_dd = txq->tx_rs_thresh - 1;
+	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
 void
@@ -310,11 +310,11 @@ idpf_qc_rx_queue_release(void *rxq)
 
 	/* Split queue */
 	if (!q->adapter->is_rx_singleq) {
-		q->bufq1->ops->release_mbufs(q->bufq1);
+		q->bufq1->idpf_ops->release_mbufs(q->bufq1);
 		rte_free(q->bufq1->sw_ring);
 		rte_memzone_free(q->bufq1->mz);
 		rte_free(q->bufq1);
-		q->bufq2->ops->release_mbufs(q->bufq2);
+		q->bufq2->idpf_ops->release_mbufs(q->bufq2);
 		rte_free(q->bufq2->sw_ring);
 		rte_memzone_free(q->bufq2->mz);
 		rte_free(q->bufq2);
@@ -324,7 +324,7 @@ idpf_qc_rx_queue_release(void *rxq)
 	}
 
 	/* Single queue */
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
@@ -343,7 +343,7 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
-	q->ops->release_mbufs(q);
+	q->idpf_ops->release_mbufs(q);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
 	rte_free(q);
@@ -789,7 +789,7 @@ idpf_split_tx_free(struct idpf_tx_queue *cq)
 				q_head;
 		else
 			nb_desc_clean = q_head - txq->last_desc_cleaned;
-		txq->nb_free += nb_desc_clean;
+		txq->nb_tx_free += nb_desc_clean;
 		txq->last_desc_cleaned = q_head;
 		break;
 	case IDPF_TXD_COMPLT_RS:
@@ -886,7 +886,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
 
-		if (txq->nb_free <= txq->free_thresh) {
+		if (txq->nb_tx_free <= txq->tx_free_thresh) {
 			/* TODO: Need to refine
 			 * 1. free and clean: Better to decide a clean destination instead of
 			 * loop times. And don't free mbuf when RS got immediately, free when
@@ -895,12 +895,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 * 2. out-of-order rewrite back haven't be supported, SW head and HW head
 			 * need to be separated.
 			 **/
-			nb_to_clean = 2 * txq->rs_thresh;
+			nb_to_clean = 2 * txq->tx_rs_thresh;
 			while (nb_to_clean--)
 				idpf_split_tx_free(txq->complq);
 		}
 
-		if (txq->nb_free < tx_pkt->nb_segs)
+		if (txq->nb_tx_free < tx_pkt->nb_segs)
 			break;
 
 		cmd_dtype = 0;
@@ -953,13 +953,13 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
-		txq->nb_free = (uint16_t)(txq->nb_free - nb_used);
-		txq->nb_used = (uint16_t)(txq->nb_used + nb_used);
+		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
+		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 
-		if (txq->nb_used >= 32) {
+		if (txq->nb_tx_used >= 32) {
 			txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			/* Update txq RE bit counters */
-			txq->nb_used = 0;
+			txq->nb_tx_used = 0;
 		}
 	}
 
@@ -1310,9 +1310,9 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
 
-	volatile struct idpf_base_tx_desc *txd = txq->tx_ring;
+	volatile struct idpf_base_tx_desc *txd = txq->idpf_tx_ring;
 
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->rs_thresh);
+	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
 	if (desc_to_clean_to >= nb_tx_desc)
 		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
 
@@ -1336,7 +1336,7 @@ idpf_xmit_cleanup(struct idpf_tx_queue *txq)
 	txd[desc_to_clean_to].qw1 = 0;
 
 	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_free = (uint16_t)(txq->nb_free + nb_tx_to_clean);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
 
 	return 0;
 }
@@ -1372,12 +1372,12 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	sw_ring = txq->sw_ring;
-	txr = txq->tx_ring;
+	txr = txq->idpf_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
 	/* Check if the descriptor ring needs to be cleaned. */
-	if (txq->nb_free < txq->free_thresh)
+	if (txq->nb_tx_free < txq->tx_free_thresh)
 		(void)idpf_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
@@ -1410,14 +1410,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		       " tx_first=%u tx_last=%u",
 		       txq->port_id, txq->queue_id, tx_id, tx_last);
 
-		if (nb_used > txq->nb_free) {
+		if (nb_used > txq->nb_tx_free) {
 			if (idpf_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
 				goto end_of_tx;
 			}
-			if (unlikely(nb_used > txq->rs_thresh)) {
-				while (nb_used > txq->nb_free) {
+			if (unlikely(nb_used > txq->tx_rs_thresh)) {
+				while (nb_used > txq->nb_tx_free) {
 					if (idpf_xmit_cleanup(txq) != 0) {
 						if (nb_tx == 0)
 							return 0;
@@ -1479,10 +1479,10 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		/* The last packet data descriptor needs End Of Packet (EOP) */
 		td_cmd |= IDPF_TX_DESC_CMD_EOP;
-		txq->nb_used = (uint16_t)(txq->nb_used + nb_used);
-		txq->nb_free = (uint16_t)(txq->nb_free - nb_used);
+		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
+		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-		if (txq->nb_used >= txq->rs_thresh) {
+		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
 			TX_LOG(DEBUG, "Setting RS bit on TXD id="
 			       "%4u (port=%d queue=%d)",
 			       tx_last, txq->port_id, txq->queue_id);
@@ -1490,7 +1490,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			td_cmd |= IDPF_TX_DESC_CMD_RS;
 
 			/* Update txq RS bit counters */
-			txq->nb_used = 0;
+			txq->nb_tx_used = 0;
 		}
 
 		txd->qw1 |= rte_cpu_to_le_16(td_cmd << IDPF_TXD_QW1_CMD_S);
@@ -1613,13 +1613,13 @@ idpf_rxq_vec_setup_default(struct idpf_rx_queue *rxq)
 int __rte_cold
 idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
-	rxq->ops = &def_rx_ops_vec;
+	rxq->idpf_ops = &def_rx_ops_vec;
 	return idpf_rxq_vec_setup_default(rxq);
 }
 
 int __rte_cold
 idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
-	rxq->bufq2->ops = &def_rx_ops_vec;
+	rxq->bufq2->idpf_ops = &def_rx_ops_vec;
 	return idpf_rxq_vec_setup_default(rxq->bufq2);
 }
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index e19e1878f3..84c05cfaac 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -135,7 +135,7 @@ struct idpf_rx_queue {
 	bool q_set;             /* if rx queue has been configured */
 	bool q_started;         /* if rx queue has been started */
 	bool rx_deferred_start; /* don't start this queue in dev start */
-	const struct idpf_rxq_ops *ops;
+	const struct idpf_rxq_ops *idpf_ops;
 
 	struct idpf_rx_stats rx_stats;
 
@@ -157,34 +157,35 @@ struct idpf_tx_entry {
 /* Structure associated with each TX queue. */
 struct idpf_tx_queue {
 	const struct rte_memzone *mz;		/* memzone for Tx ring */
-	volatile struct idpf_base_tx_desc *tx_ring;	/* Tx ring virtual address */
+	volatile struct idpf_base_tx_desc *idpf_tx_ring;	/* Tx ring virtual address */
 	volatile union {
 		struct idpf_flex_tx_sched_desc *desc_ring;
 		struct idpf_splitq_tx_compl_desc *compl_ring;
 	};
-	uint64_t tx_ring_phys_addr;		/* Tx ring DMA address */
+	rte_iova_t tx_ring_dma;		/* Tx ring DMA address */
 	struct idpf_tx_entry *sw_ring;		/* address array of SW ring */
 
 	uint16_t nb_tx_desc;		/* ring length */
 	uint16_t tx_tail;		/* current value of tail */
 	volatile uint8_t *qtx_tail;	/* register address of tail */
 	/* number of used desc since RS bit set */
-	uint16_t nb_used;
-	uint16_t nb_free;
+	uint16_t nb_tx_used;
+	uint16_t nb_tx_free;
 	uint16_t last_desc_cleaned;	/* last desc have been cleaned*/
-	uint16_t free_thresh;
-	uint16_t rs_thresh;
+	uint16_t tx_free_thresh;
+
+	uint16_t tx_rs_thresh;
 
 	uint16_t port_id;
 	uint16_t queue_id;
 	uint64_t offloads;
-	uint16_t next_dd;	/* next to set RS, for VPMD */
-	uint16_t next_rs;	/* next to check DD,  for VPMD */
+	uint16_t tx_next_dd;	/* next to set RS, for VPMD */
+	uint16_t tx_next_rs;	/* next to check DD,  for VPMD */
 
 	bool q_set;		/* if tx queue has been configured */
 	bool q_started;		/* if tx queue has been started */
 	bool tx_deferred_start; /* don't start this queue in dev start */
-	const struct idpf_txq_ops *ops;
+	const struct idpf_txq_ops *idpf_ops;
 
 	/* only valid for split queue mode */
 	uint16_t sw_nb_desc;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 43a95466ae..ba97003779 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -496,20 +496,20 @@ idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
 	/* check DD bits on threshold descriptor */
-	if ((txq->tx_ring[txq->next_dd].qw1 &
+	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
-	n = txq->rs_thresh;
+	n = txq->tx_rs_thresh;
 
 	 /* first buffer to free from S/W ring is at index
-	  * next_dd - (rs_thresh-1)
+	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
-	txep = &txq->sw_ring[txq->next_dd - (n - 1)];
+	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
@@ -538,12 +538,12 @@ idpf_singleq_tx_free_bufs_vec(struct idpf_tx_queue *txq)
 	}
 
 	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
 
-	return txq->rs_thresh;
+	return txq->tx_rs_thresh;
 }
 
 static inline void
@@ -627,20 +627,20 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	if (txq->nb_free < txq->free_thresh)
+	if (txq->nb_tx_free < txq->tx_free_thresh)
 		idpf_singleq_tx_free_bufs_vec(txq);
 
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->tx_ring[tx_id];
+	txdp = &txq->idpf_tx_ring[tx_id];
 	txep = &txq->sw_ring[tx_id];
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
@@ -655,10 +655,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->tx_ring[tx_id];
+		txdp = &txq->idpf_tx_ring[tx_id];
 		txep = &txq->sw_ring[tx_id];
 	}
 
@@ -667,12 +667,12 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs) {
-		txq->tx_ring[txq->next_rs].qw1 |=
+	if (tx_id > txq->tx_next_rs) {
+		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
 
 	txq->tx_tail = tx_id;
@@ -692,7 +692,7 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	while (nb_pkts) {
 		uint16_t ret, num;
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_singleq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx],
 						    num);
 		nb_tx += ret;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index b630d1fcd9..d2f82ab3f5 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -1003,21 +1003,21 @@ idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
 	/* check DD bits on threshold descriptor */
-	if ((txq->tx_ring[txq->next_dd].qw1 &
+	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
 			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
 			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
-	n = txq->rs_thresh;
+	n = txq->tx_rs_thresh;
 
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
 	txep = (void *)txq->sw_ring;
-	txep += txq->next_dd - (n - 1);
+	txep += txq->tx_next_dd - (n - 1);
 
 	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
 		struct rte_mempool *mp = txep[0].mbuf->pool;
@@ -1103,12 +1103,12 @@ idpf_tx_singleq_free_bufs_avx512(struct idpf_tx_queue *txq)
 
 done:
 	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
 
-	return txq->rs_thresh;
+	return txq->tx_rs_thresh;
 }
 
 static __rte_always_inline void
@@ -1201,22 +1201,22 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	if (txq->nb_free < txq->free_thresh)
+	if (txq->nb_tx_free < txq->tx_free_thresh)
 		idpf_tx_singleq_free_bufs_avx512(txq);
 
-	nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	nb_commit = nb_pkts;
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
 	tx_id = txq->tx_tail;
-	txdp = &txq->tx_ring[tx_id];
+	txdp = &txq->idpf_tx_ring[tx_id];
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
@@ -1231,10 +1231,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
-		txdp = &txq->tx_ring[tx_id];
+		txdp = &txq->idpf_tx_ring[tx_id];
 		txep = (void *)txq->sw_ring;
 		txep += tx_id;
 	}
@@ -1244,12 +1244,12 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs) {
-		txq->tx_ring[txq->next_rs].qw1 |=
+	if (tx_id > txq->tx_next_rs) {
+		txq->idpf_tx_ring[txq->tx_next_rs].qw1 |=
 			rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
 					 IDPF_TXD_QW1_CMD_S);
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 	}
 
 	txq->tx_tail = tx_id;
@@ -1269,7 +1269,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 	while (nb_pkts) {
 		uint16_t ret, num;
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_singleq_xmit_fixed_burst_vec_avx512(tx_queue, &tx_pkts[nb_tx],
 						       num);
 		nb_tx += ret;
@@ -1328,15 +1328,15 @@ idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
 	uint32_t i;
 	int nb_free = 0;
 	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->rs_thresh);
+	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
 
-	n = txq->rs_thresh;
+	n = txq->tx_rs_thresh;
 
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
 	txep = (void *)txq->sw_ring;
-	txep += txq->next_dd - (n - 1);
+	txep += txq->tx_next_dd - (n - 1);
 
 	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
 		struct rte_mempool *mp = txep[0].mbuf->pool;
@@ -1415,13 +1415,13 @@ idpf_tx_splitq_free_bufs_avx512(struct idpf_tx_queue *txq)
 
 done:
 	/* buffers were freed, update counters */
-	txq->nb_free = (uint16_t)(txq->nb_free + txq->rs_thresh);
-	txq->next_dd = (uint16_t)(txq->next_dd + txq->rs_thresh);
-	if (txq->next_dd >= txq->nb_tx_desc)
-		txq->next_dd = (uint16_t)(txq->rs_thresh - 1);
-	txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->rs_thresh;
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+	txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->tx_rs_thresh;
 
-	return txq->rs_thresh;
+	return txq->tx_rs_thresh;
 }
 
 #define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S	48
@@ -1506,9 +1506,9 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	tx_id = txq->tx_tail;
 
 	/* cross rx_thresh boundary is not allowed */
-	nb_pkts = RTE_MIN(nb_pkts, txq->rs_thresh);
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
-	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_free, nb_pkts);
+	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
@@ -1517,7 +1517,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	txep = (void *)txq->sw_ring;
 	txep += tx_id;
 
-	txq->nb_free = (uint16_t)(txq->nb_free - nb_pkts);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
@@ -1532,7 +1532,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 		nb_commit = (uint16_t)(nb_commit - n);
 
 		tx_id = 0;
-		txq->next_rs = (uint16_t)(txq->rs_thresh - 1);
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 		/* avoid reach the end of ring */
 		txdp = &txq->desc_ring[tx_id];
@@ -1545,9 +1545,9 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 	idpf_splitq_vtx(txdp, tx_pkts, nb_commit, cmd_dtype);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
-	if (tx_id > txq->next_rs)
-		txq->next_rs =
-			(uint16_t)(txq->next_rs + txq->rs_thresh);
+	if (tx_id > txq->tx_next_rs)
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
 
 	txq->tx_tail = tx_id;
 
@@ -1568,10 +1568,10 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 		idpf_splitq_scan_cq_ring(txq->complq);
 
-		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->free_thresh)
+		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->tx_free_thresh)
 			idpf_tx_splitq_free_bufs_avx512(txq);
 
-		num = (uint16_t)RTE_MIN(nb_pkts, txq->rs_thresh);
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_splitq_xmit_fixed_burst_vec_avx512(tx_queue,
 							      &tx_pkts[nb_tx],
 							      num);
@@ -1598,10 +1598,10 @@ idpf_tx_release_mbufs_avx512(struct idpf_tx_queue *txq)
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
 	struct idpf_tx_vec_entry *swr = (void *)txq->sw_ring;
 
-	if (txq->sw_ring == NULL || txq->nb_free == max_desc)
+	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
 		return;
 
-	i = txq->next_dd - txq->rs_thresh + 1;
+	i = txq->tx_next_dd - txq->tx_rs_thresh + 1;
 	if (txq->tx_tail < i) {
 		for (; i < txq->nb_tx_desc; i++) {
 			rte_pktmbuf_free_seg(swr[i].mbuf);
@@ -1625,6 +1625,6 @@ idpf_qc_tx_vec_avx512_setup(struct idpf_tx_queue *txq)
 	if (!txq)
 		return 0;
 
-	txq->ops = &avx512_tx_vec_ops;
+	txq->idpf_ops = &avx512_tx_vec_ops;
 	return 0;
 }
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index 0ae1d55d79..af81680825 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -1101,7 +1101,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		txq_info = &vc_txqs->qinfo[0];
-		txq_info->dma_ring_addr = txq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX;
 		txq_info->queue_id = txq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SINGLE;
@@ -1110,7 +1110,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 	} else {
 		/* txq info */
 		txq_info = &vc_txqs->qinfo[0];
-		txq_info->dma_ring_addr = txq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX;
 		txq_info->queue_id = txq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SPLIT;
@@ -1121,7 +1121,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct idpf_tx_queue *txq)
 
 		/* tx completion queue info */
 		txq_info = &vc_txqs->qinfo[1];
-		txq_info->dma_ring_addr = txq->complq->tx_ring_phys_addr;
+		txq_info->dma_ring_addr = txq->complq->tx_ring_dma;
 		txq_info->type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 		txq_info->queue_id = txq->complq->queue_id;
 		txq_info->model = VIRTCHNL2_QUEUE_MODEL_SPLIT;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 0c3ecd2765..95b112c95c 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -187,7 +187,7 @@ idpf_rx_split_bufq_setup(struct rte_eth_dev *dev, struct idpf_rx_queue *rxq,
 	idpf_qc_split_rx_bufq_reset(bufq);
 	bufq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_buf_qtail_start +
 			 queue_idx * vport->chunks_info.rx_buf_qtail_spacing);
-	bufq->ops = &def_rxq_ops;
+	bufq->idpf_ops = &def_rxq_ops;
 	bufq->q_set = true;
 
 	if (bufq_id == IDPF_RX_SPLIT_BUFQ1_ID) {
@@ -305,7 +305,7 @@ idpf_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_rx_queue_reset(rxq);
 		rxq->qrx_tail = hw->hw_addr + (vport->chunks_info.rx_qtail_start +
 				queue_idx * vport->chunks_info.rx_qtail_spacing);
-		rxq->ops = &def_rxq_ops;
+		rxq->idpf_ops = &def_rxq_ops;
 	} else {
 		idpf_qc_split_rx_descq_reset(rxq);
 
@@ -378,7 +378,7 @@ idpf_tx_complq_setup(struct rte_eth_dev *dev, struct idpf_tx_queue *txq,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	cq->tx_ring_phys_addr = mz->iova;
+	cq->tx_ring_dma = mz->iova;
 	cq->compl_ring = mz->addr;
 	cq->mz = mz;
 	idpf_qc_split_tx_complq_reset(cq);
@@ -438,8 +438,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	is_splitq = !!(vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT);
 
 	txq->nb_tx_desc = nb_desc;
-	txq->rs_thresh = tx_rs_thresh;
-	txq->free_thresh = tx_free_thresh;
+	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
 	txq->offloads = idpf_tx_offload_convert(offloads);
@@ -458,7 +458,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ret = -ENOMEM;
 		goto err_mz_reserve;
 	}
-	txq->tx_ring_phys_addr = mz->iova;
+	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
@@ -471,7 +471,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	}
 
 	if (!is_splitq) {
-		txq->tx_ring = mz->addr;
+		txq->idpf_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
@@ -486,7 +486,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 
 	txq->qtx_tail = hw->hw_addr + (vport->chunks_info.tx_qtail_start +
 			queue_idx * vport->chunks_info.tx_qtail_spacing);
-	txq->ops = &def_txq_ops;
+	txq->idpf_ops = &def_txq_ops;
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
 
@@ -682,11 +682,11 @@ idpf_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	rxq = dev->data->rx_queues[rx_queue_id];
 	rxq->q_started = false;
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		rxq->ops->release_mbufs(rxq);
+		rxq->idpf_ops->release_mbufs(rxq);
 		idpf_qc_single_rx_queue_reset(rxq);
 	} else {
-		rxq->bufq1->ops->release_mbufs(rxq->bufq1);
-		rxq->bufq2->ops->release_mbufs(rxq->bufq2);
+		rxq->bufq1->idpf_ops->release_mbufs(rxq->bufq1);
+		rxq->bufq2->idpf_ops->release_mbufs(rxq->bufq2);
 		idpf_qc_split_rx_queue_reset(rxq);
 	}
 	dev->data->rx_queue_state[rx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
@@ -714,7 +714,7 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = dev->data->tx_queues[tx_queue_id];
 	txq->q_started = false;
-	txq->ops->release_mbufs(txq);
+	txq->idpf_ops->release_mbufs(txq);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index 002c1e6948..608cab30f3 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -54,8 +54,8 @@ idpf_tx_vec_queue_default(struct idpf_tx_queue *txq)
 	if (txq == NULL)
 		return IDPF_SCALAR_PATH;
 
-	if (txq->rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
-	    (txq->rs_thresh & 3) != 0)
+	if (txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST ||
+	    (txq->tx_rs_thresh & 3) != 0)
 		return IDPF_SCALAR_PATH;
 
 	if ((txq->offloads & IDPF_TX_NO_VECTOR_FLAGS) != 0)
-- 
2.34.1

