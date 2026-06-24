Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B7FCDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5B4D40A8A;
	Wed, 24 Jun 2026 13:53:30 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBE04067B;
 Wed, 24 Jun 2026 13:53:25 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301998t832cfd3e
X-QQ-Originating-IP: TqI10J8HWUXw1+LBzpkc92rcGJcLPJvNapx56XDggW8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6147208669166764887
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v10 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Wed, 24 Jun 2026 19:52:41 +0800
Message-Id: <20260624115254.20348-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NbnE26TzD42gj/Hya7T3G7zQt3Q6pj/dCOgRCXfFvbY7R0oaZEg07qlJ
 hB1CIarhLU2ypdXSIebVq4uE4lJMt8j6m2RM78I7gEQSIV6JTEjwOjszZWUf3jZDT8cTp8I
 S0hFrHGeXiASqbZiNFmIsD2YRiuZmlDXJCTvwLE/v1l1P9TCMst1SWFieLodVLIEOrYEvIf
 /zO2UZlKScTDMMF6xSFAMqsS6r2jSxlMR0bfH5Thv3wDLnCLjOhz3hFhN0RXONuJXguheAP
 KFdds+EkkNc/Q12rEsxrGElvuM8UJ4S9BRSy3aBwW2OIQvkWSDqbEqY5JBp1lXUR5c8levU
 01KdbbFKXulYlVDdcsa07yrCbjXVi+L2I26saKZ4UnpbRMEOIKowXTlXRiPkioSrsl97U4K
 OKzTxGQRvoYtLE7QlG1ob37NMhQ4JbRGdwMYXDW1wa1L0+Pwqz5XahTZPE/6+uH5ZJya0Da
 0Lt0sF7N3w72kGxy7n1gCXJz4IgMB6lIw8aCgAUQ3XZJdG4eI1wxsTTv+zkvvIkvRefLZwE
 t7AxTF4LfuxfreQp4/CLDFfqA+wFHIX4VZqgrGa9l9ac+1B7hDINN3WWToSnGavCKesT+M2
 QpPFXaDfaoQXnYizREyq3VW4mGox8394qVo+XmIUUxOKwkO0U0Pa1wFsGeczTdRvDq4GO/t
 vXtGIUhZjmYVlLq3epJ7T/XdUd/Rf2jeHeBnDg9FzAo6GFK/jdLdIf3Rcxn2kAqbVTIbdkp
 M7AKL3YBVKemL1BBaYLl2hnarDrzw9ILXBgsfPp+NwECekEEOlFCHSXf86RvvhhNJyssbrY
 B70UYiO9t7KCIra13dF5uCibv1OKSOYoX+iOQO90AufhTtSa9a4ed0LhV4DBwHQg8PxruF+
 fP+Uf+cx2Pdfj4IvIK4rG01lGRAqw9xtdYQlVxPlj6JkhrgHXG7zyitExqJAbqg6VRztxJN
 bULMdHbKxCcxvWHzUVE/0HE9RpJtYJM4tvxo6w6UGhr+V3uPOlWe9j2mmc4yPcIuWCZoT3c
 n2lp0q4CtwSgdfjnnb8zjbzeHvohX4tkLs/oPxSKcYMDbPxOOo1b79iX/lxVj9byHl9zyl9
 CEJQRZM0YhvRa+cEoh96Mzq/90hGgqr87Fg7q4UZtYB
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

