Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD5CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 13:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4782D40615;
	Thu, 25 Jun 2026 15:08:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0391440430
 for <dev@dpdk.org>; Thu, 25 Jun 2026 15:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782392901; x=1813928901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cOWPXNpyrOjcmX13xJD7K19zIUJ7/82sl5zPNiaemoo=;
 b=BjTsr7PvvwCbd/ac3rlVzLw5iDFJUK1a/tTVTR+R0hZHVjeX/0kq6IIa
 prIAHtQIb2OPieJD+zfCtjDt/EcYHD0aMkdI6+G/5m8p9nMMNhNT83iBY
 vhJPqD00W8g+TX+LkXCRhRcLX6D4WyDKSluaMek2gQ947MG3KdJaS4EAy
 WVdF/wH2A+yBFBa+Cw62n9zTE5e5NV17fQ/BRaxnb8gS+x8MHYKXpZCPh
 R1wbwHMp4U+/GyVhFgXpSewO8Ddo8lh4MWw9Ub3tvEcl3oyBxFWRZl+yk
 OdJahKORvlG0Hs3Euy7aqy4wyZW8IcwDYHq8G+pBqBxrB5LUCob5A0KdT Q==;
X-CSE-ConnectionGUID: HeTM/7cFRLOP1b8tgKwkHg==
X-CSE-MsgGUID: NS0G6y/5TPWF5dFo06VdCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82288447"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="82288447"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 06:08:20 -0700
X-CSE-ConnectionGUID: 37qsaTjkQpSr5u7RxvqFAw==
X-CSE-MsgGUID: l9ZbxHOKQyireP/lDBeFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280863354"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 06:08:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] build: drop dependency on libbsd
Date: Thu, 25 Jun 2026 14:08:12 +0100
Message-ID: <20260625130813.1527333-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624113550.821516-1-bruce.richardson@intel.com>
References: <20260624113550.821516-1-bruce.richardson@intel.com>
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

Glibc added the strlcpy and strlcat functions to version 2.38, released
in 2023, meaning they are natively available in modern linux distros. At
this point, the value of having the libbsd provided versions of these
functions is reduced, so let's simplify the code options here by
providing just two options for strlcpy rather than three:

1. native implementation for BSD and recent Linux
2. DPDK-specific fallbacks using snprintf

Since the strlcpy and strlcat functions are the only two items used from
libbsd, we can then drop completely any DPDK dependency on libbsd.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
V2:
* took the work further than v1, dropping libbsd dependency entirely.
  Now DPDK just supports native strlcpy or it's own fallback version.
---
 app/test/test_string_fns.c        |  4 ++--
 buildtools/pkg-config/meson.build |  3 +--
 config/meson.build                |  7 +++----
 lib/eal/include/rte_string_fns.h  | 21 +++++----------------
 lib/eal/meson.build               |  4 +---
 lib/telemetry/telemetry.c         |  2 --
 lib/telemetry/telemetry_data.c    |  1 -
 lib/telemetry/telemetry_legacy.c  |  2 --
 8 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/app/test/test_string_fns.c b/app/test/test_string_fns.c
index 697cb7ed15..213a9312ea 100644
--- a/app/test/test_string_fns.c
+++ b/app/test/test_string_fns.c
@@ -134,7 +134,7 @@ static int
 test_rte_strlcat(void)
 {
 	/* only run actual unit tests if we have system-provided strlcat */
-#if defined(__BSD_VISIBLE) || defined(RTE_USE_LIBBSD)
+#ifdef RTE_HAS_STRLCPY
 #define BUF_LEN 32
 	const char dst[BUF_LEN] = "Test string";
 	const char src[] = " appended";
@@ -168,7 +168,7 @@ test_rte_strlcat(void)
 	}
 	LOG("Checked %zu combinations\n", i);
 #undef BUF_LEN
-#endif /* defined(__BSD_VISIBLE) || defined(RTE_USE_LIBBSD) */
+#endif /* RTE_HAS_STRLCPY */
 
 	return 0;
 }
diff --git a/buildtools/pkg-config/meson.build b/buildtools/pkg-config/meson.build
index b36add17e3..a0a265ad92 100644
--- a/buildtools/pkg-config/meson.build
+++ b/buildtools/pkg-config/meson.build
@@ -47,8 +47,7 @@ pkg.generate(name: 'DPDK', # main DPDK pkgconfig file
         description: '''The Data Plane Development Kit (DPDK).
 Note that CFLAGS might contain an -march flag higher than typical baseline.
 This is required for a number of static inline functions in the public headers.''',
-        requires: ['libdpdk-libs', libbsd], # may need libbsd for string funcs
-                      # if libbsd is not enabled, then this is blank
+        requires: ['libdpdk-libs'],
         libraries_private: ['-Wl,--whole-archive'] +
             dpdk_drivers + dpdk_static_libraries +
             ['-Wl,--no-whole-archive'] + platform_flags
diff --git a/config/meson.build b/config/meson.build
index d7f5e55c18..237e747eec 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -266,10 +266,9 @@ if libarchive.found()
     dpdk_conf.set('RTE_HAS_LIBARCHIVE', 1)
 endif
 
-# check for libbsd
-libbsd = dependency('libbsd', required: false, method: 'pkg-config')
-if libbsd.found()
-    dpdk_conf.set('RTE_USE_LIBBSD', 1)
+# check for strlcpy/strlcat in native libc, otherwise use DPDK fallback
+if cc.has_function('strlcpy', prefix: '#include <string.h>')
+    dpdk_conf.set('RTE_HAS_STRLCPY', 1)
 endif
 
 jansson_dep = dependency('jansson', required: false, method: 'pkg-config')
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 3713c94acb..4b2323fc34 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -55,7 +55,7 @@ rte_strsplit(char *string, int stringlen,
 /**
  * @internal
  * DPDK-specific version of strlcpy for systems without
- * libc or libbsd copies of the function
+ * a native libc copy of the function
  */
 static inline size_t
 rte_strlcpy(char *dst, const char *src, size_t size)
@@ -66,7 +66,7 @@ rte_strlcpy(char *dst, const char *src, size_t size)
 /**
  * @internal
  * DPDK-specific version of strlcat for systems without
- * libc or libbsd copies of the function
+ * a native libc copy of the function
  */
 static inline size_t
 rte_strlcat(char *dst, const char *src, size_t size)
@@ -81,24 +81,13 @@ rte_strlcat(char *dst, const char *src, size_t size)
 }
 #endif
 
-/* pull in a strlcpy function */
-#ifdef RTE_EXEC_ENV_FREEBSD
-#ifndef __BSD_VISIBLE /* non-standard functions are hidden */
+/* provide strlcpy/strlcat aliases where not natively available */
+#if !defined(RTE_HAS_STRLCPY) || \
+	(defined(RTE_EXEC_ENV_FREEBSD) && !defined(__BSD_VISIBLE))
 #define strlcpy(dst, src, size) rte_strlcpy(dst, src, size)
 #define strlcat(dst, src, size) rte_strlcat(dst, src, size)
 #endif
 
-#else /* non-BSD platforms */
-#ifdef RTE_USE_LIBBSD
-#include <bsd/string.h>
-
-#else /* no BSD header files, create own */
-#define strlcpy(dst, src, size) rte_strlcpy(dst, src, size)
-#define strlcat(dst, src, size) rte_strlcat(dst, src, size)
-
-#endif /* RTE_USE_LIBBSD */
-#endif /* FREEBSD */
-
 #ifdef __cplusplus
 extern "C" {
 #endif
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index f9fcee24ee..092f5c5261 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -18,9 +18,7 @@ deps += ['argparse', 'kvargs']
 if not is_windows
     deps += ['telemetry']
 endif
-if dpdk_conf.has('RTE_USE_LIBBSD')
-    ext_deps += libbsd
-endif
+
 if dpdk_conf.has('RTE_HAS_LIBARCHIVE')
     ext_deps += libarchive
 endif
diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index e591c1e283..f863445798 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -13,8 +13,6 @@
 #include <sys/stat.h>
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-/* we won't link against libbsd, so just always use DPDKs-specific strlcpy */
-#undef RTE_USE_LIBBSD
 #include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
diff --git a/lib/telemetry/telemetry_data.c b/lib/telemetry/telemetry_data.c
index 0a006559ab..08bdc4ea36 100644
--- a/lib/telemetry/telemetry_data.c
+++ b/lib/telemetry/telemetry_data.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <inttypes.h>
 
-#undef RTE_USE_LIBBSD
 #include <stdbool.h>
 
 #include <eal_export.h>
diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 1d73282ba8..af497a594a 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -10,8 +10,6 @@
 #include <pthread.h>
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
-/* we won't link against libbsd, so just always use DPDKs-specific strlcpy */
-#undef RTE_USE_LIBBSD
 #include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_common.h>
-- 
2.53.0

