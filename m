Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A49CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:00:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CDC240A7F;
	Tue, 30 Sep 2025 12:00:30 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 2E77140A7F
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:27 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226422t5f9d5c43
X-QQ-Originating-IP: jvjvvr3T8Xv/+QIvZqFPfndzTBpuMHliLEZiwG+Sx8Y=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11329806905909766861
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 03/20] net/txgbe: add identification support for new
 SFP/QSFP modules
Date: Tue, 30 Sep 2025 17:59:35 +0800
Message-Id: <20250930095953.18508-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MzUsEJ4eXJ2k7McbtbrBlR59vzecZPf3e43UEolJ9UrJxxE+p2HwrAe7
 746ibpc7ATpVCSYlbkt1p8adcRaUrN/unjKjK8WaN+PxeC9Y+jki6hpYuda4rK68NaBIw21
 41mbZvDtOxp/bN17BW6EkT8AzygCm7TB2kpnorAQDoWyiP14CJI3OhSuyLXk0h6GTK0kHYq
 2vE+eWjNiEtgark97InlZCHB3CsPgfTnfQU+HywrJ0XR9jiUwEGdcefQro4CcMIXnnGlsc5
 41Wby633b0j7aXGPD2tUs2Ld78RI0AGA+WYGcE29aF5PYkv+G6oscOVgrK6QYxlOBgzI+qJ
 2op0TC0pdb3pN3BmJ1G3jeXAUQXJOBSpj1jqLI3nAVqddkOHzejewZMODySCZiaeHJojZlI
 4IErr9D5gYKlmtDU0Z9WcYQmta4O2mnI0NXSGuPDkAk+tTn5j6FQn5jm+/muN9KPrpDvwYi
 rBcqBmgBQZjDPpihZWcdJ9iM3RWiVB4FS7zQeNuCWo8k2p9CR4tCve2idEGxeFwDvFvPDHR
 c/K8OfEqtfzYiDzxH9+mdy3YyzRHeeEUDMmUy0WcwzrQ+hBPQRux5iIu/ofmxR+GJriiTn5
 79iBquYws5KdP4zPFSTZnP/soyJU5R7x1WGouSntnCLWpjJRBwN4ydqMi+hXNLkgsy1/K97
 qzsZJ5bGXGIU+SWwZDMzyE1DvgIKW4ybHPC6H044fONzfGpmMxhkRr79ytFYitHWHBsu3pf
 jZIf9vsTNenD2hrx3gsBTylS0ptY9LLv1xSXWgPRtBC4QpyAN9nRi/UPDYn/p3plNAbVaU6
 WtlHnrM+ZTGmw/vD2twg1MCmINgVTB9Hh/N8TvBOrFaHHZbItzdy/5RctaJdx4228NPBeW+
 68mVnYcm3576J3zsLJ9vG3NBWQR2K2+B1n4gszIJ/nMmnKuKsEL0KnRVtpNPwuQ8HwTjUG+
 cOcFZ4wVe7q9kibr8l4sYH7gLIK/RkaQ8O7D4wTMoAdpjgfVVSTHVK/zbKGluxJT/S8Uk/b
 H0yqqiGcEADtcfLrvZ2LtnsC5XTeB0ABQOWGkm49ovtR3kCzGhCM+B7H17E48onZ5X9FzGZ
 A==
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

