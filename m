Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF0C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C70342DCB;
	Fri, 31 Jan 2025 13:59:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 449E442DE4
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328389; x=1769864389;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Lbu6Wxr54lx9BwtnkZKKiGNXzoubXdH4/8PACQ+KyxQ=;
 b=kptXBMbNLqpiQiu3SyPcO0mR08cHDN2FXCTCEbTNwcZvUAMBxs26emW8
 Ae4rinQ206HxDC0LpKZWVUMnbcWLpYLVYz8xHHLrgX1nYFN7GELdqjxGD
 VGkzBxK/vfdp9V9SkibO0TljidW3XSntbwziltE59TIc8mw421EFr5kBv
 W7ETjgHzUdjSZtpu6L+QIh931QvSvuVsUSlOnqKGHor1+w6DXr+3P+KEp
 mlEIzMp/Fr+lxkf7uEF/9yLDXbsUgCz5H1DSFgQqQmnebUA5POPlhleRY
 EUq9Ft2C6eOaAYkIlu3WxX9orpkQr1Kb+tWrEoL1VceSfB1k6P2umYzfh w==;
X-CSE-ConnectionGUID: 6qzBtWTcQOCk1pbp0TC+gA==
X-CSE-MsgGUID: 5JPLGzTLRbWIGWX+08sBdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315644"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315644"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:48 -0800
X-CSE-ConnectionGUID: LKuOGO9CRBuNGsjFZpYD6g==
X-CSE-MsgGUID: 14GDTIkZTECNaTxnvgioKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503405"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 22/42] net/e1000/base: improve code flow in ICH8LAN
Date: Fri, 31 Jan 2025 12:58:35 +0000
Message-ID: <799dae1751397a51ec51cbf8975e9f6d32e8f653.1738328107.git.anatoly.burakov@intel.com>
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

From: Piotr Pietruszewski <piotr.pietruszewski@intel.com>

This change rearranges the ICH8LAN code to have less indentation levels.

Signed-off-by: Piotr Pietruszewski <piotr.pietruszewski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 84 ++++++++++----------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 7cbbeae91c..7c89ecb623 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -1390,49 +1390,51 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	if (ret_val)
 		goto release;
 	/* CSC interrupt received due to ULP Indication */
-	if ((phy_reg & I218_ULP_CONFIG1_IND) || force) {
-		phy_reg &= ~(I218_ULP_CONFIG1_IND |
-			     I218_ULP_CONFIG1_STICKY_ULP |
-			     I218_ULP_CONFIG1_RESET_TO_SMBUS |
-			     I218_ULP_CONFIG1_WOL_HOST |
-			     I218_ULP_CONFIG1_INBAND_EXIT |
-			     I218_ULP_CONFIG1_EN_ULP_LANPHYPC |
-			     I218_ULP_CONFIG1_DIS_CLR_STICKY_ON_PERST |
-			     I218_ULP_CONFIG1_DISABLE_SMB_PERST);
-		e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
-
-		/* Commit ULP changes by starting auto ULP configuration */
-		phy_reg |= I218_ULP_CONFIG1_START;
-		e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
-
-		/* Clear Disable SMBus Release on PERST# in MAC */
-		mac_reg = E1000_READ_REG(hw, E1000_FEXTNVM7);
-		mac_reg &= ~E1000_FEXTNVM7_DISABLE_SMB_PERST;
-		E1000_WRITE_REG(hw, E1000_FEXTNVM7, mac_reg);
-
-		if (!force) {
-			hw->phy.ops.release(hw);
-
-			if (hw->mac.autoneg)
-				e1000_phy_setup_autoneg(hw);
-			else
-				e1000_setup_copper_link_generic(hw);
-
-			e1000_sw_lcd_config_ich8lan(hw);
-
-			e1000_oem_bits_config_ich8lan(hw, true);
-
-			/* Set ULP state to unknown and return non-zero to
-			 * indicate no link (yet) and re-enter on the next LSC
-			 * to finish disabling ULP flow.
-			 */
-			hw->dev_spec.ich8lan.ulp_state =
-			    e1000_ulp_state_unknown;
-
-			return 1;
-		}
+	if (!((phy_reg & I218_ULP_CONFIG1_IND) || force))
+		goto omit_ulp_irq_hanlder;
+
+	phy_reg &= ~(I218_ULP_CONFIG1_IND |
+			 I218_ULP_CONFIG1_STICKY_ULP |
+			 I218_ULP_CONFIG1_RESET_TO_SMBUS |
+			 I218_ULP_CONFIG1_WOL_HOST |
+			 I218_ULP_CONFIG1_INBAND_EXIT |
+			 I218_ULP_CONFIG1_EN_ULP_LANPHYPC |
+			 I218_ULP_CONFIG1_DIS_CLR_STICKY_ON_PERST |
+			 I218_ULP_CONFIG1_DISABLE_SMB_PERST);
+	e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
+
+	/* Commit ULP changes by starting auto ULP configuration */
+	phy_reg |= I218_ULP_CONFIG1_START;
+	e1000_write_phy_reg_hv_locked(hw, I218_ULP_CONFIG1, phy_reg);
+
+	/* Clear Disable SMBus Release on PERST# in MAC */
+	mac_reg = E1000_READ_REG(hw, E1000_FEXTNVM7);
+	mac_reg &= ~E1000_FEXTNVM7_DISABLE_SMB_PERST;
+	E1000_WRITE_REG(hw, E1000_FEXTNVM7, mac_reg);
+
+	if (!force) {
+		hw->phy.ops.release(hw);
+
+		if (hw->mac.autoneg)
+			e1000_phy_setup_autoneg(hw);
+		else
+			e1000_setup_copper_link_generic(hw);
+
+		e1000_sw_lcd_config_ich8lan(hw);
+
+		e1000_oem_bits_config_ich8lan(hw, true);
+
+		/* Set ULP state to unknown and return non-zero to
+		 * indicate no link (yet) and re-enter on the next LSC
+		 * to finish disabling ULP flow.
+		 */
+		hw->dev_spec.ich8lan.ulp_state =
+			e1000_ulp_state_unknown;
+
+		return 1;
 	}
 
+omit_ulp_irq_hanlder:
 	/* Re-enable Tx */
 	mac_reg = E1000_READ_REG(hw, E1000_TCTL);
 	mac_reg |= E1000_TCTL_EN;
-- 
2.43.5

