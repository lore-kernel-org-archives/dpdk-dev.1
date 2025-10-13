Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24F1CCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 18:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D454042E;
	Mon, 13 Oct 2025 20:05:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id DEE1840288
 for <dev@dpdk.org>; Mon, 13 Oct 2025 20:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760378729; x=1791914729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IUtM3X0WwK7XEyve1eJpc8VIyBO45+8PDPyktuyJfI8=;
 b=lVGucep9kWWRvj8i75bWBzOXg1XEoha26GUohPXECptX4lFNGaHwC0Wj
 YucV716WprlVsLFhyC2tZOdOynMYSmoCvCO2WIgPl6BsOwIew9TRW63tR
 RwyECEHxm65KOLaCXYRxKv9htJLHfe2Toa2fHVkl4jEO0x0/qFxcYhTMr
 L/hNQT6xMJhjGtIM0tWUxY70DBDGDShBJqQUObQ8ZoBph0wB9K5AkdQkt
 be4LJBG61PASLWw4Vk1zV7+UaoZkxCokV49a/fvucg+mgGoZcbsjL7NFY
 qV42ylvn/caF532ZrlBSAuZEPNRZRUoTpIJEJz5UQ2ePTq4VkCT29vQoB Q==;
X-CSE-ConnectionGUID: 3ItwS2G5TDOgEQE4Zc1UIQ==
X-CSE-MsgGUID: tQ6ee0qCQv2AQEyClABx6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73208646"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="73208646"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 11:05:28 -0700
X-CSE-ConnectionGUID: cYgzs+6yQVaJ9GBEkBPvOw==
X-CSE-MsgGUID: sbK8Es1JRpeDGZ8Hnkh3Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; d="scan'208";a="181468877"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa007.jf.intel.com with ESMTP; 13 Oct 2025 11:05:27 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v6 2/3] net/ice: enable PFC support
Date: Mon, 13 Oct 2025 18:05:22 +0000
Message-ID: <20251013180523.61468-3-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013180523.61468-1-vladimir.medvedkin@intel.com>
References: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
 <20251013180523.61468-1-vladimir.medvedkin@intel.com>
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

This patch add support for Priority Flow Control (PFC)

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 127 ++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 697c1e4824..582fc469fe 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -99,6 +99,11 @@ enum ice_link_state_on_close {
 #define ICE_COMMS_PKG_NAME			"ICE COMMS Package"
 #define ICE_MAX_RES_DESC_NUM        1024
 
+#define ICE_MAC_E810_MAX_WATERMARK	143744U
+#define ICE_MAC_E830_MAX_WATERMARK	259103U
+#define ICE_MAC_TC_MAX_WATERMARK	(((hw)->mac_type == ICE_MAC_E830) ?	\
+				ICE_MAC_E830_MAX_WATERMARK : ICE_MAC_E810_MAX_WATERMARK)
+
 static int ice_dev_configure(struct rte_eth_dev *dev);
 static int ice_dev_start(struct rte_eth_dev *dev);
 static int ice_dev_stop(struct rte_eth_dev *dev);
@@ -195,6 +200,7 @@ static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
 static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
 						size_t *no_of_elements);
 static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
+static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -335,6 +341,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.fec_set                      = ice_fec_set,
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
 	.get_dcb_info                 =	ice_get_dcb_info,
+	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -2868,17 +2875,35 @@ ice_dev_stop(struct rte_eth_dev *dev)
 static void
 ice_deinit_dcb(struct rte_eth_dev *dev)
 {
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_port_info *port_info = hw->port_info;
 	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
 	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
+	int i, ret, cgd_idx;
+	uint16_t max_frame_size;
 	u8 max_tcs = local_dcb_conf->etscfg.maxtcs;
-	int ret;
+	u8 tc;
 
 	if (!(dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG ||
 			dev->data->dev_conf.txmode.mq_mode == RTE_ETH_MQ_TX_DCB))
 		return;
 
+	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+		tc = ice_get_tc_by_priority(hw, i);
+		cgd_idx = ice_get_cgd_idx(hw, tc);
+		wr32(hw, GLRPB_TCHW(cgd_idx), CPU_TO_LE32(ICE_MAC_TC_MAX_WATERMARK));
+		wr32(hw, GLRPB_TCLW(cgd_idx), CPU_TO_LE32(ICE_MAC_TC_MAX_WATERMARK));
+	}
+
+	max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD : ICE_FRAME_SIZE_MAX;
+	/* for each TC resets corresponding PFC quanta/threshold to its default values */
+	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, (1 << max_tcs) - 1,
+		UINT16_MAX, INT16_MAX + 1, false, NULL);
+	if (ret)
+		PMD_DRV_LOG(ERR, "Failed to set mac config on DCB deinit");
+
 	memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
 	local_dcb_conf->etscfg.maxtcs = max_tcs;
 	local_dcb_conf->etscfg.tcbwtable[0] = 100;
@@ -3919,6 +3944,106 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
 	return 0;
 }
 
+static int
+ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *port_info = hw->port_info;
+	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+	struct ice_dcbx_cfg *dcb_conf = &qos_cfg->local_dcbx_cfg;
+	int ret;
+
+	dcb_conf->pfc_mode = ICE_QOS_MODE_VLAN;
+	dcb_conf->pfc.willing = 0;
+	/** pfccap should alreeady be set by DCB config, check if zero */
+	if (dcb_conf->pfc.pfccap == 0) {
+		PMD_DRV_LOG(ERR, "DCB is not configured on the port, can not set PFC");
+		return -EINVAL;
+	}
+
+	ret = ice_aq_set_pfc_mode(hw, ICE_AQC_PFC_VLAN_BASED_PFC, NULL);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to enable PFC in VLAN mode");
+		return ret;
+	}
+
+	u8 tc = ice_get_tc_by_priority(hw, pfc_conf->priority);
+
+	switch (pfc_conf->fc.mode) {
+	case (RTE_ETH_FC_NONE):
+		dcb_conf->pfc.pfcena &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_rx &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_tx &= ~(1 << tc);
+		break;
+	case (RTE_ETH_FC_RX_PAUSE):
+		dcb_conf->pfc.pfcena &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_rx |= (1 << tc);
+		dcb_conf->pfc.pfcena_asym_tx &= ~(1 << tc);
+		break;
+	case (RTE_ETH_FC_TX_PAUSE):
+		dcb_conf->pfc.pfcena &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_rx &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_tx |= (1 << tc);
+		break;
+	case (RTE_ETH_FC_FULL):
+		dcb_conf->pfc.pfcena |= (1 << tc);
+		dcb_conf->pfc.pfcena_asym_rx &= ~(1 << tc);
+		dcb_conf->pfc.pfcena_asym_tx &= ~(1 << tc);
+		break;
+	}
+
+	ret = ice_set_dcb_cfg(port_info);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to configure DCB for PF");
+		return ret;
+	}
+
+	/* Update high and low watermarks */
+	u32 high_watermark = pfc_conf->fc.high_water;
+	if (high_watermark > ICE_MAC_TC_MAX_WATERMARK)
+		high_watermark = ICE_MAC_TC_MAX_WATERMARK;
+
+	u32 low_watermark = pfc_conf->fc.low_water;
+	if (low_watermark > ICE_MAC_TC_MAX_WATERMARK)
+		low_watermark = ICE_MAC_TC_MAX_WATERMARK;
+
+	int cgd_idx = ice_get_cgd_idx(hw, tc);
+
+	if (high_watermark)
+		wr32(hw, GLRPB_TCHW(cgd_idx), high_watermark);
+	if (low_watermark)
+		wr32(hw, GLRPB_TCLW(cgd_idx), low_watermark);
+
+	/* Update pause quanta */
+	uint16_t max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
+		ICE_FRAME_SIZE_MAX;
+	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, 1 << tc, pfc_conf->fc.pause_time,
+			((u32)pfc_conf->fc.pause_time + 1) / 2, false, NULL);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
+		return ret;
+	}
+
+	/* Update forwarding of the non FC MAC control frames settings */
+	if ((hw)->mac_type == ICE_MAC_E830) {
+#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
+		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
+
+		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
+
+		if (pfc_conf->fc.mac_ctrl_frame_fwd)
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
 static void
 __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 		       int base_queue, int nb_queue)
-- 
2.43.0

