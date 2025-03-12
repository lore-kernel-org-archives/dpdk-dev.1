Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4901DC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 927D74029E;
	Wed, 12 Mar 2025 16:55:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2980E40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741794911; x=1773330911;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mcN2myNUqhbfaJeDPuWOC4ObWXtdDdDq/9VNDAWBrfg=;
 b=dfdF+UaGlIUL37aI8DLfdWXwly+VdDuGn+CYzceb3q0+tJ9ksT423zGN
 b/7lS4VPiXRyHnLJiB4RqlYhiM6IcT2eioWDmk9QF2GYXC+Zo+E/0lQXA
 Z0ecQS6aFzV6ixCLAlU0r8qfJMiXnqWtRHN++GUNwo0aNlnBJa3SCFG+x
 PugHudivXt7/Nw69aHuUGaSr8ibEIQ0FTvvGNoWw91KsFz5CTwOpfVxyq
 2rc9ZS/kZfPhsmsB0wfM++zeqXm+c3f4ROhoPAPkgc2u5NkJXpVlZFMC9
 B3GuqPvQit24N6PFKAyTZF+6GYIMwMgCZNWVT7L3bL8oiPTtSraGvlkv1 A==;
X-CSE-ConnectionGUID: cg9TN2V7RR+wE+KZ4PDWkA==
X-CSE-MsgGUID: oipBbD2xQ8alediB0zCkmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46531630"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="46531630"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:55:09 -0700
X-CSE-ConnectionGUID: PEYJ/3fSSEatBaJFDcFexw==
X-CSE-MsgGUID: ITBUCySiSfiuRfzHRADJLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="121379393"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa009.fm.intel.com with ESMTP; 12 Mar 2025 08:55:07 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, andremue@linux.microsoft.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Date: Wed, 12 Mar 2025 15:54:58 +0000
Message-ID: <20250312155458.1395709-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

There was an issue with building DPDK using mingw v8.1[1], which
required using the "-fno-asynchronous-unwind-tables" compiler flag when
building using the mingw compiler. However, recent versions of the
compiler no longer seem to need this flag, so remove it.

[1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/meson.build     | 4 ----
 drivers/net/intel/iavf/meson.build     | 4 ----
 drivers/net/intel/ice/base/meson.build | 4 ----
 drivers/net/intel/ice/meson.build      | 4 ----
 drivers/net/intel/ixgbe/meson.build    | 3 ---
 5 files changed, 19 deletions(-)

diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 2973ed1a01..15993393fb 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -41,10 +41,6 @@ includes += include_directories('base')
 if arch_subdir == 'x86'
     sources += files('i40e_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
-        cflags += ['-fno-asynchronous-unwind-tables']
-    endif
-
     i40e_avx2_lib = static_library('i40e_avx2_lib',
             'i40e_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index f7eac7c57a..833a63e6c8 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -29,10 +29,6 @@ includes += include_directories('base')
 if arch_subdir == 'x86'
     sources += files('iavf_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
-        cflags += ['-fno-asynchronous-unwind-tables']
-    endif
-
     iavf_avx2_lib = static_library('iavf_avx2_lib',
             'iavf_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev],
diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
index 59202df661..38d092c370 100644
--- a/drivers/net/intel/ice/base/meson.build
+++ b/drivers/net/intel/ice/base/meson.build
@@ -49,10 +49,6 @@ if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
     error_cflags += ['-Wno-array-bounds']
 endif
 
-if is_windows and cc.get_id() == 'gcc'
-    cflags += ['-fno-asynchronous-unwind-tables']
-endif
-
 c_args = cflags
 
 foreach flag: error_cflags
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index cbdf38c1c4..4d8f71cd4a 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -35,10 +35,6 @@ endif
 if arch_subdir == 'x86'
     sources += files('ice_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
-        cflags += ['-fno-asynchronous-unwind-tables']
-    endif
-
     ice_avx2_lib = static_library('ice_avx2_lib',
             'ice_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_hash],
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0ae12dd5ff..0bee736a2c 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -27,9 +27,6 @@ deps += ['hash', 'security']
 if arch_subdir == 'x86'
     sources += files('ixgbe_rxtx_vec_sse.c')
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
-    if is_windows and cc.get_id() != 'clang'
-        cflags += ['-fno-asynchronous-unwind-tables']
-    endif
 elif arch_subdir == 'arm'
     sources += files('ixgbe_rxtx_vec_neon.c')
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
-- 
2.43.0

