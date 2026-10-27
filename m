Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412A606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZAN32PKb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2BF0402BD;
	Tue, 27 Oct 2026 07:10:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 39486400D5;
 Tue, 27 Oct 2026 07:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793081427; x=1824617427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XdbTj61e46HKyefMF+jBAgNj02Ah04VG7i5iKOuBWM8=;
 b=ZAN32PKbkKDTl0PkJh2RJY4Z+0dsD2fgSLhHYxmJ6BGFRET90+GWrZ5t
 2q8/GcPol/Cah5FUJSk0kQKaACEDXamgYbL2PyVjRMEbziQijCEoYvyMi
 P16myP8BTZ/mWcMkrjM1lnwDvrA6/J6Mb+UZW0G0ACRoEUHdqHNWhZ9uN
 pSG8czb6CSqepBO4rIeLkpMLZgGKpzEulbswwFx6GPDOuvYvZS7qfK5sf
 Xyd4w+QpM0gA/Wr08fIKmxV++9Vq3LXs1EJDfQk24XsOKoZSC+yhFiMDY
 OXFlK/l00FNyQgewDm6QMg5GIf/sGPQuOsx+w6OIN/74P6jEfBwZmNc0v Q==;
X-CSE-ConnectionGUID: 4FR4j7VqT9Ku2vKfcKpCbA==
X-CSE-MsgGUID: Tojf09GoTUmTLEUmS+YEcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1794454"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1794454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 23:10:25 -0700
X-CSE-ConnectionGUID: DejXSCiJTU2rPLFmVtQ96A==
X-CSE-MsgGUID: xWANmQRcQ66ZFMMIYtXaCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4472533"
Received: from npg-npf-wlpr-srv19.iind.intel.com ([10.190.212.201])
 by orviesa004.jf.intel.com with ESMTP; 26 Oct 2026 23:10:23 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v4] net/intel: fix idpf Tx payload corruption in split queue
Date: Tue, 27 Oct 2026 11:40:17 +0530
Message-Id: <20261027061017.1018902-1-shaiq.wani@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The scalar shadow ring and the vector sw_ring_vec are both nb_tx_desc
arrays of mbuf pointers and are never used at the same time, so place
the shadow ring in the sw_ring/sw_ring_vec union and allocate a single
nb_tx_desc-sized ring for split queues instead of the old
2 * nb_tx_desc ci_tx_entry ring. This drops split-queue ring storage
from 40 KiB to 8 KiB per queue at 1024 descriptors and keeps
ci_tx_queue from growing. Split-queue mbuf drain now follows
use_vec_entry: the vector path reclaims via ci_txq_release_all_mbufs(),
the scalar path drains the shadow ring by completion tag.

Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v4: fold in the reviewer's split-queue footprint optimisation:
* Move tx_pending_pkts into the sw_ring/sw_ring_vec union; for split
  queues allocate one nb_tx_desc mbuf-pointer ring instead of the
  2 * nb_tx_desc ci_tx_entry ring (40 KiB -> 8 KiB at 1024 descs).
* Drop the now-dead sw_ring next_id chain init in descq_reset and the
  2 * nb_tx_desc sw_ring sizing; split queues no longer allocate the
  scalar sw_ring/rs_last_id.
* Set use_vec_entry for split queues and route mbuf drain through it
  (vector: ci_txq_release_all_mbufs(); scalar: shadow-ring drain).
  Rename idpf_qc_split_tx_pending_free() to
  idpf_qc_split_tx_release_mbufs() to reflect it no longer frees the
  ring (freed once via the union pointer).

v3: shrink ci_tx_queue and trim the fast path per review:
* Drop the redundant tx_pending_size field (always nb_tx_desc).
* Reuse the now-dead sw_tail slot as tx_next_compl_tag.
* Remove the dead sw_ring[]/next_id walk from idpf_dp_splitq_xmit_pkts.

v2: no mbufs in sw_ring[] (shadow ring is sole owner); stop Tx on a
pending compl_tag slot; -ENOMEM propagation and cleanup on all paths;
same compl_tag on all data descs; shadow ring sized to nb_tx_desc.
---
 drivers/net/intel/common/tx.h             |   5 +-
 drivers/net/intel/cpfl/cpfl_rxtx.c        |  69 ++++++------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 128 +++++++++++++---------
 drivers/net/intel/idpf/idpf_common_rxtx.h |   4 +
 drivers/net/intel/idpf/idpf_rxtx.c        |  60 +++++-----
 5 files changed, 144 insertions(+), 122 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2a63cd4330..00bf90181c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -166,7 +166,6 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
-	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
 };
 
 /**
@@ -187,6 +186,8 @@ struct ci_tx_queue {
 	union {
 		struct ci_tx_entry *sw_ring; /* virtual address of SW ring */
 		struct ci_tx_entry_vec *sw_ring_vec;
+		/* IDPF split scalar: packet ownership indexed by completion tag. */
+		struct rte_mbuf **tx_pending_pkts;
 	};
 	/* Scalar TX path: Array tracking last_id at each RS threshold boundary */
 	uint16_t *rs_last_id;
@@ -260,8 +261,8 @@ struct ci_tx_queue {
 				struct idpf_complq *complq;
 				uint32_t latch_idx; /* Tx timestamp latch index */
 				uint16_t sw_nb_desc;
-				uint16_t sw_tail;
 				uint16_t rs_compl_count;
+				uint16_t tx_next_compl_tag;
 		};
 	};
 };
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index aba3a5e916..a358beca23 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -325,11 +325,12 @@ cpfl_tx_queue_release(void *txq)
 	q = &cpfl_txq->base;
 
 	if (q->complq) {
+		idpf_qc_split_tx_release_mbufs(q);
 		rte_memzone_free(q->complq->mz);
 		rte_free(q->complq);
-	}
+	} else
+		ci_txq_release_all_mbufs(q, q->use_vec_entry);
 
-	ci_txq_release_all_mbufs(q, q->use_vec_entry);
 	rte_free(q->sw_ring);
 	rte_free(q->rs_last_id);
 	rte_memzone_free(q->mz);
@@ -538,7 +539,6 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	const struct rte_memzone *mz;
 	struct ci_tx_queue *txq;
 	uint64_t offloads;
-	uint16_t len;
 	bool is_splitq;
 	int ret;
 
@@ -583,11 +583,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->offloads = cpfl_tx_offload_convert(offloads);
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-	if (is_splitq)
-		len = 2 * nb_desc;
-	else
-		len = nb_desc;
-	txq->sw_nb_desc = len;
+	txq->sw_nb_desc = nb_desc;
 
 	/* Allocate TX hardware ring descriptors. */
 	mz = cpfl_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
@@ -599,31 +595,34 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
-	txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
-					  sizeof(struct ci_tx_entry) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
-	if (txq->sw_ring == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
-		ret = -ENOMEM;
-		goto err_sw_ring_alloc;
-	}
+	if (!is_splitq) {
+		txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
+				sizeof(struct ci_tx_entry) * nb_desc,
+				RTE_CACHE_LINE_SIZE, socket_id);
+		if (txq->sw_ring == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
+			ret = -ENOMEM;
+			goto err_sw_ring_alloc;
+		}
 
-	/* Allocate RS last_id tracking array */
-	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-	txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
-			sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (txq->rs_last_id == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
-		ret = -ENOMEM;
-		goto err_rs_last_id_alloc;
-	}
+		/* Allocate RS last_id tracking array */
+		const uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+		txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
+				sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+				RTE_CACHE_LINE_SIZE, socket_id);
+		if (txq->rs_last_id == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
+			ret = -ENOMEM;
+			goto err_rs_last_id_alloc;
+		}
 
-	if (!is_splitq) {
 		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
+		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		if (ret != 0)
+			goto err_sw_ring_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
@@ -1365,8 +1364,8 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = &cpfl_txq->base;
-	ci_txq_release_all_mbufs(txq, txq->use_vec_entry);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+		ci_txq_release_all_mbufs(txq, txq->use_vec_entry);
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		if (cpfl_txq->hairpin_info.hairpin_q) {
@@ -1545,14 +1544,12 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 					IDPF_TX_DEFAULT,
 					false);
 
-	/* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			txq = dev->data->tx_queues[i];
-			if (txq == NULL)
-				continue;
-			txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ);
-		}
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+		txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ &&
+				ad->tx_func_type != IDPF_TX_DEFAULT);
 	}
 
 out:
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 649b5d1f99..eb29024547 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -202,9 +202,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset)
 void
 idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
-	struct ci_tx_entry *txe;
 	uint32_t i, size;
-	uint16_t prev;
 
 	if (txq == NULL) {
 		DRV_LOG(DEBUG, "Pointer to txq is NULL");
@@ -215,24 +213,56 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->desc_ring)[i] = 0;
 
-	txe = txq->sw_ring;
-	prev = (uint16_t)(txq->sw_nb_desc - 1);
-	for (i = 0; i < txq->sw_nb_desc; i++) {
-		txe[i].mbuf = NULL;
-		txe[prev].next_id = i;
-		prev = i;
-	}
+	idpf_qc_split_tx_release_mbufs(txq);
 
 	txq->tx_tail = 0;
 
 	/* Use this as next to clean for split desc queue */
 	txq->last_desc_cleaned = 0;
-	txq->sw_tail = 0;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
 
 	txq->rs_compl_count = 0;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+
+	txq->tx_next_compl_tag = 0;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_alloc)
+int
+idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
+{
+	/* Scalar completion tags and vector descriptor indices both use nb_tx_desc pointers. */
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
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_release_mbufs)
+void
+idpf_qc_split_tx_release_mbufs(struct ci_tx_queue *txq)
+{
+	if (txq->tx_pending_pkts == NULL)
+		return;
+
+	if (txq->use_vec_entry) {
+		ci_txq_release_all_mbufs(txq, false);
+		return;
+	}
+
+	/* Scalar completion tags can outlive descriptor reuse, so drain every slot. */
+	for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
+		if (txq->tx_pending_pkts[i] != NULL)
+			rte_pktmbuf_free(txq->tx_pending_pkts[i]);
+		txq->tx_pending_pkts[i] = NULL;
+	}
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
@@ -383,11 +413,12 @@ idpf_qc_tx_queue_release(void *txq)
 		return;
 
 	if (q->complq) {
+		idpf_qc_split_tx_release_mbufs(q);
 		rte_memzone_free(q->complq->mz);
 		rte_free(q->complq);
-	}
+	} else
+		ci_txq_release_all_mbufs(q, false);
 
-	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->rs_last_id);
 	rte_free(q->sw_ring);
 	rte_memzone_free(q->mz);
@@ -787,7 +818,6 @@ idpf_split_tx_free(struct idpf_complq *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -824,26 +854,21 @@ idpf_split_tx_free(struct idpf_complq *cq)
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
@@ -915,10 +940,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
@@ -930,10 +953,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	txr = txq->desc_ring;
-	sw_ring = txq->sw_ring;
 	tx_id = txq->tx_tail;
-	sw_id = txq->sw_tail;
-	txe = &sw_ring[sw_id];
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
@@ -976,6 +996,19 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
 
@@ -991,8 +1024,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
-		uint16_t first_sw_id = sw_id;
-
 		do {
 			uint16_t slen = tx_pkt->data_len;
 			rte_iova_t buf_dma_addr = rte_mbuf_data_iova(tx_pkt);
@@ -1003,14 +1034,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
@@ -1018,33 +1047,29 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
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
@@ -1060,7 +1085,6 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (likely(nb_tx > 0)) {
 		IDPF_PCI_REG_WRITE(txq->qtx_tail, tx_id);
 		txq->tx_tail = tx_id;
-		txq->sw_tail = sw_id;
 	}
 
 	return nb_tx;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index b2d33287df..a4843c9f69 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -216,6 +216,10 @@ void idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq);
 __rte_internal
 void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
+int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id);
+__rte_internal
+void idpf_qc_split_tx_release_mbufs(struct ci_tx_queue *txq);
+__rte_internal
 void idpf_qc_split_tx_complq_reset(struct idpf_complq *cq);
 __rte_internal
 void idpf_splitq_rearm_common(struct idpf_rx_queue *rx_bufq);
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 077a92a8a9..3bee388c17 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -413,7 +413,6 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	const struct rte_memzone *mz;
 	struct ci_tx_queue *txq;
 	uint64_t offloads;
-	uint16_t len;
 	bool is_splitq;
 	int ret;
 
@@ -456,11 +455,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->offloads = idpf_tx_offload_convert(offloads);
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-	if (is_splitq)
-		len = 2 * nb_desc;
-	else
-		len = nb_desc;
-	txq->sw_nb_desc = len;
+	txq->sw_nb_desc = nb_desc;
 
 	/* Allocate TX hardware ring descriptors. */
 	mz = idpf_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
@@ -472,29 +467,32 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->tx_ring_dma = mz->iova;
 	txq->mz = mz;
 
-	txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
-					  sizeof(struct ci_tx_entry) * len,
-					  RTE_CACHE_LINE_SIZE, socket_id);
-	if (txq->sw_ring == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
-		ret = -ENOMEM;
-		goto err_sw_ring_alloc;
-	}
+	if (!is_splitq) {
+		txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
+				sizeof(struct ci_tx_entry) * nb_desc,
+				RTE_CACHE_LINE_SIZE, socket_id);
+		if (txq->sw_ring == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
+			ret = -ENOMEM;
+			goto err_sw_ring_alloc;
+		}
 
-	txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
-			sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
-			RTE_CACHE_LINE_SIZE, socket_id);
-	if (txq->rs_last_id == NULL) {
-		PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
-		ret = -ENOMEM;
-		goto err_rs_last_id_alloc;
-	}
+		txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
+				sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
+				RTE_CACHE_LINE_SIZE, socket_id);
+		if (txq->rs_last_id == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
+			ret = -ENOMEM;
+			goto err_rs_last_id_alloc;
+		}
 
-	if (!is_splitq) {
 		txq->ci_tx_ring = mz->addr;
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		txq->desc_ring = mz->addr;
+		ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
+		if (ret != 0)
+			goto err_sw_ring_alloc;
 		idpf_qc_split_tx_descq_reset(txq);
 
 		/* Setup tx completion queue if split model */
@@ -733,8 +731,8 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	txq = dev->data->tx_queues[tx_queue_id];
-	ci_txq_release_all_mbufs(txq, false);
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+		ci_txq_release_all_mbufs(txq, false);
 		idpf_qc_single_tx_queue_reset(txq);
 	} else {
 		idpf_qc_split_tx_descq_reset(txq);
@@ -890,14 +888,12 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 					IDPF_TX_DEFAULT,
 					false);
 
-	/* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
-	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			txq = dev->data->tx_queues[i];
-			if (txq == NULL)
-				continue;
-			txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ);
-		}
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+		txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ &&
+				ad->tx_func_type != IDPF_TX_DEFAULT);
 	}
 
 out:
-- 
2.34.1

