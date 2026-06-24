Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E7CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D422440A6E;
	Wed, 24 Jun 2026 13:53:47 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id C6FE740DDC;
 Wed, 24 Jun 2026 13:53:43 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782302019t8fc4b754
X-QQ-Originating-IP: f6GqwrUI1qyH3xTMIu08H+D3PGGk/H4ZiEQ2nYiGU88=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:53:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8481211772586195635
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 18/21] net/txgbe: fix get EEPROM operation
Date: Wed, 24 Jun 2026 19:52:50 +0800
Message-Id: <20260624115254.20348-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDgMZBR9sMmaW97XemBoG+AxAa+ZzGoUgr/i8YBBA6sZdXIFqMqoLfGQ
 zlmnpU3qXJKuSZeFLszROZbIBd+/lUHcK/OPdCf7rziIOYdVO/D9XLZH6Ihz1BeMKXh6wkk
 lcjD+JqpovcYSxsii2TlwHVG+Bls4xOI2RVoQ5rYPJ5i5azZmP8qxqyuhiGFVigT75XATWN
 J6SzNYgMqu0iGEsrhYXGR9x41/CokOIgr6jbE6O2sC1OXuBNebNhmyaCA7D7VAu6zhpP+LI
 x7JNyZ0PeMHeMv5A3L4IXAyLkMwo4/Sv3edF1bHd5rttfXiIKkhXfFsTZN/3cvFwa+QdE9Y
 ubmzURIGAEtN1ajapNIHWqh7dESQcPodW0/Ch7twH4nHp30dE23Brj4Dg+rTwVd+2ktjXQ0
 YodGRuOz/LRfXInxqhih/Zkh4SxEnK4gwUzMqQCEAbBDDzYS+AHwcOFcpuNkKFqn8cW0bG1
 TvgJRsC/aNhfIdxpN21IXz6+amqQy1x2Ppz4w1H9LuBdnTRULC3SR7Rvpxqt8rs0MAIDU21
 DNkSuSPZ62cy5IxNTyoTGuBXMyitk+IcFWuo7CuvU+gSgRpjB1kSrLPyBKxSuAH0ewt1dws
 deJHXQgtY1bYKOZbxnvqf3MWMgN15N6ufyiJsCjOGCT+ev9Mz1Ab9eadb99vuL1GP9QaT5x
 B54MUQeYkqGpoUiT1R905foqR1QilQgulorvKnzHtH0yEOkZcJlUxudEwPhDUr3s2yOv9bX
 L6RqkdULdxZnTJMJeeIzk9g3oIFj0EHY6HGTcG+azqwrHOGqLQJhfP4v8n4gVYzkRrO6/lb
 cgZRxMi0xnYcp2oQT0nXClbnahVNh3Pldq66MxNmWcfUdsV+bLn3iQ7PjwZ8f2RQSi1KeLh
 asih/MO8uaNM1kkkPwIYzeEnNfnKxupsGixaUObNme8+xvfGOBAGeRCakXl+HgtlhjAgTIg
 N30iYsIPTucooi7yg5L9O/0/Tv+MP7jUkPBsNt6CdAEveNRNElm3kYDPzxoiuFteZQOHg32
 tVEEjgh4Nyd2cKx7rT3tJQ0/mz2/YINa3F87+BBoy3YBj58nix5h8fR/hwpGunJ5nv0SWhb
 DpJKLLJXmperIPTC5YPLkK1sUDg0IjQxA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index f373656342..1dd849f578 100644
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

