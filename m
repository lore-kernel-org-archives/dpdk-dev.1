Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2A606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y0axVUdM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F03B140B9D;
	Thu, 26 Nov 2026 19:15:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id D303440696
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716920; x=1827252920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9PNKIQjRYgOgvKBwpyRuDQsGhxrfYcVPWbL+Rc/lxhg=;
 b=Y0axVUdMjosYun7HT3UdZItE1wSekW1sO4oj349cRFDs2LcWviHPzOep
 /F5cwWvqlzHzJhqlffo7V1DP9AkCVc+FlOsAaSDVozhqJmeGvk2dH2kpN
 3UMidpfkRlog3e1UT4UZONkdwnYQBXg+o10m36VCxamA+QxpmZV2QgLxe
 NMX4/TrYRdndcdqFWMeKwANspzk2wNQzjNHgLOVED2Oyi7G/kuBZQU6y6
 bAxbCwoTBv13PlxP8fTSOUvwXmN3jTglmOrqKeDwFUsJiv689CA15/yHy
 6PZS5sGV/rqvow88rY7VFMOWWUVLqnguh4yMV5pkLdlHxqO/5jXN9Nmsn Q==;
X-CSE-ConnectionGUID: 8vbvWVtQSgaz/WFEOzZpEA==
X-CSE-MsgGUID: p8J5g48VR5+gcHmu2D2ilg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633615"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:18 -0800
X-CSE-ConnectionGUID: fEx98Zb2SZqoSqNo1hr21Q==
X-CSE-MsgGUID: wpeHpQHwRLq64rikrYemmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733088"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 23/39] eal: move memory config pointer to runtime state
 struct
Date: Thu, 26 Nov 2026 18:13:56 +0000
Message-ID: <20261126181414.124094-24-bruce.richardson@intel.com>
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
 lib/eal/common/eal_common_proc.c    |  4 +--
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
 22 files changed, 139 insertions(+), 132 deletions(-)

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
index e431ddf03d..f9b275dbeb 100644
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
index 5739939933..6f8dc34062 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -14,8 +14,7 @@
 void
 eal_mcfg_complete(void)
 {
-	struct rte_config *cfg = rte_eal_get_configuration();
-	struct rte_mem_config *mcfg = cfg->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* ALL shared mem_config related INIT DONE */
@@ -28,7 +27,7 @@ eal_mcfg_complete(void)
 void
 eal_mcfg_wait_complete(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	/* wait until shared mem_config finish initialising */
 	rte_wait_until_equal_32(&mcfg->magic, RTE_MAGIC, rte_memory_order_relaxed);
@@ -37,7 +36,7 @@ eal_mcfg_wait_complete(void)
 int
 eal_mcfg_check_version(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	/* check if version from memconfig matches compiled in macro */
 	if (mcfg->version != RTE_VERSION)
@@ -49,7 +48,7 @@ eal_mcfg_check_version(void)
 void
 eal_mcfg_update_internal(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	user_cfg->legacy_mem = mcfg->legacy_mem;
@@ -60,7 +59,7 @@ void
 eal_mcfg_update_from_internal(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	mcfg->legacy_mem = user_cfg->legacy_mem;
 	mcfg->single_file_segments = user_cfg->single_file_segments;
@@ -74,7 +73,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mem_get_lock)
 rte_rwlock_t *
 rte_mcfg_mem_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->memory_hotplug_lock;
+	return &eal_get_mcfg()->memory_hotplug_lock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_mem_read_lock)
@@ -109,7 +108,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_tailq_get_lock)
 rte_rwlock_t *
 rte_mcfg_tailq_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->qlock;
+	return &eal_get_mcfg()->qlock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_tailq_read_lock)
@@ -144,7 +143,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_mempool_get_lock)
 rte_rwlock_t *
 rte_mcfg_mempool_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->mplock;
+	return &eal_get_mcfg()->mplock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_mempool_read_lock)
@@ -179,7 +178,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_timer_get_lock)
 rte_spinlock_t *
 rte_mcfg_timer_get_lock(void)
 {
-	return &rte_eal_get_configuration()->mem_config->tlock;
+	return &eal_get_mcfg()->tlock;
 }
 
 RTE_EXPORT_SYMBOL(rte_mcfg_timer_lock)
@@ -200,13 +199,13 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_mcfg_ethdev_get_lock)
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
index 00b5600ff8..28649ddb9a 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -344,7 +344,7 @@ virt2memseg(const void *addr, const struct rte_memseg_list *msl)
 static struct rte_memseg_list *
 virt2memseg_list(const void *addr)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	int msl_idx;
 
@@ -461,7 +461,7 @@ static int
 dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 		void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx, ms_idx, fd;
 	FILE *f = arg;
 
@@ -593,7 +593,7 @@ check_iova(const struct rte_memseg_list *msl __rte_unused,
 static int
 check_dma_mask(uint8_t maskbits, bool thread_unsafe)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint64_t mask;
 	int ret;
 
@@ -656,7 +656,7 @@ RTE_EXPORT_SYMBOL(rte_mem_set_dma_mask)
 void
 rte_mem_set_dma_mask(uint8_t maskbits)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	mcfg->dma_maskbits = mcfg->dma_maskbits == 0 ? maskbits :
 			     RTE_MIN(mcfg->dma_maskbits, maskbits);
@@ -666,29 +666,27 @@ rte_mem_set_dma_mask(uint8_t maskbits)
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
@@ -714,7 +712,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_contig_walk_thread_unsafe)
 int
 rte_memseg_contig_walk_thread_unsafe(rte_memseg_contig_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -768,7 +766,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_walk_thread_unsafe)
 int
 rte_memseg_walk_thread_unsafe(rte_memseg_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ms_idx, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -811,7 +809,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_list_walk_thread_unsafe)
 int
 rte_memseg_list_walk_thread_unsafe(rte_memseg_list_walk_t func, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int i, ret = 0;
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
@@ -845,7 +843,7 @@ RTE_EXPORT_SYMBOL(rte_memseg_get_fd_thread_unsafe)
 int
 rte_memseg_get_fd_thread_unsafe(const struct rte_memseg *ms)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -902,7 +900,7 @@ int
 rte_memseg_get_fd_offset_thread_unsafe(const struct rte_memseg *ms,
 		size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int msl_idx, seg_idx, ret;
@@ -959,7 +957,7 @@ int
 rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int socket_id, n;
 	int ret = 0;
 
@@ -1079,7 +1077,7 @@ int
 rte_eal_memory_detach(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	size_t page_sz = rte_mem_page_size();
 	unsigned int i;
 
@@ -1131,7 +1129,7 @@ rte_eal_memory_detach(void)
 			EAL_LOG(ERR, "Could not unmap shared memory config: %s",
 					rte_strerror(rte_errno));
 	}
-	rte_eal_get_configuration()->mem_config = NULL;
+	eal_get_runtime_state()->mem_config = NULL;
 
 	return 0;
 }
@@ -1184,7 +1182,7 @@ static int
 handle_eal_heap_info_request(const char *cmd __rte_unused, const char *params,
 			     struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	struct malloc_heap *heap;
 	unsigned int heap_id;
@@ -1221,7 +1219,7 @@ handle_eal_heap_list_request(const char *cmd __rte_unused,
 				const char *params __rte_unused,
 				struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_malloc_socket_stats sock_stats;
 	unsigned int heap_id;
 
@@ -1243,7 +1241,7 @@ static int
 handle_eal_memzone_info_request(const char *cmd __rte_unused,
 				const char *params, struct rte_tel_data *d)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl = NULL;
 	int ms_idx, ms_count = 0;
 	void *cur_addr, *mz_end;
@@ -1305,7 +1303,7 @@ static void
 memzone_list_cb(const struct rte_memzone *mz __rte_unused,
 		 void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_tel_data *d = arg;
 	int mz_idx;
 
@@ -1370,7 +1368,7 @@ handle_eal_memseg_lists_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
 		struct rte_memseg_list *msl = &mcfg->memsegs[i];
@@ -1406,7 +1404,7 @@ handle_eal_memseg_list_info_request(const char *cmd __rte_unused,
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
 
 	rte_mcfg_mem_read_lock();
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0)
 		goto done;
@@ -1453,7 +1451,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	if (msl->memseg_arr.count == 0) {
 		rte_mcfg_mem_read_unlock();
@@ -1532,7 +1530,7 @@ handle_eal_element_list_request(const char *cmd __rte_unused,
 
 	rte_mcfg_mem_read_lock();
 
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 	msl = &mcfg->memsegs[ms_list_idx];
 	ms = rte_fbarray_get(&msl->memseg_arr, ms_idx);
 	if (ms == NULL) {
@@ -1609,7 +1607,7 @@ handle_eal_element_info_request(const char *cmd __rte_unused,
 
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
index 1e9a0c3115..26e7a59cd2 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1390,7 +1390,7 @@ enum mp_status {
 static bool
 set_mp_status(enum mp_status status)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint8_t expected;
 	uint8_t desired;
 
@@ -1419,7 +1419,7 @@ __rte_mp_enable(void)
 bool
 eal_mp_is_disabled(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 
 	return rte_atomic_load_explicit(&mcfg->mp_status,
 			rte_memory_order_relaxed) == MP_STATUS_DISABLED;
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
index 67ede70c62..b55bb21d63 100644
--- a/lib/eal/common/eal_common_timer.c
+++ b/lib/eal/common/eal_common_timer.c
@@ -55,7 +55,7 @@ estimate_tsc_freq(void)
 int
 init_tsc_freq(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	uint64_t freq;
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index ad232a5b30..550489829f 100644
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
@@ -160,6 +163,7 @@ struct eal_runtime_state {
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
index 50b8e1653b..c7c600fa13 100644
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
index 782514eb09..6714699828 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -92,7 +92,7 @@ eal_clean_runtime_dir(void)
 static int
 rte_eal_config_create(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
@@ -162,13 +162,13 @@ rte_eal_config_create(void)
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
 
@@ -178,7 +178,7 @@ rte_eal_config_attach(void)
 {
 	void *rte_mem_cfg_addr;
 	const char *pathname = eal_runtime_config_path();
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 
@@ -194,7 +194,7 @@ rte_eal_config_attach(void)
 		}
 	}
 
-	rte_mem_cfg_addr = mmap(NULL, sizeof(*config->mem_config),
+	rte_mem_cfg_addr = mmap(NULL, sizeof(*runtime_state->mem_config),
 				PROT_READ, MAP_SHARED, mem_cfg_fd, 0);
 	/* don't close the fd here, it will be closed on reattach */
 	if (rte_mem_cfg_addr == MAP_FAILED) {
@@ -205,7 +205,7 @@ rte_eal_config_attach(void)
 		return -1;
 	}
 
-	config->mem_config = rte_mem_cfg_addr;
+	runtime_state->mem_config = rte_mem_cfg_addr;
 
 	return 0;
 }
@@ -216,7 +216,7 @@ rte_eal_config_reattach(void)
 {
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->no_shconf)
@@ -224,10 +224,10 @@ rte_eal_config_reattach(void)
 
 	/* save the address primary process has mapped shared config to */
 	rte_mem_cfg_addr =
-			(void *)(uintptr_t)config->mem_config->mem_cfg_addr;
+			(void *)(uintptr_t)runtime_state->mem_config->mem_cfg_addr;
 
 	/* unmap original config */
-	munmap(config->mem_config, sizeof(struct rte_mem_config));
+	munmap(runtime_state->mem_config, sizeof(struct rte_mem_config));
 
 	/* remap the config at proper address */
 	mem_config = (struct rte_mem_config *) mmap(rte_mem_cfg_addr,
@@ -248,7 +248,7 @@ rte_eal_config_reattach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 98e4313f7a..2466987e03 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -75,7 +75,7 @@ rte_eal_hugepage_init(void)
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* for debug purposes, hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -352,7 +352,7 @@ memseg_list_alloc(struct rte_memseg_list *msl)
 static int
 memseg_primary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -416,7 +416,7 @@ memseg_primary_init(void)
 static int
 memseg_secondary_init(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b44097d9bf..2b02d984e9 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -170,9 +170,9 @@ eal_clean_runtime_dir(void)
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
@@ -240,14 +240,14 @@ rte_eal_config_create(void)
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
@@ -256,7 +256,7 @@ rte_eal_config_create(void)
 static int
 rte_eal_config_attach(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mem_config;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
@@ -285,7 +285,7 @@ rte_eal_config_attach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
@@ -294,7 +294,7 @@ rte_eal_config_attach(void)
 static int
 rte_eal_config_reattach(void)
 {
-	struct rte_config *config = rte_eal_get_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	struct rte_mem_config *mem_config;
 	void *rte_mem_cfg_addr;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
@@ -304,10 +304,10 @@ rte_eal_config_reattach(void)
 
 	/* save the address primary process has mapped shared config to */
 	rte_mem_cfg_addr =
-		(void *) (uintptr_t) config->mem_config->mem_cfg_addr;
+		(void *) (uintptr_t) runtime_state->mem_config->mem_cfg_addr;
 
 	/* unmap original config */
-	munmap(config->mem_config, sizeof(struct rte_mem_config));
+	munmap(runtime_state->mem_config, sizeof(struct rte_mem_config));
 
 	/* remap the config at proper address */
 	mem_config = (struct rte_mem_config *) mmap(rte_mem_cfg_addr,
@@ -330,7 +330,7 @@ rte_eal_config_reattach(void)
 		return -1;
 	}
 
-	config->mem_config = mem_config;
+	runtime_state->mem_config = mem_config;
 
 	return 0;
 }
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 38e5baec29..3e693d4705 100644
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
@@ -900,7 +900,7 @@ struct free_walk_param {
 static int
 free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *found_msl;
 	struct free_walk_param *wa = arg;
 	uintptr_t start_addr, end_addr;
@@ -1330,7 +1330,7 @@ sync_existing(struct rte_memseg_list *primary_msl,
 static int
 sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hi = NULL;
@@ -1383,7 +1383,7 @@ static int
 secondary_msl_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *primary_msl, *local_msl;
 	char name[RTE_FBARRAY_NAME_LEN];
 	int msl_idx, ret;
@@ -1432,7 +1432,7 @@ static int
 secondary_msl_destroy_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *local_msl;
 	int msl_idx, ret;
 
@@ -1515,7 +1515,7 @@ static int
 fd_list_create_walk(const struct rte_memseg_list *msl,
 		void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	unsigned int len;
 	int msl_idx;
 
@@ -1531,7 +1531,7 @@ fd_list_create_walk(const struct rte_memseg_list *msl,
 static int
 fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx;
 
 	if (msl->external)
@@ -1545,7 +1545,7 @@ fd_list_destroy_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 int
 eal_memalloc_set_seg_fd(int list_idx, int seg_idx, int fd)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single file segments mode doesn't support individual segment fd's */
@@ -1600,7 +1600,7 @@ eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->single_file_segments) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 3cd100ce56..41d0cf79c0 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -679,8 +679,8 @@ unmap_unneeded_hugepages(struct hugepage_file *hugepg_tbl,
 static int
 remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int cur_page, seg_len;
@@ -848,7 +848,7 @@ static int __rte_unused
 prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 {
 	const struct eal_platform_info *platform_info = eal_get_platform_info();
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int cur_page, seg_start_page, end_seg, new_memseg;
 	unsigned int hpi_idx, socket, i;
 	int n_contig_segs, n_segs;
@@ -1146,7 +1146,7 @@ eal_legacy_hugepage_init(void)
 	memset(used_hp, 0, sizeof(used_hp));
 
 	/* get pointer to global configuration */
-	mcfg = rte_eal_get_configuration()->mem_config;
+	mcfg = eal_get_mcfg();
 
 	/* hugetlbfs can be disabled */
 	if (user_cfg->no_hugetlbfs) {
@@ -1523,7 +1523,7 @@ getFileSize(int fd)
 static int
 eal_legacy_hugepage_attach(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	struct hugepage_file *hp = NULL;
 	unsigned int num_hp = 0;
 	unsigned int i = 0;
@@ -1696,7 +1696,7 @@ memseg_primary_init_32(void)
 {
 	/* limit total amount of memory on 32-bit */
 	const uint64_t mem32_max_mem = 2ULL << 30;
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int active_sockets, hpi_idx, msl_idx = 0;
 	unsigned int socket_id, i;
 	struct rte_memseg_list *msl;
@@ -1898,7 +1898,7 @@ memseg_primary_init(void)
 static int __rte_unused
 memseg_secondary_init_dynmem(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 	void *mem_va_addr;
@@ -1949,7 +1949,7 @@ memseg_secondary_init_dynmem(void)
 static int
 memseg_secondary_init_legacy(void)
 {
-	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	struct rte_mem_config *mcfg = eal_get_mcfg();
 	int msl_idx = 0;
 	struct rte_memseg_list *msl;
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 9ff6fbec7a..51b149828b 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -44,7 +44,7 @@ eal_proc_type_detect(void)
 {
 	enum rte_proc_type_t ptype = RTE_PROC_PRIMARY;
 	const char *pathname = eal_runtime_config_path();
-	const struct rte_config *config = rte_eal_get_configuration();
+	const struct rte_mem_config *config = eal_get_mcfg();
 
 	/* if we can open the file but not get a write-lock we are a secondary
 	 * process. NOTE: if we get a file handle back, we keep that open
@@ -54,14 +54,14 @@ eal_proc_type_detect(void)
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
index 0163162db2..b45002621b 100644
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
@@ -284,7 +284,7 @@ struct free_walk_param {
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
2.55.0

