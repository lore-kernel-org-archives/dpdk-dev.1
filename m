Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4270606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D337D40A71;
	Fri, 23 Oct 2026 13:08:06 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5148240A6D;
 Fri, 23 Oct 2026 13:08:04 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753680td2b48fe2
X-QQ-Originating-IP: /90zqAftQtz2hoMyzX7wIamLuC9fJjJa4ng6AFtNUkY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1855122011673017057
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 06/17] net/txgbe: set i2c sda hold time
Date: Fri, 23 Oct 2026 19:03:44 +0800
Message-ID: <DAA191A362FB3241+20261023110728.3975-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MKD6Cx7ZSeC2HwShYBL+KzVXbuwa4Lao01aUbD7uUPsfycOOQqh7uDZM
 dE35kwhRB1yXkEd6KFDJFJzG2Ii7TFs9WJx6XJrNGt8gxTnEsNZtfRz7llqyNe8qKVWH/Wc
 lGoKy3M0T41/Nk8tjU+tydyfOOzSl5gfrrBf+DoVQbJMbGTi6TpqLMA8GRloJGmoK5O5KCw
 D69zk/OW3cbYRqcRm5xGc94ymSZYuCtPHKP5xoXbbpjCosPj97tdPlHN0DuuFY0ENc71gzj
 yo6XjYgHJbGa3muZnqDM4UfbhHNvDQV93LTs0n7SnwDiYHm4+5b60L7wEE4JFs5W5ctwHAt
 G9d+BtSlhKVg1AlEyeh2ZzqV8LWgEf1a9H2YURl7tcxxPby/k5n6TPDvMqHfPerROagVJbN
 iZ3vlF1n8KwqO4eKdRYMJMict3XagsXLrs84HH3j1O5bfZD0u+esEQ7/5yNGjienwDajL32
 7upiXbW7EnX3B5nbiEYWTw+5l2a4BvY0vcLfVshPGc3MjDtQwuB3ig0t2IiITGzEbPKZePw
 HIKGGAUj+w0QPuyZjqe2da/rmvxplBl0pYdjxPPogCOQHlI69nsZ6GjdevrV3TlsYYXhyAB
 JhOi0lVEXokQz1rTRwxM2TOSW7oebvdA9rsDvZqureBbE1Bv1ZEXkY41FQz5b9xjCGR7kj2
 ffPlefd/fArRxgAgWtJcOG8hQZgh4GcHUyIwTnpf7glJLSuFkCFSK86AftFmLY+INW8HMi9
 IX0wheQUuDbqEWkdyQ0gC5POMuzZaUTpmQHDT9/hz807uVbVi3C8bMFbo3PSiBDEDuZ3ZfM
 tEevUQm6wEBF8829Y7RA3+PYmcFwMedq1lvElb5/7kSDHKuFgbIplq+sXKoj1D2rSVjVO0Z
 YNo8fzSE4Yen3FQvnc9ebgd8nUqgh+JdhdZVYt04i7xcc0UZ9230MGEVl2r79A6Jm8WPxHc
 FoStsRSiL/kbar+R4JmfungjhLXFiagNr7BlnuBIoWR94Ny6Yz4QG4T0jRWCQlQVvFCme7p
 RUEDir3Ub3mBiHTtW7gQmO7eq1jbrckpXHVRmyISo14I+rbtnDDN2mllo7R0LgLIaxCxr3M
 /15rTBWWxnGG/i8Ivwl16Caa+ivGFVHew==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

