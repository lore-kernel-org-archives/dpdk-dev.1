Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D84CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00E842E48;
	Wed, 30 Sep 2026 12:21:13 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id BE11742E62;
 Wed, 30 Sep 2026 12:21:10 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763667ta24a6fa4
X-QQ-Originating-IP: 7oCOB8nx2dsv2wkZ0+jMyHo0llme329Q5yGwhf5f4z4=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:21:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6580642413422990080
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 09/15] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Wed, 30 Sep 2026 18:17:56 +0800
Message-ID: <55B821130E4CA178+20260930102042.2214-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NSUjTxa18SoDR5jhvtv/bLeznXSkcRhNiZiDQZr8TpuPCBGh5Q4Eut0R
 oRjo5e6/BvHOsY/6N5/zxd2w5cuV3u4VO6i0rKRZaWGw+hE3hWLvF+QB0jmUt+55rSfPzIz
 ddsT63QmQjD3nZUDvSSKn1ZHAbVBMNqiCV2zmkTtdkZXH5SaainFrDK2UkbiNPbqrfsJTSG
 ZlIMfe6Vh9PQB7isQ3D2ZEKCHg1GgotbDGm1KPMY23ulfu9T1oA7TMas4v9/kodEwnGmsiH
 wEeA5AQueIrec8H/08PpH+b1X+abdkZXJ/LPe6Zv1uKz4zIcF1ex1q+zKAuay4YYfR1guyT
 zqImpRVHN2I1TVuvRB4enNJjWK0Rj7kKg0s4OyF6gaXCkZY6OWm6XCVdHG06wwqGFzIk6W3
 pH+LpMk3hUCMEVRPCKBjwCtSiqzKF0s7vcyVQIxq9cWoVi/W/sjcsyWmfb1kbgtKmTRtYDc
 uXdr0tjnktfI9GzX2FepPyXWq4hinc8GZw7q4YZeKXWaB9J3cMfVfNepj8Z1Hzw9KlWX7FQ
 u7rZhLw/aihvrW9FCN9IfCTrmYWSvn4AiFApqNwkKfY4HrC9/BrqrRUkHNv4vkFa1uc4Ejl
 UcNbwfihskA03JIV1313LBE5PztWTlEJ7DY1NUsdDEUy3Tn0kx43fvszj1WACoZ+jzyPFai
 LIAMzFmahvvG6ObmFKDrBA32pbVbct4be6UKlYKzib7IEcjQF8ohFk1BXm5fU59NYL6AX/R
 azFPreUPKZY7fsNNNkJ1f/I7gE3aE7lscp6EhYjrj52yvzzWf+dgvEaD2EtDJhpVrgsiBfX
 Q1mM+F20Qx7eT8vD7T4psH43YyOKnk5+1mrm2BZNiLHZWWirCS599T7GtiM1tiVSwIO5bdj
 6m+kirVKj1i95FyzLq57A/Sbk7uq59xwWDuXC2HMV9ntccnXKjccT1L5bjQc0z3McP0+/jo
 2+Z8t2d+kxOHrFQtSGEu3nPi6C85yvyacI5s0GeYH560JFHJxHaDQ1Pte6jsMAXFoXBtZWF
 nfaD6Is2Oel1XCMcTTB+ocLUjUx/6BZIyna6oHQ7ypDZfP6GjcgwFYQkwEtKtzg5sxPmfgh
 XDegtRjoa3eEduOn8nZ/lLrJF/iiLG37lE6w7uyk3sR2AsRVgkLpXY4mC7P0ntI3Y/kCdqp
 xiyK
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

