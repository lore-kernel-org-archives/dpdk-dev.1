Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE125C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14D040673;
	Wed, 19 Mar 2025 18:30:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8E8334067A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405424; x=1773941424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K8RMpMzIbli/izyMfeBc4/H+/5KUy8DLskiMAina8bU=;
 b=jDedsMGgbUY2hKRhQiC6YOGDfP3X2X46cZ8HiDSN64Qjq+GRmDNLENsW
 jJPyRQgqEHhrHwzwPaXewZGL8NYAqfQcE47iFN/DtRV7zFHLT6bBzdmXe
 w7Nmd8CeQEF07T1AhZDcX5wxlTb+xhCmpjm4z7dMLCLsHOGABaZaHiAGb
 RTLmRL89NS11ziJBHYTOhiQOlgD/IAmEEOFnwGWvA+hxDRyUZEPQoQezo
 qtdUY5bVb8wEPuow5tA3XHm66Wvx0utIttEnj1lyYlIarhTy4+8+hd10r
 odrYufibEvGU3DMwWXttpMGVSl7z2MXJHmkP2jQSNa+GHQh4P0AWMZtHW A==;
X-CSE-ConnectionGUID: xliqaCtNRbC0SP5tRudg5A==
X-CSE-MsgGUID: Ohg/J8NiTRqkTnAtQa3EJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43742000"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43742000"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:24 -0700
X-CSE-ConnectionGUID: TKt7vOALRtaZ5+IKuSGIaQ==
X-CSE-MsgGUID: 6mRARexbSuqHX+6mllu4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722627"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v4 10/11] net: use common AVX512 build code
Date: Wed, 19 Mar 2025 17:29:40 +0000
Message-ID: <20250319172942.2992053-11-bruce.richardson@intel.com>
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
index c9773d6300..24ec267fc8 100644
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
2.43.0

