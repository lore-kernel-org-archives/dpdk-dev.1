Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94AC28B2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 11:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53E49410E4;
	Thu, 13 Mar 2025 12:38:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 466F2410D0
 for <dev@dpdk.org>; Thu, 13 Mar 2025 12:38:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741865919; x=1773401919;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aC09X+IXNg9b2ObYaQeycqswM8sa8zOMqsNej54RCxs=;
 b=OG9aDeRhef/JqcSVYbayyR13CmdApFzm9i9SmyMZZqQ/3bzyRFxRKCQN
 6MeVVF4DhSL1C64HL4xLAGaLIZTNOELxf3+/F3tWRgSABYa7is5RGNygd
 y3eei+uB3JyZJXcoPxKrLJcVn+A2cRSVNqctyTFc+ujy7Se1cJsQW7SWZ
 M1MXPS3JcgjiBd8VLn2v4dL7P9TlojhtFl86lWDLfwBINPqQ71y0fF8QM
 rvfucxOBo1mVN3Eiq4DM8tIIMbUxgueoHRVesZ//BgTz2mTBxX8G6GJqV
 OTFzhNzxn+9jMDPM0QI0J7ZKYpNZ31npN+7HCMkQUrknw9Ll5rBPoMKri Q==;
X-CSE-ConnectionGUID: 12JVBAiATGWkOK1M8p3Oaw==
X-CSE-MsgGUID: YTjGb/HhRKSsw83afOwIQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42145709"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="42145709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 04:38:39 -0700
X-CSE-ConnectionGUID: 6+SVWFQvSo2PJhaGzMR03Q==
X-CSE-MsgGUID: Ga27TS94TCGFCxBhGMcAHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; d="scan'208";a="120888958"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 04:38:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 3/3] eal: allow automatic mapping of high lcore ids
Date: Thu, 13 Mar 2025 11:38:29 +0000
Message-ID: <20250313113829.1480907-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313113829.1480907-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
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

To use cores with IDs greater than RTE_MAX_LCORE the user must provide a
mapping of those higher core numbers to ids within the 0 - RTE_MAX_LCORE
range. This can be awkward to do manually when more than a few lcores
are involved, so instead we can provide an extra option to EAL to do
this manually.

This patch therefore introduces the "map-lcore-ids" flag, which
automatically maps all provided lcore numbers to start at zero.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/event/dlb2/pf/base/dlb2_resource.c |  2 +-
 lib/eal/common/eal_common_options.c        | 32 ++++++++++++++--------
 lib/eal/common/eal_options.h               |  2 ++
 lib/eal/include/rte_eal.h                  |  2 +-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/event/dlb2/pf/base/dlb2_resource.c b/drivers/event/dlb2/pf/base/dlb2_resource.c
index c4bc248afc..541a16db24 100644
--- a/drivers/event/dlb2/pf/base/dlb2_resource.c
+++ b/drivers/event/dlb2/pf/base/dlb2_resource.c
@@ -931,7 +931,7 @@ dlb2_resource_probe(struct dlb2_hw *hw, const void *probe_args)
 	cpu = rte_get_next_lcore(-1, 1, 0);
 	hw->num_prod_cores = 0;
 	if (mask) {
-		int n = rte_eal_parse_coremask(mask, hw->prod_core_list);
+		int n = rte_eal_parse_coremask(mask, hw->prod_core_list, true);
 		if (n <= 0) {
 			DLB2_HW_ERR(hw, ": Invalid producer coremask=%s\n", mask);
 			return -1;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 807ba760ce..107b9eaad5 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -106,6 +106,7 @@ eal_long_options[] = {
 	{OPT_NO_TELEMETRY,      0, NULL, OPT_NO_TELEMETRY_NUM     },
 	{OPT_FORCE_MAX_SIMD_BITWIDTH, 1, NULL, OPT_FORCE_MAX_SIMD_BITWIDTH_NUM},
 	{OPT_HUGE_WORKER_STACK, 2, NULL, OPT_HUGE_WORKER_STACK_NUM     },
+	{OPT_MAP_LCORE_IDS,     0, NULL, OPT_MAP_LCORE_IDS_NUM    },
 
 	{0,                     0, NULL, 0                        }
 };
@@ -152,6 +153,7 @@ TAILQ_HEAD_INITIALIZER(devopt_list);
 static int main_lcore_parsed;
 static int mem_parsed;
 static struct lcore_options {
+	bool map_lcore_ids;
 	const char *core_mask_opt;
 	const char *core_list_opt;
 	const char *core_map_opt;
@@ -723,13 +725,14 @@ check_core_list(int *lcores, unsigned int count)
 	if (len > 0)
 		lcorestr[len - 1] = 0;
 	EAL_LOG(ERR, "To use high physical core ids, "
-		"please use --lcores to map them to lcore ids below RTE_MAX_LCORE, "
+		"please use --map-lcore-ids flag to map core ids automatically, "
+		"or use --lcores to map them manually to lcore ids below RTE_MAX_LCORE, "
 		"e.g. --lcores %s", lcorestr);
 	return -1;
 }
 
 int
-rte_eal_parse_coremask(const char *coremask, int *cores)
+rte_eal_parse_coremask(const char *coremask, int *cores, bool no_check)
 {
 	const char *coremask_orig = coremask;
 	unsigned int count = 0;
@@ -784,7 +787,7 @@ rte_eal_parse_coremask(const char *coremask, int *cores)
 		return -1;
 	}
 
-	if (check_core_list(cores, count) != 0)
+	if (!no_check && check_core_list(cores, count) != 0)
 		return -1;
 
 	return count;
@@ -869,7 +872,7 @@ eal_parse_service_corelist(const char *corelist)
 }
 
 static int
-eal_parse_corelist(const char *corelist, int *cores)
+eal_parse_corelist(const char *corelist, int *cores, bool no_check)
 {
 	unsigned int count = 0, i;
 	char *end = NULL;
@@ -932,7 +935,7 @@ eal_parse_corelist(const char *corelist, int *cores)
 		return -1;
 	}
 
-	if (check_core_list(cores, count))
+	if (!no_check && check_core_list(cores, count))
 		return -1;
 
 	return count;
@@ -1767,6 +1770,9 @@ eal_parse_common_option(int opt, const char *optarg,
 			return -1;
 		}
 		break;
+	case OPT_MAP_LCORE_IDS_NUM:
+		lcore_options.map_lcore_ids = true;
+		break;
 
 	/* don't know what to do, leave this to caller */
 	default:
@@ -1866,10 +1872,11 @@ eal_adjust_config(struct internal_config *internal_cfg)
 
 
 	if (lcore_options.core_mask_opt || lcore_options.core_list_opt) {
-		int lcore_indexes[RTE_MAX_LCORE];
+		bool map_ids = lcore_options.map_lcore_ids;
+		int idxs[RTE_MAX_LCORE];
 		int nb_indexes = lcore_options.core_list_opt ?
-				eal_parse_corelist(lcore_options.core_list_opt, lcore_indexes) :
-				rte_eal_parse_coremask(lcore_options.core_mask_opt, lcore_indexes);
+				eal_parse_corelist(lcore_options.core_list_opt, idxs, map_ids) :
+				rte_eal_parse_coremask(lcore_options.core_mask_opt, idxs, map_ids);
 
 		if (nb_indexes < 0)
 			return -1;
@@ -1877,13 +1884,16 @@ eal_adjust_config(struct internal_config *internal_cfg)
 		char *core_map_opt = malloc(RTE_MAX_LCORE * 10);
 		size_t core_map_len = 0;
 		for (i = 0; i < nb_indexes; i++) {
-			if (!eal_cpu_detected(lcore_indexes[i])) {
-				EAL_LOG(ERR, "core %d not present", lcore_indexes[i]);
+			if (!eal_cpu_detected(idxs[i])) {
+				EAL_LOG(ERR, "core %d not present", idxs[i]);
 				return -1;
 			}
 			int n = snprintf(core_map_opt + core_map_len,
 					(RTE_MAX_LCORE * 10) - core_map_len,
-					"%s%d", i == 0 ? "" : ",", lcore_indexes[i]);
+					"%s%d@%d",
+					i == 0 ? "" : ",",
+					map_ids ? i: idxs[i],
+					idxs[i]);
 			if (n < 0 || (size_t)n >= (RTE_MAX_LCORE * 10) - core_map_len) {
 				EAL_LOG(ERR, "core map string too long");
 				return -1;
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 95fb4f6108..384c2d016e 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -93,6 +93,8 @@ enum {
 	OPT_FORCE_MAX_SIMD_BITWIDTH_NUM,
 #define OPT_HUGE_WORKER_STACK  "huge-worker-stack"
 	OPT_HUGE_WORKER_STACK_NUM,
+#define OPT_MAP_LCORE_IDS  "map-lcore-ids"
+	OPT_MAP_LCORE_IDS_NUM,
 
 	OPT_LONG_MAX_NUM
 };
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index c826e143f1..a53fb29c45 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -508,7 +508,7 @@ rte_eal_get_runtime_dir(void);
  */
 __rte_internal
 int
-rte_eal_parse_coremask(const char *coremask, int *cores);
+rte_eal_parse_coremask(const char *coremask, int *cores, bool nocheck);
 
 #ifdef __cplusplus
 }
-- 
2.43.0

