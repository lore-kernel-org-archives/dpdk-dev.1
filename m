Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8512C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:35:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C324065B;
	Tue, 18 Mar 2025 18:35:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id A86CE40653
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319346; x=1773855346;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6N4adrzCQJbg/sf7c7AEnn0JUBSfzll1t/4dCNytp+s=;
 b=Bq1TUAEsG2OUA3/UYeYRI26InINOves31pbY1xRQ4G04uv9aMgogEvlh
 mrhA8EsMK33RT3s/xsIPh7/FhkcdcQ7aQni9y3c871l+Ns4Sq0myUmeAQ
 AR7B+rvA1vo1NxGFOg8KabkHeQD3cEK+q1OyrewNo2hQ6m6lqvzg2ARfc
 SDoUaBvcQayow4dkkCXwS3alV7Lg90pHIOfF47AI5nRCSeSW6DApkkL6N
 fjLFdzHvdE6CFKC+TeIgfddrPp0Zfp3A0lJJIHp+p2Op+NomGGS3WfgXZ
 nutz9aBiO/MoTLMTIa33VFPi88SDcskR0COU9dSKnF7WmIraeJr0AeF8/ A==;
X-CSE-ConnectionGUID: H6iIMg9LScimi3fRYfN4Rg==
X-CSE-MsgGUID: Wy5YrAEPRrmirRiHIlJ3Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725223"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:35:45 -0700
X-CSE-ConnectionGUID: MMy+UoktTw69AP4TSN1KzA==
X-CSE-MsgGUID: XBo1yTb6Q8qP+s4FVG2W1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122313205"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:35:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 06/11] build: add generalized AVX handling for libs
Date: Tue, 18 Mar 2025 17:34:59 +0000
Message-ID: <20250318173505.314529-7-bruce.richardson@intel.com>
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

Add support to the top-level lib build file for AVX2 and AVX512
specific sources. This should simplify library builds by avoiding the
need to constantly reimplement the same build logic

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/meson.build | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/lib/meson.build b/lib/meson.build
index ce92cb5537..30ac84263c 100644
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
+            if cc.has_argument('-march=skylake-avx512')
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
2.43.0

