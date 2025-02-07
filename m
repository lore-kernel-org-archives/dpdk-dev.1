Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0693C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D3642EA8;
	Fri,  7 Feb 2025 13:46:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C3D7142E4C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932385; x=1770468385;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CwOargFnItzjVc6RZkLQq/11jzNp+yt1HgdtpHhxE0E=;
 b=RU46EVIZEje+09yK206MR3yNygItuzsPdy68l1d7ri/MkktvX5UCh3zK
 twTmb9TWBAb8Y4q0rHXEMFolACIP+W5VIkF5nkyMUPUfs5zZqW2hZM/PS
 xkNMIB2hBxPByldNfeWssqeTl4aMjOdKBzutrfMgNbDqDu/IUp07FiUjt
 drUUM0Cs6fXBXiTwM+eYU9lnCxxquxO9pkuyQ3tcGWpmHMZfxnymZHuMG
 p62wnDLQ/FSRcbj/MT59FkXBcCD/2yTiXY06gGIcRutdmkD5GSKPdwUC7
 2mqN3nf1519DUXRfScQOWvMkjYfVosXQ5UwHvsRv1TfDDOir4fyH/zlCr w==;
X-CSE-ConnectionGUID: FD93rDzkR0SQk66QjQ6YcQ==
X-CSE-MsgGUID: gHkpSj4qQiurtHVV+wZACw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331865"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331865"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:25 -0800
X-CSE-ConnectionGUID: IeLNro7jS0KhQXC4V93mcg==
X-CSE-MsgGUID: Z7CvkLxwT3uFxlNNeoi/Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953770"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 26/36] net/e1000/base: make PHY wakeup access non-static
Date: Fri,  7 Feb 2025 12:45:18 +0000
Message-ID: <c9ece4974ba3e313f6ce88e51a25ba51cb567f89.1738932115.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Mark e1000_access_phy_wakeup_reg_bm function as non-static.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 6 ++----
 drivers/net/intel/e1000/base/e1000_phy.h | 2 ++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index d3d7ff6ba8..93a0b02998 100644
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
@@ -3498,8 +3496,8 @@ s32 e1000_disable_phy_wakeup_reg_access_bm(struct e1000_hw *hw, u16 *phy_reg)
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

