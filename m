Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83CCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 02:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 954FF4066C;
	Wed, 29 Oct 2025 03:08:59 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 5BACF40649
 for <dev@dpdk.org>; Wed, 29 Oct 2025 03:08:57 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59T28tXF23479734,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1761703736;
 bh=8ZOGGjDcl/CQvy8v075Q5+273+EpYmqgPlWI0ugICuM=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=gm12E5fJfvqIG9b3uJPSBsHGth7NeA1lQWDhG7lHkCK4dG8eg0EJtdrvzSpiYGrkk
 cXMbKYCqs/DsLYQl8Ci4asP2kNYT1+kzydtiRwro4eLr82LTAoA61JWFGGLZDAhX9G
 YU31WLUacZdexLfj5OjGfYzoDGsm1LUuHW8kNSUArvhbq8ryrCbsXkEcRQb2iIbB/t
 PW+kjcvE0OJ+0at8dqRiGLFruiVcFyVfnVRtZrLtbxsdCztaBcGeC+DEDbVkhqb2Sd
 ZlKM3PYjLH5YP1j3VlFtRubUspa1WYwbd1b6RxwBcAmxT5CkpwxOrD2pBOA2exi25f
 2eDqHdaBrGH5A==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59T28tXF23479734
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Wed, 29 Oct 2025 10:08:55 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Wed, 29 Oct 2025 10:08:54 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Wed, 29 Oct 2025 10:08:54 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 2/3] net/r8169: simplify config method check with if
Date: Wed, 29 Oct 2025 10:08:37 +0800
Message-ID: <20251029020838.401035-3-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029020838.401035-1-howard_wang@realsil.com.cn>
References: <20251029020838.401035-1-howard_wang@realsil.com.cn>
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
 drivers/net/r8169/r8169_compat.h |   1 +
 drivers/net/r8169/r8169_ethdev.c |  25 +-
 drivers/net/r8169/r8169_hw.c     | 462 ++++++++-----------------------
 drivers/net/r8169/r8169_phy.c    | 237 ++--------------
 drivers/net/r8169/r8169_rxtx.c   |  10 +-
 5 files changed, 144 insertions(+), 591 deletions(-)

diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index b106105389..9163c7f59f 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -310,6 +310,7 @@ enum RTL_register_content {
 	RxBufEmpty = 0x01,
 
 	/* Cfg9346 bits */
+	Cfg9346_EEM_MASK = 0xC0,
 	Cfg9346_Lock = 0x00,
 	Cfg9346_Unlock = 0xC0,
 	Cfg9346_EEDO = (1UL << 0),
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 1f7106a95e..f620154bf0 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -164,26 +164,19 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 
 	/* Setup link speed and duplex */
 	if (*link_speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		switch (hw->mcfg) {
-		case CFG_METHOD_48:
-		case CFG_METHOD_49:
-		case CFG_METHOD_50:
-		case CFG_METHOD_51:
-		case CFG_METHOD_52:
-		case CFG_METHOD_53:
-		case CFG_METHOD_54:
-		case CFG_METHOD_55:
-		case CFG_METHOD_56:
-		case CFG_METHOD_57:
-		case CFG_METHOD_58:
+		switch (hw->chipset_name) {
+		case RTL8125A:
+		case RTL8125B:
+		case RTL8168KB:
+		case RTL8125BP:
+		case RTL8125D:
+		case RTL8125CP:
 			speed_mode = SPEED_2500;
 			break;
-		case CFG_METHOD_69:
-		case CFG_METHOD_70:
-		case CFG_METHOD_71:
+		case RTL8126A:
 			speed_mode = SPEED_5000;
 			break;
-		case CFG_METHOD_91:
+		case RTL8127:
 			speed_mode = SPEED_10000;
 			break;
 		default:
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index cb0fadf193..f69f87c202 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -612,25 +612,6 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	int i;
 
 	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rte_delay_ms(2);
-		break;
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
 	case CFG_METHOD_52:
@@ -656,6 +637,9 @@ rtl_stop_all_request(struct rtl_hw *hw)
 		RTL_W8(hw, ChipCmd, RTL_R8(hw, ChipCmd) | StopReq);
 		rte_delay_us(200);
 		break;
+	default:
+		rte_delay_ms(2);
+		break;
 	}
 }
 
@@ -775,45 +759,26 @@ rtl_enable_force_clkreq(struct rtl_hw *hw, bool enable)
 static void
 rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	bool unlock_cfg_wr;
+
+	if ((RTL_R8(hw, Cfg9346) & Cfg9346_EEM_MASK) == Cfg9346_Unlock)
+		unlock_cfg_wr = false;
+	else
+		unlock_cfg_wr = true;
+
+	if (unlock_cfg_wr)
+		rtl_enable_cfg9346_write(hw);
+
+	if (hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
+	    hw->mcfg == CFG_METHOD_91) {
 		if (enable) {
-			RTL_W8(hw, Config2, RTL_R8(hw, Config2) | BIT_7);
+			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) | BIT_3);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
 		} else {
-			RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~BIT_7);
+			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) & ~BIT_3);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
 		}
-		rte_delay_us(10);
-		break;
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
-	case CFG_METHOD_69:
+	} else {
 		if (enable) {
 			RTL_W8(hw, Config2, RTL_R8(hw, Config2) | BIT_7);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
@@ -821,19 +786,13 @@ rtl_enable_aspm_clkreq_lock(struct rtl_hw *hw, bool enable)
 			RTL_W8(hw, Config2, RTL_R8(hw, Config2) & ~BIT_7);
 			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
 		}
-		break;
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
-		if (enable) {
-			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) | BIT_3);
-			RTL_W8(hw, Config5, RTL_R8(hw, Config5) | BIT_0);
-		} else {
-			RTL_W8(hw, INT_CFG0_8125, RTL_R8(hw, INT_CFG0_8125) & ~BIT_3);
-			RTL_W8(hw, Config5, RTL_R8(hw, Config5) & ~BIT_0);
-		}
-		break;
+
+		if (!rtl_is_8125(hw))
+			rte_delay_us(10);
 	}
+
+	if (unlock_cfg_wr)
+		rtl_disable_cfg9346_write(hw);
 }
 
 static void
@@ -851,49 +810,16 @@ rtl8125_disable_eee_plus(struct rtl_hw *hw)
 static void
 rtl_hw_clear_timer_int(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_37) {
 		RTL_W32(hw, TimeInt0, 0x0000);
 		RTL_W32(hw, TimeInt1, 0x0000);
 		RTL_W32(hw, TimeInt2, 0x0000);
 		RTL_W32(hw, TimeInt3, 0x0000);
-		break;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	} else {
 		RTL_W32(hw, TIMER_INT0_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT1_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT2_8125, 0x0000);
 		RTL_W32(hw, TIMER_INT3_8125, 0x0000);
-		break;
 	}
 }
 
@@ -1035,25 +961,12 @@ rtl8125_hw_config(struct rtl_hw *hw)
 		RTL_W32(hw, TxConfig, (RTL_R32(hw, TxConfig) | BIT_6));
 
 	/* TCAM */
-	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
+	if (hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_53)
 		RTL_W16(hw, 0x382, 0x221B);
-		break;
-	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	if ((hw->mcfg >= CFG_METHOD_69 && hw->mcfg <= CFG_METHOD_71) ||
+	    hw->mcfg == CFG_METHOD_91)
 		rtl_disable_l1_timeout(hw);
-		break;
-	}
 
 	/* Disable speed down */
 	RTL_W8(hw, Config1, RTL_R8(hw, Config1) & ~0x10);
@@ -1220,18 +1133,8 @@ rtl8168_hw_config(struct rtl_hw *hw)
 
 	hw->hw_ops.hw_config(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
+	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_28)
 		rtl_eri_write(hw, 0x2F8, 2, 0x1D8F, ERIAR_ExGMAC);
-		break;
-	}
 
 	rtl_hw_clear_timer_int(hw);
 
@@ -1260,18 +1163,14 @@ rtl8168_hw_config(struct rtl_hw *hw)
 		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
+	if (hw->mcfg == CFG_METHOD_21 || hw->mcfg == CFG_METHOD_22 ||
+	    hw->mcfg == CFG_METHOD_24 || hw->mcfg == CFG_METHOD_25 ||
+	    hw->mcfg == CFG_METHOD_26) {
 		for (timeout = 0; timeout < 10; timeout++) {
 			if ((rtl_eri_read(hw, 0x1AE, 2, ERIAR_ExGMAC) & BIT_13) == 0)
 				break;
 			rte_delay_ms(1);
 		}
-		break;
 	}
 
 	rtl_disable_cfg9346_write(hw);
@@ -1372,40 +1271,12 @@ rtl_hw_disable_mac_mcu_bps(struct rtl_hw *hw)
 {
 	u16 reg_addr;
 
-	rtl_enable_cfg9346_write(hw);
 	rtl_enable_aspm_clkreq_lock(hw, 0);
-	rtl_disable_cfg9346_write(hw);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
-		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
-		break;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	if (rtl_is_8125(hw))
 		rtl_mac_ocp_write(hw, 0xFC48, 0x0000);
-		break;
-	}
+	else if (hw->mcfg >= CFG_METHOD_29)
+		rtl_mac_ocp_write(hw, 0xFC38, 0x0000);
 
 	if (rtl_is_8125(hw)) {
 		for (reg_addr = 0xFC28; reg_addr < 0xFC48; reg_addr += 2)
@@ -1618,25 +1489,81 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	u32 tmp;
 
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
+		hw->chipset_name = RTL8125A;
+		break;
 	case CFG_METHOD_50:
 	case CFG_METHOD_51:
+		hw->chipset_name = RTL8125B;
+		break;
 	case CFG_METHOD_52:
 	case CFG_METHOD_53:
+		hw->chipset_name = RTL8168KB;
+		break;
 	case CFG_METHOD_54:
 	case CFG_METHOD_55:
+		hw->chipset_name = RTL8125BP;
+		break;
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
+		hw->chipset_name = RTL8125D;
+		break;
 	case CFG_METHOD_58:
-		speed_mode = SPEED_2500;
+		hw->chipset_name = RTL8125CP;
 		break;
 	case CFG_METHOD_69:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
-		speed_mode = SPEED_5000;
+		hw->chipset_name = RTL8126A;
 		break;
 	case CFG_METHOD_91:
+		hw->chipset_name = RTL8127;
+		break;
+	default:
+		hw->chipset_name = UNKNOWN;
+		break;
+	}
+
+	switch (hw->chipset_name) {
+	case RTL8125A:
+	case RTL8125B:
+	case RTL8168KB:
+	case RTL8125BP:
+	case RTL8125D:
+	case RTL8125CP:
+		speed_mode = SPEED_2500;
+		break;
+	case RTL8126A:
+		speed_mode = SPEED_5000;
+		break;
+	case RTL8127:
 		speed_mode = SPEED_10000;
 		break;
 	default:
@@ -1644,6 +1571,8 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
+	hw->HwSuppMaxPhyLinkSpeed = speed_mode;
+
 	switch (hw->mcfg) {
 	case CFG_METHOD_23:
 	case CFG_METHOD_27:
@@ -1674,20 +1603,12 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
+	if (hw->mcfg >= CFG_METHOD_31 && hw->mcfg <= CFG_METHOD_34) {
 		tmp = rtl_mac_ocp_read(hw, 0xDC00);
 		hw->HwPkgDet = (tmp >> 3) & 0x0F;
-		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
+	if (hw->mcfg >= CFG_METHOD_32 && hw->mcfg <= CFG_METHOD_34) {
 		if (hw->HwPkgDet == 0x06) {
 			tmp = rtl_eri_read(hw, 0xE6, 1, ERIAR_ExGMAC);
 			if (tmp == 0x02)
@@ -1695,7 +1616,6 @@ rtl_init_software_variable(struct rtl_hw *hw)
 			else if (tmp == 0x00)
 				hw->HwSuppSerDesPhyVer = 2;
 		}
-		break;
 	}
 
 	switch (hw->mcfg) {
@@ -1735,69 +1655,6 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	if (HW_DASH_SUPPORT_TYPE_2(hw))
 		hw->cmac_ioaddr = hw->mmio_addr;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-		hw->chipset_name = RTL8168G;
-		break;
-	case CFG_METHOD_23:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-		hw->chipset_name = RTL8168EP;
-		break;
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-		hw->chipset_name = RTL8168H;
-		break;
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-		hw->chipset_name = RTL8168FP;
-		break;
-	case CFG_METHOD_37:
-		hw->chipset_name = RTL8168M;
-		break;
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-		hw->chipset_name = RTL8125A;
-		break;
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-		hw->chipset_name = RTL8125B;
-		break;
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
-		hw->chipset_name = RTL8168KB;
-		break;
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-		hw->chipset_name = RTL8125BP;
-		break;
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-		hw->chipset_name = RTL8125D;
-		break;
-	case CFG_METHOD_58:
-		hw->chipset_name = RTL8125CP;
-		break;
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		hw->chipset_name = RTL8126A;
-		break;
-	case CFG_METHOD_91:
-		hw->chipset_name = RTL8127;
-		break;
-	default:
-		hw->chipset_name = UNKNOWN;
-		break;
-	}
-
 	hw->HwSuppNowIsOobVer = 1;
 
 	switch (hw->mcfg) {
@@ -1839,31 +1696,6 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_56:
-	case CFG_METHOD_57:
-	case CFG_METHOD_58:
-		hw->HwSuppMaxPhyLinkSpeed = SPEED_2500;
-		break;
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-		hw->HwSuppMaxPhyLinkSpeed = SPEED_5000;
-		break;
-	case CFG_METHOD_91:
-		hw->HwSuppMaxPhyLinkSpeed = SPEED_10000;
-		break;
-	default:
-		hw->HwSuppMaxPhyLinkSpeed = SPEED_1000;
-		break;
-	}
-
 	switch (hw->mcfg) {
 	case CFG_METHOD_48:
 	case CFG_METHOD_49:
@@ -2004,13 +1836,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 	else
 		hw->EnableRss = 0;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
+	if (hw->mcfg == CFG_METHOD_49 || hw->mcfg == CFG_METHOD_52) {
 		if ((rtl_mac_ocp_read(hw, 0xD442) & BIT_5) &&
 		    (rtl_mdio_direct_read_phy_ocp(hw, 0xD068) & BIT_1))
 			hw->RequirePhyMdiSwapPatch = TRUE;
-		break;
 	}
 
 	switch (hw->mcfg) {
@@ -2056,14 +1885,10 @@ rtl_init_software_variable(struct rtl_hw *hw)
 		break;
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_91:
+	if (hw->mcfg == CFG_METHOD_91) {
 		tmp = (u8)rtl_mac_ocp_read(hw, 0xD006);
 		if (tmp == 0x07)
 			hw->HwFiberModeVer = FIBER_MODE_RTL8127ATF;
-		break;
-	default:
-		break;
 	}
 
 	rtl_set_link_option(hw, autoneg_mode, speed_mode, duplex_mode, rtl_fc_full);
@@ -2212,37 +2037,12 @@ rtl_exit_oob(struct rtl_hw *hw)
 static void
 rtl_disable_ups(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
+	if (hw->mcfg >= CFG_METHOD_29 && hw->mcfg <= CFG_METHOD_36)
 		rtl_mac_ocp_write(hw, 0xD400,
 				  rtl_mac_ocp_read(hw, 0xD400) & ~BIT_0);
-		break;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	else if (rtl_is_8125(hw))
 		rtl_mac_ocp_write(hw, 0xD40A,
 				  rtl_mac_ocp_read(hw, 0xD40A) & ~BIT_4);
-		break;
-	}
 }
 
 static void
@@ -2250,20 +2050,7 @@ rtl_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 {
 	u16 val;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (hw->mcfg >= CFG_METHOD_25 && hw->mcfg <= CFG_METHOD_37) {
 		val = rtl_mdio_real_read_phy_ocp(hw, 0x0C41, 0x13);
 		if (val != 0x0500) {
 			rtl_set_phy_mcu_patch_request(hw);
@@ -2271,10 +2058,8 @@ rtl_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 			rtl_mdio_real_write_phy_ocp(hw, 0x0C41, 0x13, 0x0500);
 			rtl_clear_phy_mcu_patch_request(hw);
 		}
-		break;
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_52:
+	} else if (hw->mcfg == CFG_METHOD_48 || hw->mcfg == CFG_METHOD_49 ||
+		   hw->mcfg == CFG_METHOD_52){
 		val = rtl_mdio_direct_read_phy_ocp(hw, 0xC416);
 		if (val != 0x0050) {
 			rtl_set_phy_mcu_patch_request(hw);
@@ -2282,23 +2067,13 @@ rtl_disable_ocp_phy_power_saving(struct rtl_hw *hw)
 			rtl_mdio_direct_write_phy_ocp(hw, 0xC416, 0x0500);
 			rtl_clear_phy_mcu_patch_request(hw);
 		}
-		break;
 	}
 }
 
 static void
 rtl8168_disable_dma_agg(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	if (hw->mcfg >= CFG_METHOD_29 && hw->mcfg <= CFG_METHOD_37) {
 		rtl_mac_ocp_write(hw, 0xE63E, rtl_mac_ocp_read(hw, 0xE63E) &
 					      ~(BIT_3 | BIT_2 | BIT_1));
 		rtl_mac_ocp_write(hw, 0xE63E,
@@ -2307,7 +2082,6 @@ rtl8168_disable_dma_agg(struct rtl_hw *hw)
 				  rtl_mac_ocp_read(hw, 0xE63E) & ~(BIT_0));
 		rtl_mac_ocp_write(hw, 0xC094, 0x0);
 		rtl_mac_ocp_write(hw, 0xC09E, 0x0);
-		break;
 	}
 }
 
@@ -2318,9 +2092,7 @@ rtl_hw_init(struct rtl_hw *hw)
 
 	/* Disable aspm clkreq internal */
 	rtl_enable_force_clkreq(hw, 0);
-	rtl_enable_cfg9346_write(hw);
 	rtl_enable_aspm_clkreq_lock(hw, 0);
-	rtl_disable_cfg9346_write(hw);
 
 	rtl_disable_ups(hw);
 
@@ -2338,31 +2110,15 @@ rtl_hw_init(struct rtl_hw *hw)
 	rtl_csi_write(hw, 0x108, csi_tmp);
 
 	/* MCU PME setting */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
+	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_24) {
 		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
 		csi_tmp |= (BIT_2 | BIT_3 | BIT_4 | BIT_5 | BIT_6 | BIT_7);
 		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
-		break;
-	case CFG_METHOD_25:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	} else if (hw->mcfg == CFG_METHOD_25 ||
+		   (hw->mcfg >= CFG_METHOD_27 && hw->mcfg <= CFG_METHOD_37)) {
 		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
 		csi_tmp |= (BIT_3 | BIT_6);
 		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
-		break;
 	}
 }
 
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index 9da3a9d41b..9bb5774672 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -470,44 +470,20 @@ rtl_wait_phy_ups_resume(struct rtl_hw *hw, u16 PhyState)
 	u16 tmp_phy_state;
 	int i = 0;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
+	if (hw->mcfg >= CFG_METHOD_29 && hw->mcfg <= CFG_METHOD_36) {
 		do {
 			tmp_phy_state = rtl_mdio_real_read_phy_ocp(hw, 0x0A42, 0x10);
 			tmp_phy_state &= 0x7;
 			rte_delay_ms(1);
 			i++;
 		} while ((i < 100) && (tmp_phy_state != PhyState));
-		break;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	} else if (rtl_is_8125(hw)) {
 		do {
 			tmp_phy_state = rtl_mdio_direct_read_phy_ocp(hw, 0xA420);
 			tmp_phy_state &= 0x7;
 			rte_delay_ms(1);
 			i++;
 		} while ((i < 100) && (tmp_phy_state != PhyState));
-		break;
 	}
 }
 
@@ -522,13 +498,9 @@ rtl_phy_power_up(struct rtl_hw *hw)
 	rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE);
 
 	/* Wait mdc/mdio ready */
-	switch (hw->mcfg) {
-	case CFG_METHOD_23:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
+	if  (hw->mcfg == CFG_METHOD_23 || hw->mcfg == CFG_METHOD_27 ||
+	     hw->mcfg == CFG_METHOD_28)
 		rte_delay_ms(10);
-		break;
-	}
 
 	/* Wait ups resume (phy state 3) */
 	rtl_wait_phy_ups_resume(hw, 3);
@@ -537,40 +509,8 @@ rtl_phy_power_up(struct rtl_hw *hw)
 void
 rtl_powerup_pll(struct rtl_hw *hw)
 {
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
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
-	case CFG_METHOD_58:
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	if (!(hw->mcfg == CFG_METHOD_23 || hw->mcfg == CFG_METHOD_37))
 		RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) | BIT_7 | BIT_6);
-		break;
-	}
 
 	rtl_phy_power_up(hw);
 }
@@ -581,66 +521,24 @@ rtl_phy_power_down(struct rtl_hw *hw)
 	u32 csi_tmp;
 
 	/* MCU PME intr masks */
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
+	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_24) {
 		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
 		csi_tmp &= ~(BIT_2 | BIT_3 | BIT_4 | BIT_5 | BIT_6 | BIT_7);
 		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
-		break;
-	case CFG_METHOD_25:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
+	} else if (hw->mcfg == CFG_METHOD_25 ||
+		   (hw->mcfg >= CFG_METHOD_27 && hw->mcfg <= CFG_METHOD_37)) {
 		csi_tmp = rtl_eri_read(hw, 0x1AB, 1, ERIAR_ExGMAC);
 		csi_tmp &= ~(BIT_3 | BIT_6);
 		rtl_eri_write(hw, 0x1AB, 1, csi_tmp, ERIAR_ExGMAC);
-		break;
 	}
 
 	rtl_mdio_write(hw, 0x1F, 0x0000);
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
-	case CFG_METHOD_37:
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
-		rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_PDOWN);
-		break;
-	default:
+	if ((hw->mcfg >= CFG_METHOD_25 && hw->mcfg <= CFG_METHOD_28) ||
+	    (hw->mcfg >= CFG_METHOD_31 && hw->mcfg <= CFG_METHOD_34))
 		rtl_mdio_write(hw, MII_BMCR, BMCR_PDOWN);
-		break;
-	}
+	else
+		rtl_mdio_write(hw, MII_BMCR, BMCR_ANENABLE | BMCR_PDOWN);
 }
 
 void
@@ -652,78 +550,18 @@ rtl_powerdown_pll(struct rtl_hw *hw)
 	rtl_phy_power_down(hw);
 
 	if (!hw->HwIcVerUnknown) {
-		switch (hw->mcfg) {
-		case CFG_METHOD_21:
-		case CFG_METHOD_22:
-		case CFG_METHOD_24:
-		case CFG_METHOD_25:
-		case CFG_METHOD_26:
-		case CFG_METHOD_27:
-		case CFG_METHOD_28:
-		case CFG_METHOD_29:
-		case CFG_METHOD_30:
-		case CFG_METHOD_31:
-		case CFG_METHOD_32:
-		case CFG_METHOD_33:
-		case CFG_METHOD_34:
-		case CFG_METHOD_35:
-		case CFG_METHOD_36:
-		case CFG_METHOD_48:
-		case CFG_METHOD_49:
-		case CFG_METHOD_50:
-		case CFG_METHOD_51:
-		case CFG_METHOD_52:
-		case CFG_METHOD_53:
-		case CFG_METHOD_54:
-		case CFG_METHOD_55:
-		case CFG_METHOD_56:
-		case CFG_METHOD_57:
-		case CFG_METHOD_58:
-		case CFG_METHOD_69:
-		case CFG_METHOD_70:
-		case CFG_METHOD_71:
+		if (!(hw->mcfg == CFG_METHOD_23 || hw->mcfg == CFG_METHOD_37 ||
+		      hw->mcfg == CFG_METHOD_91))
 			RTL_W8(hw, PMCH, RTL_R8(hw, PMCH) & ~BIT_7);
-			break;
-		}
 	}
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_21:
-	case CFG_METHOD_22:
-	case CFG_METHOD_23:
-	case CFG_METHOD_24:
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
+	if (hw->mcfg >= CFG_METHOD_21 && hw->mcfg <= CFG_METHOD_36) {
 		RTL_W8(hw, 0xD0, RTL_R8(hw, 0xD0) & ~BIT_6);
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
-		break;
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
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	} else if ((hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_58) ||
+		   (hw->mcfg >= CFG_METHOD_69 && hw->mcfg <= CFG_METHOD_71) ||
+		   hw->mcfg == CFG_METHOD_91) {
 		RTL_W8(hw, 0xF2, RTL_R8(hw, 0xF2) & ~BIT_6);
-		break;
 	}
 }
 
@@ -786,8 +624,7 @@ rtl8125_set_hw_phy_before_init_phy_mcu(struct rtl_hw *hw)
 {
 	u16 val;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_50:
+	if (hw->mcfg == CFG_METHOD_50) {
 		rtl_mdio_direct_write_phy_ocp(hw, 0xBF86, 0x9000);
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xC402, BIT_10);
@@ -805,7 +642,6 @@ rtl8125_set_hw_phy_before_init_phy_mcu(struct rtl_hw *hw)
 		rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xBD4E, (BIT_11 | BIT_10), BIT_11);
 		rtl_clear_and_set_eth_phy_ocp_bit(hw, 0xBF46, (BIT_11 | BIT_10 | BIT_9 | BIT_8),
 						  (BIT_10 | BIT_9 | BIT_8));
-		break;
 	}
 }
 
@@ -1057,42 +893,17 @@ rtl_is_adv_eee_enabled(struct rtl_hw *hw)
 {
 	bool enabled = false;
 
-	switch (hw->mcfg) {
-	case CFG_METHOD_25:
-	case CFG_METHOD_26:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_29:
-	case CFG_METHOD_30:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
-	case CFG_METHOD_35:
-	case CFG_METHOD_36:
+	if (hw->mcfg >= CFG_METHOD_25 && hw->mcfg <= CFG_METHOD_36) {
 		rtl_mdio_write(hw, 0x1F, 0x0A43);
 		if (rtl_mdio_read(hw, 0x10) & BIT_15)
 			enabled = true;
 		rtl_mdio_write(hw, 0x1F, 0x0000);
-		break;
-	case CFG_METHOD_48:
-	case CFG_METHOD_49:
-	case CFG_METHOD_50:
-	case CFG_METHOD_51:
-	case CFG_METHOD_52:
-	case CFG_METHOD_53:
-	case CFG_METHOD_54:
-	case CFG_METHOD_55:
-	case CFG_METHOD_58:
-	case CFG_METHOD_69:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	} else if ((hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_55) ||
+		   hw->mcfg == CFG_METHOD_58 || hw->mcfg == CFG_METHOD_69 ||
+		   hw->mcfg == CFG_METHOD_70 || hw->mcfg == CFG_METHOD_71 ||
+		   hw->mcfg == CFG_METHOD_91){
 		if (rtl_mdio_direct_read_phy_ocp(hw, 0xA430) & BIT_15)
 			enabled = true;
-		break;
-	default:
-		break;
 	}
 
 	return enabled;
diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 94ae5f8212..50a47c3670 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -1612,16 +1612,8 @@ rtl_xmit_pkt(struct rtl_hw *hw, struct rtl_tx_queue *txq,
 	if (large_send == 0) {
 		rtl_setup_csum_offload(tx_pkt, tx_ol_flags, opts);
 
-		switch (hw->mcfg) {
-		case CFG_METHOD_48:
-		case CFG_METHOD_49:
-		case CFG_METHOD_50:
-		case CFG_METHOD_51:
-		case CFG_METHOD_52:
-		case CFG_METHOD_53:
+		if (hw->mcfg >= CFG_METHOD_48 && hw->mcfg <= CFG_METHOD_53)
 			rtl8125_ptp_patch(tx_pkt);
-			break;
-		}
 	}
 
 	for (m_seg = tx_pkt; m_seg; m_seg = m_seg->next) {
-- 
2.34.1

