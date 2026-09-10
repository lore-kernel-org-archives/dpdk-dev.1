Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D5C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C732D427AE;
	Thu, 10 Sep 2026 12:36:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BFBF942788
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 96E24205CA;
 Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:21 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 3/6] mempool: remove deprecated cache flush threshold field
Date: Thu, 10 Sep 2026 10:36:10 +0000
Message-ID: <20260910103613.808038-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:21.0255 (UTC)
 FILETIME=[38672970:01DD4110]
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

Removed the mempool cache flush threshold field (``flushthresh``),
which was obsolete and marked for removal.

Reduced the size of the mempool cache objects array; it was double the
required size.

Updated release notes accordingly.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
Supersedes: patch-167311
("[v3] mempool: remove cache flush threshold field")
---
 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 lib/mempool/mempool_trace.h            |  1 -
 lib/mempool/rte_mempool.c              |  1 -
 lib/mempool/rte_mempool.h              | 16 +++++-----------
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..59b8514360 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,8 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* mempool: Removed the deprecated and obsolete ``flushthresh`` field from the ``rte_mempool_cache`` structure.
+
 
 API Changes
 -----------
@@ -95,6 +97,10 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* mempool: Updated the ``rte_mempool_cache`` structure as follows:
+  - Removed the deprecated and obsolete ``flushthresh`` field.
+  - Removed the ``unused`` field.
+  - Reduced the size of the ``objs`` array from ``RTE_MEMPOOL_CACHE_MAX_SIZE`` * 2 to ``RTE_MEMPOOL_CACHE_MAX_SIZE``.
 
 ABI Changes
 -----------
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
index 925d21570a..03ecd01560 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -753,7 +753,6 @@ static void
 mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 {
 	cache->size = size;
-	cache->flushthresh = size; /* Obsolete; for API/ABI compatibility purposes only */
 	cache->len = 0;
 }
 
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..2fa70812d5 100644
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
-- 
2.43.0

