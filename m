Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C99EC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95182427BE;
	Fri, 31 Jan 2025 13:59:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 96CF2427CA
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328365; x=1769864365;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BATnHCpz0UipoAezmwfV1AK1ENJ/2v0MMtytZQWE0tI=;
 b=kpfb7NDqazD+nPiThgiAAt7rYPQXw4I11C2aHge9m+XwOXw0V3b8D+OH
 1JBTKTg95ai0inEsvm4QIyPkOuEsJ56TZKGIDyDbQoRV1XM2WCh8I5O2s
 glJyg2NqwYs0aqoadUvKCp9PMXEXMIpCksKjfBJ7g2/jYYL3KdlDhu068
 pySw8/m4lWsaoLGOeo9RcjkXdIXsU5e4owDZeCtmRcvWaNrIWCq9TP6q5
 MotOW14X7ET8USzoN1hbXvAK9pMka9LR8AJMNTIbBB3cpvaL3TQa2FyZg
 3Ldxpgvs1o7MEw1hdzK5RxfNi6wJoJmrnVgUWQFhtFtwDkpit5rJqW349 Q==;
X-CSE-ConnectionGUID: t0/pmGYdSFmucw9fBiy7LA==
X-CSE-MsgGUID: oJvi0KjVSlK4+hi7K03XCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315604"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:24 -0800
X-CSE-ConnectionGUID: RFDIK/a3RYyYNogoqvW9bg==
X-CSE-MsgGUID: DewmXJ+HScGRT2rdigWTVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503338"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 03/42] net/e1000/base: add link bringup support for i225
Date: Fri, 31 Jan 2025 12:58:16 +0000
Message-ID: <2eaccb279bf94195d4973ee3cad81d8c5ea33e55.1738328107.git.anatoly.burakov@intel.com>
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

Add link bringup support for i225 series NICs. This is mostly identical
to IGC driver, with some minor differences due to the way IGC driver was
originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  16 +++
 drivers/net/intel/e1000/base/e1000_i225.c    | 107 +++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h    |   3 +
 drivers/net/intel/e1000/base/e1000_mac.c     |  24 ++++-
 drivers/net/intel/e1000/base/e1000_phy.c     |  86 ++++++++++++++-
 drivers/net/intel/e1000/base/e1000_phy.h     |  11 ++
 6 files changed, 241 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index cdc0703582..0e33f27c3f 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -300,6 +300,7 @@
 #define E1000_STATUS_SPEED_10		0x00000000 /* Speed 10Mb/s */
 #define E1000_STATUS_SPEED_100		0x00000040 /* Speed 100Mb/s */
 #define E1000_STATUS_SPEED_1000		0x00000080 /* Speed 1000Mb/s */
+#define E1000_STATUS_SPEED_2500		0x00400000 /* Speed 2.5Gb/s indication for I225 */
 #define E1000_STATUS_LAN_INIT_DONE	0x00000200 /* Lan Init Compltn by NVM */
 #define E1000_STATUS_PHYRA		0x00000400 /* PHY Reset Asserted */
 #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000 /* Master request status */
@@ -331,11 +332,16 @@
 #define ADVERTISE_100_FULL		0x0008
 #define ADVERTISE_1000_HALF		0x0010 /* Not used, just FYI */
 #define ADVERTISE_1000_FULL		0x0020
+#define ADVERTISE_2500_HALF		0x0040 /* NOT used, just FYI */
+#define ADVERTISE_2500_FULL		0x0080
 
 /* 1000/H is not supported, nor spec-compliant. */
 #define E1000_ALL_SPEED_DUPLEX	( \
 	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
 	ADVERTISE_100_FULL | ADVERTISE_1000_FULL)
+#define E1000_ALL_SPEED_DUPLEX_2500 ( \
+	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
+	ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
 #define E1000_ALL_NOT_GIG	( \
 	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
 	ADVERTISE_100_FULL)
@@ -344,6 +350,7 @@
 #define E1000_ALL_HALF_DUPLEX	(ADVERTISE_10_HALF | ADVERTISE_100_HALF)
 
 #define AUTONEG_ADVERTISE_SPEED_DEFAULT		E1000_ALL_SPEED_DUPLEX
+#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500	E1000_ALL_SPEED_DUPLEX_2500
 
 /* LED Control */
 #define E1000_PHY_LED0_MODE_MASK	0x00000007
@@ -826,6 +833,7 @@
 #define E1000_THSTAT_LINK_THROTTLE	0x00000002 /* Link Spd Throttle Event */
 
 /* I350 EEE defines */
+#define E1000_IPCNFG_EEE_2_5G_AN	0x00000010 /* IPCNFG EEE Ena 2.5G AN */
 #define E1000_IPCNFG_EEE_1G_AN		0x00000008 /* IPCNFG EEE Ena 1G AN */
 #define E1000_IPCNFG_EEE_100M_AN	0x00000004 /* IPCNFG EEE Ena 100M AN */
 #define E1000_EEER_TX_LPI_EN		0x00010000 /* EEER Tx LPI Enable */
@@ -993,8 +1001,16 @@
 #define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
 #define PHY_EXT_STATUS		0x0F /* Extended Status Reg */
 
+/* PHY GPY 211 registers */
+#define STANDARD_AN_REG_MASK	0x0007 /* MMD */
+#define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
+#define MMD_DEVADDR_SHIFT	16     /* Shift MMD to higher bits */
+#define CR_2500T_FD_CAPS	0x0080 /* Advertise 2500T FD capability */
+
 #define PHY_CONTROL_LB		0x4000 /* PHY Loopback bit */
 
+#define E1000_PHY_RST_COMP	0x0100 /* Internal PHY reset completion */
+
 /* NVM Control */
 #define E1000_EECD_SK		0x00000001 /* NVM Clock */
 #define E1000_EECD_CS		0x00000002 /* NVM Chip Select */
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 37acb29034..ccabfdca83 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -39,6 +39,9 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	/* link info */
 	mac->ops.get_link_up_info = e1000_get_speed_and_duplex_copper_generic;
 
+	/* Allow a single clear of the SW semaphore on I225 */
+	mac->ops.setup_physical_interface = e1000_setup_copper_link_i225;
+
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = true;
 
@@ -73,6 +76,8 @@ STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 	phy->ops.power_up   = e1000_power_up_phy_copper;
 	phy->ops.power_down = e1000_power_down_phy_copper_base;
 
+	phy->autoneg_mask = AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
+
 	phy->reset_delay_us	= 100;
 
 	phy->ops.acquire	= e1000_acquire_phy_base;
@@ -94,6 +99,20 @@ STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 
 	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
 
+	ret_val = e1000_get_phy_id(hw);
+
+	/*
+	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
+	 * at this point. However, in DPDK version of IGC this check was
+	 * removed because it interfered with some i225-based NICs, and it was
+	 * deemed unnecessary because only the i225 NIC would've called this
+	 * code anyway because it was in the IGC driver.
+	 *
+	 * In merged IGB/IGC, this code is still only called by i225-based NICs,
+	 * so the previous fix is applicable.
+	 */
+	phy->type = e1000_phy_i225;
+
 out:
 	return ret_val;
 }
@@ -153,6 +172,36 @@ STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/*
+ * e1000_setup_copper_link_i225 - Configure copper link settings
+ * @hw: pointer to the HW structure
+ *
+ * Configures the link for auto-neg or forced speed and duplex.  Then we check
+ * for link, once link is established calls to configure collision distance
+ * and flow control are called.
+ */
+s32 e1000_setup_copper_link_i225(struct e1000_hw *hw)
+{
+	u32 phpm_reg;
+	s32 ret_val;
+	u32 ctrl;
+
+	DEBUGFUNC("e1000_setup_copper_link_i225");
+
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
+	ctrl |= E1000_CTRL_SLU;
+	ctrl &= ~(E1000_CTRL_FRCSPD | E1000_CTRL_FRCDPX);
+	E1000_WRITE_REG(hw, E1000_CTRL, ctrl);
+
+	phpm_reg = E1000_READ_REG(hw, E1000_I225_PHPM);
+	phpm_reg &= ~E1000_I225_PHPM_GO_LINKD;
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, phpm_reg);
+
+	ret_val = e1000_setup_copper_link_generic(hw);
+
+	return ret_val;
+}
+
 /* e1000_init_function_pointers_i225 - Init func ptrs.
  * @hw: pointer to the HW structure
  *
@@ -209,3 +258,61 @@ s32 e1000_init_hw_i225(struct e1000_hw *hw)
 	ret_val = e1000_init_hw_base(hw);
 	return ret_val;
 }
+
+/*
+ * e1000_set_d0_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D0 state
+ * @hw: pointer to the HW structure
+ * @active: true to enable LPLU, false to disable
+ *
+ * Note: since I225 does not actually support LPLU, this function
+ * simply enables/disables 1G and 2.5G speeds in D0.
+ */
+s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active)
+{
+	u32 data;
+
+	DEBUGFUNC("e1000_set_d0_lplu_state_i225");
+
+	data = E1000_READ_REG(hw, E1000_I225_PHPM);
+
+	if (active) {
+		data |= E1000_I225_PHPM_DIS_1000;
+		data |= E1000_I225_PHPM_DIS_2500;
+	} else {
+		data &= ~E1000_I225_PHPM_DIS_1000;
+		data &= ~E1000_I225_PHPM_DIS_2500;
+	}
+
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, data);
+	return E1000_SUCCESS;
+}
+
+/*
+ * e1000_set_d3_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D3 state
+ * @hw: pointer to the HW structure
+ * @active: true to enable LPLU, false to disable
+ *
+ * Note: since I225 does not actually support LPLU, this function
+ * simply enables/disables 100M, 1G and 2.5G speeds in D3.
+ */
+s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active)
+{
+	u32 data;
+
+	DEBUGFUNC("e1000_set_d3_lplu_state_i225");
+
+	data = E1000_READ_REG(hw, E1000_I225_PHPM);
+
+	if (active) {
+		data |= E1000_I225_PHPM_DIS_100_D3;
+		data |= E1000_I225_PHPM_DIS_1000_D3;
+		data |= E1000_I225_PHPM_DIS_2500_D3;
+	} else {
+		data &= ~E1000_I225_PHPM_DIS_100_D3;
+		data &= ~E1000_I225_PHPM_DIS_1000_D3;
+		data &= ~E1000_I225_PHPM_DIS_2500_D3;
+	}
+
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, data);
+	return E1000_SUCCESS;
+}
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index 8e38b75670..fd79f08216 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -6,5 +6,8 @@
 #define _E1000_I225_H_
 
 s32 e1000_init_hw_i225(struct e1000_hw *hw);
+s32 e1000_setup_copper_link_i225(struct e1000_hw *hw);
+s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active);
+s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active);
 
 #endif
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index cf0a9f21e1..ec012f1733 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -987,9 +987,13 @@ s32 e1000_setup_link_generic(struct e1000_hw *hw)
 	 * based on the EEPROM flow control settings.
 	 */
 	if (hw->fc.requested_mode == e1000_fc_default) {
-		ret_val = e1000_set_default_fc_generic(hw);
-		if (ret_val)
-			return ret_val;
+		if (hw->mac.type == e1000_i225) {
+			hw->fc.requested_mode = e1000_fc_full;
+		} else {
+			ret_val = e1000_set_default_fc_generic(hw);
+			if (ret_val)
+				return ret_val;
+		}
 	}
 
 	/* Save off the requested flow control mode for use later.  Depending
@@ -1637,8 +1641,18 @@ s32 e1000_get_speed_and_duplex_copper_generic(struct e1000_hw *hw, u16 *speed,
 
 	status = E1000_READ_REG(hw, E1000_STATUS);
 	if (status & E1000_STATUS_SPEED_1000) {
-		*speed = SPEED_1000;
-		DEBUGOUT("1000 Mbs, ");
+		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
+		 * and 2.5 Gbps link modes. An additional bit is used
+		 * to differentiate between 1 Gbps and 2.5 Gbps.
+		 */
+		if ((hw->mac.type == e1000_i225) &&
+		    (status & E1000_STATUS_SPEED_2500)) {
+			*speed = SPEED_2500;
+			DEBUGOUT("2500 Mbs, ");
+		} else {
+			*speed = SPEED_1000;
+			DEBUGOUT("1000 Mbs, ");
+		}
 	} else if (status & E1000_STATUS_SPEED_100) {
 		*speed = SPEED_100;
 		DEBUGOUT("100 Mbs, ");
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 4840094066..a7e73112e5 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -1457,6 +1457,7 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 	s32 ret_val;
 	u16 mii_autoneg_adv_reg;
 	u16 mii_1000t_ctrl_reg = 0;
+	u16 aneg_multigbt_an_ctrl = 0;
 
 	DEBUGFUNC("e1000_phy_setup_autoneg");
 
@@ -1475,6 +1476,32 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 			return ret_val;
 	}
 
+	/*
+	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
+	 * at this point. However, in DPDK version of IGC this check was
+	 * removed because it interfered with some i225-based NICs, and it was
+	 * deemed unnecessary because only the i225 NIC would've called this
+	 * code anyway because it was in the IGC driver.
+	 *
+	 * In IGB, it is no longer the case that this code is only called by
+	 * i225 NICs, so it could be argued that the check should've been added
+	 * back. However, as evidenced in the original commit removing the
+	 * check, the removal was causing problems with some i225-based NICs,
+	 * adding it back would've introduced the issue again. It is assumed
+	 * that only i225 will attempt to advertise 2.5G speed anyway, so it is
+	 * hoped that not adding the check will not cause problems.
+	 */
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL) {
+	/* Read the MULTI GBT AN Control Register - reg 7.32 */
+		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+					    MMD_DEVADDR_SHIFT) |
+					    ANEG_MULTIGBT_AN_CTRL,
+					    &aneg_multigbt_an_ctrl);
+
+		if (ret_val)
+			return ret_val;
+	}
+
 	/* Need to parse both autoneg_advertised and fc and set up
 	 * the appropriate PHY registers.  First we will parse for
 	 * autoneg_advertised software override.  Since we can advertise
@@ -1528,6 +1555,18 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		mii_1000t_ctrl_reg |= CR_1000T_FD_CAPS;
 	}
 
+	/* We do not allow the Phy to advertise 2500 Mb Half Duplex */
+	if (phy->autoneg_advertised & ADVERTISE_2500_HALF)
+		DEBUGOUT("Advertise 2500mb Half duplex request denied!\n");
+
+	/* Do we want to advertise 2500 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_2500_FULL) {
+		DEBUGOUT("Advertise 2500mb Full duplex\n");
+		aneg_multigbt_an_ctrl |= CR_2500T_FD_CAPS;
+	} else {
+		aneg_multigbt_an_ctrl &= ~CR_2500T_FD_CAPS;
+	}
+
 	/* Check for a software override of the flow control settings, and
 	 * setup the PHY advertisement registers accordingly.  If
 	 * auto-negotiation is enabled, then software will have to set the
@@ -1592,6 +1631,28 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
 					     mii_1000t_ctrl_reg);
 
+	/*
+	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
+	 * at this point. However, in DPDK version of IGC this check was
+	 * removed because it interfered with some i225-based NICs, and it was
+	 * deemed unnecessary because only the i225 NIC would've called this
+	 * code anyway because it was in the IGC driver.
+	 *
+	 * In IGB, it is no longer the case that this code is only called by
+	 * i225 NICs, so it could be argued that the check should've been added
+	 * back. However, as evidenced in the original commit removing the
+	 * check, the removal was causing problems with some i225-based NICs,
+	 * adding it back would've introduced the issue again. It is assumed
+	 * that only i225 will attempt to advertise 2.5G speed anyway, so it is
+	 * hoped that not adding the check will not cause problems.
+	 */
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL)
+		ret_val = phy->ops.write_reg(hw,
+					     (STANDARD_AN_REG_MASK <<
+					     MMD_DEVADDR_SHIFT) |
+					     ANEG_MULTIGBT_AN_CTRL,
+					     aneg_multigbt_an_ctrl);
+
 	return ret_val;
 }
 
@@ -1848,6 +1909,8 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 			case M88E1543_E_PHY_ID:
 			case M88E1512_E_PHY_ID:
 			case I210_I_PHY_ID:
+			case I225_I_PHY_ID:
+			case I226_LM_PHY_ID:
 				reset_dsp = false;
 				break;
 			default:
@@ -1889,6 +1952,9 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 	if (hw->phy.id == I210_I_PHY_ID)
 		return E1000_SUCCESS;
+	if (hw->phy.id == I225_I_PHY_ID ||
+		hw->phy.id == I226_LM_PHY_ID)
+		return E1000_SUCCESS;
 	if ((hw->phy.id == M88E1543_E_PHY_ID) ||
 	    (hw->phy.id == M88E1512_E_PHY_ID))
 		return E1000_SUCCESS;
@@ -2416,7 +2482,7 @@ s32 e1000_get_cable_length_m88(struct e1000_hw *hw)
 s32 e1000_get_cable_length_m88_gen2(struct e1000_hw *hw)
 {
 	struct e1000_phy_info *phy = &hw->phy;
-	s32 ret_val;
+	s32 ret_val  = 0;
 	u16 phy_data, phy_data2, is_cm;
 	u16 index, default_page;
 
@@ -2444,6 +2510,9 @@ s32 e1000_get_cable_length_m88_gen2(struct e1000_hw *hw)
 		phy->max_cable_length = phy_data / (is_cm ? 100 : 1);
 		phy->cable_length = phy_data / (is_cm ? 100 : 1);
 		break;
+	case I225_I_PHY_ID:
+	case I226_LM_PHY_ID:
+		break;
 	case M88E1543_E_PHY_ID:
 	case M88E1512_E_PHY_ID:
 	case M88E1340M_E_PHY_ID:
@@ -2849,6 +2918,10 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
+	if (hw->mac.type == e1000_i225) {
+		E1000_READ_REG(hw, E1000_I225_PHPM);
+	}
+
 	ctrl = E1000_READ_REG(hw, E1000_CTRL);
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_PHY_RST);
 	E1000_WRITE_FLUSH(hw);
@@ -2858,6 +2931,16 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl);
 	E1000_WRITE_FLUSH(hw);
 
+	if (hw->mac.type == e1000_i225) {
+		u32 phpm = 0, timeout = 10000;
+		/* SW should guarantee 100us for the completion of the PHY reset */
+		usec_delay(100);
+		do {
+			phpm = E1000_READ_REG(hw, E1000_I225_PHPM);
+			timeout--;
+			usec_delay(1);
+		} while (!(phpm & E1000_PHY_RST_COMP) && timeout);
+	}
 	usec_delay(150);
 
 	phy->ops.release(hw);
@@ -3486,6 +3569,7 @@ void e1000_power_up_phy_copper(struct e1000_hw *hw)
 	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
 	mii_reg &= ~MII_CR_POWER_DOWN;
 	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
+	usec_delay(300);
 }
 
 /**
diff --git a/drivers/net/intel/e1000/base/e1000_phy.h b/drivers/net/intel/e1000/base/e1000_phy.h
index 81c5308589..87b4d407e5 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.h
+++ b/drivers/net/intel/e1000/base/e1000_phy.h
@@ -120,6 +120,17 @@ s32 e1000_write_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr,
 #define GS40G_MAC_SPEED_1G		0X0006
 #define GS40G_COPPER_SPEC		0x0010
 
+#define E1000_I225_PHPM			0x0E14 /* I225 PHY Power Management */
+#define E1000_I225_PHPM_DIS_1000_D3	0x0008 /* Disable 1G in D3 */
+#define E1000_I225_PHPM_LINK_ENERGY	0x0010 /* Link Energy Detect */
+#define E1000_I225_PHPM_GO_LINKD	0x0020 /* Go Link Disconnect */
+#define E1000_I225_PHPM_DIS_1000	0x0040 /* Disable 1G globally */
+#define E1000_I225_PHPM_SPD_B2B_EN	0x0080 /* Smart Power Down Back2Back */
+#define E1000_I225_PHPM_RST_COMPL	0x0100 /* PHY Reset Completed */
+#define E1000_I225_PHPM_DIS_100_D3	0x0200 /* Disable 100M in D3 */
+#define E1000_I225_PHPM_ULP		0x0400 /* Ultra Low-Power Mode */
+#define E1000_I225_PHPM_DIS_2500	0x0800 /* Disable 2.5G globally */
+#define E1000_I225_PHPM_DIS_2500_D3	0x1000 /* Disable 2.5G in D3 */
 /* BM/HV Specific Registers */
 #define BM_PORT_CTRL_PAGE		769
 #define BM_WUC_PAGE			800
-- 
2.43.5

