Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94651CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0DFD40DDD;
	Wed, 17 Jun 2026 10:15:09 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 04D0540663;
 Wed, 17 Jun 2026 10:15:06 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684099tb398d03b
X-QQ-Originating-IP: BqGpcf4cCK8Um04BHvgUntCarVCGP9p9OJItLOC/KcE=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:14:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11258992465838473965
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Wed, 17 Jun 2026 16:12:56 +0800
Message-Id: <20260617081309.19124-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NZpC2jeiU30MrFiB8blf+I3Q8vEP07BAXyUnZl1J5DQWA9WUbmvL8A79
 bmypceanVJ2qK9SSVbJI6MqMTTAWWouHnxN9wOpSnKkUlJXrdaonevLj0mo2RMLk4uCinqM
 6K1KgXzv4SbDGege+WHUnFMGlD8T5UaEwrqaT79HjcSfc3X0sDA2KtVePnAV3Bk6ixwds1W
 ziv8Q0PLmQCPcnz/kk9dy3ghNFUNbg5SyPEJx+6Caqe744d5z7/Qc1XA/41w2sTlKTV77Je
 mVqqOxLy2W3yqLVOWSdT1R5NNsGStX6vhWgyGnx+dMP6t/h5YheSNz5JnhAoAX6NHg5Z8sg
 +eMMbUb2MrCj9ij8YeRvpsJ1FCIQy6DWCjIVD9KTD6VHQEremioYOBUBiaSUmZhJDFI9Yu7
 KgNLJfAKPMn+9uJW1x7CIcZVjES2GiAeFf9OI7z1UQFjGzd9XhCECqyrCTHZuPEftrUBaLD
 C3ktrP5jtw4yW8tQmDr5tX6Aw9XEpGf3GIqYvL8O3LyQUaGqhzmoNfSP2Es7vZj8g6rxjOD
 OW8PoB2KfddsNHpGgPib2I87MQiu1aYHy50I/ptQUnFH2vwiTgDIsY1Y3jKC3mlPf8y4X3Y
 han3btpzeIRExvnOZ/b6ddnaHENaOzm8MlOW765dXYZKH0vQixsegpVe+8gD0w5pJAf99xa
 4i7SWZGdgNoDWdCrPZDnmEaSiAKS1sokngNHfZOkdruZ+k9csnnyFdKUVIHGMPxM2BC7brz
 LuZBnYwNRvQW6Tbz5vKAZgeb1SFq76WW4m7LmAD3zUHxEAH9WKSIWYc3CkloKUEyj0+49ng
 YMIzh74YcRw1azEJVI7NvFk8LaIx6XrLLkhEgvmLtWPA2xC2PtsFFc+8FCFAcAcZ3lj02yZ
 l2BvhvpGDRGti2rnusSbHUUdH1TiJuh78/ZLH4eIWl4K2tnGhgYiNsXf2dePEKKssEhR0/0
 x4oBDEIepFIqpYvo1HZiTFDVkhhLARzyQZgt6xRrfCvDZV6vcSm/SjXST5L4A/ADTqn9012
 i/Xf4qYE19MRpVb85Y+OLxrTIuxCnVIttZ78uUp93p62I7XSXC9wKqNW4xcc7rvYqjgFT55
 Z5oO/hqRIhcSexMWrTOi/xeIjH/OxVkRDOQ2WFW7XNNySogMGvSodRTi64F/uX8fA==
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

