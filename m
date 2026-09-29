Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB3CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4594A42DB0;
	Tue, 29 Sep 2026 15:06:44 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 567F242D9D;
 Tue, 29 Sep 2026 15:06:38 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687195t12f0f99f
X-QQ-Originating-IP: nNGBG7BdM7mW3FlIeI3q2ygCeUyiMFKhfcZ1LDQ4Mzk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 539275979296583058
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 09/15] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Tue, 29 Sep 2026 21:04:40 +0800
Message-ID: <85D113B0B0CD10CD+20260929130611.4871-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NGwSGlTsKdmD5dOl6mv8mdauwlthCpGBrnTJqSDyZY4y4KH/ymK/PHSk
 Dq1dmLpYbeTiQB+2cPJ0Kr3RcqbopGsObZyqnWbY69iUsEi1jRXr6JmFVrizB5SqiaK2m69
 bRgb85Q2PZ7S7cZazYZMdsrx6KjNWR7CL7bGB9/OtfrtepW3QVE0txa6RZLv+8+8k5DDvyE
 CQhAaCxkwgyeXjKrFAB4+wIAkE/L/Ne/U9dnMXNrtviiCGlNhvz0h0n6uLR6oDhwVXGICkB
 KMfJZTaqJVXZjNyO1m4+p5//gfJ3POYqSs8YftL+P5y+2bbBJR1lLZ08kw3QMYNC1pjpvyS
 /1Y9c2UizUxG7EDk/qIFm0WQQXIeUo2nsghdEbOFA+/Y0OiVTBSPM5ZoleyLlLUZIIbE1r0
 955j0Mhc0m9cWga8kiSmRwRLQcfJveF1g68GBBKtzLfjD2nKO1hwB2LrZyf65ueqjDYzbu1
 jeB12bTvHFVieT06Kau9MOo5LsHlGS0GojR5Nd1j5aimaiSmUnt2bL6DOJuB0h0juC4gzVo
 2bDw7rzN5d1ZgRZgp8NuSXXz4qqmahY4GHcFeCpp9Aiq1ILEqHJtZK8/AmuTg0RX4RxlLul
 z08mp+GLsw8D5Ke5e6YxwzbmkfBCQiQfFJXWrkuifKxrh1TlChvUJS0HUjv9L8N42KcS4OV
 cZj8g44A+eC/2juK6PSGbzsKosV02kUgGhYhlYg7r8S8vsbVLl2UyYENPnCCU7TTO8dtWxk
 8WpKoZeXe+Fodw8zRQuOPyApLBKVdqUlPlt/YZ7NgFhvT5yCh2Y1vME5z9iLHBarH+03ym9
 SZjyIoWTrTjk0reYcVjpej0zVDHNg8GEcWCCxmPUiR9lTwsdNSB4Ad+JaSqnmZVv2YpLEf1
 RjUJ8ERpIaT8sxPNPpLRFqUWgJDB3N6oyCAa4sf/yHpZLMAHlzBBH2NIXuommx7J/jeU5+D
 37l5sg6TDRSViHXqjSX3Fgq6Wgp9MHmEc3L93resqASYX/gBzJ7luTc23zvla/qxJIk4N49
 XrvCsWoJ/+jbNa8BZ/RwK6SDHZM7ZIEO7PSzwa+LZLqtUqu+Ihn+24WjOvPcZ9E17CwxXXN
 4f19KPTME6Bcizm43CxEqLf+LG6eozYqA2MweoN6fasWt+3QN6omwENtfJ9GATrARF0mi8+
 MtvSOSam7YaJL950uaCq6f3mzUImuHVMdlp0HGtlIfoyTY8=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

