Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E8C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8AF7427AC;
	Mon, 10 Feb 2025 17:44:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 42755427B0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739205879; x=1770741879;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eoaMGrPzJrH4X0Z/H2iY219bBxx02KiMDfSXL9xDkkA=;
 b=gw6d5i69gYmzcpBBL5GQc6aDkJJRbdCOKlXcZrtsweHIyO+qQelqYg4S
 isOT8YxdsXK24FG8e3c3fWAUziSzzeXpKB0138B3Z4u3cHg1TOX1tkG/o
 9y5LxFf+dbs3oqveu8ibMWRm7ZZ+YbC7tz/eBd827xYzXhOD4iODJCJec
 DImpHdSy5tRbDHd7jFJhCXRCE3yb2nHwcOM1vjOeWxFBmAgOy/NfTT+Ls
 csgqLaJk3HUiq6vgPzuE4BZi+lsCrmd+4I84XaZD+LaH4aKctEBGS3Me2
 mNri0f33utEWwSeSxA5gt0eQUMBBNRw1vgLX3RaAUtN5V4omeBs8dBhPB w==;
X-CSE-ConnectionGUID: 0XrR9TIXQneamOS2ZHREUA==
X-CSE-MsgGUID: L8PF0A0RSiKS3RrebMcJvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="43453711"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="43453711"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 08:44:38 -0800
X-CSE-ConnectionGUID: 3AJse1fnRQqFI8P/nfadxA==
X-CSE-MsgGUID: p28koJ7tQtKtD8P0jr6vuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="112753357"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa010.fm.intel.com with ESMTP; 10 Feb 2025 08:44:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 3/4] drivers: move iavf common folder to iavf net
Date: Mon, 10 Feb 2025 16:44:25 +0000
Message-ID: <20250210164427.1118265-4-bruce.richardson@intel.com>
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

The common/iavf driver folder contains the base code for the iavf
driver, which is also linked against by the ice driver and others.
However, there is no need for this to be in common, and we can
move it to the net/intel/iavf as a base code driver. This involves
updating dependencies that were on common/iavf to net/iavf

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/libabigail.abignore                       |  1 +
 doc/guides/rel_notes/release_25_03.rst             |  5 ++++-
 drivers/common/iavf/version.map                    | 13 -------------
 drivers/common/meson.build                         |  1 -
 .../{common/iavf => net/intel/iavf/base}/README    |  0
 .../iavf => net/intel/iavf/base}/iavf_adminq.c     |  0
 .../iavf => net/intel/iavf/base}/iavf_adminq.h     |  0
 .../iavf => net/intel/iavf/base}/iavf_adminq_cmd.h |  0
 .../iavf => net/intel/iavf/base}/iavf_alloc.h      |  0
 .../iavf => net/intel/iavf/base}/iavf_common.c     |  0
 .../iavf => net/intel/iavf/base}/iavf_devids.h     |  0
 .../iavf => net/intel/iavf/base}/iavf_impl.c       |  0
 .../iavf => net/intel/iavf/base}/iavf_osdep.h      |  0
 .../iavf => net/intel/iavf/base}/iavf_prototype.h  |  0
 .../iavf => net/intel/iavf/base}/iavf_register.h   |  0
 .../iavf => net/intel/iavf/base}/iavf_status.h     |  0
 .../iavf => net/intel/iavf/base}/iavf_type.h       |  0
 .../iavf => net/intel/iavf/base}/meson.build       |  0
 .../iavf => net/intel/iavf/base}/virtchnl.h        |  0
 .../intel/iavf/base}/virtchnl_inline_ipsec.h       |  0
 drivers/net/intel/iavf/meson.build                 | 13 +++++++++----
 drivers/net/intel/iavf/version.map                 | 14 ++++++++++++++
 drivers/net/intel/ice/meson.build                  |  7 +++----
 drivers/net/intel/idpf/meson.build                 |  2 +-
 24 files changed, 32 insertions(+), 24 deletions(-)
 delete mode 100644 drivers/common/iavf/version.map
 rename drivers/{common/iavf => net/intel/iavf/base}/README (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_adminq_cmd.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_alloc.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_common.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_devids.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_impl.c (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_osdep.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_prototype.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_register.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_status.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/iavf_type.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/meson.build (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/virtchnl.h (100%)
 rename drivers/{common/iavf => net/intel/iavf/base}/virtchnl_inline_ipsec.h (100%)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore
index b7daca4841..ce501632b3 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -23,6 +23,7 @@
 ; This is not a libabigail rule (see check-abi.sh).
 ; This is used for driver removal and other special cases like mlx glue libs.
 ;
+; SKIP_LIBRARY=librte_common_iavf
 ; SKIP_LIBRARY=librte_common_idpf
 ; SKIP_LIBRARY=librte_common_mlx5_glue
 ; SKIP_LIBRARY=librte_net_mlx4_glue
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 2338a97e76..d2e8b03107 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -182,9 +182,12 @@ API Changes
   ``-Denable_drivers=net/intel/e1000``.
 
 * The driver ``common/idpf`` has been merged into the ``net/intel/idpf`` driver.
-  This change should have no impact to end applications, but,
+  Similarly, the ``common/iavf`` driver has been merged into the ``net/intel/iavf`` driver.
+  These changes should have no impact to end applications, but,
   when specifying the ``idpf`` or ``cpfl`` net drivers to meson via ``-Denable_drivers`` option,
   there is no longer any need to also specify the ``common/idpf`` driver.
+  In the same way, when specifying the ``iavf`` or ``ice`` net drivers,
+  there is no need to also specify the ``common/iavf`` driver.
   Note, however, ``net/intel/cpfl`` driver now depends upon the ``net/intel/idpf`` driver.
 
 
diff --git a/drivers/common/iavf/version.map b/drivers/common/iavf/version.map
deleted file mode 100644
index 6c1427cca4..0000000000
--- a/drivers/common/iavf/version.map
+++ /dev/null
@@ -1,13 +0,0 @@
-INTERNAL {
-	global:
-
-	iavf_aq_send_msg_to_pf;
-	iavf_clean_arq_element;
-	iavf_init_adminq;
-	iavf_set_mac_type;
-	iavf_shutdown_adminq;
-	iavf_vf_parse_hw_config;
-	iavf_vf_reset;
-
-	local: *;
-};
diff --git a/drivers/common/meson.build b/drivers/common/meson.build
index e1e3149d8f..dc096aab0a 100644
--- a/drivers/common/meson.build
+++ b/drivers/common/meson.build
@@ -5,7 +5,6 @@ std_deps = ['eal']
 drivers = [
         'cpt',
         'dpaax',
-        'iavf',
         'ionic',
         'mvep',
         'octeontx',
diff --git a/drivers/common/iavf/README b/drivers/net/intel/iavf/base/README
similarity index 100%
rename from drivers/common/iavf/README
rename to drivers/net/intel/iavf/base/README
diff --git a/drivers/common/iavf/iavf_adminq.c b/drivers/net/intel/iavf/base/iavf_adminq.c
similarity index 100%
rename from drivers/common/iavf/iavf_adminq.c
rename to drivers/net/intel/iavf/base/iavf_adminq.c
diff --git a/drivers/common/iavf/iavf_adminq.h b/drivers/net/intel/iavf/base/iavf_adminq.h
similarity index 100%
rename from drivers/common/iavf/iavf_adminq.h
rename to drivers/net/intel/iavf/base/iavf_adminq.h
diff --git a/drivers/common/iavf/iavf_adminq_cmd.h b/drivers/net/intel/iavf/base/iavf_adminq_cmd.h
similarity index 100%
rename from drivers/common/iavf/iavf_adminq_cmd.h
rename to drivers/net/intel/iavf/base/iavf_adminq_cmd.h
diff --git a/drivers/common/iavf/iavf_alloc.h b/drivers/net/intel/iavf/base/iavf_alloc.h
similarity index 100%
rename from drivers/common/iavf/iavf_alloc.h
rename to drivers/net/intel/iavf/base/iavf_alloc.h
diff --git a/drivers/common/iavf/iavf_common.c b/drivers/net/intel/iavf/base/iavf_common.c
similarity index 100%
rename from drivers/common/iavf/iavf_common.c
rename to drivers/net/intel/iavf/base/iavf_common.c
diff --git a/drivers/common/iavf/iavf_devids.h b/drivers/net/intel/iavf/base/iavf_devids.h
similarity index 100%
rename from drivers/common/iavf/iavf_devids.h
rename to drivers/net/intel/iavf/base/iavf_devids.h
diff --git a/drivers/common/iavf/iavf_impl.c b/drivers/net/intel/iavf/base/iavf_impl.c
similarity index 100%
rename from drivers/common/iavf/iavf_impl.c
rename to drivers/net/intel/iavf/base/iavf_impl.c
diff --git a/drivers/common/iavf/iavf_osdep.h b/drivers/net/intel/iavf/base/iavf_osdep.h
similarity index 100%
rename from drivers/common/iavf/iavf_osdep.h
rename to drivers/net/intel/iavf/base/iavf_osdep.h
diff --git a/drivers/common/iavf/iavf_prototype.h b/drivers/net/intel/iavf/base/iavf_prototype.h
similarity index 100%
rename from drivers/common/iavf/iavf_prototype.h
rename to drivers/net/intel/iavf/base/iavf_prototype.h
diff --git a/drivers/common/iavf/iavf_register.h b/drivers/net/intel/iavf/base/iavf_register.h
similarity index 100%
rename from drivers/common/iavf/iavf_register.h
rename to drivers/net/intel/iavf/base/iavf_register.h
diff --git a/drivers/common/iavf/iavf_status.h b/drivers/net/intel/iavf/base/iavf_status.h
similarity index 100%
rename from drivers/common/iavf/iavf_status.h
rename to drivers/net/intel/iavf/base/iavf_status.h
diff --git a/drivers/common/iavf/iavf_type.h b/drivers/net/intel/iavf/base/iavf_type.h
similarity index 100%
rename from drivers/common/iavf/iavf_type.h
rename to drivers/net/intel/iavf/base/iavf_type.h
diff --git a/drivers/common/iavf/meson.build b/drivers/net/intel/iavf/base/meson.build
similarity index 100%
rename from drivers/common/iavf/meson.build
rename to drivers/net/intel/iavf/base/meson.build
diff --git a/drivers/common/iavf/virtchnl.h b/drivers/net/intel/iavf/base/virtchnl.h
similarity index 100%
rename from drivers/common/iavf/virtchnl.h
rename to drivers/net/intel/iavf/base/virtchnl.h
diff --git a/drivers/common/iavf/virtchnl_inline_ipsec.h b/drivers/net/intel/iavf/base/virtchnl_inline_ipsec.h
similarity index 100%
rename from drivers/common/iavf/virtchnl_inline_ipsec.h
rename to drivers/net/intel/iavf/base/virtchnl_inline_ipsec.h
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index d9b605f55a..c823d618e3 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -7,9 +7,13 @@ endif
 
 testpmd_sources = files('iavf_testpmd.c')
 
-deps += ['common_iavf', 'security', 'cryptodev']
+deps += ['security', 'cryptodev']
 
 sources = files(
+        'base/iavf_adminq.c',
+        'base/iavf_common.c',
+        'base/iavf_impl.c',
+
         'iavf_ethdev.c',
         'iavf_rxtx.c',
         'iavf_vchnl.c',
@@ -20,8 +24,9 @@ sources = files(
         'iavf_ipsec_crypto.c',
         'iavf_fsub.c',
 )
+includes += include_directories('base')
 
-if arch_subdir == 'x86' and is_variable('static_rte_common_iavf')
+if arch_subdir == 'x86'
     sources += files('iavf_rxtx_vec_sse.c')
 
     if is_windows and cc.get_id() != 'clang'
@@ -30,7 +35,7 @@ if arch_subdir == 'x86' and is_variable('static_rte_common_iavf')
 
     iavf_avx2_lib = static_library('iavf_avx2_lib',
             'iavf_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev, static_rte_common_iavf],
+            dependencies: [static_rte_ethdev],
             include_directories: includes,
             c_args: [cflags, '-mavx2'])
     objs += iavf_avx2_lib.extract_objects('iavf_rxtx_vec_avx2.c')
@@ -43,7 +48,7 @@ if arch_subdir == 'x86' and is_variable('static_rte_common_iavf')
         endif
         iavf_avx512_lib = static_library('iavf_avx512_lib',
                 'iavf_rxtx_vec_avx512.c',
-                dependencies: [static_rte_ethdev, static_rte_common_iavf],
+                dependencies: [static_rte_ethdev],
                 include_directories: includes,
                 c_args: avx512_args)
         objs += iavf_avx512_lib.extract_objects('iavf_rxtx_vec_avx512.c')
diff --git a/drivers/net/intel/iavf/version.map b/drivers/net/intel/iavf/version.map
index 98de64cca2..d18dea64dd 100644
--- a/drivers/net/intel/iavf/version.map
+++ b/drivers/net/intel/iavf/version.map
@@ -17,3 +17,17 @@ EXPERIMENTAL {
 	# added in 21.11
 	rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 };
+
+INTERNAL {
+	global:
+
+	iavf_aq_send_msg_to_pf;
+	iavf_clean_arq_element;
+	iavf_init_adminq;
+	iavf_set_mac_type;
+	iavf_shutdown_adminq;
+	iavf_vf_parse_hw_config;
+	iavf_vf_reset;
+
+	local: *;
+};
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index beaf21e176..5faf887386 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -18,7 +18,7 @@ sources = files(
 
 testpmd_sources = files('ice_testpmd.c')
 
-deps += ['hash', 'net', 'common_iavf']
+deps += ['hash', 'net', 'net_iavf']
 includes += include_directories('base')
 
 if arch_subdir == 'x86'
@@ -30,7 +30,7 @@ if arch_subdir == 'x86'
 
     ice_avx2_lib = static_library('ice_avx2_lib',
             'ice_rxtx_vec_avx2.c',
-            dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
+            dependencies: [static_rte_ethdev, static_rte_hash],
             include_directories: includes,
             c_args: [cflags, '-mavx2'])
     objs += ice_avx2_lib.extract_objects('ice_rxtx_vec_avx2.c')
@@ -43,8 +43,7 @@ if arch_subdir == 'x86'
         endif
         ice_avx512_lib = static_library('ice_avx512_lib',
                 'ice_rxtx_vec_avx512.c',
-                dependencies: [static_rte_ethdev,
-                    static_rte_kvargs, static_rte_hash],
+                dependencies: [static_rte_ethdev, static_rte_hash],
                 include_directories: includes,
                 c_args: avx512_args)
         objs += ice_avx512_lib.extract_objects('ice_rxtx_vec_avx512.c')
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 87bc39f76e..d69254484b 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,7 +7,7 @@ if is_windows
     subdir_done()
 endif
 
-includes += include_directories('../../../common/iavf')
+includes += include_directories('../iavf/base')
 
 sources = files(
         'idpf_common_device.c',
-- 
2.43.0

