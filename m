Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDC7CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD942406BA;
	Fri, 29 May 2026 17:36:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 308F64068A
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069007; x=1811605007;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vskwlxwy7jpAc2xMP3TRqfv6i+dSnCCASIsURb95YhU=;
 b=cSY0aGA6Wf+spq49rKStXiXHB1NzqMrj2V4Vde22CmY6CrXFkFxeMI6F
 nzowlhcbUBSagsmi1kiag3De4aeAEHDBd2MGk6J58X+W4VU9Mc+FPFEHS
 G8QGF9Vt2McfXJjoEZwCgwazpbbl/q/7/yw0EGYyjEEZIF1i4DMQli2zy
 b5ty87kFYDevvS2S8TI62dcWyshGdJmf1hsA33DbwmLLeOrtC0wbCGALl
 QEskpxtOOcwwpogulKUrYbUeM3gV5bDx2XKHzj5Jbh8CAfkyl/1w81HW+
 Msx+wZlkXAmacp30vlmx1z84xtBMoHZPcEwxC9h3RdAS5/Si3p6MOPR1a A==;
X-CSE-ConnectionGUID: WZv/IJcyQ3iEPpvHTko7mg==
X-CSE-MsgGUID: BlrUFNlDRhqTSGqcT0J+Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549785"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549785"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:47 -0700
X-CSE-ConnectionGUID: +CBIPuBBQcysLUSSUgdBtw==
X-CSE-MsgGUID: JFznW4NRRVajE3CtE2jvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001233"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 09/27] net/ixgbe: use common checks in security filter
Date: Fri, 29 May 2026 16:36:11 +0100
Message-ID: <5a75ce65430f7d00107fe61265be8ff495049a67.1780068633.git.anatoly.burakov@intel.com>
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

