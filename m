Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:04:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F024640667;
	Tue, 25 Mar 2025 17:03:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 045CA40665
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918610; x=1774454610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JkkivSL22SkMYMLoW/I/GrBCSdBCRkg+m2SEWreC/ec=;
 b=Fnlv2PbLzhbYsIKd+DUo6ehsS9cTT/lqs6aKDVQN1RloHjwVZeiHXPIT
 z111iHGg4/sx8Ni8PMwc1lYCwc0sSIqygZUzR7HM1yvOHvN8dcgSPLxDg
 /z/hKCAnlZuuL6J8bY0Q34dYJF7wslu1NH7XRQN+tnDav6QvtpOUaPJLQ
 WmtYIHfk0zzllRAQkF15sTf7iuz5McGruKkKfr1hqpIm3qm1CT3Vx/JeP
 zEdVzFSVIgXlH9pi/AHovyHRONyB9TxOm0p4clM5SMRoDHCVYG92Qs5Hd
 Mlu4OzEq+iQDcJ78O781+krNKm+kSzxKIISOlQRfdBBVATSqwVS3YqaUt A==;
X-CSE-ConnectionGUID: fjR/EoX7T96ZWUNa7D3g1A==
X-CSE-MsgGUID: E+Jb9jpATjyl+m6Cp4/M1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565798"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565798"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:29 -0700
X-CSE-ConnectionGUID: pwTqLEUgS5qRDBNNIuf8OA==
X-CSE-MsgGUID: cIWrmhZMQLq4hO/bviY1aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086731"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 08/11] fib: use common AVX build handling
Date: Tue, 25 Mar 2025 16:02:50 +0000
Message-ID: <20250325160254.1724560-9-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325160254.1724560-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
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

Remove custom logic for building AVX2 and AVX-512 files. Within the C
code this requires some renaming of build macros to use the standard
defines.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/fib/dir24_8.c   |  6 +++---
 lib/fib/meson.build | 18 +-----------------
 lib/fib/trie.c      |  6 +++---
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index c48d962d41..2ba7e93511 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -16,11 +16,11 @@
 #include "dir24_8.h"
 #include "fib_log.h"
 
-#ifdef CC_DIR24_8_AVX512_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 
 #include "dir24_8_avx512.h"
 
-#endif /* CC_DIR24_8_AVX512_SUPPORT */
+#endif /* CC_AVX512_SUPPORT */
 
 #define DIR24_8_NAMESIZE	64
 
@@ -63,7 +63,7 @@ get_scalar_fn_inlined(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 static inline rte_fib_lookup_fn_t
 get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 {
-#ifdef CC_DIR24_8_AVX512_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
 			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) <= 0 ||
 			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_512)
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index 0c19cc8201..55d9ddcee9 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -15,21 +15,5 @@ deps += ['rcu']
 deps += ['net']
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
-    if target_has_avx512
-        cflags += ['-DCC_DIR24_8_AVX512_SUPPORT', '-DCC_TRIE_AVX512_SUPPORT']
-        sources += files('dir24_8_avx512.c', 'trie_avx512.c')
-
-    elif cc_has_avx512
-        cflags += ['-DCC_DIR24_8_AVX512_SUPPORT', '-DCC_TRIE_AVX512_SUPPORT']
-        dir24_8_avx512_tmp = static_library('dir24_8_avx512_tmp',
-                'dir24_8_avx512.c',
-                dependencies: [static_rte_eal, static_rte_rcu],
-                c_args: cflags + cc_avx512_flags)
-        objs += dir24_8_avx512_tmp.extract_objects('dir24_8_avx512.c')
-        trie_avx512_tmp = static_library('trie_avx512_tmp',
-                'trie_avx512.c',
-                dependencies: [static_rte_eal, static_rte_rcu, static_rte_net],
-                c_args: cflags + cc_avx512_flags)
-        objs += trie_avx512_tmp.extract_objects('trie_avx512.c')
-    endif
+    sources_avx512 = files('dir24_8_avx512.c', 'trie_avx512.c')
 endif
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 4893f6c636..6c20057ac5 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -14,11 +14,11 @@
 #include <rte_fib6.h>
 #include "trie.h"
 
-#ifdef CC_TRIE_AVX512_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 
 #include "trie_avx512.h"
 
-#endif /* CC_TRIE_AVX512_SUPPORT */
+#endif /* CC_AVX512_SUPPORT */
 
 #define TRIE_NAMESIZE		64
 
@@ -45,7 +45,7 @@ get_scalar_fn(enum rte_fib_trie_nh_sz nh_sz)
 static inline rte_fib6_lookup_fn_t
 get_vector_fn(enum rte_fib_trie_nh_sz nh_sz)
 {
-#ifdef CC_TRIE_AVX512_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
 			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) <= 0 ||
 			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0 ||
-- 
2.45.2

