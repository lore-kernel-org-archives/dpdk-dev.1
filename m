Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9FDCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D819840695;
	Wed, 20 May 2026 14:53:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id C5EFF4067D
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281605; x=1810817605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lsCelWGKz0fnvuu6ouo/rthyrfVMj4hfoPipQkOf2GI=;
 b=XdbygefkPqA4xV+pAkgKr4biPWbRV0mIKzvPxRtUF7+a1jisXxOaNuax
 dGC+TgiMIbMLR3vTGcnTNAAoHUpuenpioeuk6NZUgarzEn6+06JPmCZrR
 p/C6QLN/DfDC034MuXK8lsqBW4PO/tXZBWelZEOBX65zB1qbiCoJnxU+x
 QEu/mFyp48WG0XkrgUAwCGBeZmX0A4EtCYfkaNCXJu4iY5Gs2rSSy9GnN
 wTXTYdTpaVpIoIwerEHQpczG/6S8li67eZ9tYq8VXNJBeUUsiDZmq1lKd
 gL6eA/CNWJ9NHQeY4083YNAMXjWlaK6Wvrk2uq39O/RY6GgJyJoOcQyIk Q==;
X-CSE-ConnectionGUID: cI3HB91nRfKIMIJ4jCRwsg==
X-CSE-MsgGUID: l5/K+Jw0SuuUn3eHIiDQ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570287"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:24 -0700
X-CSE-ConnectionGUID: AoCHw/M2TH23BjYmlgLV6A==
X-CSE-MsgGUID: ePZm4a7PSNSUKPUlvyv9ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908312"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Mateusz Fryze <mateusz.fryze@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 09/10] net/e1000/base: auto-negotiation status for 1000BASE-T
Date: Wed, 20 May 2026 12:52:46 +0000
Message-ID: <20260520125256.354336-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Mateusz Fryze <mateusz.fryze@intel.com>

Add functionality to find auto-negotiation status on 1000BASE-T PHYs
based on specific PHY registers.

Signed-off-by: Mateusz Fryze <mateusz.fryze@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 .mailmap                                     |  1 +
 drivers/net/intel/e1000/base/e1000_82575.c   |  1 +
 drivers/net/intel/e1000/base/e1000_api.c     | 16 ++++
 drivers/net/intel/e1000/base/e1000_api.h     |  1 +
 drivers/net/intel/e1000/base/e1000_defines.h | 22 ++++++
 drivers/net/intel/e1000/base/e1000_hw.h      |  9 +++
 drivers/net/intel/e1000/base/e1000_phy.c     | 81 ++++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_phy.h     |  2 +
 8 files changed, 133 insertions(+)

diff --git a/.mailmap b/.mailmap
index f3130df686..4a211b1211 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1033,6 +1033,7 @@ Masoud Hasanifard <masoudhasanifard@gmail.com>
 Masoumeh Farhadi Nia <masoumeh.farhadinia@gmail.com>
 Matan Azrad <matan@nvidia.com> <matan@mellanox.com>
 Matej Vido <matejvido@gmail.com> <vido@cesnet.cz>
+Mateusz Fryze <mateusz.fryze@intel.com>
 Mateusz Kowalski <mateusz.kowalski@intel.com>
 Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index 8ae2b77d5f..a2b563975e 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -233,6 +233,7 @@ STATIC s32 e1000_init_phy_params_82575(struct e1000_hw *hw)
 		phy->ops.set_d3_lplu_state = e1000_set_d3_lplu_state_82580;
 		phy->ops.force_speed_duplex =
 				e1000_phy_force_speed_duplex_82577;
+		phy->ops.get_an_status = e1000_1gbase_t_autoneg_status;
 		break;
 	case I210_I_PHY_ID:
 		phy->type		= e1000_phy_i210;
diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index a7877613e3..83b3d6c439 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -1138,6 +1138,22 @@ s32 e1000_get_phy_info(struct e1000_hw *hw)
 	return E1000_SUCCESS;
 }
 
+/**
+ *  e1000_get_an_status - Finds Auto-negotiation status based on PHY registers
+ *  @hw: pointer to the HW structure
+ *  @an_status: AN status
+ *
+ *  This function gets information from the PHY specific registers to determine
+ *  Auto-negotiation status.
+ **/
+s32 e1000_get_an_status(struct e1000_hw *hw, u8 *an_status)
+{
+	if (hw->phy.ops.get_an_status)
+		return hw->phy.ops.get_an_status(hw, an_status);
+
+	return E1000_SUCCESS;
+}
+
 /**
  *  e1000_phy_hw_reset - Hard PHY reset
  *  @hw: pointer to the HW structure
diff --git a/drivers/net/intel/e1000/base/e1000_api.h b/drivers/net/intel/e1000/base/e1000_api.h
index ca3248c214..1f81f49bd5 100644
--- a/drivers/net/intel/e1000/base/e1000_api.h
+++ b/drivers/net/intel/e1000/base/e1000_api.h
@@ -59,6 +59,7 @@ s32 e1000_write_phy_reg(struct e1000_hw *hw, u32 offset, u16 data);
 s32 e1000_write_8bit_ctrl_reg(struct e1000_hw *hw, u32 reg, u32 offset,
 			      u8 data);
 s32 e1000_get_phy_info(struct e1000_hw *hw);
+s32 e1000_get_an_status(struct e1000_hw *hw, u8 *an_status);
 void e1000_release_phy(struct e1000_hw *hw);
 s32 e1000_acquire_phy(struct e1000_hw *hw);
 s32 e1000_cfg_on_link_up(struct e1000_hw *hw);
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 6c710300a6..ba12dde770 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1103,6 +1103,28 @@
 #define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
 #define PHY_EXT_STATUS		0x0F /* Extended Status Reg */
 
+/* PHY Status Register */
+#define PHY_STATUS_LINK_STATUS_SHIFT		2
+#define PHY_STATUS_AN_ABILITY_SHIFT			3
+#define PHY_STATUS_REMOTE_FAULT_SHIFT		4
+#define PHY_STATUS_AN_COMPLETE_SHIFT		5
+#define PHY_STATUS_LINK_STATUS_MASK			(0x01 << PHY_STATUS_LINK_STATUS_SHIFT)
+#define PHY_STATUS_AN_ABILITY_MASK			(0x01 << PHY_STATUS_AN_ABILITY_SHIFT)
+#define PHY_STATUS_REMOTE_FAULT_MASK		(0x01 << PHY_STATUS_REMOTE_FAULT_SHIFT)
+#define PHY_STATUS_AN_COMPLETE_MASK			(0x01 << PHY_STATUS_AN_COMPLETE_SHIFT)
+
+/* Auto negotiation Expansion Register */
+#define PHY_AUTONEG_EXP_LP_AN_ABLE_SHIFT			0
+#define PHY_AUTONEG_EXP_PAGE_RECVD_SHIFT			1
+#define PHY_AUTONEG_EXP_NEXT_PAGE_ABLE_SHIFT		2
+#define PHY_AUTONEG_EXP_LP_NEXT_PAGE_ABLE_SHIFT		3
+#define PHY_AUTONEG_EXP_PARALLEL_DETECT_FLT_SHIFT	4
+#define PHY_AUTONEG_EXP_LP_AN_ABLE_MASK			(0x01 << PHY_AUTONEG_EXP_LP_AN_ABLE_SHIFT)
+#define PHY_AUTONEG_EXP_PAGE_RECVD_MASK			(0x01 << PHY_AUTONEG_EXP_PAGE_RECVD_SHIFT)
+#define PHY_AUTONEG_EXP_NEXT_PAGE_ABLE_MASK	(0x01 << PHY_AUTONEG_EXP_NEXT_PAGE_ABLE_SHIFT)
+#define PHY_AUTONEG_EXP_LP_NEXT_PAGE_ABLE_MASK	(0x01 << PHY_AUTONEG_EXP_LP_NEXT_PAGE_ABLE_SHIFT)
+#define PHY_AUTONEG_EXP_PARALLEL_DETECT_FLT_MASK (0x01 << PHY_AUTONEG_EXP_PARALLEL_DETECT_FLT_SHIFT)
+
 /* PHY GPY 211 registers */
 #define STANDARD_AN_REG_MASK	0x0007 /* MMD */
 #define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 9b1fafd75c..99c2195916 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -409,6 +409,14 @@ enum e1000_serdes_link_state {
 	e1000_serdes_link_forced_up
 };
 
+enum e1000_autoneg_status {
+	e1000_an_off = 0,	/* No conn.; AN unsupported, disabled, or disabled on the LP */
+	e1000_an_failed,	/* Remote Fault or Parallel Detection Fault reported */
+	e1000_an_in_progress,
+	e1000_an_complete,
+	e1000_an_status_unavailable	/* AN status could not be obtained */
+};
+
 enum e1000_invm_structure_type {
 	e1000_invm_uninitialized_structure		= 0x00,
 	e1000_invm_word_autoload_structure		= 0x01,
@@ -803,6 +811,7 @@ struct e1000_phy_operations {
 	s32  (*write_reg_page)(struct e1000_hw *, u32, u16);
 	void (*power_up)(struct e1000_hw *);
 	void (*power_down)(struct e1000_hw *);
+	s32  (*get_an_status)(struct e1000_hw *, u8 *);
 	s32 (*read_i2c_byte)(struct e1000_hw *, u8, u8, u8 *);
 	s32 (*write_i2c_byte)(struct e1000_hw *, u8, u8, u8);
 };
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 31ef5089ba..c66ae44e7a 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -63,6 +63,7 @@ void e1000_init_phy_ops_generic(struct e1000_hw *hw)
 	phy->ops.write_reg_page = e1000_null_write_reg;
 	phy->ops.power_up = e1000_null_phy_generic;
 	phy->ops.power_down = e1000_null_phy_generic;
+	phy->ops.get_an_status = e1000_null_an_status;
 	phy->ops.read_i2c_byte = e1000_read_i2c_byte_null;
 	phy->ops.write_i2c_byte = e1000_write_i2c_byte_null;
 	phy->ops.cfg_on_link_up = e1000_null_ops_generic;
@@ -133,6 +134,21 @@ s32 e1000_null_write_reg(struct e1000_hw E1000_UNUSEDARG *hw,
 	return E1000_SUCCESS;
 }
 
+/**
+ *  e1000_null_link_info - No-op function, return 0
+ *  @hw: pointer to the HW structure
+ *  @status: dummy variable
+ **/
+s32 e1000_null_an_status(struct e1000_hw E1000_UNUSEDARG *hw,
+			u8 *status)
+{
+	DEBUGFUNC("e1000_null_an_status");
+	UNREFERENCED_1PARAMETER(hw);
+	*status = e1000_an_status_unavailable;
+
+	return E1000_SUCCESS;
+}
+
 /**
  *  e1000_read_i2c_byte_null - No-op function, return 0
  *  @hw: pointer to hardware structure
@@ -2427,6 +2443,71 @@ STATIC s32 e1000_wait_autoneg(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/**
+ *  e1000_1gbase_t_autoneg_status - Gets information on current AN status.
+ *  @hw: pointer to the HW structure
+ *  @an_status: pointer to the AN status
+ *
+ *  The function finds the Auto-negotiation status of 1000BASE-T PHY based on
+ *  the data from PHY Status (PSTATUS) and Auto–Negotiation Expansion (ANE)
+ *  PHY registers.
+ *
+ *  @note The function will report Auto-negotiation OFF when there is no
+ *  media connected to the port. When used during the PHY reset, it might not
+ *  report a valid status.
+ **/
+s32 e1000_1gbase_t_autoneg_status(struct e1000_hw *hw, u8 *an_status)
+{
+	s32 ret_val = E1000_SUCCESS;
+	u16 phy_reg = 0;
+
+	DEBUGFUNC("e1000_1gbase_t_autoneg_status\n");
+
+	do {
+		*an_status = e1000_an_status_unavailable;
+		ret_val = e1000_read_phy_reg(hw, PHY_STATUS, &phy_reg);
+		if (ret_val) {
+			DEBUGOUT1("Reading PHY STATUS register returned error: %X\n", ret_val);
+			break;
+		}
+
+		if (!(phy_reg & PHY_STATUS_AN_ABILITY_MASK)) {
+			*an_status = e1000_an_off;
+			break;
+		}
+
+		if (phy_reg & (PHY_STATUS_AN_COMPLETE_MASK | PHY_STATUS_LINK_STATUS_MASK)) {
+			*an_status = e1000_an_complete;
+			break;
+		}
+
+		if (phy_reg & PHY_STATUS_REMOTE_FAULT_MASK) {
+			*an_status = e1000_an_failed;
+			break;
+		}
+
+		ret_val = e1000_read_phy_reg(hw, PHY_AUTONEG_EXP, &phy_reg);
+		if (ret_val) {
+			DEBUGOUT1("Reading PHY ANE register returned error: %X\n", ret_val);
+			break;
+		}
+
+		if (!(phy_reg & PHY_AUTONEG_EXP_LP_AN_ABLE_MASK)) {
+			*an_status = e1000_an_off;
+			break;
+		}
+
+		if (phy_reg & PHY_AUTONEG_EXP_PARALLEL_DETECT_FLT_MASK) {
+			*an_status = e1000_an_failed;
+			break;
+		}
+
+		*an_status = e1000_an_in_progress;
+	} while (0);
+
+	return ret_val;
+}
+
 /**
  *  e1000_phy_has_link_generic - Polls PHY for link
  *  @hw: pointer to the HW structure
diff --git a/drivers/net/intel/e1000/base/e1000_phy.h b/drivers/net/intel/e1000/base/e1000_phy.h
index 4c0b93c18f..d8fcc7ae10 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.h
+++ b/drivers/net/intel/e1000/base/e1000_phy.h
@@ -11,6 +11,7 @@ void e1000_null_phy_generic(struct e1000_hw *hw);
 s32  e1000_null_lplu_state(struct e1000_hw *hw, bool active);
 s32  e1000_null_write_reg(struct e1000_hw *hw, u32 offset, u16 data);
 s32  e1000_null_set_page(struct e1000_hw *hw, u16 data);
+s32 e1000_null_an_status(struct e1000_hw *hw, u8 *status);
 s32 e1000_read_i2c_byte_null(struct e1000_hw *hw, u8 byte_offset,
 			     u8 dev_addr, u8 *data);
 s32 e1000_write_i2c_byte_null(struct e1000_hw *hw, u8 byte_offset,
@@ -22,6 +23,7 @@ s32  e1000_check_polarity_ife(struct e1000_hw *hw);
 s32  e1000_check_reset_block_generic(struct e1000_hw *hw);
 s32  e1000_phy_setup_autoneg(struct e1000_hw *hw);
 s32  e1000_copper_link_autoneg(struct e1000_hw *hw);
+s32  e1000_1gbase_t_autoneg_status(struct e1000_hw *hw, u8 *an_status);
 s32  e1000_copper_link_setup_igp(struct e1000_hw *hw);
 s32  e1000_copper_link_setup_m88(struct e1000_hw *hw);
 s32  e1000_copper_link_setup_m88_gen2(struct e1000_hw *hw);
-- 
2.43.0

