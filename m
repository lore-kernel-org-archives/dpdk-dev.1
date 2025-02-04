Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61243C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F2B342DDE;
	Tue,  4 Feb 2025 16:12:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 17701427E3
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681935; x=1770217935;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SXQzf8x9KqP+bIt76wz9yynDSoGvfkbbEMTLBWaOJh0=;
 b=iFXO/k/A6vlC0ax3UnvuRE3y0rIAoAFJbR05CehRLd5ddBW+lqobz4qS
 3b3CdsWK8fVkxvDTRTrudg3WrLWJESG3uNwZ9WbgcScaMiyzIJk0PzCiM
 tWSCQseaG4ng4z88P7HuiEXVrFJgxbjdeOlrKnyK+e5MlgPayOCIM503Q
 e8Lq5HWI82oJWTPZRXWZgnoEJN661W1NJn7RaSb0oEm9iIRKDaa5rJ2O/
 00GV8FywOx6VMnrvcMG8gjIfW2wwhH+i1akmuOG1dwLYFt19ypzGQFRVa
 vo/2RoI5MELuKtRCbooYzlyL8Yu7+bnOdqWIW41U1bZ6PoA1QI/mV1RZq Q==;
X-CSE-ConnectionGUID: 3SIyBCyrRpmFTVUpKlcDyQ==
X-CSE-MsgGUID: hBCKKfMPRNGzLqNqubaP2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097161"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097161"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:14 -0800
X-CSE-ConnectionGUID: Addh5l98TYS6Kbb1sBvc9Q==
X-CSE-MsgGUID: hyEncV4mSHKfTRsGjLAhpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792742"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 37/54] net/e1000/base: make e1000_access_phy_wakeup_reg_bm
 non-static
Date: Tue,  4 Feb 2025 15:10:43 +0000
Message-ID: <89d28a1297c9405a5c62e34af44f2bb6d2136e66.1738681726.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Mark e1000_access_phy_wakeup_reg_bm as non-static.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 6 ++----
 drivers/net/intel/e1000/base/e1000_phy.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 5ac8322af3..4810022fa0 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -5,8 +5,6 @@
 #include "e1000_api.h"
 
 STATIC s32 e1000_wait_autoneg(struct e1000_hw *hw);
-STATIC s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
-					  u16 *data, bool read, bool page_set);
 STATIC u32 e1000_get_phy_addr_for_hv_page(u32 page);
 STATIC s32 e1000_access_phy_debug_regs_hv(struct e1000_hw *hw, u32 offset,
 					  u16 *data, bool read);
@@ -3497,8 +3495,8 @@ s32 e1000_disable_phy_wakeup_reg_access_bm(struct e1000_hw *hw, u16 *phy_reg)
  *  the PHY page is set to BM_WUC_PAGE (i.e. a function in the call stack
  *  is responsible for calls to e1000_[enable|disable]_phy_wakeup_reg_bm()).
  **/
-STATIC s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
-					  u16 *data, bool read, bool page_set)
+s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
+				   u16 *data, bool read, bool page_set)
 {
 	s32 ret_val;
 	u16 reg = BM_PHY_REG_NUM(offset);
diff --git a/drivers/net/intel/e1000/base/e1000_phy.h b/drivers/net/intel/e1000/base/e1000_phy.h
index a7834240e0..f15f45011f 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.h
+++ b/drivers/net/intel/e1000/base/e1000_phy.h
@@ -62,6 +62,8 @@ s32  e1000_write_phy_reg_bm(struct e1000_hw *hw, u32 offset, u16 data);
 s32  e1000_read_phy_reg_bm(struct e1000_hw *hw, u32 offset, u16 *data);
 s32  e1000_enable_phy_wakeup_reg_access_bm(struct e1000_hw *hw, u16 *phy_reg);
 s32  e1000_disable_phy_wakeup_reg_access_bm(struct e1000_hw *hw, u16 *phy_reg);
+s32  e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
+				    u16 *data, bool read, bool page_set);
 s32  e1000_read_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 *data);
 s32  e1000_write_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 data);
 void e1000_power_up_phy_copper(struct e1000_hw *hw);
-- 
2.43.5

