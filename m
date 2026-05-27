Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21ACD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BA4040E19;
	Wed, 27 May 2026 15:04:18 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id AA4684067C;
 Wed, 27 May 2026 15:04:14 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887051t77cca9e7
X-QQ-Originating-IP: 7ltjKKvOcnG7SPoD8kwCmu1qLCYFm4W+PaUD3knBgVM=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:04:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14462652115745310531
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 21/21] net/txgbe: fix temperature track for AML NIC
Date: Wed, 27 May 2026 21:02:21 +0800
Message-Id: <20260527130222.24348-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmPNY57tR1XnsifJrKtIMX6Py9isL5W7dD/VASt3iCB5ib5rExlMcfpS
 QgHMj3vWbo/P/Mp2JB+KhGHvHmJruzT33rU9LwlPO5tMatk86own6PJ10dhiWsDQVZL0WXQ
 z6uQ1V2n/im3UZH4XxjPN56ptaCrinHno5ze8E6zZ0sgZ8e+XGxEDnaHcw4HrzWftqperHB
 LHR/64IJarlOTcOvYJEZGaUlwzdNCxPJBIFE5QIlEpikB4Js2HjQXEFMJZDnq77q7lFRVS8
 hTWakG8FeQhSQ9kJ07SZCRy9A7FY6a2FqGUYv5dd28Ya0YYQxMvjM+VzkIEFJijAt6dCq5S
 HWa9z/kmHrX0HYUyy9CMxRnNWvQt1m89ghFhAMs2XLPvbwz/Pykypk1WZtd1k94JQYH+h+u
 WLDerzhx9HDJnx/H+9FymUFa69A0Z9eIZAm2jA9rtIBKfvRgaAYLdiiW767cYDBdiT44Ga+
 0cq9ogzhNkO/WsXsVoFQMwU5WCUx35b7m7kY5tN5xyiYfch7R4DVHNHedrUqRZl19uGRxcq
 QkzwtUsVXP8Ad/pYFTP4BA40hTO0BzZCZPd4gmoWzsGnzYDAS2YSbNgh+/ORLyEA8fRIRsO
 F1XQXr6Cyaiy9n/PMyjdj9GW1xMFtYkog3sc+YahZ/EFsE3cBUmgo51a3xFQ6USm8NjoJX8
 C7nzZzogkMBReDv3NOMWhCl/84v/4N+2YqXtWqJf0o0nEy2pIyUgwT3GEVutDAtK/1Vpk4L
 iR6iNLPbERhhl1hHkmLy4FlQCZvZXXRlk+i4gWsHvwcHao2rEcodrJLl70iuqvQCUUl9nRO
 FqGPsLiuI7xA4exxAIYpj5l70zx2n1G30o3Y42CNETxeth8Cu1N1QOVEVvuDfMwcOSPJNWL
 Bxoj0gUvoSIKFvh55fy5Z2EB1X49x7PcTQdVrbgY9ThHqKblmGe7FbgPBJQxiazSVsJGQnm
 7U7r1lQLMgan+PKjvWz3mOqSa2Z9MaMC5L3rmDGshZqsguyOmvJqRqPWWfuPJVT8kGxWXJv
 +Ig5CVi2cXk7wXMRKL7ft+vq9OmG5LaXno/wevkuPXAfx3GqN0EGuWexlriwWK0hAIUVr1f
 naGyerHAv1O
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

Previously, temperature tracking for the amlite NIC was handled by
firmware together with the hardware setup. However, the firmware-based
PHY configuration has proven to be unstable.

Re-add the temperature tracking function directly in the driver and
invoke it periodically to ensure the PHY remains calibrated. According
to the hardware recommendation, the tracking sequence should be run at
least every 100 ms to keep temperature drift within 5 °C. Considering
the software and hardware overhead, a 2-second interval is used as a
practical trade-off that still meets stability requirements while
minimizing performance impact.

The periodic tracking is implemented using a timer in the driver, and
the sequence itself is the same as the one originally performed during
link setup.

Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 44 +++++++++++++++++++++++++++++++-
 drivers/net/txgbe/txgbe_ethdev.h |  1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 96532a015e..155d8f08ba 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2011,8 +2011,10 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	txgbe_filter_restore(dev);
 
 	hw->bp_event_interval = 100 * 1000;
-	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
+		rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+	}
 
 	if (tm_conf->root && !tm_conf->committed)
 		PMD_DRV_LOG(WARNING,
@@ -2060,6 +2062,7 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+		rte_eal_alarm_cancel(txgbe_dev_check_aml_temp_event, dev);
 		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
 	}
 
@@ -2932,6 +2935,45 @@ txgbe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
+void txgbe_dev_check_aml_temp_event(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t link_speed = 0, val = 0;
+	s32 status = 0;
+	int temp;
+
+	if (hw == NULL)
+		return;
+
+	status = txgbe_e56_get_temp(hw, &temp);
+	if (status)
+		temp = DEFAULT_TEMP;
+
+	if (!(temp - hw->temperature > 4 ||
+		hw->temperature - temp > 4))
+		goto out;
+
+	hw->temperature = temp;
+	val = rd32(hw, TXGBE_PORT);
+	if (val & TXGBE_AMLITE_LED_LINK_40G)
+		link_speed = TXGBE_LINK_SPEED_40GB_FULL;
+	else if (val & TXGBE_AMLITE_LED_LINK_25G)
+		link_speed = TXGBE_LINK_SPEED_25GB_FULL;
+	else
+		link_speed = TXGBE_LINK_SPEED_10GB_FULL;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	if (hw->mac.type == txgbe_mac_aml)
+		txgbe_temp_track_seq(hw, link_speed);
+	else if (hw->mac.type == txgbe_mac_aml40)
+		txgbe_temp_track_seq_40g(hw, link_speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+out:
+	rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+}
+
 void txgbe_dev_e56_check_bp_event(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 309db3bfe9..c32c61d8bf 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -747,5 +747,6 @@ void txgbe_vlan_hw_strip_bitmap_set(struct rte_eth_dev *dev,
 		uint16_t queue, bool on);
 void txgbe_config_vlan_strip_on_all_queues(struct rte_eth_dev *dev,
 						  int mask);
+void txgbe_dev_check_aml_temp_event(void *param);
 void txgbe_dev_e56_check_bp_event(void *param);
 #endif /* _TXGBE_ETHDEV_H_ */
-- 
2.21.0.windows.1

