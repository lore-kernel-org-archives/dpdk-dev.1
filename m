Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274D606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC1024067A;
	Thu, 26 Nov 2026 08:34:49 +0100 (CET)
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com
 [115.124.28.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 265D240431
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:44 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712912|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00337673-7.7258e-05-0.996546;
 FP=13922662857672297677|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037034254; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1Yuz_1795678480; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Yuz_1795678480 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:41 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 08/11] net/nbl: support draco Tx and Rx burst
Date: Thu, 26 Nov 2026 15:34:25 +0800
Message-ID: <20261126073430.3168813-9-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable draco device configuration and reuse the common Tx and Rx
burst paths with the draco extended header lengths.

Keep single-segment and multi-segment packet handling in the
existing unified burst functions.

Restrict software VLAN insertion and stripping to leonis and
leave draco VLAN offload capabilities disabled until hardware
VLAN support is implemented.

Use a common queue doorbell format with the producer index and
wrap bit for leonis and draco. Notify hardware after initial Rx
buffer posting and replenishment. Leonis ignores these extra bits.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c |  6 +-----
 drivers/net/nbl/nbl_hw/nbl_txrx.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 8d2195f..062f95c 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -20,10 +20,6 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 	if (dev_data == NULL || adapter == NULL)
 		return -EINVAL;
 
-	/* Keep the draco datapath disabled until its extended headers are supported. */
-	if (adapter->caps.product_type == NBL_DRACO_TYPE)
-		return -ENOTSUP;
-
 	NBL_LOG(DEBUG, "Begin to configure the device, state: %d", adapter->state);
 
 	dev_data->dev_conf.intr_conf.lsc = 0;
@@ -470,7 +466,7 @@ int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_
 	dev_info->default_txportconf.nb_queues = ring_mgt->tx_ring_num;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
-	if (!common->is_vf) {
+	if (adapter->caps.product_type == NBL_LEONIS_TYPE && !common->is_vf) {
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	}
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 8a1669e..7ba8758 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -6,6 +6,12 @@
 #include "nbl_include.h"
 #include "nbl_txrx_ops.h"
 
+static inline u32 nbl_res_txrx_notify_value(u16 qid, u16 next_to_use, u16 flags)
+{
+	return qid | ((u32)next_to_use << 16) |
+		((u32)!!(flags & NBL_PACKED_DESC_F_AVAIL_BIT) << 31);
+}
+
 static int nbl_res_txrx_alloc_rings(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
@@ -467,11 +473,13 @@ static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
 	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
 	struct nbl_res_rx_ring *rx_ring = NBL_RES_MGT_TO_RX_RING(res_mgt, index);
+	u16 tail_ptr;
+
+	tail_ptr = rx_ring->next_to_use |
+		   ((u16)!!(rx_ring->avail_used_flags & NBL_PACKED_DESC_F_AVAIL_BIT) << 15);
 
 	hw_ops->update_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
-				 rx_ring->notify_qid,
-				 ((!!(rx_ring->avail_used_flags & NBL_PACKED_DESC_F_AVAIL_BIT)) |
-				 rx_ring->next_to_use));
+				 rx_ring->notify_qid, tail_ptr);
 }
 
 static inline void nbl_fill_rx_ring(struct nbl_res_rx_ring *rxq,
@@ -509,6 +517,9 @@ static inline void nbl_fill_rx_ring(struct nbl_res_rx_ring *rxq,
 		rx_desc->flags = flags;
 	}
 
+	rte_write32(nbl_res_txrx_notify_value(rxq->notify_qid, desc_index,
+					    rxq->avail_used_flags), rxq->notify);
+
 	rxq->vq_free_cnt -= fill_num;
 	rxq->next_to_use = desc_index;
 }
@@ -551,6 +562,7 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 	u16 required_headroom;
 	u16 tx_extend_len;
 	u16 addr_offset;
+	u32 notify_val;
 
 	txq = tx_queue;
 	tx_ring = txq->desc;
@@ -570,7 +582,8 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 
 		tx_pkt = *tx_pkts++;
 
-		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN) {
+		if (txq->product == NBL_LEONIS_TYPE &&
+		    (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN)) {
 			required_headroom += sizeof(struct rte_vlan_hdr);
 			/* extend_hdr + ether_hdr + vlan_hdr */
 			tx_extend_len = required_headroom + sizeof(struct rte_ether_hdr);
@@ -589,7 +602,8 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 				       (size_t)desc_index * txq->exthdr_len);
 		}
 
-		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN) {
+		if (txq->product == NBL_LEONIS_TYPE &&
+		    (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN)) {
 			if (likely(can_push)) {
 				if (rte_vlan_insert(&tx_pkt)) {
 					can_push = 0;
@@ -680,7 +694,9 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 
 exit:
 	/* kick hw_notify_addr */
-	rte_write32(txq->notify_qid, txq->notify);
+	notify_val = nbl_res_txrx_notify_value(txq->notify_qid, txq->next_to_use,
+					      txq->avail_used_flags);
+	rte_write32(notify_val, txq->notify);
 	txq->txq_stats.tx_packets += nb_xmit_pkts;
 	return nb_xmit_pkts;
 }
@@ -757,7 +773,8 @@ nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
 		if (--num_sg)
 			continue;
 
-		if (rxq->eth_dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+		if (rxq->product == NBL_LEONIS_TYPE &&
+		    (rxq->eth_dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP))
 			rte_vlan_strip(rx_mbuf);
 
 		if (drop) {
-- 
2.53.0

