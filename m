Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5CDE9E30B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26AF140676;
	Wed, 11 Feb 2026 14:53:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 55EF84065C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818016; x=1802354016;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4ow2pUkdtoOfNhFRM26ITSEf8QgsjA9Q5OHEhwMfgsY=;
 b=EmBMxsh5uObVbeEb2OwQ48rdLS9AWgkivvGQKlLQyTkMO4iQRAgMG+sm
 39XOgVRYGUQjbmTCAtmGpOl1OY2bZcKcgwTx0dtg1YGsEpxqjzgPuAY1I
 1OaEFmngOuOydXwA2bultFpavMLEiQCRx+DRuurEyrHug46PCwUj/x6Uw
 xkTKBZPDle8cE/0/egYRyzhBrTzNgY3yyy2SzFmBLQMUEZu2vG+zmCW6+
 jbmtOG91i/TxPqdtApiQCtw2nHNgyZkqkb4mVXhmg4yZ+DYScml06/Ks5
 MWreGzfhCJMd45Ka+AvYOMq/e4EWHQtPCGJZN3HA3kzJjy/gxI1b9mJ24 w==;
X-CSE-ConnectionGUID: 8zhZJ0IXQFm/CiVUn82NEQ==
X-CSE-MsgGUID: MOIrIltUS7SU/V7l0vj90Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808228"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:36 -0800
X-CSE-ConnectionGUID: +J+PuyaTQ+uN9TKLTdx7Tw==
X-CSE-MsgGUID: /DfIRWmJRly7PixJSbvjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359562"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 03/27] net/ixgbe: split security and ntuple filters
Date: Wed, 11 Feb 2026 13:52:45 +0000
Message-ID: <1d6d12f5387fb70df51a4a9bc38abced0e915548.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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
index c17c6c4bf6..cd8d46019f 100644
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
 
+static int
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
@@ -3066,16 +3102,19 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
 				ixgbe_flow_mem_ptr, entries);
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	/* ESP flow not really a flow*/
-	if (ntuple_filter.proto == IPPROTO_ESP) {
+	/**
+	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
+	 */
+	ret = ixgbe_parse_security_filter(dev, attr, pattern, actions, error);
+	if (!ret) {
 		flow->is_security = true;
 		return flow;
 	}
 
+	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
+	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
+			actions, &ntuple_filter, error);
+
 	if (!ret) {
 		ret = ixgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
 		if (!ret) {
@@ -3299,6 +3338,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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

