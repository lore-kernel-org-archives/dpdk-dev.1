Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577BC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BC41427BD;
	Tue, 15 Sep 2026 14:02:21 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3779B42793
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:17 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A2D91A004A;
 Tue, 15 Sep 2026 14:02:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A9CB61A0009;
 Tue, 15 Sep 2026 14:02:16 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4CFF0180006C;
 Tue, 15 Sep 2026 20:02:15 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3-S3 05/10] drivers: assign dpaa2 Rx CGID per traffic class
Date: Tue, 15 Sep 2026 17:32:03 +0530
Message-ID: <20260915120208.4185877-6-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Jun Yang <jun.yang@nxp.com>

RXQs in same TC should use same CGID for congestion set.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        | 252 ++++++++++++------------
 drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +-
 3 files changed, 126 insertions(+), 132 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index f0bc9a3063..12216750a8 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -176,7 +176,6 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint32_t fqid;		/*!< Unique ID of this queue */
 	uint16_t flow_id;	/*!< To be used by DPAA2 framework */
 	uint8_t tc_index;	/*!< traffic class identifier */
-	uint8_t cgid;		/*! < Congestion Group id for this queue */
 	uint64_t rx_pkts;
 	uint64_t tx_pkts;
 	uint64_t err_pkts;
@@ -186,6 +185,8 @@ struct __rte_cache_aligned dpaa2_queue {
 		/**Egress*/
 		struct qbman_result *cscn;
 	};
+	void *cfg;
+	uint8_t options;
 	struct rte_event ev;
 	dpaa2_queue_cb_dqrr_t *cb;
 	dpaa2_queue_cb_eqresp_free_t *cb_eqresp_free;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 889084c4ce..8cd482b538 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- * Copyright 2016-2025 NXP
+ * Copyright 2016-2026 NXP
  */
 
 #include <time.h>
@@ -682,6 +682,9 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
+			if (dpaa2_q->cfg)
+				rte_free(dpaa2_q->cfg);
+			dpaa2_q->cfg = NULL;
 			priv->rx_vq[i] = NULL;
 		}
 		/* cleanup tx queue cscn */
@@ -934,11 +937,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	struct fsl_mc_io *dpni = dev->process_private;
 	bool dpcon_allocated = false;
 	struct dpaa2_queue *dpaa2_q;
-	struct dpni_queue cfg;
-	uint8_t options = 0;
-	uint8_t flow_id;
+	struct dpni_queue *cfg;
+	struct dpni_taildrop taildrop;
+	uint8_t qopt = 0;
+	uint16_t flow_id;
 	uint32_t bpid;
-	int i, ret;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -975,6 +979,10 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		dev->data->rx_queues[rx_queue_id] = dpaa2_q;
 		return 0;
 	}
+	cfg = rte_zmalloc(NULL, sizeof(struct dpni_queue), 0);
+	if (!cfg)
+		return -ENOMEM;
+	dpaa2_q->cfg = cfg;
 	dpaa2_q->mb_pool = mb_pool; /**< mbuf pool to populate RX ring. */
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q->offloads = rx_conf->offloads;
@@ -1004,125 +1012,101 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 
 	/*Get the flow id from given VQ id*/
 	flow_id = dpaa2_q->flow_id;
-	memset(&cfg, 0, sizeof(struct dpni_queue));
+	memset(cfg, 0, sizeof(struct dpni_queue));
 
-	options = options | DPNI_QUEUE_OPT_USER_CTX;
-	cfg.user_context = (size_t)(dpaa2_q);
+	qopt |= DPNI_QUEUE_OPT_USER_CTX;
+	cfg->user_context = (size_t)(dpaa2_q);
 
 	/* napi: schedule the FQ to its DPCON once, when the channel is first
 	 * grabbed; never re-bound (the MC refuses scheduled->parked at runtime)
 	 */
 	if (dpcon_allocated) {
-		options |= DPNI_QUEUE_OPT_DEST;
-		cfg.destination.type = DPNI_DEST_DPCON;
-		cfg.destination.id = dpaa2_q->napi_dpcon->dpcon_id;
-	}
-
-	/* check if a private cgr available. */
-	for (i = 0; i < priv->max_cgs; i++) {
-		if (!priv->cgid_in_use[i]) {
-			priv->cgid_in_use[i] = 1;
-			break;
-		}
+		qopt |= DPNI_QUEUE_OPT_DEST;
+		cfg->destination.type = DPNI_DEST_DPCON;
+		cfg->destination.id = dpaa2_q->napi_dpcon->dpcon_id;
 	}
 
-	if (i < priv->max_cgs) {
-		options |= DPNI_QUEUE_OPT_SET_CGID;
-		cfg.cgid = i;
-		dpaa2_q->cgid = cfg.cgid;
+	/** RXQs in same TC share same cgid.*/
+	if (dpaa2_q->tc_index < priv->max_cgs) {
+		qopt |= DPNI_QUEUE_OPT_SET_CGID;
+		cfg->cgid = dpaa2_q->tc_index;
+		priv->cgid_in_use[dpaa2_q->tc_index]++;
 	} else {
-		dpaa2_q->cgid = DPAA2_INVALID_CGID;
+		cfg->cgid = DPAA2_INVALID_CGID;
 	}
 
 	/*if ls2088 or rev2 device, enable the stashing */
 
 	if ((dpaa2_svr_family & 0xffff0000) != SVR_LS2080A) {
-		options |= DPNI_QUEUE_OPT_FLC;
-		cfg.flc.stash_control = true;
-		dpaa2_flc_stashing_clear_all(&cfg.flc.value);
+		qopt |= DPNI_QUEUE_OPT_FLC;
+		cfg->flc.stash_control = true;
+		dpaa2_flc_stashing_clear_all(&cfg->flc.value);
 		if (priv->flags & DPAA2_RX_DATA_STASHING_OFF_FLAG) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
-				&cfg.flc.value);
+				&cfg->flc.value);
 			dpaa2_q->data_stashing_off = 1;
 		} else {
 			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1,
-				&cfg.flc.value);
+				&cfg->flc.value);
 			dpaa2_q->data_stashing_off = 0;
 		}
 		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A) {
 			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1,
-				&cfg.flc.value);
+				&cfg->flc.value);
 		}
 	}
+
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_RX,
-			dpaa2_q->tc_index, flow_id, options, &cfg);
+			dpaa2_q->tc_index, flow_id, qopt, cfg);
 	if (ret) {
+		rte_free(dpaa2_q->cfg);
+		dpaa2_q->cfg = NULL;
 		DPAA2_PMD_ERR("Error in setting the rx flow: = %d", ret);
 		goto err_free_dpcon;
 	}
 
 	dpaa2_q->nb_desc = nb_rx_desc;
-
-	if (!(priv->flags & DPAA2_RX_TAILDROP_OFF)) {
-		struct dpni_taildrop taildrop;
-
+	memset(&taildrop, 0, sizeof(struct dpni_taildrop));
+	if (!(priv->flags & DPAA2_RX_TAILDROP_OFF))
 		taildrop.enable = 1;
-		/* Private CGR will use tail drop length as nb_rx_desc.
-		 * for rest cases we can use standard byte based tail drop.
-		 * There is no HW restriction, but number of CGRs are limited,
-		 * hence this restriction is placed.
-		 */
-		if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
-			/*enabling per rx queue congestion control */
-			taildrop.threshold = nb_rx_desc;
-			taildrop.units = DPNI_CONGESTION_UNIT_FRAMES;
-			taildrop.oal = 0;
-			DPAA2_PMD_DEBUG("Enabling CG Tail Drop on queue = %d",
-					rx_queue_id);
-			ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
-						DPNI_CP_CONGESTION_GROUP,
-						DPNI_QUEUE_RX,
-						dpaa2_q->tc_index,
-						dpaa2_q->cgid, &taildrop);
-		} else {
-			/*enabling per rx queue congestion control */
-			taildrop.threshold = CONG_THRESHOLD_RX_BYTES_Q;
-			taildrop.units = DPNI_CONGESTION_UNIT_BYTES;
-			taildrop.oal = CONG_RX_OAL;
-			DPAA2_PMD_DEBUG("Enabling Byte based Drop on queue= %d",
-					rx_queue_id);
-			ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
-						DPNI_CP_QUEUE, DPNI_QUEUE_RX,
-						dpaa2_q->tc_index, flow_id,
-						&taildrop);
-		}
-		if (ret) {
-			DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)",
-				ret);
-			goto err_free_dpcon;
-		}
-	} else { /* Disable tail Drop */
-		struct dpni_taildrop taildrop = {0};
-		DPAA2_PMD_INFO("Tail drop is disabled on queue");
-
-		taildrop.enable = 0;
-		if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
-			ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
-					DPNI_CP_CONGESTION_GROUP, DPNI_QUEUE_RX,
-					dpaa2_q->tc_index,
-					dpaa2_q->cgid, &taildrop);
-		} else {
-			ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
-					DPNI_CP_QUEUE, DPNI_QUEUE_RX,
-					dpaa2_q->tc_index, flow_id, &taildrop);
-		}
-		if (ret) {
-			DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)",
-				ret);
-			goto err_free_dpcon;
-		}
+	/* Private CGR will use tail drop length as nb_rx_desc * queues per TC.
+	 * For rest cases we can use standard byte based tail drop.
+	 * There is no HW restriction, but number of CGRs are limited,
+	 * hence this restriction is placed.
+	 */
+	if (cfg->cgid != DPAA2_INVALID_CGID &&
+		priv->cgid_in_use[dpaa2_q->tc_index] == 1) {
+		/*enabling per TC congestion control */
+		taildrop.threshold = nb_rx_desc * priv->dist_queues;
+		taildrop.units = DPNI_CONGESTION_UNIT_FRAMES;
+		taildrop.oal = 0;
+		DPAA2_PMD_DEBUG("%s CG Tail Drop on TC%d",
+			taildrop.enable ? "Enabling" : "Disabling",
+			dpaa2_q->tc_index);
+		ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
+			DPNI_CP_CONGESTION_GROUP, DPNI_QUEUE_RX,
+			dpaa2_q->tc_index, cfg->cgid, &taildrop);
+	} else if (cfg->cgid == DPAA2_INVALID_CGID) {
+		/*enabling per rx queue congestion control */
+		taildrop.threshold = CONG_THRESHOLD_RX_BYTES_Q;
+		taildrop.units = DPNI_CONGESTION_UNIT_BYTES;
+		taildrop.oal = CONG_RX_OAL;
+		DPAA2_PMD_DEBUG("%s Byte based Drop on TC[%d].flow%d",
+			taildrop.enable ? "Enabling" : "Disabling",
+			dpaa2_q->tc_index, flow_id);
+		ret = dpni_set_taildrop(dpni, CMD_PRI_LOW, priv->token,
+			DPNI_CP_QUEUE, DPNI_QUEUE_RX,
+			dpaa2_q->tc_index, flow_id, &taildrop);
+	}
+	if (ret) {
+		rte_free(dpaa2_q->cfg);
+		dpaa2_q->cfg = NULL;
+		DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)", ret);
+		return ret;
 	}
 
+	dpaa2_q->options = qopt;
+
 	dev->data->rx_queues[rx_queue_id] = dpaa2_q;
 	return 0;
 
@@ -1150,8 +1134,8 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	struct fsl_mc_io *dpni = dev->process_private;
 	struct dpni_queue tx_conf_cfg;
 	struct dpni_queue tx_flow_cfg;
-	uint8_t options = 0, flow_id;
-	uint16_t channel_id;
+	uint8_t qopt = 0;
+	uint16_t channel_id, flow_id;
 	struct dpni_queue_id qid;
 	uint32_t tc_id;
 	int ret;
@@ -1181,7 +1165,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		channel_id = priv->tx_channels[priv->num_channels - 1];
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_TX,
-			DPNI_BUILD_PARAM(channel_id, tc_id), flow_id, options, &tx_flow_cfg);
+			DPNI_BUILD_PARAM(channel_id, tc_id), flow_id, qopt, &tx_flow_cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Failed(%d) to set %s's TC[%d].txq[%d]",
 			ret, dev->data->name, tc_id, flow_id);
@@ -1190,7 +1174,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 			DPNI_QUEUE_TX, DPNI_BUILD_PARAM(channel_id, tc_id),
-			flow_id, &tx_flow_cfg, &qid);
+			dpaa2_q->flow_id, &tx_flow_cfg, &qid);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in getting LFQID err=%d", ret);
 		return ret;
@@ -1242,12 +1226,12 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		tc_id = dpaa2_tx_conf_q->tc_index;
 		flow_id = dpaa2_tx_conf_q->flow_id;
 		dpaa2_q->tx_conf_queue = dpaa2_tx_conf_q;
-		options = options | DPNI_QUEUE_OPT_USER_CTX;
+		qopt |= DPNI_QUEUE_OPT_USER_CTX;
 		tx_conf_cfg.user_context = (size_t)(dpaa2_q);
 		ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
 				DPNI_QUEUE_TX_CONFIRM,
 				DPNI_BUILD_PARAM(channel_id, tc_id),
-				flow_id, options, &tx_conf_cfg);
+				flow_id, qopt, &tx_conf_cfg);
 		if (ret) {
 			DPAA2_PMD_ERR("Set TC[%d].TX[%d] conf flow err=%d",
 				tc_id, flow_id, ret);
@@ -1296,30 +1280,29 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	struct dpaa2_queue *dpaa2_q = dev->data->rx_queues[rx_queue_id];
 	struct dpaa2_dev_priv *priv = dpaa2_q->eth_data->dev_private;
 	struct fsl_mc_io *dpni = priv->eth_dev->process_private;
-	uint8_t options = 0;
+	uint8_t qopt = 0;
 	int ret;
-	struct dpni_queue cfg;
+	struct dpni_queue *cfg = dpaa2_q->cfg;
 
-	memset(&cfg, 0, sizeof(struct dpni_queue));
 	PMD_INIT_FUNC_TRACE();
 
 	total_nb_rx_desc -= dpaa2_q->nb_desc;
 
-	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
-		options = DPNI_QUEUE_OPT_CLEAR_CGID;
-		cfg.cgid = dpaa2_q->cgid;
-
-		ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
-				     DPNI_QUEUE_RX,
-				     dpaa2_q->tc_index, dpaa2_q->flow_id,
-				     options, &cfg);
-		if (ret)
-			DPAA2_PMD_ERR("Unable to clear CGR from q=%u err=%d",
-					dpaa2_q->fqid, ret);
-		priv->cgid_in_use[dpaa2_q->cgid] = 0;
-		dpaa2_q->cgid = DPAA2_INVALID_CGID;
+	if (cfg) {
+		if (cfg->cgid != DPAA2_INVALID_CGID) {
+			qopt = DPNI_QUEUE_OPT_CLEAR_CGID;
+			ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
+				DPNI_QUEUE_RX, dpaa2_q->tc_index, dpaa2_q->flow_id,
+				qopt, cfg);
+			if (ret) {
+				DPAA2_PMD_ERR("Unable to clear CGR from TC[%d].flow%d err=%d",
+					dpaa2_q->tc_index, dpaa2_q->flow_id, ret);
+			}
+			priv->cgid_in_use[cfg->cgid]--;
+		}
+		rte_free(cfg);
+		dpaa2_q->cfg = NULL;
 	}
-
 	/* keep the DPCON on the FQ across a reconfigure; freed at dev_close */
 	if (dpaa2_q->napi_dpcon)
 		dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
@@ -2835,10 +2818,12 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
 	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
 	uint8_t flow_id = dpaa2_ethq->flow_id;
-	struct dpni_queue cfg;
+	struct dpni_queue *cfg;
 	uint8_t options, priority;
 	int ret;
 
+	cfg = dpaa2_ethq->cfg;
+
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_PARALLEL)
 		dpaa2_ethq->cb = dpaa2_dev_process_parallel_event;
 	else if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ATOMIC)
@@ -2851,15 +2836,19 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	priority = (RTE_EVENT_DEV_PRIORITY_LOWEST / queue_conf->ev.priority) *
 		   (dpcon->num_priorities - 1);
 
-	memset(&cfg, 0, sizeof(struct dpni_queue));
+	if (!cfg) {
+		DPAA2_PMD_ERR("%s: %s-rxq%d was not setup yet!",
+			__func__, dev->data->name, eth_rx_queue_id);
+		return -EINVAL;
+	}
 	options = DPNI_QUEUE_OPT_DEST;
-	cfg.destination.type = DPNI_DEST_DPCON;
-	cfg.destination.id = dpcon->dpcon_id;
-	cfg.destination.priority = priority;
+	cfg->destination.type = DPNI_DEST_DPCON;
+	cfg->destination.id = dpcon->dpcon_id;
+	cfg->destination.priority = priority;
 
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ATOMIC) {
 		options |= DPNI_QUEUE_OPT_HOLD_ACTIVE;
-		cfg.destination.hold_active = 1;
+		cfg->destination.hold_active = 1;
 	}
 
 	if (queue_conf->ev.sched_type == RTE_SCHED_TYPE_ORDERED &&
@@ -2898,16 +2887,16 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	}
 
 	options |= DPNI_QUEUE_OPT_USER_CTX;
-	cfg.user_context = (size_t)(dpaa2_ethq);
+	cfg->user_context = (size_t)(dpaa2_ethq);
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, eth_priv->token, DPNI_QUEUE_RX,
-			     dpaa2_ethq->tc_index, flow_id, options, &cfg);
+			     dpaa2_ethq->tc_index, flow_id, options, cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in dpni_set_queue: ret: %d", ret);
 		return ret;
 	}
 
-	memcpy(&dpaa2_ethq->ev, &queue_conf->ev, sizeof(struct rte_event));
+	rte_memcpy(&dpaa2_ethq->ev, &queue_conf->ev, sizeof(struct rte_event));
 
 	return 0;
 }
@@ -2919,17 +2908,15 @@ int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
 	struct dpaa2_dev_priv *eth_priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
 	struct dpaa2_queue *dpaa2_ethq = eth_priv->rx_vq[eth_rx_queue_id];
-	uint8_t flow_id = dpaa2_ethq->flow_id;
-	struct dpni_queue cfg;
-	uint8_t options;
+	struct dpni_queue *cfg;
 	int ret;
 
-	memset(&cfg, 0, sizeof(struct dpni_queue));
-	options = DPNI_QUEUE_OPT_DEST;
-	cfg.destination.type = DPNI_DEST_NONE;
+	cfg = dpaa2_ethq->cfg;
+	cfg->destination.type = DPNI_DEST_NONE;
+	dpaa2_ethq->options &= ~DPNI_QUEUE_OPT_DEST;
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, eth_priv->token, DPNI_QUEUE_RX,
-			     dpaa2_ethq->tc_index, flow_id, options, &cfg);
+		dpaa2_ethq->tc_index, dpaa2_ethq->flow_id, dpaa2_ethq->options, cfg);
 	if (ret)
 		DPAA2_PMD_ERR("Error in dpni_set_queue: ret: %d", ret);
 
@@ -3550,10 +3537,15 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	rte_spinlock_init(&priv->meter_lock);
 
 	/* only if the custom CG is enabled */
-	if (attr.options & DPNI_OPT_CUSTOM_CG)
+	if (attr.options & DPNI_OPT_CUSTOM_CG) {
 		priv->max_cgs = attr.num_cgs;
-	else
+		if (priv->max_cgs < priv->num_rx_tc) {
+			DPAA2_PMD_WARN("DPNI%d has no enough cgids(%d) to set %d TCs",
+				hw_id, priv->max_cgs, priv->num_rx_tc);
+		}
+	} else {
 		priv->max_cgs = 0;
+	}
 
 	for (i = 0; i < priv->max_cgs; i++)
 		priv->cgid_in_use[i] = 0;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 33bbd666c9..6eafa9a9e7 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -479,7 +479,8 @@ struct dpaa2_dev_priv {
 	uint8_t en_ordered;
 	uint8_t en_loose_ordered;
 	uint8_t max_cgs;
-	uint8_t cgid_in_use[MAX_RX_QUEUES];
+	/** RXQs in same TC share same cgid.*/
+	uint8_t cgid_in_use[MAX_TCS];
 	rte_spinlock_t meter_lock;
 	/* Lowest priority FS flow id to receive flow steering miss frames. */
 	uint16_t default_flow;
-- 
2.43.0

