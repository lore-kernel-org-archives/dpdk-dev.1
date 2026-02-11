Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB7CE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E72A540A67;
	Wed, 11 Feb 2026 15:21:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id BD7FB40668
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819666; x=1802355666;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XiWQffzlQkZFqs53wBlcaW2MPMx2FTPujbCkieu4oS4=;
 b=CHiosg3ZmVRnm4lGdjf6p+OF5Y5Go0EgsUsfwKWkG09U5td5v34ejalw
 dgyDePan0zBgwNvM5PJdMRF0i4wogxM0RyYfLfvIr5eLTtas+Ls1ku8E6
 EFA5ti/BjqoYj/0AIO4zcjgE5bSPgoIFIXtZ+sQZSxVtWgNdnKmsUQoiz
 tPk1ZZi9cfL8ElffGvnw6MahXdEyvAyS247Vmdv0llW+t0yKbD1cqfnvA
 lS2cqj0dMeZc/n6XbiHGNvJxtP4NJiQzQUDdTz5/XOjvK733lhL/ntgR7
 ZYczVQiUBzgLyIkvgHzRRBaqDj5RQ2e1XJOewYo3wsEDLgPMI/0LJiEll w==;
X-CSE-ConnectionGUID: fGiiFnZMTYGgdSxP5/zHmA==
X-CSE-MsgGUID: 5fWkpBn6SI2HBf+7P4ZBYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866739"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866739"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:05 -0800
X-CSE-ConnectionGUID: ugEIsYPsRnSscqCLUth6Mw==
X-CSE-MsgGUID: QsgKhG+eTrWghuSlPkwc4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569137"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 07/25] net/ixgbe: use common checks in security filter
Date: Wed, 11 Feb 2026 14:20:24 +0000
Message-ID: <b6656c8a2d47223db576d9516c273d348d0b90d9.1770819434.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in security filter.
As a result, some checks have become more stringent. In particular, group
attribute is now explicitly rejected instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 61 ++++++++++------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 46161e6146..38a8002611 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -556,7 +556,17 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	const struct rte_flow_action_security *security;
 	const struct rte_flow_item *item;
-	const struct rte_flow_action *act;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* only security is allowed here */
+			RTE_FLOW_ACTION_TYPE_SECURITY,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+	};
+	const struct rte_flow_action *action;
+	int ret;
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 			hw->mac.type != ixgbe_mac_X540 &&
@@ -566,45 +576,18 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 			hw->mac.type != ixgbe_mac_E610)
 		return -ENOTSUP;
 
-	if (pattern == NULL) {
-		rte_flow_error_set(error,
-			EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
-			NULL, "NULL pattern.");
-		return -rte_errno;
-	}
-	if (actions == NULL) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
-				   NULL, "NULL action.");
-		return -rte_errno;
-	}
-	if (attr == NULL) {
-		rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_ATTR,
-				   NULL, "NULL attribute.");
-		return -rte_errno;
-	}
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
 
-	/* check if next non-void action is security */
-	act = next_no_void_action(actions, NULL);
-	if (act->type != RTE_FLOW_ACTION_TYPE_SECURITY) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-	}
-	security = act->conf;
-	if (security == NULL) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
-				"NULL security action config.");
-	}
-	/* check if the next not void item is END */
-	act = next_no_void_action(actions, act);
-	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-	}
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	action = parsed_actions.actions[0];
+	security = action->conf;
 
 	/* get the IP pattern*/
 	item = next_no_void_pattern(pattern, NULL);
-- 
2.47.3

