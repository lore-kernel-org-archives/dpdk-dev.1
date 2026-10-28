Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50856606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A0F24064E;
	Wed, 28 Oct 2026 11:40:42 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id DFC4140685;
 Wed, 28 Oct 2026 11:40:39 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184033t62701f45
X-QQ-Originating-IP: IegmxwFBxb7km7bXEosEl3MsalFnjmDvawYT9Q+pCq8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8312561232047199292
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 15/17] net/txgbe: align link capabilities and DAC
 classification
Date: Wed, 28 Oct 2026 18:34:04 +0800
Message-ID: <99E0BBEA292DD7D4+20261028103913.10188-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NngTBkazz0bhLvrLDeFM59D0MCC9tA2VQtrRkcmI8YtFhVzOBcRwWqkt
 i0UJ+a4BHUc5iGT3FYh4UaxflxS1p8jcRzLSR2F9fgY7egkqZyXalryxsFtoSPQxXlFWvfH
 LhMYJ5QDHiwk/+/QJB9ejWFFKxDTFQyUt6bXpasnUcdmP60NoDHpmB+x3+oAlvXSzec/sxE
 Y4IJjWO7ANWDif4oU7+WuFvjM27XMNWnFqLEW/T/2XhLuDgXVxweyFcMAYvoYLjQGDevlKU
 P1/bsrZL7BjYBZssH9GH96kdppDiRWlyHu/KonOwmW3Q6oOrwS0ZPEpGs/JABePzw0I8jLe
 7KALzGLUt9yZO9Qunam1uFS3iet/9vGy61fJxd3uMpo96w6GUZkPPAvmnjHoltwac3lLjjD
 1x1u2EpKozcm9Hi3Ew7keJBoDE4VDES4Hv7lqPiVEl43obot8yMR76IKGi7KxrPqtKF68fv
 hiyseNwTbrfFFUV74ic3098SqGz6C4AeryeyK3A0oGEjI68e1PRzGk68TXoFFYvXF+u6/sc
 c1hXVqjIYykCYKXzrID9/fpOOIEmHRGqZCUfqzMBZrUrGeRwHnOsJ5AIyfJcEl80douoSiF
 Ew1y4klat03sb6D8OS1PJ+iuHS+ToB4lXwo0F33MpOL75Ovd2DY0DOIZg19RD4cR0gPLHGP
 cFB1RvpyKqdquK/hyXCm5wxW1PnQP8r4FYjEVz8008pRFmAMUhSgheAQL6vCI5HAOP5QTjf
 DVKs9SYc7v2Z9KD9LwrNiAJxIZ+2m6R5JrDPMnb/rrKPL5yx+IT9VSTn0bSV/fs90OGg04E
 t329DNBwVG+YZeilOKszgc+S+imJZMqpav4HzyXmI2BydlsRvNiqz+M99NEFbO2uKYSgp7U
 nwHvG2W72TRwBpJWUU0JJDNrtCrbnNb2IXAGKOejNqqzzORP2PyHcOmJX0iSmLdziO6NOyu
 DdjIbGouADK/zTR1u3lWXYenLzPCJ2B6Hca28N+f1FyV6GG9CQOX3cWMfkvZphy/dJeTZYn
 sXs8H4tNoPvTlckHwGQcgenYE/uVd+qKlt/Xr/an84w7fy9qyfsfmugHE0jgJc/SbrdW8Ad
 MrTOHjKpfUsfqT5mmCpVm8tnRYwY3y1ag==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
  identify branch). 40G active cables are handled through the optical
  path, as SFF-8636 byte 131 bit 0 ("40G Active Cable") also covers
  active optical cables.
- Unify DAC classification on txgbe_is_dac_cable(), including the
  40G FFE selection in txgbe_e56_tx_ffe_cfg() which still open-coded
  the qsfp_type_40g_cu check; the 10G active cable type (da_act_lmt)
  is no longer treated as an optical module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   |  4 +---
 drivers/net/txgbe/base/txgbe_aml40.c | 33 +++++++++++++++++-----------
 drivers/net/txgbe/base/txgbe_e56.c   |  9 +++-----
 drivers/net/txgbe/base/txgbe_phy.c   | 23 +++++++++++++++++--
 drivers/net/txgbe/base/txgbe_phy.h   |  1 +
 drivers/net/txgbe/base/txgbe_type.h  |  2 ++
 6 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index de4db31cf8..8ee4c1264c 100644
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
index fc8b92e976..a415c8f4a2 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -99,23 +99,30 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
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
index 4ba69ed4df..c671dfdcc2 100644
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
index d65a50530f..b030275141 100644
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

