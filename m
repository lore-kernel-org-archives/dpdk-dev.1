Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F3ED116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1408040E16;
	Mon,  1 Dec 2025 12:45:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E286A40DF5
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589533; x=1796125533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WTGWDaNm6+q6EhSdqnzba3uV3WpFjF0QCroXlS0ZY44=;
 b=iP3q1RWjOQ5NSruHFmKWQCd/53ZhLWYlhkCpco8Are5EaawDuEIZ7l+Z
 yDzFW5Did02aRgShhj3LDodM2fnZRbbQBxARpiJRwLWhuSwWbzoHLH+Am
 tam4YTuKFHU+Xaf4auvOL4ebHSO1lnBqmX5+Xr96vMndCEzNYvSh5w1zG
 uhQqN5Woqw3ChWSANVwzS+MQ87T4Dl5saBp17nXQyv69vnrkBGgIT+zb5
 xx+j3SXQIHAPEqXkAjjCag0eSjI2GuLsM+fndX4NMrOPsk5Y5Jkift7mg
 OLuANrl4xHasvQVS/ozemJfOtdUS1KSuYyIloYphVaGOm/TEWMNC2S81w w==;
X-CSE-ConnectionGUID: udhrRoL8QWOj0o35MyrE8A==
X-CSE-MsgGUID: LNues5deSKGeGaXA9QyRHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991775"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991775"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:33 -0800
X-CSE-ConnectionGUID: mRIQdLZ5R3mZmfkp+cTHvg==
X-CSE-MsgGUID: WcojA677RnulsrpNB6z4Ng==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 28/31] drivers: disable variable shadowing warnings for
 drivers
Date: Mon,  1 Dec 2025 11:44:45 +0000
Message-ID: <20251201114448.1441377-29-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

Not all drivers build cleanly with shadow warnings enabled, so disable
them on a driver-by-driver basis for now.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build                         | 5 +++++
 drivers/baseband/fpga_5gnr_fec/meson.build | 2 ++
 drivers/bus/fslmc/meson.build              | 2 ++
 drivers/common/cnxk/meson.build            | 1 +
 drivers/common/qat/meson.build             | 1 +
 drivers/compress/nitrox/meson.build        | 2 ++
 drivers/crypto/cnxk/meson.build            | 1 +
 drivers/crypto/octeontx/meson.build        | 1 +
 drivers/crypto/openssl/meson.build         | 1 +
 drivers/crypto/scheduler/meson.build       | 1 +
 drivers/dma/dpaa2/meson.build              | 2 ++
 drivers/event/cnxk/meson.build             | 1 +
 drivers/event/dlb2/meson.build             | 2 ++
 drivers/event/sw/meson.build               | 1 +
 drivers/net/axgbe/meson.build              | 2 +-
 drivers/net/bnxt/meson.build               | 1 +
 drivers/net/bonding/meson.build            | 1 +
 drivers/net/cnxk/meson.build               | 1 +
 drivers/net/cxgbe/meson.build              | 1 +
 drivers/net/dpaa/meson.build               | 1 +
 drivers/net/dpaa2/meson.build              | 1 +
 drivers/net/ena/meson.build                | 2 ++
 drivers/net/enetfec/meson.build            | 2 ++
 drivers/net/enic/meson.build               | 2 ++
 drivers/net/failsafe/meson.build           | 1 +
 drivers/net/mlx5/meson.build               | 1 +
 drivers/net/ntnic/meson.build              | 3 +++
 drivers/net/pfe/meson.build                | 3 +++
 drivers/net/qede/meson.build               | 3 +++
 drivers/net/txgbe/meson.build              | 1 +
 drivers/net/zxdh/meson.build               | 3 +++
 drivers/raw/ifpga/meson.build              | 2 ++
 drivers/vdpa/mlx5/meson.build              | 1 +
 33 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index 0cb074ab95..927dc18d21 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -361,6 +361,11 @@ if cc.has_argument('-Wvla')
     endif
 endif
 
+no_shadow_cflag = []
+if cc.has_argument('-Wno-shadow')
+        no_shadow_cflag = '-Wno-shadow'
+endif
+
 foreach arg: global_cflags
     if cc.has_argument(arg)
         add_project_arguments(arg, language: 'c')
diff --git a/drivers/baseband/fpga_5gnr_fec/meson.build b/drivers/baseband/fpga_5gnr_fec/meson.build
index c3678d23eb..d81070aecd 100644
--- a/drivers/baseband/fpga_5gnr_fec/meson.build
+++ b/drivers/baseband/fpga_5gnr_fec/meson.build
@@ -3,6 +3,8 @@
 
 deps += ['bus_vdev', 'ring', 'pci', 'bus_pci']
 
+cflags += no_shadow_cflag
+
 sources = files('rte_fpga_5gnr_fec.c')
 
 headers = files('rte_pmd_fpga_5gnr_fec.h')
diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index 70098ad778..ceae1c6c11 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -6,6 +6,8 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
+cflags += no_shadow_cflag
+
 deps += ['common_dpaax', 'eventdev', 'kvargs']
 sources = files(
         'fslmc_bus.c',
diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index daffc15afd..2b33022eb7 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -95,6 +95,7 @@ sources += files('cnxk_telemetry_bphy.c',
 )
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 if meson.is_cross_build()
     soc_type = meson.get_external_property('platform', '')
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index 68290ef152..31e06f4376 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -104,6 +104,7 @@ if qat_compress
 endif
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 if qat_crypto
     foreach f: ['qat_sym.c', 'qat_sym_session.c',
diff --git a/drivers/compress/nitrox/meson.build b/drivers/compress/nitrox/meson.build
index 5cecc2ad66..d48b19feb0 100644
--- a/drivers/compress/nitrox/meson.build
+++ b/drivers/compress/nitrox/meson.build
@@ -8,6 +8,8 @@ endif
 
 deps += ['common_nitrox', 'bus_pci', 'compressdev']
 
+cflags += no_shadow_cflag
+
 sources += files(
         'nitrox_comp.c',
         'nitrox_comp_reqmgr.c',
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index 912c4a0851..922c425855 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -34,6 +34,7 @@ deps += ['bus_pci', 'common_cnxk', 'security', 'eventdev']
 includes += include_directories('../../../lib/net', '../../event/cnxk')
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 if get_option('buildtype').contains('debug')
     cflags += [ '-DLA_IPSEC_DEBUG','-DCNXK_CRYPTODEV_DEBUG' ]
diff --git a/drivers/crypto/octeontx/meson.build b/drivers/crypto/octeontx/meson.build
index ec26aa65e7..5e5e4b7fa2 100644
--- a/drivers/crypto/octeontx/meson.build
+++ b/drivers/crypto/octeontx/meson.build
@@ -34,3 +34,4 @@ includes += include_directories('../../mempool/octeontx')
 includes += include_directories('../../net/octeontx')
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/crypto/openssl/meson.build b/drivers/crypto/openssl/meson.build
index c56e4678bb..af469a9827 100644
--- a/drivers/crypto/openssl/meson.build
+++ b/drivers/crypto/openssl/meson.build
@@ -17,3 +17,4 @@ sources = files('rte_openssl_pmd.c', 'rte_openssl_pmd_ops.c')
 ext_deps += dep
 require_iova_in_mbuf = false
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/crypto/scheduler/meson.build b/drivers/crypto/scheduler/meson.build
index b7c47d18b5..68ca1fa08a 100644
--- a/drivers/crypto/scheduler/meson.build
+++ b/drivers/crypto/scheduler/meson.build
@@ -24,3 +24,4 @@ headers = files(
 )
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/dma/dpaa2/meson.build b/drivers/dma/dpaa2/meson.build
index a523f5edb4..6f9b427793 100644
--- a/drivers/dma/dpaa2/meson.build
+++ b/drivers/dma/dpaa2/meson.build
@@ -14,3 +14,5 @@ sources = files('dpaa2_qdma.c')
 if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
 endif
+
+cflags += no_shadow_cflag
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 677ebc9e28..24b48d045f 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -301,6 +301,7 @@ endif
 endif
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 extra_flags = ['-flax-vector-conversions', '-Wno-strict-aliasing']
 if cc.get_id() == 'clang'
diff --git a/drivers/event/dlb2/meson.build b/drivers/event/dlb2/meson.build
index 19d88afb5d..894d011fea 100644
--- a/drivers/event/dlb2/meson.build
+++ b/drivers/event/dlb2/meson.build
@@ -29,6 +29,8 @@ headers = files('rte_pmd_dlb2.h')
 
 deps += ['mbuf', 'mempool', 'ring', 'pci', 'bus_pci']
 
+cflags += no_shadow_cflag
+
 dlb_pmd_defines = ['-DDLB2_BYPASS_FENCE_ON_PP', '-DDLB_HW_CREDITS_CHECKS', '-DDLB_SW_CREDITS_CHECKS', '-DDLB_TYPE_CHECK']
 dlb_pmd_default = ['0','1','1','1']
 
diff --git a/drivers/event/sw/meson.build b/drivers/event/sw/meson.build
index c0c559ebc4..0cd324d97a 100644
--- a/drivers/event/sw/meson.build
+++ b/drivers/event/sw/meson.build
@@ -11,3 +11,4 @@ sources = files(
 deps += ['hash', 'bus_vdev']
 require_iova_in_mbuf = false
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/net/axgbe/meson.build b/drivers/net/axgbe/meson.build
index b1cbe3d810..5a14549317 100644
--- a/drivers/net/axgbe/meson.build
+++ b/drivers/net/axgbe/meson.build
@@ -15,7 +15,7 @@ sources = files(
         'axgbe_rxtx.c',
 )
 
-cflags += '-Wno-cast-qual'
+cflags += ['-Wno-cast-qual', no_shadow_cflag]
 
 if arch_subdir == 'x86'
     sources += files('axgbe_rxtx_vec_sse.c')
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index 79300eb6ac..dc122fb3df 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -13,6 +13,7 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
 endif
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 headers = files('rte_pmd_bnxt.h')
 cflags_options = [
diff --git a/drivers/net/bonding/meson.build b/drivers/net/bonding/meson.build
index d87e7a2522..14304b68a8 100644
--- a/drivers/net/bonding/meson.build
+++ b/drivers/net/bonding/meson.build
@@ -26,3 +26,4 @@ headers = files('rte_eth_bond.h', 'rte_eth_bond_8023ad.h')
 require_iova_in_mbuf = false
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index d20a8601eb..53caa6c171 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -328,6 +328,7 @@ deps += ['bus_pci', 'cryptodev', 'eventdev', 'security']
 deps += ['common_cnxk', 'mempool_cnxk']
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 # Allow implicit vector conversions and strict aliasing warning
 extra_flags = ['-flax-vector-conversions', '-Wno-strict-aliasing']
diff --git a/drivers/net/cxgbe/meson.build b/drivers/net/cxgbe/meson.build
index 95cb58ab44..0d5d886ed5 100644
--- a/drivers/net/cxgbe/meson.build
+++ b/drivers/net/cxgbe/meson.build
@@ -25,3 +25,4 @@ sources = files(
 includes += include_directories('base')
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/net/dpaa/meson.build b/drivers/net/dpaa/meson.build
index b1e4bbafb5..8d4f69c596 100644
--- a/drivers/net/dpaa/meson.build
+++ b/drivers/net/dpaa/meson.build
@@ -18,6 +18,7 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 89932b3037..4094ea02ba 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -29,3 +29,4 @@ includes += include_directories('base', 'mc')
 headers = files('rte_pmd_dpaa2.h')
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/drivers/net/ena/meson.build b/drivers/net/ena/meson.build
index d02ed3f64f..2b18d7add7 100644
--- a/drivers/net/ena/meson.build
+++ b/drivers/net/ena/meson.build
@@ -17,3 +17,5 @@ sources = files(
 deps += ['timer']
 
 includes += include_directories('base', 'base/ena_defs')
+
+cflags += no_shadow_cflag
diff --git a/drivers/net/enetfec/meson.build b/drivers/net/enetfec/meson.build
index 29a464424b..428133c2b6 100644
--- a/drivers/net/enetfec/meson.build
+++ b/drivers/net/enetfec/meson.build
@@ -11,3 +11,5 @@ sources = files(
         'enet_uio.c',
         'enet_rxtx.c',
 )
+
+cflags += no_shadow_cflag
diff --git a/drivers/net/enic/meson.build b/drivers/net/enic/meson.build
index a48a497e46..cb853beeaa 100644
--- a/drivers/net/enic/meson.build
+++ b/drivers/net/enic/meson.build
@@ -29,6 +29,8 @@ sources = files(
 deps += ['hash']
 includes += include_directories('base')
 
+cflags += no_shadow_cflag
+
 if dpdk_conf.has('RTE_ARCH_X86_64')
     cflags += '-DENIC_RXTX_VEC'
     sources_avx2 += files('enic_rxtx_vec_avx2.c')
diff --git a/drivers/net/failsafe/meson.build b/drivers/net/failsafe/meson.build
index 90c965b705..3c2c96b73a 100644
--- a/drivers/net/failsafe/meson.build
+++ b/drivers/net/failsafe/meson.build
@@ -8,6 +8,7 @@ if is_windows
 endif
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 cflags += '-D_DEFAULT_SOURCE'
 cflags += '-D_XOPEN_SOURCE=700'
 cflags += '-pedantic'
diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index d67fb0969f..28275bed21 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -90,6 +90,7 @@ if get_option('buildtype').contains('debug')
 else
     cflags += [ '-UPEDANTIC' ]
 endif
+cflags += no_shadow_cflag
 
 require_iova_in_mbuf = false
 
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 1daf7881f1..60688c8aaf 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -128,3 +128,6 @@ sources = files(
         'ntnic_ethdev.c',
         'rte_pmd_ntnic.c',
 )
+
+# Suppress shadow warnings for this driver due to extensive variable shadowing
+cflags += no_shadow_cflag
diff --git a/drivers/net/pfe/meson.build b/drivers/net/pfe/meson.build
index 684b062090..2d7dcb154a 100644
--- a/drivers/net/pfe/meson.build
+++ b/drivers/net/pfe/meson.build
@@ -18,4 +18,7 @@ if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
 endif
 
+# Suppress shadow warnings for this driver
+cflags += no_shadow_cflag
+
 includes += include_directories('base')
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5..7957aae3fa 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,6 @@ sources = files(
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
+
+# Suppress shadow warnings for this driver
+cflags += no_shadow_cflag
diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index 5cdec017ed..dea50bfe14 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -24,6 +24,7 @@ sources = files(
 deps += ['hash', 'security']
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 if arch_subdir == 'x86'
     sources += files('txgbe_rxtx_vec_sse.c')
diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
index 0213ccb2fa..9893616b19 100644
--- a/drivers/net/zxdh/meson.build
+++ b/drivers/net/zxdh/meson.build
@@ -20,3 +20,6 @@ sources = files(
         'zxdh_mtr.c',
         'zxdh_flow.c',
 )
+
+# Suppress shadow warnings for this driver
+cflags += no_shadow_cflag
diff --git a/drivers/raw/ifpga/meson.build b/drivers/raw/ifpga/meson.build
index 395894af2a..8d5f41fd5d 100644
--- a/drivers/raw/ifpga/meson.build
+++ b/drivers/raw/ifpga/meson.build
@@ -19,6 +19,8 @@ endif
 
 ext_deps += rtdep
 
+cflags += no_shadow_cflag
+
 subdir('base')
 
 deps += ['ethdev', 'rawdev', 'pci', 'bus_pci', 'kvargs',
diff --git a/drivers/vdpa/mlx5/meson.build b/drivers/vdpa/mlx5/meson.build
index 7be11fda6d..f61adf23a4 100644
--- a/drivers/vdpa/mlx5/meson.build
+++ b/drivers/vdpa/mlx5/meson.build
@@ -24,6 +24,7 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 cflags_options = [
         '-std=c11',
-- 
2.51.0

