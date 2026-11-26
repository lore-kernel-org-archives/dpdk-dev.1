Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6164606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AAuLF1Xp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5AF340E24;
	Thu, 26 Nov 2026 19:15:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 0104440E26
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716929; x=1827252929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z4uRj+rmh0ewHCrilz7xgDm2O5TyPYHtrk6L2DXrDjk=;
 b=AAuLF1Xpbsb0LbBjtBDqBZLa7MyeVjq9mCDgeI66ZSEfj4aseNfXfPrt
 jTjVGG6aIXbXRMUhPxCAlUgV8N74yo9bmxzKh7racdaxhhcLBCchYZOL5
 wz69+Y20hLjFBJ+r9EAnSxBB5qyhVn7MzWJ+JXXa8ECC70zydQeFoZKF3
 jgB9f39OgO2QvkyhvHYVIOXxVpy0nv45DVtnDio58srxNQ3XCdOady+Bk
 fUxBVYPPNCKP6fEf2CdKOs/37R/Xj6X7uaj+V0yo3RPfywErlhj39hIiO
 U6b2eJJ0+C9NYWuvCkZZaS7OdxfXlCMgYKWibrT64zuEwDFc+LiwGrSjF A==;
X-CSE-ConnectionGUID: ESDGoGYDRQG7WRvAUMzAkg==
X-CSE-MsgGUID: 1j6GJKG7QHe4qd01AsDy6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633639"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:28 -0800
X-CSE-ConnectionGUID: 9OPtUF/8R+q+y30SPYzdTg==
X-CSE-MsgGUID: hr7wHUZ/S4KV+KCv86sT1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733158"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:26 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 34/39] eal: move functions setting runtime state
Date: Thu, 26 Nov 2026 18:14:07 +0000
Message-ID: <20261126181414.124094-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The functions to configure some of the runtime state based on the
user-provided options no longer belong in eal_common_options.c, which
should instead be more focused on processing the user-provided options.
Move the functions to eal_common_config instead, and explicitly have the
runtime state setup function called from eal_init directly, rather than
hidden as a last step in arg parsing.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  | 170 +++++++++++++++++++++++++++-
 lib/eal/common/eal_common_options.c | 167 +--------------------------
 lib/eal/common/eal_options.h        |   3 -
 lib/eal/common/eal_private.h        |  33 ++++++
 lib/eal/freebsd/eal.c               |   6 +
 lib/eal/linux/eal.c                 |   6 +
 lib/eal/windows/eal.c               |   6 +
 7 files changed, 221 insertions(+), 170 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 6f131f3a3c..2eb7646e90 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -2,8 +2,10 @@
  * Copyright(c) 2020 Mellanox Technologies, Ltd
  */
 
-#include <rte_string_fns.h>
+#include <pthread.h>
 
+#include <rte_string_fns.h>
+#include <rte_thread.h>
 #include <eal_export.h>
 #include "eal_internal_cfg.h"
 #include "eal_private.h"
@@ -133,3 +135,169 @@ rte_eal_has_pci(void)
 {
 	return !eal_user_cfg.no_pci;
 }
+
+static void
+compute_ctrl_threads_cpuset(void)
+{
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	rte_cpuset_t *cpuset = &runtime_state->ctrl_cpuset;
+	rte_cpuset_t default_set;
+	unsigned int lcore_id;
+
+	CPU_ZERO(cpuset);
+	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
+			continue;
+		RTE_CPU_OR(cpuset, cpuset, &runtime_state->lcore_cfg[lcore_id].cpuset);
+	}
+	RTE_CPU_NOT(cpuset, cpuset);
+
+	if (rte_thread_get_affinity_by_id(rte_thread_self(), &default_set) != 0)
+		CPU_ZERO(&default_set);
+
+	RTE_CPU_AND(cpuset, cpuset, &default_set);
+
+	/* if no remaining cpu, use main lcore cpu affinity */
+	if (!CPU_COUNT(cpuset)) {
+		memcpy(cpuset, &runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset,
+			sizeof(*cpuset));
+	}
+
+	/* log the computed control thread cpuset for debugging */
+	char *cpuset_str = eal_cpuset_to_str(cpuset);
+	if (cpuset_str != NULL) {
+		EAL_LOG(DEBUG, "Control threads will use cores: %s", cpuset_str);
+		free(cpuset_str);
+	}
+}
+
+static int
+eal_apply_lcore_config(void)
+{
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+
+	/* lcore_cpusets[] is always populated at parse time for all input forms */
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	unsigned int i;
+	unsigned int count = 0;
+
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
+	return 0;
+}
+
+int
+eal_apply_runtime_state(void)
+{
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+
+	if (eal_apply_lcore_config() < 0)
+		return -1;
+
+	/* Apply service core roles: service_cpuset bits are lcore IDs */
+	if (CPU_COUNT(&user_cfg->service_cpuset) > 0) {
+		unsigned int i;
+		char *cpuset_str;
+
+		for (i = 0; i < RTE_MAX_LCORE; i++) {
+			if (!CPU_ISSET(i, &user_cfg->service_cpuset))
+				continue;
+			if (eal_cpu_detected(i) == 0) {
+				EAL_LOG(ERR, "Requested service lcore %u unavailable", i);
+				return -1;
+			}
+			if (runtime_state->lcore_cfg[i].role != ROLE_RTE) {
+				EAL_LOG(WARNING,
+					"service lcore %u is not in the enabled lcore set; please ensure -c or -l includes service cores",
+					i);
+			}
+			runtime_state->lcore_cfg[i].role = ROLE_SERVICE;
+		}
+		cpuset_str = eal_cpuset_to_str(&user_cfg->service_cpuset);
+		if (cpuset_str != NULL) {
+			EAL_LOG(DEBUG, "Service cores configured: %s", cpuset_str);
+			free(cpuset_str);
+		}
+	}
+
+	/* set the main lcore */
+	if (user_cfg->main_lcore != -1) {
+		runtime_state->main_lcore = user_cfg->main_lcore;
+	} else {
+		/* default main lcore is the first one */
+		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
+		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
+			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
+			return -1;
+		}
+	}
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+	/* create runtime data directory. In no_shconf mode, skip any errors */
+	if (eal_create_runtime_dir() < 0) {
+		if (!user_cfg->no_shconf) {
+			EAL_LOG(ERR, "Cannot create runtime directory");
+			return -1;
+		}
+		EAL_LOG(WARNING, "No DPDK runtime directory created");
+	}
+#endif
+
+	runtime_state->process_type = (user_cfg->process_type == RTE_PROC_AUTO) ?
+			eal_proc_type_detect() :
+			user_cfg->process_type;
+
+	compute_ctrl_threads_cpuset();
+
+	return 0;
+}
+
+int
+eal_apply_hugepage_mem_sz_limits(void)
+{
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	unsigned int i;
+
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		unsigned int j;
+		const uint64_t pagesz = platform_info->hugepage_info[i].hugepage_sz;
+		uint64_t limit;
+
+		/* assign default limits */
+		limit = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
+				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
+
+		/* override with user value for matching page size */
+		for (j = 0; j < user_cfg->num_pagesz_mem_overrides; j++) {
+			if (user_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
+				limit = user_cfg->pagesz_mem_overrides[j].limit;
+		}
+
+		runtime_state->hugepage_mem_sz_limits[i] = limit;
+	}
+
+	return 0;
+}
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 5e8040c3a9..bdf5a8b03d 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2307,42 +2307,7 @@ eal_parse_args(void)
 	for (int i = 0; i < RTE_MAX_NUMA_NODES; i++)
 		user_cfg->memory += user_cfg->numa_mem[i];
 
-	return eal_apply_runtime_state();
-}
-
-static void
-compute_ctrl_threads_cpuset(void)
-{
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	rte_cpuset_t *cpuset = &runtime_state->ctrl_cpuset;
-	rte_cpuset_t default_set;
-	unsigned int lcore_id;
-
-	CPU_ZERO(cpuset);
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		if (rte_lcore_has_role(lcore_id, RTE_LCORE_ROLE_OFF))
-			continue;
-		RTE_CPU_OR(cpuset, cpuset, &runtime_state->lcore_cfg[lcore_id].cpuset);
-	}
-	RTE_CPU_NOT(cpuset, cpuset);
-
-	if (rte_thread_get_affinity_by_id(rte_thread_self(), &default_set) != 0)
-		CPU_ZERO(&default_set);
-
-	RTE_CPU_AND(cpuset, cpuset, &default_set);
-
-	/* if no remaining cpu, use main lcore cpu affinity */
-	if (!CPU_COUNT(cpuset)) {
-		memcpy(cpuset, &runtime_state->lcore_cfg[rte_get_main_lcore()].cpuset,
-			sizeof(*cpuset));
-	}
-
-	/* log the computed control thread cpuset for debugging */
-	char *cpuset_str = eal_cpuset_to_str(cpuset);
-	if (cpuset_str != NULL) {
-		EAL_LOG(DEBUG, "Control threads will use cores: %s", cpuset_str);
-		free(cpuset_str);
-	}
+	return 0;
 }
 
 int
@@ -2370,136 +2335,6 @@ eal_cleanup_config(void)
 	return 0;
 }
 
-static int
-eal_apply_lcore_config(void)
-{
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
-	/* lcore_cpusets[] is always populated at parse time for all input forms */
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	unsigned int i;
-	unsigned int count = 0;
-
-	rte_bitset_clear_all(runtime_state->core_indices, RTE_MAX_LCORE);
-	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (user_cfg->lcore_cpusets[i] == NULL) {
-			runtime_state->lcore_cfg[i].role = ROLE_OFF;
-			runtime_state->lcore_cfg[i].core_index = -1;
-			CPU_ZERO(&runtime_state->lcore_cfg[i].cpuset);
-			runtime_state->lcore_cfg[i].first_cpu = UINT16_MAX;
-			continue;
-		}
-		rte_bitset_set(runtime_state->core_indices, count);
-		runtime_state->lcore_cfg[i].role = ROLE_RTE;
-		runtime_state->lcore_cfg[i].core_index = count++;
-		memcpy(&runtime_state->lcore_cfg[i].cpuset,
-			user_cfg->lcore_cpusets[i], sizeof(rte_cpuset_t));
-		runtime_state->lcore_cfg[i].first_cpu =
-			(uint16_t)(RTE_CPU_FFS(&runtime_state->lcore_cfg[i].cpuset) - 1);
-	}
-	if (count == 0) {
-		EAL_LOG(ERR, "No valid lcores in core list");
-		return -1;
-	}
-	runtime_state->lcore_count = count;
-	return 0;
-}
-
-int
-eal_apply_runtime_state(void)
-{
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-
-	if (eal_apply_lcore_config() < 0)
-		return -1;
-
-	/* Apply service core roles: service_cpuset bits are lcore IDs */
-	if (CPU_COUNT(&user_cfg->service_cpuset) > 0) {
-		unsigned int i;
-		char *cpuset_str;
-
-		for (i = 0; i < RTE_MAX_LCORE; i++) {
-			if (!CPU_ISSET(i, &user_cfg->service_cpuset))
-				continue;
-			if (eal_cpu_detected(i) == 0) {
-				EAL_LOG(ERR, "Requested service lcore %u unavailable", i);
-				return -1;
-			}
-			if (runtime_state->lcore_cfg[i].role != ROLE_RTE) {
-				EAL_LOG(WARNING,
-					"service lcore %u is not in the enabled lcore set; please ensure -c or -l includes service cores",
-					i);
-			}
-			runtime_state->lcore_cfg[i].role = ROLE_SERVICE;
-		}
-		cpuset_str = eal_cpuset_to_str(&user_cfg->service_cpuset);
-		if (cpuset_str != NULL) {
-			EAL_LOG(DEBUG, "Service cores configured: %s", cpuset_str);
-			free(cpuset_str);
-		}
-	}
-
-	/* set the main lcore */
-	if (user_cfg->main_lcore != -1) {
-		runtime_state->main_lcore = user_cfg->main_lcore;
-	} else {
-		/* default main lcore is the first one */
-		runtime_state->main_lcore = rte_get_next_lcore(-1, 0, 0);
-		if (runtime_state->main_lcore >= RTE_MAX_LCORE) {
-			EAL_LOG(ERR, "Main lcore is not enabled for DPDK");
-			return -1;
-		}
-	}
-
-#ifndef RTE_EXEC_ENV_WINDOWS
-	/* create runtime data directory. In no_shconf mode, skip any errors */
-	if (eal_create_runtime_dir() < 0) {
-		if (!user_cfg->no_shconf) {
-			EAL_LOG(ERR, "Cannot create runtime directory");
-			return -1;
-		}
-		EAL_LOG(WARNING, "No DPDK runtime directory created");
-	}
-#endif
-
-	runtime_state->process_type = (user_cfg->process_type == RTE_PROC_AUTO) ?
-			eal_proc_type_detect() : user_cfg->process_type;
-
-	compute_ctrl_threads_cpuset();
-
-	return 0;
-}
-
-int
-eal_apply_hugepage_mem_sz_limits(void)
-{
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	unsigned int i;
-
-	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
-		unsigned int j;
-		const uint64_t pagesz = platform_info->hugepage_info[i].hugepage_sz;
-		uint64_t limit;
-
-		/* assign default limits */
-		limit = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
-				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
-
-		/* override with user value for matching page size */
-		for (j = 0; j < user_cfg->num_pagesz_mem_overrides; j++) {
-			if (user_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
-				limit = user_cfg->pagesz_mem_overrides[j].limit;
-		}
-
-		runtime_state->hugepage_mem_sz_limits[i] = limit;
-	}
-
-	return 0;
-}
-
 RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 1ff9291170..77a6a4405f 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -13,10 +13,7 @@ struct eal_user_cfg;
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
-int eal_apply_hugepage_mem_sz_limits(void);
-int eal_apply_runtime_state(void);
 int eal_cleanup_config(void);
-enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
 void eal_clean_saved_args(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 798e60a359..edda0289fa 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -28,6 +28,39 @@
  */
 int eal_collate_args(int argc, char **argv);
 
+/**
+ * Apply user configuration to runtime state.
+ *
+ * Translates the populated eal_user_cfg into the eal_runtime_state,
+ * including lcore roles, main lcore, service cores, process type
+ * detection, and the runtime directory.
+ *
+ * @return
+ *   0 on success, negative on error
+ */
+int eal_apply_runtime_state(void);
+
+/**
+ * Detect the process type.
+ *
+ * Used to detect process type when the user requests process type auto-detection,
+ * rather than manually specifying primary or secondary.
+ * @return
+ *   The detected process type.
+ */
+enum rte_proc_type_t eal_proc_type_detect(void);
+
+/**
+ * Apply user-provided hugepage memory size overrides to the runtime state.
+ *
+ * Computes the per-hugepage-size memory limits, applying any user-supplied
+ * overrides on top of the default limits.
+ *
+ * @return
+ *   0 on success, negative on error
+ */
+int eal_apply_hugepage_mem_sz_limits(void);
+
 /**
  * Convert an rte_cpuset_t to string form suitable for parsing by argparse.
  *
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index cb82fc7619..47efe2f4b4 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -462,6 +462,12 @@ rte_eal_init(int argc, char **argv)
 		user_cfg->in_memory = false;
 	}
 
+	if (eal_apply_runtime_state() < 0) {
+		rte_eal_init_alert("Cannot apply runtime state.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
 	if (eal_plugins_init() < 0) {
 		rte_eal_init_alert("Cannot init plugins");
 		rte_errno = EINVAL;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 708c89122f..03e26584d6 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -615,6 +615,12 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
+	if (eal_apply_runtime_state() < 0) {
+		rte_eal_init_alert("Cannot apply runtime state.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
 	if (eal_plugins_init() < 0) {
 		rte_eal_init_alert("Cannot init plugins");
 		rte_errno = EINVAL;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index d8ebcd866b..37e43c9a62 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -222,6 +222,12 @@ rte_eal_init(int argc, char **argv)
 		user_cfg->no_shconf = true;
 	}
 
+	if (eal_apply_runtime_state() < 0) {
+		rte_eal_init_alert("Cannot apply runtime state.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
 	if (!user_cfg->no_hugetlbfs && (eal_hugepage_info_init() < 0)) {
 		rte_eal_init_alert("Cannot get hugepage information");
 		rte_errno = EACCES;
-- 
2.55.0

