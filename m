Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9956C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 13:50:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE15640E41;
	Wed, 30 Jul 2025 15:50:53 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B7695402C3
 for <dev@dpdk.org>; Wed, 30 Jul 2025 15:50:52 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 67303209B9;
 Wed, 30 Jul 2025 15:50:52 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 30 Jul 2025 15:50:52 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Vipin Varghese <Vipin.Varghese@amd.com>,
 Thiyagarjan P <Thiyagarajan.P@amd.com>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3] net/null: Add fast mbuf release TX offload
Date: Wed, 30 Jul 2025 13:50:45 +0000
Message-ID: <20250730135045.622551-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624181416.167181-1-mb@smartsharesystems.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jul 2025 13:50:52.0141 (UTC)
 FILETIME=[F6AAC9D0:01DC0158]
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

Added fast mbuf release, re-using the existing mbuf pool pointer
in the queue structure.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v3:
* Use separate tx_pkt_burst callbacks depending on per-device TX offload
  configuration. (Ivan Malov, Konstantin Ananyev)
* Check TX offload configuration for mutually exclusive MBUF_FAST_FREE and
  MULTI_SEGS flags. (Ivan Malov, Konstantin Ananyev)
* Also announce MULTI_SEGS TX offload as a per-queue capability.
v2:
* Also announce the MBUF_FAST_FREE TX offload as a per-queue capability.
* Added missing test of per-device MBUF_FAST_FREE TX offload configuration
  when configuring the queue.
---
 drivers/net/null/rte_eth_null.c | 141 ++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 27 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 8a9b74a03b..3509b0b298 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -34,6 +34,17 @@ struct pmd_internals;
 struct null_queue {
 	struct pmd_internals *internals;
 
+	/**
+	 * For RX queue:
+	 *  Mempool to allocate mbufs from.
+	 *
+	 * For TX queue:
+	 *  Mempool to free mbufs to, if fast release of mbufs is enabled.
+	 *  UINTPTR_MAX if the mempool for fast release of mbufs has not yet been detected.
+	 *  NULL if fast release of mbufs is not enabled.
+	 *
+	 *  @see RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
+	 */
 	struct rte_mempool *mb_pool;
 	void *dummy_packet;
 
@@ -141,8 +152,15 @@ eth_null_no_rx(void *q __rte_unused, struct rte_mbuf **bufs __rte_unused,
 	return 0;
 }
 
+enum eth_tx_free_mode {
+	ETH_TX_FREE_MODE_NO_MBUF_FAST_FREE, /* MBUF_FAST_FREE not possible. */
+	ETH_TX_FREE_MODE_MBUF_FAST_FREE,    /* MBUF_FAST_FREE enabled for the device. */
+	ETH_TX_FREE_MODE_PER_QUEUE,         /* Varies per TX queue. */
+};
+
 static uint16_t
-eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
+eth_null_tx_common(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs,
+		enum eth_tx_free_mode mode)
 {
 	struct null_queue *h = q;
 	unsigned int i;
@@ -151,13 +169,42 @@ eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	for (i = 0; i < nb_bufs; i++)
 		bytes += rte_pktmbuf_pkt_len(bufs[i]);
 
-	rte_pktmbuf_free_bulk(bufs, nb_bufs);
+	if (mode == ETH_TX_FREE_MODE_MBUF_FAST_FREE ||
+			(mode == ETH_TX_FREE_MODE_PER_QUEUE && h->mb_pool != NULL)) {
+		/* RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
+		if (unlikely(h->mb_pool == (void *)UINTPTR_MAX)) {
+			if (unlikely(nb_bufs == 0))
+				return 0; /* Do not dereference uninitialized bufs[0]. */
+			h->mb_pool = bufs[0]->pool;
+		}
+		rte_mbuf_raw_free_bulk(h->mb_pool, bufs, nb_bufs);
+	} else {
+		rte_pktmbuf_free_bulk(bufs, nb_bufs);
+	}
 	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
 	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
 
 	return nb_bufs;
 }
 
+static uint16_t
+eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
+{
+	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_PER_QUEUE);
+}
+
+static uint16_t
+eth_null_tx_no_mbuf_fast_free(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
+{
+	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_NO_MBUF_FAST_FREE);
+}
+
+static uint16_t
+eth_null_tx_mbuf_fast_free(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
+{
+	return eth_null_tx_common(q, bufs, nb_bufs, ETH_TX_FREE_MODE_MBUF_FAST_FREE);
+}
+
 static uint16_t
 eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
@@ -178,9 +225,48 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	return nb_bufs;
 }
 
+static void
+eth_dev_assign_rxtx_ops(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	if (internals->packet_copy) {
+		dev->rx_pkt_burst = eth_null_copy_rx;
+		dev->tx_pkt_burst = eth_null_copy_tx;
+	} else {
+		if (internals->no_rx)
+			dev->rx_pkt_burst = eth_null_no_rx;
+		else
+			dev->rx_pkt_burst = eth_null_rx;
+
+		dev->tx_pkt_burst = eth_null_tx;
+		if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)
+			dev->tx_pkt_burst = eth_null_tx_no_mbuf_fast_free;
+		if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+			dev->tx_pkt_burst = eth_null_tx_mbuf_fast_free;
+	}
+}
+
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	if ((dev->data->dev_conf.txmode.offloads &
+			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) ==
+			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
+		PMD_LOG(ERR,
+			"TX offloads MBUF_FAST_FREE and MULTI_SEGS are mutually exclusive");
+		return -EINVAL;
+	}
+	if (dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE &&
+			internals->packet_copy) {
+		PMD_LOG(INFO,
+			"TX offload MBUF_FAST_FREE is ignored with %s argument",
+			ETH_NULL_PACKET_COPY_ARG);
+	}
+	/* Assign RX/TX ops depending on device TX offloads. */
+	eth_dev_assign_rxtx_ops(dev);
 	return 0;
 }
 
@@ -259,7 +345,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
 		unsigned int socket_id __rte_unused,
-		const struct rte_eth_txconf *tx_conf __rte_unused)
+		const struct rte_eth_txconf *tx_conf)
 {
 	struct rte_mbuf *dummy_packet;
 	struct pmd_internals *internals;
@@ -273,6 +359,20 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 	if (tx_queue_id >= dev->data->nb_tx_queues)
 		return -ENODEV;
 
+	if (((dev->data->dev_conf.txmode.offloads | tx_conf->offloads) &
+			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) ==
+			(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE | RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
+		PMD_LOG(ERR,
+			"TX offloads MBUF_FAST_FREE and MULTI_SEGS are mutually exclusive");
+		return -EINVAL;
+	}
+	if (tx_conf->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE &&
+			internals->packet_copy) {
+		PMD_LOG(INFO,
+			"TX offload MBUF_FAST_FREE is ignored with %s argument",
+			ETH_NULL_PACKET_COPY_ARG);
+	}
+
 	packet_size = internals->packet_size;
 
 	dev->data->tx_queues[tx_queue_id] =
@@ -284,6 +384,10 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 	internals->tx_null_queues[tx_queue_id].internals = internals;
 	internals->tx_null_queues[tx_queue_id].dummy_packet = dummy_packet;
+	internals->tx_null_queues[tx_queue_id].mb_pool =
+			(dev->data->dev_conf.txmode.offloads | tx_conf->offloads) &
+			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 
 	return 0;
 }
@@ -309,7 +413,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |
+			dev_info->tx_queue_offload_capa;
 
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
@@ -590,16 +697,7 @@ eth_dev_null_create(struct rte_vdev_device *dev, struct pmd_options *args)
 	eth_dev->dev_ops = &ops;
 
 	/* finally assign rx and tx ops */
-	if (internals->packet_copy) {
-		eth_dev->rx_pkt_burst = eth_null_copy_rx;
-		eth_dev->tx_pkt_burst = eth_null_copy_tx;
-	} else if (internals->no_rx) {
-		eth_dev->rx_pkt_burst = eth_null_no_rx;
-		eth_dev->tx_pkt_burst = eth_null_tx;
-	} else {
-		eth_dev->rx_pkt_burst = eth_null_rx;
-		eth_dev->tx_pkt_burst = eth_null_tx;
-	}
+	eth_dev_assign_rxtx_ops(eth_dev);
 
 	rte_eth_dev_probing_finish(eth_dev);
 	return 0;
@@ -678,7 +776,6 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 	PMD_LOG(INFO, "Initializing pmd_null for %s", name);
 
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-		struct pmd_internals *internals;
 		eth_dev = rte_eth_dev_attach_secondary(name);
 		if (!eth_dev) {
 			PMD_LOG(ERR, "Failed to probe %s", name);
@@ -687,17 +784,7 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 		/* TODO: request info from primary to set up Rx and Tx */
 		eth_dev->dev_ops = &ops;
 		eth_dev->device = &dev->device;
-		internals = eth_dev->data->dev_private;
-		if (internals->packet_copy) {
-			eth_dev->rx_pkt_burst = eth_null_copy_rx;
-			eth_dev->tx_pkt_burst = eth_null_copy_tx;
-		} else if (internals->no_rx) {
-			eth_dev->rx_pkt_burst = eth_null_no_rx;
-			eth_dev->tx_pkt_burst = eth_null_tx;
-		} else {
-			eth_dev->rx_pkt_burst = eth_null_rx;
-			eth_dev->tx_pkt_burst = eth_null_tx;
-		}
+		eth_dev_assign_rxtx_ops(eth_dev);
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
 	}
-- 
2.43.0

