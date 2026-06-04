Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7985DCD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:20:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 306C240A6E;
	Thu,  4 Jun 2026 18:19:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AEC9440670
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589990; x=1812125990;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UTGfjB+9J/6HSmDOX7FyTU7JvHQUGCQf4CKjBnndx4g=;
 b=l7cI4ttNg0QMW5vcBcIGh5Wa0W2wOSawvzMhZ5YWV5iWS1ppD33WbVAt
 5z98NvMVjyRkXnwihHT4eH9eGA/D8XmMaMzARPdBfTxM4XpfFHqMnBohH
 OpDYaJX2PyXQm0gyVPHja+BzwTXnmRH+ZQOaqTMqJMA/zi4CzjbzF66ds
 OyqKFgZzn9TdPzwKPn+uw+1+lRt76P/2j6moRCrERiyV3DS8R/6MhoGKQ
 JyQIMdq05oanUFQfmc5bKLePpJrZlv4J/7jTOeecS7zoCran2XWUlUHpm
 fgvoYp+QzqQv5SWNG6G6T+VDenRMGxUfzygdvYOAMcKxyy1bv9uEN5FNr w==;
X-CSE-ConnectionGUID: VvuUQoNuRGi2AFC7Po73FQ==
X-CSE-MsgGUID: u6tEDX89RYGL4Q+ojynddQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045129"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045129"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:49 -0700
X-CSE-ConnectionGUID: nE+HLwPyQmunxsDbxyVUPA==
X-CSE-MsgGUID: q4zldDlFRf27YWIzZ+YdnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240404015"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 10/27] net/ixgbe: use common checks in FDIR filters
Date: Thu,  4 Jun 2026 17:19:14 +0100
Message-ID: <3e8cf6311a991c99ab979d9d8e989fffc33c34c4.1780589914.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780589913.git.anatoly.burakov@intel.com>
 <cover.1780589913.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 319 ++++++++++++---------------
 1 file changed, 138 insertions(+), 181 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index cb7dde5a44..81dd1cb5fd 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1195,111 +1195,6 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
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
@@ -1406,9 +1301,8 @@ static inline uint8_t signature_match(const struct rte_flow_item pattern[])
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
@@ -1429,30 +1323,13 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	const struct rte_flow_item_vlan *vlan_mask;
 	const struct rte_flow_item_raw *raw_mask;
 	const struct rte_flow_item_raw *raw_spec;
+	const struct rte_flow_action *fwd_action, *aux_action;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint8_t j;
 
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-			NULL, "NULL pattern.");
-		return -rte_errno;
-	}
-
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
-	}
-
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
+	fwd_action = parsed_actions->actions[0];
+	/* can be NULL */
+	aux_action = parsed_actions->actions[1];
 
 	/**
 	 * Some fields may not be provided. Set spec to 0 and mask to default
@@ -1466,29 +1343,51 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	rule->mask.dst_port_mask = 0;
 	rule->mask.src_port_mask = 0;
 
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or TCP or UDP or SCTP.
-	 */
-	item = next_no_fuzzy_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
+	/* check if this is a signature match */
 	if (signature_match(pattern))
 		rule->mode = RTE_FDIR_MODE_SIGNATURE;
 	else
 		rule->mode = RTE_FDIR_MODE_PERFECT;
 
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
+	}
+
+	/* set up mark action */
+	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *m_act = aux_action->conf;
+		rule->soft_id = m_act->id;
+	}
+
+	/**
+	 * The first not void item should be
+	 * MAC or IPv4 or TCP or UDP or SCTP.
+	 */
+	item = next_no_fuzzy_pattern(pattern, NULL);
+	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
+	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
+	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
+	    item->type != RTE_FLOW_ITEM_TYPE_TCP &&
+	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
+	    item->type != RTE_FLOW_ITEM_TYPE_SCTP) {
+		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ITEM,
+			item, "Not supported by fdir filter");
+		return -rte_errno;
+	}
+
 	/*Not supported last point for range*/
 	if (item->last) {
 		rte_flow_error_set(error, EINVAL,
@@ -2083,7 +1982,7 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	rule->mask.l4_proto_match =
 		(rule->ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) != 0;
 
-	return ixgbe_parse_fdir_act_attr(attr, actions, rule, error);
+	return 0;
 }
 
 #define NVGRE_PROTOCOL 0x6558
@@ -2126,9 +2025,8 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
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
@@ -2141,28 +2039,12 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
-
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
-	}
-
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
+	fwd_action = parsed_actions->actions[0];
+	/* can be NULL */
+	aux_action = parsed_actions->actions[1];
 
 	/**
 	 * Some fields may not be provided. Set spec to 0 and mask to default
@@ -2172,6 +2054,20 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
 	rule->mask.vlan_tci_mask = 0;
 
+	/* set up queue/drop action */
+	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
+	}
+
+	/* set up mark action */
+	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *mark = aux_action->conf;
+		rule->soft_id = mark->id;
+	}
+
 	/**
 	 * The first not void item should be
 	 * MAC or IPv4 or IPv6 or UDP or VxLAN.
@@ -2572,7 +2468,43 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
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
+	const struct rte_flow_action *action;
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
+
+	/* second action, if specified, must not be a forwarding action */
+	action = parsed_actions->actions[1];
+	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	return 0;
 }
 
 static int
@@ -2585,22 +2517,47 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 {
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* queue/mark/drop allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = dev->data,
+		.check = ixgbe_fdir_actions_check
+	};
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
-		hw->mac.type != ixgbe_mac_X540 &&
-		hw->mac.type != ixgbe_mac_X550 &&
-		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a &&
-		hw->mac.type != ixgbe_mac_E610)
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
 		return -ENOTSUP;
 
-	ret = ixgbe_parse_fdir_filter_normal(dev, attr, pattern,
-					actions, rule, error);
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
+	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+
+	ret = ixgbe_parse_fdir_filter_normal(dev, pattern, &parsed_actions, rule, error);
 	if (!ret)
 		return 0;
 
-	return ixgbe_parse_fdir_filter_tunnel(attr, pattern,
-					actions, rule, error);
+	return ixgbe_parse_fdir_filter_tunnel(pattern, &parsed_actions,
+		rule, error);
 }
 
 static int
-- 
2.47.3

