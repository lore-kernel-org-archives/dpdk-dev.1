Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33C8CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:38:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7940340693;
	Mon, 11 May 2026 12:37:18 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 8DC2D4068A;
 Mon, 11 May 2026 12:37:15 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495832t816928f9
X-QQ-Originating-IP: Q/2vRFE5TY+7DaePtrLgEDtD9CD/X2nEXAB3WQzlvCY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:37:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16811672366521659877
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 18/20] net/txgbe: fix get EEPROM operation
Date: Mon, 11 May 2026 18:36:00 +0800
Message-Id: <20260511103604.19724-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NkMD2Sod8j9m8n6hzvSjUryDvcDyry+3/6wBtQTS3NAhXFK53fRNr5PM
 K1jjx0WasTfKy4B/SqOFNUkjY7zqacCJSAKuXbxt6E8o55oucnjVuf3LRW3+TZXhEG1ePS4
 X0BJkCX3kjmXYPBJWNFAh/e9mrjPHJdGCz8DF4KH+teDknMqieWKeS2wel7dnF+M6sgR1Zc
 FRyMsgEfCAI0QxV2A0tTAGY62PPJN4QccrJObsIYrEAf4f/tznvgRW3cZBSGndTn8t8OBwe
 2AQgMYl1GzHfotTJ83CWMHauTPlo9YzBp46/HAqF2pcpC7KhFk0IsehogiURySf2NtyhlnR
 RiAP/mr61nIMd09sIdEGV0dKlkGz0spSqv+vJWua0CIYTwF3LYwdDY7wFZJ8Obaf9EVc6sp
 JHlnKlkBYKppklm3kuN0ABDJTwj/AsH3CyyZly+ecPsRluW5TFd6UGrNYWReK4rx3uAoY5j
 0BE44fnYebCcltixzb5S7IFhWD/EES+zagXKoEYSZrgrDqgwj4B3KZKHICOYPHRzbf+y5jg
 CAswwre5ABXchErvAdwZtG+zXVuNa176ZZ+4CcqAZJ8wCfyE0SvlUX0mctPULgJL4hMIn85
 ee2/Jyk24A6SggBbI1142MNUUTteSGadJNgGBYomMQzze4Z4XeCWyvg3pjX5RrUSASUYrol
 tAreVDElzamSwR/YgMROPn5+KetMxUmETzgFveQdhbDI5xGZhhZwU8hUBoBWphfh0ndN5Hg
 mfXXjftH9VhzSbhHF2kKDRp80FrclW6F168167Ps4HEZK6nCH2bp0aE+MTCRq8uJppql7sA
 JWIzb8230ZTZi8w6tVtHjgmuPavymVR4eixYdgGptJo8h3p+GhWYPO3siCBxTVCbOmrBWPR
 zLWFuEWNgjslJVCU2BeU2odrxAZBNBVNKwkBG8fS95w7LGGTGLSAMr54/7m0pKo6YoWm5Di
 xkNod+GFdwJfDv2OX9HTEVa4l1Tw0G/hawIRckADoQ/d1kqKtWuinVUm1ILlrvtQ1xrje4r
 3qkM1r3KVXgszYLMLCEIrHKdhcxS6x2lliTPgAxC0Bd8u0LnqI+R0/BNge8IQsXaYFbDPL6
 3iSIOmrIpM32uccdhlaoUXlH6QqSvyM6g==
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
 drivers/net/txgbe/txgbe_ethdev.c | 67 ++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index bc651cfcfb..d6921704e8 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5458,23 +5458,76 @@ txgbe_get_module_eeprom(struct rte_eth_dev *dev,
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

