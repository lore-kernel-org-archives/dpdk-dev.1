Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA19CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66338427B5;
	Tue, 29 Sep 2026 13:21:59 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id B422641143;
 Tue, 29 Sep 2026 13:21:49 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680905t3060779b
X-QQ-Originating-IP: NXHe78v+Ms7CHrCRfoeUETpwixd5ZX9fz3ErQg90hAw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17003844976309349419
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 06/15] net/txgbe: set i2c sda hold time
Date: Tue, 29 Sep 2026 19:18:06 +0800
Message-ID: <387EB932177B8EF8+20260929112119.4516-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OJ1IEQL1epI3mkfbaRkmIH7wveMTJ8oUWtwzIRD3PLd3d46oEzYeitsi
 1N/5V+iio0xbcFw9vD3IDC8rawB2X7aoaWK3WAYU1u0Bd4Nb20102AmT7ls7gSvi91Sjl7i
 6eqYLXGAaJORQE2spKdHj7s/Kig0cq/w4bepzwVU7NDJc6kp1mzCZhnbYj0/JkcEv0wyGt5
 cXYaGHLxIilXXnln1YEfE919TDllFJhd7ZHiUgZufNyksxW3GdyNQgEVlDH0Va+EY3UNOxl
 Ez6Ge4twWU1fnZMPnuFZXh9OBacD6A+DY9y7jrbNymzOyOldGZ3/W/+RakfDzy+znpsX/y/
 AJedj44Hea8jIkon9czV03EHIoQx8SfiOe75yGm9TdJAVNPBS8LBIVrs4o38wQoJpnfSq1m
 g7Bbfbj6AhWG2TM8KbHCRUHvFYWbGcKtYUZMN1nBmcVJPksPoVeiiV9MHf6QAj/GLJlpPm2
 CvkH40my/GUZmvndnCcqNjMh8vB4u367bhrrzfwd4SxBc2mhNDQUNqKUzxC47KpIOkUpW4P
 laappKX/8tTLupvH62Mr8YiqR5Il5Z1XyGw4QoMfjTpMy7YmDGUtIJ4GqAw4jXo/B27LH5z
 tJZYRPFAebYYOzN6r1eP/Xrx4f6YubSz0nhS2DXX8IWARb8/9I0cI2lPN2KngG8QqW8LiPf
 zJUUkE7mQX9J1x1CFD3b5lTjj8gAkULLZsKTi3l5Zl4UhCTwsuhrhgw8lDCrrDxWqYgJW6l
 GT7c8584KpBiUn61D/UDdMnzQKsYe3uVKRZ7LhNH5rnmdOKqtqek6vDMGK3v2o9Ya77DWMo
 zbCKpjWqz0ulj1K3hXHoK64M6aOBbsP02PVJwwiSpz4WGJ1CZhrbHq2c/yMcdivJVHaVjJg
 2Hq2b2dpI2huTtGxdzo8IH2Ac39n2DweEotTVjnse8vtlGDYq+eiM/Za5bU7ZINSwgYmgJ6
 pth1lYd7KORKIqO+tOLJ9kCw/ynasOoeZCRo7vaP7hcjcIXGXHy4ol1GO2oMGIOwJCT5lQv
 SeoDjaXizq8FfGa/zzhqqONfTqnsPybs88tsnZEeBRVOET7Brxx5XxSdSzfjRyILXLJ7nGJ
 kz7ESxieRAKMoqfRCgD5Fg=
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

The data_in_hold_time measured on the oscilloscope does not meet the
hardware requirement, which can corrupt SFP EEPROM reads over I2C.

Set the I2C SDA hold time to 100 (0x64) I2C clock periods for both
RX and TX in txgbe_i2c_start().

Fixes: 00970f6398c8 ("net/txgbe: fix reading SFP module SFF-8472 data")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c  | 3 +++
 drivers/net/txgbe/base/txgbe_regs.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 2fbe50e242..8b653f0aeb 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -1334,6 +1334,9 @@ static void txgbe_i2c_start(struct txgbe_hw *hw, u8 dev_addr)
 	wr32(hw, TXGBE_I2CSCLTMOUT, 0xFFFFFF);
 	wr32(hw, TXGBE_I2CSDATMOUT, 0xFFFFFF);
 
+	wr32m(hw, TXGBE_I2C_SDA_HOLD,
+		TXGBE_I2C_SDA_RX_HOLD | TXGBE_I2C_SDA_TX_HOLD, 0x640064);
+
 	wr32(hw, TXGBE_I2CICM, 0);
 	wr32(hw, TXGBE_I2CENA, 1);
 }
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index bf46a80862..b0042dc0d6 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1610,6 +1610,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_I2CSTAT_MST          ((1U << 5))
 #define TXGBE_I2CSCLTMOUT            0x0149AC
 #define TXGBE_I2CSDATMOUT            0x0149B0 /*I2C SDA Stuck at Low Timeout*/
+#define TXGBE_I2C_SDA_HOLD              0x1497C /* SDA hold time length reg */
+#define TXGBE_I2C_SDA_RX_HOLD           0xff0000 /* SDA rx hold time length reg */
+#define TXGBE_I2C_SDA_TX_HOLD           0xffff /* SDA tx hold time length reg */
 
 /* port cfg Registers */
 #define TXGBE_PORTSTAT                  0x014404
-- 
2.55.0.windows.2

