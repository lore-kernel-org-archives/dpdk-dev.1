Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4F606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C60240E12;
	Fri, 30 Oct 2026 06:20:44 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 2910740A77
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:34 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE0732000CA;
 Fri, 30 Oct 2026 06:20:33 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82024200094;
 Fri, 30 Oct 2026 06:20:33 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E6F01800224;
 Fri, 30 Oct 2026 13:20:32 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 11/14] drivers: net/dpaa2 cache Rx queue config and
 share TC CGIDs
Date: Fri, 30 Oct 2026 10:50:13 +0530
Message-ID: <20261030052016.3301766-12-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Rework DPAA2 Rx queue setup so the DPNI queue descriptor is allocated
once per Rx queue and reused on later reconfiguration (eventq attach /
detach, release), and change congestion-group (CGID) allocation from
one CGID per Rx queue to one CGID shared by all Rx queues of the same
traffic class.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        | 274 ++++++++++++------------
 drivers/net/dpaa2/dpaa2_ethdev.h        |   3 +-
 3 files changed, 136 insertions(+), 144 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 52e6aa0bab..715c0298fc 100644
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
index ae88f11675..001c7275dc 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -735,6 +735,9 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
+			if (dpaa2_q->cfg)
+				rte_free(dpaa2_q->cfg);
+			dpaa2_q->cfg = NULL;
 			priv->rx_vq[i] = NULL;
 		}
 		/* cleanup tx queue cscn */
@@ -987,11 +990,12 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	struct fsl_mc_io *dpni = dev->process_private;
 	bool dpcon_allocated = false;
 	struct dpaa2_queue *dpaa2_q;
-	struct dpni_queue cfg;
-	uint8_t options = 0;
-	uint8_t flow_id;
+	struct dpni_queue *cfg = NULL;
+	struct dpni_taildrop taildrop;
+	uint8_t qopt = 0;
+	uint16_t flow_id;
 	uint32_t bpid;
-	int i, ret;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1028,6 +1032,10 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -1042,144 +1050,120 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		dpaa2_q->napi_dpcon = rte_dpaa2_alloc_dpcon_dev();
 		if (!dpaa2_q->napi_dpcon) {
 			DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue interrupts",
-				      rx_queue_id);
-			return -ENODEV;
+				rx_queue_id);
+			ret = -ENODEV;
+			goto err_quit;
 		}
 		dpcon_allocated = true;
 		/* the DPCON must be enabled to generate CDAN notifications */
 		ret = dpcon_enable(&dpaa2_q->napi_dpcon->dpcon, CMD_PRI_LOW,
-				   dpaa2_q->napi_dpcon->token);
+				dpaa2_q->napi_dpcon->token);
 		if (ret) {
 			DPAA2_PMD_ERR("rxq %d: dpcon_enable: %d", rx_queue_id, ret);
-			goto err_free_dpcon;
+			goto err_quit;
 		}
 	}
 
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
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0,
-				&cfg.flc.value);
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0, &cfg->flc.value);
 			dpaa2_q->data_stashing_off = 1;
 		} else {
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1,
-				&cfg.flc.value);
+			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1, &cfg->flc.value);
 			dpaa2_q->data_stashing_off = 0;
 		}
-		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A) {
-			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1,
-				&cfg.flc.value);
-		}
+		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A)
+			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1, &cfg->flc.value);
 	}
+
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_RX,
-			dpaa2_q->tc_index, flow_id, options, &cfg);
+			dpaa2_q->tc_index, flow_id, qopt, cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in setting the rx flow: = %d", ret);
-		goto err_free_dpcon;
+		goto err_quit;
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
 	}
+	if (ret) {
+		DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)", ret);
+		goto err_quit;
+	}
+
+	dpaa2_q->options = qopt;
 
 	dev->data->rx_queues[rx_queue_id] = dpaa2_q;
 	return 0;
 
-err_free_dpcon:
+err_quit:
+	if (cfg && cfg->cgid != DPAA2_INVALID_CGID &&
+		priv->cgid_in_use[dpaa2_q->tc_index])
+		priv->cgid_in_use[dpaa2_q->tc_index]--;
+	if (dpaa2_q->cfg) {
+		rte_free(dpaa2_q->cfg);
+		dpaa2_q->cfg = NULL;
+	}
 	/* free only the DPCON this call allocated; a pre-existing one belongs to
 	 * an earlier setup and is released at dev_close
 	 */
@@ -1203,8 +1187,8 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
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
@@ -1230,7 +1214,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	flow_id = dpaa2_q->flow_id;
 	channel_id = tx_queue_id % priv->num_channels;
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_TX,
-			DPNI_BUILD_PARAM(channel_id, tc_id), flow_id, options, &tx_flow_cfg);
+			DPNI_BUILD_PARAM(channel_id, tc_id), flow_id, qopt, &tx_flow_cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Failed(%d) to set %s's TC[%d].txq[%d].ch[%d]",
 			ret, dev->data->name, tc_id, flow_id, channel_id);
@@ -1239,7 +1223,7 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	ret = dpni_get_queue(dpni, CMD_PRI_LOW, priv->token,
 			DPNI_QUEUE_TX, DPNI_BUILD_PARAM(channel_id, tc_id),
-			flow_id, &tx_flow_cfg, &qid);
+			dpaa2_q->flow_id, &tx_flow_cfg, &qid);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in getting LFQID err=%d", ret);
 		return ret;
@@ -1291,12 +1275,12 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
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
@@ -1345,30 +1329,29 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
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
@@ -2885,10 +2868,12 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
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
@@ -2901,15 +2886,19 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
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
@@ -2942,16 +2931,16 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
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
@@ -2963,17 +2952,14 @@ int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
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
 
 	ret = dpni_set_queue(dpni, CMD_PRI_LOW, eth_priv->token, DPNI_QUEUE_RX,
-			     dpaa2_ethq->tc_index, flow_id, options, &cfg);
+		dpaa2_ethq->tc_index, dpaa2_ethq->flow_id, dpaa2_ethq->options, cfg);
 	if (ret)
 		DPAA2_PMD_ERR("Error in dpni_set_queue: ret: %d", ret);
 
@@ -3600,13 +3586,17 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	rte_spinlock_init(&priv->lpbk_qp_lock);
 
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
 
-	for (i = 0; i < priv->max_cgs; i++)
-		priv->cgid_in_use[i] = 0;
+	memset(priv->cgid_in_use, 0, MAX_TCS);
 
 	num_q_per_tc = attr.num_queues;
 	max_q_per_tc = MAX_RX_QUEUES / attr.num_rx_tcs;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index adf61b5a9f..e9cf8c9f88 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -453,7 +453,8 @@ struct dpaa2_dev_priv {
 	uint8_t en_ordered;
 	uint8_t en_loose_ordered;
 	uint8_t max_cgs;
-	uint8_t cgid_in_use[MAX_RX_QUEUES];
+	/** RXQs in same TC share same cgid.*/
+	uint8_t cgid_in_use[MAX_TCS];
 
 	/* Current hash distribution size per RX TC, written by
 	 * dpaa2_setup_flow_dist_size() and read by reta_query / reta_update.
-- 
2.43.0

