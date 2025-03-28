Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E775C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D9740A7A;
	Fri, 28 Mar 2025 06:15:39 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 72BFD40671
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:37 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138930texho0
X-QQ-Originating-IP: T7GUuiE2kGsnjo6qoxZoR8mZl40+AOVdGwLL1p7Calw=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6806604935434844139
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 18/29] net/rnp: add Tx multiple segment version
Date: Fri, 28 Mar 2025 05:14:33 +0000
Message-Id: <20250328051444.1019208-19-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OHxEzDHh9Tir/jk+fMzESHbGy02w3N36sixwGOacIQOFF2aPKJEyOVdL
 vvN5RuqjyR6haYQdfAW92bVS+zD9BDH+RF4hvkNAMkzNVWCk1/SrQHPHk4/sMkhQlBMg11C
 IVNhM9HgX1Vjt7SvCdK+ROzNwHh5XG76U7g+ybYw+1pq2//KCZjAy/oBFQlKSIBjFAFwPs+
 kreoN57A2BUvr9Jjckum7KPvk6uEJq6IYPvLeewvFpQN/4AimAUAgYYgbj+x3Yt+FNUPoIA
 Dr7PTLXXNky5+xpVs5OTYvts3N1TOn/+VX5km+I1pEfTiMSVtWICzIm76YsFMbnYwCo8r5n
 Ffr64IssgHyCMLsbNGTfzllTygvtS9s4LC8CDp/yWXUc+itB+IsVIU2RWKnLnhpNeGeiC2Y
 W6GpUo0sNtm02MzMywUN7W68TrbeUbH0w4hE1iW3c70njs4sKe851L3gjEv0qCBfRXO9XZV
 7uWm678Ly4bX0p18PFuxMX8HfvqseybGIHaQImpTaL2vG3gE9Lms+Gt9sc5JkNdvGzA7ZfC
 5W4Ln4eHWDJDThk0FT9MJHSYqgAzaMGX3ALd/Cegu+UtHGJHnkF7S0rTUueYCO/WCOlIQz7
 PX4vfxOpNg+pCX20+di+TWKTj/Ci+hIguMIu45DYeSWC5DOs2fbvMwH4HbEMoqfsz2Gn3dZ
 F32xCX4qZdMdznjHvP/2tspS84cmxe5dHfgY/5FpD5s5bMV7j1LI0V+UgxKWn/iyAGDOjXX
 0h4cH1L+3dRD6yYVUuLCfjrSgtfqjLV8hMdOEpMJ8Aa/1Jko0LWblKVoHVgL8K5mWxakQIu
 KxwCV8Ki+D7nnHs/p8zfcUOcD9aFXwh8mQ6x3FxJ4F78Hd7XaEqRpYkgLOqpstPAwNGzYJM
 RhzHOVncU3QPvENm2UHT5AMNVORbS5pmftcFxFOUxUyofi0NORQvVhaiDn1kpeGLxqaG9+r
 bgmNsaAgOvbFpzRQu0f4madxwoTOUmIWLE2qCpXEEosLz3KuXJ3Om4+cvjd/ZXfiG11vj8Q
 zZ6G+kyCA211JQ6XxC2UPEDQ4/qy6bw9L5LW/lTzAGAx76yNW2nMfZxjP/LIYivaI2x64XG
 4h09AhYB2K8
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

add support multiple segs mbuf send.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |   2 +
 drivers/net/rnp/rnp_rxtx.c   | 126 ++++++++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h   |   3 +-
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 48e4431945..a664c76847 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -608,6 +608,8 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
 	/* rx support offload cap */
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
+	/* tx support offload cap */
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	/* default ring configure */
 	dev_info->default_rxportconf.burst_size = 32;
 	dev_info->default_txportconf.burst_size = 32;
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index b2ca9b15fc..3d8fc50012 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -369,9 +369,11 @@ rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq)
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
@@ -857,6 +859,7 @@ rnp_rxq_bulk_alloc(struct rnp_rx_queue *rxq,
 		rxe->mbuf = nmb;
 		rxbd->d.pkt_addr = rnp_get_dma_addr(&rxq->attr, nmb);
 	}
+	rxq->rxrearm_nb++;
 	if (rxq->rxrearm_nb > rxq->rx_free_thresh) {
 		rxq->rxrearm_nb -= rxq->rx_free_thresh;
 		rxq->rxrearm_start += rxq->rx_free_thresh;
@@ -924,7 +927,6 @@ rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
 			first_seg->nb_segs++;
 			last_seg->next = rxm;
 		}
-		rxq->rxrearm_nb++;
 		if (!(rx_status & rte_cpu_to_le_16(RNP_CMD_EOP))) {
 			last_seg = rxm;
 			continue;
@@ -945,6 +947,106 @@ rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
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
+			txbd->d.cmd = 0;
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
@@ -968,9 +1070,29 @@ int rnp_rx_func_select(struct rte_eth_dev *dev)
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
index 973b667cb2..f63128555b 100644
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
2.25.1

