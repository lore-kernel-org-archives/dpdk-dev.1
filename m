Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB19CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F4B8427C8;
	Wed, 29 Apr 2026 18:59:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 01CC640B8F;
 Wed, 29 Apr 2026 18:59:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481995; x=1809017995;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Wwl0PYu9nKsW+muftTEfvDCtIlcX0GqFfh6Ns0lin8I=;
 b=nBv5kXGddFZhyIz7mdcUpBHjz2qK4epeSqVp56mj26Qor9CG6ObLO2by
 0TPEWak/u4mOE95Dk2rVlatFxkNMicTZzi+4blkuI7/MBmCNwQ1JWPnBn
 EmDWS2QxXmAiI2bRcVGIJLyNWEpK06P5Ch2JAiwc7SyR7nuf9iSxpIAgn
 ut/2fdzcUVv9V3v2yd2CSmYGax5+us3O+tteQIn4IAAt7OSUJ9A7bNa0m
 G+RPqXQZMo6q9k+mhXoQGrtEWEHlpWf9QSVxM5NMO1/73lFGrd93avCvP
 Vik4AtAihuTWuFcISTPqythR4lsxgjyb6xO8hN1R6PrsrGIZyMKHGQaRg Q==;
X-CSE-ConnectionGUID: eHul5QOmR+KLd2wOESQZFg==
X-CSE-MsgGUID: xd3JIE95SsKzNppQUczL1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725418"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725418"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:54 -0700
X-CSE-ConnectionGUID: RZ/DD5fFR7e5LSuwz/x6yQ==
X-CSE-MsgGUID: 9//CztRLS7+p3UIw63phig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697261"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 43/44] eal_cfg: support device and driver lists
Date: Wed, 29 Apr 2026 17:58:35 +0100
Message-ID: <20260429165845.2136843-44-bruce.richardson@intel.com>
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

Support configuring lists of devices, allowlist, blocklist and vdev
list, as well as lists of plugin paths.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build      |   2 +-
 app/test/test_eal_cfg.c   | 128 ++++++++++++++++++++++++++++++++++++++
 lib/eal_cfg/eal_cfg.c     |  75 ++++++++++++++++++++++
 lib/eal_cfg/rte_eal_cfg.h |  89 ++++++++++++++++++++++++++
 4 files changed, 293 insertions(+), 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 3d39e82dd8..dccc27c18d 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -66,7 +66,7 @@ source_file_deps = {
     'test_distributor_perf.c': ['distributor'],
     'test_dmadev.c': ['dmadev', 'bus_vdev'],
     'test_dmadev_api.c': ['dmadev'],
-    'test_eal_cfg.c': ['eal_cfg'],
+    'test_eal_cfg.c': ['eal_cfg', 'ethdev', 'bus_vdev'],
     'test_eal_flags.c': [],
     'test_eal_fs.c': [],
     'test_efd.c': ['efd', 'net'],
diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
index ceaa42260a..cf197e3eaa 100644
--- a/app/test/test_eal_cfg.c
+++ b/app/test/test_eal_cfg.c
@@ -13,6 +13,7 @@
 #include <rte_vect.h>
 
 #include <rte_eal_cfg.h>
+#include <rte_ethdev.h>
 #include <rte_thread.h>
 #include <stdlib.h>
 #include <string.h>
@@ -142,6 +143,42 @@ subtest_eal_cfg_init_null(void)
 	return TEST_SUCCESS;
 }
 
+/* Test that two net_null vdevs configured via add_vdev appear as ethdevs after init. */
+static int
+subtest_eal_cfg_init_null_pmd_vdevs(void)
+{
+#ifdef RTE_NET_NULL
+	struct rte_eal_cfg *cfg;
+	uint16_t port_id;
+	int ret;
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	TEST_ASSERT(rte_eal_cfg_add_vdev(cfg, "net_null0") == 0,
+		"Failed to add net_null0 vdev");
+	TEST_ASSERT(rte_eal_cfg_add_vdev(cfg, "net_null1") == 0,
+		"Failed to add net_null1 vdev");
+
+	ret = rte_eal_init_from_cfg("test_prog", cfg);
+	TEST_ASSERT(ret == 0,
+		"rte_eal_init_from_cfg failed: ret=%d rte_errno=%d", ret, rte_errno);
+
+	rte_eal_cfg_free(cfg);
+
+	TEST_ASSERT(rte_eth_dev_count_avail() == 2,
+		"Expected 2 ethdevs, got %u", rte_eth_dev_count_avail());
+
+	TEST_ASSERT(rte_eth_dev_get_port_by_name("net_null0", &port_id) == 0,
+		"Expected to find port net_null0");
+	TEST_ASSERT(rte_eth_dev_get_port_by_name("net_null1", &port_id) == 0,
+		"Expected to find port net_null1");
+
+	rte_eal_cleanup();
+#endif /* RTE_NET_NULL */
+	return TEST_SUCCESS;
+}
+
 /* Test that lcore cpusets configured via set_lcore are visible post-init. */
 static int
 subtest_eal_cfg_init_lcore_affinity(void)
@@ -255,6 +292,7 @@ test_eal_cfg_init(void)
 		TEST_CFG_FN(subtest_eal_cfg_init_empty),
 		TEST_CFG_FN(subtest_eal_cfg_init_with_values),
 		TEST_CFG_FN(subtest_eal_cfg_init_lcore_affinity),
+		TEST_CFG_FN(subtest_eal_cfg_init_null_pmd_vdevs),
 		{ NULL, NULL }
 	};
 
@@ -823,6 +861,94 @@ test_eal_cfg_in_memory(void)
 	return TEST_SUCCESS;
 }
 
+/* Test add_device_allow, add_device_block, add_vdev, add_plugin. */
+static int
+test_eal_cfg_devopt(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_device_allow(NULL, "0000:00:01.0") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_device_block(NULL, "0000:00:01.0") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_vdev(NULL, "net_ring0") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* empty string rejected */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_device_allow(cfg, "") == -1,
+		"Expected -1 for empty devargs");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty devargs, got %d", rte_errno);
+
+	/* valid allow entries */
+	TEST_ASSERT(rte_eal_cfg_add_device_allow(cfg, "0000:00:01.0") == 0,
+		"Expected 0 for add_device_allow");
+	TEST_ASSERT(rte_eal_cfg_add_device_allow(cfg, "0000:00:02.0,key=val") == 0,
+		"Expected 0 for add_device_allow with args");
+
+	/* valid block entry */
+	TEST_ASSERT(rte_eal_cfg_add_device_block(cfg, "0000:00:03.0") == 0,
+		"Expected 0 for add_device_block");
+
+	/* valid vdev entry */
+	TEST_ASSERT(rte_eal_cfg_add_vdev(cfg, "net_ring0") == 0,
+		"Expected 0 for add_vdev");
+	TEST_ASSERT(rte_eal_cfg_add_vdev(cfg, "net_ring1,size=1024") == 0,
+		"Expected 0 for add_vdev with args");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test add_plugin. */
+static int
+test_eal_cfg_plugin(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_plugin(NULL, "/path/to/lib.so") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* empty string rejected */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_plugin(cfg, "") == -1,
+		"Expected -1 for empty path");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty path, got %d", rte_errno);
+
+	/* valid plugin paths */
+	TEST_ASSERT(rte_eal_cfg_add_plugin(cfg, "/usr/lib/dpdk/pmds/librte_net_ring.so") == 0,
+		"Expected 0 for add_plugin");
+	TEST_ASSERT(rte_eal_cfg_add_plugin(cfg, "/usr/lib/dpdk/pmds") == 0,
+		"Expected 0 for add_plugin with directory/glob");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
 #ifndef RTE_EXEC_ENV_WINDOWS  /* windows is missing the necessary macros for comparing CPUSETs etc. */
 /* Test set/get_lcore and set/is_service_lcore. */
 static int
@@ -975,6 +1101,8 @@ static struct unit_test_suite eal_cfg_testsuite = {
 		TEST_CASE(test_eal_cfg_hugepage_dir),
 		TEST_CASE(test_eal_cfg_huge_unlink),
 		TEST_CASE(test_eal_cfg_in_memory),
+		TEST_CASE(test_eal_cfg_devopt),
+		TEST_CASE(test_eal_cfg_plugin),
 		TEST_CASE(test_eal_cfg_lcore),
 		TEST_CASE(test_eal_cfg_service_lcore),
 		TEST_CASES_END()
diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
index 78f130c257..258e4fa11b 100644
--- a/lib/eal_cfg/eal_cfg.c
+++ b/lib/eal_cfg/eal_cfg.c
@@ -14,9 +14,11 @@
 
 #include <eal_export.h>
 #include <rte_bitops.h>
+#include <rte_devargs.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
+#include <rte_string_fns.h>
 #include <rte_thread.h>
 #include <rte_vect.h>
 
@@ -536,6 +538,79 @@ rte_eal_cfg_set_in_memory(struct rte_eal_cfg *cfg, bool val)
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_in_memory, 26.07)
 EAL_CFG_GETTER(bool, in_memory, false)
 
+static int
+cfg_add_devopt(struct rte_eal_cfg *cfg, enum rte_devtype type, const char *devargs)
+{
+	struct device_option *devopt;
+	size_t arglen;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (devargs == NULL || devargs[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: devargs is NULL or empty", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	arglen = strlen(devargs) + 1;
+	devopt = calloc(1, sizeof(*devopt) + arglen);
+	if (devopt == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+
+	devopt->type = type;
+	strlcpy(devopt->arg, devargs, arglen);
+	TAILQ_INSERT_TAIL(&cfg->user_cfg.devopt_list, devopt, next);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_add_device_allow, 26.07)
+int
+rte_eal_cfg_add_device_allow(struct rte_eal_cfg *cfg, const char *devargs)
+{
+	return cfg_add_devopt(cfg, RTE_DEVTYPE_ALLOWED, devargs);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_add_device_block, 26.07)
+int
+rte_eal_cfg_add_device_block(struct rte_eal_cfg *cfg, const char *devargs)
+{
+	return cfg_add_devopt(cfg, RTE_DEVTYPE_BLOCKED, devargs);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_add_vdev, 26.07)
+int
+rte_eal_cfg_add_vdev(struct rte_eal_cfg *cfg, const char *devargs)
+{
+	return cfg_add_devopt(cfg, RTE_DEVTYPE_VIRTUAL, devargs);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_add_plugin, 26.07)
+int
+rte_eal_cfg_add_plugin(struct rte_eal_cfg *cfg, const char *path)
+{
+	struct eal_plugin_path *p;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (path == NULL || path[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: path is NULL or empty", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	p = calloc(1, sizeof(*p));
+	if (p == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+
+	strlcpy(p->name, path, sizeof(p->name));
+	TAILQ_INSERT_TAIL(&cfg->user_cfg.plugin_list, p, next);
+	return 0;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcore, 26.07)
 int
 rte_eal_cfg_set_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id,
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
index 34a52d70e8..200010c40a 100644
--- a/lib/eal_cfg/rte_eal_cfg.h
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -25,6 +25,7 @@ extern "C" {
 
 #include <rte_os.h>
 #include <rte_compat.h>
+#include <rte_devargs.h>
 #include <rte_eal.h>
 #include <rte_pci_dev_feature_defs.h>
 
@@ -568,6 +569,94 @@ __rte_experimental
 bool
 rte_eal_cfg_is_service_lcore(const struct rte_eal_cfg *cfg, unsigned int lcore_id);
 
+/**
+ * @}
+ */
+
+/**
+ * @name Device allow/block/virtual configuration
+ * @{
+ */
+
+/**
+ * Add a device allow entry (equivalent to -a / --allow).
+ *
+ * Appends a PCI or other bus device address to the allow list.
+ * Only devices on the allow list are probed when an allow list is present.
+ * Multiple calls may be made to allow multiple devices.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param devargs
+ *   Device argument string, e.g. "0000:00:01.0" or "0000:00:01.0,key=val".
+ *   Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL (NULL or empty devargs
+ *   or NULL cfg) or ENOMEM on allocation failure.
+ */
+__rte_experimental
+int
+rte_eal_cfg_add_device_allow(struct rte_eal_cfg *cfg, const char *devargs);
+
+/**
+ * Add a device block entry (equivalent to -b / --block).
+ *
+ * Appends a device address to the block list, preventing it from being probed.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param devargs
+ *   Device argument string. Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL or ENOMEM.
+ */
+__rte_experimental
+int
+rte_eal_cfg_add_device_block(struct rte_eal_cfg *cfg, const char *devargs);
+
+/**
+ * Add a virtual device (equivalent to --vdev).
+ *
+ * Appends a virtual device entry to the configuration.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param devargs
+ *   Virtual device argument string, e.g. "net_ring0" or
+ *   "net_ring0,size=1024". Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL or ENOMEM.
+ */
+__rte_experimental
+int
+rte_eal_cfg_add_vdev(struct rte_eal_cfg *cfg, const char *devargs);
+
+/**
+ * @}
+ */
+
+/**
+ * @name Plugin configuration
+ * @{
+ */
+
+/**
+ * Add a plugin (shared library) to load at EAL initialisation (equivalent to -d).
+ *
+ * Each call appends one entry. Glob patterns are supported for directory
+ * expansion as with the -d command-line option.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param path
+ *   Path to the shared library or a glob pattern. Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL or ENOMEM.
+ */
+__rte_experimental
+int
+rte_eal_cfg_add_plugin(struct rte_eal_cfg *cfg, const char *path);
+
 /**
  * @}
  */
-- 
2.51.0

