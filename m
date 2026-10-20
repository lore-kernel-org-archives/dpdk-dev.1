Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39989606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XeL7qR8r
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0872540A71;
	Tue, 20 Oct 2026 14:11:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id F0F284069D
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498281; x=1824034281;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ddbUy+C3uCZJJenlEaDvnfsLY4MTjQH+HRr6F0k6Gq0=;
 b=XeL7qR8ru38S0kZ00c56SID4/+R5/rMG0yDACjQBrJZWjSX1u1ItR9Nh
 a8oN9X2SEMMJhVztPAh8jME64yEeD2NiQlCSVIKt6LOn4tjrlVpS2nUzc
 v4ZCZiJLJdtK0nIQhWNzF1Ou2SgbPRlWoTVF/pKfVqpP8CxUXt6/CUZJl
 JAXxnOEbwouDBIBb1s/lqsgPDwm12vVibknCltcTUdUi6aJxNzSDO5MB2
 d4R1VJ+0t2srCWE+iEc8zL7k4BLbALPytOJ1MI3FDl9W3YAxlyEpOuL3p
 ZoU37wiBNMu1guq+A9vEci3ketaVd+8xv7z1ZNlNn3g1yPPQqiKeW+RxO A==;
X-CSE-ConnectionGUID: hRv8ElPmQsawQfEVrJBFnQ==
X-CSE-MsgGUID: +8RW+v3zTsmMDTiCDldfWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101795"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101795"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:20 -0700
X-CSE-ConnectionGUID: 1gck9i73RrqOuYy1BpA4LA==
X-CSE-MsgGUID: +Y4z0BZeTqK7U2Nc48Dqlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253923"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:20 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 6/6] net/ice: centralize flow rule memory management
Date: Tue, 20 Oct 2026 13:11:09 +0100
Message-ID: <eaf28172b00a9599520cd3c8dd6ed29ca5a0e7cf.1792498154.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792498154.git.anatoly.burakov@intel.com>
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

Flow engines manage rule memory independently, with parsers returning
either temporary metadata or shared scratch storage. This spreads
ownership and cleanup across parsing, creation, destruction and
uninitialization across the flow infrastructure, which is difficult to
verify, reason about, and may have hidden bugs.

Make parsers allocate the final rule and transfer ownership to the
generic flow layer on success. Free rules centrally after validation,
failed creation, successful destruction and uninitialization, retaining
them when destruction fails. Parsers clean up their own allocations on
failure.

Some engines, in addition to the rule itself, will also allocate additional
data for the flow (e.g. RAW pattern buffer in FDIR engine). We can make the
flow memory management centralized in generic flow, but this additional
data is engine-specific, so use the `free` callbacks to release only said
additional flow data. Remove the RSS and ACL callbacks, the FDIR and ACL
scratch storage, and the redundant allocations and copies during rule
creation, and use stack storage where appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    | 77 +++++++--------------
 drivers/net/intel/ice/ice_ethdev.h        |  2 -
 drivers/net/intel/ice/ice_fdir_filter.c   | 82 ++++++++---------------
 drivers/net/intel/ice/ice_generic_flow.c  | 29 ++++++--
 drivers/net/intel/ice/ice_generic_flow.h  |  8 ++-
 drivers/net/intel/ice/ice_hash.c          | 68 +++++--------------
 drivers/net/intel/ice/ice_switch_filter.c | 75 +++++----------------
 7 files changed, 117 insertions(+), 224 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index fe1d03556c..9414bb3f12 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -46,6 +46,7 @@
 	ICE_INSET_SCTP_SRC_PORT | ICE_INSET_SCTP_DST_PORT)
 
 struct acl_rule {
+	struct ice_acl_conf conf;
 	enum ice_fltr_ptype flow_type;
 	uint64_t entry_id[4];
 };
@@ -504,42 +505,24 @@ ice_acl_hw_rem_conf(struct ice_pf *pf, struct acl_rule *rule, int32_t entry_idx)
 
 static int
 ice_acl_create_filter(struct ice_adapter *ad,
-		      struct rte_flow *flow,
+		      struct rte_flow *flow __rte_unused,
 		      void *meta,
 		      struct rte_flow_error *error)
 {
-	struct ice_acl_conf *filter = meta;
+	struct acl_rule *rule = meta;
+	struct ice_acl_conf *filter = &rule->conf;
 	enum ice_fltr_ptype flow_type = filter->input.flow_type;
 	struct ice_flow_action acts[1];
 	struct ice_pf *pf = &ad->pf;
-	struct ice_fdir_fltr *input;
-	struct acl_rule *rule;
+	struct ice_fdir_fltr input_buf = {0};
+	struct ice_fdir_fltr *input = &input_buf;
 	int ret;
 
-	rule = rte_zmalloc("acl_rule", sizeof(*rule), 0);
-	if (!rule) {
-		rte_flow_error_set(error, ENOMEM,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to allocate memory for acl rule");
-		return -rte_errno;
-	}
-
-	input = rte_zmalloc("acl_entry", sizeof(*input), 0);
-	if (!input) {
-		rte_flow_error_set(error, ENOMEM,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to allocate memory for acl input");
-		ret = -rte_errno;
-		goto err_acl_input_alloc;
-	}
-
 	ret = ice_acl_set_input_set(filter, input);
 	if (ret) {
-		rte_flow_error_set(error, -ret,
+		return rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "failed to set input set.");
-		ret = -rte_errno;
-		goto err_acl_set_input;
 	}
 
 	if (filter->input.dest_ctl == ICE_FLTR_PRGM_DESC_DEST_DROP_PKT) {
@@ -558,11 +541,9 @@ ice_acl_create_filter(struct ice_adapter *ad,
 	input->acl_fltr = true;
 	ret = ice_acl_hw_set_conf(pf, input, acts, rule, flow_type, 0);
 	if (ret) {
-		rte_flow_error_set(error, -ret,
+		return rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "failed to set hw configure.");
-		ret = -rte_errno;
-		return ret;
 	}
 
 	if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER ||
@@ -582,7 +563,6 @@ ice_acl_create_filter(struct ice_adapter *ad,
 	}
 
 	rule->flow_type = flow_type;
-	flow->rule = rule;
 	return 0;
 
 err_acl_hw_set_conf_sctp:
@@ -591,10 +571,6 @@ ice_acl_create_filter(struct ice_adapter *ad,
 	ice_acl_hw_rem_conf(pf, rule, 2);
 err_acl_hw_set_conf_udp:
 	ice_acl_hw_rem_conf(pf, rule, 1);
-err_acl_set_input:
-	rte_free(input);
-err_acl_input_alloc:
-	rte_free(rule);
 	return ret;
 }
 
@@ -635,18 +611,9 @@ ice_acl_destroy_filter(struct ice_adapter *ad,
 		break;
 	}
 
-	flow->rule = NULL;
-	rte_free(rule);
 	return ret;
 }
 
-static void
-ice_acl_filter_free(struct rte_flow *flow)
-{
-	rte_free(flow->rule);
-	flow->rule = NULL;
-}
-
 static int
 ice_acl_parse_pattern(__rte_unused struct ice_adapter *ad,
 		       const struct rte_flow_item pattern[],
@@ -996,14 +963,12 @@ ice_acl_parse(struct ice_adapter *ad,
 		.check = ice_acl_parse_action_check,
 		.driver_ctx = ad,
 	};
-	struct ice_pf *pf = &ad->pf;
-	struct ice_acl_conf *filter = &pf->acl.conf;
+	struct acl_rule *rule;
+	struct ice_acl_conf *filter;
 	struct ice_pattern_match_item item;
 	uint64_t input_set;
 	int ret;
 
-	memset(filter, 0, sizeof(*filter));
-
 	ret = ci_flow_check_attr(attr, NULL, error);
 	if (ret)
 		return ret;
@@ -1017,24 +982,35 @@ ice_acl_parse(struct ice_adapter *ad,
 	if (ret != 0)
 		return ret;
 
+	rule = rte_zmalloc("acl_rule", sizeof(*rule), 0);
+	if (rule == NULL) {
+		return rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to allocate memory for acl rule");
+	}
+	filter = &rule->conf;
+
 	ret = ice_acl_parse_pattern(ad, pattern, error, filter);
 	if (ret)
-		return ret;
+		goto error;
 	input_set = filter->input_set;
 	if (!input_set || input_set & ~item.input_set_mask_o) {
-		return rte_flow_error_set(error, EINVAL,
+		ret = rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
 				   pattern,
 				   "Invalid input set");
+		goto error;
 	}
 
 	ret = ice_acl_parse_action(&parsed_actions, filter, error);
 	if (ret)
-		return ret;
+		goto error;
 
-	if (meta)
-		*meta = filter;
+	*meta = rule;
+	return 0;
 
+error:
+	rte_free(rule);
 	return ret;
 }
 
@@ -1122,7 +1098,6 @@ ice_flow_engine ice_acl_engine = {
 	.uninit = ice_acl_uninit,
 	.create = ice_acl_create_filter,
 	.destroy = ice_acl_destroy_filter,
-	.free = ice_acl_filter_free,
 	.name = "acl",
 	.type = ICE_FLOW_ENGINE_ACL,
 	.rule_size = sizeof(struct acl_rule),
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index b802588b40..1baec0f97c 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -465,7 +465,6 @@ struct ice_fdir_info {
 	void *prg_pkt;                 /* memory for fdir program packet */
 	uint64_t dma_addr;             /* physic address of packet memory*/
 	const struct rte_memzone *mz;
-	struct ice_fdir_filter_conf conf;
 
 	struct ice_fdir_filter_conf **hash_map;
 	struct rte_hash *hash_table;
@@ -502,7 +501,6 @@ struct ice_acl_conf {
  * A structure used to define fields of ACL related info.
  */
 struct ice_acl_info {
-	struct ice_acl_conf conf;
 	struct rte_bitmap *slots;
 	uint64_t hw_entry_id[MAX_ACL_NORMAL_ENTRIES];
 };
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index a4bb33264c..f4c886dded 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1537,14 +1537,14 @@ ice_fdir_entry_del(struct ice_pf *pf, struct ice_fdir_fltr_pattern *key)
 
 static int
 ice_fdir_create_filter(struct ice_adapter *ad,
-		       struct rte_flow *flow,
+		       struct rte_flow *flow __rte_unused,
 		       void *meta,
 		       struct rte_flow_error *error)
 {
 	struct ice_pf *pf = &ad->pf;
 	struct ice_fdir_filter_conf *filter = meta;
 	struct ice_fdir_info *fdir_info = &pf->fdir;
-	struct ice_fdir_filter_conf *entry, *node;
+	struct ice_fdir_filter_conf *node;
 	struct ice_fdir_fltr_pattern key;
 	bool is_tun;
 	int ret;
@@ -1579,12 +1579,12 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 			ret = ice_flow_set_hw_prof(hw, main_vsi, ctrl_vsi,
 						   &filter->prof, ICE_BLK_FD);
 			if (ret)
-				goto error;
+				return -rte_errno;
 		}
 
 		ret = ice_fdir_add_del_raw(pf, filter, true);
 		if (ret)
-			goto error;
+			return -rte_errno;
 
 		if (!fv_found) {
 			for (i = 0; i < filter->prof.fv_num; i++) {
@@ -1600,14 +1600,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		if (filter->mark_flag == 1)
 			ice_fdir_rx_parsing_enable(ad, 1);
 
-		entry = rte_zmalloc("fdir_entry", sizeof(*entry), 0);
-		if (!entry)
-			goto error;
-
-		memcpy(entry, filter, sizeof(*filter));
-
-		flow->rule = entry;
-
 		return 0;
 	}
 
@@ -1620,14 +1612,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		return -rte_errno;
 	}
 
-	entry = rte_zmalloc("fdir_entry", sizeof(*entry), 0);
-	if (!entry) {
-		rte_flow_error_set(error, ENOMEM,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "Failed to allocate memory");
-		return -rte_errno;
-	}
-
 	is_tun = ice_fdir_is_tunnel_profile(filter->tunnel_type);
 
 	ret = ice_fdir_input_set_conf(pf, filter->input.flow_type,
@@ -1637,7 +1621,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Profile configure failed.");
-		goto free_entry;
+		return -rte_errno;
 	}
 
 	/* alloc counter for FDIR */
@@ -1649,13 +1633,13 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 			rte_flow_error_set(error, EINVAL,
 					RTE_FLOW_ERROR_TYPE_ACTION, NULL,
 					"Failed to alloc FDIR counter.");
-			goto free_entry;
+			return -rte_errno;
 		}
 		filter->input.cnt_index = filter->counter->hw_index;
 	}
 
 	/* Reserve the software entry before installing the hardware rule. */
-	ret = ice_fdir_entry_insert(pf, entry, &key);
+	ret = ice_fdir_entry_insert(pf, filter, &key);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
@@ -1675,8 +1659,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 	if (filter->mark_flag == 1)
 		ice_fdir_rx_parsing_enable(ad, 1);
 
-	memcpy(entry, filter, sizeof(*entry));
-	flow->rule = entry;
 	ice_fdir_cnt_update(pf, filter->input.flow_type, is_tun, true);
 
 	return 0;
@@ -1687,12 +1669,6 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		filter->counter = NULL;
 	}
 
-free_entry:
-	rte_free(entry);
-	return -rte_errno;
-
-error:
-	rte_free(filter->pkt_buf);
 	return -rte_errno;
 }
 
@@ -1739,11 +1715,6 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 		if (filter->mark_flag == 1)
 			ice_fdir_rx_parsing_enable(ad, 0);
 
-		flow->rule = NULL;
-
-		rte_free(filter->pkt_buf);
-		rte_free(filter);
-
 		return 0;
 	}
 
@@ -1795,13 +1766,17 @@ ice_fdir_destroy_filter(struct ice_adapter *ad,
 	if (filter->mark_flag == 1)
 		ice_fdir_rx_parsing_enable(ad, 0);
 
-	flow->rule = NULL;
-
-	rte_free(filter);
-
 	return 0;
 }
 
+static void
+ice_fdir_filter_free(void *rule)
+{
+	struct ice_fdir_filter_conf *filter = rule;
+
+	rte_free(filter->pkt_buf);
+}
+
 static int
 ice_fdir_query_count(struct ice_adapter *ad,
 		      struct rte_flow *flow,
@@ -1850,6 +1825,7 @@ static struct ice_flow_engine ice_fdir_engine = {
 	.create = ice_fdir_create_filter,
 	.destroy = ice_fdir_destroy_filter,
 	.query_count = ice_fdir_query_count,
+	.free = ice_fdir_filter_free,
 	.name = "fdir",
 	.type = ICE_FLOW_ENGINE_FDIR,
 	.rule_size = sizeof(struct ice_fdir_filter_conf),
@@ -2814,12 +2790,10 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 }
 
 static int
-ice_fdir_parse_action(struct ice_adapter *ad,
+ice_fdir_parse_action(struct ice_fdir_filter_conf *filter,
 		const struct ci_flow_actions *actions,
 		struct rte_flow_error *error)
 {
-	struct ice_pf *pf = &ad->pf;
-	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
 	bool dest_set = false;
 	size_t i;
 
@@ -3021,8 +2995,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 		.driver_ctx = ad,
 		.rss_queues_contig = true,
 	};
-	struct ice_pf *pf = &ad->pf;
-	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
+	struct ice_fdir_filter_conf *filter;
 	struct ice_pattern_match_item item;
 	uint64_t input_set;
 	bool raw = false;
@@ -3032,8 +3005,6 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret)
 		return ret;
 
-	memset(filter, 0, sizeof(*filter));
-
 	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
 	if (ret)
 		return ret;
@@ -3044,6 +3015,13 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret != 0)
 		return ret;
 
+	filter = rte_zmalloc("ice_fdir_rule", sizeof(*filter), 0);
+	if (filter == NULL) {
+		return rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to allocate FDIR rule");
+	}
+
 	ret = ice_fdir_parse_pattern(ad, pattern, error, filter);
 	if (ret)
 		goto error;
@@ -3066,20 +3044,16 @@ ice_fdir_parse(struct ice_adapter *ad,
 		goto error;
 	}
 
-	ret = ice_fdir_parse_action(ad, &parsed_actions, error);
+	ret = ice_fdir_parse_action(filter, &parsed_actions, error);
 	if (ret)
 		goto error;
 
-	/* if meta is NULL we're validating so the flow won't be stored */
-	if (meta) {
-		*meta = filter;
-	} else if (filter->pkt_buf != NULL) {
-		rte_free(filter->pkt_buf);
-	}
+	*meta = filter;
 
 	return ret;
 error:
 	rte_free(filter->pkt_buf);
+	rte_free(filter);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 1a30327293..25aa7aa41e 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2020,6 +2020,14 @@ ice_flow_init(struct ice_adapter *ad)
 	return 0;
 }
 
+static void
+ice_flow_rule_free(struct ice_flow_engine *engine, void *rule)
+{
+	if (engine->free != NULL)
+		engine->free(rule);
+	rte_free(rule);
+}
+
 void
 ice_flow_uninit(struct ice_adapter *ad)
 {
@@ -2041,8 +2049,7 @@ ice_flow_uninit(struct ice_adapter *ad)
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&pf->flow_list))) {
 		TAILQ_REMOVE(&pf->flow_list, p_flow, node);
-		if (p_flow->engine->free)
-			p_flow->engine->free(p_flow);
+		ice_flow_rule_free(p_flow->engine, p_flow->rule);
 		rte_free(p_flow);
 	}
 
@@ -2262,7 +2269,13 @@ ice_parse_engine_create(struct ice_adapter *ad,
 
 	RTE_ASSERT(parser->engine->create != NULL);
 
-	return parser->engine->create(ad, flow, meta, error) == 0;
+	if (parser->engine->create(ad, flow, meta, error) != 0) {
+		ice_flow_rule_free(parser->engine, meta);
+		return false;
+	}
+
+	flow->rule = meta;
+	return true;
 }
 
 static bool
@@ -2274,6 +2287,8 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
+	void *meta = NULL;
+	int ret;
 
 	if (ICE_FLOW_ENGINE_DISABLED(ad->disabled_engine_mask,
 				     parser->engine->type)) {
@@ -2283,11 +2298,14 @@ ice_parse_engine_validate(struct ice_adapter *ad,
 		return false;
 	}
 
-	return parser->parse_pattern_action(ad,
+	ret = parser->parse_pattern_action(ad,
 					    parser->array,
 					    parser->array_len,
 					    pattern, actions, attr,
-					    NULL, error) >= 0;
+					    &meta, error);
+	if (ret >= 0)
+		ice_flow_rule_free(parser->engine, meta);
+	return ret >= 0;
 }
 
 static struct ice_flow_parser *get_flow_parser(uint32_t group)
@@ -2447,6 +2465,7 @@ ice_flow_destroy(struct rte_eth_dev *dev,
 	ret = flow->engine->destroy(ad, flow, error);
 	if (!ret) {
 		TAILQ_REMOVE(&pf->flow_list, flow, node);
+		ice_flow_rule_free(flow->engine, flow->rule);
 		rte_free(flow);
 	} else {
 		PMD_DRV_LOG(ERR, "Failed to destroy flow");
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index a801e0c704..efb3ee9b69 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -519,7 +519,13 @@ typedef int (*engine_query_t)(struct ice_adapter *ad,
 typedef int(*engine_redirect_t)(struct ice_adapter *ad,
 				struct rte_flow *flow,
 				struct ice_flow_redirect *redirect);
-typedef void (*engine_free_t) (struct rte_flow *flow);
+/* Free nested rule allocations only, without accessing hardware resources. */
+typedef void (*engine_free_t)(void *rule);
+/*
+ * Parsers return an allocated final rule through meta on success, and clean up
+ * their own allocations on failure. The generic layer owns successful results,
+ * including during validation; engine create/destroy callbacks must not free them.
+ */
 typedef int (*parse_pattern_action_t)(struct ice_adapter *ad,
 		struct ice_pattern_match_item *array,
 		uint32_t array_len,
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 21545efefd..fe66b1dd5a 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -72,12 +72,6 @@
 				 RTE_ETH_RSS_L3_PRE56	| \
 				 RTE_ETH_RSS_L3_PRE96)
 
-struct ice_rss_meta {
-	uint8_t hash_function;
-	struct ice_rss_hash_cfg cfg;
-	struct ice_rss_raw_cfg raw;
-};
-
 struct ice_hash_flow_cfg {
 	bool simple_xor;
 	struct ice_rss_cfg rss_cfg;
@@ -100,9 +94,6 @@ ice_hash_destroy(struct ice_adapter *ad,
 static void
 ice_hash_uninit(struct ice_adapter *ad);
 
-static void
-ice_hash_free(struct rte_flow *flow);
-
 static int
 ice_hash_parse_pattern_action(struct ice_adapter *ad,
 			struct ice_pattern_match_item *array,
@@ -590,7 +581,6 @@ static struct ice_flow_engine ice_hash_engine = {
 	.create = ice_hash_create,
 	.destroy = ice_hash_destroy,
 	.uninit = ice_hash_uninit,
-	.free = ice_hash_free,
 	.name = "hash",
 	.type = ICE_FLOW_ENGINE_HASH,
 	.rule_size = sizeof(struct ice_hash_flow_cfg),
@@ -667,7 +657,7 @@ static int
 ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 				const struct rte_flow_item *item,
 				struct rte_flow_error *error,
-				struct ice_rss_meta *meta)
+				struct ice_hash_flow_cfg *meta)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
 	struct ice_parser_profile prof;
@@ -755,7 +745,7 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	if (ret)
 		goto free_mem;
 
-	memcpy(&meta->raw.prof, &prof, sizeof(prof));
+	memcpy(&meta->rss_cfg.raw.prof, &prof, sizeof(prof));
 
 free_mem:
 	free(pkt_buf);
@@ -1133,7 +1123,7 @@ ice_hash_parse_action_check(const struct ci_flow_actions *actions,
 static int
 ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 		const struct rte_flow_action_rss *rss,
-		uint64_t pattern_hint, struct ice_rss_meta *rss_meta,
+		uint64_t pattern_hint, struct ice_hash_flow_cfg *rss_meta,
 		struct rte_flow_error *error)
 {
 	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
@@ -1146,18 +1136,17 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
 					"XOR hash function is only supported for empty pattern");
 		}
-		rss_meta->hash_function = RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
+		rss_meta->simple_xor = true;
 		return 0;
 	}
 
 	if (rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
-		rss_meta->hash_function = RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ;
 		symm = true;
 	}
 
 	/* If pattern type is raw, no need to refine rss type */
 	if (pattern_hint == ICE_PHINT_RAW) {
-		rss_meta->raw.symm = symm;
+		rss_meta->rss_cfg.raw.symm = symm;
 		return 0;
 	}
 	cfg->symm = symm;
@@ -1174,8 +1163,8 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				rss, "RSS type not supported");
 
-	rss_meta->cfg = *cfg;
-	ice_refine_hash_cfg(&rss_meta->cfg,
+	rss_meta->rss_cfg.hash = *cfg;
+	ice_refine_hash_cfg(&rss_meta->rss_cfg.hash,
 			    rss_type, pattern_hint);
 
 	return 0;
@@ -1202,7 +1191,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	};
 	const struct rte_flow_action_rss *rss;
 	struct ice_pattern_match_item pattern_match_item;
-	struct ice_rss_meta *rss_meta_ptr;
+	struct ice_hash_flow_cfg *rss_meta_ptr;
 	uint64_t phint = ICE_PHINT_NONE;
 	int ret = 0;
 
@@ -1235,7 +1224,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	if (phint == ICE_PHINT_RAW) {
 		const struct rte_flow_item *raw_item = ice_pattern_skip_void(pattern);
 
-		rss_meta_ptr->raw.raw_ena = true;
+		rss_meta_ptr->rss_cfg.raw.raw_ena = true;
 		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_meta_ptr);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
@@ -1250,7 +1239,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 				rss_meta_ptr, error);
 
 error:
-	if (!ret && meta)
+	if (!ret)
 		*meta = rss_meta_ptr;
 	else
 		rte_free(rss_meta_ptr);
@@ -1325,7 +1314,7 @@ ice_hash_add_raw_cfg(struct ice_adapter *ad,
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		struct rte_flow *flow,
+		struct rte_flow *flow __rte_unused,
 		void *meta,
 		struct rte_flow_error *error)
 {
@@ -1334,33 +1323,19 @@ ice_hash_create(struct ice_adapter *ad,
 	struct ice_vsi *vsi = pf->main_vsi;
 	int ret;
 	uint32_t reg;
-	struct ice_hash_flow_cfg *filter_ptr;
-	struct ice_rss_meta *rss_meta = (struct ice_rss_meta *)meta;
-	uint8_t hash_function = rss_meta->hash_function;
+	struct ice_hash_flow_cfg *filter_ptr = meta;
 
-	filter_ptr = rte_zmalloc("ice_rss_filter",
-				sizeof(struct ice_hash_flow_cfg), 0);
-	if (!filter_ptr) {
-		rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"No memory for filter_ptr");
-		return -ENOMEM;
-	}
-
-	if (hash_function == RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
+	if (filter_ptr->simple_xor) {
 		/* Enable registers for simple_xor hash function. */
 		reg = ICE_READ_REG(hw, VSIQF_HASH_CTL(vsi->vsi_id));
 		reg = (reg & (~VSIQF_HASH_CTL_HASH_SCHEME_M)) |
 			(2 << VSIQF_HASH_CTL_HASH_SCHEME_S);
 		ICE_WRITE_REG(hw, VSIQF_HASH_CTL(vsi->vsi_id), reg);
 
-		filter_ptr->simple_xor = 1;
-
 		goto out;
 	} else {
-		if (rss_meta->raw.raw_ena) {
-			filter_ptr->rss_cfg.raw = rss_meta->raw;
-			ret = ice_hash_add_raw_cfg(ad, &rss_meta->raw,
+		if (filter_ptr->rss_cfg.raw.raw_ena) {
+			ret = ice_hash_add_raw_cfg(ad, &filter_ptr->rss_cfg.raw,
 						   pf->main_vsi->idx);
 			if (ret) {
 				rte_flow_error_set(error, EINVAL,
@@ -1370,7 +1345,6 @@ ice_hash_create(struct ice_adapter *ad,
 				goto error;
 			}
 		} else {
-			filter_ptr->rss_cfg.hash = rss_meta->cfg;
 			ret = ice_add_rss_cfg_wrap(pf, vsi->idx,
 						   &filter_ptr->rss_cfg.hash);
 			if (ret) {
@@ -1384,13 +1358,9 @@ ice_hash_create(struct ice_adapter *ad,
 	}
 
 out:
-	flow->rule = filter_ptr;
-	rte_free(meta);
 	return 0;
 
 error:
-	rte_free(filter_ptr);
-	rte_free(meta);
 	return -rte_errno;
 }
 
@@ -1483,11 +1453,9 @@ ice_hash_destroy(struct ice_adapter *ad,
 		}
 	}
 
-	rte_free(filter_ptr);
 	return 0;
 
 error:
-	rte_free(filter_ptr);
 	return -rte_errno;
 }
 
@@ -1495,9 +1463,3 @@ static void
 ice_hash_uninit(struct ice_adapter *ad __rte_unused)
 {
 }
-
-static void
-ice_hash_free(struct rte_flow *flow)
-{
-	rte_free(flow->rule);
-}
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 5c34089b40..4dd4707c40 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -178,12 +178,6 @@
 	ICE_SW_INSET_GTPU_IPV6 | ICE_INSET_TCP_SRC_PORT | \
 	ICE_INSET_TCP_DST_PORT)
 
-struct sw_meta {
-	struct ice_adv_lkup_elem *list;
-	uint16_t lkups_num;
-	struct ice_adv_rule_info rule_info;
-};
-
 enum ice_sw_fltr_status {
 	ICE_SW_FLTR_ADDED,
 	ICE_SW_FLTR_RMV_FAILED_ON_RIDRECT,
@@ -291,7 +285,7 @@ ice_pattern_match_item ice_switch_supported_pattern[] = {
 
 static int
 ice_switch_create(struct ice_adapter *ad,
-		struct rte_flow *flow,
+		struct rte_flow *flow __rte_unused,
 		void *meta,
 		struct rte_flow_error *error)
 {
@@ -299,13 +293,10 @@ ice_switch_create(struct ice_adapter *ad,
 	struct ice_pf *pf = &ad->pf;
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 	struct ice_rule_query_data rule_added = {0};
-	struct ice_switch_filter_conf *filter_conf_ptr;
-	struct ice_adv_lkup_elem *list =
-		((struct sw_meta *)meta)->list;
-	uint16_t lkups_cnt =
-		((struct sw_meta *)meta)->lkups_num;
-	struct ice_adv_rule_info *rule_info =
-		&((struct sw_meta *)meta)->rule_info;
+	struct ice_switch_filter_conf *filter_conf_ptr = meta;
+	struct ice_adv_lkup_elem *list = filter_conf_ptr->lkups;
+	uint16_t lkups_cnt = filter_conf_ptr->lkups_num;
+	struct ice_adv_rule_info *rule_info = &filter_conf_ptr->rule_info;
 
 	if (lkups_cnt > ICE_MAX_CHAIN_WORDS) {
 		rte_flow_error_set(error, EINVAL,
@@ -329,26 +320,11 @@ ice_switch_create(struct ice_adapter *ad,
 
 	ret = ice_add_adv_rule(hw, list, lkups_cnt, rule_info, &rule_added);
 	if (!ret) {
-		filter_conf_ptr = rte_zmalloc("ice_switch_filter",
-			sizeof(struct ice_switch_filter_conf), 0);
-		if (!filter_conf_ptr) {
-			rte_flow_error_set(error, EINVAL,
-				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "No memory for ice_switch_filter");
-			goto error;
-		}
-
 		filter_conf_ptr->sw_query_data = rule_added;
 
 		filter_conf_ptr->vsi_num =
 			ice_get_hw_vsi_num(hw, rule_info->sw_act.vsi_handle);
-		filter_conf_ptr->lkups = list;
-		filter_conf_ptr->lkups_num = lkups_cnt;
-		filter_conf_ptr->rule_info = *rule_info;
-
 		filter_conf_ptr->fltr_status = ICE_SW_FLTR_ADDED;
-
-		flow->rule = filter_conf_ptr;
 	} else {
 		if (ice_dcf_adminq_need_retry(ad))
 			ret = -EAGAIN;
@@ -361,26 +337,18 @@ ice_switch_create(struct ice_adapter *ad,
 		goto error;
 	}
 
-	rte_free(meta);
 	return 0;
 
 error:
-	rte_free(list);
-	rte_free(meta);
-
 	return -rte_errno;
 }
 
 static inline void
-ice_switch_filter_rule_free(struct rte_flow *flow)
+ice_switch_filter_rule_free(void *rule)
 {
-	struct ice_switch_filter_conf *filter_conf_ptr =
-		(struct ice_switch_filter_conf *)flow->rule;
+	struct ice_switch_filter_conf *filter_conf_ptr = rule;
 
-	if (filter_conf_ptr)
-		rte_free(filter_conf_ptr->lkups);
-
-	rte_free(filter_conf_ptr);
+	rte_free(filter_conf_ptr->lkups);
 }
 
 static int
@@ -402,8 +370,6 @@ ice_switch_destroy(struct ice_adapter *ad,
 			"no such flow"
 			" create by switch filter");
 
-		ice_switch_filter_rule_free(flow);
-
 		return -rte_errno;
 	}
 
@@ -427,7 +393,6 @@ ice_switch_destroy(struct ice_adapter *ad,
 		return -rte_errno;
 	}
 
-	ice_switch_filter_rule_free(flow);
 	return ret;
 }
 
@@ -1746,7 +1711,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 {
 	struct ice_pf *pf = &ad->pf;
 	int ret = 0;
-	struct sw_meta *sw_meta_ptr = NULL;
+	struct ice_switch_filter_conf *filter = NULL;
 	struct ice_adv_rule_info rule_info;
 	struct ice_adv_lkup_elem *list = NULL;
 	uint16_t lkups_num = 0;
@@ -1839,12 +1804,11 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		return -rte_errno;
 	}
 
-	sw_meta_ptr =
-		rte_zmalloc(NULL, sizeof(*sw_meta_ptr), 0);
-	if (!sw_meta_ptr) {
+	filter = rte_zmalloc("ice_switch_filter", sizeof(*filter), 0);
+	if (filter == NULL) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				   "No memory for sw_pattern_meta_ptr");
+				   "No memory for ice_switch_filter");
 		goto error;
 	}
 
@@ -1879,21 +1843,16 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	if (ret)
 		goto error;
 
-	if (meta) {
-		*meta = sw_meta_ptr;
-		((struct sw_meta *)*meta)->list = list;
-		((struct sw_meta *)*meta)->lkups_num = lkups_num;
-		((struct sw_meta *)*meta)->rule_info = rule_info;
-	} else {
-		rte_free(list);
-		rte_free(sw_meta_ptr);
-	}
+	filter->lkups = list;
+	filter->lkups_num = lkups_num;
+	filter->rule_info = rule_info;
+	*meta = filter;
 
 	return 0;
 
 error:
 	rte_free(list);
-	rte_free(sw_meta_ptr);
+	rte_free(filter);
 
 	return -rte_errno;
 }
-- 
2.52.0

