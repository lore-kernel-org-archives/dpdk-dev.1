Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE2C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22DA840E32;
	Tue,  8 Sep 2026 14:41:14 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 2BEA840E30;
 Tue,  8 Sep 2026 14:41:10 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871269t9311cd54
X-QQ-Originating-IP: VGo2NzMeQlcByZ9ySB7QpeeakLZy6xCanyNhKz/6G28=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13482615470150602066
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 05/15] net/txgbe: set i2c sda hold time
Date: Tue,  8 Sep 2026 20:38:50 +0800
Message-ID: <FC53DB2EE4909870+20260908124047.2284-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N+v2p8NjVRtQD6DHQym77vrHSxIBORUj4CIaNnX53NwQQ0a72OBPSen8
 54o0jxWzoD+jLLlmn1OYJ06rhPFVUofBsyRwpK/2Th7kw2+xKn6Iec74oQ8U5seJImy6gX7
 HQVNBsEHqiE7WEEkCs5WfxCS9SUJf9R9M4sb51gbj+7IgkRV2wtKLuXGOq0OgtRGTCxFoHn
 Q/q9eUOQQC6GVxsvEUQLPDSbDD71N2RYgL1NkB6vfjH5jYLv3/WuyUqqialPJNidLneDpMd
 VHli7F1ZMoZwxWSuWMiCCmBXwKqwKxPme4u7poXSffH1ekkenjsd/38Oo6V4YJZaPqxWwVk
 AGgZT3oJLng9ko3QgJuJY6bUKzY/KCOEiS/Rti7Ol9Ts5eIE11TZI4WX5JMh2hj26368ZK0
 3xFav5557w2TGXZXwUatx0OSBC+iEh1n1fc5IBcGP9k4L1v2EJtSKGEkRy10rqEeIf+yhel
 e9E9su/2F8xvqT8SX4ZKDIKWi/zMXtlFYQKDx0Tfr9sZlfHxj0vdkvAqCSTQBWjBpOkd9h5
 bxJbRK1sORqPG9wgP0YEX2fwbYVcmZOhkuYCzH60ZpsG4MNGfYeq1BNGWksLPYWJU2qSCeA
 mXsT0SposH6Z96Lzty/nTHru9ovi9DvqEVdZUBxrusihGooaMfeVzG7u2P7YsQyzf6zbQZp
 /Eu//YoNkMIfd6vls71Byztbp6IOSGG9gZm/G1w1IiBTbcopl4Il+eYw5Bt4uvcgxGI2kf4
 SHManW3y5c41lX7s5F8DsE03n9Hinyw4DaYqZMfGpmfO+KmL85YiI2uto4zZrzDMDuQHVY3
 8jJG5W173eMEeFxlKhwhv05wMe4gZOIwApb4RN3TzcgKvJW29spJsXm8UIicdXYWI/NxxPx
 jXu5lJRWXs3LJ1zOXRocFNoAEiG6dPB46i1w7/6LF5nwtHKoDYifz2xfjURgnu2h2Li/x1h
 y5CI2SjOSkE5UxJx1Q93GksMD3KvKK9R1madeip7yuf7UseNzrB4PsxMPnqnD+gugEXaiUV
 xMKmrEY2KMuy93LSzPoyP+blrxS0X+XPgXrZL63UMA2ohhsmb8y7ntzNI7nVczNqhsItgci
 Guzhi2YVXx5YU1nP9mv0HQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

