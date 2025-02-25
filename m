Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B20CC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 08:42:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD8B42DD5;
	Tue, 25 Feb 2025 09:41:43 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id ED1AB42DCA
 for <dev@dpdk.org>; Tue, 25 Feb 2025 09:41:41 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id A2A34A3247; Tue, 25 Feb 2025 16:41:40 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v15 09/29] net/rnp: add queue stop and start operations
Date: Tue, 25 Feb 2025 16:41:06 +0800
Message-Id: <1740472886-30411-10-git-send-email-caowenbo@mucse.com>
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

support rx/tx queue stop/start,for rx queue stop
need to reset a queue,must stop all rx queue
during reset this queue.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini  |   1 +
 doc/guides/nics/rnp.rst           |   4 +
 drivers/net/rnp/base/rnp_common.c |   3 +
 drivers/net/rnp/rnp_rxtx.c        | 167 ++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h        |   9 ++
 5 files changed, 184 insertions(+)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 65f1ed3da0..fd7d4b9d8d 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Speed capabilities   = Y
+Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Linux                = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 99b96e9b8e..c3547c38b6 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -71,6 +71,10 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_close``
 * ``rte_eth_dev_stop``
 * ``rte_eth_dev_infos_get``
+* ``rte_eth_dev_rx_queue_start``
+* ``rte_eth_dev_rx_queue_stop``
+* ``rte_eth_dev_tx_queue_start``
+* ``rte_eth_dev_tx_queue_stop``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_common.c b/drivers/net/rnp/base/rnp_common.c
index 5655126ae0..58de3bde03 100644
--- a/drivers/net/rnp/base/rnp_common.c
+++ b/drivers/net/rnp/base/rnp_common.c
@@ -65,6 +65,9 @@ int rnp_init_hw(struct rnp_hw *hw)
 	/* setup mac resiger ctrl base */
 	for (idx = 0; idx < hw->max_port_num; idx++)
 		hw->mac_base[idx] = (u8 *)hw->e_ctrl + RNP_MAC_BASE_OFFSET(idx);
+	/* tx all hw queue must be started */
+	for (idx = 0; idx < RNP_MAX_RX_QUEUE_NUM; idx++)
+		RNP_E_REG_WR(hw, RNP_TXQ_START(idx), true);
 
 	return 0;
 }
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index d370948d6b..e65bc06d36 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -86,6 +86,7 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 	struct rte_eth_txconf def_conf;
 	struct rnp_hw *hw = port->hw;
 	struct rte_mbuf *m_mbuf[2];
+	bool tx_origin_e = false;
 	bool tx_new = false;
 	uint16_t index;
 	int err = 0;
@@ -121,6 +122,9 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 		return -ENOMEM;
 	}
 	rnp_rxq_flow_disable(hw, index);
+	tx_origin_e = txq->txq_started;
+	rte_io_wmb();
+	txq->txq_started = false;
 	rte_mbuf_refcnt_set(m_mbuf[0], 1);
 	rte_mbuf_refcnt_set(m_mbuf[1], 1);
 	m_mbuf[0]->data_off = RTE_PKTMBUF_HEADROOM;
@@ -139,6 +143,7 @@ rnp_rx_queue_reset(struct rnp_eth_port *port,
 			rnp_tx_queue_reset(port, txq);
 			rnp_tx_queue_sw_reset(txq);
 		}
+		txq->txq_started = tx_origin_e;
 	}
 	rte_mempool_put_bulk(adapter->reset_pool, (void **)m_mbuf, 2);
 	rnp_rxq_flow_enable(hw, index);
@@ -367,6 +372,7 @@ rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq)
 	txq->nb_tx_free = txq->attr.nb_desc - 1;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+	txq->tx_tail = 0;
 
 	size = (txq->attr.nb_desc + RNP_TX_MAX_BURST_SIZE);
 	for (idx = 0; idx < size * sizeof(struct rnp_tx_desc); idx++)
@@ -469,3 +475,164 @@ rnp_tx_queue_setup(struct rte_eth_dev *dev,
 
 	return err;
 }
+
+int rnp_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_tx_queue *txq;
+
+	PMD_INIT_FUNC_TRACE();
+	txq = eth_dev->data->tx_queues[qidx];
+	if (!txq) {
+		RNP_PMD_ERR("TX queue %u is null or not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		txq->txq_started = 0;
+		/* wait for tx burst process stop traffic */
+		rte_delay_us(10);
+		rnp_tx_queue_release_mbuf(txq);
+		rnp_tx_queue_reset(port, txq);
+		rnp_tx_queue_sw_reset(txq);
+		data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+int rnp_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_tx_queue *txq;
+
+	PMD_INIT_FUNC_TRACE();
+
+	txq = data->tx_queues[qidx];
+	if (!txq) {
+		RNP_PMD_ERR("Can't start tx queue %d it's not setup by "
+				"tx_queue_setup API", qidx);
+		return -EINVAL;
+	}
+	if (data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+		txq->txq_started = 1;
+	}
+
+	return 0;
+}
+
+int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	bool ori_q_state[RNP_MAX_RX_QUEUE_NUM];
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t hwrid;
+	uint16_t i = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(ori_q_state, 0, sizeof(ori_q_state));
+	if (qidx >= data->nb_rx_queues)
+		return -EINVAL;
+	rxq = data->rx_queues[qidx];
+	if (!rxq) {
+		RNP_PMD_ERR("rx queue %u is null or not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		hwrid = rxq->attr.index;
+		for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+			RNP_E_REG_WR(hw, RNP_RXQ_DROP_TIMEOUT_TH(i), 16);
+			ori_q_state[i] = RNP_E_REG_RD(hw, RNP_RXQ_START(i));
+			RNP_E_REG_WR(hw, RNP_RXQ_START(i), 0);
+		}
+		rxq->rxq_started = false;
+		rnp_rx_queue_release_mbuf(rxq);
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		rnp_rx_queue_reset(port, rxq);
+		rnp_rx_queue_sw_reset(rxq);
+		for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+			RNP_E_REG_WR(hw, RNP_RXQ_DROP_TIMEOUT_TH(i),
+					rxq->nodesc_tm_thresh);
+			RNP_E_REG_WR(hw, RNP_RXQ_START(i), ori_q_state[i]);
+		}
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+static int rnp_alloc_rxq_mbuf(struct rnp_rx_queue *rxq)
+{
+	struct rnp_rxsw_entry *rx_swbd = rxq->sw_ring;
+	volatile struct rnp_rx_desc *rxd;
+	struct rte_mbuf *mbuf = NULL;
+	uint64_t dma_addr;
+	uint16_t i;
+
+	for (i = 0; i < rxq->attr.nb_desc; i++) {
+		mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (!mbuf)
+			goto rx_mb_alloc_failed;
+		rx_swbd[i].mbuf = mbuf;
+
+		rte_mbuf_refcnt_set(mbuf, 1);
+		mbuf->next = NULL;
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+		mbuf->port = rxq->attr.port_id;
+		dma_addr = rnp_get_dma_addr(&rxq->attr, mbuf);
+
+		rxd = &rxq->rx_bdr[i];
+		*rxd = rxq->zero_desc;
+		rxd->d.pkt_addr = dma_addr;
+		rxd->d.cmd = 0;
+	}
+	memset(&rxq->fake_mbuf, 0x0, sizeof(rxq->fake_mbuf));
+	for (i = 0; i < RNP_RX_MAX_BURST_SIZE; ++i)
+		rxq->sw_ring[rxq->attr.nb_desc + i].mbuf = &rxq->fake_mbuf;
+
+	return 0;
+rx_mb_alloc_failed:
+	RNP_PMD_ERR("rx queue %u alloc mbuf failed", rxq->attr.queue_id);
+	rnp_rx_queue_release_mbuf(rxq);
+
+	return -ENOMEM;
+}
+
+int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	uint16_t hwrid;
+
+	PMD_INIT_FUNC_TRACE();
+	rxq = data->rx_queues[qidx];
+	if (!rxq) {
+		RNP_PMD_ERR("RX queue %u is Null or Not setup", qidx);
+		return -EINVAL;
+	}
+	if (data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		hwrid = rxq->attr.index;
+		/* disable ring */
+		rte_io_wmb();
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 0);
+		if (rnp_alloc_rxq_mbuf(rxq) != 0) {
+			RNP_PMD_ERR("Could not alloc mbuf for queue:%d", qidx);
+			return -ENOMEM;
+		}
+		rte_io_wmb();
+		RNP_REG_WR(rxq->rx_tailreg, 0, rxq->attr.nb_desc - 1);
+		RNP_E_REG_WR(hw, RNP_RXQ_START(hwrid), 1);
+		rxq->nb_rx_free = rxq->attr.nb_desc - 1;
+		rxq->rxq_started = true;
+
+		data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 3ea977ccaa..94e1f06722 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -65,11 +65,14 @@ struct rnp_rx_queue {
 
 	uint32_t nodesc_tm_thresh; /* rx queue no desc timeout thresh */
 	uint8_t rx_deferred_start; /* do not start queue with dev_start(). */
+	uint8_t rxq_started; /* rx queue is started */
+	uint8_t rx_link; /* device link state */
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc prefetch burst */
 
 	uint64_t rx_offloads; /* user set hw offload features */
 	struct rte_mbuf **free_mbufs; /* rx bulk alloc reserve of free mbufs */
+	struct rte_mbuf fake_mbuf; /* dummy mbuf */
 };
 
 struct rnp_txsw_entry {
@@ -98,6 +101,8 @@ struct rnp_tx_queue {
 	uint16_t tx_free_thresh; /* thresh to free tx desc resource */
 
 	uint8_t tx_deferred_start; /*< Do not start queue with dev_start(). */
+	uint8_t txq_started; /* tx queue is started */
+	uint8_t tx_link; /* device link state */
 	uint8_t pthresh; /* rx desc prefetch threshold */
 	uint8_t pburst; /* rx desc burst*/
 
@@ -115,9 +120,13 @@ int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
 		       unsigned int socket_id,
 		       const struct rte_eth_rxconf *rx_conf,
 		       struct rte_mempool *mb_pool);
+int rnp_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
+int rnp_tx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 int rnp_tx_queue_setup(struct rte_eth_dev *dev,
 		       uint16_t qidx, uint16_t nb_desc,
 		       unsigned int socket_id,
 		       const struct rte_eth_txconf *tx_conf);
+int rnp_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t qidx);
+int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx);
 
 #endif /* _RNP_RXTX_H_ */
-- 
2.25.1

