Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EBE7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:46:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F089240A77;
	Mon,  9 Feb 2026 17:45:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D86DA4065D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:45:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655553; x=1802191553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ah1ehCrH4zuL8Rhdg19coD/8bFFWUKDjASG2mJeFdT4=;
 b=Dqn+SJyCziogplmn9IPfiq+TD9eu1s4JFB2cJep8wQ9A++vXbiqDxoYK
 DZmg56Jvest9G9S0zBlBdGc+qaQd5UNKtg669Ccjil9JL6o7x+1DUFBKd
 Aq6QPvkFo2nzh3QWn1ALvnsWP40FhXAR+j8g9AYGlZg4e4O2Mo0JEodQR
 tvVixnp8JaMU5wDDhPABpesxOCpw52JvLSSgye5NHVGQ7lCroNKkySa60
 FIkAYr9r+PCWTqIueX05r38fag4/uleJakRmbklP3vLpufDVYxMBwINX2
 DU8ZvS2kuue07+znLegvyv0YdWjnY5XXE5JCtHMDYLGoe68u96Epvr/Wa Q==;
X-CSE-ConnectionGUID: bBIY2oxyTkaUYT5Xv0U2Fg==
X-CSE-MsgGUID: sQHBgGfQQei4z/CzGFNDvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663410"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663410"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:45:52 -0800
X-CSE-ConnectionGUID: xWgOox4ITlO+gFOf68JJXg==
X-CSE-MsgGUID: 8YTEYMk7R7uli8pQ9Rx0cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789093"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:45:52 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
Date: Mon,  9 Feb 2026 16:45:05 +0000
Message-ID: <20260209164538.1428499-8-bruce.richardson@intel.com>
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

Move all context descriptor handling to a single function, as with the
ice driver, and use the same function signature as that driver.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 123 +++++++++++++++--------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index b75306931a..601d4b98f2 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -321,11 +321,6 @@ i40e_txd_enable_checksum(uint64_t ol_flags,
 			uint32_t *td_offset,
 			union ci_tx_offload tx_offload)
 {
-	/* Set MACLEN */
-	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
-		*td_offset |= (tx_offload.l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-
 	/* Enable L3 checksum offloads */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
 		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
@@ -1004,7 +999,7 @@ i40e_calc_context_desc(uint64_t flags)
 
 /* set i40e TSO context descriptor */
 static inline uint64_t
-i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
+i40e_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 {
 	uint64_t ctx_desc = 0;
 	uint32_t cd_cmd, hdr_len, cd_tso_len;
@@ -1015,7 +1010,7 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 	}
 
 	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
-	hdr_len += (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
+	hdr_len += (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
 		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
 
 	cd_cmd = I40E_TX_CTX_DESC_TSO;
@@ -1029,6 +1024,52 @@ i40e_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 	return ctx_desc;
 }
 
+/* compute a context descriptor if one is necessary based on the ol_flags
+ *
+ * Returns 0 if no descriptor is necessary.
+ * Returns 1 if one is necessary and the contents of the descriptor are returned
+ *   in the values pointed to by qw0 and qw1.
+ */
+static __rte_always_inline uint16_t
+get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
+		 const union ci_tx_offload *tx_offload,
+		 const struct ci_tx_queue *txq __rte_unused,
+		 uint64_t *qw0, uint64_t *qw1)
+{
+	uint16_t cd_l2tag2 = 0;
+	uint64_t cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT;
+	uint32_t cd_tunneling_params = 0;
+
+	if (i40e_calc_context_desc(ol_flags) == 0)
+		return 0;
+
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		i40e_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		cd_type_cmd_tso_mss |= i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
+	} else {
+#ifdef RTE_LIBRTE_IEEE1588
+		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
+			cd_type_cmd_tso_mss |=
+				((uint64_t)I40E_TX_CTX_DESC_TSYN << I40E_TXD_CTX_QW1_CMD_SHIFT);
+#endif
+	}
+
+	/* TX context descriptor based double VLAN insert */
+	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
+		cd_l2tag2 = tx_pkt->vlan_tci_outer;
+		cd_type_cmd_tso_mss |=
+				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
+	}
+
+	*qw0 = rte_cpu_to_le_32(cd_tunneling_params) |
+		((uint64_t)rte_cpu_to_le_16(cd_l2tag2) << 32);
+	*qw1 = rte_cpu_to_le_64(cd_type_cmd_tso_mss);
+
+	return 1;
+}
+
 uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -1039,7 +1080,6 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	volatile struct ci_tx_desc *txr;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
-	uint32_t cd_tunneling_params;
 	uint16_t tx_id;
 	uint16_t nb_tx;
 	uint32_t td_cmd;
@@ -1050,6 +1090,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t nb_ctx;
 	uint16_t tx_last;
 	uint16_t slen;
+	uint16_t l2_len;
 	uint64_t buf_dma_addr;
 	union ci_tx_offload tx_offload = {0};
 
@@ -1064,14 +1105,15 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
-		td_cmd = 0;
-		td_tag = 0;
-		td_offset = 0;
-
 		tx_pkt = *tx_pkts++;
 		RTE_MBUF_PREFETCH_TO_FREE(txe->mbuf);
 
 		ol_flags = tx_pkt->ol_flags;
+		td_cmd = 0;
+		td_tag = 0;
+		l2_len = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
+				tx_pkt->outer_l2_len : tx_pkt->l2_len;
+		td_offset = (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
 		tx_offload.l2_len = tx_pkt->l2_len;
 		tx_offload.l3_len = tx_pkt->l3_len;
 		tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
@@ -1080,7 +1122,9 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 
 		/* Calculate the number of context descriptors needed. */
-		nb_ctx = i40e_calc_context_desc(ol_flags);
+		uint64_t cd_qw0 = 0, cd_qw1 = 0;
+		nb_ctx = get_context_desc(ol_flags, tx_pkt, &tx_offload, txq,
+				&cd_qw0, &cd_qw1);
 
 		/**
 		 * The number of descriptors that must be allocated for
@@ -1126,14 +1170,6 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		/* Always enable CRC offload insertion */
 		td_cmd |= CI_TX_DESC_CMD_ICRC;
 
-		/* Fill in tunneling parameters if necessary */
-		cd_tunneling_params = 0;
-		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-			td_offset |= (tx_offload.outer_l2_len >> 1)
-					<< CI_TX_DESC_LEN_MACLEN_S;
-			i40e_parse_tunneling_params(ol_flags, tx_offload,
-						    &cd_tunneling_params);
-		}
 		/* Enable checksum offloading */
 		if (ol_flags & I40E_TX_CKSUM_OFFLOAD_MASK)
 			i40e_txd_enable_checksum(ol_flags, &td_cmd,
@@ -1141,12 +1177,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		if (nb_ctx) {
 			/* Setup TX context descriptor if required */
-			volatile struct i40e_tx_context_desc *ctx_txd =
-				(volatile struct i40e_tx_context_desc *)\
-							&txr[tx_id];
-			uint16_t cd_l2tag2 = 0;
-			uint64_t cd_type_cmd_tso_mss =
-				I40E_TX_DESC_DTYPE_CONTEXT;
+			uint64_t *desc = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
 
 			txn = &sw_ring[txe->next_id];
 			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
@@ -1155,41 +1186,13 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				txe->mbuf = NULL;
 			}
 
-			/* TSO enabled means no timestamp */
-			if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-				cd_type_cmd_tso_mss |=
-					i40e_set_tso_ctx(tx_pkt, tx_offload);
-			else {
-#ifdef RTE_LIBRTE_IEEE1588
-				if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
-					cd_type_cmd_tso_mss |=
-						((uint64_t)I40E_TX_CTX_DESC_TSYN <<
-						 I40E_TXD_CTX_QW1_CMD_SHIFT);
-#endif
-			}
-
-			ctx_txd->tunneling_params =
-				rte_cpu_to_le_32(cd_tunneling_params);
-			if (ol_flags & RTE_MBUF_F_TX_QINQ) {
-				cd_l2tag2 = tx_pkt->vlan_tci_outer;
-				cd_type_cmd_tso_mss |=
-					((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 <<
-						I40E_TXD_CTX_QW1_CMD_SHIFT);
-			}
-			ctx_txd->l2tag2 = rte_cpu_to_le_16(cd_l2tag2);
-			ctx_txd->type_cmd_tso_mss =
-				rte_cpu_to_le_64(cd_type_cmd_tso_mss);
+			desc[0] = cd_qw0;
+			desc[1] = cd_qw1;
 
 			PMD_TX_LOG(DEBUG, "mbuf: %p, TCD[%u]: "
-				"tunneling_params: %#x; "
-				"l2tag2: %#hx; "
-				"rsvd: %#hx; "
-				"type_cmd_tso_mss: %#"PRIx64";",
-				tx_pkt, tx_id,
-				ctx_txd->tunneling_params,
-				ctx_txd->l2tag2,
-				ctx_txd->rsvd,
-				ctx_txd->type_cmd_tso_mss);
+				"qw0: %#"PRIx64"; "
+				"qw1: %#"PRIx64";",
+				tx_pkt, tx_id, cd_qw0, cd_qw1);
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
-- 
2.51.0

