Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FDD2F32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC05C40E64;
	Tue, 13 Jan 2026 16:16:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C358C40E35
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:15:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317358; x=1799853358;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y7Qh19OfmsSEP+xbt7kIcYzTgCKOfkV4ZPhSFcYD+sw=;
 b=KQOMM/pCPUvS3ReT4t+mgmHZ8k/2+esX2GVIDEbozs0E5nJzZreRWpAU
 IL0FH1CxjDOUVXicNIET+2gIkNpWb/clk3TLn0B5MjaKQwWgrFlA4hmfY
 NkbpPnLl0v6/4ArpWgYe5ONVw1m71herdJekSLXWKG//XXxm62gBYfNMW
 IMBEhXaKGmzAtktKEEFzdbJO0rXvURGPAoeWfbjqiDi+qSPPou57fjy1h
 7ZhwZ0e9nxXfV/TUhwJjR3w+xMUTnzmbUMiGsQQfeL+g2StrP7dUnCr16
 iyLK5iHrxmLTDQn4DaL8zXkr/bjSdMG0GTVoNqgxZ1tqzgGEkGkt9Fb5U Q==;
X-CSE-ConnectionGUID: 171u1cS7RgWaYuAmDdfBlA==
X-CSE-MsgGUID: /CBA+OTITq2PKMJ9UFJEQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80969241"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="80969241"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:15:57 -0800
X-CSE-ConnectionGUID: IHRog+mARwWrzUupA1goeA==
X-CSE-MsgGUID: vTM/dBKrQfyIP/Tk8o4x9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="203556693"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 13 Jan 2026 07:15:56 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 35/36] net/intel: use vector mbuf cleanup from simple
 scalar path
Date: Tue, 13 Jan 2026 15:14:59 +0000
Message-ID: <20260113151505.1871271-36-bruce.richardson@intel.com>
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

Since the simple scalar path now uses the vector Tx entry struct, we can
leverage the vector mbuf cleanup function from that path and avoid
having a separate cleanup function for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 71 +++++-------------------
 drivers/net/intel/i40e/i40e_rxtx.c       |  2 +-
 drivers/net/intel/ice/ice_rxtx.c         |  2 +-
 3 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index b284b80cbe..ce3837a201 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
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
@@ -52,61 +66,6 @@ ci_tx_fill_hw_ring_simple(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pk
 	}
 }
 
-/* Free transmitted mbufs from descriptor ring with bulk freeing for Tx simple path */
-static __rte_always_inline int
-ci_tx_free_bufs(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry_vec *txep;
-	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
-	uint16_t i = 0, j = 0;
-	struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
-	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, CI_TX_MAX_FREE_BUF_SZ);
-	const uint16_t m = tx_rs_thresh % CI_TX_MAX_FREE_BUF_SZ;
-
-	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	txep = &txq->sw_ring_vec[txq->tx_next_dd - (tx_rs_thresh - 1)];
-
-	for (i = 0; i < tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
-
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
-		if (k) {
-			for (j = 0; j != k; j += CI_TX_MAX_FREE_BUF_SZ) {
-				for (i = 0; i < CI_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
-					free[i] = txep->mbuf;
-					txep->mbuf = NULL;
-				}
-				rte_mbuf_raw_free_bulk(free[0]->pool, free,
-						CI_TX_MAX_FREE_BUF_SZ);
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
 /* Simple burst transmit for descriptor-based simple Tx path
  *
  * Transmits a burst of packets by filling hardware descriptors with mbuf
@@ -132,7 +91,7 @@ ci_xmit_burst_simple(struct ci_tx_queue *txq,
 	 * descriptor, free the associated buffer.
 	 */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		ci_tx_free_bufs(txq);
+		ci_tx_free_bufs_simple(txq);
 
 	/* Use available descriptor only */
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 185e45fb9a..820a955158 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -2367,7 +2367,7 @@ i40e_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ci_tx_free_bufs(txq);
+		n = ci_tx_free_bufs_simple(txq);
 
 		if (n == 0)
 			break;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 06f7e85c12..be9d88dda6 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3208,7 +3208,7 @@ ice_tx_done_cleanup_simple(struct ci_tx_queue *txq,
 		if (txq->nb_tx_desc - txq->nb_tx_free < txq->tx_rs_thresh)
 			break;
 
-		n = ci_tx_free_bufs(txq);
+		n = ci_tx_free_bufs_simple(txq);
 
 		if (n == 0)
 			break;
-- 
2.51.0

