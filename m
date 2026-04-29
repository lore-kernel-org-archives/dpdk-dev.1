Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3DFCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EEC040C35;
	Wed, 29 Apr 2026 19:00:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 506FD40B8F;
 Wed, 29 Apr 2026 18:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481996; x=1809017996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O7450DX4eTOjc43G8nLBQ5WEnqqn+PO3PWw/4QZvmfk=;
 b=oCdPWYVlm0qqD5rBQXhwsW5nPLMYx8o6wqxccq/ggY237+L4r2zJzrjk
 TjaF2Rfz3iP/0ONTQDQVK8PZ79WrHLT4ufl5sSj2+5eFzNpVn9ranvBr0
 umq5aPQckPdYA4srvX/7RraSQcv8BuR7ezFxirEAO3Dq8jAq31xQSrYWD
 Oy4NE394Tv5MRRxVAMRvmnBPawI+/xlC+Ho6h3aX/y5C+Fm8MwTnXwVMM
 r5nuYCNbYgFTLv9u4TBJLsQx7qHn1Rr2Ck8NkKpk6mdzytP+4QqsJBpvH
 Ew3oGH/zLp2C4KgVGGzpC9teJ+3QXOxyLVBZHIF2ctt12ibw1gJcHfg9d w==;
X-CSE-ConnectionGUID: 0S3LlsPJQ629jq2XdXJWYA==
X-CSE-MsgGUID: a4iARlBRSd+wcyUkcWtGpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725421"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:56 -0700
X-CSE-ConnectionGUID: Y94n9fE4QQKWJYfpOw7uCw==
X-CSE-MsgGUID: tKpprhetTxqEj6e/ZkF2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697269"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:54 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 44/44] eal_cfg: add APIs for configuring remaining init
 settings
Date: Wed, 29 Apr 2026 17:58:36 +0100
Message-ID: <20260429165845.2136843-45-bruce.richardson@intel.com>
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

Add APIs to configure the tracing settings for EAL, and the two other
remaining settings: the default mempool, and the vfio vf UUID token.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_cfg.c   | 205 ++++++++++++++++++++++++++++++++++++++
 lib/eal_cfg/eal_cfg.c     | 134 +++++++++++++++++++++++++
 lib/eal_cfg/rte_eal_cfg.h | 177 +++++++++++++++++++++++++++++++-
 3 files changed, 515 insertions(+), 1 deletion(-)

diff --git a/app/test/test_eal_cfg.c b/app/test/test_eal_cfg.c
index cf197e3eaa..ef93a858e6 100644
--- a/app/test/test_eal_cfg.c
+++ b/app/test/test_eal_cfg.c
@@ -949,6 +949,118 @@ test_eal_cfg_plugin(void)
 	return TEST_SUCCESS;
 }
 
+/* Test tracing configuration APIs. */
+static int
+test_eal_cfg_trace(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_trace_pattern(NULL, "lib.eal.*") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_trace_dir(NULL, "/tmp/traces") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_trace_dir(NULL) == NULL,
+		"Expected NULL from get_trace_dir with NULL cfg");
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_trace_bufsz(NULL, 1024) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_trace_bufsz(NULL) == 0,
+		"Expected 0 from get_trace_bufsz with NULL cfg");
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_trace_mode(NULL, RTE_TRACE_MODE_DISCARD) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_trace_mode(NULL) == RTE_TRACE_MODE_OVERWRITE,
+		"Expected default OVERWRITE from get_trace_mode with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* --- add_trace_pattern --- */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_add_trace_pattern(cfg, "") == -1,
+		"Expected -1 for empty pattern");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty pattern, got %d", rte_errno);
+
+	TEST_ASSERT(rte_eal_cfg_add_trace_pattern(cfg, "lib.eal.*") == 0,
+		"Expected 0 for valid pattern");
+	TEST_ASSERT(rte_eal_cfg_add_trace_pattern(cfg, "lib.mempool.*") == 0,
+		"Expected 0 for second pattern");
+
+	/* --- set/get trace_dir --- */
+	TEST_ASSERT(rte_eal_cfg_get_trace_dir(cfg) == NULL,
+		"Expected default trace_dir == NULL");
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_trace_dir(cfg, "") == -1,
+		"Expected -1 for empty dir");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty dir, got %d", rte_errno);
+
+	TEST_ASSERT(rte_eal_cfg_set_trace_dir(cfg, "/tmp/traces") == 0,
+		"Expected 0 for valid trace_dir");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_trace_dir(cfg), "/tmp/traces") == 0,
+		"get_trace_dir returned wrong value");
+
+	/* overwrite */
+	TEST_ASSERT(rte_eal_cfg_set_trace_dir(cfg, "/var/log/traces") == 0,
+		"Expected 0 overwriting trace_dir");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_trace_dir(cfg), "/var/log/traces") == 0,
+		"get_trace_dir did not reflect overwrite");
+
+	/* --- set/get trace_bufsz --- */
+	TEST_ASSERT(rte_eal_cfg_get_trace_bufsz(cfg) == 0,
+		"Expected default trace_bufsz == 0");
+
+	TEST_ASSERT(rte_eal_cfg_set_trace_bufsz(cfg, 2 * 1024 * 1024) == 0,
+		"Expected 0 setting trace_bufsz");
+	TEST_ASSERT(rte_eal_cfg_get_trace_bufsz(cfg) == 2 * 1024 * 1024,
+		"get_trace_bufsz returned wrong value");
+
+	/* 0 is valid (means use default) */
+	TEST_ASSERT(rte_eal_cfg_set_trace_bufsz(cfg, 0) == 0,
+		"Expected 0 setting trace_bufsz to 0");
+	TEST_ASSERT(rte_eal_cfg_get_trace_bufsz(cfg) == 0,
+		"Expected 0 after setting trace_bufsz to 0");
+
+	/* --- set/get trace_mode --- */
+	TEST_ASSERT(rte_eal_cfg_get_trace_mode(cfg) == RTE_TRACE_MODE_OVERWRITE,
+		"Expected default trace_mode == OVERWRITE");
+
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_trace_mode(cfg, (enum rte_trace_mode)99) == -1,
+		"Expected -1 for invalid trace_mode");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for invalid mode, got %d", rte_errno);
+
+	TEST_ASSERT(rte_eal_cfg_set_trace_mode(cfg, RTE_TRACE_MODE_DISCARD) == 0,
+		"Expected 0 setting DISCARD mode");
+	TEST_ASSERT(rte_eal_cfg_get_trace_mode(cfg) == RTE_TRACE_MODE_DISCARD,
+		"Expected DISCARD after set");
+
+	TEST_ASSERT(rte_eal_cfg_set_trace_mode(cfg, RTE_TRACE_MODE_OVERWRITE) == 0,
+		"Expected 0 setting OVERWRITE mode");
+	TEST_ASSERT(rte_eal_cfg_get_trace_mode(cfg) == RTE_TRACE_MODE_OVERWRITE,
+		"Expected OVERWRITE after set");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
 #ifndef RTE_EXEC_ENV_WINDOWS  /* windows is missing the necessary macros for comparing CPUSETs etc. */
 /* Test set/get_lcore and set/is_service_lcore. */
 static int
@@ -1084,6 +1196,96 @@ static int test_eal_cfg_lcore(void) { return TEST_SUCCESS; }
 static int test_eal_cfg_service_lcore(void) { return TEST_SUCCESS; }
 #endif /* RTE_EXEC_ENV_WINDOWS */
 
+/* Test set/get_vfio_vf_token. */
+static int
+test_eal_cfg_vfio_vf_token(void)
+{
+	struct rte_eal_cfg *cfg;
+	rte_uuid_t token, out;
+	const rte_uuid_t *p;
+	static const uint8_t bytes[16] = {
+		0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+		0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10,
+	};
+
+	/* NULL cfg: set returns -1/EINVAL; get returns NULL */
+	rte_errno = 0;
+	memcpy(token, bytes, sizeof(token));
+	TEST_ASSERT(rte_eal_cfg_set_vfio_vf_token(NULL, token) == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_vfio_vf_token(NULL) == NULL,
+		"Expected NULL from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* freshly created cfg: token should be all-zero */
+	p = rte_eal_cfg_get_vfio_vf_token(cfg);
+	TEST_ASSERT_NOT_NULL(p, "Expected non-NULL pointer from get");
+	memset(out, 0xff, sizeof(out));
+	rte_uuid_copy(out, *p);
+	for (int i = 0; i < (int)sizeof(out); i++)
+		TEST_ASSERT(out[i] == 0,
+			"fresh token byte[%d] should be 0, got 0x%02x", i, out[i]);
+
+	/* set and get roundtrip */
+	TEST_ASSERT(rte_eal_cfg_set_vfio_vf_token(cfg, token) == 0,
+		"Expected 0 setting token");
+	p = rte_eal_cfg_get_vfio_vf_token(cfg);
+	TEST_ASSERT(memcmp(*p, bytes, sizeof(bytes)) == 0,
+		"Token roundtrip mismatch");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
+/* Test set/get_user_mbuf_pool_ops_name. */
+static int
+test_eal_cfg_mbuf_pool_ops(void)
+{
+	struct rte_eal_cfg *cfg;
+
+	/* NULL cfg */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_user_mbuf_pool_ops_name(NULL, "ring_mp_mc") == -1,
+		"Expected -1 for NULL cfg");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for NULL cfg, got %d", rte_errno);
+	TEST_ASSERT(rte_eal_cfg_get_user_mbuf_pool_ops_name(NULL) == NULL,
+		"Expected NULL from get with NULL cfg");
+
+	cfg = rte_eal_cfg_create();
+	TEST_ASSERT_NOT_NULL(cfg, "rte_eal_cfg_create returned NULL");
+
+	/* default: NULL */
+	TEST_ASSERT(rte_eal_cfg_get_user_mbuf_pool_ops_name(cfg) == NULL,
+		"Expected NULL before any set");
+
+	/* empty string → EINVAL */
+	rte_errno = 0;
+	TEST_ASSERT(rte_eal_cfg_set_user_mbuf_pool_ops_name(cfg, "") == -1,
+		"Expected -1 for empty name");
+	TEST_ASSERT(rte_errno == EINVAL,
+		"Expected EINVAL for empty name, got %d", rte_errno);
+
+	/* valid set and get roundtrip */
+	TEST_ASSERT(rte_eal_cfg_set_user_mbuf_pool_ops_name(cfg, "ring_mp_mc") == 0,
+		"Expected 0 for valid name");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_user_mbuf_pool_ops_name(cfg), "ring_mp_mc") == 0,
+		"Name roundtrip mismatch");
+
+	/* overwrite */
+	TEST_ASSERT(rte_eal_cfg_set_user_mbuf_pool_ops_name(cfg, "stack") == 0,
+		"Expected 0 for overwrite");
+	TEST_ASSERT(strcmp(rte_eal_cfg_get_user_mbuf_pool_ops_name(cfg), "stack") == 0,
+		"Overwrite name mismatch");
+
+	rte_eal_cfg_free(cfg);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite eal_cfg_testsuite = {
 	.suite_name = "EAL cfg API tests",
 	.setup = NULL,
@@ -1103,8 +1305,11 @@ static struct unit_test_suite eal_cfg_testsuite = {
 		TEST_CASE(test_eal_cfg_in_memory),
 		TEST_CASE(test_eal_cfg_devopt),
 		TEST_CASE(test_eal_cfg_plugin),
+		TEST_CASE(test_eal_cfg_trace),
 		TEST_CASE(test_eal_cfg_lcore),
 		TEST_CASE(test_eal_cfg_service_lcore),
+		TEST_CASE(test_eal_cfg_vfio_vf_token),
+		TEST_CASE(test_eal_cfg_mbuf_pool_ops),
 		TEST_CASES_END()
 	}
 };
diff --git a/lib/eal_cfg/eal_cfg.c b/lib/eal_cfg/eal_cfg.c
index 258e4fa11b..6bc4975b8d 100644
--- a/lib/eal_cfg/eal_cfg.c
+++ b/lib/eal_cfg/eal_cfg.c
@@ -15,6 +15,7 @@
 #include <eal_export.h>
 #include <rte_bitops.h>
 #include <rte_devargs.h>
+#include <rte_uuid.h>
 #include <rte_errno.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
@@ -611,6 +612,92 @@ rte_eal_cfg_add_plugin(struct rte_eal_cfg *cfg, const char *path)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_add_trace_pattern, 26.07)
+int
+rte_eal_cfg_add_trace_pattern(struct rte_eal_cfg *cfg, const char *pattern)
+{
+	struct eal_trace_arg *ta;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (pattern == NULL || pattern[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: pattern is NULL or empty", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	ta = malloc(sizeof(*ta));
+	if (ta == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	ta->val = strdup(pattern);
+	if (ta->val == NULL) {
+		free(ta);
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	STAILQ_INSERT_TAIL(&cfg->user_cfg.trace_patterns, ta, next);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_trace_dir, 26.07)
+int
+rte_eal_cfg_set_trace_dir(struct rte_eal_cfg *cfg, const char *dir)
+{
+	char *copy;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (dir == NULL || dir[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: dir is NULL or empty", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	copy = strdup(dir);
+	if (copy == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	free(cfg->user_cfg.trace_dir);
+	cfg->user_cfg.trace_dir = copy;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_trace_dir, 26.07)
+EAL_CFG_GETTER(const char *, trace_dir, NULL)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_trace_bufsz, 26.07)
+int
+rte_eal_cfg_set_trace_bufsz(struct rte_eal_cfg *cfg, uint64_t bufsz)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+	cfg->user_cfg.trace_bufsz = bufsz;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_trace_bufsz, 26.07)
+EAL_CFG_GETTER(uint64_t, trace_bufsz, 0)
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_trace_mode, 26.07)
+int
+rte_eal_cfg_set_trace_mode(struct rte_eal_cfg *cfg, enum rte_trace_mode mode)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+
+	if (mode != RTE_TRACE_MODE_OVERWRITE && mode != RTE_TRACE_MODE_DISCARD) {
+		EAL_CFG_LOG(ERR, "%s: invalid trace mode %d", __func__, (int)mode);
+		rte_errno = EINVAL;
+		return -1;
+	}
+	cfg->user_cfg.trace_mode = mode;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_trace_mode, 26.07)
+EAL_CFG_GETTER(enum rte_trace_mode, trace_mode, RTE_TRACE_MODE_OVERWRITE)
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_lcore, 26.07)
 int
 rte_eal_cfg_set_lcore(struct rte_eal_cfg *cfg, unsigned int lcore_id,
@@ -742,6 +829,53 @@ rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap)
 	return 0;
 }
 
+/* --- VFIO VF token --- */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_vfio_vf_token, 26.07)
+int
+rte_eal_cfg_set_vfio_vf_token(struct rte_eal_cfg *cfg, const rte_uuid_t token)
+{
+	CFG_REQUIRE_NOT_NULL(cfg);
+	rte_uuid_copy(cfg->user_cfg.vfio_vf_token, token);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_vfio_vf_token, 26.07)
+const rte_uuid_t *
+rte_eal_cfg_get_vfio_vf_token(const struct rte_eal_cfg *cfg)
+{
+	if (cfg == NULL)
+		return NULL;
+	return &cfg->user_cfg.vfio_vf_token;
+}
+
+/* --- User mbuf pool ops name --- */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_set_user_mbuf_pool_ops_name, 26.07)
+int
+rte_eal_cfg_set_user_mbuf_pool_ops_name(struct rte_eal_cfg *cfg, const char *name)
+{
+	char *copy;
+
+	CFG_REQUIRE_NOT_NULL(cfg);
+	if (name == NULL || name[0] == '\0') {
+		EAL_CFG_LOG(ERR, "%s: name is NULL or empty", __func__);
+		rte_errno = EINVAL;
+		return -1;
+	}
+	copy = strdup(name);
+	if (copy == NULL) {
+		rte_errno = ENOMEM;
+		return -1;
+	}
+	free(cfg->user_cfg.user_mbuf_pool_ops_name);
+	cfg->user_cfg.user_mbuf_pool_ops_name = copy;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_user_mbuf_pool_ops_name, 26.07)
+EAL_CFG_GETTER(const char *, user_mbuf_pool_ops_name, NULL)
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_init_from_cfg, 26.07)
 int
 rte_eal_init_from_cfg(const char *progname, struct rte_eal_cfg *cfg)
diff --git a/lib/eal_cfg/rte_eal_cfg.h b/lib/eal_cfg/rte_eal_cfg.h
index 200010c40a..84dde085a0 100644
--- a/lib/eal_cfg/rte_eal_cfg.h
+++ b/lib/eal_cfg/rte_eal_cfg.h
@@ -25,9 +25,10 @@ extern "C" {
 
 #include <rte_os.h>
 #include <rte_compat.h>
-#include <rte_devargs.h>
 #include <rte_eal.h>
 #include <rte_pci_dev_feature_defs.h>
+#include <rte_trace.h>
+#include <rte_uuid.h>
 
 /**
  * Hugepage file unlink behaviour (equivalent to --huge-unlink).
@@ -657,6 +658,120 @@ __rte_experimental
 int
 rte_eal_cfg_add_plugin(struct rte_eal_cfg *cfg, const char *path);
 
+/**
+ * @}
+ */
+
+/**
+ * @name Tracing configuration
+ * @{
+ */
+
+/**
+ * Add a trace pattern (equivalent to --trace).
+ *
+ * Appends a glob pattern to select which trace points are enabled.
+ * Multiple patterns may be added; they are applied in order.
+ * Tracing is not supported on Windows; patterns are accepted but ignored.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param pattern
+ *   Glob pattern selecting trace points, e.g. "lib.eal.*".
+ *   Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL or ENOMEM.
+ */
+__rte_experimental
+int
+rte_eal_cfg_add_trace_pattern(struct rte_eal_cfg *cfg, const char *pattern);
+
+/**
+ * Set the trace output directory (equivalent to --trace-dir).
+ *
+ * Sets the directory where trace files are written. The string is copied
+ * internally; the caller does not need to keep it alive.
+ * Tracing is not supported on Windows; the value is accepted but ignored.
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param dir
+ *   Path to the output directory. Must not be NULL or empty.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL or ENOMEM.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_trace_dir(struct rte_eal_cfg *cfg, const char *dir);
+
+/**
+ * Get the configured trace output directory.
+ *
+ * @param cfg
+ *   Configuration handle. If NULL, returns NULL.
+ * @return
+ *   The trace directory string, or NULL if not set.
+ *   Valid until the next call to rte_eal_cfg_set_trace_dir() or rte_eal_cfg_free().
+ */
+__rte_experimental
+const char *
+rte_eal_cfg_get_trace_dir(const struct rte_eal_cfg *cfg);
+
+/**
+ * Set the trace buffer size in bytes (equivalent to --trace-bufsz).
+ *
+ * A value of 0 means use the default (1 MB per lcore).
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param bufsz
+ *   Buffer size in bytes.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL.
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_trace_bufsz(struct rte_eal_cfg *cfg, uint64_t bufsz);
+
+/**
+ * Get the configured trace buffer size.
+ *
+ * @param cfg
+ *   Configuration handle. If NULL, returns 0.
+ * @return
+ *   Trace buffer size in bytes, or 0 if not set (default).
+ */
+__rte_experimental
+uint64_t
+rte_eal_cfg_get_trace_bufsz(const struct rte_eal_cfg *cfg);
+
+/**
+ * Set the trace mode (equivalent to --trace-mode).
+ *
+ * @param cfg
+ *   Configuration handle. Must not be NULL.
+ * @param mode
+ *   RTE_TRACE_MODE_OVERWRITE or RTE_TRACE_MODE_DISCARD.
+ * @return
+ *   0 on success, or -1 with rte_errno set to EINVAL (NULL cfg or
+ *   unrecognised mode value).
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_trace_mode(struct rte_eal_cfg *cfg, enum rte_trace_mode mode);
+
+/**
+ * Get the configured trace mode.
+ *
+ * @param cfg
+ *   Configuration handle. If NULL, returns RTE_TRACE_MODE_OVERWRITE.
+ * @return
+ *   The trace mode.
+ */
+__rte_experimental
+enum rte_trace_mode
+rte_eal_cfg_get_trace_mode(const struct rte_eal_cfg *cfg);
+
 /**
  * @}
  */
@@ -695,6 +810,66 @@ __rte_experimental
 int
 rte_eal_cfg_set_lcores_from_affinity(struct rte_eal_cfg *cfg, bool remap);
 
+/**
+ * Set the VFIO VF token (shared secret for VFIO-PCI bound PF and VFs).
+ *
+ * Equivalent to the --vfio-vf-token EAL option.
+ *
+ * @param cfg
+ *   Configuration handle created with rte_eal_cfg_create().
+ * @param token
+ *   UUID token to set.
+ * @return
+ *   0 on success, -1 on error (rte_errno is set).
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_vfio_vf_token(struct rte_eal_cfg *cfg, const rte_uuid_t token);
+
+/**
+ * Get the VFIO VF token.
+ *
+ * Returns a pointer to the token stored inside @p cfg.
+ * The pointer is valid for the lifetime of @p cfg.
+ *
+ * @param cfg
+ *   Configuration handle, or NULL.
+ * @return
+ *   Pointer to the token, or NULL if @p cfg is NULL.
+ */
+__rte_experimental
+const rte_uuid_t *
+rte_eal_cfg_get_vfio_vf_token(const struct rte_eal_cfg *cfg);
+
+/**
+ * Set the user-defined mbuf pool ops name.
+ *
+ * Equivalent to the --mbuf-pool-ops-name EAL option.
+ *
+ * @param cfg
+ *   Configuration handle created with rte_eal_cfg_create().
+ * @param name
+ *   Pool ops name string. Must not be NULL or empty.
+ * @return
+ *   0 on success, -1 on error (rte_errno is set to EINVAL or ENOMEM).
+ */
+__rte_experimental
+int
+rte_eal_cfg_set_user_mbuf_pool_ops_name(struct rte_eal_cfg *cfg, const char *name);
+
+/**
+ * Get the user-defined mbuf pool ops name.
+ *
+ * @param cfg
+ *   Configuration handle, or NULL.
+ * @return
+ *   Pointer to the ops name string, or NULL if not set or @p cfg is NULL.
+ *   The returned pointer is owned by @p cfg; do not free it.
+ */
+__rte_experimental
+const char *
+rte_eal_cfg_get_user_mbuf_pool_ops_name(const struct rte_eal_cfg *cfg);
+
 /**
  * Initialise the EAL using a programmatic configuration handle.
  *
-- 
2.51.0

