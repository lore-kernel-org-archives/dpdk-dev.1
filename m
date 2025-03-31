Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D357CC36010
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9218340A6F;
	Mon, 31 Mar 2025 18:11:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id EF66340A6F
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437471; x=1774973471;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0y5GaicwpQ24NpGp9B8d1kAygMg8gwE8M7YHwu5cfOg=;
 b=XfzJdv5X0jWkDNkt4fGVoE5gMHVuBXre1mYjvLaDH55OvIOr6AHHU6ow
 v2JI0XU+lE+vAgggAOFRjQRteAke+iYZIRqbnE332W7iKsATvPEgt6/on
 4g3Fi6LlVoWGFncOS0OFDao8jyFveBzDvgoSpvm9MCh/VDwTkYHf3VUBv
 IioiCAM4q/+4IGbWHgKjJq/movwETGo2D2hWdkd3dJC2ICy3GM95BiR3c
 8L0eWZjF/V6Q/Bd0wTfk2I3ghwTot5efzk4oDxVlTDZ18hZHatWOWfqdq
 HO0uut6looIy/uajX16F2WGzwbGTU8ReNrPAWTMvZXcRyFD1uqGG681MR g==;
X-CSE-ConnectionGUID: CODbPPidTcK2aKkWXwdSKw==
X-CSE-MsgGUID: 1NjjCjTpRQyga9a3NdeTgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125782"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:11:05 -0700
X-CSE-ConnectionGUID: qaASNJycRh6IbEwfPXwW5Q==
X-CSE-MsgGUID: KKCjw6spSdKd0tTgGH8X+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132907"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:59 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH 10/10] raw/ifpga: use common base code build handling
Date: Mon, 31 Mar 2025 17:10:00 +0100
Message-ID: <20250331161000.9886-12-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

