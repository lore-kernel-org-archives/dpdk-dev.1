Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC97ECD6D6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69BAC40DFB;
	Wed, 11 Feb 2026 19:13:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id A7B7040B8C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833625; x=1802369625;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bZCOZ2PpV0Gyy+fwXhivkN4VNgiXgr2qb1CDF+ntNhQ=;
 b=d6mYCAJPgiV8n9MWVfs2bP6zx60/6arq+VJfzfHZbsx73vGB4JbnKIe1
 bFWqu1LZ8dmTHGRs6dWDiapse2rr0kIoIFuuikmA8KwMuhMPaeuDaU7ht
 NxoSmVUfvpO1Izqd/8YfYht9vP2PCga5aJ+vgFPNrpQzHH7hU0uD6Hy/7
 pHx8yk518KmL0R4rKcA0c+DwGwgoJ6XL5Ftp1H9xJfE7to4v9LvfJuq/N
 JNgcnhwmO3Dc9X5UGdea8Tfnz1Pa5eACQ2etVG82WcOsq17rVT7aE/AtP
 s0xDilCxP7D+EFVVV6Fw0sKF9IlshAQCklJA8nyu1Fr0H3FzTsxg34oIY w==;
X-CSE-ConnectionGUID: s8Bt9rzuSSicmWwcRnCyIQ==
X-CSE-MsgGUID: h6nXBxTIT/+ktIe20x/L3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834679"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834679"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:44 -0800
X-CSE-ConnectionGUID: uNctwMZsRPSnukLIdjtJUA==
X-CSE-MsgGUID: LugYA2nuRViiRYGH2ZQiDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986335"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:43 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 12/35] net/intel: create a common scalar Tx function
Date: Wed, 11 Feb 2026 18:12:41 +0000
Message-ID: <20260211181309.2838042-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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

Given the similarities between the transmit functions across various
Intel drivers, make a start on consolidating them by moving the ice Tx
function into common, for reuse by other drivers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 218 +++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c     | 270 ++++++---------------------
 2 files changed, 270 insertions(+), 218 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 9b19d56ea6..3616600a2d 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -6,6 +6,7 @@
 #define _COMMON_INTEL_TX_SCALAR_H_
 
 #include <stdint.h>
+#include <rte_io.h>
 #include <rte_byteorder.h>
 
 /* depends on common Tx definitions. */
@@ -129,5 +130,222 @@ ci_calc_pkt_desc(const struct rte_mbuf *tx_pkt)
 	return count;
 }
 
+typedef uint16_t (*ci_get_ctx_desc_fn)(uint64_t ol_flags, const struct rte_mbuf *mbuf,
+		const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
+		uint64_t *qw0, uint64_t *qw1);
+
+/* gets current timestamp tail index */
+typedef uint16_t (*get_ts_tail_t)(struct ci_tx_queue *txq);
+/* writes a timestamp descriptor and returns new tail index */
+typedef uint16_t (*write_ts_desc_t)(struct ci_tx_queue *txq, struct rte_mbuf *mbuf,
+		uint16_t tx_id, uint16_t ts_id);
+/* writes a timestamp tail index - doorbell */
+typedef void (*write_ts_tail_t)(struct ci_tx_queue *txq, uint16_t ts_id);
+
+struct ci_timestamp_queue_fns {
+	get_ts_tail_t get_ts_tail;
+	write_ts_desc_t write_ts_desc;
+	write_ts_tail_t write_ts_tail;
+};
+
+static inline uint16_t
+ci_xmit_pkts(struct ci_tx_queue *txq,
+	     struct rte_mbuf **tx_pkts,
+	     uint16_t nb_pkts,
+	     ci_get_ctx_desc_fn get_ctx_desc,
+	     const struct ci_timestamp_queue_fns *ts_fns)
+{
+	volatile struct ci_tx_desc *ci_tx_ring;
+	volatile struct ci_tx_desc *txd;
+	struct ci_tx_entry *sw_ring;
+	struct ci_tx_entry *txe, *txn;
+	struct rte_mbuf *tx_pkt;
+	struct rte_mbuf *m_seg;
+	uint16_t tx_id;
+	uint16_t ts_id = -1;
+	uint16_t nb_tx;
+	uint16_t nb_used;
+	uint16_t nb_ctx;
+	uint32_t td_cmd = 0;
+	uint32_t td_offset = 0;
+	uint32_t td_tag = 0;
+	uint16_t tx_last;
+	uint16_t slen;
+	uint16_t l2_len;
+	uint64_t buf_dma_addr;
+	uint64_t ol_flags;
+	union ci_tx_offload tx_offload = {0};
+
+	sw_ring = txq->sw_ring;
+	ci_tx_ring = txq->ci_tx_ring;
+	tx_id = txq->tx_tail;
+	txe = &sw_ring[tx_id];
+
+	if (ts_fns != NULL)
+		ts_id = ts_fns->get_ts_tail(txq);
+
+	/* Check if the descriptor ring needs to be cleaned. */
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		(void)ci_tx_xmit_cleanup(txq);
+
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		uint64_t cd_qw0 = 0, cd_qw1 = 0;
+		tx_pkt = *tx_pkts++;
+
+		ol_flags = tx_pkt->ol_flags;
+		td_cmd = CI_TX_DESC_CMD_ICRC;
+		td_tag = 0;
+		l2_len = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
+				tx_pkt->outer_l2_len : tx_pkt->l2_len;
+		td_offset = (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
+
+
+		tx_offload.l2_len = tx_pkt->l2_len;
+		tx_offload.l3_len = tx_pkt->l3_len;
+		tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
+		tx_offload.outer_l3_len = tx_pkt->outer_l3_len;
+		tx_offload.l4_len = tx_pkt->l4_len;
+		tx_offload.tso_segsz = tx_pkt->tso_segsz;
+
+		/* Calculate the number of context descriptors needed. */
+		nb_ctx = get_ctx_desc(ol_flags, tx_pkt, &tx_offload, txq, &cd_qw0, &cd_qw1);
+
+		/* The number of descriptors that must be allocated for
+		 * a packet equals to the number of the segments of that
+		 * packet plus the number of context descriptor if needed.
+		 * Recalculate the needed tx descs when TSO enabled in case
+		 * the mbuf data size exceeds max data size that hw allows
+		 * per tx desc.
+		 */
+		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
+		else
+			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
+		tx_last = (uint16_t)(tx_id + nb_used - 1);
+
+		/* Circular ring */
+		if (tx_last >= txq->nb_tx_desc)
+			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
+
+		if (nb_used > txq->nb_tx_free) {
+			if (ci_tx_xmit_cleanup(txq) != 0) {
+				if (nb_tx == 0)
+					return 0;
+				goto end_of_tx;
+			}
+			if (unlikely(nb_used > txq->tx_rs_thresh)) {
+				while (nb_used > txq->nb_tx_free) {
+					if (ci_tx_xmit_cleanup(txq) != 0) {
+						if (nb_tx == 0)
+							return 0;
+						goto end_of_tx;
+					}
+				}
+			}
+		}
+
+		/* Descriptor based VLAN insertion */
+		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
+			td_tag = tx_pkt->vlan_tci;
+		}
+
+		/* Enable checksum offloading */
+		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
+						&td_offset, tx_offload);
+
+		if (nb_ctx) {
+			/* Setup TX context descriptor if required */
+			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
+
+			txn = &sw_ring[txe->next_id];
+			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
+			if (txe->mbuf) {
+				rte_pktmbuf_free_seg(txe->mbuf);
+				txe->mbuf = NULL;
+			}
+
+			ctx_txd[0] = cd_qw0;
+			ctx_txd[1] = cd_qw1;
+
+			txe->last_id = tx_last;
+			tx_id = txe->next_id;
+			txe = txn;
+		}
+		m_seg = tx_pkt;
+
+		do {
+			txd = &ci_tx_ring[tx_id];
+			txn = &sw_ring[txe->next_id];
+
+			if (txe->mbuf)
+				rte_pktmbuf_free_seg(txe->mbuf);
+			txe->mbuf = m_seg;
+
+			/* Setup TX Descriptor */
+			slen = m_seg->data_len;
+			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+
+			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
+					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
+				txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
+				txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+					((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+					((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
+					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
+
+				buf_dma_addr += CI_MAX_DATA_PER_TXD;
+				slen -= CI_MAX_DATA_PER_TXD;
+
+				txe->last_id = tx_last;
+				tx_id = txe->next_id;
+				txe = txn;
+				txd = &ci_tx_ring[tx_id];
+				txn = &sw_ring[txe->next_id];
+			}
+
+			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
+			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
+				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
+				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
+				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
+				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
+
+			txe->last_id = tx_last;
+			tx_id = txe->next_id;
+			txe = txn;
+			m_seg = m_seg->next;
+		} while (m_seg);
+
+		/* fill the last descriptor with End of Packet (EOP) bit */
+		td_cmd |= CI_TX_DESC_CMD_EOP;
+		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
+		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
+
+		/* set RS bit on the last descriptor of one packet */
+		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
+			td_cmd |= CI_TX_DESC_CMD_RS;
+
+			/* Update txq RS bit counters */
+			txq->nb_tx_used = 0;
+		}
+		txd->cmd_type_offset_bsz |=
+				rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
+
+		if (ts_fns != NULL)
+			ts_id = ts_fns->write_ts_desc(txq, tx_pkt, tx_id, ts_id);
+	}
+end_of_tx:
+	/* update Tail register */
+	if (ts_fns != NULL)
+		ts_fns->write_ts_tail(txq, ts_id);
+	else
+		rte_write32_wc(tx_id, txq->qtx_tail);
+	txq->tx_tail = tx_id;
+
+	return nb_tx;
+}
 
 #endif /* _COMMON_INTEL_TX_SCALAR_H_ */
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 4792aa9a8b..561a6617a6 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3050,230 +3050,64 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	return 1;
 }
 
-uint16_t
-ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+static uint16_t
+ice_get_ts_tail(struct ci_tx_queue *txq)
 {
-	struct ci_tx_queue *txq;
-	volatile struct ci_tx_desc *ci_tx_ring;
-	volatile struct ci_tx_desc *txd;
-	struct ci_tx_entry *sw_ring;
-	struct ci_tx_entry *txe, *txn;
-	struct rte_mbuf *tx_pkt;
-	struct rte_mbuf *m_seg;
-	uint16_t tx_id;
-	uint16_t ts_id = -1;
-	uint16_t nb_tx;
-	uint16_t nb_used;
-	uint16_t nb_ctx;
-	uint32_t td_cmd = 0;
-	uint32_t td_offset = 0;
-	uint32_t td_tag = 0;
-	uint16_t tx_last;
-	uint16_t slen;
-	uint16_t l2_len;
-	uint64_t buf_dma_addr;
-	uint64_t ol_flags;
-	union ci_tx_offload tx_offload = {0};
-
-	txq = tx_queue;
-	sw_ring = txq->sw_ring;
-	ci_tx_ring = txq->ci_tx_ring;
-	tx_id = txq->tx_tail;
-	txe = &sw_ring[tx_id];
-
-	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		ts_id = txq->tsq->ts_tail;
-
-	/* Check if the descriptor ring needs to be cleaned. */
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)ci_tx_xmit_cleanup(txq);
-
-	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-		uint64_t cd_qw0, cd_qw1;
-		tx_pkt = *tx_pkts++;
-
-		ol_flags = tx_pkt->ol_flags;
-		td_cmd = 0;
-		td_tag = 0;
-		l2_len = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
-				tx_pkt->outer_l2_len : tx_pkt->l2_len;
-		td_offset = (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
-
-		tx_offload.l2_len = tx_pkt->l2_len;
-		tx_offload.l3_len = tx_pkt->l3_len;
-		tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
-		tx_offload.outer_l3_len = tx_pkt->outer_l3_len;
-		tx_offload.l4_len = tx_pkt->l4_len;
-		tx_offload.tso_segsz = tx_pkt->tso_segsz;
-
-		/* Calculate the number of context descriptors needed. */
-		nb_ctx = get_context_desc(ol_flags, tx_pkt, &tx_offload, txq, &cd_qw0, &cd_qw1);
-
-		/* The number of descriptors that must be allocated for
-		 * a packet equals to the number of the segments of that
-		 * packet plus the number of context descriptor if needed.
-		 * Recalculate the needed tx descs when TSO enabled in case
-		 * the mbuf data size exceeds max data size that hw allows
-		 * per tx desc.
-		 */
-		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
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
-		/* Enable checksum offloading */
-		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			ci_txd_enable_checksum(ol_flags, &td_cmd,
-						&td_offset, tx_offload);
-
-		if (nb_ctx) {
-			/* Setup TX context descriptor if required */
-			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
-
-			txn = &sw_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
-
-			ctx_txd[0] = cd_qw0;
-			ctx_txd[1] = cd_qw1;
-
-			txe->last_id = tx_last;
-			tx_id = txe->next_id;
-			txe = txn;
-		}
-		m_seg = tx_pkt;
-
-		do {
-			txd = &ci_tx_ring[tx_id];
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
-			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
-					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
-				txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-				txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-					((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
-					((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
-					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
-					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
-
-				buf_dma_addr += CI_MAX_DATA_PER_TXD;
-				slen -= CI_MAX_DATA_PER_TXD;
-
-				txe->last_id = tx_last;
-				tx_id = txe->next_id;
-				txe = txn;
-				txd = &ci_tx_ring[tx_id];
-				txn = &sw_ring[txe->next_id];
-			}
-
-			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
-				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
-				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
-
-			txe->last_id = tx_last;
-			tx_id = txe->next_id;
-			txe = txn;
-			m_seg = m_seg->next;
-		} while (m_seg);
+	return txq->tsq->ts_tail;
+}
 
-		/* fill the last descriptor with End of Packet (EOP) bit */
-		td_cmd |= CI_TX_DESC_CMD_EOP;
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
-		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
+static uint16_t
+ice_write_ts_desc(struct ci_tx_queue *txq,
+		  struct rte_mbuf *tx_pkt,
+		  uint16_t tx_id,
+		  uint16_t ts_id)
+{
+	uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt, txq->tsq->ts_offset, uint64_t *);
+	uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >> ICE_TXTIME_CTX_RESOLUTION_128NS;
+	const uint32_t desc_tx_id = (tx_id == 0) ? txq->nb_tx_desc : tx_id;
+	__le32 ts_desc = rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M, desc_tx_id) |
+			FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
+
+	txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
+	ts_id++;
+
+	/* To prevent an MDD, when wrapping the tstamp
+	 * ring create additional TS descriptors equal
+	 * to the number of the fetch TS descriptors
+	 * value. HW will merge the TS descriptors with
+	 * the same timestamp value into a single
+	 * descriptor.
+	 */
+	if (ts_id == txq->tsq->nb_ts_desc) {
+		uint16_t fetch = txq->tsq->nb_ts_desc - txq->nb_tx_desc;
+		ts_id = 0;
+		for (; ts_id < fetch; ts_id++)
+			txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
+	}
+	return ts_id;
+}
 
-		/* set RS bit on the last descriptor of one packet */
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
-			PMD_TX_LOG(DEBUG,
-				   "Setting RS bit on TXD id="
-				   "%4u (port=%d queue=%d)",
-				   tx_last, txq->port_id, txq->queue_id);
+static void
+ice_write_ts_tail(struct ci_tx_queue *txq, uint16_t ts_tail)
+{
+	ICE_PCI_REG_WRITE(txq->qtx_tail, ts_tail);
+	txq->tsq->ts_tail = ts_tail;
+}
 
-			td_cmd |= CI_TX_DESC_CMD_RS;
+uint16_t
+ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	const struct ci_timestamp_queue_fns ts_fns = {
+		.get_ts_tail = ice_get_ts_tail,
+		.write_ts_desc = ice_write_ts_desc,
+		.write_ts_tail = ice_write_ts_tail,
+	};
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
-		}
-		txd->cmd_type_offset_bsz |=
-			rte_cpu_to_le_64(((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S);
-
-		if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
-			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
-					txq->tsq->ts_offset, uint64_t *);
-			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
-						ICE_TXTIME_CTX_RESOLUTION_128NS;
-			const uint32_t desc_tx_id = (tx_id == 0) ? txq->nb_tx_desc : tx_id;
-			__le32 ts_desc = rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
-					desc_tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
-			txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
-			ts_id++;
-			/* To prevent an MDD, when wrapping the tstamp
-			 * ring create additional TS descriptors equal
-			 * to the number of the fetch TS descriptors
-			 * value. HW will merge the TS descriptors with
-			 * the same timestamp value into a single
-			 * descriptor.
-			 */
-			if (ts_id == txq->tsq->nb_ts_desc) {
-				uint16_t fetch = txq->tsq->nb_ts_desc - txq->nb_tx_desc;
-				ts_id = 0;
-				for (; ts_id < fetch; ts_id++)
-					txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
-			}
-		}
-	}
-end_of_tx:
-	/* update Tail register */
-	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
-		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
-		txq->tsq->ts_tail = ts_id;
-	} else {
-		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
-	}
-	txq->tx_tail = tx_id;
+	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, &ts_fns);
 
-	return nb_tx;
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

