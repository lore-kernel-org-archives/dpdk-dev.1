Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94914F4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00D754066C;
	Mon, 16 Mar 2026 11:53:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 82D324064C
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658386; x=1805194386;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=65apxAk0gdcjYD8AYUbOVdfugABa1KiANUz7yDzEH4Y=;
 b=LIwaCquSWSqb0vCN4O23XtWf7IFrv4kSlMjHMWpQ6oTGYoTAVMmMmH+l
 j59Pf00XkU1Kyo6HG1SEKiErVQvU10mwcM78fXIbjtJV6dkfBTAiFN8wi
 V8LkRX76bgu2QF53b9UpEYWTdARkh//I4aDRMBGrt3k/2F3eUQuozcX3Z
 Nw8sLcRvjUl+up0xKQngtjLxGEeonZAjkIAaJkWtL6VdUY7G0CjTuRLES
 eE5dGmfEM31cip42CmU9cTMKeKjJF2YuKqAHdRJCthUIQBdkghyjNbTtt
 z+cspIw+ChLIVaG1MdrcgFq6ZEli5eWcOh66+Hyvzt+Yu07LM1XS8Qdmv w==;
X-CSE-ConnectionGUID: 5XEwbNRFTBi2E9wx6QLkZA==
X-CSE-MsgGUID: X05Oj9OERHGTIjoclqajMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237416"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237416"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:05 -0700
X-CSE-ConnectionGUID: zhfbJuPTSNSsQfbDOA7CCA==
X-CSE-MsgGUID: +epfprMkTM+IG2M/kizsqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826728"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 07/25] net/ixgbe: use common checks in security filter
Date: Mon, 16 Mar 2026 10:52:32 +0000
Message-ID: <52cb21125ec78d59406bd62985d0f5dc099772b3.1773658289.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in security filter.
As a result, some checks have become more stringent. In particular, group
attribute is now explicitly rejected instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 62 ++++++++++------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 20d163bce0..9dc2ad5e56 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -557,7 +557,16 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	const struct rte_flow_action_security *security;
 	struct rte_security_session *session;
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
 	struct ip_spec spec;
 	int ret;
 
@@ -569,45 +578,18 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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
@@ -647,7 +629,7 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
 	ret = ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
-				RTE_FLOW_ERROR_TYPE_ACTION, act,
+				RTE_FLOW_ERROR_TYPE_ACTION, action,
 				"Failed to add security session.");
 		return -rte_errno;
 	}
-- 
2.47.3

