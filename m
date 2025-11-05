Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A1CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 010E040DD2;
	Wed,  5 Nov 2025 16:27:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AB66840B9B
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356420; x=1793892420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wrBKxLuBYywDzx6wdg1wpt9mRWJr3cjbsIHqd7o6l1Q=;
 b=YZeNqSPGW6O0X4aCiO1xXwYI9hnx8Bzb2e8Iw/eYTJ8lC7qbYuV8zPWb
 5gSDuGXScqp7Cda1EPhGk8s236aJobsjRmLQWS7Aa6ZJ/5kFrVqkxxFyR
 3x1+7MbBbMc/gO0VnfB13bfsGgprLTd+9q7EdPeBsRh8po3mA+3YjGP4E
 dcrlc7OWrdmelQjLIE+FVavg6emCjPw2QrNH8tY8JBuo7YNr0l51vGiB8
 Cq8Vdi9d6srvI1IzQ1pOKgnDqJIRzMpDI15fVErDaN3WIdlOGSfauG7kY
 vwH9arpGvw+bmWCSBIjQf6RQtbih3n67s3BR73xOnwPxDqSxLkFDNQW0m w==;
X-CSE-ConnectionGUID: zf9bQ8yySKa5TpdiddzVwg==
X-CSE-MsgGUID: n9B42q0JT6W2eVjradmgjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127088"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127088"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:59 -0800
X-CSE-ConnectionGUID: OJy3147fTO2fDYV/EfOuCA==
X-CSE-MsgGUID: bKqzUhH7T9GuF3FFBO1hcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257327"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:58 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 6/6] net/iavf: fix QinQ insertion with mbuf flags VLAN and
 QINQ
Date: Wed,  5 Nov 2025 15:26:42 +0000
Message-Id: <20251105152642.2981673-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105152642.2981673-1-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251105152642.2981673-1-ciara.loftus@intel.com>
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

Fix an issue that would arise in the event an mbuf had both the VLAN and
QINQ insertion offload flags set. In this case the L2TAG2 field would be
written to twice and could cause the tag to be corrupted. Reorder the
logic of populating the L2TAG2 field and ensure that the field is only
written to once.

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 26 +++++++++----------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  9 +++----
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index cd067a0199..7c0907b7cf 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2136,13 +2136,6 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
-			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw1 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw1 |=
-					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[1]->vlan_tci :
@@ -2150,6 +2143,12 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw1 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw1 |=
+					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
 #endif
@@ -2159,13 +2158,6 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 		if (offload) {
-			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw0 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			}
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
 					(uint64_t)pkt[0]->vlan_tci :
@@ -2173,6 +2165,12 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw0 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |=
+					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			}
 		}
 #endif
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 36150f0f65..d98fb9fe29 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -230,12 +230,6 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 #endif
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
-	if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
-		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
-			    IAVF_TXD_QW1_L2TAG1_SHIFT);
-	}
-
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
 		/* vlan_flag specifies outer tag location for QinQ. */
@@ -245,6 +239,9 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 		else
 			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
 					IAVF_TXD_QW1_L2TAG1_SHIFT);
+	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
+		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
+		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT);
 	}
 #endif
 
-- 
2.34.1

