Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BFBCCA464
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:01:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E3C940A8A;
	Fri, 16 Oct 2026 13:00:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 05CC440663
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792148412; x=1823684412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ioUqWWdVNZfsbdCSzh5e83TRrusO59/lX/agfZL1CbU=;
 b=nczAT6NXpP3UqhkDcRZ98vf33/JGnc4Fi3G2GJLTvuFHxLH26V7QzX10
 EpDhnab/7Q8BeYpdh6JrUUfYtjtO9nDlNMLz60Rt221LG3u2DUfhEoMF6
 Mcgwb3SQvfoSFZaKNG2i/slOCS9jKmPAYE58jajAUN4Zw3oL59ajUSEG2
 bvqvYBzz31TytbnsbQa5KZB5EP0kPayKO2WDdjS1mn/wJqooG2IqX5KXV
 8xgpuL+GU0zX/uNbKbERCK48M7jT4yDRuRT9YLcjFD5jIHIX5HjCjdbMw
 3OoJbY70/4m7O6Re5leippsNX3PPAmuj53k2PHiJmlzwTl1STsczletOE g==;
X-CSE-ConnectionGUID: HWOVKYjISS2bnAkFirF7Bg==
X-CSE-MsgGUID: JwjKAn78RKSK1+CCxnm6bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="944145"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="944145"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:00:11 -0700
X-CSE-ConnectionGUID: G951sDKwRbilJWRXgV29SA==
X-CSE-MsgGUID: 2nyFaXteRKeWbCRuYCyAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="3759408"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa011.fm.intel.com with ESMTP; 16 Oct 2026 04:00:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 10/12] build: add EAL common directory to global include
 list
Date: Fri, 16 Oct 2026 11:59:48 +0100
Message-ID: <20261016105950.273068-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016105950.273068-1-bruce.richardson@intel.com>
References: <20261016105950.273068-1-bruce.richardson@intel.com>
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

The eal/common directory includes many headers needed internally to
build various libraries, so add it to the global include rather than
relying on it being added separately in the lib meson.build file. To
simplify things further we can then just use global_inc as a standard
set of includes for building libraries - both pre and post-eal. While
those built with a dependency on EAL don't need this include, having it
there is harmless.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/common/mlx5/linux/meson.build | 1 -
 lib/eal/meson.build                   | 1 -
 lib/log/meson.build                   | 1 -
 lib/meson.build                       | 5 +----
 meson.build                           | 1 +
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3767e7a69b..69dbbc8593 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -239,7 +239,6 @@ if dlopen_ibverbs
     dlopen_sources = files('mlx5_glue.c')
     dlopen_install_dir = [ eal_pmd_path + '-glue' ]
     dlopen_includes = [global_inc]
-    dlopen_includes += include_directories('../../../../lib/eal/common')
     dlopen_includes += include_directories('..')
     shared_lib = shared_library(
             dlopen_lib_name,
diff --git a/lib/eal/meson.build b/lib/eal/meson.build
index 092f5c5261..e72276a7ca 100644
--- a/lib/eal/meson.build
+++ b/lib/eal/meson.build
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2019 Intel Corporation
 
-includes += global_inc
 subdir('include')
 
 subdir('common')
diff --git a/lib/log/meson.build b/lib/log/meson.build
index b3de57b9c7..00f45b6bae 100644
--- a/lib/log/meson.build
+++ b/lib/log/meson.build
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2023 Intel Corporation
 
-includes += global_inc
 sources = files(
         'log.c',
         'log_color.c',
diff --git a/lib/meson.build b/lib/meson.build
index 8adb510513..16c7a65786 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -132,7 +132,7 @@ foreach l:libraries
     headers = []
     indirect_headers = [] # public headers not directly included by apps
     driver_sdk_headers = [] # public headers included by drivers
-    includes = []
+    includes = global_inc
     cflags = default_cflags
     objs = [] # other object files to link against, used e.g. for
               # instruction-set optimized versions of code
@@ -146,9 +146,6 @@ foreach l:libraries
     if dpdk_conf.has('RTE_LIB_EAL')
         # eal is standard dependency once built
         deps += ['eal']
-    else
-        # otherwise, make private headers available (like eal_export.h)
-        includes += include_directories('eal/common')
     endif
 
     if dpdk_libs_deprecated.contains(l)
diff --git a/meson.build b/meson.build
index e153894ac7..4536f7e9c5 100644
--- a/meson.build
+++ b/meson.build
@@ -76,6 +76,7 @@ endif
 config_inc = [include_directories('.', 'config')]
 global_inc = [config_inc, include_directories(
     'lib/eal/include',
+    'lib/eal/common',
     'lib/eal/@0@/include'.format(host_machine.system()),
     'lib/eal/@0@/include'.format(arch_subdir),
 )]
-- 
2.53.0

