Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF4FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D678415D7;
	Wed, 29 Apr 2026 18:59:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id AB28340B8F;
 Wed, 29 Apr 2026 18:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481994; x=1809017994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IPb9m6ocOCFY3RbV9mBaz1FO5AaO+ZlM2VgjbLefZ68=;
 b=X64oCavr2ef4YVds2ZTJBVdFaxHCcUr5ureuloasvvtms86W+bdQPfgu
 FwueENEznbV+/FPIrgDYd/LE1RIQJKLJfRhAGSVm4tY+iLW+INPnuxQf7
 cyu/5LR1oAJZ43nhr9vCgJ9iGZJecicSXrnMo0MbKITX9ecFTrGLbhB3b
 rIHe5Jfkg0YLy6PZtR1154C6FOOcEDN1OQnD0Sn1gI2YV1hGLrMQpOPS4
 n6CwA0PvhDFV8oHmzWOB5MmH2SDuTCukShEh0IOwBK9v+qg/rUuU1+GNA
 voYhS8PmQWn3Jolg4WLGXrDf0kI/r5JrZAZT3JjrhDXkx87VaAgVY5s+e Q==;
X-CSE-ConnectionGUID: 7/xXHmwGRiOb610ij2nLQA==
X-CSE-MsgGUID: J73Po/+3TG+3e4B7Bq5Qxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725414"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725414"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:53 -0700
X-CSE-ConnectionGUID: An+zOC2dQU6YpPvn9l19ww==
X-CSE-MsgGUID: mI4D1hQ8Qxab7ZuyGeT++w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697253"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:51 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 42/44] eal_cfg: support configuring lcores
Date: Wed, 29 Apr 2026 17:58:34 +0100
Message-ID: <20260429165845.2136843-43-bruce.richardson@intel.com>
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

Add functions to configure lcores and set them with a cpuset for what
physical CPUs to run upon. Also support marking certain cores as service
cores.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_cfg.c   | 235 ++++++++++++++++++++++++++++++++++++++
 lib/eal_cfg/eal_cfg.c     |  78 +++++++++++++
 lib/eal_cfg/rte_eal_cfg.h |  95 +++++++++++++++
 3 files changed, 408 insertions(+)

diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
index 8b90afefac..ceaa42260a 100644
--- a/app/test/test_eal_cfg.c
+++ b/app/test/test_eal_cfg.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2026 Intel Corporation
  */
 
+#include <time.h>
 #include <errno.h>
 #include <inttypes.h>
 
@@ -12,6 +13,7 @@
 #include <rte_vect.h>
 
 #include <rte_eal_cfg.h>
+#include <rte_thread.h>
 #include <stdlib.h>
 #include <string.h>
 
@@ -140,6 +142,101 @@ subtest_eal_cfg_init_null(void)
 	return TEST_SUCCESS;
 }
 
+/* Test that lcore cpusets configured via set_lcore are visible post-init. */
+static int
+subtest_eal_cfg_init_lcore_affinity(void)
+{
+	struct rte_eal_cfg *cfg;
+	const struct eal_platform_info *pi;
+	unsigned int all_cpus[CPU_SETSIZE];
+	unsigned int ncpus = 0;
+	unsigned int idx0, idx1;
+	rte_cpuset_t cs0, cs1;
+	int ret;
+
+	/*
+	 * Collect all platform-detected CPUs.  Picking from this list avoids
+	 * any dependency on the calling thread's CPU affinity, which in a
+	 * dpdk-test subprocess is typically pinned to a single CPU.
+	 */
+	pi = rte_eal_get_platform_info();
+	if (pi == NULL) {
+		printf("  Skipping: platform info unavailable\n");
+		return TEST_SUCCESS;
+	}
+	for (unsigned int i = 0; i < pi->cpu_count; i++) {
+		if (pi->cpu_info[i].detected)
+			all_cpus[ncpus++] = i;
+	}
+	if (ncpus < 2) {
+		printf("  Skipping: need at least 2 detected CPUs, found %u\n", ncpus);
+		return TEST_SUCCESS;
+	}
+
+	/* Pick two distinct CPUs at random. */
+	srand((unsigned int)time(NULL));
+	idx0 = (unsigned int)rand() % ncpus;
+	do {
+		idx1 = (unsigned int)rand() % ncpus;
+	} while (idx1 == idx0);
+
+	CPU_ZERO(&cs0);
+	CPU_SET(all_cpus[idx0], &cs0);
+	CPU_ZERO(&cs1);
+	CPU_SET(all_cpus[idx1], &cs1);
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/*
+	 * Pin lcore 0 to cs0 and lcore 1 to cs1.  Use lcore 1 as the main
+	 * lcore so we can verify the live thread affinity on the calling thread.
+	 */
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, &cs0, false) == 0,
+		"Failed to configure lcore 0");
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 1, &cs1, false) == 0,
+		"Failed to configure lcore 1");
+	TEST_ASSERT(rte_eal_cfg_set_main_lcore(cfg, 1) == 0,
+		"Failed to set main_lcore to 1");
+
+	ret = rte_eal_init_from_cfg("test_prog", cfg);
+	TEST_ASSERT(ret == 0,
+		"rte_eal_init_from_cfg failed: ret=%d rte_errno=%d", ret, rte_errno);
+
+	rte_eal_cfg_free(cfg);
+
+	/* Two lcores (0 and 1) should be active. */
+	TEST_ASSERT(rte_lcore_count() == 2,
+		"Expected lcore_count=2, got %u", rte_lcore_count());
+	TEST_ASSERT(rte_lcore_is_enabled(0),
+		"Expected lcore 0 to be enabled");
+	TEST_ASSERT(rte_lcore_is_enabled(1),
+		"Expected lcore 1 to be enabled");
+	TEST_ASSERT(!rte_lcore_is_enabled(2),
+		"Expected lcore 2 to be disabled");
+
+	/* Worker lcore 0: verify the stored cpuset matches configuration. */
+	rte_cpuset_t got0 = rte_lcore_cpuset(0);
+	TEST_ASSERT(CPU_EQUAL(&got0, &cs0),
+		"lcore 0 cpuset mismatch: expected CPU %u", all_cpus[idx0]);
+
+	/*
+	 * Main lcore 1: this is the current thread after init.  Verify both
+	 * that rte_lcore_id() identifies us as lcore 1 and that the actual
+	 * thread CPU affinity matches what we configured.
+	 */
+	TEST_ASSERT(rte_lcore_id() == 1,
+		"Expected rte_lcore_id()==1 on main thread, got %u", rte_lcore_id());
+	rte_cpuset_t live_affinity;
+	TEST_ASSERT(rte_thread_get_affinity_by_id(rte_thread_self(),
+			&live_affinity) == 0,
+		"Failed to get main thread affinity");
+	TEST_ASSERT(CPU_EQUAL(&live_affinity, &cs1),
+		"main lcore 1 live affinity mismatch: expected CPU %u", all_cpus[idx1]);
+
+	rte_eal_cleanup();
+	return TEST_SUCCESS;
+}
 /*
  * Test EAL initialisation from a default config in a fresh subprocess.
  * Called before rte_eal_init() so that it can exercise the very first call
@@ -157,6 +254,7 @@ test_eal_cfg_init(void)
 		TEST_CFG_FN(subtest_eal_cfg_init_null),
 		TEST_CFG_FN(subtest_eal_cfg_init_empty),
 		TEST_CFG_FN(subtest_eal_cfg_init_with_values),
+		TEST_CFG_FN(subtest_eal_cfg_init_lcore_affinity),
 		{ NULL, NULL }
 	};
 
@@ -725,6 +823,141 @@ test_eal_cfg_in_memory(void)
 	return TEST_SUCCESS;
 }
 
+#ifndef RTE_EXEC_ENV_WINDOWS  /* windows is missing the necessary macros for comparing CPUSETs etc. */
+/* Test set/get_lcore and set/is_service_lcore. */
+static int
+test_eal_cfg_lcore(void)
+{
+	struct rte_eal_cfg *cfg;
+	rte_cpuset_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_lcore(NULL, 0, &cpuset, false) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_lcore_cpuset(NULL, 0) == NULL,
+		"Expected NULL from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* lcore_id out of range */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, RTE_MAX_LCORE, &cpuset, false) == -1,
+		"Expected -1 for lcore_id == RTE_MAX_LCORE");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for out-of-range lcore_id, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_lcore_cpuset(cfg, RTE_MAX_LCORE) == NULL,
+		"Expected NULL from get with out-of-range lcore_id");
+
+	/* NULL cpuset */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, NULL, false) == -1,
+		"Expected -1 for NULL cpuset");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cpuset, got %d", rte_errno);
+
+	/* default: lcore 0 not yet configured */
+	TEST_ASSERT(rte_eal_cfg_get_lcore_cpuset(cfg, 0) == NULL,
+		"Expected default lcore 0 cpuset to be NULL");
+
+	/* first set: replace=false, slot is empty, must succeed */
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, &cpuset, false) == 0,
+		"Expected 0 for first set of lcore 0");
+	TEST_ASSERT(rte_eal_cfg_get_lcore_cpuset(cfg, 0) != NULL,
+		"Expected non-NULL cpuset after set");
+	TEST_ASSERT(CPU_EQUAL(rte_eal_cfg_get_lcore_cpuset(cfg, 0), &cpuset),
+		"Expected cpuset to match what was set");
+
+	/* second set with replace=false must fail */
+	rte_cpuset_t cpuset2;
+	CPU_ZERO(&cpuset2);
+	CPU_SET(1, &cpuset2);
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, &cpuset2, false) == -1,
+		"Expected -1 when replace=false and lcore already set");
+	TEST_ASSERT(rte_errno == EEXIST,
+		"Expected EEXIST, got %d", rte_errno);
+
+	/* second set with replace=true must succeed and update cpuset */
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, &cpuset2, true) == 0,
+		"Expected 0 for replace=true");
+	TEST_ASSERT(CPU_EQUAL(rte_eal_cfg_get_lcore_cpuset(cfg, 0), &cpuset2),
+		"Expected cpuset to be updated after replace");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test set_service_lcore and is_service_lcore. */
+static int
+test_eal_cfg_service_lcore(void)
+{
+	struct rte_eal_cfg *cfg;
+	rte_cpuset_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_service_lcore(NULL, 0) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_is_service_lcore(NULL, 0) == false,
+		"Expected false from is_service_lcore with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* lcore_id out of range */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_service_lcore(cfg, RTE_MAX_LCORE) == -1,
+		"Expected -1 for lcore_id == RTE_MAX_LCORE");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for out-of-range lcore_id, got %d", rte_errno);
+
+	/* lcore not yet configured: must fail with ENOENT */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_service_lcore(cfg, 0) == -1,
+		"Expected -1 for unconfigured lcore");
+	TEST_ASSERT(rte_errno == ENOENT,
+		"Expected ENOENT for unconfigured lcore, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_is_service_lcore(cfg, 0) == false,
+		"Expected false before service lcore is set");
+
+	/* configure the lcore first, then designate as service */
+	TEST_ASSERT(rte_eal_cfg_set_lcore(cfg, 0, &cpuset, false) == 0,
+		"Expected 0 setting up lcore 0");
+	TEST_ASSERT(rte_eal_cfg_set_service_lcore(cfg, 0) == 0,
+		"Expected 0 designating lcore 0 as service");
+	TEST_ASSERT(rte_eal_cfg_is_service_lcore(cfg, 0) == true,
+		"Expected is_service_lcore to return true after set");
+
+	/* second call is idempotent */
+	TEST_ASSERT(rte_eal_cfg_set_service_lcore(cfg, 0) == 0,
+		"Expected 0 on repeated set_service_lcore");
+	TEST_ASSERT(rte_eal_cfg_is_service_lcore(cfg, 0) == true,
+		"Expected is_service_lcore still true after repeated set");
+
+	/* a different lcore that was not configured is not a service lcore */
+	TEST_ASSERT(rte_eal_cfg_is_service_lcore(cfg, 1) == false,
+		"Expected false for unconfigured lcore 1");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+#else
+static int test_eal_cfg_lcore(void) { return TEST_SUCCESS; }
+static int test_eal_cfg_service_lcore(void) { return TEST_SUCCESS; }
+#endif /* RTE_EXEC_ENV_WINDOWS */
+
 static struct unit_test_suite eal_cfg_testsuite = {
 	.suite_name = "EAL cfg API tests",
 	.setup = NULL,
@@ -742,6 +975,8 @@ static struct unit_test_suite eal_cfg_testsuite = {
 		TEST_CASE(test_eal_cfg_hugepage_dir),
 		TEST_CASE(test_eal_cfg_huge_unlink),
 		TEST_CASE(test_eal_cfg_in_memory),
+		TEST_CASE(test_eal_cfg_lcore),
+		TEST_CASE(test_eal_cfg_service_lcore),
 		TEST_CASES_END()
 	}
 };
diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
index 3e3e6bfb59..78f130c257 100644
--- a/lib/eal_cfg/eal_cfg.c
+++ b/lib/eal_cfg/eal_cfg.c
@@ -536,6 +536,84 @@ rte_eal_cfg_set_in_memory(struct rte_eal_cfg *cfg, bool val)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_in_memory, 26.07)
 EAL_CFG_GETTER(bool, in_memory, false)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcore, 26.07)
+int
+rte_eal_cfg_set_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id,
+		const rte_cpuset_t *cpuset, bool replace)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (lcore_id >= RTE_MAX_LCORE) {
+		EAL_CFG_LOG(ERR, "%s: lcore_id %u out of range [0, %u)",
+			__func__, lcore_id, RTE_MAX_LCORE);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (cpuset == NULL) {
+		EAL_CFG_LOG(ERR, "%s: cpuset is NULL", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (cfg->user_cfg.lcore_cpusets[lcore_id] != NULL && !replace) {
+		rte_errno = EEXIST;
+		return -1;
+	}
+
+	if (cfg->user_cfg.lcore_cpusets[lcore_id] == NULL) {
+		cfg->user_cfg.lcore_cpusets[lcore_id] = malloc(sizeof(rte_cpuset_t));
+		if (cfg->user_cfg.lcore_cpusets[lcore_id] == NULL) {
+			rte_errno = ENOMEM;
+			return -1;
+		}
+	}
+
+	memcpy(cfg->user_cfg.lcore_cpusets[lcore_id], cpuset, sizeof(rte_cpuset_t));
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_lcore_cpuset, 26.07)
+const rte_cpuset_t *
+rte_eal_cfg_get_lcore_cpuset(const struct rte_eal_cfg *cfg, unsigned int lcore_id)
+{
+	if (cfg == NULL || lcore_id >= RTE_MAX_LCORE)
+		return NULL;
+	return cfg->user_cfg.lcore_cpusets[lcore_id];
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_service_lcore, 26.07)
+int
+rte_eal_cfg_set_service_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (lcore_id >= RTE_MAX_LCORE) {
+		EAL_CFG_LOG(ERR, "%s: lcore_id %u out of range [0, %u)",
+			__func__, lcore_id, RTE_MAX_LCORE);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (cfg->user_cfg.lcore_cpusets[lcore_id] == NULL) {
+		EAL_CFG_LOG(ERR, "%s: lcore %u is not configured", __func__, lcore_id);
+		rte_errno = ENOENT;
+		return -1;
+	}
+
+	CPU_SET(lcore_id, &cfg->user_cfg.service_cpuset);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_is_service_lcore, 26.07)
+bool
+rte_eal_cfg_is_service_lcore(const struct rte_eal_cfg *cfg, unsigned int lcore_id)
+{
+	if (cfg == NULL || lcore_id >= RTE_MAX_LCORE)
+		return false;
+	return CPU_ISSET(lcore_id, &cfg->user_cfg.service_cpuset);
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcores_from_affinity, 26.07)
 int
 rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap)
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
index 59eacfe64d..34a52d70e8 100644
--- a/lib/eal_cfg/rte_eal_cfg.h
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -23,6 +23,7 @@ extern "C" {
 #include <stddef.h>
 #include <stdint.h>
 
+#include <rte_os.h>
 #include <rte_compat.h>
 #include <rte_eal.h>
 #include <rte_pci_dev_feature_defs.h>
@@ -477,6 +478,100 @@ bool
 rte_eal_cfg_get_in_memory(const struct rte_eal_cfg *cfg);
 /** @} */
 
+/**
+ * @name Per-lcore CPU affinity configuration
+ * @{
+ */
+
+/**
+ * Set the CPU affinity for a specific lcore.
+ *
+ * Assigns the CPU affinity set @p cpuset to lcore @p lcore_id.
+ * If the lcore already has a cpuset configured and @p replace is false,
+ * the call fails. If @p replace is true, the existing cpuset is overwritten.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param lcore_id
+ *   Lcore ID to configure. Must be in [0, RTE_MAX_LCORE).
+ * @param cpuset
+ *   CPU affinity set to assign to this lcore. Must not be NULL.
+ * @param replace
+ *   If true, overwrite any existing cpuset for this lcore.
+ *   If false, return -1 with rte_errno set to EEXIST if already configured.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL (NULL cfg or cpuset,
+ *   or lcore_id out of range), EEXIST (already configured and replace is
+ *   false), or ENOMEM on allocation failure.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id,
+		const rte_cpuset_t *cpuset, bool replace);
+
+/**
+ * Get the CPU affinity set for a specific lcore.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param lcore_id
+ *   Lcore ID to query. Must be in [0, RTE_MAX_LCORE).
+ * @return
+ *   Pointer to the cpuset for the lcore, or NULL if the lcore is not
+ *   configured or cfg is NULL or lcore_id is out of range.
+ */
+__rte_experimental
+const rte_cpuset_t *
+rte_eal_cfg_get_lcore_cpuset(const struct rte_eal_cfg *cfg, unsigned int lcore_id);
+
+/**
+ * @}
+ */
+
+/**
+ * @name Service lcore configuration
+ * @{
+ */
+
+/**
+ * Designate a configured lcore as a service lcore.
+ *
+ * Sets the bit for @p lcore_id in the service lcore cpuset, marking it
+ * as a service core. The lcore must already be configured via
+ * rte_eal_cfg_set_lcore() or rte_eal_cfg_set_lcores_from_affinity();
+ * it is an error to designate an unconfigured lcore as a service core.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param lcore_id
+ *   Lcore ID to designate as a service lcore.
+ *   Must be in [0, RTE_MAX_LCORE).
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL (NULL cfg or lcore_id
+ *   out of range) or ENOENT (lcore not configured in lcore_cpusets).
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_service_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id);
+
+/**
+ * Query whether a lcore is designated as a service lcore.
+ *
+ * @param cfg
+ *   Configuration handle. If NULL, returns false.
+ * @param lcore_id
+ *   Lcore ID to query.
+ * @return
+ *   true if the lcore is marked as a service lcore, false otherwise.
+ */
+__rte_experimental
+bool
+rte_eal_cfg_is_service_lcore(const struct rte_eal_cfg *cfg, unsigned int lcore_id);
+
+/**
+ * @}
+ */
+
 /**
  * Populate lcore configuration from the calling thread's CPU affinity.
  *
-- 
2.51.0

