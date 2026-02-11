Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A66AECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 644DE40E09;
	Wed, 11 Feb 2026 19:13:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9C68540B9E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833624; x=1802369624;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eEzjDZ34WbDzZDBu6igSUdXaZS2NA6/S3Y7DSzW0vCM=;
 b=cittE6vCQuBRHV1wnQkugXwlj+HMXeeJm2NHb+8aGJQ9Fn22xf1h4XGB
 +hx1q+d3ktYEvAD32OA+YSUd0P0L1968Ll25d8r4g8K7ZVFYzVvrMFioV
 SpPhAbAQl5FWUmJw3nUGHJkksr7ebFFKHbMmmX903D8vQp8wFUjwBeYw/
 esP1Hv60/GlFL1ag3JA2z3GJb6e31p8g5Fk/aoBr4sPlIdEQJMpsRIn6n
 UldfFDQpfmhxWQr2L9zrOug/ZmShKXFj2MEtvua3IihdshyXHMYsRs6TZ
 DdWeENofJz0Mc4Fp4zP9ftjKIpsUcFnKQGL2KYRC5w9Xzucan0Wsfil3N w==;
X-CSE-ConnectionGUID: 4LI8kJiqRPSFBRHzVyRtzA==
X-CSE-MsgGUID: veKr1YRwSFK1bBV+89Y7zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834678"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834678"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:43 -0800
X-CSE-ConnectionGUID: fE0vHZQsSYCKx0ZgsRvoeQ==
X-CSE-MsgGUID: debvN50ETDu6LNXphdOtQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986330"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 11/35] net/intel: create common checksum Tx offload function
Date: Wed, 11 Feb 2026 18:12:40 +0000
Message-ID: <20260211181309.2838042-12-bruce.richardson@intel.com>
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

Since i40e and ice have the same checksum offload logic, merge their
functions into one. Future rework should enable this to be used by more
drivers also.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 50 +++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 52 +-----------------------
 drivers/net/intel/i40e/i40e_rxtx.h   |  1 +
 drivers/net/intel/ice/ice_rxtx.c     | 60 +---------------------------
 drivers/net/intel/ice/ice_rxtx.h     |  1 +
 5 files changed, 54 insertions(+), 110 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 573f5136a9..9b19d56ea6 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -59,6 +59,56 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	return 0;
 }
 
+/* Common checksum enable function for Intel drivers (ice, i40e, etc.) */
+static inline void
+ci_txd_enable_checksum(uint64_t ol_flags,
+		       uint32_t *td_cmd,
+		       uint32_t *td_offset,
+		       union ci_tx_offload tx_offload)
+{
+	/* Enable L3 checksum offloads */
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4_CSUM;
+		*td_offset |= (tx_offload.l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV4;
+		*td_offset |= (tx_offload.l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	} else if (ol_flags & RTE_MBUF_F_TX_IPV6) {
+		*td_cmd |= CI_TX_DESC_CMD_IIPT_IPV6;
+		*td_offset |= (tx_offload.l3_len >> 2) << CI_TX_DESC_LEN_IPLEN_S;
+	}
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_offset |= (tx_offload.l4_len >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		return;
+	}
+
+	if (ol_flags & RTE_MBUF_F_TX_UDP_SEG) {
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_offset |= (tx_offload.l4_len >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		return;
+	}
+
+	/* Enable L4 checksum offloads */
+	switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_TCP;
+		*td_offset |= (sizeof(struct rte_tcp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_SCTP;
+		*td_offset |= (sizeof(struct rte_sctp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		*td_cmd |= CI_TX_DESC_CMD_L4T_EOFT_UDP;
+		*td_offset |= (sizeof(struct rte_udp_hdr) >> 2) << CI_TX_DESC_LEN_L4_LEN_S;
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
index 12a21407c5..c318b4c84e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -310,56 +310,6 @@ i40e_parse_tunneling_params(uint64_t ol_flags,
 		*cd_tunneling |= I40E_TXD_CTX_QW0_L4T_CS_MASK;
 }
 
-static inline void
-i40e_txd_enable_checksum(uint64_t ol_flags,
-			uint32_t *td_cmd,
-			uint32_t *td_offset,
-			union ci_tx_offload tx_offload)
-{
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
@@ -1167,7 +1117,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			i40e_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						 &td_offset, tx_offload);
 
 		if (nb_ctx) {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 307ffa3049..db8525d52d 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -100,6 +100,7 @@ enum i40e_header_split_mode {
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+		RTE_ETH_TX_OFFLOAD_UDP_TSO |		\
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
 		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
 		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 63bce7bd9e..4792aa9a8b 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2954,64 +2954,6 @@ ice_parse_tunneling_params(uint64_t ol_flags,
 		*cd_tunneling |= ICE_TXD_CTX_QW0_L4T_CS_M;
 }
 
-static inline void
-ice_txd_enable_checksum(uint64_t ol_flags,
-			uint32_t *td_cmd,
-			uint32_t *td_offset,
-			union ci_tx_offload tx_offload)
-{
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
@@ -3209,7 +3151,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		/* Enable checksum offloading */
 		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
-			ice_txd_enable_checksum(ol_flags, &td_cmd,
+			ci_txd_enable_checksum(ol_flags, &td_cmd,
 						&td_offset, tx_offload);
 
 		if (nb_ctx) {
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index cd5fa93d1c..7d6480b410 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -112,6 +112,7 @@
 #define ICE_TX_SCALAR_OFFLOADS (		\
 	RTE_ETH_TX_OFFLOAD_VLAN_INSERT |	\
 	RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
+	RTE_ETH_TX_OFFLOAD_UDP_TSO |		\
 	RTE_ETH_TX_OFFLOAD_MULTI_SEGS |		\
 	RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |	\
 	RTE_ETH_TX_OFFLOAD_QINQ_INSERT |	\
-- 
2.51.0

