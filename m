Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B9CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 16:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28E8240B9F;
	Wed, 29 Apr 2026 18:59:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B149A40685;
 Wed, 29 Apr 2026 18:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481946; x=1809017946;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ztzjh7751eAKuNLv4ASijI2FccLsj6VHATkacQ2hk7E=;
 b=PHLmVQNeDbQAHyRf9NNbUxo97d6N9wPWdoEgtm8A1bSU9nVMyAmUKUAU
 gRXqwY+0v+6dsKA/odFJBhIzTBJVylZUKWYh9N3Eoly9o3qzlBQ2Bixhz
 aHrTV8eRxnoTz18p+fShptXB++Eor9ABYmQG/Gv2m0c1mwSGOUedjA1Tk
 8AJipI8vBl0Bmh9n+2jhAyRSnOynIE1Dp8o8REKgUroPh5gQ1A+FENmVM
 og9ErxqnIp6sHQuNhZgkANjAwTUkMUR3ns0X+JHqNBdI+hfYfMN26K0Ip
 Q86tCpuZQi/9aBuUhgd6LMPFQRAdORhnY+Dv3JPedU8FW8V0NRLuBJGoo w==;
X-CSE-ConnectionGUID: VzTIZUKtSEq+tnfIBMkXaA==
X-CSE-MsgGUID: 91Z0k9xhSNygneThNnuW2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725300"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725300"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:05 -0700
X-CSE-ConnectionGUID: va6ZAe6tQR6rCf/8DKZz/A==
X-CSE-MsgGUID: tjJiKY1UQrOuNJb/vLllZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264696939"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:03 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 07/44] eal: move hugepage size info to platform info struct
Date: Wed, 29 Apr 2026 17:57:59 +0100
Message-ID: <20260429165845.2136843-8-bruce.richardson@intel.com>
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

The hugepage information should not change for the lifetime of the
process, so store it in the platform_info structure in EAL, moving it
out of the internal_config.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 29 ++++++-------
 lib/eal/common/eal_common_options.c |  7 +--
 lib/eal/common/eal_internal_cfg.h   |  5 +--
 lib/eal/freebsd/eal.c               |  7 ++-
 lib/eal/freebsd/eal_hugepage_info.c | 28 ++++++------
 lib/eal/freebsd/eal_memory.c        | 21 ++++-----
 lib/eal/linux/eal.c                 | 12 +++---
 lib/eal/linux/eal_hugepage_info.c   | 37 ++++++++--------
 lib/eal/linux/eal_memalloc.c        | 27 ++++++------
 lib/eal/linux/eal_memory.c          | 66 +++++++++++++----------------
 lib/eal/windows/eal_hugepages.c     |  7 ++-
 lib/eal/windows/eal_memalloc.c      | 26 ++++++------
 12 files changed, 122 insertions(+), 150 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 73a55794e0..c1c72499c4 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -30,8 +30,7 @@ eal_dynmem_memseg_lists_init(void)
 	uint64_t max_mem, max_mem_per_type;
 	unsigned int max_seglists_per_type;
 	unsigned int n_memtypes, cur_type;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
@@ -74,7 +73,7 @@ eal_dynmem_memseg_lists_init(void)
 	 */
 
 	/* create space for mem types */
-	n_memtypes = internal_conf->num_hugepage_sizes * rte_socket_count();
+	n_memtypes = platform_info->num_hugepage_sizes * rte_socket_count();
 	memtypes = calloc(n_memtypes, sizeof(*memtypes));
 	if (memtypes == NULL) {
 		EAL_LOG(ERR, "Cannot allocate space for memory types");
@@ -83,12 +82,12 @@ eal_dynmem_memseg_lists_init(void)
 
 	/* populate mem types */
 	cur_type = 0;
-	for (hpi_idx = 0; hpi_idx < (int) internal_conf->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < (int) platform_info->num_hugepage_sizes;
 			hpi_idx++) {
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 
-		hpi = &internal_conf->hugepage_info[hpi_idx];
+		hpi = &platform_info->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
 		for (i = 0; i < (int) rte_socket_count(); i++, cur_type++) {
@@ -229,14 +228,13 @@ eal_dynmem_hugepage_init(void)
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
 	uint64_t memory[RTE_MAX_NUMA_NODES];
 	int hp_sz_idx, socket_id;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	memset(used_hp, 0, sizeof(used_hp));
 
 	for (hp_sz_idx = 0;
-			hp_sz_idx < (int) internal_conf->num_hugepage_sizes;
+			hp_sz_idx < (int) platform_info->num_hugepage_sizes;
 			hp_sz_idx++) {
 #ifndef RTE_ARCH_64
 		struct hugepage_info dummy;
@@ -244,7 +242,7 @@ eal_dynmem_hugepage_init(void)
 #endif
 		/* also initialize used_hp hugepage sizes in used_hp */
 		struct hugepage_info *hpi;
-		hpi = &internal_conf->hugepage_info[hp_sz_idx];
+		hpi = &platform_info->hugepage_info[hp_sz_idx];
 		used_hp[hp_sz_idx].hugepage_sz = hpi->hugepage_sz;
 
 #ifndef RTE_ARCH_64
@@ -272,12 +270,12 @@ eal_dynmem_hugepage_init(void)
 
 	/* calculate final number of pages */
 	if (eal_dynmem_calc_num_pages_per_socket(memory,
-			internal_conf->hugepage_info, used_hp,
-			internal_conf->num_hugepage_sizes) < 0)
+			platform_info->hugepage_info, used_hp,
+			platform_info->num_hugepage_sizes) < 0)
 		return -1;
 
 	for (hp_sz_idx = 0;
-			hp_sz_idx < (int)internal_conf->num_hugepage_sizes;
+			hp_sz_idx < (int)platform_info->num_hugepage_sizes;
 			hp_sz_idx++) {
 		for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES;
 				socket_id++) {
@@ -356,11 +354,10 @@ get_socket_mem_size(int socket)
 {
 	uint64_t size = 0;
 	unsigned int i;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
 		size += hpi->hugepage_sz * hpi->num_pages[socket];
 	}
 
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index a2f305fc68..0750a52373 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -494,6 +494,7 @@ void
 eal_reset_internal_config(struct internal_config *internal_cfg)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int i;
 
 	user_cfg->memory = 0;
@@ -514,9 +515,9 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 	user_cfg->hugepage_file.unlink_existing = true;
 	/* zero out hugedir descriptors */
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
-		memset(&internal_cfg->hugepage_info[i], 0,
-				sizeof(internal_cfg->hugepage_info[0]));
-		internal_cfg->hugepage_info[i].lock_descriptor = -1;
+		memset(&platform_info->hugepage_info[i], 0,
+				sizeof(platform_info->hugepage_info[0]));
+		platform_info->hugepage_info[i].lock_descriptor = -1;
 	}
 	user_cfg->base_virtaddr = 0;
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 3aec3b0020..fbbe5dce82 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -92,7 +92,8 @@ struct eal_user_cfg {
  * Immutable after initialization, so no need for atomic types or locks.
  */
 struct eal_platform_info {
-	uint8_t reserved;
+	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
+	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
 
 /**
@@ -108,8 +109,6 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
-	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 7e00010771..996a2de9ff 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -329,11 +329,10 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
 		if (strnlen(hpi->hugedir, sizeof(hpi->hugedir)) != 0) {
 			for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 				size += hpi->hugepage_sz * hpi->num_pages[j];
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index 586c5d9f17..b46ae4b689 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -57,16 +57,15 @@ eal_hugepage_info_init(void)
 	size_t sysctl_size;
 	int num_buffers, fd, error;
 	int64_t buffer_size;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* re-use the linux "internal config" structure for our memory data */
-	struct hugepage_info *hpi = &internal_conf->hugepage_info[0];
+	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct hugepage_info *tmp_hpi;
 	unsigned int i;
 
-	internal_conf->num_hugepage_sizes = 1;
+	platform_info->num_hugepage_sizes = 1;
 
 	sysctl_size = sizeof(num_buffers);
 	error = sysctlbyname("hw.contigmem.num_buffers", &num_buffers,
@@ -116,23 +115,23 @@ eal_hugepage_info_init(void)
 		return 0;
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
-			sizeof(internal_conf->hugepage_info));
+			sizeof(platform_info->hugepage_info));
 	if (tmp_hpi == NULL ) {
 		EAL_LOG(ERR, "Failed to create shared memory!");
 		return -1;
 	}
 
-	memcpy(tmp_hpi, hpi, sizeof(internal_conf->hugepage_info));
+	memcpy(tmp_hpi, hpi, sizeof(platform_info->hugepage_info));
 
 	/* we've copied file descriptors along with everything else, but they
 	 * will be invalid in secondary process, so overwrite them
 	 */
-	for (i = 0; i < RTE_DIM(internal_conf->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
 		struct hugepage_info *tmp = &tmp_hpi[i];
 		tmp->lock_descriptor = -1;
 	}
 
-	if (munmap(tmp_hpi, sizeof(internal_conf->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
@@ -144,24 +143,23 @@ eal_hugepage_info_init(void)
 int
 eal_hugepage_info_read(void)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
-	struct hugepage_info *hpi = &internal_conf->hugepage_info[0];
+	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
 	struct hugepage_info *tmp_hpi;
 
-	internal_conf->num_hugepage_sizes = 1;
+	platform_info->num_hugepage_sizes = 1;
 
 	tmp_hpi = open_shared_memory(eal_hugepage_info_path(),
-				  sizeof(internal_conf->hugepage_info));
+				  sizeof(platform_info->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to open shared memory!");
 		return -1;
 	}
 
-	memcpy(hpi, tmp_hpi, sizeof(internal_conf->hugepage_info));
+	memcpy(hpi, tmp_hpi, sizeof(platform_info->hugepage_info));
 
-	if (munmap(tmp_hpi, sizeof(internal_conf->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index cfb17fb3fa..e925fa9743 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -59,9 +59,8 @@ rte_eal_hugepage_init(void)
 	uint64_t total_mem = 0;
 	void *addr;
 	unsigned int i, j, seg_idx = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get pointer to global configuration */
 	mcfg = rte_eal_get_configuration()->mem_config;
@@ -101,13 +100,13 @@ rte_eal_hugepage_init(void)
 	}
 
 	/* map all hugepages and sort them */
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
 		struct hugepage_info *hpi;
 		rte_iova_t prev_end = 0;
 		uint64_t page_sz, mem_needed;
 		unsigned int n_pages, max_pages;
 
-		hpi = &internal_conf->hugepage_info[i];
+		hpi = &platform_info->hugepage_info[i];
 		page_sz = hpi->hugepage_sz;
 		max_pages = hpi->num_pages[0];
 		mem_needed = RTE_ALIGN_CEIL(user_cfg->memory - total_mem,
@@ -270,15 +269,14 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 int
 rte_eal_hugepage_attach(void)
 {
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hpi;
 	int fd_hugepage = -1;
 	unsigned int i;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
-	hpi = &internal_conf->hugepage_info[0];
+	hpi = &platform_info->hugepage_info[0];
 
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
 		const struct hugepage_info *cur_hpi = &hpi[i];
 		struct attach_walk_args wa;
 
@@ -356,9 +354,8 @@ memseg_primary_init(void)
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, total_mem;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -378,7 +375,7 @@ memseg_primary_init(void)
 	total_mem = 0;
 
 	/* create memseg lists */
-	for (hpi_idx = 0; hpi_idx < (int) internal_conf->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < (int) platform_info->num_hugepage_sizes;
 			hpi_idx++) {
 		uint64_t max_type_mem, total_type_mem = 0;
 		uint64_t avail_mem;
@@ -386,7 +383,7 @@ memseg_primary_init(void)
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 
-		hpi = &internal_conf->hugepage_info[hpi_idx];
+		hpi = &platform_info->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
 		/* no NUMA support on FreeBSD */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 4b33e461fd..f692521fe7 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -412,20 +412,18 @@ rte_config_init(void)
 static void
 eal_hugedirs_unlock(void)
 {
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int i;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
 	for (i = 0; i < MAX_HUGEPAGE_SIZES; i++)
 	{
 		/* skip uninitialized */
-		if (internal_conf->hugepage_info[i].lock_descriptor < 0)
+		if (platform_info->hugepage_info[i].lock_descriptor < 0)
 			continue;
 		/* unlock hugepage file */
-		flock(internal_conf->hugepage_info[i].lock_descriptor, LOCK_UN);
-		close(internal_conf->hugepage_info[i].lock_descriptor);
+		flock(platform_info->hugepage_info[i].lock_descriptor, LOCK_UN);
+		close(platform_info->hugepage_info[i].lock_descriptor);
 		/* reset the field */
-		internal_conf->hugepage_info[i].lock_descriptor = -1;
+		platform_info->hugepage_info[i].lock_descriptor = -1;
 	}
 }
 
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 74c55327ff..f35446cdc9 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -453,8 +453,7 @@ hugepage_info_init(void)
 	unsigned int reusable_pages;
 	DIR *dir;
 	struct dirent *dirent;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	dir = opendir(sys_dir_path);
@@ -475,7 +474,7 @@ hugepage_info_init(void)
 		if (num_sizes >= MAX_HUGEPAGE_SIZES)
 			break;
 
-		hpi = &internal_conf->hugepage_info[num_sizes];
+		hpi = &platform_info->hugepage_info[num_sizes];
 		hpi->hugepage_sz =
 			rte_str_to_size(&dirent->d_name[dirent_start_len]);
 
@@ -546,17 +545,17 @@ hugepage_info_init(void)
 	if (dirent != NULL)
 		return -1;
 
-	internal_conf->num_hugepage_sizes = num_sizes;
+	platform_info->num_hugepage_sizes = num_sizes;
 
 	/* sort the page directory entries by size, largest to smallest */
-	qsort(&internal_conf->hugepage_info[0], num_sizes,
-	      sizeof(internal_conf->hugepage_info[0]), compare_hpi);
+	qsort(&platform_info->hugepage_info[0], num_sizes,
+	      sizeof(platform_info->hugepage_info[0]), compare_hpi);
 
 	/* now we have all info, check we have at least one valid size */
 	for (i = 0; i < num_sizes; i++) {
 		/* pages may no longer all be on socket 0, so check all */
 		unsigned int j, num_pages = 0;
-		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
+		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
 
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++)
 			num_pages += hpi->num_pages[j];
@@ -578,8 +577,7 @@ eal_hugepage_info_init(void)
 {
 	struct hugepage_info *hpi, *tmp_hpi;
 	unsigned int i;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (hugepage_info_init() < 0)
@@ -589,26 +587,26 @@ eal_hugepage_info_init(void)
 	if (user_cfg->no_shconf)
 		return 0;
 
-	hpi = &internal_conf->hugepage_info[0];
+	hpi = &platform_info->hugepage_info[0];
 
 	tmp_hpi = create_shared_memory(eal_hugepage_info_path(),
-			sizeof(internal_conf->hugepage_info));
+			sizeof(platform_info->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to create shared memory!");
 		return -1;
 	}
 
-	memcpy(tmp_hpi, hpi, sizeof(internal_conf->hugepage_info));
+	memcpy(tmp_hpi, hpi, sizeof(platform_info->hugepage_info));
 
 	/* we've copied file descriptors along with everything else, but they
 	 * will be invalid in secondary process, so overwrite them
 	 */
-	for (i = 0; i < RTE_DIM(internal_conf->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
 		struct hugepage_info *tmp = &tmp_hpi[i];
 		tmp->lock_descriptor = -1;
 	}
 
-	if (munmap(tmp_hpi, sizeof(internal_conf->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
@@ -617,21 +615,20 @@ eal_hugepage_info_init(void)
 
 int eal_hugepage_info_read(void)
 {
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	struct hugepage_info *hpi = &internal_conf->hugepage_info[0];
+	struct eal_platform_info *platform_info = eal_get_platform_info();
+	struct hugepage_info *hpi = &platform_info->hugepage_info[0];
 	struct hugepage_info *tmp_hpi;
 
 	tmp_hpi = open_shared_memory(eal_hugepage_info_path(),
-				  sizeof(internal_conf->hugepage_info));
+				  sizeof(platform_info->hugepage_info));
 	if (tmp_hpi == NULL) {
 		EAL_LOG(ERR, "Failed to open shared memory!");
 		return -1;
 	}
 
-	memcpy(hpi, tmp_hpi, sizeof(internal_conf->hugepage_info));
+	memcpy(hpi, tmp_hpi, sizeof(platform_info->hugepage_info));
 
-	if (munmap(tmp_hpi, sizeof(internal_conf->hugepage_info)) < 0) {
+	if (munmap(tmp_hpi, sizeof(platform_info->hugepage_info)) < 0) {
 		EAL_LOG(ERR, "Failed to unmap shared memory!");
 		return -1;
 	}
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 7121f933ea..5ae81429d9 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -964,9 +964,8 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 #endif
 	struct alloc_walk_param wa;
 	struct hugepage_info *hi = NULL;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	memset(&wa, 0, sizeof(wa));
 
@@ -974,10 +973,10 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 	if (user_cfg->legacy_mem)
 		return -1;
 
-	for (i = 0; i < (int) RTE_DIM(internal_conf->hugepage_info); i++) {
+	for (i = 0; i < (int) RTE_DIM(platform_info->hugepage_info); i++) {
 		if (page_sz ==
-				internal_conf->hugepage_info[i].hugepage_sz) {
-			hi = &internal_conf->hugepage_info[i];
+				platform_info->hugepage_info[i].hugepage_sz) {
+			hi = &platform_info->hugepage_info[i];
 			break;
 		}
 	}
@@ -1034,9 +1033,8 @@ int
 eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 {
 	int seg, ret = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* dynamic free not supported in legacy mode */
 	if (user_cfg->legacy_mem)
@@ -1057,13 +1055,13 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
 		memset(&wa, 0, sizeof(wa));
 
-		for (i = 0; i < (int)RTE_DIM(internal_conf->hugepage_info);
+		for (i = 0; i < (int)RTE_DIM(platform_info->hugepage_info);
 				i++) {
-			hi = &internal_conf->hugepage_info[i];
+			hi = &platform_info->hugepage_info[i];
 			if (cur->hugepage_sz == hi->hugepage_sz)
 				break;
 		}
-		if (i == (int)RTE_DIM(internal_conf->hugepage_info)) {
+		if (i == (int)RTE_DIM(platform_info->hugepage_info)) {
 			EAL_LOG(ERR, "Can't find relevant hugepage_info entry");
 			ret = -1;
 			continue;
@@ -1327,11 +1325,10 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct rte_memseg_list *primary_msl, *local_msl;
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct hugepage_info *hi = NULL;
 	unsigned int i;
 	int msl_idx;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	if (msl->external)
 		return 0;
@@ -1340,12 +1337,12 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
 	primary_msl = &mcfg->memsegs[msl_idx];
 	local_msl = &local_memsegs[msl_idx];
 
-	for (i = 0; i < RTE_DIM(internal_conf->hugepage_info); i++) {
+	for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
 		uint64_t cur_sz =
-			internal_conf->hugepage_info[i].hugepage_sz;
+			platform_info->hugepage_info[i].hugepage_sz;
 		uint64_t msl_sz = primary_msl->page_sz;
 		if (msl_sz == cur_sz) {
-			hi = &internal_conf->hugepage_info[i];
+			hi = &platform_info->hugepage_info[i];
 			break;
 		}
 	}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 69314656c2..36763bb44f 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -598,14 +598,13 @@ unlink_hugepage_files(struct hugepage_file *hugepg_tbl,
 {
 	unsigned socket, size;
 	int page, nrpages = 0;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get total number of hugepages */
 	for (size = 0; size < num_hp_info; size++)
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++)
 			nrpages +=
-			internal_conf->hugepage_info[size].num_pages[socket];
+			platform_info->hugepage_info[size].num_pages[socket];
 
 	for (page = 0; page < nrpages; page++) {
 		struct hugepage_file *hp = &hugepg_tbl[page];
@@ -629,13 +628,12 @@ unmap_unneeded_hugepages(struct hugepage_file *hugepg_tbl,
 {
 	unsigned socket, size;
 	int page, nrpages = 0;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get total number of hugepages */
 	for (size = 0; size < num_hp_info; size++)
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++)
-			nrpages += internal_conf->hugepage_info[size].num_pages[socket];
+			nrpages += platform_info->hugepage_info[size].num_pages[socket];
 
 	for (size = 0; size < num_hp_info; size++) {
 		for (socket = 0; socket < RTE_MAX_NUMA_NODES; socket++) {
@@ -691,8 +689,6 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	size_t memseg_len;
 	int socket_id;
 #ifndef RTE_ARCH_64
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 #endif
 	page_sz = hugepages[seg_start].size;
 	socket_id = hugepages[seg_start].socket_id;
@@ -859,13 +855,12 @@ memseg_list_free(struct rte_memseg_list *msl)
 static int __rte_unused
 prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 {
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int cur_page, seg_start_page, end_seg, new_memseg;
 	unsigned int hpi_idx, socket, i;
 	int n_contig_segs, n_segs;
 	int msl_idx;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
 	/* before we preallocate segments, we need to free up our VA space.
 	 * we're not removing files, and we already have information about
@@ -880,10 +875,10 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 	/* we cannot know how many page sizes and sockets we have discovered, so
 	 * loop over all of them
 	 */
-	for (hpi_idx = 0; hpi_idx < internal_conf->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < platform_info->num_hugepage_sizes;
 			hpi_idx++) {
 		uint64_t page_sz =
-			internal_conf->hugepage_info[hpi_idx].hugepage_sz;
+			platform_info->hugepage_info[hpi_idx].hugepage_sz;
 
 		for (i = 0; i < rte_socket_count(); i++) {
 			struct rte_memseg_list *msl;
@@ -1088,11 +1083,10 @@ eal_get_hugepage_mem_size(void)
 {
 	uint64_t size = 0;
 	unsigned i, j;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		struct hugepage_info *hpi = &platform_info->hugepage_info[i];
 		if (strnlen(hpi->hugedir, sizeof(hpi->hugedir)) != 0) {
 			for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 				size += hpi->hugepage_sz * hpi->num_pages[j];
@@ -1147,8 +1141,7 @@ eal_legacy_hugepage_init(void)
 	struct rte_mem_config *mcfg;
 	struct hugepage_file *hugepage = NULL, *tmp_hp = NULL;
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	uint64_t memory[RTE_MAX_NUMA_NODES];
@@ -1265,11 +1258,11 @@ eal_legacy_hugepage_init(void)
 
 	/* calculate total number of hugepages available. at this point we haven't
 	 * yet started sorting them so they all are on socket 0 */
-	for (i = 0; i < (int) internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++) {
 		/* meanwhile, also initialize used_hp hugepage sizes in used_hp */
-		used_hp[i].hugepage_sz = internal_conf->hugepage_info[i].hugepage_sz;
+		used_hp[i].hugepage_sz = platform_info->hugepage_info[i].hugepage_sz;
 
-		nr_hugepages += internal_conf->hugepage_info[i].num_pages[0];
+		nr_hugepages += platform_info->hugepage_info[i].num_pages[0];
 	}
 
 	/*
@@ -1293,7 +1286,7 @@ eal_legacy_hugepage_init(void)
 		memory[i] = user_cfg->numa_mem[i];
 
 	/* map all hugepages and sort them */
-	for (i = 0; i < (int)internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int)platform_info->num_hugepage_sizes; i++) {
 		unsigned pages_old, pages_new;
 		struct hugepage_info *hpi;
 
@@ -1302,7 +1295,7 @@ eal_legacy_hugepage_init(void)
 		 * we just map all hugepages available to the system
 		 * all hugepages are still located on socket 0
 		 */
-		hpi = &internal_conf->hugepage_info[i];
+		hpi = &platform_info->hugepage_info[i];
 
 		if (hpi->num_pages[0] == 0)
 			continue;
@@ -1365,9 +1358,9 @@ eal_legacy_hugepage_init(void)
 
 
 	/* clean out the numbers of pages */
-	for (i = 0; i < (int) internal_conf->num_hugepage_sizes; i++)
+	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++)
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++)
-			internal_conf->hugepage_info[i].num_pages[j] = 0;
+			platform_info->hugepage_info[i].num_pages[j] = 0;
 
 	/* get hugepages for each socket */
 	for (i = 0; i < nr_hugefiles; i++) {
@@ -1375,11 +1368,11 @@ eal_legacy_hugepage_init(void)
 
 		/* find a hugepage info with right size and increment num_pages */
 		const int nb_hpsizes = RTE_MIN(MAX_HUGEPAGE_SIZES,
-				(int)internal_conf->num_hugepage_sizes);
+				(int)platform_info->num_hugepage_sizes);
 		for (j = 0; j < nb_hpsizes; j++) {
 			if (tmp_hp[i].size ==
-					internal_conf->hugepage_info[j].hugepage_sz) {
-				internal_conf->hugepage_info[j].num_pages[socket]++;
+					platform_info->hugepage_info[j].hugepage_sz) {
+				platform_info->hugepage_info[j].num_pages[socket]++;
 			}
 		}
 	}
@@ -1390,15 +1383,15 @@ eal_legacy_hugepage_init(void)
 
 	/* calculate final number of pages */
 	nr_hugepages = eal_dynmem_calc_num_pages_per_socket(memory,
-			internal_conf->hugepage_info, used_hp,
-			internal_conf->num_hugepage_sizes);
+			platform_info->hugepage_info, used_hp,
+			platform_info->num_hugepage_sizes);
 
 	/* error if not enough memory available */
 	if (nr_hugepages < 0)
 		goto fail;
 
 	/* reporting in! */
-	for (i = 0; i < (int) internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++) {
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++) {
 			if (used_hp[i].num_pages[j] > 0) {
 				EAL_LOG(DEBUG,
@@ -1427,7 +1420,7 @@ eal_legacy_hugepage_init(void)
 	 * also, sets final_va to NULL on pages that were unmapped.
 	 */
 	if (unmap_unneeded_hugepages(tmp_hp, used_hp,
-			internal_conf->num_hugepage_sizes) < 0) {
+			platform_info->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unmapping and locking hugepages failed!");
 		goto fail;
 	}
@@ -1462,7 +1455,7 @@ eal_legacy_hugepage_init(void)
 
 	/* free the hugepage backing files */
 	if (user_cfg->hugepage_file.unlink_before_mapping &&
-		unlink_hugepage_files(tmp_hp, internal_conf->num_hugepage_sizes) < 0) {
+		unlink_hugepage_files(tmp_hp, platform_info->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unlinking hugepage files failed!");
 		goto fail;
 	}
@@ -1715,8 +1708,7 @@ memseg_primary_init_32(void)
 	struct rte_memseg_list *msl;
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
 	uint64_t max_mem;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* no-huge does not need this at all */
@@ -1783,7 +1775,7 @@ memseg_primary_init_32(void)
 
 	/* create memseg lists */
 	for (i = 0; i < rte_socket_count(); i++) {
-		int hp_sizes = (int) internal_conf->num_hugepage_sizes;
+		int hp_sizes = (int) platform_info->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
 		struct rte_config *cfg = rte_eal_get_configuration();
@@ -1831,7 +1823,7 @@ memseg_primary_init_32(void)
 			struct hugepage_info *hpi;
 			int type_msl_idx, max_segs, total_segs = 0;
 
-			hpi = &internal_conf->hugepage_info[hpi_idx];
+			hpi = &platform_info->hugepage_info[hpi_idx];
 			hugepage_sz = hpi->hugepage_sz;
 
 			/* check if pages are actually available */
diff --git a/lib/eal/windows/eal_hugepages.c b/lib/eal/windows/eal_hugepages.c
index ff72b8ee38..4e9e958c65 100644
--- a/lib/eal/windows/eal_hugepages.c
+++ b/lib/eal/windows/eal_hugepages.c
@@ -62,12 +62,11 @@ hugepage_info_init(void)
 	struct hugepage_info *hpi;
 	unsigned int socket_id;
 	int ret = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* Only one hugepage size available on Windows. */
-	internal_conf->num_hugepage_sizes = 1;
-	hpi = &internal_conf->hugepage_info[0];
+	platform_info->num_hugepage_sizes = 1;
+	hpi = &platform_info->hugepage_info[0];
 
 	hpi->hugepage_sz = GetLargePageMinimum();
 	if (hpi->hugepage_sz == 0)
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 26d9cae54c..35eaf3a180 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -33,7 +33,7 @@ eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 
 static int
 alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
-	struct hugepage_info *hi)
+	const struct hugepage_info *hi)
 {
 	HANDLE current_process;
 	unsigned int numa_node;
@@ -166,7 +166,7 @@ free_seg(struct rte_memseg *ms)
 }
 
 struct alloc_walk_param {
-	struct hugepage_info *hi;
+	const struct hugepage_info *hi;
 	struct rte_memseg **ms;
 	size_t page_sz;
 	unsigned int segs_allocated;
@@ -273,7 +273,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 }
 
 struct free_walk_param {
-	struct hugepage_info *hi;
+	const struct hugepage_info *hi;
 	struct rte_memseg *ms;
 };
 static int
@@ -313,9 +313,8 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	unsigned int i;
 	int ret = -1;
 	struct alloc_walk_param wa;
-	struct hugepage_info *hi = NULL;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct hugepage_info *hi = NULL;
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (user_cfg->legacy_mem) {
@@ -323,8 +322,8 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 		return -ENOTSUP;
 	}
 
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
-		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
+		const struct hugepage_info *hpi = &platform_info->hugepage_info[i];
 		if (page_sz == hpi->hugepage_sz) {
 			hi = hpi;
 			break;
@@ -368,8 +367,7 @@ int
 eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 {
 	int seg, ret = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	/* dynamic free not supported in legacy mode */
@@ -378,7 +376,7 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
 	for (seg = 0; seg < n_segs; seg++) {
 		struct rte_memseg *cur = ms[seg];
-		struct hugepage_info *hi = NULL;
+		const struct hugepage_info *hi = NULL;
 		struct free_walk_param wa;
 		size_t i;
 		int walk_res;
@@ -392,12 +390,12 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
 		memset(&wa, 0, sizeof(wa));
 
-		for (i = 0; i < RTE_DIM(internal_conf->hugepage_info); i++) {
-			hi = &internal_conf->hugepage_info[i];
+		for (i = 0; i < RTE_DIM(platform_info->hugepage_info); i++) {
+			hi = &platform_info->hugepage_info[i];
 			if (cur->hugepage_sz == hi->hugepage_sz)
 				break;
 		}
-		if (i == RTE_DIM(internal_conf->hugepage_info)) {
+		if (i == RTE_DIM(platform_info->hugepage_info)) {
 			EAL_LOG(ERR, "Can't find relevant hugepage_info entry");
 			ret = -1;
 			continue;
-- 
2.51.0

