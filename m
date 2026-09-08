Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BCC79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06DFD40ED8;
	Tue,  8 Sep 2026 15:28:13 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 01463402DF;
 Tue,  8 Sep 2026 15:28:10 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874088t3ca5703c
X-QQ-Originating-IP: zZ326iEX7W8rSuHhv1+ovToSo1nc5dMJ2d1Rm/M9K0M=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9501699580784973963
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 09/15] net/txgbe: fix SFP hot-plug when auto-negotiation is
 on
Date: Tue,  8 Sep 2026 21:25:54 +0800
Message-ID: <F7992AACC9C140BC+20260908132742.2661-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NFN0Qhrj1+QEsgOAcPXn1gMWwGmEu8LbX3ySTYHcnvZDZoPz+W48Bpi6
 +o9gFxXpQGx1DDds+TYPUuL2QIRJ2XZLkh9ky5aweU0ohrUmb7lppVISqgxwd1M9HqAkgIr
 xs5qHwqpQZFlvUXrwyIazCejXu7uKPDs8nwpcWzl4qegrhT0Ipzd9r/bNyAr/yptQvb3am/
 xCTd3aVyaguyZzL8hjsmHZ5DrY/ROvCqDeoBmELX/R0rB1CQR4Rv96cT1G9ip7R8tDBPguJ
 GREkKLSD+8OENyqP83iizDGOlfcABMaDGEOGPL8jyN6mFsXJFNcwrpjDKsrzZf4Opg+BlN+
 YR3Yo7Lg7BDAcAqHjdJ0PUGhuDVBX5SHHM7gDcozGUjjxaFmUwYS6O4q5xoUg9m1BJTvbSC
 NyBX5msTOhcZjGi3aJWlLrNVoIHV7SG/ORIZ34JG1cxnafImLOZZL5d5/W/IunoqgEs6Vje
 wvSGJIYoo07EN145Nl5N+elrm2NeWI5MrqDpQGOeYVZK5kTS1zz07Exr/8MC8PAh0f33mt+
 4ZrViFLzm4g0uyApT0YbmqHNW3QA5JQYY8iWG/Pp1bk6Gu2Ho8C1DKfEAAfHFunzBs1rrfv
 jJwaZQc3m2pz85G2hcskbrCe+4xzwT8/zeElBWQ/Kb9rrz/KMfCzo+kXOq6OeR87K33AVZJ
 sTFqTpyRKwFNI9oykSYlUuKeDq39lyRrj55XWANujw9O8LzEkiWK4HxlXhO3MxB7taPfySF
 41HBhxDL7ADvrBGI00Sff9zJpVGcYjhg0iHT+YKdgQ2bb2xEjOo35ZivVpaoFsBWZBu2sU6
 ZcL2to+tGYVIgZQV3Z/NPOBKehbQUz250QE+//kj1c9nk1thtrqgcd6VKXEGEo+eYGzo3hO
 7uFpqNWsOttvcSJYuTpo0uudw0tLEZ+yod2TMiZvxMi85l2HnpOMQcNL+KjBlGYPq5qacy5
 qeCxy6KbjSsiwFyA1LmsCnllwPsMPeyEh2ZOqYaGjty2Wk9LwEpPQkMX4w7n+dACdZjOKeR
 pAAMLOrHIJBaQsY+9274Kt61rURPQMcHP1BlUBs2+3PLn7A1sj47/yraZ5rJarixgLPx4Ga
 oyOdDW9tZ0JiDP2nCb+HKuw1uax5pGOhXQyaeDEH+8IU9fYn6A8Bb/nXiaCnZ9fM9FtL5st
 bX6sKNlsErfaCfg=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

Fixes: 234ce0d1fa9d ("net/txgbe: fix link stability for Amber-Lite backplane mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index bb4ff3c492..0711a28a5c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2987,6 +2987,20 @@ void txgbe_dev_e56_check_bp_event(void *param)
 	if (!hw)
 		return;
 
+	/* Sample the module-present pin on every tick. When the cable is
+	 * pulled, drop the cached SFP type so that txgbe_xpcs_an_enabled()
+	 * turns false and this alarm stops re-arming itself.
+	 */
+	if (hw->mac.type == txgbe_mac_aml)
+		value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_ABS_LS;
+	else if (hw->mac.type == txgbe_mac_aml40)
+		value = rd32(hw, TXGBE_GPIOEXT) & TXGBE_SFP1_MOD_PRST_LS;
+
+	if (value != 0 && hw->phy.sfp_type != txgbe_sfp_type_not_present) {
+		PMD_DRV_LOG(INFO, "SFP module removed, stop AN73 watchdog.");
+		hw->phy.sfp_type = txgbe_sfp_type_not_present;
+	}
+
 	if (!(txgbe_xpcs_an_enabled(hw)))
 		return;
 
@@ -3110,10 +3124,22 @@ txgbe_dev_detect_sfp(void *param)
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
+		if (hw->mac.type == txgbe_mac_aml ||
+		    hw->mac.type == txgbe_mac_aml40) {
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+			rte_eal_alarm_set(hw->bp_event_interval,
+					  txgbe_dev_e56_check_bp_event, dev);
+		}
 		txgbe_dev_link_update(dev, 0);
 	}
 }
-- 
2.55.0.windows.2

