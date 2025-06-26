Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1173AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACAA741148;
	Thu, 26 Jun 2025 10:09:47 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id B360F410DC
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:45 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925382t9bf17629
X-QQ-Originating-IP: w/ysF1dAB5XTJ/+YsawBnLIBL6J5UVMRMxAn9iyz1Fg=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3596176948339373960
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 12/15] net/txgbe: add GPIO configuration
Date: Thu, 26 Jun 2025 16:02:17 +0800
Message-Id: <20250626080221.22488-13-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MZQHZNohqAr1ZYJ0pdJupu0VR2qlSrsUoDSOcokymgFlIJFGkd/zYqrR
 4jJcojF/iJmj6ysJGjUuxMm0ev3Gej8Y1h29iAgzunW9dZNG2Tz6bqtpP6UA480nzmn76+x
 rgb1DTFV8BeMkNg8zg52Xcj76UnABHCDIuT+WnSKwLSMIP6giwtffSEVzWZUeMW7Mvz8YNa
 GYFxdDKxmlTU7ULoztf/JFJ5yrsjtmAl3DHQcR+TJy3cRZDDNfmMDx7CNd1/ei52SgqDSgs
 IYw6i5C+D68lI/h2RHKzBHRf9VYU/UQrlnMUnKIPtNlkioMLGQLsiA3zaKDZApJ2ts9WAwe
 r4o+1+eAslmWoZtfK+5Jej5V+/1wSLvSjORG6d6tTg8tbgbTVXxvO5AOtSKJa29iEODRYjO
 NU9lAY6buxc16nO2StS9WH2Tt/Oz7kMZeu8iLQ80nYWlhFnShBY1us3n/fVt7f0ZbBMl3Zw
 YjSc+aOqBEB6kM229Wnl39woXI+XD1bVn7ygQLLMUOMwOGd+pEIDZ5M73QytGAgdG6ZGWQL
 m6IB9Tpexfe0EPNJlh/HDpBQAqubm2/2wLKAXq0o2CdfKU7/yW5ZOFceKrNF65WhuW2x7zv
 Py4T8MywhXlGNjwkzU7zlMxiFOOKMbL36LvFnDTgdvCZhD/XEZHqqEKyq2FbeJJVGj4LwRG
 bl2D6CEdUDYlGILty5bCrZ/Ynfqr+0gzfdRZ3cPr+cVIaY+DOdrtmAo4Wz3WoRvl6sf6bQe
 8HLAijjM/s3I3ziaqpzb3jtFGBrmPaI8mf9NNVBD+wY+F6RWlhSSlKl2aIVOQvbi7oBJIJr
 B6rezFSgRD6u/zb6dK0Il35/gFnYqCoTpDUtLHRSUrkl24Cufc0va1o+CmuH2mNqFsRK4sn
 0CS0ya+3Dqp9Nm9TcvNBF63mdniSSA2krzOo9L9X0wW0joxTPFXiiLVShVszJ6AXIQKbHKs
 wZ0bCLL7yvXlvjzXPLiZRRI4V4uujleBrLKutFEkh4He6fmOiFP1fAn0YDxVapk84IQ63Hm
 dleyDaET/piZqLEvGYWvUynSCKzHsoQ5/sy+q7k0e7eT7qEQzgo875OhBXKr0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Add GPIO configuration for Amber-Lite NICs to match design differences
from 10G NICs: The Amber-Lite NIC requires additional setup steps
compared to 10G NICs to ensure proper functionality of features
SFP module detection.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h |   2 +
 drivers/net/txgbe/txgbe_ethdev.c    | 111 ++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 86f88e31fe..98d1070daa 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1626,6 +1626,8 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_GPIOINTEN                 0x014830
 #define TXGBE_GPIOINTMASK               0x014834
 #define TXGBE_GPIOINTTYPE               0x014838
+#define TXGBE_GPIO_INT_POLARITY         0x01483C
+#define   TXGBE_GPIO_INT_POLARITY_3     MS(3, 0x1)
 #define TXGBE_GPIOINTSTAT               0x014840
 #define TXGBE_GPIORAWINTSTAT            0x014844
 #define TXGBE_GPIOEOI                   0x01484C
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 374d6452f4..9fd4923b6d 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -353,11 +353,33 @@ txgbe_enable_intr(struct rte_eth_dev *dev)
 {
 	struct txgbe_interrupt *intr = TXGBE_DEV_INTR(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t gpie;
 
 	wr32(hw, TXGBE_IENMISC, intr->mask_misc);
 	wr32(hw, TXGBE_IMC(0), TXGBE_IMC_MASK);
 	wr32(hw, TXGBE_IMC(1), TXGBE_IMC_MASK);
 	txgbe_flush(hw);
+
+	/* To avoid gpio intr lost, enable pcie intr first. Then enable gpio intr. */
+	if (hw->mac.type == txgbe_mac_aml) {
+		gpie = rd32(hw, TXGBE_GPIOINTEN);
+		gpie |= TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3 | TXGBE_GPIOBIT_6;
+		wr32(hw, TXGBE_GPIOINTEN, gpie);
+
+		gpie = rd32(hw, TXGBE_GPIOINTTYPE);
+		gpie |= TXGBE_GPIOBIT_2 | TXGBE_GPIOBIT_3 | TXGBE_GPIOBIT_6;
+		wr32(hw, TXGBE_GPIOINTTYPE, gpie);
+	}
+
+	if (hw->mac.type == txgbe_mac_aml40) {
+		gpie = rd32(hw, TXGBE_GPIOINTEN);
+		gpie |= TXGBE_GPIOBIT_4;
+		wr32(hw, TXGBE_GPIOINTEN, gpie);
+
+		gpie = rd32(hw, TXGBE_GPIOINTTYPE);
+		gpie |= TXGBE_GPIOBIT_4;
+		wr32(hw, TXGBE_GPIOINTTYPE, gpie);
+	}
 }
 
 static void
@@ -1711,6 +1733,7 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	uint16_t vf, idx;
 	uint32_t *link_speeds;
 	struct txgbe_tm_conf *tm_conf = TXGBE_DEV_TM_CONF(dev);
+	u32 links_reg;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1892,6 +1915,44 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	if (err)
 		goto error;
 
+	if (hw->mac.type == txgbe_mac_aml) {
+		links_reg = rd32(hw, TXGBE_PORT);
+		if (links_reg & TXGBE_PORT_LINKUP) {
+			if (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) |
+					TXGBE_MAC_TX_CFG_AML_SPEED_25G);
+			} else if (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) |
+					TXGBE_MAC_TX_CFG_AML_SPEED_10G);
+			}
+		}
+
+		/* amlite: restart gpio */
+		wr32(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1 |
+					TXGBE_GPIOBIT_4 | TXGBE_GPIOBIT_5);
+		wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_4 | TXGBE_GPIOBIT_5);
+		msleep(10);
+		wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_0);
+		wr32m(hw, TXGBE_GPIO_INT_POLARITY, TXGBE_GPIO_INT_POLARITY_3, 0x0);
+	} else if (hw->mac.type == txgbe_mac_aml40) {
+		links_reg = rd32(hw, TXGBE_PORT);
+		if (links_reg & TXGBE_PORT_LINKUP) {
+			if (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) |
+					TXGBE_MAC_TX_CFG_AML_SPEED_40G);
+			}
+		}
+
+		wr32(hw, TXGBE_GPIODIR, TXGBE_GPIOBIT_0 | TXGBE_GPIOBIT_1
+							| TXGBE_GPIOBIT_3);
+		wr32(hw, TXGBE_GPIODATA, TXGBE_GPIOBIT_1);
+	}
 skip_link_setup:
 
 	if (rte_intr_allow_others(intr_handle)) {
@@ -1989,6 +2050,10 @@ txgbe_dev_stop(struct rte_eth_dev *dev)
 	for (vf = 0; vfinfo != NULL && vf < pci_dev->max_vfs; vf++)
 		vfinfo[vf].clear_to_send = false;
 
+	if (hw->mac.type == txgbe_mac_aml)
+		wr32m(hw, TXGBE_AML_EPCS_MISC_CTL,
+			  TXGBE_AML_LINK_STATUS_OVRD_EN, 0x0);
+
 	txgbe_dev_clear_queues(dev);
 
 	/* Clear stored conf */
@@ -2867,6 +2932,27 @@ txgbe_dev_sfp_event(struct rte_eth_dev *dev)
 		intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
 	}
 
+	if (hw->mac.type == txgbe_mac_aml40) {
+		if (reg & TXGBE_GPIOBIT_4) {
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_4);
+			rte_eal_alarm_set(1000 * 100, txgbe_dev_detect_sfp, dev);
+		}
+	} else if (hw->mac.type == txgbe_mac_raptor || hw->mac.type == txgbe_mac_aml) {
+		if (reg & TXGBE_GPIOBIT_0)
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_0);
+		if (reg & TXGBE_GPIOBIT_2) {
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_2);
+			rte_eal_alarm_set(1000 * 100, txgbe_dev_detect_sfp, dev);
+		}
+		if (reg & TXGBE_GPIOBIT_3) {
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_3);
+			intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
+		}
+		if (reg & TXGBE_GPIOBIT_6) {
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_6);
+			intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
+		}
+	}
 	wr32(hw, TXGBE_GPIOINTMASK, 0);
 }
 
@@ -3044,6 +3130,9 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 	}
 
 	if (link_up == 0) {
+		if (hw->mac.type == txgbe_mac_aml)
+			wr32m(hw, TXGBE_GPIO_INT_POLARITY,
+				  TXGBE_GPIO_INT_POLARITY_3, 0x0);
 		if ((hw->subsystem_device_id & 0xFF) ==
 				TXGBE_DEV_ID_KR_KX_KX4) {
 			hw->mac.bp_down_event(hw);
@@ -3130,6 +3219,28 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 		wr32(hw, TXGBE_MAC_WDG_TIMEOUT, reg);
 	}
 
+	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
+		reg = rd32(hw, TXGBE_PORT);
+		if (reg & TXGBE_PORT_LINKUP) {
+			if (reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) | TXGBE_MACTXCFG_TXE |
+					TXGBE_MAC_TX_CFG_AML_SPEED_40G);
+			} else if (reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) | TXGBE_MACTXCFG_TXE |
+					TXGBE_MAC_TX_CFG_AML_SPEED_25G);
+			} else if (reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) {
+				wr32(hw, TXGBE_MACTXCFG,
+					(rd32(hw, TXGBE_MACTXCFG) &
+					~TXGBE_MAC_TX_CFG_AML_SPEED_MASK) | TXGBE_MACTXCFG_TXE |
+					TXGBE_MAC_TX_CFG_AML_SPEED_10G);
+			}
+		}
+	}
+
 	return rte_eth_linkstatus_set(dev, &link);
 }
 
-- 
2.21.0.windows.1

