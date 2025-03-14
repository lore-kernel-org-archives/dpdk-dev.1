Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE98C35FF1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:23:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D4C140430;
	Fri, 14 Mar 2025 18:23:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 97871402EB
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741973037; x=1773509037;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oOcZYIcYSb/PNwS3s8I/xpXJsFNl8j22LH4zGgxFvuc=;
 b=YfZ4hRgpHu2Yq6BnZUITztNuY8f9T24Puf/L5JQK2AMEtPCqovSgt8FA
 M9DvSBLYhuAiWvgJo+2mIzy1eAfiopq3o8oFvqL+qa8PCnuIpS/qiF9gT
 N6uRWXElZIIW76y9xOJ1SheOpHVKaYkUQ/mYjLEvwyprHMAAAGpLc7y/r
 FnSeUxsCRuCL71ZH2f5/4N9qZd3Kafet71uwVr/+SypLtpgZATRpKYLwV
 c+pY9Hsl6c4Wbc7DKiZWfzPhP/LKNCFJlz5SVg1oxpjLvbfoB3Ispz7BA
 e1NVIMpeH3DfNdmeNo13sB/ED7TcPS2Ue6sexXUcvbHUotCgeiUyF1Svt w==;
X-CSE-ConnectionGUID: RxfeN5MpScCYU4PfWEHnuw==
X-CSE-MsgGUID: xtLaPJmGSv2pV1tRoTCp4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54131624"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="54131624"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:23:56 -0700
X-CSE-ConnectionGUID: 2S8Cg/A1TWuoyprArSOyHw==
X-CSE-MsgGUID: r5ZpD2ZlSvCdDBR01fzuJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="144520949"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa002.fm.intel.com with ESMTP; 14 Mar 2025 10:23:55 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/3] build: add generalized AVX handling for drivers
Date: Fri, 14 Mar 2025 17:23:36 +0000
Message-ID: <20250314172339.12777-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314172339.12777-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
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

Add support to the top-level driver build file for AVX2 and AVX512
specific sources. This should simplify driver builds by avoiding the
need to constantly reimplement the same build logic

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..c42c7764bf 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -126,6 +126,8 @@ foreach subpath:subdirs
         name = drv
         annotate_locks = true
         sources = []
+        sources_avx2 = []
+        sources_avx512 = []
         headers = []
         driver_sdk_headers = [] # public headers included by drivers
         objs = []
@@ -235,6 +237,34 @@ foreach subpath:subdirs
             dpdk_includes += include_directories(drv_path)
         endif
 
+        # handle avx2 and avx512 source files
+        if arch_subdir == 'x86'
+            if sources_avx2.length() > 0
+                avx2_lib = static_library(lib_name + '_avx2_lib',
+                        sources_avx2,
+                        dependencies: static_deps,
+                        include_directories: includes,
+                        c_args: [cflags, cc_avx2_flags])
+                objs += avx2_lib.extract_objects(sources_avx2)
+            endif
+            if sources_avx512.length() > 0
+                cflags += '-DCC_AVX512_SUPPORT'
+                avx512_args = [cflags, cc_avx512_flags]
+                if cc.has_argument('-march=skylake-avx512')
+                    avx512_args += '-march=skylake-avx512'
+                    if cc.has_argument('-Wno-overriding-option')
+                        avx512_args += '-Wno-overriding-option'
+                    endif
+                endif
+                avx512_lib = static_library(lib_name + '_avx512_lib',
+                        sources_avx512,
+                        dependencies: static_deps,
+                        include_directories: includes,
+                        c_args: avx512_args)
+                objs += avx512_lib.extract_objects(sources_avx512)
+            endif
+        endif
+
         # generate pmdinfo sources by building a temporary
         # lib and then running pmdinfogen on the contents of
         # that lib. The final lib reuses the object files and
-- 
2.43.0

