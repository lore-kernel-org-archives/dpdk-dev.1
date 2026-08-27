Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86AAC61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 11:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10AE84027D;
	Thu, 27 Aug 2026 13:44:23 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id D35954067B
 for <dev@dpdk.org>; Thu, 27 Aug 2026 13:44:20 +0200 (CEST)
X-QQ-mid: esmtpgz13t1787831056t8d0f2dbd
X-QQ-Originating-IP: rhEJJYWHeAZWu4nAZpIvADkj+T4QggxPPgn29o2KFuI=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.233.170.62])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 27 Aug 2026 19:44:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3722286803519330766
EX-QQ-RecipientCnt: 3
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 11/13] net/txgbe: add devarg to turn off Tx laser for 40G NIC
Date: Thu, 27 Aug 2026 19:42:03 +0800
Message-ID: <C901FD10DA5C2924+20260827114309.10530-12-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MuPAI0YaUOGVqsPDROfmNh5jmIbqcRGfVwtRSrua8Te1foU943doV17z
 gqdESiHfcbE1TDQt65wJ+gIyIX7AgvDwg4bOPv+v0xIStGGJFWjchOzbO3dYgwWYIt7i+0c
 rZZpocVdoYxZDoo0Q/GWAPnuswifcBZJzgFcy9gMVub49rfGQYSiZcjJkDcTYTry1Yvjqr2
 mmLybzMnuLqXmBimyGqIaRcdIzsGRUIrHmGQEfeEkhhYDiDaS8fL/Cd383PNHw3jPOqr6P4
 4Gg3LR6IgQHLxW4ReGxAUE0hlGznyRoq+KbLkqrdbhsHINyfB4drkR0qcP4uYpj4HN4JKMp
 H4tQtJ96wDsIuW8b/WpfUpsWtB2464oVFej+iUeJ8WUfqm5UYEyxZvsAh7YBgu0mYeQP4rv
 bgkkzruYJHB9aI4/9WbVCOdAmby2qtbobwGOp3nmEZi1eeGPkiKo7gH6XFPKvCqfBhEhV4A
 u4wEDHWznZiNG/zj/TqTrFYdJXYeq667MidztZlI/Tf0nKM3G7ES795jvbGBnFr3qd6wefx
 dAbn/2eh5nRw6lFcGJAgA2p7R+Y7xa8y1yAI6vMNBFHjMVEyVeIElxVjoIzvEkYu4NtJ7+7
 oduNes1ezvmvknT0rZkkSRz1p2MsroCOWqzqkLwm5dX3rSpqM+UHYHj0uDZ4dzHnjRZ7qIF
 wREwnwBsOrP+zUP09WfBDRTThCA3UFclUxg/tAgf4f5mXz+j2UT83Dv7KKdPNHeJqG1Uw/5
 J4IMG9lpbi9XgMERLt1bce3M2I9w2fF1vwoVRFR8a52cHhIuOJ5YBEQCqZvVd8tFBc+jpo/
 w34oqLxUBqyJp9fNQli/cJ5++22Xl9SrimcjOrYi3xA3anU1XySHgrMvOtc14l3JmeBnsrA
 C/yMHdF5WjWgGTXX8hl307TIWuFn6Flb9Rps+RTfAWJEUCmGdy0hx+dqZ8XvFX8GRiCrw+7
 w364LbjFPYmlI3GaNzrV+StfPedoYxSr3tUC4ubfGNRaLRsF3QuOO5kg1lTqmQzuX/zDXFS
 fAwbjm2oUtmyLJZSHgu+gFeH4d0f0lEXCUW5JbPvYyCQDHNJfDw/AjMeHtLtW0eHsLFlvas
 xWWFR+OqDc9HL1aHJhkdc8YZCsNkCl4kfRBjDrR3EdS
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

When the port is brought down, the Tx laser stays on, so the peer
keeps seeing a live signal and cannot detect the link loss (e.g. for
link-state tracking at the peer).

Add a laser_off devarg: when enabled, bring the Tx laser down on
port stop -- for DAC cables disable the PCS, for QSFP modules write
the Tx disable bit via I2C -- and restore the Tx enable state when
the link comes up.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 doc/guides/nics/txgbe.rst           |  7 +++++++
 drivers/net/txgbe/base/txgbe_hw.c   | 22 ++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_type.h |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c    |  7 ++++++-
 4 files changed, 38 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 2650b8b7f1..2b44c30883 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,7 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
 #include "txgbe_aml.h"
 #include "txgbe_aml40.h"
 
@@ -3259,6 +3260,24 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg &= ~TXGBE_GPIOBIT_1;
+		if (hw->devarg.laser_off) {
+			if (txgbe_is_dac_cable(hw) ||
+			    hw->phy.sfp_type == txgbe_sfp_type_unknown) {
+				u32 rdata = 0;
+
+				rte_spinlock_lock(&hw->phy_lock);
+				rdata = rd32_ephy(hw, 0x1400);
+				set_fields_e56(&rdata, 19, 16, 0x0);
+				set_fields_e56(&rdata, 15, 12, 0x0);
+				set_fields_e56(&rdata, 1, 1, 0x0);
+				wr32_ephy(hw, 0x1400, rdata);
+				rte_spinlock_unlock(&hw->phy_lock);
+			} else {
+				txgbe_acquire_swfw_sync(hw, 1);
+				hw->phy.write_i2c_eeprom(hw, 86, 0xf);
+				txgbe_release_swfw_sync(hw, 1);
+			}
+		}
 	} else if (hw->mac.type == txgbe_mac_aml) {
 		esdp_reg |= TXGBE_GPIOBIT_1;
 	} else {
@@ -3288,6 +3307,9 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 	if (hw->mac.type == txgbe_mac_aml40) {
 		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
 		esdp_reg |= TXGBE_GPIOBIT_1;
+		txgbe_acquire_swfw_sync(hw, 1);
+		hw->phy.write_i2c_eeprom(hw, 86, 0x0);
+		txgbe_release_swfw_sync(hw, 1);
 	} else {
 		esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
 	}
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
index 181a1df523..ef30e0c40a 100644
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

