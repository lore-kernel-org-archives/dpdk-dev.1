Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBC0CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDCE34067D;
	Thu,  4 Jun 2026 18:19:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4F0E54065A
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589984; x=1812125984;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zhxZ5aSDveBQh9B09hj/hbvrtdTNadyj9UnVUOLqpiE=;
 b=NfpajDMUVza1Y9JYdnbOX8eFC8Ha2Gkv4VTjAH/5n8PJ9KZX79YukoiD
 HVK558vXVCPSKjSzlEVTd2+KvaSvggTKuQTWhs4kyQm0va2K380iH05dH
 GO/n6GD6Uv5YWyb910LsKQQdC1YUtiXxLz0O+jwbh8WCWLLd7uWDSudpK
 0YqAkGOGMgsvcRg1Wt2+IOQJFMOA7lkq7s3kIe9VKdLWdUmUI84sF5qLa
 xjcS5CTfW3ODwmCtul8FegEX60xWmKPYqHZ6/Iq5niI+l5w4PR8pqDoRa
 6MXug2VguXSBBJWNrg4WheTEKsiurT0N6rGzA1Enbp5HN5msr1Mcbr7kD w==;
X-CSE-ConnectionGUID: ALaFPFDNRz6KmJ1zIrdHnA==
X-CSE-MsgGUID: zaLK2FqyQQGVtv4Bnh2YSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045116"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045116"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:44 -0700
X-CSE-ConnectionGUID: DufGkj2vTYSysi6iywmhLg==
X-CSE-MsgGUID: wMefb8yERA+dYSt+Az0mVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240403966"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 05/27] net/ixgbe: use common checks in ethertype filter
Date: Thu,  4 Jun 2026 17:19:09 +0100
Message-ID: <503d4d5dd1e3ce6539121100d848a3203b18654c.1780589914.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in ethertype. This
allows us to remove some checks as they are no longer necessary (such as
whether DROP flag was set - if we do not accept DROP actions, we do not set
the DROP flag), as well as make some checks more stringent (such as
rejecting more than one action).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 190 ++++++++++-----------------
 1 file changed, 73 insertions(+), 117 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 9038aae001..5816b35f55 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -46,6 +46,8 @@
 #include "base/ixgbe_phy.h"
 #include "rte_pmd_ixgbe.h"
 
+#include "../common/flow_check.h"
+
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -124,6 +126,41 @@ const struct rte_flow_action *next_no_void_action(
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
+	struct rte_eth_dev_data *dev_data = param->driver_ctx;
+	size_t idx;
+
+	for (idx = 0; idx < actions->count; idx++) {
+		action = actions->actions[idx];
+
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		{
+			const struct rte_flow_action_queue *queue = action->conf;
+			if (queue->index >= dev_data->nb_rx_queues) {
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
@@ -725,38 +762,14 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
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
@@ -826,87 +839,30 @@ cons_parse_ethertype_filter(const struct rte_flow_attr *attr,
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
+		.driver_ctx = dev->data,
+		.check = ixgbe_flow_actions_check
+	};
+	const struct rte_flow_action *action;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 			hw->mac.type != ixgbe_mac_X540 &&
@@ -916,19 +872,27 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
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
@@ -947,14 +911,6 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
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

