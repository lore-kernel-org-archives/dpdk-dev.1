Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D30D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 11:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79F9C40684;
	Mon,  8 Dec 2025 12:52:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B5FC840280
 for <dev@dpdk.org>; Mon,  8 Dec 2025 12:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765194775; x=1796730775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fv5JUcFXYGXmjlEqrQlHJ0u6dE2SA/B2NOVmRCfTWTs=;
 b=Q3HWJvu+iJK3sSVCS2lDRtPm6p1M5bPZopniyykclz14EFm+WDkI6TRS
 RMAoKDHeeqkWhJLyYwG5W0z1yBWCj6078uLkAJCQaDZ/Jw8yrZmCuPWSk
 nfNHlFqGDdDmTFkl43tJweTsWVSQd3/1kY2uY1iQmsYi/Az2vRaVYHvGc
 ot1lNz5vDwnC4F+MPg4SMW2V0GeOgza8ujKOoNT5W/uFDGSvWQZCLVAr9
 jw4asnXaNE5SlsWtx12++9TiJAvr9gUHapg94TeqcjRo4pqXzXXcOyJwj
 FOmTAHyvuiFisutUCFH+lmpBxZcPeF2nb8B+1qjOQidR9dMr1SOfCvdwS Q==;
X-CSE-ConnectionGUID: YzCORZM3Tu6ysQhNsgXCeQ==
X-CSE-MsgGUID: 1Z74y3YIRSOUdHagfpxOrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67096055"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67096055"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 03:52:54 -0800
X-CSE-ConnectionGUID: yZYToHwNTOKMyTBs4njHug==
X-CSE-MsgGUID: khOLM40TTMKiFbaHJkh/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="195970660"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 08 Dec 2025 03:52:54 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 05/11] eal: add internal APIs to query loaded driver paths
Date: Mon,  8 Dec 2025 11:52:39 +0000
Message-ID: <20251208115245.3809624-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208115245.3809624-1-bruce.richardson@intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251208115245.3809624-1-bruce.richardson@intel.com>
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

Add APIs for internal DPDK use to allow querying the paths of drivers
loaded into the running instance.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 54 ++++++++++++++++++++++++++---
 lib/eal/include/rte_eal.h           | 52 +++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b1fb670ea0..a4afbb80a2 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -263,6 +263,7 @@ struct shared_driver {
 
 	char    name[PATH_MAX];
 	void*   lib_handle;
+	bool    from_cmdline; /**< true if from -d flag, false if driver found in a directory */
 };
 
 /* List of external loadable drivers */
@@ -533,7 +534,7 @@ eal_reset_internal_config(struct internal_config *internal_cfg)
 }
 
 static int
-eal_plugin_add(const char *path)
+eal_plugin_add(const char *path, bool from_cmdline)
 {
 	struct shared_driver *solib;
 
@@ -544,6 +545,7 @@ eal_plugin_add(const char *path)
 	}
 	memset(solib, 0, sizeof(*solib));
 	strlcpy(solib->name, path, PATH_MAX);
+	solib->from_cmdline = from_cmdline;
 	TAILQ_INSERT_TAIL(&solib_list, solib, next);
 
 	return 0;
@@ -595,7 +597,7 @@ eal_plugindir_init(const char *path)
 		if (!(stat(sopath, &sb) == 0 && S_ISREG(sb.st_mode)))
 			continue;
 
-		if (eal_plugin_add(sopath) == -1)
+		if (eal_plugin_add(sopath, false) == -1)
 			break;
 	}
 
@@ -727,7 +729,7 @@ eal_plugins_init(void)
 			*default_solib_dir != '\0' &&
 			stat(default_solib_dir, &sb) == 0 &&
 			S_ISDIR(sb.st_mode))
-		eal_plugin_add(default_solib_dir);
+		eal_plugin_add(default_solib_dir, false);
 
 	TAILQ_FOREACH(solib, &solib_list, next) {
 
@@ -751,6 +753,50 @@ eal_plugins_init(void)
 }
 #endif
 
+RTE_EXPORT_SYMBOL(rte_eal_driver_path_next)
+const char *
+rte_eal_driver_path_next(const char *start, bool cmdline_only)
+{
+	struct shared_driver *solib;
+
+	if (start == NULL) {
+		solib = TAILQ_FIRST(&solib_list);
+	} else {
+		/* Find the current entry based on the name string */
+		TAILQ_FOREACH(solib, &solib_list, next) {
+			if (start == solib->name) {
+				solib = TAILQ_NEXT(solib, next);
+				break;
+			}
+		}
+		if (solib == NULL)
+			return NULL;
+	}
+
+	/* Skip entries that were expanded from directories if cmdline_only is true */
+	if (cmdline_only) {
+		while (solib != NULL && !solib->from_cmdline)
+			solib = TAILQ_NEXT(solib, next);
+	}
+
+	return solib ? solib->name : NULL;
+}
+
+RTE_EXPORT_SYMBOL(rte_eal_driver_path_count)
+unsigned int
+rte_eal_driver_path_count(bool cmdline_only)
+{
+	struct shared_driver *solib;
+	unsigned int count = 0;
+
+	TAILQ_FOREACH(solib, &solib_list, next) {
+		if (!cmdline_only || solib->from_cmdline)
+			count++;
+	}
+
+	return count;
+}
+
 /*
  * Parse the coremask given as argument (hexadecimal string) and fill
  * the global configuration (core role and core count) with the parsed
@@ -1929,7 +1975,7 @@ eal_parse_args(void)
 			return -1;
 	/* driver loading options */
 	TAILQ_FOREACH(arg, &args.driver_path, next)
-		if (eal_plugin_add(arg->arg) < 0)
+		if (eal_plugin_add(arg->arg, true) < 0)
 			return -1;
 
 	if (remap_lcores && args.remap_lcore_ids != (void *)1) {
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 619b8fbade..cd0b77c13f 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -491,6 +491,58 @@ rte_eal_mbuf_user_pool_ops(void);
 const char *
 rte_eal_get_runtime_dir(void);
 
+/**
+ * @internal
+ * Iterate to the next driver path.
+ *
+ * This function iterates through the list of dynamically loaded drivers,
+ * or driver paths that were specified via -d or --driver-path command-line
+ * options during EAL initialization.
+ *
+ * @param start
+ *   Starting iteration point. The iteration will start at the first driver path if NULL.
+ * @param cmdline_only
+ *   If true, only iterate paths from command line (-d flags).
+ *   If false, iterate all paths including those expanded from directories.
+ *
+ * @return
+ *   Next driver path string, NULL if there is none.
+ */
+const char *
+rte_eal_driver_path_next(const char *start, bool cmdline_only);
+
+/**
+ * @internal
+ * Iterate over all driver paths.
+ *
+ * This macro provides a convenient way to iterate through all driver paths
+ * that were loaded via -d flags during EAL initialization.
+ *
+ * @param path
+ *   Iterator variable of type const char *
+ * @param cmdline_only
+ *   If true, only iterate paths from command line (-d flags).
+ *   If false, iterate all paths including those expanded from directories.
+ */
+#define RTE_EAL_DRIVER_PATH_FOREACH(path, cmdline_only) \
+	for (path = rte_eal_driver_path_next(NULL, cmdline_only); \
+	     path != NULL; \
+	     path = rte_eal_driver_path_next(path, cmdline_only))
+
+/**
+ * @internal
+ * Get count of driver paths.
+ *
+ * @param cmdline_only
+ *   If true, only count paths from command line (-d flags).
+ *   If false, count all paths including those expanded from directories.
+ *
+ * @return
+ *   Number of driver paths.
+ */
+unsigned int
+rte_eal_driver_path_count(bool cmdline_only);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.51.0

