Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B97606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BIXu6lno
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D8CA40A6C;
	Wed, 21 Oct 2026 12:52:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3245240041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792579974; x=1824115974;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=feAlfcnZO9gQwb/98LB7pLhYxVU0RIfrumCoZrf+jH0=;
 b=BIXu6lnoPvmCd8smAgGh67j1GWR1ToZUGKtwLFvkBhVcIcCFE4uYLgtj
 PZGAbtakvh/rmg6WrElBeWhS2qckpCQRfD5T0NVlo02s5/PHZ6GPFrhpd
 MGaBxdbJpRMWzmIjSF4UPJ3ASbsTg2O4LaucX9uqw1CO+rucSdCM51HBO
 2ChADq+fv50eZD6ZnurKMXmThUeGMqFNxKgsNyKXXfvvF4J9oCt30Pmd0
 axSr8DMgejVv0mInu7lS8LIxyUYmykMbTDwezdou3AISgNogEW3xuukLH
 wdNUTNN3O+gtuo3cOJwpmk4JNvBFANSfDOJ2uFdZuX+AFN9Mr9B2rClYW w==;
X-CSE-ConnectionGUID: JzxEQbvnTtSMfWbIiHVBZA==
X-CSE-MsgGUID: M3I2ijA6SBKxAZi/9Zt4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1301046"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1301046"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:52:53 -0700
X-CSE-ConnectionGUID: 5EbqU9RUR0K5DhSIWnWq3Q==
X-CSE-MsgGUID: PU4ubYbzSF2i1oiko5vyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3078882"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa004.fm.intel.com with ESMTP; 21 Oct 2026 03:52:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/3] net/ice: remove unused flow handle from engines
Date: Wed, 21 Oct 2026 11:52:48 +0100
Message-ID: <3cbd41baf2db930276ce43893a787ea65770e1ff.1792579964.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
References: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
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

The generic flow layer now assigns the parsed rule to `flow->rule`
after successful creation. Engine create callbacks no longer use the
flow handle, and all four implementations mark it as unused.

Remove the parameter from the callback type, declarations,
implementations and generic invocation.

Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    | 1 -
 drivers/net/intel/ice/ice_fdir_filter.c   | 1 -
 drivers/net/intel/ice/ice_generic_flow.c  | 2 +-
 drivers/net/intel/ice/ice_generic_flow.h  | 1 -
 drivers/net/intel/ice/ice_hash.c          | 2 --
 drivers/net/intel/ice/ice_switch_filter.c | 1 -
 6 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 9414bb3f122..08695b554f1 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -505,7 +505,6 @@ ice_acl_hw_rem_conf(struct ice_pf *pf, struct acl_rule *rule, int32_t entry_idx)
 
 static int
 ice_acl_create_filter(struct ice_adapter *ad,
-		      struct rte_flow *flow __rte_unused,
 		      void *meta,
 		      struct rte_flow_error *error)
 {
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index f4c886dded3..e3f2cf2e3dd 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1537,7 +1537,6 @@ ice_fdir_entry_del(struct ice_pf *pf, struct ice_fdir_fltr_pattern *key)
 
 static int
 ice_fdir_create_filter(struct ice_adapter *ad,
-		       struct rte_flow *flow __rte_unused,
 		       void *meta,
 		       struct rte_flow_error *error)
 {
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 25aa7aa41e2..f5ae6f7d013 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2269,7 +2269,7 @@ ice_parse_engine_create(struct ice_adapter *ad,
 
 	RTE_ASSERT(parser->engine->create != NULL);
 
-	if (parser->engine->create(ad, flow, meta, error) != 0) {
+	if (parser->engine->create(ad, meta, error) != 0) {
 		ice_flow_rule_free(parser->engine, meta);
 		return false;
 	}
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index efb3ee9b695..ca0f7abe9aa 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -506,7 +506,6 @@ struct ice_flow_redirect {
 typedef int (*engine_init_t)(struct ice_adapter *ad);
 typedef void (*engine_uninit_t)(struct ice_adapter *ad);
 typedef int (*engine_create_t)(struct ice_adapter *ad,
-		struct rte_flow *flow,
 		void *meta,
 		struct rte_flow_error *error);
 typedef int (*engine_destroy_t)(struct ice_adapter *ad,
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index fe66b1dd5a6..980abb58f3b 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -82,7 +82,6 @@ ice_hash_init(struct ice_adapter *ad);
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		struct rte_flow *flow,
 		void *meta,
 		struct rte_flow_error *error);
 
@@ -1314,7 +1313,6 @@ ice_hash_add_raw_cfg(struct ice_adapter *ad,
 
 static int
 ice_hash_create(struct ice_adapter *ad,
-		struct rte_flow *flow __rte_unused,
 		void *meta,
 		struct rte_flow_error *error)
 {
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 4dd4707c406..59e18269206 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -285,7 +285,6 @@ ice_pattern_match_item ice_switch_supported_pattern[] = {
 
 static int
 ice_switch_create(struct ice_adapter *ad,
-		struct rte_flow *flow __rte_unused,
 		void *meta,
 		struct rte_flow_error *error)
 {
-- 
2.52.0

