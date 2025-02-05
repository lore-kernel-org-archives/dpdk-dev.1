Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70892C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F98402ED;
	Wed,  5 Feb 2025 19:29:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 25AF8402E4;
 Wed,  5 Feb 2025 19:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738780171; x=1770316171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=03R+mFVUMfkGIj7eFxHaBp29FJJtfK2dK/Y8itwrL2w=;
 b=N8+/LLBXIZ2izD7u2JDo0j9AZ1MrFaMz8R9DjDgb59vdRKfduu94QzoR
 0g4lTOY3jhRIF9uH+z7wbPWzjCOVZZNnnd5l8Ep7sKFlyaQ2tsiMGqzXA
 rg0jZh1IVYtk/lSZiLNnYcty6gHvvY8fw75YO6MI+NcRjgZE9dRWAPQ1G
 q5w6QMyYbspRwE4yfcXeRf9DwFMKnn84mvV39azJ/9PRq26RZFXPmcvcc
 jQVbddRXwwZCOiPx1ELEatOuHG4ZnhOA8xzCGpEeYqMrux4Pj0A1AmqoL
 1QzYSgzOqT1upyTrJEAndl6uB0atWTWv8CsJDEnvst/qOJUEur2Rk3zEk A==;
X-CSE-ConnectionGUID: 5PYEdL/yRgeH+n5IuM6ilw==
X-CSE-MsgGUID: corgfTTARlar0GU/Jku+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39497014"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="39497014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 10:29:31 -0800
X-CSE-ConnectionGUID: NWrIGfSiQuG2++AgEChDpQ==
X-CSE-MsgGUID: Dhv2EUWcQnOCdpkQJzo9xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; d="scan'208";a="116024276"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 10:29:29 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: john.mcnamara@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org, Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Leyi Rong <leyi.rong@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v2 1/2] drivers: fix build warnings when using icx
Date: Wed,  5 Feb 2025 18:29:14 +0000
Message-ID: <20250205182918.4041268-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205182918.4041268-1-bruce.richardson@intel.com>
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250205182918.4041268-1-bruce.richardson@intel.com>
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

