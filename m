Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECBC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:29:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BA4840A6D;
	Tue,  6 May 2025 15:28:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9C1F240269
 for <dev@dpdk.org>; Tue,  6 May 2025 15:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538118; x=1778074118;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4+QjB9R0wBl9S5jnkDvIpIG/0iuLmmOBNpAQ2vevqwg=;
 b=IYaffOIxhFU6Bb0XnvCuRaAytUkok8pI5gCBnF61AD2Vj6tdM+4kWO01
 Z09Pb2H4Ef83u+UyGbHz0L1VevTIZU+mt15+HfeBKwhpzaTCSLjORlb+G
 zJUPKZKiTfF9PUR8NCPoThp6QO6LxRVS/leiLjh5YCb/GZ4oRHCfEB6dw
 CUKmn+YvNmyBZqtKCmHqG+4fyyh8iQVQDP8T0J55CppqwnwJkPYnOTuBm
 5o8KYQwp7ag/n9Jmk/BQjakBm0b8x0h6NtLDhrgUyUCQD11W5hNGgFCCr
 M0KSgDtB0UnJInphuRPS6B/cuZ7SY0pC35QJ7y0/2QMemleLppTJ9NcAC A==;
X-CSE-ConnectionGUID: Nt5ggT6aS8yEOgk78y5Afw==
X-CSE-MsgGUID: 218mj56mQEGyTg9miXfqpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48215342"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="48215342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:28:37 -0700
X-CSE-ConnectionGUID: JKG3Ezf0RLOP73Z2aM/bIA==
X-CSE-MsgGUID: oNcEy9dPQgmRl+8h4edL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136010896"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2025 06:28:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 13/13] net/intel: add common Tx mbuf recycle
Date: Tue,  6 May 2025 14:28:02 +0100
Message-ID: <3925dc733f7a3c4dfcc1a36a5df5d2b14a3c5372.1746538072.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/recycle_mbufs.h      | 98 +++++++++++++++++++
 drivers/net/intel/common/tx.h                 |  1 +
 .../i40e/i40e_recycle_mbufs_vec_common.c      | 88 +----------------
 .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    | 89 +----------------
 4 files changed, 107 insertions(+), 169 deletions(-)

diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
index fd31c5c1ff..88779c5aa4 100644
--- a/drivers/net/intel/common/recycle_mbufs.h
+++ b/drivers/net/intel/common/recycle_mbufs.h
@@ -64,4 +64,102 @@ ci_rx_recycle_mbufs(struct ci_rx_queue *rxq, const uint16_t nb_mbufs,
 	rte_write32_wc_relaxed(rte_cpu_to_le_32(rx_id), rxq->qrx_tail);
 }
 
+/**
+ * Recycle buffers on Tx. Note: the function must first perform a driver-specific
+ * DD-bit-set check to ensure that the Tx descriptors are ready for recycling.
+ *
+ * @param txq Tx queue pointer
+ * @param recycle_rxq_info recycling mbuf information
+ *
+ * @return how many buffers were recycled
+ */
+static __rte_always_inline uint16_t
+ci_tx_recycle_mbufs(struct ci_tx_queue *txq,
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
diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index c99bd5420f..cc70fa7db4 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -37,6 +37,7 @@ struct ci_tx_queue {
 		volatile struct ice_tx_desc *ice_tx_ring;
 		volatile struct idpf_base_tx_desc *idpf_tx_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
+		volatile void *tx_ring; /**< Generic. */
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
 	union {
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 073357bee2..19edee781d 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -23,92 +23,12 @@ i40e_recycle_tx_mbufs_reuse_vec(void *tx_queue,
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
+	const uint64_t ctob = txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz;
 
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
+	/* are Tx descriptors ready for recycling? */
+	if ((ctob & rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
 			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
 		return 0;
 
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
+	return ci_tx_recycle_mbufs(txq, recycle_rxq_info);
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
index e2c3523ed2..179205b422 100644
--- a/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_recycle_mbufs_vec_common.c
@@ -21,92 +21,11 @@ ixgbe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 		struct rte_eth_recycle_rxq_info *recycle_rxq_info)
 {
 	struct ci_tx_queue *txq = tx_queue;
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
+	const uint32_t status = txq->ixgbe_tx_ring[txq->tx_next_dd].wb.status;
 
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
+	/* are Tx descriptors ready for recycling? */
+	if (!(status & rte_cpu_to_le_32(IXGBE_ADVTXD_STAT_DD)))
 		return 0;
 
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
+	return ci_tx_recycle_mbufs(tx_queue, recycle_rxq_info);
 }
-- 
2.47.1

