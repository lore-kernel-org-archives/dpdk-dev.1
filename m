Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6879CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 10:23:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55B37402EE;
	Fri, 16 Oct 2026 12:23:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 79B88400D5
 for <dev@dpdk.org>; Fri, 16 Oct 2026 12:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792146189; x=1823682189;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lHf+QZdLJCPsDWsY8fJp/bv0WMd+BuE8j3smFKroXGI=;
 b=GLhirCcTcjU64Ut9DlnClG/MhYFAwIIrVgc1UeTuxsKHtWA26zZ1VrGa
 xZgwnPC/8ztoC7bB26tRv+pGOAXElKqeoMNwnbyj516sFcNGZTxbo+o4l
 xYNZBcKhOkVZH+NWdxsTQzmbs2AS5qyAOv1iB87uL+7pw6+F2cbAIJpdf
 ehNWZ9GtWK+yijLR+Z+GmPUAqK8VHPr3q2DFe8z6bbVCfADEqZ8A9Wmxl
 weGPlFuGaqYQEtcA6WqC8/bkzqueVrgqfTgFTKs8loJSDIwy61fL8ccr7
 oeZi0JoKkgZ1LBaH+pIvMiSUs9+DGTNFLbsZP1oSsX8k/3xAsNeBN/xva Q==;
X-CSE-ConnectionGUID: D4w02wB3Tn6CUMzpHsqEmA==
X-CSE-MsgGUID: mor6Wd+XQ82djftoBPi70g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="809302"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="809302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:23:07 -0700
X-CSE-ConnectionGUID: fVg8+YMUSGyNGxU5/vQGBA==
X-CSE-MsgGUID: jShLaZX+QNGLDLrnKa7uyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2292834"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 03:23:07 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/3] net/e1000/base: add new PCH MAC type
Date: Fri, 16 Oct 2026 11:22:59 +0100
Message-ID: <3688b7fdd907877b90fad8ac07213ec97f50c098.1792146148.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792146148.git.anatoly.burakov@intel.com>
References: 
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Add a new `e1000_pch_nvp` MAC type and move the existing NVL device IDs
from `e1000_pch_ptp` to it. The new MAC type takes the same code paths as
`e1000_pch_ptp` in both the base code and the em PMD.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c     | 5 ++++-
 drivers/net/intel/e1000/base/e1000_hw.h      | 1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 7 +++++++
 drivers/net/intel/e1000/em_ethdev.c          | 5 ++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 83b3d6c439..19ba8b575b 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -328,9 +328,11 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_PCH_PTP_I219_V25:
 	case E1000_DEV_ID_PCH_WCL_I219_LM27:
 	case E1000_DEV_ID_PCH_WCL_I219_V27:
+		mac->type = e1000_pch_ptp;
+		break;
 	case E1000_DEV_ID_PCH_NVL_I219_LM29:
 	case E1000_DEV_ID_PCH_NVL_I219_V29:
-		mac->type = e1000_pch_ptp;
+		mac->type = e1000_pch_nvp;
 		break;
 	case E1000_DEV_ID_82575EB_COPPER:
 	case E1000_DEV_ID_82575EB_FIBER_SERDES:
@@ -505,6 +507,7 @@ s32 e1000_setup_init_funcs(struct e1000_hw *hw, bool init_device)
 	case e1000_pch_tgp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		e1000_init_function_pointers_ich8lan(hw);
 		break;
 	case e1000_82575:
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 99c2195916..335a018776 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -265,6 +265,7 @@ enum e1000_mac_type {
 	e1000_pch_adp,
 	e1000_pch_mtp,
 	e1000_pch_ptp,
+	e1000_pch_nvp,
 	e1000_pch_tgp,
 	e1000_82575,
 	e1000_82576,
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 0290a7dcb4..b020639563 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -372,6 +372,7 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		/* Due to clock synchronization issue on MTL and above prior to
 		 * disabling k1 it is required to disable P0s state and
 		 * reconfigure PHY k1 exit timeout. At this point the PHY might
@@ -549,6 +550,7 @@ STATIC s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 		case e1000_pch_adp:
 		case e1000_pch_mtp:
 		case e1000_pch_ptp:
+		case e1000_pch_nvp:
 			/* In case the PHY needs to be in mdio slow mode,
 			 * set slow mode and try to get the PHY id again.
 			 */
@@ -856,6 +858,7 @@ STATIC s32 e1000_init_mac_params_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		/* multicast address update for pch2 */
 		mac->ops.update_mc_addr_list =
 			e1000_update_mc_addr_list_pch2lan;
@@ -1866,6 +1869,7 @@ void e1000_init_function_pointers_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		hw->phy.ops.init_params = e1000_init_phy_params_pchlan;
 		break;
 	default:
@@ -2335,6 +2339,7 @@ STATIC s32 e1000_sw_lcd_config_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		sw_cfg_mask = E1000_FEXTNVM_SW_CONFIG_ICH8M;
 		break;
 	default:
@@ -3461,6 +3466,7 @@ STATIC s32 e1000_valid_nvm_bank_detect_ich8lan(struct e1000_hw *hw, u32 *bank)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		bank1_offset = nvm->flash_bank_size;
 		act_offset = E1000_ICH_NVM_SIG_WORD;
 
@@ -4436,6 +4442,7 @@ STATIC s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 		word = NVM_COMPAT;
 		valid_csum_mask = NVM_COMPAT_VALID_CSUM;
 		break;
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index c02d09e500..be830881db 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -593,6 +593,7 @@ em_set_pba(struct e1000_hw *hw)
 		case e1000_pch_tgp:
 		case e1000_pch_mtp:
 		case e1000_pch_ptp:
+		case e1000_pch_nvp:
 			pba = E1000_PBA_26K;
 			break;
 		default:
@@ -983,7 +984,8 @@ em_hardware_init(struct e1000_hw *hw)
 		   hw->mac.type == e1000_pch_adp ||
 		   hw->mac.type == e1000_pch_tgp ||
 		   hw->mac.type == e1000_pch_mtp ||
-		   hw->mac.type == e1000_pch_ptp) {
+		   hw->mac.type == e1000_pch_ptp ||
+		   hw->mac.type == e1000_pch_nvp) {
 		hw->fc.requested_mode = e1000_fc_full;
 	}
 
@@ -1177,6 +1179,7 @@ em_get_max_pktlen(struct rte_eth_dev *dev)
 	case e1000_pch_tgp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+	case e1000_pch_nvp:
 	case e1000_82574:
 	case e1000_80003es2lan: /* 9K Jumbo Frame size */
 	case e1000_82583:
-- 
2.52.0

