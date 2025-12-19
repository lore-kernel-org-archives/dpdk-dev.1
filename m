Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D811EE66880
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:26:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AA2440615;
	Fri, 19 Dec 2025 18:26:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4636D4064C
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165173; x=1797701173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z89i3zBX+05+JG4wcz0aAq7yiNe+GoNmCSmpy+J+snU=;
 b=BPsFR0dMNCKAyTyIvzEpqPdBIbnOQs6loR4dSQSe57vmgyRcPx6zcJIt
 A5UTuukIwPaWGFBENj4h+IzfL+Uaw6t+2/e/2A98t2wQCXIB6VgTgP4oM
 l24zECecOTUcTPAHGFo32CVEFQj3nN2YXk6plhPXVfhzvvQJkwgmQMLzZ
 Y0mzlvAj/z38Ug4hmAlJs4TplzgVlLmC2b0tPjqM6ktl6zxNKBAkVaY/Q
 vToj1SvsXuVkq7n9KJSf+0GlhC/Z06vmZI55tX91887/Oojd0Kv1mWhQ/
 gDVQeeo8N84ntyaGnk3Z4HTyzoelWBbJh3XF1ZwW9h0rhzPDpUBgUwSTu Q==;
X-CSE-ConnectionGUID: BfiCD+mtSNSF2KNBE2ivMg==
X-CSE-MsgGUID: b1f9C4V6RZ6B41pftwrl2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759466"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759466"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:12 -0800
X-CSE-ConnectionGUID: 4r7vPmLlSXWxo62Ksiiv5A==
X-CSE-MsgGUID: jdofG1lmS8ucpDnFTDwCzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170400"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [RFC PATCH 03/27] net/intel: create common post-Tx cleanup function
Date: Fri, 19 Dec 2025 17:25:20 +0000
Message-ID: <20251219172548.2660777-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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

The code used in ice, iavf, idpf and i40e for doing cleanup of mbufs
after they had been transmitted was identical. Therefore deduplicate it
by moving to common and remove the driver-specific versions.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h             | 53 ++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 49 ++----------------
 drivers/net/intel/iavf/iavf_rxtx.c        | 50 ++-----------------
 drivers/net/intel/ice/ice_rxtx.c          | 60 ++---------------------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 46 ++---------------
 5 files changed, 71 insertions(+), 187 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index a9ff3bebd5..5b87c15da0 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -249,6 +249,59 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 	return txq->tx_rs_thresh;
 }
 
+/*
+ * Common transmit descriptor cleanup function for Intel drivers.
+ * Used by ice, i40e, iavf, and idpf drivers.
+ *
+ * Returns:
+ *   0 on success
+ *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
+ */
+static __rte_always_inline int
+ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
+{
+	struct ci_tx_entry *sw_ring = txq->sw_ring;
+	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
+	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
+	uint16_t nb_tx_desc = txq->nb_tx_desc;
+	uint16_t desc_to_clean_to;
+	uint16_t nb_tx_to_clean;
+
+	/* Determine the last descriptor needing to be cleaned */
+	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
+	if (desc_to_clean_to >= nb_tx_desc)
+		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
+
+	/* Check to make sure the last descriptor to clean is done */
+	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
+
+	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
+	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(0xFUL)) !=
+			rte_cpu_to_le_64(0xFUL)) {
+		/* Descriptor not yet processed by hardware */
+		return -1;
+	}
+
+	/* Figure out how many descriptors will be cleaned */
+	if (last_desc_cleaned > desc_to_clean_to)
+		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) + desc_to_clean_to);
+	else
+		nb_tx_to_clean = (uint16_t)(desc_to_clean_to - last_desc_cleaned);
+
+	/* The last descriptor to clean is done, so that means all the
+	 * descriptors from the last descriptor that was cleaned
+	 * up to the last descriptor with the RS bit set
+	 * are done. Only reset the threshold descriptor.
+	 */
+	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
+
+	/* Update the txq to reflect the last descriptor that was cleaned */
+	txq->last_desc_cleaned = desc_to_clean_to;
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
+
+	return 0;
+}
+
 static inline void
 ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
 {
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2af3098f81..880013a515 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -380,45 +380,6 @@ i40e_build_ctob(uint32_t td_cmd,
 			((uint64_t)td_tag  << I40E_TXD_QW1_L2TAG1_SHIFT));
 }
 
-static inline int
-i40e_xmit_cleanup(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=
-			rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE)) {
-		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
-			   "(port=%d queue=%d)", desc_to_clean_to,
-			   txq->port_id, txq->queue_id);
-		return -1;
-	}
-
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) +
-							desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
-					last_desc_cleaned);
-
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
-	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-
-	return 0;
-}
-
 static inline int
 #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
 check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
@@ -1114,7 +1075,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)i40e_xmit_cleanup(txq);
+		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		td_cmd = 0;
@@ -1155,14 +1116,14 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
 		if (nb_used > txq->nb_tx_free) {
-			if (i40e_xmit_cleanup(txq) != 0) {
+			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
 				goto end_of_tx;
 			}
 			if (unlikely(nb_used > txq->tx_rs_thresh)) {
 				while (nb_used > txq->nb_tx_free) {
-					if (i40e_xmit_cleanup(txq) != 0) {
+					if (ci_tx_xmit_cleanup(txq) != 0) {
 						if (nb_tx == 0)
 							return 0;
 						goto end_of_tx;
@@ -2794,7 +2755,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_last = txq->tx_tail;
 	tx_id  = swr_ring[tx_last].next_id;
 
-	if (txq->nb_tx_free == 0 && i40e_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -2828,7 +2789,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			break;
 
 		if (pkt_cnt < free_cnt) {
-			if (i40e_xmit_cleanup(txq))
+			if (ci_tx_xmit_cleanup(txq))
 				break;
 
 			nb_tx_to_clean = txq->nb_tx_free - nb_tx_free_last;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 2ed778a872..4605523673 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2325,46 +2325,6 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
 	return nb_rx;
 }
 
-static inline int
-iavf_xmit_cleanup(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
-			rte_cpu_to_le_64(IAVF_TXD_QW1_DTYPE_MASK)) !=
-			rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE)) {
-		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
-			   "(port=%d queue=%d)", desc_to_clean_to,
-			   txq->port_id, txq->queue_id);
-		return -1;
-	}
-
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) +
-							desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
-					last_desc_cleaned);
-
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
-	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-
-	return 0;
-}
-
 /* Check if the context descriptor is needed for TX offloading */
 static inline uint16_t
 iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
@@ -2769,7 +2729,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		iavf_xmit_cleanup(txq);
+		ci_tx_xmit_cleanup(txq);
 
 	desc_idx = txq->tx_tail;
 	txe = &txe_ring[desc_idx];
@@ -2824,14 +2784,14 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			txq->port_id, txq->queue_id, desc_idx, desc_idx_last);
 
 		if (nb_desc_required > txq->nb_tx_free) {
-			if (iavf_xmit_cleanup(txq)) {
+			if (ci_tx_xmit_cleanup(txq)) {
 				if (idx == 0)
 					return 0;
 				goto end_of_tx;
 			}
 			if (unlikely(nb_desc_required > txq->tx_rs_thresh)) {
 				while (nb_desc_required > txq->nb_tx_free) {
-					if (iavf_xmit_cleanup(txq)) {
+					if (ci_tx_xmit_cleanup(txq)) {
 						if (idx == 0)
 							return 0;
 						goto end_of_tx;
@@ -4342,7 +4302,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_id = txq->tx_tail;
 	tx_last = tx_id;
 
-	if (txq->nb_tx_free == 0 && iavf_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -4374,7 +4334,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			break;
 
 		if (pkt_cnt < free_cnt) {
-			if (iavf_xmit_cleanup(txq))
+			if (ci_tx_xmit_cleanup(txq))
 				break;
 
 			nb_tx_to_clean = txq->nb_tx_free - nb_tx_free_last;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 4aded194ce..0a6ca993c6 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3015,56 +3015,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
 	}
 }
 
-static inline int
-ice_xmit_cleanup(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	/* Determine the last descriptor needing to be cleaned */
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	/* Check to make sure the last descriptor to clean is done */
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if (!(txd[desc_to_clean_to].cmd_type_offset_bsz &
-	    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))) {
-		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
-			   "(port=%d queue=%d) value=0x%"PRIx64,
-			   desc_to_clean_to,
-			   txq->port_id, txq->queue_id,
-			   txd[desc_to_clean_to].cmd_type_offset_bsz);
-		/* Failed to clean any descriptors */
-		return -1;
-	}
-
-	/* Figure out how many descriptors will be cleaned */
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) +
-					    desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
-					    last_desc_cleaned);
-
-	/* The last descriptor to clean is done, so that means all the
-	 * descriptors from the last descriptor that was cleaned
-	 * up to the last descriptor with the RS bit set
-	 * are done. Only reset the threshold descriptor.
-	 */
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
-	/* Update the txq to reflect the last descriptor that was cleaned */
-	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-
-	return 0;
-}
-
 /* Construct the tx flags */
 static inline uint64_t
 ice_build_ctob(uint32_t td_cmd,
@@ -3172,7 +3122,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)ice_xmit_cleanup(txq);
+		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = *tx_pkts++;
@@ -3209,14 +3159,14 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
 
 		if (nb_used > txq->nb_tx_free) {
-			if (ice_xmit_cleanup(txq) != 0) {
+			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
 				goto end_of_tx;
 			}
 			if (unlikely(nb_used > txq->tx_rs_thresh)) {
 				while (nb_used > txq->nb_tx_free) {
-					if (ice_xmit_cleanup(txq) != 0) {
+					if (ci_tx_xmit_cleanup(txq) != 0) {
 						if (nb_tx == 0)
 							return 0;
 						goto end_of_tx;
@@ -3446,7 +3396,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_last = txq->tx_tail;
 	tx_id  = swr_ring[tx_last].next_id;
 
-	if (txq->nb_tx_free == 0 && ice_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -3480,7 +3430,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			break;
 
 		if (pkt_cnt < free_cnt) {
-			if (ice_xmit_cleanup(txq))
+			if (ci_tx_xmit_cleanup(txq))
 				break;
 
 			nb_tx_to_clean = txq->nb_tx_free - nb_tx_free_last;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 51074bda3a..23666539ab 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1326,46 +1326,6 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return nb_rx;
 }
 
-static inline int
-idpf_xmit_cleanup(struct ci_tx_queue *txq)
-{
-	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
-	struct ci_tx_entry *sw_ring = txq->sw_ring;
-	uint16_t nb_tx_desc = txq->nb_tx_desc;
-	uint16_t desc_to_clean_to;
-	uint16_t nb_tx_to_clean;
-
-	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
-
-	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
-	if (desc_to_clean_to >= nb_tx_desc)
-		desc_to_clean_to = (uint16_t)(desc_to_clean_to - nb_tx_desc);
-
-	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
-	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
-	     rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
-	    rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE)) {
-		TX_LOG(DEBUG, "TX descriptor %4u is not done "
-		       "(port=%d queue=%d)", desc_to_clean_to,
-		       txq->port_id, txq->queue_id);
-		return -1;
-	}
-
-	if (last_desc_cleaned > desc_to_clean_to)
-		nb_tx_to_clean = (uint16_t)((nb_tx_desc - last_desc_cleaned) +
-					    desc_to_clean_to);
-	else
-		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
-					    last_desc_cleaned);
-
-	txd[desc_to_clean_to].cmd_type_offset_bsz = 0;
-
-	txq->last_desc_cleaned = desc_to_clean_to;
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
-
-	return 0;
-}
-
 /* TX function */
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts)
 uint16_t
@@ -1404,7 +1364,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)idpf_xmit_cleanup(txq);
+		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		td_cmd = 0;
@@ -1437,14 +1397,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		       txq->port_id, txq->queue_id, tx_id, tx_last);
 
 		if (nb_used > txq->nb_tx_free) {
-			if (idpf_xmit_cleanup(txq) != 0) {
+			if (ci_tx_xmit_cleanup(txq) != 0) {
 				if (nb_tx == 0)
 					return 0;
 				goto end_of_tx;
 			}
 			if (unlikely(nb_used > txq->tx_rs_thresh)) {
 				while (nb_used > txq->nb_tx_free) {
-					if (idpf_xmit_cleanup(txq) != 0) {
+					if (ci_tx_xmit_cleanup(txq) != 0) {
 						if (nb_tx == 0)
 							return 0;
 						goto end_of_tx;
-- 
2.51.0

