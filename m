Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58807C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F152140B94;
	Tue, 18 Aug 2026 15:33:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CFCD840689
 for <dev@dpdk.org>; Tue, 18 Aug 2026 15:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787060035; x=1818596035;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CFbvYnBdxW5Dh7B8wuh74mB74sHzGTjvrUrJ0TrfWk0=;
 b=A4b7DIN1oWhXSkW/R/61KB+aIDSrGNqrqFCTm6pFD0Qwtj+OI54zwwVc
 6WuY4mt9OP/buf6bEVIqtpplUhgFMpey1NktmbvP8UfANJE5EIERi3uO6
 3XMXF2zE2fkRba1EB88or6cqzMJiKgBGLCZp/jEGgwSo+YH2Rw9xjR+gQ
 Txsx3aHtpGUgtWDYpebJrbzUp8OtAnLPhxFpkTsTHAt3ZN3oDzTtLJKL3
 3B8KDkIlp4bA8QO/fl9Cz6shOxl7zV0hF764laMQlgpkJKL4PYL3l/2m4
 pu7moo66u6/7dZ85VZx8NZYK4/iDj4WbGoxcrJ/6qh6oxlbrgztoIAEGf w==;
X-CSE-ConnectionGUID: Hu8M/wI4SZGmIyofymkvPQ==
X-CSE-MsgGUID: w395vFoNTJuGnZAl9nZDBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87757625"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87757625"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:33:53 -0700
X-CSE-ConnectionGUID: AvuT+qsYSkm1QSEaIDdQkA==
X-CSE-MsgGUID: G8EApSQLQju9qO2A8j/sMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="288736594"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2026 06:33:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 10/39] eal: move hugepage size info to platform info struct
Date: Tue, 18 Aug 2026 14:33:03 +0100
Message-ID: <20260818133334.2620165-11-bruce.richardson@intel.com>
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

The hugepage information should not change for the lifetime of the
process, so store it in the platform_info structure in EAL, moving it
out of the internal_config.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_dynmem.c  | 29 ++++++-------
 lib/eal/common/eal_common_options.c | 14 ++++---
 lib/eal/common/eal_internal_cfg.h   |  5 +--
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/freebsd/eal.c               |  9 ++--
 lib/eal/freebsd/eal_hugepage_info.c | 28 ++++++-------
 lib/eal/freebsd/eal_memory.c        | 21 ++++------
 lib/eal/linux/eal.c                 | 14 +++----
 lib/eal/linux/eal_hugepage_info.c   | 37 ++++++++---------
 lib/eal/linux/eal_memalloc.c        | 27 ++++++------
 lib/eal/linux/eal_memory.c          | 64 +++++++++++++----------------
 lib/eal/windows/eal.c               |  4 +-
 lib/eal/windows/eal_hugepages.c     |  7 ++--
 lib/eal/windows/eal_memalloc.c      | 26 ++++++------
 14 files changed, 130 insertions(+), 157 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 6c830d302f..9c421be225 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -34,8 +34,7 @@ eal_dynmem_memseg_lists_init(void)
 	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
 	void *mem_va_addr = NULL;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
@@ -59,7 +58,7 @@ eal_dynmem_memseg_lists_init(void)
 	 */
 
 	/* maximum number of memtypes we're ever going to get */
-	n_memtypes = internal_conf->num_hugepage_sizes * rte_socket_count();
+	n_memtypes = platform_info->num_hugepage_sizes * rte_socket_count();
 
 	/* can we fit all memtypes into the memseg lists? */
 	if (n_memtypes > RTE_MAX_MEMSEG_LISTS) {
@@ -70,12 +69,12 @@ eal_dynmem_memseg_lists_init(void)
 
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
@@ -212,14 +211,13 @@ eal_dynmem_hugepage_init(void)
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
@@ -227,7 +225,7 @@ eal_dynmem_hugepage_init(void)
 #endif
 		/* also initialize used_hp hugepage sizes in used_hp */
 		struct hugepage_info *hpi;
-		hpi = &internal_conf->hugepage_info[hp_sz_idx];
+		hpi = &platform_info->hugepage_info[hp_sz_idx];
 		used_hp[hp_sz_idx].hugepage_sz = hpi->hugepage_sz;
 
 #ifndef RTE_ARCH_64
@@ -255,12 +253,12 @@ eal_dynmem_hugepage_init(void)
 
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
@@ -339,11 +337,10 @@ get_socket_mem_size(int socket)
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
index 8dd10340e9..4f72f2e3d9 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -511,6 +511,7 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 {
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	int i;
 
 	user_cfg->memory = 0;
@@ -537,9 +538,9 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
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
 
@@ -2519,15 +2520,16 @@ eal_adjust_config(struct internal_config *internal_cfg)
 }
 
 int
-eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
+eal_apply_hugepage_mem_sz_limits(void)
 {
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 	unsigned int i;
 
-	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
+	for (i = 0; i < platform_info->num_hugepage_sizes; i++) {
 		unsigned int j;
-		const uint64_t pagesz = internal_cfg->hugepage_info[i].hugepage_sz;
+		const uint64_t pagesz = platform_info->hugepage_info[i].hugepage_sz;
 		uint64_t limit;
 
 		/* assign default limits */
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 87f992d15f..8d4ea30754 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -98,7 +98,8 @@ struct eal_user_cfg {
  * Immutable after initialization, so no need for atomic types or locks.
  */
 struct eal_platform_info {
-	uint8_t reserved;
+	uint8_t num_hugepage_sizes;      /**< how many sizes on this system */
+	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 };
 
 /**
@@ -115,8 +116,6 @@ struct eal_runtime_state {
  * internal configuration
  */
 struct internal_config {
-	unsigned num_hugepage_sizes;      /**< how many sizes on this system */
-	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
 	/**< indicates whether EAL has completed initialization */
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 0c5132de6a..58a047a532 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -13,7 +13,7 @@ struct eal_user_cfg;
 int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
-int eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg);
+int eal_apply_hugepage_mem_sz_limits(void);
 int eal_adjust_config(struct internal_config *internal_cfg);
 int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
 enum rte_proc_type_t eal_proc_type_detect(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index ae29e1b10a..4e962966aa 100644
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
@@ -582,7 +581,7 @@ rte_eal_init(int argc, char **argv)
 			goto err_out;
 		}
 		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
-				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
 			goto err_out;
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index 29c5d986c1..b4859f9bb0 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -57,16 +57,15 @@ eal_hugepage_info_init(void)
 	size_t sysctl_size;
 	int num_buffers, fd, error;
 	int64_t buffer_size = 0;
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
@@ -121,23 +120,23 @@ eal_hugepage_info_init(void)
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
@@ -149,24 +148,23 @@ eal_hugepage_info_init(void)
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
index de66840bfe..221c003229 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -71,9 +71,8 @@ rte_eal_hugepage_init(void)
 	uint64_t total_mem = 0;
 	void *addr;
 	unsigned int i, j, seg_idx = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* get pointer to global configuration */
 	mcfg = rte_eal_get_configuration()->mem_config;
@@ -113,13 +112,13 @@ rte_eal_hugepage_init(void)
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
@@ -285,15 +284,14 @@ attach_segment(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
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
 
@@ -353,9 +351,8 @@ memseg_primary_init(void)
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int hpi_idx, msl_idx = 0;
 	struct rte_memseg_list *msl;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* no-huge does not need this at all */
 	if (user_cfg->no_hugetlbfs)
@@ -368,13 +365,13 @@ memseg_primary_init(void)
 	 */
 
 	/* create memseg lists */
-	for (hpi_idx = 0; hpi_idx < (int) internal_conf->num_hugepage_sizes;
+	for (hpi_idx = 0; hpi_idx < (int) platform_info->num_hugepage_sizes;
 			hpi_idx++) {
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 		unsigned int n_segs;
 
-		hpi = &internal_conf->hugepage_info[hpi_idx];
+		hpi = &platform_info->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
 		/* no NUMA support on FreeBSD */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c2e6fabd89..62efae6b7b 100644
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
 
@@ -746,7 +744,7 @@ rte_eal_init(int argc, char **argv)
 			goto err_out;
 		}
 		if (user_cfg->process_type == RTE_PROC_PRIMARY &&
-				eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+				eal_apply_hugepage_mem_sz_limits() < 0) {
 			rte_eal_init_alert("Cannot apply hugepage memory limits.");
 			rte_errno = EINVAL;
 			goto err_out;
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
index 143e7287a7..8e713922c7 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -966,9 +966,8 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 #endif
 	struct alloc_walk_param wa;
 	struct hugepage_info *hi = NULL;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	memset(&wa, 0, sizeof(wa));
 
@@ -976,10 +975,10 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
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
@@ -1036,9 +1035,8 @@ int
 eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 {
 	int seg, ret = 0;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 
 	/* dynamic free not supported in legacy mode */
 	if (user_cfg->legacy_mem)
@@ -1059,13 +1057,13 @@ eal_memalloc_free_seg_bulk(struct rte_memseg **ms, int n_segs)
 
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
@@ -1329,11 +1327,10 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
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
@@ -1342,12 +1339,12 @@ sync_walk(const struct rte_memseg_list *msl, void *arg __rte_unused)
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
index ad787572d3..1fc01beae9 100644
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
@@ -840,13 +838,12 @@ memseg_list_free(struct rte_memseg_list *msl)
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
@@ -861,10 +858,10 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
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
@@ -1069,11 +1066,10 @@ eal_get_hugepage_mem_size(void)
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
@@ -1128,8 +1124,7 @@ eal_legacy_hugepage_init(void)
 	struct rte_mem_config *mcfg;
 	struct hugepage_file *hugepage = NULL, *tmp_hp = NULL;
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	uint64_t memory[RTE_MAX_NUMA_NODES];
@@ -1246,11 +1241,11 @@ eal_legacy_hugepage_init(void)
 
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
@@ -1274,7 +1269,7 @@ eal_legacy_hugepage_init(void)
 		memory[i] = user_cfg->numa_mem[i];
 
 	/* map all hugepages and sort them */
-	for (i = 0; i < (int)internal_conf->num_hugepage_sizes; i++) {
+	for (i = 0; i < (int)platform_info->num_hugepage_sizes; i++) {
 		unsigned pages_old, pages_new;
 		struct hugepage_info *hpi;
 
@@ -1283,7 +1278,7 @@ eal_legacy_hugepage_init(void)
 		 * we just map all hugepages available to the system
 		 * all hugepages are still located on socket 0
 		 */
-		hpi = &internal_conf->hugepage_info[i];
+		hpi = &platform_info->hugepage_info[i];
 
 		if (hpi->num_pages[0] == 0)
 			continue;
@@ -1346,9 +1341,9 @@ eal_legacy_hugepage_init(void)
 
 
 	/* clean out the numbers of pages */
-	for (i = 0; i < (int) internal_conf->num_hugepage_sizes; i++)
+	for (i = 0; i < (int) platform_info->num_hugepage_sizes; i++)
 		for (j = 0; j < RTE_MAX_NUMA_NODES; j++)
-			internal_conf->hugepage_info[i].num_pages[j] = 0;
+			platform_info->hugepage_info[i].num_pages[j] = 0;
 
 	/* get hugepages for each socket */
 	for (i = 0; i < nr_hugefiles; i++) {
@@ -1356,11 +1351,11 @@ eal_legacy_hugepage_init(void)
 
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
@@ -1371,15 +1366,15 @@ eal_legacy_hugepage_init(void)
 
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
@@ -1408,7 +1403,7 @@ eal_legacy_hugepage_init(void)
 	 * also, sets final_va to NULL on pages that were unmapped.
 	 */
 	if (unmap_unneeded_hugepages(tmp_hp, used_hp,
-			internal_conf->num_hugepage_sizes) < 0) {
+			platform_info->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unmapping and locking hugepages failed!");
 		goto fail;
 	}
@@ -1443,7 +1438,7 @@ eal_legacy_hugepage_init(void)
 
 	/* free the hugepage backing files */
 	if (user_cfg->hugepage_file.unlink_before_mapping &&
-		unlink_hugepage_files(tmp_hp, internal_conf->num_hugepage_sizes) < 0) {
+		unlink_hugepage_files(tmp_hp, platform_info->num_hugepage_sizes) < 0) {
 		EAL_LOG(ERR, "Unlinking hugepage files failed!");
 		goto fail;
 	}
@@ -1697,8 +1692,7 @@ memseg_primary_init_32(void)
 	unsigned int socket_id, i;
 	struct rte_memseg_list *msl;
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	struct eal_platform_info *platform_info = eal_get_platform_info();
 	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
@@ -1765,7 +1759,7 @@ memseg_primary_init_32(void)
 
 	/* create memseg lists */
 	for (i = 0; i < rte_socket_count(); i++) {
-		int hp_sizes = (int) internal_conf->num_hugepage_sizes;
+		int hp_sizes = (int) platform_info->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
 		struct rte_config *cfg = rte_eal_get_configuration();
@@ -1813,7 +1807,7 @@ memseg_primary_init_32(void)
 			uint64_t pagesz_mem_limit;
 			struct hugepage_info *hpi;
 
-			hpi = &internal_conf->hugepage_info[hpi_idx];
+			hpi = &platform_info->hugepage_info[hpi_idx];
 			hugepage_sz = hpi->hugepage_sz;
 
 			/* check if pages are actually available */
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 7504a4ac92..882ef93930 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -158,8 +158,6 @@ rte_eal_init(int argc, char **argv)
 {
 	int i, fctret, bscan;
 	const struct rte_config *config = rte_eal_get_configuration();
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	bool has_phys_addr;
 	enum rte_iova_mode iova_mode;
@@ -230,7 +228,7 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 	if (!user_cfg->no_hugetlbfs &&
-			eal_apply_hugepage_mem_sz_limits(internal_conf) < 0) {
+			eal_apply_hugepage_mem_sz_limits() < 0) {
 		rte_eal_init_alert("Cannot apply hugepage memory limits");
 		rte_errno = EINVAL;
 		goto err_out;
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
2.53.0

