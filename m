Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC4C021BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3FF240616;
	Wed, 26 Feb 2025 02:07:10 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1F101402B9
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:07:05 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4FCA62069413; Tue, 25 Feb 2025 17:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4FCA62069413
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740532024;
 bh=5dGFLE7ykqeooZAYGdv7nEhUWs/AyUqC9xbBPX/SJ0I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rWJijLXrukBX6x6xyllOvxE1BGRaiG38YBBqjLVIGxhawz3ziq6C1g5lQ84KMCknw
 gPnGhkkmWoi5BrWsPWqkv5c1zL+2COKIfkSiTWlXSZQYLJ72hNap09ROCF8IlsGEct
 VugPjSah2/IysHBhU6oyxzKCVFBC26GDKXe1SBVk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 4/5] drivers/net: make compatible with instruction set
 updates for MSVC
Date: Tue, 25 Feb 2025 17:06:55 -0800
Message-Id: <1740532016-6789-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
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

Top level 'cc_avx2_flags' was created and holds the correct flags
depending on the compiler used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/bnxt/meson.build       | 2 +-
 drivers/net/enic/meson.build       | 2 +-
 drivers/net/intel/i40e/meson.build | 2 +-
 drivers/net/intel/iavf/meson.build | 2 +-
 drivers/net/intel/ice/meson.build  | 2 +-
 drivers/net/intel/idpf/meson.build | 2 +-
 drivers/net/nfp/meson.build        | 2 +-
 drivers/net/octeon_ep/meson.build  | 4 ++--
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index e26cf13a65..fd82d0c409 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -65,7 +65,7 @@ if arch_subdir == 'x86'
                 static_rte_bus_pci,
                 static_rte_kvargs, static_rte_hash],
             include_directories: includes,
-            c_args: [cflags, '-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
      objs += bnxt_avx2_lib.extract_objects('bnxt_rxtx_vec_avx2.c')
 elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('bnxt_rxtx_vec_neon.c')
diff --git a/drivers/net/enic/meson.build b/drivers/net/enic/meson.build
index 1e26338350..cfe5ec170a 100644
--- a/drivers/net/enic/meson.build
+++ b/drivers/net/enic/meson.build
@@ -38,7 +38,7 @@ if dpdk_conf.has('RTE_ARCH_X86_64')
             'enic_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_bus_pci],
             include_directories: includes,
-            c_args: [cflags, '-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += enic_avx2_lib.extract_objects('enic_rxtx_vec_avx2.c')
 endif
 
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index ffa40c5d64..2973ed1a01 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -49,7 +49,7 @@ if arch_subdir == 'x86'
             'i40e_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
             include_directories: includes,
-            c_args: [cflags, '-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += i40e_avx2_lib.extract_objects('i40e_rxtx_vec_avx2.c')
 
     if cc_has_avx512
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 19cd1cfbc8..f7eac7c57a 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -37,7 +37,7 @@ if arch_subdir == 'x86'
             'iavf_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev],
             include_directories: includes,
-            c_args: [cflags, '-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += iavf_avx2_lib.extract_objects('iavf_rxtx_vec_avx2.c')
 
     if cc_has_avx512
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index a34b7c966a..cbdf38c1c4 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -43,7 +43,7 @@ if arch_subdir == 'x86'
             'ice_rxtx_vec_avx2.c',
             dependencies: [static_rte_ethdev, static_rte_hash],
             include_directories: includes,
-            c_args: [cflags, '-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += ice_avx2_lib.extract_objects('ice_rxtx_vec_avx2.c')
 
     if cc_has_avx512
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 802b13035b..4b272d02b1 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -23,7 +23,7 @@ if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
         'idpf_common_rxtx_avx2.c',
         dependencies: [static_rte_ethdev, static_rte_hash],
         include_directories: includes,
-        c_args: [cflags, '-mavx2'])
+        c_args: [cflags, cc_avx2_flags])
     objs += idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
 
     if cc_has_avx512
diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build
index 39762bd45a..0a12b7dce7 100644
--- a/drivers/net/nfp/meson.build
+++ b/drivers/net/nfp/meson.build
@@ -61,7 +61,7 @@ if arch_subdir == 'x86'
                 avx2_sources,
                 dependencies: [static_rte_ethdev, static_rte_bus_pci],
                 include_directories: includes,
-                c_args: [cflags, '-mavx2']
+                c_args: [cflags, cc_avx2_flags]
         )
 
         objs += nfp_avx2_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/meson.build
index d5d40b23a1..1b34db3edc 100644
--- a/drivers/net/octeon_ep/meson.build
+++ b/drivers/net/octeon_ep/meson.build
@@ -18,13 +18,13 @@ if arch_subdir == 'x86'
     if cc.get_define('__AVX2__', args: machine_args) != ''
         cflags += ['-DCC_AVX2_SUPPORT']
         sources += files('cnxk_ep_rx_avx.c')
-    elif cc.has_argument('-mavx2')
+    elif cc.has_multi_arguments(cc_avx2_flags)
         cflags += ['-DCC_AVX2_SUPPORT']
         otx_ep_avx2_lib = static_library('otx_ep_avx2_lib',
                         'cnxk_ep_rx_avx.c',
                         dependencies: [static_rte_ethdev, static_rte_pci, static_rte_bus_pci],
                         include_directories: includes,
-                        c_args: [cflags, '-mavx2'])
+                        c_args: [cflags, cc_avx2_flags])
         objs += otx_ep_avx2_lib.extract_objects('cnxk_ep_rx_avx.c')
     endif
 endif
-- 
2.48.1.vfs.0.0

