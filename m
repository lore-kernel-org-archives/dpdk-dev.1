Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714CC5DF7E
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF73240ED8;
	Tue, 18 Aug 2026 15:34:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 11C7340E15
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060055; x=1818596055;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2GXKmyV1qnevIjEAmIM1XKBjNbZ5PbDUCo00w6couBA=;
 b=QqO8clinYFo09sPqRLlpsDj2yG2kn0QrOtkUU3U3HVHD2qdCmTiIk+aD
 3w4JKzS/eTVydlk6YUFJQBi2emDcwFNtjCazFy56ELdQESH1W3Qz5IFWe
 stWnbWwrmL5ewBuNVjmambwnt36NxdSQUKDnjYqqWCrxz+/iIkmE2HCSt
 YM4Xr/Y9xHQ9rDPc9uQgYTiumMIdVdATpa5WTXokadxrCUuq+0agO4p4x
 uYy3AtBVB9M1n3EEkmqiXFBEAZn0ICYVc9Uok8/isU1vncA70ro2J5vWy
 /UbHqadJ/ZaayHpd1hAGbFga4ZZWPjTkvIyKSvDG6SKpWpAXkhpD2+V3t Q==;
X-CSE-ConnectionGUID: AgbiSu1oS/2dvHt2CeAgPw==
X-CSE-MsgGUID: GIUvGBSVRxax1/fOmwuexQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757684"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:14 -0700
X-CSE-ConnectionGUID: 9ZCy+8AZSkSGsExjXaXTew==
X-CSE-MsgGUID: ZuWZWDDsQoq1Fll4v966bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736768"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 31/39] eal: store user-provided lcore info in user config
 struct
Date: Tue, 18 Aug 2026 14:33:24 +0100
Message-ID: <20260818133334.2620165-32-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

The user provides details of what lcores are to run on what cpus in a
variety of ways. Map all those to a single array of cpusets in the
user_cfg struct, such that each lcore id has a cpuset of physical lcore
ids if it is to be used. Then post-parse of args, we can use that to
appropriately populate the runtime configuration.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 151 ++++++++++++++++++----------
 lib/eal/common/eal_internal_cfg.h   |   9 +-
 lib/eal/freebsd/eal.c               |   1 +
 lib/eal/linux/eal.c                 |   1 +
 lib/eal/windows/eal.c               |   1 +
 5 files changed, 109 insertions(+), 54 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 31eff2c59d..a0b2243873 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -546,6 +546,10 @@ eal_reset_internal_config(void)
 	CPU_ZERO(&runtime_state->ctrl_cpuset);
 	runtime_state->init_complete = 0;
 	CPU_ZERO(&user_cfg->service_cpuset);
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		free(user_cfg->lcore_cpusets[i]);
+		user_cfg->lcore_cpusets[i] = NULL;
+	}
 	user_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
 	user_cfg->max_simd_bitwidth.forced = 0;
 }
@@ -913,23 +917,20 @@ eal_parse_service_corelist(const char *corelist, rte_cpuset_t *cpuset)
 	return CPU_COUNT(cpuset) > 0 ? 0 : -1;
 }
 
+/* Expand a flat cpuset into lcore_cpusets[], assigning lcore IDs.
+ * If remap is false:  lcore_id == physical CPU id (identity mapping).
+ * If remap is true:   lcore IDs are assigned sequentially from remap_base.
+ * Returns the number of lcores configured, or -1 on error.
+ */
 static int
-update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
+eal_expand_cpuset_to_map(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base,
+		rte_cpuset_t **lcore_cpusets)
 {
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int lcore_id = remap_base;
 	unsigned int count = 0;
 	unsigned int i;
 	int ret = 0;
 
-	/* set everything to disabled first, then set up values */
-	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		runtime_state->lcore_cfg[i].role = ROLE_OFF;
-		runtime_state->lcore_cfg[i].core_index = -1;
-	}
-
-	/* now go through the cpuset */
 	for (i = 0; i < CPU_SETSIZE; i++) {
 		if (CPU_ISSET(i, cpuset)) {
 			if (eal_cpu_detected(i) == 0) {
@@ -953,12 +954,17 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 				continue;
 			}
 
-			rte_bitset_set(runtime_state->core_indices, count);
-			runtime_state->lcore_cfg[lcore_id].role = ROLE_RTE;
-			runtime_state->lcore_cfg[lcore_id].core_index = count;
-			CPU_ZERO(&runtime_state->lcore_cfg[lcore_id].cpuset);
-			CPU_SET(i, &runtime_state->lcore_cfg[lcore_id].cpuset);
-			runtime_state->lcore_cfg[lcore_id].first_cpu = i;
+			lcore_cpusets[lcore_id] = malloc(sizeof(rte_cpuset_t));
+			if (lcore_cpusets[lcore_id] == NULL) {
+				EAL_LOG(ERR, "failed to allocate cpuset for lcore %u", lcore_id);
+				for (unsigned int j = 0; j < lcore_id; j++) {
+					free(lcore_cpusets[j]);
+					lcore_cpusets[j] = NULL;
+				}
+				return -1;
+			}
+			CPU_ZERO(lcore_cpusets[lcore_id]);
+			CPU_SET(i, lcore_cpusets[lcore_id]);
 			EAL_LOG(DEBUG, "lcore %u mapped to physical core %u", lcore_id, i);
 			lcore_id++;
 			count++;
@@ -968,9 +974,9 @@ update_lcore_config(const rte_cpuset_t *cpuset, bool remap, uint16_t remap_base)
 		EAL_LOG(ERR, "No valid lcores in core list");
 		ret = -1;
 	}
-	if (!ret)
-		runtime_state->lcore_count = count;
-	return ret;
+	if (ret == -1)
+		return -1;
+	return (int)count;
 }
 
 static int
@@ -1092,7 +1098,6 @@ eal_parse_main_lcore(const char *arg)
 	char *parsing_end;
 	long main_lcore;
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	errno = 0;
 	main_lcore = strtol(arg, &parsing_end, 0);
@@ -1106,8 +1111,9 @@ eal_parse_main_lcore(const char *arg)
 		EAL_LOG(ERR, "Error: Main lcore is used as a service core");
 		return -1;
 	}
-	/* check that we have the core recorded in the core list */
-	if (runtime_state->lcore_cfg[user_cfg->main_lcore].role != ROLE_RTE) {
+
+	/* lcore_cpusets is always populated before eal_parse_main_lcore is called */
+	if (user_cfg->lcore_cpusets[user_cfg->main_lcore] == NULL) {
 		EAL_LOG(ERR, "Error: Main lcore is not enabled for DPDK");
 		return -1;
 	}
@@ -1269,15 +1275,18 @@ check_cpuset(rte_cpuset_t *set)
  *   lcore 6 runs on cpuset 0x41 (cpu 0,6)
  *   lcore 7 runs on cpuset 0x80 (cpu 7)
  *   lcore 8 runs on cpuset 0x100 (cpu 8)
+ *
+ * Writes the physical-CPU affinity for each mentioned lcore_id into
+ * cpusets[lcore_id].  Slots not mentioned are left as NULL.
+ * Returns the number of distinct lcore IDs configured, or -1 on error.
  */
 static int
-eal_parse_lcores(const char *lcores)
+eal_parse_lcores_to_map(const char *lcores, rte_cpuset_t **cpusets)
 {
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	rte_cpuset_t lcore_set;
 	unsigned int set_count;
-	unsigned idx = 0;
-	unsigned count = 0;
+	unsigned int idx;
+	int count = 0;
 	const char *lcore_start = NULL;
 	const char *end = NULL;
 	int offset;
@@ -1294,15 +1303,6 @@ eal_parse_lcores(const char *lcores)
 
 	CPU_ZERO(&cpuset);
 
-	/* Reset lcore config */
-	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++) {
-		runtime_state->lcore_cfg[idx].role = ROLE_OFF;
-		runtime_state->lcore_cfg[idx].core_index = -1;
-		CPU_ZERO(&runtime_state->lcore_cfg[idx].cpuset);
-		runtime_state->lcore_cfg[idx].first_cpu = UINT16_MAX;
-	}
-
 	/* Get list of cores */
 	do {
 		while (isblank(*lcores))
@@ -1351,7 +1351,7 @@ eal_parse_lcores(const char *lcores)
 
 		/* without '@', by default using lcore_set as cpuset */
 		if (*lcores != '@')
-			rte_memcpy(&cpuset, &lcore_set, sizeof(cpuset));
+			memcpy(&cpuset, &lcore_set, sizeof(cpuset));
 
 		set_count = CPU_COUNT(&lcore_set);
 		/* start to update lcore_set */
@@ -1360,13 +1360,6 @@ eal_parse_lcores(const char *lcores)
 				continue;
 			set_count--;
 
-			if (runtime_state->lcore_cfg[idx].role != ROLE_RTE) {
-				rte_bitset_set(runtime_state->core_indices, count);
-				runtime_state->lcore_cfg[idx].core_index = count;
-				runtime_state->lcore_cfg[idx].role = ROLE_RTE;
-				count++;
-			}
-
 			if (lflags) {
 				CPU_ZERO(&cpuset);
 				CPU_SET(idx, &cpuset);
@@ -1374,10 +1367,16 @@ eal_parse_lcores(const char *lcores)
 
 			if (check_cpuset(&cpuset) < 0)
 				goto err;
-			rte_memcpy(&runtime_state->lcore_cfg[idx].cpuset, &cpuset,
-				   sizeof(rte_cpuset_t));
-			runtime_state->lcore_cfg[idx].first_cpu =
-					(uint16_t)(RTE_CPU_FFS(&cpuset) - 1);
+			if (cpusets[idx] == NULL) {
+				cpusets[idx] = malloc(sizeof(rte_cpuset_t));
+				if (cpusets[idx] == NULL) {
+					EAL_LOG(ERR, "failed to allocate cpuset for lcore %u", idx);
+					ret = -1;
+					goto err;
+				}
+				count++;
+			}
+			memcpy(cpusets[idx], &cpuset, sizeof(rte_cpuset_t));
 		}
 
 		/* some cores from the lcore_set can't be handled by EAL */
@@ -1390,11 +1389,14 @@ eal_parse_lcores(const char *lcores)
 	if (count == 0)
 		goto err;
 
-	runtime_state->lcore_count = count;
-	ret = 0;
-
+	ret = count;
 err:
-
+	if (ret == -1) {
+		for (unsigned int j = 0; j < RTE_MAX_LCORE; j++) {
+			free(cpusets[j]);
+			cpusets[j] = NULL;
+		}
+	}
 	return ret;
 }
 
@@ -2036,7 +2038,7 @@ eal_parse_args(void)
 
 	/* First handle the special case where we have explicit core mapping/remapping */
 	if (manual_lcore_mapping) {
-		if (eal_parse_lcores(args.lcores) < 0) {
+		if (eal_parse_lcores_to_map(args.lcores, user_cfg->lcore_cpusets) < 0) {
 			EAL_LOG(ERR, "invalid lcore mapping list: '%s'", args.lcores);
 			return -1;
 		}
@@ -2074,7 +2076,8 @@ eal_parse_args(void)
 			EAL_LOG(DEBUG, "Cores selected by %s: %s", cpuset_source, cpuset_str);
 			free(cpuset_str);
 		}
-		if (update_lcore_config(&cpuset, remap_lcores, lcore_id_base) < 0) {
+		if (eal_expand_cpuset_to_map(&cpuset, remap_lcores, lcore_id_base,
+				user_cfg->lcore_cpusets) < 0) {
 			char *available = available_cores();
 
 			EAL_LOG(ERR, "invalid coremask or core-list parameter, please check specified cores are part of %s",
@@ -2414,7 +2417,46 @@ eal_cleanup_config(void)
 	free(user_cfg->hugefile_prefix);
 	free(user_cfg->hugepage_dir);
 	free(user_cfg->user_mbuf_pool_ops_name);
+	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
+		free(user_cfg->lcore_cpusets[i]);
+		user_cfg->lcore_cpusets[i] = NULL;
+	}
+
+	return 0;
+}
+
+static int
+eal_apply_lcore_config(void)
+{
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+
+	/* lcore_cpusets[] is always populated at parse time for all input forms */
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	unsigned int i;
+	unsigned int count = 0;
 
+	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
+	for (i = 0; i < RTE_MAX_LCORE; i++) {
+		if (user_cfg->lcore_cpusets[i] == NULL) {
+			runtime_state->lcore_cfg[i].role = ROLE_OFF;
+			runtime_state->lcore_cfg[i].core_index = -1;
+			CPU_ZERO(&runtime_state->lcore_cfg[i].cpuset);
+			runtime_state->lcore_cfg[i].first_cpu = UINT16_MAX;
+			continue;
+		}
+		rte_bitset_set(runtime_state->core_indices, count);
+		runtime_state->lcore_cfg[i].role = ROLE_RTE;
+		runtime_state->lcore_cfg[i].core_index = count++;
+		memcpy(&runtime_state->lcore_cfg[i].cpuset,
+			user_cfg->lcore_cpusets[i], sizeof(rte_cpuset_t));
+		runtime_state->lcore_cfg[i].first_cpu =
+			(uint16_t)(RTE_CPU_FFS(&runtime_state->lcore_cfg[i].cpuset) - 1);
+	}
+	if (count == 0) {
+		EAL_LOG(ERR, "No valid lcores in core list");
+		return -1;
+	}
+	runtime_state->lcore_count = count;
 	return 0;
 }
 
@@ -2424,6 +2466,9 @@ eal_apply_runtime_state(void)
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
+	if (eal_apply_lcore_config() < 0)
+		return -1;
+
 	/* Apply service core roles: service_cpuset bits are lcore IDs */
 	if (CPU_COUNT(&user_cfg->service_cpuset) > 0) {
 		unsigned int i;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 2bce7ba662..5adc38a64c 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -138,7 +138,14 @@ struct eal_user_cfg {
 	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
 	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
 	rte_cpuset_t service_cpuset; /**<  each bit set is one lcore ID to use as service core */
-	int main_lcore;          /**< ID of the main lcore */
+
+	/** Per-lcore cpuset array, always populated at arg-parse time for all input forms
+	 * (-c coremask, -l corelist, --lcores with or without '@'/'()').
+	 * Each non-NULL slot is an individually heap-allocated rte_cpuset_t.
+	 * NULL means the corresponding lcore ID is not configured.
+	 */
+	rte_cpuset_t *lcore_cpusets[RTE_MAX_LCORE];
+	int            main_lcore;    /**< ID of the main lcore */
 };
 
 /**
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 9a976e2333..51604474cc 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -750,6 +750,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 err_out:
 	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_cleanup_config();
 	eal_clean_saved_args();
 	return -1;
 }
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c1869dde2d..ff75f6d430 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -925,6 +925,7 @@ rte_eal_init(int argc, char **argv)
 
 err_out:
 	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_cleanup_config();
 	eal_clean_saved_args();
 	return -1;
 }
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 734ad02c6a..d4c49f1560 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -414,6 +414,7 @@ rte_eal_init(int argc, char **argv)
 
 	return fctret;
 err_out:
+	eal_cleanup_config();
 	eal_clean_saved_args();
 	return -1;
 }
-- 
2.53.0

