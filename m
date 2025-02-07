Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E9C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F09C42EAA;
	Fri,  7 Feb 2025 13:46:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 1EBBB42E1D
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932387; x=1770468387;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7qYxkkBXAqm2w+lCvn2VStadO15WcA9PM5Vvai5FLRE=;
 b=Z0RRC4Wa9b2FGRn/HqvUcXPwzqNsoOhzqlJlQ4HkJ7PfKX914U9wxo3i
 1tzmWLllaZ5kyBtwL3hB5xrzjcxSQVIuZsRSgaNKbNAtc2P9vXzFDhrHC
 DDwbIKPvv3PRN4FjMWIDFlFcIytO4OGc5z4WbaypXR0wyspCr1u/GbC4v
 dysKT1PDUYVNODrIE8cJAmbcnZF1JxC3tjs1rsN8uZz+6v36KjiGJU09C
 ca8Zr8ftsgmXYcmaqrkBKbuE3mR06GzTzu8Vzna5Mo4tOkywE0yBKRIPI
 QAzG+qNlCrnyLHsCZ+k4J9CTiq1BB3tGT6+y+cdRAQRIw3pqLL/zeoM5m A==;
X-CSE-ConnectionGUID: WPccFo5nRE+OSe4/VWwy/A==
X-CSE-MsgGUID: TDpXAVuZTmWjAqNsfCShJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331871"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:26 -0800
X-CSE-ConnectionGUID: 37jm1SR0RFOGUI/CIiz00w==
X-CSE-MsgGUID: wLQhqkh4SLiDMtVEKY3XiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953780"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 27/36] net/e1000/base: make debug prints more informative
Date: Fri,  7 Feb 2025 12:45:19 +0000
Message-ID: <e87ca654f63bbd5bbc8ab7cf5567b8159686d4bb.1738932115.git.anatoly.burakov@intel.com>
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

PHY page and register notation traditionally uses decimal numbering. This
patch aligns the debug prints to this notation, as well as moves prints
to after we get a value of interest to us.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 93a0b02998..d74bb2fd6e 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -690,7 +690,7 @@ s32 e1000_set_page_igp(struct e1000_hw *hw, u16 page)
 {
 	DEBUGFUNC("e1000_set_page_igp");
 
-	DEBUGOUT1("Setting page 0x%x\n", page);
+	DEBUGOUT2("Setting page %d (0x%x)\n", page >> IGP_PAGE_SHIFT, page);
 
 	hw->phy.addr = 1;
 
@@ -3521,8 +3521,6 @@ s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
 		}
 	}
 
-	DEBUGOUT2("Accessing PHY page %d reg 0x%x\n", page, reg);
-
 	/* Write the Wakeup register page offset value using opcode 0x11 */
 	ret_val = e1000_write_phy_reg_mdic(hw, BM_WUC_ADDRESS_OPCODE, reg);
 	if (ret_val) {
@@ -3534,10 +3532,14 @@ s32 e1000_access_phy_wakeup_reg_bm(struct e1000_hw *hw, u32 offset,
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
@@ -3645,11 +3647,11 @@ STATIC s32 __e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data,
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
@@ -3771,8 +3773,8 @@ STATIC s32 __e1000_write_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 data,
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

