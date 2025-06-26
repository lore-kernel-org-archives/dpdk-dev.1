Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1E5C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CECEE410D2;
	Thu, 26 Jun 2025 10:09:36 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 05DAF410D2
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:34 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925368ta97e5fc5
X-QQ-Originating-IP: gn5kvSDYs8/a6ZvNTqzcwysbV4HlQ8P7q00qQgNuTls=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12249877686514714464
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 08/15] net/txgbe: add MAC reconfiguration to avoid packet
 loss
Date: Thu, 26 Jun 2025 16:02:13 +0800
Message-Id: <20250626080221.22488-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OW9waqWeaK7pDHNxailvVoryJf2lL1iKqf+o4b2SPEu7hZuYfKmkN2DI
 FvFvzzXAU/J2I32nWoR6wEMmHAKp2csCZtlMOH+nn2p75yWR4AL3olwGjIVNKEfdSj98xD5
 E2bij4jJi13DQTu0cKSJ8fN4Yz2dLz1JHIma5YLGF6oopvlNHlVuc//aVeeGeet0BlrQtLT
 dt+lq/rG8I5BayrpU5BbDaD//E0OxjNn+Hf9lkB5T3eeq+txOu7OrwybMpYCd6WKlWuPOi/
 AppBfjDWnsXzttRTO366wUSQJd+RJqAAdN+2jzl3zDWOBpc68DjzRIEvSFFOi6foyJM1e+l
 XX00ucWenHY5dmr0kpcWkZJwumw0qhLWGeyAJgC39UFhYc8iSMhA/iCHIWBEvwnT95LjbR5
 bvknuhNwhuhWu2kor4lliWokboffyV7hNFf/T++FYkY6T8HbmOM4x6MSG7WznP2b47t+I1G
 D7sOnW4aFbLeIJ11R9j2oeVIvIWvKEx0Ag4e/cGiUssK2kB4Ojm/KjxYb+UVKtunEHGE1yR
 VPQVqTtv1O//3Yc2yDKqQDwL28xu5II+P54yAXB+3ZMP02wUe26R3zrDzwsP9N9p/r3S6Xb
 TJGO3cG3hCKwzdXNxyTUT8ivk7dI91pjnDWZ43apnKOznd9lojlyLHOOrse042iyB71VF6K
 RMhRsmYzUBgzomkrNOnT3E7aLvmi//MtfI1A3ZyjKcBvqae+SSXZ5kfhsVlN3CcVoaqkkiz
 R6b1is/vhsZscx2hywsGajWiHY1mvhoeq2L7J8pPh5tMoJyAhGku0eyYQrMrXTG83rPIXH7
 i6lLjgoBH1tWoToJlIZy6O470IarM2Owz0MyW8+tLm7LRPwxbXZuQzTNvGykhOPjK+GtSzs
 BaJoGcUjDfHQEoXy0NSUWqDQVA2CKYpFAIVJcv5mMyd5ERZ4or4INf6fC5pZKVMvRxbouwU
 btWcdKgOKcitqE18TaVpLCww+gY96x0LtNw+b/CYPje7Ui9UWIkO+S3knvHnf+I8aSRyk4q
 EEewV0ZCJR/WPRFUgtXsCKeJgXu1su/CC31fkS46QWvgEk9sdxG/19IOS92K5rPAR/wK2Vl
 g==
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
index 86963fd078..8eae816164 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -3497,6 +3497,43 @@ txgbe_check_flash_load(struct txgbe_hw *hw, u32 check_bit)
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
index a7e9547430..1356878575 100644
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
index e24bd1eb03..7ee7712e53 100644
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
index cba1e8f2a7..a854b40b9f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3081,6 +3081,7 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 
 	/* enable mac receiver */
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		txgbe_reconfig_mac(hw);
 		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA, TXGBE_MACRXCFG_ENA);
 	}
 
-- 
2.21.0.windows.1

