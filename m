Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E0CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2EF540E16;
	Tue, 30 Sep 2025 12:01:02 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 698A040DDD
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:00 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226454t45342c0e
X-QQ-Originating-IP: YARfIMQFnQuWZOILwSn4yay2gzB9V7jqeZmnFlYilDk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12604399481257037751
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 15/20] net/txgbe: add support for TX laser enable/disable
Date: Tue, 30 Sep 2025 17:59:47 +0800
Message-Id: <20250930095953.18508-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M7uElAZZZMmFLEvVcHfAKDYJFa8GJ9Xg40j+HCJClCSfsZb2VIlyJA3B
 I1Tp2eIknqaOBkn/HAnd0z6MHKomC0QFh7FKEc/jgFU7W3vLy+bbDgPSL9K5hmZBrhnlhl+
 5DGpJ3nBb+dc8Eu5ZC/1qSNUiayGUC3OcRvdbHViPnshkzdiPHfZmd3cYdyzoYjl83lcR/X
 v/bE0/3Kf4ElalNkbTXUwAqBoWgyyGtQg87xuTD0LHgEx607MAdsarWT8kGolYg8YdQ3hUo
 MAqAJZCcO9ywJv9qUjkMhqrKJShGpvEtL5/VE5xVcjbJoHLGEJVGM7h9NxAPzkYGSNnMkC6
 vYDNd2bwcSBUHgy/Y/XR24WAbawMwNcN65FrwpFaD+/xB9Ersa7uornKn6cZRS0AgGTxWzw
 Lh8QsEqPPWVWxFp6l/OPssCu6W7saP3r8ZhNxYvohKxuR09NmE0TvmjCIeV8coTIHAr53wm
 glkz5CzrbgYe7c0KFx8jLJMGHEzhbDc/XsqhZxTp4iBcSToppv3hHJDS23ELu7A3aMve7FR
 vDQ1+u6gMOSEk2vLNe6CvgWsw9UlkM3CvuCBGcG8kfvqoRt0SV5y1na1JSJgecAR9eQHQBb
 eorknKQWD9LWXXPBAtgERYDimGISbLva2uEMrqG1Ew+RCeOb6+Di8ANmr2EiikTuerGQflT
 UsZ6SZEmPidlNMxC1LdUc2IovfQbHmwAmAxQV3N3qPpkvcRy9Imw6822JpO/KK12pf8Ruzx
 YGW91zN/IiAoydaZqWy8sA7pEX06/kvCfdrjLJl7+PIacFXs2jQnIn6w/tlON0lyk0cCTcR
 z7Koy9Geq2gOf+zviSEaY5xH0+KqXpdyF3w82JkLVSoWgEtioCX8IkYy+KUgeR30WjtzSQr
 5XIC/SeUnaRQGA3BNlV7w9CUkKa0Q4+tdkONIgure3mKQ9ujDwAxLVQ00OYJFxWxw14BnsC
 6BxVF2qq1S/gDtlIsVs8zYU/Mdl9xXS25rNbe6MqMClSrqfb7SHzKuFWerwTwkADsYIbN0m
 4YDPz+X6BPF5DpqQiEMFyaeF9f99bKvOQo7+/Xqty9xRnl2GsdOMbsYm8QbbFu5L2VdRkLD
 Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add enable/disable TX laser configuration code for Amber-Lite NICs.
Due to hardware design differences, the GPIO controlling the TX
laser on Amber-Lite NICs differs from Sapphire NICs, requiring
corresponding configuration changes.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 31 ++++++++++++++++++++++++-----
 drivers/net/txgbe/base/txgbe_regs.h | 10 ++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index d845fd0a69..3cbb21a686 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -3179,12 +3179,28 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 {
 	u32 esdp_reg = rd32(hw, TXGBE_GPIODATA);
 
-	if (txgbe_close_notify(hw))
-		txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_LEDCTL_10G |
-				TXGBE_LEDCTL_1G | TXGBE_LEDCTL_ACTIVE);
+	if (txgbe_close_notify(hw)) {
+		/* over write led when ifconfig down */
+		if (hw->mac.type == txgbe_mac_aml40) {
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_AMLITE_LED_LINK_40G |
+					TXGBE_AMLITE_LED_LINK_ACTIVE);
+		} else if  (hw->mac.type == txgbe_mac_aml)
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_AMLITE_LED_LINK_25G |
+					TXGBE_AMLITE_LED_LINK_10G | TXGBE_AMLITE_LED_LINK_ACTIVE);
+		else
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_LEDCTL_10G |
+					TXGBE_LEDCTL_1G | TXGBE_LEDCTL_ACTIVE);
+	}
 
 	/* Disable Tx laser; allow 100us to go dark per spec */
-	esdp_reg |= (TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	if (hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		esdp_reg &= ~TXGBE_GPIOBIT_1;
+	} else if (hw->mac.type == txgbe_mac_aml) {
+		esdp_reg |= TXGBE_GPIOBIT_1;
+	} else {
+		esdp_reg |= (TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	}
 	wr32(hw, TXGBE_GPIODATA, esdp_reg);
 	txgbe_flush(hw);
 	usec_delay(100);
@@ -3206,7 +3222,12 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 		wr32(hw, TXGBE_LEDCTL, 0);
 
 	/* Enable Tx laser; allow 100ms to light up */
-	esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	if (hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		esdp_reg |= TXGBE_GPIOBIT_1;
+	} else {
+		esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	}
 	wr32(hw, TXGBE_GPIODATA, esdp_reg);
 	txgbe_flush(hw);
 	msec_delay(100);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 00c41a5b86..2e0ac9c742 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -302,6 +302,16 @@
 #define   TXGBE_PORT_LINK1000M          MS(2, 0x1)
 #define   TXGBE_PORT_LINK100M           MS(3, 0x1)
 #define   TXGBE_PORT_LANID(r)           RS(r, 8, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_BSY_SEL  MS(5, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_10G_SEL  MS(4, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_25G_SEL  MS(3, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_40G_SEL  MS(2, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_50G_SEL  MS(1, 0x1)
+#define   TXGBE_AMLITE_LED_LINK_ACTIVE    TXGBE_AMLITE_CFG_LED_CTL_LINK_BSY_SEL
+#define   TXGBE_AMLITE_LED_LINK_10G       TXGBE_AMLITE_CFG_LED_CTL_LINK_10G_SEL
+#define   TXGBE_AMLITE_LED_LINK_25G       TXGBE_AMLITE_CFG_LED_CTL_LINK_25G_SEL
+#define   TXGBE_AMLITE_LED_LINK_40G       TXGBE_AMLITE_CFG_LED_CTL_LINK_40G_SEL
+#define   TXGBE_AMLITE_LED_LINK_50G       TXGBE_AMLITE_CFG_LED_CTL_LINK_50G_SEL
 #define TXGBE_EXTAG                     0x014408
 #define   TXGBE_EXTAG_ETAG_MASK         MS(0, 0xFFFF)
 #define   TXGBE_EXTAG_ETAG(v)           LS(v, 0, 0xFFFF)
-- 
2.21.0.windows.1

