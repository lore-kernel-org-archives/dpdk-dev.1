Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15031CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDEFF42793;
	Wed, 29 Apr 2026 18:59:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C2A3B40F1A;
 Wed, 29 Apr 2026 18:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481988; x=1809017988;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SmYe1CNwlQoUdKKQNqdTk/5g+pahhxn5DSGj8POX3Uk=;
 b=fUPBnUgRQrzfYHMrhXWMdJPJJhbiKsv8bLI/xvhEQb7WN4mHEuOzbQNi
 a6QH+f72q2vWMsw7ADaYsLefJBaHOgP2SsUfn0ltgfXoUY6xucOTlvKWW
 GC6ayNSpmLsXGmWNfBUpZhgzFVhZrZlR+fHa2F4ctAvLJYJGqWP58O7Nr
 GBeuaolDny9Z+cb3cIjxE6GHBPVDN/rXstl3b7Pq00giGt8H4c69RpAnB
 zB9TSSKLDzfw252C2DUBRfBBOqHbOvX59IITZrG761LCMOqqZenUMys8h
 111crHmcAGkomLqGUkj+5ZslMQrjDzN8987lpJ0ncXgQHpJvWUOtaAKl3 w==;
X-CSE-ConnectionGUID: tpH1tQqtTdep1lTZTGrn+Q==
X-CSE-MsgGUID: 5461H8EBQRi4eVCL7qK1SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725388"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725388"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:46 -0700
X-CSE-ConnectionGUID: QNJT03g2TbuLCQtrV9T6Qw==
X-CSE-MsgGUID: Tyj4axCQQfuEzVHdZeT1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697216"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 37/44] eal_cfg: add new library to programmatically init
 DPDK
Date: Wed, 29 Apr 2026 17:58:29 +0100
Message-ID: <20260429165845.2136843-38-bruce.richardson@intel.com>
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

Rather than relying on apps to populate an argc/argv array, add a new
eal_cfg library that allows programmatically programming the config and
initializing using that. Start with basic alloc and free functions for
the config context, and the init function itself to call EAL init.
Include basic unit tests for these too, although limitations in the test
framework right now prevent testing actual EAL init.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build                  |  1 +
 app/test/test_eal_cfg.c               | 99 +++++++++++++++++++++++++++
 doc/api/doxy-api-index.md             |  1 +
 doc/api/doxy-api.conf.in              |  1 +
 doc/guides/prog_guide/eal_cfg_lib.rst | 23 +++++++
 doc/guides/prog_guide/index.rst       |  1 +
 lib/eal_cfg/eal_cfg.c                 | 64 +++++++++++++++++
 lib/eal_cfg/meson.build               |  6 ++
 lib/eal_cfg/rte_eal_cfg.h             | 79 +++++++++++++++++++++
 lib/meson.build                       |  1 +
 10 files changed, 276 insertions(+)
 create mode 100644 app/test/test_eal_cfg.c
 create mode 100644 doc/guides/prog_guide/eal_cfg_lib.rst
 create mode 100644 lib/eal_cfg/eal_cfg.c
 create mode 100644 lib/eal_cfg/meson.build
 create mode 100644 lib/eal_cfg/rte_eal_cfg.h

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..3d39e82dd8 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -66,6 +66,7 @@ source_file_deps = {
     'test_distributor_perf.c': ['distributor'],
     'test_dmadev.c': ['dmadev', 'bus_vdev'],
     'test_dmadev_api.c': ['dmadev'],
+    'test_eal_cfg.c': ['eal_cfg'],
     'test_eal_flags.c': [],
     'test_eal_fs.c': [],
     'test_efd.c': ['efd', 'net'],
diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
new file mode 100644
index 0000000000..3def760b50
--- /dev/null
+++ b/app/test/test_eal_cfg.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <errno.h>
+
+#include <rte_errno.h>
+
+#include <rte_eal_cfg.h>
+
+#include "test.h"
+
+/* Test that a config handle can be created and freed without error. */
+static int
+test_eal_cfg_create_free(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* create with no arguments */
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* free must not crash */
+	rte_eal_cfg_free(cfg);
+
+	/* free(NULL) must be a safe no-op */
+	rte_eal_cfg_free(NULL);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test initialising EAL with a freshly created (empty/default) config.
+ * Since the test binary has already initialised EAL, we expect the call to
+ * fail with EALREADY rather than succeed — but the function must forward
+ * the call through to rte_eal_runtime_init() and return its error correctly.
+ */
+static int
+test_eal_cfg_init_empty(void)
+{
+	struct rte_eal_cfg *cfg;
+	int ret;
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	ret = rte_eal_init_from_cfg("test_prog", cfg);
+	TEST_ASSERT(ret == -1,
+		"Expected -1 from rte_eal_init_from_cfg (EAL already init), got %d", ret);
+	TEST_ASSERT(rte_errno == EALREADY,
+		"Expected EALREADY, got %d", rte_errno);
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test that passing NULL cfg to rte_eal_init_from_cfg uses default config.
+ * Since EAL is already running, we still expect EALREADY.
+ */
+static int
+test_eal_cfg_init_null(void)
+{
+	int ret;
+
+	ret = rte_eal_init_from_cfg("test_prog", NULL);
+	TEST_ASSERT(ret == -1,
+		"Expected -1 from rte_eal_init_from_cfg with NULL cfg, got %d", ret);
+	TEST_ASSERT(rte_errno == EALREADY,
+		"Expected EALREADY for NULL cfg, got %d", rte_errno);
+
+	/* NULL progname must be rejected regardless of cfg */
+	ret = rte_eal_init_from_cfg(NULL, NULL);
+	TEST_ASSERT(ret == -1,
+		"Expected -1 from rte_eal_init_from_cfg(NULL, NULL), got %d", ret);
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL progname, got %d", rte_errno);
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite eal_cfg_testsuite = {
+	.suite_name = "EAL cfg API tests",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_eal_cfg_create_free),
+		TEST_CASE(test_eal_cfg_init_empty),
+		TEST_CASE(test_eal_cfg_init_null),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_eal_cfg(void)
+{
+	return unit_test_suite_runner(&eal_cfg_testsuite);
+}
+
+REGISTER_FAST_TEST(eal_cfg_autotest, NOHUGE_OK, ASAN_OK, test_eal_cfg);
diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..491ce1a958 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -251,6 +251,7 @@ The public API headers are grouped by topics:
 
 - **misc**:
   [EAL config](@ref rte_eal.h),
+  [EAL programmatic init](@ref rte_eal_cfg.h),
   [common](@ref rte_common.h),
   [experimental APIs](@ref rte_compat.h),
   [version](@ref rte_version.h)
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd944681..305714773e 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -28,6 +28,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/drivers/raw/ifpga \
                           @TOPDIR@/lib/eal/include \
                           @TOPDIR@/lib/eal/include/generic \
+                          @TOPDIR@/lib/eal_cfg \
                           @TOPDIR@/lib/acl \
                           @TOPDIR@/lib/argparse \
                           @TOPDIR@/lib/bbdev \
diff --git a/doc/guides/prog_guide/eal_cfg_lib.rst b/doc/guides/prog_guide/eal_cfg_lib.rst
new file mode 100644
index 0000000000..34ca5a95ad
--- /dev/null
+++ b/doc/guides/prog_guide/eal_cfg_lib.rst
@@ -0,0 +1,23 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+EAL Programmatic Configuration Library
+=======================================
+
+The EAL programmatic configuration library provides a programmatic alternative to the ``rte_eal_init()`` argc/argv interface.
+An application creates an ``rte_eal_cfg`` handle, populates it via setter functions,
+and passes it to ``rte_eal_init_from_cfg()`` in place of the standard init call.
+This avoids the need to construct a synthetic argument vector
+when the EAL is embedded in a larger framework or launched without a conventional command line.
+
+
+Configuration Handle Lifecycle
+-------------------------------
+
+A configuration handle is created with ``rte_eal_cfg_create()``,
+which accepts the program name used for logging.
+The handle is initialised with the same defaults that apply when ``rte_eal_init()`` is called with no options.
+
+Once the application has populated the handle, it is passed to ``rte_eal_init_from_cfg()``.
+After that call the handle may be freed with ``rte_eal_cfg_free()``, which releases all memory owned by the handle.
+It is safe to call ``rte_eal_cfg_free()`` with a NULL pointer.
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..f5e6ee69d2 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -38,6 +38,7 @@ CPU Management
     :numbered:
 
     env_abstraction_layer
+    eal_cfg_lib
     power_man
     thread_safety
     service_cores
diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
new file mode 100644
index 0000000000..70f0122b81
--- /dev/null
+++ b/lib/eal_cfg/eal_cfg.c
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+
+#include <eal_export.h>
+#include <rte_errno.h>
+#include <rte_log.h>
+
+#include "eal_internal_cfg.h"
+#include "rte_eal_cfg.h"
+
+struct rte_eal_cfg {
+	struct eal_user_cfg user_cfg;
+};
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_create, 26.07)
+struct rte_eal_cfg *
+rte_eal_cfg_create(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	cfg = calloc(1, sizeof(*cfg));
+	if (cfg == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	cfg->user_cfg = EAL_USER_CFG_INITIALIZER(cfg->user_cfg);
+
+	return cfg;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_free, 26.07)
+void
+rte_eal_cfg_free(struct rte_eal_cfg *cfg)
+{
+	if (cfg == NULL)
+		return;
+
+	eal_user_cfg_cleanup(&cfg->user_cfg);
+	free(cfg);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_init_from_cfg, 26.07)
+int
+rte_eal_init_from_cfg(const char *progname, struct rte_eal_cfg *cfg)
+{
+	struct rte_eal_cfg local_cfg = {
+		.user_cfg = EAL_USER_CFG_INITIALIZER(local_cfg.user_cfg),
+	};
+
+	if (progname == NULL || progname[0] == '\0') {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (cfg == NULL)
+		cfg = &local_cfg;
+
+	return rte_eal_runtime_init(progname, &cfg->user_cfg);
+}
diff --git a/lib/eal_cfg/meson.build b/lib/eal_cfg/meson.build
new file mode 100644
index 0000000000..280a85b93e
--- /dev/null
+++ b/lib/eal_cfg/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+sources = files('eal_cfg.c')
+headers = files('rte_eal_cfg.h')
+includes += include_directories('../eal/common')
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
new file mode 100644
index 0000000000..c0d316a6cb
--- /dev/null
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef RTE_EAL_CFG_H
+#define RTE_EAL_CFG_H
+
+/**
+ * @file
+ *
+ * EAL programmatic configuration API.
+ *
+ * This API allows applications to configure and initialize the EAL without
+ * passing argc/argv. A configuration handle is created, populated via setter
+ * functions, and passed to rte_eal_init_from_cfg() in place of rte_eal_init().
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <rte_compat.h>
+
+/**
+ * Opaque EAL configuration handle.
+ */
+struct rte_eal_cfg;
+
+/**
+ * Create a new EAL configuration handle.
+ *
+ * Allocates and initialises a configuration struct with default values
+ * equivalent to those used when rte_eal_init() is called with no options.
+ *
+ * @return
+ *   Pointer to a new configuration handle, or NULL on failure (rte_errno set).
+ */
+__rte_experimental
+struct rte_eal_cfg *
+rte_eal_cfg_create(void);
+
+/**
+ * Free an EAL configuration handle.
+ *
+ * Releases all resources owned by the handle. Safe to call on NULL.
+ *
+ * @param cfg
+ *   Configuration handle to free. If NULL, this function is a no-op.
+ */
+__rte_experimental
+void
+rte_eal_cfg_free(struct rte_eal_cfg *cfg);
+
+/**
+ * Initialise the EAL using a programmatic configuration handle.
+ *
+ * This function is a programmatic alternative to rte_eal_init().
+ * The caller optionally creates a configuration handle with rte_eal_cfg_create(),
+ * populates it via setter functions, and passes it to this function
+ * in place of argc/argv. If @p cfg is NULL, default EAL configuration is used.
+ *
+ * @param progname
+ *   The program name, used for logging. Must not be NULL or empty.
+ * @param cfg
+ *   Configuration handle created with rte_eal_cfg_create(),
+ *   or NULL to use default configuration.
+ * @return
+ *   0 on success, or -1 on failure (rte_errno is set).
+ */
+__rte_experimental
+int
+rte_eal_init_from_cfg(const char *progname, struct rte_eal_cfg *cfg);
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_EAL_CFG_H */
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..9b9ebcf5db 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -15,6 +15,7 @@ libraries = [
         'telemetry', # basic info querying
         'pmu',
         'eal', # everything depends on eal
+        'eal_cfg',
         'ptr_compress',
         'ring',
         'rcu', # rcu depends on ring
-- 
2.51.0

