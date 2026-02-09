Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00396E81BDF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F193440DFB;
	Mon,  9 Feb 2026 17:46:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 02B1640E37
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:46:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655581; x=1802191581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SzCM4/7cOPYZrVcYzV/slNjqhU8ZwM8b7HBMlsq3Mo0=;
 b=l4l8/kkCFBv7oK49FMmpg0u3vazz6udg5PvnnFdsBXMtsk26eH9UdeSy
 2wX5dRnADJ1PQEas9Kdl2qEiVLKQUK9DgqpNBWDkNOvbaSiFcKX+QT2+j
 dvuzS7Us7QmLxPWrGQ+yfz3LeGTBWyFT36/wzy3tjhDhcjLdH9kZOrGSm
 O8+P7cOYpB+DkEO+IPkf8FNY/dEfenzklD/jS3g8tyv9iP2qIA7bXVbfV
 RpFLZ8ZxP8X+ia49fCNbqYvMXEDrUPgxabJ4td7/3xYJ2Q3dYB6RDUaEL
 rXSmOoZ1UqnvFSGxFpxHBN7yhUHrLvDEBTo5eTWh1Zqln/CX67jfwR8JH Q==;
X-CSE-ConnectionGUID: 3cE+Ei7XR0eSTNM4bC3gRw==
X-CSE-MsgGUID: 0sBtzA3LQdS8vtMY6Dn8CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663525"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:46:21 -0800
X-CSE-ConnectionGUID: kTCx/8h+RIqfm6HJ1t9udQ==
X-CSE-MsgGUID: 5loUhqhATAq0eWl1f1jrRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789243"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:46:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 34/35] net/intel: use vector mbuf cleanup from simple
 scalar path
Date: Mon,  9 Feb 2026 16:45:32 +0000
Message-ID: <20260209164538.1428499-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209164538.1428499-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
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

Since the simple scalar path now uses the vector Tx entry struct, we can
leverage the vector mbuf cleanup function from that path and avoid
having a separate cleanup function for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h | 74 ++++++----------------------
 drivers/net/intel/i40e/i40e_rxtx.c   |  2 +-
 drivers/net/intel/ice/ice_rxtx.c     |  2 +-
 3 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 02c60cdaff..b6297437aa 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -21,6 +21,20 @@ write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
 	txd_qw[1] = rte_cpu_to_le_64(qw1);
 }
 
+static __rte_always_inline int
+ci_tx_desc_done_simple(struct ci_tx_queue *txq, uint16_t idx)
+{
+	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) ==
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE);
+}
+
+/* Free transmitted mbufs using vector-style cleanup */
+static __rte_always_inline int
+ci_tx_free_bufs_simple(struct ci_tx_queue *txq)
+{
+	return ci_tx_free_bufs_vec(txq, ci_tx_desc_done_simple, false);
+}
+
 /* Fill hardware descriptor ring with mbuf data (simple path) */
 static inline void
 ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkts,
@@ -52,64 +66,6 @@ ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pk
 	}
 }
 
-/* Free transmitted mbufs from descriptor ring with bulk freeing for Tx simple path */
-static __rte_always_inline int
-ci_tx_free_bufs(struct ci_tx_queue *txq)
-{
-	const uint16_t rs_thresh = txq->tx_rs_thresh;
-	const uint16_t k = RTE_ALIGN_FLOOR(rs_thresh, CI_TX_MAX_FREE_BUF_SZ);
-	const uint16_t m = rs_thresh % CI_TX_MAX_FREE_BUF_SZ;
-	struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
-	struct ci_tx_entry_vec *txep;
-
-	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	txep = &txq->sw_ring_vec[txq->tx_next_dd - (rs_thresh - 1)];
-
-	struct rte_mempool *fast_free_mp =
-			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
-				txq->fast_free_mp :
-				(txq->fast_free_mp = txep[0].mbuf->pool);
-
-	if (fast_free_mp) {
-		if (k) {
-			for (uint16_t j = 0; j != k; j += CI_TX_MAX_FREE_BUF_SZ) {
-				for (uint16_t i = 0; i < CI_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
-					free[i] = txep->mbuf;
-					txep->mbuf = NULL;
-				}
-				rte_mbuf_raw_free_bulk(fast_free_mp, free, CI_TX_MAX_FREE_BUF_SZ);
-			}
-		}
-
-		if (m) {
-			for (uint16_t i = 0; i < m; ++i, ++txep) {
-				free[i] = txep->mbuf;
-				txep->mbuf = NULL;
-			}
-			rte_mbuf_raw_free_bulk(fast_free_mp, free, m);
-		}
-	} else {
-		for (uint16_t i = 0; i < rs_thresh; ++i, ++txep)
-			rte_prefetch0((txep + i)->mbuf);
-
-		for (uint16_t i = 0; i < rs_thresh; ++i, ++txep) {
-			rte_pktmbuf_free_seg(txep->mbuf);
-			txep->mbuf = NULL;
-		}
-	}
-
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(rs_thresh - 1);
-
-	return rs_thresh;
-}
-
 /* Simple burst transmit for descriptor-based simple Tx path
  *
  * Transmits a burst of packets by filling hardware descriptors with mbuf
@@ -135,7 +91,7 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs(txq);
+		ci_tx_free_bufs_simple(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 155eec210e..ffb303158b 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2377,7 +2377,7 @@ i40e_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ci_tx_free_bufs(txq);
+		n = ci_tx_free_bufs_simple(txq);
 
 		if (n == 0)
 			break;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 0fc7237234..321415d839 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3218,7 +3218,7 @@ ice_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ci_tx_free_bufs(txq);
+		n = ci_tx_free_bufs_simple(txq);
 
 		if (n == 0)
 			break;
-- 
2.51.0

