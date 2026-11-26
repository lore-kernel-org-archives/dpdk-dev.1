Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE19606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S0UWoc8h
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F1C1406A2;
	Thu, 26 Nov 2026 19:14:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 6437E402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716866; x=1827252866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aqkI0T9FtWxzqUrHmoxyU+mkAFO8tP+Ua8fLB0JE4KY=;
 b=S0UWoc8h+7EGwxi8nFU/GS4zk/LX5qdstM8e9RZMnrkFlCoTRof6M4Ct
 S8rqLXl99xhzlFZY3zn6HPhM+8inbWwTJWTRkrjCpp2e2PJRdv4QFyiMN
 DVE829amjbxz5S1ZOhlfQBTJCQOaSL4gqJT0Jq2+GDtnC515wfhYRyX9q
 PnTijSu6LcMLD9JLiBTzyhA4ymg9FIznIe/jifchU+9sJV3ANRaRMrpcl
 rwFd1+0yUV2h4MgkUdwnABpdWs5fsD4TGJvg7rK5JSdq7COlTSvue+GzR
 AnzH99PMKkgKb8eQMCqzR6krHcJwtgGInlzX46RJewaowjaosuxvQmtCX Q==;
X-CSE-ConnectionGUID: FzCUUzTLTgypEAjxQecHgg==
X-CSE-MsgGUID: nvto4NdrQ8+9l9GhQV03vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633548"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633548"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:25 -0800
X-CSE-ConnectionGUID: KQzwT9ccSoCz6hpaMFcPXQ==
X-CSE-MsgGUID: aTxQBG/KS5mpeB55DYCZ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732860"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:23 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 07/39] eal: move process policy fields to user config
Date: Thu, 26 Nov 2026 18:13:40 +0000
Message-ID: <20261126181414.124094-8-bruce.richardson@intel.com>
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

Move process/runtime policy request fields from internal_config into
eal_user_cfg, updating flag types to bool in the process.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  2 +-
 lib/eal/common/eal_common_fbarray.c | 10 +++---
 lib/eal/common/eal_common_mcfg.c    |  3 +-
 lib/eal/common/eal_common_memory.c  | 12 +++-----
 lib/eal/common/eal_common_options.c | 47 ++++++++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   | 20 +++++-------
 lib/eal/freebsd/eal.c               | 42 ++++++++++++--------------
 lib/eal/freebsd/eal_hugepage_info.c |  3 +-
 lib/eal/linux/eal.c                 | 38 +++++++++++------------
 lib/eal/linux/eal_hugepage_info.c   |  5 +--
 lib/eal/linux/eal_memalloc.c        | 37 +++++++++--------------
 lib/eal/linux/eal_memory.c          |  5 ++-
 lib/eal/linux/eal_timer_hpet.c      | 21 ++++++-------
 lib/eal/windows/eal.c               |  6 ++--
 14 files changed, 116 insertions(+), 135 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 4ebf938f31..5efc6623d6 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -138,5 +138,5 @@ RTE_EXPORT_SYMBOL(rte_eal_has_pci)
 int
 rte_eal_has_pci(void)
 {
-	return !internal_config.no_pci;
+	return !eal_user_cfg.no_pci;
 }
diff --git a/lib/eal/common/eal_common_fbarray.c b/lib/eal/common/eal_common_fbarray.c
index 834e3d7ef0..80ae7c1e31 100644
--- a/lib/eal/common/eal_common_fbarray.c
+++ b/lib/eal/common/eal_common_fbarray.c
@@ -697,8 +697,7 @@ rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 	struct mem_area *ma = NULL;
 	void *data = NULL;
 	int fd = -1;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (arr == NULL) {
 		rte_errno = EINVAL;
@@ -734,7 +733,7 @@ rte_fbarray_init(struct rte_fbarray *arr, const char *name, unsigned int len,
 
 	fd = -1;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		/* remap virtual area as writable */
 		static const int flags = RTE_MAP_FORCE_ADDRESS |
 			RTE_MAP_PRIVATE | RTE_MAP_ANONYMOUS;
@@ -964,8 +963,7 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 	size_t mmap_len;
 	int fd, ret;
 	char path[PATH_MAX];
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (arr == NULL) {
 		rte_errno = EINVAL;
@@ -999,7 +997,7 @@ rte_fbarray_destroy(struct rte_fbarray *arr)
 		goto out;
 	}
 	/* with no shconf, there were never any files to begin with */
-	if (!internal_conf->no_shconf) {
+	if (!user_cfg->no_shconf) {
 		/*
 		 * attempt to get an exclusive lock on the file, to ensure it
 		 * has been detached by all other processes
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 32f5f50015..4cac2d8cb2 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -61,13 +61,14 @@ eal_mcfg_update_internal(void)
 void
 eal_mcfg_update_from_internal(void)
 {
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
 	mcfg->legacy_mem = internal_conf->legacy_mem;
 	mcfg->single_file_segments = internal_conf->single_file_segments;
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		rte_mp_disable(); /* multi-process requires shared config */
 	/* record current DPDK version */
 	mcfg->version = RTE_VERSION;
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 3caf97963d..9657d7ad8a 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1084,13 +1084,12 @@ rte_extmem_detach(void *va_addr, size_t len)
 int
 rte_eal_memory_detach(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	size_t page_sz = rte_mem_page_size();
 	unsigned int i;
 
-	if (internal_conf->in_memory == 1)
+	if (user_cfg->in_memory)
 		return 0;
 
 	rte_rwlock_write_lock(&mcfg->memory_hotplug_lock);
@@ -1133,7 +1132,7 @@ rte_eal_memory_detach(void)
 	 * config - we can't zero it out because it might still be referenced
 	 * by other processes.
 	 */
-	if (internal_conf->no_shconf == 0 && mcfg->mem_cfg_addr != 0) {
+	if (!user_cfg->no_shconf && mcfg->mem_cfg_addr != 0) {
 		if (rte_mem_unmap(mcfg, RTE_ALIGN(sizeof(*mcfg), page_sz)) != 0)
 			EAL_LOG(ERR, "Could not unmap shared memory config: %s",
 					rte_strerror(rte_errno));
@@ -1147,8 +1146,7 @@ rte_eal_memory_detach(void)
 int
 rte_eal_memory_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int retval;
 
 	EAL_LOG(DEBUG, "Setting up physically contiguous memory...");
@@ -1165,7 +1163,7 @@ rte_eal_memory_init(void)
 	if (retval < 0)
 		goto fail;
 
-	if (internal_conf->no_shconf == 0 && rte_eal_memdevice_init() < 0)
+	if (!user_cfg->no_shconf && rte_eal_memdevice_init() < 0)
 		goto fail;
 
 	return 0;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 133175c068..c3cc41bac8 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -521,7 +521,9 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->force_numa_limits = false;
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
 		user_cfg->numa_limit[i] = 0;
+	user_cfg->process_type = RTE_PROC_PRIMARY;
 	user_cfg->no_hugetlbfs = false;
+	user_cfg->no_pci = false;
 	user_cfg->hugefile_prefix = NULL;
 	user_cfg->hugepage_dir = NULL;
 	user_cfg->hugepage_file.unlink_before_mapping = false;
@@ -546,12 +548,15 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	internal_cfg->no_auto_probing = 0;
 
 #ifdef RTE_LIBEAL_USE_HPET
-	internal_cfg->no_hpet = 0;
+	user_cfg->no_hpet = false;
 #else
-	internal_cfg->no_hpet = 1;
+	user_cfg->no_hpet = true;
 #endif
-	internal_cfg->vmware_tsc_map = 0;
-	internal_cfg->create_uio_dev = 0;
+	user_cfg->vmware_tsc_map = false;
+	user_cfg->no_shconf = false;
+	user_cfg->in_memory = false;
+	user_cfg->create_uio_dev = false;
+	user_cfg->no_telemetry = false;
 	internal_cfg->iova_mode = RTE_IOVA_DC;
 	internal_cfg->user_mbuf_pool_ops_name = NULL;
 	CPU_ZERO(&internal_cfg->ctrl_cpuset);
@@ -2087,8 +2092,8 @@ eal_parse_args(void)
 
 	/* parse the process type */
 	if (args.proc_type != NULL) {
-		int_cfg->process_type = eal_parse_proc_type(args.proc_type);
-		if (int_cfg->process_type == RTE_PROC_INVALID) {
+		user_cfg->process_type = eal_parse_proc_type(args.proc_type);
+		if (user_cfg->process_type == RTE_PROC_INVALID) {
 			EAL_LOG(ERR, "invalid process type: %s", args.proc_type);
 			return -1;
 		}
@@ -2253,21 +2258,21 @@ eal_parse_args(void)
 	if (args.no_huge) {
 		user_cfg->no_hugetlbfs = true;
 		/* no-huge is legacy mem */
-		int_cfg->legacy_mem = 1;
+		int_cfg->legacy_mem = true;
 	}
 	if (args.in_memory) {
-		int_cfg->in_memory = 1;
+		user_cfg->in_memory = true;
 		/* in-memory is a superset of noshconf and huge-unlink */
-		int_cfg->no_shconf = 1;
+		user_cfg->no_shconf = true;
 		user_cfg->hugepage_file.unlink_before_mapping = true;
 	}
 	if (args.legacy_mem) {
-		int_cfg->legacy_mem = 1;
+		int_cfg->legacy_mem = true;
 		if (args.memory_size == NULL && args.numa_mem == NULL)
 			EAL_LOG(NOTICE, "Static memory layout is selected, amount of reserved memory can be adjusted with -m or --socket-mem");
 	}
 	if (args.single_file_segments)
-		int_cfg->single_file_segments = 1;
+		int_cfg->single_file_segments = true;
 	if (args.huge_dir != NULL) {
 		if (strlen(args.huge_dir) < 1) {
 			EAL_LOG(ERR, "Invalid hugepage dir parameter");
@@ -2364,19 +2369,19 @@ eal_parse_args(void)
 	 * other options above have already set them.
 	 */
 	if (args.no_pci)
-		int_cfg->no_pci = 1;
+		user_cfg->no_pci = true;
 	if (args.no_hpet)
-		int_cfg->no_hpet = 1;
+		user_cfg->no_hpet = true;
 	if (args.vmware_tsc_map)
-		int_cfg->vmware_tsc_map = 1;
+		user_cfg->vmware_tsc_map = true;
 	if (args.no_shconf)
-		int_cfg->no_shconf = 1;
+		user_cfg->no_shconf = true;
 	if (args.no_telemetry)
-		int_cfg->no_telemetry = 1;
+		user_cfg->no_telemetry = true;
 	if (args.match_allocations)
-		int_cfg->match_allocations = 1;
+		int_cfg->match_allocations = true;
 	if (args.create_uio_dev)
-		int_cfg->create_uio_dev = 1;
+		user_cfg->create_uio_dev = true;
 
 	/* other misc settings */
 	if (args.iova_mode != NULL) {
@@ -2435,7 +2440,7 @@ eal_parse_args(void)
 #ifndef RTE_EXEC_ENV_WINDOWS
 	/* create runtime data directory. In no_shconf mode, skip any errors */
 	if (eal_create_runtime_dir() < 0) {
-		if (int_cfg->no_shconf == 0) {
+		if (!user_cfg->no_shconf) {
 			EAL_LOG(ERR, "Cannot create runtime directory");
 			return -1;
 		}
@@ -2500,8 +2505,8 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
 
-	if (internal_cfg->process_type == RTE_PROC_AUTO)
-		internal_cfg->process_type = eal_proc_type_detect();
+	if (user_cfg->process_type == RTE_PROC_AUTO)
+		user_cfg->process_type = eal_proc_type_detect();
 
 	compute_ctrl_threads_cpuset(internal_cfg);
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index bf7d6792d2..f84867e2dc 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -62,11 +62,19 @@ struct hugepage_file_discipline {
  */
 struct eal_user_cfg {
 	size_t memory;           /**< amount of asked memory */
+	enum rte_proc_type_t process_type; /**< requested process type */
 	uint8_t force_nchannel;  /**< force number of channels */
 	uint8_t force_nrank;     /**< force number of ranks */
 	bool force_numa;         /**< true to request memory on specific NUMA nodes */
 	bool force_numa_limits;  /**< true to apply per-NUMA memory limits */
 	bool no_hugetlbfs;       /**< true to disable hugetlbfs */
+	bool no_pci;             /**< true to disable PCI */
+	bool no_hpet;            /**< true to disable HPET */
+	bool vmware_tsc_map;     /**< true to use VMware TSC mapping */
+	bool no_shconf;          /**< true if there is no shared config */
+	bool in_memory;          /**< true to run with no shared runtime files */
+	bool create_uio_dev;     /**< true to create /dev/uioX devices */
+	bool no_telemetry;       /**< true to disable telemetry */
 	struct hugepage_file_discipline hugepage_file;
 	char *hugefile_prefix;   /**< the base filename of hugetlbfs files */
 	char *hugepage_dir;      /**< specific hugetlbfs directory to use */
@@ -95,17 +103,6 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	volatile unsigned no_pci;         /**< true to disable PCI */
-	volatile unsigned no_hpet;        /**< true to disable HPET */
-	volatile unsigned vmware_tsc_map; /**< true to use VMware TSC mapping
-										* instead of native TSC */
-	volatile unsigned no_shconf;      /**< true if there is no shared config */
-	volatile unsigned in_memory;
-	/**< true if DPDK should operate entirely in-memory and not create any
-	 * shared files or runtime data.
-	 */
-	volatile unsigned create_uio_dev; /**< true to create /dev/uioX devices */
-	volatile enum rte_proc_type_t process_type; /**< multi-process proc type */
 	uintptr_t base_virtaddr;          /**< base address to try and reserve memory from */
 	volatile unsigned legacy_mem;
 	/**< true to enable legacy memory behavior (no dynamic allocation,
@@ -137,7 +134,6 @@ struct internal_config {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
-	unsigned int no_telemetry; /**< true to disable Telemetry */
 	struct simd_bitwidth max_simd_bitwidth;
 	/**< max simd bitwidth path to use */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 500135e5ac..843fd03ad8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -98,6 +98,7 @@ rte_eal_config_create(void)
 	struct rte_config *config = rte_eal_get_configuration();
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
@@ -106,7 +107,7 @@ rte_eal_config_create(void)
 
 	const char *pathname = eal_runtime_config_path();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* map the config before base address so that we don't waste a page */
@@ -183,11 +184,10 @@ rte_eal_config_attach(void)
 	void *rte_mem_cfg_addr;
 	const char *pathname = eal_runtime_config_path();
 	struct rte_config *config = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	if (mem_cfg_fd < 0){
@@ -222,10 +222,9 @@ rte_eal_config_reattach(void)
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
 	struct rte_config *config = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* save the address primary process has mapped shared config to */
@@ -265,11 +264,10 @@ eal_proc_type_detect(void)
 {
 	enum rte_proc_type_t ptype = RTE_PROC_PRIMARY;
 	const char *pathname = eal_runtime_config_path();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* if there no shared config, there can be no secondary processes */
-	if (!internal_conf->no_shconf) {
+	if (!user_cfg->no_shconf) {
 		/* if we can open the file but not get a write-lock we are a
 		 * secondary process. NOTE: if we get a file handle back, we
 		 * keep that open and don't close it to prevent a race condition
@@ -291,10 +289,9 @@ static int
 rte_config_init(void)
 {
 	struct rte_config *config = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	config->process_type = internal_conf->process_type;
+	config->process_type = user_cfg->process_type;
 
 	switch (config->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -475,9 +472,9 @@ rte_eal_init(int argc, char **argv)
 
 	/* FreeBSD always uses legacy memory model */
 	internal_conf->legacy_mem = true;
-	if (internal_conf->in_memory) {
+	if (user_cfg->in_memory) {
 		EAL_LOG(WARNING, "Warning: ignoring unsupported flag, '--in-memory'");
-		internal_conf->in_memory = false;
+		user_cfg->in_memory = false;
 	}
 
 	if (eal_plugins_init() < 0) {
@@ -577,7 +574,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
-		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
+		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
 			eal_hugepage_info_read();
 		if (ret < 0) {
@@ -585,7 +582,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
+		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
@@ -600,7 +597,7 @@ rte_eal_init(int argc, char **argv)
 			user_cfg->memory = eal_get_hugepage_mem_size();
 	}
 
-	if (internal_conf->vmware_tsc_map == 1) {
+	if (user_cfg->vmware_tsc_map) {
 #ifdef RTE_LIBRTE_EAL_VMWARE_TSC_MAP_SUPPORT
 		rte_cycles_vmware_tsc_map = 1;
 		EAL_LOG(DEBUG, "Using VMWARE TSC MAP, "
@@ -749,11 +746,11 @@ rte_eal_init(int argc, char **argv)
 	 * In no_shconf mode, no runtime directory is created in the first
 	 * place, so no cleanup needed.
 	 */
-	if (!internal_conf->no_shconf && eal_clean_runtime_dir() < 0) {
+	if (!user_cfg->no_shconf && eal_clean_runtime_dir() < 0) {
 		rte_eal_init_alert("Cannot clear runtime directory");
 		goto err_out;
 	}
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !internal_conf->no_telemetry) {
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
 				&internal_conf->ctrl_cpuset) != 0)
@@ -801,9 +798,8 @@ rte_eal_cleanup(void)
 RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
 int rte_eal_create_uio_dev(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	return internal_conf->create_uio_dev;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	return user_cfg->create_uio_dev;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index 392c225d5b..29c5d986c1 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -62,6 +62,7 @@ eal_hugepage_info_init(void)
 
 	/* re-use the linux "internal config" structure for our memory data */
 	struct hugepage_info *hpi = &internal_conf->hugepage_info[0];
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct hugepage_info *tmp_hpi;
 	unsigned int i;
 
@@ -116,7 +117,7 @@ eal_hugepage_info_init(void)
 	hpi->lock_descriptor = fd;
 
 	/* for no shared files mode, do not create shared memory config */
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 9b52ef262d..a2641d1254 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -181,10 +181,11 @@ rte_eal_config_create(void)
 	int retval;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	const char *pathname = eal_runtime_config_path();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* map the config before hugepage address so that we don't waste a page */
@@ -262,12 +263,11 @@ rte_eal_config_attach(void)
 {
 	struct rte_config *config = rte_eal_get_configuration();
 	struct rte_mem_config *mem_config;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	const char *pathname = eal_runtime_config_path();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	if (mem_cfg_fd < 0){
@@ -302,10 +302,9 @@ rte_eal_config_reattach(void)
 	struct rte_config *config = rte_eal_get_configuration();
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* save the address primary process has mapped shared config to */
@@ -347,11 +346,10 @@ eal_proc_type_detect(void)
 {
 	enum rte_proc_type_t ptype = RTE_PROC_PRIMARY;
 	const char *pathname = eal_runtime_config_path();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* if there no shared config, there can be no secondary processes */
-	if (!internal_conf->no_shconf) {
+	if (!user_cfg->no_shconf) {
 		/* if we can open the file but not get a write-lock we are a
 		 * secondary process. NOTE: if we get a file handle back, we
 		 * keep that open and don't close it to prevent a race condition
@@ -373,10 +371,9 @@ static int
 rte_config_init(void)
 {
 	struct rte_config *config = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	config->process_type = internal_conf->process_type;
+	config->process_type = user_cfg->process_type;
 
 	switch (config->process_type) {
 	case RTE_PROC_PRIMARY:
@@ -748,7 +745,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
-		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
+		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
 		if (ret < 0) {
@@ -756,7 +753,7 @@ rte_eal_init(int argc, char **argv)
 			rte_errno = EACCES;
 			goto err_out;
 		}
-		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
+		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
 				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
@@ -769,7 +766,7 @@ rte_eal_init(int argc, char **argv)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
-	if (internal_conf->vmware_tsc_map == 1) {
+	if (user_cfg->vmware_tsc_map) {
 #ifdef RTE_LIBRTE_EAL_VMWARE_TSC_MAP_SUPPORT
 		rte_cycles_vmware_tsc_map = 1;
 		EAL_LOG(DEBUG, "Using VMWARE TSC MAP, "
@@ -932,11 +929,11 @@ rte_eal_init(int argc, char **argv)
 	 * In no_shconf mode, no runtime directory is created in the first
 	 * place, so no cleanup needed.
 	 */
-	if (!internal_conf->no_shconf && eal_clean_runtime_dir() < 0) {
+	if (!user_cfg->no_shconf && eal_clean_runtime_dir() < 0) {
 		rte_eal_init_alert("Cannot clear runtime directory");
 		goto err_out;
 	}
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !internal_conf->no_telemetry) {
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY && !user_cfg->no_telemetry) {
 		if (rte_telemetry_init(rte_eal_get_runtime_dir(),
 				rte_version(),
 				&internal_conf->ctrl_cpuset) != 0)
@@ -1015,10 +1012,9 @@ rte_eal_cleanup(void)
 RTE_EXPORT_SYMBOL(rte_eal_create_uio_dev)
 int rte_eal_create_uio_dev(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	return internal_conf->create_uio_dev;
+	return user_cfg->create_uio_dev;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 2f889b291e..44dafa5292 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -500,7 +500,7 @@ hugepage_info_init(void)
 			 * init process.
 			 */
 #ifdef MAP_HUGE_SHIFT
-			if (internal_conf->in_memory) {
+			if (user_cfg->in_memory) {
 				EAL_LOG(DEBUG, "In-memory mode enabled, "
 					"hugepages of size %" PRIu64 " bytes "
 					"will be allocated anonymously",
@@ -581,12 +581,13 @@ eal_hugepage_info_init(void)
 	unsigned int i;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (hugepage_info_init() < 0)
 		return -1;
 
 	/* for no shared files mode, we're done */
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	hpi = &internal_conf->hugepage_info[0];
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 4ac5c14668..d9818dbba5 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -276,7 +276,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	/* for in-memory mode, we only make it here when we're sure we support
 	 * memfd, and this is a special case.
 	 */
-	if (internal_conf->in_memory)
+	if (user_cfg->in_memory)
 		return get_seg_memfd(hi, list_idx, seg_idx);
 
 	if (internal_conf->single_file_segments) {
@@ -460,13 +460,12 @@ resize_hugefile_in_filesystem(int fd, uint64_t fa_offset, uint64_t page_sz,
 static void
 close_hugefile(int fd, char *path, int list_idx)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	/*
 	 * primary process must unlink the file, but only when not in in-memory
 	 * mode (as in that case there is no file to unlink).
 	 */
-	if (!internal_conf->in_memory &&
+	if (!user_cfg->in_memory &&
 			rte_eal_process_type() == RTE_PROC_PRIMARY &&
 			unlink(path))
 		EAL_LOG(ERR, "%s(): unlinking '%s' failed: %s",
@@ -483,10 +482,9 @@ resize_hugefile(int fd, uint64_t fa_offset, uint64_t page_sz, bool grow,
 	/* in-memory mode is a special case, because we can be sure that
 	 * fallocate() is supported.
 	 */
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->in_memory) {
+	if (user_cfg->in_memory) {
 		if (dirty != NULL)
 			*dirty = false;
 		return resize_hugefile_in_memory(fd, fa_offset,
@@ -522,7 +520,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	alloc_sz = hi->hugepage_sz;
 
 	/* these are checked at init, but code analyzers don't know that */
-	if (internal_conf->in_memory && !anonymous_hugepages_supported) {
+	if (user_cfg->in_memory && !anonymous_hugepages_supported) {
 		EAL_LOG(ERR, "Anonymous hugepages not supported, in-memory mode cannot allocate memory");
 		return -1;
 	}
@@ -551,7 +549,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 			goto resized;
 		}
 		if (user_cfg->hugepage_file.unlink_before_mapping &&
-				!internal_conf->in_memory) {
+				!user_cfg->in_memory) {
 			if (unlink(path)) {
 				EAL_LOG(DEBUG, "%s(): unlink() failed: %s",
 					__func__, strerror(errno));
@@ -685,7 +683,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	} else {
 		/* only remove file if we can take out a write lock */
 		if (!user_cfg->hugepage_file.unlink_before_mapping &&
-				internal_conf->in_memory == 0 &&
+				!user_cfg->in_memory &&
 				lock(fd, LOCK_EX) == 1)
 			unlink(path);
 		close(fd);
@@ -738,7 +736,7 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 		/* if we're able to take out a write lock, we're the last one
 		 * holding onto this page.
 		 */
-		if (!internal_conf->in_memory &&
+		if (!user_cfg->in_memory &&
 				user_cfg->hugepage_file.unlink_existing &&
 				!user_cfg->hugepage_file.unlink_before_mapping) {
 			ret = lock(fd, LOCK_EX);
@@ -776,8 +774,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	size_t page_sz;
 	int cur_idx, start_idx, j, dir_fd = -1;
 	unsigned int msl_idx, need, i;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
@@ -832,7 +829,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	 * during init, we already hold a write lock, so don't try to take out
 	 * another one.
 	 */
-	if (wa->hi->lock_descriptor == -1 && !internal_conf->in_memory) {
+	if (wa->hi->lock_descriptor == -1 && !user_cfg->in_memory) {
 		dir_fd = open(wa->hi->hugedir, O_RDONLY);
 		if (dir_fd < 0) {
 			EAL_LOG(ERR, "%s(): Cannot open '%s': %s",
@@ -915,8 +912,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
 	int msl_idx, seg_idx, ret, dir_fd = -1;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	start_addr = (uintptr_t) msl->base_va;
 	end_addr = start_addr + msl->len;
@@ -939,7 +935,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	 * during init, we already hold a write lock, so don't try to take out
 	 * another one.
 	 */
-	if (wa->hi->lock_descriptor == -1 && !internal_conf->in_memory) {
+	if (wa->hi->lock_descriptor == -1 && !user_cfg->in_memory) {
 		dir_fd = open(wa->hi->hugedir, O_RDONLY);
 		if (dir_fd < 0) {
 			EAL_LOG(ERR, "%s(): Cannot open '%s': %s",
@@ -1104,8 +1100,7 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 int
 eal_memalloc_free_seg(struct rte_memseg *ms)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct internal_config *internal_conf = eal_get_internal_configuration();
 
 	/* dynamic free not supported in legacy mode */
 	if (internal_conf->legacy_mem)
@@ -1663,8 +1658,6 @@ eal_memalloc_cleanup(void)
 int
 eal_memalloc_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
@@ -1674,7 +1667,7 @@ eal_memalloc_init(void)
 		if (rte_memseg_list_walk_thread_unsafe(secondary_msl_create_walk, NULL) < 0)
 			return -1;
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
-			internal_conf->in_memory) {
+			user_cfg->in_memory) {
 		EAL_LOG(DEBUG, "Using memfd for anonymous memory");
 		/* this cannot ever happen but better safe than sorry */
 		if (!anonymous_hugepages_supported) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 3816ddf8c5..3da8d179e6 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -545,11 +545,10 @@ create_shared_memory(const char *filename, const size_t mem_size)
 {
 	void *retval;
 	int fd;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* if no shared files mode is used, create anonymous memory instead */
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		retval = mmap(NULL, mem_size, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (retval == MAP_FAILED)
diff --git a/lib/eal/linux/eal_timer_hpet.c b/lib/eal/linux/eal_timer_hpet.c
index 63e38bd53e..c1a3993e8f 100644
--- a/lib/eal/linux/eal_timer_hpet.c
+++ b/lib/eal/linux/eal_timer_hpet.c
@@ -88,10 +88,9 @@ RTE_EXPORT_SYMBOL(rte_get_hpet_hz)
 uint64_t
 rte_get_hpet_hz(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->no_hpet)
+	if (user_cfg->no_hpet)
 		rte_panic("Error, HPET called, but no HPET present\n");
 
 	return eal_hpet_resolution_hz;
@@ -103,10 +102,9 @@ rte_get_hpet_cycles(void)
 {
 	uint32_t t, msb;
 	uint64_t ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->no_hpet)
+	if (user_cfg->no_hpet)
 		rte_panic("Error, HPET called, but no HPET present\n");
 
 	t = eal_hpet->counter_l;
@@ -126,10 +124,9 @@ int
 rte_eal_hpet_init(int make_default)
 {
 	int fd, ret;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->no_hpet) {
+	if (user_cfg->no_hpet) {
 		EAL_LOG(NOTICE, "HPET is disabled");
 		return -1;
 	}
@@ -138,14 +135,14 @@ rte_eal_hpet_init(int make_default)
 	if (fd < 0) {
 		EAL_LOG(ERR, "ERROR: Cannot open "DEV_HPET": %s!",
 			strerror(errno));
-		internal_conf->no_hpet = 1;
+		user_cfg->no_hpet = true;
 		return -1;
 	}
 	eal_hpet = mmap(NULL, 1024, PROT_READ, MAP_SHARED, fd, 0);
 	if (eal_hpet == MAP_FAILED) {
 		EAL_LOG(ERR, "ERROR: Cannot mmap "DEV_HPET"!");
 		close(fd);
-		internal_conf->no_hpet = 1;
+		user_cfg->no_hpet = true;
 		return -1;
 	}
 	close(fd);
@@ -169,7 +166,7 @@ rte_eal_hpet_init(int make_default)
 			hpet_msb_inc, NULL);
 	if (ret != 0) {
 		EAL_LOG(ERR, "ERROR: Cannot create HPET timer thread!");
-		internal_conf->no_hpet = 1;
+		user_cfg->no_hpet = true;
 		return -1;
 	}
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 5f10e1f0eb..3d01b7a16e 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -223,11 +223,11 @@ rte_eal_init(int argc, char **argv)
 	}
 
 	/* Prevent creation of shared memory files. */
-	if (internal_conf->in_memory == 0) {
+	if (!user_cfg->in_memory) {
 		EAL_LOG(WARNING, "Multi-process support is requested, "
 			"but not available.");
-		internal_conf->in_memory = 1;
-		internal_conf->no_shconf = 1;
+		user_cfg->in_memory = true;
+		user_cfg->no_shconf = true;
 	}
 
 	if (!user_cfg->no_hugetlbfs && (eal_hugepage_info_init() < 0)) {
-- 
2.55.0

