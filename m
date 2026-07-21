Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B470C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF21B410FD;
	Tue, 21 Jul 2026 11:46:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9A796410D2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627202; x=1816163202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S1cHOqYxtWpsT99Yk8o4VdoCkaxavWwE26OlJIi8p94=;
 b=jr8UBxQNDtxZm4GP4CvIEgebzzR3iwjts73zbRORnLo3GD8lsnQKBiNF
 qx0oY55fWCrmuelSuYUXS7P9XCNyvAgWL+HcCIYC7pWqcKsBEGLI0+YuX
 E1SyQ+6p/RfVyjpCiO/v1TfUSE4kk6rvuugDgLgCH12NE54rmS45hai5D
 uL8t1SkZPdbDJPrWyDMETVYE0qqKPu8Vd0FjO06NjsDsYz9dwrPw0ip9I
 ytNw9lvaDRP5FOUeF/5Bnes1s6u2rdrmIfgJ8b4SBFDe5aDrM0iio2D2T
 3DDIftClO7O+fYx4wtqOOfg1Sbrbf+/XJYmGFbYOGoMx45q8K/9xuHZ/W Q==;
X-CSE-ConnectionGUID: 5P9v8FLKQrmhcds0v9+EmQ==
X-CSE-MsgGUID: 1+Yg7JnWTICSpxf/pElemA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872524"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:41 -0700
X-CSE-ConnectionGUID: 9tKqlyi3SnCLszr/WVupDA==
X-CSE-MsgGUID: TzcU2w1NQouYo2NJ12jF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922483"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 38/39] eal: split EAL init into two stages
Date: Tue, 21 Jul 2026 10:45:46 +0100
Message-ID: <20260721094555.2188496-39-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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

Split the rte_eal_init function into two parts, where the first part is
handling the argument parsing and then calling the second part which
does the actual subsystem initialization.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 69 +++++++++--------------------
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/freebsd/eal.c               | 56 +++++++++++++++++------
 lib/eal/linux/eal.c                 | 54 +++++++++++++++++-----
 lib/eal/windows/eal.c               | 55 +++++++++++++++++------
 5 files changed, 149 insertions(+), 87 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 39dbc67f1f..ab70edd36c 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -426,9 +426,8 @@ eal_clean_saved_args(void)
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 static int
-eal_option_device_add(enum rte_devtype type, const char *arg)
+eal_option_device_add(struct eal_user_cfg *user_cfg, enum rte_devtype type, const char *arg)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct device_option *devopt;
 	size_t arglen;
 	int ret;
@@ -483,9 +482,8 @@ eal_get_hugefile_prefix(void)
 }
 
 static int
-eal_plugin_path_add(const char *path)
+eal_plugin_path_add(struct eal_user_cfg *user_cfg, const char *path)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_plugin_path *p;
 
 	p = malloc(sizeof(*p));
@@ -1021,11 +1019,10 @@ rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_ra
 
 /* Changes the lcore id of the main thread */
 static int
-eal_parse_main_lcore(const char *arg)
+eal_parse_main_lcore(struct eal_user_cfg *user_cfg, const char *arg)
 {
 	char *parsing_end;
 	long main_lcore;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	errno = 0;
 	main_lcore = strtol(arg, &parsing_end, 0);
@@ -1459,10 +1456,9 @@ eal_parse_proc_type(const char *arg)
 }
 
 static int
-eal_parse_iova_mode(const char *name)
+eal_parse_iova_mode(struct eal_user_cfg *user_cfg, const char *name)
 {
 	int mode;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (name == NULL)
 		return -1;
@@ -1506,11 +1502,10 @@ eal_parse_simd_bitwidth(const char *arg)
 }
 
 static int
-eal_parse_base_virtaddr(const char *arg)
+eal_parse_base_virtaddr(struct eal_user_cfg *user_cfg, const char *arg)
 {
 	char *end;
 	uint64_t addr;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	errno = 0;
 	addr = strtoull(arg, &end, 16);
@@ -1823,9 +1818,8 @@ eal_parse_pagesz_mem(char *strval, struct eal_user_cfg *user_cfg)
 }
 
 static int
-eal_parse_vfio_intr(const char *mode)
+eal_parse_vfio_intr(struct eal_user_cfg *user_cfg, const char *mode)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	static struct {
 		const char *name;
 		enum rte_intr_mode value;
@@ -1845,9 +1839,8 @@ eal_parse_vfio_intr(const char *mode)
 }
 
 static int
-eal_parse_vfio_vf_token(const char *vf_token)
+eal_parse_vfio_vf_token(struct eal_user_cfg *user_cfg, const char *vf_token)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_uuid_t uuid;
 
 	if (!rte_uuid_parse(vf_token, uuid)) {
@@ -1859,13 +1852,13 @@ eal_parse_vfio_vf_token(const char *vf_token)
 }
 
 static int
-eal_parse_huge_worker_stack(const char *arg)
+eal_parse_huge_worker_stack(struct eal_user_cfg *user_cfg, const char *arg)
 {
 #ifdef RTE_EXEC_ENV_WINDOWS
 	EAL_LOG(WARNING, "Cannot set worker stack size on Windows, parameter ignored");
+	RTE_SET_USED(user_cfg);
 	RTE_SET_USED(arg);
 #else
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 
 	if (arg == NULL || arg[0] == '\0') {
 		pthread_attr_t attr;
@@ -1902,10 +1895,8 @@ eal_parse_huge_worker_stack(const char *arg)
 
 /* Parse the arguments given in the command line of the application */
 int
-eal_parse_args(void)
+eal_parse_args(struct eal_user_cfg *user_cfg)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
 	/*
 	 * Initialise user_cfg to defaults. Fields not listed here are zero,
 	 * false or NULL, which is the correct default (RTE_PROC_PRIMARY,
@@ -1939,17 +1930,17 @@ eal_parse_args(void)
 
 	/* device -a/-b/-vdev options*/
 	TAILQ_FOREACH(arg, &args.allow, next)
-		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
+		if (eal_option_device_add(user_cfg, RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
 			return -1;
 	TAILQ_FOREACH(arg, &args.block, next)
-		if (eal_option_device_add(RTE_DEVTYPE_BLOCKED, arg->arg) < 0)
+		if (eal_option_device_add(user_cfg, RTE_DEVTYPE_BLOCKED, arg->arg) < 0)
 			return -1;
 	TAILQ_FOREACH(arg, &args.vdev, next)
-		if (eal_option_device_add(RTE_DEVTYPE_VIRTUAL, arg->arg) < 0)
+		if (eal_option_device_add(user_cfg, RTE_DEVTYPE_VIRTUAL, arg->arg) < 0)
 			return -1;
 	/* driver loading options */
 	TAILQ_FOREACH(arg, &args.driver_path, next)
-		if (eal_plugin_path_add(arg->arg) < 0)
+		if (eal_plugin_path_add(user_cfg, arg->arg) < 0)
 			return -1;
 
 	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
@@ -2039,7 +2030,7 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
+	if (args.main_lcore != NULL && eal_parse_main_lcore(user_cfg, args.main_lcore) < 0)
 		return -1;
 
 	/* memory options */
@@ -2242,13 +2233,13 @@ eal_parse_args(void)
 
 	/* other misc settings */
 	if (args.iova_mode != NULL) {
-		if (eal_parse_iova_mode(args.iova_mode) < 0) {
+		if (eal_parse_iova_mode(user_cfg, args.iova_mode) < 0) {
 			EAL_LOG(ERR, "invalid iova mode parameter '%s'", args.iova_mode);
 			return -1;
 		}
 	};
 	if (args.base_virtaddr != NULL) {
-		if (eal_parse_base_virtaddr(args.base_virtaddr) < 0) {
+		if (eal_parse_base_virtaddr(user_cfg, args.base_virtaddr) < 0) {
 			EAL_LOG(ERR, "invalid base virtaddr '%s'", args.base_virtaddr);
 			return -1;
 		}
@@ -2261,13 +2252,13 @@ eal_parse_args(void)
 		}
 	}
 	if (args.vfio_intr != NULL) {
-		if (eal_parse_vfio_intr(args.vfio_intr) < 0) {
+		if (eal_parse_vfio_intr(user_cfg, args.vfio_intr) < 0) {
 			EAL_LOG(ERR, "invalid vfio interrupt parameter: '%s'", args.vfio_intr);
 			return -1;
 		}
 	}
 	if (args.vfio_vf_token != NULL) {
-		if (eal_parse_vfio_vf_token(args.vfio_vf_token) < 0) {
+		if (eal_parse_vfio_vf_token(user_cfg, args.vfio_vf_token) < 0) {
 			EAL_LOG(ERR, "invalid vfio vf token parameter: '%s'", args.vfio_vf_token);
 			return -1;
 		}
@@ -2276,7 +2267,7 @@ eal_parse_args(void)
 	if (args.huge_worker_stack != NULL) {
 		if (args.huge_worker_stack == (void *)1)
 			args.huge_worker_stack = NULL;
-		if (eal_parse_huge_worker_stack(args.huge_worker_stack) < 0) {
+		if (eal_parse_huge_worker_stack(user_cfg, args.huge_worker_stack) < 0) {
 			EAL_LOG(ERR, "invalid huge worker stack parameter");
 			return -1;
 		}
@@ -2304,25 +2295,7 @@ eal_parse_args(void)
 int
 eal_cleanup_config(void)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_trace_arg *ta;
-
-	/* free trace patterns list */
-	while (!STAILQ_EMPTY(&user_cfg->trace_patterns)) {
-		ta = STAILQ_FIRST(&user_cfg->trace_patterns);
-		STAILQ_REMOVE_HEAD(&user_cfg->trace_patterns, next);
-		free(ta->val);
-		free(ta);
-	}
-	free(user_cfg->trace_dir);
-	free(user_cfg->hugefile_prefix);
-	free(user_cfg->hugepage_dir);
-	free(user_cfg->user_mbuf_pool_ops_name);
-	for (unsigned int i = 0; i < RTE_MAX_LCORE; i++) {
-		free(user_cfg->lcore_cpusets[i]);
-		user_cfg->lcore_cpusets[i] = NULL;
-	}
-
+	eal_user_cfg_cleanup(eal_get_user_configuration());
 	return 0;
 }
 
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 77a6a4405f..afa8449ee7 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -11,7 +11,7 @@ struct rte_tel_data;
 struct eal_user_cfg;
 
 int eal_parse_log_options(void);
-int eal_parse_args(void);
+int eal_parse_args(struct eal_user_cfg *user_cfg);
 int eal_option_device_parse(void);
 int eal_cleanup_config(void);
 int eal_plugins_init(void);
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index b3bbc5565c..307b01f840 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -389,20 +389,16 @@ static void rte_eal_init_alert(const char *msg)
 	EAL_LOG(ALERT, "%s", msg);
 }
 
+static int eal_runtime_init(const struct eal_user_cfg *user_provided_cfg);
+
 /* Launch threads, called at application init(). */
 RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	int i, fctret, ret;
 	static uint32_t run_once;
+	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
-	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
-	char thread_name[RTE_THREAD_NAME_SIZE];
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	bool has_phys_addr;
-	enum rte_iova_mode iova_mode;
 
 	/*
 	 * platform_info is lazily initialized on first use, and that
@@ -427,7 +423,7 @@ rte_eal_init(int argc, char **argv)
 	/* Save and collate args at the top */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("invalid command-line arguments.");
 		rte_errno = EINVAL;
@@ -443,6 +439,39 @@ rte_eal_init(int argc, char **argv)
 
 	eal_log_init(getprogname());
 
+	if (eal_parse_args(&user_cfg_from_args) < 0) {
+		rte_eal_init_alert("Error parsing command-line arguments.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
+	if (eal_runtime_init(&user_cfg_from_args) < 0)
+		goto err_out;	/* log message and rte_errno set by eal_runtime_init() */
+
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+	return fctret;
+
+err_out:
+	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_clean_saved_args();
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+	return -1;
+}
+
+/**
+ * take a provided user config, copy it to the internal user config structure
+ * and then use it to initialize the DPDK runtime.
+ */
+static int
+eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
+{
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
+	char thread_name[RTE_THREAD_NAME_SIZE];
+	bool has_phys_addr;
+	enum rte_iova_mode iova_mode;
+	int i, ret;
+
 	/* checks if the machine is adequate */
 	if (!rte_cpu_is_supported()) {
 		rte_eal_init_alert("unsupported cpu type.");
@@ -457,8 +486,10 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (eal_parse_args() < 0) {
-		rte_eal_init_alert("Error parsing command-line arguments.");
+	/* Copy user-provided configuration to EAL global configuration */
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	if (eal_user_cfg_copy(user_cfg, user_provided_cfg) < 0) {
+		rte_eal_init_alert("Cannot copy user configuration.");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
@@ -758,11 +789,10 @@ rte_eal_init(int argc, char **argv)
 
 	eal_mcfg_complete();
 
-	return fctret;
+	return 0;
+
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
 	eal_cleanup_config();
-	eal_clean_saved_args();
 	return -1;
 }
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index c5b3b73c4a..920b8cb71a 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -552,19 +552,16 @@ eal_worker_thread_create(unsigned int lcore_id)
 	return ret;
 }
 
+static int eal_runtime_init(const struct eal_user_cfg *user_provided_cfg);
+
 /* Launch threads, called at application init(). */
 RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	int i, fctret, ret;
 	static RTE_ATOMIC(uint32_t) run_once;
+	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 	uint32_t has_run = 0;
-	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
-	char thread_name[RTE_THREAD_NAME_SIZE];
-	bool phys_addrs;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
 
 	/*
 	 * platform_info is lazily initialized on first use, and that
@@ -589,7 +586,7 @@ rte_eal_init(int argc, char **argv)
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -605,6 +602,39 @@ rte_eal_init(int argc, char **argv)
 
 	eal_log_init(program_invocation_short_name);
 
+	if (eal_parse_args(&user_cfg_from_args) < 0) {
+		rte_eal_init_alert("Error parsing command line arguments.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
+	if (eal_runtime_init(&user_cfg_from_args) < 0)
+		goto err_out;   /* log message and rte_errno set by eal_runtime_init() */
+
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+	return fctret;
+
+err_out:
+	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
+	eal_clean_saved_args();
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+
+	return -1;
+}
+
+/**
+ * take a provided user config, copy it to the internal user config structure
+ * and then use it to initialize the DPDK runtime.
+ */
+static int
+eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
+{
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
+	char thread_name[RTE_THREAD_NAME_SIZE];
+	bool phys_addrs;
+	int i, ret;
+
 	/* checks if the machine is adequate */
 	if (!rte_cpu_is_supported()) {
 		rte_eal_init_alert("unsupported cpu type.");
@@ -619,8 +649,10 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (eal_parse_args() < 0) {
-		rte_eal_init_alert("Error parsing command line arguments.");
+	/* Copy user-provided configuration to EAL global configuration */
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	if (eal_user_cfg_copy(user_cfg, user_provided_cfg) < 0) {
+		rte_eal_init_alert("Cannot copy user configuration.");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
@@ -932,12 +964,10 @@ rte_eal_init(int argc, char **argv)
 
 	eal_mcfg_complete();
 
-	return fctret;
+	return 0;
 
 err_out:
-	rte_atomic_store_explicit(&run_once, 0, rte_memory_order_relaxed);
 	eal_cleanup_config();
-	eal_clean_saved_args();
 	return -1;
 }
 
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 568d364d8d..720a1e0502 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -146,19 +146,14 @@ rte_eal_cleanup(void)
 	return 0;
 }
 
+static int eal_runtime_init(const struct eal_user_cfg *user_provided_cfg);
+
 /* Launch threads, called at application init(). */
 RTE_EXPORT_SYMBOL(rte_eal_init)
 int
 rte_eal_init(int argc, char **argv)
 {
-	int i, fctret, bscan;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-	bool has_phys_addr;
-	enum rte_iova_mode iova_mode;
-	int ret;
-	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
-	char thread_name[RTE_THREAD_NAME_SIZE];
+	struct eal_user_cfg user_cfg_from_args = EAL_USER_CFG_INITIALIZER(user_cfg_from_args);
 
 	/*
 	 * platform_info is lazily initialized on first use, and that
@@ -175,7 +170,7 @@ rte_eal_init(int argc, char **argv)
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -191,6 +186,38 @@ rte_eal_init(int argc, char **argv)
 
 	eal_log_init(NULL);
 
+	if (eal_parse_args(&user_cfg_from_args) < 0) {
+		rte_eal_init_alert("Invalid command line arguments.");
+		rte_errno = EINVAL;
+		goto err_out;
+	}
+
+	if (eal_runtime_init(&user_cfg_from_args) < 0)
+		goto err_out;	/* log message and rte_errno set by eal_runtime_init() */
+
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+	return fctret;
+
+err_out:
+	eal_clean_saved_args();
+	eal_user_cfg_cleanup(&user_cfg_from_args);
+	return -1;
+}
+
+/**
+ * take a provided user config, copy it to the internal user config structure
+ * and then use it to initialize the DPDK runtime.
+ */
+static int
+eal_runtime_init(const struct eal_user_cfg *user_provided_cfg)
+{
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	bool has_phys_addr;
+	enum rte_iova_mode iova_mode;
+	int i, ret, bscan;
+	char cpuset[RTE_CPU_AFFINITY_STR_LEN];
+	char thread_name[RTE_THREAD_NAME_SIZE];
+
 	/* verify if DPDK supported on architecture MMU */
 	if (!eal_mmu_supported()) {
 		rte_eal_init_alert("Unsupported MMU type.");
@@ -198,8 +225,10 @@ rte_eal_init(int argc, char **argv)
 		goto err_out;
 	}
 
-	if (eal_parse_args() < 0) {
-		rte_eal_init_alert("Invalid command line arguments.");
+	/* Copy user-provided configuration to EAL global configuration */
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	if (eal_user_cfg_copy(user_cfg, user_provided_cfg) < 0) {
+		rte_eal_init_alert("Cannot copy user configuration.");
 		rte_errno = EINVAL;
 		goto err_out;
 	}
@@ -418,10 +447,10 @@ rte_eal_init(int argc, char **argv)
 
 	eal_mcfg_complete();
 
-	return fctret;
+	return 0;
+
 err_out:
 	eal_cleanup_config();
-	eal_clean_saved_args();
 	return -1;
 }
 
-- 
2.53.0

