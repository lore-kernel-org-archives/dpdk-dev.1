Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E6606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LwrOtppV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 434D140E4F;
	Thu, 26 Nov 2026 19:15:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 36A2140E1F
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716931; x=1827252931;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W+vEIdCN6yN3mjmC6Qro8nKF55o7c2IcYxcxdSsZG9c=;
 b=LwrOtppV9ShYALVeb6PNGTONi2YBX0AEMzFfLdD4I+uO3BeW/Mabo1DU
 LqzZ5LpCHd3RnGMD7d5pzCZj1bzqarmF6UMK2dycn9ChbYwiq+WTNgLZQ
 CUhLXWNcjhxZPwtv953yJ3/bxPt9JY2m+HSKrwCpgh2dLhcCEQipyNcOp
 t6a/f3vdt221hxggVsixepoEetKalUsR87DVMZYSbpqHoocKPVBcEHr+v
 9ySolGXwBmikCtUBelA6GwuTIZdU3Zd0wPBxmhMoxB446BPnqf6GDHr6w
 CihyLTgOWIa8VesxMkbAVU7C4FgzIGE3VNaWWIvhcdNBS0ypk9Ll5nvZ1 w==;
X-CSE-ConnectionGUID: nGE3V6z0R/epIiVHuky6uA==
X-CSE-MsgGUID: WszxJw22RE+lZBp4pPW8Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633642"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:30 -0800
X-CSE-ConnectionGUID: MRpoINT0REWcd5Z9C+B+ew==
X-CSE-MsgGUID: oUCzWmdcS82V0GZUoeFSrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733168"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 36/39] eal: remove duplicated scan of sysfs for hugepage
 details
Date: Thu, 26 Nov 2026 18:14:09 +0000
Message-ID: <20261126181414.124094-37-bruce.richardson@intel.com>
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

Since the platform_info struct does the hugepage scanning, we can reuse
those details in the hugepage init functions rather than rescanning
sysfs.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_internal_cfg.h   |   1 +
 lib/eal/freebsd/eal_hugepage_info.c |  29 ++------
 lib/eal/linux/eal_hugepage_info.c   | 103 ++++++++++------------------
 lib/eal/windows/eal_hugepages.c     |  26 ++-----
 4 files changed, 51 insertions(+), 108 deletions(-)

diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 7d23568d7b..6dcf2c55a7 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -167,6 +167,7 @@ struct eal_cpu_info {
 struct hp_sizes {
 	uint64_t size;         /**< hugepage size in bytes */
 	char dir[PATH_MAX];    /**< dir where hugetlbfs is mounted for this size */
+	char subdir[32];       /**< sysfs subdir name for this size, e.g. "hugepages-2048kB" */
 	uint32_t total_pages;  /**< total hugepages of this size across all NUMA nodes */
 	uint32_t max_pages[RTE_MAX_NUMA_NODES];
 	/**< maximum hugepages of this size available on each NUMA node */
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index 2b731f2b3c..9c97897cc3 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -87,9 +87,9 @@ eal_get_platform_hp_info(struct eal_platform_info *platform_info)
 int
 eal_hugepage_info_init(void)
 {
-	size_t sysctl_size;
-	int num_buffers, fd, error;
-	int64_t buffer_size = 0;
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	int num_buffers, fd;
+	int64_t buffer_size;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/* re-use the linux "internal config" structure for our memory data */
@@ -98,28 +98,13 @@ eal_hugepage_info_init(void)
 	struct hugepage_info *tmp_hpi;
 	unsigned int i;
 
-	sysctl_size = sizeof(num_buffers);
-	error = sysctlbyname("hw.contigmem.num_buffers", &num_buffers,
-			&sysctl_size, NULL, 0);
-
-	if (error != 0) {
-		EAL_LOG(ERR, "could not read sysctl hw.contigmem.num_buffers");
+	if (platform_info->num_hugepage_sizes == 0) {
+		EAL_LOG(ERR, "could not read hugepage info from platform");
 		return -1;
 	}
 
-	sysctl_size = sizeof(buffer_size);
-	error = sysctlbyname("hw.contigmem.buffer_size", &buffer_size,
-			&sysctl_size, NULL, 0);
-
-	if (error != 0) {
-		error = sysctlbyname("hw.contigmem.buffer_size_MB", &buffer_size,
-				&sysctl_size, NULL, 0);
-		buffer_size *= 1024 * 1024;  /* convert to bytes, harmless to multiple on error*/
-	}
-	if (error != 0) {
-		EAL_LOG(ERR, "could not read sysctl hw.contigmem.buffer_size");
-		return -1;
-	}
+	buffer_size = (int64_t)platform_info->hugepage_sizes[0].size;
+	num_buffers = (int)platform_info->hugepage_sizes[0].max_pages[0];
 
 	fd = open(CONTIGMEM_DEV, O_RDWR);
 	if (fd < 0) {
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index bbea6959d5..a6bf807f90 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -386,15 +386,6 @@ inspect_hugedir(const char *hugedir, uint64_t *total_size)
 	return walk_hugedir(hugedir, inspect_hugedir_cb, total_size);
 }
 
-static int
-compare_hpi(const void *a, const void *b)
-{
-	const struct hugepage_info *hpi_a = a;
-	const struct hugepage_info *hpi_b = b;
-
-	return hpi_b->hugepage_sz - hpi_a->hugepage_sz;
-}
-
 static int
 compare_hp_sizes(const void *a, const void *b)
 {
@@ -442,6 +433,14 @@ eal_get_platform_hp_info(struct eal_platform_info *platform_info)
 		sz = rte_str_to_size(&dirent->d_name[dirent_start_len]);
 		hps = &platform_info->hugepage_sizes[num_sizes];
 		hps->size = sz;
+		if (strlcpy(hps->subdir, dirent->d_name,
+				sizeof(hps->subdir)) >= sizeof(hps->subdir)) {
+			/* buffer is properly sized, this should never occur;
+			 * check to avoid compiler warning about return value being ignored.
+			 */
+			EAL_LOG(ERR, "Hugepage subdir name too long: %s", dirent->d_name);
+			continue;
+		}
 
 		/* fill per-socket page counts; fall back to socket 0 total */
 		hps->total_pages = 0;
@@ -472,20 +471,13 @@ eal_get_platform_hp_info(struct eal_platform_info *platform_info)
 }
 
 static void
-calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
+calc_num_pages(struct hugepage_info *hpi, const struct hp_sizes *hps,
 		unsigned int reusable_pages)
 {
 	uint64_t total_pages = 0;
 	unsigned int i;
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
-	/*
-	 * first, try to put all hugepages into relevant sockets, but
-	 * if first attempts fails, fall back to collecting all pages
-	 * in one socket and sorting them later
-	 */
-	total_pages = 0;
-
 	/*
 	 * We also don't want to do this for legacy init.
 	 * When there are hugepage files to reuse it is unknown
@@ -493,23 +485,21 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 	 * This could be determined by mapping,
 	 * but it is precisely what hugepage file reuse is trying to avoid.
 	 */
-	if (!user_cfg->legacy_mem && reusable_pages == 0)
-		for (i = 0; i < rte_socket_count(); i++) {
-			int socket = rte_socket_id_by_idx(i);
-			unsigned int num_pages =
-					get_num_hugepages_on_node(
-						dirent->d_name, socket,
-						hpi->hugepage_sz);
-			hpi->num_pages[socket] = num_pages;
-			total_pages += num_pages;
+	if (!user_cfg->legacy_mem && reusable_pages == 0) {
+		for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
+			hpi->num_pages[i] = hps->max_pages[i];
+			total_pages += hps->max_pages[i];
 		}
+	}
 	/*
 	 * we failed to sort memory from the get go, so fall
 	 * back to old way
 	 */
 	if (total_pages == 0) {
-		hpi->num_pages[0] = get_num_hugepages(dirent->d_name,
-				hpi->hugepage_sz, reusable_pages);
+		hpi->num_pages[0] = hps->total_pages > 0 ?
+			hps->total_pages + reusable_pages :
+			get_num_hugepages(hps->subdir, hpi->hugepage_sz,
+				reusable_pages);
 
 #ifndef RTE_ARCH_64
 		/* for 32-bit systems, limit number of hugepages to
@@ -522,51 +512,35 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 
 static int
 hugepage_info_init(void)
-{	const char dirent_start_text[] = "hugepages-";
-	const size_t dirent_start_len = sizeof(dirent_start_text) - 1;
+{
 	unsigned int i, num_sizes = 0;
 	uint64_t reusable_bytes;
 	unsigned int reusable_pages;
-	DIR *dir;
-	struct dirent *dirent;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
+	int failed = 0;
 
-	dir = opendir(sys_dir_path);
-	if (dir == NULL) {
-		EAL_LOG(ERR,
-			"Cannot open directory %s to read system hugepage info",
-			sys_dir_path);
-		return -1;
-	}
-
-	for (dirent = readdir(dir); dirent != NULL; dirent = readdir(dir)) {
+	/* platform_info->hugepage_sizes[] is already sorted largest to smallest */
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		const struct hp_sizes *hps = &platform_info->hugepage_sizes[i];
 		struct hugepage_info *hpi;
 
-		if (strncmp(dirent->d_name, dirent_start_text,
-			    dirent_start_len) != 0)
-			continue;
-
 		if (num_sizes >= MAX_HUGEPAGE_SIZES)
 			break;
 
 		hpi = &runtime_state->hugepage_info[num_sizes];
-		hpi->hugepage_sz =
-			rte_str_to_size(&dirent->d_name[dirent_start_len]);
+		hpi->hugepage_sz = hps->size;
 
 		/* first, check if we have a mountpoint */
 		if (get_hugepage_dir(hpi->hugepage_sz,
 			hpi->hugedir, sizeof(hpi->hugedir)) < 0) {
-			uint32_t num_pages;
-
-			num_pages = get_num_hugepages(dirent->d_name,
-					hpi->hugepage_sz, 0);
-			if (num_pages > 0)
+			if (hps->total_pages > 0)
 				EAL_LOG(NOTICE,
 					"%" PRIu32 " hugepages of size "
 					"%" PRIu64 " reserved, but no mounted "
 					"hugetlbfs found for that size",
-					num_pages, hpi->hugepage_sz);
+					hps->total_pages, hpi->hugepage_sz);
 			/* if we have kernel support for reserving hugepages
 			 * through mmap, and we're in in-memory mode, treat this
 			 * page size as valid. we cannot be in legacy mode at
@@ -575,11 +549,9 @@ hugepage_info_init(void)
 			 */
 #ifdef MAP_HUGE_SHIFT
 			if (user_cfg->in_memory) {
-				EAL_LOG(DEBUG, "In-memory mode enabled, "
-					"hugepages of size %" PRIu64 " bytes "
-					"will be allocated anonymously",
+				EAL_LOG(DEBUG, "In-memory mode enabled, hugepages of size %" PRIu64 " bytes will be allocated anonymously",
 					hpi->hugepage_sz);
-				calc_num_pages(hpi, dirent, 0);
+				calc_num_pages(hpi, hps, 0);
 				num_sizes++;
 			}
 #endif
@@ -593,6 +565,7 @@ hugepage_info_init(void)
 		if (flock(hpi->lock_descriptor, LOCK_EX) == -1) {
 			EAL_LOG(CRIT,
 				"Failed to lock hugepage directory!");
+			failed = 1;
 			break;
 		}
 
@@ -603,30 +576,26 @@ hugepage_info_init(void)
 		reusable_pages = 0;
 		if (!user_cfg->hugepage_file.unlink_existing) {
 			reusable_bytes = 0;
-			if (inspect_hugedir(hpi->hugedir,
-					&reusable_bytes) < 0)
+			if (inspect_hugedir(hpi->hugedir, &reusable_bytes) < 0) {
+				failed = 1;
 				break;
+			}
 			RTE_ASSERT(reusable_bytes % hpi->hugepage_sz == 0);
 			reusable_pages = reusable_bytes / hpi->hugepage_sz;
 		} else if (clear_hugedir(hpi->hugedir) < 0) {
+			failed = 1;
 			break;
 		}
-		calc_num_pages(hpi, dirent, reusable_pages);
+		calc_num_pages(hpi, hps, reusable_pages);
 
 		num_sizes++;
 	}
-	closedir(dir);
 
-	/* something went wrong, and we broke from the for loop above */
-	if (dirent != NULL)
+	if (failed)
 		return -1;
 
 	runtime_state->num_hugepage_sizes = num_sizes;
 
-	/* sort the page directory entries by size, largest to smallest */
-	qsort(&runtime_state->hugepage_info[0], num_sizes,
-	      sizeof(runtime_state->hugepage_info[0]), compare_hpi);
-
 	/* now we have all info, check we have at least one valid size */
 	for (i = 0; i < num_sizes; i++) {
 		/* pages may no longer all be on socket 0, so check all */
diff --git a/lib/eal/windows/eal_hugepages.c b/lib/eal/windows/eal_hugepages.c
index fa19b7b77c..0c62f5ff48 100644
--- a/lib/eal/windows/eal_hugepages.c
+++ b/lib/eal/windows/eal_hugepages.c
@@ -59,33 +59,21 @@ hugepage_claim_privilege(void)
 static int
 hugepage_info_init(void)
 {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hpi;
 	unsigned int socket_id;
 	int ret = 0;
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
-	hpi = &runtime_state->hugepage_info[0];
-
-	hpi->hugepage_sz = GetLargePageMinimum();
-	if (hpi->hugepage_sz == 0)
+	if (platform_info->num_hugepage_sizes == 0)
 		return -ENOTSUP;
 
-	/* Assume all memory on each NUMA node available for hugepages,
-	 * because Windows neither advertises additional limits,
-	 * nor provides an API to query them.
-	 */
-	for (socket_id = 0; socket_id < rte_socket_count(); socket_id++) {
-		ULONGLONG bytes;
-		unsigned int numa_node;
-
-		numa_node = eal_socket_numa_node(socket_id);
-		if (!GetNumaAvailableMemoryNodeEx(numa_node, &bytes)) {
-			RTE_LOG_WIN32_ERR("GetNumaAvailableMemoryNodeEx(%u)",
-				numa_node);
-			continue;
-		}
+	hpi = &runtime_state->hugepage_info[0];
+	hpi->hugepage_sz = platform_info->hugepage_sizes[0].size;
 
-		hpi->num_pages[socket_id] = bytes / hpi->hugepage_sz;
+	for (socket_id = 0; socket_id < rte_socket_count(); socket_id++) {
+		hpi->num_pages[socket_id] =
+			platform_info->hugepage_sizes[0].max_pages[socket_id];
 		EAL_LOG(DEBUG,
 			"Found %u hugepages of %zu bytes on socket %u",
 			hpi->num_pages[socket_id], hpi->hugepage_sz, socket_id);
-- 
2.55.0

