Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27FC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F211C42D35;
	Tue, 22 Sep 2026 14:54:30 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id DBA0B402B6;
 Tue, 22 Sep 2026 14:54:27 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081663t60a18e9e
X-QQ-Originating-IP: yBY7CPC5jQfj+sRrNsewC15PgBDtJ0Y0jaHGCMkIHPc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14021148384883748580
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 01/16] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue, 22 Sep 2026 20:37:34 +0800
Message-ID: <351633F8DA82EC31+20260922125414.3638-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/xGdBO0CIVYgOnGVQDQh1XHEV7bVunngf7TAUtQ/Ise5h
 R8zFVDh/hI/3++x4QGtQYg+IFqPGKs91990dj3iUgdy71MEORGvdLQI28JbJ9DVSvumjbpQ
 5x9cP1TOnTw2YvB6n7ldqrT11/BHCPFRJygfhPTORdZ+M3xHmgJiGLSXD7D87qeJ6G8Ygg6
 8UCrHsdABVZzt8kRINSBa7hP3Yz2BQCCyNapNnftxe6xMkzdazocoexnTzMSVN0+uUTro0y
 Ddc7IB3BISKn/4yPhrDLaQGxkuvlp6IC0UufVrnodZLtCVc1YmkSSOETaqTNdW8ndcYfs7+
 Ycaiab26Ih6VDODcoP8/cX/Tjky87VYi9mJ5R0XPCy2B5peybLQoS232eYH4MSwtnlTUPKf
 9kw7zLgsbTTFUITe0+IB1IDxy1qsj4J4fXsGL+jPSgroc5yYvNC3Kewcf96iOF5Aoq3K2uM
 mOX5vlLhzZy9U93LvrR15Ol8lp4gvRefVVfDZBlqLEt0DFZ93u88rl2uw/FlcETV6ObkP/M
 p9gfLL4WprRD42ocrBFPnHJPQHdVyUb7tWf2nVR3nZjh4HnC5XwXypihkkYGYr9r7ObhhIy
 vwUiOB3D6+TaB4nTSgcKTNQyfBSztBzxGa5Ytyi6wW4P+aQBEU9/rtoKmm0FadndXcGTDsr
 5kf/Bnm/lt9LEND5XPagOTV7WozoHw/jmMQxnFOfUgmiDLlmE4F69EaorNJSwDeyC7LiCRT
 u0025bay14r5lrzXhY+bGf4wdXnyipOcpuULk5JZOoOZ8bLvNdHFtiOrTui86gvJzrYrnKY
 lGYDBDUBChMHaj/CeMixoKm9ptMOPzTc0owITNJJsyGhn5wxB9j0OWK7dLe/Xobgk91vD2v
 GzcYNr1SD+UwibnWweTWIbcwvOqskbbzRr+CYtz/22ML5koGOCbf50wpTNIGq2LR84k5a5P
 buFTjMH7hJ+JFKdja8UaQeFsb6kEu0VbkxaGrkcwkiRR9hNPQpGENJGejlUoPIAQecSG38d
 auISVNENokZl/cmRSNP22i4g0qfoq3gMp5QLiI+ilVodQuBTkHz6X8oniz++A=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

