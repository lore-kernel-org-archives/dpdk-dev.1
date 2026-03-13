Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF30107BCC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 16:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7888140431;
	Fri, 13 Mar 2026 17:06:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 02E604042E
 for <dev@dpdk.org>; Fri, 13 Mar 2026 17:06:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773418008; x=1804954008;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=U7F6r65+8OjBGcukHzfWO8L6ZNiJDBeLMJ35NGBG9vY=;
 b=A3hk3iqFoByGCn19woS/9xniRU8f/7DV0DGKjbF5k7IDEJp+G6Jxfb9A
 vXHoTmZcerBZSe+c7gBVLaR+AHIeLUBDnSB9iRU9Fj8/T6RfqQ5Erepdm
 XHhJeBtm0mTF7wC1x8kwVZV7mpdci0h9GxDmkeg/fNCVgBECpygwWPgxU
 sZPqCzPovr3Jceky2o7s2zLkeLxfUYLIGKgK3y7ma3Wjcn2WkLUtFmf3R
 2KVOzL0Bg/65M4ICpEXGMDjPOHCKIvCGDqXJy7+I3+WjWZMnqDRAeJ51L
 8zLofsYPbjj70gvTwGduRNthhWVvENkzhGdZJviq5sFOz1zWjwi0e106+ g==;
X-CSE-ConnectionGUID: qqcm5aEeTsKP+lbqHH8dCQ==
X-CSE-MsgGUID: 9Vn4TJRnQWGweNXCARDqLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74563536"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="74563536"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 09:06:48 -0700
X-CSE-ConnectionGUID: ITZ1WJ/5S2mIUxyYLxq3+w==
X-CSE-MsgGUID: OOh3ljc/SD+LgYn5ZLRoWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="246377259"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 13 Mar 2026 09:06:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 6/6] eal/memory: add page size VA limits EAL parameter
Date: Fri, 13 Mar 2026 16:06:37 +0000
Message-ID: <968ab78a3f7bd130287e269dfe82a3481baab161.1773417833.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773417833.git.anatoly.burakov@intel.com>
 <cover.1773417833.git.anatoly.burakov@intel.com>
References: 
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

Currently, the VA space limits placed on DPDK memory are only informed by
the default configuration coming from `rte_config.h` file. Add an EAL flag
to specify per-page size memory limits explicitly, thereby overriding the
default VA space reservations.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test.c                               |   1 +
 app/test/test_eal_flags.c                     | 126 ++++++++++++++++++
 doc/guides/linux_gsg/linux_eal_parameters.rst |  13 ++
 .../prog_guide/env_abstraction_layer.rst      |  27 +++-
 lib/eal/common/eal_common_dynmem.c            |   9 ++
 lib/eal/common/eal_common_options.c           | 121 +++++++++++++++++
 lib/eal/common/eal_internal_cfg.h             |   6 +
 lib/eal/common/eal_option_list.h              |   1 +
 8 files changed, 302 insertions(+), 2 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 58ef52f312..c610c3588e 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -80,6 +80,7 @@ do_recursive_call(void)
 			{ "test_memory_flags", no_action },
 			{ "test_file_prefix", no_action },
 			{ "test_no_huge_flag", no_action },
+			{ "test_pagesz_mem_flags", no_action },
 			{ "test_panic", test_panic },
 			{ "test_exit", test_exit },
 #ifdef RTE_LIB_TIMER
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b3a8d0ae6f..4e1038be75 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -95,6 +95,14 @@ test_misc_flags(void)
 	return TEST_SKIPPED;
 }
 
+static int
+test_pagesz_mem_flags(void)
+{
+	printf("pagesz_mem_flags not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+
 #else
 
 #include <libgen.h>
@@ -1502,6 +1510,123 @@ populate_socket_mem_param(int num_sockets, const char *mem,
 	offset += written;
 }
 
+/*
+ * Tests for correct handling of --pagesz-mem flag
+ */
+static int
+test_pagesz_mem_flags(void)
+{
+#ifdef RTE_EXEC_ENV_FREEBSD
+	/* FreeBSD does not support --pagesz-mem */
+	return 0;
+#else
+	const char *in_memory = "--in-memory";
+
+	/* invalid: no value */
+	const char * const argv0[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem="};
+
+	/* invalid: no colon (missing limit) */
+	const char * const argv1[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M"};
+
+	/* invalid: colon present but limit is empty */
+	const char * const argv2[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:"};
+
+	/* invalid: limit not aligned to page size (3M is not a multiple of 2M) */
+	const char * const argv3[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:3M"};
+
+	/* invalid: garbage value */
+	const char * const argv4[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=garbage"};
+
+	/* invalid: garbage value */
+	const char * const argv5[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:garbage"};
+
+	/* invalid: --pagesz-mem combined with --no-huge */
+	const char * const argv6[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, no_huge, "--pagesz-mem=2M:2M"};
+
+	/* valid: single well-formed aligned pair */
+	const char * const argv7[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=2M:64M"};
+
+	/* valid: multiple occurrences */
+	const char * const argv8[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory,
+			"--pagesz-mem=2M:64M", "--pagesz-mem=1K:8K"};
+
+	/* valid: fake page size set to zero (ignored but syntactically valid) */
+	const char * const argv9[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=1K:0"};
+
+	/* invalid: page size must be a power of two */
+	const char * const argv10[] = {prgname, eal_debug_logs, no_pci,
+			"--file-prefix=" memtest, in_memory, "--pagesz-mem=3M:6M"};
+
+	if (launch_proc(argv0) == 0) {
+		printf("Error (line %d) - process run ok with empty --pagesz-mem!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv1) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem missing colon!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv2) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem missing limit!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv3) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem unaligned limit!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv4) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv5) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem garbage value!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv6) == 0) {
+		printf("Error (line %d) - process run ok with --pagesz-mem and --no-huge!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv7) != 0) {
+		printf("Error (line %d) - process failed with valid --pagesz-mem!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv8) != 0) {
+		printf("Error (line %d) - process failed with multiple valid --pagesz-mem!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv9) != 0) {
+		printf("Error (line %d) - process failed with --pagesz-mem zero limit!\n",
+			__LINE__);
+		return -1;
+	}
+	if (launch_proc(argv10) == 0) {
+		printf("Error (line %d) - process run ok with non-power-of-two pagesz!\n",
+			__LINE__);
+		return -1;
+	}
+
+	return 0;
+#endif /* !RTE_EXEC_ENV_FREEBSD */
+}
+
 /*
  * Tests for correct handling of -m and --socket-mem flags
  */
@@ -1683,5 +1808,6 @@ REGISTER_FAST_TEST(eal_flags_b_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invali
 REGISTER_FAST_TEST(eal_flags_vdev_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_vdev_flag);
 REGISTER_FAST_TEST(eal_flags_r_opt_autotest, NOHUGE_SKIP, ASAN_SKIP, test_invalid_r_flag);
 REGISTER_FAST_TEST(eal_flags_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_memory_flags);
+REGISTER_FAST_TEST(eal_flags_pagesz_mem_autotest, NOHUGE_SKIP, ASAN_SKIP, test_pagesz_mem_flags);
 REGISTER_FAST_TEST(eal_flags_file_prefix_autotest, NOHUGE_SKIP, ASAN_SKIP, test_file_prefix);
 REGISTER_FAST_TEST(eal_flags_misc_autotest, NOHUGE_SKIP, ASAN_SKIP, test_misc_flags);
diff --git a/doc/guides/linux_gsg/linux_eal_parameters.rst b/doc/guides/linux_gsg/linux_eal_parameters.rst
index 7c5b26ce26..ce38dd128a 100644
--- a/doc/guides/linux_gsg/linux_eal_parameters.rst
+++ b/doc/guides/linux_gsg/linux_eal_parameters.rst
@@ -75,6 +75,19 @@ Memory-related options
     Place a per-NUMA node upper limit on memory use (non-legacy memory mode only).
     0 will disable the limit for a particular NUMA node.
 
+*   ``--pagesz-mem <page size:limit>``
+
+    Set memory limit per hugepage size.
+    Each time the option is used, provide a single ``<pagesz>:<limit>`` pair;
+    repeat the option to specify additional page sizes.
+    Both values support K/M/G/T suffixes (for example ``2M:32G``).
+
+    The memory limit must be a multiple of page size.
+
+    For example::
+
+        --pagesz-mem 2M:32G --pagesz-mem 1G:512G
+
 *   ``--single-file-segments``
 
     Create fewer files in hugetlbfs (non-legacy mode only).
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 63e0568afa..e2adf0a184 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -204,13 +204,36 @@ of virtual memory being preallocated at startup by editing the following config
 variables:
 
 * ``RTE_MAX_MEMSEG_LISTS`` controls how many segment lists can DPDK have
-* ``RTE_MAX_MEMSEG_PER_TYPE`` controls how many segments each memory type
+* ``RTE_MAX_MEMSEG_PER_TYPE`` sets the default number of segments each memory type
   can have (where "type" is defined as "page size + NUMA node" combination)
-* ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
+* ``RTE_MAX_MEM_MB_PER_TYPE`` sets the default amount of memory each
   memory type can address
 
 Normally, these options do not need to be changed.
 
+Runtime Override of Per-Page-Size Memory Limits
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+By default, DPDK uses compile-time configured limits for memory allocation per page size
+(as set by ``RTE_MAX_MEM_MB_PER_TYPE``).
+These limits apply uniformly across all NUMA nodes for a given page size.
+
+It is possible to override these defaults at runtime using the ``--pagesz-mem`` option,
+which allows specifying custom memory limits for each page size. This is useful when:
+
+* The default limits may be insufficient or excessive for your workload
+* You want to dedicate more memory to specific page sizes
+
+The ``--pagesz-mem`` option accepts exactly one ``<pagesz>:<limit>`` pair per
+occurrence, where ``pagesz`` is a page size (e.g., ``2M``, ``4M``, ``1G``)
+and ``limit`` is the maximum memory to reserve for that page size (e.g., ``64G``, ``512M``).
+Both values support standard binary suffixes (K, M, G, T).
+Memory limits must be aligned to their corresponding page size.
+
+Multiple page sizes can be specified by repeating the option::
+
+  --pagesz-mem 2M:64G --pagesz-mem 1G:512G
+
 .. note::
 
     Preallocated virtual memory is not to be confused with preallocated hugepage
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index c33fbdea6d..7096f46ff3 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -127,6 +127,11 @@ eal_dynmem_memseg_lists_init(void)
 		mem_va_len += type->mem_sz;
 	}
 
+	if (mem_va_len == 0) {
+		EAL_LOG(ERR, "No virtual memory will be reserved");
+		goto out;
+	}
+
 	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
 			mem_va_page_sz, 0, 0);
 	if (mem_va_addr == NULL) {
@@ -141,6 +146,10 @@ eal_dynmem_memseg_lists_init(void)
 		uint64_t pagesz;
 		int socket_id;
 
+		/* skip page sizes with zero memory limit */
+		if (type->n_segs == 0)
+			continue;
+
 		pagesz = type->page_sz;
 		socket_id = type->socket_id;
 
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index bbc4427524..0532d27aaa 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -21,6 +21,7 @@
 #endif
 
 #include <rte_string_fns.h>
+#include <rte_common.h>
 #include <rte_eal.h>
 #include <rte_log.h>
 #include <rte_lcore.h>
@@ -233,6 +234,20 @@ eal_collate_args(int argc, char **argv)
 		EAL_LOG(ERR, "Options allow (-a) and block (-b) can't be used at the same time");
 		return -1;
 	}
+#ifdef RTE_EXEC_ENV_FREEBSD
+	if (!TAILQ_EMPTY(&args.pagesz_mem)) {
+		EAL_LOG(ERR, "Option pagesz-mem is not supported on FreeBSD");
+		return -1;
+	}
+#endif
+	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.no_huge) {
+		EAL_LOG(ERR, "Options pagesz-mem and no-huge can't be used at the same time");
+		return -1;
+	}
+	if (!TAILQ_EMPTY(&args.pagesz_mem) && args.legacy_mem) {
+		EAL_LOG(ERR, "Options pagesz-mem and legacy-mem can't be used at the same time");
+		return -1;
+	}
 
 	/* for non-list args, we can just check for zero/null values using macro */
 	if (CONFLICTING_OPTIONS(args, coremask, lcores) ||
@@ -511,7 +526,10 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 				sizeof(internal_cfg->hugepage_info[0]));
 		internal_cfg->hugepage_info[i].lock_descriptor = -1;
 		internal_cfg->hugepage_mem_sz_limits[i] = 0;
+		internal_cfg->pagesz_mem_overrides[i].pagesz = 0;
+		internal_cfg->pagesz_mem_overrides[i].limit = 0;
 	}
+	internal_cfg->num_pagesz_mem_overrides = 0;
 	internal_cfg->base_virtaddr = 0;
 
 	/* if set to NONE, interrupt mode is determined automatically */
@@ -1867,6 +1885,96 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 	return 0;
 }
 
+static int
+eal_parse_pagesz_mem(char *strval, struct internal_config *internal_cfg)
+{
+	char strval_cpy[1024];
+	char *fields[3];
+	char *pagesz_str, *mem_str;
+	int arg_num;
+	int len;
+	unsigned int i;
+	uint64_t pagesz, mem_limit;
+	struct pagesz_mem_override *pmo;
+
+	len = strnlen(strval, 1024);
+	if (len >= 1024) {
+		EAL_LOG(ERR, "--pagesz-mem parameter is too long");
+		return -1;
+	}
+
+	rte_strlcpy(strval_cpy, strval, sizeof(strval_cpy));
+
+	/* parse exactly one pagesz:mem pair per --pagesz-mem option */
+	arg_num = rte_strsplit(strval_cpy, len, fields, RTE_DIM(fields), ':');
+	if (arg_num != 2 || fields[0][0] == '\0' || fields[1][0] == '\0') {
+		EAL_LOG(ERR, "--pagesz-mem parameter format is invalid, expected <pagesz>:<limit>");
+		return -1;
+	}
+	pagesz_str = fields[0];
+	mem_str = fields[1];
+
+	/* reject accidental multiple pairs in one option */
+	if (strchr(mem_str, ',') != NULL) {
+		EAL_LOG(ERR, "--pagesz-mem accepts one <pagesz>:<limit> pair per option");
+		return -1;
+	}
+
+	/* parse page size */
+	errno = 0;
+	pagesz = rte_str_to_size(pagesz_str);
+	if (pagesz == 0 || errno != 0) {
+		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s'", pagesz_str);
+		return -1;
+	}
+	if (!rte_is_power_of_2(pagesz)) {
+		EAL_LOG(ERR, "invalid page size in --pagesz-mem: '%s' (must be a power of two)",
+			pagesz_str);
+		return -1;
+	}
+
+	/* parse memory limit (0 is valid: disables allocation for this page size) */
+	errno = 0;
+	mem_limit = rte_str_to_size(mem_str);
+	if (errno != 0) {
+		EAL_LOG(ERR, "invalid memory limit in --pagesz-mem: '%s'", mem_str);
+		return -1;
+	}
+
+	/* validate alignment: memory limit must be divisible by page size */
+	if (mem_limit % pagesz != 0) {
+		EAL_LOG(ERR, "--pagesz-mem memory limit must be aligned to page size");
+		return -1;
+	}
+
+	for (i = 0; i < internal_cfg->num_pagesz_mem_overrides; i++) {
+		pmo = &internal_cfg->pagesz_mem_overrides[i];
+		if (pmo->pagesz != pagesz)
+			continue;
+
+		EAL_LOG(WARNING,
+			"--pagesz-mem specified multiple times for page size '%s'; later limit '%s' will be used",
+			pagesz_str, mem_str);
+		pmo->limit = mem_limit;
+		return 0;
+	}
+
+	/* do we have space? */
+	if (internal_cfg->num_pagesz_mem_overrides >= MAX_HUGEPAGE_SIZES) {
+		EAL_LOG(ERR,
+			"--pagesz-mem: too many page size entries (max %d)",
+			MAX_HUGEPAGE_SIZES);
+		return -1;
+	}
+
+	pmo = &internal_cfg->pagesz_mem_overrides[internal_cfg->num_pagesz_mem_overrides];
+	pmo->pagesz = pagesz;
+	pmo->limit = mem_limit;
+	internal_cfg->num_pagesz_mem_overrides++;
+
+	return 0;
+}
+
 static int
 eal_parse_vfio_intr(const char *mode)
 {
@@ -2172,6 +2280,12 @@ eal_parse_args(void)
 		}
 		int_cfg->force_numa_limits = 1;
 	}
+	TAILQ_FOREACH(arg, &args.pagesz_mem, next) {
+		if (eal_parse_pagesz_mem(arg->arg, int_cfg) < 0) {
+			EAL_LOG(ERR, "invalid pagesz-mem parameter: '%s'", arg->arg);
+			return -1;
+		}
+	}
 
 	/* tracing settings, not supported on windows */
 #ifdef RTE_EXEC_ENV_WINDOWS
@@ -2366,6 +2480,7 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
 	unsigned int i;
 
 	for (i = 0; i < internal_cfg->num_hugepage_sizes; i++) {
+		unsigned int j;
 		const uint64_t pagesz = internal_cfg->hugepage_info[i].hugepage_sz;
 		uint64_t limit;
 
@@ -2373,6 +2488,12 @@ eal_apply_hugepage_mem_sz_limits(struct internal_config *internal_cfg)
 		limit = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
 				(uint64_t)RTE_MAX_MEMSEG_PER_TYPE * pagesz);
 
+		/* override with user value for matching page size */
+		for (j = 0; j < (unsigned int)internal_cfg->num_pagesz_mem_overrides; j++) {
+			if (internal_cfg->pagesz_mem_overrides[j].pagesz == pagesz)
+				limit = internal_cfg->pagesz_mem_overrides[j].limit;
+		}
+
 		internal_cfg->hugepage_mem_sz_limits[i] = limit;
 	}
 
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 0bf192c6e5..8475c87969 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -98,6 +98,12 @@ struct internal_config {
 	struct hugepage_info hugepage_info[MAX_HUGEPAGE_SIZES];
 	uint64_t hugepage_mem_sz_limits[MAX_HUGEPAGE_SIZES];
 	/**< default max memory per hugepage size */
+	/** storage for user-specified pagesz-mem overrides */
+	struct pagesz_mem_override {
+		uint64_t pagesz;   /**< page size in bytes */
+		uint64_t limit;    /**< memory limit in bytes */
+	} pagesz_mem_overrides[MAX_HUGEPAGE_SIZES];
+	unsigned int num_pagesz_mem_overrides;  /**< number of stored overrides */
 	enum rte_iova_mode iova_mode ;    /**< Set IOVA mode on this system  */
 	rte_cpuset_t ctrl_cpuset;         /**< cpuset for ctrl threads */
 	volatile unsigned int init_complete;
diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option_list.h
index abee16340b..164a0b3888 100644
--- a/lib/eal/common/eal_option_list.h
+++ b/lib/eal/common/eal_option_list.h
@@ -56,6 +56,7 @@ BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
 BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
 BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
 BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
+LIST_ARG("--pagesz-mem", NULL, "Memory allocation per hugepage size (format: <pagesz>:<limit>, e.g. 2M:32G). Repeat option for multiple page sizes.", pagesz_mem)
 STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
 OPT_STR_ARG("--remap-lcore-ids", "-R", "Remap lcore IDs to be contiguous starting from 0, or supplied value", remap_lcore_ids)
 STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
-- 
2.47.3

