Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E6C02198
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 03:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D35C427A9;
	Fri,  7 Feb 2025 04:19:24 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 8C490427A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 04:19:22 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5173JJRq8211784,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
 s=dkim; t=1738898360;
 bh=mP3TO6NuYFAp7xXwJFcvSbtl8O1RBU9N03iuo09nKoY=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=kxC83yVCt5oKJUeL5uhuF2GtQt4TPWu7lHavR/y7E/qdKf8LR4oJQaGh7sVXcSX5f
 7i2rgOFXzbM/+W6d+/Kbr7EHxl8NpOgYS4hgm9nTdFKsHoWba1+FaxdsfJCYs11qJm
 6jsNNlrl692jRXHHpal/xoOIe9ucYTgMxX9GU4J8wHIObN/F/A1Q90Z9q1Zjue+eOJ
 T8KWYZT16a0Tvrxh4ww0P1BJ1Gk1o67m8YDsIGb13iNb/9QUzFiCKOzLThjfN7mlbK
 ltaE+OmZgLsP6hx3yhAuDS90OZzeL7J9+05XKVK721w74ryR5HNz3TbDuloFZWuUrq
 tmsQaHNcKzwbQ==
Received: from RSEXH36501.realsil.com.cn (rsl1.realsil.com.cn[172.29.17.2])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5173JJRq8211784
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <dev@dpdk.org>; Fri, 7 Feb 2025 11:19:20 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RSEXH36501.realsil.com.cn (172.29.17.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:20 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:19 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Feb 2025 11:19:19 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 2/2] net/r8169: add support for RTL8168KB
Date: Fri, 7 Feb 2025 11:18:45 +0800
Message-ID: <20250207031845.22168-3-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207031845.22168-1-howard_wang@realsil.com.cn>
References: <20250207031845.22168-1-howard_wang@realsil.com.cn>
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

The RTL8168 series are Realtek 1G network cards, but the RTL8168KB is
significantly different from other 1G network cards in the Linux kernel
driver, so it is added separately.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 doc/guides/nics/r8169.rst                     |   5 +-
 drivers/net/r8169/base/rtl8125a.c             |   4 +-
 .../r8169/base/{rtl8125a_mcu.h => rtl8125a.h} |   8 +-
 drivers/net/r8169/base/rtl8125a_mcu.c         |   2 +-
 drivers/net/r8169/base/rtl8125b.c             |   4 +-
 .../r8169/base/{rtl8125b_mcu.h => rtl8125b.h} |   8 +-
 drivers/net/r8169/base/rtl8125b_mcu.c         |   2 +-
 drivers/net/r8169/base/rtl8168kb.c            | 123 ++++++++++++++++++
 drivers/net/r8169/meson.build                 |   3 +-
 drivers/net/r8169/r8169_ethdev.c              |   2 +
 drivers/net/r8169/r8169_hw.c                  |  16 ++-
 drivers/net/r8169/r8169_hw.h                  |   1 +
 12 files changed, 159 insertions(+), 19 deletions(-)
 rename drivers/net/r8169/base/{rtl8125a_mcu.h => rtl8125a.h} (72%)
 rename drivers/net/r8169/base/{rtl8125b_mcu.h => rtl8125b.h} (72%)
 create mode 100644 drivers/net/r8169/base/rtl8168kb.c

diff --git a/doc/guides/nics/r8169.rst b/doc/guides/nics/r8169.rst
index 0554b9b1bb..c512406a60 100644
--- a/doc/guides/nics/r8169.rst
+++ b/doc/guides/nics/r8169.rst
@@ -4,8 +4,8 @@
 R8169 Poll Mode Driver
 ======================
 
-The R8169 PMD provides poll mode driver support for Realtek 2.5 and 5 Gigabit
-Ethernet NICs.
+The R8169 PMD provides poll mode driver support for Realtek 1, 2.5
+and 5 Gigabit Ethernet NICs.
 
 More information about Realtek 2.5G Ethernet NIC can be found at `RTL8125
 <https://www.realtek.com/Product/Index?id=3962&cate_id=786&menu_id=1010>`_.
@@ -15,6 +15,7 @@ More information about Realtek 5G Ethernet NIC can be found at `RTL8126
 Supported Chipsets and NICs
 ---------------------------
 
+- Realtek RTL8168 1 Gigabit Ethernet Controller
 - Realtek RTL8125 2.5 Gigabit Ethernet Controller
 - Realtek RTL8126 5 Gigabit Ethernet Controller
 
diff --git a/drivers/net/r8169/base/rtl8125a.c b/drivers/net/r8169/base/rtl8125a.c
index e8c30d69cb..39ab308d51 100644
--- a/drivers/net/r8169/base/rtl8125a.c
+++ b/drivers/net/r8169/base/rtl8125a.c
@@ -5,7 +5,7 @@
 #include "../r8169_ethdev.h"
 #include "../r8169_hw.h"
 #include "../r8169_phy.h"
-#include "rtl8125a_mcu.h"
+#include "rtl8125a.h"
 
 /* For RTL8125A, CFG_METHOD_48,49 */
 
@@ -139,7 +139,7 @@ rtl_hw_phy_config_8125a_1(struct rtl_hw *hw)
 	rtl_set_eth_phy_ocp_bit(hw, 0xA442, BIT_11);
 }
 
-static void
+void
 rtl_hw_phy_config_8125a_2(struct rtl_hw *hw)
 {
 	u16 adccal_offset_p0;
diff --git a/drivers/net/r8169/base/rtl8125a_mcu.h b/drivers/net/r8169/base/rtl8125a.h
similarity index 72%
rename from drivers/net/r8169/base/rtl8125a_mcu.h
rename to drivers/net/r8169/base/rtl8125a.h
index 79cf848220..0b2e0492ab 100644
--- a/drivers/net/r8169/base/rtl8125a_mcu.h
+++ b/drivers/net/r8169/base/rtl8125a.h
@@ -2,8 +2,8 @@
  * Copyright(c) 2024 Realtek Corporation. All rights reserved
  */
 
-#ifndef RTL8125A_MCU_H
-#define RTL8125A_MCU_H
+#ifndef RTL8125A_H
+#define RTL8125A_H
 
 void rtl_set_mac_mcu_8125a_1(struct rtl_hw *hw);
 void rtl_set_mac_mcu_8125a_2(struct rtl_hw *hw);
@@ -11,4 +11,6 @@ void rtl_set_mac_mcu_8125a_2(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125a_1(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125a_2(struct rtl_hw *hw);
 
-#endif /* RTL8125A_MCU_H */
+void rtl_hw_phy_config_8125a_2(struct rtl_hw *hw);
+
+#endif /* RTL8125A_H */
diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/base/rtl8125a_mcu.c
index c03da6ca6b..5a69b3e094 100644
--- a/drivers/net/r8169/base/rtl8125a_mcu.c
+++ b/drivers/net/r8169/base/rtl8125a_mcu.c
@@ -5,7 +5,7 @@
 #include "../r8169_ethdev.h"
 #include "../r8169_hw.h"
 #include "../r8169_phy.h"
-#include "rtl8125a_mcu.h"
+#include "rtl8125a.h"
 
 /* For RTL8125A, CFG_METHOD_48,49 */
 
diff --git a/drivers/net/r8169/base/rtl8125b.c b/drivers/net/r8169/base/rtl8125b.c
index bd13f363a0..353b3a2466 100644
--- a/drivers/net/r8169/base/rtl8125b.c
+++ b/drivers/net/r8169/base/rtl8125b.c
@@ -5,7 +5,7 @@
 #include "../r8169_ethdev.h"
 #include "../r8169_hw.h"
 #include "../r8169_phy.h"
-#include "rtl8125b_mcu.h"
+#include "rtl8125b.h"
 
 /* For RTL8125B, CFG_METHOD_50,51 */
 
@@ -285,7 +285,7 @@ rtl_hw_phy_config_8125b_1(struct rtl_hw *hw)
 	rtl_set_eth_phy_ocp_bit(hw, 0xA438, BIT_12);
 }
 
-static void
+void
 rtl_hw_phy_config_8125b_2(struct rtl_hw *hw)
 {
 	rtl_set_eth_phy_ocp_bit(hw, 0xA442, BIT_11);
diff --git a/drivers/net/r8169/base/rtl8125b_mcu.h b/drivers/net/r8169/base/rtl8125b.h
similarity index 72%
rename from drivers/net/r8169/base/rtl8125b_mcu.h
rename to drivers/net/r8169/base/rtl8125b.h
index 3a48100265..ec63446e89 100644
--- a/drivers/net/r8169/base/rtl8125b_mcu.h
+++ b/drivers/net/r8169/base/rtl8125b.h
@@ -2,8 +2,8 @@
  * Copyright(c) 2024 Realtek Corporation. All rights reserved
  */
 
-#ifndef RTL8125B_MCU_H
-#define RTL8125B_MCU_H
+#ifndef RTL8125B_H
+#define RTL8125B_H
 
 void rtl_set_mac_mcu_8125b_1(struct rtl_hw *hw);
 void rtl_set_mac_mcu_8125b_2(struct rtl_hw *hw);
@@ -11,4 +11,6 @@ void rtl_set_mac_mcu_8125b_2(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125b_1(struct rtl_hw *hw);
 void rtl_set_phy_mcu_8125b_2(struct rtl_hw *hw);
 
-#endif /* RTL8125B_MCU_H */
+void rtl_hw_phy_config_8125b_2(struct rtl_hw *hw);
+
+#endif /* RTL8125B_H */
diff --git a/drivers/net/r8169/base/rtl8125b_mcu.c b/drivers/net/r8169/base/rtl8125b_mcu.c
index 174d589377..03b004b430 100644
--- a/drivers/net/r8169/base/rtl8125b_mcu.c
+++ b/drivers/net/r8169/base/rtl8125b_mcu.c
@@ -5,7 +5,7 @@
 #include "../r8169_ethdev.h"
 #include "../r8169_hw.h"
 #include "../r8169_phy.h"
-#include "rtl8125b_mcu.h"
+#include "rtl8125b.h"
 
 /* For RTL8125B, CFG_METHOD_50,51 */
 
diff --git a/drivers/net/r8169/base/rtl8168kb.c b/drivers/net/r8169/base/rtl8168kb.c
new file mode 100644
index 0000000000..1131f69856
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168kb.c
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8125a.h"
+#include "rtl8125b.h"
+
+/* For RTL8168KB, CFG_METHOD_52,53 */
+
+static void
+hw_init_rxcfg_8168kb(struct rtl_hw *hw)
+{
+	if (hw->mcfg == CFG_METHOD_52)
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 |
+			(RX_DMA_BURST_256 << RxCfgDMAShift));
+	else if (hw->mcfg == CFG_METHOD_53)
+		RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | RxCfg_pause_slot_en |
+			(RX_DMA_BURST_256 << RxCfgDMAShift));
+}
+
+static void
+hw_ephy_config_8168kb(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_52:
+		rtl_ephy_write(hw, 0x04, 0xD000);
+		rtl_ephy_write(hw, 0x0A, 0x8653);
+		rtl_ephy_write(hw, 0x23, 0xAB66);
+		rtl_ephy_write(hw, 0x20, 0x9455);
+		rtl_ephy_write(hw, 0x21, 0x99FF);
+		rtl_ephy_write(hw, 0x29, 0xFE04);
+
+		rtl_ephy_write(hw, 0x44, 0xD000);
+		rtl_ephy_write(hw, 0x4A, 0x8653);
+		rtl_ephy_write(hw, 0x63, 0xAB66);
+		rtl_ephy_write(hw, 0x60, 0x9455);
+		rtl_ephy_write(hw, 0x61, 0x99FF);
+		rtl_ephy_write(hw, 0x69, 0xFE04);
+
+		rtl_clear_and_set_pcie_phy_bit(hw, 0x2A, (BIT_14 | BIT_13 | BIT_12),
+					       (BIT_13 | BIT_12));
+		rtl_clear_pcie_phy_bit(hw, 0x19, BIT_6);
+		rtl_set_pcie_phy_bit(hw, 0x1B, (BIT_11 | BIT_10 | BIT_9));
+		rtl_clear_pcie_phy_bit(hw, 0x1B, (BIT_14 | BIT_13 | BIT_12));
+		rtl_ephy_write(hw, 0x02, 0x6042);
+		rtl_ephy_write(hw, 0x06, 0x0014);
+
+		rtl_clear_and_set_pcie_phy_bit(hw, 0x6A, (BIT_14 | BIT_13 | BIT_12),
+					       (BIT_13 | BIT_12));
+		rtl_clear_pcie_phy_bit(hw, 0x59, BIT_6);
+		rtl_set_pcie_phy_bit(hw, 0x5B, (BIT_11 | BIT_10 | BIT_9));
+		rtl_clear_pcie_phy_bit(hw, 0x5B, (BIT_14 | BIT_13 | BIT_12));
+		rtl_ephy_write(hw, 0x42, 0x6042);
+		rtl_ephy_write(hw, 0x46, 0x0014);
+		break;
+	case CFG_METHOD_53:
+		rtl_ephy_write(hw, 0x0B, 0xA908);
+		rtl_ephy_write(hw, 0x1E, 0x20EB);
+		rtl_ephy_write(hw, 0x22, 0x0023);
+		rtl_ephy_write(hw, 0x02, 0x60C2);
+		rtl_ephy_write(hw, 0x29, 0xFF00);
+
+		rtl_ephy_write(hw, 0x4B, 0xA908);
+		rtl_ephy_write(hw, 0x5E, 0x28EB);
+		rtl_ephy_write(hw, 0x62, 0x0023);
+		rtl_ephy_write(hw, 0x42, 0x60C2);
+		rtl_ephy_write(hw, 0x69, 0xFF00);
+		break;
+	}
+}
+
+static void
+hw_phy_config_8168kb(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_52:
+		rtl_hw_phy_config_8125a_2(hw);
+		break;
+	case CFG_METHOD_53:
+		rtl_hw_phy_config_8125b_2(hw);
+		break;
+	}
+}
+
+static void
+hw_mac_mcu_config_8168kb(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_52:
+		rtl_set_mac_mcu_8125a_2(hw);
+		break;
+	case CFG_METHOD_53:
+		rtl_set_mac_mcu_8125b_2(hw);
+		break;
+	}
+}
+
+static void
+hw_phy_mcu_config_8168kb(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_52:
+		rtl_set_phy_mcu_8125a_2(hw);
+		break;
+	case CFG_METHOD_53:
+		rtl_set_phy_mcu_8125b_2(hw);
+		break;
+	}
+}
+
+const struct rtl_hw_ops rtl8168kb_ops = {
+	.hw_init_rxcfg     = hw_init_rxcfg_8168kb,
+	.hw_ephy_config    = hw_ephy_config_8168kb,
+	.hw_phy_config     = hw_phy_config_8168kb,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168kb,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168kb,
+};
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index 6cb882f1da..d1e65377a3 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -17,4 +17,5 @@ sources = files(
         'base/rtl8125d_mcu.c',
         'base/rtl8126a.c',
         'base/rtl8126a_mcu.c',
-)
+        'base/rtl8168kb.c',
+)
\ No newline at end of file
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index b9db2e305a..c0cac6e7d8 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -378,6 +378,8 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	/* fallthrough */
 	case RTL8125A:
 	case RTL8125B:
+	case RTL8125BP:
+	case RTL8125D:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_2_5G;
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 8dec0a7d07..63a20a733e 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -79,7 +79,8 @@ rtl_eri_read_with_oob_base_address(struct rtl_hw *hw, int addr, int len,
 
 static int
 rtl_eri_write_with_oob_base_address(struct rtl_hw *hw, int addr,
-				    int len, u32 value, int type, const u32 base_address)
+				    int len, u32 value, int type,
+				    const u32 base_address)
 {
 	int i, val_shift, shift = 0;
 	u32 value1 = 0;
@@ -160,7 +161,8 @@ rtl_ocp_read(struct rtl_hw *hw, u16 addr, u8 len)
 		return 0xffffffff;
 
 	if (hw->HwSuppOcpChannelVer == 2)
-		value = rtl_ocp_read_with_oob_base_address(hw, addr, len, NO_BASE_ADDRESS);
+		value = rtl_ocp_read_with_oob_base_address(hw, addr, len,
+							   NO_BASE_ADDRESS);
 
 	return value;
 }
@@ -180,7 +182,8 @@ rtl_ocp_write(struct rtl_hw *hw, u16 addr, u8 len, u32 value)
 		return;
 
 	if (hw->HwSuppOcpChannelVer == 2)
-		rtl_ocp_write_with_oob_base_address(hw, addr, len, value, NO_BASE_ADDRESS);
+		rtl_ocp_write_with_oob_base_address(hw, addr, len, value,
+						    NO_BASE_ADDRESS);
 }
 
 void
@@ -816,6 +819,11 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_51:
 		hw->hw_ops = rtl8125b_ops;
 		return 0;
+	/* 8168KB */
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+		hw->hw_ops = rtl8168kb_ops;
+		return 0;
 	/* 8125BP */
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
@@ -1470,7 +1478,7 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 int
 rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea)
 {
-	u8 mac_addr[MAC_ADDR_LEN];
+	u8 mac_addr[MAC_ADDR_LEN] = {0};
 
 	switch (hw->mcfg) {
 	case CFG_METHOD_48 ... CFG_METHOD_57:
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index bd31ddfa58..e7c4bf1abc 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -65,6 +65,7 @@ extern const struct rtl_hw_ops rtl8125b_ops;
 extern const struct rtl_hw_ops rtl8125bp_ops;
 extern const struct rtl_hw_ops rtl8125d_ops;
 extern const struct rtl_hw_ops rtl8126a_ops;
+extern const struct rtl_hw_ops rtl8168kb_ops;
 
 #define NO_BASE_ADDRESS 0x00000000
 
-- 
2.34.1

