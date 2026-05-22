Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D34CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:15:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C09440A73;
	Fri, 22 May 2026 17:14:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 71D5240674
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462893; x=1810998893;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vskwlxwy7jpAc2xMP3TRqfv6i+dSnCCASIsURb95YhU=;
 b=nhn69NOplOZAcfHMkSffgstNuOrqWGDvmrOyjZeN/eFv7Ivu5TWot8fZ
 vZt0uNw37poUUa8Y8nO/Tm6jmpGA+mzQdeyqNu730d732HGm5AxmuB02N
 kVW1FLjIuAsOJfLsQ6hUz0YtAcZUD0wH3F/y1Qh2S63bnf6HUFW56Qv3O
 m3c0zOXN6e4sg4EAk83jZmyA085KZ+eFaE4DrRLCmm4e8enhYpFexq4A+
 npl6k6oPSFTYasIJ0vVi9DabFRA2VyZGPrQRby9/KNNSDMlMbDXoWXJY7
 gJ0wBLg6BCbgh1PfmqdtQF2D1moOBl/hrFfv/29VXymzH9NK2W5Td7goY A==;
X-CSE-ConnectionGUID: 1XScBYQ3ReuznPyVXFuWkw==
X-CSE-MsgGUID: JH4hMK/fRjWZII8oJhMvYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969160"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969160"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:52 -0700
X-CSE-ConnectionGUID: Ll3CCkHVTdyzd3u/n3IhSA==
X-CSE-MsgGUID: Lvgsi5aGQTKQYrEy4xvfbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213958"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 08/26] net/ixgbe: use common checks in security filter
Date: Fri, 22 May 2026 16:14:17 +0100
Message-ID: <dcce7a9b347c39f7264b9c0580f4f3fbac555f55.1779462699.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779462698.git.anatoly.burakov@intel.com>
 <cover.1779462698.git.anatoly.burakov@intel.com>
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
index 9b879f718b..cb7dde5a44 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -539,7 +539,16 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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
 
@@ -551,45 +560,18 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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
@@ -629,7 +611,7 @@ ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr
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

