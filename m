Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA8C79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 13:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108EC40A8A;
	Mon,  7 Sep 2026 15:08:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BB73F4069F;
 Mon,  7 Sep 2026 15:08:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788786482; x=1820322482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dfb4u6D2Itbda8CQaEZmEyhm1bAKzNTuvLn/0ZdnfX0=;
 b=d2tVtQcgGH9Pd0jdwg63hk5AmiTcyQzXuwgsH0OF4y6sToImjQlQX1p2
 m5HUrYZDGVPl6Aay8Lmi3cse3KdETW+dAvdyokXUJaSshw8FYfxiTeOTM
 aPT9+CklPNULvkG4pgkUxLRKAKnmQxXm9oHP3ouxcMqY6ojI2Hpg7LTym
 J3AOYB4mLC1Mj0DuUrewO2BkjlUUhETLDZ2fPSXrpGAKjYBLs56x/pf0y
 oIX84RFKdy6T1jN061aTRJ3hm6WWvpgblaFxP8A/G01i8EQYqFbq40Sv3
 mL8/+o1bre5bDlNkqlwaSCTvS+jkKoZQQ1aogkGke1h3yDNYZQfQBY6Lw g==;
X-CSE-ConnectionGUID: jXx9ynj+RCi9NDkAeIPB+g==
X-CSE-MsgGUID: eMzxc0FzSL64esZQT/9GWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="106705971"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="106705971"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 06:08:01 -0700
X-CSE-ConnectionGUID: cyJ8AXtcSDqjBbu25DDpGg==
X-CSE-MsgGUID: J2lNKoiqSbqrE2tt4P+9yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="270682397"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 07 Sep 2026 06:08:00 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 3/4] net/ice: fix Rx queue count reporting after TM commit
Date: Mon,  7 Sep 2026 13:07:49 +0000
Message-ID: <20260907130750.3406004-4-ciara.loftus@intel.com>
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

Currently, ice_dev_info_get() assigns the value of `vsi->nb_qps` to both
`max_rx_queues` and `max_tx_queues`.

After a Tx scheduler hierarchy is committed, the value of nb_qps may grow
to reflect the VSI's larger Tx scheduler capacity. However the Tx scheduler
hierarchy change has no effect on the VSI's Rx queue allocation,
which stays fixed at its original size for the life of the port. An
application can then request more Rx queues than the VSI's actual Rx
resources support when the inflated nb_qps is assigned to `max_rx_queues`.

`vsi->nb_qps` also feeds `ice_vsi_disable_queues_intr()`, which clears
both Rx and Tx queue interrupt registers by absolute queue index on
every port stop. Once `nb_qps` grows past the VSI's fixed queue window,
this can clear interrupt registers belonging to a different VSI.

Fix this by introducing `vsi->nb_tm_txqs` to track the Tx scheduler
capacity as it grows, leaving `vsi->nb_qps` as the VSI's fixed
queue allocation for the life of the port. `ice_vsi_disable_queues_intr()`
is switched to `nb_used_qps`, which already tracks the actually configured
queue count.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* renamed nb_tm_qps to nb_tm_txqs
---
 drivers/net/intel/ice/ice_ethdev.c | 5 +++--
 drivers/net/intel/ice/ice_ethdev.h | 1 +
 drivers/net/intel/ice/ice_tm.c     | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index fd148848d3c..b7ccace623b 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1816,6 +1816,7 @@ ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type)
 				     ret);
 			goto fail_mem;
 		}
+		vsi->nb_tm_txqs = vsi->nb_qps;
 
 		break;
 	case ICE_VSI_CTRL:
@@ -2924,7 +2925,7 @@ ice_vsi_disable_queues_intr(struct ice_vsi *vsi)
 	uint16_t msix_intr, i;
 
 	/* disable interrupt and also clear all the exist config */
-	for (i = 0; i < vsi->nb_qps; i++) {
+	for (i = 0; i < vsi->nb_used_qps; i++) {
 		ICE_WRITE_REG(hw, QINT_TQCTL(vsi->base_queue + i), 0);
 		ICE_WRITE_REG(hw, QINT_RQCTL(vsi->base_queue + i), 0);
 		rte_wmb();
@@ -4628,7 +4629,7 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_rx_bufsize = ICE_BUF_SIZE_MIN;
 	dev_info->max_rx_pktlen = ICE_FRAME_SIZE_MAX;
 	dev_info->max_rx_queues = vsi->nb_qps;
-	dev_info->max_tx_queues = vsi->nb_qps;
+	dev_info->max_tx_queues = vsi->nb_tm_txqs;
 	dev_info->max_mac_addrs = vsi->max_macaddrs;
 	dev_info->max_vfs = pci_dev->max_vfs;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - ICE_ETH_OVERHEAD;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 5914454c7c2..f8e18e68f08 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -330,6 +330,7 @@ struct ice_vsi {
 	struct ice_mac_filter_list mac_list; /* macvlan filter list */
 	struct ice_vlan_filter_list vlan_list; /* vlan filter list */
 	uint16_t nb_qps;         /* Number of queue pairs VSI can occupy */
+	uint16_t nb_tm_txqs;     /* Number of Tx queues usable by the committed TM hierarchy */
 	uint16_t nb_used_qps;    /* Number of queue pairs VSI uses */
 	uint16_t max_macaddrs;   /* Maximum number of MAC addresses */
 	uint16_t base_queue;     /* The first queue index of this VSI */
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 651d6aa932d..48bc1f39426 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -859,9 +859,9 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 		}
 		/* TM hierarchy deleted. Restore default scheduler state. */
 		reset_hw_node_recursive(hw, hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0]);
-		pf->main_vsi->nb_qps = pf->lan_nb_qps;
+		pf->main_vsi->nb_tm_txqs = pf->lan_nb_qps;
 		pf->tm_conf.committed = false;
-		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
+		return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_txqs);
 	}
 
 	/* handle case where VSI node needs to move DOWN the hierarchy */
@@ -889,13 +889,13 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 				nodes_created_per_level[i], i);
 	hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0] = new_vsi_root;
 
-	pf->main_vsi->nb_qps =
+	pf->main_vsi->nb_tm_txqs =
 			RTE_MIN(nodes_created_per_level[qg_lvl] * hw->max_children[qg_lvl],
 				hw->layer_info[q_lvl].max_device_nodes);
 
 	pf->tm_conf.committed = true; /* set flag to be checks on queue start */
 
-	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_qps);
+	return ice_alloc_lan_q_ctx(hw, 0, 0, pf->main_vsi->nb_tm_txqs);
 }
 
 static int
-- 
2.43.0

