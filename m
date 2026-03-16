Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E2F4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3617440A4B;
	Mon, 16 Mar 2026 11:53:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id BD09B40684
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658391; x=1805194391;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DTi113G6RFqBMlxtERJbKFzq248WY8FHWQAGt1rZ2lY=;
 b=CFVge3VcFxYwA1mPZoqFw+NYRCKBe64lbkwd2aPbS9CU8dST4vAxrg5r
 a2NSxgFonDMJetRC41O4NSmf+Y/EYllkgJxfIK7lkjezyJjIDFhBsbR+U
 /uPL+y+qATGKyBv+gMd0W6szqdhiRiMts7s73x6TTGPNyMeFStrp9+KAm
 RSJHu/TURaszQZZ5XkYEl52el1q0SaYrRv4Et2TY+dJMR4v873xneq+7E
 IX3Rz5D1Tffvlgoyf+Wh8kMthFCmN3Tz/oueWIAta81w/FtWmmOrvkVbl
 NLe8wL1UTsqzSi0L2Gz1VHrV+Y7dSL0Gl3Wrt+q8+w5Bpv3DSfxc9cMW9 w==;
X-CSE-ConnectionGUID: H7ITXxYxS7yZXA4tH4ntPQ==
X-CSE-MsgGUID: HSuk1DdjTeypoBBywq/fdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237427"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237427"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:10 -0700
X-CSE-ConnectionGUID: WemoCZrNQmG0lhrDWMKB2A==
X-CSE-MsgGUID: zizDkHTMQamQuG4Kgaxpkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826757"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 12/25] net/i40e: use common action checks for ethertype
Date: Mon, 16 Mar 2026 10:52:37 +0000
Message-ID: <b8c87b6ae5b08484a6354d9c06aaa6d02a3f8c5d.1773658290.git.anatoly.burakov@intel.com>
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
flow actions for ethertype filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 56 +++++++++++++-----------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 191bbd41a4..2454d3e5ca 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -1348,43 +1348,35 @@ i40e_flow_parse_ethertype_action(struct rte_eth_dev *dev,
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

