Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB56C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 15:59:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E024B4029F;
	Wed, 26 Feb 2025 16:59:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B486D4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 16:59:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7501C21726;
 Wed, 26 Feb 2025 16:59:30 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 26 Feb 2025 16:59:30 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mempool: micro optimizations
Date: Wed, 26 Feb 2025 15:59:22 +0000
Message-ID: <20250226155923.128859-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Feb 2025 15:59:30.0064 (UTC)
 FILETIME=[6B4AE100:01DB8867]
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

The comparisons lcore_id < RTE_MAX_LCORE and lcore_id != LCORE_ID_ANY are
equivalent, but the latter compiles to fewer bytes of code space.
Similarly for lcore_id >= RTE_MAX_LCORE and lcore_id == LCORE_ID_ANY.

The rte_mempool_get_ops() function is also used in the fast path, so
RTE_VERIFY() was replaced by RTE_ASSERT().

Compilers implicitly consider comparisons of variable == 0 likely, so
unlikely() was added to the check for no mempool cache (mp->cache_size ==
0) in the rte_mempool_default_cache() function.

The rte_mempool_do_generic_put() function for adding objects to a mempool
was refactored as follows:
- The comparison for the request itself being too big, which is considered
  unlikely, was moved down and out of the code path where the cache has
  sufficient room for the added objects, which is considered the most
  likely code path.
- Added __rte_assume() about the cache length, size and threshold, for
  compiler optimization when "n" is compile time constant.
- Added __rte_assume() about "ret" being zero, so other functions using
  the value returned by this function can be potentially optimized by the
  compiler; especially when it merges multiple sequential code paths of
  inlined code depending on the return value being either zero or
  negative.
- The refactored source code (with comments) made the separate comment
  describing the cache flush/add algorithm superfluous, so it was removed.

A few more likely()/unlikely() were added.

A few comments were improved for readability.

Some assertions, RTE_ASSERT(), were added. Most importantly to assert that
the return values of the mempool drivers' enqueue and dequeue operations
are API compliant, i.e. 0 (for success) or negative (for failure), and
never positive.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mempool/rte_mempool.h | 67 ++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index c495cc012f..aedc100964 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -334,7 +334,7 @@ struct __rte_cache_aligned rte_mempool {
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 #define RTE_MEMPOOL_STAT_ADD(mp, name, n) do {                                  \
 		unsigned int __lcore_id = rte_lcore_id();                       \
-		if (likely(__lcore_id < RTE_MAX_LCORE))                         \
+		if (likely(__lcore_id != LCORE_ID_ANY))                         \
 			(mp)->stats[__lcore_id].name += (n);                    \
 		else                                                            \
 			rte_atomic_fetch_add_explicit(&((mp)->stats[RTE_MAX_LCORE].name),  \
@@ -751,7 +751,7 @@ extern struct rte_mempool_ops_table rte_mempool_ops_table;
 static inline struct rte_mempool_ops *
 rte_mempool_get_ops(int ops_index)
 {
-	RTE_VERIFY((ops_index >= 0) && (ops_index < RTE_MEMPOOL_MAX_OPS_IDX));
+	RTE_ASSERT((ops_index >= 0) && (ops_index < RTE_MEMPOOL_MAX_OPS_IDX));
 
 	return &rte_mempool_ops_table.ops[ops_index];
 }
@@ -791,7 +791,8 @@ rte_mempool_ops_dequeue_bulk(struct rte_mempool *mp,
 	rte_mempool_trace_ops_dequeue_bulk(mp, obj_table, n);
 	ops = rte_mempool_get_ops(mp->ops_index);
 	ret = ops->dequeue(mp, obj_table, n);
-	if (ret == 0) {
+	RTE_ASSERT(ret <= 0);
+	if (likely(ret == 0)) {
 		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_bulk, 1);
 		RTE_MEMPOOL_STAT_ADD(mp, get_common_pool_objs, n);
 	}
@@ -816,11 +817,14 @@ rte_mempool_ops_dequeue_contig_blocks(struct rte_mempool *mp,
 		void **first_obj_table, unsigned int n)
 {
 	struct rte_mempool_ops *ops;
+	int ret;
 
 	ops = rte_mempool_get_ops(mp->ops_index);
 	RTE_ASSERT(ops->dequeue_contig_blocks != NULL);
 	rte_mempool_trace_ops_dequeue_contig_blocks(mp, first_obj_table, n);
-	return ops->dequeue_contig_blocks(mp, first_obj_table, n);
+	ret = ops->dequeue_contig_blocks(mp, first_obj_table, n);
+	RTE_ASSERT(ret <= 0);
+	return ret;
 }
 
 /**
@@ -848,6 +852,7 @@ rte_mempool_ops_enqueue_bulk(struct rte_mempool *mp, void * const *obj_table,
 	rte_mempool_trace_ops_enqueue_bulk(mp, obj_table, n);
 	ops = rte_mempool_get_ops(mp->ops_index);
 	ret = ops->enqueue(mp, obj_table, n);
+	RTE_ASSERT(ret <= 0);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	if (unlikely(ret < 0))
 		RTE_MEMPOOL_LOG(CRIT, "cannot enqueue %u objects to mempool %s",
@@ -1333,10 +1338,10 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
 static __rte_always_inline struct rte_mempool_cache *
 rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
 {
-	if (mp->cache_size == 0)
+	if (unlikely(mp->cache_size == 0))
 		return NULL;
 
-	if (lcore_id >= RTE_MAX_LCORE)
+	if (unlikely(lcore_id == LCORE_ID_ANY))
 		return NULL;
 
 	rte_mempool_trace_default_cache(mp, lcore_id,
@@ -1383,32 +1388,33 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 {
 	void **cache_objs;
 
-	/* No cache provided */
+	/* No cache provided? */
 	if (unlikely(cache == NULL))
 		goto driver_enqueue;
 
-	/* increment stat now, adding in mempool always success */
+	/* Increment stats now, adding in mempool always succeeds. */
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
 
-	/* The request itself is too big for the cache */
-	if (unlikely(n > cache->flushthresh))
-		goto driver_enqueue_stats_incremented;
-
-	/*
-	 * The cache follows the following algorithm:
-	 *   1. If the objects cannot be added to the cache without crossing
-	 *      the flush threshold, flush the cache to the backend.
-	 *   2. Add the objects to the cache.
-	 */
-
-	if (cache->len + n <= cache->flushthresh) {
+	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= cache->flushthresh);
+	if (likely(cache->len + n <= cache->flushthresh)) {
+		/* Sufficient room in the cache for the objects. */
 		cache_objs = &cache->objs[cache->len];
 		cache->len += n;
-	} else {
+	} else if (n <= cache->flushthresh) {
+		/*
+		 * The cache is big enough for the objects, but - as detected by
+		 * the comparison above - has insufficient room for them.
+		 * Flush the cache to make room for the objects.
+		 */
 		cache_objs = &cache->objs[0];
 		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
 		cache->len = n;
+	} else {
+		/* The request itself is too big for the cache. */
+		goto driver_enqueue_stats_incremented;
 	}
 
 	/* Add the objects to the cache. */
@@ -1515,7 +1521,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	uint32_t index, len;
 	void **cache_objs;
 
-	/* No cache provided */
+	/* No cache provided? */
 	if (unlikely(cache == NULL)) {
 		remaining = n;
 		goto driver_dequeue;
@@ -1524,6 +1530,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* The cache is a stack, so copy will be in reverse order. */
 	cache_objs = &cache->objs[cache->len];
 
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
 	if (__rte_constant(n) && n <= cache->len) {
 		/*
 		 * The request size is known at build time, and
@@ -1556,7 +1563,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	 * where the entire request can be satisfied from the cache
 	 * has already been handled above, so omit handling it here.
 	 */
-	if (!__rte_constant(n) && remaining == 0) {
+	if (!__rte_constant(n) && likely(remaining == 0)) {
 		/* The entire request is satisfied from the cache. */
 
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
@@ -1565,7 +1572,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 		return 0;
 	}
 
-	/* if dequeue below would overflow mem allocated for cache */
+	/* Dequeue below would overflow mem allocated for cache? */
 	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
 		goto driver_dequeue;
 
@@ -1574,8 +1581,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 			cache->size + remaining);
 	if (unlikely(ret < 0)) {
 		/*
-		 * We are buffer constrained, and not able to allocate
-		 * cache + remaining.
+		 * We are buffer constrained, and not able to fetch all that.
 		 * Do not fill the cache, just satisfy the remaining part of
 		 * the request directly from the backend.
 		 */
@@ -1583,6 +1589,8 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	}
 
 	/* Satisfy the remaining part of the request from the filled cache. */
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	cache_objs = &cache->objs[cache->size + remaining];
 	for (index = 0; index < remaining; index++)
 		*obj_table++ = *--cache_objs;
@@ -1599,7 +1607,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* Get remaining objects directly from the backend. */
 	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
 
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		if (likely(cache != NULL)) {
 			cache->len = n - remaining;
 			/*
@@ -1619,6 +1627,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
 			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
 		}
+		__rte_assume(ret == 0);
 	}
 
 	return ret;
@@ -1650,7 +1659,7 @@ rte_mempool_generic_get(struct rte_mempool *mp, void **obj_table,
 {
 	int ret;
 	ret = rte_mempool_do_generic_get(mp, obj_table, n, cache);
-	if (ret == 0)
+	if (likely(ret == 0))
 		RTE_MEMPOOL_CHECK_COOKIES(mp, obj_table, n, 1);
 	rte_mempool_trace_generic_get(mp, obj_table, n, cache);
 	return ret;
@@ -1741,7 +1750,7 @@ rte_mempool_get_contig_blocks(struct rte_mempool *mp,
 	int ret;
 
 	ret = rte_mempool_ops_dequeue_contig_blocks(mp, first_obj_table, n);
-	if (ret == 0) {
+	if (likely(ret == 0)) {
 		RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
 		RTE_MEMPOOL_STAT_ADD(mp, get_success_blks, n);
 		RTE_MEMPOOL_CONTIG_BLOCKS_CHECK_COOKIES(mp, first_obj_table, n,
-- 
2.43.0

