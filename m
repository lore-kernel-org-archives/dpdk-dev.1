Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26983C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A1F8402F1;
	Tue, 18 Mar 2025 18:35:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id AB551402F1
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:35:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319319; x=1773855319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rhixRsd+JuDrcXXuR8ajETja0d8gwBt6CdCHsdWubEk=;
 b=RTvU6NlJizMOOIyBqv+HUiyA+EkGlDm0CGcC/2K+3VhVM4mkUUdQUPc6
 QOdutkZf//jTrR/ybkMAXLp3u/psDtquSEgbixyoSfrP6etO/7GI9ZBmg
 tUg7fZjr7qCY9FsoxboPMmQwu/36kDhNHNyGOMevLAoc9XCknmMblPAyD
 2LaHHyS7l8k16c+BT7419prNUaE5uhTbsjUfcxgDh/6hbDC+f8OOsa1ZM
 krtNRlDTj02YNBCyvQkcsO7qyAvUMz9GQGxr/kaC6mDAUd1UK+eEK4NdU
 R/G+K7Kf7BMJMUT8XewRMrbVP2WxLcJnad1V0usZdAXa/UxldeOFJApkN Q==;
X-CSE-ConnectionGUID: 8AsFvYJORCaB+6043jnceg==
X-CSE-MsgGUID: gD1P3gy2SsWwE/AvuCaejw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725174"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:35:18 -0700
X-CSE-ConnectionGUID: dd4h58+nSQuIHYAYmLbhWA==
X-CSE-MsgGUID: Pqm4j24KQQuPAoaT9csJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122312968"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by orviesa006.jf.intel.com with ESMTP; 18 Mar 2025 10:35:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 01/11] build: add generalized AVX handling for drivers
Date: Tue, 18 Mar 2025 17:34:54 +0000
Message-ID: <20250318173505.314529-2-bruce.richardson@intel.com>
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

Add support to the top-level driver build file for AVX2 and AVX512
specific sources. This should simplify driver builds by avoiding the
need to constantly reimplement the same build logic

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..45082f9338 100644
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

