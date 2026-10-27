Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331E606A9C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C211440664;
	Tue, 27 Oct 2026 12:42:51 +0100 (CET)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTPS id 67481406B8;
 Tue, 27 Oct 2026 12:42:44 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101361t628eb328
X-QQ-Originating-IP: z+jz6Voqm3Mkdg/fImgmP6Kp0pKpffhW/K8OUucAnKg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13626444895392191911
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 10/17] net/txgbe: fix DAC hot-plug on AML40 with
 auto-negotiation
Date: Tue, 27 Oct 2026 19:38:26 +0800
Message-ID: <4405567395447E07+20261027114218.9724-11-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nwue+760/G5dfpzH9+yZh5lAYc6ghRVu2C1ZCdlCsP9hTWib5vl8B5gP
 7G/6DGZDsShsObGnB57B4huiElSE/1/i1gw2AwcnXTT2f452mTXRmsaNrISEhl+q0mEY5qO
 dkrZNtldi2k83gsO3UJribMogHymdd9d3bs7hh9JPYlzpAmQS5GZtmMkViL+vEEoRLRRVil
 0dDhi7unHFsqocAMIqWHYWu0xSzaKVRfYUb55FC4XQEfTjFXYShu4R/mxSP+B8mBa0JyNbt
 4UmZw09GVA6qiDRlKN2YQVeldaKhgoO4RFD3Ji62ZqPY7djiavzOYe1MNluS08AEFySoywB
 euWX1A5aTaO/ljTgnMDZ12mKBjVqIazyccLbiZUHV2AHA9aHjwoGUrbGSUkTjfa7WNC40uV
 Ba1ya200MR2K21uYyl0Naxh/9+8JSf3Lw+/VaLg27wac+gywLG4KTLfUT27DTLwxpo0KHSO
 m1BrPxCE+OwfMQDjd5eGo4gKy701+FnR6BgoUpFUc9OGsnlEzwgBmQihxrefPo0OhGgdID8
 2/AKM1XsLBLend9EnpJoqeqg5Zib21GG2xcbVYh3p8bmYXgk2x6gisozblWBE9BrQhG+73Q
 xKLGpnQ6PdzOZldcgfsDCNQHWoS9Nt8NdPv7iMBAdOuHnrNRB3HGCOhR3TLGqwDWb1TRJdT
 somWUMIWjnrHsHKCB3ISPzBc/6KZM8GAsevnpVPR9ROV1xT5P8/TYl0YBqR3xPxZZEFBSwU
 yXD+v2vi8mEieqP2y9sehOcKitiL6fe2gg6MNIVVDorkIpdmSgAcNiQaaWjfX14J0FpwOpE
 xeD4s0IauGxMW96mkNY2otr1u6nxbqoDusvAGfYqunidZG72InsUfh1Cq9cdO2qRJ8l/Gpl
 YoQPXVt3tMP8vjIgIFmeoAcvMwF/W4/lzi8XvdZ412BwEfa1HA2jfU/utT7CiUn+Cl8TUxC
 679YHTbV1eM9a27HjxTKNjoWsVJC9PKRFxDx3y47KZIYNiwZhMapOlUxlOareqZ1xgSuSBt
 EWR9YXaxUkq8G0WgDLgZIoqw3s6Db1nHVg0vNPlqi+N5wucjRvWReEvk86eQotlYAH5LeyJ
 8kueSA0+haC5qwgFQ6RILB9Wt1iU125yR9LXIlEpCm7
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

Hot-plugging a DAC cable while an Amber-Lite 40G port is running
does not bring the link up.

First, the AML40 never delivers the GPIO interrupt for module
insertion or removal, so txgbe_dev_detect_sfp() is not called and the
new module is never identified (the 25G part is not affected). Poll
the module-present level every 2 seconds instead. Identification is
attempted only when the cached module state is not present, and the
poll re-arms itself only while the SFP/AN73 alarm gate is set, so that
it cannot survive txgbe_dev_stop(). With an empty cage that poll
reported the absence and cancelled the AN73 watchdog on every pass;
do both only when the cached state changes to not present.

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
 drivers/net/txgbe/base/txgbe_aml40.c |  5 +++++
 drivers/net/txgbe/base/txgbe_phy.c   |  9 +++++++++
 drivers/net/txgbe/txgbe_ethdev.c     | 30 +++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 4b63810b16..fc8b92e976 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -178,6 +178,11 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		rte_spinlock_lock(&hw->phy_lock);
 		txgbe_e56_set_phy_link_mode(hw, speed, true);
 		rte_spinlock_unlock(&hw->phy_lock);
+		/* Restore link_valid: a txgbe_set_link_to_amlite() timeout
+		 * leaves it false, and check_phy_link()/check_mac_link() then
+		 * keep forcing the link down after AN73 brings it up.
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
index 77e8b9dea7..ececbfb13f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -1975,6 +1975,11 @@ txgbe_dev_start(struct rte_eth_dev *dev)
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
@@ -3059,7 +3064,7 @@ txgbe_dev_detect_sfp(void *param)
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	u32 value = 0;
-	s32 err;
+	s32 err = 0;
 
 	if (rte_atomic_load_explicit(&adapter->sfp_an_alarm_enabled,
 				     rte_memory_order_acquire) == 0)
@@ -3071,6 +3076,9 @@ txgbe_dev_detect_sfp(void *param)
 			err = TXGBE_ERR_SFP_NOT_PRESENT;
 			goto out;
 		}
+		/* Re-identification is only attempted from the not-present state. */
+		if (hw->phy.sfp_type != txgbe_sfp_type_not_present)
+			goto rearm;
 	}
 
 	if (hw->mac.type == txgbe_mac_aml) {
@@ -3094,10 +3102,14 @@ txgbe_dev_detect_sfp(void *param)
 	if (err == TXGBE_ERR_SFP_NOT_SUPPORTED) {
 		PMD_DRV_LOG(ERR, "Unsupported SFP+ module type was detected.");
 	} else if (err == TXGBE_ERR_SFP_NOT_PRESENT) {
-		PMD_DRV_LOG(INFO, "SFP not present.");
-		/* Module removed: drop the cached type and stop the watchdog. */
-		hw->phy.sfp_type = txgbe_sfp_type_not_present;
-		rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+		/* The poll runs every two seconds while the cage is empty, so
+		 * only the removal itself is reported.
+		 */
+		if (hw->phy.sfp_type != txgbe_sfp_type_not_present) {
+			PMD_DRV_LOG(INFO, "SFP not present.");
+			hw->phy.sfp_type = txgbe_sfp_type_not_present;
+			rte_eal_alarm_cancel(txgbe_dev_e56_check_bp_event, dev);
+		}
 	} else if (err == 0) {
 		hw->mac.setup_sfp(hw);
 		PMD_DRV_LOG(INFO, "detected SFP+: %d", hw->phy.sfp_type);
@@ -3114,6 +3126,14 @@ txgbe_dev_detect_sfp(void *param)
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

