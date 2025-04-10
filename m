Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C1C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 05:23:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E5D840A4B;
	Thu, 10 Apr 2025 07:22:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5583F40687
 for <dev@dpdk.org>; Thu, 10 Apr 2025 07:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744262557; x=1775798557;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=k7Jn0FmBmXVZfgAGCszUtvz+BRlA/TrAutkPay0bIr4=;
 b=ESC2KMGVGFzd+k40CFeZLmF5FirOQS7fVI/tr8rDqbfOvQD93Z7UcQDy
 /diql3dszfjs0j7tv/SnGKYoc69/Jd3ggpFWkDwzLNQrFOE43JsOJkNjS
 /9fJy+azrvnmMPDh/7IVc5YydOjU/kZaM1ZF/IZPu71DSSyDP6h5WWJqK
 QGjzuY35eH3FccZYZaFeLngDwwM/U1N8ClP16/nfPHJZ1IYd0EHdv5CtG
 3XNq8A6JukF5f1P5lyPoXWKdnJH5rN351YcDwVr1WDda5OwNjrYwsG9XB
 fSIEx7GsjZRvINBUHmlm2z5yFj9U9RP1in4s9cO5Eyr2DKBYkx8zzWbND A==;
X-CSE-ConnectionGUID: XQ25SYrzSpGa7QaSDEQGnw==
X-CSE-MsgGUID: 4JJ6vFNST1y3wIL7g1uWlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45651579"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="45651579"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2025 22:22:37 -0700
X-CSE-ConnectionGUID: TjqHTvuhSsylGU77L3xQwg==
X-CSE-MsgGUID: B7BCaeHBTV2yWDQvryTAbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="133520364"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa005.fm.intel.com with ESMTP; 09 Apr 2025 22:22:35 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v7 4/4] net/idpf: use common Tx free fn in idpf
Date: Thu, 10 Apr 2025 10:54:06 +0530
Message-Id: <20250410052406.293110-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410052406.293110-1-shaiq.wani@intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250410052406.293110-1-shaiq.wani@intel.com>
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
AVX2 and AVX512

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  61 +----
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 230 +-----------------
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   8 +
 3 files changed, 16 insertions(+), 283 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 40a0473116..1babc5114b 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -7,6 +7,7 @@
 
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
+#include "idpf_rxtx_vec_common.h"
 
 static __rte_always_inline void
 idpf_singleq_rx_rearm(struct idpf_rx_queue *rxq)
@@ -481,64 +482,6 @@ idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16
 	return _idpf_singleq_recv_raw_pkts_vec_avx2(rx_queue, rx_pkts, nb_pkts);
 }
 
-static __rte_always_inline int
-idpf_singleq_tx_free_bufs_vec(struct ci_tx_queue *txq)
-{
-	struct ci_tx_entry *txep;
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
-	txep = &txq->sw_ring[txq->tx_next_dd - (n - 1)];
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
-	/* buffers were freed, update counters */
-	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + txq->tx_rs_thresh);
-	txq->tx_next_dd = (uint16_t)(txq->tx_next_dd + txq->tx_rs_thresh);
-	if (txq->tx_next_dd >= txq->nb_tx_desc)
-		txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
-
-	return txq->tx_rs_thresh;
-}
-
 static inline void
 idpf_singleq_vtx1(volatile struct idpf_base_tx_desc *txdp,
 		  struct rte_mbuf *pkt, uint64_t flags)
@@ -623,7 +566,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		idpf_singleq_tx_free_bufs_vec(txq);
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
 
 	nb_commit = nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	if (unlikely(nb_pkts == 0))
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index d78b8ad86b..15b4c8a68e 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -6,6 +6,7 @@
 #include <rte_vect.h>
 #include "idpf_common_device.h"
 #include "idpf_common_rxtx.h"
+#include "idpf_rxtx_vec_common.h"
 
 #define IDPF_DESCS_PER_LOOP_AVX 8
 #define PKTLEN_SHIFT 10
@@ -998,122 +999,6 @@ idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
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
@@ -1197,7 +1082,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void *tx_queue, struct rte_mbuf **tx_pk
 	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
-		idpf_tx_singleq_free_bufs_avx512(txq);
+		ci_tx_free_bufs_vec(txq, idpf_tx_desc_done, false);
 
 	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
 	nb_commit = nb_pkts;
@@ -1314,110 +1199,6 @@ idpf_splitq_scan_cq_ring(struct ci_tx_queue *cq)
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
@@ -1559,11 +1340,12 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 
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
diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
index e444addf85..cd75c050c9 100644
--- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
+++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
@@ -28,6 +28,14 @@
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_TCP_CKSUM)
 
+static inline int
+idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
+{
+	return (txq->idpf_tx_ring[idx].qw1 &
+			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) ==
+				rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
+}
+
 static inline int
 idpf_rx_vec_queue_default(struct idpf_rx_queue *rxq)
 {
-- 
2.34.1

