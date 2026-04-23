Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9107FAD3F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AF1C40B99;
	Thu, 23 Apr 2026 05:41:40 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 191CA40BA2;
 Thu, 23 Apr 2026 05:41:37 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915693tc9974c23
X-QQ-Originating-IP: SgBYbve6Gl9F2iqxcEM9Hlx6eddR9l5olQTZco7X56c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11011146621333207642
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 16/18] net/txgbe: fix SFP module identification
Date: Thu, 23 Apr 2026 11:40:21 +0800
Message-Id: <20260423034024.14404-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NKtNg66QPLma9036RSo2GEWc0ZUbhS6vg3iwu1WrYu527qIsoyvH5QX5
 AdDgWi9tjotCl4nhlly/YBCDG+6Z+JrZfBjSKVpwsq+jKWM018YcBdTe6t/D7nd+tOUZ/pj
 zIsUzd1LBWlvY5N74EzOxiheDSkau93lRdtYLM5ko1YFvH0loBlfR7jIjjN5W1jhdTrcG7C
 wTt51lu7SnM04yYkQY65glh2G66cHzIBFmqcxkgn+dWCoN/dlEG/54OyjSAZPf8y6GIs+om
 h8aCM9rLK4SYsXEb2rofnfXFOxHekbjRswV16XlBR8kluBVXCjRAofhyH+skZpJJBkX/OJM
 gPQD3VGp+kyBpT1P2aYubf90SQ0dGAOCW211eBn/lkvuaDHZ9pT6yR8uJQ7YnVPwedQNKiV
 nJ/ACp7SunmIWFJzRTjptJK2DePNndQUTf3BhT07XmLUNhTgwLeJN/kds9NSjm9oZu6Xme6
 x0SlcqtDq80hHXqf5D2sPyYSBTFMfniBpkFfv2kCf8yCCm2boiMIlD7sknvbX/JxMDBLDJp
 OXropvuX2vPxPABhFOg5xG26DHuwP2RXt6kDGIaUqBl9wUi7YrKImHeGVJfmdaHZ33jJVij
 a+21l4CA3kQ5xKo4PdOGd1fGc13PzWQuYZRX5D91IabBFioEDBwaBcRVgxXouusUEC1yshc
 ln0AUimryr3cozO5ZSqjyL7Z3q0WQowWTdVREaULLqSKwz97bEUgkBQWvwqTga/Fz783NEQ
 opqnnyHALBFo7NlxOrYuWjVh5Oqqf8nXiVJg5joTG1JNMAm5tUIU1HwCKlrCBZHa1qHzzZc
 9opRTRX2Mwd2uY9a/JNm16A24MBUTSjqxNYujBdgWHU10P1ch8aG+oZja/s5vn11yAINC+T
 MniD5q8TL3wv9oJLGs8yBnXUHN4VEXPs1HEAaCDuNAni6tijYRTlGKNw9nodi8YBGi/xqS8
 /lW9zPhx6b1qcQIWZ48mlwvdL1a9Mpv3eIRk7dNw+hfOI9yUipWvQ2ZKZFVh1EJ+0E+0oP8
 pvq9FXdqWuS3xgreoeaLDcrk/8vT3XlmnS2Fs2ROpkPoCeDYlNBps1BMLv9wJ2vdlerFw43
 BA6dzde9rA6
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

Some optical modules were not correctly recognized due to ambiguous
classification in the original detection flow. Rework the module
identification logic to cover all module types. Also narrow the
I2C lock scope to avoid potential race conditions during module
access.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   |   2 -
 drivers/net/txgbe/base/txgbe_phy.c  | 339 ++++++++++------------------
 drivers/net/txgbe/base/txgbe_phy.h  |  18 +-
 drivers/net/txgbe/base/txgbe_type.h |   2 +
 4 files changed, 132 insertions(+), 229 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 1a297acaa6..a57f7ea097 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2907,8 +2907,6 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	phy->read_i2c_eeprom = txgbe_read_i2c_eeprom;
 	phy->write_i2c_eeprom = txgbe_write_i2c_eeprom;
 	phy->identify_sfp = txgbe_identify_module;
-	phy->read_i2c_byte_unlocked = txgbe_read_i2c_byte_unlocked;
-	phy->write_i2c_byte_unlocked = txgbe_write_i2c_byte_unlocked;
 	phy->check_overtemp = txgbe_check_overtemp;
 	phy->reset = txgbe_reset_phy;
 	phy->set_link_hostif = txgbe_hic_ephy_set_link;
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index f3e3491b30..e46a5d7957 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -830,6 +830,10 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 		return TXGBE_ERR_SFP_NOT_PRESENT;
 	}
 
+	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	if (err)
+		return -EBUSY;
+
 	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_IDENTIFIER,
 					     &identifier);
 	if (err != 0) {
@@ -839,11 +843,13 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 			hw->phy.id = 0;
 			hw->phy.type = txgbe_phy_unknown;
 		}
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 		return TXGBE_ERR_SFP_NOT_PRESENT;
 	}
 
 	if (identifier != TXGBE_SFF_IDENTIFIER_SFP) {
 		hw->phy.type = txgbe_phy_sfp_unsupported;
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 		return TXGBE_ERR_SFP_NOT_SUPPORTED;
 	}
 
@@ -888,7 +894,42 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	  * 11  SFP_1g_sx_CORE0 - chip-specific
 	  * 12  SFP_1g_sx_CORE1 - chip-specific
 	  */
-	if (cable_tech & TXGBE_SFF_CABLE_DA_ACTIVE) {
+	if (cable_tech & TXGBE_SFF_CABLE_DA_PASSIVE) {
+		if (hw->bus.lan_id == 0)
+			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core0;
+		else
+			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core1;
+
+		if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
+		    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1) {
+			hw->dac_sfp = true;
+		}
+
+		if (comp_copper_len == TXGBE_SFF_COPPER_1M)
+			hw->bypass_ctle = true;
+		else
+			hw->bypass_ctle = false;
+
+		if (comp_codes_25g == TXGBE_SFF_25GBASECR_91FEC ||
+		    comp_codes_25g == TXGBE_SFF_25GBASECR_74FEC ||
+		    comp_codes_25g == TXGBE_SFF_25GBASECR_NOFEC) {
+			hw->phy.fiber_suppport_speed =
+				TXGBE_LINK_SPEED_25GB_FULL |
+				TXGBE_LINK_SPEED_10GB_FULL;
+		} else {
+			hw->phy.fiber_suppport_speed |=
+				TXGBE_LINK_SPEED_10GB_FULL;
+		}
+	} else if (comp_codes_25g == TXGBE_SFF_25GAUI_C2M_AOC_BER_5 ||
+		   comp_codes_25g == TXGBE_SFF_25GAUI_C2M_ACC_BER_5 ||
+		   comp_codes_25g == TXGBE_SFF_25GAUI_C2M_AOC_BER_12 ||
+		   comp_codes_25g == TXGBE_SFF_25GAUI_C2M_ACC_BER_12) {
+			hw->dac_sfp = false;
+			hw->phy.sfp_type = (hw->bus.lan_id == 0
+				? txgbe_sfp_type_25g_aoc_core0
+				: txgbe_sfp_type_25g_aoc_core1);
+	} else if (cable_tech & TXGBE_SFF_CABLE_DA_ACTIVE) {
+		hw->dac_sfp = false;
 		err = hw->phy.read_i2c_eeprom(hw,
 			TXGBE_SFF_CABLE_SPEC_COMP, &cable_spec);
 		if (err != 0)
@@ -1005,6 +1046,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	/* Allow any DA cable vendor */
 	if (cable_tech & (TXGBE_SFF_CABLE_DA_PASSIVE |
 			  TXGBE_SFF_CABLE_DA_ACTIVE)) {
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 		return 0;
 	}
 
@@ -1017,6 +1059,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	      hw->phy.sfp_type == txgbe_sfp_type_1g_sx_core0 ||
 	      hw->phy.sfp_type == txgbe_sfp_type_1g_sx_core1)) {
 		hw->phy.type = txgbe_phy_sfp_unsupported;
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 		return TXGBE_ERR_SFP_NOT_SUPPORTED;
 	}
 
@@ -1031,9 +1074,11 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	      hw->phy.sfp_type == txgbe_sfp_type_1g_sx_core1)) {
 		DEBUGOUT("SFP+ module not supported");
 		hw->phy.type = txgbe_phy_sfp_unsupported;
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 		return TXGBE_ERR_SFP_NOT_SUPPORTED;
 	}
 
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	return err;
 }
 
@@ -1046,28 +1091,13 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 {
 	s32 err = TXGBE_ERR_PHY_ADDR_INVALID;
-	u32 vendor_oui = 0;
-	enum txgbe_sfp_type stored_sfp_type = hw->phy.sfp_type;
-	u8 identifier = 0;
-	u8 comp_codes_1g = 0;
-	u8 comp_codes_10g = 0;
-	u8 oui_bytes[3] = {0, 0, 0};
-	u16 enforce_sfp = 0;
-	u8 connector = 0;
-	u8 cable_length = 0;
-	u8 device_tech = 0;
-	bool active_cable = false;
+	u8 identifier = 0, transceiver_type = 0;
 	u32 value;
 
-	if (hw->phy.media_type != txgbe_media_type_fiber_qsfp) {
-		hw->phy.sfp_type = txgbe_sfp_type_not_present;
-		err = TXGBE_ERR_SFP_NOT_PRESENT;
-		goto out;
-	}
+	/* config GPIO before read i2c */
+	wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_1);
 
 	if (hw->mac.type == txgbe_mac_aml40) {
-		/* config GPIO before read i2c */
-		wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_1);
 		value = rd32(hw, TXGBE_GPIOEXT);
 		if (value & TXGBE_SFP1_MOD_PRST_LS) {
 			hw->phy.sfp_type = txgbe_sfp_type_not_present;
@@ -1075,175 +1105,68 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 		}
 	}
 
-	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_IDENTIFIER,
-					     &identifier);
-ERR_I2C:
-	if (err != 0) {
+	if (hw->phy.media_type != txgbe_media_type_fiber_qsfp) {
 		hw->phy.sfp_type = txgbe_sfp_type_not_present;
-		hw->phy.id = 0;
-		hw->phy.type = txgbe_phy_unknown;
 		return TXGBE_ERR_SFP_NOT_PRESENT;
 	}
-	if (identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS) {
-		hw->phy.type = txgbe_phy_sfp_unsupported;
-		err = TXGBE_ERR_SFP_NOT_SUPPORTED;
-		goto out;
-	}
 
-	hw->phy.id = identifier;
+	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	if (err)
+		return -EBUSY;
 
-	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_QSFP_10GBE_COMP,
-					     &comp_codes_10g);
+	err = hw->phy.read_i2c_sff8636(hw, 0, TXGBE_SFF_IDENTIFIER,
+				       &identifier);
 
 	if (err != 0)
-		goto ERR_I2C;
+		goto err_read_i2c_eeprom;
 
-	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_QSFP_1GBE_COMP,
-					     &comp_codes_1g);
-
-	if (err != 0)
-		goto ERR_I2C;
+	if (identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
+	    identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS) {
+		PMD_INIT_LOG(ERR, "port[%d] QSFP module not supported, identifier = 0x%x",
+			     hw->bus.lan_id, identifier);
+		hw->phy.type = txgbe_phy_sfp_unsupported;
+		err = TXGBE_ERR_SFP_NOT_SUPPORTED;
+	} else {
+		err = hw->phy.read_i2c_sff8636(hw, 0,
+					       TXGBE_ETHERNET_COMP_OFFSET,
+					       &transceiver_type);
+		if (err != 0)
+			goto err_read_i2c_eeprom;
 
-	if (comp_codes_10g & TXGBE_SFF_QSFP_DA_PASSIVE_CABLE) {
-		hw->phy.type = txgbe_phy_qsfp_unknown_passive;
-		if (hw->mac.type == txgbe_mac_aml40) {
+		if (transceiver_type & TXGBE_SFF_ETHERNET_40G_CR4) {
 			if (hw->bus.lan_id == 0)
 				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core0;
 			else
 				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core1;
-		} else {
-			if (hw->bus.lan_id == 0)
-				hw->phy.sfp_type = txgbe_sfp_type_da_cu_core0;
-			else
-				hw->phy.sfp_type = txgbe_sfp_type_da_cu_core1;
-		}
-	} else if (comp_codes_10g & TXGBE_SFF_40GBASE_SR4) {
-		if (hw->bus.lan_id == 0)
-			hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core0;
-		else
-			hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core1;
-	} else if (comp_codes_10g & TXGBE_SFF_40GBASE_LR4) {
-		if (hw->bus.lan_id == 0)
-			hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core0;
-		else
-			hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core1;
-	} else if (comp_codes_10g & (TXGBE_SFF_10GBASESR_CAPABLE |
-				     TXGBE_SFF_10GBASELR_CAPABLE)) {
-		if (hw->bus.lan_id == 0)
-			hw->phy.sfp_type = txgbe_sfp_type_srlr_core0;
-		else
-			hw->phy.sfp_type = txgbe_sfp_type_srlr_core1;
-	} else {
-		if (comp_codes_10g & TXGBE_SFF_QSFP_DA_ACTIVE_CABLE)
-			active_cable = true;
-
-		if (!active_cable) {
-			hw->phy.read_i2c_eeprom(hw,
-					TXGBE_SFF_QSFP_CONNECTOR,
-					&connector);
-
-			hw->phy.read_i2c_eeprom(hw,
-					TXGBE_SFF_QSFP_CABLE_LENGTH,
-					&cable_length);
-
-			hw->phy.read_i2c_eeprom(hw,
-					TXGBE_SFF_QSFP_DEVICE_TECH,
-					&device_tech);
-
-			if (connector ==
-				     TXGBE_SFF_QSFP_CONNECTOR_NOT_SEPARABLE &&
-			    cable_length > 0 &&
-			    ((device_tech >> 4) ==
-				     TXGBE_SFF_QSFP_TRANSMITTER_850NM_VCSEL))
-				active_cable = true;
+			hw->phy.fiber_suppport_speed =
+						TXGBE_LINK_SPEED_40GB_FULL |
+						TXGBE_LINK_SPEED_10GB_FULL;
 		}
 
-		if (active_cable) {
-			hw->phy.type = txgbe_phy_qsfp_unknown_active;
+		if (transceiver_type & TXGBE_SFF_ETHERNET_40G_SR4) {
 			if (hw->bus.lan_id == 0)
-				hw->phy.sfp_type =
-					txgbe_sfp_type_da_act_lmt_core0;
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core0;
 			else
-				hw->phy.sfp_type =
-					txgbe_sfp_type_da_act_lmt_core1;
-		} else {
-			/* unsupported module type */
-			hw->phy.type = txgbe_phy_sfp_unsupported;
-			err = TXGBE_ERR_SFP_NOT_SUPPORTED;
-			goto out;
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core1;
 		}
-	}
-
-	if (hw->phy.sfp_type != stored_sfp_type)
-		hw->phy.sfp_setup_needed = true;
-
-	/* Determine if the QSFP+ PHY is dual speed or not. */
-	hw->phy.multispeed_fiber = false;
-	if (((comp_codes_1g & TXGBE_SFF_1GBASESX_CAPABLE) &&
-	   (comp_codes_10g & TXGBE_SFF_10GBASESR_CAPABLE)) ||
-	   ((comp_codes_1g & TXGBE_SFF_1GBASELX_CAPABLE) &&
-	   (comp_codes_10g & TXGBE_SFF_10GBASELR_CAPABLE)))
-		hw->phy.multispeed_fiber = true;
-
-	/* Determine PHY vendor for optical modules */
-	if (comp_codes_10g & (TXGBE_SFF_10GBASESR_CAPABLE |
-			      TXGBE_SFF_10GBASELR_CAPABLE))  {
-		err = hw->phy.read_i2c_eeprom(hw,
-					    TXGBE_SFF_QSFP_VENDOR_OUI_BYTE0,
-					    &oui_bytes[0]);
-
-		if (err != 0)
-			goto ERR_I2C;
-
-		err = hw->phy.read_i2c_eeprom(hw,
-					    TXGBE_SFF_QSFP_VENDOR_OUI_BYTE1,
-					    &oui_bytes[1]);
-
-		if (err != 0)
-			goto ERR_I2C;
-
-		err = hw->phy.read_i2c_eeprom(hw,
-					    TXGBE_SFF_QSFP_VENDOR_OUI_BYTE2,
-					    &oui_bytes[2]);
 
-		if (err != 0)
-			goto ERR_I2C;
-
-		vendor_oui =
-		  ((oui_bytes[0] << 24) |
-		   (oui_bytes[1] << 16) |
-		   (oui_bytes[2] << 8));
-
-		if (vendor_oui == TXGBE_SFF_VENDOR_OUI_INTEL)
-			hw->phy.type = txgbe_phy_qsfp_intel;
-		else
-			hw->phy.type = txgbe_phy_qsfp_unknown;
-
-		hw->mac.get_device_caps(hw, &enforce_sfp);
-		if (!(enforce_sfp & TXGBE_DEVICE_CAPS_ALLOW_ANY_SFP)) {
-			/* Make sure we're a supported PHY type */
-			if (hw->phy.type == txgbe_phy_qsfp_intel) {
-				err = 0;
-			} else {
-				if (hw->allow_unsupported_sfp) {
-					DEBUGOUT("WARNING: Wangxun (R) Network Connections are quality tested using Wangxun (R) Ethernet Optics. "
-						"Using untested modules is not supported and may cause unstable operation or damage to the module or the adapter. "
-						"Wangxun Corporation is not responsible for any harm caused by using untested modules.");
-					err = 0;
-				} else {
-					DEBUGOUT("QSFP module not supported");
-					hw->phy.type =
-						txgbe_phy_sfp_unsupported;
-					err = TXGBE_ERR_SFP_NOT_SUPPORTED;
-				}
-			}
-		} else {
-			err = 0;
+		if (transceiver_type & TXGBE_SFF_ETHERNET_40G_LR4) {
+			if (hw->bus.lan_id == 0)
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core0;
+			else
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core1;
 		}
 	}
 
-out:
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	return err;
+
+err_read_i2c_eeprom:
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	hw->phy.sfp_type = txgbe_sfp_type_not_present;
+	hw->phy.id = 0;
+	hw->phy.type = txgbe_phy_unknown;
+	return TXGBE_ERR_SFP_NOT_PRESENT;
 }
 
 /**
@@ -1278,6 +1201,26 @@ s32 txgbe_read_i2c_sff8472(struct txgbe_hw *hw, u8 byte_offset,
 					 sff8472_data);
 }
 
+/**
+ *  txgbe_read_i2c_sff8636 - Reads 8 bit word over I2C interface
+ *  @hw: pointer to hardware structure
+ *  @byte_offset: byte offset at address 0xA2
+ *  @eeprom_data: value read
+ *
+ *  Performs byte read operation to SFP module's SFF-8472 data over I2C
+ **/
+s32 txgbe_read_i2c_sff8636(struct txgbe_hw *hw, u8 page, u8 byte_offset,
+				 u8 *sff8636_data)
+{
+	hw->phy.write_i2c_byte(hw, TXGBE_SFF_QSFP_PAGE_SELECT,
+					TXGBE_I2C_EEPROM_DEV_ADDR,
+					page);
+
+	return hw->phy.read_i2c_byte(hw, byte_offset,
+					TXGBE_I2C_EEPROM_DEV_ADDR,
+					sff8636_data);
+}
+
 /**
  *  txgbe_write_i2c_eeprom - Writes 8 bit EEPROM word over I2C interface
  *  @hw: pointer to hardware structure
@@ -1295,7 +1238,7 @@ s32 txgbe_write_i2c_eeprom(struct txgbe_hw *hw, u8 byte_offset,
 }
 
 /**
- *  txgbe_read_i2c_byte_unlocked - Reads 8 bit word over I2C
+ *  txgbe_read_i2c_byte - Reads 8 bit word over I2C
  *  @hw: pointer to hardware structure
  *  @byte_offset: byte offset to read
  *  @dev_addr: address to read from
@@ -1304,7 +1247,7 @@ s32 txgbe_write_i2c_eeprom(struct txgbe_hw *hw, u8 byte_offset,
  *  Performs byte read operation to SFP module's EEPROM over I2C interface at
  *  a specified device address.
  **/
-s32 txgbe_read_i2c_byte_unlocked(struct txgbe_hw *hw, u8 byte_offset,
+s32 txgbe_read_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
 					   u8 dev_addr, u8 *data)
 {
 	txgbe_i2c_start(hw, dev_addr);
@@ -1334,30 +1277,7 @@ s32 txgbe_read_i2c_byte_unlocked(struct txgbe_hw *hw, u8 byte_offset,
 }
 
 /**
- *  txgbe_read_i2c_byte - Reads 8 bit word over I2C
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to read
- *  @dev_addr: address to read from
- *  @data: value read
- *
- *  Performs byte read operation to SFP module's EEPROM over I2C interface at
- *  a specified device address.
- **/
-s32 txgbe_read_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
-				u8 dev_addr, u8 *data)
-{
-	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int err = 0;
-
-	if (hw->mac.acquire_swfw_sync(hw, swfw_mask))
-		return TXGBE_ERR_SWFW_SYNC;
-	err = txgbe_read_i2c_byte_unlocked(hw, byte_offset, dev_addr, data);
-	hw->mac.release_swfw_sync(hw, swfw_mask);
-	return err;
-}
-
-/**
- *  txgbe_write_i2c_byte_unlocked - Writes 8 bit word over I2C
+ *  txgbe_write_i2c_byte - Writes 8 bit word over I2C
  *  @hw: pointer to hardware structure
  *  @byte_offset: byte offset to write
  *  @dev_addr: address to write to
@@ -1366,54 +1286,29 @@ s32 txgbe_read_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
  *  Performs byte write operation to SFP module's EEPROM over I2C interface at
  *  a specified device address.
  **/
-s32 txgbe_write_i2c_byte_unlocked(struct txgbe_hw *hw, u8 byte_offset,
-					    u8 dev_addr, u8 data)
+s32 txgbe_write_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
+			       u8 dev_addr, u8 data)
 {
 	txgbe_i2c_start(hw, dev_addr);
 
 	/* wait tx empty */
 	if (!po32m(hw, TXGBE_I2CICR, TXGBE_I2CICR_TXEMPTY,
-		TXGBE_I2CICR_TXEMPTY, NULL, 100, 100)) {
+		   TXGBE_I2CICR_TXEMPTY, NULL, 100, 100))
 		return -TERR_TIMEOUT;
-	}
 
-	wr32(hw, TXGBE_I2CDATA, byte_offset | TXGBE_I2CDATA_STOP);
+	wr32(hw, TXGBE_I2CDATA, byte_offset);
 	wr32(hw, TXGBE_I2CDATA, data | TXGBE_I2CDATA_WRITE);
 
 	/* wait for write complete */
 	if (!po32m(hw, TXGBE_I2CICR, TXGBE_I2CICR_RXFULL,
-		TXGBE_I2CICR_RXFULL, NULL, 100, 100)) {
+		   TXGBE_I2CICR_RXFULL, NULL, 100, 100))
 		return -TERR_TIMEOUT;
-	}
+
 	txgbe_i2c_stop(hw);
 
 	return 0;
 }
 
-/**
- *  txgbe_write_i2c_byte - Writes 8 bit word over I2C
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to write
- *  @dev_addr: address to write to
- *  @data: value to write
- *
- *  Performs byte write operation to SFP module's EEPROM over I2C interface at
- *  a specified device address.
- **/
-s32 txgbe_write_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
-				 u8 dev_addr, u8 data)
-{
-	u32 swfw_mask = hw->phy.phy_semaphore_mask;
-	int err = 0;
-
-	if (hw->mac.acquire_swfw_sync(hw, swfw_mask))
-		return TXGBE_ERR_SWFW_SYNC;
-	err = txgbe_write_i2c_byte_unlocked(hw, byte_offset, dev_addr, data);
-	hw->mac.release_swfw_sync(hw, swfw_mask);
-
-	return err;
-}
-
 /**
  *  txgbe_i2c_start - Sets I2C start condition
  *  @hw: pointer to hardware structure
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 71e97b1217..796a0f6748 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -261,7 +261,9 @@
 #define TXGBE_SFF_SFF_8472_COMP		0x5E
 #define TXGBE_SFF_SFF_8472_OSCB		0x6E
 #define TXGBE_SFF_SFF_8472_ESCB		0x76
+#define TXGBE_SFF_QSFP_PAGE_SELECT      0x7F
 
+#define TXGBE_SFF_IDENTIFIER_QSFP	0x0C
 #define TXGBE_SFF_IDENTIFIER_QSFP_PLUS	0x0D
 #define TXGBE_SFF_QSFP_VENDOR_OUI_BYTE0	0xA5
 #define TXGBE_SFF_QSFP_VENDOR_OUI_BYTE1	0xA6
@@ -289,6 +291,9 @@
 #define TXGBE_SFF_4x10GBASESR_CAP		0x11
 #define TXGBE_SFF_40GBASEPSM4_PARALLEL		0x12
 #define TXGBE_SFF_40GBASE_SWMD4_CAP		0x1f
+#define TXGBE_SFF_COPPER_5M			0x5
+#define TXGBE_SFF_COPPER_3M			0x3
+#define TXGBE_SFF_COPPER_1M			0x1
 
 #define TXGBE_SFF_DA_SPEC_ACTIVE_LIMITING	0x4
 #define TXGBE_SFF_25GAUI_C2M_AOC_BER_5		0x1
@@ -296,6 +301,11 @@
 #define TXGBE_SFF_25GAUI_C2M_AOC_BER_12		0x18
 #define TXGBE_SFF_25GAUI_C2M_ACC_BER_12		0x19
 
+#define TXGBE_ETHERNET_COMP_OFFSET		0x83
+#define TXGBE_SFF_ETHERNET_40G_CR4		MS(3, 0x1)
+#define TXGBE_SFF_ETHERNET_40G_SR4		MS(2, 0x1)
+#define TXGBE_SFF_ETHERNET_40G_LR4		MS(1, 0x1)
+
 #define TXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
 #define TXGBE_SFF_SOFT_RS_SELECT_10G		0x8
 #define TXGBE_SFF_SOFT_RS_SELECT_1G		0x0
@@ -490,14 +500,12 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw);
 s32 txgbe_check_overtemp(struct txgbe_hw *hw);
 s32 txgbe_read_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
-s32 txgbe_read_i2c_byte_unlocked(struct txgbe_hw *hw, u8 byte_offset,
-					 u8 dev_addr, u8 *data);
 s32 txgbe_write_i2c_byte(struct txgbe_hw *hw, u8 byte_offset,
 				 u8 dev_addr, u8 data);
-s32 txgbe_write_i2c_byte_unlocked(struct txgbe_hw *hw, u8 byte_offset,
-					  u8 dev_addr, u8 data);
 s32 txgbe_read_i2c_sff8472(struct txgbe_hw *hw, u8 byte_offset,
-					  u8 *sff8472_data);
+				  u8 *sff8472_data);
+s32 txgbe_read_i2c_sff8636(struct txgbe_hw *hw, u8 page ,u8 byte_offset,
+					  u8 *sff8636_data);
 s32 txgbe_read_i2c_eeprom(struct txgbe_hw *hw, u8 byte_offset,
 				  u8 *eeprom_data);
 s32 txgbe_write_i2c_eeprom(struct txgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index aa882e87b8..051609bbfe 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -702,6 +702,8 @@ struct txgbe_phy_info {
 				u8 dev_addr, u8 data);
 	s32 (*read_i2c_sff8472)(struct txgbe_hw *hw, u8 byte_offset,
 				u8 *sff8472_data);
+	s32 (*read_i2c_sff8636)(struct txgbe_hw *hw, u8 page, u8 byte_offset,
+				u8 *sff8636_data);
 	s32 (*read_i2c_eeprom)(struct txgbe_hw *hw, u8 byte_offset,
 				u8 *eeprom_data);
 	s32 (*write_i2c_eeprom)(struct txgbe_hw *hw, u8 byte_offset,
-- 
2.21.0.windows.1

