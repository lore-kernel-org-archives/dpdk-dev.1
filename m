Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337F0C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B2AA4111C;
	Tue, 21 Jul 2026 11:46:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6F7D340E25
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627204; x=1816163204;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RpOKlSy72dsLcO+EoXu+lWR25nzlGo/fSYphOGm2fP4=;
 b=nzPa5FMf3xzyeZ875SrnxM8PMH1EeNyN9CY+Ez2oCnKwanB/imfCZWhG
 +lR7tugKJz2+8l4VK/ij+xx1M0Fu3VI6h+SOFXNvhrxgn8gTZYQfpkfgg
 m46jUfnZsMXlyDwxs2gU4y46MkFMpNgVHGDwitOE69jIixGLGL+wH25ZG
 wmP+ouYPUWPts9DDLUI/RdxCopbJUTlLuyDnXUVs5sFEvmzh/llnkhmdg
 XyUqZ/6bVM/EubUgmfH9MfVytSu31p5aHUehhctk21q8NyWlOOCdjXHYW
 gE7dR7tXydytyb/kpRR3jnUUUHmI0CY3hVcFZ83ixfef2rcKcqaYPCy/H A==;
X-CSE-ConnectionGUID: usk2pYzVR+iZkbJdqg4EbA==
X-CSE-MsgGUID: dXdpiORGSx2Fak9rVfeQnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872527"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872527"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:42 -0700
X-CSE-ConnectionGUID: nIzPaqH+Tk+UPhOyc7Lpzw==
X-CSE-MsgGUID: 1C4jliZ9SJGE8X8NELlrSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922492"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 39/39] eal: provide hooks for init with externally supplied
 config
Date: Tue, 21 Jul 2026 10:45:47 +0100
Message-ID: <20260721094555.2188496-40-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that we have a split EAL init, where most work is done on a
configured eal_user_cfg structure, add in hooks to allow other libraries
to init EAL by passing in that structure pre-configured.

We export an internal function that wraps the second stage init, while
taking care of the run_once flag, before calling the main initialization
function with a prepopulated config.

Also, export internally the platform info function so that any callers
of this new function can do any necessary validation of parameters as
part of their setup.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  5 +--
 lib/eal/common/eal_common_lcore.c   |  6 ++--
 lib/eal/common/eal_common_thread.c  |  2 +-
 lib/eal/common/eal_internal_cfg.h   |  8 ++++-
 lib/eal/freebsd/eal.c               | 53 ++++++++++++++++++++++++---
 lib/eal/freebsd/eal_hugepage_info.c |  2 +-
 lib/eal/freebsd/eal_memory.c        |  6 ++--
 lib/eal/linux/eal.c                 | 51 +++++++++++++++++++++++---
 lib/eal/linux/eal_hugepage_info.c   |  2 +-
 lib/eal/windows/eal.c               | 56 ++++++++++++++++++++++++++++-
 lib/eal/windows/eal_hugepages.c     |  2 +-
 lib/eal/windows/eal_memalloc.c      |  2 +-
 12 files changed, 171 insertions(+), 24 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 97bb68069b..cb96680e5b 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -68,8 +68,9 @@ eal_get_user_configuration(void)
 }
 
 /* Return a pointer to the platform state structure */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_get_platform_info)
 const struct eal_platform_info *
-eal_get_platform_info(void)
+rte_eal_get_platform_info(void)
 {
 	/* platform-discovered and runtime EAL state */
 	static struct eal_platform_info eal_platform_info;
@@ -302,7 +303,7 @@ int
 eal_apply_hugepage_mem_sz_limits(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int i;
 
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 0020e6a178..7b2936489d 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -54,7 +54,7 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	unsigned int cpu;
 
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -267,7 +267,7 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
 unsigned int
 rte_socket_count(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	return platform_info->numa_node_count;
 }
 
@@ -275,7 +275,7 @@ RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
 int
 rte_socket_id_by_idx(unsigned int idx)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	if (idx >= platform_info->numa_node_count) {
 		rte_errno = EINVAL;
 		return -1;
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index a2e08242bd..b56dd4f2b6 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -40,7 +40,7 @@ unsigned rte_socket_id(void)
 int
 eal_cpuset_socket_id(const rte_cpuset_t *cpusetp)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	int socket_id = SOCKET_ID_ANY;
 
 	if (cpusetp == NULL)
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 120ce37a47..2115ee7fe2 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -25,6 +25,7 @@
 #include <rte_bitset.h>
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
+#include "rte_compat.h"
 
 /* Forward declaration — full definition is in eal_memcfg.h */
 struct rte_mem_config;
@@ -385,8 +386,13 @@ struct eal_runtime_state {
 	struct eal_solib_list loaded_plugins; /**< all plugins loaded by eal_plugins_init() */
 };
 
-const struct eal_platform_info *eal_get_platform_info(void);
+__rte_internal
+const struct eal_platform_info *rte_eal_get_platform_info(void);
 struct eal_user_cfg *eal_get_user_configuration(void);
 struct eal_runtime_state *eal_get_runtime_state(void);
 
+__rte_internal
+int
+rte_eal_runtime_init(const char *progname, const struct eal_user_cfg *user_provided_cfg);
+
 #endif /* EAL_INTERNAL_CFG_H */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 307b01f840..da51858ffe 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -59,6 +59,9 @@
 
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc */
 static int mem_cfg_fd = -1;
@@ -322,7 +325,7 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
@@ -396,7 +399,6 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static uint32_t run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
@@ -406,14 +408,14 @@ rte_eal_init(int argc, char **argv)
 	 * everything below depends on a valid platform_info, so confirm it
 	 * is available before doing anything else.
 	 */
-	if (eal_get_platform_info() == NULL) {
+	if (rte_eal_get_platform_info() == NULL) {
 		rte_eal_init_alert("Cannot get platform information.");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
 
 	/* first check if we have been run before */
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
 					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
 		rte_eal_init_alert("already called initialization.");
 		rte_errno = EALREADY;
@@ -452,7 +454,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -796,6 +798,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
 	return -1;
 }
 
+/**
+ * Initialize the DPDK runtime with a user-provided configuration.
+ * This is an alternative to rte_eal_init() that allows the caller to provide
+ * a configuration struct directly, instead of parsing command line arguments.
+ * Both parameters to the function must be non-NULL,
+ * and the user_provided_cfg must be fully initialized by the caller.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_runtime_init)
+int
+rte_eal_runtime_init(const char *progname, const struct eal_user_cfg *user_provided_cfg)
+{
+	uint32_t has_run = 0;
+
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		return -1;
+	}
+
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
+	eal_log_init(progname);
+
+	if (eal_runtime_init(user_provided_cfg) < 0) {
+		rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
+		return -1;
+	}
+	return 0;
+}
+
 RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index 9c97897cc3..28e1a04528 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -87,7 +87,7 @@ eal_get_platform_hp_info(struct eal_platform_info *platform_info)
 int
 eal_hugepage_info_init(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	int num_buffers, fd;
 	int64_t buffer_size;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index ffb44d8286..5fda56b1d3 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -72,7 +72,7 @@ rte_eal_hugepage_init(void)
 	void *addr;
 	unsigned int i, j, seg_idx = 0;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* get pointer to global configuration */
@@ -285,7 +285,7 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 int
 rte_eal_hugepage_attach(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct hugepage_info *hpi;
 	int fd_hugepage = -1;
@@ -354,7 +354,7 @@ memseg_primary_init(void)
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 920b8cb71a..9a9477ce0b 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -61,6 +61,9 @@
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 #define KERNEL_IOMMU_GROUPS_PATH "/sys/kernel/iommu_groups"
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc */
 static int mem_cfg_fd = -1;
@@ -559,7 +562,6 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static RTE_ATOMIC(uint32_t) run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
@@ -569,14 +571,14 @@ rte_eal_init(int argc, char **argv)
 	 * everything below depends on a valid platform_info, so confirm it
 	 * is available before doing anything else.
 	 */
-	if (eal_get_platform_info() == NULL) {
+	if (rte_eal_get_platform_info() == NULL) {
 		rte_eal_init_alert("Cannot get platform information.");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
 
 	/* first check if we have been run before */
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
 					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
 		rte_eal_init_alert("already called initialization.");
 		rte_errno = EALREADY;
@@ -615,7 +617,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 
@@ -971,6 +973,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
 	return -1;
 }
 
+/**
+ * Initialize the DPDK runtime with a user-provided configuration.
+ * This is an alternative to rte_eal_init() that allows the caller to provide
+ * a configuration struct directly, instead of parsing command line arguments.
+ * Both parameters to the function must be non-NULL,
+ * and the user_provided_cfg must be fully initialized by the caller.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_runtime_init)
+int
+rte_eal_runtime_init(const char *progname, const struct eal_user_cfg *user_provided_cfg)
+{
+	uint32_t has_run = 0;
+
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		return -1;
+	}
+
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
+	eal_log_init(progname);
+
+	if (eal_runtime_init(user_provided_cfg) < 0) {
+		rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
+		return -1;
+	}
+	return 0;
+}
+
 static int
 mark_freeable(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 		void *arg __rte_unused)
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index a6bf807f90..7be3fe3b65 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -518,7 +518,7 @@ hugepage_info_init(void)
 	unsigned int reusable_pages;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	int failed = 0;
 
 	/* platform_info->hugepage_sizes[] is already sorted largest to smallest */
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 720a1e0502..9a87140b3f 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -34,6 +34,9 @@
 
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc
  */
@@ -154,6 +157,7 @@ int
 rte_eal_init(int argc, char **argv)
 {
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
+	uint32_t has_run = 0;
 
 	/*
 	 * platform_info is lazily initialized on first use, and that
@@ -161,12 +165,20 @@ rte_eal_init(int argc, char **argv)
 	 * everything below depends on a valid platform_info, so confirm it
 	 * is available before doing anything else.
 	 */
-	if (eal_get_platform_info() == NULL) {
+	if (rte_eal_get_platform_info() == NULL) {
 		rte_eal_init_alert("Cannot get platform information.");
 		rte_errno = ENOTSUP;
 		return -1;
 	}
 
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
@@ -199,6 +211,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -454,6 +467,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
 	return -1;
 }
 
+/**
+ * Initialize the DPDK runtime with a user-provided configuration.
+ * This is an alternative to rte_eal_init() that allows the caller to provide
+ * a configuration struct directly, instead of parsing command line arguments.
+ * Both parameters to the function must be non-NULL,
+ * and the user_provided_cfg must be fully initialized by the caller.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_runtime_init)
+int
+rte_eal_runtime_init(const char *progname, const struct eal_user_cfg *user_provided_cfg)
+{
+	uint32_t has_run = 0;
+
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		return -1;
+	}
+
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
+
+	eal_log_init(progname);
+
+	if (eal_runtime_init(user_provided_cfg) < 0) {
+		rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
+		return -1;
+	}
+	return 0;
+}
+
 /* Don't use MinGW asprintf() to have identical code with all toolchains. */
 int
 eal_asprintf(char **buffer, const char *format, ...)
diff --git a/lib/eal/windows/eal_hugepages.c b/lib/eal/windows/eal_hugepages.c
index 0c62f5ff48..0870495c78 100644
--- a/lib/eal/windows/eal_hugepages.c
+++ b/lib/eal/windows/eal_hugepages.c
@@ -59,7 +59,7 @@ hugepage_claim_privilege(void)
 static int
 hugepage_info_init(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct hugepage_info *hpi;
 	unsigned int socket_id;
 	int ret = 0;
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 3ab8af0466..0c34c65603 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -314,7 +314,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	int ret = -1;
 	struct alloc_walk_param wa;
 	const struct hugepage_info *hi = NULL;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-- 
2.53.0

