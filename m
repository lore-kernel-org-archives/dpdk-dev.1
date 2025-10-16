Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5C8CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BA0C4279B;
	Thu, 16 Oct 2025 13:20:01 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4F907427D0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:58 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613594teb7c94d1
X-QQ-Originating-IP: a+NPY0UkyOKoBntfSzrs+tguniPs56uRecsqFlBFJlA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10486462360672187480
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 15/21] net/txgbe: add support for TX laser enable/disable
Date: Thu, 16 Oct 2025 19:17:29 +0800
Message-Id: <20251016111736.25372-16-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MXmLQBZitZnEwcbHp5I+C/ZMz8eDQwSZ1gS/C3Z9u2c3pkRf4SnVx/YJ
 wjVl1az9L8cKlK0d0Vy38pgs3o/laWRgdMB6HgYb/kehRwlaALic4wjdV3Q9A/jDJ7x9TYY
 O6e7IWgW/3bxK1Dtz9K7mE/Zm5ZuN7tQVvfVSYy3ZRX1YtHreXFvfyb+ezdQj3gjiFiaW1j
 BjWwjIr5bY6bXrUGKRkIke/iVCN6il4+ncrXczbx2O+8uIqWMNdBG3hMz3abJkqnHJhBVZb
 dv2CKMUP5yXF/9JsJu3AbGpRY0+NMZZ/YMD9rb0zjNo2irPad68YL1XhlNEBQz4EQho+dEV
 KeaBOnQz5LgtJqHEQTZFqhQFNs6kXKo5FrsoihIJu6yJLbynwRgyVnDGS4ODORhGoVuEWSy
 PPV53ZlawasIMjScS9EEhTUH3QeK6t8QQm0K101S1ZhR5emepz30umCB3Xp5c1bLKhGXXr+
 0UfFQCmQT98argy6/q/lPdrYgQyEKzyn1d2P5tVxtZr6iEi1OwF/P4jJrstu+JRG549jjFT
 UbLzQxbN6PNm7yzwdj900shICOhe2/+f7gllO9PKF9Fo9SzGEacrlj9EkN6aJAUtBw/etlH
 3x7hYpO9AYqiqbMabsT9cwM1D7kRMQ4WqUGKpPmi7iUKqEiV9P+DFGoFW/urmvWLZrkwqpC
 9Q+iCjXc4BQdw/6ogT7FF1+UfoSLIrWJQuG/9VDhTazxSO9PBmAgo9xsGhX9ZjSUxjenozX
 Rqv4AqI+iMApjbWQuln3Zjju7BTM/kshX10UR+whc7AFC6ltpgJONMjGD8zlHd/drWsLQh8
 GuINZTtc35ZrTRqkxCysbHSuQBZ0ggOAQeiB+AbfY/veymjzE9gTFgXBW6wN9T4dgI6pjBd
 XrtcdLsxKhMutfmGWLKmGCK7fR7VPnyDTgvC1YbhCvDfDupHK8r24QoGruoChX2U5Pnq0C2
 3S7frh0AZVG0D+c4kI8HrDVUH4q2+0Hjv/1wj4oK9Gyo9S0FVSgO5qIGd7VMsWt0D9UynKr
 SW0M3nrfeV/szkybRB2bxkfRqXN2fDIevU2MYDGtzmgsObJtVeGT2d8mJQ2CCi4pftgYXl2
 K1T9cLJE9X2kloE4kCX8L8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

