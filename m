Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5B2C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE8EB40E2A;
	Wed, 25 Jun 2025 14:52:12 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 4A42940E20
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:08 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855923t1bea2fb1
X-QQ-Originating-IP: qyftzhUr22GgtjXZYMWLAAsSQiMJ5h6pleT+MHgNCq8=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12942310947383824369
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 07/15] net/txgbe: add hardware reset change for Amber-Lite
 NICs
Date: Wed, 25 Jun 2025 20:50:39 +0800
Message-Id: <20250625125047.18072-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OaJsKcI5/4cBgqIGKjoEOfnl0e3yDXglBnYUO+PBEHOIVPZGjiprRAXy
 f8UII2XXuSBIvjTTxM6MBQaGNGnq6aCvWDuW4nu4z/zhU2qKu+FYpKiGpiAEXEH2s1CXuth
 P7GamU9nDe6BdOFdlWY6p3kBNlD9XtY167HgU6bl90XlL064/EbgCjgkK+897DPJhth6qDk
 LR1rJLmiGFHqu10fWfKLxjTuFv2ySYbh2Lz2nAYG/7Qh6N5D8QXWd+iyMexi7iqkFyT/pSY
 6h9PvCv7ie/aOjGV89GE3TewhHG66qLJzWxk6JbZwUkSNjPOO+XkX9e/jxL1ilelCkVvhry
 13SLVVbCFkafY6AqToDtzfNXbTXZQxzmp/cBvKju+xzHkSqehbMUH1Uuv056JuQp6iSPQXy
 gbNciWEuNP4tFiGfkHpsj5Kbg4XsJvD1pmOZOZ5rz+IFNx/5BlRG0q34/1mHco2HOW0w2+6
 ji5321q2kj8k/1wG9yej7zF23Eq2gVIq8Bmtr7O5GgiFUMZow6vgj0ftkEQ9oQKjL+GxSye
 Qo/EAtbv1zL9Ok8+7qJxJyor+1raTUohVzQ0yizhs2QRB94Bw0eZ+oSOCWRIc2ONOpU4fPB
 6sU0TFYwaacmM2UkX/wiObLpP6ssGAE2dMy2/b4qOvo0Jbj+4iVl0ItZ/y0PZXhkM+iRfqY
 LkqzDGIbTykKsc64QHIkxNG/oRYWcVZLoG+nPcup6l7jGj6C97nw6ffnpGcNdt4UVfCZTZn
 8dnyYKA8EIWeVZPPQlUBUmqwd/msDX3GuB+tMOYxvt5YcCHgSDPUMfzQIU9ADMELL2H3hka
 y2iY1LdLQJK6z13PveOmViwy3dPE3ESZThp91ZcKSEqUQzS7RjCRiWf+OafJ0F/A+6kkN73
 G43VWLPMhfY7DW7uZpMszLgkuqBkDlZh+4VtUj4odvjqUedc8a6lkMNqQvgEBq4J+gXDffB
 oTZFEblm11BUpfJwuDqeEqQfARnEcdOrb8FmRrnaQ0Mh9t1rGDAm3+edkNxthyjlSEUyHet
 uMsqIlTZQy2x1IyVXgVcv9S94j0pMJBoRv61IJA3dkJ5Vw6Ah/+Tir/xTwQhE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
 drivers/net/txgbe/base/txgbe_hw.c   | 72 ++++++++++++++++++++++-------
 drivers/net/txgbe/base/txgbe_regs.h |  2 +
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 4fc4b4e284..f82bbee6f0 100644
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

