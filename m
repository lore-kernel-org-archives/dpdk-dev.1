Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787DBC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:36:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90AA44027C;
	Tue, 18 Aug 2026 15:34:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9E83240DD1
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060047; x=1818596047;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m4AhvSJHXEH0k+H0ExUWIEhDmjjXt4HTHJiePQV2qM0=;
 b=d1+AYXc0m1SYSDzpeseidR+X9qBCDgaPIYMBRO8enLSd3EGxtyz/TZ4j
 H2m3w7H8kauit+PCH2hc+jZLKJmbZY+Xz2vumqZRAL9fseaahX/dRKLbD
 qojbfEZohJaGfltM5uWH+OtHnac/Qdim9g8KYeK4O+YAx2d6NxyTR67uS
 l5asTG3bdPeI8Xnzmcjg/ifw/kjS8fMyh3DX9R0+T9mLCN/TABqLDxd9U
 70s6gwVrVJYfjnlJajzubg9yOlYei3og0EN9eb6lz2jITJ7qWbd5X4DrF
 k2yJtgJoaG3FlH5ROD047t5LqEocuOObxvlXA+v4/L6ujjg1GAmnNqf88 w==;
X-CSE-ConnectionGUID: kd8ZZ/NtQkSoaUJTURMdYQ==
X-CSE-MsgGUID: PxnFxMiLQ4C6Qqrkq3Pnyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757659"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757659"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:34:06 -0700
X-CSE-ConnectionGUID: qQar0ZLMTKmK+uqJAkYzfw==
X-CSE-MsgGUID: fEFXUAObRdKdM68nboL4/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736716"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:34:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 23/39] eal: move memory config pointer to runtime state
 struct
Date: Tue, 18 Aug 2026 14:33:16 +0100
Message-ID: <20260818133334.2620165-24-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

Remove the final field from the rte_config struct - the mem_config
pointer - and put it in the runtime state structure instead. The
rte_config struct is now unused and ready for removal in a later commit.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  | 15 ++++++---
 lib/eal/common/eal_common_dynmem.c  |  2 +-
 lib/eal/common/eal_common_mcfg.c    | 23 ++++++-------
 lib/eal/common/eal_common_memory.c  | 52 ++++++++++++++---------------
 lib/eal/common/eal_common_memzone.c | 20 +++++------
 lib/eal/common/eal_common_proc.c    |  2 +-
 lib/eal/common/eal_common_tailqs.c  |  6 ++--
 lib/eal/common/eal_common_timer.c   |  2 +-
 lib/eal/common/eal_internal_cfg.h   |  4 +++
 lib/eal/common/eal_memcfg.h         |  3 ++
 lib/eal/common/eal_private.h        |  6 +---
 lib/eal/common/malloc_heap.c        | 22 ++++++------
 lib/eal/common/malloc_mp.c          |  2 +-
 lib/eal/common/rte_malloc.c         | 14 ++++----
 lib/eal/freebsd/eal.c               | 22 ++++++------
 lib/eal/freebsd/eal_memory.c        |  6 ++--
 lib/eal/linux/eal.c                 | 24 ++++++-------
 lib/eal/linux/eal_memalloc.c        | 18 +++++-----
 lib/eal/linux/eal_memory.c          | 14 ++++----
 lib/eal/windows/eal.c               |  6 ++--
 lib/eal/windows/eal_memalloc.c      |  4 +--
 lib/eal/windows/eal_memory.c        |  2 +-
 22 files changed, 138 insertions(+), 131 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 7e6704a32d..ebb7c222d9 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -21,9 +21,7 @@ static struct rte_mem_config early_mem_config = {
 };
 
 /* Address of global and public configuration */
-static struct rte_config rte_config = {
-	.mem_config = &early_mem_config,
-};
+static struct rte_config rte_config;
 
 /* platform-specific runtime dir */
 static char runtime_dir[UNIX_PATH_MAX];
@@ -35,7 +33,9 @@ static struct eal_user_cfg eal_user_cfg;
 static struct eal_platform_info eal_platform_info;
 
 /* internal runtime configuration */
-static struct eal_runtime_state eal_runtime_state;
+static struct eal_runtime_state eal_runtime_state = {
+	.mem_config = &early_mem_config,
+};
 
 RTE_EXPORT_SYMBOL(rte_eal_get_runtime_dir)
 const char *
@@ -63,6 +63,13 @@ rte_eal_get_configuration(void)
 	return &rte_config;
 }
 
+/* Return a pointer to the memory config structure */
+struct rte_mem_config *
+eal_get_mcfg(void)
+{
+	return eal_get_runtime_state()->mem_config;
+}
+
 /* Return a pointer to the user configuration structure */
 struct eal_user_cfg *
 eal_get_user_configuration(void)
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index df6cdb00e9..9e73e45a60 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -20,7 +20,7 @@
 int
 eal_dynmem_memseg_lists_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct memtype {
 		uint64_t page_sz;
 		int socket_id;
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index cc4107bbca..1e09bd650d 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -13,8 +13,7 @@
 void
 eal_mcfg_complete(void)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
-	struct rte_mem_config *mcfg = cfg->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* ALL shared mem_config related INIT DONE */
@@ -27,7 +26,7 @@ eal_mcfg_complete(void)
 void
 eal_mcfg_wait_complete(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	/* wait until shared mem_config finish initialising */
 	rte_wait_until_equal_32(&mcfg->magic, RTE_MAGIC, rte_memory_order_relaxed);
@@ -36,7 +35,7 @@ eal_mcfg_wait_complete(void)
 int
 eal_mcfg_check_version(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	/* check if version from memconfig matches compiled in macro */
 	if (mcfg->version != RTE_VERSION)
@@ -48,7 +47,7 @@ eal_mcfg_check_version(void)
 void
 eal_mcfg_update_internal(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	user_cfg->legacy_mem = mcfg->legacy_mem;
@@ -58,7 +57,7 @@ eal_mcfg_update_internal(void)
 void
 eal_mcfg_update_from_internal(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	mcfg->legacy_mem = user_cfg->legacy_mem;
@@ -71,7 +70,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mem_get_lock)
 rte_rwlock_t *
 rte_mcfg_mem_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->memory_hotplug_lock;
+	return &eal_get_mcfg()->memory_hotplug_lock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_lock)
@@ -106,7 +105,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_tailq_get_lock)
 rte_rwlock_t *
 rte_mcfg_tailq_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->qlock;
+	return &eal_get_mcfg()->qlock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_lock)
@@ -141,7 +140,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mempool_get_lock)
 rte_rwlock_t *
 rte_mcfg_mempool_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->mplock;
+	return &eal_get_mcfg()->mplock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_lock)
@@ -176,7 +175,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_timer_get_lock)
 rte_spinlock_t *
 rte_mcfg_timer_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->tlock;
+	return &eal_get_mcfg()->tlock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_timer_lock)
@@ -197,13 +196,13 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_ethdev_get_lock)
 rte_spinlock_t *
 rte_mcfg_ethdev_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->ethdev_lock;
+	return &eal_get_mcfg()->ethdev_lock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_get_single_file_segments)
 bool
 rte_mcfg_get_single_file_segments(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	return (bool)mcfg->single_file_segments;
 }
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index a7d8debebe..90196f9b67 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -341,7 +341,7 @@ virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 static struct rte_memseg_list *
 virt2memseg_list(const void *addr)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	int msl_idx;
 
@@ -456,7 +456,7 @@ static int
 dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 		void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx, ms_idx, fd;
 	FILE *f = arg;
 
@@ -588,7 +588,7 @@ check_iova(const struct rte_memseg_list *msl __rte_unused,
 static int
 check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint64_t mask;
 	int ret;
 
@@ -651,7 +651,7 @@ RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask)
 void
 rte_mem_set_dma_mask(uint8_t maskbits)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	mcfg->dma_maskbits = mcfg->dma_maskbits == 0 ? maskbits :
 			     RTE_MIN(mcfg->dma_maskbits, maskbits);
@@ -661,29 +661,27 @@ rte_mem_set_dma_mask(uint8_t maskbits)
 RTE_EXPORT_SYMBOL(rte_memory_get_nchannel)
 unsigned rte_memory_get_nchannel(void)
 {
-	return rte_eal_get_configuration()->mem_config->nchannel;
+	return eal_get_mcfg()->nchannel;
 }
 
 /* return the number of memory rank */
 RTE_EXPORT_SYMBOL(rte_memory_get_nrank)
 unsigned rte_memory_get_nrank(void)
 {
-	return rte_eal_get_configuration()->mem_config->nrank;
+	return eal_get_mcfg()->nrank;
 }
 
 static int
 rte_eal_memdevice_init(void)
 {
-	struct rte_config *config;
 	const struct eal_user_cfg *user_cfg;
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		return 0;
 
 	user_cfg = eal_get_user_configuration();
-	config = rte_eal_get_configuration();
-	config->mem_config->nchannel = user_cfg->force_nchannel;
-	config->mem_config->nrank = user_cfg->force_nrank;
+	eal_get_mcfg()->nchannel = user_cfg->force_nchannel;
+	eal_get_mcfg()->nrank = user_cfg->force_nrank;
 
 	return 0;
 }
@@ -703,7 +701,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
 int
 rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -757,7 +755,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe)
 int
 rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -800,7 +798,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe)
 int
 rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -834,7 +832,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe)
 int
 rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -891,7 +889,7 @@ int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -948,7 +946,7 @@ int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int socket_id, n;
 	int ret = 0;
 
@@ -1068,7 +1066,7 @@ int
 rte_eal_memory_detach(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	size_t page_sz = rte_mem_page_size();
 	unsigned int i;
 
@@ -1120,7 +1118,7 @@ rte_eal_memory_detach(void)
 			EAL_LOG(ERR, "Could not unmap shared memory config: %s",
 					rte_strerror(rte_errno));
 	}
-	rte_eal_get_configuration()->mem_config = NULL;
+	eal_get_runtime_state()->mem_config = NULL;
 
 	return 0;
 }
@@ -1173,7 +1171,7 @@ static int
 handle_eal_heap_info_request(const char *cmd __rte_unused, const char *params,
 			     struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	struct malloc_heap *heap;
 	unsigned int heap_id;
@@ -1210,7 +1208,7 @@ handle_eal_heap_list_request(const char *cmd __rte_unused,
 				const char *params __rte_unused,
 				struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	unsigned int heap_id;
 
@@ -1232,7 +1230,7 @@ static int
 handle_eal_memzone_info_request(const char *cmd __rte_unused,
 				const char *params, struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl = NULL;
 	int ms_idx, ms_count = 0;
 	void *cur_addr, *mz_end;
@@ -1294,7 +1292,7 @@ static void
 memzone_list_cb(const struct rte_memzone *mz __rte_unused,
 		 void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_tel_data *d = arg;
 	int mz_idx;
 
@@ -1359,7 +1357,7 @@ handle_eal_memseg_lists_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
 		struct rte_memseg_list *msl = &mcfg->memsegs[i];
@@ -1395,7 +1393,7 @@ handle_eal_memseg_list_info_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0)
 		goto done;
@@ -1442,7 +1440,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0) {
 		rte_mcfg_mem_read_unlock();
@@ -1521,7 +1519,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	ms = rte_fbarray_get(&msl->memseg_arr, ms_idx);
 	if (ms == NULL) {
@@ -1599,7 +1597,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	ms = rte_fbarray_get(&msl->memseg_arr, ms_idx);
 	if (ms == NULL) {
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index 1207d524c9..570cb60757 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -39,7 +39,7 @@ rte_memzone_max_set(size_t max)
 		return -1;
 	}
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	if (mcfg == NULL) {
 		EAL_LOG(ERR, "Failed to set max memzone count");
 		return -1;
@@ -56,7 +56,7 @@ rte_memzone_max_get(void)
 {
 	struct rte_mem_config *mcfg;
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	if (mcfg == NULL || mcfg->max_memzone == 0)
 		return DEFAULT_MAX_MEMZONE_COUNT;
 
@@ -72,7 +72,7 @@ memzone_lookup_thread_unsafe(const char *name)
 	int i = 0;
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	arr = &mcfg->memzones;
 
 	/*
@@ -116,7 +116,7 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 	bool contig;
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	arr = &mcfg->memzones;
 
 	/* no more room in config */
@@ -248,7 +248,7 @@ rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
 	const struct rte_memzone *mz = NULL;
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	rte_rwlock_write_lock(&mcfg->mlock);
 
@@ -319,7 +319,7 @@ rte_memzone_free(const struct rte_memzone *mz)
 		return -EINVAL;
 
 	rte_strlcpy(name, mz->name, RTE_MEMZONE_NAMESIZE);
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	arr = &mcfg->memzones;
 
 	rte_rwlock_write_lock(&mcfg->mlock);
@@ -357,7 +357,7 @@ rte_memzone_lookup(const char *name)
 	struct rte_mem_config *mcfg;
 	const struct rte_memzone *memzone = NULL;
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	rte_rwlock_read_lock(&mcfg->mlock);
 
@@ -377,7 +377,7 @@ struct memzone_info {
 static void
 dump_memzone(const struct rte_memzone *mz, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl = NULL;
 	struct memzone_info *info = arg;
 	void *cur_addr, *mz_end;
@@ -448,7 +448,7 @@ rte_eal_memzone_init(void)
 	int ret = 0;
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	rte_rwlock_write_lock(&mcfg->mlock);
 
@@ -477,7 +477,7 @@ void rte_memzone_walk(void (*func)(const struct rte_memzone *, void *),
 	struct rte_fbarray *arr;
 	int i;
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	arr = &mcfg->memzones;
 
 	rte_rwlock_read_lock(&mcfg->mlock);
diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 0f19899517..ddc00192de 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1359,7 +1359,7 @@ enum mp_status {
 static bool
 set_mp_status(enum mp_status status)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint8_t expected;
 	uint8_t desired;
 
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index fe3ced21c7..a90c0c8932 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -29,7 +29,7 @@ struct rte_tailq_head *
 rte_eal_tailq_lookup(const char *name)
 {
 	unsigned i;
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	if (name == NULL) {
 		rte_errno = EINVAL;
@@ -53,7 +53,7 @@ rte_dump_tailq(FILE *f)
 	struct rte_mem_config *mcfg;
 	unsigned i = 0;
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	rte_mcfg_tailq_read_lock();
 	for (i = 0; i < RTE_MAX_TAILQ; i++) {
@@ -81,7 +81,7 @@ rte_eal_tailq_create(const char *name)
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
 
-		mcfg = rte_eal_get_configuration()->mem_config;
+		mcfg = eal_get_mcfg();
 		head = &mcfg->tailq_head[rte_tailqs_count];
 		strlcpy(head->name, name, sizeof(head->name));
 		TAILQ_INIT(&head->tailq_head);
diff --git a/lib/eal/common/eal_common_timer.c b/lib/eal/common/eal_common_timer.c
index bbf8b8b11b..4051096784 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -55,7 +55,7 @@ estimate_tsc_freq(void)
 void
 set_tsc_freq(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint64_t freq;
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 60936ec62b..606ef65bc0 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -20,6 +20,9 @@
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
 
+/* Forward declaration — full definition is in eal_memcfg.h */
+struct rte_mem_config;
+
 #if defined(RTE_ARCH_ARM)
 #define MAX_HUGEPAGE_SIZES 4  /**< support up to 4 page sizes */
 #else
@@ -154,6 +157,7 @@ struct eal_runtime_state {
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
+	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 2b3b3b62ba..51dddbf525 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -86,6 +86,9 @@ struct rte_mem_config {
 	size_t max_memzone; /**< Maximum number of allocated memzones. */
 };
 
+/* Return a pointer to the shared memory config */
+struct rte_mem_config *eal_get_mcfg(void);
+
 /* update internal config from shared mem config */
 void
 eal_mcfg_update_internal(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index b0e0bf2e00..0a82e068e8 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -21,11 +21,7 @@
  * The global RTE configuration structure.
  */
 struct rte_config {
-	/**
-	 * Pointer to memory configuration, which may be shared across multiple
-	 * DPDK instances
-	 */
-	struct rte_mem_config *mem_config;
+	int _unused; /**< dummy field to prevent empty struct */
 };
 
 /**
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index bd25496275..90534c9cbc 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -71,7 +71,7 @@ check_hugepage_sz(unsigned flags, uint64_t hugepage_sz)
 int
 malloc_socket_to_heap_id(unsigned int socket_id)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i;
 
 	for (i = 0; i < RTE_MAX_HEAPS; i++) {
@@ -107,7 +107,7 @@ static int
 malloc_add_seg(const struct rte_memseg_list *msl,
 		const struct rte_memseg *ms, size_t len, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *found_msl;
 	struct malloc_heap *heap;
 	int msl_idx, heap_idx;
@@ -294,7 +294,7 @@ alloc_pages_on_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
 		int socket, unsigned int flags, size_t align, size_t bound,
 		bool contig, struct rte_memseg **ms, int n_segs)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct malloc_elem *elem = NULL;
 	size_t alloc_sz;
@@ -465,7 +465,7 @@ try_expand_heap_secondary(struct malloc_heap *heap, uint64_t pg_sz,
 		size_t elt_size, int socket, unsigned int flags, size_t align,
 		size_t bound, bool contig)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct malloc_mp_req req;
 	int req_result;
 
@@ -534,7 +534,7 @@ static int
 alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int socket,
 		unsigned int flags, size_t align, size_t bound, bool contig)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *requested_msls[RTE_MAX_MEMSEG_LISTS];
 	struct rte_memseg_list *other_msls[RTE_MAX_MEMSEG_LISTS];
 	uint64_t requested_pg_sz[RTE_MAX_MEMSEG_LISTS];
@@ -642,7 +642,7 @@ static void *
 malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int flags, size_t align,
 		size_t bound, bool contig)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct malloc_heap *heap = &mcfg->malloc_heaps[heap_id];
 	unsigned int size_flags = flags & ~RTE_MEMZONE_SIZE_HINT_ONLY;
 	int socket_id;
@@ -773,7 +773,7 @@ static void *
 heap_alloc_biggest_on_heap_id(unsigned int heap_id,
 		unsigned int flags, size_t align, bool contig)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct malloc_heap *heap = &mcfg->malloc_heaps[heap_id];
 	void *ret;
 
@@ -1175,7 +1175,7 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz, const char *seg_name,
 		unsigned int socket_id)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	char fbarray_name[RTE_FBARRAY_NAME_LEN];
 	struct rte_memseg_list *msl = NULL;
 	struct rte_fbarray *arr;
@@ -1242,7 +1242,7 @@ struct extseg_walk_arg {
 static int
 extseg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct extseg_walk_arg *wa = arg;
 
 	if (msl->base_va == wa->va_addr && msl->len == wa->len) {
@@ -1343,7 +1343,7 @@ malloc_heap_remove_external_memory(struct malloc_heap *heap, void *va_addr,
 int
 malloc_heap_create(struct malloc_heap *heap, const char *heap_name)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint32_t next_socket_id = mcfg->next_socket_id;
 
 	/* prevent overflow. did you really create 2 billion heaps??? */
@@ -1397,7 +1397,7 @@ malloc_heap_destroy(struct malloc_heap *heap)
 int
 rte_eal_malloc_heap_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int i;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
index 9765277f5d..d225b22bfd 100644
--- a/lib/eal/common/malloc_mp.c
+++ b/lib/eal/common/malloc_mp.c
@@ -217,7 +217,7 @@ static int
 handle_alloc_request(const struct malloc_mp_req *m,
 		struct mp_request *req)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct malloc_req_alloc *ar = &m->alloc_req;
 	struct malloc_heap *heap;
 	struct malloc_elem *elem;
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 388e5a63b6..9e1c7adfed 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -265,7 +265,7 @@ int
 rte_malloc_get_socket_stats(int socket,
 		struct rte_malloc_socket_stats *socket_stats)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int heap_idx;
 
 	heap_idx = malloc_socket_to_heap_id(socket);
@@ -283,7 +283,7 @@ RTE_EXPORT_SYMBOL(rte_malloc_dump_heaps)
 void
 rte_malloc_dump_heaps(FILE *f)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int idx;
 
 	for (idx = 0; idx < RTE_MAX_HEAPS; idx++) {
@@ -296,7 +296,7 @@ RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket)
 int
 rte_malloc_heap_get_socket(const char *name)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct malloc_heap *heap = NULL;
 	unsigned int idx;
 	int ret;
@@ -333,7 +333,7 @@ RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external)
 int
 rte_malloc_heap_socket_is_external(int socket_id)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int idx;
 	int ret = -1;
 
@@ -362,7 +362,7 @@ RTE_EXPORT_SYMBOL(rte_malloc_dump_stats)
 void
 rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int heap_id;
 	struct rte_malloc_socket_stats sock_stats;
 
@@ -414,7 +414,7 @@ rte_malloc_virt2iova(const void *addr)
 static struct malloc_heap *
 find_named_heap(const char *name)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int i;
 
 	for (i = 0; i < RTE_MAX_HEAPS; i++) {
@@ -616,7 +616,7 @@ RTE_EXPORT_SYMBOL(rte_malloc_heap_create)
 int
 rte_malloc_heap_create(const char *heap_name)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct malloc_heap *heap = NULL;
 	int i, ret;
 
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 3b78c98ff8..ffc3a3f0cd 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -93,7 +93,7 @@ eal_clean_runtime_dir(void)
 static int
 rte_eal_config_create(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
@@ -163,13 +163,13 @@ rte_eal_config_create(void)
 		return -1;
 	}
 
-	memcpy(rte_mem_cfg_addr, config->mem_config, sizeof(struct rte_mem_config));
-	config->mem_config = rte_mem_cfg_addr;
+	memcpy(rte_mem_cfg_addr, runtime_state->mem_config, sizeof(struct rte_mem_config));
+	runtime_state->mem_config = rte_mem_cfg_addr;
 
 	/* store address of the config in the config itself so that secondary
 	 * processes could later map the config into this exact location
 	 */
-	config->mem_config->mem_cfg_addr = (uintptr_t) rte_mem_cfg_addr;
+	runtime_state->mem_config->mem_cfg_addr = (uintptr_t) rte_mem_cfg_addr;
 	return 0;
 }
 
@@ -179,7 +179,7 @@ rte_eal_config_attach(void)
 {
 	void *rte_mem_cfg_addr;
 	const char *pathname = eal_runtime_config_path();
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 
@@ -195,7 +195,7 @@ rte_eal_config_attach(void)
 		}
 	}
 
-	rte_mem_cfg_addr = mmap(NULL, sizeof(*config->mem_config),
+	rte_mem_cfg_addr = mmap(NULL, sizeof(*runtime_state->mem_config),
 				PROT_READ, MAP_SHARED, mem_cfg_fd, 0);
 	/* don't close the fd here, it will be closed on reattach */
 	if (rte_mem_cfg_addr == MAP_FAILED) {
@@ -206,7 +206,7 @@ rte_eal_config_attach(void)
 		return -1;
 	}
 
-	config->mem_config = rte_mem_cfg_addr;
+	runtime_state->mem_config = rte_mem_cfg_addr;
 
 	return 0;
 }
@@ -217,7 +217,7 @@ rte_eal_config_reattach(void)
 {
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->no_shconf)
@@ -225,10 +225,10 @@ rte_eal_config_reattach(void)
 
 	/* save the address primary process has mapped shared config to */
 	rte_mem_cfg_addr =
-			(void *)(uintptr_t)config->mem_config->mem_cfg_addr;
+			(void *)(uintptr_t)runtime_state->mem_config->mem_cfg_addr;
 
 	/* unmap original config */
-	munmap(config->mem_config, sizeof(struct rte_mem_config));
+	munmap(runtime_state->mem_config, sizeof(struct rte_mem_config));
 
 	/* remap the config at proper address */
 	mem_config = (struct rte_mem_config *) mmap(rte_mem_cfg_addr,
@@ -249,7 +249,7 @@ rte_eal_config_reattach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 221c003229..8182171c80 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -75,7 +75,7 @@ rte_eal_hugepage_init(void)
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* for debug purposes, hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -348,7 +348,7 @@ memseg_list_alloc(struct rte_memseg_list *msl)
 static int
 memseg_primary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -412,7 +412,7 @@ memseg_primary_init(void)
 static int
 memseg_secondary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index acfefc71f8..c24d02f646 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -173,9 +173,9 @@ eal_clean_runtime_dir(void)
 static int
 rte_eal_config_create(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	size_t page_sz = rte_mem_page_size();
-	size_t cfg_len = sizeof(*config->mem_config);
+	size_t cfg_len = sizeof(*runtime_state->mem_config);
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
 	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
 	int retval;
@@ -243,14 +243,14 @@ rte_eal_config_create(void)
 		return -1;
 	}
 
-	memcpy(rte_mem_cfg_addr, config->mem_config, sizeof(struct rte_mem_config));
-	config->mem_config = rte_mem_cfg_addr;
+	memcpy(rte_mem_cfg_addr, runtime_state->mem_config, sizeof(struct rte_mem_config));
+	runtime_state->mem_config = rte_mem_cfg_addr;
 
 	/* store address of the config in the config itself so that secondary
 	 * processes could later map the config into this exact location
 	 */
-	config->mem_config->mem_cfg_addr = (uintptr_t) rte_mem_cfg_addr;
-	config->mem_config->dma_maskbits = 0;
+	runtime_state->mem_config->mem_cfg_addr = (uintptr_t) rte_mem_cfg_addr;
+	runtime_state->mem_config->dma_maskbits = 0;
 
 	return 0;
 }
@@ -259,7 +259,7 @@ rte_eal_config_create(void)
 static int
 rte_eal_config_attach(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mem_config;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
@@ -288,7 +288,7 @@ rte_eal_config_attach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
@@ -297,7 +297,7 @@ rte_eal_config_attach(void)
 static int
 rte_eal_config_reattach(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -307,10 +307,10 @@ rte_eal_config_reattach(void)
 
 	/* save the address primary process has mapped shared config to */
 	rte_mem_cfg_addr =
-		(void *) (uintptr_t) config->mem_config->mem_cfg_addr;
+		(void *) (uintptr_t) runtime_state->mem_config->mem_cfg_addr;
 
 	/* unmap original config */
-	munmap(config->mem_config, sizeof(struct rte_mem_config));
+	munmap(runtime_state->mem_config, sizeof(struct rte_mem_config));
 
 	/* remap the config at proper address */
 	mem_config = (struct rte_mem_config *) mmap(rte_mem_cfg_addr,
@@ -333,7 +333,7 @@ rte_eal_config_reattach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 8e713922c7..2841ac72d8 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -761,7 +761,7 @@ struct alloc_walk_param {
 static int
 alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct alloc_walk_param *wa = arg;
 	struct rte_memseg_list *cur_msl;
 	size_t page_sz;
@@ -895,7 +895,7 @@ struct free_walk_param {
 static int
 free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *found_msl;
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
@@ -1325,7 +1325,7 @@ sync_existing(struct rte_memseg_list *primary_msl,
 static int
 sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hi = NULL;
@@ -1378,7 +1378,7 @@ static int
 secondary_msl_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	char name[RTE_FBARRAY_NAME_LEN];
 	int msl_idx, ret;
@@ -1427,7 +1427,7 @@ static int
 secondary_msl_destroy_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *local_msl;
 	int msl_idx, ret;
 
@@ -1510,7 +1510,7 @@ static int
 fd_list_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int len;
 	int msl_idx;
 
@@ -1526,7 +1526,7 @@ fd_list_create_walk(const struct rte_memseg_list *msl,
 static int
 fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx;
 
 	if (msl->external)
@@ -1540,7 +1540,7 @@ fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 int
 eal_memalloc_set_seg_fd(int list_idx, int seg_idx, int fd)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single file segments mode doesn't support individual segment fd's */
@@ -1595,7 +1595,7 @@ eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->single_file_segments) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 8e61a0a6ae..90d9a6c973 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -679,7 +679,7 @@ unmap_unneeded_hugepages(struct hugepage_file *hugepg_tbl,
 static int
 remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int cur_page, seg_len;
@@ -839,7 +839,7 @@ static int __rte_unused
 prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 {
 	const struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int cur_page, seg_start_page, end_seg, new_memseg;
 	unsigned int hpi_idx, socket, i;
 	int n_contig_segs, n_segs;
@@ -1137,7 +1137,7 @@ eal_legacy_hugepage_init(void)
 	memset(used_hp, 0, sizeof(used_hp));
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -1514,7 +1514,7 @@ getFileSize(int fd)
 static int
 eal_legacy_hugepage_attach(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct hugepage_file *hp = NULL;
 	unsigned int num_hp = 0;
 	unsigned int i = 0;
@@ -1687,7 +1687,7 @@ memseg_primary_init_32(void)
 {
 	/* limit total amount of memory on 32-bit */
 	const uint64_t mem32_max_mem = 2ULL << 30;
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int active_sockets, hpi_idx, msl_idx = 0;
 	unsigned int socket_id, i;
 	struct rte_memseg_list *msl;
@@ -1889,7 +1889,7 @@ memseg_primary_init(void)
 static int __rte_unused
 memseg_secondary_init_dynmem(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 	void *mem_va_addr;
@@ -1940,7 +1940,7 @@ memseg_secondary_init_dynmem(void)
 static int
 memseg_secondary_init_legacy(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 22e0b9c620..6220ce00a0 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -45,7 +45,7 @@ eal_proc_type_detect(void)
 {
 	enum rte_proc_type_t ptype = RTE_PROC_PRIMARY;
 	const char *pathname = eal_runtime_config_path();
-	const struct rte_config *config = rte_eal_get_configuration();
+	const struct rte_mem_config *config = eal_get_mcfg();
 
 	/* if we can open the file but not get a write-lock we are a secondary
 	 * process. NOTE: if we get a file handle back, we keep that open
@@ -55,14 +55,14 @@ eal_proc_type_detect(void)
 		_O_RDWR, _SH_DENYNO, _S_IREAD | _S_IWRITE);
 	if (err == 0) {
 		OVERLAPPED soverlapped = { 0 };
-		soverlapped.Offset = sizeof(*config->mem_config);
+		soverlapped.Offset = sizeof(*config);
 		soverlapped.OffsetHigh = 0;
 
 		HANDLE hwinfilehandle = (HANDLE)_get_osfhandle(mem_cfg_fd);
 
 		if (!LockFileEx(hwinfilehandle,
 			LOCKFILE_EXCLUSIVE_LOCK | LOCKFILE_FAIL_IMMEDIATELY, 0,
-			sizeof(*config->mem_config), 0, &soverlapped))
+			sizeof(*config), 0, &soverlapped))
 			ptype = RTE_PROC_SECONDARY;
 	}
 
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 35eaf3a180..7eaae467d8 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -178,7 +178,7 @@ struct alloc_walk_param {
 static int
 alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct alloc_walk_param *wa = arg;
 	struct rte_memseg_list *cur_msl;
 	size_t page_sz;
@@ -279,7 +279,7 @@ struct free_walk_param {
 static int
 free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *found_msl;
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 8fcd636a3a..8a267a9215 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -677,7 +677,7 @@ eal_nohuge_init(void)
 	uint64_t mem_sz, page_sz;
 	void *addr;
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* nohuge mode is legacy mode */
-- 
2.53.0

