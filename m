Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C9CC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA3F42EDB;
	Fri,  7 Feb 2025 13:46:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2A5E242EB6
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932396; x=1770468396;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IyZLiX9tMaBBV+mfASyYvDW/zFYx6X1Pj6KWfNt8N8w=;
 b=fGaO3F3Kth/ESY5MCMF1qnhoEKZKckSmcgXLrvi14TH6iKbI7auVIBBg
 3hhzpRzvcFShKgw7BPEfYW4d/cdRi4pHfGQ12l0uk1vw8L06e2yOS2GDh
 zbRXNa//HigNYROGIUfaQzYaqZYyjj/HM0ogrgSC+5KsASagBv7WHCjnN
 6/eufMVSgksTXAco3h+BWNLEu/46C+gAoHh2m2u7vk9BU8sOvEg0YM/ZZ
 Uro4l37xyYtQm64FSHZhu+kMKZyuC+kxcbZxiCasSs6FxPmd+W2ieUYKc
 4+6BOHI/UCwlDuWYwH7ZcEECaFK9CAiZDZsdtOh2etb4VDzBHyIHMpyCd A==;
X-CSE-ConnectionGUID: 1UiGESvDT2u+cxzMnDf3kg==
X-CSE-MsgGUID: UL7gRDPtTiGS8zYTNeu73A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331887"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331887"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:35 -0800
X-CSE-ConnectionGUID: mZ0fGTHqSu28+nWdiKrPow==
X-CSE-MsgGUID: oSZeKnW1RO+YpEI3fHiWQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953841"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 34/36] net/e1000/base: add PHY read/write retry mechanism
Date: Fri,  7 Feb 2025 12:45:26 +0000
Message-ID: <3a5e004d9906c360c73d3cbda77804cf733e6bb2.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Sporadic MDI errors are observed on some platforms. To address them, a
read/write retry mechanism is introduced. Set the initial retry counter
to 3 with an option to disable/enable the mechanism for some specific
flows that errors are expected.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h      |   1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c |  34 ++++
 drivers/net/intel/e1000/base/e1000_phy.c     | 195 ++++++++++++-------
 drivers/net/intel/e1000/base/e1000_phy.h     |   2 +
 4 files changed, 157 insertions(+), 75 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 4bc5a8e0f2..9b1fafd75c 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -888,6 +888,7 @@ struct e1000_phy_info {
 	u32 id;
 	u32 reset_delay_us; /* in usec */
 	u32 revision;
+	u32 current_retry_counter;
 
 	enum e1000_media_type media_type;
 
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 1b30aa5cc6..6b7eb245a6 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -217,11 +217,19 @@ STATIC bool e1000_phy_is_accessible_pchlan(struct e1000_hw *hw)
 		/* Only unforce SMBus if ME is not active */
 		if (!(E1000_READ_REG(hw, E1000_FWSM) &
 		    E1000_ICH_FWSM_FW_VALID)) {
+			/* Switching PHY interface always returns MDI error
+			 * so disable retry mechanism to avoid wasting time
+			 */
+			u32 phy_retries = 0;
+			e1000_disable_phy_retry_mechanism(hw, &phy_retries);
+
 			/* Unforce SMBus mode in PHY */
 			hw->phy.ops.read_reg_locked(hw, CV_SMB_CTRL, &phy_reg);
 			phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 			hw->phy.ops.write_reg_locked(hw, CV_SMB_CTRL, phy_reg);
 
+			e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 			/* Unforce SMBus mode in MAC */
 			mac_reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
 			mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
@@ -287,6 +295,7 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 {
 	u32 mac_reg, fwsm = E1000_READ_REG(hw, E1000_FWSM);
 	s32 ret_val;
+	u32 phy_retries = 0;
 
 	DEBUGFUNC("e1000_init_phy_workarounds_pchlan");
 
@@ -306,6 +315,11 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		goto out;
 	}
 
+	/* There is no guarantee that the PHY is accessible at this time
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000_disable_phy_retry_mechanism(hw, &phy_retries);
+
 	/* The MAC-PHY interconnect may be in SMBus mode.  If the PHY is
 	 * inaccessible and resetting the PHY is not blocked, toggle the
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
@@ -374,6 +388,8 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		break;
 	}
 
+	e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 	hw->phy.ops.release(hw);
 	if (!ret_val) {
 
@@ -450,6 +466,8 @@ STATIC s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 
 	phy->id = e1000_phy_unknown;
 
+	if (hw->mac.type == e1000_pch_mtp)
+		phy->current_retry_counter = 2;
 	ret_val = e1000_init_phy_workarounds_pchlan(hw);
 	if (ret_val)
 		return ret_val;
@@ -1141,6 +1159,12 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (hw->dev_spec.ich8lan.smbus_disable)
 		goto skip_smbus;
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	u32 phy_retries = 0;
+	e1000_disable_phy_retry_mechanism(hw, &phy_retries);
+
 	/* Force SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val)
@@ -1148,6 +1172,8 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 	/* Force SMBus mode in MAC */
 	mac_reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
@@ -1353,6 +1379,12 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 		/* Toggle LANPHYPC Value bit */
 		e1000_toggle_lanphypc_pch_lpt(hw);
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	u32 phy_retries = 0;
+	e1000_disable_phy_retry_mechanism(hw, &phy_retries);
+
 	/* Unforce SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val) {
@@ -1373,6 +1405,8 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 	/* Unforce SMBus mode in MAC */
 	mac_reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 492e83c6c1..b449c6ef42 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -253,6 +253,22 @@ s32 e1000_phy_reset_dsp_generic(struct e1000_hw *hw)
 	return hw->phy.ops.write_reg(hw, M88E1000_PHY_GEN_CONTROL, 0);
 }
 
+void e1000_disable_phy_retry_mechanism(struct e1000_hw* hw, u32* phy_retries_original)
+{
+	DEBUGFUNC("e1000_disable_phy_retry_mechanism");
+
+	*phy_retries_original = hw->phy.current_retry_counter;
+
+	hw->phy.current_retry_counter = 0;
+}
+
+void e1000_enable_phy_retry_mechanism(struct e1000_hw* hw, u32 phy_retries_original)
+{
+	DEBUGFUNC("e1000_enable_phy_retry_mechanism");
+
+	hw->phy.current_retry_counter = phy_retries_original;
+}
+
 /**
  *  e1000_read_phy_reg_mdic - Read MDI control register
  *  @hw: pointer to the HW structure
@@ -265,7 +281,8 @@ s32 e1000_phy_reset_dsp_generic(struct e1000_hw *hw)
 s32 e1000_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 {
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	u32 i, mdic = 0, retry_counter;
+	bool success;
 
 	DEBUGFUNC("e1000_read_phy_reg_mdic");
 
@@ -278,45 +295,59 @@ s32 e1000_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_READ));
-
-	E1000_WRITE_REG(hw, E1000_MDIC, mdic);
-
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		usec_delay_irq(50);
-		mdic = E1000_READ_REG(hw, E1000_MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		DEBUGOUT("MDI Read did not complete\n");
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		DEBUGOUT("MDI Error\n");
-		return -E1000_ERR_PHY;
-	}
-	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
-		DEBUGOUT2("MDI Read offset error - requested %d, returned %d\n",
-			  offset,
-			  (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
-		return -E1000_ERR_PHY;
+
+	for (retry_counter = 0; retry_counter <= hw->phy.current_retry_counter; retry_counter++) {
+		success = true;
+
+		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_READ));
+
+		E1000_WRITE_REG(hw, E1000_MDIC, mdic);
+
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usec_delay_irq(50);
+			mdic = E1000_READ_REG(hw, E1000_MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			DEBUGOUT("MDI Read did not complete\n");
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			DEBUGOUT("MDI Error\n");
+			success = false;
+		}
+		if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
+			DEBUGOUT2("MDI Read offset error - requested %d, returned %d\n",
+				offset,
+				(mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
+			success = false;
+		}
+
+		 /* Allow some time after each MDIC transaction to avoid
+		  * reading duplicate data in the next MDIC transaction.
+		  */
+		if (hw->mac.type == e1000_pch2lan)
+			usec_delay_irq(100);
+
+		if (success) {
+			*data = (u16)mdic;
+			return E1000_SUCCESS;
+		}
+		if (retry_counter != hw->phy.current_retry_counter) {
+			DEBUGOUT("Perform retry on PHY transaction...\n");
+			msec_delay_irq(10);
+		}
 	}
-	*data = (u16) mdic;
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		usec_delay_irq(100);
 
-	return E1000_SUCCESS;
+	return -E1000_ERR_PHY;
 }
 
 /**
@@ -330,7 +361,8 @@ s32 e1000_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 s32 e1000_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 {
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	u32 i, mdic = 0, retry_counter;
+	bool success;
 
 	DEBUGFUNC("e1000_write_phy_reg_mdic");
 
@@ -343,45 +375,58 @@ s32 e1000_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = (((u32)data) |
-		(offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_WRITE));
-
-	E1000_WRITE_REG(hw, E1000_MDIC, mdic);
-
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		usec_delay_irq(50);
-		mdic = E1000_READ_REG(hw, E1000_MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		DEBUGOUT("MDI Write did not complete\n");
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		DEBUGOUT("MDI Error\n");
-		return -E1000_ERR_PHY;
-	}
-	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
-		DEBUGOUT2("MDI Write offset error - requested %d, returned %d\n",
-			  offset,
-			  (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
-		return -E1000_ERR_PHY;
-	}
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		usec_delay_irq(100);
+	for (retry_counter = 0; retry_counter <= hw->phy.current_retry_counter; retry_counter++) {
+		success = true;
+
+		mdic = (((u32)data) |
+			(offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_WRITE));
+
+		E1000_WRITE_REG(hw, E1000_MDIC, mdic);
+
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usec_delay_irq(50);
+			mdic = E1000_READ_REG(hw, E1000_MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			DEBUGOUT("MDI Write did not complete\n");
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			DEBUGOUT("MDI Error\n");
+			success = false;
+		}
+		if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
+			DEBUGOUT2("MDI Write offset error - requested %d, returned %d\n",
+				offset,
+				(mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
+			success = false;
+		}
+
+		 /* Allow some time after each MDIC transaction to avoid
+		  * reading duplicate data in the next MDIC transaction.
+		  */
+		if (hw->mac.type == e1000_pch2lan)
+			usec_delay_irq(100);
+
+		if (success)
+			return E1000_SUCCESS;
+
+		if (retry_counter != hw->phy.current_retry_counter) {
+			DEBUGOUT("Perform retry on PHY transaction...\n");
+			msec_delay_irq(10);
+		}
+	}
 
-	return E1000_SUCCESS;
+	return -E1000_ERR_PHY;
 }
 
 /**
diff --git a/drivers/net/intel/e1000/base/e1000_phy.h b/drivers/net/intel/e1000/base/e1000_phy.h
index f15f45011f..4c0b93c18f 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.h
+++ b/drivers/net/intel/e1000/base/e1000_phy.h
@@ -68,6 +68,8 @@ s32  e1000_read_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 *data);
 s32  e1000_write_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 data);
 void e1000_power_up_phy_copper(struct e1000_hw *hw);
 void e1000_power_down_phy_copper(struct e1000_hw *hw);
+void e1000_disable_phy_retry_mechanism(struct e1000_hw *hw, u32 *phy_retries_original);
+void e1000_enable_phy_retry_mechanism(struct e1000_hw *hw, u32 phy_retries_original);
 s32  e1000_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data);
 s32  e1000_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data);
 s32  e1000_read_phy_reg_i2c(struct e1000_hw *hw, u32 offset, u16 *data);
-- 
2.43.5

