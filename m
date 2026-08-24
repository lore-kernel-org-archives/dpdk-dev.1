Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB9C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 10:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83980402EB;
	Mon, 24 Aug 2026 12:23:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 378ED40270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787566985; x=1819102985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zxc7gv/c3dMg1xCvPUOUqc1MTvOuCF9U5EjUeHETHmM=;
 b=IjefsVHGbjlC/Z0Tm19vjoStOfpwSAcy+hX6VrYqQ27QkYShBH0vQgdh
 jq1oDwMucxyMhNNYhzsldSIVQruEtGHCzAuLsZjK+Lmrn2sJp+I/6q3yt
 6qQrpiQ8/L4ME2Rzoug/s1WUTIIr3YxsaNLXP7SIRvPGZRxiP1SnJonW9
 wWxh5ROx8/G4VSV7kOXTQUTI6JRV2vXTks5otY0c4OzGXle8zKrucTqkA
 /ZqYp3YlWzaQa/OU5wkQ0xjJSkr8IjjpArUGxJt87TmW4Q2BKUMjKP0Ak
 0W70Gk95ZWWbVZ5z8dakip79SL4Pb/YTYnqLbS5obZ/Eq2wQATAiDMsM+ w==;
X-CSE-ConnectionGUID: RUlu8x+UQEuPRrj2NI/RiA==
X-CSE-MsgGUID: TsNlLZ3NSXC+nV6GuVMA5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87884924"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87884924"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 03:23:05 -0700
X-CSE-ConnectionGUID: 1dH6ebJMRwm0dK/2UMOnRA==
X-CSE-MsgGUID: b53z8asbTG+J9CUH4Q1LzQ==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 24 Aug 2026 03:23:03 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 2/4] net/ice: add vector tunnel context encoding
Date: Mon, 24 Aug 2026 10:21:52 +0000
Message-Id: <1544dfcdca6e4accac523326948cbe2b4571e76b.1787566677.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787566677.git.anurag.mandal@intel.com>
References: <cover.1787566677.git.anurag.mandal@intel.com>
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
index 1d83a087cc..b84456357f 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -123,8 +123,12 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 
 	/* Tx Checksum Offload */
 	/* SET MACLEN */
-	td_offset |= (tx_pkt->l2_len >> 1) <<
-		CI_TX_DESC_LEN_MACLEN_S;
+	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+		td_offset |= (tx_pkt->outer_l2_len >> 1) <<
+			CI_TX_DESC_LEN_MACLEN_S;
+	else
+		td_offset |= (tx_pkt->l2_len >> 1) <<
+			CI_TX_DESC_LEN_MACLEN_S;
 
 	/* Enable L3 checksum offload */
 	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
@@ -172,4 +176,49 @@ ice_txd_enable_offload(struct rte_mbuf *tx_pkt,
 
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
+	ctx |= (uint64_t)(tx_pkt->outer_l3_len >> 2) << ICE_TXD_CTX_QW0_EIPLEN_S;
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
+		return ctx;
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

