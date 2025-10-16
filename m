Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EF5CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B68FB427B7;
	Thu, 16 Oct 2025 13:19:43 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id A9CB440269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:41 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613577td58164f8
X-QQ-Originating-IP: AbHcbh2VphCnvY9FRBd8XrTvrOTMuPcqVp9uoMNsCcM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12710016537423324043
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 09/21] net/txgbe: add MAC reconfiguration to avoid packet
 loss
Date: Thu, 16 Oct 2025 19:17:23 +0800
Message-Id: <20251016111736.25372-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MknusLY5PWLKFvlY+ZQ2g9nGDtbzAvvUwftI01COzypbv4xNVAa8Zsjq
 E2kn0KSSRLKFTG13k1uY8cEZToz325M8k8ZgDy10xsrxi/owkLoIlt6LUEtTSo6ETbG10/8
 XpMSi2ozd6Fa1Q7yDU9OrqDRDdxIs1i4udFUR0dcYaGg2XDGXQxzcI+Ax2SqxNfoVDPAqxw
 5w6KdJeWOxnVZPrnwkzQ6DWEUa3NRN2aTutVyrQVM2dF6YPot/FID2JYEFWrgTmPLGL0r/L
 KiDcjQjsfwrApWdd4txaUD3XUyjW1KGf2O/UU/icDdrCBT3daK4nrM+Gm0Nq7FI5awdfkuC
 M8tP12dscoNy366SwHes8f3M8SAX/d7NI4Wqq/C1RO8gP+uck1tdrP5cQfGD+r9+8+D78p+
 mx/RAC497xc/tgnxmI0P6jxW3q4dUqB0sgmM8l8c7yYeO/1FNbl7LWjD0xXwy/7m8+Wovbf
 gEWcsusuHoyhrs0QawnqIagjkilmStA60TDlkuoZ5UmzLbQ+raTyZUlpJ8iaFUiW9NPSX+y
 n9swaTHnkZ9BADMySmeVs8TQNnGo8hhQVbF//lpHxFzXaWEKZtaUcOqh/GpNolu87G1J1Iq
 E55NMczNTLz4PNYdhHsw9icsgUhVUPYL5Lv1z1SaZkHOgoKWYIZcof+VtfaSGIaA+jjaO0M
 eo1WlpBW1vVazPmfpN7XvL0ouiE1leDhjlQEDCgcLGEWOmnO15E00Thjxjkj/wfOh5yY+Ac
 AmVqomegBn03lm4gpl5g4aI3TULuZRLXUXVC84Yo0ikYxG/Di1cbsmxWa3hZe0LrD1440zE
 mA9Muz49E0SqdmVnE/PrKBkCTNciZDdqKeDrYgbcR+wSQSiacmoQMUGIQO5PWLvTqf8SLrs
 506zdxrjP5Ab1b+psGw6AH1Lx1fOnLsA/Egeoczu17MGT0xzwsMkt2qSCCMtgxdAO353PlT
 +qy55uWDIPZNjrlil/tzbqZ+amU9BJ6mtH0bPzcIbMIEEtA+hcwuroJHTZalEOYO+vXMsNP
 fSzKtrW2kpxSswQElJB5SYKwkEmDYJ3qqiMoCYW3Dj1s+ZyVDS6xJCgppV+FFClrDrnrC8m
 Tx7pZ79okOG
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

There was a bug that RX will lose the first packet when down/up port.

When PHY is configured, mac error code is reported to the MAC layer,
and MAC locked this status without unlocking. As a result, when the
first packet is reveived, MAC reports this error code and RDB dismissed
this packet.

Do MAC reset can clean MAC error code so we can fix this bug.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 37 +++++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_hw.h   |  1 +
 drivers/net/txgbe/base/txgbe_regs.h |  2 ++
 drivers/net/txgbe/txgbe_ethdev.c    |  1 +
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 1fcc2feb98..6d3b917bbf 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -3504,6 +3504,43 @@ txgbe_check_flash_load(struct txgbe_hw *hw, u32 check_bit)
 	return err;
 }
 
+int txgbe_reconfig_mac(struct txgbe_hw *hw)
+{
+	u32 mac_wdg_timeout;
+	u32 mac_flow_ctrl;
+
+	mac_wdg_timeout = rd32(hw, TXGBE_MAC_WDG_TIMEOUT);
+	mac_flow_ctrl = rd32(hw, TXGBE_RXFCCFG);
+
+	if (hw->bus.lan_id == 0)
+		wr32(hw, TXGBE_RST, TXGBE_RST_MAC_LAN_0);
+	else if (hw->bus.lan_id == 1)
+		wr32(hw, TXGBE_RST, TXGBE_RST_MAC_LAN_1);
+
+	/* wait for mac reset complete */
+	usec_delay(1500);
+	wr32m(hw, TXGBE_MAC_MISC_CTL, TXGBE_MAC_MISC_LINK_STS_MOD,
+		TXGBE_LINK_BOTH_PCS_MAC);
+
+	/* receive packets that size > 2048 */
+	wr32m(hw, TXGBE_MACRXCFG,
+		TXGBE_MACRXCFG_JUMBO, TXGBE_MACRXCFG_JUMBO);
+
+	/* clear counters on read */
+	wr32m(hw, TXGBE_MACCNTCTL,
+		TXGBE_MACCNTCTL_RC, TXGBE_MACCNTCTL_RC);
+
+	wr32m(hw, TXGBE_RXFCCFG,
+		TXGBE_RXFCCFG_FC, TXGBE_RXFCCFG_FC);
+
+	wr32(hw, TXGBE_MACRXFLT, TXGBE_MACRXFLT_PROMISC);
+
+	wr32(hw, TXGBE_MAC_WDG_TIMEOUT, mac_wdg_timeout);
+	wr32(hw, TXGBE_RXFCCFG, mac_flow_ctrl);
+
+	return 0;
+}
+
 static void
 txgbe_reset_misc(struct txgbe_hw *hw)
 {
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index ab33d01966..bc34d639eb 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -107,6 +107,7 @@ s32 txgbe_setup_mac_link(struct txgbe_hw *hw, u32 speed,
 			       bool autoneg_wait_to_complete);
 s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw);
 void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw);
+int txgbe_reconfig_mac(struct txgbe_hw *hw);
 s32 txgbe_reset_hw(struct txgbe_hw *hw);
 s32 txgbe_start_hw_raptor(struct txgbe_hw *hw);
 s32 txgbe_init_phy_raptor(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 5b730bf749..23d39857de 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -158,6 +158,8 @@
 #define   TXGBE_RST_SW             MS(0, 0x1)
 #define   TXGBE_RST_LAN(i)         MS(((i) + 1), 0x1)
 #define   TXGBE_RST_FW             MS(3, 0x1)
+#define   TXGBE_RST_MAC_LAN_1      MS(17, 0x1)
+#define   TXGBE_RST_MAC_LAN_0      MS(20, 0x1)
 #define   TXGBE_RST_ETH(i)         MS(((i) + 29), 0x1)
 #define   TXGBE_RST_GLB            MS(31, 0x1)
 #define   TXGBE_RST_DEFAULT        (TXGBE_RST_SW | \
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 30c11b8743..10e088ee95 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3082,6 +3082,7 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 
 	/* enable mac receiver */
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		txgbe_reconfig_mac(hw);
 		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA, TXGBE_MACRXCFG_ENA);
 	}
 
-- 
2.21.0.windows.1

