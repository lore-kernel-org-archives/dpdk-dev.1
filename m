Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F018CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65B6340B8F;
	Fri, 29 May 2026 17:36:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 77C2F40A6E
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069014; x=1811605014;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JHuc6Ao48txuad4LCqw250XYMb6zPIRixvAOZOhmExs=;
 b=SsVsN5YPfDXDfe43khchaPwGHPvnTDheUjehfMuyMJk+4btRaaBCTN3T
 9dGtkSFbOF/HhXXgqXt81vN1tinsCmwxEqOVR4AbjWvNpRRkdL7sGHSqc
 tyo5y8jh+NZafDmVxD9JvUr/yoC1xhIH5WaUToX1sgIQOKpzOPtsTRkCR
 hFknhcw5TVXlWagY1dhiSafbbd7jXKpnc6igSs8Yr8BV+aMg+CI9kjC5u
 h+a9LATjAR04MmUdQ8mFx5RKMGUggNtQQBIcL7FBAnJYs7GSAcW3sf2i9
 3X4s0xScqTRsvPZXvJTYhU8CLvpTy1F3x/241P5jOaRlEnpKJM6WEpRKE A==;
X-CSE-ConnectionGUID: xpBzE9wGSvGxBavLgEpEvw==
X-CSE-MsgGUID: 6YUOGMm1S6Ws0n0EycuejA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549797"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:53 -0700
X-CSE-ConnectionGUID: WTAjdXl0QzWyzSz/lzeShg==
X-CSE-MsgGUID: OLwwBU1/RHy5Fk3W6pJhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001259"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 14/27] net/i40e: use common action checks for ethertype
Date: Fri, 29 May 2026 16:36:16 +0100
Message-ID: <b3efee0b78515202ec16897649642d27a54f4cb7.1780068634.git.anatoly.burakov@intel.com>
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

