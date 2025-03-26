Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAEDC3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 15:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B835D40671;
	Wed, 26 Mar 2025 16:52:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id BF71A4065B;
 Wed, 26 Mar 2025 16:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743004363; x=1774540363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I2L+i6K7bAziiy5Tk2INWAkXyhJSzRDIRTonCKRWtAY=;
 b=TRTuyJYiqlUB6HU/6qNYg1KBptvBCBRgUZcxmV2aylfjZVntd627PpNh
 ZZfeg3L5HyitlWTzKSexAmlSroyj9mz0P2X/MIGVztE8KE3yzjsiAR84h
 Ni/XLB+YqGBePBOLgLbKZUq7VEfvnsZm459X/yb/VVDKkIPEwIRrCZkAz
 VBFNRo3rm/sPV1ddeaOYzc7ZZPoLc1F1J1NQHOMLPqLYvT1UN/WD9Wf7g
 ocHQTj7vcXOP8mffs5vAIwb9VwQjQrj3q/Xe+RYJuPr7qhbaiqqBlnRfo
 YAswelfECJOTu+z8GdIBcFsPeJFz3GvgDxbP6EW2lWPN62BYReMrO2/Bh w==;
X-CSE-ConnectionGUID: 3W2cL5ysRYaoLPqE0k3T+A==
X-CSE-MsgGUID: 70IXa5WaQbe2e1yFKJu4Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188322"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="44188322"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 08:52:42 -0700
X-CSE-ConnectionGUID: LliWCA0HT/OGYxl+WggfrA==
X-CSE-MsgGUID: 7GJ7ieQBRVm2LKMPy9RXbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="124550902"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 08:52:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH 3/7] net/ixgbe/base: fix compilation warnings
Date: Wed, 26 Mar 2025 15:52:25 +0000
Message-ID: <20250326155230.1315056-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326155230.1315056-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
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

We can remove almost all of the "unused parameter" and "unused variable"
warnings by just improving the macro definitions in the osdep.h header.
Remaining two instances can be fixed by just one-line additions to the
code, so add those to give us a clean build with the warnings enabled.

Fixes: af75078fece3 ("first public release")
Fixes: c6cb313da739 ("net/ixgbe/base: add link management for E610")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_e610.c  |  2 ++
 drivers/net/intel/ixgbe/base/ixgbe_osdep.h | 19 +++++++++++--------
 drivers/net/intel/ixgbe/base/meson.build   | 11 -----------
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_e610.c b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
index 5474c3012a..7420c78d07 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_e610.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_e610.c
@@ -1054,6 +1054,7 @@ static void ixgbe_parse_vsi_func_caps(struct ixgbe_hw *hw,
 				      struct ixgbe_hw_func_caps *func_p,
 				      struct ixgbe_aci_cmd_list_caps_elem *cap)
 {
+	UNREFERENCED_PARAMETER(cap);
 	func_p->guar_num_vsi = ixgbe_get_num_per_func(hw, IXGBE_MAX_VSI);
 }
 
@@ -1770,6 +1771,7 @@ s32 ixgbe_aci_set_event_mask(struct ixgbe_hw *hw, u8 port_num, u16 mask)
 	struct ixgbe_aci_cmd_set_event_mask *cmd;
 	struct ixgbe_aci_desc desc;
 
+	UNREFERENCED_PARAMETER(port_num);
 	cmd = &desc.params.set_event_mask;
 
 	ixgbe_fill_dflt_direct_cmd_desc(&desc, ixgbe_aci_opc_set_event_mask);
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
index 6e5f7b4ae8..398c38bffd 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_osdep.h
@@ -57,13 +57,16 @@
 
 /* Bunch of defines for shared code bogosity */
 #ifndef UNREFERENCED_PARAMETER
-#define UNREFERENCED_PARAMETER(_p)  
+#define UNREFERENCED_PARAMETER(_p) (void)(_p)
 #endif
-#define UNREFERENCED_1PARAMETER(_p) 
-#define UNREFERENCED_2PARAMETER(_p, _q)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r) 
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s) 
-#define UNREFERENCED_5PARAMETER(_p, _q, _r, _s, _t)
+#define UNREFERENCED_1PARAMETER(_p) (void)(_p)
+#define UNREFERENCED_2PARAMETER(_p, _q) do { (void)(_p); (void)(_q); } while(0)
+#define UNREFERENCED_3PARAMETER(_p, _q, _r) \
+	do { (void)(_p); (void)(_q); (void)(_r); } while(0)
+#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s) \
+	do { (void)(_p); (void)(_q); (void)(_r); (void)(_s); } while(0)
+#define UNREFERENCED_5PARAMETER(_p, _q, _r, _s, _t) \
+	do { (void)(_p); (void)(_q); (void)(_r); (void)(_s); (void)(_t); } while(0)
 
 /* Shared code error reporting */
 enum {
@@ -130,8 +133,8 @@ static inline uint32_t ixgbe_read_addr(volatile void* addr)
 	IXGBE_PCI_REG_ADDR((hw), (reg) + ((index) << 2))
 
 /* Not implemented !! */
-#define IXGBE_READ_PCIE_WORD(hw, reg) 0	
-#define IXGBE_WRITE_PCIE_WORD(hw, reg, value) do { } while(0)
+#define IXGBE_READ_PCIE_WORD(hw, reg)  ((void)hw, (void)(reg), 0)
+#define IXGBE_WRITE_PCIE_WORD(hw, reg, value) do { (void)hw; (void)reg; (void)value; } while(0)
 
 #define IXGBE_WRITE_FLUSH(a) IXGBE_READ_REG(a, IXGBE_STATUS)
 
diff --git a/drivers/net/intel/ixgbe/base/meson.build b/drivers/net/intel/ixgbe/base/meson.build
index f8b2ee6341..64e0bfd7be 100644
--- a/drivers/net/intel/ixgbe/base/meson.build
+++ b/drivers/net/intel/ixgbe/base/meson.build
@@ -19,17 +19,6 @@ sources = [
         'ixgbe_x550.c',
 ]
 
-error_cflags = [
-        '-Wno-unused-but-set-variable',
-        '-Wno-unused-parameter',
-        ]
-c_args = cflags
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        c_args += flag
-    endif
-endforeach
-
 base_lib = static_library('ixgbe_base', sources,
     dependencies: [static_rte_eal, static_rte_net],
     c_args: c_args)
-- 
2.45.2

