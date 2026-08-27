Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A7C61DC2
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4718540280;
	Thu, 27 Aug 2026 13:44:09 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id D0FEB40663;
 Thu, 27 Aug 2026 13:44:06 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831043td94f314e
X-QQ-Originating-IP: bkvltbEmE1QhSAIV8the+hWbI3kdWtT5/TE99e5WLSM=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4346477105065351941
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 08/13] net/txgbe: fix SFP hot-plug when auto-negotiation is on
Date: Thu, 27 Aug 2026 19:42:00 +0800
Message-ID: <45E20A744E3D1CF8+20260827114309.10530-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Na1LuT7tvsHtv/RuZONkehjS++/Fe9tsenW8Db6+YLO3aBiUefmY+KSo
 iACdkw6uL9KtBE+qKuwnUn13sEggIz45sRktMowcSDzqmr7RZ8CbuW6uNup/afyCT0im3pN
 6migmpbI6fNjQNOOTSBL3N3iQJc/SgZmSKv3PrFDdMFuAmp18HOXP2YzcVi5U7/ANWK3QTJ
 rD/Mhv9Tn3vSRgZYC9f2QMZ3TC5AwhTqwy45Ug2SHiRIGX2VtmPnUiZnslQ+dM3sHc7qOU9
 syeL9RH9jT5jak+n74iyhsx/70CgqVkQX49FuWMjtPcD7ftCxe2lQUpuk38GGg2QzM4hxyd
 KWaW/nlqou9o62XbnlHQtuLbQ6hA4deyjPzsTaDIdDDbV8y0USFWX/XhTbsOgCphjq63rGs
 TK7JRXmQtPoLwxbvfjYt18wHdZuPmfWIM1YYZS995TY9X9+WtcqBMA6GvxvCJDxOuDDYMU0
 PIE6QA05JlbPrOhoS5FH/0EPODmC8zyLXCrsvpz8IoQUsnhkiAnXcSOLCJJhzmxhUfVvoyD
 nceJ2aZ8mOCA0B7OZbgFpOodmo4Q8fRHdMlK7ySZHtYFbMOOEa9PKQOsv8AIiXyBAAUWM62
 MK/X0A1AMag3BEgRGp72I4kIZXxkqWlYbMGG7SsS6nlEcYUVHJGurjg+sCwOaZUsojoJlGC
 bwNUrkEbCcNF/u9+/RFnZSNoOTc3iRyuWPwvGzL6Zaz1y+cEH01RjsDVcSCpBN3hpNEVBRI
 9K1RmrKto5hEniPsJtRPlc3l7MNhe1+HdGP3tGyg74KGdQMoZkPOI5srb2+S0QR3eEkgtmv
 zHVXkPdxOW7zlKlWtz5Q1np2Ze3nA4vSoV8L4gJN+l9eMgz6mba5D9Ju7ysoN8T1fOyydG8
 00zu+y/sr1FwGQXbldYs/uQA0CP98k2OtQ9ngIXteD7eZMoRLfDRBT7DMI+5MQgrwX9fc7X
 Ob8qd7inAnQeZXOyx+bZVvbjBzMOmEGjPPFC3BzpEFqManwbTUCfTyqqz/Pg+463DNpdTLC
 7qqdRUV484cbNHqacgMo+RYV3fksjmUGI+NgpV2iVjl5/Zo/WjhEhXVTKCp2mSlshpQTgAB
 V6J8SCHsWWhvV87Br39C8A3YzD1Se/OMmEeJ/rdguQoxG1+JVQ5J+s=
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
index ae755996e6..9a29539f14 100644
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

