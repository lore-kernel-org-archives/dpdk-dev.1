Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB85606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h8/rekJx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23E6C4068E;
	Wed, 21 Oct 2026 12:15:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4C31440041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577715; x=1824113715;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=K9MIWAuLaked+/Jcl6p4SpgCntfQSrMwGxW9ugjI3HQ=;
 b=h8/rekJx3yaM8poP1GnUHryJ7tqQfuzlvrpjD03Wxu1RbCE2GSj3nSaI
 O+a83uUNR8Pi/pefqmk+p+mhq8Wvp1+2bXb9LtFvbTgUQntXToLCdA5oA
 iDwfJanpCueIUX4+v9e5TYPskI1A40ZWPuetWlKQbJ9GReJ5FhTMiwx6Z
 otEy7QMJ8WxRT4tbAuL5k1RwemRSwwdAnrBp/eD6UikpO+VrxGBSLqmm+
 6lR+CR4o/3H/eYNtR2V2BwHzfR8eREQ4ZOLBkyaUK1bKpe1vIch8FaqcA
 e6M7NgnVqMzbbQgcnC0T4oVlcMToekbthKDMwRsXE/gNiLg78VbwAECn1 w==;
X-CSE-ConnectionGUID: BBPE0czhRe2q78gqF3r87Q==
X-CSE-MsgGUID: 8iTqI+K3SaSFdaerHQC3aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1397573"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1397573"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:15:14 -0700
X-CSE-ConnectionGUID: CNHn8eSfTXK6TjnlUqUBQQ==
X-CSE-MsgGUID: himu8cYGSxGSJQBBRKK2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3106190"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 21 Oct 2026 03:15:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/2] net/ice: rename flow metadata parameter to rule
Date: Wed, 21 Oct 2026 11:15:02 +0100
Message-ID: <d42ef9c40c98cc9ccb576f962ba0524a4a769ade.1792577695.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parsers now return the final engine-specific rule rather than temporary
metadata. The generic flow layer passes this object to engine creation
and stores it in `flow->rule`.

Rename the `meta` parameters and related local variables to reflect
their role as persistent rules.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    | 36 +++++++++----------
 drivers/net/intel/ice/ice_fdir_filter.c   |  8 ++---
 drivers/net/intel/ice/ice_generic_flow.c  | 16 ++++-----
 drivers/net/intel/ice/ice_generic_flow.h  |  6 ++--
 drivers/net/intel/ice/ice_hash.c          | 42 +++++++++++------------
 drivers/net/intel/ice/ice_switch_filter.c |  8 ++---
 6 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 08695b554f1..fdd841b062d 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -505,11 +505,11 @@ ice_acl_hw_rem_conf(struct ice_pf *pf, struct acl_rule *rule, int32_t entry_idx)
 
 static int
 ice_acl_create_filter(struct ice_adapter *ad,
-		      void *meta,
+		      void *rule,
 		      struct rte_flow_error *error)
 {
-	struct acl_rule *rule = meta;
-	struct ice_acl_conf *filter = &rule->conf;
+	struct acl_rule *acl_rule = rule;
+	struct ice_acl_conf *filter = &acl_rule->conf;
 	enum ice_fltr_ptype flow_type = filter->input.flow_type;
 	struct ice_flow_action acts[1];
 	struct ice_pf *pf = &ad->pf;
@@ -538,7 +538,7 @@ ice_acl_create_filter(struct ice_adapter *ad,
 	}
 
 	input->acl_fltr = true;
-	ret = ice_acl_hw_set_conf(pf, input, acts, rule, flow_type, 0);
+	ret = ice_acl_hw_set_conf(pf, input, acts, acl_rule, flow_type, 0);
 	if (ret) {
 		return rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
@@ -547,29 +547,29 @@ ice_acl_create_filter(struct ice_adapter *ad,
 
 	if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER ||
 		flow_type == ICE_FLTR_PTYPE_FRAG_IPV4) {
-		ret = ice_acl_hw_set_conf(pf, input, acts, rule,
+		ret = ice_acl_hw_set_conf(pf, input, acts, acl_rule,
 					  ICE_FLTR_PTYPE_NONF_IPV4_UDP, 1);
 		if (ret)
 			goto err_acl_hw_set_conf_udp;
-		ret = ice_acl_hw_set_conf(pf, input, acts, rule,
+		ret = ice_acl_hw_set_conf(pf, input, acts, acl_rule,
 					  ICE_FLTR_PTYPE_NONF_IPV4_TCP, 2);
 		if (ret)
 			goto err_acl_hw_set_conf_tcp;
-		ret = ice_acl_hw_set_conf(pf, input, acts, rule,
+		ret = ice_acl_hw_set_conf(pf, input, acts, acl_rule,
 					  ICE_FLTR_PTYPE_NONF_IPV4_SCTP, 3);
 		if (ret)
 			goto err_acl_hw_set_conf_sctp;
 	}
 
-	rule->flow_type = flow_type;
+	acl_rule->flow_type = flow_type;
 	return 0;
 
 err_acl_hw_set_conf_sctp:
-	ice_acl_hw_rem_conf(pf, rule, 3);
+	ice_acl_hw_rem_conf(pf, acl_rule, 3);
 err_acl_hw_set_conf_tcp:
-	ice_acl_hw_rem_conf(pf, rule, 2);
+	ice_acl_hw_rem_conf(pf, acl_rule, 2);
 err_acl_hw_set_conf_udp:
-	ice_acl_hw_rem_conf(pf, rule, 1);
+	ice_acl_hw_rem_conf(pf, acl_rule, 1);
 	return ret;
 }
 
@@ -948,7 +948,7 @@ ice_acl_parse(struct ice_adapter *ad,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
 	       const struct rte_flow_attr *attr,
-	       void **meta,
+	       void **rule,
 	       struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -962,7 +962,7 @@ ice_acl_parse(struct ice_adapter *ad,
 		.check = ice_acl_parse_action_check,
 		.driver_ctx = ad,
 	};
-	struct acl_rule *rule;
+	struct acl_rule *acl_rule;
 	struct ice_acl_conf *filter;
 	struct ice_pattern_match_item item;
 	uint64_t input_set;
@@ -981,13 +981,13 @@ ice_acl_parse(struct ice_adapter *ad,
 	if (ret != 0)
 		return ret;
 
-	rule = rte_zmalloc("acl_rule", sizeof(*rule), 0);
-	if (rule == NULL) {
+	acl_rule = rte_zmalloc("acl_rule", sizeof(*acl_rule), 0);
+	if (acl_rule == NULL) {
 		return rte_flow_error_set(error, ENOMEM,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				"Failed to allocate memory for acl rule");
 	}
-	filter = &rule->conf;
+	filter = &acl_rule->conf;
 
 	ret = ice_acl_parse_pattern(ad, pattern, error, filter);
 	if (ret)
@@ -1005,11 +1005,11 @@ ice_acl_parse(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	*meta = rule;
+	*rule = acl_rule;
 	return 0;
 
 error:
-	rte_free(rule);
+	rte_free(acl_rule);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index e3f2cf2e3dd..996d46819c9 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1537,11 +1537,11 @@ ice_fdir_entry_del(struct ice_pf *pf, struct ice_fdir_fltr_pattern *key)
 
 static int
 ice_fdir_create_filter(struct ice_adapter *ad,
-		       void *meta,
+		       void *rule,
 		       struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
-	struct ice_fdir_filter_conf *filter = meta;
+	struct ice_fdir_filter_conf *filter = rule;
 	struct ice_fdir_info *fdir_info = &pf->fdir;
 	struct ice_fdir_filter_conf *node;
 	struct ice_fdir_fltr_pattern key;
@@ -2975,7 +2975,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
 	       const struct rte_flow_attr *attr,
-	       void **meta,
+	       void **rule,
 	       struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -3047,7 +3047,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	*meta = filter;
+	*rule = filter;
 
 	return ret;
 error:
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index f5ae6f7d013..51a953ebfe9 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2251,7 +2251,7 @@ ice_parse_engine_create(struct ice_adapter *ad,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
-	void *meta = NULL;
+	void *rule = NULL;
 
 	if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask,
 				     parser->engine->type)) {
@@ -2264,17 +2264,17 @@ ice_parse_engine_create(struct ice_adapter *ad,
 	if (parser->parse_pattern_action(ad,
 					 parser->array,
 					 parser->array_len,
-					 pattern, actions, attr, &meta, error) < 0)
+					 pattern, actions, attr, &rule, error) < 0)
 		return false;
 
 	RTE_ASSERT(parser->engine->create != NULL);
 
-	if (parser->engine->create(ad, meta, error) != 0) {
-		ice_flow_rule_free(parser->engine, meta);
+	if (parser->engine->create(ad, rule, error) != 0) {
+		ice_flow_rule_free(parser->engine, rule);
 		return false;
 	}
 
-	flow->rule = meta;
+	flow->rule = rule;
 	return true;
 }
 
@@ -2287,7 +2287,7 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
-	void *meta = NULL;
+	void *rule = NULL;
 	int ret;
 
 	if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask,
@@ -2302,9 +2302,9 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 					    parser->array,
 					    parser->array_len,
 					    pattern, actions, attr,
-					    &meta, error);
+					    &rule, error);
 	if (ret >= 0)
-		ice_flow_rule_free(parser->engine, meta);
+		ice_flow_rule_free(parser->engine, rule);
 	return ret >= 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index ca0f7abe9aa..97fc3b43ac5 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -506,7 +506,7 @@ struct ice_flow_redirect {
 typedef int (*engine_init_t)(struct ice_adapter *ad);
 typedef void (*engine_uninit_t)(struct ice_adapter *ad);
 typedef int (*engine_create_t)(struct ice_adapter *ad,
-		void *meta,
+		void *rule,
 		struct rte_flow_error *error);
 typedef int (*engine_destroy_t)(struct ice_adapter *ad,
 		struct rte_flow *flow,
@@ -521,7 +521,7 @@ typedef int(*engine_redirect_t)(struct ice_adapter *ad,
 /* Free nested rule allocations only, without accessing hardware resources. */
 typedef void (*engine_free_t)(void *rule);
 /*
- * Parsers return an allocated final rule through meta on success, and clean up
+ * Parsers return an allocated final rule through rule on success, and clean up
  * their own allocations on failure. The generic layer owns successful results,
  * including during validation; engine create/destroy callbacks must not free them.
  */
@@ -531,7 +531,7 @@ typedef int (*parse_pattern_action_t)(struct ice_adapter *ad,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		const struct rte_flow_attr *attr,
-		void **meta,
+		void **rule,
 		struct rte_flow_error *error);
 
 /* Struct to store engine created. */
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 980abb58f3b..5644c89a642 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -82,7 +82,7 @@ ice_hash_init(struct ice_adapter *ad);
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		void *meta,
+		void *rule,
 		struct rte_flow_error *error);
 
 static int
@@ -100,7 +100,7 @@ ice_hash_parse_pattern_action(struct ice_adapter *ad,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
 			const struct rte_flow_attr *attr,
-			void **meta,
+			void **rule,
 			struct rte_flow_error *error);
 
 /* Rss configuration template */
@@ -656,7 +656,7 @@ static int
 ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 				const struct rte_flow_item *item,
 				struct rte_flow_error *error,
-				struct ice_hash_flow_cfg *meta)
+				struct ice_hash_flow_cfg *rule)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
 	struct ice_parser_profile prof;
@@ -744,7 +744,7 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	if (ret)
 		goto free_mem;
 
-	memcpy(&meta->rss_cfg.raw.prof, &prof, sizeof(prof));
+	memcpy(&rule->rss_cfg.raw.prof, &prof, sizeof(prof));
 
 free_mem:
 	free(pkt_buf);
@@ -1122,7 +1122,7 @@ ice_hash_parse_action_check(const struct ci_flow_actions *actions,
 static int
 ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 		const struct rte_flow_action_rss *rss,
-		uint64_t pattern_hint, struct ice_hash_flow_cfg *rss_meta,
+		uint64_t pattern_hint, struct ice_hash_flow_cfg *rule,
 		struct rte_flow_error *error)
 {
 	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
@@ -1135,7 +1135,7 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
 					"XOR hash function is only supported for empty pattern");
 		}
-		rss_meta->simple_xor = true;
+		rule->simple_xor = true;
 		return 0;
 	}
 
@@ -1145,7 +1145,7 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 
 	/* If pattern type is raw, no need to refine rss type */
 	if (pattern_hint == ICE_PHINT_RAW) {
-		rss_meta->rss_cfg.raw.symm = symm;
+		rule->rss_cfg.raw.symm = symm;
 		return 0;
 	}
 	cfg->symm = symm;
@@ -1162,8 +1162,8 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				rss, "RSS type not supported");
 
-	rss_meta->rss_cfg.hash = *cfg;
-	ice_refine_hash_cfg(&rss_meta->rss_cfg.hash,
+	rule->rss_cfg.hash = *cfg;
+	ice_refine_hash_cfg(&rule->rss_cfg.hash,
 			    rss_type, pattern_hint);
 
 	return 0;
@@ -1176,7 +1176,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
 			const struct rte_flow_attr *attr,
-			void **meta,
+			void **rule,
 			struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -1190,7 +1190,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	};
 	const struct rte_flow_action_rss *rss;
 	struct ice_pattern_match_item pattern_match_item;
-	struct ice_hash_flow_cfg *rss_meta_ptr;
+	struct ice_hash_flow_cfg *filter;
 	uint64_t phint = ICE_PHINT_NONE;
 	int ret = 0;
 
@@ -1202,11 +1202,11 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	if (ret)
 		return ret;
 
-	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
-	if (!rss_meta_ptr) {
+	filter = rte_zmalloc(NULL, sizeof(*filter), 0);
+	if (!filter) {
 		rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"No memory for rss_meta_ptr");
+				"No memory for RSS rule");
 		return -ENOMEM;
 	}
 
@@ -1223,8 +1223,8 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	if (phint == ICE_PHINT_RAW) {
 		const struct rte_flow_item *raw_item = ice_pattern_skip_void(pattern);
 
-		rss_meta_ptr->rss_cfg.raw.raw_ena = true;
-		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_meta_ptr);
+		filter->rss_cfg.raw.raw_ena = true;
+		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, filter);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
@@ -1235,13 +1235,13 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 
 	rss = parsed_actions.actions[0]->conf;
 	ret = ice_hash_parse_rss_action(&pattern_match_item, rss, phint,
-				rss_meta_ptr, error);
+				filter, error);
 
 error:
 	if (!ret)
-		*meta = rss_meta_ptr;
+		*rule = filter;
 	else
-		rte_free(rss_meta_ptr);
+		rte_free(filter);
 
 	return ret;
 }
@@ -1313,7 +1313,7 @@ ice_hash_add_raw_cfg(struct ice_adapter *ad,
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		void *meta,
+		void *rule,
 		struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
@@ -1321,7 +1321,7 @@ ice_hash_create(struct ice_adapter *ad,
 	struct ice_vsi *vsi = pf->main_vsi;
 	int ret;
 	uint32_t reg;
-	struct ice_hash_flow_cfg *filter_ptr = meta;
+	struct ice_hash_flow_cfg *filter_ptr = rule;
 
 	if (filter_ptr->simple_xor) {
 		/* Enable registers for simple_xor hash function. */
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 59e18269206..ade6ca6640f 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -285,14 +285,14 @@ ice_pattern_match_item ice_switch_supported_pattern[] = {
 
 static int
 ice_switch_create(struct ice_adapter *ad,
-		void *meta,
+		void *rule,
 		struct rte_flow_error *error)
 {
 	int ret = 0;
 	struct ice_pf *pf = &ad->pf;
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 	struct ice_rule_query_data rule_added = {0};
-	struct ice_switch_filter_conf *filter_conf_ptr = meta;
+	struct ice_switch_filter_conf *filter_conf_ptr = rule;
 	struct ice_adv_lkup_elem *list = filter_conf_ptr->lkups;
 	uint16_t lkups_cnt = filter_conf_ptr->lkups_num;
 	struct ice_adv_rule_info *rule_info = &filter_conf_ptr->rule_info;
@@ -1705,7 +1705,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		const struct rte_flow_attr *attr,
-		void **meta,
+		void **rule,
 		struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
@@ -1845,7 +1845,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	filter->lkups = list;
 	filter->lkups_num = lkups_num;
 	filter->rule_info = rule_info;
-	*meta = filter;
+	*rule = filter;
 
 	return 0;
 
-- 
2.52.0

