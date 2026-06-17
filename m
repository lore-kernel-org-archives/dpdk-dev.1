Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002EECD98E1
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 03:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90DF740E3B;
	Wed, 17 Jun 2026 05:35:11 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 6F4DA40EE3;
 Wed, 17 Jun 2026 05:35:08 +0200 (CEST)
X-QQ-mid: esmtpsz11t1781667305te648b784
X-QQ-Originating-IP: SlSRd+6nh9uCXemUXl28FJttUP4obsUeJ0oVj79EZc0=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 17 Jun 2026 11:35:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3990607742776206575
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 18/21] net/txgbe: fix get EEPROM operation
Date: Wed, 17 Jun 2026 11:33:56 +0800
Message-Id: <20260617033400.376-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260617033400.376-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617033400.376-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MhK4DKsBP06imHFGmHYewb8UUsrHVb3O1XtqspGr3If89T4kYSOQFH5N
 Cw80NzNWPvG2pV+92Jcg9xNWacZUPDF6QyhFHc3MZZXtJvxznWguwGQNwIu2QThyBQOEIrc
 NsqsOXrgq++/DvfldSPHlEJe/KkXHRhpoNYynN4D9hpkmF0gWANBNMm3oaPKKaQfrK9Qedc
 hL56jCbsO+v7k0Ai17PkZgwKMXmxSXlzVI7B1EwaIHs8vnPcU0YTn2cM4p7+Bjx6XbGK8Qy
 PN/CTplR4UnMYZA3H6Iie7xUynQw9TmX4WCysyAq3AesTU1Xvyk74DdUi6XKAEWFwF50zbC
 tfNzoAyH0hLGPJTXoHGkGBeWOFik2zbh2Z2pEjZHLCo+ArtSDIsxfpYm6R0hofAuoFXcoSL
 oogjSQHKBNXq9Cxb8Z6cK+RAdkR4UVWB2UrGmvoTVDbXOM8a/MqA1MlDHxLvM9xbajYZ4nV
 454UN4HN9ZrxAt+SMgo2Kn7NEE4oxEdK4QTkV8UyLnE1rFlIpeUeFSn5nGVmuZ3F012YGJX
 NlJ6b/lRfD5DEM0CSDh8tDSZl4DjMEob51+xXVu0PIVjbhRfs7zC/He3/9VfO2IHlij2Gy/
 gNPMHV5R2On9r2Ve1zuCvmkQOSlTFmiJT1SZkr+Ec8cN8DbvOSstNt7lYq3Rh/UdCoXn0zN
 RBLYrR9p+TxNWV6AE6oU3DGYF7elDWRKLgu3cMGMBmfG7S8UuxkLvBkR7mYhrWxeoRTU+TZ
 My5IGwmujjiYljhII7bhfAudNzEkVMze2mocbV90SR3LAeX4B4ruQnnD6UpfMltjmdQw9kS
 8VHTQsOPoOEsgg3B9FQsYbyUM22N/jzbq/CtkffCyd0WPJg1W/e1H4ju1OI0d2WhKnR3sMy
 H3TKfwa1RDxW8EPyp19+OHHvf10msySPYVp7CaQvg90CdxjMHAWYeC02q7/mfWWtDE8Qagq
 F0q23pzZdT0jhg/wWmjE+2vF/5iG+wN2k+ownXtZCR4OIXOi8GU46yd2pCBJHo+3zTofvNO
 O2BqCOiIOa6WMuVLVRa2yMKXI2OI3ZyCzBCL5K5aWIzh4sYSToo00/5KwkokCSrSnb/Dyxe
 /nlSs1gAZKreSnC2uouqdU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
index c34635c50a..7d431d85f5 100644
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

