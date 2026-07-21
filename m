Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC56C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:49:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E463440E78;
	Tue, 21 Jul 2026 11:46:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A5E1840DDD
 for <dev@dpdk.org>; Tue, 21 Jul 2026 11:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784627192; x=1816163192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i/+4gmmw9TeziSPo+O/WgPrZ/Jl0yzz2wcN7GPv2O0U=;
 b=HNAA58NGrpWZ8LGU6NmZtBAbBAlUXQjF51ecLd/IvlEbG6WfEAF2pMKo
 07g/VXI3t9FWgpHzYfp45TNUKn6MDDwSL5GndB7apCpxNLv/bKAG51b2n
 fIb88NEtx3pmOm9CmBAeQ99rJh9H7lvPfE+HQjhvd8emA1pJpCjQ58oc/
 +XQMPep02Vj6l6iNdu+4XLxivTc7wG8qgiBxTI4J22CVuc2L7NRljVFbk
 VsskqonT78Go9gVPDFopm9dUS337VC3jb1JEyfMCUhE1S7/KovhQaL2bw
 a35ersvPVqcaWzZcvjmdY9DoxGSYXsJOrQkSWY+v8W0MRA9+2TZuXR0jj g==;
X-CSE-ConnectionGUID: WpahAWm3RZWphEaQFEI6Dw==
X-CSE-MsgGUID: 25w6yF4gTyO7/ObjXp6e5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95872500"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="95872500"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 02:46:30 -0700
X-CSE-ConnectionGUID: AqrsLrneSTSyDEcCPK07XQ==
X-CSE-MsgGUID: T3YjuRE9Q/iwa5RVECcNaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="295922415"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 21 Jul 2026 02:46:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 28/39] eal: simplify internal driver path iteration APIs
Date: Tue, 21 Jul 2026 10:45:36 +0100
Message-ID: <20260721094555.2188496-29-bruce.richardson@intel.com>
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

The APIs for counting and iterating the driver paths originally iterated
the mixed list of both user-provided paths and loaded .so paths.
However, in practice only the user-provided paths were ever queried.

Since supporting both types of iteration is duplicating the work in code
(because we now have two different lists of different types to iterate)
just drop the unused iteration support and update the API to only
iterate the user-provided list. This simplifies the API (dropping a
parameter), the implementation (removing iteration of the runtime_cfg
list), and has no ABI impacts since the APIs are explicitly marked as
internal. The iteration macro is updated to match the APIs too.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/process.h                  |  4 +-
 lib/eal/common/eal_common_options.c | 60 ++++++++---------------------
 lib/eal/include/rte_eal.h           | 35 ++++++-----------
 3 files changed, 31 insertions(+), 68 deletions(-)

diff --git a/app/test/process.h b/app/test/process.h
index 3ee899dbc8..c34c81d443 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -62,7 +62,7 @@ add_parameter_driver_path(char **argv, int max_capacity)
 	const char *driver_path;
 	int count = 0;
 
-	RTE_EAL_DRIVER_PATH_FOREACH(driver_path, true) {
+	RTE_EAL_DRIVER_PATH_FOREACH(driver_path) {
 		if (asprintf(&argv[count], PREFIX_DRIVER_PATH"%s", driver_path) < 0)
 			break;
 
@@ -100,7 +100,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 		return -1;
 	else if (pid == 0) {
 		allow_num = rte_devargs_type_count(RTE_DEVTYPE_ALLOWED);
-		driver_path_num = rte_eal_driver_path_count(true);
+		driver_path_num = rte_eal_driver_path_count();
 		argv_num = numargs + allow_num + driver_path_num + 1;
 		argv_cpy = calloc(argv_num, sizeof(char *));
 		if (!argv_cpy)
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 435a8ae9d6..06c919eeca 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -797,62 +797,36 @@ eal_plugins_init(void)
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_driver_path_next)
 const char *
-rte_eal_driver_path_next(const char *start, bool cmdline_only)
+rte_eal_driver_path_next(const char *start)
 {
-	if (cmdline_only) {
-		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-		struct eal_plugin_path *p;
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_plugin_path *p;
 
-		if (start == NULL) {
-			p = TAILQ_FIRST(&user_cfg->plugin_list);
-		} else {
-			TAILQ_FOREACH(p, &user_cfg->plugin_list, next) {
-				if (start == p->name) {
-					p = TAILQ_NEXT(p, next);
-					break;
-				}
-			}
-			if (p == NULL)
-				return NULL;
-		}
-		return p ? p->name : NULL;
+	if (start == NULL) {
+		p = TAILQ_FIRST(&user_cfg->plugin_list);
 	} else {
-		const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-		struct shared_driver *solib;
-
-		if (start == NULL) {
-			solib = TAILQ_FIRST(&runtime_state->loaded_plugins);
-		} else {
-			TAILQ_FOREACH(solib, &runtime_state->loaded_plugins, next) {
-				if (start == solib->name) {
-					solib = TAILQ_NEXT(solib, next);
-					break;
-				}
+		TAILQ_FOREACH(p, &user_cfg->plugin_list, next) {
+			if (start == p->name) {
+				p = TAILQ_NEXT(p, next);
+				break;
 			}
-			if (solib == NULL)
-				return NULL;
 		}
-		return solib ? solib->name : NULL;
+		if (p == NULL)
+			return NULL;
 	}
+	return p ? p->name : NULL;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_eal_driver_path_count)
 unsigned int
-rte_eal_driver_path_count(bool cmdline_only)
+rte_eal_driver_path_count(void)
 {
+	const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
+	struct eal_plugin_path *p;
 	unsigned int count = 0;
 
-	if (cmdline_only) {
-		const struct eal_user_cfg *user_cfg = eal_get_user_configuration();
-		struct eal_plugin_path *p;
-		TAILQ_FOREACH(p, &user_cfg->plugin_list, next)
-			count++;
-	} else {
-		const struct eal_runtime_state *runtime_state = eal_get_runtime_state();
-		struct shared_driver *solib;
-		TAILQ_FOREACH(solib, &runtime_state->loaded_plugins, next)
-			count++;
-	}
+	TAILQ_FOREACH(p, &user_cfg->plugin_list, next)
+		count++;
 
 	return count;
 }
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 7241f3be5d..6711ee4440 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -493,57 +493,46 @@ rte_eal_get_runtime_dir(void);
 
 /**
  * @internal
- * Iterate to the next driver path.
+ * Iterate to the next user-provided driver path.
  *
- * This function iterates through the list of dynamically loaded drivers,
- * or driver paths that were specified via -d or --driver-path command-line
- * options during EAL initialization.
+ * This function iterates through the driver paths that were specified
+ * via -d or --driver-path command-line options during EAL initialization.
  *
  * @param start
  *   Starting iteration point. The iteration will start at the first driver path if NULL.
- * @param cmdline_only
- *   If true, only iterate paths from command line (-d flags).
- *   If false, iterate all paths including those expanded from directories.
  *
  * @return
  *   Next driver path string, NULL if there is none.
  */
 __rte_internal
 const char *
-rte_eal_driver_path_next(const char *start, bool cmdline_only);
+rte_eal_driver_path_next(const char *start);
 
 /**
  * @internal
- * Iterate over all driver paths.
+ * Iterate over all user-provided driver paths.
  *
  * This macro provides a convenient way to iterate through all driver paths
- * that were loaded via -d flags during EAL initialization.
+ * that were specified via -d flags during EAL initialization.
  *
  * @param path
  *   Iterator variable of type const char *
- * @param cmdline_only
- *   If true, only iterate paths from command line (-d flags).
- *   If false, iterate all paths including those expanded from directories.
  */
-#define RTE_EAL_DRIVER_PATH_FOREACH(path, cmdline_only) \
-	for (path = rte_eal_driver_path_next(NULL, cmdline_only); \
+#define RTE_EAL_DRIVER_PATH_FOREACH(path) \
+	for (path = rte_eal_driver_path_next(NULL); \
 	     path != NULL; \
-	     path = rte_eal_driver_path_next(path, cmdline_only))
+	     path = rte_eal_driver_path_next(path))
 
 /**
  * @internal
- * Get count of driver paths.
- *
- * @param cmdline_only
- *   If true, only count paths from command line (-d flags).
- *   If false, count all paths including those expanded from directories.
+ * Get count of user-provided driver paths.
  *
  * @return
- *   Number of driver paths.
+ *   Number of driver paths specified via -d flags during EAL initialization.
  */
 __rte_internal
 unsigned int
-rte_eal_driver_path_count(bool cmdline_only);
+rte_eal_driver_path_count(void);
 
 #ifdef __cplusplus
 }
-- 
2.53.0

