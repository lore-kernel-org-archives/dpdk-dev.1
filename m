Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA91C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:56:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD4D342EA3;
	Thu, 10 Sep 2026 15:52:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1637542E49
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:47 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EFC5D1A00E6;
 Thu, 10 Sep 2026 15:52:46 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FECB1A0043;
 Thu, 10 Sep 2026 15:52:46 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 360FA180006C;
 Thu, 10 Sep 2026 21:52:45 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 38/47] net/dpaa2: support flow meter and policer actions
Date: Thu, 10 Sep 2026 19:21:49 +0530
Message-ID: <20260910135158.2181141-39-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Add support for the METER and METER_MARK flow actions. A meter flow is
programmed per traffic class and configures the DPNI policer from the
meter profile and policy that were created through the meter ops.

Meter flows carry a single action and are tracked separately from the
regular QoS and flow steering entries, so flow create, destroy and
action update dispatch them through a dedicated path.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 316 +++++++++++++++++++++++++++++++++
 1 file changed, 316 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index f86e1c0acc..e86e6d1f8b 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -111,6 +111,7 @@ struct dpaa2_dev_flow {
 	struct dpaa2_generic_flow *qos_flow;
 	struct dpaa2_generic_flow *fs_flow;
 	struct dpaa2_dev_priv *priv;
+	int is_meter_flow;
 };
 
 struct rte_dpaa2_flow_item {
@@ -158,6 +159,10 @@ static const enum rte_flow_action_type dpaa2_supported_qos_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_DROP
 };
 
+static const enum rte_flow_action_type dpaa2_supported_meter_action_type[] = {
+	RTE_FLOW_ACTION_TYPE_METER_MARK,
+	RTE_FLOW_ACTION_TYPE_METER
+};
 
 #define DPAA2_FLOW_HDR_HEX_DUMP_SIZE \
 	(RTE_MAX(sizeof(struct rte_flow_item_eth), \
@@ -3619,6 +3624,10 @@ dpaa2_flow_verify_fs_action(struct dpaa2_dev_priv *priv,
 			/* Skip this action, have to add for vxlan*/
 		case RTE_FLOW_ACTION_TYPE_DROP:
 			break;
+		case RTE_FLOW_ACTION_TYPE_METER_MARK:
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER:
+			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			end_of_list = 1;
 			break;
@@ -4062,7 +4071,146 @@ dpaa2_flow_table_update(struct dpaa2_dev_priv *priv,
 	return 0;
 }
 
+static int
+dpaa2_flow_action_meter_mark_init(struct dpaa2_dev_priv *priv,
+	uint32_t mtr_id, struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct dpaa2_dev_meter *meter;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	int found = 0;
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			found = 1;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d) is not found!", mtr_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile) {
+		if (profile->profile_id == meter->profile_id) {
+			found = 1;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d)'s profile(%d) not exist!",
+			mtr_id, meter->profile_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy) {
+		if (policy->policy_id == meter->policy_id) {
+			found = 1;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		/** Option.*/
+		DPAA2_PMD_WARN("Meter ID(%d)'s policy(%d) not exist!",
+			mtr_id, meter->policy_id);
+		policy = NULL;
+	}
 
+	meter_mark->profile = (void *)profile;
+	meter_mark->policy = (void *)policy;
+	meter_mark->color_mode = 1;
+
+	return 0;
+}
+
+static int
+dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, const struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpni_rx_tc_policing_cfg policing_cfg = {0};
+	const struct dpaa2_dev_meter_profile *dpaa2_profile;
+	const struct dpaa2_dev_meter_policy *dpaa2_policy = NULL;
+	int ret;
+
+	if (!(priv->options & DPNI_OPT_HAS_POLICING)) {
+		DPAA2_PMD_ERR("POLICING(0x%08x) was not added in DPNI creating options(0x%08x)",
+			DPNI_OPT_HAS_POLICING, priv->options);
+		return -ENOTSUP;
+	}
+
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+
+	dpaa2_profile = (void *)meter_mark->profile;
+	if (!dpaa2_profile) {
+		DPAA2_PMD_ERR("Meter profile not specified!");
+		return -EINVAL;
+	}
+
+	/** Blind as default.*/
+	policing_cfg.options = 0;
+	if (meter_mark->color_mode)
+		policing_cfg.options = DPNI_POLICER_OPT_COLOR_AWARE;
+	if (meter_mark->policy)
+		dpaa2_policy = (void *)meter_mark->policy;
+	if (dpaa2_policy && dpaa2_policy->red_drop) {
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	} else if (!dpaa2_policy) {
+		/** Default: Red is discarded if no policy specified.*/
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	}
+
+	if (priv->flow_profile.mtr_flow[tc_id]) {
+		/** Update existing policer.*/
+		dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+		policing_cfg.options |= DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS;
+		if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV)
+			DPAA2_PMD_WARN("The existing policer's counters will be cleaned.");
+	}
+
+	policing_cfg.mode = dpaa2_profile->mode;
+	if (policing_cfg.mode < DPNI_POLICER_MODE_NONE ||
+		policing_cfg.mode > DPNI_POLICER_MODE_RFC_4115) {
+		DPAA2_PMD_ERR("Invalid policer mode(%d)",
+			policing_cfg.mode);
+		return -EINVAL;
+	}
+	policing_cfg.units = dpaa2_profile->policer_unit;
+	if (policing_cfg.units < DPNI_POLICER_UNIT_BYTES_L3 ||
+		policing_cfg.units > DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS) {
+		DPAA2_PMD_ERR("Invalid policer units(%d)",
+			policing_cfg.units);
+		return -EINVAL;
+	}
+	policing_cfg.cir = dpaa2_profile->cir;
+	policing_cfg.cbs = dpaa2_profile->cbs;
+	policing_cfg.eir = dpaa2_profile->pir;
+	policing_cfg.ebs = dpaa2_profile->pbs;
+
+	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	}
+	DPAA2_PMD_INFO("%s RX TC%d policer configure %s.",
+		priv->eth_dev->data->name, tc_id,
+		ret ? "failed" : "successfully");
+	if (!ret)
+		priv->flow_profile.tc_mtr_profile[tc_id] = (void *)meter_mark->profile;
+
+	return ret;
+}
 
 static int
 dpaa2_flow_action_single_type_check(const struct rte_flow_action actions[],
@@ -4119,6 +4267,8 @@ dpaa2_flow_fs_action_update(struct dpaa2_dev_priv *priv,
 	const struct rte_flow_action actions[])
 {
 	int end_of_list = 0, ret = 0, i = 0;
+	const struct rte_flow_action_meter *meter;
+	struct rte_flow_action_meter_mark meter_mark;
 	union dpaa2_dev_flow_action flow_action_rollback;
 
 	rte_memcpy(&flow_action_rollback, &fs_flow->flow_action,
@@ -4136,6 +4286,26 @@ dpaa2_flow_fs_action_update(struct dpaa2_dev_priv *priv,
 			if (ret)
 				goto end_action_set;
 
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER_MARK:
+			rte_memcpy(&meter_mark, actions[i].conf,
+				sizeof(meter_mark));
+			ret = dpaa2_flow_set_police_action(priv,
+				fs_flow->tc_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER:
+			meter = actions[i].conf;
+			ret = dpaa2_flow_action_meter_mark_init(priv,
+				meter->mtr_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+			ret = dpaa2_flow_set_police_action(priv,
+				fs_flow->tc_id, &meter_mark);
+			if (ret)
+				goto end_action_set;
+
 			break;
 		case RTE_FLOW_ACTION_TYPE_PF:
 			/* Skip this action, have to add for vxlan*/
@@ -4557,6 +4727,29 @@ dpaa2_flow_validate(struct rte_eth_dev *dev,
 		}
 	}
 
+	supported = dpaa2_supported_meter_action_type;
+	supported_len = RTE_DIM(dpaa2_supported_meter_action_type);
+	if (dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+		DPAA2_PMD_DEBUG("This is meter flow.");
+		if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+			err_str = "Meter flow's type can't be QoS flow.";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			ret = -EPERM;
+			goto invalid_params;
+		}
+		if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+			err_str = "Meter flow can't support multi-actions.";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+			ret = -EPERM;
+			goto invalid_params;
+		}
+		if (pattern)
+			DPAA2_PMD_WARN("Meter flow ingores flow items!");
+		return 0;
+	}
+
 	/* Verify input action list */
 	if (group_type == RTE_DPAA2_ONE_LEVEL_GROUP_FLOW ||
 		group_type == RTE_DPAA2_FS_GROUP_FLOW) {
@@ -5383,6 +5576,51 @@ dpaa2_flow_generic_flow_create(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+static struct rte_flow *
+dpaa2_flow_create_meter_flow(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_action meter_action[])
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *flow = NULL;
+	struct dpaa2_generic_flow *fs_flow = NULL;
+	int ret;
+
+	if (attr->group >= priv->num_rx_tc)
+		return NULL;
+
+	if (priv->flow_profile.mtr_flow[attr->group])
+		return NULL;
+
+	fs_flow = rte_zmalloc(NULL, sizeof(struct dpaa2_generic_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!fs_flow) {
+		DPAA2_PMD_ERR("Failure to allocate memory for flow");
+		return NULL;
+	}
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		rte_free(fs_flow);
+		DPAA2_PMD_ERR("Failure to allocate memory for flow");
+		return NULL;
+	}
+	fs_flow->tc_id = attr->group;
+	fs_flow->priv = priv;
+	flow->fs_flow = fs_flow;
+	flow->priv = priv;
+
+	ret = dpaa2_flow_fs_action_update(priv, fs_flow, meter_action);
+	if (ret) {
+		rte_free(fs_flow);
+		rte_free(flow);
+		return NULL;
+	}
+	flow->is_meter_flow = true;
+	priv->flow_profile.mtr_flow[fs_flow->tc_id] = flow;
+
+	return (struct rte_flow *)flow;
+}
 
 static struct rte_flow *
 dpaa2_flow_create(struct rte_eth_dev *dev,
@@ -5447,6 +5685,30 @@ dpaa2_flow_create(struct rte_eth_dev *dev,
 		rss_item = true;
 	}
 
+	if (dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_meter_action_type,
+		RTE_DIM(dpaa2_supported_meter_action_type))) {
+		/** Assume it's meter flow per TC.*/
+		if (group_type == RTE_DPAA2_QOS_GROUP_FLOW) {
+			error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+			err_code = -EINVAL;
+			err_str = "Failed to converts RSS config type to RSS items!";
+			goto flow_failure;
+		}
+		if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+			err_code = -EPERM;
+			err_str = "Meter flow can't support multi-actions.";
+			goto flow_failure;
+		}
+		flow = (void *)dpaa2_flow_create_meter_flow(dev, &local_attr, actions);
+		if (flow)
+			return (struct rte_flow *)flow;
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "Failed to create meter flow!";
+		goto flow_failure;
+	}
 
 	DPAA2_PMD_DEBUG("Port %s-%s: group type:%d, group id:%d, total RX TCs:%d",
 		dev->data->name, __func__, group_type, group_id, priv->num_rx_tc);
@@ -5573,6 +5835,38 @@ dpaa2_flow_create(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+static int
+dpaa2_flow_destroy_meter_flow(struct rte_eth_dev *dev,
+	struct dpaa2_dev_flow *flow)
+{
+	struct rte_dpaa2_device *dpaa2_dev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpni_rx_tc_policing_cfg cfg;
+	int ret;
+	uint8_t tc_id;
+
+	RTE_ASSERT(!flow->qos_flow && flow->fs_flow);
+	dpaa2_dev = DPAA2_DEV_PRIV_TO_DPAA2_DEV(priv);
+	tc_id = flow->fs_flow->tc_id;
+	RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == flow);
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.mode = DPNI_POLICER_MODE_NONE;
+	if (dpaa2_dev->bus_info->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	}
+	if (ret)
+		return ret;
+	priv->flow_profile.tc_mtr_profile[tc_id] = NULL;
+	priv->flow_profile.mtr_flow[tc_id] = NULL;
+	rte_free(flow->fs_flow);
+	rte_free(flow);
+
+	return 0;
+}
 
 static int
 dpaa2_flow_destroy(struct rte_eth_dev *dev,
@@ -5587,6 +5881,8 @@ dpaa2_flow_destroy(struct rte_eth_dev *dev,
 	RTE_SET_USED(error);
 
 	flow = (struct dpaa2_dev_flow *)_flow;
+	if (flow->is_meter_flow)
+		return dpaa2_flow_destroy_meter_flow(dev, flow);
 
 	LIST_REMOVE(flow, next);
 
@@ -5663,6 +5959,26 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 
 	/* check for the valid flow */
 	flow = (void *)_flow;
+	if (flow->is_meter_flow) {
+		RTE_ASSERT(flow->fs_flow);
+		tc_id = flow->fs_flow->tc_id;
+		RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == flow);
+		supported = dpaa2_supported_meter_action_type;
+		supported_len = RTE_DIM(dpaa2_supported_meter_action_type);
+		if (!dpaa2_flow_check_actions_support(actions, supported, supported_len)) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to verify meter action!";
+			err_code = -ENOTSUP;
+			goto quit;
+		}
+		ret = dpaa2_flow_fs_action_update(priv, flow->fs_flow, actions);
+		if (ret) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update meter action!";
+			err_code = ret;
+		}
+		goto quit;
+	}
 	LIST_FOREACH(flow, &priv->flows, next) {
 		if ((struct rte_flow *)flow == _flow)
 			goto action_update;
-- 
2.43.0

