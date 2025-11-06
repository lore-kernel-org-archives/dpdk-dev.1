Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE9CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 11:50:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EFAA40676;
	Thu,  6 Nov 2025 12:50:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 402D5402D6
 for <dev@dpdk.org>; Thu,  6 Nov 2025 12:50:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762429825; x=1793965825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oTWcGwu2VC1KkmF6BY+0/KaIARYZS9LH0C6OszsSxH4=;
 b=aLpw3wKiWjTwEn80CWgH8RAn9aB+kW/BY3BBOpFjShbk9Dk6SpKMQRu3
 RW2hort3MUAhik+9pVlnyraKmDvm/87qRQMgjakR6436IPYRrvyjcZLaA
 UU3W6GT5rCcwH7u54t0TqkHxq8mI2MwovEmtXwJhBiosy5bZphdJMkAWf
 oGXYspo58I7Rb7dAMLtD6u8K34sPX4545659xCPa4JUDpIk7mlfFBC/oc
 pwKLKiMY7XJyqcVR21m0/29SZ9f3i72D0Zu3CosSFTonxOCss2d1SyU74
 NlKgc5cvBhFF3n9DRznevjWBpT5VSoIZPtUwkJBGQRpgb1zHMGSQAXh9T w==;
X-CSE-ConnectionGUID: +/G+rKVlT82x6AyQTqCTNQ==
X-CSE-MsgGUID: GqZJiUTZTauNpVGIlmJhOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52129787"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="52129787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 03:50:24 -0800
X-CSE-ConnectionGUID: sgNRwKv7RHSR6S1dQkXo1g==
X-CSE-MsgGUID: oh/algcEQzqZkS1nl2Ct7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187898357"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2025 03:50:23 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 4/6] net/iavf: fix single VLAN insertion positioning
Date: Thu,  6 Nov 2025 11:50:14 +0000
Message-Id: <20251106115016.3035639-5-ciara.loftus@intel.com>
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
 drivers/net/intel/iavf/iavf_rxtx.c            | 53 +++++++------------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  8 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  5 +-
 3 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index a3ef13c791..ea49059f83 100644
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
@@ -2600,12 +2585,12 @@ iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
 	desc_qws->qw0 = rte_cpu_to_le_64(desc_qws->qw0);
 	desc_qws->qw1 = rte_cpu_to_le_64(desc_qws->qw1);
 
-	if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
-		desc->l2tag2 = m->vlan_tci;
-
+	/* vlan_flag specifies VLAN tag location for VLAN, and outer tag location for QinQ. */
 	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
-		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci :
-										m->vlan_tci_outer;
+		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci_outer :
+						m->vlan_tci;
+	else if (m->ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
+		desc->l2tag2 = m->vlan_tci;
 }
 
 
@@ -2660,11 +2645,11 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
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
index 7eb7e47390..6182988612 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2141,8 +2141,8 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 			}
 			if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-					(uint64_t)pkt[1]->vlan_tci_outer :
-					(uint64_t)pkt[1]->vlan_tci;
+					(uint64_t)pkt[1]->vlan_tci :
+					(uint64_t)pkt[1]->vlan_tci_outer;
 				hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw1 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
@@ -2164,8 +2164,8 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
 			}
 			if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
 				uint64_t qinq_tag = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ?
-					(uint64_t)pkt[0]->vlan_tci_outer :
-					(uint64_t)pkt[0]->vlan_tci;
+					(uint64_t)pkt[0]->vlan_tci :
+					(uint64_t)pkt[0]->vlan_tci_outer;
 				hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 <<
 						IAVF_TXD_CTX_QW1_CMD_SHIFT;
 				low_ctx_qw0 |= qinq_tag << IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index 7bf9dfd372..226d8c9eda 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -235,11 +235,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
 
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
 	}
 #endif
-- 
2.34.1

