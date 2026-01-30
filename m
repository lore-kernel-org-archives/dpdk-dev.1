Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48493E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B75F40A71;
	Fri, 30 Jan 2026 12:42:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 98B87402BD
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773357; x=1801309357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V3269X+xcs222IzYv+QyWMsLSk0+WWTh0DKf2wZxJ1k=;
 b=HnzMgRCvHvKqk9VQ2tfHsB0uqloWiNOWwkGAKuxG8QSJCKwDF7o7KuEF
 N9xvMG1xu3MY5S5S17KB3oqingWAC/fnA+5YnhV5FqkzkYrV6MA6/tfdH
 eTkRdl+u5ZPy9DNNZuMEGgel3QVn+VIksSv7GQYvn4GH4hs0oiREHbueD
 lTpwJa4osWI//C+4QrxWXJx1hxfaz2OimqthlsKmkNSbNtTiUMtJq2tsC
 buHQr1VgHr4PAlCG0RgfUxFqdCun+bt8rJexYcdZThErwBMnxsFmgKIh2
 /NBenH/afweRzsS7upYXvWPHYFgLnjvoaOGIpd76K834XUJTlAVOrm9D6 g==;
X-CSE-ConnectionGUID: 2n2CVL6vR0eOuLArRH9Cng==
X-CSE-MsgGUID: apv5UBR0ScixlfiXSFXECQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392308"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:37 -0800
X-CSE-ConnectionGUID: Y8ZoU68BQtuE+X1e1j7fgg==
X-CSE-MsgGUID: +XpIBT6SQqWc9/Ef7umeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190497"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 14/36] net/intel: add IPsec hooks to common Tx function
Date: Fri, 30 Jan 2026 11:41:41 +0000
Message-ID: <20260130114207.1126032-15-bruce.richardson@intel.com>
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

The iavf driver has IPsec offload support on Tx, so add hooks to the
common Tx function to support that. Do so in a way that has zero
performance impact for drivers which do not have IPSec support, by
passing in compile-time NULL constants for the function pointers, which
can be optimized away by the compiler.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 60 ++++++++++++++++++++++--
 drivers/net/intel/i40e/i40e_rxtx.c       |  4 +-
 drivers/net/intel/ice/ice_rxtx.c         |  4 +-
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 6d01c14283..2fe503a548 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -147,6 +147,24 @@ typedef uint16_t (*ci_get_ctx_desc_fn)(uint64_t ol_flags, const struct rte_mbuf
 		const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
 		uint64_t *qw0, uint64_t *qw1);
 
+/* gets IPsec descriptor information and returns number of descriptors needed (0 or 1) */
+typedef uint16_t (*get_ipsec_desc_t)(const struct rte_mbuf *mbuf,
+		const struct ci_tx_queue *txq,
+		void **ipsec_metadata,
+		uint64_t *qw0,
+		uint64_t *qw1);
+/* calculates segment length for IPsec + TSO combinations */
+typedef uint16_t (*calc_ipsec_segment_len_t)(const struct rte_mbuf *mb_seg,
+		uint64_t ol_flags,
+		const void *ipsec_metadata,
+		uint16_t tlen);
+
+/** IPsec descriptor operations for drivers that support inline IPsec crypto. */
+struct ci_ipsec_ops {
+	get_ipsec_desc_t get_ipsec_desc;
+	calc_ipsec_segment_len_t calc_segment_len;
+};
+
 /* gets current timestamp tail index */
 typedef uint16_t (*get_ts_tail_t)(struct ci_tx_queue *txq);
 /* writes a timestamp descriptor and returns new tail index */
@@ -166,6 +184,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
 	     ci_get_ctx_desc_fn get_ctx_desc,
+	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timesstamp_queue_fns *ts_fns)
 {
 	volatile struct ci_tx_desc *ci_tx_ring;
@@ -202,6 +221,9 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		void *ipsec_md = NULL;
+		uint16_t nb_ipsec = 0;
+		uint64_t ipsec_qw0 = 0, ipsec_qw1 = 0;
 		uint64_t cd_qw0, cd_qw1;
 		tx_pkt = *tx_pkts++;
 
@@ -223,17 +245,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		/* Calculate the number of context descriptors needed. */
 		nb_ctx = get_ctx_desc(ol_flags, tx_pkt, &tx_offload, txq, &cd_qw0, &cd_qw1);
 
+		/* Get IPsec descriptor information if IPsec ops provided */
+		if (ipsec_ops != NULL)
+			nb_ipsec = ipsec_ops->get_ipsec_desc(tx_pkt, txq, &ipsec_md,
+					&ipsec_qw0, &ipsec_qw1);
+
 		/* The number of descriptors that must be allocated for
 		 * a packet equals to the number of the segments of that
-		 * packet plus the number of context descriptor if needed.
+		 * packet plus the number of context and IPsec descriptors if needed.
 		 * Recalculate the needed tx descs when TSO enabled in case
 		 * the mbuf data size exceeds max data size that hw allows
 		 * per tx desc.
 		 */
 		if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx);
+			nb_used = (uint16_t)(ci_calc_pkt_desc(tx_pkt) + nb_ctx + nb_ipsec);
 		else
-			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx);
+			nb_used = (uint16_t)(tx_pkt->nb_segs + nb_ctx + nb_ipsec);
 		tx_last = (uint16_t)(tx_id + nb_used - 1);
 
 		/* Circular ring */
@@ -286,6 +313,26 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			tx_id = txe->next_id;
 			txe = txn;
 		}
+
+		if (ipsec_ops != NULL && nb_ipsec > 0) {
+			/* Setup TX IPsec descriptor if required */
+			uint64_t *ipsec_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
+
+			txn = &sw_ring[txe->next_id];
+			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
+			if (txe->mbuf) {
+				rte_pktmbuf_free_seg(txe->mbuf);
+				txe->mbuf = NULL;
+			}
+
+			ipsec_txd[0] = ipsec_qw0;
+			ipsec_txd[1] = ipsec_qw1;
+
+			txe->last_id = tx_last;
+			tx_id = txe->next_id;
+			txe = txn;
+		}
+
 		m_seg = tx_pkt;
 
 		do {
@@ -297,7 +344,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txe->mbuf = m_seg;
 
 			/* Setup TX Descriptor */
-			slen = m_seg->data_len;
+			/* Calculate segment length, using IPsec callback if provided */
+			if (ipsec_ops != NULL)
+				slen = ipsec_ops->calc_segment_len(m_seg, ol_flags, ipsec_md, 0);
+			else
+				slen = m_seg->data_len;
+
 			buf_dma_addr = rte_mbuf_data_iova(m_seg);
 
 			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 81fdeb72cb..e7dd637931 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1018,8 +1018,8 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
-	/* i40e does not support timestamp queues, so pass NULL for ts_fns */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL);
+	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index d805bee4f0..eea83bbae1 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3105,9 +3105,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, &ts_fns);
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, &ts_fns);
 
-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL);
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

