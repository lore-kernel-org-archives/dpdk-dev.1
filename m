Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2235C3600B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A455E40685;
	Tue, 25 Mar 2025 17:03:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 240DA40685
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918617; x=1774454617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TnFz8MgLX5UjE4X8Q/+XzbRgxTil94Abxmd6l8Zy9Y4=;
 b=LNzjVknCDl7r6jUHTPEm62TnliQKCsTAFjFs5/obG3XebST+e2UY6lFs
 i2N6XhJqaUEqJsGBVudkWnoA3IsO2GOJmbppnNdIJ+lmKEsUcv6hSgvZO
 8R3Uwk6kFxbeTJ12HYqukH2WhADNFV/9P4SDd6lylH3ldY7EHJBcHfd5Y
 jTYIvbothWE5bzjY+rUo5D8UDVmRR4mjj0Gf0ofC13JGfBi+njxc/L0BG
 FY7PgRU2HqBA/DWXsp2tu62FckKFKcGQA93QY8OlVbEG/goXM92+0upZt
 EhQpFs3E8j8wEh3HqXme94UkyQxTZXvAiQH02ecYuPsTCfBowuKeSYLOI A==;
X-CSE-ConnectionGUID: srKN+PwGRPWVy7V5zWULZA==
X-CSE-MsgGUID: s1n4GzqNTRmfBVzt6/VFXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565813"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565813"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:37 -0700
X-CSE-ConnectionGUID: JnzplJnzT9K2Ufss7kApwA==
X-CSE-MsgGUID: geVjpp4xQNi7cthxvzieTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086754"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>
Subject: [PATCH v5 11/11] member: use common AVX512 build support
Date: Tue, 25 Mar 2025 16:02:53 +0000
Message-ID: <20250325160254.1724560-12-bruce.richardson@intel.com>
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
2.45.2

