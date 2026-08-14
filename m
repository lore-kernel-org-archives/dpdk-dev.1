Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00944C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CA040664;
	Fri, 14 Aug 2026 17:38:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id C29C940287
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721890; x=1818257890;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x5RJmervAw/ZO8yauLx9AdMrKlSAhm3ObcWuBlTXhWQ=;
 b=UI1mjiifwrVZBHlhuTSjUUJSfXEpBHzHBeSMAvfx9MDoxIWx3IOGTUPE
 +GZJ2FjdVg87rXzm+FNRhz0+Im18myVMkZcJwje5HXmpdgvQUHH+iRuE2
 pfv1Jmoh7kqZOP3hNaB43CsFG9UNjzk5iibruz32vRDp3j5AQJtkWrPg7
 KkLKtNGwcDJHiOtKIkDEk2VAGsL4fKn49ahg1tK0yHVgBQtyHtCLOHGHY
 ogsa8tlPJwzBym8esh6f4H4WJCv1dVpkwIIjbfQ3ZGd2UQbBpXy5H4PFy
 hRyAIuHQCY7xMGZNYfyZjaUfvKL4nYvKB+oWrzSSClQ0jwX+iorvuKzFI w==;
X-CSE-ConnectionGUID: NX0sbCyjQ36teXrUcDiQrA==
X-CSE-MsgGUID: 4DqtpQjXTJGKkrB4wO7qKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430613"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430613"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:09 -0700
X-CSE-ConnectionGUID: v9X+7glyT7yDBDpVJ/yMRA==
X-CSE-MsgGUID: 3u6/I6yIR32haoFzqEQYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297096"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 5/8] net/ice: move editable files out of base folder
Date: Fri, 14 Aug 2026 16:37:48 +0100
Message-ID: <20260814153755.940302-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814153755.940302-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The osdep headers contain the macros and other definitions needed to
allow the base code to compile as part of DPDK. They traditionally tend
to reside in the base code folder, but are an exception in that they can
be modified by regular DPDK patches, and not just as part of a base code
snapshot update. Similarly the meson.build file in the base folder is
not part of the snapshots and is an editable file in the base folder.

Therefore, we can simplify the rules around base code by moving these
files into the main driver folder, leaving the base code C files all as
uneditable except via snapshot update.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/README            |  8 ---
 drivers/net/intel/ice/base/meson.build       | 51 --------------------
 drivers/net/intel/ice/{base => }/ice_osdep.h |  4 +-
 drivers/net/intel/ice/meson.build            | 51 +++++++++++++++++++-
 4 files changed, 52 insertions(+), 62 deletions(-)
 delete mode 100644 drivers/net/intel/ice/base/meson.build
 rename drivers/net/intel/ice/{base => }/ice_osdep.h (99%)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index 1f6b53c4c2..caec47217c 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -13,11 +13,3 @@ This driver is valid for the product(s) listed below
 
 * Intel® Ethernet Network Adapters E810
 * Intel® Ethernet Network Adapters E830
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from
-the following file(s):
-
-    ice_osdep.h
diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
deleted file mode 100644
index da961f0752..0000000000
--- a/drivers/net/intel/ice/base/meson.build
+++ /dev/null
@@ -1,51 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2018-2021 Intel Corporation
-
-base_sources = files(
-        'ice_controlq.c',
-        'ice_common.c',
-        'ice_sched.c',
-        'ice_switch.c',
-        'ice_nvm.c',
-        'ice_flex_pipe.c',
-        'ice_flow.c',
-        'ice_dcb.c',
-        'ice_fdir.c',
-        'ice_acl.c',
-        'ice_acl_ctrl.c',
-        'ice_vlan_mode.c',
-        'ice_ptp_hw.c',
-        'ice_parser.c',
-        'ice_imem.c',
-        'ice_metainit.c',
-        'ice_pg_cam.c',
-        'ice_bst_tcam.c',
-        'ice_ptype_mk.c',
-        'ice_mk_grp.c',
-        'ice_proto_grp.c',
-        'ice_flg_rd.c',
-        'ice_xlt_kb.c',
-        'ice_parser_rt.c',
-        'ice_ddp.c',
-        'ice_fwlog.c',
-        'ice_vf_mbx.c',
-)
-
-if is_ms_compiler
-    error_cflags = [
-            '/wd4101', # unreferenced local variable
-            '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
-            '/wd4319', # zero extending 'unsigned long' to 'u64' of greater size
-    ]
-else
-    error_cflags = [
-            '-Wno-unused-but-set-variable',
-            '-Wno-unused-parameter',
-    ]
-endif
-
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        base_cflags += flag
-    endif
-endforeach
diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/ice_osdep.h
similarity index 99%
rename from drivers/net/intel/ice/base/ice_osdep.h
rename to drivers/net/intel/ice/ice_osdep.h
index 5d92cf5aa4..599bd4086b 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/ice_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _ICE_OSDEP_H_
 #define _ICE_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <string.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -24,7 +26,7 @@
 
 #include "ice_alloc.h"
 
-#include "../ice_logs.h"
+#include "ice_logs.h"
 
 #ifndef __INTEL_NET_BASE_OSDEP__
 #define __INTEL_NET_BASE_OSDEP__
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index a205304c89..b12077f7bd 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-subdir('base')
-
 sources = files(
         'ice_acl_filter.c',
         'ice_diagnose.c',
@@ -46,3 +44,52 @@ sources += files(
 )
 
 require_iova_in_mbuf = false
+
+base_sources = files(
+        'base/ice_controlq.c',
+        'base/ice_common.c',
+        'base/ice_sched.c',
+        'base/ice_switch.c',
+        'base/ice_nvm.c',
+        'base/ice_flex_pipe.c',
+        'base/ice_flow.c',
+        'base/ice_dcb.c',
+        'base/ice_fdir.c',
+        'base/ice_acl.c',
+        'base/ice_acl_ctrl.c',
+        'base/ice_vlan_mode.c',
+        'base/ice_ptp_hw.c',
+        'base/ice_parser.c',
+        'base/ice_imem.c',
+        'base/ice_metainit.c',
+        'base/ice_pg_cam.c',
+        'base/ice_bst_tcam.c',
+        'base/ice_ptype_mk.c',
+        'base/ice_mk_grp.c',
+        'base/ice_proto_grp.c',
+        'base/ice_flg_rd.c',
+        'base/ice_xlt_kb.c',
+        'base/ice_parser_rt.c',
+        'base/ice_ddp.c',
+        'base/ice_fwlog.c',
+        'base/ice_vf_mbx.c',
+)
+
+if is_ms_compiler
+    base_error_cflags = [
+            '/wd4101', # unreferenced local variable
+            '/wd4334', # result of 32-bit shift implicitly converted to 64 bits
+            '/wd4319', # zero extending 'unsigned long' to 'u64' of greater size
+    ]
+else
+    base_error_cflags = [
+            '-Wno-unused-but-set-variable',
+            '-Wno-unused-parameter',
+    ]
+endif
+
+foreach flag: base_error_cflags
+    if cc.has_argument(flag)
+        base_cflags += flag
+    endif
+endforeach
-- 
2.53.0

