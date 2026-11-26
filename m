Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA8606A32D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KGPp5HRU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBBBC40655;
	Thu, 26 Nov 2026 19:14:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id DC9E940430
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716866; x=1827252866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CI1dA1LHbt7pMz2wP6XKZjM08UM8Y0KHsol2twIWNiI=;
 b=KGPp5HRUisEvUl7pqAx/QDC4fW2yT9wnVdw+BacE4JuYOX84ckT99Mgf
 lCh9InzQgsZRPKoMb6WW6HcDPK1w1ZdNxUN+/Rp75nLHpAhpn7XGHzvxK
 zffpd0H5qOfJQyBXpGEqBS8b8K0xjxKkc+cTQG28ka1HRF+RuoyVI4vnP
 zYmSE4fEL4BWFNFnEp4l/+k7hW+MjWvHZIWRrhZCLmtmFcLm+DAoMyofR
 x1+apiOXVxgLLdx/Zqc7aQrGHeAzQrtrczvU7BREF6jkpQ5SPPQUIRQ0S
 mBk4Gc9qbvx9yJLC/W3HOCe0K6iNvAmJAh/Bz+rX+9lq19+tkToCpgHtb A==;
X-CSE-ConnectionGUID: HeTlCr6VQS6qzbBocayZFw==
X-CSE-MsgGUID: Djj7ofgmSsunLGAJWHQXhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633547"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633547"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:14:24 -0800
X-CSE-ConnectionGUID: ATWnJDm0RkmjwhXYVTi/uQ==
X-CSE-MsgGUID: 8PDIFTe4Ry+QVKqdQNqTvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12732857"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:14:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 06/39] eal: move hugepage policy fields to user config
Date: Thu, 26 Nov 2026 18:13:39 +0000
Message-ID: <20261126181414.124094-7-bruce.richardson@intel.com>
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

Continue moving fields from the internal config to the user config, in
this case the hugepage policy fields. As with previous fields, any flags
are adjusted from unsigned to boolean.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_config.c  |  2 +-
 lib/eal/common/eal_common_dynmem.c  |  3 ++-
 lib/eal/common/eal_common_options.c | 39 +++++++++++++++--------------
 lib/eal/common/eal_internal_cfg.h   |  9 ++++---
 lib/eal/freebsd/eal.c               |  6 ++---
 lib/eal/freebsd/eal_memory.c        |  9 ++++---
 lib/eal/linux/eal.c                 |  7 +++---
 lib/eal/linux/eal_hugepage_info.c   | 12 ++++-----
 lib/eal/linux/eal_memalloc.c        | 25 ++++++++++--------
 lib/eal/linux/eal_memory.c          | 13 +++++-----
 lib/eal/windows/eal.c               |  6 ++---
 lib/eal/windows/eal_memory.c        |  5 ++--
 12 files changed, 71 insertions(+), 65 deletions(-)

diff --git a/lib/eal/common/eal_common_config.c b/lib/eal/common/eal_common_config.c
index 5427b30659..4ebf938f31 100644
--- a/lib/eal/common/eal_common_config.c
+++ b/lib/eal/common/eal_common_config.c
@@ -131,7 +131,7 @@ RTE_EXPORT_SYMBOL(rte_eal_has_hugepages)
 int
 rte_eal_has_hugepages(void)
 {
-	return !internal_config.no_hugetlbfs;
+	return !eal_user_cfg.no_hugetlbfs;
 }
 
 RTE_EXPORT_SYMBOL(rte_eal_has_pci)
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index a5652ebd5f..97f8a05b30 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -36,9 +36,10 @@ eal_dynmem_memseg_lists_init(void)
 	void *mem_va_addr = NULL;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
-	if (internal_conf->no_hugetlbfs)
+	if (user_cfg->no_hugetlbfs)
 		return 0;
 
 	/*
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 57c2bfc180..133175c068 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2014 6WIND S.A.
  */
 
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <pthread.h>
@@ -498,11 +499,10 @@ eal_option_device_parse(void)
 const char *
 eal_get_hugefile_prefix(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	if (internal_conf->hugefile_prefix != NULL)
-		return internal_conf->hugefile_prefix;
+	if (user_cfg->hugefile_prefix != NULL)
+		return user_cfg->hugefile_prefix;
 	return HUGEFILE_PREFIX_DEFAULT;
 }
 
@@ -521,10 +521,11 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->force_numa_limits = false;
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
 		user_cfg->numa_limit[i] = 0;
-	internal_cfg->hugefile_prefix = NULL;
-	internal_cfg->hugepage_dir = NULL;
-	internal_cfg->hugepage_file.unlink_before_mapping = false;
-	internal_cfg->hugepage_file.unlink_existing = true;
+	user_cfg->no_hugetlbfs = false;
+	user_cfg->hugefile_prefix = NULL;
+	user_cfg->hugepage_dir = NULL;
+	user_cfg->hugepage_file.unlink_before_mapping = false;
+	user_cfg->hugepage_file.unlink_existing = true;
 	/* zero out hugedir descriptors */
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
 		memset(&internal_cfg->hugepage_info[i], 0,
@@ -2250,7 +2251,7 @@ eal_parse_args(void)
 		user_cfg->force_nrank = (uint8_t)nrank;
 	}
 	if (args.no_huge) {
-		int_cfg->no_hugetlbfs = 1;
+		user_cfg->no_hugetlbfs = true;
 		/* no-huge is legacy mem */
 		int_cfg->legacy_mem = 1;
 	}
@@ -2258,7 +2259,7 @@ eal_parse_args(void)
 		int_cfg->in_memory = 1;
 		/* in-memory is a superset of noshconf and huge-unlink */
 		int_cfg->no_shconf = 1;
-		int_cfg->hugepage_file.unlink_before_mapping = true;
+		user_cfg->hugepage_file.unlink_before_mapping = true;
 	}
 	if (args.legacy_mem) {
 		int_cfg->legacy_mem = 1;
@@ -2272,9 +2273,9 @@ eal_parse_args(void)
 			EAL_LOG(ERR, "Invalid hugepage dir parameter");
 			return -1;
 		}
-		free(int_cfg->hugepage_dir);  /* free old hugepage dir */
-		int_cfg->hugepage_dir = strdup(args.huge_dir);
-		if (int_cfg->hugepage_dir == NULL) {
+		free(user_cfg->hugepage_dir);  /* free old hugepage dir */
+		user_cfg->hugepage_dir = strdup(args.huge_dir);
+		if (user_cfg->hugepage_dir == NULL) {
 			EAL_LOG(ERR, "failed to allocate memory for hugepage dir parameter");
 			return -1;
 		}
@@ -2288,9 +2289,9 @@ eal_parse_args(void)
 			EAL_LOG(ERR, "Invalid char, '%%', in file_prefix parameter");
 			return -1;
 		}
-		free(int_cfg->hugefile_prefix);  /* free old file prefix */
-		int_cfg->hugefile_prefix = strdup(args.file_prefix);
-		if (int_cfg->hugefile_prefix == NULL) {
+		free(user_cfg->hugefile_prefix);  /* free old file prefix */
+		user_cfg->hugefile_prefix = strdup(args.file_prefix);
+		if (user_cfg->hugefile_prefix == NULL) {
 			EAL_LOG(ERR, "failed to allocate memory for file prefix parameter");
 			return -1;
 		}
@@ -2298,7 +2299,7 @@ eal_parse_args(void)
 	if (args.huge_unlink != NULL) {
 		if (args.huge_unlink == (void *)1)
 			args.huge_unlink = NULL;
-		if (eal_parse_huge_unlink(args.huge_unlink, &int_cfg->hugepage_file) < 0) {
+		if (eal_parse_huge_unlink(args.huge_unlink, &user_cfg->hugepage_file) < 0) {
 			EAL_LOG(ERR, "invalid huge-unlink parameter");
 			return -1;
 		}
@@ -2486,8 +2487,8 @@ compute_ctrl_threads_cpuset(struct internal_config *internal_cfg)
 int
 eal_cleanup_config(struct internal_config *internal_cfg)
 {
-	free(internal_cfg->hugefile_prefix);
-	free(internal_cfg->hugepage_dir);
+	free(eal_get_user_configuration()->hugefile_prefix);
+	free(eal_get_user_configuration()->hugepage_dir);
 	free(internal_cfg->user_mbuf_pool_ops_name);
 
 	return 0;
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index fe67bb95e1..bf7d6792d2 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -14,6 +14,7 @@
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
 #include <stdint.h>
+#include <stdbool.h>
 
 #include "eal_thread.h"
 
@@ -65,6 +66,10 @@ struct eal_user_cfg {
 	uint8_t force_nrank;     /**< force number of ranks */
 	bool force_numa;         /**< true to request memory on specific NUMA nodes */
 	bool force_numa_limits;  /**< true to apply per-NUMA memory limits */
+	bool no_hugetlbfs;       /**< true to disable hugetlbfs */
+	struct hugepage_file_discipline hugepage_file;
+	char *hugefile_prefix;   /**< the base filename of hugetlbfs files */
+	char *hugepage_dir;      /**< specific hugetlbfs directory to use */
 	uint64_t numa_mem[RTE_MAX_NUMA_NODES];    /**< amount of memory per NUMA node */
 	uint64_t numa_limit[RTE_MAX_NUMA_NODES];  /**< limit amount of memory per NUMA node */
 };
@@ -90,8 +95,6 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	volatile unsigned no_hugetlbfs;   /**< true to disable hugetlbfs */
-	struct hugepage_file_discipline hugepage_file;
 	volatile unsigned no_pci;         /**< true to disable PCI */
 	volatile unsigned no_hpet;        /**< true to disable HPET */
 	volatile unsigned vmware_tsc_map; /**< true to use VMware TSC mapping
@@ -118,8 +121,6 @@ struct internal_config {
 	volatile enum rte_intr_mode vfio_intr_mode;
 	/** the shared VF token for VFIO-PCI bound PF and VFs devices */
 	rte_uuid_t vfio_vf_token;
-	char *hugefile_prefix;      /**< the base filename of hugetlbfs files */
-	char *hugepage_dir;         /**< specific hugetlbfs directory to use */
 	char *user_mbuf_pool_ops_name;
 			/**< user defined mbuf pool ops name */
 	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 9e027405ca..500135e5ac 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -535,7 +535,7 @@ rte_eal_init(int argc, char **argv)
 	 * If contigmem is inaccessible, rte_eal_hugepage_init() will fail
 	 * with a message describing the cause.
 	 */
-	has_phys_addr = internal_conf->no_hugetlbfs == 0;
+	has_phys_addr = !user_cfg->no_hugetlbfs;
 
 	/* Always call rte_bus_get_iommu_class() to trigger DMA mask detection and validation */
 	enum rte_iova_mode bus_iova_mode = rte_bus_get_iommu_class();
@@ -575,7 +575,7 @@ rte_eal_init(int argc, char **argv)
 	EAL_LOG(INFO, "Selected IOVA mode '%s'",
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
-	if (internal_conf->no_hugetlbfs == 0) {
+	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
 		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
 			eal_hugepage_info_init() :
@@ -594,7 +594,7 @@ rte_eal_init(int argc, char **argv)
 	}
 
 	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
-		if (internal_conf->no_hugetlbfs)
+		if (user_cfg->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 		else
 			user_cfg->memory = eal_get_hugepage_mem_size();
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index f65089a521..01bec37f3c 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -73,16 +73,16 @@ rte_eal_hugepage_init(void)
 	unsigned int i, j, seg_idx = 0;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* get pointer to global configuration */
 	mcfg = rte_eal_get_configuration()->mem_config;
 
 	/* for debug purposes, hugetlbfs can be disabled */
-	if (internal_conf->no_hugetlbfs) {
+	if (user_cfg->no_hugetlbfs) {
 		struct rte_memseg_list *msl;
 		uint64_t mem_sz, page_sz;
 		int n_segs;
-		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 		/* create a memseg list */
 		msl = &mcfg->memsegs[0];
@@ -122,7 +122,7 @@ rte_eal_hugepage_init(void)
 		hpi = &internal_conf->hugepage_info[i];
 		page_sz = hpi->hugepage_sz;
 		max_pages = hpi->num_pages[0];
-		mem_needed = RTE_ALIGN_CEIL(eal_get_user_configuration()->memory - total_mem,
+		mem_needed = RTE_ALIGN_CEIL(user_cfg->memory - total_mem,
 				page_sz);
 
 		n_pages = RTE_MIN(mem_needed / page_sz, max_pages);
@@ -359,9 +359,10 @@ memseg_primary_init(void)
 	struct rte_memseg_list *msl;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
-	if (internal_conf->no_hugetlbfs)
+	if (user_cfg->no_hugetlbfs)
 		return 0;
 
 	/* FreeBSD has an issue where core dump will dump the entire memory
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index dc252cab37..9b52ef262d 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -746,7 +746,7 @@ rte_eal_init(int argc, char **argv)
 	EAL_LOG(INFO, "Selected IOVA mode '%s'",
 		rte_eal_iova_mode() == RTE_IOVA_PA ? "PA" : "VA");
 
-	if (internal_conf->no_hugetlbfs == 0) {
+	if (!user_cfg->no_hugetlbfs) {
 		/* rte_config isn't initialized yet */
 		ret = internal_conf->process_type == RTE_PROC_PRIMARY ?
 				eal_hugepage_info_init() :
@@ -765,7 +765,7 @@ rte_eal_init(int argc, char **argv)
 	}
 
 	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
-		if (internal_conf->no_hugetlbfs)
+		if (user_cfg->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
@@ -989,9 +989,10 @@ rte_eal_cleanup(void)
 	 */
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
-			internal_conf->hugepage_file.unlink_existing)
+			user_cfg->hugepage_file.unlink_existing)
 		rte_memseg_walk(mark_freeable, NULL);
 
 	rte_service_finalize();
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 05c5b3f613..2f889b291e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -215,22 +215,21 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
 	static uint64_t default_size = 0;
 	const char pagesize_opt[] = "pagesize=";
 	const size_t pagesize_opt_len = sizeof(pagesize_opt) - 1;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct mntent *mnt;
 	FILE *fp;
 
 	/* Fast path: hugepage_dir explicitly specified */
-	if (internal_conf->hugepage_dir != NULL) {
+	if (user_cfg->hugepage_dir != NULL) {
 		struct statfs sfs;
 
 		/* Query info about mounted filesystem */
-		if (statfs(internal_conf->hugepage_dir, &sfs) != 0 ||
+		if (statfs(user_cfg->hugepage_dir, &sfs) != 0 ||
 				(uint32_t)sfs.f_type != HUGETLBFS_MAGIC ||
 				(uint64_t)sfs.f_bsize != hugepage_sz)
 			return -1;
 
-		strlcpy(hugedir, internal_conf->hugepage_dir, len);
+		strlcpy(hugedir, user_cfg->hugepage_dir, len);
 		return 0;
 	}
 
@@ -457,6 +456,7 @@ hugepage_info_init(void)
 	struct dirent *dirent;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	dir = opendir(sys_dir_path);
 	if (dir == NULL) {
@@ -527,7 +527,7 @@ hugepage_info_init(void)
 		 * or count how many of them can be reused.
 		 */
 		reusable_pages = 0;
-		if (!internal_conf->hugepage_file.unlink_existing) {
+		if (!user_cfg->hugepage_file.unlink_existing) {
 			reusable_bytes = 0;
 			if (inspect_hugedir(hpi->hugedir,
 					&reusable_bytes) < 0)
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 8bfcbb1469..4ac5c14668 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -268,6 +268,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	int ret;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (dirty != NULL)
 		*dirty = false;
@@ -306,7 +307,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 			__func__, path, strerror(errno));
 		return -1;
 	}
-	if (!internal_conf->hugepage_file.unlink_existing && ret == 0 &&
+	if (!user_cfg->hugepage_file.unlink_existing && ret == 0 &&
 			dirty != NULL)
 		*dirty = true;
 
@@ -323,7 +324,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	 * whether they will be dirty depends on the part that is mapped.
 	 */
 	if (!internal_conf->single_file_segments &&
-			internal_conf->hugepage_file.unlink_existing &&
+			user_cfg->hugepage_file.unlink_existing &&
 			rte_eal_process_type() == RTE_PROC_PRIMARY &&
 			ret == 0) {
 		/* coverity[toctou] */
@@ -376,8 +377,7 @@ static int
 resize_hugefile_in_filesystem(int fd, uint64_t fa_offset, uint64_t page_sz,
 		bool grow, bool *dirty)
 {
-	const struct internal_config *internal_conf =
-			eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	bool again = false;
 
 	do {
@@ -449,7 +449,7 @@ resize_hugefile_in_filesystem(int fd, uint64_t fa_offset, uint64_t page_sz,
 				 * dirty, unless the file is a fresh one.
 				 */
 				if (dirty != NULL)
-					*dirty &= !internal_conf->hugepage_file.unlink_existing;
+					*dirty &= !user_cfg->hugepage_file.unlink_existing;
 			}
 		}
 	} while (again);
@@ -517,6 +517,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	void *new_addr;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	alloc_sz = hi->hugepage_sz;
 
@@ -549,7 +550,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 			EAL_LOG(DEBUG, "%s(): ftruncate() failed: %s", __func__, strerror(errno));
 			goto resized;
 		}
-		if (internal_conf->hugepage_file.unlink_before_mapping &&
+		if (user_cfg->hugepage_file.unlink_before_mapping &&
 				!internal_conf->in_memory) {
 			if (unlink(path)) {
 				EAL_LOG(DEBUG, "%s(): unlink() failed: %s",
@@ -683,7 +684,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 			close_hugefile(fd, path, list_idx);
 	} else {
 		/* only remove file if we can take out a write lock */
-		if (!internal_conf->hugepage_file.unlink_before_mapping &&
+		if (!user_cfg->hugepage_file.unlink_before_mapping &&
 				internal_conf->in_memory == 0 &&
 				lock(fd, LOCK_EX) == 1)
 			unlink(path);
@@ -702,6 +703,7 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 	int fd, ret = 0;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* erase page data */
 	memset(ms->addr, 0, ms->len);
@@ -737,8 +739,8 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 		 * holding onto this page.
 		 */
 		if (!internal_conf->in_memory &&
-				internal_conf->hugepage_file.unlink_existing &&
-				!internal_conf->hugepage_file.unlink_before_mapping) {
+				user_cfg->hugepage_file.unlink_existing &&
+				!user_cfg->hugepage_file.unlink_before_mapping) {
 			ret = lock(fd, LOCK_EX);
 			if (ret >= 0) {
 				/* no one else is using this page */
@@ -1663,6 +1665,7 @@ eal_memalloc_init(void)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		/*  memory_hotplug_lock is held during initialization, so it's
@@ -1679,8 +1682,8 @@ eal_memalloc_init(void)
 			return -1;
 		}
 		/* safety net, should be impossible to configure */
-		if (internal_conf->hugepage_file.unlink_before_mapping &&
-				!internal_conf->hugepage_file.unlink_existing) {
+		if (user_cfg->hugepage_file.unlink_before_mapping &&
+				!user_cfg->hugepage_file.unlink_existing) {
 			EAL_LOG(ERR, "Unlinking existing hugepage files is prohibited, cannot unlink them before mapping.");
 			return -1;
 		}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index df4df5be8d..3816ddf8c5 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -683,6 +683,7 @@ static int
 remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct rte_memseg_list *msl;
 	struct rte_fbarray *arr;
 	int cur_page, seg_len;
@@ -691,9 +692,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	uint64_t page_sz;
 	size_t memseg_len;
 	int socket_id;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	const bool dirty = !internal_conf->hugepage_file.unlink_existing;
+	const bool dirty = !user_cfg->hugepage_file.unlink_existing;
 
 	page_sz = hugepages[seg_start].size;
 	socket_id = hugepages[seg_start].socket_id;
@@ -794,7 +793,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		/* we have a new address, so unmap previous one */
 #ifndef RTE_ARCH_64
 		/* in 32-bit legacy mode, we have already unmapped the page */
-		if (!internal_conf->legacy_mem)
+		if (!eal_get_internal_configuration()->legacy_mem)
 			munmap(hfile->orig_va, page_sz);
 #else
 		munmap(hfile->orig_va, page_sz);
@@ -1156,7 +1155,7 @@ eal_legacy_hugepage_init(void)
 	mcfg = rte_eal_get_configuration()->mem_config;
 
 	/* hugetlbfs can be disabled */
-	if (internal_conf->no_hugetlbfs) {
+	if (user_cfg->no_hugetlbfs) {
 		void *prealloc_addr;
 		size_t mem_sz;
 		struct rte_memseg_list *msl;
@@ -1453,7 +1452,7 @@ eal_legacy_hugepage_init(void)
 	}
 
 	/* free the hugepage backing files */
-	if (internal_conf->hugepage_file.unlink_before_mapping &&
+	if (user_cfg->hugepage_file.unlink_before_mapping &&
 		unlink_hugepage_files(tmp_hp, internal_conf->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unlinking hugepage files failed!");
 		goto fail;
@@ -1715,7 +1714,7 @@ memseg_primary_init_32(void)
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
-	if (internal_conf->no_hugetlbfs)
+	if (user_cfg->no_hugetlbfs)
 		return 0;
 
 	/* this is a giant hack, but desperate times call for desperate
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index d8c9fa26e3..5f10e1f0eb 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -230,12 +230,12 @@ rte_eal_init(int argc, char **argv)
 		internal_conf->no_shconf = 1;
 	}
 
-	if (!internal_conf->no_hugetlbfs && (eal_hugepage_info_init() < 0)) {
+	if (!user_cfg->no_hugetlbfs && (eal_hugepage_info_init() < 0)) {
 		rte_eal_init_alert("Cannot get hugepage information");
 		rte_errno = EACCES;
 		goto err_out;
 	}
-	if (!internal_conf->no_hugetlbfs &&
+	if (!user_cfg->no_hugetlbfs &&
 			eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
 		rte_eal_init_alert("Cannot apply hugepage memory limits");
 		rte_errno = EINVAL;
@@ -243,7 +243,7 @@ rte_eal_init(int argc, char **argv)
 	}
 
 	if (user_cfg->memory == 0 && !user_cfg->force_numa) {
-		if (internal_conf->no_hugetlbfs)
+		if (user_cfg->no_hugetlbfs)
 			user_cfg->memory = MEMSIZE_IF_NO_HUGE_PAGE;
 	}
 
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index caaa557694..3140d7b9c3 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -723,10 +723,9 @@ eal_nohuge_init(void)
 int
 rte_eal_hugepage_init(void)
 {
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	return internal_conf->no_hugetlbfs ?
+	return user_cfg->no_hugetlbfs ?
 		eal_nohuge_init() : eal_dynmem_hugepage_init();
 }
 
-- 
2.55.0

