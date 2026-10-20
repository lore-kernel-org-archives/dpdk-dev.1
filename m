Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B551606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKi7Dtkr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CF0F406BC;
	Tue, 20 Oct 2026 14:11:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 948E34069D
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792498279; x=1824034279;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xoTLNZrrzDtMYTZ/WOfdhR+I9rlKkisYggpq6d9t6jc=;
 b=SKi7DtkrW1OPpFMGyvXHuOiq6mapUpm5mT2tPTjZarsIX5r5ni+XbzOj
 OrYacmtQ7uCj8luffesX/bZivW79EsafSPmH+ePT6C65b5v8e0dKrANXI
 iAB14H8GYKoutenmLrsRqXwo1GMV+lQrmJIeCKw5vD8lVO0TG6FgXc0v7
 JQXAZ3dFpQV4d4GAj+kLwzvkVXnHi6WvEE5ymxYK8S02bFCE5R6QlNHFs
 3c/zX67yoa/tlj39Dy0oip1YuBVdla6gFFf73CrIreJOwihWbUwnDc4CV
 HmjdOzcItrP0Xp11ewreKwG7PVLp1XY6lWLMVZ4Irj67quq+CoigNP9Kx g==;
X-CSE-ConnectionGUID: mdgMWZlqRBCCX82hYPCesw==
X-CSE-MsgGUID: n666UbLfTTahm6xB9rzQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1101792"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1101792"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 05:11:19 -0700
X-CSE-ConnectionGUID: eA9mZRwfQmiCazoYKGquUQ==
X-CSE-MsgGUID: cc180nMiQ9mkIe0KzVWmoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3253914"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2026 05:11:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 5/6] net/ice: use caller-owned pattern match storage
Date: Tue, 20 Oct 2026 13:11:08 +0100
Message-ID: <c28b60359f98c25af67e95d90d1f17d55d90309e.1792498154.git.anatoly.burakov@intel.com>
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

Pattern lookup allocates a match item just to copy an entry from the
engine's supported-pattern table. Each engine must then free this
temporary object after parsing.

Make `ice_search_pattern_match_item()` fill caller-provided storage
and return a status code. Use stack-local match items in all four
engines, removing the allocation and corresponding cleanup paths.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    | 22 ++++++++------------
 drivers/net/intel/ice/ice_fdir_filter.c   | 18 ++++++++--------
 drivers/net/intel/ice/ice_generic_flow.c  | 25 +++++------------------
 drivers/net/intel/ice/ice_generic_flow.h  |  3 ++-
 drivers/net/intel/ice/ice_hash.c          | 13 +++++-------
 drivers/net/intel/ice/ice_switch_filter.c | 14 +++++--------
 6 files changed, 34 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 91f684c9b9..fe1d03556c 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -998,7 +998,7 @@ ice_acl_parse(struct ice_adapter *ad,
 	};
 	struct ice_pf *pf = &ad->pf;
 	struct ice_acl_conf *filter = &pf->acl.conf;
-	struct ice_pattern_match_item *item = NULL;
+	struct ice_pattern_match_item item;
 	uint64_t input_set;
 	int ret;
 
@@ -1012,33 +1012,29 @@ ice_acl_parse(struct ice_adapter *ad,
 	if (ret)
 		return ret;
 
-	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
-					     error);
-	if (!item)
-		return -rte_errno;
+	ret = ice_search_pattern_match_item(ad, pattern, array, array_len,
+					     &item, error);
+	if (ret != 0)
+		return ret;
 
 	ret = ice_acl_parse_pattern(ad, pattern, error, filter);
 	if (ret)
-		goto error;
+		return ret;
 	input_set = filter->input_set;
-	if (!input_set || input_set & ~item->input_set_mask_o) {
-		rte_flow_error_set(error, EINVAL,
+	if (!input_set || input_set & ~item.input_set_mask_o) {
+		return rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
 				   pattern,
 				   "Invalid input set");
-		ret = -rte_errno;
-		goto error;
 	}
 
 	ret = ice_acl_parse_action(&parsed_actions, filter, error);
 	if (ret)
-		goto error;
+		return ret;
 
 	if (meta)
 		*meta = filter;
 
-error:
-	free(item);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index b1a8753e90..a4bb33264c 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -3023,7 +3023,7 @@ ice_fdir_parse(struct ice_adapter *ad,
 	};
 	struct ice_pf *pf = &ad->pf;
 	struct ice_fdir_filter_conf *filter = &pf->fdir.conf;
-	struct ice_pattern_match_item *item = NULL;
+	struct ice_pattern_match_item item;
 	uint64_t input_set;
 	bool raw = false;
 	int ret;
@@ -3038,17 +3038,17 @@ ice_fdir_parse(struct ice_adapter *ad,
 	if (ret)
 		return ret;
 
-	item = ice_search_pattern_match_item(ad, pattern, array, array_len,
-					     error);
+	ret = ice_search_pattern_match_item(ad, pattern, array, array_len,
+					     &item, error);
 
-	if (!item)
-		return -rte_errno;
+	if (ret != 0)
+		return ret;
 
 	ret = ice_fdir_parse_pattern(ad, pattern, error, filter);
 	if (ret)
 		goto error;
 
-	if (item->pattern_list[0] == RTE_FLOW_ITEM_TYPE_RAW)
+	if (item.pattern_list[0] == RTE_FLOW_ITEM_TYPE_RAW)
 		raw = true;
 
 	input_set = filter->input_set_o | filter->input_set_i;
@@ -3056,8 +3056,8 @@ ice_fdir_parse(struct ice_adapter *ad,
 
 	if (!input_set ||
 	    (filter->input_set_o &
-	     ~(item->input_set_mask_o | ICE_INSET_ETHERTYPE)) ||
-	    (filter->input_set_i & ~item->input_set_mask_i)) {
+	     ~(item.input_set_mask_o | ICE_INSET_ETHERTYPE)) ||
+	    (filter->input_set_i & ~item.input_set_mask_i)) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
 				   pattern,
@@ -3077,11 +3077,9 @@ ice_fdir_parse(struct ice_adapter *ad,
 		rte_free(filter->pkt_buf);
 	}
 
-	free(item);
 	return ret;
 error:
 	rte_free(filter->pkt_buf);
-	free(item);
 	return ret;
 }
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index ebe986c469..1a30327293 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2209,45 +2209,30 @@ ice_pattern_is_supported(__rte_unused struct ice_adapter *ad,
 	return false;
 }
 
-struct ice_pattern_match_item *
+int
 ice_search_pattern_match_item(struct ice_adapter *ad,
 			      const struct rte_flow_item pattern[],
 			      struct ice_pattern_match_item *array,
 			      uint32_t array_len,
+			      struct ice_pattern_match_item *match,
 			      struct rte_flow_error *error)
 {
-	struct ice_pattern_match_item *pattern_match_item;
 	uint16_t i = 0;
 
-	pattern_match_item = calloc(1, sizeof(struct ice_pattern_match_item));
-	if (!pattern_match_item) {
-		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
-				NULL, "Failed to allocate memory.");
-		return NULL;
-	}
-
 	if (!ice_pattern_is_supported(ad, pattern))
 		goto unsupported;
 
 	for (i = 0; i < array_len; i++) {
 		if (ice_match_pattern(array[i].pattern_list,
 				      pattern)) {
-			pattern_match_item->input_set_mask_o =
-				array[i].input_set_mask_o;
-			pattern_match_item->input_set_mask_i =
-				array[i].input_set_mask_i;
-			pattern_match_item->pattern_list =
-				array[i].pattern_list;
-			pattern_match_item->meta = array[i].meta;
-			return pattern_match_item;
+			*match = array[i];
+			return 0;
 		}
 	}
 
 unsupported:
-	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+	return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
 			   pattern, "Unsupported pattern");
-	free(pattern_match_item);
-	return NULL;
 }
 
 static bool
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 983f86a5ab..a801e0c704 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -583,11 +583,12 @@ ice_pattern_skip_void(const struct rte_flow_item *item)
 	     (item)->type != RTE_FLOW_ITEM_TYPE_END; \
 	     (item) = ice_pattern_skip_void((item) + 1))
 
-struct ice_pattern_match_item *
+int
 ice_search_pattern_match_item(struct ice_adapter *ad,
 			      const struct rte_flow_item pattern[],
 			      struct ice_pattern_match_item *array,
 			      uint32_t array_len,
+			      struct ice_pattern_match_item *match,
 			      struct rte_flow_error *error);
 int
 ice_flow_redirect(struct ice_adapter *ad,
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 13bedfe90c..21545efefd 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -1201,7 +1201,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 		.check = ice_hash_parse_action_check,
 	};
 	const struct rte_flow_action_rss *rss;
-	struct ice_pattern_match_item *pattern_match_item;
+	struct ice_pattern_match_item pattern_match_item;
 	struct ice_rss_meta *rss_meta_ptr;
 	uint64_t phint = ICE_PHINT_NONE;
 	int ret = 0;
@@ -1223,12 +1223,10 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	}
 
 	/* Check rss supported pattern and find matched pattern. */
-	pattern_match_item = ice_search_pattern_match_item(ad, pattern, array,
-							   array_len, error);
-	if (!pattern_match_item) {
-		ret = -rte_errno;
+	ret = ice_search_pattern_match_item(ad, pattern, array, array_len,
+					   &pattern_match_item, error);
+	if (ret != 0)
 		goto error;
-	}
 
 	ret = ice_hash_parse_pattern(pattern, &phint, error);
 	if (ret)
@@ -1248,7 +1246,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	}
 
 	rss = parsed_actions.actions[0]->conf;
-	ret = ice_hash_parse_rss_action(pattern_match_item, rss, phint,
+	ret = ice_hash_parse_rss_action(&pattern_match_item, rss, phint,
 				rss_meta_ptr, error);
 
 error:
@@ -1256,7 +1254,6 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 		*meta = rss_meta_ptr;
 	else
 		rte_free(rss_meta_ptr);
-	free(pattern_match_item);
 
 	return ret;
 }
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 6bc1bdd09f..5c34089b40 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -1755,7 +1755,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	uint16_t vlan_num = 0;
 	enum ice_sw_tunnel_type tun_type =
 			ICE_NON_TUN;
-	struct ice_pattern_match_item *pattern_match_item = NULL;
+	struct ice_pattern_match_item pattern_match_item;
 	struct ci_flow_attr_check_param attr_param = {
 		.allow_priority = true,
 	};
@@ -1848,10 +1848,9 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		goto error;
 	}
 
-	pattern_match_item =
-		ice_search_pattern_match_item(ad, pattern, array, array_len,
-					      error);
-	if (!pattern_match_item) {
+	ret = ice_search_pattern_match_item(ad, pattern, array, array_len,
+					    &pattern_match_item, error);
+	if (ret != 0) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Invalid input pattern");
@@ -1859,7 +1858,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 	}
 
 	if (!ice_switch_parse_pattern(pattern, error, list, &lkups_num,
-				   &tun_type, pattern_match_item)) {
+				   &tun_type, &pattern_match_item)) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
 				   pattern,
@@ -1890,14 +1889,11 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		rte_free(sw_meta_ptr);
 	}
 
-	free(pattern_match_item);
-
 	return 0;
 
 error:
 	rte_free(list);
 	rte_free(sw_meta_ptr);
-	free(pattern_match_item);
 
 	return -rte_errno;
 }
-- 
2.52.0

