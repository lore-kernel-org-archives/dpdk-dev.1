Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57AC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 06:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C12042E4E;
	Tue, 10 Jun 2025 08:23:08 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id ABC4642C24
 for <dev@dpdk.org>; Tue, 10 Jun 2025 08:23:02 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A6N0YO02379769,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749536581;
 bh=Jr3Pe8pez0UI/noOZxwk47ULRJ4IQtdmktDHEZj+Nig=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=QlTPLxa7OIeHR+y+Z1Sn3l0+7UTe5PW6Jno2Ph1B8Gv+IQ3bUHifK6mVpI64O9RUp
 BC/Xapl23AOIwdy+eg0O2viqrYyVybu0jwTctSAm+I3VWfhSlaKWpVRG/ahR7dkdHw
 +nz8VaUX0DYbGgCSoXwvXLMoKd8ub6+mOBk8fh57SkRh54DsgNPkGccJcSN8mNn2oL
 naii27aygSJo5o2WQoEmFKEEbL2WwB5lFFWHQkPV8On4eg1/fs3ZqFOJAaUdz6+rfy
 GJHAiPyNItlvzjBCuhIeHqsW3CO3gL7zkoG0TGNSLJjCSBFymxiEZPjhxyIqKtoI4S
 1qPFypZNH1a+A==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A6N0YO02379769
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 14:23:00 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 14:23:00 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 14:23:00 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 6/8] net/r8169: add support for RTL8125CP
Date: Tue, 10 Jun 2025 14:22:39 +0800
Message-ID: <20250610062241.4517-7-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610062241.4517-1-howard_wang@realsil.com.cn>
References: <20250610062241.4517-1-howard_wang@realsil.com.cn>
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

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 drivers/net/r8169/base/rtl8125cp.c     | 73 ++++++++++++++++++++++++
 drivers/net/r8169/base/rtl8125cp_mcu.c | 78 ++++++++++++++++++++++++++
 drivers/net/r8169/base/rtl8125cp_mcu.h | 10 ++++
 drivers/net/r8169/meson.build          |  2 +
 drivers/net/r8169/r8169_compat.h       |  1 +
 drivers/net/r8169/r8169_ethdev.c       |  2 +
 drivers/net/r8169/r8169_hw.c           | 43 ++++++++++++--
 drivers/net/r8169/r8169_hw.h           |  2 +
 drivers/net/r8169/r8169_phy.c          | 38 ++++---------
 9 files changed, 217 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl8125cp.c
 create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.h

diff --git a/drivers/net/r8169/base/rtl8125cp.c b/drivers/net/r8169/base/rtl8125cp.c
new file mode 100644
index 0000000000..aabee94f4c
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8125cp.c
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8125cp_mcu.h"
+
+/* For RTL8125CP, CFG_METHOD_58 */
+
+static void
+hw_init_rxcfg_8125cp(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Fetch_Number_8 | Rx_Close_Multiple |
+		RxCfg_pause_slot_en | (RX_DMA_BURST_256 << RxCfgDMAShift));
+}
+
+static void
+hw_ephy_config_8125cp(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_58:
+		/* nothing to do */
+		break;
+	}
+}
+
+static void
+rtl_hw_phy_config_8125cp_1(struct rtl_hw *hw)
+{
+	rtl_set_eth_phy_ocp_bit(hw, 0xA442, BIT_11);
+
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xad0e, 0x007F, 0x000B);
+	rtl_set_eth_phy_ocp_bit(hw, 0xad78, BIT_4);
+}
+
+static void
+hw_phy_config_8125cp(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_58:
+		rtl_hw_phy_config_8125cp_1(hw);
+		break;
+	}
+}
+
+static void
+hw_mac_mcu_config_8125cp(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+}
+
+static void
+hw_phy_mcu_config_8125cp(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_58:
+		rtl_set_phy_mcu_8125cp_1(hw);
+		break;
+	}
+}
+
+const struct rtl_hw_ops rtl8125cp_ops = {
+	.hw_init_rxcfg     = hw_init_rxcfg_8125cp,
+	.hw_ephy_config    = hw_ephy_config_8125cp,
+	.hw_phy_config     = hw_phy_config_8125cp,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8125cp,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8125cp,
+};
diff --git a/drivers/net/r8169/base/rtl8125cp_mcu.c b/drivers/net/r8169/base/rtl8125cp_mcu.c
new file mode 100644
index 0000000000..e4609f46de
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8125cp_mcu.c
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_ethdev.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8125cp_mcu.h"
+
+/* For RTL8125CP, CFG_METHOD_58 */
+
+/* ------------------------------------MAC 8125CP------------------------------------- */
+
+/* No mac mcu patch code */
+
+/* ------------------------------------PHY 8125CP------------------------------------- */
+
+static const u16 phy_mcu_ram_code_8125cp_1_1[] = {
+	0xa436, 0x8023, 0xa438, 0x2300, 0xa436, 0xB82E, 0xa438, 0x0001,
+	0xb820, 0x0090, 0xa436, 0xA016, 0xa438, 0x0000, 0xa436, 0xA012,
+	0xa438, 0x07f8, 0xa436, 0xA014, 0xa438, 0xcc01, 0xa438, 0x2166,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000, 0xa438, 0x0000,
+	0xa438, 0x0000, 0xa438, 0x0000, 0xa436, 0xA152, 0xa438, 0x021c,
+	0xa436, 0xA154, 0xa438, 0x2170, 0xa436, 0xA156, 0xa438, 0x3fff,
+	0xa436, 0xA158, 0xa438, 0x3fff, 0xa436, 0xA15A, 0xa438, 0x3fff,
+	0xa436, 0xA15C, 0xa438, 0x3fff, 0xa436, 0xA15E, 0xa438, 0x3fff,
+	0xa436, 0xA160, 0xa438, 0x3fff, 0xa436, 0xA150, 0xa438, 0x0003,
+	0xa436, 0xA016, 0xa438, 0x0020, 0xa436, 0xA012, 0xa438, 0x0000,
+	0xa436, 0xA014, 0xa438, 0x1800, 0xa438, 0x8010, 0xa438, 0x1800,
+	0xa438, 0x801b, 0xa438, 0x1800, 0xa438, 0x802b, 0xa438, 0x1800,
+	0xa438, 0x8031, 0xa438, 0x1800, 0xa438, 0x8031, 0xa438, 0x1800,
+	0xa438, 0x8031, 0xa438, 0x1800, 0xa438, 0x8031, 0xa438, 0x1800,
+	0xa438, 0x8031, 0xa438, 0x800a, 0xa438, 0x8530, 0xa438, 0x0c03,
+	0xa438, 0x1502, 0xa438, 0x8d10, 0xa438, 0x9503, 0xa438, 0xd700,
+	0xa438, 0x6050, 0xa438, 0xaa20, 0xa438, 0x1800, 0xa438, 0x0d53,
+	0xa438, 0xd707, 0xa438, 0x40f6, 0xa438, 0x8901, 0xa438, 0xd704,
+	0xa438, 0x6091, 0xa438, 0x8306, 0xa438, 0x8b02, 0xa438, 0x8290,
+	0xa438, 0x1000, 0xa438, 0x0e4d, 0xa438, 0x1000, 0xa438, 0x1277,
+	0xa438, 0xd704, 0xa438, 0x7e77, 0xa438, 0x1800, 0xa438, 0x0dc5,
+	0xa438, 0xd700, 0xa438, 0x4063, 0xa438, 0x1800, 0xa438, 0x0d15,
+	0xa438, 0x1800, 0xa438, 0x0d18, 0xa436, 0xA10E, 0xa438, 0xffff,
+	0xa436, 0xA10C, 0xa438, 0xffff, 0xa436, 0xA10A, 0xa438, 0xffff,
+	0xa436, 0xA108, 0xa438, 0xffff, 0xa436, 0xA106, 0xa438, 0xffff,
+	0xa436, 0xA104, 0xa438, 0x0d13, 0xa436, 0xA102, 0xa438, 0x0dbf,
+	0xa436, 0xA100, 0xa438, 0x0d52, 0xa436, 0xA110, 0xa438, 0x0007,
+	0xa436, 0xb87c, 0xa438, 0x85bd, 0xa436, 0xb87e, 0xa438, 0xaf85,
+	0xa438, 0xd5af, 0xa438, 0x85fb, 0xa438, 0xaf85, 0xa438, 0xfbaf,
+	0xa438, 0x85fb, 0xa438, 0xaf85, 0xa438, 0xfbaf, 0xa438, 0x85fb,
+	0xa438, 0xaf85, 0xa438, 0xfbaf, 0xa438, 0x85fb, 0xa438, 0xac28,
+	0xa438, 0x0bd4, 0xa438, 0x0294, 0xa438, 0xbf85, 0xa438, 0xf802,
+	0xa438, 0x61c2, 0xa438, 0xae09, 0xa438, 0xd414, 0xa438, 0x50bf,
+	0xa438, 0x85f8, 0xa438, 0x0261, 0xa438, 0xc2bf, 0xa438, 0x60de,
+	0xa438, 0x0261, 0xa438, 0xe1bf, 0xa438, 0x80cf, 0xa438, 0xaf24,
+	0xa438, 0xe8f0, 0xa438, 0xac52, 0xa436, 0xb85e, 0xa438, 0x24e5,
+	0xa436, 0xb860, 0xa438, 0xffff, 0xa436, 0xb862, 0xa438, 0xffff,
+	0xa436, 0xb864, 0xa438, 0xffff, 0xa436, 0xb886, 0xa438, 0xffff,
+	0xa436, 0xb888, 0xa438, 0xffff, 0xa436, 0xb88a, 0xa438, 0xffff,
+	0xa436, 0xb88c, 0xa438, 0xffff, 0xa436, 0xb838, 0xa438, 0x0001,
+	0xb820, 0x0010, 0xB82E, 0x0000, 0xa436, 0x8023, 0xa438, 0x0000,
+	0xB820, 0x0000, 0xFFFF, 0xFFFF
+};
+
+static void
+rtl_real_set_phy_mcu_8125cp_1_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_ram_code(hw, phy_mcu_ram_code_8125cp_1_1,
+				 ARRAY_SIZE(phy_mcu_ram_code_8125cp_1_1));
+}
+
+void
+rtl_set_phy_mcu_8125cp_1(struct rtl_hw *hw)
+{
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_real_set_phy_mcu_8125cp_1_1(hw);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
diff --git a/drivers/net/r8169/base/rtl8125cp_mcu.h b/drivers/net/r8169/base/rtl8125cp_mcu.h
new file mode 100644
index 0000000000..8114dab2b9
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8125cp_mcu.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef RTL8125CP_MCU_H
+#define RTL8125CP_MCU_H
+
+void rtl_set_phy_mcu_8125cp_1(struct rtl_hw *hw);
+
+#endif /* RTL8125CP_MCU_H */
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index 5662ecf0f5..e139452416 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -15,6 +15,8 @@ sources = files(
         'base/rtl8125bp_mcu.c',
         'base/rtl8125d.c',
         'base/rtl8125d_mcu.c',
+        'base/rtl8125cp.c',
+        'base/rtl8125cp_mcu.c',
         'base/rtl8126a.c',
         'base/rtl8126a_mcu.c',
         'base/rtl8168kb.c',
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 8d06120518..e085f6242a 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -514,6 +514,7 @@ enum RTL_chipset_name {
 	RTL8168KB,
 	RTL8125BP,
 	RTL8125D,
+	RTL8125CP,
 	RTL8126A,
 	RTL8168EP,
 	RTL8168FP,
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 1f4c7eb885..8071e14412 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -160,6 +160,7 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		case CFG_METHOD_55:
 		case CFG_METHOD_56:
 		case CFG_METHOD_57:
+		case CFG_METHOD_58:
 			speed_mode = SPEED_2500;
 			break;
 		case CFG_METHOD_69:
@@ -435,6 +436,7 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	case RTL8125B:
 	case RTL8125BP:
 	case RTL8125D:
+	case RTL8125CP:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_2_5G;
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index e5a45f6810..c131353ef8 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -334,6 +334,7 @@ rtl_oob_mutex_lock(struct rtl_hw *hw)
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_58:
 	case CFG_METHOD_91:
 		ocp_reg_mutex_oob = 0x110;
 		ocp_reg_mutex_ib = 0x114;
@@ -393,6 +394,7 @@ rtl_oob_mutex_unlock(struct rtl_hw *hw)
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_58:
 	case CFG_METHOD_91:
 		ocp_reg_mutex_ib = 0x114;
 		ocp_reg_mutex_prio = 0x11C;
@@ -645,6 +647,7 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -698,6 +701,7 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -807,6 +811,7 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 		if (enable) {
 			RTL_W8(hw, Config2, RTL_R8(hw, Config2) | BIT_7);
@@ -818,6 +823,7 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 		break;
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
+	case CFG_METHOD_91:
 		if (enable) {
 			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) | BIT_3);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
@@ -877,6 +883,7 @@ rtl_hw_clear_timer_int(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -999,6 +1006,7 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -1006,18 +1014,14 @@ rtl8125_hw_config(struct rtl_hw *hw)
 		break;
 	}
 
-	if (hw->mcfg >= CFG_METHOD_91) {
+	if (hw->mcfg == CFG_METHOD_58 || hw->mcfg == CFG_METHOD_91) {
 		rtl_clear_mac_ocp_bit(hw, 0xE00C, BIT_12);
 		rtl_clear_mac_ocp_bit(hw, 0xC0C2, BIT_6);
 	}
 
 	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE63E);
 	mac_ocp_data &= ~(BIT_5 | BIT_4);
-	if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
-	    hw->mcfg == CFG_METHOD_52 || hw->mcfg == CFG_METHOD_69 ||
-	    hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
-	    hw->mcfg == CFG_METHOD_91)
-		mac_ocp_data |= ((0x02 & 0x03) << 4);
+	mac_ocp_data |= ((0x02 & 0x03) << 4);
 	rtl_mac_ocp_write(hw, 0xE63E, mac_ocp_data);
 
 	/*
@@ -1279,6 +1283,10 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 		hw->hw_ops = rtl8125d_ops;
 		return 0;
+	/* 8125CP */
+	case CFG_METHOD_58:
+		hw->hw_ops = rtl8125cp_ops;
+		return 0;
 	/* 8126A */
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
@@ -1324,6 +1332,7 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1531,6 +1540,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 		speed_mode = SPEED_2500;
 		break;
 	case CFG_METHOD_69:
@@ -1606,6 +1616,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_28:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_58:
 		hw->HwSuppOcpChannelVer = 2;
 		break;
 	case CFG_METHOD_31:
@@ -1683,6 +1694,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 		hw->chipset_name = RTL8125D;
 		break;
+	case CFG_METHOD_58:
+		hw->chipset_name = RTL8125CP;
+		break;
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1728,6 +1742,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1745,6 +1760,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_2500;
 		break;
 	case CFG_METHOD_69:
@@ -1773,6 +1789,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_91:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
@@ -1882,6 +1899,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_57;
 		break;
+	case CFG_METHOD_58:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_58;
+		break;
 	case CFG_METHOD_69:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_69;
 		break;
@@ -1932,6 +1952,7 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_91:
 		hw->HwSuppIntMitiVer = 6;
 		break;
@@ -1976,6 +1997,7 @@ rtl_exit_realwow(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -2108,6 +2130,7 @@ rtl_disable_ups(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -2477,6 +2500,14 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->HwIcVerUnknown = TRUE;
 		}
 		break;
+	case 0x70800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_58;
+		} else {
+			hw->mcfg = CFG_METHOD_58;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
 	case 0x64800000:
 		if (ic_version_id == 0x00000000) {
 			hw->mcfg = CFG_METHOD_69;
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index f775c1a547..6f2d38ac81 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -91,6 +91,7 @@ extern const struct rtl_hw_ops rtl8125d_ops;
 extern const struct rtl_hw_ops rtl8126a_ops;
 extern const struct rtl_hw_ops rtl8168kb_ops;
 extern const struct rtl_hw_ops rtl8127_ops;
+extern const struct rtl_hw_ops rtl8125cp_ops;
 
 #define NO_BASE_ADDRESS       0x00000000
 #define RTL8168FP_OOBMAC_BASE 0xBAF70000
@@ -132,6 +133,7 @@ extern const struct rtl_hw_ops rtl8127_ops;
 #define NIC_RAMCODE_VERSION_CFG_METHOD_55  (0x0001)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_56  (0x0027)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_57  (0x0027)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_58  (0x0008)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_69  (0x0023)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_70  (0x0033)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_71  (0x0060)
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 677bca7800..cc06c7b55a 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -495,6 +495,7 @@ rtl_wait_phy_ups_resume(struct rtl_hw *hw, u16 PhyState)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -529,32 +530,7 @@ rtl_phy_power_up(struct rtl_hw *hw)
 	}
 
 	/* Wait ups resume (phy state 3) */
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
-		rtl_wait_phy_ups_resume(hw, 3);
-		break;
-	}
+	rtl_wait_phy_ups_resume(hw, 3);
 }
 
 void
@@ -586,6 +562,7 @@ rtl_powerup_pll(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -652,6 +629,7 @@ rtl_phy_power_down(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -699,6 +677,7 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 		case CFG_METHOD_55:
 		case CFG_METHOD_56:
 		case CFG_METHOD_57:
+		case CFG_METHOD_58:
 		case CFG_METHOD_69:
 		case CFG_METHOD_70:
 		case CFG_METHOD_71:
@@ -738,6 +717,7 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1103,6 +1083,7 @@ rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 	case CFG_METHOD_53:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1187,6 +1168,9 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 	case CFG_METHOD_53:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
@@ -1272,6 +1256,7 @@ rtl_disable_eee(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
@@ -1432,6 +1417,7 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 	case CFG_METHOD_55:
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+	case CFG_METHOD_58:
 		mask |= BIT_0;
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, mask);
-- 
2.34.1

