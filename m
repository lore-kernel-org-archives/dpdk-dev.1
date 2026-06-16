Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12142CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:21:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC5C40E30;
	Tue, 16 Jun 2026 14:21:24 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 1266940DC9;
 Tue, 16 Jun 2026 14:21:22 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612476t8f937cb0
X-QQ-Originating-IP: 5hp+fDJhxB+NlV/1qF83lK3dSv73gEoM8JXCWHNY7/E=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17895895793683023674
EX-QQ-RecipientCnt: 5
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 09/21] net/txgbe: fix link flow control config for Sapphire
Date: Tue, 16 Jun 2026 20:20:17 +0800
Message-Id: <20260616122030.9688-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQPN/EATMxZDa+3/LWbZ165Nzij1DzZDHGFgYMI7DsVt0O4veQy/sljE
 TMP4CVh1eSQp4TSap/LC28vnDugxHfg9YTbTgq4WStj+OVERabIH/eysKrJal5P6YrscTF5
 mJc0ET6bsLVbFTmSkdhs6jgBKYT+GHRmMXnGbJBFDDevqfaSlR6llt18KTArp1pzCy9xYRN
 Sj7ROw+VQQPbGheAU4dafYQ56J/lQnfHGwrg+lK1g9chmK//pGUfemmX8zxyKffGj/ydcen
 uIyk1zfSpOzfOVzmre1puRl4BPK6xWem4uUrViXg+VVXrRN/Fw6O337UQ0Jk6cG4Z8wUyv5
 rVhpFp+8dNY+3soMKY8m9h/PSYe2BIAIjdKxMOiGOtzEEo9j5dDBhXskfQGQ05upxfZPsZy
 oAGAFC9GXh3ITrvF1S9wZMtrlQRwiUzr8IWXCamjBJZhdx8RB9qG8YzLBe9A0Ut4OnRK8V3
 uEN8R5fojZ38eJyM+LWN3lO/tX61rDVO+52arNktX+F5PeYOdf7VqfCL6feMIWY8B7Hqb+r
 XjVGN+0expFmB3hYyhUyTokA+6SPBcWUVxWZg65uwY0OvU7pUZQDJ61glVFnVnKrEQ6VnTz
 UwnMWKNOa1i0VUBlCEPB6g5LC7pGWxlw3htYQzCthNeU92ZWgh+cN2YmLDxMnYsamhDQ+gO
 YXdy5WuW4x965UkUEM+giIz+ohlkpEyjAiLt6x4AygtF3eBUGDip3jl49usu5kWm8U7jd8Z
 FjvB2yrHpG9ZtqnFKAoP4EK6/Tw8BVVx8KNbPCu9EsG4PGYMoWqmn1QliXJqvAsGf9mCf+g
 DqLmjKiozm8kNxkLva0LZm9Jv6SVbzswWkIiHZIplNTwdEMAbWgGU84nUB/PJzXz71cb7Aa
 LCtcUhHo74yT9kyakgYx4MAWm+XWjuLSSk3v+ebuJLbb9DYSKxVuhdNoY1j6o1M8STMc1C3
 D+Ubmt4xGaAzyFuQS/+CcyPbao3lpkt/Lw0ZvKm4XwGHebv4vYAwWKhRYar3n3WJUxN5Vap
 UdW+2+r261/qcwkTABd7jKyb7IVVAIIBv/w2NKd2UprJUSX7q3ZlD0DlHulTdCjFONrvb7W
 pHBn7xkOW9TK/hof925lZc=
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

