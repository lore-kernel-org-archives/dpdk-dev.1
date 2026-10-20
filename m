Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39592606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dOs7hShH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A334069F;
	Tue, 20 Oct 2026 11:11:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4A2144067C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487507; x=1824023507;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=30xXUzNxGF68ecr1vzY9z1jFwpnBQu6s2WkLtQ+IR6o=;
 b=dOs7hShHB89z/VuJyVNLipoktS8u6k5uiUuVQ3K5+LhlQ9QqrK8QEzRR
 /Wvx2g7uht73vzwxRmqbd7WgEsBvGUNpV1qAdot5CJNWOt1bHXtSeccx7
 ur/Xiye/Ypfx76sJPWyQc84Lk1oQ7W8BWOzX1SWsYnNX4yAhkS7m3msQ4
 VvIb7LUFYRgc8aO6WDXlbqm9ahFu1BwP4O4bmtnLB8gon8TGJ43RKTodo
 JZlWkWs1iR+ADEjEDaJTPGxbnBjM9q8h5jqVmYYBdN2b4iuB/MExhRUhF
 HjIPwPev5xfkAo2ZpXREhbzpvVvkalWc0peHfYHOq8tPxIM+uWRKJRRIK A==;
X-CSE-ConnectionGUID: DGVhleBQRlmApxqmEo2qiQ==
X-CSE-MsgGUID: XkMhb8oKTp2pmLI7baIehw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286816"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286816"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:46 -0700
X-CSE-ConnectionGUID: 3TpPXHGERoO9QcYLIhwwPg==
X-CSE-MsgGUID: yTllnzwtRZ6dLC9Pt0yMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879459"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v3 06/10] net/iavf: centralize memory management for flows
Date: Tue, 20 Oct 2026 10:11:29 +0100
Message-ID: <61751de4c88e4ba08dbe70dd5df6b2e6f43659d6.1792487374.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792487374.git.anatoly.burakov@intel.com>
 <cover.1792487374.git.anatoly.burakov@intel.com>
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

Flow engines currently distribute rule allocation and cleanup between the
parser, engine create and destroy callbacks, and generic flow code. This
leads to a lot of potential for memory leaks and bugs. In particular, one
of the issues currently present is that when PF initiates reset, we are
meant to just drop all flows without sending any virtchnl commands, but
because not all engines implement the `free` callback, some flows will be
leaked.

To address that specific leak as well as all other potential leaks due to
misuse of memory by engines, use parser-allocated rule objects as the
persistent rules and centralize their lifetime in the generic flow layer.
This requires fixing all engines to not manage their own memory:

- Allocate the final FDIR rule in the parser, use it for action checks,
  and remove the per-VF scratch configuration.
- Have FSUB create adopt its parser-produced rule instead of allocating
  and copying a second object.
- Build the final RSS configuration in the parser and remove the
  intermediate RSS metadata, including its unused raw-pattern flag.
- Let generic flow code free rules on validate, create failure,
  successful destroy, and uninit; remove engine-specific free callbacks
  and rule frees from destroy callbacks.

Fixes: 4dad1a6815d6 ("net/iavf: skip flow flush during PF-initiated reset")
Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h              |  5 --
 drivers/net/intel/iavf/iavf_fdir.c         | 68 +++++++--------
 drivers/net/intel/iavf/iavf_fsub.c         | 23 +----
 drivers/net/intel/iavf/iavf_generic_flow.c | 36 ++++++--
 drivers/net/intel/iavf/iavf_generic_flow.h |  2 -
 drivers/net/intel/iavf/iavf_hash.c         | 99 +++++++---------------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
 7 files changed, 97 insertions(+), 137 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 1f277eeee2..8b826662c6 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -155,10 +155,6 @@ struct iavf_fdir_conf {
 	uint32_t mark_flag;
 };
 
-struct iavf_fdir_info {
-	struct iavf_fdir_conf conf;
-};
-
 struct iavf_fsub_conf {
 	struct virtchnl_flow_sub sub_fltr;
 	struct virtchnl_flow_unsub unsub_fltr;
@@ -286,7 +282,6 @@ struct iavf_info {
 	struct iavf_parser_list dist_parser_list;
 	struct iavf_parser_list ipsec_crypto_parser_list;
 
-	struct iavf_fdir_info fdir; /* flow director info */
 	/* indicate large VF support enabled or not */
 	bool lv_enabled;
 
diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 67003183bb..7b9d3aac7f 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -353,36 +353,20 @@ iavf_fdir_create(struct iavf_adapter *ad,
 		struct rte_flow_error *error)
 {
 	struct iavf_fdir_conf *filter = meta;
-	struct iavf_fdir_conf *rule;
 	int ret;
 
-	rule = rte_zmalloc("fdir_entry", sizeof(*rule), 0);
-	if (!rule) {
-		rte_flow_error_set(error, ENOMEM,
-				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"Failed to allocate memory for fdir rule");
-		return -rte_errno;
-	}
-
 	ret = iavf_fdir_add(ad, filter);
 	if (ret) {
-		rte_flow_error_set(error, -ret,
+		return rte_flow_error_set(error, -ret,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				"Failed to add filter rule.");
-		goto free_entry;
 	}
 
 	if (filter->mark_flag == 1)
 		iavf_fdir_rx_proc_enable(ad, 1);
 
-	memcpy(rule, filter, sizeof(*rule));
-	flow->rule = rule;
-
+	flow->rule = filter;
 	return 0;
-
-free_entry:
-	rte_free(rule);
-	return -rte_errno;
 }
 
 static int
@@ -406,9 +390,6 @@ iavf_fdir_destroy(struct iavf_adapter *ad,
 	if (filter->mark_flag == 1)
 		iavf_fdir_rx_proc_enable(ad, 0);
 
-	flow->rule = NULL;
-	rte_free(filter);
-
 	return 0;
 }
 
@@ -1444,14 +1425,19 @@ iavf_fdir_action_check_qregion(struct iavf_adapter *ad,
 	return 0;
 }
 
+struct iavf_fdir_parse_ctx {
+	struct iavf_adapter *ad;
+	struct iavf_fdir_conf *filter;
+};
+
 static int
 iavf_fdir_parse_action_check(const struct ci_flow_actions *actions,
 		const struct ci_flow_actions_check_param *param,
 		struct rte_flow_error *error)
 {
-	struct iavf_adapter *ad = param->driver_ctx;
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
-	struct iavf_fdir_conf *filter = &vf->fdir.conf;
+	struct iavf_fdir_parse_ctx *ctx = param->driver_ctx;
+	struct iavf_adapter *ad = ctx->ad;
+	struct iavf_fdir_conf *filter = ctx->filter;
 	uint32_t dest_num = 0, mark_num = 0;
 	size_t i, number = 0;
 	bool has_drop = false;
@@ -1557,6 +1543,8 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 		struct rte_flow_error *error)
 {
 	struct ci_flow_actions parsed_actions = {0};
+	struct iavf_fdir_conf *filter;
+	struct iavf_fdir_parse_ctx ctx;
 	struct ci_flow_actions_check_param param = {
 		.allowed_types = (enum rte_flow_action_type[]){
 			RTE_FLOW_ACTION_TYPE_PASSTHRU,
@@ -1568,38 +1556,52 @@ iavf_fdir_parse(struct iavf_adapter *ad,
 		},
 		.max_actions = 2,
 		.check = iavf_fdir_parse_action_check,
-		.driver_ctx = ad,
 		.rss_queues_contig = true,
 	};
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
-	struct iavf_fdir_conf *filter = &vf->fdir.conf;
 	struct iavf_pattern_match_item *item = NULL;
 	int ret;
 
-	memset(filter, 0, sizeof(*filter));
+	filter = rte_zmalloc("iavf_fdir_meta", sizeof(*filter), 0);
+	if (filter == NULL) {
+		rte_flow_error_set(error, ENOMEM,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to allocate FDIR metadata.");
+		return -rte_errno;
+	}
+
+	ctx.ad = ad;
+	ctx.filter = filter;
+	param.driver_ctx = &ctx;
 
 	ret = ci_flow_check_attr(attr, NULL, error);
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
 	if (ret)
-		return ret;
+		goto error;
 
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
-	if (!item)
-		return -rte_errno;
+	if (item == NULL) {
+		ret = -rte_errno;
+		goto error;
+	}
 
 	ret = iavf_fdir_parse_pattern(ad, pattern, item->input_set_mask,
 				      error, filter);
 	if (ret)
 		goto error;
 
-	if (meta)
+	rte_free(item);
+	if (meta != NULL)
 		*meta = filter;
+	else
+		rte_free(filter);
+	return ret;
 
 error:
 	rte_free(item);
+	rte_free(filter);
 	return ret;
 }
 
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 19ae0e2dc2..e4e0e20c4f 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -73,34 +73,18 @@ iavf_fsub_create(struct iavf_adapter *ad, struct rte_flow *flow,
 		 void *meta, struct rte_flow_error *error)
 {
 	struct iavf_fsub_conf *filter = meta;
-	struct iavf_fsub_conf *rule;
 	int ret;
 
-	rule = rte_zmalloc("fsub_entry", sizeof(*rule), 0);
-	if (!rule) {
-		rte_flow_error_set(error, ENOMEM,
-				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"Failed to allocate memory for fsub rule");
-		return -rte_errno;
-	}
-
 	ret = iavf_flow_sub(ad, filter);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Failed to subscribe flow rule.");
-		goto free_entry;
+		return -rte_errno;
 	}
 
-	memcpy(rule, filter, sizeof(*rule));
-	flow->rule = rule;
-
-	rte_free(meta);
+	flow->rule = filter;
 	return ret;
-
-free_entry:
-	rte_free(rule);
-	return -rte_errno;
 }
 
 static int
@@ -120,9 +104,6 @@ iavf_fsub_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		return -rte_errno;
 	}
 
-	flow->rule = NULL;
-	rte_free(filter);
-
 	return ret;
 }
 
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index cd4d4a012b..1593ea297c 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -46,6 +46,13 @@ static int iavf_flow_dev_dump(struct rte_eth_dev *dev,
 		FILE *file,
 		struct rte_flow_error *error);
 
+static void
+iavf_flow_free(struct rte_flow *flow)
+{
+	rte_free(flow->rule);
+	rte_free(flow);
+}
+
 const struct rte_flow_ops iavf_flow_ops = {
 	.validate = iavf_flow_validate,
 	.create = iavf_flow_create,
@@ -1856,9 +1863,7 @@ iavf_flow_uninit(struct iavf_adapter *ad)
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&vf->flow_list))) {
 		TAILQ_REMOVE(&vf->flow_list, p_flow, node);
-		if (p_flow->engine->free)
-			p_flow->engine->free(p_flow);
-		rte_free(p_flow);
+		iavf_flow_free(p_flow);
 	}
 
 	/* Cleanup parser list */
@@ -2092,6 +2097,7 @@ iavf_parse_engine_create(struct iavf_adapter *ad,
 	void *meta = NULL;
 
 	RTE_TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
+		meta = NULL;
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
@@ -2101,8 +2107,17 @@ iavf_parse_engine_create(struct iavf_adapter *ad,
 		engine = parser_node->parser->engine;
 
 		RTE_ASSERT(engine->create != NULL);
-		if (!(engine->create(ad, flow, meta, error)))
+		if (engine->create(ad, flow, meta, error) == 0) {
+			if (flow->rule != meta)
+				rte_free(meta);
 			return engine;
+		}
+
+		if (flow->rule != NULL && flow->rule != meta)
+			rte_free(flow->rule);
+		rte_free(meta);
+		flow->rule = NULL;
+		meta = NULL;
 	}
 	return NULL;
 }
@@ -2120,8 +2135,10 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 	struct iavf_flow_parser_node *parser_node;
 	void *temp;
 	void *meta = NULL;
+	int ret;
 
 	RTE_TAILQ_FOREACH_SAFE(parser_node, parser_list, node, temp) {
+		meta = NULL;
 		if (parser_node->parser->parse_pattern_action(ad,
 				parser_node->parser->array,
 				parser_node->parser->array_len,
@@ -2130,13 +2147,18 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 
 		engine = parser_node->parser->engine;
 		if (engine->validation == NULL) {
+			rte_free(meta);
+			meta = NULL;
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Validation not support");
 			continue;
 		}
 
-		if (engine->validation(ad, flow, meta, error)) {
+		ret = engine->validation(ad, flow, meta, error);
+		rte_free(meta);
+		meta = NULL;
+		if (ret != 0) {
 			rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_HANDLE,
 				NULL, "Validation failed");
@@ -2238,7 +2260,7 @@ iavf_flow_create(struct rte_eth_dev *dev,
 			&engine, iavf_parse_engine_create, error);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Failed to create flow");
-		rte_free(flow);
+		iavf_flow_free(flow);
 		flow = NULL;
 		goto free_flow;
 	}
@@ -2308,7 +2330,7 @@ iavf_flow_destroy(struct rte_eth_dev *dev,
 
 	if (!ret) {
 		TAILQ_REMOVE(&vf->flow_list, flow, node);
-		rte_free(flow);
+		iavf_flow_free(flow);
 	} else {
 		PMD_DRV_LOG(ERR, "Failed to destroy flow");
 	}
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index 6665d68818..3a8f5f92e8 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -465,7 +465,6 @@ typedef int (*engine_query_t)(struct iavf_adapter *ad,
 		struct rte_flow *flow,
 		struct rte_flow_query_count *count,
 		struct rte_flow_error *error);
-typedef void (*engine_free_t) (struct rte_flow *flow);
 typedef int (*parse_pattern_action_t)(struct iavf_adapter *ad,
 		struct iavf_pattern_match_item *array,
 		uint32_t array_len,
@@ -494,7 +493,6 @@ struct iavf_flow_engine {
 	engine_create_t create;
 	engine_destroy_t destroy;
 	engine_query_t query_count;
-	engine_free_t free;
 	const char *name;
 	enum iavf_flow_engine_type type;
 	size_t rule_size;
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 00b616f34b..6352bf28f9 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -58,12 +58,6 @@ struct iavf_hash_match_type {
 	uint64_t pattern_hint;
 };
 
-struct iavf_rss_meta {
-	struct virtchnl_proto_hdrs proto_hdrs;
-	enum virtchnl_rss_algorithm rss_algorithm;
-	bool raw_ena;
-};
-
 struct iavf_hash_flow_cfg {
 	struct virtchnl_rss_cfg *rss_cfg;
 	bool simple_xor;
@@ -79,8 +73,6 @@ iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		  struct rte_flow_error *error);
 static void
 iavf_hash_uninit_parser(struct iavf_adapter *ad);
-static void
-iavf_hash_free(struct rte_flow *flow);
 static int
 iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 			       struct iavf_pattern_match_item *array,
@@ -682,7 +674,6 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.create = iavf_hash_create,
 	.destroy = iavf_hash_destroy,
 	.uninit = iavf_hash_uninit_parser,
-	.free = iavf_hash_free,
 	.name = "hash",
 	.type = IAVF_FLOW_ENGINE_HASH,
 	.rule_size = sizeof(struct virtchnl_rss_cfg),
@@ -886,7 +877,7 @@ iavf_hash_parse_pattern(const struct rte_flow_item pattern[], uint64_t *phint,
 static int
 iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 			struct rte_flow_error *error,
-			struct iavf_rss_meta *meta)
+			struct virtchnl_rss_cfg *rss_cfg)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
 	uint16_t spec_len, pkt_len;
@@ -958,9 +949,9 @@ iavf_hash_parse_raw_pattern(const struct rte_flow_item *item,
 			msk_buf[j] = tmp_val * 16 + tmp_c - '0';
 	}
 
-	memcpy(meta->proto_hdrs.raw.spec, pkt_buf, pkt_len);
-	memcpy(meta->proto_hdrs.raw.mask, msk_buf, pkt_len);
-	meta->proto_hdrs.raw.pkt_len = pkt_len;
+	memcpy(rss_cfg->proto_hdrs.raw.spec, pkt_buf, pkt_len);
+	memcpy(rss_cfg->proto_hdrs.raw.mask, msk_buf, pkt_len);
+	rss_cfg->proto_hdrs.raw.pkt_len = pkt_len;
 
 	rte_free(pkt_buf);
 	rte_free(msk_buf);
@@ -1433,12 +1424,12 @@ iavf_any_invalid_rss_type(enum rte_eth_hash_function rss_func,
 static int
 iavf_hash_parse_rss_type(struct iavf_pattern_match_item *match_item,
 		const struct rte_flow_action_rss *rss,
-		uint64_t pattern_hint, struct iavf_rss_meta *rss_meta,
+		uint64_t pattern_hint, struct virtchnl_rss_cfg *rss_cfg,
 		struct rte_flow_error *error)
 {
 	uint64_t rss_type;
 
-	rss_meta->rss_algorithm = rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ ?
+	rss_cfg->rss_algorithm = rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ ?
 		VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC :
 		VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC;
 
@@ -1458,9 +1449,9 @@ iavf_hash_parse_rss_type(struct iavf_pattern_match_item *match_item,
 				"RSS type not supported");
 	}
 
-	memcpy(&rss_meta->proto_hdrs, match_item->meta, sizeof(struct virtchnl_proto_hdrs));
+	memcpy(&rss_cfg->proto_hdrs, match_item->meta, sizeof(rss_cfg->proto_hdrs));
 
-	iavf_refine_proto_hdrs(&rss_meta->proto_hdrs, rss_type, pattern_hint);
+	iavf_refine_proto_hdrs(&rss_cfg->proto_hdrs, rss_type, pattern_hint);
 
 	return 0;
 }
@@ -1526,7 +1517,7 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 	};
 	const struct rte_flow_action_rss *rss;
 	struct iavf_pattern_match_item *pattern_match_item;
-	struct iavf_rss_meta *rss_meta_ptr;
+	struct virtchnl_rss_cfg *rss_cfg;
 	uint64_t phint = IAVF_PHINT_NONE;
 	int ret = 0;
 
@@ -1538,12 +1529,12 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 	if (ret)
 		return ret;
 
-	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
-	if (!rss_meta_ptr) {
+	rss_cfg = rte_zmalloc("iavf_rss_rule", sizeof(*rss_cfg), 0);
+	if (rss_cfg == NULL) {
 		rte_flow_error_set(error, ENOMEM,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "No memory for rss_meta_ptr");
-		return -ENOMEM;
+				   "No memory for RSS rule.");
+		return -rte_errno;
 	}
 
 	/* Check rss supported pattern and find matched pattern. */
@@ -1560,8 +1551,7 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 		goto error;
 
 	if (phint == IAVF_PHINT_RAW) {
-		rss_meta_ptr->raw_ena = true;
-		ret = iavf_hash_parse_raw_pattern(pattern, error, rss_meta_ptr);
+		ret = iavf_hash_parse_raw_pattern(pattern, error, rss_cfg);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
@@ -1571,13 +1561,13 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 	}
 
 	rss = parsed_actions.actions[0]->conf;
-	ret = iavf_hash_parse_rss_type(pattern_match_item, rss, phint, rss_meta_ptr, error);
+	ret = iavf_hash_parse_rss_type(pattern_match_item, rss, phint, rss_cfg, error);
 
 error:
 	if (!ret && meta)
-		*meta = rss_meta_ptr;
+		*meta = rss_cfg;
 	else
-		rte_free(rss_meta_ptr);
+		rte_free(rss_cfg);
 
 	rte_free(pattern_match_item);
 
@@ -1585,27 +1575,13 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 }
 
 static int
-iavf_hash_create(__rte_unused struct iavf_adapter *ad,
-		 __rte_unused struct rte_flow *flow, void *meta,
-		 __rte_unused struct rte_flow_error *error)
+iavf_hash_create(struct iavf_adapter *ad,
+		 struct rte_flow *flow, void *meta,
+		 struct rte_flow_error *error)
 {
-	struct iavf_rss_meta *rss_meta = (struct iavf_rss_meta *)meta;
-	struct virtchnl_rss_cfg *rss_cfg;
+	struct virtchnl_rss_cfg *rss_cfg = meta;
 	int ret = 0;
 
-	rss_cfg = rte_zmalloc("iavf rss rule",
-			      sizeof(struct virtchnl_rss_cfg), 0);
-	if (!rss_cfg) {
-		rte_flow_error_set(error, ENOMEM,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "No memory for rss rule");
-		rte_free(meta);
-		return -ENOMEM;
-	}
-
-	rss_cfg->proto_hdrs = rss_meta->proto_hdrs;
-	rss_cfg->rss_algorithm = rss_meta->rss_algorithm;
-
 	ret = iavf_add_del_rss_cfg(ad, rss_cfg, true);
 	if (!ret) {
 		flow->rule = rss_cfg;
@@ -1614,13 +1590,9 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Failed to add rss rule.");
-		rte_free(rss_cfg);
-		rte_free(meta);
 		return -rte_errno;
 	}
 
-	rte_free(meta);
-
 	return ret;
 }
 
@@ -1633,22 +1605,19 @@ iavf_hash_destroy(__rte_unused struct iavf_adapter *ad,
 	struct virtchnl_rss_cfg *rss_cfg;
 	int ret = 0;
 
+	if (vf->vf_reset)
+		return 0;
+
 	rss_cfg = (struct virtchnl_rss_cfg *)flow->rule;
 
-	if (!vf->vf_reset) {
-		ret = iavf_add_del_rss_cfg(ad, rss_cfg, false);
-		if (ret) {
-			PMD_DRV_LOG(ERR, "fail to del RSS configure");
-			rte_flow_error_set(error, -ret,
-					   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-					   "Failed to delete rss rule.");
-			return -rte_errno;
-		}
+	ret = iavf_add_del_rss_cfg(ad, rss_cfg, false);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "fail to del RSS configure");
+		rte_flow_error_set(error, -ret,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to delete rss rule.");
+		return -rte_errno;
 	}
-
-	flow->rule = NULL;
-	rte_free(rss_cfg);
-
 	return ret;
 }
 
@@ -1677,9 +1646,3 @@ iavf_hash_uninit(struct iavf_adapter *ad)
 	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
 		PMD_DRV_LOG(ERR, "fail to delete default RSS");
 }
-
-static void
-iavf_hash_free(struct rte_flow *flow)
-{
-	rte_free(flow->rule);
-}
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index b481330346..e9acd1bb1d 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1919,7 +1919,6 @@ iavf_ipsec_flow_destroy(struct iavf_adapter *ad,
 
 	iavf_ipsec_crypto_security_policy_delete(ad,
 			ipsec_flow->is_ipv4, ipsec_flow->id);
-	rte_free(ipsec_flow);
 	return 0;
 }
 
-- 
2.52.0

