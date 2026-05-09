Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BFCD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:30:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F9D14066C;
	Sat,  9 May 2026 13:29:40 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 128AD40431;
 Sat,  9 May 2026 13:29:36 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326172t512c17b2
X-QQ-Originating-IP: rDViMuQcRkxTKp0MmTmlnDUM0HhN3SW6Zoxjubvt924=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:29:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7962441700785347375
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 17/20] net/txgbe: fix get module info operation
Date: Sat,  9 May 2026 19:28:19 +0800
Message-Id: <20260509112823.7728-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OCnNLGxuhE2o5dy6mHZG3/o2VY1MmfSzQnvub4kncOP+DniwoNk5aPlP
 3vV48YKZx3uV8vVAKlLKZS6FPd3zrxoeRsiyby8PLOaAYtQajGvEi+kOghQ+i/uEyg+W4Dl
 +Qz++L8cYapUEacQa0AB+lwGYl1/qWzK4J0ivHhEpE0D9xh8SRMqwSqBTbOR+ID4SdJSpla
 KvZdff5k6+daHfuBOaaySYhBhpfDSapGlq7nhhQ4/QHoepCZkVvZRR3+T9AuTLYrQTFyRxR
 lo5ac6D/v29FRmjEoGFZb1oAi9v9VCF1wyQx0mcfU6QtXglkoChXPk/BifpCj5a+VfZHKZ1
 PENQs1k/cWws6wU+qb1Y8seYIzSeDm0DcsC6V/GRM5iRXV/2dACRLdSOL06lP+5hKjx5XF2
 ICmWXCeGcrR+JYWg910wiia3OO++KU/RbAo679YkMLT+SmXB+syiAPsoRD28iIy6yu5jU3Z
 Lsdrxci6moTZnxNOrrcQJGFo50P9sw8L8y1NJMmQGIE0ucxnHv2JNwZ4xtKR6wWWY76vejb
 KRSRepQSk74Q1tFdU3CL5jYGldQzJivChdwgKUsDO/RcakRJverlfnyc3rapJXSnBPWFPbq
 YqIxLy749vItl2G6WpBGoPeVwTs5sradU7mjhA9BEOGAhTwiZ6pmYF3gg2Zq5h4l3OUwUpz
 cpeD/HIUdSDDGlZaIgODKbwfl+I4SYkJzX/Du7NSYJSXsBp33GlXpZfTzhVZ7jmJV2itvWe
 kA2oB8qv6s9omAo452G3568Z2jOZIrA59oo2ElTr3rj/MgyCxwgaMU/c3TlVf0lAePa2aV/
 rxN2+1bKVkEZAJbVQoT2hEkvu7uWtUfyFmhoD2w7FT0lHyx98gzeAcU8Bg9d8Cy6ZLrjtPe
 RGJ89+D3pgv1mTzeG0J5fMboan7oKN2rXDtQN6Omn1YbvbxHqRJUezTUDSSmlxT5/EKezNR
 XaCSfMYei8nnwdUaXMQR+6D0k2EpuvR1EiQxNb8TAA52Exuc3IkgWpt6Ltmphm4rjM23AXv
 ot26M1YR7Y7uEE26t0BC3bvHdIN7HPr0NKTnJRVWadCR+DZhl8j+y2gmDCLMK0YUejlpLo0
 z5M7cwaHFg9L9wPyxwzrLk=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

