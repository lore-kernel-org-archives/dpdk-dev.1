Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9CCC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:29:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73F6940A8A;
	Mon,  7 Apr 2025 17:29:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E46D840A89
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039760; x=1775575760;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sn+CWp+4fTJih7tERapwg4RsC4VBxx4bT0GC3lfdM4E=;
 b=JvxtJ10MR42yxA3OSurgJhnFlM5aySDo0vG1yAQMhWKTMR8KAL3n6wfi
 wgmCoFaj6mdKDcxs19xqhp9V99SzgOC6v2e2nWRCp5IzyS+szbHhVzYeS
 VSYVVDITGpN1gzS7GxU7AZhVQDA09JBzqd8ucdC7m87nSgY+qf4J/WeI9
 lk2MeGtj2f5KNp3OzCYyEHUB3jnqwF2/okIeqZpw6RA8UKs58thVA+7SX
 l+7kbRo4eFt7ZTDnHv84x8qoYHOaslCY7fA5hDLb9S/oAevB7wUKS/dz/
 ii4HlY+hB0TGtqJGyHVkjfOlyzDF27Z7j1kAaTb/Q6Zp1hb5YhNRH7LAR w==;
X-CSE-ConnectionGUID: Ii4BAkdFRt6kucbpKbz+Ww==
X-CSE-MsgGUID: AhJd7d3USdCQQ4xHVeigvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56094893"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="56094893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:29:19 -0700
X-CSE-ConnectionGUID: z26C7YsmT92zkgvdO1l3TQ==
X-CSE-MsgGUID: MuY1/NwMSm68kDC0gQ4xFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="127965726"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 07 Apr 2025 08:29:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Jie Hai <haijie1@huawei.com>
Subject: [RFC PATCH] drivers: add generic build of SVE files
Date: Mon,  7 Apr 2025 16:28:57 +0100
Message-ID: <20250407152857.2203839-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

For SVE, as for AVX2 and AVX-512, support building files for these ISAs
from the top-level drivers/meson.build file, rather than having each
driver re-implement it.

This removes the remaining build task for drivers in DPDK which is
being done by a driver itself, rather than in the generic drivers'
build rules.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/meson.build          | 27 +++++++++++++++++++++++++++
 drivers/net/hns3/meson.build | 22 +---------------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index b2d2537dc8..a6f0670a2f 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -128,6 +128,7 @@ foreach subpath:subdirs
         sources = []
         sources_avx2 = []
         sources_avx512 = []
+        sources_sve = []
         headers = []
         driver_sdk_headers = [] # public headers included by drivers
         objs = []
@@ -285,6 +286,32 @@ foreach subpath:subdirs
             endif
         endif

+        if (arch_subdir == 'arm' and sources_sve.length() > 0
+                and cc.has_argument('-march=armv8.2-a+sve')
+                and cc.check_header('arm_sve.h'))
+
+            if dpdk_conf.has('RTE_HAS_SVE_ACLE')
+                sources += sources_sve
+            else
+                cflags += ['-DRTE_HAS_SVE_ACLE=1']
+                sve_cflags = ['-march=armv8.2-a+sve']
+                foreach flag: cflags
+                    if (flag.startswith('-march=')
+                            or flag.startswith('-mcpu=')
+                            or flag.startswith('-mtune='))
+                        continue
+                    endif
+                    sve_cflags += flag
+                endforeach
+                sve_lib = static_library(libname + '_sve_lib',
+                        sources_sve,
+                        dependencies: static_deps,
+                        include_directories: includes,
+                        c_args: sve_cflags)
+                objs += sve_lib.extract_objects(sources_sve)
+            endif
+        endif
+
         # generate pmdinfo sources by building a temporary
         # lib and then running pmdinfogen on the contents of
         # that lib. The final lib reuses the object files and
diff --git a/drivers/net/hns3/meson.build b/drivers/net/hns3/meson.build
index 53a9dd6f39..87f04aa440 100644
--- a/drivers/net/hns3/meson.build
+++ b/drivers/net/hns3/meson.build
@@ -43,25 +43,5 @@ cflags += no_wvla_cflag

 if arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('hns3_rxtx_vec.c')
-
-    # compile SVE when:
-    # a. support SVE in minimum instruction set baseline
-    # b. it's not minimum instruction set, but compiler support
-    if dpdk_conf.has('RTE_HAS_SVE_ACLE')
-        sources += files('hns3_rxtx_vec_sve.c')
-    elif cc.has_argument('-march=armv8.2-a+sve') and cc.check_header('arm_sve.h')
-        cflags += ['-DRTE_HAS_SVE_ACLE=1']
-        sve_cflags = []
-        foreach flag: cflags
-            if not (flag.startswith('-march=') or flag.startswith('-mcpu=') or flag.startswith('-mtune='))
-                sve_cflags += flag
-            endif
-        endforeach
-        hns3_sve_lib = static_library('hns3_sve_lib',
-                        'hns3_rxtx_vec_sve.c',
-                        dependencies: [static_rte_ethdev],
-                        include_directories: includes,
-                        c_args: [sve_cflags, '-march=armv8.2-a+sve'])
-        objs += hns3_sve_lib.extract_objects('hns3_rxtx_vec_sve.c')
-    endif
+    sources_sve += files('hns3_rxtx_vec_sve.c')
 endif
--
2.45.2

