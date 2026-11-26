Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C917606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WGe6ymGF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81DFF40ED0;
	Thu, 26 Nov 2026 19:15:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 2280E40609
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716934; x=1827252934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+VG7WvLrPFAawF46A7+9J35ojpmgYQWUB30Kj3Tpu2Q=;
 b=WGe6ymGFY5kQRkJUKCsax64GSgovmQTMM1+ssGEgI15Iva+hAmbSkyed
 vew3QFf5LNPCT5H2B804Ld31qW9RZ2+D3DijL1K+6ctA+sKjzogt+UF2Y
 EBefXCmeV0yXW4Ad0aTRid2sK4omvKltX3UTBFsW7KX9Z/gNebzV+LSHN
 ow5HFH9Dm3FMs14S0/fnwBmW6Iie0ogoYrPGCSAZCLnbICy4efG761K/7
 L7u+UaImv8WJ79n3NgW6N51Mi8qmf48RpPVDTKyugcZXbHTWMh/D7Y9bz
 3rKz7LzRrE3bNCIUq3fVSveE6LnaklWVrK3LOkLpIb98D7hm/WeNmynSl A==;
X-CSE-ConnectionGUID: PMe14P1xQd6ht/ZkafjVWw==
X-CSE-MsgGUID: edXrlT+PSB+kKR1bHyvWpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633646"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633646"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:33 -0800
X-CSE-ConnectionGUID: DdsgYS7FSWWvtkhOqzMHzQ==
X-CSE-MsgGUID: hv6OgNpcS7yfqwUgL9dbUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733186"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 39/39] eal: provide hooks for init with externally supplied
 config
Date: Thu, 26 Nov 2026 18:14:12 +0000
Message-ID: <20261126181414.124094-40-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 lib/eal/common/eal_common_config.c  |  5 ++-
 lib/eal/common/eal_common_lcore.c   |  6 +--
 lib/eal/common/eal_common_thread.c  |  2 +-
 lib/eal/common/eal_internal_cfg.h   |  8 +++-
 lib/eal/freebsd/eal.c               | 57 ++++++++++++++++++++++++---
 lib/eal/freebsd/eal_hugepage_info.c |  2 +-
 lib/eal/freebsd/eal_memory.c        |  6 +--
 lib/eal/linux/eal.c                 | 55 ++++++++++++++++++++++++--
 lib/eal/linux/eal_hugepage_info.c   |  2 +-
 lib/eal/windows/eal.c               | 60 ++++++++++++++++++++++++++++-
 lib/eal/windows/eal_hugepages.c     |  2 +-
 lib/eal/windows/eal_memalloc.c      |  2 +-
 12 files changed, 183 insertions(+), 24 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 110921ae93..73074f2520 100644
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
@@ -305,7 +306,7 @@ int
 eal_apply_hugepage_mem_sz_limits(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int i;
 
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 842230e729..47a754a990 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -55,7 +55,7 @@ RTE_EXPORT_SYMBOL(rte_lcore_to_cpu_id)
 int rte_lcore_to_cpu_id(int lcore_id)
 {
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	unsigned int cpu;
 
 	if (unlikely(lcore_id >= RTE_MAX_LCORE))
@@ -278,7 +278,7 @@ RTE_EXPORT_SYMBOL(rte_socket_count)
 unsigned int
 rte_socket_count(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	return platform_info->numa_node_count;
 }
 
@@ -286,7 +286,7 @@ RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
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
index 935d322345..ecc17e94e1 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -25,6 +25,7 @@
 #include <rte_bitset.h>
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
+#include "rte_compat.h"
 
 /* Forward declaration — full definition is in eal_memcfg.h */
 struct rte_mem_config;
@@ -390,8 +391,13 @@ struct eal_runtime_state {
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
index 365d22f209..92588aaf91 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -58,6 +58,9 @@
 
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc */
 static int mem_cfg_fd = -1;
@@ -321,7 +324,7 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
@@ -395,7 +398,6 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static uint32_t run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
@@ -405,14 +407,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -451,7 +453,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -795,6 +797,51 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
+	rte_errno = 0;
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		/* Set an error if previous caller has not set one.*/
+		if (rte_errno == 0)
+			rte_errno = ENOTSUP;
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
index b8d23a1dc8..4579da20b9 100644
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
@@ -289,7 +289,7 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 int
 rte_eal_hugepage_attach(void)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct hugepage_info *hpi;
 	int fd_hugepage = -1;
@@ -358,7 +358,7 @@ memseg_primary_init(void)
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 89a04d183d..d45276e19c 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -58,6 +58,9 @@
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 #define KERNEL_IOMMU_GROUPS_PATH "/sys/kernel/iommu_groups"
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc */
 static int mem_cfg_fd = -1;
@@ -555,7 +558,6 @@ RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	static RTE_ATOMIC(uint32_t) run_once;
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
 
@@ -565,14 +567,14 @@ rte_eal_init(int argc, char **argv)
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
@@ -611,7 +613,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 
@@ -979,6 +981,51 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
+	rte_errno = 0;
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		/* Set an error if previous caller has not set one.*/
+		if (rte_errno == 0)
+			rte_errno = ENOTSUP;
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
index 6a93a8dd21..5a8bfd1283 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -33,6 +33,9 @@
 
 #define MEMSIZE_IF_NO_HUGE_PAGE (64ULL * 1024ULL * 1024ULL)
 
+/* flag to prevent double-init of EAL */
+static RTE_ATOMIC(uint32_t) init_has_run;
+
 /* define fd variable here, because file needs to be kept open for the
  * duration of the program, as we hold a write lock on it in the primary proc
  */
@@ -159,6 +162,7 @@ int
 rte_eal_init(int argc, char **argv)
 {
 	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
+	uint32_t has_run = 0;
 
 	/*
 	 * platform_info is lazily initialized on first use, and that
@@ -166,12 +170,20 @@ rte_eal_init(int argc, char **argv)
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
 
@@ -204,6 +216,7 @@ rte_eal_init(int argc, char **argv)
 	return fctret;
 
 err_out:
+	rte_atomic_store_explicit(&init_has_run, 0, rte_memory_order_relaxed);
 	eal_clean_saved_args();
 	eal_user_cfg_cleanup(&user_cfg_from_args);
 	return -1;
@@ -459,6 +472,51 @@ eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
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
+	rte_errno = 0;
+	if (progname == NULL || user_provided_cfg == NULL) {
+		rte_eal_init_alert("Invalid arguments to rte_eal_runtime_init.");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (rte_eal_get_platform_info() == NULL) {
+		rte_eal_init_alert("Platform information is not available.");
+		/* Set an error if previous caller has not set one.*/
+		if (rte_errno == 0)
+			rte_errno = ENOTSUP;
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
index 8a2d3966ba..97947d1bc4 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -319,7 +319,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	int ret = -1;
 	struct alloc_walk_param wa;
 	const struct hugepage_info *hi = NULL;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = rte_eal_get_platform_info();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-- 
2.55.0

