Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3667CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 11:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AAD740296;
	Tue, 19 May 2026 13:06:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8045D4025E
 for <dev@dpdk.org>; Tue, 19 May 2026 13:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779188806; x=1810724806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=632TXx9O6+cozazKjM3Aim64vAv/yMY/hPVeEyH82wc=;
 b=Obs1xp4j3G0ZGHd7nCYUyHx3r9Xj+fidstb8EQ6EfmBnVgblVBY5W+Ud
 hd5uUwASW0QxzgSMd0CKsCfvLwSjloAc6ZG2x+wIHYpJrOIbYS+3rN5yi
 EQVsfBOdtqkBO3RMIW5wxZnkhzIYSDpL2Lgp62urngFevjD+Zgm06uzFy
 rvpUcqeQor8XyB57RtyFjz4xYI7NRcr78OJw7hGUOTh7tqL69fFu1nn11
 n32Bl4BHQSkly+gsT7TnTIt7e2qO2swqON11AIHjrEcK3I0rmLAH90iDg
 5ydDsRCNS/e9VlAWphiJnv8TiZ/4vVx42FeUKUUh+asEtY9JMWtxgfew9 Q==;
X-CSE-ConnectionGUID: Y+ejBP9cSxmAn5IC1tAiKQ==
X-CSE-MsgGUID: 4AjR2KTYSBiNgm6Wbtk8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="102737567"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="102737567"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 04:06:45 -0700
X-CSE-ConnectionGUID: XBGngLzEQbixoBlFm8pqxA==
X-CSE-MsgGUID: qFHzq8swQw2J90XAza3MFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="237121427"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 19 May 2026 04:06:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3] net/intel: optimize for fast-free hint
Date: Tue, 19 May 2026 12:06:37 +0100
Message-ID: <20260519110637.964965-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260123112032.2174361-1-bruce.richardson@intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
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

When the fast-free hint is provided to the driver we know that the mbufs
have refcnt of 1 and are from the same mempool. Therefore, we can
optimize a bit for this case by:

* resetting the necessary mbuf fields, ie. nb_seg and next pointer when
  we are accessing the mbuf on writing the descriptor.
* on cleanup of buffers after transmit, we can just write those buffers
  straight to the mempool without accessing them.
* when doing buffer cleanup, we can follow the model of the vector
  driver where we cleanup in fixed bursts which don't wrap, and where we
  track the mbufs between tx_tail and last_cleaned as invalid, so we
  don't need to set them to NULL. [We only set to NULL valid mbuf slots
  where we have a context descriptor or segment not backed by an mbuf]

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v3:
* used mbuf_raw_free_bulk rather than mempool function directly
* check for fast_free via mp pointer rather than flags
* remove unnecessary prefetches

V2: Fix issues with original submission:
* missed check for NULL mbufs
* fixed issue with freeing directly from sw_ring in scalar path which
  doesn't work as thats not a flag array of pointers
* fixed missing null assignment in case of large segments for TSO
---
 drivers/net/intel/common/tx.h        | 21 ++++--
 drivers/net/intel/common/tx_scalar.h | 99 +++++++++++++++++++++-------
 2 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 23a8c39cf2..5fe71aed12 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -329,13 +329,22 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 		return;
 
 	if (!txq->use_vec_entry) {
-		/* Regular scalar path uses sw_ring with ci_tx_entry */
-		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
-			if (txq->sw_ring[i].mbuf != NULL) {
-				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
-				txq->sw_ring[i].mbuf = NULL;
-			}
+		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail - 1). */
+		const uint16_t start = (txq->last_desc_cleaned + 1) % txq->nb_tx_desc;
+		const uint16_t nb_desc = txq->nb_tx_desc;
+		const uint16_t end = txq->tx_tail;
+
+		uint16_t i = start;
+		if (end < i) {
+			for (; i < nb_desc; i++)
+				if (txq->sw_ring[i].mbuf != NULL)
+					rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
+			i = 0;
 		}
+		for (; i < end; i++)
+			if (txq->sw_ring[i].mbuf != NULL)
+				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
+		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
 		return;
 	}
 
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 9fcd2e4733..d27df34dfa 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -197,16 +197,64 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
 			0 :
 			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
-	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) + (txq->tx_rs_thresh - 1);
+	const uint16_t dd_idx = txq->rs_last_id[rs_idx];
+	const uint16_t first_to_clean = rs_idx << txq->log2_rs_thresh;
 
-	/* Check if descriptor is done  */
-	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
-				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
+	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
+	if ((txd[dd_idx].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
+		/* Descriptor not yet processed by hardware */
 		return -1;
 
+	/* DD bit is set, descriptors are done. Now free the mbufs. */
+	/* Note: nb_tx_desc is guaranteed to be a multiple of tx_rs_thresh,
+	 * validated during queue setup. This means cleanup never wraps around
+	 * the ring within a single burst (e.g., ring=256, rs_thresh=32 gives
+	 * bursts of 0-31, 32-63, ..., 224-255).
+	 */
+	const uint16_t nb_to_clean = txq->tx_rs_thresh;
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
+
+	/* fast_free_mp is NULL only when the fast free is disabled*/
+	if (txq->fast_free_mp != NULL) {
+		/* FAST_FREE path: mbufs are already reset, just return to pool */
+		struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
+		uint16_t nb_free = 0;
+
+		/* Get cached mempool pointer, or cache it on first use */
+		struct rte_mempool *mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+			txq->fast_free_mp :
+			(txq->fast_free_mp = sw_ring[dd_idx].mbuf->pool);
+
+		/* Pack non-NULL mbufs in-place at start of sw_ring range.
+		 * No modulo needed in loop since we're guaranteed not to wrap.
+		 */
+		for (uint16_t i = 0; i < nb_to_clean; i++) {
+			struct rte_mbuf *m = sw_ring[first_to_clean + i].mbuf;
+			if (m == NULL)
+				continue;
+			free[nb_free++] = m;
+			if (unlikely(nb_free == CI_TX_MAX_FREE_BUF_SZ)) {
+				rte_mbuf_raw_free_bulk(mp, free, nb_free);
+				nb_free = 0;
+			}
+		}
+
+		/* Bulk return to mempool using packed sw_ring entries directly */
+		if (nb_free > 0)
+			rte_mbuf_raw_free_bulk(mp, free, nb_free);
+	} else {
+		/* Non-FAST_FREE path: use free_seg for refcount checks and freeing */
+		for (uint16_t i = 0; i < nb_to_clean; i++) {
+			struct rte_mbuf *m = sw_ring[first_to_clean + i].mbuf;
+			if (m != NULL)
+				rte_pktmbuf_free_seg(m);
+		}
+	}
+
 	/* Update the txq to reflect the last descriptor that was cleaned */
-	txq->last_desc_cleaned = desc_to_clean_to;
+	txq->last_desc_cleaned = first_to_clean + txq->tx_rs_thresh - 1;
 	txq->nb_tx_free += txq->tx_rs_thresh;
 
 	return 0;
@@ -450,8 +498,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txd = &ci_tx_ring[tx_id];
 			tx_id = txe->next_id;
 
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = tx_pkt;
 			/* Setup TX Descriptor */
 			td_cmd |= CI_TX_DESC_CMD_EOP;
@@ -471,11 +517,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
 
 			txn = &sw_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
+			txe->mbuf = NULL;
 
 			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
@@ -488,11 +530,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			uint64_t *ipsec_txd = RTE_CAST_PTR(uint64_t *, &ci_tx_ring[tx_id]);
 
 			txn = &sw_ring[txe->next_id];
-			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
+			txe->mbuf = NULL;
 
 			ipsec_txd[0] = ipsec_qw0;
 			ipsec_txd[1] = ipsec_qw1;
@@ -507,10 +545,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txd = &ci_tx_ring[tx_id];
 			txn = &sw_ring[txe->next_id];
 
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = m_seg;
 
+			/* For FAST_FREE: reset mbuf fields while we have it in cache.
+			 * [Fast free is indicated by txq->fast_free_mp being non-NULL.]
+			 * FAST_FREE guarantees refcnt=1 and direct mbufs, so we only
+			 * need to reset nb_segs and next pointer as per rte_pktmbuf_prefree_seg.
+			 * Save next pointer before resetting since we need it for loop iteration.
+			 */
+			struct rte_mbuf *next_seg = m_seg->next;
+			if (txq->fast_free_mp != NULL) {
+				if (m_seg->nb_segs != 1)
+					m_seg->nb_segs = 1;
+				if (next_seg != NULL)
+					m_seg->next = NULL;
+			}
+
 			/* Setup TX Descriptor */
 			/* Calculate segment length, using IPsec callback if provided */
 			if (ipsec_ops != NULL)
@@ -528,18 +578,23 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 					((uint64_t)CI_MAX_DATA_PER_TXD << CI_TXD_QW1_TX_BUF_SZ_S) |
 					((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
 				write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
+				/* txe for this slot has already been written (e.g. above outside
+				 * loop), so we write the extra NULL mbuf pointer for this
+				 * descriptor after we increment txe below.
+				 */
 
 				buf_dma_addr += CI_MAX_DATA_PER_TXD;
 				slen -= CI_MAX_DATA_PER_TXD;
 
 				tx_id = txe->next_id;
 				txe = txn;
+				txe->mbuf = NULL;
 				txd = &ci_tx_ring[tx_id];
 				txn = &sw_ring[txe->next_id];
 			}
 
 			/* fill the last descriptor with End of Packet (EOP) bit */
-			if (m_seg->next == NULL)
+			if (next_seg == NULL)
 				td_cmd |= CI_TX_DESC_CMD_EOP;
 
 			const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
@@ -551,7 +606,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			tx_id = txe->next_id;
 			txe = txn;
-			m_seg = m_seg->next;
+			m_seg = next_seg;
 		} while (m_seg);
 end_pkt:
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
-- 
2.53.0

