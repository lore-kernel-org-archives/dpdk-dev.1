Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF5DCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42A4D4066B;
	Sat,  9 May 2026 13:29:29 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id DA73D40A71;
 Sat,  9 May 2026 13:29:26 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326161t78e33061
X-QQ-Originating-IP: xuk+UHAaKBi4Z1eext42OnliSB7zqbVI6WLBdRRmXEs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 191984682884425262
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 13/20] net/txgbe: fix link stability for 40G NIC
Date: Sat,  9 May 2026 19:28:15 +0800
Message-Id: <20260509112823.7728-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwqrwaLzgdebs2qQKbwAKaDHB5YH+F15oOWwv4r0csC5xBKoQZRlpo/r
 fg/hTliARTsUNZKIlw3eh4Vz/ChLd5rLb7IWncmWLFKHffMV+AFbdTZTIxn6id4yDkXe0nM
 LBUpvzzAWV3gBrTb72xU9Hk+jZzx7tPGMpY45RiLxOoEfU6m5GJZ1qk2ksPukz+zRAPeXLF
 FJAGKkGdDPHXLWtD/z6eC6r6XWQnxbd96s89SwjKtGOvjvGjWakKUlJaDXcCdmE/RrMgZtt
 vE4tzlCfuwxa+JLPtweoykjNKEeta1gAQIgIQjq7A052Lhe1il605NKTZXqUwt5L69bC5yo
 l7qze9lwOm6/wJy8WElIZaOMuMCA6zBUh2dhaa1yvXB7XU5RgQUK+dXWbuYFRYTeJ2UmdlV
 jlcTnkasxBOaRV8MeZ3SN71vdr9IGjHxApizEBh1YbikBkqHfk4u4q3b+f7kY75vmApa7KW
 39+9ivB2egRqrl8fQumU+tfYtc6MfdP9FI5KlkwRJp5E95LAljFKZyvVSjRnP9sGYIXIib+
 8TbRW/qvao7owPXXj6Zvgmvr/Pp7YbEFX3zVGlaoIT96nSfrRQC82YD1xb8efMC/i/f2ZiI
 KJecbRMjIBqtN5DDLUwVCMJYUp42b+lNd2VtkaElVQ0PJiIg5XpUtOAcLu4Ge0PyQRNMd1Y
 MgHpqgfr1YWmkmugehbPv9mSgdnsuEjsqwpCY2pX4nol6mgv6L20xzM/0xoibkN/RYnKeyg
 /+9rDp/sXv0DvBtywDabgjugC8RlrWQkA1MiN6u2gLPX01KjyrPzR02CcmOV1lUhG5ksQan
 EvjBDixJxOw6lZKEDn+zpG26pz6X+IPbLk+h4KBl1ju/k7VP3OZask8uRq04DyzmuHqL9gF
 nNvgiqZ6Xj9lGCkrVllJErTvt8XsZZQB8lItJj6OLMNOI2mShgic8pGVkViPbixrEXpZE/m
 msX2pp2ydU6i6r9VJSHYMr0BfUyu7vnNI6pNi9xVx5trpSDyYNasbDAcXrNTVVpbLK0brcl
 OzotAFo9FTGSY3gSdDeTbWK02fSNxFvOnX1HgznR16uMB03n8yyJLF2mXJyqtMuk2Zkuj8K
 e9JZem83KUrPytU0XYpE9Y=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

Fixes: ead3616f630d ("net/txgbe: support PHY configuration via SW-FW mailbox")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c |   70 +-
 drivers/net/txgbe/base/txgbe_aml40.h |    6 +-
 drivers/net/txgbe/base/txgbe_e56.c   | 1471 ++++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.c     |    4 +-
 4 files changed, 1438 insertions(+), 113 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index eefd7119fd..84c130704a 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -13,6 +13,7 @@
 #include "txgbe_hw.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
+#include "txgbe_e56.h"
 
 void txgbe_init_ops_aml40(struct txgbe_hw *hw)
 {
@@ -24,6 +25,7 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
 
 	/* PHY */
 	phy->get_media_type = txgbe_get_media_type_aml40;
+	phy->setup_link_core = txgbe_setup_phy_link_aml40;
 
 	/* LINK */
 	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
@@ -52,6 +54,13 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 
 	if (link_up_wait_to_complete) {
 		for (i = 0; i < hw->mac.max_link_up_time; i++) {
+			if (!hw->link_valid) {
+				*link_up = false;
+
+				msleep(100);
+				continue;
+			}
+
 			if (!(links_reg & TXGBE_PORTSTAT_UP)) {
 				*link_up = false;
 			} else {
@@ -68,6 +77,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 			*link_up = false;
 	}
 
+	if (!hw->link_valid)
+		*link_up = false;
+
 	if (*link_up) {
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
@@ -107,20 +119,24 @@ u32 txgbe_get_media_type_aml40(struct txgbe_hw *hw)
 	return txgbe_media_type_fiber_qsfp;
 }
 
-s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
-			       u32 speed,
-			       bool autoneg_wait_to_complete)
+s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
+				      u32 speed,
+				      bool autoneg_wait_to_complete,
+				      bool *need_reset)
 {
 	bool autoneg = false;
 	s32 status = 0;
+	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
+	u32 value;
 
-	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
-		DEBUGOUT("SFP not detected, skip setup mac link");
-		return 0;
-	}
+	*need_reset = false;
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_not_present)
+		hw->phy.identify_sfp(hw);
 
 	/* Check to see if speed passed in is supported. */
 	status = hw->mac.get_link_capabilities(hw,
@@ -132,18 +148,43 @@ s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
 	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
 		return TXGBE_ERR_LINK_SETUP;
 
-	status = hw->mac.check_link(hw, &link_speed, &link_up,
-				    autoneg_wait_to_complete);
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			break;
+		msleep(250);
+	}
 
 	if (link_speed == speed && link_up)
-		return status;
+		goto out;
 
-	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
-		speed = 0x20;
+	rte_spinlock_lock(&hw->phy_lock);
+	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
 
-	status = hw->phy.set_link_hostif(hw, (u8)speed, autoneg, true);
+	if (ret_status == TXGBE_ERR_TIMEOUT)
+		hw->link_valid = false;
+
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			goto out;
+		msleep(250);
+	}
 
-	txgbe_wait_for_link_up_aml(hw, speed);
+out:
+	if (link_up) {
+		value = rd32(hw, TXGBE_PORTSTAT);
+		if (!(value & TXGBE_PORTSTAT_UP)) {
+			DEBUGOUT("MAC link 0x14404: 0x%x", value);
+			*need_reset = true;
+			value = rd32(hw, 0x110b0);
+			DEBUGOUT("MAC intr status 0x110b0: 0x%x", value);
+		}
+	} else {
+		*need_reset = true;
+		DEBUGOUT("Link reconfiguration required. Reset scheduled in 2000ms.");
+	}
 
 	return status;
 }
@@ -159,6 +200,5 @@ void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw)
 	mac->flap_tx_laser =
 		txgbe_flap_tx_laser_multispeed_fiber;
 
-	mac->setup_link = txgbe_setup_mac_link_aml40;
 	mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
 }
diff --git a/drivers/net/txgbe/base/txgbe_aml40.h b/drivers/net/txgbe/base/txgbe_aml40.h
index f31360c899..d97654fbf8 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.h
+++ b/drivers/net/txgbe/base/txgbe_aml40.h
@@ -14,7 +14,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw,
 s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
 u32 txgbe_get_media_type_aml40(struct txgbe_hw *hw);
-s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw, u32 speed,
-			       bool autoneg_wait_to_complete);
+s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
+				      u32 speed,
+				      bool autoneg_wait_to_complete,
+				      bool *need_reset);
 void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw);
 #endif /* _TXGBE_AML40_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index 3c4b054ef6..ebeae16e34 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -98,11 +98,29 @@ u32 txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed)
 	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
 		if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
 		    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1) {
+			ffe_main = S25G_TX_FFE_CFG_DAC_MAIN;
+			pre1 = S25G_TX_FFE_CFG_DAC_PRE1;
+			pre2 = S25G_TX_FFE_CFG_DAC_PRE2;
+			post = S25G_TX_FFE_CFG_DAC_POST;
+		} else {
 			ffe_main = S25G_TX_FFE_CFG_MAIN;
 			pre1 = S25G_TX_FFE_CFG_PRE1;
 			pre2 = S25G_TX_FFE_CFG_PRE2;
 			post = S25G_TX_FFE_CFG_POST;
 		}
+	} else if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		ffe_main = S10G_TX_FFE_CFG_MAIN;
+		pre1 = S10G_TX_FFE_CFG_PRE1;
+		pre2 = S10G_TX_FFE_CFG_PRE2;
+		post = S10G_TX_FFE_CFG_POST;
+
+		if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
+		    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
+			ffe_main = S40G_TX_FFE_CFG_MAIN;
+			pre1 = S40G_TX_FFE_CFG_PRE1;
+			pre2 = S40G_TX_FFE_CFG_PRE2;
+			post = S40G_TX_FFE_CFG_POST;
+		}
 	}
 
 	if (hw->phy.ffe_set) {
@@ -150,6 +168,416 @@ txgbe_e56_get_temp(struct txgbe_hw *hw, int *temp)
 	return 0;
 }
 
+u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+	int i;
+
+	/* CMS Config Master */
+	addr  = E56G_CMS_ANA_OVRDVAL_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDVAL_9_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_test_in_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	/* TXS Config Master */
+	for (i = 0; i < 4; i++) {
+		addr  = E56PHY_TXS_TXS_CFG_1_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_WKUP_CNT_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+		set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_PIN_OVRDVAL_6_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 19, 16, 0x6);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_PIN_OVRDEN_0_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_ANA_OVRDVAL_1_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_ANA_OVRDEN_0_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+	}
+	/* Setting TX FFE */
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_40GB_FULL);
+
+	/* RXS Config master */
+	for (i = 0; i < 4; i++) {
+		addr  = E56PHY_RXS_RXS_CFG_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+		set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->prediv0 = 0xfa0;
+		((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->target_cnt0 = 0x203a;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_range_sel0 = 0x2;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->vco_code_init = 0x7ff;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_current_boost_en0 = 0x1;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->bbcdr_current_boost0 = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK, 0xc);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_INTL_CONFIG_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_INTL_CONFIG_0 *)&rdata)->adc_intl2slice_delay0 = 0x5555;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_INTL_CONFIG_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_INTL_CONFIG_2 *)&rdata)->interleaver_hbw_disable0 = 0x1;
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1e8);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0x78);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_VGA_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_VGA_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1,
+			       S10G_PHY_RX_CTLE_TAP_FRACP1);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2,
+			       S10G_PHY_RX_CTLE_TAP_FRACP2);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3,
+			       S10G_PHY_RX_CTLE_TAP_FRACP3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1,
+			       S10G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2,
+			       S10G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3,
+			       S10G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+			       0xc);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_FFE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_IDLE_DETECT_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS3_ANA_OVRDVAL_11_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G__RXS3_ANA_OVRDVAL_11 *)&rdata)->ana_test_adc_clkgen_i = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS0_ANA_OVRDEN_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G__RXS0_ANA_OVRDEN_2 *)&rdata)->ovrd_en_ana_test_adc_clkgen_i = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 4, 0, 0x6);
+		set_fields_e56(&rdata, 14, 13, 0x2);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+			       0x1);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 2, 0, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 13, 13, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 13, 13, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_EYE_SCAN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 9, 4, 0x366);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	/* PDIG Config master */
+	addr  = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2, 0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
 u32
 txgbe_e56_cfg_25g(struct txgbe_hw *hw)
 {
@@ -1294,6 +1722,46 @@ txgbe_e56_rxs_osc_init_for_temp_track_range(struct txgbe_hw *hw, u32 speed)
 	return status;
 }
 
+static int txgbe_e56_set_rxs_ufine_le_max_40g(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	unsigned int ULTRAFINE_CODE;
+	int i = 0;
+	unsigned int CMVAR_UFINE_MAX = 0;
+	u32 addr;
+
+	for (i = 0; i < 4; i++) {
+		if (speed == TXGBE_LINK_SPEED_10GB_FULL || speed == TXGBE_LINK_SPEED_40GB_FULL)
+			CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+		else if (speed == TXGBE_LINK_SPEED_25GB_FULL)
+			CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+
+		/* a. Assign software defined variables as below */
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+		/* b. Perform the below logic sequence */
+		while (ULTRAFINE_CODE > CMVAR_UFINE_MAX) {
+			ULTRAFINE_CODE = ULTRAFINE_CODE - 1;
+			addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE;
+			wr32_ephy(hw, addr, rdata);
+
+			addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			wr32_ephy(hw, addr, rdata);
+
+			/* Wait until 1milliseconds or greater */
+			msleep(10);
+		}
+	}
+	return status;
+}
+
 static inline
 int txgbe_e56_set_rxs_ufine_le_max(struct txgbe_hw *hw, u32 speed)
 {
@@ -1328,38 +1796,269 @@ int txgbe_e56_set_rxs_ufine_le_max(struct txgbe_hw *hw, u32 speed)
 	return status;
 }
 
-int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE)
-{
-	int status = 0, i, N, median;
-	unsigned int rdata;
-	int array_size, RXS_BBCDR_SECOND_ORDER_ST[5];
+int txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane)
+{
+	int status = 0, i, N, median;
+	unsigned int rdata;
+	u32 addr;
+	int array_size, RXS_BBCDR_SECOND_ORDER_ST[5];
+
+	/* Set ovrd_en=0 to read ASIC value */
+	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
+	rdata = rd32_ephy(hw, addr);
+	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
+	wr32_ephy(hw, addr, rdata);
+
+	/*
+	 * As status update from RXS hardware is asynchronous to read status of SECOND_ORDER,
+	 * follow sequence mentioned below.
+	 */
+	N = 5;
+	for (i = 0; i < N; i = i + 1) {
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+							 ana_bbcdr_int_cstm_i);
+		usec_delay(100);
+	}
+
+	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
+	array_size = ARRAY_SIZE(RXS_BBCDR_SECOND_ORDER_ST);
+	qsort(RXS_BBCDR_SECOND_ORDER_ST, array_size, sizeof(int), txgbe_e56_int_cmp);
+
+	median = ((N + 1) / 2) - 1;
+	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
+
+	return status;
+}
+
+int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE)
+{
+	int status = 0, i, N, median;
+	unsigned int rdata;
+	int array_size, RXS_BBCDR_SECOND_ORDER_ST[5];
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
+		EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					       ana_bbcdr_int_cstm_i);
+		usec_delay(100);
+	}
+
+	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
+	array_size = ARRAY_SIZE(RXS_BBCDR_SECOND_ORDER_ST);
+	qsort(RXS_BBCDR_SECOND_ORDER_ST, array_size, sizeof(int), txgbe_e56_int_cmp);
+
+	median = ((N + 1) / 2) - 1;
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
+int txgbe_temp_track_seq_40g(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	int SECOND_CODE;
+	int COARSE_CODE;
+	int FINE_CODE;
+	int ULTRAFINE_CODE;
+
+	int CMVAR_SEC_LOW_TH;
+	int CMVAR_UFINE_MAX = 0;
+	int CMVAR_FINE_MAX;
+	int CMVAR_UFINE_UMAX_WRAP = 0;
+	int CMVAR_COARSE_MAX;
+	int CMVAR_UFINE_FMAX_WRAP = 0;
+	int CMVAR_FINE_FMAX_WRAP = 0;
+	int CMVAR_SEC_HIGH_TH;
+	int CMVAR_UFINE_MIN;
+	int CMVAR_FINE_MIN;
+	int CMVAR_UFINE_UMIN_WRAP;
+	int CMVAR_COARSE_MIN;
+	int CMVAR_UFINE_FMIN_WRAP;
+	int CMVAR_FINE_FMIN_WRAP;
+	int i;
+	u32 addr;
+	int temperature;
+
+	for (i = 0; i < 4; i++) {
+		if (speed == TXGBE_LINK_SPEED_10GB_FULL || speed == TXGBE_LINK_SPEED_40GB_FULL) {
+			CMVAR_SEC_LOW_TH = S10G_CMVAR_SEC_LOW_TH;
+			CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+			CMVAR_FINE_MAX = S10G_CMVAR_FINE_MAX;
+			CMVAR_UFINE_UMAX_WRAP = S10G_CMVAR_UFINE_UMAX_WRAP;
+			CMVAR_COARSE_MAX = S10G_CMVAR_COARSE_MAX;
+			CMVAR_UFINE_FMAX_WRAP = S10G_CMVAR_UFINE_FMAX_WRAP;
+			CMVAR_FINE_FMAX_WRAP = S10G_CMVAR_FINE_FMAX_WRAP;
+			CMVAR_SEC_HIGH_TH = S10G_CMVAR_SEC_HIGH_TH;
+			CMVAR_UFINE_MIN = S10G_CMVAR_UFINE_MIN;
+			CMVAR_FINE_MIN = S10G_CMVAR_FINE_MIN;
+			CMVAR_UFINE_UMIN_WRAP = S10G_CMVAR_UFINE_UMIN_WRAP;
+			CMVAR_COARSE_MIN = S10G_CMVAR_COARSE_MIN;
+			CMVAR_UFINE_FMIN_WRAP = S10G_CMVAR_UFINE_FMIN_WRAP;
+			CMVAR_FINE_FMIN_WRAP = S10G_CMVAR_FINE_FMIN_WRAP;
+		} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+			CMVAR_SEC_LOW_TH = S25G_CMVAR_SEC_LOW_TH;
+			CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+			CMVAR_FINE_MAX = S25G_CMVAR_FINE_MAX;
+			CMVAR_UFINE_UMAX_WRAP = S25G_CMVAR_UFINE_UMAX_WRAP;
+			CMVAR_COARSE_MAX = S25G_CMVAR_COARSE_MAX;
+			CMVAR_UFINE_FMAX_WRAP = S25G_CMVAR_UFINE_FMAX_WRAP;
+			CMVAR_FINE_FMAX_WRAP = S25G_CMVAR_FINE_FMAX_WRAP;
+			CMVAR_SEC_HIGH_TH = S25G_CMVAR_SEC_HIGH_TH;
+			CMVAR_UFINE_MIN = S25G_CMVAR_UFINE_MIN;
+			CMVAR_FINE_MIN = S25G_CMVAR_FINE_MIN;
+			CMVAR_UFINE_UMIN_WRAP = S25G_CMVAR_UFINE_UMIN_WRAP;
+			CMVAR_COARSE_MIN = S25G_CMVAR_COARSE_MIN;
+			CMVAR_UFINE_FMIN_WRAP = S25G_CMVAR_UFINE_FMIN_WRAP;
+			CMVAR_FINE_FMIN_WRAP = S25G_CMVAR_FINE_FMIN_WRAP;
+		} else {
+			DEBUGOUT("Error Speed\n");
+			return 0;
+		}
 
+		status = txgbe_e56_get_temp(hw, &temperature);
+		if (status)
+			return 0;
 
-	/* Set ovrd_en=0 to read ASIC value */
-	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i, 0);
+		hw->temperature = temperature;
 
-	/*
-	 * As status update from RXS hardware is asynchronous to read status
-	 * of SECOND_ORDER, follow sequence mentioned below.
-	 */
-	N = 5;
-	for (i = 0; i < N; i = i + 1) {
-		/* set RXS_BBCDR_SECOND_ORDER_ST[i] =
-		 * RXS::ANA_OVRDVAL[5]::ana_bbcdr_int_cstm_i[4:0]
+		/* Assign software defined variables as below */
+		/* a. SECOND_CODE = ALIAS::RXS::SECOND_ORDER */
+		status |= txgbe_e56_rx_rd_second_code_40g(hw, &SECOND_CODE, i);
+
+		/*
+		 * b. COARSE_CODE = ALIAS::RXS::COARSE
+		 * c. FINE_CODE = ALIAS::RXS::FINE
+		 * d. ULTRAFINE_CODE = ALIAS::RXS::ULTRAFINE
 		 */
-		EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
-		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
-					       ana_bbcdr_int_cstm_i);
-		usec_delay(100);
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		COARSE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i);
+		FINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i);
+		ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+		if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
+			if (ULTRAFINE_CODE < CMVAR_UFINE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+
+				/* Set ovrd_en=1 to override ASIC value */
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (FINE_CODE < CMVAR_FINE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_fine_i) = FINE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (COARSE_CODE < CMVAR_COARSE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_fine_i) = CMVAR_FINE_FMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_coarse_i) = COARSE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else {
+				DEBUGOUT("ERROR: (SECOND_CODE <= CMVAR_SEC_LOW_TH) temperature "
+					 "tracking occurs Error condition");
+			}
+		} else if (SECOND_CODE >= CMVAR_SEC_HIGH_TH) {
+			if (ULTRAFINE_CODE > CMVAR_UFINE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (FINE_CODE > CMVAR_FINE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_fine_i) = FINE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (COARSE_CODE > CMVAR_COARSE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_fine_i) = CMVAR_FINE_FMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					  ana_bbcdr_coarse_i) = COARSE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1,
+					  ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else {
+				DEBUGOUT("ERROR: (SECOND_CODE >= CMVAR_SEC_HIGH_TH) temperature "
+					 "tracking occurs Error condition");
+			}
+		}
 	}
-
-	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
-	array_size = ARRAY_SIZE(RXS_BBCDR_SECOND_ORDER_ST);
-	qsort(RXS_BBCDR_SECOND_ORDER_ST, array_size, sizeof(int), txgbe_e56_int_cmp);
-
-	median = ((N + 1) / 2) - 1;
-	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
-
 	return status;
 }
 
@@ -1534,78 +2233,410 @@ int txgbe_temp_track_seq(struct txgbe_hw *hw, u32 speed)
 			PMD_DRV_LOG(ERR, "ERROR: (SECOND_CODE >= CMVAR_SEC_HIGH_TH) "
 				    "temperature tracking occurs Error condition");
 		}
-	}
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
+static int txgbe_e56_rxs_calib_adapt_seq_40G(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0, i, j;
+	u32 addr, timer;
+	u32 rdata = 0x0;
+	u32 bypass_ctle = true;
+
+	for (i = 0; i < 4; i++) {
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	if (bypass_ctle == 1)
+		txgbe_e56_ctle_bypass_seq(hw, speed);
+
+	/*
+	 * 2. Follow sequence described in 2.3.2 RXS Osc Initialization for temperature tracking
+	 * range here. RXS would be enabled at the end of this sequence. For the case when PAM4 KR
+	 * training is not enabled (including PAM4 mode without KR training), wait until
+	 * ALIAS::PDIG::CTRL_FSM_RX_ST would return RX_TRAIN_15_ST (RX_RDY_ST).
+	 */
+	txgbe_e56_rxs_osc_init_for_temp_track_range(hw, speed);
+
+	addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+	timer = 0;
+	rdata = 0;
+	while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx0_st) != E56PHY_RX_RDY_ST ||
+	       EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx1_st) != E56PHY_RX_RDY_ST ||
+	       EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx2_st) != E56PHY_RX_RDY_ST ||
+	       EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx3_st) != E56PHY_RX_RDY_ST) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
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
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS1_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS2_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS3_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	for (i = 0; i < 4; i++) {
+		/* 4. Disable VGA and CTLE training so they don't interfere with ADC calibration */
+		/* a. Set ALIAS::RXS::VGA_TRAIN_EN = 0b0 */
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* b. Set ALIAS::RXS::CTLE_TRAIN_EN = 0b0 */
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* 5. Perform ADC interleaver calibration */
+		/* a. Remove the OVERRIDE on ALIAS::RXS::ADC_INTL_CAL_DONE */
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		timer = 0;
+		while (((rdata >> E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB)
+			 & 1) != 1) {
+			rdata = rd32_ephy(hw, addr);
+			usec_delay(1000);
+
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+
+		/*
+		 * 6. Perform ADC offset adaptation and ADC gain adaptation, repeat them a few
+		 * times and after that keep it disabled.
+		 */
+		for (j = 0; j < 16; j++) {
+			/* a. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b1 */
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata,
+				       E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+			wr32_ephy(hw, addr, rdata);
+
+			/* b. Wait for 1ms or greater */
+			addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2,
+				  ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			timer = 0;
+			while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+					 rxs0_rx0_adc_ofst_adapt_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+				if (timer++ > PHYINIT_TIMEOUT)
+					break;
+			}
+
+			/* c. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b0 */
+			rdata = 0x0000;
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata,
+				       E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+			wr32_ephy(hw, addr, rdata);
+
+			/* d. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b1 */
+			rdata = 0x0000;
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata,
+				       E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+			wr32_ephy(hw, addr, rdata);
+
+			/* e. Wait for 1ms or greater */
+			addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2,
+				  ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0;
+			timer = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+					 rxs0_rx0_adc_gain_adapt_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+
+				if (timer++ > PHYINIT_TIMEOUT)
+					break;
+			}
+
+			/* f. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b0 */
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata,
+				       E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+			wr32_ephy(hw, addr, rdata);
+		}
+		/* g. Repeat #a to #f total 16 times */
 
-	return status;
-}
 
-static inline int
-txgbe_e56_ctle_bypass_seq(struct txgbe_hw *hw, u32 speed)
-{
-	unsigned int rdata;
+		/*
+		 * 7. Perform ADC interleaver adaptation for 10ms or greater,
+		 * and after that disable it
+		 * a. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b1
+		 */
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		/* b. Wait for 10ms or greater */
+		msleep(10);
 
-	/* 1. Program the following RXS registers as mentioned below. */
-	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
-	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+		/* c. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b0 */
+		addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_intl_adapt_en_i) = 0;
+		wr32_ephy(hw, addr, rdata);
 
-	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
-	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		/*
+		 * 8. Now re-enable VGA and CTLE trainings, so that it continues to adapt tracking
+		 * changes in temperature or voltage
+		 */
+		addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_en_i) = 1;
+		if (bypass_ctle == 0)
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 1;
+		wr32_ephy(hw, addr, rdata);
 
-	/* 2. Program the following PDIG registers as mentioned below. */
-	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
-	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 0;
-	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) = 1;
-	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+		addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_done_o) = 0;
+		wr32_ephy(hw, addr, rdata);
 
-	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
-	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 1;
-	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 1;
-	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+		rdata = 0;
+		timer = 0;
+		addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_done_o) != 1) {
+			rdata = rd32_ephy(hw, addr);
+			usec_delay(500);
 
-	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
-		/* 1. Program the following RXS registers as mentioned below. */
-		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
 
-		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
-		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
-		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
-		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
-		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		if (bypass_ctle == 0) {
+			addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
 
-		/* 2. Program the following PDIG registers as mentioned below. */
-		EPHY_RREG(E56G__PMD_RXS1_OVRDVAL_1);
-		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_en_i) = 0;
-		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS1_OVRDVAL_1);
-		EPHY_RREG(E56G__PMD_RXS2_OVRDVAL_1);
-		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_en_i) = 0;
-		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS2_OVRDVAL_1);
-		EPHY_RREG(E56G__PMD_RXS3_OVRDVAL_1);
-		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_en_i) = 0;
-		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS3_OVRDVAL_1);
+			rdata = 0;
+			timer = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+					 rxs0_rx0_ctle_train_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+
+				if (timer++ > PHYINIT_TIMEOUT)
+					break;
+			}
+		}
+
+		/* a. Remove the OVERRIDE on ALIAS::RXS::VGA_TRAIN_EN */
+		addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+		/* b. Remove the OVERRIDE on ALIAS::RXS::CTLE_TRAIN_EN */
+		if (bypass_ctle == 0)
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+		wr32_ephy(hw, addr, rdata);
 
-		EPHY_RREG(E56G__PMD_RXS1_OVRDEN_1);
-		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_en_i) = 1;
-		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS1_OVRDEN_1);
-		EPHY_RREG(E56G__PMD_RXS2_OVRDEN_1);
-		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_en_i) = 1;
-		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS2_OVRDEN_1);
-		EPHY_RREG(E56G__PMD_RXS3_OVRDEN_1);
-		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_en_i) = 1;
-		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_done_o) = 1;
-		EPHY_WREG(E56G__PMD_RXS3_OVRDEN_1);
 	}
-	return 0;
+	return status;
 }
 
 static inline int
@@ -1978,20 +3009,42 @@ txgbe_e56_cfg_temp(struct txgbe_hw *hw)
 	return 0;
 }
 
-static int txgbe_e56_config_rx(struct txgbe_hw *hw, u32 speed)
+static int txgbe_e56_config_rx_40G(struct txgbe_hw *hw, u32 speed)
 {
 	s32 status;
 
-	status = txgbe_e56_rxs_calib_adapt_seq(hw, speed);
+	status = txgbe_e56_rxs_calib_adapt_seq_40G(hw, speed);
 	if (status)
 		return status;
 
 	/* Step 2 of 2.3.4 */
-	txgbe_e56_set_rxs_ufine_le_max(hw, speed);
+	txgbe_e56_set_rxs_ufine_le_max_40g(hw, speed);
 
 	/* 2.3.4 RXS post CDR lock temperature tracking sequence */
-	txgbe_temp_track_seq(hw, speed);
+	txgbe_temp_track_seq_40g(hw, speed);
+
+	hw->link_valid = true;
+
+	return 0;
+}
 
+static int txgbe_e56_config_rx(struct txgbe_hw *hw, u32 speed)
+{
+	s32 status;
+
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		txgbe_e56_config_rx_40G(hw, speed);
+	} else  {
+		status = txgbe_e56_rxs_calib_adapt_seq(hw, speed);
+		if (status)
+			return status;
+
+		/* Step 2 of 2.3.4 */
+		txgbe_e56_set_rxs_ufine_le_max(hw, speed);
+
+		/* 2.3.4 RXS post CDR lock temperature tracking sequence */
+		txgbe_temp_track_seq(hw, speed);
+	}
 	return 0;
 }
 
@@ -2001,6 +3054,151 @@ static int txgbe_e56_config_rx(struct txgbe_hw *hw, u32 speed)
  * Completion of RXS powerdown can be confirmed by
  * observing ALIAS::PDIG::CTRL_FSM_RX_ST = POWERDN_ST
  */
+static int txgbe_e56_disable_rx40G(struct txgbe_hw *hw)
+{
+	int status = 0;
+	unsigned int rdata, timer;
+	unsigned int addr, temp;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		/* 1. Disable OVERRIDE on below aliases */
+		/* a. ALIAS::RXS::RANGE_SEL */
+		rdata = 0x0000;
+		addr = E56G__RXS0_ANA_OVRDEN_0_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_bbcdr_osc_range_sel_i) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		/* b. ALIAS::RXS::COARSE */
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 0;
+		/* c. ALIAS::RXS::FINE */
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 0;
+		/* d. ALIAS::RXS::ULTRAFINE */
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		/* e. ALIAS::RXS::SAMP_CAL_DONE */
+		addr  = E56G__PMD_RXS0_OVRDEN_0_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_0, ovrd_en_rxs0_rx0_samp_cal_done_o) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		/* f. ALIAS::RXS::ADC_OFST_ADAPT_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_ofst_adapt_en_i) = 0;
+		/* g. ALIAS::RXS::ADC_GAIN_ADAPT_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_gain_adapt_en_i) = 0;
+		/* j. ALIAS::RXS::ADC_INTL_ADAPT_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_intl_adapt_en_i) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		/* h. ALIAS::RXS::ADC_INTL_CAL_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_adc_intl_cal_en_i) = 0;
+		/* i. ALIAS::RXS::ADC_INTL_CAL_DONE */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_adc_intl_cal_done_o) = 0;
+		/* k. ALIAS::RXS::CDR_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_cdr_en_i) = 0;
+		/* l. ALIAS::RXS::VGA_TRAIN_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+		/* m. ALIAS::RXS::CTLE_TRAIN_EN */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+		/* p. ALIAS::RXS::RX_FETX_TRAIN_DONE */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_train_done_o) = 0;
+		/* r. ALIAS::RXS::RX_TXFFE_COEFF_CHANGE */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_coeff_change_o) = 0;
+		/* s. ALIAS::RXS::RX_TXFFE_TRAIN_ENACK */
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_txffe_train_enack_o) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__PMD_RXS0_OVRDEN_3_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		/* n. ALIAS::RXS::RX_FETX_MOD_TYPE */
+		/* o. ALIAS::RXS::RX_FETX_MOD_TYPE_UPDATE */
+		temp = EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o) = temp & 0x8F;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS0_DIG_OVRDEN_1_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		/* q. ALIAS::RXS::SLICER_THRESHOLD_OVRD_EN */
+		EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, top_comp_th_ovrd_en) = 0;
+		EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, mid_comp_th_ovrd_en) = 0;
+		EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, bot_comp_th_ovrd_en) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		/* 2. Disable pattern checker */
+		addr = E56G__RXS0_DFT_1_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__RXS0_DFT_1, ber_en) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		/* 3. Disable internal serial loopback mode */
+		addr = E56G__RXS0_ANA_OVRDEN_3_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_3, ovrd_en_ana_sel_lpbk_i) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS0_ANA_OVRDEN_2_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_en_adccal_lpbk_i) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		/* 4. Enable bypass of clock gates in RXS - */
+		addr = E56G__RXS0_RXS_CFG_0_ADDR + (i * E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__RXS0_RXS_CFG_0, train_clk_gate_bypass_en) = 0x1FFF;
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	/* 5. Disable KR training mode */
+	/* a. ALIAS::PDIG::KR_TRAINING_MODE = 0b0 */
+	addr = E56G__PMD_BASER_PMD_CONTROL_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln0) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln1) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln2) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln3) = 0;
+	wr32_ephy(hw, addr, rdata);
+
+	/* 6. Disable RX to TX parallel loopback */
+	/* a. ALIAS::PDIG::RX_TO_TX_LPBK_EN = 0b0 */
+	addr = E56G__PMD_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	EPHY_XFLD(E56G__PMD_PMD_CFG_5, rx_to_tx_lpbk_en) = 0x0;
+	wr32_ephy(hw, addr, rdata);
+
+	/*
+	 * The FSM to disable RXS is present in PDIG. The FSM disables the RXS when
+	 * PDIG::PMD_CFG[0]::rx_en_cfg[<lane no.>] = 0b0
+	 */
+	txgbe_e56_ephy_config(E56G__PMD_PMD_CFG_0, rx_en_cfg, 0);
+
+	/* Wait RX FSM to be POWERDN_ST */
+	timer = 0;
+
+	while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx0_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx1_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx2_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx3_st) != 0x21) {
+		rdata = 0;
+		addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
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
 static int txgbe_e56_disable_rx(struct txgbe_hw *hw)
 {
 	int status = 0;
@@ -2133,8 +3331,13 @@ int txgbe_e56_reconfig_rx(struct txgbe_hw *hw, u32 speed)
 	 * 14. Do SEQ::RX_DISABLE to disable RXS. Poll ALIAS::PDIG::CTRL_FSM_RX_ST
 	 * and confirm its value is POWERDN_ST
 	 */
-	txgbe_e56_disable_rx(hw);
-	status = txgbe_e56_config_rx(hw, speed);
+	if (hw->mac.type == txgbe_mac_aml40) {
+		txgbe_e56_disable_rx40G(hw);
+		status = txgbe_e56_config_rx_40G(hw, speed);
+	} else {
+		txgbe_e56_disable_rx(hw);
+		status = txgbe_e56_config_rx(hw, speed);
+	}
 
 	addr = E56PHY_INTR_0_ADDR;
 	wr32_ephy(hw, addr, E56PHY_INTR_0_IDLE_ENTRY1);
@@ -2201,6 +3404,86 @@ int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed)
 	set_fields_e56(&value, 12, 12, 0);
 	wr32_epcs(hw, SR_AN_CTRL, value);
 
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 0x3);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 0x4);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
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
+		txgbe_e56_cfg_40g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0xf);
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+	}
+
 	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
 		value = rd32_epcs(hw, SR_PCS_CTRL1);
 		set_fields_e56(&value, 5, 2, 5);
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0e3d7649d8..02c3305712 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2054,7 +2054,7 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	if (hw->mac.type == txgbe_mac_aml)
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
 		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
 
 	rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
@@ -3206,7 +3206,7 @@ txgbe_dev_setup_link_thread_handler(void *param)
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 
 	rte_thread_detach(rte_thread_self());
-	if (hw->mac.type == txgbe_mac_aml)
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
 		txgbe_dev_setup_link_alarm_handler_aml(hw);
 	else
 		txgbe_dev_setup_link_alarm_handler(dev);
-- 
2.21.0.windows.1

