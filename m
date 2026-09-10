Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A9C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C9C5427C0;
	Thu, 10 Sep 2026 12:36:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E7C694028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C77BC20631;
 Thu, 10 Sep 2026 12:36:22 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:21 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 6/6] mempool: no cache size limit
Date: Thu, 10 Sep 2026 10:36:13 +0000
Message-ID: <20260910103613.808038-7-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:21.0958 (UTC)
 FILETIME=[38D26E60:01DD4110]
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

Replaced the fixed size object array in the per-lcore local cache
with a variable size array, allocated at mempool creation.
For faster indexing into the per-lcore array of caches, pre-calculate
the size (in bytes) of the per-lcore local cache.

Using a variable size array makes the RTE_MEMPOOL_CACHE_MAX_SIZE build
time configuration parameter superfluous,
but it was kept for compatibility purposes, as it is often used for
the cache_size parameter when creating mempools.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
Supersedes: patch-169235
("[v2] mempool: no cache size limit")
---
 app/test/test_mempool.c                |   2 +-
 doc/guides/rel_notes/release_26_11.rst |  12 ++-
 lib/mempool/rte_mempool.c              | 118 ++++++++++++++-----------
 lib/mempool/rte_mempool.h              |  17 ++--
 4 files changed, 86 insertions(+), 63 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 6ff8746474..8a21b385d9 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -193,7 +193,7 @@ static int test_mempool_creation_with_exceeded_cache_size(void)
 	mp_cov = rte_mempool_create("test_cache_too_big",
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
-		RTE_MEMPOOL_CACHE_MAX_SIZE + 32, 0,
+		MEMPOOL_SIZE + 32, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
 		SOCKET_ID_ANY, 0);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 59b8514360..64f6802e58 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -97,10 +97,20 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* mempool: When creating a mempool, the cache size can be freely specified
+  (although still not exceed the number of elements),
+  and is no longer limited by the ``RTE_MEMPOOL_CACHE_MAX_SIZE`` build time configuration parameter.
+  Although ``RTE_MEMPOOL_CACHE_MAX_SIZE`` has lost its original meaning,
+  it was kept for compatibility purposes,
+  as it is often used for the ``cache_size`` parameter when creating mempools.
+
+* mempool: Updated the ``rte_mempool`` structure as follows:
+  - Added the ``sizeof_cache_per_lcore`` field, for indexing into the per-lcore local cache.
+
 * mempool: Updated the ``rte_mempool_cache`` structure as follows:
   - Removed the deprecated and obsolete ``flushthresh`` field.
   - Removed the ``unused`` field.
-  - Reduced the size of the ``objs`` array from ``RTE_MEMPOOL_CACHE_MAX_SIZE`` * 2 to ``RTE_MEMPOOL_CACHE_MAX_SIZE``.
+  - Changed the ``objs`` array from fixed size to variable size.
 
 ABI Changes
 -----------
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 211763aced..069aabaa70 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -759,20 +759,21 @@ mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 /*
  * Create and initialize a cache for objects that are retrieved from and
  * returned to an underlying mempool. This structure is identical to the
- * local_cache[lcore_id] pointed to by the mempool structure.
+ * local_cache entry pointed to by the mempool structure.
  */
 RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
 rte_mempool_cache_create(uint32_t size, int socket_id)
 {
 	struct rte_mempool_cache *cache;
+	size_t sizeof_cache = sizeof(struct rte_mempool_cache) + size * sizeof(void *);
 
-	if (size == 0 || size > RTE_MEMPOOL_CACHE_MAX_SIZE) {
+	if (size == 0 || sizeof_cache > UINT32_MAX) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
 
-	cache = rte_zmalloc_socket("MEMPOOL_CACHE", sizeof(*cache),
+	cache = rte_zmalloc_socket("MEMPOOL_CACHE", sizeof_cache,
 				  RTE_CACHE_LINE_SIZE, socket_id);
 	if (cache == NULL) {
 		RTE_MEMPOOL_LOG(ERR, "Cannot allocate mempool cache.");
@@ -811,10 +812,9 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	struct rte_mempool *mp = NULL;
 	struct rte_tailq_entry *te = NULL;
 	const struct rte_memzone *mz = NULL;
-	size_t mempool_size;
+	size_t mempool_size, sizeof_cache_per_lcore;
 	unsigned int mz_flags = RTE_MEMZONE_1GB|RTE_MEMZONE_SIZE_HINT_ONLY;
 	struct rte_mempool_objsz objsz;
-	unsigned lcore_id;
 	int ret;
 
 	/* compilation-time checks */
@@ -822,6 +822,8 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 			  RTE_CACHE_LINE_MASK) != 0);
 	RTE_BUILD_BUG_ON((sizeof(struct rte_mempool_cache) &
 			  RTE_CACHE_LINE_MASK) != 0);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mempool_cache, objs) !=
+			  sizeof(struct rte_mempool_cache));
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	RTE_BUILD_BUG_ON((sizeof(struct rte_mempool_debug_stats) &
 			  RTE_CACHE_LINE_MASK) != 0);
@@ -838,7 +840,18 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	}
 
 	/* asked cache too big */
-	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE ||
+	sizeof_cache_per_lcore = 0;
+	if (cache_size != 0) {
+		sizeof_cache_per_lcore = sizeof(struct rte_mempool_cache);
+		sizeof_cache_per_lcore += RTE_CACHE_LINE_ROUNDUP(cache_size * sizeof(void *));
+		/*
+		 * Add padding, to guard against false sharing-like effects
+		 * on systems with a next-N-lines hardware prefetcher, when
+		 * accessing objects at the end of the cache.
+		 */
+		sizeof_cache_per_lcore += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
+	}
+	if (sizeof_cache_per_lcore > UINT32_MAX ||
 	    cache_size > n) {
 		rte_errno = EINVAL;
 		return NULL;
@@ -890,8 +903,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	mempool_size = sizeof(struct rte_mempool);
 	mempool_size += private_data_size;
-	if (cache_size != 0)
-		mempool_size += RTE_MAX_LCORE * sizeof(struct rte_mempool_cache);
+	mempool_size += RTE_MAX_LCORE * sizeof_cache_per_lcore;
 
 	ret = snprintf(mz_name, sizeof(mz_name), RTE_MEMPOOL_MZ_FORMAT, name);
 	if (ret < 0 || ret >= (int)sizeof(mz_name)) {
@@ -918,7 +930,6 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	mp->elt_size = objsz.elt_size;
 	mp->header_size = objsz.header_size;
 	mp->trailer_size = objsz.trailer_size;
-	/* Size of default caches, zero means disabled. */
 	mp->cache_size = cache_size;
 	mp->private_data_size = private_data_size;
 	STAILQ_INIT(&mp->elt_list);
@@ -942,18 +953,17 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	/*
-	 * local_cache pointer is set even if cache_size is zero.
-	 * The local_cache points to just past the private data.
-	 */
-	mp->local_cache = (struct rte_mempool_cache *)
-		RTE_PTR_ADD(mp, sizeof(struct rte_mempool) + private_data_size);
-
-	/* Init all default caches. */
+	/* local_cache pointer is only set if per-lcore local cache is present */
 	if (cache_size != 0) {
-		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++)
-			mempool_cache_init(&mp->local_cache[lcore_id],
-					   cache_size);
+		mp->local_cache = (struct rte_mempool_cache *)
+			RTE_PTR_ADD(mp, sizeof(struct rte_mempool) + private_data_size);
+		mp->sizeof_cache_per_lcore = sizeof_cache_per_lcore;
+
+		/* Init all default caches. */
+		struct rte_mempool_cache *cache = mp->local_cache;
+		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+				lcore_id++, cache = RTE_PTR_ADD(cache, sizeof_cache_per_lcore))
+			mempool_cache_init(cache, cache_size);
 	}
 
 	te->data = mp;
@@ -1016,16 +1026,17 @@ RTE_EXPORT_SYMBOL(rte_mempool_avail_count)
 unsigned int
 rte_mempool_avail_count(const struct rte_mempool *mp)
 {
-	unsigned count;
-	unsigned lcore_id;
+	unsigned int count;
 
 	count = rte_mempool_ops_get_count(mp);
 
-	if (mp->cache_size == 0)
+	if (mp->local_cache == NULL)
 		return count;
 
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++)
-		count += mp->local_cache[lcore_id].len;
+	const struct rte_mempool_cache *cache = mp->local_cache;
+	for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+			lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore))
+		count += cache->len;
 
 	/*
 	 * due to race condition (access to len is not locked), the
@@ -1053,11 +1064,11 @@ rte_mempool_stats_reset(struct rte_mempool *mp)
 
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	memset(&mp->stats, 0, sizeof(mp->stats));
-	if (mp->cache_size != 0) {
-		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-			memset(&mp->local_cache[lcore_id].stats, 0,
-					sizeof(mp->local_cache[lcore_id].stats));
-		}
+	if (mp->local_cache != NULL) {
+		struct rte_mempool_cache *cache = mp->local_cache;
+		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+				lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore))
+			memset(&cache->stats, 0, sizeof(cache->stats));
 	}
 
 	RTE_MEMPOOL_LOG(DEBUG, "<%s>@%p: statistics reset", mp->name, mp);
@@ -1071,18 +1082,18 @@ rte_mempool_stats_reset(struct rte_mempool *mp)
 static unsigned
 rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 {
-	unsigned lcore_id;
-	unsigned count = 0;
-	unsigned cache_count;
+	unsigned int count = 0;
 
 	fprintf(f, "  internal cache infos (hide zero value items):\n");
 	fprintf(f, "    cache_size=%"PRIu32"\n", mp->cache_size);
 
-	if (mp->cache_size == 0)
+	if (mp->local_cache == NULL)
 		return count;
 
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		cache_count = mp->local_cache[lcore_id].len;
+	const struct rte_mempool_cache *cache = mp->local_cache;
+	for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+			lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore)) {
+		unsigned int cache_count = cache->len;
 		if (cache_count == 0)
 			continue;
 		fprintf(f, "    cache_count[%u]=%"PRIu32"\n",
@@ -1223,15 +1234,13 @@ mempool_audit_cookies(struct rte_mempool *mp)
 static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
-	unsigned lcore_id;
-
-	if (mp->cache_size == 0)
+	if (mp->local_cache == NULL)
 		return;
 
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		const struct rte_mempool_cache *cache;
-		cache = &mp->local_cache[lcore_id];
-		if (cache->size > RTE_DIM(cache->objs)) {
+	const struct rte_mempool_cache *cache = mp->local_cache;
+	for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+			lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore)) {
+		if (cache->size > mp->size) {
 			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] size", lcore_id);
 			rte_panic("MEMPOOL: invalid cache[%u] size\n", lcore_id);
 		}
@@ -1324,13 +1333,15 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 		sum.get_success_blks += mp->stats[lcore_id].get_success_blks;
 		sum.get_fail_blks += mp->stats[lcore_id].get_fail_blks;
 	}
-	if (mp->cache_size != 0) {
+	if (mp->local_cache != NULL) {
 		/* Add the statistics stored in the mempool caches. */
-		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-			sum.put_bulk += mp->local_cache[lcore_id].stats.put_bulk;
-			sum.put_objs += mp->local_cache[lcore_id].stats.put_objs;
-			sum.get_success_bulk += mp->local_cache[lcore_id].stats.get_success_bulk;
-			sum.get_success_objs += mp->local_cache[lcore_id].stats.get_success_objs;
+		const struct rte_mempool_cache *cache = mp->local_cache;
+		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+			lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore)) {
+			sum.put_bulk += cache->stats.put_bulk;
+			sum.put_objs += cache->stats.put_objs;
+			sum.get_success_bulk += cache->stats.get_success_bulk;
+			sum.get_success_objs += cache->stats.get_success_objs;
 		}
 	}
 	fprintf(f, "  stats:\n");
@@ -1627,10 +1638,11 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 				  mp->populated_size);
 
 	cache_count = 0;
-	if (mp->cache_size > 0) {
-		int lcore_id;
-		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++)
-			cache_count += mp->local_cache[lcore_id].len;
+	if (mp->local_cache != NULL) {
+		const struct rte_mempool_cache *cache = mp->local_cache;
+		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+				lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore))
+			cache_count += cache->len;
 	}
 	rte_tel_data_add_dict_uint(info->d, "total_cache_count", cache_count);
 	common_count = rte_mempool_ops_get_count(mp);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 5a81e53a9f..5fc7cdb79c 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -105,8 +105,7 @@ struct __rte_cache_aligned rte_mempool_cache {
 	} stats;                        /**< Statistics */
 #endif
 	/** Cache objects */
-	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
-	RTE_CACHE_GUARD;
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[];
 };
 
 /**
@@ -265,6 +264,7 @@ struct __rte_cache_aligned rte_mempool {
 	int32_t ops_index;
 
 	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
+	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing into the local cache. */
 
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
@@ -1050,8 +1050,7 @@ rte_mempool_free(struct rte_mempool *mp);
  * @param cache_size
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
- *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n.
+ *   per-lcore object cache. This argument must be lower or equal to n.
  *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
@@ -1371,15 +1370,17 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
 static __rte_always_inline struct rte_mempool_cache *
 rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
 {
-	if (unlikely(mp->cache_size == 0))
+	if (unlikely(mp->local_cache == NULL))
 		return NULL;
 
 	if (unlikely(lcore_id == LCORE_ID_ANY))
 		return NULL;
 
-	rte_mempool_trace_default_cache(mp, lcore_id,
-		&mp->local_cache[lcore_id]);
-	return &mp->local_cache[lcore_id];
+	struct rte_mempool_cache *cache = (struct rte_mempool_cache *)RTE_PTR_ADD(mp->local_cache,
+			lcore_id * (size_t)mp->sizeof_cache_per_lcore);
+	rte_mempool_trace_default_cache(mp, lcore_id, cache);
+	__rte_assume(cache != NULL);
+	return cache;
 }
 
 /**
-- 
2.43.0

