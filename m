Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8C3C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9414B4068E;
	Wed, 12 Aug 2026 11:58:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CAF24402B8
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:58:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A081222820;
 Wed, 12 Aug 2026 11:58:39 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 12 Aug 2026 11:58:39 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v2] mempool: optimizations
Date: Wed, 12 Aug 2026 09:58:36 +0000
Message-ID: <20260812095836.1771949-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Aug 2026 09:58:39.0422 (UTC)
 FILETIME=[264415E0:01DD2A41]
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

This patch introduces some mempool optimizations, which might be
controvesial.

1. Access local cache without first accessing the mempool header struct.

When getting/putting objects in a mempool cache, it required accessing
the "size" field and "local_cache" pointer in the mempool structure, to
determine if the local cache was present.

The mempool structure was changed, so the local cache array is now an
integral part of the mempool structure.
This means that local cache can be accessed directly, without first
checking the "size" and "local_cache" fields in the mempool header
structure.
This avoids a couple of load operations with a potential CPU cache miss
when the mempool header itself is not hot in the CPU cache.
The "local_cache" field was changed from being a pointer to the local
cache array, and instead became the local cache array itself.

This change similarly speeds up rte_mempool_get_priv(), because it no
longer needs to access the mempool header structure (specifically, the
"cache_size" field) to determine the address of the mempool's private
data.

Disadvantage: Memory for local cache is also consumed by mempools
configured without cache.

Related changes:
- The mempool cache audit function was improved.
- The mempool autotest accessed the internal RTE_MEMPOOL_HEADER_SIZE
  macro, and was updated accordingly.

2. Move objects in mempool cache as 32-byte chunks at CPU cache line
   aligned addresses.

Improved memory copy performance by ensuring that objects in mempool cache
can be moved as 32-byte chunks at CPU cache line aligned addresses.

Disadvantage: Mempool cache size must be divisible by 32.
For compatibility purposes, a requested cache size not divisible by 32
is handled by a graceful fallback at mempool cache creation and
mempool creation.

Related changes:
- The TAP driver used a mempool cache size of 4 mbufs for GSO,
  and was updated to a cache size of 32 mbufs.

Other changes:
- The description of the RTE_MEMPOOL_NAMESIZE macro was expanded to
  explain how the value is derived.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Removed patch dependency, and included dependent patch instead.
  Trying to fix apply patch failure.
---
 app/test/test_mempool.c                 |  3 +-
 doc/guides/rel_notes/release_26_11.rst  |  6 ++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c |  2 +-
 drivers/net/tap/rte_eth_tap.c           |  2 +-
 lib/eal/include/rte_common.h            | 12 +++
 lib/mempool/mempool_trace.h             |  1 -
 lib/mempool/rte_mempool.c               | 76 +++++++++++++------
 lib/mempool/rte_mempool.h               | 97 ++++++++++++++-----------
 8 files changed, 131 insertions(+), 68 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..76d45cea2a 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -112,8 +112,7 @@ test_mempool_basic(struct rte_mempool *mp, int use_external_cache)
 		GOTO_ERR(ret, out);
 
 	printf("get private data\n");
-	if (rte_mempool_get_priv(mp) != (char *)mp +
-			RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size))
+	if (rte_mempool_get_priv(mp) != (char *)mp + sizeof(struct rte_mempool))
 		GOTO_ERR(ret, out);
 
 #ifndef RTE_EXEC_ENV_FREEBSD /* rte_mem_virt2iova() not supported on bsd */
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..e31325585a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,8 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* mempool: The obsolete ``flushthresh`` field was removed from the ``rte_mempool_cache`` structure.
+
 * Removed deprecated symbols:
 
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
@@ -93,6 +95,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* mempool: The ``rte_mempool_cache`` structure was updated as follows:
+  - The obsolete ``flushthresh`` field was removed.
+  - The size of the ``objs`` array was reduced from ``RTE_MEMPOOL_CACHE_MAX_SIZE`` * 2 to ``RTE_MEMPOOL_CACHE_MAX_SIZE``.
+
 
 ABI Changes
 -----------
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
index a830c7a33b..2e680f4027 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -67,7 +67,7 @@ static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_q
 		}
 		cache->len += rs_thresh;
 
-		if (cache->len >= cache->flushthresh) {
+		if (cache->len >= cache->size) {
 			(void)rte_mempool_ops_enqueue_bulk(mp,
 					&cache->objs[cache->size], cache->len - cache->size);
 			cache->len = cache->size;
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index b93452f168..b3142561c2 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -61,7 +61,7 @@
 #define TAP_MAX_MAC_ADDRS	16
 #define TAP_GSO_MBUFS_PER_CORE	128
 #define TAP_GSO_MBUF_SEG_SIZE	128
-#define TAP_GSO_MBUF_CACHE_SIZE	4
+#define TAP_GSO_MBUF_CACHE_SIZE	32
 #define TAP_GSO_MBUFS_NUM \
 	(TAP_GSO_MBUFS_PER_CORE * TAP_GSO_MBUF_CACHE_SIZE)
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..0fd0906506 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -567,6 +567,15 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_assume(condition) __assume(condition)
 #endif
 
+/**
+ * Alignment hint precondition
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_assume_aligned(ptr, alignment) (ptr)
+#else
+#define __rte_assume_aligned(ptr, alignment) __builtin_assume_aligned(ptr, alignment)
+#endif
+
 /**
  * Disable AddressSanitizer on some code
  */
@@ -775,6 +784,9 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
 /** Force minimum cache line alignment. */
 #define __rte_cache_min_aligned __rte_aligned(RTE_CACHE_LINE_MIN_SIZE)
 
+/** Cache alignment hint precondition */
+#define __rte_assume_cache_aligned(ptr) __rte_assume_aligned(ptr, RTE_CACHE_LINE_SIZE)
+
 #define _RTE_CACHE_GUARD_HELPER2(unique) \
 	alignas(RTE_CACHE_LINE_SIZE) \
 	char cache_guard_ ## unique[RTE_CACHE_LINE_SIZE * RTE_CACHE_GUARD_LINES]
diff --git a/lib/mempool/mempool_trace.h b/lib/mempool/mempool_trace.h
index 23cda1473c..60e47cf67b 100644
--- a/lib/mempool/mempool_trace.h
+++ b/lib/mempool/mempool_trace.h
@@ -119,7 +119,6 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_i32(socket_id);
 	rte_trace_point_emit_ptr(cache);
 	rte_trace_point_emit_u32(cache->len);
-	rte_trace_point_emit_u32(cache->flushthresh);
 )
 
 RTE_TRACE_POINT(
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..5d43c7c98b 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -753,14 +753,13 @@ static void
 mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 {
 	cache->size = size;
-	cache->flushthresh = size; /* Obsolete; for API/ABI compatibility purposes only */
 	cache->len = 0;
 }
 
 /*
  * Create and initialize a cache for objects that are retrieved from and
  * returned to an underlying mempool. This structure is identical to the
- * local_cache[lcore_id] pointed to by the mempool structure.
+ * local_cache[lcore_id] entry in the mempool structure.
  */
 RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
@@ -768,6 +767,23 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
 {
 	struct rte_mempool_cache *cache;
 
+	/*
+	 * Alignment requirement for performance optimized move within the mempool cache.
+	 * @ref rte_mempool_do_generic_put() implementation.
+	 */
+	if (size < 32) {
+		RTE_MEMPOOL_LOG(WARNING,
+				"Tiny cache size %u not divisible by 32, rounding up to 32.",
+				size);
+		size = 32;
+	} else if (size & 31) {
+		uint32_t rounded = RTE_ALIGN_MUL_FLOOR(size, 32);
+		RTE_MEMPOOL_LOG(INFO,
+				"Cache size %u not divisible by 32, rounding down to %u.",
+				size, rounded);
+		size = rounded;
+	}
+
 	if (size == 0 || size > RTE_MEMPOOL_CACHE_MAX_SIZE) {
 		rte_errno = EINVAL;
 		return NULL;
@@ -838,6 +854,26 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		return NULL;
 	}
 
+	/*
+	 * Alignment requirement for performance optimized move within the mempool cache.
+	 * @ref rte_mempool_do_generic_put() implementation.
+	 */
+	RTE_BUILD_BUG_ON(((sizeof(void *) * RTE_MEMPOOL_CACHE_MAX_SIZE / 2) &
+			RTE_CACHE_LINE_MASK) != 0);
+	RTE_BUILD_BUG_ON((RTE_MEMPOOL_CACHE_MAX_SIZE & 31) != 0);
+	if (cache_size & 31) {
+		unsigned int rounded = RTE_ALIGN_MUL_FLOOR(cache_size, 32);
+		if (rounded == 0)
+			RTE_MEMPOOL_LOG(WARNING,
+					"Tiny cache size %u not divisible by 32, disabling cache.",
+					cache_size);
+		else
+			RTE_MEMPOOL_LOG(INFO,
+					"Cache size %u not divisible by 32, rounding down to %u.",
+					cache_size, rounded);
+		cache_size = rounded;
+	}
+
 	/* asked cache too big */
 	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE ||
 	    cache_size > n) {
@@ -884,7 +920,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	mempool_size = RTE_MEMPOOL_HEADER_SIZE(mp, cache_size);
+	mempool_size = sizeof(struct rte_mempool);
 	mempool_size += private_data_size;
 	mempool_size = RTE_ALIGN_CEIL(mempool_size, RTE_MEMPOOL_ALIGN);
 
@@ -900,7 +936,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/* init the mempool structure */
 	mp = mz->addr;
-	memset(mp, 0, RTE_MEMPOOL_HEADER_SIZE(mp, cache_size));
+	memset(mp, 0, mempool_size);
 	ret = strlcpy(mp->name, name, sizeof(mp->name));
 	if (ret < 0 || ret >= (int)sizeof(mp->name)) {
 		rte_errno = ENAMETOOLONG;
@@ -937,13 +973,6 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	/*
-	 * local_cache pointer is set even if cache_size is zero.
-	 * The local_cache points to just past the elt_pa[] array.
-	 */
-	mp->local_cache = (struct rte_mempool_cache *)
-		RTE_PTR_ADD(mp, RTE_MEMPOOL_HEADER_SIZE(mp, 0));
-
 	/* Init all default caches. */
 	if (cache_size != 0) {
 		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++)
@@ -1197,6 +1226,7 @@ mempool_obj_audit(struct rte_mempool *mp, __rte_unused void *opaque,
 	RTE_MEMPOOL_CHECK_COOKIES(mp, &obj, 1, 2);
 }
 
+/* check cookies before and after objects */
 static void
 mempool_audit_cookies(struct rte_mempool *mp)
 {
@@ -1213,23 +1243,28 @@ mempool_audit_cookies(struct rte_mempool *mp)
 #define mempool_audit_cookies(mp) do {} while(0)
 #endif
 
-/* check cookies before and after objects */
+/* check cache size consistency */
 static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
-	/* check cache size consistency */
 	unsigned lcore_id;
+	const uint32_t cache_size = mp->cache_size;
 
-	if (mp->cache_size == 0)
-		return;
+	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE) {
+		RTE_MEMPOOL_LOG(CRIT, "badness on cache size");
+		rte_panic("MEMPOOL: invalid cache size\n");
+	}
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		const struct rte_mempool_cache *cache;
 		cache = &mp->local_cache[lcore_id];
-		if (cache->len > RTE_DIM(cache->objs)) {
-			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u]",
-				lcore_id);
-			rte_panic("MEMPOOL: invalid cache len\n");
+		if (cache->size != cache_size) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] size", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] size\n", lcore_id);
+		}
+		if (cache->len > cache_size) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] len", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] len\n", lcore_id);
 		}
 	}
 }
@@ -1241,9 +1276,6 @@ rte_mempool_audit(struct rte_mempool *mp)
 {
 	mempool_audit_cache(mp);
 	mempool_audit_cookies(mp);
-
-	/* For case where mempool DEBUG is not set, and cache size is 0 */
-	RTE_SET_USED(mp);
 }
 
 /* dump the status of the mempool on the console */
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..a5578b3a93 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -89,14 +89,14 @@ struct __rte_cache_aligned rte_mempool_debug_stats {
  */
 struct __rte_cache_aligned rte_mempool_cache {
 	uint32_t size;	      /**< Size of the cache */
-	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility purposes only */
 	uint32_t len;	      /**< Current cache count */
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
-	uint32_t unused;
 	/*
 	 * Alternative location for the most frequently updated mempool statistics (per-lcore),
 	 * providing faster update access when using a mempool cache.
+	 * Note: 16-byte aligned for optimal SIMD access, when updating pairs of counters.
 	 */
+	alignas(16)
 	struct {
 		uint64_t put_bulk;          /**< Number of puts. */
 		uint64_t put_objs;          /**< Number of objects successfully put. */
@@ -104,15 +104,9 @@ struct __rte_cache_aligned rte_mempool_cache {
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
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
+	RTE_CACHE_GUARD;
 };
 
 /**
@@ -126,9 +120,26 @@ struct rte_mempool_objsz {
 	/**< Total size of an object (header + elt + trailer). */
 };
 
-/**< Maximum length of a memory pool's name. */
-#define RTE_MEMPOOL_NAMESIZE (RTE_RING_NAMESIZE - \
-			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
+/* Represents the memzone prefix of the default mempool driver. */
+#define RTE_MEMPOOL_DRIVER_REPRESENTATIVE_MZ_PREFIX "RG_"
+
+/**
+ * Maximum length of a memory pool's name.
+ *
+ * Needs room for memzone prefix indicating "mempool" type:
+ * "MP_<name>"
+ * Note:
+ * The mempool driver needs room for its own memzone prefix too, e.g.:
+ * "RG_MP_<name>" (ring driver) or "STK_MP_<name>" (stack driver)
+ * In order to fail early on too long names when creating the mempool,
+ * the length of the memzone name reserved by various mempool drivers is
+ * not considered; only the default driver (ring) is considered here.
+ * If the name eventually turns out to be too long for the chosen mempool driver,
+ * populating the mempool will fail.
+ */
+#define RTE_MEMPOOL_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
+		(sizeof(RTE_MEMPOOL_DRIVER_REPRESENTATIVE_MZ_PREFIX) - 1) - \
+		(sizeof(RTE_MEMPOOL_MZ_PREFIX) - 1))
 #define RTE_MEMPOOL_MZ_PREFIX "MP_"
 
 /* "MP_<name>" */
@@ -240,8 +251,7 @@ struct __rte_cache_aligned rte_mempool {
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
-	uint32_t cache_size;
-	/**< Size of per-lcore default local cache. */
+	uint32_t cache_size;             /**< Size of per-lcore default local cache. */
 
 	uint32_t elt_size;               /**< Size of an element. */
 	uint32_t header_size;            /**< Size of header (before elt). */
@@ -257,13 +267,13 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	int32_t ops_index;
 
-	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
-
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
 	uint32_t nb_mem_chunks;          /**< Number of memory chunks */
 	struct rte_mempool_memhdr_list mem_list; /**< List of memory chunks */
 
+	struct rte_mempool_cache local_cache[RTE_MAX_LCORE]; /**< Per-lcore local cache */
+
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	/** Per-lcore statistics.
 	 *
@@ -271,6 +281,8 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	struct rte_mempool_debug_stats stats[RTE_MAX_LCORE + 1];
 #endif
+
+	/* Private data are located immediately after the mempool structure. */
 };
 
 /** Spreading among memory channels not required. */
@@ -362,18 +374,6 @@ struct __rte_cache_aligned rte_mempool {
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
@@ -1049,7 +1049,7 @@ rte_mempool_free(struct rte_mempool *mp);
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
  *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n.
+ *   RTE_MEMPOOL_CACHE_MAX_SIZE and n, and it must be divisible by 32.
  *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
@@ -1368,15 +1368,16 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
 static __rte_always_inline struct rte_mempool_cache *
 rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
 {
-	if (unlikely(mp->cache_size == 0))
+	if (unlikely(lcore_id == LCORE_ID_ANY))
 		return NULL;
 
-	if (unlikely(lcore_id == LCORE_ID_ANY))
+	struct rte_mempool_cache *cache = &mp->local_cache[lcore_id];
+
+	if (unlikely(cache->size == 0))
 		return NULL;
 
-	rte_mempool_trace_default_cache(mp, lcore_id,
-		&mp->local_cache[lcore_id]);
-	return &mp->local_cache[lcore_id];
+	rte_mempool_trace_default_cache(mp, lcore_id, cache);
+	return cache;
 }
 
 /**
@@ -1445,9 +1446,24 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 		 * are more hot, from the upper half of the cache.
 		 */
 		__rte_assume(cache->len > cache->size / 2);
-		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / 2);
-		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
-				sizeof(void *) * (cache->len - cache->size / 2));
+		rte_mempool_ops_enqueue_bulk(mp, cache->objs, cache->size / 2);
+		/*
+		 * For improved rte_memcpy() performance, move down objects
+		 * from CPU cache line aligned address in chunks of 32 bytes.
+		 * Note: For cache->objs[cache->size / 2] to be cache line aligned, cache->size
+		 * must be divisible by 32 on 32-bit architecture with 64-byte cache line,
+		 * divisible by 32 on 64-bit architecture with 128-byte cache line, and
+		 * be divisible by 16 on 64-bit architecture with 64-byte cache line.
+		 * For API consistency, require mempool cache size is divisible by 32.
+		 * This requirement is enforced when creating the cache.
+		 * @ref rte_mempool_create_empty() implementation.
+		 */
+		const size_t move = RTE_ALIGN_MUL_CEIL(
+				sizeof(void *) * (cache->len - cache->size / 2), 32);
+		__rte_assume(move >= 32);
+		__rte_assume((move & 31) == 0);
+		rte_memcpy(cache->objs, __rte_assume_cache_aligned(&cache->objs[cache->size / 2]),
+				move);
 		cache_objs = &cache->objs[cache->len - cache->size / 2];
 		cache->len = cache->len - cache->size / 2 + n;
 	} else {
@@ -1892,8 +1908,7 @@ void rte_mempool_audit(struct rte_mempool *mp);
  */
 static inline void *rte_mempool_get_priv(struct rte_mempool *mp)
 {
-	return (char *)mp +
-		RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size);
+	return (char *)mp + sizeof(struct rte_mempool);
 }
 
 /**
-- 
2.43.0

