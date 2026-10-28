Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC9606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9287640E01;
	Wed, 28 Oct 2026 11:40:52 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 8305640264;
 Wed, 28 Oct 2026 11:40:46 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184028t66dae244
X-QQ-Originating-IP: tXsoZWg/1MrF2Ua2JnyadKMrp+CZtCLxCtc0C46du3M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16571824509418670110
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 13/17] net/txgbe: fix Tx laser left on at AML40 link down
Date: Wed, 28 Oct 2026 18:34:02 +0800
Message-ID: <F4A87981BAA6525F+20261028103913.10188-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MoMGd7r8lWYPXo7QfYPs2R2rjIDB6tuwpMD2wrNT15zWrEyZSqLw7mW2
 17cZu3WXkLiIx+MCXnKwIFyxLDyj9tHiJI76SCHmaG0aG8RCU7qN/YEokwQNTSJxenE1yIR
 jKauQVxabROG3YabxU4tzUAqi2bzwvcKO3kAJ9nmUdPi3rtmGhRM68t055QoecD80KEK4tw
 1vkP03695G4q/i6MYTB0JhNQz6QrXkzYTmKXPDdOQFSxbSxKNqQIzuwH1NCZffiYXTipJc4
 M1OrhNx2Ft8N/Y2eHLUkvPTJlpcFW3YH1gKsHIoF5Nl3hjNfF6GARgYmkr91xkP7y8y1ySt
 EZxb6HOTJvrLmW9egoVMD+VwQsalHymzO/PZOJ2HQEE1Wx6wDC/Uz7HZS1M4kBkQtkqfKV/
 1GGzHRpQfONy2MgjDABjLYNoNJlxNHM2Jqmlq8PlKrXcubZby/lqX9csTudCBsW+WPipSwK
 7GGeUp2DqVCqWfGguCIdG1Se1otDWOAAF9mz4T2ZaCxQPBACa3EpvU7eQxIH3rPnK0bZ6Lm
 GRNIXO6LsfYd1My/2opE8LHVbuc2oS66S2IPlIfy2RKMgKVfEkJ/nPILT9qjZ2gRI4s3xQ8
 GnEb6o00nuDz+AesRcc2eiAGh929k+Q4dhQzHXnOxCE+Eo85nC1lH79RoqJwC0IEdxquVQN
 swYjdM+Qmey+J/zCrQ55tT7KrKX46DZHy5JYWQhf8abBWofIuRLS+CYQQhZ5Yj58Mu8RFD5
 +ARFq2td9ZqFjisbySf9yl0bPlqiOyhYGk+RZ5uw+dZdNcpoIPLpg1rcefNIyfGz4nZaNrz
 4aS+V5+EDOcMF6UM2i/F6pbTHR55sfUeVHLXi6d7/q89K0tfR0+GOKi8Acc7u7AdAsZMYmU
 ZyJHBH6YudWLX67WrayMITg7FmVRlVzrY0kMOyk4fFO2vwE1xX+uBNrGDCEwrjmzqZDjQKs
 2aFpoH1OPNm6LwNYoNYsbFdeeaHrlloayek2rbs+yih9E0BQHX0cc57fchxObG0h60JaMpn
 u9k26ZWYTTMjWmIevPkgGDMCJVyc/3a00ldy7FfTJ9LNdtaRq3HkAEqakqEpN6aBwoAlq5E
 Lw8agDqAGMiEO6estMsFd0=
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

txgbe_disable_tx_laser_multispeed_fiber() brings the laser down by
driving GPIO bit 1, which holds the SFP module in reset. Some DAC
cables and QSFP modules keep sending after that, so the port reports
link down while the peer still sees a live signal and cannot detect the
loss of signal.

Clear the PMD_CFG0 transmit and receive enables for DAC cables, and
write the SFF-8636 Tx disable bit for QSFP modules. The SFF-8636
register is only written while the management semaphore is held, and
the acquire_swfw_sync() result is checked so a failed acquire does not
release a semaphore that is not held.

Re-enabling the transmitter alone does not restore what link-down
disabled for DAC, so run the normal link setup again when the link
comes up. The setup is not gated on the current module classification
because the module may have changed while the port was down.

That setup resets the PHY, and restarts the AN73 negotiation when
auto-negotiation is enabled. That is the cost of bringing the link back
up.

The SFF-8636 Tx disable byte keeps its value while the module stays
powered, so link-up clears it for any module present, including one
left disabled by a previous run.

The PHY init failure path was the only one in txgbe_set_link_to_amlite()
that still drove the laser on the 40G MAC; the disable call before the
PHY reset and the enable call on the success path are both limited to
the 25G MAC. The 40G transmitter is not turned off anywhere in that
function, so enabling it again on the failure path changed nothing.
Limiting it the same way also keeps that call out of a path that runs
with the PHY lock held and the management semaphore already taken,
which the SFF-8636 write inside enable_tx_laser() would acquire again.

Fixes: e30e5fba32c4 ("net/txgbe: support Tx laser enable/disable for Amber-Lite")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c |  3 ++-
 drivers/net/txgbe/base/txgbe_hw.c  | 31 ++++++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h |  6 ++++++
 drivers/net/txgbe/txgbe_ethdev.c   | 17 ++++++++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index c0e5cc3894..3740ba4955 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -3370,7 +3370,8 @@ int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed)
 	value = rd32_epcs(hw, VR_PCS_DIG_CTRL1);
 	if ((value & 0x8000)) {
 		status = TXGBE_ERR_PHY_INIT_NOT_DONE;
-		hw->mac.enable_tx_laser(hw);
+		if (hw->mac.type == txgbe_mac_aml)
+			hw->mac.enable_tx_laser(hw);
 		goto out;
 	}
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 2650b8b7f1..eb032eea63 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,7 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
 
@@ -3259,6 +3260,28 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg &= ~TXGBE_GPIOBIT_1;
+		if (txgbe_is_dac_cable(hw) ||
+		    hw->phy.sfp_type == txgbe_sfp_type_unknown ||
+		    hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+			u32 rdata = 0;
+
+			rte_spinlock_lock(&hw->phy_lock);
+			rdata = rd32_ephy(hw, PMD_CFG0);
+			set_fields_e56(&rdata,
+				       E56PHY_PMD_CFG_0_RX_EN_CFG,
+				       0x0);
+			set_fields_e56(&rdata, 15, 12, 0x0);
+			set_fields_e56(&rdata, 1, 1, 0x0);
+			wr32_ephy(hw, PMD_CFG0, rdata);
+			rte_spinlock_unlock(&hw->phy_lock);
+		} else if (hw->mac.acquire_swfw_sync(hw,
+						    TXGBE_MNGSEM_SWPHY) == 0) {
+			hw->phy.write_i2c_eeprom(hw,
+				TXGBE_SFF_8636_TX_DISABLE,
+				TXGBE_SFF_8636_TX_DISABLE_ALL_LANES);
+			hw->mac.release_swfw_sync(hw,
+						TXGBE_MNGSEM_SWPHY);
+		}
 	} else if (hw->mac.type == txgbe_mac_aml) {
 		esdp_reg |= TXGBE_GPIOBIT_1;
 	} else {
@@ -3288,6 +3311,14 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg |= TXGBE_GPIOBIT_1;
+		if (!txgbe_is_dac_cable(hw) &&
+		    hw->phy.sfp_type != txgbe_sfp_type_unknown &&
+		    hw->phy.sfp_type != txgbe_sfp_type_not_present &&
+		    hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
+			hw->phy.write_i2c_eeprom(hw,
+				TXGBE_SFF_8636_TX_DISABLE, 0x0);
+			hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+		}
 	} else {
 		esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
 	}
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index a5df015a4d..a06c0eb04e 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -251,6 +251,12 @@
 #define TXGBE_SFF_VENDOR_OUI_BYTE1	0x26
 #define TXGBE_SFF_VENDOR_OUI_BYTE2	0x27
 #define TXGBE_SFF_1GBE_COMP_CODES	0x06
+
+/* SFF-8636 PMD Tx disable register (byte 0x56); bit per lane,
+ * 0xF disables the transmitter on all four lanes.
+ */
+#define TXGBE_SFF_8636_TX_DISABLE		0x56
+#define TXGBE_SFF_8636_TX_DISABLE_ALL_LANES	0x0F
 #define TXGBE_SFF_10GBE_COMP_CODES	0x03
 #define TXGBE_SFF_25GBE_COMP_CODES	0x24
 #define TXGBE_SFF_COPPER_LENGTH		0x12
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 541e7ca84f..5a29b2b934 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2202,6 +2202,9 @@ static int
 txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	bool autoneg = false;
+	u32 speed;
+	int err;
 
 	if (hw->phy.media_type == txgbe_media_type_copper) {
 		/* Turn on the copper */
@@ -2209,6 +2212,20 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 	} else {
 		/* Turn on the laser */
 		hw->mac.enable_tx_laser(hw);
+
+		if (hw->mac.type == txgbe_mac_aml40) {
+			speed = hw->phy.autoneg_advertised;
+			if (speed == 0) {
+				err = hw->mac.get_link_capabilities(hw, &speed, &autoneg);
+				if (err != 0)
+					return -EIO;
+			}
+
+			err = hw->mac.setup_link(hw, speed, true);
+			if (err != 0)
+				return -EIO;
+		}
+
 		hw->dev_start = true;
 		txgbe_dev_link_update(dev, 0);
 	}
-- 
2.55.0.windows.2

