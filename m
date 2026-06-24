Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA54CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F744025E;
	Wed, 24 Jun 2026 13:35:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3102B400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 13:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782300958; x=1813836958;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=auWVVcSpHa7Q5sgjN2lfKVBPcrabj5NBVDsfXSIyKOg=;
 b=B9mnpBR44FdFkt/VtSn6r09xez2ePs3NCWXS8xsy0FPFngxosGZf65fi
 FrkeOHE1NUxpGlrCTO1+HPJEibXb2uOgOtGx2b04AutHtu94OxonGV19S
 3WSLgUNnXFrPsi53Lbdtvr0iRBu1qdaFrZNEotBEUzHY0/EYtNUihx7xW
 PycyZVTs0uHyTZ+nnaLR+AW37duaIhJBMIAhn78cVQaIhHuDJpVahH1zA
 Q+4hL5giZ1Nh6CDOHv+1TqK4ila6AnrERlRbNBA0KZnZ8rptCAjMwbjB6
 Q3/lNErSqzrq90deUAxe1kavixPEQVLeHJx8c3z8ELEbUDL6nZjaAOx3V Q==;
X-CSE-ConnectionGUID: iNF0KNJBTe+INPnkEepLkA==
X-CSE-MsgGUID: wFYg+AKSQ2WODveZ9kyPxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83154157"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="83154157"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:35:57 -0700
X-CSE-ConnectionGUID: clX8KK7uQGyvhdJUTIVAmA==
X-CSE-MsgGUID: pV/BY2EEQ2CjdivRndmnxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="251762991"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2026 04:35:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] build: use native Linux strlcpy when available
Date: Wed, 24 Jun 2026 12:35:49 +0100
Message-ID: <20260624113550.821516-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Glibc added the strlcpy and strlcat functions to version 2.38, meaning
they are natively available in modern linux distros without having to
use libbsd, or a dpdk-specific fallback. Therefore, we adjust our
fallback detection logic to have meson check for the presence of these
functions before checking if we actually need libbsd. Then in
rte_string_fns.h we rework our macros a little for setting the fallback:

1. If libbsd is to be used, just always include it as a standalone
   block. With new meson logic, we only use it if we have to, even if
   present.
2. For BSD, configure fallback functions only if __BSD_VISIBLE is not
   defined, otherwise just use native fns.
3. Otherwise for Linux and Windows, configure the fallback functions if
   meson has not set RTE_HAS_STRLCPY.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/meson.build               | 14 ++++++++++----
 lib/eal/include/rte_string_fns.h | 18 +++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/config/meson.build b/config/meson.build
index d7f5e55c18..0049cd3807 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -266,10 +266,16 @@ if libarchive.found()
     dpdk_conf.set('RTE_HAS_LIBARCHIVE', 1)
 endif
 
-# check for libbsd
-libbsd = dependency('libbsd', required: false, method: 'pkg-config')
-if libbsd.found()
-    dpdk_conf.set('RTE_USE_LIBBSD', 1)
+# check for strlcpy: first in native libc, then via libbsd as fallback
+if cc.has_function('strlcpy', prefix: '#include <string.h>')
+    dpdk_conf.set('RTE_HAS_STRLCPY', 1)
+    libbsd = dependency('', required: false)  # empty not-found dependency
+else
+    libbsd = dependency('libbsd', required: false, method: 'pkg-config')
+    if libbsd.found()
+        dpdk_conf.set('RTE_USE_LIBBSD', 1)
+        dpdk_conf.set('RTE_HAS_STRLCPY', 1)
+    endif
 endif
 
 jansson_dep = dependency('jansson', required: false, method: 'pkg-config')
diff --git a/lib/eal/include/rte_string_fns.h b/lib/eal/include/rte_string_fns.h
index 3713c94acb..4fb2a6c1ce 100644
--- a/lib/eal/include/rte_string_fns.h
+++ b/lib/eal/include/rte_string_fns.h
@@ -14,6 +14,9 @@
 #include <ctype.h>
 #include <stdio.h>
 #include <string.h>
+#ifdef RTE_USE_LIBBSD
+#include <bsd/string.h>
+#endif
 
 #include <rte_common.h>
 #include <rte_compat.h>
@@ -81,23 +84,16 @@ rte_strlcat(char *dst, const char *src, size_t size)
 }
 #endif
 
-/* pull in a strlcpy function */
+/* provide strlcpy/strlcat aliases where not natively available */
 #ifdef RTE_EXEC_ENV_FREEBSD
 #ifndef __BSD_VISIBLE /* non-standard functions are hidden */
 #define strlcpy(dst, src, size) rte_strlcpy(dst, src, size)
 #define strlcat(dst, src, size) rte_strlcat(dst, src, size)
-#endif
-
-#else /* non-BSD platforms */
-#ifdef RTE_USE_LIBBSD
-#include <bsd/string.h>
-
-#else /* no BSD header files, create own */
+#endif /* __BSD_VISIBLE */
+#elif !defined(RTE_HAS_STRLCPY)
 #define strlcpy(dst, src, size) rte_strlcpy(dst, src, size)
 #define strlcat(dst, src, size) rte_strlcat(dst, src, size)
-
-#endif /* RTE_USE_LIBBSD */
-#endif /* FREEBSD */
+#endif /* RTE_EXEC_ENV_FREEBSD */
 
 #ifdef __cplusplus
 extern "C" {
-- 
2.53.0

