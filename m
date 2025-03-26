Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2864DC36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 15:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E93140696;
	Wed, 26 Mar 2025 16:52:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2027E40689
 for <dev@dpdk.org>; Wed, 26 Mar 2025 16:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743004371; x=1774540371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zM8lpY9d4Cltdy8u8MezUaNnq5/fFHRHzPfGni3JeVs=;
 b=PL1lYj6NaooQKRwilxd3VVeg+FxdfDSsxyd0zv3kcckAwpASXdKJGnfd
 NYKDf33YWxPLhLLrz/v8Ub7NSidXnRA7MlmVddRwy8EJ4XXdUSE65RoKn
 3EaRT+b82aWn7X9odObAHVSFqqTVqhwt5+yD99gJ7yO9FwzfpLLYGInPn
 4lN7YDW4n4MdPXzcALGVkQwBw1O6dCfaz6YQHygQvY+PNvZzzrwI0nEfH
 BraQ6Wi905Qmd8XVrVHZ/0Lqniwxz438xH7DYxtOfn/w6wjZ+hpTSmNqx
 raU8lZwb7igQYr0/K65fejqzIRe4VztMIHsmSMVhI5I3aqnjo8/6dzrQ2 g==;
X-CSE-ConnectionGUID: 0AA9VZEJSRuM5ExcLnTKng==
X-CSE-MsgGUID: 4DK+MUxTRxu7DtEYCiYXnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188331"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="44188331"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 08:52:51 -0700
X-CSE-ConnectionGUID: IQ3VtAFsT9GCoSURJ4x0xQ==
X-CSE-MsgGUID: o6wCKhdnSmCh8qmCii7wkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="124550931"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 08:52:49 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 7/7] net/intel: simplify base code builds
Date: Wed, 26 Mar 2025 15:52:29 +0000
Message-ID: <20250326155230.1315056-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326155230.1315056-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
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

Now that base-code warning flags have been removed from a number of
drivers, we can simplify their build configuration by just including the
base code files in the regular list of driver files passed back. There
is no need to use pre-compiled objects.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/e1000/base/meson.build | 9 ++-------
 drivers/net/intel/e1000/meson.build      | 4 ++--
 drivers/net/intel/fm10k/base/meson.build | 9 ++-------
 drivers/net/intel/fm10k/meson.build      | 4 ++--
 drivers/net/intel/i40e/base/meson.build  | 9 ++-------
 drivers/net/intel/i40e/meson.build       | 4 ++--
 drivers/net/intel/idpf/base/meson.build  | 2 +-
 drivers/net/intel/idpf/meson.build       | 7 ++++---
 drivers/net/intel/ixgbe/base/meson.build | 9 ++-------
 drivers/net/intel/ixgbe/meson.build      | 4 ++--
 10 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
index 8cbd9f62e6..4fe86dc6df 100644
--- a/drivers/net/intel/e1000/base/meson.build
+++ b/drivers/net/intel/e1000/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = [
+base_sources = files(
         'e1000_base.c',
         'e1000_80003es2lan.c',
         'e1000_82540.c',
@@ -21,9 +21,4 @@ sources = [
         'e1000_osdep.c',
         'e1000_phy.c',
         'e1000_vf.c',
-]
-
-base_lib = static_library('e1000_base', sources,
-    dependencies: static_rte_eal,
-    c_args: cflags)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index cd42c0042a..b52a843228 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -2,9 +2,9 @@
 # Copyright(c) 2017 Intel Corporation
 
 subdir('base')
-objs = [base_objs]
 
-sources = files(
+sources += base_sources
+sources += files(
         'e1000_logs.c',
         'em_ethdev.c',
         'em_rxtx.c',
diff --git a/drivers/net/intel/fm10k/base/meson.build b/drivers/net/intel/fm10k/base/meson.build
index a2640d1ee8..c45b31d6b2 100644
--- a/drivers/net/intel/fm10k/base/meson.build
+++ b/drivers/net/intel/fm10k/base/meson.build
@@ -1,16 +1,11 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = [
+base_sources = files(
         'fm10k_api.c',
         'fm10k_common.c',
         'fm10k_mbx.c',
         'fm10k_pf.c',
         'fm10k_tlv.c',
         'fm10k_vf.c',
-]
-
-base_lib = static_library('fm10k_base', sources,
-    dependencies: static_rte_eal,
-    c_args: cflags)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/net/intel/fm10k/meson.build b/drivers/net/intel/fm10k/meson.build
index 69566add96..e08a00cb49 100644
--- a/drivers/net/intel/fm10k/meson.build
+++ b/drivers/net/intel/fm10k/meson.build
@@ -8,9 +8,9 @@ if is_windows
 endif
 
 subdir('base')
-objs = [base_objs]
 
-sources = files(
+sources += base_sources
+sources += files(
         'fm10k_ethdev.c',
         'fm10k_rxtx.c',
 )
diff --git a/drivers/net/intel/i40e/base/meson.build b/drivers/net/intel/i40e/base/meson.build
index 766383101b..7b4882ad1d 100644
--- a/drivers/net/intel/i40e/base/meson.build
+++ b/drivers/net/intel/i40e/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2020 Intel Corporation
 
-sources = [
+base_sources = files(
         'i40e_adminq.c',
         'i40e_common.c',
         'i40e_dcb.c',
@@ -9,9 +9,4 @@ sources = [
         'i40e_hmc.c',
         'i40e_lan_hmc.c',
         'i40e_nvm.c',
-]
-
-base_lib = static_library('i40e_base', sources,
-    dependencies: static_rte_eal,
-    c_args: cflags)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 15993393fb..17b6715cd9 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -18,9 +18,9 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
 endif
 
 subdir('base')
-objs = [base_objs]
 
-sources = files(
+sources += base_sources
+sources += files(
         'i40e_ethdev.c',
         'i40e_rxtx.c',
         'i40e_pf.c',
diff --git a/drivers/net/intel/idpf/base/meson.build b/drivers/net/intel/idpf/base/meson.build
index 7316e0a805..78782e463e 100644
--- a/drivers/net/intel/idpf/base/meson.build
+++ b/drivers/net/intel/idpf/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2023 Intel Corporation
 
-sources += files(
+base_sources = files(
         'idpf_controlq.c',
         'idpf_controlq_setup.c',
 )
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 4b272d02b1..a8690da87b 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,9 +7,12 @@ if is_windows
     subdir_done()
 endif
 
+subdir('base')
+
 includes += include_directories('../iavf/base')
 
-sources = files(
+sources += base_sources
+sources += files(
         'idpf_common_device.c',
         'idpf_common_rxtx.c',
         'idpf_common_virtchnl.c',
@@ -43,5 +46,3 @@ if arch_subdir == 'x86' and dpdk_conf.get('RTE_IOVA_IN_MBUF') == 1
         objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
     endif
 endif
-
-subdir('base')
diff --git a/drivers/net/intel/ixgbe/base/meson.build b/drivers/net/intel/ixgbe/base/meson.build
index 64e0bfd7be..df42a34369 100644
--- a/drivers/net/intel/ixgbe/base/meson.build
+++ b/drivers/net/intel/ixgbe/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017-2024 Intel Corporation
 
-sources = [
+base_sources = files(
         'ixgbe_82598.c',
         'ixgbe_82599.c',
         'ixgbe_api.c',
@@ -17,9 +17,4 @@ sources = [
         'ixgbe_vf.c',
         'ixgbe_x540.c',
         'ixgbe_x550.c',
-]
-
-base_lib = static_library('ixgbe_base', sources,
-    dependencies: [static_rte_eal, static_rte_net],
-    c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 0bee736a2c..23f5a6cb3e 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -4,9 +4,9 @@
 cflags += ['-DRTE_LIBRTE_IXGBE_BYPASS']
 
 subdir('base')
-objs = [base_objs]
 
-sources = files(
+sources += base_sources
+sources += files(
         'ixgbe_82599_bypass.c',
         'ixgbe_bypass.c',
         'ixgbe_ethdev.c',
-- 
2.45.2

