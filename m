Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E18C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 20:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A29A410E8;
	Fri, 21 Feb 2025 21:27:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 19E65410E6
 for <dev@dpdk.org>; Fri, 21 Feb 2025 21:27:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B9DE620989
 for <dev@dpdk.org>; Fri, 21 Feb 2025 21:27:29 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 21 Feb 2025 21:27:29 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v20] mempool: fix mempool cache size
Date: Fri, 21 Feb 2025 20:27:22 +0000
Message-ID: <20250221202722.236360-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920163203.840770-1-mb@smartsharesystems.com>
References: <20240920163203.840770-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Feb 2025 20:27:29.0449 (UTC)
 FILETIME=[07499190:01DB849F]
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

NOTE: THIS VERSION DOES NOT BREAK THE API/ABI.

First, a per-lcore mempool cache could hold 50 % more than the cache's
size.
Since application developers do not expect this behavior, it could lead to
application failure.
This patch fixes this bug without breaking the API/ABI, by using the
mempool cache's "size" instead of the "flushthresh" as the threshold for
how many objects can be held in a mempool cache.
Note: The "flushthresh" field can be removed from the cache structure in a
future API/ABI breaking release, which must be announced in advance.

Second, requests to fetch a number of objects from the backend driver
exceeding the cache's size (but less than RTE_MEMPOOL_CACHE_MAX_SIZE) were
copied twice; first to the cache, and from there to the destination.
Such superfluous copying through the mempool cache degrades the
performance in these cases.
This patch also fixes this misbehavior, so when fetching more objects from
the driver than the mempool cache's size, they are fetched directly to the
destination.

The internal macro to calculate the cache flush threshold was updated to
reflect the new flush threshold of 1 * size instead of 1.5 * size.

The function rte_mempool_do_generic_put() for adding objects to a mempool
was modified as follows:
- When determining if the cache has sufficient room for the request
  without flushing, compare to the cache's size (cache->size) instead of
  the obsolete flush threshold (cache->flushthresh).
- The comparison for the request being too big, which is considered
  unlikely, was moved down and out of the code path where the cache has
  sufficient room for the added objects, which is considered the most
  likely code path.
- Added __rte_assume() about the cache size, for compiler optimization
  when "n" is compile time constant.
- Added __rte_assume() about "ret", for compiler optimization of
  rte_mempool_generic_get() considering the return value of
  rte_mempool_do_generic_get().

The function rte_mempool_do_generic_get() for getting objects from a
mempool was refactored as follows:
- Handling a request for a constant number of objects was merged with
  handling a request for a nonconstant number of objects, and a note about
  compiler loop unrolling in the constant case was added.
- When determining if the remaining part of a request to be dequeued from
  the backend is too big to be copied via the cache, compare to the
  cache's size (cache->size) instead of the max possible cache size
  (RTE_MEMPOOL_CACHE_MAX_SIZE).
- When refilling the cache, the target fill level was reduced from the
  full cache size to half the cache size. This allows some room for a
  put() request following a get() request where the cache was refilled,
  without "flapping" between draining and refilling the entire cache.
  Note: Before this patch, the distance between the flush threshold and
  the refill level was also half a cache size.
- A copy of cache->len in the local variable "len" is no longer needed,
  so it was removed.
- Added a group of __rte_assume()'s, for compiler optimization when "n" is
  compile time constant.

Some comments were also updated.

Furthermore, some likely()/unlikely()'s were added to a few inline
functions; most prominently rte_mempool_default_cache(), which is used by
both rte_mempool_put_bulk() and rte_mempool_get_bulk().

And finally, RTE_ASSERT()'s were added to check the return values of the
mempool driver dequeue() and enqueue() operations.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v20:
* Added more __rte_assume()'s to fix build error with GCC 11.4.1 and
  GCC 11.5.0 in call to mempool_get_bulk() with compile time constant "n"
  larger than RTE_MEMPOOL_CACHE_MAX_SIZE.
v19:
* Added __rte_assume()'s and RTE_ASSERT()'s.
v18:
* Start over from scratch, to avoid API/ABI breakage.
v17:
* Update rearm in idpf driver.
v16:
* Fix bug in rte_mempool_do_generic_put() regarding criteria for flush.
v15:
* Changed back cache bypass limit from n >= RTE_MEMPOOL_CACHE_MAX_SIZE to
  n > RTE_MEMPOOL_CACHE_MAX_SIZE.
* Removed cache size limit from serving via cache.
v14:
* Change rte_mempool_do_generic_put() back from add-then-flush to
  flush-then-add.
  Keep the target cache fill level of ca. 1/2 size of the cache.
v13:
* Target a cache fill level of ca. 1/2 size of the cache when flushing and
  refilling; based on an assumption of equal probability of get and put,
  instead of assuming a higher probability of put being followed by
  another put, and get being followed by another get.
* Reduce the amount of changes to the drivers.
v12:
* Do not init mempool caches with size zero; they don't exist.
  Bug introduced in v10.
v11:
* Removed rte_mempool_do_generic_get_split().
v10:
* Initialize mempool caches, regardless of size zero.
  This to fix compiler warning about out of bounds access.
v9:
* Removed factor 1.5 from description of cache_size parameter to
  rte_mempool_create().
* Refactored rte_mempool_do_generic_put() to eliminate some gotos.
  No functional change.
* Removed check for n >= RTE_MEMPOOL_CACHE_MAX_SIZE in
  rte_mempool_do_generic_get(); it caused the function to fail when the
  request could not be served from the backend alone, but it could be
  served from the cache and the backend.
* Refactored rte_mempool_do_generic_get_split() to make it shorter.
* When getting objects directly from the backend, use burst size aligned
  with either CPU cache line size or mempool cache size.
v8:
* Rewrote rte_mempool_do_generic_put() to get rid of transaction
  splitting. Use a method similar to the existing put method with fill
  followed by flush if overfilled.
  This also made rte_mempool_do_generic_put_split() obsolete.
* When flushing the cache as much as we can, use burst size aligned with
  either CPU cache line size or mempool cache size.
v7:
* Increased max mempool cache size from 512 to 1024 objects.
  Mainly for CI performance test purposes.
  Originally, the max mempool cache size was 768 objects, and used a fixed
  size array of 1024 objects in the mempool cache structure.
v6:
* Fix v5 incomplete implementation of passing large requests directly to
  the backend.
* Use memcpy instead of rte_memcpy where compiler complains about it.
* Added const to some function parameters.
v5:
* Moved helper functions back into the header file, for improved
  performance.
* Pass large requests directly to the backend. This also simplifies the
  code.
v4:
* Updated subject to reflect that misleading names are considered bugs.
* Rewrote patch description to provide more details about the bugs fixed.
  (Mattias Rönnblom)
* Moved helper functions, not to be inlined, to mempool C file.
  (Mattias Rönnblom)
* Pass requests for n >= RTE_MEMPOOL_CACHE_MAX_SIZE objects known at build
  time directly to backend driver, to avoid calling the helper functions.
  This also fixes the compiler warnings about out of bounds array access.
v3:
* Removed __attribute__(assume).
v2:
* Removed mempool perf test; not part of patch set.
---
 lib/mempool/rte_mempool.c |   5 +-
 lib/mempool/rte_mempool.h | 108 +++++++++++++++++---------------------
 2 files changed, 50 insertions(+), 63 deletions(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1e4f24783c..cddc896442 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -50,10 +50,9 @@ static void
 mempool_event_callback_invoke(enum rte_mempool_event event,
 			      struct rte_mempool *mp);
 
-/* Note: avoid using floating point since that compiler
- * may not think that is constant.
+/* Note: This is no longer 1.5 * size, but simply 1 * size.
  */
-#define CALC_CACHE_FLUSHTHRESH(c) (((c) * 3) / 2)
+#define CALC_CACHE_FLUSHTHRESH(c) (c)
 
 #if defined(RTE_ARCH_X86)
 /*
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index c495cc012f..de1b41d899 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
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
@@ -848,6 +849,7 @@ rte_mempool_ops_enqueue_bulk(struct rte_mempool *mp, void * const *obj_table,
 	rte_mempool_trace_ops_enqueue_bulk(mp, obj_table, n);
 	ops = rte_mempool_get_ops(mp->ops_index);
 	ret = ops->enqueue(mp, obj_table, n);
+	RTE_ASSERT(ret <= 0);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	if (unlikely(ret < 0))
 		RTE_MEMPOOL_LOG(CRIT, "cannot enqueue %u objects to mempool %s",
@@ -1044,7 +1046,7 @@ rte_mempool_free(struct rte_mempool *mp);
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
  *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5. It is advised to choose
+ *   RTE_MEMPOOL_CACHE_MAX_SIZE and n. It is advised to choose
  *   cache_size to have "n modulo cache_size == 0": if this is
  *   not the case, some elements will always stay in the pool and will
  *   never be used. The access to the per-lcore table is of course
@@ -1333,10 +1335,10 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
 static __rte_always_inline struct rte_mempool_cache *
 rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
 {
-	if (mp->cache_size == 0)
+	if (unlikely(mp->cache_size == 0))
 		return NULL;
 
-	if (lcore_id >= RTE_MAX_LCORE)
+	if (unlikely(lcore_id >= RTE_MAX_LCORE))
 		return NULL;
 
 	rte_mempool_trace_default_cache(mp, lcore_id,
@@ -1383,32 +1385,33 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
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
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->len <= cache->size);
+	if (likely(cache->len + n <= cache->size)) {
+		/* Sufficient room in the cache for the objects. */
 		cache_objs = &cache->objs[cache->len];
 		cache->len += n;
-	} else {
+	} else if (n <= cache->size) {
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
@@ -1512,10 +1515,10 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 {
 	int ret;
 	unsigned int remaining;
-	uint32_t index, len;
+	uint32_t index;
 	void **cache_objs;
 
-	/* No cache provided */
+	/* No cache provided? */
 	if (unlikely(cache == NULL)) {
 		remaining = n;
 		goto driver_dequeue;
@@ -1524,11 +1527,12 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* The cache is a stack, so copy will be in reverse order. */
 	cache_objs = &cache->objs[cache->len];
 
-	if (__rte_constant(n) && n <= cache->len) {
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	if (likely(n <= cache->len)) {
 		/*
-		 * The request size is known at build time, and
-		 * the entire request can be satisfied from the cache,
-		 * so let the compiler unroll the fixed length copy loop.
+		 * The entire request can be satisfied from the cache.
+		 * Note: If the request size is known at build time,
+		 * the compiler will unroll the fixed length copy loop.
 		 */
 		cache->len -= n;
 		for (index = 0; index < n; index++)
@@ -1540,55 +1544,38 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 		return 0;
 	}
 
-	/*
-	 * Use the cache as much as we have to return hot objects first.
-	 * If the request size 'n' is known at build time, the above comparison
-	 * ensures that n > cache->len here, so omit RTE_MIN().
-	 */
-	len = __rte_constant(n) ? cache->len : RTE_MIN(n, cache->len);
-	cache->len -= len;
-	remaining = n - len;
-	for (index = 0; index < len; index++)
+	/* Use the cache as much as we have to return hot objects first. */
+	for (index = 0; index < cache->len; index++)
 		*obj_table++ = *--cache_objs;
+	remaining = n - cache->len;
+	cache->len = 0;
 
-	/*
-	 * If the request size 'n' is known at build time, the case
-	 * where the entire request can be satisfied from the cache
-	 * has already been handled above, so omit handling it here.
-	 */
-	if (!__rte_constant(n) && remaining == 0) {
-		/* The entire request is satisfied from the cache. */
-
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-
-		return 0;
-	}
-
-	/* if dequeue below would overflow mem allocated for cache */
-	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
+	/* The remaining request is too big for the cache? */
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	if (unlikely(remaining > cache->size))
 		goto driver_dequeue;
 
-	/* Fill the cache from the backend; fetch size + remaining objects. */
+	/* Fill the cache from the backend; fetch size / 2 + remaining objects. */
 	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
-			cache->size + remaining);
+			cache->size / 2 + remaining);
 	if (unlikely(ret < 0)) {
 		/*
-		 * We are buffer constrained, and not able to allocate
-		 * cache + remaining.
+		 * We are buffer constrained, and not able to fetch all that.
 		 * Do not fill the cache, just satisfy the remaining part of
 		 * the request directly from the backend.
 		 */
 		goto driver_dequeue;
 	}
 
+	cache->len = cache->size / 2;
+
 	/* Satisfy the remaining part of the request from the filled cache. */
-	cache_objs = &cache->objs[cache->size + remaining];
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	cache_objs = &cache->objs[cache->len + remaining];
 	for (index = 0; index < remaining; index++)
 		*obj_table++ = *--cache_objs;
 
-	cache->len = cache->size;
-
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
@@ -1599,7 +1586,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* Get remaining objects directly from the backend. */
 	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
 
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		if (likely(cache != NULL)) {
 			cache->len = n - remaining;
 			/*
@@ -1619,6 +1606,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
 			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
 		}
+		__rte_assume(ret == 0);
 	}
 
 	return ret;
@@ -1650,7 +1638,7 @@ rte_mempool_generic_get(struct rte_mempool *mp, void **obj_table,
 {
 	int ret;
 	ret = rte_mempool_do_generic_get(mp, obj_table, n, cache);
-	if (ret == 0)
+	if (likely(ret == 0))
 		RTE_MEMPOOL_CHECK_COOKIES(mp, obj_table, n, 1);
 	rte_mempool_trace_generic_get(mp, obj_table, n, cache);
 	return ret;
@@ -1741,7 +1729,7 @@ rte_mempool_get_contig_blocks(struct rte_mempool *mp,
 	int ret;
 
 	ret = rte_mempool_ops_dequeue_contig_blocks(mp, first_obj_table, n);
-	if (ret == 0) {
+	if (likely(ret == 0)) {
 		RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
 		RTE_MEMPOOL_STAT_ADD(mp, get_success_blks, n);
 		RTE_MEMPOOL_CONTIG_BLOCKS_CHECK_COOKIES(mp, first_obj_table, n,
-- 
2.43.0

