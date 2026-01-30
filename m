Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC37BE6BF01
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0970640E48;
	Fri, 30 Jan 2026 12:43:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3C03940395
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773386; x=1801309386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/pmK0aUbBlChVErkyX5DUlBYYbItS+nGNNpqLxz8do=;
 b=hnHLUDdoWcE5irVrmMh9/t0HeZyr2RuyiCeAMQgTV24KhMDDyn+aDBTi
 aoTFeXI+TE3PS5ch/FbbxPcMqR4bB9PM/6G5cOqmdBcZ86J0dbmpI/9Mj
 SNsn/r66RWch+9BgaSxvPtpiEZJhWj0HGnOBHAHccRmtPW2yruEKTyKh4
 /gIwTEWTtoh9hILGBLnQ33BkgQgrTlel5/AckQzNIjTcatkpfWrdcKDRm
 RbyekrzQbR0R0J66tizjLe61uGRkqVORJ6tRICSWkcn3MzSItUYqOEp4K
 g3g88n5406dK1yK9nj3zdfYH1druEG9dC16vyGpreUQe3kHiw1sqS6nzR Q==;
X-CSE-ConnectionGUID: J2EhycGITGq6pezzWDzGBA==
X-CSE-MsgGUID: PP9Q16EaTb64ORynnyRyzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392346"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392346"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:43:01 -0800
X-CSE-ConnectionGUID: qBR6shIDRnW/yr/AF9wB8A==
X-CSE-MsgGUID: kaYTtVnwTuKJFg81MfDkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190594"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:43:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 35/36] net/intel: use vector mbuf cleanup from simple
 scalar path
Date: Fri, 30 Jan 2026 11:42:02 +0000
Message-ID: <20260130114207.1126032-36-bruce.richardson@intel.com>
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

Since the simple scalar path now uses the vector Tx entry struct, we can
leverage the vector mbuf cleanup function from that path and avoid
having a separate cleanup function for it.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar_fns.h | 74 +++++-------------------
 drivers/net/intel/i40e/i40e_rxtx.c       |  2 +-
 drivers/net/intel/ice/ice_rxtx.c         |  2 +-
 3 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index c8d370a921..27a07cf9e9 100644
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
index ba63d42b85..6ea6ffbb2f 100644
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
index 94951369fb..ece6ef6e2d 100644
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

