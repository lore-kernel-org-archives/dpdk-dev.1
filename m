Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D664BFAD3F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:43:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2DBF40DCD;
	Thu, 23 Apr 2026 05:41:43 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 5DA57406BA;
 Thu, 23 Apr 2026 05:41:40 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915697t13d0b340
X-QQ-Originating-IP: pBtuz98syAUog61g1LaunYnAPV/8RtVQDBXwFLsJeSs=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:41:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2084610229385766035
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 18/18] net/txgbe: fix get eeprom operation
Date: Thu, 23 Apr 2026 11:40:23 +0800
Message-Id: <20260423034024.14404-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nkqq4bFvvULWWKXBSGaY6S31xoKPGzaXDkThSODVyTIgs288WYne1gvW
 34N0w3dOmyCxUmINVtCaZ65rD6+0kRQBLaIENY/bY9/W0LDs9/nzKjzg+aYhSPIO4QVeg+r
 8TyILVMOSAaEWL89S3Cu/obDcPJWuxC9F0Z+nbmqwIxd2kGpB1oFkfB0iCYJtjnZq4xY//X
 1ZmDaMgP/xeFBlyWJa9n63EMe9N7fuY/+M6RUfIGqwcY5iKKQlnajib5Qn+Lwkitv2sBT2X
 +SJxR8h2i3o/B8YQWof4o9AjjgpGFI+LxLEzB7ScFAVIpqyfTt/ILocukjg2riTBmoyonlR
 p6s/RoahOtDAn/LMuXGYtpnNCklhADRJZsChk4fISIR69U0fypqdPHtx68PYcM34Y2W0oSY
 dL8YajE500vlYf2B/QOosoVE1FiPpzcuvjc4xm7G+JYyePkkdE68ujy02PsfiVQZrA8K7uY
 WkfDbnb77SCwZlGC4EwTSULsMV5DpxJC03CzgeGedXYxSV4aWo+9EVCiRF0vch4cYdD5tof
 nZaXFGiQN8j7LSNTAHCMcQRgJNlNMKdycmfURq/3XpVUUYeJ9VijaqbpdVNVCfZ5INyPYz8
 +pHBPD7k5LmKWmHH+TgKRbFnUfbiMBqPyAaQ1D/vvYvBZ7m76JrNhoJNNTz8vRv/VSUqfhm
 S5cL64UsGp9nV+vFp70dmf5MXaHIb6PlH01nJfJHuRW0tuBX/uu06AMh/m9vY/RoNYtD8wM
 TOfBlbaOy+aDCbUMe58qboqhJnWc/NPoh1N5FS9DFyxmaDwEogC6Y07jKTL1X/FqCr2wDJ6
 1uezwZBk7fjRW1qxSCHBHiha7wWWw0hKn5W/rmQorzRRhnxz6sEuGqwPuNHcm6lPVsFe/ho
 nfMoYTzAH8jONSdndOYZ8ho9M4sPcNntkmWfw/2vNZb5neDFLNfu+H9a1cia2GC9EAOpeWl
 1O8HjS182iif4c2VK52auIxKLvVzpLz5Ifof4j2f6uE1hMY/Avg4xnkChOQFcpLb4YI0TZa
 zUcgeHBA14lmINJrg5rrhmopK3TUiZ3pgWlSBknm0S9wRM4svYFLEAQHMiKwRViUw/0pHUN
 YKhHe9USE8r
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

Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 67 ++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 41ec432983..17fda66756 100644
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

