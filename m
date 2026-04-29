Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A7FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C31CF40A6C;
	Wed, 29 Apr 2026 12:26:40 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 5A7084066C;
 Wed, 29 Apr 2026 12:26:36 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458389tfb40da38
X-QQ-Originating-IP: olSGEZtgsbGMwxx7JhWZwvH6uMDKkzCcRlUgYbBgmGo=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12911537797599686191
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 09/20] net/txgbe: fix link flow control config for Sapphire
Date: Wed, 29 Apr 2026 18:25:03 +0800
Message-Id: <20260429102515.58880-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NvxNySBpH0QlY+yp8nbUfbBUd8YvFZNCq2sVcFxPaephn6emkMevXTK2
 y8q06FMMVq15T0vHOw//wFbelATZBDz7RKI1v1ijBuO9+ofWJoQVt05WYkxRjfIJ2WtpXux
 Ku0TPT99XqPMTb0+k+2fFG1zlzCvu8NuQiIj+7gcFrvqm2FZgGVZN/uzWfA9txV2IF2C11D
 yHziYPC1uPWH/McwBnpU0tQHW+HfWdHEiemosI5qNTgpzZBQ4N0zBXmNyKSNsnKU0aPbvx0
 WfPwI9qjxFwLUvRReWTfBRKZO0wyyaD14nGU3RmJ72Lbznxo8pJiOy9ddkr6jnJTjf+4cOK
 c+iGPBjDJLxrEuh2Uzaav7V102lbJxjEL6Qn0MdGpFsFZczrvz/PLE39VVeWhacTT8FzR6A
 jNthfTfuOIzntBwuBf51qK1Ao3RZYJ+cG199gRiCwXsTpqsSnsgP9jBVaHZOkBmdkR8eOYz
 kgb1poy0N2dtEXUGQh0Zt4BEZ0M7BHaJtQf0lvN3Ft6oc4yR/Mtp/iD4p/wvbH5yL/KO4LX
 01kH3I0DlonWYthS1W3X92KG+2aXZj53BrpbTFow2nbZ2e63JIlgN/I/w1fYcXzKUPTZxFU
 VB/58pHhaRjdhaJ4T/Hrg0osPPPFnZxepz09DRDuC8BNfHiAJuZyopM1sBF9TapUsAqDe6d
 MBiGhHyO7MsKK41M0qBPRbv+/6ghKZ2+83xN4UUZu7ol0tVAA9lUiJfpSDOJSQXkWE2f+DZ
 k+Z+7volby2bQg11mMkOSqk52+/rv530YYp7T+YtrWvhhTTE5PFlJL8X4BTWZmxFE+1s7Xp
 Pp3OzuUdzwuoSAVu0DhDruDQIb3A119v1qYS6eFylWc1obKSgwyvfXMqF/Hx+s0RyHCOJ8A
 uJB6102+m4wpm5mXcoVzT+q8GnDemOs0ZGoHJdep6bDiz1YBCSkZLp5Kow3aS8i2VIXDzlN
 Cqt6+ZZyzdeQRfk8gFpQdj/zzUbaBXXHs/5qf8ghf4HDweTBl0iLgCMXMP6t7F/4XkEF1i/
 ICjele6S2fnZ4kTE43neWGZn/dZRZ+P+E8AQqX4Pa1o0r8D5Hu2jsdLqsjqicMQZEefe/uh
 Kne0KP1zGsL
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 52fead6171..0719b56e3c 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -1035,8 +1035,10 @@ s32 txgbe_fc_enable(struct txgbe_hw *hw)
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

