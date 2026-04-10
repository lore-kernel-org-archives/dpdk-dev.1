Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B3F44866
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6059A4065C;
	Fri, 10 Apr 2026 15:13:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 213AF40697
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826831; x=1807362831;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LYwwjJK3UpYDNuCXQBC9Lo3l+aZ59cp3gwkgWj7c7xI=;
 b=kP5WY2wRk+/gHsWIeUumTypSK8mdcDrdrsZCsZtR8m3E7mc+COR8RWzd
 zPvMR5n/zKcLD8czI36c6f6LmJNkNhaAotv7hnbspdfrGRrrcl4G/U4sj
 0RIU0c8CoaYSqzPviZPdpPIXEnYlAOghnbhfOayBf4wMrLWOne0fuuMgg
 JrBPQWgA7SDFWJ0gs6YVtC7Fe4jJ7pVqoasuq7zySj/c/wlHIa6YvHDcb
 cfXczJYG2X2mb3zYL8gsHYYcxaVfowlgvRTBZYpeRi4QmmoseKqepuL16
 L+Br6brJNUC5cHOLKQOZ5WTfRypD6DvWV/GTvYlRj3RBcHPk/Rl2fJ000 w==;
X-CSE-ConnectionGUID: EpaycMdfSFWaXWefZZ1GXw==
X-CSE-MsgGUID: yLw53GTBQRS9iEJs7n6g4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736349"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736349"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:51 -0700
X-CSE-ConnectionGUID: N6Y+WU9WTtil1z34LkdOSQ==
X-CSE-MsgGUID: oPuvpVy0ThiQaSnArK0XJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084684"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 18/29] net/i40e: use common action checks for tunnel
Date: Fri, 10 Apr 2026 14:13:12 +0100
Message-ID: <4801a303ac4460af64840abd9ec4b6a987628848.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
index c67556c35c..dbc9af4b42 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1101,15 +1101,6 @@ static struct i40e_valid_pattern i40e_supported_patterns[] = {
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
@@ -2526,61 +2517,62 @@ i40e_flow_parse_tunnel_action(struct rte_eth_dev *dev,
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

