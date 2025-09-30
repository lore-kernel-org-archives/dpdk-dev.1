Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86839CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC36740E25;
	Tue, 30 Sep 2025 12:00:57 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 8D15340DDB
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:53 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226450t58455813
X-QQ-Originating-IP: /m314BnB1V4OKYqW3opHHlnMuAG6rQE/O4sfaRAf94U=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9273487057649519769
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 13/20] net/txgbe: add GPIO configuration
Date: Tue, 30 Sep 2025 17:59:45 +0800
Message-Id: <20250930095953.18508-14-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NSSdk1DMx7alLqBMbtKprIX10kfSyI1JcsGOKISy16HCT3yoDbC8Wd9t
 IZO7tOK7DJP2yyBC4vvR1xS2UnVqrKDc7LShgBceOKvkduMnJO1fd3ausB7GPSlZd3tP3V9
 ATRkp1+NTi8BRUFzrgDlAdaCq20RfaMk8jeWE7mDhRraaX+NUHfcmJbraKEfqbH6fh+JcRE
 lxKAaRQsxoQ9+RV86SsxSLCwARs3nWcmwyxjfi0Wcwz/OsDKZmH9bf9pLBZ8j/7s2V0l+PT
 zchRRzCHvyKY0oNHBsdyPvbUtL7KsSlLhYvAkauNmlkyJqeaf/RXooE4eDSOrQUGUDfPekD
 VQkp195wNWghEXzPAO6u1uMXp0gffZzPwwJA8R77vuswWERiuxuZF3V6fWDoalyXwp84Hby
 LcMtekzvzYIgVOvT0LNxnnsll5AdPUz+RZQ2gKdVSXnA6zMhbEekKpuf9s6/sLAaqOWtZPZ
 bKb9tiiprEEf3o6pCU1YSkw8SH9tAb/mvPVIoY99YONrmtXl9HfP5+GNlgLh/YZtHzTrF08
 Vvmb3NkUv4JoPei8ZQgjtcTDoafWizPiDUsk3gf/Zt6dunfDp+nSOUyksOFu8CEI8ueuFhK
 AfXVsckRX3Vcr3O3NZlTHJelzDw1eku21qtIB81XZqCXYo2kujVG8EEVx/7Eid5CH0Yw5R/
 pbcQkXLfwE65LAVtlkTspFKQC4G27f7n4zGJgMS4yqtVyRgDIqlTSR5YaBljNv8dJ4nxH24
 0NXCg6+mBNE5g9m3SbPvCoctDJwIc0QZunfKYth85eAvpIaQG5NGgyv+vkZ+xMDVgeS95qh
 eT3LBL/1RXL0zvuT16zvxB6QaY4t9g/I4d+iw/Q4fOoaKxvM4rh7H1DldSvdYSifgaWeGdJ
 8ojs7tNVzoQKNTdoX9vu+MLsuf1+mNukz72PeNJEsh5bYfOfAAv2CkInnRihvy2xSRvM/k4
 dUdBkDFP/MVWhZ30jydL8eKGAEGfWh58q1gJNY+jj4mGQRzpqQWIVBvk4D/kJeDudPKNtfO
 odpo/hJhxisELedL19IIGuG+SeUVV0axEhTiEfFk8bqoSWYt/OCrsnJo5oEberwnvJKXww0
 DeBXbIFlcVf
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index e050941992..00c41a5b86 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1631,6 +1631,8 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_GPIOINTEN                 0x014830
 #define TXGBE_GPIOINTMASK               0x014834
 #define TXGBE_GPIOINTTYPE               0x014838
+#define TXGBE_GPIO_INT_POLARITY         0x01483C
+#define   TXGBE_GPIO_INT_POLARITY_3     MS(3, 0x1)
 #define TXGBE_GPIOINTSTAT               0x014840
 #define TXGBE_GPIORAWINTSTAT            0x014844
 #define TXGBE_GPIOEOI                   0x01484C
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index dc190fbc1a..e6694f7fc2 100644
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
@@ -2868,6 +2933,27 @@ txgbe_dev_sfp_event(struct rte_eth_dev *dev)
 		intr->flags |= TXGBE_FLAG_NEED_LINK_UPDATE;
 	}
 
+	if (hw->mac.type == txgbe_mac_aml40) {
+		if (reg & TXGBE_GPIOBIT_4) {
+			wr32(hw, TXGBE_GPIOEOI, TXGBE_GPIOBIT_4);
+			rte_eal_alarm_set(1000 * 100, txgbe_dev_detect_sfp, dev);
+		}
+	} else if (hw->mac.type == txgbe_mac_sp || hw->mac.type == txgbe_mac_aml) {
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
 
@@ -3045,6 +3131,9 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 	}
 
 	if (link_up == 0) {
+		if (hw->mac.type == txgbe_mac_aml)
+			wr32m(hw, TXGBE_GPIO_INT_POLARITY,
+				  TXGBE_GPIO_INT_POLARITY_3, 0x0);
 		if ((hw->subsystem_device_id & 0xFF) ==
 				TXGBE_DEV_ID_KR_KX_KX4) {
 			hw->mac.bp_down_event(hw);
@@ -3131,6 +3220,28 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
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

