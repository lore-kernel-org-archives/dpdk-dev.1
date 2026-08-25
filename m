Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D381C61DBC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 16:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D549540655;
	Tue, 25 Aug 2026 18:27:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 296AA4013F
 for <dev@dpdk.org>; Tue, 25 Aug 2026 18:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787675246; x=1819211246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U3lx1MfzaWyoqvx4Tnstl5OI/t8GMIiioz+4RhZnoKA=;
 b=KEgNZBRVWLyv0M3x44LbbfLuthh5ANRaLEEPNEV/74UoZ0e6akQ2FOhE
 9xBfw59sDmP98JD3FM7tgot2uISBHKNaPoLqixln0BclBDdyk5c7J3p3R
 77bLfNwcPqIRc+Vvpb00kZSWdjfWeG41KRncrQYzTV2Kao/y+0gIAX2N8
 xKydKI4sBXsifqaW6w8AeSxtER4QpqnWxL9FbSD5VEaA4QM3DZiJBhWKE
 6KlX+9+uXmmnip5j55XEhnC3ROy28u5heJTY9UHQFiXch7/0A1zKSMS8z
 rWdLqJTgHvTpUf9QLlHSko4Oobj6gwnMnnx1LQzha/q8PxlCnKSdLbxYL g==;
X-CSE-ConnectionGUID: 5nMKubtjS3WSlGKJ/Kejnw==
X-CSE-MsgGUID: fioPrmisRPubxRBOEkkYow==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88277649"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="88277649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:27:25 -0700
X-CSE-ConnectionGUID: EE7N6HWQRG+qM3El8XCzNw==
X-CSE-MsgGUID: OTHaiuY6Tgemg+CVi9gaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="269286118"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 25 Aug 2026 09:27:24 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 1/8] net/e1000: move editable files out of base folder
Date: Tue, 25 Aug 2026 17:27:05 +0100
Message-ID: <20260825162714.1049272-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162714.1049272-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825162714.1049272-1-bruce.richardson@intel.com>
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
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
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

