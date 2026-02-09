Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9150E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:49:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7490040ED2;
	Mon,  9 Feb 2026 17:46:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B7E1740E42
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655579; x=1802191579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/8Bd2LZLK2HTn48sR71zEvIsCTyCXs/7koBhI2L1h+8=;
 b=Fz2jtyGL1mA4uy9RQF8Bpqb0n6oj3diZegfl0XluO4kD38wWfJMYHhD6
 KxX9x6DLNB/GG1V7WJZbkdXsiU0nDIKcxDGiHRbx1LP0oWQbOmwBZBBu0
 g4QS0lKOpgXS6mcaoGhhdxftZorGjg09oOOliVhjyztcecPzy0DSgmDIo
 tHrPgMLL80/b5tGPfEW+N/zZ/OuWTFEAp/MV19jslaQfASGFBFlyp4cGE
 WTUj5AlrlP76HJnvDnOkDKGubKclBNl1yVuibjTgp8cStu4RWhFcd+zpZ
 zzwPhBEnTCNyxKH/gOqryBq45t1wkDKau6kOL7MLUUGB46WBZ0PBIiaPG A==;
X-CSE-ConnectionGUID: 5/xNjQNHTNeVBRDrKHxrAQ==
X-CSE-MsgGUID: avlSQL1EQnWZ+ksYBTUXfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663512"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663512"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:18 -0800
X-CSE-ConnectionGUID: Zo5zpiLvTyueu1E2b/dAtg==
X-CSE-MsgGUID: 8ebdSPLWQdu9wusTE7oqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789217"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 32/35] net/intel: align scalar simple Tx path with vector
 logic
Date: Mon,  9 Feb 2026 16:45:30 +0000
Message-ID: <20260209164538.1428499-33-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

The scalar simple Tx path has the same restrictions as the vector Tx
path, so we can use the same logic flow in both, to try and ensure we
get best performance from the scalar path.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 54 +++++++++++++++++-----------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 918cd806a4..2405d6a2f0 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -21,13 +21,11 @@ write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
 	txd_qw[1] = rte_cpu_to_le_64(qw1);
 }
 
-/* Fill hardware descriptor ring with mbuf data */
+/* Fill hardware descriptor ring with mbuf data (simple path) */
 static inline void
-ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
-		   uint16_t nb_pkts)
+ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts,
+			  uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txdp = &txq->ci_tx_ring[txq->tx_tail];
-	struct ci_tx_entry *txep = &txq->sw_ring[txq->tx_tail];
 	const int N_PER_LOOP = 4;
 	const int N_PER_LOOP_MASK = N_PER_LOOP - 1;
 	int mainpart, leftover;
@@ -36,8 +34,6 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	mainpart = nb_pkts & ((uint32_t)~N_PER_LOOP_MASK);
 	leftover = nb_pkts & ((uint32_t)N_PER_LOOP_MASK);
 	for (i = 0; i < mainpart; i += N_PER_LOOP) {
-		for (j = 0; j < N_PER_LOOP; ++j)
-			(txep + i + j)->mbuf = *(pkts + i + j);
 		for (j = 0; j < N_PER_LOOP; ++j)
 			write_txd(txdp + i + j, rte_mbuf_data_iova(*(pkts + i + j)),
 				CI_TX_DESC_DTYPE_DATA |
@@ -48,12 +44,10 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	if (unlikely(leftover > 0)) {
 		for (i = 0; i < leftover; ++i) {
 			uint16_t idx = mainpart + i;
-			(txep + idx)->mbuf = *(pkts + idx);
 			write_txd(txdp + idx, rte_mbuf_data_iova(*(pkts + idx)),
 				CI_TX_DESC_DTYPE_DATA |
 				((uint64_t)CI_TX_DESC_CMD_DEFAULT << CI_TXD_QW1_CMD_S) |
 				((uint64_t)(*(pkts + idx))->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
-
 		}
 	}
 }
@@ -130,6 +124,9 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 		     uint16_t nb_pkts)
 {
 	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry *txep;
+	uint16_t tx_id;
 	uint16_t n = 0;
 
 	/**
@@ -145,23 +142,41 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 	if (unlikely(!nb_pkts))
 		return 0;
 
+	tx_id = txq->tx_tail;
+	txdp = &txr[tx_id];
+	txep = &txq->sw_ring[tx_id];
+
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
-	if ((txq->tx_tail + nb_pkts) > txq->nb_tx_desc) {
-		n = (uint16_t)(txq->nb_tx_desc - txq->tx_tail);
-		ci_tx_fill_hw_ring(txq, tx_pkts, n);
+
+	if ((tx_id + nb_pkts) > txq->nb_tx_desc) {
+		n = (uint16_t)(txq->nb_tx_desc - tx_id);
+
+		/* Store mbufs in backlog */
+		ci_tx_backlog_entry(txep, tx_pkts, n);
+
+		/* Write descriptors to HW ring */
+		ci_tx_fill_hw_ring_simple(txdp, tx_pkts, n);
+
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
 					  CI_TXD_QW1_CMD_S);
 		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
-		txq->tx_tail = 0;
+
+		tx_id = 0;
+		txdp = &txr[tx_id];
+		txep = &txq->sw_ring[tx_id];
 	}
 
-	/* Fill hardware descriptor ring with mbuf data */
-	ci_tx_fill_hw_ring(txq, tx_pkts + n, (uint16_t)(nb_pkts - n));
-	txq->tx_tail = (uint16_t)(txq->tx_tail + (nb_pkts - n));
+	/* Store remaining mbufs in backlog */
+	ci_tx_backlog_entry(txep, tx_pkts + n, (uint16_t)(nb_pkts - n));
+
+	/* Write remaining descriptors to HW ring */
+	ci_tx_fill_hw_ring_simple(txdp, tx_pkts + n, (uint16_t)(nb_pkts - n));
+
+	tx_id = (uint16_t)(tx_id + (nb_pkts - n));
 
 	/* Determine if RS bit needs to be set */
-	if (txq->tx_tail > txq->tx_next_rs) {
+	if (tx_id > txq->tx_next_rs) {
 		txr[txq->tx_next_rs].cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
 					  CI_TXD_QW1_CMD_S);
@@ -171,11 +186,10 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 			txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 	}
 
-	if (txq->tx_tail >= txq->nb_tx_desc)
-		txq->tx_tail = 0;
+	txq->tx_tail = tx_id;
 
 	/* Update the tx tail register */
-	rte_write32_wc((uint32_t)txq->tx_tail, txq->qtx_tail);
+	rte_write32_wc((uint32_t)tx_id, txq->qtx_tail);
 
 	return nb_pkts;
 }
-- 
2.51.0

