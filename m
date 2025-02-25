Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35512C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 08:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFEA142E6F;
	Tue, 25 Feb 2025 09:42:04 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id D15F742E24
 for <dev@dpdk.org>; Tue, 25 Feb 2025 09:41:54 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 2FE03A3246; Tue, 25 Feb 2025 16:41:54 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v15 19/29] net/rnp: add support basic stats operation
Date: Tue, 25 Feb 2025 16:41:16 +0800
Message-Id: <1740472886-30411-20-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
References: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
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

add support hw-missed rx/tx packets bytes.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   2 +
 doc/guides/nics/rnp.rst             |   3 +
 drivers/net/rnp/base/rnp_eth_regs.h |   3 +
 drivers/net/rnp/rnp.h               |   8 ++
 drivers/net/rnp/rnp_ethdev.c        | 136 ++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.c          |   9 ++
 drivers/net/rnp/rnp_rxtx.h          |  10 ++
 7 files changed, 171 insertions(+)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 6453762745..07caedba7a 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -7,6 +7,8 @@
 Speed capabilities   = Y
 Link status          = Y
 Link status event    = Y
+Basic stats          = Y
+Stats per queue      = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index b3d6d4d425..f23e7ca789 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -53,6 +53,7 @@ Features
 - MTU update
 - Jumbo frames
 - Scatter-Gather IO support
+- Port hardware statistic
 
 Prerequisites and Pre-conditions
 --------------------------------
@@ -100,3 +101,5 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_tx_queue_setup``
 * ``rte_eth_link_get``
 * ``rte_eth_link_get_nowait``
+* ``rte_eth_stats_get``
+* ``rte_eth_stats_reset``
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 91a18dd42d..391688bd80 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -23,6 +23,9 @@
 #define RNP_RX_FC_ENABLE	_ETH_(0x8520)
 #define RNP_RING_FC_EN(n)	_ETH_(0x8524 + ((0x4) * ((n) / 32)))
 #define RNP_RING_FC_THRESH(n)	_ETH_(0x8a00 + ((0x4) * (n)))
+/* ETH Statistic */
+#define RNP_ETH_RXTRANS_DROP	_ETH_(0x8904)
+#define RNP_ETH_RXTRUNC_DROP	_ETH_(0x8928)
 /* Mac Host Filter  */
 #define RNP_MAC_FCTRL		_ETH_(0x9110)
 #define RNP_MAC_FCTRL_MPE	RTE_BIT32(8)  /* Multicast Promiscuous En */
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 8323858043..2cda0ffe55 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -108,6 +108,11 @@ struct rnp_proc_priv {
 	const struct rnp_mbx_ops *mbx_ops;
 };
 
+struct rnp_hw_eth_stats {
+	uint64_t rx_trans_drop;         /* rx eth to dma fifo full drop */
+	uint64_t rx_trunc_drop;         /* rx mac to eth to host copy fifo full drop */
+};
+
 struct rnp_eth_port {
 	struct rnp_proc_priv *proc_priv;
 	struct rte_ether_addr mac_addr;
@@ -116,6 +121,9 @@ struct rnp_eth_port {
 	struct rnp_tx_queue *tx_queues[RNP_MAX_RX_QUEUE_NUM];
 	struct rnp_hw *hw;
 
+	struct rnp_hw_eth_stats eth_stats_old;
+	struct rnp_hw_eth_stats eth_stats;
+
 	struct rte_eth_rss_conf rss_conf;
 	uint16_t last_rx_num;
 	bool rxq_num_changed;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 898e2ae338..1d8549161f 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -803,6 +803,139 @@ rnp_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+struct rte_rnp_xstats_name_off {
+	char name[RTE_ETH_XSTATS_NAME_SIZE];
+	uint32_t offset;
+	uint32_t reg_base;
+	bool hi_addr_en;
+};
+
+static const struct rte_rnp_xstats_name_off rte_rnp_rx_eth_stats_str[] = {
+	{"eth rx full drop", offsetof(struct rnp_hw_eth_stats,
+			rx_trans_drop), RNP_ETH_RXTRANS_DROP, false},
+	{"eth_rx_fifo_drop", offsetof(struct rnp_hw_eth_stats,
+			rx_trunc_drop), RNP_ETH_RXTRUNC_DROP, false},
+};
+#define RNP_NB_RX_HW_ETH_STATS (RTE_DIM(rte_rnp_rx_eth_stats_str))
+#define RNP_GET_E_HW_COUNT(stats, offset)            \
+	((uint64_t *)(((char *)stats) + (offset)))
+#define RNP_ADD_INCL_COUNT(stats, offset, val)       \
+	((*(RNP_GET_E_HW_COUNT(stats, (offset)))) += val)
+
+static inline void
+rnp_update_eth_stats_32bit(struct rnp_hw_eth_stats *new,
+			   struct rnp_hw_eth_stats *old,
+			   uint32_t offset, uint32_t val)
+{
+	uint64_t *last_count = NULL;
+
+	last_count = RNP_GET_E_HW_COUNT(old, offset);
+	if (val >= *last_count)
+		RNP_ADD_INCL_COUNT(new, offset, val - (*last_count));
+	else
+		RNP_ADD_INCL_COUNT(new, offset, val + UINT32_MAX);
+	*last_count = val;
+}
+
+static void rnp_get_eth_count(struct rnp_hw *hw,
+			      uint16_t lane,
+			      struct rnp_hw_eth_stats *new,
+			      struct rnp_hw_eth_stats *old,
+			      const struct rte_rnp_xstats_name_off *ptr)
+{
+	uint64_t val = 0;
+
+	if (ptr->reg_base) {
+		val = RNP_E_REG_RD(hw, ptr->reg_base + 0x40 * lane);
+		rnp_update_eth_stats_32bit(new, old, ptr->offset, val);
+	}
+}
+
+static void rnp_get_hw_stats(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw_eth_stats *old = &port->eth_stats_old;
+	struct rnp_hw_eth_stats *new = &port->eth_stats;
+	const struct rte_rnp_xstats_name_off *ptr;
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint16_t i;
+
+	for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
+		ptr = &rte_rnp_rx_eth_stats_str[i];
+		rnp_get_eth_count(hw, lane, new, old, ptr);
+	}
+}
+
+static int
+rnp_dev_stats_get(struct rte_eth_dev *dev,
+		  struct rte_eth_stats *stats)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
+	struct rte_eth_dev_data *data = dev->data;
+	uint16_t i = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	rnp_get_hw_stats(dev);
+
+	for (i = 0; i < data->nb_rx_queues; i++) {
+		const struct rnp_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (!rxq)
+			continue;
+		stats->ipackets += rxq->stats.ipackets;
+		stats->ibytes += rxq->stats.ibytes;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = rxq->stats.ipackets;
+			stats->q_ibytes[i] = rxq->stats.ibytes;
+		}
+	}
+
+	for (i = 0; i < data->nb_tx_queues; i++) {
+		const struct rnp_tx_queue *txq = dev->data->tx_queues[i];
+
+		if (!txq)
+			continue;
+		stats->opackets += txq->stats.opackets;
+		stats->obytes += txq->stats.obytes;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = txq->stats.opackets;
+			stats->q_obytes[i] = txq->stats.obytes;
+		}
+	}
+	stats->imissed = eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
+
+	return 0;
+}
+
+static int
+rnp_dev_stats_reset(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
+	uint16_t idx;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(eth_stats, 0, sizeof(*eth_stats));
+	for (idx = 0; idx < dev->data->nb_rx_queues; idx++) {
+		struct rnp_rx_queue *rxq = dev->data->rx_queues[idx];
+
+		if (!rxq)
+			continue;
+		memset(&rxq->stats, 0, sizeof(struct rnp_queue_stats));
+	}
+	for (idx = 0; idx < dev->data->nb_tx_queues; idx++) {
+		struct rnp_tx_queue *txq = dev->data->tx_queues[idx];
+
+		if (!txq)
+			continue;
+		memset(&txq->stats, 0, sizeof(struct rnp_queue_stats));
+	}
+
+	return 0;
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -826,6 +959,9 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.reta_query                   = rnp_dev_rss_reta_query,
 	.rss_hash_update              = rnp_dev_rss_hash_update,
 	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
+	/* stats */
+	.stats_get                    = rnp_dev_stats_get,
+	.stats_reset                  = rnp_dev_stats_reset,
 	/* link impl */
 	.link_update                  = rnp_dev_link_update,
 	.dev_set_link_up              = rnp_dev_set_link_up,
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index fa0890ca76..63c0723f70 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -737,6 +737,8 @@ rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			nmb->packet_type = 0;
 			nmb->ol_flags = 0;
 			nmb->nb_segs = 1;
+
+			rxq->stats.ibytes += nmb->data_len;
 		}
 		for (j = 0; j < nb_dd; ++j) {
 			rx_pkts[i + j] = rx_swbd[j].mbuf;
@@ -748,6 +750,7 @@ rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		if (nb_dd != RNP_CACHE_FETCH_RX)
 			break;
 	}
+	rxq->stats.ipackets += nb_rx;
 	rxq->rx_tail = (rxq->rx_tail + nb_rx) & rxq->attr.nb_desc_mask;
 	rxq->rxrearm_nb = rxq->rxrearm_nb + nb_rx;
 
@@ -817,6 +820,7 @@ rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		txbd->d.blen = tx_swbd->mbuf->data_len;
 		txbd->d.cmd = RNP_CMD_EOP;
 
+		txq->stats.obytes += txbd->d.blen;
 		i = (i + 1) & txq->attr.nb_desc_mask;
 	}
 	txq->nb_tx_free -= start;
@@ -828,6 +832,7 @@ rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (txq->tx_next_rs > txq->attr.nb_desc)
 			txq->tx_next_rs = txq->tx_rs_thresh - 1;
 	}
+	txq->stats.opackets += start;
 	txq->tx_tail = i;
 
 	rte_wmb();
@@ -933,6 +938,7 @@ rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
 		}
 		rxm->next = NULL;
 		first_seg->port = rxq->attr.port_id;
+		rxq->stats.ibytes += first_seg->pkt_len;
 		/* this the end of packet the large pkt has been recv finish */
 		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr,
 					first_seg->data_off));
@@ -941,6 +947,7 @@ rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
 	}
 	if (!nb_rx)
 		return 0;
+	rxq->stats.ipackets += nb_rx;
 	/* update sw record point */
 	rxq->rx_tail = rx_id;
 	rxq->pkt_first_seg = first_seg;
@@ -1030,6 +1037,7 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			tx_id = txe->next_id;
 			txe = txn;
 		} while (m_seg != NULL);
+		txq->stats.obytes += tx_pkt->pkt_len;
 		txbd->d.cmd |= RNP_CMD_EOP;
 		txq->nb_tx_used = (uint16_t)txq->nb_tx_used + nb_used_bd;
 		txq->nb_tx_free = (uint16_t)txq->nb_tx_free - nb_used_bd;
@@ -1041,6 +1049,7 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	}
 	if (!send_pkts)
 		return 0;
+	txq->stats.opackets += send_pkts;
 	txq->tx_tail = tx_id;
 
 	rte_wmb();
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index f63128555b..d26497a263 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -47,6 +47,14 @@ struct rnp_rxsw_entry {
 	struct rte_mbuf *mbuf;
 };
 
+struct rnp_queue_stats {
+	uint64_t obytes;
+	uint64_t opackets;
+
+	uint64_t ibytes;
+	uint64_t ipackets;
+};
+
 struct rnp_rx_queue {
 	struct rte_mempool *mb_pool; /* mbuf pool to populate rx ring. */
 	const struct rte_memzone *rz; /* rx hw ring base alloc memzone */
@@ -73,6 +81,7 @@ struct rnp_rx_queue {
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc prefetch burst */
 
+	struct rnp_queue_stats stats;
 	uint64_t rx_offloads; /* user set hw offload features */
 	struct rte_mbuf **free_mbufs; /* rx bulk alloc reserve of free mbufs */
 	struct rte_mbuf fake_mbuf; /* dummy mbuf */
@@ -113,6 +122,7 @@ struct rnp_tx_queue {
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc burst*/
 
+	struct rnp_queue_stats stats;
 	uint64_t tx_offloads; /* tx offload features */
 	struct rte_mbuf **free_mbufs; /* tx bulk free reserve of free mbufs */
 };
-- 
2.25.1

