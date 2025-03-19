Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A53C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:31:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9A9C4067E;
	Wed, 19 Mar 2025 18:30:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1B3194066F
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405423; x=1773941423;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7/hswew/GOEJTuUiQgEhkKzLL/wJ7CIUQcb+Ct0vW6w=;
 b=LDLs/v9TjjDCA1N1f3gaGPXkLfs2n+V/xOC3KkOpzU2gmtaNnDIoid24
 lsC7/mYUKrl/uw/KR5IuFfJMCiUHgqOc05dOzjBvBYjF5bFnl4nxbvyGL
 oJ6HdRI2vgFOu4uEgFRkOJp0wg4I5UJ1pDmALQRPMosywfM2AlPu1Z7/M
 1wYuUO9e5fSZYNkHyKrk/NWNRJJSxAlJ7ygZyac1MLKmaNwNaot6bLhwo
 CAzQQfdNR0ZSCk2fx4qpKkkKBRfyHIQQaWB6DTiDYw+1Z32hjBjrQZ9h2
 QyN7sEKlnreZSCmk0VmA4c5fV1fRI3Ofxwm0UBeIZ9GNYJz1z9h6STccq g==;
X-CSE-ConnectionGUID: jIdqRI56ROih+oDbrs8jig==
X-CSE-MsgGUID: 5yYh+AKmQRupVehphgJ8pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43741998"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43741998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:22 -0700
X-CSE-ConnectionGUID: SkcfyrTARZCP17Wpj+TBBg==
X-CSE-MsgGUID: f+tH4dOPRQ2Zrwlxn4HBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722622"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:21 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v4 09/11] net: simplify build-time logic for x86
Date: Wed, 19 Mar 2025 17:29:39 +0000
Message-ID: <20250319172942.2992053-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319172942.2992053-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
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

All DPDK-supported versions of clang and gcc have the "-mpclmul" and
"-maes" flags, so we never need to check for those. This allows the SSE
code path to be unconditionally built on x86.

For the AVX512 code path, simplify it by only checking for the
build-time support, and always doing a separate build with AVX512
support when that compiler support is present.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/net/meson.build   | 52 +++++--------------------------------------
 lib/net/rte_net_crc.c |  8 +++----
 2 files changed, 9 insertions(+), 51 deletions(-)

diff --git a/lib/net/meson.build b/lib/net/meson.build
index c9b34afc98..cd49b4d758 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -42,57 +42,15 @@ deps += ['mbuf']
 use_function_versioning = true
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
-    net_crc_sse42_cpu_support = (cc.get_define('__PCLMUL__', args: machine_args) != '')
-    net_crc_avx512_cpu_support = (
-            target_has_avx512 and
-            cc.get_define('__VPCLMULQDQ__', args: machine_args) != ''
-    )
-
-    net_crc_sse42_cc_support = (cc.has_argument('-mpclmul') and cc.has_argument('-maes'))
-    net_crc_avx512_cc_support = (cc.has_argument('-mvpclmulqdq') and cc_has_avx512)
-
-    build_static_net_crc_sse42_lib = 0
-    build_static_net_crc_avx512_lib = 0
-
-    if net_crc_sse42_cpu_support == true
-        sources += files('net_crc_sse.c')
-        cflags += ['-DCC_X86_64_SSE42_PCLMULQDQ_SUPPORT']
-        if net_crc_avx512_cpu_support == true
-            sources += files('net_crc_avx512.c')
-            cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
-        elif net_crc_avx512_cc_support == true
-            build_static_net_crc_avx512_lib = 1
-            net_crc_avx512_lib_cflags = cc_avx512_flags + ['-mvpclmulqdq']
-            cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
-        endif
-    elif net_crc_sse42_cc_support == true
-        build_static_net_crc_sse42_lib = 1
-        net_crc_sse42_lib_cflags = ['-mpclmul', '-maes']
-        cflags += ['-DCC_X86_64_SSE42_PCLMULQDQ_SUPPORT']
-        if net_crc_avx512_cc_support == true
-            build_static_net_crc_avx512_lib = 1
-            net_crc_avx512_lib_cflags = cc_avx512_flags + ['-mvpclmulqdq', '-mpclmul']
-            cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
-        endif
-    endif
-
-    if build_static_net_crc_sse42_lib == 1
-        net_crc_sse42_lib = static_library(
-                'net_crc_sse42_lib',
-                'net_crc_sse.c',
-                dependencies: static_rte_eal,
-                c_args: [cflags,
-                    net_crc_sse42_lib_cflags])
-        objs += net_crc_sse42_lib.extract_objects('net_crc_sse.c')
-    endif
-
-    if build_static_net_crc_avx512_lib == 1
+    sources += files('net_crc_sse.c')
+    cflags += ['-mpclmul', '-maes']
+    if cc.has_argument('-mvpclmulqdq') and cc_has_avx512
+        cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
         net_crc_avx512_lib = static_library(
                 'net_crc_avx512_lib',
                 'net_crc_avx512.c',
                 dependencies: static_rte_eal,
-                c_args: [cflags,
-                    net_crc_avx512_lib_cflags])
+                c_args: [cflags, cc_avx512_flags, '-mvpclmulqdq'])
         objs += net_crc_avx512_lib.extract_objects('net_crc_avx512.c')
     endif
 
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 2fb3eec231..c9773d6300 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -66,7 +66,7 @@ static const rte_net_crc_handler handlers_avx512[] = {
 	[RTE_NET_CRC32_ETH] = rte_crc32_eth_avx512_handler,
 };
 #endif
-#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
+#ifdef RTE_ARCH_X86_64
 static const rte_net_crc_handler handlers_sse42[] = {
 	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_sse42_handler,
 	[RTE_NET_CRC32_ETH] = rte_crc32_eth_sse42_handler,
@@ -211,7 +211,7 @@ avx512_vpclmulqdq_init(void)
 static const rte_net_crc_handler *
 sse42_pclmulqdq_get_handlers(void)
 {
-#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
+#ifdef RTE_ARCH_X86_64
 	if (SSE42_PCLMULQDQ_CPU_SUPPORTED &&
 			max_simd_bitwidth >= RTE_VECT_SIMD_128)
 		return handlers_sse42;
@@ -223,7 +223,7 @@ sse42_pclmulqdq_get_handlers(void)
 static void
 sse42_pclmulqdq_init(void)
 {
-#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
+#ifdef RTE_ARCH_x86_64
 	if (SSE42_PCLMULQDQ_CPU_SUPPORTED)
 		rte_net_crc_sse42_init();
 #endif
@@ -316,7 +316,7 @@ handlers_init(enum rte_net_crc_alg alg)
 #endif
 		/* fall-through */
 	case RTE_NET_CRC_SSE42:
-#ifdef CC_X86_64_SSE42_PCLMULQDQ_SUPPORT
+#ifdef RTE_ARCH_X86_64
 		if (SSE42_PCLMULQDQ_CPU_SUPPORTED) {
 			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
 				rte_crc16_ccitt_sse42_handler;
-- 
2.43.0

