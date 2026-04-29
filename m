Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198F5FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C1D942708;
	Wed, 29 Apr 2026 18:59:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6B3CA410D5;
 Wed, 29 Apr 2026 18:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481977; x=1809017977;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8LRDDWjX1fZLZG263wpNNAfLLt+RSOjujwrF0SElqpY=;
 b=Loa0VmjvXvkZYie41Oe+GX/iwZUcSrhqL9HCVg97i7U0aUNJ/Ow7LITR
 bcry3Dce+U+ZOF5mAoxWLTd2ZrJuE4uGtyk4m1hG0MHDQNqnOadlBufEv
 c3SxqJchuiFlqZTjEGDEwkDlbZao//mprPo9lEeRbfoLLAylmAF5CtxnX
 XRFms+fJQhLFLmuDY2SEviysE1rMxP9dsNYBbnrlUpYWVjMxEttvGZfeE
 dxYugkVOsSV2nJmeh8trmPhScAesIjUKWF8qd23d6BaIebwVs/mxMN3NI
 0rBEtTHeVj3PuJxQsqqgCf36DHXZQvR/HSLEm6DFZNqqPpTr6lz866thW w==;
X-CSE-ConnectionGUID: 1dVQ2AKvQEOUVsST0mmYHg==
X-CSE-MsgGUID: kOOxeDYLSz6HOKR158n8bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725358"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725358"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:37 -0700
X-CSE-ConnectionGUID: g1jpXYh4R4OMNAM8Nx9LMA==
X-CSE-MsgGUID: zOV3upO+S3uUjzMVtS9APg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697049"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 32/44] eal: initialize platform info on first use
Date: Wed, 29 Apr 2026 17:58:24 +0100
Message-ID: <20260429165845.2136843-33-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

The platform information should be made available as early in the init
process as possible, since it should be fixed and not depend on any
application or user provided data. Therefore, rework the hugepage info
so that the basic HP info only is stored in the platform info struct,
and things like lock fd's are found in the runtime state struct.

Then start enhancing the get_platform_info structure so that it is
initialized on first use, rather than having it initialized as part of
the normal flow of rte_eal_init(). The objective is to have the platform
info, both cpu and memory, fully available when processing the user
configuration parameters, in order to properly validate them.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  31 +++++++-
 lib/eal/common/eal_common_dynmem.c  |  26 +++----
 lib/eal/common/eal_common_lcore.c   |   8 +-
 lib/eal/common/eal_hugepages.h      |   8 ++
 lib/eal/common/eal_internal_cfg.h   |  15 +++-
 lib/eal/common/eal_private.h        |  18 ++++-
 lib/eal/freebsd/eal.c               |  11 +--
 lib/eal/freebsd/eal_hugepage_info.c |  60 +++++++++++----
 lib/eal/freebsd/eal_memory.c        |  15 ++--
 lib/eal/linux/eal.c                 |  18 ++---
 lib/eal/linux/eal_hugepage_info.c   | 114 +++++++++++++++++++++++-----
 lib/eal/linux/eal_memalloc.c        |  24 +++---
 lib/eal/linux/eal_memory.c          |  58 +++++++-------
 lib/eal/windows/eal.c               |  12 ---
 lib/eal/windows/eal_hugepages.c     |  35 ++++++++-
 lib/eal/windows/eal_memalloc.c      |  11 +--
 lib/eal/windows/eal_windows.h       |   8 --
 17 files changed, 323 insertions(+), 149 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 60eeea6439..9afe836903 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -10,6 +10,7 @@
 #include "eal_internal_cfg.h"
 #include "eal_private.h"
 #include "eal_filesystem.h"
+#include "eal_hugepages.h"
 #include "eal_memcfg.h"
 
 /* early configuration structure, when memory config is not mmapped */
@@ -28,9 +29,6 @@ static char runtime_dir[UNIX_PATH_MAX];
 /* user-provided EAL configuration */
 static struct eal_user_cfg eal_user_cfg;
 
-/* platform-discovered and runtime EAL state */
-static struct eal_platform_info eal_platform_info;
-
 /* internal runtime configuration */
 static struct eal_runtime_state eal_runtime_state = {
 	.mem_config = &early_mem_config,
@@ -70,9 +68,34 @@ eal_get_user_configuration(void)
 }
 
 /* Return a pointer to the platform state structure */
-struct eal_platform_info *
+const struct eal_platform_info *
 eal_get_platform_info(void)
 {
+	/* platform-discovered and runtime EAL state */
+	static struct eal_platform_info eal_platform_info;
+	static rte_spinlock_t init_lock = RTE_SPINLOCK_INITIALIZER;
+	static RTE_ATOMIC(bool) initialized;
+
+	if (unlikely(!rte_atomic_load_explicit(&initialized, rte_memory_order_acquire))) {
+		rte_spinlock_lock(&init_lock);
+		if (rte_atomic_load_explicit(&initialized, rte_memory_order_relaxed)) {
+			rte_spinlock_unlock(&init_lock);
+			return &eal_platform_info;
+		}
+		if (rte_eal_cpu_init(&eal_platform_info) < 0) {
+			EAL_LOG(ERR, "Failed to initialise CPU information");
+			rte_spinlock_unlock(&init_lock);
+			return NULL;
+		}
+		if (eal_get_platform_hp_info(&eal_platform_info) < 0) {
+			EAL_LOG(ERR, "Failed to get platform hugepage information");
+			rte_spinlock_unlock(&init_lock);
+			return NULL;
+		}
+		rte_atomic_store_explicit(&initialized, true, rte_memory_order_release);
+		rte_spinlock_unlock(&init_lock);
+	}
+
 	return &eal_platform_info;
 }
 
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 629cec7ccc..a1471bdff0 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -30,7 +30,7 @@ eal_dynmem_memseg_lists_init(void)
 	uint64_t max_mem, max_mem_per_type;
 	unsigned int max_seglists_per_type;
 	unsigned int n_memtypes, cur_type;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
@@ -73,7 +73,7 @@ eal_dynmem_memseg_lists_init(void)
 	 */
 
 	/* create space for mem types */
-	n_memtypes = platform_info->num_hugepage_sizes * rte_socket_count();
+	n_memtypes = runtime_state->num_hugepage_sizes * rte_socket_count();
 	memtypes = calloc(n_memtypes, sizeof(*memtypes));
 	if (memtypes == NULL) {
 		EAL_LOG(ERR, "Cannot allocate space for memory types");
@@ -82,12 +82,12 @@ eal_dynmem_memseg_lists_init(void)
 
 	/* populate mem types */
 	cur_type = 0;
-	for (hpi_idx = 0; hpi_idx < (int) platform_info->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < (int) runtime_state->num_hugepage_sizes;
 			hpi_idx++) {
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 
-		hpi = &platform_info->hugepage_info[hpi_idx];
+		hpi = &runtime_state->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
 		for (i = 0; i < (int) rte_socket_count(); i++, cur_type++) {
@@ -228,13 +228,13 @@ eal_dynmem_hugepage_init(void)
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
 	uint64_t memory[RTE_MAX_NUMA_NODES];
 	int hp_sz_idx, socket_id;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	memset(used_hp, 0, sizeof(used_hp));
 
 	for (hp_sz_idx = 0;
-			hp_sz_idx < (int) platform_info->num_hugepage_sizes;
+			hp_sz_idx < (int) runtime_state->num_hugepage_sizes;
 			hp_sz_idx++) {
 #ifndef RTE_ARCH_64
 		struct hugepage_info dummy;
@@ -242,7 +242,7 @@ eal_dynmem_hugepage_init(void)
 #endif
 		/* also initialize used_hp hugepage sizes in used_hp */
 		struct hugepage_info *hpi;
-		hpi = &platform_info->hugepage_info[hp_sz_idx];
+		hpi = &runtime_state->hugepage_info[hp_sz_idx];
 		used_hp[hp_sz_idx].hugepage_sz = hpi->hugepage_sz;
 
 #ifndef RTE_ARCH_64
@@ -270,12 +270,12 @@ eal_dynmem_hugepage_init(void)
 
 	/* calculate final number of pages */
 	if (eal_dynmem_calc_num_pages_per_socket(memory,
-			platform_info->hugepage_info, used_hp,
-			platform_info->num_hugepage_sizes) < 0)
+			runtime_state->hugepage_info, used_hp,
+			runtime_state->num_hugepage_sizes) < 0)
 		return -1;
 
 	for (hp_sz_idx = 0;
-			hp_sz_idx < (int)platform_info->num_hugepage_sizes;
+			hp_sz_idx < (int)runtime_state->num_hugepage_sizes;
 			hp_sz_idx++) {
 		for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES;
 				socket_id++) {
@@ -354,10 +354,10 @@ get_socket_mem_size(int socket)
 {
 	uint64_t size = 0;
 	unsigned int i;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
+	for (i = 0; i < runtime_state->num_hugepage_sizes; i++) {
+		struct hugepage_info *hpi = &runtime_state->hugepage_info[i];
 		size += hpi->hugepage_sz * hpi->num_pages[socket];
 	}
 
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index bafcfe78d2..98857c0e34 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -165,11 +165,15 @@ socket_id_cmp(const void *a, const void *b)
  * structure.
  */
 int
-rte_eal_cpu_init(void)
+rte_eal_cpu_init(struct eal_platform_info *platform_info)
 {
-	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int *lcore_to_socket_id;
 
+	if (eal_create_cpu_map() < 0) {
+		EAL_LOG(ERR, "Failed to create CPU map");
+		return -1;
+	}
+
 	/* allocate cpu_info for all CPUs visible to the OS */
 	platform_info->cpu_count = eal_cpu_max();
 	platform_info->cpu_info = calloc(platform_info->cpu_count,
diff --git a/lib/eal/common/eal_hugepages.h b/lib/eal/common/eal_hugepages.h
index 1b560d3379..b30ff12f2d 100644
--- a/lib/eal/common/eal_hugepages.h
+++ b/lib/eal/common/eal_hugepages.h
@@ -11,6 +11,8 @@
 
 #define MAX_HUGEPAGE_PATH PATH_MAX
 
+struct eal_platform_info;
+
 /**
  * Structure used to store information about hugepages that we mapped
  * through the files in hugetlbfs.
@@ -25,6 +27,12 @@ struct hugepage_file {
 	char filepath[MAX_HUGEPAGE_PATH]; /**< path to backing file on filesystem */
 };
 
+/**
+ * Discover hugepage sizes and mounts available on this platform and populate
+ * the hugepage_sizes[] fields of the provided platform_info struct.
+ */
+int eal_get_platform_hp_info(struct eal_platform_info *platform_info);
+
 /**
  * Read the information on what hugepages are available for the EAL to use,
  * clearing out any unused ones.
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 979c1320e8..b5962d6081 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -151,6 +151,14 @@ struct eal_cpu_info {
 	unsigned int core_id;  /**< physical core number on its NUMA node */
 };
 
+struct hp_sizes {
+	uint64_t size;         /**< hugepage size in bytes */
+	char dir[PATH_MAX];    /**< dir where hugetlbfs is mounted for this size */
+	uint32_t total_pages;  /**< total hugepages of this size across all NUMA nodes */
+	uint32_t max_pages[RTE_MAX_NUMA_NODES];
+	/**< maximum hugepages of this size available on each NUMA node */
+};
+
 /**
  * Discovered information about the system hardware.
  * Immutable after discovery.
@@ -161,7 +169,7 @@ struct eal_platform_info {
 	uint32_t numa_node_count;        /**< number of detected NUMA nodes */
 	uint32_t *numa_nodes;            /**< sorted list of detected NUMA node IDs, heap-allocated */
 	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
-	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
+	struct hp_sizes hugepage_sizes[MAX_HUGEPAGE_SIZES];
 };
 
 /**
@@ -206,12 +214,15 @@ struct eal_runtime_state {
 	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
+
+	uint32_t num_hugepage_sizes;       /**< how many sizes stored in hugepage_info[] */
+	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
 	struct eal_solib_list loaded_plugins; /**< all plugins loaded by eal_plugins_init() */
 };
 
+const struct eal_platform_info *eal_get_platform_info(void);
 struct eal_user_cfg *eal_get_user_configuration(void);
-struct eal_platform_info *eal_get_platform_info(void);
 struct eal_runtime_state *eal_get_runtime_state(void);
 
 #endif /* EAL_INTERNAL_CFG_H */
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 877c0840ec..5d9cc0886f 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -77,10 +77,12 @@ int rte_eal_memzone_init(void);
  * Parse /proc/cpuinfo to get the number of physical and logical
  * processors on the machine.
  *
+ * @param platform_info
+ *   Platform info struct to populate with CPU topology.
  * @return
  *   0 on success, negative on error
  */
-int rte_eal_cpu_init(void);
+int rte_eal_cpu_init(struct eal_platform_info *platform_info);
 
 /**
  * Check for architecture supported MMU.
@@ -731,6 +733,20 @@ int eal_asprintf(char **buffer, const char *format, ...);
 		eal_asprintf(buffer, format, ##__VA_ARGS__)
 #endif
 
+/**
+ * Create a map of processors and cores on the system.
+ *
+ * @return
+ *  0 on success, (-1) on failure and rte_errno is set.
+ */
+#ifdef RTE_EXEC_ENV_WINDOWS
+int eal_create_cpu_map(void);
+#else
+/* non-Windows platforms do not require CPU map creation, define stub fn */
+static inline int
+eal_create_cpu_map(void) { return 0; }
+#endif
+
 #define EAL_LOG(level, ...) \
 	RTE_LOG_LINE(level, EAL, "" __VA_ARGS__)
 
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 2245ffc5ac..4f4b9accfe 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -322,10 +322,11 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
+		struct hugepage_info *hpi = &runtime_state->hugepage_info[i];
 		if (strnlen(hpi->hugedir, sizeof(hpi->hugedir)) != 0) {
 			for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 				size += hpi->hugepage_sz * hpi->num_pages[j];
@@ -444,12 +445,6 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_eal_cpu_init() < 0) {
-		rte_eal_init_alert("Cannot detect lcores.");
-		rte_errno = ENOTSUP;
-		goto err_out;
-	}
-
 	if (eal_parse_args() < 0) {
 		rte_eal_init_alert("Error parsing command-line arguments.");
 		rte_errno = EINVAL;
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index b46ae4b689..63dc734142 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -51,22 +51,53 @@ create_shared_memory(const char *filename, const size_t mem_size)
 /*
  * No hugepage support on freebsd, but we dummy it, using contigmem driver
  */
+int
+eal_get_platform_hp_info(struct eal_platform_info *platform_info)
+{
+	size_t sysctl_size;
+	int num_buffers, error;
+	int64_t buffer_size;
+
+	sysctl_size = sizeof(num_buffers);
+	error = sysctlbyname("hw.contigmem.num_buffers", &num_buffers,
+			&sysctl_size, NULL, 0);
+	if (error != 0) {
+		EAL_LOG(ERR, "could not read sysctl hw.contigmem.num_buffers");
+		return -1;
+	}
+
+	sysctl_size = sizeof(buffer_size);
+	error = sysctlbyname("hw.contigmem.buffer_size", &buffer_size,
+			&sysctl_size, NULL, 0);
+	if (error != 0) {
+		EAL_LOG(ERR, "could not read sysctl hw.contigmem.buffer_size");
+		return -1;
+	}
+
+	platform_info->num_hugepage_sizes = 1;
+	platform_info->hugepage_sizes[0].size = buffer_size;
+	strlcpy(platform_info->hugepage_sizes[0].dir, CONTIGMEM_DEV,
+			sizeof(platform_info->hugepage_sizes[0].dir));
+	platform_info->hugepage_sizes[0].max_pages[0] = num_buffers;
+	platform_info->hugepage_sizes[0].total_pages = num_buffers;
+
+	return 0;
+}
+
 int
 eal_hugepage_info_init(void)
 {
 	size_t sysctl_size;
 	int num_buffers, fd, error;
 	int64_t buffer_size;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* re-use the linux "internal config" structure for our memory data */
-	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
+	struct hugepage_info *hpi = &runtime_state->hugepage_info[0];
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct hugepage_info *tmp_hpi;
 	unsigned int i;
 
-	platform_info->num_hugepage_sizes = 1;
-
 	sysctl_size = sizeof(num_buffers);
 	error = sysctlbyname("hw.contigmem.num_buffers", &num_buffers,
 			&sysctl_size, NULL, 0);
@@ -109,29 +140,30 @@ eal_hugepage_info_init(void)
 	hpi->hugepage_sz = buffer_size;
 	hpi->num_pages[0] = num_buffers;
 	hpi->lock_descriptor = fd;
+	runtime_state->num_hugepage_sizes = 1;
 
 	/* for no shared files mode, do not create shared memory config */
 	if (user_cfg->no_shconf)
 		return 0;
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
-			sizeof(platform_info->hugepage_info));
+			sizeof(runtime_state->hugepage_info));
 	if (tmp_hpi == NULL ) {
 		EAL_LOG(ERR, "Failed to create shared memory!");
 		return -1;
 	}
 
-	memcpy(tmp_hpi, hpi, sizeof(platform_info->hugepage_info));
+	memcpy(tmp_hpi, hpi, sizeof(runtime_state->hugepage_info));
 
 	/* we've copied file descriptors along with everything else, but they
 	 * will be invalid in secondary process, so overwrite them
 	 */
-	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(runtime_state->hugepage_info); i++) {
 		struct hugepage_info *tmp = &tmp_hpi[i];
 		tmp->lock_descriptor = -1;
 	}
 
-	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(runtime_state->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
@@ -143,23 +175,23 @@ eal_hugepage_info_init(void)
 int
 eal_hugepage_info_read(void)
 {
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
+	struct hugepage_info *hpi = &runtime_state->hugepage_info[0];
 	struct hugepage_info *tmp_hpi;
 
-	platform_info->num_hugepage_sizes = 1;
+	runtime_state->num_hugepage_sizes = 1;
 
 	tmp_hpi = open_shared_memory(eal_hugepage_info_path(),
-				  sizeof(platform_info->hugepage_info));
+				  sizeof(runtime_state->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to open shared memory!");
 		return -1;
 	}
 
-	memcpy(hpi, tmp_hpi, sizeof(platform_info->hugepage_info));
+	memcpy(hpi, tmp_hpi, sizeof(runtime_state->hugepage_info));
 
-	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(runtime_state->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index cf0c5b7332..18e388ef08 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -60,7 +60,8 @@ rte_eal_hugepage_init(void)
 	void *addr;
 	unsigned int i, j, seg_idx = 0;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* get pointer to global configuration */
 	mcfg = eal_get_mcfg();
@@ -106,7 +107,7 @@ rte_eal_hugepage_init(void)
 		uint64_t page_sz, mem_needed;
 		unsigned int n_pages, max_pages;
 
-		hpi = &platform_info->hugepage_info[i];
+		hpi = &runtime_state->hugepage_info[i];
 		page_sz = hpi->hugepage_sz;
 		max_pages = hpi->num_pages[0];
 		mem_needed = RTE_ALIGN_CEIL(user_cfg->memory - total_mem,
@@ -269,12 +270,13 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 int
 rte_eal_hugepage_attach(void)
 {
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct hugepage_info *hpi;
 	int fd_hugepage = -1;
 	unsigned int i;
 
-	hpi = &platform_info->hugepage_info[0];
+	hpi = &runtime_state->hugepage_info[0];
 
 	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
 		const struct hugepage_info *cur_hpi = &hpi[i];
@@ -355,7 +357,8 @@ memseg_primary_init(void)
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, total_mem;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -383,7 +386,7 @@ memseg_primary_init(void)
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 
-		hpi = &platform_info->hugepage_info[hpi_idx];
+		hpi = &runtime_state->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
 		/* no NUMA support on FreeBSD */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d3f1748297..1bf519eb10 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -406,19 +406,19 @@ eal_mem_config_init(void)
 static void
 eal_hugedirs_unlock(void)
 {
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	int i;
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++)
 	{
 		/* skip uninitialized or unlocked entries */
-		if (platform_info->hugepage_info[i].hugepage_sz == 0 ||
-				platform_info->hugepage_info[i].lock_descriptor < 0)
+		if (runtime_state->hugepage_info[i].hugepage_sz == 0 ||
+				runtime_state->hugepage_info[i].lock_descriptor < 0)
 			continue;
 		/* unlock hugepage file */
-		flock(platform_info->hugepage_info[i].lock_descriptor, LOCK_UN);
-		close(platform_info->hugepage_info[i].lock_descriptor);
+		flock(runtime_state->hugepage_info[i].lock_descriptor, LOCK_UN);
+		close(runtime_state->hugepage_info[i].lock_descriptor);
 		/* reset the field */
-		platform_info->hugepage_info[i].lock_descriptor = -1;
+		runtime_state->hugepage_info[i].lock_descriptor = -1;
 	}
 }
 
@@ -607,12 +607,6 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_eal_cpu_init() < 0) {
-		rte_eal_init_alert("Cannot detect lcores.");
-		rte_errno = ENOTSUP;
-		goto err_out;
-	}
-
 	if (eal_parse_args() < 0) {
 		rte_eal_init_alert("Error parsing command line arguments.");
 		rte_errno = EINVAL;
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index f35446cdc9..28e4584ddf 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -395,6 +395,79 @@ compare_hpi(const void *a, const void *b)
 	return hpi_b->hugepage_sz - hpi_a->hugepage_sz;
 }
 
+static int
+compare_hp_sizes(const void *a, const void *b)
+{
+	const struct hp_sizes *ha = a;
+	const struct hp_sizes *hb = b;
+
+	if (hb->size > ha->size)
+		return 1;
+	if (hb->size < ha->size)
+		return -1;
+	return 0;
+}
+
+int
+eal_get_platform_hp_info(struct eal_platform_info *platform_info)
+{
+	const char dirent_start_text[] = "hugepages-";
+	const size_t dirent_start_len = sizeof(dirent_start_text) - 1;
+	unsigned int num_sizes = 0;
+	DIR *dir;
+	struct dirent *dirent;
+
+	dir = opendir(sys_dir_path);
+	if (dir == NULL) {
+		EAL_LOG(ERR, "Cannot open directory %s to read system hugepage info",
+				sys_dir_path);
+		return -1;
+	}
+
+	for (dirent = readdir(dir); dirent != NULL; dirent = readdir(dir)) {
+		struct hp_sizes *hps;
+		uint64_t sz;
+		unsigned int i;
+
+		if (strncmp(dirent->d_name, dirent_start_text,
+			    dirent_start_len) != 0)
+			continue;
+
+		if (num_sizes >= MAX_HUGEPAGE_SIZES)
+			break;
+
+		sz = rte_str_to_size(&dirent->d_name[dirent_start_len]);
+		hps = &platform_info->hugepage_sizes[num_sizes];
+		hps->size = sz;
+
+		/* fill per-socket page counts; fall back to socket 0 total */
+		hps->total_pages = 0;
+		for (i = 0; i < platform_info->numa_node_count; i++) {
+			int socket = (int)platform_info->numa_nodes[i];
+			hps->max_pages[socket] = get_num_hugepages_on_node(dirent->d_name,
+					socket, sz);
+			hps->total_pages += hps->max_pages[socket];
+		}
+		if (hps->total_pages == 0) {
+			hps->max_pages[0] = get_num_hugepages(dirent->d_name, sz, 0);
+			hps->total_pages = hps->max_pages[0];
+		}
+
+		if (get_hugepage_dir(sz, hps->dir, sizeof(hps->dir)) < 0)
+			hps->dir[0] = '\0';
+
+		num_sizes++;
+	}
+	closedir(dir);
+
+	/* sort largest to smallest, matching hugepage_info ordering */
+	qsort(&platform_info->hugepage_sizes[0], num_sizes,
+	      sizeof(platform_info->hugepage_sizes[0]), compare_hp_sizes);
+
+	platform_info->num_hugepage_sizes = num_sizes;
+	return 0;
+}
+
 static void
 calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 		unsigned int reusable_pages)
@@ -453,7 +526,7 @@ hugepage_info_init(void)
 	unsigned int reusable_pages;
 	DIR *dir;
 	struct dirent *dirent;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	dir = opendir(sys_dir_path);
@@ -474,7 +547,7 @@ hugepage_info_init(void)
 		if (num_sizes >= MAX_HUGEPAGE_SIZES)
 			break;
 
-		hpi = &platform_info->hugepage_info[num_sizes];
+		hpi = &runtime_state->hugepage_info[num_sizes];
 		hpi->hugepage_sz =
 			rte_str_to_size(&dirent->d_name[dirent_start_len]);
 
@@ -545,17 +618,17 @@ hugepage_info_init(void)
 	if (dirent != NULL)
 		return -1;
 
-	platform_info->num_hugepage_sizes = num_sizes;
+	runtime_state->num_hugepage_sizes = num_sizes;
 
 	/* sort the page directory entries by size, largest to smallest */
-	qsort(&platform_info->hugepage_info[0], num_sizes,
-	      sizeof(platform_info->hugepage_info[0]), compare_hpi);
+	qsort(&runtime_state->hugepage_info[0], num_sizes,
+	      sizeof(runtime_state->hugepage_info[0]), compare_hpi);
 
 	/* now we have all info, check we have at least one valid size */
 	for (i = 0; i < num_sizes; i++) {
 		/* pages may no longer all be on socket 0, so check all */
 		unsigned int j, num_pages = 0;
-		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
+		struct hugepage_info *hpi = &runtime_state->hugepage_info[i];
 
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++)
 			num_pages += hpi->num_pages[j];
@@ -577,7 +650,7 @@ eal_hugepage_info_init(void)
 {
 	struct hugepage_info *hpi, *tmp_hpi;
 	unsigned int i;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (hugepage_info_init() < 0)
@@ -587,26 +660,26 @@ eal_hugepage_info_init(void)
 	if (user_cfg->no_shconf)
 		return 0;
 
-	hpi = &platform_info->hugepage_info[0];
+	hpi = &runtime_state->hugepage_info[0];
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
-			sizeof(platform_info->hugepage_info));
+			sizeof(runtime_state->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to create shared memory!");
 		return -1;
 	}
 
-	memcpy(tmp_hpi, hpi, sizeof(platform_info->hugepage_info));
+	memcpy(tmp_hpi, hpi, sizeof(runtime_state->hugepage_info));
 
 	/* we've copied file descriptors along with everything else, but they
 	 * will be invalid in secondary process, so overwrite them
 	 */
-	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(runtime_state->hugepage_info); i++) {
 		struct hugepage_info *tmp = &tmp_hpi[i];
 		tmp->lock_descriptor = -1;
 	}
 
-	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(runtime_state->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
@@ -615,22 +688,29 @@ eal_hugepage_info_init(void)
 
 int eal_hugepage_info_read(void)
 {
-	struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct hugepage_info *hpi = &runtime_state->hugepage_info[0];
 	struct hugepage_info *tmp_hpi;
 
 	tmp_hpi = open_shared_memory(eal_hugepage_info_path(),
-				  sizeof(platform_info->hugepage_info));
+				  sizeof(runtime_state->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to open shared memory!");
 		return -1;
 	}
 
-	memcpy(hpi, tmp_hpi, sizeof(platform_info->hugepage_info));
+	memcpy(hpi, tmp_hpi, sizeof(runtime_state->hugepage_info));
 
-	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(runtime_state->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
+
+	/* count valid entries copied from primary process */
+	for (unsigned int i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
+		if (runtime_state->hugepage_info[i].hugepage_sz == 0)
+			break;
+		runtime_state->num_hugepage_sizes = i + 1;
+	}
 	return 0;
 }
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 035e5da08a..a8b3d97fca 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -965,7 +965,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 	struct alloc_walk_param wa;
 	struct hugepage_info *hi = NULL;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	memset(&wa, 0, sizeof(wa));
 
@@ -973,10 +973,10 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 	if (user_cfg->legacy_mem)
 		return -1;
 
-	for (i = 0; i < (int) RTE_DIM(platform_info->hugepage_info); i++) {
+	for (i = 0; i < (int) RTE_DIM(runtime_state->hugepage_info); i++) {
 		if (page_sz ==
-				platform_info->hugepage_info[i].hugepage_sz) {
-			hi = &platform_info->hugepage_info[i];
+				runtime_state->hugepage_info[i].hugepage_sz) {
+			hi = &runtime_state->hugepage_info[i];
 			break;
 		}
 	}
@@ -1034,7 +1034,7 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 {
 	int seg, ret = 0;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* dynamic free not supported in legacy mode */
 	if (user_cfg->legacy_mem)
@@ -1055,13 +1055,13 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
 		memset(&wa, 0, sizeof(wa));
 
-		for (i = 0; i < (int)RTE_DIM(platform_info->hugepage_info);
+		for (i = 0; i < (int)RTE_DIM(runtime_state->hugepage_info);
 				i++) {
-			hi = &platform_info->hugepage_info[i];
+			hi = &runtime_state->hugepage_info[i];
 			if (cur->hugepage_sz == hi->hugepage_sz)
 				break;
 		}
-		if (i == (int)RTE_DIM(platform_info->hugepage_info)) {
+		if (i == (int)RTE_DIM(runtime_state->hugepage_info)) {
 			EAL_LOG(ERR, "Can't find relevant hugepage_info entry");
 			ret = -1;
 			continue;
@@ -1325,7 +1325,7 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
 	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct hugepage_info *hi = NULL;
 	unsigned int i;
 	int msl_idx;
@@ -1337,12 +1337,12 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 	primary_msl = &mcfg->memsegs[msl_idx];
 	local_msl = &local_memsegs[msl_idx];
 
-	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(runtime_state->hugepage_info); i++) {
 		uint64_t cur_sz =
-			platform_info->hugepage_info[i].hugepage_sz;
+			runtime_state->hugepage_info[i].hugepage_sz;
 		uint64_t msl_sz = primary_msl->page_sz;
 		if (msl_sz == cur_sz) {
-			hi = &platform_info->hugepage_info[i];
+			hi = &runtime_state->hugepage_info[i];
 			break;
 		}
 	}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 1bfea89021..d5d30baf61 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -598,13 +598,13 @@ unlink_hugepage_files(struct hugepage_file *hugepg_tbl,
 {
 	unsigned socket, size;
 	int page, nrpages = 0;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* get total number of hugepages */
 	for (size = 0; size < num_hp_info; size++)
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++)
 			nrpages +=
-			platform_info->hugepage_info[size].num_pages[socket];
+			runtime_state->hugepage_info[size].num_pages[socket];
 
 	for (page = 0; page < nrpages; page++) {
 		struct hugepage_file *hp = &hugepg_tbl[page];
@@ -628,12 +628,12 @@ unmap_unneeded_hugepages(struct hugepage_file *hugepg_tbl,
 {
 	unsigned socket, size;
 	int page, nrpages = 0;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* get total number of hugepages */
 	for (size = 0; size < num_hp_info; size++)
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++)
-			nrpages += platform_info->hugepage_info[size].num_pages[socket];
+			nrpages += runtime_state->hugepage_info[size].num_pages[socket];
 
 	for (size = 0; size < num_hp_info; size++) {
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++) {
@@ -855,7 +855,7 @@ memseg_list_free(struct rte_memseg_list *msl)
 static int __rte_unused
 prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 {
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int cur_page, seg_start_page, end_seg, new_memseg;
 	unsigned int hpi_idx, socket, i;
@@ -875,10 +875,10 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 	/* we cannot know how many page sizes and sockets we have discovered, so
 	 * loop over all of them
 	 */
-	for (hpi_idx = 0; hpi_idx < platform_info->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < runtime_state->num_hugepage_sizes;
 			hpi_idx++) {
 		uint64_t page_sz =
-			platform_info->hugepage_info[hpi_idx].hugepage_sz;
+			runtime_state->hugepage_info[hpi_idx].hugepage_sz;
 
 		for (i = 0; i < rte_socket_count(); i++) {
 			struct rte_memseg_list *msl;
@@ -1083,10 +1083,10 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
+	for (i = 0; i < runtime_state->num_hugepage_sizes; i++) {
+		struct hugepage_info *hpi = &runtime_state->hugepage_info[i];
 		if (strnlen(hpi->hugedir, sizeof(hpi->hugedir)) != 0) {
 			for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 				size += hpi->hugepage_sz * hpi->num_pages[j];
@@ -1141,7 +1141,7 @@ eal_legacy_hugepage_init(void)
 	struct rte_mem_config *mcfg;
 	struct hugepage_file *hugepage = NULL, *tmp_hp = NULL;
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	uint64_t memory[RTE_MAX_NUMA_NODES];
@@ -1258,11 +1258,11 @@ eal_legacy_hugepage_init(void)
 
 	/* calculate total number of hugepages available. at this point we haven't
 	 * yet started sorting them so they all are on socket 0 */
-	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int) runtime_state->num_hugepage_sizes; i++) {
 		/* meanwhile, also initialize used_hp hugepage sizes in used_hp */
-		used_hp[i].hugepage_sz = platform_info->hugepage_info[i].hugepage_sz;
+		used_hp[i].hugepage_sz = runtime_state->hugepage_info[i].hugepage_sz;
 
-		nr_hugepages += platform_info->hugepage_info[i].num_pages[0];
+		nr_hugepages += runtime_state->hugepage_info[i].num_pages[0];
 	}
 
 	/*
@@ -1286,7 +1286,7 @@ eal_legacy_hugepage_init(void)
 		memory[i] = user_cfg->numa_mem[i];
 
 	/* map all hugepages and sort them */
-	for (i = 0; i < (int)platform_info->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int)runtime_state->num_hugepage_sizes; i++) {
 		unsigned pages_old, pages_new;
 		struct hugepage_info *hpi;
 
@@ -1295,7 +1295,7 @@ eal_legacy_hugepage_init(void)
 		 * we just map all hugepages available to the system
 		 * all hugepages are still located on socket 0
 		 */
-		hpi = &platform_info->hugepage_info[i];
+		hpi = &runtime_state->hugepage_info[i];
 
 		if (hpi->num_pages[0] == 0)
 			continue;
@@ -1358,9 +1358,9 @@ eal_legacy_hugepage_init(void)
 
 
 	/* clean out the numbers of pages */
-	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++)
+	for (i = 0; i < (int) runtime_state->num_hugepage_sizes; i++)
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++)
-			platform_info->hugepage_info[i].num_pages[j] = 0;
+			runtime_state->hugepage_info[i].num_pages[j] = 0;
 
 	/* get hugepages for each socket */
 	for (i = 0; i < nr_hugefiles; i++) {
@@ -1368,11 +1368,11 @@ eal_legacy_hugepage_init(void)
 
 		/* find a hugepage info with right size and increment num_pages */
 		const int nb_hpsizes = RTE_MIN(MAX_HUGEPAGE_SIZES,
-				(int)platform_info->num_hugepage_sizes);
+				(int)runtime_state->num_hugepage_sizes);
 		for (j = 0; j < nb_hpsizes; j++) {
 			if (tmp_hp[i].size ==
-					platform_info->hugepage_info[j].hugepage_sz) {
-				platform_info->hugepage_info[j].num_pages[socket]++;
+					runtime_state->hugepage_info[j].hugepage_sz) {
+				runtime_state->hugepage_info[j].num_pages[socket]++;
 			}
 		}
 	}
@@ -1383,15 +1383,15 @@ eal_legacy_hugepage_init(void)
 
 	/* calculate final number of pages */
 	nr_hugepages = eal_dynmem_calc_num_pages_per_socket(memory,
-			platform_info->hugepage_info, used_hp,
-			platform_info->num_hugepage_sizes);
+			runtime_state->hugepage_info, used_hp,
+			runtime_state->num_hugepage_sizes);
 
 	/* error if not enough memory available */
 	if (nr_hugepages < 0)
 		goto fail;
 
 	/* reporting in! */
-	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int) runtime_state->num_hugepage_sizes; i++) {
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 			if (used_hp[i].num_pages[j] > 0) {
 				EAL_LOG(DEBUG,
@@ -1420,7 +1420,7 @@ eal_legacy_hugepage_init(void)
 	 * also, sets final_va to NULL on pages that were unmapped.
 	 */
 	if (unmap_unneeded_hugepages(tmp_hp, used_hp,
-			platform_info->num_hugepage_sizes) < 0) {
+			runtime_state->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unmapping and locking hugepages failed!");
 		goto fail;
 	}
@@ -1455,7 +1455,7 @@ eal_legacy_hugepage_init(void)
 
 	/* free the hugepage backing files */
 	if (user_cfg->hugepage_file.unlink_before_mapping &&
-		unlink_hugepage_files(tmp_hp, platform_info->num_hugepage_sizes) < 0) {
+		unlink_hugepage_files(tmp_hp, runtime_state->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unlinking hugepage files failed!");
 		goto fail;
 	}
@@ -1708,7 +1708,7 @@ memseg_primary_init_32(void)
 	struct rte_memseg_list *msl;
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
 	uint64_t max_mem;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
@@ -1775,7 +1775,7 @@ memseg_primary_init_32(void)
 
 	/* create memseg lists */
 	for (i = 0; i < rte_socket_count(); i++) {
-		int hp_sizes = (int) platform_info->num_hugepage_sizes;
+		int hp_sizes = (int) runtime_state->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
 		bool skip;
@@ -1822,7 +1822,7 @@ memseg_primary_init_32(void)
 			struct hugepage_info *hpi;
 			int type_msl_idx, max_segs, total_segs = 0;
 
-			hpi = &platform_info->hugepage_info[hpi_idx];
+			hpi = &runtime_state->hugepage_info[hpi_idx];
 			hugepage_sz = hpi->hugepage_sz;
 
 			/* check if pages are actually available */
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index e03ba18c4b..ed293ada8f 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -179,12 +179,6 @@ rte_eal_init(int argc, char **argv)
 
 	eal_log_init(NULL);
 
-	if (eal_create_cpu_map() < 0) {
-		rte_eal_init_alert("Cannot discover CPU and NUMA.");
-		/* rte_errno is set */
-		goto err_out;
-	}
-
 	/* verify if DPDK supported on architecture MMU */
 	if (!eal_mmu_supported()) {
 		rte_eal_init_alert("Unsupported MMU type.");
@@ -192,12 +186,6 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (rte_eal_cpu_init() < 0) {
-		rte_eal_init_alert("Cannot detect lcores.");
-		rte_errno = ENOTSUP;
-		goto err_out;
-	}
-
 	if (eal_parse_args() < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
diff --git a/lib/eal/windows/eal_hugepages.c b/lib/eal/windows/eal_hugepages.c
index 4e9e958c65..fa19b7b77c 100644
--- a/lib/eal/windows/eal_hugepages.c
+++ b/lib/eal/windows/eal_hugepages.c
@@ -62,11 +62,9 @@ hugepage_info_init(void)
 	struct hugepage_info *hpi;
 	unsigned int socket_id;
 	int ret = 0;
-	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	/* Only one hugepage size available on Windows. */
-	platform_info->num_hugepage_sizes = 1;
-	hpi = &platform_info->hugepage_info[0];
+	hpi = &runtime_state->hugepage_info[0];
 
 	hpi->hugepage_sz = GetLargePageMinimum();
 	if (hpi->hugepage_sz == 0)
@@ -96,10 +94,39 @@ hugepage_info_init(void)
 	/* No hugepage filesystem on Windows. */
 	hpi->lock_descriptor = -1;
 	memset(hpi->hugedir, 0, sizeof(hpi->hugedir));
+	runtime_state->num_hugepage_sizes = 1;
 
 	return ret;
 }
 
+int
+eal_get_platform_hp_info(struct eal_platform_info *platform_info)
+{
+	size_t hp_sz;
+	unsigned int socket_id;
+
+	hp_sz = GetLargePageMinimum();
+	if (hp_sz == 0)
+		return -ENOTSUP;
+
+	for (socket_id = 0; socket_id < platform_info->numa_node_count; socket_id++) {
+		ULONGLONG bytes;
+		unsigned int numa_node;
+
+		numa_node = eal_socket_numa_node(socket_id);
+		if (GetNumaAvailableMemoryNodeEx(numa_node, &bytes)) {
+			platform_info->hugepage_sizes[0].max_pages[socket_id] = bytes / hp_sz;
+			platform_info->hugepage_sizes[0].total_pages += bytes / hp_sz;
+		}
+	}
+
+	platform_info->num_hugepage_sizes = 1;
+	platform_info->hugepage_sizes[0].size = hp_sz;
+	platform_info->hugepage_sizes[0].dir[0] = '\0'; /* no hugetlbfs on Windows */
+
+	return 0;
+}
+
 int
 eal_hugepage_info_init(void)
 {
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 7eaae467d8..3ab8af0466 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -315,6 +315,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	struct alloc_walk_param wa;
 	const struct hugepage_info *hi = NULL;
 	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->legacy_mem) {
@@ -323,7 +324,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	}
 
 	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
-		const struct hugepage_info *hpi = &platform_info->hugepage_info[i];
+		const struct hugepage_info *hpi = &runtime_state->hugepage_info[i];
 		if (page_sz == hpi->hugepage_sz) {
 			hi = hpi;
 			break;
@@ -367,7 +368,7 @@ int
 eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 {
 	int seg, ret = 0;
-	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* dynamic free not supported in legacy mode */
@@ -390,12 +391,12 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
 		memset(&wa, 0, sizeof(wa));
 
-		for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
-			hi = &platform_info->hugepage_info[i];
+		for (i = 0; i < RTE_DIM(runtime_state->hugepage_info); i++) {
+			hi = &runtime_state->hugepage_info[i];
 			if (cur->hugepage_sz == hi->hugepage_sz)
 				break;
 		}
-		if (i == RTE_DIM(platform_info->hugepage_info)) {
+		if (i == RTE_DIM(runtime_state->hugepage_info)) {
 			EAL_LOG(ERR, "Can't find relevant hugepage_info entry");
 			ret = -1;
 			continue;
diff --git a/lib/eal/windows/eal_windows.h b/lib/eal/windows/eal_windows.h
index 91cf15eaaa..64662e957a 100644
--- a/lib/eal/windows/eal_windows.h
+++ b/lib/eal/windows/eal_windows.h
@@ -29,14 +29,6 @@
 #define EAL_LOG_STUB() \
 	EAL_LOG(DEBUG, "Windows: %s() is a stub", __func__)
 
-/**
- * Create a map of processors and cores on the system.
- *
- * @return
- *  0 on success, (-1) on failure and rte_errno is set.
- */
-int eal_create_cpu_map(void);
-
 /**
  * Get system NUMA node number for a socket ID.
  *
-- 
2.51.0

