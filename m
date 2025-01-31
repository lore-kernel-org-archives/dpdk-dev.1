Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BFC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 598EF427D2;
	Fri, 31 Jan 2025 13:59:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C07F74279D
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328363; x=1769864363;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IbmNkDLkv30TC20CPSR1yLvCZ/jNwzAhGeLY8hrtl9w=;
 b=VYHmC6VnuEN/y9+e7MSMoDmBp3Zj6+YfTZvxfVRtKlc6KSiHd9pofj5S
 D918BVPNC6RGUawnudLuJt6oP1/dtSWWFSzkB1fMs5Bt7ON1vjfWcHxw9
 XbVKWazHKBtMknX4u6/ZNTWAapRQCDKSfH0B60SXFgHkvCs1iuiHmSjfE
 +lU0Hgk+OjW6QsJJHG1IPm+dOeC50ftotZLUBXZOSSosLHCv3yRfY4HP3
 jj8uK0gQlN0V6Q70Hwat5/kpaPR0XVkkc+eYZfePO82/abmuP7RuzX4rV
 LzdM5V8JHismdkQ1KF0kHKmgUSwHWc6Ln2Up4z3AqMXms+5WkGVHJ/jL/ A==;
X-CSE-ConnectionGUID: CepQejwTR0auxRXbSQ4dbw==
X-CSE-MsgGUID: 5HrYBHMUQ5+YuG2aivkUbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315598"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:23 -0800
X-CSE-ConnectionGUID: HPUbIjosTXmxgeE/4+oydA==
X-CSE-MsgGUID: o9PMKrZHTxKoQiTmrM+TOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503334"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 02/42] net/e1000/base: add initial support for i225
Date: Fri, 31 Jan 2025 12:58:15 +0000
Message-ID: <41add229fd9b1c85fbc5c4451309110094b9626d.1738328107.git.anatoly.burakov@intel.com>
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

Add basic init, and PHY/MAC type support for i225 series NICs. This is
mostly identical to IGC driver, with some minor differences due to the
way IGC driver was originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c     |  20 ++
 drivers/net/intel/e1000/base/e1000_api.h     |   1 +
 drivers/net/intel/e1000/base/e1000_defines.h |   2 +
 drivers/net/intel/e1000/base/e1000_hw.h      |  19 ++
 drivers/net/intel/e1000/base/e1000_i225.c    | 211 +++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h    |  10 +
 drivers/net/intel/e1000/base/e1000_phy.c     |   4 +
 drivers/net/intel/e1000/base/e1000_regs.h    |   1 +
 drivers/net/intel/e1000/base/meson.build     |   1 +
 9 files changed, 269 insertions(+)
 create mode 100644 drivers/net/intel/e1000/base/e1000_i225.c
 create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 6697b4b64f..1a7a737637 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -354,6 +354,23 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_82576_VF_HV:
 		mac->type = e1000_vfadapt;
 		break;
+	case E1000_DEV_ID_I225_LM:
+	case E1000_DEV_ID_I225_LMVP:
+	case E1000_DEV_ID_I225_V:
+	case E1000_DEV_ID_I225_K:
+	case E1000_DEV_ID_I225_I:
+	case E1000_DEV_ID_I225_IT:
+	case E1000_DEV_ID_I220_V:
+	case E1000_DEV_ID_I225_BLANK_NVM:
+	case E1000_DEV_ID_I226_LM:
+	case E1000_DEV_ID_I226_V:
+	case E1000_DEV_ID_I226_IT:
+	case E1000_DEV_ID_I226_K:
+	case E1000_DEV_ID_I221_V:
+	case E1000_DEV_ID_I226_LMVP:
+	case E1000_DEV_ID_I226_BLANK_NVM:
+		mac->type = e1000_i225;
+		break;
 	case E1000_DEV_ID_I350_VF:
 	case E1000_DEV_ID_I350_VF_HV:
 		mac->type = e1000_vfadapt_i350;
@@ -470,6 +487,9 @@ s32 e1000_setup_init_funcs(struct e1000_hw *hw, bool init_device)
 	case e1000_i211:
 		e1000_init_function_pointers_i210(hw);
 		break;
+	case e1000_i225:
+		e1000_init_function_pointers_i225(hw);
+		break;
 	case e1000_vfadapt:
 		e1000_init_function_pointers_vf(hw);
 		break;
diff --git a/drivers/net/intel/e1000/base/e1000_api.h b/drivers/net/intel/e1000/base/e1000_api.h
index 6b38e2b7bb..2466c2fd48 100644
--- a/drivers/net/intel/e1000/base/e1000_api.h
+++ b/drivers/net/intel/e1000/base/e1000_api.h
@@ -19,6 +19,7 @@ extern void e1000_init_function_pointers_vf(struct e1000_hw *hw);
 extern void e1000_power_up_fiber_serdes_link(struct e1000_hw *hw);
 extern void e1000_shutdown_fiber_serdes_link(struct e1000_hw *hw);
 extern void e1000_init_function_pointers_i210(struct e1000_hw *hw);
+extern void e1000_init_function_pointers_i225(struct e1000_hw *hw);
 
 s32 e1000_set_obff_timer(struct e1000_hw *hw, u32 itr);
 s32 e1000_set_mac_type(struct e1000_hw *hw);
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 97cc2797b2..cdc0703582 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1257,6 +1257,8 @@
 #define IGP04E1000_E_PHY_ID	0x02A80391
 #define BCM54616_E_PHY_ID	0x03625D10
 #define M88_VENDOR		0x0141
+#define I225_I_PHY_ID		0x67C9DC00
+#define I226_LM_PHY_ID		0x67C9DC10
 
 /* M88E1000 Specific Registers */
 #define M88E1000_PHY_SPEC_CTRL		0x10  /* PHY Specific Control Reg */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index c7e6903ecc..a21cb070e0 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -168,6 +168,22 @@ struct e1000_hw;
 #define E1000_DEV_ID_I210_SERDES_FLASHLESS	0x157C
 #define E1000_DEV_ID_I210_SGMII_FLASHLESS	0x15F6
 #define E1000_DEV_ID_I211_COPPER		0x1539
+#define E1000_DEV_ID_I225_LM			0x15F2
+#define E1000_DEV_ID_I225_V			0x15F3
+#define E1000_DEV_ID_I225_K			0x3100
+#define E1000_DEV_ID_I225_K2			0x3101
+#define E1000_DEV_ID_I225_LMVP			0x5502
+#define E1000_DEV_ID_I225_IT			0x0D9F
+#define E1000_DEV_ID_I225_I			0x15F8
+#define E1000_DEV_ID_I220_V			0x15F7
+#define E1000_DEV_ID_I225_BLANK_NVM		0x15FD
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
@@ -229,6 +245,7 @@ enum e1000_mac_type {
 	e1000_i354,
 	e1000_i210,
 	e1000_i211,
+	e1000_i225,
 	e1000_vfadapt,
 	e1000_vfadapt_i350,
 	e1000_num_macs  /* List is 1-based, so subtract 1 for true count. */
@@ -277,6 +294,7 @@ enum e1000_phy_type {
 	e1000_phy_82580,
 	e1000_phy_vf,
 	e1000_phy_i210,
+	e1000_phy_i225,
 };
 
 enum e1000_bus_type {
@@ -1019,6 +1037,7 @@ struct e1000_hw {
 #include "e1000_ich8lan.h"
 #include "e1000_82575.h"
 #include "e1000_i210.h"
+#include "e1000_i225.h"
 #include "e1000_base.h"
 
 /* These functions must be implemented by drivers */
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
new file mode 100644
index 0000000000..37acb29034
--- /dev/null
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2001-2024 Intel Corporation
+ */
+
+#include "e1000_api.h"
+
+STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw);
+STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw);
+STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw);
+
+/**
+ *  e1000_init_mac_params_i225 - Init MAC func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
+{
+	struct e1000_mac_info *mac = &hw->mac;
+
+	DEBUGFUNC("e1000_init_mac_params_i225");
+
+	/* Initialize function pointer */
+	e1000_init_mac_ops_generic(hw);
+
+	/* Set media type */
+	hw->phy.media_type = e1000_media_type_copper;
+	/* Set mta register count */
+	mac->mta_reg_count = 128;
+	/* Set rar entry count */
+	mac->rar_entry_count = E1000_RAR_ENTRIES_BASE;
+	/* bus type/speed/width */
+	mac->ops.get_bus_info = e1000_get_bus_info_pcie_generic;
+	/* reset */
+	mac->ops.reset_hw = e1000_reset_hw_i225;
+	/* hw initialization */
+	mac->ops.init_hw = e1000_init_hw_i225;
+	/* link setup */
+	mac->ops.setup_link = e1000_setup_link_generic;
+	mac->ops.check_for_link = e1000_check_for_copper_link_generic;
+	/* link info */
+	mac->ops.get_link_up_info = e1000_get_speed_and_duplex_copper_generic;
+
+	/* Set if part includes ASF firmware */
+	mac->asf_firmware_present = true;
+
+	/* multicast address update */
+	mac->ops.update_mc_addr_list = e1000_update_mc_addr_list_generic;
+
+	mac->ops.write_vfta = e1000_write_vfta_generic;
+
+	return E1000_SUCCESS;
+}
+
+/**
+ *  e1000_init_phy_params_i225 - Init PHY func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
+{
+	struct e1000_phy_info *phy = &hw->phy;
+	s32 ret_val = E1000_SUCCESS;
+	u32 ctrl_ext;
+
+	DEBUGFUNC("e1000_init_phy_params_i225");
+
+	phy->ops.read_i2c_byte = e1000_read_i2c_byte_generic;
+	phy->ops.write_i2c_byte = e1000_write_i2c_byte_generic;
+
+	if (hw->phy.media_type != e1000_media_type_copper) {
+		phy->type = e1000_phy_none;
+		goto out;
+	}
+
+	phy->ops.power_up   = e1000_power_up_phy_copper;
+	phy->ops.power_down = e1000_power_down_phy_copper_base;
+
+	phy->reset_delay_us	= 100;
+
+	phy->ops.acquire	= e1000_acquire_phy_base;
+	phy->ops.check_reset_block = e1000_check_reset_block_generic;
+	phy->ops.commit		= e1000_phy_sw_reset_generic;
+	phy->ops.release	= e1000_release_phy_base;
+	phy->ops.reset		= e1000_phy_hw_reset_generic;
+
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
+
+	/* Make sure the PHY is in a good state. Several people have reported
+	 * firmware leaving the PHY's page select register set to something
+	 * other than the default of zero, which causes the PHY ID read to
+	 * access something other than the intended register.
+	 */
+	ret_val = hw->phy.ops.reset(hw);
+	if (ret_val)
+		goto out;
+
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
+
+out:
+	return ret_val;
+}
+
+/**
+ *  e1000_reset_hw_i225 - Reset hardware
+ *  @hw: pointer to the HW structure
+ *
+ *  This resets the hardware into a known state.
+ **/
+STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw)
+{
+	u32 ctrl;
+	s32 ret_val;
+
+	DEBUGFUNC("e1000_reset_hw_i225");
+
+	/*
+	 * Prevent the PCI-E bus from sticking if there is no TLP connection
+	 * on the last TLP read/write transaction when MAC is reset.
+	 */
+	ret_val = e1000_disable_pcie_master_generic(hw);
+	if (ret_val)
+		DEBUGOUT("PCI-E Master disable polling has failed.\n");
+
+	DEBUGOUT("Masking off all interrupts\n");
+	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
+
+	E1000_WRITE_REG(hw, E1000_RCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TCTL, E1000_TCTL_PSP);
+	E1000_WRITE_FLUSH(hw);
+
+	msec_delay(10);
+
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
+
+	DEBUGOUT("Issuing a global reset to MAC\n");
+	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_RST);
+
+	ret_val = e1000_get_auto_rd_done_generic(hw);
+	if (ret_val) {
+		/*
+		 * When auto config read does not complete, do not
+		 * return with an error. This can happen in situations
+		 * where there is no eeprom and prevents getting link.
+		 */
+		DEBUGOUT("Auto Read Done did not complete\n");
+	}
+
+	/* Clear any pending interrupt events. */
+	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
+	E1000_READ_REG(hw, E1000_ICR);
+
+	/* Install any alternate MAC address into RAR0 */
+	ret_val = e1000_check_alt_mac_addr_generic(hw);
+
+	return ret_val;
+}
+
+/* e1000_init_function_pointers_i225 - Init func ptrs.
+ * @hw: pointer to the HW structure
+ *
+ * Called to initialize all function pointers and parameters.
+ */
+void e1000_init_function_pointers_i225(struct e1000_hw *hw)
+{
+	e1000_init_mac_ops_generic(hw);
+	e1000_init_phy_ops_generic(hw);
+	hw->mac.ops.init_params = e1000_init_mac_params_i225;
+	hw->phy.ops.init_params = e1000_init_phy_params_i225;
+}
+
+/* e1000_get_cfg_done_i225 - Read config done bit
+ * @hw: pointer to the HW structure
+ *
+ * Read the management control register for the config done bit for
+ * completion status.  NOTE: silicon which is EEPROM-less will fail trying
+ * to read the config done bit, so an error is *ONLY* logged and returns
+ * E1000_SUCCESS.  If we were to return with error, EEPROM-less silicon
+ * would not be able to be reset or change link.
+ */
+STATIC s32 e1000_get_cfg_done_i225(struct e1000_hw *hw)
+{
+	s32 timeout = PHY_CFG_TIMEOUT;
+	u32 mask = E1000_NVM_CFG_DONE_PORT_0;
+
+	DEBUGFUNC("e1000_get_cfg_done_i225");
+
+	while (timeout) {
+		if (E1000_READ_REG(hw, E1000_EEMNGCTL_I225) & mask)
+			break;
+		msec_delay(1);
+		timeout--;
+	}
+	if (!timeout)
+		DEBUGOUT("MNG configuration cycle has not completed.\n");
+
+	return E1000_SUCCESS;
+}
+
+/* e1000_init_hw_i225 - Init hw for I225
+ * @hw: pointer to the HW structure
+ *
+ * Called to initialize hw for i225 hw family.
+ */
+s32 e1000_init_hw_i225(struct e1000_hw *hw)
+{
+	s32 ret_val;
+
+	DEBUGFUNC("e1000_init_hw_i225");
+
+	hw->phy.ops.get_cfg_done = e1000_get_cfg_done_i225;
+	ret_val = e1000_init_hw_base(hw);
+	return ret_val;
+}
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
new file mode 100644
index 0000000000..8e38b75670
--- /dev/null
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2001-2024 Intel Corporation
+ */
+
+#ifndef _E1000_I225_H_
+#define _E1000_I225_H_
+
+s32 e1000_init_hw_i225(struct e1000_hw *hw);
+
+#endif
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 62d0be5080..4840094066 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -3023,6 +3023,10 @@ enum e1000_phy_type e1000_get_phy_type_from_id(u32 phy_id)
 	case I210_I_PHY_ID:
 		phy_type = e1000_phy_i210;
 		break;
+	case I225_I_PHY_ID:
+	case I226_LM_PHY_ID:
+		phy_type = e1000_phy_i225;
+		break;
 	default:
 		phy_type = e1000_phy_unknown;
 		break;
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 092d9d71e6..20abeeaa46 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -87,6 +87,7 @@
 #define E1000_IOSFPC	0x00F28  /* TX corrupted data  */
 #define E1000_EEMNGCTL	0x01010  /* MNG EEprom Control */
 #define E1000_EEMNGCTL_I210	0x01010  /* i210 MNG EEprom Mode Control */
+#define E1000_EEMNGCTL_I225	0x01010  /* i225 MNG EEprom Mode Control */
 #define E1000_EEARBC	0x01024  /* EEPROM Auto Read Bus Control */
 #define E1000_EEARBC_I210	0x12024 /* EEPROM Auto Read Bus Control */
 #define E1000_FLASHT	0x01028  /* FLASH Timer Register */
diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
index e73f3d6d55..033b3af2e2 100644
--- a/drivers/net/intel/e1000/base/meson.build
+++ b/drivers/net/intel/e1000/base/meson.build
@@ -12,6 +12,7 @@ sources = [
         'e1000_82575.c',
         'e1000_api.c',
         'e1000_i210.c',
+        'e1000_i225.c',
         'e1000_ich8lan.c',
         'e1000_mac.c',
         'e1000_manage.c',
-- 
2.43.5

