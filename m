Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0399C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38CA441149;
	Tue,  4 Feb 2025 16:11:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9371D410D4
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681895; x=1770217895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=irbZFW0w3DoDnC+JA5WTVdkXMprjgunNp6h187EG/8A=;
 b=NgWCmr8msGJaZJY6p4QKYf1Dg93yi9GqGArGdG2WHunTcI8tSs2Ukymx
 gR5KWoFbeMcmj6tRRbBi9G9/ykFMP9na1+qj4uXyQ9uM8fw0+lXLoW//7
 JYO525dqU4d9PKyfStXvQJCD/bmcGJxKTJuH0ee6NhuDL6F0Hvc9NIYEq
 w42sNMoVB/1ppT85Tn+8ibhQmJByCCnqCpoTm+zWM1Du2y5qxnFoZjYIs
 3KU8aotrxbqSBtX6EoQDeE/eSpCcF7uueNG1JGD0ljsInVs7wCMcCy5P3
 XeK8TmtXqT7ZE8FqR3rUzwrBXBXkZBLFacC7EBiTWiaM0zjw7TojBmYaF w==;
X-CSE-ConnectionGUID: Oi6NwBnsSQmc3ERwn6NloQ==
X-CSE-MsgGUID: VLsuI07rQVKRi4uy0NeEGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097096"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:34 -0800
X-CSE-ConnectionGUID: lOHS8JlGRi+TjATphBUGGg==
X-CSE-MsgGUID: xdnBx/i/Tnqt7ifsTIcMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792569"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 05/54] net/e1000: add missing i225 devices
Date: Tue,  4 Feb 2025 15:10:11 +0000
Message-ID: <cb32aefdaeabc0c1db0657058d8ee5aba1fc6678.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

Add missing i225 devices to the list of supported devices by IGC driver,
as well as resort the device list to match sorting order of definitions
in the base code.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c |  5 +++--
 drivers/net/intel/e1000/base/e1000_hw.h  | 18 ++++++++++--------
 drivers/net/intel/e1000/base/e1000_phy.c |  5 ++++-
 drivers/net/intel/e1000/igc_ethdev.c     | 14 +++++++++-----
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index bd7bb73030..1a7a737637 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -362,11 +362,12 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_I225_IT:
 	case E1000_DEV_ID_I220_V:
 	case E1000_DEV_ID_I225_BLANK_NVM:
-	case E1000_DEV_ID_I226_K:
-	case E1000_DEV_ID_I226_LMVP:
 	case E1000_DEV_ID_I226_LM:
 	case E1000_DEV_ID_I226_V:
 	case E1000_DEV_ID_I226_IT:
+	case E1000_DEV_ID_I226_K:
+	case E1000_DEV_ID_I221_V:
+	case E1000_DEV_ID_I226_LMVP:
 	case E1000_DEV_ID_I226_BLANK_NVM:
 		mac->type = e1000_i225;
 		break;
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index e341c9fe68..8a2135f69a 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -169,19 +169,21 @@ struct e1000_hw;
 #define E1000_DEV_ID_I210_SGMII_FLASHLESS	0x15F6
 #define E1000_DEV_ID_I211_COPPER		0x1539
 #define E1000_DEV_ID_I225_LM			0x15F2
-#define E1000_DEV_ID_I225_LMVP			0x5502
 #define E1000_DEV_ID_I225_V			0x15F3
 #define E1000_DEV_ID_I225_K			0x3100
-#define E1000_DEV_ID_I225_I			0x15F8
+#define E1000_DEV_ID_I225_K2			0x3101
+#define E1000_DEV_ID_I225_LMVP			0x5502
 #define E1000_DEV_ID_I225_IT			0x0D9F
+#define E1000_DEV_ID_I225_I			0x15F8
 #define E1000_DEV_ID_I220_V			0x15F7
 #define E1000_DEV_ID_I225_BLANK_NVM		0x15FD
-#define E1000_DEV_ID_I226_K           0x3102
-#define E1000_DEV_ID_I226_LMVP        0x5503
-#define E1000_DEV_ID_I226_LM          0x125B
-#define E1000_DEV_ID_I226_V           0x125C
-#define E1000_DEV_ID_I226_IT          0x125D
-#define E1000_DEV_ID_I226_BLANK_NVM   0x125F
+#define E1000_DEV_ID_I226_LM			0x125B
+#define E1000_DEV_ID_I226_V			0x125C
+#define E1000_DEV_ID_I226_IT			0x125D
+#define E1000_DEV_ID_I226_K			0x3102
+#define E1000_DEV_ID_I221_V			0x125E
+#define E1000_DEV_ID_I226_LMVP			0x5503
+#define E1000_DEV_ID_I226_BLANK_NVM		0x125F
 #define E1000_DEV_ID_I354_BACKPLANE_1GBPS	0x1F40
 #define E1000_DEV_ID_I354_SGMII			0x1F41
 #define E1000_DEV_ID_I354_BACKPLANE_2_5GBPS	0x1F45
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index ed3fc24365..23701db882 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -1910,6 +1910,7 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 			case M88E1512_E_PHY_ID:
 			case I210_I_PHY_ID:
 			case I225_I_PHY_ID:
+			case I226_LM_PHY_ID:
 				reset_dsp = false;
 				break;
 			default:
@@ -1951,7 +1952,7 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 	if (hw->phy.id == I210_I_PHY_ID)
 		return E1000_SUCCESS;
-	if (hw->phy.id == I225_I_PHY_ID)
+	if (hw->phy.id == I225_I_PHY_ID || hw->phy.id == I226_LM_PHY_ID)
 		return E1000_SUCCESS;
 	if ((hw->phy.id == M88E1543_E_PHY_ID) ||
 	    (hw->phy.id == M88E1512_E_PHY_ID))
@@ -2509,6 +2510,7 @@ s32 e1000_get_cable_length_m88_gen2(struct e1000_hw *hw)
 		phy->cable_length = phy_data / (is_cm ? 100 : 1);
 		break;
 	case I225_I_PHY_ID:
+	case I226_LM_PHY_ID:
 		break;
 	case M88E1543_E_PHY_ID:
 	case M88E1512_E_PHY_ID:
@@ -3090,6 +3092,7 @@ enum e1000_phy_type e1000_get_phy_type_from_id(u32 phy_id)
 		phy_type = e1000_phy_i210;
 		break;
 	case I225_I_PHY_ID:
+	case I226_LM_PHY_ID:
 		phy_type = e1000_phy_i225;
 		break;
 	default:
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 5563cee09c..136f5af2a0 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -107,16 +107,20 @@ static const struct rte_eth_desc_lim tx_desc_lim = {
 
 static const struct rte_pci_id pci_id_igc_map[] = {
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LM) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K2) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I220_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_BLANK_NVM)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LM)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_V)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I221_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_BLANK_NVM)  },
 	{ .vendor_id = 0, /* sentinel */ },
 };
-- 
2.43.5

