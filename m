Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A2CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A5342759;
	Wed, 29 Apr 2026 18:59:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5A8EC40E2D;
 Wed, 29 Apr 2026 18:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481987; x=1809017987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y65zxN7eaGQW8KGzCMqn0as8f+fpP/sFw/Enuft7yho=;
 b=LVOl3ttv4yZ5VaLxMEe6C7obBjLbqebviQ7ES6EOLsA+int4BvunUKnN
 cngqDzviaFFh/ZSat1ffW0XOyKNlQi7I0w3UNrrpdeFpOMb/LcocPhClq
 FqsEdlBvSCfOEuC0WjzfmsTDjcWccWF20oC2jmKqendR6vVjjfMs3wlF0
 lRMAYTtghbzhoKdFNq4tlJkQbiVLEndQMLt3lomzznoCU1n1SjKWcEIYE
 lXx2fB1hRRToMzOS+nnRGW6p43lFj+b664rhovOyLmsCL1Ar967/8/soB
 LRO3iE+tt9SgmzBJv5KhQt78VFPtVVcAbJuOSkqX84Fz+R3oA8umsfx1v A==;
X-CSE-ConnectionGUID: zA9dZmhBTVSElD2J3HD/Qw==
X-CSE-MsgGUID: lWSBXJluTiCIxEF3eJzSPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725385"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725385"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:46 -0700
X-CSE-ConnectionGUID: e7VZCtMEReOX/o1qWBrZ/A==
X-CSE-MsgGUID: vN95q6x/R0SZh6+D9E39lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697204"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 36/44] eal: provide hooks for init with externally
 supplied config
Date: Wed, 29 Apr 2026 17:58:28 +0100
Message-ID: <20260429165845.2136843-37-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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
taking care of the run_once flag (since this flag needs to be in the top
level init function to avoid issues with trying to save off EAL args
twice), before calling the main initialization function with a
prepopulated config. Also, export internally the platform info function
so that any callers of this new function can do any necessary validation
of parameters as part of their setup.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  3 +-
 lib/eal/common/eal_common_lcore.c   |  8 ++---
 lib/eal/common/eal_common_thread.c  |  2 +-
 lib/eal/common/eal_internal_cfg.h   |  8 ++++-
 lib/eal/freebsd/eal.c               | 51 ++++++++++++++++++++++++---
 lib/eal/freebsd/eal_hugepage_info.c |  2 +-
 lib/eal/freebsd/eal_memory.c        |  6 ++--
 lib/eal/linux/eal.c                 | 49 ++++++++++++++++++++++++--
 lib/eal/linux/eal_hugepage_info.c   |  2 +-
 lib/eal/windows/eal.c               | 54 +++++++++++++++++++++++++++++
 lib/eal/windows/eal_hugepages.c     |  2 +-
 lib/eal/windows/eal_memalloc.c      |  2 +-
 12 files changed, 168 insertions(+), 21 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 9afe836903..9fff42b0b5 100644
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
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 98857c0e34..304e99eff2 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -53,7 +53,7 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	unsigned int cpu;
 
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -138,7 +138,7 @@ unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	unsigned int cpu = runtime_state->lcore_cfg[lcore_id].first_cpu;
 
 	if (cpu < platform_info->cpu_count)
@@ -247,7 +247,7 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
 unsigned int
 rte_socket_count(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	return platform_info->numa_node_count;
 }
 
@@ -255,7 +255,7 @@ RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
 int
 rte_socket_id_by_idx(unsigned int idx)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	if (idx >= platform_info->numa_node_count) {
 		rte_errno = EINVAL;
 		return -1;
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index 7256d06d0a..c3df4cd9ae 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -55,7 +55,7 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
 		RTE_PER_LCORE(_numa_id) = rte_lcore_to_socket_id(lcore_id);
 	} else {
 		/* Non-EAL thread: derive NUMA node from first CPU in cpuset. */
-		const struct eal_platform_info *platform_info = eal_get_platform_info();
+		const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 		unsigned int cpu;
 
 		RTE_PER_LCORE(_numa_id) = SOCKET_ID_ANY;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 31f2c2cf72..5a72b4c15e 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -24,6 +24,7 @@
 
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
+#include "rte_compat.h"
 
 /* Forward declaration — full definition is in eal_memcfg.h */
 struct rte_mem_config;
@@ -373,8 +374,13 @@ struct eal_runtime_state {
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
index 5e9348a2cd..1295e4e06b 100644
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
@@ -396,12 +399,11 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static uint32_t run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
 	/* first check if we have been run before */
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
 					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
 		rte_eal_init_alert("already called initialization.");
 		rte_errno = EALREADY;
@@ -440,7 +442,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -778,6 +780,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
index 18e388ef08..c23e203ec2 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -60,7 +60,7 @@ rte_eal_hugepage_init(void)
 	void *addr;
 	unsigned int i, j, seg_idx = 0;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* get pointer to global configuration */
@@ -270,7 +270,7 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 int
 rte_eal_hugepage_attach(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct hugepage_info *hpi;
 	int fd_hugepage = -1;
@@ -357,7 +357,7 @@ memseg_primary_init(void)
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, total_mem;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 75d03e3b3c..b0cc16a221 100644
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
@@ -559,12 +562,11 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static RTE_ATOMIC(uint32_t) run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
 	/* first check if we have been run before */
-	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
 					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
 		rte_eal_init_alert("already called initialization.");
 		rte_errno = EALREADY;
@@ -603,7 +605,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 
@@ -953,6 +955,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
index 738632bc20..482064acb8 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -506,7 +506,7 @@ hugepage_info_init(void)
 	unsigned int reusable_pages;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	int failed = 0;
 
 	/* platform_info->hugepage_sizes[] is already sorted largest to smallest */
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 021361a802..d24d58701b 100644
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
@@ -154,6 +157,15 @@ int
 rte_eal_init(int argc, char **argv)
 {
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
+	uint32_t has_run = 0;
+
+	/* first check if we have been run before */
+	if (!rte_atomic_compare_exchange_strong_explicit(&init_has_run, &has_run, 1,
+					rte_memory_order_relaxed, rte_memory_order_relaxed)) {
+		rte_eal_init_alert("already called initialization.");
+		rte_errno = EALREADY;
+		return -1;
+	}
 
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
@@ -187,6 +199,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -436,6 +449,47 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
2.51.0

