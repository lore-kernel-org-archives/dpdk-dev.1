Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F9C531FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F9A440DD6;
	Fri, 20 Feb 2026 11:15:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E690C40A81
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582516; x=1803118516;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4hglFKeHNRsKk89Dj3LrromaemdHoKJV8caSrsIw1hA=;
 b=Mh+W88uC7n/l8ol6pvxSgTRJtyz6LuuUOEADXPXwWGcLVKHffeLiF4DY
 /bwR0pQYF+VfpWSMDAMNoMoUTDfG6Ud5aRYKDvSO07BWmQca5Iosgkh1H
 syYp3eujMrn0QV+J9wpIHxWuS3SszamyI/FGf2HyhtW+svKZzjplDtmKL
 z5WmQ80NwaucAuwIxBcyRycd5NgFki9wHAGN01Cf6JkChes4HYmAL3XkZ
 sexTUiM8GoNsU8gkS7pdqNE0N65CWsp6PyfBAKhmWOGA2y+Q69NCru88B
 HhAtJaQIsR7pqy77hycnCeUrRQd8QyLX9ADXP5k7lsdGZh6KgLMQQP6jh A==;
X-CSE-ConnectionGUID: WEt0USRJTEGLxGyeU+M0QA==
X-CSE-MsgGUID: DgjzmX6FSKWQndHDROfVBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283371"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283371"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:15 -0800
X-CSE-ConnectionGUID: 7P1BH41lQImJmvWSJvnpSQ==
X-CSE-MsgGUID: Wx4xFxc8SDSHd+Ugart+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038563"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 22/27] net/iavf: avoid rte malloc in queue operations
Date: Fri, 20 Feb 2026 10:14:29 +0000
Message-ID: <83143a2c634cfa8e2fc7a0ef8e1506109a2849cc.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

Currently, when enabling, disabling, or switching queues, we are using
rte_malloc followed by an immediate rte_free. This is not needed as these
structures are not being stored anywhere, so replace them with stack
allocation.

The original code did not check maximum queue number, because the design
was built around an anti-pattern of caller having to chunk the queue
configuration. This has now been corrected as well.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |   3 +-
 drivers/net/intel/iavf/iavf_ethdev.c |  15 +-
 drivers/net/intel/iavf/iavf_vchnl.c  | 212 ++++++++++++++-------------
 3 files changed, 115 insertions(+), 115 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 6054321771..77a2c94290 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -503,8 +503,7 @@ int iavf_disable_queues(struct iavf_adapter *adapter);
 int iavf_disable_queues_lv(struct iavf_adapter *adapter);
 int iavf_configure_rss_lut(struct iavf_adapter *adapter);
 int iavf_configure_rss_key(struct iavf_adapter *adapter);
-int iavf_configure_queues(struct iavf_adapter *adapter,
-			uint16_t num_queue_pairs, uint16_t index);
+int iavf_configure_queues(struct iavf_adapter *adapter, uint16_t num_queue_pairs);
 int iavf_get_supported_rxdid(struct iavf_adapter *adapter);
 int iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable);
 int iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 4e0df2ca05..6e216f4c0f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1036,20 +1036,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	if (iavf_set_vf_quanta_size(adapter, index, num_queue_pairs) != 0)
 		PMD_DRV_LOG(WARNING, "configure quanta size failed");
 
-	/* If needed, send configure queues msg multiple times to make the
-	 * adminq buffer length smaller than the 4K limitation.
-	 */
-	while (num_queue_pairs > IAVF_CFG_Q_NUM_PER_BUF) {
-		if (iavf_configure_queues(adapter,
-				IAVF_CFG_Q_NUM_PER_BUF, index) != 0) {
-			PMD_DRV_LOG(ERR, "configure queues failed");
-			goto error;
-		}
-		num_queue_pairs -= IAVF_CFG_Q_NUM_PER_BUF;
-		index += IAVF_CFG_Q_NUM_PER_BUF;
-	}
-
-	if (iavf_configure_queues(adapter, num_queue_pairs, index) != 0) {
+	if (iavf_configure_queues(adapter, num_queue_pairs) != 0) {
 		PMD_DRV_LOG(ERR, "configure queues failed");
 		goto error;
 	}
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f44dc7e7be..f0ab3b950b 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1020,19 +1020,15 @@ int
 iavf_enable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
+	} queue_req = {0};
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues) +
-		  sizeof(struct virtchnl_queue_chunk) *
-		  (IAVF_RXTX_QUEUE_CHUNKS_NUM - 1);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1048,7 +1044,7 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1056,7 +1052,6 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_ENABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1064,19 +1059,15 @@ int
 iavf_disable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
+	} queue_req = {0};
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues) +
-		  sizeof(struct virtchnl_queue_chunk) *
-		  (IAVF_RXTX_QUEUE_CHUNKS_NUM - 1);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1092,7 +1083,7 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1100,7 +1091,6 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_DISABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1109,17 +1099,14 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		 bool rx, bool on)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+	} queue_req = {0};
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = 1;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1138,7 +1125,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 	else
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1146,7 +1133,6 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
 			    on ? "OP_ENABLE_QUEUES_V2" : "OP_DISABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1214,88 +1200,116 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	return err;
 }
 
-int
-iavf_configure_queues(struct iavf_adapter *adapter,
-		uint16_t num_queue_pairs, uint16_t index)
+static void
+iavf_configure_queue_pair(struct iavf_adapter *adapter,
+		struct virtchnl_queue_pair_info *vc_qp,
+		uint16_t q_idx)
 {
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct ci_rx_queue **rxq = (struct ci_rx_queue **)adapter->dev_data->rx_queues;
 	struct ci_tx_queue **txq = (struct ci_tx_queue **)adapter->dev_data->tx_queues;
+
+	/* common parts */
+	vc_qp->txq.vsi_id = vf->vsi_res->vsi_id;
+	vc_qp->txq.queue_id = q_idx;
+
+	vc_qp->rxq.vsi_id = vf->vsi_res->vsi_id;
+	vc_qp->rxq.queue_id = q_idx;
+	vc_qp->rxq.max_pkt_size = vf->max_pkt_len;
+
+	/* is this txq active? */
+	if (q_idx < adapter->dev_data->nb_tx_queues) {
+		vc_qp->txq.ring_len = txq[q_idx]->nb_tx_desc;
+		vc_qp->txq.dma_ring_addr = txq[q_idx]->tx_ring_dma;
+	}
+
+	/* is this rxq active? */
+	if (q_idx >= adapter->dev_data->nb_rx_queues)
+		return;
+
+	vc_qp->rxq.ring_len = rxq[q_idx]->nb_rx_desc;
+	vc_qp->rxq.dma_ring_addr = rxq[q_idx]->rx_ring_phys_addr;
+	vc_qp->rxq.databuffer_size = rxq[q_idx]->rx_buf_len;
+	vc_qp->rxq.crc_disable = rxq[q_idx]->crc_len != 0 ? 1 : 0;
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
+		if (vf->supported_rxdid & RTE_BIT64(rxq[q_idx]->rxdid)) {
+			vc_qp->rxq.rxdid = rxq[q_idx]->rxdid;
+			PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d]",
+					vc_qp->rxq.rxdid, q_idx);
+		} else {
+			PMD_DRV_LOG(NOTICE, "RXDID[%d] is not supported, "
+					"request default RXDID[%d] in Queue[%d]",
+					rxq[q_idx]->rxdid, IAVF_RXDID_LEGACY_1, q_idx);
+			vc_qp->rxq.rxdid = IAVF_RXDID_LEGACY_1;
+		}
+
+		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP &&
+			vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_RX_TSTAMP &&
+			rxq[q_idx]->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
+			vc_qp->rxq.flags |= VIRTCHNL_PTP_RX_TSTAMP;
+	}
+}
+
+static int
+iavf_configure_queue_chunk(struct iavf_adapter *adapter,
+		uint16_t chunk_sz,
+		uint16_t chunk_start)
+{
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_vsi_queue_config_info *vc_config;
-	struct virtchnl_queue_pair_info *vc_qp;
-	struct iavf_cmd_info args;
-	uint16_t i, size;
+	struct {
+		struct virtchnl_vsi_queue_config_info config;
+		struct virtchnl_queue_pair_info qp[IAVF_CFG_Q_NUM_PER_BUF];
+	} queue_req = {0};
+	struct iavf_cmd_info args = {0};
+	struct virtchnl_vsi_queue_config_info *vc_config = &queue_req.config;
+	struct virtchnl_queue_pair_info *vc_qp = vc_config->qpair;
+	uint16_t chunk_end = chunk_start + chunk_sz;
+	uint16_t i;
 	int err;
 
-	size = sizeof(*vc_config) +
-	       sizeof(vc_config->qpair[0]) * num_queue_pairs;
-	vc_config = rte_zmalloc("cfg_queue", size, 0);
-	if (!vc_config)
-		return -ENOMEM;
+	if (chunk_sz > IAVF_CFG_Q_NUM_PER_BUF)
+		return -EINVAL;
 
 	vc_config->vsi_id = vf->vsi_res->vsi_id;
-	vc_config->num_queue_pairs = num_queue_pairs;
+	vc_config->num_queue_pairs = chunk_sz;
 
-	for (i = index, vc_qp = vc_config->qpair;
-		 i < index + num_queue_pairs;
-	     i++, vc_qp++) {
-		vc_qp->txq.vsi_id = vf->vsi_res->vsi_id;
-		vc_qp->txq.queue_id = i;
+	for (i = chunk_start; i < chunk_end; i++, vc_qp++)
+		iavf_configure_queue_pair(adapter, vc_qp, i);
 
-		/* Virtchnnl configure tx queues by pairs */
-		if (i < adapter->dev_data->nb_tx_queues) {
-			vc_qp->txq.ring_len = txq[i]->nb_tx_desc;
-			vc_qp->txq.dma_ring_addr = txq[i]->tx_ring_dma;
-		}
-
-		vc_qp->rxq.vsi_id = vf->vsi_res->vsi_id;
-		vc_qp->rxq.queue_id = i;
-		vc_qp->rxq.max_pkt_size = vf->max_pkt_len;
-
-		if (i >= adapter->dev_data->nb_rx_queues)
-			continue;
-
-		/* Virtchnnl configure rx queues by pairs */
-		vc_qp->rxq.ring_len = rxq[i]->nb_rx_desc;
-		vc_qp->rxq.dma_ring_addr = rxq[i]->rx_ring_phys_addr;
-		vc_qp->rxq.databuffer_size = rxq[i]->rx_buf_len;
-		vc_qp->rxq.crc_disable = rxq[i]->crc_len != 0 ? 1 : 0;
-		if (vf->vf_res->vf_cap_flags &
-		    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
-			if (vf->supported_rxdid & RTE_BIT64(rxq[i]->rxdid)) {
-				vc_qp->rxq.rxdid = rxq[i]->rxdid;
-				PMD_DRV_LOG(NOTICE, "request RXDID[%d] in Queue[%d]",
-					    vc_qp->rxq.rxdid, i);
-			} else {
-				PMD_DRV_LOG(NOTICE, "RXDID[%d] is not supported, "
-					    "request default RXDID[%d] in Queue[%d]",
-					    rxq[i]->rxdid, IAVF_RXDID_LEGACY_1, i);
-				vc_qp->rxq.rxdid = IAVF_RXDID_LEGACY_1;
-			}
-
-			if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP &&
-			    vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_RX_TSTAMP &&
-			    rxq[i]->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP)
-				vc_qp->rxq.flags |= VIRTCHNL_PTP_RX_TSTAMP;
-		}
-	}
-
-	memset(&args, 0, sizeof(args));
 	args.ops = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
 	args.in_args = (uint8_t *)vc_config;
-	args.in_args_size = size;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
-		PMD_DRV_LOG(ERR, "Failed to execute command of"
-			    " VIRTCHNL_OP_CONFIG_VSI_QUEUES");
-
-	rte_free(vc_config);
+		PMD_DRV_LOG(ERR, "Failed to execute command VIRTCHNL_OP_CONFIG_VSI_QUEUES");
 	return err;
 }
 
+int
+iavf_configure_queues(struct iavf_adapter *adapter, uint16_t num_queue_pairs)
+{
+	uint16_t c;
+	int err;
+
+	/*
+	 * we cannot configure all queues in one go because they won't fit into
+	 * adminq buffer, so we're going to chunk them instead
+	 */
+	for (c = 0; c < num_queue_pairs; c += IAVF_CFG_Q_NUM_PER_BUF) {
+		uint16_t chunk_sz = RTE_MIN(num_queue_pairs - c, IAVF_CFG_Q_NUM_PER_BUF);
+		err = iavf_configure_queue_chunk(adapter, chunk_sz, c);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to configure queues chunk [%u, %u)",
+					c, c + chunk_sz);
+			return err;
+		}
+	}
+	return 0;
+}
+
 int
 iavf_config_irq_map(struct iavf_adapter *adapter)
 {
-- 
2.47.3

