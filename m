Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE06C36008
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 17:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 209354029A;
	Tue, 25 Mar 2025 18:22:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id F2D404027C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 18:22:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742923345; x=1774459345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bQsj3DdLjFUYi5sFmKxmvMXYigVnXYBv9iKIVZhXe2w=;
 b=ZZPbzEDq5WIPVGp6kIm96XlxQ1eRmjvuBbmp7bB4sw56PMrb//6Ell9T
 LRnpG762eY/Kz5S42toQbFcnVn3galw51bbQ/IethRjkNzbND3aB/dFa4
 tqdgHR395fkMgV1r+7kzoWtAoJ2a3AfPZw/HUdUQQ4YEd4u9q1YTgqvyP
 AbzBCOOFHFReRAKmVHdlp8V3wyEp/fSTA2fEHc/9NOGteIYlPfPoomalr
 5L9SlzTYW0CcL9XCrAuA7TinhOeoCo7ib8y2q4TFKUX+sFnpp+5NX60wc
 1GM6Xd2+/YpFpR1l732i2LoYWceewzO+48i0/I19igJizFaN/qJ5shpB0 w==;
X-CSE-ConnectionGUID: FAllyvu2SJCAE2+woFWVRw==
X-CSE-MsgGUID: m+rDT5wySL+IvfzpHyesNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="43910693"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="43910693"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 10:22:23 -0700
X-CSE-ConnectionGUID: ZzKqg1o6RymkJWSNWmNeEw==
X-CSE-MsgGUID: vXVO3wjeRkuO/J3aSlQnRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="124913753"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa010.fm.intel.com with ESMTP; 25 Mar 2025 10:22:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH] build: reduce use of AVX compiler flags
Date: Tue, 25 Mar 2025 17:22:15 +0000
Message-ID: <20250325172215.3360590-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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
the default flags produce the desired output, just use them unmodified.

Depends-on: series-34915 ("remove component-specific logic for AVX builds")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---

This patchset depends on the previous AVX rework. However, sending it
separately as a new RFC because it effectively increases the minimum
compiler versions needed for x86 builds - from GCC 5 to 6, and
Clang 3.6 to 3.9.

For now, I've just documented that as an additional note in the GSG that
these versions are recommended, but it would be simpler if we could just
set them as the required minimum baseline (at least in the docs).

Feedback on these compiler version requirements welcome.

---
 config/x86/meson.build            | 31 ++++++++++++++++++++-----------
 doc/guides/linux_gsg/sys_reqs.rst |  8 ++++++++
 drivers/meson.build               |  9 +--------
 lib/meson.build                   |  9 +--------
 4 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index c3564b0011..97f790b0d4 100644
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
+if developer_mode
+    message('Extra C flags needed for AVX2 output: @0@'.format(cc_avx2_flags))
+    if cc_has_avx512
+        message('Extra C flags needed for AVX512 output: @0@'.format(cc_avx512_flags))
     endif
 endif

diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 5a7d9e4a43..55e9fe4724 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -35,6 +35,14 @@ Compilation of the DPDK
     * For Ubuntu/Debian systems these can be installed using ``apt install build-essential``
     * For Alpine Linux, ``apk add alpine-sdk bsd-compat-headers``

+.. note::
+
+   When compiling for x86 platforms,
+   GCC version 6.1 or higher,
+   or Clang version 3.9 or higher is recommended.
+   Earlier versions of these compilers do not support the compiler flags used by DPDK for AVX-512 code.
+   As such, any builds using earlier compilers will be missing AVX-512 support.
+
 .. note::

    pkg-config 0.27, supplied with RHEL-7,
diff --git a/drivers/meson.build b/drivers/meson.build
index c15319dc24..bb33b0a7a0 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -249,18 +249,11 @@ foreach subpath:subdirs
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
index e2605e7d68..887e0ed56d 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -257,18 +257,11 @@ foreach l:libraries
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
2.45.2

