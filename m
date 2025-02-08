Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7BFC02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AFC14067C;
	Sat,  8 Feb 2025 03:44:58 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id C19B6402E6
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:44:50 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 13965A3243; Sat,  8 Feb 2025 10:44:21 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v7 14/28] net/rnp: add Rx burst simple support
Date: Sat,  8 Feb 2025 10:43:51 +0800
Message-Id: <1738982645-34550-15-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
References: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
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

add only support simple recv pkts.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |   7 +++
 drivers/net/rnp/rnp_rxtx.c   | 129 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h   |   5 ++
 3 files changed, 141 insertions(+)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index e229b2e..e5f984f 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -329,6 +329,8 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	rnp_dev_set_link_up(eth_dev);
 	/* enable eth rx flow */
 	RNP_RX_ETH_ENABLE(hw, lane);
+	rnp_rx_func_select(eth_dev);
+	rnp_tx_func_select(eth_dev);
 	port->port_stopped = 0;
 
 	return 0;
@@ -568,6 +570,11 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
 		.rx_drop_en = 0,
+		.rx_thresh = {
+			.pthresh = RNP_RX_DESC_FETCH_TH,
+			.hthresh = RNP_RX_DESC_FETCH_BURST,
+		},
+		.rx_free_thresh = RNP_DEFAULT_RX_FREE_THRESH,
 		.offloads = 0,
 	};
 
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 2b172c8..8553fbf 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -641,3 +641,132 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 
 	return 0;
 }
+
+#define RNP_CACHE_FETCH_RX (4)
+static __rte_always_inline int
+rnp_refill_rx_ring(struct rnp_rx_queue *rxq)
+{
+	volatile struct rnp_rx_desc *rxbd;
+	struct rnp_rxsw_entry *rx_swbd;
+	struct rte_mbuf *mb;
+	uint16_t j, i;
+	uint16_t rx_id;
+	int ret;
+
+	rxbd = rxq->rx_bdr + rxq->rxrearm_start;
+	rx_swbd = &rxq->sw_ring[rxq->rxrearm_start];
+	ret = rte_mempool_get_bulk(rxq->mb_pool, (void *)rx_swbd,
+			rxq->rx_free_thresh);
+	if (unlikely(ret != 0)) {
+		if (rxq->rxrearm_nb + rxq->rx_free_thresh >= rxq->attr.nb_desc) {
+			for (i = 0; i < RNP_CACHE_FETCH_RX; i++) {
+				rx_swbd[i].mbuf = &rxq->fake_mbuf;
+				rxbd[i].d.pkt_addr = 0;
+				rxbd[i].d.cmd = 0;
+			}
+		}
+		rte_eth_devices[rxq->attr.port_id].data->rx_mbuf_alloc_failed +=
+			rxq->rx_free_thresh;
+		return 0;
+	}
+	for (j = 0; j < rxq->rx_free_thresh; ++j) {
+		mb = rx_swbd[j].mbuf;
+		rte_mbuf_refcnt_set(mb, 1);
+		mb->data_off = RTE_PKTMBUF_HEADROOM;
+		mb->port = rxq->attr.port_id;
+
+		rxbd[j].d.pkt_addr = rnp_get_dma_addr(&rxq->attr, mb);
+		rxbd[j].d.cmd = 0;
+	}
+	rxq->rxrearm_start += rxq->rx_free_thresh;
+	if (rxq->rxrearm_start >= rxq->attr.nb_desc - 1)
+		rxq->rxrearm_start = 0;
+	rxq->rxrearm_nb -= rxq->rx_free_thresh;
+
+	rx_id = (uint16_t)((rxq->rxrearm_start == 0) ?
+			(rxq->attr.nb_desc - 1) : (rxq->rxrearm_start - 1));
+	rte_wmb();
+	RNP_REG_WR(rxq->rx_tailreg, 0, rx_id);
+
+	return j;
+}
+
+static __rte_always_inline uint16_t
+rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct rnp_rx_queue *rxq = (struct rnp_rx_queue *)_rxq;
+	struct rnp_rxsw_entry *rx_swbd;
+	uint32_t state_cmd[RNP_CACHE_FETCH_RX];
+	uint32_t pkt_len[RNP_CACHE_FETCH_RX] = {0};
+	volatile struct rnp_rx_desc *rxbd;
+	struct rte_mbuf *nmb;
+	int nb_dd, nb_rx = 0;
+	int i, j;
+
+	if (unlikely(!rxq->rxq_started || !rxq->rx_link))
+		return 0;
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, RNP_CACHE_FETCH_RX);
+	rxbd = &rxq->rx_bdr[rxq->rx_tail];
+	rte_prefetch0(rxbd);
+	if (rxq->rxrearm_nb > rxq->rx_free_thresh)
+		rnp_refill_rx_ring(rxq);
+
+	if (!(rxbd->wb.qword1.cmd & RNP_CMD_DD))
+		return 0;
+
+	rx_swbd = &rxq->sw_ring[rxq->rx_tail];
+	for (i = 0; i < nb_pkts;
+			i += RNP_CACHE_FETCH_RX, rxbd += RNP_CACHE_FETCH_RX,
+			rx_swbd += RNP_CACHE_FETCH_RX) {
+		for (j = 0; j < RNP_CACHE_FETCH_RX; j++)
+			state_cmd[j] = rxbd[j].wb.qword1.cmd;
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+
+		for (nb_dd = 0; nb_dd < RNP_CACHE_FETCH_RX &&
+				(state_cmd[nb_dd] & rte_cpu_to_le_16(RNP_CMD_DD));
+				nb_dd++)
+			;
+		for (j = 0; j < nb_dd; j++)
+			pkt_len[j] = rxbd[j].wb.qword1.lens;
+
+		for (j = 0; j < nb_dd; ++j) {
+			nmb = rx_swbd[j].mbuf;
+
+			nmb->data_off = RTE_PKTMBUF_HEADROOM;
+			nmb->port = rxq->attr.port_id;
+			nmb->data_len = pkt_len[j];
+			nmb->pkt_len = pkt_len[j];
+			nmb->packet_type = 0;
+			nmb->ol_flags = 0;
+			nmb->nb_segs = 1;
+		}
+		for (j = 0; j < nb_dd; ++j) {
+			rx_pkts[i + j] = rx_swbd[j].mbuf;
+			rx_swbd[j].mbuf = NULL;
+		}
+
+		nb_rx += nb_dd;
+		rxq->nb_rx_free -= nb_dd;
+		if (nb_dd != RNP_CACHE_FETCH_RX)
+			break;
+	}
+	rxq->rx_tail = (rxq->rx_tail + nb_rx) & rxq->attr.nb_desc_mask;
+	rxq->rxrearm_nb = rxq->rxrearm_nb + nb_rx;
+
+	return nb_rx;
+}
+
+int rnp_rx_func_select(struct rte_eth_dev *dev)
+{
+	dev->rx_pkt_burst = rnp_recv_pkts;
+
+	return 0;
+}
+
+int rnp_tx_func_select(struct rte_eth_dev *dev)
+{
+	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
+
+	return 0;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 94e1f06..39e5184 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -63,6 +63,9 @@ struct rnp_rx_queue {
 	uint16_t rx_free_thresh; /* rx free desc desource thresh */
 	uint16_t rx_tail;
 
+	uint16_t rxrearm_start;
+	uint16_t rxrearm_nb;
+
 	uint32_t nodesc_tm_thresh; /* rx queue no desc timeout thresh */
 	uint8_t rx_deferred_start; /* do not start queue with dev_start(). */
 	uint8_t rxq_started; /* rx queue is started */
@@ -128,5 +131,7 @@ int rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		       const struct rte_eth_txconf *tx_conf);
 int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
+int rnp_rx_func_select(struct rte_eth_dev *dev);
+int rnp_tx_func_select(struct rte_eth_dev *dev);
 
 #endif /* _RNP_RXTX_H_ */
-- 
1.8.3.1

