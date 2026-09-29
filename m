Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F523CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEAB942D76;
	Tue, 29 Sep 2026 15:06:35 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id AF5D542D0B;
 Tue, 29 Sep 2026 15:06:32 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687188tf1467788
X-QQ-Originating-IP: E7wQa8ADTFg53IW8LHKab+0EGebdBm9QApa/SGwF36E=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 923559327680793506
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 06/15] net/txgbe: set i2c sda hold time
Date: Tue, 29 Sep 2026 21:04:37 +0800
Message-ID: <2D2AE43BFDF868BE+20260929130611.4871-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mo478EnjNuQn3lufJPWV/BC+1OxkN7pgmI5bwCbjeyV2HTcprkAphKII
 XlXAESaLrel0Flv/0k8HvvKOQRUTBslafCYPjXhcwLwy1fzgjHs8Dg6ZEq/dFlawQ/QAgN+
 NdHqPAF+y7QIf0/RBO/wV2H50uxoTf4dzSjcg4BwYyKlBsbBQUeAHbVASXcjdpnsxPQkcnm
 /ZLO5z0q6v+oopZgMM/9rGURwbriCqAWnHr9uY1ktlDLmKrjiGaAGd+UYvpB5x4or3S1sh6
 IaH1oNs5QJ2yKAUtuNoa/8R6odryPSA2/Z6rXqgSUhSGUQtZScLo+WRpr8GU2foVYn8Xs3q
 Y4UyZjmR5y9eTVLK28QMfwuv2xLyZ94NHSZGKNWQ9u84t+gll19PVz0Y0xv4w5dJaivGcUC
 r93vO4FM5cV8RApZE7W/46XEMay2PFMVt+Qzv5KjqzVuWplQYDGi+nDMgKdLzgIX2akjC9S
 uBTePxHPwpO3Wo5N146C9ag3kI4jkPzhPXCxoAKh27TffU/j2zP2W5YDFoTgzPsvROWN3RX
 XEZ2tb+ypDZTxD9fHq9/iO0O+DNZHXtl+tr9PSwJ6ME6haXji+B1MgQ54gy6DbBUmQzrErJ
 jwJ8ED8EuJmcWuIYFV3MON+2gtdwleFWZI72eiHPYbcO8bCQbRRL4l6GY2QGUa5bHUGelHw
 3YtCWB566d3MvSLM3sIJD3EmZeNN/ySra7BJFZgGe+w9yRYcuJ0GUYWyU3iXlovsgUy/XAL
 DPrlqbJWASX7vuYDspQ+qd3VtKy2BpMj1ogybNdL7ZArp6NVzVvZxZoqHZ6BvbCYoFJgW6P
 VI/DeGvmjNLvLu3xuI9FU79lE9RTdWVhlWC58HBD9tOmCo28uHwBTZAC2o/H25ne2AEM8GZ
 JfLZCmtHfYUn7o+SnJdJfRnkUN4npxeokW7BE/VchjhdkQyhKedu1eG1gRGCzM/51uPAWlD
 2+gimDaR4XrCAjc5uKlXM8v2DwrhrQRgRxZw7gwzLRoY/gtZ939GttX2FQrgJxrmVgm7Kyg
 KL2b8R13obqKJ+UYXGeVypi3gICPnS7eIYsgDP+0glNNfFWqPD67OGeQ3ZRQtQn2rrh0Cab
 RR6Iou2AbdhLXgUR2zKBSBLIu/3hqLHWvprlnjc02UV83g0ySZppRi6LtSVvOf9QQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

