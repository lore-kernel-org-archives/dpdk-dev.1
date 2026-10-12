Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E6DCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E52402EA;
	Mon, 12 Oct 2026 13:05:55 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 89C52406BB;
 Mon, 12 Oct 2026 13:05:52 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803149tca9e0d2f
X-QQ-Originating-IP: eRRMOEd29aWyDUjzAHG5llHzw6f0KZLXP4RE1sDx5ZM=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7217213100711104981
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 09/16] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Mon, 12 Oct 2026 18:56:26 +0800
Message-ID: <078312910EB766D7+20261012110518.1911-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3QajCFJy0PCf0iXkRi+Nc5fN41IUAfyCNhp/3fVpJmRcdvecYxdj6FY
 C8TgYzN1946qYRN/oepIkHDEURw2SReQzubsutDiS70PoMbtqDPPdb1I44YNAtfgHDLCYQi
 Q2QuSip6b1+7q768LCMo5QF0ODw4iJwd3xXBtbIs0nvr5N7zY7REsxquBGSGg+x+IF/IQ8L
 0i/cfrd3u0ICK/YI0lw+SJe9AV8aExzfC6AoZzQCJ9rkaRrIBK5a4mM8KnWUp1mUHRYBSMk
 GgW6g4pFLCTuBXQV84tQlIWFE4T1ci5nxuOqBiNH7knfvRNlbOyY6AVZrRa7S+qJvxHTz0N
 xR8qRis86q73QHFWrhMG44c4otXoaZ2mT+U0ERAp05x5dXo5gqamCDqaigjtIipxGVAp0mC
 bQdMXD9bxhuHlIvSLjNH02G7JV+ZqlrRnSlcessEO9Ki3QjPPwbcujYyuWEe+2XwpdcEA1+
 +4FwE3h3ulxmyzrUQi7aH8X3I7JT7TxCOa/Ule73pvWAZx6JRFSHRqydblkxCfuVC+THuYT
 x4mZTVBOdKn1Cp2w1YwNn3mkIBqxaP2pYRX4EsrVRitM73Pvg83fw7ek+tWDaa7uZF7x2Sc
 0kqJzDjAhsxAQHvQZtUYMdFWujTTSThXiAQQIDwbfv8hr0msWYlSu2g3bpVDU1Bn2jieMwU
 PvVL5ycuEAWab67cTHHPOejcBvS5rlak8hKzQ5Te4ZX8b+OwbxbhpXT4h5QMdQWhoWgdEUD
 gAAOgRGuasDvqlx/cAM0c5V3R9Hr4yGztc6nvRnzKg8MxanlGaoyZSZKLzoFZMkuDnYSPmC
 JMJXqy0fSl1qjHOW8BRMmIxGl04JKSD5eHYOT9kgWwVxK7ryB8ubzJXicFWuIniEo8+1p3G
 w3V3X3HIpZ0PVXa4g9zJKJkmKiHe83G/lJCq27DhM+M856ubE5tIHPRDefFE3q5sB1755wf
 +Bi+RjTWxtO668z3T0Wooq8pGBR+nX5wFX3ptdgURnGpWVZYBrPkYtzuxQCBMQkx4Iw0pM0
 XnI1WPqnqpfqglDztYkAY9jIGtaogCBgGeJhYFUcEJd3lP0plro4qokld6xOhAe0xJBjzJZ
 FPIuRy3MZZsIXsOu0J5QOMejDmCrQfDgr8fbVun+UhX0lwsJIH1pbCfSarh+e2kD3SBBMp6
 1Oao
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

The SFP detection alarm and the AN73 watchdog are gated on a per-port
flag that txgbe_dev_start() sets before the alarms are armed and
txgbe_dev_stop() clears before it cancels anything, so a handler
already running on the alarm thread can neither re-arm itself nor arm
the other one on a port that is being stopped. The flag goes low
before the cancels because hw->adapter_stopped is only set at the end
of txgbe_dev_stop().

The link thread can arm the AML link alarm while txgbe_dev_stop()
waits for it, so cancel that alarm again after the thread has been
joined.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 61 ++++++++++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h |  2 ++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index a5ef0b3e54..83ef9d8bfc 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1695,6 +1695,7 @@ txgbe_set_vf_rate_limit(struct rte_eth_dev *dev, uint16_t vf,
 static int
 txgbe_dev_start(struct rte_eth_dev *dev)
 {
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
 	struct txgbe_vf_info *vfinfo = *TXGBE_DEV_VFDATA(dev);
@@ -1970,6 +1971,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		txgbe_dev_rxq_interrupt_setup(dev);
 
 	/* enable uio/vfio intr/eventfd mapping */
+	rte_atomic_store_explicit(&adapter->sfp_an_alarm_enabled, 1,
+				  rte_memory_order_release);
 	rte_intr_enable(intr_handle);
 
 	/* resume enabled intr since hw reset */
@@ -2027,15 +2030,22 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	rte_atomic_store_explicit(&adapter->sfp_an_alarm_enabled, 0,
+				  rte_memory_order_release);
+
+	/* Stop the producer before the watchdog it can arm. */
+	rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
+
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
 		rte_eal_alarm_cancel(txgbe_dev_check_aml_temp_event, dev);
 		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
 	}
 
-	rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
 	rte_eal_alarm_cancel(txgbe_tx_queue_clear_error, dev);
 	txgbe_dev_wait_setup_link_complete(dev, 0);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+		rte_eal_alarm_cancel(txgbe_dev_setup_link_alarm_handler_aml, hw);
 
 	/* disable interrupts */
 	txgbe_disable_intr(hw);
@@ -2926,6 +2936,7 @@ void txgbe_dev_check_aml_temp_event(void *param)
 void txgbe_dev_e56_check_bp_event(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 an_int1 = 0, value = 0, fsm = 0;
 	u32 __rte_unused an_int = 0;
@@ -2935,6 +2946,27 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw)
 		return;
 
+	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) == 0)
+		return;
+
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
 
@@ -3022,7 +3054,10 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		hw->bp_event_interval = 2000 * 1000;
 
 out:
-	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) != 0 &&
+	    (hw->mac.type == txgbe_mac_aml ||
+	     hw->mac.type == txgbe_mac_aml40))
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
 }
 
@@ -3030,10 +3065,15 @@ static void
 txgbe_dev_detect_sfp(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
 	s32 err;
 
+	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) == 0)
+		return;
+
 	if (hw->mac.type == txgbe_mac_aml40) {
 		value = rd32(hw, TXGBE_GPIOEXT);
 		if (value & TXGBE_SFP1_MOD_PRST_LS) {
@@ -3056,14 +3096,31 @@ txgbe_dev_detect_sfp(void *param)
 
 	err = hw->phy.identify_sfp(hw);
 out:
+	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) == 0)
+		return;
+
 	if (err == TXGBE_ERR_SFP_NOT_SUPPORTED) {
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
+		if (!hw->adapter_stopped &&
+		    (hw->mac.type == txgbe_mac_aml ||
+		     hw->mac.type == txgbe_mac_aml40)) {
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+			rte_eal_alarm_set(hw->bp_event_interval,
+					  txgbe_dev_e56_check_bp_event, dev);
+		}
 		txgbe_dev_link_update(dev, 0);
 	}
 }
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index a617b70e3c..08f41e628d 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -368,6 +368,8 @@ struct txgbe_adapter {
 	uint8_t rss_reta_updated;
 
 	RTE_ATOMIC(uint32_t) link_thread_running;
+	/* SFP detection and AN73 watchdog alarm state. */
+	RTE_ATOMIC(uint32_t) sfp_an_alarm_enabled;
 	rte_thread_t link_thread_tid;
 };
 
-- 
2.55.0.windows.2

