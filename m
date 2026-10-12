Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24609CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 442B340658;
	Mon, 12 Oct 2026 13:05:48 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id E162640609;
 Mon, 12 Oct 2026 13:05:44 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803141t4881b864
X-QQ-Originating-IP: Am536UinuHi3PBdp+8IOZuB0Vet2EeWOgPTMXa6T4kU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17623865939983491149
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 06/16] net/txgbe: set i2c sda hold time
Date: Mon, 12 Oct 2026 18:56:23 +0800
Message-ID: <FF17B80750766D3F+20261012110518.1911-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OHv85Jr8Tf/k5xzzL02IlF8KolgTismAXAGeU+6nWU0qCPOnOuEJYJdv
 X/nkS53Or9uMHdmCx/D2s/mqyohSMMSEdBVQFpwwq+ssuwKsEgkc5+fyufUKwpZ8dRzWXEb
 3B6lIvCNY9QbaueDtUeiKnQ+Sp8gDYNbV/hUvOrbxctkgbOBxwlOnCU8f22zUV6Um/a2F6A
 WAnWnKb8g17AbFpwF5dBX7iNr3VAUTD2lATlFH01j04EHPbA3CZTqfxEE9HfIezjZUYlpg+
 TUW7xeQp2uvUuO9UfetNHLJbkeP7gubMd9E0WyqJTQ13sgwFV7rWFRaa2LebJZBE2OeyHyk
 1PWhgZ9jvrkx9dTHXBz0b85eDpzqlemY0um4oxWab/Gt9A1hyU4x+X+szltW/tYi3rDIx+M
 q8GCFefkfHOfuDyz0jdB558nokDrWKpM9zN66nmzU4UdJu6Vq0c+/faqqdb73gm/j3q0Jk2
 jIfR/R6GusJIdlowhtlX0tXCWjIhJuUned28igt9JeEh+uVvczdIBIviZ1VVoSLTFtVyvpZ
 hwYXdmkcQkxdkBHLMSOMd6z1aXtc/jWzErxTsjDphrjBrjzFJqBZeuF0nVIDuxSES1if0Yh
 Mlq4IyQlFOO2Ia/RvIHM/imCVusg3uKEjTiPkuOB3VaRM6fke8zr8G31gemisNFTpbMzUu7
 Q3O2DnkP16Y6rIDprAEJTO112gE66kaCJhm8fzKWFesWvGPVjfrY077sRW8D/LDzQHJtv7t
 TukTzGSCLn5le0/ktRELt9+RAS9ubf7HYXUtVQAYYz0fqp/88hwelGESfh1RV58NQ9aBVoR
 HDlbopJom4LBXedTubxiVNxdETK3M2qbo9+rc1Ru+KF9AZMG7w+NtvNURbqjneJtu084IKd
 ERWfkOvGCrykK8LT55UbqUj0w2+SgNAmPzDQr1x5UOFAL4wO//gebGl61WKXZtlhBxfVfiU
 5OdUdcBJt4PW9TOg3mlHiNmRbHjhMfDQsCc3JciXr7JPPKbN38l9WBuDvLhP9M5KJlwiAe3
 0FZfK00MZvlnRLohas4q+PbKz/5vmYsPL8Qv4HjS5lIcelwElVEcyXgmSYg1U3CUwgRexiE
 aeVyuxqM9sic3JSYSQxuK9VzNDooBjvLepxaaNayJUW
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

