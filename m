Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56496E7E0BC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6361540BA2;
	Mon,  9 Feb 2026 17:46:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5E174402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655561; x=1802191561;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dwP1xXSKnzS2dNvt0px0Vq6DZR7gcBHOf7/uPCVolRQ=;
 b=Kx4FN4L7PZSPV0PgtFRkLQQRT1ErhhUQKH/iMp0v054z5rucaJNjZZOZ
 GX0AdsCe8znpONCfIVfE9Ger1PZSXXTFs7lxElZjFqI2TNnxyg3GgYmlt
 QJGcKUG7YygV/GDCQnpQ1h/O8igV2PPMHrMWMwX8b5IZsmsPxNohmyqWL
 bYn0LSwPDxS1a7R/cJgF4zJ4W8esrUT2BkqeS9l3B5wqW7WiybsGSESFI
 mvLdiTk66aEthNXdCZePvCgORFWmSjc7bEqyPiEUBbQJ6M1tPO0Ozh5Qa
 yzkNI+Z4hYYtyVt9b57Tt+64c746g0/rc5ed7/yl8PL0ygdjtSy6Lh4xX g==;
X-CSE-ConnectionGUID: jLuyQcDVQkORObWSf7tDmQ==
X-CSE-MsgGUID: t7JjCEI0Tv2ZcPcTpSEEIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663453"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663453"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:01 -0800
X-CSE-ConnectionGUID: B9rV2VvUT+ulwEuhD9+6iQ==
X-CSE-MsgGUID: yoxalPsjTdSHbfBxxI3ECg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789139"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 15/35] net/iavf: use common scalar Tx function
Date: Mon,  9 Feb 2026 16:45:13 +0000
Message-ID: <20260209164538.1428499-16-bruce.richardson@intel.com>
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

Now that the common scalar Tx function has all necessary hooks for the
features supported by the iavf driver, use the common function to avoid
duplicated code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h |   3 +-
 drivers/net/intel/iavf/iavf_rxtx.c   | 534 ++++++---------------------
 drivers/net/intel/iavf/iavf_rxtx.h   |   1 +
 3 files changed, 112 insertions(+), 426 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 3248f9423d..8b503dd4de 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -226,7 +226,8 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		ol_flags = tx_pkt->ol_flags;
 		td_cmd = CI_TX_DESC_CMD_ICRC;
 		td_tag = 0;
-		l2_len = ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
+		l2_len = (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK &&
+					!(ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)) ?
 				tx_pkt->outer_l2_len : tx_pkt->l2_len;
 		td_offset = (l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 3dbcfd5355..2ea00e1975 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2326,7 +2326,7 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
 
 /* Check if the context descriptor is needed for TX offloading */
 static inline uint16_t
-iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
+iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag)
 {
 	uint64_t flags = mb->ol_flags;
 	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
@@ -2344,44 +2344,7 @@ iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
 }
 
 static inline void
-iavf_fill_ctx_desc_cmd_field(volatile uint64_t *field, struct rte_mbuf *m,
-		uint8_t vlan_flag)
-{
-	uint64_t cmd = 0;
-
-	/* TSO enabled */
-	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-		cmd = CI_TX_CTX_DESC_TSO << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-
-	if ((m->ol_flags & RTE_MBUF_F_TX_VLAN &&
-			vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) ||
-			m->ol_flags & RTE_MBUF_F_TX_QINQ) {
-		cmd |= CI_TX_CTX_DESC_IL2TAG2
-			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-	}
-
-	if (IAVF_CHECK_TX_LLDP(m))
-		cmd |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-
-	*field |= cmd;
-}
-
-static inline void
-iavf_fill_ctx_desc_ipsec_field(volatile uint64_t *field,
-	struct iavf_ipsec_crypto_pkt_metadata *ipsec_md)
-{
-	uint64_t ipsec_field =
-		(uint64_t)ipsec_md->ctx_desc_ipsec_params <<
-			IAVF_TXD_CTX_QW1_IPSEC_PARAMS_CIPHERBLK_SHIFT;
-
-	*field |= ipsec_field;
-}
-
-
-static inline void
-iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
-		const struct rte_mbuf *m)
+iavf_fill_ctx_desc_tunnelling_field(uint64_t *qw0, const struct rte_mbuf *m)
 {
 	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
 	uint64_t eip_len = 0;
@@ -2456,7 +2419,7 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
 
 static inline uint16_t
 iavf_fill_ctx_desc_segmentation_field(volatile uint64_t *field,
-	struct rte_mbuf *m, struct iavf_ipsec_crypto_pkt_metadata *ipsec_md)
+	const struct rte_mbuf *m, struct iavf_ipsec_crypto_pkt_metadata *ipsec_md)
 {
 	uint64_t segmentation_field = 0;
 	uint64_t total_length = 0;
@@ -2495,59 +2458,31 @@ struct iavf_tx_context_desc_qws {
 	__le64 qw1;
 };
 
-static inline void
-iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
-	struct rte_mbuf *m, struct iavf_ipsec_crypto_pkt_metadata *ipsec_md,
-	uint16_t *tlen, uint8_t vlan_flag)
+/* IPsec callback for ci_xmit_pkts - gets IPsec descriptor information */
+static uint16_t
+iavf_get_ipsec_desc(const struct rte_mbuf *mbuf, const struct ci_tx_queue *txq,
+		    void **ipsec_metadata, uint64_t *qw0, uint64_t *qw1)
 {
-	volatile struct iavf_tx_context_desc_qws *desc_qws =
-			(volatile struct iavf_tx_context_desc_qws *)desc;
-	/* fill descriptor type field */
-	desc_qws->qw1 = IAVF_TX_DESC_DTYPE_CONTEXT;
-
-	/* fill command field */
-	iavf_fill_ctx_desc_cmd_field(&desc_qws->qw1, m, vlan_flag);
-
-	/* fill segmentation field */
-	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
-		/* fill IPsec field */
-		if (m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)
-			iavf_fill_ctx_desc_ipsec_field(&desc_qws->qw1,
-				ipsec_md);
-
-		*tlen = iavf_fill_ctx_desc_segmentation_field(&desc_qws->qw1,
-				m, ipsec_md);
-	}
-
-	/* fill tunnelling field */
-	if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
-		iavf_fill_ctx_desc_tunnelling_field(&desc_qws->qw0, m);
-	else
-		desc_qws->qw0 = 0;
+	struct iavf_ipsec_crypto_pkt_metadata *md;
 
-	desc_qws->qw0 = rte_cpu_to_le_64(desc_qws->qw0);
-	desc_qws->qw1 = rte_cpu_to_le_64(desc_qws->qw1);
+	if (!(mbuf->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD))
+		return 0;
 
-	/* vlan_flag specifies VLAN tag location for VLAN, and outer tag location for QinQ. */
-	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
-		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci_outer :
-						m->vlan_tci;
-	else if (m->ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
-		desc->l2tag2 = m->vlan_tci;
-}
+	md = RTE_MBUF_DYNFIELD(mbuf, txq->ipsec_crypto_pkt_md_offset,
+				     struct iavf_ipsec_crypto_pkt_metadata *);
+	if (!md)
+		return 0;
 
+	*ipsec_metadata = md;
 
-static inline void
-iavf_fill_ipsec_desc(volatile struct iavf_tx_ipsec_desc *desc,
-	const struct iavf_ipsec_crypto_pkt_metadata *md, uint16_t *ipsec_len)
-{
-	desc->qw0 = rte_cpu_to_le_64(((uint64_t)md->l4_payload_len <<
+	/* Fill IPsec descriptor using existing logic */
+	*qw0 = rte_cpu_to_le_64(((uint64_t)md->l4_payload_len <<
 		IAVF_IPSEC_TX_DESC_QW0_L4PAYLEN_SHIFT) |
 		((uint64_t)md->esn << IAVF_IPSEC_TX_DESC_QW0_IPSECESN_SHIFT) |
 		((uint64_t)md->esp_trailer_len <<
 				IAVF_IPSEC_TX_DESC_QW0_TRAILERLEN_SHIFT));
 
-	desc->qw1 = rte_cpu_to_le_64(((uint64_t)md->sa_idx <<
+	*qw1 = rte_cpu_to_le_64(((uint64_t)md->sa_idx <<
 		IAVF_IPSEC_TX_DESC_QW1_IPSECSA_SHIFT) |
 		((uint64_t)md->next_proto <<
 				IAVF_IPSEC_TX_DESC_QW1_IPSECNH_SHIFT) |
@@ -2556,143 +2491,106 @@ iavf_fill_ipsec_desc(volatile struct iavf_tx_ipsec_desc *desc,
 		((uint64_t)(md->ol_flags & IAVF_IPSEC_CRYPTO_OL_FLAGS_NATT ?
 				1ULL : 0ULL) <<
 				IAVF_IPSEC_TX_DESC_QW1_UDP_SHIFT) |
-		(uint64_t)IAVF_TX_DESC_DTYPE_IPSEC);
+		((uint64_t)IAVF_TX_DESC_DTYPE_IPSEC <<
+				CI_TXD_QW1_DTYPE_S));
 
-	/**
-	 * TODO: Pre-calculate this in the Session initialization
-	 *
-	 * Calculate IPsec length required in data descriptor func when TSO
-	 * offload is enabled
-	 */
-	*ipsec_len = sizeof(struct rte_esp_hdr) + (md->len_iv >> 2) +
-			(md->ol_flags & IAVF_IPSEC_CRYPTO_OL_FLAGS_NATT ?
-			sizeof(struct rte_udp_hdr) : 0);
+	return 1; /* One IPsec descriptor needed */
 }
 
-static inline void
-iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
-		struct rte_mbuf *m, uint8_t vlan_flag)
+/* IPsec callback for ci_xmit_pkts - calculates segment length for IPsec+TSO */
+static uint16_t
+iavf_calc_ipsec_segment_len(const struct rte_mbuf *mb_seg, uint64_t ol_flags,
+			    const void *ipsec_metadata, uint16_t tlen)
 {
-	uint64_t command = 0;
-	uint64_t offset = 0;
-	uint64_t l2tag1 = 0;
-
-	*qw1 = CI_TX_DESC_DTYPE_DATA;
-
-	command = (uint64_t)CI_TX_DESC_CMD_ICRC;
-
-	/* Descriptor based VLAN insertion */
-	if ((vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) &&
-			m->ol_flags & RTE_MBUF_F_TX_VLAN) {
-		command |= (uint64_t)CI_TX_DESC_CMD_IL2TAG1;
-		l2tag1 |= m->vlan_tci;
-	}
-
-	/* Descriptor based QinQ insertion. vlan_flag specifies outer tag location. */
-	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
-		command |= (uint64_t)CI_TX_DESC_CMD_IL2TAG1;
-		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci_outer :
-									m->vlan_tci;
+	const struct iavf_ipsec_crypto_pkt_metadata *ipsec_md = ipsec_metadata;
+
+	if ((ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) &&
+	    (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))) {
+		uint16_t ipseclen = ipsec_md ? (ipsec_md->esp_trailer_len +
+						ipsec_md->len_iv) : 0;
+		uint16_t slen = tlen + mb_seg->l2_len + mb_seg->l3_len +
+				mb_seg->outer_l3_len + ipseclen;
+		if (ol_flags & RTE_MBUF_F_TX_L4_MASK)
+			slen += mb_seg->l4_len;
+		return slen;
 	}
 
-	if ((m->ol_flags &
-	    (CI_TX_CKSUM_OFFLOAD_MASK | RTE_MBUF_F_TX_SEC_OFFLOAD)) == 0)
-		goto skip_cksum;
+	return mb_seg->data_len;
+}
 
-	/* Set MACLEN */
-	if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK &&
-			!(m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD))
-		offset |= (m->outer_l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-	else
-		offset |= (m->l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
+/* Context descriptor callback for ci_xmit_pkts */
+static uint16_t
+iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
+		      const union ci_tx_offload *tx_offload __rte_unused,
+		      const struct ci_tx_queue *txq,
+		      uint64_t *qw0, uint64_t *qw1)
+{
+	uint8_t iavf_vlan_flag;
+	uint16_t cd_l2tag2 = 0;
+	uint64_t cd_type_cmd = IAVF_TX_DESC_DTYPE_CONTEXT;
+	uint64_t cd_tunneling_params = 0;
+	uint16_t tlen = 0;
+	struct iavf_ipsec_crypto_pkt_metadata *ipsec_md = NULL;
+
+	/* Use IAVF-specific vlan_flag from txq */
+	iavf_vlan_flag = txq->vlan_flag;
+
+	/* Check if context descriptor is needed using existing IAVF logic */
+	if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag))
+		return 0;
 
-	/* Enable L3 checksum offloading inner */
-	if (m->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		if (m->ol_flags & RTE_MBUF_F_TX_IPV4) {
-			command |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
-			offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
-		}
-	} else if (m->ol_flags & RTE_MBUF_F_TX_IPV4) {
-		command |= CI_TX_DESC_CMD_IIPT_IPV4;
-		offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
-	} else if (m->ol_flags & RTE_MBUF_F_TX_IPV6) {
-		command |= CI_TX_DESC_CMD_IIPT_IPV6;
-		offset |= (m->l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	/* Get IPsec metadata if needed */
+	if (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) {
+		ipsec_md = RTE_MBUF_DYNFIELD(mbuf, txq->ipsec_crypto_pkt_md_offset,
+					     struct iavf_ipsec_crypto_pkt_metadata *);
 	}
 
-	if (m->ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
-		if (m->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			command |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		else
-			command |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		offset |= (m->l4_len >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
+	/* TSO command field */
+	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
+		cd_type_cmd |= (uint64_t)CI_TX_CTX_DESC_TSO << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
-		*qw1 = rte_cpu_to_le_64((((uint64_t)command <<
-			IAVF_TXD_DATA_QW1_CMD_SHIFT) & IAVF_TXD_DATA_QW1_CMD_MASK) |
-			(((uint64_t)offset << IAVF_TXD_DATA_QW1_OFFSET_SHIFT) &
-			IAVF_TXD_DATA_QW1_OFFSET_MASK) |
-			((uint64_t)l2tag1 << IAVF_TXD_DATA_QW1_L2TAG1_SHIFT));
+		/* IPsec field for TSO */
+		if (ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD && ipsec_md) {
+			uint64_t ipsec_field = (uint64_t)ipsec_md->ctx_desc_ipsec_params <<
+				IAVF_TXD_CTX_QW1_IPSEC_PARAMS_CIPHERBLK_SHIFT;
+			cd_type_cmd |= ipsec_field;
+		}
 
-		return;
+		/* TSO segmentation field */
+		tlen = iavf_fill_ctx_desc_segmentation_field(&cd_type_cmd,
+							     mbuf, ipsec_md);
+		(void)tlen; /* Suppress unused variable warning */
 	}
 
-	/* Enable L4 checksum offloads */
-	switch (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) {
-	case RTE_MBUF_F_TX_TCP_CKSUM:
-		command |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		command |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
-		offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_UDP_CKSUM:
-		command |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
+	/* VLAN field for L2TAG2 */
+	if ((ol_flags & RTE_MBUF_F_TX_VLAN &&
+	     iavf_vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) ||
+	    ol_flags & RTE_MBUF_F_TX_QINQ) {
+		cd_type_cmd |= (uint64_t)CI_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	}
 
-skip_cksum:
-	*qw1 = rte_cpu_to_le_64((((uint64_t)command <<
-		IAVF_TXD_DATA_QW1_CMD_SHIFT) & IAVF_TXD_DATA_QW1_CMD_MASK) |
-		(((uint64_t)offset << IAVF_TXD_DATA_QW1_OFFSET_SHIFT) &
-		IAVF_TXD_DATA_QW1_OFFSET_MASK) |
-		((uint64_t)l2tag1 << IAVF_TXD_DATA_QW1_L2TAG1_SHIFT));
-}
-
-static inline void
-iavf_fill_data_desc(volatile struct ci_tx_desc *desc,
-	uint64_t desc_template,	uint16_t buffsz,
-	uint64_t buffer_addr)
-{
-	/* fill data descriptor qw1 from template */
-	desc->cmd_type_offset_bsz = desc_template;
-
-	/* set data buffer size */
-	desc->cmd_type_offset_bsz |=
-		(((uint64_t)buffsz << IAVF_TXD_DATA_QW1_TX_BUF_SZ_SHIFT) &
-		IAVF_TXD_DATA_QW1_TX_BUF_SZ_MASK);
-
-	desc->buffer_addr = rte_cpu_to_le_64(buffer_addr);
-	desc->cmd_type_offset_bsz = rte_cpu_to_le_64(desc->cmd_type_offset_bsz);
-}
-
+	/* LLDP switching field */
+	if (IAVF_CHECK_TX_LLDP(mbuf))
+		cd_type_cmd |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+
+	/* Tunneling field */
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		iavf_fill_ctx_desc_tunnelling_field((uint64_t *)&cd_tunneling_params, mbuf);
+
+	/* L2TAG2 field (VLAN) */
+	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
+		cd_l2tag2 = iavf_vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+			    mbuf->vlan_tci_outer : mbuf->vlan_tci;
+	} else if (ol_flags & RTE_MBUF_F_TX_VLAN &&
+		   iavf_vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+		cd_l2tag2 = mbuf->vlan_tci;
+	}
 
-static struct iavf_ipsec_crypto_pkt_metadata *
-iavf_ipsec_crypto_get_pkt_metadata(const struct ci_tx_queue *txq,
-		struct rte_mbuf *m)
-{
-	if (m->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD)
-		return RTE_MBUF_DYNFIELD(m, txq->ipsec_crypto_pkt_md_offset,
-				struct iavf_ipsec_crypto_pkt_metadata *);
+	/* Set outputs */
+	*qw0 = rte_cpu_to_le_64(cd_tunneling_params | ((uint64_t)cd_l2tag2 << 32));
+	*qw1 = rte_cpu_to_le_64(cd_type_cmd);
 
-	return NULL;
+	return 1; /* One context descriptor needed */
 }
 
 /* TX function */
@@ -2700,231 +2598,17 @@ uint16_t
 iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	volatile struct ci_tx_desc *txr = txq->ci_tx_ring;
-	struct ci_tx_entry *txe_ring = txq->sw_ring;
-	struct ci_tx_entry *txe, *txn;
-	struct rte_mbuf *mb, *mb_seg;
-	uint64_t buf_dma_addr;
-	uint16_t desc_idx, desc_idx_last;
-	uint16_t idx;
-	uint16_t slen;
-
-
-	/* Check if the descriptor ring needs to be cleaned. */
-	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_xmit_cleanup(txq);
-
-	desc_idx = txq->tx_tail;
-	txe = &txe_ring[desc_idx];
-
-	for (idx = 0; idx < nb_pkts; idx++) {
-		volatile struct ci_tx_desc *ddesc;
-		struct iavf_ipsec_crypto_pkt_metadata *ipsec_md;
-
-		uint16_t nb_desc_ctx, nb_desc_ipsec;
-		uint16_t nb_desc_data, nb_desc_required;
-		uint16_t tlen = 0, ipseclen = 0;
-		uint64_t ddesc_template = 0;
-		uint64_t ddesc_cmd = 0;
-
-		mb = tx_pkts[idx];
 
-		RTE_MBUF_PREFETCH_TO_FREE(txe->mbuf);
-
-		/**
-		 * Get metadata for ipsec crypto from mbuf dynamic fields if
-		 * security offload is specified.
-		 */
-		ipsec_md = iavf_ipsec_crypto_get_pkt_metadata(txq, mb);
-
-		nb_desc_data = mb->nb_segs;
-		nb_desc_ctx =
-			iavf_calc_context_desc(mb, txq->vlan_flag);
-		nb_desc_ipsec = !!(mb->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD);
-
-		/**
-		 * The number of descriptors that must be allocated for
-		 * a packet equals to the number of the segments of that
-		 * packet plus the context and ipsec descriptors if needed.
-		 * Recalculate the needed tx descs when TSO enabled in case
-		 * the mbuf data size exceeds max data size that hw allows
-		 * per tx desc.
-		 */
-		if (mb->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			nb_desc_required = ci_calc_pkt_desc(mb) + nb_desc_ctx + nb_desc_ipsec;
-		else
-			nb_desc_required = nb_desc_data + nb_desc_ctx + nb_desc_ipsec;
-
-		desc_idx_last = (uint16_t)(desc_idx + nb_desc_required - 1);
-
-		/* wrap descriptor ring */
-		if (desc_idx_last >= txq->nb_tx_desc)
-			desc_idx_last =
-				(uint16_t)(desc_idx_last - txq->nb_tx_desc);
-
-		PMD_TX_LOG(DEBUG,
-			"port_id=%u queue_id=%u tx_first=%u tx_last=%u",
-			txq->port_id, txq->queue_id, desc_idx, desc_idx_last);
-
-		if (nb_desc_required > txq->nb_tx_free) {
-			if (ci_tx_xmit_cleanup(txq)) {
-				if (idx == 0)
-					return 0;
-				goto end_of_tx;
-			}
-			if (unlikely(nb_desc_required > txq->tx_rs_thresh)) {
-				while (nb_desc_required > txq->nb_tx_free) {
-					if (ci_tx_xmit_cleanup(txq)) {
-						if (idx == 0)
-							return 0;
-						goto end_of_tx;
-					}
-				}
-			}
-		}
-
-		iavf_build_data_desc_cmd_offset_fields(&ddesc_template, mb,
-			txq->vlan_flag);
-
-			/* Setup TX context descriptor if required */
-		if (nb_desc_ctx) {
-			volatile struct iavf_tx_context_desc *ctx_desc =
-				(volatile struct iavf_tx_context_desc *)
-					&txr[desc_idx];
-
-			/* clear QW0 or the previous writeback value
-			 * may impact next write
-			 */
-			*(volatile uint64_t *)ctx_desc = 0;
-
-			txn = &txe_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
-
-			iavf_fill_context_desc(ctx_desc, mb, ipsec_md, &tlen,
-				txq->vlan_flag);
-			IAVF_DUMP_TX_DESC(txq, ctx_desc, desc_idx);
-
-			txe->last_id = desc_idx_last;
-			desc_idx = txe->next_id;
-			txe = txn;
-		}
-
-		if (nb_desc_ipsec) {
-			volatile struct iavf_tx_ipsec_desc *ipsec_desc =
-				(volatile struct iavf_tx_ipsec_desc *)
-					&txr[desc_idx];
-
-			txn = &txe_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
-
-			iavf_fill_ipsec_desc(ipsec_desc, ipsec_md, &ipseclen);
-
-			IAVF_DUMP_TX_DESC(txq, ipsec_desc, desc_idx);
-
-			txe->last_id = desc_idx_last;
-			desc_idx = txe->next_id;
-			txe = txn;
-		}
-
-		mb_seg = mb;
-
-		do {
-			ddesc = (volatile struct ci_tx_desc *)
-					&txr[desc_idx];
-
-			txn = &txe_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
-
-			txe->mbuf = mb_seg;
-
-			if ((mb_seg->ol_flags & RTE_MBUF_F_TX_SEC_OFFLOAD) &&
-					(mb_seg->ol_flags &
-						(RTE_MBUF_F_TX_TCP_SEG |
-						RTE_MBUF_F_TX_UDP_SEG))) {
-				slen = tlen + mb_seg->l2_len + mb_seg->l3_len +
-						mb_seg->outer_l3_len + ipseclen;
-				if (mb_seg->ol_flags & RTE_MBUF_F_TX_L4_MASK)
-					slen += mb_seg->l4_len;
-			} else {
-				slen = mb_seg->data_len;
-			}
-
-			buf_dma_addr = rte_mbuf_data_iova(mb_seg);
-			while ((mb_seg->ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
-					RTE_MBUF_F_TX_UDP_SEG)) &&
-					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
-				iavf_fill_data_desc(ddesc, ddesc_template,
-					CI_MAX_DATA_PER_TXD, buf_dma_addr);
-
-				IAVF_DUMP_TX_DESC(txq, ddesc, desc_idx);
-
-				buf_dma_addr += CI_MAX_DATA_PER_TXD;
-				slen -= CI_MAX_DATA_PER_TXD;
-
-				txe->last_id = desc_idx_last;
-				desc_idx = txe->next_id;
-				txe = txn;
-				ddesc = &txr[desc_idx];
-				txn = &txe_ring[txe->next_id];
-			}
-
-			iavf_fill_data_desc(ddesc, ddesc_template,
-					slen, buf_dma_addr);
-
-			IAVF_DUMP_TX_DESC(txq, ddesc, desc_idx);
-
-			txe->last_id = desc_idx_last;
-			desc_idx = txe->next_id;
-			txe = txn;
-			mb_seg = mb_seg->next;
-		} while (mb_seg);
-
-		/* The last packet data descriptor needs End Of Packet (EOP) */
-		ddesc_cmd = CI_TX_DESC_CMD_EOP;
-
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_desc_required);
-		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_desc_required);
-
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
-			PMD_TX_LOG(DEBUG, "Setting RS bit on TXD id="
-				   "%4u (port=%d queue=%d)",
-				   desc_idx_last, txq->port_id, txq->queue_id);
-
-			ddesc_cmd |= CI_TX_DESC_CMD_RS;
-
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
-		}
-
-		ddesc->cmd_type_offset_bsz |= rte_cpu_to_le_64(ddesc_cmd <<
-				IAVF_TXD_DATA_QW1_CMD_SHIFT);
-
-		IAVF_DUMP_TX_DESC(txq, ddesc, desc_idx - 1);
-	}
-
-end_of_tx:
-	rte_wmb();
-
-	PMD_TX_LOG(DEBUG, "port_id=%u queue_id=%u tx_tail=%u nb_tx=%u",
-		   txq->port_id, txq->queue_id, desc_idx, idx);
-
-	IAVF_PCI_REG_WRITE_RELAXED(txq->qtx_tail, desc_idx);
-	txq->tx_tail = desc_idx;
+	const struct ci_ipsec_ops ipsec_ops = {
+		.get_ipsec_desc = iavf_get_ipsec_desc,
+		.calc_segment_len = iavf_calc_ipsec_segment_len,
+	};
 
-	return idx;
+	/* IAVF does not support timestamp queues, so pass NULL for ts_fns */
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts,
+			    (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+				CI_VLAN_IN_L2TAG1 : CI_VLAN_IN_L2TAG2,
+			    iavf_get_context_desc, &ipsec_ops, NULL);
 }
 
 /* Check if the packet with vlan user priority is transmitted in the
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index cca5c25119..fe3385dcf6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -43,6 +43,7 @@
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+		RTE_ETH_TX_OFFLOAD_UDP_TSO |		\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
 		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
-- 
2.51.0

