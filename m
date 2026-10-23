Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B5D606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D924540A6C;
	Fri, 23 Oct 2026 13:08:30 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 6C4304069F
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:08:29 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753703t15a39769
X-QQ-Originating-IP: MUvPT8QskmKYzlcayDlZmwgBdlg/qpu96dPnXm35GpU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11778933404429760861
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 13/17] net/txgbe: add devarg to turn off Tx laser for AML40
Date: Fri, 23 Oct 2026 19:03:51 +0800
Message-ID: <3895B1178E8FD14F+20261023110728.3975-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mw3/skGyA4U5+o8st0jMs32Ovg40l2dfwWTUL6lb7wK2ovfIjUyFooay
 B7rk4V5iceueSwgGCSzU4Y+h/sKh82WnCZroFQmm7VdP/Qr92mbLXOWeSlXxBkWWjx7quv3
 5kmkq66EXcEDmk1CtDaiN43Hqql16FtdTHMMuV+1QQa24TaAbcFWl0dLm9SjCFqpYX1Pv1t
 0mvm6VqHs7Yhu79MiJtP/dpm7y4DEjFOB2cosU7111TSDX7N8dziM/CPnSfKcfakA2d4TTn
 liJSkPBCJs9aLykrFqCNIvgE8YITQrtVqaZqdKKCRPRNWb5sefLNigw8aUYaOrKxdPvPsmV
 rHErgoppXtXAfgxvIHkGqDtjOqj+riOyh3FgEweiJ0zz/DI1XNeyrj2POakMYe5U+j4UVrf
 abo4iGag9oYpzte5/a3AAuh3xHDnvb/Mx22MwKYD28y7Gie30S7hX2cY+GIRZzizIIFxzM2
 kG0HlKpKeRlYiaQcEgmy7iNYfs8Ave7us/cR3X7ljFy7/Urxlz1gjBUP6W19foSLM2QAnhw
 JmUeDiFTTOAo8xTARfwmhOi6KqupFge7wbBt5jNVRINs7EKpQvUi/NED6S3jbvBG96XmMWW
 xHupW/zbO9vtzG44DhlPN4DXT7Wi8V27RJJfOhD72JeA1dI+zbLRiB5lmVdG/M+uUhIkuG7
 ggNj3b8j3vvJCJs9EjcYc7VgBEegk8M2EBh6+WOrnQEm6mVsmYu+sTCkjAv9jPGwj8Du9lL
 dtK7NUnPZNt8khzrG2VtPLuZbRSkRPOszVc9CgQt3QzPufDfiZly+K+JjDj0HiuWqejCDTR
 IeF0T2QQvkhXAueBhugxlXY0RcUiOYKim9/N55Uia3LZfDrXuQzNjN6Wq7KIGVLctFn0Xph
 uAl47NbYleBl5+frfZ93GQVH++FPYbhswJvrxHHHR6nvfo2LLOr+6VDTKhqDS8Vjnfbv89V
 twxIsp1Y+F3GeqFnCS/zSd3F4V1I9gL3M2mHVevgCRUqJ2IzFUDFLyRrO61n0VdchTLHFW0
 tiqz9EfGkAZ5Kc5sYoLP0qnYxN8KieNhizerUh/vtVXJCsykyHYRTkID/9NSAGQzYwzQ6p1
 7WHBLdjv8GxYoLthlI8uVI=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index 13f6a0a1fa..217f5aae68 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -196,6 +196,13 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
   both 40GBASE-KR4 and 40GBASE-CR4, set 1 for 40GBASE-KR4 only, set 2
   for 40GBASE-CR4 only.
 
+- ``laser_off`` (default **0**)
+
+  Toggle behavior to disable the Tx laser when the port is brought down
+  on the Amber-Lite 40G NIC. By default the Tx laser is left on. When
+  enabled, for DAC cables the PCS is disabled through PMD_CFG0, for QSFP
+  modules the Tx disable bit is written via I2C.
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
index d669fcf116..df08332a3c 100644
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
@@ -2182,6 +2186,9 @@ static int
 txgbe_dev_set_link_up(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	bool autoneg = false;
+	u32 speed;
+	int err;
 
 	if (hw->phy.media_type == txgbe_media_type_copper) {
 		/* Turn on the copper */
@@ -2189,6 +2196,20 @@ txgbe_dev_set_link_up(struct rte_eth_dev *dev)
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
@@ -6527,7 +6548,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
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

