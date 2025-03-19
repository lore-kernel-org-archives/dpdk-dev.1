Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B82DC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE58840693;
	Wed, 19 Mar 2025 18:30:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 115D340685
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405426; x=1773941426;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RSBNWgivHbv7g35lUmwaoi/6d2txL1Z3MJYMx9t9QKg=;
 b=R8g/IoUIDo06jIOyF/uyhKDkOzTzpv/nsxpvC6n8O0mt0Q8z6nB+Cry5
 p1qZa3iJC5MNODlHfz2yXO8ndwzZJ1S6rc+EJbgxYaLdf+A/bt1+JW8Jy
 2VuSS39bhZfFugixI0Q9NyVl5eKTzWtUVWgB0YMTcmdcn1OnoxpOs98+c
 lK2KqwGSwCnnH/ldM0/KGEp8FtnGndcC8HJqgTaNRYdHKN4cdSXwRJRBk
 aHoaHTGlse08IACXcmJPppRcId3V5MvSwrNbhyfSSi+eObaCcbSg1xm/s
 XILzfy+zLxOSZEBYksxicmbxKwRcKFrdV2+OQKxCnAVMUEPweRw35ooRr g==;
X-CSE-ConnectionGUID: YkqkWIMMRSyCzYlbs9XUiA==
X-CSE-MsgGUID: NeyDJ7zZRx6T5xuy98EuMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43742004"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43742004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:25 -0700
X-CSE-ConnectionGUID: vZBTBgobTDOOwsL1CKcTQA==
X-CSE-MsgGUID: lQRjthw2Rxi2PeeleunLuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722635"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v4 11/11] member: use common AVX512 build support
Date: Wed, 19 Mar 2025 17:29:41 +0000
Message-ID: <20250319172942.2992053-12-bruce.richardson@intel.com>
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

Use the support for building AVX512 code present in lib/meson.build
rather than reimplementing it in the library meson.build file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/member/meson.build | 46 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/lib/member/meson.build b/lib/member/meson.build
index 4341b424df..07f9afaed9 100644
--- a/lib/member/meson.build
+++ b/lib/member/meson.build
@@ -20,44 +20,12 @@ sources = files(
 
 deps += ['hash', 'ring']
 
-# compile AVX512 version if:
-if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
-    # compile AVX512 version if either:
-    # a. we have AVX512 supported in minimum instruction set
-    #    baseline
-    # b. it's not minimum instruction set, but supported by
-    #    compiler
-    #
-    # in former case, just add avx512 C file to files list
-    # in latter case, compile c file to static lib, using correct
-    # compiler flags, and then have the .o file from static lib
-    # linked into main lib.
-
-    member_avx512_args = cc_avx512_flags
-    if not is_ms_compiler
-            member_avx512_args += '-mavx512ifma'
-    endif
-
-    # check if all required flags already enabled
-    sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
-
-    sketch_avx512_on = true
-    foreach f:sketch_avx512_flags
-        if cc.get_define(f, args: machine_args) == ''
-            sketch_avx512_on = false
-        endif
-    endforeach
-
-    if sketch_avx512_on == true
-        cflags += ['-DCC_AVX512_SUPPORT']
-        sources += files('rte_member_sketch_avx512.c')
-    elif cc.has_multi_arguments(member_avx512_args)
-        sketch_avx512_tmp = static_library('sketch_avx512_tmp',
-            'rte_member_sketch_avx512.c',
-            include_directories: includes,
-            dependencies: [static_rte_eal, static_rte_hash],
-            c_args: cflags + member_avx512_args)
-        objs += sketch_avx512_tmp.extract_objects('rte_member_sketch_avx512.c')
-        cflags += ['-DCC_AVX512_SUPPORT']
+# compile AVX512 version if we have avx512 on MSVC or the 'ifma' flag on GCC/Clang
+if dpdk_conf.has('RTE_ARCH_X86_64')
+    if is_ms_compiler
+        sources_avx512 += files('rte_member_sketch_avx512.c')
+    elif cc.has_argument('-mavx512ifma')
+        sources_avx512 += files('rte_member_sketch_avx512.c')
+        cflags_avx512 += '-mavx512ifma'
     endif
 endif
-- 
2.43.0

