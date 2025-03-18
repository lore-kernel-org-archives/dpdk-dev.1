Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B663C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:36:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B399540661;
	Tue, 18 Mar 2025 18:35:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id A16AC402E7
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319359; x=1773855359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F4q/eYsLfSX35vzBwbe1SwG+pYoyc/rSKXDdWJnqldo=;
 b=Tvm7jjxAY93h+65as5VES8xfZI7eGNoJwHy+4Zent6h/RFSNniJdX6bb
 SrgDuFn+8WSQ2GqJKetqa5oYHvKqoegoHEYun78ryPYNfBZAKskNhqx8v
 8IfthD8YyO8yXKI0dyjbo+PanxZStuOFW01BYGDAzYJsYb80Zr1cbUAX4
 /D8IoXoRJVMNV84ac9vEp3mYI83QJZ1nTnIFqmWTyRWSCIc3JPVjOA/Dn
 GJSBYFtkw+LTbmWnz4tRaxhdNXIZ/9/oA36LRgLXEPf7WMCzc9VHYfzUz
 Cy+0QZUCkWhheuzJpwLLFcVUT1NsUTGzJEGPHSfb9HkzB64fHtUKYE/og w==;
X-CSE-ConnectionGUID: zhvrd6P9TuGB35qX/1qZLw==
X-CSE-MsgGUID: O1ghUbXlQeqD9EKVPjcVIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725243"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:35:58 -0700
X-CSE-ConnectionGUID: Ta0OEV4vTIyCa0HJFEBZVA==
X-CSE-MsgGUID: qi3sdtOgQTu4IdOU168pZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122313283"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:35:57 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v3 09/11] net: simplify build-time logic for x86
Date: Tue, 18 Mar 2025 17:35:02 +0000
Message-ID: <20250318173505.314529-10-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318173505.314529-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
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
 lib/net/meson.build   | 53 +++++--------------------------------------
 lib/net/rte_net_crc.c |  8 +++----
 2 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/lib/net/meson.build b/lib/net/meson.build
index c9b34afc98..4bbbad3f42 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -42,57 +42,16 @@ deps += ['mbuf']
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
+        net_crc_avx512_lib_cflags = cc_avx512_flags + ['-mvpclmulqdq']
+        cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
         net_crc_avx512_lib = static_library(
                 'net_crc_avx512_lib',
                 'net_crc_avx512.c',
                 dependencies: static_rte_eal,
-                c_args: [cflags,
-                    net_crc_avx512_lib_cflags])
+                c_args: [cflags, net_crc_avx512_lib_cflags])
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

