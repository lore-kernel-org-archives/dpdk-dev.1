Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5EBC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1A0A410E4;
	Tue,  4 Feb 2025 16:11:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 259D3410D4
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681894; x=1770217894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=875fiFfRrVwLu5hTlySQVd/H7q60EAkcVTRqJ8y3fC0=;
 b=UqLbXYOH9LeblVVwH6OgUaDmSxK95xWyR6/5LkYflAvw5v78hg39YQwD
 /Xx3rS+ZGlQJDv0vEvDhbsa2ksS7OwodsFCumBJBGW0FvYpUvYlp2CtqT
 kMGLTuIEKndGvkck/zgGnrRZHhDhPE6KgDJNJx1/c7PQnqsjxrPoT1G/Z
 SpmCqmjd3S/zD1dpA1dSmAFDwWe9NhJbvHRdf2cJPBRhgDXu2NKdnF69D
 XLP1Q2bRW6qH9I3UG1aURtwZDIeCKZdjIyDx0EaOFRMC8jS+IHpQoN6+D
 Ul3OkXR5MGDUxJ0GBtaGX74ygjxaUG1wxDcFGCrRvd6/4cMQwuDFdgWDE w==;
X-CSE-ConnectionGUID: WkY7+B76Q96TOGZ33AJB8g==
X-CSE-MsgGUID: pCNgKK2wQTG0n/y0uL0k8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097095"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097095"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:33 -0800
X-CSE-ConnectionGUID: QFHL1/HIToac8QbwNIVePQ==
X-CSE-MsgGUID: Co+TP1SYTVye7fEn+pebjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792564"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 04/54] net/e1000/base: remove unused parameter workaround
Date: Tue,  4 Feb 2025 15:10:10 +0000
Message-ID: <39c610c0d023b0e5a24d973b92b0c75896ee6723.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_osdep.c | 10 ++++++---
 drivers/net/intel/e1000/base/e1000_osdep.h | 26 +++++++++++++++++-----
 drivers/net/intel/e1000/base/meson.build   | 12 +---------
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_osdep.c b/drivers/net/intel/e1000/base/e1000_osdep.c
index 55265931b9..23f9556fd8 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.c
+++ b/drivers/net/intel/e1000/base/e1000_osdep.c
@@ -6,7 +6,7 @@
 #include "e1000_api.h"
 
 /*
- * NOTE: the following routines using the e1000 
+ * NOTE: the following routines using the e1000
  * 	naming style are provided to the shared
  *	code but are OS specific
  */
@@ -14,24 +14,26 @@
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
 
 
@@ -41,6 +43,7 @@ e1000_pci_clear_mwi(struct e1000_hw *hw)
 int32_t
 e1000_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
+	UNREFERENCED_3PARAMETER(hw, reg, value);
 	return E1000_NOT_IMPLEMENTED;
 }
 
@@ -50,5 +53,6 @@ e1000_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 int32_t
 e1000_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
 {
+	UNREFERENCED_3PARAMETER(hw, reg, value);
 	return E1000_NOT_IMPLEMENTED;
 }
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/base/e1000_osdep.h
index 0cf6da1545..7b29a526b4 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/base/e1000_osdep.h
@@ -35,12 +35,28 @@
 #define DEBUGOUT7(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 
 #ifndef UNREFERENCED_PARAMETER
-#define UNREFERENCED_PARAMETER(_p)
+#define UNREFERENCED_PARAMETER(_p) do { \
+	RTE_SET_USED(_p); \
+} while (0)
 #endif
-#define UNREFERENCED_1PARAMETER(_p)
-#define UNREFERENCED_2PARAMETER(_p, _q)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r)
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s)
+#define UNREFERENCED_1PARAMETER(_p) do { \
+	RTE_SET_USED(_p); \
+} while (0)
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

