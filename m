Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A6C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 13:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01C7540B90;
	Mon,  7 Sep 2026 15:08:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7D09D4069F
 for <dev@dpdk.org>; Mon,  7 Sep 2026 15:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788786483; x=1820322483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8LqoEZGvey5Pu02KJtrXYNLJPE1NqEjTThnsb6KBci0=;
 b=Xvb/TRoK5IiD1krobrwazqi3ke7VFP8fjtzmWbQEREKzc/YTv+u2Nn2V
 H+R0OR6PzArQYKV6xtTGSYziyT36P4MnJDzT17tXHbBbo0wBxAmbasT3/
 IyIMSfdd/NdpxfBBc22IFxoiHvpEAewByA37k3aOArNB7BLHp2bHCREiQ
 J0klwGZE7dOHykKCNX42GGW2JcVorjtqaD1x3DQtNvpXKrKMT+JCfzB6Q
 QipciWoKtVz9CfU7HfOVmyug7fAzu8Zmgcro3G2bZounlIfVWbN5JM9Ib
 Vd10LHLxwVGkj+6ijdobcMYihxIraTlddLrNQQag9UQg7qBS+b/q9vPfj w==;
X-CSE-ConnectionGUID: 7mDrXO3vQ0SPxdh0kVpf1A==
X-CSE-MsgGUID: wy6uyVZLSA26uEB6AUqC5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="106705974"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="106705974"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 06:08:02 -0700
X-CSE-ConnectionGUID: 5B6T8vsESR2QNxfc/6+JKA==
X-CSE-MsgGUID: l9b+geTaRuKlXvOkI80RRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="270682403"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 07 Sep 2026 06:08:01 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 4/4] net/ice: split VSI queue count into Rx/Tx
Date: Mon,  7 Sep 2026 13:07:50 +0000
Message-ID: <20260907130750.3406004-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907130750.3406004-1-ciara.loftus@intel.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260907130750.3406004-1-ciara.loftus@intel.com>
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

The number of rxqs and txqs ie. "queue pairs" was tracked in a single
variable `vsi->nb_qps` prior to this commit. A second variable `nb_tm_txqs`
was then introduced to track the number of txqs independently of the rxqs,
since the TM hierarchy could grow the number of txqs beyond the initial
symmetric allocation. Since the number of rxqs and txqs can diverge, it
doesn't make much sense to maintain the `vsi->nb_qps` variable anymore.
This commit drops that variable and instead introduces two variables
`vsi->nb_txqs` and `vsi->nb_rxqs` to track txqs and rxqs separately.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 37 ++++++++++++++----------------
 drivers/net/intel/ice/ice_ethdev.h |  4 ++--
 drivers/net/intel/ice/ice_tm.c     |  8 +++----
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index b7ccace623b..22578c9f28d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1002,10 +1002,10 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
 
 	/* vector 0 is reserved and 1 vector for ctrl vsi */
 	if (vsi->adapter->hw.func_caps.common_cap.num_msix_vectors < 2) {
-		vsi->nb_qps = 0;
+		vsi->nb_rxqs = 0;
 	} else {
-		vsi->nb_qps = RTE_MIN(vsi->nb_qps, ICE_MAX_Q_PER_TC);
-		vsi->nb_qps = RTE_MIN(vsi->nb_qps,
+		vsi->nb_rxqs = RTE_MIN(vsi->nb_rxqs, ICE_MAX_Q_PER_TC);
+		vsi->nb_rxqs = RTE_MIN(vsi->nb_rxqs,
 			(uint16_t)vsi->adapter->hw.func_caps.common_cap.num_msix_vectors - 2);
 
 		/* cap max QPs to what the HW reports as num-children for each layer.
@@ -1017,13 +1017,13 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
 		uint32_t max_sched_vsi_nodes = 1;
 		for (uint8_t i = hw->sw_entry_point_layer; i < hw->num_tx_sched_layers - 1; i++) {
 			max_sched_vsi_nodes *= hw->max_children[i];
-			if (max_sched_vsi_nodes >= vsi->nb_qps)
+			if (max_sched_vsi_nodes >= vsi->nb_rxqs)
 				break;
 		}
-		vsi->nb_qps = RTE_MIN(vsi->nb_qps, max_sched_vsi_nodes);
+		vsi->nb_rxqs = RTE_MIN(vsi->nb_rxqs, max_sched_vsi_nodes);
 	}
 
-	/* nb_qps(hex)  -> fls */
+	/* nb_rxqs(hex)  -> fls */
 	/* 0000		-> 0 */
 	/* 0001		-> 0 */
 	/* 0002		-> 1 */
@@ -1034,7 +1034,7 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
 	/* 0021 ~ 0040	-> 6 */
 	/* 0041 ~ 0080	-> 7 */
 	/* 0081 ~ 0100	-> 8 */
-	fls = (vsi->nb_qps == 0) ? 0 : rte_fls_u32(vsi->nb_qps - 1);
+	fls = (vsi->nb_rxqs == 0) ? 0 : rte_fls_u32(vsi->nb_rxqs - 1);
 
 	qp_idx = 0;
 	/* Set tc and queue mapping with VSI */
@@ -1045,7 +1045,7 @@ ice_vsi_config_tc_queue_mapping(struct ice_hw *hw, struct ice_vsi *vsi,
 	/* Associate queue number with VSI */
 	info->mapping_flags |= rte_cpu_to_le_16(ICE_AQ_VSI_Q_MAP_CONTIG);
 	info->q_mapping[0] = rte_cpu_to_le_16(vsi->base_queue);
-	info->q_mapping[1] = rte_cpu_to_le_16(vsi->nb_qps);
+	info->q_mapping[1] = rte_cpu_to_le_16(vsi->nb_rxqs);
 	info->valid_sections |=
 		rte_cpu_to_le_16(ICE_AQ_VSI_PROP_RXQ_MAP_VALID);
 	/* Set the info.ingress_table and info.egress_table
@@ -1753,7 +1753,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 	memset(&vsi_ctx, 0, sizeof(vsi_ctx));
 	switch (type) {
 	case ICE_VSI_PF:
-		vsi->nb_qps = pf->lan_nb_qps;
+		vsi->nb_rxqs = pf->lan_nb_qps;
 		vsi->base_queue = 1;
 		ice_vsi_config_default_rss(&vsi_ctx.info);
 		vsi_ctx.alloc_from_pool = true;
@@ -1816,11 +1816,11 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 				     ret);
 			goto fail_mem;
 		}
-		vsi->nb_tm_txqs = vsi->nb_qps;
+		vsi->nb_txqs = vsi->nb_rxqs;
 
 		break;
 	case ICE_VSI_CTRL:
-		vsi->nb_qps = pf->fdir_nb_qps;
+		vsi->nb_rxqs = pf->fdir_nb_qps;
 		vsi->base_queue = ICE_FDIR_QUEUE_ID;
 		vsi_ctx.alloc_from_pool = true;
 		vsi_ctx.flags = ICE_AQ_VSI_TYPE_PF;
@@ -1841,6 +1841,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 				     ret);
 			goto fail_mem;
 		}
+		vsi->nb_txqs = vsi->nb_rxqs;
 		break;
 	default:
 		/* for other types of VSI */
@@ -1851,14 +1852,14 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 	/* VF has MSIX interrupt in VF range, don't allocate here */
 	if (type == ICE_VSI_PF) {
 		ret = ice_res_pool_alloc(&pf->msix_pool,
-					 RTE_MIN(vsi->nb_qps,
+					 RTE_MIN(vsi->nb_rxqs,
 						 RTE_MAX_RXTX_INTR_VEC_ID));
 		if (ret < 0) {
 			PMD_INIT_LOG(ERR, "VSI MAIN %d get heap failed %d",
 				     vsi->vsi_id, ret);
 		}
 		vsi->msix_intr = ret;
-		vsi->nb_msix = RTE_MIN(vsi->nb_qps, RTE_MAX_RXTX_INTR_VEC_ID);
+		vsi->nb_msix = RTE_MIN(vsi->nb_rxqs, RTE_MAX_RXTX_INTR_VEC_ID);
 	} else if (type == ICE_VSI_CTRL) {
 		ret = ice_res_pool_alloc(&pf->msix_pool, 1);
 		if (ret < 0) {
@@ -1900,11 +1901,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 	}
 
 	/* At the beginning, only TC0. */
-	/* What we need here is the maximum number of the TX queues.
-	 * Currently vsi->nb_qps means it.
-	 * Correct it if any change.
-	 */
-	max_txqs[0] = vsi->nb_qps;
+	max_txqs[0] = vsi->nb_txqs;
 	ret = ice_cfg_vsi_lan(hw->port_info, vsi->idx,
 			      tc_bitmap, max_txqs);
 	if (ret != ICE_SUCCESS)
@@ -4628,8 +4625,8 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
 	dev_info->min_rx_bufsize = ICE_BUF_SIZE_MIN;
 	dev_info->max_rx_pktlen = ICE_FRAME_SIZE_MAX;
-	dev_info->max_rx_queues = vsi->nb_qps;
-	dev_info->max_tx_queues = vsi->nb_tm_txqs;
+	dev_info->max_rx_queues = vsi->nb_rxqs;
+	dev_info->max_tx_queues = vsi->nb_txqs;
 	dev_info->max_mac_addrs = vsi->max_macaddrs;
 	dev_info->max_vfs = pci_dev->max_vfs;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - ICE_ETH_OVERHEAD;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index f8e18e68f08..1d038016afc 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -329,8 +329,8 @@ struct ice_vsi {
 	uint16_t mac_num;        /* Total mac number */
 	struct ice_mac_filter_list mac_list; /* macvlan filter list */
 	struct ice_vlan_filter_list vlan_list; /* vlan filter list */
-	uint16_t nb_qps;         /* Number of queue pairs VSI can occupy */
-	uint16_t nb_tm_txqs;     /* Number of Tx queues usable by the committed TM hierarchy */
+	uint16_t nb_rxqs;        /* Number of Rx queues VSI can occupy */
+	uint16_t nb_txqs;        /* Number of Tx queues VSI can occupy, grows with TM hierarchy */
 	uint16_t nb_used_qps;    /* Number of queue pairs VSI uses */
 	uint16_t max_macaddrs;   /* Maximum number of MAC addresses */
 	uint16_t base_queue;     /* The first queue index of this VSI */
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 48bc1f39426..d93704dd3f9 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -859,9 +859,9 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 		}
 		/* TM hierarchy deleted. Restore default scheduler state. */
 		reset_hw_node_recursive(hw, hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0]);
-		pf->main_vsi->nb_tm_txqs = pf->lan_nb_qps;
+		pf->main_vsi->nb_txqs = pf->lan_nb_qps;
 		pf->tm_conf.committed = false;
-		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_txqs);
+		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_txqs);
 	}
 
 	/* handle case where VSI node needs to move DOWN the hierarchy */
@@ -889,13 +889,13 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 				nodes_created_per_level[i], i);
 	hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0] = new_vsi_root;
 
-	pf->main_vsi->nb_tm_txqs =
+	pf->main_vsi->nb_txqs =
 			RTE_MIN(nodes_created_per_level[qg_lvl] * hw->max_children[qg_lvl],
 				hw->layer_info[q_lvl].max_device_nodes);
 
 	pf->tm_conf.committed = true; /* set flag to be checks on queue start */
 
-	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_txqs);
+	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_txqs);
 }
 
 static int
-- 
2.43.0

