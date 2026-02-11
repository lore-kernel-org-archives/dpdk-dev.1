Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55541E9E30D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05FA440B92;
	Wed, 11 Feb 2026 15:21:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3C00540B8D
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819682; x=1802355682;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CC69/C3aIivNEypbVtXYaz6Xg7PJek2QJ34q7ULRXzY=;
 b=h6Q36W5xDK18T5yVGtfMPUaqZ16fveOlkCNdEMKj0lCuFgGU09yzMGnj
 r5PBMRK54u2ZvXJOk8WMdD5m5Npci2uLzr6gz+bM0zZBm45GSgStDbCLz
 0e6+VDUWsMK7MF1viJfyoIo95tkliAfZCkRvAqGwU0GhK+KLjY7Z22mze
 TBRLRvwJ/EQ276CyoWbO8HcFi4B3d90atts2PiWBaCcDcOzb4qqtJV5q8
 hH7CAYcfnvCy+o4oP9BEDvgnG9s3aBdI0cF9P9g+32dpTvMYD2+CwJhgx
 CUuHFc5dg0dNke/2+5vbE3ZRCHVdS5kbC5DzQELUcTeet1WW9fiiYtqVM A==;
X-CSE-ConnectionGUID: nlVOomGLQta2zeJDrLq44Q==
X-CSE-MsgGUID: Ic2YqxXpSBCntF+3SKqxwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866774"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:20 -0800
X-CSE-ConnectionGUID: BBmib+s2TRaA2srHVaNptQ==
X-CSE-MsgGUID: jCRXmwsZTv+9OY30UCJXOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569204"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 17/25] net/iavf: use common action checks for hash
Date: Wed, 11 Feb 2026 14:20:34 +0000
Message-ID: <ac5c764a74e3914d6daef8ca5c5bb5594021132c.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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
index b569450b82..d8c9e900e8 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -1428,95 +1428,81 @@ iavf_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 }
 
 static int
-iavf_hash_parse_action(struct iavf_pattern_match_item *match_item,
-		       const struct rte_flow_action actions[],
-		       uint64_t pattern_hint, struct iavf_rss_meta *rss_meta,
-		       struct rte_flow_error *error)
+iavf_hash_parse_rss_type(struct iavf_pattern_match_item *match_item,
+		         const struct rte_flow_action_rss *rss,
+		         uint64_t pattern_hint, struct iavf_rss_meta *rss_meta,
+		         struct rte_flow_error *error)
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
@@ -1525,6 +1511,17 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
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
@@ -1534,6 +1531,10 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
 	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
 	if (!rss_meta_ptr) {
 		rte_flow_error_set(error, EINVAL,
@@ -1566,8 +1567,8 @@ iavf_hash_parse_pattern_action(__rte_unused struct iavf_adapter *ad,
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

