Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD925CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 818BC40BA6;
	Tue, 30 Sep 2025 12:01:08 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 172A740E49
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:01:05 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226461tc6e16d2f
X-QQ-Originating-IP: a92wwSbOnQMsXIhVE4thtFmNwaNZVPbbaoc9afWepxo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:01:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6243097873924131335
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 18/20] net/txgbe: add thermal sensor configuration for
 Amber-Lite NICs
Date: Tue, 30 Sep 2025 17:59:50 +0800
Message-Id: <20250930095953.18508-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OYMEOeTae7ml8FT4JGggEyTAwP78x0YL96ArpK3Q2RkkurCfsBxngI/u
 d4z1ECcq+mTDUBSZ6zaMBh0gdsCqCInRWDfg/V51ng2jAaGHeR6l0yr23Utaf4iBZdAbGsD
 vOpZUYjB5xJkl/6J1lLEVf7wUxtibp1GgknZpKlYCcoEPSHdkWkz4ffNwh3qtgXa4dfkafa
 crJjhgM9CQ3KCJZtFo7LEkUKyhwaD2rn+ZIEr3DZkIJcUHRxbFeLZk2kUjhkUUJcm5B+Fcf
 OD+s5CDyRQvUYYNrmocvWCL+x5gWCf1iKOXxZR6fKkr6AEQAvJZoxKJwyM29SjLxytCl9NB
 EqUlvEN4Iq0EvOB4N/LFGnpLm0rJt5CGp/0m/dv5eHT8sJzmpn+8sKCAdTDJPnCCk4GnrxC
 VxK2lSTu8mCk0sdAEqCLUG81r2L8teRSN5WKAi6Hc4/Krzotl1riJYsy0LKwa4wGMtv1a7q
 5rHfiH2mKsnbmL9R1LwzTf6mEy8LoceSm07p8TKz7u8gg2DugOuitw4yRMKFqifEhN2MtVo
 bjK5bH+OjwKYetLR7cZEQrdgPVH5Imclo4Smw7x5QFp99UNjqMD/EUsILEUQuOHnn4q7zuU
 oQY7SgER8vVoV7ZlwG0cUBxCAJysjVVqU7Z7utAewMuTFEZHe1AcvwV/nrN+n/HjPp4clsI
 HATjV/gjDypaRXiGX5IwJYM1TjtK5iQIuJGXTzktLtJmdapvMQUZvhvbcgbhnROoBLGG21z
 Pvv1c/9B9dJvMwRE/VhrgLShpP4Cu1oh85n3mSF5k+Jgq28egBFVwqX/0IfDwqHsVhOkYKb
 7edjCqT0xRuU6AOT0IZ/M8LFy4sKM/LFbEc3/PU4nJaE+QcJCs2R1ekkFMpCz8P4AO1+svQ
 r5ZrtI9OGqumRbms5j6joRaBz2M4/6HU9u1Jm3mhhvNVQ6Lb293QmYHkfPbd+Bllpp/eavV
 ZsDgcT37BhoQTbg0sv2J0Lju85lHDCKVlEXR30xhlYDge8PMdb4oGC44oWhLHD8qf+2RXMU
 Oa3lW0X3U4i+V1CN3vrKfBoVKPSHG9KRE18NWiTA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

