Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E40CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E07A6406B7;
	Fri, 29 May 2026 17:36:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 15DE440678
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069006; x=1811605006;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=guLpDCsJx/r7H7+6JuuhXNOMTxP1g27la4nbT2H3WhM=;
 b=HKNNkRrDtX3qMKV6hslBPISR1N+KQjjhK0c8nw75ZTsIFNW0mSdtT+he
 cnNozArHAGm9+VTezZ5g7HuAd6IrQG3ZswktI1JpKDkh+ibuXY9Fu88aL
 M4HKP9hzKLe8ynsVdyPyEuaK700exop6F/3DpdsaUndzKFyovM9QxfvuU
 HHdcu1Dv/z28/m8893Kq7P1kRzF27Jn1qzpk1Tu45k+fHhxn3WuZxVPWe
 2vXGpJr+1M4tVG9uNXT0lmvKdwr6Nh2VgsVjMLpOKaJAPqfElEXeZHuAm
 tdNDhnJAgLADng2CsngwHZNrPsPcAqBxjznjINIYI1ym8kv83WodPrUjd g==;
X-CSE-ConnectionGUID: t52gQL/3TyS0GB7tb3NbWQ==
X-CSE-MsgGUID: 7v+G3APkTjuskzRHXwHHJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549783"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:46 -0700
X-CSE-ConnectionGUID: nDj+OUPkTLqAgq+KXMwVDg==
X-CSE-MsgGUID: wCZ3T8xMTeOgdkLaFhIT9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001228"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 08/27] net/ixgbe: use common checks in ntuple filter
Date: Fri, 29 May 2026 16:36:10 +0100
Message-ID: <cd60fc6a1b0e42a2b9e49af07068ccb131112ad4.1780068633.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in ntuple filter.
As a result, some checks have become more stringent, in particular the
group attribute is now explicitly rejected instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 133 ++++++++-------------------
 1 file changed, 36 insertions(+), 97 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 1d93717ce8..9b879f718b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -210,12 +210,11 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
 static int
 cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 			 const struct rte_flow_item pattern[],
-			 const struct rte_flow_action actions[],
+			 const struct rte_flow_action_queue *q_act,
 			 struct rte_eth_ntuple_filter *filter,
 			 struct rte_flow_error *error)
 {
 	const struct rte_flow_item *item;
-	const struct rte_flow_action *act;
 	const struct rte_flow_item_ipv4 *ipv4_spec;
 	const struct rte_flow_item_ipv4 *ipv4_mask;
 	const struct rte_flow_item_tcp *tcp_spec;
@@ -231,24 +230,11 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	struct rte_flow_item_eth eth_null;
 	struct rte_flow_item_vlan vlan_null;
 
-	if (!pattern) {
-		rte_flow_error_set(error,
-			EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
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
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
+	/* Priority must be 16-bit */
+	if (attr->priority > UINT16_MAX) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
+				"Priority must be 16-bit");
 	}
 
 	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
@@ -535,70 +521,11 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 action:
 
-	/**
-	 * n-tuple only supports forwarding,
-	 * check if the first not void action is QUEUE.
-	 */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_QUEUE) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			item, "Not supported action.");
-		return -rte_errno;
-	}
-	filter->queue =
-		((const struct rte_flow_action_queue *)act->conf)->index;
+	filter->queue = q_act->index;
 
-	/* check if the next not void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	/* parse attr */
-	/* must be input direction */
-	if (!attr->ingress) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-				   attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->egress) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-				   attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->transfer) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-				   attr, "No support for transfer.");
-		return -rte_errno;
-	}
-
-	if (attr->priority > 0xFFFF) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				   attr, "Error priority.");
-		return -rte_errno;
-	}
 	filter->priority = (uint16_t)attr->priority;
-	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO ||
-	    attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
-	    filter->priority = 1;
+	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO || attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
+		filter->priority = 1;
 
 	return 0;
 }
@@ -718,15 +645,40 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 			  struct rte_eth_ntuple_filter *filter,
 			  struct rte_flow_error *error)
 {
-	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = dev->data,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
+	int ret;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 			hw->mac.type != ixgbe_mac_X540)
 		return -ENOTSUP;
 
-	ret = cons_parse_ntuple_filter(attr, pattern, actions, filter, error);
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
 
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+	action = parsed_actions.actions[0];
+
+	ret = cons_parse_ntuple_filter(attr, pattern, action->conf, filter, error);
 	if (ret)
 		return ret;
 
@@ -739,19 +691,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	/* Ixgbe doesn't support many priorities. */
-	if (filter->priority < IXGBE_MIN_N_TUPLE_PRIO ||
-	    filter->priority > IXGBE_MAX_N_TUPLE_PRIO) {
-		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "Priority not supported by ntuple filter");
-		return -rte_errno;
-	}
-
-	if (filter->queue >= dev->data->nb_rx_queues)
-		return -rte_errno;
-
 	/* fixed value for ixgbe */
 	filter->flags = RTE_5TUPLE_FLAGS;
 	return 0;
-- 
2.47.3

