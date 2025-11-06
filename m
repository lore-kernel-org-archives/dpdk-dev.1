Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE027CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85EAA40669;
	Thu,  6 Nov 2025 12:50:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4B23C402D6
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:50:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762429824; x=1793965824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXru0jJJkbQB31G+7gXUOFUJCxYq+VWwaJ8jE+1GK2Q=;
 b=VpTably1UGtYkL4uijbQB72ddkUFig7oSkPCITF/41NIT6PWtPI7nTid
 lSOXGKsJxoGOomSHQda9cxFO936sllZZNobxuB7/mCv6I80QlCS5pwIwi
 S4ulrk1/8RNW+xFzjWJ+27Rp3lkhlOqYMckBpAE9P0Bk7a1qUPXwj+IUV
 kXwoNhLTpVNkydzicy5E3RAUrczALMjJUYExdFeQrzuWCeqNHWFz4PuJB
 4ATt0/F+/MOeAmLBq69hHqewulv8U+CW6PiUlTII5ReCTZsxsn45cN2Rn
 CANXnjaE1TeODF1aGZad+ogC1ANI2dUg84ZWru6XPGbyuBZ87Dtbscmgg Q==;
X-CSE-ConnectionGUID: lV1lx79NS7W79dG/ba8hVA==
X-CSE-MsgGUID: QIpTP0QbQhOfRQ+MRfiOrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52129786"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52129786"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 03:50:23 -0800
X-CSE-ConnectionGUID: AVLOV1yeRN6vks+eB64rKA==
X-CSE-MsgGUID: snDwcPE+Ssuz/XCBbXkK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187898351"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 03:50:22 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 3/6] net/iavf: ensure correct conditions for AVX-512 VLAN
 offload
Date: Thu,  6 Nov 2025 11:50:13 +0000
Message-Id: <20251106115016.3035639-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106115016.3035639-1-ciara.loftus@intel.com>
References: <20251105152642.2981673-1-ciara.loftus@intel.com>
 <20251106115016.3035639-1-ciara.loftus@intel.com>
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

Commit 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")
re-enabled VLAN insertion on the AVX-512 path after it was disabled in
commit efe1b63775e8 ("net/iavf: fix VLAN insertion in vector path"). The
initial implementation introduced in commit 4f8259df563a ("net/iavf:
enable Tx outer checksum offload on AVX512") was inconsistent in that if
the vlan tag was to be placed in the L2TAG1 field, the offload was only
performed if IAVF_TX_VLAN_QINQ_OFFLOAD was defined and if the path was
an offload path. However if the vlan tag was to be placed in the L2TAG2
field (requiring a context descriptor), the insert was performed
unconditionally.

When VLAN insertion was re-enabled, these inconsistencies remained. This
commit fixes these and ensures the following two conditions are met
before VLAN insert is offloaded on the AVX-512 path:
1. IAVF_TX_VLAN_QINQ_OFFLOAD is defined (defined by default)
2. The path is an "offload" path

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 79 +++++++++++--------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 28d83ca3ed..7eb7e47390 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2074,14 +2074,17 @@ ctx_vtx1(volatile struct iavf_tx_desc *txdp, struct rte_mbuf *pkt,
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
 
-	if (((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) || offload)) {
-		if (offload)
-			iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
-		if ((pkt->ol_flags & RTE_MBUF_F_TX_VLAN) ||
-				(vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)) {
-			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw |= (uint64_t)pkt->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+	if (offload) {
+		iavf_fill_ctx_desc_tunneling_avx512(&low_ctx_qw, pkt);
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (pkt->ol_flags & RTE_MBUF_F_TX_VLAN &&
+				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+			high_ctx_qw |= IAVF_TX_CTX_DESC_IL2TAG2 <<
+					IAVF_TXD_CTX_QW1_CMD_SHIFT;
+			low_ctx_qw |= (uint64_t)pkt->vlan_tci <<
+					IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 		}
+#endif
 	}
 	if (IAVF_CHECK_TX_LLDP(pkt))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
@@ -2127,38 +2130,48 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 				((uint64_t)pkt[0]->data_len <<
 					IAVF_TXD_QW1_TX_BUF_SZ_SHIFT);
 
-		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-			hi_ctx_qw1 |=
-				IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw1 |=
-				(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		}
-		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-				(uint64_t)pkt[0]->vlan_tci_outer :
-				(uint64_t)pkt[0]->vlan_tci;
-			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (offload) {
+			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw1 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw1 |=
+					(uint64_t)pkt[1]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
+			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+					(uint64_t)pkt[1]->vlan_tci_outer :
+					(uint64_t)pkt[1]->vlan_tci;
+				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
+						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
 		}
+#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[1]))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
-		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
-				vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-			hi_ctx_qw0 |=
-				IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw0 |=
-				(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-		}
-		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
-			uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-				(uint64_t)pkt[0]->vlan_tci_outer :
-				(uint64_t)pkt[0]->vlan_tci;
-			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
-			low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+		if (offload) {
+			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN &&
+					vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
+				hi_ctx_qw0 |=
+					IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |=
+					(uint64_t)pkt[0]->vlan_tci << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
+			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
+				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
+					(uint64_t)pkt[0]->vlan_tci_outer :
+					(uint64_t)pkt[0]->vlan_tci;
+				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
+						IAVF_TXD_CTX_QW1_CMD_SHIFT;
+				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+			}
 		}
+#endif
 		if (IAVF_CHECK_TX_LLDP(pkt[0]))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
-- 
2.34.1

