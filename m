Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8134BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:35:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0BF64065A;
	Fri,  7 Nov 2025 08:35:11 +0100 (CET)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id 202CC4021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:35:08 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fH1I0NT_1762500905 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 07 Nov 2025 15:35:06 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 2/4] net/nbl: add support for Tx and Rx VLAN offload
Date: Thu,  6 Nov 2025 23:34:57 -0800
Message-Id: <20251107073459.3532524-3-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
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

We simulate support for Tx and Rx VLAN offload,
while in reality we handle Tx VLAN insertion
and Rx VLAN stripping in software.
This implementation is necessary because some of our customers
assume our NICs natively support Tx and Rx VLAN offload capabilities.
They use packet vlan offload during packet transmission and reception
without checking the eth_dev capabilities.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c |  5 ++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c | 47 ++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 1992568088..900b6efd97 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -301,6 +301,7 @@ int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
 	struct nbl_dev_ring_mgt *ring_mgt = &dev_mgt->net_dev->ring_mgt;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
 	struct nbl_board_port_info *board_info = &dev_mgt->common->board_info;
 	u8 speed_mode = board_info->speed;
 
@@ -331,6 +332,10 @@ int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_
 	dev_info->default_txportconf.nb_queues = ring_mgt->tx_ring_num;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
+	if (!common->is_vf) {
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	}
 	switch (speed_mode) {
 	case NBL_FW_PORT_SPEED_100G:
 		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_100G;
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 3c93765a5f..ea77d258ba 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -237,8 +237,11 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
 	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
 	const struct rte_memzone *memzone;
+	uint64_t offloads;
 	u32 size;
 
+	offloads = param->conf->offloads | eth_dev->data->dev_conf.rxmode.offloads;
+
 	if (eth_dev->data->rx_queues[param->queue_idx] != NULL) {
 		NBL_LOG(WARNING, "re-setup an already allocated rx queue");
 		nbl_res_txrx_stop_rx_ring(priv, param->queue_idx);
@@ -284,8 +287,8 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	rx_ring->dma_limit_msb = common->dma_limit_msb;
 	rx_ring->common = common;
 	rx_ring->notify = hw_ops->get_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	rx_ring->offloads = offloads;
 	rx_ring->rx_hash_en = param->rx_hash_en;
-
 	switch (param->product) {
 	case NBL_LEONIS_TYPE:
 		if (param->rx_hash_en)
@@ -441,6 +444,23 @@ static inline void nbl_fill_rx_ring(struct nbl_res_rx_ring *rxq,
 	rxq->next_to_use = desc_index;
 }
 
+static inline void nbl_res_txrx_vlan_insert_out_mbuf(struct rte_mbuf *tx_pkt,
+						     union nbl_tx_extend_head *u,
+						     u16 vlan_proto, u16 vlan_tci)
+{
+	struct rte_vlan_hdr *vlan_hdr;
+	struct rte_ether_hdr *ether_hdr;
+
+	ether_hdr = (struct rte_ether_hdr *)((u8 *)u + sizeof(struct nbl_tx_ehdr_leonis));
+	rte_memcpy(ether_hdr, rte_pktmbuf_mtod(tx_pkt, u8 *), sizeof(struct rte_ether_hdr));
+
+	vlan_hdr = (struct rte_vlan_hdr *)(ether_hdr + 1);
+	vlan_hdr->vlan_tci = rte_cpu_to_be_16(vlan_tci);
+	vlan_hdr->eth_proto = ether_hdr->ether_type;
+
+	ether_hdr->ether_type = rte_cpu_to_be_16(vlan_proto);
+}
+
 static u16
 nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u16 extend_set)
 {
@@ -481,6 +501,12 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 
 		tx_pkt = *tx_pkts++;
 
+		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			required_headroom += sizeof(struct rte_vlan_hdr);
+			/* extend_hdr + ether_hdr + vlan_hdr */
+			tx_extend_len = required_headroom + sizeof(struct rte_ether_hdr);
+		}
+
 		if (rte_pktmbuf_headroom(tx_pkt) >= required_headroom) {
 			can_push = 1;
 			u = rte_pktmbuf_mtod_offset(tx_pkt, union nbl_tx_extend_head *,
@@ -489,6 +515,21 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 			can_push = 0;
 			u = (union nbl_tx_extend_head *)(&tx_region[desc_index]);
 		}
+
+		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			if (likely(can_push)) {
+				if (rte_vlan_insert(&tx_pkt)) {
+					can_push = 0;
+					u = (union nbl_tx_extend_head *)(&tx_region[desc_index]);
+				}
+			}
+			if (unlikely(!can_push)) {
+				addr_offset += sizeof(struct rte_ether_hdr);
+				nbl_res_txrx_vlan_insert_out_mbuf(tx_pkt, u, RTE_ETHER_TYPE_VLAN,
+								  tx_pkt->vlan_tci);
+			}
+		}
+
 		nb_descs = !can_push + tx_pkt->nb_segs;
 
 		if (nb_descs > txq->vq_free_cnt) {
@@ -642,6 +683,10 @@ nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
 
 		if (--num_sg)
 			continue;
+
+		if (rxq->eth_dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rte_vlan_strip(rx_mbuf);
+
 		if (drop) {
 			rxq->rxq_stats.rx_drop_proto++;
 			rte_pktmbuf_free(rx_mbuf);
-- 
2.34.1

