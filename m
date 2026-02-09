Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E049DE81BDF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6713840B95;
	Mon,  9 Feb 2026 17:46:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8BAA840A4B
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655557; x=1802191557;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qtxcxBZ0418PPiP8WX3tz0YXqqz3ECrfl5rhjBu+iP0=;
 b=aeSKA42j5Z62Sh1bnPWlirYpV2AO7iyNQm28rYZk/r/0xs8gW5d51hNP
 BmY7WdkyFkotf8JHW97J9Udm4DsbATq6QnMRemn9NMdSyilozYByH+ONj
 AHbGdiJ4884+6BHZmZ9JdVAlTsGZoVRpkvmK26qgcwpgLlRF+Q+2EHKsl
 bDYJMPjSw4oh4Di0rT9vf4ygpUxQI4fI5gBmfqGuYJESnVoXPVSM79Gw7
 gDiYZgYPnJ/bSzry3S+jSEqv2UbDXVgLYiRMEI7KvYGigm1rprYhZb+D3
 ggKJBTo1eTAnl8qG0jENr2uxhOSJPqMrcYtzCTvwRJwi4aUQdFcTKr+5d g==;
X-CSE-ConnectionGUID: UDWDBK/1TMyWKtuUeCUO4g==
X-CSE-MsgGUID: zNiUDPaASmqCtiZhLTCQIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663425"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663425"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:45:56 -0800
X-CSE-ConnectionGUID: b2cdPGTFQdS035x8nzDWxw==
X-CSE-MsgGUID: KPa31h8VREqb+OfdBrfeug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789107"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:45:55 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 10/35] net/intel: create common checksum Tx offload function
Date: Mon,  9 Feb 2026 16:45:08 +0000
Message-ID: <20260209164538.1428499-11-bruce.richardson@intel.com>
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

Since i40e and ice have the same checksum offload logic, merge their
functions into one. Future rework should enable this to be used by more
drivers also.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 52 +-----------------------
 drivers/net/intel/i40e/i40e_rxtx.h   |  1 +
 drivers/net/intel/ice/ice_rxtx.c     | 60 +---------------------------
 drivers/net/intel/ice/ice_rxtx.h     |  1 +
 5 files changed, 62 insertions(+), 110 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 573f5136a9..cf0dcb4b2c 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -59,6 +59,64 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
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

