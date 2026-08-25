Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FAC61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9554F40685;
	Tue, 25 Aug 2026 17:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5B20C40658
 for <dev@dpdk.org>; Tue, 25 Aug 2026 17:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787670963; x=1819206963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WD1krhssv7oucdmYO8sGXEjbFlKam8OQLi9X9RgU26k=;
 b=BrznUuWl8Reh1rGyUJPI1JTcuFflEJvA5U4PLLmetu3Dr5kP7sCgRJVY
 VbyLHw6z76uyC4Uj0wqkCft6rQ0Y80E/+yAWldSIUgDbsfR7gINP3EmkC
 5gOZiFRpRJ3FszKXTLFkaKIKNZTDnDO1mYYxR1k1ME8lE68lsQH+GqoJc
 JAJxbRg7wjsYARP0Uc/yLVG2NoBlkpA7iXiT4wpol06oeCcnRpmtzbCqx
 UUYUQ3tsBX7avrIH+hg21mJsqSpjyXf4uw6YbdsEbqIvmtRkrDSLxpap7
 j3yRZFR+1M7BCy5Q6zU+4qr1b3+KZdkM5edqQXYxOBmL6LaPAtzHqh1ir Q==;
X-CSE-ConnectionGUID: Y4lkxBUTSA6VyRmBZux/bg==
X-CSE-MsgGUID: 1b5MeQJSQ+2q4s+RUih+3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88270723"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88270723"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 08:15:48 -0700
X-CSE-ConnectionGUID: hwVYE9FXSwmsCzD0JS56iw==
X-CSE-MsgGUID: plxzeGJqR66YhjcK2H/JVw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2026 08:15:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 7/8] net/ixgbe: move editable files out of base folder
Date: Tue, 25 Aug 2026 16:15:22 +0100
Message-ID: <20260825151533.535102-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825151533.535102-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825151533.535102-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/README           |  9 ---------
 drivers/net/intel/ixgbe/base/meson.build      | 19 -------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          |  2 +-
 .../net/intel/ixgbe/{base => }/ixgbe_osdep.h  |  2 ++
 drivers/net/intel/ixgbe/meson.build           | 17 ++++++++++++++++-
 6 files changed, 20 insertions(+), 31 deletions(-)
 delete mode 100644 drivers/net/intel/ixgbe/base/meson.build
 rename drivers/net/intel/ixgbe/{base => }/ixgbe_osdep.h (99%)

diff --git a/drivers/net/intel/ixgbe/base/README b/drivers/net/intel/ixgbe/base/README
index b48438f1db..bea5061abc 100644
--- a/drivers/net/intel/ixgbe/base/README
+++ b/drivers/net/intel/ixgbe/base/README
@@ -25,12 +25,3 @@ This driver is valid for the product(s) listed below
 * Intel® Ethernet Server Adapter X520-T2
 * Intel® Ethernet Controller X550 Series
 * Intel® Ethernet Controller E610 Series
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from
-the following file(s):
-
-    ixgbe_osdep.h
-    ixgbe_osdep.c
diff --git a/drivers/net/intel/ixgbe/base/meson.build b/drivers/net/intel/ixgbe/base/meson.build
deleted file mode 100644
index c0b14a1db3..0000000000
--- a/drivers/net/intel/ixgbe/base/meson.build
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2017-2024 Intel Corporation
-
-base_sources = files(
-        'ixgbe_82598.c',
-        'ixgbe_82599.c',
-        'ixgbe_api.c',
-        'ixgbe_common.c',
-        'ixgbe_dcb_82598.c',
-        'ixgbe_dcb_82599.c',
-        'ixgbe_dcb.c',
-        'ixgbe_e610.c',
-        'ixgbe_hv_vf.c',
-        'ixgbe_mbx.c',
-        'ixgbe_phy.c',
-        'ixgbe_vf.c',
-        'ixgbe_x540.c',
-        'ixgbe_x550.c',
-)
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 3d4f4fb7fc..4b7f51ce13 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -44,7 +44,7 @@
 #include "ixgbe_rxtx.h"
 #include "base/ixgbe_type.h"
 #include "base/ixgbe_phy.h"
-#include "base/ixgbe_osdep.h"
+#include "ixgbe_osdep.h"
 #include "ixgbe_regs.h"
 
 /*
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 7f1241951f..c702119eb0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -38,7 +38,7 @@
 #include "base/ixgbe_api.h"
 #include "base/ixgbe_vf.h"
 #include "base/ixgbe_common.h"
-#include "base/ixgbe_osdep.h"
+#include "ixgbe_osdep.h"
 #include "ixgbe_ethdev.h"
 #include "ixgbe_bypass.h"
 #include "ixgbe_rxtx.h"
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/ixgbe_osdep.h
similarity index 99%
rename from drivers/net/intel/ixgbe/base/ixgbe_osdep.h
rename to drivers/net/intel/ixgbe/ixgbe_osdep.h
index 4dfed02137..9f4f5e8038 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/ixgbe_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _IXGBE_OS_H_
 #define _IXGBE_OS_H_
 
+/* File containing OS dependencies for base code */
+
 #include <pthread.h>
 #include <string.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 7e737ee7b4..0531d37acd 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -3,7 +3,22 @@
 
 cflags += ['-DRTE_LIBRTE_IXGBE_BYPASS']
 
-subdir('base')
+base_sources = files(
+        'base/ixgbe_82598.c',
+        'base/ixgbe_82599.c',
+        'base/ixgbe_api.c',
+        'base/ixgbe_common.c',
+        'base/ixgbe_dcb_82598.c',
+        'base/ixgbe_dcb_82599.c',
+        'base/ixgbe_dcb.c',
+        'base/ixgbe_e610.c',
+        'base/ixgbe_hv_vf.c',
+        'base/ixgbe_mbx.c',
+        'base/ixgbe_phy.c',
+        'base/ixgbe_vf.c',
+        'base/ixgbe_x540.c',
+        'base/ixgbe_x550.c',
+)
 
 sources += files(
         'ixgbe_82599_bypass.c',
-- 
2.53.0

