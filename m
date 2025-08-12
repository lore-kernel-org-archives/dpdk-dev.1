Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D2C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 17:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BDDB4065B;
	Tue, 12 Aug 2025 19:33:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3E5F7400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 19:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755019980; x=1786555980;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pZzc+DVgZcyu9OVFl+1REDYbhp0GyppBaFVRxrTxBLA=;
 b=gBPNQAhvUkHqIYfWwC5shqG8bHXYBewwrCDowgTMMeWimxiTYMrge5mx
 +0vOccMVrcVBaqpVLTdR6z94Wrhf0ZKwzlnBCmUyzzqnmHFgxHWAkWbqV
 L6Ycyto5edZrmGBnZvP7yg7T7GU9K459oOc1S0BtkUKutVpRL+XPab9LM
 UKXH+VSYWOiBUslbJu9omPyV5LwmdFhF13ZGhE/AIs3o28KADWvqnzr4G
 HUhmczqRoCE9TOyGfiNjB2rVG0bYVyqlUUj8Umlm69cHJzVCK+r+12CD8
 7nFzqMdMdTW+cwi5XqlzxQwhhRNuP4qsKh4ov4ttxhqm33SZQCasThZMc A==;
X-CSE-ConnectionGUID: B0x8HNtCS1O6J6GuJ/IGjw==
X-CSE-MsgGUID: SWimQvTrSnexqqlwNDpkvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74751872"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="74751872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 10:32:59 -0700
X-CSE-ConnectionGUID: VrVyxBHbSWybA3HFL2RtAw==
X-CSE-MsgGUID: P3+bAwf/Tr21RYkzQIUcJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; d="scan'208";a="170472904"
Received: from unknown (HELO silpixa00401176.ger.corp.intel.com)
 ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 10:32:57 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3 2/6] net/ice/base: make set MAC config TC aware
Date: Tue, 12 Aug 2025 17:32:48 +0000
Message-ID: <20250812173252.507954-3-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
References: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
 <20250812173252.507954-1-vladimir.medvedkin@intel.com>
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

Current implementation of the ice_aq_set_mac_cfg() sets Flow Control (FC)
settings such as quanta and threshold only for LFC. This patch makes this
function Traffic Class (TC) aware, so it can configure FC for each TC
individually.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 166 ++++++++++++++++++------
 drivers/net/intel/ice/base/ice_common.h |   3 +
 2 files changed, 127 insertions(+), 42 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 68c873f71c..2645b7295d 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -690,66 +690,121 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 	return 0;
 }
 
-/**
- * ice_fill_tx_timer_and_fc_thresh
- * @hw: pointer to the HW struct
- * @cmd: pointer to MAC cfg structure
- *
- * Add Tx timer and FC refresh threshold info to Set MAC Config AQ command
- * descriptor
- */
-static void
-ice_fill_tx_timer_and_fc_thresh(struct ice_hw *hw,
-				struct ice_aqc_set_mac_cfg *cmd)
+static u16
+ice_get_xoff_pause_quanta(struct ice_hw *hw, u8 tc, bool pfc)
 {
-	u16 fc_thres_val, tx_timer_val;
 	u32 val;
+#define E830_CL01_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL01_PAUSE_QUANTA : E830_PRTMAC_CL01_PAUSE_QUANTA)
+#define E830_CL23_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL23_PAUSE_QUANTA : E830_PRTMAC_CL23_PAUSE_QUANTA)
+#define E830_CL45_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL45_PAUSE_QUANTA : E830_PRTMAC_CL45_PAUSE_QUANTA)
+#define E830_CL67_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL67_PAUSE_QUANTA : E830_PRTMAC_CL67_PAUSE_QUANTA)
 
-	/* We read back the transmit timer and fc threshold value of
-	 * LFC. Thus, we will use index =
-	 * PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX.
-	 *
-	 * Also, because we are operating on transmit timer and fc
-	 * threshold of LFC, we don't turn on any bit in tx_tmr_priority
-	 */
-#define E800_IDX_OF_LFC E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX
+	if ((hw)->mac_type == ICE_MAC_E830) {
+		switch (tc) {
+		case 0:
+		case 1:
+			val = rd32(hw, E830_CL01_PAUSE_QUANTA(hw->port_info));
+			break;
+		case 2:
+		case 3:
+			val = rd32(hw, E830_CL23_PAUSE_QUANTA(hw->port_info));
+			break;
+		case 4:
+		case 5:
+			val = rd32(hw, E830_CL45_PAUSE_QUANTA(hw->port_info));
+			break;
+		case 6:
+		case 7:
+			val = rd32(hw, E830_CL67_PAUSE_QUANTA(hw->port_info));
+			break;
+		}
+
+		val = LE32_TO_CPU(val);
+		if (tc & 0x1)
+			val >>= 16;
+
+	} else {
+		int prio_idx = (pfc) ? tc : E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX;
+		val = LE32_TO_CPU(rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA(prio_idx)) &
+			E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_HSEC_CTL_TX_PAUSE_QUANTA_M);
+	}
+
+	val = CPU_TO_LE32(val);
+	return (u16)val;
+}
+
+
+static u16
+ice_get_xoff_pause_thresh(struct ice_hw *hw, u8 tc, bool pfc)
+{
+	u32 val;
+
+#define E830_CL01_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL01_QUANTA_THRESH : E830_PRTMAC_CL01_QUANTA_THRESH)
+#define E830_CL23_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL23_QUANTA_THRESH : E830_PRTMAC_CL23_QUANTA_THRESH)
+#define E830_CL45_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL45_QUANTA_THRESH : E830_PRTMAC_CL45_QUANTA_THRESH)
+#define E830_CL67_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL67_QUANTA_THRESH : E830_PRTMAC_CL67_QUANTA_THRESH)
 
 	if ((hw)->mac_type == ICE_MAC_E830) {
-		/* Retrieve the transmit timer */
-		val = rd32(hw, E830_PRTMAC_CL01_PAUSE_QUANTA);
-		tx_timer_val = val & E830_PRTMAC_CL01_PAUSE_QUANTA_CL0_PAUSE_QUANTA_M;
-		cmd->tx_tmr_value = CPU_TO_LE16(tx_timer_val);
-
-		/* Retrieve the fc threshold */
-		val = rd32(hw, E830_PRTMAC_CL01_QUANTA_THRESH);
-		fc_thres_val = val & E830_PRTMAC_CL01_QUANTA_THRESH_CL0_QUANTA_THRESH_M;
+		switch (tc) {
+		case 0:
+		case 1:
+			val = rd32(hw, E830_CL01_PAUSE_THRESH(hw->port_info));
+			break;
+		case 2:
+		case 3:
+			val = rd32(hw, E830_CL23_PAUSE_THRESH(hw->port_info));
+			break;
+		case 4:
+		case 5:
+			val = rd32(hw, E830_CL45_PAUSE_THRESH(hw->port_info));
+			break;
+		case 6:
+		case 7:
+			val = rd32(hw, E830_CL67_PAUSE_THRESH(hw->port_info));
+			break;
+		}
+
+		val = LE32_TO_CPU(val);
+		if (tc & 0x1)
+			val >>= 16;
+
 	} else {
-		/* Retrieve the transmit timer */
-		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA(E800_IDX_OF_LFC));
-		tx_timer_val = val &
-			E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_HSEC_CTL_TX_PAUSE_QUANTA_M;
-		cmd->tx_tmr_value = CPU_TO_LE16(tx_timer_val);
-
-		/* Retrieve the fc threshold */
-		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER(E800_IDX_OF_LFC));
-		fc_thres_val = val & E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_M;
+		int prio_idx = (pfc) ? tc : E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_MAX_INDEX;
+		val = LE32_TO_CPU(rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER(prio_idx)) &
+			E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_M);
 	}
 
-	cmd->fc_refresh_threshold = CPU_TO_LE16(fc_thres_val);
+	val = CPU_TO_LE32(val);
+	return (u16)val;
 }
 
 /**
- * ice_aq_set_mac_cfg
+ * ice_aq_set_mac_pfc_cfg
  * @hw: pointer to the HW struct
  * @max_frame_size: Maximum Frame Size to be supported
+ * @tc_bitmap: Traffic Class bitmap indicating relevant TCs for the following XOFF settings
+ *             0 is used of LFC.
+ *             If any of XOFF settings is zero tc_bitmap must have not more than one bit.
+ * @xoff_quanta: FC XOFF Pause quanta, measured in 64byte slots. 0 means keep current value
+ * @xoff_thresh: FC XOFF Pause refresh threshold, specifies how many slots (64 byte) time
+ *               before XOFF expires to send a new XOFF if CGD is still in a blocked state.
+ *               0 means keep current value
  * @auto_drop: Tell HW to drop packets if TC queue is blocked
  * @cd: pointer to command details structure or NULL
  *
  * Set MAC configuration (0x0603)
  */
 int
-ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
-		   struct ice_sq_cd *cd)
+ice_aq_set_mac_pfc_cfg(struct ice_hw *hw, u16 max_frame_size, u8 tc_bitmap,
+	u16 xoff_quanta, u16 xoff_thresh, bool auto_drop, struct ice_sq_cd *cd)
 {
 	struct ice_aqc_set_mac_cfg *cmd;
 	struct ice_aq_desc desc;
@@ -759,17 +814,44 @@ ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
 	if (max_frame_size == 0)
 		return ICE_ERR_PARAM;
 
+	if ((xoff_quanta == 0 || xoff_thresh == 0) && tc_bitmap != 0 &&
+			(__builtin_popcount(tc_bitmap) > 1))
+		return ICE_ERR_PARAM;
+
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_mac_cfg);
 
 	cmd->max_frame_size = CPU_TO_LE16(max_frame_size);
 
 	if (ice_is_fw_auto_drop_supported(hw) && auto_drop)
 		cmd->drop_opts |= ICE_AQ_SET_MAC_AUTO_DROP_BLOCKING_PKTS;
-	ice_fill_tx_timer_and_fc_thresh(hw, cmd);
+
+	cmd->tx_tmr_priority = tc_bitmap;
+	cmd->tx_tmr_value = (xoff_quanta) ? CPU_TO_LE16(xoff_quanta) :
+		ice_get_xoff_pause_quanta(hw,
+			(tc_bitmap) ? __builtin_ctz(tc_bitmap) : 0, !!tc_bitmap);
+	cmd->fc_refresh_threshold = (xoff_thresh) ? CPU_TO_LE16(xoff_thresh) :
+		ice_get_xoff_pause_thresh(hw,
+			(tc_bitmap) ? __builtin_ctz(tc_bitmap) : 0, !!tc_bitmap);
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
 
+/**
+ * ice_aq_set_mac_cfg
+ * @hw: pointer to the HW struct
+ * @max_frame_size: Maximum Frame Size to be supported
+ * @auto_drop: Tell HW to drop packets if TC queue is blocked
+ * @cd: pointer to command details structure or NULL
+ *
+ * Set MAC configuration (0x0603)
+ */
+int
+ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
+		  struct ice_sq_cd *cd)
+{
+	return ice_aq_set_mac_pfc_cfg(hw, max_frame_size, 0, 0, 0, auto_drop, cd);
+}
+
 /**
  * ice_init_fltr_mgmt_struct - initializes filter management list and locks
  * @hw: pointer to the HW struct
diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
index 77ceccc6bd..884b8f7834 100644
--- a/drivers/net/intel/ice/base/ice_common.h
+++ b/drivers/net/intel/ice/base/ice_common.h
@@ -223,6 +223,9 @@ int
 ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
 		   struct ice_sq_cd *cd);
 int
+ice_aq_set_mac_pfc_cfg(struct ice_hw *hw, u16 max_frame_size, u8 tc_bitmap, u16 xoff_quanta,
+	u16 xoff_thresh, bool auto_drop, struct ice_sq_cd *cd);
+int
 ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 		     struct ice_link_status *link, struct ice_sq_cd *cd);
 int
-- 
2.43.0

