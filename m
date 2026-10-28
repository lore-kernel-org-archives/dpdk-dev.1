Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD6606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:42:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A7C540DDA;
	Wed, 28 Oct 2026 11:40:50 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTPS id A78E240B91;
 Wed, 28 Oct 2026 11:40:43 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184036t0e3b09e1
X-QQ-Originating-IP: mLIilHMalaR51JKzm+Iz8NCz/DF5VpTf7Fa0ET9sLuo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17690734180860190199
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 16/17] net/txgbe: respect manual link-down on Amber-Lite
Date: Wed, 28 Oct 2026 18:34:05 +0800
Message-ID: <2B4E83564F31C866+20261028103913.10188-17-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N/BWsBa1EZaJ/0Ljc8X8R+5+h+2DUwHv+XI+H9dwiBrxaV8TuihbP6XW
 yEOwo20rQ3Z+lkiM7U81BFfhnFmOJ0GQr/wDCZ4WUshgj+t0xCn4IDnyc/gWcV1cPofaxlU
 M89l/X1D7lLbI96DOrvk4xE8YtKQJl39Oz/21mwddYDXAYabUcpYuB5sLSGNkgsNfGoDhV7
 CJtGpLxv2cZhtN38tipZV07Pb1a78m3fvRKIuLqemIW2Vh2kvBUCdA97Purq5ZRBzJb2Cne
 h3kZR5tt9+nWPETscjEfwgmTcLTBgVWGm6D1zy8ThifsP3fEbXl1mzphfnME6qDsQQXGPfy
 lJXQitpdqZCXUy0rvAW6nnx19k4sut8YbaNwjmxxXhZ+V8CTJIu0/RjYA+ahBJBTw1ndeJi
 u57nngaA0nNO2PEq2Gh2vbIyV6AVGv56AQYclY8vKHPm1BX8ZCNpSfsfjvrNcUImFCm5V4b
 8Vx9ZgBJA9JozCNt+tK6dDhO9H/EQP1qB87cCPLdK64VVZVKx69LisJNQS45A+FaHZnKBOX
 BefFzgihFbEXhapKsC8gwm7nagTXwQEyrP+V7wLH3r7zvMaB3V9/1f68mn2R8E2Yl15DjKL
 HmafCLwzxoCw3fAKCBmqpKfRDA5LIWkeDH4ymCxFTg0Nc2dLu+4phsxLgwlfuG3y7nPJTDb
 BOpKIJf9YF7Dk6WTS7Fm6H6SFfggYUcukWIa6RQRQnaEeq/ioQcY6vEbpjKCj8X1syMbjqJ
 A2RhUPWH4Wqqj0yro2fmw9jzhvlUJfU7VqVk1QVEV3hDrJrF0mCE1C3rzdDvCWmDFX6ZYy7
 fePOJEFWLSeTWfLJKC2pvHYW/nbJdY3HP3MpYFQ3+GeFLmJLd2NldnENFGIasB87QJ+j8yM
 kz+iCt2xU5KHSwsHBVx8vq4jDzNvF9wmZJKkzUwrwO7DEzn4xn6Mxqn9SEqzkXliGCq8xrr
 MDgTeVArKyL+5uBbXPkvOoTWi67mLYMIfJ0qODOZP46WAAsIfkOgXQ9l3Eow0SbCslzBYe+
 QsmK/ISL4ce2R1pwPNDXEw7/wrKC/xrbYTFLCiqUbhbFCOltXUfpEecTDZ1iPPpqnAZ2hHO
 /OjgFVhCVxCCtuh19swdH0o9Wjnwbt4nOU7loX6kFJQwb075KbaeBIpfDaASap5Eg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

After rte_eth_dev_set_link_down() the port can come back up without a
corresponding rte_eth_dev_set_link_up(). Three paths reprogram the PHY
while the port is down:

- txgbe_dev_e56_check_bp_event() (the AN73 watchdog): keeps driving
  negotiation while the link is down and auto-negotiation is enabled.
- txgbe_dev_setup_link_alarm_handler_aml(): runs setup_link() from the
  2 s retry armed by txgbe_setup_mac_link_aml() and from the link
  thread.
- txgbe_dev_detect_sfp(): calls txgbe_dev_setup_link_alarm_handler(),
  which ignores the administrative state, after identifying a module.

The first two are gated on hw->dev_start before acquire_swfw_sync() and
setup_link(); the third only around the setup call, so identification
keeps running. It has to keep running: no setup path re-identifies the
module by itself, since txgbe_setup_phy_link_aml() never identifies and
txgbe_setup_phy_link_aml40() identifies only when the cached type is
not present. A module swapped while the port is down would otherwise be
configured as the module that was there before, out of hw->phy.sfp_type.

set_link_down() then stops what is already running:

- clears hw->dev_start first, so a callback that starts later stops at
  its gate;
- calls rte_eal_alarm_cancel(), which returns only after a matching
  callback that is already running has finished;
- waits for the link thread with txgbe_dev_wait_setup_link_complete(),
  which with timeout 0 has no bound and logs an error every 9 s;
- cancels the handler once more: the link thread runs the same handler
  and can arm a 2 s retry that the earlier cancel never saw;
- calls hw->mac.disable_tx_laser() last; on a 40G DAC that clears the
  transmit and receive enables in PMD_CFG0.

set_link_up() restarts the flow for both Amber-Lite MACs. The watchdog
is cancelled before it is armed because rte_eal_alarm_set() adds an
entry on every call without looking for an existing one, and each entry
arms the next when it fires: arming twice leaves two chains running
side by side. Link setup now runs for txgbe_mac_aml too and returns
-EIO on failure; txgbe_setup_phy_link_aml() resets the PHY and restarts
AN73 (when auto-negotiation is enabled).

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 40 ++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 043c96b747..9dbdbfa309 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2213,7 +2213,8 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 		/* Turn on the laser */
 		hw->mac.enable_tx_laser(hw);
 
-		if (hw->mac.type == txgbe_mac_aml40) {
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {
 			speed = hw->phy.autoneg_advertised;
 			if (speed == 0) {
 				err = hw->mac.get_link_capabilities(hw, &speed, &autoneg);
@@ -2227,12 +2228,33 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 		}
 
 		hw->dev_start = true;
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+			rte_eal_alarm_set(hw->bp_event_interval,
+					  txgbe_dev_e56_check_bp_event, dev);
+		}
 		txgbe_dev_link_update(dev, 0);
 	}
 
 	return 0;
 }
 
+static void
+txgbe_stop_link_handlers(struct rte_eth_dev *dev)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+
+	if (hw->mac.type != txgbe_mac_aml &&
+	    hw->mac.type != txgbe_mac_aml40)
+		return;
+
+	rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+	rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
+	txgbe_dev_wait_setup_link_complete(dev, 0);
+	rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
+}
+
 /*
  * Set device link down: disable tx.
  */
@@ -2245,9 +2267,11 @@ txgbe_dev_set_link_down(struct rte_eth_dev *dev)
 		/* Turn off the copper */
 		hw->phy.set_phy_power(hw, false);
 	} else {
+		hw->dev_start = false;
+		txgbe_stop_link_handlers(dev);
+
 		/* Turn off the laser */
 		hw->mac.disable_tx_laser(hw);
-		hw->dev_start = false;
 		txgbe_dev_link_update(dev, 0);
 	}
 
@@ -3073,8 +3097,8 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw->devarg.auto_neg)
 		return;
 
-	/* only continue if link is down */
-	if (dev->data->dev_link.link_status)
+	/* Continue only for an administratively up port with link down. */
+	if (!hw->dev_start || dev->data->dev_link.link_status)
 		goto out;
 
 	value = rd32_epcs(hw, VR_AN_INTR);
@@ -3232,7 +3256,8 @@ txgbe_dev_detect_sfp(void *param)
 	} else if (err == 0) {
 		hw->mac.setup_sfp(hw);
 		PMD_DRV_LOG(INFO, "detected SFP+: %d", hw->phy.sfp_type);
-		txgbe_dev_setup_link_alarm_handler(dev);
+		if (hw->dev_start)
+			txgbe_dev_setup_link_alarm_handler(dev);
 		/* Re-arm the AN73 watchdog for the newly inserted module, so
 		 * that only one instance of it is running at a time.
 		 */
@@ -3412,6 +3437,11 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 	bool autoneg = false;
 	u32 gssr = hw->phy.phy_semaphore_mask;
 
+	if (!hw->dev_start) {
+		intr->flags &= ~TXGBE_FLAG_NEED_LINK_CONFIG;
+		return;
+	}
+
 	speed = hw->phy.autoneg_advertised;
 	if (!speed)
 		hw->mac.get_link_capabilities(hw, &speed, &autoneg);
-- 
2.55.0.windows.2

