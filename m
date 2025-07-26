Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD3C83F17
	for <dpdk-dev@archiver.kernel.org>; Sat, 26 Jul 2025 04:48:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA10440144;
	Sat, 26 Jul 2025 06:48:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D4E03400D5
 for <dev@dpdk.org>; Sat, 26 Jul 2025 06:48:30 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8C44520446;
 Sat, 26 Jul 2025 06:48:30 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 26 Jul 2025 06:48:29 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Vipin Varghese <Vipin.Varghese@amd.com>,
 Thiyagarjan P <Thiyagarajan.P@amd.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] net/null: Add fast mbuf release TX offload
Date: Sat, 26 Jul 2025 04:48:27 +0000
Message-ID: <20250726044827.569456-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624181416.167181-1-mb@smartsharesystems.com>
References: <20250624181416.167181-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Jul 2025 04:48:29.0945 (UTC)
 FILETIME=[885ABE90:01DBFDE8]
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
v2:
* Also announce the offload as a per-queue capability.
* Added missing test of per-device offload configuration when configuring
  the queue.
---
 drivers/net/null/rte_eth_null.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 8a9b74a03b..09cfc74494 100644
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
 
@@ -151,7 +162,16 @@ eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	for (i = 0; i < nb_bufs; i++)
 		bytes += rte_pktmbuf_pkt_len(bufs[i]);
 
-	rte_pktmbuf_free_bulk(bufs, nb_bufs);
+	if (h->mb_pool != NULL) { /* RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
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
 
@@ -259,7 +279,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
 		unsigned int socket_id __rte_unused,
-		const struct rte_eth_txconf *tx_conf __rte_unused)
+		const struct rte_eth_txconf *tx_conf)
 {
 	struct rte_mbuf *dummy_packet;
 	struct pmd_internals *internals;
@@ -284,6 +304,10 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 
 	internals->tx_null_queues[tx_queue_id].internals = internals;
 	internals->tx_null_queues[tx_queue_id].dummy_packet = dummy_packet;
+	internals->tx_null_queues[tx_queue_id].mb_pool =
+			(dev->data->dev_conf.txmode.offloads | tx_conf->offloads) &
+			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 
 	return 0;
 }
@@ -309,7 +333,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+	dev_info->tx_queue_offload_capa = RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+			RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |
+			dev_info->tx_queue_offload_capa;
 
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
-- 
2.43.0

