Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F24F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FE3A4064A;
	Tue, 24 Feb 2026 16:14:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 72873402DF
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946083; x=1803482083;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KcM5O01RH64YTOgiH/Znx568OUdb57pKh2gTsRLwiwM=;
 b=YuPLeSrtgz7GwpDhd9TNdzvfuU95V34svaU/FNH54/u2lq2dcRtoHjoD
 ehLLES+TAKcOphL2KAGzDaQ4GqIZXhcBZ+huiuzr2G8YTbJWZQQXr25sh
 6bi8PXXPRdRWL1SzZ+y86qNezsw27npk8ti8gRMTCesKdKvTWfjeaBC7M
 MQYq0gxb4ghZ06jYf13SRpBuSfMycqgY7t1EkIG5RaG+zBNhxf7Q1N1bj
 pCY+xMxNGt2IVgvSKNvqiaFZyrj+l1FwAyceyin2kyB1PT+WCFS7HRsUn
 6f1soREc7InwXxGqqJBO0KLQ6Tf8WBjMAtKvE+plkXFgqfwe6Oz7HJRsv g==;
X-CSE-ConnectionGUID: MxZgRLoDTpuWAPd0wIE4RQ==
X-CSE-MsgGUID: 54z4vH7URnCjsewch9jvNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056239"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:43 -0800
X-CSE-ConnectionGUID: Lh0j5ca1RBehN6cWcv5JLg==
X-CSE-MsgGUID: WxOHV0IuQAmgTIVLoERxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526074"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 03/26] net/ixgbe: split security and ntuple filters
Date: Tue, 24 Feb 2026 15:14:08 +0000
Message-ID: <78baf5c4604169fab4883db42bf0c88f5cf832e2.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 202 ++++++++++++++++-----------
 1 file changed, 122 insertions(+), 80 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 491e8bccc5..01cd4f9bde 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -214,74 +214,6 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
 	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
 
-	/**
-	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
-	 */
-	act = next_no_void_action(actions, NULL);
-	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
-		const void *conf = act->conf;
-		const struct rte_flow_action_security *sec_act;
-		struct rte_security_session *session;
-		struct ip_spec spec;
-
-		if (conf == NULL) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
-				act, "NULL security conf.");
-			return -rte_errno;
-		}
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
-		if (item->spec == NULL) {
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
-					"NULL IP pattern.");
-			return -rte_errno;
-		}
-
-		filter->proto = IPPROTO_ESP;
-		sec_act = (const struct rte_flow_action_security *)conf;
-		spec.is_ipv6 = item->type == RTE_FLOW_ITEM_TYPE_IPV6;
-		if (spec.is_ipv6) {
-			const struct rte_flow_item_ipv6 *ipv6 = item->spec;
-			spec.spec.ipv6 = *ipv6;
-		} else {
-			const struct rte_flow_item_ipv4 *ipv4 = item->spec;
-			spec.spec.ipv4 = *ipv4;
-		}
-
-		/*
-		 * we get pointer to security session from security action,
-		 * which is const. however, we do need to act on the session, so
-		 * either we do some kind of pointer based lookup to get session
-		 * pointer internally (which quickly gets unwieldy for lots of
-		 * flows case), or we simply cast away constness.
-		 */
-		session = RTE_CAST_PTR(struct rte_security_session *, sec_act->security_session);
-		return ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
-	}
-
 	/* the first not void item can be MAC or IPv4 */
 	item = next_no_void_pattern(pattern, NULL);
 
@@ -640,6 +572,112 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	return 0;
 }
 
+static int
+ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
+		struct rte_flow_error *error)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	const struct rte_flow_action_security *security;
+	struct rte_security_session *session;
+	const struct rte_flow_item *item;
+	const struct rte_flow_action *act;
+	struct ip_spec spec;
+	int ret;
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
+	if (item->spec == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_SPEC, item,
+				"NULL IP pattern.");
+		return -rte_errno;
+	}
+	spec.is_ipv6 = item->type == RTE_FLOW_ITEM_TYPE_IPV6;
+	if (spec.is_ipv6) {
+		const struct rte_flow_item_ipv6 *ipv6 = item->spec;
+		spec.spec.ipv6 = *ipv6;
+	} else {
+		const struct rte_flow_item_ipv4 *ipv4 = item->spec;
+		spec.spec.ipv4 = *ipv4;
+	}
+
+	/*
+	 * we get pointer to security session from security action, which is
+	 * const. however, we do need to act on the session, so either we do
+	 * some kind of pointer based lookup to get session pointer internally
+	 * (which quickly gets unwieldy for lots of flows case), or we simply
+	 * cast away constness. the latter path was chosen.
+	 */
+	session = RTE_CAST_PTR(struct rte_security_session *, security->security_session);
+	ret = ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
+	if (ret) {
+		rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_ACTION, act,
+				"Failed to add security session.");
+		return -rte_errno;
+	}
+	return 0;
+}
+
 /* a specific function for ixgbe because the flags is specific */
 static int
 ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
@@ -661,10 +699,6 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	if (ret)
 		return ret;
 
-	/* ESP flow not really a flow*/
-	if (filter->proto == IPPROTO_ESP)
-		return 0;
-
 	/* Ixgbe doesn't support tcp flags. */
 	if (filter->flags & RTE_NTUPLE_FLAGS_TCP_FLAG) {
 		memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
@@ -3099,18 +3133,19 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&ixgbe_flow_list,
 				ixgbe_flow_mem_ptr, entries);
 
-	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
-	ret = ixgbe_parse_ntuple_filter(dev, attr, pattern,
-			actions, &ntuple_filter, error);
-
-	/* ESP flow not really a flow*/
-	if (ntuple_filter.proto == IPPROTO_ESP) {
-		if (ret != 0)
-			goto out;
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
@@ -3334,6 +3369,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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

