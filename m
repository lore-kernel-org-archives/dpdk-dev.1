Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5568DC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A454842E0C;
	Tue,  4 Feb 2025 16:12:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 72BE842C24
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681936; x=1770217936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qAdgWDN4yqoNjwQqsyng3hpCUvR03gu7dk6GsEKSDhY=;
 b=HhKO04RHaJceaqkcD4iKIY7zyJ4mKWlzQk4GEttTlUwPw0RtS9r/rxyD
 7sS2celoylA5mp8H2saFM6VFs1WZSSOqMv23KoS6qgZdxRdKPhQ69emB/
 k9VDN8JohX90YSygSa80fvQoR1hU42DuncwpLagrPOxXlZbDB1Gf7QhGk
 7FpgZ1fWq8dxyBiNDGgW3qiDJPg9UskICcHaJxf0zm1/ObduM1531yLqS
 lKiAc4vVXldOCsVCEirE8ErbgwrrFt5bbe/QT6NscRVwzZWVtJ8ybdMN0
 0w7JTLFvCE4aksZDPsMoFBi04YWflYHP2SHq/NqwPHJi8m+1qvipgUSip Q==;
X-CSE-ConnectionGUID: enqiZ3AfS2uzIK1W4fTugA==
X-CSE-MsgGUID: 1+V9lxrPSUOK6Scw8Bcwgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097165"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097165"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:16 -0800
X-CSE-ConnectionGUID: HJ8dZtkUTZGwIReaOgWrpg==
X-CSE-MsgGUID: OxUv92NyQ/m0z4wytLnODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792746"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:14 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 38/54] net/e1000/base: make debug prints more informative
Date: Tue,  4 Feb 2025 15:10:44 +0000
Message-ID: <be25e0ec916bf7a237d5dd0924572602bdf5fa5a.1738681726.git.anatoly.burakov@intel.com>
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

PHY page and register notation traditionally uses decimal numbering. This
patch aligns the debug prints to this notation, as well as moves prints
to after we get a value of interest to us.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 4810022fa0..cc1efddceb 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -690,7 +690,7 @@ s32 e1000_set_page_igp(struct e1000_hw *hw, u16 page)
 {
 	DEBUGFUNC("e1000_set_page_igp");
 
-	DEBUGOUT1("Setting page 0x%x\n", page);
+	DEBUGOUT2("Setting page %d (0x%x)\n", page >> IGP_PAGE_SHIFT, page);
 
 	hw->phy.addr = 1;
 
@@ -3520,8 +3520,6 @@ s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
 		}
 	}
 
-	DEBUGOUT2("Accessing PHY page %d reg 0x%x\n", page, reg);
-
 	/* Write the Wakeup register page offset value using opcode 0x11 */
 	ret_val = e1000_write_phy_reg_mdic(hw, BM_WUC_ADDRESS_OPCODE, reg);
 	if (ret_val) {
@@ -3533,10 +3531,14 @@ s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
 		/* Read the Wakeup register page value using opcode 0x12 */
 		ret_val = e1000_read_phy_reg_mdic(hw, BM_WUC_DATA_OPCODE,
 						  data);
+		DEBUGOUT3("Read PHY page %d reg %d value 0x%04x\n",
+			  page, reg, *data);
 	} else {
 		/* Write the Wakeup register page value using opcode 0x12 */
 		ret_val = e1000_write_phy_reg_mdic(hw, BM_WUC_DATA_OPCODE,
 						   *data);
+		DEBUGOUT3("Wrote PHY page %d reg %d value 0x%04x\n",
+			  page, reg, *data);
 	}
 
 	if (ret_val) {
@@ -3644,11 +3646,11 @@ STATIC s32 __e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data,
 		}
 	}
 
-	DEBUGOUT3("reading PHY page %d (or 0x%x shifted) reg 0x%x\n", page,
-		  page << IGP_PAGE_SHIFT, reg);
-
 	ret_val = e1000_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & reg,
 					  data);
+	DEBUGOUT3("read PHY page %d reg %d value 0x%04x\n",
+		  page, reg, *data);
+
 out:
 	if (!locked)
 		hw->phy.ops.release(hw);
@@ -3770,8 +3772,8 @@ STATIC s32 __e1000_write_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 data,
 		}
 	}
 
-	DEBUGOUT3("writing PHY page %d (or 0x%x shifted) reg 0x%x\n", page,
-		  page << IGP_PAGE_SHIFT, reg);
+	DEBUGOUT3("writing PHY page %d reg %d value 0x%04x\n",
+		  page, reg, data);
 
 	ret_val = e1000_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & reg,
 					   data);
-- 
2.43.5

