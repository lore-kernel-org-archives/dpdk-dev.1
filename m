Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C44CCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13DAE40661;
	Thu,  9 Oct 2025 13:16:41 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id E36B84027A
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC6381A3D22;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9176E1A3F18;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B260A1800089;
 Thu,  9 Oct 2025 19:16:35 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v1 03/12] net/enetc: Optimize ENETC4 data path
Date: Thu,  9 Oct 2025 16:46:24 +0530
Message-Id: <20251009111633.3585957-4-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Improves ENETC4 data path on i.MX95 Non-cache coherent platform by:

- Adding separate RX and TX functions.
- Reducing memory accesses

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/base/enetc4_hw.h |   2 +
 drivers/net/enetc/enetc.h          |   5 +
 drivers/net/enetc/enetc4_ethdev.c  |   4 +-
 drivers/net/enetc/enetc_rxtx.c     | 147 ++++++++++++++++++++++++-----
 4 files changed, 132 insertions(+), 26 deletions(-)

diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 34a4ca3b02..759cfaba28 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -14,6 +14,8 @@
 #define ENETC4_DEV_ID_VF	0xef00
 #define PCI_VENDOR_ID_NXP	0x1131
 
+#define ENETC4_TXBD_FLAGS_F		BIT(7)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_PMR		0x10
 #define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index df831ce8d0..99a2d22b22 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -67,6 +67,7 @@ struct enetc_bdr {
 	};
 	struct rte_mempool *mb_pool;   /* mbuf pool to populate RX ring. */
 	struct rte_eth_dev *ndev;
+	uint64_t ierrors;
 };
 
 /*
@@ -121,8 +122,12 @@ int enetc4_vf_dev_stop(struct rte_eth_dev *dev);
  */
 uint16_t enetc_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts);
+uint16_t enetc_xmit_pkts_nc(void *txq, struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts);
 uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
+uint16_t enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts);
 
 int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
 void enetc4_dev_hw_init(struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 6f67eda24e..6970626220 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -606,8 +606,8 @@ enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 
-	eth_dev->rx_pkt_burst = &enetc_recv_pkts;
-	eth_dev->tx_pkt_burst = &enetc_xmit_pkts;
+	eth_dev->rx_pkt_burst = &enetc_recv_pkts_nc;
+	eth_dev->tx_pkt_burst = &enetc_xmit_pkts_nc;
 
 	/* Retrieving and storing the HW base address of device */
 	hw->hw.reg = (void *)pci_dev->mem_resource[0].addr;
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index 1fc5f11339..9922915cf5 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -86,12 +86,6 @@ enetc_xmit_pkts(void *tx_queue,
 	int i, start, bds_to_use;
 	struct enetc_tx_bd *txbd;
 	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
-	unsigned short buflen;
-	uint8_t *data;
-	int j;
-
-	struct enetc_eth_hw *hw =
-			ENETC_DEV_PRIVATE_TO_HW(tx_ring->ndev->data->dev_private);
 
 	i = tx_ring->next_to_use;
 
@@ -103,12 +97,6 @@ enetc_xmit_pkts(void *tx_queue,
 	while (nb_pkts--) {
 		tx_ring->q_swbd[i].buffer_addr = tx_pkts[start];
 
-		if (hw->device_id == ENETC4_DEV_ID || hw->device_id == ENETC4_DEV_ID_VF) {
-			buflen = rte_pktmbuf_pkt_len(tx_ring->q_swbd[i].buffer_addr);
-			data = rte_pktmbuf_mtod(tx_ring->q_swbd[i].buffer_addr, void *);
-			for (j = 0; j <= buflen; j += RTE_CACHE_LINE_SIZE)
-				dcbf(data + j);
-		}
 		txbd = ENETC_TXBD(*tx_ring, i);
 		tx_swbd = &tx_ring->q_swbd[i];
 		txbd->frm_len = tx_pkts[start]->pkt_len;
@@ -136,6 +124,61 @@ enetc_xmit_pkts(void *tx_queue,
 	return start;
 }
 
+uint16_t
+enetc_xmit_pkts_nc(void *tx_queue,
+		struct rte_mbuf **tx_pkts,
+		uint16_t nb_pkts)
+{
+	struct enetc_swbd *tx_swbd;
+	int i, start, bds_to_use;
+	struct enetc_tx_bd *txbd;
+	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
+	unsigned int buflen, j;
+	uint8_t *data;
+
+	i = tx_ring->next_to_use;
+
+	bds_to_use = enetc_bd_unused(tx_ring);
+	if (bds_to_use < nb_pkts)
+		nb_pkts = bds_to_use;
+
+	start = 0;
+	while (nb_pkts--) {
+		tx_ring->q_swbd[i].buffer_addr = tx_pkts[start];
+
+		buflen = rte_pktmbuf_pkt_len(tx_ring->q_swbd[i].buffer_addr);
+		data = rte_pktmbuf_mtod(tx_ring->q_swbd[i].buffer_addr, void *);
+		for (j = 0; j <= buflen; j += RTE_CACHE_LINE_SIZE)
+			dcbf(data + j);
+
+		txbd = ENETC_TXBD(*tx_ring, i);
+		txbd->flags = rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
+
+		tx_swbd = &tx_ring->q_swbd[i];
+		txbd->frm_len = buflen;
+		txbd->buf_len = txbd->frm_len;
+		txbd->addr = (uint64_t)(uintptr_t)
+		rte_cpu_to_le_64((size_t)tx_swbd->buffer_addr->buf_iova +
+				 tx_swbd->buffer_addr->data_off);
+		i++;
+		start++;
+		if (unlikely(i == tx_ring->bd_count))
+			i = 0;
+	}
+
+	/* we're only cleaning up the Tx ring here, on the assumption that
+	 * software is slower than hardware and hardware completed sending
+	 * older frames out by now.
+	 * We're also cleaning up the ring before kicking off Tx for the new
+	 * batch to minimize chances of contention on the Tx ring
+	 */
+	enetc_clean_tx_ring(tx_ring);
+
+	tx_ring->next_to_use = i;
+	enetc_wr_reg(tx_ring->tcir, i);
+	return start;
+}
+
 int
 enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 {
@@ -171,7 +214,7 @@ enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
 		k++;
 		if (unlikely(i == rx_ring->bd_count)) {
 			i = 0;
-			rxbd = ENETC_RXBD(*rx_ring, 0);
+			rxbd = ENETC_RXBD(*rx_ring, i);
 			rx_swbd = &rx_ring->q_swbd[i];
 		}
 	}
@@ -341,11 +384,6 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd;
 	uint32_t bd_status;
-	uint8_t *data;
-	uint32_t j;
-	struct enetc_eth_hw *hw =
-			ENETC_DEV_PRIVATE_TO_HW(rx_ring->ndev->data->dev_private);
-
 
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
@@ -386,12 +424,6 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		enetc_dev_rx_parse(rx_swbd->buffer_addr,
 				   rxbd->r.parse_summary);
 
-		if (hw->device_id == ENETC4_DEV_ID || hw->device_id == ENETC4_DEV_ID_VF) {
-			data = rte_pktmbuf_mtod(rx_swbd->buffer_addr, void *);
-			for (j = 0; j <= rx_swbd->buffer_addr->pkt_len; j += RTE_CACHE_LINE_SIZE)
-				dccivac(data + j);
-		}
-
 		rx_pkts[rx_frm_cnt] = rx_swbd->buffer_addr;
 		cleaned_cnt++;
 		rx_swbd++;
@@ -417,6 +449,73 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	return rx_frm_cnt;
 }
 
+static int
+enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
+		    struct rte_mbuf **rx_pkts,
+		    int work_limit)
+{
+	int rx_frm_cnt = 0;
+	int cleaned_cnt, i;
+	struct enetc_swbd *rx_swbd;
+	union enetc_rx_bd *rxbd, rxbd_temp;
+	uint32_t bd_status;
+	uint8_t *data;
+	uint32_t j;
+
+	/* next descriptor to process */
+	i = rx_ring->next_to_clean;
+	/* next descriptor to process */
+	rxbd = ENETC_RXBD(*rx_ring, i);
+
+	cleaned_cnt = enetc_bd_unused(rx_ring);
+	rx_swbd = &rx_ring->q_swbd[i];
+
+	while (likely(rx_frm_cnt < work_limit)) {
+		rxbd_temp = *rxbd;
+		bd_status = rte_le_to_cpu_32(rxbd_temp.r.lstatus);
+		if (!bd_status)
+			break;
+		if (rxbd_temp.r.error)
+			rx_ring->ierrors++;
+
+		rx_swbd->buffer_addr->pkt_len = rxbd_temp.r.buf_len -
+						rx_ring->crc_len;
+		rx_swbd->buffer_addr->data_len = rx_swbd->buffer_addr->pkt_len;
+		rx_swbd->buffer_addr->hash.rss = rxbd_temp.r.rss_hash;
+		enetc_dev_rx_parse(rx_swbd->buffer_addr,
+				   rxbd_temp.r.parse_summary);
+
+		data = rte_pktmbuf_mtod(rx_swbd->buffer_addr, void *);
+		for (j = 0; j <= rx_swbd->buffer_addr->pkt_len; j += RTE_CACHE_LINE_SIZE)
+			dccivac(data + j);
+
+		rx_pkts[rx_frm_cnt] = rx_swbd->buffer_addr;
+		cleaned_cnt++;
+		rx_swbd++;
+		i++;
+		if (unlikely(i == rx_ring->bd_count)) {
+			i = 0;
+			rx_swbd = &rx_ring->q_swbd[i];
+		}
+		rxbd = ENETC_RXBD(*rx_ring, i);
+		rx_frm_cnt++;
+	}
+
+	rx_ring->next_to_clean = i;
+	enetc_refill_rx_ring(rx_ring, cleaned_cnt);
+
+	return rx_frm_cnt;
+}
+
+uint16_t
+enetc_recv_pkts_nc(void *rxq, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts)
+{
+	struct enetc_bdr *rx_ring = (struct enetc_bdr *)rxq;
+
+	return enetc_clean_rx_ring_nc(rx_ring, rx_pkts, nb_pkts);
+}
+
 uint16_t
 enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
-- 
2.25.1

