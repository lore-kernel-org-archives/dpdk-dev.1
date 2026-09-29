Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE1BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 858F642DDC;
	Tue, 29 Sep 2026 15:06:54 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id B3409427C6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:06:49 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687204t80e82f18
X-QQ-Originating-IP: sCKgtoPGDE+zNEjoEl8RmcShhs0vcIj/p88GAuoW/0g=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6247151980871207067
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 13/15] net/txgbe: add devarg to turn off Tx laser for 40G
 NIC
Date: Tue, 29 Sep 2026 21:04:44 +0800
Message-ID: <B359507E58F60369+20260929130611.4871-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OfHd9xF5rGrD6iImIim7JPNOsJV9JTCCyeR44xYwjxLD69cGAil209oC
 DPyRmagIGA0gnUszvNuAJvEFQQ9QMuXkjH4easT9m93Sia5qOW+rFAdvYhT6TXKWwZM77eT
 aXhfNPm3OdyVn+1MA+iYR5BDnzGsPai2Cr6L2uL38/UdtEl+SK8O4Q9g3hU6149+Z5ZpT2y
 GKj8J1lEk9zKwEfIiPFOTjftPdR6yEFr2WxCeYhZxoIdQLQjS1WQy2NneMlNMsTH33pF1Du
 9vl6sqZG1p0CAuUksQxlsZTCOBm087RRDHQCgLtaWqCz4BMKLEoOsXFtPDLSQccZrpEdnT6
 cgI0t+tl63ePW3Ay/imQhk7vTcOdLVjwBinaU5/Qh+CwXPNqiT3JLhWxiN6X7D/VCnoqwAW
 kEhjxkrLWTETUsUyX8A2Etr5n0VbTvfAANRS19bi0b+HoSW4ZVsJkAv2MGFPd374w437dNw
 +tZDV7h1j303Fo+N4aVUuVhPHRk/zBseSJX1I13BnJcNvEoCKJzjnlF5OqlY5CW5NQ+bjNY
 Gmd/r8JbVLYppC/zNiaMREVnzz1UC1FUC1xNhvjGAG4L0saonNO1BUjIbK5WfowdVHb+QX/
 OgG2c+GPr4NqNtyv4BC9LzJtUU3c2CtOXYFssublFi8UXLL5sAHaWeox1CYm8GiEhZwdAw7
 wXdjOJq8x9Z5Zz2DIqAb2OEXFt4DhbdNJW9yUOg01Tw4hJnKpDllmRX6/llcBh+etieJfNz
 aeTTe4hT8kpMWzygy4lcl+z7ZPzr3fcl07A9CJtKG2USnylaX2JnArR9cMrRYQyER5IgxCF
 DGz9vZAKd2eYROVSoyaGpk+ZjDyLItxE34cBk1AyayllZjZfiPESRQMZLyhbi0f0p4KXiyf
 Rh3ZM1V1jkj327IuYRlJVqJG3CIQA/qXvO0hmee3tmgeCAtJdgoRPnbVKECljuHchiJ3nhy
 DhWKRYzqVVQlTzK4NokiraezYH/hGOWCtQOwX4xWkiXiCwUo8pDQ2WFygl2170TdMkB640I
 5Im+vH3oHrkY2Rz3tNPbpNXaYeEVgABbIbiwur+KOIORSYk+Lwq5CL6bXghkZ4d72Ld1qxe
 nJGAuADpB8np+ZpA9/HDoNC3SaWHNr0Xmb108J4DsraS4ZBR6tWm9LHYNrnavI8nQ==
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

Restoring the Tx enable state is deliberately not gated on
laser_off in txgbe_enable_tx_laser_multispeed_fiber(). The SFF-8636
Tx disable byte keeps its value while the module stays powered, so
a module left with Tx disabled by a run that exited with
laser_off=1 is still disabled when the driver next starts with
laser_off=0. Nothing else clears that byte when the link comes up,
so gating this write would leave the laser off for good.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst              |  7 ++++++
 doc/guides/rel_notes/release_26_11.rst |  3 +++
 drivers/net/txgbe/base/txgbe_hw.c      | 33 ++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_phy.h     |  6 +++++
 drivers/net/txgbe/base/txgbe_type.h    |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c       |  7 +++++-
 6 files changed, 58 insertions(+), 1 deletion(-)

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
index 53da0dc66c..40ec9f457f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -141,6 +141,9 @@ New Features
   * Added the ``bp_capa`` device argument to select the advertised
     backplane capability on the 40G NIC
     (0 for 40GBASE-KR4 + 40GBASE-CR4, 1 for KR4 only, 2 for CR4 only).
+  * Added the ``laser_off`` device argument: when set, the 40G NIC
+    turns its Tx laser off on port down
+    (PCS disable for DAC cables, SFF-8636 Tx disable for QSFP modules).
 
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
index cd54b696b4..999a8e9316 100644
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
@@ -6501,7 +6505,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

