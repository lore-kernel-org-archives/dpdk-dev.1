Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E45DCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:19:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E82794275D;
	Thu, 16 Oct 2025 13:19:27 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id A61C44161A
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:25 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613561t09e881ff
X-QQ-Originating-IP: kV/RSEg0GZNvJvohojgVsU5i6YN2hH9QiPLHW/wv0bw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2109356807865239198
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 03/21] net/txgbe: add identification support for new
 SFP/QSFP modules
Date: Thu, 16 Oct 2025 19:17:17 +0800
Message-Id: <20251016111736.25372-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: ONMinSPvVgZRE7HJlg9SgUTN1Km5LcvjQeW566Qmg88plzBfnzUwVMNc
 P9y82DM673XnzBDCZk8Po3Y58AUwRCQQhSYRcdMxfeBp77GIKORwFXdWZpxbmzSxxGxGBbM
 gYTUYUhYUxiFK5UzfJICIJFU7KUXY2+EFHCluLTZxPKhcV4Ac7U6mM3hsnXbzfIclnGFLTT
 224854UnayHE6id6aZSf+sRV1yE3Oiq2BAgrL1pYZlMblmUUxtskKVzASe4UrGPDqyCQDw7
 pXBowA+uEGgs74s9qHmL3RsoBZxUm9ipu9XBowwjQLLOMGzxqVI55IFNoIOEhYA30QWmWqu
 FKDdrmfLdKX0cmk1GMUjgNaDLH+oiXk9algf81CBvzCT20riyhK9cTZWRM2kKCq4BTKET2W
 kI/k5orzAT/s5qL/6h1oK2LvOsYjKsbusdHpN2lMiAaLXR8EaIu7D/3L4TbDRr3sXretYLr
 5+nTXpVdNkoL054nG0oycos+j7IzJJ2X0LHS4ND9vINztjYlTzLboH/k2iVyegfQoazfK88
 xrTaKyx5RmFvafYV6lXy4ll+H1i23wlV4VEBM3xhIhlyPjv1Glsx1vYSvIyAHpBZn+9dGgT
 63fnw0wZGU0VJKDUIBkxkQvFBFZYELwOYSKashgmcxIEF93/RQsLUbxKt9ybTXou5nITMmj
 JL2Fx9C24lqr8DdlZ4fLWR10WeOclnZEIXozE4e88fnGAZDhfb7LBXeiy1j7Dh06tdy8i3j
 TRJAYtXP8mGp4+Naas2cbuTHDm4KWJDlfxjsVfOtbOppEiMPx52LOBQxnNSdZqMhjKfr20c
 k2ODZkRy9PI7CWuGm4pNmUhuf/5iHnwOBet6AWMbi3mkzx6ZM1+haAuqE+/Ra52v4xOZjoN
 wMLwx7VyrqejA75OBhuDZNqLa4kO+zqikg0p2ZhZrAWtcIWQH00ro9HhZfYU7jzuPi5gO4w
 4ObJKq2RzIDwskLEE4lCKHtfbUqdG/ySzTj+hLgGFHhm+2n3DQMbsrOVW91d0IQkngLiX0/
 DjHiPXyByOe72YpOFJOVd76G7zV9qYfOBAAg965njMwvDLilFs7KBSMonc0GGM/JxddQA4X
 dzJ1aWWUV0t
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

Add identification support for new SFP/QSFP module types (e.g., 25G
SR/CR) in the Amber-Lite NIC configuration flow.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c  | 92 ++++++++++++++++++++++++-----
 drivers/net/txgbe/base/txgbe_phy.h  | 23 ++++++++
 drivers/net/txgbe/base/txgbe_regs.h |  5 +-
 drivers/net/txgbe/base/txgbe_type.h | 12 ++++
 4 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index ce6882e262..81e9aee295 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -774,10 +774,21 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	u8 identifier = 0;
 	u8 comp_codes_1g = 0;
 	u8 comp_codes_10g = 0;
+	u8 comp_codes_25g = 0;
+	u8 comp_copper_len = 0;
 	u8 oui_bytes[3] = {0, 0, 0};
 	u8 cable_tech = 0;
 	u8 cable_spec = 0;
 	u16 enforce_sfp = 0;
+	u32 value;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_ABS_LS) {
+			hw->phy.sfp_type = txgbe_sfp_type_not_present;
+			return TXGBE_ERR_SFP_NOT_PRESENT;
+		}
+	}
 
 	if (hw->phy.media_type != txgbe_media_type_fiber) {
 		hw->phy.sfp_type = txgbe_sfp_type_not_present;
@@ -811,6 +822,16 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	if (err != 0)
 		goto ERR_I2C;
 
+	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_25GBE_COMP_CODES,
+					      &comp_codes_25g);
+	if (err != 0)
+		goto ERR_I2C;
+
+	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_COPPER_LENGTH,
+					      &comp_copper_len);
+	if (err != 0)
+		goto ERR_I2C;
+
 	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_CABLE_TECHNOLOGY,
 					     &cable_tech);
 	if (err != 0)
@@ -832,12 +853,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	  * 11  SFP_1g_sx_CORE0 - chip-specific
 	  * 12  SFP_1g_sx_CORE1 - chip-specific
 	  */
-	if (cable_tech & TXGBE_SFF_CABLE_DA_PASSIVE) {
-		if (hw->bus.lan_id == 0)
-			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core0;
-		else
-			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core1;
-	} else if (cable_tech & TXGBE_SFF_CABLE_DA_ACTIVE) {
+	if (cable_tech & TXGBE_SFF_CABLE_DA_ACTIVE) {
 		err = hw->phy.read_i2c_eeprom(hw,
 			TXGBE_SFF_CABLE_SPEC_COMP, &cable_spec);
 		if (err != 0)
@@ -849,6 +865,17 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 		} else {
 			hw->phy.sfp_type = txgbe_sfp_type_unknown;
 		}
+	} else if (comp_codes_25g == TXGBE_SFF_25GBASESR_CAPABLE ||
+		   comp_codes_25g == TXGBE_SFF_25GBASEER_CAPABLE) {
+		if (hw->bus.lan_id == 0)
+			hw->phy.sfp_type = txgbe_sfp_type_25g_sr_core0;
+		else
+			hw->phy.sfp_type = txgbe_sfp_type_25g_sr_core1;
+	} else if (comp_codes_25g == TXGBE_SFF_25GBASELR_CAPABLE) {
+		if (hw->bus.lan_id == 0)
+			hw->phy.sfp_type = txgbe_sfp_type_25g_lr_core0;
+		else
+			hw->phy.sfp_type = txgbe_sfp_type_25g_lr_core1;
 	} else if (comp_codes_10g &
 		   (TXGBE_SFF_10GBASESR_CAPABLE |
 		    TXGBE_SFF_10GBASELR_CAPABLE)) {
@@ -876,11 +903,20 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 
 	/* Determine if the SFP+ PHY is dual speed or not. */
 	hw->phy.multispeed_fiber = false;
-	if (((comp_codes_1g & TXGBE_SFF_1GBASESX_CAPABLE) &&
-	     (comp_codes_10g & TXGBE_SFF_10GBASESR_CAPABLE)) ||
-	    ((comp_codes_1g & TXGBE_SFF_1GBASELX_CAPABLE) &&
-	     (comp_codes_10g & TXGBE_SFF_10GBASELR_CAPABLE)))
-		hw->phy.multispeed_fiber = true;
+	if (hw->mac.type == txgbe_mac_aml) {
+		if ((comp_codes_25g == TXGBE_SFF_25GBASESR_CAPABLE ||
+		     comp_codes_25g == TXGBE_SFF_25GBASELR_CAPABLE ||
+		     comp_codes_25g == TXGBE_SFF_25GBASEER_CAPABLE) &&
+		   ((comp_codes_10g & TXGBE_SFF_10GBASESR_CAPABLE) ||
+		    (comp_codes_10g & TXGBE_SFF_10GBASELR_CAPABLE)))
+			hw->phy.multispeed_fiber = true;
+	} else {
+		if (((comp_codes_1g & TXGBE_SFF_1GBASESX_CAPABLE) &&
+		     (comp_codes_10g & TXGBE_SFF_10GBASESR_CAPABLE)) ||
+		    ((comp_codes_1g & TXGBE_SFF_1GBASELX_CAPABLE) &&
+		     (comp_codes_10g & TXGBE_SFF_10GBASELR_CAPABLE)))
+			hw->phy.multispeed_fiber = true;
+	}
 
 	/* Determine PHY vendor */
 	if (hw->phy.type != txgbe_phy_nl) {
@@ -938,7 +974,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 	}
 
 	/* Verify supported 1G SFP modules */
-	if (comp_codes_10g == 0 &&
+	if (comp_codes_10g == 0 && comp_codes_25g == 0 &&
 	    !(hw->phy.sfp_type == txgbe_sfp_type_1g_cu_core1 ||
 	      hw->phy.sfp_type == txgbe_sfp_type_1g_cu_core0 ||
 	      hw->phy.sfp_type == txgbe_sfp_type_1g_lx_core0 ||
@@ -986,6 +1022,7 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 	u8 cable_length = 0;
 	u8 device_tech = 0;
 	bool active_cable = false;
+	u32 value;
 
 	if (hw->phy.media_type != txgbe_media_type_fiber_qsfp) {
 		hw->phy.sfp_type = txgbe_sfp_type_not_present;
@@ -993,6 +1030,16 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 		goto out;
 	}
 
+	if (hw->mac.type == txgbe_mac_aml40) {
+		/* config GPIO before read i2c */
+		wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_1);
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_PRST_LS) {
+			hw->phy.sfp_type = txgbe_sfp_type_not_present;
+			return TXGBE_ERR_SFP_NOT_PRESENT;
+		}
+	}
+
 	err = hw->phy.read_i2c_eeprom(hw, TXGBE_SFF_IDENTIFIER,
 					     &identifier);
 ERR_I2C:
@@ -1024,10 +1071,27 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 
 	if (comp_codes_10g & TXGBE_SFF_QSFP_DA_PASSIVE_CABLE) {
 		hw->phy.type = txgbe_phy_qsfp_unknown_passive;
+		if (hw->mac.type == txgbe_mac_aml40) {
+			if (hw->bus.lan_id == 0)
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core0;
+			else
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_cu_core1;
+		} else {
+			if (hw->bus.lan_id == 0)
+				hw->phy.sfp_type = txgbe_sfp_type_da_cu_core0;
+			else
+				hw->phy.sfp_type = txgbe_sfp_type_da_cu_core1;
+		}
+	} else if (comp_codes_10g & TXGBE_SFF_40GBASE_SR4) {
+		if (hw->bus.lan_id == 0)
+			hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core0;
+		else
+			hw->phy.sfp_type = txgbe_qsfp_type_40g_sr_core1;
+	} else if (comp_codes_10g & TXGBE_SFF_40GBASE_LR4) {
 		if (hw->bus.lan_id == 0)
-			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core0;
+			hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core0;
 		else
-			hw->phy.sfp_type = txgbe_sfp_type_da_cu_core1;
+			hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core1;
 	} else if (comp_codes_10g & (TXGBE_SFF_10GBASESR_CAPABLE |
 				     TXGBE_SFF_10GBASELR_CAPABLE)) {
 		if (hw->bus.lan_id == 0)
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 4dfe18930c..c02be3cc34 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -249,6 +249,8 @@
 #define TXGBE_SFF_VENDOR_OUI_BYTE2	0x27
 #define TXGBE_SFF_1GBE_COMP_CODES	0x06
 #define TXGBE_SFF_10GBE_COMP_CODES	0x03
+#define TXGBE_SFF_25GBE_COMP_CODES	0x24
+#define TXGBE_SFF_COPPER_LENGTH		0x12
 #define TXGBE_SFF_CABLE_TECHNOLOGY	0x08
 #define   TXGBE_SFF_CABLE_DA_PASSIVE    0x4
 #define   TXGBE_SFF_CABLE_DA_ACTIVE     0x8
@@ -275,6 +277,23 @@
 #define TXGBE_SFF_1GBASET_CAPABLE		0x8
 #define TXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define TXGBE_SFF_10GBASELR_CAPABLE		0x20
+#define TXGBE_SFF_25GBASESR_CAPABLE		0x2
+#define TXGBE_SFF_25GBASELR_CAPABLE		0x3
+#define TXGBE_SFF_25GBASEER_CAPABLE		0x4
+#define TXGBE_SFF_25GBASECR_91FEC		0xB
+#define TXGBE_SFF_25GBASECR_74FEC		0xC
+#define TXGBE_SFF_25GBASECR_NOFEC		0xD
+#define TXGBE_SFF_40GBASE_SR_CAPABLE		0x10
+#define TXGBE_SFF_4x10GBASESR_CAP		0x11
+#define TXGBE_SFF_40GBASEPSM4_PARALLEL		0x12
+#define TXGBE_SFF_40GBASE_SWMD4_CAP		0x1f
+
+#define TXGBE_SFF_DA_SPEC_ACTIVE_LIMITING	0x4
+#define TXGBE_SFF_25GAUI_C2M_AOC_BER_5		0x1
+#define TXGBE_SFF_25GAUI_C2M_ACC_BER_5		0x8
+#define TXGBE_SFF_25GAUI_C2M_AOC_BER_12		0x18
+#define TXGBE_SFF_25GAUI_C2M_ACC_BER_12		0x19
+
 #define TXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
 #define TXGBE_SFF_SOFT_RS_SELECT_10G		0x8
 #define TXGBE_SFF_SOFT_RS_SELECT_1G		0x0
@@ -290,6 +309,10 @@
 #define TXGBE_I2C_EEPROM_STATUS_FAIL		0x2
 #define TXGBE_I2C_EEPROM_STATUS_IN_PROGRESS	0x3
 
+#define TXGBE_SFF_40GBASE_CR4			0x8
+#define TXGBE_SFF_40GBASE_SR4			0x4
+#define TXGBE_SFF_40GBASE_LR4			0x2
+
 /* EEPROM for SFF-8472 (dev_addr = 0xA2) */
 #define TXGBE_I2C_EEPROM_DEV_ADDR2	0xA2
 
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 3b0bf08ea2..e75597591f 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1605,7 +1605,10 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_GPIOINTSTAT               0x014840
 #define TXGBE_GPIORAWINTSTAT            0x014844
 #define TXGBE_GPIOEOI                   0x01484C
-
+#define TXGBE_GPIOEXT                   0x014850
+#define   TXGBE_SFP1_MOD_ABS_LS         MS(2, 0x1) /* GPIO_EXT SFP ABSENT*/
+#define   TXGBE_SFP1_RX_LOS_LS          MS(3, 0x1) /* GPIO_EXT RX LOSS */
+#define   TXGBE_SFP1_MOD_PRST_LS        MS(4, 0x1) /* GPIO_EXT SFP ABSENT*/
 
 #define TXGBE_ARBPOOLIDX                0x01820C
 #define TXGBE_ARBTXRATE                 0x018404
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index a34c782ec8..2d13539f87 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -206,6 +206,18 @@ enum txgbe_sfp_type {
 	txgbe_sfp_type_1g_sx_core1,
 	txgbe_sfp_type_1g_lx_core0,
 	txgbe_sfp_type_1g_lx_core1,
+	txgbe_sfp_type_25g_sr_core0,
+	txgbe_sfp_type_25g_sr_core1,
+	txgbe_sfp_type_25g_lr_core0,
+	txgbe_sfp_type_25g_lr_core1,
+	txgbe_sfp_type_25g_aoc_core0,
+	txgbe_sfp_type_25g_aoc_core1,
+	txgbe_qsfp_type_40g_cu_core0,
+	txgbe_qsfp_type_40g_cu_core1,
+	txgbe_qsfp_type_40g_sr_core0,
+	txgbe_qsfp_type_40g_sr_core1,
+	txgbe_qsfp_type_40g_lr_core0,
+	txgbe_qsfp_type_40g_lr_core1,
 	txgbe_sfp_type_not_present = 0xFFFE,
 	txgbe_sfp_type_not_known = 0xFFFF
 };
-- 
2.21.0.windows.1

