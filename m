Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DCFC3600B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2886A402B4;
	Tue, 25 Mar 2025 17:03:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id ABA0F40150
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918589; x=1774454589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DgfQhcb4eQEE/rUUkO+wAGXYWCnz3T6FOU+HN3Aj5pw=;
 b=ehOXMlIvdLtbs+BbjqzmcRAvpsorocGpoBMTVEcPYK7sFfUdHxBJj6Ev
 lEo0WYUbdihypFxJOy0wqLyYglHUrrEAJaj0TheH1xlWclynxOl4GKArn
 grsXPP0/J5GT6SMQjnPYzl+YqO5eRymjdYs9c48uUHk/mbKU3MppbNrxP
 ub50XiM2wjF3vZvFP6NX2KSRdC/Rt0icTD8SASeqE0sfw3+u21cD5BA7S
 gN3PLCMF3UFqKcYsBB0h6XlM3zcm9sBY2YRv4rdfBs5ne9oTkxkFMnSa2
 vPqnuSkHLCsR1mpKk7eWXO7BXqrslG5gwRg57W6yVIJtLW7meqXbH6+ZM w==;
X-CSE-ConnectionGUID: Lq8qE9RwTJW/9qytLGfiDw==
X-CSE-MsgGUID: RkNl8zbsSqedDU01DW5dpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565695"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565695"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:08 -0700
X-CSE-ConnectionGUID: nYt/Uz7nSw2u1Cv0Jg39uw==
X-CSE-MsgGUID: wjveSlk5RKugOIh596kspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086564"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 01/11] drivers: add generalized AVX build handling
Date: Tue, 25 Mar 2025 16:02:43 +0000
Message-ID: <20250325160254.1724560-2-bruce.richardson@intel.com>
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

Add support to the top-level driver build file for AVX2 and AVX512
specific sources. This should simplify driver builds by avoiding the
need to constantly reimplement the same build logic

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..c15319dc24 100644
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
+            if sources_avx512.length() > 0 and cc_has_avx512
+                cflags += '-DCC_AVX512_SUPPORT'
+                avx512_args = [cflags, cc_avx512_flags]
+                if not target_has_avx512 and cc.has_argument('-march=skylake-avx512')
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
2.45.2

