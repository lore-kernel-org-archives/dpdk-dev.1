Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0791E606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA6EA40A79;
	Fri, 23 Oct 2026 13:08:19 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 5EF9C4067B;
 Fri, 23 Oct 2026 13:08:15 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753693tce073b8a
X-QQ-Originating-IP: jRv5CBHUp5L+2skwUFQvHxvWP0JC+PFC6cjSwgFbbOw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3953486288635783183
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 09/17] net/txgbe: fix SFP hot-plug when auto-negotiation
 is on
Date: Fri, 23 Oct 2026 19:03:47 +0800
Message-ID: <D2BBCD02AE42C5A9+20261023110728.3975-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MpfD2K07u3RPS1P5fJq1fSxlcQ0etPFhoFAUYmmLI+ZpX+Oqoki/IJlV
 ySoQwL7YBjeoswX2lR3462DzDf7tTG0xDrJaaaXXECoZHw38QhM2hwFn4BxC6v6M4L2qhxc
 ninPSWdQ+ZumgdGQ3hFzjSmG+cqpXorcxbL3PPp93Vf1LV73R7CdlTR4SY5CqbVKAcDokQt
 eNqEG7kwO0alvCu3QHrD+oQo8UL2IRFGd+qXiStboB/6xI2n96bgtTweaysTxITwPkw4idy
 X56UFeG3hHPGHPFyUIJBaaA1TT1+8crR/+nKDWhiw5YA1/+TN8MMUoG5vMKmQrvYyTngP6P
 9P9WDrSHJB/p1ed0dmJqhnkwcRRVJYyj5kprdmpqu1c4jNs47tm71aP30sSkrzxTYQfFQSz
 GAPs/Tq94WZQjaG4lxk5izhIfTAHczsqkhL/dwn8P2JvKAu3EiVLx6oNDYxsYgvXJuhVukV
 jtxD801nFg+pL8fUcUCUy0YtppbFUkI/q+r/1c+uxTgwCvZxLovUXnzmNL7Q8qv2GxdUdr/
 U7FPPPozETKj+zmqkJuIzC8VcR3X6JdIrEDq4Y3mq6zYeO+mJmdImy8VPqxAF2Gd1UeLhSn
 +9ZfURxN3Fc1JSdqkc0hsNwHflSiU6IXq7ZtT91wd6T5nVlOZaGxnWd4MV5qHjnLL/wgpS3
 9/yHdmTCgXTQOvlEngkerNrWWPRaedYkJ1f2OD7TL1rE+BgJ7fYNWcAyHPYqKSk4hXW+kvd
 hf8lBPGHqgm4V5DL+DMgxJNyY7+htucDBxHkFWrqoaiTmQdgymDFjJm242yXH7mmzOSThyC
 qJ+12hBAybM05ZalV9EBBEMnluV+exLNQrk6xwJ4vz8bIfLKbgyTBAgsY+hvLR1Fg2SXemo
 nQ9nDYHQ3478aVc4PDCHregtbWpABTdy9C3C5cXLx+LFmiOQKZp6So6OKfIIVWaIBF9GXzC
 1E1WM8zSzC35lQaHKbtgWA1Gdlk1EQFrVbqs0yPYAupp9FPTku0KjhkoEyRpGMy6eUXwxEV
 5mBkOdcRAdHG2/c1o9EMWXYkHKKeWa7jqP+n+WFplukDc1XFUqbzrurUnFzf4GM3siPSJ12
 ubfuWQNtGXjQaTCN0/kpNRzj8EQeFBzF/uJcgChH+t1sIj1m4ji54ggXwDlhsLvE6Ok1ARq
 pOLo
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
flag, set in txgbe_dev_start() before arming and cleared in
txgbe_dev_stop() before cancelling, so a handler already running on
the alarm thread cannot re-arm on a port being stopped. The flag goes
low first because hw->adapter_stopped is only set at the end of
txgbe_dev_stop(). Cancel the AML link alarm again after joining the
link thread, which can arm it while the stop is waiting.

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 61 ++++++++++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h |  2 ++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 2f513e20b9..77e8b9dea7 100644
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
@@ -1961,6 +1962,8 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 		txgbe_dev_rxq_interrupt_setup(dev);
 
 	/* enable uio/vfio intr/eventfd mapping */
+	rte_atomic_store_explicit(&adapter->sfp_an_alarm_enabled, 1,
+				  rte_memory_order_release);
 	rte_intr_enable(intr_handle);
 
 	/* resume enabled intr since hw reset */
@@ -2018,15 +2021,22 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -2917,6 +2927,7 @@ void txgbe_dev_check_aml_temp_event(void *param)
 void txgbe_dev_e56_check_bp_event(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 an_int1 = 0, value = 0, fsm = 0;
 	u32 __rte_unused an_int = 0;
@@ -2926,6 +2937,27 @@ void txgbe_dev_e56_check_bp_event(void *param)
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
 
@@ -3013,7 +3045,10 @@ void txgbe_dev_e56_check_bp_event(void *param)
 		hw->bp_event_interval = 2000 * 1000;
 
 out:
-	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
+	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) != 0 &&
+	    (hw->mac.type == txgbe_mac_aml ||
+	     hw->mac.type == txgbe_mac_aml40))
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
 }
 
@@ -3021,10 +3056,15 @@ static void
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
@@ -3047,14 +3087,31 @@ txgbe_dev_detect_sfp(void *param)
 
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

