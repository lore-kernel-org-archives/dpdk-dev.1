Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2953CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 12:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4064042E;
	Fri,  3 Oct 2025 14:40:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 996354025D
 for <dev@dpdk.org>; Fri,  3 Oct 2025 14:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759495243; x=1791031243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SUuoySRWC665/wUhztjNrs3jWjXR1E0FCr03arwrA38=;
 b=YaQJCSRL1Xikr+iXrGf8oVYjCB2Qr47pvP6jj3BcdUlxjfxUh9plfeRA
 2R42sxcYTrkg/aNqpf6v2MdfrjBgXDHenPVkjmGnufuhNicy0xuUNh9KL
 reKxVVcFS5iCZpdO2vAPicIxFT5MZVhC7sEgEdG4FAdnfmnczHzT4nUCd
 m8JynGKzYz91TwkWuC6KhtnNjQbyvW9yydPTZN3A2XK/6SNYeOL5gAE7O
 gb4/zB83QSoGzyZfL/lTmHB8o3cp7dBVCgGOpgRjVppwHy/1nzsRTd+Ae
 uDvBWB9xno9ShrLzYTFdIXlnit22Ss2wJaeiMOSGMOuqNxfyLZGogm9Q4 A==;
X-CSE-ConnectionGUID: kaJO/3A2QBG4mnMK3QzujQ==
X-CSE-MsgGUID: nAb9o7OpQxGjEQ1dpFpsiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="72395404"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72395404"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 05:40:42 -0700
X-CSE-ConnectionGUID: jJdejCBSSKi9lq8rYxlDjA==
X-CSE-MsgGUID: g7G7vdOiTNen/WYvo2lCMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="178572350"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa010.jf.intel.com with ESMTP; 03 Oct 2025 05:40:41 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v5 1/3] net/ice: enable DCB support
Date: Fri,  3 Oct 2025 12:40:35 +0000
Message-ID: <20251003124037.342760-2-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003124037.342760-1-vladimir.medvedkin@intel.com>
References: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
 <20251003124037.342760-1-vladimir.medvedkin@intel.com>
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

This patch adds support for Data Center Bridging (DCB)

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 184 +++++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c   |  21 ++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index a9a49cd924..209d40c46f 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -194,6 +194,7 @@ static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
 static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
 static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
 						size_t *no_of_elements);
+static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -333,6 +334,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.fec_get                      = ice_fec_get,
 	.fec_set                      = ice_fec_set,
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
+	.get_dcb_info                 =	ice_get_dcb_info,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -2863,6 +2865,29 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+ice_deinit_dcb(struct rte_eth_dev *dev)
+{
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ice_port_info *port_info = hw->port_info;
+	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+	struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
+	u8 max_tcs = local_dcb_conf->etscfg.maxtcs;
+	int ret;
+
+	if (!(dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG ||
+			dev->data->dev_conf.txmode.mq_mode == RTE_ETH_MQ_TX_DCB))
+		return;
+
+	memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
+	local_dcb_conf->etscfg.maxtcs = max_tcs;
+	local_dcb_conf->etscfg.tcbwtable[0] = 100;
+	local_dcb_conf->etsrec.tcbwtable[0] = 100;
+	ret = ice_set_dcb_cfg(port_info);
+	if (ret)
+		PMD_DRV_LOG(ERR, "Failed to disable DCB");
+}
+
 static int
 ice_dev_close(struct rte_eth_dev *dev)
 {
@@ -2897,6 +2922,7 @@ ice_dev_close(struct rte_eth_dev *dev)
 	if (!ad->is_safe_mode)
 		ice_flow_uninit(ad);
 
+	ice_deinit_dcb(dev);
 	/* release all queue resource */
 	ice_free_queues(dev);
 
@@ -3707,6 +3733,34 @@ static int ice_init_rss(struct ice_pf *pf)
 	return -EINVAL;
 }
 
+static int
+check_dcb_conf(int is_8_ports, struct rte_eth_dcb_rx_conf *dcb_conf)
+{
+	uint32_t tc_map = 0;
+	int i;
+
+	enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
+	if (nb_tcs != RTE_ETH_4_TCS && is_8_ports) {
+		PMD_DRV_LOG(ERR, "Invalid num TCs setting - only 4 TCs are supported");
+		return -1;
+	} else if (nb_tcs != RTE_ETH_4_TCS && nb_tcs != RTE_ETH_8_TCS) {
+		PMD_DRV_LOG(ERR, "Invalid num TCs setting - only 8 TCs or 4 TCs are supported");
+		return -1;
+	}
+
+	/* Check if associated TC are in continuous range */
+	for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++)
+		tc_map |= 1 << (dcb_conf->dcb_tc[i] & 0x7);
+
+	if (!rte_is_power_of_2(tc_map + 1)) {
+		PMD_DRV_LOG(ERR,
+			"Bad VLAN User Priority to Traffic Class association in DCB config");
+		return -1;
+	}
+
+	return rte_popcount32(tc_map);
+}
+
 static int
 ice_dev_configure(struct rte_eth_dev *dev)
 {
@@ -3734,6 +3788,136 @@ ice_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+		struct ice_hw *hw = ICE_PF_TO_HW(pf);
+		struct ice_vsi *vsi = pf->main_vsi;
+		struct ice_port_info *port_info = hw->port_info;
+		struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+		struct ice_dcbx_cfg *local_dcb_conf = &qos_cfg->local_dcbx_cfg;
+		struct ice_vsi_ctx ctxt;
+		struct rte_eth_dcb_rx_conf *dcb_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+		int i;
+		enum rte_eth_nb_tcs nb_tcs = dcb_conf->nb_tcs;
+		int nb_tc_used, queues_per_tc;
+		uint16_t total_q_nb;
+
+		nb_tc_used = check_dcb_conf(ice_get_port_max_cgd(hw) == ICE_4_CGD_PER_PORT,
+			dcb_conf);
+		if (nb_tc_used < 0)
+			return -EINVAL;
+
+		ctxt.info = vsi->info;
+		if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
+			PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
+			return -EINVAL;
+		}
+
+		total_q_nb = dev->data->nb_rx_queues;
+		queues_per_tc = total_q_nb / nb_tc_used;
+		if (total_q_nb % nb_tc_used != 0) {
+			PMD_DRV_LOG(ERR, "For DCB, number of queues must be evenly divisble by number of used TCs");
+			return -EINVAL;
+		} else if (!rte_is_power_of_2(queues_per_tc)) {
+			PMD_DRV_LOG(ERR, "For DCB, number of queues per TC must be a power of 2");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < nb_tc_used; i++) {
+			ctxt.info.tc_mapping[i] =
+				rte_cpu_to_le_16(((i * queues_per_tc) << ICE_AQ_VSI_TC_Q_OFFSET_S) |
+					(rte_log2_u32(queues_per_tc) << ICE_AQ_VSI_TC_Q_NUM_S));
+		}
+
+		memset(local_dcb_conf, 0, sizeof(*local_dcb_conf));
+
+		local_dcb_conf->etscfg.maxtcs = nb_tcs;
+
+		/* Associate each VLAN UP with particular TC */
+		for (i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+			local_dcb_conf->etscfg.prio_table[i] = dcb_conf->dcb_tc[i];
+			local_dcb_conf->etsrec.prio_table[i] = dcb_conf->dcb_tc[i];
+		}
+
+		/*
+		 * Since current API does not support setting ETS BW Share and Scheduler
+		 * configure all TC as ETS and evenly share load across all existing TC
+		 **/
+		const int bw_share_percent = 100 / nb_tc_used;
+		const int bw_share_left = 100 - bw_share_percent * nb_tc_used;
+		for (i = 0; i < nb_tc_used; i++) {
+			/* Per TC bandwidth table (all valued must add up to 100%), valid on ETS */
+			local_dcb_conf->etscfg.tcbwtable[i] = bw_share_percent;
+			local_dcb_conf->etsrec.tcbwtable[i] = bw_share_percent;
+
+			/**< Transmission Selection Algorithm. 0 - Strict prio, 2 - ETS */
+			local_dcb_conf->etscfg.tsatable[i] = 2;
+			local_dcb_conf->etsrec.tsatable[i] = 2;
+		}
+
+		for (i = 0; i < bw_share_left; i++) {
+			local_dcb_conf->etscfg.tcbwtable[i]++;
+			local_dcb_conf->etsrec.tcbwtable[i]++;
+		}
+
+		local_dcb_conf->pfc.pfccap = nb_tcs;
+		local_dcb_conf->pfc.pfcena = 0;
+
+		ret = ice_set_dcb_cfg(port_info);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "Failed to configure DCB for PF");
+			return ret;
+		}
+
+		/* Update VSI queue allocatios per TC */
+		ctxt.info.valid_sections = rte_cpu_to_le_16(ICE_AQ_VSI_PROP_RXQ_MAP_VALID);
+		ctxt.info.mapping_flags = rte_cpu_to_le_16(ICE_AQ_VSI_Q_MAP_CONTIG);
+
+		ret = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "Failed to configure queue mapping");
+			return ret;
+		}
+
+		ctxt.info.valid_sections = 0;
+		vsi->info = ctxt.info;
+
+		hw->port_info->fc.current_mode = ICE_FC_PFC;
+	}
+
+	return 0;
+}
+
+static int
+ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_port_info *port_info = hw->port_info;
+	struct ice_qos_cfg *qos_cfg = &port_info->qos_cfg;
+	struct ice_dcbx_cfg *dcb_conf = &qos_cfg->local_dcbx_cfg;
+	struct ice_vsi *vsi = pf->main_vsi;
+	struct ice_vsi_ctx ctxt = { 0 };
+
+	ctxt.info = vsi->info;
+	if (rte_le_to_cpu_16(ctxt.info.mapping_flags) == ICE_AQ_VSI_Q_MAP_NONCONTIG) {
+		PMD_DRV_LOG(ERR, "VSI configured with non contiguous queues, DCB is not supported");
+		return -ENOTSUP;
+	}
+
+	dcb_info->nb_tcs = dcb_conf->etscfg.maxtcs;
+	for (int i = 0; i < dcb_info->nb_tcs; i++) {
+		dcb_info->prio_tc[i] = dcb_conf->etscfg.prio_table[i];
+		dcb_info->tc_bws[i] = dcb_conf->etscfg.tcbwtable[i];
+		/* Using VMDQ pool zero since DCB+VMDQ is not supported */
+		uint16_t tc_rx_q_map = rte_le_to_cpu_16(ctxt.info.tc_mapping[i]);
+		dcb_info->tc_queue.tc_rxq[0][i].base = tc_rx_q_map & ICE_AQ_VSI_TC_Q_OFFSET_M;
+		dcb_info->tc_queue.tc_rxq[0][i].nb_queue =
+			1 << ((tc_rx_q_map & ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
+
+		dcb_info->tc_queue.tc_txq[0][i].base = dcb_info->tc_queue.tc_rxq[0][i].base;
+		dcb_info->tc_queue.tc_txq[0][i].nb_queue = dcb_info->tc_queue.tc_rxq[0][i].nb_queue;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 411b353417..1b09e7d81d 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -795,6 +795,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	struct ice_tlan_ctx tx_ctx;
 	int buf_len;
 	struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	u16 q_base, q_range, cgd_idx = 0;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -839,6 +840,26 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	tx_ctx.legacy_int = 1; /* Legacy or Advanced Host Interface */
 	tx_ctx.tsyn_ena = 1;
 
+	/* Mirror RXQ<->CGD association to TXQ<->CDG */
+	for (int i = 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
+		q_base = rte_le_to_cpu_16(vsi->info.tc_mapping[i]) & ICE_AQ_VSI_TC_Q_OFFSET_M;
+		q_range = 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
+			ICE_AQ_VSI_TC_Q_NUM_M) >> ICE_AQ_VSI_TC_Q_NUM_S);
+
+		if (q_base <= tx_queue_id && tx_queue_id < q_base + q_range)
+			break;
+
+		cgd_idx++;
+	}
+
+	if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
+		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
+		rte_free(txq_elem);
+		return -EINVAL;
+	}
+
+	tx_ctx.cgd_num = cgd_idx;
+
 	ice_set_ctx(hw, (uint8_t *)&tx_ctx, txq_elem->txqs[0].txq_ctx,
 		    ice_tlan_ctx_info);
 
-- 
2.43.0

