Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A6E66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2833E406BA;
	Fri, 19 Dec 2025 18:26:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id CFFB840697
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165190; x=1797701190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xm7Waje1pW1Q9p+/InOfGxq5CJeYnlIs3ZKPDPUCKSg=;
 b=BqqKMcNYrB67V/qFN0qBa32iC2ZRQ+kdwnJflRZL3qyPFa3Ys80VCIm2
 MxZlJpUGzHmowpFiyEuREEiFfFRyPpYsjyL6tUF69MQtpWdTJuRoHGITI
 SXQBxwCA9Bg8djNGn0wuivscWcO8gFN0An64oUDE3E5SjrWmeASXG5EKI
 PAE/+nNmfhg5piGnU0fNa0ZynMdksigik+wykCptmGA0g+1tvrWxrhUFC
 KpJrG5X0crTN3YuEKbcgXURLfkndQlSwVBZvqi4v8EDmXK+XOQdjWrEtF
 QNWaUZE97QWDlduTcK3ghQcBH2dAPB+xjJgr0Hm/j8uD4kLjG9oT6FLHc g==;
X-CSE-ConnectionGUID: Npu3btLYS+OdBwsCGMvmEg==
X-CSE-MsgGUID: uXpP1bk3RJeOfn9IYrS2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759498"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:30 -0800
X-CSE-ConnectionGUID: 30Ngz9smQSiW3rrOrxTO4A==
X-CSE-MsgGUID: cFi6YMSZQZq8GHbppSO9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170467"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:28 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC PATCH 15/27] net/intel: support configurable VLAN tag insertion
 on Tx
Date: Fri, 19 Dec 2025 17:25:32 +0000
Message-ID: <20251219172548.2660777-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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
 drivers/net/intel/i40e/i40e_rxtx.c       |  4 ++--
 drivers/net/intel/ice/ice_rxtx.c         |  4 ++--
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index a71b98f119..0d11daaab3 100644
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
index 8c0de26537..6079a558e4 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -188,6 +188,7 @@ static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
+	     enum ci_tx_l2tag1_field l2tag1_field,
 	     ci_get_ctx_desc_fn get_ctx_desc,
 	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timesstamp_queue_fns *ts_fns)
@@ -286,8 +287,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			}
 		}
 
-		/* Descriptor based VLAN insertion */
-		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+		/* Descriptor based VLAN/QinQ insertion */
+		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
+		 * for qinq offload, we always put inner tag in L2Tag1
+		 */
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && (l2tag1_field == CI_VLAN_IN_L2TAG1)) ||
+				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e22fcfff60..2d12e6dd1a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1002,7 +1002,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	/* TX context descriptor based double VLAN insert */
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		cd_l2tag2 = tx_pkt->vlan_tci_outer;
-		cd_type_cmd_tso_mss |= ((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
+		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
 	}
 
 	*qw0 = rte_cpu_to_le_32(cd_tunneling_params) |
@@ -1016,7 +1016,7 @@ uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 49ed6b8399..2c73011181 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3100,9 +3100,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, &ts_fns);
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, &ts_fns);
 
-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

