Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D68EC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 719A640E09;
	Mon, 11 Aug 2025 15:43:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id AD9EE40DDA
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754919788; x=1786455788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fBTVWKi4KeXWobTcvE16lzpMv1PrERKArKfnKmf9NBk=;
 b=eHUJYTV8i+wtisYjBrIxfwD9Pcrp38w9FA4k+CJwiqGXIY8LZNs4F+57
 Qjwqy/4i6qMir/ToMrGKFfCAJtsxUA4IDFL4CWzMB097OgoiD64EQD2x3
 HWTCya2tiX8Asgb7Rf4mXhFv92SoFRStjl9/C6w6so04/U6gkFBchG6iD
 P/7GzrisHwIFC7EjYTP3rBjITJ5N3ME9d4+TETHvyJqcN9suOnPFD3BH1
 PtctxXNekS23ovlAnXeMMj+yuDGhIEL0Xuu6Kl5+EkP1GTbUlZxDmCbLf
 Zbc2/NR7Wd9tDuosAQy/3ddSXR0pycLn5GILvcKTM5+7tuKSNtm40RH+Q Q==;
X-CSE-ConnectionGUID: GX3WPLkRRyGNVj16QO7H3g==
X-CSE-MsgGUID: HFULRBdwTTOx6Wu66Y5Olg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57041883"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57041883"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 06:43:08 -0700
X-CSE-ConnectionGUID: wFdS94JbR1OD3q5klOFEpw==
X-CSE-MsgGUID: aI8velbxS/6SPkVxMUH+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="171169013"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa004.fm.intel.com with ESMTP; 11 Aug 2025 06:43:06 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v2 2/6] net/ice/base: make set MAC config TC aware
Date: Mon, 11 Aug 2025 13:42:57 +0000
Message-ID: <20250811134301.459523-3-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
 <20250811134301.459523-1-vladimir.medvedkin@intel.com>
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
 drivers/net/intel/ice/base/ice_common.c | 150 +++++++++++++++++-------
 drivers/net/intel/ice/base/ice_common.h |   4 +-
 drivers/net/intel/ice/ice_ethdev.c      |   2 +-
 3 files changed, 111 insertions(+), 45 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 8bca256b34..b2ac9f9324 100644
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
  * ice_aq_set_mac_cfg
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
+ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, u8 tc_bitmap, u16 xoff_quanta,
+	u16 xoff_thresh, bool auto_drop, struct ice_sq_cd *cd)
 {
 	struct ice_aqc_set_mac_cfg *cmd;
 	struct ice_aq_desc desc;
@@ -759,13 +814,24 @@ ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
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
@@ -1072,7 +1138,7 @@ int ice_init_hw(struct ice_hw *hw)
 		goto err_unroll_fltr_mgmt_struct;
 
 	/* enable jumbo frame support at MAC level */
-	status = ice_aq_set_mac_cfg(hw, ICE_AQ_SET_MAC_FRAME_SIZE_MAX, false,
+	status = ice_aq_set_mac_cfg(hw, ICE_AQ_SET_MAC_FRAME_SIZE_MAX, 0, 0, 0, false,
 				    NULL);
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
diff --git a/drivers/net/intel/ice/base/ice_common.h b/drivers/net/intel/ice/base/ice_common.h
index 2d4f4871e6..32342ac005 100644
--- a/drivers/net/intel/ice/base/ice_common.h
+++ b/drivers/net/intel/ice/base/ice_common.h
@@ -220,8 +220,8 @@ int
 ice_aq_set_link_restart_an(struct ice_port_info *pi, bool ena_link,
 			   struct ice_sq_cd *cd);
 int
-ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
-		   struct ice_sq_cd *cd);
+ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, u8 tc_bitmap, u16 xoff_quanta,
+	u16 xoff_thresh, bool auto_drop, struct ice_sq_cd *cd);
 int
 ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 		     struct ice_link_status *link, struct ice_sq_cd *cd);
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..c152da4fc1 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4039,7 +4039,7 @@ ice_dev_start(struct rte_eth_dev *dev)
 		ICE_FRAME_SIZE_MAX;
 
 	/* Set the max frame size to HW*/
-	ice_aq_set_mac_cfg(hw, max_frame_size, false, NULL);
+	ice_aq_set_mac_cfg(hw, max_frame_size, 0, 0, 0, false, NULL);
 
 	if (ad->devargs.pps_out_ena) {
 		ret = ice_pps_out_cfg(hw, pin_idx, timer);
-- 
2.43.0

