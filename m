Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD35CC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA4E14028F;
	Fri, 14 Aug 2026 17:38:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AEF64400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721886; x=1818257886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=onQdpMVM+fly7kZvODnY0RshFcKiho1g4zUa2UUONvA=;
 b=WdFOnxdvfFkE1Gg8qvm2vHI3NBP6kW+tmZCZ9cUwWbLB/ru9xF15C7E5
 b1Bvr8ddu4hc+AHsF4r/ZiN/uRAz2rGljqQNWGXlaAao+tvRSgu/UMZgf
 oAvI3pnlpTxz0yk2ilq/PembvOLxCdQwdqIeWtEo/9DFkgYUmXuyTMKDF
 g+MEayvk6wDXEpyaF3FdlfYDRZcwSxB3Vf/Mq+t4uoLfryZcZcCyB4R/Z
 QvNs9zDFN9AXZ3+QjsSk2I4wlVdVR5FoMNLx9LG8uWwzIJeWXc9F4WU6y
 +h3QjQG9bPrSQJA5DDqF+aRzwEFTIjDVI7ibDfsWQJxvqCpDsJVxHUbGR Q==;
X-CSE-ConnectionGUID: bXdH+OvWQ1yYvSOknbcHWQ==
X-CSE-MsgGUID: YztmmDH8TMa7XhfqySN9Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430609"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430609"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:04 -0700
X-CSE-ConnectionGUID: XU/8fN5ySgyb858YgVfATQ==
X-CSE-MsgGUID: UL3bN4FPSnKD2AK77nfyJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297080"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:04 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/8] net/e1000: move editable files out of base folder
Date: Fri, 14 Aug 2026 16:37:44 +0100
Message-ID: <20260814153755.940302-2-bruce.richardson@intel.com>
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

The osdep files contain the macros and other definitions needed to allow
the base code to compile as part of DPDK. They traditionally tend to
reside in the base code folder, but are an exception in that they can be
modified by regular DPDK patches, and not just as part of a base code
snapshot update. Similarly the meson.build file in the base folder is
not part of the snapshots and is an editable file in the base folder.

Therefore, we can simplify the rules around base code by moving these
files into the main driver folder, leaving the base code C files all as
uneditable except via snapshot update.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/e1000/base/README           |  9 -------
 drivers/net/intel/e1000/base/meson.build      | 24 -------------------
 .../net/intel/e1000/{base => }/e1000_osdep.c  |  0
 .../net/intel/e1000/{base => }/e1000_osdep.h  |  4 +++-
 drivers/net/intel/e1000/em_rxtx.c             |  2 +-
 drivers/net/intel/e1000/igc_ethdev.h          |  2 +-
 drivers/net/intel/e1000/meson.build           | 22 ++++++++++++++++-
 7 files changed, 26 insertions(+), 37 deletions(-)
 delete mode 100644 drivers/net/intel/e1000/base/meson.build
 rename drivers/net/intel/e1000/{base => }/e1000_osdep.c (100%)
 rename drivers/net/intel/e1000/{base => }/e1000_osdep.h (98%)

diff --git a/drivers/net/intel/e1000/base/README b/drivers/net/intel/e1000/base/README
index f0c1e4af48..861b2650aa 100644
--- a/drivers/net/intel/e1000/base/README
+++ b/drivers/net/intel/e1000/base/README
@@ -27,12 +27,3 @@ This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller I226
 * Intel® Ethernet Controller I354 Series
 * Intel® Ethernet Controller DH89XXCC Series
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from
-the following file(s):
-
-    e1000_osdep.c
-    e1000_osdep.h
diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
deleted file mode 100644
index 4fe86dc6df..0000000000
--- a/drivers/net/intel/e1000/base/meson.build
+++ /dev/null
@@ -1,24 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2017 Intel Corporation
-
-base_sources = files(
-        'e1000_base.c',
-        'e1000_80003es2lan.c',
-        'e1000_82540.c',
-        'e1000_82541.c',
-        'e1000_82542.c',
-        'e1000_82543.c',
-        'e1000_82571.c',
-        'e1000_82575.c',
-        'e1000_api.c',
-        'e1000_i210.c',
-        'e1000_i225.c',
-        'e1000_ich8lan.c',
-        'e1000_mac.c',
-        'e1000_manage.c',
-        'e1000_mbx.c',
-        'e1000_nvm.c',
-        'e1000_osdep.c',
-        'e1000_phy.c',
-        'e1000_vf.c',
-)
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.c b/drivers/net/intel/e1000/e1000_osdep.c
similarity index 100%
rename from drivers/net/intel/e1000/base/e1000_osdep.c
rename to drivers/net/intel/e1000/e1000_osdep.c
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/e1000_osdep.h
similarity index 98%
rename from drivers/net/intel/e1000/base/e1000_osdep.h
rename to drivers/net/intel/e1000/e1000_osdep.h
index 895ffa5182..2a8da37476 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/e1000_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _E1000_OSDEP_H_
 #define _E1000_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <stdint.h>
 #include <stdio.h>
 #include <stdarg.h>
@@ -17,7 +19,7 @@
 #include <rte_byteorder.h>
 #include <rte_io.h>
 
-#include "../e1000_logs.h"
+#include "e1000_logs.h"
 
 #define DELAY(x) rte_delay_us_sleep(x)
 #define usec_delay(x) DELAY(x)
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index f9665127df..3e18ac994a 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -43,7 +43,7 @@
 #include "e1000_logs.h"
 #include "base/e1000_api.h"
 #include "e1000_ethdev.h"
-#include "base/e1000_osdep.h"
+#include "e1000_osdep.h"
 
 #define	E1000_TXD_VLAN_SHIFT	16
 
diff --git a/drivers/net/intel/e1000/igc_ethdev.h b/drivers/net/intel/e1000/igc_ethdev.h
index 7fa7877adf..e36fa4755e 100644
--- a/drivers/net/intel/e1000/igc_ethdev.h
+++ b/drivers/net/intel/e1000/igc_ethdev.h
@@ -9,7 +9,7 @@
 #include <rte_flow.h>
 #include <rte_time.h>
 
-#include "base/e1000_osdep.h"
+#include "e1000_osdep.h"
 #include "base/e1000_hw.h"
 #include "base/e1000_i225.h"
 #include "base/e1000_api.h"
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index 924fe4ecae..6f1e300718 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -1,10 +1,30 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-subdir('base')
+base_sources = files(
+        'base/e1000_base.c',
+        'base/e1000_80003es2lan.c',
+        'base/e1000_82540.c',
+        'base/e1000_82541.c',
+        'base/e1000_82542.c',
+        'base/e1000_82543.c',
+        'base/e1000_82571.c',
+        'base/e1000_82575.c',
+        'base/e1000_api.c',
+        'base/e1000_i210.c',
+        'base/e1000_i225.c',
+        'base/e1000_ich8lan.c',
+        'base/e1000_mac.c',
+        'base/e1000_manage.c',
+        'base/e1000_mbx.c',
+        'base/e1000_nvm.c',
+        'base/e1000_phy.c',
+        'base/e1000_vf.c',
+)
 
 sources += files(
         'e1000_logs.c',
+        'e1000_osdep.c',
         'em_ethdev.c',
         'em_rxtx.c',
         'igb_ethdev.c',
-- 
2.53.0

