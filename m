Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1485BCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1025440A79;
	Mon, 12 Oct 2026 13:06:07 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 91D2F402C4
 for <dev@dpdk.org>; Mon, 12 Oct 2026 13:06:04 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803159t28146b8e
X-QQ-Originating-IP: NL1y8trtbqAt4bZU2PI1cCofRzmAUNE3cJfhV7YuyAw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9897121218878099929
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 13/16] net/txgbe: add devarg to turn off Tx laser for 40G
 NIC
Date: Mon, 12 Oct 2026 18:56:30 +0800
Message-ID: <1E4A5EEAD37C0200+20261012110518.1911-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOJijf76Vc+iLivMyyi5inMKI2bIc0GABxrbB4f3wLxP8pvIhBjtzq3h
 zK7TThdcO/PUs8CdyQ4gyc6JswSJRAQuFoVwOS1GjVR6hAIHYbMGtfP7YGtG91rqkf2lfT5
 oC6ouswPExseJVF00LJaDS59oUhtIsU5p5/eJIKylge2DjIYi+A7jJ5i/630bSc7DWQ3n12
 m4UUCIrIRJyNyUP/CbnRE2fKjqxpgK0OpQnjeIxvkuJsLs55YcqUy4E6GddIvfa0qHAOQZe
 0j+cvwaKEY6GFu2X/F57x1h2bHurX3cZWd/M6iEflvQohvZ71/vBXpEkzBNBZSgluyXSdQs
 e+hgHvd/h/eI+P9IzNuSAYFpfe7O8uFkAxq0iSsYRE2dhRi9fjQPgboI9GX9ive2ihOgTSB
 3BlTfuVAVjxwZXvSMGNAOs8FQSehHhEpPB1RB1gWfE4TsIRD28cY/oIcNHailmIzAmd86pp
 4DU+KvcyqNhm+z2cLa0ZC5h2UlpLC2H2xieDkvzPTUNzJ4s/vK2Uw/DVwK03nwneFwzjwrs
 uv2oR2xVMElW5l4ecD4V9W0sUDAM6KOKtSxLBIMcpiCUiTDyv6VGMDRhdA//D8rKfa81KxY
 bC7jKwI6QezF1ASJRL/NypsWHBfK4lluBdjQp0ZWhmnLdsp7571bwn+22xwbemfAO+uoNUr
 nrqv0YpeYc+eaJ7B7jg4mKr8qfcTjq5KnWamfdIlR8QIVp+j+Rt+EHfWZJ8fInejFXcSGpE
 3YjqyDtUvqHfmu0RLHRnb+4D4/F+VQiuYrhjxy5C84dV+mIgzSioQtYVmokx1IuJQj2FVPQ
 AjI7AIVRQUCOyqX2djlIzjIALiNGtOpCOdfDoSyCX1SC21bBmTDkqgYI/wpmRrA0m3G7QBS
 iL2bC3qsNjnh50fXH3RvE1fpCKjpTtUTjzTkh14oGnY4gKatnBfTZ+l3g19k1g5Ii3kS8f8
 yw0GoCRbzR79c8i0p51ln75FiWNqFv9ukHmcKs/jqToipUIHff2yur+KD9MURcWKx99XNBU
 95+XvGSdiSWelmzviQv0KKzrKefd33DEz3pryaweLypYwqYWvtY3np1g4NEGpvPNL3Qaygr
 ebMuGfrIiHNcV9UiIxJycnl3iRJhMq8BQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

When the port is brought down, the Tx laser stays on, so the peer
keeps seeing a live signal and cannot detect the link loss, for
example for link-state tracking at the peer.

Add a laser_off devarg: when enabled, bring the Tx laser down on port
link-down -- for DAC cables disable the PCS, for QSFP modules write
the Tx disable bit via I2C -- and restore the Tx enable state when
the link comes up. The SFF-8636 Tx disable register is only touched
while the management semaphore is held, and the acquire_swfw_sync()
result is checked so a failed acquire does not release a semaphore
that is not held. Replace the raw register offsets and bit masks with
named constants (PMD_CFG0, E56PHY_PMD_CFG_0_RX_EN_CFG,
TXGBE_MNGSEM_SWPHY, TXGBE_SFF_8636_TX_DISABLE).

For AML40, rerun normal link setup when link is brought up with
laser_off enabled. Re-enabling the transmitter alone does not restore
the configuration disabled for DAC on link-down. The setup is not
gated on the current module classification because the module may have
changed while the port was down.

Restoring the Tx enable state is deliberately not gated on laser_off
in txgbe_enable_tx_laser_multispeed_fiber(). The SFF-8636 Tx disable
byte keeps its value while the module stays powered, so a module left
with Tx disabled by a run that exited with laser_off=1 is still
disabled when the driver next starts with laser_off=0. Nothing else
clears that byte when the link comes up, so gating this write would
leave the laser off for good.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              |  7 ++++++
 doc/guides/rel_notes/release_26_11.rst |  4 +++-
 drivers/net/txgbe/base/txgbe_hw.c      | 33 ++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h     |  6 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c       | 24 ++++++++++++++++++-
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 61766cc4ac..6aa6d4597f 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -189,6 +189,13 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
   40GBASE-KR4 and 40GBASE-CR4, set 1 for 40GBASE-KR4 only, set 2 for
   40GBASE-CR4 only.
 
+- ``laser_off`` (default **0**)
+
+  Toggle behavior to disable the Tx laser when the port is brought down
+  on the 40G NIC. By default the Tx laser is left on. When enabled, for
+  DAC cables the PCS is disabled, for QSFP modules the Tx disable bit is
+  written via I2C.
+
 Driver compilation and testing
 ------------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f40f9e7da3..d62f787747 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -149,6 +149,9 @@ New Features
   * Added the ``bp_capa`` device argument to select the advertised
     backplane capability on the 40G NIC
     (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+  * Added the ``laser_off`` device argument: when set, the 40G NIC
+    turns its Tx laser off on port down
+    (PCS disable for DAC cables, SFF-8636 Tx disable for QSFP modules).
 
 * **Updated ZTE zxdh ethernet driver.**
 
@@ -172,7 +175,6 @@ New Features
   for a specific queue, complementing the existing device-level statistics API.
 
 
-
 Removed Items
 -------------
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 2650b8b7f1..cbf859c54f 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,7 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
 
@@ -3259,6 +3260,30 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg &= ~TXGBE_GPIOBIT_1;
+		if (hw->devarg.laser_off) {
+			if (txgbe_is_dac_cable(hw) ||
+			    hw->phy.sfp_type == txgbe_sfp_type_unknown ||
+			    hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+				u32 rdata = 0;
+
+				rte_spinlock_lock(&hw->phy_lock);
+				rdata = rd32_ephy(hw, PMD_CFG0);
+				set_fields_e56(&rdata,
+					       E56PHY_PMD_CFG_0_RX_EN_CFG,
+					       0x0);
+				set_fields_e56(&rdata, 15, 12, 0x0);
+				set_fields_e56(&rdata, 1, 1, 0x0);
+				wr32_ephy(hw, PMD_CFG0, rdata);
+				rte_spinlock_unlock(&hw->phy_lock);
+			} else if (hw->mac.acquire_swfw_sync(hw,
+							    TXGBE_MNGSEM_SWPHY) == 0) {
+				hw->phy.write_i2c_eeprom(hw,
+					TXGBE_SFF_8636_TX_DISABLE,
+					TXGBE_SFF_8636_TX_DISABLE_ALL_LANES);
+				hw->mac.release_swfw_sync(hw,
+							TXGBE_MNGSEM_SWPHY);
+			}
+		}
 	} else if (hw->mac.type == txgbe_mac_aml) {
 		esdp_reg |= TXGBE_GPIOBIT_1;
 	} else {
@@ -3288,6 +3313,14 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
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
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index d65a50530f..33e306ac70 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -762,6 +762,7 @@ struct txgbe_phy_info {
 #define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
 #define TXGBE_DEVARG_RX_DESC_MERGE	"rx_desc_merge"
 #define TXGBE_DEVARG_BP_CAPA		"bp_capa"
+#define TXGBE_DEVARG_LASER_OFF		"laser_off"
 
 static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_BP_AUTO,
@@ -779,6 +780,7 @@ static const char * const txgbe_valid_arguments[] = {
 	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
 	TXGBE_DEVARG_RX_DESC_MERGE,
 	TXGBE_DEVARG_BP_CAPA,
+	TXGBE_DEVARG_LASER_OFF,
 	NULL
 };
 
@@ -834,6 +836,7 @@ struct txgbe_devargs {
 	u16 tx_headwb;
 	u16 tx_headwb_size;
 	u16 rx_desc_merge;
+	u16 laser_off;
 };
 
 struct txgbe_hw {
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 07b6d13ce1..ae3dbf076e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -493,6 +493,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
 	u16 bp_capa = 0;
+	u16 laser_off = 0;
 
 	/* The E56 PHY needs its own FFE defaults, as the ones above only
 	 * apply to the Sapphire PHY.
@@ -546,6 +547,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &rx_desc_merge);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
 			   &txgbe_handle_devarg, &bp_capa);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_LASER_OFF,
+			   &txgbe_handle_devarg, &laser_off);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -556,6 +559,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->devarg.tx_headwb = tx_headwb;
 	hw->devarg.tx_headwb_size = tx_headwb_size;
 	hw->devarg.rx_desc_merge = rx_desc_merge;
+	hw->devarg.laser_off = laser_off;
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
@@ -2158,6 +2162,9 @@ static int
 txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	bool autoneg = false;
+	u32 speed;
+	int err;
 
 	if (hw->phy.media_type == txgbe_media_type_copper) {
 		/* Turn on the copper */
@@ -2165,6 +2172,20 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 	} else {
 		/* Turn on the laser */
 		hw->mac.enable_tx_laser(hw);
+
+		if (hw->mac.type == txgbe_mac_aml40 && hw->devarg.laser_off) {
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
@@ -6499,7 +6520,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
 			      TXGBE_DEVARG_TX_HEAD_WB "=<0|1>"
 			      TXGBE_DEVARG_TX_HEAD_WB_SIZE "=<1|16>"
 			      TXGBE_DEVARG_RX_DESC_MERGE "=<0|1>"
-			      TXGBE_DEVARG_BP_CAPA "=<0|1|2>");
+			      TXGBE_DEVARG_BP_CAPA "=<0|1|2>"
+			      TXGBE_DEVARG_LASER_OFF "=<0|1>");
 
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(txgbe_logtype_driver, driver, NOTICE);
-- 
2.55.0.windows.2

