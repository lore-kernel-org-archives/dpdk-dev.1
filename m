Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D32D72377
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5174026F;
	Fri, 23 Jan 2026 12:20:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7FE6C40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 12:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769167243; x=1800703243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mw6TFgWi5pSbxvrzcghQkhXuTkHcQb7yFgREIyqCCh8=;
 b=Y5G0GEwJqWFno/c15lYs0/4kLvdhOAYkI+aGHNpVK2AMAdq5/+wewWde
 SRG18tzs9AcYFk32j4VSNp8pR8SGnj0Ux6PWxl5lF3cRQLLg7bbHUQoxD
 pBj4XrkYntXAKs5JqZ0yE3d2VjQyZezaYJaFGzijeCAcUpUq4Y2a6t/gX
 c1rVvnkwA2Gb/3FWJ3893KG41nVz5DpawbB7W/JgNaaLWmf7RBT6OzunG
 b26vhRsakY7waHMitfHMLrpLeRc7RMEs6VUVBjDSVSfFL1A7yHY7OzWWw
 KtwMfLARvbLQVeWT46UvviW0+WsPQbHMUOG7QmBs607Z/9Sz43ZuFNPjI g==;
X-CSE-ConnectionGUID: +i+f/OrfRq6QbGn1HK/6Iw==
X-CSE-MsgGUID: sD4CZokwS/GAeqz1zQohtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81049530"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="81049530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:20:42 -0800
X-CSE-ConnectionGUID: dc5xJZp8T+aUOC3mSayJhQ==
X-CSE-MsgGUID: 4D6/K4ziRDi4AtDCuZKxiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207344856"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 23 Jan 2026 03:20:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: mb@smartsharesystems.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/intel: optimize for fast-free hint
Date: Fri, 23 Jan 2026 11:20:31 +0000
Message-ID: <20260123112032.2174361-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
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

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h            | 16 +++--
 drivers/net/intel/common/tx_scalar_fns.h | 81 +++++++++++++++++++-----
 2 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 7fe4022f35..9bda2c8f59 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -345,12 +345,20 @@ ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 		return;
 
 	if (!txq->vector_tx) {
-		for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
-			if (txq->sw_ring[i].mbuf != NULL) {
+		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail - 1). */
+		const uint16_t start = (txq->last_desc_cleaned + 1) % txq->nb_tx_desc;
+		const uint16_t nb_desc = txq->nb_tx_desc;
+		const uint16_t end = txq->tx_tail;
+
+		uint16_t i = start;
+		if (end < i) {
+			for (; i < nb_desc; i++)
 				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
-				txq->sw_ring[i].mbuf = NULL;
-			}
+			i = 0;
 		}
+		for (; i < end; i++)
+			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
+		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
 		return;
 	}
 
diff --git a/drivers/net/intel/common/tx_scalar_fns.h b/drivers/net/intel/common/tx_scalar_fns.h
index 82dc54438f..47ddcf411b 100644
--- a/drivers/net/intel/common/tx_scalar_fns.h
+++ b/drivers/net/intel/common/tx_scalar_fns.h
@@ -30,16 +30,60 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
 	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
 			0 :
 			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
-	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) + (txq->tx_rs_thresh - 1);
+	const uint16_t dd_idx = txq->rs_last_id[rs_idx];
+	const uint16_t first_to_clean = rs_idx << txq->log2_rs_thresh;
 
 	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
-	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
+	if ((txd[dd_idx].cmd_type_offset_bsz & rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
 			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
 		/* Descriptor not yet processed by hardware */
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
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		/* FAST_FREE path: mbufs are already reset, just return to pool */
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
+			if (m != NULL) {
+				/* Pack into sw_ring at packed position */
+				sw_ring[first_to_clean + nb_free].mbuf = m;
+				nb_free++;
+			}
+		}
+
+		/* Bulk return to mempool using packed sw_ring entries directly */
+		if (nb_free > 0)
+			rte_mempool_put_bulk(mp, (void **)&sw_ring[first_to_clean].mbuf, nb_free);
+	} else {
+		/* Non-FAST_FREE path: use prefree_seg for refcount checks */
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
@@ -300,8 +344,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txd = &ci_tx_ring[tx_id];
 			tx_id = txe->next_id;
 
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = tx_pkt;
 			/* Setup TX Descriptor */
 			td_cmd |= CI_TX_DESC_CMD_EOP;
@@ -322,10 +364,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			txn = &sw_ring[txe->next_id];
 			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
+			txe->mbuf = NULL;
 
 			write_txd(ctx_txd, cd_qw0, cd_qw1);
 
@@ -339,10 +378,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			txn = &sw_ring[txe->next_id];
 			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
-			if (txe->mbuf) {
-				rte_pktmbuf_free_seg(txe->mbuf);
-				txe->mbuf = NULL;
-			}
+			txe->mbuf = NULL;
 
 			ipsec_txd[0] = ipsec_qw0;
 			ipsec_txd[1] = ipsec_qw1;
@@ -357,10 +393,21 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			txd = &ci_tx_ring[tx_id];
 			txn = &sw_ring[txe->next_id];
 
-			if (txe->mbuf)
-				rte_pktmbuf_free_seg(txe->mbuf);
 			txe->mbuf = m_seg;
 
+			/* For FAST_FREE: reset mbuf fields while we have it in cache.
+			 * FAST_FREE guarantees refcnt=1 and direct mbufs, so we only
+			 * need to reset nb_segs and next pointer as per rte_pktmbuf_prefree_seg.
+			 * Save next pointer before resetting since we need it for loop iteration.
+			 */
+			struct rte_mbuf *next_seg = m_seg->next;
+			if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+				if (m_seg->nb_segs != 1)
+					m_seg->nb_segs = 1;
+				if (next_seg != NULL)
+					m_seg->next = NULL;
+			}
+
 			/* Setup TX Descriptor */
 			/* Calculate segment length, using IPsec callback if provided */
 			if (ipsec_ops != NULL)
@@ -389,7 +436,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			}
 
 			/* fill the last descriptor with End of Packet (EOP) bit */
-			if (m_seg->next == NULL)
+			if (next_seg == NULL)
 				td_cmd |= CI_TX_DESC_CMD_EOP;
 
 			const uint64_t cmd_type_offset_bsz = CI_TX_DESC_DTYPE_DATA |
@@ -401,7 +448,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 
 			tx_id = txe->next_id;
 			txe = txn;
-			m_seg = m_seg->next;
+			m_seg = next_seg;
 		} while (m_seg);
 end_pkt:
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
-- 
2.51.0

