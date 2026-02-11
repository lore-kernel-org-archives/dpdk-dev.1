Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F0ECD6D6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A448140662;
	Wed, 11 Feb 2026 19:13:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id BF81B40DCD
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833627; x=1802369627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8DU0Q9oh/KR9o6wk2hejPnbVzQF0Tc/EoKVSk9gi5r0=;
 b=TohcPJBIEXXAZnzzBrjz7jKJ8ZmYe/EkrmT2bxzEv69Ab/CTYZzwE3Jb
 aG0fy7wO/F94JsG6NVgRYliRyqafZTEIrp5UesUbJBHmDzk6hSOskzmwb
 ub8Pn6QGTcMmjwX7mPwPUtr4MOVvZQjeeh3lY+p7Lj0vCS+bmNdATFOHb
 DwfLKoFJ2pQCmowQH3qcYULCJXnGDD/fyhin79q8FCp4oazYAB1NrtaV3
 QQ0yLilPnthAgJ2AKtXEQgqotQTJ51q1Wq2CiBgN2r6FtaExNhWgJdrx1
 lhAYZ2tTIVA8z3Mn7STIIma74hgR+VX5/GqklkfKg3LbITcMhP5KgTTkh Q==;
X-CSE-ConnectionGUID: D60fbEDbSLKYLj48Fr/0JQ==
X-CSE-MsgGUID: iTAnfmuvR06EGlXx4gNSoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834681"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834681"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:46 -0800
X-CSE-ConnectionGUID: 99B26KJ6R3KTS2XOaHTqyQ==
X-CSE-MsgGUID: w9644lgZQaqENREO5gYTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986341"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:46 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 14/35] net/intel: add IPsec hooks to common Tx function
Date: Wed, 11 Feb 2026 18:12:43 +0000
Message-ID: <20260211181309.2838042-15-bruce.richardson@intel.com>
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

The iavf driver has IPsec offload support on Tx, so add hooks to the
common Tx function to support that. Do so in a way that has zero
performance impact for drivers which do not have IPSec support, by
passing in compile-time NULL constants for the function pointers, which
can be optimized away by the compiler.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 60 ++++++++++++++++++++++++++--
 drivers/net/intel/i40e/i40e_rxtx.c   |  4 +-
 drivers/net/intel/ice/ice_rxtx.c     |  4 +-
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 3616600a2d..cd0abe4179 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -134,6 +134,24 @@ typedef uint16_t (*ci_get_ctx_desc_fn)(uint64_t ol_flags, const struct rte_mbuf
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
@@ -153,6 +171,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
 	     ci_get_ctx_desc_fn get_ctx_desc,
+	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timestamp_queue_fns *ts_fns)
 {
 	volatile struct ci_tx_desc *ci_tx_ring;
@@ -189,6 +208,9 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		void *ipsec_md = NULL;
+		uint16_t nb_ipsec = 0;
+		uint64_t ipsec_qw0 = 0, ipsec_qw1 = 0;
 		uint64_t cd_qw0 = 0, cd_qw1 = 0;
 		tx_pkt = *tx_pkts++;
 
@@ -210,17 +232,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
@@ -273,6 +300,26 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
@@ -284,7 +331,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
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
index 41310b4c6c..4e362e737e 100644
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
index 561a6617a6..9643dd3817 100644
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

