Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D4FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06FDE427A5;
	Wed, 29 Apr 2026 18:59:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D19F84278B;
 Wed, 29 Apr 2026 18:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481990; x=1809017990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wq2mZGp9PpyzitJp8agjXU/3BX/E2BSP4zRk/DDNQKw=;
 b=fnVWWNXAfD7fIo/+rYoA9pVXTQqCde9M3ChGfrVCsssXaJshGZfBsCOY
 T0o1pDa040YtYI9QsGY9dQ1j+IQL84QQcURGQRgEXG/6keUZKK9j4v8Le
 0Bq6c+OUt5z0Ca6rn4WWo9KlGqUP+JMz8yBhIQaocmnJ2/1xh7AJEqttT
 krmvG/9TM4FjnR0ygiVVAa1DEjhYZ7IZTuVHqoCFPtRB9DL10I9iQ738r
 QMKSbVMS7ImfoZ4dmtLvGesVeXc4ZN2h/PBAPNKDm4xcbJoP203MB0jmv
 gWhiy+liNTt5Erp+BQnWMJI+cAoFYiXrOaUr4JBXnrGoLV+/lp1MdRApB w==;
X-CSE-ConnectionGUID: aYonx/GnSIiMFSmT7XvKZw==
X-CSE-MsgGUID: aViPNisYTrucMBnbLZ9LzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725397"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725397"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:49 -0700
X-CSE-ConnectionGUID: laFifJ/nSKi2e1nPX3thiQ==
X-CSE-MsgGUID: U+/Xh66HStqGlRbLrNjAnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697227"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:47 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 39/44] app/test: enable testing init using EAL config lib
Date: Wed, 29 Apr 2026 17:58:31 +0100
Message-ID: <20260429165845.2136843-40-bruce.richardson@intel.com>
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

To test the eal_cfg library initialization we need to bypass the regular
rte_eal_init() calls in the test binary, which requires a little bit of
rework to the existing test harness. Make those changes and then add
some very basic init testing using the rte_eal_cfg_init() function.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test.c         | 14 +++---
 app/test/test.h         |  1 +
 app/test/test_eal_cfg.c | 99 +++++++++++++++++++++++++++++++----------
 3 files changed, 86 insertions(+), 28 deletions(-)

diff --git a/app/test/test.c b/app/test/test.c
index 58ef52f312..dba3c581a4 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -47,13 +47,11 @@ extern cmdline_parse_ctx_t main_ctx[];
 
 const char *prgname; /* to be set to argv[0] */
 
-static const char *recursive_call; /* used in linux for MP and other tests */
-
 static int
 no_action(void){ return 0; }
 
 static int
-do_recursive_call(void)
+do_recursive_call(const char *recursive_call)
 {
 	unsigned i;
 	struct {
@@ -117,6 +115,13 @@ main(int argc, char **argv)
 	int i;
 	char *extra_args;
 	int ret;
+	const char *recursive_call = getenv(RECURSIVE_ENV_VAR);
+
+#ifdef RTE_LIB_EAL_CFG
+	/* Pre-EAL-init dispatch: for tests that test EAL init itself. */
+	if (recursive_call != NULL && strcmp(recursive_call, "test_eal_cfg_init") == 0)
+		return test_eal_cfg_init();
+#endif
 
 	extra_args = getenv("DPDK_TEST_PARAMS");
 	if (extra_args != NULL && strlen(extra_args) > 0) {
@@ -174,9 +179,8 @@ main(int argc, char **argv)
 		goto out;
 	}
 
-	recursive_call = getenv(RECURSIVE_ENV_VAR);
 	if (recursive_call != NULL) {
-		ret = do_recursive_call();
+		ret = do_recursive_call(recursive_call);
 		goto out;
 	}
 
diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..b80c818249 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -179,6 +179,7 @@ int test_exit(void);
 int test_mp_secondary(void);
 int test_panic(void);
 int test_timer_secondary(void);
+int test_eal_cfg_init(void);
 
 int test_set_rxtx_conf(cmdline_fixed_string_t mode);
 int test_set_rxtx_anchor(cmdline_fixed_string_t type);
diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
index 3def760b50..f714be3fd4 100644
--- a/app/test/test_eal_cfg.c
+++ b/app/test/test_eal_cfg.c
@@ -4,12 +4,19 @@
 
 #include <errno.h>
 
+#include <rte_eal.h>
+#include <rte_debug.h>
 #include <rte_errno.h>
 
 #include <rte_eal_cfg.h>
+#include <stdlib.h>
 
 #include "test.h"
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include "process.h"
+#endif
+
 /* Test that a config handle can be created and freed without error. */
 static int
 test_eal_cfg_create_free(void)
@@ -29,14 +36,13 @@ test_eal_cfg_create_free(void)
 	return TEST_SUCCESS;
 }
 
-/*
- * Test initialising EAL with a freshly created (empty/default) config.
- * Since the test binary has already initialised EAL, we expect the call to
- * fail with EALREADY rather than succeed — but the function must forward
- * the call through to rte_eal_runtime_init() and return its error correctly.
- */
+#ifdef RTE_EXEC_ENV_WINDOWS
+int
+test_eal_cfg_init(void) { return 0; }
+#else
+/* Test initialising EAL with a freshly created (empty/default) config. */
 static int
-test_eal_cfg_init_empty(void)
+subtest_eal_cfg_init_empty(void)
 {
 	struct rte_eal_cfg *cfg;
 	int ret;
@@ -45,29 +51,21 @@ test_eal_cfg_init_empty(void)
 	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
 
 	ret = rte_eal_init_from_cfg("test_prog", cfg);
-	TEST_ASSERT(ret == -1,
-		"Expected -1 from rte_eal_init_from_cfg (EAL already init), got %d", ret);
-	TEST_ASSERT(rte_errno == EALREADY,
-		"Expected EALREADY, got %d", rte_errno);
+	TEST_ASSERT(ret == 0,
+		"Expected 0 from rte_eal_init_from_cfg, got %d", ret);
 
 	rte_eal_cfg_free(cfg);
+
+	rte_eal_cleanup();
 	return TEST_SUCCESS;
 }
 
-/* Test that passing NULL cfg to rte_eal_init_from_cfg uses default config.
- * Since EAL is already running, we still expect EALREADY.
- */
+/* Test that passing NULL cfg to rte_eal_init_from_cfg uses default config. */
 static int
-test_eal_cfg_init_null(void)
+subtest_eal_cfg_init_null(void)
 {
 	int ret;
 
-	ret = rte_eal_init_from_cfg("test_prog", NULL);
-	TEST_ASSERT(ret == -1,
-		"Expected -1 from rte_eal_init_from_cfg with NULL cfg, got %d", ret);
-	TEST_ASSERT(rte_errno == EALREADY,
-		"Expected EALREADY for NULL cfg, got %d", rte_errno);
-
 	/* NULL progname must be rejected regardless of cfg */
 	ret = rte_eal_init_from_cfg(NULL, NULL);
 	TEST_ASSERT(ret == -1,
@@ -75,17 +73,72 @@ test_eal_cfg_init_null(void)
 	TEST_ASSERT(rte_errno == EINVAL,
 		"Expected EINVAL for NULL progname, got %d", rte_errno);
 
+	ret = rte_eal_init_from_cfg("test_prog", NULL);
+	TEST_ASSERT(ret == 0,
+		"Expected 0 from rte_eal_init_from_cfg with NULL cfg, got %d", ret);
+
+	rte_eal_cleanup();
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test EAL initialisation from a default config in a fresh subprocess.
+ * Called before rte_eal_init() so that it can exercise the very first call
+ * through rte_eal_init_from_cfg(). Returns 0 on success, 1 on failure.
+ */
+int
+test_eal_cfg_init(void)
+{
+#define EAL_CFG_TEST_FN "EAL_CFG_TEST_FN"
+	struct test_fns {
+		const char *name;
+		int (*fn)(void);
+	} test_fns[] = {
+#define TEST_CFG_FN(X) { #X, X }
+		TEST_CFG_FN(subtest_eal_cfg_init_null),
+		TEST_CFG_FN(subtest_eal_cfg_init_empty),
+		{ NULL, NULL }
+	};
+
+	const char *test_fn = getenv(EAL_CFG_TEST_FN);
+	if (test_fn == NULL) {
+		/* This is the parent process: spawn a child to run the test. */
+		const char *argv[] = { prgname, NULL };
+
+		for (size_t i = 0; test_fns[i].name != NULL; i++) {
+			setenv(EAL_CFG_TEST_FN, test_fns[i].name, 1);
+			int ret = process_dup(argv, 1, __func__);
+			if (ret != 0) {
+				printf("Test '%s' failed with return code %d\n",
+					test_fns[i].name, ret);
+				return -1;
+			}
+			printf("Test '%s' passed\n", test_fns[i].name);
+		}
+	} else {
+		/* This is the child process: run the specified test function. */
+		for (size_t i = 0; test_fns[i].name != NULL; i++) {
+			if (strcmp(test_fn, test_fns[i].name) == 0) {
+				printf("Running test '%s'\n", test_fns[i].name);
+				return test_fns[i].fn();
+			}
+		}
+
+		printf("Unknown test function '%s'\n", test_fn);
+		return -1;
+	}
+
+	return 0;
+}
+#endif /* RTE_EXEC_ENV_WINDOWS */
+
 static struct unit_test_suite eal_cfg_testsuite = {
 	.suite_name = "EAL cfg API tests",
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
 		TEST_CASE(test_eal_cfg_create_free),
-		TEST_CASE(test_eal_cfg_init_empty),
-		TEST_CASE(test_eal_cfg_init_null),
+		TEST_CASE(test_eal_cfg_init),
 		TEST_CASES_END()
 	}
 };
-- 
2.51.0

