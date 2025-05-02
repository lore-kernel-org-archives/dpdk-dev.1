Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24124C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B46740670;
	Fri,  2 May 2025 17:12:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C33604066D
 for <dev@dpdk.org>; Fri,  2 May 2025 17:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746198727; x=1777734727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+qPpC2DPLRLBjVxPC2zSimMfgrNIHcnvtR7TKZWvR/o=;
 b=eHVQfwPU0mNATmZamJhIzdylTmKaFcqgq4tSZJbstcaaaERZd+ZIpDHj
 d1dtZfBpe3tZsPzQfZD0L8Ts8SJB31URWCpJahzeT9z5OVMEqlE40xffE
 9hcFEAA8R8DrU8B29iPCB52J7niwrkDI+b85xCHa8ks0LBTCsIt+Qezqa
 8yVPlCM2fq0XhLLrqAQsjJjllKFtf5z+BLvn2+Rw+Yt5H5kE7r4HZPC42
 bEBi9NuTvtD7nfG6CrwVP/99mL2/cWZtIzM9mA13KiPJAl+PkFdb1kteV
 BOEnoT/HSfQ+tJeO2Ze1BECkJAL4VHwJQ1UxlroVIRUPBHmyMrTxL1urf g==;
X-CSE-ConnectionGUID: t2yh4zVHT/qydymjCte92A==
X-CSE-MsgGUID: iVIMrqbgRzGhQrCffX/Kew==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47970513"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47970513"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:12:05 -0700
X-CSE-ConnectionGUID: r51KZJc7QVm4zg+fbNlpwA==
X-CSE-MsgGUID: CJV9W6oNRaCSxigF2kbC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135172774"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 02 May 2025 08:12:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, mb@smartsharesystems.com,
 stephen@networkplumber.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/4] eal: merge corelist and core mapping options
Date: Fri,  2 May 2025 16:11:32 +0100
Message-ID: <20250502151134.536799-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502151134.536799-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
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

The "-l" EAL parameter supported a subset of the features that were
provided by the "--lcores" long option. There is no need to have two
different options with different behaviour in this case, so we can just
eliminate the special-case handling for "-l", and have it as a shortened
form of "--lcores".

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/linux_gsg/eal_args.include.rst     |  10 +-
 .../prog_guide/env_abstraction_layer.rst      |   3 +-
 lib/eal/common/eal_common_options.c           | 135 ++----------------
 lib/eal/common/eal_options.h                  |   4 +-
 4 files changed, 21 insertions(+), 131 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 7ffd2e2535..01fe6a3006 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -4,16 +4,14 @@
 Lcore-related options
 ~~~~~~~~~~~~~~~~~~~~~
 
-*   ``-l <core list>``
+*   ``-l/--lcores <core list>``
 
     List of cores to run on
 
-    The argument format is ``<c1>[-c2][,c3[-c4],...]``
-    where ``c1``, ``c2``, etc are core indexes between 0 and 128.
+    Simplest argument format is ``<c1>[-c2][,c3[-c4],...]``
+    where ``c1``, ``c2``, etc are core indexes between 0 and ``RTE_MAX_LCORE`` (default 128).
 
-*   ``--lcores <core map>``
-
-    Map lcore set to physical cpu set
+    This argument can also be used to map lcore set to physical cpu set
 
     The argument format is::
 
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 04214a05b2..fca9cc0afa 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -729,7 +729,7 @@ As EAL pthreads usually bind 1:1 to the physical CPU, the *_lcore_id* is typical
 
 When using multiple pthreads, however, the binding is no longer always 1:1 between an EAL pthread and a specified physical CPU.
 The EAL pthread may have affinity to a CPU set, and as such the *_lcore_id* will not be the same as the CPU ID.
-For this reason, there is an EAL long option '--lcores' defined to assign the CPU affinity of lcores.
+For this reason, there is an EAL option ``--lcores`` (or just ``-l``) defined to assign the CPU affinity of lcores.
 For a specified lcore ID or ID group, the option allows setting the CPU set for that EAL pthread.
 
 The format pattern:
@@ -753,7 +753,6 @@ If a '\@cpu_set' value is not supplied, the value of 'cpu_set' will default to t
     	    lcore 8 runs on cpuset 0x100 (cpu 8).
 
 Using this option, for each given lcore ID, the associated CPUs can be assigned.
-It's also compatible with the pattern of corelist('-l') option.
 
 non-EAL pthread support
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 19c5997c7c..ed514ec1d1 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -46,7 +46,6 @@
 #define BITS_PER_HEX 4
 #define LCORE_OPT_LST 1
 #define LCORE_OPT_MSK 2
-#define LCORE_OPT_MAP 3
 
 const char
 eal_short_options[] =
@@ -921,85 +920,6 @@ eal_parse_service_corelist(const char *corelist)
 	return 0;
 }
 
-static int
-eal_parse_corelist(const char *corelist, int *cores)
-{
-	unsigned int count = 0, i;
-	int lcores[RTE_MAX_LCORE];
-	char *end = NULL;
-	int min, max;
-	int idx;
-
-	for (idx = 0; idx < RTE_MAX_LCORE; idx++)
-		cores[idx] = -1;
-
-	/* Remove all blank characters ahead */
-	while (isblank(*corelist))
-		corelist++;
-
-	/* Get list of cores */
-	min = -1;
-	do {
-		while (isblank(*corelist))
-			corelist++;
-		if (*corelist == '\0')
-			return -1;
-		errno = 0;
-		idx = strtol(corelist, &end, 10);
-		if (errno || end == NULL)
-			return -1;
-		if (idx < 0)
-			return -1;
-		while (isblank(*end))
-			end++;
-		if (*end == '-') {
-			min = idx;
-		} else if ((*end == ',') || (*end == '\0')) {
-			max = idx;
-			if (min == -1)
-				min = idx;
-			for (idx = min; idx <= max; idx++) {
-				bool dup = false;
-
-				/* Check if this idx is already present */
-				for (i = 0; i < count; i++) {
-					if (lcores[i] == idx)
-						dup = true;
-				}
-				if (dup)
-					continue;
-				if (count >= RTE_MAX_LCORE) {
-					EAL_LOG(ERR, "Too many lcores provided. Cannot exceed RTE_MAX_LCORE (%d)",
-						RTE_MAX_LCORE);
-					return -1;
-				}
-				lcores[count++] = idx;
-			}
-			min = -1;
-		} else
-			return -1;
-		corelist = end + 1;
-	} while (*end != '\0');
-
-	if (count == 0)
-		return -1;
-
-	if (check_core_list(lcores, count))
-		return -1;
-
-	/*
-	 * Now that we've got a list of cores no longer than RTE_MAX_LCORE,
-	 * and no lcore in that list is greater than RTE_MAX_LCORE, populate
-	 * the cores array.
-	 */
-	do {
-		count--;
-		cores[lcores[count]] = count;
-	} while (count != 0);
-
-	return 0;
-}
-
 /* Changes the lcore id of the main thread */
 static int
 eal_parse_main_lcore(const char *arg)
@@ -1703,10 +1623,10 @@ eal_parse_common_option(int opt, const char *optarg,
 		}
 
 		if (core_parsed) {
-			EAL_LOG(ERR, "Option -c is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_LST) ? "-l" :
-				(core_parsed == LCORE_OPT_MAP) ? "--lcores" :
-				"-c");
+			if (core_parsed == LCORE_OPT_MSK)
+				EAL_LOG(ERR, "Option '-c' passed multiple times to EAL");
+			else
+				EAL_LOG(ERR, "Option -c is ignored, because option -l/--lcores used");
 			return -1;
 		}
 
@@ -1715,31 +1635,20 @@ eal_parse_common_option(int opt, const char *optarg,
 	}
 	/* corelist */
 	case 'l': {
-		int lcore_indexes[RTE_MAX_LCORE];
-
 		if (eal_service_cores_parsed())
 			EAL_LOG(WARNING,
 				"Service cores parsed before dataplane cores. Please ensure -l is before -s or -S");
 
-		if (eal_parse_corelist(optarg, lcore_indexes) < 0) {
-			EAL_LOG(ERR, "invalid core list syntax");
-			return -1;
-		}
-		if (update_lcore_config(lcore_indexes) < 0) {
-			char *available = available_cores();
-
-			EAL_LOG(ERR,
-				"invalid core list, please check specified cores are part of %s",
-				available);
-			free(available);
+		if (eal_parse_lcores(optarg) < 0) {
+			EAL_LOG(ERR, "invalid parameter for -l/--" OPT_LCORES);
 			return -1;
 		}
 
 		if (core_parsed) {
-			EAL_LOG(ERR, "Option -l is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_MSK) ? "-c" :
-				(core_parsed == LCORE_OPT_MAP) ? "--lcores" :
-				"-l");
+			if (core_parsed == LCORE_OPT_LST)
+				EAL_LOG(ERR, "Core list option passed multiple times to EAL");
+			else
+				EAL_LOG(ERR, "Option '-l/--lcores' is ignored, because coremask option used");
 			return -1;
 		}
 
@@ -1926,23 +1835,6 @@ eal_parse_common_option(int opt, const char *optarg,
 	}
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-	case OPT_LCORES_NUM:
-		if (eal_parse_lcores(optarg) < 0) {
-			EAL_LOG(ERR, "invalid parameter for --"
-				OPT_LCORES);
-			return -1;
-		}
-
-		if (core_parsed) {
-			EAL_LOG(ERR, "Option --lcores is ignored, because (%s) is set!",
-				(core_parsed == LCORE_OPT_LST) ? "-l" :
-				(core_parsed == LCORE_OPT_MSK) ? "-c" :
-				"--lcores");
-			return -1;
-		}
-
-		core_parsed = LCORE_OPT_MAP;
-		break;
 	case OPT_LEGACY_MEM_NUM:
 		conf->legacy_mem = 1;
 		break;
@@ -2214,10 +2106,11 @@ eal_common_usage(void)
 	printf("[options]\n\n"
 	       "EAL common options:\n"
 	       "  -c COREMASK         Hexadecimal bitmask of cores to run on\n"
-	       "  -l CORELIST         List of cores to run on\n"
-	       "                      The argument format is <c1>[-c2][,c3[-c4],...]\n"
+	       "  -l, --"OPT_LCORES" CORELIST\n"
+	       "                      List of cores to run on\n"
+	       "                      The basic argument format is <c1>[-c2][,c3[-c4],...]\n"
 	       "                      where c1, c2, etc are core indexes between 0 and %d\n"
-	       "  --"OPT_LCORES" COREMAP    Map lcore set to physical cpu set\n"
+	       "                      Can also be used to map lcore set to physical cpu set\n"
 	       "                      The argument format is\n"
 	       "                            '<lcores[@cpus]>[<,lcores[@cpus]>...]'\n"
 	       "                      lcores and cpus list are grouped by '(' and ')'\n"
diff --git a/lib/eal/common/eal_options.h b/lib/eal/common/eal_options.h
index 95fb4f6108..7b84b7d778 100644
--- a/lib/eal/common/eal_options.h
+++ b/lib/eal/common/eal_options.h
@@ -17,6 +17,8 @@ enum {
 	OPT_DEV_ALLOW_NUM       = 'a',
 #define OPT_DEV_BLOCK         "block"
 	OPT_DEV_BLOCK_NUM      = 'b',
+#define OPT_LCORES            "lcores"
+	OPT_LCORES_NUM         = 'l',
 
 	/* first long only option value must be >= 256, so that we won't
 	 * conflict with short options */
@@ -31,8 +33,6 @@ enum {
 	OPT_HUGE_DIR_NUM,
 #define OPT_HUGE_UNLINK       "huge-unlink"
 	OPT_HUGE_UNLINK_NUM,
-#define OPT_LCORES            "lcores"
-	OPT_LCORES_NUM,
 #define OPT_LOG_COLOR	      "log-color"
 	OPT_LOG_COLOR_NUM,
 #define OPT_LOG_LEVEL         "log-level"
-- 
2.45.2

