Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169EC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 957DF40EDB;
	Wed, 25 Jun 2025 14:52:32 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 35EA040E78
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:52:29 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855945te5b319ce
X-QQ-Originating-IP: ObLlQeV4eZvRCr2bOPtcp/rr3foNBv2MRMCH/I+EUho=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:52:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4639716839629879970
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v2 14/15] net/txgbe: add other hardware-related changes
Date: Wed, 25 Jun 2025 20:50:46 +0800
Message-Id: <20250625125047.18072-15-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M7n9VusxZAlPrlQJ1Fqqmlc+CacnzmOiMbmajMd70okAd4OC41f4VqQA
 CNSywfc/6G/mEZacteowY150O9LSGsI6r9s8zlOJ77aTye83r/rZl9nw35PuUprZwxaFzlp
 H+onYHp65koDQ6HtSqBpaYs8CeoITSyBrGpplCp5XLJKKba6RRie6kXcu0bbbCKoHuYBcd9
 j/6cJNxAv9GDqhhHkheSjYfw6hgFOCfYRceTp4K+BP4Mrfwsy+NauDMOkAO703f4qXH+c3N
 5KttS9sS/6YyOEbJn3ddapo/76VjoLwaLcKixkKi+CP6GqTdM3J/FyjlQU4+TCRaR2jYrma
 R7AdKaIklQmMPZQWEY4cbnogF32luUcbmK9znj7yHtN2DJcYQg1kcBXms+cJyGg0pCapATa
 2BHkB5AcM50Zxn5Orl1Bw895dSlp348fe6uTRLaZSEygS5n6vDCPIbd4ywqn8iOOcSc3fgF
 VmI1aJMT5C4+uS1LQPx72hCOIOiwXQXPosuMzPkKL2vTumkScBCLgbPZsBL6OPxRmMXJYPP
 la+HODkPLEMY2vmXL3xuSAlkD143tsu+5BBrIR6Vf4Xcz+z4fTu8ZfGMbtOzq2n2nPqj0f8
 DiHrftAXU2FIHPrJCaAVvdcWe+nexJ6+R/M8iXLd1jwlnqNnafGAuccPHPibasKMLpWHEpW
 x2mkqLv+quyni0QRQg5EO8nSh3i2VmFVHpDXD44IyRORB8wctXiKd0lTXNzzSf6Eg5i3q1q
 Kt7ke9gOHglJwNH9zQhYvGK2gHLU7h+sLzcFNl8BTZSJu4+c5gCfPctuD7Pioo9IJ3wm+J7
 1KvZ2ouDHDr207OhbvLBvtnGGnrXm2H2nGXOHJ3TJqwn3yrB7wjTuEmtZoeXQNXZVOD+U01
 QRZiILdnK5IkI+OiVdIuXPFKOMgRTgcRCQ7IOikgQCkHCtHTgFQ8VUSTtyq3xeKUqC0ftMi
 q+F3U2dkLlM9f7j8zddSN97iat09t0CzZ8DQFs4DnSH1al+RihPQGFRFotOzpVOV3lf4w2+
 9j+trtmGtDLDHXebr8PdUYl4I/M9I+R8cZhFKefKZCPHuYolLjCjXdsGQOvSvBZQ06LjdV1
 KEpPoZMcOjp
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

Add other hardware-related changes for Amber-Lite NICs, such as PF
queue rate limit, enable/disable tx laser.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c    | 113 +++++++++++++++++++++------
 drivers/net/txgbe/base/txgbe_osdep.h |   2 +
 drivers/net/txgbe/base/txgbe_phy.c   |  35 +++++++++
 drivers/net/txgbe/base/txgbe_regs.h  |  23 ++++++
 drivers/net/txgbe/base/txgbe_type.h  |  27 +++++++
 drivers/net/txgbe/txgbe_ethdev.c     |  72 ++++++++++++++---
 6 files changed, 238 insertions(+), 34 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 6010a4a569..4ffe5a3fcf 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2213,27 +2213,56 @@ void txgbe_clear_tx_pending(struct txgbe_hw *hw)
  *
  *  Returns the thermal sensor data structure
  **/
+#define PHYINIT_TIMEOUT 1000
 s32 txgbe_get_thermal_sensor_data(struct txgbe_hw *hw)
 {
 	struct txgbe_thermal_sensor_data *data = &hw->mac.thermal_sensor_data;
 	s64 tsv;
 	u32 ts_stat;
+	u32 data_code;
+	int temp_data, temp_fraction;
+	int i = 0;
 
 	/* Only support thermal sensors attached to physical port 0 */
 	if (hw->bus.lan_id != 0)
 		return TXGBE_NOT_IMPLEMENTED;
 
-	ts_stat = rd32(hw, TXGBE_TSSTAT);
-	tsv = (s64)TXGBE_TSSTAT_DATA(ts_stat);
-	tsv = tsv > 1200 ? tsv : 1200;
-	tsv = -(48380 << 8) / 1000
-		+ tsv * (31020 << 8) / 100000
-		- tsv * tsv * (18201 << 8) / 100000000
-		+ tsv * tsv * tsv * (81542 << 8) / 1000000000000
-		- tsv * tsv * tsv * tsv * (16743 << 8) / 1000000000000000;
-	tsv >>= 8;
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_AML_TS_ENA, 0x0001);
 
-	data->sensor[0].temp = (s16)tsv;
+		while (1) {
+			data_code = rd32(hw, TXGBE_AML_TS_STS);
+			if ((data_code & TXGBE_AML_TS_STS_VLD) != 0)
+				break;
+			msleep(1);
+			if (i++ > PHYINIT_TIMEOUT) {
+				PMD_DRV_LOG(ERR, "ERROR: Wait 0x1033c Timeout!!!");
+				return -1;
+			}
+		}
+
+		data_code = data_code & 0xFFF;
+		temp_data = 419400 + 2205 * (data_code * 1000 / 4094 - 500);
+
+		/* Change double Temperature to int */
+		tsv = temp_data / 10000;
+		temp_fraction = temp_data - (tsv * 10000);
+		if (temp_fraction >= 5000)
+			tsv += 1;
+		data->sensor[0].temp = (s16)tsv;
+	} else {
+		ts_stat = rd32(hw, TXGBE_TSSTAT);
+		tsv = (s64)TXGBE_TSSTAT_DATA(ts_stat);
+		tsv = tsv > 1200 ? tsv : 1200;
+		tsv = -(48380 << 8) / 1000
+			+ tsv * (31020 << 8) / 100000
+			- tsv * tsv * (18201 << 8) / 100000000
+			+ tsv * tsv * tsv * (81542 << 8) / 1000000000000
+			- tsv * tsv * tsv * tsv * (16743 << 8) / 1000000000000000;
+		tsv >>= 8;
+
+		data->sensor[0].temp = (s16)tsv;
+	}
 
 	return 0;
 }
@@ -2254,16 +2283,32 @@ s32 txgbe_init_thermal_sensor_thresh(struct txgbe_hw *hw)
 	if (hw->bus.lan_id != 0)
 		return TXGBE_NOT_IMPLEMENTED;
 
-	wr32(hw, TXGBE_TSCTRL, TXGBE_TSCTRL_EVALMD);
-	wr32(hw, TXGBE_TSINTR,
-		TXGBE_TSINTR_AEN | TXGBE_TSINTR_DEN);
-	wr32(hw, TXGBE_TSEN, TXGBE_TSEN_ENA);
-
-
 	data->sensor[0].alarm_thresh = 100;
-	wr32(hw, TXGBE_TSATHRE, 677);
 	data->sensor[0].dalarm_thresh = 90;
-	wr32(hw, TXGBE_TSDTHRE, 614);
+
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		wr32(hw, TXGBE_AML_TS_ENA, 0x0);
+		wr32(hw, TXGBE_AML_INTR_RAW_LO, TXGBE_AML_INTR_CL_LO);
+		wr32(hw, TXGBE_AML_INTR_RAW_HI, TXGBE_AML_INTR_CL_HI);
+
+		wr32(hw, TXGBE_AML_INTR_HIGH_EN, TXGBE_AML_INTR_EN_HI);
+		wr32(hw, TXGBE_AML_INTR_LOW_EN, TXGBE_AML_INTR_EN_LO);
+
+		wr32m(hw, TXGBE_AML_TS_CTL1, TXGBE_AML_EVAL_MODE_MASK, 0x10);
+		wr32m(hw, TXGBE_AML_TS_CTL1, TXGBE_AML_ALARM_THRE_MASK, 0x186a0000);
+		wr32m(hw, TXGBE_AML_TS_CTL1, TXGBE_AML_DALARM_THRE_MASK, 0x16f60);
+		wr32(hw, TXGBE_AML_TS_ENA, 0x1);
+	} else {
+		wr32(hw, TXGBE_TSCTRL, TXGBE_TSCTRL_EVALMD);
+		wr32(hw, TXGBE_TSINTR,
+			 TXGBE_TSINTR_AEN | TXGBE_TSINTR_DEN);
+		wr32(hw, TXGBE_TSEN, TXGBE_TSEN_ENA);
+
+		data->sensor[0].alarm_thresh = 100;
+		wr32(hw, TXGBE_TSATHRE, 677);
+		data->sensor[0].dalarm_thresh = 90;
+		wr32(hw, TXGBE_TSDTHRE, 614);
+	}
 
 	return 0;
 }
@@ -3172,12 +3217,28 @@ void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 {
 	u32 esdp_reg = rd32(hw, TXGBE_GPIODATA);
 
-	if (txgbe_close_notify(hw))
-		txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_LEDCTL_10G |
-				TXGBE_LEDCTL_1G | TXGBE_LEDCTL_ACTIVE);
+	if (txgbe_close_notify(hw)) {
+		/* over write led when ifconfig down */
+		if (hw->mac.type == txgbe_mac_aml40) {
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_AMLITE_LED_LINK_40G |
+					TXGBE_AMLITE_LED_LINK_ACTIVE);
+		} else if  (hw->mac.type == txgbe_mac_aml)
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_AMLITE_LED_LINK_25G |
+					TXGBE_AMLITE_LED_LINK_10G | TXGBE_AMLITE_LED_LINK_ACTIVE);
+		else
+			txgbe_led_off(hw, TXGBE_LEDCTL_UP | TXGBE_LEDCTL_10G |
+					TXGBE_LEDCTL_1G | TXGBE_LEDCTL_ACTIVE);
+	}
 
 	/* Disable Tx laser; allow 100us to go dark per spec */
-	esdp_reg |= (TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	if (hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		esdp_reg &= ~TXGBE_GPIOBIT_1;
+	} else if (hw->mac.type == txgbe_mac_aml) {
+		esdp_reg |= TXGBE_GPIOBIT_1;
+	} else {
+		esdp_reg |= (TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	}
 	wr32(hw, TXGBE_GPIODATA, esdp_reg);
 	txgbe_flush(hw);
 	usec_delay(100);
@@ -3199,7 +3260,13 @@ void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw)
 		wr32(hw, TXGBE_LEDCTL, 0);
 
 	/* Enable Tx laser; allow 100ms to light up */
-	esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+
+	if (hw->mac.type == txgbe_mac_aml40) {
+		wr32m(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_1, TXGBE_GPIOBIT_1);
+		esdp_reg |= TXGBE_GPIOBIT_1;
+	} else {
+		esdp_reg &= ~(TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1);
+	}
 	wr32(hw, TXGBE_GPIODATA, esdp_reg);
 	txgbe_flush(hw);
 	msec_delay(100);
diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index a1477653e2..05071aca22 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -162,6 +162,8 @@ static inline u64 REVERT_BIT_MASK64(u64 mask)
 	       ((mask & 0xFFFFFFFF00000000) >> 32);
 }
 
+#define BIT(nr)         (1UL << (nr))
+
 #define IOMEM
 
 #define prefetch(x) rte_prefetch0(x)
diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 81e9aee295..bf7260a295 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -173,6 +173,41 @@ s32 txgbe_get_phy_id(struct txgbe_hw *hw)
 	u32 err;
 	u16 phy_id_high = 0;
 	u16 phy_id_low = 0;
+	u32 i = 0;
+	u32 status;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		hw->phy.addr = 0;
+
+		for (i = 0; i < 32; i++) {
+			hw->phy.addr = i;
+			status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_HIGH, 0, &phy_id_high);
+			if (status) {
+				DEBUGOUT("txgbe_read_phy_reg_mdi failed 1");
+				return status;
+			}
+			DEBUGOUT("%d: phy_id_high 0x%x", i, phy_id_high);
+			if ((phy_id_high & 0xFFFF) == 0x0141)
+				break;
+		}
+
+		if (i == 32) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed");
+			return TXGBE_ERR_PHY;
+		}
+
+		status = txgbe_read_phy_reg_mdi(hw, TXGBE_MD_PHY_ID_LOW, 0, &phy_id_low);
+		if (status) {
+			DEBUGOUT("txgbe_read_phy_reg_mdi failed 2");
+			return status;
+		}
+		hw->phy.id = (u32)(phy_id_high & 0xFFFF) << 6;
+		hw->phy.id |= (u32)((phy_id_low & 0xFC00) >> 10);
+
+		DEBUGOUT("phy_id 0x%x", hw->phy.id);
+
+		return status;
+	}
 
 	err = hw->phy.read_reg(hw, TXGBE_MD_PHY_ID_HIGH,
 				      TXGBE_MD_DEV_PMA_PMD,
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 98d1070daa..f32f17428b 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -302,6 +302,17 @@
 #define   TXGBE_PORT_LINK1000M          MS(2, 0x1)
 #define   TXGBE_PORT_LINK100M           MS(3, 0x1)
 #define   TXGBE_PORT_LANID(r)           RS(r, 8, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_BSY_SEL  MS(5, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_10G_SEL  MS(4, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_25G_SEL  MS(3, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_40G_SEL  MS(2, 0x1)
+#define   TXGBE_AMLITE_CFG_LED_CTL_LINK_50G_SEL  MS(1, 0x1)
+#define   TXGBE_AMLITE_LED_LINK_ACTIVE    TXGBE_AMLITE_CFG_LED_CTL_LINK_BSY_SEL
+#define   TXGBE_AMLITE_LED_LINK_10G       TXGBE_AMLITE_CFG_LED_CTL_LINK_10G_SEL
+#define   TXGBE_AMLITE_LED_LINK_25G       TXGBE_AMLITE_CFG_LED_CTL_LINK_25G_SEL
+#define   TXGBE_AMLITE_LED_LINK_40G       TXGBE_AMLITE_CFG_LED_CTL_LINK_40G_SEL
+#define   TXGBE_AMLITE_LED_LINK_50G       TXGBE_AMLITE_CFG_LED_CTL_LINK_50G_SEL
+
 #define TXGBE_EXTAG                     0x014408
 #define   TXGBE_EXTAG_ETAG_MASK         MS(0, 0xFFFF)
 #define   TXGBE_EXTAG_ETAG(v)           LS(v, 0, 0xFFFF)
@@ -1641,6 +1652,18 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_ARBTXRATE_MIN(v)        LS(v, 0, 0x3FFF)
 #define   TXGBE_ARBTXRATE_MAX(v)        LS(v, 16, 0x3FFF)
 
+#define TXGBE_TDM_RL_QUEUE_IDX          0x018210
+#define TXGBE_TDM_RL_QUEUE_CFG          0x018214
+#define   TXGBE_TDM_FACTOR_INT_MASK     MS(16, 0xFFFF)
+#define   TXGBE_TDM_FACTOR_FRA_MASK     MS(0, 0xFFFC)
+#define   TXGBE_TDM_FACTOR_INT_SHIFT    16
+#define   TXGBE_TDM_FACTOR_FRA_SHIFT    2
+
+#define TXGBE_TDM_RL_VM_IDX             0x018218
+#define TXGBE_TDM_RL_VM_CFG             0x01821C
+#define TXGBE_TDM_RL_CFG                0x018400
+#define TXGBE_TDM_RL_EN                 MS(0, 0x1)
+
 /* qos */
 #define TXGBE_ARBTXCTL                  0x018200
 #define   TXGBE_ARBTXCTL_RRM            MS(1, 0x1)
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 3833f1420a..aad8a15129 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -37,6 +37,33 @@
 #include "txgbe_osdep.h"
 #include "txgbe_devids.h"
 
+/* Sensors for AMLITE PVT(Process Voltage Temperature) */
+#define TXGBE_AML_INTR_RAW_HI           0x10300
+#define TXGBE_AML_INTR_RAW_ME           0x10304
+#define TXGBE_AML_INTR_RAW_LO           0x10308
+#define TXGBE_AML_TS_CTL1               0x10330
+#define TXGBE_AML_TS_CTL2               0x10334
+#define TXGBE_AML_TS_ENA                0x10338
+#define TXGBE_AML_TS_STS                0x1033C
+#define TXGBE_AML_INTR_HIGH_EN          0x10318
+#define TXGBE_AML_INTR_MED_EN           0x1031C
+#define TXGBE_AML_INTR_LOW_EN           0x10320
+#define TXGBE_AML_INTR_HIGH_STS         0x1030C
+#define TXGBE_AML_INTR_MED_STS          0x10310
+#define TXGBE_AML_INTR_LOW_STS          0x10314
+
+#define TXGBE_AML_TS_STS_VLD            0x00001000U
+#define TXGBE_AML_INTR_EN_HI            0x00000002U
+#define TXGBE_AML_INTR_EN_ME            0x00000001U
+#define TXGBE_AML_INTR_EN_LO            0x00000001U
+#define TXGBE_AML_INTR_CL_HI            0x00000002U
+#define TXGBE_AML_INTR_CL_ME            0x00000001U
+#define TXGBE_AML_INTR_CL_LO            0x00000001U
+#define TXGBE_AML_EVAL_MODE_MASK        0x00000010U
+#define TXGBE_AML_CAL_MODE_MASK         0x00000008U
+#define TXGBE_AML_ALARM_THRE_MASK       0x1FFE0000U
+#define TXGBE_AML_DALARM_THRE_MASK      0x0001FFE0U
+
 struct txgbe_thermal_diode_data {
 	s16 temp;
 	s16 alarm_thresh;
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9fd4923b6d..9032f52951 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -4243,33 +4243,80 @@ txgbe_configure_msix(struct rte_eth_dev *dev)
 			| TXGBE_ITR_WRDSA);
 }
 
+static u16 txgbe_frac_to_bi(u16 frac, u16 denom, int max_bits)
+{
+	u16 value = 0;
+
+	while (frac > 0 && max_bits > 0) {
+		max_bits -= 1;
+		frac *= 2;
+		if (frac >= denom) {
+			value |= BIT(max_bits);
+			frac -= denom;
+		}
+	}
+
+	return value;
+}
+
 int
 txgbe_set_queue_rate_limit(struct rte_eth_dev *dev,
 			   uint16_t queue_idx, uint32_t tx_rate)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t bcnrc_val;
+	int factor_int, factor_fra;
+	uint32_t link_speed;
 
 	if (queue_idx >= hw->mac.max_tx_queues)
 		return -EINVAL;
 
-	if (tx_rate != 0) {
-		bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
-		bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
-	} else {
-		bcnrc_val = 0;
-	}
-
 	/*
 	 * Set global transmit compensation time to the MMW_SIZE in ARBTXMMW
 	 * register. MMW_SIZE=0x014 if 9728-byte jumbo is supported.
 	 */
 	wr32(hw, TXGBE_ARBTXMMW, 0x14);
 
-	/* Set ARBTXRATE of queue X */
-	wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
-	wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
-	txgbe_flush(hw);
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		if (tx_rate) {
+			u16 frac;
+
+			link_speed = dev->data->dev_link.link_speed;
+			tx_rate  = tx_rate * 105 / 100;
+			/* Calculate the rate factor values to set */
+			factor_int = link_speed / tx_rate;
+			frac = (link_speed % tx_rate) * 10000 / tx_rate;
+			factor_fra = txgbe_frac_to_bi(frac, 10000, 14);
+			if (tx_rate > link_speed) {
+				factor_int = 1;
+				factor_fra = 0;
+			}
+
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_INT_MASK, factor_int << TXGBE_TDM_FACTOR_INT_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_FACTOR_FRA_MASK, factor_fra << TXGBE_TDM_FACTOR_FRA_SHIFT);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, TXGBE_TDM_RL_EN);
+		} else {
+			wr32(hw, TXGBE_TDM_RL_QUEUE_IDX, queue_idx);
+			wr32m(hw, TXGBE_TDM_RL_QUEUE_CFG,
+			      TXGBE_TDM_RL_EN, 0);
+		}
+	} else {
+		if (tx_rate != 0) {
+			bcnrc_val = TXGBE_ARBTXRATE_MAX(tx_rate);
+			bcnrc_val |= TXGBE_ARBTXRATE_MIN(tx_rate / 2);
+		} else {
+			bcnrc_val = 0;
+		}
+
+		/* Set ARBTXRATE of queue X */
+		wr32(hw, TXGBE_ARBPOOLIDX, queue_idx);
+		wr32(hw, TXGBE_ARBTXRATE, bcnrc_val);
+		txgbe_flush(hw);
+	}
 
 	return 0;
 }
@@ -5121,7 +5168,10 @@ txgbe_rss_update_sp(enum txgbe_mac_type mac_type)
 {
 	switch (mac_type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 	case txgbe_mac_raptor_vf:
+	case txgbe_mac_aml_vf:
 		return 1;
 	default:
 		return 0;
-- 
2.21.0.windows.1

