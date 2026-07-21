Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDDBC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:49:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00FC840E64;
	Tue, 21 Jul 2026 11:46:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 53BA640B90
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627191; x=1816163191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38Bgp4zGHR3Xw5DmyoOsU8OilKUaLV4lVuRyMnIBthA=;
 b=LnSf3InJrqxnT7M0VR1XvvEdiPFdhEfmo8S0oqxfgxAgQ9YakPGQtuCk
 VeOcBX+/0kUv9d6Pb3zcYqkybqGjm9dPwpI7ad07KIe6wRMF5Wz768ri2
 GOIIhY5/80W6pAQRv7mg8VmuMY6xRbzl3fO4RyX54NAlJJWTwycg2Csnb
 9QJFeaeptvI8vKYK6ZwEolOLTm9qtU3zPBbjI1W8YMs3MRhtiIcl3U+lI
 IjiXK6C4gR6MFOrz4ilzmGdaLIiNzelmTPCpYMEkGlk0z7d1S1reEEzWa
 hh8vg9MEHxoBloDgxSZzkfFuWJVtQGkgj/BDrSUsiU90BIcMKqdDLLC/N Q==;
X-CSE-ConnectionGUID: BNYHoJeBSSuTViiynQh6lA==
X-CSE-MsgGUID: nXL2TeB7RBWLvD/Io9Fzqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872495"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872495"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:29 -0700
X-CSE-ConnectionGUID: HzzmNDS2T0u0rkHN5GpkIA==
X-CSE-MsgGUID: LzwasvTTSpmgyxSrUEbvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922408"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27/39] eal: separate plugin paths from loaded plugin objects
Date: Tue, 21 Jul 2026 10:45:35 +0100
Message-ID: <20260721094555.2188496-28-bruce.richardson@intel.com>
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

The one data structure in eal managed both the loaded plugins and the
list of plugin paths provided by the user, separating the two rather
awkwardly by using a flag value. Since we have separate user_cfg and
runtime_state structures, separate the plugin info between the two
structs - user provided directory and file paths in one, and actual
loaded .so paths and pointers in the other.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 248 +++++++++++++++-------------
 lib/eal/common/eal_internal_cfg.h   |  22 +++
 2 files changed, 158 insertions(+), 112 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 1bc6731fba..435a8ae9d6 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -277,21 +277,6 @@ eal_collate_args(int argc, char **argv)
 	return retval - 1;
 }
 
-TAILQ_HEAD(shared_driver_list, shared_driver);
-
-/* Definition for shared object drivers. */
-struct shared_driver {
-	TAILQ_ENTRY(shared_driver) next;
-
-	char    name[PATH_MAX];
-	void*   lib_handle;
-	bool    from_cmdline; /**< true if from -d flag, false if driver found in a directory */
-};
-
-/* List of external loadable drivers */
-static struct shared_driver_list solib_list =
-TAILQ_HEAD_INITIALIZER(solib_list);
-
 #ifndef RTE_EXEC_ENV_WINDOWS
 /* Default path of external loadable drivers */
 static const char *default_solib_dir = RTE_EAL_PMD_PATH;
@@ -505,6 +490,8 @@ eal_reset_internal_config(void)
 	int i;
 
 	TAILQ_INIT(&user_cfg->devopt_list);
+	TAILQ_INIT(&user_cfg->plugin_list);
+	TAILQ_INIT(&runtime_state->loaded_plugins);
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
 	user_cfg->force_nchannel = 0;
@@ -561,19 +548,18 @@ eal_reset_internal_config(void)
 }
 
 static int
-eal_plugin_add(const char *path, bool from_cmdline)
+eal_plugin_path_add(const char *path)
 {
-	struct shared_driver *solib;
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_plugin_path *p;
 
-	solib = malloc(sizeof(*solib));
-	if (solib == NULL) {
-		EAL_LOG(ERR, "malloc(solib) failed");
+	p = malloc(sizeof(*p));
+	if (p == NULL) {
+		EAL_LOG(ERR, "malloc(plugin_path) failed");
 		return -1;
 	}
-	memset(solib, 0, sizeof(*solib));
-	strlcpy(solib->name, path, PATH_MAX);
-	solib->from_cmdline = from_cmdline;
-	TAILQ_INSERT_TAIL(&solib_list, solib, next);
+	strlcpy(p->name, path, PATH_MAX);
+	TAILQ_INSERT_TAIL(&user_cfg->plugin_list, p, next);
 
 	return 0;
 }
@@ -595,53 +581,6 @@ ends_with(const char *str, const char *tail)
 	return str_len >= tail_len && strcmp(&str[str_len - tail_len], tail) == 0;
 }
 
-static int
-eal_plugindir_init(const char *path)
-{
-	struct dirent *dent = NULL;
-	DIR *d = NULL;
-
-	if (path == NULL || *path == '\0')
-		return 0;
-
-	d = opendir(path);
-	if (d == NULL) {
-		EAL_LOG(ERR, "failed to open directory %s: %s",
-			path, strerror(errno));
-		return -1;
-	}
-
-	while ((dent = readdir(d)) != NULL) {
-		char *sopath = NULL;
-		struct stat sb;
-
-		if (!ends_with(dent->d_name, ".so") && !ends_with(dent->d_name, ".so."ABI_VERSION))
-			continue;
-
-		if (asprintf(&sopath, "%s/%s", path, dent->d_name) < 0) {
-			EAL_LOG(ERR, "failed to create full path %s/%s",
-				path, dent->d_name);
-			continue;
-		}
-
-		/* if a regular file, add to list to load */
-		if (!(stat(sopath, &sb) == 0 && S_ISREG(sb.st_mode))) {
-			free(sopath);
-			continue;
-		}
-
-		if (eal_plugin_add(sopath, false) == -1) {
-			free(sopath);
-			break;
-		}
-		free(sopath);
-	}
-
-	closedir(d);
-	/* XXX this ignores failures from readdir() itself */
-	return (dent == NULL) ? 0 : -1;
-}
-
 static int
 verify_perms(const char *dirpath)
 {
@@ -713,6 +652,65 @@ eal_dlopen(const char *pathname)
 	return retval;
 }
 
+static int
+eal_plugindir_init(const char *path)
+{
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct dirent *dent = NULL;
+	DIR *d = NULL;
+
+	if (path == NULL || *path == '\0')
+		return 0;
+
+	d = opendir(path);
+	if (d == NULL) {
+		EAL_LOG(ERR, "failed to open directory %s: %s",
+			path, strerror(errno));
+		return -1;
+	}
+
+	while ((dent = readdir(d)) != NULL) {
+		char *sopath = NULL;
+		struct shared_driver *solib;
+		struct stat sb;
+
+		if (!ends_with(dent->d_name, ".so") && !ends_with(dent->d_name, ".so."ABI_VERSION))
+			continue;
+
+		if (asprintf(&sopath, "%s/%s", path, dent->d_name) < 0) {
+			EAL_LOG(ERR, "failed to create full path %s/%s",
+				path, dent->d_name);
+			continue;
+		}
+
+		/* if not a regular file, skip */
+		if (!(stat(sopath, &sb) == 0 && S_ISREG(sb.st_mode))) {
+			free(sopath);
+			continue;
+		}
+
+		solib = calloc(1, sizeof(*solib));
+		if (solib == NULL) {
+			free(sopath);
+			break;
+		}
+		strlcpy(solib->name, sopath, PATH_MAX);
+		free(sopath);
+
+		EAL_LOG(DEBUG, "open shared lib %s", solib->name);
+		solib->lib_handle = eal_dlopen(solib->name);
+		if (solib->lib_handle == NULL) {
+			free(solib);
+			break;
+		}
+		TAILQ_INSERT_TAIL(&runtime_state->loaded_plugins, solib, next);
+	}
+
+	closedir(d);
+	/* XXX this ignores failures from readdir() itself */
+	return (dent == NULL) ? 0 : -1;
+}
+
 static int
 is_shared_build(void)
 {
@@ -753,37 +751,45 @@ is_shared_build(void)
 int
 eal_plugins_init(void)
 {
-	struct shared_driver *solib = NULL;
+	struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+	struct eal_plugin_path *p;
 	struct stat sb;
 
-	/* If we are not statically linked, add default driver loading
-	 * path if it exists as a directory.
-	 * (Using dlopen with NOLOAD flag on EAL, will return NULL if the EAL
-	 * shared library is not already loaded i.e. it's statically linked.)
-	 */
+	TAILQ_INIT(&runtime_state->loaded_plugins);
+
+	/* If we are not statically linked, scan the default driver directory. */
 	if (is_shared_build() &&
 			*default_solib_dir != '\0' &&
 			stat(default_solib_dir, &sb) == 0 &&
-			S_ISDIR(sb.st_mode))
-		eal_plugin_add(default_solib_dir, false);
-
-	TAILQ_FOREACH(solib, &solib_list, next) {
+			S_ISDIR(sb.st_mode)) {
+		if (eal_plugindir_init(default_solib_dir) == -1) {
+			EAL_LOG(ERR, "Cannot init plugin directory %s",
+				default_solib_dir);
+			return -1;
+		}
+	}
 
-		if (stat(solib->name, &sb) == 0 && S_ISDIR(sb.st_mode)) {
-			if (eal_plugindir_init(solib->name) == -1) {
-				EAL_LOG(ERR,
-					"Cannot init plugin directory %s",
-					solib->name);
+	TAILQ_FOREACH(p, &user_cfg->plugin_list, next) {
+		if (stat(p->name, &sb) == 0 && S_ISDIR(sb.st_mode)) {
+			if (eal_plugindir_init(p->name) == -1) {
+				EAL_LOG(ERR, "Cannot init plugin directory %s",
+					p->name);
 				return -1;
 			}
 		} else {
-			EAL_LOG(DEBUG, "open shared lib %s",
-				solib->name);
+			struct shared_driver *solib = calloc(1, sizeof(*solib));
+			if (solib == NULL)
+				return -1;
+			strlcpy(solib->name, p->name, PATH_MAX);
+			EAL_LOG(DEBUG, "open shared lib %s", solib->name);
 			solib->lib_handle = eal_dlopen(solib->name);
-			if (solib->lib_handle == NULL)
+			if (solib->lib_handle == NULL) {
+				free(solib);
 				return -1;
+			}
+			TAILQ_INSERT_TAIL(&runtime_state->loaded_plugins, solib, next);
 		}
-
 	}
 	return 0;
 }
@@ -793,40 +799,58 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_driver_path_next)
 const char *
 rte_eal_driver_path_next(const char *start, bool cmdline_only)
 {
-	struct shared_driver *solib;
+	if (cmdline_only) {
+		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+		struct eal_plugin_path *p;
 
-	if (start == NULL) {
-		solib = TAILQ_FIRST(&solib_list);
-	} else {
-		/* Find the current entry based on the name string */
-		TAILQ_FOREACH(solib, &solib_list, next) {
-			if (start == solib->name) {
-				solib = TAILQ_NEXT(solib, next);
-				break;
+		if (start == NULL) {
+			p = TAILQ_FIRST(&user_cfg->plugin_list);
+		} else {
+			TAILQ_FOREACH(p, &user_cfg->plugin_list, next) {
+				if (start == p->name) {
+					p = TAILQ_NEXT(p, next);
+					break;
+				}
 			}
+			if (p == NULL)
+				return NULL;
 		}
-		if (solib == NULL)
-			return NULL;
-	}
+		return p ? p->name : NULL;
+	} else {
+		const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+		struct shared_driver *solib;
 
-	/* Skip entries that were expanded from directories if cmdline_only is true */
-	if (cmdline_only) {
-		while (solib != NULL && !solib->from_cmdline)
-			solib = TAILQ_NEXT(solib, next);
+		if (start == NULL) {
+			solib = TAILQ_FIRST(&runtime_state->loaded_plugins);
+		} else {
+			TAILQ_FOREACH(solib, &runtime_state->loaded_plugins, next) {
+				if (start == solib->name) {
+					solib = TAILQ_NEXT(solib, next);
+					break;
+				}
+			}
+			if (solib == NULL)
+				return NULL;
+		}
+		return solib ? solib->name : NULL;
 	}
-
-	return solib ? solib->name : NULL;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_driver_path_count)
 unsigned int
 rte_eal_driver_path_count(bool cmdline_only)
 {
-	struct shared_driver *solib;
 	unsigned int count = 0;
 
-	TAILQ_FOREACH(solib, &solib_list, next) {
-		if (!cmdline_only || solib->from_cmdline)
+	if (cmdline_only) {
+		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+		struct eal_plugin_path *p;
+		TAILQ_FOREACH(p, &user_cfg->plugin_list, next)
+			count++;
+	} else {
+		const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
+		struct shared_driver *solib;
+		TAILQ_FOREACH(solib, &runtime_state->loaded_plugins, next)
 			count++;
 	}
 
@@ -2106,7 +2130,7 @@ eal_parse_args(void)
 			return -1;
 	/* driver loading options */
 	TAILQ_FOREACH(arg, &args.driver_path, next)
-		if (eal_plugin_add(arg->arg, true) < 0)
+		if (eal_plugin_path_add(arg->arg) < 0)
 			return -1;
 
 	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 478c16aeae..c683fceb3b 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -58,6 +58,16 @@ struct hugepage_file_discipline {
 	bool unlink_existing;
 };
 
+/**
+ * A plugin path provided by the user via -d, staged during arg parsing.
+ * Lives in user_cfg->plugin_list; consumed by eal_plugins_init().
+ */
+struct eal_plugin_path {
+	TAILQ_ENTRY(eal_plugin_path) next;
+	char name[PATH_MAX];
+};
+TAILQ_HEAD(eal_plugin_path_list, eal_plugin_path);
+
 /**
  * A single device option (-a/-b/--vdev) staged during arg parsing.
  * Lives in user_cfg->devopt_list; drained by eal_option_device_parse().
@@ -75,6 +85,7 @@ TAILQ_HEAD(eal_devopt_list, device_option);
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
+	struct eal_plugin_path_list plugin_list; /**< user-provided plugin paths (-d) */
 	size_t memory;           /**< amount of asked memory */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
@@ -155,6 +166,16 @@ struct lcore_cfg {
 	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
 };
 
+/**
+ * A plugin loaded by EAL, including directory-expanded entries.
+ */
+struct shared_driver {
+	TAILQ_ENTRY(shared_driver) next;
+	char name[PATH_MAX];
+	void *lib_handle;
+};
+TAILQ_HEAD(eal_solib_list, shared_driver);
+
 /**
  * Internal EAL runtime state
  * May be modified at runtime, so access must be protected by locks or atomic types
@@ -174,6 +195,7 @@ struct eal_runtime_state {
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
+	struct eal_solib_list loaded_plugins; /**< all plugins loaded by eal_plugins_init() */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
-- 
2.53.0

