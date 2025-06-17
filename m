Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85D3C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDF7F427B7;
	Wed, 18 Jun 2025 08:45:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id CDA34427B0
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750229149; x=1781765149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tiDaNdGTGBXxBsLbeEmriUMQlExyY4ACEa4sJTxm0l8=;
 b=VaTaWVIqZvSbpGNGAU6kKFRFnCCUQRn1+mPBlMKX3WLh7G1n/OXTmfsP
 xXWuXqAB5SB2ZKsNRChJ6x68EHYmjeLCpkOg2AbCs7kzjlFsKkO5dXX3Y
 X5YrK++YCIQjsAU3gomp2ZF854qOrr+wkXsqIyk0K03GOD5GTLf3zlZio
 Jl4URD4f8QShooIOh5P/2MyCUhHScsELh7yjug3ZizHsiseW9eMnPPE+N
 Srt2VbocMfayHvqzUVVyLJwUDMmVPjq8HXIgOYf69sBkQQQ1LEMj9k3no
 ldc7imvnISSwRfPgyPcAgVWMfx25sDzNCTwvgmLWJPBXExcWJueXbftoZ Q==;
X-CSE-ConnectionGUID: lmF5PgCbRFO9UVYJlpZtRw==
X-CSE-MsgGUID: gOFFAz5RTreN8EMKoXEyWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63469077"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63469077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 23:45:48 -0700
X-CSE-ConnectionGUID: BTU9lJ/6TC28hXurCVzgwA==
X-CSE-MsgGUID: DgJdl/S+Q+mumAot7sHWdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="150110518"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa009.fm.intel.com with ESMTP; 17 Jun 2025 23:45:46 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	manoj.kumar.subbarao@intel.com
Subject: [PATCH v7 3/4] net/intel: add TxPP Support for E830
Date: Tue, 17 Jun 2025 22:36:13 +0000
Message-ID: <20250617223614.568996-4-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617223614.568996-1-soumyadeep.hore@intel.com>
References: <20250617051337.563233-5-soumyadeep.hore@intel.com>
 <20250617223614.568996-1-soumyadeep.hore@intel.com>
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

Add support for Tx Time based queues. This is used to schedule
packets based on Tx timestamp.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/common/tx.h              |   1 +
 drivers/net/intel/ice/base/ice_lan_tx_rx.h |   4 +
 drivers/net/intel/ice/ice_ethdev.c         |   3 +-
 drivers/net/intel/ice/ice_rxtx.c           | 235 ++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.h           |  32 +++
 5 files changed, 266 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index b0a68bae44..492cdb2f88 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -77,6 +77,7 @@ struct ci_tx_queue {
 	union {
 		struct { /* ICE driver specific values */
 			uint32_t q_teid; /* TX schedule node id. */
+			struct ice_txtime *tsq; /* Tx Time based queue */
 		};
 		struct { /* I40E driver specific values */
 			uint8_t dcb_tc;
diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
index f92382346f..cd02d2b4eb 100644
--- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
+++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
@@ -1278,6 +1278,8 @@ struct ice_ts_desc {
 #define ICE_TXTIME_MAX_QUEUE		2047
 #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
 #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
+#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
+#define ICE_TXTIME_FETCH_PROFILE_CNT	16
 /* Tx Time queue context data
  *
  * The sizes of the variables may be larger than needed due to crossing byte
@@ -1303,10 +1305,12 @@ struct ice_txtime_ctx {
 	u8 drbell_mode_32;
 #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
 	u8 ts_res;
+#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
 	u8 ts_round_type;
 	u8 ts_pacing_slot;
 	u8 merging_ena;
 	u8 ts_fetch_prof_id;
+#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
 	u8 ts_fetch_cache_line_aln_thld;
 	u8 tx_pipe_delay_mode;
 	u8 int_q_state; /* width not needed - internal - DO NOT WRITE!!! */
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index c02935a04d..001c1343ad 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4139,7 +4139,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
 			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
 			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
+			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
 		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
 	}
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index ba1435b9de..e33fd74543 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -740,6 +740,50 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	return 0;
 }
 
+/**
+ * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
+ * @txq: The queue on which tstamp ring to configure
+ * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
+ * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
+ */
+static int
+ice_setup_txtime_ctx(struct ci_tx_queue *txq,
+		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
+{
+	struct ice_vsi *vsi = txq->ice_vsi;
+	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
+
+	txtime_ctx->base = txq->tsq->ts_mz->iova >> ICE_TX_CMPLTNQ_CTX_BASE_S;
+
+	/* Tx time Queue Length */
+	txtime_ctx->qlen = txq->tsq->nb_ts_desc;
+
+	if (txtime_ena)
+		txtime_ctx->txtime_ena_q = 1;
+
+	/* PF number */
+	txtime_ctx->pf_num = hw->pf_id;
+
+	switch (vsi->type) {
+	case ICE_VSI_PF:
+		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
+				vsi->type);
+		return -EINVAL;
+	}
+
+	/* make sure the context is associated with the right VSI */
+	txtime_ctx->src_vsi = vsi->vsi_id;
+
+	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
+	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
+	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
+
+	return 0;
+}
+
 int
 ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 {
@@ -799,11 +843,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
 		    ice_tlan_ctx_info);
 
-	txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
-
-	/* Init the Tx tail register*/
-	ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
-
 	/* Fix me, we assume TC always 0 here */
 	err = ice_ena_vsi_txq(hw->port_info, vsi->idx, 0, tx_queue_id, 1,
 			txq_elem, buf_len, NULL);
@@ -826,6 +865,38 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	/* record what kind of descriptor cleanup we need on teardown */
 	txq->vector_tx = ad->tx_vec_allowed;
 
+	if (txq->tsq->ts_flag > 0) {
+		struct ice_aqc_set_txtime_qgrp *ts_elem;
+		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
+		struct ice_txtime_ctx txtime_ctx = { 0 };
+
+		ts_elem = ice_malloc(hw, ts_buf_len);
+		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
+		ice_set_ctx(hw, (u8 *)&txtime_ctx,
+				ts_elem->txtimeqs[0].txtime_ctx,
+				ice_txtime_ctx_info);
+
+		txq->qtx_tail = hw->hw_addr +
+				E830_GLQTX_TXTIME_DBELL_LSB(txq->reg_idx);
+
+		/* Init the Tx time tail register*/
+		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
+
+		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem,
+				ts_buf_len, NULL);
+		rte_free(ts_elem);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
+			rte_free(txq_elem);
+			return err;
+		}
+	} else {
+		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
+
+		/* Init the Tx tail register*/
+		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
+	}
+
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
 	rte_free(txq_elem);
@@ -1046,6 +1117,16 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
 
 	txq->last_desc_cleaned = (uint16_t)(txq->nb_tx_desc - 1);
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_desc - 1);
+
+	if (txq->tsq->ts_flag > 0) {
+		for (i = 0; i < txq->tsq->nb_ts_desc; i++) {
+			volatile struct ice_ts_desc *tsd =
+							&txq->tsq->ice_ts_ring[i];
+			tsd->tx_desc_idx_tstamp = 0;
+		}
+
+		txq->tsq->ts_tail = 0;
+	}
 }
 
 int
@@ -1080,6 +1161,17 @@ ice_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	q_ids[0] = txq->reg_idx;
 	q_teids[0] = txq->q_teid;
 
+	if (txq->tsq->ts_flag > 0) {
+		struct ice_aqc_ena_dis_txtime_qgrp txtime_pg;
+		dev->dev_ops->timesync_disable(dev);
+		status = ice_aq_ena_dis_txtimeq(hw, q_ids[0], 1, 0,
+					     &txtime_pg, NULL);
+		if (status != ICE_SUCCESS) {
+			PMD_DRV_LOG(DEBUG, "Failed to disable Tx time queue");
+			return -EINVAL;
+		}
+	}
+
 	/* Fix me, we assume TC always 0 here */
 	status = ice_dis_vsi_txq(hw->port_info, vsi->idx, 0, 1, &q_handle,
 				q_ids, q_teids, ICE_NO_RESET, 0, NULL);
@@ -1166,6 +1258,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 		   struct rte_mempool *mp)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_adapter *ad =
 		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
@@ -1249,7 +1342,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->xtr_field_offs = ad->devargs.xtr_field_offs;
 
 	/* Allocate the maximum number of RX ring hardware descriptor. */
-	len = ICE_MAX_RING_DESC;
+	len = ICE_MAX_NUM_DESC_BY_MAC(hw);
 
 	/**
 	 * Allocating a little more memory because vectorized/bulk_alloc Rx
@@ -1337,6 +1430,37 @@ ice_rx_queue_release(void *rxq)
 	rte_free(q);
 }
 
+/**
+ * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
+ * @hw: pointer to the hardware structure
+ * @tx_desc_count: number of Tx descriptors in the ring
+ *
+ * Return: the number of timestamp descriptors
+ */
+static uint16_t
+ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
+{
+	u16 prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
+	u16 max_fetch_desc = 0;
+	u16 fetch;
+	u32 reg;
+	u16 i;
+
+	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
+		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
+		fetch = FIELD_GET(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M,
+				  reg);
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
 ice_tx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t queue_idx,
@@ -1345,6 +1469,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
 	struct ci_tx_queue *txq;
 	const struct rte_memzone *tz;
@@ -1469,7 +1594,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	/* Allocate TX hardware ring descriptors. */
-	ring_size = sizeof(struct ice_tx_desc) * ICE_MAX_RING_DESC;
+	ring_size = sizeof(struct ice_tx_desc) *
+				ICE_MAX_NUM_DESC_BY_MAC(hw);
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 	tz = rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
 				      ring_size, ICE_RING_BASE_ALIGN,
@@ -1507,6 +1633,58 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	if (vsi->type == ICE_VSI_PF &&
+		(offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)) {
+		if (hw->phy_model != ICE_PHY_E830) {
+			ice_tx_queue_release(txq);
+			PMD_INIT_LOG(ERR, "Tx Time Queue is not supported on "
+							"this device");
+			return -EINVAL;
+		}
+
+		txq->tsq = rte_zmalloc_socket(NULL,
+						sizeof(struct ice_txtime),
+						RTE_CACHE_LINE_SIZE, socket_id);
+		if (!txq->tsq) {
+			ice_tx_queue_release(txq);
+			PMD_INIT_LOG(ERR, "Failed to allocate memory for "
+							"tx time queue structure");
+			return -ENOMEM;
+		}
+
+		int ret =
+			rte_mbuf_dyn_tx_timestamp_register(&txq->tsq->ts_offset,
+							 &txq->tsq->ts_flag);
+		if (ret) {
+			ice_tx_queue_release(txq);
+			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag "
+							"for timestamp");
+			return -EINVAL;
+		}
+		dev->dev_ops->timesync_enable(dev);
+
+		txq->tsq->nb_ts_desc =
+				ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
+							txq->nb_tx_desc);
+		ring_size = sizeof(struct ice_ts_desc) *
+					txq->tsq->nb_ts_desc;
+		ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
+		const struct rte_memzone *ts_z =
+					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
+					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
+				    socket_id);
+		if (!ts_z) {
+			ice_tx_queue_release(txq);
+			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory "
+							"for TX timestamp");
+			return -ENOMEM;
+		}
+		txq->tsq->ts_mz = ts_z;
+		txq->tsq->ice_ts_ring = ts_z->addr;
+	} else {
+		txq->tsq = NULL;
+	}
+
 	ice_reset_tx_queue(txq);
 	txq->q_set = true;
 	dev->data->tx_queues[queue_idx] = txq;
@@ -1539,6 +1717,10 @@ ice_tx_queue_release(void *txq)
 
 	ci_txq_release_all_mbufs(q, false);
 	rte_free(q->sw_ring);
+	if (q->tsq) {
+		rte_memzone_free(q->tsq->ts_mz);
+		rte_free(q->tsq);
+	}
 	rte_memzone_free(q->mz);
 	rte_free(q);
 }
@@ -2961,6 +3143,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf *m_seg;
 	uint32_t cd_tunneling_params;
 	uint16_t tx_id;
+	uint16_t ts_id = -1;
 	uint16_t nb_tx;
 	uint16_t nb_used;
 	uint16_t nb_ctx;
@@ -2979,6 +3162,9 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	tx_id = txq->tx_tail;
 	txe = &sw_ring[tx_id];
 
+	if (txq->tsq->ts_flag > 0)
+		ts_id = txq->tsq->ts_tail;
+
 	/* Check if the descriptor ring needs to be cleaned. */
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		(void)ice_xmit_cleanup(txq);
@@ -3166,10 +3352,43 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txd->cmd_type_offset_bsz |=
 			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
 					 ICE_TXD_QW1_CMD_S);
+
+		if (txq->tsq->ts_flag > 0) {
+			uint64_t txtime = *RTE_MBUF_DYNFIELD(tx_pkt,
+					txq->tsq->ts_offset, uint64_t *);
+			uint32_t tstamp = (uint32_t)(txtime % NS_PER_S) >>
+						ICE_TXTIME_CTX_RESOLUTION_128NS;
+			const uint32_t desc_tx_id = (tx_id == 0) ?
+									txq->nb_tx_desc : tx_id;
+			__le32 ts_desc =
+				rte_cpu_to_le_32(FIELD_PREP(ICE_TXTIME_TX_DESC_IDX_M,
+					desc_tx_id) | FIELD_PREP(ICE_TXTIME_STAMP_M, tstamp));
+			txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp = ts_desc;
+			ts_id++;
+			/* To prevent an MDD, when wrapping the tstamp
+			 * ring create additional TS descriptors equal
+			 * to the number of the fetch TS descriptors
+			 * value. HW will merge the TS descriptors with
+			 * the same timestamp value into a single
+			 * descriptor.
+			 */
+			if (ts_id == txq->tsq->nb_ts_desc) {
+				uint16_t fetch = txq->tsq->nb_ts_desc - txq->nb_tx_desc;
+				ts_id = 0;
+				for (; ts_id < fetch; ts_id++)
+					txq->tsq->ice_ts_ring[ts_id].tx_desc_idx_tstamp =
+											ts_desc;
+			}
+		}
 	}
 end_of_tx:
 	/* update Tail register */
-	ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
+	if (txq->tsq->ts_flag > 0) {
+		ICE_PCI_REG_WRITE(txq->qtx_tail, ts_id);
+		txq->tsq->ts_tail = ts_id;
+	} else {
+		ICE_PCI_REG_WRITE(txq->qtx_tail, tx_id);
+	}
 	txq->tx_tail = tx_id;
 
 	return nb_tx;
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 500d630679..1e917ed7fb 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -8,12 +8,32 @@
 #include "../common/tx.h"
 #include "ice_ethdev.h"
 
+#define FIELD_GET(_mask, _reg) \
+	(__extension__ ({ \
+		typeof(_mask) _x = (_mask); \
+		(typeof(_x))(((_reg) & (_x)) >> rte_bsf32(_x)); \
+	}))
+#define FIELD_PREP(_mask, _val) \
+	(__extension__ ({ \
+		typeof(_mask) _x = (_mask); \
+		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
+	}))
+
 #define ICE_ALIGN_RING_DESC  32
 #define ICE_MIN_RING_DESC    64
 #define ICE_MAX_RING_DESC    (8192 - 32)
+#define ICE_MAX_RING_DESC_E830	  8096
+#define ICE_MAX_NUM_DESC_BY_MAC(hw) ((hw)->phy_model == \
+					ICE_PHY_E830 ? \
+				    ICE_MAX_RING_DESC_E830 : \
+				    ICE_MAX_RING_DESC)
 #define ICE_DMA_MEM_ALIGN    4096
 #define ICE_RING_BASE_ALIGN  128
 
+#define ICE_TXTIME_TX_DESC_IDX_M	RTE_GENMASK32(12, 0)
+#define ICE_TXTIME_STAMP_M		RTE_GENMASK32(31, 13)
+#define ICE_REQ_DESC_MULTIPLE	32
+
 #define ICE_RX_MAX_BURST 32
 #define ICE_TX_MAX_BURST 32
 
@@ -144,6 +164,18 @@ struct ice_rx_queue {
 	uint64_t ts_flag; /* dynamic mbuf timestamp flag */
 };
 
+/**
+ * Structure associated with Tx Time based queue
+ */
+struct ice_txtime {
+	volatile struct ice_ts_desc *ice_ts_ring; /* Tx time ring virtual address */
+	uint16_t nb_ts_desc; /* number of Tx Time descriptors */
+	uint16_t ts_tail; /* current value of tail register */
+	int ts_offset; /* dynamic mbuf Tx timestamp field offset */
+	uint64_t ts_flag; /* dynamic mbuf Tx timestamp flag */
+	const struct rte_memzone *ts_mz;
+};
+
 /* Offload features */
 union ice_tx_offload {
 	uint64_t data;
-- 
2.43.0

