Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B10C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A035A40A6E;
	Mon, 31 Aug 2026 12:26:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 44B6740682;
 Mon, 31 Aug 2026 12:26:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171996; x=1819707996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HxnZ0fIYIbvOFdbWgCi34BGQKL8zksqnXTFGgwtresw=;
 b=gCNU+0OMzBQYoVwcpKsV0Cl9cX8Cvl2BI/SBs1RVGtLmX+CPlzF6P5Vv
 bLBLKPNBLYhOg0k7gVdQl3xJ199YwUh169g+vMBniiMjO8vcjERh6Ilho
 AoV9X/uQwA/5pD8JGJ+8e6Qja9pJB8K7DQzwoa8c6oyiP+g5QUd0qLV3f
 otx9KBHQTFhLn3cubNnmyZSsE6VSOhghnG1bqZfZgrWwf5EoB6gXUQqNr
 Q1bodhV1dH1rHIvZ9pD/dfIF6iPwbnhxWj/QtAs3pSKZQi1SA1Ro5IBtU
 0vlEPsDunyYpIwHRNGsxfrigmdzUp4nCNQq623hE1nIgZxwXo55tjRvly Q==;
X-CSE-ConnectionGUID: uUQ/Tm6GTCi9MIG6+rtJ4g==
X-CSE-MsgGUID: TXpDZTXfRLiyZfNp/VEN8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452422"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:35 -0700
X-CSE-ConnectionGUID: ve90gieTSF6cSh9241uZtg==
X-CSE-MsgGUID: P2bq3ECRR36dl/RGkStFdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424153"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH 4/7] net/intel: fix unclear enum names
Date: Mon, 31 Aug 2026 11:26:17 +0100
Message-ID: <20260831102621.495759-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

The enum for VLAN tag placement was badly named, and it's purpose as
described in the comments was unclear. Update the names to be clearer,
and more general for future uses and remove the incorrect comments.

Fixes: 6ea6d67bebfe ("net/intel: support configurable VLAN insertion on Tx")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h             | 14 ++++++--------
 drivers/net/intel/common/tx_scalar.h      |  6 +++---
 drivers/net/intel/i40e/i40e_rxtx.c        |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c        |  2 +-
 drivers/net/intel/ice/ice_rxtx.c          |  5 +++--
 drivers/net/intel/idpf/idpf_common_rxtx.c |  2 +-
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 55757d34d7..2d4a8b5d3c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -46,20 +46,18 @@
 #define CI_TX_CTX_DESC_IL2TAG2          0x04

 /**
- * L2TAG1 Field Source Selection
- * Specifies which mbuf VLAN field to use for the L2TAG1 field in data descriptors.
- * Context descriptor VLAN handling (L2TAG2) is managed by driver-specific callbacks.
+ * Enum to specify where a VLAN tag is to be placed for packet Tx.
  */
-enum ci_tx_l2tag1_field {
-	/** For VLAN (not QinQ), use L2Tag1 field in data desc */
-	CI_VLAN_IN_L2TAG1,
+enum ci_l2tag_pos {
+	/** Insert via the data descriptor's L2Tag1 field. */
+	CI_TAG_IN_DATA_DESC,

-	/** For VLAN (not QinQ), use L2Tag2 field in ctx desc.
+	/** Insert via the context descriptor's L2Tag2 field.
 	 * NOTE: When set, drivers must set the VLAN tag in the context
 	 * descriptor callback function, rather than relying on the
 	 * common Tx code to insert it.
 	 */
-	CI_VLAN_IN_L2TAG2,
+	CI_TAG_IN_CTX_DESC,
 };

 /* Common TX Descriptor Length Field Shifts */
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 11ab6c08fc..4df279e729 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -372,7 +372,7 @@ static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
-	     enum ci_tx_l2tag1_field l2tag1_field,
+	     enum ci_l2tag_pos l2tag_pos,
 	     ci_get_ctx_desc_fn get_ctx_desc,
 	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timestamp_queue_fns *ts_fns)
@@ -480,10 +480,10 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		}

 		/* Descriptor based VLAN/QinQ insertion */
-		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
+		/* for single vlan offload, only insert in data desc when CI_TAG_IN_DATA_DESC is set
 		 * for qinq offload, we always put inner tag in L2Tag1
 		 */
-		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag_pos == CI_TAG_IN_DATA_DESC) ||
 				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e29fcff661..ef7041cebd 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1007,7 +1007,7 @@ uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
 			get_context_desc, NULL, NULL);
 }

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 39bcbebf56..1354e2d6d6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2605,7 +2605,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/* IAVF does not support timestamp queues, so pass NULL for ts_fns */
 	return ci_xmit_pkts(txq, tx_pkts, nb_pkts,
 			    (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
-				CI_VLAN_IN_L2TAG1 : CI_VLAN_IN_L2TAG2,
+				CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC,
 			    iavf_get_context_desc, &ipsec_ops, NULL);
 }

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..22d1d5d602 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3125,10 +3125,11 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;

 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
 				get_context_desc, NULL, &ts_fns);

-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
+			get_context_desc, NULL, NULL);
 }

 static int
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 2c87e02c98..128ebb6a88 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1415,7 +1415,7 @@ uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
 			idpf_get_context_desc, NULL, NULL);
 }

--
2.53.0

