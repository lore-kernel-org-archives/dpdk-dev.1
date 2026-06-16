Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A5CD98E7
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3996D41109;
	Tue, 16 Jun 2026 14:21:52 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 00BA0410D4;
 Tue, 16 Jun 2026 14:21:47 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612503t92580be4
X-QQ-Originating-IP: f+H0D/U2bOAxh1Hx4OF2dZZRpJmhFu4iSjuKJh2CdIM=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:21:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 567388228054629866
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 18/21] net/txgbe: fix get EEPROM operation
Date: Tue, 16 Jun 2026 20:20:26 +0800
Message-Id: <20260616122030.9688-19-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NT9b64/RmY6NabkMzr8O9c9iYI6bp7lOpQKWQTRcJtbIQSfc9TuyuXr4
 s2jxxg5CicgFzVCS1jCoqvKVB5aSuJK8mCr8JnC/qoYCE8x4Nu9g6d6NIvWJfjzseA8raTR
 abZfiswDd9w8000Ng3ZkIq+5JSm2YfcGXh16EZ4q44DPzwI0J06l4xSQjSmo75ioui4H459
 8xEeNvAuFp2RJGSdHxXbcWiOWO32VMHfOB2NELyrbspKZWL0MVuKG3hrmr/RPwD01oz2cHz
 iwMYnjy6uXg2e/OBdabv6ahdf6vmrD7G1Q+Ep0NLUfHfi+m7bC7Y5pypBvd9XjvKrfHyXx+
 fBfTfjIBwkRCR9k1T+JsxMnn1oAjhPkhvz1DG1ZN2l2nPe8homyAzT1lEBLyPVaUDdssX/r
 Ra3q6tn2r+PNMzgAdY8/e3b/zZinUsHrlr2cA5QB1EE7KmWdc5ca8hi/9cF2WKSHrDnQwWD
 T3pAQ7fRFtk+bVQVO1Cfqz4OLaBYPu8dlB7jdq/l4jHMx9Dw/ZePftPJ26CCi7YEhaQ3e8M
 JBMnnl6SLfGI3REo/IO7obTdYqbYWERNiQueQWCpNoP7nol59lyfW/6gv5BeiuXzUz+JEMy
 lScmra26LiTKlHGtFwORItwc8fbODmdPT5MiQ2CnssIwjhuKcI01xEvv5C+kzU27/DlNEa7
 EOyUm0sl/vNoo73TpxpZhnq9CGbTLQGJqICoD4JOi6Wr/FnCmA1jOkCsWrVg1mLxLteKRLc
 gvtncZOYnl/by9p+vn+EsqUjtXmzlbD4BsXG0UoNTQyOVAQys1iLaqxsLe98OMtIF/B5av4
 H4cl0IXAkfVykHIxAOpR0mHr1dLzinXUNvl//Gs9WEMZbemeZ5ZL9AyTLa4Y87k3KRzrbfi
 2TZFUgPwZW1ntIg+gxcbjC1WRrW3YcIZqoGaRY+i+bJe/HTi5r6wfNOO7kZ4sQi3211gVzL
 XJ06o/+Hm/17xWOiZ8aaCKsqFh/qNKLV30nooUqnY8O/HR3EgQkYBWtG8vwvTajdmPf2q1r
 iWhwuwWo3eXj257l1DUFzWBo3BeLix/V09X0TFF4+rnAR1D3Yp7riyTmREStuMupobtQqTx
 /cxdUX5+Zf3GlaLahepHhA=
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
index c34635c50a..57803fe841 100644
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
+	bool is_flat_mem = true;
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
+			is_flat_mem = false;
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
+			if (page == 0 || is_flat_mem) {
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

