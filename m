Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56804CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A61FA40E45;
	Wed, 17 Jun 2026 10:15:29 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 6A61840E72;
 Wed, 17 Jun 2026 10:15:24 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1781684121ta4156dba
X-QQ-Originating-IP: m6wJbirhpiVulKUwktT0Szmf1BvGUj8pQRZoaVnQae8=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 16:15:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16115876280409020039
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 18/21] net/txgbe: fix get EEPROM operation
Date: Wed, 17 Jun 2026 16:13:05 +0800
Message-Id: <20260617081309.19124-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M589RIiAniBCweU8wOhrHA+PyFN00wuDlpX6znBMhwu5INva57L1TGzB
 K8kSLMD7jWh4REbfHoUeK9oMewMhzWV/AFSY/gZwH19GYBSITTkzZiUrWHpA7pjvCrZJ5GF
 IUsyv94M4went2CQqIT0u1fYmf1/+jDnZSlIZ/c5gQp7AHuII4f9HMtSIvulvWpxOgSFFWX
 slQdpEoLTdzi0abq8rXdX7Rb50b60udLoP+FJ1rAnwYdtWIflOoivu2VRtNwxcaBgeJINe3
 rhHN07vcpC8AdwLiB/MPuWi6cqH2WW8fYUC8dGqZrLDZwj6U06Z2OQg2YjKJmzOz82Uk9Pk
 KpCa2EsSpG0j6TVf2nCT13SE4o0aAdts6CqmZz/wp+shRX6otxdCz5ThjAWiTqLeXatDb3C
 PinWNLCBDzXU4k8kWgbrQc/YtXutrgCpCtqTMEclkvAtW112xosSv7NcyH+XcLlpl73vsRg
 7W08UXLKxcU5Uhgry47TtWhtVZLKVLEdJxoP7HMBNQ989mEFnF1tDwKNa1BE7HSQrqcudS8
 FjyMCxkKXv0smrIIRiMUfze33fWtneO1+mxFl3v5Jk8Mk9+EmT3aQnGp+Pxp9bFN3caXnz8
 zXKMN7o5AMynHLYCKUfXnnVZ9DCAHBmVSFbG8sgJkJuW/aJ2BQgflMGFdhwfi0eIchqjrG9
 b+DHvg46ax+gtApK4XtNzgD9BqBrrreCMaLZ7bDioE5vK2hMimFUxRjk3kypJ5uFHj7LXhz
 /5G8IHWsr6y8xu4Fnk1eNAWnX9+jfrPHxrpPsQyeCfoCdwVqv6fvk0SHqljbN/WHyo8pvCv
 wI4s7DHLfVB3OACts2d2eF+6ezhrh+biNVe6TGHYTlzh0WJz6mBm7oPpsZiV2jvgtqlAu1x
 C501ryeDAs6ane2DVXlHnzgSRGSoPyN5pAIxfEwzSiFjipEhnSNIZljjLiZ3Tc2OBMYZoEg
 nOGjb9OsqBpqoaw3IbfYUwfrJ88eOyJwemcSq5xunKxlnj+4bH2wjUUNLqGGh5CA85hB9Kj
 9Ko9IoVYvqpPgq2t8aByylVmVwCgu7DWpD16oWr3fHfCsW57GtuhSqAt4+V/jF1FuNRMZuL
 viDEr/+V4bAKZw8u5AXF3Q=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
 drivers/net/txgbe/base/txgbe_phy.h |  1 +
 drivers/net/txgbe/txgbe_ethdev.c   | 81 +++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 31bdceb35b..a5df015a4d 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -245,6 +245,7 @@
 /* EEPROM (dev_addr = 0xA0) */
 #define TXGBE_I2C_EEPROM_DEV_ADDR	0xA0
 #define TXGBE_SFF_IDENTIFIER		0x00
+#define TXGBE_SFF_8636_STATUS_OFFSET	0x02
 #define TXGBE_SFF_IDENTIFIER_SFP	0x03
 #define TXGBE_SFF_VENDOR_OUI_BYTE0	0x25
 #define TXGBE_SFF_VENDOR_OUI_BYTE1	0x26
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index c0471e3d0f..f2c3a35900 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5462,23 +5462,92 @@ txgbe_get_module_eeprom(struct rte_eth_dev *dev,
 	uint8_t databyte = 0xFF;
 	uint8_t *data = info->data;
 	uint32_t i = 0;
+	bool is_sfp = false;
+	uint32_t value;
+	uint8_t identifier = 0;
+	uint16_t offset;
+	uint8_t page = 0;
+	bool is_flat_mem = false;
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
+
+	status = hw->phy.read_i2c_eeprom(hw,
+					     TXGBE_SFF_IDENTIFIER,
+					     &identifier);
+	if (status != 0)
+		goto ERROR_IO;
 
+	if (identifier == TXGBE_SFF_IDENTIFIER_SFP) {
+		is_sfp = true;
+	} else {
+		uint8_t rdata = 0;
+
+		status = hw->phy.read_i2c_sff8636(hw, 0,
+						  TXGBE_SFF_8636_STATUS_OFFSET,
+						  &rdata);
 		if (status != 0)
-			return -EIO;
+			goto ERROR_IO;
 
+		if (rdata & 0x4)
+			is_flat_mem = true;
+	}
+
+	memset(data, 0, info->length);
+
+	for (i = info->offset; i < info->offset + info->length; i++) {
+		databyte = 0;
+
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
+			page = 0;
+			while (offset >= RTE_ETH_MODULE_SFF_8436_LEN) {
+				offset -= RTE_ETH_MODULE_SFF_8436_LEN / 2;
+				page++;
+			}
+			if (page == 0 || !is_flat_mem) {
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

