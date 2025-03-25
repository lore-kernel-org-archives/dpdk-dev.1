Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C7C3600B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DAB4065E;
	Tue, 25 Mar 2025 17:03:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 283104065C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918605; x=1774454605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ir/+mHjIoYnNjvXwh9ZoRcdTb06fNJjvx1ipihbKoi8=;
 b=JNM3z2ex5pwRtdf12weXBnF3N/tHLedskIT5Po4QOaGS6h5QeLSz4Rvx
 WhX/SQzskKr57qC1glyRzbfw7v/FOSM3/mWqtZOBixXA9b+5veHjR4sgi
 Au2ei1thHFmMF3FrNbOP/fljrbBKizx8sUlXRfZpYoJIFSlKj82FG+uOD
 0r/VbQc33C6sfEgyd1EuGWwt2az/IpONwZ3I0D3FSgSUZGyb+vRmCv/Lf
 Eopl9LDAnn9FDVzNIaFnzHqgylw/pHMXbILNesdcmiDa/jGwaNtCGMhs5
 Yc3jULHVi0X7CQX/z4dFP5L9ycbbGPF/0I0bFDfprxpRsAvIT84hugTsl A==;
X-CSE-ConnectionGUID: xSsO0fUUTIyaXQzJFzQTSQ==
X-CSE-MsgGUID: U9kPNXbgTWOr/wdtGxuuJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565785"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565785"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:24 -0700
X-CSE-ConnectionGUID: KdfzeThSQkqzVyW2eMsJHw==
X-CSE-MsgGUID: AvhnLNgJQ1Wr+Jg4Aq9GNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086703"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 06/11] lib: add generalized AVX build handling
Date: Tue, 25 Mar 2025 16:02:48 +0000
Message-ID: <20250325160254.1724560-7-bruce.richardson@intel.com>
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

Add support to the top-level lib build file for AVX2 and AVX512
specific sources. This should simplify library builds by avoiding the
need to constantly reimplement the same build logic

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/meson.build | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/meson.build b/lib/meson.build
index ce92cb5537..e2605e7d68 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -122,6 +122,9 @@ foreach l:libraries
     use_function_versioning = false
     annotate_locks = true
     sources = []
+    sources_avx2 = []
+    sources_avx512 = []
+    cflags_avx512 = [] # extra cflags for the avx512 code, e.g. extra avx512 feature flags
     headers = []
     indirect_headers = [] # public headers not directly included by apps
     driver_sdk_headers = [] # public headers included by drivers
@@ -242,7 +245,36 @@ foreach l:libraries
         cflags += '-Wthread-safety'
     endif
 
-    # first build static lib
+    # handle avx2 and avx512 source files
+    if arch_subdir == 'x86'
+        if sources_avx2.length() > 0
+            avx2_lib = static_library(libname + '_avx2_lib',
+                    sources_avx2,
+                    dependencies: static_deps,
+                    include_directories: includes,
+                    c_args: [cflags, cc_avx2_flags])
+            objs += avx2_lib.extract_objects(sources_avx2)
+        endif
+        if sources_avx512.length() > 0 and cc_has_avx512
+            cflags += '-DCC_AVX512_SUPPORT'
+            avx512_args = [cflags, cflags_avx512, cc_avx512_flags]
+            if not target_has_avx512 and cc.has_argument('-march=skylake-avx512')
+                avx512_args += '-march=skylake-avx512'
+                if cc.has_argument('-Wno-overriding-option')
+                    avx512_args += '-Wno-overriding-option'
+                endif
+            endif
+            avx512_lib = static_library(libname + '_avx512_lib',
+                    sources_avx512,
+                    dependencies: static_deps,
+                    include_directories: includes,
+                    c_args: avx512_args)
+            objs += avx512_lib.extract_objects(sources_avx512)
+        endif
+    endif
+
+
+    # build static lib
     static_lib = static_library(libname,
             sources,
             objects: objs,
-- 
2.45.2

