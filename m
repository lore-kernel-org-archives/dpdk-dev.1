Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18BC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:52:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C9C040E96;
	Wed, 25 Jun 2025 14:52:14 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 52D3440E20
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:11 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855927tbca0e642
X-QQ-Originating-IP: 0cVolAiLbas+WGdtxME6YATOjXDOJ8KZz8HAK3WeM7k=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9684397094894164873
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 08/15] net/txgbe: add MAC reconfiguration to avoid packet
 loss
Date: Wed, 25 Jun 2025 20:50:40 +0800
Message-Id: <20250625125047.18072-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MtZ4zLDUQmWfnV15Fl4f4ib4Xm8mXOIUOZKZMnkkdb2Ge9H+HDeZMy/M
 FjXOy+Ewuj4poLuFa6K+V0eALYXOKnXVWGJYLk83+9wkfxm5WvtLw/GfYUabLduzZRnNCQD
 3PNYiDbAYGFq2iqOP5Qs1ATeS8mcHYPTSU+RJQhcStqXRKEvuaRwgE8tW2hfono2ycKILvi
 JfUzojVn6FLw2xxfrnAsusigD0A0ak/qBGR1DYlXJDoX1ZOnWx+wW3Nufkf6mRzyfch27cT
 kWwKrmMxzCuDB73YPMQHs0knliZS+8fu8YpNb9zuCzLNCZ65aE9Z5CiPG6T1klANNgZ7ofL
 nI4QaL4GXMpUJXiD2iP7KCUsbSXK7dqAMtMDUBJs3/dH8oepMyhcY7sO8bQ9NLyN5q+45D5
 8N/3la66IFx1ENP0xT23k/w201uOG3EelP2e2CBMuSyUh0owEN421anmF3mYrLL9VqSQZ7O
 azeMJMQsRT+7eMTsx3uccq+oLwR68n3Vh96kLB46YB4UKZDW2OPKJc1BgrjjIUogkgU9W/Q
 frvNVCdJ4VDYHDM8uHBWseOf2xHkBxRMGvdRJ/zEdrITKNiz5zw+QbmPabr3q+c3CgabB0g
 50NOO8R3GMuV7ZKAyyow27+jCJJnZTVpN8cMCZEuQriWoP/Bvw9ahP6uY2a9c8EAMcZBqY1
 MYkr7wmI+2iGNmXxvIkbP/bBcSQRQ8uodniCIQx7ywsVAfTzoQlmW/QMefTRFIAlU2/MiNI
 7mNspwosUlQ8ICUt/RFgTe6eh75jpM4bUE0atG+5+UMYNiv5ueL75dB2oixicfDhArDBCnM
 33PskWDmyi+JbIpio5jOn9zjajwD26hsl8PilPo72r51X/aB0+d4SbgntYmvhiN0nn2Yfsu
 ui3qHdKqWfXXVSxrLwQMe0DB5fPS20gmeLZDVh60scDpjFELNNbE4s8bW3hFgUuJwRVX3gH
 k8xATqYlhCXSPF7wlPYFw+AVriGBcnxa1bb91Zb0pK8wXDw+U7h47KKRQqhORx8m5GRGcSY
 2pbk3fAZPHtHYWVGxSY7FFBLSSlsYC0znEBrc3FqkQ1L+XIY8Uq0vvIAkU74Lbyd/GGS89o
 w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index f82bbee6f0..4f93c28280 100644
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

