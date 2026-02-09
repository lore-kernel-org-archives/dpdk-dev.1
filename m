Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA2E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8B4640A72;
	Mon,  9 Feb 2026 17:45:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 07B8F4065D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655552; x=1802191552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mU4/BxBFt7Hz3iC+3XGYPwkQh0H2JQpNV3qTjPXPwB0=;
 b=CoUUrqzGkB2IRFTD2txomc6M4qzvjoRi2O5CGGytYKAikzA5uKtueA5T
 w9FD936Y24VHFQNSlCbdG6TGbHU9BGtptSzGuXuTWfzu8yQP6hXAGVEqH
 hKfC/WJfgSIRo9tO794jqthZXJgWS4LGmOhZex94D6uwHh44gslozZo7A
 Axv73yv03YEhaR8Zena2IGFivZG4urS/aM1LZcw8vyUMn6e0TAu4RIdIt
 ST9uxxqaoP4neXb0Z8W6MNhbvn4vFM2qU/+RYImapEpAVl1vU66ADZ3L+
 kOKhXPK8HQa7t9XAVxKleoZP6GlfbLRv4XM5Xo3YFTBF+QrrdQol0shxv A==;
X-CSE-ConnectionGUID: lQAA2s5fQXqDltzkwPMvMg==
X-CSE-MsgGUID: F4DotknrTCeaRxUKv5C72Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663406"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663406"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:45:52 -0800
X-CSE-ConnectionGUID: 8M9tTqA8RwCz52yUU1A3IA==
X-CSE-MsgGUID: xLyI37+LRZaetbhU1DzzeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789086"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:45:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 06/35] net/ice: refactor context descriptor handling
Date: Mon,  9 Feb 2026 16:45:04 +0000
Message-ID: <20260209164538.1428499-7-bruce.richardson@intel.com>
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

Create a single function to manage all context descriptor handling,
which returns either 0 or 1 depending on whether a descriptor is needed
or not, as well as returning directly the descriptor contents if
relevant.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 104 +++++++++++++++++--------------
 1 file changed, 57 insertions(+), 47 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 2a53b614b2..1c789d45da 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2966,10 +2966,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
 			uint32_t *td_offset,
 			union ci_tx_offload tx_offload)
 {
-	/* Set MACLEN */
-	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
-		*td_offset |= (tx_offload.l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offloads */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
@@ -3052,7 +3048,7 @@ ice_calc_context_desc(uint64_t flags)
 
 /* set ice TSO context descriptor */
 static inline uint64_t
-ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
+ice_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 {
 	uint64_t ctx_desc = 0;
 	uint32_t cd_cmd, hdr_len, cd_tso_len;
@@ -3063,7 +3059,7 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
 	}
 
 	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
-	hdr_len += (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
+	hdr_len += (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
 		   tx_offload.outer_l2_len + tx_offload.outer_l3_len : 0;
 
 	cd_cmd = CI_TX_CTX_DESC_TSO;
@@ -3075,6 +3071,49 @@ ice_set_tso_ctx(struct rte_mbuf *mbuf, union ci_tx_offload tx_offload)
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
+	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
+	uint64_t *qw0, uint64_t *qw1)
+{
+	uint16_t cd_l2tag2 = 0;
+	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
+	uint32_t cd_tunneling_params = 0;
+	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
+
+	if (ice_calc_context_desc(ol_flags) == 0)
+		return 0;
+
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		ice_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
+
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+		cd_type_cmd_tso_mss |= ice_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
+	else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
+		cd_type_cmd_tso_mss |=
+			((uint64_t)CI_TX_CTX_DESC_TSYN << CI_TXD_QW1_CMD_S) |
+			((ptp_tx_index << ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
+
+
+	/* TX context descriptor based double VLAN insert */
+	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
+		cd_l2tag2 = tx_pkt->vlan_tci_outer;
+		cd_type_cmd_tso_mss |= ((uint64_t)CI_TX_CTX_DESC_IL2TAG2 << CI_TXD_QW1_CMD_S);
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
 ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -3085,7 +3124,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_entry *txe, *txn;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
-	uint32_t cd_tunneling_params;
 	uint16_t tx_id;
 	uint16_t ts_id = -1;
 	uint16_t nb_tx;
@@ -3096,6 +3134,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint32_t td_tag = 0;
 	uint16_t tx_last;
 	uint16_t slen;
+	uint16_t l2_len;
 	uint64_t buf_dma_addr;
 	uint64_t ol_flags;
 	union ci_tx_offload tx_offload = {0};
@@ -3114,20 +3153,25 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		uint64_t cd_qw0, cd_qw1;
 		tx_pkt = *tx_pkts++;
 
+		ol_flags = tx_pkt->ol_flags;
 		td_cmd = 0;
 		td_tag = 0;
-		td_offset = 0;
-		ol_flags = tx_pkt->ol_flags;
+		l2_len = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
+				tx_pkt->outer_l2_len : tx_pkt->l2_len;
+		td_offset = (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
+
 		tx_offload.l2_len = tx_pkt->l2_len;
 		tx_offload.l3_len = tx_pkt->l3_len;
 		tx_offload.outer_l2_len = tx_pkt->outer_l2_len;
 		tx_offload.outer_l3_len = tx_pkt->outer_l3_len;
 		tx_offload.l4_len = tx_pkt->l4_len;
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
+
 		/* Calculate the number of context descriptors needed. */
-		nb_ctx = ice_calc_context_desc(ol_flags);
+		nb_ctx = get_context_desc(ol_flags, tx_pkt, &tx_offload, txq, &cd_qw0, &cd_qw1);
 
 		/* The number of descriptors that must be allocated for
 		 * a packet equals to the number of the segments of that
@@ -3169,15 +3213,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			td_tag = tx_pkt->vlan_tci;
 		}
 
-		/* Fill in tunneling parameters if necessary */
-		cd_tunneling_params = 0;
-		if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-			td_offset |= (tx_offload.outer_l2_len >> 1)
-				<< CI_TX_DESC_LEN_MACLEN_S;
-			ice_parse_tunneling_params(ol_flags, tx_offload,
-						   &cd_tunneling_params);
-		}
-
 		/* Enable checksum offloading */
 		if (ol_flags & ICE_TX_CKSUM_OFFLOAD_MASK)
 			ice_txd_enable_checksum(ol_flags, &td_cmd,
@@ -3185,11 +3220,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		if (nb_ctx) {
 			/* Setup TX context descriptor if required */
-			volatile struct ice_tx_ctx_desc *ctx_txd =
-				(volatile struct ice_tx_ctx_desc *)
-					&ci_tx_ring[tx_id];
-			uint16_t cd_l2tag2 = 0;
-			uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
+			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
 
 			txn = &sw_ring[txe->next_id];
 			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
@@ -3198,29 +3229,8 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				txe->mbuf = NULL;
 			}
 
-			if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-				cd_type_cmd_tso_mss |=
-					ice_set_tso_ctx(tx_pkt, tx_offload);
-			else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
-				cd_type_cmd_tso_mss |=
-					((uint64_t)CI_TX_CTX_DESC_TSYN <<
-					CI_TXD_QW1_CMD_S) |
-					 (((uint64_t)txq->ice_vsi->adapter->ptp_tx_index <<
-					 ICE_TXD_CTX_QW1_TSYN_S) & ICE_TXD_CTX_QW1_TSYN_M);
-
-			ctx_txd->tunneling_params =
-				rte_cpu_to_le_32(cd_tunneling_params);
-
-			/* TX context descriptor based double VLAN insert */
-			if (ol_flags & RTE_MBUF_F_TX_QINQ) {
-				cd_l2tag2 = tx_pkt->vlan_tci_outer;
-				cd_type_cmd_tso_mss |=
-					((uint64_t)CI_TX_CTX_DESC_IL2TAG2 <<
-					 CI_TXD_QW1_CMD_S);
-			}
-			ctx_txd->l2tag2 = rte_cpu_to_le_16(cd_l2tag2);
-			ctx_txd->qw1 =
-				rte_cpu_to_le_64(cd_type_cmd_tso_mss);
+			ctx_txd[0] = cd_qw0;
+			ctx_txd[1] = cd_qw1;
 
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
-- 
2.51.0

