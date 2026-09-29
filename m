Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F3CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EDD142791;
	Tue, 29 Sep 2026 15:06:21 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 70F014278C;
 Tue, 29 Sep 2026 15:06:19 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687176t5361fd6e
X-QQ-Originating-IP: +leAOTo6TEXyZ3Bec6E5vb62DIQICwqGbGJLH2teMFo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2100484263406872435
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 01/15] net/txgbe: fix failure to configure 10G on
 dual-speed DAC
Date: Tue, 29 Sep 2026 21:04:32 +0800
Message-ID: <B5C82180E7D4B9FA+20260929130611.4871-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NG4DlAWE0Xz8NhiSdi2uPbvyc+OVloFDSaRM3LntwBmQzDr6ouMecufG
 m7XHg4ob2biyHM349ZRobAw2Hl+qN4ndFU4jvE7K5BJbU0bzjbp9afYWeOHmPC+C4eWeMoB
 Bb6bB/UvPfW28ouUsipUbs/OxjNE4JIwKN8yu5ffrBKIrO3eofEuqADCD4i0AXnImVe4vL6
 83mM1eIANxF/lNB3dDVSXOpHe04mcOVhMReGBHnzetuxkc8oQnFODN0+j36IBgfasvSphj8
 fEdNYeqDoZv2qIY9tENGtvAiNwxuiwYtpwZTigbjqZkkbwbHupt6VpNCb30WNm6wFba/Ub1
 LrIJc4jckhEpO0oXUczSU1QPL1e6EOPFDcSqu6Tq84YDGfNWtcmv05uodqtEBqt0P5fb8am
 GN7XGifpSIgyfeEnA2b09xzSe/95RdCMLe2OuBy+KFGx7wnFuRp9fAGifP4587J+yROflmn
 93f8+dT0L88QFnS4EkrQtLM/bahjBNtZG+VryXFlghJlLdluaZoDqPpsz3ivgApHdaqhURb
 lH4m1OAcCyIX7KGNxSCSne8RsdmPOQZAkQQzQINb7ucmv+fNI7SjYCS4lh7g8GjeFUwDX4w
 C8BM6jotv8/NySNLiwnuRyYcfzgqf9eg9lMLjGdUQ4q6sh+UkkDvlRP4hZjhrRwG9Vf+6M1
 utXYwVaVZjlWu6xI/gbacTn9iJbfwlHtTuysnblpqpud/jypPqlfDfFVRlaAYRyAoVoqnbM
 Ryt8WTPYd7gd+Iemt3yBLBynqv9OVe0DFsakRg0wkqSj5Jp8IPRWXk6BRN6pgmJrvtDO3ZA
 +YaMwryPYUceDpI+bO5tP4TcrPHqVABV+n9uvxjD5y09h7WXmow3N+y60wE9fkPDS2ZJ6G4
 qxfm1jZH8Okz8xix1WY5l+Gni5S8oumYTxuBZeghb6VPgQVB+imxq2SqZIJHzLTGI1C5dYS
 +o+1lzpSeJDXULuHdUbX5OPdJiDZZqk1FFwc+1aFUqeiRQfadF/MKTfolRM6gZ+z6ZKIRwC
 2EoPWSIN2qnTaIV0TvDOqy9eek9d667JAqkaY3YwY37L/5qKbL2ylZXlsSjhaLj27+echW9
 vkTOWXIGVuAAAsigtESWLplsfqRQF/Rj1K3x9G4ugmKvCNkn1QH1q8+erHk0Aoz1QNNceBC
 ULNz1FDRDr4ku84=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

