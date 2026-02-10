Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3880EF0702
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40CDA40E1B;
	Tue, 10 Feb 2026 17:14:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9652D40DDE
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740064; x=1802276064;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vRMwjLqMdoa3XuDio5Hz4GQTNP8whMRI9Ha19pIWsiY=;
 b=JfMCnP0lZ54DfLI/1HKZ4rmGLpMJr2nL+mrBylDVf9FGWOb3txAYXPD+
 fU90kRpr2/Br5i0LNgPslNsCY2t/CBVVpMO+meqzUv2RMH0aUji5Gp8H5
 GJtFa/eOSQq7Cc1lomhNUeZVySXaIh1ikpATNsEOQdY0sUUDdxs/oUVrr
 4V1XmA8nPbwZA0k42dj3PN0Mu0dU/9kmO9WXMyofXzKZUIO8tjfuI4wQr
 byVHErHSh4wZFO+Ibl75RNkIIwqWaG316FHvS3PyKGc/ubK/4uUcnRgcj
 D6ScpHyBLpq+/QSkbkWbt0VgQnsPQqsSV4d9K0ElVLxtm3OHnxaTouGgi Q==;
X-CSE-ConnectionGUID: kC3qMZWeThuBNgpgsco8HQ==
X-CSE-MsgGUID: wUX1gDq9RqyoTeAGWtPxZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286229"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286229"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:22 -0800
X-CSE-ConnectionGUID: zuUY6/fzQDmVjB/vwbvMrA==
X-CSE-MsgGUID: xGXjOwkHR1W62q47L9nArw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127794"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 16/26] net/iavf: remove remnants of pipeline mode
Date: Tue, 10 Feb 2026 16:13:45 +0000
Message-ID: <59f8ba8b9fc5c21e6579a221a130b8ccfc75da5a.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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

When pipeline mode was removed, some of the things used by pipelines were
left in the code. Remove them as they are unused.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c         |  1 -
 drivers/net/intel/iavf/iavf_fsub.c         |  1 -
 drivers/net/intel/iavf/iavf_generic_flow.h | 15 ---------------
 drivers/net/intel/iavf/iavf_hash.c         |  1 -
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |  1 -
 5 files changed, 19 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 0ef6e0d04a..9eae874800 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -1632,7 +1632,6 @@ static struct iavf_flow_parser iavf_fdir_parser = {
 	.array = iavf_fdir_pattern,
 	.array_len = RTE_DIM(iavf_fdir_pattern),
 	.parse_pattern_action = iavf_fdir_parse,
-	.stage = IAVF_FLOW_STAGE_DISTRIBUTOR,
 };
 
 RTE_INIT(iavf_fdir_engine_register)
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index cf1030320f..bfb34695de 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -814,7 +814,6 @@ iavf_flow_parser iavf_fsub_parser = {
 	.array = iavf_fsub_pattern_list,
 	.array_len = RTE_DIM(iavf_fsub_pattern_list),
 	.parse_pattern_action = iavf_fsub_parse,
-	.stage = IAVF_FLOW_STAGE_DISTRIBUTOR,
 };
 
 RTE_INIT(iavf_fsub_engine_init)
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index b11bb4cf2b..b97cf8b7ff 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -485,20 +485,6 @@ enum iavf_flow_engine_type {
 	IAVF_FLOW_ENGINE_MAX,
 };
 
-/**
- * classification stages.
- * for non-pipeline mode, we have two classification stages: Distributor/RSS
- * for pipeline-mode we have three classification stages:
- * Permission/Distributor/RSS
- */
-enum iavf_flow_classification_stage {
-	IAVF_FLOW_STAGE_NONE = 0,
-	IAVF_FLOW_STAGE_IPSEC_CRYPTO,
-	IAVF_FLOW_STAGE_RSS,
-	IAVF_FLOW_STAGE_DISTRIBUTOR,
-	IAVF_FLOW_STAGE_MAX,
-};
-
 /* Struct to store engine created. */
 struct iavf_flow_engine {
 	TAILQ_ENTRY(iavf_flow_engine) node;
@@ -527,7 +513,6 @@ struct iavf_flow_parser {
 	struct iavf_pattern_match_item *array;
 	uint32_t array_len;
 	parse_pattern_action_t parse_pattern_action;
-	enum iavf_flow_classification_stage stage;
 };
 
 /* Struct to store parser created. */
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 1725c2b2b9..a40fed7542 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -691,7 +691,6 @@ static struct iavf_flow_parser iavf_hash_parser = {
 	.array = iavf_hash_pattern_list,
 	.array_len = RTE_DIM(iavf_hash_pattern_list),
 	.parse_pattern_action = iavf_hash_parse_pattern_action,
-	.stage = IAVF_FLOW_STAGE_RSS,
 };
 
 int
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 6d41b1744e..66eaea8715 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1983,7 +1983,6 @@ static struct iavf_flow_parser iavf_ipsec_flow_parser = {
 	.array = iavf_ipsec_flow_pattern,
 	.array_len = RTE_DIM(iavf_ipsec_flow_pattern),
 	.parse_pattern_action = iavf_ipsec_flow_parse,
-	.stage = IAVF_FLOW_STAGE_IPSEC_CRYPTO,
 };
 
 RTE_INIT(iavf_ipsec_flow_engine_register)
-- 
2.47.3

