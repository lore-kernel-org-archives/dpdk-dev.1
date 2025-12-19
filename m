Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B05D78770
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D23A40B9A;
	Fri, 19 Dec 2025 18:26:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id DAD4F40DCD
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165204; x=1797701204;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RAW53+YbbfMj1UXFmdYU34/hp9+RniLDaWey7+r3O78=;
 b=Row9L4ghaUmXPY2xAL2xvombrAOVXacEKOt839X01VlaUDwhR/msvc43
 GYpm4IEtBLBwz60q5tzFgoCY6Ru2wLDtXNM1B5QkNeF97W5vS/HvOpVf1
 NPpLlBMa4p4mkoGRFLbGjtXcSl/7RrlrznT2ToHONFZdUhwOmvXqF6PMj
 qpW4h926Mmgntf0VgoSbtPuRCOdcX0CE/PPpBAs8EPHLIxKnl+Z/cFQvs
 M2LeHJMxI3cdYTemKDcr1dgQRPvPZdN7dtlfHfQeP+ovTB6ES6hBBAiAq
 zHF4lr6O9s2HH2/2L4BgZe2c6EGrsU6tMvTwKex3OJn39UISQfla0fB09 Q==;
X-CSE-ConnectionGUID: sFW45BMyR8aIbCZjNMHjbQ==
X-CSE-MsgGUID: TzFLfxuWTFyjMCk/bgN/hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759528"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759528"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:44 -0800
X-CSE-ConnectionGUID: r8694EErSPiuJOurCPKzNw==
X-CSE-MsgGUID: UgRRO863RqSspvfaW3//Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170537"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [RFC PATCH 26/27] net/intel: drop unused Tx queue used count
Date: Fri, 19 Dec 2025 17:25:43 +0000
Message-ID: <20251219172548.2660777-27-bruce.richardson@intel.com>
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

Since drivers now track the setting of the RS bit based on fixed
thresholds rather than after a fixed number of descriptors, we no longer
need to track the number of descriptors used from one call to another.
Therefore we can remove the tx_used value in the Tx queue structure.

This value was still being used inside the IDPF splitq scalar code,
however, the ipdf driver-specific section of the Tx queue structure also
had an rs_compl_count value that was only used for the vector code
paths, so we can use it to replace the old tx_used value in the scalar
path.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h                   | 1 -
 drivers/net/intel/common/tx_scalar_fns.h        | 1 -
 drivers/net/intel/i40e/i40e_rxtx.c              | 1 -
 drivers/net/intel/iavf/iavf_rxtx.c              | 1 -
 drivers/net/intel/ice/ice_dcf_ethdev.c          | 1 -
 drivers/net/intel/ice/ice_rxtx.c                | 1 -
 drivers/net/intel/idpf/idpf_common_rxtx.c       | 8 +++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c            | 8 --------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c | 1 -
 9 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 9b3f8385e6..3976766f06 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -130,7 +130,6 @@ struct ci_tx_queue {
 	uint16_t *rs_last_id;
 	uint16_t nb_tx_desc;           /* number of TX descriptors */
 	uint16_t tx_tail; /* current value of tail register */
-	uint16_t nb_tx_used; /* number of TX desc used since RS bit set */
 	/* index to last TX descriptor to have been cleaned */
 	uint16_t last_desc_cleaned;
 	/* Total number of TX descriptors ready to be allocated. */
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 3d0a23eda3..27a5dafefc 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -404,7 +404,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			m_seg = m_seg->next;
 		} while (m_seg);
 end_pkt:
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
 		/* Check if packet crosses into a new RS threshold bucket.
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 1fadd0407a..e1226d649b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2632,7 +2632,6 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
 	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4517d55011..9cac6e8841 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -298,7 +298,6 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = txq->nb_tx_desc - 1;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 4ceecc15c6..02a23629d6 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -414,7 +414,6 @@ reset_tx_queue(struct ci_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = txq->nb_tx_desc - 1;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index a6a454ddf5..092981f452 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1127,7 +1127,6 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 1d123f6350..b36e29c8d2 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -224,7 +224,6 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	/* Use this as next to clean for split desc queue */
 	txq->last_desc_cleaned = 0;
@@ -284,7 +283,6 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 	}
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 
 	txq->last_desc_cleaned = txq->nb_tx_desc - 1;
 	txq->nb_tx_free = txq->nb_tx_desc - 1;
@@ -993,12 +991,12 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
+		txq->rs_compl_count += nb_used;
 
-		if (txq->nb_tx_used >= 32) {
+		if (txq->rs_compl_count >= 32) {
 			txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			/* Update txq RE bit counters */
-			txq->nb_tx_used = 0;
+			txq->rs_compl_count = 0;
 		}
 	}
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 3eeec220fd..6b8ff20f61 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -708,12 +708,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		 */
 		nb_used = (uint16_t)(tx_pkt->nb_segs + new_ctx);
 
-		if (txp != NULL &&
-				nb_used + txq->nb_tx_used >= txq->tx_rs_thresh)
-			/* set RS on the previous packet in the burst */
-			txp->read.cmd_type_len |=
-				rte_cpu_to_le_32(IXGBE_TXD_CMD_RS);
-
 		/*
 		 * The number of descriptors that must be allocated for a
 		 * packet is the number of segments of that packet, plus 1
@@ -912,7 +906,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		 * The last packet data descriptor needs End Of Packet (EOP)
 		 */
 		cmd_type_len |= IXGBE_TXD_CMD_EOP;
-		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
 		/*
@@ -2551,7 +2544,6 @@ ixgbe_reset_tx_queue(struct ci_tx_queue *txq)
 	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 	/*
 	 * Always allow 1 descriptor to be un-allocated to avoid
 	 * a H/W race condition
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index eb7c79eaf9..63c7cb50d3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -47,7 +47,6 @@ ixgbe_reset_tx_queue_vec(struct ci_tx_queue *txq)
 	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
 	txq->tx_tail = 0;
-	txq->nb_tx_used = 0;
 	/*
 	 * Always allow 1 descriptor to be un-allocated to avoid
 	 * a H/W race condition
-- 
2.51.0

