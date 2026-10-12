Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6390BCA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D9A04026D;
	Mon, 12 Oct 2026 13:05:35 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id F348D40041;
 Mon, 12 Oct 2026 13:05:31 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803127ta0723841
X-QQ-Originating-IP: QEh3DL0xJuAgQ1YPb4kQJH5bEbcIOq5843cw6ryPAng=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10750874073152099219
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 01/16] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Mon, 12 Oct 2026 18:56:18 +0800
Message-ID: <09B3AE9C35E25916+20261012110518.1911-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MXeHgLEcWKNKVZsUAAM3We2A3qhB2bgxdM6FBrj0230DbWQdH8RcVNkr
 p7X/1N89pVV/3YykWnHdF43YWA9vVU5X7nMUKhoYAm4UIf+5DEhhVWuPD7r1ISkwR7AMXuC
 k1rSFmisq5aExHQDNyEflcbbSbQsSTorUExNENovB5XwSB/M8BI7WbMOktHzzQLO+tVx7zB
 XW3wAh6YfS22R6k3c//NBmXw5geKUUGM3hrlLyzoXy5DuDIf7JiCtpVRljh2xw6bVH4aEJR
 LbNy3u0IQAye/ForI47xdCrbdaXdIypvYDRCos+gdDlFAGzaW0AKXD11C2h4+YyA4Xd/RJM
 jZj9ALZ8f399LszHydj7b32SxgYqIPS2f/XUHw+SfHUc1gInGbexiI3o6LB4p7uGE/z5UTI
 KWPjI/R5kPwS9dXolzhpxScu1xxaTq48j16A1kZgH/u8Y+woZbmlo7HfGkdXipse8/WWttI
 osKntZGbR+LFlI2tSnhIQrC51jwLJRf0+6EnQTpSj5YBxWWPfOHU8mneIhSVElgL622Gh3S
 SSl7A9dPfR/cLEVm+Np7+vX8dLXBecNkoajjmBL+F9W39FP6Myl1TtSZsOypWjpozek1eee
 iJUmrSJhJnmY6P672wVz5p8MPT9CTs7UHvOiuYZQHE4VrvaWq6qf3EW4S9iZU4LdXz8V8ul
 oJR9vxqIUKnVWIkCBpXY3L0aUiaKGi/EE2esq1vfmn/xNjYbSsmHBEolHJIraa0e3BT4/gy
 p+IIXEZVu4JGJGoXN60IYbmE5gw3EuLNRtYD/ND4UvesISgQgjGsfolKOOF50c4/d/UC9g8
 iiaoDsn+z8I5zT620Q/5wNpyNg+J+TQTkyqzGhsbGyJK/6WR7BFY3EJ9SmBuWwypwyRcFQJ
 KXxMZzk44iEmUPuwgOHEZCBg8TlHD5KTmofm+jE+haMe5+NUw3Aerg5/M/xua8ZJvPeQJ0T
 0/LiU3w+iWfaKaQIt1ay05HmBSbV6AAPsPyD8zIk/Wk+tWi/ixuWH+iyR9pdCoL/Uh61f5I
 oBcg+DWjw/TRWwW5u0TzFWpAZ3c/Qkcw7l4fY34j8i4QO0RN1PQ1aYxh6J/ww=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

Setting "port config speed 10000" on a 10G/40G dual-speed DAC cable
fails with LINK_SETUP_ERR, and the AN base page always advertises
only 40G.

Two checks independently blocked 10G:

1. allowed_speeds in dev_start was restricted to 40G, so the user
   request was rejected before reaching setup_link.
2. get_link_capabilities_aml40() returned only 40G for all DAC
   cables, so the link_capabilities mask in setup_phy_link_aml40()
   stripped any 10G bit from the caller speed.

Remove both restrictions so 10G flows through from user
configuration to the AN base page advertisement. On DAC cables the
capability is read from hw->phy.fiber_suppport_speed, which reflects
the actual SFP module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 15 +++++++++++----
 drivers/net/txgbe/txgbe_ethdev.c     |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..7c72b53f64 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -98,11 +98,12 @@ s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
 {
 	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
 	    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = hw->phy.fiber_suppport_speed;
+		*autoneg = hw->devarg.auto_neg;
 	} else if (txgbe_is_backplane(hw)) {
-		*speed = TXGBE_LINK_SPEED_40GB_FULL;
-		*autoneg = true;
+		*speed = TXGBE_LINK_SPEED_40GB_FULL |
+			 TXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = hw->devarg.auto_neg;
 	} else {
 		/*
 		 * Temporary workaround: set speed to 40G even if sfp not present
@@ -176,6 +177,12 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		return status;
 	}
 
+	/* setup the highest link when no autoneg */
+	if (speed & TXGBE_LINK_SPEED_40GB_FULL)
+		speed = TXGBE_LINK_SPEED_40GB_FULL;
+	else if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		speed = TXGBE_LINK_SPEED_10GB_FULL;
+
 	if (txgbe_is_backplane(hw) || txgbe_is_dac_cable(hw) ||
 	    hw->phy.ffe_set) {
 		rte_spinlock_lock(&hw->phy_lock);
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 0734a1c63c..d4c635dc2f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1848,7 +1848,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		goto error;
 
 	if (hw->mac.type == txgbe_mac_aml40)
-		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_40G;
 	else if (hw->mac.type == txgbe_mac_aml)
 		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
 	else
-- 
2.55.0.windows.2

