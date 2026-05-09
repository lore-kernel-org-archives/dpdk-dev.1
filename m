Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B77CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:29:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 046AC40673;
	Sat,  9 May 2026 13:29:21 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 5B4EB4064F;
 Sat,  9 May 2026 13:29:18 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326151t104fe8f9
X-QQ-Originating-IP: 6wZL70v5pxY4grCzEoE06mw9NapttjyYSVbFINexfZE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7182035884644860363
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v3 09/20] net/txgbe: fix link flow control config for Sapphire
Date: Sat,  9 May 2026 19:28:11 +0800
Message-Id: <20260509112823.7728-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDAhN78L72+TF6DRfW7M7DaJVbG6yVVI/JN/ZhciN0xNRhpF5HboWwdD
 QP25BUnddlawg4l5/zNJH+JE5zVSaZgNZ/9QJmxSOI24q7WztZPvi/TvbvY1qbIoq8Qe+d1
 x+VVi0HMtuIGKnHAEHgxszH0QaGKt/tsYOEe9XhxbqYElIV5sF2xU8o6oONnwUsW0k8/4ty
 4+E/d4ZW40ONk6Rz6sRWWG/ObuZHxthWjTkuiiuDpHY1yh/XSkHXoRi9jP99ji3ZX17fx1K
 AGLtkDIr6ThjvXnz+BymYBhEFv8tOJfbjTIG23km9zCtI8E9C/ckpPMlddb2DljJJH8fdxR
 YN1GeZ9wT7HSgHflZsLq9N83cl9MrV1osIMr4zeo60O0kI+IJiymaibNUpzugAEZFOXF0wM
 j8RJnzMd6TCv4d00YRNkYZI2i5oDFEn37YqhPT99hKv+XO9Srj38lUb9Jfu156cs0zYCTzB
 cfwJp1u7nfzthV0Oa7xEyc7U5Td+U91dAthzdAqKMXh+Cuv7JPyv4V1E6jcCU21uRmHpCrp
 XP4bavMTNlMNryTsqwjAUEgwW9WUbFQr2TGtF1uvEClVzlBiYqe4GhVtyMNBIHip5vZkc6i
 7QMDXawf4L5O4qwO+cJqcFp4y/ewsH0BZ6tBuzXw7bgY0icsJzW7rt7Ie91/QEJ0ggKwTG4
 dur6XzCORoGZAMif2FPko2HbDkmBscS//T5sQTH5sL3qPwjqwReR2e8d549dmxg6dH7cWe6
 VbzgzEeusgqgGpM5iip1M9j9dGbbUZxxFVaiDvPS7csoYQl3j9jHeiCgJM2dgAHqFu8x86g
 sig94v6WPocqGY5Pu6cfZhjJkxTO32kVnYUArBEL6VCbrUMCwWDysVtxRyCUX3ck/7RRyJ8
 i4RMiiV/5MRid8w/1dF7DkQBuZsHSlpue64HZqIWpxASIp9TUBUEZHTLsO/dcsJbT2izCz2
 GJ8qI8ttm6ED9lhTBWS9qsdnyJLoCNGtu9fFHieSDFAHofryCbJqdlHKknd4k+VNv5iKiuf
 HNwhNHyDeXc37sITw/tn7D2rwCr/5LFnjdSb7MHkkWG0hCExdRxDmPnT2aGoxcWrRWxV3JC
 GOdEHHvLEgnYUM792JjiWQ=
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

