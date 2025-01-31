Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE82BC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC63B41611;
	Fri, 31 Jan 2025 13:59:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id D2F0B42D78
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328378; x=1769864378;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=njBbgFDpVpMIMKK5ChWffa/Wy+SAsv4RtfiQudv0gQI=;
 b=myRrGabBK5d+VCo2BRRDsU49w/gPrDwxCsrl2h0KCATkfr8d1cwTXxLV
 wh9oeC/8Bo/1zCz4bfoemWlSKZSG4b+7tmJH/4hNUzRQpRylS7NMs7kfz
 J6LUoMOUyqGrAMrGqryQf19eapy4CqsB62JZpSzi5P4EH0LKNlkIs5DSH
 8Umh8M1gExzeKZVs48UX4j3qwO8HRNHbJdlJxpVikGw66awhX/CGLof0I
 Xo+fddmlypUIOBQC/ux14FlPehPQTTN6g43YN0hIhTcczEvpC5UWBJmua
 +uFm0O2WlveosFv8hN9SA0wELgo49pIz88RnD4zZhKm9NvknCkD/8uLoM w==;
X-CSE-ConnectionGUID: 30puqasnTJ2uDlSOUq0ZmA==
X-CSE-MsgGUID: y8oONzcyR7adrt0Cnq9Vjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315629"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:37 -0800
X-CSE-ConnectionGUID: LK9XfpYZRbmiPIvFu2VfDQ==
X-CSE-MsgGUID: pj0FzYlHRGuyTdBTwOHzlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503378"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 12/42] net/e1000: add support for more I219 devices
Date: Fri, 31 Jan 2025 12:58:25 +0000
Message-ID: <39c8e217ac9f03b963efa684b4fdcf3c47d16e9c.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Add support for new hardware ID's from the I219 series.

Signed-off-by: Lifshits, Vitaly <vitaly.lifshits@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c     | 32 +++++++++++++++++
 drivers/net/intel/e1000/base/e1000_hw.h      | 36 +++++++++++++++++---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 21 ++++++++++++
 drivers/net/intel/e1000/em_ethdev.c          | 28 ++++++++++++++-
 4 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 1a7a737637..bc7956cd01 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -278,6 +278,8 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_PCH_SPT_I219_V4:
 	case E1000_DEV_ID_PCH_SPT_I219_LM5:
 	case E1000_DEV_ID_PCH_SPT_I219_V5:
+	case E1000_DEV_ID_PCH_CMP_I219_LM12:
+	case E1000_DEV_ID_PCH_CMP_I219_V12:
 		mac->type = e1000_pch_spt;
 		break;
 	case E1000_DEV_ID_PCH_CNP_I219_LM6:
@@ -288,8 +290,18 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_PCH_ICP_I219_V8:
 	case E1000_DEV_ID_PCH_ICP_I219_LM9:
 	case E1000_DEV_ID_PCH_ICP_I219_V9:
+	case E1000_DEV_ID_PCH_CMP_I219_LM10:
+	case E1000_DEV_ID_PCH_CMP_I219_V10:
+	case E1000_DEV_ID_PCH_CMP_I219_LM11:
+	case E1000_DEV_ID_PCH_CMP_I219_V11:
 		mac->type = e1000_pch_cnp;
 		break;
+	case E1000_DEV_ID_PCH_TGP_I219_LM13:
+	case E1000_DEV_ID_PCH_TGP_I219_V13:
+	case E1000_DEV_ID_PCH_TGP_I219_LM14:
+	case E1000_DEV_ID_PCH_TGP_I219_V14:
+	case E1000_DEV_ID_PCH_TGP_I219_LM15:
+	case E1000_DEV_ID_PCH_TGP_I219_V15:
 	case E1000_DEV_ID_PCH_ADL_I219_LM16:
 	case E1000_DEV_ID_PCH_ADL_I219_V16:
 	case E1000_DEV_ID_PCH_RPL_I219_LM23:
@@ -302,6 +314,24 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_PCH_RPL_I219_V22:
 		mac->type = e1000_pch_adp;
 		break;
+	case E1000_DEV_ID_PCH_MTP_I219_LM18:
+	case E1000_DEV_ID_PCH_MTP_I219_V18:
+	case E1000_DEV_ID_PCH_MTP_I219_LM19:
+	case E1000_DEV_ID_PCH_MTP_I219_V19:
+	case E1000_DEV_ID_PCH_LNL_I219_LM20:
+	case E1000_DEV_ID_PCH_LNL_I219_V20:
+	case E1000_DEV_ID_PCH_ARL_I219_LM24:
+	case E1000_DEV_ID_PCH_ARL_I219_V24:
+		mac->type = e1000_pch_mtp;
+		break;
+	case E1000_DEV_ID_PCH_PTP_I219_LM25:
+	case E1000_DEV_ID_PCH_PTP_I219_V25:
+	case E1000_DEV_ID_PCH_WCL_I219_LM27:
+	case E1000_DEV_ID_PCH_WCL_I219_V27:
+	case E1000_DEV_ID_PCH_NVL_I219_LM29:
+	case E1000_DEV_ID_PCH_NVL_I219_V29:
+		mac->type = e1000_pch_ptp;
+		break;
 	case E1000_DEV_ID_82575EB_COPPER:
 	case E1000_DEV_ID_82575EB_FIBER_SERDES:
 	case E1000_DEV_ID_82575GB_QUAD_COPPER:
@@ -474,6 +504,8 @@ s32 e1000_setup_init_funcs(struct e1000_hw *hw, bool init_device)
 	case e1000_pch_cnp:
 	case e1000_pch_adp:
 	case e1000_pch_tgp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		e1000_init_function_pointers_ich8lan(hw);
 		break;
 	case e1000_82575:
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index c16dd1cbf7..e98413d4b2 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -124,14 +124,40 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_ICP_I219_V8		0x15E0
 #define E1000_DEV_ID_PCH_ICP_I219_LM9		0x15E1
 #define E1000_DEV_ID_PCH_ICP_I219_V9		0x15E2
+#define E1000_DEV_ID_PCH_CMP_I219_LM10		0x0D4E
+#define E1000_DEV_ID_PCH_CMP_I219_V10		0x0D4F
+#define E1000_DEV_ID_PCH_CMP_I219_LM11		0x0D4C
+#define E1000_DEV_ID_PCH_CMP_I219_V11		0x0D4D
+#define E1000_DEV_ID_PCH_CMP_I219_LM12		0x0D53
+#define E1000_DEV_ID_PCH_CMP_I219_V12		0x0D55
+#define E1000_DEV_ID_PCH_TGP_I219_LM13		0x15FB
+#define E1000_DEV_ID_PCH_TGP_I219_V13		0x15FC
+#define E1000_DEV_ID_PCH_TGP_I219_LM14		0x15F9
+#define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
+#define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
+#define E1000_DEV_ID_PCH_TGP_I219_V15		0x15F5
 #define E1000_DEV_ID_PCH_ADL_I219_LM16		0x1A1E
 #define E1000_DEV_ID_PCH_ADL_I219_V16		0x1A1F
 #define E1000_DEV_ID_PCH_ADL_I219_LM17		0x1A1C
 #define E1000_DEV_ID_PCH_ADL_I219_V17		0x1A1D
-#define E1000_DEV_ID_PCH_RPL_I219_LM23          0x0DC5
-#define E1000_DEV_ID_PCH_RPL_I219_V23           0x0DC6
-#define E1000_DEV_ID_PCH_RPL_I219_LM22          0x0DC7
-#define E1000_DEV_ID_PCH_RPL_I219_V22           0x0DC8
+#define E1000_DEV_ID_PCH_MTP_I219_LM18		0x550A
+#define E1000_DEV_ID_PCH_MTP_I219_V18		0x550B
+#define E1000_DEV_ID_PCH_MTP_I219_LM19		0x550C
+#define E1000_DEV_ID_PCH_MTP_I219_V19		0x550D
+#define E1000_DEV_ID_PCH_LNL_I219_LM20		0x550E
+#define E1000_DEV_ID_PCH_LNL_I219_V20		0x550F
+#define E1000_DEV_ID_PCH_RPL_I219_LM22		0x0DC7
+#define E1000_DEV_ID_PCH_RPL_I219_V22		0x0DC8
+#define E1000_DEV_ID_PCH_RPL_I219_LM23		0x0DC5
+#define E1000_DEV_ID_PCH_RPL_I219_V23		0x0DC6
+#define E1000_DEV_ID_PCH_ARL_I219_LM24		0x57A0
+#define E1000_DEV_ID_PCH_ARL_I219_V24		0x57A1
+#define E1000_DEV_ID_PCH_PTP_I219_LM25		0x57B3
+#define E1000_DEV_ID_PCH_PTP_I219_V25		0x57B4
+#define E1000_DEV_ID_PCH_WCL_I219_LM27		0x57B7
+#define E1000_DEV_ID_PCH_WCL_I219_V27		0x57B8
+#define E1000_DEV_ID_PCH_NVL_I219_LM29		0x57B9
+#define E1000_DEV_ID_PCH_NVL_I219_V29		0x57BA
 #define E1000_DEV_ID_82576			0x10C9
 #define E1000_DEV_ID_82576_FIBER		0x10E6
 #define E1000_DEV_ID_82576_SERDES		0x10E7
@@ -237,6 +263,8 @@ enum e1000_mac_type {
 	e1000_pch_spt,
 	e1000_pch_cnp,
 	e1000_pch_adp,
+	e1000_pch_mtp,
+	e1000_pch_ptp,
 	e1000_pch_tgp,
 	e1000_82575,
 	e1000_82576,
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 14f86b7bdc..4ff213f2c4 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -314,7 +314,10 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		if (e1000_phy_is_accessible_pchlan(hw))
 			break;
 
@@ -464,7 +467,10 @@ STATIC s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 		case e1000_pch_lpt:
 		case e1000_pch_spt:
 		case e1000_pch_cnp:
+		case e1000_pch_tgp:
 		case e1000_pch_adp:
+		case e1000_pch_mtp:
+		case e1000_pch_ptp:
 			/* In case the PHY needs to be in mdio slow mode,
 			 * set slow mode and try to get the PHY id again.
 			 */
@@ -768,7 +774,10 @@ STATIC s32 e1000_init_mac_params_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		/* multicast address update for pch2 */
 		mac->ops.update_mc_addr_list =
 			e1000_update_mc_addr_list_pch2lan;
@@ -1755,7 +1764,10 @@ void e1000_init_function_pointers_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		hw->phy.ops.init_params = e1000_init_phy_params_pchlan;
 		break;
 	default:
@@ -2221,7 +2233,10 @@ STATIC s32 e1000_sw_lcd_config_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		sw_cfg_mask = E1000_FEXTNVM_SW_CONFIG_ICH8M;
 		break;
 	default:
@@ -3342,7 +3357,10 @@ STATIC s32 e1000_valid_nvm_bank_detect_ich8lan(struct e1000_hw *hw, u32 *bank)
 	switch (hw->mac.type) {
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		bank1_offset = nvm->flash_bank_size;
 		act_offset = E1000_ICH_NVM_SIG_WORD;
 
@@ -4314,7 +4332,10 @@ STATIC s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
+	case e1000_pch_tgp:
 	case e1000_pch_adp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 		word = NVM_COMPAT;
 		valid_csum_mask = NVM_COMPAT_VALID_CSUM;
 		break;
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index 80ad360a23..bd3f7e44df 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -159,14 +159,34 @@ static const struct rte_pci_id pci_id_em_map[] = {
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_V8) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_LM9) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_V9) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_LM10) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_V10) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_LM11) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_V11) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_LM12) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CMP_I219_V12) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_LM13) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_V13) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_LM14) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_V14) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_LM15) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_TGP_I219_V15) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_LM16) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_V16) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_LM17) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_V17) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_MTP_I219_LM18) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_MTP_I219_V18) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_MTP_I219_LM19) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_MTP_I219_V19) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_LNL_I219_LM20) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_LNL_I219_V20) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_LM22) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_V22) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_LM23) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_V23) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ARL_I219_LM24) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ARL_I219_V24) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -501,6 +521,8 @@ em_set_pba(struct e1000_hw *hw)
 		case e1000_pch_cnp:
 		case e1000_pch_adp:
 		case e1000_pch_tgp:
+		case e1000_pch_mtp:
+		case e1000_pch_ptp:
 			pba = E1000_PBA_26K;
 			break;
 		default:
@@ -873,7 +895,9 @@ em_hardware_init(struct e1000_hw *hw)
 		   hw->mac.type == e1000_pch_spt ||
 		   hw->mac.type == e1000_pch_cnp ||
 		   hw->mac.type == e1000_pch_adp ||
-		   hw->mac.type == e1000_pch_tgp) {
+		   hw->mac.type == e1000_pch_tgp ||
+		   hw->mac.type == e1000_pch_mtp ||
+		   hw->mac.type == e1000_pch_ptp) {
 		hw->fc.requested_mode = e1000_fc_full;
 	}
 
@@ -1056,6 +1080,8 @@ em_get_max_pktlen(struct rte_eth_dev *dev)
 	case e1000_pch_cnp:
 	case e1000_pch_adp:
 	case e1000_pch_tgp:
+	case e1000_pch_mtp:
+	case e1000_pch_ptp:
 	case e1000_82574:
 	case e1000_80003es2lan: /* 9K Jumbo Frame size */
 	case e1000_82583:
-- 
2.43.5

