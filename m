Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D380CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA628402C6;
	Mon, 12 Oct 2026 13:05:58 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 361C84028B;
 Mon, 12 Oct 2026 13:05:55 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803151t57c25fcf
X-QQ-Originating-IP: ddK+/+5fX/Cdl0xRZXUgjJJ3zZ5dYQs/lVttiAxN6Pc=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 758214049849841790
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 10/16] net/txgbe: fix DAC hot-plug on 40G NIC with
 auto-negotiation
Date: Mon, 12 Oct 2026 18:56:27 +0800
Message-ID: <D70CF12CE2AE8527+20261012110518.1911-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NcmC868q55ANnB/HvJvcXBsioMbhM97n9S6sC1AYX5yWLmyz9vfAGqDJ
 dIXccX3pfYMGNMU07QZ3vJR4/HAMgEn0eljFtiOA+0RgzYdtUfHECdlt1Iuh4RI4fjrp2lK
 WfzuBAHkGNKgskkSQq8gx16zUg9Yffg8Zjw3pYaACV8k0Ofh4PB1JjmaLUOHUE6y0QoVCpm
 Q4zCNf/VxuQwb7XzT7v6wDap24xQZiTKQ0EP5Mv+AS8coye0gUWKJIqnSlfZUo6UnqHN4ND
 tO6dmQ1Rd5fC8vTBxpJ9xv3ksoGztFFdZpkQXGeHKj9ntq3dGucXkV8qyi1uY5LshFRRUts
 TMhWWIc/3nIeUpcGVzi77nx8K+H4hlI1PauE3/edtvdTeMcDqY5b2j4hMCBdq3QN4AkEu+w
 PYnb2rkVih6xVyo+bLs0rzoIWusNQ4iuastr7ktI5qJ52PwUFCrde2LikmtfM/VeZqk+yAZ
 Ka9uiLbptrq2CdyB39CR2dw3fy/kRboFpGRHkz75vzGo7sL/DTRmxcrXUDUjHpyKKkYZ7t/
 KpomWZ39a1al7gh6uM8icLz1RX0KBauJSQC66TuLVZZfeJKtC7U/vn3VtREmigyGNj8+OKa
 SWCXv1atP84jEidToJ7dnNoq3GKYLdvxW+RsDrh8umk0cfvqOagdQOWCqkAzyQPERK41ARZ
 vTiCG1qemq+Cq+lWrcPyI/zE66uPKfB3RzIPn+2n96YFqyP1iXiEzfRsICW7QHy/Lb5HSM6
 xRyvondIu3zxnkaBuVcf6qWdjxmpURsVs6DPxHW/LHVEmT+9YdhK88e+PgMU9dp3/edQR8o
 0BTyiC4q7m7pdR40wVhmunt7R4OIk6iKeRGv2VR6v8FmnZXLeHTYxhnfekvLaT+zGioweSm
 b1gz8QdlucpFIO3/OrDoBbQ3csMPPCz97tLnxbTlf1TNfHJ0PvA6rkhIlmGD9TPIacemeA/
 83Iw0HIpCEPTWP+B7CtgTYtXPSqfIXL+1GYktBbNfiAGGAIhvTpv9CaAiVlOwzl+iMi8/sM
 S4m1qCpXZCRhE6fxcXhFjx+ZJUtx2WLfwCt6+xQmaRNEUJZNdINEM5kHuOU0QICeAjhWfAs
 1Fcrn2CJN6AgigNmpSpxdR6cn3Ql5bt/KXyaKQNrrRKfyqeamVeySA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
does not bring the link up. Three problems are in the way.

First, the 40G NIC never delivers the GPIO interrupt for module
insertion or removal, so txgbe_dev_detect_sfp() is not called and the
new module is never identified (the 25G part is not affected). Poll
the module-present level every 2 seconds instead. Identification is
attempted only when the cached module state is not present, and the
poll re-arms itself only while the SFP/AN73 alarm gate is set, so that
it cannot survive txgbe_dev_stop().

Second, on AML40, an unsupported QSFP identifier, or a QSFP module
with no supported capability bit, previously left the cached state as
not present. The poll then repeated the delay and I2C reads
indefinitely, and the latter case also repeated module and link setup.
Record these modules as unknown and return not supported so polling
resumes only after an observed removal.

Third, when the port is started with no module plugged in,
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
 drivers/net/txgbe/base/txgbe_phy.c   |  9 +++++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 18 +++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index b52702b197..cee2f2880a 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -180,6 +180,13 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		rte_spinlock_lock(&hw->phy_lock);
 		txgbe_e56_set_phy_link_mode(hw, speed, need_restart);
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
 
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 8b653f0aeb..a50fa986b9 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -1125,6 +1125,8 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 		PMD_INIT_LOG(ERR, "port[%d] QSFP module not supported, identifier = 0x%x",
 			     hw->bus.lan_id, identifier);
 		hw->phy.type = txgbe_phy_sfp_unsupported;
+		if (hw->mac.type == txgbe_mac_aml40)
+			hw->phy.sfp_type = txgbe_sfp_type_unknown;
 		err = TXGBE_ERR_SFP_NOT_SUPPORTED;
 	} else {
 		err = hw->phy.read_i2c_sff8636(hw, 0,
@@ -1158,6 +1160,13 @@ s32 txgbe_identify_qsfp_module(struct txgbe_hw *hw)
 		}
 	}
 
+	if (err == 0 && hw->mac.type == txgbe_mac_aml40 &&
+	    hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+		hw->phy.type = txgbe_phy_sfp_unsupported;
+		hw->phy.sfp_type = txgbe_sfp_type_unknown;
+		err = TXGBE_ERR_SFP_NOT_SUPPORTED;
+	}
+
 	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	return err;
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 83ef9d8bfc..8e2adb245e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1984,6 +1984,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3068,7 +3073,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
 				     rte_memory_order_acquire) == 0)
@@ -3080,6 +3085,9 @@ txgbe_dev_detect_sfp(void *param)
 			err = TXGBE_ERR_SFP_NOT_PRESENT;
 			goto out;
 		}
+		/* Re-identification is only attempted from the not-present state. */
+		if (hw->phy.sfp_type != txgbe_sfp_type_not_present)
+			goto rearm;
 	}
 
 	if (hw->mac.type == txgbe_mac_aml) {
@@ -3123,6 +3131,14 @@ txgbe_dev_detect_sfp(void *param)
 		}
 		txgbe_dev_link_update(dev, 0);
 	}
+
+rearm:
+	if (hw->mac.type == txgbe_mac_aml40 && !txgbe_is_backplane(hw) &&
+	    rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
+				     rte_memory_order_acquire) != 0) {
+		rte_eal_alarm_cancel(txgbe_dev_detect_sfp, dev);
+		rte_eal_alarm_set(2000 * 1000, txgbe_dev_detect_sfp, dev);
+	}
 }
 
 static void
-- 
2.55.0.windows.2

