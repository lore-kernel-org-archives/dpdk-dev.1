Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8DFCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DBA5410D0;
	Wed, 29 Apr 2026 18:59:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B0D8840EA5;
 Wed, 29 Apr 2026 18:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481970; x=1809017970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fRdnO3C2521c3yXI6GhUF2CfRqsNP1DHS6z/cyPI1CM=;
 b=IGNgrgMCtvwrhi4vlys8pqXv/84086q1HryDBdiZCscx2s8H+xmhJisN
 x+PtwbFagbjRIVWphy3uSFuSNxzH2SnKerW0zZkHi0RwYbQDMFz182AUc
 XN+ly3HBlXBzE01QowUT9SjiJhF75PRLHcqTK7uv9TF0guJSDCQmNjTa0
 irypkPRKqV+zk7zczVotvkkrol8eb8IZr2IRtv1MDErJ5ME551JXEgrWC
 RW3KlQ3APfPrz+GJLbnGPwbCPcwDPiUOr1RBlgAAzEE7rPdeBudEdDuon
 2kSS9DUDcpTpwdGlPCwSSNU1WH3wJvHUcr0g3zPfYFYRacu9SKjlPCrmi A==;
X-CSE-ConnectionGUID: q+w1kIkgRR2yxPz6J4NB4A==
X-CSE-MsgGUID: pNmtpbp+Q5alWJxHwJ6IxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725345"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:29 -0700
X-CSE-ConnectionGUID: hDQ2b9QQQnK+esQVeFeclQ==
X-CSE-MsgGUID: AkBvAj1jSgCMvbRjXrQtQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697022"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 26/44] eal: move trace config into user config struct
Date: Wed, 29 Apr 2026 17:58:18 +0100
Message-ID: <20260429165845.2136843-27-bruce.richardson@intel.com>
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

The trace settings (pattern list, directory, buffer size, mode) were
previously stored directly in the internal struct trace singleton during
arg parsing, via helper functions. Move these setting into eal_user_cfg
and drop the helper functions.

NOTE: after these changes, eal_cleanup_config needs a non-const user
config pointer to cleanup. Rather than making the pointer in
rte_eal_cleanup non-const, make eal_cleanup_config like all the other
functions in the cleanup chain in taking no parameters. Then it can
define its own non-const user config pointer internally.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c     |  53 ++++++++++--
 lib/eal/common/eal_common_trace.c       |  30 +++++--
 lib/eal/common/eal_common_trace_utils.c | 104 ------------------------
 lib/eal/common/eal_internal_cfg.h       |  15 ++++
 lib/eal/common/eal_options.h            |   2 +-
 lib/eal/common/eal_trace.h              |  11 ---
 lib/eal/freebsd/eal.c                   |   3 +-
 lib/eal/linux/eal.c                     |   2 +-
 lib/eal/windows/eal.c                   |   4 +-
 9 files changed, 87 insertions(+), 137 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 835e518e2c..18d6ee3f5a 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -14,6 +14,7 @@
 #include <sys/queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <dlfcn.h>
+#include <fnmatch.h>
 #include <libgen.h>
 #endif
 #include <sys/stat.h>
@@ -475,6 +476,7 @@ eal_reset_internal_config(void)
 
 	TAILQ_INIT(&user_cfg->devopt_list);
 	TAILQ_INIT(&user_cfg->plugin_list);
+	STAILQ_INIT(&user_cfg->trace_patterns);
 	TAILQ_INIT(&runtime_state->loaded_plugins);
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
@@ -2178,28 +2180,56 @@ eal_parse_args(void)
 		EAL_LOG(WARNING, "Tracing is not supported on Windows, ignoring tracing parameters");
 #else
 	TAILQ_FOREACH(arg, &args.trace, next) {
-		if (eal_trace_args_save(arg->arg) < 0) {
-			EAL_LOG(ERR, "invalid trace parameter, '%s'", arg->arg);
+		struct eal_trace_arg *ta = malloc(sizeof(*ta));
+		if (ta == NULL) {
+			EAL_LOG(ERR, "failed to allocate trace arg for '%s'", arg->arg);
 			return -1;
 		}
+		ta->val = strdup(arg->arg);
+		if (ta->val == NULL) {
+			EAL_LOG(ERR, "failed to allocate trace arg for '%s'", arg->arg);
+			free(ta);
+			return -1;
+		}
+		STAILQ_INSERT_TAIL(&user_cfg->trace_patterns, ta, next);
 	}
 	if (args.trace_dir != NULL) {
-		if (eal_trace_dir_args_save(args.trace_dir) < 0) {
+		if (asprintf(&user_cfg->trace_dir, "%s/", args.trace_dir) == -1) {
 			EAL_LOG(ERR, "invalid trace directory, '%s'", args.trace_dir);
 			return -1;
 		}
 	}
 	if (args.trace_bufsz != NULL) {
-		if (eal_trace_bufsz_args_save(args.trace_bufsz) < 0) {
+		uint64_t bufsz = rte_str_to_size(args.trace_bufsz);
+		if (bufsz == 0) {
 			EAL_LOG(ERR, "invalid trace buffer size, '%s'", args.trace_bufsz);
 			return -1;
 		}
+		user_cfg->trace_bufsz = bufsz;
 	}
 	if (args.trace_mode != NULL) {
-		if (eal_trace_mode_args_save(args.trace_mode) < 0) {
+		size_t len = strlen(args.trace_mode);
+		char *pattern;
+		if (len == 0) {
+			EAL_LOG(ERR, "trace mode value is empty");
+			return -1;
+		}
+		pattern = calloc(1, len + 2);
+		if (pattern == NULL) {
+			EAL_LOG(ERR, "failed to allocate memory for trace mode");
+			return -1;
+		}
+		sprintf(pattern, "%s*", args.trace_mode);
+		if (fnmatch(pattern, "overwrite", 0) == 0)
+			user_cfg->trace_mode = RTE_TRACE_MODE_OVERWRITE;
+		else if (fnmatch(pattern, "discard", 0) == 0)
+			user_cfg->trace_mode = RTE_TRACE_MODE_DISCARD;
+		else {
 			EAL_LOG(ERR, "invalid trace mode, '%s'", args.trace_mode);
+			free(pattern);
 			return -1;
 		}
+		free(pattern);
 	}
 #endif
 
@@ -2318,8 +2348,19 @@ compute_ctrl_threads_cpuset(void)
 }
 
 int
-eal_cleanup_config(const struct eal_user_cfg *user_cfg)
+eal_cleanup_config(void)
 {
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_trace_arg *ta;
+
+	/* free trace patterns list */
+	while (!STAILQ_EMPTY(&user_cfg->trace_patterns)) {
+		ta = STAILQ_FIRST(&user_cfg->trace_patterns);
+		STAILQ_REMOVE_HEAD(&user_cfg->trace_patterns, next);
+		free(ta->val);
+		free(ta);
+	}
+	free(user_cfg->trace_dir);
 	free(user_cfg->hugefile_prefix);
 	free(user_cfg->hugepage_dir);
 	free(user_cfg->user_mbuf_pool_ops_name);
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index a76dff0017..3d984ac8b1 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -24,7 +24,7 @@ RTE_DEFINE_PER_LCORE(void *, trace_mem);
 static RTE_DEFINE_PER_LCORE(char *, ctf_field);
 
 static struct trace_point_head tp_list = STAILQ_HEAD_INITIALIZER(tp_list);
-static struct trace trace = { .args = STAILQ_HEAD_INITIALIZER(trace.args), };
+static struct trace trace;
 
 struct trace *
 trace_obj_get(void)
@@ -41,7 +41,8 @@ trace_list_head_get(void)
 int
 eal_trace_init(void)
 {
-	struct trace_arg *arg;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	const struct eal_trace_arg *arg;
 
 	/* Trace memory should start with 8B aligned for natural alignment */
 	RTE_BUILD_BUG_ON((offsetof(struct __rte_trace_header, mem) % 8) != 0);
@@ -58,14 +59,24 @@ eal_trace_init(void)
 	if (trace_has_duplicate_entry())
 		goto fail;
 
+	/* Copy trace directory from user config (trace.dir may be reallocated later) */
+	if (user_cfg->trace_dir != NULL) {
+		trace.dir = strdup(user_cfg->trace_dir);
+		if (trace.dir == NULL) {
+			rte_errno = ENOMEM;
+			goto fail;
+		}
+	}
+
+	/* Apply buffer size from user config, then fill in default if still 0 */
+	trace.buff_len = user_cfg->trace_bufsz;
+	trace_bufsz_args_apply();
+
 	/* Generate UUID ver 4 with total size of events and number of
 	 * events
 	 */
 	trace_uuid_generate();
 
-	/* Apply buffer size configuration for trace output */
-	trace_bufsz_args_apply();
-
 	/* Generate CTF TDSL metadata */
 	if (trace_metadata_create() < 0)
 		goto fail;
@@ -74,11 +85,11 @@ eal_trace_init(void)
 	if (trace_epoch_time_save() < 0)
 		goto free_meta;
 
-	/* Apply global configurations */
-	STAILQ_FOREACH(arg, &trace.args, next)
+	/* Apply trace pattern filters from user config */
+	STAILQ_FOREACH(arg, &user_cfg->trace_patterns, next)
 		trace_args_apply(arg->val);
 
-	rte_trace_mode_set(trace.mode);
+	rte_trace_mode_set(user_cfg->trace_mode);
 
 	return 0;
 
@@ -94,7 +105,8 @@ eal_trace_fini(void)
 {
 	trace_mem_free();
 	trace_metadata_destroy();
-	eal_trace_args_free();
+	free(trace.dir);
+	trace.dir = NULL;
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_is_enabled, 20.05)
diff --git a/lib/eal/common/eal_common_trace_utils.c b/lib/eal/common/eal_common_trace_utils.c
index e1996433b7..821036b4bb 100644
--- a/lib/eal/common/eal_common_trace_utils.c
+++ b/lib/eal/common/eal_common_trace_utils.c
@@ -2,7 +2,6 @@
  * Copyright(C) 2020 Marvell International Ltd.
  */
 
-#include <fnmatch.h>
 #include <pwd.h>
 #include <sys/stat.h>
 #include <time.h>
@@ -132,42 +131,6 @@ trace_dir_update(const char *str)
 	return rc;
 }
 
-int
-eal_trace_args_save(const char *val)
-{
-	struct trace *trace = trace_obj_get();
-	struct trace_arg *arg = malloc(sizeof(*arg));
-
-	if (arg == NULL) {
-		trace_err("failed to allocate memory for %s", val);
-		return -ENOMEM;
-	}
-
-	arg->val = strdup(val);
-	if (arg->val == NULL) {
-		trace_err("failed to allocate memory for %s", val);
-		free(arg);
-		return -ENOMEM;
-	}
-
-	STAILQ_INSERT_TAIL(&trace->args, arg, next);
-	return 0;
-}
-
-void
-eal_trace_args_free(void)
-{
-	struct trace *trace = trace_obj_get();
-	struct trace_arg *arg;
-
-	while (!STAILQ_EMPTY(&trace->args)) {
-		arg = STAILQ_FIRST(&trace->args);
-		STAILQ_REMOVE_HEAD(&trace->args, next);
-		free(arg->val);
-		free(arg);
-	}
-}
-
 int
 trace_args_apply(const char *arg)
 {
@@ -179,22 +142,6 @@ trace_args_apply(const char *arg)
 	return 0;
 }
 
-int
-eal_trace_bufsz_args_save(char const *val)
-{
-	struct trace *trace = trace_obj_get();
-	uint64_t bufsz;
-
-	bufsz = rte_str_to_size(val);
-	if (bufsz == 0) {
-		trace_err("buffer size cannot be zero");
-		return -EINVAL;
-	}
-
-	trace->buff_len = bufsz;
-	return 0;
-}
-
 void
 trace_bufsz_args_apply(void)
 {
@@ -204,57 +151,6 @@ trace_bufsz_args_apply(void)
 		trace->buff_len = 1024 * 1024; /* 1MB */
 }
 
-int
-eal_trace_mode_args_save(const char *val)
-{
-	struct trace *trace = trace_obj_get();
-	size_t len = strlen(val);
-	unsigned long tmp;
-	char *pattern;
-
-	if (len == 0) {
-		trace_err("value is not provided with option");
-		return -EINVAL;
-	}
-
-	pattern = (char *)calloc(1, len + 2);
-	if (pattern == NULL) {
-		trace_err("fail to allocate memory");
-		return -ENOMEM;
-	}
-
-	sprintf(pattern, "%s*", val);
-
-	if (fnmatch(pattern, "overwrite", 0) == 0)
-		tmp = RTE_TRACE_MODE_OVERWRITE;
-	else if (fnmatch(pattern, "discard", 0) == 0)
-		tmp = RTE_TRACE_MODE_DISCARD;
-	else {
-		free(pattern);
-		return -EINVAL;
-	}
-
-	trace->mode = tmp;
-	free(pattern);
-	return 0;
-}
-
-int
-eal_trace_dir_args_save(char const *val)
-{
-	char *dir_path;
-	int rc;
-
-	if (asprintf(&dir_path, "%s/", val) == -1) {
-		trace_err("failed to copy directory: %s", strerror(errno));
-		return -ENOMEM;
-	}
-
-	rc = trace_dir_update(dir_path);
-	free(dir_path);
-	return rc;
-}
-
 int
 trace_epoch_time_save(void)
 {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 6894bbf9d5..79722577a5 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -16,6 +16,7 @@
 #include <rte_eal.h>
 #include <rte_os_shim.h>
 #include <rte_pci_dev_feature_defs.h>
+#include <rte_trace.h>
 #include <stdint.h>
 #include <stdbool.h>
 
@@ -57,6 +58,16 @@ struct hugepage_file_discipline {
 	bool unlink_existing;
 };
 
+/**
+ * A saved trace pattern string from --trace, staged during arg parsing.
+ * Lives in user_cfg->trace_patterns; applied during eal_trace_init().
+ */
+struct eal_trace_arg {
+	STAILQ_ENTRY(eal_trace_arg) next;
+	char *val;
+};
+STAILQ_HEAD(eal_trace_arg_list, eal_trace_arg);
+
 /**
  * A plugin path provided by the user via -d, staged during arg parsing.
  * Lives in user_cfg->plugin_list; consumed by eal_plugins_init().
@@ -85,6 +96,10 @@ TAILQ_HEAD(eal_devopt_list, device_option);
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
 	struct eal_plugin_path_list plugin_list; /**< user-provided plugin paths (-d) */
+	struct eal_trace_arg_list trace_patterns; /**< saved --trace patterns */
+	char *trace_dir;        /**< trace output directory (NULL = use default) */
+	uint64_t trace_bufsz;   /**< trace buffer size in bytes (0 = use default 1 MB) */
+	enum rte_trace_mode trace_mode; /**< trace mode (default RTE_TRACE_MODE_OVERWRITE) */
 	size_t memory;           /**< amount of asked memory */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index d5ad7a4720..d20381a48f 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -14,7 +14,7 @@ int eal_parse_log_options(void);
 int eal_parse_args(void);
 int eal_option_device_parse(void);
 int eal_apply_runtime_state(void);
-int eal_cleanup_config(const struct eal_user_cfg *user_cfg);
+int eal_cleanup_config(void);
 enum rte_proc_type_t eal_proc_type_detect(void);
 int eal_plugins_init(void);
 int eal_save_args(int argc, char **argv);
diff --git a/lib/eal/common/eal_trace.h b/lib/eal/common/eal_trace.h
index 55262677e0..c7ef7d12f7 100644
--- a/lib/eal/common/eal_trace.h
+++ b/lib/eal/common/eal_trace.h
@@ -42,11 +42,6 @@ struct thread_mem_meta {
 	enum trace_area_e area;
 };
 
-struct trace_arg {
-	STAILQ_ENTRY(trace_arg) next;
-	char *val;
-};
-
 struct trace {
 	char *dir;
 	int register_errno;
@@ -54,7 +49,6 @@ struct trace {
 	enum rte_trace_mode mode;
 	rte_uuid_t uuid;
 	uint32_t buff_len;
-	STAILQ_HEAD(, trace_arg) args;
 	uint32_t nb_trace_points;
 	uint32_t nb_trace_mem_list;
 	struct thread_mem_meta *lcore_meta;
@@ -107,10 +101,5 @@ void trace_mem_per_thread_free(void);
 /* EAL interface */
 int eal_trace_init(void);
 void eal_trace_fini(void);
-int eal_trace_args_save(const char *val);
-void eal_trace_args_free(void);
-int eal_trace_dir_args_save(const char *val);
-int eal_trace_mode_args_save(const char *val);
-int eal_trace_bufsz_args_save(const char *val);
 
 #endif /* __EAL_TRACE_H */
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 16748f965e..b1155dfc2c 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -762,7 +762,6 @@ rte_eal_cleanup(void)
 		return -1;
 	}
 
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
 	rte_service_finalize();
 	eal_bus_cleanup();
 	rte_mp_channel_cleanup();
@@ -771,7 +770,7 @@ rte_eal_cleanup(void)
 	eal_trace_fini();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
-	eal_cleanup_config(user_cfg);
+	eal_cleanup_config();
 	eal_lcore_var_cleanup();
 	return 0;
 }
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 8d67d6744f..4c716f2a09 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -974,7 +974,7 @@ rte_eal_cleanup(void)
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
 	rte_eal_malloc_heap_cleanup();
-	eal_cleanup_config(user_cfg);
+	eal_cleanup_config();
 	eal_lcore_var_cleanup();
 	rte_eal_log_cleanup();
 	return 0;
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 8de7d6d715..e0d7c4e612 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -136,14 +136,12 @@ RTE_EXPORT_SYMBOL(rte_eal_cleanup)
 int
 rte_eal_cleanup(void)
 {
-	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-
 	eal_intr_thread_cancel();
 	eal_mem_virt2iova_cleanup();
 	eal_bus_cleanup();
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
-	eal_cleanup_config(user_cfg);
+	eal_cleanup_config();
 	eal_lcore_var_cleanup();
 	return 0;
 }
-- 
2.51.0

