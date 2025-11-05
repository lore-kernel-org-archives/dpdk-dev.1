Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D42CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 08:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48E9440665;
	Wed,  5 Nov 2025 09:20:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 360BD40668;
 Wed,  5 Nov 2025 09:20:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1D4A62079A;
 Wed,  5 Nov 2025 09:20:02 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 5 Nov 2025 09:20:00 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: techboard@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] Revert "net/null: add fast mbuf release Tx offload"
Date: Wed,  5 Nov 2025 08:19:52 +0000
Message-ID: <20251105081953.20153-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Nov 2025 08:20:00.0241 (UTC)
 FILETIME=[FA7EBE10:01DC4E2C]
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

This reverts commit 675ddc233d68d90b3858cdb6267dd407c4e85984.

The Tech Board has decided that the co-existence of fast mbuf release and
multi segments is unclear, and new restrictions should not be imposed
until this has been clarified.

Fixes: 675ddc233d68 ("net/null: add fast mbuf release Tx offload")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/null/rte_eth_null.c | 143 +++++++-------------------------
 1 file changed, 28 insertions(+), 115 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 14bc65c8ad..46e7e7bd8c 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -34,17 +34,6 @@ struct pmd_internals;
 struct null_queue {
 	struct pmd_internals *internals;
 
-	/**
-	 * For RX queue:
-	 *  Mempool to allocate mbufs from.
-	 *
-	 * For TX queue:
-	 *  Mempool to free mbufs to, if fast release of mbufs is enabled.
-	 *  UINTPTR_MAX if the mempool for fast release of mbufs has not yet been detected.
-	 *  NULL if fast release of mbufs is not enabled.
-	 *
-	 *  @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
-	 */
 	struct rte_mempool *mb_pool;
 	void *dummy_packet;
 
@@ -152,15 +141,8 @@ eth_null_no_rx(void *q __rte_unused, struct rte_mbuf **bufs __rte_unused,
 	return 0;
 }
 
-enum eth_tx_free_mode {
-	ETH_TX_FREE_MODE_NO_MBUF_FAST_FREE, /* MBUF_FAST_FREE not possible. */
-	ETH_TX_FREE_MODE_MBUF_FAST_FREE,    /* MBUF_FAST_FREE enabled for the device. */
-	ETH_TX_FREE_MODE_PER_QUEUE,         /* Varies per TX queue. */
-};
-
-static __rte_always_inline uint16_t
-eth_null_tx_common(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs,
-		enum eth_tx_free_mode mode)
+static uint16_t
+eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
 	struct null_queue *h = q;
 	unsigned int i;
@@ -169,42 +151,13 @@ eth_null_tx_common(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs,
 	for (i = 0; i < nb_bufs; i++)
 		bytes += rte_pktmbuf_pkt_len(bufs[i]);
 
-	if (mode == ETH_TX_FREE_MODE_MBUF_FAST_FREE ||
-			(mode == ETH_TX_FREE_MODE_PER_QUEUE && h->mb_pool != NULL)) {
-		/* RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
-		if (unlikely(h->mb_pool == (void *)UINTPTR_MAX)) {
-			if (unlikely(nb_bufs == 0))
-				return 0; /* Do not dereference uninitialized bufs[0]. */
-			h->mb_pool = bufs[0]->pool;
-		}
-		rte_mbuf_raw_free_bulk(h->mb_pool, bufs, nb_bufs);
-	} else {
-		rte_pktmbuf_free_bulk(bufs, nb_bufs);
-	}
+	rte_pktmbuf_free_bulk(bufs, nb_bufs);
 	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
 	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
 
 	return nb_bufs;
 }
 
-static uint16_t
-eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
-{
-	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_PER_QUEUE);
-}
-
-static uint16_t
-eth_null_tx_no_mbuf_fast_free(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
-{
-	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_NO_MBUF_FAST_FREE);
-}
-
-static uint16_t
-eth_null_tx_mbuf_fast_free(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
-{
-	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_MBUF_FAST_FREE);
-}
-
 static uint16_t
 eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
@@ -225,48 +178,9 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	return nb_bufs;
 }
 
-static void
-eth_dev_assign_rxtx_ops(struct rte_eth_dev *dev)
-{
-	struct pmd_internals *internals = dev->data->dev_private;
-
-	if (internals->packet_copy) {
-		dev->rx_pkt_burst = eth_null_copy_rx;
-		dev->tx_pkt_burst = eth_null_copy_tx;
-	} else {
-		if (internals->no_rx)
-			dev->rx_pkt_burst = eth_null_no_rx;
-		else
-			dev->rx_pkt_burst = eth_null_rx;
-
-		dev->tx_pkt_burst = eth_null_tx;
-		if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)
-			dev->tx_pkt_burst = eth_null_tx_no_mbuf_fast_free;
-		if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
-			dev->tx_pkt_burst = eth_null_tx_mbuf_fast_free;
-	}
-}
-
 static int
-eth_dev_configure(struct rte_eth_dev *dev)
+eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
 {
-	struct pmd_internals *internals = dev->data->dev_private;
-
-	if ((dev->data->dev_conf.txmode.offloads &
-			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) ==
-			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
-		PMD_LOG(ERR,
-			"TX offloads MBUF_FAST_FREE and MULTI_SEGS are mutually exclusive");
-		return -EINVAL;
-	}
-	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE &&
-			internals->packet_copy) {
-		PMD_LOG(INFO,
-			"TX offload MBUF_FAST_FREE is ignored with %s argument",
-			ETH_NULL_PACKET_COPY_ARG);
-	}
-	/* Assign RX/TX ops depending on device TX offloads. */
-	eth_dev_assign_rxtx_ops(dev);
 	return 0;
 }
 
@@ -345,7 +259,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
 		unsigned int socket_id __rte_unused,
-		const struct rte_eth_txconf *tx_conf)
+		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct rte_mbuf *dummy_packet;
 	struct pmd_internals *internals;
@@ -359,20 +273,6 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -ENODEV;
 
-	if (((dev->data->dev_conf.txmode.offloads | tx_conf->offloads) &
-			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) ==
-			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
-		PMD_LOG(ERR,
-			"TX offloads MBUF_FAST_FREE and MULTI_SEGS are mutually exclusive");
-		return -EINVAL;
-	}
-	if (tx_conf->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE &&
-			internals->packet_copy) {
-		PMD_LOG(INFO,
-			"TX offload MBUF_FAST_FREE is ignored with %s argument",
-			ETH_NULL_PACKET_COPY_ARG);
-	}
-
 	packet_size = internals->packet_size;
 
 	dev->data->tx_queues[tx_queue_id] =
@@ -384,10 +284,6 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 	internals->tx_null_queues[tx_queue_id].internals = internals;
 	internals->tx_null_queues[tx_queue_id].dummy_packet = dummy_packet;
-	internals->tx_null_queues[tx_queue_id].mb_pool =
-			(dev->data->dev_conf.txmode.offloads | tx_conf->offloads) &
-			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
-			(void *)UINTPTR_MAX : NULL;
 
 	return 0;
 }
@@ -413,10 +309,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
-			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |
-			dev_info->tx_queue_offload_capa;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
@@ -698,7 +591,16 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	eth_dev->dev_ops = &ops;
 
 	/* finally assign rx and tx ops */
-	eth_dev_assign_rxtx_ops(eth_dev);
+	if (internals->packet_copy) {
+		eth_dev->rx_pkt_burst = eth_null_copy_rx;
+		eth_dev->tx_pkt_burst = eth_null_copy_tx;
+	} else if (internals->no_rx) {
+		eth_dev->rx_pkt_burst = eth_null_no_rx;
+		eth_dev->tx_pkt_burst = eth_null_tx;
+	} else {
+		eth_dev->rx_pkt_burst = eth_null_rx;
+		eth_dev->tx_pkt_burst = eth_null_tx;
+	}
 
 	rte_eth_dev_probing_finish(eth_dev);
 	return 0;
@@ -777,6 +679,7 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 	PMD_LOG(INFO, "Initializing pmd_null for %s", name);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct pmd_internals *internals;
 		eth_dev = rte_eth_dev_attach_secondary(name);
 		if (!eth_dev) {
 			PMD_LOG(ERR, "Failed to probe %s", name);
@@ -785,7 +688,17 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 		/* TODO: request info from primary to set up Rx and Tx */
 		eth_dev->dev_ops = &ops;
 		eth_dev->device = &dev->device;
-		eth_dev_assign_rxtx_ops(eth_dev);
+		internals = eth_dev->data->dev_private;
+		if (internals->packet_copy) {
+			eth_dev->rx_pkt_burst = eth_null_copy_rx;
+			eth_dev->tx_pkt_burst = eth_null_copy_tx;
+		} else if (internals->no_rx) {
+			eth_dev->rx_pkt_burst = eth_null_no_rx;
+			eth_dev->tx_pkt_burst = eth_null_tx;
+		} else {
+			eth_dev->rx_pkt_burst = eth_null_rx;
+			eth_dev->tx_pkt_burst = eth_null_tx;
+		}
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
 	}
-- 
2.43.0

