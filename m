Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86147CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:59:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBAB340A6D;
	Wed, 29 Apr 2026 18:59:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id BF29740A67;
 Wed, 29 Apr 2026 18:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481943; x=1809017943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=16Y2jUuVwUoWkZArbiEWViaqpDbJWPZO1RmkPyveveo=;
 b=ltJPymcfuyiBiJfULraSgXHr7loF87tJf372pSgZgA/0d2E42NU1malw
 jvulVRKZbKrcV1/Uko/eSZ5TjHGQsDerYNdhB5xOMQq8Tb961pJBJKrDD
 jjmLjJKQ8lqGsmz93YWRLS1z9zRhdSKowyw3WCtEl5sm29Hk5bHCJfPz0
 MLm49Y5WJNPsXikyuCtk932dMTZSx4U9Cv7w/TB/61GB9i8YwH826J7Fx
 EygwE0cXK/9SYnE8AZNQz14rXTYHYo8duSM5U7Z2+B4UbLgFqQ/TGDDso
 Q0qsw8nv2GKmwAHKKTKIpoM3YjneYYnv+HvFoeehJzHenrLLZdtu/LLKc Q==;
X-CSE-ConnectionGUID: NSz5hJTeRDOZ00c+lK8WSA==
X-CSE-MsgGUID: lNiVYwvGS5mbH3yMfumVnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725296"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725296"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:02 -0700
X-CSE-ConnectionGUID: XofYhbPxRj2ayxHbpPJfpQ==
X-CSE-MsgGUID: /BRyq9hWQpy41NJaKUfQ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696927"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 05/44] eal: move process policy fields to user config
Date: Wed, 29 Apr 2026 17:57:57 +0100
Message-ID: <20260429165845.2136843-6-bruce.richardson@intel.com>
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

Move process/runtime policy request fields from internal_config into
eal_user_cfg, updating flag types to bool in the process.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  2 +-
 lib/eal/common/eal_common_fbarray.c | 10 +++---
 lib/eal/common/eal_common_memory.c  | 12 +++-----
 lib/eal/common/eal_common_options.c | 47 ++++++++++++++++-------------
 lib/eal/common/eal_common_proc.c    | 35 +++++++++------------
 lib/eal/common/eal_internal_cfg.h   | 20 +++++-------
 lib/eal/freebsd/eal.c               | 40 +++++++++++-------------
 lib/eal/freebsd/eal_hugepage_info.c |  3 +-
 lib/eal/linux/eal.c                 | 36 ++++++++++------------
 lib/eal/linux/eal_hugepage_info.c   |  5 +--
 lib/eal/linux/eal_memalloc.c        | 37 +++++++++--------------
 lib/eal/linux/eal_memory.c          |  5 ++-
 lib/eal/linux/eal_timer_hpet.c      | 21 ++++++-------
 lib/eal/linux/eal_vfio.c            | 14 ++++-----
 lib/eal/windows/eal.c               |  6 ++--
 15 files changed, 132 insertions(+), 161 deletions(-)

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
index 8bdcefb717..f76bb5353d 100644
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
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 208e3583b0..b6a737b1ab 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1054,13 +1054,12 @@ rte_extmem_detach(void *va_addr, size_t len)
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
@@ -1103,7 +1102,7 @@ rte_eal_memory_detach(void)
 	 * config - we can't zero it out because it might still be referenced
 	 * by other processes.
 	 */
-	if (internal_conf->no_shconf == 0 && mcfg->mem_cfg_addr != 0) {
+	if (!user_cfg->no_shconf && mcfg->mem_cfg_addr != 0) {
 		if (rte_mem_unmap(mcfg, RTE_ALIGN(sizeof(*mcfg), page_sz)) != 0)
 			EAL_LOG(ERR, "Could not unmap shared memory config: %s",
 					rte_strerror(rte_errno));
@@ -1117,8 +1116,7 @@ rte_eal_memory_detach(void)
 int
 rte_eal_memory_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int retval;
 
 	EAL_LOG(DEBUG, "Setting up physically contiguous memory...");
@@ -1135,7 +1133,7 @@ rte_eal_memory_init(void)
 	if (retval < 0)
 		goto fail;
 
-	if (internal_conf->no_shconf == 0 && rte_eal_memdevice_init() < 0)
+	if (!user_cfg->no_shconf && rte_eal_memdevice_init() < 0)
 		goto fail;
 
 	return 0;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index f7f305e302..48b004258a 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -505,7 +505,9 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->force_numa_limits = false;
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
 		user_cfg->numa_limit[i] = 0;
+	user_cfg->process_type = RTE_PROC_AUTO;
 	user_cfg->no_hugetlbfs = false;
+	user_cfg->no_pci = false;
 	user_cfg->hugefile_prefix = NULL;
 	user_cfg->hugepage_dir = NULL;
 	user_cfg->hugepage_file.unlink_before_mapping = false;
@@ -526,12 +528,15 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
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
@@ -1973,8 +1978,8 @@ eal_parse_args(void)
 
 	/* parse the process type */
 	if (args.proc_type != NULL) {
-		int_cfg->process_type = eal_parse_proc_type(args.proc_type);
-		if (int_cfg->process_type == RTE_PROC_INVALID) {
+		user_cfg->process_type = eal_parse_proc_type(args.proc_type);
+		if (user_cfg->process_type == RTE_PROC_INVALID) {
 			EAL_LOG(ERR, "invalid process type: %s", args.proc_type);
 			return -1;
 		}
@@ -2121,21 +2126,21 @@ eal_parse_args(void)
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
@@ -2226,19 +2231,19 @@ eal_parse_args(void)
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
@@ -2297,7 +2302,7 @@ eal_parse_args(void)
 #ifndef RTE_EXEC_ENV_WINDOWS
 	/* create runtime data directory. In no_shconf mode, skip any errors */
 	if (eal_create_runtime_dir() < 0) {
-		if (int_cfg->no_shconf == 0) {
+		if (!user_cfg->no_shconf) {
 			EAL_LOG(ERR, "Cannot create runtime directory");
 			return -1;
 		}
@@ -2362,8 +2367,8 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
 
-	if (internal_cfg->process_type == RTE_PROC_AUTO)
-		internal_cfg->process_type = eal_proc_type_detect();
+	if (user_cfg->process_type == RTE_PROC_AUTO)
+		user_cfg->process_type = eal_proc_type_detect();
 
 	compute_ctrl_threads_cpuset(internal_cfg);
 
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 06f151818c..74f4f60b0a 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -208,13 +208,12 @@ int
 rte_mp_action_register(const char *name, rte_mp_t action)
 {
 	struct action_entry *entry;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (validate_action_name(name) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -245,13 +244,12 @@ void
 rte_mp_action_unregister(const char *name)
 {
 	struct action_entry *entry;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (validate_action_name(name) != 0)
 		return;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		return;
 	}
@@ -619,13 +617,12 @@ rte_mp_channel_init(void)
 {
 	char path[UNIX_PATH_MAX];
 	int dir_fd;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* in no shared files mode, we do not have secondary processes support,
 	 * so no need to initialize IPC.
 	 */
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC will be disabled");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -856,13 +853,12 @@ RTE_EXPORT_SYMBOL(rte_mp_sendmsg)
 int
 rte_mp_sendmsg(struct rte_mp_msg *msg)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (check_input(msg) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -1015,8 +1011,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	DIR *mp_dir;
 	struct dirent *ent;
 	struct timespec now, end;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	EAL_LOG(DEBUG, "request: %s", req->name);
 
@@ -1027,7 +1022,7 @@ rte_mp_request_sync(struct rte_mp_msg *req, struct rte_mp_reply *reply,
 	if (check_input(req) != 0)
 		goto end;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -1124,15 +1119,14 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 	struct timespec now;
 	struct timespec *end;
 	bool dummy_used = false;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	EAL_LOG(DEBUG, "request: %s", req->name);
 
 	if (check_input(req) != 0)
 		return -1;
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -1268,8 +1262,7 @@ int
 rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 {
 	EAL_LOG(DEBUG, "reply: %s", msg->name);
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (check_input(msg) != 0)
 		return -1;
@@ -1280,7 +1273,7 @@ rte_mp_reply(struct rte_mp_msg *msg, const char *peer)
 		return -1;
 	}
 
-	if (internal_conf->no_shconf) {
+	if (user_cfg->no_shconf) {
 		EAL_LOG(DEBUG, "No shared files mode enabled, IPC is disabled");
 		return 0;
 	}
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 0516e10ebb..4ba43eb5ca 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -56,11 +56,19 @@ struct hugepage_file_discipline {
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
@@ -89,17 +97,6 @@ struct eal_runtime_state {
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
@@ -123,7 +120,6 @@ struct internal_config {
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
-	unsigned int no_telemetry; /**< true to disable Telemetry */
 	struct simd_bitwidth max_simd_bitwidth;
 	/**< max simd bitwidth path to use */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index bff0e4615a..7f8fa6e1c0 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -99,6 +99,7 @@ rte_eal_config_create(void)
 	struct rte_config *config = rte_eal_get_configuration();
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
@@ -107,7 +108,7 @@ rte_eal_config_create(void)
 
 	const char *pathname = eal_runtime_config_path();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* map the config before base address so that we don't waste a page */
@@ -184,11 +185,10 @@ rte_eal_config_attach(void)
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
@@ -223,10 +223,9 @@ rte_eal_config_reattach(void)
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
@@ -266,11 +265,10 @@ eal_proc_type_detect(void)
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
@@ -292,10 +290,9 @@ static int
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
@@ -476,9 +473,9 @@ rte_eal_init(int argc, char **argv)
 
 	/* FreeBSD always uses legacy memory model */
 	internal_conf->legacy_mem = true;
-	if (internal_conf->in_memory) {
+	if (user_cfg->in_memory) {
 		EAL_LOG(WARNING, "Warning: ignoring unsupported flag, '--in-memory'");
-		internal_conf->in_memory = false;
+		user_cfg->in_memory = false;
 	}
 
 	if (eal_plugins_init() < 0) {
@@ -578,7 +575,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
-		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
+		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
 			eal_hugepage_info_read();
 		if (ret < 0) {
@@ -595,7 +592,7 @@ rte_eal_init(int argc, char **argv)
 			user_cfg->memory = eal_get_hugepage_mem_size();
 	}
 
-	if (internal_conf->vmware_tsc_map == 1) {
+	if (user_cfg->vmware_tsc_map) {
 #ifdef RTE_LIBRTE_EAL_VMWARE_TSC_MAP_SUPPORT
 		rte_cycles_vmware_tsc_map = 1;
 		EAL_LOG(DEBUG, "Using VMWARE TSC MAP, "
@@ -744,11 +741,11 @@ rte_eal_init(int argc, char **argv)
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
@@ -796,9 +793,8 @@ rte_eal_cleanup(void)
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
index b6772e0701..586c5d9f17 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -62,6 +62,7 @@ eal_hugepage_info_init(void)
 
 	/* re-use the linux "internal config" structure for our memory data */
 	struct hugepage_info *hpi = &internal_conf->hugepage_info[0];
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct hugepage_info *tmp_hpi;
 	unsigned int i;
 
@@ -111,7 +112,7 @@ eal_hugepage_info_init(void)
 	hpi->lock_descriptor = fd;
 
 	/* for no shared files mode, do not create shared memory config */
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c51aa7e3b4..c9c30e15fd 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -184,10 +184,11 @@ rte_eal_config_create(void)
 	int retval;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	const char *pathname = eal_runtime_config_path();
 
-	if (internal_conf->no_shconf)
+	if (user_cfg->no_shconf)
 		return 0;
 
 	/* map the config before hugepage address so that we don't waste a page */
@@ -265,12 +266,11 @@ rte_eal_config_attach(void)
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
@@ -305,10 +305,9 @@ rte_eal_config_reattach(void)
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
@@ -350,11 +349,10 @@ eal_proc_type_detect(void)
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
@@ -376,10 +374,9 @@ static int
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
@@ -741,7 +738,7 @@ rte_eal_init(int argc, char **argv)
 
 	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
-		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
+		ret = user_cfg->process_type == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
 				eal_hugepage_info_read();
 		if (ret < 0) {
@@ -756,7 +753,7 @@ rte_eal_init(int argc, char **argv)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
-	if (internal_conf->vmware_tsc_map == 1) {
+	if (user_cfg->vmware_tsc_map) {
 #ifdef RTE_LIBRTE_EAL_VMWARE_TSC_MAP_SUPPORT
 		rte_cycles_vmware_tsc_map = 1;
 		EAL_LOG(DEBUG, "Using VMWARE TSC MAP, "
@@ -917,11 +914,11 @@ rte_eal_init(int argc, char **argv)
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
@@ -1000,10 +997,9 @@ rte_eal_cleanup(void)
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
index 37f5da8d1f..d2fb08e625 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -275,7 +275,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	/* for in-memory mode, we only make it here when we're sure we support
 	 * memfd, and this is a special case.
 	 */
-	if (internal_conf->in_memory)
+	if (user_cfg->in_memory)
 		return get_seg_memfd(hi, list_idx, seg_idx);
 
 	if (internal_conf->single_file_segments) {
@@ -459,13 +459,12 @@ resize_hugefile_in_filesystem(int fd, uint64_t fa_offset, uint64_t page_sz,
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
@@ -482,10 +481,9 @@ resize_hugefile(int fd, uint64_t fa_offset, uint64_t page_sz, bool grow,
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
@@ -521,7 +519,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	alloc_sz = hi->hugepage_sz;
 
 	/* these are checked at init, but code analyzers don't know that */
-	if (internal_conf->in_memory && !anonymous_hugepages_supported) {
+	if (user_cfg->in_memory && !anonymous_hugepages_supported) {
 		EAL_LOG(ERR, "Anonymous hugepages not supported, in-memory mode cannot allocate memory");
 		return -1;
 	}
@@ -550,7 +548,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 			goto resized;
 		}
 		if (user_cfg->hugepage_file.unlink_before_mapping &&
-				!internal_conf->in_memory) {
+				!user_cfg->in_memory) {
 			if (unlink(path)) {
 				EAL_LOG(DEBUG, "%s(): unlink() failed: %s",
 					__func__, strerror(errno));
@@ -683,7 +681,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	} else {
 		/* only remove file if we can take out a write lock */
 		if (!user_cfg->hugepage_file.unlink_before_mapping &&
-				internal_conf->in_memory == 0 &&
+				!user_cfg->in_memory &&
 				lock(fd, LOCK_EX) == 1)
 			unlink(path);
 		close(fd);
@@ -736,7 +734,7 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 		/* if we're able to take out a write lock, we're the last one
 		 * holding onto this page.
 		 */
-		if (!internal_conf->in_memory &&
+		if (!user_cfg->in_memory &&
 				user_cfg->hugepage_file.unlink_existing &&
 				!user_cfg->hugepage_file.unlink_before_mapping) {
 			ret = lock(fd, LOCK_EX);
@@ -774,8 +772,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	size_t page_sz;
 	int cur_idx, start_idx, j, dir_fd = -1;
 	unsigned int msl_idx, need, i;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
@@ -825,7 +822,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	 * during init, we already hold a write lock, so don't try to take out
 	 * another one.
 	 */
-	if (wa->hi->lock_descriptor == -1 && !internal_conf->in_memory) {
+	if (wa->hi->lock_descriptor == -1 && !user_cfg->in_memory) {
 		dir_fd = open(wa->hi->hugedir, O_RDONLY);
 		if (dir_fd < 0) {
 			EAL_LOG(ERR, "%s(): Cannot open '%s': %s",
@@ -908,8 +905,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
 	int msl_idx, seg_idx, ret, dir_fd = -1;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	start_addr = (uintptr_t) msl->base_va;
 	end_addr = start_addr + msl->len;
@@ -932,7 +928,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 	 * during init, we already hold a write lock, so don't try to take out
 	 * another one.
 	 */
-	if (wa->hi->lock_descriptor == -1 && !internal_conf->in_memory) {
+	if (wa->hi->lock_descriptor == -1 && !user_cfg->in_memory) {
 		dir_fd = open(wa->hi->hugedir, O_RDONLY);
 		if (dir_fd < 0) {
 			EAL_LOG(ERR, "%s(): Cannot open '%s': %s",
@@ -1097,8 +1093,7 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 int
 eal_memalloc_free_seg(struct rte_memseg *ms)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct internal_config *internal_conf = eal_get_internal_configuration();
 
 	/* dynamic free not supported in legacy mode */
 	if (internal_conf->legacy_mem)
@@ -1656,8 +1651,6 @@ eal_memalloc_cleanup(void)
 int
 eal_memalloc_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
@@ -1667,7 +1660,7 @@ eal_memalloc_init(void)
 		if (rte_memseg_list_walk_thread_unsafe(secondary_msl_create_walk, NULL) < 0)
 			return -1;
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
-			internal_conf->in_memory) {
+			user_cfg->in_memory) {
 		EAL_LOG(DEBUG, "Using memfd for anonymous memory");
 		/* this cannot ever happen but better safe than sorry */
 		if (!anonymous_hugepages_supported) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index a53fe65c60..f52206e698 100644
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
 
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index f1050ffa60..678ac57e87 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -482,8 +482,8 @@ vfio_get_group_fd(struct vfio_config *vfio_cfg,
 	 * knowledge of them. Requesting a group fd from the primary for a
 	 * container it doesn't know about would be incorrect.
 	 */
-	const struct internal_config *internal_conf = eal_get_internal_configuration();
-	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	bool mp_request = (user_cfg->process_type == RTE_PROC_SECONDARY) &&
 			(vfio_cfg == default_vfio_cfg);
 
 	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
@@ -770,8 +770,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	int iommu_group_num;
 	rte_uuid_t vf_token;
 	int i, ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* get group number */
 	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
@@ -853,7 +852,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		 * Note this can happen several times with the hotplug
 		 * functionality.
 		 */
-		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
+		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
 				vfio_cfg->vfio_active_groups == 1 &&
 				vfio_group_device_count(vfio_group_fd) == 0) {
 			const struct vfio_iommu_type *t;
@@ -1106,8 +1105,7 @@ rte_vfio_enable(const char *modname)
 	unsigned int i, j;
 	int vfio_available;
 	DIR *dir;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
@@ -1151,7 +1149,7 @@ rte_vfio_enable(const char *modname)
 	}
 	closedir(dir);
 
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
+	if (user_cfg->process_type == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
 			default_vfio_cfg->vfio_container_fd = -1;
 		} else {
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 622bda7578..9ec4892fdb 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -218,11 +218,11 @@ rte_eal_init(int argc, char **argv)
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
2.51.0

