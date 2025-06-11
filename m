Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66DC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 03:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 805E7402E7;
	Wed, 11 Jun 2025 05:10:15 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 0DC24402E5
 for <dev@dpdk.org>; Wed, 11 Jun 2025 05:10:12 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3AA7304079682,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749611411;
 bh=y/WP3nQmE33twDnA1WQHLqQruz+UmLz4phwyF11yo+Y=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=vwkhqQvWELjRpR/5m5TmoLL9M+I/JudseqgXnLZcOKsnCrFd78zSQZGQxi1BJlGfx
 WJYjpC947OtHkenJI642e/6yVL+dbc/lwLHnyGuWLx8m1LYN/P5mOgOkImRuwjQ9dd
 zE8Zn3FNYfCi/pXres3qsA4H5ZMdncfkcOZSG8iusYZQM9y2l9VZP8pgObTtSgcS3+
 7hksArgNPiXQfOKIfx5FhnNym0ZYWTuZR+7cnd9atPe8cFmQ3XTArlEroJsC28nx0U
 h9kxn4ItvvdS9gXyc+Yf45Ak18l8fM2cWrpgcOiVlIqe9YK0eQQ6o/iv2rBpW/BGy6
 0sFU2Dz/8pI2A==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3AA7304079682
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:10:10 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 11:10:09 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 11 Jun 2025 11:10:09 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v3 1/8] net/r8169: add support for RTL8168 series
Date: Wed, 11 Jun 2025 11:09:54 +0800
Message-ID: <20250611031001.20306-2-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611031001.20306-1-howard_wang@realsil.com.cn>
References: <20250611031001.20306-1-howard_wang@realsil.com.cn>
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

This patch adds support for RTL8168EP, RTL8168FP, RTL8168G, RTL8168H
and RTL8168M.

Signed-off-by: Howard Wang <howard_wang@realsil.com.cn>
---
 doc/guides/nics/r8169.rst              |    4 +
 drivers/net/r8169/base/rtl8125a_mcu.c  |    7 +-
 drivers/net/r8169/base/rtl8126a.c      |    4 +-
 drivers/net/r8169/base/rtl8168ep.c     |  221 +++
 drivers/net/r8169/base/rtl8168ep.h     |   15 +
 drivers/net/r8169/base/rtl8168ep_mcu.c |  177 +++
 drivers/net/r8169/base/rtl8168fp.c     |  195 +++
 drivers/net/r8169/base/rtl8168fp.h     |   14 +
 drivers/net/r8169/base/rtl8168fp_mcu.c |  270 ++++
 drivers/net/r8169/base/rtl8168g.c      |  297 ++++
 drivers/net/r8169/base/rtl8168g.h      |   15 +
 drivers/net/r8169/base/rtl8168g_mcu.c  | 1936 ++++++++++++++++++++++++
 drivers/net/r8169/base/rtl8168h.c      |  447 ++++++
 drivers/net/r8169/base/rtl8168h.h      |   21 +
 drivers/net/r8169/base/rtl8168h_mcu.c  | 1186 +++++++++++++++
 drivers/net/r8169/base/rtl8168m.c      |   19 +
 drivers/net/r8169/meson.build          |    9 +
 drivers/net/r8169/r8169_compat.h       |   25 +-
 drivers/net/r8169/r8169_dash.c         |  439 +++++-
 drivers/net/r8169/r8169_dash.h         |    8 +-
 drivers/net/r8169/r8169_ethdev.c       |  179 ++-
 drivers/net/r8169/r8169_ethdev.h       |   32 +-
 drivers/net/r8169/r8169_hw.c           | 1713 +++++++++++++++++++--
 drivers/net/r8169/r8169_hw.h           |   56 +-
 drivers/net/r8169/r8169_phy.c          | 1024 +++++++++++--
 drivers/net/r8169/r8169_phy.h          |   11 +
 drivers/net/r8169/r8169_rxtx.c         |  317 +++-
 27 files changed, 8261 insertions(+), 380 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl8168ep.c
 create mode 100644 drivers/net/r8169/base/rtl8168ep.h
 create mode 100644 drivers/net/r8169/base/rtl8168ep_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168fp.c
 create mode 100644 drivers/net/r8169/base/rtl8168fp.h
 create mode 100644 drivers/net/r8169/base/rtl8168fp_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168g.c
 create mode 100644 drivers/net/r8169/base/rtl8168g.h
 create mode 100644 drivers/net/r8169/base/rtl8168g_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168h.c
 create mode 100644 drivers/net/r8169/base/rtl8168h.h
 create mode 100644 drivers/net/r8169/base/rtl8168h_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168m.c

diff --git a/doc/guides/nics/r8169.rst b/doc/guides/nics/r8169.rst
index bffdfc91cf..f3c547c4d4 100644
--- a/doc/guides/nics/r8169.rst
+++ b/doc/guides/nics/r8169.rst
@@ -7,8 +7,12 @@ R8169 Poll Mode Driver
 The R8169 PMD provides poll mode driver support for Realtek 1, 2.5 and 5 Gigabit
 Ethernet NICs.
 
+More information about Realtek 1G Ethernet NIC can be found at `RTL8168
+<https://www.realtek.com/Product/Index?id=4080>`_.
+
 More information about Realtek 2.5G Ethernet NIC can be found at `RTL8125
 <https://www.realtek.com/Product/Index?id=3962&cate_id=786&menu_id=1010>`_.
+
 More information about Realtek 5G Ethernet NIC can be found at `RTL8126
 <https://www.realtek.com/Product/ProductHitsDetail?id=4425&menu_id=643>`_.
 
diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/base/rtl8125a_mcu.c
index 5a69b3e094..e2d56102fb 100644
--- a/drivers/net/r8169/base/rtl8125a_mcu.c
+++ b/drivers/net/r8169/base/rtl8125a_mcu.c
@@ -162,7 +162,12 @@ static void
 rtl_release_phy_mcu_patch_key_lock(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x0000);
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0000);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xB82E, BIT_0);
diff --git a/drivers/net/r8169/base/rtl8126a.c b/drivers/net/r8169/base/rtl8126a.c
index 69fe7bc030..84354b6d32 100644
--- a/drivers/net/r8169/base/rtl8126a.c
+++ b/drivers/net/r8169/base/rtl8126a.c
@@ -29,7 +29,9 @@ static void
 hw_ephy_config_8126a(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		/* nothing to do */
 		break;
 	}
diff --git a/drivers/net/r8169/base/rtl8168ep.c b/drivers/net/r8169/base/rtl8168ep.c
new file mode 100644
index 0000000000..5f955d2b0d
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168ep.c
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168ep.h"
+
+/* For RTL8168EP, CFG_METHOD_23,27,28 */
+
+static void
+hw_init_rxcfg_8168ep(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Single_fetch_V2 |
+		(RX_DMA_BURST_unlimited << RxCfgDMAShift) | RxEarly_off_V2);
+}
+
+static void
+hw_ephy_config_8168ep(struct rtl_hw *hw)
+{
+	u16 ephy_data;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+		rtl_ephy_write(hw, 0x00, 0x10AB);
+		rtl_ephy_write(hw, 0x06, 0xf030);
+		rtl_ephy_write(hw, 0x08, 0x2006);
+		rtl_ephy_write(hw, 0x0D, 0x1666);
+
+		ephy_data = rtl_ephy_read(hw, 0x0C);
+		ephy_data &= ~(BIT_13 | BIT_12 | BIT_11 | BIT_10 | BIT_9 |
+			       BIT_8 | BIT_7 | BIT_6 | BIT_5 | BIT_4);
+		rtl_ephy_write(hw, 0x0C, ephy_data);
+		break;
+	case CFG_METHOD_27:
+		rtl_ephy_write(hw, 0x00, 0x10A3);
+		rtl_ephy_write(hw, 0x19, 0xFC00);
+		rtl_ephy_write(hw, 0x1E, 0x20EA);
+		break;
+	case CFG_METHOD_28:
+		rtl_ephy_write(hw, 0x00, 0x10AB);
+		rtl_ephy_write(hw, 0x19, 0xFC00);
+		rtl_ephy_write(hw, 0x1E, 0x20EB);
+		rtl_ephy_write(hw, 0x0D, 0x1666);
+		rtl_clear_pcie_phy_bit(hw, 0x0B, BIT_0);
+		rtl_set_pcie_phy_bit(hw, 0x1D, BIT_14);
+		rtl_clear_and_set_pcie_phy_bit(hw, 0x0C, (BIT_13 | BIT_12 | BIT_11 |
+					       BIT_10 | BIT_8 | BIT_7 | BIT_6 | BIT_5),
+					       BIT_9 | BIT_4);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+hw_phy_config_8168ep(struct rtl_hw *hw)
+{
+	if (hw->mcfg == CFG_METHOD_23) {
+		rtl_mdio_write(hw, 0x1F, 0x0A44);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) |
+					 (BIT_3 | BIT_2));
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+
+		rtl_mdio_write(hw, 0x1F, 0x0BCC);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~BIT_8);
+		rtl_mdio_write(hw, 0x1F, 0x0A44);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_7);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_6);
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8084);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) &
+					 ~(BIT_14 | BIT_13));
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_12);
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_1);
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_0);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A4B);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_2);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8012);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) | BIT_15);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+
+		rtl_mdio_write(hw, 0x1F, 0x0C42);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x11, BIT_13, BIT_14);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	} else if (hw->mcfg == CFG_METHOD_27 || hw->mcfg == CFG_METHOD_28) {
+		rtl_mdio_write(hw, 0x1F, 0x0BCC);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~BIT_8);
+		rtl_mdio_write(hw, 0x1F, 0x0A44);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_7);
+		rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_6);
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8084);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~(BIT_14 | BIT_13));
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_12);
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_1);
+		rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_0);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8012);
+		rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) | BIT_15);
+
+		rtl_mdio_write(hw, 0x1F, 0x0C42);
+		rtl_mdio_write(hw, 0x11, (rtl_mdio_read(hw, 0x11) & ~BIT_13) | BIT_14);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x80F3);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8B00);
+		rtl_mdio_write(hw, 0x13, 0x80F0);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x3A00);
+		rtl_mdio_write(hw, 0x13, 0x80EF);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0500);
+		rtl_mdio_write(hw, 0x13, 0x80F6);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6E00);
+		rtl_mdio_write(hw, 0x13, 0x80EC);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6800);
+		rtl_mdio_write(hw, 0x13, 0x80ED);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x7C00);
+		rtl_mdio_write(hw, 0x13, 0x80F2);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xF400);
+		rtl_mdio_write(hw, 0x13, 0x80F4);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8500);
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8110);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xA800);
+		rtl_mdio_write(hw, 0x13, 0x810F);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x1D00);
+		rtl_mdio_write(hw, 0x13, 0x8111);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xF500);
+		rtl_mdio_write(hw, 0x13, 0x8113);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6100);
+		rtl_mdio_write(hw, 0x13, 0x8115);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x9200);
+		rtl_mdio_write(hw, 0x13, 0x810E);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0400);
+		rtl_mdio_write(hw, 0x13, 0x810C);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x7C00);
+		rtl_mdio_write(hw, 0x13, 0x810B);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x5A00);
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x80D1);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xFF00);
+		rtl_mdio_write(hw, 0x13, 0x80CD);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x9E00);
+		rtl_mdio_write(hw, 0x13, 0x80D3);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0E00);
+		rtl_mdio_write(hw, 0x13, 0x80D5);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xCA00);
+		rtl_mdio_write(hw, 0x13, 0x80D7);
+		rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8400);
+	}
+}
+
+static void
+hw_config_8168ep(struct rtl_hw *hw)
+{
+	u16 mac_ocp_data;
+	u32 csi_tmp;
+
+	rtl_eri_write(hw, 0xC8, 4, 0x00080002, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xCC, 1, 0x2F, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xD0, 1, 0x5F, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xE8, 4, 0x00100006, ERIAR_ExGMAC);
+
+	/* Adjust the trx fifo */
+	rtl_eri_write(hw, 0xCA, 2, 0x0370, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xEA, 1, 0x10, ERIAR_ExGMAC);
+
+	/* Disable share fifo */
+	RTL_W32(hw, TxConfig, RTL_R32(hw, TxConfig) & ~BIT_7);
+
+	csi_tmp = rtl_eri_read(hw, 0xDC, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_0;
+	rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+	csi_tmp |= BIT_0;
+	rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+
+	RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~Beacon_en);
+
+	/* EEE led enable */
+	RTL_W8(hw, 0x1B, RTL_R8(hw, 0x1B) & ~0x07);
+
+	if (hw->mcfg == CFG_METHOD_27 || hw->mcfg == CFG_METHOD_28) {
+		rtl_oob_mutex_lock(hw);
+		rtl_eri_write(hw, 0x5F0, 2, 0x4F87, ERIAR_ExGMAC);
+		rtl_oob_mutex_unlock(hw);
+	}
+
+	rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
+	rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
+
+	if (hw->mcfg == CFG_METHOD_28) {
+		mac_ocp_data = rtl_mac_ocp_read(hw, 0xD3E2);
+		mac_ocp_data &= 0xF000;
+		mac_ocp_data |= 0xAFD;
+		rtl_mac_ocp_write(hw, 0xD3E2, mac_ocp_data);
+
+		mac_ocp_data = rtl_mac_ocp_read(hw, 0xD3E4);
+		mac_ocp_data &= 0xFF00;
+		rtl_mac_ocp_write(hw, 0xD3E4, mac_ocp_data);
+
+		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE860);
+		mac_ocp_data |= BIT_7;
+		rtl_mac_ocp_write(hw, 0xE860, mac_ocp_data);
+	}
+}
+
+const struct rtl_hw_ops rtl8168ep_ops = {
+	.hw_config         = hw_config_8168ep,
+	.hw_init_rxcfg     = hw_init_rxcfg_8168ep,
+	.hw_ephy_config    = hw_ephy_config_8168ep,
+	.hw_phy_config     = hw_phy_config_8168ep,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168ep,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168ep,
+};
diff --git a/drivers/net/r8169/base/rtl8168ep.h b/drivers/net/r8169/base/rtl8168ep.h
new file mode 100644
index 0000000000..a03c94dc9f
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168ep.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef _RTL8168EP_H_
+#define _RTL8168EP_H_
+
+#include "../r8169_compat.h"
+
+extern const struct rtl_hw_ops rtl8168ep_ops;
+
+void hw_mac_mcu_config_8168ep(struct rtl_hw *hw);
+void hw_phy_mcu_config_8168ep(struct rtl_hw *hw);
+
+#endif
diff --git a/drivers/net/r8169/base/rtl8168ep_mcu.c b/drivers/net/r8169/base/rtl8168ep_mcu.c
new file mode 100644
index 0000000000..49375390ab
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168ep_mcu.c
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_dash.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168ep.h"
+
+/* For RTL8168EP, CFG_METHOD_23,27,28 */
+
+/* -------------------------------------MAC 8168EP------------------------------------ */
+
+static void
+rtl8168_set_mac_mcu_8168ep_1(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168ep_1[] = {
+		0xE008, 0xE0D3, 0xE0D6, 0xE0D9, 0xE0DB, 0xE0DD, 0xE0DF, 0xE0E1, 0xC251,
+		0x7340, 0x49B1, 0xF010, 0x1D02, 0x8D40, 0xC202, 0xBA00, 0x2C3A, 0xC0F0,
+		0xE8DE, 0x2000, 0x8000, 0xC0B6, 0x268C, 0x752C, 0x49D4, 0xF112, 0xE025,
+		0xC2F6, 0x7146, 0xC2F5, 0x7340, 0x49BE, 0xF103, 0xC7F2, 0xE002, 0xC7F1,
+		0x304F, 0x6226, 0x49A1, 0xF1F0, 0x7222, 0x49A0, 0xF1ED, 0x2525, 0x1F28,
+		0x3097, 0x3091, 0x9A36, 0x752C, 0x21DC, 0x25BC, 0xC6E2, 0x77C0, 0x1304,
+		0xF014, 0x1303, 0xF014, 0x1302, 0xF014, 0x1301, 0xF014, 0x49D4, 0xF103,
+		0xC3D7, 0xBB00, 0xC618, 0x67C6, 0x752E, 0x22D7, 0x26DD, 0x1505, 0xF013,
+		0xC60A, 0xBE00, 0xC309, 0xBB00, 0xC308, 0xBB00, 0xC307, 0xBB00, 0xC306,
+		0xBB00, 0x25C8, 0x25A6, 0x25AC, 0x25B2, 0x25B8, 0xCD08, 0x0000, 0xC0BC,
+		0xC2FF, 0x7340, 0x49B0, 0xF04E, 0x1F46, 0x308F, 0xC3F7, 0x1C04, 0xE84D,
+		0x1401, 0xF147, 0x7226, 0x49A7, 0xF044, 0x7222, 0x2525, 0x1F30, 0x3097,
+		0x3091, 0x7340, 0xC4EA, 0x401C, 0xF006, 0xC6E8, 0x75C0, 0x49D7, 0xF105,
+		0xE036, 0x1D08, 0x8DC1, 0x0208, 0x6640, 0x2764, 0x1606, 0xF12F, 0x6346,
+		0x133B, 0xF12C, 0x9B34, 0x1B18, 0x3093, 0xC32A, 0x1C10, 0xE82A, 0x1401,
+		0xF124, 0x1A36, 0x308A, 0x7322, 0x25B5, 0x0B0E, 0x1C00, 0xE82C, 0xC71F,
+		0x4027, 0xF11A, 0xE838, 0x1F42, 0x308F, 0x1B08, 0xE824, 0x7236, 0x7746,
+		0x1700, 0xF00D, 0xC313, 0x401F, 0xF103, 0x1F00, 0x9F46, 0x7744, 0x449F,
+		0x445F, 0xE817, 0xC70A, 0x4027, 0xF105, 0xC302, 0xBB00, 0x2E08, 0x2DC2,
+		0xC7FF, 0xBF00, 0xCDB8, 0xFFFF, 0x0C02, 0xA554, 0xA5DC, 0x402F, 0xF105,
+		0x1400, 0xF1FA, 0x1C01, 0xE002, 0x1C00, 0xFF80, 0x49B0, 0xF004, 0x0B01,
+		0xA1D3, 0xE003, 0x0B02, 0xA5D3, 0x3127, 0x3720, 0x0B02, 0xA5D3, 0x3127,
+		0x3720, 0x1300, 0xF1FB, 0xFF80, 0x7322, 0x25B5, 0x1E28, 0x30DE, 0x30D9,
+		0x7264, 0x1E11, 0x2368, 0x3116, 0xFF80, 0x1B7E, 0xC602, 0xBE00, 0x06A6,
+		0x1B7E, 0xC602, 0xBE00, 0x0764, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00,
+		0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00,
+		0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168ep_1); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168ep_1[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x2549);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x06A5);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0763);
+}
+
+static void
+rtl8168_set_mac_mcu_8168ep_2(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168ep_2[] = {
+		0xE008, 0xE017, 0xE052, 0xE056, 0xE058, 0xE05A, 0xE05C, 0xE05E, 0xC50F,
+		0x76A4, 0x49E3, 0xF007, 0x49C0, 0xF103, 0xC607, 0xBE00, 0xC606, 0xBE00,
+		0xC602, 0xBE00, 0x0BDA, 0x0BB6, 0x0BBA, 0xDC00, 0xB400, 0xB401, 0xB402,
+		0xB403, 0xB404, 0xC02E, 0x7206, 0x49AE, 0xF1FE, 0xC12B, 0x9904, 0xC12A,
+		0x9906, 0x7206, 0x49AE, 0xF1FE, 0x7200, 0x49A0, 0xF117, 0xC123, 0xC223,
+		0xC323, 0xE808, 0xC322, 0xE806, 0xC321, 0xE804, 0xC320, 0xE802, 0xE00C,
+		0x740E, 0x49CE, 0xF1FE, 0x9908, 0x990A, 0x9A0C, 0x9B0E, 0x740E, 0x49CE,
+		0xF1FE, 0xFF80, 0xB004, 0xB003, 0xB002, 0xB001, 0xB000, 0xC604, 0xC002,
+		0xB800, 0x1FC8, 0xE000, 0xE8E0, 0xF128, 0x0002, 0xFFFF, 0xF000, 0x8001,
+		0x8002, 0x8003, 0x8004, 0x48C1, 0x48C2, 0xC502, 0xBD00, 0x0490, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168ep_2); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168ep_2[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x0BB3);
+	if (!rtl8168_check_dash_other_fun_present(hw))
+		rtl_mac_ocp_write(hw, 0xFC2A, 0x1FC7);
+}
+
+/* ------------------------------------PHY 8168FP------------------------------------- */
+
+static void
+rtl8168_set_phy_mcu_8168ep_2(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x8700);
+	rtl_mdio_write(hw, 0x13, 0xB82E);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+
+	rtl_mdio_write(hw, 0x13, 0x83DD);
+	rtl_mdio_write(hw, 0x14, 0xAF83);
+	rtl_mdio_write(hw, 0x14, 0xE9AF);
+	rtl_mdio_write(hw, 0x14, 0x83EE);
+	rtl_mdio_write(hw, 0x14, 0xAF83);
+	rtl_mdio_write(hw, 0x14, 0xF1A1);
+	rtl_mdio_write(hw, 0x14, 0x83F4);
+	rtl_mdio_write(hw, 0x14, 0xD149);
+	rtl_mdio_write(hw, 0x14, 0xAF06);
+	rtl_mdio_write(hw, 0x14, 0x47AF);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0xAF00);
+	rtl_mdio_write(hw, 0x14, 0x00AF);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_mdio_write(hw, 0x13, 0xB818);
+	rtl_mdio_write(hw, 0x14, 0x0645);
+
+	rtl_mdio_write(hw, 0x13, 0xB81A);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_mdio_write(hw, 0x13, 0xB81C);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_mdio_write(hw, 0x13, 0xB81E);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_mdio_write(hw, 0x13, 0xB832);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x17);
+	gphy_val &= ~BIT_0;
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+void
+hw_mac_mcu_config_8168ep(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_27:
+		rtl8168_set_mac_mcu_8168ep_1(hw);
+		break;
+	case CFG_METHOD_28:
+		rtl8168_set_mac_mcu_8168ep_2(hw);
+		break;
+	}
+}
+
+void
+hw_phy_mcu_config_8168ep(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_28:
+		rtl8168_set_phy_mcu_8168ep_2(hw);
+		break;
+	}
+}
diff --git a/drivers/net/r8169/base/rtl8168fp.c b/drivers/net/r8169/base/rtl8168fp.c
new file mode 100644
index 0000000000..b8a058bbd9
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168fp.c
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168fp.h"
+
+/* For RTL8168FP, CFG_METHOD_31,32,33,34 */
+
+static void
+hw_init_rxcfg_8168fp(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Single_fetch_V2 |
+		(RX_DMA_BURST_unlimited << RxCfgDMAShift) | RxEarly_off_V2);
+}
+
+static void
+hw_ephy_config_8168fp(struct rtl_hw *hw)
+{
+	rtl_clear_and_set_pcie_phy_bit(hw, 0x19, BIT_6, BIT_12 | BIT_8);
+	rtl_clear_and_set_pcie_phy_bit(hw, 0x59, BIT_6, BIT_12 | BIT_8);
+
+	rtl_clear_pcie_phy_bit(hw, 0x0C, BIT_4);
+	rtl_clear_pcie_phy_bit(hw, 0x4C, BIT_4);
+	rtl_clear_pcie_phy_bit(hw, 0x0B, BIT_0);
+}
+
+static void
+hw_phy_config_8168fp(struct rtl_hw *hw)
+{
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x808E);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x4800);
+	rtl_mdio_write(hw, 0x13, 0x8090);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0xCC00);
+	rtl_mdio_write(hw, 0x13, 0x8092);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0xB000);
+	rtl_mdio_write(hw, 0x13, 0x8088);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x6000);
+	rtl_mdio_write(hw, 0x13, 0x808B);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x3F00, 0x0B00);
+	rtl_mdio_write(hw, 0x13, 0x808D);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x1F00, 0x0600);
+	rtl_mdio_write(hw, 0x13, 0x808C);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0xB000);
+
+	rtl_mdio_write(hw, 0x13, 0x80A0);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x2800);
+	rtl_mdio_write(hw, 0x13, 0x80A2);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x5000);
+	rtl_mdio_write(hw, 0x13, 0x809B);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xF800, 0xB000);
+	rtl_mdio_write(hw, 0x13, 0x809A);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x4B00);
+	rtl_mdio_write(hw, 0x13, 0x809D);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x3F00, 0x0800);
+	rtl_mdio_write(hw, 0x13, 0x80A1);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x7000);
+	rtl_mdio_write(hw, 0x13, 0x809F);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x1F00, 0x0300);
+	rtl_mdio_write(hw, 0x13, 0x809E);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x8800);
+
+	rtl_mdio_write(hw, 0x13, 0x80B2);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x2200);
+	rtl_mdio_write(hw, 0x13, 0x80AD);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xF800, 0x9800);
+	rtl_mdio_write(hw, 0x13, 0x80AF);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x3F00, 0x0800);
+	rtl_mdio_write(hw, 0x13, 0x80B3);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x6F00);
+	rtl_mdio_write(hw, 0x13, 0x80B1);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x1F00, 0x0300);
+	rtl_mdio_write(hw, 0x13, 0x80B0);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x9300);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8011);
+	rtl_set_eth_phy_bit(hw, 0x14, BIT_11);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_set_eth_phy_bit(hw, 0x11, BIT_11);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8016);
+	rtl_set_eth_phy_bit(hw, 0x14, BIT_10);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	/* Enable EthPhyPPSW */
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_clear_eth_phy_bit(hw, 0x11, BIT_7);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+static void
+hw_config_8168fp(struct rtl_hw *hw)
+{
+	u16 mac_ocp_data;
+	u32 csi_tmp;
+
+	rtl_eri_write(hw, 0xC8, 4, 0x00080002, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xCC, 1, 0x2F, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xD0, 1, 0x5F, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xE8, 4, 0x00100006, ERIAR_ExGMAC);
+
+	/* Adjust the trx fifo*/
+	rtl_eri_write(hw, 0xCA, 2, 0x0370, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xEA, 1, 0x10, ERIAR_ExGMAC);
+
+	/* Disable share fifo */
+	RTL_W32(hw, TxConfig, RTL_R32(hw, TxConfig) & ~BIT_7);
+
+	csi_tmp = rtl_eri_read(hw, 0xDC, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_0;
+	rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+	csi_tmp |= BIT_0;
+	rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+
+	/* EEE pwrsave params */
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE056);
+	mac_ocp_data &= ~(BIT_7 | BIT_6 | BIT_5 | BIT_4);
+	rtl_mac_ocp_write(hw, 0xE056, mac_ocp_data);
+
+	if (hw->HwPkgDet == 0x0F)
+		rtl_mac_ocp_write(hw, 0xEA80, 0x0003);
+	else
+		rtl_mac_ocp_write(hw, 0xEA80, 0x0000);
+
+	rtl_oob_mutex_lock(hw);
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE052);
+	mac_ocp_data &= ~(BIT_3 | BIT_0);
+	if (hw->HwPkgDet == 0x0F)
+		mac_ocp_data |= BIT_0;
+	rtl_mac_ocp_write(hw, 0xE052, mac_ocp_data);
+	rtl_oob_mutex_unlock(hw);
+
+	RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~Beacon_en);
+
+	RTL_W8(hw, 0x1B, RTL_R8(hw, 0x1B) & ~0x07);
+
+	RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~PMSTS_En);
+
+	if (!HW_SUPP_SERDES_PHY(hw)) {
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_6);
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_6);
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) | BIT_7);
+	} else {
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_6);
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_7);
+	}
+
+	rtl_oob_mutex_lock(hw);
+	if (hw->HwPkgDet == 0x0F)
+		rtl_eri_write(hw, 0x5F0, 2, 0x4F00, ERIAR_ExGMAC);
+	else
+		rtl_eri_write(hw, 0x5F0, 2, 0x4000, ERIAR_ExGMAC);
+	rtl_oob_mutex_unlock(hw);
+
+	csi_tmp = rtl_eri_read(hw, 0xDC, 4, ERIAR_ExGMAC);
+	csi_tmp |= (BIT_2 | BIT_3);
+	rtl_eri_write(hw, 0xDC, 4, csi_tmp, ERIAR_ExGMAC);
+
+	if (hw->mcfg == CFG_METHOD_32 || hw->mcfg == CFG_METHOD_33 ||
+	    hw->mcfg == CFG_METHOD_34) {
+		csi_tmp = rtl_eri_read(hw, 0xD4, 4, ERIAR_ExGMAC);
+		csi_tmp |= BIT_4;
+		rtl_eri_write(hw, 0xD4, 4, csi_tmp, ERIAR_ExGMAC);
+	}
+
+	rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
+	rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
+
+	csi_tmp = rtl_eri_read(hw, 0x2FC, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~(BIT_0 | BIT_1);
+	csi_tmp |= BIT_0;
+	rtl_eri_write(hw, 0x2FC, 1, csi_tmp, ERIAR_ExGMAC);
+
+	csi_tmp = rtl_eri_read(hw, 0x1D0, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_1;
+	rtl_eri_write(hw, 0x1D0, 1, csi_tmp, ERIAR_ExGMAC);
+}
+
+const struct rtl_hw_ops rtl8168fp_ops = {
+	.hw_config         = hw_config_8168fp,
+	.hw_init_rxcfg     = hw_init_rxcfg_8168fp,
+	.hw_ephy_config    = hw_ephy_config_8168fp,
+	.hw_phy_config     = hw_phy_config_8168fp,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168fp,
+};
diff --git a/drivers/net/r8169/base/rtl8168fp.h b/drivers/net/r8169/base/rtl8168fp.h
new file mode 100644
index 0000000000..4613fe9a98
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168fp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef _RTL8168FP_H_
+#define _RTL8168FP_H_
+
+#include "../r8169_compat.h"
+
+extern const struct rtl_hw_ops rtl8168fp_ops;
+
+void hw_mac_mcu_config_8168fp(struct rtl_hw *hw);
+
+#endif
diff --git a/drivers/net/r8169/base/rtl8168fp_mcu.c b/drivers/net/r8169/base/rtl8168fp_mcu.c
new file mode 100644
index 0000000000..839dcfde61
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168fp_mcu.c
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_dash.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168fp.h"
+
+/* For RTL8168FP, CFG_METHOD_31,32,33,34 */
+
+/* ------------------------------------MAC 8168FP--------------------------------------- */
+
+static void
+rtl8168_set_mac_mcu_8168fp_1(struct rtl_hw *hw)
+{
+	u16 i;
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+	if (hw->HwPkgDet == 0x00 || hw->HwPkgDet == 0x0F) {
+		static const u16 mcu_patch_code_8168fp_1_1[] = {
+			0xE00A, 0xE0C1, 0xE104, 0xE108, 0xE10D, 0xE112, 0xE11C, 0xE121, 0xE000,
+			0xE0C8, 0xB400, 0xC1FE, 0x49E2, 0xF04C, 0x49EA, 0xF04A, 0x74E6, 0xC246,
+			0x7542, 0x73EC, 0x1800, 0x49C0, 0xF10D, 0x49C1, 0xF10B, 0x49C2, 0xF109,
+			0x49B0, 0xF107, 0x49B1, 0xF105, 0x7220, 0x49A2, 0xF102, 0xE002, 0x4800,
+			0x49D0, 0xF10A, 0x49D1, 0xF108, 0x49D2, 0xF106, 0x49D3, 0xF104, 0x49DF,
+			0xF102, 0xE00C, 0x4801, 0x72E4, 0x49AD, 0xF108, 0xC225, 0x6741, 0x48F0,
+			0x8F41, 0x4870, 0x8F41, 0xC7CF, 0x49B5, 0xF01F, 0x49B2, 0xF00B, 0x4980,
+			0xF003, 0x484E, 0x94E7, 0x4981, 0xF004, 0x485E, 0xC212, 0x9543, 0xE071,
+			0x49B6, 0xF003, 0x49B3, 0xF10F, 0x4980, 0xF003, 0x484E, 0x94E7, 0x4981,
+			0xF004, 0x485E, 0xC204, 0x9543, 0xE005, 0xE000, 0xE0FC, 0xE0FA, 0xE065,
+			0x49B7, 0xF007, 0x4980, 0xF005, 0x1A38, 0x46D4, 0x1200, 0xF109, 0x4981,
+			0xF055, 0x49C3, 0xF105, 0x1A30, 0x46D5, 0x1200, 0xF04F, 0x7220, 0x49A2,
+			0xF130, 0x49C1, 0xF12E, 0x49B0, 0xF12C, 0xC2E6, 0x7240, 0x49A8, 0xF003,
+			0x49D0, 0xF126, 0x49A9, 0xF003, 0x49D1, 0xF122, 0x49AA, 0xF003, 0x49D2,
+			0xF11E, 0x49AB, 0xF003, 0x49DF, 0xF11A, 0x49AC, 0xF003, 0x49D3, 0xF116,
+			0x4980, 0xF003, 0x49C7, 0xF105, 0x4981, 0xF02C, 0x49D7, 0xF02A, 0x49C0,
+			0xF00C, 0xC721, 0x62F4, 0x49A0, 0xF008, 0x49A4, 0xF106, 0x4824, 0x8AF4,
+			0xC71A, 0x1A40, 0x9AE0, 0x49B6, 0xF017, 0x200E, 0xC7B8, 0x72E0, 0x4710,
+			0x92E1, 0xC70E, 0x77E0, 0x49F0, 0xF112, 0xC70B, 0x77E0, 0x27FE, 0x1AFA,
+			0x4317, 0xC705, 0x9AE2, 0x1A11, 0x8AE0, 0xE008, 0xE41C, 0xC0AE, 0xD23A,
+			0xC7A2, 0x74E6, 0x484F, 0x94E7, 0xC79E, 0x8CE6, 0x8BEC, 0xC29C, 0x8D42,
+			0x7220, 0xB000, 0xC502, 0xBD00, 0x0932, 0xB400, 0xC240, 0xC340, 0x7060,
+			0x498F, 0xF014, 0x488F, 0x9061, 0x744C, 0x49C3, 0xF004, 0x7562, 0x485E,
+			0x9563, 0x7446, 0x49C3, 0xF106, 0x7562, 0x1C30, 0x46E5, 0x1200, 0xF004,
+			0x7446, 0x484F, 0x9447, 0xC32A, 0x7466, 0x49C0, 0xF00F, 0x48C0, 0x9C66,
+			0x7446, 0x4840, 0x4841, 0x4842, 0x9C46, 0x744C, 0x4840, 0x9C4C, 0x744A,
+			0x484A, 0x9C4A, 0xE013, 0x498E, 0xF011, 0x488E, 0x9061, 0x744C, 0x49C3,
+			0xF004, 0x7446, 0x484E, 0x9447, 0x7446, 0x1D38, 0x46EC, 0x1500, 0xF004,
+			0x7446, 0x484F, 0x9447, 0xB000, 0xC502, 0xBD00, 0x074C, 0xE000, 0xE0FC,
+			0xE0C0, 0x4830, 0x4837, 0xC502, 0xBD00, 0x0978, 0x63E2, 0x4830, 0x4837,
+			0xC502, 0xBD00, 0x09FE, 0x73E2, 0x4830, 0x8BE2, 0xC302, 0xBB00, 0x0A12,
+			0x73E2, 0x48B0, 0x48B3, 0x48B4, 0x48B5, 0x48B6, 0x48B7, 0x8BE2, 0xC302,
+			0xBB00, 0x0A5A, 0x73E2, 0x4830, 0x8BE2, 0xC302, 0xBB00, 0x0A6C, 0x73E2,
+			0x4830, 0x4837, 0xC502, 0xBD00, 0x0A86
+		};
+
+		for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168fp_1_1); i++)
+			rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168fp_1_1[i]);
+
+		rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+		rtl_mac_ocp_write(hw, 0xFC28, 0x0890);
+		rtl_mac_ocp_write(hw, 0xFC2A, 0x0712);
+		rtl_mac_ocp_write(hw, 0xFC2C, 0x0974);
+		rtl_mac_ocp_write(hw, 0xFC2E, 0x09FC);
+		rtl_mac_ocp_write(hw, 0xFC30, 0x0A0E);
+		rtl_mac_ocp_write(hw, 0xFC32, 0x0A56);
+		rtl_mac_ocp_write(hw, 0xFC34, 0x0A68);
+		rtl_mac_ocp_write(hw, 0xFC36, 0x0A84);
+
+		/* Set bp enable*/
+		if (hw->HwPkgDet == 0x00)
+			rtl_mac_ocp_write(hw, 0xFC38, 0x00FC);
+		else if (hw->HwPkgDet == 0x0F)
+			rtl_mac_ocp_write(hw, 0xFC38, 0x00FF);
+	} else if (hw->HwPkgDet == 0x05 || hw->HwPkgDet == 0x06) {
+		static const u16 mcu_patch_code_8168fp_1_2[] = {
+			0xE008, 0xE00A, 0xE031, 0xE033, 0xE035, 0xE144, 0xE166, 0xE168, 0xC502,
+			0xBD00, 0x0000, 0xC725, 0x75E0, 0x48D0, 0x9DE0, 0xC722, 0x75E0, 0x1C78,
+			0x416C, 0x1530, 0xF111, 0xC71D, 0x75F6, 0x49D1, 0xF00D, 0x75E0, 0x1C1F,
+			0x416C, 0x1502, 0xF108, 0x75FA, 0x49D3, 0xF005, 0x75EC, 0x9DE4, 0x4853,
+			0x9DFA, 0xC70B, 0x75E0, 0x4852, 0x4850, 0x9DE0, 0xC602, 0xBE00, 0x04B8,
+			0xE420, 0xE000, 0xE0FC, 0xE43C, 0xDC00, 0xEB00, 0xC202, 0xBA00, 0x0000,
+			0xC002, 0xB800, 0x0000, 0xB401, 0xB402, 0xB403, 0xB404, 0xB405, 0xB406,
+			0xC44D, 0xC54D, 0x1867, 0xE8A2, 0x2318, 0x276E, 0x1601, 0xF106, 0x1A07,
+			0xE861, 0xE86B, 0xE873, 0xE037, 0x231E, 0x276E, 0x1602, 0xF10B, 0x1A07,
+			0xE858, 0xE862, 0xC247, 0xC344, 0xE8E3, 0xC73B, 0x66E0, 0xE8B5, 0xE029,
+			0x231A, 0x276C, 0xC733, 0x9EE0, 0x1866, 0xE885, 0x251C, 0x120F, 0xF011,
+			0x1209, 0xF011, 0x2014, 0x240E, 0x1000, 0xF007, 0x120C, 0xF00D, 0x1203,
+			0xF00D, 0x1200, 0xF00D, 0x120C, 0xF00D, 0x1203, 0xF00D, 0x1A03, 0xE00C,
+			0x1A07, 0xE00A, 0x1A00, 0xE008, 0x1A01, 0xE006, 0x1A02, 0xE004, 0x1A04,
+			0xE002, 0x1A05, 0xE829, 0xE833, 0xB006, 0xB005, 0xB004, 0xB003, 0xB002,
+			0xB001, 0x60C4, 0xC702, 0xBF00, 0x2786, 0xDD00, 0xD030, 0xE0C4, 0xE0F8,
+			0xDC42, 0xD3F0, 0x0000, 0x0004, 0x0007, 0x0014, 0x0090, 0x1000, 0x0F00,
+			0x1004, 0x1008, 0x3000, 0x3004, 0x3008, 0x4000, 0x7777, 0x8000, 0x8001,
+			0x8008, 0x8003, 0x8004, 0xC000, 0xC004, 0xF004, 0xFFFF, 0xB406, 0xB407,
+			0xC6E5, 0x77C0, 0x27F3, 0x23F3, 0x47FA, 0x9FC0, 0xB007, 0xB006, 0xFF80,
+			0xB405, 0xB407, 0xC7D8, 0x75E0, 0x48D0, 0x9DE0, 0xB007, 0xB005, 0xFF80,
+			0xB401, 0xC0EA, 0xC2DC, 0xC3D8, 0xE865, 0xC0D3, 0xC1E0, 0xC2E3, 0xE861,
+			0xE817, 0xC0CD, 0xC2CF, 0xE85D, 0xC0C9, 0xC1D6, 0xC2DB, 0xE859, 0xE80F,
+			0xC1C7, 0xC2CE, 0xE855, 0xC0C0, 0xC1D1, 0xC2D3, 0xE851, 0xE807, 0xC0BE,
+			0xC2C2, 0xE84D, 0xE803, 0xB001, 0xFF80, 0xB402, 0xC2C6, 0xE859, 0x499F,
+			0xF1FE, 0xB002, 0xFF80, 0xB402, 0xB403, 0xB407, 0xE821, 0x8882, 0x1980,
+			0x8983, 0xE81D, 0x7180, 0x218B, 0x25BB, 0x1310, 0xF014, 0x1310, 0xFB03,
+			0x1F20, 0x38FB, 0x3288, 0x434B, 0x2491, 0x430B, 0x1F0F, 0x38FB, 0x4313,
+			0x2121, 0x4353, 0x2521, 0x418A, 0x6282, 0x2527, 0x212F, 0x418A, 0xB007,
+			0xB003, 0xB002, 0xFF80, 0x6183, 0x2496, 0x1100, 0xF1FD, 0xFF80, 0x4800,
+			0x4801, 0xC213, 0xC313, 0xE815, 0x4860, 0x8EE0, 0xC210, 0xC310, 0xE822,
+			0x481E, 0xC20C, 0xC30C, 0xE80C, 0xC206, 0x7358, 0x483A, 0x9B58, 0xFF80,
+			0xE8E0, 0xE000, 0x1008, 0x0F00, 0x800C, 0x0F00, 0xB407, 0xB406, 0xB403,
+			0xC7F7, 0x98E0, 0x99E2, 0x9AE4, 0x21B2, 0x4831, 0x483F, 0x9BE6, 0x66E7,
+			0x49E6, 0xF1FE, 0xB003, 0xB006, 0xB007, 0xFF80, 0xB407, 0xB406, 0xB403,
+			0xC7E5, 0x9AE4, 0x21B2, 0x4831, 0x9BE6, 0x66E7, 0x49E6, 0xF1FE, 0x70E0,
+			0x71E2, 0xB003, 0xB006, 0xB007, 0xFF80, 0x4882, 0xB406, 0xB405, 0xC71E,
+			0x76E0, 0x1D78, 0x4175, 0x1630, 0xF10C, 0xC715, 0x76E0, 0x4861, 0x9EE0,
+			0xC713, 0x1EFF, 0x9EE2, 0x75E0, 0x4850, 0x9DE0, 0xE005, 0xC70B, 0x76E0,
+			0x4865, 0x9EE0, 0xB005, 0xB006, 0xC708, 0xC102, 0xB900, 0x279E, 0xEB16,
+			0xEB00, 0xE43C, 0xDC00, 0xD3EC, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00,
+			0x0000
+		};
+
+		for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168fp_1_2); i++)
+			rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168fp_1_2[i]);
+
+		rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+		rtl_mac_ocp_write(hw, 0xFC28, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC2A, 0x04b4);
+		rtl_mac_ocp_write(hw, 0xFC2C, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC2E, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC30, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC32, 0x279C);
+		rtl_mac_ocp_write(hw, 0xFC34, 0x0000);
+		rtl_mac_ocp_write(hw, 0xFC36, 0x0000);
+
+		/* Set bp enable*/
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0022);
+	}
+}
+
+static void
+rtl8168_set_mac_mcu_8168fp_8116as_2(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168fp_8116as_2[] = {
+		0xE008, 0xE00A, 0xE00F, 0xE014, 0xE016, 0xE018, 0xE01A, 0xE01C, 0xC602,
+		0xBE00, 0x2AB2, 0x1BC0, 0x46EB, 0x1BFE, 0xC102, 0xB900, 0x0B1A, 0x1BC0,
+		0x46EB, 0x1B7E, 0xC102, 0xB900, 0x0BEA, 0xC602, 0xBE00, 0x0000, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602,
+		0xBE00, 0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168fp_8116as_2); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168fp_8116as_2[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x2AAC);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x0B14);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0BE4);
+
+	rtl_mac_ocp_write(hw, 0xFC38, 0x0007);
+}
+
+static void
+_rtl8168_set_mac_mcu_8168fp_2(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168fp_2[] = {
+		0xE008, 0xE00A, 0xE00F, 0xE014, 0xE05F, 0xE064, 0xE066, 0xE068, 0xC602,
+		0xBE00, 0x0000, 0x1BC0, 0x46EB, 0x1BFE, 0xC102, 0xB900, 0x0B1A, 0x1BC0,
+		0x46EB, 0x1B7E, 0xC102, 0xB900, 0x0BEA, 0xB400, 0xB401, 0xB402, 0xB403,
+		0xB404, 0xB405, 0xC03A, 0x7206, 0x49AE, 0xF1FE, 0xC137, 0x9904, 0xC136,
+		0x9906, 0x7206, 0x49AE, 0xF1FE, 0x7200, 0x49A0, 0xF10B, 0xC52F, 0xC12E,
+		0xC232, 0xC332, 0xE812, 0xC331, 0xE810, 0xC330, 0xE80E, 0xE018, 0xC126,
+		0xC229, 0xC525, 0xC328, 0xE808, 0xC523, 0xC326, 0xE805, 0xC521, 0xC324,
+		0xE802, 0xE00C, 0x740E, 0x49CE, 0xF1FE, 0x9908, 0x9D0A, 0x9A0C, 0x9B0E,
+		0x740E, 0x49CE, 0xF1FE, 0xFF80, 0xB005, 0xB004, 0xB003, 0xB002, 0xB001,
+		0xB000, 0xC604, 0xC002, 0xB800, 0x2A5E, 0xE000, 0xE8E0, 0xF128, 0x3DC2,
+		0xFFFF, 0x10EC, 0x816A, 0x816D, 0x816C, 0xF000, 0x8002, 0x8004, 0x8007,
+		0x48C1, 0x48C2, 0x9C46, 0xC402, 0xBC00, 0x07BC, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168fp_2); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168fp_2[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x2AAC);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x0B14);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0BE4);
+	rtl_mac_ocp_write(hw, 0xFC2E, 0x2A5C);
+
+	if (rtl8168_check_dash_other_fun_present(hw))
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0006);
+	else
+		rtl_mac_ocp_write(hw, 0xFC38, 0x000E);
+}
+
+static void
+rtl8168_set_mac_mcu_8168fp_2(struct rtl_hw *hw)
+{
+	if (hw->HwSuppSerDesPhyVer == 1)
+		rtl8168_set_mac_mcu_8168fp_8116as_2(hw);
+	else
+		_rtl8168_set_mac_mcu_8168fp_2(hw);
+}
+
+static void
+rtl8168_set_mac_mcu_8168fp_3(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168fp_3[] = {
+		0xE008, 0xE053, 0xE058, 0xE05A, 0xE05C, 0xE05E, 0xE060, 0xE062, 0xB400,
+		0xB401, 0xB402, 0xB403, 0xB404, 0xB405, 0xC03A, 0x7206, 0x49AE, 0xF1FE,
+		0xC137, 0x9904, 0xC136, 0x9906, 0x7206, 0x49AE, 0xF1FE, 0x7200, 0x49A0,
+		0xF10B, 0xC52F, 0xC12E, 0xC232, 0xC332, 0xE812, 0xC331, 0xE810, 0xC330,
+		0xE80E, 0xE018, 0xC126, 0xC229, 0xC525, 0xC328, 0xE808, 0xC523, 0xC326,
+		0xE805, 0xC521, 0xC324, 0xE802, 0xE00C, 0x740E, 0x49CE, 0xF1FE, 0x9908,
+		0x9D0A, 0x9A0C, 0x9B0E, 0x740E, 0x49CE, 0xF1FE, 0xFF80, 0xB005, 0xB004,
+		0xB003, 0xB002, 0xB001, 0xB000, 0xC604, 0xC002, 0xB800, 0x2B16, 0xE000,
+		0xE8E0, 0xF128, 0x3DC2, 0xFFFF, 0x10EC, 0x816A, 0x816D, 0x816C, 0xF000,
+		0x8002, 0x8004, 0x8007, 0x48C1, 0x48C2, 0x9C46, 0xC402, 0xBC00, 0x07BC,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000,
+		0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168fp_3); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168fp_3[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x2B14);
+
+	if (rtl8168_check_dash_other_fun_present(hw))
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
+	else
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0001);
+}
+
+/* ------------------------------------PHY 8168FP------------------------------------- */
+
+void
+hw_mac_mcu_config_8168fp(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_31:
+		rtl8168_set_mac_mcu_8168fp_1(hw);
+		break;
+	case CFG_METHOD_32:
+		rtl8168_set_mac_mcu_8168fp_2(hw);
+		break;
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		rtl8168_set_mac_mcu_8168fp_3(hw);
+		break;
+	}
+}
diff --git a/drivers/net/r8169/base/rtl8168g.c b/drivers/net/r8169/base/rtl8168g.c
new file mode 100644
index 0000000000..8f5e7ac2a5
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168g.c
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168g.h"
+
+/* For RTL8168G,RTL8168GU, CFG_METHOD_21,22,24,25 */
+
+static void
+hw_init_rxcfg_8168g(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Single_fetch_V2 |
+		(RX_DMA_BURST_unlimited << RxCfgDMAShift) | RxEarly_off_V2);
+}
+
+static void
+hw_ephy_config_8168g(struct rtl_hw *hw)
+{
+	u16 ephy_data;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+		ephy_data = rtl_ephy_read(hw, 0x00);
+		ephy_data &= ~BIT_3;
+		rtl_ephy_write(hw, 0x00, ephy_data);
+		ephy_data = rtl_ephy_read(hw, 0x0C);
+		ephy_data &= ~(BIT_13 | BIT_12 | BIT_11 | BIT_10 | BIT_9 |
+			       BIT_8 | BIT_7 | BIT_6 | BIT_5 | BIT_4);
+		ephy_data |= (BIT_5 | BIT_11);
+		rtl_ephy_write(hw, 0x0C, ephy_data);
+
+		ephy_data = rtl_ephy_read(hw, 0x1E);
+		ephy_data |= BIT_0;
+		rtl_ephy_write(hw, 0x1E, ephy_data);
+
+		ephy_data = rtl_ephy_read(hw, 0x19);
+		ephy_data &= ~BIT_15;
+		rtl_ephy_write(hw, 0x19, ephy_data);
+		break;
+	case CFG_METHOD_25:
+		ephy_data = rtl_ephy_read(hw, 0x00);
+		ephy_data &= ~BIT_3;
+		rtl_ephy_write(hw, 0x00, ephy_data);
+		ephy_data = rtl_ephy_read(hw, 0x0C);
+		ephy_data &= ~(BIT_13 | BIT_12 | BIT_11 | BIT_10 | BIT_9 |
+			       BIT_8 | BIT_7 | BIT_6 | BIT_5 | BIT_4);
+		ephy_data |= (BIT_5 | BIT_11);
+		rtl_ephy_write(hw, 0x0C, ephy_data);
+
+		rtl_ephy_write(hw, 0x19, 0x7C00);
+		rtl_ephy_write(hw, 0x1E, 0x20EB);
+		rtl_ephy_write(hw, 0x0D, 0x1666);
+		rtl_ephy_write(hw, 0x00, 0x10A3);
+		rtl_ephy_write(hw, 0x06, 0xF050);
+
+		rtl_set_pcie_phy_bit(hw, 0x04, BIT_4);
+		rtl_clear_pcie_phy_bit(hw, 0x1D, BIT_14);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+hw_phy_config_8168g_1(struct rtl_hw *hw)
+{
+	u16 gphy_val;
+
+	rtl_mdio_write(hw, 0x1F, 0x0A46);
+	gphy_val = rtl_mdio_read(hw, 0x10);
+	rtl_mdio_write(hw, 0x1F, 0x0BCC);
+	if (gphy_val & BIT_8)
+		rtl_clear_eth_phy_bit(hw, 0x12, BIT_15);
+	else
+		rtl_set_eth_phy_bit(hw, 0x12, BIT_15);
+	rtl_mdio_write(hw, 0x1F, 0x0A46);
+	gphy_val = rtl_mdio_read(hw, 0x13);
+	rtl_mdio_write(hw, 0x1F, 0x0C41);
+	if (gphy_val & BIT_8)
+		rtl_set_eth_phy_bit(hw, 0x15, BIT_1);
+	else
+		rtl_clear_eth_phy_bit(hw, 0x15, BIT_1);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_2 | BIT_3);
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCC);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~BIT_8);
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_7);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_6);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8084);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~(BIT_14 | BIT_13));
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_12);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_1);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_0);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A4B);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_2);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8012);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) | BIT_15);
+
+	rtl_mdio_write(hw, 0x1F, 0x0C42);
+	gphy_val = rtl_mdio_read(hw, 0x11);
+	gphy_val |= BIT_14;
+	gphy_val &= ~BIT_13;
+	rtl_mdio_write(hw, 0x11, gphy_val);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x809A);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x13, 0x80A0);
+	gphy_val = rtl_mdio_read(hw, 0x14) & 0x00FF;
+	gphy_val |= 0x1000;
+	rtl_mdio_write(hw, 0x14, gphy_val);
+	rtl_mdio_write(hw, 0x13, 0x8088);
+	rtl_mdio_write(hw, 0x14, 0x9222);
+
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+static void
+hw_phy_config_8168g_2(struct rtl_hw *hw)
+{
+	u16 gphy_val;
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCC);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~BIT_8);
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_7);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_6);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8084);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~(BIT_14 | BIT_13));
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_12);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_1);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_0);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8012);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) | BIT_15);
+
+	rtl_mdio_write(hw, 0x1F, 0x0C42);
+	gphy_val = rtl_mdio_read(hw, 0x11);
+	gphy_val |= BIT_14;
+	gphy_val &= ~BIT_13;
+	rtl_mdio_write(hw, 0x11, gphy_val);
+}
+
+static void
+hw_phy_config_8168g_3(struct rtl_hw *hw)
+{
+	rtl_mdio_write(hw, 0x1F, 0x0BCC);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~BIT_8);
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_7);
+	rtl_mdio_write(hw, 0x11, rtl_mdio_read(hw, 0x11) | BIT_6);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8084);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) & ~(BIT_14 | BIT_13));
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_12);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_1);
+	rtl_mdio_write(hw, 0x10, rtl_mdio_read(hw, 0x10) | BIT_0);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8012);
+	rtl_mdio_write(hw, 0x14, rtl_mdio_read(hw, 0x14) | BIT_15);
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCE);
+	rtl_mdio_write(hw, 0x12, 0x8860);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x80F3);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8B00);
+	rtl_mdio_write(hw, 0x13, 0x80F0);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x3A00);
+	rtl_mdio_write(hw, 0x13, 0x80EF);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0500);
+	rtl_mdio_write(hw, 0x13, 0x80F6);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6E00);
+	rtl_mdio_write(hw, 0x13, 0x80EC);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6800);
+	rtl_mdio_write(hw, 0x13, 0x80ED);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x7C00);
+	rtl_mdio_write(hw, 0x13, 0x80F2);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xF400);
+	rtl_mdio_write(hw, 0x13, 0x80F4);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8500);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8110);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xA800);
+	rtl_mdio_write(hw, 0x13, 0x810F);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x1D00);
+	rtl_mdio_write(hw, 0x13, 0x8111);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xF500);
+	rtl_mdio_write(hw, 0x13, 0x8113);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x6100);
+	rtl_mdio_write(hw, 0x13, 0x8115);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x9200);
+	rtl_mdio_write(hw, 0x13, 0x810E);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0400);
+	rtl_mdio_write(hw, 0x13, 0x810C);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x7C00);
+	rtl_mdio_write(hw, 0x13, 0x810B);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x5A00);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x80D1);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xFF00);
+	rtl_mdio_write(hw, 0x13, 0x80CD);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x9E00);
+	rtl_mdio_write(hw, 0x13, 0x80D3);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x0E00);
+	rtl_mdio_write(hw, 0x13, 0x80D5);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0xCA00);
+	rtl_mdio_write(hw, 0x13, 0x80D7);
+	rtl_mdio_write(hw, 0x14, (rtl_mdio_read(hw, 0x14) & ~0xFF00) | 0x8400);
+}
+
+static void
+hw_phy_config_8168g(struct rtl_hw *hw)
+{
+	if (hw->mcfg == CFG_METHOD_21)
+		hw_phy_config_8168g_1(hw);
+	else if (hw->mcfg == CFG_METHOD_24)
+		hw_phy_config_8168g_2(hw);
+	else if (hw->mcfg == CFG_METHOD_25)
+		hw_phy_config_8168g_3(hw);
+
+	/* Disable EthPhyPPSW */
+	rtl_mdio_write(hw, 0x1F, 0x0BCD);
+	rtl_mdio_write(hw, 0x14, 0x5065);
+	rtl_mdio_write(hw, 0x14, 0xD065);
+	rtl_mdio_write(hw, 0x1F, 0x0BC8);
+	rtl_mdio_write(hw, 0x11, 0x5655);
+	rtl_mdio_write(hw, 0x1F, 0x0BCD);
+	rtl_mdio_write(hw, 0x14, 0x1065);
+	rtl_mdio_write(hw, 0x14, 0x9065);
+	rtl_mdio_write(hw, 0x14, 0x1065);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+static void
+hw_config_8168g(struct rtl_hw *hw)
+{
+	u32 csi_tmp;
+
+	/* Share fifo rx params */
+	rtl_eri_write(hw, 0xC8, 4, 0x00080002, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xCC, 1, 0x38, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xD0, 1, 0x48, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xE8, 4, 0x00100006, ERIAR_ExGMAC);
+
+	/* Adjust the trx fifo*/
+	rtl_eri_write(hw, 0xCA, 2, 0x0370, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xEA, 1, 0x10, ERIAR_ExGMAC);
+
+	/* Disable share fifo */
+	RTL_W32(hw, TxConfig, RTL_R32(hw, TxConfig) & ~BIT_7);
+
+	RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~Beacon_en);
+
+	/* EEE led enable */
+	RTL_W8(hw, 0x1B, RTL_R8(hw, 0x1B) & ~0x07);
+
+	RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~PMSTS_En);
+
+	/* CRC wake disable */
+	rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
+
+	csi_tmp = rtl_eri_read(hw, 0x1B0, 4, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_12;
+	rtl_eri_write(hw, 0x1B0, 4, csi_tmp, ERIAR_ExGMAC);
+
+	csi_tmp = rtl_eri_read(hw, 0x2FC, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~(BIT_0 | BIT_1 | BIT_2);
+	csi_tmp |= BIT_0;
+	rtl_eri_write(hw, 0x2FC, 1, csi_tmp, ERIAR_ExGMAC);
+
+	csi_tmp = rtl_eri_read(hw, 0x1D0, 1, ERIAR_ExGMAC);
+	csi_tmp |= BIT_1;
+	rtl_eri_write(hw, 0x1D0, 1, csi_tmp, ERIAR_ExGMAC);
+}
+
+const struct rtl_hw_ops rtl8168g_ops = {
+	.hw_config         = hw_config_8168g,
+	.hw_init_rxcfg     = hw_init_rxcfg_8168g,
+	.hw_ephy_config    = hw_ephy_config_8168g,
+	.hw_phy_config     = hw_phy_config_8168g,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168g,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168g,
+};
diff --git a/drivers/net/r8169/base/rtl8168g.h b/drivers/net/r8169/base/rtl8168g.h
new file mode 100644
index 0000000000..feb0e28ff6
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168g.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef _RTL8168G_H_
+#define _RTL8168G_H_
+
+#include "../r8169_compat.h"
+
+extern const struct rtl_hw_ops rtl8168g_ops;
+
+void hw_mac_mcu_config_8168g(struct rtl_hw *hw);
+void hw_phy_mcu_config_8168g(struct rtl_hw *hw);
+
+#endif
diff --git a/drivers/net/r8169/base/rtl8168g_mcu.c b/drivers/net/r8169/base/rtl8168g_mcu.c
new file mode 100644
index 0000000000..a1296b044b
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168g_mcu.c
@@ -0,0 +1,1936 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168g.h"
+
+/* For RTL8168G,RTL8168GU, CFG_METHOD_21,22,24,25 */
+
+/* ------------------------------------MAC 8168G1----------------------------------- */
+
+static void
+rtl8168_set_mac_mcu_8168g_1(struct rtl_hw *hw)
+{
+	rtl_mac_ocp_write(hw, 0xE43C, 0x0000);
+	rtl_mac_ocp_write(hw, 0xE43E, 0x0000);
+
+	rtl_mac_ocp_write(hw, 0xE434, 0x0004);
+	rtl_mac_ocp_write(hw, 0xE43C, 0x0004);
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	rtl_mac_ocp_write(hw, 0xF800, 0xE008);
+	rtl_mac_ocp_write(hw, 0xF802, 0xE01B);
+	rtl_mac_ocp_write(hw, 0xF804, 0xE022);
+	rtl_mac_ocp_write(hw, 0xF806, 0xE094);
+	rtl_mac_ocp_write(hw, 0xF808, 0xE097);
+	rtl_mac_ocp_write(hw, 0xF80A, 0xE09A);
+	rtl_mac_ocp_write(hw, 0xF80C, 0xE0B3);
+	rtl_mac_ocp_write(hw, 0xF80E, 0xE0BA);
+	rtl_mac_ocp_write(hw, 0xF810, 0x49D2);
+	rtl_mac_ocp_write(hw, 0xF812, 0xF10D);
+	rtl_mac_ocp_write(hw, 0xF814, 0x766C);
+	rtl_mac_ocp_write(hw, 0xF816, 0x49E2);
+	rtl_mac_ocp_write(hw, 0xF818, 0xF00A);
+	rtl_mac_ocp_write(hw, 0xF81A, 0x1EC0);
+	rtl_mac_ocp_write(hw, 0xF81C, 0x8EE1);
+	rtl_mac_ocp_write(hw, 0xF81E, 0xC60A);
+	rtl_mac_ocp_write(hw, 0xF820, 0x77C0);
+	rtl_mac_ocp_write(hw, 0xF822, 0x4870);
+	rtl_mac_ocp_write(hw, 0xF824, 0x9FC0);
+	rtl_mac_ocp_write(hw, 0xF826, 0x1EA0);
+	rtl_mac_ocp_write(hw, 0xF828, 0xC707);
+	rtl_mac_ocp_write(hw, 0xF82A, 0x8EE1);
+	rtl_mac_ocp_write(hw, 0xF82C, 0x9D6C);
+	rtl_mac_ocp_write(hw, 0xF82E, 0xC603);
+	rtl_mac_ocp_write(hw, 0xF830, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF832, 0xB416);
+	rtl_mac_ocp_write(hw, 0xF834, 0x0076);
+	rtl_mac_ocp_write(hw, 0xF836, 0xE86C);
+	rtl_mac_ocp_write(hw, 0xF838, 0xC406);
+	rtl_mac_ocp_write(hw, 0xF83A, 0x7580);
+	rtl_mac_ocp_write(hw, 0xF83C, 0x4852);
+	rtl_mac_ocp_write(hw, 0xF83E, 0x8D80);
+	rtl_mac_ocp_write(hw, 0xF840, 0xC403);
+	rtl_mac_ocp_write(hw, 0xF842, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF844, 0xD3E0);
+	rtl_mac_ocp_write(hw, 0xF846, 0x02C8);
+	rtl_mac_ocp_write(hw, 0xF848, 0x8918);
+	rtl_mac_ocp_write(hw, 0xF84A, 0xE815);
+	rtl_mac_ocp_write(hw, 0xF84C, 0x1100);
+	rtl_mac_ocp_write(hw, 0xF84E, 0xF011);
+	rtl_mac_ocp_write(hw, 0xF850, 0xE812);
+	rtl_mac_ocp_write(hw, 0xF852, 0x4990);
+	rtl_mac_ocp_write(hw, 0xF854, 0xF002);
+	rtl_mac_ocp_write(hw, 0xF856, 0xE817);
+	rtl_mac_ocp_write(hw, 0xF858, 0xE80E);
+	rtl_mac_ocp_write(hw, 0xF85A, 0x4992);
+	rtl_mac_ocp_write(hw, 0xF85C, 0xF002);
+	rtl_mac_ocp_write(hw, 0xF85E, 0xE80E);
+	rtl_mac_ocp_write(hw, 0xF860, 0xE80A);
+	rtl_mac_ocp_write(hw, 0xF862, 0x4993);
+	rtl_mac_ocp_write(hw, 0xF864, 0xF002);
+	rtl_mac_ocp_write(hw, 0xF866, 0xE818);
+	rtl_mac_ocp_write(hw, 0xF868, 0xE806);
+	rtl_mac_ocp_write(hw, 0xF86A, 0x4991);
+	rtl_mac_ocp_write(hw, 0xF86C, 0xF002);
+	rtl_mac_ocp_write(hw, 0xF86E, 0xE838);
+	rtl_mac_ocp_write(hw, 0xF870, 0xC25E);
+	rtl_mac_ocp_write(hw, 0xF872, 0xBA00);
+	rtl_mac_ocp_write(hw, 0xF874, 0xC056);
+	rtl_mac_ocp_write(hw, 0xF876, 0x7100);
+	rtl_mac_ocp_write(hw, 0xF878, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xF87A, 0x7100);
+	rtl_mac_ocp_write(hw, 0xF87C, 0x4892);
+	rtl_mac_ocp_write(hw, 0xF87E, 0x4813);
+	rtl_mac_ocp_write(hw, 0xF880, 0x8900);
+	rtl_mac_ocp_write(hw, 0xF882, 0xE00A);
+	rtl_mac_ocp_write(hw, 0xF884, 0x7100);
+	rtl_mac_ocp_write(hw, 0xF886, 0x4890);
+	rtl_mac_ocp_write(hw, 0xF888, 0x4813);
+	rtl_mac_ocp_write(hw, 0xF88A, 0x8900);
+	rtl_mac_ocp_write(hw, 0xF88C, 0xC74B);
+	rtl_mac_ocp_write(hw, 0xF88E, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF890, 0x48C2);
+	rtl_mac_ocp_write(hw, 0xF892, 0x4841);
+	rtl_mac_ocp_write(hw, 0xF894, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF896, 0xC746);
+	rtl_mac_ocp_write(hw, 0xF898, 0x74FC);
+	rtl_mac_ocp_write(hw, 0xF89A, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF89C, 0xF120);
+	rtl_mac_ocp_write(hw, 0xF89E, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8A0, 0xF11E);
+	rtl_mac_ocp_write(hw, 0xF8A2, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF8A4, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF8A6, 0xF01B);
+	rtl_mac_ocp_write(hw, 0xF8A8, 0x49C6);
+	rtl_mac_ocp_write(hw, 0xF8AA, 0xF119);
+	rtl_mac_ocp_write(hw, 0xF8AC, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF8AE, 0x49C4);
+	rtl_mac_ocp_write(hw, 0xF8B0, 0xF013);
+	rtl_mac_ocp_write(hw, 0xF8B2, 0xC536);
+	rtl_mac_ocp_write(hw, 0xF8B4, 0x74B0);
+	rtl_mac_ocp_write(hw, 0xF8B6, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8B8, 0xF1FD);
+	rtl_mac_ocp_write(hw, 0xF8BA, 0xC537);
+	rtl_mac_ocp_write(hw, 0xF8BC, 0xC434);
+	rtl_mac_ocp_write(hw, 0xF8BE, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xF8C0, 0xC435);
+	rtl_mac_ocp_write(hw, 0xF8C2, 0x1C13);
+	rtl_mac_ocp_write(hw, 0xF8C4, 0x484F);
+	rtl_mac_ocp_write(hw, 0xF8C6, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xF8C8, 0xC52B);
+	rtl_mac_ocp_write(hw, 0xF8CA, 0x74B0);
+	rtl_mac_ocp_write(hw, 0xF8CC, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8CE, 0xF1FD);
+	rtl_mac_ocp_write(hw, 0xF8D0, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF8D2, 0x48C4);
+	rtl_mac_ocp_write(hw, 0xF8D4, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF8D6, 0x7100);
+	rtl_mac_ocp_write(hw, 0xF8D8, 0x4893);
+	rtl_mac_ocp_write(hw, 0xF8DA, 0x8900);
+	rtl_mac_ocp_write(hw, 0xF8DC, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xF8DE, 0xC520);
+	rtl_mac_ocp_write(hw, 0xF8E0, 0x74B0);
+	rtl_mac_ocp_write(hw, 0xF8E2, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8E4, 0xF11C);
+	rtl_mac_ocp_write(hw, 0xF8E6, 0xC71E);
+	rtl_mac_ocp_write(hw, 0xF8E8, 0x74FC);
+	rtl_mac_ocp_write(hw, 0xF8EA, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8EC, 0xF118);
+	rtl_mac_ocp_write(hw, 0xF8EE, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF8F0, 0xF116);
+	rtl_mac_ocp_write(hw, 0xF8F2, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF8F4, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF8F6, 0xF013);
+	rtl_mac_ocp_write(hw, 0xF8F8, 0x48C3);
+	rtl_mac_ocp_write(hw, 0xF8FA, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF8FC, 0xC516);
+	rtl_mac_ocp_write(hw, 0xF8FE, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xF900, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xF902, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xF904, 0xC411);
+	rtl_mac_ocp_write(hw, 0xF906, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xF908, 0xC411);
+	rtl_mac_ocp_write(hw, 0xF90A, 0x1C13);
+	rtl_mac_ocp_write(hw, 0xF90C, 0x484F);
+	rtl_mac_ocp_write(hw, 0xF90E, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xF910, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xF912, 0x49CF);
+	rtl_mac_ocp_write(hw, 0xF914, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xF916, 0x7100);
+	rtl_mac_ocp_write(hw, 0xF918, 0x4891);
+	rtl_mac_ocp_write(hw, 0xF91A, 0x8900);
+	rtl_mac_ocp_write(hw, 0xF91C, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xF91E, 0xE400);
+	rtl_mac_ocp_write(hw, 0xF920, 0xD3E0);
+	rtl_mac_ocp_write(hw, 0xF922, 0xE000);
+	rtl_mac_ocp_write(hw, 0xF924, 0x0481);
+	rtl_mac_ocp_write(hw, 0xF926, 0x0C81);
+	rtl_mac_ocp_write(hw, 0xF928, 0xDE20);
+	rtl_mac_ocp_write(hw, 0xF92A, 0x0000);
+	rtl_mac_ocp_write(hw, 0xF92C, 0x0992);
+	rtl_mac_ocp_write(hw, 0xF92E, 0x1B76);
+	rtl_mac_ocp_write(hw, 0xF930, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF932, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF934, 0x059C);
+	rtl_mac_ocp_write(hw, 0xF936, 0x1B76);
+	rtl_mac_ocp_write(hw, 0xF938, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF93A, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF93C, 0x065A);
+	rtl_mac_ocp_write(hw, 0xF93E, 0xB400);
+	rtl_mac_ocp_write(hw, 0xF940, 0x18DE);
+	rtl_mac_ocp_write(hw, 0xF942, 0x2008);
+	rtl_mac_ocp_write(hw, 0xF944, 0x4001);
+	rtl_mac_ocp_write(hw, 0xF946, 0xF10F);
+	rtl_mac_ocp_write(hw, 0xF948, 0x7342);
+	rtl_mac_ocp_write(hw, 0xF94A, 0x1880);
+	rtl_mac_ocp_write(hw, 0xF94C, 0x2008);
+	rtl_mac_ocp_write(hw, 0xF94E, 0x0009);
+	rtl_mac_ocp_write(hw, 0xF950, 0x4018);
+	rtl_mac_ocp_write(hw, 0xF952, 0xF109);
+	rtl_mac_ocp_write(hw, 0xF954, 0x7340);
+	rtl_mac_ocp_write(hw, 0xF956, 0x25BC);
+	rtl_mac_ocp_write(hw, 0xF958, 0x130F);
+	rtl_mac_ocp_write(hw, 0xF95A, 0xF105);
+	rtl_mac_ocp_write(hw, 0xF95C, 0xC00A);
+	rtl_mac_ocp_write(hw, 0xF95E, 0x7300);
+	rtl_mac_ocp_write(hw, 0xF960, 0x4831);
+	rtl_mac_ocp_write(hw, 0xF962, 0x9B00);
+	rtl_mac_ocp_write(hw, 0xF964, 0xB000);
+	rtl_mac_ocp_write(hw, 0xF966, 0x7340);
+	rtl_mac_ocp_write(hw, 0xF968, 0x8320);
+	rtl_mac_ocp_write(hw, 0xF96A, 0xC302);
+	rtl_mac_ocp_write(hw, 0xF96C, 0xBB00);
+	rtl_mac_ocp_write(hw, 0xF96E, 0x0C12);
+	rtl_mac_ocp_write(hw, 0xF970, 0xE860);
+	rtl_mac_ocp_write(hw, 0xF972, 0xC406);
+	rtl_mac_ocp_write(hw, 0xF974, 0x7580);
+	rtl_mac_ocp_write(hw, 0xF976, 0x4851);
+	rtl_mac_ocp_write(hw, 0xF978, 0x8D80);
+	rtl_mac_ocp_write(hw, 0xF97A, 0xC403);
+	rtl_mac_ocp_write(hw, 0xF97C, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF97E, 0xD3E0);
+	rtl_mac_ocp_write(hw, 0xF980, 0x02C8);
+	rtl_mac_ocp_write(hw, 0xF982, 0xC406);
+	rtl_mac_ocp_write(hw, 0xF984, 0x7580);
+	rtl_mac_ocp_write(hw, 0xF986, 0x4850);
+	rtl_mac_ocp_write(hw, 0xF988, 0x8D80);
+	rtl_mac_ocp_write(hw, 0xF98A, 0xC403);
+	rtl_mac_ocp_write(hw, 0xF98C, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF98E, 0xD3E0);
+	rtl_mac_ocp_write(hw, 0xF990, 0x0298);
+
+	rtl_mac_ocp_write(hw, 0xDE30, 0x0080);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x0075);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x02B1);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0991);
+	rtl_mac_ocp_write(hw, 0xFC2E, 0x059B);
+	rtl_mac_ocp_write(hw, 0xFC30, 0x0659);
+	rtl_mac_ocp_write(hw, 0xFC32, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC34, 0x02C7);
+	rtl_mac_ocp_write(hw, 0xFC36, 0x0279);
+}
+
+/* ------------------------------------MAC 8168GU1---------------------------------- */
+
+static void
+rtl8168_set_mac_mcu_8168gu_1(struct rtl_hw *hw)
+{
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	rtl_mac_ocp_write(hw, 0xF800, 0xE008);
+	rtl_mac_ocp_write(hw, 0xF802, 0xE011);
+	rtl_mac_ocp_write(hw, 0xF804, 0xE015);
+	rtl_mac_ocp_write(hw, 0xF806, 0xE018);
+	rtl_mac_ocp_write(hw, 0xF808, 0xE01B);
+	rtl_mac_ocp_write(hw, 0xF80A, 0xE027);
+	rtl_mac_ocp_write(hw, 0xF80C, 0xE043);
+	rtl_mac_ocp_write(hw, 0xF80E, 0xE065);
+	rtl_mac_ocp_write(hw, 0xF810, 0x49E2);
+	rtl_mac_ocp_write(hw, 0xF812, 0xF005);
+	rtl_mac_ocp_write(hw, 0xF814, 0x49EA);
+	rtl_mac_ocp_write(hw, 0xF816, 0xF003);
+	rtl_mac_ocp_write(hw, 0xF818, 0xC404);
+	rtl_mac_ocp_write(hw, 0xF81A, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF81C, 0xC403);
+	rtl_mac_ocp_write(hw, 0xF81E, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF820, 0x0496);
+	rtl_mac_ocp_write(hw, 0xF822, 0x051A);
+	rtl_mac_ocp_write(hw, 0xF824, 0x1D01);
+	rtl_mac_ocp_write(hw, 0xF826, 0x8DE8);
+	rtl_mac_ocp_write(hw, 0xF828, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF82A, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF82C, 0x0206);
+	rtl_mac_ocp_write(hw, 0xF82E, 0x1B76);
+	rtl_mac_ocp_write(hw, 0xF830, 0xC202);
+	rtl_mac_ocp_write(hw, 0xF832, 0xBA00);
+	rtl_mac_ocp_write(hw, 0xF834, 0x058A);
+	rtl_mac_ocp_write(hw, 0xF836, 0x1B76);
+	rtl_mac_ocp_write(hw, 0xF838, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF83A, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF83C, 0x0648);
+	rtl_mac_ocp_write(hw, 0xF83E, 0x74E6);
+	rtl_mac_ocp_write(hw, 0xF840, 0x1B78);
+	rtl_mac_ocp_write(hw, 0xF842, 0x46DC);
+	rtl_mac_ocp_write(hw, 0xF844, 0x1300);
+	rtl_mac_ocp_write(hw, 0xF846, 0xF005);
+	rtl_mac_ocp_write(hw, 0xF848, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF84A, 0x48C3);
+	rtl_mac_ocp_write(hw, 0xF84C, 0x48C4);
+	rtl_mac_ocp_write(hw, 0xF84E, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF850, 0x64E7);
+	rtl_mac_ocp_write(hw, 0xF852, 0xC302);
+	rtl_mac_ocp_write(hw, 0xF854, 0xBB00);
+	rtl_mac_ocp_write(hw, 0xF856, 0x068E);
+	rtl_mac_ocp_write(hw, 0xF858, 0x74E4);
+	rtl_mac_ocp_write(hw, 0xF85A, 0x49C5);
+	rtl_mac_ocp_write(hw, 0xF85C, 0xF106);
+	rtl_mac_ocp_write(hw, 0xF85E, 0x49C6);
+	rtl_mac_ocp_write(hw, 0xF860, 0xF107);
+	rtl_mac_ocp_write(hw, 0xF862, 0x48C8);
+	rtl_mac_ocp_write(hw, 0xF864, 0x48C9);
+	rtl_mac_ocp_write(hw, 0xF866, 0xE011);
+	rtl_mac_ocp_write(hw, 0xF868, 0x48C9);
+	rtl_mac_ocp_write(hw, 0xF86A, 0x4848);
+	rtl_mac_ocp_write(hw, 0xF86C, 0xE00E);
+	rtl_mac_ocp_write(hw, 0xF86E, 0x4848);
+	rtl_mac_ocp_write(hw, 0xF870, 0x49C7);
+	rtl_mac_ocp_write(hw, 0xF872, 0xF00A);
+	rtl_mac_ocp_write(hw, 0xF874, 0x48C9);
+	rtl_mac_ocp_write(hw, 0xF876, 0xC60D);
+	rtl_mac_ocp_write(hw, 0xF878, 0x1D1F);
+	rtl_mac_ocp_write(hw, 0xF87A, 0x8DC2);
+	rtl_mac_ocp_write(hw, 0xF87C, 0x1D00);
+	rtl_mac_ocp_write(hw, 0xF87E, 0x8DC3);
+	rtl_mac_ocp_write(hw, 0xF880, 0x1D11);
+	rtl_mac_ocp_write(hw, 0xF882, 0x8DC0);
+	rtl_mac_ocp_write(hw, 0xF884, 0xE002);
+	rtl_mac_ocp_write(hw, 0xF886, 0x4849);
+	rtl_mac_ocp_write(hw, 0xF888, 0x94E5);
+	rtl_mac_ocp_write(hw, 0xF88A, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF88C, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF88E, 0x0238);
+	rtl_mac_ocp_write(hw, 0xF890, 0xE434);
+	rtl_mac_ocp_write(hw, 0xF892, 0x49D9);
+	rtl_mac_ocp_write(hw, 0xF894, 0xF01B);
+	rtl_mac_ocp_write(hw, 0xF896, 0xC31E);
+	rtl_mac_ocp_write(hw, 0xF898, 0x7464);
+	rtl_mac_ocp_write(hw, 0xF89A, 0x49C4);
+	rtl_mac_ocp_write(hw, 0xF89C, 0xF114);
+	rtl_mac_ocp_write(hw, 0xF89E, 0xC31B);
+	rtl_mac_ocp_write(hw, 0xF8A0, 0x6460);
+	rtl_mac_ocp_write(hw, 0xF8A2, 0x14FA);
+	rtl_mac_ocp_write(hw, 0xF8A4, 0xFA02);
+	rtl_mac_ocp_write(hw, 0xF8A6, 0xE00F);
+	rtl_mac_ocp_write(hw, 0xF8A8, 0xC317);
+	rtl_mac_ocp_write(hw, 0xF8AA, 0x7460);
+	rtl_mac_ocp_write(hw, 0xF8AC, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF8AE, 0xF10B);
+	rtl_mac_ocp_write(hw, 0xF8B0, 0xC311);
+	rtl_mac_ocp_write(hw, 0xF8B2, 0x7462);
+	rtl_mac_ocp_write(hw, 0xF8B4, 0x48C1);
+	rtl_mac_ocp_write(hw, 0xF8B6, 0x9C62);
+	rtl_mac_ocp_write(hw, 0xF8B8, 0x4841);
+	rtl_mac_ocp_write(hw, 0xF8BA, 0x9C62);
+	rtl_mac_ocp_write(hw, 0xF8BC, 0xC30A);
+	rtl_mac_ocp_write(hw, 0xF8BE, 0x1C04);
+	rtl_mac_ocp_write(hw, 0xF8C0, 0x8C60);
+	rtl_mac_ocp_write(hw, 0xF8C2, 0xE004);
+	rtl_mac_ocp_write(hw, 0xF8C4, 0x1C15);
+	rtl_mac_ocp_write(hw, 0xF8C6, 0xC305);
+	rtl_mac_ocp_write(hw, 0xF8C8, 0x8C60);
+	rtl_mac_ocp_write(hw, 0xF8CA, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF8CC, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF8CE, 0x0374);
+	rtl_mac_ocp_write(hw, 0xF8D0, 0xE434);
+	rtl_mac_ocp_write(hw, 0xF8D2, 0xE030);
+	rtl_mac_ocp_write(hw, 0xF8D4, 0xE61C);
+	rtl_mac_ocp_write(hw, 0xF8D6, 0xE906);
+	rtl_mac_ocp_write(hw, 0xF8D8, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF8DA, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF8DC, 0x0000);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x0493);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x0205);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0589);
+	rtl_mac_ocp_write(hw, 0xFC2E, 0x0647);
+	rtl_mac_ocp_write(hw, 0xFC30, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC32, 0x0215);
+	rtl_mac_ocp_write(hw, 0xFC34, 0x0285);
+}
+
+/* ------------------------------------MAC 8168GU2------------------------------------- */
+
+static void
+rtl8168_set_mac_mcu_8168gu_2(struct rtl_hw *hw)
+{
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	rtl_mac_ocp_write(hw, 0xF800, 0xE008);
+	rtl_mac_ocp_write(hw, 0xF802, 0xE00A);
+	rtl_mac_ocp_write(hw, 0xF804, 0xE00D);
+	rtl_mac_ocp_write(hw, 0xF806, 0xE02F);
+	rtl_mac_ocp_write(hw, 0xF808, 0xE031);
+	rtl_mac_ocp_write(hw, 0xF80A, 0xE038);
+	rtl_mac_ocp_write(hw, 0xF80C, 0xE03A);
+	rtl_mac_ocp_write(hw, 0xF80E, 0xE051);
+	rtl_mac_ocp_write(hw, 0xF810, 0xC202);
+	rtl_mac_ocp_write(hw, 0xF812, 0xBA00);
+	rtl_mac_ocp_write(hw, 0xF814, 0x0DFC);
+	rtl_mac_ocp_write(hw, 0xF816, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF818, 0xC502);
+	rtl_mac_ocp_write(hw, 0xF81A, 0xBD00);
+	rtl_mac_ocp_write(hw, 0xF81C, 0x0A30);
+	rtl_mac_ocp_write(hw, 0xF81E, 0x49D9);
+	rtl_mac_ocp_write(hw, 0xF820, 0xF019);
+	rtl_mac_ocp_write(hw, 0xF822, 0xC520);
+	rtl_mac_ocp_write(hw, 0xF824, 0x64A5);
+	rtl_mac_ocp_write(hw, 0xF826, 0x1400);
+	rtl_mac_ocp_write(hw, 0xF828, 0xF007);
+	rtl_mac_ocp_write(hw, 0xF82A, 0x0C01);
+	rtl_mac_ocp_write(hw, 0xF82C, 0x8CA5);
+	rtl_mac_ocp_write(hw, 0xF82E, 0x1C15);
+	rtl_mac_ocp_write(hw, 0xF830, 0xC515);
+	rtl_mac_ocp_write(hw, 0xF832, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xF834, 0xE00F);
+	rtl_mac_ocp_write(hw, 0xF836, 0xC513);
+	rtl_mac_ocp_write(hw, 0xF838, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xF83A, 0x48C8);
+	rtl_mac_ocp_write(hw, 0xF83C, 0x48CA);
+	rtl_mac_ocp_write(hw, 0xF83E, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xF840, 0xC510);
+	rtl_mac_ocp_write(hw, 0xF842, 0x1B00);
+	rtl_mac_ocp_write(hw, 0xF844, 0x9BA0);
+	rtl_mac_ocp_write(hw, 0xF846, 0x1B1C);
+	rtl_mac_ocp_write(hw, 0xF848, 0x483F);
+	rtl_mac_ocp_write(hw, 0xF84A, 0x9BA2);
+	rtl_mac_ocp_write(hw, 0xF84C, 0x1B04);
+	rtl_mac_ocp_write(hw, 0xF84E, 0xC506);
+	rtl_mac_ocp_write(hw, 0xF850, 0x9BA0);
+	rtl_mac_ocp_write(hw, 0xF852, 0xC603);
+	rtl_mac_ocp_write(hw, 0xF854, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF856, 0x0298);
+	rtl_mac_ocp_write(hw, 0xF858, 0x03DE);
+	rtl_mac_ocp_write(hw, 0xF85A, 0xE434);
+	rtl_mac_ocp_write(hw, 0xF85C, 0xE096);
+	rtl_mac_ocp_write(hw, 0xF85E, 0xE860);
+	rtl_mac_ocp_write(hw, 0xF860, 0xDE20);
+	rtl_mac_ocp_write(hw, 0xF862, 0xD3C0);
+	rtl_mac_ocp_write(hw, 0xF864, 0xC602);
+	rtl_mac_ocp_write(hw, 0xF866, 0xBE00);
+	rtl_mac_ocp_write(hw, 0xF868, 0x0A64);
+	rtl_mac_ocp_write(hw, 0xF86A, 0xC707);
+	rtl_mac_ocp_write(hw, 0xF86C, 0x1D00);
+	rtl_mac_ocp_write(hw, 0xF86E, 0x8DE2);
+	rtl_mac_ocp_write(hw, 0xF870, 0x48C1);
+	rtl_mac_ocp_write(hw, 0xF872, 0xC502);
+	rtl_mac_ocp_write(hw, 0xF874, 0xBD00);
+	rtl_mac_ocp_write(hw, 0xF876, 0x00AA);
+	rtl_mac_ocp_write(hw, 0xF878, 0xE0C0);
+	rtl_mac_ocp_write(hw, 0xF87A, 0xC502);
+	rtl_mac_ocp_write(hw, 0xF87C, 0xBD00);
+	rtl_mac_ocp_write(hw, 0xF87E, 0x0132);
+	rtl_mac_ocp_write(hw, 0xF880, 0xC50C);
+	rtl_mac_ocp_write(hw, 0xF882, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xF884, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xF886, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xF888, 0x1C00);
+	rtl_mac_ocp_write(hw, 0xF88A, 0x9EA0);
+	rtl_mac_ocp_write(hw, 0xF88C, 0x1C1C);
+	rtl_mac_ocp_write(hw, 0xF88E, 0x484F);
+	rtl_mac_ocp_write(hw, 0xF890, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xF892, 0xC402);
+	rtl_mac_ocp_write(hw, 0xF894, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xF896, 0x0AFA);
+	rtl_mac_ocp_write(hw, 0xF898, 0xDE20);
+	rtl_mac_ocp_write(hw, 0xF89A, 0xE000);
+	rtl_mac_ocp_write(hw, 0xF89C, 0xE092);
+	rtl_mac_ocp_write(hw, 0xF89E, 0xE430);
+	rtl_mac_ocp_write(hw, 0xF8A0, 0xDE20);
+	rtl_mac_ocp_write(hw, 0xF8A2, 0xE0C0);
+	rtl_mac_ocp_write(hw, 0xF8A4, 0xE860);
+	rtl_mac_ocp_write(hw, 0xF8A6, 0xE84C);
+	rtl_mac_ocp_write(hw, 0xF8A8, 0xB400);
+	rtl_mac_ocp_write(hw, 0xF8AA, 0xB430);
+	rtl_mac_ocp_write(hw, 0xF8AC, 0xE410);
+	rtl_mac_ocp_write(hw, 0xF8AE, 0xC0AE);
+	rtl_mac_ocp_write(hw, 0xF8B0, 0xB407);
+	rtl_mac_ocp_write(hw, 0xF8B2, 0xB406);
+	rtl_mac_ocp_write(hw, 0xF8B4, 0xB405);
+	rtl_mac_ocp_write(hw, 0xF8B6, 0xB404);
+	rtl_mac_ocp_write(hw, 0xF8B8, 0xB403);
+	rtl_mac_ocp_write(hw, 0xF8BA, 0xB402);
+	rtl_mac_ocp_write(hw, 0xF8BC, 0xB401);
+	rtl_mac_ocp_write(hw, 0xF8BE, 0xC7EE);
+	rtl_mac_ocp_write(hw, 0xF8C0, 0x76F4);
+	rtl_mac_ocp_write(hw, 0xF8C2, 0xC2ED);
+	rtl_mac_ocp_write(hw, 0xF8C4, 0xC3ED);
+	rtl_mac_ocp_write(hw, 0xF8C6, 0xC1EF);
+	rtl_mac_ocp_write(hw, 0xF8C8, 0xC5F3);
+	rtl_mac_ocp_write(hw, 0xF8CA, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xF8CC, 0x49CD);
+	rtl_mac_ocp_write(hw, 0xF8CE, 0xF001);
+	rtl_mac_ocp_write(hw, 0xF8D0, 0xC5EE);
+	rtl_mac_ocp_write(hw, 0xF8D2, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xF8D4, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF8D6, 0xF105);
+	rtl_mac_ocp_write(hw, 0xF8D8, 0xC5E4);
+	rtl_mac_ocp_write(hw, 0xF8DA, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xF8DC, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xF8DE, 0xF00B);
+	rtl_mac_ocp_write(hw, 0xF8E0, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF8E2, 0x484B);
+	rtl_mac_ocp_write(hw, 0xF8E4, 0x9C44);
+	rtl_mac_ocp_write(hw, 0xF8E6, 0x1C10);
+	rtl_mac_ocp_write(hw, 0xF8E8, 0x9C62);
+	rtl_mac_ocp_write(hw, 0xF8EA, 0x1C11);
+	rtl_mac_ocp_write(hw, 0xF8EC, 0x8C60);
+	rtl_mac_ocp_write(hw, 0xF8EE, 0x1C00);
+	rtl_mac_ocp_write(hw, 0xF8F0, 0x9CF6);
+	rtl_mac_ocp_write(hw, 0xF8F2, 0xE0EC);
+	rtl_mac_ocp_write(hw, 0xF8F4, 0x49E7);
+	rtl_mac_ocp_write(hw, 0xF8F6, 0xF016);
+	rtl_mac_ocp_write(hw, 0xF8F8, 0x1D80);
+	rtl_mac_ocp_write(hw, 0xF8FA, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xF8FC, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF8FE, 0x4843);
+	rtl_mac_ocp_write(hw, 0xF900, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF902, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF904, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF906, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF908, 0x48C8);
+	rtl_mac_ocp_write(hw, 0xF90A, 0x48C9);
+	rtl_mac_ocp_write(hw, 0xF90C, 0x48CA);
+	rtl_mac_ocp_write(hw, 0xF90E, 0x9C44);
+	rtl_mac_ocp_write(hw, 0xF910, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF912, 0x4844);
+	rtl_mac_ocp_write(hw, 0xF914, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF916, 0x1E01);
+	rtl_mac_ocp_write(hw, 0xF918, 0xE8DB);
+	rtl_mac_ocp_write(hw, 0xF91A, 0x7420);
+	rtl_mac_ocp_write(hw, 0xF91C, 0x48C1);
+	rtl_mac_ocp_write(hw, 0xF91E, 0x9C20);
+	rtl_mac_ocp_write(hw, 0xF920, 0xE0D5);
+	rtl_mac_ocp_write(hw, 0xF922, 0x49E6);
+	rtl_mac_ocp_write(hw, 0xF924, 0xF02A);
+	rtl_mac_ocp_write(hw, 0xF926, 0x1D40);
+	rtl_mac_ocp_write(hw, 0xF928, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xF92A, 0x74FC);
+	rtl_mac_ocp_write(hw, 0xF92C, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF92E, 0xF124);
+	rtl_mac_ocp_write(hw, 0xF930, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF932, 0xF122);
+	rtl_mac_ocp_write(hw, 0xF934, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF936, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF938, 0xF01F);
+	rtl_mac_ocp_write(hw, 0xF93A, 0xE8D3);
+	rtl_mac_ocp_write(hw, 0xF93C, 0x48C4);
+	rtl_mac_ocp_write(hw, 0xF93E, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF940, 0x1E00);
+	rtl_mac_ocp_write(hw, 0xF942, 0xE8C6);
+	rtl_mac_ocp_write(hw, 0xF944, 0xC5B1);
+	rtl_mac_ocp_write(hw, 0xF946, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xF948, 0x49C3);
+	rtl_mac_ocp_write(hw, 0xF94A, 0xF016);
+	rtl_mac_ocp_write(hw, 0xF94C, 0xC5AF);
+	rtl_mac_ocp_write(hw, 0xF94E, 0x74A4);
+	rtl_mac_ocp_write(hw, 0xF950, 0x49C2);
+	rtl_mac_ocp_write(hw, 0xF952, 0xF005);
+	rtl_mac_ocp_write(hw, 0xF954, 0xC5AA);
+	rtl_mac_ocp_write(hw, 0xF956, 0x74B2);
+	rtl_mac_ocp_write(hw, 0xF958, 0x49C9);
+	rtl_mac_ocp_write(hw, 0xF95A, 0xF10E);
+	rtl_mac_ocp_write(hw, 0xF95C, 0xC5A6);
+	rtl_mac_ocp_write(hw, 0xF95E, 0x74A8);
+	rtl_mac_ocp_write(hw, 0xF960, 0x4845);
+	rtl_mac_ocp_write(hw, 0xF962, 0x4846);
+	rtl_mac_ocp_write(hw, 0xF964, 0x4847);
+	rtl_mac_ocp_write(hw, 0xF966, 0x4848);
+	rtl_mac_ocp_write(hw, 0xF968, 0x9CA8);
+	rtl_mac_ocp_write(hw, 0xF96A, 0x74B2);
+	rtl_mac_ocp_write(hw, 0xF96C, 0x4849);
+	rtl_mac_ocp_write(hw, 0xF96E, 0x9CB2);
+	rtl_mac_ocp_write(hw, 0xF970, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xF972, 0x484F);
+	rtl_mac_ocp_write(hw, 0xF974, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xF976, 0xE0AA);
+	rtl_mac_ocp_write(hw, 0xF978, 0x49E4);
+	rtl_mac_ocp_write(hw, 0xF97A, 0xF018);
+	rtl_mac_ocp_write(hw, 0xF97C, 0x1D10);
+	rtl_mac_ocp_write(hw, 0xF97E, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xF980, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF982, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF984, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF986, 0x4843);
+	rtl_mac_ocp_write(hw, 0xF988, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF98A, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF98C, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF98E, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF990, 0x4844);
+	rtl_mac_ocp_write(hw, 0xF992, 0x4842);
+	rtl_mac_ocp_write(hw, 0xF994, 0x4841);
+	rtl_mac_ocp_write(hw, 0xF996, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF998, 0x1E01);
+	rtl_mac_ocp_write(hw, 0xF99A, 0xE89A);
+	rtl_mac_ocp_write(hw, 0xF99C, 0x7420);
+	rtl_mac_ocp_write(hw, 0xF99E, 0x4841);
+	rtl_mac_ocp_write(hw, 0xF9A0, 0x9C20);
+	rtl_mac_ocp_write(hw, 0xF9A2, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF9A4, 0x4848);
+	rtl_mac_ocp_write(hw, 0xF9A6, 0x9C44);
+	rtl_mac_ocp_write(hw, 0xF9A8, 0xE091);
+	rtl_mac_ocp_write(hw, 0xF9AA, 0x49E5);
+	rtl_mac_ocp_write(hw, 0xF9AC, 0xF03E);
+	rtl_mac_ocp_write(hw, 0xF9AE, 0x1D20);
+	rtl_mac_ocp_write(hw, 0xF9B0, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xF9B2, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF9B4, 0x48C2);
+	rtl_mac_ocp_write(hw, 0xF9B6, 0x4841);
+	rtl_mac_ocp_write(hw, 0xF9B8, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF9BA, 0x1E01);
+	rtl_mac_ocp_write(hw, 0xF9BC, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF9BE, 0x49CA);
+	rtl_mac_ocp_write(hw, 0xF9C0, 0xF103);
+	rtl_mac_ocp_write(hw, 0xF9C2, 0x49C2);
+	rtl_mac_ocp_write(hw, 0xF9C4, 0xF00C);
+	rtl_mac_ocp_write(hw, 0xF9C6, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF9C8, 0xF004);
+	rtl_mac_ocp_write(hw, 0xF9CA, 0x6447);
+	rtl_mac_ocp_write(hw, 0xF9CC, 0x2244);
+	rtl_mac_ocp_write(hw, 0xF9CE, 0xE002);
+	rtl_mac_ocp_write(hw, 0xF9D0, 0x1C01);
+	rtl_mac_ocp_write(hw, 0xF9D2, 0x9C62);
+	rtl_mac_ocp_write(hw, 0xF9D4, 0x1C11);
+	rtl_mac_ocp_write(hw, 0xF9D6, 0x8C60);
+	rtl_mac_ocp_write(hw, 0xF9D8, 0x1C00);
+	rtl_mac_ocp_write(hw, 0xF9DA, 0x9CF6);
+	rtl_mac_ocp_write(hw, 0xF9DC, 0x7444);
+	rtl_mac_ocp_write(hw, 0xF9DE, 0x49C8);
+	rtl_mac_ocp_write(hw, 0xF9E0, 0xF01D);
+	rtl_mac_ocp_write(hw, 0xF9E2, 0x74FC);
+	rtl_mac_ocp_write(hw, 0xF9E4, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF9E6, 0xF11A);
+	rtl_mac_ocp_write(hw, 0xF9E8, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xF9EA, 0xF118);
+	rtl_mac_ocp_write(hw, 0xF9EC, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xF9EE, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xF9F0, 0xF015);
+	rtl_mac_ocp_write(hw, 0xF9F2, 0x49C6);
+	rtl_mac_ocp_write(hw, 0xF9F4, 0xF113);
+	rtl_mac_ocp_write(hw, 0xF9F6, 0xE875);
+	rtl_mac_ocp_write(hw, 0xF9F8, 0x48C4);
+	rtl_mac_ocp_write(hw, 0xF9FA, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xF9FC, 0x7420);
+	rtl_mac_ocp_write(hw, 0xF9FE, 0x48C1);
+	rtl_mac_ocp_write(hw, 0xFA00, 0x9C20);
+	rtl_mac_ocp_write(hw, 0xFA02, 0xC50A);
+	rtl_mac_ocp_write(hw, 0xFA04, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFA06, 0x8CA5);
+	rtl_mac_ocp_write(hw, 0xFA08, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xFA0A, 0xC505);
+	rtl_mac_ocp_write(hw, 0xFA0C, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xFA0E, 0x1C11);
+	rtl_mac_ocp_write(hw, 0xFA10, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xFA12, 0xE00A);
+	rtl_mac_ocp_write(hw, 0xFA14, 0xE434);
+	rtl_mac_ocp_write(hw, 0xFA16, 0xD3C0);
+	rtl_mac_ocp_write(hw, 0xFA18, 0xDC00);
+	rtl_mac_ocp_write(hw, 0xFA1A, 0x7444);
+	rtl_mac_ocp_write(hw, 0xFA1C, 0x49CA);
+	rtl_mac_ocp_write(hw, 0xFA1E, 0xF004);
+	rtl_mac_ocp_write(hw, 0xFA20, 0x48CA);
+	rtl_mac_ocp_write(hw, 0xFA22, 0x9C44);
+	rtl_mac_ocp_write(hw, 0xFA24, 0xE855);
+	rtl_mac_ocp_write(hw, 0xFA26, 0xE052);
+	rtl_mac_ocp_write(hw, 0xFA28, 0x49E8);
+	rtl_mac_ocp_write(hw, 0xFA2A, 0xF024);
+	rtl_mac_ocp_write(hw, 0xFA2C, 0x1D01);
+	rtl_mac_ocp_write(hw, 0xFA2E, 0x8DF5);
+	rtl_mac_ocp_write(hw, 0xFA30, 0x7440);
+	rtl_mac_ocp_write(hw, 0xFA32, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xFA34, 0xF11E);
+	rtl_mac_ocp_write(hw, 0xFA36, 0x7444);
+	rtl_mac_ocp_write(hw, 0xFA38, 0x49C8);
+	rtl_mac_ocp_write(hw, 0xFA3A, 0xF01B);
+	rtl_mac_ocp_write(hw, 0xFA3C, 0x49CA);
+	rtl_mac_ocp_write(hw, 0xFA3E, 0xF119);
+	rtl_mac_ocp_write(hw, 0xFA40, 0xC5EC);
+	rtl_mac_ocp_write(hw, 0xFA42, 0x76A4);
+	rtl_mac_ocp_write(hw, 0xFA44, 0x49E3);
+	rtl_mac_ocp_write(hw, 0xFA46, 0xF015);
+	rtl_mac_ocp_write(hw, 0xFA48, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xFA4A, 0xF103);
+	rtl_mac_ocp_write(hw, 0xFA4C, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xFA4E, 0xF011);
+	rtl_mac_ocp_write(hw, 0xFA50, 0x4849);
+	rtl_mac_ocp_write(hw, 0xFA52, 0x9C44);
+	rtl_mac_ocp_write(hw, 0xFA54, 0x1C00);
+	rtl_mac_ocp_write(hw, 0xFA56, 0x9CF6);
+	rtl_mac_ocp_write(hw, 0xFA58, 0x7444);
+	rtl_mac_ocp_write(hw, 0xFA5A, 0x49C1);
+	rtl_mac_ocp_write(hw, 0xFA5C, 0xF004);
+	rtl_mac_ocp_write(hw, 0xFA5E, 0x6446);
+	rtl_mac_ocp_write(hw, 0xFA60, 0x1E07);
+	rtl_mac_ocp_write(hw, 0xFA62, 0xE003);
+	rtl_mac_ocp_write(hw, 0xFA64, 0x1C01);
+	rtl_mac_ocp_write(hw, 0xFA66, 0x1E03);
+	rtl_mac_ocp_write(hw, 0xFA68, 0x9C62);
+	rtl_mac_ocp_write(hw, 0xFA6A, 0x1C11);
+	rtl_mac_ocp_write(hw, 0xFA6C, 0x8C60);
+	rtl_mac_ocp_write(hw, 0xFA6E, 0xE830);
+	rtl_mac_ocp_write(hw, 0xFA70, 0xE02D);
+	rtl_mac_ocp_write(hw, 0xFA72, 0x49E9);
+	rtl_mac_ocp_write(hw, 0xFA74, 0xF004);
+	rtl_mac_ocp_write(hw, 0xFA76, 0x1D02);
+	rtl_mac_ocp_write(hw, 0xFA78, 0x8DF5);
+	rtl_mac_ocp_write(hw, 0xFA7A, 0xE79C);
+	rtl_mac_ocp_write(hw, 0xFA7C, 0x49E3);
+	rtl_mac_ocp_write(hw, 0xFA7E, 0xF006);
+	rtl_mac_ocp_write(hw, 0xFA80, 0x1D08);
+	rtl_mac_ocp_write(hw, 0xFA82, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xFA84, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xFA86, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xFA88, 0xE73A);
+	rtl_mac_ocp_write(hw, 0xFA8A, 0x49E1);
+	rtl_mac_ocp_write(hw, 0xFA8C, 0xF007);
+	rtl_mac_ocp_write(hw, 0xFA8E, 0x1D02);
+	rtl_mac_ocp_write(hw, 0xFA90, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xFA92, 0x1E01);
+	rtl_mac_ocp_write(hw, 0xFA94, 0xE7A7);
+	rtl_mac_ocp_write(hw, 0xFA96, 0xDE20);
+	rtl_mac_ocp_write(hw, 0xFA98, 0xE410);
+	rtl_mac_ocp_write(hw, 0xFA9A, 0x49E0);
+	rtl_mac_ocp_write(hw, 0xFA9C, 0xF017);
+	rtl_mac_ocp_write(hw, 0xFA9E, 0x1D01);
+	rtl_mac_ocp_write(hw, 0xFAA0, 0x8DF4);
+	rtl_mac_ocp_write(hw, 0xFAA2, 0xC5FA);
+	rtl_mac_ocp_write(hw, 0xFAA4, 0x1C00);
+	rtl_mac_ocp_write(hw, 0xFAA6, 0x8CA0);
+	rtl_mac_ocp_write(hw, 0xFAA8, 0x1C1B);
+	rtl_mac_ocp_write(hw, 0xFAAA, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xFAAC, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFAAE, 0x49CF);
+	rtl_mac_ocp_write(hw, 0xFAB0, 0xF0FE);
+	rtl_mac_ocp_write(hw, 0xFAB2, 0xC5F3);
+	rtl_mac_ocp_write(hw, 0xFAB4, 0x74A0);
+	rtl_mac_ocp_write(hw, 0xFAB6, 0x4849);
+	rtl_mac_ocp_write(hw, 0xFAB8, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xFABA, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xFABC, 0x49C0);
+	rtl_mac_ocp_write(hw, 0xFABE, 0xF006);
+	rtl_mac_ocp_write(hw, 0xFAC0, 0x48C3);
+	rtl_mac_ocp_write(hw, 0xFAC2, 0x8CF8);
+	rtl_mac_ocp_write(hw, 0xFAC4, 0xE820);
+	rtl_mac_ocp_write(hw, 0xFAC6, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xFAC8, 0x74F8);
+	rtl_mac_ocp_write(hw, 0xFACA, 0xC432);
+	rtl_mac_ocp_write(hw, 0xFACC, 0xBC00);
+	rtl_mac_ocp_write(hw, 0xFACE, 0xC5E4);
+	rtl_mac_ocp_write(hw, 0xFAD0, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFAD2, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xFAD4, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xFAD6, 0x9EA0);
+	rtl_mac_ocp_write(hw, 0xFAD8, 0x1C1C);
+	rtl_mac_ocp_write(hw, 0xFADA, 0x484F);
+	rtl_mac_ocp_write(hw, 0xFADC, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xFADE, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xFAE0, 0xB404);
+	rtl_mac_ocp_write(hw, 0xFAE2, 0xB405);
+	rtl_mac_ocp_write(hw, 0xFAE4, 0xC5D9);
+	rtl_mac_ocp_write(hw, 0xFAE6, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFAE8, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xFAEA, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xFAEC, 0xC41F);
+	rtl_mac_ocp_write(hw, 0xFAEE, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xFAF0, 0xC41C);
+	rtl_mac_ocp_write(hw, 0xFAF2, 0x1C13);
+	rtl_mac_ocp_write(hw, 0xFAF4, 0x484F);
+	rtl_mac_ocp_write(hw, 0xFAF6, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xFAF8, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFAFA, 0x49CF);
+	rtl_mac_ocp_write(hw, 0xFAFC, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xFAFE, 0xB005);
+	rtl_mac_ocp_write(hw, 0xFB00, 0xB004);
+	rtl_mac_ocp_write(hw, 0xFB02, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xFB04, 0xB404);
+	rtl_mac_ocp_write(hw, 0xFB06, 0xB405);
+	rtl_mac_ocp_write(hw, 0xFB08, 0xC5C7);
+	rtl_mac_ocp_write(hw, 0xFB0A, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFB0C, 0x49CE);
+	rtl_mac_ocp_write(hw, 0xFB0E, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xFB10, 0xC40E);
+	rtl_mac_ocp_write(hw, 0xFB12, 0x9CA0);
+	rtl_mac_ocp_write(hw, 0xFB14, 0xC40A);
+	rtl_mac_ocp_write(hw, 0xFB16, 0x1C13);
+	rtl_mac_ocp_write(hw, 0xFB18, 0x484F);
+	rtl_mac_ocp_write(hw, 0xFB1A, 0x9CA2);
+	rtl_mac_ocp_write(hw, 0xFB1C, 0x74A2);
+	rtl_mac_ocp_write(hw, 0xFB1E, 0x49CF);
+	rtl_mac_ocp_write(hw, 0xFB20, 0xF1FE);
+	rtl_mac_ocp_write(hw, 0xFB22, 0xB005);
+	rtl_mac_ocp_write(hw, 0xFB24, 0xB004);
+	rtl_mac_ocp_write(hw, 0xFB26, 0xFF80);
+	rtl_mac_ocp_write(hw, 0xFB28, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFB2A, 0x0481);
+	rtl_mac_ocp_write(hw, 0xFB2C, 0x0C81);
+	rtl_mac_ocp_write(hw, 0xFB2E, 0x0AE0);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x0297);
+	rtl_mac_ocp_write(hw, 0xFC2E, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC30, 0x00A9);
+	rtl_mac_ocp_write(hw, 0xFC32, 0x012D);
+	rtl_mac_ocp_write(hw, 0xFC34, 0x0000);
+	rtl_mac_ocp_write(hw, 0xFC36, 0x08DF);
+}
+
+/* ------------------------------------PHY 8168G------------------------------------- */
+
+static void
+rtl8168_set_phy_mcu_8168g_1(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x2300);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0290);
+	rtl_mdio_write(hw, 0x13, 0xA012);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA014);
+	rtl_mdio_write(hw, 0x14, 0x2c04);
+	rtl_mdio_write(hw, 0x14, 0x2c0c);
+	rtl_mdio_write(hw, 0x14, 0x2c6c);
+	rtl_mdio_write(hw, 0x14, 0x2d0d);
+	rtl_mdio_write(hw, 0x14, 0x31ce);
+	rtl_mdio_write(hw, 0x14, 0x506d);
+	rtl_mdio_write(hw, 0x14, 0xd708);
+	rtl_mdio_write(hw, 0x14, 0x3108);
+	rtl_mdio_write(hw, 0x14, 0x106d);
+	rtl_mdio_write(hw, 0x14, 0x1560);
+	rtl_mdio_write(hw, 0x14, 0x15a9);
+	rtl_mdio_write(hw, 0x14, 0x206e);
+	rtl_mdio_write(hw, 0x14, 0x175b);
+	rtl_mdio_write(hw, 0x14, 0x6062);
+	rtl_mdio_write(hw, 0x14, 0xd700);
+	rtl_mdio_write(hw, 0x14, 0x5fae);
+	rtl_mdio_write(hw, 0x14, 0xd708);
+	rtl_mdio_write(hw, 0x14, 0x3107);
+	rtl_mdio_write(hw, 0x14, 0x4c1e);
+	rtl_mdio_write(hw, 0x14, 0x4169);
+	rtl_mdio_write(hw, 0x14, 0x316a);
+	rtl_mdio_write(hw, 0x14, 0x0c19);
+	rtl_mdio_write(hw, 0x14, 0x31aa);
+	rtl_mdio_write(hw, 0x14, 0x0c19);
+	rtl_mdio_write(hw, 0x14, 0x2c1b);
+	rtl_mdio_write(hw, 0x14, 0x5e62);
+	rtl_mdio_write(hw, 0x14, 0x26b5);
+	rtl_mdio_write(hw, 0x14, 0x31ab);
+	rtl_mdio_write(hw, 0x14, 0x5c1e);
+	rtl_mdio_write(hw, 0x14, 0x2c0c);
+	rtl_mdio_write(hw, 0x14, 0xc040);
+	rtl_mdio_write(hw, 0x14, 0x8808);
+	rtl_mdio_write(hw, 0x14, 0xc520);
+	rtl_mdio_write(hw, 0x14, 0xc421);
+	rtl_mdio_write(hw, 0x14, 0xd05a);
+	rtl_mdio_write(hw, 0x14, 0xd19a);
+	rtl_mdio_write(hw, 0x14, 0xd709);
+	rtl_mdio_write(hw, 0x14, 0x608f);
+	rtl_mdio_write(hw, 0x14, 0xd06b);
+	rtl_mdio_write(hw, 0x14, 0xd18a);
+	rtl_mdio_write(hw, 0x14, 0x2c2c);
+	rtl_mdio_write(hw, 0x14, 0xd0be);
+	rtl_mdio_write(hw, 0x14, 0xd188);
+	rtl_mdio_write(hw, 0x14, 0x2c2c);
+	rtl_mdio_write(hw, 0x14, 0xd708);
+	rtl_mdio_write(hw, 0x14, 0x4072);
+	rtl_mdio_write(hw, 0x14, 0xc104);
+	rtl_mdio_write(hw, 0x14, 0x2c3e);
+	rtl_mdio_write(hw, 0x14, 0x4076);
+	rtl_mdio_write(hw, 0x14, 0xc110);
+	rtl_mdio_write(hw, 0x14, 0x2c3e);
+	rtl_mdio_write(hw, 0x14, 0x4071);
+	rtl_mdio_write(hw, 0x14, 0xc102);
+	rtl_mdio_write(hw, 0x14, 0x2c3e);
+	rtl_mdio_write(hw, 0x14, 0x4070);
+	rtl_mdio_write(hw, 0x14, 0xc101);
+	rtl_mdio_write(hw, 0x14, 0x2c3e);
+	rtl_mdio_write(hw, 0x14, 0x175b);
+	rtl_mdio_write(hw, 0x14, 0xd709);
+	rtl_mdio_write(hw, 0x14, 0x3390);
+	rtl_mdio_write(hw, 0x14, 0x5c39);
+	rtl_mdio_write(hw, 0x14, 0x2c4e);
+	rtl_mdio_write(hw, 0x14, 0x175b);
+	rtl_mdio_write(hw, 0x14, 0xd708);
+	rtl_mdio_write(hw, 0x14, 0x6193);
+	rtl_mdio_write(hw, 0x14, 0xd709);
+	rtl_mdio_write(hw, 0x14, 0x5f9d);
+	rtl_mdio_write(hw, 0x14, 0x408b);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x6042);
+	rtl_mdio_write(hw, 0x14, 0xb401);
+	rtl_mdio_write(hw, 0x14, 0x175b);
+	rtl_mdio_write(hw, 0x14, 0xd708);
+	rtl_mdio_write(hw, 0x14, 0x6073);
+	rtl_mdio_write(hw, 0x14, 0x5fbc);
+	rtl_mdio_write(hw, 0x14, 0x2c4d);
+	rtl_mdio_write(hw, 0x14, 0x26ed);
+	rtl_mdio_write(hw, 0x14, 0xb280);
+	rtl_mdio_write(hw, 0x14, 0xa841);
+	rtl_mdio_write(hw, 0x14, 0x9420);
+	rtl_mdio_write(hw, 0x14, 0x8710);
+	rtl_mdio_write(hw, 0x14, 0xd709);
+	rtl_mdio_write(hw, 0x14, 0x42ec);
+	rtl_mdio_write(hw, 0x14, 0x606d);
+	rtl_mdio_write(hw, 0x14, 0xd207);
+	rtl_mdio_write(hw, 0x14, 0x2c57);
+	rtl_mdio_write(hw, 0x14, 0xd203);
+	rtl_mdio_write(hw, 0x14, 0x33ff);
+	rtl_mdio_write(hw, 0x14, 0x563b);
+	rtl_mdio_write(hw, 0x14, 0x3275);
+	rtl_mdio_write(hw, 0x14, 0x7c5e);
+	rtl_mdio_write(hw, 0x14, 0xb240);
+	rtl_mdio_write(hw, 0x14, 0xb402);
+	rtl_mdio_write(hw, 0x14, 0x263b);
+	rtl_mdio_write(hw, 0x14, 0x6096);
+	rtl_mdio_write(hw, 0x14, 0xb240);
+	rtl_mdio_write(hw, 0x14, 0xb406);
+	rtl_mdio_write(hw, 0x14, 0x263b);
+	rtl_mdio_write(hw, 0x14, 0x31d7);
+	rtl_mdio_write(hw, 0x14, 0x7c67);
+	rtl_mdio_write(hw, 0x14, 0xb240);
+	rtl_mdio_write(hw, 0x14, 0xb40e);
+	rtl_mdio_write(hw, 0x14, 0x263b);
+	rtl_mdio_write(hw, 0x14, 0xb410);
+	rtl_mdio_write(hw, 0x14, 0x8802);
+	rtl_mdio_write(hw, 0x14, 0xb240);
+	rtl_mdio_write(hw, 0x14, 0x940e);
+	rtl_mdio_write(hw, 0x14, 0x263b);
+	rtl_mdio_write(hw, 0x14, 0xba04);
+	rtl_mdio_write(hw, 0x14, 0x1cd6);
+	rtl_mdio_write(hw, 0x14, 0xa902);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x4045);
+	rtl_mdio_write(hw, 0x14, 0xa980);
+	rtl_mdio_write(hw, 0x14, 0x3003);
+	rtl_mdio_write(hw, 0x14, 0x59b1);
+	rtl_mdio_write(hw, 0x14, 0xa540);
+	rtl_mdio_write(hw, 0x14, 0xa601);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4043);
+	rtl_mdio_write(hw, 0x14, 0xa910);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x60a0);
+	rtl_mdio_write(hw, 0x14, 0xca33);
+	rtl_mdio_write(hw, 0x14, 0xcb33);
+	rtl_mdio_write(hw, 0x14, 0xa941);
+	rtl_mdio_write(hw, 0x14, 0x2c82);
+	rtl_mdio_write(hw, 0x14, 0xcaff);
+	rtl_mdio_write(hw, 0x14, 0xcbff);
+	rtl_mdio_write(hw, 0x14, 0xa921);
+	rtl_mdio_write(hw, 0x14, 0xce02);
+	rtl_mdio_write(hw, 0x14, 0xe070);
+	rtl_mdio_write(hw, 0x14, 0x0f10);
+	rtl_mdio_write(hw, 0x14, 0xaf01);
+	rtl_mdio_write(hw, 0x14, 0x8f01);
+	rtl_mdio_write(hw, 0x14, 0x1766);
+	rtl_mdio_write(hw, 0x14, 0x8e02);
+	rtl_mdio_write(hw, 0x14, 0x1787);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x609c);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fa4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0x1ce9);
+	rtl_mdio_write(hw, 0x14, 0xce04);
+	rtl_mdio_write(hw, 0x14, 0xe070);
+	rtl_mdio_write(hw, 0x14, 0x0f20);
+	rtl_mdio_write(hw, 0x14, 0xaf01);
+	rtl_mdio_write(hw, 0x14, 0x8f01);
+	rtl_mdio_write(hw, 0x14, 0x1766);
+	rtl_mdio_write(hw, 0x14, 0x8e04);
+	rtl_mdio_write(hw, 0x14, 0x6044);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0xa520);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4043);
+	rtl_mdio_write(hw, 0x14, 0x2cc1);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0501);
+	rtl_mdio_write(hw, 0x14, 0x1cef);
+	rtl_mdio_write(hw, 0x14, 0xb801);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x4060);
+	rtl_mdio_write(hw, 0x14, 0x7fc4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0x1cf5);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0502);
+	rtl_mdio_write(hw, 0x14, 0x1cef);
+	rtl_mdio_write(hw, 0x14, 0xb802);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x4061);
+	rtl_mdio_write(hw, 0x14, 0x7fc4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0x1cf5);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0504);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6099);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fa4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0xc17f);
+	rtl_mdio_write(hw, 0x14, 0xc200);
+	rtl_mdio_write(hw, 0x14, 0xc43f);
+	rtl_mdio_write(hw, 0x14, 0xcc03);
+	rtl_mdio_write(hw, 0x14, 0xa701);
+	rtl_mdio_write(hw, 0x14, 0xa510);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4018);
+	rtl_mdio_write(hw, 0x14, 0x9910);
+	rtl_mdio_write(hw, 0x14, 0x8510);
+	rtl_mdio_write(hw, 0x14, 0x2860);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0504);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6099);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fa4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0xa608);
+	rtl_mdio_write(hw, 0x14, 0xc17d);
+	rtl_mdio_write(hw, 0x14, 0xc200);
+	rtl_mdio_write(hw, 0x14, 0xc43f);
+	rtl_mdio_write(hw, 0x14, 0xcc03);
+	rtl_mdio_write(hw, 0x14, 0xa701);
+	rtl_mdio_write(hw, 0x14, 0xa510);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4018);
+	rtl_mdio_write(hw, 0x14, 0x9910);
+	rtl_mdio_write(hw, 0x14, 0x8510);
+	rtl_mdio_write(hw, 0x14, 0x2926);
+	rtl_mdio_write(hw, 0x14, 0x1792);
+	rtl_mdio_write(hw, 0x14, 0x27db);
+	rtl_mdio_write(hw, 0x14, 0xc000);
+	rtl_mdio_write(hw, 0x14, 0xc100);
+	rtl_mdio_write(hw, 0x14, 0xc200);
+	rtl_mdio_write(hw, 0x14, 0xc300);
+	rtl_mdio_write(hw, 0x14, 0xc400);
+	rtl_mdio_write(hw, 0x14, 0xc500);
+	rtl_mdio_write(hw, 0x14, 0xc600);
+	rtl_mdio_write(hw, 0x14, 0xc7c1);
+	rtl_mdio_write(hw, 0x14, 0xc800);
+	rtl_mdio_write(hw, 0x14, 0xcc00);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xca0f);
+	rtl_mdio_write(hw, 0x14, 0xcbff);
+	rtl_mdio_write(hw, 0x14, 0xa901);
+	rtl_mdio_write(hw, 0x14, 0x8902);
+	rtl_mdio_write(hw, 0x14, 0xc900);
+	rtl_mdio_write(hw, 0x14, 0xca00);
+	rtl_mdio_write(hw, 0x14, 0xcb00);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xb804);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x6044);
+	rtl_mdio_write(hw, 0x14, 0x9804);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6099);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fa4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xa510);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6098);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fa4);
+	rtl_mdio_write(hw, 0x14, 0x2cd4);
+	rtl_mdio_write(hw, 0x14, 0x8510);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x3003);
+	rtl_mdio_write(hw, 0x14, 0x1d01);
+	rtl_mdio_write(hw, 0x14, 0x2d0b);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x60be);
+	rtl_mdio_write(hw, 0x14, 0xe060);
+	rtl_mdio_write(hw, 0x14, 0x0920);
+	rtl_mdio_write(hw, 0x14, 0x1cd6);
+	rtl_mdio_write(hw, 0x14, 0x2c89);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x3063);
+	rtl_mdio_write(hw, 0x14, 0x1948);
+	rtl_mdio_write(hw, 0x14, 0x288a);
+	rtl_mdio_write(hw, 0x14, 0x1cd6);
+	rtl_mdio_write(hw, 0x14, 0x29bd);
+	rtl_mdio_write(hw, 0x14, 0xa802);
+	rtl_mdio_write(hw, 0x14, 0xa303);
+	rtl_mdio_write(hw, 0x14, 0x843f);
+	rtl_mdio_write(hw, 0x14, 0x81ff);
+	rtl_mdio_write(hw, 0x14, 0x8208);
+	rtl_mdio_write(hw, 0x14, 0xa201);
+	rtl_mdio_write(hw, 0x14, 0xc001);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x30a0);
+	rtl_mdio_write(hw, 0x14, 0x0d1c);
+	rtl_mdio_write(hw, 0x14, 0x30a0);
+	rtl_mdio_write(hw, 0x14, 0x3d13);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7f4c);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0xe003);
+	rtl_mdio_write(hw, 0x14, 0x0202);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6090);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fac);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0xa20c);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6091);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fac);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0x820e);
+	rtl_mdio_write(hw, 0x14, 0xa3e0);
+	rtl_mdio_write(hw, 0x14, 0xa520);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x609d);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fac);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0x8520);
+	rtl_mdio_write(hw, 0x14, 0x6703);
+	rtl_mdio_write(hw, 0x14, 0x2d34);
+	rtl_mdio_write(hw, 0x14, 0xa13e);
+	rtl_mdio_write(hw, 0x14, 0xc001);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x6046);
+	rtl_mdio_write(hw, 0x14, 0x2d0d);
+	rtl_mdio_write(hw, 0x14, 0xa43f);
+	rtl_mdio_write(hw, 0x14, 0xa101);
+	rtl_mdio_write(hw, 0x14, 0xc020);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x3121);
+	rtl_mdio_write(hw, 0x14, 0x0d45);
+	rtl_mdio_write(hw, 0x14, 0x30c0);
+	rtl_mdio_write(hw, 0x14, 0x3d0d);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7f4c);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0xa540);
+	rtl_mdio_write(hw, 0x14, 0xc001);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4001);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0501);
+	rtl_mdio_write(hw, 0x14, 0x1dac);
+	rtl_mdio_write(hw, 0x14, 0xc1c4);
+	rtl_mdio_write(hw, 0x14, 0xa268);
+	rtl_mdio_write(hw, 0x14, 0xa303);
+	rtl_mdio_write(hw, 0x14, 0x8420);
+	rtl_mdio_write(hw, 0x14, 0xe00f);
+	rtl_mdio_write(hw, 0x14, 0x0502);
+	rtl_mdio_write(hw, 0x14, 0x1dac);
+	rtl_mdio_write(hw, 0x14, 0xc002);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x8208);
+	rtl_mdio_write(hw, 0x14, 0x8410);
+	rtl_mdio_write(hw, 0x14, 0xa121);
+	rtl_mdio_write(hw, 0x14, 0xc002);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x8120);
+	rtl_mdio_write(hw, 0x14, 0x8180);
+	rtl_mdio_write(hw, 0x14, 0x1d97);
+	rtl_mdio_write(hw, 0x14, 0xa180);
+	rtl_mdio_write(hw, 0x14, 0xa13a);
+	rtl_mdio_write(hw, 0x14, 0x8240);
+	rtl_mdio_write(hw, 0x14, 0xa430);
+	rtl_mdio_write(hw, 0x14, 0xc010);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x30e1);
+	rtl_mdio_write(hw, 0x14, 0x0abc);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7f8c);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0xa480);
+	rtl_mdio_write(hw, 0x14, 0xa230);
+	rtl_mdio_write(hw, 0x14, 0xa303);
+	rtl_mdio_write(hw, 0x14, 0xc001);
+	rtl_mdio_write(hw, 0x14, 0xd70c);
+	rtl_mdio_write(hw, 0x14, 0x4124);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x6120);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x3128);
+	rtl_mdio_write(hw, 0x14, 0x3d76);
+	rtl_mdio_write(hw, 0x14, 0x2d70);
+	rtl_mdio_write(hw, 0x14, 0xa801);
+	rtl_mdio_write(hw, 0x14, 0x2d6c);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0xe018);
+	rtl_mdio_write(hw, 0x14, 0x0208);
+	rtl_mdio_write(hw, 0x14, 0xa1f8);
+	rtl_mdio_write(hw, 0x14, 0x8480);
+	rtl_mdio_write(hw, 0x14, 0xc004);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x6046);
+	rtl_mdio_write(hw, 0x14, 0x2d0d);
+	rtl_mdio_write(hw, 0x14, 0xa43f);
+	rtl_mdio_write(hw, 0x14, 0xa105);
+	rtl_mdio_write(hw, 0x14, 0x8228);
+	rtl_mdio_write(hw, 0x14, 0xc004);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x81bc);
+	rtl_mdio_write(hw, 0x14, 0xa220);
+	rtl_mdio_write(hw, 0x14, 0x1d97);
+	rtl_mdio_write(hw, 0x14, 0x8220);
+	rtl_mdio_write(hw, 0x14, 0xa1bc);
+	rtl_mdio_write(hw, 0x14, 0xc040);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x30e1);
+	rtl_mdio_write(hw, 0x14, 0x0abc);
+	rtl_mdio_write(hw, 0x14, 0x30e1);
+	rtl_mdio_write(hw, 0x14, 0x3d0d);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7f4c);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0xa802);
+	rtl_mdio_write(hw, 0x14, 0xd70c);
+	rtl_mdio_write(hw, 0x14, 0x4244);
+	rtl_mdio_write(hw, 0x14, 0xa301);
+	rtl_mdio_write(hw, 0x14, 0xc004);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x3128);
+	rtl_mdio_write(hw, 0x14, 0x3da5);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x5f80);
+	rtl_mdio_write(hw, 0x14, 0xd711);
+	rtl_mdio_write(hw, 0x14, 0x3109);
+	rtl_mdio_write(hw, 0x14, 0x3da7);
+	rtl_mdio_write(hw, 0x14, 0x2dab);
+	rtl_mdio_write(hw, 0x14, 0xa801);
+	rtl_mdio_write(hw, 0x14, 0x2d9a);
+	rtl_mdio_write(hw, 0x14, 0xa802);
+	rtl_mdio_write(hw, 0x14, 0xc004);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x4000);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x14, 0xa510);
+	rtl_mdio_write(hw, 0x14, 0xd710);
+	rtl_mdio_write(hw, 0x14, 0x609a);
+	rtl_mdio_write(hw, 0x14, 0xd71e);
+	rtl_mdio_write(hw, 0x14, 0x7fac);
+	rtl_mdio_write(hw, 0x14, 0x2ab6);
+	rtl_mdio_write(hw, 0x14, 0x8510);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x13, 0xA01A);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA006);
+	rtl_mdio_write(hw, 0x14, 0x0ad6);
+	rtl_mdio_write(hw, 0x13, 0xA004);
+	rtl_mdio_write(hw, 0x14, 0x07f5);
+	rtl_mdio_write(hw, 0x13, 0xA002);
+	rtl_mdio_write(hw, 0x14, 0x06a9);
+	rtl_mdio_write(hw, 0x13, 0xA000);
+	rtl_mdio_write(hw, 0x14, 0xf069);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x83a0);
+	rtl_mdio_write(hw, 0x14, 0xaf83);
+	rtl_mdio_write(hw, 0x14, 0xacaf);
+	rtl_mdio_write(hw, 0x14, 0x83b8);
+	rtl_mdio_write(hw, 0x14, 0xaf83);
+	rtl_mdio_write(hw, 0x14, 0xcdaf);
+	rtl_mdio_write(hw, 0x14, 0x83d3);
+	rtl_mdio_write(hw, 0x14, 0x0204);
+	rtl_mdio_write(hw, 0x14, 0x9a02);
+	rtl_mdio_write(hw, 0x14, 0x09a9);
+	rtl_mdio_write(hw, 0x14, 0x0284);
+	rtl_mdio_write(hw, 0x14, 0x61af);
+	rtl_mdio_write(hw, 0x14, 0x02fc);
+	rtl_mdio_write(hw, 0x14, 0xad20);
+	rtl_mdio_write(hw, 0x14, 0x0302);
+	rtl_mdio_write(hw, 0x14, 0x867c);
+	rtl_mdio_write(hw, 0x14, 0xad21);
+	rtl_mdio_write(hw, 0x14, 0x0302);
+	rtl_mdio_write(hw, 0x14, 0x85c9);
+	rtl_mdio_write(hw, 0x14, 0xad22);
+	rtl_mdio_write(hw, 0x14, 0x0302);
+	rtl_mdio_write(hw, 0x14, 0x1bc0);
+	rtl_mdio_write(hw, 0x14, 0xaf17);
+	rtl_mdio_write(hw, 0x14, 0xe302);
+	rtl_mdio_write(hw, 0x14, 0x8703);
+	rtl_mdio_write(hw, 0x14, 0xaf18);
+	rtl_mdio_write(hw, 0x14, 0x6201);
+	rtl_mdio_write(hw, 0x14, 0x06e0);
+	rtl_mdio_write(hw, 0x14, 0x8148);
+	rtl_mdio_write(hw, 0x14, 0xaf3c);
+	rtl_mdio_write(hw, 0x14, 0x69f8);
+	rtl_mdio_write(hw, 0x14, 0xf9fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0x10f7);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0x131f);
+	rtl_mdio_write(hw, 0x14, 0xd104);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0xf302);
+	rtl_mdio_write(hw, 0x14, 0x4259);
+	rtl_mdio_write(hw, 0x14, 0x0287);
+	rtl_mdio_write(hw, 0x14, 0x88bf);
+	rtl_mdio_write(hw, 0x14, 0x87cf);
+	rtl_mdio_write(hw, 0x14, 0xd7b8);
+	rtl_mdio_write(hw, 0x14, 0x22d0);
+	rtl_mdio_write(hw, 0x14, 0x0c02);
+	rtl_mdio_write(hw, 0x14, 0x4252);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xcda0);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xce8b);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xd1f5);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xd2a9);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xd30a);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xf010);
+	rtl_mdio_write(hw, 0x14, 0xee80);
+	rtl_mdio_write(hw, 0x14, 0xf38f);
+	rtl_mdio_write(hw, 0x14, 0xee81);
+	rtl_mdio_write(hw, 0x14, 0x011e);
+	rtl_mdio_write(hw, 0x14, 0xee81);
+	rtl_mdio_write(hw, 0x14, 0x0b4a);
+	rtl_mdio_write(hw, 0x14, 0xee81);
+	rtl_mdio_write(hw, 0x14, 0x0c7c);
+	rtl_mdio_write(hw, 0x14, 0xee81);
+	rtl_mdio_write(hw, 0x14, 0x127f);
+	rtl_mdio_write(hw, 0x14, 0xd100);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+	rtl_mdio_write(hw, 0x14, 0xb5ee);
+	rtl_mdio_write(hw, 0x14, 0x8088);
+	rtl_mdio_write(hw, 0x14, 0xa4ee);
+	rtl_mdio_write(hw, 0x14, 0x8089);
+	rtl_mdio_write(hw, 0x14, 0x44ee);
+	rtl_mdio_write(hw, 0x14, 0x809a);
+	rtl_mdio_write(hw, 0x14, 0xa4ee);
+	rtl_mdio_write(hw, 0x14, 0x809b);
+	rtl_mdio_write(hw, 0x14, 0x44ee);
+	rtl_mdio_write(hw, 0x14, 0x809c);
+	rtl_mdio_write(hw, 0x14, 0xa7ee);
+	rtl_mdio_write(hw, 0x14, 0x80a5);
+	rtl_mdio_write(hw, 0x14, 0xa7d2);
+	rtl_mdio_write(hw, 0x14, 0x0002);
+	rtl_mdio_write(hw, 0x14, 0x0e66);
+	rtl_mdio_write(hw, 0x14, 0x0285);
+	rtl_mdio_write(hw, 0x14, 0xc0ee);
+	rtl_mdio_write(hw, 0x14, 0x87fc);
+	rtl_mdio_write(hw, 0x14, 0x00e0);
+	rtl_mdio_write(hw, 0x14, 0x8245);
+	rtl_mdio_write(hw, 0x14, 0xf622);
+	rtl_mdio_write(hw, 0x14, 0xe482);
+	rtl_mdio_write(hw, 0x14, 0x45ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfdfc);
+	rtl_mdio_write(hw, 0x14, 0x0402);
+	rtl_mdio_write(hw, 0x14, 0x847a);
+	rtl_mdio_write(hw, 0x14, 0x0284);
+	rtl_mdio_write(hw, 0x14, 0xb302);
+	rtl_mdio_write(hw, 0x14, 0x0cab);
+	rtl_mdio_write(hw, 0x14, 0x020c);
+	rtl_mdio_write(hw, 0x14, 0xc402);
+	rtl_mdio_write(hw, 0x14, 0x0cef);
+	rtl_mdio_write(hw, 0x14, 0x020d);
+	rtl_mdio_write(hw, 0x14, 0x0802);
+	rtl_mdio_write(hw, 0x14, 0x0d33);
+	rtl_mdio_write(hw, 0x14, 0x020c);
+	rtl_mdio_write(hw, 0x14, 0x3d04);
+	rtl_mdio_write(hw, 0x14, 0xf8fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe182);
+	rtl_mdio_write(hw, 0x14, 0x2fac);
+	rtl_mdio_write(hw, 0x14, 0x291a);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x24ac);
+	rtl_mdio_write(hw, 0x14, 0x2102);
+	rtl_mdio_write(hw, 0x14, 0xae22);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+	rtl_mdio_write(hw, 0x14, 0x57f6);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8224);
+	rtl_mdio_write(hw, 0x14, 0xd101);
+	rtl_mdio_write(hw, 0x14, 0xbf44);
+	rtl_mdio_write(hw, 0x14, 0xd202);
+	rtl_mdio_write(hw, 0x14, 0x4259);
+	rtl_mdio_write(hw, 0x14, 0xae10);
+	rtl_mdio_write(hw, 0x14, 0x0212);
+	rtl_mdio_write(hw, 0x14, 0x4cf6);
+	rtl_mdio_write(hw, 0x14, 0x29e5);
+	rtl_mdio_write(hw, 0x14, 0x822f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x24f6);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8224);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xe182);
+	rtl_mdio_write(hw, 0x14, 0x2fac);
+	rtl_mdio_write(hw, 0x14, 0x2a18);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x24ac);
+	rtl_mdio_write(hw, 0x14, 0x2202);
+	rtl_mdio_write(hw, 0x14, 0xae26);
+	rtl_mdio_write(hw, 0x14, 0x0284);
+	rtl_mdio_write(hw, 0x14, 0xf802);
+	rtl_mdio_write(hw, 0x14, 0x8565);
+	rtl_mdio_write(hw, 0x14, 0xd101);
+	rtl_mdio_write(hw, 0x14, 0xbf44);
+	rtl_mdio_write(hw, 0x14, 0xd502);
+	rtl_mdio_write(hw, 0x14, 0x4259);
+	rtl_mdio_write(hw, 0x14, 0xae0e);
+	rtl_mdio_write(hw, 0x14, 0x0284);
+	rtl_mdio_write(hw, 0x14, 0xea02);
+	rtl_mdio_write(hw, 0x14, 0x85a9);
+	rtl_mdio_write(hw, 0x14, 0xe182);
+	rtl_mdio_write(hw, 0x14, 0x2ff6);
+	rtl_mdio_write(hw, 0x14, 0x2ae5);
+	rtl_mdio_write(hw, 0x14, 0x822f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x24f6);
+	rtl_mdio_write(hw, 0x14, 0x22e4);
+	rtl_mdio_write(hw, 0x14, 0x8224);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf9e2);
+	rtl_mdio_write(hw, 0x14, 0x8011);
+	rtl_mdio_write(hw, 0x14, 0xad31);
+	rtl_mdio_write(hw, 0x14, 0x05d2);
+	rtl_mdio_write(hw, 0x14, 0x0002);
+	rtl_mdio_write(hw, 0x14, 0x0e66);
+	rtl_mdio_write(hw, 0x14, 0xfd04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69e0);
+	rtl_mdio_write(hw, 0x14, 0x8011);
+	rtl_mdio_write(hw, 0x14, 0xad21);
+	rtl_mdio_write(hw, 0x14, 0x5cbf);
+	rtl_mdio_write(hw, 0x14, 0x43be);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97ac);
+	rtl_mdio_write(hw, 0x14, 0x281b);
+	rtl_mdio_write(hw, 0x14, 0xbf43);
+	rtl_mdio_write(hw, 0x14, 0xc102);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0xac28);
+	rtl_mdio_write(hw, 0x14, 0x12bf);
+	rtl_mdio_write(hw, 0x14, 0x43c7);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97ac);
+	rtl_mdio_write(hw, 0x14, 0x2804);
+	rtl_mdio_write(hw, 0x14, 0xd300);
+	rtl_mdio_write(hw, 0x14, 0xae07);
+	rtl_mdio_write(hw, 0x14, 0xd306);
+	rtl_mdio_write(hw, 0x14, 0xaf85);
+	rtl_mdio_write(hw, 0x14, 0x56d3);
+	rtl_mdio_write(hw, 0x14, 0x03e0);
+	rtl_mdio_write(hw, 0x14, 0x8011);
+	rtl_mdio_write(hw, 0x14, 0xad26);
+	rtl_mdio_write(hw, 0x14, 0x25bf);
+	rtl_mdio_write(hw, 0x14, 0x4559);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97e2);
+	rtl_mdio_write(hw, 0x14, 0x8073);
+	rtl_mdio_write(hw, 0x14, 0x0d21);
+	rtl_mdio_write(hw, 0x14, 0xf637);
+	rtl_mdio_write(hw, 0x14, 0x0d11);
+	rtl_mdio_write(hw, 0x14, 0xf62f);
+	rtl_mdio_write(hw, 0x14, 0x1b21);
+	rtl_mdio_write(hw, 0x14, 0xaa02);
+	rtl_mdio_write(hw, 0x14, 0xae10);
+	rtl_mdio_write(hw, 0x14, 0xe280);
+	rtl_mdio_write(hw, 0x14, 0x740d);
+	rtl_mdio_write(hw, 0x14, 0x21f6);
+	rtl_mdio_write(hw, 0x14, 0x371b);
+	rtl_mdio_write(hw, 0x14, 0x21aa);
+	rtl_mdio_write(hw, 0x14, 0x0313);
+	rtl_mdio_write(hw, 0x14, 0xae02);
+	rtl_mdio_write(hw, 0x14, 0x2b02);
+	rtl_mdio_write(hw, 0x14, 0x020e);
+	rtl_mdio_write(hw, 0x14, 0x5102);
+	rtl_mdio_write(hw, 0x14, 0x0e66);
+	rtl_mdio_write(hw, 0x14, 0x020f);
+	rtl_mdio_write(hw, 0x14, 0xa3ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfdfc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xf9fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe080);
+	rtl_mdio_write(hw, 0x14, 0x12ad);
+	rtl_mdio_write(hw, 0x14, 0x2733);
+	rtl_mdio_write(hw, 0x14, 0xbf43);
+	rtl_mdio_write(hw, 0x14, 0xbe02);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0xac28);
+	rtl_mdio_write(hw, 0x14, 0x09bf);
+	rtl_mdio_write(hw, 0x14, 0x43c1);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97ad);
+	rtl_mdio_write(hw, 0x14, 0x2821);
+	rtl_mdio_write(hw, 0x14, 0xbf45);
+	rtl_mdio_write(hw, 0x14, 0x5902);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0xe387);
+	rtl_mdio_write(hw, 0x14, 0xffd2);
+	rtl_mdio_write(hw, 0x14, 0x001b);
+	rtl_mdio_write(hw, 0x14, 0x45ac);
+	rtl_mdio_write(hw, 0x14, 0x2711);
+	rtl_mdio_write(hw, 0x14, 0xe187);
+	rtl_mdio_write(hw, 0x14, 0xfebf);
+	rtl_mdio_write(hw, 0x14, 0x87e4);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x590d);
+	rtl_mdio_write(hw, 0x14, 0x11bf);
+	rtl_mdio_write(hw, 0x14, 0x87e7);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfdfc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69d1);
+	rtl_mdio_write(hw, 0x14, 0x00bf);
+	rtl_mdio_write(hw, 0x14, 0x87e4);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59bf);
+	rtl_mdio_write(hw, 0x14, 0x87e7);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xff46);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xfe01);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69e0);
+	rtl_mdio_write(hw, 0x14, 0x8241);
+	rtl_mdio_write(hw, 0x14, 0xa000);
+	rtl_mdio_write(hw, 0x14, 0x0502);
+	rtl_mdio_write(hw, 0x14, 0x85eb);
+	rtl_mdio_write(hw, 0x14, 0xae0e);
+	rtl_mdio_write(hw, 0x14, 0xa001);
+	rtl_mdio_write(hw, 0x14, 0x0502);
+	rtl_mdio_write(hw, 0x14, 0x1a5a);
+	rtl_mdio_write(hw, 0x14, 0xae06);
+	rtl_mdio_write(hw, 0x14, 0xa002);
+	rtl_mdio_write(hw, 0x14, 0x0302);
+	rtl_mdio_write(hw, 0x14, 0x1ae6);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xf9fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x29f6);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8229);
+	rtl_mdio_write(hw, 0x14, 0xe080);
+	rtl_mdio_write(hw, 0x14, 0x10ac);
+	rtl_mdio_write(hw, 0x14, 0x2202);
+	rtl_mdio_write(hw, 0x14, 0xae76);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x27f7);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8227);
+	rtl_mdio_write(hw, 0x14, 0xbf43);
+	rtl_mdio_write(hw, 0x14, 0x1302);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0xef21);
+	rtl_mdio_write(hw, 0x14, 0xbf43);
+	rtl_mdio_write(hw, 0x14, 0x1602);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0x0c11);
+	rtl_mdio_write(hw, 0x14, 0x1e21);
+	rtl_mdio_write(hw, 0x14, 0xbf43);
+	rtl_mdio_write(hw, 0x14, 0x1902);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0x0c12);
+	rtl_mdio_write(hw, 0x14, 0x1e21);
+	rtl_mdio_write(hw, 0x14, 0xe682);
+	rtl_mdio_write(hw, 0x14, 0x43a2);
+	rtl_mdio_write(hw, 0x14, 0x000a);
+	rtl_mdio_write(hw, 0x14, 0xe182);
+	rtl_mdio_write(hw, 0x14, 0x27f6);
+	rtl_mdio_write(hw, 0x14, 0x29e5);
+	rtl_mdio_write(hw, 0x14, 0x8227);
+	rtl_mdio_write(hw, 0x14, 0xae42);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44f7);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x0246);
+	rtl_mdio_write(hw, 0x14, 0xaebf);
+	rtl_mdio_write(hw, 0x14, 0x4325);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97ef);
+	rtl_mdio_write(hw, 0x14, 0x21bf);
+	rtl_mdio_write(hw, 0x14, 0x431c);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x970c);
+	rtl_mdio_write(hw, 0x14, 0x121e);
+	rtl_mdio_write(hw, 0x14, 0x21bf);
+	rtl_mdio_write(hw, 0x14, 0x431f);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x970c);
+	rtl_mdio_write(hw, 0x14, 0x131e);
+	rtl_mdio_write(hw, 0x14, 0x21bf);
+	rtl_mdio_write(hw, 0x14, 0x4328);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x970c);
+	rtl_mdio_write(hw, 0x14, 0x141e);
+	rtl_mdio_write(hw, 0x14, 0x21bf);
+	rtl_mdio_write(hw, 0x14, 0x44b1);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x970c);
+	rtl_mdio_write(hw, 0x14, 0x161e);
+	rtl_mdio_write(hw, 0x14, 0x21e6);
+	rtl_mdio_write(hw, 0x14, 0x8242);
+	rtl_mdio_write(hw, 0x14, 0xee82);
+	rtl_mdio_write(hw, 0x14, 0x4101);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x46a0);
+	rtl_mdio_write(hw, 0x14, 0x0005);
+	rtl_mdio_write(hw, 0x14, 0x0286);
+	rtl_mdio_write(hw, 0x14, 0x96ae);
+	rtl_mdio_write(hw, 0x14, 0x06a0);
+	rtl_mdio_write(hw, 0x14, 0x0103);
+	rtl_mdio_write(hw, 0x14, 0x0219);
+	rtl_mdio_write(hw, 0x14, 0x19ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x29f6);
+	rtl_mdio_write(hw, 0x14, 0x20e4);
+	rtl_mdio_write(hw, 0x14, 0x8229);
+	rtl_mdio_write(hw, 0x14, 0xe080);
+	rtl_mdio_write(hw, 0x14, 0x10ac);
+	rtl_mdio_write(hw, 0x14, 0x2102);
+	rtl_mdio_write(hw, 0x14, 0xae54);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x27f7);
+	rtl_mdio_write(hw, 0x14, 0x20e4);
+	rtl_mdio_write(hw, 0x14, 0x8227);
+	rtl_mdio_write(hw, 0x14, 0xbf42);
+	rtl_mdio_write(hw, 0x14, 0xe602);
+	rtl_mdio_write(hw, 0x14, 0x4297);
+	rtl_mdio_write(hw, 0x14, 0xac28);
+	rtl_mdio_write(hw, 0x14, 0x22bf);
+	rtl_mdio_write(hw, 0x14, 0x430d);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97e5);
+	rtl_mdio_write(hw, 0x14, 0x8247);
+	rtl_mdio_write(hw, 0x14, 0xac28);
+	rtl_mdio_write(hw, 0x14, 0x20d1);
+	rtl_mdio_write(hw, 0x14, 0x03bf);
+	rtl_mdio_write(hw, 0x14, 0x4307);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59ee);
+	rtl_mdio_write(hw, 0x14, 0x8246);
+	rtl_mdio_write(hw, 0x14, 0x00e1);
+	rtl_mdio_write(hw, 0x14, 0x8227);
+	rtl_mdio_write(hw, 0x14, 0xf628);
+	rtl_mdio_write(hw, 0x14, 0xe582);
+	rtl_mdio_write(hw, 0x14, 0x27ae);
+	rtl_mdio_write(hw, 0x14, 0x21d1);
+	rtl_mdio_write(hw, 0x14, 0x04bf);
+	rtl_mdio_write(hw, 0x14, 0x4307);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59ae);
+	rtl_mdio_write(hw, 0x14, 0x08d1);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x4307);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59e0);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0xf720);
+	rtl_mdio_write(hw, 0x14, 0xe482);
+	rtl_mdio_write(hw, 0x14, 0x4402);
+	rtl_mdio_write(hw, 0x14, 0x46ae);
+	rtl_mdio_write(hw, 0x14, 0xee82);
+	rtl_mdio_write(hw, 0x14, 0x4601);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69e0);
+	rtl_mdio_write(hw, 0x14, 0x8013);
+	rtl_mdio_write(hw, 0x14, 0xad24);
+	rtl_mdio_write(hw, 0x14, 0x1cbf);
+	rtl_mdio_write(hw, 0x14, 0x87f0);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x97ad);
+	rtl_mdio_write(hw, 0x14, 0x2813);
+	rtl_mdio_write(hw, 0x14, 0xe087);
+	rtl_mdio_write(hw, 0x14, 0xfca0);
+	rtl_mdio_write(hw, 0x14, 0x0005);
+	rtl_mdio_write(hw, 0x14, 0x0287);
+	rtl_mdio_write(hw, 0x14, 0x36ae);
+	rtl_mdio_write(hw, 0x14, 0x10a0);
+	rtl_mdio_write(hw, 0x14, 0x0105);
+	rtl_mdio_write(hw, 0x14, 0x0287);
+	rtl_mdio_write(hw, 0x14, 0x48ae);
+	rtl_mdio_write(hw, 0x14, 0x08e0);
+	rtl_mdio_write(hw, 0x14, 0x8230);
+	rtl_mdio_write(hw, 0x14, 0xf626);
+	rtl_mdio_write(hw, 0x14, 0xe482);
+	rtl_mdio_write(hw, 0x14, 0x30ef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8e0);
+	rtl_mdio_write(hw, 0x14, 0x8245);
+	rtl_mdio_write(hw, 0x14, 0xf722);
+	rtl_mdio_write(hw, 0x14, 0xe482);
+	rtl_mdio_write(hw, 0x14, 0x4502);
+	rtl_mdio_write(hw, 0x14, 0x46ae);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xfc01);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xfb02);
+	rtl_mdio_write(hw, 0x14, 0x46d3);
+	rtl_mdio_write(hw, 0x14, 0xad50);
+	rtl_mdio_write(hw, 0x14, 0x2fbf);
+	rtl_mdio_write(hw, 0x14, 0x87ed);
+	rtl_mdio_write(hw, 0x14, 0xd101);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59bf);
+	rtl_mdio_write(hw, 0x14, 0x87ed);
+	rtl_mdio_write(hw, 0x14, 0xd100);
+	rtl_mdio_write(hw, 0x14, 0x0242);
+	rtl_mdio_write(hw, 0x14, 0x59e0);
+	rtl_mdio_write(hw, 0x14, 0x8245);
+	rtl_mdio_write(hw, 0x14, 0xf622);
+	rtl_mdio_write(hw, 0x14, 0xe482);
+	rtl_mdio_write(hw, 0x14, 0x4502);
+	rtl_mdio_write(hw, 0x14, 0x46ae);
+	rtl_mdio_write(hw, 0x14, 0xd100);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0xf002);
+	rtl_mdio_write(hw, 0x14, 0x4259);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xfc00);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x30f6);
+	rtl_mdio_write(hw, 0x14, 0x26e4);
+	rtl_mdio_write(hw, 0x14, 0x8230);
+	rtl_mdio_write(hw, 0x14, 0xffef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xface);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69fb);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0xb3d7);
+	rtl_mdio_write(hw, 0x14, 0x001c);
+	rtl_mdio_write(hw, 0x14, 0xd819);
+	rtl_mdio_write(hw, 0x14, 0xd919);
+	rtl_mdio_write(hw, 0x14, 0xda19);
+	rtl_mdio_write(hw, 0x14, 0xdb19);
+	rtl_mdio_write(hw, 0x14, 0x07ef);
+	rtl_mdio_write(hw, 0x14, 0x9502);
+	rtl_mdio_write(hw, 0x14, 0x4259);
+	rtl_mdio_write(hw, 0x14, 0x073f);
+	rtl_mdio_write(hw, 0x14, 0x0004);
+	rtl_mdio_write(hw, 0x14, 0x9fec);
+	rtl_mdio_write(hw, 0x14, 0xffef);
+	rtl_mdio_write(hw, 0x14, 0x96fe);
+	rtl_mdio_write(hw, 0x14, 0xc6fe);
+	rtl_mdio_write(hw, 0x14, 0xfdfc);
+	rtl_mdio_write(hw, 0x14, 0x0400);
+	rtl_mdio_write(hw, 0x14, 0x0145);
+	rtl_mdio_write(hw, 0x14, 0x7d00);
+	rtl_mdio_write(hw, 0x14, 0x0345);
+	rtl_mdio_write(hw, 0x14, 0x5c00);
+	rtl_mdio_write(hw, 0x14, 0x0143);
+	rtl_mdio_write(hw, 0x14, 0x4f00);
+	rtl_mdio_write(hw, 0x14, 0x0387);
+	rtl_mdio_write(hw, 0x14, 0xdb00);
+	rtl_mdio_write(hw, 0x14, 0x0987);
+	rtl_mdio_write(hw, 0x14, 0xde00);
+	rtl_mdio_write(hw, 0x14, 0x0987);
+	rtl_mdio_write(hw, 0x14, 0xe100);
+	rtl_mdio_write(hw, 0x14, 0x0087);
+	rtl_mdio_write(hw, 0x14, 0xeaa4);
+	rtl_mdio_write(hw, 0x14, 0x00b8);
+	rtl_mdio_write(hw, 0x14, 0x20c4);
+	rtl_mdio_write(hw, 0x14, 0x1600);
+	rtl_mdio_write(hw, 0x14, 0x000f);
+	rtl_mdio_write(hw, 0x14, 0xf800);
+	rtl_mdio_write(hw, 0x14, 0x7098);
+	rtl_mdio_write(hw, 0x14, 0xa58a);
+	rtl_mdio_write(hw, 0x14, 0xb6a8);
+	rtl_mdio_write(hw, 0x14, 0x3e50);
+	rtl_mdio_write(hw, 0x14, 0xa83e);
+	rtl_mdio_write(hw, 0x14, 0x33bc);
+	rtl_mdio_write(hw, 0x14, 0xc622);
+	rtl_mdio_write(hw, 0x14, 0xbcc6);
+	rtl_mdio_write(hw, 0x14, 0xaaa4);
+	rtl_mdio_write(hw, 0x14, 0x42ff);
+	rtl_mdio_write(hw, 0x14, 0xc408);
+	rtl_mdio_write(hw, 0x14, 0x00c4);
+	rtl_mdio_write(hw, 0x14, 0x16a8);
+	rtl_mdio_write(hw, 0x14, 0xbcc0);
+	rtl_mdio_write(hw, 0x13, 0xb818);
+	rtl_mdio_write(hw, 0x14, 0x02f3);
+	rtl_mdio_write(hw, 0x13, 0xb81a);
+	rtl_mdio_write(hw, 0x14, 0x17d1);
+	rtl_mdio_write(hw, 0x13, 0xb81c);
+	rtl_mdio_write(hw, 0x14, 0x185a);
+	rtl_mdio_write(hw, 0x13, 0xb81e);
+	rtl_mdio_write(hw, 0x14, 0x3c66);
+	rtl_mdio_write(hw, 0x13, 0xb820);
+	rtl_mdio_write(hw, 0x14, 0x021f);
+	rtl_mdio_write(hw, 0x13, 0xc416);
+	rtl_mdio_write(hw, 0x14, 0x0500);
+	rtl_mdio_write(hw, 0x13, 0xb82e);
+	rtl_mdio_write(hw, 0x14, 0xfffc);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x10);
+	gphy_val &= ~BIT_9;
+	rtl_mdio_write(hw, 0x10, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+/* ------------------------------------PHY 8168GU2------------------------------------- */
+
+static void
+rtl8168_set_phy_mcu_8168gu_2(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x0300);
+	rtl_mdio_write(hw, 0x13, 0xB82E);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0xb820);
+	rtl_mdio_write(hw, 0x14, 0x0290);
+	rtl_mdio_write(hw, 0x13, 0xa012);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xa014);
+	rtl_mdio_write(hw, 0x14, 0x2c04);
+	rtl_mdio_write(hw, 0x14, 0x2c07);
+	rtl_mdio_write(hw, 0x14, 0x2c07);
+	rtl_mdio_write(hw, 0x14, 0x2c07);
+	rtl_mdio_write(hw, 0x14, 0xa304);
+	rtl_mdio_write(hw, 0x14, 0xa301);
+	rtl_mdio_write(hw, 0x14, 0x207e);
+	rtl_mdio_write(hw, 0x13, 0xa01a);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xa006);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xa004);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xa002);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xa000);
+	rtl_mdio_write(hw, 0x14, 0x107c);
+	rtl_mdio_write(hw, 0x13, 0xb820);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x17);
+	gphy_val &= ~BIT_0;
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8146);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+void
+hw_mac_mcu_config_8168g(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+		rtl8168_set_mac_mcu_8168g_1(hw);
+		break;
+	case CFG_METHOD_24:
+		rtl8168_set_mac_mcu_8168gu_1(hw);
+		break;
+	case CFG_METHOD_25:
+		rtl8168_set_mac_mcu_8168gu_2(hw);
+		break;
+	}
+}
+
+void
+hw_phy_mcu_config_8168g(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+		rtl8168_set_phy_mcu_8168g_1(hw);
+		break;
+	case CFG_METHOD_25:
+		rtl8168_set_phy_mcu_8168gu_2(hw);
+		break;
+	}
+}
diff --git a/drivers/net/r8169/base/rtl8168h.c b/drivers/net/r8169/base/rtl8168h.c
new file mode 100644
index 0000000000..933a15ae39
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168h.c
@@ -0,0 +1,447 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168h.h"
+
+/* For RTL8168H, CFG_METHOD_29,30,35,36 */
+
+void
+hw_init_rxcfg_8168h(struct rtl_hw *hw)
+{
+	RTL_W32(hw, RxConfig, Rx_Single_fetch_V2 |
+		(RX_DMA_BURST_unlimited << RxCfgDMAShift) | RxEarly_off_V2);
+}
+
+void
+hw_ephy_config_8168h(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_37:
+		rtl_clear_pcie_phy_bit(hw, 0x1E, BIT_11);
+
+		rtl_set_pcie_phy_bit(hw, 0x1E, BIT_0);
+		rtl_set_pcie_phy_bit(hw, 0x1D, BIT_11);
+
+		rtl_ephy_write(hw, 0x05, 0x2089);
+		rtl_ephy_write(hw, 0x06, 0x5881);
+
+		rtl_ephy_write(hw, 0x04, 0x854A);
+		rtl_ephy_write(hw, 0x01, 0x068B);
+
+		break;
+	case CFG_METHOD_35:
+		rtl8168_clear_mcu_ocp_bit(hw, 0xD438, BIT_2);
+
+		rtl_clear_pcie_phy_bit(hw, 0x24, BIT_9);
+
+		rtl8168_clear_mcu_ocp_bit(hw, 0xDE28, (BIT_1 | BIT_0));
+
+		rtl8168_set_mcu_ocp_bit(hw, 0xD438, BIT_2);
+
+		break;
+	case CFG_METHOD_36:
+		rtl8168_clear_mcu_ocp_bit(hw, 0xD438, BIT_2);
+
+		rtl8168_clear_mcu_ocp_bit(hw, 0xDE28, (BIT_1 | BIT_0));
+
+		rtl8168_set_mcu_ocp_bit(hw, 0xD438, BIT_2);
+
+		break;
+	default:
+		break;
+	}
+}
+
+static int
+rtl8168h_require_adc_bias_patch_check(struct rtl_hw *hw, u16 *offset)
+{
+	int ret;
+	u16 ioffset_p3, ioffset_p2, ioffset_p1, ioffset_p0;
+	u16 tmp_ushort;
+
+	rtl_mac_ocp_write(hw, 0xDD02, 0x807D);
+	tmp_ushort = rtl_mac_ocp_read(hw, 0xDD02);
+	ioffset_p3 = ((tmp_ushort & BIT_7) >> 7);
+	ioffset_p3 <<= 3;
+	tmp_ushort = rtl_mac_ocp_read(hw, 0xDD00);
+
+	ioffset_p3 |= ((tmp_ushort & (BIT_15 | BIT_14 | BIT_13)) >> 13);
+
+	ioffset_p2 = ((tmp_ushort & (BIT_12 | BIT_11 | BIT_10 | BIT_9)) >> 9);
+	ioffset_p1 = ((tmp_ushort & (BIT_8 | BIT_7 | BIT_6 | BIT_5)) >> 5);
+
+	ioffset_p0 = ((tmp_ushort & BIT_4) >> 4);
+	ioffset_p0 <<= 3;
+	ioffset_p0 |= (tmp_ushort & (BIT_2 | BIT_1 | BIT_0));
+
+	if (ioffset_p3 == 0x0F && ioffset_p2 == 0x0F && ioffset_p1 == 0x0F &&
+	    ioffset_p0 == 0x0F) {
+		ret = FALSE;
+	} else {
+		ret = TRUE;
+		*offset = (ioffset_p3 << 12) | (ioffset_p2 << 8) |
+			   (ioffset_p1 << 4) | ioffset_p0;
+	}
+
+	return ret;
+}
+
+static void
+hw_phy_config_8168h_1(struct rtl_hw *hw)
+{
+	u16 dout_tapbin;
+	u16 gphy_val;
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x809b);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xF800, 0x8000);
+	rtl_mdio_write(hw, 0x13, 0x80A2);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x8000);
+	rtl_mdio_write(hw, 0x13, 0x80A4);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x8500);
+	rtl_mdio_write(hw, 0x13, 0x809C);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0xbd00);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x80AD);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xF800, 0x7000);
+	rtl_mdio_write(hw, 0x13, 0x80B4);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x5000);
+	rtl_mdio_write(hw, 0x13, 0x80AC);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x4000);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x808E);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x1200);
+	rtl_mdio_write(hw, 0x13, 0x8090);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0xE500);
+	rtl_mdio_write(hw, 0x13, 0x8092);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x9F00);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	if (HW_HAS_WRITE_PHY_MCU_RAM_CODE(hw)) {
+		dout_tapbin = 0x0000;
+		rtl_mdio_write(hw, 0x1F, 0x0A46);
+		gphy_val = rtl_mdio_read(hw, 0x13);
+		gphy_val &= (BIT_1 | BIT_0);
+		gphy_val <<= 2;
+		dout_tapbin |= gphy_val;
+
+		gphy_val = rtl_mdio_read(hw, 0x12);
+		gphy_val &= (BIT_15 | BIT_14);
+		gphy_val >>= 14;
+		dout_tapbin |= gphy_val;
+
+		dout_tapbin = ~(dout_tapbin ^ BIT_3);
+		dout_tapbin <<= 12;
+		dout_tapbin &= 0xF000;
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+
+		rtl_mdio_write(hw, 0x13, 0x827A);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 | BIT_12),
+					      dout_tapbin);
+
+		rtl_mdio_write(hw, 0x13, 0x827B);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 | BIT_12),
+					      dout_tapbin);
+
+		rtl_mdio_write(hw, 0x13, 0x827C);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 | BIT_12),
+					      dout_tapbin);
+
+		rtl_mdio_write(hw, 0x13, 0x827D);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 | BIT_12),
+					      dout_tapbin);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8011);
+		rtl_set_eth_phy_bit(hw, 0x14, BIT_11);
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		rtl_set_eth_phy_bit(hw, 0x16, BIT_1);
+	}
+
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_set_eth_phy_bit(hw, 0x11, BIT_11);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCA);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x17, (BIT_13 | BIT_12), BIT_14);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x803F);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x8047);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x804F);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x8057);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x805F);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x8067);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x13, 0x806F);
+	rtl_clear_eth_phy_bit(hw, 0x14, (BIT_13 | BIT_12));
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+static void
+hw_phy_config_8168h_2(struct rtl_hw *hw)
+{
+	u16 gphy_val;
+	u16 offset;
+	u16 rlen;
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x808A);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+				      (BIT_5 | BIT_4 | BIT_3 | BIT_2 | BIT_1 | BIT_0),
+				      0x0A);
+
+	if (HW_HAS_WRITE_PHY_MCU_RAM_CODE(hw)) {
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8011);
+		rtl_set_eth_phy_bit(hw, 0x14, BIT_11);
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		rtl_set_eth_phy_bit(hw, 0x16, BIT_1);
+	}
+
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_set_eth_phy_bit(hw, 0x11, BIT_11);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	if (rtl8168h_require_adc_bias_patch_check(hw, &offset)) {
+		rtl_mdio_write(hw, 0x1F, 0x0BCF);
+		rtl_mdio_write(hw, 0x16, offset);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+	}
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCD);
+	gphy_val = rtl_mdio_read(hw, 0x16);
+	gphy_val &= 0x000F;
+
+	if (gphy_val > 3)
+		rlen = gphy_val - 3;
+	else
+		rlen = 0;
+
+	gphy_val = rlen | (rlen << 4) | (rlen << 8) | (rlen << 12);
+
+	rtl_mdio_write(hw, 0x1F, 0x0BCD);
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	if (HW_HAS_WRITE_PHY_MCU_RAM_CODE(hw)) {
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x85FE);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14, (BIT_15 | BIT_14 |
+					      BIT_13 | BIT_12 | BIT_11 | BIT_10 | BIT_8),
+					      BIT_9);
+		rtl_mdio_write(hw, 0x13, 0x85FF);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 | BIT_12),
+					      (BIT_11 | BIT_10 | BIT_9 | BIT_8));
+		rtl_mdio_write(hw, 0x13, 0x814B);
+		rtl_clear_and_set_eth_phy_bit(hw, 0x14,
+					      (BIT_15 | BIT_14 | BIT_13 |
+					      BIT_11 | BIT_10 | BIT_9 | BIT_8),
+					      BIT_12);
+	}
+
+	rtl_mdio_write(hw, 0x1F, 0x0C41);
+	rtl_clear_eth_phy_bit(hw, 0x15, BIT_1);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_set_eth_phy_bit(hw, 0x10, BIT_0);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+static void
+hw_phy_config_8168h_3(struct rtl_hw *hw)
+{
+	rtl_mdio_write(hw, 0x1F, 0x0A44);
+	rtl_set_eth_phy_bit(hw, 0x11, BIT_11);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A4C);
+	rtl_clear_eth_phy_bit(hw, 0x15, (BIT_14 | BIT_13));
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x81B9);
+	rtl_mdio_write(hw, 0x14, 0x2000);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x81D4);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x6600);
+	rtl_mdio_write(hw, 0x13, 0x81CB);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x3500);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A80);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x16, 0x000F, 0x0005);
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8016);
+	rtl_set_eth_phy_bit(hw, 0x14, BIT_13);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x811E);
+	rtl_mdio_write(hw, 0x14, 0xDECA);
+
+	rtl_mdio_write(hw, 0x13, 0x811C);
+	rtl_mdio_write(hw, 0x14, 0x8008);
+	rtl_mdio_write(hw, 0x13, 0x8118);
+	rtl_mdio_write(hw, 0x14, 0xF8B4);
+	rtl_mdio_write(hw, 0x13, 0x811A);
+	rtl_mdio_write(hw, 0x14, 0x1A04);
+
+	rtl_mdio_write(hw, 0x13, 0x8134);
+	rtl_mdio_write(hw, 0x14, 0xDECA);
+	rtl_mdio_write(hw, 0x13, 0x8132);
+	rtl_mdio_write(hw, 0x14, 0xA008);
+	rtl_mdio_write(hw, 0x13, 0x812E);
+	rtl_mdio_write(hw, 0x14, 0x00B5);
+	rtl_mdio_write(hw, 0x13, 0x8130);
+	rtl_mdio_write(hw, 0x14, 0x1A04);
+
+	rtl_mdio_write(hw, 0x13, 0x8112);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x7300);
+	rtl_mdio_write(hw, 0x13, 0x8106);
+	rtl_mdio_write(hw, 0x14, 0xA209);
+	rtl_mdio_write(hw, 0x13, 0x8108);
+	rtl_mdio_write(hw, 0x14, 0x13B0);
+	rtl_mdio_write(hw, 0x13, 0x8103);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xF800, 0xB800);
+	rtl_mdio_write(hw, 0x13, 0x8105);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x0A00);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x87EB);
+	rtl_mdio_write(hw, 0x14, 0x0018);
+	rtl_mdio_write(hw, 0x13, 0x87EB);
+	rtl_mdio_write(hw, 0x14, 0x0018);
+	rtl_mdio_write(hw, 0x13, 0x87ED);
+	rtl_mdio_write(hw, 0x14, 0x0733);
+	rtl_mdio_write(hw, 0x13, 0x87EF);
+	rtl_mdio_write(hw, 0x14, 0x08DC);
+	rtl_mdio_write(hw, 0x13, 0x87F1);
+	rtl_mdio_write(hw, 0x14, 0x08DF);
+	rtl_mdio_write(hw, 0x13, 0x87F3);
+	rtl_mdio_write(hw, 0x14, 0x0C79);
+	rtl_mdio_write(hw, 0x13, 0x87F5);
+	rtl_mdio_write(hw, 0x14, 0x0D93);
+	rtl_mdio_write(hw, 0x13, 0x87F9);
+	rtl_mdio_write(hw, 0x14, 0x0010);
+	rtl_mdio_write(hw, 0x13, 0x87FB);
+	rtl_mdio_write(hw, 0x14, 0x0800);
+	rtl_mdio_write(hw, 0x13, 0x8015);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0x7000, 0x7000);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8111);
+	rtl_clear_and_set_eth_phy_bit(hw, 0x14, 0xFF00, 0x7C00);
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+}
+
+void
+hw_phy_config_8168h(struct rtl_hw *hw)
+{
+	if (hw->mcfg == CFG_METHOD_29)
+		hw_phy_config_8168h_1(hw);
+	else if (hw->mcfg == CFG_METHOD_30 || hw->mcfg == CFG_METHOD_37)
+		hw_phy_config_8168h_2(hw);
+	else if (hw->mcfg == CFG_METHOD_35)
+		hw_phy_config_8168h_3(hw);
+
+	/* Enable EthPhyPPSW */
+	if (hw->mcfg != CFG_METHOD_37) {
+		rtl_mdio_write(hw, 0x1F, 0x0A44);
+		rtl_clear_eth_phy_bit(hw, 0x11, BIT_7);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+	}
+}
+
+void
+hw_config_8168h(struct rtl_hw *hw)
+{
+	u32 csi_tmp;
+	u16 mac_ocp_data;
+
+	/* Share fifo rx params */
+	rtl_eri_write(hw, 0xC8, 4, 0x00080002, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xCC, 1, 0x38, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xD0, 1, 0x48, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xE8, 4, 0x00100006, ERIAR_ExGMAC);
+
+	/* Adjust the trx fifo*/
+	rtl_eri_write(hw, 0xCA, 2, 0x0370, ERIAR_ExGMAC);
+	rtl_eri_write(hw, 0xEA, 1, 0x10, ERIAR_ExGMAC);
+
+	/* Disable share fifo */
+	RTL_W32(hw, TxConfig, RTL_R32(hw, TxConfig) & ~BIT_7);
+
+	if (hw->mcfg == CFG_METHOD_35 || hw->mcfg == CFG_METHOD_36)
+		rtl8168_set_mcu_ocp_bit(hw, 0xD438, (BIT_1 | BIT_0));
+
+	/* EPHY err mask */
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE0D6);
+	mac_ocp_data &= ~(BIT_8 | BIT_7 | BIT_6 | BIT_5 | BIT_4 | BIT_3 |
+			  BIT_2 | BIT_1 | BIT_0);
+	mac_ocp_data |= 0x17F;
+	rtl_mac_ocp_write(hw, 0xE0D6, mac_ocp_data);
+
+	RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~Beacon_en);
+
+	/* EEE led enable */
+	RTL_W8(hw, 0x1B, RTL_R8(hw, 0x1B) & ~0x07);
+
+	RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~PMSTS_En);
+
+	csi_tmp = rtl_eri_read(hw, 0xDC, 4, ERIAR_ExGMAC);
+	csi_tmp |= (BIT_2 | BIT_3 | BIT_4);
+	rtl_eri_write(hw, 0xDC, 4, csi_tmp, ERIAR_ExGMAC);
+
+	/* CRC wake disable */
+	rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
+	rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
+
+	csi_tmp = rtl_eri_read(hw, 0x1B0, 4, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_12;
+	rtl_eri_write(hw, 0x1B0, 4, csi_tmp, ERIAR_ExGMAC);
+
+	csi_tmp = rtl_eri_read(hw, 0x2FC, 1, ERIAR_ExGMAC);
+	csi_tmp &= ~BIT_2;
+	rtl_eri_write(hw, 0x2FC, 1, csi_tmp, ERIAR_ExGMAC);
+
+	if (hw->mcfg != CFG_METHOD_37) {
+		csi_tmp = rtl_eri_read(hw, 0x1D0, 1, ERIAR_ExGMAC);
+		csi_tmp |= BIT_1;
+		rtl_eri_write(hw, 0x1D0, 1, csi_tmp, ERIAR_ExGMAC);
+	}
+}
+
+const struct rtl_hw_ops rtl8168h_ops = {
+	.hw_config         = hw_config_8168h,
+	.hw_init_rxcfg     = hw_init_rxcfg_8168h,
+	.hw_ephy_config    = hw_ephy_config_8168h,
+	.hw_phy_config     = hw_phy_config_8168h,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168h,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168h,
+};
diff --git a/drivers/net/r8169/base/rtl8168h.h b/drivers/net/r8169/base/rtl8168h.h
new file mode 100644
index 0000000000..51612d5fc3
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168h.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#ifndef _RTL8168H_H_
+#define _RTL8168H_H_
+
+#include "../r8169_compat.h"
+
+extern const struct rtl_hw_ops rtl8168h_ops;
+extern const struct rtl_hw_ops rtl8168m_ops;
+
+void hw_mac_mcu_config_8168h(struct rtl_hw *hw);
+void hw_phy_mcu_config_8168h(struct rtl_hw *hw);
+
+void hw_init_rxcfg_8168h(struct rtl_hw *hw);
+void hw_ephy_config_8168h(struct rtl_hw *hw);
+void hw_phy_config_8168h(struct rtl_hw *hw);
+void hw_config_8168h(struct rtl_hw *hw);
+
+#endif
diff --git a/drivers/net/r8169/base/rtl8168h_mcu.c b/drivers/net/r8169/base/rtl8168h_mcu.c
new file mode 100644
index 0000000000..445e6ab22e
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168h_mcu.c
@@ -0,0 +1,1186 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168h.h"
+
+/* For RTL8168H, CFG_METHOD_29,30,35,36 */
+
+/* ------------------------------------MAC 8168H------------------------------------- */
+
+static void
+rtl8168_set_mac_mcu_8168h_1(struct rtl_hw *hw)
+{
+	rtl_hw_disable_mac_mcu_bps(hw);
+}
+
+static void
+rtl8168_set_mac_mcu_8168h_2(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168h_1[] = {
+		0xE008, 0xE00F, 0xE011, 0xE047, 0xE049, 0xE073, 0xE075, 0xE07A, 0xC707,
+		0x1D00, 0x8DE2, 0x48C1, 0xC502, 0xBD00, 0x00E4, 0xE0C0, 0xC502, 0xBD00,
+		0x0216, 0xC634, 0x75C0, 0x49D3, 0xF027, 0xC631, 0x75C0, 0x49D3, 0xF123,
+		0xC627, 0x75C0, 0xB405, 0xC525, 0x9DC0, 0xC621, 0x75C8, 0x49D5, 0xF00A,
+		0x49D6, 0xF008, 0x49D7, 0xF006, 0x49D8, 0xF004, 0x75D2, 0x49D9, 0xF111,
+		0xC517, 0x9DC8, 0xC516, 0x9DD2, 0xC618, 0x75C0, 0x49D4, 0xF003, 0x49D0,
+		0xF104, 0xC60A, 0xC50E, 0x9DC0, 0xB005, 0xC607, 0x9DC0, 0xB007, 0xC602,
+		0xBE00, 0x1A06, 0xB400, 0xE86C, 0xA000, 0x01E1, 0x0200, 0x9200, 0xE84C,
+		0xE004, 0xE908, 0xC502, 0xBD00, 0x0B58, 0xB407, 0xB404, 0x2195, 0x25BD,
+		0x9BE0, 0x1C1C, 0x484F, 0x9CE2, 0x72E2, 0x49AE, 0xF1FE, 0x0B00, 0xF116,
+		0xC71C, 0xC419, 0x9CE0, 0x1C13, 0x484F, 0x9CE2, 0x74E2, 0x49CE, 0xF1FE,
+		0xC412, 0x9CE0, 0x1C13, 0x484F, 0x9CE2, 0x74E2, 0x49CE, 0xF1FE, 0xC70C,
+		0x74F8, 0x48C3, 0x8CF8, 0xB004, 0xB007, 0xC502, 0xBD00, 0x0F24, 0x0481,
+		0x0C81, 0xDE24, 0xE000, 0xC602, 0xBE00, 0x0CA4, 0x48C1, 0x48C2, 0x9C46,
+		0xC402, 0xBC00, 0x0578, 0xC602, 0xBE00, 0x0000
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168h_1); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168h_1[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC28, 0x00E2);
+	rtl_mac_ocp_write(hw, 0xFC2A, 0x0210);
+	rtl_mac_ocp_write(hw, 0xFC2C, 0x1A04);
+	rtl_mac_ocp_write(hw, 0xFC2E, 0x0B26);
+	rtl_mac_ocp_write(hw, 0xFC30, 0x0F02);
+	rtl_mac_ocp_write(hw, 0xFC32, 0x0CA0);
+
+	rtl_mac_ocp_write(hw, 0xFC38, 0x003F);
+}
+
+static void
+rtl8168_set_mac_mcu_8168h_3(struct rtl_hw *hw)
+{
+	u16 i;
+	static const u16 mcu_patch_code_8168h_3[] = {
+		0xE008, 0xE00A, 0xE00C, 0xE00E, 0xE010, 0xE03E, 0xE040, 0xE069, 0xC602,
+		0xBE00, 0x0000, 0xC602, 0xBE00, 0x0000, 0xC002, 0xB800, 0x0000, 0xC602,
+		0xBE00, 0x0000, 0xC72B, 0x76E2, 0x49EE, 0xF1FD, 0x1E00, 0x9EE0, 0x1E1C,
+		0x9EE2, 0x76E2, 0x49EE, 0xF1FE, 0xC621, 0x9EE0, 0x1E1D, 0x486F, 0x9EE2,
+		0x76E2, 0x49EE, 0xF1FE, 0xC71A, 0x76E0, 0x48E8, 0x48E9, 0x48EA, 0x48EB,
+		0x48EC, 0x9EE0, 0xC70D, 0xC60D, 0x9EF4, 0xC60C, 0x9EF6, 0xC70E, 0x76E0,
+		0x4863, 0x9EE0, 0xB007, 0xC602, 0xBE00, 0x0ACC, 0xE000, 0x03BF, 0x07FF,
+		0xDE24, 0x3200, 0xE096, 0xD438, 0xC602, 0xBE00, 0x0000, 0x8EE6, 0xC726,
+		0x76E2, 0x49EE, 0xF1FD, 0x1E00, 0x8EE0, 0x1E1C, 0x8EE2, 0x76E2, 0x49EE,
+		0xF1FE, 0xC61C, 0x8EE0, 0x1E1D, 0x486F, 0x8EE2, 0x76E2, 0x49EE, 0xF1FE,
+		0xC715, 0x76E0, 0x48E8, 0x48E9, 0x48EA, 0x48EB, 0x48EC, 0x9EE0, 0xC708,
+		0xC608, 0x9EF4, 0xC607, 0x9EF6, 0xC602, 0xBE00, 0x0ABE, 0xE000, 0x03BF,
+		0x07FF, 0xDE24, 0x3200, 0xE096, 0xC602, 0xBE00, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x6838, 0x0A17, 0x0613, 0x0D26
+	};
+
+	rtl_hw_disable_mac_mcu_bps(hw);
+
+	for (i = 0; i < ARRAY_SIZE(mcu_patch_code_8168h_3); i++)
+		rtl_mac_ocp_write(hw, 0xF800 + i * 2, mcu_patch_code_8168h_3[i]);
+
+	rtl_mac_ocp_write(hw, 0xFC26, 0x8000);
+
+	rtl_mac_ocp_write(hw, 0xFC30, 0x0ACA);
+
+	rtl8168_clear_mcu_ocp_bit(hw, 0xD438, BIT_3);
+
+	rtl_mac_ocp_write(hw, 0xFC38, 0x0010);
+}
+
+static void
+rtl8168_set_mac_mcu_8168h_4(struct rtl_hw *hw)
+{
+	rtl_hw_disable_mac_mcu_bps(hw);
+}
+
+/* ------------------------------------PHY 8168H------------------------------------- */
+
+static void
+rtl8168_set_phy_mcu_8168h_1(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8028);
+	rtl_mdio_write(hw, 0x14, 0x6200);
+	rtl_mdio_write(hw, 0x13, 0xB82E);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0290);
+	rtl_mdio_write(hw, 0x13, 0xA012);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA014);
+	rtl_mdio_write(hw, 0x14, 0x2c04);
+	rtl_mdio_write(hw, 0x14, 0x2c10);
+	rtl_mdio_write(hw, 0x14, 0x2c10);
+	rtl_mdio_write(hw, 0x14, 0x2c10);
+	rtl_mdio_write(hw, 0x14, 0xa210);
+	rtl_mdio_write(hw, 0x14, 0xa101);
+	rtl_mdio_write(hw, 0x14, 0xce10);
+	rtl_mdio_write(hw, 0x14, 0xe070);
+	rtl_mdio_write(hw, 0x14, 0x0f40);
+	rtl_mdio_write(hw, 0x14, 0xaf01);
+	rtl_mdio_write(hw, 0x14, 0x8f01);
+	rtl_mdio_write(hw, 0x14, 0x183e);
+	rtl_mdio_write(hw, 0x14, 0x8e10);
+	rtl_mdio_write(hw, 0x14, 0x8101);
+	rtl_mdio_write(hw, 0x14, 0x8210);
+	rtl_mdio_write(hw, 0x14, 0x28da);
+	rtl_mdio_write(hw, 0x13, 0xA01A);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA006);
+	rtl_mdio_write(hw, 0x14, 0x0017);
+	rtl_mdio_write(hw, 0x13, 0xA004);
+	rtl_mdio_write(hw, 0x14, 0x0015);
+	rtl_mdio_write(hw, 0x13, 0xA002);
+	rtl_mdio_write(hw, 0x14, 0x0013);
+	rtl_mdio_write(hw, 0x13, 0xA000);
+	rtl_mdio_write(hw, 0x14, 0x18d1);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x17);
+	gphy_val &= ~BIT_0;
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8028);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+static void
+rtl8168_set_phy_mcu_8168h_2(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8028);
+	rtl_mdio_write(hw, 0x14, 0x6201);
+	rtl_mdio_write(hw, 0x13, 0xB82E);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0290);
+	rtl_mdio_write(hw, 0x13, 0xA012);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA014);
+	rtl_mdio_write(hw, 0x14, 0x2c04);
+	rtl_mdio_write(hw, 0x14, 0x2c09);
+	rtl_mdio_write(hw, 0x14, 0x2c0d);
+	rtl_mdio_write(hw, 0x14, 0x2c12);
+	rtl_mdio_write(hw, 0x14, 0xad01);
+	rtl_mdio_write(hw, 0x14, 0xad01);
+	rtl_mdio_write(hw, 0x14, 0xad01);
+	rtl_mdio_write(hw, 0x14, 0xad01);
+	rtl_mdio_write(hw, 0x14, 0x236c);
+	rtl_mdio_write(hw, 0x14, 0xd03c);
+	rtl_mdio_write(hw, 0x14, 0xd1aa);
+	rtl_mdio_write(hw, 0x14, 0xc010);
+	rtl_mdio_write(hw, 0x14, 0x2745);
+	rtl_mdio_write(hw, 0x14, 0x33de);
+	rtl_mdio_write(hw, 0x14, 0x16ba);
+	rtl_mdio_write(hw, 0x14, 0x31ee);
+	rtl_mdio_write(hw, 0x14, 0x2712);
+	rtl_mdio_write(hw, 0x14, 0x274e);
+	rtl_mdio_write(hw, 0x14, 0xc2bb);
+	rtl_mdio_write(hw, 0x14, 0xd500);
+	rtl_mdio_write(hw, 0x14, 0xc426);
+	rtl_mdio_write(hw, 0x14, 0xd01d);
+	rtl_mdio_write(hw, 0x14, 0xd1c3);
+	rtl_mdio_write(hw, 0x14, 0x401c);
+	rtl_mdio_write(hw, 0x14, 0xd501);
+	rtl_mdio_write(hw, 0x14, 0xc2b3);
+	rtl_mdio_write(hw, 0x14, 0xd500);
+	rtl_mdio_write(hw, 0x14, 0xd00b);
+	rtl_mdio_write(hw, 0x14, 0xd1c3);
+	rtl_mdio_write(hw, 0x14, 0x401c);
+	rtl_mdio_write(hw, 0x14, 0x241a);
+	rtl_mdio_write(hw, 0x13, 0xA01A);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA006);
+	rtl_mdio_write(hw, 0x14, 0x0414);
+	rtl_mdio_write(hw, 0x13, 0xA004);
+	rtl_mdio_write(hw, 0x14, 0x074c);
+	rtl_mdio_write(hw, 0x13, 0xA002);
+	rtl_mdio_write(hw, 0x14, 0x0744);
+	rtl_mdio_write(hw, 0x13, 0xA000);
+	rtl_mdio_write(hw, 0x14, 0xf36b);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0210);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8323);
+	rtl_mdio_write(hw, 0x14, 0xaf83);
+	rtl_mdio_write(hw, 0x14, 0x2faf);
+	rtl_mdio_write(hw, 0x14, 0x853d);
+	rtl_mdio_write(hw, 0x14, 0xaf85);
+	rtl_mdio_write(hw, 0x14, 0x3daf);
+	rtl_mdio_write(hw, 0x14, 0x853d);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x45ad);
+	rtl_mdio_write(hw, 0x14, 0x2052);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7ae3);
+	rtl_mdio_write(hw, 0x14, 0x85fe);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f6);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7a1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fa);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7be3);
+	rtl_mdio_write(hw, 0x14, 0x85fe);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f7);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7b1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fb);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7ce3);
+	rtl_mdio_write(hw, 0x14, 0x85fe);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f8);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7c1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fc);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7de3);
+	rtl_mdio_write(hw, 0x14, 0x85fe);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f9);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7d1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fd);
+	rtl_mdio_write(hw, 0x14, 0xae50);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7ee3);
+	rtl_mdio_write(hw, 0x14, 0x85ff);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f6);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7e1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fa);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7fe3);
+	rtl_mdio_write(hw, 0x14, 0x85ff);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f7);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x7f1b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fb);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x80e3);
+	rtl_mdio_write(hw, 0x14, 0x85ff);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f8);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x801b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fc);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x81e3);
+	rtl_mdio_write(hw, 0x14, 0x85ff);
+	rtl_mdio_write(hw, 0x14, 0x1a03);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x85f9);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x811b);
+	rtl_mdio_write(hw, 0x14, 0x03e4);
+	rtl_mdio_write(hw, 0x14, 0x85fd);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf6ad);
+	rtl_mdio_write(hw, 0x14, 0x2404);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xf610);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf7ad);
+	rtl_mdio_write(hw, 0x14, 0x2404);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xf710);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf8ad);
+	rtl_mdio_write(hw, 0x14, 0x2404);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xf810);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf9ad);
+	rtl_mdio_write(hw, 0x14, 0x2404);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xf910);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfaad);
+	rtl_mdio_write(hw, 0x14, 0x2704);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xfa00);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfbad);
+	rtl_mdio_write(hw, 0x14, 0x2704);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xfb00);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfcad);
+	rtl_mdio_write(hw, 0x14, 0x2704);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xfc00);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfdad);
+	rtl_mdio_write(hw, 0x14, 0x2704);
+	rtl_mdio_write(hw, 0x14, 0xee85);
+	rtl_mdio_write(hw, 0x14, 0xfd00);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44ad);
+	rtl_mdio_write(hw, 0x14, 0x203f);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf6e4);
+	rtl_mdio_write(hw, 0x14, 0x8288);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfae4);
+	rtl_mdio_write(hw, 0x14, 0x8289);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x440d);
+	rtl_mdio_write(hw, 0x14, 0x0458);
+	rtl_mdio_write(hw, 0x14, 0x01bf);
+	rtl_mdio_write(hw, 0x14, 0x8264);
+	rtl_mdio_write(hw, 0x14, 0x0215);
+	rtl_mdio_write(hw, 0x14, 0x38bf);
+	rtl_mdio_write(hw, 0x14, 0x824e);
+	rtl_mdio_write(hw, 0x14, 0x0213);
+	rtl_mdio_write(hw, 0x14, 0x06a0);
+	rtl_mdio_write(hw, 0x14, 0x010f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44f6);
+	rtl_mdio_write(hw, 0x14, 0x20e4);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x580f);
+	rtl_mdio_write(hw, 0x14, 0xe582);
+	rtl_mdio_write(hw, 0x14, 0x5aae);
+	rtl_mdio_write(hw, 0x14, 0x0ebf);
+	rtl_mdio_write(hw, 0x14, 0x825e);
+	rtl_mdio_write(hw, 0x14, 0xe382);
+	rtl_mdio_write(hw, 0x14, 0x44f7);
+	rtl_mdio_write(hw, 0x14, 0x3ce7);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x0212);
+	rtl_mdio_write(hw, 0x14, 0xf0ad);
+	rtl_mdio_write(hw, 0x14, 0x213f);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf7e4);
+	rtl_mdio_write(hw, 0x14, 0x8288);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfbe4);
+	rtl_mdio_write(hw, 0x14, 0x8289);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x440d);
+	rtl_mdio_write(hw, 0x14, 0x0558);
+	rtl_mdio_write(hw, 0x14, 0x01bf);
+	rtl_mdio_write(hw, 0x14, 0x826b);
+	rtl_mdio_write(hw, 0x14, 0x0215);
+	rtl_mdio_write(hw, 0x14, 0x38bf);
+	rtl_mdio_write(hw, 0x14, 0x824f);
+	rtl_mdio_write(hw, 0x14, 0x0213);
+	rtl_mdio_write(hw, 0x14, 0x06a0);
+	rtl_mdio_write(hw, 0x14, 0x010f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44f6);
+	rtl_mdio_write(hw, 0x14, 0x21e4);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x580f);
+	rtl_mdio_write(hw, 0x14, 0xe582);
+	rtl_mdio_write(hw, 0x14, 0x5bae);
+	rtl_mdio_write(hw, 0x14, 0x0ebf);
+	rtl_mdio_write(hw, 0x14, 0x8265);
+	rtl_mdio_write(hw, 0x14, 0xe382);
+	rtl_mdio_write(hw, 0x14, 0x44f7);
+	rtl_mdio_write(hw, 0x14, 0x3de7);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x0212);
+	rtl_mdio_write(hw, 0x14, 0xf0ad);
+	rtl_mdio_write(hw, 0x14, 0x223f);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf8e4);
+	rtl_mdio_write(hw, 0x14, 0x8288);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfce4);
+	rtl_mdio_write(hw, 0x14, 0x8289);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x440d);
+	rtl_mdio_write(hw, 0x14, 0x0658);
+	rtl_mdio_write(hw, 0x14, 0x01bf);
+	rtl_mdio_write(hw, 0x14, 0x8272);
+	rtl_mdio_write(hw, 0x14, 0x0215);
+	rtl_mdio_write(hw, 0x14, 0x38bf);
+	rtl_mdio_write(hw, 0x14, 0x8250);
+	rtl_mdio_write(hw, 0x14, 0x0213);
+	rtl_mdio_write(hw, 0x14, 0x06a0);
+	rtl_mdio_write(hw, 0x14, 0x010f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44f6);
+	rtl_mdio_write(hw, 0x14, 0x22e4);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x580f);
+	rtl_mdio_write(hw, 0x14, 0xe582);
+	rtl_mdio_write(hw, 0x14, 0x5cae);
+	rtl_mdio_write(hw, 0x14, 0x0ebf);
+	rtl_mdio_write(hw, 0x14, 0x826c);
+	rtl_mdio_write(hw, 0x14, 0xe382);
+	rtl_mdio_write(hw, 0x14, 0x44f7);
+	rtl_mdio_write(hw, 0x14, 0x3ee7);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x0212);
+	rtl_mdio_write(hw, 0x14, 0xf0ad);
+	rtl_mdio_write(hw, 0x14, 0x233f);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xf9e4);
+	rtl_mdio_write(hw, 0x14, 0x8288);
+	rtl_mdio_write(hw, 0x14, 0xe085);
+	rtl_mdio_write(hw, 0x14, 0xfde4);
+	rtl_mdio_write(hw, 0x14, 0x8289);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x440d);
+	rtl_mdio_write(hw, 0x14, 0x0758);
+	rtl_mdio_write(hw, 0x14, 0x01bf);
+	rtl_mdio_write(hw, 0x14, 0x8279);
+	rtl_mdio_write(hw, 0x14, 0x0215);
+	rtl_mdio_write(hw, 0x14, 0x38bf);
+	rtl_mdio_write(hw, 0x14, 0x8251);
+	rtl_mdio_write(hw, 0x14, 0x0213);
+	rtl_mdio_write(hw, 0x14, 0x06a0);
+	rtl_mdio_write(hw, 0x14, 0x010f);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0x44f6);
+	rtl_mdio_write(hw, 0x14, 0x23e4);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x580f);
+	rtl_mdio_write(hw, 0x14, 0xe582);
+	rtl_mdio_write(hw, 0x14, 0x5dae);
+	rtl_mdio_write(hw, 0x14, 0x0ebf);
+	rtl_mdio_write(hw, 0x14, 0x8273);
+	rtl_mdio_write(hw, 0x14, 0xe382);
+	rtl_mdio_write(hw, 0x14, 0x44f7);
+	rtl_mdio_write(hw, 0x14, 0x3fe7);
+	rtl_mdio_write(hw, 0x14, 0x8244);
+	rtl_mdio_write(hw, 0x14, 0x0212);
+	rtl_mdio_write(hw, 0x14, 0xf0ee);
+	rtl_mdio_write(hw, 0x14, 0x8288);
+	rtl_mdio_write(hw, 0x14, 0x10ee);
+	rtl_mdio_write(hw, 0x14, 0x8289);
+	rtl_mdio_write(hw, 0x14, 0x00af);
+	rtl_mdio_write(hw, 0x14, 0x14aa);
+	rtl_mdio_write(hw, 0x13, 0xb818);
+	rtl_mdio_write(hw, 0x14, 0x13cf);
+	rtl_mdio_write(hw, 0x13, 0xb81a);
+	rtl_mdio_write(hw, 0x14, 0xfffd);
+	rtl_mdio_write(hw, 0x13, 0xb81c);
+	rtl_mdio_write(hw, 0x14, 0xfffd);
+	rtl_mdio_write(hw, 0x13, 0xb81e);
+	rtl_mdio_write(hw, 0x14, 0xfffd);
+	rtl_mdio_write(hw, 0x13, 0xb832);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x17);
+	gphy_val &= ~BIT_0;
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8028);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+static void
+rtl8168_set_phy_mcu_8168h_3(struct rtl_hw *hw)
+{
+	unsigned int gphy_val;
+
+	rtl_set_phy_mcu_patch_request(hw);
+
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8042);
+	rtl_mdio_write(hw, 0x14, 0x3800);
+	rtl_mdio_write(hw, 0x13, 0xB82E);
+	rtl_mdio_write(hw, 0x14, 0x0001);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0090);
+	rtl_mdio_write(hw, 0x13, 0xA016);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA012);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x13, 0xA014);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8010);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8014);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x8022);
+	rtl_mdio_write(hw, 0x14, 0x2b5d);
+	rtl_mdio_write(hw, 0x14, 0x0c68);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x0b3c);
+	rtl_mdio_write(hw, 0x14, 0xc2bb);
+	rtl_mdio_write(hw, 0x14, 0xd500);
+	rtl_mdio_write(hw, 0x14, 0xc426);
+	rtl_mdio_write(hw, 0x14, 0xd01d);
+	rtl_mdio_write(hw, 0x14, 0xd1c3);
+	rtl_mdio_write(hw, 0x14, 0x401c);
+	rtl_mdio_write(hw, 0x14, 0xd501);
+	rtl_mdio_write(hw, 0x14, 0xc2b3);
+	rtl_mdio_write(hw, 0x14, 0xd500);
+	rtl_mdio_write(hw, 0x14, 0xd00b);
+	rtl_mdio_write(hw, 0x14, 0xd1c3);
+	rtl_mdio_write(hw, 0x14, 0x401c);
+	rtl_mdio_write(hw, 0x14, 0x1800);
+	rtl_mdio_write(hw, 0x14, 0x0478);
+	rtl_mdio_write(hw, 0x13, 0xA026);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA024);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA022);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA020);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA006);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA004);
+	rtl_mdio_write(hw, 0x14, 0x0fff);
+	rtl_mdio_write(hw, 0x13, 0xA002);
+	rtl_mdio_write(hw, 0x14, 0x0472);
+	rtl_mdio_write(hw, 0x13, 0xA000);
+	rtl_mdio_write(hw, 0x14, 0x0b3a);
+	rtl_mdio_write(hw, 0x13, 0xA008);
+	rtl_mdio_write(hw, 0x14, 0x0300);
+	rtl_mdio_write(hw, 0x13, 0xB820);
+	rtl_mdio_write(hw, 0x14, 0x0010);
+
+	rtl_mdio_write(hw, 0x13, 0x83f3);
+	rtl_mdio_write(hw, 0x14, 0xaf84);
+	rtl_mdio_write(hw, 0x14, 0x0baf);
+	rtl_mdio_write(hw, 0x14, 0x8466);
+	rtl_mdio_write(hw, 0x14, 0xaf84);
+	rtl_mdio_write(hw, 0x14, 0xcdaf);
+	rtl_mdio_write(hw, 0x14, 0x873c);
+	rtl_mdio_write(hw, 0x14, 0xaf87);
+	rtl_mdio_write(hw, 0x14, 0x3faf);
+	rtl_mdio_write(hw, 0x14, 0x8760);
+	rtl_mdio_write(hw, 0x14, 0xaf87);
+	rtl_mdio_write(hw, 0x14, 0x60af);
+	rtl_mdio_write(hw, 0x14, 0x8760);
+	rtl_mdio_write(hw, 0x14, 0xef79);
+	rtl_mdio_write(hw, 0x14, 0xfb89);
+	rtl_mdio_write(hw, 0x14, 0xe987);
+	rtl_mdio_write(hw, 0x14, 0xffd7);
+	rtl_mdio_write(hw, 0x14, 0x0017);
+	rtl_mdio_write(hw, 0x14, 0xd400);
+	rtl_mdio_write(hw, 0x14, 0x051c);
+	rtl_mdio_write(hw, 0x14, 0x421a);
+	rtl_mdio_write(hw, 0x14, 0x741b);
+	rtl_mdio_write(hw, 0x14, 0x97e9);
+	rtl_mdio_write(hw, 0x14, 0x87fe);
+	rtl_mdio_write(hw, 0x14, 0xffef);
+	rtl_mdio_write(hw, 0x14, 0x97e0);
+	rtl_mdio_write(hw, 0x14, 0x82aa);
+	rtl_mdio_write(hw, 0x14, 0xa000);
+	rtl_mdio_write(hw, 0x14, 0x08ef);
+	rtl_mdio_write(hw, 0x14, 0x46dc);
+	rtl_mdio_write(hw, 0x14, 0x19dd);
+	rtl_mdio_write(hw, 0x14, 0xaf1a);
+	rtl_mdio_write(hw, 0x14, 0x37a0);
+	rtl_mdio_write(hw, 0x14, 0x012d);
+	rtl_mdio_write(hw, 0x14, 0xe082);
+	rtl_mdio_write(hw, 0x14, 0xa7ac);
+	rtl_mdio_write(hw, 0x14, 0x2013);
+	rtl_mdio_write(hw, 0x14, 0xe087);
+	rtl_mdio_write(hw, 0x14, 0xffe1);
+	rtl_mdio_write(hw, 0x14, 0x87fe);
+	rtl_mdio_write(hw, 0x14, 0xac27);
+	rtl_mdio_write(hw, 0x14, 0x05a1);
+	rtl_mdio_write(hw, 0x14, 0x0807);
+	rtl_mdio_write(hw, 0x14, 0xae0f);
+	rtl_mdio_write(hw, 0x14, 0xa107);
+	rtl_mdio_write(hw, 0x14, 0x02ae);
+	rtl_mdio_write(hw, 0x14, 0x0aef);
+	rtl_mdio_write(hw, 0x14, 0x4619);
+	rtl_mdio_write(hw, 0x14, 0x19dc);
+	rtl_mdio_write(hw, 0x14, 0x19dd);
+	rtl_mdio_write(hw, 0x14, 0xaf1a);
+	rtl_mdio_write(hw, 0x14, 0x37d8);
+	rtl_mdio_write(hw, 0x14, 0x19d9);
+	rtl_mdio_write(hw, 0x14, 0x19dc);
+	rtl_mdio_write(hw, 0x14, 0x19dd);
+	rtl_mdio_write(hw, 0x14, 0xaf1a);
+	rtl_mdio_write(hw, 0x14, 0x3719);
+	rtl_mdio_write(hw, 0x14, 0x19ae);
+	rtl_mdio_write(hw, 0x14, 0xcfbf);
+	rtl_mdio_write(hw, 0x14, 0x878a);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdc3c);
+	rtl_mdio_write(hw, 0x14, 0x0005);
+	rtl_mdio_write(hw, 0x14, 0xaaf5);
+	rtl_mdio_write(hw, 0x14, 0x0249);
+	rtl_mdio_write(hw, 0x14, 0xcaef);
+	rtl_mdio_write(hw, 0x14, 0x67d7);
+	rtl_mdio_write(hw, 0x14, 0x0014);
+	rtl_mdio_write(hw, 0x14, 0x0249);
+	rtl_mdio_write(hw, 0x14, 0xe5ad);
+	rtl_mdio_write(hw, 0x14, 0x50f7);
+	rtl_mdio_write(hw, 0x14, 0xd400);
+	rtl_mdio_write(hw, 0x14, 0x01bf);
+	rtl_mdio_write(hw, 0x14, 0x46a7);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0x98bf);
+	rtl_mdio_write(hw, 0x14, 0x465c);
+	rtl_mdio_write(hw, 0x14, 0x024a);
+	rtl_mdio_write(hw, 0x14, 0x5fd4);
+	rtl_mdio_write(hw, 0x14, 0x0003);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9c02);
+	rtl_mdio_write(hw, 0x14, 0x4498);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9902);
+	rtl_mdio_write(hw, 0x14, 0x4a5f);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x8d02);
+	rtl_mdio_write(hw, 0x14, 0x4a5f);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9002);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0xad28);
+	rtl_mdio_write(hw, 0x14, 0xf7bf);
+	rtl_mdio_write(hw, 0x14, 0x8796);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcad);
+	rtl_mdio_write(hw, 0x14, 0x28f7);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9302);
+	rtl_mdio_write(hw, 0x14, 0x4a5f);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9302);
+	rtl_mdio_write(hw, 0x14, 0x4a56);
+	rtl_mdio_write(hw, 0x14, 0xbf46);
+	rtl_mdio_write(hw, 0x14, 0x5c02);
+	rtl_mdio_write(hw, 0x14, 0x4a56);
+	rtl_mdio_write(hw, 0x14, 0xbf45);
+	rtl_mdio_write(hw, 0x14, 0x21af);
+	rtl_mdio_write(hw, 0x14, 0x020e);
+	rtl_mdio_write(hw, 0x14, 0xee82);
+	rtl_mdio_write(hw, 0x14, 0x5000);
+	rtl_mdio_write(hw, 0x14, 0x0284);
+	rtl_mdio_write(hw, 0x14, 0xdd02);
+	rtl_mdio_write(hw, 0x14, 0x8521);
+	rtl_mdio_write(hw, 0x14, 0x0285);
+	rtl_mdio_write(hw, 0x14, 0x36af);
+	rtl_mdio_write(hw, 0x14, 0x03d2);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfafb);
+	rtl_mdio_write(hw, 0x14, 0xef59);
+	rtl_mdio_write(hw, 0x14, 0xbf45);
+	rtl_mdio_write(hw, 0x14, 0x3002);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0x3c00);
+	rtl_mdio_write(hw, 0x14, 0x03aa);
+	rtl_mdio_write(hw, 0x14, 0x2cbf);
+	rtl_mdio_write(hw, 0x14, 0x8790);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcad);
+	rtl_mdio_write(hw, 0x14, 0x2823);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x9602);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0xad28);
+	rtl_mdio_write(hw, 0x14, 0x1a02);
+	rtl_mdio_write(hw, 0x14, 0x49ca);
+	rtl_mdio_write(hw, 0x14, 0xef67);
+	rtl_mdio_write(hw, 0x14, 0xd700);
+	rtl_mdio_write(hw, 0x14, 0x0202);
+	rtl_mdio_write(hw, 0x14, 0x49e5);
+	rtl_mdio_write(hw, 0x14, 0xad50);
+	rtl_mdio_write(hw, 0x14, 0xf7bf);
+	rtl_mdio_write(hw, 0x14, 0x8793);
+	rtl_mdio_write(hw, 0x14, 0x024a);
+	rtl_mdio_write(hw, 0x14, 0x5fbf);
+	rtl_mdio_write(hw, 0x14, 0x8793);
+	rtl_mdio_write(hw, 0x14, 0x024a);
+	rtl_mdio_write(hw, 0x14, 0x56ef);
+	rtl_mdio_write(hw, 0x14, 0x95ff);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xe080);
+	rtl_mdio_write(hw, 0x14, 0x15ad);
+	rtl_mdio_write(hw, 0x14, 0x2406);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x8702);
+	rtl_mdio_write(hw, 0x14, 0x4a56);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xe087);
+	rtl_mdio_write(hw, 0x14, 0xf9e1);
+	rtl_mdio_write(hw, 0x14, 0x87fa);
+	rtl_mdio_write(hw, 0x14, 0x1b10);
+	rtl_mdio_write(hw, 0x14, 0x9f1e);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xf900);
+	rtl_mdio_write(hw, 0x14, 0xe080);
+	rtl_mdio_write(hw, 0x14, 0x15ac);
+	rtl_mdio_write(hw, 0x14, 0x2606);
+	rtl_mdio_write(hw, 0x14, 0xee87);
+	rtl_mdio_write(hw, 0x14, 0xf700);
+	rtl_mdio_write(hw, 0x14, 0xae12);
+	rtl_mdio_write(hw, 0x14, 0x0286);
+	rtl_mdio_write(hw, 0x14, 0x9d02);
+	rtl_mdio_write(hw, 0x14, 0x8565);
+	rtl_mdio_write(hw, 0x14, 0x0285);
+	rtl_mdio_write(hw, 0x14, 0x9d02);
+	rtl_mdio_write(hw, 0x14, 0x8660);
+	rtl_mdio_write(hw, 0x14, 0xae04);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x87f9);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69fa);
+	rtl_mdio_write(hw, 0x14, 0xbf45);
+	rtl_mdio_write(hw, 0x14, 0x3002);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0xa103);
+	rtl_mdio_write(hw, 0x14, 0x22e0);
+	rtl_mdio_write(hw, 0x14, 0x87eb);
+	rtl_mdio_write(hw, 0x14, 0xe187);
+	rtl_mdio_write(hw, 0x14, 0xecef);
+	rtl_mdio_write(hw, 0x14, 0x64bf);
+	rtl_mdio_write(hw, 0x14, 0x876f);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdc1b);
+	rtl_mdio_write(hw, 0x14, 0x46aa);
+	rtl_mdio_write(hw, 0x14, 0x0abf);
+	rtl_mdio_write(hw, 0x14, 0x8772);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdc1b);
+	rtl_mdio_write(hw, 0x14, 0x46ab);
+	rtl_mdio_write(hw, 0x14, 0x06bf);
+	rtl_mdio_write(hw, 0x14, 0x876c);
+	rtl_mdio_write(hw, 0x14, 0x024a);
+	rtl_mdio_write(hw, 0x14, 0x5ffe);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xef59);
+	rtl_mdio_write(hw, 0x14, 0xf9bf);
+	rtl_mdio_write(hw, 0x14, 0x4530);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdca1);
+	rtl_mdio_write(hw, 0x14, 0x0310);
+	rtl_mdio_write(hw, 0x14, 0xe087);
+	rtl_mdio_write(hw, 0x14, 0xf7ac);
+	rtl_mdio_write(hw, 0x14, 0x2605);
+	rtl_mdio_write(hw, 0x14, 0x0285);
+	rtl_mdio_write(hw, 0x14, 0xc9ae);
+	rtl_mdio_write(hw, 0x14, 0x0d02);
+	rtl_mdio_write(hw, 0x14, 0x8613);
+	rtl_mdio_write(hw, 0x14, 0xae08);
+	rtl_mdio_write(hw, 0x14, 0xe287);
+	rtl_mdio_write(hw, 0x14, 0xf7f6);
+	rtl_mdio_write(hw, 0x14, 0x36e6);
+	rtl_mdio_write(hw, 0x14, 0x87f7);
+	rtl_mdio_write(hw, 0x14, 0xfdef);
+	rtl_mdio_write(hw, 0x14, 0x95fd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfafb);
+	rtl_mdio_write(hw, 0x14, 0xef79);
+	rtl_mdio_write(hw, 0x14, 0xfbbf);
+	rtl_mdio_write(hw, 0x14, 0x876f);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcef);
+	rtl_mdio_write(hw, 0x14, 0x64e2);
+	rtl_mdio_write(hw, 0x14, 0x87e9);
+	rtl_mdio_write(hw, 0x14, 0xe387);
+	rtl_mdio_write(hw, 0x14, 0xea1b);
+	rtl_mdio_write(hw, 0x14, 0x659e);
+	rtl_mdio_write(hw, 0x14, 0x10e4);
+	rtl_mdio_write(hw, 0x14, 0x87e9);
+	rtl_mdio_write(hw, 0x14, 0xe587);
+	rtl_mdio_write(hw, 0x14, 0xeae2);
+	rtl_mdio_write(hw, 0x14, 0x87f7);
+	rtl_mdio_write(hw, 0x14, 0xf636);
+	rtl_mdio_write(hw, 0x14, 0xe687);
+	rtl_mdio_write(hw, 0x14, 0xf7ae);
+	rtl_mdio_write(hw, 0x14, 0x19e2);
+	rtl_mdio_write(hw, 0x14, 0x87f7);
+	rtl_mdio_write(hw, 0x14, 0xf736);
+	rtl_mdio_write(hw, 0x14, 0xe687);
+	rtl_mdio_write(hw, 0x14, 0xf700);
+	rtl_mdio_write(hw, 0x14, 0x00ae);
+	rtl_mdio_write(hw, 0x14, 0x0200);
+	rtl_mdio_write(hw, 0x14, 0x0002);
+	rtl_mdio_write(hw, 0x14, 0x49ca);
+	rtl_mdio_write(hw, 0x14, 0xef57);
+	rtl_mdio_write(hw, 0x14, 0xe687);
+	rtl_mdio_write(hw, 0x14, 0xe7e7);
+	rtl_mdio_write(hw, 0x14, 0x87e8);
+	rtl_mdio_write(hw, 0x14, 0xffef);
+	rtl_mdio_write(hw, 0x14, 0x97ff);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfafb);
+	rtl_mdio_write(hw, 0x14, 0xef79);
+	rtl_mdio_write(hw, 0x14, 0xfbe2);
+	rtl_mdio_write(hw, 0x14, 0x87e7);
+	rtl_mdio_write(hw, 0x14, 0xe387);
+	rtl_mdio_write(hw, 0x14, 0xe8ef);
+	rtl_mdio_write(hw, 0x14, 0x65e2);
+	rtl_mdio_write(hw, 0x14, 0x87fb);
+	rtl_mdio_write(hw, 0x14, 0xe387);
+	rtl_mdio_write(hw, 0x14, 0xfcef);
+	rtl_mdio_write(hw, 0x14, 0x7502);
+	rtl_mdio_write(hw, 0x14, 0x49e5);
+	rtl_mdio_write(hw, 0x14, 0xac50);
+	rtl_mdio_write(hw, 0x14, 0x1abf);
+	rtl_mdio_write(hw, 0x14, 0x876f);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcef);
+	rtl_mdio_write(hw, 0x14, 0x64e2);
+	rtl_mdio_write(hw, 0x14, 0x87e9);
+	rtl_mdio_write(hw, 0x14, 0xe387);
+	rtl_mdio_write(hw, 0x14, 0xea1b);
+	rtl_mdio_write(hw, 0x14, 0x659e);
+	rtl_mdio_write(hw, 0x14, 0x16e4);
+	rtl_mdio_write(hw, 0x14, 0x87e9);
+	rtl_mdio_write(hw, 0x14, 0xe587);
+	rtl_mdio_write(hw, 0x14, 0xeaae);
+	rtl_mdio_write(hw, 0x14, 0x06bf);
+	rtl_mdio_write(hw, 0x14, 0x876c);
+	rtl_mdio_write(hw, 0x14, 0x024a);
+	rtl_mdio_write(hw, 0x14, 0x5fe2);
+	rtl_mdio_write(hw, 0x14, 0x87f7);
+	rtl_mdio_write(hw, 0x14, 0xf636);
+	rtl_mdio_write(hw, 0x14, 0xe687);
+	rtl_mdio_write(hw, 0x14, 0xf7ff);
+	rtl_mdio_write(hw, 0x14, 0xef97);
+	rtl_mdio_write(hw, 0x14, 0xfffe);
+	rtl_mdio_write(hw, 0x14, 0xfdfc);
+	rtl_mdio_write(hw, 0x14, 0x04f8);
+	rtl_mdio_write(hw, 0x14, 0xf9fa);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x6602);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0xad28);
+	rtl_mdio_write(hw, 0x14, 0x29bf);
+	rtl_mdio_write(hw, 0x14, 0x8763);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcef);
+	rtl_mdio_write(hw, 0x14, 0x54bf);
+	rtl_mdio_write(hw, 0x14, 0x8760);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdcac);
+	rtl_mdio_write(hw, 0x14, 0x290d);
+	rtl_mdio_write(hw, 0x14, 0xac28);
+	rtl_mdio_write(hw, 0x14, 0x05a3);
+	rtl_mdio_write(hw, 0x14, 0x020c);
+	rtl_mdio_write(hw, 0x14, 0xae10);
+	rtl_mdio_write(hw, 0x14, 0xa303);
+	rtl_mdio_write(hw, 0x14, 0x07ae);
+	rtl_mdio_write(hw, 0x14, 0x0ba3);
+	rtl_mdio_write(hw, 0x14, 0x0402);
+	rtl_mdio_write(hw, 0x14, 0xae06);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x6c02);
+	rtl_mdio_write(hw, 0x14, 0x4a5f);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8f9);
+	rtl_mdio_write(hw, 0x14, 0xfafb);
+	rtl_mdio_write(hw, 0x14, 0xef69);
+	rtl_mdio_write(hw, 0x14, 0xfae0);
+	rtl_mdio_write(hw, 0x14, 0x8015);
+	rtl_mdio_write(hw, 0x14, 0xad25);
+	rtl_mdio_write(hw, 0x14, 0x41d2);
+	rtl_mdio_write(hw, 0x14, 0x0002);
+	rtl_mdio_write(hw, 0x14, 0x86f3);
+	rtl_mdio_write(hw, 0x14, 0xe087);
+	rtl_mdio_write(hw, 0x14, 0xebe1);
+	rtl_mdio_write(hw, 0x14, 0x87ec);
+	rtl_mdio_write(hw, 0x14, 0x1b46);
+	rtl_mdio_write(hw, 0x14, 0xab26);
+	rtl_mdio_write(hw, 0x14, 0xd40b);
+	rtl_mdio_write(hw, 0x14, 0xff1b);
+	rtl_mdio_write(hw, 0x14, 0x46aa);
+	rtl_mdio_write(hw, 0x14, 0x1fac);
+	rtl_mdio_write(hw, 0x14, 0x3204);
+	rtl_mdio_write(hw, 0x14, 0xef32);
+	rtl_mdio_write(hw, 0x14, 0xae02);
+	rtl_mdio_write(hw, 0x14, 0xd304);
+	rtl_mdio_write(hw, 0x14, 0x0c31);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0xeb1a);
+	rtl_mdio_write(hw, 0x14, 0x93d8);
+	rtl_mdio_write(hw, 0x14, 0x19d9);
+	rtl_mdio_write(hw, 0x14, 0x1b46);
+	rtl_mdio_write(hw, 0x14, 0xab0e);
+	rtl_mdio_write(hw, 0x14, 0x19d8);
+	rtl_mdio_write(hw, 0x14, 0x19d9);
+	rtl_mdio_write(hw, 0x14, 0x1b46);
+	rtl_mdio_write(hw, 0x14, 0xaa06);
+	rtl_mdio_write(hw, 0x14, 0x12a2);
+	rtl_mdio_write(hw, 0x14, 0x08c9);
+	rtl_mdio_write(hw, 0x14, 0xae06);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x6902);
+	rtl_mdio_write(hw, 0x14, 0x4a5f);
+	rtl_mdio_write(hw, 0x14, 0xfeef);
+	rtl_mdio_write(hw, 0x14, 0x96ff);
+	rtl_mdio_write(hw, 0x14, 0xfefd);
+	rtl_mdio_write(hw, 0x14, 0xfc04);
+	rtl_mdio_write(hw, 0x14, 0xf8fb);
+	rtl_mdio_write(hw, 0x14, 0xef79);
+	rtl_mdio_write(hw, 0x14, 0xa200);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x876f);
+	rtl_mdio_write(hw, 0x14, 0xae33);
+	rtl_mdio_write(hw, 0x14, 0xa201);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x8772);
+	rtl_mdio_write(hw, 0x14, 0xae2b);
+	rtl_mdio_write(hw, 0x14, 0xa202);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x8775);
+	rtl_mdio_write(hw, 0x14, 0xae23);
+	rtl_mdio_write(hw, 0x14, 0xa203);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x8778);
+	rtl_mdio_write(hw, 0x14, 0xae1b);
+	rtl_mdio_write(hw, 0x14, 0xa204);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x877b);
+	rtl_mdio_write(hw, 0x14, 0xae13);
+	rtl_mdio_write(hw, 0x14, 0xa205);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x877e);
+	rtl_mdio_write(hw, 0x14, 0xae0b);
+	rtl_mdio_write(hw, 0x14, 0xa206);
+	rtl_mdio_write(hw, 0x14, 0x05bf);
+	rtl_mdio_write(hw, 0x14, 0x8781);
+	rtl_mdio_write(hw, 0x14, 0xae03);
+	rtl_mdio_write(hw, 0x14, 0xbf87);
+	rtl_mdio_write(hw, 0x14, 0x8402);
+	rtl_mdio_write(hw, 0x14, 0x44dc);
+	rtl_mdio_write(hw, 0x14, 0xef64);
+	rtl_mdio_write(hw, 0x14, 0xef97);
+	rtl_mdio_write(hw, 0x14, 0xfffc);
+	rtl_mdio_write(hw, 0x14, 0x04af);
+	rtl_mdio_write(hw, 0x14, 0x00ed);
+	rtl_mdio_write(hw, 0x14, 0x0220);
+	rtl_mdio_write(hw, 0x14, 0xa5f8);
+	rtl_mdio_write(hw, 0x14, 0xfaef);
+	rtl_mdio_write(hw, 0x14, 0x69bf);
+	rtl_mdio_write(hw, 0x14, 0x4554);
+	rtl_mdio_write(hw, 0x14, 0x0244);
+	rtl_mdio_write(hw, 0x14, 0xdce0);
+	rtl_mdio_write(hw, 0x14, 0x87ff);
+	rtl_mdio_write(hw, 0x14, 0x1f01);
+	rtl_mdio_write(hw, 0x14, 0x9e06);
+	rtl_mdio_write(hw, 0x14, 0xe587);
+	rtl_mdio_write(hw, 0x14, 0xff02);
+	rtl_mdio_write(hw, 0x14, 0x4b05);
+	rtl_mdio_write(hw, 0x14, 0xef96);
+	rtl_mdio_write(hw, 0x14, 0xfefc);
+	rtl_mdio_write(hw, 0x14, 0xaf03);
+	rtl_mdio_write(hw, 0x14, 0x8c54);
+	rtl_mdio_write(hw, 0x14, 0xa434);
+	rtl_mdio_write(hw, 0x14, 0x74a6);
+	rtl_mdio_write(hw, 0x14, 0x0022);
+	rtl_mdio_write(hw, 0x14, 0xa434);
+	rtl_mdio_write(hw, 0x14, 0x11b8);
+	rtl_mdio_write(hw, 0x14, 0x4222);
+	rtl_mdio_write(hw, 0x14, 0xb842);
+	rtl_mdio_write(hw, 0x14, 0xf0a2);
+	rtl_mdio_write(hw, 0x14, 0x00f0);
+	rtl_mdio_write(hw, 0x14, 0xa202);
+	rtl_mdio_write(hw, 0x14, 0xf0a2);
+	rtl_mdio_write(hw, 0x14, 0x04f0);
+	rtl_mdio_write(hw, 0x14, 0xa206);
+	rtl_mdio_write(hw, 0x14, 0xf0a2);
+	rtl_mdio_write(hw, 0x14, 0x08f0);
+	rtl_mdio_write(hw, 0x14, 0xa20a);
+	rtl_mdio_write(hw, 0x14, 0xf0a2);
+	rtl_mdio_write(hw, 0x14, 0x0cf0);
+	rtl_mdio_write(hw, 0x14, 0xa20e);
+	rtl_mdio_write(hw, 0x14, 0x55b8);
+	rtl_mdio_write(hw, 0x14, 0x20d9);
+	rtl_mdio_write(hw, 0x14, 0xc608);
+	rtl_mdio_write(hw, 0x14, 0xaac4);
+	rtl_mdio_write(hw, 0x14, 0x3000);
+	rtl_mdio_write(hw, 0x14, 0xc614);
+	rtl_mdio_write(hw, 0x14, 0x33c4);
+	rtl_mdio_write(hw, 0x14, 0x1a88);
+	rtl_mdio_write(hw, 0x14, 0xc42e);
+	rtl_mdio_write(hw, 0x14, 0x22c4);
+	rtl_mdio_write(hw, 0x14, 0x2e54);
+	rtl_mdio_write(hw, 0x14, 0xc41a);
+	rtl_mdio_write(hw, 0x13, 0xb818);
+	rtl_mdio_write(hw, 0x14, 0x1a01);
+	rtl_mdio_write(hw, 0x13, 0xb81a);
+	rtl_mdio_write(hw, 0x14, 0x020b);
+	rtl_mdio_write(hw, 0x13, 0xb81c);
+	rtl_mdio_write(hw, 0x14, 0x03ce);
+	rtl_mdio_write(hw, 0x13, 0xb81e);
+	rtl_mdio_write(hw, 0x14, 0x00e7);
+	rtl_mdio_write(hw, 0x13, 0xb846);
+	rtl_mdio_write(hw, 0x14, 0x0389);
+	rtl_mdio_write(hw, 0x13, 0xb848);
+	rtl_mdio_write(hw, 0x14, 0xffff);
+	rtl_mdio_write(hw, 0x13, 0xb84a);
+	rtl_mdio_write(hw, 0x14, 0xffff);
+	rtl_mdio_write(hw, 0x13, 0xb84c);
+	rtl_mdio_write(hw, 0x14, 0xffff);
+	rtl_mdio_write(hw, 0x13, 0xb832);
+	rtl_mdio_write(hw, 0x14, 0x001f);
+
+	rtl_mdio_write(hw, 0x1F, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x0000);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+	rtl_mdio_write(hw, 0x1f, 0x0B82);
+	gphy_val = rtl_mdio_read(hw, 0x17);
+	gphy_val &= ~BIT_0;
+	rtl_mdio_write(hw, 0x17, gphy_val);
+	rtl_mdio_write(hw, 0x1f, 0x0A43);
+	rtl_mdio_write(hw, 0x13, 0x8042);
+	rtl_mdio_write(hw, 0x14, 0x0000);
+
+	rtl_clear_phy_mcu_patch_request(hw);
+}
+
+void
+hw_mac_mcu_config_8168h(struct rtl_hw *hw)
+{
+	if (hw->NotWrMcuPatchCode)
+		return;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_29:
+		rtl8168_set_mac_mcu_8168h_1(hw);
+		break;
+	case CFG_METHOD_30:
+	case CFG_METHOD_37:
+		rtl8168_set_mac_mcu_8168h_2(hw);
+		break;
+	case CFG_METHOD_35:
+		rtl8168_set_mac_mcu_8168h_3(hw);
+		break;
+	case CFG_METHOD_36:
+		rtl8168_set_mac_mcu_8168h_4(hw);
+		break;
+	}
+}
+
+void
+hw_phy_mcu_config_8168h(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_29:
+		rtl8168_set_phy_mcu_8168h_1(hw);
+		break;
+	case CFG_METHOD_30:
+	case CFG_METHOD_37:
+		rtl8168_set_phy_mcu_8168h_2(hw);
+		break;
+	case CFG_METHOD_35:
+		rtl8168_set_phy_mcu_8168h_3(hw);
+		break;
+	case CFG_METHOD_36:
+		break;
+	}
+}
diff --git a/drivers/net/r8169/base/rtl8168m.c b/drivers/net/r8169/base/rtl8168m.c
new file mode 100644
index 0000000000..2b544c9fe8
--- /dev/null
+++ b/drivers/net/r8169/base/rtl8168m.c
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Realtek Corporation. All rights reserved
+ */
+
+#include "../r8169_compat.h"
+#include "../r8169_hw.h"
+#include "../r8169_phy.h"
+#include "rtl8168h.h"
+
+/* For RTL8168M, CFG_METHOD_37 */
+
+const struct rtl_hw_ops rtl8168m_ops = {
+	.hw_config         = hw_config_8168h,
+	.hw_init_rxcfg     = hw_init_rxcfg_8168h,
+	.hw_ephy_config    = hw_ephy_config_8168h,
+	.hw_phy_config     = hw_phy_config_8168h,
+	.hw_mac_mcu_config = hw_mac_mcu_config_8168h,
+	.hw_phy_mcu_config = hw_phy_mcu_config_8168h,
+};
diff --git a/drivers/net/r8169/meson.build b/drivers/net/r8169/meson.build
index d1e65377a3..720d79acff 100644
--- a/drivers/net/r8169/meson.build
+++ b/drivers/net/r8169/meson.build
@@ -18,4 +18,13 @@ sources = files(
         'base/rtl8126a.c',
         'base/rtl8126a_mcu.c',
         'base/rtl8168kb.c',
+        'base/rtl8168g.c',
+        'base/rtl8168g_mcu.c',
+        'base/rtl8168h.c',
+        'base/rtl8168h_mcu.c',
+        'base/rtl8168ep.c',
+        'base/rtl8168ep_mcu.c',
+        'base/rtl8168fp.c',
+        'base/rtl8168fp_mcu.c',
+        'base/rtl8168m.c',
 )
\ No newline at end of file
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index f5b953b098..631acffb64 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -355,16 +355,16 @@ enum RTL_register_content {
 	/* Config3 register */
 	Isolate_en  = (1UL << 12), /* Isolate enable */
 	MagicPacket = (1UL << 5),  /* Wake up when receives a magic packet */
-	LinkUp      = (1UL << 4),  /* This bit is reserved in RTL8125B. */
+	LinkUp      = (1UL << 4),
 
 	/* Wake up when the cable connection is re-established */
-	ECRCEN      = (1UL << 3), /* This bit is reserved in RTL8125B. */
-	Jumbo_En0   = (1UL << 2), /* This bit is reserved in RTL8125B. */
-	RDY_TO_L23  = (1UL << 1), /* This bit is reserved in RTL8125B. */
-	Beacon_en   = (1UL << 0), /* This bit is reserved in RTL8125B. */
+	ECRCEN      = (1UL << 3),
+	Jumbo_En0   = (1UL << 2),
+	RDY_TO_L23  = (1UL << 1),
+	Beacon_en   = (1UL << 0),
 
 	/* Config4 register */
-	Jumbo_En1   = (1UL << 1), /* This bit is reserved in RTL8125B. */
+	Jumbo_En1   = (1UL << 1),
 
 	/* Config5 register */
 	BWF         = (1UL << 6), /* Accept broadcast wakeup frame */
@@ -380,8 +380,8 @@ enum RTL_register_content {
 	Force_halfdup   = (1UL << 12),
 	Force_rxflow_en = (1UL << 11),
 	Force_txflow_en = (1UL << 10),
-	Cxpl_dbg_sel    = (1UL << 9), /* This bit is reserved in RTL8125B. */
-	ASF             = (1UL << 8), /* This bit is reserved in RTL8125C. */
+	Cxpl_dbg_sel    = (1UL << 9),
+	ASF             = (1UL << 8),
 	PktCntrDisable  = (1UL << 7),
 	RxVlan          = (1UL << 6),
 	RxChkSum        = (1UL << 5),
@@ -508,6 +508,11 @@ enum RTL_chipset_name {
 	RTL8125BP,
 	RTL8125D,
 	RTL8126A,
+	RTL8168EP,
+	RTL8168FP,
+	RTL8168G,
+	RTL8168H,
+	RTL8168M,
 	UNKNOWN
 };
 
@@ -540,6 +545,8 @@ enum RTL_chipset_name {
 #define InterFrameGap       0x03    /* 3 means InterFrameGap = the shortest one */
 #define Rx_Fetch_Number_8  (1 << 30)
 #define Rx_Close_Multiple  (1 << 21)
+#define RxEarly_off_V2	   (1 << 11)
+#define Rx_Single_fetch_V2 (1 << 14)
 
 #define TRUE  1
 #define FALSE 0
@@ -567,8 +574,6 @@ enum RTL_chipset_name {
 #define ADVERTISE_5000_HALF   0x0100 /* NOT used, just FYI */
 #define ADVERTISE_5000_FULL   0x0200
 
-#define MAC_ADDR_LEN    RTE_ETHER_ADDR_LEN
-
 #define RTL_MAX_TX_DESC 4096
 #define RTL_MAX_RX_DESC 4096
 #define RTL_MIN_TX_DESC 64
diff --git a/drivers/net/r8169/r8169_dash.c b/drivers/net/r8169/r8169_dash.c
index 21684b19eb..0da7e07283 100644
--- a/drivers/net/r8169/r8169_dash.c
+++ b/drivers/net/r8169/r8169_dash.c
@@ -48,7 +48,7 @@ rtl_get_dash_fw_ver(struct rtl_hw *hw)
 {
 	u32 ver = 0xffffffff;
 
-	if (HW_DASH_SUPPORT_GET_FIRMWARE_VERSION(hw) == FALSE)
+	if (!HW_DASH_SUPPORT_GET_FIRMWARE_VERSION(hw))
 		goto exit;
 
 	ver = rtl_ocp_read(hw, OCP_REG_FIRMWARE_MAJOR_VERSION, 4);
@@ -63,46 +63,165 @@ _rtl_check_dash(struct rtl_hw *hw)
 	if (!hw->AllowAccessDashOcp)
 		return 0;
 
-	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_4(hw)) {
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_3(hw) ||
+	    HW_DASH_SUPPORT_TYPE_4(hw)) {
 		if (rtl_ocp_read(hw, 0x128, 1) & BIT_0)
 			return 1;
+		else
+			return 0;
+	} else if (HW_DASH_SUPPORT_TYPE_1(hw)) {
+		if (rtl_ocp_read(hw, 0x10, 2) & 0x00008000)
+			return 1;
+		else
+			return 0;
+	} else {
+		return 0;
 	}
-
-	return 0;
 }
 
 int
 rtl_check_dash(struct rtl_hw *hw)
 {
-	u32 ver;
+	int dash_enabled;
+	u32 fw_ver;
 
-	if (_rtl_check_dash(hw)) {
-		ver = rtl_get_dash_fw_ver(hw);
-		if (!(ver == 0 || ver == 0xffffffff))
-			return 1;
+	dash_enabled = _rtl_check_dash(hw);
+
+	if (!dash_enabled)
+		goto exit;
+
+	if (!HW_DASH_SUPPORT_GET_FIRMWARE_VERSION(hw))
+		goto exit;
+
+	fw_ver = rtl_get_dash_fw_ver(hw);
+	if (fw_ver == 0 || fw_ver == 0xffffffff)
+		dash_enabled = 0;
+exit:
+	return dash_enabled;
+}
+
+static u32
+rtl8168_csi_to_cmac_r32(struct rtl_hw *hw)
+{
+	u32 cmd;
+	int i;
+	u32 value = 0;
+
+	cmd = CSIAR_Read | CSIAR_ByteEn << CSIAR_ByteEn_shift | 0xf9;
+
+	cmd |= 1 << 16;
+
+	RTL_W32(hw, CSIAR, cmd);
+
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
+
+		/* Check if the RTL8168 has completed CSI read */
+		if (RTL_R32(hw, CSIAR) & CSIAR_Flag) {
+			value = RTL_R32(hw, CSIDR);
+			break;
+		}
 	}
 
-	return 0;
+	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
+
+	return value;
+}
+
+static u8
+rtl8168_csi_to_cmac_r8(struct rtl_hw *hw, u32 reg)
+{
+	u32 mask, value1 = 0;
+	u8 val_shift, value2 = 0;
+
+	val_shift = reg - 0xf8;
+
+	if (val_shift == 0)
+		mask = 0xFF;
+	else if (val_shift == 1)
+		mask = 0xFF00;
+	else if (val_shift == 2)
+		mask = 0xFF0000;
+	else
+		mask = 0xFF000000;
+
+	value1 = rtl8168_csi_to_cmac_r32(hw) & mask;
+	value2 = value1 >> (val_shift * 8);
+
+	return value2;
 }
 
 static void
-rtl8125_dash2_disable_tx(struct rtl_hw *hw)
+rtl8168_csi_to_cmac_w8(struct rtl_hw *hw, u32 reg, u8 value)
 {
-	u16 wait_cnt = 0;
-	u8 tmp_uchar;
+	int i;
+	u8 val_shift;
+	u32 value32, cmd, mask;
 
-	if (!HW_DASH_SUPPORT_CMAC(hw))
-		return;
+	val_shift = reg - 0xf8;
 
-	if (!hw->DASH)
-		return;
+	if (val_shift == 0)
+		mask = 0xFF;
+	else if (val_shift == 1)
+		mask = 0xFF00;
+	else if (val_shift == 2)
+		mask = 0xFF0000;
+	else
+		mask = 0xFF000000;
+
+	value32 = rtl8168_csi_to_cmac_r32(hw) & ~mask;
+	value32 |= value << (val_shift * 8);
+	RTL_W32(hw, CSIDR, value32);
+
+	cmd = CSIAR_Write | CSIAR_ByteEn << CSIAR_ByteEn_shift | 0xf9;
+
+	cmd |= 1 << 16;
+
+	RTL_W32(hw, CSIAR, cmd);
+
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
+
+		/* Check if the RTL8168 has completed CSI write */
+		if (!(RTL_R32(hw, CSIAR) & CSIAR_Flag))
+			break;
+	}
+
+	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
+}
+
+static void
+rtl_cmac_w8(struct rtl_hw *hw, u32 reg, u8 value)
+{
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_4(hw))
+		RTL_CMAC_W8(hw, reg, value);
+	else if (HW_DASH_SUPPORT_TYPE_3(hw))
+		rtl8168_csi_to_cmac_w8(hw, reg, value);
+}
+
+static u8
+rtl_cmac_r8(struct rtl_hw *hw, u32 reg)
+{
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_4(hw))
+		return RTL_CMAC_R8(hw, reg);
+	else if (HW_DASH_SUPPORT_TYPE_3(hw))
+		return rtl8168_csi_to_cmac_r8(hw, reg);
+	else
+		return 0;
+}
+
+static void
+rtl_dash2_disable_tx(struct rtl_hw *hw)
+{
+	u16 wait_cnt = 0;
+	u8 tmp_uchar;
 
 	/* Disable oob Tx */
-	RTL_CMAC_W8(hw, CMAC_IBCR2, RTL_CMAC_R8(hw, CMAC_IBCR2) & ~BIT_0);
+	rtl_cmac_w8(hw, CMAC_IBCR2, rtl_cmac_r8(hw, CMAC_IBCR2) & ~BIT_0);
 
 	/* Wait oob Tx disable */
 	do {
-		tmp_uchar = RTL_CMAC_R8(hw, CMAC_IBISR0);
+		tmp_uchar = rtl_cmac_r8(hw, CMAC_IBISR0);
 		if (tmp_uchar & ISRIMR_DASH_TYPE2_TX_DISABLE_IDLE)
 			break;
 
@@ -111,30 +230,27 @@ rtl8125_dash2_disable_tx(struct rtl_hw *hw)
 	} while (wait_cnt < 2000);
 
 	/* Clear ISRIMR_DASH_TYPE2_TX_DISABLE_IDLE */
-	RTL_CMAC_W8(hw, CMAC_IBISR0, RTL_CMAC_R8(hw, CMAC_IBISR0) |
+	rtl_cmac_w8(hw, CMAC_IBISR0, rtl_cmac_r8(hw, CMAC_IBISR0) |
 		    ISRIMR_DASH_TYPE2_TX_DISABLE_IDLE);
 }
 
 static void
-rtl8125_dash2_disable_rx(struct rtl_hw *hw)
+rtl_dash2_disable_rx(struct rtl_hw *hw)
 {
-	if (!HW_DASH_SUPPORT_CMAC(hw))
-		return;
-
-	if (!hw->DASH)
-		return;
-
-	RTL_CMAC_W8(hw, CMAC_IBCR0, RTL_CMAC_R8(hw, CMAC_IBCR0) & ~BIT_0);
+	rtl_cmac_w8(hw, CMAC_IBCR0, rtl_cmac_r8(hw, CMAC_IBCR0) & ~BIT_0);
 }
 
 void
-rtl8125_dash2_disable_txrx(struct rtl_hw *hw)
+rtl_dash2_disable_txrx(struct rtl_hw *hw)
 {
 	if (!HW_DASH_SUPPORT_CMAC(hw))
 		return;
 
-	rtl8125_dash2_disable_tx(hw);
-	rtl8125_dash2_disable_rx(hw);
+	if (!hw->DASH)
+		return;
+
+	rtl_dash2_disable_tx(hw);
+	rtl_dash2_disable_rx(hw);
 }
 
 static void
@@ -154,7 +270,7 @@ rtl8125_notify_dash_oob_cmac(struct rtl_hw *hw, u32 cmd)
 static void
 rtl8125_notify_dash_oob_ipc2(struct rtl_hw *hw, u32 cmd)
 {
-	if (HW_DASH_SUPPORT_TYPE_4(hw) == FALSE)
+	if (!HW_DASH_SUPPORT_TYPE_4(hw))
 		return;
 
 	rtl_ocp_write(hw, IB2SOC_DATA, 4, cmd);
@@ -179,20 +295,36 @@ rtl8125_notify_dash_oob(struct rtl_hw *hw, u32 cmd)
 }
 
 static int
-rtl8125_wait_dash_fw_ready(struct rtl_hw *hw)
+rtl_wait_dash_fw_ready(struct rtl_hw *hw)
 {
 	int rc = -1;
 	int timeout;
 
+	if (!HW_DASH_SUPPORT_DASH(hw))
+		goto out;
+
 	if (!hw->DASH)
 		goto out;
 
-	for (timeout = 0; timeout < 10; timeout++) {
-		rte_delay_ms(10);
-		if (rtl_ocp_read(hw, 0x124, 1) & BIT_0) {
-			rc = 1;
-			goto out;
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_3(hw) ||
+	    HW_DASH_SUPPORT_TYPE_4(hw)) {
+		for (timeout = 0; timeout < 10; timeout++) {
+			rte_delay_ms(10);
+			if (rtl_ocp_read(hw, 0x124, 1) & BIT_0) {
+				rc = 1;
+				goto out;
+			}
 		}
+	} else if (HW_DASH_SUPPORT_TYPE_1(hw)) {
+		for (timeout = 0; timeout < 10; timeout++) {
+			rte_delay_ms(10);
+			if (rtl_ocp_read(hw, 0x10, 2) & BIT_11) {
+				rc = 1;
+				goto out;
+			}
+		}
+	} else {
+		goto out;
 	}
 
 	rc = 0;
@@ -201,7 +333,7 @@ rtl8125_wait_dash_fw_ready(struct rtl_hw *hw)
 	return rc;
 }
 
-void
+static void
 rtl8125_driver_start(struct rtl_hw *hw)
 {
 	if (!hw->AllowAccessDashOcp)
@@ -209,19 +341,242 @@ rtl8125_driver_start(struct rtl_hw *hw)
 
 	rtl8125_notify_dash_oob(hw, OOB_CMD_DRIVER_START);
 
-	rtl8125_wait_dash_fw_ready(hw);
+	rtl_wait_dash_fw_ready(hw);
+}
+
+static void
+rtl8168_clear_and_set_other_fun_pci_bit(struct rtl_hw *hw, u8 multi_fun_sel_bit,
+					u32 addr, u32 clearmask, u32 setmask)
+{
+	u32 tmp_ulong;
+
+	tmp_ulong = rtl_csi_other_fun_read(hw, multi_fun_sel_bit, addr);
+	tmp_ulong &= ~clearmask;
+	tmp_ulong |= setmask;
+	rtl_csi_other_fun_write(hw, multi_fun_sel_bit, addr, tmp_ulong);
+}
+
+static void
+rtl8168_other_fun_dev_pci_setting(struct rtl_hw *hw, u32 addr, u32 clearmask,
+				  u32 setmask, u8 multi_fun_sel_bit)
+{
+	u32 tmp_ulong;
+	u8 i;
+	u8 fun_bit;
+	u8 set_other_fun;
+
+	for (i = 0; i < 8; i++) {
+		fun_bit = (1 << i);
+		if (!(fun_bit & multi_fun_sel_bit))
+			continue;
+
+		set_other_fun = TRUE;
+
+		switch (hw->mcfg) {
+		case CFG_METHOD_23:
+		case CFG_METHOD_27:
+		case CFG_METHOD_28:
+			/*
+			 * 0: UMAC, 1: TCR1, 2: TCR2, 3: KCS,
+			 * 4: EHCI(Control by EHCI Driver)
+			 */
+			if (i < 5) {
+				tmp_ulong = rtl_csi_other_fun_read(hw, i, 0x00);
+				if (tmp_ulong == 0xFFFFFFFF)
+					set_other_fun = TRUE;
+				else
+					set_other_fun = FALSE;
+			}
+			break;
+		case CFG_METHOD_31:
+		case CFG_METHOD_32:
+		case CFG_METHOD_33:
+		case CFG_METHOD_34:
+			/*
+			 * 0: BMC, 1: NIC, 2: TCR, 3: VGA / PCIE_TO_USB,
+			 * 4: EHCI, 5: WIFI, 6: WIFI, 7: KCS
+			 */
+			if (i == 5 || i == 6) {
+				if (hw->DASH) {
+					tmp_ulong = rtl_ocp_read(hw, 0x184, 4);
+					if (tmp_ulong & BIT_26)
+						set_other_fun = FALSE;
+					else
+						set_other_fun = TRUE;
+				}
+			} else { /* Function 0/1/2/3/4/7 */
+				tmp_ulong = rtl_csi_other_fun_read(hw, i, 0x00);
+				if (tmp_ulong == 0xFFFFFFFF)
+					set_other_fun = TRUE;
+				else
+					set_other_fun = FALSE;
+			}
+			break;
+		default:
+			return;
+		}
+
+		if (set_other_fun)
+			rtl8168_clear_and_set_other_fun_pci_bit(hw, i, addr,
+								clearmask, setmask);
+	}
+}
+
+static void
+rtl8168_set_dash_other_fun_dev_state_change(struct rtl_hw *hw, u8 dev_state,
+					    u8 multi_fun_sel_bit)
+{
+	u32 clearmask;
+	u32 setmask;
+
+	if (dev_state == 0) {
+		/* Goto D0 */
+		clearmask = (BIT_0 | BIT_1);
+		setmask = 0;
+
+		rtl8168_other_fun_dev_pci_setting(hw, 0x44, clearmask, setmask,
+						  multi_fun_sel_bit);
+	} else {
+		/* Goto D3 */
+		clearmask = 0;
+		setmask = (BIT_0 | BIT_1);
+
+		rtl8168_other_fun_dev_pci_setting(hw, 0x44, clearmask, setmask,
+						  multi_fun_sel_bit);
+	}
+}
+
+static void
+rtl8168_set_dash_other_fun_dev_aspm_clkreq(struct rtl_hw *hw, u8 aspm_val,
+					   u8 clkreq_en, u8 multi_fun_sel_bit)
+{
+	u32 clearmask;
+	u32 setmask;
+
+	aspm_val &= (BIT_0 | BIT_1);
+	clearmask = (BIT_0 | BIT_1 | BIT_8);
+	setmask = aspm_val;
+	if (clkreq_en)
+		setmask |= BIT_8;
+
+	rtl8168_other_fun_dev_pci_setting(hw, 0x80, clearmask, setmask,
+					  multi_fun_sel_bit);
+}
+
+static void
+rtl8168_oob_notify(struct rtl_hw *hw, u8 cmd)
+{
+	rtl_eri_write(hw, 0xE8, 1, cmd, ERIAR_ExGMAC);
+
+	rtl_ocp_write(hw, 0x30, 1, 0x01);
+}
+
+static void
+rtl8168_driver_start(struct rtl_hw *hw)
+{
+	u32 tmp_value;
+
+	/* Change other device state to D0. */
+	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		rtl8168_set_dash_other_fun_dev_aspm_clkreq(hw, 3, 1, 0x1E);
+		rtl8168_set_dash_other_fun_dev_state_change(hw, 3, 0x1E);
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		rtl8168_set_dash_other_fun_dev_aspm_clkreq(hw, 3, 1, 0xFC);
+		rtl8168_set_dash_other_fun_dev_state_change(hw, 3, 0xFC);
+		break;
+	}
+
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_3(hw)) {
+		rtl_ocp_write(hw, 0x180, 1, OOB_CMD_DRIVER_START);
+		tmp_value = rtl_ocp_read(hw, 0x30, 1);
+		tmp_value |= BIT_0;
+		rtl_ocp_write(hw, 0x30, 1, tmp_value);
+	} else {
+		rtl8168_oob_notify(hw, OOB_CMD_DRIVER_START);
+	}
+
+	rtl_wait_dash_fw_ready(hw);
 }
 
 void
+rtl_driver_start(struct rtl_hw *hw)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_driver_start(hw);
+	else
+		rtl8168_driver_start(hw);
+}
+
+static void
+rtl8168_driver_stop(struct rtl_hw *hw)
+{
+	u32 tmp_value;
+
+	if (HW_DASH_SUPPORT_TYPE_2(hw) || HW_DASH_SUPPORT_TYPE_3(hw)) {
+		rtl_dash2_disable_txrx(hw);
+
+		rtl_ocp_write(hw, 0x180, 1, OOB_CMD_DRIVER_STOP);
+		tmp_value = rtl_ocp_read(hw, 0x30, 1);
+		tmp_value |= BIT_0;
+		rtl_ocp_write(hw, 0x30, 1, tmp_value);
+	} else if (HW_DASH_SUPPORT_TYPE_1(hw)) {
+		rtl8168_oob_notify(hw, OOB_CMD_DRIVER_STOP);
+	}
+
+	rtl_wait_dash_fw_ready(hw);
+
+	/* Change other device state to D3. */
+	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		rtl8168_set_dash_other_fun_dev_state_change(hw, 3, 0x0E);
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		rtl8168_set_dash_other_fun_dev_state_change(hw, 3, 0xFD);
+		break;
+	}
+}
+
+static void
 rtl8125_driver_stop(struct rtl_hw *hw)
 {
 	if (!hw->AllowAccessDashOcp)
 		return;
 
 	if (HW_DASH_SUPPORT_CMAC(hw))
-		rtl8125_dash2_disable_txrx(hw);
+		rtl_dash2_disable_txrx(hw);
 
 	rtl8125_notify_dash_oob(hw, OOB_CMD_DRIVER_STOP);
 
-	rtl8125_wait_dash_fw_ready(hw);
+	rtl_wait_dash_fw_ready(hw);
+}
+
+void
+rtl_driver_stop(struct rtl_hw *hw)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_driver_stop(hw);
+	else
+		rtl8168_driver_stop(hw);
+}
+
+bool
+rtl8168_check_dash_other_fun_present(struct rtl_hw *hw)
+{
+	/* Check if func 2 exist */
+	if (rtl_csi_other_fun_read(hw, 2, 0x00) != 0xffffffff)
+		return true;
+	else
+		return false;
 }
diff --git a/drivers/net/r8169/r8169_dash.h b/drivers/net/r8169/r8169_dash.h
index daa572b456..47c5d6906e 100644
--- a/drivers/net/r8169/r8169_dash.h
+++ b/drivers/net/r8169/r8169_dash.h
@@ -50,8 +50,10 @@ bool rtl_is_allow_access_dash_ocp(struct rtl_hw *hw);
 
 int rtl_check_dash(struct rtl_hw *hw);
 
-void rtl8125_driver_start(struct rtl_hw *hw);
-void rtl8125_driver_stop(struct rtl_hw *hw);
-void rtl8125_dash2_disable_txrx(struct rtl_hw *hw);
+void rtl_driver_start(struct rtl_hw *hw);
+void rtl_driver_stop(struct rtl_hw *hw);
+void rtl_dash2_disable_txrx(struct rtl_hw *hw);
+
+bool rtl8168_check_dash_other_fun_present(struct rtl_hw *hw);
 
 #endif /* R8169_DASH_H */
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index c0cac6e7d8..e2ea9435fe 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -26,12 +26,12 @@
 #include "r8169_hw.h"
 #include "r8169_dash.h"
 
-static int rtl_dev_configure(struct rte_eth_dev *dev);
+static int rtl_dev_configure(struct rte_eth_dev *dev __rte_unused);
 static int rtl_dev_start(struct rte_eth_dev *dev);
 static int rtl_dev_stop(struct rte_eth_dev *dev);
 static int rtl_dev_reset(struct rte_eth_dev *dev);
 static int rtl_dev_close(struct rte_eth_dev *dev);
-static int rtl_dev_link_update(struct rte_eth_dev *dev, int wait);
+static int rtl_dev_link_update(struct rte_eth_dev *dev, int wait __rte_unused);
 static int rtl_dev_set_link_up(struct rte_eth_dev *dev);
 static int rtl_dev_set_link_down(struct rte_eth_dev *dev);
 static int rtl_dev_infos_get(struct rte_eth_dev *dev,
@@ -55,6 +55,7 @@ static const struct rte_pci_id pci_id_r8169_map[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8162) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8126) },
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x5000) },
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8168) },
 	{.vendor_id = 0, /* sentinel */ },
 };
 
@@ -116,15 +117,23 @@ static void
 rtl_disable_intr(struct rtl_hw *hw)
 {
 	PMD_INIT_FUNC_TRACE();
-	RTL_W32(hw, IMR0_8125, 0x0000);
-	RTL_W32(hw, ISR0_8125, RTL_R32(hw, ISR0_8125));
+	if (rtl_is_8125(hw)) {
+		RTL_W32(hw, IMR0_8125, 0x0000);
+		RTL_W32(hw, ISR0_8125, RTL_R32(hw, ISR0_8125));
+	} else {
+		RTL_W16(hw, IntrMask, 0x0000);
+		RTL_W16(hw, IntrStatus, RTL_R16(hw, IntrStatus));
+	}
 }
 
 static void
 rtl_enable_intr(struct rtl_hw *hw)
 {
 	PMD_INIT_FUNC_TRACE();
-	RTL_W32(hw, IMR0_8125, LinkChg);
+	if (rtl_is_8125(hw))
+		RTL_W32(hw, IMR0_8125, LinkChg);
+	else
+		RTL_W16(hw, IntrMask, LinkChg);
 }
 
 static int
@@ -134,10 +143,35 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 	struct rtl_hw *hw = &adapter->hw;
 	u64 adv = 0;
 	u32 *link_speeds = &dev->data->dev_conf.link_speeds;
+	unsigned int speed_mode;
 
 	/* Setup link speed and duplex */
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		rtl_set_link_option(hw, AUTONEG_ENABLE, SPEED_5000, DUPLEX_FULL, rtl_fc_full);
+		switch (hw->mcfg) {
+		case CFG_METHOD_48:
+		case CFG_METHOD_49:
+		case CFG_METHOD_50:
+		case CFG_METHOD_51:
+		case CFG_METHOD_52:
+		case CFG_METHOD_53:
+		case CFG_METHOD_54:
+		case CFG_METHOD_55:
+		case CFG_METHOD_56:
+		case CFG_METHOD_57:
+			speed_mode = SPEED_2500;
+			break;
+		case CFG_METHOD_69:
+		case CFG_METHOD_70:
+		case CFG_METHOD_71:
+			speed_mode = SPEED_5000;
+			break;
+		default:
+			speed_mode = SPEED_1000;
+			break;
+		}
+
+		rtl_set_link_option(hw, AUTONEG_ENABLE, speed_mode, DUPLEX_FULL,
+				    rtl_fc_full);
 	} else if (*link_speeds != 0) {
 		if (*link_speeds & ~(RTE_ETH_LINK_SPEED_10M_HD | RTE_ETH_LINK_SPEED_10M |
 				     RTE_ETH_LINK_SPEED_100M_HD | RTE_ETH_LINK_SPEED_100M |
@@ -225,6 +259,18 @@ rtl_setup_link(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Set PCI configuration space offset 0x79 to setting */
+static void
+set_offset79(struct rte_pci_device *pdev, u8 setting)
+{
+	u8 device_control;
+
+	PCI_READ_CONFIG_BYTE(pdev, &device_control, 0x79);
+	device_control &= ~0x70;
+	device_control |= setting;
+	PCI_WRITE_CONFIG_BYTE(pdev, &device_control, 0x79);
+}
+
 /*
  * Configure device link speed and setup link.
  * It returns 0 on success.
@@ -249,6 +295,28 @@ rtl_dev_start(struct rte_eth_dev *dev)
 
 	rtl_hw_config(hw);
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		set_offset79(pci_dev, 0x40);
+		break;
+	}
+
 	/* Initialize transmission unit */
 	rtl_tx_init(dev);
 
@@ -295,8 +363,19 @@ rtl_dev_stop(struct rte_eth_dev *dev)
 	rtl_nic_reset(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting);
 		break;
 	}
@@ -333,8 +412,19 @@ rtl_dev_set_link_down(struct rte_eth_dev *dev)
 
 	/* mcu pme intr masks */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE00A, hw->mcu_pme_setting & ~(BIT_11 | BIT_14));
 		break;
 	}
@@ -515,20 +605,63 @@ rtl_dev_link_update(struct rte_eth_dev *dev, int wait __rte_unused)
 
 		if (status & FullDup) {
 			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
-			if (hw->mcfg == CFG_METHOD_2)
+			switch (hw->mcfg) {
+			case CFG_METHOD_21:
+			case CFG_METHOD_22:
+			case CFG_METHOD_23:
+			case CFG_METHOD_24:
+			case CFG_METHOD_25:
+			case CFG_METHOD_26:
+			case CFG_METHOD_27:
+			case CFG_METHOD_28:
+			case CFG_METHOD_29:
+			case CFG_METHOD_30:
+			case CFG_METHOD_31:
+			case CFG_METHOD_32:
+			case CFG_METHOD_33:
+			case CFG_METHOD_34:
+			case CFG_METHOD_35:
+			case CFG_METHOD_36:
+			case CFG_METHOD_37:
+			case CFG_METHOD_48:
 				RTL_W32(hw, TxConfig, (RTL_R32(hw, TxConfig) |
-						       (BIT_24 | BIT_25)) & ~BIT_19);
-
+						      (BIT_24 | BIT_25)) & ~BIT_19);
+				break;
+			}
 		} else {
 			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
-			if (hw->mcfg == CFG_METHOD_2)
+			switch (hw->mcfg) {
+			case CFG_METHOD_21:
+			case CFG_METHOD_22:
+			case CFG_METHOD_23:
+			case CFG_METHOD_24:
+			case CFG_METHOD_25:
+			case CFG_METHOD_26:
+			case CFG_METHOD_27:
+			case CFG_METHOD_28:
+			case CFG_METHOD_29:
+			case CFG_METHOD_30:
+			case CFG_METHOD_31:
+			case CFG_METHOD_32:
+			case CFG_METHOD_33:
+			case CFG_METHOD_34:
+			case CFG_METHOD_35:
+			case CFG_METHOD_36:
+			case CFG_METHOD_37:
+			case CFG_METHOD_48:
 				RTL_W32(hw, TxConfig, (RTL_R32(hw, TxConfig) | BIT_25) &
-					~(BIT_19 | BIT_24));
+						      ~(BIT_19 | BIT_24));
+				break;
+			}
 		}
 
-		if (status & _5000bpsF)
+		/*
+		 * The PHYstatus register for the RTL8168 is 8 bits,
+		 * while for the RTL8125 and RTL8126, it is 16 bits.
+		 */
+		if (status & _5000bpsF && rtl_is_8125(hw))
 			speed = 5000;
-		else if (status & _2500bpsF)
+		else if (status & _2500bpsF && rtl_is_8125(hw))
 			speed = 2500;
 		else if (status & _1000bpsF)
 			speed = 1000;
@@ -556,7 +689,10 @@ rtl_dev_interrupt_handler(void *param)
 	struct rtl_hw *hw = &adapter->hw;
 	uint32_t intr;
 
-	intr = RTL_R32(hw, ISR0_8125);
+	if (rtl_is_8125(hw))
+		intr = RTL_R32(hw, ISR0_8125);
+	else
+		intr = RTL_R16(hw, IntrStatus);
 
 	/* Clear all cause mask */
 	rtl_disable_intr(hw);
@@ -586,7 +722,7 @@ rtl_dev_close(struct rte_eth_dev *dev)
 		return 0;
 
 	if (HW_DASH_SUPPORT_DASH(hw))
-		rtl8125_driver_stop(hw);
+		rtl_driver_stop(hw);
 
 	ret_stp = rtl_dev_stop(dev);
 
@@ -656,14 +792,15 @@ rtl_dev_init(struct rte_eth_dev *dev)
 	dev->tx_pkt_burst = &rtl_xmit_pkts;
 	dev->rx_pkt_burst = &rtl_recv_pkts;
 
-	/* For secondary processes, the primary process has done all the work */
+	/* For secondary processes, the primary process has done all the work. */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		if (dev->data->scattered_rx)
 			dev->rx_pkt_burst = &rtl_recv_scattered_pkts;
 		return 0;
 	}
 
-	hw->mmio_addr = (u8 *)pci_dev->mem_resource[2].addr; /* RTL8169 uses BAR2 */
+	/* R8169 uses BAR2 */
+	hw->mmio_addr = (u8 *)pci_dev->mem_resource[2].addr;
 
 	rtl_get_mac_version(hw, pci_dev);
 
diff --git a/drivers/net/r8169/r8169_ethdev.h b/drivers/net/r8169/r8169_ethdev.h
index c5fd465ff0..0de91045fa 100644
--- a/drivers/net/r8169/r8169_ethdev.h
+++ b/drivers/net/r8169/r8169_ethdev.h
@@ -15,6 +15,7 @@
 struct rtl_hw;
 
 struct rtl_hw_ops {
+	void (*hw_config)(struct rtl_hw *hw);
 	void (*hw_init_rxcfg)(struct rtl_hw *hw);
 	void (*hw_ephy_config)(struct rtl_hw *hw);
 	void (*hw_phy_config)(struct rtl_hw *hw);
@@ -36,13 +37,12 @@ struct rtl_hw {
 	u8  *mmio_addr;
 	u8  *cmac_ioaddr; /* cmac memory map physical address */
 	u8  chipset_name;
-	u8  efuse_ver;
 	u8  HwIcVerUnknown;
 	u32 mcfg;
 	u32 mtu;
 	u8  HwSuppIntMitiVer;
 	u16 cur_page;
-	u8  mac_addr[MAC_ADDR_LEN];
+	u8  mac_addr[RTE_ETHER_ADDR_LEN];
 	u32 rx_buf_sz;
 
 	struct rtl_counters *tally_vaddr;
@@ -53,9 +53,9 @@ struct rtl_hw {
 	u8  HwSuppMacMcuVer;
 	u16 MacMcuPageSize;
 
-	u8  NotWrRamCodeToMicroP;
-	u8  HwHasWrRamCodeToMicroP;
-	u8  HwSuppCheckPhyDisableModeVer;
+	u8 NotWrRamCodeToMicroP;
+	u8 HwHasWrRamCodeToMicroP;
+	u8 HwSuppCheckPhyDisableModeVer;
 
 	u16 sw_ram_code_ver;
 	u16 hw_ram_code_ver;
@@ -68,7 +68,7 @@ struct rtl_hw {
 
 	u32 HwSuppMaxPhyLinkSpeed;
 
-	u8  HwSuppNowIsOobVer;
+	u8 HwSuppNowIsOobVer;
 
 	u16 mcu_pme_setting;
 
@@ -86,6 +86,8 @@ struct rtl_hw {
 	u8 DASH;
 	u8 HwSuppOcpChannelVer;
 	u8 AllowAccessDashOcp;
+	u8 HwPkgDet;
+	u8 HwSuppSerDesPhyVer;
 };
 
 struct rtl_sw_stats {
@@ -108,6 +110,24 @@ struct rtl_adapter {
 #define R8169_LINK_CHECK_TIMEOUT  50   /* 10s */
 #define R8169_LINK_CHECK_INTERVAL 200  /* ms */
 
+#define PCI_READ_CONFIG_BYTE(dev, val, where) \
+	rte_pci_read_config(dev, val, 1, where)
+
+#define PCI_READ_CONFIG_WORD(dev, val, where) \
+	rte_pci_read_config(dev, val, 2, where)
+
+#define PCI_READ_CONFIG_DWORD(dev, val, where) \
+	rte_pci_read_config(dev, val, 4, where)
+
+#define PCI_WRITE_CONFIG_BYTE(dev, val, where) \
+	rte_pci_write_config(dev, val, 1, where)
+
+#define PCI_WRITE_CONFIG_WORD(dev, val, where) \
+	rte_pci_write_config(dev, val, 2, where)
+
+#define PCI_WRITE_CONFIG_DWORD(dev, val, where) \
+	rte_pci_write_config(dev, val, 4, where)
+
 int rtl_rx_init(struct rte_eth_dev *dev);
 int rtl_tx_init(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index 63a20a733e..21a599dfc6 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -77,6 +77,12 @@ rtl_eri_read_with_oob_base_address(struct rtl_hw *hw, int addr, int len,
 	return value2;
 }
 
+u32
+rtl_eri_read(struct rtl_hw *hw, int addr, int len, int type)
+{
+	return rtl_eri_read_with_oob_base_address(hw, addr, len, type, 0);
+}
+
 static int
 rtl_eri_write_with_oob_base_address(struct rtl_hw *hw, int addr,
 				    int len, u32 value, int type,
@@ -144,6 +150,13 @@ rtl_eri_write_with_oob_base_address(struct rtl_hw *hw, int addr,
 	return 0;
 }
 
+int
+rtl_eri_write(struct rtl_hw *hw, int addr, int len, u32 value, int type)
+{
+	return rtl_eri_write_with_oob_base_address(hw, addr, len, value, type,
+						   NO_BASE_ADDRESS);
+}
+
 static u32
 rtl_ocp_read_with_oob_base_address(struct rtl_hw *hw, u16 addr, u8 len,
 				   const u32 base_address)
@@ -152,17 +165,122 @@ rtl_ocp_read_with_oob_base_address(struct rtl_hw *hw, u16 addr, u8 len,
 						  base_address);
 }
 
+static u32
+rtl8168_real_ocp_read(struct rtl_hw *hw, u16 addr, u8 len)
+{
+	int i, val_shift, shift = 0;
+	u32 value1, value2, mask;
+
+	value1 = 0;
+	value2 = 0;
+
+	if (len > 4 || len <= 0)
+		return -1;
+
+	while (len > 0) {
+		val_shift = addr % 4;
+		addr = addr & ~0x3;
+
+		RTL_W32(hw, OCPAR, (0x0F << 12) | (addr & 0xFFF));
+
+		for (i = 0; i < 20; i++) {
+			rte_delay_us(100);
+			if (RTL_R32(hw, OCPAR) & OCPAR_Flag)
+				break;
+		}
+
+		if (len == 1)
+			mask = (0xFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else if (len == 2)
+			mask = (0xFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else if (len == 3)
+			mask = (0xFFFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else
+			mask = (0xFFFFFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+
+		value1 = RTL_R32(hw, OCPDR) & mask;
+		value2 |= (value1 >> val_shift * 8) << shift * 8;
+
+		if (len <= 4 - val_shift) {
+			len = 0;
+		} else {
+			len -= (4 - val_shift);
+			shift = 4 - val_shift;
+			addr += 4;
+		}
+	}
+
+	rte_delay_us(20);
+
+	return value2;
+}
+
+static int
+rtl8168_real_ocp_write(struct rtl_hw *hw, u16 addr, u8 len, u32 value)
+{
+	int i, val_shift, shift = 0;
+	u32 mask, value1 = 0;
+
+	if (len > 4 || len <= 0)
+		return -1;
+
+	while (len > 0) {
+		val_shift = addr % 4;
+		addr = addr & ~0x3;
+
+		if (len == 1)
+			mask = (0xFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else if (len == 2)
+			mask = (0xFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else if (len == 3)
+			mask = (0xFFFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+		else
+			mask = (0xFFFFFFFF << (val_shift * 8)) & 0xFFFFFFFF;
+
+		value1 = rtl_ocp_read(hw, addr, 4) & ~mask;
+		value1 |= ((value << val_shift * 8) >> shift * 8);
+
+		RTL_W32(hw, OCPDR, value1);
+		RTL_W32(hw, OCPAR, OCPAR_Flag | (0x0F << 12) | (addr & 0xFFF));
+
+		for (i = 0; i < 10; i++) {
+			rte_delay_us(100);
+
+			/* Check if the RTL8168 has completed ERI write */
+			if (!(RTL_R32(hw, OCPAR) & OCPAR_Flag))
+				break;
+		}
+
+		if (len <= 4 - val_shift) {
+			len = 0;
+		} else {
+			len -= (4 - val_shift);
+			shift = 4 - val_shift;
+			addr += 4;
+		}
+	}
+
+	rte_delay_us(20);
+
+	return 0;
+}
+
 u32
 rtl_ocp_read(struct rtl_hw *hw, u16 addr, u8 len)
 {
 	u32 value = 0;
 
-	if (!hw->AllowAccessDashOcp)
+	if (rtl_is_8125(hw) && !hw->AllowAccessDashOcp)
 		return 0xffffffff;
 
 	if (hw->HwSuppOcpChannelVer == 2)
 		value = rtl_ocp_read_with_oob_base_address(hw, addr, len,
 							   NO_BASE_ADDRESS);
+	else if (hw->HwSuppOcpChannelVer == 3)
+		value = rtl_ocp_read_with_oob_base_address(hw, addr, len,
+							   RTL8168FP_OOBMAC_BASE);
+	else
+		value = rtl8168_real_ocp_read(hw, addr, len);
 
 	return value;
 }
@@ -171,23 +289,28 @@ static u32
 rtl_ocp_write_with_oob_base_address(struct rtl_hw *hw, u16 addr, u8 len,
 				    u32 value, const u32 base_address)
 {
-	return rtl_eri_write_with_oob_base_address(hw, addr, len, value, ERIAR_OOB,
-						   base_address);
+	return rtl_eri_write_with_oob_base_address(hw, addr, len, value,
+						   ERIAR_OOB, base_address);
 }
 
 void
 rtl_ocp_write(struct rtl_hw *hw, u16 addr, u8 len, u32 value)
 {
-	if (!hw->AllowAccessDashOcp)
+	if (rtl_is_8125(hw) && !hw->AllowAccessDashOcp)
 		return;
 
 	if (hw->HwSuppOcpChannelVer == 2)
 		rtl_ocp_write_with_oob_base_address(hw, addr, len, value,
 						    NO_BASE_ADDRESS);
+	else if (hw->HwSuppOcpChannelVer == 3)
+		rtl_ocp_write_with_oob_base_address(hw, addr, len, value,
+						    RTL8168FP_OOBMAC_BASE);
+	else
+		rtl8168_real_ocp_write(hw, addr, len, value);
 }
 
 void
-rtl8125_oob_mutex_lock(struct rtl_hw *hw)
+rtl_oob_mutex_lock(struct rtl_hw *hw)
 {
 	u8 reg_16, reg_a0;
 	u16 ocp_reg_mutex_ib;
@@ -199,6 +322,13 @@ rtl8125_oob_mutex_lock(struct rtl_hw *hw)
 		return;
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
@@ -241,7 +371,7 @@ rtl8125_oob_mutex_lock(struct rtl_hw *hw)
 }
 
 void
-rtl8125_oob_mutex_unlock(struct rtl_hw *hw)
+rtl_oob_mutex_unlock(struct rtl_hw *hw)
 {
 	u16 ocp_reg_mutex_ib;
 	u16 ocp_reg_mutex_prio;
@@ -250,6 +380,13 @@ rtl8125_oob_mutex_unlock(struct rtl_hw *hw)
 		return;
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
@@ -295,34 +432,62 @@ rtl_mac_ocp_read(struct rtl_hw *hw, u16 addr)
 }
 
 u32
-rtl_csi_read(struct rtl_hw *hw, u32 addr)
+rtl_csi_other_fun_read(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr)
 {
 	u32 cmd;
 	int i;
-	u32 value = 0;
+	u32 value = 0xffffffff;
 
 	cmd = CSIAR_Read | CSIAR_ByteEn << CSIAR_ByteEn_shift |
 	      (addr & CSIAR_Addr_Mask);
 
+	if (multi_fun_sel_bit > 7)
+		goto exit;
+
+	cmd |= multi_fun_sel_bit << 16;
+
 	RTL_W32(hw, CSIAR, cmd);
 
-	for (i = 0; i < 10; i++) {
-		rte_delay_us(100);
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
 
 		/* Check if the NIC has completed CSI read */
 		if (RTL_R32(hw, CSIAR) & CSIAR_Flag) {
-			value = RTL_R32(hw, CSIDR);
+			value = (u32)RTL_R32(hw, CSIDR);
 			break;
 		}
 	}
 
-	rte_delay_us(20);
+	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
 
+exit:
 	return value;
 }
 
+u32
+rtl_csi_read(struct rtl_hw *hw, u32 addr)
+{
+	u8 multi_fun_sel_bit;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_26:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		multi_fun_sel_bit = 1;
+		break;
+	default:
+		multi_fun_sel_bit = 0;
+		break;
+	}
+
+	return rtl_csi_other_fun_read(hw, multi_fun_sel_bit, addr);
+}
+
 void
-rtl_csi_write(struct rtl_hw *hw, u32 addr, u32 value)
+rtl_csi_other_fun_write(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr,
+			u32 value)
 {
 	u32 cmd;
 	int i;
@@ -331,6 +496,11 @@ rtl_csi_write(struct rtl_hw *hw, u32 addr, u32 value)
 	cmd = CSIAR_Write | CSIAR_ByteEn << CSIAR_ByteEn_shift |
 	      (addr & CSIAR_Addr_Mask);
 
+	if (multi_fun_sel_bit > 7)
+		return;
+
+	cmd |= multi_fun_sel_bit << 16;
+
 	RTL_W32(hw, CSIAR, cmd);
 
 	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
@@ -344,14 +514,88 @@ rtl_csi_write(struct rtl_hw *hw, u32 addr, u32 value)
 	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
 }
 
+void
+rtl_csi_write(struct rtl_hw *hw, u32 addr, u32 value)
+{
+	u8 multi_fun_sel_bit;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_26:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		multi_fun_sel_bit = 1;
+		break;
+	default:
+		multi_fun_sel_bit = 0;
+		break;
+	}
+
+	rtl_csi_other_fun_write(hw, multi_fun_sel_bit, addr, value);
+}
+
+void
+rtl8168_clear_and_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 clearmask,
+				  u16 setmask)
+{
+	u16 reg_value;
+
+	reg_value = rtl_mac_ocp_read(hw, addr);
+	reg_value &= ~clearmask;
+	reg_value |= setmask;
+	rtl_mac_ocp_write(hw, addr, reg_value);
+}
+
+void
+rtl8168_clear_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
+{
+	rtl8168_clear_and_set_mcu_ocp_bit(hw, addr, mask, 0);
+}
+
+void
+rtl8168_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
+{
+	rtl8168_clear_and_set_mcu_ocp_bit(hw, addr, 0, mask);
+}
+
 static void
 rtl_enable_rxdvgate(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_3);
 		rte_delay_ms(2);
+		break;
 	}
 }
 
@@ -359,15 +603,44 @@ void
 rtl_disable_rxdvgate(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_3);
 		rte_delay_ms(2);
+		break;
 	}
 }
 
 static void
-rtl_stop_all_request(struct rtl_hw *hw)
+rtl8125_stop_all_request(struct rtl_hw *hw)
 {
 	int i;
 
@@ -392,14 +665,95 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) & (CmdTxEnb | CmdRxEnb));
 }
 
+static void
+rtl8168_stop_all_request(struct rtl_hw *hw)
+{
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rte_delay_ms(2);
+		break;
+	default:
+		rte_delay_ms(10);
+		break;
+	}
+}
+
+static void
+rtl_stop_all_request(struct rtl_hw *hw)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_stop_all_request(hw);
+	else
+		rtl8168_stop_all_request(hw);
+}
+
 static void
 rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 {
 	int i;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		for (i = 0; i < 10; i++) {
+			rte_delay_us(100);
+			if (RTL_R32(hw, TxConfig) & BIT_11)
+				break;
+		}
+
+		for (i = 0; i < 10; i++) {
+			rte_delay_us(100);
+			if ((RTL_R8(hw, MCUCmd_reg) & (Txfifo_empty | Rxfifo_empty)) ==
+			    (Txfifo_empty | Rxfifo_empty))
+				break;
+		}
+
+		rte_delay_ms(1);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		for (i = 0; i < 3000; i++) {
 			rte_delay_us(50);
 			if ((RTL_R8(hw, MCUCmd_reg) & (Txfifo_empty | Rxfifo_empty)) ==
@@ -412,8 +766,14 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	switch (hw->mcfg) {
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
-	case CFG_METHOD_53 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		for (i = 0; i < 3000; i++) {
 			rte_delay_us(50);
 			if ((RTL_R16(hw, IntrMitigate) & (BIT_0 | BIT_1 | BIT_8)) ==
@@ -473,19 +833,86 @@ rtl_disable_cfg9346_write(struct rtl_hw *hw)
 static void
 rtl_enable_force_clkreq(struct rtl_hw *hw, bool enable)
 {
-	if (enable)
-		RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) | BIT_7);
-	else
-		RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) & ~BIT_7);
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		if (enable)
+			RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) | BIT_7);
+		else
+			RTL_W8(hw, 0xF1, RTL_R8(hw, 0xF1) & ~BIT_7);
+		break;
+	}
 }
 
 static void
 rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		if (enable) {
+			RTL_W8(hw, Config2, RTL_R8(hw, Config2) | BIT_7);
+			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
+		} else {
+			RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~BIT_7);
+			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
+		}
+		rte_delay_us(10);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 	case CFG_METHOD_69:
-		rtl_enable_cfg9346_write(hw);
 		if (enable) {
 			RTL_W8(hw, Config2, RTL_R8(hw, Config2) | BIT_7);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
@@ -493,11 +920,9 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 			RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~BIT_7);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
 		}
-		rtl_disable_cfg9346_write(hw);
 		break;
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		rtl_enable_cfg9346_write(hw);
 		if (enable) {
 			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) | BIT_3);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
@@ -505,26 +930,35 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) & ~BIT_3);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
 		}
-		rtl_disable_cfg9346_write(hw);
 		break;
 	}
 }
 
 static void
-rtl_disable_l1_timeout(struct rtl_hw *hw)
+rtl8126_disable_l1_timeout(struct rtl_hw *hw)
 {
 	rtl_csi_write(hw, 0x890, rtl_csi_read(hw, 0x890) & ~BIT_0);
 }
 
 static void
-rtl_disable_eee_plus(struct rtl_hw *hw)
+rtl8125_disable_eee_plus(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xE080, rtl_mac_ocp_read(hw, 0xE080) & ~BIT_1);
 		break;
-
 	default:
 		/* Not support EEEPlus */
 		break;
@@ -535,8 +969,41 @@ static void
 rtl_hw_clear_timer_int(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		RTL_W32(hw, TimeInt0, 0x0000);
+		RTL_W32(hw, TimeInt1, 0x0000);
+		RTL_W32(hw, TimeInt2, 0x0000);
+		RTL_W32(hw, TimeInt3, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W32(hw, TIMER_INT0_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT1_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT2_8125, 0x0000);
@@ -546,7 +1013,7 @@ rtl_hw_clear_timer_int(struct rtl_hw *hw)
 }
 
 static void
-rtl_hw_clear_int_miti(struct rtl_hw *hw)
+rtl8125_hw_clear_int_miti(struct rtl_hw *hw)
 {
 	int i;
 
@@ -577,8 +1044,8 @@ rtl_hw_clear_int_miti(struct rtl_hw *hw)
 	}
 }
 
-void
-rtl_hw_config(struct rtl_hw *hw)
+static void
+rtl8125_hw_config(struct rtl_hw *hw)
 {
 	u32 mac_ocp_data;
 
@@ -590,18 +1057,24 @@ rtl_hw_config(struct rtl_hw *hw)
 	rtl_enable_cfg9346_write(hw);
 
 	/* Disable aspm clkreq internal */
-	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		rtl_enable_force_clkreq(hw, 0);
-		rtl_enable_aspm_clkreq_lock(hw, 0);
-		break;
-	}
+	rtl_enable_force_clkreq(hw, 0);
+	rtl_enable_aspm_clkreq_lock(hw, 0);
 
 	/* Disable magic packet */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		mac_ocp_data = 0;
 		rtl_mac_ocp_write(hw, 0xC0B6, mac_ocp_data);
 		break;
@@ -616,21 +1089,38 @@ rtl_hw_config(struct rtl_hw *hw)
 
 	/* TCAM */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		RTL_W16(hw, 0x382, 0x221B);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		rtl_disable_l1_timeout(hw);
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl8126_disable_l1_timeout(hw);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		/* RSS_control_0 */
 		RTL_W32(hw, RSS_CTRL_8125, 0x00);
 
@@ -644,33 +1134,17 @@ rtl_hw_config(struct rtl_hw *hw)
 		rtl_mac_ocp_write(hw, 0xC140, 0xFFFF);
 		rtl_mac_ocp_write(hw, 0xC142, 0xFFFF);
 
-		/* New TX desc format */
+		/* Disable new TX desc format */
 		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEB58);
 		if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
 			mac_ocp_data &= ~(BIT_0 | BIT_1);
-		mac_ocp_data |= BIT_0;
+		else
+			mac_ocp_data &= ~BIT_0;
 		rtl_mac_ocp_write(hw, 0xEB58, mac_ocp_data);
 
 		if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71)
 			RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~BIT_1);
 
-		/*
-		 * MTPS
-		 * 15-8 maximum tx use credit number
-		 * 7-0 reserved for pcie product line
-		 */
-		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE614);
-		mac_ocp_data &= ~(BIT_10 | BIT_9 | BIT_8);
-		if (hw->mcfg == CFG_METHOD_50 || hw->mcfg == CFG_METHOD_51 ||
-		    hw->mcfg == CFG_METHOD_53)
-			mac_ocp_data |= ((2 & 0x07) << 8);
-		else if (hw->mcfg == CFG_METHOD_69 || hw->mcfg == CFG_METHOD_70 ||
-			 hw->mcfg == CFG_METHOD_71)
-			mac_ocp_data |= ((4 & 0x07) << 8);
-		else
-			mac_ocp_data |= ((3 & 0x07) << 8);
-		rtl_mac_ocp_write(hw, 0xE614, mac_ocp_data);
-
 		mac_ocp_data = rtl_mac_ocp_read(hw, 0xE63E);
 		mac_ocp_data &= ~(BIT_5 | BIT_4);
 		if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
@@ -724,7 +1198,7 @@ rtl_hw_config(struct rtl_hw *hw)
 		case CFG_METHOD_52:
 		case CFG_METHOD_54:
 		case CFG_METHOD_55:
-			rtl8125_oob_mutex_lock(hw);
+			rtl_oob_mutex_lock(hw);
 			break;
 		}
 
@@ -740,7 +1214,7 @@ rtl_hw_config(struct rtl_hw *hw)
 		case CFG_METHOD_52:
 		case CFG_METHOD_54:
 		case CFG_METHOD_55:
-			rtl8125_oob_mutex_unlock(hw);
+			rtl_oob_mutex_unlock(hw);
 			break;
 		}
 
@@ -766,7 +1240,7 @@ rtl_hw_config(struct rtl_hw *hw)
 		    hw->mcfg == CFG_METHOD_52)
 			RTL_W8(hw, MCUCmd_reg, RTL_R8(hw, MCUCmd_reg) | BIT_0);
 
-		rtl_disable_eee_plus(hw);
+		rtl8125_disable_eee_plus(hw);
 
 		mac_ocp_data = rtl_mac_ocp_read(hw, 0xEA1C);
 		mac_ocp_data &= ~BIT_2;
@@ -782,7 +1256,10 @@ rtl_hw_config(struct rtl_hw *hw)
 		RTL_W16(hw, 0x1880, RTL_R16(hw, 0x1880) & ~(BIT_4 | BIT_5));
 
 		switch (hw->mcfg) {
-		case CFG_METHOD_54 ... CFG_METHOD_57:
+		case CFG_METHOD_54:
+		case CFG_METHOD_55:
+		case CFG_METHOD_56:
+		case CFG_METHOD_57:
 			RTL_W8(hw, 0xd8, RTL_R8(hw, 0xd8) & ~EnableRxDescV4_0);
 			break;
 		}
@@ -791,24 +1268,223 @@ rtl_hw_config(struct rtl_hw *hw)
 	/* Other hw parameters */
 	rtl_hw_clear_timer_int(hw);
 
-	rtl_hw_clear_int_miti(hw);
+	rtl8125_hw_clear_int_miti(hw);
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_mac_ocp_write(hw, 0xE098, 0xC302);
+		break;
+	}
+
+	rtl_disable_cfg9346_write(hw);
+
+	rte_delay_us(10);
+}
+
+static void
+rtl8168_hw_config(struct rtl_hw *hw)
+{
+	u32 csi_tmp;
+	int timeout;
+
+	rtl_nic_reset(hw);
+
+	rtl_enable_cfg9346_write(hw);
+
+	/* Disable aspm clkreq internal */
+	rtl_enable_force_clkreq(hw, 0);
+	rtl_enable_aspm_clkreq_lock(hw, 0);
+
+	/* Clear io_rdy_l23 */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		RTL_W8(hw, Config3, RTL_R8(hw, Config3) & ~BIT_1);
+		break;
+	}
+
+	/* Keep magic packet only */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_eri_read(hw, 0xDE, 1, ERIAR_ExGMAC);
+		csi_tmp &= BIT_0;
+		rtl_eri_write(hw, 0xDE, 1, csi_tmp, ERIAR_ExGMAC);
+		break;
+	}
+
+	/* Set TxConfig to default */
+	RTL_W32(hw, TxConfig, (TX_DMA_BURST_unlimited << TxDMAShift) |
+		(InterFrameGap << TxInterFrameGapShift));
+
+	hw->hw_ops.hw_config(hw);
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		rtl_eri_write(hw, 0x2F8, 2, 0x1D8F, ERIAR_ExGMAC);
+		break;
+	}
+
+	rtl_hw_clear_timer_int(hw);
+
+	/* Clkreq exit masks */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_eri_read(hw, 0xD4, 4, ERIAR_ExGMAC);
+		csi_tmp |= (BIT_7 | BIT_8 | BIT_9 | BIT_10 | BIT_11 | BIT_12);
+		rtl_eri_write(hw, 0xD4, 4, csi_tmp, ERIAR_ExGMAC);
+		break;
+	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_25:
+		rtl_mac_ocp_write(hw, 0xD3C0, 0x0B00);
+		rtl_mac_ocp_write(hw, 0xD3C2, 0x0000);
+		break;
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mac_ocp_write(hw, 0xE098, 0x0AA2);
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
 		rtl_mac_ocp_write(hw, 0xE098, 0xC302);
 		break;
 	}
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+		for (timeout = 0; timeout < 10; timeout++) {
+			if ((rtl_eri_read(hw, 0x1AE, 2, ERIAR_ExGMAC) & BIT_13) == 0)
+				break;
+			rte_delay_ms(1);
+		}
+		break;
+	}
+
 	rtl_disable_cfg9346_write(hw);
 
 	rte_delay_us(10);
 }
 
+void
+rtl_hw_config(struct rtl_hw *hw)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_hw_config(hw);
+	else
+		rtl8168_hw_config(hw);
+}
+
 int
 rtl_set_hw_ops(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
+	/* 8168G */
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	/* 8168GU */
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+		hw->hw_ops = rtl8168g_ops;
+		return 0;
+	/* 8168EP */
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		hw->hw_ops = rtl8168ep_ops;
+		return 0;
+	/* 8168H */
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		hw->hw_ops = rtl8168h_ops;
+		return 0;
+	/* 8168FP */
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		hw->hw_ops = rtl8168fp_ops;
+		return 0;
+	/* 8168M */
+	case CFG_METHOD_37:
+		hw->hw_ops = rtl8168m_ops;
+		return 0;
 	/* 8125A */
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
@@ -835,7 +1511,9 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 		hw->hw_ops = rtl8125d_ops;
 		return 0;
 	/* 8126A */
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->hw_ops = rtl8126a_ops;
 		return 0;
 	default:
@@ -848,23 +1526,80 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 {
 	u16 reg_addr;
 
+	rtl_enable_cfg9346_write(hw);
 	rtl_enable_aspm_clkreq_lock(hw, 0);
+	rtl_disable_cfg9346_write(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xFC48, 0x0000);
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		for (reg_addr = 0xFC28; reg_addr < 0xFC48; reg_addr += 2)
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		for (reg_addr = 0xFC28; reg_addr < 0xFC38; reg_addr += 2)
 			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
 
 		rte_delay_ms(3);
+		rtl_mac_ocp_write(hw, 0xFC26, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		for (reg_addr = 0xFC28; reg_addr < 0xFC48; reg_addr += 2)
+			rtl_mac_ocp_write(hw, reg_addr, 0x0000);
 
+		rte_delay_ms(3);
 		rtl_mac_ocp_write(hw, 0xFC26, 0x0000);
 		break;
 	}
@@ -973,7 +1708,7 @@ rtl_set_link_option(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex,
 	u64 adv;
 
 	if (!rtl_is_speed_mode_valid(speed))
-		speed = SPEED_5000;
+		speed = SPEED_1000;
 
 	if (!rtl_is_duplex_mode_valid(duplex))
 		duplex = DUPLEX_FULL;
@@ -1009,12 +1744,46 @@ static void
 rtl_init_software_variable(struct rtl_hw *hw)
 {
 	int tx_no_close_enable = 1;
-	unsigned int speed_mode = SPEED_5000;
+	unsigned int speed_mode;
 	unsigned int duplex_mode = DUPLEX_FULL;
 	unsigned int autoneg_mode = AUTONEG_ENABLE;
-	u8 tmp;
+	u32 tmp;
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+		speed_mode = SPEED_2500;
+		break;
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		speed_mode = SPEED_5000;
+		break;
+	default:
+		speed_mode = SPEED_1000;
+		break;
+	}
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		hw->HwSuppDashVer = 2;
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		hw->HwSuppDashVer = 3;
+		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 		tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
@@ -1031,6 +1800,41 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		tmp = rtl_mac_ocp_read(hw, 0xDC00);
+		hw->HwPkgDet = (tmp >> 3) & 0x0F;
+		break;
+	}
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		if (hw->HwPkgDet == 0x06) {
+			tmp = rtl_eri_read(hw, 0xE6, 1, ERIAR_ExGMAC);
+			if (tmp == 0x02)
+				hw->HwSuppSerDesPhyVer = 1;
+			else if (tmp == 0x00)
+				hw->HwSuppSerDesPhyVer = 2;
+		}
+		break;
+	}
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		hw->HwSuppOcpChannelVer = 2;
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		hw->HwSuppOcpChannelVer = 3;
+		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 		if (HW_DASH_SUPPORT_DASH(hw))
@@ -1040,9 +1844,13 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 		hw->HwSuppOcpChannelVer = 2;
 		break;
+	default:
+		hw->HwSuppOcpChannelVer = 0;
+		break;
 	}
 
-	hw->AllowAccessDashOcp = rtl_is_allow_access_dash_ocp(hw);
+	if (rtl_is_8125(hw))
+		hw->AllowAccessDashOcp = rtl_is_allow_access_dash_ocp(hw);
 
 	if (HW_DASH_SUPPORT_DASH(hw) && rtl_check_dash(hw))
 		hw->DASH = 1;
@@ -1053,6 +1861,32 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		hw->cmac_ioaddr = hw->mmio_addr;
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+		hw->chipset_name = RTL8168G;
+		break;
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		hw->chipset_name = RTL8168EP;
+		break;
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		hw->chipset_name = RTL8168H;
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		hw->chipset_name = RTL8168FP;
+		break;
+	case CFG_METHOD_37:
+		hw->chipset_name = RTL8168M;
+		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 		hw->chipset_name = RTL8125A;
@@ -1073,7 +1907,9 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_57:
 		hw->chipset_name = RTL8125D;
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->chipset_name = RTL8126A;
 		break;
 	default:
@@ -1082,23 +1918,91 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppNowIsOobVer = 1;
+		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		hw->HwSuppCheckPhyDisableModeVer = 2;
+		break;
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppCheckPhyDisableModeVer = 3;
+		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_51:
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_2500;
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppMaxPhyLinkSpeed = SPEED_5000;
 		break;
 	default:
@@ -1107,10 +2011,18 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_53:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
 		hw->HwSuppTxNoCloseVer = 3;
 		break;
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
 	case CFG_METHOD_69:
@@ -1158,6 +2070,41 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_21;
+		break;
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_23;
+		break;
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_24;
+		break;
+	case CFG_METHOD_26:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_26;
+		break;
+	case CFG_METHOD_28:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_28;
+		break;
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_37:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_29;
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_31;
+		break;
+	case CFG_METHOD_35:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_35;
+		break;
+	case CFG_METHOD_36:
+		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_36;
+		break;
 	case CFG_METHOD_48:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_48;
 		break;
@@ -1201,15 +2148,37 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->HwSuppMacMcuVer = 2;
 		break;
 	}
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->MacMcuPageSize = RTL_MAC_MCU_PAGE_SIZE;
 		break;
 	}
@@ -1235,7 +2204,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	case CFG_METHOD_69:
 		hw->HwSuppIntMitiVer = 4;
 		break;
-	case CFG_METHOD_54 ... CFG_METHOD_57:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		hw->HwSuppIntMitiVer = 6;
 		break;
 	case CFG_METHOD_70:
@@ -1247,8 +2219,19 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		hw->mcu_pme_setting = rtl_mac_ocp_read(hw, 0xE00A);
 		break;
 	}
@@ -1259,13 +2242,69 @@ rtl_init_software_variable(struct rtl_hw *hw)
 static void
 rtl_exit_realwow(struct rtl_hw *hw)
 {
+	u32 csi_tmp;
+
 	/* Disable realwow function */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+		RTL_W32(hw, MACOCP, 0x605E0000);
+		RTL_W32(hw, MACOCP, (0xE05E << 16) |
+				    (RTL_R32(hw, MACOCP) & 0xFFFE));
+		RTL_W32(hw, MACOCP, 0xE9720000);
+		RTL_W32(hw, MACOCP, 0xF2140010);
+		break;
+	case CFG_METHOD_26:
+		RTL_W32(hw, MACOCP, 0xE05E00FF);
+		RTL_W32(hw, MACOCP, 0xE9720000);
+		rtl_mac_ocp_write(hw, 0xE428, 0x0010);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mac_ocp_write(hw, 0xC0BC, 0x00FF);
 		break;
 	}
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+		rtl_eri_write(hw, 0x174, 2, 0x0000, ERIAR_ExGMAC);
+		rtl_mac_ocp_write(hw, 0xE428, 0x0010);
+		break;
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		rtl_eri_write(hw, 0x174, 2, 0x00FF, ERIAR_ExGMAC);
+		rtl_mac_ocp_write(hw, 0xE428, 0x0010);
+		break;
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_eri_read(hw, 0x174, 2, ERIAR_ExGMAC);
+		csi_tmp &= ~BIT_8;
+		csi_tmp |= BIT_15;
+		rtl_eri_write(hw, 0x174, 2, csi_tmp, ERIAR_ExGMAC);
+		rtl_mac_ocp_write(hw, 0xE428, 0x0010);
+		break;
+	}
 }
 
 static void
@@ -1287,6 +2326,20 @@ rtl_wait_ll_share_fifo_ready(struct rtl_hw *hw)
 	}
 }
 
+static void
+rtl8168_switch_to_sgmii_mode(struct rtl_hw *hw)
+{
+	if (!HW_SUPP_SERDES_PHY(hw))
+		return;
+
+	switch (hw->HwSuppSerDesPhyVer) {
+	case 1:
+		rtl_mac_ocp_write(hw, 0xEB00, 0x2);
+		rtl8168_set_mcu_ocp_bit(hw, 0xEB16, BIT_1);
+		break;
+	}
+}
+
 static void
 rtl_exit_oob(struct rtl_hw *hw)
 {
@@ -1294,9 +2347,14 @@ rtl_exit_oob(struct rtl_hw *hw)
 
 	rtl_disable_rx_packet_filter(hw);
 
+	if (HW_SUPP_SERDES_PHY(hw)) {
+		if (hw->HwSuppSerDesPhyVer == 1)
+			rtl8168_switch_to_sgmii_mode(hw);
+	}
+
 	if (HW_DASH_SUPPORT_DASH(hw)) {
-		rtl8125_driver_start(hw);
-		rtl8125_dash2_disable_txrx(hw);
+		rtl_driver_start(hw);
+		rtl_dash2_disable_txrx(hw);
 	}
 
 	rtl_exit_realwow(hw);
@@ -1304,8 +2362,47 @@ rtl_exit_oob(struct rtl_hw *hw)
 	rtl_nic_reset(hw);
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_disable_now_is_oob(hw);
+
+		data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
+		rtl_mac_ocp_write(hw, 0xE8DE, data16);
+		rtl_wait_ll_share_fifo_ready(hw);
+
+		data16 = rtl_mac_ocp_read(hw, 0xE8DE) | BIT_15;
+		rtl_mac_ocp_write(hw, 0xE8DE, data16);
+
+		rtl_wait_ll_share_fifo_ready(hw);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_disable_now_is_oob(hw);
 
 		data16 = rtl_mac_ocp_read(hw, 0xE8DE) & ~BIT_14;
@@ -1327,20 +2424,66 @@ static void
 rtl_disable_ups(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		rtl_mac_ocp_write(hw, 0xD40A, rtl_mac_ocp_read(hw, 0xD40A) & ~BIT_4);
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		rtl_mac_ocp_write(hw, 0xD400,
+				  rtl_mac_ocp_read(hw, 0xD400) & ~BIT_0);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_mac_ocp_write(hw, 0xD40A,
+				  rtl_mac_ocp_read(hw, 0xD40A) & ~BIT_4);
 		break;
 	}
 }
 
 static void
-rtl8125_disable_ocp_phy_power_saving(struct rtl_hw *hw)
+rtl_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 {
 	u16 val;
 
-	if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
-	    hw->mcfg == CFG_METHOD_52) {
+	switch (hw->mcfg) {
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		val = rtl_mdio_real_read_phy_ocp(hw, 0x0C41, 0x13);
+		if (val != 0x0500) {
+			rtl_set_phy_mcu_patch_request(hw);
+			rtl_mdio_real_write_phy_ocp(hw, 0x0C41, 0x13, 0x0000);
+			rtl_mdio_real_write_phy_ocp(hw, 0x0C41, 0x13, 0x0500);
+			rtl_clear_phy_mcu_patch_request(hw);
+		}
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_52:
 		val = rtl_mdio_direct_read_phy_ocp(hw, 0xC416);
 		if (val != 0x0050) {
 			rtl_set_phy_mcu_patch_request(hw);
@@ -1348,26 +2491,108 @@ rtl8125_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 			rtl_mdio_direct_write_phy_ocp(hw, 0xC416, 0x0500);
 			rtl_clear_phy_mcu_patch_request(hw);
 		}
+		break;
 	}
 }
 
 static void
-rtl_hw_init(struct rtl_hw *hw)
+rtl8168_disable_dma_agg(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		rtl_enable_aspm_clkreq_lock(hw, 0);
-		rtl_enable_force_clkreq(hw, 0);
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mac_ocp_write(hw, 0xE63E, rtl_mac_ocp_read(hw, 0xE63E) &
+					      ~(BIT_3 | BIT_2 | BIT_1));
+		rtl_mac_ocp_write(hw, 0xE63E,
+				  rtl_mac_ocp_read(hw, 0xE63E) | (BIT_0));
+		rtl_mac_ocp_write(hw, 0xE63E,
+				  rtl_mac_ocp_read(hw, 0xE63E) & ~(BIT_0));
+		rtl_mac_ocp_write(hw, 0xC094, 0x0);
+		rtl_mac_ocp_write(hw, 0xC09E, 0x0);
 		break;
 	}
+}
+
+static void
+rtl_hw_init(struct rtl_hw *hw)
+{
+	u32 csi_tmp;
+
+	/* Disable aspm clkreq internal */
+	rtl_enable_force_clkreq(hw, 0);
+	rtl_enable_cfg9346_write(hw);
+	rtl_enable_aspm_clkreq_lock(hw, 0);
+	rtl_disable_cfg9346_write(hw);
 
 	rtl_disable_ups(hw);
 
+	/* Disable DMA aggregation */
+	rtl8168_disable_dma_agg(hw);
+
 	hw->hw_ops.hw_mac_mcu_config(hw);
 
 	/* Disable ocp phy power saving */
-	rtl8125_disable_ocp_phy_power_saving(hw);
+	rtl_disable_ocp_phy_power_saving(hw);
+
+	/* Set PCIE uncorrectable error status mask pcie 0x108 */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_csi_read(hw, 0x108);
+		csi_tmp |= BIT_20;
+		rtl_csi_write(hw, 0x108, csi_tmp);
+		break;
+	}
+
+	/* MCU PME setting */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
+		csi_tmp |= (BIT_2 | BIT_3 | BIT_4 | BIT_5 | BIT_6 | BIT_7);
+		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
+		break;
+	case CFG_METHOD_25:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
+		csi_tmp |= (BIT_3 | BIT_6);
+		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
+		break;
+	}
 }
 
 void
@@ -1393,33 +2618,200 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	ic_version_id = val32 & 0x00700000;
 
 	switch (reg) {
+	case 0x30000000:
+		hw->mcfg = CFG_METHOD_1;
+		break;
+	case 0x38000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_2;
+		} else if (ic_version_id == 0x00500000) {
+			hw->mcfg = CFG_METHOD_3;
+		} else {
+			hw->mcfg = CFG_METHOD_3;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x3C000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_4;
+		} else if (ic_version_id == 0x00200000) {
+			hw->mcfg = CFG_METHOD_5;
+		} else if (ic_version_id == 0x00400000) {
+			hw->mcfg = CFG_METHOD_6;
+		} else {
+			hw->mcfg = CFG_METHOD_6;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x3C800000:
+		if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_7;
+		} else if (ic_version_id == 0x00300000) {
+			hw->mcfg = CFG_METHOD_8;
+		} else {
+			hw->mcfg = CFG_METHOD_8;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x28000000:
+		if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_9;
+		} else if (ic_version_id == 0x00300000) {
+			hw->mcfg = CFG_METHOD_10;
+		} else {
+			hw->mcfg = CFG_METHOD_10;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x28800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_11;
+		} else if (ic_version_id == 0x00200000) {
+			hw->mcfg = CFG_METHOD_12;
+			RTL_W32(hw, 0xD0, RTL_R32(hw, 0xD0) | 0x00020000);
+		} else if (ic_version_id == 0x00300000) {
+			hw->mcfg = CFG_METHOD_13;
+		} else {
+			hw->mcfg = CFG_METHOD_13;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x2C000000:
+		if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_14;
+		} else if (ic_version_id == 0x00200000) {
+			hw->mcfg = CFG_METHOD_15;
+		} else {
+			hw->mcfg = CFG_METHOD_15;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x2C800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_16;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_17;
+		} else {
+			hw->mcfg = CFG_METHOD_17;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x48000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_18;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_19;
+		} else {
+			hw->mcfg = CFG_METHOD_19;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x48800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_20;
+		} else {
+			hw->mcfg = CFG_METHOD_20;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x4C000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_21;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_22;
+		} else {
+			hw->mcfg = CFG_METHOD_22;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x50000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_23;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_27;
+		} else if (ic_version_id == 0x00200000) {
+			hw->mcfg = CFG_METHOD_28;
+		} else {
+			hw->mcfg = CFG_METHOD_28;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x50800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_24;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_25;
+		} else {
+			hw->mcfg = CFG_METHOD_25;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x5C800000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_26;
+		} else {
+			hw->mcfg = CFG_METHOD_26;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x54000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_29;
+		} else if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_30;
+		} else {
+			hw->mcfg = CFG_METHOD_30;
+			hw->HwIcVerUnknown = TRUE;
+		}
+
+		if (hw->mcfg == CFG_METHOD_30) {
+			if ((rtl_mac_ocp_read(hw, 0xD006) & 0xFF00) == 0x0100)
+				hw->mcfg = CFG_METHOD_35;
+			else if ((rtl_mac_ocp_read(hw, 0xD006) & 0xFF00) == 0x0300)
+				hw->mcfg = CFG_METHOD_36;
+		}
+		break;
+	case 0x6C000000:
+		if (ic_version_id == 0x00000000) {
+			hw->mcfg = CFG_METHOD_37;
+		} else {
+			hw->mcfg = CFG_METHOD_37;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
+	case 0x54800000:
+		if (ic_version_id == 0x00100000) {
+			hw->mcfg = CFG_METHOD_31;
+		} else if (ic_version_id == 0x00200000) {
+			hw->mcfg = CFG_METHOD_32;
+		} else if (ic_version_id == 0x00300000) {
+			hw->mcfg = CFG_METHOD_33;
+		} else if (ic_version_id == 0x00400000) {
+			hw->mcfg = CFG_METHOD_34;
+		} else {
+			hw->mcfg = CFG_METHOD_34;
+			hw->HwIcVerUnknown = TRUE;
+		}
+		break;
 	case 0x60800000:
 		if (ic_version_id == 0x00000000) {
 			hw->mcfg = CFG_METHOD_48;
-
 		} else if (ic_version_id == 0x100000) {
 			hw->mcfg = CFG_METHOD_49;
-
 		} else {
 			hw->mcfg = CFG_METHOD_49;
 			hw->HwIcVerUnknown = TRUE;
 		}
-
-		hw->efuse_ver = EFUSE_SUPPORT_V4;
 		break;
 	case 0x64000000:
 		if (ic_version_id == 0x00000000) {
 			hw->mcfg = CFG_METHOD_50;
-
 		} else if (ic_version_id == 0x100000) {
 			hw->mcfg = CFG_METHOD_51;
-
 		} else {
 			hw->mcfg = CFG_METHOD_51;
 			hw->HwIcVerUnknown = TRUE;
 		}
-
-		hw->efuse_ver = EFUSE_SUPPORT_V4;
 		break;
 	case 0x68000000:
 		if (ic_version_id == 0x00000000) {
@@ -1430,8 +2822,6 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_55;
 			hw->HwIcVerUnknown = TRUE;
 		}
-
-		hw->efuse_ver = EFUSE_SUPPORT_V4;
 		break;
 	case 0x68800000:
 		if (ic_version_id == 0x00000000) {
@@ -1442,8 +2832,6 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_57;
 			hw->HwIcVerUnknown = TRUE;
 		}
-
-		hw->efuse_ver = EFUSE_SUPPORT_V4;
 		break;
 	case 0x64800000:
 		if (ic_version_id == 0x00000000) {
@@ -1456,14 +2844,11 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_71;
 			hw->HwIcVerUnknown = TRUE;
 		}
-
-		hw->efuse_ver = EFUSE_SUPPORT_V4;
 		break;
 	default:
 		PMD_INIT_LOG(NOTICE, "unknown chip version (%x)", reg);
 		hw->mcfg = CFG_METHOD_DEFAULT;
 		hw->HwIcVerUnknown = TRUE;
-		hw->efuse_ver = EFUSE_NOT_SUPPORT;
 		break;
 	}
 
@@ -1478,11 +2863,42 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 int
 rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea)
 {
-	u8 mac_addr[MAC_ADDR_LEN] = {0};
+	u8 mac_addr[RTE_ETHER_ADDR_LEN] = {0};
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		*(u32 *)&mac_addr[0] = rtl_eri_read(hw, 0xE0, 4, ERIAR_ExGMAC);
+		*(u16 *)&mac_addr[4] = rtl_eri_read(hw, 0xE4, 2, ERIAR_ExGMAC);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		*(u32 *)&mac_addr[0] = RTL_R32(hw, BACKUP_ADDR0_8125);
 		*(u16 *)&mac_addr[4] = RTL_R16(hw, BACKUP_ADDR1_8125);
 		break;
@@ -1495,6 +2911,7 @@ rtl_get_mac_address(struct rtl_hw *hw, struct rte_ether_addr *ea)
 	return 0;
 }
 
+/* Puts an ethernet address into a receive address register. */
 void
 rtl_rar_set(struct rtl_hw *hw, uint8_t *addr)
 {
@@ -1593,3 +3010,9 @@ rtl_tally_free(struct rte_eth_dev *dev)
 {
 	rte_eth_dma_zone_free(dev, "tally_counters", 0);
 }
+
+bool
+rtl_is_8125(struct rtl_hw *hw)
+{
+	return hw->mcfg >= CFG_METHOD_48;
+}
diff --git a/drivers/net/r8169/r8169_hw.h b/drivers/net/r8169/r8169_hw.h
index e7c4bf1abc..7cc4ee527f 100644
--- a/drivers/net/r8169/r8169_hw.h
+++ b/drivers/net/r8169/r8169_hw.h
@@ -30,8 +30,8 @@ void rtl_nic_reset(struct rtl_hw *hw);
 void rtl_enable_cfg9346_write(struct rtl_hw *hw);
 void rtl_disable_cfg9346_write(struct rtl_hw *hw);
 
-void rtl8125_oob_mutex_lock(struct rtl_hw *hw);
-void rtl8125_oob_mutex_unlock(struct rtl_hw *hw);
+void rtl_oob_mutex_lock(struct rtl_hw *hw);
+void rtl_oob_mutex_unlock(struct rtl_hw *hw);
 
 void rtl_disable_rxdvgate(struct rtl_hw *hw);
 
@@ -60,6 +60,24 @@ void rtl_clear_tally_stats(struct rtl_hw *hw);
 int rtl_tally_init(struct rte_eth_dev *dev);
 void rtl_tally_free(struct rte_eth_dev *dev);
 
+bool rtl_is_8125(struct rtl_hw *hw);
+
+u32 rtl_eri_read(struct rtl_hw *hw, int addr, int len, int type);
+int rtl_eri_write(struct rtl_hw *hw, int addr, int len, u32 value, int type);
+
+u32 rtl_csi_other_fun_read(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr);
+void rtl_csi_other_fun_write(struct rtl_hw *hw, u8 multi_fun_sel_bit, u32 addr,
+			     u32 value);
+void rtl8168_clear_and_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr,
+				       u16 clearmask, u16 setmask);
+void rtl8168_clear_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
+void rtl8168_set_mcu_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
+
+extern const struct rtl_hw_ops rtl8168g_ops;
+extern const struct rtl_hw_ops rtl8168h_ops;
+extern const struct rtl_hw_ops rtl8168ep_ops;
+extern const struct rtl_hw_ops rtl8168fp_ops;
+extern const struct rtl_hw_ops rtl8168m_ops;
 extern const struct rtl_hw_ops rtl8125a_ops;
 extern const struct rtl_hw_ops rtl8125b_ops;
 extern const struct rtl_hw_ops rtl8125bp_ops;
@@ -67,7 +85,8 @@ extern const struct rtl_hw_ops rtl8125d_ops;
 extern const struct rtl_hw_ops rtl8126a_ops;
 extern const struct rtl_hw_ops rtl8168kb_ops;
 
-#define NO_BASE_ADDRESS 0x00000000
+#define NO_BASE_ADDRESS       0x00000000
+#define RTL8168FP_OOBMAC_BASE 0xBAF70000
 
 /* Channel wait count */
 #define RTL_CHANNEL_WAIT_COUNT      20000
@@ -80,15 +99,24 @@ extern const struct rtl_hw_ops rtl8168kb_ops;
 #define HW_HAS_WRITE_PHY_MCU_RAM_CODE(_M) ((_M)->HwHasWrRamCodeToMicroP ? 1 : 0)
 
 /* Tx NO CLOSE */
-#define MAX_TX_NO_CLOSE_DESC_PTR_V2            0x10000
-#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V2       0xFFFF
-#define MAX_TX_NO_CLOSE_DESC_PTR_V3            0x100000000
-#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V3       0xFFFFFFFF
-#define MAX_TX_NO_CLOSE_DESC_PTR_V4            0x80000000
-#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V4       0x7FFFFFFF
-#define TX_NO_CLOSE_SW_PTR_MASK_V2             0x1FFFF
+#define MAX_TX_NO_CLOSE_DESC_PTR_V2       0x10000
+#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V2  0xFFFF
+#define MAX_TX_NO_CLOSE_DESC_PTR_V3       0x100000000
+#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V3  0xFFFFFFFF
+#define MAX_TX_NO_CLOSE_DESC_PTR_V4       0x80000000
+#define MAX_TX_NO_CLOSE_DESC_PTR_MASK_V4  0x7FFFFFFF
+#define TX_NO_CLOSE_SW_PTR_MASK_V2        0x1FFFF
 
 /* Ram code version */
+#define NIC_RAMCODE_VERSION_CFG_METHOD_21  (0x0042)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_24  (0x0001)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_23  (0x0015)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_26  (0x0012)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_28  (0x0019)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_29  (0x0083)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_31  (0x0003)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_35  (0x0027)
+#define NIC_RAMCODE_VERSION_CFG_METHOD_36  (0x0000)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_48  (0x0b11)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_49  (0x0b33)
 #define NIC_RAMCODE_VERSION_CFG_METHOD_50  (0x0b17)
@@ -104,12 +132,4 @@ extern const struct rtl_hw_ops rtl8168kb_ops;
 #define RTL_MAC_MCU_PAGE_SIZE 256
 #define RTL_DEFAULT_MTU       1500
 
-enum effuse {
-	EFUSE_NOT_SUPPORT = 0,
-	EFUSE_SUPPORT_V1,
-	EFUSE_SUPPORT_V2,
-	EFUSE_SUPPORT_V3,
-	EFUSE_SUPPORT_V4,
-};
-
 #endif /* R8169_HW_H */
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index cc8efe80f2..ce16ab3242 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -13,6 +13,7 @@
 #include "r8169_hw.h"
 #include "r8169_phy.h"
 #include "r8169_logs.h"
+#include "r8169_dash.h"
 
 static void
 rtl_clear_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 clearmask,
@@ -68,7 +69,7 @@ rtl_map_phy_ocp_addr(u16 PageNum, u8 RegNum)
 }
 
 static u32
-rtl_mdio_real_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr)
+rtl_mdio_real_direct_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr)
 {
 	u32 data32;
 	int i, value = 0;
@@ -77,8 +78,8 @@ rtl_mdio_real_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr)
 	data32 <<= OCPR_Addr_Reg_shift;
 
 	RTL_W32(hw, PHYOCP, data32);
-	for (i = 0; i < 100; i++) {
-		rte_delay_us(1);
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
 
 		if (RTL_R32(hw, PHYOCP) & OCPR_Flag)
 			break;
@@ -91,27 +92,33 @@ rtl_mdio_real_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr)
 u32
 rtl_mdio_direct_read_phy_ocp(struct rtl_hw *hw, u32 RegAddr)
 {
-	return rtl_mdio_real_read_phy_ocp(hw, RegAddr);
+	return rtl_mdio_real_direct_read_phy_ocp(hw, RegAddr);
 }
 
-static u32
-rtl_mdio_read_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr)
+u32
+rtl_mdio_real_read_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr)
 {
 	u16 ocp_addr;
 
 	ocp_addr = rtl_map_phy_ocp_addr(PageNum, RegAddr);
 
-	return rtl_mdio_direct_read_phy_ocp(hw, ocp_addr);
+	return rtl_mdio_real_direct_read_phy_ocp(hw, ocp_addr);
 }
 
 static u32
 rtl_mdio_real_read(struct rtl_hw *hw, u32 RegAddr)
 {
-	return rtl_mdio_read_phy_ocp(hw, hw->cur_page, RegAddr);
+	return rtl_mdio_real_read_phy_ocp(hw, hw->cur_page, RegAddr);
+}
+
+u32
+rtl_mdio_read(struct rtl_hw *hw, u32 RegAddr)
+{
+	return rtl_mdio_real_read(hw, RegAddr);
 }
 
 static void
-rtl_mdio_real_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value)
+rtl_mdio_real_direct_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value)
 {
 	u32 data32;
 	int i;
@@ -121,8 +128,8 @@ rtl_mdio_real_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value)
 	data32 |= OCPR_Write | value;
 
 	RTL_W32(hw, PHYOCP, data32);
-	for (i = 0; i < 100; i++) {
-		rte_delay_us(1);
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
 
 		if (!(RTL_R32(hw, PHYOCP) & OCPR_Flag))
 			break;
@@ -132,11 +139,11 @@ rtl_mdio_real_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value)
 void
 rtl_mdio_direct_write_phy_ocp(struct rtl_hw *hw, u32 RegAddr, u32 value)
 {
-	rtl_mdio_real_write_phy_ocp(hw, RegAddr, value);
+	rtl_mdio_real_direct_write_phy_ocp(hw, RegAddr, value);
 }
 
-static void
-rtl_mdio_write_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr, u32 value)
+void
+rtl_mdio_real_write_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr, u32 value)
 {
 	u16 ocp_addr;
 
@@ -148,15 +155,11 @@ rtl_mdio_write_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr, u32 value)
 static void
 rtl_mdio_real_write(struct rtl_hw *hw, u32 RegAddr, u32 value)
 {
-	if (RegAddr == 0x1F)
+	if (RegAddr == 0x1F) {
 		hw->cur_page = value;
-	rtl_mdio_write_phy_ocp(hw, hw->cur_page, RegAddr, value);
-}
-
-u32
-rtl_mdio_read(struct rtl_hw *hw, u32 RegAddr)
-{
-	return rtl_mdio_real_read(hw, RegAddr);
+		return;
+	}
+	rtl_mdio_real_write_phy_ocp(hw, hw->cur_page, RegAddr, value);
 }
 
 void
@@ -189,37 +192,67 @@ rtl_set_eth_phy_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask)
 	rtl_clear_and_set_eth_phy_ocp_bit(hw, addr, 0, mask);
 }
 
+static u8
+rtl8168_check_ephy_addr(struct rtl_hw *hw, int addr)
+{
+	if (hw->mcfg != CFG_METHOD_35 && hw->mcfg != CFG_METHOD_36)
+		goto exit;
+
+	if (addr & (BIT_6 | BIT_5))
+		rtl8168_clear_and_set_mcu_ocp_bit(hw, 0xDE28, (BIT_1 | BIT_0),
+						  (addr >> 5) & (BIT_1 | BIT_0));
+
+	addr &= 0x1F;
+
+exit:
+	return addr;
+}
+
 void
 rtl_ephy_write(struct rtl_hw *hw, int addr, int value)
 {
 	int i;
+	unsigned int mask;
 
-	RTL_W32(hw, EPHYAR, EPHYAR_Write |
-		(addr & EPHYAR_Reg_Mask_v2) << EPHYAR_Reg_shift |
+	if (rtl_is_8125(hw)) {
+		mask = EPHYAR_Reg_Mask_v2;
+	} else {
+		mask = EPHYAR_Reg_Mask;
+		addr = rtl8168_check_ephy_addr(hw, addr);
+	}
+
+	RTL_W32(hw, EPHYAR, EPHYAR_Write | (addr & mask) << EPHYAR_Reg_shift |
 		(value & EPHYAR_Data_Mask));
 
-	for (i = 0; i < 10; i++) {
-		rte_delay_us(100);
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
 
 		/* Check if the NIC has completed EPHY write */
 		if (!(RTL_R32(hw, EPHYAR) & EPHYAR_Flag))
 			break;
 	}
 
-	rte_delay_us(20);
+	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
 }
 
-static u16
+u16
 rtl_ephy_read(struct rtl_hw *hw, int addr)
 {
 	int i;
 	u16 value = 0xffff;
+	unsigned int mask;
+
+	if (rtl_is_8125(hw)) {
+		mask = EPHYAR_Reg_Mask_v2;
+	} else {
+		mask = EPHYAR_Reg_Mask;
+		addr = rtl8168_check_ephy_addr(hw, addr);
+	}
 
-	RTL_W32(hw, EPHYAR, EPHYAR_Read | (addr & EPHYAR_Reg_Mask_v2) <<
-		EPHYAR_Reg_shift);
+	RTL_W32(hw, EPHYAR, EPHYAR_Read | (addr & mask) << EPHYAR_Reg_shift);
 
-	for (i = 0; i < 10; i++) {
-		rte_delay_us(100);
+	for (i = 0; i < RTL_CHANNEL_WAIT_COUNT; i++) {
+		rte_delay_us(RTL_CHANNEL_WAIT_TIME);
 
 		/* Check if the NIC has completed EPHY read */
 		if (RTL_R32(hw, EPHYAR) & EPHYAR_Flag) {
@@ -228,7 +261,7 @@ rtl_ephy_read(struct rtl_hw *hw, int addr)
 		}
 	}
 
-	rte_delay_us(20);
+	rte_delay_us(RTL_CHANNEL_EXIT_DELAY_TIME);
 
 	return value;
 }
@@ -264,18 +297,66 @@ rtl_set_phy_mcu_patch_request(struct rtl_hw *hw)
 	u16 wait_cnt;
 	bool bool_success = TRUE;
 
-	rtl_set_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mdio_write(hw, 0x1f, 0x0B82);
+		rtl_set_eth_phy_bit(hw, 0x10, BIT_4);
+
+		rtl_mdio_write(hw, 0x1f, 0x0B80);
+		wait_cnt = 0;
+		do {
+			gphy_val = rtl_mdio_read(hw, 0x10);
+			rte_delay_us(100);
+			wait_cnt++;
+		}  while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
 
-	wait_cnt = 0;
-	do {
-		gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
-		rte_delay_us(100);
-		wait_cnt++;
-	} while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
+		if (!(gphy_val & BIT_6) && wait_cnt == 1000)
+			bool_success = FALSE;
 
-	if (!(gphy_val & BIT_6) && wait_cnt == 1000)
-		bool_success = FALSE;
+		rtl_mdio_write(hw, 0x1f, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_set_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
+
+		wait_cnt = 0;
+		do {
+			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
+			rte_delay_us(100);
+			wait_cnt++;
+		} while (!(gphy_val & BIT_6) && (wait_cnt < 1000));
 
+		if (!(gphy_val & BIT_6) && wait_cnt == 1000)
+			bool_success = FALSE;
+		break;
+	}
 	if (!bool_success)
 		PMD_INIT_LOG(NOTICE, "%s fail.", __func__);
 
@@ -289,17 +370,66 @@ rtl_clear_phy_mcu_patch_request(struct rtl_hw *hw)
 	u16 wait_cnt;
 	bool bool_success = TRUE;
 
-	rtl_clear_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mdio_write(hw, 0x1f, 0x0B82);
+		rtl_clear_eth_phy_bit(hw, 0x10, BIT_4);
+
+		rtl_mdio_write(hw, 0x1f, 0x0B80);
+		wait_cnt = 0;
+		do {
+			gphy_val = rtl_mdio_read(hw, 0x10);
+			rte_delay_us(100);
+			wait_cnt++;
+		} while ((gphy_val & BIT_6) && (wait_cnt < 1000));
+
+		if ((gphy_val & BIT_6) && wait_cnt == 1000)
+			bool_success = FALSE;
 
-	wait_cnt = 0;
-	do {
-		gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
-		rte_delay_us(100);
-		wait_cnt++;
-	} while ((gphy_val & BIT_6) && (wait_cnt < 1000));
+		rtl_mdio_write(hw, 0x1f, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_clear_eth_phy_ocp_bit(hw, 0xB820, BIT_4);
+
+		wait_cnt = 0;
+		do {
+			gphy_val = rtl_mdio_direct_read_phy_ocp(hw, 0xB800);
+			rte_delay_us(100);
+			wait_cnt++;
+		} while ((gphy_val & BIT_6) && (wait_cnt < 1000));
 
-	if ((gphy_val & BIT_6) && wait_cnt == 1000)
-		bool_success = FALSE;
+		if ((gphy_val & BIT_6) && wait_cnt == 1000)
+			bool_success = FALSE;
+		break;
+	}
 
 	if (!bool_success)
 		PMD_INIT_LOG(NOTICE, "%s fail.", __func__);
@@ -335,6 +465,11 @@ rtl_is_phy_disable_mode_enabled(struct rtl_hw *hw)
 	u8 phy_disable_mode_enabled = FALSE;
 
 	switch (hw->HwSuppCheckPhyDisableModeVer) {
+	case 1:
+		if (rtl_mac_ocp_read(hw, 0xDC20) & BIT_1)
+			phy_disable_mode_enabled = TRUE;
+		break;
+	case 2:
 	case 3:
 		if (RTL_R8(hw, 0xF2) & BIT_5)
 			phy_disable_mode_enabled = TRUE;
@@ -350,6 +485,11 @@ rtl_is_gpio_low(struct rtl_hw *hw)
 	u8 gpio_low = FALSE;
 
 	switch (hw->HwSuppCheckPhyDisableModeVer) {
+	case 1:
+	case 2:
+		if (!(rtl_mac_ocp_read(hw, 0xDC04) & BIT_9))
+			gpio_low = TRUE;
+		break;
 	case 3:
 		if (!(rtl_mac_ocp_read(hw, 0xDC04) & BIT_13))
 			gpio_low = TRUE;
@@ -377,14 +517,41 @@ rtl_wait_phy_ups_resume(struct rtl_hw *hw, u16 PhyState)
 	int i = 0;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		do {
+			tmp_phy_state = rtl_mdio_real_read_phy_ocp(hw, 0x0A42, 0x10);
+			tmp_phy_state &= 0x7;
+			rte_delay_ms(1);
+			i++;
+		} while ((i < 100) && (tmp_phy_state != PhyState));
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		do {
 			tmp_phy_state = rtl_mdio_direct_read_phy_ocp(hw, 0xA420);
 			tmp_phy_state &= 0x7;
 			rte_delay_ms(1);
 			i++;
 		} while ((i < 100) && (tmp_phy_state != PhyState));
+		break;
 	}
 }
 
@@ -395,13 +562,43 @@ rtl_phy_power_up(struct rtl_hw *hw)
 		return;
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
+
 	rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE);
 
+	/* Wait mdc/mdio ready */
+	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		rte_delay_ms(10);
+		break;
+	}
+
 	/* Wait ups resume (phy state 3) */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_wait_phy_ups_resume(hw, 3);
+		break;
 	}
 }
 
@@ -409,9 +606,36 @@ void
 rtl_powerup_pll(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) | BIT_7 | BIT_6);
+		break;
 	}
 
 	rtl_phy_power_up(hw);
@@ -420,8 +644,67 @@ rtl_powerup_pll(struct rtl_hw *hw)
 static void
 rtl_phy_power_down(struct rtl_hw *hw)
 {
+	u32 csi_tmp;
+
+	/* MCU PME intr masks */
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
+		csi_tmp &= ~(BIT_2 | BIT_3 | BIT_4 | BIT_5 | BIT_6 | BIT_7);
+		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
+		break;
+	case CFG_METHOD_25:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
+		csi_tmp &= ~(BIT_3 | BIT_6);
+		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
+		break;
+	}
+
 	rtl_mdio_write(hw, 0x1F, 0x0000);
-	rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_PDOWN);
+
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_PDOWN);
+		break;
+	default:
+		rtl_mdio_write(hw, MII_BMCR, BMCR_PDOWN);
+		break;
+	}
 }
 
 void
@@ -432,10 +715,75 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 
 	rtl_phy_power_down(hw);
 
+	if (!hw->HwIcVerUnknown) {
+		switch (hw->mcfg) {
+		case CFG_METHOD_21:
+		case CFG_METHOD_22:
+		case CFG_METHOD_24:
+		case CFG_METHOD_25:
+		case CFG_METHOD_26:
+		case CFG_METHOD_27:
+		case CFG_METHOD_28:
+		case CFG_METHOD_29:
+		case CFG_METHOD_30:
+		case CFG_METHOD_31:
+		case CFG_METHOD_32:
+		case CFG_METHOD_33:
+		case CFG_METHOD_34:
+		case CFG_METHOD_35:
+		case CFG_METHOD_36:
+		case CFG_METHOD_48:
+		case CFG_METHOD_49:
+		case CFG_METHOD_50:
+		case CFG_METHOD_51:
+		case CFG_METHOD_52:
+		case CFG_METHOD_53:
+		case CFG_METHOD_54:
+		case CFG_METHOD_55:
+		case CFG_METHOD_56:
+		case CFG_METHOD_57:
+		case CFG_METHOD_69:
+		case CFG_METHOD_70:
+		case CFG_METHOD_71:
+			RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
+			break;
+		}
+	}
+
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_6);
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
 		break;
 	}
 }
@@ -470,12 +818,16 @@ rtl_xmii_reset_enable(struct rtl_hw *hw)
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
 	rtl_mdio_write(hw, MII_ADVERTISE, rtl_mdio_read(hw, MII_ADVERTISE) &
-		       ~(ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF |
-		       ADVERTISE_100FULL));
+		       ~(ADVERTISE_10HALF | ADVERTISE_10FULL |
+		       ADVERTISE_100HALF | ADVERTISE_100FULL));
 	rtl_mdio_write(hw, MII_CTRL1000, rtl_mdio_read(hw, MII_CTRL1000) &
 		       ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL));
-	rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4, rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4) &
-				      ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL));
+
+	if (rtl_is_8125(hw))
+		rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4,
+					      rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4) &
+					      ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL));
+
 	rtl_mdio_write(hw, MII_BMCR, BMCR_RESET | BMCR_ANENABLE);
 
 	if (rtl_wait_phy_reset_complete(hw) == 0)
@@ -488,7 +840,7 @@ rtl8125_set_hw_phy_before_init_phy_mcu(struct rtl_hw *hw)
 	u16 phy_reg_value;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_4:
+	case CFG_METHOD_50:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xBF86, 0x9000);
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xC402, BIT_10);
@@ -516,8 +868,41 @@ rtl_get_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 	u16 hw_ram_code_ver = ~0;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x801E);
+		hw_ram_code_ver = rtl_mdio_read(hw, 0x14);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
 		hw_ram_code_ver = rtl_mdio_direct_read_phy_ocp(hw, 0xA438);
 		break;
@@ -547,8 +932,42 @@ static void
 rtl_write_hw_phy_mcu_code_ver(struct rtl_hw *hw)
 {
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x801E);
+		rtl_mdio_write(hw, 0x14, hw->sw_ram_code_ver);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x801E);
 		rtl_mdio_direct_write_phy_ocp(hw, 0xA438, hw->sw_ram_code_ver);
 		hw->hw_ram_code_ver = hw->sw_ram_code_ver;
@@ -560,6 +979,11 @@ static void
 rtl_enable_phy_disable_mode(struct rtl_hw *hw)
 {
 	switch (hw->HwSuppCheckPhyDisableModeVer) {
+	case 1:
+		rtl_mac_ocp_write(hw, 0xDC20, rtl_mac_ocp_read(hw, 0xDC20) |
+					      BIT_1);
+		break;
+	case 2:
 	case 3:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) | BIT_5);
 		break;
@@ -570,6 +994,11 @@ static void
 rtl_disable_phy_disable_mode(struct rtl_hw *hw)
 {
 	switch (hw->HwSuppCheckPhyDisableModeVer) {
+	case 1:
+		rtl_mac_ocp_write(hw, 0xDC20, rtl_mac_ocp_read(hw, 0xDC20) &
+					      ~BIT_1);
+		break;
+	case 2:
 	case 3:
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_5);
 		break;
@@ -578,6 +1007,107 @@ rtl_disable_phy_disable_mode(struct rtl_hw *hw)
 	rte_delay_ms(1);
 }
 
+static int
+rtl8168_phy_ram_code_check(struct rtl_hw *hw)
+{
+	u16 phy_reg_value;
+	int retval = TRUE;
+
+	if (hw->mcfg == CFG_METHOD_21) {
+		rtl_mdio_write(hw, 0x1f, 0x0A40);
+		phy_reg_value = rtl_mdio_read(hw, 0x10);
+		phy_reg_value &= ~BIT_11;
+		rtl_mdio_write(hw, 0x10, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A00);
+		phy_reg_value = rtl_mdio_read(hw, 0x10);
+		phy_reg_value &= ~(BIT_12 | BIT_13 | BIT_14 | BIT_15);
+		rtl_mdio_write(hw, 0x10, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8010);
+		phy_reg_value = rtl_mdio_read(hw, 0x14);
+		phy_reg_value &= ~BIT_11;
+		rtl_mdio_write(hw, 0x14, phy_reg_value);
+
+		retval = rtl_set_phy_mcu_patch_request(hw);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A40);
+		rtl_mdio_write(hw, 0x10, 0x0140);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A4A);
+		phy_reg_value = rtl_mdio_read(hw, 0x13);
+		phy_reg_value &= ~BIT_6;
+		phy_reg_value |= BIT_7;
+		rtl_mdio_write(hw, 0x13, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A44);
+		phy_reg_value = rtl_mdio_read(hw, 0x14);
+		phy_reg_value |= BIT_2;
+		rtl_mdio_write(hw, 0x14, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A50);
+		phy_reg_value = rtl_mdio_read(hw, 0x11);
+		phy_reg_value |= (BIT_11 | BIT_12);
+		rtl_mdio_write(hw, 0x11, phy_reg_value);
+
+		retval = rtl_clear_phy_mcu_patch_request(hw);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A40);
+		rtl_mdio_write(hw, 0x10, 0x1040);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A4A);
+		phy_reg_value = rtl_mdio_read(hw, 0x13);
+		phy_reg_value &= ~(BIT_6 | BIT_7);
+		rtl_mdio_write(hw, 0x13, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A44);
+		phy_reg_value = rtl_mdio_read(hw, 0x14);
+		phy_reg_value &= ~BIT_2;
+		rtl_mdio_write(hw, 0x14, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A50);
+		phy_reg_value = rtl_mdio_read(hw, 0x11);
+		phy_reg_value &= ~(BIT_11 | BIT_12);
+		rtl_mdio_write(hw, 0x11, phy_reg_value);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A43);
+		rtl_mdio_write(hw, 0x13, 0x8010);
+		phy_reg_value = rtl_mdio_read(hw, 0x14);
+		phy_reg_value |= BIT_11;
+		rtl_mdio_write(hw, 0x14, phy_reg_value);
+
+		retval = rtl_set_phy_mcu_patch_request(hw);
+
+		rtl_mdio_write(hw, 0x1f, 0x0A20);
+		phy_reg_value = rtl_mdio_read(hw, 0x13);
+		if (phy_reg_value & BIT_11) {
+			if (phy_reg_value & BIT_10)
+				retval = FALSE;
+		}
+
+		retval = rtl_clear_phy_mcu_patch_request(hw);
+
+		rte_delay_ms(2);
+	}
+
+	rtl_mdio_write(hw, 0x1F, 0x0000);
+
+	return retval;
+}
+
+static void
+rtl8168_set_phy_ram_code_check_fail_flag(struct rtl_hw *hw)
+{
+	u16 tmp_ushort;
+
+	if (hw->mcfg == CFG_METHOD_21) {
+		tmp_ushort = rtl_mac_ocp_read(hw, 0xD3C0);
+		tmp_ushort |= BIT_0;
+		rtl_mac_ocp_write(hw, 0xD3C0, tmp_ushort);
+	}
+}
+
 static void
 rtl_init_hw_phy_mcu(struct rtl_hw *hw)
 {
@@ -589,6 +1119,11 @@ rtl_init_hw_phy_mcu(struct rtl_hw *hw)
 	if (rtl_check_hw_phy_mcu_code_ver(hw))
 		return;
 
+	if (!rtl_is_8125(hw) && !rtl8168_phy_ram_code_check(hw)) {
+		rtl8168_set_phy_ram_code_check_fail_flag(hw);
+		return;
+	}
+
 	if (HW_SUPPORT_CHECK_PHY_DISABLE_MODE(hw) && rtl_is_in_phy_disable_mode(hw))
 		require_disable_phy_disable_mode = TRUE;
 
@@ -611,44 +1146,107 @@ static void
 rtl_disable_aldps(struct rtl_hw *hw)
 {
 	u16 tmp_ushort;
-	u32 timeout, wait_cnt;
-
-	tmp_ushort = rtl_mdio_real_read_phy_ocp(hw, 0xA430);
-	if (tmp_ushort & BIT_2) {
-		timeout = 0;
-		wait_cnt = 200;
-		rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
+	u32 timeout = 0;
+	u32 wait_cnt = 200;
 
-		do {
-			rte_delay_us(100);
-
-			tmp_ushort = rtl_mac_ocp_read(hw, 0xE908);
-
-			timeout++;
-		} while (!(tmp_ushort & BIT_7) && timeout < wait_cnt);
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		tmp_ushort = rtl_mdio_real_direct_read_phy_ocp(hw, 0xA430);
+		if (tmp_ushort & BIT_2)
+			rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		tmp_ushort = rtl_mdio_real_direct_read_phy_ocp(hw, 0xA430);
+		if (tmp_ushort & BIT_2) {
+			rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_2);
+
+			do {
+				rte_delay_us(100);
+				tmp_ushort = rtl_mac_ocp_read(hw, 0xE908);
+				timeout++;
+			} while (!(tmp_ushort & BIT_7) && timeout < wait_cnt);
+		}
+		break;
 	}
 }
 
 static bool
 rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 {
+	bool enabled = false;
+
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_55:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		if (rtl_mdio_read(hw, 0x10) & BIT_15)
+			enabled = true;
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
-			return true;
+			enabled = true;
 		break;
 	default:
 		break;
 	}
 
-	return false;
+	return enabled;
 }
 
 static void
 _rtl_disable_adv_eee(struct rtl_hw *hw)
 {
 	bool lock;
+	u16 data;
 
 	if (rtl_is_adv_eee_enabled(hw))
 		lock = true;
@@ -658,9 +1256,70 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 	if (lock)
 		rtl_set_phy_mcu_patch_request(hw);
 
-	rtl_clear_mac_ocp_bit(hw, 0xE052, BIT_0);
-	rtl_clear_eth_phy_ocp_bit(hw, 0xA442, (BIT_12 | BIT_13));
-	rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_15);
+	switch (hw->mcfg) {
+	case CFG_METHOD_25:
+		rtl_eri_write(hw, 0x1EA, 1, 0x00, ERIAR_ExGMAC);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		data = rtl_mdio_read(hw, 0x16);
+		data &= ~BIT_1;
+		rtl_mdio_write(hw, 0x16, data);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_26:
+		data = rtl_mac_ocp_read(hw, 0xE052);
+		data &= ~BIT_0;
+		rtl_mac_ocp_write(hw, 0xE052, data);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		data = rtl_mdio_read(hw, 0x16);
+		data &= ~BIT_1;
+		rtl_mdio_write(hw, 0x16, data);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+		data = rtl_mac_ocp_read(hw, 0xE052);
+		data &= ~BIT_0;
+		rtl_mac_ocp_write(hw, 0xE052, data);
+		break;
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		data = rtl_mac_ocp_read(hw, 0xE052);
+		data &= ~BIT_0;
+		rtl_mac_ocp_write(hw, 0xE052, data);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		data = rtl_mdio_read(hw, 0x10) & ~(BIT_15);
+		rtl_mdio_write(hw, 0x10, data);
+
+		rtl_mdio_write(hw, 0x1F, 0x0A44);
+		data = rtl_mdio_read(hw, 0x11) & ~(BIT_12 | BIT_13 | BIT_14);
+		rtl_mdio_write(hw, 0x11, data);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_clear_mac_ocp_bit(hw, 0xE052, BIT_0);
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA442, (BIT_12 | BIT_13));
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA430, BIT_15);
+		break;
+	}
 
 	if (lock)
 		rtl_clear_phy_mcu_patch_request(hw);
@@ -669,25 +1328,42 @@ _rtl_disable_adv_eee(struct rtl_hw *hw)
 static void
 rtl_disable_adv_eee(struct rtl_hw *hw)
 {
+	if (hw->mcfg < CFG_METHOD_25 || hw->mcfg == CFG_METHOD_37)
+		return;
+
 	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
-		rtl8125_oob_mutex_lock(hw);
+		rtl_oob_mutex_lock(hw);
 		break;
 	}
 
 	_rtl_disable_adv_eee(hw);
 
 	switch (hw->mcfg) {
+	case CFG_METHOD_23:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
-		rtl8125_oob_mutex_unlock(hw);
+		rtl_oob_mutex_unlock(hw);
 		break;
 	}
 }
@@ -695,7 +1371,39 @@ rtl_disable_adv_eee(struct rtl_hw *hw)
 static void
 rtl_disable_eee(struct rtl_hw *hw)
 {
+	u16 data;
+	u32 csi_tmp;
+
 	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		csi_tmp = rtl_eri_read(hw, 0x1B0, 4, ERIAR_ExGMAC);
+		csi_tmp &= ~(BIT_1 | BIT_0);
+		rtl_eri_write(hw, 0x1B0, 4, csi_tmp, ERIAR_ExGMAC);
+		rtl_mdio_write(hw, 0x1F, 0x0A43);
+		data = rtl_mdio_read(hw, 0x11);
+		if (hw->mcfg == CFG_METHOD_36)
+			rtl_mdio_write(hw, 0x11, data | BIT_4);
+		else
+			rtl_mdio_write(hw, 0x11, data & ~BIT_4);
+		rtl_mdio_write(hw, 0x1F, 0x0A5D);
+		rtl_mdio_write(hw, 0x10, 0x0000);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
@@ -712,7 +1420,11 @@ rtl_disable_eee(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
-	case CFG_METHOD_53 ... CFG_METHOD_57:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
@@ -723,7 +1435,9 @@ rtl_disable_eee(struct rtl_hw *hw)
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_7);
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA4A2, BIT_9);
 		break;
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5D0, (MDIO_EEE_100TX | MDIO_EEE_1000T));
@@ -740,6 +1454,19 @@ rtl_disable_eee(struct rtl_hw *hw)
 		break;
 	}
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		rtl_clear_eth_phy_bit(hw, 0x14, BIT_7);
+		rtl_mdio_write(hw, 0x1F, 0x0A4A);
+		rtl_clear_eth_phy_bit(hw, 0x11, BIT_9);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	}
+
 	/* Advanced EEE */
 	rtl_disable_adv_eee(hw);
 }
@@ -749,24 +1476,32 @@ rtl_hw_phy_config(struct rtl_hw *hw)
 {
 	rtl_xmii_reset_enable(hw);
 
+	if (HW_DASH_SUPPORT_TYPE_3(hw) && hw->HwPkgDet == 0x06)
+		return;
+
 	rtl8125_set_hw_phy_before_init_phy_mcu(hw);
 
 	rtl_init_hw_phy_mcu(hw);
 
 	hw->hw_ops.hw_phy_config(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-		rtl_disable_aldps(hw);
-		break;
-	}
+	rtl_disable_aldps(hw);
 
 	/* Legacy force mode (chap 22) */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
-	default:
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		rtl_clear_eth_phy_ocp_bit(hw, 0xA5B4, BIT_15);
 		break;
 	}
@@ -784,7 +1519,11 @@ rtl_phy_restart_nway(struct rtl_hw *hw)
 		return;
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
-	rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_ANRESTART);
+	if (rtl_is_8125(hw))
+		rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_ANRESTART);
+	else
+		rtl_mdio_write(hw, MII_BMCR, BMCR_RESET | BMCR_ANENABLE |
+					     BMCR_ANRESTART);
 }
 
 static void
@@ -819,11 +1558,45 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 	int rc = -EINVAL;
 
 	/* Disable giga lite */
-	rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
-	rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_0);
+	switch (hw->mcfg) {
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		rtl_clear_eth_phy_bit(hw, 0x14, BIT_9);
+		rtl_mdio_write(hw, 0x1F, 0x0A40);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+		rtl_mdio_write(hw, 0x1F, 0x0A42);
+		rtl_clear_eth_phy_bit(hw, 0x14, BIT_9 | BIT_7);
+		rtl_mdio_write(hw, 0x1F, 0x0A40);
+		rtl_mdio_write(hw, 0x1F, 0x0000);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA428, BIT_9);
+		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_0);
 
-	if (HW_SUPP_PHY_LINK_SPEED_5000M(hw))
-		rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_1);
+		if (HW_SUPP_PHY_LINK_SPEED_5000M(hw))
+			rtl_clear_eth_phy_ocp_bit(hw, 0xA5EA, BIT_1);
+		break;
+	}
 
 	if (!rtl_is_speed_mode_valid(speed)) {
 		speed = hw->HwSuppMaxPhyLinkSpeed;
@@ -833,8 +1606,10 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 
 	giga_ctrl = rtl_mdio_read(hw, MII_CTRL1000);
 	giga_ctrl &= ~(ADVERTISE_1000HALF | ADVERTISE_1000FULL);
-	ctrl_2500 = rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4);
-	ctrl_2500 &= ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL);
+	if (rtl_is_8125(hw)) {
+		ctrl_2500 = rtl_mdio_direct_read_phy_ocp(hw, 0xA5D4);
+		ctrl_2500 &= ~(RTK_ADVERTISE_2500FULL | RTK_ADVERTISE_5000FULL);
+	}
 
 	if (autoneg == AUTONEG_ENABLE) {
 		/* N-way force */
@@ -867,7 +1642,8 @@ rtl_set_speed_xmii(struct rtl_hw *hw, u8 autoneg, u32 speed, u8 duplex, u32 adv)
 		rtl_mdio_write(hw, 0x1f, 0x0000);
 		rtl_mdio_write(hw, MII_ADVERTISE, auto_nego);
 		rtl_mdio_write(hw, MII_CTRL1000, giga_ctrl);
-		rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4, ctrl_2500);
+		if (rtl_is_8125(hw))
+			rtl_mdio_direct_write_phy_ocp(hw, 0xA5D4, ctrl_2500);
 		rtl_phy_restart_nway(hw);
 		rte_delay_ms(20);
 	} else {
@@ -897,3 +1673,27 @@ rtl_set_speed(struct rtl_hw *hw)
 
 	return ret;
 }
+
+void
+rtl_clear_and_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
+			      u16 setmask)
+{
+	u16 phy_reg_value;
+
+	phy_reg_value = rtl_mdio_read(hw, addr);
+	phy_reg_value &= ~clearmask;
+	phy_reg_value |= setmask;
+	rtl_mdio_write(hw, addr, phy_reg_value);
+}
+
+void
+rtl_clear_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask)
+{
+	rtl_clear_and_set_eth_phy_bit(hw, addr, mask, 0);
+}
+
+void
+rtl_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask)
+{
+	rtl_clear_and_set_eth_phy_bit(hw, addr, 0, mask);
+}
diff --git a/drivers/net/r8169/r8169_phy.h b/drivers/net/r8169/r8169_phy.h
index 4d553f9712..ea1facba5b 100644
--- a/drivers/net/r8169/r8169_phy.h
+++ b/drivers/net/r8169/r8169_phy.h
@@ -109,6 +109,8 @@
 #define MDIO_EEE_2_5GT  0x0001
 #define MDIO_EEE_5GT    0x0002
 
+#define HW_SUPP_SERDES_PHY(_M)  ((_M)->HwSuppSerDesPhyVer > 0)
+
 void rtl_clear_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 void rtl_set_mac_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 
@@ -124,6 +126,7 @@ void rtl_clear_eth_phy_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 void rtl_set_eth_phy_ocp_bit(struct rtl_hw *hw, u16 addr, u16 mask);
 
 void rtl_ephy_write(struct rtl_hw *hw, int addr, int value);
+u16 rtl_ephy_read(struct rtl_hw *hw, int addr);
 
 void rtl_clear_and_set_pcie_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
 				    u16 setmask);
@@ -144,4 +147,12 @@ void rtl_hw_phy_config(struct rtl_hw *hw);
 
 int rtl_set_speed(struct rtl_hw *hw);
 
+u32 rtl_mdio_real_read_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr);
+void rtl_mdio_real_write_phy_ocp(struct rtl_hw *hw, u16 PageNum, u32 RegAddr,
+				 u32 value);
+void rtl_clear_and_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 clearmask,
+				   u16 setmask);
+void rtl_clear_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask);
+void rtl_set_eth_phy_bit(struct rtl_hw *hw, u8 addr, u16 mask);
+
 #endif /* R8169_PHY_H */
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 57b97338d4..eee91a639e 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -41,10 +41,6 @@ struct rtl_tx_desc {
 	RTE_ATOMIC(u32) opts1;
 	u32 opts2;
 	u64 addr;
-	u32 reserved0;
-	u32 reserved1;
-	u32 reserved2;
-	u32 reserved3;
 };
 
 /* Struct RxDesc in kernel r8169 */
@@ -187,6 +183,9 @@ enum _DescStatusBit {
 #define LSOPKTSIZE_MAX 0xffffU
 #define MSS_MAX        0x07ffu /* MSS value */
 
+typedef void (*rtl_clear_rdu_func)(struct rtl_hw *);
+static rtl_clear_rdu_func rtl_clear_rdu;
+
 /* ---------------------------------RX---------------------------------- */
 
 static void
@@ -384,8 +383,8 @@ rtl_alloc_rx_queue_mbufs(struct rtl_rx_queue *rxq)
 	return 0;
 }
 
-static int
-rtl_hw_set_features(struct rtl_hw *hw, uint64_t offloads)
+static void
+rtl8125_hw_set_features(struct rtl_hw *hw, uint64_t offloads)
 {
 	u16 cp_cmd;
 	u32 rx_config;
@@ -406,8 +405,35 @@ rtl_hw_set_features(struct rtl_hw *hw, uint64_t offloads)
 		cp_cmd &= ~RxChkSum;
 
 	RTL_W16(hw, CPlusCmd, cp_cmd);
+}
 
-	return 0;
+static void
+rtl8168_hw_set_features(struct rtl_hw *hw, uint64_t offloads)
+{
+	u16 cp_cmd;
+
+	cp_cmd = RTL_R16(hw, CPlusCmd);
+
+	if (offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
+		cp_cmd |= RxChkSum;
+	else
+		cp_cmd &= ~RxChkSum;
+
+	if (offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+		cp_cmd |= RxVlan;
+	else
+		cp_cmd &= ~RxVlan;
+
+	RTL_W16(hw, CPlusCmd, cp_cmd);
+}
+
+static void
+rtl_hw_set_features(struct rtl_hw *hw, uint64_t offloads)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_hw_set_features(hw, offloads);
+	else
+		rtl8168_hw_set_features(hw, offloads);
 }
 
 static void
@@ -421,6 +447,18 @@ rtl_hw_set_rx_packet_filter(struct rtl_hw *hw)
 	RTL_W32(hw, RxConfig, rx_mode | (RTL_R32(hw, RxConfig)));
 }
 
+static void
+rtl8125_clear_rdu(struct rtl_hw *hw)
+{
+	RTL_W32(hw, ISR0_8125, (RxOK | RxErr | RxDescUnavail));
+}
+
+static void
+rtl8168_clear_rdu(struct rtl_hw *hw)
+{
+	RTL_W16(hw, IntrStatus, (RxOK | RxErr | RxDescUnavail));
+}
+
 int
 rtl_rx_init(struct rte_eth_dev *dev)
 {
@@ -428,7 +466,7 @@ rtl_rx_init(struct rte_eth_dev *dev)
 	struct rtl_hw *hw = &adapter->hw;
 	struct rtl_rx_queue *rxq;
 	int ret;
-	u32 max_rx_pkt_size;
+	u32 csi_tmp, max_rx_pkt_size;
 
 	rxq = dev->data->rx_queues[0];
 
@@ -463,6 +501,37 @@ rtl_rx_init(struct rte_eth_dev *dev)
 
 	rtl_enable_cfg9346_write(hw);
 
+	switch (hw->mcfg) {
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		/* RX ftr mcu enable */
+		csi_tmp = rtl_eri_read(hw, 0xDC, 1, ERIAR_ExGMAC);
+		csi_tmp &= ~BIT_0;
+		rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+		csi_tmp |= BIT_0;
+		rtl_eri_write(hw, 0xDC, 1, csi_tmp, ERIAR_ExGMAC);
+
+		/* RSS disable */
+		rtl_eri_write(hw, 0xC0, 2, 0x0000, ERIAR_ExGMAC); /* queue num = 1 */
+		rtl_eri_write(hw, 0xB8, 4, 0x00000000, ERIAR_ExGMAC);
+		break;
+	}
+
 	/* RX accept type and csum vlan offload */
 	rtl_hw_set_features(hw, rxq->offloads);
 
@@ -477,6 +546,11 @@ rtl_rx_init(struct rte_eth_dev *dev)
 
 	dev->data->rx_queue_state[0] = RTE_ETH_QUEUE_STATE_STARTED;
 
+	if (rtl_is_8125(hw))
+		rtl_clear_rdu = rtl8125_clear_rdu;
+	else
+		rtl_clear_rdu = rtl8168_clear_rdu;
+
 	return 0;
 }
 
@@ -527,10 +601,10 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	uint16_t nb_rx = 0;
 	uint16_t nb_hold = 0;
 	uint16_t tail = rxq->rx_tail;
+	uint16_t pkt_len = 0;
 	const uint16_t nb_rx_desc = rxq->nb_rx_desc;
 	uint32_t opts1;
 	uint32_t opts2;
-	uint16_t pkt_len = 0;
 	uint64_t dma_addr;
 
 	hw_ring = rxq->hw_ring;
@@ -632,7 +706,7 @@ rtl_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		rte_wmb();
 
 		/* Clear RDU */
-		RTL_W32(hw, ISR0_8125, (RxOK | RxErr | RxDescUnavail));
+		rtl_clear_rdu(hw);
 
 		nb_hold = 0;
 	}
@@ -829,7 +903,7 @@ rtl_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		rte_wmb();
 
 		/* Clear RDU */
-		RTL_W32(hw, ISR0_8125, (RxOK | RxErr | RxDescUnavail));
+		rtl_clear_rdu(hw);
 
 		nb_hold = 0;
 	}
@@ -941,7 +1015,7 @@ rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq = rte_zmalloc_socket("r8169 TX queue", sizeof(struct rtl_tx_queue),
 				 RTE_CACHE_LINE_SIZE, socket_id);
 
-	if (txq == NULL) {
+	if (!txq) {
 		PMD_INIT_LOG(ERR, "Cannot allocate Tx queue structure");
 		return -ENOMEM;
 	}
@@ -995,6 +1069,44 @@ rtl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
+static void
+rtl8125_set_tx_tag_num(struct rtl_hw *hw)
+{
+	u32 mac_ocp_data;
+
+	mac_ocp_data = rtl_mac_ocp_read(hw, 0xE614);
+	mac_ocp_data &= ~(BIT_10 | BIT_9 | BIT_8);
+	switch (hw->mcfg) {
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_53:
+		mac_ocp_data |= (2 << 8);
+		break;
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
+		if (hw->EnableTxNoClose)
+			mac_ocp_data |= (4 << 8);
+		else
+			mac_ocp_data |= (3 << 8);
+		break;
+	default:
+		mac_ocp_data |= (3 << 8);
+		break;
+	}
+	rtl_mac_ocp_write(hw, 0xE614, mac_ocp_data);
+}
+
+/* Set MTPS: Max Tx Pkt Size */
+static void
+rtl8168_set_mtps(struct rtl_hw *hw)
+{
+	if (hw->mtu > RTE_ETHER_MTU)
+		RTL_W8(hw, MTPS, 0x27);
+	else
+		RTL_W8(hw, MTPS, 0x3F);
+}
+
 int
 rtl_tx_init(struct rte_eth_dev *dev)
 {
@@ -1010,10 +1122,45 @@ rtl_tx_init(struct rte_eth_dev *dev)
 
 	rtl_enable_cfg9346_write(hw);
 
+	if (rtl_is_8125(hw))
+		rtl8125_set_tx_tag_num(hw);
+	else
+		rtl8168_set_mtps(hw);
+
 	/* Set TDFNR: TX Desc Fetch NumbeR */
 	switch (hw->mcfg) {
-	case CFG_METHOD_48 ... CFG_METHOD_57:
-	case CFG_METHOD_69 ... CFG_METHOD_71:
+	case CFG_METHOD_21:
+	case CFG_METHOD_22:
+	case CFG_METHOD_23:
+	case CFG_METHOD_24:
+	case CFG_METHOD_25:
+	case CFG_METHOD_26:
+	case CFG_METHOD_27:
+	case CFG_METHOD_28:
+	case CFG_METHOD_29:
+	case CFG_METHOD_30:
+	case CFG_METHOD_31:
+	case CFG_METHOD_32:
+	case CFG_METHOD_33:
+	case CFG_METHOD_34:
+	case CFG_METHOD_35:
+	case CFG_METHOD_36:
+	case CFG_METHOD_37:
+		RTL_W8(hw, TDFNR, 0x4);
+		break;
+	case CFG_METHOD_48:
+	case CFG_METHOD_49:
+	case CFG_METHOD_50:
+	case CFG_METHOD_51:
+	case CFG_METHOD_52:
+	case CFG_METHOD_53:
+	case CFG_METHOD_54:
+	case CFG_METHOD_55:
+	case CFG_METHOD_56:
+	case CFG_METHOD_57:
+	case CFG_METHOD_69:
+	case CFG_METHOD_70:
+	case CFG_METHOD_71:
 		RTL_W8(hw, TDFNR, 0x10);
 		break;
 	}
@@ -1187,7 +1334,12 @@ rtl_xmit_pkt(struct rtl_hw *hw, struct rtl_tx_queue *txq,
 		rtl_setup_csum_offload(tx_pkt, tx_ol_flags, opts);
 
 		switch (hw->mcfg) {
-		case CFG_METHOD_48 ... CFG_METHOD_53:
+		case CFG_METHOD_48:
+		case CFG_METHOD_49:
+		case CFG_METHOD_50:
+		case CFG_METHOD_51:
+		case CFG_METHOD_52:
+		case CFG_METHOD_53:
 			rtl8125_ptp_patch(tx_pkt);
 			break;
 		}
@@ -1270,7 +1422,7 @@ rtl_get_opts1(struct rtl_tx_desc *txd)
 }
 
 static void
-rtl_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
+rtl8125_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 {
 	struct rtl_tx_entry *sw_ring = txq->sw_ring;
 	struct rtl_tx_entry *txe;
@@ -1282,7 +1434,7 @@ rtl_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 	uint32_t tx_left;
 	uint32_t tx_desc_closed, next_hw_desc_clo_ptr0;
 
-	if (txq == NULL)
+	if (!txq)
 		return;
 
 	if (enable_tx_no_close) {
@@ -1319,8 +1471,54 @@ rtl_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 	txq->tx_head = head;
 }
 
-int
-rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
+static void
+rtl8168_tx_clean(struct rtl_hw *hw __rte_unused, struct rtl_tx_queue *txq)
+{
+	struct rtl_tx_entry *sw_ring = txq->sw_ring;
+	struct rtl_tx_entry *txe;
+	struct rtl_tx_desc *txd;
+	const uint16_t nb_tx_desc = txq->nb_tx_desc;
+	const int tx_tail = txq->tx_tail % nb_tx_desc;
+	int head = txq->tx_head;
+	uint16_t desc_freed = 0;
+
+	if (!txq)
+		return;
+
+	while (1) {
+		txd = &txq->hw_ring[head];
+
+		if (rtl_get_opts1(txd) & DescOwn)
+			break;
+
+		txe = &sw_ring[head];
+		if (txe->mbuf) {
+			rte_pktmbuf_free_seg(txe->mbuf);
+			txe->mbuf = NULL;
+		}
+
+		head = (head + 1) % nb_tx_desc;
+		desc_freed++;
+
+		if (head == tx_tail)
+			break;
+	}
+
+	txq->tx_free += desc_freed;
+	txq->tx_head = head;
+}
+
+static void
+rtl_tx_clean(struct rtl_hw *hw, struct rtl_tx_queue *txq)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_tx_clean(hw, txq);
+	else
+		rtl8168_tx_clean(hw, txq);
+}
+
+static int
+rtl8125_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 {
 	struct rtl_tx_queue *txq = tx_queue;
 	struct rtl_hw *hw = txq->hw;
@@ -1336,7 +1534,7 @@ rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 	uint32_t status;
 	uint32_t tx_desc_closed, next_hw_desc_clo_ptr0;
 
-	if (txq == NULL)
+	if (!txq)
 		return -ENODEV;
 
 	if (enable_tx_no_close) {
@@ -1385,8 +1583,70 @@ rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
 	return count;
 }
 
+static int
+rtl8168_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
+{
+	struct rtl_tx_queue *txq = tx_queue;
+	struct rtl_tx_entry *sw_ring = txq->sw_ring;
+	struct rtl_tx_entry *txe;
+	struct rtl_tx_desc *txd;
+	const uint16_t nb_tx_desc = txq->nb_tx_desc;
+	const int tx_tail = txq->tx_tail % nb_tx_desc;
+	int head = txq->tx_head;
+	uint16_t desc_freed = 0;
+	int count = 0;
+	uint32_t status;
+
+	if (!txq)
+		return -ENODEV;
+
+	while (1) {
+		txd = &txq->hw_ring[head];
+
+		status = rtl_get_opts1(txd);
+
+		if (status & DescOwn)
+			break;
+
+		txe = &sw_ring[head];
+		if (txe->mbuf) {
+			rte_pktmbuf_free_seg(txe->mbuf);
+			txe->mbuf = NULL;
+		}
+
+		head = (head + 1) % nb_tx_desc;
+		desc_freed++;
+
+		if (status & LastFrag) {
+			count++;
+			if ((uint32_t)count == free_cnt)
+				break;
+		}
+
+		if (head == tx_tail)
+			break;
+	}
+
+	txq->tx_free += desc_freed;
+	txq->tx_head = head;
+
+	return count;
+}
+
+int
+rtl_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
+{
+	struct rtl_tx_queue *txq = tx_queue;
+	struct rtl_hw *hw = txq->hw;
+
+	if (rtl_is_8125(hw))
+		return rtl8125_tx_done_cleanup(tx_queue, free_cnt);
+	else
+		return rtl8168_tx_done_cleanup(tx_queue, free_cnt);
+}
+
 static void
-rtl_doorbell(struct rtl_hw *hw, struct rtl_tx_queue *txq)
+rtl8125_doorbell(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 {
 	if (hw->EnableTxNoClose)
 		if (hw->HwSuppTxNoCloseVer > 3)
@@ -1397,6 +1657,21 @@ rtl_doorbell(struct rtl_hw *hw, struct rtl_tx_queue *txq)
 		RTL_W16(hw, TPPOLL_8125, BIT_0);
 }
 
+static void
+rtl8168_doorbell(struct rtl_hw *hw)
+{
+	RTL_W8(hw, TxPoll, NPQ);
+}
+
+static void
+rtl_doorbell(struct rtl_hw *hw, struct rtl_tx_queue *txq)
+{
+	if (rtl_is_8125(hw))
+		rtl8125_doorbell(hw, txq);
+	else
+		rtl8168_doorbell(hw);
+}
+
 /* PMD transmit function */
 uint16_t
 rtl_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
-- 
2.34.1

