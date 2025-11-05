Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57139CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B217B40B9C;
	Wed,  5 Nov 2025 16:26:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3604E40A7F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:26:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356417; x=1793892417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iXru0jJJkbQB31G+7gXUOFUJCxYq+VWwaJ8jE+1GK2Q=;
 b=gRMHrCAKSM87526Rtidn4WvxJ0wFVj7qFRq17oNYmG+a81l54QJ2thTd
 aEJ6om49RsnWNnaBWsV9KqmzgrnhnBtdPbAIgYmWPPtAdPBi9CIXTu/Vv
 u+m9C+D4U/HyEu8PzbzYDRSWWuVHo1g7/P28AzHnnHmIuWQPiCOVGzFo6
 RVFH/XFlDDkEqJ7cPiuBgsUVKmgSaBiRiDEk5xqycFikhzkqT+8ujfZNx
 olhcge5P+XHToaEftwLgXrhGNS1d7+Z1PhgTeykE5fy7kJMGC7UlReWgt
 +skugAld9p+eUEMUm/Ty4GjvvpoIekFX1RO1KlG8SSHuDtk7ZItDlfzuL A==;
X-CSE-ConnectionGUID: /S6ysaULSO+MbtZQDDzmaQ==
X-CSE-MsgGUID: i1uZbu6tQRKJNkEqiY0v8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127085"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127085"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:57 -0800
X-CSE-ConnectionGUID: 9c+nG/W1TYSDDBpsXqyFzg==
X-CSE-MsgGUID: esTOMddgTRmUfioubAWNGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257311"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:56 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 3/6] net/iavf: ensure correct conditions for AVX-512 VLAN
 offload
Date: Wed,  5 Nov 2025 15:26:39 +0000
Message-Id: <20251105152642.2981673-4-ciara.loftus@intel.com>
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

