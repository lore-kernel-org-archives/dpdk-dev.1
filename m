Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F20AC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 09:41:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92A36402E7;
	Fri, 18 Apr 2025 11:41:54 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 11DC4400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:41:51 +0200 (CEST)
X-QQ-mid: esmtpsz20t1744969307teb5aec46
X-QQ-Originating-IP: t7v+Mj+/3BkM0h5WMzyEInsEUX7bfYndKCRMzos2eG4=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.64.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 18 Apr 2025 17:41:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3957164204625500436
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 1/2] net/txgbe: add support for Wangxun new NIC Amber-Lite
 25g/40g
Date: Fri, 18 Apr 2025 17:41:29 +0800
Message-Id: <20250418094131.24136-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OW4JKxETGMY2BQwNrfHEesfw6rsA8ZWr35LtkmUEV5ZbC0FXcf/x7yil
 0qLJXcEvg1CgNMgYMFxABE+Jtll38Bg6g2oDdV//uUVp5u+Vo7/ZdmSxhF2SoI0HkHvB7aP
 ns+wORRkBg9eSyzyUM1v3BCJBDsbPZ7IaENaPeMeXLP7fH+VqQfzaRekZgj4OS1FPLycQq9
 0nlqombRUiSofrmBNnRcjb04KXkLUswn2n1FeUTPgxMYOAs+GUN1/MblcZkXxcdiQMazNNK
 81ADc9HguYv9ZgsKteKlmB/ujXqCJoxy2P7YRgVYmc3YdzeREM21hkA85OwDEmceqKlBAJH
 H1nlHlSC/vFb9MvXD7hkBQKkstvfJ1AwL6K3CbfwICShBVROxtf+90SMZRifD+rMJ4XEAPR
 Ws+2Z/VaovRplzLdcdtkEMTwPcpZmJfzjXroU4M0/snAgNXsQxPwYeakwR6elAtf4DMOEsM
 H34Q4gXZVn7oOBS5BZr1yOVess3N9LnVUw4eFc+XHYy0lgtczkZ6cUuiUm8eq0bzmBfoN0I
 OVbCbxxCH1vA8NTLj5TLgopNOp4Fg+sPg8TbNx2Tl7/1kEQ2N41M8bBDncOPUb3pfpHdq4+
 1x3baeMNPZ5AQgfqVrSMlweKKtz9U+NpwQS2Ldp82kYW51ZKbnmWu0+eXYEfgQ5FRahwg5q
 v1iPKGDyJLMuAKvwAN09d4HIvckymIs3oRYBjd6FZBo2umjY9OMK6+69y+MJGIAchDMIKyT
 MWFeuxILbYIyrpGBPGTLtoLsiFIO631zLCMl4aQjkbX+t7aZ6alSLOHstd6HiqYsUC9YzFF
 U/4obOGesQIIjOjASHJHyIdDoIddEq3rqyQZWiFuhCMTir/zBDGPHQUnhUOuZtlRqp1q4v7
 uJU2Y5WvqQK1XWbOllYZcHSTqg8dwUYEyT2B/pUzRBZYyJDL3T2ttlv64Sz5SB4afOyjAN8
 BXcDY33r/4c9PhWgpJR1aLIKx4Sy8m0YmUs1eU4izhzkq9yb0EKtBiUMSXzkjpDxprD+Kko
 6ZGHDh8ydjQ245hs8DGMrrIu0wrWM=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

Amber-Lite is a new model of network interface card launched by Wangxun.
It comes in two types: one supports 10g/25g rates, and the other
supports 10g/40g rates.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_devids.h |  9 +++++++
 drivers/net/txgbe/base/txgbe_hw.c     | 17 +++++++++++++
 drivers/net/txgbe/base/txgbe_regs.h   |  4 ++-
 drivers/net/txgbe/base/txgbe_type.h   |  3 +++
 drivers/net/txgbe/txgbe_ethdev.c      | 35 ++++++++++++++++++++-------
 5 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_devids.h b/drivers/net/txgbe/base/txgbe_devids.h
index a3f26eabf6..b7133c7d54 100644
--- a/drivers/net/txgbe/base/txgbe_devids.h
+++ b/drivers/net/txgbe/base/txgbe_devids.h
@@ -19,6 +19,15 @@
 #define TXGBE_DEV_ID_WX1820			0x2001
 #define TXGBE_DEV_ID_SP1000_VF                  0x1000
 #define TXGBE_DEV_ID_WX1820_VF                  0x2000
+#define TXGBE_DEV_ID_AML			0x5000
+#define TXGBE_DEV_ID_AML5025			0x5025
+#define TXGBE_DEV_ID_AML5125			0x5125
+#define TXGBE_DEV_ID_AML5040			0x5040
+#define TXGBE_DEV_ID_AML5140			0x5140
+
+#define TXGBE_DEV_ID_AML_VF			0x5001
+#define TXGBE_DEV_ID_AML5024_VF			0x5024
+#define TXGBE_DEV_ID_AML5124_VF			0x5124
 
 /*
  * Subsystem IDs
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index dd5d3ea1fe..85dbbc5eff 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2469,6 +2469,8 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		status = txgbe_init_ops_pf(hw);
 		break;
 	case txgbe_mac_raptor_vf:
@@ -2506,11 +2508,26 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	case TXGBE_DEV_ID_WX1820:
 		hw->mac.type = txgbe_mac_raptor;
 		break;
+	case TXGBE_DEV_ID_AML:
+	case TXGBE_DEV_ID_AML5025:
+	case TXGBE_DEV_ID_AML5125:
+		hw->mac.type = txgbe_mac_aml;
+		break;
+	case TXGBE_DEV_ID_AML5040:
+	case TXGBE_DEV_ID_AML5140:
+		hw->mac.type = txgbe_mac_aml40;
+		break;
 	case TXGBE_DEV_ID_SP1000_VF:
 	case TXGBE_DEV_ID_WX1820_VF:
 		hw->phy.media_type = txgbe_media_type_virtual;
 		hw->mac.type = txgbe_mac_raptor_vf;
 		break;
+	case TXGBE_DEV_ID_AML_VF:
+	case TXGBE_DEV_ID_AML5024_VF:
+	case TXGBE_DEV_ID_AML5124_VF:
+		hw->phy.media_type = txgbe_media_type_virtual;
+		hw->mac.type = txgbe_mac_aml_vf;
+		break;
 	default:
 		err = TXGBE_ERR_DEVICE_NOT_SUPPORTED;
 		DEBUGOUT("Unsupported device id: %x", hw->device_id);
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 7a9ba6976f..a27860ac84 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -97,7 +97,9 @@
 #define     TXGBE_LINK_SPEED_2_5GB_FULL   0x0400
 #define     TXGBE_LINK_SPEED_5GB_FULL     0x0800
 #define     TXGBE_LINK_SPEED_10GB_FULL    0x0080
-#define     TXGBE_LINK_SPEED_40GB_FULL    0x0100
+#define     TXGBE_LINK_SPEED_25GB_FULL    0x0100
+#define     TXGBE_LINK_SPEED_40GB_FULL    0x0040
+#define     TXGBE_LINK_SPEED_50GB_FULL    0x0200
 #define   TXGBE_AUTOC_AUTONEG             MS64(63, 0x1)
 
 
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 4371876649..1a5e4326a7 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -148,7 +148,10 @@ enum txgbe_eeprom_type {
 enum txgbe_mac_type {
 	txgbe_mac_unknown = 0,
 	txgbe_mac_raptor,
+	txgbe_mac_aml,
+	txgbe_mac_aml40,
 	txgbe_mac_raptor_vf,
+	txgbe_mac_aml_vf,
 	txgbe_num_macs
 };
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index ea9faba2c0..2431057485 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -145,6 +145,11 @@ static void txgbe_l2_tunnel_conf(struct rte_eth_dev *dev);
 static const struct rte_pci_id pci_id_txgbe_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_SP1000) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_WX1820) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5025) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5125) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5040) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_WANGXUN, TXGBE_DEV_ID_AML5140) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -1829,8 +1834,13 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 	if (err)
 		goto error;
 
-	allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
-			RTE_ETH_LINK_SPEED_10G;
+	if (hw->mac.type == txgbe_mac_aml40)
+		allowed_speeds = RTE_ETH_LINK_SPEED_40G;
+	else if (hw->mac.type == txgbe_mac_aml)
+		allowed_speeds = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G;
+	else
+		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
+				 RTE_ETH_LINK_SPEED_10G;
 
 	link_speeds = &dev->data->dev_conf.link_speeds;
 	if (((*link_speeds) >> 1) & ~(allowed_speeds >> 1)) {
@@ -1840,17 +1850,24 @@ txgbe_dev_start(struct rte_eth_dev *dev)
 
 	speed = 0x0;
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		speed = (TXGBE_LINK_SPEED_100M_FULL |
-			 TXGBE_LINK_SPEED_1GB_FULL |
-			 TXGBE_LINK_SPEED_10GB_FULL);
+		if (hw->mac.type == txgbe_mac_aml40) {
+			speed = TXGBE_LINK_SPEED_40GB_FULL;
+		} else  if (hw->mac.type == txgbe_mac_aml) {
+			speed = (TXGBE_LINK_SPEED_10GB_FULL |
+				 TXGBE_LINK_SPEED_25GB_FULL);
+		} else {
+			speed = (TXGBE_LINK_SPEED_100M_FULL |
+				 TXGBE_LINK_SPEED_1GB_FULL |
+				 TXGBE_LINK_SPEED_10GB_FULL);
+		}
 		hw->autoneg = true;
 	} else {
+		if (*link_speeds & RTE_ETH_LINK_SPEED_40G)
+			speed |= TXGBE_LINK_SPEED_40GB_FULL;
+		if (*link_speeds & RTE_ETH_LINK_SPEED_25G)
+			speed |= TXGBE_LINK_SPEED_25GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_10G)
 			speed |= TXGBE_LINK_SPEED_10GB_FULL;
-		if (*link_speeds & RTE_ETH_LINK_SPEED_5G)
-			speed |= TXGBE_LINK_SPEED_5GB_FULL;
-		if (*link_speeds & RTE_ETH_LINK_SPEED_2_5G)
-			speed |= TXGBE_LINK_SPEED_2_5GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_1G)
 			speed |= TXGBE_LINK_SPEED_1GB_FULL;
 		if (*link_speeds & RTE_ETH_LINK_SPEED_100M)
-- 
2.21.0.windows.1

