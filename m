Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD304C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B27442D80;
	Fri, 31 Jan 2025 13:59:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 63846427AC
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328369; x=1769864369;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=neCD/TdSi19cJO5gAemN9AJOuNuSmlk71CI7SrD6ARw=;
 b=RDNRiK8vtGILWpNti/5NoNRoW2ekHYLOaHB+TWOeA3i1Sc8hplsN11Yj
 b+Vwh/4GgiHjQtWb20vC/NmwV4DtwYjLk6o4NlLqnYcdqMTFWOiZY7/Tb
 siJRZCS9G1HAeyJrajplTSbvoCRnm+teMknmcpIyf6MQiTkzTWgsZAwqV
 +30l1zkK09waXp2iHWhlNkAzy18VHswY7CNqZgVUulV3sM0BQ2O2NcmoJ
 Z6UAf5WiGrHXfJTG9snSW8JwomlVvZDbg6HpcpONCt6VJDBfK8LgIsdIr
 dOq7VqnFi/NbyAWrnmDHjVu9LnbnxyUttu+7IRIAYMB1pwhLbivMKsOZx w==;
X-CSE-ConnectionGUID: v9qu/U7ERRWbVo/mrkc7OA==
X-CSE-MsgGUID: lD15mz8iSJGeFr7RbjNN9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315616"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315616"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:28 -0800
X-CSE-ConnectionGUID: o0UEn7lZQAmaB+c8OIuGgQ==
X-CSE-MsgGUID: RUFafSrFR0qQsmSiurYuLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503353"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 06/42] net/e1000/base: add LTR support in i225
Date: Fri, 31 Jan 2025 12:58:19 +0000
Message-ID: <0ba8b622e01876dc7f63c93cdda637182eaeae9a.1738328107.git.anatoly.burakov@intel.com>
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

Enable Latency Tolerance Reporting (LTR) code and add its associated
definitions for i225. This is mostly identical to IGC driver, with some
minor differences due to the way IGC driver was originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  31 +++
 drivers/net/intel/e1000/base/e1000_i225.c    | 188 ++++++++++++++++++-
 drivers/net/intel/e1000/base/e1000_i225.h    |   2 +
 drivers/net/intel/e1000/base/e1000_regs.h    |   3 +-
 4 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 49e4f6c7cc..10009d7a19 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1491,6 +1491,37 @@
 #define I210_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
 #define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 
+#define E1000_LTRC_EEEMS_EN		0x00000020 /* Enable EEE LTR max send */
+/* Minimum time for 1000BASE-T where no data will be transmit following move out
+ * of EEE LPI Tx state
+ */
+#define E1000_TW_SYSTEM_1000_MASK	0x000000FF
+/* Minimum time for 100BASE-T where no data will be transmit following move out
+ * of EEE LPI Tx state
+ */
+#define E1000_TW_SYSTEM_100_MASK	0x0000FF00
+#define E1000_TW_SYSTEM_100_SHIFT	8
+#define E1000_LTRMINV_LTRV_MASK		0x000003FF /* LTR minimum value */
+#define E1000_LTRMAXV_LTRV_MASK		0x000003FF /* LTR maximum value */
+#define E1000_LTRMINV_SCALE_MASK	0x00001C00 /* LTR minimum scale */
+#define E1000_LTRMINV_SCALE_SHIFT	10
+/* Reg val to set scale to 1024 nsec */
+#define E1000_LTRMINV_SCALE_1024	2
+/* Reg val to set scale to 32768 nsec */
+#define E1000_LTRMINV_SCALE_32768	3
+#define E1000_LTRMINV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
+#define E1000_LTRMAXV_SCALE_MASK	0x00001C00 /* LTR maximum scale */
+#define E1000_LTRMAXV_SCALE_SHIFT	10
+/* Reg val to set scale to 1024 nsec */
+#define E1000_LTRMAXV_SCALE_1024	2
+/* Reg val to set scale to 32768 nsec */
+#define E1000_LTRMAXV_SCALE_32768	3
+#define E1000_LTRMAXV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
+
+#define I225_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
+#define I225_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
+#define E1000_RXPBS_SIZE_I225_MASK	0x0000003F /* Rx packet buffer size */
+#define E1000_TXPB0S_SIZE_I225_MASK	0x0000003F /* Tx packet buffer 0 size */
 #define E1000_STM_OPCODE		0xDB00
 #define E1000_EEPROM_FLASH_SIZE_WORD	0x11
 #define INVM_DWORD_TO_RECORD_TYPE(invm_dword) \
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 7c8cf8552d..9a512f3baf 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -102,7 +102,8 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->ops.init_hw = e1000_init_hw_i225;
 	/* link setup */
 	mac->ops.setup_link = e1000_setup_link_generic;
-	mac->ops.check_for_link = e1000_check_for_copper_link_generic;
+	/* check for link */
+	mac->ops.check_for_link = e1000_check_for_link_i225;
 	/* link info */
 	mac->ops.get_link_up_info = e1000_get_speed_and_duplex_copper_generic;
 	/* acquire SW_FW sync */
@@ -907,6 +908,191 @@ s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/* e1000_set_ltr_i225 - Set Latency Tolerance Reporting thresholds.
+ * @hw: pointer to the HW structure
+ * @link: bool indicating link status
+ *
+ * Set the LTR thresholds based on the link speed (Mbps), EEE, and DMAC
+ * settings, otherwise specify that there is no LTR requirement.
+ */
+s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
+{
+	u16 speed, duplex;
+	u32 tw_system, ltrc, ltrv, ltr_min, ltr_max, scale_min, scale_max;
+	s32 size;
+
+	DEBUGFUNC("e1000_set_ltr_i225");
+
+	/* If we do not have link, LTR thresholds are zero. */
+	if (link) {
+		hw->mac.ops.get_link_up_info(hw, &speed, &duplex);
+
+		/* Check if using copper interface with EEE enabled or if the
+		 * link speed is 10 Mbps.
+		 */
+		if ((hw->phy.media_type == e1000_media_type_copper) &&
+		    !(hw->dev_spec._i225.eee_disable) &&
+		     (speed != SPEED_10)) {
+			/* EEE enabled, so send LTRMAX threshold. */
+			ltrc = E1000_READ_REG(hw, E1000_LTRC) |
+				E1000_LTRC_EEEMS_EN;
+			E1000_WRITE_REG(hw, E1000_LTRC, ltrc);
+
+			/* Calculate tw_system (nsec). */
+			if (speed == SPEED_100) {
+				tw_system = ((E1000_READ_REG(hw, E1000_EEE_SU) &
+					     E1000_TW_SYSTEM_100_MASK) >>
+					     E1000_TW_SYSTEM_100_SHIFT) * 500;
+			} else {
+				tw_system = (E1000_READ_REG(hw, E1000_EEE_SU) &
+					     E1000_TW_SYSTEM_1000_MASK) * 500;
+				}
+		} else {
+			tw_system = 0;
+			}
+
+		/* Get the Rx packet buffer size. */
+		size = E1000_READ_REG(hw, E1000_RXPBS) &
+			E1000_RXPBS_SIZE_I225_MASK;
+
+		/* Calculations vary based on DMAC settings. */
+		if (E1000_READ_REG(hw, E1000_DMACR) & E1000_DMACR_DMAC_EN) {
+			size -= (E1000_READ_REG(hw, E1000_DMACR) &
+				 E1000_DMACR_DMACTHR_MASK) >>
+				 E1000_DMACR_DMACTHR_SHIFT;
+			/* Convert size to bits. */
+			size *= 1024 * 8;
+		} else {
+			/* Convert size to bytes, subtract the MTU, and then
+			 * convert the size to bits.
+			 */
+			size *= 1024;
+			size -= hw->dev_spec._i225.mtu;
+			size *= 8;
+		}
+
+		if (size < 0) {
+			DEBUGOUT1("Invalid effective Rx buffer size %d\n",
+				  size);
+			return -E1000_ERR_CONFIG;
+		}
+
+		/* Calculate the thresholds. Since speed is in Mbps, simplify
+		 * the calculation by multiplying size/speed by 1000 for result
+		 * to be in nsec before dividing by the scale in nsec. Set the
+		 * scale such that the LTR threshold fits in the register.
+		 */
+		ltr_min = (1000 * size) / speed;
+		ltr_max = ltr_min + tw_system;
+		scale_min = (ltr_min / 1024) < 1024 ? E1000_LTRMINV_SCALE_1024 :
+			    E1000_LTRMINV_SCALE_32768;
+		scale_max = (ltr_max / 1024) < 1024 ? E1000_LTRMAXV_SCALE_1024 :
+			    E1000_LTRMAXV_SCALE_32768;
+		ltr_min /= scale_min == E1000_LTRMINV_SCALE_1024 ? 1024 : 32768;
+		ltr_min -= 1;
+		ltr_max /= scale_max == E1000_LTRMAXV_SCALE_1024 ? 1024 : 32768;
+		ltr_max -= 1;
+
+		/* Only write the LTR thresholds if they differ from before. */
+		ltrv = E1000_READ_REG(hw, E1000_LTRMINV);
+		if (ltr_min != (ltrv & E1000_LTRMINV_LTRV_MASK)) {
+			ltrv = E1000_LTRMINV_LSNP_REQ | ltr_min |
+			      (scale_min << E1000_LTRMINV_SCALE_SHIFT);
+			E1000_WRITE_REG(hw, E1000_LTRMINV, ltrv);
+		}
+
+		ltrv = E1000_READ_REG(hw, E1000_LTRMAXV);
+		if (ltr_max != (ltrv & E1000_LTRMAXV_LTRV_MASK)) {
+			ltrv = E1000_LTRMAXV_LSNP_REQ | ltr_max |
+			      (scale_max << E1000_LTRMAXV_SCALE_SHIFT);
+			E1000_WRITE_REG(hw, E1000_LTRMAXV, ltrv);
+		}
+	}
+
+	return E1000_SUCCESS;
+}
+
+/* e1000_check_for_link_i225 - Check for link
+ * @hw: pointer to the HW structure
+ *
+ * Checks to see of the link status of the hardware has changed.  If a
+ * change in link status has been detected, then we read the PHY registers
+ * to get the current speed/duplex if link exists.
+ */
+s32 e1000_check_for_link_i225(struct e1000_hw *hw)
+{
+	struct e1000_mac_info *mac = &hw->mac;
+	s32 ret_val;
+	bool link = false;
+
+	DEBUGFUNC("e1000_check_for_link_i225");
+
+	/* We only want to go out to the PHY registers to see if
+	 * Auto-Neg has completed and/or if our link status has
+	 * changed.  The get_link_status flag is set upon receiving
+	 * a Link Status Change or Rx Sequence Error interrupt.
+	 */
+	if (!mac->get_link_status)
+		goto out;
+
+	/* First we want to see if the MII Status Register reports
+	 * link.  If so, then we want to get the current speed/duplex
+	 * of the PHY.
+	 */
+	ret_val = e1000_phy_has_link_generic(hw, 1, 0, &link);
+	if (ret_val)
+		goto out;
+
+	if (!link)
+		goto out; /* No link detected */
+
+	/* First we want to see if the MII Status Register reports
+	 * link.  If so, then we want to get the current speed/duplex
+	 * of the PHY.
+	 */
+	ret_val = e1000_phy_has_link_generic(hw, 1, 0, &link);
+	if (ret_val)
+		goto out;
+
+	if (!link)
+		goto out; /* No link detected */
+
+	mac->get_link_status = false;
+
+	/* Check if there was DownShift, must be checked
+	 * immediately after link-up
+	 */
+	e1000_check_downshift_generic(hw);
+
+	/* If we are forcing speed/duplex, then we simply return since
+	 * we have already determined whether we have link or not.
+	 */
+	if (!mac->autoneg)
+		goto out;
+
+	/* Auto-Neg is enabled.  Auto Speed Detection takes care
+	 * of MAC speed/duplex configuration.  So we only need to
+	 * configure Collision Distance in the MAC.
+	 */
+	mac->ops.config_collision_dist(hw);
+
+	/* Configure Flow Control now that Auto-Neg has completed.
+	 * First, we need to restore the desired flow control
+	 * settings because we may have had to re-autoneg with a
+	 * different link partner.
+	 */
+	ret_val = e1000_config_fc_after_link_up_generic(hw);
+	if (ret_val)
+		DEBUGOUT("Error configuring flow control\n");
+out:
+	/* Now that we are aware of our link settings, we can set the LTR
+	 * thresholds.
+	 */
+	ret_val = e1000_set_ltr_i225(hw, link);
+
+	return ret_val;
+}
+
 /* e1000_init_function_pointers_i225 - Init func ptrs.
  * @hw: pointer to the HW structure
  *
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index be3b1b76eb..cd6e7d0f6f 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -19,6 +19,8 @@ s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
 					 u32 address);
 s32 e1000_id_led_init_i225(struct e1000_hw *hw);
 s32 e1000_blink_led_i225(struct e1000_hw *hw);
+s32 e1000_check_for_link_i225(struct e1000_hw *hw);
+s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link);
 s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 s32 e1000_init_hw_i225(struct e1000_hw *hw);
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index b9d2a4484b..04bb94f819 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -697,6 +697,7 @@
 #define E1000_O2BGPTC	0x08FE4 /* OS2BMC packets received by BMC */
 #define E1000_O2BSPC	0x0415C /* OS2BMC packets transmitted by host */
 
-
+#define E1000_LTRMINV	0x5BB0 /* LTR Minimum Value */
+#define E1000_LTRMAXV	0x5BB4 /* LTR Maximum Value */
 
 #endif
-- 
2.43.5

