Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857D606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D+ZP8gUB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8BA740E7C;
	Thu, 26 Nov 2026 19:15:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 34BAA40E1E
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716933; x=1827252933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gNMqgMftxtxIBvwnNrnB9YZEIRzJThEZhbrTbxMEUAk=;
 b=D+ZP8gUB5bteNHzT1YWGT2bhP/wnuCpegNYdjN6I3KjACejrg//FGRXA
 uJKWqhzqUxwuR8P3cHZkdhA9SG0BwGoL+Vlnira/YU2Xeh34IOZMOylTF
 Mcos2LNy2euyQlq3tbV+EebTQnd/shYj4ftvBK8eUfvfDKRCHiLxy+FFy
 PzM49fP3JdofM7QYjZOcvZ2AAyTYn6VrhTD04qF4NgF/ZAGrDzbvwlhVB
 0YFiCVu9Mj+Cdpst/ybiASnlQIfCipk35iH+ePY8PW2t1XSWfKihP723D
 wFSEhI2b5Iw24Mq8o1RMm5ux+bbKV9PtMHq1YDBtYtfQ2PwSsGhnvdY6p w==;
X-CSE-ConnectionGUID: Jq3cH3zETdOaeXBI0lw7QQ==
X-CSE-MsgGUID: AO/X3Ut7QGOpHlheGIRw8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633644"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633644"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:32 -0800
X-CSE-ConnectionGUID: cDEB8JgeQqewXCSF7Bx+Pw==
X-CSE-MsgGUID: FTlwvTuIQle/wD9pnKmniw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733177"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 38/39] eal: split EAL init into two stages
Date: Thu, 26 Nov 2026 18:14:11 +0000
Message-ID: <20261126181414.124094-39-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126181414.124094-1-bruce.richardson@intel.com>
References: <20260721094555.2188496-1-bruce.richardson@intel.com>
 <20261126181414.124094-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 7590ad9c8c..d0bea404fe 100644
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
@@ -1822,9 +1817,8 @@ eal_parse_pagesz_mem(char *strval, struct eal_user_cfg *user_cfg)
 }
 
 static int
-eal_parse_vfio_intr(const char *mode)
+eal_parse_vfio_intr(struct eal_user_cfg *user_cfg, const char *mode)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	static struct {
 		const char *name;
 		enum rte_intr_mode value;
@@ -1844,9 +1838,8 @@ eal_parse_vfio_intr(const char *mode)
 }
 
 static int
-eal_parse_vfio_vf_token(const char *vf_token)
+eal_parse_vfio_vf_token(struct eal_user_cfg *user_cfg, const char *vf_token)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_uuid_t uuid;
 
 	if (!rte_uuid_parse(vf_token, uuid)) {
@@ -1858,13 +1851,13 @@ eal_parse_vfio_vf_token(const char *vf_token)
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
@@ -1901,10 +1894,8 @@ eal_parse_huge_worker_stack(const char *arg)
 
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
@@ -1938,17 +1929,17 @@ eal_parse_args(void)
 
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
@@ -2038,7 +2029,7 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
+	if (args.main_lcore != NULL && eal_parse_main_lcore(user_cfg, args.main_lcore) < 0)
 		return -1;
 
 	/* memory options */
@@ -2241,13 +2232,13 @@ eal_parse_args(void)
 
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
@@ -2260,13 +2251,13 @@ eal_parse_args(void)
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
@@ -2275,7 +2266,7 @@ eal_parse_args(void)
 	if (args.huge_worker_stack != NULL) {
 		if (args.huge_worker_stack == (void *)1)
 			args.huge_worker_stack = NULL;
-		if (eal_parse_huge_worker_stack(args.huge_worker_stack) < 0) {
+		if (eal_parse_huge_worker_stack(user_cfg, args.huge_worker_stack) < 0) {
 			EAL_LOG(ERR, "invalid huge worker stack parameter");
 			return -1;
 		}
@@ -2303,25 +2294,7 @@ eal_parse_args(void)
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
index e4a69e4edf..365d22f209 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -388,20 +388,16 @@ static void rte_eal_init_alert(const char *msg)
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
@@ -426,7 +422,7 @@ rte_eal_init(int argc, char **argv)
 	/* Save and collate args at the top */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("invalid command-line arguments.");
 		rte_errno = EINVAL;
@@ -442,6 +438,39 @@ rte_eal_init(int argc, char **argv)
 
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
@@ -456,8 +485,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -757,11 +788,10 @@ rte_eal_init(int argc, char **argv)
 
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
index 6824e0f06b..89a04d183d 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -548,19 +548,16 @@ eal_worker_thread_create(unsigned int lcore_id)
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
@@ -585,7 +582,7 @@ rte_eal_init(int argc, char **argv)
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -601,6 +598,39 @@ rte_eal_init(int argc, char **argv)
 
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
@@ -615,8 +645,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -940,12 +972,10 @@ rte_eal_init(int argc, char **argv)
 
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
index f1a159bf48..6a93a8dd21 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -151,19 +151,14 @@ rte_eal_cleanup(void)
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
@@ -180,7 +175,7 @@ rte_eal_init(int argc, char **argv)
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);
 
-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -196,6 +191,38 @@ rte_eal_init(int argc, char **argv)
 
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
@@ -203,8 +230,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -423,10 +452,10 @@ rte_eal_init(int argc, char **argv)
 
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
2.55.0

