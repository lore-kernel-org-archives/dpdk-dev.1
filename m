Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2856DC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41EE142E71;
	Fri, 31 Jan 2025 14:00:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 796F042E5A
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328392; x=1769864392;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=acL2KoqFksgOt3CUV0HWSO9tK4ZAFPGR2ID+XbgGwTc=;
 b=cwozbcLkNypbc0uzKpOegeZwDLEvqUX3AuNRu/S/6a5cOdXgvEGjTN3e
 WEsmt+WyB6aremBJXMRHdP8jeQ7tqhSiVNZL7N/N1qth9Pu+fH6PGdC6k
 OatmYGUmovn/t96bR2Albaozp1JIpTTWajiIaZYqwxQjpfIpB2TQWMufm
 v9NiwmThQ+15rowhfA/7hUDTTQhBVJxW7TAEzReLOZdY5cRF23fltNtmo
 JmRpgJJIuWgIPdbGiKyB+GXllQE4sqi9/ml3IZWeI+1HEtQA8pu23Y4QF
 N15JbJRUK5Tnzx6+yvz90ULsD7tn51LQRxwan+7zU+nmZx837CsuK/6cN A==;
X-CSE-ConnectionGUID: rlxWLW/2R9m7TaNOawMsZw==
X-CSE-MsgGUID: pCpbdmcFQgKcuywWeqjMmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315648"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:51 -0800
X-CSE-ConnectionGUID: 87RMbGUwQIic0xVgVh3RZg==
X-CSE-MsgGUID: EoLSWM8jQbWqonz+1QvM4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503408"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 25/42] net/e1000/base: make e1000_access_phy_wakeup_reg_bm
 non-static
Date: Fri, 31 Jan 2025 12:58:38 +0000
Message-ID: <dfa9e59c1fb3fc0f3c36ae41c89ea28537a4b4b5.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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
index 102fae6bf0..50f760583d 100644
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

