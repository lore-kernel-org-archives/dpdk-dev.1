Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DCCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E90340677;
	Mon, 22 Jun 2026 13:12:29 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id AF44440A8A;
 Mon, 22 Jun 2026 13:12:24 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126741ta8a59361
X-QQ-Originating-IP: JnmAHxFdRs/81p0tr6b6rsJVFQtT9/P4LJ416uHneR4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:12:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6691825732449445196
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 18/21] net/txgbe: fix get EEPROM operation
Date: Mon, 22 Jun 2026 19:11:06 +0800
Message-Id: <20260622111111.21024-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MIfXsOALvCbbMRv0Es5k/Ue65ofan3mUvFfeBQLAihS0LNFMxSBLpJX9
 IoTADLUyUIs0xVXTI513guSD+EBf3TpbmASlHZzoRCRwP/hK/UP0zoOCgpd9BVzq1Bd+6xP
 jQ1wmr9dWH/2pCNtezEpoNeOHsCc3njIo3ZUaJUK4P+fp/hPlm9YXnRueLR/z9mltpsHWeH
 mVnmmvULilDpNQGBUM1N42drhE0zJiyTU1z4MIAAf9oAK0LFmh5xwmO2g/ydo1zKyYstviI
 mfpsFNipHwlxWslOQc0yoRjAOJJVVFqwWQ5DIK60c2qaIy1SdqbfnNuHfIFdIHoIbqZGCqX
 WWmM5SR37iCHSZngx3bRED9LyfeV/WRpu3yERRBPCHHp7596QmKb+oaqFWA9YcDj77qmnhZ
 bONzvpyuRIvHCWt0SPLaa4hm4ngqMOGaeI3O9IYhDVoCldQFPKQ7XGeNXFUrOKTZmiCBqPo
 1LyoGTCcDdTV6/McYHwpHg35DU0F0FUEpfxE3F/4rgoFvV6q3VyrwKHpdqrE+bwMHq++Q9P
 Y1eO0jvq4eyHau3Qx31KWDbj0RwXANvgbYA8KWdTRaqBVwagyLFgcMFID+oB1H9yTzGwIqn
 xFiPJ/e208ra9y6DBLdzZvZEuBbHTHY4EiYqxZ97C62KJ+5BZAyQ0Kenk6O7uq4CTylp4/s
 KOTMkchBzlC18wPJup6d8+/KnaxoUD9Tb+CywRIcs7R+TnedSu9EXpVw35D8AN/3LbcJo6E
 zId4cT/ZIiCO/id31MSUtiStZQPaJ0qm2rwwYI5TyK7Bi/4xeoQ1ijUpYJlz/oYNolHhpJx
 e9WlsbOZjtjkptRyU5rstTRhWYAhzAKzNs+dtXBhBKG9Lah9Z4bgXkStl2+O19dfYJBolNB
 pr5NUFDNckT2thmKG+DzrM1aVACCJx99oIeZz32GLftBrodZuSM9zxS45VJeZ2Riw01zxBU
 s4jJUMnSv96d6z/ViGqD8F1VDLRGzNPZ8hFb/VVxNpW5mF+r7fPlIcf1RKy4CzBOkaXBY42
 0Qio8fuT/Bc4pQ1PBCiMc0k96X5l2A+tBxTK6xFIP8niIUNDqW4BXN/wbrOC0/B+8PZSwzz
 zVKBN9CZhGZjb/8+hxAZG0CU/2K6kAbcdGPzpKWRRQB
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index c02ba6c517..4691a562d8 100644
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

