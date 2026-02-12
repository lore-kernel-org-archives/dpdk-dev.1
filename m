Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6DFEDF040
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 06:00:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2A9740A4B;
	Thu, 12 Feb 2026 06:59:38 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id A7A8040A82
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:59:37 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61C5xZgdD3356690,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770875976;
 bh=Lcp3rp1hxEXjp565mFkMju+lj4+sPvRAbwCwLLZpnnk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=rewhwFVm4AWoy5Dpsu+a8HWIm0QvyxB7nPgBPqZZ873+hAWLZ1Dlkj3GIgEky3rvD
 dls9vXiAQRnOFzTYefBgIlFo+285R1OMDx/dptk/1YSaJXGDLSQBEETS7cJZGrNmkA
 MzoA3VQgCK5iKTM4Qp9rrkM3B00PjRKfHzr6o1Li+NuWcXpfJQp77XK3cvAZy2A6lY
 EPu4xt3U5juOp4dh7FCOYFJgsELcCXiZdXsFJD2/BYT8dZ3ijLQ9hNRzU6+Jo5OcwB
 ZmZWkfdiqPK1QerPiO0sFv3kWALqXws8SYoWNavuUm+/7yWx/Q6H0zXozGDw4128VR
 KzRvQD+h0VTww==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61C5xZgdD3356690
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:59:36 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 12 Feb 2026 13:59:35 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 12 Feb 2026 13:59:35 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v3 09/12] net/r8169: add support for RTL9151
Date: Thu, 12 Feb 2026 13:58:59 +0800
Message-ID: <20260212055902.139958-10-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260212055902.139958-1-howard_wang@realsil.com.cn>
References: <20260212055902.139958-1-howard_wang@realsil.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This device supports network speeds up to 2.5Gbps.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl9151a.c     |  87 ++++++++++++++++++++
 drivers/net/r8169/base/rtl9151a.h     |  10 +++
 drivers/net/r8169/base/rtl9151a_mcu.c |  53 ++++++++++++
 drivers/net/r8169/meson.build         |   2 +
 drivers/net/r8169/r8169_compat.h      |   3 +
 drivers/net/r8169/r8169_ethdev.c      |   5 +-
 drivers/net/r8169/r8169_ethdev.h      |   3 +
 drivers/net/r8169/r8169_hw.c          | 112 +++++++++++++++++---------
 drivers/net/r8169/r8169_hw.h          |   4 +-
 drivers/net/r8169/r8169_phy.c         |  36 ++-------
 10 files changed, 246 insertions(+), 69 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl9151a.c
 create mode 100644 drivers/net/r8169/base/rtl9151a.h
 create mode 100644 drivers/net/r8169/base/rtl9151a_mcu.c

diff --git a/drivers/net/r8169/base/rtl9151a.c b/drivers/net/r8169/base/rtl9151a.c
new file mode 100644
index 0000000000..4eca5fb96b
--- /dev/null
+++ b/drivers/net/r8169/base/rtl9151a.c
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl9151a.h"
+
+/* For RTL9151A, CFG_METHOD_60 */
+
+static void
+hw_init_rxcfg_9151a(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | Rx_Close_Multiple |
+		RxCfg_pause_slot_en | (RX_DMA_BURST_512 << RxCfgDMAShift));
+}
+
+static void
+hw_ephy_config_9151a(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_60:
+		/* nothing to do */
+		break;
+	}
+}
+
+static void
+rtl_hw_phy_config_9151a_1(struct rtl_hw *hw)
+{
+	rtl_set_eth_phy_ocp_bit(hw, 0xA442, BIT_11);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xB87C, 0x8079);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xB87E, 0xFF00, 0x4400);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xAC16, 0x00FF, 0x0001);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xAD0E, 0x007F, 0x000D);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x80B6);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0xB6C3);
+}
+
+static void
+hw_phy_config_9151a(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_60:
+		rtl_hw_phy_config_9151a_1(hw);
+		break;
+	}
+}
+
+static void
+hw_mac_mcu_config_9151a(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	/* Get H/W mac mcu patch code version */
+	hw->hw_mcu_patch_code_ver = rtl_get_hw_mcu_patch_code_ver(hw);
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_60:
+		/* no mac mcu patch code */
+		break;
+	}
+}
+
+static void
+hw_phy_mcu_config_9151a(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_60:
+		rtl_set_phy_mcu_9151a_1(hw);
+		break;
+	}
+}
+
+const struct rtl_hw_ops rtl9151a_ops = {
+	.hw_init_rxcfg     = hw_init_rxcfg_9151a,
+	.hw_ephy_config    = hw_ephy_config_9151a,
+	.hw_phy_config     = hw_phy_config_9151a,
+	.hw_mac_mcu_config = hw_mac_mcu_config_9151a,
+	.hw_phy_mcu_config = hw_phy_mcu_config_9151a,
+};
diff --git a/drivers/net/r8169/base/rtl9151a.h b/drivers/net/r8169/base/rtl9151a.h
new file mode 100644
index 0000000000..bf0e2017d6
--- /dev/null
+++ b/drivers/net/r8169/base/rtl9151a.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef RTL9151A_H
+#define RTL9151A_H
+
+void rtl_set_phy_mcu_9151a_1(struct rtl_hw *hw);
+
+#endif /* RTL9151A_H */
diff --git a/drivers/net/r8169/base/rtl9151a_mcu.c b/drivers/net/r8169/base/rtl9151a_mcu.c
new file mode 100644
index 0000000000..50a2cd90e6
--- /dev/null
+++ b/drivers/net/r8169/base/rtl9151a_mcu.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl9151a.h"
+
+/* For RTL9151A, CFG_METHOD_60 */
+
+/* ------------------------------------MAC 9151A------------------------------------- */
+
+/* ------------------------------------PHY 9151A--------------------------------------- */
+
+static const u16 phy_mcu_ram_code_9151a_1_1[] = {
+	0xa436, 0x8023, 0xa438, 0x5100, 0xa436, 0xB82E, 0xa438, 0x0001,
+	0xb820, 0x0090, 0xa436, 0xA016, 0xa438, 0x0020, 0xa436, 0xA012,
+	0xa438, 0x0000, 0xa436, 0xA014, 0xa438, 0x1800, 0xa438, 0x8010,
+	0xa438, 0x1800, 0xa438, 0x8017, 0xa438, 0x1800, 0xa438, 0x8028,
+	0xa438, 0x1800, 0xa438, 0x8028, 0xa438, 0x1800, 0xa438, 0x8028,
+	0xa438, 0x1800, 0xa438, 0x8028, 0xa438, 0x1800, 0xa438, 0x8028,
+	0xa438, 0x1800, 0xa438, 0x8028, 0xa438, 0x8901, 0xa438, 0xd707,
+	0xa438, 0x4076, 0xa438, 0x1800, 0xa438, 0x1399, 0xa438, 0x1800,
+	0xa438, 0x139f, 0xa438, 0xa00a, 0xa438, 0x0c06, 0xa438, 0x0102,
+	0xa438, 0xa240, 0xa438, 0xa290, 0xa438, 0xa344, 0xa438, 0xab02,
+	0xa438, 0xa404, 0xa438, 0xd1c7, 0xa438, 0xd045, 0xa438, 0x1000,
+	0xa438, 0x125f, 0xa438, 0xd700, 0xa438, 0x5fbb, 0xa438, 0xa320,
+	0xa438, 0x1800, 0xa438, 0x0cc2, 0xa436, 0xA10E, 0xa438, 0xffff,
+	0xa436, 0xA10C, 0xa438, 0xffff, 0xa436, 0xA10A, 0xa438, 0xffff,
+	0xa436, 0xA108, 0xa438, 0xffff, 0xa436, 0xA106, 0xa438, 0xffff,
+	0xa436, 0xA104, 0xa438, 0xffff, 0xa436, 0xA102, 0xa438, 0x0cb4,
+	0xa436, 0xA100, 0xa438, 0x1398, 0xa436, 0xA110, 0xa438, 0x0003,
+	0xb820, 0x0010, 0xB82E, 0x0000, 0xa436, 0x8023, 0xa438, 0x0000,
+	0xB820, 0x0000, 0xFFFF, 0xFFFF
+};
+
+static void
+rtl_real_set_phy_mcu_9151a_1_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_ram_code(hw, phy_mcu_ram_code_9151a_1_1,
+				 ARRAY_SIZE(phy_mcu_ram_code_9151a_1_1));
+}
+
+void
+rtl_set_phy_mcu_9151a_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_real_set_phy_mcu_9151a_1_1(hw);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index e0b3e88c3d..3747e198bc 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -32,4 +32,6 @@ sources = files(
         'base/rtl8168m.c',
         'base/rtl8127.c',
         'base/rtl8127_mcu.c',
+        'base/rtl9151a.c',
+        'base/rtl9151a_mcu.c',
 )
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 673a1ca274..4339522f2d 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -271,6 +271,8 @@ enum RTL_registers {
 	IB2SOC_DATA    = 0x0014,
 	IB2SOC_CMD     = 0x0018,
 	IB2SOC_IMR     = 0x001C,
+	/* 9151 */
+	TxConfigV2     = 0x60B0,
 };
 
 enum RTL_register_content {
@@ -526,6 +528,7 @@ enum RTL_chipset_name {
 	RTL8125D,
 	RTL8125CP,
 	RTL8168KD,
+	RTL9151A,
 	RTL8126A,
 	RTL8168EP,
 	RTL8168FP,
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 80e03dd53c..625f50853e 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -171,6 +171,7 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		case RTL8125BP:
 		case RTL8125D:
 		case RTL8125CP:
+		case RTL9151A:
 			speed_mode = SPEED_2500;
 			break;
 		case RTL8126A:
@@ -426,6 +427,7 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
+	case CFG_METHOD_60:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -471,6 +473,7 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	case RTL8125BP:
 	case RTL8125D:
 	case RTL8125CP:
+	case RTL9151A:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_2_5G;
 		break;
 	}
@@ -931,7 +934,7 @@ rtl_dev_init(struct rte_eth_dev *dev)
 
 	rtl_disable_intr(hw);
 
-	rtl_hw_initialize(hw);
+	rtl_hw_initialize(hw, pci_dev);
 
 	/* Read the permanent MAC address out of ROM */
 	rtl_get_mac_address(hw, perm_addr);
diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index a7604df6c2..d3676ee7d2 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -117,6 +117,9 @@ struct rtl_hw {
 
 	u16 mcu_pme_setting;
 
+	/* Device function */
+	u8 function;
+
 	/* Enable Tx No Close */
 	u8  HwSuppTxNoCloseVer;
 	u8  EnableTxNoClose;
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 3f7e452132..ef2b0654a5 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -496,22 +496,7 @@ rtl_csi_other_fun_read(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr)
 u32
 rtl_csi_read(struct rtl_hw *hw, u32 addr)
 {
-	u8 multi_fun_sel_bit;
-
-	switch (hw->mcfg) {
-	case CFG_METHOD_26:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-		multi_fun_sel_bit = 1;
-		break;
-	default:
-		multi_fun_sel_bit = 0;
-		break;
-	}
-
-	return rtl_csi_other_fun_read(hw, multi_fun_sel_bit, addr);
+	return rtl_csi_other_fun_read(hw, hw->function, addr);
 }
 
 void
@@ -546,22 +531,7 @@ rtl_csi_other_fun_write(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr,
 void
 rtl_csi_write(struct rtl_hw *hw, u32 addr, u32 value)
 {
-	u8 multi_fun_sel_bit;
-
-	switch (hw->mcfg) {
-	case CFG_METHOD_26:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-		multi_fun_sel_bit = 1;
-		break;
-	default:
-		multi_fun_sel_bit = 0;
-		break;
-	}
-
-	rtl_csi_other_fun_write(hw, multi_fun_sel_bit, addr, value);
+	rtl_csi_other_fun_write(hw, hw->function, addr, value);
 }
 
 void
@@ -631,6 +601,7 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -688,6 +659,7 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -925,6 +897,7 @@ rtl8125_set_rx_desc_type(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
 		break;
 	case CFG_METHOD_70:
@@ -1043,7 +1016,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	rtl_oob_mutex_lock(hw);
 
 	if (hw->mcfg == CFG_METHOD_56 || hw->mcfg == CFG_METHOD_57 ||
-	    hw->mcfg == CFG_METHOD_59)
+	    hw->mcfg == CFG_METHOD_59 || hw->mcfg == CFG_METHOD_60)
 		rtl_mac_ocp_write(hw, 0xE0C0, 0x4403);
 	else
 		rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
@@ -1259,6 +1232,10 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 		hw->hw_ops = rtl8125cp_ops;
 		return 0;
+	/* 9151A */
+	case CFG_METHOD_60:
+		hw->hw_ops = rtl9151a_ops;
+		return 0;
 	/* 8126A */
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1486,7 +1463,7 @@ rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 }
 
 static void
-rtl_init_software_variable(struct rtl_hw *hw)
+rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 {
 	int tx_no_close_enable = 1;
 	unsigned int speed_mode;
@@ -1547,6 +1524,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_59:
 		hw->chipset_name = RTL8168KD;
 		break;
+	case CFG_METHOD_60:
+		hw->chipset_name = RTL9151A;
+		break;
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 		hw->chipset_name = RTL8126A;
@@ -1566,6 +1546,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case RTL8125BP:
 	case RTL8125D:
 	case RTL8125CP:
+	case RTL9151A:
 		speed_mode = SPEED_2500;
 		break;
 	case RTL8126A:
@@ -1697,6 +1678,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -1719,6 +1701,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 	case CFG_METHOD_91:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
@@ -1813,6 +1796,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_58;
 		break;
+	case CFG_METHOD_60:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_60;
+		break;
 	case CFG_METHOD_70:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_70;
 		break;
@@ -1863,6 +1849,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 	case CFG_METHOD_91:
 		hw->HwSuppIntMitiVer = 6;
 		break;
@@ -1894,6 +1881,8 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
 
 	hw->mtu = RTL_DEFAULT_MTU;
+
+	hw->function = pci_dev->addr.function;
 }
 
 static void
@@ -2104,9 +2093,9 @@ rtl_hw_init(struct rtl_hw *hw)
 }
 
 void
-rtl_hw_initialize(struct rtl_hw *hw)
+rtl_hw_initialize(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 {
-	rtl_init_software_variable(hw);
+	rtl_init_software_variable(hw, pci_dev);
 
 	rtl_exit_oob(hw);
 
@@ -2115,6 +2104,36 @@ rtl_hw_initialize(struct rtl_hw *hw)
 	rtl_nic_reset(hw);
 }
 
+static void
+rtl8125_get_mac_version_v2(struct rtl_hw *hw)
+{
+	u32 reg, val32;
+	u32 ic_version_id;
+
+	val32 = RTL_R32(hw, TxConfigV2);
+	reg = val32 & 0x7fffffc0;
+	ic_version_id = val32 & 0x3f;
+
+	RTE_ASSERT(val32 != UINT_MAX &&
+		   (val32 & RTL_R32(hw, TxConfig) & 0x7c800000) == 0x7c800000);
+
+	if (val32 == UINT_MAX)
+		return;
+
+	switch (reg) {
+	case 0x00000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_60;
+		} else {
+			hw->mcfg = CFG_METHOD_60;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 void
 rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 {
@@ -2125,6 +2144,13 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	reg = val32 & 0x7c800000;
 	ic_version_id = val32 & 0x00700000;
 
+	hw->mcfg = CFG_METHOD_DEFAULT;
+
+	RTE_ASSERT(val32 != UINT_MAX);
+
+	if (val32 == UINT_MAX)
+		goto exit;
+
 	switch (reg) {
 	case 0x30000000:
 		hw->mcfg = CFG_METHOD_1;
@@ -2336,8 +2362,10 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_56;
 		} else if (ic_version_id == 0x100000) {
 			hw->mcfg = CFG_METHOD_57;
+		} else if (ic_version_id == 0x300000) {
+			hw->mcfg = CFG_METHOD_60;
 		} else {
-			hw->mcfg = CFG_METHOD_57;
+			hw->mcfg = CFG_METHOD_61;
 			hw->HwIcVerUnknown = TRUE;
 		}
 		break;
@@ -2369,11 +2397,17 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->HwIcVerUnknown = TRUE;
 		}
 		break;
+	case 0x7C800000:
+		rtl8125_get_mac_version_v2(hw);
+		break;
 	default:
+		break;
+	}
+
+exit:
+	if (hw->mcfg == CFG_METHOD_DEFAULT) {
 		PMD_INIT_LOG(NOTICE, "unknown chip version (%x)", reg);
-		hw->mcfg = CFG_METHOD_DEFAULT;
 		hw->HwIcVerUnknown = TRUE;
-		break;
 	}
 
 	if (pci_dev->id.device_id == 0x8162) {
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index 1bdc46bd17..65007c2a7e 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -45,7 +45,7 @@ void rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw);
 void rtl_write_mac_mcu_ram_code(struct rtl_hw *hw, const u16 *entry,
 				u16 entry_cnt);
 
-void rtl_hw_initialize(struct rtl_hw *hw);
+void rtl_hw_initialize(struct rtl_hw *hw, struct rte_pci_device *pci_dev);
 
 bool rtl_is_speed_mode_valid(struct rtl_hw *hw, u32 speed);
 
@@ -91,6 +91,7 @@ extern const struct rtl_hw_ops rtl8125a_ops;
 extern const struct rtl_hw_ops rtl8125b_ops;
 extern const struct rtl_hw_ops rtl8125bp_ops;
 extern const struct rtl_hw_ops rtl8125d_ops;
+extern const struct rtl_hw_ops rtl9151a_ops;
 extern const struct rtl_hw_ops rtl8126a_ops;
 extern const struct rtl_hw_ops rtl8168kb_ops;
 extern const struct rtl_hw_ops rtl8127_ops;
@@ -137,6 +138,7 @@ extern const struct rtl_hw_ops rtl8125cp_ops;
 #define NIC_RAMCODE_VERSION_CFG_METHOD_56  (0x0027)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_57  (0x0034)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_58  (0x0024)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_60  (0x0003)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_70  (0x0033)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_71  (0x0060)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_91  (0x0051)
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 8988c6f288..de6e512375 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -551,7 +551,7 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 
 	if (!hw->HwIcVerUnknown) {
 		if (!(hw->mcfg == CFG_METHOD_23 || hw->mcfg == CFG_METHOD_37 ||
-		      hw->mcfg == CFG_METHOD_91))
+		      hw->mcfg == CFG_METHOD_60 || hw->mcfg == CFG_METHOD_91))
 			RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
 	}
 
@@ -964,21 +964,9 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 		rtl_mdio_write(hw, 0x11, data);
 		rtl_mdio_write(hw, 0x1F, 0x0000);
 		break;
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-	case CFG_METHOD_58:
-	case CFG_METHOD_59:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	default:
+		if (!rtl_is_8125(hw))
+			break;
 		rtl_clear_mac_ocp_bit(hw, 0xE052, BIT_0);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA442, (BIT_12 | BIT_13));
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_15);
@@ -1062,6 +1050,7 @@ rtl_disable_eee(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
+	case CFG_METHOD_60:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
@@ -1213,18 +1202,9 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 	case CFG_METHOD_71:
 		mask |= BIT_1;
 	/* Fall through */
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-	case CFG_METHOD_58:
-	case CFG_METHOD_59:
+	default:
+		if (!rtl_is_8125(hw))
+			break;
 		mask |= BIT_0;
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, mask);
-- 
2.34.1

