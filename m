Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F0ACCF9FE
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 03:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3630A40655;
	Mon,  3 Nov 2025 04:26:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id AD2D240647
 for <dev@dpdk.org>; Mon,  3 Nov 2025 04:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762140380; x=1793676380;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ECCDi08S+tBFX9XCe3nf6Sh2PLx3x2W5VBsve16RBuI=;
 b=SKH3jeqBn2+zgZ+cZVqQceFb2ou3/zMtIUJs8hAbxrTGc6wfUf8dDzOG
 fIep9LSjwEjKHsnGZO2mNov7rc9PrJM6NSzWNKkny5I4k1r3ThPXCaB3Z
 X8t64V8NZiFQhn4FvLaxoe12fYxHIffU4qQpqH2xp/NbCI4Nr9VQPQ5lL
 f/q71KJyuNuUFPE106Bhw08rjZL7Fjnxm88XaQF3o1bN/htwHrJKRUlcr
 bdvNlJ4IgjhDPrlMOk/q62vrFitdvxqpeq5jezwY15zLXHiCWGW7cAm2f
 YmV9peqPEFjulHAGNF8URW2jSgwk9R/gODKWTDEeziCKZkfoVcis8fo0f A==;
X-CSE-ConnectionGUID: BauSDtmcTrubB2fuQOsI3w==
X-CSE-MsgGUID: O6Cbqoh5SW6eGj5S7aRb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="86836204"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="86836204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2025 19:26:20 -0800
X-CSE-ConnectionGUID: pFRsR3GzQ+m40t1GnviEoQ==
X-CSE-MsgGUID: Pvu/pv3wS/+14NAgQwZlgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="187481845"
Received: from fenlix-mobl.ccr.corp.intel.com (HELO localhost.intel.com)
 ([10.239.252.5])
 by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2025 19:26:17 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: rajesh3.kumar@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v3 3/4] net/intel: add support for Precision Time Protocol
Date: Mon,  3 Nov 2025 11:06:44 -0500
Message-ID: <20251103160646.140084-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251103160646.140084-1-soumyadeep.hore@intel.com>
References: <20251028060758.233929-1-soumyadeep.hore@intel.com>
 <20251103160646.140084-1-soumyadeep.hore@intel.com>
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

Add support for PTP that contains negotiation with CP to receive a
set of supported functionalities through capabilities,
get/set/adjust the time of the main timer and Tx timestamping
through secondary mailbox dedicated to PTP.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/common/tx.h             |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 186 +++++++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h |  10 +
 drivers/net/intel/idpf/idpf_ethdev.c      | 275 ++++++++++++++++++++++
 4 files changed, 401 insertions(+), 71 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 5af64a4cfe..fe175f7d65 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -113,6 +113,7 @@ struct ci_tx_queue {
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
 				uint8_t expected_gen_id;
+				uint32_t latch_idx; /* Tx timestamp latch index */
 		};
 	};
 };
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a5d0795057..c8cd5b9d5b 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -9,6 +9,7 @@
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
 #include "../common/rx.h"
+#include "idpf_ptp.h"
 
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
@@ -435,58 +436,6 @@ idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
-#define IDPF_TIMESYNC_REG_WRAP_GUARD_BAND  10000
-/* Helper function to convert a 32b nanoseconds timestamp to 64b. */
-static inline uint64_t
-idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
-			    uint32_t in_timestamp)
-{
-#ifdef RTE_ARCH_X86_64
-	struct idpf_hw *hw = &ad->hw;
-	const uint64_t mask = 0xFFFFFFFF;
-	uint32_t hi, lo, lo2, delta;
-	uint64_t ns;
-
-	if (flag != 0) {
-		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
-		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_EXEC_CMD_M |
-			       PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
-		lo = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-		hi = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
-		/*
-		 * On typical system, the delta between lo and lo2 is ~1000ns,
-		 * so 10000 seems a large-enough but not overly-big guard band.
-		 */
-		if (lo > (UINT32_MAX - IDPF_TIMESYNC_REG_WRAP_GUARD_BAND))
-			lo2 = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-		else
-			lo2 = lo;
-
-		if (lo2 < lo) {
-			lo = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-			hi = IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
-		}
-
-		ad->time_hw = ((uint64_t)hi << 32) | lo;
-	}
-
-	delta = (in_timestamp - (uint32_t)(ad->time_hw & mask));
-	if (delta > (mask / 2)) {
-		delta = ((uint32_t)(ad->time_hw & mask) - in_timestamp);
-		ns = ad->time_hw - delta;
-	} else {
-		ns = ad->time_hw + delta;
-	}
-
-	return ns;
-#else /* !RTE_ARCH_X86_64 */
-	RTE_SET_USED(ad);
-	RTE_SET_USED(flag);
-	RTE_SET_USED(in_timestamp);
-	return 0;
-#endif /* RTE_ARCH_X86_64 */
-}
-
 #define IDPF_RX_FLEX_DESC_ADV_STATUS0_XSUM_S				\
 	(RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_IPE_S) |     \
 	 RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_L4E_S) |     \
@@ -655,8 +604,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	rx_desc_ring = rxq->rx_ring;
 	ptype_tbl = rxq->adapter->ptype_tbl;
 
-	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
-		rxq->hw_register_set = 1;
+	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
+		uint64_t sw_cur_time = rte_get_timer_cycles() /
+							(rte_get_timer_hz() / 1000);
+		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
+			rxq->hw_register_set = 1;
+	}
 
 	while (nb_rx < nb_pkts) {
 		rx_desc = &rx_desc_ring[rx_id];
@@ -732,20 +685,38 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
 				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
 				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
+
+		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
+			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
 		pkt_flags = idpf_splitq_rx_csum_offload(status_err0_qw1);
 		pkt_flags |= idpf_splitq_rx_rss_offload(rxm, rx_desc);
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP)) {
 			/* timestamp */
-			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-							    rxq->hw_register_set,
-							    rte_le_to_cpu_32(rx_desc->ts_high));
-			rxq->hw_register_set = 0;
+			rxq->time_high = rte_le_to_cpu_32(rx_desc->ts_high);
+			if (unlikely(rxq->hw_register_set)) {
+				ts_ns = idpf_tstamp_convert_32b_64b(ad,
+							    rxq->hw_register_set, true,
+							    rxq->time_high);
+				rxq->hw_time_low = (uint32_t)ts_ns;
+				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+				rxq->hw_register_set = 0;
+			} else {
+				if (rxq->time_high < rxq->hw_time_low)
+					rxq->hw_time_high += 1;
+				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
+				rxq->hw_time_low = rxq->time_high;
+			}
+			rxq->hw_time_update = rte_get_timer_cycles() /
+						     (rte_get_timer_hz() / 1000);
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			first_seg->ol_flags |= idpf_timestamp_dynflag;
+			if (rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)
+				rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		first_seg->ol_flags |= pkt_flags;
@@ -839,10 +810,34 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 static inline uint16_t
 idpf_calc_context_desc(uint64_t flags)
 {
-	if ((flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
-		return 1;
+	static uint64_t mask = RTE_MBUF_F_TX_TCP_SEG |
+		RTE_MBUF_F_TX_IEEE1588_TMST;
 
-	return 0;
+	return (flags & mask) ? 1 : 0;
+}
+
+/**
+ * idpf_tx_set_tstamp_desc - Set the Tx descriptor fields needed to generate
+ *			     PHY Tx timestamp
+ * @ctx_desc: Context descriptor
+ * @idx: Index of the Tx timestamp latch
+ */
+static inline void
+idpf_tx_set_tstamp_desc(volatile union idpf_flex_tx_ctx_desc *ctx_desc,
+				uint32_t idx)
+{
+	ctx_desc->tsyn.qw1.cmd_dtype =
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_CMD_M,
+				       IDPF_TX_CTX_DESC_TSYN));
+	ctx_desc->tsyn.qw1.cmd_dtype |=
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_DTYPE_M,
+				       IDPF_TX_DESC_DTYPE_CTX));
+	ctx_desc->tsyn.qw1.tsyn_reg_l =
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_L_M,
+				       idx));
+	ctx_desc->tsyn.qw1.tsyn_reg_h =
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_H_M,
+				       idx >> 2));
 }
 
 /* set TSO context descriptor
@@ -948,6 +943,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
 							ctx_desc);
 
+			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) != 0)
+				idpf_tx_set_tstamp_desc(ctx_desc, txq->latch_idx);
+
 			tx_id++;
 			if (tx_id == txq->nb_tx_desc)
 				tx_id = 0;
@@ -1104,8 +1102,12 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	rx_ring = rxq->rx_ring;
 	ptype_tbl = rxq->adapter->ptype_tbl;
 
-	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
-		rxq->hw_register_set = 1;
+	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
+		uint64_t sw_cur_time = rte_get_timer_cycles() /
+							(rte_get_timer_hz() / 1000);
+		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
+			rxq->hw_register_set = 1;
+	}
 
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
@@ -1167,17 +1169,33 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		rxm->ol_flags |= pkt_flags;
 
+		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
+			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
 			/* timestamp */
-			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-					    rxq->hw_register_set,
-					    rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
-			rxq->hw_register_set = 0;
+			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
+			if (unlikely(rxq->hw_register_set)) {
+				ts_ns = idpf_tstamp_convert_32b_64b(ad,
+							    rxq->hw_register_set, true,
+							    rxq->time_high);
+				rxq->hw_time_low = (uint32_t)ts_ns;
+				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+				rxq->hw_register_set = 0;
+			} else {
+				if (rxq->time_high < rxq->hw_time_low)
+					rxq->hw_time_high += 1;
+				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
+				rxq->hw_time_low = rxq->time_high;
+			}
+			rxq->hw_time_update = rte_get_timer_cycles() /
+						     (rte_get_timer_hz() / 1000);
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			rxm->ol_flags |= idpf_timestamp_dynflag;
+			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		rx_pkts[nb_rx++] = rxm;
@@ -1218,6 +1236,13 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	if (unlikely(!rxq) || unlikely(!rxq->q_started))
 		return nb_rx;
 
+	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
+		uint64_t sw_cur_time = rte_get_timer_cycles() /
+							(rte_get_timer_hz() / 1000);
+		if (unlikely(sw_cur_time - rxq->hw_time_update > 4))
+			rxq->hw_register_set = 1;
+	}
+
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
 		rx_status0 = rte_le_to_cpu_16(rxdp->flex_nic_wb.status_error0);
@@ -1298,17 +1323,33 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			ptype_tbl[(uint8_t)(rte_cpu_to_le_16(rxd.flex_nic_wb.ptype_flex_flags0) &
 				VIRTCHNL2_RX_FLEX_DESC_PTYPE_M)];
 
+		if ((first_seg->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
+			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
 			/* timestamp */
-			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-				rxq->hw_register_set,
-				rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
-			rxq->hw_register_set = 0;
+			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
+			if (unlikely(rxq->hw_register_set)) {
+				ts_ns = idpf_tstamp_convert_32b_64b(ad,
+							    rxq->hw_register_set, true,
+							    rxq->time_high);
+				rxq->hw_time_low = (uint32_t)ts_ns;
+				rxq->hw_time_high = (uint32_t)(ts_ns >> 32);
+				rxq->hw_register_set = 0;
+			} else {
+				if (rxq->time_high < rxq->hw_time_low)
+					rxq->hw_time_high += 1;
+				ts_ns = (uint64_t)rxq->hw_time_high << 32 | rxq->time_high;
+				rxq->hw_time_low = rxq->time_high;
+			}
+			rxq->hw_time_update = rte_get_timer_cycles() /
+						     (rte_get_timer_hz() / 1000);
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			first_seg->ol_flags |= idpf_timestamp_dynflag;
+			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		first_seg->ol_flags |= pkt_flags;
@@ -1474,6 +1515,9 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
 							ctx_txd);
 
+			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) != 0)
+				idpf_tx_set_tstamp_desc(ctx_txd, txq->latch_idx);
+
 			txe->last_id = tx_last;
 			tx_id = txe->next_id;
 			txe = txn;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 3bc3323af4..f0812befc5 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -13,6 +13,12 @@
 #include "../common/tx.h"
 #include "../common/rx.h"
 
+#define FIELD_PREP(_mask, _val) \
+	(__extension__ ({ \
+		typeof(_mask) _x = (_mask); \
+		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
+	}))
+
 #define IDPF_RX_MAX_BURST		32
 
 #define IDPF_RX_OFFLOAD_IPV4_CKSUM		RTE_BIT64(1)
@@ -156,6 +162,10 @@ struct idpf_rx_queue {
 
 	uint64_t offloads;
 	uint32_t hw_register_set;
+	uint32_t time_high; /* high 32 bits of hardware timestamp register */
+	uint32_t hw_time_high; /* high 32 bits of timestamp */
+	uint32_t hw_time_low; /* low 32 bits of timestamp */
+	uint64_t hw_time_update; /* Last time HW timestamp was updated */
 };
 
 /* Offload features */
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5d786fbba6..22b7a1093c 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
+#include <math.h>
+
 #include <rte_atomic.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
@@ -14,6 +16,7 @@
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
 #include "../common/tx.h"
+#include "idpf_ptp.h"
 
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
@@ -841,6 +844,270 @@ idpf_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+idpf_timesync_enable(struct rte_eth_dev *dev)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	struct timespec sys_ts;
+	uint64_t ns;
+	int ret = 0, q_id = 0;
+
+	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
+	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
+		return -1;
+	}
+
+	adapter->ptp = rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
+	if (adapter->ptp == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
+		return -ENOMEM;
+	}
+
+	ret = idpf_ptp_get_caps(adapter);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=%d", ret);
+		goto err_ptp;
+	}
+	/* Write the default increment time value if the clock adjustments
+	 * are enabled.
+	 */
+	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
+		ret = idpf_ptp_adj_dev_clk_fine(adapter,
+						adapter->ptp->base_incval);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set incval failed, err=%d", ret);
+			goto err_ptp;
+		}
+	}
+
+	/* Do not initialize the PTP if the device clock time cannot be read. */
+	if (adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
+		PMD_DRV_LOG(ERR, "Getting device clock time is not supported");
+		ret = -EIO;
+		goto err_ptp;
+	}
+
+	/* Set the device clock time to system time. */
+	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
+		clock_gettime(CLOCK_REALTIME, &sys_ts);
+		ns = rte_timespec_to_ns(&sys_ts);
+		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err=%d", ret);
+			goto err_ptp;
+		}
+	}
+
+	ret = idpf_ptp_get_vport_tstamps_caps(vport);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get vport timestamp capabilities, err=%d", ret);
+		goto err_ptp;
+	}
+
+	for (q_id = 0; q_id < dev->data->nb_tx_queues; q_id++) {
+		struct ci_tx_queue *txq = dev->data->tx_queues[q_id];
+		txq->latch_idx = vport->tx_tstamp_caps->tx_tstamp[q_id].idx;
+	}
+
+	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
+	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
+
+err_ptp:
+	if (ret != 0) {
+		rte_free(adapter->ptp);
+		adapter->ptp = NULL;
+	}
+	return ret;
+}
+
+static int
+idpf_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
+						struct timespec *timestamp,
+						uint32_t flags)
+{
+	struct idpf_rx_queue *rxq;
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	uint64_t ts_ns;
+
+	rxq = dev->data->rx_queues[flags];
+
+	ts_ns = idpf_tstamp_convert_32b_64b(adapter, 1, true, rxq->time_high);
+	*timestamp = rte_ns_to_timespec(ts_ns);
+
+	return 0;
+}
+
+static int
+idpf_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
+			       struct timespec *timestamp)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	uint16_t latch_idx;
+	uint64_t ts_ns, tstamp;
+	int ret = 0;
+
+	ret = idpf_ptp_get_tx_tstamp(vport);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get TX timestamp");
+		return ret;
+	}
+
+	latch_idx = vport->tx_tstamp_caps->latched_idx;
+	tstamp = vport->tx_tstamp_caps->tx_tstamp[latch_idx].tstamp;
+	ts_ns = idpf_tstamp_convert_32b_64b(vport->adapter, 0, false, tstamp);
+
+	/* Convert to timespec */
+	*timestamp = rte_ns_to_timespec(ts_ns);
+
+	vport->tx_tstamp_caps->latched_idx = -1;
+
+	return 0;
+}
+
+static int
+idpf_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_ptp *ptp = adapter->ptp;
+	uint64_t time, ns;
+	int ret = 0;
+
+	if (ptp->adj_dev_clk_time_access != IDPF_PTP_MAILBOX) {
+		PMD_DRV_LOG(ERR, "Adjusting device clock time is not supported");
+		return -ENOTSUP;
+	}
+
+	if (delta > INT32_MAX || delta < INT32_MIN) {
+		ret = idpf_ptp_read_src_clk_reg(adapter, &time);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP read clock time failed, err %d", ret);
+			return ret;
+		}
+
+		ns = time + delta;
+
+		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret)
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err %d", ret);
+
+		return ret;
+	}
+
+	ret = idpf_ptp_adj_dev_clk_time(adapter, delta);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP adjusting clock failed, err %d", ret);
+
+	return ret;
+}
+
+static int
+idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	struct idpf_ptp *ptp = adapter->ptp;
+	int64_t incval, diff = 0;
+	bool negative = false;
+	uint64_t div, rem;
+	uint64_t divisor = 1000000ULL << 16;
+	int shift;
+	int ret = 0;
+
+	incval = ptp->base_incval;
+
+	if (ppm < 0) {
+		negative = true;
+		ppm = -ppm;
+	}
+
+	/* can incval * ppm overflow ? */
+	if (log2(incval) + log2(ppm) > 62) {
+		rem = ppm % divisor;
+		div = ppm / divisor;
+		diff = div * incval;
+		ppm = rem;
+
+		shift = log2(incval) + log2(ppm) - 62;
+		if (shift > 0) {
+			/* drop precision */
+			ppm >>= shift;
+			divisor >>= shift;
+		}
+	}
+
+	if (divisor)
+		diff = diff + incval * ppm / divisor;
+
+	if (negative)
+		incval -= diff;
+	else
+		incval += diff;
+
+	ret = idpf_ptp_adj_dev_clk_fine(adapter, incval);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int
+idpf_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	uint64_t ns;
+	int ret = 0;
+
+	ns = rte_timespec_to_ns(ts);
+	ret = idpf_ptp_set_dev_clk_time(adapter, ns);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP write time failed, err %d", ret);
+
+	return ret;
+}
+
+static int
+idpf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	uint64_t time;
+	int ret = 0;
+
+	ret = idpf_ptp_read_src_clk_reg(adapter, &time);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
+	else
+		*ts = rte_ns_to_timespec(time);
+
+	return ret;
+}
+
+static int
+idpf_timesync_disable(struct rte_eth_dev *dev)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+
+	if (vport->tx_tstamp_caps) {
+		rte_free(vport->tx_tstamp_caps);
+		vport->tx_tstamp_caps = NULL;
+	}
+
+	if (adapter->ptp) {
+		rte_free(adapter->ptp);
+		adapter->ptp = NULL;
+	}
+
+	return 0;
+}
+
+
 static const struct eth_dev_ops idpf_eth_dev_ops = {
 	.dev_configure			= idpf_dev_configure,
 	.dev_close			= idpf_dev_close,
@@ -867,6 +1134,14 @@ static const struct eth_dev_ops idpf_eth_dev_ops = {
 	.xstats_get			= idpf_dev_xstats_get,
 	.xstats_get_names		= idpf_dev_xstats_get_names,
 	.xstats_reset			= idpf_dev_xstats_reset,
+	.timesync_enable              = idpf_timesync_enable,
+	.timesync_read_rx_timestamp   = idpf_timesync_read_rx_timestamp,
+	.timesync_read_tx_timestamp   = idpf_timesync_read_tx_timestamp,
+	.timesync_adjust_time         = idpf_timesync_adjust_time,
+	.timesync_adjust_freq         = idpf_timesync_adjust_freq,
+	.timesync_read_time           = idpf_timesync_read_time,
+	.timesync_write_time          = idpf_timesync_write_time,
+	.timesync_disable             = idpf_timesync_disable,
 };
 
 static int
-- 
2.47.1

