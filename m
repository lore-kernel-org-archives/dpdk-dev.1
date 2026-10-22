Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3D606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GlXLGLAy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84EE2402A2;
	Thu, 22 Oct 2026 07:22:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id E496740299;
 Thu, 22 Oct 2026 07:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792646534; x=1824182534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dbbQC9yJtigqF0EzqMIPpywTCBcEuelrqz3iQcrNqRg=;
 b=GlXLGLAy7aujbm4FVUCbSt3B4tUcBpfpy3wTEHM2Ak6UK1wj3y/2XwN/
 dMW71vN6Y0jFAtSwcph8WiBYPli4MtNb4whAAQzWF1WFqWiy/uWSImJ+S
 LV2zYFKegQ3gJM/gmxxoUs2hjnO+YgKNssgQNt393i9JdzBdy5Agv9kYK
 xZXFSbLuGXsiiXnqg/SDqq9L472h9F8ytWQVpYeLYbmZb0QnS52wQB6B+
 nXGUE9EO/R1PRtj5ynleLH2ULwI2iPkJL4i2Do9/NKhiNPuTaaybagYN8
 cEx8UshPL0B681KJA4lbthXuIhcN2juzNzYN8b8u4MTAToDsCtnawdDr9 w==;
X-CSE-ConnectionGUID: ifu01TbhTEahziZwbSizqQ==
X-CSE-MsgGUID: TWYPDr2uROW9NND7I8GSUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1394760"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1394760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 22:22:12 -0700
X-CSE-ConnectionGUID: 1P+SnCeaQbWcx3WNb/J//Q==
X-CSE-MsgGUID: eg4mFxlUSVGyzMy2Y/kZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="3192636"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa007.jf.intel.com with ESMTP; 21 Oct 2026 22:22:11 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v3] net/intel: fix idpf Tx payload corruption in split queue
Date: Thu, 22 Oct 2026 10:52:07 +0530
Message-Id: <20261022052207.591236-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930044630.250936-1-shaiq.wani@intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Observed on ACC while running NVMe traffic tests: under sustained
high-throughput split-queue Tx, payload bytes on the wire did not
match what the application submitted, while headers and checksums
looked valid.

The RS-completion path freed mbufs by walking sw_ring[] slots between
first_id and the EOP sw_id. RE reclaims and reuses those slots before
RS lands, so the walker freed mbufs still in flight for later packets,
whose buffers were then recycled and overwritten mid-DMA.

Track completion ownership in a shadow ring indexed by a software-
defined compl_tag written to all data descriptors of a packet (per the
IDPF spec) and echoed back by HW on RS. The shadow ring is the sole
owner of in-flight mbufs, so sw_ring[].mbuf is no longer touched and
queue stop/release drain only the shadow ring. Size it to nb_tx_desc
and stop Tx when the next compl_tag slot is still occupied, since RE
runs ahead of RS and nb_tx_free does not bound pending completions.
Allocate it at queue setup (failing on -ENOMEM) and free it on all
setup-error and release paths.

Remove the now unused ci_tx_entry.first_id field.

Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v3: shrink ci_tx_queue and trim the fast path per review:
* Drop the redundant tx_pending_size field (always nb_tx_desc).
* Reuse the now-dead sw_tail slot as tx_next_compl_tag, so the shadow
  ring adds only one pointer to ci_tx_queue.
* Remove the dead sw_ring[]/next_id walk from idpf_dp_splitq_xmit_pkts.
Kept a dedicated shadow ring rather than sw_ring[tag].mbuf: sw_ring is
indexed by descriptor and drained per-segment, so it cannot track
per-packet compl_tag ownership of multi-seg chains.

v2: no mbufs in sw_ring[] (shadow ring is sole owner); stop Tx on a
pending compl_tag slot; -ENOMEM propagation and cleanup on all paths;
same compl_tag on all data descs; shadow ring sized to nb_tx_desc.
---
 drivers/net/intel/common/tx.h             |   8 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c        |   6 ++
 drivers/net/intel/idpf/idpf_common_rxtx.c | 119 ++++++++++++++--------
 drivers/net/intel/idpf/idpf_common_rxtx.h |   4 +
 drivers/net/intel/idpf/idpf_rxtx.c        |   5 +
 5 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2a63cd4330..65e8f3fc59 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -166,7 +166,6 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
-	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
 };
 
 /**
@@ -260,8 +259,13 @@ struct ci_tx_queue {
 				struct idpf_complq *complq;
 				uint32_t latch_idx; /* Tx timestamp latch index */
 				uint16_t sw_nb_desc;
-				uint16_t sw_tail;
 				uint16_t rs_compl_count;
+				/* Split-Tx completion tracking: shadow ring indexed by a
+				 * rolling compl_tag decouples RS-completion mbuf lifetime
+				 * from sw_ring[] slot reuse. Sized nb_tx_desc.
+				 */
+				struct rte_mbuf **tx_pending_pkts;
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
index 649b5d1f99..496900b697 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -227,12 +227,55 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 
 	/* Use this as next to clean for split desc queue */
 	txq->last_desc_cleaned = 0;
-	txq->sw_tail = 0;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
 	txq->rs_compl_count = 0;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+
+	if (txq->tx_pending_pkts != NULL) {
+		for (i = 0; i < txq->nb_tx_desc; i++) {
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
+	for (i = 0; i < txq->nb_tx_desc; i++) {
+		if (txq->tx_pending_pkts[i] != NULL)
+			rte_pktmbuf_free(txq->tx_pending_pkts[i]);
+	}
+	rte_free(txq->tx_pending_pkts);
+	txq->tx_pending_pkts = NULL;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
@@ -387,6 +430,7 @@ idpf_qc_tx_queue_release(void *txq)
 		rte_free(q->complq);
 	}
 
+	idpf_qc_split_tx_pending_free(q);
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->rs_last_id);
 	rte_free(q->sw_ring);
@@ -787,7 +831,6 @@ idpf_split_tx_free(struct idpf_complq *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -824,26 +867,21 @@ idpf_split_tx_free(struct idpf_complq *cq)
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
+		if (unlikely(tag >= txq->nb_tx_desc)) {
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
@@ -915,10 +953,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
-	struct ci_tx_entry *sw_ring;
 	union ci_tx_offload tx_offload = {0};
-	struct ci_tx_entry *txe, *txn;
-	uint16_t nb_used, tx_id, sw_id;
+	uint16_t nb_used, tx_id;
 	struct rte_mbuf *tx_pkt;
 	uint16_t nb_to_clean;
 	uint16_t nb_tx = 0;
@@ -930,10 +966,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	txr = txq->desc_ring;
-	sw_ring = txq->sw_ring;
 	tx_id = txq->tx_tail;
-	sw_id = txq->sw_tail;
-	txe = &sw_ring[sw_id];
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
@@ -976,6 +1009,19 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
 
@@ -991,8 +1037,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
-		uint16_t first_sw_id = sw_id;
-
 		do {
 			uint16_t slen = tx_pkt->data_len;
 			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
@@ -1003,14 +1047,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
 					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
 				txd = &txr[tx_id];
-				txn = &sw_ring[txe->next_id];
-				txe->mbuf = NULL;
 
 				txd->buf_addr = rte_cpu_to_le_64(buf_dma_addr);
 				txd->qw1.cmd_dtype = cmd_dtype |
 					IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 				txd->qw1.rxr_bufsize = CI_MAX_DATA_PER_TXD;
-				txd->qw1.compl_tag = sw_id;
+				txd->qw1.compl_tag = tag;
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
@@ -1018,33 +1060,29 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id++;
 				if (tx_id == txq->nb_tx_desc)
 					tx_id = 0;
-				sw_id = txe->next_id;
-				txe = txn;
 			}
 
 			txd = &txr[tx_id];
-			txn = &sw_ring[txe->next_id];
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
-			sw_id = txe->next_id;
-			txe = txn;
 			tx_pkt = tx_pkt->next;
 		} while (tx_pkt);
 
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
-		/* Record first sw_id at EOP so completion can walk forward. */
-		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
+		txq->tx_pending_pkts[tag] = tx_pkts[nb_tx];
+		if (++txq->tx_next_compl_tag == txq->nb_tx_desc)
+			txq->tx_next_compl_tag = 0;
 
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 		txq->rs_compl_count += nb_used;
@@ -1060,7 +1098,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (likely(nb_tx > 0)) {
 		IDPF_PCI_REG_WRITE(txq->qtx_tail, tx_id);
 		txq->tx_tail = tx_id;
-		txq->sw_tail = sw_id;
 	}
 
 	return nb_tx;
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

