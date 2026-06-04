Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC4ACD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F42C40A82;
	Thu,  4 Jun 2026 18:19:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3C461406BA
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589994; x=1812125994;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zGBg2Af+Dqxr/byXvXh51yiVusWxFM1XolQcDTt5iaw=;
 b=lTvt5Hr+OZDehUdynyi2P6lDFGWhk/7dAXreHMYITt3FB0t7CoFmkIUf
 JgVBcKmI6xOuP5qIzTh/oIasC9c3LFi5JWUfO57QjDcMYA25KdadiJfi4
 GKgim7F/cYmw/KwDbuNovhTkFP6YKUci/8zlvZONC2C2QbzINMclssBgi
 CObM1HHnTKnCOE4cdo6EZK2oEMgXE0CWLAcvtlA14T014KutzfpuRJwcO
 HnS+f2SEmHjDJASe2PEtqSb6knEgodj3QdTTU0JrQxli7y/SYnDxL7uJo
 5N8YDdSlPMNgmEQt+SJlV43FhkKFGiSV9nvWAUtJVBiqbJuJCX9FQXabV w==;
X-CSE-ConnectionGUID: UymPoHjMT7SJhrzYcAbMeQ==
X-CSE-MsgGUID: ePpPYWOPRVWxGsOyvCEk5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045134"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045134"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:54 -0700
X-CSE-ConnectionGUID: Dh2WG28GTHW/MceIePDAMQ==
X-CSE-MsgGUID: eRk605DmTA2e/clZVLZTpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240404058"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 14/27] net/i40e: use common action checks for ethertype
Date: Thu,  4 Jun 2026 17:19:18 +0100
Message-ID: <d21c3a80c31f20ebd33c845d87787a20d7d03d0c.1780589914.git.anatoly.burakov@intel.com>
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
flow actions for ethertype filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

