Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4FEC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:43:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A308C40E32;
	Mon, 11 Aug 2025 15:43:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CEC24402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754919792; x=1786455792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oSmPzrJqNzuQcfPkOH+9UiM3Fgtp9Jms0ut/RkM3Q+Y=;
 b=FeQFJK8uu3W4aooSJVPmHcIIe+tP17k1xo7151S/I1iK4FYC/aKj+ITC
 Nm6XOUpUggeKeBtVHeCkknYn6vPPy6pA4E3NbukuXjpojHjAM49pSsEUJ
 H3vatdmKOr0xbOumvWl8CmVh0YTXJSsUxq8wtKtlx8zC3+WADTEFAGFg8
 Kxq/02KKe6iT1OteN3Ni3UsvDemIVmRQifjX5lhj0N5HuHZC3qxpbYIv1
 31O02Yy07E9drEciLfz54cuQjt/1TlztxgdVsJ+dw2vV8Qa8Z56rXX1vG
 kGsSHkzSmWijqft3ND/oFkUfNiMgIjBhohWM5R5hj8dHLKMb+e5fLlSUS g==;
X-CSE-ConnectionGUID: 2BQ7koAlQhSgECrD7U4l3w==
X-CSE-MsgGUID: FbqKLNZyRr2Xn7dBcGhE8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57041900"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57041900"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 06:43:12 -0700
X-CSE-ConnectionGUID: id/ilCucSOmgxfjd5iUH/w==
X-CSE-MsgGUID: +hSwtRf/RJmy8Eg5I1SopA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="171169028"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa004.fm.intel.com with ESMTP; 11 Aug 2025 06:43:10 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v2 5/6] net/ice: enable PFC support
Date: Mon, 11 Aug 2025 13:43:00 +0000
Message-ID: <20250811134301.459523-6-vladimir.medvedkin@intel.com>
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

This patch add support for Priority Flow Control (PFC)

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 125 ++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 27ba9c5b34..43fdbc7bc9 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -99,6 +99,11 @@ static struct proto_xtr_ol_flag ice_proto_xtr_ol_flag_params[] = {
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
@@ -326,6 +332,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.fec_set                      = ice_fec_set,
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
 	.get_dcb_info                 =	ice_get_dcb_info,
+	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -2831,17 +2838,33 @@ ice_dev_stop(struct rte_eth_dev *dev)
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
 
+	for (i = 0; i < max_tcs; i++) {
+		tc = ice_get_tc_by_up(hw, i);
+		cgd_idx = ice_get_cgd_idx(hw, tc);
+		wr32(hw, GLRPB_TCHW(cgd_idx), CPU_TO_LE32(ICE_MAC_TC_MAX_WATERMARK));
+		wr32(hw, GLRPB_TCLW(cgd_idx), CPU_TO_LE32(ICE_MAC_TC_MAX_WATERMARK));
+	}
+	max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD : ICE_FRAME_SIZE_MAX;
+	ret = ice_aq_set_mac_cfg(hw, max_frame_size, UINT8_MAX, UINT16_MAX,
+		INT16_MAX + 1, false, NULL);
+	if (ret)
+		PMD_DRV_LOG(ERR, "Failed to set mac config on DCB deinit");
+
 	memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
 	local_dcb_conf->etscfg.maxtcs = max_tcs;
 	local_dcb_conf->etscfg.tcbwtable[0] = 100;
@@ -3880,6 +3903,106 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
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
+	u8 tc = ice_get_tc_by_up(hw, pfc_conf->priority);
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
+		wr32(hw, GLRPB_TCHW(cgd_idx), CPU_TO_LE32(high_watermark));
+	if (low_watermark)
+		wr32(hw, GLRPB_TCLW(cgd_idx), CPU_TO_LE32(low_watermark));
+
+	/* Update pause quanta */
+	uint16_t max_frame_size = pf->dev_data->mtu ?
+		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
+		ICE_FRAME_SIZE_MAX;
+	ret = ice_aq_set_mac_cfg(hw, max_frame_size, 1 << tc, pfc_conf->fc.pause_time,
+			(pfc_conf->fc.pause_time + 1) / 2, false, NULL);
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
+		u32 mac_config = LE32_TO_CPU(rd32(hw, E830_MAC_COMMAND_CONFIG(port_info)));
+
+		if (pfc_conf->fc.mac_ctrl_frame_fwd)
+			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
+		else
+			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
+
+		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), CPU_TO_LE32(mac_config));
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

