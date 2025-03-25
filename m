Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E6C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E8A40649;
	Tue, 25 Mar 2025 17:03:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1A74040649
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918597; x=1774454597;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tBaPNSV/VfRxFsaUwjJyqZwpJX3jANMalW9ZuC2Y8H0=;
 b=mNnPgkVoDljYZHDRYrPQBtBTrR6O/YEKkrdmdbLcUrYjHiholIARM01/
 YcGz5GKGTKJ+MRmCqWz+fB27fmnfywIkmjPZw6Cimf7vuG6xUN0J0+NRS
 BDSOXgYBHx26wkno/JTDkfyJGU3hxVKf9cXKVh1EkGGCJLHdpYWrBvBTx
 LQKKMPWQilypkIohjAQUctfOYg/GfvOmxxqpOVEk1HhekrKSqyjLCVI2k
 BqbnLGG4g6D94jyJxlB7t55zhbfMhf0mB5+fCtXWoWslUgtcZwLeGSWDH
 nk2rHYD1J2jvmaYzjXejwp6oS8gep8vjYHiwfKb2I33I1kYyDMGsrJ/qT g==;
X-CSE-ConnectionGUID: svr4J6MqTUeENM/O6sxbWw==
X-CSE-MsgGUID: x1YuoLl8QwerlG2gQpSWIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565723"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565723"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:16 -0700
X-CSE-ConnectionGUID: KdRF4Y4WQ3yc9dnTaYZGDw==
X-CSE-MsgGUID: wYwaOTyAQqGgRrkHLkCjdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086633"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v5 03/11] drivers/net: build use common AVX handling
Date: Tue, 25 Mar 2025 16:02:45 +0000
Message-ID: <20250325160254.1724560-4-bruce.richardson@intel.com>
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

Remove from remaining net drivers the special-case code to handle AVX2
or AVX512 specific files. These can be built instead using
drivers/meson.build.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/bnxt/meson.build      | 10 +---------
 drivers/net/enic/meson.build      | 10 +---------
 drivers/net/nfp/meson.build       | 10 +---------
 drivers/net/octeon_ep/meson.build | 14 ++------------
 drivers/net/virtio/meson.build    |  9 +--------
 5 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index fd82d0c409..dcca7df916 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -58,15 +58,7 @@ subdir('hcapi/cfa_v3')
 
 if arch_subdir == 'x86'
     sources += files('bnxt_rxtx_vec_sse.c')
-    # build AVX2 code with instruction set explicitly enabled for runtime selection
-    bnxt_avx2_lib = static_library('bnxt_avx2_lib',
-            'bnxt_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev,
-                static_rte_bus_pci,
-                static_rte_kvargs, static_rte_hash],
-            include_directories: includes,
-            c_args: [cflags, cc_avx2_flags])
-     objs += bnxt_avx2_lib.extract_objects('bnxt_rxtx_vec_avx2.c')
+    sources_avx2 = files('bnxt_rxtx_vec_avx2.c')
 elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('bnxt_rxtx_vec_neon.c')
 endif
diff --git a/drivers/net/enic/meson.build b/drivers/net/enic/meson.build
index cfe5ec170a..2b3052fae8 100644
--- a/drivers/net/enic/meson.build
+++ b/drivers/net/enic/meson.build
@@ -29,17 +29,9 @@ sources = files(
 deps += ['hash']
 includes += include_directories('base')
 
-# Build the avx2 handler for 64-bit X86 targets, even though 'machine'
-# may not. This is to support users who build for the min supported machine
-# and need to run the binary on newer CPUs too.
 if dpdk_conf.has('RTE_ARCH_X86_64')
     cflags += '-DENIC_RXTX_VEC'
-    enic_avx2_lib = static_library('enic_avx2_lib',
-            'enic_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev, static_rte_bus_pci],
-            include_directories: includes,
-            c_args: [cflags, cc_avx2_flags])
-    objs += enic_avx2_lib.extract_objects('enic_rxtx_vec_avx2.c')
+    sources_avx2 = files('enic_rxtx_vec_avx2.c')
 endif
 
 annotate_locks = false
diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build
index 0a12b7dce7..a98b584042 100644
--- a/drivers/net/nfp/meson.build
+++ b/drivers/net/nfp/meson.build
@@ -52,19 +52,11 @@ cflags += no_wvla_cflag
 if arch_subdir == 'x86'
         includes += include_directories('../../common/nfp')
 
-        avx2_sources = files(
+        sources_avx2 = files(
                 'nfdk/nfp_nfdk_vec_avx2_dp.c',
                 'nfp_rxtx_vec_avx2.c',
         )
 
-        nfp_avx2_lib = static_library('nfp_avx2_lib',
-                avx2_sources,
-                dependencies: [static_rte_ethdev, static_rte_bus_pci],
-                include_directories: includes,
-                c_args: [cflags, cc_avx2_flags]
-        )
-
-        objs += nfp_avx2_lib.extract_all_objects(recursive: true)
 else
         sources += files(
                 'nfp_rxtx_vec_stub.c',
diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/meson.build
index 1b34db3edc..9bf4627894 100644
--- a/drivers/net/octeon_ep/meson.build
+++ b/drivers/net/octeon_ep/meson.build
@@ -15,18 +15,8 @@ sources = files(
 
 if arch_subdir == 'x86'
     sources += files('cnxk_ep_rx_sse.c')
-    if cc.get_define('__AVX2__', args: machine_args) != ''
-        cflags += ['-DCC_AVX2_SUPPORT']
-        sources += files('cnxk_ep_rx_avx.c')
-    elif cc.has_multi_arguments(cc_avx2_flags)
-        cflags += ['-DCC_AVX2_SUPPORT']
-        otx_ep_avx2_lib = static_library('otx_ep_avx2_lib',
-                        'cnxk_ep_rx_avx.c',
-                        dependencies: [static_rte_ethdev, static_rte_pci, static_rte_bus_pci],
-                        include_directories: includes,
-                        c_args: [cflags, cc_avx2_flags])
-        objs += otx_ep_avx2_lib.extract_objects('cnxk_ep_rx_avx.c')
-    endif
+    cflags += ['-DCC_AVX2_SUPPORT']
+    sources_avx2 = files('cnxk_ep_rx_avx.c')
 endif
 
 if arch_subdir == 'arm'
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index c1c4a85bea..01bfb3c47d 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -27,15 +27,8 @@ cflags += no_wvla_cflag
 
 if arch_subdir == 'x86'
     if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
         cflags += ['-DVIRTIO_RXTX_PACKED_VEC']
-        virtio_avx512_lib = static_library('virtio_avx512_lib',
-                'virtio_rxtx_packed.c',
-                dependencies: [static_rte_ethdev,
-                    static_rte_kvargs, static_rte_bus_pci],
-                include_directories: includes,
-                c_args: cflags + cc_avx512_flags)
-        objs += virtio_avx512_lib.extract_objects('virtio_rxtx_packed.c')
+        sources_avx512 = files('virtio_rxtx_packed.c')
         if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
             cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
         elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
-- 
2.45.2

