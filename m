Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C590C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B1B540F1A;
	Tue, 21 Jul 2026 11:46:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 196A540E54
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627197; x=1816163197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VOP/rSdYB8GEtNGZZOsz6MGmKYmahivxmjVL2Op0tuI=;
 b=WnbSFc333ZfKZM8MCg80myF/RySrRxNrT7WmxYHaLYvplVclgI++KT0i
 z/ZxYg5efAP/8cDj2YIu6D+TErxsaodS8RkGkkAV/KLfmOCKEN6GImtfP
 4k1e5Iqm+SZVTIb3FQ7trmOGnBx+wJtWDPhyC00gQZEQf4p8gkQZLDIFI
 dLHN20h7B9Jr204iubrz4f31LritpsxUZ5Vt2drvIAykzp65ka3iiXsFP
 aTLT1ZR2tL4EoSBasvL+X6RvgPj6fyLeXkuoN5Cn3P/Vge2cGONXMtHnV
 ad9KCncbCzzIuYf9kU9/IbVK0AmxTHN/pOV80B7JIf8t+oaI7sHRQv0r2 w==;
X-CSE-ConnectionGUID: rtvsVaztQxmBo7Val/XceA==
X-CSE-MsgGUID: kJMJR24tRDaq12oFDq5KFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872516"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872516"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:37 -0700
X-CSE-ConnectionGUID: ZWCJ8+UPSiS09+A5EK/kQQ==
X-CSE-MsgGUID: S/M0LfpWTDSHvlOXFH4uSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922448"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 34/39] eal: move functions setting runtime state
Date: Tue, 21 Jul 2026 10:45:42 +0100
Message-ID: <20260721094555.2188496-35-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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
index 35654cc71f..cec3fc9110 100644
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
@@ -127,3 +129,169 @@ rte_eal_has_pci(void)
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
index 653a08b375..08a3984b7e 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2308,42 +2308,7 @@ eal_parse_args(void)
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
-		if (rte_lcore_has_role(lcore_id, ROLE_OFF))
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
@@ -2371,136 +2336,6 @@ eal_cleanup_config(void)
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
index b1d3c69601..c460d66807 100644
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
index 58150e5a0f..e44d7fe58a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -463,6 +463,12 @@ rte_eal_init(int argc, char **argv)
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
index d56aa3c609..9162a7d68b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -619,6 +619,12 @@ rte_eal_init(int argc, char **argv)
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
index d4c49f1560..0978613ec6 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -217,6 +217,12 @@ rte_eal_init(int argc, char **argv)
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
2.53.0

