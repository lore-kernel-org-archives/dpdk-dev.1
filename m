Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944ACD2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B9440A72;
	Tue, 13 Jan 2026 16:15:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D315A406BC
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317330; x=1799853330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2gXWzlGrR98xxwkuaUtYExHYFz6TezrbhQ0Sm7jlGBY=;
 b=ZUOSfJCi3qdEXpyTnX5EPhJayU9FuaepSPDEOaJIe0NrwpQTmquTxrMF
 NTlTZxBHPrXGpIFS8MJK6Q2XACdZe+kKwqG3FPZhcjnDwSLdl8GWZJ91S
 Gtx9ZV4+iJsuhQmyk4ru0r+Mgrtou9wB1xXbXtRAIZKbWDDs0Z7IqDi47
 Vo56PrtH5TLim7Pn4FHaGdoPhMlmGlWvpCwcJDjo4wTJvV+XP/aWYKE+2
 RxCTSC8nruQ9jOotVGsbGCucIoh7vhV4njbPlij0+LkE1uNUqfDMAfTyX
 pIkYsVERZwjZ/HSu5CCXTo8ZGxxrUZCuvR7hg78iYbgCs3nPyXtJ8egcW Q==;
X-CSE-ConnectionGUID: QObtZCCFR+OI04I1pbVTXQ==
X-CSE-MsgGUID: 0+MVoIdKQj+cEy8ZzPRL+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969167"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:30 -0800
X-CSE-ConnectionGUID: z3Bb/9v2RfCw2uevxYF+Lw==
X-CSE-MsgGUID: piXjX9LvQUi402quhHeaLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556584"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:28 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 11/36] net/intel: create common checksum Tx offload function
Date: Tue, 13 Jan 2026 15:14:35 +0000
Message-ID: <20260113151505.1871271-12-bruce.richardson@intel.com>
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
index db36ec86f7..617b93c92b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -310,61 +310,6 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
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
@@ -1172,7 +1117,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			i40e_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
 		if (nb_ctx) {
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index dc21a89ce3..b9c38995f0 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2942,68 +2942,6 @@ ice_parse_tunneling_params(uint64_t ol_flags,
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
@@ -3201,7 +3139,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			ice_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
 		if (nb_ctx) {
-- 
2.51.0

