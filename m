Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0999CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:04:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 198C840674;
	Wed, 27 May 2026 15:03:44 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 3208040A75;
 Wed, 27 May 2026 15:03:42 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887015tfbe81b6c
X-QQ-Originating-IP: mb/7kgdRaav6hWHXpOUc2Sr9S8K03ExzNi/YvjOGxhA=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1076709167170175028
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Wed, 27 May 2026 21:02:09 +0800
Message-Id: <20260527130222.24348-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M6KIQpYj5PeCOgBw3d4AB8pNy1o2wbyQWyXLQrSyHEngB96igxKSWnDR
 CQSr5jNIftCMeMwjyqPUTXDy6b3juvze5dhm3Sxy2pq2+ceK6X10O66m7aMjShLTNVPZGde
 kopHwiR/yUjCJ7XAGBDKrPix6W5XRnsRBNdBf2jkD2MeQ2M3LfEBuK04NVdkVV/BXUIPu4L
 vhlyKAStBAATMu+xiHGWZgsHmRo6gZxH1yLoxwjM0pOU0JnSAyHHIGEYGVQm+aIfSfbBSIP
 FUixWCxZEFvYDWiWKcdsaXpF3lh+npi810Cm8c5NGBd8DBm7nu35WH/T9PsCXSCSRCJinW4
 gJ42PS95A2ZXguStqqiSURGctFKCpocu9JlzzEoPMrbQr8yWyju7GNplPYhLAwdNMOBt/Fr
 D37wCA3lqFO8vRvVkiO67B6gaos4fTTOrcSJoI7lHf3Ngx7XwHj+leNtf2xxWWNWOwZe0NE
 B7wtfjTq/rOflAmd6dlx/09YQfNBC4818gZjr/+7PXuaa+15WVBzMKAQxZdrklS/myNTeEb
 pjwPbY62EETK6UBw6GYbRl6Tv/T5TKS46SJS1rz9AtfJ+d5V8P6QzU7IdgdXTwpSx6XJ1gS
 FG8X7YczbwYJAMK0I23MqslSzT2vm+njCj7gxKcCVy/0pzJZ8WPtgigjkIp/NXrTxTx0bT3
 PkHBWwzRoStUgHVEQP3PKyuRBO+1ykoqE73GoJztRbp8AMNXeP7hcqPIOgrSRqscoKtSr6M
 dwd3hmlkCISkHWJ1RsjhzEcoNMFWKUItaQJHdz/rAbrLWJAfwpPhZ2Ux065dgWcLqdsv/AI
 ZFD6TGjFSGuX6yXHi82yXj5jBu22DOmNbFbazRuB/xue8RRO8aCeXXX51voOhZCP0WqooK9
 VKmR1VFTKeKLMq8xOaWg/jGCnT3lv3EN/USJvS4utzfMuRrq30n6XcoTerefkWRO5NAttW5
 1X9iz668+JSlTtmFGZLB7BvlB3WHtrhhOFCgOtWeaoOJ+jUmFtWPnzTE0e/6L09PhUEqAsI
 1jrgisMleQW3IXcaAYx3XZ8jqBC1lZyod5aiNW5NNUcMxmcnNFehJhHqz9TA+Cs5wnEVk4D
 5xRpemqfvtP
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

SP chips have a hardware bug preventing XON flow control support,
so the driver disables it.

Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 0d3310e15c..db45c5c0ef 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1037,8 +1037,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
 		if ((hw->fc.current_mode & txgbe_fc_tx_pause) &&
 		    hw->fc.high_water[i]) {
-			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]) |
-				TXGBE_FCWTRLO_XON;
+			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]);
+			/* Only AML support XON */
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				fcrtl |= TXGBE_FCWTRLO_XON;
 			fcrth = TXGBE_FCWTRHI_TH(hw->fc.high_water[i]) |
 				TXGBE_FCWTRHI_XOFF;
 		} else {
-- 
2.21.0.windows.1

