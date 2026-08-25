Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E3C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA030406BC;
	Tue, 25 Aug 2026 17:16:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B975B40655
 for <dev@dpdk.org>; Tue, 25 Aug 2026 17:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787670962; x=1819206962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h0AvUYYkAWPhSnk/xJtqzLnDH60oAZjjnk70QJBd98E=;
 b=KD6msIf3xfjWgVBdACJZTHX6ZQWVktQvm11FwXOJGD3gv/jrVY9OvdTT
 +t/YXHgAmEP6it2M89H79s2ohhxOfxuZH0g1DL9KUsS0nqc+vgNBkrP8M
 DmvQJdjMQQV444bLyrN4JxU1rGuEZGHdXbtd/8rBM5Ez9kVccFvXcOamc
 iEd+GmwemLP9FEljnReOTAfGsuVKa+HNNPlllXvUpfFtkdt4XTO4D/8Yc
 S99fonC8d9jDlRNCKIn4k0EjPIL3RoLgdo9LSFpATSkcO3asmctuuaSXm
 6XL+QSCAWVMvmv2VqgA6SpFyKiQRTC7kb2Lh0URuXO+dywfXKdlykumXw w==;
X-CSE-ConnectionGUID: nt5q232VT0qXoZjfVgByaA==
X-CSE-MsgGUID: 72Xw2jdJS5+A5K9Pab2nyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88270715"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88270715"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 08:15:47 -0700
X-CSE-ConnectionGUID: tgmYJp2DT0SrICb+3821cQ==
X-CSE-MsgGUID: I7YFjt0MR86bM7Hx24xm7g==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 25 Aug 2026 08:15:45 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 6/8] net/idpf: move editable files out of base folder
Date: Tue, 25 Aug 2026 16:15:21 +0100
Message-ID: <20260825151533.535102-7-bruce.richardson@intel.com>
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
 drivers/net/intel/cpfl/cpfl_actions.h          | 2 +-
 drivers/net/intel/cpfl/cpfl_controlq.h         | 2 +-
 drivers/net/intel/idpf/base/README             | 8 --------
 drivers/net/intel/idpf/base/meson.build        | 7 -------
 drivers/net/intel/idpf/{base => }/idpf_osdep.h | 4 +++-
 drivers/net/intel/idpf/idpf_ptp.h              | 2 +-
 drivers/net/intel/idpf/meson.build             | 5 ++++-
 7 files changed, 10 insertions(+), 20 deletions(-)
 delete mode 100644 drivers/net/intel/idpf/base/meson.build
 rename drivers/net/intel/idpf/{base => }/idpf_osdep.h (99%)

diff --git a/drivers/net/intel/cpfl/cpfl_actions.h b/drivers/net/intel/cpfl/cpfl_actions.h
index 7b82119e39..772b3ff999 100644
--- a/drivers/net/intel/cpfl/cpfl_actions.h
+++ b/drivers/net/intel/cpfl/cpfl_actions.h
@@ -5,7 +5,7 @@
 #ifndef _CPFL_ACTIONS_H_
 #define _CPFL_ACTIONS_H_
 
-#include "base/idpf_osdep.h"
+#include "idpf_osdep.h"
 
 #pragma pack(1)
 
diff --git a/drivers/net/intel/cpfl/cpfl_controlq.h b/drivers/net/intel/cpfl/cpfl_controlq.h
index 740ae6522c..812b1b14a6 100644
--- a/drivers/net/intel/cpfl/cpfl_controlq.h
+++ b/drivers/net/intel/cpfl/cpfl_controlq.h
@@ -5,7 +5,7 @@
 #ifndef _CPFL_CONTROLQ_H_
 #define _CPFL_CONTROLQ_H_
 
-#include "base/idpf_osdep.h"
+#include "idpf_osdep.h"
 #include "base/idpf_controlq_api.h"
 
 #define CPFL_CTLQ_DESCRIPTOR_SIZE	32
diff --git a/drivers/net/intel/idpf/base/README b/drivers/net/intel/idpf/base/README
index 457b5a81f3..aa617f1819 100644
--- a/drivers/net/intel/idpf/base/README
+++ b/drivers/net/intel/idpf/base/README
@@ -11,11 +11,3 @@ The directory of base/ contains the original source package.
 This driver is valid for the product(s) listed below
 
 * Intel® IPU E2100
-
-Updating the driver
-===================
-
-NOTE: The source code in this directory should not be modified apart from
-the following file(s):
-
-    idpf_osdep.h
diff --git a/drivers/net/intel/idpf/base/meson.build b/drivers/net/intel/idpf/base/meson.build
deleted file mode 100644
index 78782e463e..0000000000
--- a/drivers/net/intel/idpf/base/meson.build
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2023 Intel Corporation
-
-base_sources = files(
-        'idpf_controlq.c',
-        'idpf_controlq_setup.c',
-)
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/idpf_osdep.h
similarity index 99%
rename from drivers/net/intel/idpf/base/idpf_osdep.h
rename to drivers/net/intel/idpf/idpf_osdep.h
index 67bc33f2e6..9c758fb3c0 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/idpf_osdep.h
@@ -5,6 +5,8 @@
 #ifndef _IDPF_OSDEP_H_
 #define _IDPF_OSDEP_H_
 
+/* File containing OS dependencies for base code */
+
 #include <string.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -24,7 +26,7 @@
 #include <rte_io.h>
 #include <rte_compat.h>
 
-#include "../idpf_common_logs.h"
+#include "idpf_common_logs.h"
 
 #define INLINE inline
 #define STATIC static
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idpf_ptp.h
index 0c901440fb..ecb59200bd 100644
--- a/drivers/net/intel/idpf/idpf_ptp.h
+++ b/drivers/net/intel/idpf/idpf_ptp.h
@@ -5,7 +5,7 @@
 #ifndef _IDPF_PTP_H_
 #define _IDPF_PTP_H_
 
-#include "base/idpf_osdep.h"
+#include "idpf_osdep.h"
 #include <rte_time.h>
 #include "idpf_common_device.h"
 
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/meson.build
index 740c1a5985..311f300ccb 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,7 +7,10 @@ if is_windows
     subdir_done()
 endif
 
-subdir('base')
+base_sources = files(
+        'base/idpf_controlq.c',
+        'base/idpf_controlq_setup.c',
+)
 
 includes += include_directories('../iavf/base')
 
-- 
2.53.0

