Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E6DF46449
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B10A40654;
	Mon, 16 Mar 2026 11:53:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6D5AF40613
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658382; x=1805194382;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oYXnPa9en74SxTbshcSeISoeiZ1i7yE8a+eO1GaJvac=;
 b=Fc2vdOMLfN3FyhQvbcpi/RbNLSEtj13y3Fo3+D8ucADbYeEQS6N6HQBM
 QXvqXvoXWcdV5px+Thyvo8nFZ1kl5XBg5bLmlqR+UrHhrl6MDwZLFDc7b
 wyOqEXCwztf7XJoDxN417Uan/lYJBzfTqFHjWwDfzOI8C1zTm036ynlGD
 gpW1yREZ5Rqa3N2hIqS7N90ECV8dOZMUk634QwXLLqxkh5ijNY9bIQGJP
 kBDNOQJNkWvh83jPx81vmL0QoaKGxAini6uegrgAG2anig04/SxPoRTYG
 yaJ+zCtNm1MVVlfiFjnvK2KSKVrecKCsVzGOlbGqtKro5ZN0Ta3fpXkXX Q==;
X-CSE-ConnectionGUID: d2iuu3MmQLOPvM2n9BpVWw==
X-CSE-MsgGUID: O7vNXWVWT7+mLs+P/5KSyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237412"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237412"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:01 -0700
X-CSE-ConnectionGUID: zlrIeLBnQ7yjkiL87hEg2w==
X-CSE-MsgGUID: G2TxSKxpR3aqqM1HKhT1bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826585"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 03/25] net/ixgbe: use common checks in ethertype filter
Date: Mon, 16 Mar 2026 10:52:28 +0000
Message-ID: <49a0262aea9fb328360ac93bfc832d8e59f20525.1773658289.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773658289.git.anatoly.burakov@intel.com>
 <cover.1773658289.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in ethertype. This
allows us to remove some checks as they are no longer necessary (such as
whether DROP flag was set - if we do not accept DROP actions, we do not set
the DROP flag), as well as make some checks more stringent (such as
rejecting more than one action).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 190 ++++++++++-----------------
 1 file changed, 73 insertions(+), 117 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..e41e070ee7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -43,6 +43,8 @@
 #include "base/ixgbe_phy.h"
 #include "rte_pmd_ixgbe.h"
 
+#include "../common/flow_check.h"
+
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -133,6 +135,41 @@ const struct rte_flow_action *next_no_void_action(
 	}
 }
 
+/*
+ * All ixgbe engines mostly check the same stuff, so use a common check.
+ */
+static int
+ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action *action;
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param->driver_ctx;
+	size_t idx;
+
+	for (idx = 0; idx < actions->count; idx++) {
+		action = actions->actions[idx];
+
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		{
+			const struct rte_flow_action_queue *queue = action->conf;
+			if (queue->index >= dev->data->nb_rx_queues) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION,
+						action,
+						"queue index out of range");
+			}
+			break;
+		}
+		default:
+			/* no specific validation */
+			break;
+		}
+	}
+	return 0;
+}
+
 /**
  * Please be aware there's an assumption for all the parsers.
  * rte_flow_item is using big endian, rte_flow_attr and
@@ -743,38 +780,14 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
  * item->last should be NULL.
  */
 static int
-cons_parse_ethertype_filter(const struct rte_flow_attr *attr,
-			    const struct rte_flow_item *pattern,
-			    const struct rte_flow_action *actions,
-			    struct rte_eth_ethertype_filter *filter,
-			    struct rte_flow_error *error)
+cons_parse_ethertype_filter(const struct rte_flow_item *pattern,
+		const struct rte_flow_action *action,
+		struct rte_eth_ethertype_filter *filter,
+		struct rte_flow_error *error)
 {
 	const struct rte_flow_item *item;
-	const struct rte_flow_action *act;
 	const struct rte_flow_item_eth *eth_spec;
 	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_action_queue *act_q;
-
-	if (!pattern) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-				NULL, "NULL pattern.");
-		return -rte_errno;
-	}
-
-	if (!actions) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				NULL, "NULL action.");
-		return -rte_errno;
-	}
-
-	if (!attr) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
 
 	item = next_no_void_pattern(pattern, NULL);
 	/* The first non-void item should be MAC. */
@@ -844,87 +857,30 @@ cons_parse_ethertype_filter(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	/* Parse action */
-
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_QUEUE &&
-	    act->type != RTE_FLOW_ACTION_TYPE_DROP) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	if (act->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		act_q = (const struct rte_flow_action_queue *)act->conf;
-		filter->queue = act_q->index;
-	} else {
-		filter->flags |= RTE_ETHTYPE_FLAGS_DROP;
-	}
-
-	/* Check if the next non-void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	/* Parse attr */
-	/* Must be input direction */
-	if (!attr->ingress) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-				attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->egress) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-				attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->transfer) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-				attr, "No support for transfer.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->priority) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				attr, "Not support priority.");
-		return -rte_errno;
-	}
-
-	/* Not supported */
-	if (attr->group) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
-				attr, "Not support group.");
-		return -rte_errno;
-	}
+	filter->queue = ((const struct rte_flow_action_queue *)action->conf)->index;
 
 	return 0;
 }
 
 static int
-ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_eth_ethertype_filter *filter,
-			     struct rte_flow_error *error)
+ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		struct rte_eth_ethertype_filter *filter, struct rte_flow_error *error)
 {
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only queue is allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = dev,
+		.check = ixgbe_flow_actions_check
+	};
+	const struct rte_flow_action *action;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 			hw->mac.type != ixgbe_mac_X540 &&
@@ -934,19 +890,27 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
 			hw->mac.type != ixgbe_mac_E610)
 		return -ENOTSUP;
 
-	ret = cons_parse_ethertype_filter(attr, pattern,
-					actions, filter, error);
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
 	if (ret)
 		return ret;
 
-	if (filter->queue >= dev->data->nb_rx_queues) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "queue index much too big");
-		return -rte_errno;
+	/* only one action is supported */
+	if (parsed_actions.count > 1) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  parsed_actions.actions[1],
+					  "Only one action can be specified at a time");
 	}
+	action = parsed_actions.actions[0];
+
+	ret = cons_parse_ethertype_filter(pattern, action, filter, error);
+	if (ret)
+		return ret;
 
 	if (filter->ether_type == RTE_ETHER_TYPE_IPV4 ||
 		filter->ether_type == RTE_ETHER_TYPE_IPV6) {
@@ -965,14 +929,6 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	if (filter->flags & RTE_ETHTYPE_FLAGS_DROP) {
-		memset(filter, 0, sizeof(struct rte_eth_ethertype_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			NULL, "drop option is unsupported");
-		return -rte_errno;
-	}
-
 	return 0;
 }
 
-- 
2.47.3

