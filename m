Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09615CD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:37:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4722B40667;
	Mon, 11 May 2026 12:36:58 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 74F52406BA;
 Mon, 11 May 2026 12:36:56 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495807ta3c83e48
X-QQ-Originating-IP: VzQqucgW44DGpIDapz8cSRPKyvjUd80I8GWM+6iTMT8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8850768886122280105
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 09/20] net/txgbe: fix link flow control config for Sapphire
Date: Mon, 11 May 2026 18:35:51 +0800
Message-Id: <20260511103604.19724-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPIPMtP+A9k/6gOVr5NJXu5DsUvXzw22bePcbAtVC+CaDcE6NlhUpb6M
 vymiSG8YkpgFGn2JTZwP1DqGlNcsBlKyYdGlk/JjCTVKzBIHeWdM8FmyV9tE+KcB2RdwoEt
 mp6gAWHlEk4gIPSVTDMFYu/HNebE8XbPLv4VGmVaxaqWDbHc7PPR29GUBQuDrllu+RcF5JP
 fjgnePfxaegPdYcxRexMa3XvwRQfoCX2y4VCXi1p1H3w3opq8P3LbYlFG6NYPhIheDeSerT
 N1GmQw6LaXBKh69X8SQoON5xT32X/NNGPpMukwZqfC2KNEuPEOybApsJ4eujAAnrTWhETY3
 M9kINjoQKJZ5WHrPBN32k7kkvQbmqOdO/b7++lwnR4ViTLELUWb3j137SUdN7u2sMHl0Nzc
 K7urr1EBHk3IVZfx+fbLENxiLgAER2Kxq8nxxOabWt8J41IpkUYApNQebBFUwit84Km0BjG
 EdvZlH6+JS89J7IQX0SWSn+ovdGdmoPHQ71/cFP/wMdpxcUGI9l6TkoibwpCh96m2l/mI9c
 rcFroWfHEuIuLc9iBMAFddvgxwAqQhlm/J9WJ0NUfJ3YFCRfrzqsZ05GHRKsaxLiYukC4NN
 7ou+89u6pa/MXtWQEdnivQwQU+o2fTWy7qJYBY/YaCYiEaJNFmllkNosgC4o+HuP6jctlqE
 prvZiSZ/np6OvARI3cQL8YoskhytNkY9LkiqncnYe7Wa2CTTFviSfBg6tZRQmiRv6i0zf1m
 m2Zn3Zanm1ooVbxI19fEShekPtDFlFtgFUlAic2jrUt9T4njwVtIfiU5Z/px+TkHhQ4FbYs
 urY07T/jo1NxWPf/Mkd8HtKSOih/lIQIRBeyWKH396AU9VfdDzgMU5ZvsSoseLC9n8Ua81L
 MUYeXHqJCn3VmGe2ZopEpRGHpoYDduxjP5xZfmlHoPgSm9GPzvGmRLVV4XfzDxStb7oDo1n
 klALQZUlOOYPd2H4tSujHIsAsisXNRVUMoSWCrB1qHRgQWm3ADEyxWVFXTvSHrfvYjmT6zN
 dfSdrT9V2F8gZ2I18T/3TlpIYD33elszkO9F/0fCD/ioN3Ek97N28S5Mz1FTjUfUXNJa+6/
 vrVQyzaRiNXsuG8qzHmbJk=
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
index 0d3310e15c..b1a1483dab 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1037,8 +1037,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
 	for (i = 0; i < TXGBE_DCB_TC_MAX; i++) {
 		if ((hw->fc.current_mode & txgbe_fc_tx_pause) &&
 		    hw->fc.high_water[i]) {
-			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]) |
-				TXGBE_FCWTRLO_XON;
+			fcrtl = TXGBE_FCWTRLO_TH(hw->fc.low_water[i]);
+			/* SP doesn't support xon */
+			if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+				fcrtl |= TXGBE_FCWTRLO_XON;
 			fcrth = TXGBE_FCWTRHI_TH(hw->fc.high_water[i]) |
 				TXGBE_FCWTRHI_XOFF;
 		} else {
-- 
2.21.0.windows.1

