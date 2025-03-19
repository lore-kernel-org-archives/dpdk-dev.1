Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42854C36000
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC0EC4064A;
	Wed, 19 Mar 2025 18:30:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 30A8440608
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405411; x=1773941411;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kpvfJ/mD+Vg5S8jNJl8nCAtqyh7Bv21b/M/Tbq2UoME=;
 b=mJYcNVtiYw8GE+ddKXzb5dq7vRQOo8YRoNnuav3BOGxF/yb8iplq3Db1
 2y4ARM8iLn72xiOL3Ah0AOpWPRcrjFoih7cx/C2Ig/UVq2xtqZAhu0CTe
 4Pla2svBk7qKiQhb52VlYU3XcrMcjryJURK+OomAS2llXgWatjr6wjjXO
 xANNdT1N1s9a+OxCn9cADVDTI1bWITCqyLwORxW9rnr+8TBgL8MdG0F6k
 c+SeB7U1TrBVNDr823+wTGNSn32YdXl9uefSyvvP3l9DGEl9KdNiB/Wc3
 5t6rLaPL7141kPgy5Mj8XzwLtb+dm3GPsrD9aAxvk5u1oC2bum7l3meGW Q==;
X-CSE-ConnectionGUID: JW5B9iQzT9uO1pfpIycYMA==
X-CSE-MsgGUID: mXyHHqjrQiS28wFEy6daTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43741963"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43741963"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:10 -0700
X-CSE-ConnectionGUID: 78q1Yp73QTKe9xPAvVv1lQ==
X-CSE-MsgGUID: 5v9mAOpSSQKiXxwLeVP2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722491"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v4 02/11] net/intel: use common AVX build code
Date: Wed, 19 Mar 2025 17:29:32 +0000
Message-ID: <20250319172942.2992053-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319172942.2992053-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
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

Remove driver-specific build instructions for the AVX2 and AVX-512 code,
and rely instead on the generic driver build file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/meson.build | 26 ++------------------------
 drivers/net/intel/iavf/meson.build | 25 ++-----------------------
 drivers/net/intel/ice/meson.build  | 25 ++-----------------------
 drivers/net/intel/idpf/meson.build | 25 ++-----------------------
 4 files changed, 8 insertions(+), 93 deletions(-)

diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 15993393fb..dae61222cf 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -40,31 +40,9 @@ includes += include_directories('base')
 
 if arch_subdir == 'x86'
     sources += files('i40e_rxtx_vec_sse.c')
+    sources_avx2 += files('i40e_rxtx_vec_avx2.c')
+    sources_avx512 += files('i40e_rxtx_vec_avx512.c')
 
-    i40e_avx2_lib = static_library('i40e_avx2_lib',
-            'i40e_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
-            include_directories: includes,
-            c_args: [cflags, cc_avx2_flags])
-    objs += i40e_avx2_lib.extract_objects('i40e_rxtx_vec_avx2.c')
-
-    if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
-        avx512_args = cflags + cc_avx512_flags
-        if cc.has_argument('-march=skylake-avx512')
-            avx512_args += '-march=skylake-avx512'
-            if cc.has_argument('-Wno-overriding-option')
-                avx512_args += '-Wno-overriding-option'
-            endif
-        endif
-        i40e_avx512_lib = static_library('i40e_avx512_lib',
-                'i40e_rxtx_vec_avx512.c',
-                dependencies: [static_rte_ethdev,
-                    static_rte_kvargs, static_rte_hash],
-                include_directories: includes,
-                c_args: avx512_args)
-        objs += i40e_avx512_lib.extract_objects('i40e_rxtx_vec_avx512.c')
-    endif
 elif arch_subdir == 'ppc'
        sources += files('i40e_rxtx_vec_altivec.c')
 elif arch_subdir == 'arm'
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 833a63e6c8..1ca500c43c 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -28,30 +28,9 @@ includes += include_directories('base')
 
 if arch_subdir == 'x86'
     sources += files('iavf_rxtx_vec_sse.c')
+    sources_avx2 += files('iavf_rxtx_vec_avx2.c')
+    sources_avx512 += files('iavf_rxtx_vec_avx512.c')
 
-    iavf_avx2_lib = static_library('iavf_avx2_lib',
-            'iavf_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev],
-            include_directories: includes,
-            c_args: [cflags, cc_avx2_flags])
-    objs += iavf_avx2_lib.extract_objects('iavf_rxtx_vec_avx2.c')
-
-    if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
-        avx512_args = cflags + cc_avx512_flags
-        if cc.has_argument('-march=skylake-avx512')
-            avx512_args += '-march=skylake-avx512'
-            if cc.has_argument('-Wno-overriding-option')
-                avx512_args += '-Wno-overriding-option'
-            endif
-        endif
-        iavf_avx512_lib = static_library('iavf_avx512_lib',
-                'iavf_rxtx_vec_avx512.c',
-                dependencies: [static_rte_ethdev],
-                include_directories: includes,
-                c_args: avx512_args)
-        objs += iavf_avx512_lib.extract_objects('iavf_rxtx_vec_avx512.c')
-    endif
 elif arch_subdir == 'arm'
     sources += files('iavf_rxtx_vec_neon.c')
 endif
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 4d8f71cd4a..fa6c505450 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -34,30 +34,9 @@ endif
 
 if arch_subdir == 'x86'
     sources += files('ice_rxtx_vec_sse.c')
+    sources_avx2 += files('ice_rxtx_vec_avx2.c')
+    sources_avx512 += files('ice_rxtx_vec_avx512.c')
 
-    ice_avx2_lib = static_library('ice_avx2_lib',
-            'ice_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev, static_rte_hash],
-            include_directories: includes,
-            c_args: [cflags, cc_avx2_flags])
-    objs += ice_avx2_lib.extract_objects('ice_rxtx_vec_avx2.c')
-
-    if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
-        avx512_args = cflags + cc_avx512_flags
-        if cc.has_argument('-march=skylake-avx512')
-            avx512_args += '-march=skylake-avx512'
-            if cc.has_argument('-Wno-overriding-option')
-                avx512_args += '-Wno-overriding-option'
-            endif
-        endif
-        ice_avx512_lib = static_library('ice_avx512_lib',
-                'ice_rxtx_vec_avx512.c',
-                dependencies: [static_rte_ethdev, static_rte_hash],
-                include_directories: includes,
-                c_args: avx512_args)
-        objs += ice_avx512_lib.extract_objects('ice_rxtx_vec_avx512.c')
-    endif
 endif
 
 sources += files(
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 4b272d02b1..f579ffae46 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -19,29 +19,8 @@ sources = files(
 )
 
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
-    idpf_avx2_lib = static_library('idpf_avx2_lib',
-        'idpf_common_rxtx_avx2.c',
-        dependencies: [static_rte_ethdev, static_rte_hash],
-        include_directories: includes,
-        c_args: [cflags, cc_avx2_flags])
-    objs += idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
-
-    if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
-        avx512_args = cflags + cc_avx512_flags
-        if cc.has_argument('-march=skylake-avx512')
-            avx512_args += '-march=skylake-avx512'
-            if cc.has_argument('-Wno-overriding-option')
-                avx512_args += '-Wno-overriding-option'
-            endif
-        endif
-        idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
-                'idpf_common_rxtx_avx512.c',
-                dependencies: static_rte_mbuf,
-                include_directories: includes,
-                c_args: avx512_args)
-        objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
-    endif
+    sources_avx2 += files('idpf_common_rxtx_avx2.c')
+    sources_avx512 += files('idpf_common_rxtx_avx512.c')
 endif
 
 subdir('base')
-- 
2.43.0

