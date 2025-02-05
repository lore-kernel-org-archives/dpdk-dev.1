Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E389C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D950C402E5;
	Wed,  5 Feb 2025 12:55:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id A25C9402D0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738756547; x=1770292547;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mx2wLlcrIoWotCTIxMVMwiKB5UquqQ+l+CeGVbkPjRM=;
 b=L0/wJ3DC8qfG6GYUMvnmp5wG+HDCchovrS94VuXCdUmtWCl+5pICeQ9s
 of71effxhllBWXeYlMbVBNjlRk714m92Im6rJGsONOVn5jcuBe280B1T+
 wbR6BKhx9dBE5iCT8mFDJoBPuxLOwxlaxMLdSTasOnpn9OpbjYjjXKmTp
 GR7Q9527PGp0gTAoVyt7zBV+qzREhcB2JKJqf51yfJIphJn84EmjoYunV
 5Daqc5L9lw0otS2k+3/BjrQGjlHNk70Q4O8WNmlgpOTYEOsjSO9hYIEPj
 IlOuSYfCmRs7XZk7GUW1K/jzXKnu3uGNUTJbQ7CyZ/gqy+aOg+j9ycFs1 g==;
X-CSE-ConnectionGUID: MUPkexA+Qs2VsCyyAqfqzw==
X-CSE-MsgGUID: VZMy2CvZReaXgGHLZOM5nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49568719"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49568719"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 03:55:46 -0800
X-CSE-ConnectionGUID: BXLu5mfHQVGkplfQFNcKkw==
X-CSE-MsgGUID: PCtCjMv7Rli3Ki9xCHzsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141781683"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 03:55:44 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, Jingjing Wu <jingjing.wu@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v4 1/4] drivers: merge common and net idpf drivers
Date: Wed,  5 Feb 2025 11:55:28 +0000
Message-ID: <20250205115533.2746196-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205115533.2746196-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250205115533.2746196-1-bruce.richardson@intel.com>
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

Rather than having some of the idpf code split out into the "common"
directory, used by both a net/idpf and a net/cpfl driver, we can
merge all idpf code together under net/idpf and have the cpfl driver
depend on "net/idpf" rather than "common/idpf".

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Praveen Shetty <praveen.shetty@intel.com>
---
 devtools/libabigail.abignore                  |  1 +
 doc/guides/rel_notes/release_25_03.rst        |  6 ++++
 drivers/common/idpf/meson.build               | 34 -------------------
 drivers/common/meson.build                    |  1 -
 drivers/net/intel/cpfl/meson.build            |  2 +-
 .../{common => net/intel}/idpf/base/README    |  0
 .../intel}/idpf/base/idpf_alloc.h             |  0
 .../intel}/idpf/base/idpf_controlq.c          |  0
 .../intel}/idpf/base/idpf_controlq.h          |  0
 .../intel}/idpf/base/idpf_controlq_api.h      |  0
 .../intel}/idpf/base/idpf_controlq_setup.c    |  0
 .../intel}/idpf/base/idpf_devids.h            |  0
 .../intel}/idpf/base/idpf_lan_pf_regs.h       |  0
 .../intel}/idpf/base/idpf_lan_txrx.h          |  0
 .../intel}/idpf/base/idpf_lan_vf_regs.h       |  0
 .../intel}/idpf/base/idpf_osdep.h             |  0
 .../intel}/idpf/base/idpf_prototype.h         |  0
 .../intel}/idpf/base/idpf_type.h              |  0
 .../intel}/idpf/base/meson.build              |  0
 .../intel}/idpf/base/siov_regs.h              |  0
 .../intel}/idpf/base/virtchnl2.h              |  0
 .../intel}/idpf/base/virtchnl2_lan_desc.h     |  0
 .../intel}/idpf/idpf_common_device.c          |  0
 .../intel}/idpf/idpf_common_device.h          |  0
 .../intel}/idpf/idpf_common_logs.h            |  0
 .../intel}/idpf/idpf_common_rxtx.c            |  0
 .../intel}/idpf/idpf_common_rxtx.h            |  0
 .../intel}/idpf/idpf_common_rxtx_avx512.c     |  0
 .../intel}/idpf/idpf_common_virtchnl.c        |  0
 .../intel}/idpf/idpf_common_virtchnl.h        |  0
 drivers/net/intel/idpf/meson.build            | 20 +++++++++--
 .../{common => net/intel}/idpf/version.map    |  0
 drivers/net/meson.build                       |  2 +-
 33 files changed, 27 insertions(+), 39 deletions(-)
 delete mode 100644 drivers/common/idpf/meson.build
 rename drivers/{common => net/intel}/idpf/base/README (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_alloc.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq.c (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq_api.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_controlq_setup.c (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_devids.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_pf_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_txrx.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_lan_vf_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_osdep.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_prototype.h (100%)
 rename drivers/{common => net/intel}/idpf/base/idpf_type.h (100%)
 rename drivers/{common => net/intel}/idpf/base/meson.build (100%)
 rename drivers/{common => net/intel}/idpf/base/siov_regs.h (100%)
 rename drivers/{common => net/intel}/idpf/base/virtchnl2.h (100%)
 rename drivers/{common => net/intel}/idpf/base/virtchnl2_lan_desc.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_device.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_device.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_logs.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx.h (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx512.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.h (100%)
 rename drivers/{common => net/intel}/idpf/version.map (100%)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 21b8cd6113..1dee6a954f 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -25,6 +25,7 @@
 ;
 ; SKIP_LIBRARY=librte_common_mlx5_glue
 ; SKIP_LIBRARY=librte_net_mlx4_glue
+; SKIP_LIBRARY=librte_common_idpf
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Experimental APIs exceptions ;
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index a88b04d958..79b1116f6e 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -115,6 +115,12 @@ API Changes
   but to enable/disable these drivers via Meson option requires use of the new paths.
   For example, ``-Denable_drivers=/net/i40e`` becomes ``-Denable_drivers=/net/intel/i40e``.
 
+* The driver ``common/idpf`` has been merged into the ``net/intel/idpf`` driver.
+  This change should have no impact to end applications, but,
+  when specifying the ``idpf`` or ``cpfl`` net drivers to meson via ``-Denable_drivers`` option,
+  there is no longer any need to also specify the ``common/idpf`` driver.
+  Note, however, ``net/intel/cpfl`` driver now depends upon the ``net/intel/idpf`` driver.
+
 
 ABI Changes
 -----------
diff --git a/drivers/common/idpf/meson.build b/drivers/common/idpf/meson.build
deleted file mode 100644
index 46fd45c03b..0000000000
--- a/drivers/common/idpf/meson.build
+++ /dev/null
@@ -1,34 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2022 Intel Corporation
-
-if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
-    subdir_done()
-endif
-
-includes += include_directories('../iavf')
-
-deps += ['mbuf']
-
-sources = files(
-        'idpf_common_device.c',
-        'idpf_common_rxtx.c',
-        'idpf_common_virtchnl.c',
-)
-
-if arch_subdir == 'x86'
-    if cc_has_avx512
-        cflags += ['-DCC_AVX512_SUPPORT']
-        avx512_args = cflags + cc_avx512_flags
-        if cc.has_argument('-march=skylake-avx512')
-            avx512_args += '-march=skylake-avx512'
-        endif
-        idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
-                'idpf_common_rxtx_avx512.c',
-                dependencies: [static_rte_mbuf,],
-                include_directories: includes,
-                c_args: avx512_args)
-        objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
-    endif
-endif
-
-subdir('base')
diff --git a/drivers/common/meson.build b/drivers/common/meson.build
index 8734af36aa..e1e3149d8f 100644
--- a/drivers/common/meson.build
+++ b/drivers/common/meson.build
@@ -6,7 +6,6 @@ drivers = [
         'cpt',
         'dpaax',
         'iavf',
-        'idpf',
         'ionic',
         'mvep',
         'octeontx',
diff --git a/drivers/net/intel/cpfl/meson.build b/drivers/net/intel/cpfl/meson.build
index 87fcfe0bb1..1f0269d50b 100644
--- a/drivers/net/intel/cpfl/meson.build
+++ b/drivers/net/intel/cpfl/meson.build
@@ -11,7 +11,7 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
     subdir_done()
 endif
 
-deps += ['hash', 'common_idpf']
+deps += ['hash', 'net_idpf']
 
 sources = files(
         'cpfl_ethdev.c',
diff --git a/drivers/common/idpf/base/README b/drivers/net/intel/idpf/base/README
similarity index 100%
rename from drivers/common/idpf/base/README
rename to drivers/net/intel/idpf/base/README
diff --git a/drivers/common/idpf/base/idpf_alloc.h b/drivers/net/intel/idpf/base/idpf_alloc.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_alloc.h
rename to drivers/net/intel/idpf/base/idpf_alloc.h
diff --git a/drivers/common/idpf/base/idpf_controlq.c b/drivers/net/intel/idpf/base/idpf_controlq.c
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq.c
rename to drivers/net/intel/idpf/base/idpf_controlq.c
diff --git a/drivers/common/idpf/base/idpf_controlq.h b/drivers/net/intel/idpf/base/idpf_controlq.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq.h
rename to drivers/net/intel/idpf/base/idpf_controlq.h
diff --git a/drivers/common/idpf/base/idpf_controlq_api.h b/drivers/net/intel/idpf/base/idpf_controlq_api.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq_api.h
rename to drivers/net/intel/idpf/base/idpf_controlq_api.h
diff --git a/drivers/common/idpf/base/idpf_controlq_setup.c b/drivers/net/intel/idpf/base/idpf_controlq_setup.c
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq_setup.c
rename to drivers/net/intel/idpf/base/idpf_controlq_setup.c
diff --git a/drivers/common/idpf/base/idpf_devids.h b/drivers/net/intel/idpf/base/idpf_devids.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_devids.h
rename to drivers/net/intel/idpf/base/idpf_devids.h
diff --git a/drivers/common/idpf/base/idpf_lan_pf_regs.h b/drivers/net/intel/idpf/base/idpf_lan_pf_regs.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_pf_regs.h
rename to drivers/net/intel/idpf/base/idpf_lan_pf_regs.h
diff --git a/drivers/common/idpf/base/idpf_lan_txrx.h b/drivers/net/intel/idpf/base/idpf_lan_txrx.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_txrx.h
rename to drivers/net/intel/idpf/base/idpf_lan_txrx.h
diff --git a/drivers/common/idpf/base/idpf_lan_vf_regs.h b/drivers/net/intel/idpf/base/idpf_lan_vf_regs.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_vf_regs.h
rename to drivers/net/intel/idpf/base/idpf_lan_vf_regs.h
diff --git a/drivers/common/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_osdep.h
rename to drivers/net/intel/idpf/base/idpf_osdep.h
diff --git a/drivers/common/idpf/base/idpf_prototype.h b/drivers/net/intel/idpf/base/idpf_prototype.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_prototype.h
rename to drivers/net/intel/idpf/base/idpf_prototype.h
diff --git a/drivers/common/idpf/base/idpf_type.h b/drivers/net/intel/idpf/base/idpf_type.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_type.h
rename to drivers/net/intel/idpf/base/idpf_type.h
diff --git a/drivers/common/idpf/base/meson.build b/drivers/net/intel/idpf/base/meson.build
similarity index 100%
rename from drivers/common/idpf/base/meson.build
rename to drivers/net/intel/idpf/base/meson.build
diff --git a/drivers/common/idpf/base/siov_regs.h b/drivers/net/intel/idpf/base/siov_regs.h
similarity index 100%
rename from drivers/common/idpf/base/siov_regs.h
rename to drivers/net/intel/idpf/base/siov_regs.h
diff --git a/drivers/common/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
similarity index 100%
rename from drivers/common/idpf/base/virtchnl2.h
rename to drivers/net/intel/idpf/base/virtchnl2.h
diff --git a/drivers/common/idpf/base/virtchnl2_lan_desc.h b/drivers/net/intel/idpf/base/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/common/idpf/base/virtchnl2_lan_desc.h
rename to drivers/net/intel/idpf/base/virtchnl2_lan_desc.h
diff --git a/drivers/common/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_device.c
rename to drivers/net/intel/idpf/idpf_common_device.c
diff --git a/drivers/common/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_device.h
rename to drivers/net/intel/idpf/idpf_common_device.h
diff --git a/drivers/common/idpf/idpf_common_logs.h b/drivers/net/intel/idpf/idpf_common_logs.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_logs.h
rename to drivers/net/intel/idpf/idpf_common_logs.h
diff --git a/drivers/common/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx.c
rename to drivers/net/intel/idpf/idpf_common_rxtx.c
diff --git a/drivers/common/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx.h
rename to drivers/net/intel/idpf/idpf_common_rxtx.h
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx_avx512.c
rename to drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
diff --git a/drivers/common/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_virtchnl.c
rename to drivers/net/intel/idpf/idpf_common_virtchnl.c
diff --git a/drivers/common/idpf/idpf_common_virtchnl.h b/drivers/net/intel/idpf/idpf_common_virtchnl.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_virtchnl.h
rename to drivers/net/intel/idpf/idpf_common_virtchnl.h
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 34cbdc4da0..52405b5b35 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,13 +7,29 @@ if is_windows
     subdir_done()
 endif
 
-deps += ['common_idpf']
+includes += include_directories('../../../common/iavf')
 
 sources = files(
+        'idpf_common_device.c',
+        'idpf_common_rxtx.c',
+        'idpf_common_virtchnl.c',
+
         'idpf_ethdev.c',
         'idpf_rxtx.c',
 )
 
-if arch_subdir == 'x86'and cc_has_avx512
+if arch_subdir == 'x86' and cc_has_avx512
     cflags += ['-DCC_AVX512_SUPPORT']
+    avx512_args = cflags + cc_avx512_flags
+    if cc.has_argument('-march=skylake-avx512')
+        avx512_args += '-march=skylake-avx512'
+    endif
+    idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
+            'idpf_common_rxtx_avx512.c',
+            dependencies: static_rte_mbuf,
+            include_directories: includes,
+            c_args: avx512_args)
+    objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
 endif
+
+subdir('base')
diff --git a/drivers/common/idpf/version.map b/drivers/net/intel/idpf/version.map
similarity index 100%
rename from drivers/common/idpf/version.map
rename to drivers/net/intel/idpf/version.map
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 02a3f5a0b6..bcf6f9dc73 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -24,7 +24,6 @@ drivers = [
         'gve',
         'hinic',
         'hns3',
-        'intel/cpfl',
         'intel/e1000',
         'intel/fm10k',
         'intel/i40e',
@@ -34,6 +33,7 @@ drivers = [
         'intel/igc',
         'intel/ipn3ke',
         'intel/ixgbe',
+        'intel/cpfl',  # depends on idpf, so must come after it
         'ionic',
         'mana',
         'memif',
-- 
2.43.0

