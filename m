Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01216C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BAA042EA5;
	Tue, 15 Sep 2026 15:37:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 826D842E88
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789479445; x=1821015445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GhKcz0aJcbsAuT/S9mlSQhaj7+LwAiD3QnBmYb2qPPk=;
 b=PRXwf4tm4sHjJgU7hRX9v7qzI2ry6+/Ih4S9UqhEH4uXWfTM3Jz/IwV3
 4SvlE3Vd5oJsYK2pDT/f2abMG2gnczOxThgsui102jMspHmspYlJClehN
 yCiH4LA3y6jwGRdLQfjRcKrPxFG+/lXDTdQQhLzD+/EjKcMPe22Ajxoby
 WCg5p+rlIWqHhw1sn7qbHdS7EJ8hiGK2pA4fvp2KghzzCFIOvxceXx45U
 G/a6RoX547+3wtCPq2CuYXPT7F7IMVLBBv+Pr0OPeUmf+OPe5ZabC4m4d
 X3RAIkdAkzdiLoyobe+fLq5GUGC3Sl64fiU+Oou7jSXaMP+6tMY3/l3XR w==;
X-CSE-ConnectionGUID: sHmkyQjXQIeMWdJ/pbUHVw==
X-CSE-MsgGUID: tGfIL0dVTBKvs607TTO6sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972533"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89972533"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:37:25 -0700
X-CSE-ConnectionGUID: 0V85qmrkSVmDl+u6T8/xHg==
X-CSE-MsgGUID: L6vIugPESlmzdQu7SnWqNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266800764"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by fmviesa009.fm.intel.com with ESMTP; 15 Sep 2026 06:37:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 12/15] net/intel: add common vector Tx fns with context
 handling
Date: Tue, 15 Sep 2026 14:36:49 +0100
Message-ID: <20260915133654.278780-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915133654.278780-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260915133654.278780-1-bruce.richardson@intel.com>
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

The iavf vector driver has support for more Tx offloads because it has
Tx functions which handle transmit context descriptors. Move those
context-handling functions to the common folder for reuse by other
drivers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx_vec_x86.h         | 136 ++++++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  78 +---------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  89 +-----------
 3 files changed, 147 insertions(+), 156 deletions(-)

diff --git a/drivers/net/intel/common/tx_vec_x86.h b/drivers/net/intel/common/tx_vec_x86.h
index 946dcc1f2e..cbc7855f99 100644
--- a/drivers/net/intel/common/tx_vec_x86.h
+++ b/drivers/net/intel/common/tx_vec_x86.h
@@ -408,6 +408,74 @@ ci_xmit_fixed_burst_vec_avx2(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkts,
 	return nb_pkts;
 }
 
+static __rte_always_inline uint16_t
+ci_xmit_fixed_burst_vec_ctx_avx2(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts, bool offload,
+		enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		ci_tx_ctx_lldp_fn lldp_check)
+{
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, nb_mbuf, tx_id;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ci_tx_desc_done_simple, true);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts << 1);
+	nb_commit &= 0xFFFE;
+	if (unlikely(nb_commit == 0))
+		return 0;
+
+	nb_pkts = nb_commit >> 1;
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = (void *)txq->sw_ring;
+	txep += (tx_id >> 1);
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+	if (n != 0 && nb_commit >= n) {
+		nb_mbuf = n >> 1;
+		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+		ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
+				single_vlan_pos, qinq_outer_pos, lldp_check);
+		tx_pkts += (nb_mbuf - 1);
+		txdp += (n - 2);
+		ci_vtx1_ctx_avx2(txdp, *tx_pkts++, rs, offload,
+				single_vlan_pos, qinq_outer_pos, lldp_check);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		tx_id = 0;
+		/* avoid reach the end of ring */
+		txdp = txq->ci_tx_ring;
+		txep = (void *)txq->sw_ring;
+	}
+
+	nb_mbuf = nb_commit >> 1;
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+	ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf, flags, offload,
+			single_vlan_pos, qinq_outer_pos, lldp_check);
+	tx_id = (uint16_t)(tx_id + nb_commit);
+
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	ci_tx_qtx_tail_write(txq, tx_id);
+	return nb_pkts;
+}
+
 #endif /* __AVX2__ */
 
 #ifdef __AVX512VL__
@@ -640,6 +708,74 @@ ci_xmit_fixed_burst_vec_avx512(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkt
 	return nb_pkts;
 }
 
+static __rte_always_inline uint16_t
+ci_xmit_fixed_burst_vec_ctx_avx512(struct ci_tx_queue *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts, bool offload,
+		enum ci_l2tag_pos single_vlan_pos, enum ci_l2tag_pos qinq_outer_pos,
+		ci_tx_ctx_lldp_fn lldp_check)
+{
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, nb_mbuf, tx_id;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ci_tx_desc_done_simple, true);
+
+	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts << 1);
+	nb_commit &= 0xFFFE;
+	if (unlikely(nb_commit == 0))
+		return 0;
+
+	nb_pkts = nb_commit >> 1;
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = (void *)txq->sw_ring;
+	txep += (tx_id >> 1);
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+	if (n != 0 && nb_commit >= n) {
+		nb_mbuf = n >> 1;
+		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+		ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
+				single_vlan_pos, qinq_outer_pos, lldp_check);
+		tx_pkts += (nb_mbuf - 1);
+		txdp += (n - 2);
+		ci_vtx1_ctx_avx512(txdp, *tx_pkts++, rs, offload,
+				single_vlan_pos, qinq_outer_pos, lldp_check);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+		tx_id = 0;
+		/* avoid reach the end of ring */
+		txdp = txq->ci_tx_ring;
+		txep = (void *)txq->sw_ring;
+	}
+
+	nb_mbuf = nb_commit >> 1;
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
+
+	ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf, flags, offload,
+			single_vlan_pos, qinq_outer_pos, lldp_check);
+	tx_id = (uint16_t)(tx_id + nb_commit);
+
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs = (uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	ci_tx_qtx_tail_write(txq, tx_id);
+	return nb_pkts;
+}
+
 #endif /* __AVX512VL__ */
 
 #endif /* _COMMON_INTEL_TX_VEC_X86_H_ */
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 1289581038..833d553343 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1626,92 +1626,24 @@ iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
 }
 
 static __rte_always_inline uint16_t
-iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
-				 uint16_t nb_pkts, bool offload)
+iavf_xmit_pkts_vec_avx2_ctx_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
+				  uint16_t nb_pkts, bool offload)
 {
+	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, nb_mbuf, tx_id;
-	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
-	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
 	ci_tx_ctx_lldp_fn lldp_check = txq->lldp_enabled ? iavf_tx_ctx_lldp_check : NULL;
 	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
 	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
 			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
-
-	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts << 1);
-	nb_commit &= 0xFFFE;
-	if (unlikely(nb_commit == 0))
-		return 0;
-
-	nb_pkts = nb_commit >> 1;
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = (void *)txq->sw_ring;
-	txep += (tx_id >> 1);
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-
-	if (n != 0 && nb_commit >= n) {
-		nb_mbuf = n >> 1;
-		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
-
-		ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
-				vlan_pos, vlan_pos, lldp_check);
-		tx_pkts += (nb_mbuf - 1);
-		txdp += (n - 2);
-		ci_vtx1_ctx_avx2(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_check);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		tx_id = 0;
-		/* avoid reach the end of ring */
-		txdp = txq->ci_tx_ring;
-		txep = (void *)txq->sw_ring;
-	}
-
-	nb_mbuf = nb_commit >> 1;
-	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
-
-	ci_vtx_ctx_avx2(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_check);
-	tx_id = (uint16_t)(tx_id + nb_commit);
-
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
-					 IAVF_TXD_QW1_CMD_SHIFT);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-	return nb_pkts;
-}
-
-static __rte_always_inline uint16_t
-iavf_xmit_pkts_vec_avx2_ctx_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
-				  uint16_t nb_pkts, bool offload)
-{
-	uint16_t nb_tx = 0;
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-
 	while (nb_pkts) {
 		uint16_t ret, num;
 
 		/* cross rs_thresh boundary is not allowed */
 		num = (uint16_t)RTE_MIN(nb_pkts << 1, txq->tx_rs_thresh);
 		num = num >> 1;
-		ret = iavf_xmit_fixed_burst_vec_avx2_ctx(tx_queue, &tx_pkts[nb_tx],
-						       num, offload);
+		ret = ci_xmit_fixed_burst_vec_ctx_avx2(txq, &tx_pkts[nb_tx], num,
+				offload, vlan_pos, vlan_pos, lldp_check);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 9f773f226b..c5aa860f81 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1817,16 +1817,6 @@ iavf_recv_scattered_pkts_vec_avx512_flex_rxd_offload(void *rx_queue,
 								true);
 }
 
-static __rte_always_inline void
-tx_backlog_entry_avx512(struct ci_tx_entry_vec *txep,
-			struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-{
-	int i;
-
-	for (i = 0; i < (int)nb_pkts; ++i)
-		txep[i].mbuf = tx_pkts[i];
-}
-
 #define IAVF_TX_LEN_MASK 0xAA
 #define IAVF_TX_OFF_MASK 0x55
 
@@ -1838,77 +1828,6 @@ iavf_tx_ctx_lldp_check(struct rte_mbuf *pkt, uint64_t high_ctx_qw)
 	return high_ctx_qw;
 }
 
-static __rte_always_inline uint16_t
-iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
-				 uint16_t nb_pkts, bool offload)
-{
-	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
-	volatile struct ci_tx_desc *txdp;
-	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit, nb_mbuf, tx_id;
-	/* bit2 is reserved and must be set to 1 according to Spec */
-	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
-	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
-	ci_tx_ctx_lldp_fn lldp_check = txq->lldp_enabled ? iavf_tx_ctx_lldp_check : NULL;
-	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
-	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
-			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
-
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
-
-	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts << 1);
-	nb_commit &= 0xFFFE;
-	if (unlikely(nb_commit == 0))
-		return 0;
-
-	nb_pkts = nb_commit >> 1;
-	tx_id = txq->tx_tail;
-	txdp = &txq->ci_tx_ring[tx_id];
-	txep = (void *)txq->sw_ring;
-	txep += (tx_id >> 1);
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_commit);
-	n = (uint16_t)(txq->nb_tx_desc - tx_id);
-
-	if (n != 0 && nb_commit >= n) {
-		nb_mbuf = n >> 1;
-		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
-
-		ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf - 1, flags, offload,
-				vlan_pos, vlan_pos, lldp_check);
-		tx_pkts += (nb_mbuf - 1);
-		txdp += (n - 2);
-		ci_vtx1_ctx_avx512(txdp, *tx_pkts++, rs, offload, vlan_pos, vlan_pos, lldp_check);
-
-		nb_commit = (uint16_t)(nb_commit - n);
-
-		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		tx_id = 0;
-		/* avoid reach the end of ring */
-		txdp = txq->ci_tx_ring;
-		txep = (void *)txq->sw_ring;
-	}
-
-	nb_mbuf = nb_commit >> 1;
-	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
-
-	ci_vtx_ctx_avx512(txdp, tx_pkts, nb_mbuf, flags, offload, vlan_pos, vlan_pos, lldp_check);
-	tx_id = (uint16_t)(tx_id + nb_commit);
-
-	if (tx_id > txq->tx_next_rs) {
-		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) << CI_TXD_QW1_CMD_S);
-		txq->tx_next_rs =
-			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
-	}
-
-	txq->tx_tail = tx_id;
-
-	IAVF_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
-	return nb_pkts;
-}
-
 static __rte_always_inline uint16_t
 iavf_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 			      uint16_t nb_pkts, bool offload)
@@ -1955,6 +1874,10 @@ iavf_xmit_pkts_vec_avx512_ctx_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 {
 	uint16_t nb_tx = 0;
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	ci_tx_ctx_lldp_fn lldp_check = txq->lldp_enabled ? iavf_tx_ctx_lldp_check : NULL;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;
 
 	while (nb_pkts) {
 		uint16_t ret, num;
@@ -1962,8 +1885,8 @@ iavf_xmit_pkts_vec_avx512_ctx_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* cross rs_thresh boundary is not allowed */
 		num = (uint16_t)RTE_MIN(nb_pkts << 1, txq->tx_rs_thresh);
 		num = num >> 1;
-		ret = iavf_xmit_fixed_burst_vec_avx512_ctx(tx_queue, &tx_pkts[nb_tx],
-						       num, offload);
+		ret = ci_xmit_fixed_burst_vec_ctx_avx512(txq, &tx_pkts[nb_tx], num,
+				offload, vlan_pos, vlan_pos, lldp_check);
 		nb_tx += ret;
 		nb_pkts -= ret;
 		if (ret < num)
-- 
2.53.0

