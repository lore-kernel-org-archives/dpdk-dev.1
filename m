Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549A2CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF73040A8A;
	Fri, 22 May 2026 17:15:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 984BD40695
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462899; x=1810998899;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JHuc6Ao48txuad4LCqw250XYMb6zPIRixvAOZOhmExs=;
 b=Uq/oqVCfZLkPsEZ9YdK8A0ZOc40PMDAxnPKEy3LyQwtDl8D6p4l/TUnJ
 ksFEcWvaLTOuJTVK7iv5+dRV5zVcBXIAHCkmweKFR+RyoRLScdBErOqCR
 FOPe0QskO87F6c2n/7l5XWpgaNFG4Nddw2aypOAx9dg+fE3o5aBSHTh3+
 7sfw+Iya7f0XT3+HtUU0iqkS1cmknkWcBjKoowXPcKrUWh/h9Tv7OJjuw
 1IiC2W0r+bGzzzMnkShtFQ4WOZ+u7MSYDWHVjeDnX+mw7DX4IwnXs0DGq
 nTgjUnLxvEjg5khbonrP5j+6peOH1MW/GD0vdSUl6XcfXM+JZjrV768xk Q==;
X-CSE-ConnectionGUID: fqLl7yshR1OZrrmuXE+EAw==
X-CSE-MsgGUID: Rhy8reJqR7uxQAkc/7JcDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969167"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969167"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:58 -0700
X-CSE-ConnectionGUID: FxgY5vKQQG6Sy5m08ZFn0w==
X-CSE-MsgGUID: KeaVk/vtTCasMqifx/eAtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213980"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 13/26] net/i40e: use common action checks for ethertype
Date: Fri, 22 May 2026 16:14:22 +0100
Message-ID: <509962531b36fdb0788b4eb96bf9c9a215da098d.1779462699.git.anatoly.burakov@intel.com>
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
flow actions for ethertype filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 56 +++++++++++++-----------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 9f1fb7bbc7..57d83479f1 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1448,43 +1448,35 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
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

