Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3262CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53C540E1F;
	Wed, 29 Apr 2026 18:59:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6B5BB40E2B;
 Wed, 29 Apr 2026 18:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481962; x=1809017962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZrJNNvwBUqYxcH8hN71wUUsNJyLKJ+fPEYednjS3OY4=;
 b=KtW3Ov2GYnIXtPKoy8+X3+RSkoKQ9cMEL4KSCGFAsVzMyrvmnM9oPho9
 KILsXuN4DNfkS+YuHfGl5aIKSoUtRK1w8KK02a+Gx07npV7qJ1iBqz1A5
 /PzVI3uiy+h6knqJmleuL2wwC+ipHKZQiEmnPzLPPjrpRibk3hM/0jhVa
 DHuuNOghTfh6vWrjWZo47FOuaV8JjrGwUFbgQeokoEY0m0IcWVwfBYNy8
 rnE6Zf/ZijSWobkNb0CIxcJPj73p2eWb4YWtts/B0j8CH3jzPHDEEcRG/
 g1gBoPbV4GnEKakBVnkaho6m9ZgoVkpeG+ZIcSr2ajnWrs+u3yE/W+rXD A==;
X-CSE-ConnectionGUID: gBe5tkivRIqW/DH+CaRuDA==
X-CSE-MsgGUID: SVAePU+kRP6nWd2x/TcyZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725332"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725332"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:22 -0700
X-CSE-ConnectionGUID: ypyNNjfaSda7Nm5cvBlPCA==
X-CSE-MsgGUID: JSVgZnKXR+KL3DGXSEpDqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697000"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 20/44] eal: move memory config pointer to runtime state
 struct
Date: Wed, 29 Apr 2026 17:58:12 +0100
Message-ID: <20260429165845.2136843-21-bruce.richardson@intel.com>
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

Remove the final field from the rte_config struct - the mem_config
pointer - and put it in the runtime state structure instead. The
rte_config struct is now unused and ready for removal is a later commit.

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
 lib/eal/linux/eal_memory.c          | 12 +++----
 lib/eal/windows/eal.c               |  6 ++--
 lib/eal/windows/eal_memalloc.c      |  4 +--
 lib/eal/windows/eal_memory.c        |  2 +-
 22 files changed, 137 insertions(+), 130 deletions(-)

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
index 674ea5ec42..629cec7ccc 100644
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
index 42ddc34b01..cc7ee56b64 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -322,7 +322,7 @@ virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 static struct rte_memseg_list *
 virt2memseg_list(const void *addr)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	int msl_idx;
 
@@ -437,7 +437,7 @@ static int
 dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 		void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx, ms_idx, fd;
 	FILE *f = arg;
 
@@ -569,7 +569,7 @@ check_iova(const struct rte_memseg_list *msl __rte_unused,
 static int
 check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint64_t mask;
 	int ret;
 
@@ -632,7 +632,7 @@ RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask)
 void
 rte_mem_set_dma_mask(uint8_t maskbits)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	mcfg->dma_maskbits = mcfg->dma_maskbits == 0 ? maskbits :
 			     RTE_MIN(mcfg->dma_maskbits, maskbits);
@@ -642,29 +642,27 @@ rte_mem_set_dma_mask(uint8_t maskbits)
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
@@ -684,7 +682,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
 int
 rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -738,7 +736,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe)
 int
 rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -781,7 +779,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe)
 int
 rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -815,7 +813,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe)
 int
 rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -872,7 +870,7 @@ int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -929,7 +927,7 @@ int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int socket_id, n;
 	int ret = 0;
 
@@ -1049,7 +1047,7 @@ int
 rte_eal_memory_detach(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	size_t page_sz = rte_mem_page_size();
 	unsigned int i;
 
@@ -1101,7 +1099,7 @@ rte_eal_memory_detach(void)
 			EAL_LOG(ERR, "Could not unmap shared memory config: %s",
 					rte_strerror(rte_errno));
 	}
-	rte_eal_get_configuration()->mem_config = NULL;
+	eal_get_runtime_state()->mem_config = NULL;
 
 	return 0;
 }
@@ -1154,7 +1152,7 @@ static int
 handle_eal_heap_info_request(const char *cmd __rte_unused, const char *params,
 			     struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	struct malloc_heap *heap;
 	unsigned int heap_id;
@@ -1191,7 +1189,7 @@ handle_eal_heap_list_request(const char *cmd __rte_unused,
 				const char *params __rte_unused,
 				struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	unsigned int heap_id;
 
@@ -1213,7 +1211,7 @@ static int
 handle_eal_memzone_info_request(const char *cmd __rte_unused,
 				const char *params, struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl = NULL;
 	int ms_idx, ms_count = 0;
 	void *cur_addr, *mz_end;
@@ -1275,7 +1273,7 @@ static void
 memzone_list_cb(const struct rte_memzone *mz __rte_unused,
 		 void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_tel_data *d = arg;
 	int mz_idx;
 
@@ -1340,7 +1338,7 @@ handle_eal_memseg_lists_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
 		struct rte_memseg_list *msl = &mcfg->memsegs[i];
@@ -1376,7 +1374,7 @@ handle_eal_memseg_list_info_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0)
 		goto done;
@@ -1423,7 +1421,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0) {
 		rte_mcfg_mem_read_unlock();
@@ -1502,7 +1500,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	ms = rte_fbarray_get(&msl->memseg_arr, ms_idx);
 	if (ms == NULL) {
@@ -1580,7 +1578,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 
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
index dcf18ebf4c..448089d024 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1296,7 +1296,7 @@ enum mp_status {
 static bool
 set_mp_status(enum mp_status status)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint8_t expected;
 	uint8_t desired;
 
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index c581f43b6f..8f8a2d2417 100644
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
 		strlcpy(head->name, name, sizeof(head->name) - 1);
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
index e229f82c1e..47af403c27 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -19,6 +19,9 @@
 #include <rte_stdatomic.h>
 #include "eal_thread.h"
 
+/* Forward declaration — full definition is in eal_memcfg.h */
+struct rte_mem_config;
+
 #if defined(RTE_ARCH_ARM)
 #define MAX_HUGEPAGE_SIZES 4  /**< support up to 4 page sizes */
 #else
@@ -144,6 +147,7 @@ struct eal_runtime_state {
 	uint32_t main_lcore;          /**< ID of the main lcore */
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
+	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 60e2089797..8302a7c8e5 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -80,6 +80,9 @@ struct rte_mem_config {
 	size_t max_memzone; /**< Maximum number of allocated memzones. */
 };
 
+/* Return a pointer to the shared memory config */
+struct rte_mem_config *eal_get_mcfg(void);
+
 /* update internal config from shared mem config */
 void
 eal_mcfg_update_internal(void);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index a905632cbe..2bb5c6c402 100644
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
index 5271614e4a..98da77acc1 100644
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
index e925fa9743..cf0c5b7332 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -63,7 +63,7 @@ rte_eal_hugepage_init(void)
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* for debug purposes, hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -350,7 +350,7 @@ memseg_list_alloc(struct rte_memseg_list *msl)
 static int
 memseg_primary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, total_mem;
@@ -454,7 +454,7 @@ memseg_primary_init(void)
 static int
 memseg_secondary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 2ac2546391..04affc6a28 100644
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
index 5ae81429d9..035e5da08a 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -759,7 +759,7 @@ struct alloc_walk_param {
 static int
 alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct alloc_walk_param *wa = arg;
 	struct rte_memseg_list *cur_msl;
 	size_t page_sz;
@@ -893,7 +893,7 @@ struct free_walk_param {
 static int
 free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *found_msl;
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
@@ -1323,7 +1323,7 @@ sync_existing(struct rte_memseg_list *primary_msl,
 static int
 sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hi = NULL;
@@ -1376,7 +1376,7 @@ static int
 secondary_msl_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	char name[RTE_FBARRAY_NAME_LEN];
 	int msl_idx, ret;
@@ -1425,7 +1425,7 @@ static int
 secondary_msl_destroy_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *local_msl;
 	int msl_idx, ret;
 
@@ -1508,7 +1508,7 @@ static int
 fd_list_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int len;
 	int msl_idx;
 
@@ -1524,7 +1524,7 @@ fd_list_create_walk(const struct rte_memseg_list *msl,
 static int
 fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx;
 
 	if (msl->external)
@@ -1538,7 +1538,7 @@ fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 int
 eal_memalloc_set_seg_fd(int list_idx, int seg_idx, int fd)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single file segments mode doesn't support individual segment fd's */
@@ -1593,7 +1593,7 @@ eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->single_file_segments) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index c341e9a599..1bfea89021 100644
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
@@ -856,7 +856,7 @@ static int __rte_unused
 prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 {
 	const struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int cur_page, seg_start_page, end_seg, new_memseg;
 	unsigned int hpi_idx, socket, i;
 	int n_contig_segs, n_segs;
@@ -1154,7 +1154,7 @@ eal_legacy_hugepage_init(void)
 	memset(used_hp, 0, sizeof(used_hp));
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -1531,7 +1531,7 @@ getFileSize(int fd)
 static int
 eal_legacy_hugepage_attach(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct hugepage_file *hp = NULL;
 	unsigned int num_hp = 0;
 	unsigned int i = 0;
@@ -1702,7 +1702,7 @@ rte_eal_using_phys_addrs(void)
 static int __rte_unused
 memseg_primary_init_32(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int active_sockets, hpi_idx, msl_idx = 0;
 	unsigned int socket_id, i;
 	struct rte_memseg_list *msl;
@@ -1905,7 +1905,7 @@ memseg_primary_init(void)
 static int
 memseg_secondary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 72df9163f0..8de7d6d715 100644
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
2.51.0

