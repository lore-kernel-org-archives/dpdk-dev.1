Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A09C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:41:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA6042E81;
	Tue, 10 Jun 2025 09:41:02 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 377E542E6B
 for <dev@dpdk.org>; Tue, 10 Jun 2025 09:40:58 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A7et3iB2458260,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749541256;
 bh=W16WkRrquerj5drq4cBsHc3kzMsKxtIdj1Fpzb/fqA4=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=CqP5YdRCZ+PEZjsWIkmdy0hVEMtfR+Cx61Ry0hXqrPt+sXmMq2hWScMhX3AjmYaRZ
 kxLGOp12FNQYmNgVaXD8U7fI1uZ3b0iwm2pGMP59V5O0Pg2Q2S+lNcaotJoaTOvwMH
 TfxHT8u9z2nxAeWr/EcAaydEwzUiT1PHc1+j0/IAmwGrFP4oKZbFQ9ZWY2XuZjFUbz
 ek29daWLI1ybBYN1NnD9D0Zv/lKQUasaqIBglsGVmxSKqUqOH0DMBe/zpxWF7Cxkv5
 P0dEHVJzfvWGJEgBR/xn3YSTeLbFRPCUhnkU0i0Wj5soHKblR8T7LxI4XzOvKUzPCR
 GYJF9/ST/7PgQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A7et3iB2458260
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 15:40:55 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 15:40:56 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 15:40:56 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 7/8] net/r8169: add support for RTL8127ATF serdes interface
Date: Tue, 10 Jun 2025 15:40:36 +0800
Message-ID: <20250610074037.5288-8-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610074037.5288-1-howard_wang@realsil.com.cn>
References: <20250610074037.5288-1-howard_wang@realsil.com.cn>
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
 drivers/net/r8169/meson.build    |   1 +
 drivers/net/r8169/r8169_ethdev.h |   3 +
 drivers/net/r8169/r8169_fiber.c  | 201 +++++++++++++++++++++++++++++++
 drivers/net/r8169/r8169_fiber.h  |  42 +++++++
 drivers/net/r8169/r8169_hw.c     |  93 +++++++++-----
 drivers/net/r8169/r8169_hw.h     |   2 +-
 drivers/net/r8169/r8169_phy.c    |  14 ++-
 7 files changed, 324 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/r8169/r8169_fiber.c
 create mode 100644 drivers/net/r8169/r8169_fiber.h

diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index e139452416..ed644059f5 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -7,6 +7,7 @@ sources = files(
         'r8169_rxtx.c',
         'r8169_phy.c',
         'r8169_dash.c',
+        'r8169_fiber.c',
         'base/rtl8125a.c',
         'base/rtl8125a_mcu.c',
         'base/rtl8125b.c',
diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index bc65ccf68a..84a233dfed 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -90,6 +90,9 @@ struct rtl_hw {
 	u8 AllowAccessDashOcp;
 	u8 HwPkgDet;
 	u8 HwSuppSerDesPhyVer;
+
+	/* Fiber */
+	u32 HwFiberModeVer;
 };
 
 struct rtl_sw_stats {
diff --git a/drivers/net/r8169/r8169_fiber.c b/drivers/net/r8169/r8169_fiber.c
new file mode 100644
index 0000000000..9108fa6bba
--- /dev/null
+++ b/drivers/net/r8169/r8169_fiber.c
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include <rte_ether.h>
+#include <ethdev_driver.h>
+
+#include "r8169_fiber.h"
+
+static bool
+rtl8127_wait_8127_sds_cmd_done(struct rtl_hw *hw)
+{
+	u32 timeout = 0;
+	u32 waitcount = 100;
+
+	do {
+		if (RTL_R16(hw, R8127_SDS_8127_CMD) & R8127_SDS_8127_CMD_IN)
+			rte_delay_us(1);
+		else
+			return true;
+	} while (++timeout < waitcount);
+
+	return false;
+}
+
+static u16
+rtl8127_sds_phy_read_8127(struct rtl_hw *hw, u16 index, u16 page, u16 reg)
+{
+	RTL_W16(hw, R8127_SDS_8127_ADDR,
+		R8127_MAKE_SDS_8127_ADDR(index, page, reg));
+	RTL_W16(hw, R8127_SDS_8127_CMD, R8127_SDS_8127_CMD_IN);
+
+	if (rtl8127_wait_8127_sds_cmd_done(hw))
+		return RTL_R16(hw, R8127_SDS_8127_DATA_OUT);
+	else
+		return 0xffff;
+}
+
+static void
+rtl8127_sds_phy_write_8127(struct rtl_hw *hw, u16 index, u16 page, u16 reg,
+			   u16 val)
+{
+	RTL_W16(hw, R8127_SDS_8127_DATA_IN, val);
+	RTL_W16(hw, R8127_SDS_8127_ADDR,
+		R8127_MAKE_SDS_8127_ADDR(index, page, reg));
+	RTL_W16(hw, R8127_SDS_8127_CMD,
+		R8127_SDS_8127_CMD_IN | R8127_SDS_8127_WE_IN);
+
+	rtl8127_wait_8127_sds_cmd_done(hw);
+}
+
+static void
+rtl8127_clear_and_set_sds_phy_bit(struct rtl_hw *hw, u16 index, u16 page,
+				  u16 addr, u16 clearmask, u16 setmask)
+{
+	u16 val;
+
+	val = rtl8127_sds_phy_read_8127(hw, index, page, addr);
+	val &= ~clearmask;
+	val |= setmask;
+	rtl8127_sds_phy_write_8127(hw, index, page, addr, val);
+}
+
+static void
+rtl8127_clear_sds_phy_bit(struct rtl_hw *hw, u16 index, u16 page,
+			  u16 addr, u16 mask)
+{
+	rtl8127_clear_and_set_sds_phy_bit(hw, index, page, addr, mask, 0);
+}
+
+static void
+rtl8127_set_sds_phy_bit(struct rtl_hw *hw, u16 index, u16 page, u16 addr,
+			u16 mask)
+{
+	rtl8127_clear_and_set_sds_phy_bit(hw, index, page, addr, 0, mask);
+}
+
+static void
+rtl8127_sds_phy_reset_8127(struct rtl_hw *hw)
+{
+	RTL_W8(hw, 0x2350, RTL_R8(hw, 0x2350) & ~BIT_0);
+	rte_delay_us(1);
+
+	RTL_W16(hw, 0x233A, 0x801F);
+	RTL_W8(hw, 0x2350, RTL_R8(hw, 0x2350) | BIT_0);
+	rte_delay_us(10);
+}
+
+static void
+rtl8127_sds_phy_reset(struct rtl_hw *hw)
+{
+	switch (hw->HwFiberModeVer) {
+	case FIBER_MODE_RTL8127ATF:
+		rtl8127_sds_phy_reset_8127(hw);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+rtl8127_set_sds_phy_caps_1g_8127(struct rtl_hw *hw)
+{
+	u16 val;
+
+	rtl8127_set_sds_phy_bit(hw, 0, 1, 31, BIT_3);
+	rtl8127_clear_and_set_sds_phy_bit(hw, 0, 2, 0, BIT_13 | BIT_12 | BIT_6,
+					  BIT_12 | BIT_6);
+	RTL_W16(hw, 0x233A, 0x8004);
+
+	val = RTL_R16(hw, 0x233E);
+	val &= (BIT_13 | BIT_12 | BIT_1 | BIT_0);
+	val |= BIT_1;
+	RTL_W16(hw, 0x233E, val);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC40A, 0x0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC466, 0x0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC808, 0x0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC80A, 0x0);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xC804, 0x000F, 0x000C);
+}
+
+static void
+rtl8127_sds_phy_exit_1g_8127(struct rtl_hw *hw)
+{
+	rtl8127_clear_sds_phy_bit(hw, 0, 1, 31, BIT_3);
+	rtl8127_clear_and_set_sds_phy_bit(hw, 0, 2, 0, BIT_13 | BIT_12 | BIT_6,
+					  BIT_6);
+
+	rtl8127_sds_phy_reset(hw);
+}
+
+static void
+rtl8127_set_sds_phy_caps_10g_8127(struct rtl_hw *hw)
+{
+	u16 val;
+
+	RTL_W16(hw, 0x233A, 0x801A);
+
+	val = RTL_R16(hw, 0x233E);
+	val &= (BIT_13 | BIT_12 | BIT_1 | BIT_0);
+	val |= BIT_12;
+	RTL_W16(hw, 0x233E, val);
+
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC40A, 0x0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC466, 0x3);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC808, 0x0);
+	rtl_mdio_direct_write_phy_ocp(hw, 0xC80A, 0x0);
+	rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xC804, 0x000F, 0x000C);
+}
+
+static void
+rtl8127_set_sds_phy_caps_8127(struct rtl_hw *hw)
+{
+	rtl8127_sds_phy_exit_1g_8127(hw);
+
+	switch (hw->speed) {
+	case SPEED_10000:
+		rtl8127_set_sds_phy_caps_10g_8127(hw);
+		break;
+	case SPEED_1000:
+		rtl8127_set_sds_phy_caps_1g_8127(hw);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+rtl8127_set_sds_phy_caps(struct rtl_hw *hw)
+{
+	switch (hw->HwFiberModeVer) {
+	case FIBER_MODE_RTL8127ATF:
+		rtl8127_set_sds_phy_caps_8127(hw);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+rtl8127_hw_sds_phy_config(struct rtl_hw *hw)
+{
+	rtl8127_set_sds_phy_caps(hw);
+}
+
+void
+rtl8127_hw_fiber_phy_config(struct rtl_hw *hw)
+{
+	switch (hw->HwFiberModeVer) {
+	case FIBER_MODE_RTL8127ATF:
+		rtl8127_hw_sds_phy_config(hw);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/r8169/r8169_fiber.h b/drivers/net/r8169/r8169_fiber.h
new file mode 100644
index 0000000000..52bafc7e4c
--- /dev/null
+++ b/drivers/net/r8169/r8169_fiber.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef R8169_FIBER_H
+#define R8169_FIBER_H
+
+#include <stdint.h>
+
+#include <bus_pci_driver.h>
+#include <rte_ethdev.h>
+#include <rte_ethdev_core.h>
+
+#include "r8169_compat.h"
+#include "r8169_ethdev.h"
+#include "r8169_phy.h"
+#include "r8169_hw.h"
+
+enum {
+	FIBER_MODE_NIC_ONLY = 0,
+	FIBER_MODE_RTL8127ATF,
+	FIBER_MODE_MAX
+};
+
+#define HW_FIBER_MODE_ENABLED(_M)   ((_M)->HwFiberModeVer > 0)
+
+/* sds address */
+#define R8127_SDS_8127_CMD      0x2348
+#define R8127_SDS_8127_ADDR     0x234A
+#define R8127_SDS_8127_DATA_IN  0x234C
+#define R8127_SDS_8127_DATA_OUT 0x234E
+
+#define R8127_MAKE_SDS_8127_ADDR(_index, _page, _reg) \
+	(((_index) << 11) | ((_page) << 5) | (_reg))
+
+/* sds command */
+#define R8127_SDS_8127_CMD_IN BIT_0
+#define R8127_SDS_8127_WE_IN  BIT_1
+
+void rtl8127_hw_fiber_phy_config(struct rtl_hw *hw);
+
+#endif /* R8169_FIBER_H */
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index c131353ef8..e25336ac19 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -12,6 +12,7 @@
 #include "r8169_hw.h"
 #include "r8169_logs.h"
 #include "r8169_dash.h"
+#include "r8169_fiber.h"
 
 static u32
 rtl_eri_read_with_oob_base_address(struct rtl_hw *hw, int addr, int len,
@@ -1439,18 +1440,28 @@ rtl_write_mac_mcu_ram_code(struct rtl_hw *hw, const u16 *entry, u16 entry_cnt)
 }
 
 bool
-rtl_is_speed_mode_valid(u32 speed)
-{
-	switch (speed) {
-	case SPEED_10000:
-	case SPEED_5000:
-	case SPEED_2500:
-	case SPEED_1000:
-	case SPEED_100:
-	case SPEED_10:
-		return true;
-	default:
-		return false;
+rtl_is_speed_mode_valid(struct rtl_hw *hw, u32 speed)
+{
+	if (HW_FIBER_MODE_ENABLED(hw)) {
+		switch (speed) {
+		case SPEED_10000:
+		case SPEED_1000:
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		switch (speed) {
+		case SPEED_10000:
+		case SPEED_5000:
+		case SPEED_2500:
+		case SPEED_1000:
+		case SPEED_100:
+		case SPEED_10:
+			return true;
+		default:
+			return false;
+		}
 	}
 }
 
@@ -1482,9 +1493,9 @@ void
 rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 		    enum rtl_fc_mode fc)
 {
-	u64 adv;
+	u64 adv = 0;
 
-	if (!rtl_is_speed_mode_valid(speed))
+	if (!rtl_is_speed_mode_valid(hw, speed))
 		speed = hw->HwSuppMaxPhyLinkSpeed;
 
 	if (!rtl_is_duplex_mode_valid(duplex))
@@ -1495,22 +1506,34 @@ rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 
 	speed = RTE_MIN(speed, hw->HwSuppMaxPhyLinkSpeed);
 
-	adv = 0;
-	switch (speed) {
-	case SPEED_10000:
-		adv |= ADVERTISE_10000_FULL;
-	/* Fall through */
-	case SPEED_5000:
-		adv |= ADVERTISE_5000_FULL;
-	/* Fall through */
-	case SPEED_2500:
-		adv |= ADVERTISE_2500_FULL;
-	/* Fall through */
-	default:
-		adv |= (ADVERTISE_10_HALF | ADVERTISE_10_FULL |
-			ADVERTISE_100_HALF | ADVERTISE_100_FULL |
-			ADVERTISE_1000_HALF | ADVERTISE_1000_FULL);
-		break;
+	if (HW_FIBER_MODE_ENABLED(hw)) {
+		switch (speed) {
+		case SPEED_10000:
+			adv |= ADVERTISE_10000_FULL;
+		/* Fall through */
+		case SPEED_1000:
+			adv |= ADVERTISE_1000_FULL;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (speed) {
+		case SPEED_10000:
+			adv |= ADVERTISE_10000_FULL;
+		/* Fall through */
+		case SPEED_5000:
+			adv |= ADVERTISE_5000_FULL;
+		/* Fall through */
+		case SPEED_2500:
+			adv |= ADVERTISE_2500_FULL;
+		/* Fall through */
+		default:
+			adv |= (ADVERTISE_10_HALF | ADVERTISE_10_FULL |
+				ADVERTISE_100_HALF | ADVERTISE_100_FULL |
+				ADVERTISE_1000_HALF | ADVERTISE_1000_FULL);
+			break;
+		}
 	}
 
 	hw->autoneg = autoneg;
@@ -1962,6 +1985,16 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_91:
+		tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
+		if (tmp == 0x07)
+			hw->HwFiberModeVer = FIBER_MODE_RTL8127ATF;
+		break;
+	default:
+		break;
+	}
+
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
 
 	hw->mtu = RTL_DEFAULT_MTU;
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index 6f2d38ac81..558ffaac95 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -47,7 +47,7 @@ void rtl_write_mac_mcu_ram_code(struct rtl_hw *hw, const u16 *entry,
 
 void rtl_hw_initialize(struct rtl_hw *hw);
 
-bool rtl_is_speed_mode_valid(u32 speed);
+bool rtl_is_speed_mode_valid(struct rtl_hw *hw, u32 speed);
 
 void rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev);
 int rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea);
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index cc06c7b55a..e547b44137 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -14,6 +14,7 @@
 #include "r8169_phy.h"
 #include "r8169_logs.h"
 #include "r8169_dash.h"
+#include "r8169_fiber.h"
 
 static u16
 rtl_map_phy_ocp_addr(u16 PageNum, u8 RegNum)
@@ -1327,6 +1328,9 @@ rtl_hw_phy_config(struct rtl_hw *hw)
 	if (rtl_is_8125(hw))
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5B4, BIT_15);
 
+	if (HW_FIBER_MODE_ENABLED(hw))
+		rtl8127_hw_fiber_phy_config(hw);
+
 	rtl_mdio_write(hw, 0x1F, 0x0000);
 
 	if (HW_HAS_WRITE_PHY_MCU_RAM_CODE(hw))
@@ -1424,12 +1428,15 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 		break;
 	}
 
-	if (!rtl_is_speed_mode_valid(speed)) {
+	if (!rtl_is_speed_mode_valid(hw, speed)) {
 		speed = hw->HwSuppMaxPhyLinkSpeed;
 		duplex = DUPLEX_FULL;
 		adv |= hw->advertising;
 	}
 
+	if (HW_FIBER_MODE_ENABLED(hw))
+		goto set_speed;
+
 	giga_ctrl = rtl_mdio_read(hw, MII_CTRL1000);
 	giga_ctrl &= ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
 	if (rtl_is_8125(hw)) {
@@ -1482,11 +1489,16 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u64 adv)
 		else
 			goto out;
 	}
+
+set_speed:
 	hw->autoneg = autoneg;
 	hw->speed = speed;
 	hw->duplex = duplex;
 	hw->advertising = adv;
 
+	if (HW_FIBER_MODE_ENABLED(hw))
+		rtl8127_hw_fiber_phy_config(hw);
+
 	rc = 0;
 out:
 	return rc;
-- 
2.34.1

