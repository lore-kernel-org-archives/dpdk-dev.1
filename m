Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D0CECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9726840EF1;
	Wed, 11 Feb 2026 19:14:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 31DCE40ED8
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833644; x=1802369644;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ptp7FVop15MpD7z4IMYUXjCQcrzedSrEzZ1hjkfLLHA=;
 b=WDC7y4Rs5XMgZc+mM/TmUsKt43MlABXVafxdQIkK5sd2wS+siyKqHgW2
 4M3QgmIK+jD67Q4/S0xNVs9IH+Kg4DVF5M/YxnXNxeExiEfZcP0FzUlo6
 gDl4e3EAp6YQ8YiqL61HJ3A3mWv2uqXkJz2yRPhU4Ia6vX1OdVGTfjIoi
 DMJv0MTeX3ZRIe/tXgF3Y5u6aRYvwVnecoYGDXftKqrbVFY6gcsIjtjhN
 AcWuSXerLc0NQ1Ba7iyf0O5tm/Kd72JoGwq2ddYhlFqdf02x53ipyoIHJ
 UtqdEl8Gh3KVjIxyIUU/QZGr0dZVoJWgPbDtrd2KzOcxCu33vBCOVnz2r Q==;
X-CSE-ConnectionGUID: Is1oKKeGR+2FC4ifgReYtw==
X-CSE-MsgGUID: p+QBrmhPToShLwUE4dT+LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834698"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834698"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:14:04 -0800
X-CSE-ConnectionGUID: 1+Vj+Sc6QCiUjfdO6kVb1A==
X-CSE-MsgGUID: 4LI51huXRnOKEHspRFdwlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986391"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:14:03 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 28/35] net/intel: consolidate ice and i40e buffer free
 function
Date: Wed, 11 Feb 2026 18:12:57 +0000
Message-ID: <20260211181309.2838042-29-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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

The buffer freeing function for the simple scalar Tx path is almost
identical in both ice and i40e drivers, except that the i40e has
batching for the FAST_FREE case. Consolidate both functions into a
common one based off the better i40e version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/common/tx.h        |  3 ++
 drivers/net/intel/common/tx_scalar.h | 58 +++++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c   | 63 +---------------------------
 drivers/net/intel/ice/ice_rxtx.c     | 45 +-------------------
 4 files changed, 65 insertions(+), 104 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index a5cbe070fc..f38e43f65a 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -73,6 +73,9 @@ enum ci_tx_l2tag1_field {
 /* Common TX maximum burst size for chunked transmission in simple paths */
 #define CI_TX_MAX_BURST 32
 
+/* Common TX maximum free buffer size for batched bulk freeing */
+#define CI_TX_MAX_FREE_BUF_SZ 64
+
 /* Common TX descriptor command flags for simple transmit */
 #define CI_TX_DESC_CMD_DEFAULT (CI_TX_DESC_CMD_ICRC | CI_TX_DESC_CMD_EOP)
 
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 3c9c1f611c..a85be8bbb7 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -72,6 +72,64 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	}
 }
 
+/* Free transmitted mbufs from descriptor ring with bulk freeing for Tx simple path */
+static __rte_always_inline int
+ci_tx_free_bufs(struct ci_tx_queue *txq)
+{
+	const uint16_t rs_thresh = txq->tx_rs_thresh;
+	const uint16_t k = RTE_ALIGN_FLOOR(rs_thresh, CI_TX_MAX_FREE_BUF_SZ);
+	const uint16_t m = rs_thresh % CI_TX_MAX_FREE_BUF_SZ;
+	struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
+	struct ci_tx_entry *txep;
+
+	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
+		return 0;
+
+	txep = &txq->sw_ring[txq->tx_next_dd - (rs_thresh - 1)];
+
+	struct rte_mempool *fast_free_mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+				txq->fast_free_mp :
+				(txq->fast_free_mp = txep[0].mbuf->pool);
+
+	if (fast_free_mp) {
+		if (k) {
+			for (uint16_t j = 0; j != k; j += CI_TX_MAX_FREE_BUF_SZ) {
+				for (uint16_t i = 0; i < CI_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
+					free[i] = txep->mbuf;
+					txep->mbuf = NULL;
+				}
+				rte_mbuf_raw_free_bulk(fast_free_mp, free, CI_TX_MAX_FREE_BUF_SZ);
+			}
+		}
+
+		if (m) {
+			for (uint16_t i = 0; i < m; ++i, ++txep) {
+				free[i] = txep->mbuf;
+				txep->mbuf = NULL;
+			}
+			rte_mbuf_raw_free_bulk(fast_free_mp, free, m);
+		}
+	} else {
+		for (uint16_t i = 0; i < rs_thresh; ++i, ++txep)
+			rte_prefetch0((txep + i)->mbuf);
+
+		for (uint16_t i = 0; i < rs_thresh; ++i, ++txep) {
+			rte_pktmbuf_free_seg(txep->mbuf);
+			txep->mbuf = NULL;
+		}
+	}
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(rs_thresh - 1);
+
+	return rs_thresh;
+}
+
 /*
  * Common transmit descriptor cleanup function for Intel drivers.
  *
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 174d517e9d..6b8d9fd70e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1010,65 +1010,6 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			get_context_desc, NULL, NULL);
 }
 
-static __rte_always_inline int
-i40e_tx_free_bufs(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *txep;
-	const uint16_t tx_rs_thresh = txq->tx_rs_thresh;
-	uint16_t i, j;
-	struct rte_mbuf *free[I40E_TX_MAX_FREE_BUF_SZ];
-	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, I40E_TX_MAX_FREE_BUF_SZ);
-	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
-
-	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
-
-	struct rte_mempool *fast_free_mp =
-			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
-			txq->fast_free_mp :
-			(txq->fast_free_mp = txep[0].mbuf->pool);
-
-	if (fast_free_mp != NULL) {
-		if (k) {
-			for (j = 0; j != k; j += I40E_TX_MAX_FREE_BUF_SZ) {
-				for (i = 0; i < I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
-					free[i] = txep->mbuf;
-					txep->mbuf = NULL;
-				}
-				rte_mbuf_raw_free_bulk(fast_free_mp, free,
-						I40E_TX_MAX_FREE_BUF_SZ);
-			}
-		}
-
-		if (m) {
-			for (i = 0; i < m; ++i, ++txep) {
-				free[i] = txep->mbuf;
-				txep->mbuf = NULL;
-			}
-			rte_mbuf_raw_free_bulk(fast_free_mp, free, m);
-		}
-	} else {
-		for (i = 0; i < tx_rs_thresh; i++)
-			rte_prefetch0((txep + i)->mbuf);
-
-		for (i = 0; i < tx_rs_thresh; ++i, ++txep) {
-			rte_pktmbuf_free_seg(txep->mbuf);
-			txep->mbuf = NULL;
-		}
-	}
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(tx_rs_thresh - 1);
-
-	return tx_rs_thresh;
-}
-
 static inline uint16_t
 tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -1083,7 +1024,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		i40e_tx_free_bufs(txq);
+		ci_tx_free_bufs(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
@@ -2508,7 +2449,7 @@ i40e_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = i40e_tx_free_bufs(txq);
+		n = ci_tx_free_bufs(txq);
 
 		if (n == 0)
 			break;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index e4fba453a9..a3a94033bf 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3129,47 +3129,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
 }
 
-static __rte_always_inline int
-ice_tx_free_bufs(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *txep;
-	uint16_t i;
-
-	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-	     rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-	    rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	txep = &txq->sw_ring[txq->tx_next_dd - (txq->tx_rs_thresh - 1)];
-
-	struct rte_mempool *fast_free_mp =
-			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
-			txq->fast_free_mp :
-			(txq->fast_free_mp = txep[0].mbuf->pool);
-
-	if (fast_free_mp != NULL) {
-		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
-			rte_mempool_put(fast_free_mp, txep->mbuf);
-			txep->mbuf = NULL;
-		}
-	} else {
-		for (i = 0; i < txq->tx_rs_thresh; i++)
-			rte_prefetch0((txep + i)->mbuf);
-
-		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
-			rte_pktmbuf_free_seg(txep->mbuf);
-			txep->mbuf = NULL;
-		}
-	}
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	return txq->tx_rs_thresh;
-}
-
 static int
 ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			uint32_t free_cnt)
@@ -3259,7 +3218,7 @@ ice_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ice_tx_free_bufs(txq);
+		n = ci_tx_free_bufs(txq);
 
 		if (n == 0)
 			break;
@@ -3300,7 +3259,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ice_tx_free_bufs(txq);
+		ci_tx_free_bufs(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-- 
2.51.0

