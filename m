Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B5C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 11:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8839E402F2;
	Wed,  5 Feb 2025 12:55:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 1D04440654
 for <dev@dpdk.org>; Wed,  5 Feb 2025 12:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738756553; x=1770292553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kWit+9gA9VTZ0sJttj52PIMDZxVhC+/fiaBng0bc0p4=;
 b=KU+4hCpZpHfpq0lD6lzBsP4LcAe5CARCJOOmf6mcxh7yV1z7OrXTxOPE
 OXliyro62sYNF2yirFbDjiJ6YMrik5fSjPz20I32lhDSCw/jCRbooM7xN
 iGm5aZkjZkhJzcsvvXSsF/AKQNeWyNn0AbgVJE9uwJ3uLxW7SeoIm+ONa
 dPo65IL228Q48uVxz0fDD4S1OtDxAgG8tsP75u/E7Rc0PgDuIsXreTTPA
 F+1T3Kv8m28GEG9LhGNnny6F4v5+eSNjEfr9Dvg0AmfETzKvRMD5jm5R2
 9AxTRMevxlKYyaQZ341b/8kGneQAgWPu9sWxC0LL6/buPae85DAO8ZB3U Q==;
X-CSE-ConnectionGUID: CUB3Lb+EQBGtxPFVdRe3Dg==
X-CSE-MsgGUID: EN5SA4jeTgWJ8KqgJH48yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49568733"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; d="scan'208";a="49568733"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 03:55:52 -0800
X-CSE-ConnectionGUID: 2UX3qPJOR6yYVsgmVYkjgQ==
X-CSE-MsgGUID: JMv52FwITgaSlDStO3kOvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="141781724"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 05 Feb 2025 03:55:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH v4 3/4] drivers: move iavf common folder to iavf net
Date: Wed,  5 Feb 2025 11:55:30 +0000
Message-ID: <20250205115533.2746196-4-bruce.richardson@intel.com>
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
index 1dee6a954f..4d7079abbc 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -26,6 +26,7 @@
 ; SKIP_LIBRARY=librte_common_mlx5_glue
 ; SKIP_LIBRARY=librte_net_mlx4_glue
 ; SKIP_LIBRARY=librte_common_idpf
+; SKIP_LIBRARY=librte_common_iavf
 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Experimental APIs exceptions ;
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 79b1116f6e..1f22efa79f 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -116,9 +116,12 @@ API Changes
   For example, ``-Denable_drivers=/net/i40e`` becomes ``-Denable_drivers=/net/intel/i40e``.
 
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
index 52405b5b35..e4559bf861 100644
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

