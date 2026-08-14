Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E9C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C224406B7;
	Fri, 14 Aug 2026 17:38:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id A3AB640658
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786721893; x=1818257893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rKsjXE1VenUQ7FB2HJPK/nUDPWwHBFsdat93EIC8geo=;
 b=O27CrmSVR77xFQ3RqR7wVVjYxneyCXOCr2hAV2IOrP+gZrOKkwYQsRoM
 Zv1/Ink0r0gShNuBS4k1WFfma/NeeL72VgMnj1sy8lHzHUlEgcVceCnt7
 6W9nhNRRvoGza4+GtwsnxLOhrzwWemRsljvZjQz9nnboZtlKXN/qEPGvv
 +pOR6CGTTWwT2CwbxUdWMKbExXGyhskNUlRCA0cwZJRW7VBeCTdi8MIj0
 Z8V7uOdXjLDy9/GZZldeYz9ecp2yp7EcjLsECtA6aCwyJ9iVgdSQz4sFG
 xfpD0u14H9rF1/IJ7Qg1wg16c9jAAdO/FQUiD6OygUaMg4AYJiKUL1A4z A==;
X-CSE-ConnectionGUID: ZFlP4AAHR/mKFk2vKKHWog==
X-CSE-MsgGUID: z6pzyauGTainMNnCl4DAYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87430616"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87430616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 08:38:12 -0700
X-CSE-ConnectionGUID: n/8X+07QSEera1mo3rwopg==
X-CSE-MsgGUID: aaL2POE4RUW3XfhMAMzr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="264297110"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 14 Aug 2026 08:38:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 7/8] net/ixgbe: move editable files out of base folder
Date: Fri, 14 Aug 2026 16:37:50 +0100
Message-ID: <20260814153755.940302-8-bruce.richardson@intel.com>
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
 drivers/net/intel/ixgbe/base/README           |  9 ---------
 drivers/net/intel/ixgbe/base/meson.build      | 19 -------------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        | 12 ++++++------
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 12 ++++++------
 .../net/intel/ixgbe/{base => }/ixgbe_osdep.h  |  2 ++
 drivers/net/intel/ixgbe/meson.build           | 17 ++++++++++++++++-
 6 files changed, 30 insertions(+), 41 deletions(-)
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
index 3d4f4fb7fc..8e44bb3a09 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -36,15 +36,15 @@
 #include <rte_os_shim.h>
 
 #include "ixgbe_logs.h"
-#include "base/ixgbe_api.h"
-#include "base/ixgbe_vf.h"
-#include "base/ixgbe_common.h"
+#include "ixgbe_api.h"
+#include "ixgbe_vf.h"
+#include "ixgbe_common.h"
 #include "ixgbe_ethdev.h"
 #include "ixgbe_bypass.h"
 #include "ixgbe_rxtx.h"
-#include "base/ixgbe_type.h"
-#include "base/ixgbe_phy.h"
-#include "base/ixgbe_osdep.h"
+#include "ixgbe_type.h"
+#include "ixgbe_phy.h"
+#include "ixgbe_osdep.h"
 #include "ixgbe_regs.h"
 
 /*
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 7f1241951f..01ee4dbb4a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -35,15 +35,15 @@
 #include <rte_flow_driver.h>
 
 #include "ixgbe_logs.h"
-#include "base/ixgbe_api.h"
-#include "base/ixgbe_vf.h"
-#include "base/ixgbe_common.h"
-#include "base/ixgbe_osdep.h"
+#include "ixgbe_api.h"
+#include "ixgbe_vf.h"
+#include "ixgbe_common.h"
+#include "ixgbe_osdep.h"
 #include "ixgbe_ethdev.h"
 #include "ixgbe_bypass.h"
 #include "ixgbe_rxtx.h"
-#include "base/ixgbe_type.h"
-#include "base/ixgbe_phy.h"
+#include "ixgbe_type.h"
+#include "ixgbe_phy.h"
 #include "rte_pmd_ixgbe.h"
 
 #include "../common/flow_check.h"
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

