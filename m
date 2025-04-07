Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CBEC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E58E940BA5;
	Mon,  7 Apr 2025 17:25:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A303840B8F
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039520; x=1775575520;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4lBMnhVn6bnnHIxlfafxaKZLmc+b9IXDuETamZ7EoyU=;
 b=TtNzHe2TQKVmuFXe9dCXQmKwfoZcjAqIoLoBp6CbVXLRugnKM8Yws4f4
 115AwB8O02LDXQKy8d2A8atWQwyyNGYjFq89++wM/s7A5ObdV89BNKESD
 s53scCFdKChFofWVJrvBu7sfSlVCk1IIM1amiFtAiIDLxzK5aePSqhVnv
 zHjFiigAh9KU9AymkTA5f3lTIJ+hka451MMj4eHumlDr+yUUZXj8/ZwyP
 fc0Rv82SVTxUHCcJVaA1SLRKHLpgttvY7NqAUtXK5oWixc6Jdjz2APPq/
 U6sqS8IrTm4ycF4fgVEGJZophW1G45xFGqRbEAz0I3H9kG1unQsdF/sv4 A==;
X-CSE-ConnectionGUID: FfadXbQCQWi/i2bG1dIQZg==
X-CSE-MsgGUID: cC77iLxVQbmO8pBC1UGDnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809368"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:19 -0700
X-CSE-ConnectionGUID: 4zmLI43jQQS7fmk8cEU+gQ==
X-CSE-MsgGUID: s6xUljZSTCqZv23ejOLaoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125576"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 04/10] net/intel: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:03 +0100
Message-ID: <20250407152509.2203243-5-bruce.richardson@intel.com>
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
rather than re-implementing it in the drivers.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/e1000/meson.build    |  3 ---
 drivers/net/intel/fm10k/meson.build    |  3 ---
 drivers/net/intel/i40e/meson.build     |  2 --
 drivers/net/intel/iavf/meson.build     |  1 -
 drivers/net/intel/ice/base/meson.build | 13 +++----------
 drivers/net/intel/ice/meson.build      |  2 --
 drivers/net/intel/idpf/meson.build     |  1 -
 drivers/net/intel/ixgbe/meson.build    |  3 ---
 8 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index b52a843228..924fe4ecae 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -3,7 +3,6 @@
 
 subdir('base')
 
-sources += base_sources
 sources += files(
         'e1000_logs.c',
         'em_ethdev.c',
@@ -24,5 +23,3 @@ if not is_windows
                 'igc_txrx.c',
         )
 endif
-
-includes += include_directories('base')
diff --git a/drivers/net/intel/fm10k/meson.build b/drivers/net/intel/fm10k/meson.build
index e08a00cb49..fac4750f8d 100644
--- a/drivers/net/intel/fm10k/meson.build
+++ b/drivers/net/intel/fm10k/meson.build
@@ -9,7 +9,6 @@ endif
 
 subdir('base')
 
-sources += base_sources
 sources += files(
         'fm10k_ethdev.c',
         'fm10k_rxtx.c',
@@ -17,5 +16,3 @@ sources += files(
 if arch_subdir == 'x86'
     sources += files('fm10k_rxtx_vec.c')
 endif
-
-includes += include_directories('base')
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 720706ff1e..49e7f899e6 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -19,7 +19,6 @@ endif
 
 subdir('base')
 
-sources += base_sources
 sources += files(
         'i40e_ethdev.c',
         'i40e_rxtx.c',
@@ -36,7 +35,6 @@ sources += files(
 testpmd_sources = files('i40e_testpmd.c')
 
 deps += ['hash']
-includes += include_directories('base')
 
 if arch_subdir == 'x86'
     sources += files('i40e_rxtx_vec_sse.c')
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index 7e03881529..3b1da8a796 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -24,7 +24,6 @@ sources = files(
         'iavf_ipsec_crypto.c',
         'iavf_fsub.c',
 )
-includes += include_directories('base')
 
 if arch_subdir == 'x86'
     sources += files('iavf_rxtx_vec_sse.c')
diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
index e7ba9c34bc..f46dbb265f 100644
--- a/drivers/net/intel/ice/base/meson.build
+++ b/drivers/net/intel/ice/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018-2021 Intel Corporation
 
-sources = [
+base_sources = files(
         'ice_controlq.c',
         'ice_common.c',
         'ice_sched.c',
@@ -29,7 +29,7 @@ sources = [
         'ice_ddp.c',
         'ice_fwlog.c',
         'ice_vf_mbx.c',
-]
+)
 
 if is_ms_compiler
     error_cflags = [
@@ -48,15 +48,8 @@ if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
     error_cflags += ['-Wno-array-bounds']
 endif
 
-c_args = cflags
-
 foreach flag: error_cflags
     if cc.has_argument(flag)
-        c_args += flag
+        base_cflags += flag
     endif
 endforeach
-
-base_lib = static_library('ice_base', sources,
-        dependencies: static_rte_eal,
-        c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 70ec746e50..8a20d0f297 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -2,7 +2,6 @@
 # Copyright(c) 2018 Intel Corporation
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'ice_acl_filter.c',
@@ -19,7 +18,6 @@ sources = files(
 testpmd_sources = files('ice_testpmd.c')
 
 deps += ['hash', 'net']
-includes += include_directories('base')
 
 if dpdk_conf.has('RTE_NET_IAVF')
     deps += 'net_iavf'
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 44e59c6910..a805d02ea2 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -11,7 +11,6 @@ subdir('base')
 
 includes += include_directories('../iavf/base')
 
-sources += base_sources
 sources += files(
         'idpf_common_device.c',
         'idpf_common_rxtx.c',
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 23f5a6cb3e..d1122bb9cd 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -5,7 +5,6 @@ cflags += ['-DRTE_LIBRTE_IXGBE_BYPASS']
 
 subdir('base')
 
-sources += base_sources
 sources += files(
         'ixgbe_82599_bypass.c',
         'ixgbe_bypass.c',
@@ -32,6 +31,4 @@ elif arch_subdir == 'arm'
     sources += files('ixgbe_recycle_mbufs_vec_common.c')
 endif
 
-includes += include_directories('base')
-
 headers = files('rte_pmd_ixgbe.h')
-- 
2.45.2

