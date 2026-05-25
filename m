Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B7ACD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:09:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42BE440685;
	Mon, 25 May 2026 16:07:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id CDAD040A7F
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718038; x=1811254038;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QiI13HSZGzP4riM7PfplITKPpTIyeUftAz4XP9gqDN0=;
 b=TZA2QXwjBSWP1KDV2Zy1zynhV9fRFlx7LbMhe72Ts4jb1AbVLQENNDyV
 CTuec/vI4ZSzWm2ToKxFaqim3xA4nc6ufluxPoeiXpqXr9GFKLiUUYt5K
 28pZpGSYjss1RnYmdmdQHvMd0VO8lO8lOYqXahVWT/H1SfkR8b2G7ahli
 z/c95L9+YPNP9SB6J6Z0PIWsqJg6aUqsi4SIIuRFroi83Rcybt4joNvHw
 Nrmk3ohbL2caFoeSbC6fQrIdzEvmxSZXRBCiiGfRtu5HtqJCKtbY72sLp
 mkI6zGmLr2oZWrko7J7j5m35bAkck7kQ9ZI/QhvXHrcc1UUa9GcI5jkjE w==;
X-CSE-ConnectionGUID: 5yCcQlbORuSFQV0TOo4RZg==
X-CSE-MsgGUID: CZXdObM1SlCcgJ4auU8tfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392527"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392527"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:17 -0700
X-CSE-ConnectionGUID: IjR4IKMNQd6FBqwu4mewZg==
X-CSE-MsgGUID: ur3l09eHQTKuniXb2EmV+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692399"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 20/27] net/iavf: use common action checks for FDIR
Date: Mon, 25 May 2026 15:06:39 +0100
Message-ID: <0303bf272e5a5248dcaa69218bf5db8d43bdd3da.1779717944.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for FDIR filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c | 360 +++++++++++++----------------
 1 file changed, 158 insertions(+), 202 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 91efc986d8..8940132dff 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -443,204 +443,6 @@ static struct iavf_flow_engine iavf_fdir_engine = {
 	.rule_size = sizeof(struct iavf_fdir_conf),
 };
 
-static int
-iavf_fdir_parse_action_qregion(struct iavf_adapter *ad,
-			struct rte_flow_error *error,
-			const struct rte_flow_action *act,
-			struct virtchnl_filter_action *filter_action)
-{
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
-	const struct rte_flow_action_rss *rss = act->conf;
-	uint32_t i;
-
-	if (act->type != RTE_FLOW_ACTION_TYPE_RSS) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"Invalid action.");
-		return -rte_errno;
-	}
-
-	if (rss->queue_num <= 1) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"Queue region size can't be 0 or 1.");
-		return -rte_errno;
-	}
-
-	/* check if queue index for queue region is continuous */
-	for (i = 0; i < rss->queue_num - 1; i++) {
-		if (rss->queue[i + 1] != rss->queue[i] + 1) {
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, act,
-					"Discontinuous queue region");
-			return -rte_errno;
-		}
-	}
-
-	if (rss->queue[rss->queue_num - 1] >= ad->dev_data->nb_rx_queues) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"Invalid queue region indexes.");
-		return -rte_errno;
-	}
-
-	if (!(rte_is_power_of_2(rss->queue_num) &&
-		rss->queue_num <= IAVF_FDIR_MAX_QREGION_SIZE)) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"The region size should be any of the following values:"
-				"1, 2, 4, 8, 16, 32, 64, 128 as long as the total number "
-				"of queues do not exceed the VSI allocation.");
-		return -rte_errno;
-	}
-
-	if (rss->queue_num > vf->max_rss_qregion) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"The region size cannot be large than the supported max RSS queue region");
-		return -rte_errno;
-	}
-
-	filter_action->act_conf.queue.index = rss->queue[0];
-	filter_action->act_conf.queue.region = rte_fls_u32(rss->queue_num) - 1;
-
-	return 0;
-}
-
-static int
-iavf_fdir_parse_action(struct iavf_adapter *ad,
-			const struct rte_flow_action actions[],
-			struct rte_flow_error *error,
-			struct iavf_fdir_conf *filter)
-{
-	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_mark *mark_spec = NULL;
-	uint32_t dest_num = 0;
-	uint32_t mark_num = 0;
-	int ret;
-
-	int number = 0;
-	struct virtchnl_filter_action *filter_action;
-
-	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
-		switch (actions->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
-			dest_num++;
-
-			filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-
-			filter_action->type = VIRTCHNL_ACTION_PASSTHRU;
-
-			filter->add_fltr.rule_cfg.action_set.count = ++number;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			dest_num++;
-
-			filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-
-			filter_action->type = VIRTCHNL_ACTION_DROP;
-
-			filter->add_fltr.rule_cfg.action_set.count = ++number;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			dest_num++;
-
-			act_q = actions->conf;
-			filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-
-			filter_action->type = VIRTCHNL_ACTION_QUEUE;
-			filter_action->act_conf.queue.index = act_q->index;
-
-			if (filter_action->act_conf.queue.index >=
-				ad->dev_data->nb_rx_queues) {
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					actions, "Invalid queue for FDIR.");
-				return -rte_errno;
-			}
-
-			filter->add_fltr.rule_cfg.action_set.count = ++number;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			dest_num++;
-
-			filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-
-			filter_action->type = VIRTCHNL_ACTION_Q_REGION;
-
-			ret = iavf_fdir_parse_action_qregion(ad,
-						error, actions, filter_action);
-			if (ret)
-				return ret;
-
-			filter->add_fltr.rule_cfg.action_set.count = ++number;
-			break;
-
-		case RTE_FLOW_ACTION_TYPE_MARK:
-			mark_num++;
-
-			filter->mark_flag = 1;
-			mark_spec = actions->conf;
-			filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-
-			filter_action->type = VIRTCHNL_ACTION_MARK;
-			filter_action->act_conf.mark_id = mark_spec->id;
-
-			filter->add_fltr.rule_cfg.action_set.count = ++number;
-			break;
-
-		default:
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, actions,
-					"Invalid action.");
-			return -rte_errno;
-		}
-	}
-
-	if (number > VIRTCHNL_MAX_NUM_ACTIONS) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			"Action numbers exceed the maximum value");
-		return -rte_errno;
-	}
-
-	if (dest_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			"Unsupported action combination");
-		return -rte_errno;
-	}
-
-	if (mark_num >= 2) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			"Too many mark actions");
-		return -rte_errno;
-	}
-
-	if (dest_num + mark_num == 0) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION, actions,
-			"Empty action");
-		return -rte_errno;
-	}
-
-	/* Mark only is equal to mark + passthru. */
-	if (dest_num == 0) {
-		filter_action = &filter->add_fltr.rule_cfg.action_set.actions[number];
-		filter_action->type = VIRTCHNL_ACTION_PASSTHRU;
-		filter->add_fltr.rule_cfg.action_set.count = ++number;
-	}
-
-	return 0;
-}
-
 static bool
 iavf_fdir_refine_input_set(const uint64_t input_set,
 			   const uint64_t input_set_mask,
@@ -1589,6 +1391,145 @@ iavf_fdir_parse_pattern(__rte_unused struct iavf_adapter *ad,
 	return 0;
 }
 
+static int
+iavf_fdir_action_check_qregion(struct iavf_adapter *ad,
+		const struct rte_flow_action_rss *rss,
+		struct rte_flow_error *error)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+
+	if (rss->queue_num <= 1) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Queue region size can't be 0 or 1.");
+	}
+
+	if (rss->queue[rss->queue_num - 1] >= ad->dev_data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Invalid queue region indexes.");
+	}
+
+	if (!(rte_is_power_of_2(rss->queue_num) &&
+		rss->queue_num <= IAVF_FDIR_MAX_QREGION_SIZE)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"The region size should be any of the following values:"
+				"1, 2, 4, 8, 16, 32, 64, 128 as long as the total number "
+				"of queues do not exceed the VSI allocation.");
+	}
+
+	if (rss->queue_num > vf->max_rss_qregion) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"The region size cannot be large than the supported max RSS queue region");
+	}
+
+	return 0;
+}
+
+static int
+iavf_fdir_parse_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	struct iavf_adapter *ad = param->driver_ctx;
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+	struct iavf_fdir_conf *filter = &vf->fdir.conf;
+	uint32_t dest_num = 0, mark_num = 0;
+	size_t i, number = 0;
+	bool has_drop = false;
+	int ret;
+
+	for (i = 0; i < actions->count; i++) {
+		const struct rte_flow_action *act = actions->actions[i];
+		struct virtchnl_filter_action *filter_action =
+				&filter->add_fltr.rule_cfg.action_set.actions[number];
+
+		switch (act->type) {
+		case RTE_FLOW_ACTION_TYPE_PASSTHRU:
+			dest_num++;
+
+			filter_action->type = VIRTCHNL_ACTION_PASSTHRU;
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			dest_num++;
+			has_drop = true;
+
+			filter_action->type = VIRTCHNL_ACTION_DROP;
+			break;
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+		{
+			const struct rte_flow_action_queue *act_q;
+			dest_num++;
+
+			act_q = act->conf;
+
+			filter_action->type = VIRTCHNL_ACTION_QUEUE;
+
+			if (act_q->index >= ad->dev_data->nb_rx_queues) {
+				return rte_flow_error_set(error, EINVAL,
+						RTE_FLOW_ERROR_TYPE_ACTION, actions,
+						"Invalid queue index.");
+			}
+			filter_action->act_conf.queue.index = act_q->index;
+
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RSS:
+		{
+			const struct rte_flow_action_rss *rss = act->conf;
+			dest_num++;
+
+			filter_action->type = VIRTCHNL_ACTION_Q_REGION;
+
+			ret = iavf_fdir_action_check_qregion(ad, rss, error);
+			if (ret)
+				return ret;
+
+			filter_action->act_conf.queue.index = rss->queue[0];
+			filter_action->act_conf.queue.region = rte_fls_u32(rss->queue_num) - 1;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_MARK:
+		{
+			const struct rte_flow_action_mark *mark_spec;
+			mark_num++;
+
+			filter->mark_flag = 1;
+			mark_spec = act->conf;
+
+			filter_action->type = VIRTCHNL_ACTION_MARK;
+			filter_action->act_conf.mark_id = mark_spec->id;
+
+			break;
+		}
+		default:
+			/* cannot happen */
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, actions,
+					"Invalid action.");
+		}
+		filter->add_fltr.rule_cfg.action_set.count = ++number;
+	}
+
+	if (dest_num > 1 || mark_num > 1 || (has_drop && mark_num > 1)) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION, actions,
+			"Unsupported action combination");
+	}
+
+	/* Mark only is equal to mark + passthru. */
+	if (dest_num == 0) {
+		struct virtchnl_filter_action *filter_action =
+				&filter->add_fltr.rule_cfg.action_set.actions[number];
+		filter_action->type = VIRTCHNL_ACTION_PASSTHRU;
+		filter->add_fltr.rule_cfg.action_set.count = ++number;
+	}
+
+	return 0;
+}
+
 static int
 iavf_fdir_parse(struct iavf_adapter *ad,
 		struct iavf_pattern_match_item *array,
@@ -1599,6 +1540,21 @@ iavf_fdir_parse(struct iavf_adapter *ad,
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
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+		.check = iavf_fdir_parse_action_check,
+		.driver_ctx = ad,
+		.rss_queues_contig = true,
+	};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
 	struct iavf_fdir_conf *filter = &vf->fdir.conf;
 	struct iavf_pattern_match_item *item = NULL;
@@ -1610,6 +1566,10 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
 	if (!item)
 		return -rte_errno;
@@ -1619,10 +1579,6 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 	if (ret)
 		goto error;
 
-	ret = iavf_fdir_parse_action(ad, actions, error, filter);
-	if (ret)
-		goto error;
-
 	if (meta)
 		*meta = filter;
 
-- 
2.47.3

