Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF87E81A36
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 15:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E37654042E;
	Mon, 16 Feb 2026 16:23:25 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6109F402C5
 for <dev@dpdk.org>; Mon, 16 Feb 2026 16:23:23 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2C8AC21091;
 Mon, 16 Feb 2026 16:23:23 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 16 Feb 2026 16:23:22 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v3 1/2] mempool: simplify get objects
Date: Mon, 16 Feb 2026 15:23:19 +0000
Message-ID: <20260216152320.105312-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216152320.105312-1-mb@smartsharesystems.com>
References: <20260216115813.103515-1-mb@smartsharesystems.com>
 <20260216152320.105312-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Feb 2026 15:23:22.0570 (UTC)
 FILETIME=[3002CAA0:01DC9F58]
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

Removed explicit test for build time constant request size,
and added comment that the compiler loop unrolls when request size is
build time constant, to improve source code readability.

Moved setting cache->len up before the copy loop; not only for code
similarity (cache->len is now set before each copy loop), but also as an
optimization:
The function's pointer parameters are not marked restrict, so writing to
obj_table in the copy loop might formally modify cache->size. And thus,
setting cache->len = cache->size after the copy loop requires loading
cache->size again after copying the objects.
Moving this line up before the copy loop avoids that extra load of
cache->size when setting cache->len.

Similarly, moved statistics update up before the copy loops.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v3:
* Added to description why setting cache->len was moved up before the copy
  loop.
* Moved statistics update up before the copy loop.
v2:
* Removed unrelated microoptimization from rte_mempool_do_generic_put(),
  which was also described incorrectly.
---
 lib/mempool/rte_mempool.h | 47 ++++++++++++---------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index aedc100964..7989d7a475 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1531,47 +1531,29 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	cache_objs = &cache->objs[cache->len];
 
 	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	if (__rte_constant(n) && n <= cache->len) {
+	if (likely(n <= cache->len)) {
+		/* The entire request can be satisfied from the cache. */
+		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
+		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
+
 		/*
-		 * The request size is known at build time, and
-		 * the entire request can be satisfied from the cache,
-		 * so let the compiler unroll the fixed length copy loop.
+		 * If the request size is known at build time,
+		 * the compiler unrolls the fixed length copy loop.
 		 */
 		cache->len -= n;
 		for (index = 0; index < n; index++)
 			*obj_table++ = *--cache_objs;
 
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-
 		return 0;
 	}
 
-	/*
-	 * Use the cache as much as we have to return hot objects first.
-	 * If the request size 'n' is known at build time, the above comparison
-	 * ensures that n > cache->len here, so omit RTE_MIN().
-	 */
-	len = __rte_constant(n) ? cache->len : RTE_MIN(n, cache->len);
-	cache->len -= len;
+	/* Use the cache as much as we have to return hot objects first. */
+	len = cache->len;
 	remaining = n - len;
+	cache->len = 0;
 	for (index = 0; index < len; index++)
 		*obj_table++ = *--cache_objs;
 
-	/*
-	 * If the request size 'n' is known at build time, the case
-	 * where the entire request can be satisfied from the cache
-	 * has already been handled above, so omit handling it here.
-	 */
-	if (!__rte_constant(n) && likely(remaining == 0)) {
-		/* The entire request is satisfied from the cache. */
-
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-
-		return 0;
-	}
-
 	/* Dequeue below would overflow mem allocated for cache? */
 	if (unlikely(remaining > RTE_MEMPOOL_CACHE_MAX_SIZE))
 		goto driver_dequeue;
@@ -1589,17 +1571,16 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	}
 
 	/* Satisfy the remaining part of the request from the filled cache. */
+	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
+	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
+
 	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	cache_objs = &cache->objs[cache->size + remaining];
+	cache->len = cache->size;
 	for (index = 0; index < remaining; index++)
 		*obj_table++ = *--cache_objs;
 
-	cache->len = cache->size;
-
-	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
-	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
-
 	return 0;
 
 driver_dequeue:
-- 
2.43.0

