Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B12CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A9140DD7;
	Wed, 27 May 2026 15:04:08 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id C83584065C;
 Wed, 27 May 2026 15:04:05 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887043t76aaca5b
X-QQ-Originating-IP: 4LNZwLY9oQ3bhBtKr+7XFIgghSrO+dShJ7zFKuoPWV0=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:04:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9177579325803966042
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 18/21] net/txgbe: fix get EEPROM operation
Date: Wed, 27 May 2026 21:02:18 +0800
Message-Id: <20260527130222.24348-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mford2LpU4AocKqRda7KZ+mpaTDUEMhLLZjEEDX5mfpnlMHCEA+QBy3S
 8w1UmOTrZqqepMpIdDDcWk98waTaZqV6rXunlWUy/Jh291vhlZfF1txi5PaTss5i0wygLz9
 6cCcQUJABrmwafXM8KTahqALYVTnjSrcwutWHxCDfXpl3W/OHnsM1z/OP02FYncuYmiJltQ
 V9w9y9ZaUYlt2DxkePM4k6BwhnMrpV2TfwwuB3VOz3tMOAPjKqkpFkJyZ3HWRgPJkk7EHpc
 6j3bq8x/BdBwiz1UZ7KtzxedMhwT7PxYnbejXmFRQebII+K9YQyUu1JaCDbMSSfaGitBeqS
 kkopDFCiiNWJT7NltgukmiTIFcdF6GVh+aAdb+wTfZGKI8soGu5wkoD/uD9tRYeXcSXnHsO
 8me7jU4xyBhuQjLz5BdWm9ykJOV3zq8U3gNbH93aoeyzYhE7K//PpevmF85/WEF7OIqi+Bg
 VwJbpJVwDD66tQcmaptc3Nw5LbGoPflJ+9DTQYH1dHwvxT13K2d2J+H5CbMIWborwfv27yy
 g81boKGtkLD+3wBdS1Qj9iLU0BdUb0clwp+1wA1sTIFWIn3kKU8uMz/WvY32hToTLhG+eGF
 zJO2o1kZR0ibghcejaMo1G6jxZNCibDMhv6MjEyAygNFKqdb1m46cZg8VBFsNrBt4JLC3FF
 yvJJ5MqhLvtS54msPUfmKZ4CaG/xoAWZojuezG8rshcbPFZxKIol9ufaUFw+5b6WYchoQPL
 jRjyJWqfREvtUG2fAty+OcPNof4URau57ajyfF3hBXTSbzv56203rr2ClcBO8h74GgpUXKm
 w+6I9r0Kj72x7c0NpIWzUV/FYFlvNdMy6K6UBPwRn0nCMnjCk+Q1jUBX5vOrc/H6dBrL+wk
 PqRpd+xtQBs4Cc9BJmG3M8VPNOB+LAOKBS3mnIKonoPJnBS9VQ9WRs21WAW9xVXcAxe8zWw
 +6oyFNoNChalE52EZgclaENPvx7a8QBlz4vThRNlC9WUJcd+dzHNvcIQYAPfOWvMNJkxs97
 J6JoMwnsmYi3JCwKMojKlZ8H9h3QkTEiA8+egLEVdWzoudYd9+dzRSghfNbb/sCH/NQC/1w
 hlsYU1xBAzm
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
index 84c0a856e5..96532a015e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5462,23 +5462,76 @@ txgbe_get_module_eeprom(struct rte_eth_dev *dev,
 	uint8_t databyte = 0xFF;
 	uint8_t *data = info->data;
 	uint32_t i = 0;
+	bool is_sfp = false;
+	uint32_t value;
+	uint8_t identifier = 0;
+	uint16_t offset;
+	uint8_t page = 0;
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
+
+	if (identifier == TXGBE_SFF_IDENTIFIER_SFP)
+		is_sfp = true;
 
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

