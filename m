Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3BC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E444240E30;
	Tue,  8 Sep 2026 14:41:22 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id B46E240ED2;
 Tue,  8 Sep 2026 14:41:20 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871278tec9e9c2a
X-QQ-Originating-IP: NJRJ5rfy62+9+Zml1c7dmwUWt1LPi5cP0W07Q3AWmmk=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3382580711347449843
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 09/15] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Tue,  8 Sep 2026 20:38:54 +0800
Message-ID: <816D38B02F55893E+20260908124047.2284-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ma/u5za4kb+sXKy/DHYr7Iy7joKUKQKMb7I3NNoAvyOkv9EB8rHla+Zt
 tAqwb7Y1WuJ40Y3x7k1HI6YacQVzqOnfPIMnsslcv3jpjWQCaHYi+2ejRxop2sXToDwshqO
 TZ71ZqX2LLvB5x8G16efkdtX/bP9DaUQB+U6x7ozVOErDqeBh99Ond331JWcHP7WcCW1KAo
 lKS5EvsHGaMCL50yP/HERHTbNO0m2M+HG7aPwenZM5Rh4fE37QBflCyvtOpDW1Y+Xkj6Y3k
 Y8bh99sfH3hLwwGWmI6A6UTMmEKDpqspuI8EehAvE6/66zX2W0CHtcuJMY035++K5osvR0j
 gJR/oIPWFkRbKh62JN5p0p5vDmhbw2880TPOcIkiMTyg+rDZG7wEgTOiNJlb1BirkveIP+F
 EDMG0XxdbmEIk1ckRexnAhYW2v9lbFAr1dmpC0tEF0hZd4Ha4BayIaGM2oEFWQdxgdQFI1A
 BeV8mEZMU/3UY5O5IGk2/r0jLM+D6gD1XtCltldpCQ9z8C8kWEt7iA4kzX4p/ReB3lVk5kI
 SHzx0hkl3mjOhP0IRqMs6X1RycsalcKcEI/0/wSY3SNfQAee5hBOYaaB8nYDi5mKs9UT0Rh
 /5k//1/c86uQ+4trOjWHslrp3tSIsR1SNeTCUgoh68rk7bKdoyIXZDkHLD0QzwNXWbZNgOI
 0IXs4WlYDON50CJh9AJf9Fpdcn6kSo0kwJgTgiakqBxJyU22PkrV7iarHCar6weSoBLhUWt
 AhyxrLIbpTVmuTkzBT+eBJ1BXSOCblG7izB0VbTjTm01uZay6mbR7XYHI9bvr3JTLIUWF5h
 lgpjo52B8Pkx82Azugml0YqT/LgDmv4xCXB0bpRSl1TgfwB5isYnO6Ox0YmnrpJ2LIW1S+7
 sX8xjXkCfRAC8OUh420iROte6XRWVj5FL2JkZP9Zkp/nGhs2BFOSXuX2Aqxk3cRrUNtuir0
 295y7zSQN/ElMYduzdO2sa6s9g3M0buULzLCjBsIbKG8D+oquIcXFqy4gbwEeS2XTwfl0NP
 gTTG7AA+i4bFxXx9ozFRaKK41KFbIJzh6CRO2HBKj/VOuHv3K8SOdL1OB2PtpOknJhU9XVf
 J0GayIqDjl9WYz0/kfBMPid/DtVA5XNxg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

When a port is started before the DAC cable is plugged in,
hot-plugging the cable never brings the link up and the port has to
be stopped and started again.

The AN73 watchdog txgbe_dev_e56_check_bp_event() is armed once in
txgbe_dev_start(). Its first tick finds no module, so
txgbe_xpcs_an_enabled() returns false and the handler returns without
re-arming itself. Once the cable is inserted, nobody polls the AN73
completion any more and the link stays down.

Re-arm the watchdog from txgbe_dev_detect_sfp() once a module has
been identified, cancelling any pending instance first so that only
one of them is running at a time. On the removal path, drop the
cached SFP type and cancel the watchdog. Also sample the
module-present pin (GPIO_EXT bit 2 on 25G, bit 4 on 40G) on every
watchdog tick, so that pulling the cable is noticed even if no GPIO
interrupt is delivered.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index bb4ff3c492..0711a28a5c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2987,6 +2987,20 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw)
 		return;
 
+	/* Sample the module-present pin on every tick. When the cable is
+	 * pulled, drop the cached SFP type so that txgbe_xpcs_an_enabled()
+	 * turns false and this alarm stops re-arming itself.
+	 */
+	if (hw->mac.type == txgbe_mac_aml)
+		value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_ABS_LS;
+	else if (hw->mac.type == txgbe_mac_aml40)
+		value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_PRST_LS;
+
+	if (value != 0 && hw->phy.sfp_type != txgbe_sfp_type_not_present) {
+		PMD_DRV_LOG(INFO, "SFP module removed, stop AN73 watchdog.");
+		hw->phy.sfp_type = txgbe_sfp_type_not_present;
+	}
+
 	if (!(txgbe_xpcs_an_enabled(hw)))
 		return;
 
@@ -3110,10 +3124,22 @@ txgbe_dev_detect_sfp(void *param)
 		PMD_DRV_LOG(ERR, "Unsupported SFP+ module type was detected.");
 	} else if (err == TXGBE_ERR_SFP_NOT_PRESENT) {
 		PMD_DRV_LOG(INFO, "SFP not present.");
+		/* Module removed: drop the cached type and stop the watchdog. */
+		hw->phy.sfp_type = txgbe_sfp_type_not_present;
+		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
 	} else if (err == 0) {
 		hw->mac.setup_sfp(hw);
 		PMD_DRV_LOG(INFO, "detected SFP+: %d", hw->phy.sfp_type);
 		txgbe_dev_setup_link_alarm_handler(dev);
+		/* Re-arm the AN73 watchdog for the newly inserted module, so
+		 * that only one instance of it is running at a time.
+		 */
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+			rte_eal_alarm_set(hw->bp_event_interval,
+					  txgbe_dev_e56_check_bp_event, dev);
+		}
 		txgbe_dev_link_update(dev, 0);
 	}
 }
-- 
2.55.0.windows.2

