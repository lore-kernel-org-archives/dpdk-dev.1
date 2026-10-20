Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD27606A324
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M0bYkhq7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BA4B40A75;
	Tue, 20 Oct 2026 11:11:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBEB4069F
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487511; x=1824023511;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WBoNaCqhRclTdIu+IbF2MplW9IALgN6sFa0nIfDuIVw=;
 b=M0bYkhq7SiUg9VzhHqisjkXSVwu/zjFpq7DpLpRthKyAh5pfdGRUQkX7
 JtAMH8Bn5/cJ8R3vOrKtynR4UDR0D2jiiY/l/oFSAzzZdCmVfO72eOvai
 BkLZ7IJjnxH/bJMOJEOhD8uymSySFMy4CFbmnNgjIQKwrwKTiqPMJU7P+
 QrvliTY3f3yUXnX2SAXLdVOAtRT5fhiCaCXxjRTCCpW+opqCJV6L30Z63
 N2mQD2M61gmTV2WlNIj419ZGIXuBWo3rQDuqqQX22V01paOs9qSEgmkwS
 381hAAN5CIlKLHU/Ye0VHzPOtGjtte1cJ3glhY0vJzRM02mGVSkoNHE+c A==;
X-CSE-ConnectionGUID: MG4JfYzrR/Kl5UQ3hycKrQ==
X-CSE-MsgGUID: htH/jFHDRwKIJpwHIdoVLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286820"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286820"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:50 -0700
X-CSE-ConnectionGUID: SGs+L4duTeG8uVrDketGOw==
X-CSE-MsgGUID: 7DR5Ii/uSzyBWzf3VkyCSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879469"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH v3 09/10] net/iavf: fix null engine for egress security flows
Date: Tue, 20 Oct 2026 10:11:32 +0100
Message-ID: <c37a0b4add7cd2e721e2b5a67b30ea5d0efe6dc3.1792487374.git.anatoly.burakov@intel.com>
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

Egress security flows bypass the flow parsers and are inserted with a
NULL `engine` pointer. The create path then dereferences that pointer
when logging the new flow, and other engine-based operations cannot
handle the flow consistently.

Register an egress security engine and route these flows through the
normal parser and lifecycle callbacks. Egress flows own no rule and
require no hardware teardown.

Fixes: e783da175250 ("net/iavf: fix memory leak on egress IPsec flows")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c |  44 +++-----
 drivers/net/intel/iavf/iavf_generic_flow.h |   2 +-
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 120 +++++++++++++++++++--
 3 files changed, 123 insertions(+), 43 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 1593ea297c..be7ddf5db6 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1914,7 +1914,8 @@ iavf_register_parser(struct iavf_flow_parser *parser,
 			}
 		}
 		TAILQ_INSERT_HEAD(list, parser_node, node);
-	} else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO) {
+	} else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO ||
+		   parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_EGRESS) {
 		list = &vf->ipsec_crypto_parser_list;
 		TAILQ_INSERT_HEAD(list, parser_node, node);
 	} else if (parser->engine->type == IAVF_FLOW_ENGINE_FSUB) {
@@ -1943,7 +1944,8 @@ iavf_unregister_parser(struct iavf_flow_parser *parser,
 	else if ((parser->engine->type == IAVF_FLOW_ENGINE_FDIR) ||
 		 (parser->engine->type == IAVF_FLOW_ENGINE_FSUB))
 		list = &vf->dist_parser_list;
-	else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO)
+	else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO ||
+		 parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_EGRESS)
 		list = &vf->ipsec_crypto_parser_list;
 
 	if (list == NULL)
@@ -2250,12 +2252,6 @@ iavf_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
-	/* Special case for inline crypto egress flows */
-	if (attr->egress && actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY) {
-		flow->is_ipsec_egress_flow = true;
-		goto tailq_insert;
-	}
-
 	ret = iavf_flow_process_filter(dev, flow, attr, pattern, actions,
 			&engine, iavf_parse_engine_create, error);
 	if (ret < 0) {
@@ -2266,7 +2262,6 @@ iavf_flow_create(struct rte_eth_dev *dev,
 	}
 
 	flow->engine = engine;
-tailq_insert:
 	rte_spinlock_lock(&vf->flow_ops_lock);
 	TAILQ_INSERT_TAIL(&vf->flow_list, flow, node);
 	rte_spinlock_unlock(&vf->flow_ops_lock);
@@ -2282,14 +2277,7 @@ iavf_flow_is_valid(struct rte_flow *flow)
 	struct iavf_flow_engine *engine;
 	void *temp;
 
-	if (flow == NULL)
-		return false;
-
-	/* these flows don't use engines */
-	if (flow->is_ipsec_egress_flow)
-		return true;
-
-	if (flow->engine) {
+	if (flow != NULL && flow->engine != NULL) {
 		RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 			if (engine == flow->engine)
 				return true;
@@ -2307,26 +2295,17 @@ iavf_flow_destroy(struct rte_eth_dev *dev,
 	struct iavf_adapter *ad =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
-	bool need_destroy;
 	int ret = 0;
 
-	if (!iavf_flow_is_valid(flow)) {
+	if (!iavf_flow_is_valid(flow) || flow->engine->destroy == NULL) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL, "Invalid flow destroy");
 		return -rte_errno;
 	}
-	need_destroy = !flow->is_ipsec_egress_flow;
-
-	if (need_destroy && flow->engine->destroy == NULL) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"Invalid flow destroy");
-	}
 
 	rte_spinlock_lock(&vf->flow_ops_lock);
-	if (need_destroy)
-		ret = flow->engine->destroy(ad, flow, error);
+	ret = flow->engine->destroy(ad, flow, error);
 
 	if (!ret) {
 		TAILQ_REMOVE(&vf->flow_list, flow, node);
@@ -2444,16 +2423,17 @@ iavf_flow_dev_dump(struct rte_eth_dev *dev,
 		if (flow != NULL && f != flow)
 			continue;
 
-		/* this should not happen */
-		if (f->engine == NULL || f->rule == NULL) {
+		if (!iavf_flow_is_valid(f)) {
 			PMD_DRV_LOG(DEBUG, "Invalid flow");
 			continue;
 		}
 
 		found = true;
 
-		rule_size = f->engine->rule_size;
-		rule_data = f->rule;
+		if (f->rule != NULL) {
+			rule_size = f->engine->rule_size;
+			rule_data = f->rule;
+		}
 
 		iavf_flow_dump_blob(file,
 			f->engine->name != NULL ?
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index 3a8f5f92e8..75bb92900b 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -481,6 +481,7 @@ enum iavf_flow_engine_type {
 	IAVF_FLOW_ENGINE_FDIR,
 	IAVF_FLOW_ENGINE_HASH,
 	IAVF_FLOW_ENGINE_FSUB,
+	IAVF_FLOW_ENGINE_IPSEC_EGRESS,
 	IAVF_FLOW_ENGINE_MAX,
 };
 
@@ -503,7 +504,6 @@ TAILQ_HEAD(iavf_engine_list, iavf_flow_engine);
 /* Struct to store flow created. */
 struct rte_flow {
 	TAILQ_ENTRY(rte_flow) node;
-	bool is_ipsec_egress_flow;
 	struct iavf_flow_engine *engine;
 	void *rule;
 };
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index e9acd1bb1d..f7e391a74a 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1832,6 +1832,7 @@ iavf_ipsec_flow_item_parse(struct iavf_adapter *adapter,
 
 
 static struct iavf_flow_parser iavf_ipsec_flow_parser;
+static struct iavf_flow_parser iavf_ipsec_egress_flow_parser;
 
 static int
 iavf_ipsec_flow_init(struct iavf_adapter *ad)
@@ -1922,16 +1923,6 @@ iavf_ipsec_flow_destroy(struct iavf_adapter *ad,
 	return 0;
 }
 
-static struct iavf_flow_engine iavf_ipsec_flow_engine = {
-	.init = iavf_ipsec_flow_init,
-	.uninit = iavf_ipsec_flow_uninit,
-	.create = iavf_ipsec_flow_create,
-	.destroy = iavf_ipsec_flow_destroy,
-	.name = "ipsec_crypto",
-	.type = IAVF_FLOW_ENGINE_IPSEC_CRYPTO,
-	.rule_size = sizeof(struct iavf_ipsec_flow_item),
-};
-
 static int
 iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		      struct iavf_pattern_match_item *array,
@@ -1975,6 +1966,105 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 	return ret;
 }
 
+/*
+ * Inline crypto egress flows only associate Tx traffic with a security
+ * session; nothing is programmed in hardware, so the engine owns no rule.
+ */
+static int
+iavf_ipsec_egress_flow_init(struct iavf_adapter *ad)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+
+	if (!vf->vf_res)
+		return -EINVAL;
+
+	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_INLINE_IPSEC_CRYPTO))
+		return -ENOTSUP;
+
+	return iavf_register_parser(&iavf_ipsec_egress_flow_parser, ad);
+}
+
+static void
+iavf_ipsec_egress_flow_uninit(struct iavf_adapter *ad)
+{
+	iavf_unregister_parser(&iavf_ipsec_egress_flow_parser, ad);
+}
+
+static int
+iavf_ipsec_egress_flow_create(__rte_unused struct iavf_adapter *ad,
+		struct rte_flow *flow,
+		__rte_unused void *meta,
+		__rte_unused struct rte_flow_error *error)
+{
+	flow->rule = NULL;
+	return 0;
+}
+
+static int
+iavf_ipsec_egress_flow_destroy(__rte_unused struct iavf_adapter *ad,
+		__rte_unused struct rte_flow *flow,
+		__rte_unused struct rte_flow_error *error)
+{
+	return 0;
+}
+
+/* The pattern is not used, as there is nothing to match in hardware. */
+static int
+iavf_ipsec_egress_flow_parse(__rte_unused struct iavf_adapter *ad,
+		__rte_unused struct iavf_pattern_match_item *array,
+		__rte_unused uint32_t array_len,
+		__rte_unused const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		const struct rte_flow_attr *attr,
+		void **meta,
+		struct rte_flow_error *error)
+{
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]){
+			RTE_FLOW_ACTION_TYPE_SECURITY,
+			RTE_FLOW_ACTION_TYPE_END,
+		},
+		.max_actions = 1,
+	};
+	struct ci_flow_attr_check_param attr_param = {
+		.require_egress = true,
+	};
+	int ret;
+
+	ret = ci_flow_check_attr(attr, &attr_param, error);
+	if (ret)
+		return ret;
+
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret < 0)
+		return ret;
+
+	if (meta != NULL)
+		*meta = NULL;
+
+	return 0;
+}
+
+static struct iavf_flow_engine iavf_ipsec_flow_engine = {
+	.init = iavf_ipsec_flow_init,
+	.uninit = iavf_ipsec_flow_uninit,
+	.create = iavf_ipsec_flow_create,
+	.destroy = iavf_ipsec_flow_destroy,
+	.name = "ipsec_crypto",
+	.type = IAVF_FLOW_ENGINE_IPSEC_CRYPTO,
+	.rule_size = sizeof(struct iavf_ipsec_flow_item),
+};
+
+static struct iavf_flow_engine iavf_ipsec_egress_flow_engine = {
+	.init = iavf_ipsec_egress_flow_init,
+	.uninit = iavf_ipsec_egress_flow_uninit,
+	.create = iavf_ipsec_egress_flow_create,
+	.destroy = iavf_ipsec_egress_flow_destroy,
+	.name = "ipsec_egress",
+	.type = IAVF_FLOW_ENGINE_IPSEC_EGRESS,
+};
+
 static struct iavf_flow_parser iavf_ipsec_flow_parser = {
 	.engine = &iavf_ipsec_flow_engine,
 	.array = iavf_ipsec_flow_pattern,
@@ -1982,7 +2072,17 @@ static struct iavf_flow_parser iavf_ipsec_flow_parser = {
 	.parse_pattern_action = iavf_ipsec_flow_parse,
 };
 
+static struct iavf_flow_parser iavf_ipsec_egress_flow_parser = {
+	.engine = &iavf_ipsec_egress_flow_engine,
+	.parse_pattern_action = iavf_ipsec_egress_flow_parse,
+};
+
 RTE_INIT(iavf_ipsec_flow_engine_register)
 {
 	iavf_register_flow_engine(&iavf_ipsec_flow_engine);
 }
+
+RTE_INIT(iavf_ipsec_egress_flow_engine_register)
+{
+	iavf_register_flow_engine(&iavf_ipsec_egress_flow_engine);
+}
-- 
2.52.0

