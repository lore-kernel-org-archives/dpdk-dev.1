Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9D0C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB0C5410F2;
	Tue,  8 Sep 2026 14:41:37 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 4C2AC40E2F
 for <dev@dpdk.org>; Tue,  8 Sep 2026 14:41:33 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871288ta5342cf8
X-QQ-Originating-IP: x937f4RaV1BkfOt9DGi1H1sGitCvUuGWihbhAbEpEMU=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12055109586392032094
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 13/15] net/txgbe: add devarg to turn off Tx laser for 40G
 NIC
Date: Tue,  8 Sep 2026 20:38:58 +0800
Message-ID: <C1A657712BBF9AEA+20260908124047.2284-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MheOLAy0ZeCvjJ6jae/dmRWPGGO3UQO2XR37GGlkkniNMZn/xV0SNGRg
 AghQXHovT3NA2TmHsHHLUaGAKIi9cfh7TWSvjiDGrqGe82SbBzdHndsQAGqhlg/baexT5VP
 18lJqn8KiMhO40KqqWNKTlQvVBkfy33DwALFtwgYSrciefMg9s95g0Ja3rFA9YzVjTi4nAt
 LGZi4ckYrftESdV3LZ8ar16Cf2serhMbVC7H6U+NG8JqxkegrBJmZcUToZG7cti3zftL4fH
 DcMMxNLqKSIsQGX5RAvqGJX9hTAwOXXE9D/0luzJ9dINmkJ8ThwFWosVFExN1d5sPJKn/KN
 qgxHMOwKX3w8YsIwWB5FA4HNEJw8dtFC7VsuNN3niNNPmniHKT1mTo7tDK35rl03EU5vwyS
 HaAbyPJ+VrJAiqasGTSeRx14DaB7LJaTJoZs5TbsAGvRyXKB3Q1ZkHQ2C+/+TKVJQ6i1Dq6
 Lmy7CLkRZ5oJBROW8vKItlBlOxp51n4NLZ+SYe7jwhY4RXKY/kGhPGGLdaKSVGYxvt83tFq
 vOIVTpDzfgDj/RBfiBg6hnRboK7I0bcWYCNYkgGQRfMNAUPh5aDlV1qBUl1Ev/bxY6kSfSM
 chSWdzgcjwmkJBpLyOIE91pRF/Cw3mjZRlwlzpzguB3zzfcfYJiQ2hXrC8/C+B1yjrEHAp7
 gTPOk91r9NZNcEicjkA1PD5DJzjw1E2V8DElOXPwjmB3dec+peHPHEeLLuOA5INmkPwiDOk
 xNbxvNcRiuVyY1n1B780Ip8awTVxwXDKAwCT2VBTFbiyiE/9xOy/CmtfTXuZI8UpoDv9hjR
 w5QoupoWpvFEnhm6AhkxnRygGteYtjCOY41eBWsekZwUy888Key+fibORBWgeLKKUdKuXbJ
 eso529IYKuF/zF2rIkQEHqUPZDRSEfQP+pGutFq878uO7DKwg1/w1vmUSiYiv9pdLxzb22F
 A32QYsvpHDCSzB8vRUaMrd2/bhXpHrLsNuzuAPn9RV0jzhA5+1r2HCZHj9s7n0RtoEvUyE6
 hd7Y8TqIlxORhcvajHqS+a3Sn7HUmElKziZzmoxkd77De5lBqFA+M0yfrxiqBhH2UbUkkLf
 Bi8NviTBL3XLfjaIUdAJyFCO3mwV7A+oH01QVw73BeyUt4iqUjuUYuae1grJiQX9w==
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

When the port is brought down, the Tx laser stays on, so the peer
keeps seeing a live signal and cannot detect the link loss (e.g. for
link-state tracking at the peer).

Add a laser_off devarg: when enabled, bring the Tx laser down on
port stop -- for DAC cables disable the PCS, for QSFP modules write
the Tx disable bit via I2C -- and restore the Tx enable state when
the link comes up. The SFF-8636 Tx disable register is only touched
while the management semaphore is held, and the acquire_swfw_sync()
result is checked so a failed acquire does not release a semaphore
that is not held. Replace the raw register offsets and bit masks
with named constants (PMD_CFG0, E56PHY_PMD_CFG_0_RX_EN_CFG,
TXGBE_MNGSEM_SWPHY, TXGBE_SFF_8636_TX_DISABLE).

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              |  7 +++++
 doc/guides/rel_notes/release_26_07.rst |  3 +++
 drivers/net/txgbe/base/txgbe_hw.c      | 37 ++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h     |  6 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c       |  7 ++++-
 6 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index d56fb3b99a..a580450726 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -188,6 +188,13 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
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
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f65044c9b9..4c302540d8 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -168,6 +168,9 @@ New Features
   * Added the ``bp_capa`` device argument to select the advertised
     backplane capability on the 40G NIC
     (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+  * Added the ``laser_off`` device argument: when set, the 40G NIC
+    turns its Tx laser off on port down
+    (PCS disable for DAC cables, SFF-8636 Tx disable for QSFP modules).
 
 * **Updated Intel qat crypto driver dependency requirements.**
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 2650b8b7f1..891f1ed0c4 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,7 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
 
@@ -3259,6 +3260,33 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg &= ~TXGBE_GPIOBIT_1;
+		if (hw->devarg.laser_off) {
+			if (txgbe_is_dac_cable(hw) ||
+			    hw->phy.sfp_type == txgbe_sfp_type_unknown) {
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
+			} else if (txgbe_acquire_swfw_sync(hw,
+							    TXGBE_MNGSEM_SWPHY) == 0) {
+				int err;
+
+				err = hw->phy.write_i2c_eeprom(hw,
+					TXGBE_SFF_8636_TX_DISABLE,
+					TXGBE_SFF_8636_TX_DISABLE_ALL_LANES);
+				if (err)
+					DEBUGOUT("Disable Tx laser failed %d\n", err);
+				txgbe_release_swfw_sync(hw,
+							TXGBE_MNGSEM_SWPHY);
+			}
+		}
 	} else if (hw->mac.type == txgbe_mac_aml) {
 		esdp_reg |= TXGBE_GPIOBIT_1;
 	} else {
@@ -3288,6 +3316,15 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg |= TXGBE_GPIOBIT_1;
+		if (txgbe_acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY) == 0) {
+			int err;
+
+			err = hw->phy.write_i2c_eeprom(hw,
+				TXGBE_SFF_8636_TX_DISABLE, 0x0);
+			if (err)
+				DEBUGOUT("Enable Tx laser failed %d\n", err);
+			txgbe_release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
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
index f56cd70c6f..39a70746a7 100644
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
index 27a6ff0b2e..9c31b2cfed 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -541,6 +541,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 tx_headwb_size = 16;
 	u16 rx_desc_merge = 1;
 	u16 bp_capa = 0;
+	u16 laser_off = 0;
 
 	/* The E56 PHY needs its own FFE defaults, as the ones above only
 	 * apply to the Sapphire PHY.
@@ -594,6 +595,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 			   &txgbe_handle_devarg, &rx_desc_merge);
 	rte_kvargs_process(kvlist, TXGBE_DEVARG_BP_CAPA,
 			   &txgbe_handle_devarg, &bp_capa);
+	rte_kvargs_process(kvlist, TXGBE_DEVARG_LASER_OFF,
+			   &txgbe_handle_devarg, &laser_off);
 	rte_kvargs_free(kvlist);
 
 null:
@@ -604,6 +607,7 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	hw->devarg.tx_headwb = tx_headwb;
 	hw->devarg.tx_headwb_size = tx_headwb_size;
 	hw->devarg.rx_desc_merge = rx_desc_merge;
+	hw->devarg.laser_off = laser_off;
 	hw->phy.ffe_set = ffe_set;
 	hw->phy.ffe_main = ffe_main;
 	hw->phy.ffe_pre = ffe_pre;
@@ -6518,7 +6522,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

