Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A096C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 10:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E87740267;
	Thu,  3 Jul 2025 12:23:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 390B640264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 12:23:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751538222; x=1783074222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mmMvp+eK0YrlNP9nux2w24ZyV5DoHM0uymS4S1f99eI=;
 b=f4YdUaFvbWeXbPjGPcJZ46SFaoeFhvqLpSqyIPYnfwy8Uypr7dfYMP0t
 6RJz0Ge1LRMq1hbs+1Cq2D29IBy5jMSIXsApjSTfuO7LeGLS+0ZaVim81
 Rkl7ol/67b6tFFMudPhZ8wonawB7LpayEm/YcashJEFq0xaEWqm8GAG5I
 cCe9g2k7xZUaAItujAcLk5tbvaJ5J26Cjd/L/6nD8UvV3b4JxkeUil6hH
 V6QiJDngFyt5E/Ak8asxZbHYhHk7ERmrFLveZ+bfh3b5/Qy5lELRvRFG2
 Tk80snLEwvsaIOJB276Q3W3ugjBmFH9VzlzJ20Q89JiMLqPUqm1qEJ54a g==;
X-CSE-ConnectionGUID: bCf5l6YESJCP3Mx9zPqAAQ==
X-CSE-MsgGUID: VSraM9qcTVCks9lYiv4twg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53826805"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="53826805"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 03:23:41 -0700
X-CSE-ConnectionGUID: dSWElie4T0aITR0bRjgImg==
X-CSE-MsgGUID: 2JAKiyIhQ56uqLLlTuTyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="158891542"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa004.jf.intel.com with ESMTP; 03 Jul 2025 03:23:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
Subject: [PATCH v3] build/x86: fix support for older compilers
Date: Thu,  3 Jul 2025 11:21:24 +0100
Message-ID: <20250703102123.3708401-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702155129.3440210-1-bruce.richardson@intel.com>
References: <20250702155129.3440210-1-bruce.richardson@intel.com>
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

Some older compilers e.g. gcc 8.5, do not support overriding
-march=native with another architecture, leading to build warnings such
as reported in Bugzilla (link below). Add a check for that case, and
explicitly add the avx512 flags if necessary.

Note: it appears that it is only the "native" flag that isn't
overridden, which makes the issue hard to reproduce e.g. using
godbolt.org, or on a modern machine. For example, testing with gcc 8.5
on a haswell machine, using 'native' vs explicit 'haswell':

gcc -march=native -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
0

gcc -march=haswell -march=skylake-avx512 -dM -E - < /dev/null | grep AVX512 | wc -l
5

Bugzilla ID: 1736
Fixes: e361ae3f59d3 ("build: reduce use of AVX compiler flags")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
V3: fix build when using meson 0.57 which doesn't flatten the sub-arrays
V2: fix commit log
---
 config/x86/meson.build | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index e2ccfb6d12..bd135eb02d 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -67,26 +67,31 @@ if is_linux or cc.get_id() == 'gcc'
     endif
 endif
 
-avx512_march_flag = '-march=x86-64-v4'
+avx512_march_flag = ['-march=x86-64-v4']
 if not cc.has_argument(avx512_march_flag)
-    avx512_march_flag = '-march=skylake-avx512'
+    avx512_march_flag = ['-march=skylake-avx512']
+endif
+# workaround for older compilers, e.g. gcc 8.5 on RHEL 8.
+# if march flag overriding doesn't work, explicitly add flags for AVX512.
+if cc.get_define('__AVX512F__', args: machine_args + avx512_march_flag) == ''
+    avx512_march_flag = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
 endif
 cc_avx512_flags = []
-if (binutils_ok and cc.has_argument(avx512_march_flag)
+if (binutils_ok and cc.has_multi_arguments(avx512_march_flag)
         and '-mno-avx512f' not in get_option('c_args'))
     # check if compiler is working with _mm512_extracti64x4_epi64
     # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
     code = '''#include <immintrin.h>
     void test(__m512i zmm){
         __m256i ymm = _mm512_extracti64x4_epi64(zmm, 0);}'''
-    result = cc.compiles(code, args : [avx512_march_flag], name : 'AVX512 checking')
+    result = cc.compiles(code, args : avx512_march_flag, name : 'AVX512 checking')
     if result == false
         machine_args += '-mno-avx512f'
         warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
     else
         cc_has_avx512 = true
         if cc.get_define('__AVX512F__', args: machine_args) == ''
-            cc_avx512_flags = [avx512_march_flag]
+            cc_avx512_flags = avx512_march_flag
             if cc.has_argument('-Wno-overriding-option')
                 cc_avx512_flags += '-Wno-overriding-option'
             endif
-- 
2.48.1

