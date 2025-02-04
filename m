Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F51AC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91AC342E56;
	Tue,  4 Feb 2025 16:12:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A04DD427E4
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681945; x=1770217945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=byvRaAnA/VnhrE9lsd/tM0VpF7tRxTWS5IAfo4UPaXs=;
 b=BcVR2h0+fZeej4v/g7fe/x2fS3TPVuKIR2+pQ1rt8wtytpMWYOcLW95o
 fHDspoYLPCnEtnrjNKac4sj60lk8t7ro6gd3be+Fwyg1H4TWcbuQLoWTU
 JDMMbwTd99O85P1lQKVTFYaI+XL3EBdtp1YB8fbSxIlbItUYWd5OFUsFi
 8IynmwAX2ulep7B2J7jWQ90UWTidUjGLgmdkKJO0/Y3qMhdl/nv4fSq0e
 DYczUvHFl/NgGdyHZkeNW0046tZZhelqNB2EYmy5naY4RCmAP7phiOmz1
 h+cx2rf9oWyOk/0DK8/lFSqwYEGpEt2NkgflcdONPZtgzykiaIUo5CRKJ w==;
X-CSE-ConnectionGUID: rc4ZTcQ1RCKjatJiZtMJ2A==
X-CSE-MsgGUID: 6ts9lY9yRfuOa+XuIbSAwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097182"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097182"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:25 -0800
X-CSE-ConnectionGUID: vHtZWsGjS+Ol+1W2kstJXg==
X-CSE-MsgGUID: VZs6VIvcSz6a5hplFMaANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792771"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 45/54] net/e1000/base: add PHY read/write retry mechanism
Date: Tue,  4 Feb 2025 15:10:51 +0000
Message-ID: <0377d57a8e4c254aa4201245e11bef9754bb7adb.1738681726.git.anatoly.burakov@intel.com>
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
index 01cda7ddeb..c3449a3f45 100644
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
@@ -1139,6 +1157,12 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
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
@@ -1146,6 +1170,8 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 	/* Force SMBus mode in MAC */
 	mac_reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
@@ -1351,6 +1377,12 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
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
@@ -1371,6 +1403,8 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000_enable_phy_retry_mechanism(hw, phy_retries);
+
 	/* Unforce SMBus mode in MAC */
 	mac_reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index b29f616b38..06505d855e 100644
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

