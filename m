Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC190CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CAF240616;
	Thu, 23 Oct 2025 14:14:52 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1C92440616
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:14:48 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221683tbc11075a
X-QQ-Originating-IP: a59St8rnDeH/tVKRoDA0tSfXOjLuBdbLl2qbmrUQH30=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5619954051794385796
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 3/6] net/txgbe: add RSS register selection for Amber-Lite 25G
 VF
Date: Thu, 23 Oct 2025 20:13:52 +0800
Message-Id: <20251023121356.21944-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NcOdkfOXZm3fDSoRzEvIYDgzQqgyYrodo0qUCoNDWdv5Fw2/d57GL0lJ
 5cwa9Lykinfh1lakD++03lA6sz0N8mZARLyqe9c1KXFKHEjCaeoOaXlz9MvoYTkxLehXpaj
 LbKZ8WzF/C6Ya4YGPpny08aTi0Jl1DMarhRVH6RJxxOZVxSmRqVftbjdDsB7sDHfiUqJg3k
 70L+809W8aEh1plTUnt45PT3tFV2d+FVLa4Sb7E7iMrzGqjehijcS/KHg9IHSOCBbBs82qg
 MMH7EDa5LwJbgoDtteoTeNRaAi+FfBQh0DgrMIb6HkuCfN6sG24p93rgigxt++XT7oyTmZ2
 iedrofFP92m1S2dHtHth20CAbclJCCxlPJX/0bV1/tt2yUFO9U9q/DRSqpycr46jBXjff3V
 lnVafy+0/ZxN+Gi0vXMvtkWWmfub9TiiERE8WYYPD/avgh2PxMcsv8btgu8LpDtF+jYp7L9
 7XAOQvU0GY6cJT70B9yEjv2Hnreco6st/m6zFuDD+oatGDUDukHx12VUN8ey8gjQrGB/0HC
 hCVuMVY2rYHyZ8g1+XKRwA4217MP2sQufqVWYtLHdu0BR65BrLvgQL9IDoslNEctOY5XT90
 dJMVT17TUoTcTVh5UE4oTeua/4roz+lzdwGdKnn5mOOz8i6RXlWqMCGTQXJigBUHk1fl5mp
 G3QYIY/1FIdIxdL/mrrIHvjFlJ6TvSmCEuyXEsic1kUw6Hwrc0BOhbiG/du3msLGGI+12k1
 +c8bqCA1b/i/rP8vSQadFu70WiiX9nrC4PqgzrSgyuS98x/o/80Xc6TWsEd/xvvjbvwQ8SJ
 s4CA+iOW8wUM9E/YYsvSRrO2e3W/DN7iQIa79xVjSG3NzhocLJtJH8imyKOqvD0qoWteO21
 5q7tbOfArEslKtKoinkjJ/ksrPZXyXNLX8LHDcXDEF6nIyQuKegt7Z7DC6UsTz2g0FlYXRC
 dmUgeWkbFkaEKmkwUocW0/TqF4NE+6YkVffAttO30ajqIfSLxvjf3mPiftGaWB4kXB+Z+ta
 F1n4lWBFiqdvRlBsZSvskSdZWSieXFVStJchIfFCpeNAyt0aP5F2rr/26bawY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

A mapping function is used to distinguish between PF and VF during RSS
setup, ensuring access to the correct registers. This feature is added
specifically for Amber-Lite 25G VF, while 40G VF remains unchanged.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 505e42a666..cfe9b94e78 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1816,11 +1816,13 @@ txgbe_map_reg(struct txgbe_hw *hw, u32 reg)
 {
 	switch (reg) {
 	case TXGBE_REG_RSSTBL:
-		if (hw->mac.type == txgbe_mac_sp_vf)
+		if (hw->mac.type == txgbe_mac_sp_vf ||
+		    hw->mac.type == txgbe_mac_aml_vf)
 			reg = TXGBE_VFRSSTBL(0);
 		break;
 	case TXGBE_REG_RSSKEY:
-		if (hw->mac.type == txgbe_mac_sp_vf)
+		if (hw->mac.type == txgbe_mac_sp_vf ||
+		    hw->mac.type == txgbe_mac_aml_vf)
 			reg = TXGBE_VFRSSKEY(0);
 		break;
 	default:
-- 
2.21.0.windows.1

