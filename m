Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81555CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:20:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E6C841109;
	Wed, 30 Sep 2026 12:20:55 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 2C1BA40278;
 Wed, 30 Sep 2026 12:20:52 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763650tfb147497
X-QQ-Originating-IP: SIDteIH9pfYoNfdZZOTa/JZhYCVesT2MhKmWBQnkq4Y=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9634341227819843059
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 01/15] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Wed, 30 Sep 2026 18:17:48 +0800
Message-ID: <8E3E2DAA2EF61450+20260930102042.2214-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWth7vBa++Gd3WzN8N215hTi3iy6s6pMiUEazXIHvrvviU27Bg/ZHIrU
 mTFF9pcgZP5NhKvgNPGTV80bF4uAzrOHHBjg0KtxYiacEjlB4SStWb++zPkQC9iQ4OzoNlX
 TbQaM9oRrKOBkgTUnyURoSaCK7pk3gfK4m74CgXybrLte+S3LoxyeXhokVO8nkcr/olYrgy
 3HsEnypwXYliqWJ/HBpD3a7xrBpqmkvvXckipxi22On7d1Coovsz+srnR01P7C3Gy+16Pv9
 uUqpAASdwvpa2Tl8ComxTvJJ4wKcQc6UnyQg5/HNRD+0XHhPPvo2Qvb5fbHF/GQ6ZsiB+H7
 c9qZEcX3JzRMpgYCoKc+CBeD7uqgFCe3boDMvYYwDl0+q4BGrK7T+i0iWTBQTd4fNlb3Wnd
 gJ7/9ap/pg5+1H+tUZ+PgwytqGKeYercB5UB6gblR3u1VK8PwdutRN8NmdWevyOk7f1ZoBU
 0E9JMz4EXfXonLyF35Kk3EvJWlWkU9PGRENipCtullaUiAbA1OWLe9BlBXT1pqBASkkkzFz
 H6MPrhkcBNq/XgzlY3rYaFERYnQ8mf+8yjN4ew9zmhmbpqiNcNTird7fOU+PbpahrFOpqPY
 Df7XaRrW3O33xJMe30UpDhdj9EInQjnEA964cBDYiEnvAt3RHqTxQim9Rea711T2xojMpKe
 udVh19D061lqIzWXgKG4rK22ToQ9oQySBOABJcXLFOtByt7lG4jHR7CjF4ect5vWq3wn6jw
 fAPF7nrtwT/2U0buztcr3ImnmlwOLgevo0kfZ6C6N544yrhD1UEcRrO0HLNxBYCSUe6MxV7
 sIsOTimeREHXWyQBLWdApRzWmqfu5qE+Nogqo/p/HKXB6gQQa4Ulx/rr6YSpGJAwobL9E3G
 d/gYcEMDeebAvkVG9zK6oc7yvnMVZwlP2PgMDhcngcZSXKG1nmDueZWgreKXi/6B74oJkea
 lv0+cdJohcEzlEDK9nDvfeoQbnKKh2bBr80c1PGacJP9S4q7fz8IWArzkKk0ozalg4PsZRj
 /ynHQI27bPgSR7TI+7gUshwkNRWQpIjs7NUGejWYScIwdguGNfBTX4S/vlsXAf/g4nscxky
 w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

