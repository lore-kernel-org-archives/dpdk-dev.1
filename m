Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D3CE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A70540B91;
	Wed, 11 Feb 2026 15:21:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E3D47406BB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819667; x=1802355667;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bipU7Na5J/Nxzt+cchbGxshYve52OEogE/27HVuTjOE=;
 b=e8E1zYxqnVW2754G17JwnNzgroJvQl3vyF9YwwUqI0Igh/pm5uCCMaHi
 vD5RCsMNcayV7VBu57n6BqZ3SHkk/VjqXj74x3gtWV2JvLxIqRxVySUyK
 CJZUIxwoHrlZJWTcKaHWsGy2k5bYGlTCZ+zCJzfcSiYKd76cRBmo9QTP+
 JBtvxO7xjpAP0rfuMcB9qc4P407m+2qm+tVvEgBMu8DVjNSf/IIhxLfJe
 bY9m36wyAD1vQGNkKY3xjEAjgHOubBT3SPcee2zdvb355Tiz0B9U0MzIw
 sUeCogDMWbYuYJQFTMYGYvN4Tu1jehZ0VHl2JhhAcll2OXG/BOBnB2oLQ w==;
X-CSE-ConnectionGUID: xa7l6NmjQ7mwXDh0A/ETFQ==
X-CSE-MsgGUID: dCqw9qRASV2gVEd909xbYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866743"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866743"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:06 -0800
X-CSE-ConnectionGUID: K8BwpUrhQkOiQA6nJxMFqw==
X-CSE-MsgGUID: 6i7e5REXSgWSaEtThxXMoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569143"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 08/25] net/ixgbe: use common checks in FDIR filters
Date: Wed, 11 Feb 2026 14:20:25 +0000
Message-ID: <a60123ca2b7f859bb70690bd9f51f47357333db5.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in flow director
filters (both tunnel and normal). As a result, some checks have become
more stringent, in particular group attribute is now explicitly rejected
instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 290 ++++++++++++---------------
 1 file changed, 128 insertions(+), 162 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 38a8002611..c857eb0227 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1182,111 +1182,6 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	return ret;
 }
 
-/* Parse to get the attr and action info of flow director rule. */
-static int
-ixgbe_parse_fdir_act_attr(const struct rte_flow_attr *attr,
-			  const struct rte_flow_action actions[],
-			  struct ixgbe_fdir_rule *rule,
-			  struct rte_flow_error *error)
-{
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_mark *mark;
-
-	/* parse attr */
-	/* must be input direction */
-	if (!attr->ingress) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-			attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->egress) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-			attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->transfer) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-			attr, "No support for transfer.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->priority) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-			attr, "Not support priority.");
-		return -rte_errno;
-	}
-
-	/* check if the first not void action is QUEUE or DROP. */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_QUEUE &&
-	    act->type != RTE_FLOW_ACTION_TYPE_DROP) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	if (act->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		act_q = (const struct rte_flow_action_queue *)act->conf;
-		rule->queue = act_q->index;
-	} else { /* drop */
-		/* signature mode does not support drop action. */
-		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-			return -rte_errno;
-		}
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* check if the next not void item is MARK */
-	act = next_no_void_action(actions, act);
-	if ((act->type != RTE_FLOW_ACTION_TYPE_MARK) &&
-		(act->type != RTE_FLOW_ACTION_TYPE_END)) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	rule->soft_id = 0;
-
-	if (act->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		mark = (const struct rte_flow_action_mark *)act->conf;
-		rule->soft_id = mark->id;
-		act = next_no_void_action(actions, act);
-	}
-
-	/* check if the next not void item is END */
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 /* search next no void pattern and skip fuzzy */
 static inline
 const struct rte_flow_item *next_no_fuzzy_pattern(
@@ -1393,9 +1288,8 @@ static inline uint8_t signature_match(const struct rte_flow_item pattern[])
  */
 static int
 ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
-			       const struct rte_flow_attr *attr,
 			       const struct rte_flow_item pattern[],
-			       const struct rte_flow_action actions[],
+			       const struct ci_flow_actions *parsed_actions,
 			       struct ixgbe_fdir_rule *rule,
 			       struct rte_flow_error *error)
 {
@@ -1416,29 +1310,39 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	const struct rte_flow_item_vlan *vlan_mask;
 	const struct rte_flow_item_raw *raw_mask;
 	const struct rte_flow_item_raw *raw_spec;
+	const struct rte_flow_action *fwd_action, *aux_action;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint8_t j;
 
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	fwd_action = parsed_actions->actions[0];
+	/* can be NULL */
+	aux_action = parsed_actions->actions[1];
 
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-			NULL, "NULL pattern.");
-		return -rte_errno;
-	}
+	/* check if this is a signature match */
+	if (signature_match(pattern))
+		rule->mode = RTE_FDIR_MODE_SIGNATURE;
+	else
+		rule->mode = RTE_FDIR_MODE_PERFECT;
 
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
+	/* set up action */
+	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		/* signature mode does not support drop action. */
+		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, fwd_action,
+				"Signature mode does not support drop action.");
+			return -rte_errno;
+		}
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
 	}
 
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
+	/* set up mark action */
+	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *m_act = aux_action->conf;
+		rule->soft_id = m_act->id;
 	}
 
 	/**
@@ -1470,11 +1374,6 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	if (signature_match(pattern))
-		rule->mode = RTE_FDIR_MODE_SIGNATURE;
-	else
-		rule->mode = RTE_FDIR_MODE_PERFECT;
-
 	/*Not supported last point for range*/
 	if (item->last) {
 		rte_flow_error_set(error, EINVAL,
@@ -2063,7 +1962,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 		}
 	}
 
-	return ixgbe_parse_fdir_act_attr(attr, actions, rule, error);
+	return 0;
 }
 
 #define NVGRE_PROTOCOL 0x6558
@@ -2106,9 +2005,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
  * item->last should be NULL.
  */
 static int
-ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
-			       const struct rte_flow_item pattern[],
-			       const struct rte_flow_action actions[],
+ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_item pattern[],
+			       const struct ci_flow_actions *parsed_actions,
 			       struct ixgbe_fdir_rule *rule,
 			       struct rte_flow_error *error)
 {
@@ -2121,27 +2019,25 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	const struct rte_flow_item_eth *eth_mask;
 	const struct rte_flow_item_vlan *vlan_spec;
 	const struct rte_flow_item_vlan *vlan_mask;
+	const struct rte_flow_action *fwd_action, *aux_action;
 	uint32_t j;
 
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-				   NULL, "NULL pattern.");
-		return -rte_errno;
-	}
+	fwd_action = parsed_actions->actions[0];
+	/* can be NULL */
+	aux_action = parsed_actions->actions[1];
 
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
+	/* set up queue/drop action */
+	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
 	}
 
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
+	/* set up mark action */
+	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *mark = aux_action->conf;
+		rule->soft_id = mark->id;
 	}
 
 	/**
@@ -2552,7 +2448,56 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	 * Do nothing.
 	 */
 
-	return ixgbe_parse_fdir_act_attr(attr, actions, rule, error);
+	return 0;
+}
+
+/*
+ * Check flow director actions
+ */
+static int
+ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
+	const struct ci_flow_actions_check_param *param __rte_unused,
+	struct rte_flow_error *error)
+{
+	const enum rte_flow_action_type fwd_actions[] = {
+		RTE_FLOW_ACTION_TYPE_QUEUE,
+		RTE_FLOW_ACTION_TYPE_DROP,
+		RTE_FLOW_ACTION_TYPE_END
+	};
+	const struct rte_flow_action *action, *drop_action = NULL;
+
+	/* do the generic checks first */
+	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
+	if (ret)
+		return ret;
+
+	/* first action must be a forwarding action */
+	action = parsed_actions->actions[0];
+	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "First action must be QUEUE or DROP");
+	}
+	/* remember if we have a drop action */
+	if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		drop_action = action;
+	}
+
+	/* second action, if specified, must not be a forwarding action */
+	action = parsed_actions->actions[1];
+	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	/* if we didn't have a drop action before but now we do, remember that */
+	if (drop_action == NULL && action != NULL && action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+		drop_action = action;
+	}
+	/* drop must be the only action */
+	if (drop_action != NULL && action != NULL) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	return 0;
 }
 
 static int
@@ -2566,24 +2511,45 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* queue/mark/drop allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = dev,
+		.check = ixgbe_fdir_actions_check
+	};
+
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
 
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-		hw->mac.type != ixgbe_mac_X540 &&
-		hw->mac.type != ixgbe_mac_X550 &&
-		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a &&
-		hw->mac.type != ixgbe_mac_E610)
-		return -ENOTSUP;
-
-	ret = ixgbe_parse_fdir_filter_normal(dev, attr, pattern,
-					actions, rule, error);
+	ret = ixgbe_parse_fdir_filter_normal(dev, pattern, &parsed_actions, rule, error);
 
 	if (!ret)
 		goto step_next;
 
-	ret = ixgbe_parse_fdir_filter_tunnel(attr, pattern,
-					actions, rule, error);
+	ret = ixgbe_parse_fdir_filter_tunnel(pattern, &parsed_actions, rule, error);
 
 	if (ret)
 		return ret;
-- 
2.47.3

