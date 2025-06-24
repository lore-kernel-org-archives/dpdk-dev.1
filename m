Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F43C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 06:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDC5C40287;
	Tue, 24 Jun 2025 08:12:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D07A740264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 08:12:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A9FE720849;
 Tue, 24 Jun 2025 08:12:47 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 24 Jun 2025 08:12:45 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] net/i40e: Fast release optimizations
Date: Tue, 24 Jun 2025 06:12:38 +0000
Message-ID: <20250624061238.89259-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jun 2025 06:12:45.0864 (UTC)
 FILETIME=[00B2C280:01DBE4CF]
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

When fast releasing mbufs, the mbufs are not accessed, so do not prefetch
them.
This saves a mbuf load operation for each fast released TX mbuf.

When fast release of mbufs is enabled for a TX queue, cache the mbuf
mempool pointer in the TX queue structure.
This saves one mbuf load operation for each burst of fast released TX
mbufs.

The txep->mbuf pointer is not used after the mbuf has been freed, so do
not reset the pointer.
This saves a txep store operation for each TX mbuf freed.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/intel/common/tx.h                 |  5 +++
 .../i40e/i40e_recycle_mbufs_vec_common.c      |  4 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 39 ++++++++++---------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index b0a68bae44..54c9b845f7 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -62,6 +62,11 @@ struct ci_tx_queue {
 	uint16_t tx_next_dd;
 	uint16_t tx_next_rs;
 	uint64_t offloads;
+	/* Mempool pointer for fast release of mbufs.
+	 * NULL if disabled, UINTPTR_MAX if enabled and not yet known.
+	 * Initialized at first use.
+	 */
+	struct rte_mempool *fast_free_mp;
 	uint64_t mbuf_errors;
 	rte_iova_t tx_ring_dma;        /* TX ring DMA address */
 	bool tx_deferred_start; /* don't start this queue in dev start */
diff --git a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
index 2875c578af..a46605cee9 100644
--- a/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
+++ b/drivers/net/intel/i40e/i40e_recycle_mbufs_vec_common.c
@@ -106,7 +106,9 @@ i40e_recycle_tx_mbufs_reuse_vec(void *tx_queue,
 	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
 		/* Avoid txq contains buffers from unexpected mempool. */
 		if (unlikely(recycle_rxq_info->mp
-					!= txep[0].mbuf->pool))
+				!= (likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+				txq->fast_free_mp :
+				(txq->fast_free_mp = txep[0].mbuf->pool))))
 			return 0;
 
 		/* Directly put mbufs from Tx to Rx. */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c3ff2e05c3..679c1340b8 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1332,7 +1332,7 @@ static __rte_always_inline int
 i40e_tx_free_bufs(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *txep;
-	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
+	const uint16_t tx_rs_thresh = txq->tx_rs_thresh;
 	uint16_t i = 0, j = 0;
 	struct rte_mbuf *free[RTE_I40E_TX_MAX_FREE_BUF_SZ];
 	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, RTE_I40E_TX_MAX_FREE_BUF_SZ);
@@ -1345,41 +1345,40 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 
 	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
 
-	for (i = 0; i < tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
-
 	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		struct rte_mempool * const fast_free_mp =
+				likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+				txq->fast_free_mp :
+				(txq->fast_free_mp = txep[0].mbuf->pool);
+
 		if (k) {
 			for (j = 0; j != k; j += RTE_I40E_TX_MAX_FREE_BUF_SZ) {
-				for (i = 0; i < RTE_I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
+				for (i = 0; i < RTE_I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep)
 					free[i] = txep->mbuf;
-					txep->mbuf = NULL;
-				}
-				rte_mempool_put_bulk(free[0]->pool, (void **)free,
+				rte_mempool_put_bulk(fast_free_mp, (void **)free,
 						RTE_I40E_TX_MAX_FREE_BUF_SZ);
 			}
 		}
 
 		if (m) {
-			for (i = 0; i < m; ++i, ++txep) {
+			for (i = 0; i < m; ++i, ++txep)
 				free[i] = txep->mbuf;
-				txep->mbuf = NULL;
-			}
-			rte_mempool_put_bulk(free[0]->pool, (void **)free, m);
+			rte_mempool_put_bulk(fast_free_mp, (void **)free, m);
 		}
 	} else {
-		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
+		for (i = 0; i < tx_rs_thresh; i++)
+			rte_prefetch0((txep + i)->mbuf);
+
+		for (i = 0; i < tx_rs_thresh; ++i, ++txep)
 			rte_pktmbuf_free_seg(txep->mbuf);
-			txep->mbuf = NULL;
-		}
 	}
 
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + tx_rs_thresh);
+	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + tx_rs_thresh);
 	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
+		txq->tx_next_dd = (uint16_t)(tx_rs_thresh - 1);
 
-	return txq->tx_rs_thresh;
+	return tx_rs_thresh;
 }
 
 /* Populate 4 descriptors with data from 4 mbufs */
@@ -2546,6 +2545,8 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->reg_idx = reg_idx;
 	txq->port_id = dev->data->port_id;
 	txq->offloads = offloads;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->i40e_vsi = vsi;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-- 
2.43.0

