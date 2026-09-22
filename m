Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85146C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47B5342EAB;
	Tue, 22 Sep 2026 14:54:52 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 1E21042EA6;
 Tue, 22 Sep 2026 14:54:49 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081687t830bc6d7
X-QQ-Originating-IP: QwfYUrKLfJvL0fl27i8I/vVFbZqt0FR9enzSe9ta3GE=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3509769844385035371
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 10/16] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Tue, 22 Sep 2026 20:37:43 +0800
Message-ID: <2A5C27386F11008B+20260922125414.3638-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwZsEbMvZ2Q74AjdnlW4GF6qp+P8GeuF0p5ecumWZUmd3jny76B59W3h
 s31gzr+e/2yCfK7Vy585zyAXwAdGO/BhbgymS5LZtCkSjf/d7nKgIgL7dJ+7hoersFOA1u8
 i+Va7vVdY+kUMo2OfQQRUVeceLeaPuqSdUb03FMsjaV9Ft7I2kko1f7lueCG3a8ck6StkZZ
 ryRZ1mRo+XhsRNI2Q4XhCVg41e7gqZZSzhgezFfC+qrzDASrwikYEoH/pCNUnF+dfrjdHAc
 v4j7fOwJw7QdD2derubHCxQJ8tYOs93rzOUD1iLosJwhfL+/vkyidyPOdIZqQqTJYe/7O3L
 R0JUGo6urVrNG7rQcrHGqJfEoExzMHxd+m5gYPO9oHZzG5KvFVPUAYU4dsCNcDeau/17Lx3
 mNMijEdafeEeOmYkLp1ZqxW7R/knxsms2OM4HNdNsHFCH5Qd8y+httWcKb6Ge1cKg8+gRd4
 39YJr/uwzwO4UBtu8eruKi+OlX8WKzbVg9qm3jj6YZZfBYPTOAlNN01FnQrMUcgRbjySIhk
 PhOdpmR2K+zpHH4rYr0gtOP2ks/xVaHcHNSlkN8c80TjcbNATUsVcT/sSq6g8LOR11XaB+H
 zzDzTmLcekEG8xmb779y8CJ7yRQim4k7wsAzKz7dQTSmtni+MARnFHmJsYrBN7yvEWYMO+B
 Fj55YFzRDKxtJPTEVxrY49VVzYeh2TrnRWyYKhiLpn6Nk8fUSbayYAlV5uuu9kT3PIWYgt4
 04ejEdKeLfhCPksLMnou9v352Dd7ef50Bx/2466fUD7jAQbBIGPe9w0H32mwnASclidia2c
 xZVPy6xVctNgCRSRWuTyEKkTYusxgIDfuw9mbD5+B2GwwCzJCO9EHFTvkFxu8uNklMwVd0O
 mC9U72G/fXINM3cnqHeey+avtll30QhkQmnXPzJJ9ZYoaHc0YMYW2rH7gX80RNlgFqPDgS7
 pEKAqOH3mVmuvhaytSUcZRcYMgtXDTw4mPuT2wu7BiOQPVz683w57raPryddOghVg78ZKwq
 1QHqfHyWqZYFN2WPFt1/+ucZWnJVUk4GZEHHgrFAZTFHFOaflvcLICYFkSD/J/0MQZUVejY
 3Ge1b2jbJOh3YNZVxMJ8zbLCnYK/tp7rw==
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
 drivers/net/txgbe/txgbe_ethdev.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 626015fae2..e7f8234146 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3001,6 +3001,23 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw)
 		return;
 
+	/* Sample the module-present pin on every tick. When the cable is
+	 * pulled, drop the cached SFP type so that txgbe_xpcs_an_enabled()
+	 * turns false and this alarm stops re-arming itself.
+	 */
+	if (!txgbe_is_backplane(hw)) {
+		if (hw->mac.type == txgbe_mac_aml)
+			value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_ABS_LS;
+		else if (hw->mac.type == txgbe_mac_aml40)
+			value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_PRST_LS;
+
+		if (value != 0 &&
+		    hw->phy.sfp_type != txgbe_sfp_type_not_present) {
+			PMD_DRV_LOG(INFO, "SFP module removed, stop AN73 watchdog.");
+			hw->phy.sfp_type = txgbe_sfp_type_not_present;
+		}
+	}
+
 	if (!(txgbe_xpcs_an_enabled(hw)))
 		return;
 
@@ -3126,10 +3143,22 @@ txgbe_dev_detect_sfp(void *param)
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

