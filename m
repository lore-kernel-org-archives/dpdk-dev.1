Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4DD2F327
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED2540B8C;
	Tue, 13 Jan 2026 16:15:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E5F2F40A70
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317332; x=1799853332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xxk8KoF8/0WJi0Wx9wJyawsQya4mYwCUVhsDigEeg8o=;
 b=kIB3hFeyEGJMUJqHC/lNL7KCt3VkkaYC9r5xdVxMFkab0Kd4nvAaXMj/
 F1AxQNRWvuU14gxQ2Kr/IHgavo8NeR9swVPeM9OTm27HiBBVcZqSBKt+l
 40IEJNJWdjyAF5kqxvjyaIEet6M1mlRWuSQv2gH9TjCJj4N0ZA/Ns5FRw
 XLhwXH+RtWc/ydRJUchZNZqIMNXfoJVeyXsoLlg0uLQGc7inpuIw/5kC7
 ZpV0CGntrT4tvy70M9jNHFAxp8NbcjZQIyajJ3sj0INk0wjVVsOkDuSlR
 RhBD/RRZZl2YJ1riziLvyScBSlTRytN8Gj+B59zPhXy1fDlXnfsyEtapC g==;
X-CSE-ConnectionGUID: ag/UBW2qRGG9Cn/DXmFrrA==
X-CSE-MsgGUID: EuKwkVoNSSGcS1ErppHx8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969180"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969180"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:32 -0800
X-CSE-ConnectionGUID: Iu0VL5b+Qwa+dg/INCPYiQ==
X-CSE-MsgGUID: xbMfDJH8Qk+PhXkwjksRFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556594"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 13/36] net/i40e: use common scalar Tx function
Date: Tue, 13 Jan 2026 15:14:37 +0000
Message-ID: <20260113151505.1871271-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

Following earlier rework, the scalar transmit function for i40e can use
the common function previously moved over from ice driver. This saves
hundreds of duplicated lines of code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 206 +----------------------------
 1 file changed, 2 insertions(+), 204 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 617b93c92b..08a74fb1d4 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1020,210 +1020,8 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
-	struct ci_tx_queue *txq;
-	struct ci_tx_entry *sw_ring;
-	struct ci_tx_entry *txe, *txn;
-	volatile struct ci_tx_desc *txd;
-	volatile struct ci_tx_desc *txr;
-	struct rte_mbuf *tx_pkt;
-	struct rte_mbuf *m_seg;
-	uint16_t tx_id;
-	uint16_t nb_tx;
-	uint32_t td_cmd;
-	uint32_t td_offset;
-	uint32_t td_tag;
-	uint64_t ol_flags;
-	uint16_t nb_used;
-	uint16_t nb_ctx;
-	uint16_t tx_last;
-	uint16_t slen;
-	uint64_t buf_dma_addr;
-	union ci_tx_offload tx_offload = {0};
-
-	txq = tx_queue;
-	sw_ring = txq->sw_ring;
-	txr = txq->ci_tx_ring;
-	tx_id = txq->tx_tail;
-	txe = &sw_ring[tx_id];
-
-	/* Check if the descriptor ring needs to be cleaned. */
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)ci_tx_xmit_cleanup(txq);
-
-	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-		td_cmd = 0;
-		td_tag = 0;
-		td_offset = 0;
-
-		tx_pkt = *tx_pkts++;
-		RTE_MBUF_PREFETCH_TO_FREE(txe->mbuf);
-
-		ol_flags = tx_pkt->ol_flags;
-		tx_offload.l2_len = tx_pkt->l2_len;
-		tx_offload.l3_len = tx_pkt->l3_len;
-		tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
-		tx_offload.outer_l3_len = tx_pkt->outer_l3_len;
-		tx_offload.l4_len = tx_pkt->l4_len;
-		tx_offload.tso_segsz = tx_pkt->tso_segsz;
-
-		/* Calculate the number of context descriptors needed. */
-		uint64_t cd_qw0 = 0, cd_qw1 = 0;
-		nb_ctx = get_context_desc(ol_flags, tx_pkt, &tx_offload, txq, &td_offset,
-				&cd_qw0, &cd_qw1);
-
-		/**
-		 * The number of descriptors that must be allocated for
-		 * a packet equals to the number of the segments of that
-		 * packet plus 1 context descriptor if needed.
-		 * Recalculate the needed tx descs when TSO enabled in case
-		 * the mbuf data size exceeds max data size that hw allows
-		 * per tx desc.
-		 */
-		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
-		else
-			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
-		tx_last = (uint16_t)(tx_id + nb_used - 1);
-
-		/* Circular ring */
-		if (tx_last >= txq->nb_tx_desc)
-			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
-
-		if (nb_used > txq->nb_tx_free) {
-			if (ci_tx_xmit_cleanup(txq) != 0) {
-				if (nb_tx == 0)
-					return 0;
-				goto end_of_tx;
-			}
-			if (unlikely(nb_used > txq->tx_rs_thresh)) {
-				while (nb_used > txq->nb_tx_free) {
-					if (ci_tx_xmit_cleanup(txq) != 0) {
-						if (nb_tx == 0)
-							return 0;
-						goto end_of_tx;
-					}
-				}
-			}
-		}
-
-		/* Descriptor based VLAN insertion */
-		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
-			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
-			td_tag = tx_pkt->vlan_tci;
-		}
-
-		/* Always enable CRC offload insertion */
-		td_cmd |= CI_TX_DESC_CMD_ICRC;
-
-		/* Enable checksum offloading */
-		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			ci_txd_enable_checksum(ol_flags, &td_cmd,
-						 &td_offset, tx_offload);
-
-		if (nb_ctx) {
-			/* Setup TX context descriptor if required */
-			uint64_t *desc = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
-
-			txn = &sw_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf != NULL) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
-
-			desc[0] = cd_qw0;
-			desc[1] = cd_qw1;
-
-			PMD_TX_LOG(DEBUG, "mbuf: %p, TCD[%u]: "
-				"qw0: %#"PRIx64"; "
-				"qw1: %#"PRIx64";",
-				tx_pkt, tx_id, cd_qw0, cd_qw1);
-
-			txe->last_id = tx_last;
-			tx_id = txe->next_id;
-			txe = txn;
-		}
-
-		m_seg = tx_pkt;
-		do {
-			txd = &txr[tx_id];
-			txn = &sw_ring[txe->next_id];
-
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
-			txe->mbuf = m_seg;
-
-			/* Setup TX Descriptor */
-			slen = m_seg->data_len;
-			buf_dma_addr = rte_mbuf_data_iova(m_seg);
-
-			while ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
-				unlikely(slen > CI_MAX_DATA_PER_TXD)) {
-				txd->buffer_addr =
-					rte_cpu_to_le_64(buf_dma_addr);
-				txd->cmd_type_offset_bsz =
-					i40e_build_ctob(td_cmd,
-					td_offset, CI_MAX_DATA_PER_TXD,
-					td_tag);
-
-				buf_dma_addr += CI_MAX_DATA_PER_TXD;
-				slen -= CI_MAX_DATA_PER_TXD;
-
-				txe->last_id = tx_last;
-				tx_id = txe->next_id;
-				txe = txn;
-				txd = &txr[tx_id];
-				txn = &sw_ring[txe->next_id];
-			}
-			PMD_TX_LOG(DEBUG, "mbuf: %p, TDD[%u]: "
-				"buf_dma_addr: %#"PRIx64"; "
-				"td_cmd: %#x; "
-				"td_offset: %#x; "
-				"td_len: %u; "
-				"td_tag: %#x;",
-				tx_pkt, tx_id, buf_dma_addr,
-				td_cmd, td_offset, slen, td_tag);
-
-			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz = i40e_build_ctob(td_cmd,
-						td_offset, slen, td_tag);
-			txe->last_id = tx_last;
-			tx_id = txe->next_id;
-			txe = txn;
-			m_seg = m_seg->next;
-		} while (m_seg != NULL);
-
-		/* The last packet data descriptor needs End Of Packet (EOP) */
-		td_cmd |= CI_TX_DESC_CMD_EOP;
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
-		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
-
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
-			PMD_TX_LOG(DEBUG,
-				   "Setting RS bit on TXD id="
-				   "%4u (port=%d queue=%d)",
-				   tx_last, txq->port_id, txq->queue_id);
-
-			td_cmd |= CI_TX_DESC_CMD_RS;
-
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
-		}
-
-		txd->cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
-	}
-
-end_of_tx:
-	PMD_TX_LOG(DEBUG, "port_id=%u queue_id=%u tx_tail=%u nb_tx=%u",
-		   (unsigned) txq->port_id, (unsigned) txq->queue_id,
-		   (unsigned) tx_id, (unsigned) nb_tx);
-
-	rte_io_wmb();
-	I40E_PCI_REG_WC_WRITE_RELAXED(txq->qtx_tail, tx_id);
-	txq->tx_tail = tx_id;
-
-	return nb_tx;
+	/* i40e does not support timestamp queues, so pass NULL for ts_fns */
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

