Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DD1C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F1142DD6;
	Fri,  7 Feb 2025 13:45:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id DAD2042DF0
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932355; x=1770468355;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=op8J4W37ztIoStNBQIB3eKI1lZWu9ROaUxnU9B+kJX8=;
 b=kub6IfUqC0RNe7HCFseJKwOWEX4zGIKGokCT25LPsKXpl4IgJjxknQhb
 PNT0CRGB4r14wQtcxZ3Y3TOy+vMBFcYruMsHxSH0f9arDkQlI1ylbIHUV
 4f+FhHoZp4ZojXn1pLwc2RAHNRO7dZfRdMvjyTNmgG2QOxyJJRCx7IR1d
 v/p63LHdn42fLAribnywHHpPZl0f28b6xca9YNrnrieH9tlVP2HmIueWS
 IhtZloJonSXFKoi3wavMavEYQnjByaFkzzekoiEXVehveneVGu5LjfxPo
 I3pVAS5Rp6QdKBfGLIM3Wa/OBNU1N+Iy3AlrhS8mgQom36BA4CeR09Zlu g==;
X-CSE-ConnectionGUID: nckU2feHQaim2cyWowQCnA==
X-CSE-MsgGUID: 9Ffyq8gQTxWzxsJl1BPz2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331718"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331718"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:45:54 -0800
X-CSE-ConnectionGUID: tYjTs26YTMymI4aUOW9lgA==
X-CSE-MsgGUID: 91us3JRpSvaB6sr/tmNIGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953445"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:45:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 04/36] net/e1000/base: remove unused parameter workaround
Date: Fri,  7 Feb 2025 12:44:56 +0000
Message-ID: <4e7b0de4c84585969b409e93b2b2f7d7eb22bee2.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

Currently, e1000 base code is compiled with removing warning for unused
parameters. The e1000 codebase does define a few macros to suppress
unused parameters explicitly and dilligently uses them where they are
needed, but the definitions for these macros are empty in e1000 osdep
file, which is probably the reason why the workaround for the warning was
added in the first place.

We address that by making them meaningful by using RTE_SET_USED macro, so
that we can use them for their intended purposes. The meson file workaround
can now be removed. After removing the workaround, there is a bunch of
warnings coming from osdep.c file, so fix those too.

While we're at it, also fix trailing whitespace as well as unnecessary
FreeBSD license header tags that were used internally at the time the code
was generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_osdep.c | 11 +++++++----
 drivers/net/intel/e1000/base/e1000_osdep.h | 23 ++++++++++++++++------
 drivers/net/intel/e1000/base/meson.build   | 12 +----------
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_osdep.c b/drivers/net/intel/e1000/base/e1000_osdep.c
index 55265931b9..e6aac5a5bb 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.c
+++ b/drivers/net/intel/e1000/base/e1000_osdep.c
@@ -1,12 +1,11 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2001 - 2015 Intel Corporation
  */
-/*$FreeBSD$*/
 
 #include "e1000_api.h"
 
 /*
- * NOTE: the following routines using the e1000 
+ * NOTE: the following routines using the e1000
  * 	naming style are provided to the shared
  *	code but are OS specific
  */
@@ -14,24 +13,26 @@
 void
 e1000_write_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
-	return;
+	UNREFERENCED_3PARAMETER(hw, reg, value);
 }
 
 void
 e1000_read_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
+	UNREFERENCED_2PARAMETER(hw, reg);
 	*value = 0;
-	return;
 }
 
 void
 e1000_pci_set_mwi(struct e1000_hw *hw)
 {
+	UNREFERENCED_1PARAMETER(hw);
 }
 
 void
 e1000_pci_clear_mwi(struct e1000_hw *hw)
 {
+	UNREFERENCED_1PARAMETER(hw);
 }
 
 
@@ -41,6 +42,7 @@ e1000_pci_clear_mwi(struct e1000_hw *hw)
 int32_t
 e1000_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
+	UNREFERENCED_3PARAMETER(hw, reg, value);
 	return E1000_NOT_IMPLEMENTED;
 }
 
@@ -50,5 +52,6 @@ e1000_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 int32_t
 e1000_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
+	UNREFERENCED_3PARAMETER(hw, reg, value);
 	return E1000_NOT_IMPLEMENTED;
 }
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/base/e1000_osdep.h
index 0cf6da1545..b048d2c08b 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/base/e1000_osdep.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2001 - 2015 Intel Corporation
  */
-/*$FreeBSD$*/
 
 #ifndef _E1000_OSDEP_H_
 #define _E1000_OSDEP_H_
@@ -35,12 +34,24 @@
 #define DEBUGOUT7(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 
 #ifndef UNREFERENCED_PARAMETER
-#define UNREFERENCED_PARAMETER(_p)
+#define UNREFERENCED_PARAMETER(_p) RTE_SET_USED(_p)
 #endif
-#define UNREFERENCED_1PARAMETER(_p)
-#define UNREFERENCED_2PARAMETER(_p, _q)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r)
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s)
+#define UNREFERENCED_1PARAMETER(_p) RTE_SET_USED(_p)
+#define UNREFERENCED_2PARAMETER(_p, _q) do { \
+	RTE_SET_USED(_p); \
+	RTE_SET_USED(_q); \
+} while (0)
+#define UNREFERENCED_3PARAMETER(_p, _q, _r) do { \
+	RTE_SET_USED(_p); \
+	RTE_SET_USED(_q); \
+	RTE_SET_USED(_r); \
+} while (0)
+#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s) do { \
+	RTE_SET_USED(_p); \
+	RTE_SET_USED(_q); \
+	RTE_SET_USED(_r); \
+	RTE_SET_USED(_s); \
+} while (0)
 
 #define FALSE			0
 #define TRUE			1
diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
index 033b3af2e2..8cbd9f62e6 100644
--- a/drivers/net/intel/e1000/base/meson.build
+++ b/drivers/net/intel/e1000/base/meson.build
@@ -23,17 +23,7 @@ sources = [
         'e1000_vf.c',
 ]
 
-error_cflags = [
-        '-Wno-unused-parameter',
-]
-c_args = cflags
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        c_args += flag
-    endif
-endforeach
-
 base_lib = static_library('e1000_base', sources,
     dependencies: static_rte_eal,
-    c_args: c_args)
+    c_args: cflags)
 base_objs = base_lib.extract_all_objects(recursive: true)
-- 
2.43.5

