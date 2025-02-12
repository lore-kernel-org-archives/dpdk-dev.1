Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155CCC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:39:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C1F42DBD;
	Wed, 12 Feb 2025 15:37:23 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 6E09B427E5
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:37:08 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id B4242DFB991; Wed, 12 Feb 2025 22:36:51 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v11 15/28] net/rnp: add Tx burst simple support
Date: Wed, 12 Feb 2025 22:36:12 +0800
Message-Id: <1739370987-3989-16-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
References: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
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

add only support simple send pkts.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |  6 +++
 drivers/net/rnp/rnp_rxtx.c   | 85 +++++++++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h   |  1 +
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 55098158bb..915704204d 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -588,6 +588,12 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	};
 
 	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.tx_thresh = {
+			.pthresh = RNP_TX_DESC_FETCH_TH,
+			.hthresh = RNP_TX_DESC_FETCH_BURST,
+		},
+		.tx_free_thresh = RNP_DEFAULT_TX_FREE_THRESH,
+		.tx_rs_thresh = RNP_DEFAULT_TX_RS_THRESH,
 		.offloads = 0,
 	};
 
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index df9462fbcf..af416b900e 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -751,6 +751,89 @@ rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	return nb_rx;
 }
 
+static  __rte_always_inline int
+rnp_clean_tx_ring(struct rnp_tx_queue *txq)
+{
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *tx_swbd;
+	struct rte_mbuf *m;
+	uint16_t next_dd;
+	uint16_t i;
+
+	txbd = &txq->tx_bdr[txq->tx_next_dd];
+	if (!(txbd->d.cmd & RNP_CMD_DD))
+		return 0;
+	*txbd = txq->zero_desc;
+	next_dd = txq->tx_next_dd - (txq->tx_free_thresh - 1);
+	tx_swbd = &txq->sw_ring[next_dd];
+
+	for (i = 0; i < txq->tx_rs_thresh; ++i, ++tx_swbd) {
+		if (tx_swbd->mbuf) {
+			m = tx_swbd->mbuf;
+			rte_pktmbuf_free_seg(m);
+			tx_swbd->mbuf = NULL;
+		}
+	}
+	txq->nb_tx_free = (txq->nb_tx_free + txq->tx_rs_thresh);
+	txq->tx_next_dd = (txq->tx_next_dd + txq->tx_rs_thresh) &
+		txq->attr.nb_desc_mask;
+
+	return 0;
+}
+
+static __rte_always_inline uint16_t
+rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct rnp_tx_queue *txq = (struct rnp_tx_queue *)_txq;
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *tx_swbd;
+	uint64_t phy;
+	uint16_t start;
+	uint16_t i;
+
+	if (unlikely(!txq->txq_started || !txq->tx_link))
+		return 0;
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		rnp_clean_tx_ring(txq);
+
+	nb_pkts = RTE_MIN(txq->nb_tx_free, nb_pkts);
+	if (!nb_pkts)
+		return 0;
+	start = nb_pkts;
+	i = txq->tx_tail;
+
+	while (nb_pkts--) {
+		txbd = &txq->tx_bdr[i];
+		tx_swbd = &txq->sw_ring[i];
+		tx_swbd->mbuf = *tx_pkts++;
+		phy = rnp_get_dma_addr(&txq->attr, tx_swbd->mbuf);
+		txbd->d.addr = phy;
+		if (unlikely(tx_swbd->mbuf->data_len > RNP_MAC_MAXFRM_SIZE))
+			tx_swbd->mbuf->data_len = 0;
+		txbd->d.blen = tx_swbd->mbuf->data_len;
+		txbd->d.cmd = RNP_CMD_EOP;
+
+		i = (i + 1) & txq->attr.nb_desc_mask;
+	}
+	txq->nb_tx_free -= start;
+	if (txq->tx_tail + start > txq->tx_next_rs) {
+		txbd = &txq->tx_bdr[txq->tx_next_rs];
+		txbd->d.cmd |= RNP_CMD_RS;
+		txq->tx_next_rs = (txq->tx_next_rs + txq->tx_rs_thresh);
+
+		if (txq->tx_next_rs > txq->attr.nb_desc)
+			txq->tx_next_rs = txq->tx_rs_thresh - 1;
+	}
+
+	txq->tx_tail = i;
+
+	rte_wmb();
+	RNP_REG_WR(txq->tx_tailreg, 0, i);
+
+	return start;
+}
+
 int rnp_rx_func_select(struct rte_eth_dev *dev)
 {
 	dev->rx_pkt_burst = rnp_recv_pkts;
@@ -760,7 +843,7 @@ int rnp_rx_func_select(struct rte_eth_dev *dev)
 
 int rnp_tx_func_select(struct rte_eth_dev *dev)
 {
-	dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+	dev->tx_pkt_burst = rnp_xmit_simple;
 	dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
 
 	return 0;
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 39e5184502..a8fd8d052f 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -89,6 +89,7 @@ struct rnp_tx_queue {
 	const struct rte_memzone *rz;
 	uint64_t ring_phys_addr; /* tx dma ring physical addr */
 	volatile struct rnp_tx_desc *tx_bdr; /* tx dma ring virtual addr */
+	volatile struct rnp_tx_desc zero_desc;
 	struct rnp_txsw_entry *sw_ring; /* tx software ring addr */
 	volatile void *tx_tailreg; /* hw desc tail register */
 	volatile void *tx_headreg; /* hw desc head register*/
-- 
2.34.1

