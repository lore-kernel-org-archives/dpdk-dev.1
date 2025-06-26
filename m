Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64803C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A33E410DD;
	Thu, 26 Jun 2025 10:09:30 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id DF80E402CD
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:28 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925365t463a2472
X-QQ-Originating-IP: FU8+Uzh46/niA/SR5hPa5ZVOpPBPmYc2dwXKxNIsrfI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12167034886793374072
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 07/15] net/txgbe: add hardware reset change for Amber-Lite
 NICs
Date: Thu, 26 Jun 2025 16:02:12 +0800
Message-Id: <20250626080221.22488-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M0oOkQfwkJeFfj2a1s6aBf1zLtNaYYfaoygHrcQ3wRcE25bMarFmXn51
 fOXxMWWNm5tPN1/P482j11LCNuqsqRhbE6Pl2KScsgZwIMP8d3vjMvVwQxO2MnWFQZd7+lD
 XsVRzwtmKmeZkpHKvlFOH2iJrLsLB74+MU/D+gW5GmPO2Ggl/i8sHiaehoiFV10JmYRCtqU
 IJ0xwhwo39b62f/g/1wZjRL7Gz9QnH1p/Ch5hQPqxk6KPs3+inWV9/LSOVRLvphWBeFCyse
 x9UektasG/zgtYFJWI45hbgw83UZP4MSTu3EbaWBglGUH1Lcx1ylDFZ2/G2THH7vP1FuoZF
 g8QbGTIcIR66xmjKH51Ux0HKy9l5FXyktdU7rUwlxxFK9Rd4n32Tn4DJFmRv9+6nlMPVMfj
 RZB2YAbqUXiR7uCSQDLjPw4I5JPPkFVesAW4xU8of8MFm9/NMmg65ESvUZP672m2SFpqTCd
 Cdp2CPGYUv+4WD/S/1unQByd0tYnTbqYLs39+rlU17bTgLSJxKv/qZ5ZXRnacPrJHKFVjFd
 ZwyArdxOrip/DNQpVybRk/5lv1qF0GS4vpuMoU3mPLmXJIuBqX2dyD6FIsbbkdgnamcVob4
 DFkm4rbme/wx/NybffqJ9bBA6tlzr6lBvwSRImYGUr95o01ATYn8vYAEjaZWuDAmrSnqEvF
 kRGSGaTe9EjM8gBfMWCONKwWRnUoRPrUVbAS+229aihfiAY/qBbT1OCX/0yRPGwgRP31VdA
 Ia4sQ6bKRDMtgyZhIKABKqiITuzfWEbPsEaZEFUv0tzcViBuuBeDW6Hn0fL3tRyXFTCtiAJ
 GyRiM7BxA/50ZvcdNMgKyHREgwQn+8OAa9Xgd+0etelibC2hgd8m7dSf0xW9LjbKTUy7J20
 g7IKiBAK1AHu+ErY1ChjHFFJD1ry7vnOqJsFMVvKtDvC0QwsEphKlu2hkZ4T1JC0vCo9gz6
 XPQnfPiHKnz1YG+kipnbuohG1ptgdvgP+3j0+MjVjrgyMBn0/t+dfrkBmmGU+qlrvSml20j
 RBDd/Lyj4tFuBcfVQdFw6wvxt9FkRMbFvlwn0E1BYR+NgDfcrp
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Add necessary configurations for Amber-Lite's hardware reset
process, which differs from the 10G NIC's. These configurations
may be modified in future to accommodate further changes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 74 ++++++++++++++++++++++-------
 drivers/net/txgbe/base/txgbe_regs.h |  2 +
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 4fc4b4e284..86963fd078 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -267,6 +267,8 @@ s32 txgbe_start_hw(struct txgbe_hw *hw)
 	/* Cache bit indicating need for crosstalk fix */
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		hw->mac.get_device_caps(hw, &device_caps);
 		if (device_caps & TXGBE_DEVICE_CAPS_NO_CROSSTALK_WR)
 			hw->need_crosstalk_fix = false;
@@ -3500,13 +3502,37 @@ txgbe_reset_misc(struct txgbe_hw *hw)
 {
 	int i;
 	u32 value;
+	int err = 0;
+	u32 speed;
 
 	wr32(hw, TXGBE_ISBADDRL, hw->isb_dma & 0x00000000FFFFFFFF);
 	wr32(hw, TXGBE_ISBADDRH, hw->isb_dma >> 32);
 
-	value = rd32_epcs(hw, SR_XS_PCS_CTRL2);
-	if ((value & 0x3) != SR_PCS_CTRL2_TYPE_SEL_X)
-		hw->link_status = TXGBE_LINK_STATUS_NONE;
+	if (hw->mac.type == txgbe_mac_aml) {
+		if ((rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK)
+						!= TXGBE_EPHY_STAT_PPL_LOCK) {
+			speed = TXGBE_LINK_SPEED_25GB_FULL
+			      | TXGBE_LINK_SPEED_10GB_FULL;
+			err = hw->mac.setup_link(hw, speed, false);
+			if (err) {
+				DEBUGOUT("setup phy failed");
+				return;
+			}
+		}
+	} else if (hw->mac.type == txgbe_mac_aml40) {
+		if (!(rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK)) {
+			speed = TXGBE_LINK_SPEED_40GB_FULL;
+			err = hw->mac.setup_link(hw, speed, false);
+			if (err) {
+				DEBUGOUT("setup phy failed");
+				return;
+			}
+		}
+	} else {
+		value = rd32_epcs(hw, SR_XS_PCS_CTRL2);
+		if ((value & 0x3) != SR_PCS_CTRL2_TYPE_SEL_X)
+			hw->link_status = TXGBE_LINK_STATUS_NONE;
+	}
 
 	/* receive packets that size > 2048 */
 	wr32m(hw, TXGBE_MACRXCFG,
@@ -3569,7 +3595,7 @@ txgbe_reset_misc(struct txgbe_hw *hw)
 s32 txgbe_reset_hw(struct txgbe_hw *hw)
 {
 	s32 status;
-	u32 autoc;
+	u32 autoc = 0;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = hw->mac.stop_hw(hw);
@@ -3596,9 +3622,10 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 	if (!hw->phy.reset_disable)
 		hw->phy.reset(hw);
 
-	/* remember AUTOC from before we reset */
-	autoc = hw->mac.autoc_read(hw);
-
+	if (hw->mac.type == txgbe_mac_raptor) {
+		/* remember AUTOC from before we reset */
+		autoc = hw->mac.autoc_read(hw);
+	}
 mac_reset_top:
 	/* Do LAN reset, the MNG domain will not be reset. */
 	wr32(hw, TXGBE_RST, TXGBE_RST_LAN(hw->bus.lan_id));
@@ -3629,16 +3656,28 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 		goto mac_reset_top;
 	}
 
-	/*
-	 * Store the original AUTOC/AUTOC2 values if they have not been
-	 * stored off yet.  Otherwise restore the stored original
-	 * values since the reset operation sets back to defaults.
-	 */
-	if (!hw->mac.orig_link_settings_stored) {
-		hw->mac.orig_autoc = hw->mac.autoc_read(hw);
-		hw->mac.orig_link_settings_stored = true;
+	/* amlite TODO*/
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_LINKUP_FILTER, 30);
+		wr32m(hw, TXGBE_MAC_MISC_CTL, TXGBE_MAC_MISC_LINK_STS_MOD,
+			  TXGBE_LINK_BOTH_PCS_MAC);
+		/* amlite: bme */
+		wr32(hw, TXGBE_PX_PF_BME, TXGBE_PX_PF_BME_EN);
+		/* amlite: rdm_rsc_ctl_free_ctl set to 1 */
+		wr32m(hw, TXGBE_RDM_RSC_CTL, TXGBE_RDM_RSC_CTL_FREE_CTL,
+			  TXGBE_RDM_RSC_CTL_FREE_CTL);
 	} else {
-		hw->mac.orig_autoc = autoc;
+		/*
+		 * Store the original AUTOC/AUTOC2 values if they have not been
+		 * stored off yet.  Otherwise restore the stored original
+		 * values since the reset operation sets back to defaults.
+		 */
+		if (!hw->mac.orig_link_settings_stored) {
+			hw->mac.orig_autoc = hw->mac.autoc_read(hw);
+			hw->mac.orig_link_settings_stored = true;
+		} else {
+			hw->mac.orig_autoc = autoc;
+		}
 	}
 
 	if (hw->phy.ffe_set) {
@@ -3646,7 +3685,8 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
 		msec_delay(50);
 
 		/* A temporary solution to set phy */
-		txgbe_set_phy_temp(hw);
+		if (hw->mac.type == txgbe_mac_raptor)
+			txgbe_set_phy_temp(hw);
 	}
 
 	/* Store the permanent mac address */
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 7830abac7b..e24bd1eb03 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1236,6 +1236,8 @@ enum txgbe_5tuple_protocol {
 			TXGBE_ICRMISC_LNKUP)
 #define TXGBE_ICSMISC                   0x000104
 #define TXGBE_IENMISC                   0x000108
+#define TXGBE_PX_PF_BME                 0x0004B8
+#define   TXGBE_PX_PF_BME_EN            MS(0, 0x1)
 #define TXGBE_IVARMISC                  0x0004FC
 #define   TXGBE_IVARMISC_VEC(v)         LS(v, 0, 0x7)
 #define   TXGBE_IVARMISC_VLD            MS(7, 0x1)
-- 
2.21.0.windows.1

