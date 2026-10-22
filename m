Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DED606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32F0F40DCB;
	Thu, 22 Oct 2026 13:11:09 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6C840689
 for <dev@dpdk.org>; Thu, 22 Oct 2026 13:11:05 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667461t39633935
X-QQ-Originating-IP: c36JJGLGdxfHFLhZCZ8Cc/D8L5Uu1pKfv3TeM3+Bu2c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:11:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5812380161896119624
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 13/16] net/txgbe: add devarg to turn off Tx laser for 40G
 NIC
Date: Thu, 22 Oct 2026 19:03:19 +0800
Message-ID: <748FDE95C9939A4F+20261022111017.3605-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MkHPGCJDhue0KRdsCd1aq8pZ8K3If8bcfclGxp4YTDw8lTqAZtaIA8Nm
 VZMMobjPhHOtQa2UZebhE0pQelu80LIw7Iavgv+NUxTwvpFbShnuFeD9YEUhQgFdvwOY/GR
 zfomfOLI0AvTgIsCkeub5X0ThkdhS+k7DR/lKW0o61ofVhoHy1ScftWxfngTPgJM7n3mkPV
 TGWPyXFH11+aDYfJU7ZsgmzP7Qve+X0SR72FpuG75UE5Qnfg8e5ZUS2CZxMJBJ3W4kL+k8i
 FjmUeORpcx2KvMn7vP9mgcHRkg1X6aiEuCc/XFTWqaB+AjOzOBa2kkVDn0QJx2MRfQNwLcC
 avkvt+OfhUj6Z5YxzLc+775sYL0zzYTGMeBWLMYI5BiXpoDLhOsqdQi/QcoOyZhITpkRbMC
 kkmZh0RAFC995dTzkLKiAF7jW7oVRI87IJR+ENNj3iTT/j/w4tsqfL5W3xWFITrVXew0A9U
 OMcAoHF+sy3oU6yJK4jIHh8ORrjZWQqaFUL3oFTTuVhM/JUO+PDZnQ7JGuq6aaROxyll3fx
 dQ+MudNrbL+qwKyNXyHPR2Om8jNFurEjxmsR0XqkCMUiTI8+r4z+kimAk/yIBkBNErTTkKG
 Smc9d6hQXB8+kVigO3glW0fH8APow8/9F9Bu2BwalbbzMOijuR1fLEqFI9qK/bVtLBQ/WMq
 f6xTLt0jTkM4atgZNkar+9tGBcCvktIZwd5AcpD8zq6QwM3i9qCpAmHp8PpWtdX3YSTCzH1
 XkChPnn1+4RdBGKjpkFvIe7I2mOaqarUlx5mdipLgi+I8xcats1pva3ALglZfgdsUqsbe9X
 b9M89aqGe+DtOEPSXsaeV8uEqJ+F/CW1DKnDmDkJ4/1CQEgkcOfQesECUEB3/zCO9UDcFCx
 8dV0UrO196eNtkF90C38OEtUaPC4ZUVayHCmpyS3fXAfrFzdE18i/tD/CNZWIt26YbcgX9d
 buLNZbGkIaRUGthfe2Lg6wW6FIQIVsRfmWPHGsnEmm8WcgXZiYgqWHtvMrd3j3XsqjTp1k3
 SmXmKA2LjRXVsE374yo+s/7oi0Lrg4aFwy0mNDCpNT5z5mOAfGzhXNiBQJbqAzpzOW3nvA1
 jSQZ1tVksSisK0/rpVkV90=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

When the port is brought down, the Tx laser stays on, so the peer
keeps seeing a live signal and cannot detect the link loss, for
example for link-state tracking at the peer.

Add a laser_off devarg: when enabled, bring the Tx laser down on port
link-down -- for DAC cables disable the PCS through PMD_CFG0, for
QSFP modules write the Tx disable bit via I2C -- and restore the Tx
enable state when the link comes up. The SFF-8636 Tx disable register
is only touched while the management semaphore is held, and the
acquire_swfw_sync() result is checked so a failed acquire does not
release a semaphore that is not held.

For AML40, rerun normal link setup when link is brought up with
laser_off enabled. Re-enabling the transmitter alone does not restore
the configuration disabled for DAC on link-down. The setup is not
gated on the current module classification because the module may have
changed while the port was down.

That setup resets the PHY and restarts the AN73 negotiation, so the
additional disable is opt-in: a port that only has to report link
down does not pay for it on the next link-up.

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
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 drivers/net/txgbe/base/txgbe_hw.c      | 33 ++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h     |  6 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c       | 24 ++++++++++++++++++-
 6 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 0f5b48683d..f45be2c6aa 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -196,6 +196,13 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
   40GBASE-KR4 and 40GBASE-CR4, set 1 for 40GBASE-KR4 only, set 2 for
   40GBASE-CR4 only.
 
+- ``laser_off`` (default **0**)
+
+  Toggle behavior to disable the Tx laser when the port is brought down
+  on the 40G NIC. By default the Tx laser is left on. When enabled, for
+  DAC cables the PCS is disabled through PMD_CFG0, for QSFP modules the
+  Tx disable bit is written via I2C.
+
 Driver compilation and testing
 ------------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 7b6bf917a0..4f6ff9ea62 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -207,6 +207,10 @@ New Features
   * Added the ``bp_capa`` device argument to select the advertised
     backplane capability on the 40G NIC
     (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+  * Added the ``laser_off`` device argument: when set, the 40G NIC
+    turns its Tx laser off on port down
+    (PCS disable through PMD_CFG0 for DAC cables, SFF-8636 Tx disable
+    for QSFP modules).
 
 * **Updated ZTE zxdh ethernet driver.**
 
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
index 909457c536..a72cb15d1a 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -493,6 +493,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
 	u16 bp_capa = 0;
+	u16 laser_off = 0;
 
 	/* The E56 PHY has its own FFE defaults; the ones above are Sapphire. */
 	if (hw->mac.type == txgbe_mac_aml) {
@@ -544,6 +545,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &rx_desc_merge);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
 			   &txgbe_handle_devarg, &bp_capa);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_LASER_OFF,
+			   &txgbe_handle_devarg, &laser_off);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -554,6 +557,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->devarg.tx_headwb = tx_headwb;
 	hw->devarg.tx_headwb_size = tx_headwb_size;
 	hw->devarg.rx_desc_merge = rx_desc_merge;
+	hw->devarg.laser_off = laser_off;
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
@@ -2170,6 +2174,9 @@ static int
 txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	bool autoneg = false;
+	u32 speed;
+	int err;
 
 	if (hw->phy.media_type == txgbe_media_type_copper) {
 		/* Turn on the copper */
@@ -2177,6 +2184,20 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
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
@@ -6515,7 +6536,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

