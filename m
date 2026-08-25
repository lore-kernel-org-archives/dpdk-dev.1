Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70544C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:16:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3591A40689;
	Tue, 25 Aug 2026 17:16:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 14B8B400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 17:16:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787670961; x=1819206961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JEJ41gf7iL5A3vvU3d2SsGN0m0QO+s27+TEUVJ1Gqvk=;
 b=cfm29EcMjSSiI+yfLZrREK/JhJmv/6ZsMphlxZEIHKZ0kiJzmEDsG6gR
 Bojllz/Ah++6Tt01TPEtSl9L8EhMB6+oVMzDxUUXLioe/+0AusEKM1MVu
 y0KbvVCDtHdkmNW0x/x9YWHPn9S+FYmTHUshrn5PIOWrd/b6ZobeFsfKb
 Y5vY+txQHj0Rf8Zj/UcQ2D2FfggDYNhjTYwVAE6b+1ab26GGvu9Ak9e0s
 rcUhHSutZ9YTqbNoi8Ri6aXGAqpzbiQKnRM/npBS4LPaJDX1TVSoeecw1
 jlfT4xMvGyL4dcB8rZl1o5dkXqsn5npDQoVBfBJP8oJjPAx5hgcfvvwWF w==;
X-CSE-ConnectionGUID: 7Bk5wmafR5meS+sseoeOog==
X-CSE-MsgGUID: /nbrWHcVScyn/NJM+ACyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88270692"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88270692"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 08:15:44 -0700
X-CSE-ConnectionGUID: Br24UYisS92EY6JNrIahxQ==
X-CSE-MsgGUID: gqhWsJpRQ4CzQODgKozpcg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2026 08:15:42 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 3/8] net/i40e: move editable files out of base folder
Date: Tue, 25 Aug 2026 16:15:18 +0100
Message-ID: <20260825151533.535102-4-bruce.richardson@intel.com>
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
 drivers/net/intel/i40e/base/README             |  8 --------
 drivers/net/intel/i40e/base/meson.build        | 12 ------------
 drivers/net/intel/i40e/{base => }/i40e_osdep.h |  4 +++-
 drivers/net/intel/i40e/meson.build             | 10 +++++++++-
 4 files changed, 12 insertions(+), 22 deletions(-)
 delete mode 100644 drivers/net/intel/i40e/base/meson.build
 rename drivers/net/intel/i40e/{base => }/i40e_osdep.h (98%)

diff --git a/drivers/net/intel/i40e/base/README b/drivers/net/intel/i40e/base/README
index 59cae0fc90..77ae90dcd1 100644
--- a/drivers/net/intel/i40e/base/README
+++ b/drivers/net/intel/i40e/base/README
@@ -21,11 +21,3 @@ This driver is valid for the product(s) listed below
 * Intel® Ethernet Controller X710 and XL710 Family
 * Intel® Ethernet Controller XXV710 for 25GbE backplane
 * Intel® Ethernet Controller XXV710 for 25GbE SFP28
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from
-the following file(s):
-
-    i40e_osdep.h
diff --git a/drivers/net/intel/i40e/base/meson.build b/drivers/net/intel/i40e/base/meson.build
deleted file mode 100644
index 7b4882ad1d..0000000000
--- a/drivers/net/intel/i40e/base/meson.build
+++ /dev/null
@@ -1,12 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2017-2020 Intel Corporation
-
-base_sources = files(
-        'i40e_adminq.c',
-        'i40e_common.c',
-        'i40e_dcb.c',
-        'i40e_diag.c',
-        'i40e_hmc.c',
-        'i40e_lan_hmc.c',
-        'i40e_nvm.c',
-)
diff --git a/drivers/net/intel/i40e/base/i40e_osdep.h b/drivers/net/intel/i40e/i40e_osdep.h
similarity index 98%
rename from drivers/net/intel/i40e/base/i40e_osdep.h
rename to drivers/net/intel/i40e/i40e_osdep.h
index 9c5a94f055..1139c9c1fb 100644
--- a/drivers/net/intel/i40e/base/i40e_osdep.h
+++ b/drivers/net/intel/i40e/i40e_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _I40E_OSDEP_H_
 #define _I40E_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <string.h>
 #include <stdint.h>
 #include <stdbool.h>
@@ -18,7 +20,7 @@
 #include <rte_log.h>
 #include <rte_io.h>
 
-#include "../i40e_logs.h"
+#include "i40e_logs.h"
 #include "i40e_status.h"
 
 #define INLINE inline
diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
index bccae1ffc1..3229233f50 100644
--- a/drivers/net/intel/i40e/meson.build
+++ b/drivers/net/intel/i40e/meson.build
@@ -17,7 +17,15 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') == 0
     subdir_done()
 endif
 
-subdir('base')
+base_sources = files(
+        'base/i40e_adminq.c',
+        'base/i40e_common.c',
+        'base/i40e_dcb.c',
+        'base/i40e_diag.c',
+        'base/i40e_hmc.c',
+        'base/i40e_lan_hmc.c',
+        'base/i40e_nvm.c',
+)
 
 sources += files(
         'i40e_ethdev.c',
-- 
2.53.0

