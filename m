Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A381CCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1675D40B9C;
	Mon, 25 May 2026 16:07:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1732240A7F
 for <dev@dpdk.org>; Mon, 25 May 2026 16:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718037; x=1811254037;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cL1diaCkUJC8VLSAsNo+sPkVRj8pFflYTQ18ockJd24=;
 b=m32JXFc8vVy9YjlxFSR7LPkMs5LkKcAYoDmRl9nRcwi/wlV4RZfSmzMT
 K3qPRjwTdlEiCA4HWWIiqYN9sWwynvzCMMyhaAUWePLhLPDpYFNbm633W
 G5DWorbTevW8xyiwb17LOSNrxEAOidSH2LBp85OsEE0jcH+ToUltlvudd
 dfN+fKbEW6JffFnrbpa+kehicJdTJXVqT923hoERJ9/uEln7AnK23Q2CW
 IoIIkIIBYc4HefzxN3HIVKzD39LM6qyZvYg2L01OYmO8VUg92M7/gHU3j
 0vYgf61K1Q9RYvru0H3pyx3EU4F99ylkNqnHz8nYYz0CTbMq3Wt4bPk6o g==;
X-CSE-ConnectionGUID: 4tu4BgNOQpWjXhCcw6fX3w==
X-CSE-MsgGUID: Fm3HnHyNRp+eLVAIdkgDqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392524"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392524"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:07:16 -0700
X-CSE-ConnectionGUID: JYEv7sySRWelnKHJyUuNcw==
X-CSE-MsgGUID: RGzTagZlSsGBZ0GhZHfSpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692395"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:07:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 19/27] net/iavf: use common action checks for hash
Date: Mon, 25 May 2026 15:06:38 +0100
Message-ID: <e7b546417078239f97769208b01dbfd16dabcf08.1779717944.git.anatoly.burakov@intel.com>
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

Use the common flow action checking parsing infrastructure for checking
flow actions for hash filter.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_hash.c | 143 +++++++++++++++--------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 1615ba5ce9..9515094402 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -1429,95 +1429,81 @@ iavf_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 }
 
 static int
-iavf_hash_parse_action(struct iavf_pattern_match_item *match_item,
-		       const struct rte_flow_action actions[],
-		       uint64_t pattern_hint, struct iavf_rss_meta *rss_meta,
-		       struct rte_flow_error *error)
+iavf_hash_parse_rss_type(struct iavf_pattern_match_item *match_item,
+		const struct rte_flow_action_rss *rss,
+		uint64_t pattern_hint, struct iavf_rss_meta *rss_meta,
+		struct rte_flow_error *error)
 {
-	enum rte_flow_action_type action_type;
-	const struct rte_flow_action_rss *rss;
-	const struct rte_flow_action *action;
 	uint64_t rss_type;
 
-	/* Supported action is RSS. */
-	for (action = actions; action->type !=
-		RTE_FLOW_ACTION_TYPE_END; action++) {
-		action_type = action->type;
-		switch (action_type) {
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss = action->conf;
-			rss_type = rss->types;
+	rss_meta->rss_algorithm = rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ ?
+		VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC :
+		VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
 
-			if (rss->func ==
-			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
-				rss_meta->rss_algorithm =
-					VIRTCHNL_RSS_ALG_XOR_ASYMMETRIC;
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"function simple_xor is not supported");
-			} else if (rss->func ==
-				   RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
-				rss_meta->rss_algorithm =
-					VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC;
-			} else {
-				rss_meta->rss_algorithm =
-					VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
-			}
+	/* If pattern type is raw, no need to refine rss type */
+	if (pattern_hint == IAVF_PHINT_RAW)
+		return 0;
 
-			if (rss->level)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a nonzero RSS encapsulation level is not supported");
+	/**
+	 * Check simultaneous use of SRC_ONLY and DST_ONLY
+	 * of the same level.
+	 */
+	rss_type = rte_eth_rss_hf_refine(rss->types);
 
-			if (rss->key_len)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a nonzero RSS key_len is not supported");
+	if (iavf_any_invalid_rss_type(rss->func, rss_type, match_item->input_set_mask)) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"RSS type not supported");
+	}
 
-			if (rss->queue_num)
-				return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION, action,
-					"a non-NULL RSS queue is not supported");
+	memcpy(&rss_meta->proto_hdrs, match_item->meta, sizeof(struct virtchnl_proto_hdrs));
 
-			/* If pattern type is raw, no need to refine rss type */
-			if (pattern_hint == IAVF_PHINT_RAW)
-				break;
+	iavf_refine_proto_hdrs(&rss_meta->proto_hdrs, rss_type, pattern_hint);
 
-			/**
-			 * Check simultaneous use of SRC_ONLY and DST_ONLY
-			 * of the same level.
-			 */
-			rss_type = rte_eth_rss_hf_refine(rss_type);
+	return 0;
+}
 
-			if (iavf_any_invalid_rss_type(rss->func, rss_type,
-					match_item->input_set_mask))
-				return rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_ACTION,
-						action, "RSS type not supported");
+static int
+iavf_hash_parse_action_check(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param __rte_unused,
+		struct rte_flow_error *error)
+{
+	const struct rte_flow_action_rss *rss = actions->actions[0]->conf;
 
-			memcpy(&rss_meta->proto_hdrs, match_item->meta,
-			       sizeof(struct virtchnl_proto_hdrs));
+	/* filter out unsupported RSS functions */
+	switch (rss->func) {
+	case RTE_ETH_HASH_FUNCTION_SIMPLE_XOR:
+	case RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ_SORT:
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"Selected RSS hash function not supported");
+	default:
+		break;
+	}
 
-			iavf_refine_proto_hdrs(&rss_meta->proto_hdrs,
-					       rss_type, pattern_hint);
-			break;
+	if (rss->level != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"Nonzero RSS encapsulation level is not supported");
+	}
 
-		case RTE_FLOW_ACTION_TYPE_END:
-			break;
+	if (rss->key_len != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"RSS key is not supported");
+	}
 
-		default:
-			rte_flow_error_set(error, EINVAL,
-					   RTE_FLOW_ERROR_TYPE_ACTION, action,
-					   "Invalid action.");
-			return -rte_errno;
-		}
+	if (rss->queue_num != 0) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"RSS queue region is not supported");
 	}
 
 	return 0;
 }
 
 static int
-iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
+iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 			       struct iavf_pattern_match_item *array,
 			       uint32_t array_len,
 			       const struct rte_flow_item pattern[],
@@ -1526,6 +1512,17 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 			       void **meta,
 			       struct rte_flow_error *error)
 {
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_RSS,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1,
+		.driver_ctx = ad,
+		.check = iavf_hash_parse_action_check,
+	};
+	const struct rte_flow_action_rss *rss;
 	struct iavf_pattern_match_item *pattern_match_item;
 	struct iavf_rss_meta *rss_meta_ptr;
 	uint64_t phint = IAVF_PHINT_NONE;
@@ -1535,6 +1532,10 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
 		rte_flow_error_set(error, EINVAL,
@@ -1567,8 +1568,8 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 		}
 	}
 
-	ret = iavf_hash_parse_action(pattern_match_item, actions, phint,
-				     rss_meta_ptr, error);
+	rss = parsed_actions.actions[0]->conf;
+	ret = iavf_hash_parse_rss_type(pattern_match_item, rss, phint, rss_meta_ptr, error);
 
 error:
 	if (!ret && meta)
-- 
2.47.3

