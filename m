Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30721CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839F540DD8;
	Tue, 30 Sep 2025 12:00:48 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 6BD5D40E17
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:45 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226439t5384a980
X-QQ-Originating-IP: IVGRkMqNuIZSIW5tzi+Erw57e7OlnDpb/3JIDypuLFg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11078994436134679667
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 09/20] net/txgbe: add MAC reconfiguration to avoid packet
 loss
Date: Tue, 30 Sep 2025 17:59:41 +0800
Message-Id: <20250930095953.18508-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OeFOmPvKThpBdXqavVjzFL3ZB28qLHl+A08VJTxMfem/UtDuwkcr5eW8
 MvLAAgABQSdXhAVU4vhH44UaWBXIxp+GUKRkXtwr5NiFOzEXDMyQdzA8xvkoJBZkzu4v5Hy
 CqcbItrDu2Ak01YzBblPxUSkHURZTxvJvzqIBHMfXE+8IOqnASpFdw02nr7Ygy3MNtrqxa2
 RTSOnkm6KFknkn7eZRHb9iGrt8Rv7NjyFNdKHKTLnPR5E09JCaqjkz0lopXRkqfCyL4ysCY
 inNNiyuNPlhg4BHMRiecDqrTYuBTNJBPzNWlcETT/Wby1RrGZmngDxpF9Ms74oFXvgRuoPH
 ZV91xmUcRkpGSFIEM0LvHjNrf/pnpfdwP7UtJJXGYKgxUMcqdaP+0oJFE0ejefh9qnZohJv
 +FGwS2w8qCCwl47AE4yiH2WbdXU0yWAKrihmwpwIjxlIldMVLVLnr8HZGgx9Jmpj1hRffVt
 u+qPcbwoBCccOP0bYj2hqPDY3wO/Lein223k2bMhQxOZFdrtEZUZycZ3wLcxmCQ+zgY5FXO
 o4Up3qhHYC1wJ/THD2rRt1DPMKFps/PrvQxvjLiVolSarVE3NJ0qgQfAYpgUfeMscjVzlZj
 nCJqguAkx+RuStH4QL6D2Wuf5KUkMb+LQcEUTTORc775KuyIiRHY0pApDutoFA24cyGUWOG
 s1dSNZ1XC5iIlvhRyQhVeXwZjbwpZKIj69kN8kHg4zvwmp2Fa6Vd7KI7sRPPtjl58DOHf1O
 MCrHyWcWiIjP38miZXeJOqhTg/q/aeEkHUU5+eHl47hUz21o7vmql80B5aUX1bjCgAoS6i3
 62eqx57zQ6Vp/uixtwAkgztpBxwt3GZ74ZBbWEW381KsouG0DQKopG3e32sm+dVkR1lQSz7
 NOWmZ9s4xdB5oh5t+HDa9aZQ3hIGZHKwJhGPXD7u0Uh9LyrTjiB3Q4OldRMeh+nIp6LXz8R
 HyNRAzvVQ7IxUIEbon8mHlvh8YVkFe8hsSVIVWaYpRRnSjLQbasvchVWZTRVIGQLsqRRPl/
 pu4+jrPtq/x0kQyj5/XL1s3SVT/pVPo/P9nyPhHvOUWx0V7YpnjWNgI2OmgQFuuQsye0k+B
 AZ9OA8K+cBf
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

