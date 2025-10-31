Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB68CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AF5E40651;
	Fri, 31 Oct 2025 16:23:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E646740150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 16:23:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761924191; x=1793460191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OdCsNNXi41Jad3n8Z7mTHEGRHmWgEczDXEXLfJEC7B0=;
 b=MdGbswaUNQBZTpobcaornrI8W/8qPL77ZaDfBCaUSlZx4JqOVuCP5p7K
 Pz93jRdJV0QcJ2Q5H1+CsS30RKc2pGce/7Fkk1SvU6BSTKhhStuqD2wGv
 hlDFWQTqToiw8y+Yxj/4b9fgs+6Hh7dVWnoyehPv0ey2149+sUHHEHCpc
 gSP0NRtL8+0g+wBCMFaOkDGlgD7UdzpK0egM86/sQQN29LE3bB4uCs2Yq
 NdvxGQKmiNE5s9TBfI6E2Ag3UYx+OR1ImrSdbeaz6MQKNMFrkmkg8hdAV
 66I/k87rn+j8DGC88BktyHKGeebquqSC/BpWPyx/cSE/0vRe+lBIzOHtX g==;
X-CSE-ConnectionGUID: za4Q9CWzQqqiJsQnCHPPkw==
X-CSE-MsgGUID: PFdt+9OwT2iVTbHHUznExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63106780"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="63106780"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2025 08:23:10 -0700
X-CSE-ConnectionGUID: 0jZwJOylQQGcWT6vZDaebA==
X-CSE-MsgGUID: 64cRYXy3RGCaET3kOtP7AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="190607057"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 31 Oct 2025 08:23:09 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/2] net/iavf: fix AVX-512 double VLAN (QinQ) insertion
Date: Fri, 31 Oct 2025 15:22:49 +0000
Message-Id: <20251031152250.2441980-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031152250.2441980-1-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
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

QinQ insertion was enabled in the bulk transmit function but not the
single packet transmit function. Implement it in the single packet
function.

Also, fix an issue that would arise in the event an mbuf had both the
VLAN and QINQ offload flags set. In this case the L2TAG2 field would be
written to twice and could cause the tag to be corrupted. Reorder the
logic of populating the L2TAG2 field and ensure that the field is only
written to once.

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 50 ++++++++++---------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 10 ++--
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index d40a858413..c800ae29e1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2077,7 +2077,13 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
 	if (((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) || offload)) {
 		if (offload)
 			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
-		if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) ||
+		if (pkt->ol_flags & RTE_MBUF_F_TX_QINQ) {
+			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+				(uint64_t)pkt->vlan_tci_outer :
+				(uint64_t)pkt->vlan_tci;
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+		} else if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) &&
 				(vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)) {
 			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
@@ -2127,17 +2133,6 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
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
-		}
 		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
@@ -2153,22 +2148,21 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
 							IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
-		}
-		if (IAVF_CHECK_TX_LLDP(pkt[1]))
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
-				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-
-		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
+		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				hi_ctx_qw0 |=
+				hi_ctx_qw1 |=
 					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-				low_ctx_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				low_ctx_qw1 |=
+					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 			} else {
-				hi_data_qw0 |=
-					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
+				hi_data_qw1 |=
+					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
 		}
+		if (IAVF_CHECK_TX_LLDP(pkt[1]))
+			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
+				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
+
 		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
@@ -2184,6 +2178,16 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
 							IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
+		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw0 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |=
+					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			} else {
+				hi_data_qw0 |=
+					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_QW1_L2TAG1_SHIFT;
+			}
 		}
 		if (IAVF_CHECK_TX_LLDP(pkt[0]))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f513777663..bf8faf3632 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -225,12 +225,6 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
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
 		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
@@ -239,6 +233,10 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 		else
 			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
 					IAVF_TXD_QW1_L2TAG1_SHIFT);
+	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
+		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
+		*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
+			    IAVF_TXD_QW1_L2TAG1_SHIFT);
 	}
 #endif
 
-- 
2.34.1

