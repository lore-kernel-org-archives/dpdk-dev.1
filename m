Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F74ACCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAB80427E1;
	Thu, 16 Oct 2025 13:20:08 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 1BA2A42796
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:20:06 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613602t0d867e4c
X-QQ-Originating-IP: Ft5IvW3Vd2LoSL/DmzdXIak+RJ8+8BlV7nLzbPrQ6XQ=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:20:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15321015183541463163
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v5 18/21] net/txgbe: add thermal sensor configuration for
 Amber-Lite NICs
Date: Thu, 16 Oct 2025 19:17:32 +0800
Message-Id: <20251016111736.25372-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nj7uXftgmBN0VW4W08/aJkl8bYSPEfwErnZ0sNkkS+pLkMk7lT0k/hmh
 w1vetOcTs48MP1MDS2YppKZyR56YRmamQvSoXc0i96c+oyduOktyOIJ+qQ/UeLjrCeUAdVK
 0gT5vhpMdBvZPCN0nyk40mCkDRasFiisKOOq8I1k6co0TnXdJHXItYerpUjpDiNyrWvv5qJ
 e14AK1NawdYc7h4vGwrLN0TFySq/1ZYIWohVvYuPmjMljJKeNzR7wzBh4er5U2w1HXbH2kq
 FKLbI57jDffCGUD/et4vHNwGAtbI1+R2k214i0WPQreJ4eSIYzjMYpIZ+DBCmS+DAX+xSau
 m+Lf8ImOdlXDj+zmN8tNc+UlZ+kp3ZQKe445f1G18jpxPSXBoQllB7OzUqCvSusRcskjy5N
 PTIT8ozfMiebkR+BIrQOXvBUDTNDlAwQNdpHs6FVYNaq57GyLuvAt6CxHPXQ4nr5SUlDWUG
 kErYFeViVEtotSMk98r7h9ugV7PEaEjGvGuRllmZNxWUoWs7ZVZcB1sJpvk8yOvzeFV8sf5
 TIqN0rYRmM+UaT5zvyLuW5LVfg4jOkPaNx/Ap0gO9gsl9+sfIjBLZP9hS2pES55CtbiDm1a
 EeypP+XhNgo2rmiQGfaZ6F66ZHDCDiLgdEX9JxUU2FNdf/xlNbt50MjMPAJQ3yS6XZAYkfq
 gzljGzecZI0Ajmud9esyUwQN9C/5vb9GzMR+QmpeSSuWohzjRU2DTsmRBpxBdGP2Stgzflw
 01Sq74x1bC3vavWfG3zEfH/uHKZrUufV6Lwv2u8deydXOA8Ee7Tbd/tlGhThJ0YEyE6Y4Qw
 hFlVel42ZuKgmQ5BMK0N+uAerZAe3W6azmugZ7zg1SDeycLwB5zfx3U5+GqcOMTpzSgLU/o
 m/YLB1yGt3qNBMqkqB7noQEtsx4O/ERGteiIktKXRc+x0VwdOnI+Rry1CdQ0M8PqCBbW9jS
 PJoLCUL6jfT62RYCWGZs75Uu1cQ8mPHmH7iHPu0tm6hv93iltnkh2Em237v+tdYtERHQj1u
 0LW+TzeWqttnrS4emBu7wX4C79lxtL/DroGACGLXyGKt1h0ZFIJ/jQTOEccbYVSbvX9j3X5
 HxQrnPNxBQI
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add thermal sensor configuration code for Amber-Lite NICs.
Due to differences in hardware design, Amber-Lite NICs require
different configuration from Sapphire NICs to initialize and
retrieve thermal sensor data.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 81 ++++++++++++++++++++++-------
 drivers/net/txgbe/base/txgbe_type.h | 27 ++++++++++
 2 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 3cbb21a686..5017886896 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2220,27 +2220,56 @@ void txgbe_clear_tx_pending(struct txgbe_hw *hw)
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
+
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
 
-	data->sensor[0].temp = (s16)tsv;
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
@@ -2261,16 +2290,32 @@ s32 txgbe_init_thermal_sensor_thresh(struct txgbe_hw *hw)
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
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index c5f51b3ade..07b443c2e0 100644
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
-- 
2.21.0.windows.1

