Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DEC0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FCA3427B3;
	Mon, 10 Feb 2025 17:44:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D87EC4279E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:44:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739205877; x=1770741877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IPaS3wTypPiFY7r+gAvLqQIba77jtICjxJT5rZ5LO5M=;
 b=iX9P/aNhP4WbHVuKfrxVwqa/GXmYWCEL1EA6brJNr770NLXofFVWzYP8
 d6Eli4LAx/sbu7YrlKlCsBw7VQXFdI+tJRu9xfa8CtqfUpvQp9XIbd/ny
 XdjvVRQTjjMEZBctx2WPXVhocSUTYHuwwVwLJaOJ0sXKc0I9CgBzeCDzo
 heqB4hyP8LByp8teBsRC8qGNFZwZa67RmFZS3KE269O3AGH4qq9fLq3hy
 b3zr+W/KyGF7vo8/XnqOoPezFsR9w+xBZ9IB0Jg8Ov/YIQxMq+qLFJ8S2
 y6PBdh3398tCR585mxLKI7zVOMxx9MxaJEzVzDx7aenVMecxLZ8J6onVn w==;
X-CSE-ConnectionGUID: AWEFMpWxQIyFlnALWZoK0Q==
X-CSE-MsgGUID: Zp9iWRtDS0qQa3eG41rVnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43453709"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="43453709"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 08:44:35 -0800
X-CSE-ConnectionGUID: 7YtLPBM2Qjy6IgjdZ7MsWQ==
X-CSE-MsgGUID: 6VfvboilR3K0GN7EpJQJDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="112753335"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa010.fm.intel.com with ESMTP; 10 Feb 2025 08:44:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v5 1/4] drivers: merge common and net idpf drivers
Date: Mon, 10 Feb 2025 16:44:23 +0000
Message-ID: <20250210164427.1118265-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210164427.1118265-1-bruce.richardson@intel.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250210164427.1118265-1-bruce.richardson@intel.com>
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
 doc/guides/rel_notes/release_25_03.rst        |  6 +++
 drivers/common/idpf/meson.build               | 41 -------------------
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
 .../intel}/idpf/idpf_common_rxtx_avx2.c       |  0
 .../intel}/idpf/idpf_common_rxtx_avx512.c     |  0
 .../intel}/idpf/idpf_common_virtchnl.c        |  0
 .../intel}/idpf/idpf_common_virtchnl.h        |  0
 drivers/net/intel/idpf/meson.build            | 31 ++++++++++++--
 .../{common => net/intel}/idpf/version.map    |  0
 drivers/net/meson.build                       |  2 +-
 34 files changed, 37 insertions(+), 47 deletions(-)
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
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx2.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_rxtx_avx512.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.c (100%)
 rename drivers/{common => net/intel}/idpf/idpf_common_virtchnl.h (100%)
 rename drivers/{common => net/intel}/idpf/version.map (100%)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index 9ae1a36c3a..b7daca4841 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -23,6 +23,7 @@
 ; This is not a libabigail rule (see check-abi.sh).
 ; This is used for driver removal and other special cases like mlx glue libs.
 ;
+; SKIP_LIBRARY=librte_common_idpf
 ; SKIP_LIBRARY=librte_common_mlx5_glue
 ; SKIP_LIBRARY=librte_net_mlx4_glue
 ; SKIP_LIBRARY=librte_net_igc
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 0125235fbd..2338a97e76 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -181,6 +181,12 @@ API Changes
   has changed from ``-Denable_drivers=net/igc`` to
   ``-Denable_drivers=net/intel/e1000``.
 
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
index 0a30c7e601..0000000000
--- a/drivers/common/idpf/meson.build
+++ /dev/null
@@ -1,41 +0,0 @@
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
-    idpf_avx2_lib = static_library('idpf_avx2_lib',
-        'idpf_common_rxtx_avx2.c',
-        dependencies: [static_rte_ethdev, static_rte_hash],
-        include_directories: includes,
-        c_args: [cflags, '-mavx2'])
-    objs += idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
-
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
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx_avx2.c
rename to drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
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
index 34cbdc4da0..87bc39f76e 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,13 +7,38 @@ if is_windows
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
-    cflags += ['-DCC_AVX512_SUPPORT']
+if arch_subdir == 'x86'
+    idpf_avx2_lib = static_library('idpf_avx2_lib',
+        'idpf_common_rxtx_avx2.c',
+        dependencies: [static_rte_ethdev, static_rte_hash],
+        include_directories: includes,
+        c_args: [cflags, '-mavx2'])
+    objs += idpf_avx2_lib.extract_objects('idpf_common_rxtx_avx2.c')
+
+    if cc_has_avx512
+        cflags += ['-DCC_AVX512_SUPPORT']
+        avx512_args = cflags + cc_avx512_flags
+        if cc.has_argument('-march=skylake-avx512')
+            avx512_args += '-march=skylake-avx512'
+        endif
+        idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
+                'idpf_common_rxtx_avx512.c',
+                dependencies: static_rte_mbuf,
+                include_directories: includes,
+                c_args: avx512_args)
+        objs += idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
+    endif
 endif
+
+subdir('base')
diff --git a/drivers/common/idpf/version.map b/drivers/net/intel/idpf/version.map
similarity index 100%
rename from drivers/common/idpf/version.map
rename to drivers/net/intel/idpf/version.map
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index cdc3e7e664..460eb69e5b 100644
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
@@ -33,6 +32,7 @@ drivers = [
         'intel/idpf',
         'intel/ipn3ke',
         'intel/ixgbe',
+        'intel/cpfl',  # depends on idpf, so must come after it
         'ionic',
         'mana',
         'memif',
-- 
2.43.0

