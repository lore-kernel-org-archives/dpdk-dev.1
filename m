Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD783CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 11:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D31D40A81;
	Tue, 30 Sep 2025 13:21:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E8585402E7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 13:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759231285; x=1790767285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rATuDqswMHnL4Cf6zISU+WkUob4e7FupP/KEaL7O26A=;
 b=dqExMxhPbMt7RgRYUBgbZNvBGUMq1rWQNpFZabcscpUU71Ru3e4QgOXP
 Et0MEQQoiaBQyTI3V7wAYSfJg4nv+Gt0lv8jY4S+3nxvC9REIH6fzxDgu
 8nBMXSiSRwKKDzpnXSl1k7wdS0S9ALXTw+12jhv+JIiKEWsoVy0xUxBEs
 W1AhZKjVJtVJSFDsN+gxFHMhpr0jr9biWcPkqxt3YPjKHjCV2BdmG1l7r
 qblsXXhK3Dkg1T+RgVr4L1IByd6Bk/SjN7qe18UkeZVNUsqsXEbCv0AYq
 VwDrx6Ndo5s8H3K6TIsFxXBezwM63KE+tore8M7ysuVaxlyFWGeC6005+ g==;
X-CSE-ConnectionGUID: uzrX8m+vS/Sgk8mo5JV2jA==
X-CSE-MsgGUID: 0jxtDtEvTbe8Dtw+31ASPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="86927964"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="86927964"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 04:21:24 -0700
X-CSE-ConnectionGUID: nfKZoUWuTjOkk7CsqM6+lg==
X-CSE-MsgGUID: bHOH/+r+RXCGKiv+Xhc7Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="179265266"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 04:21:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v1 3/4] net/ice/base: make set MAC config TC aware
Date: Tue, 30 Sep 2025 12:21:16 +0100
Message-ID: <c51f2c6e36e3892e3a729d1cff507c2346bc0f0e.1759231103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759231103.git.anatoly.burakov@intel.com>
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Current implementation of the `ice_aq_set_mac_cfg()` sets Flow Control (FC)
settings such as quanta and threshold only for LFC. This patch makes this
function Traffic Class (TC) aware, so it can configure FC for each TC
individually.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 172 +++++++++++++++++++-----
 drivers/net/intel/ice/base/ice_common.h |   3 +
 drivers/net/intel/ice/base/ice_type.h   |  13 ++
 3 files changed, 152 insertions(+), 36 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 63c72f77a5..e7f3b240c4 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -700,65 +700,136 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 }
 
 /**
- * ice_fill_tx_timer_and_fc_thresh
+ * ice_get_xoff_pause_quanta
  * @hw: pointer to the HW struct
- * @cmd: pointer to MAC cfg structure
+ * @tc: index of traffic class. Relevant if @pfc is true
+ * @pfc: if true - use @tc to get corresponding quanta
  *
- * Add Tx timer and FC refresh threshold info to Set MAC Config AQ command
- * descriptor
+ * Returns u16 current configured LFC of PFC quanta value.
+ * If @pfc is true returns value of the corresponding @tc traffic class.
+ * If false returns configured LFC quanta
  */
-static void
-ice_fill_tx_timer_and_fc_thresh(struct ice_hw *hw,
-				struct ice_aqc_set_mac_cfg *cmd)
+static u16
+ice_get_xoff_pause_quanta(struct ice_hw *hw, u8 tc, bool pfc)
 {
-	u16 fc_thres_val, tx_timer_val;
-	u32 val;
+	u32 val = 0;
 
-	/* We read back the transmit timer and fc threshold value of
-	 * LFC. Thus, we will use index =
-	 * PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX.
-	 *
-	 * Also, because we are operating on transmit timer and fc
-	 * threshold of LFC, we don't turn on any bit in tx_tmr_priority
-	 */
-#define E800_IDX_OF_LFC E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX
+#define E830_CL01_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL01_PAUSE_QUANTA : E830_PRTMAC_CL01_PAUSE_QUANTA)
+#define E830_CL23_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL23_PAUSE_QUANTA : E830_PRTMAC_CL23_PAUSE_QUANTA)
+#define E830_CL45_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL45_PAUSE_QUANTA : E830_PRTMAC_CL45_PAUSE_QUANTA)
+#define E830_CL67_PAUSE_QUANTA(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+				E830_PRTMAC_200G_CL67_PAUSE_QUANTA : E830_PRTMAC_CL67_PAUSE_QUANTA)
 
 	if ((hw)->mac_type == ICE_MAC_E830) {
-		/* Retrieve the transmit timer */
-		val = rd32(hw, E830_PRTMAC_CL01_PAUSE_QUANTA);
-		tx_timer_val = val & E830_PRTMAC_CL01_PAUSE_QUANTA_CL0_PAUSE_QUANTA_M;
-		cmd->tx_tmr_value = CPU_TO_LE16(tx_timer_val);
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
+		if (tc & 0x1)
+			val >>= 16;
 
-		/* Retrieve the fc threshold */
-		val = rd32(hw, E830_PRTMAC_CL01_QUANTA_THRESH);
-		fc_thres_val = val & E830_PRTMAC_CL01_QUANTA_THRESH_CL0_QUANTA_THRESH_M;
 	} else {
-		/* Retrieve the transmit timer */
-		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA(E800_IDX_OF_LFC));
-		tx_timer_val = val &
+		int prio_idx = (pfc) ? tc : E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_MAX_INDEX;
+		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA(prio_idx)) &
 			E800_PRTMAC_HSEC_CTL_TX_PAUSE_QUANTA_HSEC_CTL_TX_PAUSE_QUANTA_M;
-		cmd->tx_tmr_value = CPU_TO_LE16(tx_timer_val);
+	}
+
+	return CPU_TO_LE16((u16)val);
+}
+
+/**
+ * ice_get_xoff_pause_thresh
+ * @hw: pointer to the HW struct
+ * @tc: index of traffic class. Relevant if @pfc is true
+ * @pfc: if true - use @tc to get corresponding threshold
+ *
+ * Returns u16 current configured LFC of PFC threshold value.
+ * If @pfc is true returns value of the corresponding @tc traffic class.
+ * If false returns configured LFC threshold
+ */
+static u16
+ice_get_xoff_pause_thresh(struct ice_hw *hw, u8 tc, bool pfc)
+{
+	u32 val = 0;
+
+#define E830_CL01_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL01_QUANTA_THRESH : E830_PRTMAC_CL01_QUANTA_THRESH)
+#define E830_CL23_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL23_QUANTA_THRESH : E830_PRTMAC_CL23_QUANTA_THRESH)
+#define E830_CL45_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL45_QUANTA_THRESH : E830_PRTMAC_CL45_QUANTA_THRESH)
+#define E830_CL67_PAUSE_THRESH(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+			E830_PRTMAC_200G_CL67_QUANTA_THRESH : E830_PRTMAC_CL67_QUANTA_THRESH)
+
+	if ((hw)->mac_type == ICE_MAC_E830) {
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
+		if (tc & 0x1)
+			val >>= 16;
 
-		/* Retrieve the fc threshold */
-		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER(E800_IDX_OF_LFC));
-		fc_thres_val = val & E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_M;
+	} else {
+		int prio_idx = (pfc) ? tc : E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_MAX_INDEX;
+		val = rd32(hw, E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER(prio_idx)) &
+			E800_PRTMAC_HSEC_CTL_TX_PAUSE_REFRESH_TIMER_M;
 	}
 
-	cmd->fc_refresh_threshold = CPU_TO_LE16(fc_thres_val);
+	return CPU_TO_LE16((u16)val);
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
@@ -768,17 +839,46 @@ ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, bool auto_drop,
 	if (max_frame_size == 0)
 		return ICE_ERR_PARAM;
 
+	/* when quanta or threshold are 0, we may read values from traffic class
+	 * registers indicated by tc_bitmap. However, the AQC can only store
+	 * data read from one traffic class, so check if there is at most one
+	 * bit set to avoid ambiguity
+	 */
+	if ((xoff_quanta == 0 || xoff_thresh == 0) && !ice_is_pow2(tc_bitmap))
+		return ICE_ERR_PARAM;
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_mac_cfg);
 
 	cmd->max_frame_size = CPU_TO_LE16(max_frame_size);
 
 	if (ice_is_fw_auto_drop_supported(hw) && auto_drop)
 		cmd->drop_opts |= ICE_AQ_SET_MAC_AUTO_DROP_BLOCKING_PKTS;
-	ice_fill_tx_timer_and_fc_thresh(hw, cmd);
+	cmd->tx_tmr_priority = tc_bitmap;
+	cmd->tx_tmr_value = (xoff_quanta) ? CPU_TO_LE16(xoff_quanta) :
+		ice_get_xoff_pause_quanta(hw,
+			(tc_bitmap) ? ice_ctz(tc_bitmap) : 0, !!tc_bitmap);
+	cmd->fc_refresh_threshold = (xoff_thresh) ? CPU_TO_LE16(xoff_thresh) :
+		ice_get_xoff_pause_thresh(hw,
+			(tc_bitmap) ? ice_ctz(tc_bitmap) : 0, !!tc_bitmap);
 
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
+		   struct ice_sq_cd *cd)
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
diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 5f1f1a2f13..b2e1bfeca1 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -28,6 +28,19 @@ static inline bool ice_is_pow2(u64 val)
 	return val != 0 && (val & (val - 1)) == 0;
 }
 
+/**
+ * ice_ctz - count trailing zeroes
+ * @val: unsigned integer to be validated
+ */
+static inline int ice_ctz(u32 val)
+{
+	int i = 0;
+	while (!(val & (1 << i)))
+		i++;
+
+	return i;
+}
+
 /**
  * ice_ilog2 - Calculates integer log base 2 of a number
  * @n: number on which to perform operation
-- 
2.47.3

