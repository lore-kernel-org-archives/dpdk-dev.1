Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E19C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 14:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82B6040E21;
	Fri, 30 May 2025 15:58:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C9DAB40E19
 for <dev@dpdk.org>; Fri, 30 May 2025 15:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748613512; x=1780149512;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lIgqbICD+XzkJAixCzgfHKGVpU1x7Iv2HDLDWNhxRPQ=;
 b=SJSqMvjUgnb8X8QXQPpSUxu1/4rhLdmb07IDiKRFnN3TjF6igkrAyAib
 cXphL3dLibBZ2DShvy8pkw9wWNyanLCDx72Asi5CwFOPGPVOknhdDHXJp
 x06RfGMJuuy3Q9Oz5v4BLMOXeTChHIOhN3yi7zRe9dA3fgW2QhYHQEQZW
 M3szey+iuUb3AeNQWc7M07qDmqfnzS3UTkSt3fPFdIimG300oZ6Hngu9b
 3/UTLhXJLUUfIOB1OUryh3HDjsUj1M3uqpO/c4xX44tXK0UaJLkmk381V
 HYaZEdjoFIKU6E740jNrR5g7ZEd1SJu8PamjvX8MfpMgQMc52zxsRx/DO g==;
X-CSE-ConnectionGUID: CzDmogePRieLD9eDDRphZg==
X-CSE-MsgGUID: H95jznhvRpSIgly4skWf4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50809520"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="50809520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 06:58:25 -0700
X-CSE-ConnectionGUID: EAl6zUz9SP6/LaZZFhyW+w==
X-CSE-MsgGUID: XROtqe7TSk6XRH07ChtSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; d="scan'208";a="174887613"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa002.jf.intel.com with ESMTP; 30 May 2025 06:58:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 25/25] net/intel: add common Tx mbuf recycle
Date: Fri, 30 May 2025 14:57:21 +0100
Message-ID: <150e8c6ff6c3730f5c9ed78477d0b615c7f35a1a.1748612804.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
References: 
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

Currently, there are duplicate implementations of Tx mbuf recycle in some
drivers, specifically ixgbe and i40e. Move them into a common header.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v3 -> v4:
    - Use the common desc_done function to check for DD bit status
    - Add a desc_done implementation for ixgbe
    
    [implementation note]
    We could've used ixgbe_tx_desc_done in ixgbe_rxtx.c, but it is defined in
    ixgbe_rxtx_vec_common.h, and including that file causes a clash between two
    different implementations of ixgbe_tx_free_bufs(), so I left it alone.

 drivers/net/intel/common/recycle_mbufs.h      | 105 ++++++++++++++++++
 .../i40e/i40e_recycle_mbufs_vec_common.c      |  90 +--------------
 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    |  92 +--------------
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   9 ++
 4 files changed, 120 insertions(+), 176 deletions(-)

diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
index c32e2ce9b1..5b5abba918 100644
--- a/drivers/net/intel/common/recycle_mbufs.h
+++ b/drivers/net/intel/common/recycle_mbufs.h
@@ -65,4 +65,109 @@ ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs)
 	rte_write32_wc_relaxed(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
 }
 
+/**
+ * Recycle buffers on Tx.
+ *
+ * @param txq Tx queue pointer
+ * @param desc_done function to check if the Tx descriptor is done
+ * @param recycle_rxq_info recycling mbuf information
+ *
+ * @return how many buffers were recycled
+ */
+static __rte_always_inline uint16_t
+ci_tx_recycle_mbufs(struct ci_tx_queue *txq, ci_desc_done_fn desc_done,
+	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
+{
+	struct ci_tx_entry *txep;
+	struct rte_mbuf **rxep;
+	int i, n;
+	uint16_t nb_recycle_mbufs;
+	uint16_t avail = 0;
+	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
+	uint16_t mask = recycle_rxq_info->mbuf_ring_size - 1;
+	uint16_t refill_requirement = recycle_rxq_info->refill_requirement;
+	uint16_t refill_head = *recycle_rxq_info->refill_head;
+	uint16_t receive_tail = *recycle_rxq_info->receive_tail;
+
+	/* Get available recycling Rx buffers. */
+	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
+
+	/* Check Tx free thresh and Rx available space. */
+	if (txq->nb_tx_free > txq->tx_free_thresh || avail <= txq->tx_rs_thresh)
+		return 0;
+
+	if (!desc_done(txq, txq->tx_next_dd)) {
+		/* If the Tx descriptor is not done, we can not recycle
+		 * buffers.
+		 */
+		return 0;
+	}
+
+	n = txq->tx_rs_thresh;
+	nb_recycle_mbufs = n;
+
+	/* Mbufs recycle mode can only support no ring buffer wrapping around.
+	 * Two case for this:
+	 *
+	 * case 1: The refill head of Rx buffer ring needs to be aligned with
+	 * mbuf ring size. In this case, the number of Tx freeing buffers
+	 * should be equal to refill_requirement.
+	 *
+	 * case 2: The refill head of Rx ring buffer does not need to be aligned
+	 * with mbuf ring size. In this case, the update of refill head can not
+	 * exceed the Rx mbuf ring size.
+	 */
+	if ((refill_requirement && refill_requirement != n) ||
+		(!refill_requirement && (refill_head + n > mbuf_ring_size)))
+		return 0;
+
+	/* First buffer to free from S/W ring is at index
+	 * tx_next_dd - (tx_rs_thresh-1).
+	 */
+	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
+	rxep = recycle_rxq_info->mbuf_ring;
+	rxep += refill_head;
+
+	/* is fast-free enabled in offloads? */
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		/* Avoid txq containing buffers from unexpected mempool. */
+		if (unlikely(recycle_rxq_info->mp
+					!= txep[0].mbuf->pool))
+			return 0;
+
+		/* Directly put mbufs from Tx to Rx. */
+		for (i = 0; i < n; i++)
+			rxep[i] = txep[i].mbuf;
+	} else {
+		for (i = 0; i < n; i++) {
+			rxep[i] = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+
+			/* If Tx buffers are not the last reference or from
+			 * unexpected mempool, previous copied buffers are
+			 * considered as invalid.
+			 */
+			if (unlikely(rxep[i] == NULL ||
+				recycle_rxq_info->mp != txep[i].mbuf->pool))
+				nb_recycle_mbufs = 0;
+		}
+		/* If Tx buffers are not the last reference or
+		 * from unexpected mempool, all recycled buffers
+		 * are put into mempool.
+		 */
+		if (nb_recycle_mbufs == 0)
+			for (i = 0; i < n; i++) {
+				if (rxep[i] != NULL)
+					rte_mempool_put(rxep[i]->pool, rxep[i]);
+			}
+	}
+
+	/* Update counters for Tx. */
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	if (txq->tx_next_dd >= txq->nb_tx_desc)
+		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+
+	return nb_recycle_mbufs;
+}
+
 #endif
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 0b036faea9..5faaff28c4 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -10,6 +10,8 @@
 #include "i40e_ethdev.h"
 #include "i40e_rxtx.h"
 
+#include "i40e_rxtx_vec_common.h"
+
 #include "../common/recycle_mbufs.h"
 
 void
@@ -23,92 +25,6 @@ i40e_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
 	struct ci_tx_queue *txq = tx_queue;
-	struct ci_tx_entry *txep;
-	struct rte_mbuf **rxep;
-	int i, n;
-	uint16_t nb_recycle_mbufs;
-	uint16_t avail = 0;
-	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
-	uint16_t mask = recycle_rxq_info->mbuf_ring_size - 1;
-	uint16_t refill_requirement = recycle_rxq_info->refill_requirement;
-	uint16_t refill_head = *recycle_rxq_info->refill_head;
-	uint16_t receive_tail = *recycle_rxq_info->receive_tail;
 
-	/* Get available recycling Rx buffers. */
-	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
-
-	/* Check Tx free thresh and Rx available space. */
-	if (txq->nb_tx_free > txq->tx_free_thresh || avail <= txq->tx_rs_thresh)
-		return 0;
-
-	/* check DD bits on threshold descriptor */
-	if ((txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
-				rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
-			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	n = txq->tx_rs_thresh;
-	nb_recycle_mbufs = n;
-
-	/* Mbufs recycle mode can only support no ring buffer wrapping around.
-	 * Two case for this:
-	 *
-	 * case 1: The refill head of Rx buffer ring needs to be aligned with
-	 * mbuf ring size. In this case, the number of Tx freeing buffers
-	 * should be equal to refill_requirement.
-	 *
-	 * case 2: The refill head of Rx ring buffer does not need to be aligned
-	 * with mbuf ring size. In this case, the update of refill head can not
-	 * exceed the Rx mbuf ring size.
-	 */
-	if ((refill_requirement && refill_requirement != n) ||
-		(!refill_requirement && (refill_head + n > mbuf_ring_size)))
-		return 0;
-
-	/* First buffer to free from S/W ring is at index
-	 * tx_next_dd - (tx_rs_thresh-1).
-	 */
-	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
-	rxep = recycle_rxq_info->mbuf_ring;
-	rxep += refill_head;
-
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
-		/* Avoid txq contains buffers from unexpected mempool. */
-		if (unlikely(recycle_rxq_info->mp
-					!= txep[0].mbuf->pool))
-			return 0;
-
-		/* Directly put mbufs from Tx to Rx. */
-		for (i = 0; i < n; i++)
-			rxep[i] = txep[i].mbuf;
-	} else {
-		for (i = 0; i < n; i++) {
-			rxep[i] = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-
-			/* If Tx buffers are not the last reference or from
-			 * unexpected mempool, previous copied buffers are
-			 * considered as invalid.
-			 */
-			if (unlikely(rxep[i] == NULL ||
-				recycle_rxq_info->mp != txep[i].mbuf->pool))
-				nb_recycle_mbufs = 0;
-		}
-		/* If Tx buffers are not the last reference or
-		 * from unexpected mempool, all recycled buffers
-		 * are put into mempool.
-		 */
-		if (nb_recycle_mbufs == 0)
-			for (i = 0; i < n; i++) {
-				if (rxep[i] != NULL)
-					rte_mempool_put(rxep[i]->pool, rxep[i]);
-			}
-	}
-
-	/* Update counters for Tx. */
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	return nb_recycle_mbufs;
+	return ci_tx_recycle_mbufs(txq, i40e_tx_desc_done, recycle_rxq_info);
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
index 776bb4303f..f0ffc4360e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
@@ -8,6 +8,8 @@
 #include "ixgbe_ethdev.h"
 #include "ixgbe_rxtx.h"
 
+#include "ixgbe_rxtx_vec_common.h"
+
 #include "../common/recycle_mbufs.h"
 
 void
@@ -20,93 +22,5 @@ uint16_t
 ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
-	struct ci_tx_queue *txq = tx_queue;
-	struct ci_tx_entry *txep;
-	struct rte_mbuf **rxep;
-	int i, n;
-	uint32_t status;
-	uint16_t nb_recycle_mbufs;
-	uint16_t avail = 0;
-	uint16_t mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
-	uint16_t mask = recycle_rxq_info->mbuf_ring_size - 1;
-	uint16_t refill_requirement = recycle_rxq_info->refill_requirement;
-	uint16_t refill_head = *recycle_rxq_info->refill_head;
-	uint16_t receive_tail = *recycle_rxq_info->receive_tail;
-
-	/* Get available recycling Rx buffers. */
-	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
-
-	/* Check Tx free thresh and Rx available space. */
-	if (txq->nb_tx_free > txq->tx_free_thresh || avail <= txq->tx_rs_thresh)
-		return 0;
-
-	/* check DD bits on threshold descriptor */
-	status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
-	if (!(status & IXGBE_ADVTXD_STAT_DD))
-		return 0;
-
-	n = txq->tx_rs_thresh;
-	nb_recycle_mbufs = n;
-
-	/* Mbufs recycle can only support no ring buffer wrapping around.
-	 * Two case for this:
-	 *
-	 * case 1: The refill head of Rx buffer ring needs to be aligned with
-	 * buffer ring size. In this case, the number of Tx freeing buffers
-	 * should be equal to refill_requirement.
-	 *
-	 * case 2: The refill head of Rx ring buffer does not need to be aligned
-	 * with buffer ring size. In this case, the update of refill head can not
-	 * exceed the Rx buffer ring size.
-	 */
-	if ((refill_requirement && refill_requirement != n) ||
-		(!refill_requirement && (refill_head + n > mbuf_ring_size)))
-		return 0;
-
-	/* First buffer to free from S/W ring is at index
-	 * tx_next_dd - (tx_rs_thresh-1).
-	 */
-	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
-	rxep = recycle_rxq_info->mbuf_ring;
-	rxep += refill_head;
-
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
-		/* Avoid txq contains buffers from unexpected mempool. */
-		if (unlikely(recycle_rxq_info->mp
-					!= txep[0].mbuf->pool))
-			return 0;
-
-		/* Directly put mbufs from Tx to Rx. */
-		for (i = 0; i < n; i++)
-			rxep[i] = txep[i].mbuf;
-	} else {
-		for (i = 0; i < n; i++) {
-			rxep[i] = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-
-			/* If Tx buffers are not the last reference or from
-			 * unexpected mempool, previous copied buffers are
-			 * considered as invalid.
-			 */
-			if (unlikely(rxep[i] == NULL ||
-				recycle_rxq_info->mp != txep[i].mbuf->pool))
-				nb_recycle_mbufs = 0;
-		}
-		/* If Tx buffers are not the last reference or
-		 * from unexpected mempool, all recycled buffers
-		 * are put into mempool.
-		 */
-		if (nb_recycle_mbufs == 0)
-			for (i = 0; i < n; i++) {
-				if (rxep[i] != NULL)
-					rte_mempool_put(rxep[i]->pool, rxep[i]);
-			}
-	}
-
-	/* Update counters for Tx. */
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	return nb_recycle_mbufs;
+	return ci_tx_recycle_mbufs(tx_queue, ixgbe_tx_desc_done, recycle_rxq_info);
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
index 538a2b5164..2ec7774731 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.h
@@ -6,11 +6,20 @@
 #define _IXGBE_RXTX_VEC_COMMON_H_
 #include <stdint.h>
 #include <ethdev_driver.h>
+#include <rte_malloc.h>
 
 #include "../common/rx.h"
 #include "ixgbe_ethdev.h"
 #include "ixgbe_rxtx.h"
 
+static inline int
+ixgbe_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	const uint32_t status = txq->ixgbe_tx_ring[idx].wb.status;
+
+	return !!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD));
+}
+
 static __rte_always_inline int
 ixgbe_tx_free_bufs(struct ci_tx_queue *txq)
 {
-- 
2.47.1

