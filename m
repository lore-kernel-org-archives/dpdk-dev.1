Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675EC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1352A41148;
	Tue,  8 Sep 2026 15:28:28 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 65438410F2;
 Tue,  8 Sep 2026 15:28:25 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874103t9f668b2d
X-QQ-Originating-IP: 7SqGHvBDAef+Hpyoi/Ov6TCrFUIEP7VBdgPz1CvHnRc=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17021909549941151299
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 15/15] net/txgbe: align link capabilities and DAC
 classification
Date: Tue,  8 Sep 2026 21:26:00 +0800
Message-ID: <C39E6B1D6F94FC5E+20260908132742.2661-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrkGtizlZui2uXMhsN+OCi567WyoB3HoG67Es5D2vTIqGQ9pOXt1iphn
 PiFB4Ri8/mkKMr9rpTCj8c/j3X8ZNqWaJvbSPb/+RnHtdbTxmbpdCnieud5ct3MvK4xEUCq
 AulHStiZb8vSBP5xdLpD7h3fr22BfXfweBpT4Jrd2ShiLJQw9Lv4UXAXkQHeAVuF3zXEQmK
 TQhv54Qbv7v3yzpviWw5TWP4ZJAgR29pdf3XqnscPNU+oRlouwAAcma6rxWzv+6EBEd27yP
 zo3rtmUcGJS5d+3Gd4HA2447rKTR/3FhgrcFtWY/F3eebWQ3FH4Sr5EYfdYCDq1ne54PvU+
 i2yx454KdSzKJ9l3Heonc+LkIzTxWXw4QJT9Ku+HosLHEvN32qguSWoB1wsFDjZ8oZgLVZe
 sagrfGe3MU+gRg45v1ixdf5mjDONBVZWzTc5slPgiZzxd6dlTRE1CyJcZTp63Gnxom/6R9X
 tiEX0R9KW/YwsRToTpaGiGQ3gYliM9RPXDde27enihxu9PCMnhYyOPwN/PjLgVKMTuGuLQD
 BM8fNJjUEpVj4pW+nRlG6UigCcXIXLXRk+dKNr62xvWpP5yvmuqP6bDrqFAdDcMh/DMzH2L
 MnkWy8wl8CP0StwJKPZGopDaQNx2nxjVdH2HW8PnEf+JrEhZ39nGKbanj3AFrg7WbLpRj4/
 EpfrRMf5LD8D7lUM4Dt3n3NZLLjyYOYqJ2ZfgsOuTlsFKRWHsgbhswdVqmDTB19B5ul9XkO
 CdEdWCwQuqtZjsc5QkhNBwa9wC+G/+pXvwHA1fOdfmibx9j/uMlmPSl8TYPK2w38fO9aj2e
 chUMty7nhnlAJA75wE/UH07D85FEe7OCwARVCjAbO5/T+QORatd8x+fvOMsuxs23aQwIfO6
 VSwzt5rDfFvg8qyaZ6vWCuV5tR4BOOfI4wVjCJFkRAH14K+NcOS5Yd79TIsavptLSw/+pJ5
 D5+7BMQfObxUcctEcZ1i/NyVGNlMHc2E3gCwoHKCff2uHbFHiS4gqcngQzLe5SbYAVmE14U
 au/TdKm0WBZ6pmGDSpAjYQo2dSGQEebj/jw/U1ukVwhxxQ66cCevzV7hWZW1wjWquEHQwVC
 6MppNysdkMJ55ejgnbeZ2zC0EZZxjD5llHv6wdTwRQIv4iMKTz0KbuQ539IstjVYNaXWFWf
 K6fKw2Jsl9nyLu4=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

An active DAC can be misidentified as a 40G optical module, in which
case the driver reports 40G and enables autoneg for a module that
does not support it; DACs and optical modules are also treated
differently in the FFE, CTLE and capability-report paths.

Rework the AML40/AML link capabilities and DAC classification:

- Port the five-branch capability layout to AML40:
  backplane, DAC (txgbe_is_dac_cable() plus the 10G-only AN-off
  case), multispeed fiber, 40G QSFP and 10G SFP. Modules previously
  misreported as 40G through the fallback now report the correct
  speed and autoneg.
- Add the 40G-active transceiver identification (sfp_type enum and
  identify branch). Like the kernel driver, 40G active cables are
  handled through the optical path, as SFF-8636 byte 131 bit 0
  ("40G Active Cable") also covers active optical cables.
- Unify DAC classification on txgbe_is_dac_cable(), including the
  40G FFE selection in txgbe_e56_tx_ffe_cfg() which still
  open-coded the qsfp_type_40g_cu check; the 10G active cable type
  (da_act_lmt) is no longer treated as an optical module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   |  3 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 74 +++++++++++++++++++++++-----
 drivers/net/txgbe/base/txgbe_e56.c   |  9 ++--
 drivers/net/txgbe/base/txgbe_phy.c   |  7 +++
 drivers/net/txgbe/base/txgbe_phy.h   |  1 +
 drivers/net/txgbe/base/txgbe_type.h  |  2 +
 6 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index ac80d85f08..fe4becf198 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -103,8 +103,7 @@ s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
 		*speed = TXGBE_LINK_SPEED_10GB_FULL |
 			 TXGBE_LINK_SPEED_25GB_FULL;
 		*autoneg = true;
-	} else if (hw->phy.sfp_type == txgbe_sfp_type_da_cu_core0 ||
-		   hw->phy.sfp_type == txgbe_sfp_type_da_cu_core1) {
+	} else if (txgbe_is_dac_cable(hw)) {
 		if (hw->phy.fiber_suppport_speed ==
 		    TXGBE_LINK_SPEED_10GB_FULL) {
 			hw->devarg.auto_neg = false;
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 2d3b32839c..512b8ba331 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -95,27 +95,77 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 	return 0;
 }
 
+static int txgbe_is_40g_fiber_qsfp(struct txgbe_hw *hw)
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
+static int txgbe_is_10g_fiber_sfp(struct txgbe_hw *hw)
+{
+	if (hw->phy.sfp_type == txgbe_sfp_type_srlr_core0 ||
+	    hw->phy.sfp_type == txgbe_sfp_type_srlr_core1)
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
+	PMD_DRV_LOG(DEBUG, "port[%d]hw->phy.sfp_type = %d",
+		    hw->bus.lan_id, hw->phy.sfp_type);
+
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
+		/*
+		 * 10G-only DAC cable: legacy build-time AUTO=0/1 default
+		 * mode forces AN off. DPDK equivalent: devarg.auto_neg == 0.
+		 */
+		if (hw->phy.fiber_suppport_speed ==
+		    TXGBE_LINK_SPEED_10GB_FULL &&
+		    hw->devarg.auto_neg == 0) {
+			*autoneg = false;
+		} else {
+			*autoneg = hw->devarg.auto_neg;
+		}
+		*speed = hw->phy.fiber_suppport_speed;
+	} else if (hw->phy.multispeed_fiber) {
+		/* multispeed fiber must come before single-sfp/qsfp fiber */
+		*speed = TXGBE_LINK_SPEED_10GB_FULL |
+			 TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = true;
+	} else if (txgbe_is_40g_fiber_qsfp(hw)) {
+		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = false;
+	} else if (txgbe_is_10g_fiber_sfp(hw)) {
+		*speed = TXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = false;
 	} else {
 		/*
-		 * Temporary workaround: set speed to 40G even if sfp not present
-		 * to avoid TXGBE_ERR_LINK_SETUP returned by setup_mac_link, but
-		 * a more reasonable solution is don't execute setup_mac_link when
-		 * sfp module not present.
+		 * Unknown / unsupported module: keep 40G default to avoid
+		 * TXGBE_ERR_LINK_SETUP returned by setup_mac_link, mirroring
+		 * the temporary workaround in the previous version.
 		 */
 		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*autoneg = false;
 	}
 
 	return 0;
diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index 8e986daf96..f996113ab8 100644
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
index 10df23afae..e52f1da87d 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -1156,6 +1156,13 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
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
 
 	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
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
index 39a70746a7..91771b9cbd 100644
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

