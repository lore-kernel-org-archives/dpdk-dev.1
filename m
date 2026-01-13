Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9231D2F32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8BAE40E3A;
	Tue, 13 Jan 2026 16:15:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E8CDB40E03
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317352; x=1799853352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nknH1AZiGVTkX5XTk9B6Y9TtCSW0j+ZHLsVeufThOU0=;
 b=oKvwR7ZMjF+SOEmBMUlU8py07rIEaPNMG65znjm/iIeXyshIS7v0V//G
 Sk281QUv+WL4HKzhU5aXKhwpLfp/FPGHD7kKKwOGrdt9lOgRxhyejSRBB
 0As9wQUuou48vKjzo2cChpNGhWTpaOd3XYfvRpmVKhS5He4bm7xF8zE3V
 ktHiLR8OImcjIoDIEHRdKbYsH6/PjuA1xjRXtyz/Zb8UE88/FZXQBtVsL
 0NCK7L/wATBByLnoNb+0YoxGIdDbLmugauRXHdoFATtspYhMmWIQCxbBv
 aYHWFd6FcLIii4Qpkjjh/R0bw5r6uDE+cC9fy0A8tifGGlkZsnFKS1Nv6 A==;
X-CSE-ConnectionGUID: D0zVrmAbSmeVOjvdybIS5w==
X-CSE-MsgGUID: P4F+z0ZtQZSAl9s2Or2Qjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969228"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969228"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:52 -0800
X-CSE-ConnectionGUID: b7LwSfkwTKufOQYZwl9/4Q==
X-CSE-MsgGUID: sIQPuWGuREKEFmhtxmxt7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556663"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:51 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 30/36] net/intel: consolidate ice and i40e buffer free
 function
Date: Tue, 13 Jan 2026 15:14:54 +0000
Message-ID: <20260113151505.1871271-31-bruce.richardson@intel.com>
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

The buffer freeing function for the simple scalar Tx path is almost
identical in both ice and i40e drivers, except that the i40e has
batching for the FAST_FREE case. Consolidate both functions into a
common one based off the better i40e version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h            |  3 ++
 drivers/net/intel/common/tx_scalar_fns.h | 55 ++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c       | 58 +-----------------------
 drivers/net/intel/ice/ice_rxtx.c         | 40 +---------------
 4 files changed, 62 insertions(+), 94 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 502b3f2032..753e3a2e9e 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -66,6 +66,9 @@ enum ci_tx_l2tag1_field {
 /* Common TX maximum burst size for chunked transmission in simple paths */
 #define CI_TX_MAX_BURST 32
 
+/* Common TX maximum free buffer size for batched bulk freeing */
+#define CI_TX_MAX_FREE_BUF_SZ 64
+
 /* Common TX descriptor command flags for simple transmit */
 #define CI_TX_DESC_CMD_DEFAULT (CI_TX_DESC_CMD_ICRC | CI_TX_DESC_CMD_EOP)
 
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 0d64a63e16..d472aa24e0 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -72,6 +72,61 @@ ci_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
 	}
 }
 
+/* Free transmitted mbufs from descriptor ring with bulk freeing for Tx simple path */
+static __rte_always_inline int
+ci_tx_free_bufs(struct ci_tx_queue *txq)
+{
+	struct ci_tx_entry *txep;
+	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
+	uint16_t i = 0, j = 0;
+	struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
+	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, CI_TX_MAX_FREE_BUF_SZ);
+	const uint16_t m = tx_rs_thresh % CI_TX_MAX_FREE_BUF_SZ;
+
+	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
+			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
+		return 0;
+
+	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
+
+	for (i = 0; i < tx_rs_thresh; i++)
+		rte_prefetch0((txep + i)->mbuf);
+
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		if (k) {
+			for (j = 0; j != k; j += CI_TX_MAX_FREE_BUF_SZ) {
+				for (i = 0; i < CI_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
+					free[i] = txep->mbuf;
+					txep->mbuf = NULL;
+				}
+				rte_mbuf_raw_free_bulk(free[0]->pool, free,
+						CI_TX_MAX_FREE_BUF_SZ);
+			}
+		}
+
+		if (m) {
+			for (i = 0; i < m; ++i, ++txep) {
+				free[i] = txep->mbuf;
+				txep->mbuf = NULL;
+			}
+			rte_mbuf_raw_free_bulk(free[0]->pool, free, m);
+		}
+	} else {
+		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
+			rte_pktmbuf_free_seg(txep->mbuf);
+			txep->mbuf = NULL;
+		}
+	}
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+
+	return txq->tx_rs_thresh;
+}
+
 /*
  * Common transmit descriptor cleanup function for Intel drivers.
  * Used by ice, i40e, iavf, and idpf drivers.
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index cb91eeeab2..22728af980 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1012,60 +1012,6 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			get_context_desc, NULL, NULL);
 }
 
-static __rte_always_inline int
-i40e_tx_free_bufs(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *txep;
-	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
-	uint16_t i = 0, j = 0;
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
-	for (i = 0; i < tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
-
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
-		if (k) {
-			for (j = 0; j != k; j += I40E_TX_MAX_FREE_BUF_SZ) {
-				for (i = 0; i < I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
-					free[i] = txep->mbuf;
-					txep->mbuf = NULL;
-				}
-				rte_mbuf_raw_free_bulk(free[0]->pool, free,
-						I40E_TX_MAX_FREE_BUF_SZ);
-			}
-		}
-
-		if (m) {
-			for (i = 0; i < m; ++i, ++txep) {
-				free[i] = txep->mbuf;
-				txep->mbuf = NULL;
-			}
-			rte_mbuf_raw_free_bulk(free[0]->pool, free, m);
-		}
-	} else {
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
 static inline uint16_t
 tx_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
@@ -1080,7 +1026,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		i40e_tx_free_bufs(txq);
+		ci_tx_free_bufs(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
@@ -2493,7 +2439,7 @@ i40e_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = i40e_tx_free_bufs(txq);
+		n = ci_tx_free_bufs(txq);
 
 		if (n == 0)
 			break;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 5e4391f120..468c039ab1 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3119,42 +3119,6 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
-	for (i = 0; i < txq->tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
-
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
-		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
-			rte_mempool_put(txep->mbuf->pool, txep->mbuf);
-			txep->mbuf = NULL;
-		}
-	} else {
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
@@ -3244,7 +3208,7 @@ ice_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ice_tx_free_bufs(txq);
+		n = ci_tx_free_bufs(txq);
 
 		if (n == 0)
 			break;
@@ -3285,7 +3249,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ice_tx_free_bufs(txq);
+		ci_tx_free_bufs(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-- 
2.51.0

