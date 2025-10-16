Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C431CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81376427B1;
	Thu, 16 Oct 2025 13:19:42 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id BB6B941153
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:39 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613574t9cdcbe05
X-QQ-Originating-IP: WhmPYQEDbRLdbf+sMTns+JVbYD1XWMWMOOIAwZlCiqg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17956881559382924056
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 08/21] net/txgbe: add hardware reset change for Amber-Lite
 NICs
Date: Thu, 16 Oct 2025 19:17:22 +0800
Message-Id: <20251016111736.25372-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MPrO9VV3SNd/F752JLzsHVYIw9fgV3LkcUgfFDKvjhNfyTgxOQySIJcF
 JesjF7fvPIxmTfKmtaPFBpALMeMJJGq271VR83TU0CqdbYodzDqure+sxH51m/NkFVTvHkZ
 aeXdnfrQPeatvoxv18eaQlBMqgJqaiYQ3rNZBy5LBBW5r7+UCwx2GjOz5hr6JNGLSaxDGfB
 JjWfRQb2q/Jl/eAR0UxZ3rgcJF7H5fRUljvV+o9OEpx4gOZDN0bajFXrQ87CSfc2OIo9J/+
 5j3zjJ2v3wSn3wD36Xblc+80+3GOITz7sBfFaDUbWzkAUlOmPDJlDwC6t6iDEUCmGgLhubF
 /QI76cp3ItB8gw0rpF7fhV0CFo9EW2p66s1ioIzspPHmizw5iGJ7ugFXlfzRkwMxerBjLt+
 4N/6ixGkCqz1dkI9dLd/7WGlAR/Nnn5p0Xzr4IpigaDK8toJyuZ5i3oXOHhPs5dPZNMyyPC
 CVbI9EKFLIhZ6mXMtM73/zjlfGMzS86lwKxAWMHqy+Gy0tVsdjLuphmxttahiBSHiijGqxx
 K+H67b7rfHGwqRoeMxeWtAq+ZcL2K5E0xRyjkLmLbZvmDVWYF74oqAan17gjqvhvvD32YJR
 2luUiX7WjEgL+pYFnyWwBmMZZkd9Orb5AoqNDunXlpDGFTrf7qHnyGKkjCAIWW4fqRo/6Dr
 iqQSBhc7ISXmGc1aEv3F+1eFpNsrzHaSBTDE0KsAJp2aW8gw0McOxWjvN1KIIPUdJLKtJ30
 uqBL4Y3Ype63IWy9rlO28wNKBIsaZhkMnvSSLdwpn4KshNZxsLt74LHFsmt1wTnXqZ+SIFP
 0tH+TwN9ADO7NdMSHwhf6+FQpESJWJjBkjaV9MIIdegf2zJ3RmSfetDFomQqYxAMdui3Gq1
 CsiyTsWnQzOC9/bArR7v9WLYKxR+36r8+2ze1u3N5NVc3iaJnDXakjEsd9cSNM02flablpX
 /2DY3ItXl5g8oMvOHsYcOvWKofpODSaybcQ3yyoXWc95tgh5JXo77flzD/dyyNdnPBESruF
 MS1QhxVBVlSQVTonG0LeWxWshmBRR6hayeBLDgaI3XzLe2HweuVYkGPcMF4nHpeBtaLAEpu
 KKiFb8PpzxymTTeO1nDgnk9pjngrpgWhA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
 drivers/net/txgbe/base/txgbe_hw.c   | 64 +++++++++++++++++++++++------
 drivers/net/txgbe/base/txgbe_regs.h |  2 +
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index be8409c28e..1fcc2feb98 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -276,6 +276,8 @@ s32 txgbe_start_hw(struct txgbe_hw *hw)
 	/* Cache bit indicating need for crosstalk fix */
 	switch (hw->mac.type) {
 	case txgbe_mac_sp:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		hw->mac.get_device_caps(hw, &device_caps);
 		if (device_caps & TXGBE_DEVICE_CAPS_NO_CROSSTALK_WR)
 			hw->need_crosstalk_fix = false;
@@ -3507,13 +3509,37 @@ txgbe_reset_misc(struct txgbe_hw *hw)
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
@@ -3576,7 +3602,7 @@ txgbe_reset_misc(struct txgbe_hw *hw)
 s32 txgbe_reset_hw(struct txgbe_hw *hw)
 {
 	s32 status;
-	u32 autoc;
+	u32 autoc = 0;
 
 	/* Call adapter stop to disable tx/rx and clear interrupts */
 	status = hw->mac.stop_hw(hw);
@@ -3638,16 +3664,28 @@ s32 txgbe_reset_hw(struct txgbe_hw *hw)
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
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 93cc222339..5b730bf749 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1238,6 +1238,8 @@ enum txgbe_5tuple_protocol {
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

