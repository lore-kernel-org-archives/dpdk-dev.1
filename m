Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29CFFC5913
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:46:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00A8D4060C;
	Thu, 26 Feb 2026 10:45:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 433E4402EE
 for <dev@dpdk.org>; Thu, 26 Feb 2026 10:45:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772099149; x=1803635149;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jnA2uqL6+wmALyaRUgX+hss1f4XeBcj76JkmMNxcsP8=;
 b=V0UjioyMpBOCewGbCvR3qBsXNipDyoDO+YKlK+Ji8SAiMf/Bxy71Qwzo
 SETDczILQrMdUFdipIGFnaj3eCgjvbAWIn6w9ZCo9UAWIAPyFDCmTyxZN
 f22SjOE59AT8kOaZsXjNLZK2vsBONYPr+pDXmqgSEXBmJTjlorb+/Cu9m
 lJPOfyT5KJLXhtT4/wFy2fTRxCOip+VgONME/tarr54+MV6USq5f8AYDP
 Wj5rmaUpxlJ7V5hQ+zdc0tUjzl1dnNhjMDDnsPtyK5SLbd1za4pFbINdx
 0anDk+RexBVMk/zwnr2R5Cm+o15nv5pnrDEKy3pFRhSXvCan8YrTn5jkN w==;
X-CSE-ConnectionGUID: xpnFoYlnTEy4T1enXO3owA==
X-CSE-MsgGUID: +isXT25xSGuJYCZatL7Vpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73259095"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73259095"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 01:45:49 -0800
X-CSE-ConnectionGUID: akmuCw7FS/qHmaVpvcKCPw==
X-CSE-MsgGUID: PLALtbXqSM22dFQv3M+IWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="221021310"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa004.jf.intel.com with ESMTP; 26 Feb 2026 01:45:48 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v14 2/3] net/idpf: enable AVX2 for split queue Tx
Date: Thu, 26 Feb 2026 15:12:21 +0530
Message-Id: <20260226094222.1393288-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226094222.1393288-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260226094222.1393288-1-shaiq.wani@intel.com>
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

Add AVX2 vectorized split queue Tx path with
completion queue scanning support.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst        |   4 +
 drivers/net/intel/idpf/idpf_common_device.h   |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   8 +
 drivers/net/intel/idpf/idpf_common_rxtx.h     |   3 +
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 173 ++++++++++++++++++
 5 files changed, 189 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..2c78b62632 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -77,6 +77,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated Intel idpf driver.**
+
+  * Added AVX2 vectorized split queue Rx and Tx paths.
+
 * **Updated Marvell cnxk net driver.**
 
   * Added out-of-place support for CN20K SoC.
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 1424046a16..6f3dfbc3fc 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -81,6 +81,7 @@ enum idpf_tx_func_type {
 	IDPF_TX_SINGLEQ,
 	IDPF_TX_SINGLEQ_SIMPLE,
 	IDPF_TX_SINGLEQ_AVX2,
+	IDPF_TX_AVX2,
 	IDPF_TX_AVX512,
 	IDPF_TX_SINGLEQ_AVX512,
 	/* Need a max value defined as array values in are defined
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index ead31fd0f8..8e964bef5c 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1620,6 +1620,14 @@ const struct ci_tx_path_info idpf_tx_path_infos[] = {
 			.single_queue = true
 		}
 	},
+	[IDPF_TX_AVX2] = {
+		.pkt_burst = idpf_dp_splitq_xmit_pkts_avx2,
+		.info = "Split AVX2",
+		.features = {
+			.tx_offloads = IDPF_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256
+		}
+	},
 #ifdef CC_AVX512_SUPPORT
 	[IDPF_TX_AVX512] = {
 		.pkt_burst = idpf_dp_splitq_xmit_pkts_avx512,
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 256e9ff54c..2c4ebb21e4 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -257,6 +257,9 @@ __rte_internal
 uint16_t idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts);
 __rte_internal
+uint16_t idpf_dp_splitq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
+				       uint16_t nb_pkts);
+__rte_internal
 uint16_t idpf_dp_singleq_recv_pkts_avx2(void *rx_queue,
 					struct rte_mbuf **rx_pkts,
 					uint16_t nb_pkts);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 0122c82951..3ccd517c46 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -780,3 +780,176 @@ idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 
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
+	for (i = 0; i < IDPF_TXQ_SCAN_CQ_THRESH; i++) {
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
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx2)
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
-- 
2.34.1

