Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE8FAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0381D40A4B;
	Thu, 23 Apr 2026 05:41:28 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 1640B40662;
 Thu, 23 Apr 2026 05:41:24 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915682t011afe25
X-QQ-Originating-IP: XISVp6W1CoaqmG3qGUIPPUdCfAKHNCWQ+mAe9LIzdSI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17267006751433506589
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 12/18] net/txgbe: fix link stability for 25G NIC
Date: Thu, 23 Apr 2026 11:40:17 +0800
Message-Id: <20260423034024.14404-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MNP7vfaed7CMSnEdTuFixGTuauh03SwxEsdT+U0G7fzIqBiMkmrk6ckt
 k4LSrjzGRB31pqGuJfjfRH1lTVK/fuBwmJPszR/cBN2rXLMkEN1bJY85eGSPa+YjvjHR9iP
 KqsANDDTc+vwm4C7Ml1s3n5thXqWPdnH1cYBtUGSRnKCJw13DyQ/t8B7L/QWg+VpFHZXmTd
 cIWgBPHGpLZ6J3/TiNcCdwUGI1KciwDOS5OEUZv7L8jIDUUVfKqxCSlr/GOaAtbE6pFMDV6
 kcLee3cWCrP0Lt6t7A86i433u5PO19VIPwjdd9nqbJTBMwMDlHMqikVZIUI9pqSk6UyTRtW
 aMNpfuzYINeyM9UX3BmwjlEhvUgQW8ZlcTsC8MwAZFe/Zjeqw52hOvgzAGmW+cNjplEYRh7
 CbWLUvXor8th2Lm3ab801wDjZX3SdaMTJHOhJIw7fLAT0qQB0ZSa2R+va4tHYyRqDhf4dIn
 JLlR9Qrez4GgP2qbRbwGi/VT2TscC3JeZDKu2VMh0KVcvfCs2qUlesMOiPkFZvFHVYvflGv
 0nSN/nOiA1r8j0M3TJlzIdZRCxiA/8GjGzQVQOcyyHp01+SwpxTgcTQzS2TVGwC5lSrLlP6
 ghhoFyLXxkqKuQMpVz2nLlxG9nW3XotsV6j6siBwtfqpY99KJr6Fpo60YRQ6q1Z2gMSsPhz
 1wFcuj+x2w23G8wFigSm+RDNiNzbgVw/sDDpPxYsDuODSqhSq5hChVP2XJo5kTuy7CdZMSI
 FU66QE0hIdnY6c6DDux299cenorE2CRQhgrX0p1rJNJIVNKJd9M4DaDXyXsk1lTaNETZ1Lx
 1IH7kzndUj26Rck9ju7KfY3aifUGZlDRtyRY4D45LrmqbR5BH1fXAHQ+GcuqL+t5XS7Shv4
 MxY1Q9AQAVQ+gYJh8xoKYsIPTs0awLTXcCqvd5ey12qUp+xP+rAO98mhbRqlKwl5paEAFgY
 3yfBX7bsvCH1IvChfdD5jkt6n2V6TMj+g/8l3763x0Vv4tv/7fv5d6fz4YtuB6sF8nrRD6Q
 V5gs+omOtJ2b2RrySCwliSiFHmEmNZ6FNbcApK70ybUnIC/F3UuRNOSZ+Lu7Kp0eJbgFZcS
 zEkvkSqi1kiytp/6o6VyVM=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

The link was previously configured via firmware, but this approach
resulted in unstable link behavior. To resolve the issue, re-add the
PHY configuration flow directly into the driver.

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/meson.build    |    1 +
 drivers/net/txgbe/base/txgbe_aml.c    |  107 +-
 drivers/net/txgbe/base/txgbe_aml.h    |    6 +-
 drivers/net/txgbe/base/txgbe_e56.c    | 2466 +++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h    | 1749 ++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h |  279 +++
 drivers/net/txgbe/base/txgbe_hw.c     |   35 +-
 drivers/net/txgbe/base/txgbe_osdep.h  |    8 -
 drivers/net/txgbe/base/txgbe_phy.h    |    1 -
 drivers/net/txgbe/base/txgbe_regs.h   |    2 +
 drivers/net/txgbe/base/txgbe_type.h   |   12 +
 drivers/net/txgbe/txgbe_ethdev.c      |   83 +-
 drivers/net/txgbe/txgbe_ethdev.h      |    4 +
 drivers/net/txgbe/txgbe_logs.h        |    7 +
 14 files changed, 4694 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

diff --git a/drivers/net/txgbe/base/meson.build b/drivers/net/txgbe/base/meson.build
index ac4a05005e..305c0291e3 100644
--- a/drivers/net/txgbe/base/meson.build
+++ b/drivers/net/txgbe/base/meson.build
@@ -12,4 +12,5 @@ base_sources = files(
         'txgbe_mng.c',
         'txgbe_phy.c',
         'txgbe_vf.c',
+        'txgbe_e56.c',
 )
diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index de9a1b1c93..208f999d78 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -12,6 +12,7 @@
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
 #include "txgbe_aml.h"
+#include "txgbe_e56.h"
 
 void txgbe_init_ops_aml(struct txgbe_hw *hw)
 {
@@ -23,6 +24,7 @@ void txgbe_init_ops_aml(struct txgbe_hw *hw)
 
 	/* PHY */
 	phy->get_media_type = txgbe_get_media_type_aml;
+	phy->setup_link_core = txgbe_setup_phy_link_aml;
 
 	/* LINK */
 	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml;
@@ -175,16 +177,21 @@ void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed)
 	}
 }
 
-s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
-			       u32 speed,
-			       bool autoneg_wait_to_complete)
+s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
+				    u32 speed,
+				    bool autoneg_wait_to_complete,
+				    bool *need_reset)
 {
 	bool autoneg = false;
 	s32 status = 0;
+	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
-	u32 value = 0;
+	u32 value;
+
+	*need_reset = false;
 
 	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
 		DEBUGOUT("SFP not detected, skip setup mac link");
@@ -197,33 +204,80 @@ s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
 	if (status)
 		return status;
 
+	/* setup the highest link when no autoneg */
+	if (!autoneg) {
+		if (speed & TXGBE_LINK_SPEED_25GB_FULL)
+			speed = TXGBE_LINK_SPEED_25GB_FULL;
+		else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+			speed = TXGBE_LINK_SPEED_10GB_FULL;
+	}
+
 	speed &= link_capabilities;
 	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
 		return TXGBE_ERR_LINK_SETUP;
 
-	value = rd32(hw, TXGBE_GPIOEXT);
-	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
+	if (txgbe_gpio_ext_check(hw, TXGBE_SFP1_MOD_ABS_LS |
+				 TXGBE_SFP1_RX_LOS_LS)) {
+		DEBUGOUT("RX LOS");
 		return status;
+	}
 
-	status = hw->mac.check_link(hw, &link_speed, &link_up,
-				    autoneg_wait_to_complete);
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up) {
+			DEBUGOUT("check phy link_up");
+			break;
+		}
+		msleep(250);
+	}
 
-	if (link_up && speed == TXGBE_LINK_SPEED_25GB_FULL)
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL)
 		hw->cur_fec_link = txgbe_phy_fec_get(hw);
 
 	if (link_speed == speed && link_up &&
-	   !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
-	   !(hw->fec_mode & hw->cur_fec_link)))
-		return status;
+	    !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
+	    !(hw->fec_mode & hw->cur_fec_link)))
+		goto out;
 
-	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
-		speed = 0x10;
-	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
-		speed = 0x08;
+	rte_spinlock_lock(&hw->phy_lock);
+	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		goto out;
 
-	status = hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
+	if (ret_status == TXGBE_ERR_TIMEOUT) {
+		hw->link_valid = false;
+		*need_reset = true;
+		goto out;
+	} else {
+		hw->link_valid = true;
+	}
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		txgbe_e56_fec_polling(hw, &link_up);
+	} else {
+		for (i = 0; i < 4; i++) {
+			txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+			if (link_up)
+				goto out;
+			msleep(250);
+		}
+	}
 
-	txgbe_wait_for_link_up_aml(hw, speed);
+out:
+	if (link_up) {
+		value = rd32(hw, TXGBE_PORTSTAT);
+		if (!(value & TXGBE_PORTSTAT_UP)) {
+			PMD_DRV_LOG(DEBUG, "MAC link 0x14404: 0x%x", value);
+			*need_reset = true;
+			value = rd32(hw, 0x110b0);
+			PMD_DRV_LOG(DEBUG, "MAC intr status 0x110b0: 0x%x", value);
+		}
+	} else {
+		*need_reset = true;
+		PMD_DRV_LOG(DEBUG, "Link reconfiguration required. Reset scheduled in 2000ms.");
+	}
 
 	return status;
 }
@@ -269,9 +323,12 @@ static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
 		/* Allow module to change analog characteristics (10G -> 25G) */
 		msec_delay(40);
 
-		status = hw->mac.setup_mac_link(hw,
+		bool need_reset;
+
+		status = hw->phy.setup_link_core(hw,
 				TXGBE_LINK_SPEED_25GB_FULL,
-				autoneg_wait_to_complete);
+				autoneg_wait_to_complete,
+				&need_reset);
 		if (status != 0)
 			return status;
 
@@ -297,8 +354,12 @@ static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
 		/* Allow module to change analog characteristics (25G->10G) */
 		msec_delay(40);
 
-		status = hw->mac.setup_mac_link(hw, TXGBE_LINK_SPEED_10GB_FULL,
-				autoneg_wait_to_complete);
+		bool need_reset;
+
+		status = hw->phy.setup_link_core(hw,
+				TXGBE_LINK_SPEED_10GB_FULL,
+				autoneg_wait_to_complete,
+				&need_reset);
 		if (status != 0)
 			return status;
 
@@ -348,10 +409,8 @@ void txgbe_init_mac_link_ops_aml(struct txgbe_hw *hw)
 		if (hw->phy.multispeed_fiber) {
 			/* Set up dual speed SFP+ support */
 			mac->setup_link = txgbe_setup_mac_link_multispeed_fiber_aml;
-			mac->setup_mac_link = txgbe_setup_mac_link_aml;
 			mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
 		} else {
-			mac->setup_link = txgbe_setup_mac_link_aml;
 			mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
 		}
 	}
diff --git a/drivers/net/txgbe/base/txgbe_aml.h b/drivers/net/txgbe/base/txgbe_aml.h
index e98c952787..bfb01b4968 100644
--- a/drivers/net/txgbe/base/txgbe_aml.h
+++ b/drivers/net/txgbe/base/txgbe_aml.h
@@ -16,7 +16,9 @@ s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
 u32 txgbe_get_media_type_aml(struct txgbe_hw *hw);
 void txgbe_wait_for_link_up_aml(struct txgbe_hw *hw, u32 speed);
-s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw, u32 speed,
-			       bool autoneg_wait_to_complete);
+s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
+				    u32 speed,
+				    bool autoneg_wait_to_complete,
+				    bool *need_reset);
 void txgbe_init_mac_link_ops_aml(struct txgbe_hw *hw);
 #endif /* _TXGBE_AML_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
new file mode 100644
index 0000000000..352eb2e110
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -0,0 +1,2466 @@
+#include "txgbe_e56.h"
+#include "txgbe_e56_bp.h"
+#include "../txgbe_logs.h"
+
+void
+set_fields_e56(unsigned int *src_data, unsigned int bit_high,
+	       unsigned int bit_low, unsigned int set_value)
+{
+	unsigned int i;
+
+	/* Single bit field handling */
+	if (bit_high == bit_low) {
+		if (set_value == 0) {
+			/* clear single bit */
+			*src_data &= ~(1 << bit_low);
+		} else {
+			/* set single bit */
+			*src_data |= (1 << bit_low);
+		}
+	} else {
+		/* first, clear the bit fields */
+		for (i = bit_low; i <= bit_high; i++) {
+			/* clear single bit */
+			*src_data &= ~(1 << i);
+		}
+
+		/* second, or the bit fields with set value */
+		*src_data |= (set_value << bit_low);
+	}
+}
+
+/*
+ * compare function for qsort()
+ */
+static inline
+int compare(const void *a, const void *b)
+{
+	const int *num1 = (const int *)a;
+	const int *num2 = (const int *)b;
+
+	if (*num1 < *num2)
+		return -1;
+
+	else if (*num1 > *num2)
+		return 1;
+
+	else
+		return 0;
+}
+
+s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
+				bool *link_up)
+{
+	u32 rdata = 0;
+	u32 links_reg = 0;
+
+	/* must read it twice because the state may
+	 * not be correct the first time you read it
+	 */
+	rdata = rd32_epcs(hw, 0x30001);
+	rdata = rd32_epcs(hw, 0x30001);
+
+	if (rdata & TXGBE_E56_PHY_LINK_UP)
+		*link_up = true;
+	else
+		*link_up = false;
+
+	if (!hw->link_valid)
+		*link_up = false;
+
+	links_reg = rd32(hw, TXGBE_PORTSTAT);
+	if (*link_up) {
+		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_40G)
+			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_25G)
+			*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
+	} else {
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
+
+u32 txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed)
+{
+	u32 ffe_main = 0, pre1 = 0, pre2 = 0, post = 0;
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		ffe_main = S10G_TX_FFE_CFG_MAIN;
+		pre1 = S10G_TX_FFE_CFG_PRE1;
+		pre2 = S10G_TX_FFE_CFG_PRE2;
+		post = S10G_TX_FFE_CFG_POST;
+	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
+		    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1) {
+			ffe_main = S25G_TX_FFE_CFG_MAIN;
+			pre1 = S25G_TX_FFE_CFG_PRE1;
+			pre2 = S25G_TX_FFE_CFG_PRE2;
+			post = S25G_TX_FFE_CFG_POST;
+		}
+	}
+
+	if (hw->phy.ffe_set) {
+		ffe_main = hw->phy.ffe_main;
+		pre1 = hw->phy.ffe_pre;
+		pre2 = hw->phy.ffe_pre2;
+		post = hw->phy.ffe_post;
+	}
+
+	PMD_DRV_LOG(DEBUG, "main = 0x%x, pre1 = 0x%x, pre2 = 0x%x, post = 0x%x",
+			    ffe_main, pre1, pre2, post);
+
+	wr32_ephy(hw, E56G__PMD_TX_FFE_CFG_1_ADDR, ffe_main);
+	wr32_ephy(hw, E56G__PMD_TX_FFE_CFG_2_ADDR, pre1);
+	wr32_ephy(hw, E56G__PMD_TX_FFE_CFG_3_ADDR, pre2);
+	wr32_ephy(hw, E56G__PMD_TX_FFE_CFG_4_ADDR, post);
+
+	return 0;
+}
+
+int
+txgbe_e56_get_temp(struct txgbe_hw *hw, int *temp)
+{
+	int data_code, temp_data, temp_fraction;
+	u32 rdata;
+	u32 timer = 0;
+
+	while (1) {
+		rdata = rd32(hw, 0x1033c);
+		if (((rdata >> 12) & 0x1) != 0)
+			break;
+		if (timer++ > PHYINIT_TIMEOUT)
+			return -1;
+	}
+
+	data_code = rdata & 0xFFF;
+	temp_data = 419400 + 2205 * (data_code * 1000 / 4094 - 500);
+
+	/* Change double Temperature to int */
+	*temp = temp_data / 10000;
+	temp_fraction = temp_data - (*temp * 10000);
+	if (temp_fraction >= 5000)
+		*temp += 1;
+
+	return 0;
+}
+
+u32
+txgbe_e56_cfg_25g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+
+	addr = E56PHY_CMS_PIN_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDVAL_0_INT_PLL0_TX_SIGNAL_TYPE_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDEN_0_OVRD_EN_PLL0_TX_SIGNAL_TYPE_I,
+		       0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDVAL_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_VCO_SWING_CTRL_I,
+		       0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDVAL_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 27, 24, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_25GB_FULL);
+
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1, 0x700);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1, 0x2418);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_RANGE_SEL1, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_VCO_CODE_INIT, 0x7fb);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_CURRENT_BOOST_EN1, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_BBCDR_CURRENT_BOOST1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_0_ADC_INTL2SLICE_DELAY1, 0x3333);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_2_INTERLEAVER_HBW_DISABLE1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1f8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0xf0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G__RXS0_FOM_18__ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFL_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFL_HINT__LSB, 0x0);
+	/* change 0x90 to 0x0 to fix 25G link up keep when cable unplugged */
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFH_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFH_HINT__LSB, 0x0);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__LSB, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1,
+		       S25G_PHY_RX_CTLE_TAP_FRACP1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2,
+		       S25G_PHY_RX_CTLE_TAP_FRACP2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3,
+		       S25G_PHY_RX_CTLE_TAP_FRACP3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_11, ana_test_adc_clkgen_i, 0x0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_test_adc_clkgen_i,
+			      0x0);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x0);
+	set_fields_e56(&rdata, 14, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 21, 12, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+u32
+txgbe_e56_cfg_10g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+
+	addr = E56G_CMS_ANA_OVRDVAL_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G_CMS_ANA_OVRDVAL_9_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_test_in_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 19, 16, 0x6);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/* Setting TX FFE */
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_10GB_FULL);
+
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->prediv0 = 0xfa0;
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->target_cnt0 = 0x203a;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_range_sel0 = 0x2;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->vco_code_init = 0x7ff;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_current_boost_en0 = 0x1;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->bbcdr_current_boost0 = 0x0;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xc);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_0 *)&rdata)->adc_intl2slice_delay0 = 0x5555;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_2 *)&rdata)->interleaver_hbw_disable0 = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1e8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0x78);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1,
+		       S10G_PHY_RX_CTLE_TAP_FRACP1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2,
+		       S10G_PHY_RX_CTLE_TAP_FRACP2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3,
+		       S10G_PHY_RX_CTLE_TAP_FRACP3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_11, ana_test_adc_clkgen_i, 0x0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_test_adc_clkgen_i,
+			      0x0);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x6);
+	set_fields_e56(&rdata, 14, 13, 0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 9, 4, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+static inline int
+txgbe_e56_rxs_osc_init_for_temp_track_range(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int addr, rdata, timer;
+	int T = 40;
+	int RX_COARSE_MID_TD, CMVAR_RANGE_H = 0, CMVAR_RANGE_L = 0;
+	int OFFSET_CENTRE_RANGE_H, OFFSET_CENTRE_RANGE_L, RANGE_FINAL;
+	int i = 0;
+	int lane_num = 1;
+	/* 1. Read the temperature T just before RXS is enabled. */
+	txgbe_e56_get_temp(hw, &T);
+
+	/* 2. Define software variable RX_COARSE_MID_TD (RX Coarse Code mid value dependent upon temperature) */
+	if (T < -5)
+		RX_COARSE_MID_TD = 10;
+	else if (T < 30)
+		RX_COARSE_MID_TD = 9;
+	else if (T < 65)
+		RX_COARSE_MID_TD = 8;
+	else if (T < 100)
+		RX_COARSE_MID_TD = 7;
+	else
+		RX_COARSE_MID_TD = 6;
+
+	/* Set CMVAR_RANGE_H/L based on the link speed mode */
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL || speed == TXGBE_LINK_SPEED_40GB_FULL) { //10G mode
+		CMVAR_RANGE_H = S10G_CMVAR_RANGE_H;
+		CMVAR_RANGE_L = S10G_CMVAR_RANGE_L;
+	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) { //25G mode
+		CMVAR_RANGE_H = S25G_CMVAR_RANGE_H;
+		CMVAR_RANGE_L = S25G_CMVAR_RANGE_L;
+	}
+
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL)
+		lane_num = 4;
+
+	/* 3. Program ALIAS::RXS::RANGE_SEL = CMVAR::RANGE_H */
+	for (i = 0; i < lane_num; i++) {
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, CMVAR_RANGE_H);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDEN_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/*
+		 * 4. Do SEQ::RX_ENABLE to enable RXS, and let it stop after oscillator calibration.
+		 * This needs to be done by blocking the RX power-up fsm at the state following the oscillator calibration state. 
+		 * Follow below steps to do the same before SEQ::RX_ENABLE.
+		 * a. ALIAS::PDIG::CTRL_FSM_RX_ST can be stopped at RX_SAMP_CAL_ST which is the state
+		 * after RX_OSC_CAL_ST by configuring ALIAS::RXS::SAMP_CAL_DONE=0b0
+		 */
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* Do SEQ::RX_ENABLE to enable RXS */
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, (0x1 << i));
+		wr32_ephy(hw, addr, rdata);
+
+		/* b. Poll ALIAS::PDIG::CTRL_FSM_RX_ST and confirm its value is RX_SAMP_CAL_ST */
+		rdata = 0;
+		timer = 0;
+		while ((rdata >> (i * 8) & 0x3f) != 0x9) {
+			usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_INTR_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if (rdata & (0x100 << i))
+				break;
+
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				DEBUGOUT("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!\n");
+				break;
+				return -1;
+			}
+		}
+
+		/* 5/6.Define software variable as OFFSET_CENTRE_RANGE_H = ALIAS::RXS::COARSE */
+		rdata = 0;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		OFFSET_CENTRE_RANGE_H = (rdata >> 4) & 0xf;
+		if(OFFSET_CENTRE_RANGE_H > RX_COARSE_MID_TD) {
+			OFFSET_CENTRE_RANGE_H = OFFSET_CENTRE_RANGE_H - RX_COARSE_MID_TD;
+		} else {
+			OFFSET_CENTRE_RANGE_H = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_H;
+		}
+
+		/* 7. Do SEQ::RX_DISABLE to disable RXS. Poll ALIAS::PDIG::CTRL_FSM_RX_ST and confirm */
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		timer = 0;
+		while (1) {
+		usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if (((rdata >> (i * 8)) & 0x3f) == 0x21) { break; }
+			if (timer++ > PHYINIT_TIMEOUT) {
+				DEBUGOUT("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!\n");
+				break;
+				return -1;
+			}
+		}
+
+		/*
+		 * 8. Since RX power-up fsm is stopped in RX_SAMP_CAL_ST, it is possible the timeout interrupt is set.
+		 * Clear the same by clearing ALIAS::PDIG::INTR_CTRL_FSM_RX_ERR.
+		 * Also clear ALIAS::PDIG::INTR_RX_OSC_FREQ_ERR which could also be set.
+		 */
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		usec_delay(500);
+		addr  = E56PHY_INTR_0_ADDR;
+		wr32_ephy(hw, addr, rdata);
+	   
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		/* 9. Program ALIAS::RXS::RANGE_SEL = CMVAR::RANGE_L */
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, CMVAR_RANGE_L);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDEN_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* 10. Do SEQ::RX_ENABLE to enable RXS, and let it stop after oscillator calibration. */
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, (0x1 << i));
+		wr32_ephy(hw, addr, rdata);
+		
+		/* poll CTRL_FSM_RX_ST */
+		timer = 0;
+		while (((rdata >> (i * 8)) & 0x3f) != 0x9) {
+			usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_INTR_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if ((rdata & 0x100) == 0x100)
+				break;
+
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if (timer++ > PHYINIT_TIMEOUT) {
+				DEBUGOUT("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!\n");
+				break;
+				return -1;
+			}
+		}
+
+		/*
+		 * 11/12.Define software variable as OFFSET_CENTRE_RANGE_L = ALIAS::RXS::COARSE -
+		 * RX_COARSE_MID_TD. Clear the INTR.
+		 */
+		rdata = 0;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		OFFSET_CENTRE_RANGE_L = (rdata >> 4) & 0xf;
+		if(OFFSET_CENTRE_RANGE_L > RX_COARSE_MID_TD) {
+			OFFSET_CENTRE_RANGE_L = OFFSET_CENTRE_RANGE_L - RX_COARSE_MID_TD;
+		} else {
+			OFFSET_CENTRE_RANGE_L = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_L;
+		}
+
+		/* 13. Perform below calculation in software. Goal is to pick range value which is closer to RX_COARSE_MID_TD */
+		if (OFFSET_CENTRE_RANGE_L < OFFSET_CENTRE_RANGE_H) {
+			RANGE_FINAL = CMVAR_RANGE_L;
+		}
+		else {
+			RANGE_FINAL = CMVAR_RANGE_H;
+		}
+
+		/*
+		 * 14. Do SEQ::RX_DISABLE to disable RXS. Poll ALIAS::PDIG::CTRL_FSM_RX_ST
+		 * and confirm its value is POWERDN_ST
+		 */
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		timer = 0;
+		while (1) {
+		usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if (((rdata  >> (i * 8)) & 0x3f) == 0x21) { break; }
+			if (timer++ > PHYINIT_TIMEOUT) {
+				DEBUGOUT("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!\n");
+				break;
+				return -1;
+			}
+		}
+
+		/*
+		 * 15. Since RX power-up fsm is stopped in RX_SAMP_CAL_ST,
+		 * it is possible the timeout interrupt is set. Clear the same by clearing
+		 * ALIAS::PDIG::INTR_CTRL_FSM_RX_ERR. Also clear ALIAS::PDIG::INTR_RX_OSC_FREQ_ERR
+		 * which could also be set.
+		 */
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
+		wr32_ephy(hw, addr, rdata);
+
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		/* 16. Program ALIAS::RXS::RANGE_SEL = RANGE_FINAL */
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, RANGE_FINAL);
+		wr32_ephy(hw, addr, rdata);
+
+		/*
+		 * 17. Program following before enabling RXS. Purpose is to disable power-up FSM control on ADC offset adaptation
+		 * Note: this step will be done in 2.3.3 RXS calibration and adaptation sequence
+		 * 18. After this SEQ::RX_ENABLE can be done at any time. Note to ensure that ALIAS::RXS::RANGE_SEL = RANGE_FINAL configuration is retained.
+		 * Rmove the OVRDEN on rxs0_rx0_samp_cal_done_o
+		 */
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	rdata = 0;
+	addr  = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL)
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0xf);
+	else
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	return status;
+}
+
+static inline
+int txgbe_e56_set_rxs_ufine_le_max(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	unsigned int ULTRAFINE_CODE;
+
+	unsigned int CMVAR_UFINE_MAX = 0;
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL)
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+	else if (speed == TXGBE_LINK_SPEED_25GB_FULL)
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+
+	/* a. Assign software defined variables as below */
+	/* ii. ULTRAFINE_CODE = ALIAS::RXS::ULTRAFINE */
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	/* b. Perform the below logic sequence */
+	while (ULTRAFINE_CODE > CMVAR_UFINE_MAX) {
+		ULTRAFINE_CODE = ULTRAFINE_CODE - 1;
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+				      ULTRAFINE_CODE);
+		/* Set ovrd_en=1 to overide ASIC value */
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i,
+				      1);
+		/*  Wait until 1milliseconds or greater */
+		msleep(10);
+	}
+
+	return status;
+}
+
+int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE)
+{
+	int status = 0, i, N, median;
+	unsigned int rdata;
+	int arraySize, RXS_BBCDR_SECOND_ORDER_ST[5];
+
+
+	/* Set ovrd_en=0 to read ASIC value */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i, 0);
+
+	/*
+	 * As status update from RXS hardware is asynchronous to read status
+	 * of SECOND_ORDER, follow sequence mentioned below.
+	 */
+	N = 5;
+	for (i = 0; i < N; i = i + 1) {
+		/* set RXS_BBCDR_SECOND_ORDER_ST[i] = RXS::ANA_OVRDVAL[5]::ana_bbcdr_int_cstm_i[4:0] */
+		EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					       ana_bbcdr_int_cstm_i);
+		usec_delay(100);
+	}
+
+	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
+	arraySize = sizeof(RXS_BBCDR_SECOND_ORDER_ST) / sizeof(
+			    RXS_BBCDR_SECOND_ORDER_ST[0]);
+	qsort(RXS_BBCDR_SECOND_ORDER_ST, arraySize, sizeof(int), compare);
+
+	median = ((N + 1) / 2) -1;
+	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
+
+	return status;
+}
+
+/*
+ * 2.3.4 RXS post CDR lock temperature tracking sequence
+ *
+ * Below sequence must be run before the temperature drifts by >5degC
+ * after the CDR locks for the first time or after the ious time this
+ * sequence was run. It is recommended to call this sequence periodically
+ * (eg: once every 100ms) or trigger sequence if the temperature drifts
+ * by >=5degC. Temperature must be read from an on-die temperature sensor.
+ */
+
+int txgbe_temp_track_seq(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	int SECOND_CODE;
+	int COARSE_CODE;
+	int FINE_CODE;
+	int ULTRAFINE_CODE;
+
+	int CMVAR_SEC_LOW_TH ;
+	int CMVAR_UFINE_MAX = 0;
+	int CMVAR_FINE_MAX ;
+	int CMVAR_UFINE_UMAX_WRAP = 0;
+	int CMVAR_COARSE_MAX ;
+	int CMVAR_UFINE_FMAX_WRAP = 0;
+	int CMVAR_FINE_FMAX_WRAP = 0;
+	int CMVAR_SEC_HIGH_TH ;
+	int CMVAR_UFINE_MIN ;
+	int CMVAR_FINE_MIN ;
+	int CMVAR_UFINE_UMIN_WRAP ;
+	int CMVAR_COARSE_MIN ;
+	int CMVAR_UFINE_FMIN_WRAP ;
+	int CMVAR_FINE_FMIN_WRAP ;
+	int temperature;
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		CMVAR_SEC_LOW_TH = S10G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S10G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S10G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S10G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S10G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S10G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S10G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S10G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S10G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S10G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S10G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S10G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S10G_CMVAR_FINE_FMIN_WRAP ;
+	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		CMVAR_SEC_LOW_TH = S25G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S25G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S25G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S25G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S25G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S25G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S25G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S25G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S25G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S25G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S25G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S25G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S25G_CMVAR_FINE_FMIN_WRAP;
+	} else {
+		DEBUGOUT("Error Speed\n");
+		return 0;
+	}
+
+	status = txgbe_e56_get_temp(hw, &temperature);
+	if (status)
+		return 0;
+
+	hw->temperature = temperature;
+
+	/*
+	 * Assign software defined variables as below
+	 * a. SECOND_CODE = ALIAS::RXS::SECOND_ORDER
+	 */
+	status |= txgbe_e56_rx_rd_second_code(hw, &SECOND_CODE);
+
+	/*
+	 * b. COARSE_CODE = ALIAS::RXS::COARSE
+	 * c. FINE_CODE = ALIAS::RXS::FINE
+	 * d. ULTRAFINE_CODE = ALIAS::RXS::ULTRAFINE
+	 */
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	COARSE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i);
+	FINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
+		if (ULTRAFINE_CODE < CMVAR_UFINE_MAX) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE + 1);
+			/* Set ovrd_en=1 to overide ASIC value */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE < CMVAR_FINE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			/*
+			 * Note: All two of above code updates should be written in a single register write
+			 * Set ovrd_en=1 to overide ASIC value
+			 */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE < CMVAR_COARSE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			/*
+			 * Note: All three of above code updates should be written in a single register write
+			 * Set ovrd_en=1 to overide ASIC value
+			 */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else {
+			PMD_DRV_LOG(ERR, "ERROR: (SECOND_CODE <= CMVAR_SEC_LOW_TH) temperature "
+				    "tracking occurs Error condition");
+		}
+	} else if (SECOND_CODE >= CMVAR_SEC_HIGH_TH) {
+		if (ULTRAFINE_CODE > CMVAR_UFINE_MIN) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE - 1);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE > CMVAR_FINE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE > CMVAR_COARSE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else {
+			PMD_DRV_LOG(ERR, "ERROR: (SECOND_CODE >= CMVAR_SEC_HIGH_TH) "
+				    "temperature tracking occurs Error condition");
+		}
+	}
+
+	return status;
+}
+
+static inline int
+txgbe_e56_ctle_bypass_seq(struct txgbe_hw *hw, u32 speed)
+{
+	unsigned int rdata;
+
+	/* 1. Program the following RXS registers as mentioned below. */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+
+	/* 2. Program the following PDIG registers as mentioned below. */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 1;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		/* 1. Program the following RXS registers as mentioned below. */
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+
+		/* 2. Program the following PDIG registers as mentioned below. */
+		EPHY_RREG(E56G__PMD_RXS1_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS1_OVRDVAL_1);
+		EPHY_RREG(E56G__PMD_RXS2_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS2_OVRDVAL_1);
+		EPHY_RREG(E56G__PMD_RXS3_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS3_OVRDVAL_1);
+
+		EPHY_RREG(E56G__PMD_RXS1_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS1_OVRDEN_1);
+		EPHY_RREG(E56G__PMD_RXS2_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS2_OVRDEN_1);
+		EPHY_RREG(E56G__PMD_RXS3_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS3_OVRDEN_1);
+	}
+	return 0;
+}
+
+static inline int
+txgbe_e56_rxs_calib_adapt_seq(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0, i;
+	u32 addr, timer;
+	u32 rdata = 0x0;
+	u32 bypassCtle = 1;
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
+	    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1)
+		bypassCtle = 0;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		msleep(350);
+		rdata = rd32(hw, TXGBE_GPIOEXT);
+		if (rdata & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS)) {
+			if (rdata & TXGBE_SFP1_MOD_ABS_LS)
+				PMD_DRV_LOG(DEBUG,
+					    "E56phyRxsCalibAdaptSeq TXGBE_SFP1_MOD_ABS_LS");
+			else if (rdata & TXGBE_SFP1_RX_LOS_LS)
+				PMD_DRV_LOG(DEBUG,
+					    "E56phyRxsCalibAdaptSeq TXGBE_SFP1_RX_LOS_LS");
+			return TXGBE_ERR_PHY_INIT_NOT_DONE;
+		}
+	}
+
+	rdata = 0;
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	if (bypassCtle == 1)
+		txgbe_e56_ctle_bypass_seq(hw, speed);
+
+	/*
+	 * 2. Follow sequence described in 2.3.2 RXS Osc Initialization for temperature
+	 * tracking range here. RXS would be enabled at the end of this sequence. For the case
+	 * when PAM4 KR training is not enabled (including PAM4 mode without KR training),
+	 * wait until ALIAS::PDIG::CTRL_FSM_RX_ST would return RX_TRAIN_15_ST (RX_RDY_ST).
+	 */
+	txgbe_e56_rxs_osc_init_for_temp_track_range(hw, speed);
+
+	addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+	timer = 0;
+	rdata = 0;
+	while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0,
+			 ctrl_fsm_rx0_st) != E56PHY_RX_RDY_ST) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
+		EPHY_RREG(E56G__PMD_CTRL_FSM_RX_STAT_0);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			rdata = 0;
+			addr  = E56PHY_PMD_CFG_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+			wr32_ephy(hw, addr, rdata);
+			return TXGBE_ERR_TIMEOUT;
+		}
+	}
+
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	/*
+	 * 4. Disable VGA and CTLE training so that they don't interfere with ADC calibration
+	 * a. Set ALIAS::RXS::VGA_TRAIN_EN = 0b0
+	 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/* b. Set ALIAS::RXS::CTLE_TRAIN_EN = 0b0 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/*
+	 * 5. Perform ADC interleaver calibration
+	 * a. Remove the OVERRIDE on ALIAS::RXS::ADC_INTL_CAL_DONE
+	 */
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O
+		       , 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	timer = 0;
+	while (((rdata >> E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB) & 1)
+	       != 1) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(1000);
+		if (timer++ > PHYINIT_TIMEOUT)
+			break;
+	}
+
+	/*
+	 * 6. Perform ADC offset adaptation and ADC gain adaptation,
+	 * repeat them a few times and after that keep it disabled.
+	 */
+	for (i = 0; i < 16; i++) {
+		/* a. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b1 */
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* b. Wait for 1ms or greater */
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_ofst_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+
+		/* c. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b0 */
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		/* d. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b1 */
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* e. Wait for 1ms or greater */
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_gain_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+
+		/* f. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b0 */
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+	}
+	/* g. Repeat #a to #f total 16 times */
+
+	/*
+	 * 7. Perform ADC interleaver adaptation for 10ms or greater, and after that disable it
+	 * a. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b1
+	 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+	/* b. Wait for 10ms or greater */
+	msleep(10);
+
+	/* c. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b0 */
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_intl_adapt_en_i, 0);
+
+	/*
+	 * 8. Now re-enable VGA and CTLE trainings, so that it continues to adapt tracking changes in temperature or voltage
+	 * <1> Set ALIAS::RXS::VGA_TRAIN_EN = 0b1
+	 *     Set ALIAS::RXS::CTLE_TRAIN_EN = 0b1
+	 */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_en_i) = 1;
+	if (bypassCtle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	/*
+	 * <2> wait for ALIAS::RXS::VGA_TRAIN_DONE = 1
+	 *     wait for ALIAS::RXS::CTLE_TRAIN_DONE = 1
+	 */
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+			      ovrd_en_rxs0_rx0_vga_train_done_o, 0);
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_done_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			break;
+	}
+
+	if (bypassCtle == 0) {
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+				      ovrd_en_rxs0_rx0_ctle_train_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+	}
+
+	/* a. Remove the OVERRIDE on ALIAS::RXS::VGA_TRAIN_EN */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+	/* b. Remove the OVERRIDE on ALIAS::RXS::CTLE_TRAIN_EN */
+	if (bypassCtle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	return status;
+}
+
+static inline u32
+txgbe_e56_cfg_temp(struct txgbe_hw *hw)
+{
+	u32 status;
+	u32 value;
+	int temp;
+
+	status = txgbe_e56_get_temp(hw, &temp);
+	if (status)
+		temp = DEFAULT_TEMP;
+
+	if (temp < DEFAULT_TEMP) {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN0);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL2);
+		set_fields_e56(&value, 20, 16, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL2, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 12, 12, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL7);
+		set_fields_e56(&value, 8, 4, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL7, value);
+	} else if (temp > HIGH_TEMP) {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN0);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL2);
+		set_fields_e56(&value, 20, 16, 0x3);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL2, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 12, 12, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL7);
+		set_fields_e56(&value, 8, 4, 0x3);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL7, value);
+	} else {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 4, 4, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL4);
+		set_fields_e56(&value, 24, 24, 0x1);
+		set_fields_e56(&value, 31, 29, 0x4);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL4, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL5);
+		set_fields_e56(&value, 1, 0, 0x0);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 23, 23, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL9);
+		set_fields_e56(&value, 24, 24, 0x1);
+		set_fields_e56(&value, 31, 29, 0x4);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL9, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL10);
+		set_fields_e56(&value, 1, 0, 0x0);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL10, value);
+	}
+
+	return 0;
+}
+
+static int txgbe_e56_config_rx(struct txgbe_hw *hw, u32 speed)
+{
+	s32 status;
+
+	status = txgbe_e56_rxs_calib_adapt_seq(hw, speed);
+	if (status)
+		return status;
+
+	/* Step 2 of 2.3.4 */
+	txgbe_e56_set_rxs_ufine_le_max(hw, speed);
+
+	/* 2.3.4 RXS post CDR lock temperature tracking sequence */
+	txgbe_temp_track_seq(hw, speed);
+
+	return 0;
+}
+
+/*
+ * 2.2.10 SEQ::RX_DISABLE
+ * Use PDIG::PMD_CFG[0]::rx_en_cfg[<lane no.>] = 0b0 to powerdown specific RXS lanes.
+ * Completion of RXS powerdown can be confirmed by observing ALIAS::PDIG::CTRL_FSM_RX_ST = POWERDN_ST
+ */
+static int txgbe_e56_disable_rx(struct txgbe_hw *hw)
+{
+	int status = 0;
+	unsigned int rdata, timer;
+	unsigned int addr, temp;
+
+	/* 1. Disable OVERRIDE on below aliases */
+	/* a. ALIAS::RXS::RANGE_SEL */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_bbcdr_osc_range_sel_i, 0);
+
+	EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+	/* b. ALIAS::RXS::COARSE */
+	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 0;
+	/* c. ALIAS::RXS::FINE */
+	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 0;
+	/* d. ALIAS::RXS::ULTRAFINE */
+	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 0;
+	EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+
+	/* e. ALIAS::RXS::SAMP_CAL_DONE */
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_0, ovrd_en_rxs0_rx0_samp_cal_done_o, 0);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_2);
+	/* f. ALIAS::RXS::ADC_OFST_ADAPT_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_ofst_adapt_en_i) = 0;
+	/* g. ALIAS::RXS::ADC_GAIN_ADAPT_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_gain_adapt_en_i) = 0;
+	/* j. ALIAS::RXS::ADC_INTL_ADAPT_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_intl_adapt_en_i) = 0;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_2);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	/* h. ALIAS::RXS::ADC_INTL_CAL_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_adc_intl_cal_en_i) = 0;
+	/* i. ALIAS::RXS::ADC_INTL_CAL_DONE */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_adc_intl_cal_done_o) = 0;
+	/* k. ALIAS::RXS::CDR_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_cdr_en_i) = 0;
+	/* l. ALIAS::RXS::VGA_TRAIN_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+	/* m. ALIAS::RXS::CTLE_TRAIN_EN */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+	/* p. ALIAS::RXS::RX_FETX_TRAIN_DONE */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_train_done_o) = 0;
+	/* r. ALIAS::RXS::RX_TXFFE_COEFF_CHANGE */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_coeff_change_o) = 0;
+	/* s. ALIAS::RXS::RX_TXFFE_TRAIN_ENACK */
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_train_enack_o) = 0;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_3);
+	/* n. ALIAS::RXS::RX_FETX_MOD_TYPE */
+	/* o. ALIAS::RXS::RX_FETX_MOD_TYPE_UPDATE */
+	temp = EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o) = temp & 0x8F;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_3);
+
+	/* q. ALIAS::RXS::SLICER_THRESHOLD_OVRD_EN */
+	EPHY_RREG(E56G__RXS0_DIG_OVRDEN_1);
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, top_comp_th_ovrd_en) = 0;
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, mid_comp_th_ovrd_en) = 0;
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, bot_comp_th_ovrd_en) = 0;
+	EPHY_WREG(E56G__RXS0_DIG_OVRDEN_1);
+
+	/* 2. Disable pattern checker */
+	txgbe_e56_ephy_config(E56G__RXS0_DFT_1, ber_en, 0);
+
+	/* 3. Disable internal serial loopback mode */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_3, ovrd_en_ana_sel_lpbk_i, 0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_en_adccal_lpbk_i, 0);
+
+	//4. Enable bypass of clock gates in RXS */
+	txgbe_e56_ephy_config(E56G__RXS0_RXS_CFG_0, train_clk_gate_bypass_en, 0x1FFF);
+
+	//5. Disable KR training mode */
+	//a. ALIAS::PDIG::KR_TRAINING_MODE = 0b0 */
+	txgbe_e56_ephy_config(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln0, 0);
+
+	//6. Disable RX to TX parallel loopback */
+	//a. ALIAS::PDIG::RX_TO_TX_LPBK_EN = 0b0 */
+	txgbe_e56_ephy_config(E56G__PMD_PMD_CFG_5, rx_to_tx_lpbk_en, 0);
+
+	/*
+	 * The FSM to disable RXS is present in PDIG. The FSM disables the RXS when
+	 * PDIG::PMD_CFG[0]::rx_en_cfg[<lane no.>] = 0b0
+	 */
+	txgbe_e56_ephy_config(E56G__PMD_PMD_CFG_0, rx_en_cfg, 0);
+
+	/* Wait RX FSM to be POWERDN_ST */
+	timer = 0;
+	while (1) {
+		rdata = 0;
+		addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x3f) == 0x21)
+			break;
+		usec_delay(100);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			DEBUGOUT("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!\n");
+			break;
+		}
+	}
+
+	return status;
+}
+
+int txgbe_e56_reconfig_rx(struct txgbe_hw *hw, u32 speed)
+{
+	u32 addr;
+	u32 rdata;
+	int status = 0;
+
+	wr32m(hw, TXGBE_MACTXCFG, TXGBE_MACTXCFG_TXE,
+	      ~TXGBE_MACTXCFG_TXE);
+	wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+	      ~TXGBE_MACRXCFG_ENA);
+
+	hw->mac.disable_sec_tx_path(hw);
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		rdata = rd32(hw, TXGBE_GPIOEXT);
+		if (rdata & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS)) {
+			return TXGBE_ERR_TIMEOUT;
+		}
+	}
+
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, 0x0);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, 0x0);
+
+	/*
+	 * 14. Do SEQ::RX_DISABLE to disable RXS. Poll ALIAS::PDIG::CTRL_FSM_RX_ST
+	 * and confirm its value is POWERDN_ST
+	 */
+	txgbe_e56_disable_rx(hw);
+	status = txgbe_e56_config_rx(hw, speed);
+
+	addr = E56PHY_INTR_0_ADDR;
+	wr32_ephy(hw, addr, E56PHY_INTR_0_IDLE_ENTRY1);
+
+	addr = E56PHY_INTR_1_ADDR;
+	wr32_ephy(hw, addr, E56PHY_INTR_1_IDLE_EXIT1);
+
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+
+	hw->mac.enable_sec_tx_path(hw);
+
+	return status;
+}
+
+int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed)
+{
+	u32 value = 0;
+	u32 ppl_lock = false;
+	int status = 0;
+	u32 reset = 0;
+
+	PMD_DRV_LOG(DEBUG, "port[%d] force set speed: 0x%x", hw->bus.lan_id, speed);
+
+	if ((rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK) ==
+	     TXGBE_EPHY_STAT_PPL_LOCK) {
+		ppl_lock = true;
+		wr32m(hw, TXGBE_MACTXCFG, TXGBE_MACTXCFG_TXE,
+		      ~TXGBE_MACTXCFG_TXE);
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+		      ~TXGBE_MACRXCFG_ENA);
+
+		hw->mac.disable_sec_tx_path(hw);
+	}
+
+	if (hw->mac.type == txgbe_mac_aml)
+		hw->mac.disable_tx_laser(hw);
+
+	if (hw->bus.lan_id == 0)
+		reset = TXGBE_RST_EPHY_LAN_0;
+
+	else
+		reset = TXGBE_RST_EPHY_LAN_1;
+
+	wr32(hw, TXGBE_RST,
+	     reset | rd32(hw, TXGBE_RST));
+	txgbe_flush(hw);
+	usec_delay(10);
+
+	/* XLGPCS REGS Start */
+	value = rd32_epcs(hw, VR_PCS_DIG_CTRL1);
+	value |= 0x8000;
+	wr32_epcs(hw, VR_PCS_DIG_CTRL1, value);
+
+	usec_delay(1000);
+	value = rd32_epcs(hw, VR_PCS_DIG_CTRL1);
+	if ((value & 0x8000)) {
+		status = TXGBE_ERR_PHY_INIT_NOT_DONE;
+		hw->mac.enable_tx_laser(hw);
+		goto out;
+	}
+
+	value = rd32_epcs(hw, SR_AN_CTRL);
+	set_fields_e56(&value, 12, 12, 0);
+	wr32_epcs(hw, SR_AN_CTRL, value);
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 5);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 7);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
+
+		value = rd32_epcs(hw, SR_PMA_CTRL2);
+		set_fields_e56(&value, 6, 0, 0x39);
+		wr32_epcs(hw, SR_PMA_CTRL2, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL0);
+		set_fields_e56(&value, 29, 29, 0x1);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL5);
+		/* Update to 0 from SNPS for PIN CLKP/N: Enable the termination of the input buffer */
+		set_fields_e56(&value, 24, 24, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN1);
+		set_fields_e56(&value, 30, 30, 0x1);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, PLL0_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL0_CFG0, value);
+
+		value = rd32_ephy(hw, PLL0_CFG2);
+		set_fields_e56(&value, 12, 8, 0x4);
+		wr32_ephy(hw, PLL0_CFG2, value);
+
+		value = rd32_ephy(hw, PLL1_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL1_CFG0, value);
+
+		value = rd32_ephy(hw, PLL1_CFG2);
+		set_fields_e56(&value, 12, 8, 0x8);
+		wr32_ephy(hw, PLL1_CFG2, value);
+
+		value = rd32_ephy(hw, PLL0_DIV_CFG0);
+		set_fields_e56(&value, 18, 8, 0x294);
+		set_fields_e56(&value, 4, 0, 0x8);
+		wr32_ephy(hw, PLL0_DIV_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG0);
+		set_fields_e56(&value, 30, 28, 0x7);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 18, 16, 0x3);
+		set_fields_e56(&value, 14, 12, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG1);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		set_fields_e56(&value, 18, 16, 0x3);
+		set_fields_e56(&value, 2, 0, 0x3);
+		wr32_ephy(hw, DATAPATH_CFG1, value);
+
+		value = rd32_ephy(hw, AN_CFG1);
+		set_fields_e56(&value, 4, 0, 0x9);
+		wr32_ephy(hw, AN_CFG1, value);
+
+		txgbe_e56_cfg_temp(hw);
+		txgbe_e56_cfg_25g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0x1); /* TX_EN set */
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+	}
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 0);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 0);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
+
+		value = rd32_epcs(hw, SR_PMA_CTRL2);
+		set_fields_e56(&value, 6, 0, 0xb);
+		wr32_epcs(hw, SR_PMA_CTRL2, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL0);
+		set_fields_e56(&value, 29, 29, 0x1);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL5);
+		set_fields_e56(&value, 24, 24, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN1);
+		set_fields_e56(&value, 30, 30, 0x1);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, PLL0_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL0_CFG0, value);
+
+		value = rd32_ephy(hw, PLL0_CFG2);
+		set_fields_e56(&value, 12, 8, 0x4);
+		wr32_ephy(hw, PLL0_CFG2, value);
+
+		value = rd32_ephy(hw, PLL1_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL1_CFG0, value);
+
+		value = rd32_ephy(hw, PLL1_CFG2);
+		set_fields_e56(&value, 12, 8, 0x8);
+		wr32_ephy(hw, PLL1_CFG2, value);
+
+		value = rd32_ephy(hw, PLL0_DIV_CFG0);
+		set_fields_e56(&value, 18, 8, 0x294);
+		set_fields_e56(&value, 4, 0, 0x8);
+		wr32_ephy(hw, PLL0_DIV_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG0);
+		set_fields_e56(&value, 30, 28, 0x7);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 14, 12, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG1);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 2, 0, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG1, value);
+
+		value = rd32_ephy(hw, AN_CFG1);
+		set_fields_e56(&value, 4, 0, 0x2);
+		wr32_ephy(hw, AN_CFG1, value);
+
+		txgbe_e56_cfg_temp(hw);
+		txgbe_e56_cfg_10g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0x1); /* TX_EN set */
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+	}
+
+	if (hw->mac.type == txgbe_mac_aml)
+		hw->mac.enable_tx_laser(hw);
+
+	status = txgbe_e56_config_rx(hw, speed);
+
+	value = rd32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR);
+	set_fields_e56(&value, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0x28);
+	set_fields_e56(&value, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0xa);
+	wr32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR, value);
+
+	wr32_ephy(hw, E56PHY_INTR_0_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+
+	if (hw->fec_mode != TXGBE_PHY_FEC_AUTO) {
+		hw->cur_fec_link = hw->fec_mode;
+		txgbe_e56_fec_set(hw);
+	}
+
+out:
+	if (ppl_lock) {
+		hw->mac.enable_sec_tx_path(hw);
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+		      TXGBE_MACRXCFG_ENA);
+	}
+
+	return status;
+}
+
+s32 txgbe_e56_fec_set(struct txgbe_hw *hw)
+{
+	u32 value;
+
+	if (hw->cur_fec_link  & TXGBE_PHY_FEC_RS) {
+		/* disable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 0);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+
+		/* enable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x68c1);
+		wr32_epcs(hw, 0x180a4, 0x3321);
+		wr32_epcs(hw, 0x180a5, 0x973e);
+		wr32_epcs(hw, 0x180a6, 0xccde);
+
+		wr32_epcs(hw, 0x38018, 1024);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 1);
+		wr32_epcs(hw, 0x100c8, value);
+	} else if (hw->cur_fec_link & TXGBE_PHY_FEC_BASER) {
+		/* disable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x7690);
+		wr32_epcs(hw, 0x180a4, 0x3347);
+		wr32_epcs(hw, 0x180a5, 0x896f);
+		wr32_epcs(hw, 0x180a6, 0xccb8);
+		wr32_epcs(hw, 0x38018, 0x3fff);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 0);
+		wr32_epcs(hw, 0x100c8, value);
+
+		/* enable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 1);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+	} else {
+		/* disable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x7690);
+		wr32_epcs(hw, 0x180a4, 0x3347);
+		wr32_epcs(hw, 0x180a5, 0x896f);
+		wr32_epcs(hw, 0x180a6, 0xccb8);
+		wr32_epcs(hw, 0x38018, 0x3fff);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 0);
+		wr32_epcs(hw, 0x100c8, value);
+
+		/* disable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 0);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+	}
+
+	return 0;
+}
+
+s32 txgbe_e56_fec_polling(struct txgbe_hw *hw, bool *link_up)
+{
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	s32 i = 0, j = 0;
+
+	do {
+		if (!(hw->fec_mode & BIT(j))) {
+			j += 1;
+			continue;
+		}
+
+		hw->cur_fec_link = hw->fec_mode & BIT(j);
+
+		/*
+		 * If in fec auto mode, try another fec mode after no link in 1s
+		 * for lr sfp, enable KR-FEC to link up with mellonax and intel
+		 */
+		rte_spinlock_lock(&hw->phy_lock);
+		txgbe_e56_fec_set(hw);
+		rte_spinlock_unlock(&hw->phy_lock);
+
+		for (i = 0; i < 4; i++) {
+			msleep(250);
+			txgbe_e56_check_phy_link(hw, &link_speed, link_up);
+			if (*link_up)
+				return 0;
+		}
+		j += 1;
+	} while (j < 3);
+
+	return 0;
+}
diff --git a/drivers/net/txgbe/base/txgbe_e56.h b/drivers/net/txgbe/base/txgbe_e56.h
new file mode 100644
index 0000000000..d9b3d70cf1
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56.h
@@ -0,0 +1,1749 @@
+#ifndef _TXGBE_E56_H_
+#define _TXGBE_E56_H_
+
+#include "txgbe_type.h"
+#include "txgbe_hw.h"
+#include "txgbe_osdep.h"
+#include "txgbe_phy.h"
+
+#define EPHY_RREG(REG) \
+	do {\
+		rdata = 0; \
+		rdata = rd32_ephy(hw, REG##_ADDR); \
+	} while (0)
+
+#define EPHY_WREG(REG) \
+	do { \
+		wr32_ephy(hw, REG##_ADDR, rdata); \
+	} while (0)
+
+#define EPCS_RREG(REG) \
+	do {\
+		rdata = 0; \
+		rdata = rd32_epcs(hw, REG##_ADDR); \
+	} while (0)
+
+#define EPCS_WREG(REG) \
+	do { \
+		wr32_epcs(hw, REG##_ADDR, rdata); \
+	} while (0)
+
+#define txgbe_e56_ephy_config(reg, field, val) \
+	do { \
+		EPHY_RREG(reg); \
+		EPHY_XFLD(reg, field) = (val); \
+		EPHY_WREG(reg); \
+	} while (0)
+
+#define txgbe_e56_epcs_config(reg, field, val) \
+	do { \
+		EPCS_RREG(reg); \
+		EPCS_XFLD(reg, field) = (val); \
+		EPCS_WREG(reg); \
+	} while (0)
+
+/*
+ * LAN GPIO define for SFP+ module
+ * -- Fields
+ */
+#define SFP1_RS0		5, 5
+#define SFP1_RS1		4, 4
+#define SFP1_RX_LOS		3, 3
+#define SFP1_MOD_ABS		2, 2
+#define SFP1_TX_DISABLE		1, 1
+#define SFP1_TX_FAULT		0, 0
+
+#define EPHY_XFLD(REG, FLD)	((REG *)&rdata)->FLD
+#define EPCS_XFLD(REG, FLD)	((REG *)&rdata)->FLD
+
+typedef union {
+	struct {
+		u32 ana_refclk_buf_daisy_en_i : 1;
+		u32 ana_refclk_buf_pad_en_i : 1;
+		u32 ana_vddinoff_dcore_dig_o : 1;
+		u32 ana_lcpll_en_clkout_hf_left_top_i : 1;
+		u32 ana_lcpll_en_clkout_hf_right_top_i : 1;
+		u32 ana_lcpll_en_clkout_hf_left_bot_i : 1;
+		u32 ana_lcpll_en_clkout_hf_right_bot_i : 1;
+		u32 ana_lcpll_en_clkout_lf_left_top_i : 1;
+		u32 ana_lcpll_en_clkout_lf_right_top_i : 1;
+		u32 ana_lcpll_en_clkout_lf_left_bot_i : 1;
+		u32 ana_lcpll_en_clkout_lf_right_bot_i : 1;
+		u32 ana_bg_en_i : 1;
+		u32 ana_en_rescal_i : 1;
+		u32 ana_rescal_comp_o : 1;
+		u32 ana_en_ldo_core_i : 1;
+		u32 ana_lcpll_hf_en_bias_i : 1;
+		u32 ana_lcpll_hf_en_loop_i : 1;
+		u32 ana_lcpll_hf_en_cp_i : 1;
+		u32 ana_lcpll_hf_set_lpf_i : 1;
+		u32 ana_lcpll_hf_en_vco_i : 1;
+		u32 ana_lcpll_hf_vco_amp_status_o : 1;
+		u32 ana_lcpll_hf_en_odiv_i : 1;
+		u32 ana_lcpll_lf_en_bias_i : 1;
+		u32 ana_lcpll_lf_en_loop_i : 1;
+		u32 ana_lcpll_lf_en_cp_i : 1;
+		u32 ana_lcpll_lf_set_lpf_i : 1;
+		u32 ana_lcpll_lf_en_vco_i : 1;
+		u32 ana_lcpll_lf_vco_amp_status_o : 1;
+		u32 ana_lcpll_lf_en_odiv_i : 1;
+		u32 ana_lcpll_hf_refclk_select_i : 1;
+		u32 ana_lcpll_lf_refclk_select_i : 1;
+		u32 rsvd0 : 1;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_0;
+
+/* AMLITE ETH PHY Registers */
+#define VR_PCS_DIG_CTRL1                        0x38000
+#define SR_PCS_CTRL1                            0x30000
+#define SR_PCS_CTRL2                            0x30007
+#define SR_PMA_CTRL2                            0x10007
+#define VR_PCS_DIG_CTRL3                        0x38003
+#define VR_PMA_CTRL3                            0x180a8
+#define VR_PMA_CTRL4                            0x180a9
+#define SR_PMA_RS_FEC_CTRL                      0x100c8
+#define CMS_ANA_OVRDEN0                         0xca4
+#define ANA_OVRDEN0                             0xca4
+#define ANA_OVRDEN1                             0xca8
+#define ANA_OVRDVAL0                            0xcb0
+#define ANA_OVRDVAL5                            0xcc4
+#define OSC_CAL_N_CDR4                          0x14
+#define PLL0_CFG0                               0xc10
+#define PLL0_CFG2                               0xc18
+#define PLL0_DIV_CFG0                           0xc1c
+#define PLL1_CFG0                               0xc48
+#define PLL1_CFG2                               0xc50
+#define CMS_PIN_OVRDEN0                         0xc8c
+#define CMS_PIN_OVRDVAL0                        0xc94
+#define DATAPATH_CFG0                           0x142c
+#define DATAPATH_CFG1                           0x1430
+#define AN_CFG1                                 0x1438
+#define SPARE52                                 0x16fc
+#define RXS_CFG0                                0x000
+#define PMD_CFG0                                0x1400
+#define SR_PCS_STS1                             0x30001
+#define PMD_CTRL_FSM_TX_STAT0                   0x14dc
+#define CMS_ANA_OVRDEN0                         0xca4
+#define CMS_ANA_OVRDEN1                         0xca8
+#define CMS_ANA_OVRDVAL2                        0xcb8
+#define CMS_ANA_OVRDVAL4                        0xcc0
+#define CMS_ANA_OVRDVAL5                        0xcc4
+#define CMS_ANA_OVRDVAL7                        0xccc
+#define CMS_ANA_OVRDVAL9                        0xcd4
+#define CMS_ANA_OVRDVAL10                       0xcd8
+
+#define TXS_TXS_CFG1                            0x804
+#define TXS_WKUP_CNT                            0x808
+#define TXS_PIN_OVRDEN0                         0x80c
+#define TXS_PIN_OVRDVAL6                        0x82c
+#define TXS_ANA_OVRDVAL1                        0x854
+
+#define E56PHY_CMS_BASE_ADDR                    0x0C00
+
+#define E56PHY_CMS_PIN_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR + 0x8C)
+#define E56PHY_CMS_PIN_OVRDEN_0_OVRD_EN_PLL0_TX_SIGNAL_TYPE_I 12, 12
+
+#define E56PHY_CMS_PIN_OVRDVAL_0_ADDR   (E56PHY_CMS_BASE_ADDR + 0x94)
+#define E56PHY_CMS_PIN_OVRDVAL_0_INT_PLL0_TX_SIGNAL_TYPE_I 10, 10
+
+#define E56PHY_CMS_ANA_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR + 0xA4)
+
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I 29, 29
+
+#define E56PHY_CMS_ANA_OVRDEN_1_ADDR   (E56PHY_CMS_BASE_ADDR + 0xA8)
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I 4, 4
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ADDR   (E56PHY_CMS_BASE_ADDR + 0xB8)
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_VCO_SWING_CTRL_I 31, 28
+
+#define E56PHY_CMS_ANA_OVRDVAL_4_ADDR   (E56PHY_CMS_BASE_ADDR + 0xC0)
+
+#define E56PHY_TXS_BASE_ADDR                    0x0800
+#define E56PHY_TXS1_BASE_ADDR                   0x0900
+#define E56PHY_TXS2_BASE_ADDR                   0x0A00
+#define E56PHY_TXS3_BASE_ADDR                   0x0B00
+#define E56PHY_TXS_OFFSET                       0x0100
+
+#define E56PHY_PMD_RX_OFFSET                    0x02C
+
+#define E56PHY_TXS_TXS_CFG_1_ADDR   (E56PHY_TXS_BASE_ADDR + 0x04)
+#define E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256 7, 4
+#define E56PHY_TXS_WKUP_CNT_ADDR   (E56PHY_TXS_BASE_ADDR + 0x08)
+#define E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32 7, 0
+#define E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32 15, 8
+
+#define E56PHY_TXS_PIN_OVRDEN_0_ADDR   (E56PHY_TXS_BASE_ADDR + 0x0C)
+#define E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I 28, 28
+
+#define E56PHY_TXS_PIN_OVRDVAL_6_ADDR   (E56PHY_TXS_BASE_ADDR + 0x2C)
+
+#define E56PHY_TXS_ANA_OVRDVAL_1_ADDR   (E56PHY_TXS_BASE_ADDR + 0x54)
+#define E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I 23, 8
+
+#define E56PHY_TXS_ANA_OVRDEN_0_ADDR   (E56PHY_TXS_BASE_ADDR + 0x44)
+#define E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I 13, 13
+
+#define E56PHY_RXS_BASE_ADDR   0x0000
+#define E56PHY_RXS1_BASE_ADDR  0x0200
+#define E56PHY_RXS2_BASE_ADDR  0x0400
+#define E56PHY_RXS3_BASE_ADDR  0x0600
+#define E56PHY_RXS_OFFSET      0x0200
+
+#define E56PHY_RXS_RXS_CFG_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x000)
+#define E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL 1, 1
+#define E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN 17, 4
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x008)
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1 15, 0
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1_LSB 0
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1 31, 16
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1_LSB 16
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR   (E56PHY_RXS_BASE_ADDR + 0x014)
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_RANGE_SEL1 3, 2
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_VCO_CODE_INIT 18, 8
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_CURRENT_BOOST_EN1 21, 21
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_BBCDR_CURRENT_BOOST1 27, 26
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR   (E56PHY_RXS_BASE_ADDR + 0x018)
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH 3, 2
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK 15, 12
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK 19, 16
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK 23, 20
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK 27, 24
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT 30, 28
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR   (E56PHY_RXS_BASE_ADDR + 0x01C)
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK 3, 0
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK 7, 4
+
+#define E56PHY_RXS_INTL_CONFIG_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x020)
+#define E56PHY_RXS_INTL_CONFIG_0_ADC_INTL2SLICE_DELAY1 31, 16
+
+#define E56PHY_RXS_INTL_CONFIG_2_ADDR   (E56PHY_RXS_BASE_ADDR + 0x028)
+#define E56PHY_RXS_INTL_CONFIG_2_INTERLEAVER_HBW_DISABLE1 1, 1
+
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x02C)
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH 18, 12
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH 26, 20
+
+#define E56PHY_RXS_TXFFE_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x030)
+#define E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH 8, 0
+#define E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH 20, 12
+
+#define E56PHY_RXS_TXFFE_TRAINING_2_ADDR   (E56PHY_RXS_BASE_ADDR + 0x034)
+#define E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH 8, 0
+#define E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH 20, 12
+
+#define E56PHY_RXS_TXFFE_TRAINING_3_ADDR   (E56PHY_RXS_BASE_ADDR + 0x038)
+#define E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH 8, 0
+#define E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH 20, 12
+#define E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE 26, 21
+
+#define E56PHY_RXS_VGA_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x04C)
+#define E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET 18, 12
+
+#define E56PHY_RXS_VGA_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x050)
+#define E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0 4, 0
+#define E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0 12, 8
+#define E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123 20, 16
+#define E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123 28, 24
+
+#define E56PHY_RXS_CTLE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x054)
+#define E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0 24, 20
+#define E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123 31, 27
+
+#define E56PHY_RXS_CTLE_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x058)
+#define E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT 24, 0
+
+#define E56PHY_RXS_CTLE_TRAINING_2_ADDR   (E56PHY_RXS_BASE_ADDR + 0x05C)
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1 5, 0
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2 13, 8
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3 21, 16
+
+#define E56PHY_RXS_CTLE_TRAINING_3_ADDR   (E56PHY_RXS_BASE_ADDR + 0x060)
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1 9, 8
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2 11, 10
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3 13, 12
+
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x064)
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT 5, 4
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT 9, 8
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8 31, 28
+
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x068)
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG 31, 28
+
+#define E56PHY_RXS_FFE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x070)
+#define E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN 23, 8
+
+#define E56PHY_RXS_IDLE_DETECT_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x088)
+#define E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX 22, 16
+#define E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN 30, 24
+
+#define E56PHY_RXS_ANA_OVRDEN_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x08C)
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I 0, 0
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_TRIM_RTERM_I 1, 1
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I 29, 29
+
+#define E56PHY_RXS_ANA_OVRDEN_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x090)
+#define E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I 0, 0
+#define E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I 9, 9
+
+#define E56PHY_RXS_ANA_OVRDEN_3_ADDR   (E56PHY_RXS_BASE_ADDR + 0x098)
+#define E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I 15, 15
+#define E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I 25, 25
+
+#define E56PHY_RXS_ANA_OVRDEN_4_ADDR   (E56PHY_RXS_BASE_ADDR + 0x09C)
+#define E56PHY_RXS_ANA_OVRDVAL_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0A0)
+#define E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I 0, 0
+
+#define E56PHY_RXS_ANA_OVRDVAL_6_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0B8)
+#define E56PHY_RXS_ANA_OVRDVAL_14_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0D8)
+#define E56PHY_RXS_ANA_OVRDVAL_15_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0DC)
+#define E56PHY_RXS_ANA_OVRDVAL_17_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0E4)
+#define E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I 18, 16
+
+#define E56PHY_RXS_EYE_SCAN_1_ADDR   (E56PHY_RXS_BASE_ADDR + 0x1A4)
+#define E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER 31, 0
+
+#define E56PHY_RXS_ANA_OVRDVAL_5_ADDR   (E56PHY_RXS_BASE_ADDR + 0x0B4)
+#define E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I 1, 0
+
+#define E56PHY_RXS_RINGO_0_ADDR   (E56PHY_RXS_BASE_ADDR + 0x1FC)
+
+#define E56PHY_PMD_BASE_ADDR  0x1400
+#define E56PHY_PMD_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x000)
+#define E56PHY_PMD_CFG_0_RX_EN_CFG 19, 16
+
+#define E56PHY_PMD_CFG_3_ADDR   (E56PHY_PMD_BASE_ADDR + 0x00C)
+#define E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K 31, 24
+#define E56PHY_PMD_CFG_4_ADDR   (E56PHY_PMD_BASE_ADDR + 0x010)
+#define E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K 7, 0
+#define E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K 15, 8
+#define E56PHY_PMD_CFG_5_ADDR   (E56PHY_PMD_BASE_ADDR + 0x014)
+#define E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET 12, 12
+#define E56PHY_CTRL_FSM_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x040)
+#define E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_OFST_CAL_ERR 4, 4
+#define E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR 5, 5
+#define E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL 9, 8
+#define E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN 31, 24
+
+#define E56PHY_CTRL_FSM_CFG_1_ADDR   (E56PHY_PMD_BASE_ADDR + 0x044)
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096 7, 0
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096 15, 8
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096 23, 16
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096 31, 24
+
+#define E56PHY_CTRL_FSM_CFG_2_ADDR   (E56PHY_PMD_BASE_ADDR + 0x048)
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096 7, 0
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096 15, 8
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096 23, 16
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096 31, 24
+
+#define E56PHY_CTRL_FSM_CFG_3_ADDR   (E56PHY_PMD_BASE_ADDR + 0x04C)
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096 7, 0
+
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096 15, 8
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096 23, 16
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096 31, 24
+
+#define E56PHY_CTRL_FSM_CFG_4_ADDR   (E56PHY_PMD_BASE_ADDR + 0x050)
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096 7, 0
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096 15, 8
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096 23, 16
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096 31, 24
+
+#define E56PHY_CTRL_FSM_CFG_7_ADDR   (E56PHY_PMD_BASE_ADDR + 0x05C)
+#define E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN 15, 0
+#define E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_8_ADDR   (E56PHY_PMD_BASE_ADDR + 0x060)
+#define E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_12_ADDR   (E56PHY_PMD_BASE_ADDR + 0x070)
+#define E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_13_ADDR   (E56PHY_PMD_BASE_ADDR + 0x074)
+#define E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN 15, 0
+#define E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_14_ADDR   (E56PHY_PMD_BASE_ADDR + 0x078)
+#define E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_15_ADDR   (E56PHY_PMD_BASE_ADDR + 0x07C)
+#define E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN 15, 0
+
+#define E56PHY_CTRL_FSM_CFG_17_ADDR   (E56PHY_PMD_BASE_ADDR + 0x084)
+#define E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN 15, 0
+
+#define E56PHY_CTRL_FSM_CFG_18_ADDR   (E56PHY_PMD_BASE_ADDR + 0x088)
+#define E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN 15, 0
+
+#define E56PHY_CTRL_FSM_CFG_29_ADDR   (E56PHY_PMD_BASE_ADDR + 0x0B4)
+#define E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_33_ADDR   (E56PHY_PMD_BASE_ADDR + 0x0C4)
+#define E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL 15, 0
+#define E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL 31, 16
+
+#define E56PHY_CTRL_FSM_CFG_34_ADDR   (E56PHY_PMD_BASE_ADDR + 0x0C8)
+#define E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL 15, 0
+#define E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL 31, 16
+
+#define E56PHY_CTRL_FSM_RX_STAT_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x0FC)
+#define E56PHY_RXS0_OVRDEN_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x130)
+#define E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O 27, 27
+
+#define E56PHY_RXS0_OVRDEN_1_ADDR   (E56PHY_PMD_BASE_ADDR + 0x134)
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I 14, 14
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I 16, 16
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CDR_EN_I 18, 18
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I 23, 23
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O 24, 24
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB 24
+
+#define E56PHY_RXS0_OVRDEN_2_ADDR   (E56PHY_PMD_BASE_ADDR + 0x138)
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I 0, 0
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I 3, 3
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I 6, 6
+
+#define E56PHY_RXS0_OVRDVAL_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x140)
+#define E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O 22, 22
+
+#define E56PHY_RXS0_OVRDVAL_1_ADDR   (E56PHY_PMD_BASE_ADDR + 0x144)
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I 7, 7
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I 9, 9
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CDR_EN_I 11, 11
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I 16, 16
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O 17, 17
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB 17
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I 25, 25
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I 28, 28
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I 31, 31
+
+#define E56PHY_INTR_0_IDLE_ENTRY1              0x10000000
+#define E56PHY_INTR_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x1EC)
+#define E56PHY_INTR_0_ENABLE_ADDR   (E56PHY_PMD_BASE_ADDR + 0x1E0)
+
+#define E56PHY_INTR_1_IDLE_EXIT1               0x1
+#define E56PHY_INTR_1_ADDR   (E56PHY_PMD_BASE_ADDR + 0x1F0)
+#define E56PHY_INTR_1_ENABLE_ADDR   (E56PHY_PMD_BASE_ADDR + 0x1E4)
+
+#define E56PHY_KRT_TFSM_CFG_ADDR   (E56PHY_PMD_BASE_ADDR + 0x2B8)
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K 7, 0
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K 15, 8
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K 23, 16
+
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR + 0x2BC)
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2 9, 8
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_3 13, 12
+
+#define PHYINIT_TIMEOUT 1000 //PHY initialization timeout value in 0.5ms unit
+
+#define E56G__BASEADDR 0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_vco_swing_ctrl_i : 4;
+		u32 ana_lcpll_lf_lpf_setcode_calib_i : 5;
+		u32 rsvd0 : 3;
+		u32 ana_lcpll_lf_vco_coarse_bin_i : 5;
+		u32 rsvd1 : 3;
+		u32 ana_lcpll_lf_vco_fine_therm_i : 8;
+		u32 ana_lcpll_lf_clkout_fb_ctrl_i : 2;
+		u32 rsvd2 : 2;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_7;
+#define E56G_CMS_ANA_OVRDVAL_7_ADDR                   (E56G__BASEADDR + 0xccc)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_lcpll_hf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_bias_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_loop_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_cp_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_base_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_fine_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_setcode_calib_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_set_lpf_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_vco_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_coarse_bin_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_fine_therm_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_test_bias_i : 1;
+		u32 ovrd_en_ana_test_slicer_i : 1;
+		u32 ovrd_en_ana_test_sampler_i : 1;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDEN_1;
+
+#define E56G_CMS_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR + 0xca8)
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_test_in_i : 32;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_9;
+
+#define E56G_CMS_ANA_OVRDVAL_9_ADDR                   (E56G__BASEADDR + 0xcd4)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_bbcdr_vcofilt_byp_i : 1;
+		u32 ovrd_en_ana_bbcdr_coarse_i : 1;
+		u32 ovrd_en_ana_bbcdr_fine_i : 1;
+		u32 ovrd_en_ana_bbcdr_ultrafine_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_i : 1;
+		u32 ovrd_en_ana_bbcdr_divctrl_i : 1;
+		u32 ovrd_en_ana_bbcdr_int_cstm_i : 1;
+		u32 ovrd_en_ana_bbcdr_prop_step_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_clk_i : 1;
+		u32 ovrd_en_ana_test_bbcdr_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_elv_cnt_ping_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_elv_cnt_pong_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_cnt_sync_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_elv_cnt_rd_i : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_270_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_270_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_270_o : 1;
+		u32 ovrd_en_ana_en_bbcdr_samp_dac_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac0_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac90_i : 1;
+		u32 ovrd_en_ana_vga2_cload_in_cstm_i : 1;
+		u32 ovrd_en_ana_intlvr_cut_bw_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_1;
+
+#define E56G__RXS0_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR + 0x90)
+
+typedef union {
+	struct {
+		u32 prediv0 : 16;
+		u32 target_cnt0 : 16;
+	};
+	u32 reg;
+} E56G_RXS0_OSC_CAL_N_CDR_0;
+
+#define E56G_RXS0_OSC_CAL_N_CDR_0_ADDR                  (E56G__BASEADDR + 0x4)
+
+typedef union {
+	struct {
+		u32 osc_range_sel0 : 2;
+		u32 osc_range_sel1 : 2;
+		u32 osc_range_sel2 : 2;
+		u32 osc_range_sel3 : 2;
+		u32 vco_code_init : 11;
+		u32 calibrate_range_sel : 1;
+		u32 osc_current_boost_en0 : 1;
+		u32 osc_current_boost_en1 : 1;
+		u32 osc_current_boost_en2 : 1;
+		u32 osc_current_boost_en3 : 1;
+		u32 bbcdr_current_boost0 : 2;
+		u32 bbcdr_current_boost1 : 2;
+		u32 bbcdr_current_boost2 : 2;
+		u32 bbcdr_current_boost3 : 2;
+	};
+	u32 reg;
+} E56G_RXS0_OSC_CAL_N_CDR_4;
+
+#define E56G_RXS0_OSC_CAL_N_CDR_4_ADDR                 (E56G__BASEADDR + 0x14)
+
+typedef union {
+	struct {
+		u32 adc_intl2slice_delay0 : 16;
+		u32 adc_intl2slice_delay1 : 16;
+	};
+	u32 reg;
+} E56G_RXS0_INTL_CONFIG_0;
+
+#define E56G_RXS0_INTL_CONFIG_0_ADDR                   (E56G__BASEADDR + 0x20)
+
+typedef union {
+	struct {
+		u32 interleaver_hbw_disable0 : 1;
+		u32 interleaver_hbw_disable1 : 1;
+		u32 interleaver_hbw_disable2 : 1;
+		u32 interleaver_hbw_disable3 : 1;
+		u32 rsvd0 : 28;
+	};
+	u32 reg;
+} E56G_RXS0_INTL_CONFIG_2;
+
+#define E56G_RXS0_INTL_CONFIG_2_ADDR                   (E56G__BASEADDR + 0x28)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_bbcdr_dac180_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac270_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_samp_cal_cnt_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_samp_cal_cnt_i : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_270_o : 1;
+		u32 ovrd_en_ana_en_adcbuf1_i : 1;
+		u32 ovrd_en_ana_test_adcbuf1_i : 1;
+		u32 ovrd_en_ana_en_adc_clk4ui_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew0_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew90_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew180_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew270_i : 1;
+		u32 ovrd_en_ana_adc_update_skew_i : 1;
+		u32 ovrd_en_ana_en_adc_pi_i : 1;
+		u32 ovrd_en_ana_adc_pictrl_quad_i : 1;
+		u32 ovrd_en_ana_adc_pctrl_code_i : 1;
+		u32 ovrd_en_ana_adc_clkdiv_i : 1;
+		u32 ovrd_en_ana_test_adc_clkgen_i : 1;
+		u32 ovrd_en_ana_en_adc_i : 1;
+		u32 ovrd_en_ana_en_adc_vref_i : 1;
+		u32 ovrd_en_ana_vref_cnfg_i : 1;
+		u32 ovrd_en_ana_adc_data_cstm_o : 1;
+		u32 ovrd_en_ana_en_adccal_lpbk_i : 1;
+		u32 ovrd_en_ana_sel_adcoffset_cal_i : 1;
+		u32 ovrd_en_ana_sel_adcgain_cal_i : 1;
+		u32 ovrd_en_ana_adcgain_cal_swing_ctrl_i : 1;
+		u32 ovrd_en_ana_adc_gain_i : 1;
+		u32 ovrd_en_ana_vga_cload_out_cstm_i : 1;
+		u32 ovrd_en_ana_vga2_cload_out_cstm_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_2;
+
+#define E56G__RXS0_ANA_OVRDEN_2_ADDR                    (E56G__BASEADDR + 0x94)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_adc_offset_i         : 1;
+		u32 ovrd_en_ana_adc_slice_addr_i     : 1;
+		u32 ovrd_en_ana_slice_wr_i           : 1;
+		u32 ovrd_en_ana_test_adc_i           : 1;
+		u32 ovrd_en_ana_test_adc_o           : 1;
+		u32 ovrd_en_ana_spare_o              : 8;
+		u32 ovrd_en_ana_sel_lpbk_i           : 1;
+		u32 ovrd_en_ana_ana_debug_sel_i      : 1;
+		u32 ovrd_en_ana_anabs_config_i       : 1;
+		u32 ovrd_en_ana_en_anabs_i           : 1;
+		u32 ovrd_en_ana_anabs_rxn_o          : 1;
+		u32 ovrd_en_ana_anabs_rxp_o          : 1;
+		u32 ovrd_en_ana_dser_clk_en_i        : 1;
+		u32 ovrd_en_ana_dser_clk_config_i    : 1;
+		u32 ovrd_en_ana_en_mmcdr_clk_obs_i   : 1;
+		u32 ovrd_en_ana_skew_coarse0_fine1_i : 1;
+		u32 ovrd_en_ana_vddinoff_acore_dig_o : 1;
+		u32 ovrd_en_ana_vddinoff_dcore_dig_o : 1;
+		u32 ovrd_en_ana_vga2_boost_cstm_i    : 1;
+		u32 ovrd_en_ana_adc_sel_vbgr_bias_i  : 1;
+		u32 ovrd_en_ana_adc_nbuf_cnfg_i      : 1;
+		u32 ovrd_en_ana_adc_pbuf_cnfg_i      : 1;
+		u32 rsvd0                            : 3;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_3;
+
+#define E56G__RXS0_ANA_OVRDEN_3_NUM                                         1
+#define E56G__RXS0_ANA_OVRDEN_3_ADDR                    (E56G__BASEADDR + 0x98)
+
+typedef union {
+	struct {
+		u32 pam4_ab_swap_en          : 1;
+		u32 dser_data_sel            : 1;
+		u32 signal_type              : 1;
+		u32 precode_en               : 1;
+		u32 train_clk_gate_bypass_en : 14;
+		u32 rsvd0                    : 14;
+	};
+	u32 reg;
+} E56G__RXS0_RXS_CFG_0;
+
+#define E56G__RXS0_RXS_CFG_0_NUM                                            1
+#define E56G__RXS0_RXS_CFG_0_ADDR                        (E56G__BASEADDR + 0x0)
+
+typedef union {
+	struct {
+		u32 restart_training_ln0 : 1;
+		u32 training_enable_ln0  : 1;
+		u32 restart_training_ln1 : 1;
+		u32 training_enable_ln1  : 1;
+		u32 restart_training_ln2 : 1;
+		u32 training_enable_ln2  : 1;
+		u32 restart_training_ln3 : 1;
+		u32 training_enable_ln3  : 1;
+		u32 rsvd0                : 24;
+	};
+	u32 reg;
+} E56G__PMD_BASER_PMD_CONTROL;
+
+#define E56G__PMD_BASER_PMD_CONTROL_NUM                                     1
+#define E56G__PMD_BASER_PMD_CONTROL_ADDR              (E56G__BASEADDR + 0x1640)
+
+typedef union {
+	struct {
+		u32 rx_to_tx_lpbk_en         : 4;
+		u32 sel_wp_pmt_out           : 4;
+		u32 sel_wp_pmt_clkout        : 4;
+		u32 use_recent_marker_offset : 1;
+		u32 interrupt_debug_mode     : 1;
+		u32 rsvd0                    : 2;
+		u32 tx_ffe_coeff_update      : 4;
+		u32 rsvd1                    : 12;
+	};
+	u32 reg;
+} E56G__PMD_PMD_CFG_5;
+
+#define E56G__PMD_PMD_CFG_5_NUM                                             1
+#define E56G__PMD_PMD_CFG_5_ADDR                      (E56G__BASEADDR + 0x1414)
+
+typedef union {
+	struct {
+		u32 soft_reset             : 1;
+		u32 pmd_en                 : 1;
+		u32 rsvd0                  : 2;
+		u32 pll_refclk_sel         : 2;
+		u32 rsvd1                  : 2;
+		u32 pmd_mode               : 1;
+		u32 rsvd2                  : 3;
+		u32 tx_en_cfg              : 4;
+		u32 rx_en_cfg              : 4;
+		u32 pll_en_cfg             : 2;
+		u32 rsvd3                  : 2;
+		u32 pam4_precode_no_krt_en : 4;
+		u32 rsvd4                  : 4;
+	};
+	u32 reg;
+} E56G__PMD_PMD_CFG_0;
+
+#define E56G__PMD_PMD_CFG_0_NUM                                             1
+#define E56G__PMD_PMD_CFG_0_ADDR                      (E56G__BASEADDR + 0x1400)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_rstn_i               : 1;
+		u32 ovrd_en_rxs0_rx0_bitclk_divctrl_i     : 1;
+		u32 ovrd_en_rxs0_rx0_bitclk_rate_i        : 1;
+		u32 ovrd_en_rxs0_rx0_symdata_width_i      : 1;
+		u32 ovrd_en_rxs0_rx0_symdata_o            : 1;
+		u32 ovrd_en_rxs0_rx0_precode_en_i         : 1;
+		u32 ovrd_en_rxs0_rx0_signal_type_i        : 1;
+		u32 ovrd_en_rxs0_rx0_sync_detect_en_i     : 1;
+		u32 ovrd_en_rxs0_rx0_sync_o               : 1;
+		u32 ovrd_en_rxs0_rx0_rate_select_i        : 1;
+		u32 ovrd_en_rxs0_rx0_rterm_en_i           : 1;
+		u32 ovrd_en_rxs0_rx0_bias_en_i            : 1;
+		u32 ovrd_en_rxs0_rx0_ldo_en_i             : 1;
+		u32 ovrd_en_rxs0_rx0_ldo_rdy_i            : 1;
+		u32 ovrd_en_rxs0_rx0_blwc_en_i            : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_en_i            : 1;
+		u32 ovrd_en_rxs0_rx0_vga_en_i             : 1;
+		u32 ovrd_en_rxs0_rx0_osc_sel_i            : 1;
+		u32 ovrd_en_rxs0_rx0_osc_en_i             : 1;
+		u32 ovrd_en_rxs0_rx0_clkgencdr_en_i       : 1;
+		u32 ovrd_en_rxs0_rx0_ctlecdr_en_i         : 1;
+		u32 ovrd_en_rxs0_rx0_samp_en_i            : 1;
+		u32 ovrd_en_rxs0_rx0_adc_en_i             : 1;
+		u32 ovrd_en_rxs0_rx0_osc_cal_en_i         : 1;
+		u32 ovrd_en_rxs0_rx0_osc_cal_done_o       : 1;
+		u32 ovrd_en_rxs0_rx0_osc_freq_error_o     : 1;
+		u32 ovrd_en_rxs0_rx0_samp_cal_en_i        : 1;
+		u32 ovrd_en_rxs0_rx0_samp_cal_done_o      : 1;
+		u32 ovrd_en_rxs0_rx0_samp_cal_err_o       : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_cal_en_i    : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_cal_done_o  : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_cal_error_o : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_0;
+
+#define E56G__PMD_RXS0_OVRDEN_0_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_0_ADDR                  (E56G__BASEADDR + 0x1530)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_sparein_i  : 8;
+		u32 ovrd_en_rxs0_rx0_spareout_o : 8;
+		u32 rsvd0                       : 16;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_3;
+
+#define E56G__PMD_RXS0_OVRDEN_3_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_3_ADDR                  (E56G__BASEADDR + 0x153c)
+
+typedef union {
+	struct {
+		u32 vco_code_cont_adj_done_ovrd_en : 1;
+		u32 dfe_coeffl_ovrd_en             : 1;
+		u32 dfe_coeffh_ovrd_en             : 1;
+		u32 rsvd0                          : 1;
+		u32 top_comp_th_ovrd_en            : 1;
+		u32 mid_comp_th_ovrd_en            : 1;
+		u32 bot_comp_th_ovrd_en            : 1;
+		u32 rsvd1                          : 1;
+		u32 level_target_ovrd_en           : 4;
+		u32 ffe_coeff_c0to3_ovrd_en        : 4;
+		u32 ffe_coeff_c4to7_ovrd_en        : 4;
+		u32 ffe_coeff_c8to11_ovrd_en       : 4;
+		u32 ffe_coeff_c12to15_ovrd_en      : 4;
+		u32 ffe_coeff_update_ovrd_en       : 1;
+		u32 rsvd2                          : 3;
+	};
+	u32 reg;
+} E56G__RXS0_DIG_OVRDEN_1;
+
+#define E56G__RXS0_DIG_OVRDEN_1_NUM                                         1
+#define E56G__RXS0_DIG_OVRDEN_1_ADDR                   (E56G__BASEADDR + 0x160)
+
+typedef union {
+	struct {
+		u32 ber_en                            : 1;
+		u32 rsvd0                             : 3;
+		u32 read_mode_en                      : 1;
+		u32 rsvd1                             : 3;
+		u32 err_cnt_mode_all0_one1            : 1;
+		u32 rsvd2                             : 3;
+		u32 init_lfsr_mode_continue0_restart1 : 1;
+		u32 rsvd3                             : 3;
+		u32 pattern_sel                       : 4;
+		u32 rsvd4                             : 12;
+	};
+	u32 reg;
+} E56G__RXS0_DFT_1;
+
+#define E56G__RXS0_DFT_1_NUM                                                1
+#define E56G__RXS0_DFT_1_ADDR                   (E56G__BASEADDR + 0xec)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_samp_th_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_samp_th_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_efuse_bits_i : 1;
+		u32 ovrd_en_rxs0_rx0_wp_pmt_in_i : 1;
+		u32 ovrd_en_rxs0_rx0_wp_pmt_out_o : 1;
+		u32 rsvd0 : 15;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_2;
+
+#define E56G__PMD_RXS0_OVRDEN_2_ADDR                  (E56G__BASEADDR + 0x1538)
+
+typedef union {
+	struct {
+		u32 ana_bbcdr_osc_range_sel_i : 2;
+		u32 rsvd0 : 2;
+		u32 ana_bbcdr_coarse_i : 4;
+		u32 ana_bbcdr_fine_i : 3;
+		u32 rsvd1 : 1;
+		u32 ana_bbcdr_ultrafine_i : 3;
+		u32 rsvd2 : 1;
+		u32 ana_bbcdr_divctrl_i : 2;
+		u32 rsvd3 : 2;
+		u32 ana_bbcdr_int_cstm_i : 5;
+		u32 rsvd4 : 3;
+		u32 ana_bbcdr_prop_step_i : 4;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_5;
+
+#define E56G__RXS0_ANA_OVRDVAL_5_ADDR                   (E56G__BASEADDR + 0xb4)
+
+typedef union {
+	struct {
+		u32 ana_adc_pictrl_quad_i : 2;
+		u32 rsvd0 : 2;
+		u32 ana_adc_clkdiv_i : 2;
+		u32 rsvd1 : 2;
+		u32 ana_test_adc_clkgen_i : 4;
+		u32 ana_vref_cnfg_i : 4;
+		u32 ana_adcgain_cal_swing_ctrl_i : 4;
+		u32 ana_adc_gain_i : 4;
+		u32 ana_adc_offset_i : 4;
+		u32 ana_ana_debug_sel_i : 4;
+	};
+	u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_11;
+
+#define E56G__RXS3_ANA_OVRDVAL_11_ADDR                 (E56G__BASEADDR + 0x6cc)
+
+typedef union {
+	struct {
+		u32 rxs0_rx0_fe_ofst_cal_error_o : 1;
+		u32 rxs0_rx0_fom_en_i : 1;
+		u32 rxs0_rx0_idle_detect_en_i : 1;
+		u32 rxs0_rx0_idle_o : 1;
+		u32 rxs0_rx0_txffe_train_en_i : 1;
+		u32 rxs0_rx0_txffe_train_enack_o : 1;
+		u32 rxs0_rx0_txffe_train_done_o : 1;
+		u32 rxs0_rx0_vga_train_en_i : 1;
+		u32 rxs0_rx0_vga_train_done_o : 1;
+		u32 rxs0_rx0_ctle_train_en_i : 1;
+		u32 rxs0_rx0_ctle_train_done_o : 1;
+		u32 rxs0_rx0_cdr_en_i : 1;
+		u32 rxs0_rx0_cdr_rdy_o : 1;
+		u32 rxs0_rx0_ffe_train_en_i : 1;
+		u32 rxs0_rx0_ffe_train_done_o : 1;
+		u32 rxs0_rx0_mmpd_en_i : 1;
+		u32 rxs0_rx0_adc_intl_cal_en_i : 1;
+		u32 rxs0_rx0_adc_intl_cal_done_o : 1;
+		u32 rxs0_rx0_adc_intl_cal_error_o : 1;
+		u32 rxs0_rx0_dfe_train_en_i : 1;
+		u32 rxs0_rx0_dfe_train_done_o : 1;
+		u32 rxs0_rx0_vga_adapt_en_i : 1;
+		u32 rxs0_rx0_vga_adapt_done_o : 1;
+		u32 rxs0_rx0_ctle_adapt_en_i : 1;
+		u32 rxs0_rx0_ctle_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_en_i : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_error_o : 1;
+		u32 rxs0_rx0_adc_gain_adapt_en_i : 1;
+		u32 rxs0_rx0_adc_gain_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_gain_adapt_error_o : 1;
+		u32 rxs0_rx0_adc_intl_adapt_en_i : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDVAL_1;
+#define E56G__PMD_RXS0_OVRDVAL_1_ADDR                 (E56G__BASEADDR + 0x1544)
+
+typedef union {
+	struct {
+		u32 rxs1_rx0_fe_ofst_cal_error_o    : 1;
+		u32 rxs1_rx0_fom_en_i               : 1;
+		u32 rxs1_rx0_idle_detect_en_i       : 1;
+		u32 rxs1_rx0_idle_o                 : 1;
+		u32 rxs1_rx0_txffe_train_en_i       : 1;
+		u32 rxs1_rx0_txffe_train_enack_o    : 1;
+		u32 rxs1_rx0_txffe_train_done_o     : 1;
+		u32 rxs1_rx0_vga_train_en_i         : 1;
+		u32 rxs1_rx0_vga_train_done_o       : 1;
+		u32 rxs1_rx0_ctle_train_en_i        : 1;
+		u32 rxs1_rx0_ctle_train_done_o      : 1;
+		u32 rxs1_rx0_cdr_en_i               : 1;
+		u32 rxs1_rx0_cdr_rdy_o              : 1;
+		u32 rxs1_rx0_ffe_train_en_i         : 1;
+		u32 rxs1_rx0_ffe_train_done_o       : 1;
+		u32 rxs1_rx0_mmpd_en_i              : 1;
+		u32 rxs1_rx0_adc_intl_cal_en_i      : 1;
+		u32 rxs1_rx0_adc_intl_cal_done_o    : 1;
+		u32 rxs1_rx0_adc_intl_cal_error_o   : 1;
+		u32 rxs1_rx0_dfe_train_en_i         : 1;
+		u32 rxs1_rx0_dfe_train_done_o       : 1;
+		u32 rxs1_rx0_vga_adapt_en_i         : 1;
+		u32 rxs1_rx0_vga_adapt_done_o       : 1;
+		u32 rxs1_rx0_ctle_adapt_en_i        : 1;
+		u32 rxs1_rx0_ctle_adapt_done_o      : 1;
+		u32 rxs1_rx0_adc_ofst_adapt_en_i    : 1;
+		u32 rxs1_rx0_adc_ofst_adapt_done_o  : 1;
+		u32 rxs1_rx0_adc_ofst_adapt_error_o : 1;
+		u32 rxs1_rx0_adc_gain_adapt_en_i    : 1;
+		u32 rxs1_rx0_adc_gain_adapt_done_o  : 1;
+		u32 rxs1_rx0_adc_gain_adapt_error_o : 1;
+		u32 rxs1_rx0_adc_intl_adapt_en_i    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS1_OVRDVAL_1;
+
+#define E56G__PMD_RXS1_OVRDVAL_1_ADDR                 (E56G__BASEADDR + 0x1570)
+
+typedef union {
+	struct {
+		u32 rxs2_rx0_fe_ofst_cal_error_o    : 1;
+		u32 rxs2_rx0_fom_en_i               : 1;
+		u32 rxs2_rx0_idle_detect_en_i       : 1;
+		u32 rxs2_rx0_idle_o                 : 1;
+		u32 rxs2_rx0_txffe_train_en_i       : 1;
+		u32 rxs2_rx0_txffe_train_enack_o    : 1;
+		u32 rxs2_rx0_txffe_train_done_o     : 1;
+		u32 rxs2_rx0_vga_train_en_i         : 1;
+		u32 rxs2_rx0_vga_train_done_o       : 1;
+		u32 rxs2_rx0_ctle_train_en_i        : 1;
+		u32 rxs2_rx0_ctle_train_done_o      : 1;
+		u32 rxs2_rx0_cdr_en_i               : 1;
+		u32 rxs2_rx0_cdr_rdy_o              : 1;
+		u32 rxs2_rx0_ffe_train_en_i         : 1;
+		u32 rxs2_rx0_ffe_train_done_o       : 1;
+		u32 rxs2_rx0_mmpd_en_i              : 1;
+		u32 rxs2_rx0_adc_intl_cal_en_i      : 1;
+		u32 rxs2_rx0_adc_intl_cal_done_o    : 1;
+		u32 rxs2_rx0_adc_intl_cal_error_o   : 1;
+		u32 rxs2_rx0_dfe_train_en_i         : 1;
+		u32 rxs2_rx0_dfe_train_done_o       : 1;
+		u32 rxs2_rx0_vga_adapt_en_i         : 1;
+		u32 rxs2_rx0_vga_adapt_done_o       : 1;
+		u32 rxs2_rx0_ctle_adapt_en_i        : 1;
+		u32 rxs2_rx0_ctle_adapt_done_o      : 1;
+		u32 rxs2_rx0_adc_ofst_adapt_en_i    : 1;
+		u32 rxs2_rx0_adc_ofst_adapt_done_o  : 1;
+		u32 rxs2_rx0_adc_ofst_adapt_error_o : 1;
+		u32 rxs2_rx0_adc_gain_adapt_en_i    : 1;
+		u32 rxs2_rx0_adc_gain_adapt_done_o  : 1;
+		u32 rxs2_rx0_adc_gain_adapt_error_o : 1;
+		u32 rxs2_rx0_adc_intl_adapt_en_i    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS2_OVRDVAL_1;
+
+#define E56G__PMD_RXS2_OVRDVAL_1_ADDR                 (E56G__BASEADDR + 0x159c)
+
+typedef union {
+	struct {
+		u32 rxs3_rx0_fe_ofst_cal_error_o    : 1;
+		u32 rxs3_rx0_fom_en_i               : 1;
+		u32 rxs3_rx0_idle_detect_en_i       : 1;
+		u32 rxs3_rx0_idle_o                 : 1;
+		u32 rxs3_rx0_txffe_train_en_i       : 1;
+		u32 rxs3_rx0_txffe_train_enack_o    : 1;
+		u32 rxs3_rx0_txffe_train_done_o     : 1;
+		u32 rxs3_rx0_vga_train_en_i         : 1;
+		u32 rxs3_rx0_vga_train_done_o       : 1;
+		u32 rxs3_rx0_ctle_train_en_i        : 1;
+		u32 rxs3_rx0_ctle_train_done_o      : 1;
+		u32 rxs3_rx0_cdr_en_i               : 1;
+		u32 rxs3_rx0_cdr_rdy_o              : 1;
+		u32 rxs3_rx0_ffe_train_en_i         : 1;
+		u32 rxs3_rx0_ffe_train_done_o       : 1;
+		u32 rxs3_rx0_mmpd_en_i              : 1;
+		u32 rxs3_rx0_adc_intl_cal_en_i      : 1;
+		u32 rxs3_rx0_adc_intl_cal_done_o    : 1;
+		u32 rxs3_rx0_adc_intl_cal_error_o   : 1;
+		u32 rxs3_rx0_dfe_train_en_i         : 1;
+		u32 rxs3_rx0_dfe_train_done_o       : 1;
+		u32 rxs3_rx0_vga_adapt_en_i         : 1;
+		u32 rxs3_rx0_vga_adapt_done_o       : 1;
+		u32 rxs3_rx0_ctle_adapt_en_i        : 1;
+		u32 rxs3_rx0_ctle_adapt_done_o      : 1;
+		u32 rxs3_rx0_adc_ofst_adapt_en_i    : 1;
+		u32 rxs3_rx0_adc_ofst_adapt_done_o  : 1;
+		u32 rxs3_rx0_adc_ofst_adapt_error_o : 1;
+		u32 rxs3_rx0_adc_gain_adapt_en_i    : 1;
+		u32 rxs3_rx0_adc_gain_adapt_done_o  : 1;
+		u32 rxs3_rx0_adc_gain_adapt_error_o : 1;
+		u32 rxs3_rx0_adc_intl_adapt_en_i    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS3_OVRDVAL_1;
+
+#define E56G__PMD_RXS3_OVRDVAL_1_ADDR                 (E56G__BASEADDR + 0x15c8)
+
+typedef union {
+	struct {
+		u32 ctrl_fsm_rx0_st : 6;
+		u32 rsvd0 : 2;
+		u32 ctrl_fsm_rx1_st : 6;
+		u32 rsvd1 : 2;
+		u32 ctrl_fsm_rx2_st : 6;
+		u32 rsvd2 : 2;
+		u32 ctrl_fsm_rx3_st : 6;
+		u32 rsvd3 : 2;
+	};
+	u32 reg;
+} E56G__PMD_CTRL_FSM_RX_STAT_0;
+
+#define E56G__PMD_CTRL_FSM_RX_STAT_0_ADDR             (E56G__BASEADDR + 0x14fc)
+
+typedef union {
+	struct {
+		u32 ana_en_rterm_i : 1;
+		u32 ana_en_bias_i : 1;
+		u32 ana_en_ldo_i : 1;
+		u32 ana_rstn_i : 1;
+		u32 ana_en_blwc_i : 1;
+		u32 ana_en_acc_amp_i : 1;
+		u32 ana_en_acc_dac_i : 1;
+		u32 ana_en_afe_offset_cal_i : 1;
+		u32 ana_clk_offsetcal_i : 1;
+		u32 ana_acc_os_comp_o : 1;
+		u32 ana_en_ctle_i : 1;
+		u32 ana_ctle_bypass_i : 1;
+		u32 ana_en_ctlecdr_i : 1;
+		u32 ana_cdr_ctle_boost_i : 1;
+		u32 ana_en_vga_i : 1;
+		u32 ana_en_bbcdr_vco_i : 1;
+		u32 ana_bbcdr_vcofilt_byp_i : 1;
+		u32 ana_en_bbcdr_i : 1;
+		u32 ana_en_bbcdr_clk_i : 1;
+		u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_ping_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_pong_i : 1;
+		u32 ana_bbcdr_clrz_cnt_sync_i : 1;
+		u32 ana_bbcdr_en_elv_cnt_rd_i : 1;
+		u32 ana_bbcdr_elv_cnt_ping_0_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_90_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_180_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_270_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_0_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_90_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_180_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_270_o : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_0;
+#define E56G__RXS0_ANA_OVRDVAL_0_ADDR                   (E56G__BASEADDR + 0xa0)
+
+typedef union {
+	struct {
+		u32 ana_en_rterm_i                     : 1;
+		u32 ana_en_bias_i                      : 1;
+		u32 ana_en_ldo_i                       : 1;
+		u32 ana_rstn_i                         : 1;
+		u32 ana_en_blwc_i                      : 1;
+		u32 ana_en_acc_amp_i                   : 1;
+		u32 ana_en_acc_dac_i                   : 1;
+		u32 ana_en_afe_offset_cal_i            : 1;
+		u32 ana_clk_offsetcal_i                : 1;
+		u32 ana_acc_os_comp_o                  : 1;
+		u32 ana_en_ctle_i                      : 1;
+		u32 ana_ctle_bypass_i                  : 1;
+		u32 ana_en_ctlecdr_i                   : 1;
+		u32 ana_cdr_ctle_boost_i               : 1;
+		u32 ana_en_vga_i                       : 1;
+		u32 ana_en_bbcdr_vco_i                 : 1;
+		u32 ana_bbcdr_vcofilt_byp_i            : 1;
+		u32 ana_en_bbcdr_i                     : 1;
+		u32 ana_en_bbcdr_clk_i                 : 1;
+		u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+		u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+		u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+		u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+	};
+	u32 reg;
+} E56G__RXS1_ANA_OVRDVAL_0;
+
+#define E56G__RXS1_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR + 0x2a0)
+
+typedef union {
+	struct {
+		u32 ana_en_rterm_i                     : 1;
+		u32 ana_en_bias_i                      : 1;
+		u32 ana_en_ldo_i                       : 1;
+		u32 ana_rstn_i                         : 1;
+		u32 ana_en_blwc_i                      : 1;
+		u32 ana_en_acc_amp_i                   : 1;
+		u32 ana_en_acc_dac_i                   : 1;
+		u32 ana_en_afe_offset_cal_i            : 1;
+		u32 ana_clk_offsetcal_i                : 1;
+		u32 ana_acc_os_comp_o                  : 1;
+		u32 ana_en_ctle_i                      : 1;
+		u32 ana_ctle_bypass_i                  : 1;
+		u32 ana_en_ctlecdr_i                   : 1;
+		u32 ana_cdr_ctle_boost_i               : 1;
+		u32 ana_en_vga_i                       : 1;
+		u32 ana_en_bbcdr_vco_i                 : 1;
+		u32 ana_bbcdr_vcofilt_byp_i            : 1;
+		u32 ana_en_bbcdr_i                     : 1;
+		u32 ana_en_bbcdr_clk_i                 : 1;
+		u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+		u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+		u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+		u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+	};
+	u32 reg;
+} E56G__RXS2_ANA_OVRDVAL_0;
+
+#define E56G__RXS2_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR + 0x4a0)
+
+typedef union {
+	struct {
+		u32 ana_en_rterm_i                     : 1;
+		u32 ana_en_bias_i                      : 1;
+		u32 ana_en_ldo_i                       : 1;
+		u32 ana_rstn_i                         : 1;
+		u32 ana_en_blwc_i                      : 1;
+		u32 ana_en_acc_amp_i                   : 1;
+		u32 ana_en_acc_dac_i                   : 1;
+		u32 ana_en_afe_offset_cal_i            : 1;
+		u32 ana_clk_offsetcal_i                : 1;
+		u32 ana_acc_os_comp_o                  : 1;
+		u32 ana_en_ctle_i                      : 1;
+		u32 ana_ctle_bypass_i                  : 1;
+		u32 ana_en_ctlecdr_i                   : 1;
+		u32 ana_cdr_ctle_boost_i               : 1;
+		u32 ana_en_vga_i                       : 1;
+		u32 ana_en_bbcdr_vco_i                 : 1;
+		u32 ana_bbcdr_vcofilt_byp_i            : 1;
+		u32 ana_en_bbcdr_i                     : 1;
+		u32 ana_en_bbcdr_clk_i                 : 1;
+		u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+		u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+		u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+		u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+		u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+		u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+		u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+	};
+	u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_0;
+
+#define E56G__RXS3_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR + 0x6a0)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_en_rterm_i : 1;
+		u32 ovrd_en_ana_trim_rterm_i : 1;
+		u32 ovrd_en_ana_en_bias_i : 1;
+		u32 ovrd_en_ana_test_bias_i : 1;
+		u32 ovrd_en_ana_en_ldo_i : 1;
+		u32 ovrd_en_ana_test_ldo_i : 1;
+		u32 ovrd_en_ana_rstn_i : 1;
+		u32 ovrd_en_ana_en_blwc_i : 1;
+		u32 ovrd_en_ana_en_acc_amp_i : 1;
+		u32 ovrd_en_ana_en_acc_dac_i : 1;
+		u32 ovrd_en_ana_en_afe_offset_cal_i : 1;
+		u32 ovrd_en_ana_clk_offsetcal_i : 1;
+		u32 ovrd_en_ana_acc_os_code_i : 1;
+		u32 ovrd_en_ana_acc_os_comp_o : 1;
+		u32 ovrd_en_ana_test_acc_i : 1;
+		u32 ovrd_en_ana_en_ctle_i : 1;
+		u32 ovrd_en_ana_ctle_bypass_i : 1;
+		u32 ovrd_en_ana_ctle_cz_cstm_i : 1;
+		u32 ovrd_en_ana_ctle_cload_cstm_i : 1;
+		u32 ovrd_en_ana_test_ctle_i : 1;
+		u32 ovrd_en_ana_lfeq_ctrl_cstm_i : 1;
+		u32 ovrd_en_ana_en_ctlecdr_i : 1;
+		u32 ovrd_en_ana_cdr_ctle_boost_i : 1;
+		u32 ovrd_en_ana_test_ctlecdr_i : 1;
+		u32 ovrd_en_ana_en_vga_i : 1;
+		u32 ovrd_en_ana_vga_gain_cstm_i : 1;
+		u32 ovrd_en_ana_vga_cload_in_cstm_i : 1;
+		u32 ovrd_en_ana_test_vga_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_vco_i : 1;
+		u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+		u32 ovrd_en_ana_sel_vga_gain_byp_i : 1;
+		u32 ovrd_en_ana_vga2_gain_cstm_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_0;
+
+#define E56G__RXS0_ANA_OVRDEN_0_ADDR                    (E56G__BASEADDR + 0x8c)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_en_rterm_i            : 1;
+		u32 ovrd_en_ana_trim_rterm_i          : 1;
+		u32 ovrd_en_ana_en_bias_i             : 1;
+		u32 ovrd_en_ana_test_bias_i           : 1;
+		u32 ovrd_en_ana_en_ldo_i              : 1;
+		u32 ovrd_en_ana_test_ldo_i            : 1;
+		u32 ovrd_en_ana_rstn_i                : 1;
+		u32 ovrd_en_ana_en_blwc_i             : 1;
+		u32 ovrd_en_ana_en_acc_amp_i          : 1;
+		u32 ovrd_en_ana_en_acc_dac_i          : 1;
+		u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+		u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+		u32 ovrd_en_ana_acc_os_code_i         : 1;
+		u32 ovrd_en_ana_acc_os_comp_o         : 1;
+		u32 ovrd_en_ana_test_acc_i            : 1;
+		u32 ovrd_en_ana_en_ctle_i             : 1;
+		u32 ovrd_en_ana_ctle_bypass_i         : 1;
+		u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+		u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+		u32 ovrd_en_ana_test_ctle_i           : 1;
+		u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+		u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+		u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+		u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+		u32 ovrd_en_ana_en_vga_i              : 1;
+		u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+		u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+		u32 ovrd_en_ana_test_vga_i            : 1;
+		u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+		u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+		u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+		u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+	};
+	u32 reg;
+} E56G__RXS1_ANA_OVRDEN_0;
+
+#define E56G__RXS1_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR + 0x28c)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_en_rterm_i            : 1;
+		u32 ovrd_en_ana_trim_rterm_i          : 1;
+		u32 ovrd_en_ana_en_bias_i             : 1;
+		u32 ovrd_en_ana_test_bias_i           : 1;
+		u32 ovrd_en_ana_en_ldo_i              : 1;
+		u32 ovrd_en_ana_test_ldo_i            : 1;
+		u32 ovrd_en_ana_rstn_i                : 1;
+		u32 ovrd_en_ana_en_blwc_i             : 1;
+		u32 ovrd_en_ana_en_acc_amp_i          : 1;
+		u32 ovrd_en_ana_en_acc_dac_i          : 1;
+		u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+		u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+		u32 ovrd_en_ana_acc_os_code_i         : 1;
+		u32 ovrd_en_ana_acc_os_comp_o         : 1;
+		u32 ovrd_en_ana_test_acc_i            : 1;
+		u32 ovrd_en_ana_en_ctle_i             : 1;
+		u32 ovrd_en_ana_ctle_bypass_i         : 1;
+		u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+		u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+		u32 ovrd_en_ana_test_ctle_i           : 1;
+		u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+		u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+		u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+		u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+		u32 ovrd_en_ana_en_vga_i              : 1;
+		u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+		u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+		u32 ovrd_en_ana_test_vga_i            : 1;
+		u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+		u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+		u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+		u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+	};
+	u32 reg;
+} E56G__RXS2_ANA_OVRDEN_0;
+
+#define E56G__RXS2_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR + 0x48c)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_en_rterm_i            : 1;
+		u32 ovrd_en_ana_trim_rterm_i          : 1;
+		u32 ovrd_en_ana_en_bias_i             : 1;
+		u32 ovrd_en_ana_test_bias_i           : 1;
+		u32 ovrd_en_ana_en_ldo_i              : 1;
+		u32 ovrd_en_ana_test_ldo_i            : 1;
+		u32 ovrd_en_ana_rstn_i                : 1;
+		u32 ovrd_en_ana_en_blwc_i             : 1;
+		u32 ovrd_en_ana_en_acc_amp_i          : 1;
+		u32 ovrd_en_ana_en_acc_dac_i          : 1;
+		u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+		u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+		u32 ovrd_en_ana_acc_os_code_i         : 1;
+		u32 ovrd_en_ana_acc_os_comp_o         : 1;
+		u32 ovrd_en_ana_test_acc_i            : 1;
+		u32 ovrd_en_ana_en_ctle_i             : 1;
+		u32 ovrd_en_ana_ctle_bypass_i         : 1;
+		u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+		u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+		u32 ovrd_en_ana_test_ctle_i           : 1;
+		u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+		u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+		u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+		u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+		u32 ovrd_en_ana_en_vga_i              : 1;
+		u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+		u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+		u32 ovrd_en_ana_test_vga_i            : 1;
+		u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+		u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+		u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+		u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+	};
+	u32 reg;
+} E56G__RXS3_ANA_OVRDEN_0;
+
+#define E56G__RXS3_ANA_OVRDEN_0_NUM                                         1
+#define E56G__RXS3_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR + 0x68c)
+
+typedef union {
+	struct {
+		u32 ana_ctle_cz_cstm_i : 5;
+		u32 rsvd0 : 3;
+		u32 ana_ctle_cload_cstm_i : 5;
+		u32 rsvd1 : 3;
+		u32 ana_test_ctle_i : 2;
+		u32 rsvd2 : 2;
+		u32 ana_lfeq_ctrl_cstm_i : 4;
+		u32 ana_test_ctlecdr_i : 2;
+		u32 rsvd3 : 2;
+		u32 ana_vga_cload_in_cstm_i : 3;
+		u32 rsvd4 : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_3;
+
+#define E56G__RXS0_ANA_OVRDVAL_3_NUM                                        1
+#define E56G__RXS0_ANA_OVRDVAL_3_ADDR                   (E56G__BASEADDR + 0xac)
+
+typedef union {
+	struct {
+		u32 ana_ctle_cz_cstm_i      : 5;
+		u32 rsvd0                   : 3;
+		u32 ana_ctle_cload_cstm_i   : 5;
+		u32 rsvd1                   : 3;
+		u32 ana_test_ctle_i         : 2;
+		u32 rsvd2                   : 2;
+		u32 ana_lfeq_ctrl_cstm_i    : 4;
+		u32 ana_test_ctlecdr_i      : 2;
+		u32 rsvd3                   : 2;
+		u32 ana_vga_cload_in_cstm_i : 3;
+		u32 rsvd4                   : 1;
+	};
+	u32 reg;
+} E56G__RXS1_ANA_OVRDVAL_3;
+
+#define E56G__RXS1_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR + 0x2ac)
+
+typedef union {
+	struct {
+		u32 ana_ctle_cz_cstm_i      : 5;
+		u32 rsvd0                   : 3;
+		u32 ana_ctle_cload_cstm_i   : 5;
+		u32 rsvd1                   : 3;
+		u32 ana_test_ctle_i         : 2;
+		u32 rsvd2                   : 2;
+		u32 ana_lfeq_ctrl_cstm_i    : 4;
+		u32 ana_test_ctlecdr_i      : 2;
+		u32 rsvd3                   : 2;
+		u32 ana_vga_cload_in_cstm_i : 3;
+		u32 rsvd4                   : 1;
+	};
+	u32 reg;
+} E56G__RXS2_ANA_OVRDVAL_3;
+
+#define E56G__RXS2_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR + 0x4ac)
+
+typedef union {
+	struct {
+		u32 ana_ctle_cz_cstm_i      : 5;
+		u32 rsvd0                   : 3;
+		u32 ana_ctle_cload_cstm_i   : 5;
+		u32 rsvd1                   : 3;
+		u32 ana_test_ctle_i         : 2;
+		u32 rsvd2                   : 2;
+		u32 ana_lfeq_ctrl_cstm_i    : 4;
+		u32 ana_test_ctlecdr_i      : 2;
+		u32 rsvd3                   : 2;
+		u32 ana_vga_cload_in_cstm_i : 3;
+		u32 rsvd4                   : 1;
+	};
+	u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_3;
+
+#define E56G__RXS3_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR + 0x6ac)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fom_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_idle_detect_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_idle_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_coeff_rst_i : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_enack_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_coeff_change_o : 1;
+		u32 ovrd_en_rxs0_rx0_vga_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_vga_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_cdr_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_cdr_rdy_o : 1;
+		u32 ovrd_en_rxs0_rx0_ffe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ffe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_mmpd_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_dfe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_dfe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_vga_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_vga_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_adapt_done_o : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_1;
+
+#define E56G__PMD_RXS0_OVRDEN_1_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_1_ADDR                  (E56G__BASEADDR + 0x1534)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs1_rx0_adc_gain_cal_en_i    : 1;
+		u32 ovrd_en_rxs1_rx0_adc_gain_cal_done_o  : 1;
+		u32 ovrd_en_rxs1_rx0_adc_gain_cal_error_o : 1;
+		u32 ovrd_en_rxs1_rx0_fe_ofst_cal_en_i     : 1;
+		u32 ovrd_en_rxs1_rx0_fe_ofst_cal_done_o   : 1;
+		u32 ovrd_en_rxs1_rx0_fe_ofst_cal_error_o  : 1;
+		u32 ovrd_en_rxs1_rx0_fom_en_i             : 1;
+		u32 ovrd_en_rxs1_rx0_idle_detect_en_i     : 1;
+		u32 ovrd_en_rxs1_rx0_idle_o               : 1;
+		u32 ovrd_en_rxs1_rx0_txffe_train_en_i     : 1;
+		u32 ovrd_en_rxs1_rx0_txffe_coeff_rst_i    : 1;
+		u32 ovrd_en_rxs1_rx0_txffe_train_enack_o  : 1;
+		u32 ovrd_en_rxs1_rx0_txffe_train_done_o   : 1;
+		u32 ovrd_en_rxs1_rx0_txffe_coeff_change_o : 1;
+		u32 ovrd_en_rxs1_rx0_vga_train_en_i       : 1;
+		u32 ovrd_en_rxs1_rx0_vga_train_done_o     : 1;
+		u32 ovrd_en_rxs1_rx0_ctle_train_en_i      : 1;
+		u32 ovrd_en_rxs1_rx0_ctle_train_done_o    : 1;
+		u32 ovrd_en_rxs1_rx0_cdr_en_i             : 1;
+		u32 ovrd_en_rxs1_rx0_cdr_rdy_o            : 1;
+		u32 ovrd_en_rxs1_rx0_ffe_train_en_i       : 1;
+		u32 ovrd_en_rxs1_rx0_ffe_train_done_o     : 1;
+		u32 ovrd_en_rxs1_rx0_mmpd_en_i            : 1;
+		u32 ovrd_en_rxs1_rx0_adc_intl_cal_en_i    : 1;
+		u32 ovrd_en_rxs1_rx0_adc_intl_cal_done_o  : 1;
+		u32 ovrd_en_rxs1_rx0_adc_intl_cal_error_o : 1;
+		u32 ovrd_en_rxs1_rx0_dfe_train_en_i       : 1;
+		u32 ovrd_en_rxs1_rx0_dfe_train_done_o     : 1;
+		u32 ovrd_en_rxs1_rx0_vga_adapt_en_i       : 1;
+		u32 ovrd_en_rxs1_rx0_vga_adapt_done_o     : 1;
+		u32 ovrd_en_rxs1_rx0_ctle_adapt_en_i      : 1;
+		u32 ovrd_en_rxs1_rx0_ctle_adapt_done_o    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS1_OVRDEN_1;
+
+#define E56G__PMD_RXS1_OVRDEN_1_ADDR                  (E56G__BASEADDR + 0x1560)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs2_rx0_adc_gain_cal_en_i    : 1;
+		u32 ovrd_en_rxs2_rx0_adc_gain_cal_done_o  : 1;
+		u32 ovrd_en_rxs2_rx0_adc_gain_cal_error_o : 1;
+		u32 ovrd_en_rxs2_rx0_fe_ofst_cal_en_i     : 1;
+		u32 ovrd_en_rxs2_rx0_fe_ofst_cal_done_o   : 1;
+		u32 ovrd_en_rxs2_rx0_fe_ofst_cal_error_o  : 1;
+		u32 ovrd_en_rxs2_rx0_fom_en_i             : 1;
+		u32 ovrd_en_rxs2_rx0_idle_detect_en_i     : 1;
+		u32 ovrd_en_rxs2_rx0_idle_o               : 1;
+		u32 ovrd_en_rxs2_rx0_txffe_train_en_i     : 1;
+		u32 ovrd_en_rxs2_rx0_txffe_coeff_rst_i    : 1;
+		u32 ovrd_en_rxs2_rx0_txffe_train_enack_o  : 1;
+		u32 ovrd_en_rxs2_rx0_txffe_train_done_o   : 1;
+		u32 ovrd_en_rxs2_rx0_txffe_coeff_change_o : 1;
+		u32 ovrd_en_rxs2_rx0_vga_train_en_i       : 1;
+		u32 ovrd_en_rxs2_rx0_vga_train_done_o     : 1;
+		u32 ovrd_en_rxs2_rx0_ctle_train_en_i      : 1;
+		u32 ovrd_en_rxs2_rx0_ctle_train_done_o    : 1;
+		u32 ovrd_en_rxs2_rx0_cdr_en_i             : 1;
+		u32 ovrd_en_rxs2_rx0_cdr_rdy_o            : 1;
+		u32 ovrd_en_rxs2_rx0_ffe_train_en_i       : 1;
+		u32 ovrd_en_rxs2_rx0_ffe_train_done_o     : 1;
+		u32 ovrd_en_rxs2_rx0_mmpd_en_i            : 1;
+		u32 ovrd_en_rxs2_rx0_adc_intl_cal_en_i    : 1;
+		u32 ovrd_en_rxs2_rx0_adc_intl_cal_done_o  : 1;
+		u32 ovrd_en_rxs2_rx0_adc_intl_cal_error_o : 1;
+		u32 ovrd_en_rxs2_rx0_dfe_train_en_i       : 1;
+		u32 ovrd_en_rxs2_rx0_dfe_train_done_o     : 1;
+		u32 ovrd_en_rxs2_rx0_vga_adapt_en_i       : 1;
+		u32 ovrd_en_rxs2_rx0_vga_adapt_done_o     : 1;
+		u32 ovrd_en_rxs2_rx0_ctle_adapt_en_i      : 1;
+		u32 ovrd_en_rxs2_rx0_ctle_adapt_done_o    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS2_OVRDEN_1;
+
+#define E56G__PMD_RXS2_OVRDEN_1_ADDR                  (E56G__BASEADDR + 0x158c)
+
+typedef union {
+	struct {
+		u32 ovrd_en_rxs3_rx0_adc_gain_cal_en_i    : 1;
+		u32 ovrd_en_rxs3_rx0_adc_gain_cal_done_o  : 1;
+		u32 ovrd_en_rxs3_rx0_adc_gain_cal_error_o : 1;
+		u32 ovrd_en_rxs3_rx0_fe_ofst_cal_en_i     : 1;
+		u32 ovrd_en_rxs3_rx0_fe_ofst_cal_done_o   : 1;
+		u32 ovrd_en_rxs3_rx0_fe_ofst_cal_error_o  : 1;
+		u32 ovrd_en_rxs3_rx0_fom_en_i             : 1;
+		u32 ovrd_en_rxs3_rx0_idle_detect_en_i     : 1;
+		u32 ovrd_en_rxs3_rx0_idle_o               : 1;
+		u32 ovrd_en_rxs3_rx0_txffe_train_en_i     : 1;
+		u32 ovrd_en_rxs3_rx0_txffe_coeff_rst_i    : 1;
+		u32 ovrd_en_rxs3_rx0_txffe_train_enack_o  : 1;
+		u32 ovrd_en_rxs3_rx0_txffe_train_done_o   : 1;
+		u32 ovrd_en_rxs3_rx0_txffe_coeff_change_o : 1;
+		u32 ovrd_en_rxs3_rx0_vga_train_en_i       : 1;
+		u32 ovrd_en_rxs3_rx0_vga_train_done_o     : 1;
+		u32 ovrd_en_rxs3_rx0_ctle_train_en_i      : 1;
+		u32 ovrd_en_rxs3_rx0_ctle_train_done_o    : 1;
+		u32 ovrd_en_rxs3_rx0_cdr_en_i             : 1;
+		u32 ovrd_en_rxs3_rx0_cdr_rdy_o            : 1;
+		u32 ovrd_en_rxs3_rx0_ffe_train_en_i       : 1;
+		u32 ovrd_en_rxs3_rx0_ffe_train_done_o     : 1;
+		u32 ovrd_en_rxs3_rx0_mmpd_en_i            : 1;
+		u32 ovrd_en_rxs3_rx0_adc_intl_cal_en_i    : 1;
+		u32 ovrd_en_rxs3_rx0_adc_intl_cal_done_o  : 1;
+		u32 ovrd_en_rxs3_rx0_adc_intl_cal_error_o : 1;
+		u32 ovrd_en_rxs3_rx0_dfe_train_en_i       : 1;
+		u32 ovrd_en_rxs3_rx0_dfe_train_done_o     : 1;
+		u32 ovrd_en_rxs3_rx0_vga_adapt_en_i       : 1;
+		u32 ovrd_en_rxs3_rx0_vga_adapt_done_o     : 1;
+		u32 ovrd_en_rxs3_rx0_ctle_adapt_en_i      : 1;
+		u32 ovrd_en_rxs3_rx0_ctle_adapt_done_o    : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS3_OVRDEN_1;
+
+#define E56G__PMD_RXS3_OVRDEN_1_ADDR                  (E56G__BASEADDR + 0x15b8)
+
+#define E56G__RXS0_FOM_18__ADDR                       (E56G__BASEADDR + 0x1f8)
+#define E56G__RXS0_FOM_18__DFE_COEFFL_HINT__MSB                             11
+#define E56G__RXS0_FOM_18__DFE_COEFFL_HINT__LSB                              0
+#define E56G__RXS0_FOM_18__DFE_COEFFH_HINT__MSB                             23
+#define E56G__RXS0_FOM_18__DFE_COEFFH_HINT__LSB                             12
+#define E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__MSB                         25
+#define E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__LSB                         25
+
+#define DEFAULT_TEMP                            40
+#define HIGH_TEMP                               70
+
+#define E56PHY_RX_RDY_ST    0x1B
+
+#define S10G_CMVAR_RANGE_H          0x3
+#define S10G_CMVAR_RANGE_L          0x2
+#define S25G_CMVAR_RANGE_H          0x1
+#define S25G_CMVAR_RANGE_L          0x0
+
+#define S25G_CMVAR_RANGE_H          0x1
+#define S25G_CMVAR_RANGE_L          0x0
+#define S25G_CMVAR_SEC_LOW_TH       0x1A
+#define S25G_CMVAR_SEC_HIGH_TH      0x1D
+#define S25G_CMVAR_UFINE_MAX        0x2
+#define S25G_CMVAR_FINE_MAX         0x7
+#define S25G_CMVAR_COARSE_MAX       0xF
+#define S25G_CMVAR_UFINE_UMAX_WRAP  0x0
+#define S25G_CMVAR_UFINE_FMAX_WRAP  0x0
+#define S25G_CMVAR_FINE_FMAX_WRAP   0x2
+#define S25G_CMVAR_UFINE_MIN        0x0
+#define S25G_CMVAR_FINE_MIN         0x0
+#define S25G_CMVAR_COARSE_MIN       0x1
+#define S25G_CMVAR_UFINE_UMIN_WRAP  0x2
+#define S25G_CMVAR_UFINE_FMIN_WRAP  0x2
+#define S25G_CMVAR_FINE_FMIN_WRAP   0x5
+
+#define S10G_CMVAR_RANGE_H          0x3
+#define S10G_CMVAR_RANGE_L          0x2
+#define S10G_CMVAR_SEC_LOW_TH       0x1A
+#define S10G_CMVAR_SEC_HIGH_TH      0x1D
+#define S10G_CMVAR_UFINE_MAX        0x7
+#define S10G_CMVAR_FINE_MAX         0x7
+#define S10G_CMVAR_COARSE_MAX       0xF
+#define S10G_CMVAR_UFINE_UMAX_WRAP  0x6
+#define S10G_CMVAR_UFINE_FMAX_WRAP  0x7
+#define S10G_CMVAR_FINE_FMAX_WRAP   0x1
+#define S10G_CMVAR_UFINE_MIN        0x0
+#define S10G_CMVAR_FINE_MIN         0x0
+#define S10G_CMVAR_COARSE_MIN       0x1
+#define S10G_CMVAR_UFINE_UMIN_WRAP  0x2
+#define S10G_CMVAR_UFINE_FMIN_WRAP  0x2
+#define S10G_CMVAR_FINE_FMIN_WRAP   0x5
+
+#define S10G_TX_FFE_CFG_MAIN        0x2c2c2c2c
+#define S10G_TX_FFE_CFG_PRE1        0x0
+#define S10G_TX_FFE_CFG_PRE2        0x0
+#define S10G_TX_FFE_CFG_POST        0x06060606
+#define S25G_TX_FFE_CFG_MAIN        0x31
+#define S25G_TX_FFE_CFG_PRE1        0x4
+#define S25G_TX_FFE_CFG_PRE2        0x1
+#define S25G_TX_FFE_CFG_POST        0x9
+
+#define S25G_TX_FFE_CFG_DAC_MAIN    0x2a
+#define S25G_TX_FFE_CFG_DAC_PRE1    0x03
+#define S25G_TX_FFE_CFG_DAC_PRE2    0x0
+#define S25G_TX_FFE_CFG_DAC_POST    0x11
+
+#define S40G_TX_FFE_CFG_MAIN        0x2b2b2b2b
+#define S40G_TX_FFE_CFG_PRE1        0x03030303
+#define S40G_TX_FFE_CFG_PRE2        0x0
+#define S40G_TX_FFE_CFG_POST        0x11111111
+
+#define BYPASS_CTLE_TAG             0x0
+
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT2      0x0
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT3      0x0
+#define S10G_PHY_RX_CTLE_TAP_FRACP1         0x18
+#define S10G_PHY_RX_CTLE_TAP_FRACP2         0x0
+#define S10G_PHY_RX_CTLE_TAP_FRACP3         0x0
+
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT2      0x0
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT3      0x0
+#define S25G_PHY_RX_CTLE_TAP_FRACP1         0x18
+#define S25G_PHY_RX_CTLE_TAP_FRACP2         0x0
+#define S25G_PHY_RX_CTLE_TAP_FRACP3         0x0
+
+#define TXGBE_E56_PHY_LINK_UP            0x4
+
+void set_fields_e56(unsigned int *src_data, unsigned int bit_high,
+		    unsigned int bit_low, unsigned int set_value);
+int txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane);
+int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE);
+u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw);
+u32 txgbe_e56_cfg_25g(struct txgbe_hw *hw);
+u32 txgbe_e56_cfg_10g(struct txgbe_hw *hw);
+int txgbe_temp_track_seq_40g(struct txgbe_hw *hw, u32 speed);
+int txgbe_temp_track_seq(struct txgbe_hw *hw, u32 speed);
+int txgbe_e56_get_temp(struct txgbe_hw *hw, int *temp);
+int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed);
+int txgbe_e56_reconfig_rx(struct txgbe_hw *hw, u32 speed);
+s32 txgbe_e56_fec_set(struct txgbe_hw *hw);
+s32 txgbe_e56_fec_polling(struct txgbe_hw *hw, bool *link_up);
+u32 txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed);
+
+#endif /* _TXGBE_E56_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.h b/drivers/net/txgbe/base/txgbe_e56_bp.h
new file mode 100644
index 0000000000..99dcca2af5
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.h
@@ -0,0 +1,279 @@
+#ifndef _TXGBE_E56_BP_H_
+#define _TXGBE_E56_BP_H_
+
+#define TXGBE_10G_FEC_REQ       BIT(15)
+#define TXGBE_10G_FEC_ABL       BIT(14)
+#define TXGBE_25G_BASE_FEC_REQ  BIT(13)
+#define TXGBE_25G_RS_FEC_REQ    BIT(12)
+
+#ifndef __bf_shf
+#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+#endif
+/**
+ * FIELD_GET_M() - extract a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg:  value of entire bitfield
+ *
+ * FIELD_GET_M() extracts the field specified by @_mask from the
+ * bitfield passed in as @_reg by masking and shifting it down.
+ */
+#define FIELD_GET_M(_mask, _reg)						\
+	({								\
+		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+	})
+
+typedef union {
+	struct {
+		u32 tx0_cursor_factor : 7;
+		u32 rsvd0             : 1;
+		u32 tx1_cursor_factor : 7;
+		u32 rsvd1             : 1;
+		u32 tx2_cursor_factor : 7;
+		u32 rsvd2             : 1;
+		u32 tx3_cursor_factor : 7;
+		u32 rsvd3             : 1;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_1;
+
+#define E56G__PMD_TX_FFE_CFG_1_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_1_ADDR                   (E56G__BASEADDR + 0x141c)
+#define E56G__PMD_TX_FFE_CFG_1_PTR ((E56G__PMD_TX_FFE_CFG_1 *)(E56G__PMD_TX_FFE_CFG_1_ADDR))
+#define E56G__PMD_TX_FFE_CFG_1_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_1_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_1_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_1_READ_MSB                                    30
+#define E56G__PMD_TX_FFE_CFG_1_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_1_WRITE_MSB                                   30
+#define E56G__PMD_TX_FFE_CFG_1_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_1_RESET_VALUE                         0x3f3f3f3f
+
+typedef union {
+	struct {
+		u32 tx0_precursor1_factor : 6;
+		u32 rsvd0                 : 2;
+		u32 tx1_precursor1_factor : 6;
+		u32 rsvd1                 : 2;
+		u32 tx2_precursor1_factor : 6;
+		u32 rsvd2                 : 2;
+		u32 tx3_precursor1_factor : 6;
+		u32 rsvd3                 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_2;
+
+#define E56G__PMD_TX_FFE_CFG_2_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_2_ADDR                   (E56G__BASEADDR + 0x1420)
+#define E56G__PMD_TX_FFE_CFG_2_PTR ((E56G__PMD_TX_FFE_CFG_2 *)(E56G__PMD_TX_FFE_CFG_2_ADDR))
+#define E56G__PMD_TX_FFE_CFG_2_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_2_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_2_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_2_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_2_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_2_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_2_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_2_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 tx0_precursor2_factor : 6;
+		u32 rsvd0                 : 2;
+		u32 tx1_precursor2_factor : 6;
+		u32 rsvd1                 : 2;
+		u32 tx2_precursor2_factor : 6;
+		u32 rsvd2                 : 2;
+		u32 tx3_precursor2_factor : 6;
+		u32 rsvd3                 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_3;
+#define E56G__PMD_TX_FFE_CFG_3_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_3_ADDR                   (E56G__BASEADDR + 0x1424)
+#define E56G__PMD_TX_FFE_CFG_3_PTR ((E56G__PMD_TX_FFE_CFG_3 *)(E56G__PMD_TX_FFE_CFG_3_ADDR))
+#define E56G__PMD_TX_FFE_CFG_3_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_3_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_3_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_3_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_3_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_3_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_3_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_3_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 tx0_postcursor_factor : 6;
+		u32 rsvd0                 : 2;
+		u32 tx1_postcursor_factor : 6;
+		u32 rsvd1                 : 2;
+		u32 tx2_postcursor_factor : 6;
+		u32 rsvd2                 : 2;
+		u32 tx3_postcursor_factor : 6;
+		u32 rsvd3                 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_4;
+#define E56G__PMD_TX_FFE_CFG_4_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_4_ADDR                   (E56G__BASEADDR + 0x1428)
+#define E56G__PMD_TX_FFE_CFG_4_PTR ((E56G__PMD_TX_FFE_CFG_4 *)(E56G__PMD_TX_FFE_CFG_4_ADDR))
+#define E56G__PMD_TX_FFE_CFG_4_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_4_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_4_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_4_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_4_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_4_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_4_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_4_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_vco_swing_ctrl_i    : 4;
+		u32 ana_lcpll_lf_lpf_setcode_calib_i : 5;
+		u32 rsvd0                            : 3;
+		u32 ana_lcpll_lf_vco_coarse_bin_i    : 5;
+		u32 rsvd1                            : 3;
+		u32 ana_lcpll_lf_vco_fine_therm_i    : 8;
+		u32 ana_lcpll_lf_clkout_fb_ctrl_i    : 2;
+		u32 rsvd2                            : 2;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDVAL_7;
+#define E56G__CMS_ANA_OVRDVAL_7_NUM                                         1
+#define E56G__CMS_ANA_OVRDVAL_7_ADDR                   (E56G__BASEADDR + 0xccc)
+#define E56G__CMS_ANA_OVRDVAL_7_PTR ((E56G__CMS_ANA_OVRDVAL_7 *)(E56G__CMS_ANA_OVRDVAL_7_ADDR))
+#define E56G__CMS_ANA_OVRDVAL_7_STRIDE                                      4
+#define E56G__CMS_ANA_OVRDVAL_7_SIZE                                       32
+#define E56G__CMS_ANA_OVRDVAL_7_ACC_SIZE                                   32
+#define E56G__CMS_ANA_OVRDVAL_7_READ_MSB                                   29
+#define E56G__CMS_ANA_OVRDVAL_7_READ_LSB                                    0
+#define E56G__CMS_ANA_OVRDVAL_7_WRITE_MSB                                  29
+#define E56G__CMS_ANA_OVRDVAL_7_WRITE_LSB                                   0
+#define E56G__CMS_ANA_OVRDVAL_7_RESET_VALUE                               0x0
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_lcpll_hf_vco_amp_status_o    : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkout_fb_ctrl_i    : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkdiv_ctrl_i       : 1;
+		u32 ovrd_en_ana_lcpll_hf_en_odiv_i           : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_in_i           : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_out_o          : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_bias_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_loop_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_cp_i             : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_base_i          : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_fine_i          : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_ctrl_i          : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_setcode_calib_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_set_lpf_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_vco_i            : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_sel_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i    : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_coarse_bin_i    : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_fine_therm_i    : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_amp_status_o    : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkout_fb_ctrl_i    : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkdiv_ctrl_i       : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_odiv_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_in_i           : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_out_o          : 1;
+		u32 ovrd_en_ana_lcpll_hf_refclk_select_i     : 1;
+		u32 ovrd_en_ana_lcpll_lf_refclk_select_i     : 1;
+		u32 ovrd_en_ana_lcpll_hf_clk_ref_sel_i       : 1;
+		u32 ovrd_en_ana_lcpll_lf_clk_ref_sel_i       : 1;
+		u32 ovrd_en_ana_test_bias_i                  : 1;
+		u32 ovrd_en_ana_test_slicer_i                : 1;
+		u32 ovrd_en_ana_test_sampler_i               : 1;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDEN_1;
+#define E56G__CMS_ANA_OVRDEN_1_NUM                                          1
+#define E56G__CMS_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR + 0xca8)
+#define E56G__CMS_ANA_OVRDEN_1_PTR ((E56G__CMS_ANA_OVRDEN_1 *)(E56G__CMS_ANA_OVRDEN_1_ADDR))
+#define E56G__CMS_ANA_OVRDEN_1_STRIDE                                       4
+#define E56G__CMS_ANA_OVRDEN_1_SIZE                                        32
+#define E56G__CMS_ANA_OVRDEN_1_ACC_SIZE                                    32
+#define E56G__CMS_ANA_OVRDEN_1_READ_MSB                                    31
+#define E56G__CMS_ANA_OVRDEN_1_READ_LSB                                     0
+#define E56G__CMS_ANA_OVRDEN_1_WRITE_MSB                                   31
+#define E56G__CMS_ANA_OVRDEN_1_WRITE_LSB                                    0
+#define E56G__CMS_ANA_OVRDEN_1_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_test_in_i : 32;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDVAL_9;
+#define E56G__CMS_ANA_OVRDVAL_9_NUM                                         1
+#define E56G__CMS_ANA_OVRDVAL_9_ADDR                   (E56G__BASEADDR + 0xcd4)
+#define E56G__CMS_ANA_OVRDVAL_9_PTR ((E56G__CMS_ANA_OVRDVAL_9 *)(E56G__CMS_ANA_OVRDVAL_9_ADDR))
+#define E56G__CMS_ANA_OVRDVAL_9_STRIDE                                      4
+#define E56G__CMS_ANA_OVRDVAL_9_SIZE                                       32
+#define E56G__CMS_ANA_OVRDVAL_9_ACC_SIZE                                   32
+#define E56G__CMS_ANA_OVRDVAL_9_READ_MSB                                   31
+#define E56G__CMS_ANA_OVRDVAL_9_READ_LSB                                    0
+#define E56G__CMS_ANA_OVRDVAL_9_WRITE_MSB                                  31
+#define E56G__CMS_ANA_OVRDVAL_9_WRITE_LSB                                   0
+#define E56G__CMS_ANA_OVRDVAL_9_RESET_VALUE                               0x0
+
+#define SFP2_RS0  5
+#define SFP2_RS1  4
+#define SFP2_TX_DISABLE  1
+#define SFP2_TX_FAULT  0
+#define SFP2_RX_LOS_BIT  3
+#ifdef PHYINIT_TIMEOUT
+#undef PHYINIT_TIMEOUT
+#define PHYINIT_TIMEOUT   2000
+#endif
+
+#define E56PHY_CMS_ANA_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR + 0xA4)
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_DAISY_EN_I	0, 0
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_PAD_EN_I		1, 1
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_PAD_EN_I_LSB 1
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_VDDINOFF_DCORE_DIG_O	2, 2
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_EN_I			11, 11
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_EN_I_LSB 11
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_TESTIN_I			12, 12
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_TESTIN_I_LSB 12
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RESCAL_I			13, 13
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RESCAL_I_LSB 13
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_COMP_O		14, 14
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_COMP_O_LSB 14
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_CODE_I		15, 15
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_CODE_I_LSB 15
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_LDO_CORE_I		16, 16
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_LDO_CORE_I_LSB 16
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_LDO_I			17, 17
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_LDO_I_LSB 17
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_ANA_DEBUG_SEL_I		18, 18
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_ANA_DEBUG_SEL_I_LSB 18
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_BIAS_I		19, 19
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_BIAS_I_LSB 19
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_LOOP_I		20, 20
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_LOOP_I_LSB 20
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_CP_I		21, 21
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_CP_I_LSB 21
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_BASE_I		22, 22
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_BASE_I_LSB 22
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_FINE_I		23, 23
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_FINE_I_LSB 23
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_CTRL_I		24, 24
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_CTRL_I_LSB 24
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I 25, 25
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I_LSB 25
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_SET_LPF_I		26, 26
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I	20, 16
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I 12, 12
+#define E56PHY_CMS_ANA_OVRDVAL_7_ADDR   (E56PHY_CMS_BASE_ADDR + 0xCC)
+#define E56PHY_CMS_ANA_OVRDVAL_5_ADDR   (E56PHY_CMS_BASE_ADDR + 0xC4)
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_TEST_IN_I		23, 23
+#define E56PHY_CMS_ANA_OVRDVAL_9_ADDR   (E56PHY_CMS_BASE_ADDR + 0xD4)
+#define E56PHY_CMS_ANA_OVRDVAL_10_ADDR   (E56PHY_CMS_BASE_ADDR + 0xD8)
+#define E56PHY_CMS_ANA_OVRDVAL_7_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I	8, 4
+int txgbe_e56_set_phy_link_mode(struct txgbe_hw *hw,
+				        unsigned char byLinkMode, unsigned int bypassCtle);
+void txgbe_e65_bp_down_event(struct txgbe_hw *hw);
+int handle_e56_bkp_an73_flow(struct txgbe_hw *hw);
+
+#endif
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0719b56e3c..3b683eaa04 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -4069,37 +4069,12 @@ s32 txgbe_reset_pipeline_raptor(struct txgbe_hw *hw)
 	return err;
 }
 
-s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
-				bool *link_up)
+bool txgbe_gpio_ext_check(struct txgbe_hw *hw, u8 gpio_ext_mask)
 {
-	u32 rdata = 0;
-	u32 links_reg = 0;
+	u32 gpio_ext = rd32(hw, TXGBE_GPIOEXT);
 
-	/* must read it twice because the state may
-	 * not be correct the first time you read it
-	 */
-	rdata = rd32_epcs(hw, 0x30001);
-	rdata = rd32_epcs(hw, 0x30001);
-
-	if (rdata & TXGBE_AML_PHY_LINK_UP)
-		*link_up = true;
-	else
-		*link_up = false;
-
-	links_reg = rd32(hw, TXGBE_PORTSTAT);
-	if (*link_up) {
-		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
-				TXGBE_CFG_PORT_ST_AML_LINK_40G)
-			*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) ==
-				TXGBE_CFG_PORT_ST_AML_LINK_25G)
-			*speed = TXGBE_LINK_SPEED_25GB_FULL;
-		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
-				TXGBE_CFG_PORT_ST_AML_LINK_10G)
-			*speed = TXGBE_LINK_SPEED_10GB_FULL;
-	} else {
-		*speed = TXGBE_LINK_SPEED_UNKNOWN;
-	}
+	if (gpio_ext & gpio_ext_mask)
+		return true;
 
-	return 0;
+	return false;
 }
diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index f4282b3241..91ad36f4d4 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -28,14 +28,6 @@
 #define TMZ_VADDR(mz)  ((mz)->addr)
 #define TDEV_NAME(eth_dev)  ((eth_dev)->device->name)
 
-extern int txgbe_logtype_bp;
-#define RTE_LOGTYPE_TXGBE_BP txgbe_logtype_bp
-#define BP_LOG(fmt, ...) \
-	RTE_LOG(DEBUG, TXGBE_BP, \
-		"[%"PRIu64".%"PRIu64"]%s(%d): " fmt, \
-		usec_stamp() / 1000000, usec_stamp() % 1000000, \
-		__func__, __LINE__, ## __VA_ARGS__)
-
 #define ASSERT(x) do {			\
 	if (!(x))			\
 		PMD_DRV_LOG(ERR, "TXGBE: %d", x);	\
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index f1849c8400..c02be3cc34 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -40,7 +40,6 @@
 #define   SR_PMA_KR_LD_CESTS_RR		MS16(15, 0x1)
 #define SR_PMA_KR_FEC_CTRL              0x0100AB
 #define   SR_PMA_KR_FEC_CTRL_EN		MS16(0, 0x1)
-#define SR_PMA_RS_FEC_CTRL              0x0100C8
 #define SR_MII_MMD_CTL                  0x1F0000
 #define   SR_MII_MMD_CTL_AN_EN              0x1000
 #define   SR_MII_MMD_CTL_RESTART_AN         0x0200
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index bc73f28ca2..85d0aee8ff 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -158,6 +158,8 @@
 #define   TXGBE_RST_SW             MS(0, 0x1)
 #define   TXGBE_RST_LAN(i)         MS(((i) + 1), 0x1)
 #define   TXGBE_RST_FW             MS(3, 0x1)
+#define   TXGBE_RST_EPHY_LAN_1     MS(16, 0x1)
+#define   TXGBE_RST_EPHY_LAN_0     MS(19, 0x1)
 #define   TXGBE_RST_MAC_LAN_1      MS(17, 0x1)
 #define   TXGBE_RST_MAC_LAN_0      MS(20, 0x1)
 #define   TXGBE_RST_ETH(i)         MS(((i) + 29), 0x1)
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index ede780321f..421abc1145 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -64,6 +64,9 @@
 #define TXGBE_AML_ALARM_THRE_MASK       0x1FFE0000U
 #define TXGBE_AML_DALARM_THRE_MASK      0x0001FFE0U
 
+#define CL74_KRTR_TRAINNING_TIMEOUT	6000	/* 3000ms c74 trainning timeout */
+#define AN_TRAINNING_MODE		0	/* 0: not dis an 1: dis an */
+
 struct txgbe_thermal_diode_data {
 	s16 temp;
 	s16 alarm_thresh;
@@ -690,6 +693,8 @@ struct txgbe_phy_info {
 	s32 (*setup_link_speed)(struct txgbe_hw *hw, u32 speed,
 				bool autoneg_wait_to_complete);
 	s32 (*check_link)(struct txgbe_hw *hw, u32 *speed, bool *link_up);
+	s32 (*setup_link_core)(struct txgbe_hw *hw, u32 speed,
+			       bool autoneg_wait_to_complete, bool *need_reset);
 	s32 (*get_fw_version)(struct txgbe_hw *hw, u32 *fw_version);
 	s32 (*read_i2c_byte)(struct txgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
@@ -732,7 +737,9 @@ struct txgbe_phy_info {
 	u16 ffe_set;
 	u16 ffe_main;
 	u16 ffe_pre;
+	u16 ffe_pre2;
 	u16 ffe_post;
+	u16 fec_mode;
 };
 
 #define TXGBE_DEVARG_BP_AUTO		"auto_neg"
@@ -823,6 +830,7 @@ struct txgbe_devargs {
 struct txgbe_hw {
 	void IOMEM *hw_addr;
 	void *back;
+	void *dev_back;
 	struct txgbe_mac_info mac;
 	struct txgbe_addr_filter_info addr_ctrl;
 	struct txgbe_fc_info fc;
@@ -881,8 +889,12 @@ struct txgbe_hw {
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
 	rte_atomic32_t swfw_busy;
+	bool link_valid;
+	bool reconfig_rx;
 	u32 fec_mode;
 	u32 cur_fec_link;
+	int temperature;
+	u32 bp_link_mode;
 };
 
 struct txgbe_backplane_ability {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e3492c9cd7..622049890f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -592,6 +592,17 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	fdir_conf->drop_queue = drop_queue;
 }
 
+static void
+txgbe_override_mac_ops(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+
+	if (hw->phy.multispeed_fiber)
+		mac->setup_mac_link = txgbe_setup_mac_link_aml;
+	else
+		mac->setup_link = txgbe_setup_mac_link_aml;
+}
+
 static int
 eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 {
@@ -651,6 +662,7 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 	/* Vendor and Device ID need to be set before init of shared code */
 	hw->back = pci_dev;
+	hw->dev_back = eth_dev;
 	hw->port_id = eth_dev->data->port_id;
 	hw->device_id = pci_dev->id.device_id;
 	hw->vendor_id = pci_dev->id.vendor_id;
@@ -686,6 +698,9 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 		return -EIO;
 	}
 
+	if (hw->mac.type == txgbe_mac_aml)
+		txgbe_override_mac_ops(hw);
+
 	/* Unlock any pending hardware semaphore */
 	txgbe_swfw_lock_reset(hw);
 
@@ -2039,6 +2054,9 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (hw->mac.type == txgbe_mac_aml)
+		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
+
 	rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
 	rte_eal_alarm_cancel(txgbe_tx_queue_clear_error, dev);
 	txgbe_dev_wait_setup_link_complete(dev, 0);
@@ -3087,6 +3105,65 @@ txgbe_tx_ring_recovery(struct rte_eth_dev *dev)
 	}
 }
 
+void
+txgbe_dev_setup_link_alarm_handler_aml(void *param)
+{
+	struct txgbe_hw *hw = (struct txgbe_hw *)param;
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)hw->dev_back;
+	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
+	u32 speed;
+	bool autoneg = false;
+	u32 gssr = hw->phy.phy_semaphore_mask;
+
+	if (!hw)
+		return;
+
+	speed = hw->phy.autoneg_advertised;
+	if (!speed)
+		hw->mac.get_link_capabilities(hw, &speed, &autoneg);
+
+	/* firmware is configuring phy now, delay host driver config action */
+	if (hw->mac.acquire_swfw_sync(hw, gssr) != 0) {
+		rte_eal_alarm_set(1000 * 1000 * 2,
+				  txgbe_dev_setup_link_alarm_handler_aml, hw);
+		printf("delay config ephy\n");
+		return;
+	}
+
+	hw->mac.setup_link(hw, speed, true);
+
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+
+	hw->mac.check_link(hw, &link_speed, &link_up, false);
+	if (link_up) {
+		DEBUGOUT("LINK UP IN HANDLER");
+		intr->flags &= ~TXGBE_FLAG_NEED_LINK_CONFIG;
+		txgbe_dev_link_update_share(dev, 0);
+	}
+
+	hw->mac.release_swfw_sync(hw, gssr);
+
+	intr->flags &= ~TXGBE_FLAG_NEED_LINK_CONFIG;
+}
+
+s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
+				    u32 speed,
+				    bool autoneg_wait_to_complete)
+{
+	bool need_reset = false;
+	s32 status = 0;
+
+	status = hw->phy.setup_link_core(hw, speed, autoneg_wait_to_complete, &need_reset);
+	if (status)
+		return status;
+
+	if (!hw->adapter_stopped && need_reset)
+		rte_eal_alarm_set(2000 * 1000, txgbe_dev_setup_link_alarm_handler_aml, hw);
+
+	return status;
+}
+
 /*
  * If @timeout_ms was 0, it means that it will not return until link complete.
  * It returns 1 on complete, return 0 on timeout.
@@ -3120,9 +3197,13 @@ txgbe_dev_setup_link_thread_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
 	struct txgbe_adapter *ad = TXGBE_DEV_ADAPTER(dev);
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	rte_thread_detach(rte_thread_self());
-	txgbe_dev_setup_link_alarm_handler(dev);
+	if (hw->mac.type == txgbe_mac_aml)
+		txgbe_dev_setup_link_alarm_handler_aml(hw);
+	else
+		txgbe_dev_setup_link_alarm_handler(dev);
 	rte_atomic_store_explicit(&ad->link_thread_running, 0, rte_memory_order_seq_cst);
 	return 0;
 }
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 189fbac541..1ec8e096cc 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -733,6 +733,10 @@ int txgbe_dev_rss_reta_query(struct rte_eth_dev *dev,
 			struct rte_eth_rss_reta_entry64 *reta_conf,
 			uint16_t reta_size);
 void txgbe_dev_setup_link_alarm_handler(void *param);
+void txgbe_dev_setup_link_alarm_handler_aml(void *param);
+s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
+				    u32 speed,
+				    bool autoneg_wait_to_complete);
 void txgbe_read_stats_registers(struct txgbe_hw *hw,
 			   struct txgbe_hw_stats *hw_stats);
 
diff --git a/drivers/net/txgbe/txgbe_logs.h b/drivers/net/txgbe/txgbe_logs.h
index 1ad9d25ca1..2fc63e5921 100644
--- a/drivers/net/txgbe/txgbe_logs.h
+++ b/drivers/net/txgbe/txgbe_logs.h
@@ -49,6 +49,13 @@ extern int txgbe_logtype_tx_free;
 #define PMD_TX_FREE_LOG(...) do { } while (0)
 #endif
 
+extern int txgbe_logtype_bp;
+#define BP_LOG(fmt, args...) \
+	rte_log(RTE_LOG_DEBUG, txgbe_logtype_bp, \
+		"[%" PRIu64 ".%" PRIu64 "]%s(%d): <port %d> " fmt, \
+		usec_stamp() / 1000000, usec_stamp() % 1000000, \
+		__func__, __LINE__, hw->port_id, ##args)
+
 #define DEBUGOUT(fmt, ...)        PMD_DRV_LOG(DEBUG, fmt, ##__VA_ARGS__)
 #define PMD_INIT_FUNC_TRACE()     PMD_DRV_LOG(DEBUG, ">>")
 
-- 
2.21.0.windows.1

