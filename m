Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B5CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 09:50:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 023DA402E0;
	Fri,  3 Oct 2025 11:50:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 63497402D4
 for <dev@dpdk.org>; Fri,  3 Oct 2025 11:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759485021; x=1791021021;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zq5LH0TRrlzVt2RrzEpZLt2xWjNHNbDB1RzsATruk7Q=;
 b=DrrmiY5dKpCIziWR2HhNi7hd+xx6uAQHVTe4e6tAhP/iFGCjnDYqo9sV
 sLIj957ItY5qmqQH5vjQFyUgudv560nuundYXe6jLG4WytW2cZlrvcLEN
 PHY/rgLdE2Tr40SFetYcbtZ1lIDYxn6ZYquhVisglcwMjqz6FUeROHLaf
 zYz2o6OX8wDTaPrcQIdEvPFCGIM85D84M++o3FFu0uuLTg1Bd/69OK5Rz
 PrTa5xisrgGqMfaUb6WcwDP08vDK1nhw4cUMbTjbjzhSYC8DVcrGoOEUZ
 8E9RDwpZvVbu5bcH3DVjNTxWvYKVuu7ja2fGejh3DGYqxQ66/7xtgF/SA w==;
X-CSE-ConnectionGUID: G6puAGlFQT+2fFyZOpxYrw==
X-CSE-MsgGUID: 52q6wr1UTsmiPDt0QOBVwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="87223208"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="87223208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 02:50:21 -0700
X-CSE-ConnectionGUID: fXp8PLmMT9mZ4KlKnpO6Ug==
X-CSE-MsgGUID: 5nogVVBgQiKIJWNETYA0Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179064899"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 02:50:19 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v6 2/2] net/idpf: enable AVX2 for split queue Tx
Date: Fri,  3 Oct 2025 15:19:50 +0530
Message-Id: <20251003094950.2818019-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003094950.2818019-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com/>
 <20251003094950.2818019-1-shaiq.wani@intel.com>
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
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 197 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
 3 files changed, 209 insertions(+)

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
index ae10ca981f..1d8f7dd0e3 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -800,3 +800,200 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
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
+			 IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
+
+		if (genid != cq->expected_gen_id)
+			break;
+
+		ctype = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
+			 IDPF_TXD_COMPLQ_COMPL_TYPE_M) >> IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+
+		txq_qid = (rte_le_to_cpu_16(compl_ring->qid_comptype_gen) &
+			   IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
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
+	const uint64_t hi_qw_tmpl = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE |
+		((uint64_t)flags);
+
+	/* align if needed */
+	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
+		idpf_splitq_vtx1_avx2(txdp, *pkt, flags);
+		txdp++, pkt++, nb_pkts--;
+	}
+
+	for (; nb_pkts >= IDPF_VPMD_DESCS_PER_LOOP;
+					txdp += IDPF_VPMD_DESCS_PER_LOOP,
+					pkt += IDPF_VPMD_DESCS_PER_LOOP,
+					nb_pkts -= IDPF_VPMD_DESCS_PER_LOOP) {
+		uint64_t hi_qw3 = hi_qw_tmpl |
+			((uint64_t)pkt[3]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw2 = hi_qw_tmpl |
+			((uint64_t)pkt[2]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw1 = hi_qw_tmpl |
+			((uint64_t)pkt[1]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+		uint64_t hi_qw0 = hi_qw_tmpl |
+			((uint64_t)pkt[0]->data_len << IDPF_TXD_QW1_TX_BUF_SZ_S);
+
+		__m256i desc2_3 = _mm256_set_epi64x(hi_qw3,
+			pkt[3]->buf_iova + pkt[3]->data_off,
+			hi_qw2,
+			pkt[2]->buf_iova + pkt[2]->data_off);
+
+		__m256i desc0_1 = _mm256_set_epi64x(hi_qw1,
+			pkt[1]->buf_iova + pkt[1]->data_off,
+			hi_qw0,
+			pkt[0]->buf_iova + pkt[0]->data_off);
+
+		_mm256_storeu_si256((__m256i *)(txdp + 2), desc2_3);
+		_mm256_storeu_si256((__m256i *)txdp, desc0_1);
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
+idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+						uint16_t nb_pkts)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	struct idpf_flex_tx_sched_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, tx_id;
+	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+	tx_id = txq->tx_tail;
+
+	/* restrict to max burst size */
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+
+	/* make sure we have enough free space */
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	nb_pkts = nb_commit;
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	txdp = (struct idpf_flex_tx_sched_desc *)&txq->desc_ring[tx_id];
+	txep = (void *)txq->sw_ring;
+	txep += tx_id;
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
+
+		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+		txdp = &txq->desc_ring[tx_id];
+		txep = (void *)txq->sw_ring;
+		txep += tx_id;
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs)
+		txq->tx_next_rs =
+		(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+
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
+		ret = idpf_splitq_xmit_fixed_burst_vec_avx2(tx_queue,
+								&tx_pkts[nb_tx], num);
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

