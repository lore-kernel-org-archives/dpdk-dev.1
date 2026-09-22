Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8DC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F12CE42E54;
	Tue, 22 Sep 2026 14:54:41 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 1470442E69;
 Tue, 22 Sep 2026 14:54:39 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081676t47e3b47c
X-QQ-Originating-IP: 01wTrWlkdg0FqecrXL7633WuaznMfwBMzYpsoxB4O3U=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16189831480884725209
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 06/16] net/txgbe: set i2c sda hold time
Date: Tue, 22 Sep 2026 20:37:39 +0800
Message-ID: <38C6E30036B5FD3E+20260922125414.3638-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M1v+UkG2MoDhUOM1kQN44eFHpOGctj1j3njQZi7KfRWPwIcDVL4SUTYF
 FEQnh4JdHyOmZuL4y5FzgLkU1uirqntbT0+jPs4355hjPAibFMCL7adfCcRMPik5Xa6aLfw
 FWsdlssoDhrm1suMVfPqF118HYh1pn0W/D04eQQf37UxwR6hsGA8okqpigvPqQVihkmFux0
 x1vQPjOZPuZ2QJXqrLClvcy+LVeywJh6FVL2YQW3Q3SQwth9+Pzbyeg4PDWwGulzEPw7KXP
 QCqD4bo9cXryrJ4J74NRfS5m+pylrGbGckD5/Qx+qjnf1/ZRvYvjNEWHBWXfQLIbNX3tgvN
 frxw6AUJoVPu8DJNn7Tb4HJKE7gmIhGeMOBSd4lMu37WmXHXDuwlqUpJs0wffSLtIcgKlNi
 Vpm2UGrsQrTVT/fPjvMzNB+CrfESZ9ldM6cHblm6L/gnRLf4xYMkTkaieZntOYFfwmcTLKf
 7pogcE9OGcg/wa1g2VUbrakf/Ujw7EKNKPUThvh0QOg0OmYRizkxIx1M80CA+V7PfUejPPx
 +ZASssYWFGlheXlB10Axxnhu3vvvgKDSOBoo8DDH8Crm6ySMYuYw76JpfN47nuiWU+7tYZe
 WjyNtly2niFGq/XuIYvgbt7/zO+UHo9URMnih9/tI6RBT34L2o6gWRadj9+JvUZW6IwuNhX
 4grfDHkQAnqbdWWKPuULmnIbboKO5LoWhCbJ+/SF++rHs0GSaQcyJOBb+VJEkGW+z2W/2wX
 G5LsitOAk8PHbGj3wu58pyEysctpF0N6jffMpNlmTJmrZiUDU3Zt1kf8d0vapTAaa0M1Wm1
 DLxS6zuRYwJtXtKivWT0asjzu5Pjgj4I3WxrU/N9BmP11ZJfE8zJeRi5zAHAWhJm34O0aD5
 rjePaODrFvLraSsA+M0Mu9P24KGqeweAJlCU9iTG9wn8c5zOnylUifBo8NaZErhz3Ohf7Rh
 w0WDFPVhL41iqa6ckKF0/bksQD+cMy4uSKIvuAzNqY9lQRdMX98KyaBz4Nx8T8zxBDaq/nq
 OSU009iNgnRnIOwbC+U/SqAyQn168IZSLSFeL8LNnPo16qMI0wGS/wiFKEYGG8/qTSy0+EX
 cV68AuetJ/UW/oXX+C0SumuMcX+Ioj5nA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

