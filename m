Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBACCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:04:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E6FB41104;
	Wed, 29 Apr 2026 18:59:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id E605740A70;
 Wed, 29 Apr 2026 18:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481987; x=1809017987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oSVIOASQs9tnFJEP21JrB9ph1T4cBvcgM60LObSA4mA=;
 b=RhoLE3/Ta5anS+BopL0FXZEwmh5yzwSzuV/1FVO9+zE2h/3ddaMuzINk
 3eaOcXzosw3cdJkScUom9MI5UCWaBmZTTnehIU702hkQns7oQLBWI1pFL
 wWo58pzCVUbUgtwS4nI5ufr61eeMvE8ML6hcf3S8IiRlVVszjnbExB6E9
 rNRIxdcTU5spWMvgzMgRQ0X48KPIHc0ndDeddFysAIYyzQP/6ZbEwP8WU
 dClkLMNSDns/X2uZQjdAg2CuzDgI+40ZoOuhVTTUOaqwn6zNwHoKr/QjA
 UZ9bOfmXIHDbj4mKyx72UIHxnJC7IlVTZrkcmS+6JSy9elY1aO02A81ja w==;
X-CSE-ConnectionGUID: zT/cYN4VT1q4twT9dWvEdw==
X-CSE-MsgGUID: KkjKstE8Rh2VDBsUJLzOUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725382"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:45 -0700
X-CSE-ConnectionGUID: KT9Ht3lqT1Gkuitvzpd0uQ==
X-CSE-MsgGUID: 50xd373ITVKy64R3AjLa6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697201"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 35/44]  eal: split EAL init into two stages
Date: Wed, 29 Apr 2026 17:58:27 +0100
Message-ID: <20260429165845.2136843-36-bruce.richardson@intel.com>
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

Split the rte_eal_init function into two parts, where the first part is
handling the argument parsing and then calling the second part which
does the actual subsystem initialization. To keep the split clean and
make the user_cfg the point of data transfer between the two, update
functions in eal_common_options.c to take the user_cfg as parameter
rather than relying on the EAL global.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

Note: to avoid having a massive diff - and therefore make reviewing
easier - I have kept the second function below the first, rather than
putting it above. A forward declaration of the function is enough to
keep the compiler happy, and the result shows clearly the split of the
function into two.

---
 lib/eal/common/eal_common_options.c | 69 +++++++++--------------------
 lib/eal/common/eal_options.h        |  2 +-
 lib/eal/freebsd/eal.c               | 56 +++++++++++++++++------
 lib/eal/linux/eal.c                 | 54 +++++++++++++++++-----
 lib/eal/windows/eal.c               | 55 +++++++++++++++++------
 5 files changed, 149 insertions(+), 87 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 32984cb8eb..4cae4cd43f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -410,9 +410,8 @@ eal_clean_saved_args(void)
 #endif /* !RTE_EXEC_ENV_WINDOWS */

 static int
-eal_option_device_add(enum rte_devtype type, const char *arg)
+eal_option_device_add(struct eal_user_cfg *user_cfg, enum rte_devtype type, const char *arg)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct device_option *devopt;
 	size_t arglen;
 	int ret;
@@ -467,9 +466,8 @@ eal_get_hugefile_prefix(void)
 }

 static int
-eal_plugin_path_add(const char *path)
+eal_plugin_path_add(struct eal_user_cfg *user_cfg, const char *path)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	struct eal_plugin_path *p;

 	p = malloc(sizeof(*p));
@@ -1001,10 +999,9 @@ rte_eal_parse_coremask(const char *coremask, rte_cpuset_t *cpuset, bool limit_ra

 /* Changes the lcore id of the main thread */
 static int
-eal_parse_main_lcore(const char *arg)
+eal_parse_main_lcore(struct eal_user_cfg *user_cfg, const char *arg)
 {
 	char *parsing_end;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();

 	errno = 0;
 	user_cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);
@@ -1438,10 +1435,9 @@ eal_parse_proc_type(const char *arg)
 }

 static int
-eal_parse_iova_mode(const char *name)
+eal_parse_iova_mode(struct eal_user_cfg *user_cfg, const char *name)
 {
 	int mode;
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();

 	if (name == NULL)
 		return -1;
@@ -1485,11 +1481,10 @@ eal_parse_simd_bitwidth(const char *arg)
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
@@ -1712,9 +1707,8 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 }

 static int
-eal_parse_vfio_intr(const char *mode)
+eal_parse_vfio_intr(struct eal_user_cfg *user_cfg, const char *mode)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	static struct {
 		const char *name;
 		enum rte_intr_mode value;
@@ -1734,9 +1728,8 @@ eal_parse_vfio_intr(const char *mode)
 }

 static int
-eal_parse_vfio_vf_token(const char *vf_token)
+eal_parse_vfio_vf_token(struct eal_user_cfg *user_cfg, const char *vf_token)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_uuid_t uuid;

 	if (!rte_uuid_parse(vf_token, uuid)) {
@@ -1748,13 +1741,13 @@ eal_parse_vfio_vf_token(const char *vf_token)
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
@@ -1791,10 +1784,8 @@ eal_parse_huge_worker_stack(const char *arg)

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
@@ -1828,17 +1819,17 @@ eal_parse_args(void)

 	/* device -a/-b/-vdev options*/
 	TAILQ_FOREACH(arg, &args.allow, next)
-		if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
+		if (eal_option_device_add(user_cfg,RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
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
@@ -1928,7 +1919,7 @@ eal_parse_args(void)
 			return -1;
 		}
 	}
-	if (args.main_lcore != NULL && eal_parse_main_lcore(args.main_lcore) < 0)
+	if (args.main_lcore != NULL && eal_parse_main_lcore(user_cfg, args.main_lcore) < 0)
 		return -1;

 	/* memory options */
@@ -2107,13 +2098,13 @@ eal_parse_args(void)

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
@@ -2126,13 +2117,13 @@ eal_parse_args(void)
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
@@ -2141,7 +2132,7 @@ eal_parse_args(void)
 	if (args.huge_worker_stack != NULL) {
 		if (args.huge_worker_stack == (void *)1)
 			args.huge_worker_stack = NULL;
-		if (eal_parse_huge_worker_stack(args.huge_worker_stack) < 0) {
+		if (eal_parse_huge_worker_stack(user_cfg, args.huge_worker_stack) < 0) {
 			EAL_LOG(ERR, "invalid huge worker stack parameter");
 			return -1;
 		}
@@ -2169,25 +2160,7 @@ eal_parse_args(void)
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
index 4f4b9accfe..5e9348a2cd 100644
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

 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -415,7 +411,7 @@ rte_eal_init(int argc, char **argv)
 	/* Save and collate args at the top */
 	eal_save_args(argc, argv);

-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("invalid command-line arguments.");
 		rte_errno = EINVAL;
@@ -431,6 +427,39 @@ rte_eal_init(int argc, char **argv)

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
@@ -445,8 +474,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -740,11 +771,10 @@ rte_eal_init(int argc, char **argv)

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
index 1bf519eb10..75d03e3b3c 100644
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

 	/* first check if we have been run before */
 	if (!rte_atomic_compare_exchange_strong_explicit(&run_once, &has_run, 1,
@@ -577,7 +574,7 @@ rte_eal_init(int argc, char **argv)
 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);

-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -593,6 +590,39 @@ rte_eal_init(int argc, char **argv)

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
@@ -607,8 +637,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -914,12 +946,10 @@ rte_eal_init(int argc, char **argv)

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
index ed293ada8f..021361a802 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -146,24 +146,19 @@ rte_eal_cleanup(void)
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

 	/* clone argv to report out later in telemetry */
 	eal_save_args(argc, argv);

-	fctret = eal_collate_args(argc, argv);
+	int fctret = eal_collate_args(argc, argv);
 	if (fctret < 0) {
 		rte_eal_init_alert("Invalid command line arguments.");
 		rte_errno = EINVAL;
@@ -179,6 +174,38 @@ rte_eal_init(int argc, char **argv)

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
@@ -186,8 +213,10 @@ rte_eal_init(int argc, char **argv)
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
@@ -400,10 +429,10 @@ rte_eal_init(int argc, char **argv)

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
2.51.0

