Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D1E66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:27:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 859584067C;
	Fri, 19 Dec 2025 18:26:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A754F4068A
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165185; x=1797701185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NxurympIpLI4UGoU0Ap6UNXzGOe0nP7WpSzUyyvKlvA=;
 b=UWxvgLcS91aj9Ovj/PiAuC/opP17OQUuTw+vd5UIpd/f5XPSuCBgclKu
 TzBAy36GQHOH+MoS6c8SSraFS8OjmgPkSDsv5j7MzXztdOC4pOdIWUAAQ
 Jcb5AzSz9iBwNfTBS0cDXwAID9Guv9s5ute1YBLmN1YGmgnDH88Dn0Lfc
 FwaYOm/Kx0Ecj6qZbYNZjHxvxZudCthYuriULZKOVyzfvnGZjNRL/7JQ+
 j/trcA+7Ub4VS+ALbJKCtLTSh0KE4812qpvYSVH10TltpUvNtpW2TZteJ
 Xire9n+2sYc1pVXcKOuqfFQpzJcOCRMEUjHQw3UGRluWzvJ2ryjkL/tgF w==;
X-CSE-ConnectionGUID: +Jabaq26RASD1o85w94q4w==
X-CSE-MsgGUID: ZJFh7jicTIyiX1R6lIrRmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759486"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759486"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:25 -0800
X-CSE-ConnectionGUID: +KclsNf2SWixfSh2DlUMhQ==
X-CSE-MsgGUID: 429RsDKAQK2Q/60PbxlzSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170445"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC PATCH 11/27] net/intel: create common checksum Tx offload
 function
Date: Fri, 19 Dec 2025 17:25:28 +0000
Message-ID: <20251219172548.2660777-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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

Since i40e and ice have the same checksum offload logic, merge their
functions into one. Future rework should enable this to be used by more
drivers also.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 63 +++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c       | 57 +--------------------
 drivers/net/intel/ice/ice_rxtx.c         | 64 +-----------------------
 3 files changed, 65 insertions(+), 119 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index f894cea616..95ee7dc35f 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -64,6 +64,69 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	return 0;
 }
 
+/* Common checksum enable function for Intel drivers (ice, i40e, etc.) */
+static inline void
+ci_txd_enable_checksum(uint64_t ol_flags,
+		       uint32_t *td_cmd,
+		       uint32_t *td_offset,
+		       union ci_tx_offload tx_offload)
+{
+	/* Set MACLEN */
+	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
+		*td_offset |= (tx_offload.l2_len >> 1)
+			<< CI_TX_DESC_LEN_MACLEN_S;
+
+	/* Enable L3 checksum offloads */
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
+		*td_offset |= (tx_offload.l3_len >> 2) <<
+			CI_TX_DESC_LEN_IPLEN_S;
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
+		*td_offset |= (tx_offload.l3_len >> 2) <<
+			CI_TX_DESC_LEN_IPLEN_S;
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
+		*td_offset |= (tx_offload.l3_len >> 2) <<
+			CI_TX_DESC_LEN_IPLEN_S;
+	}
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_offset |= (tx_offload.l4_len >> 2) <<
+			      CI_TX_DESC_LEN_L4_LEN_S;
+		return;
+	}
+
+	if (ol_flags & RTE_MBUF_F_TX_UDP_SEG) {
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_offset |= (tx_offload.l4_len >> 2) <<
+			      CI_TX_DESC_LEN_L4_LEN_S;
+		return;
+	}
+
+	/* Enable L4 checksum offloads */
+	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
+			      CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
+		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
+			      CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
+			      CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	default:
+		break;
+	}
+}
+
 static inline uint16_t
 ci_div_roundup16(uint16_t x, uint16_t y)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e1964eab97..5d1b2e4217 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -306,61 +306,6 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
 		*cd_tunneling |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
 }
 
-static inline void
-i40e_txd_enable_checksum(uint64_t ol_flags,
-			uint32_t *td_cmd,
-			uint32_t *td_offset,
-			union ci_tx_offload tx_offload)
-{
-	/* Set MACLEN */
-	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
-		*td_offset |= (tx_offload.l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-
-	/* Enable L3 checksum offloads */
-	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		*td_offset |= (tx_offload.l3_len >> 2)
-				<< CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
-		*td_offset |= (tx_offload.l3_len >> 2)
-				<< CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
-		*td_offset |= (tx_offload.l3_len >> 2)
-				<< CI_TX_DESC_LEN_IPLEN_S;
-	}
-
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= (tx_offload.l4_len >> 2)
-			<< CI_TX_DESC_LEN_L4_LEN_S;
-		return;
-	}
-
-	/* Enable L4 checksum offloads */
-	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
-	case RTE_MBUF_F_TX_TCP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
-		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_UDP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-				CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	default:
-		break;
-	}
-}
-
 /* Construct the tx flags */
 static inline uint64_t
 i40e_build_ctob(uint32_t td_cmd,
@@ -1167,7 +1112,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			i40e_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
 		if (nb_ctx) {
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index e102eb9bcc..0b0179e1fa 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2947,68 +2947,6 @@ ice_parse_tunneling_params(uint64_t ol_flags,
 		*cd_tunneling |= ICE_TXD_CTX_QW0_L4T_CS_M;
 }
 
-static inline void
-ice_txd_enable_checksum(uint64_t ol_flags,
-			uint32_t *td_cmd,
-			uint32_t *td_offset,
-			union ci_tx_offload tx_offload)
-{
-	/* Set MACLEN */
-	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
-		*td_offset |= (tx_offload.l2_len >> 1)
-			<< CI_TX_DESC_LEN_MACLEN_S;
-
-	/* Enable L3 checksum offloads */
-	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
-		*td_offset |= (tx_offload.l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
-		*td_offset |= (tx_offload.l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
-		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
-		*td_offset |= (tx_offload.l3_len >> 2) <<
-			CI_TX_DESC_LEN_IPLEN_S;
-	}
-
-	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= (tx_offload.l4_len >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
-		return;
-	}
-
-	if (ol_flags & RTE_MBUF_F_TX_UDP_SEG) {
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		*td_offset |= (tx_offload.l4_len >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
-		return;
-	}
-
-	/* Enable L4 checksum offloads */
-	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
-	case RTE_MBUF_F_TX_TCP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
-		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_SCTP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
-		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	case RTE_MBUF_F_TX_UDP_CKSUM:
-		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
-		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) <<
-			      CI_TX_DESC_LEN_L4_LEN_S;
-		break;
-	default:
-		break;
-	}
-}
-
 /* Construct the tx flags */
 static inline uint64_t
 ice_build_ctob(uint32_t td_cmd,
@@ -3206,7 +3144,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			ice_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
 		if (nb_ctx) {
-- 
2.51.0

