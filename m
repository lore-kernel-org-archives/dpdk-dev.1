Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE13E9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B14E40B9B;
	Wed, 11 Feb 2026 15:21:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B91D240A80
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819673; x=1802355673;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=O16E4pYupgwo+XNsEeCH593keEao3e4lRHnd+h8Ia8c=;
 b=UeM4hbmaux6L5syjFn5lPbkDt0rDz6JIvLuoihDjCiTT7WkS4zuVTu+0
 qtfj51bxycv3HmS4SbLkx2l5nzvfrU9fbJ2kjPz4MJ8WhrUqkAlJ/k/Yt
 1cn2gye00KdL+WApC6kgQluqWWIu5CRwduou+R5KriS0QoG2vL4GC3oZ1
 DurggpuarWbkeiNmBXrTFKb6uBH9JiBroHKlYyTYrs9ZDXY4vtjApf/4G
 oTEiPD59ArJLT2p5tclEJAWtlKabD+RQyNDBjJ8wuDnfkNrww1ka7ODU2
 6ZurhRwDbSRK+1UoM1QkxytPZXEkWKFcGVglfmyT5hJTFpI/rjA94yNoK Q==;
X-CSE-ConnectionGUID: nSIsvObcTuejd1NZr9Jyfw==
X-CSE-MsgGUID: jwmaCOnHSzawydYTnPGlKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866755"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866755"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:12 -0800
X-CSE-ConnectionGUID: P+ZGRVbeSKioArDPUCGxdQ==
X-CSE-MsgGUID: yLflcnrgSx+P7Z1tqEUGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569170"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:12 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 13/25] net/i40e: use common action checks for FDIR
Date: Wed, 11 Feb 2026 14:20:30 +0000
Message-ID: <b8e267c987cf5c3859ca098e2a03d1433f239927.1770819434.git.anatoly.burakov@intel.com>
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
flow actions for flow director filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 139 ++++++++++++++++-------------
 1 file changed, 76 insertions(+), 63 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 0e9880e9ce..d8c8654cfa 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2371,28 +2371,49 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
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
@@ -2400,69 +2421,61 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
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

