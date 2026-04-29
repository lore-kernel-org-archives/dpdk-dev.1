Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6430CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 17:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F93040EE4;
	Wed, 29 Apr 2026 18:59:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0E12140E50;
 Wed, 29 Apr 2026 18:59:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777481967; x=1809017967;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J4JMlDS+xIQaUOOs4Ubl+yNMeJDg8cI+5djgpe39PfE=;
 b=XBq2HoqNoQX5sw8wfN55hDEZ7ueAhjg2bw6N2eNiRLEqVRrPy2oi476T
 FABaT/PlAuJUC7AOxGdm+5Q8sw99VMiR0fnUt4XvR22n6HdrohsA4sEDl
 QSZ/4AuesywT3EL/izDxhuhZKePSubZvpeCRDodpqCDNnWw9uOCDMoYSL
 iYZALQvc4hwHumu5StP1YQQXQe2h3hlXsIZw2PAv08M570+JFMjkiOAXf
 KbddxKKj+3Ch33srJqasbVPQAqifcWKj/V1mJBdSmxnDaTYDIJQBXfCL9
 xF33fSLnGAuPkQheLthu1dNfkk2VuVFMXbMdWXoiOekKay9i8/pjHfDPt w==;
X-CSE-ConnectionGUID: hZowvewcRH+OvlUmDa57Hw==
X-CSE-MsgGUID: mgUMDmUlR02tAjwHUHgf2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88725339"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="88725339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 09:59:26 -0700
X-CSE-ConnectionGUID: Z++XbLIQQ86+RrcRcDfVpA==
X-CSE-MsgGUID: Dlu8Lgp8RQKC1JPtKsn80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="264697015"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.128])
 by orviesa002.jf.intel.com with ESMTP; 29 Apr 2026 09:59:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 24/44] eal: separate plugin paths from loaded plugin
 objects
Date: Wed, 29 Apr 2026 17:58:16 +0100
Message-ID: <20260429165845.2136843-25-bruce.richardson@intel.com>
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
index 71fc69e80d..63ab7980c1 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -261,21 +261,6 @@ eal_collate_args(int argc, char **argv)
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
@@ -489,6 +474,8 @@ eal_reset_internal_config(void)
 	int i;
 
 	TAILQ_INIT(&user_cfg->devopt_list);
+	TAILQ_INIT(&user_cfg->plugin_list);
+	TAILQ_INIT(&runtime_state->loaded_plugins);
 	user_cfg->memory = 0;
 	user_cfg->force_nrank = 0;
 	user_cfg->force_nchannel = 0;
@@ -539,19 +526,18 @@ eal_reset_internal_config(void)
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
@@ -573,53 +559,6 @@ ends_with(const char *str, const char *tail)
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
@@ -691,6 +630,65 @@ eal_dlopen(const char *pathname)
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
@@ -731,37 +729,45 @@ is_shared_build(void)
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
@@ -771,40 +777,58 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_driver_path_next)
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
 
@@ -1987,7 +2011,7 @@ eal_parse_args(void)
 			return -1;
 	/* driver loading options */
 	TAILQ_FOREACH(arg, &args.driver_path, next)
-		if (eal_plugin_add(arg->arg, true) < 0)
+		if (eal_plugin_path_add(arg->arg) < 0)
 			return -1;
 
 	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 4decc26d2c..6894bbf9d5 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -57,6 +57,16 @@ struct hugepage_file_discipline {
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
@@ -74,6 +84,7 @@ TAILQ_HEAD(eal_devopt_list, device_option);
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
+	struct eal_plugin_path_list plugin_list; /**< user-provided plugin paths (-d) */
 	size_t memory;           /**< amount of asked memory */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
@@ -148,6 +159,16 @@ struct lcore_cfg {
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
@@ -163,6 +184,7 @@ struct eal_runtime_state {
 	uint32_t lcore_count;         /**< Number of active lcore IDs (role != ROLE_OFF). */
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
+	struct eal_solib_list loaded_plugins; /**< all plugins loaded by eal_plugins_init() */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
-- 
2.51.0

