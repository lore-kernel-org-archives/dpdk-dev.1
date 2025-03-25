Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD0C3600D
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:04:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 909494067E;
	Tue, 25 Mar 2025 17:03:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7105640678
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918614; x=1774454614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ofk1+EQiq+sKuIl43TP4yrwzlw5KtwOIegOf7i2asII=;
 b=L1AnrpY0fpV4XOzFfkar+EhFy5C2RMbD7sjyABc1FD9TKg9J5/fsM8wE
 SXzyUu936SGYw283KNsGd1kzswatJQGCphFq12cwtFi70DyQ43OUIp3OD
 qEdX7UQ8fxKAELkuVnHyObzsSvpRjDCx+R3L8Zjg0BsNnd7roaRMaxP1e
 faOAtGXfGsf02MhsITw9eJ1LlEeSuxuTYU8JoLKQP5YIZEqOHmUZXWN1W
 pgy+lqYK7tXxIPQoiiddtLy1AzRCTFvpdYvRAdRISCm3QEXvTvkvxM+OE
 GthkiEDQD62C1ca0FsQYVmm6V+kCOC+L9o5sBTqlH9543IZyRugQo83Uq Q==;
X-CSE-ConnectionGUID: VprrPhhSQ2aSWVkghdlKDg==
X-CSE-MsgGUID: V3ctmqQcTFKB3AY11DUBog==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565807"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565807"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:34 -0700
X-CSE-ConnectionGUID: fieQQkp7Sc+XC/OQR54j0A==
X-CSE-MsgGUID: KX8PRDuDS2egJCg3LMNTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086751"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:32 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v5 10/11] net: use common AVX512 build code
Date: Tue, 25 Mar 2025 16:02:52 +0000
Message-ID: <20250325160254.1724560-11-bruce.richardson@intel.com>
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

Use the common support for AVX512 code present in lib/meson.build,
rather than hard-coding it. The only complication is an extra check for
the "-mvpclmulqdq" command-line flag before adding the AVX512 sources.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/net/meson.build   | 12 ++++--------
 lib/net/rte_net_crc.c |  8 ++++----
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/lib/net/meson.build b/lib/net/meson.build
index cd49b4d758..7a6c419f40 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -44,14 +44,10 @@ use_function_versioning = true
 if dpdk_conf.has('RTE_ARCH_X86_64')
     sources += files('net_crc_sse.c')
     cflags += ['-mpclmul', '-maes']
-    if cc.has_argument('-mvpclmulqdq') and cc_has_avx512
-        cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
-        net_crc_avx512_lib = static_library(
-                'net_crc_avx512_lib',
-                'net_crc_avx512.c',
-                dependencies: static_rte_eal,
-                c_args: [cflags, cc_avx512_flags, '-mvpclmulqdq'])
-        objs += net_crc_avx512_lib.extract_objects('net_crc_avx512.c')
+    # only build AVX-512 support if we also have PCLMULQDQ support
+    if cc.has_argument('-mvpclmulqdq')
+        sources_avx512 += files('net_crc_avx512.c')
+        cflags_avx512 += ['-mvpclmulqdq']
     endif
 
 elif (dpdk_conf.has('RTE_ARCH_ARM64') and
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 8d11515712..b5a5dabd4f 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -60,7 +60,7 @@ static const rte_net_crc_handler handlers_scalar[] = {
 	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_handler,
 	[RTE_NET_CRC32_ETH] = rte_crc32_eth_handler,
 };
-#ifdef CC_X86_64_AVX512_VPCLMULQDQ_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 static const rte_net_crc_handler handlers_avx512[] = {
 	[RTE_NET_CRC16_CCITT] = rte_crc16_ccitt_avx512_handler,
 	[RTE_NET_CRC32_ETH] = rte_crc32_eth_avx512_handler,
@@ -185,7 +185,7 @@ rte_crc32_eth_handler(const uint8_t *data, uint32_t data_len)
 static const rte_net_crc_handler *
 avx512_vpclmulqdq_get_handlers(void)
 {
-#ifdef CC_X86_64_AVX512_VPCLMULQDQ_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 	if (AVX512_VPCLMULQDQ_CPU_SUPPORTED &&
 			max_simd_bitwidth >= RTE_VECT_SIMD_512)
 		return handlers_avx512;
@@ -197,7 +197,7 @@ avx512_vpclmulqdq_get_handlers(void)
 static void
 avx512_vpclmulqdq_init(void)
 {
-#ifdef CC_X86_64_AVX512_VPCLMULQDQ_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 	if (AVX512_VPCLMULQDQ_CPU_SUPPORTED)
 		rte_net_crc_avx512_init();
 #endif
@@ -305,7 +305,7 @@ handlers_init(enum rte_net_crc_alg alg)
 
 	switch (alg) {
 	case RTE_NET_CRC_AVX512:
-#ifdef CC_X86_64_AVX512_VPCLMULQDQ_SUPPORT
+#ifdef CC_AVX512_SUPPORT
 		if (AVX512_VPCLMULQDQ_CPU_SUPPORTED) {
 			handlers_dpdk26[alg].f[RTE_NET_CRC16_CCITT] =
 				rte_crc16_ccitt_avx512_handler;
-- 
2.45.2

