Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDFCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:31:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D98340BA2;
	Sat,  9 May 2026 13:29:41 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 0C93A40612;
 Sat,  9 May 2026 13:29:37 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326174t1a7c2bda
X-QQ-Originating-IP: Bxy/Z+iSY92iiA0CeWWI5qOnVG+4iQrSqHiFq83svfg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5039048910354375011
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 18/20] net/txgbe: fix get eeprom operation
Date: Sat,  9 May 2026 19:28:20 +0800
Message-Id: <20260509112823.7728-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZb5vfAg1Xle0XD6n6xswFU25toN3mlTAIOzElAtSAsUaIPqyulChoya
 +07VqgWcYVDU22Ejxj+lpt/P4ii4dOSC6T7tmPBCz2/V67RySVwPBmmu9qU3B3nTVmKt9Pn
 nTD2Tdu7rxYtMqBG6sMFBFRV3LEuIe9TCn/faItVG1UE99nS/FKYIYrcHiO1HNRYH7UAJOn
 QLtoEtxlrHfcVoQW3pK4xZL/jXLJ+vC3+VKXTcfllosvz8UJbDJt7yMj9zcXN8/Hhbyyrcq
 PZxUPqSuP//szPwNrCEwKRE4mo2b0pU9lIhe2LYXj91ZXjRoNcdJVpaoYXJWZpo78/ecddX
 bCzMbD2wqLoiZ0c9d88cV29e8wIrLFE3qL45cCuDDQojqQzNUbYg6Kx8EKzHJnJ7+bCAoTR
 9PmR21xsDYDJOjKATH3POWM2N1sAwlG8pRgWZVwqMhBA2wcJz1uEo49QWldpNHQa3sOiDj1
 hQR4yey4+SiLSmPwfE8hDP/kVmjSVBfg8pQrV9UbJjgC//Jwkcajyqi3MpMGpJR0ZF002/X
 alqNFlu2hc8Tl6EtcZ3WQWjtxf6NALEXaYO3p8xPaZ3kFUJIE+vbU7FU3QAdblXmnub5Y6z
 1DSFILwiap4+hLMzH0yiXRFMMX4vszC/GgXqLOdlzYmZtGArxGHM8bRt9NB/Kl3sGNVrwHz
 Ik1MRU3zs8a9vjbuVf9trfC/Je5unwcxHc8ElA7r0y1I8kbe0F0lZTrHPFZO9x9kw74qUWi
 HeboWro03XIRyeGTMU0fs1+mh4c+Kb3Omj9Mgh4mZJ8ytaUf2FDmg1ce7CcNJbA48946HZP
 OeqKgQm9DB1HCvW4IBS3MosiqJcsC0JuqZSldgsysbIaXVoICno4YgWFZwjFlh7qCF3QrQK
 lvpwZVxeWaoN8WdEmuAHJPS/avwgd+EtNyG7jDoKSnptQsNihC+pEyvSFJxLNEjdpZx+l4R
 7I3yLGnYiy/YKyj95YDO0WIwLyqskg7x5sgw8PrMCUx4yfZK9bmsuut6yKavXRnu1eZFjLu
 Xh7/9DrH5WIaXehzn/vT06TIsk+Q/iUqWqiFYzPlaAAVUF1rkZAFY0b6Harez7Q+NYJREFb
 r2vhdt7tr/LFumygAu55TsK/SUdcYYcyA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

