Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD5C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314A240EDC;
	Tue,  8 Sep 2026 14:41:25 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 5834B40E8A;
 Tue,  8 Sep 2026 14:41:23 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871281tb451f3ba
X-QQ-Originating-IP: Lmitrfv2h0DzS9RoYsvllOtyyz0LlkUjevTnvcCklNE=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15347369803072067633
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 10/15] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Tue,  8 Sep 2026 20:38:55 +0800
Message-ID: <A1A205BFD72BED04+20260908124047.2284-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDQqrmkCTH3PcMudQZXGmj3Mm98MxJBffmaI1uYBYFdugynfylCX8QJQ
 pYttz0pFfZFNpz/TGsLtHp5lnGiFK0TIHlNXheBJuMWUzsaHaNFqiVDfE1Y5vXrHGalnGAF
 FtkucuQBDJcpfcFf6FXnLoZITzhyPj8wLiN8WFJqf77dw5Vh3ntOFqP0g/VXw9iEdwPrtiv
 3zx4sILJI8oa2DlTKIZMiCbsxEJF6f40+xvlCXZuHTzWEgUhktJSOggLvBlImKiZWjQm1uC
 1tur7aYhzFDt00Gr2FokbfLvvhgLgvpniBHWjgf/zGl562BVDQGbRkw6CjuJ350cSggRFdQ
 Scsrth5sYnoU1CzTpi/xxSSYSqMIOPSXKKh6hzRiSzIaOq6jnfBIaMUnkWbFu/vRI3N1fGl
 b7TSbU0ZaO444EKSx+a4l7ocnArjDRJLbyJzQ5mqkU0JUh0U5JeopshnWXZsSNXrhmaoEcA
 rMwUlx/Z0khpU47Pw7IjIrB6Fb4kmoW7ULT5ZQ+UPI7F4LxOf873ZdogyT2Vm2DX7WYpKIQ
 Fl7IyY19mry8CLb7FIq/mFHeXZnjVSwzMMnuaiztNNyxJ/x2Lq7mP7IV22j946wGsRp5gAr
 2n1A3JDZHZ0Jl9Cvdp3/lHXJI3MpiNBAipJFVn1xl9qlREapJRN+ghD/VR57o4tJ0Q6PP7V
 7gwgrfDOLI0XS7BzIHuPDAt84G1nhsDoOATUlFSUDgUMamW/hr/pubNsWCSfEiFQCsjndra
 qybdg3q8fqXArb9bDtRMegRMUmcDgbaBOycGAu2bfbpYfTf+hpLW6ZUuvmTK8AazPBWAru5
 0VheCl42Odcfxe20syMoKSDME4Aw7pmr/SDkK2qtUa0b+MHUcf75j8dsF8ue6VlEje/Hqes
 5/Kw8mMhkskkXPtplL4xL/anOZDuGlvnh6PwzjSkOWb7UEJ7i0AT6Pz6o/R+1ihvN9sq3y3
 uV4RQBvKFw6pLpJpLKbk+voK1dxRUCnfqZ0EvEIyoPXVXP0k9usDj0ZiDSwgTf3ZYZdyeZa
 sF3Z7w9meFnEeIXoAwJtorwf3xthTClrUDv8ct4Il8k/qEAwuwYbAukPv0/4XJHzaxJNxe8
 eB7BT0sgAt3WW/Br8Zoo80sQj/3iOdFdg==
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
 drivers/net/txgbe/txgbe_ethdev.c     | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index 0711a28a5c..0aa2d5719b 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2015,6 +2015,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3096,7 +3101,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (hw->mac.type == txgbe_mac_aml40) {
 		value = rd32(hw, TXGBE_GPIOEXT);
@@ -3104,6 +3109,11 @@ txgbe_dev_detect_sfp(void *param)
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
@@ -3142,6 +3152,11 @@ txgbe_dev_detect_sfp(void *param)
 		}
 		txgbe_dev_link_update(dev, 0);
 	}
+
+rearm:
+	if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw) &&
+	    dev->data->dev_started)
+		rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
 }
 
 static void
-- 
2.55.0.windows.2

