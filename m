Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089BCD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E12D740BA4;
	Mon, 11 May 2026 12:37:19 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 11F18402DB;
 Mon, 11 May 2026 12:37:16 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495830t50192b50
X-QQ-Originating-IP: lE1V+6LMTb0ez43NDP+UliK89Ivpeo6ekiSZIDecL88=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:37:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2487655536960330664
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v4 17/20] net/txgbe: fix get module info operation
Date: Mon, 11 May 2026 18:35:59 +0800
Message-Id: <20260511103604.19724-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OKKHiI6c9SH3fxzGeZeoTmM7bYo1EHxWz8dqJfnEaK+Vwp5ArDUHOB7l
 nDFDZNiFvPp9Oz9Pg+Qvd4GjPgMaAC39/wqiGmkkV49UyOkwoxgG8cG7gKz+oZGAGVcnoIz
 cBxv0cF4nTwifFs5hXi+vEDtZdqV2QwCoKgC+5S4pAQTP4XFw8cpsinM5BaJYVpY+x0wgJT
 oV9xrx+KWOcTsnNWDezrvCCYAgDx1WnWwn70TddCF0zQurhYNUUmQmiydak1zFT+QodANiu
 1VybGVDhYfmrH0DAZ4pUbCD1Iy+8gqHwXjMg3egdD+R9Cy/yiGF1yNhwjosWTx5btZqsEwx
 tTR6saNti3ldzGWHNWs86gf+bjgJpnq6eATUBGQ/gDyGUvwnY/yWUz8AEexB6lUO497+63R
 ZnFkPRL/YIt7+YPEEIi2mBrMCFtu0Lf45qHFG46rnpOiLdOa9s7LMEVBohcqrizJ36WP8Dz
 6q/fXC0V04f2fWJZG7yTLFaoOst9PtZlasTIIHIDja13TlRieWzIBD8/i6VENLzR6c+pqVH
 tiZWkqYAyh65wMmExcfbAkVg6W5wJYArCYRGzr6+5KYQr5xIr2dlAF2aIobJBbmZ9iIYmc/
 yGOJGW+aMoGq3Mye7weUnk9IkfEqNdjnaHWbVjqo3wQ5so9+GczQLG/dIBVXq+hMicPB51M
 gl1HxzVeTtENLSlbvAqg1A30C5YY60bLofeAYHpcgPeLp/WgjCeITOxdfbdGE3I0akZEWC+
 yf7hm8XnRkw3qjJh4Djx5bKsSpx/AwEszhEwQ+psTjThjISN20y7U/A8voLtspixKZLdrai
 goExQhd8cAZ0nXmAK8CIDAm+QeutUOMsX3JdAwfroIr2pnYf3Hg8EASHRzmlR/AiSV7m+jc
 7v8s3nNGToHoiWGCqdhyj8o2ywKbgIrKZ3CRFBYhgLhF5UGpQz3E3QnE7lIoITdzMlFrt6E
 eCVqk51McZLBopLPEQeglSgX9LrpbMnPSidELQj3NB4FVtvJx4qPy+VJfWJqsZ/khHnySwm
 1cM3uglTzOeYkC7hP8q0k0wHtansHG5HyPAz8kCvrhy2JGEz9QPWsJ2ZNJwrlpOsm8jc2mg
 xqz0onVzQgru7aGv0yALJo=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
 drivers/net/txgbe/base/txgbe_phy.h |   6 +-
 drivers/net/txgbe/txgbe_ethdev.c   | 116 ++++++++++++++++++++++-------
 2 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 4da4be0d5f..581f667bdc 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -257,11 +257,15 @@
 #define   TXGBE_SFF_CABLE_DA_PASSIVE    0x4
 #define   TXGBE_SFF_CABLE_DA_ACTIVE     0x8
 #define TXGBE_SFF_CABLE_SPEC_COMP	0x3C
+#define TXGBE_SFF_DDM_IMPLEMENTED	0x40
 #define TXGBE_SFF_SFF_8472_SWAP		0x5C
 #define TXGBE_SFF_SFF_8472_COMP		0x5E
 #define TXGBE_SFF_SFF_8472_OSCB		0x6E
 #define TXGBE_SFF_SFF_8472_ESCB		0x76
-#define TXGBE_SFF_QSFP_PAGE_SELECT      0x7F
+#define TXGBE_SFF_SFF_REVISION_ADDR	0x01
+#define TXGBE_SFF_QSFP_PAGE_SELECT	0x7F
+
+#define TXGBE_MODULE_QSFP_MAX_LEN	640
 
 #define TXGBE_SFF_IDENTIFIER_QSFP	0x0C
 #define TXGBE_SFF_IDENTIFIER_QSFP_PLUS	0x0D
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 56987ae028..bc651cfcfb 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5348,41 +5348,105 @@ txgbe_get_module_info(struct rte_eth_dev *dev,
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t status;
 	uint8_t sff8472_rev, addr_mode;
+	u8 identifier = 0;
+	u8 sff8636_rev = 0;
 	bool page_swap = false;
+	u32 value;
 
-	/* Check whether we support SFF-8472 or not */
-	status = hw->phy.read_i2c_eeprom(hw,
-					     TXGBE_SFF_SFF_8472_COMP,
-					     &sff8472_rev);
-	if (status != 0)
-		return -EIO;
-
-	/* addressing mode is not supported */
-	status = hw->phy.read_i2c_eeprom(hw,
-					     TXGBE_SFF_SFF_8472_SWAP,
-					     &addr_mode);
-	if (status != 0)
-		return -EIO;
+	if (hw->mac.type == txgbe_mac_aml40) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_PRST_LS)
+			return -EIO;
+	}
 
-	if (addr_mode & TXGBE_SFF_ADDRESSING_MODE) {
-		PMD_DRV_LOG(ERR,
-			    "Address change required to access page 0xA2, "
-			    "but not supported. Please report the module "
-			    "type to the driver maintainers.");
-		page_swap = true;
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_ABS_LS)
+			return -EIO;
 	}
 
-	if (sff8472_rev == TXGBE_SFF_SFF_8472_UNSUP || page_swap) {
-		/* We have a SFP, but it does not support SFF-8472 */
-		modinfo->type = RTE_ETH_MODULE_SFF_8079;
-		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8079_LEN;
+	status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	if (status)
+		return -EBUSY;
+
+	if (hw->mac.type == txgbe_mac_aml40) {
+		status = hw->phy.read_i2c_sff8636(hw, 0,
+						  TXGBE_SFF_IDENTIFIER,
+						  &identifier);
 	} else {
-		/* We have a SFP which supports a revision of SFF-8472. */
-		modinfo->type = RTE_ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
+		status = hw->phy.read_i2c_eeprom(hw,
+						 TXGBE_SFF_IDENTIFIER,
+						 &identifier);
 	}
 
+	if (status != 0)
+		goto ERROR_IO;
+
+	switch (identifier) {
+	case TXGBE_SFF_IDENTIFIER_SFP:
+		/* Check whether we support SFF-8472 or not */
+		status = hw->phy.read_i2c_eeprom(hw,
+						 TXGBE_SFF_SFF_8472_COMP,
+						 &sff8472_rev);
+		if (status != 0)
+			goto ERROR_IO;
+
+		/* addressing mode is not supported */
+		status = hw->phy.read_i2c_eeprom(hw,
+						 TXGBE_SFF_SFF_8472_SWAP,
+						 &addr_mode);
+		if (status != 0)
+			goto ERROR_IO;
+
+		if (addr_mode & TXGBE_SFF_ADDRESSING_MODE) {
+			PMD_DRV_LOG(ERR,
+				    "Address change required to access page 0xA2, "
+				    "but not supported. Please report the module "
+				    "type to the driver maintainers.");
+			page_swap = true;
+		}
+
+		if (sff8472_rev == TXGBE_SFF_SFF_8472_UNSUP || page_swap ||
+		    !(addr_mode & TXGBE_SFF_DDM_IMPLEMENTED)) {
+			/* We have a SFP, but it does not support SFF-8472 */
+			modinfo->type = RTE_ETH_MODULE_SFF_8079;
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8079_LEN;
+		} else {
+			/* We have a SFP which supports a revision of SFF-8472. */
+			modinfo->type = RTE_ETH_MODULE_SFF_8472;
+			modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
+		}
+		break;
+	case TXGBE_SFF_IDENTIFIER_QSFP:
+	case TXGBE_SFF_IDENTIFIER_QSFP_PLUS:
+		status = hw->phy.read_i2c_sff8636(hw, 0,
+						  TXGBE_SFF_SFF_REVISION_ADDR,
+						  &sff8636_rev);
+		if (status != 0)
+			goto ERROR_IO;
+		/* Check revision compliance */
+		if (sff8636_rev > 0x02) {
+			/* Module is SFF-8636 compliant */
+			modinfo->type = RTE_ETH_MODULE_SFF_8636;
+			modinfo->eeprom_len = TXGBE_MODULE_QSFP_MAX_LEN;
+		} else {
+			modinfo->type = RTE_ETH_MODULE_SFF_8436;
+			modinfo->eeprom_len = TXGBE_MODULE_QSFP_MAX_LEN;
+		}
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "SFF Module Type not recognized.");
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+		return -EINVAL;
+	}
+
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	return 0;
+
+ERROR_IO:
+	PMD_DRV_LOG(ERR, "I2C IO ERROR.");
+	hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+	return -EIO;
 }
 
 static int
-- 
2.21.0.windows.1

