Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C2606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X8/37fot
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0BC40E18;
	Thu, 26 Nov 2026 19:15:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id AFD0240B9D
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716922; x=1827252922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DowV62peFULxxsELM6+0OJA5O45IioySq+s4t/nk8nw=;
 b=X8/37fota+T/6QaO4KoDVv0KlZzzWZRPt5YYjo03U07jApLTK/WvRs60
 jlHfUdQ5ck2FUanlR1E+4nO8biYKqbExq8ols+9bBN+HD3fGWhEAvAwDm
 cw3c6VBTWfmEi5G/vnFHrC7Pbe+T9uVb6+f23OUWwak7CPpsUgmEtWyRQ
 BLybyP5kJ+sApuVxKkgLpISpC4B127KFKC6j/TrwBmiNRlMfamMWZEosV
 lytvNVUssZb8r/iUBUq0f1lWuDtHg0HyHL9a3SB2/5WyLFPqSZO3qflVF
 8RT0Yg/rtDODXUgsGVBK0QbVK+fLu6G72dK7SgoYdW5kEv8MI5fuMhAw5 A==;
X-CSE-ConnectionGUID: SGgL2eG2SmSruwfYcnfB1w==
X-CSE-MsgGUID: tshuw1M/T3O/gceoEeIUVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633620"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:22 -0800
X-CSE-ConnectionGUID: W3FBkdVWSWq6BgiuTA3NEg==
X-CSE-MsgGUID: uWq8AquyQfyitMIKUvjgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733116"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 27/39] eal: separate plugin paths from loaded plugin objects
Date: Thu, 26 Nov 2026 18:14:00 +0000
Message-ID: <20261126181414.124094-28-bruce.richardson@intel.com>
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
index 1369f75be7..1d24f52e5c 100644
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
 
@@ -2105,7 +2129,7 @@ eal_parse_args(void)
 			return -1;
 	/* driver loading options */
 	TAILQ_FOREACH(arg, &args.driver_path, next)
-		if (eal_plugin_add(arg->arg, true) < 0)
+		if (eal_plugin_path_add(arg->arg) < 0)
 			return -1;
 
 	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 578de5184f..55900f87bf 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -64,6 +64,16 @@ struct hugepage_file_discipline {
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
@@ -81,6 +91,7 @@ TAILQ_HEAD(eal_devopt_list, device_option);
  */
 struct eal_user_cfg {
 	struct eal_devopt_list devopt_list; /**< staged device options (-a/-b/--vdev) */
+	struct eal_plugin_path_list plugin_list; /**< user-provided plugin paths (-d) */
 	size_t memory;           /**< amount of asked memory */
 	size_t huge_worker_stack_size; /**< worker thread stack size */
 	enum rte_proc_type_t process_type; /**< requested process type */
@@ -161,6 +172,16 @@ struct lcore_cfg {
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
@@ -179,6 +200,7 @@ struct eal_runtime_state {
 	struct lcore_cfg lcore_cfg[RTE_MAX_LCORE];
 	RTE_BITSET_DECLARE(core_indices, RTE_MAX_LCORE); /**< currently allocated core_indices */
 	struct rte_mem_config *mem_config; /**< pointer to memory config (in shared memory) */
+	struct eal_solib_list loaded_plugins; /**< all plugins loaded by eal_plugins_init() */
 };
 
 struct eal_user_cfg *eal_get_user_configuration(void);
-- 
2.55.0

