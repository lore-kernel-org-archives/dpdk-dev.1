Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A924E7BDAC
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 13:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3860840289;
	Mon, 16 Feb 2026 14:13:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AB1EA40269
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:13:12 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 81B9C20FCA;
 Mon, 16 Feb 2026 14:13:12 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 16 Feb 2026 14:13:11 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v2 2/2] mempool: de-inline get/put objects unlikely code
 paths
Date: Mon, 16 Feb 2026 13:13:03 +0000
Message-ID: <20260216131303.104297-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216131303.104297-1-mb@smartsharesystems.com>
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216131303.104297-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Feb 2026 13:13:11.0603 (UTC)
 FILETIME=[004FD030:01DC9F46]
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

De-inline unlikely code paths, for smaller footprint.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Removed review functions.
* Changed #if 0 to #if AVOID_RTE_MEMCPY.
---
 lib/mempool/rte_mempool.c | 114 ++++++++++++++++++++-
 lib/mempool/rte_mempool.h | 202 +++++++++++++++++++-------------------
 2 files changed, 214 insertions(+), 102 deletions(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 3042d94c14..c9e6f49de5 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1016,6 +1016,118 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 	return NULL;
 }
 
+/* internal */
+RTE_EXPORT_INTERNAL_SYMBOL(_rte_mempool_do_generic_put_more)
+void
+_rte_mempool_do_generic_put_more(struct rte_mempool *mp, void * const *obj_table,
+		unsigned int n, struct rte_mempool_cache *cache)
+{
+	__rte_assume(cache->flushthresh <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	__rte_assume(cache->len <= cache->flushthresh);
+	__rte_assume(cache->len + n > cache->flushthresh);
+	if (likely(n <= cache->flushthresh)) {
+		uint32_t len;
+		void **cache_objs;
+
+		/*
+		 * The cache is big enough for the objects, but - as detected by
+		 * rte_mempool_do_generic_put() - has insufficient room for them.
+		 * Flush the cache to make room for the objects.
+		 */
+		len = cache->len;
+		cache_objs = &cache->objs[0];
+		cache->len = n;
+		rte_mempool_ops_enqueue_bulk(mp, cache_objs, len);
+
+		/* Add the objects to the cache. */
+#ifdef AVOID_RTE_MEMCPY /* Simple alternative to rte_memcpy(). */
+		for (uint32_t index = 0; index < n; index++)
+			*cache_objs++ = *obj_table++;
+#else
+		rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
+#endif
+
+		return;
+	}
+
+	/* The request itself is too big for the cache. Push objects directly to the backend. */
+	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
+}
+
+/* internal */
+RTE_EXPORT_INTERNAL_SYMBOL(_rte_mempool_do_generic_get_more)
+int
+_rte_mempool_do_generic_get_more(struct rte_mempool *mp, void **obj_table,
+		unsigned int n, struct rte_mempool_cache *cache)
+{
+	int ret;
+	unsigned int remaining;
+	uint32_t index, len;
+	void **cache_objs;
+
+	/* Use the cache as much as we have to return hot objects first. */
+	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
+	len = cache->len;
+	remaining = n - len;
+	cache_objs = &cache->objs[len];
+	cache->len = 0;
+	for (index = 0; index < len; index++)
+		*obj_table++ = *--cache_objs;
+
+	/* Dequeue below would overflow mem allocated for cache? */
+	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
+		goto driver_dequeue;
+
+	/* Fill the cache from the backend; fetch size + remaining objects. */
+	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
+			cache->size + remaining);
+	if (unlikely(ret < 0)) {
+		/*
+		 * We are buffer constrained, and not able to fetch all that.
+		 * Do not fill the cache, just satisfy the remaining part of
+		 * the request directly from the backend.
+		 */
+		goto driver_dequeue;
+	}
+
+	/* Satisfy the remaining part of the request from the filled cache. */
+	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
+	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
+
+	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	cache_objs = &cache->objs[cache->size + remaining];
+	cache->len = cache->size;
+	for (index = 0; index < remaining; index++)
+		*obj_table++ = *--cache_objs;
+
+	return 0;
+
+driver_dequeue:
+
+	/* Get remaining objects directly from the backend. */
+	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
+
+	if (unlikely(ret < 0)) {
+		cache->len = n - remaining;
+		/*
+		 * No further action is required to roll the first part
+		 * of the request back into the cache, as objects in
+		 * the cache are intact.
+		 */
+
+		RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
+		RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
+	} else {
+		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
+		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
+		__rte_assume(ret == 0);
+	}
+
+	return ret;
+}
+
 /* Return the number of entries in the mempool */
 RTE_EXPORT_SYMBOL(rte_mempool_avail_count)
 unsigned int
@@ -1633,4 +1745,4 @@ RTE_INIT(mempool_init_telemetry)
 		"Returns list of available mempool. Takes no parameters");
 	rte_telemetry_register_cmd("/mempool/info", mempool_handle_info,
 		"Returns mempool info. Parameters: pool_name");
-}
+}
\ No newline at end of file
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 7989d7a475..86163e5377 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1370,6 +1370,24 @@ rte_mempool_cache_flush(struct rte_mempool_cache *cache,
 	cache->len = 0;
 }
 
+/**
+ * @internal
+ * Put several objects back in the mempool, more than the cache has room for; used internally.
+ * @param mp
+ *   A pointer to the mempool structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to store back in the mempool, must be strictly
+ *   positive.
+ * @param cache
+ *   A pointer to a mempool cache structure.
+ */
+__rte_internal
+void
+_rte_mempool_do_generic_put_more(struct rte_mempool *mp, void * const *obj_table,
+		unsigned int n, struct rte_mempool_cache *cache);
+
 /**
  * @internal Put several objects back in the mempool; used internally.
  * @param mp
@@ -1388,9 +1406,16 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 {
 	void **cache_objs;
 
-	/* No cache provided? */
-	if (unlikely(cache == NULL))
-		goto driver_enqueue;
+	if (unlikely(cache == NULL)) {
+		/* No cache. Push objects directly to the backend. */
+		/* Increment stats now, adding in mempool always succeeds. */
+		RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
+		RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);
+
+		rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
+
+		return;
+	}
 
 	/* Increment stats now, adding in mempool always succeeds. */
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
@@ -1403,35 +1428,43 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 		/* Sufficient room in the cache for the objects. */
 		cache_objs = &cache->objs[cache->len];
 		cache->len += n;
-	} else if (n <= cache->flushthresh) {
+
+cache_enqueue:
+#ifdef AVOID_RTE_MEMCPY /* Simple alternative to rte_memcpy(). */
 		/*
-		 * The cache is big enough for the objects, but - as detected by
-		 * the comparison above - has insufficient room for them.
-		 * Flush the cache to make room for the objects.
+		 * Add the objects to the cache.
+		 * If the request size is known at build time,
+		 * the compiler unrolls the fixed length copy loop.
 		 */
-		cache_objs = &cache->objs[0];
-		rte_mempool_ops_enqueue_bulk(mp, cache_objs, cache->len);
-		cache->len = n;
-	} else {
-		/* The request itself is too big for the cache. */
-		goto driver_enqueue_stats_incremented;
-	}
-
-	/* Add the objects to the cache. */
-	rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
+		for (uint32_t index = 0; index < n; index++)
+			*cache_objs++ = *obj_table++;
+#else
+		/* Add the objects to the cache. */
+		rte_memcpy(cache_objs, obj_table, sizeof(void *) * n);
+#endif
 
-	return;
+		return;
+	}
 
-driver_enqueue:
+	if (__rte_constant(n) && likely(n <= cache->flushthresh)) {
+		uint32_t len;
 
-	/* increment stat now, adding in mempool always success */
-	RTE_MEMPOOL_STAT_ADD(mp, put_bulk, 1);
-	RTE_MEMPOOL_STAT_ADD(mp, put_objs, n);
+		/*
+		 * The cache is big enough for the objects, but - as detected
+		 * above - has insufficient room for them.
+		 * Flush the cache to make room for the objects.
+		 */
+		len = cache->len;
+		cache_objs = &cache->objs[0];
+		cache->len = n;
+		rte_mempool_ops_enqueue_bulk(mp, cache_objs, len);
 
-driver_enqueue_stats_incremented:
+		/* Add the objects to the cache. */
+		goto cache_enqueue;
+	}
 
-	/* push objects to the backend */
-	rte_mempool_ops_enqueue_bulk(mp, obj_table, n);
+	/* Insufficient room in the cache for the objects. */
+	_rte_mempool_do_generic_put_more(mp, obj_table, n, cache);
 }
 
 
@@ -1498,6 +1531,26 @@ rte_mempool_put(struct rte_mempool *mp, void *obj)
 	rte_mempool_put_bulk(mp, &obj, 1);
 }
 
+/**
+ * @internal
+ * Get several objects from the mempool, more than held in the cache; used internally.
+ * @param mp
+ *   A pointer to the mempool structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to get, must be strictly positive.
+ * @param cache
+ *   A pointer to a mempool cache structure.
+ * @return
+ *   - 0: Success.
+ *   - <0: Error; code of driver dequeue function.
+ */
+__rte_internal
+int
+_rte_mempool_do_generic_get_more(struct rte_mempool *mp, void **obj_table,
+		unsigned int n, struct rte_mempool_cache *cache);
+
 /**
  * @internal Get several objects from the mempool; used internally.
  * @param mp
@@ -1516,26 +1569,36 @@ static __rte_always_inline int
 rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 			   unsigned int n, struct rte_mempool_cache *cache)
 {
-	int ret;
-	unsigned int remaining;
-	uint32_t index, len;
-	void **cache_objs;
-
-	/* No cache provided? */
 	if (unlikely(cache == NULL)) {
-		remaining = n;
-		goto driver_dequeue;
-	}
+		int ret;
 
-	/* The cache is a stack, so copy will be in reverse order. */
-	cache_objs = &cache->objs[cache->len];
+		/* No cache. Get objects directly from the backend. */
+		ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, n);
+
+		if (unlikely(ret < 0)) {
+			RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
+			RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
+		} else {
+			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
+			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
+			__rte_assume(ret == 0);
+		}
+
+		return ret;
+	}
 
 	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
 	if (likely(n <= cache->len)) {
+		uint32_t index;
+		void **cache_objs;
+
 		/* The entire request can be satisfied from the cache. */
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
+		/* The cache is a stack, so copy will be in reverse order. */
+		cache_objs = &cache->objs[cache->len];
+
 		/*
 		 * If the request size is known at build time,
 		 * the compiler unrolls the fixed length copy loop.
@@ -1547,71 +1610,8 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 		return 0;
 	}
 
-	/* Use the cache as much as we have to return hot objects first. */
-	len = cache->len;
-	remaining = n - len;
-	cache->len = 0;
-	for (index = 0; index < len; index++)
-		*obj_table++ = *--cache_objs;
-
-	/* Dequeue below would overflow mem allocated for cache? */
-	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
-		goto driver_dequeue;
-
-	/* Fill the cache from the backend; fetch size + remaining objects. */
-	ret = rte_mempool_ops_dequeue_bulk(mp, cache->objs,
-			cache->size + remaining);
-	if (unlikely(ret < 0)) {
-		/*
-		 * We are buffer constrained, and not able to fetch all that.
-		 * Do not fill the cache, just satisfy the remaining part of
-		 * the request directly from the backend.
-		 */
-		goto driver_dequeue;
-	}
-
-	/* Satisfy the remaining part of the request from the filled cache. */
-	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-
-	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-	cache_objs = &cache->objs[cache->size + remaining];
-	cache->len = cache->size;
-	for (index = 0; index < remaining; index++)
-		*obj_table++ = *--cache_objs;
-
-	return 0;
-
-driver_dequeue:
-
-	/* Get remaining objects directly from the backend. */
-	ret = rte_mempool_ops_dequeue_bulk(mp, obj_table, remaining);
-
-	if (unlikely(ret < 0)) {
-		if (likely(cache != NULL)) {
-			cache->len = n - remaining;
-			/*
-			 * No further action is required to roll the first part
-			 * of the request back into the cache, as objects in
-			 * the cache are intact.
-			 */
-		}
-
-		RTE_MEMPOOL_STAT_ADD(mp, get_fail_bulk, 1);
-		RTE_MEMPOOL_STAT_ADD(mp, get_fail_objs, n);
-	} else {
-		if (likely(cache != NULL)) {
-			RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-			RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-		} else {
-			RTE_MEMPOOL_STAT_ADD(mp, get_success_bulk, 1);
-			RTE_MEMPOOL_STAT_ADD(mp, get_success_objs, n);
-		}
-		__rte_assume(ret == 0);
-	}
-
-	return ret;
+	/* The entire request cannot be satisfied from the cache. */
+	return _rte_mempool_do_generic_get_more(mp, obj_table, n, cache);
 }
 
 /**
-- 
2.43.0

