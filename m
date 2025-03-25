Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11845C3600B
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 469F7402E5;
	Tue, 25 Mar 2025 17:03:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 45CF1402E5
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918593; x=1774454593;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3cjk4iW/jaDAcaXHyPr6Ol9mAzz3DuEKCEBkWGTZ3+g=;
 b=QQ1RqQbcuKcJIEXYME/dCd5Y9Dt6zY+9QLdHbXyfY1TM9rIuXBYbbmql
 PDdzkrIIHZ56nrEuklajU2w5tAjbcyX9XezwcAu9yWBvbZXyX0aJbUAdE
 hoa6+pZ9YdorSLUXF2oK7sp1PbxY+8a4QFnIP3/DGY27TerbfFuK+JbQA
 yNvreFWv4fVPNR3INmWkl12taciK90hAbjU4EbnBf6rT14f+vB9ziT1I3
 vLhFcK/8QfzDun2VbH9jrHZzNQwhH7dLX3WzM4V//7SEywJfvjQPbDPRK
 vEmlozNsl9zbkMRxs1mGTdR8zLGTTyXzTmXQEJFjPq5AmGDruHcjRNRX1 A==;
X-CSE-ConnectionGUID: DZyLtqXDTzGhMC7TE5cN8A==
X-CSE-MsgGUID: M+ejsE+3SOuHIwBQ0K/4kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565704"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565704"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:12 -0700
X-CSE-ConnectionGUID: Mhr/ZutNQEOppdSs+/XutQ==
X-CSE-MsgGUID: PrgmLwQCS96k4qSHvdSYwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086604"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 02/11] net/intel: use common AVX build code
Date: Tue, 25 Mar 2025 16:02:44 +0000
Message-ID: <20250325160254.1724560-3-bruce.richardson@intel.com>
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
2.45.2

