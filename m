Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68865E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C28540A4B;
	Thu, 19 Feb 2026 17:23:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 21BB240672
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518215; x=1803054215;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vRMwjLqMdoa3XuDio5Hz4GQTNP8whMRI9Ha19pIWsiY=;
 b=Aqx2T0o+GrjfV3UkxOIoDQaygdDdXJm5t2GtoZWxMpddhMsIcVS103eO
 CeRckLOab5yHDI0DPLszNjZ+FKKGmiMdI9j4We15mbmP4fuaj5NxSE1uB
 jI3jJwmtvMonxKBl9gp2fEtf6ZXKJqqSjWKfYPnJiQGtHg9rOK/PZynQs
 nuk9oKqzvgw9FMDSfKFdVJdLsPbJUYVuuCzvMvZ3HFQoRe191oPgM629D
 z5wBrguIdAxtc+HeC9yzvBfc0sC1kcc1q/fz+CmmUIuzWB9tw17EEj0Z1
 9XRzH6nV9uJodBIcRNOSFXEo5Y/K+ToMhWFq/hzIdiDd4Xt7U5lO1lG8r g==;
X-CSE-ConnectionGUID: VVtJth+ZSwSW65ECuGsNnw==
X-CSE-MsgGUID: sXosVx34SOGRhLrfe6P5vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231449"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:35 -0800
X-CSE-ConnectionGUID: eMQIo8FxQpqxng7/oSDUzQ==
X-CSE-MsgGUID: hUqnHHJ9S1iRintS06butg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699902"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 16/27] net/iavf: remove remnants of pipeline mode
Date: Thu, 19 Feb 2026 16:22:59 +0000
Message-ID: <4c849647461e061b1b5f6d8c78f6aec3d35a818e.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

