Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158BCCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 17:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 554AA4113C;
	Thu,  2 Oct 2025 19:43:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 39610410E7
 for <dev@dpdk.org>; Thu,  2 Oct 2025 19:43:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759427026; x=1790963026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gGVKDFOtdRpSW0445A2QhWG1YfPjhDyWPjE7wUBIpXw=;
 b=DEukD4Z5GXPN0fupq3StcyAVipTrIB0H/tAH+OOvvbvHx91Pd2CdZ/V2
 flPnq3QE7NJFJJwC8j0gTX5CTfxuv1N1pmxKHHK+AQRU4uY60c2HoL45R
 lTdkuvShn2o/JNHQIXiEwSdZIq3ENzT0p/i4m2QoyXmjYjFnXqmnzwE5t
 jSrm8F1THFxdswRYn7W7GartUU6QiQjwcG3RLDbICP76FreLGYg+gKm//
 VRUTM98kxUrfDJXOh9tXRpi71Hadu1wy7eUBF12N6oejQBt2yW+veDrDJ
 /i6dxTEVgMABB0csbcTzoIyH7X+ZbapdKda147UMEgjZKqdnXWQ1CCMEw A==;
X-CSE-ConnectionGUID: k2SYOEmfSUuYjJazoAu/Tw==
X-CSE-MsgGUID: s1F+Em7rRFaA9UFP7K2X/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49271899"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="49271899"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 10:43:45 -0700
X-CSE-ConnectionGUID: +eXPC3Y3QdaB2SaXpx0dYg==
X-CSE-MsgGUID: vRlFU5pyTNymYXgpHDzDZg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 02 Oct 2025 10:43:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 18/18] eal: allow lcore remapping with autodetected core
 affinity
Date: Thu,  2 Oct 2025 18:43:15 +0100
Message-ID: <20251002174315.962992-19-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_options.c | 110 +++++++++++-----------------
 1 file changed, 43 insertions(+), 67 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index c754c19511..b1830aa9d7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -292,8 +292,6 @@ struct device_option {
 static struct device_option_list devopt_list =
 TAILQ_HEAD_INITIALIZER(devopt_list);
 
-static int core_parsed;
-
 /* Returns rte_usage_hook_t */
 rte_usage_hook_t
 eal_get_application_usage_hook(void)
@@ -830,7 +828,7 @@ eal_parse_service_coremask(const char *coremask)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores are in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -1051,7 +1049,7 @@ eal_parse_service_corelist(const char *corelist)
 	if (count == 0)
 		return -1;
 
-	if (core_parsed && taken_lcore_count != count) {
+	if (taken_lcore_count != count) {
 		EAL_LOG(WARNING,
 			"Not all service cores were in the coremask. "
 			"Please ensure -c or -l includes service cores");
@@ -1919,32 +1917,31 @@ eal_parse_args(void)
 		}
 	}
 
-	/* parse the core list arguments */
-	if (args.coremask != NULL) {
-		rte_cpuset_t cpuset;
 
-		if (rte_eal_parse_coremask(args.coremask, &cpuset, !remap_lcores) < 0) {
-			EAL_LOG(ERR, "invalid coremask syntax");
-			return -1;
-		}
-		if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
-			char *available = available_cores();
-
-			EAL_LOG(ERR, "invalid coremask '%s', please check specified cores are part of %s",
-					args.coremask, available);
-			free(available);
+	/* parse the core list arguments
+	 * First handle the special case where we have explicit core mapping/remapping
+	 */
+	if (args.lcores != NULL && !remap_lcores) {
+		if (eal_parse_lcores(args.lcores) < 0) {
+			EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
 			return -1;
 		}
-		core_parsed = 1;
-	} else if (args.lcores != NULL) {
-		if (!remap_lcores) {
-			if (eal_parse_lcores(args.lcores) < 0) {
-				EAL_LOG(ERR, "invalid lcore list: '%s'", args.lcores);
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
-		} else {
-			rte_cpuset_t cpuset;
-
+			cpuset_source = "coremask";
+		} else if (args.lcores != NULL) {
 			if (strchr(args.lcores, '@') != NULL || strchr(args.lcores, '(') != NULL) {
 				EAL_LOG(ERR, "cannot use '@' or core groupings '()' in lcore list when remapping lcores");
 				return -1;
@@ -1954,18 +1951,29 @@ eal_parse_args(void)
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
@@ -2208,27 +2216,6 @@ eal_parse_args(void)
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
@@ -2276,20 +2263,9 @@ int
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

