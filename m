Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7878C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C491E42E94;
	Fri,  7 Feb 2025 13:46:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 362CB42E57
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932382; x=1770468382;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4uPAUxJlNN8iSHYsc4P6RJcffQw/fn/pg321RE20IDY=;
 b=i7UuZuwS6HsbpEMct8an4MKwqY0d/1T2VV0ghgQr6OzBx4QAs49WxXXC
 q4LuyWj8E5aUuT2co622o0Ar5uEq9nM8UbrLNJ/+UOG8/Ty0QKKrHtneN
 5T2cPaZJi0wZpnJJkmStCRZsWWk4ncVBcDGhXNPtx50tfZxWq7iRuAb+0
 G9S8x1Q21PuGnQtGmW+YjPA/GGoKncK5zfzdhyX9s2msXgARGB5kRg9Ox
 VVB7SvASBt1fEniUwQEBgJi6IzDHduWrZ8GV2FoBgoj/JTnA603/EqqkS
 Rgd5rDSDtbBCPjIDVsEfEl/jEsA73vUyQ4fnRk/9R5B42UlJQH5pYB47r A==;
X-CSE-ConnectionGUID: bCfxpcdwThuAY2YvKkNmZw==
X-CSE-MsgGUID: azjAY9ydSgyygDs4FENoNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331855"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331855"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:21 -0800
X-CSE-ConnectionGUID: hKOlsvJJSgmlvkb0AGERFQ==
X-CSE-MsgGUID: 1Ayevc3xSuSbJM2UgNciJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953726"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 23/36] net/e1000/base: improve code flow in ICH8LAN
Date: Fri,  7 Feb 2025 12:45:15 +0000
Message-ID: <c3e42e40d9dedf95407a68b2c0ae3bb82297e54b.1738932115.git.anatoly.burakov@intel.com>
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

From: Piotr Pietruszewski <piotr.pietruszewski@intel.com>

This change rearranges the ICH8LAN code to have less indentation levels.

Signed-off-by: Piotr Pietruszewski <piotr.pietruszewski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 84 ++++++++++----------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 927126b3ab..57c724523c 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -1392,49 +1392,51 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
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

