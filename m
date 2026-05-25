Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E18CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88F9740DD7;
	Mon, 25 May 2026 16:07:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4E66640B9E
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718042; x=1811254042;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=poupF/vQJoDCd7aAw4hcrrreWu5ODV60X95B25X4BcI=;
 b=bhe77FQLbRUHgyAg4+ei4wImMA2eBFCmysLeuSXEb2SnFa3ult6uB4PG
 eHJjbSF1Q4OJ1Y+SLR4hArw/6EVFnfPBMN+VoYiGmCbSivh/IROKZCMgq
 3Yo7M0H0K/XN8RogH3BdPGHYwjlD5T/FXG1EGC2vr1Yop3uUf8YHHfIlv
 RY+gn96Ze0CAaNHmXrpUzDJPdFSDcwpEdvD39na2nmI2CW5TmNAZY1b39
 E7JswCTkI/Unknr7ORd82fY5eY+4VX3OOu5GlEr1NrXlyg01o1tRINrFm
 hCr8nId86LOL5u4ZvKeXNprj6eM24wbIMBxagMetxK/6tM/wtVN2wTyA3 Q==;
X-CSE-ConnectionGUID: ANpWzm/9Sv+fTW6T8KELzg==
X-CSE-MsgGUID: IIf17f5MQpmjy6WDPgERYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392537"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392537"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:22 -0700
X-CSE-ConnectionGUID: 08NSHxzNRYuuFRa2kSh8lw==
X-CSE-MsgGUID: u4Bc7lNgSvGpu9DWjomQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692421"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 24/27] net/ice: use common action checks for hash
Date: Mon, 25 May 2026 15:06:43 +0100
Message-ID: <a2e422ad0f459ed4828ac61f1440950b43eb2306.1779717944.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Use the common flow action checking parsing infrastructure for checking
flow actions for hash filter.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 178 +++++++++++++++++--------------
 1 file changed, 95 insertions(+), 83 deletions(-)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 9a56d7000c..7a9a4f1a04 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1092,94 +1092,92 @@ ice_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 }
 
 static int
-ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
-		const struct rte_flow_action actions[],
+ice_hash_parse_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param __rte_unused,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss;
+
+	rss = actions->actions[0]->conf;
+
+	switch (rss->func) {
+	case RTE_ETH_HASH_FUNCTION_DEFAULT:
+	case RTE_ETH_HASH_FUNCTION_TOEPLITZ:
+	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
+	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ:
+		break;
+	default:
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Selected RSS hash function not supported");
+	}
+
+	if (rss->level)
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"a nonzero RSS encapsulation level is not supported");
+
+	if (rss->key_len)
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"a nonzero RSS key_len is not supported");
+
+	if (rss->queue)
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"a non-NULL RSS queue is not supported");
+
+	return 0;
+}
+
+static int
+ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
+		const struct rte_flow_action_rss *rss,
 		uint64_t pattern_hint, struct ice_rss_meta *rss_meta,
 		struct rte_flow_error *error)
 {
 	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
-	enum rte_flow_action_type action_type;
-	const struct rte_flow_action_rss *rss;
-	const struct rte_flow_action *action;
 	uint64_t rss_type;
+	bool symm = false;
 
-	/* Supported action is RSS. */
-	for (action = actions; action->type !=
-		RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss = action->conf;
-			rss_type = rss->types;
-
-			/* Check hash function and save it to rss_meta. */
-			if (pattern_match_item->pattern_list !=
-			    pattern_empty && rss->func ==
-			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"Not supported flow");
-			} else if (rss->func ==
-				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
-				rss_meta->hash_function =
-				RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
-				return 0;
-			} else if (rss->func ==
-				   RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
-				rss_meta->hash_function =
-				RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
-				if (pattern_hint == ICE_PHINT_RAW)
-					rss_meta->raw.symm = true;
-				else
-					cfg->symm = true;
-			}
-
-			if (rss->level)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a nonzero RSS encapsulation level is not supported");
-
-			if (rss->key_len)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a nonzero RSS key_len is not supported");
-
-			if (rss->queue)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a non-NULL RSS queue is not supported");
-
-			/* If pattern type is raw, no need to refine rss type */
-			if (pattern_hint == ICE_PHINT_RAW)
-				break;
-
-			/**
-			 * Check simultaneous use of SRC_ONLY and DST_ONLY
-			 * of the same level.
-			 */
-			rss_type = rte_eth_rss_hf_refine(rss_type);
-
-			if (ice_any_invalid_rss_type(rss->func, rss_type,
-					pattern_match_item->input_set_mask_o))
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					action, "RSS type not supported");
-
-			rss_meta->cfg = *cfg;
-			ice_refine_hash_cfg(&rss_meta->cfg,
-					    rss_type, pattern_hint);
-			break;
-		case RTE_FLOW_ACTION_TYPE_END:
-			break;
-
-		default:
-			rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"Invalid action.");
-			return -rte_errno;
+	if (rss->func == RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
+		if (pattern_match_item->pattern_list != pattern_empty) {
+			return rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+					"XOR hash function is only supported for empty pattern");
 		}
+		rss_meta->hash_function = RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
+		return 0;
 	}
 
+	if (rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
+		rss_meta->hash_function = RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
+		symm = true;
+	}
+
+	/* If pattern type is raw, no need to refine rss type */
+	if (pattern_hint == ICE_PHINT_RAW) {
+		rss_meta->raw.symm = symm;
+		return 0;
+	}
+	cfg->symm = symm;
+
+	/**
+	 * Check simultaneous use of SRC_ONLY and DST_ONLY
+	 * of the same level.
+	 */
+	rss_type = rte_eth_rss_hf_refine(rss->types);
+
+	if (ice_any_invalid_rss_type(rss->func, rss_type,
+				pattern_match_item->input_set_mask_o))
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+				rss, "RSS type not supported");
+
+	rss_meta->cfg = *cfg;
+	ice_refine_hash_cfg(&rss_meta->cfg,
+			    rss_type, pattern_hint);
+
 	return 0;
 }
 
@@ -1193,15 +1191,29 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 			void **meta,
 			struct rte_flow_error *error)
 {
-	int ret = 0;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.check = ice_hash_parse_action_check,
+	};
+	const struct rte_flow_action_rss *rss;
 	struct ice_pattern_match_item *pattern_match_item;
 	struct ice_rss_meta *rss_meta_ptr;
 	uint64_t phint = ICE_PHINT_NONE;
+	int ret = 0;
 
 	ret = ci_flow_check_attr(attr, NULL, error);
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
 		rte_flow_error_set(error, EINVAL,
@@ -1233,9 +1245,9 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 		}
 	}
 
-	/* Check rss action. */
-	ret = ice_hash_parse_action(pattern_match_item, actions, phint,
-				    rss_meta_ptr, error);
+	rss = parsed_actions.actions[0]->conf;
+	ret = ice_hash_parse_rss_action(pattern_match_item, rss, phint,
+				rss_meta_ptr, error);
 
 error:
 	if (!ret && meta)
-- 
2.47.3

