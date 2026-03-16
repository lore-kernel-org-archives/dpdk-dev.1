Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73090F4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E5240656;
	Mon, 16 Mar 2026 11:53:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 31B3B4064A
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658382; x=1805194382;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v7H8nyiF7W5xFhl+JQXowwV9TpcsmycW8g+4gH98CMw=;
 b=D/Cm7+YC/8ighZJgb7Rs3PKn/LnOV8xe6SIHgUjIJgsZT9exLO9wuv0f
 5Oo9j6fVdwXR3dObnP7yUKXkD3/4wnFW8yAwLhAyJXo5cBlfZXgr+LaIa
 SihpgCLWkEuTv8Kl9BKqSFvTNir32RIENEIRf7MEioyfpX11twzlS3zp6
 yle9zjHV/YDQ9Dy4Hw/jW9suVJdGBlS+TAh38VJsOPeEIDK1VqlsJaXI5
 30HDptRBSX3oPduawD/WZoRIEn6m7Hz/c5I2j+A4gtpvqfNMQcCnGTPWn
 O5uHIU2DIz77fv4gz8vBjOgCmr9eidbFrhJTObZXQz3TqezsERFA5mfTa Q==;
X-CSE-ConnectionGUID: ETN2lSOGTbq5eDGFzF+DOw==
X-CSE-MsgGUID: ZVuS8YohTlqGHjhAXjxzcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237413"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237413"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:02 -0700
X-CSE-ConnectionGUID: EYj0+c72RWO00Puz9Jwwdg==
X-CSE-MsgGUID: XtaQERnfTs+l92AW8n7t4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826655"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 04/25] net/ixgbe: use common checks in syn filter
Date: Mon, 16 Mar 2026 10:52:29 +0000
Message-ID: <dcb12af7464d3c1e9a1236310bc355d49a0cd57e.1773658289.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in syn filter. Some
checks have been rearranged or become more stringent due to using common
infrastructure. In particular, group attr was ignored previously but is
now explicitly rejected.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 130 +++++++--------------------
 1 file changed, 32 insertions(+), 98 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index e41e070ee7..220b89f8fc 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -953,38 +953,13 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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
@@ -1092,63 +1067,7 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
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
@@ -1159,7 +1078,7 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
 		memset(filter, 0, sizeof(struct rte_eth_syn_filter));
 		rte_flow_error_set(error, EINVAL,
 			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-			attr, "Not support priority.");
+			attr, "Priority can be 0 or 0xFFFFFFFF");
 		return -rte_errno;
 	}
 
@@ -1167,15 +1086,27 @@ cons_parse_syn_filter(const struct rte_flow_attr *attr,
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
@@ -1185,16 +1116,19 @@ ixgbe_parse_syn_filter(struct rte_eth_dev *dev,
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

