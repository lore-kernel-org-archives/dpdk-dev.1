Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92596C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:04:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE7D40661;
	Tue, 25 Mar 2025 17:03:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 872A540663
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918607; x=1774454607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l1O2NcM3M+OKYlVvtC+GOXpwZl22tx8U1aJ+cvhPX/Y=;
 b=iIVl4IvsbqHt6bCBHqntT17AzQDkFr6Ywr4L+g20GCwU/Y7UHIS+LYRx
 XHG9VByE5P6TwFOoNFnFS5l7fNXkySk0uUFwtfdh50auMLF6GVqiHjjcw
 wOah2G9bYAHnSNugPlhsGJx/Expv/6OFTW9+Csdkj5DyACysZDgfcGrGB
 uuFDkqsEtlubFBrfqYhlMx6/kzSxwkzUkbFYIN5ewngWKvaaMOxW/smt/
 HQo+VETRLTYNqqAsI11vMDpn3tHz0f47uCkCE3OWjdQj1TLwd7pQ6DfzY
 yDoThNbilhU+hfsfbPNYJcO7Epal2zja8p1KITIYpKoRQaJHhcPwrw/SV A==;
X-CSE-ConnectionGUID: 5D0YlaCwT+Gu74Knb2Oebg==
X-CSE-MsgGUID: /XYPTg+hRLuUlsMBIiCMeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565791"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:27 -0700
X-CSE-ConnectionGUID: XZ+uOlN/S7OAH1bgGgIvtQ==
X-CSE-MsgGUID: a5AjmiJYR5W254Kt/9VAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086723"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v5 07/11] acl: use common AVX build handling
Date: Tue, 25 Mar 2025 16:02:49 +0000
Message-ID: <20250325160254.1724560-8-bruce.richardson@intel.com>
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

remove custom logic for building AVX2 and AVX-512 files.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/acl/meson.build | 54 ++++-----------------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index a80c172812..87e9f25f8e 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -15,57 +15,11 @@ headers = files('rte_acl.h', 'rte_acl_osdep.h')
 
 if dpdk_conf.has('RTE_ARCH_X86')
     sources += files('acl_run_sse.c')
-
-    avx2_tmplib = static_library('avx2_tmp',
-            'acl_run_avx2.c',
-            dependencies: static_rte_eal,
-            c_args: [cflags, cc_avx2_flags])
-    objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
-
-    # compile AVX512 version if:
-    # we are building 64-bit binary AND binutils can generate proper code
-
-    if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
-
-        # compile AVX512 version if either:
-        # a. we have AVX512 supported in minimum instruction set
-        #    baseline
-        # b. it's not minimum instruction set, but supported by
-        #    compiler
-        #
-        # in former case, just add avx512 C file to files list
-        # in latter case, compile c file to static lib, using correct
-        # compiler flags, and then have the .o file from static lib
-        # linked into main lib.
-
-        # check if all required flags already enabled (variant a).
-        acl_avx512_flags = ['__AVX512F__', '__AVX512VL__',
-            '__AVX512CD__', '__AVX512BW__']
-
-        acl_avx512_on = true
-        foreach f:acl_avx512_flags
-
-            if cc.get_define(f, args: machine_args) == ''
-                acl_avx512_on = false
-            endif
-        endforeach
-
-        if acl_avx512_on == true
-
-            sources += files('acl_run_avx512.c')
-            cflags += '-DCC_AVX512_SUPPORT'
-
-        elif cc_has_avx512
-            avx512_tmplib = static_library('avx512_tmp',
-                'acl_run_avx512.c',
-                dependencies: static_rte_eal,
-                c_args: cflags + cc_avx512_flags)
-            objs += avx512_tmplib.extract_objects(
-                    'acl_run_avx512.c')
-            cflags += '-DCC_AVX512_SUPPORT'
-        endif
+    sources_avx2 += files('acl_run_avx2.c')
+    # AVX512 is only supported on 64-bit builds
+    if dpdk_conf.has('RTE_ARCH_X86_64')
+        sources_avx512 += files('acl_run_avx512.c')
     endif
-
 elif dpdk_conf.has('RTE_ARCH_ARM')
     cflags += '-flax-vector-conversions'
     sources += files('acl_run_neon.c')
-- 
2.45.2

