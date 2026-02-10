Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD4EA3F0C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 05:55:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16F3740647;
	Tue, 10 Feb 2026 06:55:24 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 38019402E4
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:55:19 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A5tHWl93127200,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770702918;
 bh=5esDF40EOZODzBGt8E92ucselmWNIyo707eJlpSiNQg=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=RJb11Y3dFQheshi1JVJBDOKZXmTAfy+7rrQNsDDUPYX0l4EUT2Y+4+XE2RUz2jhAI
 AaaymVeJ1Sq3NQpNwybxHuomN7vwXmjtBjoXmE7pXRvotuLxHjkdKVyc8Ku6R1Xh5+
 VvkG9ZEz9duIYCODkIDvZVW4SABaUdwcFvkjT1n5NRWHr52A3I/Uuiw3O5phix7uaV
 3m9bjhstMhqBkFm2w/0TV00V3j59wyib0JuhyKycsf621Scp0iPaJS1Vj+e/rNVRCU
 njC7/oh3YhutW2qLewAb3FrRA2I1egizmAzC3pd9E1vqtTUwToBhq00C7r0FjkP0uQ
 316sLnARaof8w==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A5tHWl93127200
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:55:18 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 10 Feb 2026 13:55:17 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 10 Feb 2026 13:55:17 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 10/12] net/r8169: add support for RTL8125K
Date: Tue, 10 Feb 2026 13:55:09 +0800
Message-ID: <20260210055511.62382-11-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210055511.62382-1-howard_wang@realsil.com.cn>
References: <20260210055511.62382-1-howard_wang@realsil.com.cn>
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
 drivers/net/r8169/base/rtl8125d.c     |  7 +++++
 drivers/net/r8169/base/rtl8125d_mcu.c |  1 +
 drivers/net/r8169/r8169_compat.h      |  1 +
 drivers/net/r8169/r8169_ethdev.c      |  3 ++
 drivers/net/r8169/r8169_hw.c          | 42 +++++++++++----------------
 drivers/net/r8169/r8169_phy.c         |  1 +
 6 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/r8169/base/rtl8125d.c b/drivers/net/r8169/base/rtl8125d.c
index ac500587e0..70b82858ef 100644
--- a/drivers/net/r8169/base/rtl8125d.c
+++ b/drivers/net/r8169/base/rtl8125d.c
@@ -10,6 +10,7 @@
 /*
  * For RTL8125D, CFG_METHOD_56,57
  * For RTL8168KD, CFG_METHOD_59
+ * For RTL8125K, CFG_METHOD_61
  */
 
 static void
@@ -26,6 +27,7 @@ hw_ephy_config_8125d(struct rtl_hw *hw)
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_59:
+	case CFG_METHOD_61:
 		/* Nothing to do */
 		break;
 	}
@@ -278,6 +280,7 @@ hw_phy_config_8125d(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_57:
 	case CFG_METHOD_59:
+	case CFG_METHOD_61:
 		rtl_hw_phy_config_8125d_2(hw);
 		break;
 	}
@@ -302,6 +305,9 @@ hw_mac_mcu_config_8125d(struct rtl_hw *hw)
 	case CFG_METHOD_59:
 		rtl_set_mac_mcu_8125d_2(hw);
 		break;
+	default:
+		/* no mac mcu patch code */
+		break;
 	}
 }
 
@@ -314,6 +320,7 @@ hw_phy_mcu_config_8125d(struct rtl_hw *hw)
 		break;
 	case CFG_METHOD_57:
 	case CFG_METHOD_59:
+	case CFG_METHOD_61:
 		rtl_set_phy_mcu_8125d_2(hw);
 		break;
 	}
diff --git a/drivers/net/r8169/base/rtl8125d_mcu.c b/drivers/net/r8169/base/rtl8125d_mcu.c
index 304bad2998..953c80da5b 100644
--- a/drivers/net/r8169/base/rtl8125d_mcu.c
+++ b/drivers/net/r8169/base/rtl8125d_mcu.c
@@ -10,6 +10,7 @@
 /*
  * For RTL8125D, CFG_METHOD_56,57
  * For RTL8168KD, CFG_METHOD_59
+ * For RTL8125K, CFG_METHOD_61
  */
 
 /* ------------------------------------MAC 8125D------------------------------------- */
diff --git a/drivers/net/r8169/r8169_compat.h b/drivers/net/r8169/r8169_compat.h
index 4339522f2d..91c84c7633 100644
--- a/drivers/net/r8169/r8169_compat.h
+++ b/drivers/net/r8169/r8169_compat.h
@@ -529,6 +529,7 @@ enum RTL_chipset_name {
 	RTL8125CP,
 	RTL8168KD,
 	RTL9151A,
+	RTL8125K,
 	RTL8126A,
 	RTL8168EP,
 	RTL8168FP,
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 625f50853e..72e014e22b 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -172,6 +172,7 @@ _rtl_setup_link(struct rte_eth_dev *dev)
 		case RTL8125D:
 		case RTL8125CP:
 		case RTL9151A:
+		case RTL8125K:
 			speed_mode = SPEED_2500;
 			break;
 		case RTL8126A:
@@ -428,6 +429,7 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	case CFG_METHOD_57:
 	case CFG_METHOD_58:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -474,6 +476,7 @@ rtl_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	case RTL8125D:
 	case RTL8125CP:
 	case RTL9151A:
+	case RTL8125K:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_2_5G;
 		break;
 	}
diff --git a/drivers/net/r8169/r8169_hw.c b/drivers/net/r8169/r8169_hw.c
index ef2b0654a5..aa5e160feb 100644
--- a/drivers/net/r8169/r8169_hw.c
+++ b/drivers/net/r8169/r8169_hw.c
@@ -602,6 +602,7 @@ rtl_stop_all_request(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -660,6 +661,7 @@ rtl_wait_txrx_fifo_empty(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 	case CFG_METHOD_91:
@@ -898,6 +900,7 @@ rtl8125_set_rx_desc_type(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 		RTL_W8(hw, 0xD8, RTL_R8(hw, 0xD8) & ~EnableRxDescV4_0);
 		break;
 	case CFG_METHOD_70:
@@ -1016,7 +1019,8 @@ rtl8125_hw_config(struct rtl_hw *hw)
 	rtl_oob_mutex_lock(hw);
 
 	if (hw->mcfg == CFG_METHOD_56 || hw->mcfg == CFG_METHOD_57 ||
-	    hw->mcfg == CFG_METHOD_59 || hw->mcfg == CFG_METHOD_60)
+	    hw->mcfg == CFG_METHOD_59 || hw->mcfg == CFG_METHOD_60 ||
+	    hw->mcfg == CFG_METHOD_61)
 		rtl_mac_ocp_write(hw, 0xE0C0, 0x4403);
 	else
 		rtl_mac_ocp_write(hw, 0xE0C0, 0x4000);
@@ -1222,10 +1226,11 @@ rtl_set_hw_ops(struct rtl_hw *hw)
 	case CFG_METHOD_55:
 		hw->hw_ops = rtl8125bp_ops;
 		return 0;
-	/* 8125D and 8168KD */
+	/* 8125D, 8168KD, 8125K */
 	case CFG_METHOD_56:
 	case CFG_METHOD_57:
 	case CFG_METHOD_59:
+	case CFG_METHOD_61:
 		hw->hw_ops = rtl8125d_ops;
 		return 0;
 	/* 8125CP */
@@ -1527,6 +1532,9 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	case CFG_METHOD_60:
 		hw->chipset_name = RTL9151A;
 		break;
+	case CFG_METHOD_61:
+		hw->chipset_name = RTL8125K;
+		break;
 	case CFG_METHOD_70:
 	case CFG_METHOD_71:
 		hw->chipset_name = RTL8126A;
@@ -1547,6 +1555,7 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	case RTL8125D:
 	case RTL8125CP:
 	case RTL9151A:
+	case RTL8125K:
 		speed_mode = SPEED_2500;
 		break;
 	case RTL8126A:
@@ -1659,29 +1668,7 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	case CFG_METHOD_37:
 		hw->HwSuppCheckPhyDisableModeVer = 2;
 		break;
-	case CFG_METHOD_23:
-	case CFG_METHOD_27:
-	case CFG_METHOD_28:
-	case CFG_METHOD_31:
-	case CFG_METHOD_32:
-	case CFG_METHOD_33:
-	case CFG_METHOD_34:
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
-	case CFG_METHOD_60:
-	case CFG_METHOD_70:
-	case CFG_METHOD_71:
-	case CFG_METHOD_91:
+	default:
 		hw->HwSuppCheckPhyDisableModeVer = 3;
 		break;
 	}
@@ -1702,6 +1689,7 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 	case CFG_METHOD_91:
 		hw->HwSuppTxNoCloseVer = 6;
 		break;
@@ -1791,6 +1779,7 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 		break;
 	case CFG_METHOD_57:
 	case CFG_METHOD_59:
+	case CFG_METHOD_61:
 		hw->sw_ram_code_ver = NIC_RAMCODE_VERSION_CFG_METHOD_57;
 		break;
 	case CFG_METHOD_58:
@@ -1850,6 +1839,7 @@ rtl_init_software_variable(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 	case CFG_METHOD_91:
 		hw->HwSuppIntMitiVer = 6;
 		break;
@@ -2362,6 +2352,8 @@ rtl_get_mac_version(struct rtl_hw *hw, struct rte_pci_device *pci_dev)
 			hw->mcfg = CFG_METHOD_56;
 		} else if (ic_version_id == 0x100000) {
 			hw->mcfg = CFG_METHOD_57;
+		} else if (ic_version_id == 0x200000) {
+			hw->mcfg = CFG_METHOD_61;
 		} else if (ic_version_id == 0x300000) {
 			hw->mcfg = CFG_METHOD_60;
 		} else {
diff --git a/drivers/net/r8169/r8169_phy.c b/drivers/net/r8169/r8169_phy.c
index de6e512375..079b9e5f00 100644
--- a/drivers/net/r8169/r8169_phy.c
+++ b/drivers/net/r8169/r8169_phy.c
@@ -1051,6 +1051,7 @@ rtl_disable_eee(struct rtl_hw *hw)
 	case CFG_METHOD_58:
 	case CFG_METHOD_59:
 	case CFG_METHOD_60:
+	case CFG_METHOD_61:
 		rtl_clear_mac_ocp_bit(hw, 0xE040, (BIT_1 | BIT_0));
 
 		rtl_set_eth_phy_ocp_bit(hw, 0xA432, BIT_4);
-- 
2.34.1

