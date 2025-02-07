Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4CEC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 20:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8790402E0;
	Fri,  7 Feb 2025 21:49:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id AA5D740270
 for <dev@dpdk.org>; Fri,  7 Feb 2025 21:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738961383; x=1770497383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hUnnl+t9Z33CjPq0joDDeFH7scuhhc9Bi3j0S9vcAEE=;
 b=FB1vpJ7tM/ukvPwSecFUR9YZ311/6e1xdAb4ql0nF66nzT8W+jI2O5KE
 e/5yPg+qW7Vo7CjumfbPihxiNqrws2lQvuOYlTue/39VAhOpKXip73pdb
 Txqk4vmEZcYlCPvmBNEsvSo9Asg4bBtj3QXsx1h4RWLXfRl3qUuRkYnAU
 E2RPWReGW5Sy22mqY5RJWTwMx9qbPQ1NIyxJw2rPadAzR3feiiI+TyGkk
 rkM8NDfnHPHYqHDI3fxeDEE801yRrQx0XArBZ1iggQQV4Heb5wt+ci/N5
 E8y3XI7BQ30l5LVfQmptLFSTo8nKszj12+ZilvrxfxwQXslZi0HGo/kfb A==;
X-CSE-ConnectionGUID: h4r5hWg5Rp2AX8M0nM6Jxg==
X-CSE-MsgGUID: aT4oT54AQPq8M9kP4ZfmxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39742361"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="39742361"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 12:49:09 -0800
X-CSE-ConnectionGUID: Q3QAmdxlQxGw17L5rcW3eg==
X-CSE-MsgGUID: SDuXBWqRTL+KOuuKPMgvxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="116631322"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 12:49:07 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v1 3/3] net/intel: add Tx time queue
Date: Fri,  7 Feb 2025 12:43:00 +0000
Message-ID: <20250207124300.1022523-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
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

Enabling Tx timestamp queue for supporting Tx time based
scheduling of packets.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/common/tx.h              |   5 +
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   1 +
 drivers/net/intel/ice/ice_ethdev.h         |   1 +
 drivers/net/intel/ice/ice_rxtx.c           | 174 +++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h           |   5 +
 5 files changed, 186 insertions(+)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..f3777fa9e7 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -35,6 +35,7 @@ struct ci_tx_queue {
 		volatile struct i40e_tx_desc *i40e_tx_ring;
 		volatile struct iavf_tx_desc *iavf_tx_ring;
 		volatile struct ice_tx_desc *ice_tx_ring;
+		volatile struct ice_ts_desc *ice_tstamp_ring;
 		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
 	};
 	volatile uint8_t *qtx_tail;               /* register address of tail */
@@ -76,6 +77,10 @@ struct ci_tx_queue {
 	union {
 		struct { /* ICE driver specific values */
 			uint32_t q_teid; /* TX schedule node id. */
+			uint16_t nb_tstamp_desc;	/* number of Timestamp descriptors */
+			volatile uint8_t *tstamp_tail;	/* value of timestamp tail register */
+			rte_iova_t tstamp_ring_dma;	/* Timestamp ring DMA address */
+			uint16_t next_tstamp_id;
 		};
 		struct { /* I40E driver specific values */
 			uint8_t dcb_tc;
diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
index 940c6843d9..edd1137114 100644
--- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
+++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
@@ -1279,6 +1279,7 @@ struct ice_ts_desc {
 #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
 #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
 #define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
+#define ICE_TXTIME_FETCH_PROFILE_CNT	16
 
 /* Tx Time queue context data
  *
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index afe8dae497..9649456771 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -299,6 +299,7 @@ struct ice_vsi {
 	uint8_t enabled_tc; /* The traffic class enabled */
 	uint8_t vlan_anti_spoof_on; /* The VLAN anti-spoofing enabled */
 	uint8_t vlan_filter_on; /* The VLAN filter enabled */
+	uint8_t enabled_txpp;	/* TXPP support enabled */
 	/* information about rss configuration */
 	u32 rss_key_size;
 	u32 rss_lut_size;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 8dd8644b16..f043ae3aa6 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -5,6 +5,7 @@
 #include <ethdev_driver.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_os_shim.h>
 
 #include "ice_rxtx.h"
 #include "ice_rxtx_vec_common.h"
@@ -741,6 +742,87 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	return 0;
 }
 
+/**
+ * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
+ * @ring: The tstamp ring to configure
+ * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
+ * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
+ */
+static int
+ice_setup_txtime_ctx(struct ci_tx_queue *txq,
+		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
+{
+	struct ice_vsi *vsi = txq->ice_vsi;
+	struct ice_hw *hw;
+
+	hw = ICE_VSI_TO_HW(vsi);
+	txtime_ctx->base = txq->tstamp_ring_dma >> ICE_TX_CMPLTNQ_CTX_BASE_S;
+
+	/* Tx time Queue Length */
+	txtime_ctx->qlen = txq->nb_tstamp_desc;
+
+	if (txtime_ena)
+		txtime_ctx->txtime_ena_q = 1;
+
+	/* PF number */
+	txtime_ctx->pf_num = hw->pf_id;
+
+	switch (vsi->type) {
+	case ICE_VSI_LB:
+	case ICE_VSI_CTRL:
+	case ICE_VSI_ADI:
+	case ICE_VSI_PF:
+		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
+			vsi->type);
+		return -EINVAL;
+	}
+
+	/* make sure the context is associated with the right VSI */
+	txtime_ctx->src_vsi = ice_get_hw_vsi_num(hw, vsi->idx);
+
+
+	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
+	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
+	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
+
+	return 0;
+}
+
+/**
+ * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
+ * @hw: pointer to the hardware structure
+ * @tx_desc_count: number of Tx descriptors in the ring
+ *
+ * Return: the number of timestamp descriptors
+ */
+uint16_t ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
+{
+	uint16_t prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
+	uint16_t max_fetch_desc = 0;
+	uint16_t fetch;
+	uint32_t reg;
+	uint16_t i;
+
+	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
+		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
+		fetch = ((uint32_t)((reg &
+				E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)
+				>> rte_bsf64
+				(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)));
+		max_fetch_desc = max(fetch, max_fetch_desc);
+	}
+
+	if (!max_fetch_desc)
+		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
+
+	max_fetch_desc = RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
+
+	return tx_desc_count + max_fetch_desc;
+}
+
 int
 ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
@@ -829,6 +911,29 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	if (txq->ice_tstamp_ring) {
+		struct ice_aqc_set_txtime_qgrp *txtime_qg_buf;
+		u8 txtime_buf_len = ice_struct_size(txtime_qg_buf, txtimeqs, 1);
+		struct ice_txtime_ctx txtime_ctx = { 0 };
+
+		txtime_qg_buf = ice_malloc(hw, txtime_buf_len);
+		ice_setup_txtime_ctx(txq, &txtime_ctx,
+				vsi->enabled_txpp);
+		ice_set_ctx(hw, (u8 *)&txtime_ctx,
+			    txtime_qg_buf->txtimeqs[0].txtime_ctx,
+			    ice_txtime_ctx_info);
+
+		txq->tstamp_tail = hw->hw_addr +
+					E830_GLQTX_TXTIME_DBELL_LSB(tx_queue_id);
+
+		err = ice_aq_set_txtimeq(hw, tx_queue_id, 1, txtime_qg_buf,
+					    txtime_buf_len, NULL);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
+			return err;
+		}
+	}
+
 	rte_free(txq_elem);
 	return 0;
 }
@@ -1039,6 +1144,22 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 		prev = i;
 	}
 
+	if (txq->ice_tstamp_ring) {
+		size = sizeof(struct ice_ts_desc) * txq->nb_tstamp_desc;
+		for (i = 0; i < size; i++)
+			((volatile char *)txq->ice_tstamp_ring)[i] = 0;
+
+		prev = (uint16_t)(txq->nb_tstamp_desc - 1);
+		for (i = 0; i < txq->nb_tstamp_desc; i++) {
+			volatile struct ice_ts_desc *tsd = &txq->ice_tstamp_ring[i];
+			tsd->tx_desc_idx_tstamp = 0;
+			prev = i;
+		}
+
+		txq->next_tstamp_id = 0;
+		txq->tstamp_tail = NULL;
+	}
+
 	txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
 	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
@@ -1501,6 +1622,24 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	if (vsi->type == ICE_VSI_PF && vsi->enabled_txpp) {
+		const struct rte_memzone *tstamp_z =
+					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
+					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
+				    socket_id);
+		if (!tstamp_z) {
+			ice_tx_queue_release(txq);
+			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX");
+			return -ENOMEM;
+		}
+
+		txq->nb_tstamp_desc =
+				    ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
+							    txq->nb_tx_desc);
+	} else {
+		txq->ice_tstamp_ring = NULL;
+	}
+
 	ice_reset_tx_queue(txq);
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
@@ -3161,6 +3300,41 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd->cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
 					 ICE_TXD_QW1_CMD_S);
+
+		if (txq->ice_tstamp_ring) {
+			volatile struct ice_ts_desc *ts_desc;
+			volatile struct ice_ts_desc *ice_tstamp_ring;
+			struct timespec sys_time;
+			uint16_t next_ts_id = txq->next_tstamp_id;
+			uint64_t ns;
+			uint32_t tstamp;
+
+			clock_gettime(CLOCK_REALTIME, &sys_time);
+			ns = rte_timespec_to_ns(&sys_time);
+			tstamp = ns >> ICE_TXTIME_CTX_RESOLUTION_128NS;
+
+			ice_tstamp_ring = txq->ice_tstamp_ring;
+			ts_desc = &ice_tstamp_ring[next_ts_id];
+			ts_desc->tx_desc_idx_tstamp =
+						rte_cpu_to_le_32(((uint32_t)tx_id &
+						ICE_TXTIME_TX_DESC_IDX_M) |
+						((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
+
+			next_ts_id++;
+			if (next_ts_id == txq->nb_tstamp_desc) {
+				int fetch = txq->nb_tstamp_desc - txq->nb_tx_desc;
+
+				for (next_ts_id = 0; next_ts_id < fetch; next_ts_id++) {
+					ts_desc = &ice_tstamp_ring[next_ts_id];
+					ts_desc->tx_desc_idx_tstamp =
+							rte_cpu_to_le_32(((uint32_t)tx_id &
+							ICE_TXTIME_TX_DESC_IDX_M) |
+							((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
+				}
+			}
+			txq->next_tstamp_id = next_ts_id;
+			ICE_PCI_REG_WRITE(txq->tstamp_tail, next_ts_id);
+		}
 	}
 end_of_tx:
 	/* update Tail register */
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index f9293ac6f9..651e146e6d 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -29,6 +29,10 @@
 #define ice_rx_flex_desc ice_32b_rx_flex_desc
 #endif
 
+#define ICE_TXTIME_TX_DESC_IDX_M	0x00001fff
+#define ICE_TXTIME_STAMP_M		12
+#define ICE_REQ_DESC_MULTIPLE	32
+
 #define ICE_SUPPORT_CHAIN_NUM 5
 
 #define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
@@ -293,6 +297,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
 int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
 int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
+u16 ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count);
 
 #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
 	int i; \
-- 
2.43.0

