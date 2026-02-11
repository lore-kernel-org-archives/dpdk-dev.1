Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C718ECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:13:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3010440679;
	Wed, 11 Feb 2026 19:13:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2FD25406B6
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833614; x=1802369614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gj9y0pT30WTIWbpN41UvDHRLJD/eTeTwWv1TTatrXp4=;
 b=ZDh33mEa+7qIBnOrDEOM3PX93RP0iK3WgDh1rypCJNuscVr8McDRufVI
 P46avPcwRBx7yRX4somY7JngX5kgq3LA3Ocs7KfiS20qwwsJgzUOWuiP3
 wApml2ErgD3eIYaj1FOGsHe9G0nymu18QviBS+1VbTenOJqi9OA8zaWHW
 gAWLa8w87MnyLZBjq+2HgrmOvULoQ2KpeRHWOabX9rHzG0msW9zeyN2RV
 RIdk9fNnB/VsOl0/aeGOz/hr5iaQzqnY5lK9zYH51gwmR/DlYUXTayXgY
 6KWdQHMyMMDOPGWitL9M3nJCReoJOE63uPu6DPhAqqxpbh4tILzOj5A/f Q==;
X-CSE-ConnectionGUID: aov8PZv1Qqi0ntqi+JR1Fw==
X-CSE-MsgGUID: xzWW4ZA9RfqR8tdnP+PBNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834656"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834656"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:34 -0800
X-CSE-ConnectionGUID: liSyxMsPSa+vYBZr9bTvEg==
X-CSE-MsgGUID: N41YqxBxSo6cDpi7RUO4eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986269"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 04/35] net/intel: create common post-Tx cleanup function
Date: Wed, 11 Feb 2026 18:12:33 +0000
Message-ID: <20260211181309.2838042-5-bruce.richardson@intel.com>
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

The code used in ice, iavf, idpf and i40e for doing cleanup of mbufs
after they had been transmitted was identical. Therefore deduplicate it
by moving to common and remove the driver-specific versions.

Rather than having all Tx code in the one file, which could start
getting rather long, create a new header file for scalar datapath
functions.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/tx.h             |  5 ++
 drivers/net/intel/common/tx_scalar.h      | 62 +++++++++++++++++++++++
 drivers/net/intel/i40e/i40e_rxtx.c        | 49 ++----------------
 drivers/net/intel/iavf/iavf_rxtx.c        | 50 ++----------------
 drivers/net/intel/ice/ice_rxtx.c          | 60 ++--------------------
 drivers/net/intel/idpf/idpf_common_rxtx.c | 46 ++---------------
 6 files changed, 85 insertions(+), 187 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_scalar.h

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 8cf63e59ab..558c861df0 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -377,4 +377,9 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 	return idx;
 }
 
+/* include the scalar functions at the end, so they can use the common definitions.
+ * This is done so drivers can use all functions just by including tx.h
+ */
+#include "tx_scalar.h"
+
 #endif /* _COMMON_INTEL_TX_H_ */
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
new file mode 100644
index 0000000000..181629d856
--- /dev/null
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_TX_SCALAR_H_
+#define _COMMON_INTEL_TX_SCALAR_H_
+
+#include <stdint.h>
+#include <rte_byteorder.h>
+
+/* depends on common Tx definitions. */
+#include "tx.h"
+
+/*
+ * Common transmit descriptor cleanup function for Intel drivers.
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
+	/* Check if descriptor is done - all drivers use 0xF as done value in bits 3:0 */
+	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
+	if ((txd[desc_to_clean_to].cmd_type_offset_bsz & rte_cpu_to_le_64(0x0FUL)) !=
+			rte_cpu_to_le_64(0x0FUL))
+		return -1;
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
+#endif /* _COMMON_INTEL_TX_SCALAR_H_ */
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

