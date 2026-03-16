Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B5F4644A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:54:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AE3240687;
	Mon, 16 Mar 2026 11:53:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 7935C4068A
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658392; x=1805194392;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v+Osk8S5ukiPzQ46egtfPHp1coiucI5Xn0ihkC5wn2Y=;
 b=jbzaPtSLHll+48ASBrZtyMs4eJ8qpGcSgbvnV1J9pzQ0zkjaE6X6CFbC
 ix7MCpG5m9e7qgoYZKJ8FgAG9kqC2k6sknvApUnz0v3zlVbHK5P5rKdng
 eCUH+3Exc7EJzsoICsGDtACH8SCJQF68P9/v88ZlkpKCLMmq0qUWVIU0d
 x2+Grt3IfBlfFaBnqUJ5IAXWx5phNMMkruqkutKza4gy7jV5nvxLaqMJY
 OMTgocjlryfqalGrKiOojybikTlS314LeTt4xQ/6/LfaUdZU3B+b5BvrG
 fjHZgvtoEfCMs8tUI2IWOHgnNmoLdaTK6LhPA3QCkf7QqrJmYfTkssKlR w==;
X-CSE-ConnectionGUID: Sjs53gscQIOFzizRQa7pUg==
X-CSE-MsgGUID: u28EX+6HRBaLNrQheml14A==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237428"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237428"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:11 -0700
X-CSE-ConnectionGUID: stdNb0p0RCm3b0PMtNSAaA==
X-CSE-MsgGUID: 7DIAEoPwTNSfAA4RxGrPdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826760"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 13/25] net/i40e: use common action checks for FDIR
Date: Mon, 16 Mar 2026 10:52:38 +0000
Message-ID: <fc6a5c3383c266bc221621c6deecd7549a58eaf8.1773658290.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for flow director filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 139 ++++++++++++++++-------------
 1 file changed, 76 insertions(+), 63 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2454d3e5ca..3470f35a20 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2396,28 +2396,49 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
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
@@ -2425,69 +2446,61 @@ i40e_flow_parse_fdir_action(struct rte_eth_dev *dev,
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

