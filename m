Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C8E42E62;
	Wed, 30 Sep 2026 12:21:16 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id C015842E62;
 Wed, 30 Sep 2026 12:21:13 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763669tbfedc7d7
X-QQ-Originating-IP: 9A5U6F1QuI2hpZvdXwBYdukbAGEaLWwE2k5bXZtfyWs=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:21:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1072247120453609239
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 10/15] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Wed, 30 Sep 2026 18:17:57 +0800
Message-ID: <C4BB8907786A5435+20260930102042.2214-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MPeDaT9v3nTZyuowjDNlUX+oO10EQ1DsCk7mse7WSRTpCyu5/KcgIldU
 rKHh02HW3SN4U1RAnX9ztyiLJs+TiskjGoiDhZ36jrWJkQ6IhlNKhGDQ7QwKESManY+MElq
 dlOffwqtpn+tz5qfnuGbo+tPkb0VfoJqmCKd7B0sQJJbQYd1Jky1Sr29vRdpk6fe484hw9F
 e71jrDhKaKGBt7EAfS4sIIYAD0JARAT0yl6BC/bvdEQH33/xJb19wqEk/vHCrOVPH4DGhmv
 WQpoXTjsNF7bSmkoLvAz/wktKXl21QAKpXTJzQoh8X0n1SQWZ1gw/bD59G3I1m68V3HLkOY
 zB9tj8GPzJDDJdHAxn/UKb7mAkTj/nCVaHfLwuTn8Is9N8zzP2BQutbNc8323nRFL8nYMKZ
 5fYQ1Ick97Vz369EsKvOIyV5Ec5vCFPQZIuoK7Gp0ekPcDL0XlqbTK0ycPQCGKglei9znMv
 NFkjynV0tWx5eEFWxTXXS6JNvp0r7xnXRjilMIJDqwA60g3rdVZ/bGLRBaz/41VdMsOe0Gf
 iXX7w+5mPlraGDkRQiZwFWwYyV9SXSvyd83D0QFOnURssgJC8CteHauW9hin+P8yKedQBU+
 YAZVs6H4OqIKWMbulOOdJ74U/ecadALHT6CwYByXv3JedNR2vq7ICnRtm961ZlHMrZ7jTTF
 ydIlGgfn6olLDNrMF6OFHyK/dkaWgSydR/7PC4AM4aajlkYw5Wu/6xWF1ID8xwwSQkLTFet
 au3rwzkLHPydwjTnc1Dps0jZ8uiRP8ChhxgXSrsq0UR0MLt2IJTT0WKNkQtnMQBU7cipY5c
 juNIuCytEXGnNSCF61QuhBpBCJbDhVdxO3FQS//ZR6k8lEPWXCkBJvmKu989fc+6G7hWOHQ
 N4xjpxZsv7DRgLLloa43b9eZ4YeaJZo9Jmy6lYPIHoh6CqDTMobSYEIWpkMgEyUnEdnfTmE
 dDl9l4w8iv/UdJYostp+8umTpnYvXa1n2BioBFkEzEFjl4wLVMMfO59+lA+GLdoUAESJJyi
 tcD/gSUXUNum4u5eGky8K1Mw1y7suKcnhIDvG65FZbWRPC0cLmLT65BzwyuTkDB8VpTlJSu
 Kz+glDgy/s5O0VDM0Uyc/5vH5693vh3ztUne0+s3W2D
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

