Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC343C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78D0340E11;
	Mon,  7 Apr 2025 17:25:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 36CB640DCD
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039525; x=1775575525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r2zi+VzD/V5Y5z4DXB3PtYIIZKia/VyKchbH9SKG97s=;
 b=OlGHe/kYyfYrxMsl9UlDSuy/9CVU86EmsUfEea7R4EeEB9K88YudbYKa
 lb6mlv2geGtaxmgwdALt17e32Lg8P5zI8H12ATY1oGZ1K24wK4/KEtFKW
 11Hn/dWa69f/92tPElVocBSw2qDlQi7vKz8egO8G23RmT0qTbwfyU8601
 q4+R+HJ1Rwp2OozmddkunsNr0ncKJ+gJ0Mlpw7erYAo79xvvqwovcOIVY
 r4NTqFHardUyaYrvXxM0JliL5MYawpzBglwGt9a1JwM1MCmZ+S/wWUIaz
 syfZdC3xVYiQ4LUWUd/eLR2euUuhseuceOIPV01rPSbnjr4u92wPSGiyy w==;
X-CSE-ConnectionGUID: P8R3beOGTOW2rKT/SYSI/Q==
X-CSE-MsgGUID: 0xGChnZfQ0CHOLZfEz4g2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809377"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809377"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:25 -0700
X-CSE-ConnectionGUID: mv3g3u7MT6q54Dvj3PBH2A==
X-CSE-MsgGUID: Kx9GwXcwTxm2BtjTVU6Buw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125596"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH v2 10/10] raw/ifpga: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:09 +0100
Message-ID: <20250407152509.2203243-11-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250407152509.2203243-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250407152509.2203243-1-bruce.richardson@intel.com>
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

Use the base code build handling logic in the drivers/meson.build file,
rather than re-implementing it in the driver itself.

While making changes similar to that in other drivers, also move content
around dependencies from the base/meson.build file to the main
driver meson.build file, so that the base code file only contains the
list of base code files.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Rosen Xu <rosen.xu@altera.com>
---
 drivers/raw/ifpga/base/meson.build | 21 ++-------------------
 drivers/raw/ifpga/meson.build      | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/raw/ifpga/base/meson.build b/drivers/raw/ifpga/base/meson.build
index 2de8e7ea22..efebff94e9 100644
--- a/drivers/raw/ifpga/base/meson.build
+++ b/drivers/raw/ifpga/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-sources = [
+base_sources = files(
         'ifpga_api.c',
         'ifpga_enumerate.c',
         'ifpga_feature_dev.c',
@@ -23,21 +23,4 @@ sources = [
         'opae_i2c.c',
         'opae_at24_eeprom.c',
         'opae_eth_group.c',
-]
-
-rtdep = dependency('librt', required: false)
-if not rtdep.found()
-    rtdep = cc.find_library('rt', required: false)
-endif
-if not rtdep.found()
-    build = false
-    reason = 'missing dependency, "librt"'
-    subdir_done()
-endif
-
-ext_deps += rtdep
-
-base_lib = static_library('ifpga_rawdev_base', sources,
-    dependencies: static_rte_eal,
-    c_args: cflags)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/raw/ifpga/meson.build b/drivers/raw/ifpga/meson.build
index 444799cfb2..4295ec04bd 100644
--- a/drivers/raw/ifpga/meson.build
+++ b/drivers/raw/ifpga/meson.build
@@ -7,8 +7,19 @@ if not has_libfdt
     subdir_done()
 endif
 
+rtdep = dependency('librt', required: false)
+if not rtdep.found()
+    rtdep = cc.find_library('rt', required: false)
+endif
+if not rtdep.found()
+    build = false
+    reason = 'missing dependency, "librt"'
+    subdir_done()
+endif
+
+ext_deps += rtdep
+
 subdir('base')
-objs = [base_objs]
 
 deps += ['ethdev', 'rawdev', 'pci', 'bus_pci', 'kvargs',
     'bus_vdev', 'bus_ifpga', 'net', 'net_i40e', 'net_ipn3ke']
@@ -17,6 +28,4 @@ sources = files('ifpga_rawdev.c', 'rte_pmd_ifpga.c', 'afu_pmd_core.c',
     'afu_pmd_n3000.c', 'afu_pmd_he_lpbk.c', 'afu_pmd_he_mem.c',
     'afu_pmd_he_hssi.c')
 
-includes += include_directories('base')
-
 headers = files('rte_pmd_ifpga.h')
-- 
2.45.2

