Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC27DC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E116440B8F;
	Tue, 18 Aug 2026 15:33:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 563A640A6D
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060033; x=1818596033;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2baiJs7jCUjslibxlNbge/HCBI18aQ5uPt/MvHyScBY=;
 b=iDO/TMYL8zvEWBafwWfEkhhrLDH/ZJ6BHjaAbLkut5o6WTwMTtExhjF4
 3A/PtF+IrChFnpZzhf92RHzEzVM87jR3zniTeythLY+puEyEolObZo1F+
 J80CyoEtA8Q62tC8isUg75ZV2RgAjLGXChhjuQjU7f5Xl/WNkUEuEbhBF
 in384B5gCOHrYRdY1E8dMcvzADJpKeK3TFRKZwGzCZ8bgE1Ii8KzodhY9
 4PB7IiCnID92bYS0V0cgHx6osMMxs92B/pYifEqy93Tosg09IhOSpOHzl
 +GAcLMzYNK7uQTfHBvorP46KXvIAGh413HDkKPMeN6FZfu1Il9qP/2MVt Q==;
X-CSE-ConnectionGUID: OgpL3aD/QwGjRBsGmEwkng==
X-CSE-MsgGUID: PuMWK0LJSFuuldjVsdIMWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757622"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757622"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:52 -0700
X-CSE-ConnectionGUID: +YJ7BahXR+aBquqiB1MuLg==
X-CSE-MsgGUID: qAQkn+cwQvCw42UcMEcZTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736589"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 09/39] eal: move advanced user config options to user cfg
 struct
Date: Tue, 18 Aug 2026 14:33:02 +0100
Message-ID: <20260818133334.2620165-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818133334.2620165-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260818133334.2620165-1-bruce.richardson@intel.com>
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

Move the more advanced configuration options, such as for virtual base
addresses, vfio interrupt mode, etc., to the user configuration
structure, so that all user-provided config options are in a single
struct, which does not contain any other fields other than user config
options.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_bus.c      |  4 +-
 lib/eal/common/eal_common_config.c   |  6 +-
 lib/eal/common/eal_common_dynmem.c   |  2 +-
 lib/eal/common/eal_common_mcfg.c     | 14 ++---
 lib/eal/common/eal_common_memalloc.c |  5 +-
 lib/eal/common/eal_common_memory.c   | 36 +++++-------
 lib/eal/common/eal_common_options.c  | 88 +++++++++++++---------------
 lib/eal/common/eal_internal_cfg.h    | 33 ++++-------
 lib/eal/common/eal_options.h         |  3 +-
 lib/eal/common/malloc_elem.c         | 15 ++---
 lib/eal/common/malloc_heap.c         | 17 +++---
 lib/eal/freebsd/eal.c                | 15 ++---
 lib/eal/linux/eal.c                  | 26 ++++----
 lib/eal/linux/eal_hugepage_info.c    |  5 +-
 lib/eal/linux/eal_memalloc.c         | 63 ++++++++------------
 lib/eal/linux/eal_memory.c           | 41 ++++++-------
 lib/eal/windows/eal.c                |  7 +--
 lib/eal/windows/eal_memalloc.c       |  6 +-
 lib/eal/windows/eal_memory.c         |  6 +-
 19 files changed, 168 insertions(+), 224 deletions(-)

diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 067e7a8b67..1430a20ab7 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -345,12 +345,12 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_device_is_ignored)
 bool
 rte_bus_device_is_ignored(const struct rte_bus *bus, const char *dev_name)
 {
-	const struct internal_config *internal_conf = eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_devargs *devargs = rte_bus_find_devargs(bus, dev_name);
 	enum rte_bus_scan_mode scan_mode = bus->conf.scan_mode;
 
 	if (scan_mode == RTE_BUS_SCAN_UNDEFINED) {
-		if (internal_conf->no_auto_probing != 0)
+		if (user_cfg->no_auto_probing)
 			scan_mode = RTE_BUS_SCAN_ALLOWLIST;
 		else
 			scan_mode = RTE_BUS_SCAN_BLOCKLIST;
diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 5efc6623d6..50cba4fa1a 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -106,8 +106,8 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_get_baseaddr)
 uint64_t
 rte_eal_get_baseaddr(void)
 {
-	return (internal_config.base_virtaddr != 0) ?
-		       (uint64_t) internal_config.base_virtaddr :
+	return (eal_user_cfg.base_virtaddr != 0) ?
+		       (uint64_t) eal_user_cfg.base_virtaddr :
 		       eal_get_baseaddr();
 }
 
@@ -123,7 +123,7 @@ RTE_EXPORT_SYMBOL(rte_eal_mbuf_user_pool_ops)
 const char *
 rte_eal_mbuf_user_pool_ops(void)
 {
-	return internal_config.user_mbuf_pool_ops_name;
+	return eal_user_cfg.user_mbuf_pool_ops_name;
 }
 
 /* return non-zero if hugepages are enabled. */
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index e48466c272..6c830d302f 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -83,7 +83,7 @@ eal_dynmem_memseg_lists_init(void)
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
 			/* we can still sort pages by socket in legacy mode */
-			if (!internal_conf->legacy_mem && socket_id > 0)
+			if (!user_cfg->legacy_mem && socket_id > 0)
 				break;
 #endif
 			memtypes[cur_type].page_sz = hugepage_sz;
diff --git a/lib/eal/common/eal_common_mcfg.c b/lib/eal/common/eal_common_mcfg.c
index 84ee3f3959..fddeae255e 100644
--- a/lib/eal/common/eal_common_mcfg.c
+++ b/lib/eal/common/eal_common_mcfg.c
@@ -50,22 +50,20 @@ void
 eal_mcfg_update_internal(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	internal_conf->legacy_mem = mcfg->legacy_mem;
-	internal_conf->single_file_segments = mcfg->single_file_segments;
+	user_cfg->legacy_mem = mcfg->legacy_mem;
+	user_cfg->single_file_segments = mcfg->single_file_segments;
 }
 
 void
 eal_mcfg_update_from_internal(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	mcfg->legacy_mem = internal_conf->legacy_mem;
-	mcfg->single_file_segments = internal_conf->single_file_segments;
+	mcfg->legacy_mem = user_cfg->legacy_mem;
+	mcfg->single_file_segments = user_cfg->single_file_segments;
 	/* record current DPDK version */
 	mcfg->version = RTE_VERSION;
 }
diff --git a/lib/eal/common/eal_common_memalloc.c b/lib/eal/common/eal_common_memalloc.c
index 47e782f395..e3eadf0237 100644
--- a/lib/eal/common/eal_common_memalloc.c
+++ b/lib/eal/common/eal_common_memalloc.c
@@ -72,15 +72,14 @@ eal_memalloc_is_contig(const struct rte_memseg_list *msl, void *start,
 	void *end, *aligned_start, *aligned_end;
 	size_t pgsz = (size_t)msl->page_sz;
 	const struct rte_memseg *ms;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* for IOVA_VA, it's always contiguous */
 	if (rte_eal_iova_mode() == RTE_IOVA_VA && !msl->external)
 		return true;
 
 	/* for legacy memory, it's always contiguous */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return true;
 
 	end = RTE_PTR_ADD(start, len);
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 2466f672ef..a7d8debebe 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -53,8 +53,7 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
 	uint64_t map_sz;
 	void *mapped_addr, *aligned_addr;
 	uint8_t try = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (system_page_sz == 0)
 		system_page_sz = rte_mem_page_size();
@@ -65,12 +64,12 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
 	allow_shrink = (flags & EAL_VIRTUAL_AREA_ALLOW_SHRINK) > 0;
 	unmap = (flags & EAL_VIRTUAL_AREA_UNMAP) > 0;
 
-	if (next_baseaddr == NULL && internal_conf->base_virtaddr != 0 &&
+	if (next_baseaddr == NULL && user_cfg->base_virtaddr != 0 &&
 			rte_eal_process_type() == RTE_PROC_PRIMARY)
-		next_baseaddr = (void *) internal_conf->base_virtaddr;
+		next_baseaddr = (void *) user_cfg->base_virtaddr;
 
 #ifdef RTE_ARCH_64
-	if (next_baseaddr == NULL && internal_conf->base_virtaddr == 0 &&
+	if (next_baseaddr == NULL && user_cfg->base_virtaddr == 0 &&
 			rte_eal_process_type() == RTE_PROC_PRIMARY)
 		next_baseaddr = (void *) eal_get_baseaddr();
 #endif
@@ -151,7 +150,7 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
 		 * demote this warning to debug if we did not explicitly request
 		 * a base virtual address.
 		 */
-		if (internal_conf->base_virtaddr != 0) {
+		if (user_cfg->base_virtaddr != 0) {
 			EAL_LOG(WARNING, "WARNING! Base virtual address hint (%p != %p) not respected!",
 				requested_addr, aligned_addr);
 			EAL_LOG(WARNING, "   This may cause issues with mapping memory into secondary processes");
@@ -404,8 +403,7 @@ void *
 rte_mem_iova2virt(rte_iova_t iova)
 {
 	struct virtiova vi;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	memset(&vi, 0, sizeof(vi));
 
@@ -413,7 +411,7 @@ rte_mem_iova2virt(rte_iova_t iova)
 	/* for legacy mem, we can get away with scanning VA-contiguous segments,
 	 * as we know they are PA-contiguous as well
 	 */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		rte_memseg_contig_walk(find_virt_legacy, &vi);
 	else
 		rte_memseg_walk(find_virt, &vi);
@@ -497,11 +495,10 @@ int
 rte_mem_event_callback_register(const char *name, rte_mem_event_callback_t clb,
 		void *arg)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* FreeBSD boots with legacy mem enabled by default */
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		EAL_LOG(DEBUG, "Registering mem event callbacks not supported");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -513,11 +510,10 @@ RTE_EXPORT_SYMBOL(rte_mem_event_callback_unregister)
 int
 rte_mem_event_callback_unregister(const char *name, void *arg)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* FreeBSD boots with legacy mem enabled by default */
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		EAL_LOG(DEBUG, "Registering mem event callbacks not supported");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -530,11 +526,10 @@ int
 rte_mem_alloc_validator_register(const char *name,
 		rte_mem_alloc_validator_t clb, int socket_id, size_t limit)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* FreeBSD boots with legacy mem enabled by default */
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		EAL_LOG(DEBUG, "Registering mem alloc validators not supported");
 		rte_errno = ENOTSUP;
 		return -1;
@@ -547,11 +542,10 @@ RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_unregister)
 int
 rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* FreeBSD boots with legacy mem enabled by default */
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		EAL_LOG(DEBUG, "Registering mem alloc validators not supported");
 		rte_errno = ENOTSUP;
 		return -1;
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b6a5b3ea8b..8dd10340e9 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -541,14 +541,14 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 				sizeof(internal_cfg->hugepage_info[0]));
 		internal_cfg->hugepage_info[i].lock_descriptor = -1;
 	}
-	internal_cfg->base_virtaddr = 0;
+	user_cfg->base_virtaddr = 0;
 
 	/* if set to NONE, interrupt mode is determined automatically */
-	internal_cfg->vfio_intr_mode = RTE_INTR_MODE_NONE;
-	memset(internal_cfg->vfio_vf_token, 0,
-			sizeof(internal_cfg->vfio_vf_token));
+	user_cfg->vfio_intr_mode = RTE_INTR_MODE_NONE;
+	memset(user_cfg->vfio_vf_token, 0,
+			sizeof(user_cfg->vfio_vf_token));
 
-	internal_cfg->no_auto_probing = 0;
+	user_cfg->no_auto_probing = false;
 
 #ifdef RTE_LIBEAL_USE_HPET
 	user_cfg->no_hpet = false;
@@ -560,12 +560,12 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->in_memory = false;
 	user_cfg->create_uio_dev = false;
 	user_cfg->no_telemetry = false;
-	internal_cfg->iova_mode = RTE_IOVA_DC;
-	internal_cfg->user_mbuf_pool_ops_name = NULL;
+	user_cfg->iova_mode = RTE_IOVA_DC;
+	user_cfg->user_mbuf_pool_ops_name = NULL;
 	CPU_ZERO(&internal_cfg->ctrl_cpuset);
 	internal_cfg->init_complete = 0;
-	internal_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
-	internal_cfg->max_simd_bitwidth.forced = 0;
+	user_cfg->max_simd_bitwidth.bitwidth = RTE_VECT_DEFAULT_SIMD_BITWIDTH;
+	user_cfg->max_simd_bitwidth.forced = 0;
 }
 
 static int
@@ -1633,8 +1633,7 @@ static int
 eal_parse_iova_mode(const char *name)
 {
 	int mode;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (name == NULL)
 		return -1;
@@ -1646,7 +1645,7 @@ eal_parse_iova_mode(const char *name)
 	else
 		return -1;
 
-	internal_conf->iova_mode = mode;
+	user_cfg->iova_mode = mode;
 	return 0;
 }
 
@@ -1656,8 +1655,7 @@ eal_parse_simd_bitwidth(const char *arg)
 	char *end;
 	unsigned long bitwidth;
 	int ret;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (arg == NULL || arg[0] == '\0')
 		return -1;
@@ -1674,7 +1672,7 @@ eal_parse_simd_bitwidth(const char *arg)
 	ret = rte_vect_set_max_simd_bitwidth(bitwidth);
 	if (ret < 0)
 		return -1;
-	internal_conf->max_simd_bitwidth.forced = 1;
+	user_cfg->max_simd_bitwidth.forced = 1;
 	return 0;
 }
 
@@ -1683,8 +1681,7 @@ eal_parse_base_virtaddr(const char *arg)
 {
 	char *end;
 	uint64_t addr;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	errno = 0;
 	addr = strtoull(arg, &end, 16);
@@ -1704,7 +1701,7 @@ eal_parse_base_virtaddr(const char *arg)
 	 * it can align to 2MB for x86. So this alignment can also be used
 	 * on x86 and other architectures.
 	 */
-	internal_conf->base_virtaddr =
+	user_cfg->base_virtaddr =
 		RTE_PTR_ALIGN_CEIL((uintptr_t)addr, (size_t)RTE_PGSIZE_16M);
 
 	return 0;
@@ -1999,8 +1996,7 @@ eal_parse_pagesz_mem(char *strval, struct eal_user_cfg *user_cfg)
 static int
 eal_parse_vfio_intr(const char *mode)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	static struct {
 		const char *name;
 		enum rte_intr_mode value;
@@ -2012,7 +2008,7 @@ eal_parse_vfio_intr(const char *mode)
 
 	for (size_t i = 0; i < RTE_DIM(map); i++) {
 		if (!strcmp(mode, map[i].name)) {
-			internal_conf->vfio_intr_mode = map[i].value;
+			user_cfg->vfio_intr_mode = map[i].value;
 			return 0;
 		}
 	}
@@ -2022,11 +2018,11 @@ eal_parse_vfio_intr(const char *mode)
 static int
 eal_parse_vfio_vf_token(const char *vf_token)
 {
-	struct internal_config *cfg = eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_uuid_t uuid;
 
 	if (!rte_uuid_parse(vf_token, uuid)) {
-		rte_uuid_copy(cfg->vfio_vf_token, uuid);
+		rte_uuid_copy(user_cfg->vfio_vf_token, uuid);
 		return 0;
 	}
 
@@ -2040,7 +2036,7 @@ eal_parse_huge_worker_stack(const char *arg)
 	EAL_LOG(WARNING, "Cannot set worker stack size on Windows, parameter ignored");
 	RTE_SET_USED(arg);
 #else
-	struct internal_config *cfg = eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (arg == NULL || arg[0] == '\0') {
 		pthread_attr_t attr;
@@ -2050,7 +2046,7 @@ eal_parse_huge_worker_stack(const char *arg)
 			EAL_LOG(ERR, "Could not retrieve default stack size");
 			return -1;
 		}
-		ret = pthread_attr_getstacksize(&attr, &cfg->huge_worker_stack_size);
+		ret = pthread_attr_getstacksize(&attr, &user_cfg->huge_worker_stack_size);
 		pthread_attr_destroy(&attr);
 		if (ret != 0) {
 			EAL_LOG(ERR, "Could not retrieve default stack size");
@@ -2066,11 +2062,11 @@ eal_parse_huge_worker_stack(const char *arg)
 				stack_size >= (size_t)-1 / 1024)
 			return -1;
 
-		cfg->huge_worker_stack_size = stack_size * 1024;
+		user_cfg->huge_worker_stack_size = stack_size * 1024;
 	}
 
 	EAL_LOG(DEBUG, "Each worker thread will use %zu kB of DPDK memory as stack",
-		cfg->huge_worker_stack_size / 1024);
+		user_cfg->huge_worker_stack_size / 1024);
 #endif
 	return 0;
 }
@@ -2104,7 +2100,7 @@ eal_parse_args(void)
 	}
 
 	if (args.no_auto_probing)
-		int_cfg->no_auto_probing = 1;
+		user_cfg->no_auto_probing = true;
 
 	/* device -a/-b/-vdev options*/
 	TAILQ_FOREACH(arg, &args.allow, next)
@@ -2262,7 +2258,7 @@ eal_parse_args(void)
 	if (args.no_huge) {
 		user_cfg->no_hugetlbfs = true;
 		/* no-huge is legacy mem */
-		int_cfg->legacy_mem = true;
+		user_cfg->legacy_mem = true;
 	}
 	if (args.in_memory) {
 		user_cfg->in_memory = true;
@@ -2271,12 +2267,12 @@ eal_parse_args(void)
 		user_cfg->hugepage_file.unlink_before_mapping = true;
 	}
 	if (args.legacy_mem) {
-		int_cfg->legacy_mem = true;
+		user_cfg->legacy_mem = true;
 		if (args.memory_size == NULL && args.numa_mem == NULL)
 			EAL_LOG(NOTICE, "Static memory layout is selected, amount of reserved memory can be adjusted with -m or --socket-mem");
 	}
 	if (args.single_file_segments)
-		int_cfg->single_file_segments = true;
+		user_cfg->single_file_segments = true;
 	if (args.huge_dir != NULL) {
 		if (strlen(args.huge_dir) < 1) {
 			EAL_LOG(ERR, "Invalid hugepage dir parameter");
@@ -2383,7 +2379,7 @@ eal_parse_args(void)
 	if (args.no_telemetry)
 		user_cfg->no_telemetry = true;
 	if (args.match_allocations)
-		int_cfg->match_allocations = true;
+		user_cfg->match_allocations = true;
 	if (args.create_uio_dev)
 		user_cfg->create_uio_dev = true;
 
@@ -2429,13 +2425,13 @@ eal_parse_args(void)
 		}
 	}
 	if (args.mbuf_pool_ops_name != NULL) {
-		free(int_cfg->user_mbuf_pool_ops_name); /* free old ops name */
-		int_cfg->user_mbuf_pool_ops_name = strdup(args.mbuf_pool_ops_name);
-		if (int_cfg->user_mbuf_pool_ops_name == NULL) {
+		free(user_cfg->user_mbuf_pool_ops_name); /* free old ops name */
+		user_cfg->user_mbuf_pool_ops_name = strdup(args.mbuf_pool_ops_name);
+		if (user_cfg->user_mbuf_pool_ops_name == NULL) {
 			EAL_LOG(ERR, "failed to allocate memory for mbuf pool ops name parameter");
 			return -1;
 		}
-		if (strlen(int_cfg->user_mbuf_pool_ops_name) < 1) {
+		if (strlen(user_cfg->user_mbuf_pool_ops_name) < 1) {
 			EAL_LOG(ERR, "Invalid mbuf pool ops name parameter");
 			return -1;
 		}
@@ -2494,11 +2490,11 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 }
 
 int
-eal_cleanup_config(struct internal_config *internal_cfg)
+eal_cleanup_config(const struct eal_user_cfg *user_cfg)
 {
-	free(eal_get_user_configuration()->hugefile_prefix);
-	free(eal_get_user_configuration()->hugepage_dir);
-	free(internal_cfg->user_mbuf_pool_ops_name);
+	free(user_cfg->hugefile_prefix);
+	free(user_cfg->hugepage_dir);
+	free(user_cfg->user_mbuf_pool_ops_name);
 
 	return 0;
 }
@@ -2554,18 +2550,16 @@ RTE_EXPORT_SYMBOL(rte_vect_get_max_simd_bitwidth)
 uint16_t
 rte_vect_get_max_simd_bitwidth(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	return internal_conf->max_simd_bitwidth.bitwidth;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	return user_cfg->max_simd_bitwidth.bitwidth;
 }
 
 RTE_EXPORT_SYMBOL(rte_vect_set_max_simd_bitwidth)
 int
 rte_vect_set_max_simd_bitwidth(uint16_t bitwidth)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	if (internal_conf->max_simd_bitwidth.forced) {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	if (user_cfg->max_simd_bitwidth.forced) {
 		EAL_LOG(NOTICE, "Cannot set max SIMD bitwidth - user runtime override enabled");
 		return -EPERM;
 	}
@@ -2574,6 +2568,6 @@ rte_vect_set_max_simd_bitwidth(uint16_t bitwidth)
 		EAL_LOG(ERR, "Invalid bitwidth value!");
 		return -EINVAL;
 	}
-	internal_conf->max_simd_bitwidth.bitwidth = bitwidth;
+	user_cfg->max_simd_bitwidth.bitwidth = bitwidth;
 	return 0;
 }
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index cef5164e99..87f992d15f 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -56,7 +56,12 @@ struct hugepage_file_discipline {
  */
 struct eal_user_cfg {
 	size_t memory;           /**< amount of asked memory */
+	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
+	enum rte_intr_mode vfio_intr_mode; /**< default interrupt mode for VFIO */
+	enum rte_iova_mode iova_mode; /**< requested IOVA mode */
+	struct simd_bitwidth max_simd_bitwidth; /**< max simd bitwidth path to use */
+	rte_uuid_t vfio_vf_token; /**< shared VF token for VFIO-PCI bound PF and VFs */
 	uint8_t force_nchannel;  /**< force number of channels */
 	uint8_t force_nrank;     /**< force number of ranks */
 	bool force_numa;         /**< true to request memory on specific NUMA nodes */
@@ -69,9 +74,15 @@ struct eal_user_cfg {
 	bool in_memory;          /**< true to run with no shared runtime files */
 	bool create_uio_dev;     /**< true to create /dev/uioX devices */
 	bool no_telemetry;       /**< true to disable telemetry */
+	bool legacy_mem;         /**< true to enable legacy memory behavior */
+	bool match_allocations;  /**< true to free hugepages exactly as allocated */
+	bool no_auto_probing;    /**< true to switch from block-listing to allow-listing */
+	bool single_file_segments; /**< true if storing all pages within single files */
 	struct hugepage_file_discipline hugepage_file;
 	char *hugefile_prefix;   /**< the base filename of hugetlbfs files */
 	char *hugepage_dir;      /**< specific hugetlbfs directory to use */
+	char *user_mbuf_pool_ops_name; /**< user defined mbuf pool ops name */
+	uintptr_t base_virtaddr; /**< base address to try and reserve memory from */
 	uint64_t numa_mem[RTE_MAX_NUMA_NODES];    /**< amount of memory per NUMA node */
 	uint64_t numa_limit[RTE_MAX_NUMA_NODES];  /**< limit amount of memory per NUMA node */
 	/** storage for user-specified pagesz-mem overrides */
@@ -104,33 +115,11 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	uintptr_t base_virtaddr;          /**< base address to try and reserve memory from */
-	volatile unsigned legacy_mem;
-	/**< true to enable legacy memory behavior (no dynamic allocation,
-	 * IOVA-contiguous segments).
-	 */
-	volatile unsigned match_allocations;
-	/**< true to free hugepages exactly as allocated */
-	volatile unsigned single_file_segments;
-	/**< true if storing all pages within single files (per-page-size,
-	 * per-node) non-legacy mode only.
-	 */
-	/** default interrupt mode for VFIO */
-	volatile enum rte_intr_mode vfio_intr_mode;
-	/** the shared VF token for VFIO-PCI bound PF and VFs devices */
-	rte_uuid_t vfio_vf_token;
-	char *user_mbuf_pool_ops_name;
-			/**< user defined mbuf pool ops name */
 	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
-	enum rte_iova_mode iova_mode ;    /**< Set IOVA mode on this system  */
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
-	struct simd_bitwidth max_simd_bitwidth;
-	/**< max simd bitwidth path to use */
-	size_t huge_worker_stack_size; /**< worker thread stack size */
-	unsigned int no_auto_probing; /**< true to switch from block-listing to allow-listing */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 82cc8be8db..0c5132de6a 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -8,13 +8,14 @@
 #include "getopt.h"
 
 struct rte_tel_data;
+struct eal_user_cfg;
 
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg);
 int eal_adjust_config(struct internal_config *internal_cfg);
-int eal_cleanup_config(struct internal_config *internal_cfg);
+int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
diff --git a/lib/eal/common/malloc_elem.c b/lib/eal/common/malloc_elem.c
index 452b119c20..7a10a66779 100644
--- a/lib/eal/common/malloc_elem.c
+++ b/lib/eal/common/malloc_elem.c
@@ -37,8 +37,7 @@ malloc_elem_find_max_iova_contig(struct malloc_elem *elem, size_t align)
 	rte_iova_t expected_iova;
 	struct rte_memseg *ms;
 	size_t page_sz, cur, max;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	page_sz = (size_t)elem->msl->page_sz;
 	data_start = RTE_PTR_ADD(elem, MALLOC_ELEM_HEADER_LEN);
@@ -57,7 +56,7 @@ malloc_elem_find_max_iova_contig(struct malloc_elem *elem, size_t align)
 	 */
 	if (!elem->msl->external &&
 			(rte_eal_iova_mode() == RTE_IOVA_VA ||
-				(internal_conf->legacy_mem &&
+				(user_cfg->legacy_mem &&
 					rte_eal_has_hugepages())))
 		return RTE_PTR_DIFF(data_end, contig_seg_start);
 
@@ -338,24 +337,22 @@ remove_elem(struct malloc_elem *elem)
 static int
 next_elem_is_adjacent(struct malloc_elem *elem)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	return elem->next == RTE_PTR_ADD(elem, elem->size) &&
 			elem->next->msl == elem->msl &&
-			(!internal_conf->match_allocations ||
+			(!user_cfg->match_allocations ||
 			 elem->orig_elem == elem->next->orig_elem);
 }
 
 static int
 prev_elem_is_adjacent(struct malloc_elem *elem)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	return elem == RTE_PTR_ADD(elem->prev, elem->prev->size) &&
 			elem->prev->msl == elem->msl &&
-			(!internal_conf->match_allocations ||
+			(!user_cfg->match_allocations ||
 			 elem->orig_elem == elem->prev->orig_elem);
 }
 
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 77f364158a..bd25496275 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -647,15 +647,14 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 	unsigned int size_flags = flags & ~RTE_MEMZONE_SIZE_HINT_ONLY;
 	int socket_id;
 	void *ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	rte_spinlock_lock(&(heap->lock));
 
 	align = align == 0 ? 1 : align;
 
 	/* for legacy mode, try once and with all flags */
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		ret = heap_alloc(heap, size, flags, align, bound, contig);
 		goto alloc_unlock;
 	}
@@ -865,8 +864,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	unsigned int i, n_segs, before_space, after_space;
 	int ret;
 	bool unmapped = false;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (!malloc_elem_cookies_ok(elem) || elem->state != ELEM_BUSY)
 		return -1;
@@ -894,7 +892,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	/* ...of which we can't avail if we are in legacy mode, or if this is an
 	 * externally allocated segment.
 	 */
-	if (internal_conf->legacy_mem || (msl->external > 0))
+	if (user_cfg->legacy_mem || (msl->external > 0))
 		goto free_unlock;
 
 	/* check if we can free any memory back to the system */
@@ -905,7 +903,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	 * we will defer freeing these hugepages until the entire original allocation
 	 * can be freed
 	 */
-	if (internal_conf->match_allocations && elem->size != elem->orig_size)
+	if (user_cfg->match_allocations && elem->size != elem->orig_size)
 		goto free_unlock;
 
 	/* probably, but let's make sure, as we may not be using up full page */
@@ -1401,10 +1399,9 @@ rte_eal_malloc_heap_init(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	unsigned int i;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->match_allocations)
+	if (user_cfg->match_allocations)
 		EAL_LOG(DEBUG, "Hugepages will be freed exactly as allocated.");
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 3fc61c98a0..ae29e1b10a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -97,8 +97,6 @@ static int
 rte_eal_config_create(void)
 {
 	struct rte_config *config = rte_eal_get_configuration();
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	size_t page_sz = rte_mem_page_size();
 	size_t cfg_len = sizeof(struct rte_mem_config);
@@ -112,9 +110,9 @@ rte_eal_config_create(void)
 		return 0;
 
 	/* map the config before base address so that we don't waste a page */
-	if (internal_conf->base_virtaddr != 0)
+	if (user_cfg->base_virtaddr != 0)
 		rte_mem_cfg_addr = (void *)
-			RTE_ALIGN_FLOOR(internal_conf->base_virtaddr -
+			RTE_ALIGN_FLOOR(user_cfg->base_virtaddr -
 			sizeof(struct rte_mem_config), page_sz);
 	else
 		rte_mem_cfg_addr = NULL;
@@ -472,7 +470,7 @@ rte_eal_init(int argc, char **argv)
 	}
 
 	/* FreeBSD always uses legacy memory model */
-	internal_conf->legacy_mem = true;
+	user_cfg->legacy_mem = true;
 	if (user_cfg->in_memory) {
 		EAL_LOG(WARNING, "Warning: ignoring unsupported flag, '--in-memory'");
 		user_cfg->in_memory = false;
@@ -538,7 +536,7 @@ rte_eal_init(int argc, char **argv)
 	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
 	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
 
-	iova_mode = internal_conf->iova_mode;
+	iova_mode = user_cfg->iova_mode;
 	if (iova_mode == RTE_IOVA_DC) {
 		EAL_LOG(DEBUG, "Specific IOVA mode is not requested, autodetecting");
 		if (has_phys_addr) {
@@ -781,8 +779,7 @@ rte_eal_cleanup(void)
 		return -1;
 	}
 
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_service_finalize();
 	eal_bus_cleanup();
 	rte_mp_channel_cleanup();
@@ -791,7 +788,7 @@ rte_eal_cleanup(void)
 	eal_trace_fini();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
-	eal_cleanup_config(internal_conf);
+	eal_cleanup_config(user_cfg);
 	eal_lcore_var_cleanup();
 	return 0;
 }
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 32f1b5a028..c2e6fabd89 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -182,8 +182,6 @@ rte_eal_config_create(void)
 	size_t cfg_len_aligned = RTE_ALIGN(cfg_len, page_sz);
 	void *rte_mem_cfg_addr, *mapped_mem_cfg_addr;
 	int retval;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	const char *pathname = eal_runtime_config_path();
@@ -192,9 +190,9 @@ rte_eal_config_create(void)
 		return 0;
 
 	/* map the config before hugepage address so that we don't waste a page */
-	if (internal_conf->base_virtaddr != 0)
+	if (user_cfg->base_virtaddr != 0)
 		rte_mem_cfg_addr = (void *)
-			RTE_ALIGN_FLOOR(internal_conf->base_virtaddr -
+			RTE_ALIGN_FLOOR(user_cfg->base_virtaddr -
 			sizeof(struct rte_mem_config), page_sz);
 	else
 		rte_mem_cfg_addr = NULL;
@@ -522,8 +520,9 @@ eal_worker_thread_create(unsigned int lcore_id)
 	pthread_attr_t attr;
 	size_t stack_size;
 	int ret = -1;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	stack_size = eal_get_internal_configuration()->huge_worker_stack_size;
+	stack_size = user_cfg->huge_worker_stack_size;
 	if (stack_size != 0) {
 		/* Allocate NUMA aware stack memory and set pthread attributes */
 		stack_ptr = rte_zmalloc_socket("lcore_stack", stack_size,
@@ -687,7 +686,7 @@ rte_eal_init(int argc, char **argv)
 	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
 
 	/* if no EAL option "--iova-mode=<pa|va>", use bus IOVA scheme */
-	if (internal_conf->iova_mode == RTE_IOVA_DC) {
+	if (user_cfg->iova_mode == RTE_IOVA_DC) {
 		/* autodetect the IOVA mapping mode */
 		enum rte_iova_mode iova_mode = bus_iova_mode;
 
@@ -718,7 +717,7 @@ rte_eal_init(int argc, char **argv)
 		rte_eal_get_configuration()->iova_mode = iova_mode;
 	} else {
 		rte_eal_get_configuration()->iova_mode =
-			internal_conf->iova_mode;
+			user_cfg->iova_mode;
 	}
 
 	if (rte_eal_iova_mode() == RTE_IOVA_PA && !phys_addrs) {
@@ -975,8 +974,6 @@ rte_eal_cleanup(void)
 	/* if we're in a primary process, we need to mark hugepages as freeable
 	 * so that finalization can release them back to the system.
 	 */
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
@@ -994,7 +991,7 @@ rte_eal_cleanup(void)
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
 	rte_eal_malloc_heap_cleanup();
-	eal_cleanup_config(internal_conf);
+	eal_cleanup_config(user_cfg);
 	eal_lcore_var_cleanup();
 	rte_eal_log_cleanup();
 	return 0;
@@ -1012,19 +1009,18 @@ RTE_EXPORT_SYMBOL(rte_eal_vfio_intr_mode)
 enum rte_intr_mode
 rte_eal_vfio_intr_mode(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	return internal_conf->vfio_intr_mode;
+	return user_cfg->vfio_intr_mode;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_vfio_get_vf_token)
 void
 rte_eal_vfio_get_vf_token(rte_uuid_t vf_token)
 {
-	struct internal_config *cfg = eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	rte_uuid_copy(vf_token, cfg->vfio_vf_token);
+	rte_uuid_copy(vf_token, user_cfg->vfio_vf_token);
 }
 
 int
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 44dafa5292..74c55327ff 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -401,8 +401,7 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 {
 	uint64_t total_pages = 0;
 	unsigned int i;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/*
 	 * first, try to put all hugepages into relevant sockets, but
@@ -418,7 +417,7 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 	 * This could be determined by mapping,
 	 * but it is precisely what hugepage file reuse is trying to avoid.
 	 */
-	if (!internal_conf->legacy_mem && reusable_pages == 0)
+	if (!user_cfg->legacy_mem && reusable_pages == 0)
 		for (i = 0; i < rte_socket_count(); i++) {
 			int socket = rte_socket_id_by_idx(i);
 			unsigned int num_pages =
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 2a9be968a9..143e7287a7 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -222,10 +222,9 @@ get_seg_memfd(struct hugepage_info *hi __rte_unused,
 	char segname[250]; /* as per manpage, limit is 249 bytes plus null */
 
 	int flags = MFD_HUGETLB | pagesz_flags(hi->hugepage_sz);
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		fd = fd_list[list_idx].memseg_list_fd;
 
 		if (fd < 0) {
@@ -266,8 +265,6 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	const char *huge_path;
 	struct stat st;
 	int ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (dirty != NULL)
@@ -279,7 +276,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	if (user_cfg->in_memory)
 		return get_seg_memfd(hi, list_idx, seg_idx);
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		out_fd = &fd_list[list_idx].memseg_list_fd;
 		huge_path = eal_get_hugefile_path(path, buflen, hi->hugedir, list_idx);
 	} else {
@@ -323,7 +320,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	 * When multiple hugepages are mapped from the same file,
 	 * whether they will be dirty depends on the part that is mapped.
 	 */
-	if (!internal_conf->single_file_segments &&
+	if (!user_cfg->single_file_segments &&
 			user_cfg->hugepage_file.unlink_existing &&
 			rte_eal_process_type() == RTE_PROC_PRIMARY &&
 			ret == 0) {
@@ -513,8 +510,6 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	size_t alloc_sz;
 	int flags;
 	void *new_addr;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	alloc_sz = hi->hugepage_sz;
@@ -535,7 +530,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 		return -1;
 	}
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		map_offset = seg_idx * alloc_sz;
 		ret = resize_hugefile(fd, map_offset, alloc_sz, true, &dirty);
 		if (ret < 0)
@@ -666,14 +661,14 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 		EAL_LOG(CRIT, "Can't mmap holes in our virtual address space");
 	}
 	/* roll back the ref count */
-	if (internal_conf->single_file_segments)
+	if (user_cfg->single_file_segments)
 		fd_list[list_idx].count--;
 resized:
 	/* some codepaths will return negative fd, so exit early */
 	if (fd < 0)
 		return -1;
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		resize_hugefile(fd, map_offset, alloc_sz, false, NULL);
 		/* ignore failure, can't make it any worse */
 
@@ -699,8 +694,6 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 	uint64_t map_offset;
 	char path[PATH_MAX];
 	int fd, ret = 0;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* erase page data */
@@ -723,7 +716,7 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 	if (fd < 0)
 		return -1;
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		map_offset = seg_idx * ms->len;
 		if (resize_hugefile(fd, map_offset, ms->len, false, NULL))
 			return -1;
@@ -975,11 +968,12 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 	struct hugepage_info *hi = NULL;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	memset(&wa, 0, sizeof(wa));
 
 	/* dynamic allocation not supported in legacy mode */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return -1;
 
 	for (i = 0; i < (int) RTE_DIM(internal_conf->hugepage_info); i++) {
@@ -1044,9 +1038,10 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 	int seg, ret = 0;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* dynamic free not supported in legacy mode */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return -1;
 
 	for (seg = 0; seg < n_segs; seg++) {
@@ -1095,10 +1090,10 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 int
 eal_memalloc_free_seg(struct rte_memseg *ms)
 {
-	const struct internal_config *internal_conf = eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* dynamic free not supported in legacy mode */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return -1;
 
 	return eal_memalloc_free_seg_bulk(&ms, 1);
@@ -1461,11 +1456,10 @@ alloc_list(int list_idx, int len)
 {
 	int *data;
 	int i;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single-file segments mode does not need fd list */
-	if (!internal_conf->single_file_segments) {
+	if (!user_cfg->single_file_segments) {
 		/* ensure we have space to store fd per each possible segment */
 		data = malloc(sizeof(int) * len);
 		if (data == NULL) {
@@ -1491,11 +1485,10 @@ alloc_list(int list_idx, int len)
 static int
 destroy_list(int list_idx)
 {
-	const struct internal_config *internal_conf =
-			eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single-file segments mode does not need fd list */
-	if (!internal_conf->single_file_segments) {
+	if (!user_cfg->single_file_segments) {
 		int *fds = fd_list[list_idx].fds;
 		int i;
 		/* go through each fd and ensure it's closed */
@@ -1551,11 +1544,10 @@ int
 eal_memalloc_set_seg_fd(int list_idx, int seg_idx, int fd)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* single file segments mode doesn't support individual segment fd's */
-	if (internal_conf->single_file_segments)
+	if (user_cfg->single_file_segments)
 		return -ENOTSUP;
 
 	/* if list is not allocated, allocate it */
@@ -1573,11 +1565,10 @@ eal_memalloc_set_seg_fd(int list_idx, int seg_idx, int fd)
 int
 eal_memalloc_set_seg_list_fd(int list_idx, int fd)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* non-single file segment mode doesn't support segment list fd's */
-	if (!internal_conf->single_file_segments)
+	if (!user_cfg->single_file_segments)
 		return -ENOTSUP;
 
 	fd_list[list_idx].memseg_list_fd = fd;
@@ -1589,10 +1580,9 @@ int
 eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 {
 	int fd;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		fd = fd_list[list_idx].memseg_list_fd;
 	} else if (fd_list[list_idx].len == 0) {
 		/* list not initialized */
@@ -1609,10 +1599,9 @@ int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->single_file_segments) {
+	if (user_cfg->single_file_segments) {
 		size_t pgsz = mcfg->memsegs[list_idx].page_sz;
 
 		/* segment not active? */
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index a45be4a56a..ad787572d3 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -690,10 +690,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	uint64_t page_sz;
 	size_t memseg_len;
 	int socket_id;
-#ifndef RTE_ARCH_64
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-#endif
+
 	page_sz = hugepages[seg_start].size;
 	socket_id = hugepages[seg_start].socket_id;
 	seg_len = seg_end - seg_start;
@@ -786,7 +783,8 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		/* we have a new address, so unmap previous one */
 #ifndef RTE_ARCH_64
 		/* in 32-bit legacy mode, we have already unmapped the page */
-		if (!internal_conf->legacy_mem)
+		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+		if (!user_cfg->legacy_mem)
 			munmap(hfile->orig_va, page_sz);
 #else
 		munmap(hfile->orig_va, page_sz);
@@ -1132,7 +1130,7 @@ eal_legacy_hugepage_init(void)
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	uint64_t memory[RTE_MAX_NUMA_NODES];
 
@@ -1156,10 +1154,10 @@ eal_legacy_hugepage_init(void)
 		uint64_t page_sz;
 
 		/* nohuge mode is legacy mode */
-		internal_conf->legacy_mem = 1;
+		user_cfg->legacy_mem = 1;
 
 		/* nohuge mode is single-file segments mode */
-		internal_conf->single_file_segments = 1;
+		user_cfg->single_file_segments = 1;
 
 		/* create a memseg list */
 		msl = &mcfg->memsegs[0];
@@ -1428,7 +1426,7 @@ eal_legacy_hugepage_init(void)
 
 #ifndef RTE_ARCH_64
 	/* for legacy 32-bit mode, we did not preallocate VA space, so do it */
-	if (internal_conf->legacy_mem &&
+	if (user_cfg->legacy_mem &&
 			prealloc_segments(hugepage, nr_hugefiles)) {
 		EAL_LOG(ERR, "Could not preallocate VA space for hugepages");
 		goto fail;
@@ -1656,10 +1654,9 @@ eal_hugepage_attach(void)
 int
 rte_eal_hugepage_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	return internal_conf->legacy_mem ?
+	return user_cfg->legacy_mem ?
 			eal_legacy_hugepage_init() :
 			eal_dynmem_hugepage_init();
 }
@@ -1667,10 +1664,9 @@ rte_eal_hugepage_init(void)
 int
 rte_eal_hugepage_attach(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	return internal_conf->legacy_mem ?
+	return user_cfg->legacy_mem ?
 			eal_legacy_hugepage_attach() :
 			eal_hugepage_attach();
 }
@@ -1720,7 +1716,7 @@ memseg_primary_init_32(void)
 	 * unneeded pages. this will not affect secondary processes, as those
 	 * should be able to mmap the space without (too many) problems.
 	 */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return 0;
 
 	/* 32-bit mode is a very special case. we cannot know in advance where
@@ -1785,7 +1781,7 @@ memseg_primary_init_32(void)
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
 		/* we can still sort pages by socket in legacy mode */
-		if (!internal_conf->legacy_mem && socket_id > 0)
+		if (!user_cfg->legacy_mem && socket_id > 0)
 			break;
 #endif
 
@@ -1982,11 +1978,10 @@ static int
 memseg_secondary_init(void)
 {
 #ifdef RTE_ARCH_64
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* for 32-bit dynmem init is same as legacy */
-	if (!internal_conf->legacy_mem)
+	if (!user_cfg->legacy_mem)
 		return memseg_secondary_init_dynmem();
 #endif
 
@@ -2000,8 +1995,8 @@ rte_eal_memseg_init(void)
 	struct rlimit lim;
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg =
+		eal_get_user_configuration();
 #endif
 	if (getrlimit(RLIMIT_NOFILE, &lim) == 0) {
 		/* set limit to maximum */
@@ -2019,7 +2014,7 @@ rte_eal_memseg_init(void)
 		EAL_LOG(ERR, "Cannot get current resource limits");
 	}
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
-	if (!internal_conf->legacy_mem && rte_socket_count() > 1) {
+	if (!user_cfg->legacy_mem && rte_socket_count() > 1) {
 		EAL_LOG(WARNING, "DPDK is running on a NUMA system, but is compiled without NUMA support.");
 		EAL_LOG(WARNING, "This will have adverse consequences for performance and usability.");
 		EAL_LOG(WARNING, "Please use --legacy-mem option, or recompile with NUMA support.");
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index c062d29446..7504a4ac92 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -139,15 +139,14 @@ RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	eal_intr_thread_cancel();
 	eal_mem_virt2iova_cleanup();
 	eal_bus_cleanup();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
-	eal_cleanup_config(internal_conf);
+	eal_cleanup_config(user_cfg);
 	eal_lcore_var_cleanup();
 	return 0;
 }
@@ -277,7 +276,7 @@ rte_eal_init(int argc, char **argv)
 	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
 	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
 
-	iova_mode = internal_conf->iova_mode;
+	iova_mode = user_cfg->iova_mode;
 	if (iova_mode == RTE_IOVA_DC) {
 		EAL_LOG(DEBUG, "Specific IOVA mode is not requested, autodetecting");
 		if (has_phys_addr) {
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 5db5a474cc..26d9cae54c 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -316,8 +316,9 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	struct hugepage_info *hi = NULL;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->legacy_mem) {
+	if (user_cfg->legacy_mem) {
 		EAL_LOG(ERR, "dynamic allocation not supported in legacy mode");
 		return -ENOTSUP;
 	}
@@ -369,9 +370,10 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 	int seg, ret = 0;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* dynamic free not supported in legacy mode */
-	if (internal_conf->legacy_mem)
+	if (user_cfg->legacy_mem)
 		return -1;
 
 	for (seg = 0; seg < n_segs; seg++) {
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 3140d7b9c3..8fcd636a3a 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -678,12 +678,10 @@ eal_nohuge_init(void)
 	void *addr;
 
 	mcfg = rte_eal_get_configuration()->mem_config;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* nohuge mode is legacy mode */
-	internal_conf->legacy_mem = 1;
+	user_cfg->legacy_mem = 1;
 
 	msl = &mcfg->memsegs[0];
 
-- 
2.53.0

