Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F493CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3577E402F2;
	Mon, 25 May 2026 16:07:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 636B84066F
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718033; x=1811254033;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6maOZQwPGhXKK+gRSj7po3fsoOM3ygJQMNgMYi/cDgM=;
 b=Iaue3APdQ0ffSiybyBbU46qywMmEzcOs7myXwWxb4sZwdNUVlGAOqPEL
 7Zb5u7dhc4cOeP2f6EmtQj0eix+AW139YSQzqwUGOWkFoDs2HKxTiidnI
 TCtqQ0sY7PxT33/FYisSH9KajKr7lC3+NXaxtSBkdAtOgLVazM7R1+lWr
 ueJqkd0py5PenMD4cW8awYOpqnOc8gMia44/CQXj9xjkoEgBF1rweMDCk
 DbKNb4+8CeVK9syrfB1sE/qvU/v0jVC0ziv2wh6/xWgm9hfhp7c7pVPBr
 yWUpd32iEjklyT2v0CrM2T171bevslykOXaP1FMsrQClAQIr5CiopnTLC A==;
X-CSE-ConnectionGUID: 1rYSZfGHTJ20TMAVRn3GyA==
X-CSE-MsgGUID: sVQAtCWZTayXvS3XQpiybw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392516"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392516"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:13 -0700
X-CSE-ConnectionGUID: 3XqdpXwiRP6Vod2MwHmWug==
X-CSE-MsgGUID: pG2g53HsRzGDBQNmh7GRAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692383"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 16/27] net/i40e: use common action checks for tunnel
Date: Mon, 25 May 2026 15:06:35 +0100
Message-ID: <34a59a51794b275683972cdeda233ea1e845352d.1779717944.git.anatoly.burakov@intel.com>
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
flow actions for flow director tunnel filter. As a result, more stringent
checks are performed against parametersm specifically the following:

- reject NULL conf for VF action (instead of attempt at NULL dereference)
- second action was expected to be QUEUE but if it wasn't it was ignored

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 104 +++++++++++++----------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 1ca70ff71c..1051c99fba 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1107,15 +1107,6 @@ static struct i40e_valid_pattern i40e_supported_patterns[] = {
 	{ pattern_fdir_ipv6_sctp, i40e_flow_parse_l4_cloud_filter },
 };
 
-#define NEXT_ITEM_OF_ACTION(act, actions, index)                        \
-	do {                                                            \
-		act = actions + index;                                  \
-		while (act->type == RTE_FLOW_ACTION_TYPE_VOID) {        \
-			index++;                                        \
-			act = actions + index;                          \
-		}                                                       \
-	} while (0)
-
 /* Find the first VOID or non-VOID item pointer */
 static const struct rte_flow_item *
 i40e_find_first_item(const struct rte_flow_item *item, bool is_void)
@@ -2629,61 +2620,62 @@ i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
 			      struct i40e_tunnel_filter_conf *filter)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	const struct rte_flow_action *act;
 	const struct rte_flow_action_queue *act_q;
-	const struct rte_flow_action_vf *act_vf;
-	uint32_t index = 0;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param ac_param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_PF,
+			RTE_FLOW_ACTION_TYPE_VF,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 2,
+	};
+	const struct rte_flow_action *first, *second;
+	int ret;
 
-	/* Check if the first non-void action is PF or VF. */
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type != RTE_FLOW_ACTION_TYPE_PF &&
-	    act->type != RTE_FLOW_ACTION_TYPE_VF) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Not supported action.");
-		return -rte_errno;
-	}
+	ret = ci_flow_check_actions(actions, &ac_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+	first = parsed_actions.actions[0];
+	/* can be NULL */
+	second = parsed_actions.actions[1];
 
-	if (act->type == RTE_FLOW_ACTION_TYPE_VF) {
-		act_vf = act->conf;
-		filter->vf_id = act_vf->id;
+	/* first action must be PF or VF */
+	if (first->type == RTE_FLOW_ACTION_TYPE_VF) {
+		const struct rte_flow_action_vf *vf = first->conf;
+		if (vf->id >= pf->vf_num) {
+			rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ACTION, first,
+					"Invalid VF ID for tunnel filter");
+			return -rte_errno;
+		}
+		filter->vf_id = vf->id;
 		filter->is_to_vf = 1;
-		if (filter->vf_id >= pf->vf_num) {
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Invalid VF ID for tunnel filter");
-			return -rte_errno;
-		}
+	} else if (first->type != RTE_FLOW_ACTION_TYPE_PF) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION, first,
+					  "Unsupported action");
 	}
 
-	/* Check if the next non-void item is QUEUE */
-	index++;
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		act_q = act->conf;
-		filter->queue_id = act_q->index;
-		if ((!filter->is_to_vf) &&
-		    (filter->queue_id >= pf->dev_data->nb_rx_queues)) {
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Invalid queue ID for tunnel filter");
-			return -rte_errno;
-		} else if (filter->is_to_vf &&
-			   (filter->queue_id >= pf->vf_nb_qps)) {
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Invalid queue ID for tunnel filter");
-			return -rte_errno;
-		}
-	}
+	/* check if second action is QUEUE */
+	if (second == NULL)
+		return 0;
 
-	/* Check if the next non-void item is END */
-	index++;
-	NEXT_ITEM_OF_ACTION(act, actions, index);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-				   act, "Not supported action.");
-		return -rte_errno;
+	act_q = second->conf;
+	/* check queue ID for PF flow */
+	if (!filter->is_to_vf && act_q->index >= pf->dev_data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
+	}
+	/* check queue ID for VF flow */
+	if (filter->is_to_vf && act_q->index >= pf->vf_nb_qps) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, act_q,
+				"Invalid queue ID for tunnel filter");
 	}
+	filter->queue_id = act_q->index;
 
 	return 0;
 }
-- 
2.47.3

