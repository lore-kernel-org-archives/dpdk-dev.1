Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF9CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:59:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E1D84066E;
	Wed, 29 Apr 2026 18:59:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B02594066A;
 Wed, 29 Apr 2026 18:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481939; x=1809017939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZwKeICNv5YCVjyt6YrsuQ1C5Rx67cA9vH9nS/7I4jw=;
 b=VWWMxXeP4hN7vfa/x/JbOCHx2NgCGNJkJGAKM/pyto1Sm0X1PyqJ8wEY
 ICPUIkEnaYcCpWWXj6Ayo6n88M845+tTRPkwfndRDS2pEA5uEKktD/8jM
 8XiLjFC/esd3SRQcO93ujHpIcYVIxXEN1a69rD7cE5dkZR/aDvpr/984w
 AAL1VQT8y+D8kNyoRurOO7eivCv1RKzIt10YLbaN08MKifCtf/BdJfodO
 KaPjYaNtEH8CBPqWVHPeONL8LWzxN7MWCGVsSHUe60HKJ5L1zGEMYLB9Q
 jfCDSwmK96iBSVA2aOM588SyzaOUeXyS6KucNIDJZC/uatMTRfI/K4moa A==;
X-CSE-ConnectionGUID: oOOZZqt9QGO+T3xef9RJMA==
X-CSE-MsgGUID: YIq2HAzGR2CW1o+VMnzDtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725290"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725290"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:58:57 -0700
X-CSE-ConnectionGUID: CKdI+zqTT7ihf68rXmLOwg==
X-CSE-MsgGUID: pfPWbYJAQLOWtMobhGICtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696914"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:58:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 02/44] eal: move memory request fields to user config
Date: Wed, 29 Apr 2026 17:57:54 +0100
Message-ID: <20260429165845.2136843-3-bruce.richardson@intel.com>
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

Move the basic memory request information supplied by the user from the
internal-config to the user config structure in EAL. For the number of
channels or ranks of memory, limit the data size to uint8_t rather than
having a full 32-bit value per entry.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 11 ++++++-----
 lib/eal/common/eal_common_memory.c  |  8 ++++----
 lib/eal/common/eal_common_options.c | 29 ++++++++++++++++++-----------
 lib/eal/common/eal_internal_cfg.h   |  8 ++++----
 lib/eal/freebsd/eal.c               |  7 ++++---
 lib/eal/freebsd/eal_memory.c        | 11 ++++++-----
 lib/eal/linux/eal.c                 |  5 +++--
 lib/eal/linux/eal_memory.c          | 12 ++++++------
 lib/eal/windows/eal.c               |  5 +++--
 lib/eal/windows/eal_memory.c        |  3 ++-
 10 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 8f51d6dd4a..5bd22f6ef0 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -376,7 +376,8 @@ eal_dynmem_calc_num_pages_per_socket(
 	uint64_t remaining_mem, cur_mem;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	uint64_t total_mem = internal_conf->memory;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	uint64_t total_mem = user_cfg->memory;
 
 	if (num_hp_info == 0)
 		return -1;
@@ -400,12 +401,12 @@ eal_dynmem_calc_num_pages_per_socket(
 		 * sockets according to number of cores from CPU mask present
 		 * on each socket.
 		 */
-		total_size = internal_conf->memory;
+		total_size = user_cfg->memory;
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
 				socket++) {
 
 			/* Set memory amount per socket */
-			default_size = internal_conf->memory *
+			default_size = user_cfg->memory *
 				cpu_per_socket[socket] / rte_lcore_count();
 
 			/* Limit to maximum available memory on socket */
@@ -436,7 +437,7 @@ eal_dynmem_calc_num_pages_per_socket(
 		/* in 32-bit mode, allocate all of the memory only on main
 		 * lcore socket
 		 */
-		total_size = internal_conf->memory;
+		total_size = user_cfg->memory;
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
 				socket++) {
 			struct rte_config *cfg = rte_eal_get_configuration();
@@ -520,7 +521,7 @@ eal_dynmem_calc_num_pages_per_socket(
 
 	/* if we didn't satisfy total memory requirements */
 	if (total_mem > 0) {
-		requested = internal_conf->memory / 0x100000;
+		requested = user_cfg->memory / 0x100000;
 		available = requested - (total_mem / 0x100000);
 		EAL_LOG(ERR, "Not enough memory available! Requested: %uMB, available: %uMB",
 			requested, available);
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index dccf9406c5..208e3583b0 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -662,15 +662,15 @@ static int
 rte_eal_memdevice_init(void)
 {
 	struct rte_config *config;
-	const struct internal_config *internal_conf;
+	const struct eal_user_cfg *user_cfg;
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		return 0;
 
-	internal_conf = eal_get_internal_configuration();
+	user_cfg = eal_get_user_configuration();
 	config = rte_eal_get_configuration();
-	config->mem_config->nchannel = internal_conf->force_nchannel;
-	config->mem_config->nrank = internal_conf->force_nrank;
+	config->mem_config->nchannel = user_cfg->force_nchannel;
+	config->mem_config->nrank = user_cfg->force_nrank;
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 290386dc63..11b77bc9dd 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -493,11 +493,12 @@ eal_get_hugefile_prefix(void)
 void
 eal_reset_internal_config(struct internal_config *internal_cfg)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
 
-	internal_cfg->memory = 0;
-	internal_cfg->force_nrank = 0;
-	internal_cfg->force_nchannel = 0;
+	user_cfg->memory = 0;
+	user_cfg->force_nrank = 0;
+	user_cfg->force_nchannel = 0;
 	internal_cfg->hugefile_prefix = NULL;
 	internal_cfg->hugepage_dir = NULL;
 	internal_cfg->hugepage_file.unlink_before_mapping = false;
@@ -1957,6 +1958,7 @@ int
 eal_parse_args(void)
 {
 	struct internal_config *int_cfg = eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
@@ -2095,23 +2097,27 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
-		int_cfg->memory *= 1024ULL;
-		int_cfg->memory *= 1024ULL;
+		user_cfg->memory = atoi(args.memory_size);
+		user_cfg->memory *= 1024ULL;
+		user_cfg->memory *= 1024ULL;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		int nchannel = atoi(args.memory_channels);
+
+		if (nchannel <= 0 || nchannel > UINT8_MAX) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		user_cfg->force_nchannel = (uint8_t)nchannel;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		int nrank = atoi(args.memory_ranks);
+
+		if (nrank <= 0 || nrank > 16 || nrank > UINT8_MAX) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		user_cfg->force_nrank = (uint8_t)nrank;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
@@ -2354,6 +2360,7 @@ eal_cleanup_config(struct internal_config *internal_cfg)
 int
 eal_adjust_config(struct internal_config *internal_cfg)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
 
 	if (internal_cfg->process_type == RTE_PROC_AUTO)
@@ -2364,7 +2371,7 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	/* if no memory amounts were requested, this will result in 0 and
 	 * will be overridden later, right after eal_hugepage_info_init() */
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		internal_cfg->memory += internal_cfg->numa_mem[i];
+		user_cfg->memory += internal_cfg->numa_mem[i];
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index fb4afca5b8..1625c697b2 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -13,6 +13,7 @@
 #include <rte_eal.h>
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
+#include <stdint.h>
 
 #include "eal_thread.h"
 
@@ -53,7 +54,9 @@ struct hugepage_file_discipline {
  * Immutable after initialization, so no need for atomic types or locks.
  */
 struct eal_user_cfg {
-	uint8_t reserved;
+	size_t memory;           /**< amount of asked memory */
+	uint8_t force_nchannel;  /**< force number of channels */
+	uint8_t force_nrank;     /**< force number of ranks */
 };
 
 /**
@@ -77,9 +80,6 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	volatile size_t memory;           /**< amount of asked memory */
-	volatile unsigned force_nchannel; /**< force number of channels */
-	volatile unsigned force_nrank;    /**< force number of ranks */
 	volatile unsigned no_hugetlbfs;   /**< true to disable hugetlbfs */
 	struct hugepage_file_discipline hugepage_file;
 	volatile unsigned no_pci;         /**< true to disable PCI */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 60f5e676a8..1779362686 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -415,6 +415,7 @@ rte_eal_init(int argc, char **argv)
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
@@ -587,11 +588,11 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
-	if (internal_conf->memory == 0 && internal_conf->force_numa == 0) {
+	if (user_cfg->memory == 0 && internal_conf->force_numa == 0) {
 		if (internal_conf->no_hugetlbfs)
-			internal_conf->memory = MEMSIZE_IF_NO_HUGE_PAGE;
+			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 		else
-			internal_conf->memory = eal_get_hugepage_mem_size();
+			user_cfg->memory = eal_get_hugepage_mem_size();
 	}
 
 	if (internal_conf->vmware_tsc_map == 1) {
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index cd608db9f9..a0a398ab55 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -70,11 +70,12 @@ rte_eal_hugepage_init(void)
 		struct rte_memseg_list *msl;
 		uint64_t mem_sz, page_sz;
 		int n_segs;
+		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 		/* create a memseg list */
 		msl = &mcfg->memsegs[0];
 
-		mem_sz = internal_conf->memory;
+		mem_sz = user_cfg->memory;
 		page_sz = RTE_PGSIZE_4K;
 		n_segs = mem_sz / page_sz;
 
@@ -109,7 +110,7 @@ rte_eal_hugepage_init(void)
 		hpi = &internal_conf->hugepage_info[i];
 		page_sz = hpi->hugepage_sz;
 		max_pages = hpi->num_pages[0];
-		mem_needed = RTE_ALIGN_CEIL(internal_conf->memory - total_mem,
+		mem_needed = RTE_ALIGN_CEIL(eal_get_user_configuration()->memory - total_mem,
 				page_sz);
 
 		n_pages = RTE_MIN(mem_needed / page_sz, max_pages);
@@ -229,14 +230,14 @@ rte_eal_hugepage_init(void)
 
 			total_mem += seg->len;
 		}
-		if (total_mem >= internal_conf->memory)
+		if (total_mem >= eal_get_user_configuration()->memory)
 			break;
 	}
-	if (total_mem < internal_conf->memory) {
+	if (total_mem < eal_get_user_configuration()->memory) {
 		EAL_LOG(ERR, "Couldn't reserve requested memory, "
 				"requested: %" PRIu64 "M "
 				"available: %" PRIu64 "M",
-				internal_conf->memory >> 20, total_mem >> 20);
+				eal_get_user_configuration()->memory >> 20, total_mem >> 20);
 		return -1;
 	}
 	return 0;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d848de03d8..a15e4dd598 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -577,6 +577,7 @@ rte_eal_init(int argc, char **argv)
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -750,9 +751,9 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
-	if (internal_conf->memory == 0 && internal_conf->force_numa == 0) {
+	if (user_cfg->memory == 0 && internal_conf->force_numa == 0) {
 		if (internal_conf->no_hugetlbfs)
-			internal_conf->memory = MEMSIZE_IF_NO_HUGE_PAGE;
+			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
 	if (internal_conf->vmware_tsc_map == 1) {
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index bf783e3c76..695596668f 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1182,7 +1182,7 @@ eal_legacy_hugepage_init(void)
 		/* create a memseg list */
 		msl = &mcfg->memsegs[0];
 
-		mem_sz = internal_conf->memory;
+		mem_sz = eal_get_user_configuration()->memory;
 		page_sz = RTE_PGSIZE_4K;
 		n_segs = mem_sz / page_sz;
 
@@ -1203,7 +1203,7 @@ eal_legacy_hugepage_init(void)
 			EAL_LOG(DEBUG, "Falling back to anonymous map");
 		} else {
 			/* we got an fd - now resize it */
-			if (ftruncate(memfd, internal_conf->memory) < 0) {
+			if (ftruncate(memfd, eal_get_user_configuration()->memory) < 0) {
 				EAL_LOG(ERR, "Cannot resize memfd: %s",
 						strerror(errno));
 				EAL_LOG(ERR, "Falling back to anonymous map");
@@ -1359,8 +1359,8 @@ eal_legacy_hugepage_init(void)
 
 	huge_recover_sigbus();
 
-	if (internal_conf->memory == 0 && internal_conf->force_numa == 0)
-		internal_conf->memory = eal_get_hugepage_mem_size();
+	if (eal_get_user_configuration()->memory == 0 && internal_conf->force_numa == 0)
+		eal_get_user_configuration()->memory = eal_get_hugepage_mem_size();
 
 	nr_hugefiles = nr_hugepages;
 
@@ -1758,7 +1758,7 @@ memseg_primary_init_32(void)
 			total_requested_mem += mem;
 		}
 	else
-		total_requested_mem = internal_conf->memory;
+		total_requested_mem = eal_get_user_configuration()->memory;
 
 	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
 	if (total_requested_mem > max_mem) {
@@ -1823,7 +1823,7 @@ memseg_primary_init_32(void)
 		/* max amount of memory on this socket */
 		max_socket_mem = (active_sockets != 0 ?
 					internal_conf->numa_mem[socket_id] :
-					internal_conf->memory) +
+					eal_get_user_configuration()->memory) +
 					extra_mem_per_socket;
 		cur_socket_mem = 0;
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index f06375a624..2e1cd88189 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -161,6 +161,7 @@ rte_eal_init(int argc, char **argv)
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 	int ret;
@@ -230,9 +231,9 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (internal_conf->memory == 0 && !internal_conf->force_numa) {
+	if (user_cfg->memory == 0 && !internal_conf->force_numa) {
 		if (internal_conf->no_hugetlbfs)
-			internal_conf->memory = MEMSIZE_IF_NO_HUGE_PAGE;
+			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
 	if (rte_eal_intr_init() < 0) {
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 9f85191016..caaa557694 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -680,13 +680,14 @@ eal_nohuge_init(void)
 	mcfg = rte_eal_get_configuration()->mem_config;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* nohuge mode is legacy mode */
 	internal_conf->legacy_mem = 1;
 
 	msl = &mcfg->memsegs[0];
 
-	mem_sz = internal_conf->memory;
+	mem_sz = user_cfg->memory;
 	page_sz = RTE_PGSIZE_4K;
 	n_segs = mem_sz / page_sz;
 
-- 
2.51.0

