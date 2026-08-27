Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB64C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:43:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C015340664;
	Thu, 27 Aug 2026 13:43:52 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id F1A2140151;
 Thu, 27 Aug 2026 13:43:49 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831026tbbce97dd
X-QQ-Originating-IP: Q9CtPusjzKG8DgOsuQ6vfLT0cjLFXk0M80VrXuE5X3U=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:43:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2225876006580598758
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 04/13] net/txgbe: set i2c sda hold time
Date: Thu, 27 Aug 2026 19:41:56 +0800
Message-ID: <ADEF990519047647+20260827114309.10530-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M/BhhHt976mJsZEejBPZOJn4RsnD/FvpyWJlD7SAsWGFMJvPVhwLO3WI
 yHQYh3M//s1XV/pYt+k+4MTwn+1+EPitpPdNYS2IBW0vkmVNB12Yq2+un7E1T5i4ferJe31
 01WV2Xt9IXJyHEsQRfZPxmB37Jg7FolejtfKPiupPHFwigi+rlZYw2bq6Ezc+66WQLxZNWa
 DqCnQUTTKcz8/8n+p1nTZho6HIMF+4ibhEajrMBwEMy1brcTsxNXht6I6yJUSk4SVFyXL8M
 8JYYjoEJhGFw2VaycjHKC9vjhAa0H9XkdJJ9J+eUFx4P0B8JM9zU0NtZhx4zLGrdYwaBfAU
 qD2u4XyDEdCADfb2lfgje+7tIcdUILDSFCYtpFqqvbAIuTWJ0KWDUTfMLARCeQcpOPvQIzl
 8HqW+jfg210emiYWjlCP9CxQmitmIrhnnfr/Ljj7uHgMDcv8YHqYiRRh920tjw2JlX0Ws0a
 81yE2Mbc10inXDpdk0rukbwmn80zARhzTlrnOxezrXvxOAbktY5wY2dd2qJWKXL5pcKYXxB
 TtecIk3zHkjnEkfoiGAEPbQ2bJCxRbK64bRStTD72tJeFyjI6NfXOerNnnV8AaCnJKpCsK/
 PfisxEMol4gBrg/gC34rZEhKAAY2mFOZecweR1x+3Js1kDff7WyiTKlWlKo/7GnGsXGocMP
 Im2A1vhBPoAqRmE7/UZK4IQvR21rWY6JHb1OgE7/NvYe6uvlS2aI2BQ1F43E3XWwzYOpWNb
 F31V7h2qE8tQShX7rnl0nxa2UpQDxb0QmLHOcSxNbTqWzaXe/0wnII4uU6pBXCr1vyHsNoB
 5yc28mg3Dbl3DIBADfS+CGUKGwA+52LgUwulyEDr+MK3mw17CRO4acKIOd/NKysMZhKAo1T
 pkCO6k/QWNsHgHD+gS/z1iMCDCHscr0DN9X9+yWFIV4E/7Hh1j7EZPK6z/oAMieTQfHw7Sd
 QUDSlCXAkVMfD1Std2dVE7oWgLU0dOXVzm/BpKIfs0qztD2ttYsofW8IfLSzzXD3MGMsr7o
 eknf43OfLVHj6RMNGPuGaLq1GWXdjhOsrTBTl4Wg26l4KWus+2xON1iYYkm21jrnYM+SoFK
 xiM4ys6wrxeBwMtxqFvZJXz4mxTKg2ZJxQ/j6yPb475
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

