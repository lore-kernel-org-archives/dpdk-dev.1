Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8556C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F8514066A;
	Tue, 18 Feb 2025 12:16:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 016BF4065A
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:16:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739877372; x=1771413372;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ybi04Wlm/Oyus7opb8a9WuQIXNM4bwoO0dszGj+KFcw=;
 b=eKxf99hUwo9wSIYYh9R70GLHHJo+d5pcsDUK1gHXMqHX67oFexWvsV3G
 Ht3EYYyE+zAD9Jy8NxzymcWza20bVkaPzZ0Nt34EIiMLFYnRAXHSb9Dfj
 Fauxh5vYI1us8H61r6o3kOe09Cd4yMwmhAx5oPzartcBB27Bs9PMG5Ivy
 Zevh3nvlfBHjCMEbAwyGav7l83aXAnOgXk2UQoFnbRR6XT2Y9sf6JKVs/
 fQEVfiUBnkus0quvaNtOg5ddMkbELb/vBjnZbNOxgwWYUwOJbpPPidWjt
 ukRuLn5NrifS8A5h41kphMyj0j/1CtUc4MbBmwqUzWfy9YOB2fGkVdOMx A==;
X-CSE-ConnectionGUID: 19KtOE/MQb6qUfnT9wcIeA==
X-CSE-MsgGUID: TwiKqyYyRLyMyF1xYW+Qww==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50780856"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="50780856"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 03:16:11 -0800
X-CSE-ConnectionGUID: PbFO/h9XRt63+ULLZAOZ/g==
X-CSE-MsgGUID: kOLr9yseSK+WfBZUQCW+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="119466381"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2025 03:15:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Hanxiao Li <li.hanxiao@zte.com.cn>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Ankur Dwivedi <adwivedi@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Kai Ji <kai.ji@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Vamsi Attunuru <vattunuru@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Pravin Pathak <pravin.pathak@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Jakub Palider <jpalider@marvell.com>, Yong Zhang <zhang.yong25@zte.com.cn>,
 Jingjing Wu <jingjing.wu@intel.com>, Liron Himi <lironh@marvell.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>
Subject: [PATCH v6 6/8] drivers: reduce driver dependencies
Date: Tue, 18 Feb 2025 11:15:32 +0000
Message-ID: <f678bf6f44bb18deecaad5cc6689cefee0d483ae.1739877266.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1739877265.git.anatoly.burakov@intel.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
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

From: Bruce Richardson <bruce.richardson@intel.com>

Remove any unnecessary dependencies from the driver dependency lists.
This will give each driver a near-minimum set of required dependencies.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Rosen Xu <rosen.xu@intel.com>
---
 drivers/baseband/fpga_5gnr_fec/meson.build | 2 +-
 drivers/baseband/fpga_lte_fec/meson.build  | 2 +-
 drivers/baseband/la12xx/meson.build        | 2 +-
 drivers/baseband/null/meson.build          | 2 +-
 drivers/baseband/turbo_sw/meson.build      | 2 +-
 drivers/bus/auxiliary/meson.build          | 2 --
 drivers/bus/dpaa/meson.build               | 2 +-
 drivers/bus/fslmc/meson.build              | 2 +-
 drivers/bus/ifpga/meson.build              | 2 +-
 drivers/bus/pci/meson.build                | 4 +---
 drivers/bus/platform/meson.build           | 1 -
 drivers/bus/uacce/meson.build              | 2 --
 drivers/bus/vdev/meson.build               | 2 --
 drivers/common/cnxk/meson.build            | 4 ++--
 drivers/common/cpt/meson.build             | 2 +-
 drivers/common/mlx5/meson.build            | 2 +-
 drivers/common/zsda/meson.build            | 2 +-
 drivers/compress/mlx5/meson.build          | 2 +-
 drivers/compress/nitrox/meson.build        | 2 +-
 drivers/compress/octeontx/meson.build      | 2 +-
 drivers/crypto/bcmfs/meson.build           | 2 +-
 drivers/crypto/cnxk/meson.build            | 2 +-
 drivers/crypto/dpaa_sec/meson.build        | 2 +-
 drivers/crypto/ipsec_mb/meson.build        | 2 +-
 drivers/crypto/mlx5/meson.build            | 2 +-
 drivers/crypto/nitrox/meson.build          | 2 +-
 drivers/dma/cnxk/meson.build               | 2 +-
 drivers/dma/dpaa/meson.build               | 2 +-
 drivers/dma/dpaa2/meson.build              | 2 +-
 drivers/dma/odm/meson.build                | 2 +-
 drivers/dma/skeleton/meson.build           | 2 +-
 drivers/event/cnxk/meson.build             | 2 +-
 drivers/event/dlb2/meson.build             | 2 +-
 drivers/event/dpaa2/meson.build            | 2 +-
 drivers/event/octeontx/meson.build         | 3 +--
 drivers/event/sw/meson.build               | 2 +-
 drivers/mempool/cnxk/meson.build           | 2 +-
 drivers/mempool/dpaa/meson.build           | 2 +-
 drivers/mempool/dpaa2/meson.build          | 2 +-
 drivers/mempool/octeontx/meson.build       | 2 +-
 drivers/ml/cnxk/meson.build                | 2 +-
 drivers/net/cnxk/meson.build               | 4 +---
 drivers/net/intel/iavf/meson.build         | 2 +-
 drivers/net/intel/ice/meson.build          | 2 +-
 drivers/net/mana/meson.build               | 2 +-
 drivers/net/mlx5/meson.build               | 2 +-
 drivers/net/sfc/meson.build                | 2 +-
 drivers/net/softnic/meson.build            | 2 +-
 drivers/net/virtio/meson.build             | 2 +-
 drivers/raw/cnxk_bphy/meson.build          | 2 +-
 drivers/raw/cnxk_gpio/meson.build          | 2 +-
 drivers/raw/gdtc/meson.build               | 2 +-
 drivers/raw/ntb/meson.build                | 2 +-
 drivers/raw/skeleton/meson.build           | 2 +-
 drivers/regex/cn9k/meson.build             | 2 +-
 drivers/regex/mlx5/meson.build             | 2 +-
 drivers/vdpa/ifc/meson.build               | 2 +-
 drivers/vdpa/meson.build                   | 3 +--
 drivers/vdpa/mlx5/meson.build              | 2 +-
 drivers/vdpa/sfc/meson.build               | 2 +-
 60 files changed, 57 insertions(+), 70 deletions(-)

diff --git a/drivers/baseband/fpga_5gnr_fec/meson.build b/drivers/baseband/fpga_5gnr_fec/meson.build
index c3678d23eb..31b9e92fbb 100644
--- a/drivers/baseband/fpga_5gnr_fec/meson.build
+++ b/drivers/baseband/fpga_5gnr_fec/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2020 Intel Corporation
 
-deps += ['bus_vdev', 'ring', 'pci', 'bus_pci']
+deps += ['bus_vdev', 'bus_pci']
 
 sources = files('rte_fpga_5gnr_fec.c')
 
diff --git a/drivers/baseband/fpga_lte_fec/meson.build b/drivers/baseband/fpga_lte_fec/meson.build
index 14e07826ef..fbf24755db 100644
--- a/drivers/baseband/fpga_lte_fec/meson.build
+++ b/drivers/baseband/fpga_lte_fec/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
-deps += ['bus_vdev', 'ring', 'pci', 'bus_pci']
+deps += ['bus_vdev', 'bus_pci']
 sources = files('fpga_lte_fec.c')
diff --git a/drivers/baseband/la12xx/meson.build b/drivers/baseband/la12xx/meson.build
index 7b7e41c961..e1dbdd0fa7 100644
--- a/drivers/baseband/la12xx/meson.build
+++ b/drivers/baseband/la12xx/meson.build
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright 2020-2021 NXP
 
-deps += ['bus_vdev', 'ring']
+deps += ['bus_vdev']
 
 sources = files('bbdev_la12xx.c')
diff --git a/drivers/baseband/null/meson.build b/drivers/baseband/null/meson.build
index 22863f0bd8..716d6c6fdb 100644
--- a/drivers/baseband/null/meson.build
+++ b/drivers/baseband/null/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
 
-deps += ['bus_vdev', 'ring']
+deps += ['bus_vdev']
 sources = files('bbdev_null.c')
diff --git a/drivers/baseband/turbo_sw/meson.build b/drivers/baseband/turbo_sw/meson.build
index a9035a753e..ac18e8a9b6 100644
--- a/drivers/baseband/turbo_sw/meson.build
+++ b/drivers/baseband/turbo_sw/meson.build
@@ -26,5 +26,5 @@ if dep_dec5g.found()
     cflags += ['-DRTE_BBDEV_SDK_AVX512']
 endif
 
-deps += ['bus_vdev', 'ring']
+deps += ['bus_vdev']
 sources = files('bbdev_turbo_software.c')
diff --git a/drivers/bus/auxiliary/meson.build b/drivers/bus/auxiliary/meson.build
index 10468fd130..a113f11743 100644
--- a/drivers/bus/auxiliary/meson.build
+++ b/drivers/bus/auxiliary/meson.build
@@ -13,5 +13,3 @@ if is_linux
 endif
 
 require_iova_in_mbuf = false
-
-deps += ['kvargs']
diff --git a/drivers/bus/dpaa/meson.build b/drivers/bus/dpaa/meson.build
index 5506f2bffc..a2314fdebe 100644
--- a/drivers/bus/dpaa/meson.build
+++ b/drivers/bus/dpaa/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['common_dpaax', 'eventdev']
+deps = ['common_dpaax', 'eventdev']
 sources = files(
         'base/fman/fman.c',
         'base/fman/fman_hw.c',
diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index 70098ad778..a0e11f7081 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['common_dpaax', 'eventdev', 'kvargs']
+deps = ['common_dpaax', 'eventdev']
 sources = files(
         'fslmc_bus.c',
         'fslmc_vfio.c',
diff --git a/drivers/bus/ifpga/meson.build b/drivers/bus/ifpga/meson.build
index dedc94db2d..e87b08eaf4 100644
--- a/drivers/bus/ifpga/meson.build
+++ b/drivers/bus/ifpga/meson.build
@@ -7,6 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-deps += ['pci', 'kvargs', 'rawdev']
+deps = ['pci', 'rawdev']
 driver_sdk_headers += files('bus_ifpga_driver.h')
 sources = files('ifpga_bus.c')
diff --git a/drivers/bus/pci/meson.build b/drivers/bus/pci/meson.build
index fede114dc7..776c3d1550 100644
--- a/drivers/bus/pci/meson.build
+++ b/drivers/bus/pci/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-deps += ['pci']
+deps = ['pci']
 headers = files('rte_bus_pci.h')
 driver_sdk_headers = files('bus_pci_driver.h')
 sources = files('pci_common.c',
@@ -31,5 +31,3 @@ if is_windows
 endif
 
 require_iova_in_mbuf = false
-
-deps += ['kvargs']
diff --git a/drivers/bus/platform/meson.build b/drivers/bus/platform/meson.build
index 8633cc4e75..2039c23ac6 100644
--- a/drivers/bus/platform/meson.build
+++ b/drivers/bus/platform/meson.build
@@ -10,7 +10,6 @@ endif
 
 require_iova_in_mbuf = false
 
-deps += ['kvargs']
 sources = files(
         'platform_params.c',
         'platform.c',
diff --git a/drivers/bus/uacce/meson.build b/drivers/bus/uacce/meson.build
index a659d65f23..130148a315 100644
--- a/drivers/bus/uacce/meson.build
+++ b/drivers/bus/uacce/meson.build
@@ -8,5 +8,3 @@ endif
 
 sources = files('uacce.c')
 driver_sdk_headers += files('bus_uacce_driver.h')
-
-deps += ['kvargs']
diff --git a/drivers/bus/vdev/meson.build b/drivers/bus/vdev/meson.build
index 50f0c8918d..24993c88a3 100644
--- a/drivers/bus/vdev/meson.build
+++ b/drivers/bus/vdev/meson.build
@@ -9,5 +9,3 @@ headers = files('rte_bus_vdev.h')
 driver_sdk_headers = files('bus_vdev_driver.h')
 
 require_iova_in_mbuf = false
-
-deps += ['kvargs']
diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 00a352dc55..669e4d78b7 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -8,7 +8,7 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
     subdir_done()
 endif
 
-deps = ['eal', 'pci', 'bus_pci', 'mbuf', 'security']
+deps = ['bus_pci', 'security']
 sources = files(
         'roc_ae.c',
         'roc_aes.c',
@@ -107,7 +107,7 @@ elif soc_type == 'cn20k'
     dpdk_conf.set('ROC_PLATFORM_CN20K', 1)
 endif
 
-deps += ['bus_pci', 'net', 'telemetry']
+deps += ['bus_pci']
 
 require_iova_in_mbuf = false
 
diff --git a/drivers/common/cpt/meson.build b/drivers/common/cpt/meson.build
index c09824a651..a4b000dc37 100644
--- a/drivers/common/cpt/meson.build
+++ b/drivers/common/cpt/meson.build
@@ -9,5 +9,5 @@ endif
 
 sources = files('cpt_fpm_tables.c', 'cpt_pmd_ops_helper.c')
 
-deps = ['kvargs', 'pci', 'cryptodev']
+deps = ['pci', 'cryptodev']
 includes += include_directories('../../crypto/octeontx')
diff --git a/drivers/common/mlx5/meson.build b/drivers/common/mlx5/meson.build
index f572b12ae3..a78295bb08 100644
--- a/drivers/common/mlx5/meson.build
+++ b/drivers/common/mlx5/meson.build
@@ -12,7 +12,7 @@ if is_windows and not is_ms_linker and not meson.is_cross_build()
     subdir_done()
 endif
 
-deps += ['hash', 'pci', 'bus_pci', 'bus_auxiliary', 'net', 'eal', 'kvargs']
+deps += ['hash', 'bus_pci', 'bus_auxiliary']
 sources += files(
         'mlx5_devx_cmds.c',
         'mlx5_common.c',
diff --git a/drivers/common/zsda/meson.build b/drivers/common/zsda/meson.build
index be4fbaedb3..e847c21378 100644
--- a/drivers/common/zsda/meson.build
+++ b/drivers/common/zsda/meson.build
@@ -7,7 +7,7 @@ if is_windows
     subdir_done()
 endif
 
-deps += ['bus_pci', 'mbuf', 'compressdev']
+deps += ['bus_pci', 'compressdev']
 sources += files(
         'zsda_device.c',
         'zsda_logs.c',
diff --git a/drivers/compress/mlx5/meson.build b/drivers/compress/mlx5/meson.build
index 26a0e0cd09..ddb9e0f82c 100644
--- a/drivers/compress/mlx5/meson.build
+++ b/drivers/compress/mlx5/meson.build
@@ -7,7 +7,7 @@ if not is_linux
     subdir_done()
 endif
 
-deps += ['common_mlx5', 'eal', 'compressdev']
+deps += ['common_mlx5', 'compressdev']
 if not dpdk_conf.has('RTE_COMMON_MLX5')
     # avoid referencing undefined variables from common/mlx5
     subdir_done()
diff --git a/drivers/compress/nitrox/meson.build b/drivers/compress/nitrox/meson.build
index 1becc66912..c3db4ac2bb 100644
--- a/drivers/compress/nitrox/meson.build
+++ b/drivers/compress/nitrox/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['common_nitrox', 'bus_pci', 'compressdev']
+deps += ['common_nitrox', 'compressdev']
 
 sources += files(
         'nitrox_comp.c',
diff --git a/drivers/compress/octeontx/meson.build b/drivers/compress/octeontx/meson.build
index 16f973f4d7..0ccde449e8 100644
--- a/drivers/compress/octeontx/meson.build
+++ b/drivers/compress/octeontx/meson.build
@@ -9,7 +9,7 @@ endif
 
 sources = files('otx_zip.c', 'otx_zip_pmd.c')
 includes += include_directories('include')
-deps += ['mempool_octeontx', 'bus_pci']
+deps += ['mempool_octeontx']
 ext_deps += dep
 
 require_iova_in_mbuf = false
diff --git a/drivers/crypto/bcmfs/meson.build b/drivers/crypto/bcmfs/meson.build
index 5842f83a3b..678bab7398 100644
--- a/drivers/crypto/bcmfs/meson.build
+++ b/drivers/crypto/bcmfs/meson.build
@@ -9,7 +9,7 @@ if is_windows
     subdir_done()
 endif
 
-deps += ['eal', 'bus_vdev']
+deps += ['bus_vdev']
 sources = files(
         'bcmfs_logs.c',
         'bcmfs_device.c',
diff --git a/drivers/crypto/cnxk/meson.build b/drivers/crypto/cnxk/meson.build
index e9b67b4a14..77efe98cb3 100644
--- a/drivers/crypto/cnxk/meson.build
+++ b/drivers/crypto/cnxk/meson.build
@@ -25,7 +25,7 @@ sources = files(
 )
 
 headers = files('rte_pmd_cnxk_crypto.h')
-deps += ['bus_pci', 'common_cnxk', 'security', 'eventdev']
+deps += ['common_cnxk', 'eventdev']
 includes += include_directories('../../../lib/net', '../../event/cnxk')
 
 cflags += no_wvla_cflag
diff --git a/drivers/crypto/dpaa_sec/meson.build b/drivers/crypto/dpaa_sec/meson.build
index f87ad6c7e7..9efac952c4 100644
--- a/drivers/crypto/dpaa_sec/meson.build
+++ b/drivers/crypto/dpaa_sec/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['bus_dpaa', 'mempool_dpaa', 'security']
+deps += ['mempool_dpaa', 'security']
 sources = files('dpaa_sec.c', 'dpaa_sec_raw_dp.c')
 
 includes += include_directories('../../bus/dpaa/include')
diff --git a/drivers/crypto/ipsec_mb/meson.build b/drivers/crypto/ipsec_mb/meson.build
index 5fcff5b04b..5a2a53f55f 100644
--- a/drivers/crypto/ipsec_mb/meson.build
+++ b/drivers/crypto/ipsec_mb/meson.build
@@ -47,5 +47,5 @@ sources = files(
         'pmd_snow3g.c',
         'pmd_zuc.c',
 )
-deps += ['bus_vdev', 'net', 'security']
+deps += ['bus_vdev', 'security']
 require_iova_in_mbuf = false
diff --git a/drivers/crypto/mlx5/meson.build b/drivers/crypto/mlx5/meson.build
index d7bc8ec967..595053d8cd 100644
--- a/drivers/crypto/mlx5/meson.build
+++ b/drivers/crypto/mlx5/meson.build
@@ -7,7 +7,7 @@ if not (is_linux or is_windows)
     subdir_done()
 endif
 
-deps += ['common_mlx5', 'eal', 'cryptodev']
+deps += ['common_mlx5', 'cryptodev']
 if not dpdk_conf.has('RTE_COMMON_MLX5')
     # avoid referencing undefined variables from common/mlx5
     subdir_done()
diff --git a/drivers/crypto/nitrox/meson.build b/drivers/crypto/nitrox/meson.build
index f8887713d2..85e3ca2b28 100644
--- a/drivers/crypto/nitrox/meson.build
+++ b/drivers/crypto/nitrox/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['common_nitrox', 'bus_pci', 'cryptodev']
+deps += ['common_nitrox', 'cryptodev']
 
 sources += files(
         'nitrox_sym.c',
diff --git a/drivers/dma/cnxk/meson.build b/drivers/dma/cnxk/meson.build
index 8ccc1c2cb7..738774d542 100644
--- a/drivers/dma/cnxk/meson.build
+++ b/drivers/dma/cnxk/meson.build
@@ -12,7 +12,7 @@ driver_sdk_headers = files(
         'cnxk_dma_event_dp.h',
 )
 
-deps += ['bus_pci', 'common_cnxk', 'dmadev', 'eventdev']
+deps += ['common_cnxk', 'eventdev']
 
 includes += include_directories('../../event/cnxk')
 
diff --git a/drivers/dma/dpaa/meson.build b/drivers/dma/dpaa/meson.build
index aac5ffb36d..33c0b8d858 100644
--- a/drivers/dma/dpaa/meson.build
+++ b/drivers/dma/dpaa/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on linux'
 endif
 
-deps += ['dmadev', 'bus_dpaa']
+deps += ['bus_dpaa']
 sources = files('dpaa_qdma.c')
 
 cflags += no_wvla_cflag
diff --git a/drivers/dma/dpaa2/meson.build b/drivers/dma/dpaa2/meson.build
index a523f5edb4..cc4a02440e 100644
--- a/drivers/dma/dpaa2/meson.build
+++ b/drivers/dma/dpaa2/meson.build
@@ -8,7 +8,7 @@ endif
 
 build = dpdk_conf.has('RTE_MEMPOOL_DPAA2')
 reason = 'missing dependency, DPDK DPAA2 mempool driver'
-deps += ['dmadev', 'bus_fslmc', 'mempool_dpaa2', 'ring', 'kvargs']
+deps += ['mempool_dpaa2']
 sources = files('dpaa2_qdma.c')
 
 if cc.has_argument('-Wno-pointer-arith')
diff --git a/drivers/dma/odm/meson.build b/drivers/dma/odm/meson.build
index d597762d37..959e7e685d 100644
--- a/drivers/dma/odm/meson.build
+++ b/drivers/dma/odm/meson.build
@@ -7,7 +7,7 @@ if not is_linux or not dpdk_conf.get('RTE_ARCH_64')
     subdir_done()
 endif
 
-deps += ['bus_pci', 'dmadev', 'eal', 'mempool', 'pci']
+deps += ['bus_pci', 'dmadev', 'mempool']
 
 sources = files('odm_dmadev.c', 'odm.c')
 
diff --git a/drivers/dma/skeleton/meson.build b/drivers/dma/skeleton/meson.build
index 77055683ad..0d703a36eb 100644
--- a/drivers/dma/skeleton/meson.build
+++ b/drivers/dma/skeleton/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2021 HiSilicon Limited
 
-deps += ['dmadev', 'kvargs', 'ring', 'bus_vdev']
+deps += ['dmadev', 'ring', 'bus_vdev']
 sources = files(
         'skeleton_dmadev.c',
 )
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 9461ae33e4..c0ddd84fdd 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -313,7 +313,7 @@ foreach flag: extra_flags
 endforeach
 
 headers = files('rte_pmd_cnxk_eventdev.h')
-deps += ['bus_pci', 'common_cnxk', 'net_cnxk', 'crypto_cnxk', 'dma_cnxk']
+deps += ['net_cnxk', 'crypto_cnxk', 'dma_cnxk']
 
 require_iova_in_mbuf = false
 
diff --git a/drivers/event/dlb2/meson.build b/drivers/event/dlb2/meson.build
index c024edb311..2bb1b97686 100644
--- a/drivers/event/dlb2/meson.build
+++ b/drivers/event/dlb2/meson.build
@@ -39,4 +39,4 @@ endif
 
 headers = files('rte_pmd_dlb2.h')
 
-deps += ['mbuf', 'mempool', 'ring', 'pci', 'bus_pci']
+deps += ['bus_pci']
diff --git a/drivers/event/dpaa2/meson.build b/drivers/event/dpaa2/meson.build
index dd5063af43..7dae1da32b 100644
--- a/drivers/event/dpaa2/meson.build
+++ b/drivers/event/dpaa2/meson.build
@@ -5,7 +5,7 @@ if not is_linux
     build = false
     reason = 'only supported on Linux'
 endif
-deps += ['bus_vdev', 'net_dpaa2', 'crypto_dpaa2_sec']
+deps += ['net_dpaa2', 'crypto_dpaa2_sec']
 sources = files(
         'dpaa2_hw_dpcon.c',
         'dpaa2_eventdev.c',
diff --git a/drivers/event/octeontx/meson.build b/drivers/event/octeontx/meson.build
index eb17e059d8..1227b2e18d 100644
--- a/drivers/event/octeontx/meson.build
+++ b/drivers/event/octeontx/meson.build
@@ -17,5 +17,4 @@ sources = files(
         'timvf_probe.c',
 )
 
-deps += ['common_octeontx', 'mempool_octeontx', 'bus_vdev', 'net_octeontx']
-deps += ['crypto_octeontx']
+deps = ['net_octeontx', 'crypto_octeontx']
diff --git a/drivers/event/sw/meson.build b/drivers/event/sw/meson.build
index c0c559ebc4..312008eb05 100644
--- a/drivers/event/sw/meson.build
+++ b/drivers/event/sw/meson.build
@@ -8,6 +8,6 @@ sources = files(
         'sw_evdev_xstats.c',
         'sw_evdev.c',
 )
-deps += ['hash', 'bus_vdev']
+deps += ['bus_vdev']
 require_iova_in_mbuf = false
 cflags += no_wvla_cflag
diff --git a/drivers/mempool/cnxk/meson.build b/drivers/mempool/cnxk/meson.build
index e388cce26a..7bbed325df 100644
--- a/drivers/mempool/cnxk/meson.build
+++ b/drivers/mempool/cnxk/meson.build
@@ -18,5 +18,5 @@ sources = files(
 )
 
 headers = files('rte_pmd_cnxk_mempool.h')
-deps += ['eal', 'mbuf', 'kvargs', 'bus_pci', 'common_cnxk', 'mempool']
+deps = ['common_cnxk']
 require_iova_in_mbuf = false
diff --git a/drivers/mempool/dpaa/meson.build b/drivers/mempool/dpaa/meson.build
index c4e9994b83..39fc312344 100644
--- a/drivers/mempool/dpaa/meson.build
+++ b/drivers/mempool/dpaa/meson.build
@@ -6,5 +6,5 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['bus_dpaa']
+deps = ['bus_dpaa']
 sources = files('dpaa_mempool.c')
diff --git a/drivers/mempool/dpaa2/meson.build b/drivers/mempool/dpaa2/meson.build
index 3d16d44158..0099b20b97 100644
--- a/drivers/mempool/dpaa2/meson.build
+++ b/drivers/mempool/dpaa2/meson.build
@@ -6,7 +6,7 @@ if not is_linux
     reason = 'only supported on Linux'
 endif
 
-deps += ['bus_fslmc']
+deps = ['bus_fslmc']
 sources = files('dpaa2_hw_mempool.c')
 
 headers = files('rte_dpaa2_mempool.h')
diff --git a/drivers/mempool/octeontx/meson.build b/drivers/mempool/octeontx/meson.build
index 3ccecac75d..f97bcf4a5a 100644
--- a/drivers/mempool/octeontx/meson.build
+++ b/drivers/mempool/octeontx/meson.build
@@ -12,6 +12,6 @@ sources = files(
         'rte_mempool_octeontx.c',
 )
 
-deps += ['mbuf', 'bus_pci', 'common_octeontx']
+deps = ['mbuf', 'bus_pci', 'common_octeontx']
 
 require_iova_in_mbuf = false
diff --git a/drivers/ml/cnxk/meson.build b/drivers/ml/cnxk/meson.build
index 0680a0faa5..6c99f5b57b 100644
--- a/drivers/ml/cnxk/meson.build
+++ b/drivers/ml/cnxk/meson.build
@@ -55,7 +55,7 @@ sources = files(
         'cnxk_ml_utils.c',
 )
 
-deps += ['mldev', 'common_cnxk', 'kvargs', 'hash']
+deps += ['mldev', 'common_cnxk', 'hash']
 
 if enable_mvtvm
 
diff --git a/drivers/net/cnxk/meson.build b/drivers/net/cnxk/meson.build
index a747a5fcae..e50acfa67e 100644
--- a/drivers/net/cnxk/meson.build
+++ b/drivers/net/cnxk/meson.build
@@ -322,9 +322,7 @@ sources += files(
 endif
 endif
 
-
-deps += ['bus_pci', 'cryptodev', 'eventdev', 'security']
-deps += ['common_cnxk', 'mempool_cnxk']
+deps = ['eventdev', 'mempool_cnxk']
 
 cflags += no_wvla_cflag
 
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 19cd1cfbc8..bd0c75053b 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -7,7 +7,7 @@ endif
 
 testpmd_sources = files('iavf_testpmd.c')
 
-deps += ['security', 'cryptodev']
+deps += ['security']
 
 sources = files(
         'base/iavf_adminq.c',
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index a34b7c966a..1c0685aca4 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -18,7 +18,7 @@ sources = files(
 
 testpmd_sources = files('ice_testpmd.c')
 
-deps += ['hash', 'net']
+deps += ['hash']
 includes += include_directories('base')
 
 if dpdk_conf.has('RTE_NET_IAVF')
diff --git a/drivers/net/mana/meson.build b/drivers/net/mana/meson.build
index e320da7fc4..20408049d3 100644
--- a/drivers/net/mana/meson.build
+++ b/drivers/net/mana/meson.build
@@ -7,7 +7,7 @@ if not is_linux or not (dpdk_conf.has('RTE_ARCH_X86') or dpdk_conf.has('RTE_ARCH
     subdir_done()
 endif
 
-deps += ['pci', 'bus_pci', 'net', 'eal', 'kvargs']
+deps += ['bus_pci']
 
 sources += files(
         'gdma.c',
diff --git a/drivers/net/mlx5/meson.build b/drivers/net/mlx5/meson.build
index 78a8648b43..7c4a63524f 100644
--- a/drivers/net/mlx5/meson.build
+++ b/drivers/net/mlx5/meson.build
@@ -8,7 +8,7 @@ if not (is_linux or is_windows)
     subdir_done()
 endif
 
-deps += ['hash', 'common_mlx5']
+deps += ['common_mlx5']
 if not dpdk_conf.has('RTE_COMMON_MLX5')
     # avoid referencing undefined variables from common/mlx5
     subdir_done()
diff --git a/drivers/net/sfc/meson.build b/drivers/net/sfc/meson.build
index 90c38231e1..a0f78eb2aa 100644
--- a/drivers/net/sfc/meson.build
+++ b/drivers/net/sfc/meson.build
@@ -72,7 +72,7 @@ if not cc.links(atomic_check_code)
     ext_deps += libatomic_dep
 endif
 
-deps += ['common_sfc_efx', 'bus_pci', 'hash']
+deps += ['common_sfc_efx', 'hash']
 sources = files(
         'sfc_ethdev.c',
         'sfc_kvargs.c',
diff --git a/drivers/net/softnic/meson.build b/drivers/net/softnic/meson.build
index e8d7290062..cdff250bcc 100644
--- a/drivers/net/softnic/meson.build
+++ b/drivers/net/softnic/meson.build
@@ -15,5 +15,5 @@ sources = files(
         'rte_eth_softnic_swq.c',
         'rte_eth_softnic_thread.c',
 )
-deps += ['pipeline', 'port', 'table']
+deps += ['pipeline']
 cflags += no_wvla_cflag
diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
index 4302595424..f748fb3123 100644
--- a/drivers/net/virtio/meson.build
+++ b/drivers/net/virtio/meson.build
@@ -21,7 +21,7 @@ sources += files(
         'virtio_rxtx_simple.c',
         'virtqueue.c',
 )
-deps += ['kvargs', 'bus_pci']
+deps += ['bus_pci']
 
 cflags += no_wvla_cflag
 
diff --git a/drivers/raw/cnxk_bphy/meson.build b/drivers/raw/cnxk_bphy/meson.build
index bb5d2ffb80..b38b071697 100644
--- a/drivers/raw/cnxk_bphy/meson.build
+++ b/drivers/raw/cnxk_bphy/meson.build
@@ -2,7 +2,7 @@
 # Copyright(C) 2021 Marvell.
 #
 
-deps += ['bus_pci', 'common_cnxk', 'rawdev']
+deps += ['common_cnxk', 'rawdev']
 sources = files(
         'cnxk_bphy.c',
         'cnxk_bphy_cgx.c',
diff --git a/drivers/raw/cnxk_gpio/meson.build b/drivers/raw/cnxk_gpio/meson.build
index 9d9a527392..6d17fe573f 100644
--- a/drivers/raw/cnxk_gpio/meson.build
+++ b/drivers/raw/cnxk_gpio/meson.build
@@ -2,7 +2,7 @@
 # Copyright(C) 2021 Marvell.
 #
 
-deps += ['bus_vdev', 'common_cnxk', 'rawdev', 'kvargs']
+deps += ['bus_vdev', 'common_cnxk', 'rawdev']
 sources = files(
         'cnxk_gpio.c',
         'cnxk_gpio_irq.c',
diff --git a/drivers/raw/gdtc/meson.build b/drivers/raw/gdtc/meson.build
index 3e748ca58d..b86f9510ce 100644
--- a/drivers/raw/gdtc/meson.build
+++ b/drivers/raw/gdtc/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright 2024 ZTE Corporation
 
-deps += ['rawdev', 'kvargs', 'mbuf', 'bus_pci']
+deps += ['rawdev', 'mbuf', 'bus_pci']
 sources = files('gdtc_rawdev.c')
diff --git a/drivers/raw/ntb/meson.build b/drivers/raw/ntb/meson.build
index 9096f2b25a..8f79d3b16a 100644
--- a/drivers/raw/ntb/meson.build
+++ b/drivers/raw/ntb/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation.
 
-deps += ['rawdev', 'mbuf', 'mempool', 'pci', 'bus_pci']
+deps += ['rawdev', 'mbuf', 'bus_pci']
 sources = files('ntb.c',
                 'ntb_hw_intel.c')
 headers = files('rte_pmd_ntb.h')
diff --git a/drivers/raw/skeleton/meson.build b/drivers/raw/skeleton/meson.build
index 9d5fcf6514..7d76fe71b3 100644
--- a/drivers/raw/skeleton/meson.build
+++ b/drivers/raw/skeleton/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright 2018 NXP
 
-deps += ['rawdev', 'kvargs', 'mbuf', 'bus_vdev']
+deps += ['rawdev', 'mbuf', 'bus_vdev']
 sources = files(
         'skeleton_rawdev.c',
         'skeleton_rawdev_test.c',
diff --git a/drivers/regex/cn9k/meson.build b/drivers/regex/cn9k/meson.build
index b22275928a..40aced4c62 100644
--- a/drivers/regex/cn9k/meson.build
+++ b/drivers/regex/cn9k/meson.build
@@ -13,4 +13,4 @@ sources = files(
 )
 
 deps += ['bus_pci']
-deps += ['common_cnxk', 'mempool_cnxk']
+deps += ['mempool_cnxk']
diff --git a/drivers/regex/mlx5/meson.build b/drivers/regex/mlx5/meson.build
index 6070b37501..f75bf2e084 100644
--- a/drivers/regex/mlx5/meson.build
+++ b/drivers/regex/mlx5/meson.build
@@ -7,7 +7,7 @@ if not is_linux
     subdir_done()
 endif
 
-deps += ['common_mlx5', 'eal']
+deps += ['common_mlx5']
 if not dpdk_conf.has('RTE_COMMON_MLX5')
     # avoid referencing undefined variables from common/mlx5
     subdir_done()
diff --git a/drivers/vdpa/ifc/meson.build b/drivers/vdpa/ifc/meson.build
index f78d36a715..f4ed4f491f 100644
--- a/drivers/vdpa/ifc/meson.build
+++ b/drivers/vdpa/ifc/meson.build
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-deps += 'vhost'
+deps += 'bus_pci'
 sources = files('ifcvf_vdpa.c', 'base/ifcvf.c')
 includes += include_directories('base')
diff --git a/drivers/vdpa/meson.build b/drivers/vdpa/meson.build
index e01c277b9e..747cdc7c55 100644
--- a/drivers/vdpa/meson.build
+++ b/drivers/vdpa/meson.build
@@ -11,5 +11,4 @@ drivers = [
         'nfp',
         'sfc',
 ]
-std_deps = ['bus_pci']
-std_deps += ['vhost']
+std_deps = ['vhost']
diff --git a/drivers/vdpa/mlx5/meson.build b/drivers/vdpa/mlx5/meson.build
index 7be11fda6d..46fd09bfb2 100644
--- a/drivers/vdpa/mlx5/meson.build
+++ b/drivers/vdpa/mlx5/meson.build
@@ -7,7 +7,7 @@ if not is_linux
     subdir_done()
 endif
 
-deps += ['hash', 'common_mlx5', 'vhost', 'pci', 'eal', 'sched']
+deps += ['common_mlx5', 'vhost', 'sched']
 if not dpdk_conf.has('RTE_COMMON_MLX5')
     # avoid referencing undefined variables from common/mlx5
     subdir_done()
diff --git a/drivers/vdpa/sfc/meson.build b/drivers/vdpa/sfc/meson.build
index 933f3f18f3..465ca9f220 100644
--- a/drivers/vdpa/sfc/meson.build
+++ b/drivers/vdpa/sfc/meson.build
@@ -16,7 +16,7 @@ foreach flag: extra_flags
     endif
 endforeach
 
-deps += ['common_sfc_efx', 'bus_pci']
+deps += ['common_sfc_efx']
 sources = files(
         'sfc_vdpa.c',
         'sfc_vdpa_hw.c',
-- 
2.43.5

