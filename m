Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF7CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E186E40611;
	Mon, 22 Jun 2026 13:12:23 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 1841440B8F;
 Mon, 22 Jun 2026 13:12:20 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126738t214f17d6
X-QQ-Originating-IP: bY7BWX5Jresi/L+xL6G9ReP57JPQhxxI1Fn0u3xfGhA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:12:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12949498586289318028
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 17/21] net/txgbe: fix get module info operation
Date: Mon, 22 Jun 2026 19:11:05 +0800
Message-Id: <20260622111111.21024-18-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBUSIVIw0bNz+TEeGWaHoBhFM7uK9tycnR95u1fyd8gj5Ej1OnA7vR6g
 BCit35hb5+cG1RVMOwO+FanMC8EdzGdqsfIc4fYnijXnQk/1TuN4bpLYb2012o6OHeRRgX4
 P0wdRComeARO6U4pyW6lDSO3Gkoudb4LA1YuzWRouYSsVfRQmJIFSQMCznn8UDTma6xtH+Q
 88PBxKFRnqp8/Goi4LDIjds6XvB0N+i37wUVraZsRPqFKDiIkmuYLZ7uqmexyPhg3UQQugW
 uMziqXbenPMn2OS6qBhapiMvNHP/U4H03hxHPg9P3MV/Rq3fpY1owvPKX/0qEZEpluuySAL
 qGyOY3PIdwPjnsJsDdAvj2+4NT/fiTBljRXp3DNV8T5DC9yQQliaOaS57ITD0G825vqEAjh
 /nTV5gaXGVORPHaPJxO4uPigl6u+HvHyYuV6PkxAVhuGdst89Ujz6DfttVqDztJXyqImro7
 /BJLqR55dkMXv0Iem9BCxKOC3hahH5Wl38GzCL3Xp8mV4wTEgxvLBQC2kRlUVAr9f1XmhG5
 Fy/BTVOoT0pH14qlS76Hf4/N8G///JcJpeOjt3xeD+H7U5Hn6g+e5DKzq0v/kDiScpzRU98
 GckgFCbdzEAHa6DsvK2wUjuOdFJm0lmBF6SaQl7r/qMXz+bUAbVjewOk7k4CLTAMTsQ8EUw
 YzNR7GLqjCPU2UlpU5t6TuYc7Mml85BSZln/fJ3v2CfKcGPNlDoxOBg5tNFFIvSHqD5+9Yt
 672eXoqb4Bw8J1JtXC/FTccoAHj6IH1nmeF4rGkaalew66+KvbWsrFsmZwVxmY1tf0Q0UDL
 MbqhTdYsBwESOVVcqzKMqNRzVp0f14fa3w8akiVW/gt37/5wQG4wUGJfZyzi1xMX6AL3zOX
 cqk45i0sqqFxH7wBBev9gINdh5E97C/aNhREMrtxHxdRbEfRw5tnFAdPp6Kuv7BsrROQIEI
 7QdP1hQzpBjUrgJpml4t+98aig+Z29LhpucWKvAER1vRSRy8EeJfEUyVPHeZCQhy004p97j
 J2qcZ+K/m0OeLFZtYfVIyVBYZHtkEIu5SyyMPNcgRP9Z+z8xLfK7+iWlqFCLa0PZoYR93fj
 bweMbfhXsC5XIlpNmXTkSP7l2jnrTRU1w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
index 20c80d9d88..31bdceb35b 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -258,10 +258,14 @@
 #define   TXGBE_SFF_CABLE_DA_ACTIVE     0x8
 #define TXGBE_SFF_CABLE_SPEC_COMP	0x3C
 #define TXGBE_SFF_SFF_8472_SWAP		0x5C
+#define   TXGBE_SFF_DDM_IMPLEMENTED	0x40
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
index 5174803df7..c02ba6c517 100644
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
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		value = rd32(hw, TXGBE_GPIOEXT);
+		if (value & TXGBE_SFP1_MOD_ABS_LS) {
+			PMD_DRV_LOG(WARNING, "SFP module not present, cannot get module info.");
+			return -EINVAL;
+		}
+	}
 
-	/* addressing mode is not supported */
-	status = hw->phy.read_i2c_eeprom(hw,
-					     TXGBE_SFF_SFF_8472_SWAP,
-					     &addr_mode);
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

