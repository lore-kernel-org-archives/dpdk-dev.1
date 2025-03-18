Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04397C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C35E40669;
	Tue, 18 Mar 2025 18:36:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3B37C4066E
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:36:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319366; x=1773855366;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RSBNWgivHbv7g35lUmwaoi/6d2txL1Z3MJYMx9t9QKg=;
 b=M/z07bKqOt93BtK0xREQVbcgXwf+6fNbmPB5ulOWnVje3Stdh6lxMmRO
 Mcl4efHmdHBNkkOKFPxvK91aor0wr2r98THRgrCl89FKudbmQ6T9XIvqn
 K0aXoKJFW7stSHtDrBt7A2gc9EzE6/gMq1CDAXI/uV2My943zTOFDZMvI
 jB6I+8BrAoYUkYsm0muvN2ENToFGJEB9bpgvoVyTavuhhWx/7nJDAplNC
 MH6AMLw+MWXtbUvEE4Pou8gaHhNzYJON5rCBTDcCGyAN5YcrgS2T0eFTz
 pxx2A0proYFgBcAZWgSpK5VNLxl/RA7L0d1jDaWLj8jBJk6izfwOVG0jG g==;
X-CSE-ConnectionGUID: RWjfptFKRv+Pz8EDj7AzFQ==
X-CSE-MsgGUID: fMyt3XXpT4eRbh8efsZ4mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725274"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725274"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:36:06 -0700
X-CSE-ConnectionGUID: zJnjFVjlRMSpDsIQDjFkXA==
X-CSE-MsgGUID: 0jv78YsXQN+WkXW/Gp3a0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122313352"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:36:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v3 11/11] member: use common AVX512 build support
Date: Tue, 18 Mar 2025 17:35:04 +0000
Message-ID: <20250318173505.314529-12-bruce.richardson@intel.com>
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

