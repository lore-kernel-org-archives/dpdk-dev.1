Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2831C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70C7C42E77;
	Fri, 31 Jan 2025 14:00:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 90CD9427B8
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328393; x=1769864393;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vxwZbDw7VuQQffVIAHINJPDY58EbCfImWktV3c+U2B4=;
 b=NoFcHNJq396U+Wn12tZ3xVlMR8rflTVzuiV+Js1aYUVWc+dJVzosThW8
 o0ktHyi31rP0ztYOTKqB9XT54e1fvsLQJ2FUbfZujNHn1Jkd7EtxDL4Zc
 GMrR/NOSZccwxljUi16xH9xlUQ2gdTilJCqkajpXMk/mHJoVWCVWnrGlP
 /JW2CsWbWKIao/xqbhbxxybQJhrv42Ufmtqbof0OWUvsxZ3jTDs5+gW6m
 lnfcpkiSwAR8I/OXrYOURpch57lD7LmhYCaw+gN+ofb6TqR58jEyZTql6
 qfgbd9cQ8/Y/mIVQQH9YLd3kRf0wVnJa6/CC5QrTr/5CEzjUT7kJ0sahd w==;
X-CSE-ConnectionGUID: E5E8Sf9WQeGChprFCoMctA==
X-CSE-MsgGUID: t00dHUBOQom5dzv0Di1igQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315649"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:52 -0800
X-CSE-ConnectionGUID: p0wx96ijRXqhEtcUQYwsZg==
X-CSE-MsgGUID: EsTOh8NgQImXel2rlexNmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503409"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 26/42] net/e1000/base: make debug prints more informative
Date: Fri, 31 Jan 2025 12:58:39 +0000
Message-ID: <0a16b441a935267f39ceea52d657ea472ffbea4b.1738328107.git.anatoly.burakov@intel.com>
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

PHY page and register notation traditionally uses decimal numbering. This
patch aligns the debug prints to this notation, as well as moves prints
to after we get a value of interest to us.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 50f760583d..05e6062ae7 100644
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

