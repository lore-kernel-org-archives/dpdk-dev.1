Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C007CD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9460540E64;
	Wed, 17 Jun 2026 05:35:18 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id F077D40E5A;
 Wed, 17 Jun 2026 05:35:15 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667313t9e834371
X-QQ-Originating-IP: pL9ZNGCEg2BruhDDRSLzACTD9xcf6aWqi+cg1YrtufY=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:35:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5760137177496849723
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 21/21] net/txgbe: fix temperature track for AML NIC
Date: Wed, 17 Jun 2026 11:33:59 +0800
Message-Id: <20260617033400.376-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N5sfBKY/oC4kV8cx7SJ+rC93uZmoYdm7PHdnQXLU3e0S2wajzZ2BugcO
 qenYv/t2RHPoFS1xpjjr75haOdvYFUeOt3ck7vbS1zXFBvkNg8IU+ZOis4x4ScQMi9xNmk/
 YBaTA3N7vaj83VaV8dQVQ3lWEsyi3Z+kNadBWoPS41IZiDRUoc9K+BwR32nlmDsn+m0aM+P
 9uz0EIFotfZLYWnKVsGTsPeAqft1GWCDccEw/4x3/x4IG3XVXoUNMBjsJFbHH9sSgeWIVkc
 65BW+fo/Z43ahPMHCl1sjibP3Rhso2uWmUtonn9jGYHqGCP9QomThFQ9cDuHyZy0hJEbJxL
 QH8ZVYcwSDBYB6IszKFJBkDWXFCG7/wn28fq6f+NRQBh/+ULhOsArWGitZ1RQsnHuTVrP8V
 e6tiE+CL50X9kSafC8vGEAe+6UFicvhTbFfKVvo8g4+rSrNE2Q1RLIe9T5IN1KZrNMvH9ph
 pILuKJJoO/vR87AmxcYNM4DcdlkMi419qYUA4eHAHrqGa76+uKMatYtzVr9YMnAp6g8DTwm
 dhBPuZlkMtb6Aonu/vIQUcYR2HAY5nyDdyP9hGCRLf8d8Go/qQt+1smDaySsTKOI1YdlFvu
 rnDKnhe6NoMM3bhgss9Oc7aX1oKBr96/p0Goty/YF7Aks1NBXfEQqb2hH0SIMnukFymRX7p
 uOjDFpe8NoNVcM8bK0l3wOHsItz1nFjsGJW0GQ7ynDRQN4Nv8m6xQCzrFI88nTXMZ8LK4vg
 uvS9sXMp/S330tmMPJ59X9ntaeDqIdIdyXnn5ebp/eQEqRFZ1ZOcmwTrShThGNd6ysItEmg
 MmarAYhcIHdY72u9Tw5C2nyKgldkI6E2J58d6KwPMF0jTsCdnh4oKzgh4Ml8I+7sbs17TA/
 VC5FeEKCAYr+PGNw3khXfY3sbt5ybwNMhVs2+xg4gjjnZq3kD1AXviXSfAYoiC0gf2XZzCp
 zxF+DUyoUQle1LRucYhGb0IUrRdDsJTJMgJykUdNesSbe850qyqRQbamLLrI8hWHOzPQ17o
 hZ5CZtqPo5CLxH58srEp8URFDJ8Y5n3nE+4H0TjML5lgVMQ6gyKYhDfnhDajeylhKBV6gRK
 04iFvaUBY6/
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
index 7d431d85f5..cc33437b88 100644
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

