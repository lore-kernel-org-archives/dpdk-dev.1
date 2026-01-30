Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E0BE6BF03
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0583402DC;
	Fri, 30 Jan 2026 12:42:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 83D5340609
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769773342; x=1801309342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1XA9Ty9wT9eGk0P1ZAPIEUrNXmaeoXHiQK4Am2SFh4I=;
 b=b8cXKibTmScIiWzrreDFBriyyk0pvYzH1xMYzUnYFgf4sJiUhhVsQ1j+
 DjvP2bX/8jqaP1IHCMu/LaJf75INjtHsGtN1h+IX6REWWdt2OIv7A4paq
 LFJ9uTRb7WwaVjxo1UENfvPGNu5plm9GgOYZw/x2qh47//w8OVroUbrq/
 MtNhAgbyWpabG7U7EDTYIxH64XxZQitsF+tAqu/G+v86DnaxO4wIW9AJB
 X3ycMlS1QY6Gl5+PSUvxjEf66Z/hsx6sfOJjz1OtMOfOkmoNxqMr7/3cl
 IHohNDOAa/t6HOaQ9QTmIAnG8/NG3PrKinlVV4YbSreUJaQhh8Vo7lG+Y g==;
X-CSE-ConnectionGUID: x/DMQbb/RnWxj1ubopBHSQ==
X-CSE-MsgGUID: H7RD9kDoRySdgmr1GRfOOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82392266"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="82392266"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:42:22 -0800
X-CSE-ConnectionGUID: 6KUvd/sYQ+mneTNRSAp4aQ==
X-CSE-MsgGUID: coOmPRoMS9i8bLpGUISkeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="209190440"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jan 2026 03:42:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v3 03/36] net/intel: create common post-Tx cleanup function
Date: Fri, 30 Jan 2026 11:41:30 +0000
Message-ID: <20260130114207.1126032-4-bruce.richardson@intel.com>
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
index 8cf63e59ab..a89412c195 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -259,6 +259,59 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
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
index 210fc0201e..2760e76e99 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -384,45 +384,6 @@ i40e_build_ctob(uint32_t td_cmd,
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
@@ -1118,7 +1079,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)i40e_xmit_cleanup(txq);
+		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		td_cmd = 0;
@@ -1159,14 +1120,14 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -2808,7 +2769,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_last = txq->tx_tail;
 	tx_id  = swr_ring[tx_last].next_id;
 
-	if (txq->nb_tx_free == 0 && i40e_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -2842,7 +2803,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			break;
 
 		if (pkt_cnt < free_cnt) {
-			if (i40e_xmit_cleanup(txq))
+			if (ci_tx_xmit_cleanup(txq))
 				break;
 
 			nb_tx_to_clean = txq->nb_tx_free - nb_tx_free_last;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 807bc92a45..560abfc1ef 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2324,46 +2324,6 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
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
@@ -2768,7 +2728,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		iavf_xmit_cleanup(txq);
+		ci_tx_xmit_cleanup(txq);
 
 	desc_idx = txq->tx_tail;
 	txe = &txe_ring[desc_idx];
@@ -2823,14 +2783,14 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -4300,7 +4260,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_id = txq->tx_tail;
 	tx_last = tx_id;
 
-	if (txq->nb_tx_free == 0 && iavf_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -4332,7 +4292,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
 			break;
 
 		if (pkt_cnt < free_cnt) {
-			if (iavf_xmit_cleanup(txq))
+			if (ci_tx_xmit_cleanup(txq))
 				break;
 
 			nb_tx_to_clean = txq->nb_tx_free - nb_tx_free_last;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index e3ffbdb587..7a33e1e980 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3023,56 +3023,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
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
@@ -3180,7 +3130,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		(void)ice_xmit_cleanup(txq);
+		(void)ci_tx_xmit_cleanup(txq);
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = *tx_pkts++;
@@ -3217,14 +3167,14 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -3459,7 +3409,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
 	tx_last = txq->tx_tail;
 	tx_id  = swr_ring[tx_last].next_id;
 
-	if (txq->nb_tx_free == 0 && ice_xmit_cleanup(txq))
+	if (txq->nb_tx_free == 0 && ci_tx_xmit_cleanup(txq))
 		return 0;
 
 	nb_tx_to_clean = txq->nb_tx_free;
@@ -3493,7 +3443,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
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

