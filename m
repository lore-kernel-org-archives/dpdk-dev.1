Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D8C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 13:59:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 551A042EAB;
	Thu,  3 Sep 2026 15:54:57 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 33B0E42E81
 for <dev@dpdk.org>; Thu,  3 Sep 2026 15:54:46 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 184E41A0075;
 Thu,  3 Sep 2026 15:54:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D6DA41A0035;
 Thu,  3 Sep 2026 15:54:45 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F582180006C;
 Thu,  3 Sep 2026 21:54:44 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH 42/45] net/dpaa2: read MC version from device private data
Date: Thu,  3 Sep 2026 19:23:50 +0530
Message-ID: <20260903135353.3358303-43-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

The flow engine reached back to the bus device to read the MC firmware
version. The bus_info pointer behind it is only attached by the primary
process, so a secondary process that creates a flow dereferences a
pointer it never set up.

The version is already cached in priv->mc_rev at probe time and the rest
of the driver reads it from there, so use that here too. This removes the
last user of DPAA2_DEV_PRIV_TO_DPAA2_DEV(), so drop the macro.

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h |  4 ---
 drivers/net/dpaa2/dpaa2_flow.c   | 59 ++++++++++----------------------
 2 files changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 7d93b75be3..e02fa9a622 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -43,10 +43,6 @@
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
-#define DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv) \
-	container_of((((struct dpaa2_dev_priv *)priv)->eth_dev->device), \
-	struct rte_dpaa2_device, device)
-
 #define DPAA2_EXTRACT_PARAM_MAX_SIZE \
 	RTE_ALIGN(sizeof(struct dpni_ext_set_rx_tc_dist), 256)
 
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 8456b3b80d..187381c5dd 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -781,13 +781,10 @@ static int
 dpaa2_flow_add_fs_rule(struct dpaa2_dev_priv *priv,
 	struct dpaa2_generic_flow *flow)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpaa2_flow_tbl_profile *tbl_profile;
 	int ret;
 	struct fsl_mc_io *dpni = priv->hw;
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-
 	tbl_profile = &priv->flow_profile.tc_profile[flow->tc_id];
 	if (dpaa2_flow_entry_map_get(tbl_profile->entry_map,
 		flow->entry_index)) {
@@ -798,7 +795,7 @@ dpaa2_flow_add_fs_rule(struct dpaa2_dev_priv *priv,
 
 	dpaa2_flow_fs_entry_log("Add", flow);
 
-	if (dpaa2_dev->bus_info->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
+	if (priv->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
 		ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
 			priv->token, flow->tc_id, flow->entry_index,
 			&flow->rule_cfg, &flow->flow_action.fs_action.fs_action_cfg);
@@ -3642,7 +3639,6 @@ dpaa2_flow_fs_action_config(struct dpaa2_dev_priv *priv,
 	struct dpaa2_generic_flow *flow,
 	const struct rte_flow_action *rte_action)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct rte_eth_dev *dest_dev;
 	struct dpaa2_dev_priv *dest_priv;
 	const struct rte_flow_action_queue *dest_queue;
@@ -3651,11 +3647,9 @@ dpaa2_flow_fs_action_config(struct dpaa2_dev_priv *priv,
 	uint16_t num_tokens;
 	struct dpaa2_dev_flow_fs_action *fs_action;
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-
 	fs_action = &flow->flow_action.fs_action;
 	if (fs_action->action_type != RTE_FLOW_ACTION_TYPE_END) {
-		if (dpaa2_dev->bus_info->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV &&
+		if (priv->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV &&
 			(fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
 			fs_action->action_type == RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR)) {
 			if (rte_action->type != RTE_FLOW_ACTION_TYPE_PORT_ID &&
@@ -3807,21 +3801,19 @@ dpaa2_flow_fs_table_set_default(struct dpaa2_dev_priv *priv,
 	uint8_t tc_id, int discard, uint16_t default_queue)
 {
 	int ret;
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpni_rx_dist_cfg *tc_cfg;
 	struct fsl_mc_io *dpni = priv->hw;
 	struct dpaa2_flow_tbl_profile *tbl_profile;
 	struct dpaa2_queue *queue;
 	char mc_rev[1024];
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
 	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
 	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
-		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
-		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
-		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+		RTE_FSL_MC_REV_MAJOR(priv->mc_rev),
+		RTE_FSL_MC_REV_MINOR(priv->mc_rev),
+		RTE_FSL_MC_REV_REVISION(priv->mc_rev));
 	if (!tbl_profile->dpkg.num_extracts &&
-		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
 		DPAA2_PMD_DEBUG("%s can't set miss action of FS table indepentently.",
 			mc_rev);
 		return 0;
@@ -3946,26 +3938,24 @@ dpaa2_flow_qos_table_set_default(struct dpaa2_dev_priv *priv,
 	int discard, uint8_t default_tc, uint16_t default_flow)
 {
 	int ret;
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpni_qos_tbl_cfg qos_cfg;
 	struct fsl_mc_io *dpni = priv->hw;
 	struct dpaa2_flow_tbl_profile *tbl_profile;
 	char mc_rev[1024];
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
 	tbl_profile = &priv->flow_profile.qos_profile;
 	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
-		RTE_FSL_MC_REV_MAJOR(dpaa2_dev->bus_info->mc_rev),
-		RTE_FSL_MC_REV_MINOR(dpaa2_dev->bus_info->mc_rev),
-		RTE_FSL_MC_REV_REVISION(dpaa2_dev->bus_info->mc_rev));
+		RTE_FSL_MC_REV_MAJOR(priv->mc_rev),
+		RTE_FSL_MC_REV_MINOR(priv->mc_rev),
+		RTE_FSL_MC_REV_REVISION(priv->mc_rev));
 	if (!tbl_profile->dpkg.num_extracts &&
-		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
 		DPAA2_PMD_DEBUG("%s can't set miss action of QoS table indepentently.",
 			mc_rev);
 		return 0;
 	}
 	if (default_flow < priv->dist_queues &&
-		dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) {
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) {
 		DPAA2_PMD_WARN("%s can't direct miss traffic to TC%d-flow%d by QoS table only.",
 			mc_rev, default_tc, default_flow);
 		return 0;
@@ -4002,7 +3992,6 @@ static int
 dpaa2_flow_qos_table_config(struct dpaa2_dev_priv *priv,
 	int rss_dist)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpaa2_flow_tbl_profile *tbl_profile;
 	uint8_t *key_cfg_buf;
 	int ret;
@@ -4064,8 +4053,7 @@ dpaa2_flow_qos_table_config(struct dpaa2_dev_priv *priv,
 			qos_cfg->discard_on_miss = false;
 	}
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-	if (dpaa2_dev->bus_info->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
+	if (priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
 		ret = dpni_set_qos_table_v2(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
 	else
 		ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
@@ -4209,7 +4197,6 @@ static int
 dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
 	uint8_t tc_id, const struct rte_flow_action_meter_mark *meter_mark)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpni_rx_tc_policing_cfg policing_cfg = {0};
 	const struct dpaa2_dev_meter_profile *dpaa2_profile;
 	const struct dpaa2_dev_meter_policy *dpaa2_policy = NULL;
@@ -4221,8 +4208,6 @@ dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
 		return -ENOTSUP;
 	}
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-
 	dpaa2_profile = (void *)meter_mark->profile;
 	if (!dpaa2_profile) {
 		DPAA2_PMD_ERR("Meter profile not specified!");
@@ -4244,9 +4229,8 @@ dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
 
 	if (priv->flow_profile.mtr_flow[tc_id]) {
 		/** Update existing policer.*/
-		dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
 		policing_cfg.options |= DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS;
-		if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV)
+		if (priv->mc_rev < DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV)
 			DPAA2_PMD_WARN("The existing policer's counters will be cleaned.");
 	}
 
@@ -4269,7 +4253,7 @@ dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
 	policing_cfg.eir = dpaa2_profile->pir;
 	policing_cfg.ebs = dpaa2_profile->pbs;
 
-	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+	if (priv->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
 		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
 			priv->token, tc_id, &policing_cfg);
 	} else {
@@ -5400,7 +5384,6 @@ dpaa2_flow_generic_flow_create(struct rte_eth_dev *dev,
 	int mix_extract, int is_rss)
 {
 	struct dpaa2_generic_flow *flow = NULL;
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	int ret, idx = -1;
 	uint64_t iova, mc_rev;
@@ -5416,8 +5399,7 @@ dpaa2_flow_generic_flow_create(struct rte_eth_dev *dev,
 	if (type != DPAA2_FLOW_QOS_TYPE && type != DPAA2_FLOW_FS_TYPE)
 		return NULL;
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-	mc_rev = dpaa2_dev->bus_info->mc_rev;
+	mc_rev = priv->mc_rev;
 
 	if (actions) {
 		ret = dpaa2_flow_qos_fs_action_set(actions, qos_actions,
@@ -5912,19 +5894,17 @@ static int
 dpaa2_flow_destroy_meter_flow(struct rte_eth_dev *dev,
 	struct dpaa2_dev_flow *flow)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpni_rx_tc_policing_cfg cfg;
 	int ret;
 	uint8_t tc_id;
 
 	RTE_ASSERT(!flow->qos_flow && flow->fs_flow);
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
 	tc_id = flow->fs_flow->tc_id;
 	RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == flow);
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.mode = DPNI_POLICER_MODE_NONE;
-	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+	if (priv->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
 		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
 			priv->token, tc_id, &cfg);
 	} else {
@@ -6141,7 +6121,6 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 	const struct rte_flow_action actions[],
 	struct rte_flow_error *error)
 {
-	struct rte_dpaa2_device *dpaa2_dev;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_dev_flow *flow;
 	struct dpaa2_flow_tbl_profile *tbl_profile = NULL;
@@ -6162,8 +6141,6 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 	const struct rte_flow_action_queue *action_q;
 	struct dpaa2_queue *rxq = NULL;
 
-	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
-
 	/* check for the valid flow */
 	flow = (void *)_flow;
 	if (flow->is_meter_flow) {
@@ -6275,7 +6252,7 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 	if (fs_action_num > 0 &&
 		fs_actions[0].type != RTE_FLOW_ACTION_TYPE_PORT_ID &&
 		fs_actions[0].type != RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT &&
-		dpaa2_dev->bus_info->mc_rev >= DPAA2_FS_FLOW_HW_ACTION_UPDATE_MC_REV) {
+		priv->mc_rev >= DPAA2_FS_FLOW_HW_ACTION_UPDATE_MC_REV) {
 		/** Action HW update doesn't support redirecting frames to other DPNIs.*/
 		hw_update = true;
 		goto skip_remove_fs_entry;
@@ -6365,7 +6342,7 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 	}
 
 	hw_update = false;
-	if (dpaa2_dev->bus_info->mc_rev >= DPAA2_QOS_FLOW_HW_ACTION_UPDATE_MC_REV) {
+	if (priv->mc_rev >= DPAA2_QOS_FLOW_HW_ACTION_UPDATE_MC_REV) {
 		/** Action HW update doesn't support redirecting frames to other DPNIs.*/
 		hw_update = true;
 		goto skip_remove_qos_entry;
-- 
2.43.0

