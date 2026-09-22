Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02103C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 12:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36F8042E9D;
	Tue, 22 Sep 2026 14:54:56 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id A207642E9D;
 Tue, 22 Sep 2026 14:54:52 +0200 (CEST)
X-QQ-mid: esmtpsz17t1790081690t05639a3d
X-QQ-Originating-IP: f52ODL1JbO2i4l62EX2ZSWFlJ2XEBCoRr0JBR7Joh4M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.132])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 22 Sep 2026 20:54:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12285168624646359826
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 11/16] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Tue, 22 Sep 2026 20:37:44 +0800
Message-ID: <902546CF27148B4C+20260922125414.3638-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260922125414.3638-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260922125414.3638-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKK2DAMrOULSVgDEy6YS5yDvSW+RZzEM88Q2o7P8w93RP0w1F+1APlzj
 ojfsl0sRfMK383fHhKLJjiw+JeI/UJJmnZQJCq7pR1beY8mHO3gl/7huqQywh2Ek3Hw5HWW
 1s4ouGLlnd0xFhtu2Lx9N7MAoyouYrNdvpal/UF8n1l5hhVyPqqqDvms8dOILl69n1ptYBi
 6FOe9f89KZGSTt9ToPPSE8jzU18pUx3RLOIid6XY/WtVzvYaCED7cBLiIB341iFDt8zx+qz
 gUDJUj3Lb6Rd6ZyU68QZBbFmqV/x11Rk4PBMpy5IEm8NCxQHqS8klVNHnR6Ds7o8DF94pfx
 HDH6trKL99Qya/hiL2T30mZYQ5KfdDmU8ahLa95O3LdnsnVNOSOjmVcC+hZOyojXkdKIR00
 jebv/Baypg9p0lLZm+A4+KTQgOziQDO9wSS/SKCyPJueCCLO6kcwJ6Uale2AAJ0tom0exkx
 u46wHAdpiICs2AWopvMV5RCho+ZKARVq54p1oEKIRim1BP/2B4Cdvsm+6Ii9kWu14q3mg/p
 3VbTKjBrGx/l71d9EoNIAmUvaf66G3a8wdN2JWviBghN0JmQnzIrm2MLJnj5+6A3ZrfQftT
 eGmnYcLplE3VPZ09l5Q4f/ERaBaLf64c/k26/Lz0iywmxbyuLllUAdHuwRB3KhWsDwnUrX4
 ZXOhoB8eJGZSWyOHv0BNOVkpEvJdCsqX0z+kHAkDnMPwZn3oJA63wBq1Jxakvg6OxbBC+sK
 c/GnZ8KR1lCW7xkj1ay6wiOIkikuvN4E2stThIKksISCousFhJ6+aP2zaUaFbYTOy03fQFj
 hIrQA8Dayeh6W6BUqumy7zJYnFrE6vcJP/xHS9KDUigXWOK1qz7tYovugY5reP+TgAd08Nb
 imbNnYicgK9w+gn2xxerIBHfVyMcPdd+rMOCnG6WMSCU768M8oUoSEa1iUyi2TupyJwFyr5
 1Zn9L+CpY0aBjBstXM0PaCAiyGp8eYTpxHCgAJD+DonpJVScmC3u5m3lKR+Hsb/buqXG53V
 5EMxhcLa2k0fzDXY8F2ShPHsfgQHTv9252+R6t8of6D7drw61Infnnp+tEu5xjQxe5sxbxL
 TJLHTUSQDBDb37PQsiEQI8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

Hot-plugging a DAC cable while an Amber-Lite 40G port is running
does not bring the link up. Two problems are in the way.

First, the 40G NIC never delivers the GPIO interrupt for module
insertion or removal, so txgbe_dev_detect_sfp() is not called and the
new module is never identified (the 25G part is not affected). Poll
the module-present level every 2 seconds instead. The poll skips the
identify step while the level is unchanged, and only re-arms itself
while the port is started, so that it cannot survive txgbe_dev_stop().

Second, when the port is started with no module plugged in,
txgbe_set_link_to_amlite() times out and leaves hw->link_valid false.
The xpcs path of txgbe_setup_phy_link_aml40() never restores it, so
txgbe_e56_check_phy_link() and txgbe_check_mac_link_aml40() keep
forcing the link down even once AN73 has brought it up. Restore
link_valid on the xpcs path, as the non-xpcs path already does.

Fixes: a2d92608d3b0 ("net/txgbe: add GPIO configuration")
Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c |  7 +++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 19 ++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index d812adac69..2d3b32839c 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -177,6 +177,13 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		rte_spinlock_lock(&hw->phy_lock);
 		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
 		rte_spinlock_unlock(&hw->phy_lock);
+		/* Restore link_valid, as the non-xpcs path below does. An
+		 * earlier txgbe_set_link_to_amlite() timeout, for example when
+		 * the port was started with no module plugged in, left it
+		 * false, which keeps the check_phy_link and check_mac_link
+		 * gates forcing the link down even after AN73 brings it up.
+		 */
+		hw->link_valid = true;
 		return status;
 	}
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index e7f8234146..cd7b40dbdb 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2029,6 +2029,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
 		rte_eal_alarm_set(hw->bp_event_interval, txgbe_dev_e56_check_bp_event, dev);
 		rte_eal_alarm_set(1000 * 1000 * 2, txgbe_dev_check_aml_temp_event, dev);
+		/* The 40G NIC does not deliver a GPIO interrupt on module
+		 * insertion or removal, so poll the module-present level.
+		 */
+		if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw))
+			rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
 	}
 
 	if (tm_conf->root && !tm_conf->committed)
@@ -3115,7 +3120,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (hw->mac.type == txgbe_mac_aml40) {
 		value = rd32(hw, TXGBE_GPIOEXT);
@@ -3123,6 +3128,11 @@ txgbe_dev_detect_sfp(void *param)
 			err = TXGBE_ERR_SFP_NOT_PRESENT;
 			goto out;
 		}
+		/* The level is unchanged since the last poll, so the cached
+		 * module type is still valid and identify can be skipped.
+		 */
+		if (hw->phy.sfp_type != txgbe_sfp_type_not_present)
+			goto rearm;
 	}
 
 	if (hw->mac.type == txgbe_mac_aml) {
@@ -3161,6 +3171,13 @@ txgbe_dev_detect_sfp(void *param)
 		}
 		txgbe_dev_link_update(dev, 0);
 	}
+
+rearm:
+	if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw) &&
+	    dev->data->dev_started) {
+		rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
+		rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
+	}
 }
 
 static void
-- 
2.55.0.windows.2

