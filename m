Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CBBCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12B842D0B;
	Tue, 29 Sep 2026 13:22:05 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id EF6EA427A9;
 Tue, 29 Sep 2026 13:22:00 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680916t99b77b38
X-QQ-Originating-IP: LVa8ZoRI/jHC2XH+Z2MuuJixYX5K+aqgByZdNlJqx8c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15815202819032202302
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 10/15] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Tue, 29 Sep 2026 19:18:10 +0800
Message-ID: <ABC343B9DEC3DDB7+20260929112119.4516-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NW+cWte1xz2zehHMDsQuwgJcTGNuby3NiXT6DSpg2ZtHw1sJeHapyPou
 K45jAhlluAF+KYHGJZYQrY9qGQtk+bL/a8U/BoEE42Q2s+dfsxS5X1qMrPk67Lgpydmh5m1
 bZp+q0+zVNV7ZnCORC+WoHFcOfG335gg7xuXB0TX8jcfWNV5Eo33bqOEb4l2Hm+GapaD6Ka
 CtujzyKxxSGkuZ2QXsMnwp8MQBCFBWJdMd26Xpq/2pmihvLz0nvtfiu4fqR1IAbZuejeVSN
 AaFLg0toL1S3BgZvHD6YwtsHSSdEaISRWNsV8a12J/xEAd6owsBNhUe98dP6VUeDr/ZemED
 x5pa+XBYL60/V3PLkG6jPQW3vP40mkDDwpFgRQJ9zLHM1NcEuD26sYAnxMHU7N+pHNMZ8OP
 qasjM5OVz/LFC8SUV8NfNmUCWmuQsDkc7dke2BQzaJkmCrlJxPHtGYzUcADelsryhs6cyxn
 K+2lvnqHCfJzd512WGRhf53X+MXycK76TJfOFkbH6+bgo78SgUp/APHJOMRPqqbCNSwkGWI
 Ad20xf+b00M9QyN8IQRXpskGqzJ6aZd1z6A2ZMLbZHjsqPXL25QZRLtMRtbMnmPfE/teOOQ
 OZmwAyJeezUE4a1aN573c+cXYhjii/ZCMRSPSsOgsiHkL6aqE6UYNYbIUVD2LFf/FKjTcTA
 oZsL1D+3SiRQEmhWxZ8aTGrgTloz2VFI+ej9nqDTNSt0Bq/hvv8TYK0marLIxFehdn2yOrT
 RRDOMzOsX4vOLtFXVHycDNyB9/2z8WxVnnxAf1rB4lDvm64Xu9rdbskY1AFoVN/GmWQR/56
 cmzjGSK6qGSzKHJ3NQTl5/YUrvVY1qOIaek+KCBj4rr7GZklgzWlZLi7g6YKUVa+fBT1RMC
 8KzIvmXpIm7aFbVno5X7fJmVD6POth7NRA7x+jFk/7+J3uYyxZo0WLCtZY9OcPc6Qtnyh7E
 Xh0rYXVRZ2misLQ4QsJM4jfuZ71t9C65sii40FTTXaDd9t00SXtnCNdWszUP+ph+9ZIGHgm
 ZZnH7JeNi2kcp+1UMEVezVBE04kKGd1MtKIVpt7nTRtk4uUYyq8B5E2rKnKKa8ytrNY0+3C
 USzx9+3HEHGSNyFdSdP+R13DUcnfv9+aA==
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
index c41d48437a..7481d45bf6 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2032,6 +2032,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3134,7 +3139,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
 				     rte_memory_order_acquire) == 0)
@@ -3146,6 +3151,11 @@ txgbe_dev_detect_sfp(void *param)
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
@@ -3189,6 +3199,14 @@ txgbe_dev_detect_sfp(void *param)
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

