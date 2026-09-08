Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53811C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F503402DF;
	Tue,  8 Sep 2026 17:14:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DFE544028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 17:14:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C489A2041E;
 Tue,  8 Sep 2026 17:14:22 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 8 Sep 2026 17:14:22 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mempool: no cache size limit
Date: Tue,  8 Sep 2026 15:14:15 +0000
Message-ID: <20260908151415.376092-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907120605.969197-1-mb@smartsharesystems.com>
References: <20260907120605.969197-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2026 15:14:22.0395 (UTC)
 FILETIME=[BA4FA0B0:01DD3FA4]
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

Replaced the object array of fixed size in the per-lcore local cache
with a dynamically sized array, thereby making the
RTE_MEMPOOL_CACHE_MAX_SIZE superfluous.
For faster indexing into the per-lcore array of caches, pre-calculate
the size (in bytes) of the per-lcore local cache.

Also swapped the position of the private data and the local caches;
the private data now are positioned before the local caches, instead
of after. This is how the mempool API was documented, but I don't think
it warrants a Fixes tag, as it has been implemented the other way around
for a long time.
Positioning the private data directly after the mempool header reduces
getting the private data pointer to simply adding a constant.
The local caches are accessed by dereferencing a pointer anyway, so the
performance for accessing these is unaffected by moving their position.

And annotated cache_alloc/free as alloc/free functions.

Comments, please?

We should probably keep RTE_MEMPOOL_CACHE_MAX_SIZE in rte_config.h,
and deprecate it as obsolete.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Fixed bugs.
* Annotated cache_alloc/free as alloc/free functions.
---
 app/test/test_mempool.c   |  19 ++++---
 lib/mempool/rte_mempool.c | 114 +++++++++++++++++++-------------------
 lib/mempool/rte_mempool.h |  70 +++++++++++------------
 3 files changed, 100 insertions(+), 103 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..83809ec257 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -96,6 +96,9 @@ test_mempool_basic(struct rte_mempool *mp, int use_external_cache)
 		cache = rte_mempool_default_cache(mp, rte_lcore_id());
 	}
 
+	printf("test %s\n", use_external_cache ? "using external cache" :
+			cache != NULL ? "using cache" : "without cache");
+
 	/* dump the mempool status */
 	rte_mempool_dump(stdout, mp);
 
@@ -113,7 +116,7 @@ test_mempool_basic(struct rte_mempool *mp, int use_external_cache)
 
 	printf("get private data\n");
 	if (rte_mempool_get_priv(mp) != (char *)mp +
-			RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size))
+			sizeof(struct rte_mempool))
 		GOTO_ERR(ret, out);
 
 #ifndef RTE_EXEC_ENV_FREEBSD /* rte_mem_virt2iova() not supported on bsd */
@@ -191,10 +194,10 @@ static int test_mempool_creation_with_exceeded_cache_size(void)
 {
 	struct rte_mempool *mp_cov;
 
-	mp_cov = rte_mempool_create("test_mempool_cache_too_big",
+	mp_cov = rte_mempool_create("cache_too_big",
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
-		RTE_MEMPOOL_CACHE_MAX_SIZE + 32, 0,
+		MEMPOOL_SIZE + 32, 0,
 		NULL, NULL,
 		my_obj_init, NULL,
 		SOCKET_ID_ANY, 0);
@@ -211,7 +214,7 @@ static int test_mempool_creation_with_invalid_flags(void)
 {
 	struct rte_mempool *mp_cov;
 
-	mp_cov = rte_mempool_create("test_mempool_invalid_flags", MEMPOOL_SIZE,
+	mp_cov = rte_mempool_create("invalid_flags", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
@@ -333,7 +336,7 @@ test_mempool_sp_sc(void)
 
 	/* create a mempool with single producer/consumer ring */
 	if (mp_spsc == NULL) {
-		mp_spsc = rte_mempool_create("test_mempool_sp_sc", MEMPOOL_SIZE,
+		mp_spsc = rte_mempool_create("sp_sc", MEMPOOL_SIZE,
 			MEMPOOL_ELT_SIZE, 0, 0,
 			my_mp_init, NULL,
 			my_obj_init, NULL,
@@ -343,7 +346,7 @@ test_mempool_sp_sc(void)
 		if (mp_spsc == NULL)
 			RET_ERR();
 	}
-	if (rte_mempool_lookup("test_mempool_sp_sc") != mp_spsc) {
+	if (rte_mempool_lookup("sp_sc") != mp_spsc) {
 		printf("Cannot lookup mempool from its name\n");
 		ret = -1;
 		goto err;
@@ -440,7 +443,7 @@ test_mempool_same_name_twice_creation(void)
 {
 	struct rte_mempool *mp_tc, *mp_tc2;
 
-	mp_tc = rte_mempool_create("test_mempool_same_name", MEMPOOL_SIZE,
+	mp_tc = rte_mempool_create("same_name", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
@@ -449,7 +452,7 @@ test_mempool_same_name_twice_creation(void)
 	if (mp_tc == NULL)
 		RET_ERR();
 
-	mp_tc2 = rte_mempool_create("test_mempool_same_name", MEMPOOL_SIZE,
+	mp_tc2 = rte_mempool_create("same_name", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..5e21d34e04 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -760,7 +760,7 @@ mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 /*
  * Create and initialize a cache for objects that are retrieved from and
  * returned to an underlying mempool. This structure is identical to the
- * local_cache[lcore_id] pointed to by the mempool structure.
+ * local_cache pointed to by the mempool structure.
  */
 RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
@@ -768,13 +768,14 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
 {
 	struct rte_mempool_cache *cache;
 
-	if (size == 0 || size > RTE_MEMPOOL_CACHE_MAX_SIZE) {
+	if (size == 0 || sizeof(struct rte_mempool_cache) + size * sizeof(void *) > UINT32_MAX) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
 
-	cache = rte_zmalloc_socket("MEMPOOL_CACHE", sizeof(*cache),
-				  RTE_CACHE_LINE_SIZE, socket_id);
+	cache = rte_zmalloc_socket("MEMPOOL_CACHE",
+			sizeof(struct rte_mempool_cache) + size * sizeof(void *),
+			RTE_CACHE_LINE_SIZE, socket_id);
 	if (cache == NULL) {
 		RTE_MEMPOOL_LOG(ERR, "Cannot allocate mempool cache.");
 		rte_errno = ENOMEM;
@@ -812,10 +813,9 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
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
@@ -823,6 +823,8 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 			  RTE_CACHE_LINE_MASK) != 0);
 	RTE_BUILD_BUG_ON((sizeof(struct rte_mempool_cache) &
 			  RTE_CACHE_LINE_MASK) != 0);
+	RTE_BUILD_BUG_ON((offsetof(struct rte_mempool_cache, objs) &
+			  RTE_CACHE_LINE_MASK) != 0);
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	RTE_BUILD_BUG_ON((sizeof(struct rte_mempool_debug_stats) &
 			  RTE_CACHE_LINE_MASK) != 0);
@@ -839,7 +841,9 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	}
 
 	/* asked cache too big */
-	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE ||
+	sizeof_cache_per_lcore = cache_size != 0 ? RTE_CACHE_LINE_ROUNDUP(
+			sizeof(struct rte_mempool_cache) + cache_size * sizeof(void *)) : 0;
+	if (sizeof_cache_per_lcore > UINT32_MAX ||
 	    cache_size > n) {
 		rte_errno = EINVAL;
 		return NULL;
@@ -873,9 +877,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	 * reserve a memory zone for this mempool: private data is
 	 * cache-aligned
 	 */
-	private_data_size = (private_data_size +
-			     RTE_MEMPOOL_ALIGN_MASK) & (~RTE_MEMPOOL_ALIGN_MASK);
-
+	private_data_size = RTE_CACHE_LINE_ROUNDUP(private_data_size);
 
 	/* try to allocate tailq entry */
 	te = rte_zmalloc("MEMPOOL_TAILQ_ENTRY", sizeof(*te), 0);
@@ -884,9 +886,9 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	mempool_size = RTE_MEMPOOL_HEADER_SIZE(mp, cache_size);
+	mempool_size = sizeof(struct rte_mempool);
 	mempool_size += private_data_size;
-	mempool_size = RTE_ALIGN_CEIL(mempool_size, RTE_MEMPOOL_ALIGN);
+	mempool_size += RTE_MAX_LCORE * sizeof_cache_per_lcore;
 
 	ret = snprintf(mz_name, sizeof(mz_name), RTE_MEMPOOL_MZ_FORMAT, name);
 	if (ret < 0 || ret >= (int)sizeof(mz_name)) {
@@ -900,7 +902,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/* init the mempool structure */
 	mp = mz->addr;
-	memset(mp, 0, RTE_MEMPOOL_HEADER_SIZE(mp, cache_size));
+	memset(mp, 0, sizeof(struct rte_mempool) + private_data_size);
 	ret = strlcpy(mp->name, name, sizeof(mp->name));
 	if (ret < 0 || ret >= (int)sizeof(mp->name)) {
 		rte_errno = ENAMETOOLONG;
@@ -913,7 +915,6 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	mp->elt_size = objsz.elt_size;
 	mp->header_size = objsz.header_size;
 	mp->trailer_size = objsz.trailer_size;
-	/* Size of default caches, zero means disabled. */
 	mp->cache_size = cache_size;
 	mp->private_data_size = private_data_size;
 	STAILQ_INIT(&mp->elt_list);
@@ -937,18 +938,17 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	/*
-	 * local_cache pointer is set even if cache_size is zero.
-	 * The local_cache points to just past the elt_pa[] array.
-	 */
-	mp->local_cache = (struct rte_mempool_cache *)
-		RTE_PTR_ADD(mp, RTE_MEMPOOL_HEADER_SIZE(mp, 0));
-
-	/* Init all default caches. */
+	/* local_cache pointer is only set if local cache is allocated. */
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
@@ -1012,15 +1012,16 @@ unsigned int
 rte_mempool_avail_count(const struct rte_mempool *mp)
 {
 	unsigned count;
-	unsigned lcore_id;
 
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
@@ -1048,11 +1049,11 @@ rte_mempool_stats_reset(struct rte_mempool *mp)
 
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
@@ -1066,18 +1067,18 @@ rte_mempool_stats_reset(struct rte_mempool *mp)
 static unsigned
 rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 {
-	unsigned lcore_id;
 	unsigned count = 0;
-	unsigned cache_count;
 
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
@@ -1218,15 +1219,13 @@ static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
 	/* check cache size consistency */
-	unsigned lcore_id;
-
-	if (mp->cache_size == 0)
+	if (mp->local_cache == NULL)
 		return;
 
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		const struct rte_mempool_cache *cache;
-		cache = &mp->local_cache[lcore_id];
-		if (cache->len > RTE_DIM(cache->objs)) {
+	const struct rte_mempool_cache *cache = mp->local_cache;
+	for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE;
+			lcore_id++, cache = RTE_PTR_ADD(cache, mp->sizeof_cache_per_lcore)) {
+		if (cache->len > cache->size) {
 			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u]",
 				lcore_id);
 			rte_panic("MEMPOOL: invalid cache len\n");
@@ -1319,13 +1318,15 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
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
@@ -1624,10 +1625,11 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
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
index 50d958c7c6..57256894d8 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -104,15 +104,8 @@ struct __rte_cache_aligned rte_mempool_cache {
 		uint64_t get_success_objs;  /**< Objects successfully allocated. */
 	} stats;                        /**< Statistics */
 #endif
-	/**
-	 * Cache objects
-	 *
-	 * Note:
-	 * Cache is allocated at double size for API/ABI compatibility purposes only.
-	 * When reducing its size at an API/ABI breaking release,
-	 * remember to add a cache guard after it.
-	 */
-	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
+	/** Cache objects */
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[];
 };
 
 /**
@@ -258,6 +251,7 @@ struct __rte_cache_aligned rte_mempool {
 	int32_t ops_index;
 
 	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
+	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing into the local cache. */
 
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
@@ -271,8 +265,18 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	struct rte_mempool_debug_stats stats[RTE_MAX_LCORE + 1];
 #endif
+
+	/** Padding to ensure mempool header size is cache line aligned. */
+	__extension__ alignas(RTE_CACHE_LINE_SIZE) char cache_line_padding[0];
+	/*
+	 * Private data area is located immediately after the mempool header.
+	 * Per-lcore local cache, if present, is located immediately after the private data area.
+	 */
 };
 
+static_assert((sizeof(struct rte_mempool) & RTE_CACHE_LINE_MASK) == 0,
+		"mempool header size not cache line aligned");
+
 /** Spreading among memory channels not required. */
 #define RTE_MEMPOOL_F_NO_SPREAD		0x0001
 /**
@@ -362,18 +366,6 @@ struct __rte_cache_aligned rte_mempool {
 #define RTE_MEMPOOL_CACHE_STAT_ADD(cache, name, n) do {} while (0)
 #endif
 
-/**
- * @internal Calculate the size of the mempool header.
- *
- * @param mp
- *   Pointer to the memory pool.
- * @param cs
- *   Size of the per-lcore cache.
- */
-#define RTE_MEMPOOL_HEADER_SIZE(mp, cs) \
-	(sizeof(*(mp)) + (((cs) == 0) ? 0 : \
-	(sizeof(struct rte_mempool_cache) * RTE_MAX_LCORE)))
-
 /* return the header of a mempool object (internal) */
 static inline struct rte_mempool_objhdr *
 rte_mempool_get_header(void *obj)
@@ -1048,8 +1040,7 @@ rte_mempool_free(struct rte_mempool *mp);
  * @param cache_size
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
- *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n.
+ *   per-lcore object cache. This argument must be lower or equal to n.
  *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
@@ -1328,6 +1319,15 @@ void rte_mempool_stats_reset(struct rte_mempool *mp);
  */
 void rte_mempool_dump(FILE *f, struct rte_mempool *mp);
 
+/**
+ * Free a user-owned mempool cache.
+ *
+ * @param cache
+ *   A pointer to the mempool cache.
+ */
+void
+rte_mempool_cache_free(struct rte_mempool_cache *cache);
+
 /**
  * Create a user-owned mempool cache.
  *
@@ -1343,16 +1343,8 @@ void rte_mempool_dump(FILE *f, struct rte_mempool *mp);
  *   SOCKET_ID_ANY if there is no NUMA constraint for the reserved zone.
  */
 struct rte_mempool_cache *
-rte_mempool_cache_create(uint32_t size, int socket_id);
-
-/**
- * Free a user-owned mempool cache.
- *
- * @param cache
- *   A pointer to the mempool cache.
- */
-void
-rte_mempool_cache_free(struct rte_mempool_cache *cache);
+rte_mempool_cache_create(uint32_t size, int socket_id)
+	__rte_malloc __rte_dealloc(rte_mempool_cache_free, 1);
 
 /**
  * Get a pointer to the per-lcore default mempool cache.
@@ -1368,15 +1360,16 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
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
+	return cache;
 }
 
 /**
@@ -1892,8 +1885,7 @@ void rte_mempool_audit(struct rte_mempool *mp);
  */
 static inline void *rte_mempool_get_priv(struct rte_mempool *mp)
 {
-	return (char *)mp +
-		RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size);
+	return (void *)(mp + 1);
 }
 
 /**
-- 
2.43.0

