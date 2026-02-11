Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209C6E9E30D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78B484069D;
	Wed, 11 Feb 2026 15:21:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9EC9740A76
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819671; x=1802355671;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UUKwcYwKx54DdKKFthbDddNlNXTgP4EtjvLf6hBjt1Q=;
 b=VPWcoG8nSTtBQSuQFpZuurYZXQa/R633uGCjAiR4bfFghN17xSYLDZzQ
 INTqZiT2snXiC0aK/lfSNxG8HPUeicEN6LVQ86gySQ9F1RgJhEfAZ4EaA
 +T/c7PkbOewYiWzdUne44VwpS9C3hnBJUb/prXwcabZaZrDcrJo6x6fnV
 uVMmtpR01wx/a4f8GEECM9YVthwCkWzTI4arA5wItuMdlKokE2Ftckgnh
 kxWez112iZb/PCTDypiQ+gKblI6hNjSW22AWQCNKc815vPfb9ndsXa79R
 Xa/iNCXxyyPg8pY9seNhBcFtyicdWWhgNGaHK06P5PutcuUi/ZjxHsaoT w==;
X-CSE-ConnectionGUID: kRDhASgVSxqpdIJR7uRtuQ==
X-CSE-MsgGUID: JAbL30c8Ta6tEzSjKDZnyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866754"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866754"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:11 -0800
X-CSE-ConnectionGUID: 7MOSVBHLTQGbZX5zinzvmg==
X-CSE-MsgGUID: U4erSFGpQXu14XBREcI3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569166"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 12/25] net/i40e: use common action checks for ethertype
Date: Wed, 11 Feb 2026 14:20:29 +0000
Message-ID: <c15cb9fb407660b2c658cd740833a65c606f7c4f.1770819434.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for ethertype filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 56 +++++++++++++-----------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index ad80883f13..0e9880e9ce 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1347,43 +1347,35 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
 				 struct rte_flow_error *error,
 				 struct rte_eth_ethertype_filter *filter)
 {
-	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_queue *act_q;
-	uint32_t index = 0;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_END,
+		},
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
+	int ret;
 
-	/* Check if the first non-void action is QUEUE or DROP. */
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type != RTE_FLOW_ACTION_TYPE_QUEUE &&
-	    act->type != RTE_FLOW_ACTION_TYPE_DROP) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Not supported action.");
-		return -rte_errno;
-	}
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+	action = parsed_actions.actions[0];
 
-	if (act->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		act_q = act->conf;
+	if (action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *act_q = action->conf;
+		/* check queue index */
+		if (act_q->index >= dev->data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, action,
+					"Invalid queue index");
+		}
 		filter->queue = act_q->index;
-		if (filter->queue >= pf->dev_data->nb_rx_queues) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION,
-					   act, "Invalid queue ID for"
-					   " ethertype_filter.");
-			return -rte_errno;
-		}
-	} else {
+	} else if (action->type == RTE_FLOW_ACTION_TYPE_DROP) {
 		filter->flags |= RTE_ETHTYPE_FLAGS_DROP;
 	}
-
-	/* Check if the next non-void item is END */
-	index++;
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Not supported action.");
-		return -rte_errno;
-	}
-
 	return 0;
 }
 
-- 
2.47.3

