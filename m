Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D06D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45A7740B97;
	Tue, 13 Jan 2026 16:15:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2479640A77
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317334; x=1799853334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2xWRcDOpI5OMeSAS7US2m/1ThceQSsilC7fZRgl8NWA=;
 b=TG7MFzbQ4t4tJHF09KQjJjzvyaPtqIjEIHQMqc1HJXpbcEhnItFNwzdR
 80TjbTcD9GfdXn4houXc1Xqtk8cre3kKIf7oBYchQEtvQ9KiGFrCFAuZc
 rIDbgV6D/ngc84yF+lb8WHjA5ElbqlVJDkFamvhaQwPmD7yrwoF8hJjtN
 WaAz+XHA2LYJf73mBxV7kvIyaJA/hyyqd/31vUuaYiX+8WFn4vtciVQB4
 ZUq0D5ChHCFQjXouuq25fT4GOKO0W+5wWjTMV3DIQNV0bhtMISb+IXYNP
 3qcwp8eTyChobUpj4NL/VGfNOp7ARn33MlH9TRqFW352nxztTR6TGW9Jo w==;
X-CSE-ConnectionGUID: 3cHwqrFaQZGyHRWVO/Y5xA==
X-CSE-MsgGUID: lOz/3y1sSnyXIfMAy99Cog==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969185"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:34 -0800
X-CSE-ConnectionGUID: o4Mb3/cgS7GfeK5PtrSaCA==
X-CSE-MsgGUID: 5N9dEiMNSxOO0b7pr+ecwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556602"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 15/36] net/intel: support configurable VLAN tag insertion
 on Tx
Date: Tue, 13 Jan 2026 15:14:39 +0000
Message-ID: <20260113151505.1871271-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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
index 8c0de26537..0dfe2060c0 100644
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
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
+				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 6f3b22db02..f0047e4f59 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1006,8 +1006,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	/* TX context descriptor based double VLAN insert */
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		cd_l2tag2 = tx_pkt->vlan_tci_outer;
-		cd_type_cmd_tso_mss |=
-				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
+		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
 	}
 
 	*qw0 = rte_cpu_to_le_32(cd_tunneling_params) |
@@ -1021,7 +1020,8 @@ uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+			get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 760a994165..c67d6223b3 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3095,9 +3095,10 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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

