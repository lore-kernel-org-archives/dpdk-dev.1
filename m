Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BF7C35FFC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:30:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0342B4066A;
	Wed, 19 Mar 2025 18:30:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1CBBD4026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405420; x=1773941420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=djY+irPAJ8BII7aNrg9KbZ0EXuxlgvDNrec6cti+dU8=;
 b=EUQaEQtJW81gJlxvwmhdvWwmshfrPBBr5O86N8uMYHr8sJIuacO2FeMF
 Rr1xfGz+VGdH5g3C/WzOMPO1AnQ5Xtg8v/9pUUmBjIddA+1z3w0mmSgaZ
 dd/2S93eFD0vDT6gvj5/L5p0YmSQsCJUIJe6OFFSQ706BdKzO/Qc40JY0
 5/MS1YQqIlWdmlscpD/nKOob/rtPfjF8z5hsoUFrZj9yse43jGEuPeSP1
 2AUI0SlDJdS+RqrNlM6VSvJNInlfEcXQOTyb/6n4WzQVECYoom42LRhdC
 9o4NIsmI0AGFOydZbgnu+lo1TjsYvOmg+VfDvfLcLmfobdcV7Qqo0IKvB Q==;
X-CSE-ConnectionGUID: fTVVGetoQkumQRfC0ANVhg==
X-CSE-MsgGUID: AjqxuX+AS265kDVwlDBnGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43741991"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43741991"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:19 -0700
X-CSE-ConnectionGUID: 0UaVpcYNSI+cDRagJAUUmw==
X-CSE-MsgGUID: QSjWUynKQRyySkrrmx/kzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722612"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v4 07/11] acl: use common AVX build handling
Date: Wed, 19 Mar 2025 17:29:37 +0000
Message-ID: <20250319172942.2992053-8-bruce.richardson@intel.com>
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
2.43.0

