Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C071073CBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 14:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CD284014F;
	Wed,  8 Apr 2026 16:13:21 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 990584013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 16:13:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7D2402041E;
 Wed,  8 Apr 2026 16:13:18 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 8 Apr 2026 16:13:17 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mempool: improve cache behaviour and performance
Date: Wed,  8 Apr 2026 14:13:15 +0000
Message-ID: <20260408141315.904381-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Apr 2026 14:13:17.0646 (UTC)
 FILETIME=[D8BF8EE0:01DCC761]
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

This patch refactors the mempool cache to eliminate some unexpected
behaviour and reduce the mempool cache miss rate.

1.
The actual cache size was 1.5 times the cache size specified at run-time
mempool creation.
This was obviously not expected by application developers.

2.
In get operations, the check for when to use the cache as bounce buffer
did not respect the run-time configured cache size,
but compared to the build time maximum possible cache size
(RTE_MEMPOOL_CACHE_MAX_SIZE, default 512).
E.g. with a configured cache size of 32 objects, getting 256 objects
would first fetch 32 + 256 = 288 objects into the cache,
and then move the 256 objects from the cache to the destination memory,
instead of fetching the 256 objects directly to the destination memory.
This had a performance cost.
However, this is unlikely to occur in real applications, so it is not
important in itself.

3.
When putting objects into a mempool, and the mempool cache did not have
free space for so many objects,
the cache was flushed completely, and the new objects were then put into
the cache.
I.e. the cache drain level was zero.
This (complete cache flush) meant that a subsequent get operation (with
the same number of objects) completely emptied the cache,
so another subsequent get operation required replenishing the cache.

Similarly,
When getting objects from a mempool, and the mempool cache did not hold so
many objects,
the cache was replenished to cache->size + remaining objects,
and then (the remaining part of) the requested objects were fetched via
the cache,
which left the cache filled (to cache->size) at completion.
I.e. the cache refill level was cache->size (plus some, depending on
request size).

(1) was improved by generally comparing to cache->size instead of
cache->flushthresh.
The cache->flushthresh field is kept for API/ABI compatibility purposes,
and initialized to cache->size instead of cache->size * 1.5.

(2) was improved by generally comparing to cache->size instead of
RTE_MEMPOOL_CACHE_MAX_SIZE.

(3) was improved by flushing and replenishing the cache by half its size,
so an flush/replenish can be followed randomly by get or put requests.
This also reduced the number of objects in each flush/replenish operation.

As a consequence of these changes, the size of the array holding the
objects in the cache (cache->objs[]) no longer needs to be
2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and was reduced to
RTE_MEMPOOL_CACHE_MAX_SIZE.
For ABI compatibility purposes, keeping the size of the rte_mempool_cache
unchanged, a filler array (cache->unused_objs[]) was added.

Performance data:
With a real WAN Optimization application, where the number of allocated
packets varies (as they are held in e.g. shaper queues), the mempool
cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
This was deployed in production at an ISP, and using an effective cache
size of 384 objects.

In addition to the Mempool library changes, some Intel network drivers
bypassing the Mempool API to access the mempool cache were updated
accordingly.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 drivers/net/intel/common/tx.h                 | 36 +-------
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 15 ++--
 lib/mempool/rte_mempool.c                     | 14 +--
 lib/mempool/rte_mempool.h                     | 86 ++++++++++---------
 4 files changed, 60 insertions(+), 91 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 283bd58d5d..c5114f756d 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -284,43 +284,11 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 			txq->fast_free_mp :
 			(txq->fast_free_mp = txep[0].mbuf->pool);
 
-	if (mp != NULL && (n & 31) == 0) {
-		void **cache_objs;
-		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
-
-		if (cache == NULL)
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
-		 *   2. Anything greater than the cache min value (if it
-		 *   crosses the cache flush threshold) is flushed to the ring.
-		 */
-		/* Add elements back into the cache */
-		uint32_t copied = 0;
-		/* n is multiple of 32 */
-		while (copied < n) {
-			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
-			copied += 32;
-		}
-		cache->len += n;
-
-		if (cache->len >= cache->flushthresh) {
-			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
-					cache->len - cache->size);
-			cache->len = cache->size;
-		}
+	if (mp != NULL) {
+		rte_mbuf_raw_free_bulk(mp, (void *)txep, n);
 		goto done;
 	}
 
-normal:
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 9af275cd9d..e5eb56552f 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -148,14 +148,19 @@ idpf_singleq_rearm(struct idpf_rx_queue *rxq)
 	/* Can this be satisfied from the cache? */
 	if (cache->len < IDPF_RXQ_REARM_THRESH) {
 		/* No. Backfill the cache first, and then fill from it */
-		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size -
-							cache->len);
 
-		/* How many do we require i.e. number to fill the cache + the request */
+		/* Backfill would exceed the cache bounce buffer limit? */
+		__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+		if (unlikely(IDPF_RXQ_REARM_THRESH > cache->size / 2)) {
+			idpf_singleq_rearm_common(rxq);
+			return;
+		}
+
+		/* Backfill the cache from the backend; fetch (size / 2) objects. */
 		int ret = rte_mempool_ops_dequeue_bulk
-				(rxq->mp, &cache->objs[cache->len], req);
+				(rxq->mp, &cache->objs[cache->len], cache->size / 2);
 		if (ret == 0) {
-			cache->len += req;
+			cache->len += cache->size / 2;
 		} else {
 			if (rxq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
 			    rxq->nb_rx_desc) {
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 3042d94c14..805b52cc58 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -52,11 +52,6 @@ static void
 mempool_event_callback_invoke(enum rte_mempool_event event,
 			      struct rte_mempool *mp);
 
-/* Note: avoid using floating point since that compiler
- * may not think that is constant.
- */
-#define CALC_CACHE_FLUSHTHRESH(c) (((c) * 3) / 2)
-
 #if defined(RTE_ARCH_X86)
 /*
  * return the greatest common divisor between a and b (fast algorithm)
@@ -757,13 +752,8 @@ rte_mempool_free(struct rte_mempool *mp)
 static void
 mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 {
-	/* Check that cache have enough space for flush threshold */
-	RTE_BUILD_BUG_ON(CALC_CACHE_FLUSHTHRESH(RTE_MEMPOOL_CACHE_MAX_SIZE) >
-			 RTE_SIZEOF_FIELD(struct rte_mempool_cache, objs) /
-			 RTE_SIZEOF_FIELD(struct rte_mempool_cache, objs[0]));
-
 	cache->size = size;
-	cache->flushthresh = CALC_CACHE_FLUSHTHRESH(size);
+	cache->flushthresh = size; /* Obsolete; for API/ABI compatibility purposes only */
 	cache->len = 0;
 }
 
@@ -850,7 +840,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/* asked cache too big */
 	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE ||
-	    CALC_CACHE_FLUSHTHRESH(cache_size) > n) {
+	    cache_size > n) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 2e54fc4466..dafe98d1c2 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -89,7 +89,7 @@ struct __rte_cache_aligned rte_mempool_debug_stats {
  */
 struct __rte_cache_aligned rte_mempool_cache {
 	uint32_t size;	      /**< Size of the cache */
-	uint32_t flushthresh; /**< Threshold before we flush excess elements */
+	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility purposes only */
 	uint32_t len;	      /**< Current cache count */
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	uint32_t unused;
@@ -104,13 +104,11 @@ struct __rte_cache_aligned rte_mempool_cache {
 		uint64_t get_success_objs;  /**< Objects successfully allocated. */
 	} stats;                        /**< Statistics */
 #endif
-	/**
-	 * Cache objects
-	 *
-	 * Cache is allocated to this size to allow it to overflow in certain
-	 * cases to avoid needless emptying of cache.
-	 */
-	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
+	/** Cache objects */
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
+	/** Unused; for ABI compatibility purposes only */
+	void *unused_objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
+	/* Note: Remember to add an RTE_CACHE_GUARD here, if removing unused_objs. */
 };
 
 /**
@@ -1047,11 +1045,16 @@ rte_mempool_free(struct rte_mempool *mp);
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
  *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5.
+ *   RTE_MEMPOOL_CACHE_MAX_SIZE and n.
  *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
  *   avoid losing objects in cache.
+ *   Note:
+ *   Mempool put/get requests of more than cache_size / 2 objects may be
+ *   partially or fully served directly by the multi-producer/consumer
+ *   pool, to avoid the overhead of copying the objects twice (instead of
+ *   once) when using the cache as a bounce buffer.
  * @param private_data_size
  *   The size of the private data appended after the mempool
  *   structure. This is useful for storing some private data after the
@@ -1377,7 +1380,7 @@ rte_mempool_cache_flush(struct rte_mempool_cache *cache,
  *   A pointer to a mempool cache structure. May be NULL if not needed.
  */
 static __rte_always_inline void
-rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
+rte_mempool_do_generic_put(struct rte_mempool *mp, void * const * __rte_restrict obj_table,
 			   unsigned int n, struct rte_mempool_cache *cache)
 {
 	void **cache_objs;
@@ -1390,24 +1393,26 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
 
-	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	__rte_assume(cache->len <= cache->flushthresh);
-	if (likely(cache->len + n <= cache->flushthresh)) {
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->len <= cache->size);
+	if (likely(cache->len + n <= cache->size)) {
 		/* Sufficient room in the cache for the objects. */
 		cache_objs = &cache->objs[cache->len];
 		cache->len += n;
-	} else if (n <= cache->flushthresh) {
+	} else if (n <= cache->size / 2) {
 		/*
-		 * The cache is big enough for the objects, but - as detected by
-		 * the comparison above - has insufficient room for them.
-		 * Flush the cache to make room for the objects.
+		 * The number of objects is within the cache bounce buffer limit,
+		 * but - as detected by the comparison above - the cache has
+		 * insufficient room for them.
+		 * Flush the cache to the backend to make room for the objects;
+		 * flush (size / 2) objects.
 		 */
-		cache_objs = &cache->objs[0];
-		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
-		cache->len = n;
+		cache_objs = &cache->objs[cache->len - cache->size / 2];
+		cache->len = cache->len - cache->size / 2 + n;
+		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->size / 2);
 	} else {
-		/* The request itself is too big for the cache. */
+		/* The request itself is too big. */
 		goto driver_enqueue_stats_incremented;
 	}
 
@@ -1418,13 +1423,13 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 
 driver_enqueue:
 
-	/* increment stat now, adding in mempool always success */
+	/* Increment stats now, adding in mempool always succeeds. */
 	RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
 	RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);
 
 driver_enqueue_stats_incremented:
 
-	/* push objects to the backend */
+	/* Push the objects to the backend. */
 	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
 }
 
@@ -1442,7 +1447,7 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
  *   A pointer to a mempool cache structure. May be NULL if not needed.
  */
 static __rte_always_inline void
-rte_mempool_generic_put(struct rte_mempool *mp, void * const *obj_table,
+rte_mempool_generic_put(struct rte_mempool *mp, void * const * __rte_restrict obj_table,
 			unsigned int n, struct rte_mempool_cache *cache)
 {
 	rte_mempool_trace_generic_put(mp, obj_table, n, cache);
@@ -1465,7 +1470,7 @@ rte_mempool_generic_put(struct rte_mempool *mp, void * const *obj_table,
  *   The number of objects to add in the mempool from obj_table.
  */
 static __rte_always_inline void
-rte_mempool_put_bulk(struct rte_mempool *mp, void * const *obj_table,
+rte_mempool_put_bulk(struct rte_mempool *mp, void * const * __rte_restrict obj_table,
 		     unsigned int n)
 {
 	struct rte_mempool_cache *cache;
@@ -1507,7 +1512,7 @@ rte_mempool_put(struct rte_mempool *mp, void *obj)
  *   - <0: Error; code of driver dequeue function.
  */
 static __rte_always_inline int
-rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
+rte_mempool_do_generic_get(struct rte_mempool *mp, void ** __rte_restrict obj_table,
 			   unsigned int n, struct rte_mempool_cache *cache)
 {
 	int ret;
@@ -1524,7 +1529,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* The cache is a stack, so copy will be in reverse order. */
 	cache_objs = &cache->objs[cache->len];
 
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	if (likely(n <= cache->len)) {
 		/* The entire request can be satisfied from the cache. */
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
@@ -1548,13 +1553,13 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	for (index = 0; index < len; index++)
 		*obj_table++ = *--cache_objs;
 
-	/* Dequeue below would overflow mem allocated for cache? */
-	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
+	/* Dequeue below would exceed the cache bounce buffer limit? */
+	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+	if (unlikely(remaining > cache->size / 2))
 		goto driver_dequeue;
 
-	/* Fill the cache from the backend; fetch size + remaining objects. */
-	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
-			cache->size + remaining);
+	/* Fill the cache from the backend; fetch (size / 2) objects. */
+	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs, cache->size / 2);
 	if (unlikely(ret < 0)) {
 		/*
 		 * We are buffer constrained, and not able to fetch all that.
@@ -1568,10 +1573,11 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
-	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-	cache_objs = &cache->objs[cache->size + remaining];
-	cache->len = cache->size;
+	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+	__rte_assume(remaining <= cache->size / 2);
+	cache_objs = &cache->objs[cache->size / 2];
+	cache->len = cache->size / 2 - remaining;
 	for (index = 0; index < remaining; index++)
 		*obj_table++ = *--cache_objs;
 
@@ -1629,7 +1635,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
  *   - -ENOENT: Not enough entries in the mempool; no object is retrieved.
  */
 static __rte_always_inline int
-rte_mempool_generic_get(struct rte_mempool *mp, void **obj_table,
+rte_mempool_generic_get(struct rte_mempool *mp, void ** __rte_restrict obj_table,
 			unsigned int n, struct rte_mempool_cache *cache)
 {
 	int ret;
@@ -1663,7 +1669,7 @@ rte_mempool_generic_get(struct rte_mempool *mp, void **obj_table,
  *   - -ENOENT: Not enough entries in the mempool; no object is retrieved.
  */
 static __rte_always_inline int
-rte_mempool_get_bulk(struct rte_mempool *mp, void **obj_table, unsigned int n)
+rte_mempool_get_bulk(struct rte_mempool *mp, void ** __rte_restrict obj_table, unsigned int n)
 {
 	struct rte_mempool_cache *cache;
 	cache = rte_mempool_default_cache(mp, rte_lcore_id());
@@ -1692,7 +1698,7 @@ rte_mempool_get_bulk(struct rte_mempool *mp, void **obj_table, unsigned int n)
  *   - -ENOENT: Not enough entries in the mempool; no object is retrieved.
  */
 static __rte_always_inline int
-rte_mempool_get(struct rte_mempool *mp, void **obj_p)
+rte_mempool_get(struct rte_mempool *mp, void ** __rte_restrict obj_p)
 {
 	return rte_mempool_get_bulk(mp, obj_p, 1);
 }
-- 
2.43.0

