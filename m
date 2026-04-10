Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF34F4485A
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCA0D40A6B;
	Fri, 10 Apr 2026 15:13:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id F41B940685
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826826; x=1807362826;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=p8p/GoGlVFD0zge+fHNX4LwqSu7uVWL8B4ZGrQBO6mA=;
 b=QgdItYAbD1Ms7+0JXweqlda7pEpS9u6Ce+nHGyKLuZZZto0hkj6CfrKn
 QE87VwF2zFBP4pSOdhN8cWkVnWHUva/dFpDev18ZdJfMHZ7pXWZ28YS9Q
 +axrLsHCApeVOOazZ8QFrkrNelLebCObd/Qno2XVQV1dYv7eZIhh57zKf
 H4eGFAnytbBM0OnaTYbcQ6vk9a1lVrJ5eyYnUFJqTpBRnw9AF2omyoK27
 MojWDvfz1qq5n9hrU2Lsi1m2UpRgdE0Ez5esNty9ZeS7kqVHLD7557eym
 NpCWR7hrE4JGAo7OCpsZhSC7o0TxauMFyco0BpvgoOoUwG+zqX6HMjTRt w==;
X-CSE-ConnectionGUID: n2tbOw/hQj2szZzL6ulipw==
X-CSE-MsgGUID: GfOkQrXjRhem03JBT7TR8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736333"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736333"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:46 -0700
X-CSE-ConnectionGUID: BI2ib5qaQsq48V4yLggJyA==
X-CSE-MsgGUID: ZiEJbK8tRaGCQHj7jZy0rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084669"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 13/29] net/ixgbe: use common checks in RSS filter
Date: Fri, 10 Apr 2026 14:13:07 +0100
Message-ID: <43dc86bcd84750c726bcccd21a6cddd3193e8262.1775826526.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in RSS filter. As a
result, some checks have become more stringent, in particular:

- the group attribute is now explicitly rejected instead of being ignored
- RSS now explicitly rejects unsupported RSS types at validation
- the priority attribute was previously allowed but rejected values bigger
  than 0xFFFF despite not using priority anywhere - it is now rejected

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 202 +++++++++++----------------
 1 file changed, 85 insertions(+), 117 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 4d7f9312a1..8f5b30d329 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -121,20 +121,6 @@ const struct rte_flow_item *next_no_void_pattern(
 	}
 }
 
-static inline
-const struct rte_flow_action *next_no_void_action(
-		const struct rte_flow_action actions[],
-		const struct rte_flow_action *cur)
-{
-	const struct rte_flow_action *next =
-		cur ? cur + 1 : &actions[0];
-	while (1) {
-		if (next->type != RTE_FLOW_ACTION_TYPE_VOID)
-			return next;
-		next++;
-	}
-}
-
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
@@ -2611,6 +2597,62 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 	return ret;
 }
 
+/* Flow actions check specific to RSS filter */
+static int
+ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action *action = parsed_actions->actions[0];
+	const struct rte_flow_action_rss *rss_act = action->conf;
+	struct rte_eth_dev_data *dev_data = param->driver_ctx;
+	const size_t rss_key_len = sizeof(((struct ixgbe_rte_flow_rss_conf *)0)->key);
+	size_t q_idx, q;
+
+	/* check if queue list is not empty */
+	if (rss_act->queue_num == 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS queue list is empty");
+	}
+
+	/* check if each RSS queue is valid */
+	for (q_idx = 0; q_idx < rss_act->queue_num; q_idx++) {
+		q = rss_act->queue[q_idx];
+		if (q >= dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+				"Invalid RSS queue specified");
+		}
+	}
+
+	/* only support default hash function */
+	if (rss_act->func != RTE_ETH_HASH_FUNCTION_DEFAULT) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"Non-default RSS hash functions are not supported");
+	}
+	/* levels aren't supported */
+	if (rss_act->level) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"A nonzero RSS encapsulation level is not supported");
+	}
+	/* check key length */
+	if (rss_act->key_len != 0 && rss_act->key_len != rss_key_len) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"RSS key must be exactly 40 bytes long");
+	}
+	/* filter out unsupported RSS types */
+	if ((rss_act->types & ~IXGBE_RSS_OFFLOAD_ALL) != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss_act,
+			"Invalid RSS type specified");
+	}
+	return 0;
+}
+
 static int
 ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 			const struct rte_flow_attr *attr,
@@ -2618,109 +2660,35 @@ ixgbe_parse_rss_filter(struct rte_eth_dev *dev,
 			struct ixgbe_rte_flow_rss_conf *rss_conf,
 			struct rte_flow_error *error)
 {
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_rss *rss;
-	uint16_t n;
-
-	/**
-	 * rss only supports forwarding,
-	 * check if the first not void action is RSS.
-	 */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_RSS) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	rss = (const struct rte_flow_action_rss *)act->conf;
-
-	if (!rss || !rss->queue_num) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act,
-			   "no valid queues");
-		return -rte_errno;
-	}
-
-	for (n = 0; n < rss->queue_num; n++) {
-		if (rss->queue[n] >= dev->data->nb_rx_queues) {
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION,
-				   act,
-				   "queue id > max number of queues");
-			return -rte_errno;
-		}
-	}
-
-	if (rss->func != RTE_ETH_HASH_FUNCTION_DEFAULT)
-		return rte_flow_error_set
-			(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, act,
-			 "non-default RSS hash functions are not supported");
-	if (rss->level)
-		return rte_flow_error_set
-			(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, act,
-			 "a nonzero RSS encapsulation level is not supported");
-	if (rss->key_len && rss->key_len != RTE_DIM(rss_conf->key))
-		return rte_flow_error_set
-			(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, act,
-			 "RSS hash key must be exactly 40 bytes");
-	if (rss->queue_num > RTE_DIM(rss_conf->queue))
-		return rte_flow_error_set
-			(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION, act,
-			 "too many queues for RSS context");
-	if (ixgbe_rss_conf_init(rss_conf, rss))
-		return rte_flow_error_set
-			(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, act,
-			 "RSS context initialization failure");
-
-	/* check if the next not void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			act, "Not supported action.");
-		return -rte_errno;
-	}
-
-	/* parse attr */
-	/* must be input direction */
-	if (!attr->ingress) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_INGRESS,
-				   attr, "Only support ingress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->egress) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_EGRESS,
-				   attr, "Not support egress.");
-		return -rte_errno;
-	}
-
-	/* not supported */
-	if (attr->transfer) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
-				   attr, "No support for transfer.");
-		return -rte_errno;
-	}
-
-	if (attr->priority > 0xFFFF) {
-		memset(rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
-				   attr, "Error priority.");
-		return -rte_errno;
-	}
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only rss allowed here */
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = dev->data,
+		.check = ixgbe_flow_actions_check_rss,
+		.max_actions = 1,
+	};
+	int ret;
+	const struct rte_flow_action *action;
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
+	action = parsed_actions.actions[0];
+
+	if (ixgbe_rss_conf_init(rss_conf, action->conf))
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"RSS context initialization failure");
 
 	return 0;
 }
-- 
2.47.3

