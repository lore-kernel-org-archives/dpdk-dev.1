Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69DC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:46:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC6EF406B4;
	Sat,  8 Feb 2025 03:45:05 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 2B8C840684
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:44:57 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id C2A8AA3246; Sat,  8 Feb 2025 10:44:21 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v7 18/28] net/rnp: add Tx multiple segment version
Date: Sat,  8 Feb 2025 10:43:55 +0800
Message-Id: <1738982645-34550-19-git-send-email-caowenbo@mucse.com>
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

add support multiple segs mbuf send.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_rxtx.c | 126 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h |   3 +-
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index c80cc8b..777ce7b 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -374,9 +374,11 @@ static int rnp_alloc_txbdr(struct rte_eth_dev *dev,
 		sw_ring[prev].next_id = idx;
 		prev = idx;
 	}
+	txq->last_desc_cleaned = txq->attr.nb_desc - 1;
 	txq->nb_tx_free = txq->attr.nb_desc - 1;
 	txq->tx_next_dd = txq->tx_rs_thresh - 1;
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+	txq->nb_tx_used = 0;
 	txq->tx_tail = 0;
 
 	size = (txq->attr.nb_desc + RNP_TX_MAX_BURST_SIZE);
@@ -860,6 +862,7 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 		rxe->mbuf = nmb;
 		rxbd->d.pkt_addr = rnp_get_dma_addr(&rxq->attr, nmb);
 	}
+	rxq->rxrearm_nb++;
 	if (rxq->rxrearm_nb > rxq->rx_free_thresh) {
 		rxq->rxrearm_nb -= rxq->rx_free_thresh;
 		rxq->rxrearm_start += rxq->rx_free_thresh;
@@ -927,7 +930,6 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 			first_seg->nb_segs++;
 			last_seg->next = rxm;
 		}
-		rxq->rxrearm_nb++;
 		if (!(rx_status & rte_cpu_to_le_16(RNP_CMD_EOP))) {
 			last_seg = rxm;
 			continue;
@@ -950,6 +952,106 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 	return nb_rx;
 }
 
+static __rte_always_inline uint16_t
+rnp_multiseg_clean_txq(struct rnp_tx_queue *txq)
+{
+	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
+	struct rnp_txsw_entry *sw_ring = txq->sw_ring;
+	volatile struct rnp_tx_desc *txbd;
+	uint16_t desc_to_clean_to;
+	uint16_t nb_tx_to_clean;
+
+	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
+	desc_to_clean_to = desc_to_clean_to & (txq->attr.nb_desc - 1);
+
+	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
+	txbd = &txq->tx_bdr[desc_to_clean_to];
+	if (!(txbd->d.cmd & RNP_CMD_DD))
+		return txq->nb_tx_free;
+
+	if (last_desc_cleaned > desc_to_clean_to)
+		nb_tx_to_clean = (uint16_t)((txq->attr.nb_desc -
+					last_desc_cleaned) + desc_to_clean_to);
+	else
+		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
+				last_desc_cleaned);
+
+	txbd->d.cmd = 0;
+
+	txq->last_desc_cleaned = desc_to_clean_to;
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
+
+	return txq->nb_tx_free;
+}
+
+static __rte_always_inline uint16_t
+rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct rnp_tx_queue *txq = (struct rnp_tx_queue *)_txq;
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *txe, *txn;
+	struct rte_mbuf *tx_pkt, *m_seg;
+	uint16_t send_pkts = 0;
+	uint16_t nb_used_bd;
+	uint16_t tx_last;
+	uint16_t nb_tx;
+	uint16_t tx_id;
+
+	if (unlikely(!txq->txq_started || !txq->tx_link))
+		return 0;
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		rnp_multiseg_clean_txq(txq);
+	if (unlikely(txq->nb_tx_free == 0))
+		return 0;
+	tx_id = txq->tx_tail;
+	txbd = &txq->tx_bdr[tx_id];
+	txe = &txq->sw_ring[tx_id];
+	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
+		tx_pkt = tx_pkts[nb_tx];
+		nb_used_bd = tx_pkt->nb_segs;
+		tx_last = (uint16_t)(tx_id + nb_used_bd - 1);
+		if (tx_last >= txq->attr.nb_desc)
+			tx_last = (uint16_t)(tx_last - txq->attr.nb_desc);
+		if (nb_used_bd > txq->nb_tx_free)
+			if (nb_used_bd > rnp_multiseg_clean_txq(txq))
+				break;
+		m_seg = tx_pkt;
+		do {
+			txbd = &txq->tx_bdr[tx_id];
+			txn = &txq->sw_ring[txe->next_id];
+			if (txe->mbuf) {
+				rte_pktmbuf_free_seg(txe->mbuf);
+				txe->mbuf = NULL;
+			}
+			txe->mbuf = m_seg;
+			txe->last_id = tx_last;
+			txbd->d.addr = rnp_get_dma_addr(&txq->attr, m_seg);
+			txbd->d.blen = rte_cpu_to_le_32(m_seg->data_len);
+			txbd->d.cmd &= ~RNP_CMD_EOP;
+			txbd->d.cmd |= RNP_DATA_DESC;
+			m_seg = m_seg->next;
+			tx_id = txe->next_id;
+			txe = txn;
+		} while (m_seg != NULL);
+		txbd->d.cmd |= RNP_CMD_EOP;
+		txq->nb_tx_used = (uint16_t)txq->nb_tx_used + nb_used_bd;
+		txq->nb_tx_free = (uint16_t)txq->nb_tx_free - nb_used_bd;
+		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
+			txq->nb_tx_used = 0;
+			txbd->d.cmd |= RNP_CMD_RS;
+		}
+		send_pkts++;
+	}
+	if (!send_pkts)
+		return 0;
+	txq->tx_tail = tx_id;
+
+	rte_wmb();
+	RNP_REG_WR(txq->tx_tailreg, 0, tx_id);
+
+	return send_pkts;
+}
+
 static int
 rnp_check_rx_simple_valid(struct rte_eth_dev *dev)
 {
@@ -973,9 +1075,29 @@ int rnp_rx_func_select(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+rnp_check_tx_simple_valid(struct rte_eth_dev *dev, struct rnp_tx_queue *txq)
+{
+	RTE_SET_USED(txq);
+	if (dev->data->scattered_rx)
+		return -ENOTSUP;
+	return 0;
+}
+
 int rnp_tx_func_select(struct rte_eth_dev *dev)
 {
-	dev->tx_pkt_burst = rnp_xmit_simple;
+	bool simple_allowed = false;
+	struct rnp_tx_queue *txq;
+	int idx = 0;
+
+	for (idx = 0; idx < dev->data->nb_tx_queues; idx++) {
+		txq = dev->data->tx_queues[idx];
+		simple_allowed = rnp_check_tx_simple_valid(dev, txq) == 0;
+	}
+	if (simple_allowed)
+		dev->tx_pkt_burst = rnp_xmit_simple;
+	else
+		dev->tx_pkt_burst = rnp_multiseg_xmit_pkts;
 	dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
 
 	return 0;
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 973b667..f631285 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -98,7 +98,8 @@ struct rnp_tx_queue {
 	struct rnp_queue_attr attr;
 
 	uint16_t nb_tx_free; /* avail desc to set pkts */
-	uint16_t nb_tx_used;
+	uint16_t nb_tx_used; /* multiseg mbuf used num */
+	uint16_t last_desc_cleaned;
 	uint16_t tx_tail;
 
 	uint16_t tx_next_dd; /* next to scan writeback dd bit */
-- 
1.8.3.1

