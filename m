Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A2E6BF04
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB64340A82;
	Fri, 30 Jan 2026 12:42:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B02E14068A
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773359; x=1801309359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ntu4z201tjcwwKTVtOabvDHCDEby+G2YDJpJWKdje8M=;
 b=gzQd/wY40y7rD0HBlxAJhhPSMSkBsJKnI26vH5YRT6mV5t1lUjLDYcnZ
 rMZ1N6bai4XvnWowT2liMO16A91au58N4MVOuCIBLVbebaX2BIbjQbu6i
 bK6Q8Q9m+GcO0C9WR2xLM0248uXqKUH3Sema16KcG5k8HdBHymqM3M4V+
 PyTd7uFmEMGXYc/amR0Q3P8V/IPSzKhL7ktidk1Z8rYVhyzlW+izezbG/
 c9Ctmg45iTOUqGCdM9QvClK3FfL0zUs8TAF5jX26x1dYTHxMwlAXdHoPS
 QH4cfZQs7ck+EeLwpwrecJ3BJGmpqao4XjlKstV9I/Vm1tLFcKWFvVjNa g==;
X-CSE-ConnectionGUID: C6I+UPwrTxaI716ZOmPn9g==
X-CSE-MsgGUID: kD3E3AtXRaOQnkImLy8HAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392310"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:38 -0800
X-CSE-ConnectionGUID: vJ1PCag6Q2SQ0mBE6noYRA==
X-CSE-MsgGUID: wuVxuwdfQVCv/mQsho1nPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190502"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:37 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 15/36] net/intel: support configurable VLAN tag insertion
 on Tx
Date: Fri, 30 Jan 2026 11:41:42 +0000
Message-ID: <20260130114207.1126032-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130114207.1126032-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
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

Make the VLAN tag insertion logic configurable in the common code, as to
where inner/outer tags get placed.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h            | 10 ++++++++++
 drivers/net/intel/common/tx_scalar_fns.h |  9 +++++++--
 drivers/net/intel/i40e/i40e_rxtx.c       |  6 +++---
 drivers/net/intel/ice/ice_rxtx.c         |  5 +++--
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 928fad1df5..faa9bb9559 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -45,6 +45,16 @@
 #define CI_TX_CTX_DESC_TSYN             0x02
 #define CI_TX_CTX_DESC_IL2TAG2          0x04
 
+/**
+ * L2TAG1 Field Source Selection
+ * Specifies which mbuf VLAN field to use for the L2TAG1 field in data descriptors.
+ * Context descriptor VLAN handling (L2TAG2) is managed by driver-specific callbacks.
+ */
+enum ci_tx_l2tag1_field {
+	CI_VLAN_IN_L2TAG1,       /**< For VLAN (not QinQ), use L2Tag1 field in data desc */
+	CI_VLAN_IN_L2TAG2,       /**< For VLAN (not QinQ), use L2Tag2 field in ctx desc */
+};
+
 /* Common TX Descriptor Length Field Shifts */
 #define CI_TX_DESC_LEN_MACLEN_S         0  /* 7 BITS */
 #define CI_TX_DESC_LEN_IPLEN_S          7  /* 7 BITS */
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 2fe503a548..92eed4a476 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -183,6 +183,7 @@ static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
+	     enum ci_tx_l2tag1_field l2tag1_field,
 	     ci_get_ctx_desc_fn get_ctx_desc,
 	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timesstamp_queue_fns *ts_fns)
@@ -284,8 +285,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			}
 		}
 
-		/* Descriptor based VLAN insertion */
-		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+		/* Descriptor based VLAN/QinQ insertion */
+		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
+		 * for qinq offload, we always put inner tag in L2Tag1
+		 */
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
+				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e7dd637931..4e2071c024 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	/* TX context descriptor based double VLAN insert */
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		cd_l2tag2 = tx_pkt->vlan_tci_outer;
-		cd_type_cmd_tso_mss |=
-				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
+		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
 	}
 
 	*qw0 = rte_cpu_to_le_32(cd_tunneling_params) |
@@ -1019,7 +1018,8 @@ uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+			get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index eea83bbae1..79b021a58f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3105,9 +3105,10 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, &ts_fns);
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+				get_context_desc, NULL, &ts_fns);
 
-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

