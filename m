Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5819D4417D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 11:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBEF540A76;
	Fri, 12 Dec 2025 12:11:39 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BB93140664
 for <dev@dpdk.org>; Fri, 12 Dec 2025 12:11:38 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 97F8D20B75;
 Fri, 12 Dec 2025 12:11:38 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 12 Dec 2025 12:11:38 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] net/intel: cache mbuf fast release mempool
Date: Fri, 12 Dec 2025 11:11:36 +0000
Message-ID: <20251212111136.103137-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Dec 2025 11:11:38.0300 (UTC)
 FILETIME=[15E697C0:01DC6B58]
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

When fast release of mbufs is enabled, the mempool to free the mbufs to
was determined by looking at the pool pointer of the first mbuf in the
burst being freed, potentially costing a cache miss.

This patch adds a mbuf fast release mempool pointer to the common transmit
queue structure, so reading the mbufs during fast release is avoided.
The pointer in located a cache line already being accessed,
and is only set once, when the first mbuf ever is released.

The fast release mempool pointer also indicates if fast release is
enabled, so this pointer is checked instead of the
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE flag in the offloads field in the
transmit queue structure.

The same optimizations were applied to mbuf recycle.

For the ice driver, prefetcing the mbufs when fast release of mbufs is
enabled became superflouous, and has been moved into the branch for normal
mbuf release.

For the i40e driver, prefetcing the mbufs when fast release of mbufs is
enabled was already superflouous, and has been moved into the branch for
normal mbuf release.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/intel/common/recycle_mbufs.h | 10 +++++---
 drivers/net/intel/common/tx.h            | 14 +++++++++--
 drivers/net/intel/cpfl/cpfl_rxtx.c       |  2 ++
 drivers/net/intel/i40e/i40e_rxtx.c       | 31 +++++++++++++++---------
 drivers/net/intel/iavf/iavf_rxtx.c       |  2 ++
 drivers/net/intel/ice/ice_rxtx.c         | 15 +++++++++---
 drivers/net/intel/idpf/idpf_rxtx.c       |  2 ++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c     |  2 ++
 8 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/common/recycle_mbufs.h b/drivers/net/intel/common/recycle_mbufs.h
index fbe09eb5d0..564c8320d1 100644
--- a/drivers/net/intel/common/recycle_mbufs.h
+++ b/drivers/net/intel/common/recycle_mbufs.h
@@ -129,10 +129,14 @@ ci_tx_recycle_mbufs(struct ci_tx_queue *txq, ci_desc_done_fn desc_done,
 	rxep += refill_head;
 
 	/* is fast-free enabled in offloads? */
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+	struct rte_mempool *fast_free_mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+			txq->fast_free_mp :
+			(txq->fast_free_mp = txep[0].mbuf->pool);
+
+	if (fast_free_mp != NULL) {
 		/* Avoid txq containing buffers from unexpected mempool. */
-		if (unlikely(recycle_rxq_info->mp
-					!= txep[0].mbuf->pool))
+		if (unlikely(recycle_rxq_info->mp != fast_free_mp))
 			return 0;
 
 		/* Directly put mbufs from Tx to Rx. */
diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 5af64a4cfe..44b6ab76e2 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -61,6 +61,11 @@ struct ci_tx_queue {
 	uint16_t reg_idx;
 	uint16_t tx_next_dd;
 	uint16_t tx_next_rs;
+	/* Mempool pointer for fast release of mbufs.
+	 * NULL if disabled, UINTPTR_MAX if enabled and not yet known.
+	 * Set at first use (if enabled and not yet known).
+	 */
+	struct rte_mempool *fast_free_mp;
 	uint64_t offloads;
 	uint64_t mbuf_errors;
 	rte_iova_t tx_ring_dma;        /* TX ring DMA address */
@@ -154,8 +159,13 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 	struct ci_tx_entry_vec *txep = txq->sw_ring_vec;
 	txep += (txq->tx_next_dd >> ctx_descs) - (n - 1);
 
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
-		struct rte_mempool *mp = txep[0].mbuf->pool;
+	/* is fast-free enabled? */
+	struct rte_mempool *mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+			txq->fast_free_mp :
+			(txq->fast_free_mp = txep[0].mbuf->pool);
+
+	if (mp != NULL && (n & 31) == 0) {
 		void **cache_objs;
 		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
 
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 453ec975d5..8fe6354325 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -565,6 +565,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = cpfl_tx_offload_convert(offloads);
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 255414dd03..5a73e5d1b3 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1337,8 +1337,8 @@ static __rte_always_inline int
 i40e_tx_free_bufs(struct ci_tx_queue *txq)
 {
 	struct ci_tx_entry *txep;
-	uint16_t tx_rs_thresh = txq->tx_rs_thresh;
-	uint16_t i = 0, j = 0;
+	const uint16_t tx_rs_thresh = txq->tx_rs_thresh;
+	uint16_t i, j;
 	struct rte_mbuf *free[I40E_TX_MAX_FREE_BUF_SZ];
 	const uint16_t k = RTE_ALIGN_FLOOR(tx_rs_thresh, I40E_TX_MAX_FREE_BUF_SZ);
 	const uint16_t m = tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
@@ -1350,17 +1350,19 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 
 	txep = &txq->sw_ring[txq->tx_next_dd - (tx_rs_thresh - 1)];
 
-	for (i = 0; i < tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
+	struct rte_mempool *fast_free_mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+			txq->fast_free_mp :
+			(txq->fast_free_mp = txep[0].mbuf->pool);
 
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+	if (fast_free_mp != NULL) {
 		if (k) {
 			for (j = 0; j != k; j += I40E_TX_MAX_FREE_BUF_SZ) {
 				for (i = 0; i < I40E_TX_MAX_FREE_BUF_SZ; ++i, ++txep) {
 					free[i] = txep->mbuf;
 					txep->mbuf = NULL;
 				}
-				rte_mbuf_raw_free_bulk(free[0]->pool, free,
+				rte_mbuf_raw_free_bulk(fast_free_mp, free,
 						I40E_TX_MAX_FREE_BUF_SZ);
 			}
 		}
@@ -1370,21 +1372,24 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
 				free[i] = txep->mbuf;
 				txep->mbuf = NULL;
 			}
-			rte_mbuf_raw_free_bulk(free[0]->pool, free, m);
+			rte_mbuf_raw_free_bulk(fast_free_mp, free, m);
 		}
 	} else {
-		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
+		for (i = 0; i < tx_rs_thresh; i++)
+			rte_prefetch0((txep + i)->mbuf);
+
+		for (i = 0; i < tx_rs_thresh; ++i, ++txep) {
 			rte_pktmbuf_free_seg(txep->mbuf);
 			txep->mbuf = NULL;
 		}
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
@@ -2550,6 +2555,8 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->queue_id = queue_idx;
 	txq->reg_idx = reg_idx;
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = offloads;
 	txq->i40e_vsi = vsi;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index d8662fd815..18ec1d5d78 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -820,6 +820,8 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = queue_idx;
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = offloads;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 	txq->iavf_vsi = vsi;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..e4b4aa2806 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1628,6 +1628,8 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
 
 	txq->reg_idx = vsi->base_queue + queue_idx;
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = offloads;
 	txq->ice_vsi = vsi;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
@@ -3409,15 +3411,20 @@ ice_tx_free_bufs(struct ci_tx_queue *txq)
 
 	txep = &txq->sw_ring[txq->tx_next_dd - (txq->tx_rs_thresh - 1)];
 
-	for (i = 0; i < txq->tx_rs_thresh; i++)
-		rte_prefetch0((txep + i)->mbuf);
+	struct rte_mempool *fast_free_mp =
+			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
+			txq->fast_free_mp :
+			(txq->fast_free_mp = txep[0].mbuf->pool);
 
-	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+	if (fast_free_mp != NULL) {
 		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
-			rte_mempool_put(txep->mbuf->pool, txep->mbuf);
+			rte_mempool_put(fast_free_mp, txep->mbuf);
 			txep->mbuf = NULL;
 		}
 	} else {
+		for (i = 0; i < txq->tx_rs_thresh; i++)
+			rte_prefetch0((txep + i)->mbuf);
+
 		for (i = 0; i < txq->tx_rs_thresh; ++i, ++txep) {
 			rte_pktmbuf_free_seg(txep->mbuf);
 			txep->mbuf = NULL;
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 4796d8b862..b838d7650a 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -440,6 +440,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = idpf_tx_offload_convert(offloads);
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index a7583c178a..824e328230 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2878,6 +2878,8 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	txq->reg_idx = (uint16_t)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
 		queue_idx : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + queue_idx);
 	txq->port_id = dev->data->port_id;
+	txq->fast_free_mp = offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE ?
+			(void *)UINTPTR_MAX : NULL;
 	txq->offloads = offloads;
 	txq->ops = &def_txq_ops;
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
-- 
2.43.0

