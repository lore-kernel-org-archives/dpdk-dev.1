Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD357C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01A9640698;
	Fri, 28 Mar 2025 06:15:19 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id A83FE40698
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:16 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138910tcdam8
X-QQ-Originating-IP: Ia8qrPh6fhnhIXqHlaIGjFI3PB7gTQkJHaSgs7uY22s=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3948882957288985514
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 09/29] net/rnp: add queue stop and start operations
Date: Fri, 28 Mar 2025 05:14:24 +0000
Message-Id: <20250328051444.1019208-10-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: Noy+ibaQGaj1tX0QMz/zYPAY0mz3EhMvBl7f4kOMt2pJRRge5R/EG80L
 1OD9s88pJ+RuRKgXyOaPKUFVF1errm2agF/XzuOv1lmL3YkA8tA/s6vynTUH40AXhHoCfwZ
 X4tFFsWoMiawe19PXIPiyEuN2tHUHMaJeOdYA66xEemY7mFgc+QOVrIIfjR2DiK2ODbJSkB
 nmEbW3m1S4BRtsUA+P6JIdH/07Am9kvId4enzQHkmYyg/KefoHiPUTqhXrLoWmm8414JosO
 7QRKUi9674qlhiJ7ruAzp/abcGDlkQq8PayNrNKtjhYdQ+5P0U4oWBc3a2rF+l+gB1p9Naq
 trqyiTlZRoAwsjJuRIuivYuuVVBkZzjQMnmr+1kT1ImDlfhKz8eT3DnJr/FBxEw6w5DG2R/
 BHZGdzLJxfo88E2GDp2I3BOPagfXKgXQ+hHlYiRT5TZhhc/uMwnbonEBd+8SXTff8h4reRy
 QxNs8HYrhSVE5gMrEDweHKQMFYileAqrbEnZ7zyHuWIPf+5p9YEJbTnx+/nDHbETUePzwFY
 qZxcHiv+Ob8h2beV6YxR/9sGtRr4VlPff8g0GzrmHTRasZK2OIGeSDGZvr51mw54Uk32bpL
 21v3a7q2Jlk2x9L9qjRDB9kiQmDz5COxLR2Ba1s0n80dCqqcRfISTtPrCI4oEBetRm/7kOU
 ergG/P2niaCDzmszYoQgQ2OibPxNdl+5vuLVaZDBX/W2TY6ICrlqrH67ueSyyZz8vFAkJVr
 znl1TLZoHVuiDrX471YAw/93V424axT7QvVr3zecezIWZWQaCKfusTlofKZh9UEABiW7XNV
 cHZYuOYOovIQTgwVYfpQjq24dolzheNY2dOSabxsJfZvxrV5my2At7fUW/kqgAZ517r/SGt
 URI8+2S3sXt8VqBEM8Gq55BO7tnpeYfCuiTiLjtLIg+WJ9kxPWdcVGoqbxMJy11riZSeyC7
 TEmebjmwkq1RedwHy3Yu3m1ImfOmsEP7xdSC59372mWaq0ewaYQYHU5V7RtgqtZWFjj1Sbq
 t7YahrSTA2tg9nXLVIY0lFY87bb4Ii631VAwB70cUnMaXhI7Ud5OROLi3hyxpzJ2QphyKvR
 h9GeJu8+dxQqi30XV2nAZgRJveXl4a+ZFqeY4t/OAqL
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rnp.ini  |   1 +
 doc/guides/nics/rnp.rst           |   4 +
 drivers/net/rnp/base/rnp_common.c |   3 +
 drivers/net/rnp/rnp_ethdev.c      |   4 +
 drivers/net/rnp/rnp_rxtx.c        | 167 ++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h        |   9 ++
 6 files changed, 188 insertions(+)

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
index 6ab2474c42..7b3462c64b 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -64,6 +64,10 @@ Listed below are the rte_eth functions supported:
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
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index f207a7e865..8c8691ce7f 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -249,8 +249,12 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 
 	.rx_queue_setup               = rnp_rx_queue_setup,
 	.rx_queue_release             = rnp_dev_rx_queue_release,
+	.rx_queue_stop                = rnp_rx_queue_stop,
+	.rx_queue_start               = rnp_rx_queue_start,
 	.tx_queue_setup               = rnp_tx_queue_setup,
 	.tx_queue_release             = rnp_dev_tx_queue_release,
+	.tx_queue_stop                = rnp_tx_queue_stop,
+	.tx_queue_start               = rnp_tx_queue_start,
 };
 
 static void
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

