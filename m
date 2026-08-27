Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91B7C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84CAE40679;
	Thu, 27 Aug 2026 13:44:13 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id CC34940678;
 Thu, 27 Aug 2026 13:44:10 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831047t65e1a5ee
X-QQ-Originating-IP: cTyTQ/SNv2CnkEZXrvz8D2iSLWAcnShDCLGIM3NjMls=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18348504478640002781
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 09/13] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Thu, 27 Aug 2026 19:42:01 +0800
Message-ID: <E8E6FE7736F0B569+20260827114309.10530-10-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLbAtvpy5B1PAl6lmZQLNHbKrsYhMuBksQ+TvfIGF3XIoyR7d2cuvCh6
 1sCrI8WBOWie4YkRNp+WbWx1adZStvG4bJTqIzDavYBS0zK+2r8slmEjyxDm+jx/8ugpd0J
 XtNRRVbPhPreKutQPcXII1oIHKbx9KMMRXVDMmscQ+D5Edi2W36X87Z/sUlanC4WOyEpT3+
 kAvy75y8PmvVuTGju+vqWO6U/IULW5VtjD5Lpy7Zh1LdO1D0c/btG5ezTBklbqISd2KPEi2
 pvWroxeXCclac8iE6Gq4StP1z6bxrr6fp00e+8lu3BfIphkF1C/2uix14PNjXXI0uPGJZtF
 LEn/3dDfxvY1Sn1IDC1MoQIe2rOC2Rgebvl3o/d1E/42ohhLlQB+EqXb2MamKEMCYpK4ChY
 pipX6zuK2atDaMUrqeULdKMpeEDkVUC0YT7EtaHR+YOeQ+iWA/qmM8ZUg313IxojZJI3H9w
 2aaWlN/itAz+JT0I2B64uEeZL2bDVKFN+6ey2z/IQQMLlAitoYym/9RFiF7Rj7W/nzdODM1
 lDOOAat5WxvsGMq75UtYRAGGa8GYjzltxAQGQ8ndLSZlxra16ZNe9q/604+k100NYT8/VAl
 xvQYwCRlpb7bi3dkwoa1iKB50zButJSHD1s/KxSdS26gxOzN6RChw5usNiDG+5cbbTCI++1
 y8Krh+Q1Iy0EZg5L3zgYxRtPggS5DMoKxiiBD9cpqHjCtV6ktSei1kAHJN5FbMCKZW+v5ml
 LLbrekZEIN8J9r6JfbVuFMYNsgeOCNIdJUfgXM+j5wDnf4UO1+h4rv58lF9OumOFN3JvMUp
 YvFdzDsymacVSEICeA03Y3Kfi/XM93O1G54X3HI3N+JGd8DgnUfTZLsFBLMDGu+kW9M5dkM
 vVDf6UwYofBE8sJG3Lwbl6mjlyjlUpAb44VlJsTtCWLaYhkxysfCAcGIoef8L+XAjcYLnlj
 /87U47jYdDpE8pxziW3pHimsJm3OL9gcbrvcq4a9ARTp3foYKX/EsWnHAb4zQrK/0sqpNBv
 eVzOgMfFgRbm30NtrAY1HXfDLV5NAAU9wv3GJrK2kUmfqLp4gTmdTOUJVd4QVPODbXomQh1
 N6TFxInGGwawVs7p+kFsaQITObuu5n5HQ==
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
index 90d4453b06..bfb8a4bc7f 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -176,6 +176,13 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		rte_spinlock_lock(&hw->phy_lock);
 		txgbe_e56_set_phy_link_mode(hw, 40, autoneg_wait_to_complete);
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
index 9a29539f14..38c58323e7 100644
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


