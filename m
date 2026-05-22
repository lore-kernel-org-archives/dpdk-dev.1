Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6961CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FFE040DD5;
	Fri, 22 May 2026 17:15:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 20DAE40A4B
 for <dev@dpdk.org>; Fri, 22 May 2026 17:15:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462907; x=1810998907;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ld9Wz+BsIjpprs3IlPa3sOoaH/TJzNyasT6r3xCqrwQ=;
 b=TnclbAlAkYCzoAIhycZO6d24wHm5SzRxLXg2AfWjbM5Abl+Gg6wLrvPl
 YTzmGtPjp+iTkNdW1NejUzPi5ilHyHV2qklgpLSZRdPKe0ErSqRwXTcdZ
 qZLWrW/zj5Y5JTWz7E3AmaEBvzwxEOYDQs9Ihz9ESY5hvWq8aT2elF81X
 ZsT8oXvYrYNWH8vHLF5VXJc/lLhBZp2jTU71iTyIxxBsr710RDZWoLnJ3
 AkIIQNnz2UBEA96PZdBjiAWapxIhWVtZgYvmhW72ShV6iicapyS1gP3Rs
 B/bu+zfpRlpnP7OGHnZajwIcKybT5uEzAuyQIfFV6WNI1JgF3aEoLJmv2 Q==;
X-CSE-ConnectionGUID: Nyups258TtWev+du1WHW+Q==
X-CSE-MsgGUID: hVAaQVc/S7a9+7OC7KDlKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969177"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969177"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:15:07 -0700
X-CSE-ConnectionGUID: CQph081zS92dzSvt5OGyrQ==
X-CSE-MsgGUID: EDegRh+0TEmmx/nHh/wg1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245214045"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:15:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 20/26] net/iavf: use common action checks for fsub
Date: Fri, 22 May 2026 16:14:29 +0100
Message-ID: <8503b4ec27fe2c1769c55de6efaddc6f0452c6c7.1779462699.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779462698.git.anatoly.burakov@intel.com>
 <cover.1779462698.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for flow subscription filter.

Existing implementation had a couple issues that do not rise to the level
of being bugs, but are still questionable design choices.

For one, DROP action is supported in actions check (single actions are
allowed as long as it isn't RSS or QUEUE) but is later disallowed in action
parse (because not having port representor action is treated as an error).
This is fixed by removing DROP action support from the check stage.

For another, PORT_REPRESENTOR action was incrementing action counter but
not writing anything into action array, which, given that action list is
zero-initialized, meant that the default action (drop) was kept in the
action list. However, because the actual PF treats drop as a no-op, nothing
bad happened when a DROP action was added to the list of actions.

However, nothing bad also happens if we just didn't have an action to
begin with, so we remedy these unorthodox semantics by accordingly
treating PORT_REPRESENTOR action as a noop, and not adding anything to
the action list.

As a final note, now that all filter parsing code paths use the common
action check infrastructure, we can remove the NULL check for actions
from the beginning of the parsing path, as this is now handled by each
engine.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fsub.c         | 243 +++++++++------------
 drivers/net/intel/iavf/iavf_generic_flow.c |   7 -
 2 files changed, 100 insertions(+), 150 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 65172467b5..ef46954bff 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -465,89 +465,46 @@ iavf_fsub_parse_pattern(const struct rte_flow_item pattern[],
 }
 
 static int
-iavf_fsub_parse_action(struct iavf_adapter *ad,
-		       const struct rte_flow_action *actions,
+iavf_fsub_parse_action(const struct ci_flow_actions *actions,
 		       uint32_t priority,
 		       struct rte_flow_error *error,
 		       struct iavf_fsub_conf *filter)
 {
-	const struct rte_flow_action *action;
-	const struct rte_flow_action_ethdev *act_ethdev;
-	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_rss *act_qgrop;
-	struct virtchnl_filter_action *filter_action;
-	uint16_t valid_qgrop_number[MAX_QGRP_NUM_TYPE] = {
-		2, 4, 8, 16, 32, 64, 128};
-	uint16_t i, num = 0, dest_num = 0, vf_num = 0;
-	uint16_t rule_port_id;
+	uint16_t num_actions = 0;
+	size_t i;
+
+	for (i = 0; i < actions->count; i++) {
+		const struct rte_flow_action *action = actions->actions[i];
+		struct virtchnl_filter_action *filter_action =
+				&filter->sub_fltr.actions.actions[num_actions];
 
-	for (action = actions; action->type !=
-				RTE_FLOW_ACTION_TYPE_END; action++) {
 		switch (action->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			vf_num++;
-			filter_action = &filter->sub_fltr.actions.actions[num];
-
-			act_ethdev = action->conf;
-			rule_port_id = ad->dev_data->port_id;
-			if (rule_port_id != act_ethdev->port_id)
-				goto error1;
-
-			filter->sub_fltr.actions.count = ++num;
-			break;
+			/* nothing to be done, but skip the action */
+			continue;
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			dest_num++;
-			filter_action = &filter->sub_fltr.actions.actions[num];
-
-			act_q = action->conf;
-			if (act_q->index >= ad->dev_data->nb_rx_queues)
-				goto error2;
-
+		{
+			const struct rte_flow_action_queue *act_q = action->conf;
 			filter_action->type = VIRTCHNL_ACTION_QUEUE;
 			filter_action->act_conf.queue.index = act_q->index;
-			filter->sub_fltr.actions.count = ++num;
 			break;
+		}
 		case RTE_FLOW_ACTION_TYPE_RSS:
-			dest_num++;
-			filter_action = &filter->sub_fltr.actions.actions[num];
-
-			act_qgrop = action->conf;
-			if (act_qgrop->queue_num <= 1)
-				goto error2;
+		{
+			const struct rte_flow_action_rss *act_qgrp = action->conf;
 
 			filter_action->type = VIRTCHNL_ACTION_Q_REGION;
-			filter_action->act_conf.queue.index =
-							act_qgrop->queue[0];
-			for (i = 0; i < MAX_QGRP_NUM_TYPE; i++) {
-				if (act_qgrop->queue_num ==
-				    valid_qgrop_number[i])
-					break;
-			}
-
-			if (i == MAX_QGRP_NUM_TYPE)
-				goto error2;
-
-			if ((act_qgrop->queue[0] + act_qgrop->queue_num) >
-			    ad->dev_data->nb_rx_queues)
-				goto error3;
-
-			for (i = 0; i < act_qgrop->queue_num - 1; i++)
-				if (act_qgrop->queue[i + 1] !=
-				    act_qgrop->queue[i] + 1)
-					goto error4;
-
-			filter_action->act_conf.queue.region = act_qgrop->queue_num;
-			filter->sub_fltr.actions.count = ++num;
+			filter_action->act_conf.queue.index = act_qgrp->queue[0];
+			filter_action->act_conf.queue.region = act_qgrp->queue_num;
 			break;
+		}
 		default:
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION,
-					   actions, "Invalid action type");
-			return -rte_errno;
+			/* cannot happen */
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Invalid action type.");
 		}
+		filter->sub_fltr.actions.count = ++num_actions;
 	}
 
 	/* 0 denotes lowest priority of recipe and highest priority
@@ -555,91 +512,81 @@ iavf_fsub_parse_action(struct iavf_adapter *ad,
 	 */
 	filter->sub_fltr.priority = priority;
 
-	if (num > VIRTCHNL_MAX_NUM_ACTIONS) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-				   "Action numbers exceed the maximum value");
-		return -rte_errno;
-	}
-
-	if (vf_num == 0) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-				   "Invalid action, vf action must be added");
-		return -rte_errno;
-	}
-
-	if (dest_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-				   "Unsupported action combination");
-		return -rte_errno;
-	}
-
 	return 0;
-
-error1:
-	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Invalid port id");
-	return -rte_errno;
-
-error2:
-	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Invalid action type or queue number");
-	return -rte_errno;
-
-error3:
-	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Invalid queue region indexes");
-	return -rte_errno;
-
-error4:
-	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Discontinuous queue region");
-	return -rte_errno;
 }
 
 static int
-iavf_fsub_check_action(const struct rte_flow_action *actions,
+iavf_fsub_action_check(const struct ci_flow_actions *actions,
+		       const struct ci_flow_actions_check_param *param,
 		       struct rte_flow_error *error)
 {
-	const struct rte_flow_action *action;
-	enum rte_flow_action_type action_type;
-	uint16_t actions_num = 0;
-	bool vf_valid = false;
-	bool queue_valid = false;
+	const struct iavf_adapter *ad = param->driver_ctx;
+	bool vf = false;
+	size_t i;
 
-	for (action = actions; action->type !=
-				RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
+	/*
+	 * allowed action types:
+	 * 1. PORT_REPRESENTOR only
+	 * 2. PORT_REPRESENTOR + QUEUE/RSS
+	 */
+
+	for (i = 0; i < actions->count; i++) {
+		const struct rte_flow_action *action = actions->actions[i];
+		switch (action->type) {
 		case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
-			vf_valid = true;
-			actions_num++;
+		{
+			const struct rte_flow_action_ethdev *act_ethdev = action->conf;
+
+			if (act_ethdev->port_id != ad->dev_data->port_id) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_ethdev,
+						"Invalid port id");
+			}
+			vf = true;
 			break;
+		}
 		case RTE_FLOW_ACTION_TYPE_RSS:
+		{
+			const struct rte_flow_action_rss *act_qgrp = action->conf;
+
+			/* must be between 2 and 128 and be a power of 2 */
+			if (act_qgrp->queue_num < 2 || act_qgrp->queue_num > 128 ||
+					!rte_is_power_of_2(act_qgrp->queue_num)) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_qgrp,
+						"Invalid number of queues in RSS queue group");
+			}
+			/* last queue must not exceed total number of queues */
+			if (act_qgrp->queue[0] + act_qgrp->queue_num > ad->dev_data->nb_rx_queues) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_qgrp,
+						"Invalid queue index in RSS queue group");
+			}
+			break;
+		}
 		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			queue_valid = true;
-			actions_num++;
+		{
+			const struct rte_flow_action_queue *act_q = action->conf;
+
+			if (act_q->index >= ad->dev_data->nb_rx_queues) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+						"Invalid queue index");
+			}
 			break;
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			actions_num++;
-			break;
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			continue;
+		}
 		default:
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION,
-					   actions, "Invalid action type");
-			return -rte_errno;
+			/* shouldn't happen */
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Invalid action type");
 		}
 	}
-
-	if (!((actions_num == 1 && !queue_valid) ||
-	      (actions_num == 2 && vf_valid && queue_valid))) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   actions, "Invalid action number");
-		return -rte_errno;
+	/* QUEUE/RSS must be accompanied by PORT_REPRESENTOR */
+	if (!vf) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, actions,
+				"Invalid action combination");
 	}
 
 	return 0;
@@ -655,6 +602,18 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 		void **meta,
 		struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR,
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+		.check = iavf_fsub_action_check,
+		.driver_ctx = ad,
+	};
 	struct iavf_fsub_conf *filter;
 	struct iavf_pattern_match_item *pattern_match_item = NULL;
 	struct ci_flow_attr_check_param attr_param = {
@@ -674,6 +633,10 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 	if (ret)
 		goto error;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		goto error;
+
 	if (attr->priority > 1) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
@@ -697,14 +660,8 @@ iavf_fsub_parse(struct iavf_adapter *ad,
 	if (ret)
 		goto error;
 
-	/* check flow subscribe pattern action */
-	ret = iavf_fsub_check_action(actions, error);
-	if (ret)
-		goto error;
-
 	/* parse flow subscribe pattern action */
-	ret = iavf_fsub_parse_action((void *)ad, actions, attr->priority,
-				     error, filter);
+	ret = iavf_fsub_parse_action(&parsed_actions, attr->priority, error, filter);
 
 error:
 	if (!ret && meta)
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 371ad1b356..7ebfa70490 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2159,13 +2159,6 @@ iavf_flow_process_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
-	}
-
 	*engine = iavf_parse_engine(ad, flow, &vf->rss_parser_list,
 				    attr, pattern, actions, error);
 	if (*engine)
-- 
2.47.3

