Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54BE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 736A040E31;
	Wed, 11 Feb 2026 15:21:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id C301340E28
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819689; x=1802355689;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aXG0UMuPHeu02uwB8vx12mFFQ5yn58xKAfHFwwRxJ2Y=;
 b=N9b0AzBKM66uzVkIy5LbvOpxpOvQThtxmEufZ3leli9cHSBao8Ms9u3Y
 jDp8ozW5ZOx2VITtxkHTNqZ7hcLz5JgTa2VmKnLdhL11lSQt2THticLIU
 TpRY6+/Yolzr8U01yDaIyYHIL/+mQfLY83NZXTQjW8MsKrHNn6ZsOs20l
 WwOidshrELCFQ+RQz9dM3a6GAvAgfMt9VX9ty/43/aDSMDZ8kqfSMVnA4
 ygg5st+6EOiLcIF3/gSTAuPwg8Zks9nJJICEtwzupcuRPpkKrRzqLrJGN
 qwMr1TaIUoz4R13ZlovgNzrZGeDFVt6QqnXaew1jLZX7dN4NRI5rT7MPr g==;
X-CSE-ConnectionGUID: ZHleLJJbSXCTt1ZJzNy+Aw==
X-CSE-MsgGUID: YWq4NbotRluknnBJ8zvcRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866795"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866795"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:27 -0800
X-CSE-ConnectionGUID: yxXX/GLUQkWe9mKJrWGYWQ==
X-CSE-MsgGUID: mwR1Z/tGQJGKRpXHJdTtUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569247"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 23/25] net/ice: use common action checks for FDIR
Date: Wed, 11 Feb 2026 14:20:40 +0000
Message-ID: <9b181ed97039b89ad7cdf8d75bdae9ef577e4725.1770819434.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Use the common flow action checking parsing infrastructure for checking
flow actions for FDIR filter.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 376 +++++++++++++-----------
 1 file changed, 204 insertions(+), 172 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 553b20307c..a204aa785b 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1604,177 +1604,6 @@ static struct ice_flow_engine ice_fdir_engine = {
 	.type = ICE_FLOW_ENGINE_FDIR,
 };
 
-static int
-ice_fdir_parse_action_qregion(struct ice_pf *pf,
-			      struct rte_flow_error *error,
-			      const struct rte_flow_action *act,
-			      struct ice_fdir_filter_conf *filter)
-{
-	const struct rte_flow_action_rss *rss = act->conf;
-	uint32_t i;
-
-	if (act->type != RTE_FLOW_ACTION_TYPE_RSS) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, act,
-				   "Invalid action.");
-		return -rte_errno;
-	}
-
-	if (rss->queue_num <= 1) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, act,
-				   "Queue region size can't be 0 or 1.");
-		return -rte_errno;
-	}
-
-	/* check if queue index for queue region is continuous */
-	for (i = 0; i < rss->queue_num - 1; i++) {
-		if (rss->queue[i + 1] != rss->queue[i] + 1) {
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION, act,
-					   "Discontinuous queue region");
-			return -rte_errno;
-		}
-	}
-
-	if (rss->queue[rss->queue_num - 1] >= pf->dev_data->nb_rx_queues) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, act,
-				   "Invalid queue region indexes.");
-		return -rte_errno;
-	}
-
-	if (!(rte_is_power_of_2(rss->queue_num) &&
-	     (rss->queue_num <= ICE_FDIR_MAX_QREGION_SIZE))) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, act,
-				   "The region size should be any of the following values:"
-				   "1, 2, 4, 8, 16, 32, 64, 128 as long as the total number "
-				   "of queues do not exceed the VSI allocation.");
-		return -rte_errno;
-	}
-
-	filter->input.q_index = rss->queue[0];
-	filter->input.q_region = rte_fls_u32(rss->queue_num) - 1;
-	filter->input.dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
-
-	return 0;
-}
-
-static int
-ice_fdir_parse_action(struct ice_adapter *ad,
-		      const struct rte_flow_action actions[],
-		      struct rte_flow_error *error,
-		      struct ice_fdir_filter_conf *filter)
-{
-	struct ice_pf *pf = &ad->pf;
-	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_mark *mark_spec = NULL;
-	const struct rte_flow_action_count *act_count;
-	uint32_t dest_num = 0;
-	uint32_t mark_num = 0;
-	uint32_t counter_num = 0;
-	int ret;
-
-	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
-		switch (actions->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
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
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			dest_num++;
-
-			filter->input.dest_ctl =
-				ICE_FLTR_PRGM_DESC_DEST_DROP_PKT;
-			break;
-		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
-			dest_num++;
-
-			filter->input.dest_ctl =
-				ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER;
-			break;
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			dest_num++;
-
-			ret = ice_fdir_parse_action_qregion(pf,
-						error, actions, filter);
-			if (ret)
-				return ret;
-			break;
-		case RTE_FLOW_ACTION_TYPE_MARK:
-			mark_num++;
-			filter->mark_flag = 1;
-			mark_spec = actions->conf;
-			filter->input.fltr_id = mark_spec->id;
-			filter->input.fdid_prio = ICE_FXD_FLTR_QW1_FDID_PRI_ONE;
-			break;
-		case RTE_FLOW_ACTION_TYPE_COUNT:
-			counter_num++;
-
-			act_count = actions->conf;
-			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
-			rte_memcpy(&filter->act_count, act_count,
-						sizeof(filter->act_count));
-
-			break;
-		default:
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-				   "Invalid action.");
-			return -rte_errno;
-		}
-	}
-
-	if (dest_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Unsupported action combination");
-		return -rte_errno;
-	}
-
-	if (mark_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Too many mark actions");
-		return -rte_errno;
-	}
-
-	if (counter_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Too many count actions");
-		return -rte_errno;
-	}
-
-	if (dest_num + mark_num + counter_num == 0) {
-		rte_flow_error_set(error, EINVAL,
-			   RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			   "Empty action");
-		return -rte_errno;
-	}
-
-	/* set default action to PASSTHRU mode, in "mark/count only" case. */
-	if (dest_num == 0)
-		filter->input.dest_ctl =
-			ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER;
-
-	return 0;
-}
 
 static int
 ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
@@ -2451,6 +2280,189 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	return 0;
 }
 
+static int
+ice_fdir_parse_action(struct ice_adapter *ad,
+		const struct ci_flow_actions *actions,
+		struct rte_flow_error *error)
+{
+	struct ice_pf *pf = &ad->pf;
+	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
+	bool dest_set = false;
+	size_t i;
+
+	for (i = 0; i < actions->count; i++) {
+		const struct rte_flow_action *act = actions->actions[i];
+
+		switch (act->type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		{
+			const struct rte_flow_action_queue *act_q = act->conf;
+			dest_set = true;
+
+			filter->input.q_index = act_q->index;
+			filter->input.dest_ctl =
+				ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			dest_set = true;
+
+			filter->input.dest_ctl =
+				ICE_FLTR_PRGM_DESC_DEST_DROP_PKT;
+			break;
+		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
+			dest_set = true;
+
+			filter->input.dest_ctl =
+				ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER;
+			break;
+		case RTE_FLOW_ACTION_TYPE_RSS:
+		{
+			const struct rte_flow_action_rss *rss = act->conf;
+			dest_set = true;
+
+			filter->input.q_index = rss->queue[0];
+			filter->input.q_region = rte_fls_u32(rss->queue_num) - 1;
+			filter->input.dest_ctl = ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QGROUP;
+
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_MARK:
+		{
+			const struct rte_flow_action_mark *mark_spec = act->conf;
+			filter->mark_flag = 1;
+			filter->input.fltr_id = mark_spec->id;
+			filter->input.fdid_prio = ICE_FXD_FLTR_QW1_FDID_PRI_ONE;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+		{
+			const struct rte_flow_action_count *act_count = act->conf;
+
+			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
+			rte_memcpy(&filter->act_count, act_count,
+						sizeof(filter->act_count));
+			break;
+		}
+		default:
+			/* Should not happen */
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, act,
+					"Invalid action.");
+		}
+	}
+
+	/* set default action to PASSTHRU mode, in "mark/count only" case. */
+	if (!dest_set) {
+		filter->input.dest_ctl =
+			ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_OTHER;
+	}
+
+	return 0;
+}
+
+static int
+ice_fdir_check_action_qregion(struct ice_pf *pf,
+			      struct rte_flow_error *error,
+			      const struct rte_flow_action_rss *rss)
+{
+	if (rss->queue_num <= 1) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Queue region size can't be 0 or 1.");
+	}
+
+	if (rss->queue[rss->queue_num - 1] >= pf->dev_data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Invalid queue region indexes.");
+	}
+
+	if (!(rte_is_power_of_2(rss->queue_num) &&
+	     (rss->queue_num <= ICE_FDIR_MAX_QREGION_SIZE))) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"The region size should be any of the following values:"
+				"2, 4, 8, 16, 32, 64, 128 as long as the total number "
+				"of queues do not exceed the VSI allocation.");
+	}
+
+	return 0;
+}
+
+static int
+ice_fdir_check_action(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct ice_adapter *ad = param->driver_ctx;
+	struct ice_pf *pf = &ad->pf;
+	uint32_t dest_num = 0;
+	uint32_t mark_num = 0;
+	uint32_t counter_num = 0;
+	size_t i;
+	int ret;
+
+	for (i = 0; i < actions->count; i++) {
+		const struct rte_flow_action *act = actions->actions[i];
+
+		switch (act->type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		{
+			const struct rte_flow_action_queue *act_q = act->conf;
+			dest_num++;
+
+			if (act_q->index >= pf->dev_data->nb_rx_queues) {
+				return rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ACTION,
+						   act,
+						   "Invalid queue for FDIR.");
+			}
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			dest_num++;
+			break;
+		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
+			dest_num++;
+			break;
+		case RTE_FLOW_ACTION_TYPE_RSS:
+		{
+			const struct rte_flow_action_rss *rss = act->conf;
+
+			dest_num++;
+			ret = ice_fdir_check_action_qregion(pf, error, rss);
+			if (ret)
+				return ret;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_MARK:
+		{
+			mark_num++;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+		{
+			counter_num++;
+			break;
+		}
+		default:
+			/* Should not happen */
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, act,
+					"Invalid action.");
+		}
+	}
+
+	if (dest_num > 1 || mark_num > 1 || counter_num > 1) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Unsupported action combination");
+	}
+
+	return 0;
+}
+
 static int
 ice_fdir_parse(struct ice_adapter *ad,
 	       struct ice_pattern_match_item *array,
@@ -2461,6 +2473,21 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       void **meta,
 	       struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_PASSTHRU,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_COUNT,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 3,
+		.check = ice_fdir_check_action,
+		.driver_ctx = ad,
+	};
 	struct ice_pf *pf = &ad->pf;
 	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
 	struct ice_pattern_match_item *item = NULL;
@@ -2473,6 +2500,11 @@ ice_fdir_parse(struct ice_adapter *ad,
 		return ret;
 
 	memset(filter, 0, sizeof(*filter));
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
 
@@ -2500,7 +2532,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 		goto error;
 	}
 
-	ret = ice_fdir_parse_action(ad, actions, error, filter);
+	ret = ice_fdir_parse_action(ad, &parsed_actions, error);
 	if (ret)
 		goto error;
 
-- 
2.47.3

