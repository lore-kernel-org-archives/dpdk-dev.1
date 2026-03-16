Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9D1F4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8E540BA3;
	Mon, 16 Mar 2026 11:53:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 136DD40B8F
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658401; x=1805194401;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MNk+NE2uMbKVFP0PKYr8BVC9n3eMeQlMX7x3ADmIupg=;
 b=W/DXY9OBctq187e7yekCTm4rkDVfwbhpyQ9ceGRKe1+xY7VlcBVqOvev
 02kuGnPhPL52THnyfjapqFChI0iT9/NjlRdDU2Olcapm4lHI/ot3itZbp
 32tAVYICx226W7RCRT0FD+kzryph0jgyHEBp+6yXgg8FNZ8cN8gMO4m5S
 Yr6iB4kgP3BBEdqMU07iBIfy82Y3EEh4vKY2BikWmy/HDqTfgKBA8AXOz
 mAZTnB14P8DfSvz7bE8QnMWzWLAfZZH/fjK2tpRygfRzBujLCkFPDwomv
 MsQ+/l8sijeS8+cMkRhHMABhCgIC04JGmFKBx6itux61Lb/vtq/UN8Xjr w==;
X-CSE-ConnectionGUID: R55i3bHPRwSyk4vCm6ySMQ==
X-CSE-MsgGUID: zJmgWZI0TJmSOBEi66Wtog==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237443"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:21 -0700
X-CSE-ConnectionGUID: NcMcGZpbQKWiy0oKrhm6OA==
X-CSE-MsgGUID: Wp9+tXpMQNqDRFuKhrc6kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826807"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 22/25] net/ice: use common action checks for hash
Date: Mon, 16 Mar 2026 10:52:47 +0000
Message-ID: <efd15d02a1ee16852ea217cc17a5e5491091e5f5.1773658290.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Use the common flow action checking parsing infrastructure for checking
flow actions for hash filter.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 178 +++++++++++++++++--------------
 1 file changed, 95 insertions(+), 83 deletions(-)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index bd42bc2a4a..40bac92f8a 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1090,94 +1090,92 @@ ice_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
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
 
@@ -1191,15 +1189,29 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
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
@@ -1231,9 +1243,9 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
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

