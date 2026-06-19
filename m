Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CACD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 18:45:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCB940B8C;
	Fri, 19 Jun 2026 20:44:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id DE8EF40279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C082F200029;
 Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87F34200004;
 Fri, 19 Jun 2026 20:44:30 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B6E36180004C;
 Sat, 20 Jun 2026 02:44:29 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 06/10] net/enetc: support scatter-gather
Date: Sat, 20 Jun 2026 00:14:23 +0530
Message-Id: <20260619184427.522518-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Add scatter-gather support for ENETC4 PMD:
- Add ENETC_RXBD_LSTATUS_R/F bits for RX BD status
- Add ENETC4_MAX_SEGS (63) for max segments per TX packet
- Update enetc4_vf_dev_infos_get to fill nb_seg_max, offloads,
  max queues and packet length
- Extend enetc_xmit_pkts_nc to handle multi-segment mbufs
- Extend enetc_clean_rx_ring_nc to chain scatter-gather segments
  using LSTATUS_R/F bits

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/enetc/base/enetc_hw.h |   2 +
 drivers/net/enetc/enetc.h         |   4 +-
 drivers/net/enetc/enetc4_vf.c     |  46 ++++++++---
 drivers/net/enetc/enetc_rxtx.c    | 124 +++++++++++++++++++-----------
 4 files changed, 119 insertions(+), 57 deletions(-)

diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index f79c950..6e96562 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -230,6 +230,8 @@ enum enetc_bdr_type {TX, RX};
 			(0x0005 | ENETC_PKT_TYPE_IPV4)
 #define ENETC_PKT_TYPE_IPV6_ESP \
 			(0x0005 | ENETC_PKT_TYPE_IPV6)
+#define ENETC_RXBD_LSTATUS_R	BIT(30)
+#define ENETC_RXBD_LSTATUS_F	BIT(31)
 
 /* PCI device info */
 struct enetc_hw {
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 4d99b5b..439d2d6 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2019,2024 NXP
+ * Copyright 2018-2019,2024-2026 NXP
  */
 
 #ifndef _ENETC_H_
@@ -28,6 +28,8 @@
 #define MIN_BD_COUNT   32
 /* BD ALIGN */
 #define BD_ALIGN       8
+/* Max segments per ENETC4 TX packet (scatter-gather) */
+#define ENETC4_MAX_SEGS	63
 
 /* minimum frame size supported */
 #define ENETC_MAC_MINFRM_SIZE	68
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index bec7128..9dc4e1d 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2024 NXP
+ * Copyright 2024-2026 NXP
  */
 
 #include <stdbool.h>
@@ -18,8 +18,19 @@ uint16_t enetc_crc_table[ENETC_CRC_TABLE_SIZE];
 bool enetc_crc_gen;
 
 /* Supported Rx offloads */
-static uint64_t dev_vf_rx_offloads_sup =
-	RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+static uint64_t dev_rx_offloads_sup =
+	RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_RX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+	RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+	RTE_ETH_RX_OFFLOAD_SCATTER;
+
+/* Supported Tx offloads */
+static uint64_t dev_tx_offloads_sup =
+	RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+	RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+	RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 static void
 enetc_gen_crc_table(void)
@@ -61,21 +72,38 @@ static int
 enetc4_vf_dev_infos_get(struct rte_eth_dev *dev,
 			struct rte_eth_dev_info *dev_info)
 {
-	int ret = 0;
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
 	PMD_INIT_FUNC_TRACE();
 
-	ret = enetc4_dev_infos_get(dev, dev_info);
-	if (ret)
-		return ret;
-
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+		.nb_seg_max = ENETC4_MAX_SEGS,
+		.nb_mtu_seg_max = ENETC4_MAX_SEGS,
+	};
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+		.nb_seg_max = ENETC4_MAX_SEGS,
+		.nb_mtu_seg_max = ENETC4_MAX_SEGS,
+	};
+	dev_info->max_rx_queues = hw->max_rx_queues;
+	dev_info->max_tx_queues = hw->max_tx_queues;
+	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
 	dev_info->max_mtu = dev_info->max_rx_pktlen - (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN);
 	dev_info->max_mac_addrs = ENETC4_MAC_ENTRIES;
-	dev_info->rx_offload_capa |= dev_vf_rx_offloads_sup;
+	dev_info->rx_offload_capa = dev_rx_offloads_sup;
+	dev_info->tx_offload_capa = dev_tx_offloads_sup;
+	dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL;
 
 	return 0;
 }
 
+
 int
 enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
 {
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index c87349f..a37c835 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -149,54 +149,64 @@ enetc_xmit_pkts_nc(void *tx_queue,
 		struct rte_mbuf **tx_pkts,
 		uint16_t nb_pkts)
 {
-	struct enetc_swbd *tx_swbd;
-	int i, start, bds_to_use;
-	struct enetc_tx_bd *txbd;
 	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
-	unsigned int buflen, j;
+	int i, start, bds_to_use, bd_count;
+	struct enetc_tx_bd *txbd;
+	struct rte_mbuf *seg;
+	uint16_t seg_len, segs_per_pkt;
+	bool is_first_seg;
+	unsigned int j;
 	uint8_t *data;
 
 	i = tx_ring->next_to_use;
-
 	bds_to_use = enetc_bd_unused(tx_ring);
-	if (bds_to_use < nb_pkts)
-		nb_pkts = bds_to_use;
-
+	bd_count = tx_ring->bd_count;
 	start = 0;
-	while (nb_pkts--) {
-		tx_ring->q_swbd[i].buffer_addr = tx_pkts[start];
 
-		buflen = rte_pktmbuf_pkt_len(tx_ring->q_swbd[i].buffer_addr);
-		data = rte_pktmbuf_mtod(tx_ring->q_swbd[i].buffer_addr, void *);
-		for (j = 0; j <= buflen; j += RTE_CACHE_LINE_SIZE)
-			dcbf(data + j);
+	while (start < nb_pkts) {
+		seg = tx_pkts[start];
+		segs_per_pkt = seg->nb_segs;
 
-		txbd = ENETC_TXBD(*tx_ring, i);
-		txbd->flags = 0;
-		if (tx_ring->q_swbd[i].buffer_addr->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
-			enetc4_tx_offload_checksum(tx_ring->q_swbd[i].buffer_addr, txbd);
+		if (bds_to_use < segs_per_pkt)
+			break;
 
-		tx_swbd = &tx_ring->q_swbd[i];
-		txbd->frm_len = buflen;
-		txbd->buf_len = txbd->frm_len;
-		txbd->addr = (uint64_t)(uintptr_t)
-		rte_cpu_to_le_64((size_t)tx_swbd->buffer_addr->buf_iova +
-				 tx_swbd->buffer_addr->data_off);
+		is_first_seg = true;
+		while (seg) {
+			tx_ring->q_swbd[i].buffer_addr = NULL;
+			seg_len = rte_pktmbuf_data_len(seg);
+			data = rte_pktmbuf_mtod(seg, void *);
+
+			/* Flush payload to PoC so HW DMA reads the correct data. */
+			for (j = 0; j < seg_len; j += RTE_CACHE_LINE_SIZE)
+				dcbf(data + j);
+			/* Cover the last byte of an unaligned buffer. */
+			dcbf(data + (seg_len - 1));
+
+			txbd = ENETC_TXBD(*tx_ring, i);
+			txbd->flags = 0;
+			if (is_first_seg) {
+				tx_ring->q_swbd[i].buffer_addr = tx_pkts[start];
+				txbd->frm_len = rte_pktmbuf_pkt_len(seg);
+				if (seg->ol_flags & ENETC4_TX_CKSUM_OFFLOAD_MASK)
+					enetc4_tx_offload_checksum(seg, txbd);
+				is_first_seg = false;
+			}
+
+			txbd->buf_len = rte_cpu_to_le_16(seg_len);
+			txbd->addr = rte_cpu_to_le_64(rte_mbuf_data_iova(seg));
+			seg = seg->next;
+			i++;
+			bds_to_use--;
+			if (unlikely(i == bd_count))
+				i = 0;
+		}
+
+		/* Set the frame-last flag on the final BD of this packet. */
 		txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);
-		i++;
 		start++;
-		if (unlikely(i == tx_ring->bd_count))
-			i = 0;
 	}
 
-	/* we're only cleaning up the Tx ring here, on the assumption that
-	 * software is slower than hardware and hardware completed sending
-	 * older frames out by now.
-	 * We're also cleaning up the ring before kicking off Tx for the new
-	 * batch to minimize chances of contention on the Tx ring
-	 */
 	enetc_clean_tx_ring(tx_ring);
-
 	tx_ring->next_to_use = i;
 	enetc_wr_reg(tx_ring->tcir, i);
 	return start;
@@ -501,38 +511,59 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd, rxbd_temp;
+	struct rte_mbuf *first_seg = NULL, *cur_seg = NULL;
 	uint32_t bd_status;
 	uint8_t *data;
 	uint32_t j;
+	struct rte_mbuf *seg;
+	uint16_t data_len;
 
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
-	/* next descriptor to process */
 	rxbd = ENETC_RXBD(*rx_ring, i);
-
 	cleaned_cnt = enetc_bd_unused(rx_ring);
 	rx_swbd = &rx_ring->q_swbd[i];
 
 	while (likely(rx_frm_cnt < work_limit)) {
 		rxbd_temp = *rxbd;
 		bd_status = rte_le_to_cpu_32(rxbd_temp.r.lstatus);
-		if (!bd_status)
+		/* LSTATUS_R indicates this BD has been written by HW */
+		if (!(bd_status & ENETC_RXBD_LSTATUS_R))
 			break;
 		if (rxbd_temp.r.error)
 			rx_ring->ierrors++;
 
-		rx_swbd->buffer_addr->pkt_len = rxbd_temp.r.buf_len -
-						rx_ring->crc_len;
-		rx_swbd->buffer_addr->data_len = rx_swbd->buffer_addr->pkt_len;
-		rx_swbd->buffer_addr->hash.rss = rxbd_temp.r.rss_hash;
-		enetc_dev_rx_parse(rx_swbd->buffer_addr,
-				   rxbd_temp.r.parse_summary);
+		seg = rx_swbd->buffer_addr;
+		data_len = rte_le_to_cpu_16(rxbd_temp.r.buf_len);
+		seg->data_len = data_len;
+
+		if (!first_seg) {
+			first_seg = seg;
+			cur_seg = seg;
+			first_seg->pkt_len = data_len;
+			enetc_dev_rx_parse(first_seg, rxbd_temp.r.parse_summary);
+			first_seg->hash.rss = rxbd_temp.r.rss_hash;
+		} else {
+			first_seg->pkt_len += data_len;
+			first_seg->nb_segs++;
+			cur_seg->next = seg;
+			cur_seg = seg;
+		}
 
-		data = rte_pktmbuf_mtod(rx_swbd->buffer_addr, void *);
-		for (j = 0; j <= rx_swbd->buffer_addr->pkt_len; j += RTE_CACHE_LINE_SIZE)
+		/* Invalidate packet data cache lines so CPU reads HW-written data. */
+		data = rte_pktmbuf_mtod(seg, void *);
+		for (j = 0; j < data_len; j += RTE_CACHE_LINE_SIZE)
 			dccivac(data + j);
+		dccivac(data + (data_len - 1));
+
+		if (bd_status & ENETC_RXBD_LSTATUS_F) {
+			seg->next = NULL;
+			first_seg->pkt_len -= rx_ring->crc_len;
+			rx_pkts[rx_frm_cnt] = first_seg;
+			rx_frm_cnt++;
+			first_seg = NULL;
+		}
 
-		rx_pkts[rx_frm_cnt] = rx_swbd->buffer_addr;
 		cleaned_cnt++;
 		rx_swbd++;
 		i++;
@@ -541,7 +572,6 @@ enetc_clean_rx_ring_nc(struct enetc_bdr *rx_ring,
 			rx_swbd = &rx_ring->q_swbd[i];
 		}
 		rxbd = ENETC_RXBD(*rx_ring, i);
-		rx_frm_cnt++;
 	}
 
 	rx_ring->next_to_clean = i;
-- 
2.25.1

