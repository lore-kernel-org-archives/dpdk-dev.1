Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E3CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D351542EA3;
	Wed, 30 Sep 2026 12:21:27 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 80EAA402A2;
 Wed, 30 Sep 2026 12:21:24 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763681tb5d2179f
X-QQ-Originating-IP: tYkrSXNRfTQKmeThEtWKNo/yrTr9YFtJP8k3GClmSkE=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:21:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6858181022039217863
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 15/15] net/txgbe: align link capabilities and DAC
 classification
Date: Wed, 30 Sep 2026 18:18:02 +0800
Message-ID: <39895C63A61D2EF6+20260930102042.2214-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NovCFWrsOaVAsPnsB2PJUMtG124Kg2IWAd6f6Xyj3BGPdfZUSDLbhOOE
 86Ql0ViXCHIw4l8giu/OSyl7M4ccgfEFa4MEyEPt7WKcNuFYNwdrZWGofLy+gKrUDKQ8ySj
 iT+dm01lxUsfbfQgz2XYgiQNca2ynKtpSoU1Qk5E36Q2X4ma53Zsq6bYzrmBEgieE5Lu+NK
 J5apP/LAYLwMPul0CWVt2nbymzpPGpLBK/vwgc763geXlg+wz2tovfOU3OrN/mlFSWmILHi
 Gh+x58awVAq6Mn9a6I6jH5KzUfvFe2TMjymTRkbEhZlUJFH0Edomkpz5PmttTMfnHRH+Hir
 NjaMevJIf0RrJRnbLR4BMsUOx5atDaLhZ+OI4IGtH+azGG71r+CLWyLcK0i1mYBOY3ZJi6W
 OnwB8gLBYOopJs/TfkjlV5EaJXQQojq6HqUUNRWFSz/vie2nd0pLPzirf0/6l+tjJcjCbKQ
 XdPTH55rCpEIynl8cMi28MSilM88KhOoBAMhy7sx7lc4D0Uctg1HfBPlrFqvmoDDifEMHj5
 jJBKBDoHuVCV1newoywi6kxPEZxhd7Wa23NbgYKlbqoHEQfFXJrZ/rEaMKxB84fYCAI8MSV
 NccrmB6G8GwmWTR/ADre60l0PNM9hp9QPbP+q0H4X1QuoM+ujumvu21mOZ2E19WlxUPHZ6m
 LHQlCtIYkG2Y6UH5GxkGR2202mNDBy7aKut7fZf/qF0YxXP2JzJkNZSc4aX/12RO+4kPJai
 /Zy8X8Tuob+jxGTppOkwArl5JIzmllDuCX8VmhDf1yyBMHWareGqZ9j0hbBGeki9ojRyypH
 Je4q8Ds0LHcWG6AozSfDk48NlRDdcsXuGyxmuVCUNU4fsSjHV60H15zIVMg5X0r3p5l16cB
 gZIUdwbR6+Lm18Kmb2OP3PEx8FCqVbk4tX403EVF03s7PnjVo20WUMH1I/N3QB+eeI6qWVj
 2Wxp5+cLWOOFn8BPdaraolIbwPKkGE2o8TWXn9yl3ZdSAXKbfqBuSCCk86H/sVYJqaxKmuJ
 DeW00qqRvpAaX1sLWntzBo9a44QYtaRLA0zQd7wUCXrzVy6XdazFme+m4ignEw9dwErfrWf
 fRFJJ+aa2bZG5JGx/BgBC3uitvtS6RmuIi+fCmfg1VN
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

- Port the four-branch capability layout to AML40:
  backplane, DAC (txgbe_is_dac_cable() plus the 10G-only AN-off
  case), 40G QSFP and 10G SFP. Modules previously
  misreported as 40G through the fallback now report the correct
  speed and autoneg.
- Keep the bp_auto devarg unchanged when a 10G-only DAC disables AN.
  The XPCS AN gate queries the current link capabilities, so a
  subsequently hot-plugged AN-capable DAC is re-evaluated and can
  enable AN73 again.
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
 drivers/net/txgbe/base/txgbe_aml.c   |  4 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 64 ++++++++++++++++++++++------
 drivers/net/txgbe/base/txgbe_e56.c   |  9 ++--
 drivers/net/txgbe/base/txgbe_phy.c   | 19 ++++++++-
 drivers/net/txgbe/base/txgbe_phy.h   |  1 +
 drivers/net/txgbe/base/txgbe_type.h  |  2 +
 6 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index ac80d85f08..f3d7c9f04a 100644
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
index 2d3b32839c..f0456341a7 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -95,27 +95,67 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
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
+static bool txgbe_is_10g_fiber_sfp(struct txgbe_hw *hw)
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
+	DEBUGOUT("port[%d] hw->phy.sfp_type = %d",
+		 hw->bus.lan_id, hw->phy.sfp_type);
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
index 10df23afae..11d38db4ba 100644
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
@@ -2421,10 +2428,20 @@ int txgbe_is_dac_cable(struct txgbe_hw *hw)
 
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

