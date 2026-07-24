Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7343AC531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 12:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 368844029B;
	Fri, 24 Jul 2026 14:07:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5422340276
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:07:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2A54A205EE;
 Fri, 24 Jul 2026 14:07:50 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 24 Jul 2026 14:07:49 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jie Liu <liujie5@linkdatatechnology.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mempool: remove cache flush threshold
Date: Fri, 24 Jul 2026 12:07:47 +0000
Message-ID: <20260724120747.33981-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jul 2026 12:07:49.0859 (UTC)
 FILETIME=[0C09AB30:01DD1B65]
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

mempool: remove cache flush threshold

Removed the mempool cache flush threshold field (``flushthresh``),
which was obsolete and marked for removal.

Reduced the size of the mempool cache objects array; it was double the
required size.

Also fixed a couple of commments.

The sxe2 driver was updated to use the ``size`` field instead of the
``flushthresh`` field; it contains the same value.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_26_11.rst  |  5 +++++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c |  2 +-
 lib/mempool/mempool_trace.h             |  1 -
 lib/mempool/rte_mempool.c               |  5 ++---
 lib/mempool/rte_mempool.h               | 15 ++++-----------
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..8a109cae56 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,6 +100,11 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* mempool: The structure ``rte_mempool_cache`` was updated as follows:
+  - The obsolete ``flushthresh`` field was removed.
+  - The size of the ``objs`` array was reduced from ``RTE_MEMPOOL_CACHE_MAX_SIZE`` * 2 to ``RTE_MEMPOOL_CACHE_MAX_SIZE``.
+  - A cache guard was added at the end of the structure.
+
 
 Known Issues
 ------------
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
index 817e2b8dc1..4a79a4c800 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -753,7 +753,6 @@ static void
 mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 {
 	cache->size = size;
-	cache->flushthresh = size; /* Obsolete; for API/ABI compatibility purposes only */
 	cache->len = 0;
 }
 
@@ -1197,6 +1196,7 @@ mempool_obj_audit(struct rte_mempool *mp, __rte_unused void *opaque,
 	RTE_MEMPOOL_CHECK_COOKIES(mp, &obj, 1, 2);
 }
 
+/* check cookies before and after objects */
 static void
 mempool_audit_cookies(struct rte_mempool *mp)
 {
@@ -1213,11 +1213,10 @@ mempool_audit_cookies(struct rte_mempool *mp)
 #define mempool_audit_cookies(mp) do {} while(0)
 #endif
 
-/* check cookies before and after objects */
+/* check cache size consistency */
 static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
-	/* check cache size consistency */
 	unsigned lcore_id;
 
 	if (mp->cache_size == 0)
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..b531c8cbb5 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -89,14 +89,13 @@ struct __rte_cache_aligned rte_mempool_debug_stats {
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
 	 */
+	alignas(16)
 	struct {
 		uint64_t put_bulk;          /**< Number of puts. */
 		uint64_t put_objs;          /**< Number of objects successfully put. */
@@ -104,15 +103,9 @@ struct __rte_cache_aligned rte_mempool_cache {
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
-- 
2.43.0

