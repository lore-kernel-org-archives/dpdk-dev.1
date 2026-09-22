Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B1C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA13740609;
	Tue, 22 Sep 2026 20:23:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id AEDD8402DE
 for <dev@dpdk.org>; Tue, 22 Sep 2026 20:23:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790101419; x=1821637419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T2MH+rZ0LG2vR0330+25KOawKTeAe+YsO/Ximoh4zSc=;
 b=fzCBN++mpJTo73VvCeYCAHCcJyPbJ5cEgx4DVQgQx0+RdoDZuicgdWhY
 4+wICuGjBYPp3OGLU18tI5X5lmEhmGRAq2eIGpyizq1ua6Vp9XdmovqCn
 nAcAYoIEw8M7G0VAzqpr1ydseql1REGj286Hw1XuHyxfdLFk+2NKNajKA
 Foo4R8t5au20+F3OxGzNdKx1OeviJDxasarAU3ZsM0rR2jRC+4ySJB4pn
 LWnYACoFdbdIvdta1rq+Gw7qQl14mCf94W3RRi0u2/nI+Y4S2lCEXxJRJ
 BbdeeDCi1IkkgRFMWihdy1yvEH+4EqHPWjrAuvGhyu+kYA5pxMtGHFElx g==;
X-CSE-ConnectionGUID: rTBBv6FbRkuJ32gv45HmyQ==
X-CSE-MsgGUID: Drel3DsOSr+Q87SliPbadQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1243653"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1243653"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:23:37 -0700
X-CSE-ConnectionGUID: OiiLZWX4Saig7BgrXkkdAA==
X-CSE-MsgGUID: iwN4eWsARxariNZetMso3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="4262889"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa012.fm.intel.com with ESMTP; 22 Sep 2026 11:23:36 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v3] net/ice: support link flow control
Date: Tue, 22 Sep 2026 18:23:33 +0000
Message-ID: <20260922182333.2288005-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
References: <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
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

Add get and set operations for IEEE 802.3x link flow control.
Link pause is advertised only when requested, retained across port
stop/start and re-armed on link-up. The watermark and pause quanta
programming is shared with priority flow control.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
v3:
- Address Bruce's comments.
- Add documentation.
- Retain LFC configuration across port stop/start.
- Fix various issues.

 doc/guides/nics/features/ice.ini       |   1 +
 doc/guides/nics/ice.rst                |  50 +++++
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/intel/ice/ice_ethdev.c     | 296 +++++++++++++++++++++----
 drivers/net/intel/ice/ice_ethdev.h     |   1 +
 5 files changed, 310 insertions(+), 42 deletions(-)

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
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index b671422ad7..065038a0d1 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -516,6 +516,56 @@ Example PFC configuration using DPDK API:
    ret = rte_eth_dev_priority_flow_ctrl_set(port_id, &pfc_conf);
 
 
+Link Flow Control (LFC)
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The ice PMD supports IEEE 802.3x link flow control through
+``rte_eth_dev_flow_ctrl_set()`` and ``rte_eth_dev_flow_ctrl_get()``.
+
+The requested mode (``RTE_ETH_FC_NONE``, ``RTE_ETH_FC_RX_PAUSE``,
+``RTE_ETH_FC_TX_PAUSE`` or ``RTE_ETH_FC_FULL``) is advertised to the link
+partner and takes effect once the link has been renegotiated.
+Pause frames are only exchanged when the link partner agrees to them,
+so ``rte_eth_dev_flow_ctrl_get()`` reports the negotiated mode,
+which may differ from the requested one.
+Link flow control is disabled (``RTE_ETH_FC_NONE`` advertised) until a mode is requested.
+The request is retained across ``rte_eth_dev_stop()`` and ``rte_eth_dev_start()``.
+
+Link flow control and priority flow control are mutually exclusive:
+``rte_eth_dev_flow_ctrl_set()`` fails with ``-ENOTSUP`` on a port configured
+with ``RTE_ETH_MQ_RX_DCB_FLAG``.
+
+The single traffic class configuration that arms the MAC for link flow control
+is programmed when the link comes up, from the link status change interrupt.
+Link status change interrupts (``intr_conf.lsc``) must therefore be enabled
+for link flow control to operate.
+
+Fields of ``struct rte_eth_fc_conf``:
+
+high_water, low_water
+   Rx buffer watermarks, in bytes, of the traffic class carrying link flow control.
+   A value of 0 keeps the current setting.
+
+pause_time
+   Pause quanta (in 512 bit-time units) carried in the transmitted pause frames.
+   A value of 0 keeps the current setting.
+
+mac_ctrl_frame_fwd
+   Forwarding of MAC control frames other than pause frames.
+
+autoneg, send_xon
+   Not used.
+
+Example configuration in testpmd:
+
+.. code-block:: console
+
+   set flow_ctrl rx on tx on 100000 50000 65535 0 mac_ctrl_frame_fwd off autoneg off 0
+
+This requests symmetric link flow control on port 0 with a high watermark of 100000 bytes,
+a low watermark of 50000 bytes and a pause time of 65535.
+
+
 Forward Error Correction (FEC)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
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
index 76b8ff0a72..2847b5269a 100644
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
+static int ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
+				  struct ice_link_status *link);
 
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
 
@@ -1468,9 +1475,16 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 		switch (opcode) {
 		case ice_aqc_opc_get_link_status:
 			ret = ice_link_update(dev, 0);
-			if (!ret)
+			if (!ret) {
+				/* On link-up, reapply the default single-TC configuration. */
+				if ((hw->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+						!(dev->data->dev_conf.rxmode.mq_mode &
+							RTE_ETH_MQ_RX_DCB_FLAG))
+					ice_set_dflt_mib(dev);
+
 				rte_eth_dev_callback_process
 					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+			}
 			break;
 		default:
 			PMD_DRV_LOG(DEBUG, "Request %u is not supported yet",
@@ -4105,6 +4119,233 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
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
+	uint8_t lldpmib[ICE_LLDPDU_SIZE] = { 0 };
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
+	ice_dcb_cfg_to_lldp(lldpmib, &miblen, &dcbcfg, ICE_SET_PFC_SYM);
+
+	if (ice_aq_set_lldp_mib(hw, SET_LOCAL_MIB_TYPE_LOCAL_MIB, lldpmib, miblen, NULL))
+		PMD_DRV_LOG(ERR, "Failed to set default LLDP MIB");
+}
+
+/* PHY pause advertisement bits for a link flow control mode */
+static uint8_t
+ice_fc_mode_to_pause_caps(enum rte_eth_fc_mode mode)
+{
+	switch (mode) {
+	case RTE_ETH_FC_FULL:
+		return ICE_AQC_PHY_EN_TX_LINK_PAUSE | ICE_AQC_PHY_EN_RX_LINK_PAUSE;
+	case RTE_ETH_FC_TX_PAUSE:
+		return ICE_AQC_PHY_EN_TX_LINK_PAUSE;
+	case RTE_ETH_FC_RX_PAUSE:
+		return ICE_AQC_PHY_EN_RX_LINK_PAUSE;
+	default:
+		return 0;
+	}
+}
+
+static int
+ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	bool enable_lse = dev->data->dev_conf.intr_conf.lsc ? true : false;
+	struct ice_link_status link_status;
+	bool tx_pause, rx_pause;
+	int ret;
+
+	ret = ice_get_link_info_safe(pf, enable_lse, &link_status);
+	if (ret != ICE_SUCCESS) {
+		PMD_DRV_LOG(ERR, "Failed to get link info");
+		return -EIO;
+	}
+
+	/* Last applied request; autoneg and send_xon are never set as they are
+	 * not programmed. The mode is the one negotiated with the link partner,
+	 * taken from the snapshot rather than the shared port state which the
+	 * link event handler updates concurrently.
+	 */
+	*fc_conf = pf->fc_conf;
+
+	tx_pause = (link_status.an_info & ICE_AQ_LINK_PAUSE_TX) != 0;
+	rx_pause = (link_status.an_info & ICE_AQ_LINK_PAUSE_RX) != 0;
+	if (tx_pause && rx_pause)
+		fc_conf->mode = RTE_ETH_FC_FULL;
+	else if (tx_pause)
+		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
+	else if (rx_pause)
+		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
+	else
+		fc_conf->mode = RTE_ETH_FC_NONE;
+
+	return 0;
+}
+
+/*
+ * Program the Rx buffer watermarks, pause quanta and MAC control frame
+ * forwarding shared by link flow control and priority flow control.
+ * A tc_bitmap of 0 selects link flow control; a single bit selects a PFC
+ * traffic class. Watermark or quanta values of 0 leave the current setting.
+ * The only step that can fail is issued first so that on error nothing
+ * has been changed.
+ */
+static int
+ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc_bitmap,
+		  struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *port_info = hw->port_info;
+	uint8_t tc = tc_bitmap == 0 ? 0 : rte_ctz32(tc_bitmap);
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
+	fc_conf->high_water = high_water;
+	fc_conf->low_water = low_water;
+
+	cgd_idx = ice_get_cgd_idx(hw, tc);
+	if (high_water)
+		wr32(hw, GLRPB_TCHW(cgd_idx), high_water);
+	if (low_water)
+		wr32(hw, GLRPB_TCLW(cgd_idx), low_water);
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
+	} else {
+		fc_conf->mac_ctrl_frame_fwd = false;
+	}
+
+	/* Update pause quanta and refresh threshold */
+	max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
+		ICE_FRAME_SIZE_MAX;
+	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
+			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
+			false, NULL);
+	if (ret)
+		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
+
+	return ret;
+}
+
+static int
+ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *pi = hw->port_info;
+	bool enable_lse = dev->data->dev_conf.intr_conf.lsc ? true : false;
+	struct ice_link_status link_status;
+	enum ice_fc_mode req_mode;
+	struct rte_eth_fc_conf tmp_fc_conf = { 0 };
+	bool link_up;
+	u8 aq_failures;
+	int ret;
+
+	/* Link flow control and priority flow control are mutually exclusive */
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+		PMD_DRV_LOG(ERR, "Priority flow control is enabled, cannot set link flow control");
+		return -ENOTSUP;
+	}
+
+	ret = ice_get_link_info_safe(pf, enable_lse, &link_status);
+	if (ret != ICE_SUCCESS) {
+		PMD_DRV_LOG(ERR, "Failed to get link info");
+		return -EIO;
+	}
+	link_up = link_status.link_info & ICE_AQ_LINK_UP;
+
+	switch (fc_conf->mode) {
+	case RTE_ETH_FC_NONE:
+		req_mode = ICE_FC_NONE;
+		break;
+	case RTE_ETH_FC_RX_PAUSE:
+		req_mode = ICE_FC_RX_PAUSE;
+		break;
+	case RTE_ETH_FC_TX_PAUSE:
+		req_mode = ICE_FC_TX_PAUSE;
+		break;
+	case RTE_ETH_FC_FULL:
+		req_mode = ICE_FC_FULL;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Invalid flow control mode %d", fc_conf->mode);
+		return -EINVAL;
+	}
+
+	/* ice_set_fc() reprograms pause config and, if auto link update is
+	 * enabled, restarts the link so the new mode is renegotiated. The
+	 * default MIB that configures the pipeline for LFC is reapplied from
+	 * the link-up event handler.
+	 */
+	pi->fc.req_mode = req_mode;
+	ret = ice_set_fc(pi, &aq_failures, link_up);
+	if (ret != 0 && aq_failures != ICE_SET_FC_AQ_FAIL_UPDATE) {
+		PMD_DRV_LOG(ERR, "Failed to set flow control mode, ret %d aq_failures 0x%x",
+			    ret, aq_failures);
+		return -EIO;
+	}
+
+	pf->fc_conf.mode = fc_conf->mode;
+
+	/* Apply the Rx buffer watermarks and pause quanta. If ice_cfg_fc_params
+	 * fails, leaves pause quanta at 0 (keep the current value), since this
+	 * is the only place where it may fail. Update watermarks
+	 * unconditionally.
+	 */
+	tmp_fc_conf = *fc_conf;
+	ret = ice_cfg_fc_params(dev, 0, &tmp_fc_conf);
+	if (ret != 0) {
+		PMD_DRV_LOG(WARNING, "Flow control mode applied, pause parameters left unchanged");
+	} else {
+		if (tmp_fc_conf.pause_time)
+			pf->fc_conf.pause_time = tmp_fc_conf.pause_time;
+	}
+	if (tmp_fc_conf.high_water)
+		pf->fc_conf.high_water = tmp_fc_conf.high_water;
+	if (tmp_fc_conf.low_water)
+		pf->fc_conf.low_water = tmp_fc_conf.low_water;
+	pf->fc_conf.mac_ctrl_frame_fwd = tmp_fc_conf.mac_ctrl_frame_fwd;
+
+	return 0;
+}
+
 static int
 ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf)
 {
@@ -4113,6 +4354,7 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
 	struct ice_port_info *port_info = hw->port_info;
 	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
 	struct ice_dcbx_cfg *dcb_conf = &qos_cfg->local_dcbx_cfg;
+	struct rte_eth_fc_conf tmp_fc_conf = { 0 };
 	int ret;
 
 	dcb_conf->pfc_mode = ICE_QOS_MODE_VLAN;
@@ -4160,47 +4402,13 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
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
+	/* Apply the Rx buffer watermarks and pause quanta for the PFC
+	 * traffic class selected by the user priority.
+	 */
+	tmp_fc_conf = pfc_conf->fc;
+	ret = ice_cfg_fc_params(dev, 1 << tc, &tmp_fc_conf);
+	if (ret)
+		PMD_DRV_LOG(WARNING, "Flow control mode applied, pause parameters left unchanged");
 
 	return 0;
 }
@@ -4946,6 +5154,7 @@ ice_phy_conf_link(struct ice_hw *hw,
 		   bool link_up)
 {
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(hw->back);
 	struct ice_port_info *pi = hw->port_info;
 	struct ice_aqc_get_phy_caps_data *phy_caps;
 	int err;
@@ -4986,6 +5195,9 @@ ice_phy_conf_link(struct ice_hw *hw,
 	}
 
 	cfg.caps = phy_caps->caps | ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+
+	cfg.caps &= ~(ICE_AQC_PHY_EN_TX_LINK_PAUSE | ICE_AQC_PHY_EN_RX_LINK_PAUSE);
+	cfg.caps |= ice_fc_mode_to_pause_caps(pf->fc_conf.mode);
 	cfg.low_power_ctrl_an = phy_caps->low_power_ctrl_an;
 	cfg.eee_cap = phy_caps->eee_cap;
 	cfg.eeer_value = phy_caps->eeer_value;
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

