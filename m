Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5DCE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C61406B7;
	Wed, 11 Feb 2026 15:21:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4551640668
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819662; x=1802355662;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ys95lOSCadZO9lHq/MyL1HUTS9JLSK1Wj7JIMjPOvfk=;
 b=kBgz1zmk+kZAN1EX+NSCqIRRGZiZw53osddpmAgoEZ47HDpbJzmjNVA6
 2hXKcMqzofUvmGHkGRWqt937+kcKDkJx4R1NRKVvWh9bt6Pztti+bfzeN
 wthogky7ItnMWcE2Da/arNzTTvxrZ/hNeD6RDvortDXG9+9a7GyzMd94m
 cCccaiQyFeUx9RRxUzJLkJZl12cLGjbmOeTLRecpZydkDEvHpXkA9T7le
 KIFuSpt1OmWDwLFp9ndz0neNU/+gNqR7D96ZnpoP3u41heaEW8Z0hyp1X
 R5m6/2j5czp1aBLgMaSwI9oaMFPcsk8oZuEumkOSCdDDxD1c4fz5xX0sd Q==;
X-CSE-ConnectionGUID: tO/NR0/NSb2VpBSPRHeI2A==
X-CSE-MsgGUID: yn33Hl7dQeezfOkEEi0usA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866729"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866729"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:01 -0800
X-CSE-ConnectionGUID: jkkHbNCaThukq4sEKtn7kA==
X-CSE-MsgGUID: ppHWJPexRe6CzuU8/Zxp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569113"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 04/25] net/ixgbe: use common checks in syn filter
Date: Wed, 11 Feb 2026 14:20:21 +0000
Message-ID: <cd1c7820c110917767475514cd8bc2844cca2197.1770819434.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in syn filter. Some
checks have been rearranged or become more stringent due to using common
infrastructure. In particular, group attr was ignored previously but is
now explicitly rejected.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 130 +++++++--------------------
 1 file changed, 32 insertions(+), 98 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 7695d57e2a..0aa96f04bb 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -922,38 +922,13 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
  * item->last should be NULL.
  */
 static int
-cons_parse_syn_filter(const struct rte_flow_attr *attr,
-				const struct rte_flow_item pattern[],
-				const struct rte_flow_action actions[],
-				struct rte_eth_syn_filter *filter,
-				struct rte_flow_error *error)
+cons_parse_syn_filter(const struct rte_flow_attr *attr, const struct rte_flow_item pattern[],
+		const struct rte_flow_action_queue *q_act, struct rte_eth_syn_filter *filter,
+		struct rte_flow_error *error)
 {
 	const struct rte_flow_item *item;
-	const struct rte_flow_action *act;
 	const struct rte_flow_item_tcp *tcp_spec;
 	const struct rte_flow_item_tcp *tcp_mask;
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
 
 
 	/* the first not void item should be MAC or IPv4 or IPv6 or TCP */
@@ -1061,63 +1036,7 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
 		return -rte_errno;
 	}
 
-	/* check if the first not void action is QUEUE. */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_QUEUE) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	act_q = (const struct rte_flow_action_queue *)act->conf;
-	filter->queue = act_q->index;
-	if (filter->queue >= IXGBE_MAX_RX_QUEUE_NUM) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	/* check if the next not void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	/* parse attr */
-	/* must be input direction */
-	if (!attr->ingress) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-			attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->egress) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-			attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->transfer) {
-		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-			attr, "No support for transfer.");
-		return -rte_errno;
-	}
+	filter->queue = q_act->index;
 
 	/* Support 2 priorities, the lowest or highest. */
 	if (!attr->priority) {
@@ -1128,7 +1047,7 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
 		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-			attr, "Not support priority.");
+			attr, "Priority can be 0 or 0xFFFFFFFF");
 		return -rte_errno;
 	}
 
@@ -1136,15 +1055,27 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
 }
 
 static int
-ixgbe_parse_syn_filter(struct rte_eth_dev *dev,
-				 const struct rte_flow_attr *attr,
-			     const struct rte_flow_item pattern[],
-			     const struct rte_flow_action actions[],
-			     struct rte_eth_syn_filter *filter,
-			     struct rte_flow_error *error)
+ixgbe_parse_syn_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		struct rte_eth_syn_filter *filter, struct rte_flow_error *error)
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
+		.driver_ctx = dev,
+		.check = ixgbe_flow_actions_check,
+		.max_actions = 1,
+	};
+	struct ci_flow_attr_check_param attr_param = {
+		.allow_priority = true,
+	};
+	const struct rte_flow_action *action;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 			hw->mac.type != ixgbe_mac_X540 &&
@@ -1154,16 +1085,19 @@ ixgbe_parse_syn_filter(struct rte_eth_dev *dev,
 			hw->mac.type != ixgbe_mac_E610)
 		return -ENOTSUP;
 
-	ret = cons_parse_syn_filter(attr, pattern,
-					actions, filter, error);
-
-	if (filter->queue >= dev->data->nb_rx_queues)
-		return -rte_errno;
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
 
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
 	if (ret)
 		return ret;
 
-	return 0;
+	action = parsed_actions.actions[0];
+
+	return cons_parse_syn_filter(attr, pattern, action->conf, filter, error);
 }
 
 /**
-- 
2.47.3

