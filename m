Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE75C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D91394065A;
	Mon, 31 Aug 2026 12:36:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9665B40615
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788172607; x=1819708607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=awRPoU5y1FH2KbFcSOS77vK01oL/kHzTEPWXIBhEX9g=;
 b=ncRNqb2pSScvQEvh1Cz6pecmu7pzdmLseSLxGPAM0AAUPTusP59xvDMp
 gdznA9+KaK/Pg0Lv0/pEOhkagzZs7V0o1tAialwZ4wuz5aqKMxboUNk8i
 EYGs5vAL1zDchMp2lYnw4DPG/EDwtPhC5dHfyKdrdDWynQPgh2iJT6MdV
 AgwMBpQf9+87UEuxxT4u5BjugRTCI0WVBwMQnEAxI46H/hiX3snHxG2ER
 KLH9OKY4yY8gKymKpYQoG+gjIDFy3C5pWeLopXKC5rILroEHM6771nHMW
 79uYsk4AY0oo4JSk7myt2Oeo/nOCvUuymM+wFkj2wabCa2fMgO6TLqwde Q==;
X-CSE-ConnectionGUID: ovWiwWvqSBa/dSp6Oc1uiQ==
X-CSE-MsgGUID: GWODn0QhTPGxsG36ascmnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88625949"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88625949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:36:47 -0700
X-CSE-ConnectionGUID: ckTeoMUaTIqk95Z+c+Cc1Q==
X-CSE-MsgGUID: qpHcHT6rR/Kg6xPNuSpIYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="268807434"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 31 Aug 2026 03:36:46 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 2/4] net/ice: add vector tunnel context encoding
Date: Mon, 31 Aug 2026 10:35:28 +0000
Message-Id: <72b5a4dfd8eac0cfa03338e17a9577221093a13e.1788171502.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788171502.git.anurag.mandal@intel.com>
References: <cover.1788171502.git.anurag.mandal@intel.com>
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

Added helpers to encode tunnel context descriptors,
and checksum offsets.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 53 ++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 1d83a087cc..30f5245622 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -123,8 +123,10 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 
 	/* Tx Checksum Offload */
 	/* SET MACLEN */
-	td_offset |= (tx_pkt->l2_len >> 1) <<
-		CI_TX_DESC_LEN_MACLEN_S;
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		td_offset |= (tx_pkt->outer_l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
+	else
+		td_offset |= (tx_pkt->l2_len >> 1) << CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offload */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
@@ -172,4 +174,51 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 
 	*txd_hi |= ((uint64_t)td_cmd) << CI_TXD_QW1_CMD_S;
 }
+
+static inline uint64_t
+ice_txd_tunneling_ctx(const struct rte_mbuf *tx_pkt)
+{
+	const uint64_t ol_flags = tx_pkt->ol_flags;
+	uint64_t ctx = 0;
+
+	if (!(ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK))
+		return 0;
+
+	if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
+		ctx |= ICE_TX_CTX_EIPT_IPV4;
+	else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV4)
+		ctx |= ICE_TX_CTX_EIPT_IPV4_NO_CSUM;
+	else if (ol_flags & RTE_MBUF_F_TX_OUTER_IPV6)
+		ctx |= ICE_TX_CTX_EIPT_IPV6;
+
+	/* EIPLEN: outer IP header length in DWords, only valid if EIPT is set */
+	if (ctx & ICE_TXD_CTX_QW0_EIPT_M)
+		ctx |= (uint64_t)(tx_pkt->outer_l3_len >> 2) << ICE_TXD_CTX_QW0_EIPLEN_S;
+
+	switch (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+	case RTE_MBUF_F_TX_TUNNEL_IPIP:
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE:
+	case RTE_MBUF_F_TX_TUNNEL_GTP:
+	case RTE_MBUF_F_TX_TUNNEL_GENEVE:
+		ctx |= ICE_TXD_CTX_UDP_TUNNELING;
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_GRE:
+		ctx |= ICE_TXD_CTX_GRE_TUNNELING;
+		break;
+	default:
+		PMD_TX_LOG(ERR, "Tunnel type not supported");
+		return 0;
+	}
+
+	ctx |= (uint64_t)(tx_pkt->l2_len >> 1) << ICE_TXD_CTX_QW0_NATLEN_S;
+
+	if ((ctx & ICE_TXD_CTX_QW0_EIPT_M) &&
+			(ctx & ICE_TXD_CTX_UDP_TUNNELING) &&
+			(ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM))
+		ctx |= ICE_TXD_CTX_QW0_L4T_CS_M;
+
+	return ctx;
+}
 #endif
-- 
2.34.1

