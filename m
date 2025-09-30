Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B7ECCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D9F740695;
	Tue, 30 Sep 2025 12:00:23 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id E070E400EF
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:21 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226417t49405b59
X-QQ-Originating-IP: 59FyPKFMmYnqhPu2V+9YeKWDKDOHfBgIe6gqSpzDxKo=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8381111083825882056
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 01/20] net/txgbe: add basic information for Amber-Lite
 25G/40G NICs
Date: Tue, 30 Sep 2025 17:59:33 +0800
Message-Id: <20250930095953.18508-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MMz/ZfIG29K6zLYyVVc3u8O8XgSLBf/oFaG+n6qgajeN34Uk1w5b6W70
 ULQdPtj2Itg86UFKnmBKTgLDti501t6WLpRUPzxE+EGTbHqlFn6cDdeUZqPmS863YyeQ0oj
 q3o0hgxRs3/iTl/PlEOPhK5O2Koc3jf1Mq+6+5QlTEVT4I5hn1RiQeKFkNiY0br3Tke8Mmo
 YTaFks8HldqNZx5bY3U9RduUKbUt6D8fhJqqNQhLOWyDB1Tz1shC55VHsAqDW7bKGQWYmx/
 UGGzCbUKuFiYRlY++cw68rd6t+KuZDJKfaCieM/sObNS9m4ZtylD1s3g3sCfQsiZoJ+Kwtj
 qlJvhEEpgXianr3/dQ2jFK8AiQmrynea60UoUHRmlOUGRVBGPfH+KHHWuos3hlUH1JGf3Eu
 2zt5J/dngzFwb47WLA/hHjcdf69loUQXN7DQkwO8N1sSobl6+b/wUviyXswvuTq2WKZyX26
 fX9KeXpP0d836piWac1foQNuZfzAD4lkaOvhPMO0Kj1bVYjPK43Hr3mrH2VR0rUZyUa2vnS
 3t5W2xOM/ZtezeDr+FZWYSZNPe6wldx8MrIpeXFnBq3F2C9/mD3kwXvnklnC1cmN0UxPU5A
 tI7LC6FUuWSygaMKakR1G7SyFMuhQVGsU2H60x0otyNH/NvL4zADHGAKIDXcy22/LOpLqB6
 wE+yGZaTRxDq0k/tqdvSx0RO4LQxGGoDmZfoE2NVg9fTGDQXniJyk/rfI0q3y/NtYtYZKL0
 RyJ0VXVNg4ojNXEmcU1e0+FtQxH2Kl+HcEn0vFWcPLOWDuLTi11h1JLGxFFamEn4ahGdoOV
 e+95MpYugNS51cDWi6yqu9VLlkmR2nWUSQyr114qSAW1e9lbKw/XF/n6LTxqSaVP+vIJGKO
 Vg6Q8Q7tIYjWnqyQLH9MF4ewW8LiorXRbHhKbIZ3zjQsMwAAILqcp4C7aHErgB2PN9A0YQ2
 tIk/ALlYfYSJeTOsUZfKW98kGM1HJ1JVmSNdv4aWbilrsGefUTRxmjHtIF2ya+8Br0yQLtD
 HVZnhf03NBhmIoLFxQKn4IR4Jri5UvMMVlG/KF1YwMKD+qWVvbnaha6JesSmXIgoBbSC+v2
 TZRU6ybspr1
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

Add device IDs, speed and other basic information for Wangxun's
new Amber-Lite NICs: aml (10G/25G) and aml40 (40G).

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
index 42cd0e0e2c..76f8ecf62e 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2476,6 +2476,8 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		status = txgbe_init_ops_pf(hw);
 		break;
 	case txgbe_mac_raptor_vf:
@@ -2523,11 +2525,26 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
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
index 346c23b5da..8da976dcc4 100644
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
index 65527a22e7..731a7b4373 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -140,7 +140,10 @@ enum txgbe_eeprom_type {
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
index 580579094b..d49030357d 100644
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

