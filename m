Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509F1C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 10:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D2EB40F35;
	Thu, 29 May 2025 12:34:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9E6744067D
 for <dev@dpdk.org>; Thu, 29 May 2025 12:34:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748514854; x=1780050854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zMcDH6H6DclBfIJl18U/E54fATscb+01ZTm5aTUvgOY=;
 b=j09q4v7fvP+bx97WHE1oR+VT7L8CFJzG1g0ghk9G3l/MNux4xsLU0OAD
 vsDp/U4IALRN+qXuGNep6YrvfohvlR8k0D9Lf3D+C97ypXUkQRRHqlzbI
 2hAz4Coc4+hwFHrArC4pSciAKyCpblUpOD7z3275g0IL+22wMR5Ry6sI8
 CEXAWmPeRE1cuAcN0ZMiJW2vrP0TwZlsHmiYe6PisgrcWRAxHmMrtfXXs
 TUuwqO3OBKTE3Iccg4hkK6nsPzJ13UoIuBFX/sx6mIgeAf5Bp5bosddvc
 Qsq1ZGyTx0JfdOGknA0YPI3E6H3PN62b1tFFY+7ZYUIXpCZufV0huVxZP w==;
X-CSE-ConnectionGUID: WPYNR0FpShaWNKbWoKmGQw==
X-CSE-MsgGUID: pSIK3gEuTbaZZ6QEx/+EtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61233405"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="61233405"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 03:34:13 -0700
X-CSE-ConnectionGUID: C3ptrNOmTEG4wCO6HAyCFw==
X-CSE-MsgGUID: 2FTNJTU+R3am/D79mF/qog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; d="scan'208";a="180718574"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2025 03:34:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Vipin.Varghese@amd.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3] build: reduce use of AVX compiler flags
Date: Thu, 29 May 2025 11:31:44 +0100
Message-ID: <20250529103406.1142334-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325172215.3360590-1-bruce.richardson@intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
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

When doing a build for a target that already has the instruction sets
for AVX2/AVX512 enabled, skip emitting the AVX compiler flags, or the
skylake-avx512 '-march' flags, as they are unnecessary. Instead, when
the default flags produce the desired output, just use them unmodified,
and don't bother adding in extra enabling flags for AVX2 or AVX-512.

Depends-on: series-35006 ("doc/linux_gsg: update recommended compiler versions")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

V3: put in version check to work around an issues with some meson versions,
    (hopefully) allowing builds to pass in all CIs. The printout of the
    extra flags now only happens with meson >= 0.60.2

V2: dropped the doc update for the minimum compiler version. Based on
    discussion, that version bump is larger than proposed in RFC and
    is now a separate patch/series [series 35006 referenced above]

---
 config/x86/meson.build | 31 ++++++++++++++++++++-----------
 drivers/meson.build    |  9 +--------
 lib/meson.build        |  9 +--------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index c3564b0011..7ec40376b9 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -4,11 +4,13 @@
 if is_ms_compiler
     cc_avx2_flags = ['/arch:AVX2']
 else
-    cc_avx2_flags = ['-mavx2']
+    cc_avx2_flags = []
+    if cc.get_define('__AVX2__', args: machine_args) == ''
+        cc_avx2_flags = ['-mavx2']
+    endif
 endif
 
 cc_has_avx512 = false
-target_has_avx512 = false
 
 dpdk_conf.set('RTE_ARCH_X86', 1)
 if dpdk_conf.get('RTE_ARCH_64')
@@ -65,26 +67,33 @@ if is_linux or cc.get_id() == 'gcc'
     endif
 endif
 
-cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
-if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
+avx512_march_flag = '-march=skylake-avx512'
+cc_avx512_flags = []
+if (binutils_ok and cc.has_argument(avx512_march_flag)
         and '-mno-avx512f' not in get_option('c_args'))
     # check if compiler is working with _mm512_extracti64x4_epi64
     # Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82887
     code = '''#include <immintrin.h>
     void test(__m512i zmm){
         __m256i ymm = _mm512_extracti64x4_epi64(zmm, 0);}'''
-    result = cc.compiles(code, args : cc_avx512_flags, name : 'AVX512 checking')
+    result = cc.compiles(code, args : [avx512_march_flag], name : 'AVX512 checking')
     if result == false
         machine_args += '-mno-avx512f'
         warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
     else
         cc_has_avx512 = true
-        target_has_avx512 = (
-                cc.get_define('__AVX512F__', args: machine_args) != '' and
-                cc.get_define('__AVX512BW__', args: machine_args) != '' and
-                cc.get_define('__AVX512DQ__', args: machine_args) != '' and
-                cc.get_define('__AVX512VL__', args: machine_args) != ''
-            )
+        if cc.get_define('__AVX512F__', args: machine_args) == ''
+            cc_avx512_flags = [avx512_march_flag]
+            if cc.has_argument('-Wno-overriding-option')
+                cc_avx512_args += '-Wno-overriding-option'
+            endif
+        endif
+    endif
+endif
+if developer_mode and meson.version().version_compare('>=0.60.2')
+    message('Extra C flags needed for AVX2 output: @0@'.format(cc_avx2_flags))
+    if cc_has_avx512
+        message('Extra C flags needed for AVX512 output: @0@'.format(cc_avx512_flags))
     endif
 endif
 
diff --git a/drivers/meson.build b/drivers/meson.build
index b0850bbb24..51c824ea40 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -267,18 +267,11 @@ foreach subpath:subdirs
             endif
             if sources_avx512.length() > 0 and cc_has_avx512
                 cflags += '-DCC_AVX512_SUPPORT'
-                avx512_args = [cflags, cc_avx512_flags]
-                if not target_has_avx512 and cc.has_argument('-march=skylake-avx512')
-                    avx512_args += '-march=skylake-avx512'
-                    if cc.has_argument('-Wno-overriding-option')
-                        avx512_args += '-Wno-overriding-option'
-                    endif
-                endif
                 avx512_lib = static_library(lib_name + '_avx512_lib',
                         sources_avx512,
                         dependencies: static_deps,
                         include_directories: includes,
-                        c_args: avx512_args)
+                        c_args: [cflags, cc_avx512_flags])
                 objs += avx512_lib.extract_objects(sources_avx512)
             endif
         endif
diff --git a/lib/meson.build b/lib/meson.build
index 41fd98f4e9..16389b9c34 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -260,18 +260,11 @@ foreach l:libraries
         endif
         if sources_avx512.length() > 0 and cc_has_avx512
             cflags += '-DCC_AVX512_SUPPORT'
-            avx512_args = [cflags, cflags_avx512, cc_avx512_flags]
-            if not target_has_avx512 and cc.has_argument('-march=skylake-avx512')
-                avx512_args += '-march=skylake-avx512'
-                if cc.has_argument('-Wno-overriding-option')
-                    avx512_args += '-Wno-overriding-option'
-                endif
-            endif
             avx512_lib = static_library(libname + '_avx512_lib',
                     sources_avx512,
                     dependencies: static_deps,
                     include_directories: includes,
-                    c_args: avx512_args)
+                    c_args: [cflags, cflags_avx512, cc_avx512_flags])
             objs += avx512_lib.extract_objects(sources_avx512)
         endif
     endif
-- 
2.48.1

