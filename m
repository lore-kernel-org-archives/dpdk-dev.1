Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964F6CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45EBA4065D;
	Fri, 31 Oct 2025 16:23:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id F0F7940150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 16:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761924192; x=1793460192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DCPn27n74BgY4Uj+WOF+ocVkxz1AohBoeyYYK/j+1k4=;
 b=CPJsDjlfYcXNSiqzmaR+2MVTs5jccSdyMfxNLOEqrEaT1Yl4x/6yZ/Vo
 Y9cbHJVh+gFjtPmf5VBWLa6HoTVHxnHCtdQbsy+9t7QL9I6o5VGdI8crW
 zRifjJ5SyEOD380CqNNWHLfxbNoTbwzIdPb/NaIXO4ahaukoBs+7SiVhJ
 +iuwZepi9Qwzxop5XY0T65yA3oG4uQyXXYnYS9a0sqIfUyeWtKVUEeXQx
 8K6jla/8X8bD2uabIelaDw5p3WgIA4CQFQ5IJoplBEwCNYIYXEXveI5Dz
 hV3hGb7o+nR0+c978shXqNPDjt78llG5+Rx0shS6BbYUTzBNSiC1JU4AX Q==;
X-CSE-ConnectionGUID: hYFTTUY9RtyWZUUeCu/tIQ==
X-CSE-MsgGUID: DltfT0LwT3Cj1Wehwby3mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63106783"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="63106783"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2025 08:23:11 -0700
X-CSE-ConnectionGUID: nmTr8+mRQJGrStEr9QCvnw==
X-CSE-MsgGUID: 7C0jVgtKQz6yzGeVHlXaog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="190607062"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 31 Oct 2025 08:23:10 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/2] net/iavf: fix single VLAN insertion positioning
Date: Fri, 31 Oct 2025 15:22:50 +0000
Message-Id: <20251031152250.2441980-3-ciara.loftus@intel.com>
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

Commit fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar
Tx") broke single VLAN insertion offload in cases where the v2 offload
capability and both inner and outer insertion were supported because it
caused inner VLAN tags to be inserted instead of outer.

When an iavf tx queue is being set up, if v2 offload capability is
supported, the driver queries the insertion capabilities and takes note
of where VLAN tags should be placed in the transmit and/or context
descriptors for insertion offload. In the offending commit, when both
inner and outer insertion was reported as supported, the flag
"vlan_flag" was changed to hold the location for inner VLAN tags.
However this caused inner VLAN tags to be inserted in the case of single
VLAN offload which is incorrect behaviour for this use case.

To fix this, revert the "vlan_flag" back to holding the location for
outer VLAN tags and update the datapath code accordingly.

Fixes: fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c            | 50 +++++++------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 24 ++++-----
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  5 +-
 3 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a3ef13c791..66f718424a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -799,32 +799,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			&adapter->vf.vlan_v2_caps.offloads.insertion_support;
 		uint32_t insertion_cap;
 
-		if (insertion_support->outer == VIRTCHNL_VLAN_UNSUPPORTED ||
-				insertion_support->inner == VIRTCHNL_VLAN_UNSUPPORTED) {
-			/* Only one insertion is supported. */
-			if (insertion_support->outer)
-				insertion_cap = insertion_support->outer;
-			else
-				insertion_cap = insertion_support->inner;
-
-			if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
-				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
-				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
-			} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
-				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
-				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
-			}
-		} else {
-			 /* Both outer and inner insertion supported. */
-			if (insertion_support->inner & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
-				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
-				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG1");
-				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG2");
-			} else {
-				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
-				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG2");
-				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG1");
-			}
+		if (insertion_support->outer)
+			insertion_cap = insertion_support->outer;
+		else
+			insertion_cap = insertion_support->inner;
+
+		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
+			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
+			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
+		} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
+			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
+			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
 		}
 	} else {
 		txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
@@ -2600,12 +2585,11 @@ iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
 	desc_qws->qw0 = rte_cpu_to_le_64(desc_qws->qw0);
 	desc_qws->qw1 = rte_cpu_to_le_64(desc_qws->qw1);
 
+	/* vlan_flag specifies VLAN tag location for VLAN, and outer tag location for QinQ. */
 	if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
+		desc->l2tag2 = m->ol_flags & RTE_MBUF_F_TX_QINQ ? m->vlan_tci_outer : m->vlan_tci;
+	else if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
 		desc->l2tag2 = m->vlan_tci;
-
-	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
-		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci :
-										m->vlan_tci_outer;
 }
 
 
@@ -2660,11 +2644,11 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
 		l2tag1 |= m->vlan_tci;
 	}
 
-	/* Descriptor based QinQ insertion */
+	/* Descriptor based QinQ insertion. vlan_flag specifies outer tag location. */
 	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
 		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
-		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci :
-									m->vlan_tci_outer;
+		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci_outer :
+									m->vlan_tci;
 	}
 
 	if ((m->ol_flags &
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index c800ae29e1..6f150cb1c1 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2136,17 +2136,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
-				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			} else {
 				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
 				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
 							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
 							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			} else {
+				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
+				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
 		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
@@ -2166,17 +2166,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
-				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
-				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
-							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
-				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
-							IAVF_TXD_QW1_L2TAG1_SHIFT;
-			} else {
 				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
 				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
 							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
 				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
 							IAVF_TXD_QW1_L2TAG1_SHIFT;
+			} else {
+				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
+				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
+							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
+				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
+							IAVF_TXD_QW1_L2TAG1_SHIFT;
 			}
 		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index bf8faf3632..86523a7d2b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -227,11 +227,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
+		/* vlan_flag specifies outer tag location for QinQ. */
 		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
 					IAVF_TXD_QW1_L2TAG1_SHIFT);
 		else
-			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
+			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
 					IAVF_TXD_QW1_L2TAG1_SHIFT);
 	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
 		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
-- 
2.34.1

