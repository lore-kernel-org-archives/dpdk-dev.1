Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B2CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:39:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22DA940E2A;
	Fri, 29 May 2026 17:37:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 602CE40DDC
 for <dev@dpdk.org>; Fri, 29 May 2026 17:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069030; x=1811605030;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Sq0lxTRQkSrxrih/i3Jlh/LODHMTfYPo/5I0mgrlPjA=;
 b=VQqQj1OnKMSTZz4lQ9+ujI/RB6lIKx2BlpHMwPemFnkOlp+GlH5HrWyF
 vzAUtIUVq7RI8On2vX7utlkcp+UDH0gFmhZ2xTFUQg50+icGNcsHYXwV9
 bnZWwL/IJBYMJkJbB7vyIrP56xMjLbnYvQuw04ooswsFJ8dWvMHPFhWEF
 auAULCCO68YLKJdAccjNlIfGEonUJDZkwcajWWWid1csshhPFpKg0jBiC
 MpIXSd68YMp/ZiSP7b5wfPab90baEKbVvp0GodB2InTCuIMqry09CwgQ8
 C/ymp8nqnGB8Zf7soPFb7vRj52XLGdEPs8uufMHTgMuwH5/bjOfBLkSdH Q==;
X-CSE-ConnectionGUID: zJd/5ooGQyuuoLoVVRGmZA==
X-CSE-MsgGUID: mqFpe1JzRwWABZO+F0A8fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549827"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549827"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:37:09 -0700
X-CSE-ConnectionGUID: ZjSDj0ovSdePp8fUPZUFPg==
X-CSE-MsgGUID: JzbvQMPETUaHIH1m7oZDHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001319"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:37:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 27/27] net/ice: use common action checks for ACL
Date: Fri, 29 May 2026 16:36:29 +0100
Message-ID: <d70d0097d535928d25bb853c7a9f5469cb9b90ab.1780068634.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Use the common flow action checking parsing infrastructure for checking
flow actions for ACL filter.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 143 +++++++++++++++----------
 1 file changed, 84 insertions(+), 59 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 0b50f06c46..30ff1254c9 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -645,60 +645,6 @@ ice_acl_filter_free(struct rte_flow *flow)
 	flow->rule = NULL;
 }
 
-static int
-ice_acl_parse_action(__rte_unused struct ice_adapter *ad,
-		     const struct rte_flow_action actions[],
-		     struct rte_flow_error *error,
-		     struct ice_acl_conf *filter)
-{
-	struct ice_pf *pf = &ad->pf;
-	const struct rte_flow_action_queue *act_q;
-	uint32_t dest_num = 0;
-
-	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
-		switch (actions->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			dest_num++;
-
-			filter->input.dest_ctl =
-				ICE_FLTR_PRGM_DESC_DEST_DROP_PKT;
-			break;
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			dest_num++;
-
-			act_q = actions->conf;
-			filter->input.q_index = act_q->index;
-			if (filter->input.q_index >=
-					pf->dev_data->nb_rx_queues) {
-				rte_flow_error_set(error, EINVAL,
-						   RTE_FLOW_ERROR_TYPE_ACTION,
-						   actions,
-						   "Invalid queue for FDIR.");
-				return -rte_errno;
-			}
-			filter->input.dest_ctl =
-				ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
-			break;
-		default:
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-				   "Invalid action.");
-			return -rte_errno;
-		}
-	}
-
-	if (dest_num == 0 || dest_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Unsupported action combination");
-		return -rte_errno;
-	}
-
-	return 0;
-}
-
 static int
 ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
 		       const struct rte_flow_item pattern[],
@@ -966,6 +912,69 @@ ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
 	return 0;
 }
 
+static int
+ice_acl_parse_action(const struct ci_flow_actions *actions,
+		struct ice_acl_conf *filter,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action *act = actions->actions[0];
+
+	switch (act->type) {
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		filter->input.dest_ctl =
+			ICE_FLTR_PRGM_DESC_DEST_DROP_PKT;
+		break;
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	{
+		const struct rte_flow_action_queue *act_q = act->conf;
+
+		filter->input.q_index = act_q->index;
+		filter->input.dest_ctl =
+			ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
+		break;
+	}
+	default:
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, act,
+				"Invalid action.");
+	}
+
+	return 0;
+}
+
+static int
+ice_acl_parse_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct ice_adapter *ad = param->driver_ctx;
+	struct ice_pf *pf = &ad->pf;
+	const struct rte_flow_action *act = actions->actions[0];
+
+	switch (act->type) {
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		break;
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+	{
+		const struct rte_flow_action_queue *act_q = act->conf;
+
+		if (act_q->index >= pf->dev_data->nb_rx_queues) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, act,
+					"Invalid queue for ACL.");
+		}
+		break;
+	}
+	default:
+		/* shouldn't happen */
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, act,
+				"Invalid action.");
+	}
+
+	return 0;
+}
+
 static int
 ice_acl_parse(struct ice_adapter *ad,
 	       struct ice_pattern_match_item *array,
@@ -976,17 +985,33 @@ ice_acl_parse(struct ice_adapter *ad,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.check = ice_acl_parse_action_check,
+		.driver_ctx = ad,
+	};
 	struct ice_pf *pf = &ad->pf;
 	struct ice_acl_conf *filter = &pf->acl.conf;
 	struct ice_pattern_match_item *item = NULL;
 	uint64_t input_set;
 	int ret;
 
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret)
-		return ret;
-
 	memset(filter, 0, sizeof(*filter));
+
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
 	if (!item)
@@ -1005,7 +1030,7 @@ ice_acl_parse(struct ice_adapter *ad,
 		goto error;
 	}
 
-	ret = ice_acl_parse_action(ad, actions, error, filter);
+	ret = ice_acl_parse_action(&parsed_actions, filter, error);
 	if (ret)
 		goto error;
 
-- 
2.47.3

