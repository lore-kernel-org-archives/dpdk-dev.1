Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E6E81BCD
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F153440667;
	Mon,  9 Feb 2026 15:14:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 73DE040647
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646440; x=1802182440;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UF59Kxg5/6jSn/bK3yNOeEMHPAu3N5Ik2j7PT4I3/vA=;
 b=fv0Ce/TmOTtOorhM76o9OiV+3yVjwS8e4BZADmQAMA5lDIWLwHhYWNB3
 hQU5if0XQbWSKGIFoWweqWJY4jozj0CwkmwmyjIkTdFKCj4LTm0k772/M
 PF5wgLLns+7LpwsmDQNTNQWCgMofbcoSJFHvIx+eDLkvbiW9L1rTEgWgx
 aWh2d4K/hpAxFKsz8iIaBcIvr/h6MMaz7FbaZfk+1fX6JvT9bHX35HJM6
 p4t3WRczami7KJIE+OYQAoy1kgIAb1/uzxAbDYf5p+CBcU9lNyMjxfvZW
 Q5uusisezY07nXGL0N+t/pkk2qDi85TOR8yYmiz6SekxMnh4lSdQMK9Qe A==;
X-CSE-ConnectionGUID: Wk74Q7qCRQaZMotk4hZUKA==
X-CSE-MsgGUID: sdsy/6L4TXabn8aUgQ9yYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658482"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658482"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:13:59 -0800
X-CSE-ConnectionGUID: ZsadoMHNTlGnRWj7LNBUhw==
X-CSE-MsgGUID: 0wHgdZsBRm2oj5g8z5sI5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242215969"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:13:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 03/12] net/ixgbe: split security and ntuple filters
Date: Mon,  9 Feb 2026 14:13:39 +0000
Message-ID: <6715c4e747937fcfcbc4cd7cd147c24ccd57fbf2.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
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

These filters are mashed together even though they almost do not share any
code at all between each other. Separate security filter from ntuple filter
and parse it separately.

While we're at it, we're making checks more stringent (such as checking for
NULL conf), and more type safe.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 136 ++++++++++++++++++---------
 1 file changed, 91 insertions(+), 45 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index e7521a4b1f..fee5d7b901 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -214,41 +214,6 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
 	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
 
-	/**
-	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
-	 */
-	act = next_no_void_action(actions, NULL);
-	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
-		const void *conf = act->conf;
-		/* check if the next not void item is END */
-		act = next_no_void_action(actions, act);
-		if (act->type != RTE_FLOW_ACTION_TYPE_END) {
-			memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION,
-				act, "Not supported action.");
-			return -rte_errno;
-		}
-
-		/* get the IP pattern*/
-		item = next_no_void_pattern(pattern, NULL);
-		while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-				item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-			if (item->last ||
-					item->type == RTE_FLOW_ITEM_TYPE_END) {
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "IP pattern missing.");
-				return -rte_errno;
-			}
-			item = next_no_void_pattern(pattern, item);
-		}
-
-		filter->proto = IPPROTO_ESP;
-		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
-					item->type == RTE_FLOW_ITEM_TYPE_IPV6);
-	}
-
 	/* the first not void item can be MAC or IPv4 */
 	item = next_no_void_pattern(pattern, NULL);
 
@@ -607,6 +572,81 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	return 0;
 }
 
+static int __rte_unused
+ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	const struct rte_flow_action_security *security;
+	const struct rte_flow_item *item;
+	const struct rte_flow_action *act;
+
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	if (pattern == NULL) {
+		rte_flow_error_set(error,
+			EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
+			NULL, "NULL pattern.");
+		return -rte_errno;
+	}
+	if (actions == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
+				   NULL, "NULL action.");
+		return -rte_errno;
+	}
+	if (attr == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ATTR,
+				   NULL, "NULL attribute.");
+		return -rte_errno;
+	}
+
+	/* check if next non-void action is security */
+	act = next_no_void_action(actions, NULL);
+	if (act->type != RTE_FLOW_ACTION_TYPE_SECURITY) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION,
+				act, "Not supported action.");
+	}
+	security = act->conf;
+	if (security == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, act,
+				"NULL security action config.");
+	}
+	/* check if the next not void item is END */
+	act = next_no_void_action(actions, act);
+	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION,
+				act, "Not supported action.");
+	}
+
+	/* get the IP pattern*/
+	item = next_no_void_pattern(pattern, NULL);
+	while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
+			item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
+		if (item->last || item->type == RTE_FLOW_ITEM_TYPE_END) {
+			rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "IP pattern missing.");
+			return -rte_errno;
+		}
+		item = next_no_void_pattern(pattern, item);
+	}
+
+	return ixgbe_crypto_add_ingress_sa_from_flow(security->security_session,
+			item->spec, item->type == RTE_FLOW_ITEM_TYPE_IPV6);
+}
+
 /* a specific function for ixgbe because the flags is specific */
 static int
 ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
@@ -628,10 +668,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	/* ESP flow not really a flow*/
-	if (filter->proto == IPPROTO_ESP)
-		return 0;
-
 	/* Ixgbe doesn't support tcp flags. */
 	if (filter->flags & RTE_NTUPLE_FLAGS_TCP_FLAG) {
 		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
@@ -3066,14 +3102,17 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
 				ixgbe_flow_mem_ptr, entries);
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	/* ESP flow not really a flow*/
-	if (ntuple_filter.proto == IPPROTO_ESP)
+	/**
+	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
+	 */
+	ret = ixgbe_parse_security_filter(dev, attr, pattern, actions, error);
+	if (!ret)
 		return flow;
 
+	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
+	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
+			actions, &ntuple_filter, error);
+
 	if (!ret) {
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
 		if (!ret) {
@@ -3297,6 +3336,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
+	/**
+	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
+	 */
+	ret = ixgbe_parse_security_filter(dev, attr, pattern, actions, error);
+	if (!ret)
+		return 0;
+
 	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
 	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
 				actions, &ntuple_filter, error);
-- 
2.47.3

