Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EDC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D74442E88;
	Fri,  7 Feb 2025 13:46:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 30E7E42E85
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932376; x=1770468376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XmFnNEHA/AMXRYF8E3bpNsIpmp/EtzpYJJmUtDB9dwE=;
 b=DrkTRoUg72eKa79DQ69n2wT2/2x80vFSM+bKPgouNC+9T+n7m9vE8Wzd
 JRZR7AaHLsYMJc0NldT3X4PinsMysdfRnmFvUEIw/fC0iPj03sBJba2bA
 ZrnBtDU5BuAYAdBKtx4ULmqMr0R7U8xy6mpV5AG91/4FiF3i5Dt2MQxJr
 fgme9hFGZoG3moO0uHydAdqSoKEIOO8GQQ/FBFu33tV2YnvrHdk8ha76p
 A0FZ4vuldJ/fXrnleV9/Qsh7xQIfDNYQLhokXUL9lSQR3y+SW7Mt0GPar
 CD9O1J5z/ZFDt1TfbHvaC6B3B/hfgPf0aOFktx77+zn4pj0P/gtXTIB7W w==;
X-CSE-ConnectionGUID: L6xEKOKCTBW5jFUR5h77lA==
X-CSE-MsgGUID: qqERlfa2SiihIBvAGNoFpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331844"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:15 -0800
X-CSE-ConnectionGUID: TVG3Ae35R4KIJ+0NkCjm0A==
X-CSE-MsgGUID: /gaXNfx5T6Wqtst0Wyd7Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953672"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:14 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 18/36] net/e1000/base: workaround for packet loss
Date: Fri,  7 Feb 2025 12:45:10 +0000
Message-ID: <918bc29a0486b5136fc9bb86800d61ffa88706f3.1738932115.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

On some MAC types, packet loss is observed due to wake DMA clock gating.
Disable wake DMA clock for some MAC types to avoid packet loss.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 7 +++++++
 drivers/net/intel/e1000/base/e1000_ich8lan.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 18e193861e..927126b3ab 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -5050,6 +5050,7 @@ STATIC s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
 	u32 ctrl_ext, txdctl, snoop;
+	u32 mac_reg;
 	s32 ret_val;
 	u16 i;
 
@@ -5110,6 +5111,12 @@ STATIC s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 		snoop = (u32) ~(PCIE_NO_SNOOP_ALL);
 	e1000_set_pcie_no_snoop_generic(hw, snoop);
 
+	/* Enable workaround for packet loss issue on TGL/ADL platforms */
+	if (mac->type == e1000_pch_tgp || mac->type == e1000_pch_adp) {
+		mac_reg = E1000_READ_REG(hw, E1000_FFLT_DBG);
+		mac_reg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
+		E1000_WRITE_REG(hw, E1000_FFLT_DBG, mac_reg);
+	}
 	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	ctrl_ext |= E1000_CTRL_EXT_RO_DIS;
 	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index e456e5132e..4780417bae 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -277,7 +277,7 @@
 #define E1000_PCH_RAICC(_n)	(0x05F50 + ((_n) * 4))
 
 #define E1000_PCI_VENDOR_ID_REGISTER	0x00
-
+#define E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK 0x1000
 #define E1000_PCI_REVISION_ID_REG	0x08
 void e1000_set_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw,
 						 bool state);
-- 
2.43.5

