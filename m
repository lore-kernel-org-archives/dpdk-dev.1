Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC92ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4638B40ED2;
	Wed, 11 Feb 2026 19:14:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7359A40E43
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833639; x=1802369639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1rCCw8E7I+3QuOg1w09r18GEYGW8sd/6aNdMcb7D2qY=;
 b=SN7cNpYDQJhwnJ7O49XLLgNaKVKQMxUqU9RClR6guscb+5awQuM1cl4Z
 qgRPhXMkIijTpU1gr6Gt56OmCFWpSehTIlyynvk/BFjNi+iuJ+DoLFxr2
 oWGcuxjxf2w95xrF2bse04R84oGfhXyghtwqgKk+tlmSkjr6b9iXYkxrI
 M0gR+X/RXDOfQ2WyxOJilMGmARWZsE9AqjZ2BOHH6yQd4kC5g8Y6CxnlK
 GSVxcLvhRnY53V7LedC2EcmKit88bEJcxw3QSlX+PyrL7rSscl/A4uBL+
 wP+LiQC+7eYjhybxQk3kN2zDDNUE8/dFrQlTRRm0hmf6NdvHeu6cug0kC Q==;
X-CSE-ConnectionGUID: AI9JgzhuT26VcNMI0Pf3Ew==
X-CSE-MsgGUID: R6HSwTSpRZ+rBvxW70i2Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834693"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834693"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:58 -0800
X-CSE-ConnectionGUID: V5dzqKrbQiK84mLfonwiHg==
X-CSE-MsgGUID: tnB6KSYHTjiRcHDXGrU3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986377"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:57 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 24/35] net/ixgbe: use separate array for desc status
 tracking
Date: Wed, 11 Feb 2026 18:12:53 +0000
Message-ID: <20260211181309.2838042-25-bruce.richardson@intel.com>
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

Due to significant differences in the ixgbe transmit descriptors, the
ixgbe driver does not use the common scalar Tx functionality. Update the
driver directly so its use of the rs_last_id array matches that of the
common Tx code.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 86 +++++++++++++++-------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0af04c9b0d..3e37ccc50d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -43,6 +43,7 @@
 #include <rte_ip.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_bitops.h>
 
 #include "ixgbe_logs.h"
 #include "base/ixgbe_api.h"
@@ -571,57 +572,35 @@ tx_desc_ol_flags_to_cmdtype(uint64_t ol_flags)
 static inline int
 ixgbe_xmit_cleanup(struct ci_tx_queue *txq)
 {
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
 	volatile union ixgbe_adv_tx_desc *txr = txq->ixgbe_tx_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-	uint32_t status;
+	const uint16_t last_desc_cleaned = txq->last_desc_cleaned;
+	const uint16_t nb_tx_desc = txq->nb_tx_desc;
 
-	/* Determine the last descriptor needing to be cleaned */
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
+	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
+			0 :
+			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
+	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) + (txq->tx_rs_thresh - 1);
 
-	/* Check to make sure the last descriptor to clean is done */
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	status = txr[desc_to_clean_to].wb.status;
+	uint32_t status = txr[txq->rs_last_id[rs_idx]].wb.status;
 	if (!(status & rte_cpu_to_le_32(IXGBE_TXD_STAT_DD))) {
 		PMD_TX_LOG(DEBUG,
 			   "TX descriptor %4u is not done"
 			   "(port=%d queue=%d)",
-			   desc_to_clean_to,
+			   txq->rs_last_id[rs_idx],
 			   txq->port_id, txq->queue_id);
 		/* Failed to clean any descriptors, better luck next time */
 		return -(1);
 	}
 
-	/* Figure out how many descriptors will be cleaned */
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) +
-							desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
-						last_desc_cleaned);
-
 	PMD_TX_LOG(DEBUG,
 		   "Cleaning %4u TX descriptors: %4u to %4u "
 		   "(port=%d queue=%d)",
-		   nb_tx_to_clean, last_desc_cleaned, desc_to_clean_to,
+		   txq->tx_rs_thresh, last_desc_cleaned, desc_to_clean_to,
 		   txq->port_id, txq->queue_id);
 
-	/*
-	 * The last descriptor to clean is done, so that means all the
-	 * descriptors from the last descriptor that was cleaned
-	 * up to the last descriptor with the RS bit set
-	 * are done. Only reset the threshold descriptor.
-	 */
-	txr[desc_to_clean_to].wb.status = 0;
-
 	/* Update the txq to reflect the last descriptor that was cleaned */
 	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
 
 	/* No Error */
 	return 0;
@@ -749,6 +728,9 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		if (tx_last >= txq->nb_tx_desc)
 			tx_last = (uint16_t) (tx_last - txq->nb_tx_desc);
 
+		/* Track the RS threshold bucket at packet start */
+		uint16_t pkt_rs_idx = (uint16_t)(tx_id >> txq->log2_rs_thresh);
+
 		PMD_TX_LOG(DEBUG, "port_id=%u queue_id=%u pktlen=%u"
 			   " tx_first=%u tx_last=%u",
 			   (unsigned) txq->port_id,
@@ -876,7 +858,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 					tx_offload,
 					rte_security_dynfield(tx_pkt));
 
-				txe->last_id = tx_last;
 				tx_id = txe->next_id;
 				txe = txn;
 			}
@@ -922,7 +903,6 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				rte_cpu_to_le_32(cmd_type_len | slen);
 			txd->read.olinfo_status =
 				rte_cpu_to_le_32(olinfo_status);
-			txe->last_id = tx_last;
 			tx_id = txe->next_id;
 			txe = txn;
 			m_seg = m_seg->next;
@@ -935,8 +915,18 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 
-		/* Set RS bit only on threshold packets' last descriptor */
-		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
+		/*
+		 * Check if packet crosses into a new RS threshold bucket.
+		 * The RS bit is set on the last descriptor when we move from one bucket to another.
+		 * For example, with tx_rs_thresh=32 and a 5-descriptor packet using slots 30-34:
+		 *   - pkt_rs_idx = 30 >> 5 = 0 (started in bucket 0)
+		 *   - tx_last = 34, so 35 >> 5 = 1 (next packet is in bucket 1)
+		 *   - Since 0 != 1, set RS bit on descriptor 34, and record rs_last_id[0] = 34
+		 */
+		uint16_t next_rs_idx = ((tx_last + 1) >> txq->log2_rs_thresh);
+
+		if (next_rs_idx != pkt_rs_idx) {
+			/* Packet crossed into a new bucket - set RS bit on last descriptor */
 			PMD_TX_LOG(DEBUG,
 				   "Setting RS bit on TXD id="
 				   "%4u (port=%d queue=%d)",
@@ -944,9 +934,8 @@ ixgbe_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 			cmd_type_len |= IXGBE_TXD_CMD_RS;
 
-			/* Update txq RS bit counters */
-			txq->nb_tx_used = 0;
-			txp = NULL;
+			/* Record the last descriptor ID for the bucket we're leaving */
+			txq->rs_last_id[pkt_rs_idx] = tx_last;
 		} else
 			txp = txd;
 
@@ -2521,6 +2510,7 @@ ixgbe_tx_queue_release(struct ci_tx_queue *txq)
 	if (txq != NULL && txq->ops != NULL) {
 		ci_txq_release_all_mbufs(txq, false);
 		txq->ops->free_swring(txq);
+		rte_free(txq->rs_last_id);
 		rte_memzone_free(txq->mz);
 		rte_free(txq);
 	}
@@ -2825,6 +2815,13 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 			     (int)dev->data->port_id, (int)queue_idx);
 		return -(EINVAL);
 	}
+	if (!rte_is_power_of_2(tx_rs_thresh)) {
+		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2. (tx_rs_thresh=%u port=%d queue=%d)",
+			     (unsigned int)tx_rs_thresh,
+			     (int)dev->data->port_id,
+			     (int)queue_idx);
+		return -(EINVAL);
+	}
 
 	/*
 	 * If rs_bit_thresh is greater than 1, then TX WTHRESH should be
@@ -2870,6 +2867,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->mz = tz;
 	txq->nb_tx_desc = nb_desc;
 	txq->tx_rs_thresh = tx_rs_thresh;
+	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->pthresh = tx_conf->tx_thresh.pthresh;
 	txq->hthresh = tx_conf->tx_thresh.hthresh;
@@ -2913,6 +2911,16 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	PMD_INIT_LOG(DEBUG, "sw_ring=%p hw_ring=%p dma_addr=0x%"PRIx64,
 		     txq->sw_ring, txq->ixgbe_tx_ring, txq->tx_ring_dma);
 
+	/* Allocate RS last_id tracking array */
+	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->rs_last_id == NULL) {
+		ixgbe_tx_queue_release(txq);
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id array");
+		return -ENOMEM;
+	}
+
 	/* set up vector or scalar TX function as appropriate */
 	ixgbe_set_tx_function(dev, txq);
 
-- 
2.51.0

