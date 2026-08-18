Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AFDC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6B440698;
	Tue, 18 Aug 2026 15:33:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C64EA40663
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060027; x=1818596027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tC4rsobUS29oQP4HJ2Fj618q8q7RKSNw+b6YC/r9LGY=;
 b=KpZOVsSDROkyd2ujM47pISNmYCQp0ZJvdVpU8cZ7Uclh+W6k4ttXAohc
 uW2oI3B/54J+mb7VuoLQK9zs1wRDXguCPQeWO1b04b6/dqy+ryQ0d5HH5
 m4Aolb2SVENFAUjxLYnoOJxkse3o2W4w5wMCFJwr1Q3MVOo/ARTh8fRf8
 vmRW6db1LLtN0AY0TlZ4lHZSJESfIC6k/uyi7YJgOI2bJqPhBPqqH1GUD
 8cDY/6c6cXt6mLKmx8pVW0RJVF9YdUZQ5MTt4N58Y9mLC/q4NDYIM7Io8
 4/llQIMxk7k/u8mVikmhDhppaod6OBpUMh1E+pNMlfy4s+on4xz45Ci+q g==;
X-CSE-ConnectionGUID: HoPMfy8ARleq5gYV+z8CTQ==
X-CSE-MsgGUID: haqkQmJxS9aDgHCBowisvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757584"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:46 -0700
X-CSE-ConnectionGUID: 49f+AHOHRVeqrWeFw0kTeA==
X-CSE-MsgGUID: 8Gk36S0oTLGvAM8BrjSEbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736552"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 04/39] eal: move memory request fields to user config
Date: Tue, 18 Aug 2026 14:32:57 +0100
Message-ID: <20260818133334.2620165-5-bruce.richardson@intel.com>
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

Move the basic memory request information supplied by the user from the
internal-config to the user config structure in EAL. For the number of
channels or ranks of memory, limit the data size to uint8_t rather than
having a full 32-bit value per entry.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 11 ++++---
 lib/eal/common/eal_common_memory.c  |  8 ++---
 lib/eal/common/eal_common_options.c | 47 ++++++++++++++++++++++-------
 lib/eal/common/eal_internal_cfg.h   |  8 ++---
 lib/eal/freebsd/eal.c               |  7 +++--
 lib/eal/freebsd/eal_memory.c        | 11 ++++---
 lib/eal/linux/eal.c                 |  5 +--
 lib/eal/linux/eal_memory.c          | 12 ++++----
 lib/eal/windows/eal.c               |  5 +--
 lib/eal/windows/eal_memory.c        |  3 +-
 10 files changed, 74 insertions(+), 43 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 868d274dc0..4e991d4fb1 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -358,7 +358,8 @@ eal_dynmem_calc_num_pages_per_socket(
 	uint64_t remaining_mem, cur_mem;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
-	uint64_t total_mem = internal_conf->memory;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	uint64_t total_mem = user_cfg->memory;
 
 	if (num_hp_info == 0)
 		return -1;
@@ -382,12 +383,12 @@ eal_dynmem_calc_num_pages_per_socket(
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
@@ -418,7 +419,7 @@ eal_dynmem_calc_num_pages_per_socket(
 		/* in 32-bit mode, allocate all of the memory only on main
 		 * lcore socket
 		 */
-		total_size = internal_conf->memory;
+		total_size = user_cfg->memory;
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
 				socket++) {
 			struct rte_config *cfg = rte_eal_get_configuration();
@@ -502,7 +503,7 @@ eal_dynmem_calc_num_pages_per_socket(
 
 	/* if we didn't satisfy total memory requirements */
 	if (total_mem > 0) {
-		requested = internal_conf->memory / 0x100000;
+		requested = user_cfg->memory / 0x100000;
 		available = requested - (total_mem / 0x100000);
 		EAL_LOG(ERR, "Not enough memory available! Requested: %uMB, available: %uMB",
 			requested, available);
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 91724d0732..6ae1791bad 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -681,15 +681,15 @@ static int
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
index 42cdef632f..e0308aa460 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -509,11 +509,12 @@ eal_get_hugefile_prefix(void)
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
@@ -2072,6 +2073,7 @@ int
 eal_parse_args(void)
 {
 	struct internal_config *int_cfg = eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_config *rte_cfg = rte_eal_get_configuration();
 	bool remap_lcores = (args.remap_lcore_ids != NULL);
 	struct arg_list_elem *arg;
@@ -2210,23 +2212,45 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
-		int_cfg->memory *= 1024ULL;
-		int_cfg->memory *= 1024ULL;
+		char *end = NULL;
+		unsigned long long memory_mb;
+
+		errno = 0;
+		memory_mb = strtoull(args.memory_size, &end, 10);
+		if (errno != 0 || args.memory_size[0] == '\0' || end[0] != '\0' ||
+				memory_mb > SIZE_MAX / (1024ULL * 1024ULL)) {
+			EAL_LOG(ERR, "invalid memory size parameter");
+			return -1;
+		}
+		user_cfg->memory = (size_t)memory_mb * 1024ULL * 1024ULL;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		char *end = NULL;
+		unsigned long nchannel;
+
+		errno = 0;
+		nchannel = strtoul(args.memory_channels, &end, 10);
+
+		if (errno != 0 || args.memory_channels[0] == '\0' || end[0] != '\0' ||
+				nchannel == 0 || nchannel > UINT8_MAX) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		user_cfg->force_nchannel = (uint8_t)nchannel;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		char *end = NULL;
+		unsigned long nrank;
+
+		errno = 0;
+		nrank = strtoul(args.memory_ranks, &end, 10);
+
+		if (errno != 0 || args.memory_ranks[0] == '\0' || end[0] != '\0' ||
+				nrank == 0 || nrank > 16) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		user_cfg->force_nrank = (uint8_t)nrank;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
@@ -2475,6 +2499,7 @@ eal_cleanup_config(struct internal_config *internal_cfg)
 int
 eal_adjust_config(struct internal_config *internal_cfg)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	int i;
 
 	if (internal_cfg->process_type == RTE_PROC_AUTO)
@@ -2485,7 +2510,7 @@ eal_adjust_config(struct internal_config *internal_cfg)
 	/* if no memory amounts were requested, this will result in 0 and
 	 * will be overridden later, right after eal_hugepage_info_init() */
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
-		internal_cfg->memory += internal_cfg->numa_mem[i];
+		user_cfg->memory += internal_cfg->numa_mem[i];
 
 	return 0;
 }
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 66224e7c75..0cecb30cb2 100644
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
index 8b1ba5b99b..c348e9291a 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -415,6 +415,7 @@ rte_eal_init(int argc, char **argv)
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
 
@@ -593,11 +594,11 @@ rte_eal_init(int argc, char **argv)
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
index a239b83420..c85ff503ac 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -82,11 +82,12 @@ rte_eal_hugepage_init(void)
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
 
@@ -121,7 +122,7 @@ rte_eal_hugepage_init(void)
 		hpi = &internal_conf->hugepage_info[i];
 		page_sz = hpi->hugepage_sz;
 		max_pages = hpi->num_pages[0];
-		mem_needed = RTE_ALIGN_CEIL(internal_conf->memory - total_mem,
+		mem_needed = RTE_ALIGN_CEIL(eal_get_user_configuration()->memory - total_mem,
 				page_sz);
 
 		n_pages = RTE_MIN(mem_needed / page_sz, max_pages);
@@ -244,14 +245,14 @@ rte_eal_hugepage_init(void)
 
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
index fc2e9b8c0e..35ab3d5413 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -577,6 +577,7 @@ rte_eal_init(int argc, char **argv)
 	const struct rte_config *config = rte_eal_get_configuration();
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -756,9 +757,9 @@ rte_eal_init(int argc, char **argv)
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
index d9d505d865..1f369f5a9d 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1165,7 +1165,7 @@ eal_legacy_hugepage_init(void)
 		/* create a memseg list */
 		msl = &mcfg->memsegs[0];
 
-		mem_sz = internal_conf->memory;
+		mem_sz = eal_get_user_configuration()->memory;
 		page_sz = RTE_PGSIZE_4K;
 		n_segs = mem_sz / page_sz;
 
@@ -1186,7 +1186,7 @@ eal_legacy_hugepage_init(void)
 			EAL_LOG(DEBUG, "Falling back to anonymous map");
 		} else {
 			/* we got an fd - now resize it */
-			if (ftruncate(memfd, internal_conf->memory) < 0) {
+			if (ftruncate(memfd, eal_get_user_configuration()->memory) < 0) {
 				EAL_LOG(ERR, "Cannot resize memfd: %s",
 						strerror(errno));
 				EAL_LOG(ERR, "Falling back to anonymous map");
@@ -1342,8 +1342,8 @@ eal_legacy_hugepage_init(void)
 
 	huge_recover_sigbus();
 
-	if (internal_conf->memory == 0 && internal_conf->force_numa == 0)
-		internal_conf->memory = eal_get_hugepage_mem_size();
+	if (eal_get_user_configuration()->memory == 0 && internal_conf->force_numa == 0)
+		eal_get_user_configuration()->memory = eal_get_hugepage_mem_size();
 
 	nr_hugefiles = nr_hugepages;
 
@@ -1742,7 +1742,7 @@ memseg_primary_init_32(void)
 			total_requested_mem += mem;
 		}
 	else
-		total_requested_mem = internal_conf->memory;
+		total_requested_mem = eal_get_user_configuration()->memory;
 
 	if (total_requested_mem > mem32_max_mem) {
 		EAL_LOG(ERR, "Invalid parameters: 32-bit process can at most use %uM of memory",
@@ -1806,7 +1806,7 @@ memseg_primary_init_32(void)
 		/* max amount of memory on this socket */
 		max_socket_mem = (active_sockets != 0 ?
 					internal_conf->numa_mem[socket_id] :
-					internal_conf->memory) +
+					eal_get_user_configuration()->memory) +
 					extra_mem_per_socket;
 		cur_socket_mem = 0;
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 6dacae7235..cb44cbfc88 100644
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
@@ -236,9 +237,9 @@ rte_eal_init(int argc, char **argv)
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
2.53.0

