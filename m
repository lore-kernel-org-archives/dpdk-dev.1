Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BCAE6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5325440B97;
	Fri, 30 Jan 2026 12:42:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0BFFD40A6F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773362; x=1801309362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D31r/EHyYkpwbhFS/sVxc107i6QKS0n6OEhMJZX5lY4=;
 b=IpQVGM7bXmC5atgp4enXvSKQsGuP+mid0/MsWA62wRDKXLxX9wMEqH7H
 cy4BQrsowYNrtoeQBvqdeqhAxVyVvp3ZhhJYMCOFHZBCBeHixI7iBqwb4
 VL04sz/OpEO1Vc4J7M/rL4MKhfaswrOjlct24xwj90hDQ8lJFhWJoe9/W
 KSgbb1/tpXCU1G9UAx1K75KFDNIMV3riNJcxsHcj8S59yhX2YyVgyKkUK
 AT13keaueKK6QDSiElQCZ+q8+1jhA1EXkj2zoA/62pwapOnp/LbrOfMM9
 fFcO1jR7Kf7Yx8bDV9C0TRDxYaP9lbhZJPzbjGpTC/bd5PSx+4Gjwl3n4 w==;
X-CSE-ConnectionGUID: mZ9yQT8tSiaV38DXAhn3uQ==
X-CSE-MsgGUID: INisa3MsRXG1c5avElwWdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392314"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392314"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:41 -0800
X-CSE-ConnectionGUID: 7h5FqUccSfilj4vFX9u+Iw==
X-CSE-MsgGUID: Srd8GIzgQFWCs1LbCbPJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190520"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v3 18/36] net/idpf: use common scalar Tx function
Date: Fri, 30 Jan 2026 11:41:45 +0000
Message-ID: <20260130114207.1126032-19-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

Update idpf driver to use the common scalar Tx function in single-queue
configuration.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/idpf_common_rxtx.c | 178 ++--------------------
 1 file changed, 10 insertions(+), 168 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index b34d545a0a..bca5f13c8e 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -8,7 +8,6 @@
 
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
-#include "../common/rx.h"
 
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
@@ -848,9 +847,10 @@ idpf_calc_context_desc(uint64_t flags)
 /* set TSO context descriptor, returns 0 if no context needed, 1 if context set
  */
 static inline uint16_t
-idpf_set_tso_ctx(uint64_t ol_flags, struct rte_mbuf *mbuf,
-			union ci_tx_offload tx_offload,
-			uint64_t *qw0, uint64_t *qw1)
+idpf_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf,
+		 const union ci_tx_offload *tx_offload,
+		 const struct ci_tx_queue *txq __rte_unused,
+		 uint64_t *qw0, uint64_t *qw1)
 {
 	uint16_t cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX | IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
 	uint16_t tso_segsz = mbuf->tso_segsz;
@@ -861,12 +861,12 @@ idpf_set_tso_ctx(uint64_t ol_flags, struct rte_mbuf *mbuf,
 		return 0;
 
 	/* TSO context descriptor setup */
-	if (tx_offload.l4_len == 0) {
+	if (tx_offload->l4_len == 0) {
 		TX_LOG(DEBUG, "L4 length set to 0");
 		return 0;
 	}
 
-	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
+	hdr_len = tx_offload->l2_len + tx_offload->l3_len + tx_offload->l4_len;
 	tso_len = mbuf->pkt_len - hdr_len;
 
 	*qw0 = rte_cpu_to_le_32(tso_len & IDPF_TXD_FLEX_CTX_MSS_RT_M) |
@@ -933,7 +933,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 		/* Calculate the number of context descriptors needed. */
 		uint64_t cd_qw0, cd_qw1;
-		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
+		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, &tx_offload, txq,
+					  &cd_qw0, &cd_qw1);
 
 		/* Calculate the number of TX descriptors needed for
 		 * each packet. For TSO packets, use ci_calc_pkt_desc as
@@ -1339,167 +1340,8 @@ uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
-	volatile struct ci_tx_desc *txd;
-	volatile struct ci_tx_desc *txr;
-	union ci_tx_offload tx_offload = {0};
-	struct ci_tx_entry *txe, *txn;
-	struct ci_tx_entry *sw_ring;
-	struct ci_tx_queue *txq;
-	struct rte_mbuf *tx_pkt;
-	struct rte_mbuf *m_seg;
-	uint64_t buf_dma_addr;
-	uint32_t td_offset;
-	uint64_t ol_flags;
-	uint16_t tx_last;
-	uint16_t nb_used;
-	uint16_t nb_ctx;
-	uint16_t td_cmd;
-	uint16_t tx_id;
-	uint16_t nb_tx;
-	uint16_t slen;
-
-	nb_tx = 0;
-	txq = tx_queue;
-
-	if (unlikely(txq == NULL))
-		return nb_tx;
-
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
-		td_offset = 0;
-
-		tx_pkt = *tx_pkts++;
-		RTE_MBUF_PREFETCH_TO_FREE(txe->mbuf);
-
-		ol_flags = tx_pkt->ol_flags;
-		tx_offload.l2_len = tx_pkt->l2_len;
-		tx_offload.l3_len = tx_pkt->l3_len;
-		tx_offload.l4_len = tx_pkt->l4_len;
-		tx_offload.tso_segsz = tx_pkt->tso_segsz;
-		/* Calculate the number of context descriptors needed. */
-		uint64_t cd_qw0, cd_qw1;
-		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
-
-		/* The number of descriptors that must be allocated for
-		 * a packet. For TSO packets, use ci_calc_pkt_desc as
-		 * the mbuf data size might exceed max data size that hw allows
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
-		TX_LOG(DEBUG, "port_id=%u queue_id=%u"
-		       " tx_first=%u tx_last=%u",
-		       txq->port_id, txq->queue_id, tx_id, tx_last);
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
-		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			td_cmd |= IDPF_TX_FLEX_DESC_CMD_CS_EN;
-
-		if (nb_ctx != 0) {
-			/* Setup TX context descriptor if required */
-			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
-
-			txn = &sw_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf != NULL) {
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
-
-		m_seg = tx_pkt;
-		do {
-			txd = &txr[tx_id];
-			txn = &sw_ring[txe->next_id];
-
-			if (txe->mbuf != NULL)
-				rte_pktmbuf_free_seg(txe->mbuf);
-			txe->mbuf = m_seg;
-
-			/* Setup TX Descriptor */
-			slen = m_seg->data_len;
-			buf_dma_addr = rte_mbuf_data_iova(m_seg);
-			txd->buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
-			txd->cmd_type_offset_bsz = rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
-				((uint64_t)td_cmd  << CI_TXD_QW1_CMD_S) |
-				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
-				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S));
-
-			txe->last_id = tx_last;
-			tx_id = txe->next_id;
-			txe = txn;
-			m_seg = m_seg->next;
-		} while (m_seg);
-
-		/* The last packet data descriptor needs End Of Packet (EOP) */
-		td_cmd |= CI_TX_DESC_CMD_EOP;
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
-		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
-
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
-			TX_LOG(DEBUG, "Setting RS bit on TXD id="
-			       "%4u (port=%d queue=%d)",
-			       tx_last, txq->port_id, txq->queue_id);
-
-			td_cmd |= CI_TX_DESC_CMD_RS;
-
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
-		}
-
-		txd->cmd_type_offset_bsz |= rte_cpu_to_le_16(td_cmd << CI_TXD_QW1_CMD_S);
-	}
-
-end_of_tx:
-	rte_wmb();
-
-	TX_LOG(DEBUG, "port_id=%u queue_id=%u tx_tail=%u nb_tx=%u",
-	       txq->port_id, txq->queue_id, tx_id, nb_tx);
-
-	IDPF_PCI_REG_WRITE(txq->qtx_tail, tx_id);
-	txq->tx_tail = tx_id;
-
-	return nb_tx;
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+			idpf_set_tso_ctx, NULL, NULL);
 }
 
 /* TX prep functions */
-- 
2.51.0

