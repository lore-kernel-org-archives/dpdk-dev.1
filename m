Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B61C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3C9F4042E;
	Tue,  1 Sep 2026 17:12:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4D047402E2
 for <dev@dpdk.org>; Tue,  1 Sep 2026 17:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788275558; x=1819811558;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cuipDKHOFlvXCN7YdhmTsdtEGwmv4zm/am9pU0BNA0I=;
 b=ebDsoZyUZQjjy+uNuAf8FD03ARpPxxinlt176HI9FhDjOSaxNUYJwCKZ
 +CXrTeFR0Co1UH+rD+FdnWLj8x7ScMgdEZhJ9xC/jmlEgnn8VTM6vVVfU
 YT1b9kEeb5OhA9K60BfExgqxBKCmYtgtukHRncyRdWK1aaqTsil7Tll0Q
 ohZJIjxOR8qgi95YWX5UUpSYJ7doun1l/0cuAjAxj3Zi2U/IZ/8IiCH63
 V3r5Goe2bWu7nKd3RaFkgYgLspUrh5iGM+HTxO2pIDS1HCZAQYp7w9fUd
 hhS9yOTFOrCVR2bCxTUFDALLqOSSFqbcTodicC7826OnI0jfOCNwvi+lz w==;
X-CSE-ConnectionGUID: 8yjkKsllSsqTVe9G67NYCw==
X-CSE-MsgGUID: 2IwPSKZwQmaEeK5T9stC6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111478067"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="111478067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 08:12:37 -0700
X-CSE-ConnectionGUID: 2E0PERYYTvSPIVOV9lmHCw==
X-CSE-MsgGUID: t+r2Lo8/RnC9HfGIOwfKhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="262988110"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa009.fm.intel.com with ESMTP; 01 Sep 2026 08:12:36 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Subject: [PATCH] net/ice: support link flow control
Date: Tue,  1 Sep 2026 15:12:33 +0000
Message-ID: <20260901151233.1110607-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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

Add get and set functions for link flow control (802.3x).

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 doc/guides/nics/features/ice.ini       |   1 +
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/intel/ice/ice_ethdev.c     | 286 +++++++++++++++++++------
 drivers/net/intel/ice/ice_ethdev.h     |   1 +
 4 files changed, 232 insertions(+), 60 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 893d09e9ec..309f691f32 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -30,6 +30,7 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 VLAN filter          = Y
+Flow control         = Y
 Traffic manager      = Y
 CRC offload          = Y
 VLAN offload         = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..5c4cd8a6df 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel ice driver.**
+
+  * Added support for getting and setting link (802.3x) flow control.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..11902df8b0 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -211,7 +211,12 @@ static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
 static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
 						size_t *no_of_elements);
 static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
+static void ice_set_dflt_mib(struct rte_eth_dev *dev);
+static int ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
+static int ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
 static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
+static int ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
+			     const struct rte_eth_fc_conf *fc_conf);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -352,6 +357,8 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.fec_set                      = ice_fec_set,
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
 	.get_dcb_info                 =	ice_get_dcb_info,
+	.flow_ctrl_get                = ice_flow_ctrl_get,
+	.flow_ctrl_set                = ice_flow_ctrl_set,
 	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
 };
 
@@ -1468,9 +1475,23 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 		switch (opcode) {
 		case ice_aqc_opc_get_link_status:
 			ret = ice_link_update(dev, 0);
-			if (!ret)
+			if (!ret) {
+				struct ice_pf *pf =
+					ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+
+				/* On link-up, reapply the default single-TC configuration. */
+				if ((hw->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+					!(dev->data->dev_conf.rxmode.mq_mode &
+						RTE_ETH_MQ_RX_DCB_FLAG) &&
+					hw->port_info->qos_cfg.local_dcbx_cfg.pfc.pfcena == 0) {
+					ice_set_dflt_mib(dev);
+					if (pf->fc_conf.mode != RTE_ETH_FC_NONE)
+						ice_cfg_fc_params(dev, 0, 0, &pf->fc_conf);
+				}
+
 				rte_eth_dev_callback_process
 					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+			}
 			break;
 		default:
 			PMD_DRV_LOG(DEBUG, "Request %u is not supported yet",
@@ -4073,6 +4094,22 @@ ice_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
+		       struct ice_link_status *link)
+{
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	int ret;
+
+	rte_spinlock_lock(&pf->link_lock);
+
+	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
+
+	rte_spinlock_unlock(&pf->link_lock);
+
+	return ret;
+}
+
 static int
 ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
 {
@@ -4105,6 +4142,190 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
 	return 0;
 }
 
+/*
+ * Program a default single-TC local LLDP MIB configuration. All user priorities
+ * map to TC0 at 100% bandwidth.
+ */
+static void
+ice_set_dflt_mib(struct rte_eth_dev *dev)
+{
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ice_dcbx_cfg dcbcfg = { 0 };
+	uint8_t *lldpmib;
+	uint16_t miblen;
+
+	dcbcfg.etscfg.willing = 1;
+	dcbcfg.etscfg.maxtcs = hw->func_caps.common_cap.maxtc;
+	dcbcfg.etscfg.tcbwtable[0] = 100;
+	dcbcfg.etscfg.tsatable[0] = ICE_IEEE_TSA_ETS;
+	dcbcfg.etsrec = dcbcfg.etscfg;
+	dcbcfg.etsrec.willing = 0;
+	dcbcfg.pfc.willing = 1;
+	dcbcfg.pfc.pfccap = hw->func_caps.common_cap.maxtc;
+
+	lldpmib = ice_malloc(hw, ICE_LLDPDU_SIZE);
+	if (lldpmib == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate MIB memory");
+		return;
+	}
+
+	ice_dcb_cfg_to_lldp(lldpmib, &miblen, &dcbcfg, ICE_SET_PFC_SYM);
+
+	if (ice_aq_set_lldp_mib(hw, SET_LOCAL_MIB_TYPE_LOCAL_MIB, lldpmib, miblen, NULL))
+		PMD_DRV_LOG(ERR, "Failed to set default LLDP MIB");
+
+	ice_free(hw, lldpmib);
+}
+
+static int
+ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *pi = hw->port_info;
+	bool enable_lse = dev->data->dev_conf.intr_conf.lsc ? true : false;
+	struct ice_link_status link_status;
+	int ret;
+
+	/* Refresh the negotiated flow control mode from the link status */
+	ret = ice_get_link_info_safe(pf, enable_lse, &link_status);
+	if (ret != ICE_SUCCESS) {
+		PMD_DRV_LOG(ERR, "Failed to get link info");
+		return -EIO;
+	}
+
+	*fc_conf = pf->fc_conf;
+
+	/* report the link flow control mode currently in effect */
+	switch (pi->fc.current_mode) {
+	case ICE_FC_FULL:
+		fc_conf->mode = RTE_ETH_FC_FULL;
+		break;
+	case ICE_FC_TX_PAUSE:
+		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
+		break;
+	case ICE_FC_RX_PAUSE:
+		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
+		break;
+	default:
+		fc_conf->mode = RTE_ETH_FC_NONE;
+	}
+
+	return 0;
+}
+
+/*
+ * Program the Rx buffer watermarks, pause quanta and MAC control frame
+ * forwarding shared by link flow control and priority flow control.
+ * A tc_bitmap of 0 selects link flow control; a single bit selects a PFC
+ * traffic class. Watermark or quanta values of 0 leave the current setting.
+ */
+static int
+ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
+		  const struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *port_info = hw->port_info;
+	uint32_t high_water = fc_conf->high_water;
+	uint32_t low_water = fc_conf->low_water;
+	uint16_t max_frame_size;
+	int cgd_idx;
+	int ret;
+
+	if (high_water > ICE_MAC_TC_MAX_WATERMARK)
+		high_water = ICE_MAC_TC_MAX_WATERMARK;
+	if (low_water > ICE_MAC_TC_MAX_WATERMARK)
+		low_water = ICE_MAC_TC_MAX_WATERMARK;
+
+	cgd_idx = ice_get_cgd_idx(hw, tc);
+	if (high_water)
+		wr32(hw, GLRPB_TCHW(cgd_idx), high_water);
+	if (low_water)
+		wr32(hw, GLRPB_TCLW(cgd_idx), low_water);
+
+	/* Update pause quanta and refresh threshold */
+	max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
+		ICE_FRAME_SIZE_MAX;
+	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
+			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
+			false, NULL);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
+		return ret;
+	}
+
+	/* Update forwarding of the non FC MAC control frames settings */
+	if (hw->mac_type == ICE_MAC_E830) {
+#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
+
+		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
+
+		if (fc_conf->mac_ctrl_frame_fwd)
+			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
+		else
+			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
+
+		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
+	}
+
+	return 0;
+}
+
+static int
+ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *pi = hw->port_info;
+	struct ice_dcbx_cfg *dcbx_cfg = &pi->qos_cfg.local_dcbx_cfg;
+	bool link_up;
+	u8 aq_failures;
+	int ret;
+
+	/* Link flow control and priority flow control are mutually exclusive */
+	if (dcbx_cfg->pfc.pfcena != 0) {
+		PMD_DRV_LOG(ERR, "Priority flow control is enabled, cannot set link flow control");
+		return -ENOTSUP;
+	}
+
+	switch (fc_conf->mode) {
+	case RTE_ETH_FC_FULL:
+		pi->fc.req_mode = ICE_FC_FULL;
+		break;
+	case RTE_ETH_FC_TX_PAUSE:
+		pi->fc.req_mode = ICE_FC_TX_PAUSE;
+		break;
+	case RTE_ETH_FC_RX_PAUSE:
+		pi->fc.req_mode = ICE_FC_RX_PAUSE;
+		break;
+	default:
+		pi->fc.req_mode = ICE_FC_NONE;
+	}
+
+	/* ice_set_fc() reprograms the PHY pause config and, if auto link update
+	 * is enabled, restarts the link so the new mode is renegotiated. The
+	 * default MIB that arms the MAC for LFC is reapplied from the link-up
+	 * event handler.
+	 */
+	link_up = pi->phy.link_info.link_info & ICE_AQ_LINK_UP;
+	ret = ice_set_fc(pi, &aq_failures, link_up);
+	if (ret != 0 && aq_failures != ICE_SET_FC_AQ_FAIL_UPDATE) {
+		PMD_DRV_LOG(ERR, "Failed to set flow control mode, ret %d aq_failures 0x%x",
+			    ret, aq_failures);
+		return -EIO;
+	}
+
+	pf->fc_conf = *fc_conf;
+
+	/* Apply the Rx buffer watermarks and pause quanta for the link flow
+	 * control traffic class (LFC rides user priority 0).
+	 */
+	return ice_cfg_fc_params(dev, 0, 0, fc_conf);
+}
+
 static int
 ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf)
 {
@@ -4160,49 +4381,10 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
 		return ret;
 	}
 
-	/* Update high and low watermarks */
-	u32 high_watermark = pfc_conf->fc.high_water;
-	if (high_watermark > ICE_MAC_TC_MAX_WATERMARK)
-		high_watermark = ICE_MAC_TC_MAX_WATERMARK;
-
-	u32 low_watermark = pfc_conf->fc.low_water;
-	if (low_watermark > ICE_MAC_TC_MAX_WATERMARK)
-		low_watermark = ICE_MAC_TC_MAX_WATERMARK;
-
-	int cgd_idx = ice_get_cgd_idx(hw, tc);
-
-	if (high_watermark)
-		wr32(hw, GLRPB_TCHW(cgd_idx), high_watermark);
-	if (low_watermark)
-		wr32(hw, GLRPB_TCLW(cgd_idx), low_watermark);
-
-	/* Update pause quanta */
-	uint16_t max_frame_size = pf->dev_data->mtu ?
-		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
-		ICE_FRAME_SIZE_MAX;
-	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, 1 << tc, pfc_conf->fc.pause_time,
-			((u32)pfc_conf->fc.pause_time + 1) / 2, false, NULL);
-	if (ret) {
-		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
-		return ret;
-	}
-
-	/* Update forwarding of the non FC MAC control frames settings */
-	if ((hw)->mac_type == ICE_MAC_E830) {
-#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
-		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
-
-		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
-
-		if (pfc_conf->fc.mac_ctrl_frame_fwd)
-			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
-		else
-			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
-
-		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
-	}
-
-	return 0;
+	/* Apply the Rx buffer watermarks and pause quanta for the PFC
+	 * traffic class selected by the user priority.
+	 */
+	return ice_cfg_fc_params(dev, tc, 1 << tc, &pfc_conf->fc);
 }
 
 static void
@@ -4373,22 +4555,6 @@ ice_rxq_intr_setup(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static int
-ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
-		       struct ice_link_status *link)
-{
-	struct ice_hw *hw = ICE_PF_TO_HW(pf);
-	int ret;
-
-	rte_spinlock_lock(&pf->link_lock);
-
-	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
-
-	rte_spinlock_unlock(&pf->link_lock);
-
-	return ret;
-}
-
 static void
 ice_get_init_link_status(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..3143aca74a 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -613,6 +613,7 @@ struct ice_pf {
 	 * and link status update during dev_start.
 	 */
 	rte_spinlock_t link_lock;
+	struct rte_eth_fc_conf fc_conf; /* cached link flow control config */
 };
 
 #define ICE_MAX_QUEUE_NUM  2048
-- 
2.43.0

