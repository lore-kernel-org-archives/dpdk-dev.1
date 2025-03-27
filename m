Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189BC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 10:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6D8640B91;
	Thu, 27 Mar 2025 11:43:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3E32F40A80
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743072231; x=1774608231;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=75jibIYm605vGkozZBouqUHALH4Q82ITyuHX+XzI9zg=;
 b=N/EMH3i2EbV5gNXHLGEZ2xNVEo8hj2T7BtizCGbsM8HeCJbBJEpL3KCo
 9hCfEnYx+Pm8mj9CdQgn5fRwoCXAzxHS4bwfMUosP40Il2SOdAB2xFHYT
 mFJh0CB+5r9DoyPYVe3DFNZMl7yO7sJlRh3J3kluCNJR21JoHtXJ1WiqV
 d7m7rwc65z/a6W7yu7xhkvKtApJD21o+zHAMaMmmRqcn97gC8ec1ivZd5
 TOEStQhWQtsQnfQ6NRzRNO7Ti/rlSHViSPKQCsfAB3f1+iXlqF8shs+P8
 8i4GO2UrIDzfh/M+j2p5lWmQ6sUOA6lFv3Y4UifIrDxr9XevkJytzLUqX w==;
X-CSE-ConnectionGUID: bZGtIF86TjW9EKFh7EOaNA==
X-CSE-MsgGUID: 0i5ejxHpQvaRN/F5qq9qNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44520210"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44520210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:43:51 -0700
X-CSE-ConnectionGUID: n6CcLjdXSJ2/BrGmdtuuKg==
X-CSE-MsgGUID: f6CVk7g2SPCiuCxAnIBgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130195186"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2025 03:43:49 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v4 4/4] net/idpf: use common Tx free fn in idpf
Date: Thu, 27 Mar 2025 16:15:02 +0530
Message-Id: <20250327104502.2107300-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327104502.2107300-1-shaiq.wani@intel.com>
References: <20250324124908.1282692-2-shaiq.wani@intel.com>
 <20250327104502.2107300-1-shaiq.wani@intel.com>
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

Switch the idpf driver to use the common Tx free function for
AVX2 and AVX512.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  10 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 237 +-----------------
 2 files changed, 22 insertions(+), 225 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index bce0257804..fff31fedec 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -79,6 +79,14 @@ idpf_singleq_rx_rearm(struct idpf_rx_queue *rxq)
 	IDPF_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
 }
 
+static inline int
+idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+		return (txq->idpf_tx_ring[idx].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+}
+
 static inline uint16_t
 _idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 				     uint16_t nb_pkts)
@@ -621,7 +629,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		idpf_singleq_tx_free_bufs_vec(txq);
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
 
 	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index c0ec754642..dbbdc71e22 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -122,6 +122,14 @@ idpf_singleq_rearm_common(struct idpf_rx_queue *rxq)
 	IDPF_PCI_REG_WRITE(rxq->qrx_tail, rx_id);
 }
 
+static inline int
+idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+		return (txq->idpf_tx_ring[idx].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+}
+
 static __rte_always_inline void
 idpf_singleq_rearm(struct idpf_rx_queue *rxq)
 {
@@ -996,122 +1004,6 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 						 nb_pkts);
 }
 
-static __rte_always_inline int
-idpf_tx_singleq_free_bufs_avx512(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry_vec *txep;
-	uint32_t n;
-	uint32_t i;
-	int nb_free = 0;
-	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
-
-	/* check DD bits on threshold descriptor */
-	if ((txq->idpf_tx_ring[txq->tx_next_dd].qw1 &
-			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=
-			rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE))
-		return 0;
-
-	n = txq->tx_rs_thresh;
-
-	 /* first buffer to free from S/W ring is at index
-	  * tx_next_dd - (tx_rs_thresh-1)
-	  */
-	txep = (void *)txq->sw_ring;
-	txep += txq->tx_next_dd - (n - 1);
-
-	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
-		struct rte_mempool *mp = txep[0].mbuf->pool;
-		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp,
-								rte_lcore_id());
-		void **cache_objs;
-
-		if (cache == NULL || cache->len == 0)
-			goto normal;
-
-		cache_objs = &cache->objs[cache->len];
-
-		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
-			goto done;
-		}
-
-		/* The cache follows the following algorithm
-		 *   1. Add the objects to the cache
-		 *   2. Anything greater than the cache min value (if it crosses the
-		 *   cache flush threshold) is flushed to the ring.
-		 */
-		/* Add elements back into the cache */
-		uint32_t copied = 0;
-		/* n is multiple of 32 */
-		while (copied < n) {
-#ifdef RTE_ARCH_64
-			const __m512i a = _mm512_loadu_si512(&txep[copied]);
-			const __m512i b = _mm512_loadu_si512(&txep[copied + 8]);
-			const __m512i c = _mm512_loadu_si512(&txep[copied + 16]);
-			const __m512i d = _mm512_loadu_si512(&txep[copied + 24]);
-
-			_mm512_storeu_si512(&cache_objs[copied], a);
-			_mm512_storeu_si512(&cache_objs[copied + 8], b);
-			_mm512_storeu_si512(&cache_objs[copied + 16], c);
-			_mm512_storeu_si512(&cache_objs[copied + 24], d);
-#else
-			const __m512i a = _mm512_loadu_si512(&txep[copied]);
-			const __m512i b = _mm512_loadu_si512(&txep[copied + 16]);
-			_mm512_storeu_si512(&cache_objs[copied], a);
-			_mm512_storeu_si512(&cache_objs[copied + 16], b);
-#endif
-			copied += 32;
-		}
-		cache->len += n;
-
-		if (cache->len >= cache->flushthresh) {
-			rte_mempool_ops_enqueue_bulk(mp,
-						     &cache->objs[cache->size],
-						     cache->len - cache->size);
-			cache->len = cache->size;
-		}
-		goto done;
-	}
-
-normal:
-	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
-	if (likely(m != NULL)) {
-		free[0] = m;
-		nb_free = 1;
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (likely(m != NULL)) {
-				if (likely(m->pool == free[0]->pool)) {
-					free[nb_free++] = m;
-				} else {
-					rte_mempool_put_bulk(free[0]->pool,
-							     (void *)free,
-							     nb_free);
-					free[0] = m;
-					nb_free = 1;
-				}
-			}
-		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
-	} else {
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (m != NULL)
-				rte_mempool_put(m->pool, m);
-		}
-	}
-
-done:
-	/* buffers were freed, update counters */
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	return txq->tx_rs_thresh;
-}
-
 static __rte_always_inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 	  struct rte_mbuf *pkt, uint64_t flags)
@@ -1195,7 +1087,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		idpf_tx_singleq_free_bufs_avx512(txq);
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
 
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	nb_commit = nb_pkts;
@@ -1311,110 +1203,6 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
 	cq->tx_tail = cq_qid;
 }
 
-static __rte_always_inline int
-idpf_tx_splitq_free_bufs_avx512(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry_vec *txep;
-	uint32_t n;
-	uint32_t i;
-	int nb_free = 0;
-	struct rte_mbuf *m;
-	struct rte_mbuf **free = alloca(sizeof(struct rte_mbuf *) * txq->tx_rs_thresh);
-
-	n = txq->tx_rs_thresh;
-
-	 /* first buffer to free from S/W ring is at index
-	  * tx_next_dd - (tx_rs_thresh-1)
-	  */
-	txep = (void *)txq->sw_ring;
-	txep += txq->tx_next_dd - (n - 1);
-
-	if (txq->offloads & IDPF_TX_OFFLOAD_MBUF_FAST_FREE && (n & 31) == 0) {
-		struct rte_mempool *mp = txep[0].mbuf->pool;
-		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp,
-								rte_lcore_id());
-		void **cache_objs;
-
-		if (!cache || cache->len == 0)
-			goto normal;
-
-		cache_objs = &cache->objs[cache->len];
-
-		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
-			goto done;
-		}
-
-		/* The cache follows the following algorithm
-		 *   1. Add the objects to the cache
-		 *   2. Anything greater than the cache min value (if it crosses the
-		 *   cache flush threshold) is flushed to the ring.
-		 */
-		/* Add elements back into the cache */
-		uint32_t copied = 0;
-		/* n is multiple of 32 */
-		while (copied < n) {
-			const __m512i a = _mm512_loadu_si512(&txep[copied]);
-			const __m512i b = _mm512_loadu_si512(&txep[copied + 8]);
-			const __m512i c = _mm512_loadu_si512(&txep[copied + 16]);
-			const __m512i d = _mm512_loadu_si512(&txep[copied + 24]);
-
-			_mm512_storeu_si512(&cache_objs[copied], a);
-			_mm512_storeu_si512(&cache_objs[copied + 8], b);
-			_mm512_storeu_si512(&cache_objs[copied + 16], c);
-			_mm512_storeu_si512(&cache_objs[copied + 24], d);
-			copied += 32;
-		}
-		cache->len += n;
-
-		if (cache->len >= cache->flushthresh) {
-			rte_mempool_ops_enqueue_bulk(mp,
-						     &cache->objs[cache->size],
-						     cache->len - cache->size);
-			cache->len = cache->size;
-		}
-		goto done;
-	}
-
-normal:
-	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
-	if (likely(m)) {
-		free[0] = m;
-		nb_free = 1;
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (likely(m)) {
-				if (likely(m->pool == free[0]->pool)) {
-					free[nb_free++] = m;
-				} else {
-					rte_mempool_put_bulk(free[0]->pool,
-							     (void *)free,
-							     nb_free);
-					free[0] = m;
-					nb_free = 1;
-				}
-			}
-		}
-		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
-	} else {
-		for (i = 1; i < n; i++) {
-			m = rte_pktmbuf_prefree_seg(txep[i].mbuf);
-			if (m)
-				rte_mempool_put(m->pool, m);
-		}
-	}
-
-done:
-	/* buffers were freed, update counters */
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-	txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->tx_rs_thresh;
-
-	return txq->tx_rs_thresh;
-}
-
 #define IDPF_TXD_FLEX_QW1_TX_BUF_SZ_S	48
 
 static __rte_always_inline void
@@ -1556,11 +1344,12 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 
 	while (nb_pkts) {
 		uint16_t ret, num;
-
 		idpf_splitq_scan_cq_ring(txq->complq);
 
-		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->tx_free_thresh)
-			idpf_tx_splitq_free_bufs_avx512(txq);
+		if (txq->ctype[IDPF_TXD_COMPLT_RS] > txq->tx_free_thresh) {
+			ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
+			txq->ctype[IDPF_TXD_COMPLT_RS] -= txq->tx_rs_thresh;
+		}
 
 		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 		ret = idpf_splitq_xmit_fixed_burst_vec_avx512(tx_queue,
-- 
2.34.1

