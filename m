Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052A606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I85NosvD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 572E54065A;
	Wed, 21 Oct 2026 12:15:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 893C340041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577714; x=1824113714;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+ANVTBhF/ew5tDnQTMRskmgTAi11CzychuD6by/xbCI=;
 b=I85NosvD7V3pYKMQ7V+DoIUhKRivUd8lhHWNAlXGI9te4CqgZS55mKv+
 nBX1nXoqlGacHahri6EmZ4af63tcTTMkQ5PtfR9+9U6S2OI2QAvwCv44P
 rz0VPbLldAfV4ckT7lXcrxohywqvGbNzSnyQPPMNqLBQ6LXM5Prlf0tcl
 D87PdAhJaoD/GwEzBBdKCImCpFur5t4B5h0oDqH7YNiEi3UZ7e26jvoA5
 1XhLs9FDgM2hzDo+tnN6N3RrMFajJ5kROjDmD+Hvb5jKw9j9L5WdK/aEV
 Hr758QEC0HXzxIaVRW7OQEIv4mLX1H9MIpnq6Ln6adtSE4fism9raA9tw A==;
X-CSE-ConnectionGUID: EP8I37DhR3qS5UTPsAkR3w==
X-CSE-MsgGUID: i93zoFR/QZilvlfX/sTSAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1397571"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1397571"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:15:11 -0700
X-CSE-ConnectionGUID: 6dlDj1C2SU6I+hdFiAXa1g==
X-CSE-MsgGUID: WDMvtCsZSYi8Z8QOxErNzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3106181"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 21 Oct 2026 03:15:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/2] net/ice: remove unused flow handle from engines
Date: Wed, 21 Oct 2026 11:15:01 +0100
Message-ID: <869a70bf8e9bb8ce36de57ddb46ea2d44d7b9be9.1792577695.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
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

