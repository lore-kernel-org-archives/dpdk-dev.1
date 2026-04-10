Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760DCF44869
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:23:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD76A406BC;
	Fri, 10 Apr 2026 15:23:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8C0E740687
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775827378; x=1807363378;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6vXjoxQqB/9u7USY0422HdTxoh6cA01SuT75YGTFB+w=;
 b=lA1FOjrKZD3+V+dRxTZdZG23azpEqnhlXzDxvvW2mrDOj/ec2BbY/qJm
 KoZxudcXWsYCgg/f+Wc39oig2jurNbdnJwUj9jIt61W0Rwf5LOk5X0X3I
 uYNttxxxcZCapThnd0Gsz+31AqNcYDH+IuCg6rqf9ycOVfRCNlFMpPaOH
 JIyWvRPHnEvoxW2O2p00Ni4U2Negoe3/A8PMg0Mxs1cpLHMcCqi8znLZU
 DjHmqjXvxwQJcuOWP7UwAd2lgpUcD5UD4JX03XCJUX5BxldupWeuud0b3
 Hkv+XmJdpXdhsE9DA1P3q2QC5vp7Q0gzQlnR7DT7f6B/j0FyTQUGdViKS A==;
X-CSE-ConnectionGUID: bZJOrCsuSSCNdMCDEHkYMw==
X-CSE-MsgGUID: QaXS5FXCQ7K+rfPLcbXzyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76753681"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76753681"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:22:57 -0700
X-CSE-ConnectionGUID: xecwom4iR66BedTj5rvpgA==
X-CSE-MsgGUID: fLbQcUt9QHOlQucUw7hNlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="252451159"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2026 06:22:56 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 28/29] net/ice: use common action checks for switch
Date: Fri, 10 Apr 2026 14:22:48 +0100
Message-ID: <12b875066a26fe2b20c15a32259d9dc9d3e145a3.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Use the common flow action checking parsing infrastructure for checking
flow actions for switch filter.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_switch_filter.c | 370 +++++++++++-----------
 1 file changed, 184 insertions(+), 186 deletions(-)

diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index d8c0e7c59c..9a46e3b413 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -35,6 +35,8 @@
 #define ICE_IPV4_PROTO_NVGRE	0x002F
 #define ICE_SW_PRI_BASE 6
 
+#define ICE_SW_MAX_QUEUES	128
+
 #define ICE_SW_INSET_ETHER ( \
 	ICE_INSET_DMAC | ICE_INSET_SMAC | ICE_INSET_ETHERTYPE)
 #define ICE_SW_INSET_MAC_VLAN ( \
@@ -1527,85 +1529,38 @@ ice_switch_parse_pattern(const struct rte_flow_item pattern[],
 }
 
 static int
-ice_switch_parse_dcf_action(struct ice_dcf_adapter *ad,
-			    const struct rte_flow_action *actions,
+ice_switch_parse_dcf_action(const struct rte_flow_action *action,
 			    uint32_t priority,
 			    struct rte_flow_error *error,
 			    struct ice_adv_rule_info *rule_info)
 {
 	const struct rte_flow_action_ethdev *act_ethdev;
-	const struct rte_flow_action *action;
 	const struct rte_eth_dev *repr_dev;
 	enum rte_flow_action_type action_type;
-	uint16_t rule_port_id, backer_port_id;
 
-	for (action = actions; action->type !=
-				RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
-		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			rule_info->sw_act.fltr_act = ICE_FWD_TO_VSI;
-			act_ethdev = action->conf;
-
-			if (!rte_eth_dev_is_valid_port(act_ethdev->port_id))
-				goto invalid_port_id;
-
-			/* For traffic to original DCF port */
-			rule_port_id = ad->parent.pf.dev_data->port_id;
-
-			if (rule_port_id != act_ethdev->port_id)
-				goto invalid_port_id;
-
-			rule_info->sw_act.vsi_handle = 0;
-
-			break;
-
-invalid_port_id:
-			rte_flow_error_set(error,
-						EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-						actions,
-						"Invalid port_id");
-			return -rte_errno;
-
-		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-			rule_info->sw_act.fltr_act = ICE_FWD_TO_VSI;
-			act_ethdev = action->conf;
-
-			if (!rte_eth_dev_is_valid_port(act_ethdev->port_id))
-				goto invalid;
-
-			repr_dev = &rte_eth_devices[act_ethdev->port_id];
-
-			if (!repr_dev->data)
-				goto invalid;
-
-			rule_port_id = ad->parent.pf.dev_data->port_id;
-			backer_port_id = repr_dev->data->backer_port_id;
-
-			if (backer_port_id != rule_port_id)
-				goto invalid;
-
-			rule_info->sw_act.vsi_handle = repr_dev->data->representor_id;
-			break;
-
-invalid:
-			rte_flow_error_set(error,
-						EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-						actions,
-						"Invalid ethdev_port_id");
-			return -rte_errno;
-
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			rule_info->sw_act.fltr_act = ICE_DROP_PACKET;
-			break;
-
-		default:
-			rte_flow_error_set(error,
-					   EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					   actions,
-					   "Invalid action type");
-			return -rte_errno;
-		}
+	action_type = action->type;
+	switch (action_type) {
+	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+		rule_info->sw_act.fltr_act = ICE_FWD_TO_VSI;
+		rule_info->sw_act.vsi_handle = 0;
+		break;
+
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		rule_info->sw_act.fltr_act = ICE_FWD_TO_VSI;
+		act_ethdev = action->conf;
+		repr_dev = &rte_eth_devices[act_ethdev->port_id];
+		rule_info->sw_act.vsi_handle = repr_dev->data->representor_id;
+		break;
+
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		rule_info->sw_act.fltr_act = ICE_DROP_PACKET;
+		break;
+
+	default:
+		/* Should never reach */
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Invalid action type");
+		return -rte_errno;
 	}
 
 	rule_info->sw_act.src = rule_info->sw_act.vsi_handle;
@@ -1621,73 +1576,38 @@ ice_switch_parse_dcf_action(struct ice_dcf_adapter *ad,
 
 static int
 ice_switch_parse_action(struct ice_pf *pf,
-		const struct rte_flow_action *actions,
+		const struct rte_flow_action *action,
 		uint32_t priority,
 		struct rte_flow_error *error,
 		struct ice_adv_rule_info *rule_info)
 {
 	struct ice_vsi *vsi = pf->main_vsi;
-	struct rte_eth_dev_data *dev_data = pf->adapter->pf.dev_data;
 	const struct rte_flow_action_queue *act_q;
 	const struct rte_flow_action_rss *act_qgrop;
-	uint16_t base_queue, i;
-	const struct rte_flow_action *action;
+	uint16_t base_queue;
 	enum rte_flow_action_type action_type;
-	uint16_t valid_qgrop_number[MAX_QGRP_NUM_TYPE] = {
-		 2, 4, 8, 16, 32, 64, 128};
 
 	base_queue = pf->base_queue + vsi->base_queue;
-	for (action = actions; action->type !=
-			RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			act_qgrop = action->conf;
-			if (act_qgrop->queue_num <= 1)
-				goto error;
-			rule_info->sw_act.fltr_act =
-				ICE_FWD_TO_QGRP;
-			rule_info->sw_act.fwd_id.q_id =
-				base_queue + act_qgrop->queue[0];
-			for (i = 0; i < MAX_QGRP_NUM_TYPE; i++) {
-				if (act_qgrop->queue_num ==
-					valid_qgrop_number[i])
-					break;
-			}
-			if (i == MAX_QGRP_NUM_TYPE)
-				goto error;
-			if ((act_qgrop->queue[0] +
-				act_qgrop->queue_num) >
-				dev_data->nb_rx_queues)
-				goto error1;
-			for (i = 0; i < act_qgrop->queue_num - 1; i++)
-				if (act_qgrop->queue[i + 1] !=
-					act_qgrop->queue[i] + 1)
-					goto error2;
-			rule_info->sw_act.qgrp_size =
-				act_qgrop->queue_num;
-			break;
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			act_q = action->conf;
-			if (act_q->index >= dev_data->nb_rx_queues)
-				goto error;
-			rule_info->sw_act.fltr_act =
-				ICE_FWD_TO_Q;
-			rule_info->sw_act.fwd_id.q_id =
-				base_queue + act_q->index;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			rule_info->sw_act.fltr_act =
-				ICE_DROP_PACKET;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-
-		default:
-			goto error;
-		}
+	action_type = action->type;
+	switch (action_type) {
+	case RTE_FLOW_ACTION_TYPE_RSS:
+		act_qgrop = action->conf;
+		rule_info->sw_act.fltr_act = ICE_FWD_TO_QGRP;
+		rule_info->sw_act.fwd_id.q_id =	base_queue + act_qgrop->queue[0];
+		rule_info->sw_act.qgrp_size = act_qgrop->queue_num;
+		break;
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		act_q = action->conf;
+		rule_info->sw_act.fltr_act = ICE_FWD_TO_Q;
+		rule_info->sw_act.fwd_id.q_id = base_queue + act_q->index;
+		break;
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		rule_info->sw_act.fltr_act = ICE_DROP_PACKET;
+		break;
+	default:
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+			action, "Invalid action type or queue number");
+		return -rte_errno;
 	}
 
 	rule_info->sw_act.vsi_handle = vsi->idx;
@@ -1699,65 +1619,120 @@ ice_switch_parse_action(struct ice_pf *pf,
 	rule_info->priority = ICE_SW_PRI_BASE - priority;
 
 	return 0;
-
-error:
-	rte_flow_error_set(error,
-		EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-		actions,
-		"Invalid action type or queue number");
-	return -rte_errno;
-
-error1:
-	rte_flow_error_set(error,
-		EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-		actions,
-		"Invalid queue region indexes");
-	return -rte_errno;
-
-error2:
-	rte_flow_error_set(error,
-		EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-		actions,
-		"Discontinuous queue region");
-	return -rte_errno;
 }
 
 static int
-ice_switch_check_action(const struct rte_flow_action *actions,
-			    struct rte_flow_error *error)
+ice_switch_dcf_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
 {
+	struct ice_dcf_adapter *ad = param->driver_ctx;
 	const struct rte_flow_action *action;
 	enum rte_flow_action_type action_type;
-	uint16_t actions_num = 0;
-
-	for (action = actions; action->type !=
-				RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
-		case RTE_FLOW_ACTION_TYPE_RSS:
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-		case RTE_FLOW_ACTION_TYPE_DROP:
-		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			actions_num++;
-			break;
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			continue;
-		default:
-			rte_flow_error_set(error,
-					   EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					   actions,
-					   "Invalid action type");
-			return -rte_errno;
+	const struct rte_flow_action_ethdev *act_ethdev;
+	const struct rte_eth_dev *repr_dev;
+
+	action = actions->actions[0];
+	action_type = action->type;
+
+	switch (action_type) {
+	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+	{
+		uint16_t expected_port_id, backer_port_id;
+		act_ethdev = action->conf;
+
+		if (!rte_eth_dev_is_valid_port(act_ethdev->port_id))
+			goto invalid_port_id;
+
+		expected_port_id = ad->parent.pf.dev_data->port_id;
+
+		if (action_type == RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR) {
+			if (expected_port_id != act_ethdev->port_id)
+				goto invalid_port_id;
+		} else {
+			repr_dev = &rte_eth_devices[act_ethdev->port_id];
+
+			if (!repr_dev->data)
+				goto invalid_port_id;
+
+			backer_port_id = repr_dev->data->backer_port_id;
+
+			if (backer_port_id != expected_port_id)
+				goto invalid_port_id;
 		}
+
+		break;
+invalid_port_id:
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Invalid port ID");
+	}
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		break;
+	default:
+		/* Should never reach */
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Invalid action type");
 	}
 
-	if (actions_num != 1) {
-		rte_flow_error_set(error,
-				   EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   actions,
-				   "Invalid action number");
-		return -rte_errno;
+	return 0;
+}
+
+static int
+ice_switch_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct ice_adapter *ad = param->driver_ctx;
+	struct ice_pf *pf = &ad->pf;
+	struct rte_eth_dev_data *dev_data = pf->dev_data;
+	const struct rte_flow_action *action = actions->actions[0];
+
+	switch (action->type) {
+	case RTE_FLOW_ACTION_TYPE_RSS:
+	{
+		const struct rte_flow_action_rss *act_qgrop;
+		act_qgrop = action->conf;
+
+		/* Check bounds on number of queues */
+		if (act_qgrop->queue_num < 2 || act_qgrop->queue_num > ICE_SW_MAX_QUEUES)
+			goto err_rss;
+
+		/* must be power of 2 */
+		if (!rte_is_power_of_2(act_qgrop->queue_num))
+			goto err_rss;
+
+		/* queues are monotonous and contiguous so check last queue */
+		if ((act_qgrop->queue[0] + act_qgrop->queue_num) > dev_data->nb_rx_queues)
+			goto err_rss;
+
+		break;
+err_rss:
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Invalid queue region");
+	}
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	{
+		const struct rte_flow_action_queue *act_q;
+		act_q = action->conf;
+		if (act_q->index >= dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Invalid queue");
+		}
+
+		break;
+	}
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		break;
+	default:
+		/* Should never reach */
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
+				"Invalid action type");
 	}
 
 	return 0;
@@ -1788,11 +1763,38 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	struct ci_flow_attr_check_param attr_param = {
 		.allow_priority = true,
 	};
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param dcf_param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT,
+			RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.check = ice_switch_dcf_action_check,
+	};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.check = ice_switch_action_check,
+		.driver_ctx = ad,
+	};
 
 	ret = ci_flow_check_attr(attr, &attr_param, error);
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, (ad->hw.dcf_enabled) ? &dcf_param : &param,
+		&parsed_actions, error);
+	if (ret)
+		goto error;
+
 	/* Allow only two priority values - 0 or 1 */
 	if (attr->priority > 1) {
 		rte_flow_error_set(error, EINVAL,
@@ -1870,16 +1872,12 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	memset(&rule_info, 0, sizeof(rule_info));
 	rule_info.tun_type = tun_type;
 
-	ret = ice_switch_check_action(actions, error);
-	if (ret)
-		goto error;
-
 	if (ad->hw.dcf_enabled)
-		ret = ice_switch_parse_dcf_action((void *)ad, actions, attr->priority,
-						  error, &rule_info);
+		ret = ice_switch_parse_dcf_action(parsed_actions.actions[0],
+						  attr->priority, error, &rule_info);
 	else
-		ret = ice_switch_parse_action(pf, actions, attr->priority, error,
-					      &rule_info);
+		ret = ice_switch_parse_action(pf, parsed_actions.actions[0],
+				      attr->priority, error, &rule_info);
 
 	if (ret)
 		goto error;
-- 
2.47.3

