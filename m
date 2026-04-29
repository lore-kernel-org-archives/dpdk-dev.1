Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB53FF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2989640A6E;
	Wed, 29 Apr 2026 12:27:05 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 8AC5840B9A;
 Wed, 29 Apr 2026 12:26:55 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458412ta55b390e
X-QQ-Originating-IP: rsH95olnw8bOmQtWV2dNQm4a2U1tjp99tKS3GF+xHQI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:26:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9064336430316563695
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 17/20] net/txgbe: fix get module info operation
Date: Wed, 29 Apr 2026 18:25:11 +0800
Message-Id: <20260429102515.58880-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Np41pleoJw3mw1ToU+EHw7ayn0aeymr/pW4aqYdRPOOPeGqoav6NiFDN
 D8/S+jUrsAXdST2y7deuNrKkenpTfUY/wA7d0OeL2II4RYAq3mbdUYLHFD+TFdkWzEHAtYD
 WW6iQ95NkYG1krw+Kpbfs8j5qMSuH6JaTwavlB46zVdDSHSg1iKVnzsg1rlzHtl9/gJbsZI
 hTrGZ3KkO856OGs6VgTRzZQ2JpVcK3Q9DpvNYnWa1da+B0v1AKU+Dc73uDw3fMrn+G3LNx5
 9rcMJVzo4nwIscQ+n8Vb/2mj0aCUC3hFr19VAWlyq6DgaKBJrxtUcVsS0vrPVheJJws6Nwq
 iBE70n/WSSKl93D7WIBBVXbkEPM2s2abBlzkidp1v982x9bExB7570ZM1J6cn95zKpmhWXB
 qE2csj3kN9nqEUrlCFX87D7n4SsbOEnTPAj4wr/Pz6zbaIDohQ5sPS+Nwy57sCu67nF4Bgv
 7OdIuO+8mw6PwYdDNWB7gwM/+VyqgOZiukn91CQ452u3KBmJbxpzgIMOvxznx5S6xVTXuOl
 UrWmUYdiEU/EaUQTYlN6KANmMD7IWF/BjipxJ9WjmKFpSkLiVEwL6PxRaT4+vBk4bQZpfK4
 1NR+zGnRX01f18iU2CzONoV2VQD8Q9/qEde9AcW3/iXB2tipw7zeO9afCFmFUAJ6cVqYpzg
 U7hvWcZmT4l5fA+4pnPsZ1tJxiu4vOII/nGppAqEHAuynREVA57xjNdKjz+hIGTVkPsr4C0
 VMRf7oizcCa7tb6Plu5v65H1ACYQxJ5qb3Zu7F3QQXxZtzYpVdCKTHhsjvSVfPwCtQfQEsN
 kbUshSNeJ/W+smDXHXW2VE3JZribftb7vFdskO+AF2vmQfGkNXFjQEglFVcbYaymydDVdaO
 yLZf+yZao9bC8n/CyTJD33Smwb3Zs90MWEgnluK5I0QoCVdyQK7h+dunuNGisC60FYVP83F
 AOjCR+eRSSH+bZ2HFrHmf4qM0S3vxmAYsHngyOviQ9fnnMRD3gykCs9bgG3LY+Yuq+WkR0Q
 lFNUGxmEHcWrVyOmF5wlYMgeOvIUjxTHFZPJfPLuXod66x8fM8BZkyPbOLBnBVo529RKcMl
 V1murKoKkce
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
index 2221153347..4e9da14697 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5342,41 +5342,105 @@ txgbe_get_module_info(struct rte_eth_dev *dev,
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

