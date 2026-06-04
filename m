Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D7CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:21:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC86240B9A;
	Thu,  4 Jun 2026 18:19:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 44F3A40A7A
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589995; x=1812125995;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IyhAMhpzDUiMT44n3MXvDoGNVFinljJj0vZeILH3VOI=;
 b=SjEuLQFeUiYn/ZaDjVwbZvoI3l9mpX74/QFJ7s5grj3lZt2hzbShKegf
 HnniKhmt/+I+xv6rlJE3Sl9dfkKlXscROhPHiNV303kEu23tx3u0dvMeT
 VNOkHRTLKOXbAkktUl+GpOERoopsct0ZeSZUwuque3BlapxzajxOQDQQo
 6EGdWCuc0qVdh02O4YGynZiZGCZ5wgIweb5PympFwAEM2ZNBPKryX894w
 bZg2zPWcFytvxAY+qtwk8RH+hH4ffzPiDHldyFHcHnKtegWTI8XrUuWTm
 94EpQ9YUzDk3iFADAekPvqB/6sGjInm8cWQNvnmh4nEyKi8cCEwDPFP98 g==;
X-CSE-ConnectionGUID: 0NMOJTxqSXechuzPDiSX2g==
X-CSE-MsgGUID: azDF93iSTi2IhTLVtFXgBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045138"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045138"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:55 -0700
X-CSE-ConnectionGUID: Fi7zRds9TyqbmCh2Th7mQQ==
X-CSE-MsgGUID: w2zABmHLQR2WQzsqPh2GHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240404062"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 15/27] net/i40e: use common action checks for FDIR
Date: Thu,  4 Jun 2026 17:19:19 +0100
Message-ID: <fe70d106df045121d3791fff7fe7ff987a466a85.1780589914.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for flow director filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 139 ++++++++++++++++-------------
 1 file changed, 76 insertions(+), 63 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 57d83479f1..1ca70ff71c 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2486,28 +2486,49 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 			    struct i40e_fdir_filter_conf *filter)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_action *act;
-	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_mark *mark_spec = NULL;
-	uint32_t index = 0;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_PASSTHRU,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_FLAG,
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+	};
+	const struct rte_flow_action *first, *second;
+	int ret;
 
-	/* Check if the first non-void action is QUEUE or DROP or PASSTHRU. */
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	switch (act->type) {
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+	first = parsed_actions.actions[0];
+	/* can be NULL */
+	second = parsed_actions.actions[1];
+
+	switch (first->type) {
 	case RTE_FLOW_ACTION_TYPE_QUEUE:
-		act_q = act->conf;
+	{
+		const struct rte_flow_action_queue *act_q = first->conf;
+		/* check against PF constraints */
+		if (!filter->input.flow_ext.is_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid queue ID for FDIR");
+		}
+		/* check against VF constraints */
+		if (filter->input.flow_ext.is_vf && act_q->index >= pf->vf_nb_qps) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid queue ID for FDIR");
+		}
 		filter->action.rx_queue = act_q->index;
-		if ((!filter->input.flow_ext.is_vf &&
-		     filter->action.rx_queue >= pf->dev_data->nb_rx_queues) ||
-		    (filter->input.flow_ext.is_vf &&
-		     filter->action.rx_queue >= pf->vf_nb_qps)) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION, act,
-					   "Invalid queue ID for FDIR.");
-			return -rte_errno;
-		}
 		filter->action.behavior = I40E_FDIR_ACCEPT;
 		break;
+	}
 	case RTE_FLOW_ACTION_TYPE_DROP:
 		filter->action.behavior = I40E_FDIR_REJECT;
 		break;
@@ -2515,69 +2536,61 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
 		filter->action.behavior = I40E_FDIR_PASSTHRU;
 		break;
 	case RTE_FLOW_ACTION_TYPE_MARK:
+	{
+		const struct rte_flow_action_mark *act_m = first->conf;
 		filter->action.behavior = I40E_FDIR_PASSTHRU;
-		mark_spec = act->conf;
 		filter->action.report_status = I40E_FDIR_REPORT_ID;
-		filter->soft_id = mark_spec->id;
-	break;
+		filter->soft_id = act_m->id;
+		break;
+	}
 	default:
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, act,
-				   "Invalid action.");
-		return -rte_errno;
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, first,
+				"Invalid first action for FDIR");
 	}
 
-	/* Check if the next non-void item is MARK or FLAG or END. */
-	index++;
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	switch (act->type) {
+	/* do we have another? */
+	if (second == NULL)
+		return 0;
+
+	switch (second->type) {
 	case RTE_FLOW_ACTION_TYPE_MARK:
-		if (mark_spec) {
-			/* Double MARK actions requested */
-			rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, act,
-			   "Invalid action.");
-			return -rte_errno;
+	{
+		const struct rte_flow_action_mark *act_m = second->conf;
+		/* only one mark action can be specified */
+		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+						  RTE_FLOW_ERROR_TYPE_ACTION, second,
+						  "Invalid second action for FDIR");
 		}
-		mark_spec = act->conf;
 		filter->action.report_status = I40E_FDIR_REPORT_ID;
-		filter->soft_id = mark_spec->id;
+		filter->soft_id = act_m->id;
 		break;
+	}
 	case RTE_FLOW_ACTION_TYPE_FLAG:
-		if (mark_spec) {
-			/* MARK + FLAG not supported */
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION, act,
-					   "Invalid action.");
-			return -rte_errno;
+	{
+		/* mark + flag is unsupported */
+		if (first->type == RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, second,
+					"Invalid second action for FDIR");
 		}
 		filter->action.report_status = I40E_FDIR_NO_REPORT_STATUS;
 		break;
+	}
 	case RTE_FLOW_ACTION_TYPE_RSS:
-		if (filter->action.behavior != I40E_FDIR_PASSTHRU) {
-			/* RSS filter won't be next if FDIR did not pass thru */
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION, act,
-					   "Invalid action.");
-			return -rte_errno;
+		/* RSS filter only can be after passthru or mark */
+		if (first->type != RTE_FLOW_ACTION_TYPE_PASSTHRU &&
+				first->type != RTE_FLOW_ACTION_TYPE_MARK) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, second,
+					"Invalid second action for FDIR");
 		}
 		break;
-	case RTE_FLOW_ACTION_TYPE_END:
-		return 0;
 	default:
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Invalid action.");
-		return -rte_errno;
-	}
-
-	/* Check if the next non-void item is END */
-	index++;
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Invalid action.");
-		return -rte_errno;
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION, second,
+					  "Invalid second action for FDIR");
 	}
 
 	return 0;
-- 
2.47.3

