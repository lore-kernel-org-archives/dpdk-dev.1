Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71CCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB9E402E5;
	Mon, 25 May 2026 16:07:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7837840C35
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718043; x=1811254043;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ztBlvNCTEumcYlRvTen/mfK1yTwaWbDQkrH+yltCVwU=;
 b=V9xH9goGCma2WQJMmL1NnCT8kZ7j1OyulG/lK5C5DY7yM0CMEUXnYkGZ
 tZMO8RO/6HrNdUiwY6YzsDUSb1F6+znPz37RTeW5EBAq7jt1EGPDviHTr
 udwOgM6nr0BQkywL6XVXyy/zbPzbK/58lpw24bO3UYb44+mBldOTUcKFX
 NU4PhKXlXdEC6NFW5XtUvGg7xRQ/eKNJrw4DCJB+2IFZxPVON2Wn5P9Rk
 INOdJx9l0xJXehzAhF7sJVkyWZ6LjrRiuuvdbqXGJMwLkM+Ed1VxeS1bi
 PFQR/Y2Ia6qgzRo08yYOmr8Zlrc6jHaqpNyTBBU51gO1RgPAb2q+zQrsu A==;
X-CSE-ConnectionGUID: QnLprnV4Qdmd4zRMd3uMIQ==
X-CSE-MsgGUID: rlF/DaL4Q0i6OyyUi6kQvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392540"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392540"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:23 -0700
X-CSE-ConnectionGUID: nKepSskBSLql+Rd4SFeHyw==
X-CSE-MsgGUID: gbTluqr+SvGXrVmEY1oivg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692425"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 25/27] net/ice: use common action checks for FDIR
Date: Mon, 25 May 2026 15:06:44 +0100
Message-ID: <6e276474cec5d61b7491aeedc27e74bf45048966.1779717944.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
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
index 4efa078aca..2b4c978dd6 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1695,177 +1695,6 @@ static struct ice_flow_engine ice_fdir_engine = {
 	.rule_size = sizeof(struct ice_fdir_filter_conf),
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
-			memcpy(&filter->act_count, act_count,
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
@@ -2804,6 +2633,188 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
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
+	     (rss->queue_num <= ICE_FDIR_MAX_QREGION_SIZE)))
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"The region size should be any of the following values:"
+				"2, 4, 8, 16, 32, 64, 128 as long as the total number "
+				"of queues do not exceed the VSI allocation.");
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
@@ -2814,6 +2825,22 @@ ice_fdir_parse(struct ice_adapter *ad,
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
+		.rss_queues_contig = true,
+	};
 	struct ice_pf *pf = &ad->pf;
 	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
 	struct ice_pattern_match_item *item = NULL;
@@ -2826,6 +2853,11 @@ ice_fdir_parse(struct ice_adapter *ad,
 		return ret;
 
 	memset(filter, 0, sizeof(*filter));
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
 					     error);
 
@@ -2854,7 +2886,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 		goto error;
 	}
 
-	ret = ice_fdir_parse_action(ad, actions, error, filter);
+	ret = ice_fdir_parse_action(ad, &parsed_actions, error);
 	if (ret)
 		goto error;
 
-- 
2.47.3

