Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C81FF8877
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 441E040DCB;
	Wed, 29 Apr 2026 12:27:06 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 82C2840695;
 Wed, 29 Apr 2026 12:26:58 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458414te9434741
X-QQ-Originating-IP: SrZk1O8SOyLbAbXnLtyCgnQKmR5jRQQ676wV1omT2vg=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8492410843685341549
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 18/20] net/txgbe: fix get eeprom operation
Date: Wed, 29 Apr 2026 18:25:12 +0800
Message-Id: <20260429102515.58880-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NhUkPfKlCtQw4S7SbsAEYtBiDi3TRrmWKpke0DU/ul6scfMTHibbtxIP
 XNOMUVdYpADm/yaBna+bk2je/Kng7TWx9pOGm6gMcwA01DtcCCEVvbl/rstlAWfjkgn0T0i
 BlK+dOQuTp6tFbtHnn/dAm84ynHFg62Ce9jWfoJPTGGQ0isTD3DPtU3t/IV+WAGWyOLZ0f5
 oFQc1TUK5r2oVXE/1tiPfQjW8jEnVBPgtVc8XsKF8yu8k9JSe7lTQfFnuYCFq8eIsx0nmEs
 7u+9SENHz7PyPXZ8PusF/5NTfDV+rkLTWT1ruUqM6ZzaxW6+g1IjlNrPdG4Sy1dbfrmiL5m
 U1TyrwBZ0vS8grutR/J4Ct5EhehKl3mFZs6wOzmSdLrR7y3u2mEBg0476XTynL4vU/vC4ui
 YHJFEkbJeK1DF5zd/NHvnYxURfFuWc6Q4Qe5DfrI1Lk7nKEzMLn9VnZ5vLlWYcAJ/0Hf8tf
 61nG13K6Q100mPNHoC/qA521Snx5rYhcJYhX7sBVaIl7zOctZ7Zn0I+SUiY3jYZWzi4t7qN
 mtsXuaKbyeAU0BaWtZiJmqJabJM48WX0g4U2Z7Tz/E5BmTqylCrbb/K2ECJoaBcfk+4NCra
 0azrGgBswOjVxfhCinq8wGm3bQcEQ5ew1WU4QaXblJE17N4RxDjlx/dca2FK2GcFEMwXUkZ
 +XfAb1TQmSRGC9K3dI89NVDeYowZDwvOo2MKENK24OIdtQKcmKwDRxqmX7zIRSOJ5Wwfxm8
 LgLQN5386WuQTvUZUmhp14k6HQdzGGIxfjXxO7PsAaStqrSPeWwAG5yzx2vHloGewiYxTIL
 xuBcXQwTt6kwdROuKKdoJrzUtjowt9dqUUPmp96GVl5it+8S6pRNj1YiMYcQ8dPLrXx0qqf
 Tcy5kOoKJROKIuJRh8E+wsUqniXa1PNQPfAzl34k1C2tIBivHqTWwrHOWKtk3NWBjBkWvCn
 W4Ntem7I3zflxD1iD1xSoMtazsb72FFbQOz/BLya9zAe2cyuacfcj8vTE02vWvK4suzpbkw
 ym0KHjJrzsr9ts2GpTg2s7+L5b0IBWxn0+kPnvUVJN1V3FmFllEHxOl0/owlpFQuDGUgzbE
 JyXLr0+lAS1b+0SYRzOgtY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

The original I2C access flow in the module information retrieval
process was flawed. Correct the implementation to properly fetch
module info.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 67 ++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4e9da14697..9c9606cc92 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5452,23 +5452,76 @@ txgbe_get_module_eeprom(struct rte_eth_dev *dev,
 	uint8_t databyte = 0xFF;
 	uint8_t *data = info->data;
 	uint32_t i = 0;
+	bool is_sfp = false;
+	u32 value;
+	u8 identifier = 0;
+	u16 offset;
+	u8 page = 0;
+
+	if (hw->mac.type == txgbe_mac_aml40) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_PRST_LS)
+			return -EIO;
+	}
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_ABS_LS)
+			return -EIO;
+	}
 
 	if (info->length == 0)
 		return -EINVAL;
 
-	for (i = info->offset; i < info->offset + info->length; i++) {
-		if (i < RTE_ETH_MODULE_SFF_8079_LEN)
-			status = hw->phy.read_i2c_eeprom(hw, i, &databyte);
-		else
-			status = hw->phy.read_i2c_sff8472(hw, i, &databyte);
+	status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	if (status)
+		return -EBUSY;
 
-		if (status != 0)
-			return -EIO;
+	status = hw->phy.read_i2c_eeprom(hw,
+					     TXGBE_SFF_IDENTIFIER,
+					     &identifier);
+	if (status != 0)
+		goto ERROR_IO;
 
+	if (identifier == TXGBE_SFF_IDENTIFIER_SFP)
+		is_sfp = true;
+
+	memset(data, 0, info->length);
+
+	for (i = info->offset; i < info->offset + info->length; i++) {
+		if (is_sfp) {
+			if (i < RTE_ETH_MODULE_SFF_8079_LEN)
+				status = hw->phy.read_i2c_eeprom(hw, i,
+					       &databyte);
+			else
+				status = hw->phy.read_i2c_sff8472(hw, i,
+					       &databyte);
+
+			if (status != 0)
+				goto ERROR_IO;
+		} else {
+			offset = i;
+			while (offset >= RTE_ETH_MODULE_SFF_8436_LEN) {
+				offset -= RTE_ETH_MODULE_SFF_8436_LEN / 2;
+				page++;
+			}
+			if (page == 0 || !(data[0x2] & 0x4)) {
+				status = hw->phy.read_i2c_sff8636(hw, page, offset,
+					       &databyte);
+				if (status != 0)
+					goto ERROR_IO;
+			}
+		}
 		data[i - info->offset] = databyte;
 	}
 
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	return 0;
+
+ERROR_IO:
+	PMD_DRV_LOG(ERR, "I2C IO ERROR.");
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	return -EIO;
 }
 
 bool
-- 
2.21.0.windows.1

