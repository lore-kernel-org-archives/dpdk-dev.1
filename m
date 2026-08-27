Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC63DC61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5413D40664;
	Thu, 27 Aug 2026 13:44:30 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 8920B40664;
 Thu, 27 Aug 2026 13:44:27 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831064tc8752c69
X-QQ-Originating-IP: NOsNmqE5C9HvQSnPxIIIBrxs1ZR+/9YLJ1tiG/2h3B8=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4285178209834649056
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 13/13] net/txgbe: align link capabilities and DAC
 classification
Date: Thu, 27 Aug 2026 19:42:05 +0800
Message-ID: <98EF76FFB223FF98+20260827114309.10530-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M8X+OvqqReHCSQ+Srs6G7dLxQ9wgTMo12hs7SwH75Q1X62IkOcnRVW1I
 Qf8/iebYLcCq8+ZHZTZDNwBqsAEsH07lLSS9i8uSV7AfjmSvvMD31iWHISQT0szOAnoqFhp
 iqMquZ/PNC50xdTbiyheq3toGLfI9xRwwkm6kwABSI87ayuvjrBxr6/W+Kr1Y1KR4Yh7OW3
 QbkFVS9KER1OCqEi8GRzMgJyPF4wp9BUo04+3frhUkakiHC1iisJf5plqPEfay1E6bvDjtu
 HtiwitHnC+iL7Fhzv+7XufzeeE6NDFVU85J2NlfTV8OspOsAZc6unnWGyBveB4vCrpCqRwC
 54rv+ure96nEVyQIYVW6RnCFJEYlH4ptbJ/LgFFtpVfsRn98dTWf2X3DtDuyCPKHc9nXUca
 nLnY2N96HN/tRJjT6u0TrfL3HZwQciKcfjvPvzU4undi9jJcqvYhYg6T1E01XzdB4Tj2CKs
 32JQA8o5p+xepZFlafIGSuYZnAfBIpJ5tFK6B++qolCUB79YPt4ddMy8snJ6JeEryQQe2iD
 aBKU91bvRuE01ja3l0GZgHKFUKnGO8Gt9rwRGBdcRQ5bY/XcsYi/jOfdM6/1ONat8p3vo5h
 9kPojH6hjcq/3nddMXae+HzVUex/S2LvKhSUBzGGXSBazSDvyHD+DeEF1j15k1g6wm4HfHn
 NqCtW02+Ma23cDtX11ZaODU7rULMa5SA+hWrozzUboBO6YftKXTbvnIlExA4EcfSUjHCSdW
 UjLP3XPJ6qtmGuKzJQDpLuOP0enybzqfDfZCSTfOoxGav7QZgbAXMSMba/YkKvqyzSR64IK
 70pDgCzYA5zVuUDtI8ZgxLlZuSfnpegwJ9dDp26imtuRzR1UMuok2TbiuQxWjQg1JJ9uqbi
 Ym+1oR49lOtSMa+LBK1kfCXB2qw7FUHep5jUoyelWig/DLlQxXWTcVlvc4KYdfe9+apaSp9
 4W/VnUo7cOq+PqVVTq0U5tB9r7VW3L5SR69o+X9AGzCJTC9X/zebiZ2yTbgGMaLy/TYw8KV
 zhV1FO+7mj8/UP74AokZ4huEMS1rRUqAealOLVyMfah/NCb+lYN1cCR0kB+aOjz1o7n8P3S
 JT1Uzne2mEfdEco78c3dYpobrP14aijKgJTgdH1rzpcS184Jkmgud1hkwuGhVIz9Q==
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
  identify branch).
- Unify DAC classification on txgbe_is_dac_cable(), so active DACs
  are no longer treated as optical modules.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   |  3 +-
 drivers/net/txgbe/base/txgbe_aml40.c | 71 ++++++++++++++++++++++++----
 drivers/net/txgbe/base/txgbe_e56.c   |  6 +--
 drivers/net/txgbe/base/txgbe_phy.c   |  7 +++
 drivers/net/txgbe/base/txgbe_phy.h   |  1 +
 drivers/net/txgbe/base/txgbe_type.h  |  2 +
 6 files changed, 74 insertions(+), 16 deletions(-)

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
index bfb8a4bc7f..b4371921cd 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -95,26 +95,77 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
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
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+	PMD_DRV_LOG(DEBUG, "port[%d]hw->phy.sfp_type = %d",
+		    hw->bus.lan_id, hw->phy.sfp_type);
+
+	/* Backplane */
+	if (txgbe_is_backplane(hw)) {
+		*speed = TXGBE_LINK_SPEED_10GB_FULL |
+			 TXGBE_LINK_SPEED_40GB_FULL;
+		/* Backplane supports autonegotiation */
+		*autoneg = hw->devarg.auto_neg;
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
 		*autoneg = true;
-	} else if (txgbe_is_backplane(hw)) {
+	} else if (txgbe_is_40g_fiber_qsfp(hw)) {
 		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
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
index 8e986daf96..cc168a9f81 100644
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
@@ -2622,8 +2621,7 @@ txgbe_e56_rxs_calib_adapt_seq(struct txgbe_hw *hw, u32 speed)
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
index a5df015a4d..b00f00931c 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -310,6 +310,7 @@
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

