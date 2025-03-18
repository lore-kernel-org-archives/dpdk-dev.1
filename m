Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A2CC28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D63DA40611;
	Tue, 18 Mar 2025 18:36:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 23D2C40668
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:36:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319362; x=1773855362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ybpco9n6sHPANUIXszZGaTQG1pKx25MxWZAdhPkusGw=;
 b=nQYI01fdKUHV8OROW+fYHBwEXpaEOE1wEHsrZ6xGkvpnzLE5x3bPh9pk
 Vkozi//L8zW1BN0dkac9wG+NX5G/mGZ/l7fa+1jLxQoCAIU3Hg7Ni3Kvj
 1Ee3+Va0d62bEqx3Q97YADcTi78vpdZC5nIqfJR5hbQCUWZg9VuK8Q9D8
 FpRIcKROe4Wbg/4vLRmmI1gfTi/w3MxAFHFErmOd/RmK289REKEmnFMdT
 YUReMIu0A5tcZ3/vTGI3a7ROqCo3VfVZYyERUre03zC4kzvtZ1orA//wL
 Bfwne2u105HN3ecRRqL06vbU5TI8/SNbSd2WUwDP45ZrR/0YG+rPLqTUF Q==;
X-CSE-ConnectionGUID: kAnOkWUBR/m7bk8f52c/cQ==
X-CSE-MsgGUID: 2+2bYyhNSFixxKMCt3RKqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725261"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725261"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:36:02 -0700
X-CSE-ConnectionGUID: J4j1VE9ITDainKeMozeQ/A==
X-CSE-MsgGUID: yi4IPyG8QyqK7FuTiW9g9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122313331"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:36:00 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: [PATCH v3 10/11] net: use common AVX512 build code
Date: Tue, 18 Mar 2025 17:35:03 +0000
Message-ID: <20250318173505.314529-11-bruce.richardson@intel.com>
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

Use the common support for AVX512 code present in lib/meson.build,
rather than hard-coding it. The only complication is an extra check for
the "-mvpclmulqdq" command-line flag before adding the AVX512 sources.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/net/meson.build   | 13 ++++---------
 lib/net/rte_net_crc.c |  8 ++++----
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/lib/net/meson.build b/lib/net/meson.build
index 4bbbad3f42..7a6c419f40 100644
--- a/lib/net/meson.build
+++ b/lib/net/meson.build
@@ -44,15 +44,10 @@ use_function_versioning = true
 if dpdk_conf.has('RTE_ARCH_X86_64')
     sources += files('net_crc_sse.c')
     cflags += ['-mpclmul', '-maes']
-    if cc.has_argument('-mvpclmulqdq') and cc_has_avx512
-        net_crc_avx512_lib_cflags = cc_avx512_flags + ['-mvpclmulqdq']
-        cflags += ['-DCC_X86_64_AVX512_VPCLMULQDQ_SUPPORT']
-        net_crc_avx512_lib = static_library(
-                'net_crc_avx512_lib',
-                'net_crc_avx512.c',
-                dependencies: static_rte_eal,
-                c_args: [cflags, net_crc_avx512_lib_cflags])
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

