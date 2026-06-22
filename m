Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1ACDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C0FA40689;
	Mon, 22 Jun 2026 13:13:54 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 8578C4064A;
 Mon, 22 Jun 2026 13:13:51 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126827ta927e075
X-QQ-Originating-IP: PRL8I7wQCmBhOHvWwXB4hl8KfPkpj4bBX8vR/zCJYqw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:13:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9631636413923188032
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 21/21] net/txgbe: fix temperature track for AML NIC
Date: Mon, 22 Jun 2026 19:11:09 +0800
Message-Id: <20260622111111.21024-22-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NMVVdJVMVI9X2nanhlC3s0jaL8srQsD4YgeS/UpMrV/pBHFYdnwTeI89
 EPzugmZIOVFfyOjQSExXo8BowlZtKndASadbnRpLrH01iiI8gDVaYBndtU9E1NnSLW6crpf
 eIfKXTTNwJiUDwmqwVRdfK8k7u47SRxGOd57eabM7B8RURE8T2We5bpLHbOfsv459xNvMxO
 VBUZ8d9DAIXiKsXHyRMTVJFV61xaWmmxCAZk5b4cLnkX+qCAe32HpvVv+tGjlaiAy17rv7t
 JPKhISDR2+X3Uma3J+modcApjNiH4ytvUAbEoW8JNovGrhojEeyLDu6HH2URDd8WSvdTR3w
 nuXbE6Qt+l9/JTgGiD5pUxLqc0nALmxIpzwTzfWN8sfrcUTscaF0XxuGrGvtsVR9xy9YucC
 HVV55Q+B/930oQl94fO8Y1K3v/gVrDmoM1XRr+FwPIz/QKqHw7um2Av6FGoa4J+GaociAaP
 V7fto/gz7LCodFeaH0xAJSHNw4GP7XD4uVxLGfSD05hBUhz5wEJeov2CwnLdze1884JcGDN
 s5RZWgojPmPbClaEw/OMPdcbeyRS4e1mT3qIE+w+lQFenKw/k4hZ4HPJmjtSQ/5uyY8+amt
 sckq43sr3TdzdKcRVre5Fev5QY+Y/a+jHEh0+mv00jnfq6ebNOz3PTuJoZpjb1Db0rkZ495
 u+lrEEQAjF9LK8ziij0neQMyT0+wEL4xo6PUhdrt3eQSlIoPJfDamYfORKUnNBEkLbzpOEm
 blHbY9C6wP8Af7P5fK+AKXXi4d335T0eEIkOr7Y36Z+QAXXy+b7mx/1xwrkzKMl22xeso3x
 CvBj2BnmFYKSrhq8cZGwN8TX/7h6yUWuf59IHLag2t9YaeD//T+s0XtPyfctiv2up0onV+N
 g2zymeJFOnaJ6hM2h40Nfv1G5dLz8Z6XRj3fs7JQo+c0FshX2lliOn+jsUPSXa0U7cFJzOY
 gE1urNPSU/K/ay+EsoSbdK5pWkRLelj1O87wPg1NA3RC9fqWmL3ETqSO1j6c3gWfi2aWtfD
 FxTUmJzSsY6eT3zzg1GeSbjz/tNcmWZwJ1OBPJtAg421v1+dfbDiJCyf21MRN/O3gGnshkK
 T6ELnN47DDvztOU53xSJvwPH8b5ev/HtQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
index 4691a562d8..308963b616 100644
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

