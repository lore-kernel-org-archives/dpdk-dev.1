Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38065C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA76E410DC;
	Thu, 10 Sep 2026 12:02:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DA7A14028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789034531; x=1820570531;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HNoa4PC/eYYWVae6NsDAthKuUUuly3APeH6XBNMIQ4E=;
 b=m5hzutw0liwPRRU0r9OlsemJEvbSjVX2QqUYAjEbKgj1/bbN/Cy5fPIt
 CIHWSNzHJdTAV+0k1x8zIoxHzyLlXuus92qDysmcmXDKVqqjYsBP90d1K
 2IdqFdSzmUHEYm0oRVyiMfCY9ifcoU3QWCrgbDPzH2u3GOLB2t5qXU2Nz
 bEvgAV/1sLiAk41jQbU96NowBRWcjbMGW5HmUMHdU7xuy7WgPCCqMmQ+F
 3zwawOhoCGkIvK5axy803XK5sVxhPsv6pKbeg0gwiy0IpUxC1NWTG8+r0
 qIR2S3L7VBMhfC/3/T0YBL4dZRcp1bo7W0XMusUaHlhRK/erYg5RYKARI g==;
X-CSE-ConnectionGUID: kLLbqH/FQASTs8qno3RrrA==
X-CSE-MsgGUID: KB70WekNREiR9M1b23BhrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="77038127"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="77038127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:02:10 -0700
X-CSE-ConnectionGUID: Pv8qheW3SXSHO38XiDW5tQ==
X-CSE-MsgGUID: rNR+kGS0RVKaz3xwlSAWkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270231117"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa010.jf.intel.com with ESMTP; 10 Sep 2026 03:02:08 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/ice: add per-queue Tx rate limit support
Date: Thu, 10 Sep 2026 10:04:32 +0000
Message-Id: <20260910100432.207328-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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
Tx queues without tearing down the queue.

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

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 doc/guides/nics/features/ice.ini       |  1 +
 doc/guides/rel_notes/release_26_11.rst |  3 +
 drivers/net/intel/ice/ice_ethdev.c     | 77 ++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index 893d09e9ec..6b21d56144 100644
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 907f9013ff..1567f93563 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,9 @@ New Features
   * Renamed the ``enable_ptype_lldp`` devarg to ``enable_lldp``.
     The old name is no longer accepted.
 
+* **Updated Intel ice driver.**
+
+  * Added support for Tx rate limiting per queue.
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..8ae2842098 100644
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
@@ -4205,6 +4211,77 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
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
+	/* The scheduler node of a Tx queue only exists once the queue has been
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
+static int
+ice_get_queue_rate_limit(struct rte_eth_dev *dev, uint16_t queue_idx,
+			 uint32_t *tx_rate)
+{
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct ice_hw *hw = ICE_PF_TO_HW(pf);
+	struct ice_vsi *vsi = pf->main_vsi;
+	struct ice_q_ctx *q_ctx;
+
+	q_ctx = ice_get_lan_q_ctx(hw, vsi->idx, 0, queue_idx);
+	if (q_ctx == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to get the context of Tx queue %u",
+			    queue_idx);
+		return -EINVAL;
+	}
+
+	/* The scheduler caches the EIR limit in Kbps, and stores 0 when the
+	 * queue runs at the default (unlimited) bandwidth.
+	 */
+	*tx_rate = q_ctx->bw_t_info.eir_bw.bw / 1000;
+
+	return 0;
+}
+
 static void
 __vsi_queues_bind_intr(struct ice_vsi *vsi, uint16_t msix_vect,
 		       int base_queue, int nb_queue)
-- 
2.34.1

