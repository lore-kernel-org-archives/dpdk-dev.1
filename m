Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B06CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE72A42DA3;
	Tue, 29 Sep 2026 15:06:42 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id BF46542DA3;
 Tue, 29 Sep 2026 15:06:39 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687197t7dd470e8
X-QQ-Originating-IP: KPmN6lsn4tRDgqfpXhD/RmwC4wRX39EyncZPSwzF6a8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4593749429729536051
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 10/15] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Tue, 29 Sep 2026 21:04:41 +0800
Message-ID: <AC56AD7ADCD9534D+20260929130611.4871-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OTnfJ5NUztydeaFYJ8uhaqW3MuYWXzMZU7c2JFHYSeDgd5370pYqNh5+
 3D0p0DRLneVfYGuxAmaYzzBvaEDR31yCqPkvoA05T81FRp/QwUwV3j0e8tzk0gsEw9X06Ik
 W63SAHWYwtaI75NDc3mkZ6PQ9bPsau5HLszzwHd7RgHdC5XSF3KE+tx+Qi2lRoZI/v553lP
 aomDLVFyt4tRBj/cMUSINEI9cVQlMfYh0KB7iQBbWdnGzQXCqix0mqZAwVLLCzMD4M7tRLM
 JOVqJBrkN8Ftx1ufcOi+4TwIU7Hmm06G7HKTH+PHls283PMzBsCM9r59G8JOJgh9GfC7QJF
 IEqfet80/G92u4IPMjACMWTWxekxsZ9UJPp2/B6IKZ8Xf6dW9pqaG7Q5rTjTJbg7ssVoxuH
 4OEQsCGuUfD2n0ubNb2fuhD1AZABTfeTgpIH84r8lHyZFhRpZ1+dcMhfUeplEtkUehr1BQS
 U+9pKOLoM/JtOx33vLjpAyX8y4C6YTyEUETgBVS/FgVC1xD7z+yFDhwA47bB1HDZxpzCA1h
 tQQAlgbsURTf4GvceZsnRcHDIFdRJ9UoR2TkONP7ZZeSz5L3btyNAZmnZsxVXr6cJkBreNc
 afQpvyXIx6Jv+6GUhUmOY877UvMj5kcTn1TqVJTsMDOBoIlcPNxiqEoKsaHP1XFTokjRMfb
 gHhb1BLKdYI164mrbUFhuDnQCDap9uL2J+xM41iD5AyjkFqiK04B1R99L2NMUhHLB4b7wyh
 qVZjNVU0eeRUSbaBjmqOIQF5fpvfQnMd2Wqkrxg0zOze0gV7lD/SSZ3843Hz1uYy6YLUwGZ
 CZY7S+hjeoY0Vk3PamCg6c39mNOcUdUjdIIGa7jOwBq40yEWACyjYQVKk4P+0W5YUBMzWiI
 r+ySm8SUys2pTlqzsgR+vUE+J1fp96CLX4fWsRROrQZKy6vEnb0s0Qz1BR3A95bzuK58Kr2
 vffOEmJyrEReDgQGPeX42Rzuy1qb4QTyrYkgpBWLMvUhKYBh72RP53eKyQAaJyFMW/VR8ty
 cyuZ1WVq1q6JqCxLRTxj/wnRl51wqAxIwuCu2RRRnQ+7eHH3fJ30EbfgTt0wnCO91H1Jte7
 eXwKKF4IwK45Vkh54iJYyE7rXbK1XnE7EBlhSAZtgKpAn4V+JplXivlBeHRq77YFw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

Hot-plugging a DAC cable while an Amber-Lite 40G port is running
does not bring the link up. Two problems are in the way.

First, the 40G NIC never delivers the GPIO interrupt for module
insertion or removal, so txgbe_dev_detect_sfp() is not called and the
new module is never identified (the 25G part is not affected). Poll
the module-present level every 2 seconds instead. The poll skips the
identify step while the level is unchanged, and only re-arms itself
while the SFP/AN73 alarm gate is set, so that it cannot survive
txgbe_dev_stop().

Second, when the port is started with no module plugged in,
txgbe_set_link_to_amlite() times out and leaves hw->link_valid false.
The xpcs path of txgbe_setup_phy_link_aml40() never restores it, so
txgbe_e56_check_phy_link() and txgbe_check_mac_link_aml40() keep
forcing the link down even once AN73 has brought it up. Restore
link_valid on the xpcs path, as the non-xpcs path already does.

Fixes: a2d92608d3b0 ("net/txgbe: add GPIO configuration")
Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c |  7 +++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 20 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index d812adac69..2d3b32839c 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -177,6 +177,13 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		rte_spinlock_lock(&hw->phy_lock);
 		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
 		rte_spinlock_unlock(&hw->phy_lock);
+		/* Restore link_valid, as the non-xpcs path below does. An
+		 * earlier txgbe_set_link_to_amlite() timeout, for example when
+		 * the port was started with no module plugged in, left it
+		 * false, which keeps the check_phy_link and check_mac_link
+		 * gates forcing the link down even after AN73 brings it up.
+		 */
+		hw->link_valid = true;
 		return status;
 	}
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 83ef9d8bfc..222c82694e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1984,6 +1984,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
 		rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+		/* The 40G NIC does not deliver a GPIO interrupt on module
+		 * insertion or removal, so poll the module-present level.
+		 */
+		if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw))
+			rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
 	}
 
 	if (tm_conf->root && !tm_conf->committed)
@@ -3068,7 +3073,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
 				     rte_memory_order_acquire) == 0)
@@ -3080,6 +3085,11 @@ txgbe_dev_detect_sfp(void *param)
 			err = TXGBE_ERR_SFP_NOT_PRESENT;
 			goto out;
 		}
+		/* The level is unchanged since the last poll, so the cached
+		 * module type is still valid and identify can be skipped.
+		 */
+		if (hw->phy.sfp_type != txgbe_sfp_type_not_present)
+			goto rearm;
 	}
 
 	if (hw->mac.type == txgbe_mac_aml) {
@@ -3123,6 +3133,14 @@ txgbe_dev_detect_sfp(void *param)
 		}
 		txgbe_dev_link_update(dev, 0);
 	}
+
+rearm:
+	if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw) &&
+	    rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) != 0) {
+		rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
+		rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
+	}
 }
 
 static void
-- 
2.55.0.windows.2

