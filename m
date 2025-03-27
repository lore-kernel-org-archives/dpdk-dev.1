Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED06C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 16:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E73D640EDC;
	Thu, 27 Mar 2025 17:03:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CC6AF40E31
 for <dev@dpdk.org>; Thu, 27 Mar 2025 17:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743091405; x=1774627405;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AKiAM94wEwPITAsjYj9r0FKtykro8Oshx/kYbzI7UAA=;
 b=LLCxga8xVAvecvaGMLBUb+FT35whfZPaehNC8MycQWBjVyHG7rVjRgSM
 33m9av7PK8kHf6mBcJVv3vtIvHFLwXpVSHBGeuikbQ/85Yn4SNTL/D6zp
 VYsdHLerB8VSg+ZQAdf/FTL4NCqhrzSLWXMOfKf7jwvPrlKz9kg6UB7qS
 uqdqVtm2ZwBazGIYe8rrxWyWTYNdrfSfnTkglxPxj2luIJIT/SRYM1Wzm
 ZuxcY/bRj+9SF4zBVPhh0j8yuDWdMuXoFVzK2Y/iRSHyPQT3s/Ng7edT8
 veYjDsV1no9TE+lXce+NumoyodLNGohtfP+n59xna91x4e6zKj2Lkc8hA g==;
X-CSE-ConnectionGUID: FrOItSzUQLqRCTiTS61X3w==
X-CSE-MsgGUID: pvjbLy7qRgmeWWfbduwXWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61825769"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61825769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 09:03:23 -0700
X-CSE-ConnectionGUID: 1aPsPe8CQT6DKEz4Fop67A==
X-CSE-MsgGUID: VoaPrl34TPWCtzUGvnXq7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125412056"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2025 09:03:22 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v5 3/4] net/intel: use common Tx entry structure
Date: Thu, 27 Mar 2025 21:34:36 +0530
Message-Id: <20250327160437.2296127-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327160437.2296127-1-shaiq.wani@intel.com>
References: <20250327104502.2107300-2-shaiq.wani@intel.com>
 <20250327160437.2296127-1-shaiq.wani@intel.com>
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

Used the common Tx entry structure and common Tx mbuf ring replenish fn
in place of idpf-specific structure and function.
The vector driver code paths (AVX2, AVX512) use the smaller SW
ring structure.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 26 ++++++++---------
 drivers/net/intel/idpf/idpf_common_rxtx.h     | 10 -------
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 23 +++++----------
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 28 ++++++-------------
 drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
 5 files changed, 30 insertions(+), 59 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 48fc3ef7ae..4318b3fb3c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -210,7 +210,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 void
 idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -223,7 +223,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->desc_ring)[i] = 0;
 
-	txe = (struct idpf_tx_entry *)txq->sw_ring;
+	txe = (struct ci_tx_entry *)txq->sw_ring;
 	prev = (uint16_t)(txq->sw_nb_desc - 1);
 	for (i = 0; i < txq->sw_nb_desc; i++) {
 		txe[i].mbuf = NULL;
@@ -266,7 +266,7 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 void
 idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	uint32_t i, size;
 	uint16_t prev;
 
@@ -275,7 +275,7 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 		return;
 	}
 
-	txe = (struct idpf_tx_entry *)txq->sw_ring;
+	txe = (struct ci_tx_entry *)txq->sw_ring;
 	size = sizeof(struct idpf_base_tx_desc) * txq->nb_tx_desc;
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->idpf_tx_ring)[i] = 0;
@@ -755,7 +755,7 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 	volatile struct idpf_splitq_tx_compl_desc *compl_ring = cq->compl_ring;
 	volatile struct idpf_splitq_tx_compl_desc *txd;
 	uint16_t next = cq->tx_tail;
-	struct idpf_tx_entry *txe;
+	struct ci_tx_entry *txe;
 	struct ci_tx_queue *txq;
 	uint16_t gen, qid, q_head;
 	uint16_t nb_desc_clean;
@@ -794,7 +794,7 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 		break;
 	case IDPF_TXD_COMPLT_RS:
 		/* q_head indicates sw_id when ctype is 2 */
-		txe = (struct idpf_tx_entry *)&txq->sw_ring[q_head];
+		txe = &txq->sw_ring[q_head];
 		if (txe->mbuf != NULL) {
 			rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = NULL;
@@ -863,9 +863,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txr;
 	volatile struct idpf_flex_tx_sched_desc *txd;
-	struct idpf_tx_entry *sw_ring;
+	struct ci_tx_entry *sw_ring;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
+	struct ci_tx_entry *txe, *txn;
 	uint16_t nb_used, tx_id, sw_id;
 	struct rte_mbuf *tx_pkt;
 	uint16_t nb_to_clean;
@@ -878,7 +878,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		return nb_tx;
 
 	txr = txq->desc_ring;
-	sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
+	sw_ring = txq->sw_ring;
 	tx_id = txq->tx_tail;
 	sw_id = txq->sw_tail;
 	txe = &sw_ring[sw_id];
@@ -1305,7 +1305,7 @@ static inline int
 idpf_xmit_cleanup(struct ci_tx_queue *txq)
 {
 	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct idpf_tx_entry *sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	uint16_t nb_tx_desc = txq->nb_tx_desc;
 	uint16_t desc_to_clean_to;
 	uint16_t nb_tx_to_clean;
@@ -1349,8 +1349,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	volatile struct idpf_base_tx_desc *txd;
 	volatile struct idpf_base_tx_desc *txr;
 	union idpf_tx_offload tx_offload = {0};
-	struct idpf_tx_entry *txe, *txn;
-	struct idpf_tx_entry *sw_ring;
+	struct ci_tx_entry *txe, *txn;
+	struct ci_tx_entry *sw_ring;
 	struct ci_tx_queue *txq;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
@@ -1371,7 +1371,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	if (unlikely(txq == NULL))
 		return nb_tx;
 
-	sw_ring = (struct idpf_tx_entry *)txq->sw_ring;
+	sw_ring = txq->sw_ring;
 	txr = txq->idpf_tx_ring;
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 1a64b6615c..fc68dddc90 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -149,12 +149,6 @@ struct idpf_rx_queue {
 	uint32_t hw_register_set;
 };
 
-struct idpf_tx_entry {
-	struct rte_mbuf *mbuf;
-	uint16_t next_id;
-	uint16_t last_id;
-};
-
 /* Offload features */
 union idpf_tx_offload {
 	uint64_t data;
@@ -167,10 +161,6 @@ union idpf_tx_offload {
 	};
 };
 
-struct idpf_tx_vec_entry {
-	struct rte_mbuf *mbuf;
-};
-
 union idpf_tx_desc {
 	struct idpf_base_tx_desc *tx_ring;
 	struct idpf_flex_tx_sched_desc *desc_ring;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 26b24106d0..bce0257804 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -478,20 +478,11 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 {
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
-static __rte_always_inline void
-idpf_tx_backlog_entry(struct idpf_tx_entry *txep,
-		     struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	int i;
-
-	for (i = 0; i < (int)nb_pkts; ++i)
-		txep[i].mbuf = tx_pkts[i];
-}
 
 static __rte_always_inline int
 idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -509,7 +500,7 @@ idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
 	 /* first buffer to free from S/W ring is at index
 	  * tx_next_dd - (tx_rs_thresh-1)
 	  */
-	txep = (struct idpf_tx_entry *)&txq->sw_ring[txq->tx_next_dd - (n - 1)];
+	txep = &txq->sw_ring_vec[txq->tx_next_dd - (n - 1)];
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
@@ -621,7 +612,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -638,13 +629,13 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 	tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
-	txep = (struct idpf_tx_entry *)&txq->sw_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		idpf_tx_backlog_entry(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -659,10 +650,10 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 
 		/* avoid reach the end of ring */
 		txdp = &txq->idpf_tx_ring[tx_id];
-		txep = (struct idpf_tx_entry *)&txq->sw_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
 	}
 
-	idpf_tx_backlog_entry(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index a41b5f33af..c0ec754642 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -999,7 +999,7 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 static __rte_always_inline int
 idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1112,16 +1112,6 @@ idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
 	return txq->tx_rs_thresh;
 }
 
-static __rte_always_inline void
-tx_backlog_entry_avx512(struct idpf_tx_vec_entry *txep,
-			struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	int i;
-
-	for (i = 0; i < (int)nb_pkts; ++i)
-		txep[i].mbuf = tx_pkts[i];
-}
-
 static __rte_always_inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags)
@@ -1196,7 +1186,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 {
 	struct ci_tx_queue *txq = tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
@@ -1221,7 +1211,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_singleq_vtx(txdp, tx_pkts, n - 1, flags);
 		tx_pkts += (n - 1);
@@ -1240,7 +1230,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_singleq_vtx(txdp, tx_pkts, nb_commit, flags);
 
@@ -1324,7 +1314,7 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 static __rte_always_inline int
 idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
 {
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint32_t n;
 	uint32_t i;
 	int nb_free = 0;
@@ -1499,7 +1489,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 {
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_flex_tx_sched_desc *txdp;
-	struct idpf_tx_vec_entry *txep;
+	struct ci_tx_entry_vec *txep;
 	uint16_t n, nb_commit, tx_id;
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
@@ -1522,7 +1512,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 
 	n = (uint16_t)(txq->nb_tx_desc - tx_id);
 	if (nb_commit >= n) {
-		tx_backlog_entry_avx512(txep, tx_pkts, n);
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
 
 		idpf_splitq_vtx(txdp, tx_pkts, n - 1, cmd_dtype);
 		tx_pkts += (n - 1);
@@ -1541,7 +1531,7 @@ idpf_splitq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pkt
 		txep += tx_id;
 	}
 
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_commit);
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
 
 	idpf_splitq_vtx(txdp, tx_pkts, nb_commit, cmd_dtype);
 
@@ -1597,7 +1587,7 @@ idpf_tx_release_mbufs_avx512(struct ci_tx_queue *txq)
 {
 	unsigned int i;
 	const uint16_t max_desc = (uint16_t)(txq->nb_tx_desc - 1);
-	struct idpf_tx_vec_entry *swr = (void *)txq->sw_ring;
+	struct ci_tx_entry_vec *swr = (void *)txq->sw_ring;
 
 	if (txq->sw_ring == NULL || txq->nb_tx_free == max_desc)
 		return;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 4d8cfa56ac..7f512c6bc6 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -462,7 +462,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->mz = mz;
 
 	txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
-					  sizeof(struct idpf_tx_entry) * len,
+					  sizeof(struct ci_tx_entry) * len,
 					  RTE_CACHE_LINE_SIZE, socket_id);
 	if (txq->sw_ring == NULL) {
 		PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
-- 
2.34.1

