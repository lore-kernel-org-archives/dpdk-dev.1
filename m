Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E7CE9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3025540DCE;
	Wed, 11 Feb 2026 14:53:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EB1D240A76
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818032; x=1802354032;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vRMwjLqMdoa3XuDio5Hz4GQTNP8whMRI9Ha19pIWsiY=;
 b=ISxFjVnan/oY6Zi4RT4VyFckaIaD0cvl+3dxvPFcjRRT352jnJOkLpzp
 COZgnm/NKYEuGyak4rgGXHXX04WbPxx/XsJGh7+rShKk5zwr5EwHtE4Ae
 XmYOadNqOJ8VmA5cXJQqTtiWcB6pynwKO3t6SbKBtHAtA7EBk9VaB28mS
 MWL6lHin9tZMarm2TWKRpihRuSkiOgUeBcy55w2FYpTVf/4Dma7DGLZQU
 +k5Hj355ComstHFZsJ6ovqiKhQGw36BWd31s2O6IJ8udc36edX3fN2a7C
 AsQPrfcghw38klPn+aBt0izZ02/Zm34FgWzbRN5vf2SaWZAB9Stihul8Y g==;
X-CSE-ConnectionGUID: iP1oYKbtR+GI0oXVRfKmTA==
X-CSE-MsgGUID: QrFh+R7eRd+y329psq6lLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808264"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808264"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:51 -0800
X-CSE-ConnectionGUID: FCk5vDzfR9OyzYGjhaZCBg==
X-CSE-MsgGUID: UnKDTSp5SPe9vO/chshSMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359622"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 16/27] net/iavf: remove remnants of pipeline mode
Date: Wed, 11 Feb 2026 13:52:58 +0000
Message-ID: <c55f6d802b299f48f110c0a62e915f62cfb6b278.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

