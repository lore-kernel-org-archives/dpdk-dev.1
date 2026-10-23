Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57938606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:09:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 368B640B9A;
	Fri, 23 Oct 2026 13:08:34 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 08EEF4069F;
 Fri, 23 Oct 2026 13:08:31 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753710t5bff2349
X-QQ-Originating-IP: veCfard9TE0FeNR0CIFk1dILOEci1DOuncTQqcxo258=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18066706152305081697
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 15/17] net/txgbe: align link capabilities and DAC
 classification
Date: Fri, 23 Oct 2026 19:03:53 +0800
Message-ID: <1FB0837079480D37+20261023110728.3975-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NYq9vJSNdMF2ePwqN07mcNc8snlC65Mvi7VGvwWy1/tPk9+Sm+6vWIo7
 vaiAY1PFAQHprFjEpTXyjVF8QehsHjCFkLU5A9pjsMSAWrfSt8hWJa2VDCHZ7cmSkELJRE+
 9kR7ZFfA3mCUjW0OojB//wXgv/t6p5Rq5mvTpb8UipZPb2a2A3HkrcTCWdU8mbsK9YnUkpr
 Nb1UPUrvEGgD71Ul5rS+dJ2ZZB0vdC0FAYQRZzTUCBjsfxYNi5RZSaGojfgC325SGRzlDQb
 4eDTZo1LgCYl4zEeifhlb1Fu62tGROBvE5UV5OTHUQ8/JhJIvuLWzn3irrpatqbWk1hVRrT
 9lt3lUrVPuQtqtk80jPT+EznwOImoEiwuvCtX3WlcLwNMpXW4IwRxaOHIJj/fzKggarbPcG
 0mlnD6n4jJupLZRkFrUTqYfuMj9H/Huxr4hnu04fH65rpwRfwyrolOEbrULo9Aci59In/0G
 OpVct6Z2+lMbX4ryEHcBTM5CugIYTIEBpwUlOrvIKIZLmDSM6gKewquemPuoocaLhP09JT6
 pinN+UD9LXO4xqhoyt6kqSpAFD6OA8Y8l3qkgQhqAlKr/J9tnXutP7J1lE9jmluy3KIxf2G
 lGFWwzCZABwB+f8ybDRPm+TcLYEEg634fC9KmCR2BgCD9ynv80I+oySHiW/M22OXRQxh3hV
 xlSSqNx0AhV0xbf0JygyLydqc9B7JNRdXzIsepLznI6YR3immpHA/aek57gZvODbpGdiKUQ
 7ShgqhRhhgQkLaJEYpBFfCWkle/NN0GtENNwW5nYkcb1h1X1vG33Z5GIYGXm6rlsy3KTi4i
 Gv3K2akIZYHucmQh/yKV8t+P8VB5txGAVWpeSQnM7TDQA/qv7kCgsEtM6jIhfBQGOGWKhRW
 dzcWqZMw68978HD+bUGsCg556lPRAdrEMR+XE58rPj9Q09+Fce+quTYBUr6ROq5ipvH9Aph
 fo6J7H/9mc4UOJtNOJo8PlEjnXjrlWbZ6g6jzkPXMv/QHHz7qTO6Cy+ttn13P+FBWKUdf/8
 flmu7bGxL4U3g/HRlGmyVVJOFAJOA9OeBgVyzf5g5NUQ4R9qrV8EZU8Ar847ZertZWHswKP
 S8HNN6UJoNWlP0Fhr92fCUfynA/vCnWOfl67EiBlx+H
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A 10G active-limiting DAC on an Amber-Lite 25G NIC has no
fiber_suppport_speed value, so the capability path rejects it. A
10G-only passive DAC can also retain a stale 25G bit after hot-plug.
DACs and optical modules are additionally treated differently in the
FFE, CTLE and capability-report paths.

Rework the AML40/AML link capabilities and DAC classification:

- Use the detected DAC speed in the capability paths. Assign 10G for
  passive 10G-only and active-limiting DACs instead of preserving a
  speed value left by the previously installed module.
- Keep the bp_auto devarg unchanged when a 10G-only DAC disables AN.
  The XPCS AN gate queries the current link capabilities, so a
  subsequently hot-plugged AN-capable DAC is re-evaluated and can
  enable AN73 again.
- Add the 40G-active transceiver identification (sfp_type enum and
  identify branch). Like the kernel driver, 40G active cables are
  handled through the optical path, as SFF-8636 byte 131 bit 0
  ("40G Active Cable") also covers active optical cables.
- Unify DAC classification on txgbe_is_dac_cable(), including the
  40G FFE selection in txgbe_e56_tx_ffe_cfg() which still open-coded
  the qsfp_type_40g_cu check; the 10G active cable type (da_act_lmt)
  is no longer treated as an optical module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   |  4 +--
 drivers/net/txgbe/base/txgbe_aml40.c | 49 ++++++++++++++++++++--------
 drivers/net/txgbe/base/txgbe_e56.c   |  9 ++---
 drivers/net/txgbe/base/txgbe_phy.c   | 23 +++++++++++--
 drivers/net/txgbe/base/txgbe_phy.h   |  1 +
 drivers/net/txgbe/base/txgbe_type.h  |  2 ++
 6 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index 7a0839a7d1..ae5c7d7f0d 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -103,11 +103,9 @@ s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
 		*speed = TXGBE_LINK_SPEED_10GB_FULL |
 			 TXGBE_LINK_SPEED_25GB_FULL;
 		*autoneg = true;
-	} else if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
-		   hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1) {
+	} else if (txgbe_is_dac_cable(hw)) {
 		if (hw->phy.fiber_suppport_speed ==
 		    TXGBE_LINK_SPEED_10GB_FULL) {
-			hw->devarg.auto_neg = false;
 			*autoneg = false;
 		} else {
 			*autoneg = true;
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index b28eb5f8ff..a338880345 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -95,27 +95,50 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 	return 0;
 }
 
+static bool txgbe_is_40g_fiber_qsfp(struct txgbe_hw *hw)
+{
+	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_sr_core0 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_sr_core1 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_lr_core0 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_lr_core1 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_active_core0 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_active_core1)
+		return true;
+
+	return false;
+}
+
 s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 				      u32 *speed,
 				      bool *autoneg)
 {
-	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
-	    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
-		*speed = hw->phy.fiber_suppport_speed;
-		*autoneg = hw->devarg.auto_neg;
-	} else if (txgbe_is_backplane(hw)) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL |
-			 TXGBE_LINK_SPEED_10GB_FULL;
+	/* Backplane */
+	if (txgbe_is_backplane(hw)) {
+		*speed = TXGBE_LINK_SPEED_10GB_FULL |
+			 TXGBE_LINK_SPEED_40GB_FULL;
+		/* Backplane supports autonegotiation */
 		*autoneg = hw->devarg.auto_neg;
+		return 0;
+	}
+
+	/* Fiber or DAC cable */
+	if (txgbe_is_dac_cable(hw)) {
+		if (hw->phy.fiber_suppport_speed ==
+		    TXGBE_LINK_SPEED_10GB_FULL) {
+			*autoneg = false;
+		} else {
+			*autoneg = hw->devarg.auto_neg;
+		}
+		*speed = hw->phy.fiber_suppport_speed;
+	} else if (txgbe_is_40g_fiber_qsfp(hw)) {
+		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = false;
 	} else {
-		/*
-		 * Temporary workaround: set speed to 40G even if sfp not present
-		 * to avoid TXGBE_ERR_LINK_SETUP returned by setup_mac_link, but
-		 * a more reasonable solution is don't execute setup_mac_link when
-		 * sfp module not present.
+		/* Unknown module: report 40G so setup_mac_link() does not
+		 * fail with TXGBE_ERR_LINK_SETUP.
 		 */
 		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*autoneg = false;
 	}
 
 	return 0;
diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index 279c9740c1..f966faf56b 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -73,8 +73,7 @@ u32 txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed)
 		pre2 = S10G_TX_FFE_CFG_PRE2;
 		post = S10G_TX_FFE_CFG_POST;
 	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
-		if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
-		    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1 ||
+		if (txgbe_is_dac_cable(hw) ||
 		    txgbe_is_backplane(hw)) {
 			ffe_main = S25G_TX_FFE_CFG_DAC_MAIN;
 			pre1 = S25G_TX_FFE_CFG_DAC_PRE1;
@@ -92,8 +91,7 @@ u32 txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed)
 		pre2 = S10G_TX_FFE_CFG_PRE2;
 		post = S10G_TX_FFE_CFG_POST;
 
-		if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
-		    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1 ||
+		if (txgbe_is_dac_cable(hw) ||
 		    txgbe_is_backplane(hw)) {
 			ffe_main = S40G_TX_FFE_CFG_MAIN;
 			pre1 = S40G_TX_FFE_CFG_PRE1;
@@ -2622,8 +2620,7 @@ txgbe_e56_rxs_calib_adapt_seq(struct txgbe_hw *hw, u32 speed)
 	u32 rdata = 0x0;
 	bool bypass_ctle = true;
 
-	if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
-	    hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1)
+	if (txgbe_is_dac_cable(hw))
 		bypass_ctle = 0;
 
 	if (hw->mac.type == txgbe_mac_aml) {
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index decfcbadd6..896fe7eecf 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -917,7 +917,7 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 				TXGBE_LINK_SPEED_25GB_FULL |
 				TXGBE_LINK_SPEED_10GB_FULL;
 		} else {
-			hw->phy.fiber_suppport_speed |=
+			hw->phy.fiber_suppport_speed =
 				TXGBE_LINK_SPEED_10GB_FULL;
 		}
 	} else if (comp_codes_25g == TXGBE_SFF_25GAUI_C2M_AOC_BER_5 ||
@@ -938,6 +938,8 @@ s32 txgbe_identify_sfp_module(struct txgbe_hw *hw)
 			hw->phy.sfp_type = (hw->bus.lan_id == 0
 				? txgbe_sfp_type_da_act_lmt_core0
 				: txgbe_sfp_type_da_act_lmt_core1);
+			hw->phy.fiber_suppport_speed =
+				TXGBE_LINK_SPEED_10GB_FULL;
 		} else {
 			hw->phy.sfp_type = txgbe_sfp_type_unknown;
 		}
@@ -1158,6 +1160,13 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 			else
 				hw->phy.sfp_type = txgbe_qsfp_type_40g_lr_core1;
 		}
+
+		if (transceiver_type & TXGBE_SFF_ETHERNET_40G_ACTIVE) {
+			if (hw->bus.lan_id == 0)
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_active_core0;
+			else
+				hw->phy.sfp_type = txgbe_qsfp_type_40g_active_core1;
+		}
 	}
 
 	if (err == 0 && hw->mac.type == txgbe_mac_aml40 &&
@@ -2430,10 +2439,20 @@ int txgbe_is_dac_cable(struct txgbe_hw *hw)
 
 int txgbe_xpcs_an_enabled(struct txgbe_hw *hw)
 {
+	u32 speed;
+	bool autoneg;
+
 	if (!(txgbe_is_dac_cable(hw) || txgbe_is_backplane(hw)))
 		return false;
 
-	return hw->devarg.auto_neg ? true : false;
+	if (!hw->devarg.auto_neg)
+		return false;
+
+	/* Re-evaluate AN support for the currently detected module. */
+	if (hw->mac.get_link_capabilities(hw, &speed, &autoneg) != 0)
+		return false;
+
+	return autoneg;
 }
 
 /**
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index a06c0eb04e..552fedadab 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -316,6 +316,7 @@
 #define TXGBE_SFF_ETHERNET_40G_CR4		MS(3, 0x1)
 #define TXGBE_SFF_ETHERNET_40G_SR4		MS(2, 0x1)
 #define TXGBE_SFF_ETHERNET_40G_LR4		MS(1, 0x1)
+#define TXGBE_SFF_ETHERNET_40G_ACTIVE		MS(0, 0x1)
 
 #define TXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
 #define TXGBE_SFF_SOFT_RS_SELECT_10G		0x8
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 33e306ac70..a1ce78623b 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -249,6 +249,8 @@ enum txgbe_sfp_type {
 	txgbe_qsfp_type_40g_sr_core1,
 	txgbe_qsfp_type_40g_lr_core0,
 	txgbe_qsfp_type_40g_lr_core1,
+	txgbe_qsfp_type_40g_active_core0,
+	txgbe_qsfp_type_40g_active_core1,
 	txgbe_sfp_type_not_present = 0xFFFE,
 	txgbe_sfp_type_not_known = 0xFFFF
 };
-- 
2.55.0.windows.2

