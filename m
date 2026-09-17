Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B95C982CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 06:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4729E400D6;
	Thu, 17 Sep 2026 08:36:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 6C061400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789626987; x=1821162987;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qp+6zd3+5DswCfy7yBv7S5IqXoRojaAKtc07oEWNOaM=;
 b=DpyQnG4fAjReXoXKnd3QNFvv7kGYSDveDuixxpjdq2kfHildefOpY+sF
 azQQDSGbEVbqjFVJV7fCxpVgDFAb2UXi7VMw7q9xSeurVcxEVAFLxcODp
 x1l/UOoMIBjI1vHZUF0dB0FtxQtwb4DlC1AHBUuHxAT6J3mp/8MOwKwL8
 RLDOfS9aLBm8sbmXKq9gyb2NuapbRlIiF9CcaB6D2SiUjgvpQDy7WuEoU
 BKTlzbZa3w/sOLwZOKQ8AW5qJ4oqe/Me9l1dW5UCzKvSdllTYrS+mvYCN
 /y8OSZDsQVJezhFLQLlDRBPblXU1HC4I+ibcmiZwMI14JwHGATr8zeb6o g==;
X-CSE-ConnectionGUID: 4EwSqeNqSc+VFQqyyH0new==
X-CSE-MsgGUID: hJ9v3rOLR1+k9Y3u5PU4IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107523744"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107523744"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 23:36:17 -0700
X-CSE-ConnectionGUID: /O0H8RWbSYmhoagkyp7BFA==
X-CSE-MsgGUID: zAOufYJQQZ6ub8Mx8ljdag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1814436"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa011.fm.intel.com with ESMTP; 16 Sep 2026 23:36:15 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2] net/ice: add per-queue Tx rate limit support
Date: Thu, 17 Sep 2026 06:38:23 +0000
Message-Id: <20260917063823.316379-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910100432.207328-1-anurag.mandal@intel.com>
References: <20260910100432.207328-1-anurag.mandal@intel.com>
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

The Tx rate can be limited per queue with
ethdev operation ``rte_eth_set_queue_rate_limit()``
and can be read through ``rte_eth_get_queue_rate_limit()``.

This feature uses the hardware packet pacing
mechanism to enforce a data rate on individual
Tx queues without tearing down the queue or
bouncing the port.

The rate is specified in Mbps.

ice_set_queue_rate_limit() applies the requested rate
as the EIR (maximum bandwidth) limit of the queue
scheduler node using ice_cfg_q_bw_lmt(),
converting the Mbps value taken by the API to the Kbps
expected by the scheduler.
A rate of 0 removes the limit and restores the default
bandwidth via ice_cfg_q_bw_dflt_lmt().

ice_get_queue_rate_limit() reads back the value cached
in the queue context by the scheduler on a successful
set, and reports 0 when the queue runs unlimited.

This interface and the Traffic Management API are
mutually exclusive.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Addressed Bruce Richardson's feedback
 - The per-queue Tx rate limit and Traffic Management APIs are mutually  exclusive.

 doc/guides/nics/features/ice.ini       |   1 +
 doc/guides/nics/ice.rst                |  26 +++++++
 doc/guides/rel_notes/release_26_11.rst |   2 +
 drivers/net/intel/ice/ice_ethdev.c     | 100 +++++++++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.h     |   2 +
 drivers/net/intel/ice/ice_tm.c         |  14 ++++
 6 files changed, 145 insertions(+)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 589916b2c1..2bf1b2a42d 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -30,6 +30,7 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 VLAN filter          = Y
+Rate limitation      = Y
 Traffic manager      = Y
 CRC offload          = Y
 VLAN offload         = Y
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index bdb3d61c23..bfb67a2cd3 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -925,6 +925,32 @@ Additional Options
       192.168.0.2', dst="192.168.0.3")/TCP(flags='S')/Raw(load='XXXXXXXXXX'), \
       iface="enp24s0f0", count=10)
 
+Per-Queue Tx Rate Limiting
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The maximum Tx rate of an individual queue can be capped using
+``rte_eth_set_queue_rate_limit()``, and read back using
+``rte_eth_get_queue_rate_limit()``.
+The rate is given in Mbps, and a rate of 0 removes the limit.
+
+The limit is applied to the queue's node in the Tx scheduler tree,
+which only exists while the queue is running,
+so the queue must be started before its rate can be set,
+and a configured rate is lost when the queue is stopped.
+
+This interface and the Traffic Management API are mutually exclusive,
+because both configure the bandwidth of the same scheduler nodes:
+
+* setting a queue rate limit fails while a Traffic Management
+  hierarchy is committed;
+
+* committing a Traffic Management hierarchy fails while any queue has
+  a rate limit set through ``rte_eth_set_queue_rate_limit()``.
+
+To switch from one to the other, clear the existing configuration first,
+either by setting the rate of each limited queue back to 0,
+or by deleting the Traffic Management hierarchy.
+
 Sample Application Notes
 ------------------------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index e725933fa7..19365fd0f2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -75,6 +75,8 @@ New Features
     paths, enabling QinQ tag insertion and outer IPv4/UDP checksum
     offloads on those paths.
 
+  * Added support for Tx rate limiting per queue.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 22578c9f28..dfee07c457 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -212,6 +212,10 @@ static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_
 						size_t *no_of_elements);
 static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
 static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
+static int ice_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+				    uint32_t tx_rate);
+static int ice_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+				    uint32_t *tx_rate);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -353,6 +357,8 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
 	.get_dcb_info                 =	ice_get_dcb_info,
 	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
+	.set_queue_rate_limit         = ice_set_queue_rate_limit,
+	.get_queue_rate_limit         = ice_get_queue_rate_limit,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -4207,6 +4213,100 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
 	return 0;
 }
 
+static int
+ice_set_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			 uint32_t tx_rate)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_vsi *vsi = pf->main_vsi;
+	int ret;
+
+	if (queue_idx >= dev->data->nb_tx_queues) {
+		PMD_DRV_LOG(ERR, "Tx queue %u is out of range (%u configured)",
+			    queue_idx, dev->data->nb_tx_queues);
+		return -EINVAL;
+	}
+
+	/*
+	 * A committed TM hierarchy owns the bandwidth of every scheduler node
+	 * and reapplies it on each commit, so the two interfaces are exclusive.
+	 */
+	if (pf->tm_conf.committed) {
+		PMD_DRV_LOG(ERR, "Tx rate limit cannot be set while a traffic manager hierarchy is committed");
+		return -EBUSY;
+	}
+
+	/*
+	 * The scheduler node of a Tx queue only exists once the queue has been
+	 * added to the Tx scheduler tree, which happens on queue start.
+	 */
+	if (dev->data->tx_queue_state[queue_idx] != RTE_ETH_QUEUE_STATE_STARTED) {
+		PMD_DRV_LOG(ERR, "Tx queue %u must be started before setting its rate limit",
+			    queue_idx);
+		return -EINVAL;
+	}
+
+	/* Rate is expressed in Mbps by the API, the scheduler uses Kbps. */
+	if (tx_rate > ICE_SCHED_MAX_BW / 1000) {
+		PMD_DRV_LOG(ERR, "Invalid Tx rate %u Mbps for queue %u, maximum is %u Mbps",
+			    tx_rate, queue_idx, (uint32_t)(ICE_SCHED_MAX_BW / 1000));
+		return -EINVAL;
+	}
+
+	/* A rate of 0 removes the limit and restores the default bandwidth. */
+	if (tx_rate == 0)
+		ret = ice_cfg_q_bw_dflt_lmt(hw->port_info, vsi->idx, 0,
+					    queue_idx, ICE_MAX_BW);
+	else
+		ret = ice_cfg_q_bw_lmt(hw->port_info, vsi->idx, 0, queue_idx,
+				       ICE_MAX_BW, tx_rate * 1000);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to set Tx rate limit on queue %u, error %d",
+			    queue_idx, ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Returns the rate limit currently programmed on a Tx queue, 0 if unlimited.
+ * The scheduler caches the requested rate, but that cache outlives the queue
+ * node, which is destroyed on queue stop and recreated with the default
+ * profile, so only trust it while the node still carries a rate limit.
+ */
+uint32_t
+ice_txq_rate_limit_kbps(struct ice_pf *pf, uint16_t queue_idx)
+{
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_sched_node *node;
+	struct ice_q_ctx *q_ctx;
+
+	q_ctx = ice_get_lan_q_ctx(hw, pf->main_vsi->idx, 0, queue_idx);
+	if (q_ctx == NULL)
+		return 0;
+
+	node = ice_sched_find_node_by_teid(hw->port_info->root, q_ctx->q_teid);
+	if (node == NULL ||
+	    rte_le_to_cpu_16(node->info.data.eir_bw.bw_profile_idx) ==
+	    ICE_SCHED_DFLT_RL_PROF_ID)
+		return 0;
+
+	return q_ctx->bw_t_info.eir_bw.bw;
+}
+
+static int
+ice_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			 uint32_t *tx_rate)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+
+	*tx_rate = ice_txq_rate_limit_kbps(pf, queue_idx) / 1000;
+
+	return 0;
+}
+
 static void
 __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 		       int base_queue, int nb_queue)
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 3cfd7afbae..e39757e842 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -832,4 +832,6 @@ int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
 int
 ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32_t node_teid);
 
+uint32_t ice_txq_rate_limit_kbps(struct ice_pf *pf, uint16_t queue_idx);
+
 #endif /* _ICE_ETHDEV_H_ */
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index d93704dd3f..9566a36098 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -903,8 +903,22 @@ ice_hierarchy_commit(struct rte_eth_dev *dev,
 				 int clear_on_fail,
 				 struct rte_tm_error *error)
 {
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	bool restart = false;
 
+	/*
+	 * A commit reapplies the bandwidth of every node, which would silently
+	 * discard any rate set through rte_eth_set_queue_rate_limit().
+	 */
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		if (ice_txq_rate_limit_kbps(pf, i) != 0) {
+			error->type = RTE_TM_ERROR_TYPE_UNSPECIFIED;
+			error->message =
+				"queue rate limit already set via rte_eth_set_queue_rate_limit";
+			return -EBUSY;
+		}
+	}
+
 	/* commit should only be done to topology before start
 	 * If port is already started, stop it and then restart when done.
 	 */
-- 
2.34.1

