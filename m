Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF098CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B266740290;
	Wed,  7 Oct 2026 09:56:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7E6EC40289
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791359799; x=1822895799;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tPVKyEdGXZQI6/wofNzsIWYxmoSBTrZ75om/sSgZNNg=;
 b=RbSgljodRW1tmc0k0QVTZIHxL4d0sGP8xwpq6TNNzVjPl32B7IutjKAR
 MponKPtDaruNnBo/L1TWAJpWEQOOQQ+zd0ZfFCcZP9P7zf4Gl/kInxpEl
 /viPlNkflzh6biw0dPKq+nmEt5Yyo1+/RTlU79k4aKEJm42ehjyFH0u8f
 MaYlO8lEXm9sPObrj5miUh1uuLA+txx/twDRho1oXR9OOTNN9UfApir/G
 zPHQo3FwcmY68mQOK0FYhAMgL0SKbnTXv7Y1xd7VKscTrNNnkdQtqo1L9
 i9O6ulOk10OKmUfqmnsorTXShnN7PsHkRlh5NOqsjoXn/L9SBteYC+pr8 g==;
X-CSE-ConnectionGUID: PmRIePHqQtKT4KPxI3oMDA==
X-CSE-MsgGUID: Y0Ph6q6RTTKCz6kmWzT7Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="216880"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="216880"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 00:56:38 -0700
X-CSE-ConnectionGUID: J42QR/jnR3arBUlbMbmv1w==
X-CSE-MsgGUID: iYaVH1SMStGZsdnrvKC0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="285301190"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 07 Oct 2026 00:56:36 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 1/2] net/ice: free memory with matching allocator
Date: Wed,  7 Oct 2026 07:58:19 +0000
Message-Id: <c9d029d702469ebb734cdc1117ee55bfcafeadb0.1791356190.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791356190.git.anurag.mandal@intel.com>
References: <cover.1791356190.git.anurag.mandal@intel.com>
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

Several buffers allocated with ice_malloc(), ice_calloc() or
ice_memdup() were released using rte_free() instead of ice_free().
Both APIs currently map to the same underlying allocator.
However, mixing them is inconsistent and could break if the
inconsistent and could break if the OS abstraction layer changes.

Use ice_free() for all memory obtained through the ice_malloc()
family.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c  | 10 +++++-----
 drivers/net/intel/ice/ice_dcf.c         |  2 +-
 drivers/net/intel/ice/ice_dcf_parent.c  |  2 +-
 drivers/net/intel/ice/ice_ethdev.c      | 14 +++++++-------
 drivers/net/intel/ice/ice_fdir_filter.c | 12 ++++++------
 drivers/net/intel/ice/ice_rxtx.c        | 18 +++++++++---------
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 30ff1254c9..a91bd558f3 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -86,11 +86,11 @@ ice_acl_prof_alloc(struct ice_hw *hw)
 fail_mem:
 	for (fltr_ptype = ICE_FLTR_PTYPE_NONF_NONE + 1;
 	     fltr_ptype < ptype; fltr_ptype++) {
-		rte_free(hw->acl_prof[fltr_ptype]);
+		ice_free(hw, hw->acl_prof[fltr_ptype]);
 		hw->acl_prof[fltr_ptype] = NULL;
 	}
 
-	rte_free(hw->acl_prof);
+	ice_free(hw, hw->acl_prof);
 	hw->acl_prof = NULL;
 
 	return -ENOMEM;
@@ -148,7 +148,7 @@ static void ice_deinit_acl(struct ice_pf *pf)
 
 	ice_acl_destroy_tbl(hw);
 
-	rte_free(hw->acl_tbl);
+	ice_free(hw, hw->acl_tbl);
 	hw->acl_tbl = NULL;
 
 	if (pf->acl.slots) {
@@ -1102,11 +1102,11 @@ ice_acl_prof_free(struct ice_hw *hw)
 
 	for (ptype = ICE_FLTR_PTYPE_NONF_NONE + 1;
 	     ptype < ICE_FLTR_PTYPE_MAX; ptype++) {
-		rte_free(hw->acl_prof[ptype]);
+		ice_free(hw, hw->acl_prof[ptype]);
 		hw->acl_prof[ptype] = NULL;
 	}
 
-	rte_free(hw->acl_prof);
+	ice_free(hw, hw->acl_prof);
 	hw->acl_prof = NULL;
 }
 
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 3b635c0822..976f2ed260 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -913,7 +913,7 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 	rte_free(hw->qos_bw_cfg);
 	hw->qos_bw_cfg = NULL;
 
-	rte_free(hw->ets_config);
+	ice_free(hw, hw->ets_config);
 	hw->ets_config = NULL;
 }
 
diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index 2c7d94b50d..e6398205ce 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -295,7 +295,7 @@ ice_dcf_query_port_ets(struct ice_hw *parent_hw, struct ice_dcf_hw *real_hw)
 			NULL);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "DCF Query Port ETS failed");
-		rte_free(real_hw->ets_config);
+		ice_free(real_hw, real_hw->ets_config);
 		real_hw->ets_config = NULL;
 		return ret;
 	}
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 9bfa585c06..11b549a452 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1178,7 +1178,7 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	ret = 0;
 
 DONE:
-	rte_free(m_list_itr);
+	ice_free(hw, m_list_itr);
 	return ret;
 }
 
@@ -1229,7 +1229,7 @@ ice_remove_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 
 	ret = 0;
 DONE:
-	rte_free(m_list_itr);
+	ice_free(hw, m_list_itr);
 	return ret;
 }
 
@@ -1314,7 +1314,7 @@ ice_add_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 	ret = 0;
 
 DONE:
-	rte_free(v_list_itr);
+	ice_free(hw, v_list_itr);
 	return ret;
 }
 
@@ -1372,7 +1372,7 @@ ice_remove_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 
 	ret = 0;
 DONE:
-	rte_free(v_list_itr);
+	ice_free(hw, v_list_itr);
 	return ret;
 }
 
@@ -2572,7 +2572,7 @@ ice_get_hw_res(struct ice_hw *hw, uint16_t res_type,
 			(*num_prof), ICE_NONDMA_TO_NONDMA);
 
 exit:
-	rte_free(resp_buf);
+	ice_free(hw, resp_buf);
 	return ret;
 }
 static int
@@ -2772,7 +2772,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 		ret = ice_init_hw_tbls(hw);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "ice_init_hw_tbls failed: %d", ret);
-			rte_free(hw->pkg_copy);
+			ice_free(hw, hw->pkg_copy);
 		}
 	}
 
@@ -3098,7 +3098,7 @@ ice_dev_close(struct rte_eth_dev *dev)
 	ice_release_vsi(pf->main_vsi);
 	ice_sched_cleanup_all(hw);
 	ice_free_hw_tbls(hw);
-	rte_free(hw->port_info);
+	ice_free(hw, hw->port_info);
 	hw->port_info = NULL;
 	free((void *)(uintptr_t)ad->devargs.ddp_filename);
 	ad->devargs.ddp_filename = NULL;
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index d7ddd32f90..517c32cecf 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -231,11 +231,11 @@ ice_fdir_prof_alloc(struct ice_hw *hw)
 	for (fltr_ptype = ICE_FLTR_PTYPE_NONF_NONE + 1;
 	     fltr_ptype < ptype;
 	     fltr_ptype++) {
-		rte_free(hw->fdir_prof[fltr_ptype]);
+		ice_free(hw, hw->fdir_prof[fltr_ptype]);
 		hw->fdir_prof[fltr_ptype] = NULL;
 	}
 
-	rte_free(hw->fdir_prof);
+	ice_free(hw, hw->fdir_prof);
 	hw->fdir_prof = NULL;
 
 	return -ENOMEM;
@@ -608,11 +608,11 @@ ice_fdir_prof_free(struct ice_hw *hw)
 	for (ptype = ICE_FLTR_PTYPE_NONF_NONE + 1;
 	     ptype < ICE_FLTR_PTYPE_MAX;
 	     ptype++) {
-		rte_free(hw->fdir_prof[ptype]);
+		ice_free(hw, hw->fdir_prof[ptype]);
 		hw->fdir_prof[ptype] = NULL;
 	}
 
-	rte_free(hw->fdir_prof);
+	ice_free(hw, hw->fdir_prof);
 	hw->fdir_prof = NULL;
 }
 
@@ -644,7 +644,7 @@ ice_fdir_prof_rm(struct ice_pf *pf, enum ice_fltr_ptype ptype, bool is_tunnel)
 		}
 	}
 	ice_flow_rem_prof(hw, ICE_BLK_FD, prof_id);
-	rte_free(hw_prof->fdir_seg[is_tunnel]);
+	ice_free(hw, hw_prof->fdir_seg[is_tunnel]);
 	hw_prof->fdir_seg[is_tunnel] = NULL;
 
 	for (i = 0; i < hw_prof->cnt; i++)
@@ -1350,7 +1350,7 @@ ice_fdir_input_set_conf(struct ice_pf *pf, enum ice_fltr_ptype flow,
 	if (!ret) {
 		return ret;
 	} else if (ret < 0) {
-		rte_free(seg_tun);
+		ice_free(pf->adapter->hw, seg_tun);
 		return (ret == -EEXIST) ? 0 : ret;
 	} else {
 		return ret;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 882af80833..c8b88fb235 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -854,13 +854,13 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		}
 		if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
 			PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
-			rte_free(txq_elem);
+			ice_free(hw, txq_elem);
 			return -EINVAL;
 		}
 	} else if (pf->dcb_num_tcs > 1) {
 		/* TM only manages the TC0 scheduler subtree. */
 		PMD_DRV_LOG(ERR, "TM hierarchy is not supported together with multi-TC DCB");
-		rte_free(txq_elem);
+		ice_free(hw, txq_elem);
 		return -EINVAL;
 	}
 
@@ -874,7 +874,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			txq_elem, buf_len, NULL);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to add lan txq");
-		rte_free(txq_elem);
+		ice_free(hw, txq_elem);
 		return -EIO;
 	}
 	/* store the schedule node id */
@@ -884,7 +884,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	if (pf->tm_conf.committed)
 		if (ice_tm_setup_txq_node(pf, hw, tx_queue_id, txq->q_teid) != 0) {
 			PMD_DRV_LOG(ERR, "Failed to set up txq traffic management node");
-			rte_free(txq_elem);
+			ice_free(hw, txq_elem);
 			return -EIO;
 		}
 
@@ -909,10 +909,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
 
 		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem, ts_buf_len, NULL);
-		rte_free(ts_elem);
+		ice_free(hw, ts_elem);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
-			rte_free(txq_elem);
+			ice_free(hw, txq_elem);
 			return err;
 		}
 	} else {
@@ -924,7 +924,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
-	rte_free(txq_elem);
+	ice_free(hw, txq_elem);
 	return 0;
 }
 
@@ -1096,13 +1096,13 @@ ice_fdir_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			      txq_elem, buf_len, NULL);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to add FDIR txq");
-		rte_free(txq_elem);
+		ice_free(hw, txq_elem);
 		return -EIO;
 	}
 	/* store the schedule node id */
 	txq->q_teid = txq_elem->txqs[0].q_teid;
 
-	rte_free(txq_elem);
+	ice_free(hw, txq_elem);
 	return 0;
 }
 
-- 
2.34.1

