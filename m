Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70419F44863
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:14:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F61F40672;
	Fri, 10 Apr 2026 15:13:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id D9E7040672
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826824; x=1807362824;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RF2yGtMSZrUnpJ1Ba7FsvijHgj/yuj3qkPKqjK0VQOI=;
 b=QydES5MACAtmEVEGG9tZ3ByyxMw1GFd3u02TRo9K8TpmOlxE2u+BJuFv
 rqPiEH9bRB3rNgvkB92fFk7UxcbqUwK2LEaMmC63iJcnaYuQM8zMrUC4/
 Sb2j018WhP1bwVreCep6t5k5kMg9pFCd5XAMAFF4Xs9ug1mX/n7nWCYig
 lYx7/IKkiO0Z4//coRJGcCgEQcCAFqBertNbdtHQvvILZ1mGtsMTA2oBo
 QhY04K6sO6xmgqIyRLlSBHSgNhIgeF1vQxFnLupoTAarfzLtw21pGdPUU
 YdnDPlDuLc5dcKakKnxVbAKGlTMEkYh71tsA9ggY38B6ETaGHOlYIeNMD Q==;
X-CSE-ConnectionGUID: qgMD2w3oREWbGZfCdsPq1A==
X-CSE-MsgGUID: ZGJ39hoTQEu1g/OhYQMJDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736331"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736331"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:44 -0700
X-CSE-ConnectionGUID: nSWS5kHQTW2OdBsS6dovJA==
X-CSE-MsgGUID: V7+0xfrfQS28zA1uU0mTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084663"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 11/29] net/ixgbe: use common checks in security filter
Date: Fri, 10 Apr 2026 14:13:05 +0100
Message-ID: <56ff60dabffd4d7d85ab8a5cf6e1f12b59a7fae6.1775826526.git.anatoly.burakov@intel.com>
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

Use the common attr and action parsing infrastructure in security filter.
As a result, some checks have become more stringent. In particular, group
attribute is now explicitly rejected instead of being ignored.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 62 ++++++++++------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index f6a57af98b..1da66083db 100644
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

