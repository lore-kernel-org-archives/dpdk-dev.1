Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2902CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49E8440B9B;
	Wed, 27 May 2026 15:04:06 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 86B7940B9B;
 Wed, 27 May 2026 15:04:04 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779887040t8069a3a4
X-QQ-Originating-IP: dldchViAkfIzHb/eDlU2lvJ5CC9jOWah+NsSwFOHQ40=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:03:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16211108913284199929
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 17/21] net/txgbe: fix get module info operation
Date: Wed, 27 May 2026 21:02:17 +0800
Message-Id: <20260527130222.24348-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260527130222.24348-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N10XyoOyIIl0Z+q8Ejqrx/5EIQ/FZuSSWyyCIivj8GROd1EApyYFoPhV
 Wim4igmQhnxxbKsku1CoreKa8Y/0RLCdZD9CaiId+9REzjCLGsMntcAu+BOEL7s1mOhx31m
 eDZn4hevcM6lLOdOh582QHdQlqc44HNFRCF/ghjHxYet4C/D9v9upysvZMbAtVz7X4RBxXr
 eis7sZhbM2jl71vsYpe/TQgIokcKdd755+VnnJ7N4K41SzlNvbSbpyiz9ac1sZeL7K0MU30
 Wr8hdx8uyoayo0zkeJiEuBlcnFeIDPrw3LPopfFpEVl6xWipyoYCAJcaV2DubsMof9fazVl
 +Wh0QRJC6Mhsfsbh+F3Gp4pBIPYXEMxya1BK3raxuM6HvE6EGqwzFpf1u+a7PMjQy2Fo7iA
 FslFytt8WW+eqbF5wlOQ1sJCsZLWClHzsTI1KJXYjyOWvRvQiTc1Kw0netrCbHQ41H6SAQh
 DJ4OBsHGV4C9tjk7XMKxmfS3cLhETEy94BYsqkr3zM1wkdT1MUuvoOz5QO/CXcRkMOG1iNL
 EmTBlsXm90l127s+NzMoCZ4DmDVTD9mCWGTCw6Y/vu7oJYbdeip68Wivsc3IOkBbDrVbhSu
 CZS8MXq5aAcyXocbt0ef8ilekOZp3Af0BMLT7Hkckz1UNpLnjDkPVdV3TkLnYn/vo5ojBHa
 0gmzg01TnljbhvAMjfyFzFNJozZb7xG8B1Or2XYiiHmdwBPUwY/1CwsGZPJiS5zGtDq5CxM
 OiJK8tUQkZTeh3Hjc0Hy4uVggdySrHDtfPQ6IdOomtXnUaW1ssY/6i0gVIYxO2siLKRZyFk
 4NFLHTgtRH9mVpzO6pv1pC1w2RQLQPBrjbBYI7qCABYwkYABnHbrqxvB4XiiJC55sL4LrHC
 Xt+tDIar7JVtFb0RJv6T+boSYQg7Y4Hw4xKWfLi0NvPl5kh+51xvMZoGrVdKNmy7+iWmaLc
 nF0gLWLnEawaICsvCMkK/ROV5TiH8+QBKvxWVjysrOK2/7FKl6eRIcgnD852vl8+jNOr+36
 hlP5JB3U4j6jGgT5YFFYjNa3USCz2qaENvTPh+MpEeFggN2zDqDCZMASpZ88BMKsjlYC1OC
 5jzRmmR9aenlzaVjmmNV8U=
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
 drivers/net/txgbe/base/txgbe_phy.h |   6 +-
 drivers/net/txgbe/txgbe_ethdev.c   | 118 +++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 26 deletions(-)

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
index f1119cf6f8..84c0a856e5 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5348,41 +5348,109 @@ txgbe_get_module_info(struct rte_eth_dev *dev,
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t status;
 	uint8_t sff8472_rev, addr_mode;
+	uint8_t identifier;
+	uint8_t sff8636_rev;
 	bool page_swap = false;
+	uint32_t value;
 
-	/* Check whether we support SFF-8472 or not */
-	status = hw->phy.read_i2c_eeprom(hw,
-					     TXGBE_SFF_SFF_8472_COMP,
-					     &sff8472_rev);
-	if (status != 0)
-		return -EIO;
+	if (hw->mac.type == txgbe_mac_aml40) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_PRST_LS) {
+			PMD_DRV_LOG(WARNING, "QSFP module not present, cannot get module info.");
+			return -EINVAL;
+		}
+	}
 
-	/* addressing mode is not supported */
-	status = hw->phy.read_i2c_eeprom(hw,
-					     TXGBE_SFF_SFF_8472_SWAP,
-					     &addr_mode);
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		 if (value & TXGBE_SFP1_MOD_ABS_LS) {
+			PMD_DRV_LOG(WARNING, "SFP module not present, cannot get module info.");
+			return -EINVAL;
+		}
+	}
+
+	status = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
 	if (status != 0)
-		return -EIO;
+		return -EBUSY;
 
-	if (addr_mode & TXGBE_SFF_ADDRESSING_MODE) {
-		PMD_DRV_LOG(ERR,
-			    "Address change required to access page 0xA2, "
-			    "but not supported. Please report the module "
-			    "type to the driver maintainers.");
-		page_swap = true;
+	if (hw->mac.type == txgbe_mac_aml40) {
+		status = hw->phy.read_i2c_sff8636(hw, 0,
+						  TXGBE_SFF_IDENTIFIER,
+						  &identifier);
+	} else {
+		status = hw->phy.read_i2c_eeprom(hw,
+						 TXGBE_SFF_IDENTIFIER,
+						 &identifier);
 	}
 
-	if (sff8472_rev == TXGBE_SFF_SFF_8472_UNSUP || page_swap) {
-		/* We have a SFP, but it does not support SFF-8472 */
-		modinfo->type = RTE_ETH_MODULE_SFF_8079;
-		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8079_LEN;
-	} else {
-		/* We have a SFP which supports a revision of SFF-8472. */
-		modinfo->type = RTE_ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = RTE_ETH_MODULE_SFF_8472_LEN;
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
+		PMD_DRV_LOG(ERR, "SFF Module Type not recognized, identifier=0x%x", identifier);
+		hw->mac.release_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
+		return -EINVAL;
 	}
 
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

