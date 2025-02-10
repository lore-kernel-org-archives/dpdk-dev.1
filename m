Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55218C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 17:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CA7F427C5;
	Mon, 10 Feb 2025 18:20:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BA2E1427C4;
 Mon, 10 Feb 2025 18:20:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739208008; x=1770744008;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ez9I4ddHCxAwEVg2fpgsB34DjpJ7d2eoToghXw7+eBk=;
 b=HIkoOMukSCq2QhY9zWEXs/qJMasvY0mi2HolqXWxk3pX+0U+XP54soYr
 kbm63fT1zXgKaHgxxNm8VQzsfLKzhBuurQUMRqZMhW3QDVJtNYjVW+PYo
 ws4e7RpIClnbDV0u0EgEM9WGuUv0vOgdrxgBlek9BnkQHeQq6/Nw3iQYm
 Bwt1W4EYLBCbT0gA0PufkAu0aaoMoK44GUOU9zm3yOBkaVX94HtYiYnrU
 DqEL9T6cHXLWL3XmRXohKgXBj/m8xGAbBS+wtVDuL6jfAVSsDeyH/xbgA
 n0/ZYMJBtfR55pXvJr5vo2bPOtO2qjjhXEAtRZWrntnqe6GQwaFNqh2vb g==;
X-CSE-ConnectionGUID: RNvNVJWwQ3uOBzE0Z+zclw==
X-CSE-MsgGUID: fY7myNVgRiCtHJZsw/Vhuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="65153450"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; d="scan'208";a="65153450"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 09:20:07 -0800
X-CSE-ConnectionGUID: nvse9oY3QPmrSsl+V0Lsiw==
X-CSE-MsgGUID: Tg6rD0uSQA28rwspTTyoHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="143142512"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2025 09:20:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH] drivers: fix build warnings when using icx
Date: Mon, 10 Feb 2025 17:19:57 +0000
Message-ID: <20250210171957.1670913-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

The Intel oneAPI DPC++/C++ Compiler (icx), issues warnings on build when
the "-march=native", or other configured global "-march" flag, is
overridden to "skylake-avx512", when compiling AVX-512 code.

Allow building with icx with warnings-as-errors flag (werror) enabled by
disabling the warning for the cases where we pass that extra "-march"
flag.

Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
Fixes: 31737f2b66fb ("net/iavf: enable AVX512 for legacy Rx")
Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
Fixes: 0fac6a1c44d5 ("common/idpf: add AVX512 for single queue model")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ian Stokes <ian.stokes@intel.com>
---
 drivers/common/idpf/meson.build    | 3 +++
 drivers/net/intel/i40e/meson.build | 3 +++
 drivers/net/intel/iavf/meson.build | 3 +++
 drivers/net/intel/ice/meson.build  | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/drivers/common/idpf/meson.build b/drivers/common/idpf/meson.build
index 46fd45c03b..7dbcdabd90 100644
--- a/drivers/common/idpf/meson.build
+++ b/drivers/common/idpf/meson.build
@@ -21,6 +21,9 @@ if arch_subdir == 'x86'
         avx512_args = cflags + cc_avx512_flags
         if cc.has_argument('-march=skylake-avx512')
             avx512_args += '-march=skylake-avx512'
+            if cc.has_argument('-Wno-overriding-option')
+                avx512_args += '-Wno-overriding-option'
+            endif
         endif
         idpf_common_avx512_lib = static_library('idpf_common_avx512_lib',
                 'idpf_common_rxtx_avx512.c',
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index 5c93493124..ffa40c5d64 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -57,6 +57,9 @@ if arch_subdir == 'x86'
         avx512_args = cflags + cc_avx512_flags
         if cc.has_argument('-march=skylake-avx512')
             avx512_args += '-march=skylake-avx512'
+            if cc.has_argument('-Wno-overriding-option')
+                avx512_args += '-Wno-overriding-option'
+            endif
         endif
         i40e_avx512_lib = static_library('i40e_avx512_lib',
                 'i40e_rxtx_vec_avx512.c',
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index d9b605f55a..c2bef0230f 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -40,6 +40,9 @@ if arch_subdir == 'x86' and is_variable('static_rte_common_iavf')
         avx512_args = cflags + cc_avx512_flags
         if cc.has_argument('-march=skylake-avx512')
             avx512_args += '-march=skylake-avx512'
+            if cc.has_argument('-Wno-overriding-option')
+                avx512_args += '-Wno-overriding-option'
+            endif
         endif
         iavf_avx512_lib = static_library('iavf_avx512_lib',
                 'iavf_rxtx_vec_avx512.c',
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index beaf21e176..3b13a5913d 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -40,6 +40,9 @@ if arch_subdir == 'x86'
         avx512_args = cflags + cc_avx512_flags
         if cc.has_argument('-march=skylake-avx512')
             avx512_args += '-march=skylake-avx512'
+            if cc.has_argument('-Wno-overriding-option')
+                avx512_args += '-Wno-overriding-option'
+            endif
         endif
         ice_avx512_lib = static_library('ice_avx512_lib',
                 'ice_rxtx_vec_avx512.c',
-- 
2.43.0

