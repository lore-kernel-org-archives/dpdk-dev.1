Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47749606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Al6u7+QO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D58140A80;
	Wed, 21 Oct 2026 12:52:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C77C040041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792579975; x=1824115975;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Z72ib0u8amqOxviJcBUdWK1JG+pWY207MnIK863HM4A=;
 b=Al6u7+QOhRHN3QG/2/mkEl4NSIqeGZfSlzyIN7RdN1kf/SKgu4aW4yiQ
 4kHYnAujXwEpwcRWMaFp6sopkzvcW1F6evyaHCjQjm/e76HbYsrOwwMeV
 KvvuOSC2KPz1OkCMUbsngjCHCdXJeK1GEDAy3UAbQgGO2Kl+L+vU/PTYX
 Qmuex+8qhCQrmw9dsM7M9CBjeInDR7e8ANnnRipwdyZj/HG6lbmYU2oyE
 Q7FFyBGV3VnUfEZz6IfkpgEfN8WrB8Qh1bgzvbrq07bYWnokxDJsCayw3
 bhl2kUTPy2d8SY4AtteiCAZ5tHGLCUa6IPvPl4UkAXGw0gJmOGM0VCUtz g==;
X-CSE-ConnectionGUID: cSZmv0JuTee+zifMwzFGiQ==
X-CSE-MsgGUID: 8E9DnyliTQKuHwoCwVl/tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1301048"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1301048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:52:54 -0700
X-CSE-ConnectionGUID: tAp9i8HcRrKjGn5jn2/S+g==
X-CSE-MsgGUID: nnA1q6nkRoWuHlTfIoKvMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3078887"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2026 03:52:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/3] net/ice: rename flow metadata parameter to rule
Date: Wed, 21 Oct 2026 11:52:49 +0100
Message-ID: <9bf36a97abcbbb5a624ce63b116da035dfe43a97.1792579964.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ice/ice_acl_filter.c    |  8 ++++----
 drivers/net/intel/ice/ice_fdir_filter.c   |  8 ++++----
 drivers/net/intel/ice/ice_generic_flow.c  | 16 ++++++++--------
 drivers/net/intel/ice/ice_generic_flow.h  |  6 +++---
 drivers/net/intel/ice/ice_hash.c          | 12 ++++++------
 drivers/net/intel/ice/ice_switch_filter.c |  8 ++++----
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 08695b554f1..21b48e10091 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -505,10 +505,10 @@ ice_acl_hw_rem_conf(struct ice_pf *pf, struct acl_rule *rule, int32_t entry_idx)
 
 static int
 ice_acl_create_filter(struct ice_adapter *ad,
-		      void *meta,
+		      void *flow_rule,
 		      struct rte_flow_error *error)
 {
-	struct acl_rule *rule = meta;
+	struct acl_rule *rule = flow_rule;
 	struct ice_acl_conf *filter = &rule->conf;
 	enum ice_fltr_ptype flow_type = filter->input.flow_type;
 	struct ice_flow_action acts[1];
@@ -948,7 +948,7 @@ ice_acl_parse(struct ice_adapter *ad,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
 	       const struct rte_flow_attr *attr,
-	       void **meta,
+	       void **flow_rule,
 	       struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -1005,7 +1005,7 @@ ice_acl_parse(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	*meta = rule;
+	*flow_rule = rule;
 	return 0;
 
 error:
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index e3f2cf2e3dd..0ff9c567196 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1537,11 +1537,11 @@ ice_fdir_entry_del(struct ice_pf *pf, struct ice_fdir_fltr_pattern *key)
 
 static int
 ice_fdir_create_filter(struct ice_adapter *ad,
-		       void *meta,
+		       void *flow_rule,
 		       struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
-	struct ice_fdir_filter_conf *filter = meta;
+	struct ice_fdir_filter_conf *filter = flow_rule;
 	struct ice_fdir_info *fdir_info = &pf->fdir;
 	struct ice_fdir_filter_conf *node;
 	struct ice_fdir_fltr_pattern key;
@@ -2975,7 +2975,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	       const struct rte_flow_item pattern[],
 	       const struct rte_flow_action actions[],
 	       const struct rte_flow_attr *attr,
-	       void **meta,
+	       void **flow_rule,
 	       struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -3047,7 +3047,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	*meta = filter;
+	*flow_rule = filter;
 
 	return ret;
 error:
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index f5ae6f7d013..1602691b1cc 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2251,7 +2251,7 @@ ice_parse_engine_create(struct ice_adapter *ad,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
-	void *meta = NULL;
+	void *flow_rule = NULL;
 
 	if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask,
 				     parser->engine->type)) {
@@ -2264,17 +2264,17 @@ ice_parse_engine_create(struct ice_adapter *ad,
 	if (parser->parse_pattern_action(ad,
 					 parser->array,
 					 parser->array_len,
-					 pattern, actions, attr, &meta, error) < 0)
+					 pattern, actions, attr, &flow_rule, error) < 0)
 		return false;
 
 	RTE_ASSERT(parser->engine->create != NULL);
 
-	if (parser->engine->create(ad, meta, error) != 0) {
-		ice_flow_rule_free(parser->engine, meta);
+	if (parser->engine->create(ad, flow_rule, error) != 0) {
+		ice_flow_rule_free(parser->engine, flow_rule);
 		return false;
 	}
 
-	flow->rule = meta;
+	flow->rule = flow_rule;
 	return true;
 }
 
@@ -2287,7 +2287,7 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
-	void *meta = NULL;
+	void *flow_rule = NULL;
 	int ret;
 
 	if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask,
@@ -2302,9 +2302,9 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 					    parser->array,
 					    parser->array_len,
 					    pattern, actions, attr,
-					    &meta, error);
+					    &flow_rule, error);
 	if (ret >= 0)
-		ice_flow_rule_free(parser->engine, meta);
+		ice_flow_rule_free(parser->engine, flow_rule);
 	return ret >= 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index ca0f7abe9aa..b6eedaa202d 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -506,7 +506,7 @@ struct ice_flow_redirect {
 typedef int (*engine_init_t)(struct ice_adapter *ad);
 typedef void (*engine_uninit_t)(struct ice_adapter *ad);
 typedef int (*engine_create_t)(struct ice_adapter *ad,
-		void *meta,
+		void *flow_rule,
 		struct rte_flow_error *error);
 typedef int (*engine_destroy_t)(struct ice_adapter *ad,
 		struct rte_flow *flow,
@@ -521,7 +521,7 @@ typedef int(*engine_redirect_t)(struct ice_adapter *ad,
 /* Free nested rule allocations only, without accessing hardware resources. */
 typedef void (*engine_free_t)(void *rule);
 /*
- * Parsers return an allocated final rule through meta on success, and clean up
+ * Parsers return an allocated final rule through flow_rule on success, and clean up
  * their own allocations on failure. The generic layer owns successful results,
  * including during validation; engine create/destroy callbacks must not free them.
  */
@@ -531,7 +531,7 @@ typedef int (*parse_pattern_action_t)(struct ice_adapter *ad,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		const struct rte_flow_attr *attr,
-		void **meta,
+		void **flow_rule,
 		struct rte_flow_error *error);
 
 /* Struct to store engine created. */
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 980abb58f3b..951a9d3aa2c 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -82,7 +82,7 @@ ice_hash_init(struct ice_adapter *ad);
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		void *meta,
+		void *flow_rule,
 		struct rte_flow_error *error);
 
 static int
@@ -100,7 +100,7 @@ ice_hash_parse_pattern_action(struct ice_adapter *ad,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
 			const struct rte_flow_attr *attr,
-			void **meta,
+			void **flow_rule,
 			struct rte_flow_error *error);
 
 /* Rss configuration template */
@@ -1176,7 +1176,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 			const struct rte_flow_item pattern[],
 			const struct rte_flow_action actions[],
 			const struct rte_flow_attr *attr,
-			void **meta,
+			void **flow_rule,
 			struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
@@ -1239,7 +1239,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 
 error:
 	if (!ret)
-		*meta = rss_meta_ptr;
+		*flow_rule = rss_meta_ptr;
 	else
 		rte_free(rss_meta_ptr);
 
@@ -1313,7 +1313,7 @@ ice_hash_add_raw_cfg(struct ice_adapter *ad,
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		void *meta,
+		void *flow_rule,
 		struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
@@ -1321,7 +1321,7 @@ ice_hash_create(struct ice_adapter *ad,
 	struct ice_vsi *vsi = pf->main_vsi;
 	int ret;
 	uint32_t reg;
-	struct ice_hash_flow_cfg *filter_ptr = meta;
+	struct ice_hash_flow_cfg *filter_ptr = flow_rule;
 
 	if (filter_ptr->simple_xor) {
 		/* Enable registers for simple_xor hash function. */
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 59e18269206..8a550ed4c86 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -285,14 +285,14 @@ ice_pattern_match_item ice_switch_supported_pattern[] = {
 
 static int
 ice_switch_create(struct ice_adapter *ad,
-		void *meta,
+		void *flow_rule,
 		struct rte_flow_error *error)
 {
 	int ret = 0;
 	struct ice_pf *pf = &ad->pf;
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 	struct ice_rule_query_data rule_added = {0};
-	struct ice_switch_filter_conf *filter_conf_ptr = meta;
+	struct ice_switch_filter_conf *filter_conf_ptr = flow_rule;
 	struct ice_adv_lkup_elem *list = filter_conf_ptr->lkups;
 	uint16_t lkups_cnt = filter_conf_ptr->lkups_num;
 	struct ice_adv_rule_info *rule_info = &filter_conf_ptr->rule_info;
@@ -1705,7 +1705,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		const struct rte_flow_item pattern[],
 		const struct rte_flow_action actions[],
 		const struct rte_flow_attr *attr,
-		void **meta,
+		void **flow_rule,
 		struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
@@ -1845,7 +1845,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	filter->lkups = list;
 	filter->lkups_num = lkups_num;
 	filter->rule_info = rule_info;
-	*meta = filter;
+	*flow_rule = filter;
 
 	return 0;
 
-- 
2.52.0

