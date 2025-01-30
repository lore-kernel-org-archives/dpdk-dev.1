Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E709C0218D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 21:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7636F410EE;
	Thu, 30 Jan 2025 22:56:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 833ED40275
 for <dev@dpdk.org>; Thu, 30 Jan 2025 22:55:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B90EE210C322; Thu, 30 Jan 2025 13:55:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B90EE210C322
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738274144;
 bh=gPlcWlI0MPZn/5Re9Vwy3LS8Rv+pXNEBDwfum72eNjE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PMyRlPFj8OPOMY09cO3mUQLE41MtDp93tufAKowu/UkWA5O4d8cVl17UtNu/ZCfmp
 VwLyPcArgA2m+8aq/xCttvESwwWwgfQ+6665V5C2/WTcQJe1YjLSSJNEgsxsBtZ7ox
 2J+ev2MxMzL6FGgvyeFDxpxY+pyCVWbbbICh4uX0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v18 23/26] drivers: add no_vla_cflag to directories that are
 not VLA-free
Date: Thu, 30 Jan 2025 13:55:32 -0800
Message-Id: <1738274135-2086-24-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
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

The no_vla_cflag is added to meson.build files in directories that
are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/cnxk/meson.build      | 2 ++
 drivers/common/mlx5/meson.build      | 2 ++
 drivers/common/qat/meson.build       | 2 ++
 drivers/crypto/ccp/meson.build       | 2 ++
 drivers/crypto/cnxk/meson.build      | 2 ++
 drivers/crypto/octeontx/meson.build  | 2 ++
 drivers/crypto/openssl/meson.build   | 1 +
 drivers/crypto/scheduler/meson.build | 2 ++
 drivers/dma/dpaa/meson.build         | 2 ++
 drivers/event/cnxk/meson.build       | 2 ++
 drivers/event/dsw/meson.build        | 1 +
 drivers/event/opdl/meson.build       | 1 +
 drivers/event/sw/meson.build         | 1 +
 drivers/net/af_xdp/meson.build       | 2 ++
 drivers/net/bnxt/meson.build         | 2 ++
 drivers/net/bonding/meson.build      | 2 ++
 drivers/net/cnxk/meson.build         | 2 ++
 drivers/net/cxgbe/meson.build        | 2 ++
 drivers/net/dpaa/meson.build         | 2 ++
 drivers/net/dpaa2/meson.build        | 2 ++
 drivers/net/failsafe/meson.build     | 1 +
 drivers/net/gve/meson.build          | 2 ++
 drivers/net/hns3/meson.build         | 2 ++
 drivers/net/mlx4/meson.build         | 2 ++
 drivers/net/mlx5/linux/meson.build   | 2 ++
 drivers/net/netvsc/meson.build       | 2 ++
 drivers/net/nfp/meson.build          | 2 ++
 drivers/net/ngbe/base/meson.build    | 1 +
 drivers/net/ntnic/meson.build        | 2 ++
 drivers/net/octeontx/meson.build     | 2 ++
 drivers/net/sfc/meson.build          | 1 +
 drivers/net/softnic/meson.build      | 1 +
 drivers/net/tap/meson.build          | 1 +
 drivers/net/txgbe/meson.build        | 2 ++
 drivers/net/vdev_netvsc/meson.build  | 2 ++
 drivers/net/virtio/meson.build       | 2 ++
 drivers/vdpa/mlx5/meson.build        | 3 +++
 37 files changed, 66 insertions(+)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 9e3fd44317..f685f94ee1 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -92,6 +92,8 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
+cflags += no_vla_cflag
+
 if meson.is_cross_build()
     soc_type = meson.get_external_property('platform', '')
 else
diff --git a/drivers/common/mlx5/meson.build b/drivers/common/mlx5/meson.build
index 1eefc02f06..c706db08ad 100644
--- a/drivers/common/mlx5/meson.build
+++ b/drivers/common/mlx5/meson.build
@@ -24,6 +24,8 @@ sources += files(
         'mlx5_common_utils.c',
 )
 
+cflags += no_vla_cflag
+
 cflags_options = [
         '-std=c11',
         '-Wno-strict-prototypes',
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.build
index 5a8de16fe0..75530610ef 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -103,6 +103,8 @@ if qat_compress
     endforeach
 endif
 
+cflags += no_vla_cflag
+
 if qat_crypto
     foreach f: ['qat_sym.c', 'qat_sym_session.c',
             'qat_asym.c', 'qat_crypto.c',
diff --git a/drivers/crypto/ccp/meson.build b/drivers/crypto/ccp/meson.build
index a9abaa4da0..45eedb2e92 100644
--- a/drivers/crypto/ccp/meson.build
+++ b/drivers/crypto/ccp/meson.build
@@ -22,3 +22,5 @@ sources = files(
 )
 
 ext_deps += dep
+
+cflags += no_vla_cflag
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index aa840fb7bb..2e483d786c 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -28,6 +28,8 @@ headers = files('rte_pmd_cnxk_crypto.h')
 deps += ['bus_pci', 'common_cnxk', 'security', 'eventdev']
 includes += include_directories('../../../lib/net', '../../event/cnxk')
 
+cflags += no_vla_cflag
+
 if get_option('buildtype').contains('debug')
     cflags += [ '-DLA_IPSEC_DEBUG','-DCNXK_CRYPTODEV_DEBUG' ]
 else
diff --git a/drivers/crypto/octeontx/meson.build b/drivers/crypto/octeontx/meson.build
index 387727c6ab..94689c1484 100644
--- a/drivers/crypto/octeontx/meson.build
+++ b/drivers/crypto/octeontx/meson.build
@@ -32,3 +32,5 @@ includes += include_directories('../../common/octeontx')
 includes += include_directories('../../event/octeontx')
 includes += include_directories('../../mempool/octeontx')
 includes += include_directories('../../net/octeontx')
+
+cflags += no_vla_cflag
diff --git a/drivers/crypto/openssl/meson.build b/drivers/crypto/openssl/meson.build
index 1ec63c216d..02716e1674 100644
--- a/drivers/crypto/openssl/meson.build
+++ b/drivers/crypto/openssl/meson.build
@@ -16,3 +16,4 @@ deps += 'bus_vdev'
 sources = files('rte_openssl_pmd.c', 'rte_openssl_pmd_ops.c')
 ext_deps += dep
 require_iova_in_mbuf = false
+cflags += no_vla_cflag
diff --git a/drivers/crypto/scheduler/meson.build b/drivers/crypto/scheduler/meson.build
index 752d655415..d443e2a2ab 100644
--- a/drivers/crypto/scheduler/meson.build
+++ b/drivers/crypto/scheduler/meson.build
@@ -22,3 +22,5 @@ headers = files(
         'rte_cryptodev_scheduler.h',
         'rte_cryptodev_scheduler_operations.h',
 )
+
+cflags += no_vla_cflag
diff --git a/drivers/dma/dpaa/meson.build b/drivers/dma/dpaa/meson.build
index c31a6d91fe..1eade2bb35 100644
--- a/drivers/dma/dpaa/meson.build
+++ b/drivers/dma/dpaa/meson.build
@@ -9,6 +9,8 @@ endif
 deps += ['dmadev', 'bus_dpaa']
 sources = files('dpaa_qdma.c')
 
+cflags += no_vla_cflag
+
 if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
 endif
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 8aaf8116f7..e4d024edc9 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -299,6 +299,8 @@ sources += files(
 endif
 endif
 
+cflags += no_vla_cflag
+
 extra_flags = ['-flax-vector-conversions', '-Wno-strict-aliasing']
 if cc.get_id() == 'clang'
         extra_flags += ['-Wno-asm-operand-widths']
diff --git a/drivers/event/dsw/meson.build b/drivers/event/dsw/meson.build
index 01af94165f..2a7f0d9496 100644
--- a/drivers/event/dsw/meson.build
+++ b/drivers/event/dsw/meson.build
@@ -2,6 +2,7 @@
 # Copyright(c) 2018 Ericsson AB
 
 deps += ['bus_vdev']
+cflags += no_vla_cflag
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
diff --git a/drivers/event/opdl/meson.build b/drivers/event/opdl/meson.build
index 8613b2a746..d79006d9ad 100644
--- a/drivers/event/opdl/meson.build
+++ b/drivers/event/opdl/meson.build
@@ -10,3 +10,4 @@ sources = files(
 )
 deps += ['bus_vdev']
 require_iova_in_mbuf = false
+cflags += no_vla_cflag
diff --git a/drivers/event/sw/meson.build b/drivers/event/sw/meson.build
index 3a3ebd72a3..019f2069fd 100644
--- a/drivers/event/sw/meson.build
+++ b/drivers/event/sw/meson.build
@@ -10,3 +10,4 @@ sources = files(
 )
 deps += ['hash', 'bus_vdev']
 require_iova_in_mbuf = false
+cflags += no_vla_cflag
diff --git a/drivers/net/af_xdp/meson.build b/drivers/net/af_xdp/meson.build
index 69d109ff46..c641ed3730 100644
--- a/drivers/net/af_xdp/meson.build
+++ b/drivers/net/af_xdp/meson.build
@@ -22,6 +22,8 @@ if not bpf_dep.found()
     bpf_dep = cc.find_library('bpf', required: false)
 endif
 
+cflags += no_vla_cflag
+
 if cc.has_header('linux/if_xdp.h')
     if xdp_dep.found() and cc.has_header('xdp/xsk.h')
         cflags += ['-DRTE_NET_AF_XDP_LIBXDP']
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index 575f4c2add..a01b363010 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -12,6 +12,8 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
     subdir_done()
 endif
 
+cflags += no_vla_cflag
+
 headers = files('rte_pmd_bnxt.h')
 cflags_options = [
         '-DSUPPORT_CFA_HW_P70=1',
diff --git a/drivers/net/bonding/meson.build b/drivers/net/bonding/meson.build
index 87c567b149..4433376358 100644
--- a/drivers/net/bonding/meson.build
+++ b/drivers/net/bonding/meson.build
@@ -24,3 +24,5 @@ deps += ['ip_frag']
 headers = files('rte_eth_bond.h', 'rte_eth_bond_8023ad.h')
 
 require_iova_in_mbuf = false
+
+cflags += no_vla_cflag
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index 32ff8aadc0..f928926691 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -324,6 +324,8 @@ endif
 deps += ['bus_pci', 'cryptodev', 'eventdev', 'security']
 deps += ['common_cnxk', 'mempool_cnxk']
 
+cflags += no_vla_cflag
+
 # Allow implicit vector conversions and strict aliasing warning
 extra_flags = ['-flax-vector-conversions', '-Wno-strict-aliasing']
 if cc.get_id() == 'clang'
diff --git a/drivers/net/cxgbe/meson.build b/drivers/net/cxgbe/meson.build
index 6ed32774c9..0fa66b6eaa 100644
--- a/drivers/net/cxgbe/meson.build
+++ b/drivers/net/cxgbe/meson.build
@@ -23,3 +23,5 @@ sources = files(
         'base/t4vf_hw.c',
 )
 includes += include_directories('base')
+
+cflags += no_vla_cflag
diff --git a/drivers/net/dpaa/meson.build b/drivers/net/dpaa/meson.build
index 239858adda..6053efe607 100644
--- a/drivers/net/dpaa/meson.build
+++ b/drivers/net/dpaa/meson.build
@@ -17,6 +17,8 @@ sources = files(
         'dpaa_ptp.c',
 )
 
+cflags += no_vla_cflag
+
 if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
 endif
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 51598c048c..e8f55c6162 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -27,3 +27,5 @@ sources = files(
 includes += include_directories('base', 'mc')
 
 headers = files('rte_pmd_dpaa2.h')
+
+cflags += no_vla_cflag
diff --git a/drivers/net/failsafe/meson.build b/drivers/net/failsafe/meson.build
index c1d361083b..f1a684dd05 100644
--- a/drivers/net/failsafe/meson.build
+++ b/drivers/net/failsafe/meson.build
@@ -7,6 +7,7 @@ if is_windows
     subdir_done()
 endif
 
+cflags += no_vla_cflag
 cflags += '-D_DEFAULT_SOURCE'
 cflags += '-D_XOPEN_SOURCE=700'
 cflags += '-pedantic'
diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index 6da13a8406..853735904f 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -18,3 +18,5 @@ sources = files(
         'gve_rss.c',
 )
 includes += include_directories('base')
+
+cflags += no_vla_cflag
diff --git a/drivers/net/hns3/meson.build b/drivers/net/hns3/meson.build
index 33f61f9883..5414ec6628 100644
--- a/drivers/net/hns3/meson.build
+++ b/drivers/net/hns3/meson.build
@@ -39,6 +39,8 @@ annotate_locks = false
 
 deps += ['hash']
 
+cflags += no_vla_cflag
+
 if arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('hns3_rxtx_vec.c')
 
diff --git a/drivers/net/mlx4/meson.build b/drivers/net/mlx4/meson.build
index 3c5ee24186..df8913e66d 100644
--- a/drivers/net/mlx4/meson.build
+++ b/drivers/net/mlx4/meson.build
@@ -8,6 +8,8 @@ if not is_linux
     subdir_done()
 endif
 
+cflags += no_vla_cflag
+
 static_ibverbs = (get_option('ibverbs_link') == 'static')
 dlopen_ibverbs = (get_option('ibverbs_link') == 'dlopen')
 LIB_GLUE_BASE = 'librte_net_mlx4_glue.so'
diff --git a/drivers/net/mlx5/linux/meson.build b/drivers/net/mlx5/linux/meson.build
index e541d25c18..b8f18464e2 100644
--- a/drivers/net/mlx5/linux/meson.build
+++ b/drivers/net/mlx5/linux/meson.build
@@ -11,3 +11,5 @@ sources += files(
         'mlx5_vlan_os.c',
         'mlx5_flow_os.c',
 )
+
+cflags += no_vla_cflag
diff --git a/drivers/net/netvsc/meson.build b/drivers/net/netvsc/meson.build
index bb6225d05a..672b17482b 100644
--- a/drivers/net/netvsc/meson.build
+++ b/drivers/net/netvsc/meson.build
@@ -15,3 +15,5 @@ sources = files(
         'hn_rxtx.c',
         'hn_vf.c',
 )
+
+cflags += no_vla_cflag
diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build
index 58a066c2e3..fa8045cfb5 100644
--- a/drivers/net/nfp/meson.build
+++ b/drivers/net/nfp/meson.build
@@ -49,6 +49,8 @@ sources = files(
         'nfp_service.c',
 )
 
+cflags += no_vla_cflag
+
 if arch_subdir == 'x86'
         includes += include_directories('../../common/nfp')
 
diff --git a/drivers/net/ngbe/base/meson.build b/drivers/net/ngbe/base/meson.build
index dd68100bf8..6f93bb1540 100644
--- a/drivers/net/ngbe/base/meson.build
+++ b/drivers/net/ngbe/base/meson.build
@@ -15,6 +15,7 @@ sources = [
 
 error_cflags = []
 
+cflags += no_vla_cflag
 c_args = cflags
 
 base_lib = static_library('ngbe_base', sources,
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 3c05ad1d87..a6db9037c0 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -107,3 +107,5 @@ sources = files(
         'ntnic_vfio.c',
         'ntnic_ethdev.c',
 )
+
+cflags += no_vla_cflag
diff --git a/drivers/net/octeontx/meson.build b/drivers/net/octeontx/meson.build
index a5a6c9661c..496c610a41 100644
--- a/drivers/net/octeontx/meson.build
+++ b/drivers/net/octeontx/meson.build
@@ -19,3 +19,5 @@ sources = files(
 deps += ['mempool_octeontx', 'eventdev']
 
 includes += include_directories('base')
+
+cflags += no_vla_cflag
diff --git a/drivers/net/sfc/meson.build b/drivers/net/sfc/meson.build
index 5adde68517..3773842beb 100644
--- a/drivers/net/sfc/meson.build
+++ b/drivers/net/sfc/meson.build
@@ -18,6 +18,7 @@ if (arch_subdir != 'x86' and arch_subdir != 'arm') or (not dpdk_conf.get('RTE_AR
     subdir_done()
 endif
 
+cflags += no_vla_cflag
 extra_flags = []
 
 # Strict-aliasing rules are violated by rte_eth_link to uint64_t casts
diff --git a/drivers/net/softnic/meson.build b/drivers/net/softnic/meson.build
index 5dfbd16c77..5ee863ed59 100644
--- a/drivers/net/softnic/meson.build
+++ b/drivers/net/softnic/meson.build
@@ -16,3 +16,4 @@ sources = files(
         'rte_eth_softnic_thread.c',
 )
 deps += ['pipeline', 'port', 'table']
+cflags += no_vla_cflag
diff --git a/drivers/net/tap/meson.build b/drivers/net/tap/meson.build
index fa4e6cbec9..6807637fcd 100644
--- a/drivers/net/tap/meson.build
+++ b/drivers/net/tap/meson.build
@@ -16,6 +16,7 @@ deps = ['bus_vdev', 'gso', 'hash']
 
 max_queues = '-DTAP_MAX_QUEUES=64'
 cflags += max_queues
+cflags += no_vla_cflag
 
 require_iova_in_mbuf = false
 
diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index ba7167a511..ed6ef31de4 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -24,6 +24,8 @@ sources = files(
 
 deps += ['hash', 'security']
 
+cflags += no_vla_cflag
+
 if arch_subdir == 'x86'
     sources += files('txgbe_rxtx_vec_sse.c')
 elif arch_subdir == 'arm'
diff --git a/drivers/net/vdev_netvsc/meson.build b/drivers/net/vdev_netvsc/meson.build
index 2228250b6c..805f19c725 100644
--- a/drivers/net/vdev_netvsc/meson.build
+++ b/drivers/net/vdev_netvsc/meson.build
@@ -7,6 +7,8 @@ if not is_linux
 endif
 sources = files('vdev_netvsc.c')
 
+cflags += no_vla_cflag
+
 cflags_options = [
         '-D_BSD_SOURCE',
         '-D_DEFAULT_SOURCE',
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index 02742da5c2..ac960aadb0 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -23,6 +23,8 @@ sources += files(
 )
 deps += ['kvargs', 'bus_pci']
 
+cflags += no_vla_cflag
+
 if arch_subdir == 'x86'
     if cc_has_avx512
         cflags += ['-DCC_AVX512_SUPPORT']
diff --git a/drivers/vdpa/mlx5/meson.build b/drivers/vdpa/mlx5/meson.build
index e224d1bcc9..fa46233755 100644
--- a/drivers/vdpa/mlx5/meson.build
+++ b/drivers/vdpa/mlx5/meson.build
@@ -22,6 +22,9 @@ sources = files(
         'mlx5_vdpa_lm.c',
         'mlx5_vdpa_cthread.c',
 )
+
+cflags += no_vla_cflag
+
 cflags_options = [
         '-std=c11',
         '-Wno-strict-prototypes',
-- 
2.47.2.vfs.0.1

