Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E6C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91CC74281D;
	Thu,  3 Sep 2026 19:02:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5E05E42670
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788454930; x=1819990930;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pE0DblvdTh5LowiyVhYraYDnNklLB1FUJ989Ki4ngMY=;
 b=JvV+tdPgwIYdGt6Z8wV597SZGyB271YYML0ShcqWnCGtWqo9Rrk1M8XN
 8umdrTiEjYABmwO5Fg/WBx0DtpnxMu0w+x37Up+rwLphBg+X2vGNh5F51
 26czvQG9dMs/IqNUx9JQqBXsHYG3iMrEH4OlW35U75+9+D6cV3PLbWebB
 KZYqZtT4e0GCRxLr37/CFjpme3sEZLoPvp0JSOBDfQyBf0jNEn3uUKRqA
 Y6iWGXYrUggLwPPoLO/O8eO4MCj+4OlkNCJ9i82raIVZCHpMgw4LufqTM
 F7SltwYzIIQYSdqNvOQagMW6dTXvIxK9dmU33ZLr7knFe7EwkE8OQ0uVz A==;
X-CSE-ConnectionGUID: RNfmsQUURuCB5pqvKFAHLg==
X-CSE-MsgGUID: 9e+Xu/U7R+mkN3ovcPhm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100462990"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100462990"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:01:50 -0700
X-CSE-ConnectionGUID: MjtJeSuQRIishILgpeVLNw==
X-CSE-MsgGUID: tcTrsK7OQSCXvZkDXje+JA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2026 10:01:48 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 04/13] net/iavf: deduplicate tunnel field fill functions
Date: Thu,  3 Sep 2026 18:01:33 +0100
Message-ID: <20260903170140.360477-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903170140.360477-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
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

Each of the avx2 and avx512 Tx functions used two separate subfunctions
to insert the tunneling fields into the context descriptor. Except for
some minor differences (a flags guard on one) the two were identical, so
remove the one missing the additional guard.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 77 +------------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 77 +------------------
 2 files changed, 4 insertions(+), 150 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 2aaa713702..10e96a8510 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1833,79 +1833,6 @@ iavf_fill_ctx_desc_tunneling_avx2(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 	}
 }
 
-static inline void
-iavf_fill_ctx_desc_tunneling_field(volatile uint64_t *qw0,
-		const struct rte_mbuf *m)
-{
-	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
-	uint64_t eip_len = 0;
-	uint64_t eip_noinc = 0;
-	/* Default - IP_ID is increment in each segment of LSO */
-
-	switch (m->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
-			RTE_MBUF_F_TX_OUTER_IPV6 |
-			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
-	case RTE_MBUF_F_TX_OUTER_IPV4:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	case RTE_MBUF_F_TX_OUTER_IPV6:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	}
-
-	/* L4TUNT: L4 Tunneling Type */
-	switch (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-	case RTE_MBUF_F_TX_TUNNEL_IPIP:
-		/* for non UDP / GRE tunneling, set to 00b */
-		break;
-	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
-	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
-	case RTE_MBUF_F_TX_TUNNEL_GTP:
-	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-		eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
-		break;
-	case RTE_MBUF_F_TX_TUNNEL_GRE:
-		eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
-		break;
-	default:
-		PMD_TX_LOG(ERR, "Tunnel type not supported");
-		return;
-	}
-
-	/* L4TUNLEN: L4 Tunneling Length, in Words
-	 *
-	 * We depend on app to set rte_mbuf.l2_len correctly.
-	 * For IP in GRE it should be set to the length of the GRE
-	 * header;
-	 * For MAC in GRE or MAC in UDP it should be set to the length
-	 * of the GRE or UDP headers plus the inner MAC up to including
-	 * its last Ethertype.
-	 * If MPLS labels exists, it should include them as well.
-	 */
-	eip_typ |= (m->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
-
-	/**
-	 * Calculate the tunneling UDP checksum.
-	 * Shall be set only if L4TUNT = 01b and EIPT is not zero
-	 */
-	if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV6 |
-				IAVF_TX_CTX_EXT_IP_IPV4 |
-				IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
-			(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
-			(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-		eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
-
-	*qw0 = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
-		eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
-		eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
-}
-
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
@@ -1969,7 +1896,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw1, pkt[1]);
+			iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
@@ -1990,7 +1917,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunneling_field(&low_ctx_qw0, pkt[0]);
+			iavf_fill_ctx_desc_tunneling_avx2(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 8e44406511..58ed89a72a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -1972,79 +1972,6 @@ iavf_fill_ctx_desc_tunneling_avx512(uint64_t *low_ctx_qw, struct rte_mbuf *pkt)
 	}
 }
 
-static inline void
-iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
-		const struct rte_mbuf *m)
-{
-	uint64_t eip_typ = IAVF_TX_CTX_DESC_EIPT_NONE;
-	uint64_t eip_len = 0;
-	uint64_t eip_noinc = 0;
-	/* Default - IP_ID is increment in each segment of LSO */
-
-	switch (m->ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 |
-			RTE_MBUF_F_TX_OUTER_IPV6 |
-			RTE_MBUF_F_TX_OUTER_IP_CKSUM)) {
-	case RTE_MBUF_F_TX_OUTER_IPV4:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_NO_CHECKSUM_OFFLOAD;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	case RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IP_CKSUM:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV4_CHECKSUM_OFFLOAD;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	case RTE_MBUF_F_TX_OUTER_IPV6:
-		eip_typ = IAVF_TX_CTX_DESC_EIPT_IPV6;
-		eip_len = m->outer_l3_len >> 2;
-	break;
-	}
-
-	/* L4TUNT: L4 Tunneling Type */
-	switch (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
-	case RTE_MBUF_F_TX_TUNNEL_IPIP:
-		/* for non UDP / GRE tunneling, set to 00b */
-		break;
-	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
-	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
-	case RTE_MBUF_F_TX_TUNNEL_GTP:
-	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
-		eip_typ |= IAVF_TXD_CTX_UDP_TUNNELING;
-		break;
-	case RTE_MBUF_F_TX_TUNNEL_GRE:
-		eip_typ |= IAVF_TXD_CTX_GRE_TUNNELING;
-		break;
-	default:
-		PMD_TX_LOG(ERR, "Tunnel type not supported");
-		return;
-	}
-
-	/* L4TUNLEN: L4 Tunneling Length, in Words
-	 *
-	 * We depend on app to set rte_mbuf.l2_len correctly.
-	 * For IP in GRE it should be set to the length of the GRE
-	 * header;
-	 * For MAC in GRE or MAC in UDP it should be set to the length
-	 * of the GRE or UDP headers plus the inner MAC up to including
-	 * its last Ethertype.
-	 * If MPLS labels exists, it should include them as well.
-	 */
-	eip_typ |= (m->l2_len >> 1) << IAVF_TXD_CTX_QW0_NATLEN_SHIFT;
-
-	/**
-	 * Calculate the tunneling UDP checksum.
-	 * Shall be set only if L4TUNT = 01b and EIPT is not zero
-	 */
-	if ((eip_typ & (IAVF_TX_CTX_EXT_IP_IPV6 |
-				IAVF_TX_CTX_EXT_IP_IPV4 |
-				IAVF_TX_CTX_EXT_IP_IPV4_NO_CSUM)) &&
-			(eip_typ & IAVF_TXD_CTX_UDP_TUNNELING) &&
-			(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
-		eip_typ |= IAVF_TXD_CTX_QW0_L4T_CS_MASK;
-
-	*qw0 = eip_typ << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPT_SHIFT |
-		eip_len << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIPLEN_SHIFT |
-		eip_noinc << IAVF_TXD_CTX_QW0_TUN_PARAMS_EIP_NOINC_SHIFT;
-}
-
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		uint64_t flags, bool offload, enum ci_l2tag_pos single_vlan_pos,
@@ -2106,7 +2033,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw1; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw1, pkt[1]);
+			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw1, pkt[1]);
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[1]->vlan_tci_outer :
@@ -2126,7 +2053,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 
 		if (offload) {
 			/* tunnel fill assigns low_ctx_qw0; must run before QinQ/VLAN OR below */
-			iavf_fill_ctx_desc_tunnelling_field(&low_ctx_qw0, pkt[0]);
+			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw0, pkt[0]);
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = qinq_outer_pos == CI_TAG_IN_CTX_DESC ?
 					(uint64_t)pkt[0]->vlan_tci_outer :
-- 
2.53.0

