Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B23CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3E6A427BE;
	Wed, 29 Apr 2026 18:59:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 678E8410F6;
 Wed, 29 Apr 2026 18:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481992; x=1809017992;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZjKSWaS7pNThJ+QfSh7H6gS08JQHYz3fcmaa7jR2IT4=;
 b=QySzN7wvoK/nfBFfa5UYKUxJWfl4Kn4dvLNb1KvKdMOOy/Kql8KKXX1a
 0OLrAWgg1NiP/IGFab6FfvNjz6EQJ+zNtrgOFaR/3uxy5wIm+yM5rj/xh
 5U0gZ/KuLjJr6U+i1Am97ipmhe3Xbqxb/2i+q/pHgZDp1lBq25Ld7/3YB
 MU07Nidf4Bm3bDhgdKMSNIFBGn/2yTHlcisssYnY1ibj0m07fHV747glF
 vMQzoIuhHEr8s60hAVlgcqLA2EK0mGlhKoGf94PwaiIluFVofzlwaAbDr
 ah0TqX1TZfSPxA01sI6jJ9TFe4Rlau+KnalIVQIcOihK3fkWyvUt1Cs39 w==;
X-CSE-ConnectionGUID: R68dZ2kDRaGRCwP+HfJRBw==
X-CSE-MsgGUID: TFROYJALRVuLgeTkQdnFaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725412"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725412"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:52 -0700
X-CSE-ConnectionGUID: h7VdeyXnQsGeKtVhW/jfsg==
X-CSE-MsgGUID: nizx/FD6Tiu8UVHwD3pDcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697250"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 41/44] eal_cfg: add hugepage memory configuration
Date: Wed, 29 Apr 2026 17:58:33 +0100
Message-ID: <20260429165845.2136843-42-bruce.richardson@intel.com>
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

Add support for options to do with hugepage memory configuration, such
as the hugepage directory to use, and when to cleanup hugepage files. As
part of this, also update the in-memory setting to match the effect of
the in-memory setting from the commandline.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_cfg.c   | 231 ++++++++++++++++++++++++++++++++++++++
 lib/eal_cfg/eal_cfg.c     | 143 ++++++++++++++++++++++-
 lib/eal_cfg/rte_eal_cfg.h | 126 +++++++++++++++++++--
 3 files changed, 489 insertions(+), 11 deletions(-)

diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
index 4424c42533..8b90afefac 100644
--- a/app/test/test_eal_cfg.c
+++ b/app/test/test_eal_cfg.c
@@ -13,6 +13,9 @@
 
 #include <rte_eal_cfg.h>
 #include <stdlib.h>
+#include <string.h>
+
+#include "eal_internal_cfg.h"
 
 #include "test.h"
 
@@ -498,6 +501,230 @@ test_eal_cfg_numa_limit(void)
 	return TEST_SUCCESS;
 }
 
+/* Test hugefile_prefix: NULL cfg, empty, '%' char, valid, overwrite. */
+static int
+test_eal_cfg_hugefile_prefix(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_hugefile_prefix(NULL, "pfx") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_hugefile_prefix(NULL) == NULL,
+		"Expected NULL from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* default is NULL (unset) */
+	TEST_ASSERT(rte_eal_cfg_get_hugefile_prefix(cfg) == NULL,
+		"Expected default hugefile_prefix == NULL");
+
+	/* empty string rejected */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_hugefile_prefix(cfg, "") == -1,
+		"Expected -1 for empty prefix");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty prefix, got %d", rte_errno);
+
+	/* '%' character rejected */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_hugefile_prefix(cfg, "bad%prefix") == -1,
+		"Expected -1 for prefix containing '%%'");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for '%%' in prefix, got %d", rte_errno);
+
+	/* valid prefix */
+	TEST_ASSERT(rte_eal_cfg_set_hugefile_prefix(cfg, "myapp") == 0,
+		"Expected 0 for valid prefix");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_hugefile_prefix(cfg), "myapp") == 0,
+		"get_hugefile_prefix returned wrong value");
+
+	/* overwrite: getter must reflect the new value */
+	TEST_ASSERT(rte_eal_cfg_set_hugefile_prefix(cfg, "newpfx") == 0,
+		"Expected 0 overwriting prefix");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_hugefile_prefix(cfg), "newpfx") == 0,
+		"get_hugefile_prefix did not reflect overwritten value");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test hugepage_dir: NULL cfg, empty string, non-hugetlbfs path, valid hugetlbfs path. */
+static int
+test_eal_cfg_hugepage_dir(void)
+{
+	struct rte_eal_cfg *cfg;
+	const struct eal_platform_info *pi;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_hugepage_dir(NULL, "/mnt/huge") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_hugepage_dir(NULL) == NULL,
+		"Expected NULL from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* default is NULL (unset) */
+	TEST_ASSERT(rte_eal_cfg_get_hugepage_dir(cfg) == NULL,
+		"Expected default hugepage_dir == NULL");
+
+	/* empty string rejected */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_hugepage_dir(cfg, "") == -1,
+		"Expected -1 for empty dir");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty dir, got %d", rte_errno);
+
+	/* Tests gated on platform having hugepage mount points */
+	pi = rte_eal_get_platform_info();
+	if (pi != NULL && pi->num_hugepage_sizes > 0 &&
+			pi->hugepage_sizes[0].dir[0] != '\0') {
+		const char *valid_dir = pi->hugepage_sizes[0].dir;
+
+		/* positive test: valid hugetlbfs mount point must succeed */
+		TEST_ASSERT(rte_eal_cfg_set_hugepage_dir(cfg, valid_dir) == 0,
+			"Expected 0 for valid hugetlbfs dir '%s'", valid_dir);
+		TEST_ASSERT(strcmp(rte_eal_cfg_get_hugepage_dir(cfg), valid_dir) == 0,
+			"get_hugepage_dir returned wrong value");
+
+		/* overwrite with same valid dir */
+		TEST_ASSERT(rte_eal_cfg_set_hugepage_dir(cfg, valid_dir) == 0,
+			"Expected 0 overwriting with same dir");
+		TEST_ASSERT(strcmp(rte_eal_cfg_get_hugepage_dir(cfg), valid_dir) == 0,
+			"get_hugepage_dir did not reflect overwritten value");
+
+		/* negative test: "/" is never a hugetlbfs mount point */
+		rte_errno = 0;
+		TEST_ASSERT(rte_eal_cfg_set_hugepage_dir(cfg, "/") == -1,
+			"Expected -1 for non-hugetlbfs dir '/'");
+		TEST_ASSERT(rte_errno == ENODEV,
+			"Expected ENODEV for non-hugetlbfs '/', got errno=%d", rte_errno);
+	} else {
+		printf("  Skipping hugetlbfs dir tests: no hugepage mount points discovered\n");
+	}
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test huge_unlink: NULL cfg, default, all valid modes, invalid value. */
+static int
+test_eal_cfg_huge_unlink(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_huge_unlink(NULL, RTE_EAL_HUGE_UNLINK_ALWAYS) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_huge_unlink(NULL) == RTE_EAL_HUGE_UNLINK_EXISTING,
+		"Expected EXISTING from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* default */
+	TEST_ASSERT(rte_eal_cfg_get_huge_unlink(cfg) == RTE_EAL_HUGE_UNLINK_EXISTING,
+		"Expected default huge_unlink == EXISTING");
+
+	/* all three valid modes roundtrip */
+	static const enum rte_eal_huge_unlink valid[] = {
+		RTE_EAL_HUGE_UNLINK_EXISTING,
+		RTE_EAL_HUGE_UNLINK_ALWAYS,
+		RTE_EAL_HUGE_UNLINK_NEVER,
+	};
+	for (size_t i = 0; i < RTE_DIM(valid); i++) {
+		TEST_ASSERT(rte_eal_cfg_set_huge_unlink(cfg, valid[i]) == 0,
+			"Expected 0 for huge_unlink mode %d", (int)valid[i]);
+		TEST_ASSERT(rte_eal_cfg_get_huge_unlink(cfg) == valid[i],
+			"get returned wrong value for huge_unlink mode %d", (int)valid[i]);
+	}
+
+	/* invalid enum value */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_huge_unlink(cfg, (enum rte_eal_huge_unlink)99) == -1,
+		"Expected -1 for invalid huge_unlink mode");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for invalid mode, got %d", rte_errno);
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test in_memory setter side-effects: enabling it must also set no_shconf
+ * and flip huge_unlink to ALWAYS; disabling it must not reverse those.
+ */
+static int
+test_eal_cfg_in_memory(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_in_memory(NULL, true) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_in_memory(NULL) == false,
+		"Expected false from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* defaults */
+	TEST_ASSERT(rte_eal_cfg_get_in_memory(cfg) == true,
+		"Expected default in_memory == true (set by rte_eal_cfg_create)");
+
+	/* reset to false to test the set-true side-effects cleanly */
+	TEST_ASSERT(rte_eal_cfg_set_no_shconf(cfg, false) == 0,
+		"Failed to reset no_shconf");
+	TEST_ASSERT(rte_eal_cfg_set_huge_unlink(cfg, RTE_EAL_HUGE_UNLINK_EXISTING) == 0,
+		"Failed to reset huge_unlink");
+	TEST_ASSERT(rte_eal_cfg_set_in_memory(cfg, false) == 0,
+		"Failed to set in_memory = false");
+
+	TEST_ASSERT(rte_eal_cfg_get_in_memory(cfg) == false,
+		"Expected in_memory == false after reset");
+	TEST_ASSERT(rte_eal_cfg_get_no_shconf(cfg) == false,
+		"Expected no_shconf == false after reset");
+	TEST_ASSERT(rte_eal_cfg_get_huge_unlink(cfg) == RTE_EAL_HUGE_UNLINK_EXISTING,
+		"Expected huge_unlink == EXISTING after reset");
+
+	/* set in_memory = true: must pull no_shconf and huge_unlink with it */
+	TEST_ASSERT(rte_eal_cfg_set_in_memory(cfg, true) == 0,
+		"Expected 0 setting in_memory = true");
+	TEST_ASSERT(rte_eal_cfg_get_in_memory(cfg) == true,
+		"Expected in_memory == true after set");
+	TEST_ASSERT(rte_eal_cfg_get_no_shconf(cfg) == true,
+		"Expected no_shconf == true after in_memory = true");
+	TEST_ASSERT(rte_eal_cfg_get_huge_unlink(cfg) == RTE_EAL_HUGE_UNLINK_ALWAYS,
+		"Expected huge_unlink == ALWAYS after in_memory = true");
+
+	/* set in_memory = false: side-effects are NOT reversed */
+	TEST_ASSERT(rte_eal_cfg_set_in_memory(cfg, false) == 0,
+		"Expected 0 setting in_memory = false");
+	TEST_ASSERT(rte_eal_cfg_get_in_memory(cfg) == false,
+		"Expected in_memory == false after clear");
+	TEST_ASSERT(rte_eal_cfg_get_no_shconf(cfg) == true,
+		"Expected no_shconf to remain true after in_memory cleared");
+	TEST_ASSERT(rte_eal_cfg_get_huge_unlink(cfg) == RTE_EAL_HUGE_UNLINK_ALWAYS,
+		"Expected huge_unlink to remain ALWAYS after in_memory cleared");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite eal_cfg_testsuite = {
 	.suite_name = "EAL cfg API tests",
 	.setup = NULL,
@@ -511,6 +738,10 @@ static struct unit_test_suite eal_cfg_testsuite = {
 		TEST_CASE(test_eal_cfg_process_type),
 		TEST_CASE(test_eal_cfg_numa_mem),
 		TEST_CASE(test_eal_cfg_numa_limit),
+		TEST_CASE(test_eal_cfg_hugefile_prefix),
+		TEST_CASE(test_eal_cfg_hugepage_dir),
+		TEST_CASE(test_eal_cfg_huge_unlink),
+		TEST_CASE(test_eal_cfg_in_memory),
 		TEST_CASES_END()
 	}
 };
diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
index ce3be8201b..3e3e6bfb59 100644
--- a/lib/eal_cfg/eal_cfg.c
+++ b/lib/eal_cfg/eal_cfg.c
@@ -5,6 +5,12 @@
 #include <errno.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
+
+#ifdef RTE_EXEC_ENV_LINUX
+#include <sys/vfs.h>
+#include <linux/magic.h>
+#endif
 
 #include <eal_export.h>
 #include <rte_bitops.h>
@@ -119,9 +125,6 @@ EAL_CFG_BOOL(vmware_tsc_map)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_no_shconf, 26.07)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_no_shconf, 26.07)
 EAL_CFG_BOOL(no_shconf)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_in_memory, 26.07)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_in_memory, 26.07)
-EAL_CFG_BOOL(in_memory)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_create_uio_dev, 26.07)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_create_uio_dev, 26.07)
 EAL_CFG_BOOL(create_uio_dev)
@@ -287,6 +290,28 @@ rte_eal_cfg_get_max_simd_bitwidth(const struct rte_eal_cfg *cfg)
 	return cfg->user_cfg.max_simd_bitwidth.bitwidth;
 }
 
+/*
+ * Check that @dir is a hugetlbfs mount point.
+ *
+ * Uses statfs(2) on Linux to verify the filesystem type.  On non-Linux
+ * platforms where this check is not available, the function always returns
+ * true (permissive fallback — EAL will catch the error at init time).
+ */
+static bool
+hugedir_is_hugetlbfs(const char *dir)
+{
+#ifdef RTE_EXEC_ENV_LINUX
+	struct statfs sfs;
+
+	if (statfs(dir, &sfs) != 0)
+		return false;
+	return (uint32_t)sfs.f_type == HUGETLBFS_MAGIC;
+#else
+	(void)dir;
+	return true;
+#endif
+}
+
 /*
  * Check that @node is a NUMA node ID that actually exists on this system.
  *
@@ -399,6 +424,118 @@ rte_eal_cfg_get_memory(const struct rte_eal_cfg *cfg)
 	return (size_t)total;
 }
 
+/* --- Hugepage configuration --- */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_hugefile_prefix, 26.07)
+int
+rte_eal_cfg_set_hugefile_prefix(struct rte_eal_cfg *cfg, const char *prefix)
+{
+	char *copy;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+	if (prefix == NULL || prefix[0] == '\0' || strchr(prefix, '%') != NULL) {
+		EAL_CFG_LOG(ERR, "%s: invalid hugefile prefix", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+	copy = strdup(prefix);
+	if (copy == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	free(cfg->user_cfg.hugefile_prefix);
+	cfg->user_cfg.hugefile_prefix = copy;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_hugefile_prefix, 26.07)
+EAL_CFG_GETTER(const char *, hugefile_prefix, NULL)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_hugepage_dir, 26.07)
+int
+rte_eal_cfg_set_hugepage_dir(struct rte_eal_cfg *cfg, const char *dir)
+{
+	char *copy;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+	if (dir == NULL || dir[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: invalid hugepage dir", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+	if (!hugedir_is_hugetlbfs(dir)) {
+		EAL_CFG_LOG(ERR, "%s: '%s' is not a hugetlbfs mount point", __func__, dir);
+		rte_errno = ENODEV;
+		return -1;
+	}
+	copy = strdup(dir);
+	if (copy == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	free(cfg->user_cfg.hugepage_dir);
+	cfg->user_cfg.hugepage_dir = copy;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_hugepage_dir, 26.07)
+EAL_CFG_GETTER(const char *, hugepage_dir, NULL)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_huge_unlink, 26.07)
+int
+rte_eal_cfg_set_huge_unlink(struct rte_eal_cfg *cfg, enum rte_eal_huge_unlink mode)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+	switch (mode) {
+	case RTE_EAL_HUGE_UNLINK_EXISTING:
+		cfg->user_cfg.hugepage_file.unlink_existing = true;
+		cfg->user_cfg.hugepage_file.unlink_before_mapping = false;
+		break;
+	case RTE_EAL_HUGE_UNLINK_ALWAYS:
+		cfg->user_cfg.hugepage_file.unlink_existing = true;
+		cfg->user_cfg.hugepage_file.unlink_before_mapping = true;
+		break;
+	case RTE_EAL_HUGE_UNLINK_NEVER:
+		cfg->user_cfg.hugepage_file.unlink_existing = false;
+		cfg->user_cfg.hugepage_file.unlink_before_mapping = false;
+		break;
+	default:
+		EAL_CFG_LOG(ERR, "%s: invalid huge_unlink mode %d", __func__, (int)mode);
+		rte_errno = EINVAL;
+		return -1;
+	}
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_huge_unlink, 26.07)
+enum rte_eal_huge_unlink
+rte_eal_cfg_get_huge_unlink(const struct rte_eal_cfg *cfg)
+{
+	if (cfg == NULL)
+		return RTE_EAL_HUGE_UNLINK_EXISTING;
+	if (cfg->user_cfg.hugepage_file.unlink_before_mapping)
+		return RTE_EAL_HUGE_UNLINK_ALWAYS;
+	if (!cfg->user_cfg.hugepage_file.unlink_existing)
+		return RTE_EAL_HUGE_UNLINK_NEVER;
+	return RTE_EAL_HUGE_UNLINK_EXISTING;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_in_memory, 26.07)
+int
+rte_eal_cfg_set_in_memory(struct rte_eal_cfg *cfg, bool val)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+	cfg->user_cfg.in_memory = val;
+	if (val) {
+		/* in-memory is a superset of no_shconf and huge-unlink=always */
+		cfg->user_cfg.no_shconf = true;
+		cfg->user_cfg.hugepage_file.unlink_before_mapping = true;
+	}
+	return 0;
+}
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_in_memory, 26.07)
+EAL_CFG_GETTER(bool, in_memory, false)
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcores_from_affinity, 26.07)
 int
 rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap)
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
index 1ffdcffa49..59eacfe64d 100644
--- a/lib/eal_cfg/rte_eal_cfg.h
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -27,6 +27,21 @@ extern "C" {
 #include <rte_eal.h>
 #include <rte_pci_dev_feature_defs.h>
 
+/**
+ * Hugepage file unlink behaviour (equivalent to --huge-unlink).
+ */
+enum rte_eal_huge_unlink {
+	/** Remove stale hugepage files at startup; keep newly created files (default). */
+	RTE_EAL_HUGE_UNLINK_EXISTING = 0,
+	/**
+	 * Unlink hugepage files immediately before mapping, leaving no trace in hugetlbfs.
+	 * Equivalent to --huge-unlink or --huge-unlink=always.
+	 */
+	RTE_EAL_HUGE_UNLINK_ALWAYS,
+	/** Never unlink hugepage files. May leave stale files on abnormal exit (warns). */
+	RTE_EAL_HUGE_UNLINK_NEVER,
+};
+
 /**
  * Opaque EAL configuration handle.
  */
@@ -111,14 +126,6 @@ __rte_experimental
 bool
 rte_eal_cfg_get_no_shconf(const struct rte_eal_cfg *cfg);
 
-/** Run without any shared runtime files (equivalent to --in-memory). */
-__rte_experimental
-int
-rte_eal_cfg_set_in_memory(struct rte_eal_cfg *cfg, bool val);
-__rte_experimental
-bool
-rte_eal_cfg_get_in_memory(const struct rte_eal_cfg *cfg);
-
 /** Create /dev/uioX devices (equivalent to --create-uio-dev). */
 __rte_experimental
 int
@@ -367,6 +374,109 @@ size_t
 rte_eal_cfg_get_memory(const struct rte_eal_cfg *cfg);
 /** @} */
 
+/**
+ * @name Hugepage configuration
+ * @{
+ */
+/**
+ * Set the hugetlbfs file prefix (equivalent to --file-prefix).
+ *
+ * Overrides the base name used for hugepage backing files and runtime
+ * directory. Allows multiple independent DPDK processes to coexist on
+ * the same system without sharing hugepage files.
+ *
+ * @param cfg     Configuration handle. Must not be NULL.
+ * @param prefix  File prefix string. Must not be NULL or empty and must
+ *                not contain the '%' character.
+ * @return 0 on success, -1 with rte_errno set to EINVAL or ENOMEM on error.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_hugefile_prefix(struct rte_eal_cfg *cfg, const char *prefix);
+/**
+ * Get the configured hugetlbfs file prefix.
+ *
+ * @param cfg  Configuration handle.
+ * @return Pointer to the prefix string, or NULL if not set or cfg is NULL.
+ *         The returned pointer is valid until the next call to
+ *         rte_eal_cfg_set_hugefile_prefix() or rte_eal_cfg_free().
+ */
+__rte_experimental
+const char *
+rte_eal_cfg_get_hugefile_prefix(const struct rte_eal_cfg *cfg);
+
+/**
+ * Set the hugetlbfs mount directory (equivalent to --huge-dir).
+ *
+ * @param cfg  Configuration handle. Must not be NULL.
+ * @param dir  Path to a hugetlbfs mount point. Must not be NULL or empty, and
+ *             must refer to a directory that is actually mounted as hugetlbfs
+ *             on the current system.
+ * @return 0 on success, -1 with rte_errno set to EINVAL if cfg is NULL or
+ *         the path is empty; ENODEV if the path is not a hugetlbfs mount;
+ *         ENOMEM on allocation failure.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_hugepage_dir(struct rte_eal_cfg *cfg, const char *dir);
+/**
+ * Get the configured hugetlbfs directory.
+ *
+ * @param cfg  Configuration handle.
+ * @return Pointer to the directory string, or NULL if not set or cfg is NULL.
+ *         The returned pointer is valid until the next call to
+ *         rte_eal_cfg_set_hugepage_dir() or rte_eal_cfg_free().
+ */
+__rte_experimental
+const char *
+rte_eal_cfg_get_hugepage_dir(const struct rte_eal_cfg *cfg);
+
+/**
+ * Set the hugepage file unlink behaviour (equivalent to --huge-unlink).
+ *
+ * Controls when hugepage backing files are removed:
+ *   - RTE_EAL_HUGE_UNLINK_EXISTING (default): remove stale files at startup,
+ *     keep newly created files.
+ *   - RTE_EAL_HUGE_UNLINK_ALWAYS: unlink files immediately before mapping,
+ *     leaving no trace in hugetlbfs.
+ *   - RTE_EAL_HUGE_UNLINK_NEVER: never remove any hugepage files. This may
+ *     leave stale files on abnormal exit and is logged as a warning at init.
+ *
+ * @param cfg   Configuration handle. Must not be NULL.
+ * @param mode  Unlink mode.
+ * @return 0 on success, -1 with rte_errno set to EINVAL on error.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_huge_unlink(struct rte_eal_cfg *cfg, enum rte_eal_huge_unlink mode);
+/**
+ * Get the configured hugepage file unlink behaviour.
+ *
+ * @param cfg  Configuration handle.
+ * @return The configured mode, or RTE_EAL_HUGE_UNLINK_EXISTING if cfg is NULL.
+ */
+__rte_experimental
+enum rte_eal_huge_unlink
+rte_eal_cfg_get_huge_unlink(const struct rte_eal_cfg *cfg);
+
+/**
+ * Run without any shared runtime files (equivalent to --in-memory).
+ *
+ * NOTE: as with the command-line option, this implies no_shconf and huge-unlink=always.
+ * Passing "true" will therefore set both no_shconf and huge-unlink=always to true.
+ *
+ * @param cfg  Configuration handle. Must not be NULL.
+ * @param val  true to enable in-memory mode.
+ * @return 0 on success, -1 with rte_errno set to EINVAL if cfg is NULL.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_in_memory(struct rte_eal_cfg *cfg, bool val);
+__rte_experimental
+bool
+rte_eal_cfg_get_in_memory(const struct rte_eal_cfg *cfg);
+/** @} */
+
 /**
  * Populate lcore configuration from the calling thread's CPU affinity.
  *
-- 
2.51.0

