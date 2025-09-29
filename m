Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBFCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 675E040A81;
	Mon, 29 Sep 2025 17:00:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 365DF40289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759158020; x=1790694020;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3JBzN6KeD1h2LUaMTx7N61eiWn1seCfhlqfLBXiKQ2k=;
 b=UUro8bBgBweyMVIAsCVb3F0OI+WwMPcOJfDMR7BI2J1BWyDgr2TzW+Te
 Pkay5XeJu0Z2OQw0bbs0FOR7H0R6ZnrkSBOH9qrwq7WYMPz5DnhTS25kG
 ngf7fmK7EGRbXkxq224DIrU8diR1I1fo8UlDjJIA9BofSKD+u2EWyl2Kx
 1zdHo186CfsjXcGSsb8uMhHXx6nYYCxLy+Bs1jEWISQN+dvtcpad8ugMr
 fRJx7Wm54DPnaZPlIt96YBD8WDn7i5zlmoXXetpCgL2POfM1N23gTKp1S
 qTpqtXtQ0BFluV9u1JSHE75PeNt4SjxY2L0BeHD+89RmBxK6e54Dn+oLw A==;
X-CSE-ConnectionGUID: EU4IxawrRAOsWbjuW1wI9w==
X-CSE-MsgGUID: Z2FVqBmXRGeQm0hr+4sxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84017126"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="84017126"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:00:19 -0700
X-CSE-ConnectionGUID: l92+/hxdS7OaWlSj1mIT6Q==
X-CSE-MsgGUID: UWB3PDgcSbWb5SSQzYjjvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178638019"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2025 08:00:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 4/6] drivers/net: update to remove queue stats from eth
 stats
Date: Mon, 29 Sep 2025 16:00:07 +0100
Message-ID: <20250929150009.1542208-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929150009.1542208-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
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

Now that we have removed the queue stats from the ethdev stats, we need
to update the various PMDs to take account of the changes.

Update each stats_get function to take the extra parameters for qstats,
just marking it as unused if the driver does not fill in queue stats.
For those that do complete queue stats, update the structure reference
as appropriate.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
 drivers/net/ark/ark_ethdev.c                  |  36 +++--
 drivers/net/ark/ark_ethdev_rx.c               |  14 +-
 drivers/net/ark/ark_ethdev_rx.h               |   3 +-
 drivers/net/ark/ark_ethdev_tx.c               |  12 +-
 drivers/net/ark/ark_ethdev_tx.h               |   3 +-
 drivers/net/atlantic/atl_ethdev.c             |  19 +--
 drivers/net/atlantic/atl_types.h              |   1 +
 drivers/net/avp/avp_ethdev.c                  |  20 ++-
 drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
 drivers/net/axgbe/axgbe_ethdev.h              |   1 +
 drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
 drivers/net/bnxt/bnxt_reps.c                  |  14 +-
 drivers/net/bnxt/bnxt_reps.h                  |   2 +-
 drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
 drivers/net/bnxt/bnxt_stats.h                 |   2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
 drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
 drivers/net/cnxk/cnxk_rep.h                   |   3 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
 drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
 drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
 drivers/net/ena/ena_ethdev.c                  |  46 +++---
 drivers/net/enetc/enetc_ethdev.c              |   4 +-
 drivers/net/enetfec/enet_ethdev.c             |   3 +-
 drivers/net/enic/enic.h                       |   3 +-
 drivers/net/enic/enic_ethdev.c                |   4 +-
 drivers/net/enic/enic_main.c                  |   3 +-
 drivers/net/enic/enic_vf_representor.c        |   3 +-
 drivers/net/failsafe/failsafe_ether.c         |   9 --
 drivers/net/failsafe/failsafe_ops.c           |   3 +-
 drivers/net/gve/gve_ethdev.c                  |   4 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
 drivers/net/hns3/hns3_stats.c                 |   4 +-
 drivers/net/hns3/hns3_stats.h                 |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/e1000/em_ethdev.c           |   7 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
 drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
 drivers/net/intel/ice/ice_ethdev.c            |   5 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |   3 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
 drivers/net/ionic/ionic_ethdev.c              |   6 +-
 drivers/net/ionic/ionic_lif.c                 |  35 +++--
 drivers/net/ionic/ionic_lif.h                 |   3 +-
 drivers/net/mana/mana.c                       |  15 +-
 drivers/net/memif/rte_eth_memif.c             |  15 +-
 drivers/net/mlx4/mlx4.h                       |   3 +-
 drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
 drivers/net/mlx5/mlx5.h                       |   3 +-
 drivers/net/mlx5/mlx5_stats.c                 |  17 +--
 drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
 drivers/net/netvsc/hn_ethdev.c                |  17 +--
 drivers/net/netvsc/hn_var.h                   |   3 +-
 drivers/net/netvsc/hn_vf.c                    |   3 +-
 drivers/net/nfp/flower/nfp_flower.c           |   8 +-
 .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
 .../net/nfp/flower/nfp_flower_representor.h   |   3 +
 drivers/net/nfp/nfp_net_common.c              |  46 +++---
 drivers/net/nfp/nfp_net_common.h              |   4 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
 drivers/net/null/rte_eth_null.c               |  15 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
 drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
 drivers/net/pcap/pcap_ethdev.c                |  23 +--
 drivers/net/pfe/pfe_ethdev.c                  |   3 +-
 drivers/net/qede/qede_ethdev.c                |  23 ++-
 drivers/net/r8169/r8169_ethdev.c              |   6 +-
 drivers/net/ring/rte_eth_ring.c               |  13 +-
 drivers/net/rnp/rnp_ethdev.c                  |  15 +-
 drivers/net/sfc/sfc_ethdev.c                  |   3 +-
 drivers/net/sfc/sfc_repr.c                    |   3 +-
 drivers/net/tap/rte_eth_tap.c                 |  23 +--
 drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
 drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
 drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
 drivers/net/virtio/virtio_ethdev.c            |  23 +--
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
 drivers/net/xsc/xsc_ethdev.c                  |  19 +--
 drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
 drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
 95 files changed, 828 insertions(+), 605 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index 85bc1201b4..88eb705a48 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -426,7 +426,7 @@ packet_drop_count(int sockfd)
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 	unsigned long rx_total = 0, rx_dropped_total = 0, rx_nombuf_total = 0;
@@ -448,11 +448,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		tx_err_total += internal->tx_queue[i].err_pkts;
 		tx_bytes_total += internal->tx_queue[i].tx_bytes;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = internal->rx_queue[i].rx_pkts;
-			stats->q_ibytes[i] = internal->rx_queue[i].rx_bytes;
-			stats->q_opackets[i] = internal->tx_queue[i].tx_pkts;
-			stats->q_obytes[i] = internal->tx_queue[i].tx_bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = internal->rx_queue[i].rx_pkts;
+			qstats->q_ibytes[i] = internal->rx_queue[i].rx_bytes;
+			qstats->q_opackets[i] = internal->tx_queue[i].tx_pkts;
+			qstats->q_obytes[i] = internal->tx_queue[i].tx_bytes;
+			qstats->q_errors[i] = internal->rx_queue[i].rx_nombuf;
 		}
 	}
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index f68895c93c..f2a8fb95d1 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -892,7 +892,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pmd_process_private *process_private = dev->process_private;
@@ -901,20 +902,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	struct pkt_tx_queue *txq;
 	socklen_t optlen;
 	int i, ret, fd;
+	unsigned long ipackets = 0, ibytes = 0, opackets = 0, obytes = 0;
+	unsigned long oerrors = 0, imissed = 0;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		optlen = sizeof(struct xdp_statistics);
 		rxq = &internals->rx_queues[i];
 		txq = rxq->pair;
-		stats->q_ipackets[i] = rxq->stats.rx_pkts;
-		stats->q_ibytes[i] = rxq->stats.rx_bytes;
 
-		stats->q_opackets[i] = txq->stats.tx_pkts;
-		stats->q_obytes[i] = txq->stats.tx_bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxq->stats.rx_pkts;
+			qstats->q_ibytes[i] = rxq->stats.rx_bytes;
+			qstats->q_opackets[i] = txq->stats.tx_pkts;
+			qstats->q_obytes[i] = txq->stats.tx_bytes;
+			qstats->q_errors[i] = 0; /* Not used */
+		}
 
-		stats->ipackets += stats->q_ipackets[i];
-		stats->ibytes += stats->q_ibytes[i];
-		stats->oerrors += txq->stats.tx_dropped;
+		ipackets += rxq->stats.rx_pkts;
+		ibytes += rxq->stats.rx_bytes;
+		oerrors += txq->stats.tx_dropped;
 		fd = process_private->rxq_xsk_fds[i];
 		ret = fd >= 0 ? getsockopt(fd, SOL_XDP, XDP_STATISTICS,
 					   &xdp_stats, &optlen) : -1;
@@ -922,12 +928,19 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			AF_XDP_LOG_LINE(ERR, "getsockopt() failed for XDP_STATISTICS.");
 			return -1;
 		}
-		stats->imissed += xdp_stats.rx_dropped - rxq->stats.imissed_offset;
+		imissed += xdp_stats.rx_dropped - rxq->stats.imissed_offset;
 
-		stats->opackets += stats->q_opackets[i];
-		stats->obytes += stats->q_obytes[i];
+		opackets += txq->stats.tx_pkts;
+		obytes += txq->stats.tx_bytes;
 	}
 
+	stats->ipackets = ipackets;
+	stats->ibytes = ibytes;
+	stats->opackets = opackets;
+	stats->obytes = obytes;
+	stats->oerrors = oerrors;
+	stats->imissed = imissed;
+
 	return 0;
 }
 
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..02d6683ab9 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -37,7 +37,8 @@ static int eth_ark_dev_link_update(struct rte_eth_dev *dev,
 static int eth_ark_dev_set_link_up(struct rte_eth_dev *dev);
 static int eth_ark_dev_set_link_down(struct rte_eth_dev *dev);
 static int eth_ark_dev_stats_get(struct rte_eth_dev *dev,
-				  struct rte_eth_stats *stats);
+				  struct rte_eth_stats *stats,
+				  struct eth_queue_stats *qstats);
 static int eth_ark_dev_stats_reset(struct rte_eth_dev *dev);
 static int eth_ark_set_default_mac_addr(struct rte_eth_dev *dev,
 					 struct rte_ether_addr *mac_addr);
@@ -780,25 +781,36 @@ eth_ark_dev_set_link_down(struct rte_eth_dev *dev)
 }
 
 static int
-eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_ark_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	uint16_t i;
 	struct ark_adapter *ark = dev->data->dev_private;
+	struct rte_eth_dev_data *data = dev->data;
 
-	stats->ipackets = 0;
-	stats->ibytes = 0;
-	stats->opackets = 0;
-	stats->obytes = 0;
-	stats->imissed = 0;
-	stats->oerrors = 0;
+	/* Initialize stats to 0 */
+	memset(stats, 0, sizeof(*stats));
 
-	for (i = 0; i < dev->data->nb_tx_queues; i++)
-		eth_tx_queue_stats_get(dev->data->tx_queues[i], stats);
-	for (i = 0; i < dev->data->nb_rx_queues; i++)
-		eth_rx_queue_stats_get(dev->data->rx_queues[i], stats);
+	if (qstats)
+		memset(qstats, 0, sizeof(*qstats));
+
+	/* Get stats for each RX queue */
+	for (i = 0; i < data->nb_rx_queues; i++) {
+		if (data->rx_queues[i])
+			eth_rx_queue_stats_get(data->rx_queues[i], stats, qstats);
+	}
+
+	/* Get stats for each TX queue */
+	for (i = 0; i < data->nb_tx_queues; i++) {
+		if (data->tx_queues[i])
+			eth_tx_queue_stats_get(data->tx_queues[i], stats, qstats);
+	}
+
+	/* Call user extension if registered */
 	if (ark->user_ext.stats_get)
 		return ark->user_ext.stats_get(dev, stats,
 			ark->user_data[dev->data->port_id]);
+
 	return 0;
 }
 
diff --git a/drivers/net/ark/ark_ethdev_rx.c b/drivers/net/ark/ark_ethdev_rx.c
index 2fff0ffded..d7d480ac90 100644
--- a/drivers/net/ark/ark_ethdev_rx.c
+++ b/drivers/net/ark/ark_ethdev_rx.c
@@ -560,13 +560,14 @@ eth_ark_dev_rx_queue_release(void *vqueue)
 }
 
 void
-eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats)
 {
 	struct ark_rx_queue *queue;
 	struct ark_udm_t *udm;
 
 	queue = vqueue;
-	if (queue == 0)
+	if (queue == NULL)
 		return;
 	udm = queue->udm;
 
@@ -574,12 +575,15 @@ eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
 	uint64_t ipackets = ark_udm_packets(udm);
 	uint64_t idropped = ark_udm_dropped(queue->udm);
 
-	stats->q_ipackets[queue->queue_index] = ipackets;
-	stats->q_ibytes[queue->queue_index] = ibytes;
-	stats->q_errors[queue->queue_index] = idropped;
 	stats->ipackets += ipackets;
 	stats->ibytes += ibytes;
 	stats->imissed += idropped;
+
+	if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		qstats->q_ipackets[queue->queue_index] = ipackets;
+		qstats->q_ibytes[queue->queue_index] = ibytes;
+		qstats->q_errors[queue->queue_index] = idropped;
+	}
 }
 
 void
diff --git a/drivers/net/ark/ark_ethdev_rx.h b/drivers/net/ark/ark_ethdev_rx.h
index 12d4f61637..27b87445b1 100644
--- a/drivers/net/ark/ark_ethdev_rx.h
+++ b/drivers/net/ark/ark_ethdev_rx.h
@@ -23,7 +23,8 @@ int eth_ark_rx_start_queue(struct rte_eth_dev *dev, uint16_t queue_id);
 uint16_t eth_ark_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts);
 void eth_ark_dev_rx_queue_release(void *rx_queue);
-void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void eth_rx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats);
 void eth_rx_queue_stats_reset(void *vqueue);
 void eth_ark_rx_dump_queue(struct rte_eth_dev *dev, uint16_t queue_id,
 			   const char *msg);
diff --git a/drivers/net/ark/ark_ethdev_tx.c b/drivers/net/ark/ark_ethdev_tx.c
index ca6cd297a1..5c22de6080 100644
--- a/drivers/net/ark/ark_ethdev_tx.c
+++ b/drivers/net/ark/ark_ethdev_tx.c
@@ -415,23 +415,29 @@ free_completed_tx(struct ark_tx_queue *queue)
 
 /* ************************************************************************* */
 void
-eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats)
+eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats)
 {
 	struct ark_tx_queue *queue;
 	struct ark_ddm_t *ddm;
 	uint64_t bytes, pkts;
 
 	queue = vqueue;
+	if (queue == NULL)
+		return;
 	ddm = queue->ddm;
 
 	bytes = ark_ddm_queue_byte_count(ddm);
 	pkts = ark_ddm_queue_pkt_count(ddm);
 
-	stats->q_opackets[queue->queue_index] = pkts;
-	stats->q_obytes[queue->queue_index] = bytes;
 	stats->opackets += pkts;
 	stats->obytes += bytes;
 	stats->oerrors += queue->tx_errors;
+
+	if (qstats && queue->queue_index < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		qstats->q_opackets[queue->queue_index] = pkts;
+		qstats->q_obytes[queue->queue_index] = bytes;
+	}
 }
 
 void
diff --git a/drivers/net/ark/ark_ethdev_tx.h b/drivers/net/ark/ark_ethdev_tx.h
index 7134dbfeed..639ee8adb4 100644
--- a/drivers/net/ark/ark_ethdev_tx.h
+++ b/drivers/net/ark/ark_ethdev_tx.h
@@ -21,7 +21,8 @@ int eth_ark_tx_queue_setup(struct rte_eth_dev *dev,
 void eth_ark_tx_queue_release(void *vtx_queue);
 int eth_ark_tx_queue_stop(struct rte_eth_dev *dev, uint16_t queue_id);
 int eth_ark_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
-void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats);
+void eth_tx_queue_stats_get(void *vqueue, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats);
 void eth_tx_queue_stats_reset(void *vqueue);
 
 #endif
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 9cde935834..2925dc2478 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -33,7 +33,7 @@ static int atl_dev_xstats_get_names(struct rte_eth_dev *dev __rte_unused,
 				    unsigned int size);
 
 static int atl_dev_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *stats);
+				struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 
 static int atl_dev_xstats_get(struct rte_eth_dev *dev,
 			      struct rte_eth_xstat *stats, unsigned int n);
@@ -930,7 +930,8 @@ int atl_macsec_select_rxsa(struct rte_eth_dev *dev,
 }
 
 static int
-atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		  struct eth_queue_stats *qstats)
 {
 	struct atl_adapter *adapter = ATL_DEV_TO_ADAPTER(dev);
 	struct aq_hw_s *hw = &adapter->hw;
@@ -951,12 +952,14 @@ atl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	stats->rx_nombuf = swstats->rx_nombuf;
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-		stats->q_ipackets[i] = swstats->q_ipackets[i];
-		stats->q_opackets[i] = swstats->q_opackets[i];
-		stats->q_ibytes[i] = swstats->q_ibytes[i];
-		stats->q_obytes[i] = swstats->q_obytes[i];
-		stats->q_errors[i] = swstats->q_errors[i];
+	if (qstats != NULL) {
+		for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
+			qstats->q_ipackets[i] = swstats->q_ipackets[i];
+			qstats->q_opackets[i] = swstats->q_opackets[i];
+			qstats->q_ibytes[i] = swstats->q_ibytes[i];
+			qstats->q_obytes[i] = swstats->q_obytes[i];
+			qstats->q_errors[i] = swstats->q_errors[i];
+		}
 	}
 	return 0;
 }
diff --git a/drivers/net/atlantic/atl_types.h b/drivers/net/atlantic/atl_types.h
index e813d9f326..dfd7016600 100644
--- a/drivers/net/atlantic/atl_types.h
+++ b/drivers/net/atlantic/atl_types.h
@@ -13,6 +13,7 @@
 #include <pthread.h>
 
 #include <rte_common.h>
+#include <ethdev_driver.h>
 
 typedef uint8_t		u8;
 typedef int8_t		s8;
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index ed44c1645d..3bc5171336 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -79,7 +79,8 @@ static void avp_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 static void avp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 static int avp_dev_stats_get(struct rte_eth_dev *dev,
-			      struct rte_eth_stats *stats);
+			      struct rte_eth_stats *stats,
+			      struct eth_queue_stats *qstats);
 static int avp_dev_stats_reset(struct rte_eth_dev *dev);
 
 
@@ -2241,7 +2242,8 @@ avp_vlan_offload_set(struct rte_eth_dev *eth_dev, int mask)
 }
 
 static int
-avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
+avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+		  struct eth_queue_stats *qstats)
 {
 	struct avp_dev *avp = AVP_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	unsigned int i;
@@ -2254,9 +2256,11 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
 			stats->ibytes += rxq->bytes;
 			stats->ierrors += rxq->errors;
 
-			stats->q_ipackets[i] += rxq->packets;
-			stats->q_ibytes[i] += rxq->bytes;
-			stats->q_errors[i] += rxq->errors;
+			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+				qstats->q_ipackets[i] += rxq->packets;
+				qstats->q_ibytes[i] += rxq->bytes;
+				qstats->q_errors[i] += rxq->errors;
+			}
 		}
 	}
 
@@ -2268,8 +2272,10 @@ avp_dev_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
 			stats->obytes += txq->bytes;
 			stats->oerrors += txq->errors;
 
-			stats->q_opackets[i] += txq->packets;
-			stats->q_obytes[i] += txq->bytes;
+			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+				qstats->q_opackets[i] += txq->packets;
+				qstats->q_obytes[i] += txq->bytes;
+			}
 		}
 	}
 
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index bc73536604..31d35ff182 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -51,7 +51,8 @@ static int axgbe_dev_link_update(struct rte_eth_dev *dev,
 static int axgbe_dev_get_regs(struct rte_eth_dev *dev,
 			      struct rte_dev_reg_info *regs);
 static int axgbe_dev_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *stats);
+				struct rte_eth_stats *stats,
+				struct eth_queue_stats *qstats);
 static int axgbe_dev_stats_reset(struct rte_eth_dev *dev);
 static int axgbe_dev_xstats_get(struct rte_eth_dev *dev,
 				struct rte_eth_xstat *stats,
@@ -1133,7 +1134,7 @@ axgbe_dev_xstats_reset(struct rte_eth_dev *dev)
 
 static int
 axgbe_dev_stats_get(struct rte_eth_dev *dev,
-		    struct rte_eth_stats *stats)
+		    struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct axgbe_rx_queue *rxq;
 	struct axgbe_tx_queue *txq;
@@ -1148,14 +1149,16 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
 		if (rxq) {
-			stats->q_ipackets[i] = rxq->pkts;
 			stats->ipackets += rxq->pkts;
-			stats->q_ibytes[i] = rxq->bytes;
 			stats->ibytes += rxq->bytes;
 			stats->rx_nombuf += rxq->rx_mbuf_alloc_failed;
-			stats->q_errors[i] = rxq->errors
-				+ rxq->rx_mbuf_alloc_failed;
 			stats->ierrors += rxq->errors;
+
+			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+				qstats->q_ipackets[i] = rxq->pkts;
+				qstats->q_ibytes[i] = rxq->bytes;
+				qstats->q_errors[i] = rxq->errors + rxq->rx_mbuf_alloc_failed;
+			}
 		} else {
 			PMD_DRV_LOG_LINE(DEBUG, "Rx queue not setup for port %d",
 					dev->data->port_id);
@@ -1165,11 +1168,14 @@ axgbe_dev_stats_get(struct rte_eth_dev *dev,
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
 		if (txq) {
-			stats->q_opackets[i] = txq->pkts;
 			stats->opackets += txq->pkts;
-			stats->q_obytes[i] = txq->bytes;
 			stats->obytes += txq->bytes;
 			stats->oerrors += txq->errors;
+
+			if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+				qstats->q_opackets[i] = txq->pkts;
+				qstats->q_obytes[i] = txq->bytes;
+			}
 		} else {
 			PMD_DRV_LOG_LINE(DEBUG, "Tx queue not setup for port %d",
 					dev->data->port_id);
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index 5cd4317d7a..b94a7f3562 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -8,6 +8,7 @@
 
 #include <rte_mempool.h>
 #include <rte_lcore.h>
+#include <ethdev_driver.h>
 #include "axgbe_common.h"
 #include "rte_time.h"
 
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_ethdev.c
index 1327cbe912..5e2e555525 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.c
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c
@@ -427,7 +427,8 @@ bnx2xvf_dev_link_update(struct rte_eth_dev *dev, __rte_unused int wait_to_comple
 }
 
 static int
-bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+bnx2x_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats __rte_unused)
 {
 	struct bnx2x_softc *sc = dev->data->dev_private;
 	uint32_t brb_truncate_discard;
diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index 6f5c3f80eb..bd3bfb8209 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -877,7 +877,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx)
 }
 
 int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
-			     struct rte_eth_stats *stats)
+			     struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct bnxt_representor *rep_bp = eth_dev->data->dev_private;
 	unsigned int i;
@@ -890,11 +890,13 @@ int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
 		stats->ipackets += rep_bp->rx_pkts[i];
 		stats->imissed += rep_bp->rx_drop_pkts[i];
 
-		stats->q_ipackets[i] = rep_bp->rx_pkts[i];
-		stats->q_ibytes[i] = rep_bp->rx_bytes[i];
-		stats->q_opackets[i] = rep_bp->tx_pkts[i];
-		stats->q_obytes[i] = rep_bp->tx_bytes[i];
-		stats->q_errors[i] = rep_bp->rx_drop_pkts[i];
+		if (qstats) {
+			qstats->q_ipackets[i] = rep_bp->rx_pkts[i];
+			qstats->q_ibytes[i] = rep_bp->rx_bytes[i];
+			qstats->q_opackets[i] = rep_bp->tx_pkts[i];
+			qstats->q_obytes[i] = rep_bp->tx_bytes[i];
+			qstats->q_errors[i] = rep_bp->rx_drop_pkts[i];
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/bnxt/bnxt_reps.h b/drivers/net/bnxt/bnxt_reps.h
index 3f2db9d1ae..1615ecf11c 100644
--- a/drivers/net/bnxt/bnxt_reps.h
+++ b/drivers/net/bnxt/bnxt_reps.h
@@ -47,7 +47,7 @@ void bnxt_rep_tx_queue_release_op(struct rte_eth_dev *dev, uint16_t queue_idx);
 int  bnxt_rep_dev_stop_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_dev_close_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_stats_get_op(struct rte_eth_dev *eth_dev,
-			     struct rte_eth_stats *stats);
+			     struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 int bnxt_rep_stats_reset_op(struct rte_eth_dev *eth_dev);
 int bnxt_rep_stop_all(struct bnxt *bp);
 #endif /* _BNXT_REPS_H_ */
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..53f5613eb3 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -561,84 +561,95 @@ void bnxt_free_stats(struct bnxt *bp)
 
 static void bnxt_fill_rte_eth_stats_ext(struct rte_eth_stats *stats,
 					struct bnxt_ring_stats_ext *ring_stats,
+					struct eth_queue_stats *qstats,
 					unsigned int i, bool rx)
 {
 	if (rx) {
-		stats->q_ipackets[i] = ring_stats->rx_ucast_pkts;
-		stats->q_ipackets[i] += ring_stats->rx_mcast_pkts;
-		stats->q_ipackets[i] += ring_stats->rx_bcast_pkts;
-
-		stats->ipackets += stats->q_ipackets[i];
-
-		stats->q_ibytes[i] = ring_stats->rx_ucast_bytes;
-		stats->q_ibytes[i] += ring_stats->rx_mcast_bytes;
-		stats->q_ibytes[i] += ring_stats->rx_bcast_bytes;
-
-		stats->ibytes += stats->q_ibytes[i];
-
-		stats->q_errors[i] = ring_stats->rx_discard_pkts;
-		stats->q_errors[i] += ring_stats->rx_error_pkts;
-
+		uint64_t ipackets = ring_stats->rx_ucast_pkts +
+				ring_stats->rx_mcast_pkts +
+				ring_stats->rx_bcast_pkts;
+		uint64_t ibytes = ring_stats->rx_ucast_bytes +
+				ring_stats->rx_mcast_bytes +
+				ring_stats->rx_bcast_bytes;
+		uint64_t ierrors = ring_stats->rx_discard_pkts +
+				ring_stats->rx_error_pkts;
+
+		stats->ipackets += ipackets;
+		stats->ibytes += ibytes;
 		stats->imissed += ring_stats->rx_discard_pkts;
 		stats->ierrors += ring_stats->rx_error_pkts;
-	} else {
-		stats->q_opackets[i] = ring_stats->tx_ucast_pkts;
-		stats->q_opackets[i] += ring_stats->tx_mcast_pkts;
-		stats->q_opackets[i] += ring_stats->tx_bcast_pkts;
-
-		stats->opackets += stats->q_opackets[i];
-
-		stats->q_obytes[i] = ring_stats->tx_ucast_bytes;
-		stats->q_obytes[i] += ring_stats->tx_mcast_bytes;
-		stats->q_obytes[i] += ring_stats->tx_bcast_bytes;
-
-		stats->obytes += stats->q_obytes[i];
 
+		if (qstats) {
+			qstats->q_ipackets[i] = ipackets;
+			qstats->q_ibytes[i] = ibytes;
+			qstats->q_errors[i] = ierrors;
+		}
+	} else {
+		uint64_t opackets = ring_stats->tx_ucast_pkts +
+				ring_stats->tx_mcast_pkts +
+				ring_stats->tx_bcast_pkts;
+		uint64_t obytes = ring_stats->tx_ucast_bytes +
+				ring_stats->tx_mcast_bytes +
+				ring_stats->tx_bcast_bytes;
+
+		stats->opackets += opackets;
+		stats->obytes += obytes;
 		stats->oerrors += ring_stats->tx_discard_pkts;
+
+		if (qstats) {
+			qstats->q_opackets[i] = opackets;
+			qstats->q_obytes[i] = obytes;
+		}
 	}
 }
 
 static void bnxt_fill_rte_eth_stats(struct rte_eth_stats *stats,
 				    struct bnxt_ring_stats *ring_stats,
+				    struct eth_queue_stats *qstats,
 				    unsigned int i, bool rx)
 {
 	if (rx) {
-		stats->q_ipackets[i] = ring_stats->rx_ucast_pkts;
-		stats->q_ipackets[i] += ring_stats->rx_mcast_pkts;
-		stats->q_ipackets[i] += ring_stats->rx_bcast_pkts;
-
-		stats->ipackets += stats->q_ipackets[i];
-
-		stats->q_ibytes[i] = ring_stats->rx_ucast_bytes;
-		stats->q_ibytes[i] += ring_stats->rx_mcast_bytes;
-		stats->q_ibytes[i] += ring_stats->rx_bcast_bytes;
-
-		stats->ibytes += stats->q_ibytes[i];
-
-		stats->q_errors[i] = ring_stats->rx_discard_pkts;
-		stats->q_errors[i] += ring_stats->rx_error_pkts;
-
+		uint64_t ipackets = ring_stats->rx_ucast_pkts +
+				ring_stats->rx_mcast_pkts +
+				ring_stats->rx_bcast_pkts;
+		uint64_t ibytes = ring_stats->rx_ucast_bytes +
+				ring_stats->rx_mcast_bytes +
+				ring_stats->rx_bcast_bytes;
+		uint64_t ierrors = ring_stats->rx_discard_pkts +
+				ring_stats->rx_error_pkts;
+
+		stats->ipackets += ipackets;
+		stats->ibytes += ibytes;
 		stats->imissed += ring_stats->rx_discard_pkts;
 		stats->ierrors += ring_stats->rx_error_pkts;
-	} else {
-		stats->q_opackets[i] = ring_stats->tx_ucast_pkts;
-		stats->q_opackets[i] += ring_stats->tx_mcast_pkts;
-		stats->q_opackets[i] += ring_stats->tx_bcast_pkts;
-
-		stats->opackets += stats->q_opackets[i];
-
-		stats->q_obytes[i] = ring_stats->tx_ucast_bytes;
-		stats->q_obytes[i] += ring_stats->tx_mcast_bytes;
-		stats->q_obytes[i] += ring_stats->tx_bcast_bytes;
-
-		stats->obytes += stats->q_obytes[i];
 
+		if (qstats) {
+			qstats->q_ipackets[i] = ipackets;
+			qstats->q_ibytes[i] = ibytes;
+			qstats->q_errors[i] = ierrors;
+		}
+	} else {
+		uint64_t opackets = ring_stats->tx_ucast_pkts +
+				ring_stats->tx_mcast_pkts +
+				ring_stats->tx_bcast_pkts;
+		uint64_t obytes = ring_stats->tx_ucast_bytes +
+				ring_stats->tx_mcast_bytes +
+				ring_stats->tx_bcast_bytes;
+
+		stats->opackets += opackets;
+		stats->obytes += obytes;
 		stats->oerrors += ring_stats->tx_discard_pkts;
+
+		if (qstats) {
+			qstats->q_opackets[i] = opackets;
+			qstats->q_obytes[i] = obytes;
+		}
 	}
 }
 
 static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
-				 struct rte_eth_stats *bnxt_stats)
+				 struct rte_eth_stats *bnxt_stats,
+				 struct eth_queue_stats *qstats)
 {
 	int rc = 0;
 	unsigned int i;
@@ -661,7 +672,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, i, true);
+		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats, i, true);
 		bnxt_stats->rx_nombuf +=
 				rte_atomic_load_explicit(&rxq->rx_mbuf_alloc_fail,
 							 rte_memory_order_relaxed);
@@ -683,14 +694,14 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, i, false);
+		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats, i, false);
 	}
 
 	return rc;
 }
 
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
-		      struct rte_eth_stats *bnxt_stats)
+		      struct rte_eth_stats *bnxt_stats, struct eth_queue_stats *qstats)
 {
 	int rc = 0;
 	unsigned int i;
@@ -705,7 +716,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		return -EIO;
 
 	if (BNXT_TPA_V2_P7(bp))
-		return bnxt_stats_get_ext(eth_dev, bnxt_stats);
+		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
 
 	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings,
 			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
@@ -723,7 +734,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, i, true);
+		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i, true);
 		bnxt_stats->rx_nombuf +=
 				rte_atomic_load_explicit(&rxq->rx_mbuf_alloc_fail,
 							 rte_memory_order_relaxed);
@@ -745,7 +756,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, i, false);
+		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i, false);
 		bnxt_stats->oerrors +=
 				rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							 rte_memory_order_relaxed);
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h
index e46c05eed3..c0508e773a 100644
--- a/drivers/net/bnxt/bnxt_stats.h
+++ b/drivers/net/bnxt/bnxt_stats.h
@@ -10,7 +10,7 @@
 
 void bnxt_free_stats(struct bnxt *bp);
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
-			   struct rte_eth_stats *bnxt_stats);
+			   struct rte_eth_stats *bnxt_stats, struct eth_queue_stats *qstats);
 int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev);
 int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 	struct rte_eth_xstat_name *xstats_names,
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 4906701a95..b7bab6bc99 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2636,11 +2636,12 @@ bond_ethdev_link_update(struct rte_eth_dev *ethdev, int wait_to_complete)
 
 
 static int
-bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats __rte_unused)
 {
 	struct bond_dev_private *internals = dev->data->dev_private;
 	struct rte_eth_stats member_stats;
-	int i, j;
+	int i;
 
 	for (i = 0; i < internals->member_count; i++) {
 		rte_eth_stats_get(internals->members[i].port_id, &member_stats);
@@ -2653,15 +2654,6 @@ bond_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->ierrors += member_stats.ierrors;
 		stats->oerrors += member_stats.oerrors;
 		stats->rx_nombuf += member_stats.rx_nombuf;
-
-		for (j = 0; j < RTE_ETHDEV_QUEUE_STAT_CNTRS; j++) {
-			stats->q_ipackets[j] += member_stats.q_ipackets[j];
-			stats->q_opackets[j] += member_stats.q_opackets[j];
-			stats->q_ibytes[j] += member_stats.q_ibytes[j];
-			stats->q_obytes[j] += member_stats.q_obytes[j];
-			stats->q_errors[j] += member_stats.q_errors[j];
-		}
-
 	}
 
 	return 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 7868185768..67867c889b 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -682,7 +682,8 @@ int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete);
 int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t queue_id,
 				 uint8_t stat_idx, uint8_t is_rx);
 int cnxk_nix_stats_reset(struct rte_eth_dev *dev);
-int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int cnxk_nix_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		       struct eth_queue_stats *qstats);
 int cnxk_nix_xstats_get(struct rte_eth_dev *eth_dev,
 			struct rte_eth_xstat *xstats, unsigned int n);
 int cnxk_nix_xstats_get_names(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/cnxk/cnxk_rep.h b/drivers/net/cnxk/cnxk_rep.h
index b9601854ce..9ede1e6dad 100644
--- a/drivers/net/cnxk/cnxk_rep.h
+++ b/drivers/net/cnxk/cnxk_rep.h
@@ -130,7 +130,8 @@ void cnxk_rep_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 void cnxk_rep_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_idx);
 int cnxk_rep_dev_stop(struct rte_eth_dev *eth_dev);
 int cnxk_rep_dev_close(struct rte_eth_dev *eth_dev);
-int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats);
+int cnxk_rep_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+		       struct eth_queue_stats *qstats);
 int cnxk_rep_stats_reset(struct rte_eth_dev *eth_dev);
 int cnxk_rep_flow_ops_get(struct rte_eth_dev *ethdev, const struct rte_flow_ops **ops);
 int cnxk_rep_state_update(struct cnxk_eswitch_dev *eswitch_dev, uint32_t state, uint16_t *rep_id);
diff --git a/drivers/net/cnxk/cnxk_rep_ops.c b/drivers/net/cnxk/cnxk_rep_ops.c
index c88d28ff72..c481015592 100644
--- a/drivers/net/cnxk/cnxk_rep_ops.c
+++ b/drivers/net/cnxk/cnxk_rep_ops.c
@@ -574,7 +574,8 @@ native_repte_eth_stats(struct cnxk_rep_dev *rep_dev, struct rte_eth_stats *stats
 }
 
 int
-cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats)
+cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats,
+		   struct eth_queue_stats *qstats)
 {
 	struct cnxk_rep_dev *rep_dev = cnxk_rep_pmd_priv(ethdev);
 	struct rte_eth_stats vf_stats;
@@ -612,13 +613,15 @@ cnxk_rep_stats_get(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats)
 		rte_memcpy(&vf_stats, adata.u.data, adata.size);
 	}
 
-	stats->q_ipackets[0] = vf_stats.ipackets;
-	stats->q_ibytes[0] = vf_stats.ibytes;
+	if (qstats != NULL) {
+		qstats->q_ipackets[0] = vf_stats.ipackets;
+		qstats->q_ibytes[0] = vf_stats.ibytes;
+		qstats->q_opackets[0] = vf_stats.opackets;
+		qstats->q_obytes[0] = vf_stats.obytes;
+	}
+
 	stats->ipackets = vf_stats.ipackets;
 	stats->ibytes = vf_stats.ibytes;
-
-	stats->q_opackets[0] = vf_stats.opackets;
-	stats->q_obytes[0] = vf_stats.obytes;
 	stats->opackets = vf_stats.opackets;
 	stats->obytes = vf_stats.obytes;
 
diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index 469faff405..d57659ef51 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -8,7 +8,8 @@
 #define CNXK_NB_TXQ_STATS 4
 
 int
-cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
+cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+		   struct eth_queue_stats *qstats)
 {
 	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
 	struct roc_nix *nix = &dev->nix;
@@ -32,28 +33,30 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
 	stats->ibytes = nix_stats.rx_octs;
 	stats->ierrors = nix_stats.rx_err;
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-		struct roc_nix_stats_queue qstats;
-		uint16_t qidx;
-
-		if (dev->txq_stat_map[i] & (1U << 31)) {
-			qidx = dev->txq_stat_map[i] & 0xFFFF;
-			rc = roc_nix_stats_queue_get(nix, qidx, 0, &qstats);
-			if (rc)
-				goto exit;
-			stats->q_opackets[i] = qstats.tx_pkts;
-			stats->q_obytes[i] = qstats.tx_octs;
-			stats->q_errors[i] = qstats.tx_drop_pkts;
-		}
-
-		if (dev->rxq_stat_map[i] & (1U << 31)) {
-			qidx = dev->rxq_stat_map[i] & 0xFFFF;
-			rc = roc_nix_stats_queue_get(nix, qidx, 1, &qstats);
-			if (rc)
-				goto exit;
-			stats->q_ipackets[i] = qstats.rx_pkts;
-			stats->q_ibytes[i] = qstats.rx_octs;
-			stats->q_errors[i] += qstats.rx_drop_pkts;
+	if (qstats != NULL) {
+		for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
+			struct roc_nix_stats_queue qstats_data;
+			uint16_t qidx;
+
+			if (dev->txq_stat_map[i] & (1U << 31)) {
+				qidx = dev->txq_stat_map[i] & 0xFFFF;
+				rc = roc_nix_stats_queue_get(nix, qidx, 0, &qstats_data);
+				if (rc)
+					goto exit;
+				qstats->q_opackets[i] = qstats_data.tx_pkts;
+				qstats->q_obytes[i] = qstats_data.tx_octs;
+				qstats->q_errors[i] = qstats_data.tx_drop_pkts;
+			}
+
+			if (dev->rxq_stat_map[i] & (1U << 31)) {
+				qidx = dev->rxq_stat_map[i] & 0xFFFF;
+				rc = roc_nix_stats_queue_get(nix, qidx, 1, &qstats_data);
+				if (rc)
+					goto exit;
+				qstats->q_ipackets[i] = qstats_data.rx_pkts;
+				qstats->q_ibytes[i] = qstats_data.rx_octs;
+				qstats->q_errors[i] += qstats_data.rx_drop_pkts;
+			}
 		}
 	}
 exit:
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 9b6a3651f9..0c337a6cc8 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -701,7 +701,8 @@ void cxgbe_dev_rx_queue_release(struct rte_eth_dev *eth_dev, uint16_t qid)
  * Get port statistics.
  */
 static int cxgbe_dev_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *eth_stats)
+				struct rte_eth_stats *eth_stats,
+				struct eth_queue_stats *qstats __rte_unused)
 {
 	struct port_info *pi = eth_dev->data->dev_private;
 	struct adapter *adapter = pi->adapter;
diff --git a/drivers/net/cxgbe/cxgbevf_ethdev.c b/drivers/net/cxgbe/cxgbevf_ethdev.c
index a62c56c2b9..d8eba8afef 100644
--- a/drivers/net/cxgbe/cxgbevf_ethdev.c
+++ b/drivers/net/cxgbe/cxgbevf_ethdev.c
@@ -34,7 +34,8 @@
  * Get port statistics.
  */
 static int cxgbevf_dev_stats_get(struct rte_eth_dev *eth_dev,
-				 struct rte_eth_stats *eth_stats)
+				 struct rte_eth_stats *eth_stats,
+				 struct eth_queue_stats *qstats __rte_unused)
 {
 	struct port_info *pi = eth_dev->data->dev_private;
 	struct adapter *adapter = pi->adapter;
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 34b691fde7..789a55c2a0 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -855,7 +855,8 @@ static int dpaa_eth_link_update(struct rte_eth_dev *dev,
 }
 
 static int dpaa_eth_stats_get(struct rte_eth_dev *dev,
-			       struct rte_eth_stats *stats)
+			       struct rte_eth_stats *stats,
+			       struct eth_queue_stats *qstats __rte_unused)
 {
 	PMD_INIT_FUNC_TRACE();
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 41678ce09b..ada4a79b36 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1602,7 +1602,7 @@ dpaa2_dev_set_mac_addr(struct rte_eth_dev *dev,
 
 static int
 dpaa2_dev_stats_get(struct rte_eth_dev *dev,
-	struct rte_eth_stats *stats)
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
@@ -1659,18 +1659,20 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	stats->imissed = value.page_2.ingress_nobuffer_discards;
 
 	/* Fill in per queue stats */
-	for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-		(i < priv->nb_rx_queues || i < priv->nb_tx_queues); ++i) {
-		dpaa2_rxq = priv->rx_vq[i];
-		dpaa2_txq = priv->tx_vq[i];
-		if (dpaa2_rxq)
-			stats->q_ipackets[i] = dpaa2_rxq->rx_pkts;
-		if (dpaa2_txq)
-			stats->q_opackets[i] = dpaa2_txq->tx_pkts;
-
-		/* Byte counting is not implemented */
-		stats->q_ibytes[i]   = 0;
-		stats->q_obytes[i]   = 0;
+	if (qstats != NULL) {
+		for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
+			(i < priv->nb_rx_queues || i < priv->nb_tx_queues); ++i) {
+			dpaa2_rxq = priv->rx_vq[i];
+			dpaa2_txq = priv->tx_vq[i];
+			if (dpaa2_rxq)
+				qstats->q_ipackets[i] = dpaa2_rxq->rx_pkts;
+			if (dpaa2_txq)
+				qstats->q_opackets[i] = dpaa2_txq->tx_pkts;
+
+			/* Byte counting is not implemented */
+			qstats->q_ibytes[i]   = 0;
+			qstats->q_obytes[i]   = 0;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index f5cf5c3811..448de25fdc 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -9,6 +9,7 @@
 #include <rte_version.h>
 #include <rte_net.h>
 #include <rte_kvargs.h>
+#include <ethdev_driver.h>
 
 #include "ena_ethdev.h"
 #include "ena_logs.h"
@@ -270,7 +271,8 @@ static int ena_start(struct rte_eth_dev *dev);
 static int ena_stop(struct rte_eth_dev *dev);
 static int ena_close(struct rte_eth_dev *dev);
 static int ena_dev_reset(struct rte_eth_dev *dev);
-static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+static int ena_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+			  struct eth_queue_stats *qstats);
 static void ena_rx_queue_release_all(struct rte_eth_dev *dev);
 static void ena_tx_queue_release_all(struct rte_eth_dev *dev);
 static void ena_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
@@ -1240,7 +1242,8 @@ static void ena_stats_restart(struct rte_eth_dev *dev)
 }
 
 static int ena_stats_get(struct rte_eth_dev *dev,
-			  struct rte_eth_stats *stats)
+			  struct rte_eth_stats *stats,
+			  struct eth_queue_stats *qstats)
 {
 	struct ena_admin_basic_stats ena_stats;
 	struct ena_adapter *adapter = dev->data->dev_private;
@@ -1276,26 +1279,29 @@ static int ena_stats_get(struct rte_eth_dev *dev,
 	stats->oerrors = rte_atomic64_read(&adapter->drv_stats->oerrors);
 	stats->rx_nombuf = rte_atomic64_read(&adapter->drv_stats->rx_nombuf);
 
-	max_rings_stats = RTE_MIN(dev->data->nb_rx_queues,
-		RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	for (i = 0; i < max_rings_stats; ++i) {
-		struct ena_stats_rx *rx_stats = &adapter->rx_ring[i].rx_stats;
-
-		stats->q_ibytes[i] = rx_stats->bytes;
-		stats->q_ipackets[i] = rx_stats->cnt;
-		stats->q_errors[i] = rx_stats->bad_desc_num +
-			rx_stats->bad_req_id +
-			rx_stats->bad_desc +
-			rx_stats->unknown_error;
-	}
+	/* Queue statistics */
+	if (qstats) {
+		max_rings_stats = RTE_MIN(dev->data->nb_rx_queues,
+			RTE_ETHDEV_QUEUE_STAT_CNTRS);
+		for (i = 0; i < max_rings_stats; ++i) {
+			struct ena_stats_rx *rx_stats = &adapter->rx_ring[i].rx_stats;
+
+			qstats->q_ibytes[i] = rx_stats->bytes;
+			qstats->q_ipackets[i] = rx_stats->cnt;
+			qstats->q_errors[i] = rx_stats->bad_desc_num +
+				rx_stats->bad_req_id +
+				rx_stats->bad_desc +
+				rx_stats->unknown_error;
+		}
 
-	max_rings_stats = RTE_MIN(dev->data->nb_tx_queues,
-		RTE_ETHDEV_QUEUE_STAT_CNTRS);
-	for (i = 0; i < max_rings_stats; ++i) {
-		struct ena_stats_tx *tx_stats = &adapter->tx_ring[i].tx_stats;
+		max_rings_stats = RTE_MIN(dev->data->nb_tx_queues,
+			RTE_ETHDEV_QUEUE_STAT_CNTRS);
+		for (i = 0; i < max_rings_stats; ++i) {
+			struct ena_stats_tx *tx_stats = &adapter->tx_ring[i].tx_stats;
 
-		stats->q_obytes[i] = tx_stats->bytes;
-		stats->q_opackets[i] = tx_stats->cnt;
+			qstats->q_obytes[i] = tx_stats->bytes;
+			qstats->q_opackets[i] = tx_stats->cnt;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index ffbecc407c..37a61f8ff6 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <ethdev_pci.h>
+#include <ethdev_driver.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
 
@@ -543,7 +544,8 @@ enetc_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 static
 int enetc_stats_get(struct rte_eth_dev *dev,
-		    struct rte_eth_stats *stats)
+		    struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats __rte_unused)
 {
 	struct enetc_eth_hw *hw =
 		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 7c2926409e..c336db75e8 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -314,7 +314,8 @@ enetfec_set_mac_address(struct rte_eth_dev *dev,
 
 static int
 enetfec_stats_get(struct rte_eth_dev *dev,
-	      struct rte_eth_stats *stats)
+	      struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats __rte_unused)
 {
 	struct enetfec_private *fep = dev->data->dev_private;
 	struct rte_eth_stats *eth_stats = &fep->stats;
diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index dc1d16f7d5..87f6b35fcd 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -419,7 +419,8 @@ int enic_disable(struct enic *enic);
 void enic_remove(struct enic *enic);
 int enic_get_link_status(struct enic *enic);
 int enic_dev_stats_get(struct enic *enic,
-		       struct rte_eth_stats *r_stats);
+		       struct rte_eth_stats *r_stats,
+		       struct eth_queue_stats *qstats __rte_unused);
 int enic_dev_stats_clear(struct enic *enic);
 int enic_add_packet_filter(struct enic *enic);
 int enic_set_mac_address(struct enic *enic, uint8_t *mac_addr);
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index 749cc9ca5c..a853a5047a 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -432,12 +432,12 @@ static int enicpmd_dev_link_update(struct rte_eth_dev *eth_dev,
 }
 
 static int enicpmd_dev_stats_get(struct rte_eth_dev *eth_dev,
-	struct rte_eth_stats *stats)
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct enic *enic = pmd_priv(eth_dev);
 
 	ENICPMD_FUNC_TRACE();
-	return enic_dev_stats_get(enic, stats);
+	return enic_dev_stats_get(enic, stats, qstats);
 }
 
 static int enicpmd_dev_stats_reset(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 4124c48b85..2696fa77d4 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -111,7 +111,8 @@ int enic_dev_stats_clear(struct enic *enic)
 	return 0;
 }
 
-int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats)
+int enic_dev_stats_get(struct enic *enic, struct rte_eth_stats *r_stats,
+			struct eth_queue_stats *qstats __rte_unused)
 {
 	struct vnic_stats *stats;
 	struct enic_soft_stats *soft_stats = &enic->soft_stats;
diff --git a/drivers/net/enic/enic_vf_representor.c b/drivers/net/enic/enic_vf_representor.c
index 8469e06de9..05b2efedcb 100644
--- a/drivers/net/enic/enic_vf_representor.c
+++ b/drivers/net/enic/enic_vf_representor.c
@@ -419,13 +419,14 @@ static int enic_vf_link_update(struct rte_eth_dev *eth_dev,
 }
 
 static int enic_vf_stats_get(struct rte_eth_dev *eth_dev,
-	struct rte_eth_stats *stats)
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rte_unused)
 {
 	struct enic_vf_representor *vf;
 	struct vnic_stats *vs;
 	int err;
 
 	ENICPMD_FUNC_TRACE();
+
 	vf = eth_dev->data->dev_private;
 	/* Get VF stats via PF */
 	err = vnic_dev_stats_dump(vf->enic.vdev, &vs);
diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index dc4aba6e30..f0fd662c7b 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -565,8 +565,6 @@ failsafe_eth_dev_state_sync(struct rte_eth_dev *dev)
 void
 failsafe_stats_increment(struct rte_eth_stats *to, struct rte_eth_stats *from)
 {
-	uint32_t i;
-
 	RTE_ASSERT(to != NULL && from != NULL);
 	to->ipackets += from->ipackets;
 	to->opackets += from->opackets;
@@ -576,13 +574,6 @@ failsafe_stats_increment(struct rte_eth_stats *to, struct rte_eth_stats *from)
 	to->ierrors += from->ierrors;
 	to->oerrors += from->oerrors;
 	to->rx_nombuf += from->rx_nombuf;
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS; i++) {
-		to->q_ipackets[i] += from->q_ipackets[i];
-		to->q_opackets[i] += from->q_opackets[i];
-		to->q_ibytes[i] += from->q_ibytes[i];
-		to->q_obytes[i] += from->q_obytes[i];
-		to->q_errors[i] += from->q_errors[i];
-	}
 }
 
 int
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 5321c3385c..ddc8808ebe 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -898,7 +898,8 @@ fs_link_update(struct rte_eth_dev *dev,
 
 static int
 fs_stats_get(struct rte_eth_dev *dev,
-	     struct rte_eth_stats *stats)
+	     struct rte_eth_stats *stats,
+	     struct eth_queue_stats *qstats __rte_unused)
 {
 	struct rte_eth_stats backup;
 	struct sub_device *sdev;
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 56e1a470b8..6341d89f39 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -10,6 +10,7 @@
 #include "gve_version.h"
 #include "rte_ether.h"
 #include "gve_rss.h"
+#include <ethdev_driver.h>
 
 static void
 gve_write_version(uint8_t *driver_version_register)
@@ -671,7 +672,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 }
 
 static int
-gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+gve_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		  struct eth_queue_stats *qstats __rte_unused)
 {
 	uint16_t i;
 	if (gve_is_gqi(dev->data->dev_private))
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index cb5c013b21..75534c1ce2 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -5,6 +5,7 @@
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <ethdev_pci.h>
+#include <ethdev_driver.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
@@ -1305,7 +1306,8 @@ static int hinic_set_dev_promiscuous(struct hinic_nic_dev *nic_dev, bool enable)
  *   negative error value otherwise.
  */
 static int
-hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats)
 {
 	int i, err, q_num;
 	u64 rx_discards_pmd = 0;
@@ -1326,29 +1328,45 @@ hinic_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	dev->data->rx_mbuf_alloc_failed = 0;
 
 	/* rx queue stats */
-	q_num = (nic_dev->num_rq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-			nic_dev->num_rq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-	for (i = 0; i < q_num; i++) {
-		rxq = nic_dev->rxqs[i];
-		hinic_rxq_get_stats(rxq, &rxq_stats);
-		stats->q_ipackets[i] = rxq_stats.packets;
-		stats->q_ibytes[i] = rxq_stats.bytes;
-		stats->q_errors[i] = rxq_stats.rx_discards;
-
-		stats->ierrors += rxq_stats.errors;
-		rx_discards_pmd += rxq_stats.rx_discards;
-		dev->data->rx_mbuf_alloc_failed += rxq_stats.rx_nombuf;
-	}
+	if (qstats) {
+		q_num = (nic_dev->num_rq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
+				nic_dev->num_rq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
+		for (i = 0; i < q_num; i++) {
+			rxq = nic_dev->rxqs[i];
+			hinic_rxq_get_stats(rxq, &rxq_stats);
+			qstats->q_ipackets[i] = rxq_stats.packets;
+			qstats->q_ibytes[i] = rxq_stats.bytes;
+			qstats->q_errors[i] = rxq_stats.rx_discards;
+
+			stats->ierrors += rxq_stats.errors;
+			rx_discards_pmd += rxq_stats.rx_discards;
+			dev->data->rx_mbuf_alloc_failed += rxq_stats.rx_nombuf;
+		}
 
-	/* tx queue stats */
-	q_num = (nic_dev->num_sq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
-		nic_dev->num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
-	for (i = 0; i < q_num; i++) {
-		txq = nic_dev->txqs[i];
-		hinic_txq_get_stats(txq, &txq_stats);
-		stats->q_opackets[i] = txq_stats.packets;
-		stats->q_obytes[i] = txq_stats.bytes;
-		stats->oerrors += (txq_stats.tx_busy + txq_stats.off_errs);
+		/* tx queue stats */
+		q_num = (nic_dev->num_sq < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
+			nic_dev->num_sq : RTE_ETHDEV_QUEUE_STAT_CNTRS;
+		for (i = 0; i < q_num; i++) {
+			txq = nic_dev->txqs[i];
+			hinic_txq_get_stats(txq, &txq_stats);
+			qstats->q_opackets[i] = txq_stats.packets;
+			qstats->q_obytes[i] = txq_stats.bytes;
+			stats->oerrors += (txq_stats.tx_busy + txq_stats.off_errs);
+		}
+	} else {
+		/* Still aggregate error stats even without qstats */
+		for (i = 0; i < nic_dev->num_rq; i++) {
+			rxq = nic_dev->rxqs[i];
+			hinic_rxq_get_stats(rxq, &rxq_stats);
+			stats->ierrors += rxq_stats.errors;
+			rx_discards_pmd += rxq_stats.rx_discards;
+			dev->data->rx_mbuf_alloc_failed += rxq_stats.rx_nombuf;
+		}
+		for (i = 0; i < nic_dev->num_sq; i++) {
+			txq = nic_dev->txqs[i];
+			hinic_txq_get_stats(txq, &txq_stats);
+			stats->oerrors += (txq_stats.tx_busy + txq_stats.off_errs);
+		}
 	}
 
 	/* vport stats */
diff --git a/drivers/net/hns3/hns3_stats.c b/drivers/net/hns3/hns3_stats.c
index 9a1e8935e5..c8d5070a5b 100644
--- a/drivers/net/hns3/hns3_stats.c
+++ b/drivers/net/hns3/hns3_stats.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_ethdev.h>
+#include <ethdev_driver.h>
 #include <rte_io.h>
 #include <rte_malloc.h>
 
@@ -609,7 +610,8 @@ hns3_rcb_tx_ring_stats_get(struct hns3_tx_queue *txq,
  *   0 on success.
  */
 int
-hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats)
+hns3_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats,
+	       struct eth_queue_stats *qstats __rte_unused)
 {
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
diff --git a/drivers/net/hns3/hns3_stats.h b/drivers/net/hns3/hns3_stats.h
index 74bc4173cc..511af430a3 100644
--- a/drivers/net/hns3/hns3_stats.h
+++ b/drivers/net/hns3/hns3_stats.h
@@ -151,7 +151,8 @@ struct hns3_reset_stats;
 struct hns3_hw;
 
 int hns3_stats_get(struct rte_eth_dev *eth_dev,
-		   struct rte_eth_stats *rte_stats);
+		   struct rte_eth_stats *rte_stats,
+		   struct eth_queue_stats *qstats);
 int hns3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 			unsigned int n);
 int hns3_dev_xstats_reset(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 6d7b23ad7a..ed6852f23d 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -311,7 +311,8 @@ cpfl_get_mbuf_alloc_failed_stats(struct rte_eth_dev *dev)
 }
 
 static int
-cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+cpfl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
 	struct idpf_vport *vport = &cpfl_vport->base;
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index 39dddf3384..ec3924bf6b 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -42,7 +42,7 @@ static int eth_em_allmulticast_disable(struct rte_eth_dev *dev);
 static int eth_em_link_update(struct rte_eth_dev *dev,
 				int wait_to_complete);
 static int eth_em_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *rte_stats);
+				struct rte_eth_stats *rte_stats, struct eth_queue_stats *qstats);
 static int eth_em_stats_reset(struct rte_eth_dev *dev);
 static int eth_em_infos_get(struct rte_eth_dev *dev,
 				struct rte_eth_dev_info *dev_info);
@@ -926,7 +926,8 @@ em_hardware_init(struct e1000_hw *hw)
 
 /* This function is based on em_update_stats_counters() in e1000/if_em.c */
 static int
-eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+eth_em_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_hw_stats *stats =
@@ -1049,7 +1050,7 @@ eth_em_stats_reset(struct rte_eth_dev *dev)
 			E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
 
 	/* HW registers are cleared on read */
-	eth_em_stats_get(dev, NULL);
+	eth_em_stats_get(dev, NULL, NULL);
 
 	/* Reset software totals */
 	memset(hw_stats, 0, sizeof(*hw_stats));
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 124cf75762..f4e2a6442e 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -86,7 +86,7 @@ static int  eth_igb_allmulticast_disable(struct rte_eth_dev *dev);
 static int  eth_igb_link_update(struct rte_eth_dev *dev,
 				int wait_to_complete);
 static int eth_igb_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *rte_stats);
+				struct rte_eth_stats *rte_stats, struct eth_queue_stats *qstats);
 static int eth_igb_xstats_get(struct rte_eth_dev *dev,
 			      struct rte_eth_xstat *xstats, unsigned n);
 static int eth_igb_xstats_get_by_id(struct rte_eth_dev *dev,
@@ -163,7 +163,7 @@ static int igbvf_allmulticast_enable(struct rte_eth_dev *dev);
 static int igbvf_allmulticast_disable(struct rte_eth_dev *dev);
 static int eth_igbvf_link_update(struct e1000_hw *hw);
 static int eth_igbvf_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *rte_stats);
+				struct rte_eth_stats *rte_stats, struct eth_queue_stats *qstats);
 static int eth_igbvf_xstats_get(struct rte_eth_dev *dev,
 				struct rte_eth_xstat *xstats, unsigned n);
 static int eth_igbvf_xstats_get_names(struct rte_eth_dev *dev,
@@ -1943,7 +1943,8 @@ igb_read_stats_registers(struct e1000_hw *hw, struct e1000_hw_stats *stats)
 }
 
 static int
-eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+eth_igb_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_hw_stats *stats =
@@ -1976,7 +1977,7 @@ eth_igb_stats_reset(struct rte_eth_dev *dev)
 			E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
 
 	/* HW registers are cleared on read */
-	eth_igb_stats_get(dev, NULL);
+	eth_igb_stats_get(dev, NULL, NULL);
 
 	/* Reset software totals */
 	memset(hw_stats, 0, sizeof(*hw_stats));
@@ -2212,7 +2213,8 @@ eth_igbvf_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+eth_igbvf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct e1000_hw *hw = E1000_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct e1000_vf_stats *hw_stats = (struct e1000_vf_stats *)
@@ -2237,7 +2239,7 @@ eth_igbvf_stats_reset(struct rte_eth_dev *dev)
 			E1000_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
 
 	/* Sync HW register to the last stats */
-	eth_igbvf_stats_get(dev, NULL);
+	eth_igbvf_stats_get(dev, NULL, NULL);
 
 	/* reset HW current stats*/
 	memset(&hw_stats->gprc, 0, sizeof(*hw_stats) -
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 68444e4fba..b9c91d2446 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -226,7 +226,7 @@ static int eth_igc_allmulticast_enable(struct rte_eth_dev *dev);
 static int eth_igc_allmulticast_disable(struct rte_eth_dev *dev);
 static int eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu);
 static int eth_igc_stats_get(struct rte_eth_dev *dev,
-			struct rte_eth_stats *rte_stats);
+			struct rte_eth_stats *rte_stats, struct eth_queue_stats *qstats);
 static int eth_igc_xstats_get(struct rte_eth_dev *dev,
 			struct rte_eth_xstat *xstats, unsigned int n);
 static int eth_igc_xstats_get_by_id(struct rte_eth_dev *dev,
@@ -2029,7 +2029,8 @@ igc_read_queue_stats_register(struct rte_eth_dev *dev)
 }
 
 static int
-eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+		struct eth_queue_stats *qstats)
 {
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
@@ -2068,19 +2069,21 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
 	rte_stats->obytes   = stats->gotc;
 
 	/* Get per-queue statuses */
-	for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-		/* GET TX queue statuses */
-		int map_id = igc->txq_stats_map[i];
-		if (map_id >= 0) {
-			rte_stats->q_opackets[map_id] += queue_stats->pqgptc[i];
-			rte_stats->q_obytes[map_id] += queue_stats->pqgotc[i];
-		}
-		/* Get RX queue statuses */
-		map_id = igc->rxq_stats_map[i];
-		if (map_id >= 0) {
-			rte_stats->q_ipackets[map_id] += queue_stats->pqgprc[i];
-			rte_stats->q_ibytes[map_id] += queue_stats->pqgorc[i];
-			rte_stats->q_errors[map_id] += queue_stats->rqdpc[i];
+	if (qstats) {
+		for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
+			/* GET TX queue statuses */
+			int map_id = igc->txq_stats_map[i];
+			if (map_id >= 0) {
+				qstats->q_opackets[map_id] += queue_stats->pqgptc[i];
+				qstats->q_obytes[map_id] += queue_stats->pqgotc[i];
+			}
+			/* Get RX queue statuses */
+			map_id = igc->rxq_stats_map[i];
+			if (map_id >= 0) {
+				qstats->q_ipackets[map_id] += queue_stats->pqgprc[i];
+				qstats->q_ibytes[map_id] += queue_stats->pqgorc[i];
+				qstats->q_errors[map_id] += queue_stats->rqdpc[i];
+			}
 		}
 	}
 
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 75ce2e19cf..bb05aecd97 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -1314,7 +1314,8 @@ fm10k_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	uint64_t ipackets, opackets, ibytes, obytes, imissed;
 	struct fm10k_hw *hw =
@@ -1329,17 +1330,19 @@ fm10k_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	ipackets = opackets = ibytes = obytes = imissed = 0;
 	for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-		(i < hw->mac.max_queues); ++i) {
-		stats->q_ipackets[i] = hw_stats->q[i].rx_packets.count;
-		stats->q_opackets[i] = hw_stats->q[i].tx_packets.count;
-		stats->q_ibytes[i]   = hw_stats->q[i].rx_bytes.count;
-		stats->q_obytes[i]   = hw_stats->q[i].tx_bytes.count;
-		stats->q_errors[i]   = hw_stats->q[i].rx_drops.count;
-		ipackets += stats->q_ipackets[i];
-		opackets += stats->q_opackets[i];
-		ibytes   += stats->q_ibytes[i];
-		obytes   += stats->q_obytes[i];
-		imissed  += stats->q_errors[i];
+			(i < hw->mac.max_queues); ++i) {
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = hw_stats->q[i].rx_packets.count;
+			qstats->q_opackets[i] = hw_stats->q[i].tx_packets.count;
+			qstats->q_ibytes[i]   = hw_stats->q[i].rx_bytes.count;
+			qstats->q_obytes[i]   = hw_stats->q[i].tx_bytes.count;
+			qstats->q_errors[i]   = hw_stats->q[i].rx_drops.count;
+		}
+		ipackets += hw_stats->q[i].rx_packets.count;
+		opackets += hw_stats->q[i].tx_packets.count;
+		ibytes   += hw_stats->q[i].rx_bytes.count;
+		obytes   += hw_stats->q[i].tx_bytes.count;
+		imissed  += hw_stats->q[i].rx_drops.count;
 	}
 	stats->ipackets = ipackets;
 	stats->opackets = opackets;
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 7a562a6e0b..b8ce79061b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -256,7 +256,7 @@ static int i40e_dev_allmulticast_disable(struct rte_eth_dev *dev);
 static int i40e_dev_set_link_up(struct rte_eth_dev *dev);
 static int i40e_dev_set_link_down(struct rte_eth_dev *dev);
 static int i40e_dev_stats_get(struct rte_eth_dev *dev,
-			       struct rte_eth_stats *stats);
+			       struct rte_eth_stats *stats,	struct eth_queue_stats *qstats);
 static int i40e_dev_xstats_get(struct rte_eth_dev *dev,
 			       struct rte_eth_xstat *xstats, unsigned n);
 static int i40e_dev_xstats_get_names(struct rte_eth_dev *dev,
@@ -3474,7 +3474,8 @@ i40e_read_stats_registers(struct i40e_pf *pf, struct i40e_hw *hw)
 
 /* Get all statistics of a port */
 static int
-i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+i40e_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
diff --git a/drivers/net/intel/i40e/i40e_vf_representor.c b/drivers/net/intel/i40e/i40e_vf_representor.c
index c00ae832aa..e8f0bb62a0 100644
--- a/drivers/net/intel/i40e/i40e_vf_representor.c
+++ b/drivers/net/intel/i40e/i40e_vf_representor.c
@@ -209,7 +209,7 @@ rte_pmd_i40e_get_vf_native_stats(uint16_t port,
 
 static int
 i40e_vf_representor_stats_get(struct rte_eth_dev *ethdev,
-		struct rte_eth_stats *stats)
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rte_unused)
 {
 	struct i40e_vf_representor *representor = ethdev->data->dev_private;
 	struct i40e_eth_stats native_stats;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 08c814725d..56bc6480e5 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -105,7 +105,7 @@ static int iavf_dev_info_get(struct rte_eth_dev *dev,
 static const uint32_t *iavf_dev_supported_ptypes_get(struct rte_eth_dev *dev,
 						     size_t *no_of_elements);
 static int iavf_dev_stats_get(struct rte_eth_dev *dev,
-			     struct rte_eth_stats *stats);
+			     struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 static int iavf_dev_stats_reset(struct rte_eth_dev *dev);
 static int iavf_dev_xstats_reset(struct rte_eth_dev *dev);
 static int iavf_dev_xstats_get(struct rte_eth_dev *dev,
@@ -1798,7 +1798,8 @@ iavf_update_stats(struct iavf_vsi *vsi, struct virtchnl_eth_stats *nes)
 }
 
 static int
-iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 499062be40..81da5a4656 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1514,7 +1514,8 @@ ice_dcf_update_stats(struct virtchnl_eth_stats *oes,
 
 
 static int
-ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct ice_dcf_adapter *ad = dev->data->dev_private;
 	struct ice_dcf_hw *hw = &ad->real_hw;
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 31f1419897..cdc4943667 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -161,7 +161,7 @@ static int ice_get_module_info(struct rte_eth_dev *dev,
 static int ice_get_module_eeprom(struct rte_eth_dev *dev,
 				 struct rte_dev_eeprom_info *info);
 static int ice_stats_get(struct rte_eth_dev *dev,
-			 struct rte_eth_stats *stats);
+			 struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 static int ice_stats_reset(struct rte_eth_dev *dev);
 static int ice_xstats_get(struct rte_eth_dev *dev,
 			  struct rte_eth_xstat *xstats, unsigned int n);
@@ -6340,7 +6340,8 @@ ice_read_stats_registers(struct ice_pf *pf, struct ice_hw *hw)
 
 /* Get all statistics of a port */
 static int
-ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ice_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 90720909bf..3c505e882a 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -268,7 +268,8 @@ idpf_get_mbuf_alloc_failed_stats(struct rte_eth_dev *dev)
 }
 
 static int
-idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+idpf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct idpf_vport *vport =
 		(struct idpf_vport *)dev->data->dev_private;
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index c5aca0ea8f..cd34d08055 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -2119,7 +2119,8 @@ ipn3ke_rpst_stats_reset(struct rte_eth_dev *ethdev)
 
 static int
 ipn3ke_rpst_stats_get
-(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats)
+(struct rte_eth_dev *ethdev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	uint16_t port_id = 0;
 	char *ch;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 4f0343245e..7e1278c026 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -164,7 +164,7 @@ static int ixgbe_dev_allmulticast_disable(struct rte_eth_dev *dev);
 static int ixgbe_dev_link_update(struct rte_eth_dev *dev,
 				int wait_to_complete);
 static int ixgbe_dev_stats_get(struct rte_eth_dev *dev,
-				struct rte_eth_stats *stats);
+				struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 static int ixgbe_dev_xstats_get(struct rte_eth_dev *dev,
 				struct rte_eth_xstat *xstats, unsigned n);
 static int ixgbevf_dev_xstats_get(struct rte_eth_dev *dev,
@@ -265,7 +265,7 @@ static int  ixgbevf_dev_reset(struct rte_eth_dev *dev);
 static void ixgbevf_intr_disable(struct rte_eth_dev *dev);
 static void ixgbevf_intr_enable(struct rte_eth_dev *dev);
 static int ixgbevf_dev_stats_get(struct rte_eth_dev *dev,
-		struct rte_eth_stats *stats);
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 static int ixgbevf_dev_stats_reset(struct rte_eth_dev *dev);
 static int ixgbevf_vlan_filter_set(struct rte_eth_dev *dev,
 		uint16_t vlan_id, int on);
@@ -3398,7 +3398,7 @@ ixgbe_read_stats_registers(struct ixgbe_hw *hw,
  * This function is based on ixgbe_update_stats_counters() in ixgbe/ixgbe.c
  */
 static int
-ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct ixgbe_hw *hw =
 			IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -3427,13 +3427,15 @@ ixgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	stats->opackets = hw_stats->gptc;
 	stats->obytes = hw_stats->gotc;
 
-	for (i = 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
-			RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
-		stats->q_ipackets[i] = hw_stats->qprc[i];
-		stats->q_opackets[i] = hw_stats->qptc[i];
-		stats->q_ibytes[i] = hw_stats->qbrc[i];
-		stats->q_obytes[i] = hw_stats->qbtc[i];
-		stats->q_errors[i] = hw_stats->qprdc[i];
+	if (qstats != NULL) {
+		for (i = 0; i < RTE_MIN_T(IXGBE_QUEUE_STAT_COUNTERS,
+				RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
+			qstats->q_ipackets[i] = hw_stats->qprc[i];
+			qstats->q_opackets[i] = hw_stats->qptc[i];
+			qstats->q_ibytes[i] = hw_stats->qbrc[i];
+			qstats->q_obytes[i] = hw_stats->qbtc[i];
+			qstats->q_errors[i] = hw_stats->qprdc[i];
+		}
 	}
 
 	/* Rx Errors */
@@ -3468,7 +3470,7 @@ ixgbe_dev_stats_reset(struct rte_eth_dev *dev)
 			IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
 
 	/* HW registers are cleared on read */
-	ixgbe_dev_stats_get(dev, NULL);
+	ixgbe_dev_stats_get(dev, NULL, NULL);
 
 	/* Reset software totals */
 	memset(stats, 0, sizeof(*stats));
@@ -3887,7 +3889,8 @@ ixgbevf_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ixgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct ixgbevf_hw_stats *hw_stats = (struct ixgbevf_hw_stats *)
 			  IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
@@ -3911,7 +3914,7 @@ ixgbevf_dev_stats_reset(struct rte_eth_dev *dev)
 			IXGBE_DEV_PRIVATE_TO_STATS(dev->data->dev_private);
 
 	/* Sync HW register to the last stats */
-	ixgbevf_dev_stats_get(dev, NULL);
+	ixgbevf_dev_stats_get(dev, NULL, NULL);
 
 	/* reset HW current stats*/
 	hw_stats->vfgprc = 0;
diff --git a/drivers/net/ionic/ionic_ethdev.c b/drivers/net/ionic/ionic_ethdev.c
index aa22b6a70d..6e9cd5f7eb 100644
--- a/drivers/net/ionic/ionic_ethdev.c
+++ b/drivers/net/ionic/ionic_ethdev.c
@@ -39,7 +39,7 @@ static int  ionic_dev_rss_hash_conf_get(struct rte_eth_dev *eth_dev,
 static int  ionic_dev_rss_hash_update(struct rte_eth_dev *eth_dev,
 	struct rte_eth_rss_conf *rss_conf);
 static int  ionic_dev_stats_get(struct rte_eth_dev *eth_dev,
-	struct rte_eth_stats *stats);
+	struct rte_eth_stats *stats, struct eth_queue_stats *queue_stats);
 static int  ionic_dev_stats_reset(struct rte_eth_dev *eth_dev);
 static int  ionic_dev_xstats_get(struct rte_eth_dev *dev,
 	struct rte_eth_xstat *xstats, unsigned int n);
@@ -722,11 +722,11 @@ ionic_dev_rss_hash_update(struct rte_eth_dev *eth_dev,
 
 static int
 ionic_dev_stats_get(struct rte_eth_dev *eth_dev,
-		struct rte_eth_stats *stats)
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	struct ionic_lif *lif = IONIC_ETH_DEV_TO_LIF(eth_dev);
 
-	ionic_lif_get_stats(lif, stats);
+	ionic_lif_get_stats(lif, stats, qstats);
 
 	return 0;
 }
diff --git a/drivers/net/ionic/ionic_lif.c b/drivers/net/ionic/ionic_lif.c
index b4dc118fef..b52c8cad88 100644
--- a/drivers/net/ionic/ionic_lif.c
+++ b/drivers/net/ionic/ionic_lif.c
@@ -100,7 +100,8 @@ ionic_lif_reset(struct ionic_lif *lif)
 }
 
 static void
-ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats)
+ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct ionic_lif_stats *ls = &lif->info->stats;
 	uint32_t i;
@@ -144,13 +145,15 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats
 		ls->rx_desc_fetch_error +
 		ls->rx_desc_data_error;
 
-	for (i = 0; i < num_rx_q_counters; i++) {
-		struct ionic_rx_stats *rx_stats = &lif->rxqcqs[i]->stats;
-		stats->q_ipackets[i] = rx_stats->packets;
-		stats->q_ibytes[i] = rx_stats->bytes;
-		stats->q_errors[i] =
-			rx_stats->bad_cq_status +
-			rx_stats->bad_len;
+	if (qstats != NULL) {
+		for (i = 0; i < num_rx_q_counters; i++) {
+			struct ionic_rx_stats *rx_stats = &lif->rxqcqs[i]->stats;
+			qstats->q_ipackets[i] = rx_stats->packets;
+			qstats->q_ibytes[i] = rx_stats->bytes;
+			qstats->q_errors[i] =
+				rx_stats->bad_cq_status +
+				rx_stats->bad_len;
+		}
 	}
 
 	/* TX */
@@ -179,18 +182,20 @@ ionic_lif_get_abs_stats(const struct ionic_lif *lif, struct rte_eth_stats *stats
 		ls->tx_desc_fetch_error +
 		ls->tx_desc_data_error;
 
-	for (i = 0; i < num_tx_q_counters; i++) {
-		struct ionic_tx_stats *tx_stats = &lif->txqcqs[i]->stats;
-		stats->q_opackets[i] = tx_stats->packets;
-		stats->q_obytes[i] = tx_stats->bytes;
+	if (qstats != NULL) {
+		for (i = 0; i < num_tx_q_counters; i++) {
+			struct ionic_tx_stats *tx_stats = &lif->txqcqs[i]->stats;
+			qstats->q_opackets[i] = tx_stats->packets;
+			qstats->q_obytes[i] = tx_stats->bytes;
+		}
 	}
 }
 
 void
 ionic_lif_get_stats(const struct ionic_lif *lif,
-		struct rte_eth_stats *stats)
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
-	ionic_lif_get_abs_stats(lif, stats);
+	ionic_lif_get_abs_stats(lif, stats, qstats);
 
 	stats->ipackets  -= lif->stats_base.ipackets;
 	stats->opackets  -= lif->stats_base.opackets;
@@ -214,7 +219,7 @@ ionic_lif_reset_stats(struct ionic_lif *lif)
 			sizeof(struct ionic_tx_stats));
 	}
 
-	ionic_lif_get_abs_stats(lif, &lif->stats_base);
+	ionic_lif_get_abs_stats(lif, &lif->stats_base, NULL);
 }
 
 void
diff --git a/drivers/net/ionic/ionic_lif.h b/drivers/net/ionic/ionic_lif.h
index f4a1b9937e..2d85ebbcae 100644
--- a/drivers/net/ionic/ionic_lif.h
+++ b/drivers/net/ionic/ionic_lif.h
@@ -9,6 +9,7 @@
 
 #include <rte_ethdev.h>
 #include <rte_ether.h>
+#include <ethdev_driver.h>
 
 #include "ionic.h"
 #include "ionic_dev.h"
@@ -244,7 +245,7 @@ int ionic_lif_rss_config(struct ionic_lif *lif, const uint16_t types,
 int ionic_lif_set_features(struct ionic_lif *lif);
 
 void ionic_lif_get_stats(const struct ionic_lif *lif,
-	struct rte_eth_stats *stats);
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats);
 void ionic_lif_reset_stats(struct ionic_lif *lif);
 
 void ionic_lif_get_hw_stats(struct ionic_lif *lif,
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 48e44bfafc..b7ae01b152 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -645,7 +645,8 @@ mana_dev_link_update(struct rte_eth_dev *dev,
 }
 
 static int
-mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		   struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 
@@ -659,9 +660,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->obytes += txq->stats.bytes;
 		stats->oerrors += txq->stats.errors;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = txq->stats.packets;
-			stats->q_obytes[i] = txq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = txq->stats.packets;
+			qstats->q_obytes[i] = txq->stats.bytes;
 		}
 	}
 
@@ -678,9 +679,9 @@ mana_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 		/* There is no good way to get stats->imissed, not setting it */
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = rxq->stats.packets;
-			stats->q_ibytes[i] = rxq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxq->stats.packets;
+			qstats->q_ibytes[i] = rxq->stats.bytes;
 		}
 
 		stats->rx_nombuf += rxq->stats.nombuf;
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index f7b04c4f9e..9de6f97cd9 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1578,7 +1578,8 @@ memif_link_update(struct rte_eth_dev *dev,
 }
 
 static int
-memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
 	struct memif_queue *mq;
@@ -1598,8 +1599,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	/* RX stats */
 	for (i = 0; i < nq; i++) {
 		mq = dev->data->rx_queues[i];
-		stats->q_ipackets[i] = mq->n_pkts;
-		stats->q_ibytes[i] = mq->n_bytes;
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = mq->n_pkts;
+			qstats->q_ibytes[i] = mq->n_bytes;
+		}
 		stats->ipackets += mq->n_pkts;
 		stats->ibytes += mq->n_bytes;
 	}
@@ -1612,8 +1615,10 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	/* TX stats */
 	for (i = 0; i < nq; i++) {
 		mq = dev->data->tx_queues[i];
-		stats->q_opackets[i] = mq->n_pkts;
-		stats->q_obytes[i] = mq->n_bytes;
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = mq->n_pkts;
+			qstats->q_obytes[i] = mq->n_bytes;
+		}
 		stats->opackets += mq->n_pkts;
 		stats->obytes += mq->n_bytes;
 	}
diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h
index c992a1c5ea..f68eeb991a 100644
--- a/drivers/net/mlx4/mlx4.h
+++ b/drivers/net/mlx4/mlx4.h
@@ -219,7 +219,8 @@ int mlx4_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr);
 int mlx4_set_mc_addr_list(struct rte_eth_dev *dev, struct rte_ether_addr *list,
 			  uint32_t num);
 int mlx4_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on);
-int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		   struct eth_queue_stats *qstats);
 int mlx4_stats_reset(struct rte_eth_dev *dev);
 int mlx4_fw_version_get(struct rte_eth_dev *dev, char *fw_ver, size_t fw_size);
 int mlx4_dev_infos_get(struct rte_eth_dev *dev,
diff --git a/drivers/net/mlx4/mlx4_ethdev.c b/drivers/net/mlx4/mlx4_ethdev.c
index f11c6b4373..efc6ee4577 100644
--- a/drivers/net/mlx4/mlx4_ethdev.c
+++ b/drivers/net/mlx4/mlx4_ethdev.c
@@ -702,7 +702,8 @@ int mlx4_fw_version_get(struct rte_eth_dev *dev, char *fw_ver, size_t fw_size)
  *   Stats structure output buffer.
  */
 int
-mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	       struct eth_queue_stats *qstats)
 {
 	struct rte_eth_stats tmp;
 	unsigned int i;
@@ -716,10 +717,10 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (rxq == NULL)
 			continue;
 		idx = rxq->stats.idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			tmp.q_ipackets[idx] += rxq->stats.ipackets;
-			tmp.q_ibytes[idx] += rxq->stats.ibytes;
-			tmp.q_errors[idx] += (rxq->stats.idropped +
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[idx] += rxq->stats.ipackets;
+			qstats->q_ibytes[idx] += rxq->stats.ibytes;
+			qstats->q_errors[idx] += (rxq->stats.idropped +
 					      rxq->stats.rx_nombuf);
 		}
 		tmp.ipackets += rxq->stats.ipackets;
@@ -733,9 +734,9 @@ mlx4_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (txq == NULL)
 			continue;
 		idx = txq->stats.idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			tmp.q_opackets[idx] += txq->stats.opackets;
-			tmp.q_obytes[idx] += txq->stats.obytes;
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[idx] += txq->stats.opackets;
+			qstats->q_obytes[idx] += txq->stats.obytes;
 		}
 		tmp.opackets += txq->stats.opackets;
 		tmp.obytes += txq->stats.obytes;
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 93e298d648..e7fd4066ba 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2418,7 +2418,8 @@ int mlx5_allmulticast_disable(struct rte_eth_dev *dev);
 
 /* mlx5_stats.c */
 
-int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		   struct eth_queue_stats *qstats);
 int mlx5_stats_reset(struct rte_eth_dev *dev);
 int mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *stats,
 		    unsigned int n);
diff --git a/drivers/net/mlx5/mlx5_stats.c b/drivers/net/mlx5/mlx5_stats.c
index ebc6f9fb53..5cd3e303cc 100644
--- a/drivers/net/mlx5/mlx5_stats.c
+++ b/drivers/net/mlx5/mlx5_stats.c
@@ -208,7 +208,8 @@ mlx5_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *stats,
  *   rte_errno is set.
  */
 int
-mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	       struct eth_queue_stats *qstats)
 {
 	struct mlx5_priv *priv = dev->data->dev_private;
 	struct mlx5_stats_ctrl *stats_ctrl = &priv->stats_ctrl;
@@ -226,14 +227,14 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (rxq == NULL)
 			continue;
 		idx = rxq->idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 #ifdef MLX5_PMD_SOFT_COUNTERS
-			tmp.q_ipackets[idx] += rxq->stats.ipackets -
+			qstats->q_ipackets[idx] += rxq->stats.ipackets -
 				rxq->stats_reset.ipackets;
-			tmp.q_ibytes[idx] += rxq->stats.ibytes -
+			qstats->q_ibytes[idx] += rxq->stats.ibytes -
 				rxq->stats_reset.ibytes;
 #endif
-			tmp.q_errors[idx] += (rxq->stats.idropped +
+			qstats->q_errors[idx] += (rxq->stats.idropped +
 					      rxq->stats.rx_nombuf) -
 					      (rxq->stats_reset.idropped +
 					      rxq->stats_reset.rx_nombuf);
@@ -252,11 +253,11 @@ mlx5_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (txq == NULL)
 			continue;
 		idx = txq->idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 #ifdef MLX5_PMD_SOFT_COUNTERS
-			tmp.q_opackets[idx] += txq->stats.opackets -
+			qstats->q_opackets[idx] += txq->stats.opackets -
 						txq->stats_reset.opackets;
-			tmp.q_obytes[idx] += txq->stats.obytes -
+			qstats->q_obytes[idx] += txq->stats.obytes -
 						txq->stats_reset.obytes;
 #endif
 		}
diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta_ethdev.c
index f99f9e6289..eef9758224 100644
--- a/drivers/net/mvneta/mvneta_ethdev.c
+++ b/drivers/net/mvneta/mvneta_ethdev.c
@@ -712,7 +712,8 @@ mvneta_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
  *   0 on success, negative error value otherwise.
  */
 static int
-mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mvneta_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		 struct eth_queue_stats *qstats __rte_unused)
 {
 	struct mvneta_priv *priv = dev->data->dev_private;
 	struct neta_ppio_statistics ppio_stats;
@@ -765,7 +766,7 @@ mvneta_stats_reset(struct rte_eth_dev *dev)
 	if (!priv->ppio)
 		return 0;
 
-	ret = mvneta_stats_get(dev, &priv->prev_stats);
+	ret = mvneta_stats_get(dev, &priv->prev_stats, NULL);
 	if (unlikely(ret))
 		MVNETA_LOG(ERR, "Failed to reset port statistics");
 
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 4200c11d46..845819e4d8 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -1486,7 +1486,8 @@ mrvl_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
  *   0 on success, negative error value otherwise.
  */
 static int
-mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	       struct eth_queue_stats *qstats)
 {
 	struct mrvl_priv *priv = dev->data->dev_private;
 	struct pp2_ppio_statistics ppio_stats;
@@ -1521,12 +1522,14 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			break;
 		}
 
-		stats->q_ibytes[idx] = rxq->bytes_recv;
-		stats->q_ipackets[idx] = rx_stats.enq_desc - rxq->drop_mac;
-		stats->q_errors[idx] = rx_stats.drop_early +
-				       rx_stats.drop_fullq +
-				       rx_stats.drop_bm +
-				       rxq->drop_mac;
+		if (qstats != NULL) {
+			qstats->q_ibytes[idx] = rxq->bytes_recv;
+			qstats->q_ipackets[idx] = rx_stats.enq_desc - rxq->drop_mac;
+			qstats->q_errors[idx] = rx_stats.drop_early +
+					       rx_stats.drop_fullq +
+					       rx_stats.drop_bm +
+					       rxq->drop_mac;
+		}
 		stats->ibytes += rxq->bytes_recv;
 		drop_mac += rxq->drop_mac;
 	}
@@ -1553,8 +1556,10 @@ mrvl_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			break;
 		}
 
-		stats->q_opackets[idx] = tx_stats.deq_desc;
-		stats->q_obytes[idx] = txq->bytes_sent;
+		if (qstats != NULL) {
+			qstats->q_opackets[idx] = tx_stats.deq_desc;
+			qstats->q_obytes[idx] = txq->bytes_sent;
+		}
 		stats->obytes += txq->bytes_sent;
 	}
 
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 1d788f3fb7..a31aac1a8a 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -817,11 +817,12 @@ static int hn_dev_configure(struct rte_eth_dev *dev)
 }
 
 static int hn_dev_stats_get(struct rte_eth_dev *dev,
-			    struct rte_eth_stats *stats)
+			    struct rte_eth_stats *stats,
+			    struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 
-	hn_vf_stats_get(dev, stats);
+	hn_vf_stats_get(dev, stats, qstats);
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		const struct hn_tx_queue *txq = dev->data->tx_queues[i];
@@ -833,9 +834,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->obytes += txq->stats.bytes;
 		stats->oerrors += txq->stats.errors;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] += txq->stats.packets;
-			stats->q_obytes[i] += txq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] += txq->stats.packets;
+			qstats->q_obytes[i] += txq->stats.bytes;
 		}
 	}
 
@@ -850,9 +851,9 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->ierrors += rxq->stats.errors;
 		stats->imissed += rxq->stats.ring_full;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] += rxq->stats.packets;
-			stats->q_ibytes[i] += rxq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] += rxq->stats.packets;
+			qstats->q_ibytes[i] += rxq->stats.bytes;
 		}
 	}
 
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index ccbd6b6a33..17c1d5d07b 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -269,7 +269,8 @@ int	hn_vf_rx_queue_setup(struct rte_eth_dev *dev,
 			     struct rte_mempool *mp);
 void	hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id);
 
-int	hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int	hn_vf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats);
 int	hn_vf_stats_reset(struct rte_eth_dev *dev);
 int	hn_vf_xstats_get_names(struct rte_eth_dev *dev,
 			       struct rte_eth_xstat_name *xstats_names,
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index d922e685f4..0ecfaf54ea 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -677,7 +677,8 @@ void hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id)
 }
 
 int hn_vf_stats_get(struct rte_eth_dev *dev,
-		    struct rte_eth_stats *stats)
+		    struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats __rte_unused)
 {
 	struct hn_data *hv = dev->data->dev_private;
 	struct rte_eth_dev *vf_dev;
diff --git a/drivers/net/nfp/flower/nfp_flower.c b/drivers/net/nfp/flower/nfp_flower.c
index 804ad494d5..4eeb9aee3b 100644
--- a/drivers/net/nfp/flower/nfp_flower.c
+++ b/drivers/net/nfp/flower/nfp_flower.c
@@ -238,8 +238,8 @@ nfp_flower_multiple_pf_recv_pkts(void *rx_queue,
 		for (i = 0; i < recv; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_stats.q_ipackets[rxq->qidx] += recv;
-		repr->repr_stats.q_ibytes[rxq->qidx] += data_len;
+		repr->repr_qstats.q_ipackets[rxq->qidx] += recv;
+		repr->repr_qstats.q_ibytes[rxq->qidx] += data_len;
 	}
 
 	return recv;
@@ -276,8 +276,8 @@ nfp_flower_multiple_pf_xmit_pkts(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_stats.q_opackets[txq->qidx] += sent;
-		repr->repr_stats.q_obytes[txq->qidx] += data_len;
+		repr->repr_qstats.q_opackets[txq->qidx] += sent;
+		repr->repr_qstats.q_obytes[txq->qidx] += data_len;
 	}
 
 	return sent;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index 6c3a30c694..9b984dbc8d 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -314,7 +314,7 @@ nfp_flower_repr_tx_queue_setup(struct rte_eth_dev *dev,
 
 static int
 nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
-		struct rte_eth_stats *stats)
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats __rte_unused)
 {
 	uint16_t i;
 	struct nfp_flower_representor *repr;
@@ -324,15 +324,15 @@ nfp_flower_repr_stats_get(struct rte_eth_dev *ethdev,
 	repr->repr_stats.ipackets = 0;
 	repr->repr_stats.ibytes = 0;
 	for (i = 0; i < ethdev->data->nb_rx_queues; i++) {
-		repr->repr_stats.ipackets += repr->repr_stats.q_ipackets[i];
-		repr->repr_stats.ibytes += repr->repr_stats.q_ibytes[i];
+		repr->repr_stats.ipackets += repr->repr_qstats.q_ipackets[i];
+		repr->repr_stats.ibytes += repr->repr_qstats.q_ibytes[i];
 	}
 
 	repr->repr_stats.opackets = 0;
 	repr->repr_stats.obytes = 0;
 	for (i = 0; i < ethdev->data->nb_tx_queues; i++) {
-		repr->repr_stats.opackets += repr->repr_stats.q_opackets[i];
-		repr->repr_stats.obytes += repr->repr_stats.q_obytes[i];
+		repr->repr_stats.opackets += repr->repr_qstats.q_opackets[i];
+		repr->repr_stats.obytes += repr->repr_qstats.q_obytes[i];
 	}
 
 	*stats = repr->repr_stats;
@@ -347,6 +347,7 @@ nfp_flower_repr_stats_reset(struct rte_eth_dev *ethdev)
 
 	repr = ethdev->data->dev_private;
 	memset(&repr->repr_stats, 0, sizeof(struct rte_eth_stats));
+	memset(&repr->repr_qstats, 0, sizeof(struct eth_queue_stats));
 
 	return 0;
 }
@@ -402,8 +403,8 @@ nfp_flower_repr_rx_burst(void *rx_queue,
 		for (i = 0; i < total_dequeue; i++)
 			data_len += rx_pkts[i]->data_len;
 
-		repr->repr_stats.q_ipackets[rxq->qidx] += total_dequeue;
-		repr->repr_stats.q_ibytes[rxq->qidx] += data_len;
+		repr->repr_qstats.q_ipackets[rxq->qidx] += total_dequeue;
+		repr->repr_qstats.q_ibytes[rxq->qidx] += data_len;
 	}
 
 	return total_dequeue;
@@ -450,8 +451,8 @@ nfp_flower_repr_tx_burst(void *tx_queue,
 		for (i = 0; i < sent; i++)
 			data_len += tx_pkts[i]->data_len;
 
-		repr->repr_stats.q_opackets[txq->qidx] += sent;
-		repr->repr_stats.q_obytes[txq->qidx] += data_len;
+		repr->repr_qstats.q_opackets[txq->qidx] += sent;
+		repr->repr_qstats.q_obytes[txq->qidx] += data_len;
 	}
 
 	return sent;
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.h b/drivers/net/nfp/flower/nfp_flower_representor.h
index a7416eccab..66714d9a51 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.h
+++ b/drivers/net/nfp/flower/nfp_flower_representor.h
@@ -6,6 +6,8 @@
 #ifndef __NFP_FLOWER_REPRESENTOR_H__
 #define __NFP_FLOWER_REPRESENTOR_H__
 
+#include <ethdev_driver.h>
+
 #include "nfp_flower.h"
 
 struct nfp_flower_representor {
@@ -20,6 +22,7 @@ struct nfp_flower_representor {
 	struct rte_ring **ring;
 	struct rte_eth_link link;
 	struct rte_eth_stats repr_stats;
+	struct eth_queue_stats repr_qstats;
 
 	struct rte_eth_xstat *repr_xstats_base;
 	uint8_t *mac_stats;
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index 730372e279..d35eee970a 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -904,7 +904,7 @@ nfp_net_link_update(struct rte_eth_dev *dev,
 
 int
 nfp_net_stats_get(struct rte_eth_dev *dev,
-		struct rte_eth_stats *stats)
+		struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
 	uint16_t i;
 	struct nfp_net_hw *hw;
@@ -922,15 +922,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
 		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
 			break;
 
-		nfp_dev_stats.q_ipackets[i] =
-				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i));
-		nfp_dev_stats.q_ipackets[i] -=
-				hw->eth_stats_base.q_ipackets[i];
+		uint64_t q_ipackets = nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i));
+		q_ipackets -= hw->eth_qstats_base.q_ipackets[i];
 
-		nfp_dev_stats.q_ibytes[i] =
-				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i) + 0x8);
-		nfp_dev_stats.q_ibytes[i] -=
-				hw->eth_stats_base.q_ibytes[i];
+		uint64_t q_ibytes = nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i) + 0x8);
+		q_ibytes -= hw->eth_qstats_base.q_ibytes[i];
+
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = q_ipackets;
+			qstats->q_ibytes[i] = q_ibytes;
+		}
 	}
 
 	/* Reading per TX ring stats */
@@ -938,13 +939,16 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
 		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
 			break;
 
-		nfp_dev_stats.q_opackets[i] =
-				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i));
-		nfp_dev_stats.q_opackets[i] -= hw->eth_stats_base.q_opackets[i];
+		uint64_t q_opackets = nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i));
+		q_opackets -= hw->eth_qstats_base.q_opackets[i];
 
-		nfp_dev_stats.q_obytes[i] =
-				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i) + 0x8);
-		nfp_dev_stats.q_obytes[i] -= hw->eth_stats_base.q_obytes[i];
+		uint64_t q_obytes = nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i) + 0x8);
+		q_obytes -= hw->eth_qstats_base.q_obytes[i];
+
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = q_opackets;
+			qstats->q_obytes[i] = q_obytes;
+		}
 	}
 
 	nfp_dev_stats.ipackets = nn_cfg_readq(&hw->super, NFP_NET_CFG_STATS_RX_FRAMES);
@@ -982,8 +986,8 @@ nfp_net_stats_get(struct rte_eth_dev *dev,
 }
 
 /*
- * hw->eth_stats_base records the per counter starting point.
- * Lets update it now.
+ * hw->eth_stats_base and hw->eth_qstats_base record the per counter starting point.
+ * Let's update them now.
  */
 int
 nfp_net_stats_reset(struct rte_eth_dev *dev)
@@ -998,10 +1002,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
 		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
 			break;
 
-		hw->eth_stats_base.q_ipackets[i] =
+		hw->eth_qstats_base.q_ipackets[i] =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i));
 
-		hw->eth_stats_base.q_ibytes[i] =
+		hw->eth_qstats_base.q_ibytes[i] =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_RXR_STATS(i) + 0x8);
 	}
 
@@ -1010,10 +1014,10 @@ nfp_net_stats_reset(struct rte_eth_dev *dev)
 		if (i == RTE_ETHDEV_QUEUE_STAT_CNTRS)
 			break;
 
-		hw->eth_stats_base.q_opackets[i] =
+		hw->eth_qstats_base.q_opackets[i] =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i));
 
-		hw->eth_stats_base.q_obytes[i] =
+		hw->eth_qstats_base.q_obytes[i] =
 				nn_cfg_readq(&hw->super, NFP_NET_CFG_TXR_STATS(i) + 0x8);
 	}
 
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_common.h
index a6addf8610..2bd2d54028 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -250,6 +250,7 @@ struct nfp_net_hw {
 
 	/** Records starting point for counters */
 	struct rte_eth_stats eth_stats_base;
+	struct eth_queue_stats eth_qstats_base;
 	struct rte_eth_xstat *eth_xstats_base;
 
 	struct nfp_cpp_area *ctrl_area;
@@ -301,7 +302,8 @@ int nfp_net_link_update_common(struct rte_eth_dev *dev,
 		uint32_t link_status);
 int nfp_net_link_update(struct rte_eth_dev *dev,
 		__rte_unused int wait_to_complete);
-int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int nfp_net_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats);
 int nfp_net_stats_reset(struct rte_eth_dev *dev);
 uint32_t nfp_net_xstats_size(const struct rte_eth_dev *dev);
 int nfp_net_xstats_get_names(struct rte_eth_dev *dev,
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index d3ac40299f..adb7785498 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -1498,7 +1498,8 @@ ngbe_read_stats_registers(struct ngbe_hw *hw,
 }
 
 static int
-ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_hw_stats *hw_stats = NGBE_DEV_STATS(dev);
@@ -1518,29 +1519,31 @@ ngbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	stats->opackets = hw_stats->tx_packets;
 	stats->obytes = hw_stats->tx_bytes;
 
-	memset(&stats->q_ipackets, 0, sizeof(stats->q_ipackets));
-	memset(&stats->q_opackets, 0, sizeof(stats->q_opackets));
-	memset(&stats->q_ibytes, 0, sizeof(stats->q_ibytes));
-	memset(&stats->q_obytes, 0, sizeof(stats->q_obytes));
-	memset(&stats->q_errors, 0, sizeof(stats->q_errors));
-	for (i = 0; i < NGBE_MAX_QP; i++) {
-		uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
-		uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-		uint32_t q_map;
-
-		q_map = (stat_mappings->rqsm[n] >> offset)
-				& QMAP_FIELD_RESERVED_BITS_MASK;
-		j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-		     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		stats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
-		stats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
-
-		q_map = (stat_mappings->tqsm[n] >> offset)
-				& QMAP_FIELD_RESERVED_BITS_MASK;
-		j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-		     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		stats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
-		stats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+	if (qstats != NULL) {
+		memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
+		memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
+		memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
+		memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
+		memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
+		for (i = 0; i < NGBE_MAX_QP; i++) {
+			uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
+			uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
+			uint32_t q_map;
+
+			q_map = (stat_mappings->rqsm[n] >> offset)
+					& QMAP_FIELD_RESERVED_BITS_MASK;
+			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
+			qstats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
+			qstats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
+
+			q_map = (stat_mappings->tqsm[n] >> offset)
+					& QMAP_FIELD_RESERVED_BITS_MASK;
+			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
+			qstats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
+			qstats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+		}
 	}
 
 	/* Rx Errors */
@@ -1580,7 +1583,7 @@ ngbe_dev_stats_reset(struct rte_eth_dev *dev)
 
 	/* HW registers are cleared on read */
 	hw->offset_loaded = 0;
-	ngbe_dev_stats_get(dev, NULL);
+	ngbe_dev_stats_get(dev, NULL, NULL);
 	hw->offset_loaded = 1;
 
 	/* Reset software totals */
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 846bc981f6..e575c47049 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -425,7 +425,8 @@ ngbevf_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+ngbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct ngbevf_hw_stats *hw_stats = (struct ngbevf_hw_stats *)
 			  NGBE_DEV_STATS(dev);
@@ -449,7 +450,7 @@ ngbevf_dev_stats_reset(struct rte_eth_dev *dev)
 			NGBE_DEV_STATS(dev);
 
 	/* Sync HW register to the last stats */
-	ngbevf_dev_stats_get(dev, NULL);
+	ngbevf_dev_stats_get(dev, NULL, NULL);
 
 	/* reset HW current stats*/
 	hw_stats->vfgprc = 0;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 79ef9e7e7c..4c090aa521 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -167,7 +167,8 @@ get_pdrv_from_pci(struct rte_pci_addr addr)
 	return p_drv;
 }
 
-static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_stats *stats)
+static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	const struct ntnic_filter_ops *ntnic_filter_ops = get_ntnic_filter_ops();
 
@@ -201,19 +202,19 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	ntnic_filter_ops->poll_statistics(internals);
 
 	for (i = 0; i < internals->nb_rx_queues; i++) {
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
-			stats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
+			qstats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
 		}
 		rx_total += internals->rxq_scg[i].rx_pkts;
 		rx_total_b += internals->rxq_scg[i].rx_bytes;
 	}
 
 	for (i = 0; i < internals->nb_tx_queues; i++) {
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
-			stats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
-			stats->q_errors[i] = internals->txq_scg[i].err_pkts;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
+			qstats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
+			qstats->q_errors[i] = internals->txq_scg[i].err_pkts;
 		}
 		tx_total += internals->txq_scg[i].tx_pkts;
 		tx_total_b += internals->txq_scg[i].tx_bytes;
@@ -303,10 +304,11 @@ eth_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused)
 	return 0;
 }
 
-static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats)
+static int eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct pmd_internals *internals = eth_dev->data->dev_private;
-	dpdk_stats_collect(internals, stats);
+	dpdk_stats_collect(internals, stats, qstats);
 	return 0;
 }
 
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 4f273319f2..14bc65c8ad 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -426,7 +426,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	const struct pmd_internals *internal = dev->data->dev_private;
 	unsigned int i;
@@ -438,9 +439,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->ipackets += pkts;
 		stats->ibytes += bytes;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = pkts;
-			stats->q_ibytes[i] = bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = pkts;
+			qstats->q_ibytes[i] = bytes;
 		}
 	}
 
@@ -454,9 +455,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->opackets = pkts;
 		stats->obytes = bytes;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = pkts;
-			stats->q_obytes[i] = bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = pkts;
+			qstats->q_obytes[i] = bytes;
 		}
 	}
 
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index cd8e4bad3b..f7f927a4e7 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -614,7 +614,8 @@ otx_ep_dev_stats_reset(struct rte_eth_dev *dev)
 
 static int
 otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *stats)
+				struct rte_eth_stats *stats,
+				struct eth_queue_stats *qstats)
 {
 	struct otx_ep_device *otx_epvf = OTX_EP_DEV(eth_dev);
 	struct otx_ep_iq_stats *ostats;
@@ -625,17 +626,21 @@ otx_ep_dev_stats_get(struct rte_eth_dev *eth_dev,
 
 	for (i = 0; i < otx_epvf->nb_tx_queues; i++) {
 		ostats = &otx_epvf->instr_queue[i]->stats;
-		stats->q_opackets[i] = ostats->tx_pkts;
-		stats->q_obytes[i] = ostats->tx_bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = ostats->tx_pkts;
+			qstats->q_obytes[i] = ostats->tx_bytes;
+		}
 		stats->opackets += ostats->tx_pkts;
 		stats->obytes += ostats->tx_bytes;
 		stats->oerrors += ostats->instr_dropped;
 	}
 	for (i = 0; i < otx_epvf->nb_rx_queues; i++) {
 		istats = &otx_epvf->droq[i]->stats;
-		stats->q_ipackets[i] = istats->pkts_received;
-		stats->q_ibytes[i] = istats->bytes_received;
-		stats->q_errors[i] = istats->rx_err;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = istats->pkts_received;
+			qstats->q_ibytes[i] = istats->bytes_received;
+			qstats->q_errors[i] = istats->rx_err;
+		}
 		stats->ipackets += istats->pkts_received;
 		stats->ibytes += istats->bytes_received;
 		stats->imissed += istats->rx_alloc_failure;
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index 9451431144..21e3e56901 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1022,7 +1022,8 @@ octeontx_dev_xstats_get(struct rte_eth_dev *dev,
 }
 
 static int
-octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+octeontx_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		       struct eth_queue_stats *qstats __rte_unused)
 {
 	struct octeontx_nic *nic = octeontx_pmd_priv(dev);
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 728ef85d53..f323c0b0df 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -750,7 +750,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
@@ -762,21 +763,25 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
 			i < dev->data->nb_rx_queues; i++) {
-		stats->q_ipackets[i] = internal->rx_queue[i].rx_stat.pkts;
-		stats->q_ibytes[i] = internal->rx_queue[i].rx_stat.bytes;
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = internal->rx_queue[i].rx_stat.pkts;
+			qstats->q_ibytes[i] = internal->rx_queue[i].rx_stat.bytes;
+		}
 		rx_nombuf_total += internal->rx_queue[i].rx_stat.rx_nombuf;
 		rx_err_total += internal->rx_queue[i].rx_stat.err_pkts;
-		rx_packets_total += stats->q_ipackets[i];
-		rx_bytes_total += stats->q_ibytes[i];
+		rx_packets_total += internal->rx_queue[i].rx_stat.pkts;
+		rx_bytes_total += internal->rx_queue[i].rx_stat.bytes;
 		rx_missed_total += queue_missed_stat_get(dev, i);
 	}
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
 			i < dev->data->nb_tx_queues; i++) {
-		stats->q_opackets[i] = internal->tx_queue[i].tx_stat.pkts;
-		stats->q_obytes[i] = internal->tx_queue[i].tx_stat.bytes;
-		tx_packets_total += stats->q_opackets[i];
-		tx_bytes_total += stats->q_obytes[i];
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = internal->tx_queue[i].tx_stat.pkts;
+			qstats->q_obytes[i] = internal->tx_queue[i].tx_stat.bytes;
+		}
+		tx_packets_total += internal->tx_queue[i].tx_stat.pkts;
+		tx_bytes_total += internal->tx_queue[i].tx_stat.bytes;
 		tx_packets_err_total += internal->tx_queue[i].tx_stat.err_pkts;
 	}
 
diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 725ffcb2bc..1efa17539e 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -713,7 +713,8 @@ pfe_dev_set_mac_addr(struct rte_eth_dev *dev,
 
 static int
 pfe_stats_get(struct rte_eth_dev *dev,
-	      struct rte_eth_stats *stats)
+	      struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats __rte_unused)
 {
 	struct pfe_eth_priv_s *priv = dev->data->dev_private;
 	struct rte_eth_stats *eth_stats = &priv->stats;
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index bee9fa4f60..e1c28a0ac2 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1592,7 +1592,8 @@ static int qede_dev_close(struct rte_eth_dev *eth_dev)
 }
 
 static int
-qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats)
+qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats,
+	       struct eth_queue_stats *qstats)
 {
 	struct qede_dev *qdev = eth_dev->data->dev_private;
 	struct ecore_dev *edev = &qdev->edev;
@@ -1645,18 +1646,18 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats)
 		       " appropriately and retry.\n");
 
 	for (qid = 0; qid < eth_dev->data->nb_rx_queues; qid++) {
-		eth_stats->q_ipackets[i] = 0;
-		eth_stats->q_errors[i] = 0;
+		uint64_t q_ipackets = 0;
+		uint64_t q_errors = 0;
 
 		for_each_hwfn(edev, hw_fn) {
 			idx = qid * edev->num_hwfns + hw_fn;
 
-			eth_stats->q_ipackets[i] +=
+			q_ipackets +=
 				*(uint64_t *)
 					(((char *)(qdev->fp_array[idx].rxq)) +
 					 offsetof(struct qede_rx_queue,
 					 rcv_pkts));
-			eth_stats->q_errors[i] +=
+			q_errors +=
 				*(uint64_t *)
 					(((char *)(qdev->fp_array[idx].rxq)) +
 					 offsetof(struct qede_rx_queue,
@@ -1667,25 +1668,33 @@ qede_get_stats(struct rte_eth_dev *eth_dev, struct rte_eth_stats *eth_stats)
 					 rx_alloc_errors));
 		}
 
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = q_ipackets;
+			qstats->q_errors[i] = q_errors;
+		}
+
 		i++;
 		if (i == rxq_stat_cntrs)
 			break;
 	}
 
 	for (qid = 0; qid < eth_dev->data->nb_tx_queues; qid++) {
-		eth_stats->q_opackets[j] = 0;
+		uint64_t q_opackets = 0;
 
 		for_each_hwfn(edev, hw_fn) {
 			idx = qid * edev->num_hwfns + hw_fn;
 
 			txq = qdev->fp_array[idx].txq;
-			eth_stats->q_opackets[j] +=
+			q_opackets +=
 				*((uint64_t *)(uintptr_t)
 					(((uint64_t)(uintptr_t)(txq)) +
 					 offsetof(struct qede_tx_queue,
 						  xmit_pkts)));
 		}
 
+		if (qstats != NULL)
+			qstats->q_opackets[j] = q_opackets;
+
 		j++;
 		if (j == txq_stat_cntrs)
 			break;
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 8071e14412..69512ced8b 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -37,7 +37,8 @@ static int rtl_dev_set_link_down(struct rte_eth_dev *dev);
 static int rtl_dev_infos_get(struct rte_eth_dev *dev,
 			     struct rte_eth_dev_info *dev_info);
 static int rtl_dev_stats_get(struct rte_eth_dev *dev,
-			     struct rte_eth_stats *rte_stats);
+			     struct rte_eth_stats *rte_stats,
+			     struct eth_queue_stats *qstats);
 static int rtl_dev_stats_reset(struct rte_eth_dev *dev);
 static int rtl_promiscuous_enable(struct rte_eth_dev *dev);
 static int rtl_promiscuous_disable(struct rte_eth_dev *dev);
@@ -533,7 +534,8 @@ rtl_sw_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
 }
 
 static int
-rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
+rtl_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
+		struct eth_queue_stats *qstats __rte_unused)
 {
 	struct rtl_adapter *adapter = RTL_DEV_PRIVATE(dev);
 	struct rtl_hw *hw = &adapter->hw;
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..b639544eab 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -196,7 +196,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 	unsigned long rx_total = 0, tx_total = 0;
@@ -204,14 +205,16 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
 			i < dev->data->nb_rx_queues; i++) {
-		stats->q_ipackets[i] = internal->rx_ring_queues[i].rx_pkts;
-		rx_total += stats->q_ipackets[i];
+		if (qstats != NULL)
+			qstats->q_ipackets[i] = internal->rx_ring_queues[i].rx_pkts;
+		rx_total += internal->rx_ring_queues[i].rx_pkts;
 	}
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
 			i < dev->data->nb_tx_queues; i++) {
-		stats->q_opackets[i] = internal->tx_ring_queues[i].tx_pkts;
-		tx_total += stats->q_opackets[i];
+		if (qstats != NULL)
+			qstats->q_opackets[i] = internal->tx_ring_queues[i].tx_pkts;
+		tx_total += internal->tx_ring_queues[i].tx_pkts;
 	}
 
 	stats->ipackets = rx_total;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index de1c077f61..f5babb797d 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1233,7 +1233,8 @@ static void rnp_get_hw_stats(struct rte_eth_dev *dev)
 
 static int
 rnp_dev_stats_get(struct rte_eth_dev *dev,
-		  struct rte_eth_stats *stats)
+		  struct rte_eth_stats *stats,
+		  struct eth_queue_stats *qstats)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
 	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
@@ -1251,9 +1252,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 			continue;
 		stats->ipackets += rxq->stats.ipackets;
 		stats->ibytes += rxq->stats.ibytes;
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = rxq->stats.ipackets;
-			stats->q_ibytes[i] = rxq->stats.ibytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxq->stats.ipackets;
+			qstats->q_ibytes[i] = rxq->stats.ibytes;
 		}
 	}
 
@@ -1265,9 +1266,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 		stats->opackets += txq->stats.opackets;
 		stats->obytes += txq->stats.obytes;
 		stats->oerrors += txq->stats.errors;
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = txq->stats.opackets;
-			stats->q_obytes[i] = txq->stats.obytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = txq->stats.opackets;
+			qstats->q_obytes[i] = txq->stats.obytes;
 		}
 	}
 	stats->imissed = eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 8b0bf4eeee..99141bdda5 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -823,7 +823,8 @@ sfc_update_diff_stat(uint64_t *stat, uint64_t newval)
 }
 
 static int
-sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+sfc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats __rte_unused)
 {
 	const struct sfc_adapter_priv *sap = sfc_adapter_priv_by_eth_dev(dev);
 	bool have_dp_rx_stats = sap->dp_rx->features & SFC_DP_RX_FEAT_STATS;
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 18e76fa7da..93da97387c 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -846,7 +846,8 @@ sfc_repr_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr)
 }
 
 static int
-sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+sfc_repr_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats __rte_unused)
 {
 	union sfc_pkts_bytes queue_stats;
 	uint16_t i;
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 650ddbd706..3c9ba829d6 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1030,7 +1030,8 @@ tap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 }
 
 static int
-tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats)
+tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
+	      struct eth_queue_stats *qstats)
 {
 	unsigned int i, imax;
 	unsigned long rx_total = 0, tx_total = 0, tx_err_total = 0;
@@ -1042,10 +1043,12 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats)
 	imax = (dev->data->nb_rx_queues < RTE_ETHDEV_QUEUE_STAT_CNTRS) ?
 		dev->data->nb_rx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;
 	for (i = 0; i < imax; i++) {
-		tap_stats->q_ipackets[i] = pmd->rxq[i].stats.ipackets;
-		tap_stats->q_ibytes[i] = pmd->rxq[i].stats.ibytes;
-		rx_total += tap_stats->q_ipackets[i];
-		rx_bytes_total += tap_stats->q_ibytes[i];
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = pmd->rxq[i].stats.ipackets;
+			qstats->q_ibytes[i] = pmd->rxq[i].stats.ibytes;
+		}
+		rx_total += pmd->rxq[i].stats.ipackets;
+		rx_bytes_total += pmd->rxq[i].stats.ibytes;
 		rx_nombuf += pmd->rxq[i].stats.rx_nombuf;
 		ierrors += pmd->rxq[i].stats.ierrors;
 	}
@@ -1055,11 +1058,13 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats)
 		dev->data->nb_tx_queues : RTE_ETHDEV_QUEUE_STAT_CNTRS;
 
 	for (i = 0; i < imax; i++) {
-		tap_stats->q_opackets[i] = pmd->txq[i].stats.opackets;
-		tap_stats->q_obytes[i] = pmd->txq[i].stats.obytes;
-		tx_total += tap_stats->q_opackets[i];
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = pmd->txq[i].stats.opackets;
+			qstats->q_obytes[i] = pmd->txq[i].stats.obytes;
+		}
+		tx_total += pmd->txq[i].stats.opackets;
+		tx_bytes_total += pmd->txq[i].stats.obytes;
 		tx_err_total += pmd->txq[i].stats.errs;
-		tx_bytes_total += tap_stats->q_obytes[i];
 	}
 
 	tap_stats->ipackets = rx_total;
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 4441a90bdf..76ed76a045 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -289,7 +289,8 @@ nicvf_dev_get_regs(struct rte_eth_dev *dev, struct rte_dev_reg_info *regs)
 }
 
 static int
-nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats)
 {
 	uint16_t qidx;
 	struct nicvf_hw_rx_qstats rx_qstats;
@@ -309,8 +310,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			break;
 
 		nicvf_hw_get_rx_qstats(nic, &rx_qstats, qidx);
-		stats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
-		stats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+		if (qstats != NULL) {
+			qstats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
+			qstats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+		}
 	}
 
 	/* TX queue indices for the first VF */
@@ -322,8 +325,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			break;
 
 		nicvf_hw_get_tx_qstats(nic, &tx_qstats, qidx);
-		stats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
-		stats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+		if (qstats != NULL) {
+			qstats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
+			qstats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+		}
 	}
 
 	for (i = 0; i < nic->sqs_count; i++) {
@@ -342,8 +347,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 			nicvf_hw_get_rx_qstats(snic, &rx_qstats,
 					       qidx % MAX_RCV_QUEUES_PER_QS);
-			stats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
-			stats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+			if (qstats != NULL) {
+				qstats->q_ibytes[qidx] = rx_qstats.q_rx_bytes;
+				qstats->q_ipackets[qidx] = rx_qstats.q_rx_packets;
+			}
 		}
 
 		/* TX queue indices for a secondary VF */
@@ -355,8 +362,10 @@ nicvf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 			nicvf_hw_get_tx_qstats(snic, &tx_qstats,
 					       qidx % MAX_SND_QUEUES_PER_QS);
-			stats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
-			stats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+			if (qstats != NULL) {
+				qstats->q_obytes[qidx] = tx_qstats.q_tx_bytes;
+				qstats->q_opackets[qidx] = tx_qstats.q_tx_packets;
+			}
 		}
 	}
 
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 580579094b..33d1d59ead 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2342,7 +2342,8 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
 }
 
 static int
-txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
@@ -2362,29 +2363,31 @@ txgbe_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	stats->opackets = hw_stats->tx_packets;
 	stats->obytes = hw_stats->tx_bytes;
 
-	memset(&stats->q_ipackets, 0, sizeof(stats->q_ipackets));
-	memset(&stats->q_opackets, 0, sizeof(stats->q_opackets));
-	memset(&stats->q_ibytes, 0, sizeof(stats->q_ibytes));
-	memset(&stats->q_obytes, 0, sizeof(stats->q_obytes));
-	memset(&stats->q_errors, 0, sizeof(stats->q_errors));
-	for (i = 0; i < TXGBE_MAX_QP; i++) {
-		uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
-		uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
-		uint32_t q_map;
-
-		q_map = (stat_mappings->rqsm[n] >> offset)
-				& QMAP_FIELD_RESERVED_BITS_MASK;
-		j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-		     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		stats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
-		stats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
-
-		q_map = (stat_mappings->tqsm[n] >> offset)
-				& QMAP_FIELD_RESERVED_BITS_MASK;
-		j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
-		     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
-		stats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
-		stats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+	if (qstats != NULL) {
+		memset(&qstats->q_ipackets, 0, sizeof(qstats->q_ipackets));
+		memset(&qstats->q_opackets, 0, sizeof(qstats->q_opackets));
+		memset(&qstats->q_ibytes, 0, sizeof(qstats->q_ibytes));
+		memset(&qstats->q_obytes, 0, sizeof(qstats->q_obytes));
+		memset(&qstats->q_errors, 0, sizeof(qstats->q_errors));
+		for (i = 0; i < TXGBE_MAX_QP; i++) {
+			uint32_t n = i / NB_QMAP_FIELDS_PER_QSM_REG;
+			uint32_t offset = (i % NB_QMAP_FIELDS_PER_QSM_REG) * 8;
+			uint32_t q_map;
+
+			q_map = (stat_mappings->rqsm[n] >> offset)
+					& QMAP_FIELD_RESERVED_BITS_MASK;
+			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
+			qstats->q_ipackets[j] += hw_stats->qp[i].rx_qp_packets;
+			qstats->q_ibytes[j] += hw_stats->qp[i].rx_qp_bytes;
+
+			q_map = (stat_mappings->tqsm[n] >> offset)
+					& QMAP_FIELD_RESERVED_BITS_MASK;
+			j = (q_map < RTE_ETHDEV_QUEUE_STAT_CNTRS
+			     ? q_map : q_map % RTE_ETHDEV_QUEUE_STAT_CNTRS);
+			qstats->q_opackets[j] += hw_stats->qp[i].tx_qp_packets;
+			qstats->q_obytes[j] += hw_stats->qp[i].tx_qp_bytes;
+		}
 	}
 
 	/* Rx Errors */
@@ -2426,7 +2429,7 @@ txgbe_dev_stats_reset(struct rte_eth_dev *dev)
 
 	/* HW registers are cleared on read */
 	hw->offset_loaded = 0;
-	txgbe_dev_stats_get(dev, NULL);
+	txgbe_dev_stats_get(dev, NULL, NULL);
 	hw->offset_loaded = 1;
 
 	/* Reset software totals */
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 847febf8c3..b369070da8 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -494,7 +494,8 @@ txgbevf_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+txgbevf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats __rte_unused)
 {
 	struct txgbevf_hw_stats *hw_stats = (struct txgbevf_hw_stats *)
 			  TXGBE_DEV_STATS(dev);
@@ -528,7 +529,7 @@ txgbevf_dev_stats_reset(struct rte_eth_dev *dev)
 	uint32_t i;
 
 	/* Sync HW register to the last stats */
-	txgbevf_dev_stats_get(dev, NULL);
+	txgbevf_dev_stats_get(dev, NULL, NULL);
 
 	/* reset HW current stats*/
 	for (i = 0; i < 8; i++) {
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 87c91e2f96..05940f2461 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1310,7 +1310,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	      struct eth_queue_stats *qstats)
 {
 	unsigned i;
 	unsigned long rx_total = 0, tx_total = 0;
@@ -1323,11 +1324,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (dev->data->rx_queues[i] == NULL)
 			continue;
 		vq = dev->data->rx_queues[i];
-		stats->q_ipackets[i] = vq->stats.pkts;
-		rx_total += stats->q_ipackets[i];
-
-		stats->q_ibytes[i] = vq->stats.bytes;
-		rx_total_bytes += stats->q_ibytes[i];
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = vq->stats.pkts;
+			qstats->q_ibytes[i] = vq->stats.bytes;
+		}
+		rx_total += vq->stats.pkts;
+		rx_total_bytes += vq->stats.bytes;
 	}
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
@@ -1335,12 +1337,12 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		if (dev->data->tx_queues[i] == NULL)
 			continue;
 		vq = dev->data->tx_queues[i];
-		stats->q_opackets[i] = vq->stats.pkts;
-		tx_total += stats->q_opackets[i];
-
-		stats->q_obytes[i] = vq->stats.bytes;
-		tx_total_bytes += stats->q_obytes[i];
-
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = vq->stats.pkts;
+			qstats->q_obytes[i] = vq->stats.bytes;
+		}
+		tx_total += vq->stats.pkts;
+		tx_total_bytes += vq->stats.bytes;
 		tx_total_errors += vq->stats.missed_pkts;
 	}
 
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index eebc3ea817..e45dbd8ee9 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -68,7 +68,8 @@ static void virtio_set_hwaddr(struct virtio_hw *hw);
 static void virtio_get_hwaddr(struct virtio_hw *hw);
 
 static int virtio_dev_stats_get(struct rte_eth_dev *dev,
-				 struct rte_eth_stats *stats);
+				 struct rte_eth_stats *stats,
+				 struct eth_queue_stats *qstats);
 static int virtio_dev_xstats_get(struct rte_eth_dev *dev,
 				 struct rte_eth_xstat *xstats, unsigned n);
 static int virtio_dev_xstats_get_names(struct rte_eth_dev *dev,
@@ -673,7 +674,8 @@ const struct eth_dev_ops virtio_user_secondary_eth_dev_ops = {
 };
 
 static void
-virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		    struct eth_queue_stats *qstats)
 {
 	unsigned i;
 
@@ -685,9 +687,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->opackets += txvq->stats.packets;
 		stats->obytes += txvq->stats.bytes;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = txvq->stats.packets;
-			stats->q_obytes[i] = txvq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = txvq->stats.packets;
+			qstats->q_obytes[i] = txvq->stats.bytes;
 		}
 	}
 
@@ -700,9 +702,9 @@ virtio_update_stats(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->ibytes += rxvq->stats.bytes;
 		stats->ierrors += rxvq->stats.errors;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = rxvq->stats.packets;
-			stats->q_ibytes[i] = rxvq->stats.bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxvq->stats.packets;
+			qstats->q_ibytes[i] = rxvq->stats.bytes;
 		}
 	}
 
@@ -802,9 +804,10 @@ virtio_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+virtio_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		     struct eth_queue_stats *qstats)
 {
-	virtio_update_stats(dev, stats);
+	virtio_update_stats(dev, stats, qstats);
 
 	return 0;
 }
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index e19aa43888..b0c19c5c7c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -77,7 +77,8 @@ static int vmxnet3_dev_link_update(struct rte_eth_dev *dev,
 				   int wait_to_complete);
 static void vmxnet3_hw_stats_save(struct vmxnet3_hw *hw);
 static int vmxnet3_dev_stats_get(struct rte_eth_dev *dev,
-				  struct rte_eth_stats *stats);
+				  struct rte_eth_stats *stats,
+				  struct eth_queue_stats *qstats);
 static int vmxnet3_dev_stats_reset(struct rte_eth_dev *dev);
 static int vmxnet3_dev_xstats_get_names(struct rte_eth_dev *dev,
 					struct rte_eth_xstat_name *xstats,
@@ -1470,7 +1471,8 @@ vmxnet3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 }
 
 static int
-vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	unsigned int i;
 	struct vmxnet3_hw *hw = dev->data->dev_private;
@@ -1495,9 +1497,9 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->obytes += bytes;
 		stats->oerrors += txStats.pktsTxError + txStats.pktsTxDiscard;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = packets;
-			stats->q_obytes[i] = bytes;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = packets;
+			qstats->q_obytes[i] = bytes;
 		}
 	}
 
@@ -1517,10 +1519,10 @@ vmxnet3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		stats->ierrors += rxStats.pktsRxError;
 		stats->imissed += rxStats.pktsRxOutOfBuf;
 
-		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = packets;
-			stats->q_ibytes[i] = bytes;
-			stats->q_errors[i] = rxStats.pktsRxError;
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = packets;
+			qstats->q_ibytes[i] = bytes;
+			qstats->q_errors[i] = rxStats.pktsRxError;
 		}
 	}
 
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 988d734b5b..07fc52ac7b 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -577,7 +577,8 @@ xsc_ethdev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
 }
 
 static int
-xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
 	uint32_t rxqs_n = priv->num_rq;
@@ -592,10 +593,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			continue;
 
 		idx = rxq->idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[idx] += rxq->stats.rx_pkts;
-			stats->q_ibytes[idx] += rxq->stats.rx_bytes;
-			stats->q_errors[idx] += rxq->stats.rx_errors +
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[idx] += rxq->stats.rx_pkts;
+			qstats->q_ibytes[idx] += rxq->stats.rx_bytes;
+			qstats->q_errors[idx] += rxq->stats.rx_errors +
 						rxq->stats.rx_nombuf;
 		}
 		stats->ipackets += rxq->stats.rx_pkts;
@@ -610,10 +611,10 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 			continue;
 
 		idx = txq->idx;
-		if (idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[idx] += txq->stats.tx_pkts;
-			stats->q_obytes[idx] += txq->stats.tx_bytes;
-			stats->q_errors[idx] += txq->stats.tx_errors;
+		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[idx] += txq->stats.tx_pkts;
+			qstats->q_obytes[idx] += txq->stats.tx_bytes;
+			qstats->q_errors[idx] += txq->stats.tx_errors;
 		}
 		stats->opackets += txq->stats.tx_pkts;
 		stats->obytes += txq->stats.tx_bytes;
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
index da32512b03..6d9f0af748 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -1698,7 +1698,8 @@ zxdh_hw_np_stats_get(struct rte_eth_dev *dev, struct zxdh_hw_np_stats *np_stats)
 }
 
 int
-zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats)
 {
 	struct zxdh_hw *hw = dev->data->dev_private;
 	struct zxdh_hw_vqm_stats vqm_stats = {0};
@@ -1730,14 +1731,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 		if (rxvq == NULL)
 			continue;
-		stats->q_ipackets[i] = *(uint64_t *)(((char *)rxvq) +
-				zxdh_rxq_stat_strings[0].offset);
-		stats->q_ibytes[i] = *(uint64_t *)(((char *)rxvq) +
-				zxdh_rxq_stat_strings[1].offset);
-		stats->q_errors[i] = *(uint64_t *)(((char *)rxvq) +
-				zxdh_rxq_stat_strings[2].offset);
-		stats->q_errors[i] += *(uint64_t *)(((char *)rxvq) +
-				zxdh_rxq_stat_strings[5].offset);
+		if (qstats != NULL) {
+			qstats->q_ipackets[i] = *(uint64_t *)(((char *)rxvq) +
+					zxdh_rxq_stat_strings[0].offset);
+			qstats->q_ibytes[i] = *(uint64_t *)(((char *)rxvq) +
+					zxdh_rxq_stat_strings[1].offset);
+			qstats->q_errors[i] = *(uint64_t *)(((char *)rxvq) +
+					zxdh_rxq_stat_strings[2].offset);
+			qstats->q_errors[i] += *(uint64_t *)(((char *)rxvq) +
+					zxdh_rxq_stat_strings[5].offset);
+		}
 	}
 
 	for (i = 0; (i < dev->data->nb_tx_queues) && (i < RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
@@ -1745,14 +1748,16 @@ zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 		if (txvq == NULL)
 			continue;
-		stats->q_opackets[i] = *(uint64_t *)(((char *)txvq) +
-				zxdh_txq_stat_strings[0].offset);
-		stats->q_obytes[i] = *(uint64_t *)(((char *)txvq) +
-				zxdh_txq_stat_strings[1].offset);
-		stats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
-				zxdh_txq_stat_strings[2].offset);
-		stats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
-				zxdh_txq_stat_strings[5].offset);
+		if (qstats != NULL) {
+			qstats->q_opackets[i] = *(uint64_t *)(((char *)txvq) +
+					zxdh_txq_stat_strings[0].offset);
+			qstats->q_obytes[i] = *(uint64_t *)(((char *)txvq) +
+					zxdh_txq_stat_strings[1].offset);
+			qstats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
+					zxdh_txq_stat_strings[2].offset);
+			qstats->q_errors[i] += *(uint64_t *)(((char *)txvq) +
+					zxdh_txq_stat_strings[5].offset);
+		}
 	}
 	return 0;
 }
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.h b/drivers/net/zxdh/zxdh_ethdev_ops.h
index 86db6efe40..85e926887b 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.h
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.h
@@ -130,7 +130,8 @@ int zxdh_dev_rss_reta_query(struct rte_eth_dev *dev,
 int zxdh_rss_hash_update(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf);
 int zxdh_rss_hash_conf_get(struct rte_eth_dev *dev, struct rte_eth_rss_conf *rss_conf);
 int zxdh_rss_configure(struct rte_eth_dev *dev);
-int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats);
+int zxdh_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+		struct eth_queue_stats *qstats);
 int zxdh_dev_stats_reset(struct rte_eth_dev *dev);
 int zxdh_dev_mtu_set(struct rte_eth_dev *dev, uint16_t new_mtu);
 int zxdh_hw_np_stats_pf_reset(struct rte_eth_dev *dev, uint32_t stats_id);
-- 
2.48.1

