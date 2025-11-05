Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 707E340B92;
	Wed,  5 Nov 2025 16:26:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7BDAF40A79;
 Wed,  5 Nov 2025 16:26:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356417; x=1793892417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pE1wczkJ4iF88o5PEux2VpZKxA242/3L7IkDXsqti+Q=;
 b=O/q/yaSenlfwW1KyCF9y+FM2JIOCMp7nNZeXnORyVCbWzdrmXrzl5r38
 bdohAD82upklxKCQ4wDaffeaVnqsnP7TbZp0tgBnPSxI3D9u4nwa8SABs
 pQ+v8Nxc7kmzPU2GJC1Ne5QTZmMzx8gN5fnJZtCHjivACGxz2xoKxsPoC
 w2rQtUpl0RLDBYkKW4vMz1cSqd0TeqhoH1ufpDvDohTkjHzwc1dfR2ieU
 m9mYlH0acFUAvWLLW7B0Edpj7mk3sRayKfjQFBjeI2Lq6hjsmkmW3TvDm
 xG62YtR3vxsx2DKBAsM6ixcLO16eNPpJ5M8cJ8hAqj8A0hEY0YynLmSld Q==;
X-CSE-ConnectionGUID: Iaq9Ke2eT9upkbPNtG2yEg==
X-CSE-MsgGUID: BxJwL1cNQVyWsYNYm6YG8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127083"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127083"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:56 -0800
X-CSE-ConnectionGUID: Ulna6KD/Qtuo6pos9BK5ew==
X-CSE-MsgGUID: d6XuVwQpREeP81QZBIjTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257307"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:55 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 2/6] net/iavf: remove duplication in AVX-512 VLAN insert
 logic
Date: Wed,  5 Nov 2025 15:26:38 +0000
Message-Id: <20251105152642.2981673-3-ciara.loftus@intel.com>
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

The part of the transmit descriptor that holds the L2TAG1 VLAN tag was
potentially being written to twice on the AVX-512 context path. Fix this
by removing one of the writes.

Fixes: 4f8259df563a ("net/iavf: enable Tx outer checksum offload on AVX512")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 66 ++++++-------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index d40a858413..28d83ca3ed 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2127,63 +2127,37 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				((uint64_t)pkt[0]->data_len <<
 					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 
-		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
-			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw1 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw1 |=
-					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else {
-				hi_data_qw1 |=
-					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
-			}
+		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+			hi_ctx_qw1 |=
+				IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw1 |=
+				(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
 		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				(uint64_t)pkt[0]->vlan_tci_outer :
+				(uint64_t)pkt[0]->vlan_tci;
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
-				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			} else {
-				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
-				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			}
+			low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
 		if (IAVF_CHECK_TX_LLDP(pkt[1]))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
-		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
-			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw0 |=
-					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-			} else {
-				hi_data_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
-			}
+		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+			hi_ctx_qw0 |=
+				IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw0 |=
+				(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
 		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				(uint64_t)pkt[0]->vlan_tci_outer :
+				(uint64_t)pkt[0]->vlan_tci;
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
-				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			} else {
-				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
-				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			}
+			low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
 		if (IAVF_CHECK_TX_LLDP(pkt[0]))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-- 
2.34.1

