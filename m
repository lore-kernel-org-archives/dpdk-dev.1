Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B27CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 13:03:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C580340DCD;
	Thu,  9 Oct 2025 15:01:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0D39A40647
 for <dev@dpdk.org>; Thu,  9 Oct 2025 15:01:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760014897; x=1791550897;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dWtjtYbMQ78QDYYELpSKbOUnpsxBgpYRxRVdn6rkwHk=;
 b=Hq5O1qvVrQMH9xL5kqP9k0SWXe8OSISUlcMnZqLysDette9emH6H7AYs
 64yGwWMmjpxHKwBx7Zjv6rYaK1PnbQApTKfx2bmW6ZIxy7ARSfeTER2yK
 QZanapGr44/IdZHtz2AsL7cB+aq4jzNO9WZc1UDHA6HWqV01Od4xRm8rM
 U+L6KZz/ayQooV67D+t5gUlEGXAZWUdjN3SU/7sls6CBe+K4XxL1aDgyZ
 lzUYDavwYFz1S1Uy5CkQ0HtFbNboRgKJoZrgJfRQi0qAaXlOoFoIE+MCa
 Vuq/xKMLdtYfpKCJ2JvLuwef6QNWCCKszm7CIXZtmp0Yj4STJprk1pYcS g==;
X-CSE-ConnectionGUID: Tm7YLCZnStGGRO88SswLNw==
X-CSE-MsgGUID: RfpDBpA/RZKQJR4+KvpJ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79663165"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="79663165"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 06:01:36 -0700
X-CSE-ConnectionGUID: cV0Raw5WSw+qLb36uT4Now==
X-CSE-MsgGUID: nJUcO0TKSs+jcX9bSuFkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; d="scan'208";a="179951679"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 09 Oct 2025 06:01:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 21/21] eal: allow lcore remapping with autodetected core
 affinity
Date: Thu,  9 Oct 2025 14:00:56 +0100
Message-ID: <20251009130056.2630343-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251009130056.2630343-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251009130056.2630343-1-bruce.richardson@intel.com>
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

When run without an coremask or core list parameters, EAL detects the
working set of cores allowed for the current process and uses that as a
core list for use. Currently, this does not work for cores which are
numbered >= RTE_MAX_LCORE.

We can fix this by allowing the remap option to also be used with these
auto-detected cores. In the process we simplify the code by taking
advantage of that fact that we know up-front when processing parameters
if any core parameter is passed, so we no longer need a flag and to
auto-detect at the end. Instead, we take advantage of the fact that our
core-arg processing routines now all work with cpusets, to have a simple
tri-state option for remapping (if we don't have manual remapping done
by --lcores-parameter):
  * parse coremask to cpuset
  * parse core list to cpuset
  * query OS for current thread's cpuset
Once that is done, we have common code for processing, and optionally
remapping, the resulting cpuset.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 136 ++++++++++++++--------------
 1 file changed, 67 insertions(+), 69 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 9f460d1740..5e9ab3254a 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -293,8 +293,6 @@ struct device_option {
 static struct device_option_list devopt_list =
 TAILQ_HEAD_INITIALIZER(devopt_list);
 
-static int core_parsed;
-
 /* Returns rte_usage_hook_t */
 rte_usage_hook_t
 eal_get_application_usage_hook(void)
@@ -831,7 +829,7 @@ eal_parse_service_coremask(const char *coremask)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores are in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -864,8 +862,22 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				ret = -1;
 				continue;
 			}
+
+			if (count >= RTE_MAX_LCORE) {
+				EAL_LOG(WARNING, "Too many lcores provided (>=RTE_MAX_LCORE[%d]). All remaining lcores will be skipped.",
+					RTE_MAX_LCORE);
+				break;
+			}
+
 			if (!remap)
 				lcore_id = i;
+			if (lcore_id >= RTE_MAX_LCORE) {
+				EAL_LOG(ERR, "lcore %u >= RTE_MAX_LCORE (%d), cannot use.",
+						lcore_id, RTE_MAX_LCORE);
+				ret = -1;
+				continue;
+			}
+
 			cfg->lcore_role[lcore_id] = ROLE_RTE;
 			lcore_config[lcore_id].core_index = count;
 			CPU_ZERO(&lcore_config[lcore_id].cpuset);
@@ -875,6 +887,10 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 			count++;
 		}
 	}
+	if (count == 0) {
+		EAL_LOG(ERR, "No valid lcores in core list");
+		ret = -1;
+	}
 	if (!ret)
 		cfg->lcore_count = count;
 	return ret;
@@ -1052,7 +1068,7 @@ eal_parse_service_corelist(const char *corelist)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores were in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -1920,53 +1936,67 @@ eal_parse_args(void)
 		}
 	}
 
+
 	/* parse the core list arguments */
-	if (args.coremask != NULL) {
-		rte_cpuset_t cpuset;
+	/* check if we are using manual mapping */
+	bool manual_lcore_mapping = (args.lcores != NULL) &&
+			((strchr(args.lcores, '@') != NULL || strchr(args.lcores, '(') != NULL));
 
-		if (rte_eal_parse_coremask(args.coremask, &cpuset, !remap_lcores) < 0) {
-			EAL_LOG(ERR, "invalid coremask syntax");
-			return -1;
-		}
-		if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
-			char *available = available_cores();
+	if (manual_lcore_mapping && remap_lcores) {
+		EAL_LOG(ERR, "cannot use '@' or core groupings '()' in lcore list when remapping lcores");
+		return -1;
+	}
 
-			EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
-					args.coremask, available);
-			free(available);
+	/* First handle the special case where we have explicit core mapping/remapping */
+	if (manual_lcore_mapping) {
+		if (eal_parse_lcores(args.lcores) < 0) {
+			EAL_LOG(ERR, "invalid lcore mapping list: '%s'", args.lcores);
 			return -1;
 		}
-		core_parsed = 1;
-	} else if (args.lcores != NULL) {
-		if (!remap_lcores) {
-			if (eal_parse_lcores(args.lcores) < 0) {
-				EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
-				return -1;
-			}
-		} else {
-			rte_cpuset_t cpuset;
-
-			if (strchr(args.lcores, '@') != NULL || strchr(args.lcores, '(') != NULL) {
-				EAL_LOG(ERR, "cannot use '@' or core groupings '()' in lcore list when remapping lcores");
+	} else {
+		/* otherwise get a cpuset of the cores to be used and then handle that
+		 * taking mappings into account. Cpuset comes from either:
+		 * 1. coremask parameter
+		 * 2. core list parameter
+		 * 3. autodetecting current thread affinities
+		 */
+		rte_cpuset_t cpuset;
+		const char *cpuset_source;
+		if (args.coremask != NULL) {
+			if (rte_eal_parse_coremask(args.coremask, &cpuset, !remap_lcores) < 0) {
+				EAL_LOG(ERR, "invalid coremask syntax");
 				return -1;
 			}
+			cpuset_source = "coremask";
+		} else if (args.lcores != NULL) {
 			if (rte_argparse_parse_type(args.lcores,
 					RTE_ARGPARSE_VALUE_TYPE_CORELIST, &cpuset) != 0) {
 				EAL_LOG(ERR, "Error parsing lcore list: '%s'", args.lcores);
 				return -1;
 			}
-
-			if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
-				char *available = available_cores();
-
-				EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
-						args.coremask, available);
-				free(available);
+			cpuset_source = "core list";
+		} else {
+			if (rte_thread_get_affinity_by_id(rte_thread_self(), &cpuset) != 0) {
+				EAL_LOG(ERR, "Error querying current process thread affinities");
 				return -1;
 			}
+			cpuset_source = "affinity auto-detection";
+		}
+		char *cpuset_str = eal_cpuset_to_str(&cpuset);
+		if (cpuset_str != NULL) {
+			EAL_LOG(DEBUG, "Cores selected by %s: %s", cpuset_source, cpuset_str);
+			free(cpuset_str);
+		}
+		if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
+			char *available = available_cores();
+
+			EAL_LOG(ERR, "invalid coremask or core-list parameter, please check specified cores are part of %s",
+					available);
+			free(available);
+			return -1;
 		}
-		core_parsed = 1;
 	}
+
 	/* service core options */
 	if (args.service_coremask != NULL) {
 		if (eal_parse_service_coremask(args.service_coremask) < 0) {
@@ -2209,27 +2239,6 @@ eal_parse_args(void)
 	return 0;
 }
 
-static void
-eal_auto_detect_cores(struct rte_config *cfg)
-{
-	unsigned int lcore_id;
-	unsigned int removed = 0;
-	rte_cpuset_t affinity_set;
-
-	if (rte_thread_get_affinity_by_id(rte_thread_self(), &affinity_set) != 0)
-		CPU_ZERO(&affinity_set);
-
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (cfg->lcore_role[lcore_id] == ROLE_RTE &&
-		    !CPU_ISSET(lcore_id, &affinity_set)) {
-			cfg->lcore_role[lcore_id] = ROLE_OFF;
-			removed++;
-		}
-	}
-
-	cfg->lcore_count -= removed;
-}
-
 static void
 compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 {
@@ -2277,20 +2286,9 @@ int
 eal_adjust_config(struct internal_config *internal_cfg)
 {
 	int i;
-	struct rte_config *cfg = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (!core_parsed)
-		eal_auto_detect_cores(cfg);
-
-	if (cfg->lcore_count == 0) {
-		EAL_LOG(ERR, "No detected lcore is enabled, please check the core list");
-		return -1;
-	}
 
-	if (internal_conf->process_type == RTE_PROC_AUTO)
-		internal_conf->process_type = eal_proc_type_detect();
+	if (internal_cfg->process_type == RTE_PROC_AUTO)
+		internal_cfg->process_type = eal_proc_type_detect();
 
 	compute_ctrl_threads_cpuset(internal_cfg);
 
-- 
2.48.1

