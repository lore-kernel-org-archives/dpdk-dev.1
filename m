Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA775CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:17:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EC5D40DF6;
	Wed, 17 Jun 2026 10:15:33 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id A376E40ED9;
 Wed, 17 Jun 2026 10:15:30 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684128tbc489bb0
X-QQ-Originating-IP: +/sQmVArEQyq+L6qmdhbVtJX1ZK5nLbuvcAU/I+oSVE=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17835260442906159549
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 21/21] net/txgbe: fix temperature track for AML NIC
Date: Wed, 17 Jun 2026 16:13:08 +0800
Message-Id: <20260617081309.19124-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ORuEwgb9eurkhVjMTms/IVzd7Ct6wZAgrErxWvzQMTUkFI6+N9ZNMnjN
 5nqKfGrxK2rQozlfdrAMyX5xVRrW75soilx2qSiFfjKJaOFQGM3YxHTrSrjuusRDCocdoEj
 dbvAQqalSOTiFP1RqE8AvCx8hSa+T28xA5v07lMWaisL4PVdKU9RitwaPYC0bBdNOk1h1/c
 2TOjkk4S5b8RYatYYEqfgfWXQ0s5+TouBuDEtjzAfVeEEs9bltZZqmpcrkEqN7QIXuJ8u3D
 1BuYOwXMOdpjdPt4d79eXOWb3JxDNP/sI4WsOlL61aYP2x8NpPU4HIntN/EWcvDWFHdfy2X
 LVCFe72F9jgQG0D7MTo/wqHLDiiJGnZXR28XgkuEeOKyvR0/IeTeS/D4xqpQnjVmKZYGTau
 KohWAmXhoagjecSy7zG0UVaxfZQ0Xtl5uutjvikFY6WyrWidFUzaj9w6hoZj7pjUs5FG+It
 2b70hB0lSpdsOXxcvzsB+nWcLB/u69eH8b/zbo1UTAZwMWqHgkz6XkDHaDTOWr+m/2bTEtz
 7Ln2UNxaT70rgE1UISd+a7X3Sdv7QuCWlkGDkjyNGdG9wopMv7hS4bt8sofXKZq/5d8bvzz
 X64KOPJdfEh/Q7p9k/fa1zknsSPSVjUKy1k0gEYRS7mNk4KSIRFN90OZrU0XvLSwR2cY+sf
 caX7VEm8Djhng7dRRZGVq2S3eFJXdwP51D2gh59Qp/WyEjCU7emBm2nd/7B0og7uV1+ZZHw
 PV42MgymkDk7B/ULqfJJeq3H/Ks1bB5nPGg+r9U35TgCUXC2biDds22k+wTQxVQvITroanX
 p9l720VO6YMHhjubk2x8LSjEwFXjmsMetsLs6BDxYbVfaR27E8D1LGXZZd2L82erxpsiIYn
 4EK7uE9bGnHU1Ajmrom5/jNwQGElLglHtVib75mGs31POVQbFgQZuwYLAFIyQdsz61c2Ms8
 Ke9hjqQxDZFqe/hTGoaiUfAGZ5BEVIr21DwHgO1b3jNJxdL8FOpjECOU6H4gr2xGFQyXfxq
 AUnE7d1mtIKX0dPKFmnQqxKvv3qX+Z87qw1QK5rpwBlHpIRQE77wXaQdotfVgtb7oi7xrWZ
 3Ci7d0qtLAt9H5xAnTVuUA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index f2c3a35900..2ed9a8c179 100644
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

