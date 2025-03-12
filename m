Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39204C282EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 02:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D6540265;
	Wed, 12 Mar 2025 03:14:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E43D040264
 for <dev@dpdk.org>; Wed, 12 Mar 2025 03:14:03 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 270012045FE8; Tue, 11 Mar 2025 19:14:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 270012045FE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741745643;
 bh=0DH1Qos7wGUrK1S3jvaNwz7OExz/zoOrxyVqNOskasM=;
 h=From:To:Cc:Subject:Date:From;
 b=Qbjy1cgoQAD53Omp5IbKEXpQwOsalxcWb57z7PYeqo/Ms7U7FX7QHSmj7QI90qOyV
 P9m4WPZPZ7QB3dlOA/w5hYXM2NcyWCeA66q47er/fdJc/odeww6DI2SHLLuZ4yB704
 4OOmMe2EJOgieZF5zxcuhCdVnzE1F0wgnLV7gfnk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] drivers: remove invalid options for MSVC
Date: Tue, 11 Mar 2025 19:13:56 -0700
Message-Id: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling "drivers" directory with MSVC the errors below popped up:

1)
LINK : warning LNK4044: unrecognized option
'/Wl,/def:V:\github\dpdk\build\drivers\rte_bus_vdev_exports.def'; ignored

2)
cl : Command line warning D9002 : ignoring unknown
    option '-fno-asynchronous-unwind-tables'

The fix is to remove the unnecessary/invalid option when using MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/meson.build                 | 6 +++++-
 drivers/net/intel/i40e/meson.build  | 2 +-
 drivers/net/intel/iavf/meson.build  | 2 +-
 drivers/net/intel/ice/meson.build   | 2 +-
 drivers/net/intel/ixgbe/meson.build | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/meson.build b/drivers/meson.build
index 05391a575d..fc7f7eed8c 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -289,7 +289,11 @@ foreach subpath:subdirs
                         output: '@0@_exports.def'.format(lib_name))
                 lk_deps += [def_file]
 
-                lk_args = ['-Wl,/def:' + def_file.full_path()]
+                if is_ms_compiler
+                    lk_args = ['/def:' + def_file.full_path()]
+                else
+                    lk_args = ['-Wl,/def:' + def_file.full_path()]
+                endif
             else
                 mingw_map = custom_target(lib_name + '_mingw',
                         command: [map_to_win_cmd, '@INPUT@', '@OUTPUT@'],
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 2973ed1a01..fce5d997ed 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -41,7 +41,7 @@ includes += include_directories('base')
 if arch_subdir == 'x86'
     sources += files('i40e_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
+    if is_windows and cc.get_id() == 'gcc'
         cflags += ['-fno-asynchronous-unwind-tables']
     endif
 
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index f7eac7c57a..d801527ada 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -29,7 +29,7 @@ includes += include_directories('base')
 if arch_subdir == 'x86'
     sources += files('iavf_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
+    if is_windows and cc.get_id() == 'gcc'
         cflags += ['-fno-asynchronous-unwind-tables']
     endif
 
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index cbdf38c1c4..a28d62173c 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -35,7 +35,7 @@ endif
 if arch_subdir == 'x86'
     sources += files('ice_rxtx_vec_sse.c')
 
-    if is_windows and cc.get_id() != 'clang'
+    if is_windows and cc.get_id() == 'gcc'
         cflags += ['-fno-asynchronous-unwind-tables']
     endif
 
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0ae12dd5ff..3553b0ffe1 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -27,7 +27,7 @@ deps += ['hash', 'security']
 if arch_subdir == 'x86'
     sources += files('ixgbe_rxtx_vec_sse.c')
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
-    if is_windows and cc.get_id() != 'clang'
+    if is_windows and cc.get_id() == 'gcc'
         cflags += ['-fno-asynchronous-unwind-tables']
     endif
 elif arch_subdir == 'arm'
-- 
2.48.1.vfs.0.1

