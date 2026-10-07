Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A86CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:41:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17F2240608;
	Wed,  7 Oct 2026 12:41:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 13D2A40144;
 Wed,  7 Oct 2026 12:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791369699; x=1822905699;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AkE6sc2Pp2cF3mvRaVUoDi7eILjILOdOu7uwJMqB8QE=;
 b=SXPMvOWTn35zJZ9ZLjGwJXyzP5D+Y8LqOBRK6ef+RG/aVmph+lDT2Nza
 SFMZHjz2s9SSHSfcfMhH7O3D/kv7ZY5joZDBcF8A2pPSs2nwm71aC5BzD
 W949Z1lj4iJcrSgLXmZQDlL6IE8TMsRmaQBK0Qp0Q4aNrZHYwO9xOaylJ
 6InmPUUXPEFfkAzc9MzOCjZElG8f4QHK4739cSfX9wWzzmWuHMTpWEm8U
 Tae6aKkuge3jbMBH9qVw01KuB2Z8z5C+/vptqxRyVtxHsUtKSgDmt3Xsd
 ncdgXzuMK8JA4VLbNN31/mdWyrR558kR0YyTZiIHIoRJl+6Y9xAqdDuyk g==;
X-CSE-ConnectionGUID: k2XuY5IOTje9RoO2G9C9Zg==
X-CSE-MsgGUID: epSmOtiKQQeE3Mkdu8yCIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="22711"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="22711"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:41:30 -0700
X-CSE-ConnectionGUID: CxhQ6I9pTYqVvcdSQPlCtA==
X-CSE-MsgGUID: Vvn4CIzpQr2VnXsiafVNhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="303705026"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2026 03:41:28 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v2] net/intel: fix idpf Tx payload corruption in split queue
Date: Wed,  7 Oct 2026 16:10:42 +0530
Message-Id: <20261007104042.1189216-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930044630.250936-1-shaiq.wani@intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
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

Observed on ACC while running NVMe traffic tests: under sustained
high-throughput split-queue Tx, payload bytes on the wire did not
match what the application submitted, while headers and checksums
looked valid.

The RS-completion path was freeing mbufs by walking sw_ring[] slots
between first_id and the EOP sw_id. sw_ring[] slots get reclaimed
by RE and reused by subsequent submits well before RS lands, so the
walker was freeing mbufs still in flight for later packets, whose
buffers then got recycled and overwritten mid-DMA.

Fix by tracking completion ownership in a shadow ring indexed by a
software-defined compl_tag stamped on all data descriptors of the
packet, as required by the IDPF spec, and echoed back by HW on RS.
The shadow ring is the sole owner of in-flight mbufs on the scalar
split-queue path, so sw_ring[].mbuf is no longer written and queue
stop/release drain only the shadow ring.

Since RE reclaims descriptors before RS completes, nb_tx_free does
not bound the number of packets awaiting RS. Size the shadow ring to
nb_tx_desc and stop transmitting when the next compl_tag slot is
still occupied, so a pending entry is never overwritten and pending
completions cannot overflow the completion queue.

Allocate the shadow ring at queue setup and fail setup on allocation
error, and free it on all setup error and release paths. Remove the
now unused ci_tx_entry.first_id field.

Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v2:
Addressed AI review comments, which include:
* Do not store mbufs in sw_ring[] on the scalar split-queue Tx path;
  tx_pending_pkts[] is the sole owner, fixing double-free on queue
  stop/release.
* Stop Tx when the next compl_tag slot is still pending, so RS
  entries cannot be overwritten when RE runs ahead of RS.
* Allocate the shadow ring at queue setup and propagate -ENOMEM.
* Free the shadow ring on idpf/cpfl setup error paths and in
  cpfl_tx_queue_release().
Also aligned with the IDPF spec:
* Write the same compl_tag to all data descriptors of a packet.
* Size the shadow ring to nb_tx_desc, so pending completions cannot
  overflow the 2 * nb_tx_desc completion queue.
Other:
* Remove the now unused ci_tx_entry.first_id field.
* Drop redundant per-descriptor sw_ring[].mbuf = NULL stores.

 drivers/net/intel/common/tx.h             |   8 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c        |   6 ++
 drivers/net/intel/idpf/idpf_common_rxtx.c | 105 ++++++++++++++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h |   4 +
 drivers/net/intel/idpf/idpf_rxtx.c        |   5 ++
 5 files changed, 100 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2a63cd4330..7c9841a21a 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -166,7 +166,6 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
-	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
 };
 
 /**
@@ -262,6 +261,13 @@ struct ci_tx_queue {
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
+				/* Split-Tx completion tracking: shadow ring indexed by a
+				 * rolling compl_tag decouples RS-completion mbuf lifetime
+				 * from sw_ring[] slot reuse. Sized nb_tx_desc.
+				 */
+				struct rte_mbuf **tx_pending_pkts;
+				uint16_t tx_pending_size;
+				uint16_t tx_next_compl_tag;
 		};
 	};
 };
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index aba3a5e916..0dbe47d336 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -329,6 +329,7 @@ cpfl_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
+	idpf_qc_split_tx_pending_free(q);
 	ci_txq_release_all_mbufs(q, q->use_vec_entry);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
@@ -624,6 +625,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
+		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		if (ret != 0)
+			goto err_pending_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
@@ -642,6 +646,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	idpf_qc_split_tx_pending_free(txq);
+err_pending_alloc:
 	rte_free(txq->rs_last_id);
 err_rs_last_id_alloc:
 	rte_free(txq->sw_ring);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 649b5d1f99..e54056b5c0 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -233,6 +233,51 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	txq->rs_compl_count = 0;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+
+	if (txq->tx_pending_pkts != NULL) {
+		for (i = 0; i < txq->tx_pending_size; i++) {
+			if (txq->tx_pending_pkts[i] != NULL) {
+				rte_pktmbuf_free(txq->tx_pending_pkts[i]);
+				txq->tx_pending_pkts[i] = NULL;
+			}
+		}
+	}
+	txq->tx_next_compl_tag = 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_alloc)
+int
+idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
+{
+	/* Bounding pending RS to nb_tx_desc keeps the 2 * nb_tx_desc complq from overflowing. */
+	txq->tx_pending_pkts = rte_zmalloc_socket("idpf_tx_pending",
+			sizeof(struct rte_mbuf *) * txq->nb_tx_desc,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->tx_pending_pkts == NULL) {
+		DRV_LOG(ERR, "Failed to alloc idpf tx_pending shadow ring");
+		return -ENOMEM;
+	}
+	txq->tx_pending_size = txq->nb_tx_desc;
+	txq->tx_next_compl_tag = 0;
+
+	return 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_free)
+void
+idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq)
+{
+	uint32_t i;
+
+	if (txq->tx_pending_pkts == NULL)
+		return;
+
+	for (i = 0; i < txq->tx_pending_size; i++) {
+		if (txq->tx_pending_pkts[i] != NULL)
+			rte_pktmbuf_free(txq->tx_pending_pkts[i]);
+	}
+	rte_free(txq->tx_pending_pkts);
+	txq->tx_pending_pkts = NULL;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
@@ -387,6 +432,7 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
+	idpf_qc_split_tx_pending_free(q);
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->rs_last_id);
 	rte_free(q->sw_ring);
@@ -787,7 +833,6 @@ idpf_split_tx_free(struct idpf_complq *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -824,26 +869,21 @@ idpf_split_tx_free(struct idpf_complq *cq)
 		txq->nb_tx_free += nb_desc_clean;
 		txq->last_desc_cleaned = q_head;
 		break;
-	case IDPF_TXD_COMPLT_RS:
-		/* Walk from first segment to EOP, freeing each segment. */
-		txe = &txq->sw_ring[q_head];
-		if (txe->mbuf != NULL) {
-			uint16_t first = txe->first_id;
-			uint16_t idx = first;
-			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
-					0 : q_head + 1;
-
-			do {
-				txe = &txq->sw_ring[idx];
-				if (txe->mbuf != NULL) {
-					rte_pktmbuf_free_seg(txe->mbuf);
-					txe->mbuf = NULL;
-				}
-				idx = (idx + 1 == txq->sw_nb_desc) ?
-					0 : idx + 1;
-			} while (idx != end);
+	case IDPF_TXD_COMPLT_RS: {
+		/* Shadow ring indexed by the software-defined compl_tag is
+		 * the sole source of truth for RS-time mbuf ownership; free
+		 * the whole multi-seg chain via mbuf->next in one call.
+		 */
+		uint16_t tag = q_head;
+
+		if (unlikely(tag >= txq->tx_pending_size)) {
+			TX_LOG(ERR, "invalid completion tag %u.", tag);
+		} else if (txq->tx_pending_pkts[tag] != NULL) {
+			rte_pktmbuf_free(txq->tx_pending_pkts[tag]);
+			txq->tx_pending_pkts[tag] = NULL;
 		}
 		break;
+	}
 	default:
 		TX_LOG(ERR, "unknown completion type.");
 		return;
@@ -976,6 +1016,19 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		if (txq->nb_tx_free < nb_used)
 			break;
 
+		/* RE reclaims descriptors before RS, so tag occupancy is the
+		 * only bound on packets awaiting RS completion.
+		 */
+		uint16_t tag = txq->tx_next_compl_tag;
+
+		if (unlikely(txq->tx_pending_pkts[tag] != NULL)) {
+			nb_to_clean = 2 * txq->tx_rs_thresh;
+			while (nb_to_clean--)
+				idpf_split_tx_free(txq->complq);
+			if (txq->tx_pending_pkts[tag] != NULL)
+				break;
+		}
+
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
 			cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
 
@@ -991,8 +1044,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
-		uint16_t first_sw_id = sw_id;
-
 		do {
 			uint16_t slen = tx_pkt->data_len;
 			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
@@ -1004,13 +1055,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
 				txd = &txr[tx_id];
 				txn = &sw_ring[txe->next_id];
-				txe->mbuf = NULL;
 
 				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
 				txd->qw1.cmd_dtype = cmd_dtype |
 					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
-				txd->qw1.compl_tag = sw_id;
+				txd->qw1.compl_tag = tag;
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
@@ -1024,14 +1074,14 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 			txd = &txr[tx_id];
 			txn = &sw_ring[txe->next_id];
-			txe->mbuf = tx_pkt;
 
 			/* Setup TX descriptor */
 			txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
 			txd->qw1.cmd_dtype = cmd_dtype |
 				IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 			txd->qw1.rxr_bufsize = slen;
-			txd->qw1.compl_tag = sw_id;
+			/* Spec: COMPLETION_TAG must be identical on all data descs of a packet. */
+			txd->qw1.compl_tag = tag;
 			tx_id++;
 			if (tx_id == txq->nb_tx_desc)
 				tx_id = 0;
@@ -1043,8 +1093,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
-		/* Record first sw_id at EOP so completion can walk forward. */
-		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
+		txq->tx_pending_pkts[tag] = tx_pkts[nb_tx];
+		if (++txq->tx_next_compl_tag == txq->tx_pending_size)
+			txq->tx_next_compl_tag = 0;
 
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 		txq->rs_compl_count += nb_used;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index b2d33287df..3365631d80 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -216,6 +216,10 @@ void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
+int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id);
+__rte_internal
+void idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq);
+__rte_internal
 void idpf_qc_split_tx_complq_reset(struct idpf_complq *cq);
 __rte_internal
 void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 077a92a8a9..0d41cd87eb 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -495,6 +495,9 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
+		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		if (ret != 0)
+			goto err_pending_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
@@ -512,6 +515,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 
 err_complq_setup:
+	idpf_qc_split_tx_pending_free(txq);
+err_pending_alloc:
 	rte_free(txq->rs_last_id);
 err_rs_last_id_alloc:
 	rte_free(txq->sw_ring);
-- 
2.34.1

