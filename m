Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B7C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 21:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9797A4069F;
	Wed, 26 Feb 2025 22:21:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D432A40648
 for <dev@dpdk.org>; Wed, 26 Feb 2025 22:21:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0FB79210C321; Wed, 26 Feb 2025 13:21:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FB79210C321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740604872;
 bh=rkhZl9Pq/9Y4yhfZszlTGwJZtG21OnDiqyT9mEG7Aos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gu67pCLfQp0GYPGjXlyU15m2reTGjf0ULXxpOdq+jAGv/3uYvgMtMLVRzHmBh1SLk
 ZV4NhOtH0zrK405uVEFVqFE36QqZnb/boRpKMWt1eos7pOetrWJAzB2g/NtViCvvYg
 Q9natDXs1cj2oeWtKaCxxEbToC9ZEJwsEaDN9dlQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 3/3] config: create top level variable cc_avx2_flags
Date: Wed, 26 Feb 2025 13:21:06 -0800
Message-Id: <1740604866-6184-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
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

Top level variable cc_avx2_flags was created and set according to the
compiler used. It is used in lower level directories like drivers/net
and lib/acl.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 config/x86/meson.build             | 6 ++++++
 drivers/net/bnxt/meson.build       | 2 +-
 drivers/net/enic/meson.build       | 2 +-
 drivers/net/intel/i40e/meson.build | 2 +-
 drivers/net/intel/iavf/meson.build | 2 +-
 drivers/net/intel/ice/meson.build  | 2 +-
 drivers/net/intel/idpf/meson.build | 2 +-
 drivers/net/nfp/meson.build        | 2 +-
 drivers/net/octeon_ep/meson.build  | 4 ++--
 lib/acl/meson.build                | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..941d4d921f 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2020 Intel Corporation
 
+if is_ms_compiler
+    cc_avx2_flags = ['/arch:AVX2']
+else
+    cc_avx2_flags = ['-mavx2']
+endif
+
 # get binutils version for the workaround of Bug 97
 binutils_ok = true
 if is_linux or cc.get_id() == 'gcc'
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
diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index fefe131a48..a28d70c23f 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
     avx2_tmplib = static_library('avx2_tmp',
             'acl_run_avx2.c',
             dependencies: static_rte_eal,
-            c_args: cflags + ['-mavx2'])
+            c_args: [cflags, cc_avx2_flags])
     objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
 
     # compile AVX512 version if:
-- 
2.48.1.vfs.0.0

