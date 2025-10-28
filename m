Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8749CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D78040A4B;
	Tue, 28 Oct 2025 15:22:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6126E40673
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:22:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761661333; x=1793197333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pj5I+u4NB+jHX/CiHVuENzxW3w/d1lOqi7mgS5oOhEk=;
 b=FcdT+GGz7QJyLlB9QqGwW/B6N2sjjyaEPecp//m7swiFHcauCcj2zK0U
 iahflOvvd1gm63AVRbIMC+5W0Zyluk1WaolgBglSWLGUkFu7qH/OfFUrx
 fltWXkIqXdp9poBA3xud/1SX4kX9zsZl26zQWI0lvbnHzI01fPmLLzq0R
 7aUFwPGA9W6DHxoXHCKMbo9LD1a0icpdHLzFBiIgwb5RfcBqdvxdIKSq8
 YpFwEUS+dX0OmJln8xeIdZHw8580jr3j6QwOHue26IoIRYyY1h5gPhTLL
 hEcyRmCswf5b4Qo0/CbVzJP5rqg8re0FNcC/aJHOL1NQ+X3sAZj6qkMgX g==;
X-CSE-ConnectionGUID: XO4np5QiSnq3r3eEFLMcaQ==
X-CSE-MsgGUID: jCPbKUDXTT2Zt+3iViB/Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67626442"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="67626442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 07:22:13 -0700
X-CSE-ConnectionGUID: PyHOo+YZRW+mfdaYrOqnsA==
X-CSE-MsgGUID: Em0gXVGoSD2eU+GM2dSWmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="185681808"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 07:22:11 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v10 2/3] net/idpf: enable AVX2 for split queue Tx
Date: Tue, 28 Oct 2025 19:52:01 +0530
Message-Id: <20251028142202.137392-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142202.137392-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20251028142202.137392-1-shaiq.wani@intel.com>
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

In case some CPUs don't support AVX512. Enable AVX2 for them to
get better per-core performance.

In the single queue model, the same descriptor queue is used by SW
to post descriptors to the device and used by device to report completed
descriptors to SW. While as the split queue model separates them into
different queues for parallel processing and improved performance.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 178 +++++++++++++++++-
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 3 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 87f6895c4c..3636d55272 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -264,6 +264,9 @@ uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
 					struct rte_mbuf **rx_pkts,
 					uint16_t nb_pkts);
 __rte_internal
+uint16_t idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+				       uint16_t nb_pkts);
+__rte_internal
 uint16_t idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue,
 					struct rte_mbuf **tx_pkts,
 					uint16_t nb_pkts);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 2ea957ded8..4df9c560e0 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -697,7 +697,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	volatile struct idpf_base_tx_desc *txdp;
 	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, tx_id;
+	uint16_t n, nb_commit;
 	uint64_t flags = IDPF_TX_DESC_CMD_EOP;
 	uint64_t rs = IDPF_TX_DESC_CMD_RS | flags;
 
@@ -711,7 +711,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	tx_id = txq->tx_tail;
+	uint16_t tx_id = txq->tx_tail;
 	txdp = &txq->idpf_tx_ring[tx_id];
 	txep = &txq->sw_ring_vec[tx_id];
 
@@ -779,3 +779,177 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	return nb_tx;
 }
+
+static __rte_always_inline void
+idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
+{
+	struct idpf_splitq_tx_compl_desc *compl_ring;
+	struct ci_tx_queue *txq;
+	uint16_t genid, txq_qid, cq_qid, i;
+	uint8_t ctype;
+
+	cq_qid = cq->tx_tail;
+
+	for (i = 0; i < IDPD_TXQ_SCAN_CQ_THRESH; i++) {
+		if (cq_qid == cq->nb_tx_desc) {
+			cq_qid = 0;
+			cq->expected_gen_id ^= 1;  /* toggle generation bit */
+		}
+
+		compl_ring = &cq->compl_ring[cq_qid];
+
+		genid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
+				 IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
+
+		if (genid != cq->expected_gen_id)
+			break;
+
+		ctype = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
+				 IDPF_TXD_COMPLQ_COMPL_TYPE_M) >> IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+		txq_qid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
+				   IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
+
+		txq = cq->txqs[txq_qid - cq->tx_start_qid];
+		if (ctype == IDPF_TXD_COMPLT_RS)
+			txq->rs_compl_count++;
+
+		cq_qid++;
+	}
+
+	cq->tx_tail = cq_qid;
+}
+
+static __rte_always_inline void
+idpf_splitq_vtx1_avx2(struct idpf_flex_tx_sched_desc *txdp,
+				struct rte_mbuf *pkt, uint64_t flags)
+{
+	uint64_t high_qw =
+		IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
+		((uint64_t)flags) |
+		((uint64_t)pkt->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+
+	__m128i descriptor = _mm_set_epi64x(high_qw,
+						pkt->buf_iova + pkt->data_off);
+	_mm_storeu_si128((__m128i *)txdp, descriptor);
+}
+
+static inline void
+idpf_splitq_vtx_avx2(struct idpf_flex_tx_sched_desc *txdp,
+				struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags)
+{
+	const uint64_t hi_qw_tmpl = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE | ((uint64_t)flags);
+
+	/* align if needed */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
+		txdp++, pkt++, nb_pkts--;
+	}
+
+	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP; txdp += IDPF_VPMD_DESCS_PER_LOOP,
+			pkt += IDPF_VPMD_DESCS_PER_LOOP, nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP) {
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+
+		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
+			pkt[1]->buf_iova + pkt[1]->data_off,
+			hi_qw0,
+			pkt[0]->buf_iova + pkt[0]->data_off);
+		__m256i desc2_3 = _mm256_set_epi64x(hi_qw3,
+			pkt[3]->buf_iova + pkt[3]->data_off,
+			hi_qw2,
+			pkt[2]->buf_iova + pkt[2]->data_off);
+
+		_mm256_storeu_si256((__m256i *)(txdp + 0), desc0_1);
+		_mm256_storeu_si256((__m256i *)(txdp + 2), desc2_3);
+	}
+
+	while (nb_pkts--) {
+		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
+		txdp++;
+		pkt++;
+	}
+}
+
+static inline uint16_t
+idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	struct idpf_flex_tx_sched_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit;
+	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+	uint16_t tx_id = txq->tx_tail;
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	nb_pkts = nb_commit;
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	txdp = (struct idpf_flex_tx_sched_desc *)&txq->desc_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
+
+		idpf_splitq_vtx_avx2(txdp, tx_pkts, n - 1, cmd_dtype);
+		tx_pkts += (n - 1);
+		txdp += (n - 1);
+
+		idpf_splitq_vtx1_avx2(txdp, *tx_pkts++, cmd_dtype);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+		tx_id = 0;
+
+		txdp = &txq->desc_ring[tx_id];
+		txep = (void *)txq->sw_ring;
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	txq->tx_tail = tx_id;
+
+	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+uint16_t
+idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+					uint16_t nb_pkts)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	uint16_t nb_tx = 0;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+		idpf_splitq_scan_cq_ring(txq->complq);
+
+		if (txq->rs_compl_count > txq->tx_free_thresh) {
+			ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
+			txq->rs_compl_count -= txq->tx_rs_thresh;
+		}
+
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+		ret = idpf_splitq_xmit_fixed_burst_vec_avx2(tx_queue, &tx_pkts[nb_tx], num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx2)
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 1c725065df..6950fabb49 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -850,6 +850,15 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
 				return;
 			}
 #endif /* CC_AVX512_SUPPORT */
+			if (tx_simd_width == RTE_VECT_SIMD_256) {
+				PMD_DRV_LOG(NOTICE,
+					    "Using Split AVX2 Vector Tx (port %d).",
+					    dev->data->port_id);
+				dev->tx_pkt_burst = idpf_dp_splitq_xmit_pkts_avx2;
+				dev->tx_pkt_prepare = idpf_dp_prep_pkts;
+				return;
+			}
+
 		}
 		PMD_DRV_LOG(NOTICE,
 			    "Using Split Scalar Tx (port %d).",
-- 
2.34.1

