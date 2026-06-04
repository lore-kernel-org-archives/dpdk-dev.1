Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5CBCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 11:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF5D402CC;
	Thu,  4 Jun 2026 13:49:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D9AEC402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 13:49:00 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 69A59222DE;
 Thu,  4 Jun 2026 13:49:00 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 4 Jun 2026 13:48:58 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v8] mempool: improve cache behaviour and performance
Date: Thu,  4 Jun 2026 11:48:51 +0000
Message-ID: <20260604114851.12586-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408141315.904381-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Jun 2026 11:48:58.0559 (UTC)
 FILETIME=[21137CF0:01DCF418]
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
cache->flushthresh, when considering the capacity of the cache.
The cache->flushthresh field is kept for API/ABI compatibility purposes,
and initialized to cache->size instead of cache->size * 1.5.

(2) was improved by generally comparing to cache->size / 2 instead of
RTE_MEMPOOL_CACHE_MAX_SIZE, when checking the bounce buffer limit.

(3) was improved by flushing and replenishing the cache by half its size,
so a flush/refill can be followed randomly by get or put requests.
This also reduced the number of objects in each flush/refill operation.

As a consequence of these changes, the size of the array holding the
objects in the cache (cache->objs[]) no longer needs to be
2 * RTE_MEMPOOL_CACHE_MAX_SIZE, and can be reduced to
RTE_MEMPOOL_CACHE_MAX_SIZE at an API/ABI breaking release.

Performance data:
With a real WAN Optimization application, where the number of allocated
packets varies (as they are held in e.g. shaper queues), the mempool
cache miss rate dropped from ca. 1/20 objects to ca. 1/48 objects.
This was deployed in production at an ISP, and using an effective cache
size of 384 objects.

Bugzilla ID: 1027
Fixes: ea5dd2744b90 ("mempool: cache optimisations")
Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
v8:
* Rebased.
  CI cannot apply the patch when the release notes have changed at the tip
  of main. Hoping to win the race this time.
v7:
* Rebased. Dependency no longer required. (Thomas)
v6:
* Moved driver changes out as separate patches, for easier review. (Bruce)
  Tests using the Intel idpf PMD in AVX512 mode may fail with this patch.
* Reverted a small code comment change. The original was better. (Bruce)
* Reverted rte_mempool_create() description requiring the cache_size to be
  an even number. There is no such requirement.
v5:
* Flush the cache from the bottom, where objects are colder, and move down
  the remaining objects, which are hotter.
* In the Intel idpf PMD, move up the hot objects in the cache and refill
  with cold objects at the bottom.
v4:
* Added Bugzilla ID.
* Added Fixes tag. For reference only.
* Moved fast-free related update of Intel common driver out as a separate
  patch, and depend on that patch.
* Omitted unrelated changes to the Intel idpf AVX512 driver, specifically
  fixing an indentation and adding mbuf instrumentation.
* Omitted unrelated changes to the mempool library, specifically adding
  __rte_restrict and changing a couple of comments to proper sentences.
* Please checkpatches by swapping operators in a couple of comparisons.
v3:
* Fixed my copy-paste bug in idpf_splitq_rearm().
v2:
* Fixed issue found by abidiff:
  Reverted cache objects array size reduction. Added a note instead.
* Added missing mbuf instrumentation to the Intel idpf AVX512 driver.
* Updated idpf_splitq_rearm() like idpf_singleq_rearm().
* Added a few more __rte_assume(). (Inspired by AI review)
* Updated NXP dpaa and dpaa2 mempool drivers to not set mempool cache
  flush threshold.
* Added release notes.
* Added deprecation notes.
---
 doc/guides/rel_notes/deprecation.rst   |  7 +++
 doc/guides/rel_notes/release_26_07.rst | 11 +++++
 lib/mempool/rte_mempool.c              | 14 +-----
 lib/mempool/rte_mempool.h              | 66 ++++++++++++++++----------
 4 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..1b6cc181fb 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -158,3 +158,10 @@ Deprecation Notices
 * net/iavf: The dynamic mbuf field used to detect LLDP packets on the
   transmit path in the iavf PMD will be removed in a future release.
   After removal, only packet type-based detection will be supported.
+
+* mempool: The ``flushthresh`` field in ``struct rte_mempool_cache``
+  is obsolete, and will be removed in DPDK 26.11.
+
+* mempool: The object array in ``struct rte_mempool_cache`` is oversize by
+  factor two, and will be reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE`` in
+  DPDK 26.11.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index d2563ac503..b1010d238f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -69,6 +69,17 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Changed effective size of mempool cache.**
+
+  * The effective size of a mempool cache was changed to match the specified size at mempool creation; the effective size was previously 50 % larger than requested.
+  * The ``flushthresh`` field of the ``struct rte_mempool_cache`` became obsolete, but was kept for API/ABI compatibility purposes.
+  * The effective size of the ``objs`` array in the ``struct rte_mempool_cache`` was reduced to ``RTE_MEMPOOL_CACHE_MAX_SIZE``, but its size was kept for API/ABI compatibility purposes.
+
+* **Improved mempool cache flush/refill algorithm.**
+
+  The mempool cache flush/refill algorithm was improved, to reduce the mempool cache miss rate for most application types.
+  Applications where each lcore only puts or gets to a mempool, e.g. pipelined applications where ethdev Rx and Tx run on separate lcores, should adapt to the new algorithm by doubling their configured mempool cache size, to avoid doubling their mempool cache miss rate.
+
 * **Added RISC-V vector paths.**
 
   * Increased the default SIMD bitwidth to allow using the vector extension.
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 3ddf7b9c11..817e2b8dc1 100644
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
index d3f969847b..50d958c7c6 100644
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
@@ -107,8 +107,10 @@ struct __rte_cache_aligned rte_mempool_cache {
 	/**
 	 * Cache objects
 	 *
-	 * Cache is allocated to this size to allow it to overflow in certain
-	 * cases to avoid needless emptying of cache.
+	 * Note:
+	 * Cache is allocated at double size for API/ABI compatibility purposes only.
+	 * When reducing its size at an API/ABI breaking release,
+	 * remember to add a cache guard after it.
 	 */
 	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
 };
@@ -1047,11 +1049,16 @@ rte_mempool_free(struct rte_mempool *mp);
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
@@ -1419,22 +1426,30 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
 
-	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	__rte_assume(cache->len <= cache->flushthresh);
-	if (likely(cache->len + n <= cache->flushthresh)) {
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
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
+		 * flush (size / 2) objects from the bottom of the cache, where
+		 * objects are less hot, and move down the remaining objects, which
+		 * are more hot, from the upper half of the cache.
 		 */
-		cache_objs = &cache->objs[0];
-		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
-		cache->len = n;
+		__rte_assume(cache->len > cache->size / 2);
+		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / 2);
+		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
+				sizeof(void *) * (cache->len - cache->size / 2));
+		cache_objs = &cache->objs[cache->len - cache->size / 2];
+		cache->len = cache->len - cache->size / 2 + n;
 	} else {
 		/* The request itself is too big for the cache. */
 		goto driver_enqueue_stats_incremented;
@@ -1553,7 +1568,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* The cache is a stack, so copy will be in reverse order. */
 	cache_objs = &cache->objs[cache->len];
 
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	if (likely(n <= cache->len)) {
 		/* The entire request can be satisfied from the cache. */
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
@@ -1577,13 +1592,13 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
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
@@ -1597,10 +1612,11 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
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
 
-- 
2.43.0

