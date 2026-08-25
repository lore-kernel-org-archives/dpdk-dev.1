Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634FC61DBC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 16:27:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E444067B;
	Tue, 25 Aug 2026 18:27:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 79F0F40655
 for <dev@dpdk.org>; Tue, 25 Aug 2026 18:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787675247; x=1819211247;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kee2Sszz1aItoswxRN0FGIFcdCDfmo50hoishLws+Qc=;
 b=NJ7irpXgi6h7m8hzAvjEnXvKHC8Gv53XMYBEYOJyeKmTKZEdMmUIS6Nw
 xEcSN1oACH/puLXGujTqQJRyaWkxu3X52nOt3SQDuOHFo5UppzqHij2QD
 75/88N1QAa4eS0sfWRf/6Bj9XaAeu8V0mbiOMUe0ClRWca7xGOEFvtMr/
 9G8pMTFcfPSf0ONU65BS0hEpMFFFRICX2OTyI2kyMpZJsdoyg2EYiwYQZ
 +9Yfav1XVg/qAYQ8RfxFPmHAxN+tJFqY+wN8tcIPklgZNPtJjbZmV5RmX
 rQl6T3jhbufvXO5aUZO1eX0zQJjhA4oZlRPGDqmYa+a5jPJnSpPKPcP74 w==;
X-CSE-ConnectionGUID: IT6gU+6JSuWvlwLtRlXrAg==
X-CSE-MsgGUID: YDu4D0urRWKAeBzzh9vThA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88277654"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="88277654"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 09:27:27 -0700
X-CSE-ConnectionGUID: RSHt8Hb7TVGpEdwvCnd/IA==
X-CSE-MsgGUID: YkCMZzJsSp2DGqBj9D/F1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="269286136"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa004.fm.intel.com with ESMTP; 25 Aug 2026 09:27:26 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v3 2/8] net/fm10k: move editable files out of base folder
Date: Tue, 25 Aug 2026 17:27:06 +0100
Message-ID: <20260825162714.1049272-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162714.1049272-1-bruce.richardson@intel.com>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825162714.1049272-1-bruce.richardson@intel.com>
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
Acked-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/intel/fm10k/base/meson.build         | 11 -----------
 drivers/net/intel/fm10k/{base => }/fm10k_osdep.h |  4 +++-
 drivers/net/intel/fm10k/meson.build              |  9 ++++++++-
 3 files changed, 11 insertions(+), 13 deletions(-)
 delete mode 100644 drivers/net/intel/fm10k/base/meson.build
 rename drivers/net/intel/fm10k/{base => }/fm10k_osdep.h (98%)

diff --git a/drivers/net/intel/fm10k/base/meson.build b/drivers/net/intel/fm10k/base/meson.build
deleted file mode 100644
index c45b31d6b2..0000000000
--- a/drivers/net/intel/fm10k/base/meson.build
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2017 Intel Corporation
-
-base_sources = files(
-        'fm10k_api.c',
-        'fm10k_common.c',
-        'fm10k_mbx.c',
-        'fm10k_pf.c',
-        'fm10k_tlv.c',
-        'fm10k_vf.c',
-)
diff --git a/drivers/net/intel/fm10k/base/fm10k_osdep.h b/drivers/net/intel/fm10k/fm10k_osdep.h
similarity index 98%
rename from drivers/net/intel/fm10k/base/fm10k_osdep.h
rename to drivers/net/intel/fm10k/fm10k_osdep.h
index 5f8ff10474..69c542a6d0 100644
--- a/drivers/net/intel/fm10k/base/fm10k_osdep.h
+++ b/drivers/net/intel/fm10k/fm10k_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _FM10K_OSDEP_H_
 #define _FM10K_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <stdint.h>
 #include <stdbool.h>
 #include <string.h>
@@ -13,7 +15,7 @@
 #include <rte_cycles.h>
 #include <rte_io.h>
 
-#include "../fm10k_logs.h"
+#include "fm10k_logs.h"
 
 /* TODO: this does not look like it should be used... */
 #define ERROR_REPORT2(v1, v2, v3)   do { } while (0)
diff --git a/drivers/net/intel/fm10k/meson.build b/drivers/net/intel/fm10k/meson.build
index fac4750f8d..a532b35818 100644
--- a/drivers/net/intel/fm10k/meson.build
+++ b/drivers/net/intel/fm10k/meson.build
@@ -7,7 +7,14 @@ if is_windows
     subdir_done()
 endif
 
-subdir('base')
+base_sources = files(
+        'base/fm10k_api.c',
+        'base/fm10k_common.c',
+        'base/fm10k_mbx.c',
+        'base/fm10k_pf.c',
+        'base/fm10k_tlv.c',
+        'base/fm10k_vf.c',
+)
 
 sources += files(
         'fm10k_ethdev.c',
-- 
2.53.0

