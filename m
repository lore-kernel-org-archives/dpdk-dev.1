Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3EC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8355140E30;
	Tue,  8 Sep 2026 15:27:54 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id B7EA640DF6;
 Tue,  8 Sep 2026 15:27:51 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874067t424d03fe
X-QQ-Originating-IP: rF/uewlt7Myihd/f4MM9nTuhMZPiKe0koW7ePCQ9WLo=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9297883961754170583
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 01/15] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue,  8 Sep 2026 21:25:46 +0800
Message-ID: <7DF0CA28C1B0520C+20260908132742.2661-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MTyvyLqh9yTfh6TOq2vZwjPO7P5y/8oed5VKpqDQUFOUGczEIOrfExkr
 p7pwxBJuf0kd8/KrDB9QyBAPmfZqnrmgTic9QRlWoGzPeDo4P3u4pkvfGheKwoTz1ymIVw5
 +RGWC2tIP1cTl0v+OTL9/8mepIBwsuUT5qfojPkMqnqeynfGwFmSthSDRyTrESuPW5oDQPR
 VeuZe33W7PGQpve9TkipA2DeB+WN/skNFJZjtC2Isvupv21WrHv846uwtOnjIvaVFUFxNkp
 dnhTxqxcHp1F4KhXI9dOVed6FJLiAXd+7sqZSzXE9hjE+NuOhgDgShKQZL5TJF54GZiBvWq
 zGMsjh7QF3lzNzCsU/Y36JszlnSilSaKBGhOPgvinWcuPxPFDE9a+ibQXEAhIInfpDMKiMY
 JXRE78aQcmLd4eCZ4gswSK7sz25M4kWyoQFKtibECJUQDpDUIJZXAitXQA8vH7Ex4zq9Ma5
 d0oHbwUH7rycuQ4VrxMd81R5hLNlCaLwgwynHVpqV8HwPfjfv05MXBtm4k5Prp1je/+qpae
 yAQ7BCs8i8vF0vcxyAnVEVKRzWyJgG8Jhwnw6CbS5/IdSBtIr1MPQKuOgAqdNgHP9by6oB0
 DR+MCGkhWf9f1YlRJkXOBxNeTXdzywiWEv9vhOHnX/PA65V/61TTiHqRp7IFru0lZrr4NB6
 B4RB1E+cnpJNbxAAT35x+5y2j/SQIOQ0eZ9idCGGXYVUwj63f27cI1G1xHYB9YpiItMoj+h
 Wi46zCAWJ5PC/p2hPYxDRYK7m8QN3wfz2ytO+ir4IouBBlbrjUBN6JrZl+JuVq/xxDphLbI
 8xEPB/JBEXITahz2Hm8lcx5rLwM0ahJS18sG3kHuXkEY2+3j+RYqqA0pYnq5mrc0kgyekLD
 0xQ84BDBh3D5lTs0KY4IKEU3FB7dQxrlHav+/4++POErvfllv8XAmDgP0Ga9vn50LJSQEE0
 DOCZdztFftC0nKeU8x5rmEkbgYFGasOu5oDju5dwoDaasip8hN25Z0CR7xEaIFgAHyBBv44
 3cm0w0go6duE8PI2YqEQrEQq1VO3b0aVfJHSlK9sH2Zc7TY4cayL/BR2Z2laICCArUNXDwY
 lygeNZ+K7qsL3hf3w1H1ZCkHqtW30tuE6CvdOY/EylME9QIsCdV74ZMSyoqYhrbLQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Three checks independently blocked 10G:

1. allowed_speeds in dev_start was restricted to 40G, so the user
   request was rejected before reaching setup_link.
2. get_link_capabilities_aml40() returned only 40G for all DAC
   cables, so the link_capabilities mask in setup_phy_link_aml40()
   stripped any 10G bit from the caller speed.
3. setup_phy_link_aml40() on the AN path passed a hardcoded 40 to
   txgbe_e56_set_phy_link_mode(), ignoring the caller speed.

Remove each of these restrictions so 10G flows through from user
configuration to the AN base page advertisement. On DAC cables the
capability is read from hw->phy.fiber_suppport_speed, which reflects
the actual SFP module.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 17 ++++++++++++-----
 drivers/net/txgbe/txgbe_ethdev.c     |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 1098efe5e6..7476759d4d 100644
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
@@ -171,11 +172,17 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, 40, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
 		rte_spinlock_unlock(&hw->phy_lock);
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
index 4d2746371b..bc2e11e801 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1896,7 +1896,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		goto error;
 
 	if (hw->mac.type == txgbe_mac_aml40)
-		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_40G;
 	else if (hw->mac.type == txgbe_mac_aml)
 		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
 	else
-- 
2.55.0.windows.2

