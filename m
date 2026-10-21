Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D4F606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aKk5y/9D
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD0A40B91;
	Wed, 21 Oct 2026 12:52:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0779740A7D
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792579976; x=1824115976;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6iWHSG/gGwIE+eSSm9F9duuzLCMagD/NBWQ7Wi9laNs=;
 b=aKk5y/9DFFQ+cmP+6Zk21cqml9HXPRVh/m5fZ7/FnMLaWCPVPRYbaQQi
 ZJlSrF5TpHjCOw75t+9k9iLCvQBJtrFpVzqkA+VJ4sKqKoG82DtkSzr2M
 PX47KFrclEeYD9qOKpShQsxX1HD3MJ8cUIYeo9ZGKSv9SlkpgEO23ktFH
 n/957iHFC5SyCGnlAh35MiNz/mpsBxlJ+mk/5HPCPAfJABL/GG6E6lnhN
 uB1EFB/vtl9DKB0xtVXq5N0CL7bg61wKd+8ZceNIkoNL/eijvBDCYzzUA
 6u8NZGh6GzP7RuJpN0j0QilFJbH+emtAv6Z/TDfn5qgCGhUtWROeWaFso g==;
X-CSE-ConnectionGUID: PUeDxfxVQh2H9VvbjDbVtA==
X-CSE-MsgGUID: NKR1kpZBQ0OczIiPPQsDmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1301050"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1301050"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:52:55 -0700
X-CSE-ConnectionGUID: HU+cpezOSB2XTXrTy8jeEQ==
X-CSE-MsgGUID: ErzOIDLZSCW0+19loN3lTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3078890"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2026 03:52:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] net/ice: rename RSS flow configuration variables
Date: Wed, 21 Oct 2026 11:52:50 +0100
Message-ID: <09882fdcca7a467876582e530e4ec7c20b93466e.1792579964.git.anatoly.burakov@intel.com>
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

RSS parsing now constructs the final flow configuration rather than
temporary metadata, but its variable names still describe metadata.

Rename `meta`, `rss_meta`, and `rss_meta_ptr` to `rss_conf` in the RSS
flow parsing functions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_hash.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 951a9d3aa2c..2930aca2287 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -656,7 +656,7 @@ static int
 ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 				const struct rte_flow_item *item,
 				struct rte_flow_error *error,
-				struct ice_hash_flow_cfg *meta)
+				struct ice_hash_flow_cfg *rss_conf)
 {
 	const struct rte_flow_item_raw *raw_spec, *raw_mask;
 	struct ice_parser_profile prof;
@@ -744,7 +744,7 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	if (ret)
 		goto free_mem;
 
-	memcpy(&meta->rss_cfg.raw.prof, &prof, sizeof(prof));
+	memcpy(&rss_conf->rss_cfg.raw.prof, &prof, sizeof(prof));
 
 free_mem:
 	free(pkt_buf);
@@ -1122,7 +1122,7 @@ ice_hash_parse_action_check(const struct ci_flow_actions *actions,
 static int
 ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 		const struct rte_flow_action_rss *rss,
-		uint64_t pattern_hint, struct ice_hash_flow_cfg *rss_meta,
+		uint64_t pattern_hint, struct ice_hash_flow_cfg *rss_conf,
 		struct rte_flow_error *error)
 {
 	struct ice_rss_hash_cfg *cfg = pattern_match_item->meta;
@@ -1135,7 +1135,7 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 					RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
 					"XOR hash function is only supported for empty pattern");
 		}
-		rss_meta->simple_xor = true;
+		rss_conf->simple_xor = true;
 		return 0;
 	}
 
@@ -1145,7 +1145,7 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 
 	/* If pattern type is raw, no need to refine rss type */
 	if (pattern_hint == ICE_PHINT_RAW) {
-		rss_meta->rss_cfg.raw.symm = symm;
+		rss_conf->rss_cfg.raw.symm = symm;
 		return 0;
 	}
 	cfg->symm = symm;
@@ -1162,8 +1162,8 @@ ice_hash_parse_rss_action(struct ice_pattern_match_item *pattern_match_item,
 				RTE_FLOW_ERROR_TYPE_ACTION_CONF,
 				rss, "RSS type not supported");
 
-	rss_meta->rss_cfg.hash = *cfg;
-	ice_refine_hash_cfg(&rss_meta->rss_cfg.hash,
+	rss_conf->rss_cfg.hash = *cfg;
+	ice_refine_hash_cfg(&rss_conf->rss_cfg.hash,
 			    rss_type, pattern_hint);
 
 	return 0;
@@ -1190,7 +1190,7 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	};
 	const struct rte_flow_action_rss *rss;
 	struct ice_pattern_match_item pattern_match_item;
-	struct ice_hash_flow_cfg *rss_meta_ptr;
+	struct ice_hash_flow_cfg *rss_conf;
 	uint64_t phint = ICE_PHINT_NONE;
 	int ret = 0;
 
@@ -1202,11 +1202,11 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	if (ret)
 		return ret;
 
-	rss_meta_ptr = rte_zmalloc(NULL, sizeof(*rss_meta_ptr), 0);
-	if (!rss_meta_ptr) {
+	rss_conf = rte_zmalloc(NULL, sizeof(*rss_conf), 0);
+	if (!rss_conf) {
 		rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
-				"No memory for rss_meta_ptr");
+				"No memory for RSS configuration");
 		return -ENOMEM;
 	}
 
@@ -1223,8 +1223,8 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 	if (phint == ICE_PHINT_RAW) {
 		const struct rte_flow_item *raw_item = ice_pattern_skip_void(pattern);
 
-		rss_meta_ptr->rss_cfg.raw.raw_ena = true;
-		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_meta_ptr);
+		rss_conf->rss_cfg.raw.raw_ena = true;
+		ret = ice_hash_parse_raw_pattern(ad, raw_item, error, rss_conf);
 		if (ret) {
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM, NULL,
@@ -1235,13 +1235,13 @@ ice_hash_parse_pattern_action(__rte_unused struct ice_adapter *ad,
 
 	rss = parsed_actions.actions[0]->conf;
 	ret = ice_hash_parse_rss_action(&pattern_match_item, rss, phint,
-				rss_meta_ptr, error);
+				rss_conf, error);
 
 error:
 	if (!ret)
-		*flow_rule = rss_meta_ptr;
+		*flow_rule = rss_conf;
 	else
-		rte_free(rss_meta_ptr);
+		rte_free(rss_conf);
 
 	return ret;
 }
-- 
2.52.0

