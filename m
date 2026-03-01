Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C7BFEE4FE
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 20:35:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 813B840DD7;
	Sat, 28 Feb 2026 21:34:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3982740BA6
 for <dev@dpdk.org>; Sat, 28 Feb 2026 21:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772310894; x=1803846894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SW+3RCfpIZCMs1xMWKz+A3HFbnXGgFj6Oh357s8bUR0=;
 b=ZWBYLPFSUR1c1dtCJhrQ7h6dT0ulJDlgHSOxexlwvjkREXjdQy8nmMrw
 rpiRqpg1LBit6+pEdCYilCHTrBjOn+5QUG1S+n9uF0ZIodHEVihxqOWy7
 c0kW9R232lf44m7P6waKTyz37clXibMJb8VO4tGaChvboHEWu5LJsvSGn
 kyCHc5O67eGo0DW+qEZZTQnOBIYjbXwj8xEvBN6Gezhf+elyeWBqQmn1Y
 gU6hhNDiMVdHA5O2V8593LqC521J6PJkb0/ZtFW+Z7/lcHGQPSroH6Sq3
 wFCCC1bHX0Rtutn/KPUfHzKFaO/EYWPygDgwOoHNUxK/wgN3m/1DuWwxq w==;
X-CSE-ConnectionGUID: kxPYqPmSQL2SSzDYju7Syw==
X-CSE-MsgGUID: hiJMw9yQR1uFNQkmwzWzPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84002133"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="84002133"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2026 12:34:53 -0800
X-CSE-ConnectionGUID: yMgq6w4xTIeEhc9AZkYOWA==
X-CSE-MsgGUID: 2cGDXsM1Q7mqWFvsbJ4rqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; d="scan'208";a="220401543"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2026 12:34:51 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v8 3/4] net/idpf: add timesync support
Date: Sun,  1 Mar 2026 04:10:39 -0500
Message-ID: <20260301091040.10647-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260301091040.10647-1-soumyadeep.hore@intel.com>
References: <20260227003314.439267-5-soumyadeep.hore@intel.com>
 <20260301091040.10647-1-soumyadeep.hore@intel.com>
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

Add timesync support including:
- Capability negotiation with the Control Plane
to determine supported PTP features.
- Get/set/adjust operations on the main device
clock.
- Tx timestamping support using a PTP-dedicated
secondary mailbox.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Acked-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 drivers/net/intel/common/tx.h             |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 126 ++++------
 drivers/net/intel/idpf/idpf_common_rxtx.h |   7 +
 drivers/net/intel/idpf/idpf_ethdev.c      | 270 ++++++++++++++++++++++
 4 files changed, 329 insertions(+), 75 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 8fec8d7909..283bd58d5d 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -216,6 +216,7 @@ struct ci_tx_queue {
 				struct ci_tx_queue *complq;
 				void **txqs;   /*only valid for split queue mode*/
 				uint32_t tx_start_qid;
+				uint32_t latch_idx; /* Tx timestamp latch index */
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index b8f6418d4a..ec020d4910 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -9,6 +9,7 @@
 
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
+#include "idpf_ptp.h"
 
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
@@ -437,58 +438,6 @@ idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
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
@@ -734,20 +683,27 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
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
+			rxq->time_high = rte_le_to_cpu_32(rx_desc->ts_high);
 			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-							    rxq->hw_register_set,
-							    rte_le_to_cpu_32(rx_desc->ts_high));
+							    rxq->hw_register_set, true,
+							    rxq->time_high);
 			rxq->hw_register_set = 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			first_seg->ol_flags |= idpf_timestamp_dynflag;
+			if (rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)
+				rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		first_seg->ol_flags |= pkt_flags;
@@ -841,21 +797,20 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 static inline uint16_t
 idpf_calc_context_desc(uint64_t flags)
 {
-	if ((flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
-		return 1;
+	static uint64_t mask = RTE_MBUF_F_TX_TCP_SEG |
+		RTE_MBUF_F_TX_IEEE1588_TMST;
 
-	return 0;
+	return (flags & mask) ? 1 : 0;
 }
 
-/* set TSO context descriptor, returns 0 if no context needed, 1 if context set
+/* set a context descriptor, returns 0 if no context needed, 1 if context set
  */
 static inline uint16_t
-idpf_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf,
+idpf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 		 const union ci_tx_offload *tx_offload,
 		 const struct ci_tx_queue *txq __rte_unused,
 		 uint64_t *qw0, uint64_t *qw1)
 {
-	uint16_t cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX | IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
 	uint16_t tso_segsz = mbuf->tso_segsz;
 	uint32_t tso_len;
 	uint8_t hdr_len;
@@ -863,19 +818,27 @@ idpf_set_tso_ctx(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 	if (idpf_calc_context_desc(ol_flags) == 0)
 		return 0;
 
-	/* TSO context descriptor setup */
-	if (tx_offload->l4_len == 0) {
-		TX_LOG(DEBUG, "L4 length set to 0");
-		return 0;
-	}
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		/* TSO context descriptor setup */
+		if (tx_offload->l4_len == 0) {
+			TX_LOG(DEBUG, "L4 length set to 0");
+			return 0;
+		}
 
-	hdr_len = tx_offload->l2_len + tx_offload->l3_len + tx_offload->l4_len;
-	tso_len = mbuf->pkt_len - hdr_len;
+		hdr_len = tx_offload->l2_len + tx_offload->l3_len + tx_offload->l4_len;
+		tso_len = mbuf->pkt_len - hdr_len;
 
-	*qw0 = rte_cpu_to_le_32(tso_len & IDPF_TXD_FLEX_CTX_MSS_RT_M) |
+		*qw0 = rte_cpu_to_le_32(tso_len & IDPF_TXD_FLEX_CTX_MSS_RT_M) |
 	       ((uint64_t)rte_cpu_to_le_16(tso_segsz & IDPF_TXD_FLEX_CTX_MSS_RT_M) << 32) |
 	       ((uint64_t)hdr_len << 48);
-	*qw1 = rte_cpu_to_le_16(cmd_dtype);
+		*qw1 = rte_cpu_to_le_16(IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
+			IDPF_TX_FLEX_CTX_DESC_CMD_TSO);
+	} else if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
+		*qw1 = FIELD_PREP(IDPF_TXD_QW1_CMD_M, IDPF_TX_CTX_DESC_TSYN) |
+			FIELD_PREP(IDPF_TXD_QW1_DTYPE_M, IDPF_TX_DESC_DTYPE_CTX) |
+			((uint64_t)FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_L_M, txq->latch_idx) << 16) |
+			((uint64_t)FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_H_M, txq->latch_idx >> 2)
+			<< 32);
 
 	return 1;
 }
@@ -936,7 +899,7 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		tx_offload.tso_segsz = tx_pkt->tso_segsz;
 		/* Calculate the number of context descriptors needed. */
 		uint64_t cd_qw0 = 0, cd_qw1 = 0;
-		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, &tx_offload, txq,
+		nb_ctx = idpf_get_context_desc(ol_flags, tx_pkt, &tx_offload, txq,
 					  &cd_qw0, &cd_qw1);
 
 		/* Calculate the number of TX descriptors needed for
@@ -1178,17 +1141,22 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		rxm->ol_flags |= pkt_flags;
 
+		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
+			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
 			/* timestamp */
+			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
 			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-					    rxq->hw_register_set,
-					    rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
+					    rxq->hw_register_set, true,
+					    rxq->time_high);
 			rxq->hw_register_set = 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			rxm->ol_flags |= idpf_timestamp_dynflag;
+			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		rx_pkts[nb_rx++] = rxm;
@@ -1229,6 +1197,9 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	if (unlikely(!rxq) || unlikely(!rxq->q_started))
 		return nb_rx;
 
+	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0)
+		rxq->hw_register_set = 1;
+
 	while (nb_rx < nb_pkts) {
 		rxdp = &rx_ring[rx_id];
 		rx_status0 = rte_le_to_cpu_16(rxdp->flex_nic_wb.status_error0);
@@ -1309,17 +1280,22 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			ptype_tbl[(uint8_t)(rte_cpu_to_le_16(rxd.flex_nic_wb.ptype_flex_flags0) &
 				VIRTCHNL2_RX_FLEX_DESC_PTYPE_M)];
 
+		if ((first_seg->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_TIMESYNC)
+			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) != 0) {
 			/* timestamp */
+			rxq->time_high = rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
 			ts_ns = idpf_tstamp_convert_32b_64b(ad,
-				rxq->hw_register_set,
-				rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
+				rxq->hw_register_set, true,
+				rxq->time_high);
 			rxq->hw_register_set = 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) = ts_ns;
 			first_seg->ol_flags |= idpf_timestamp_dynflag;
+			first_seg->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
 
 		first_seg->ol_flags |= pkt_flags;
@@ -1344,7 +1320,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
 	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
-			idpf_set_tso_ctx, NULL, NULL);
+			idpf_get_context_desc, NULL, NULL);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_simple)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 914cab0f25..a71af7103f 100644
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
@@ -162,6 +168,7 @@ struct idpf_rx_queue {
 
 	uint64_t offloads;
 	uint32_t hw_register_set;
+	uint32_t time_high; /* high 32 bits of hardware timestamp register */
 };
 
 union idpf_tx_desc {
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 5d786fbba6..5e57a45775 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -14,6 +14,7 @@
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
 #include "../common/tx.h"
+#include "idpf_ptp.h"
 
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
@@ -841,6 +842,267 @@ idpf_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+idpf_timesync_enable(struct rte_eth_dev *dev)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = vport->adapter;
+	struct timespec sys_ts;
+	uint64_t ns;
+	int ret, q_id;
+	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
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
+		goto fail_ptp;
+	}
+
+	/* Write the default increment time value if the clock adjustments are enabled. */
+	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
+		ret = idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp->base_incval);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set incval failed, err=%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	/* Do not initialize the PTP if the device clock time cannot be read. */
+	if (adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
+		PMD_DRV_LOG(ERR, "Getting device clock time is not supported");
+		ret = -EIO;
+		goto fail_ptp;
+	}
+
+	/* Set the device clock time to system time. */
+	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
+		clock_gettime(CLOCK_REALTIME, &sys_ts);
+		ns = rte_timespec_to_ns(&sys_ts);
+		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err=%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	ret = idpf_ptp_get_vport_tstamps_caps(vport);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get vport timestamp capabilities, err=%d", ret);
+		goto fail_ptp;
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
+	return 0;
+
+fail_ptp:
+	rte_free(adapter->ptp);
+	adapter->ptp = NULL;
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
+						struct timespec *timestamp)
+{
+	struct idpf_vport *vport = dev->data->dev_private;
+	uint16_t latch_idx;
+	uint64_t ts_ns, tstamp;
+	int ret;
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
+	int ret;
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
+	int ret;
+
+	incval = ptp->base_incval;
+
+	if (ppm < 0) {
+		negative = true;
+		ppm = -ppm;
+	}
+
+	/* can incval * ppm overflow ? */
+	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
+		rem = ppm % divisor;
+		div = ppm / divisor;
+		diff = div * incval;
+		ppm = rem;
+
+		shift = rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
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
+	int ret;
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
+	int ret;
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
@@ -867,6 +1129,14 @@ static const struct eth_dev_ops idpf_eth_dev_ops = {
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

