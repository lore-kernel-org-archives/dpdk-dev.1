Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D796606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cWbidn2J
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F77140E28;
	Thu, 26 Nov 2026 19:15:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 97D8340A75
 for <dev@dpdk.org>; Thu, 26 Nov 2026 19:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795716923; x=1827252923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FHiJgp0afjZXXIWyhDAkovpH6LCjNKDUtDmDncwHLgk=;
 b=cWbidn2JYk6zAisez2pSxPC/r93IehrwPYH3dwBVHV0qzKgEf3/9pKKy
 litMKEyOBZS8hO0CrZq3xCXkqw5f93JBS7dkgNb3QUSBQo1Ts9j25a2Pt
 NyrvJ8ZtuRrFsD+aNRFZ/3BTVY+DBbxFP3phRcCTRr/gCAXL/jXLxlfrO
 O9fSeN+Bk0CHZWlkgsXwL6ybWuWnPPN/R4tL3Kcc9IJtA9E6RJVLCHsiH
 jlYfV86h20hdRfHx/zD/FDb/ErOuHUUBZwefFISOmXIJzHywr2MtaX/6o
 qg6NYgzjkh5IMJF4pNhLG39/m/As1fR3vHYOm1rkuKjpWROE14cpJfdgV Q==;
X-CSE-ConnectionGUID: wQnLB8D5QPOYn/pnfoaiTw==
X-CSE-MsgGUID: eBOyRAooSmW2NriXIa8TGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4633622"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4633622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 10:15:22 -0800
X-CSE-ConnectionGUID: ncI4xrFRR7GxFmrMZpmZwQ==
X-CSE-MsgGUID: B0qRoFq9Q2Kr7uReojTWlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; d="scan'208";a="12733122"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 26 Nov 2026 10:15:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 28/39] eal: simplify internal driver path iteration APIs
Date: Thu, 26 Nov 2026 18:14:01 +0000
Message-ID: <20261126181414.124094-29-bruce.richardson@intel.com>
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
 app/test/process.c                  |  4 +-
 lib/eal/common/eal_common_options.c | 60 ++++++++---------------------
 lib/eal/include/rte_eal.h           | 35 ++++++-----------
 3 files changed, 31 insertions(+), 68 deletions(-)

diff --git a/app/test/process.c b/app/test/process.c
index 92c8af702b..599d6ee780 100644
--- a/app/test/process.c
+++ b/app/test/process.c
@@ -63,7 +63,7 @@ add_parameter_driver_path(char **argv, int max_capacity)
 	const char *driver_path;
 	int count = 0;
 
-	RTE_EAL_DRIVER_PATH_FOREACH(driver_path, true) {
+	RTE_EAL_DRIVER_PATH_FOREACH(driver_path) {
 		if (asprintf(&argv[count], PREFIX_DRIVER_PATH"%s", driver_path) < 0)
 			break;
 
@@ -95,7 +95,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
 		return -1;
 	else if (pid == 0) {
 		allow_num = rte_devargs_type_count(RTE_DEVTYPE_ALLOWED);
-		driver_path_num = rte_eal_driver_path_count(true);
+		driver_path_num = rte_eal_driver_path_count();
 		argv_num = numargs + allow_num + driver_path_num + 1;
 		argv_cpy = calloc(argv_num, sizeof(char *));
 		if (!argv_cpy)
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 1d24f52e5c..5014eb6209 100644
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
2.55.0

