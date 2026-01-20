Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEDD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 10:17:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81957402F0;
	Tue, 20 Jan 2026 11:17:12 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B621A4013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:17:10 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CC15E20D99;
 Tue, 20 Jan 2026 11:17:09 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 20 Jan 2026 11:17:07 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
	dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mempool: simplify get objects
Date: Tue, 20 Jan 2026 10:17:01 +0000
Message-ID: <20260120101701.467039-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120082049.466224-1-mb@smartsharesystems.com>
References: <20260120082049.466224-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Jan 2026 10:17:07.0932 (UTC)
 FILETIME=[EEB849C0:01DC89F5]
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

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Removed unrelated microoptimization from rte_mempool_do_generic_put(),
  which was also described incorrectly.
---
 lib/mempool/rte_mempool.h | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index aedc100964..4213784e14 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1531,11 +1531,11 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	cache_objs = &cache->objs[cache->len];
 
 	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE * 2);
-	if (__rte_constant(n) && n <= cache->len) {
+	if (likely(n <= cache->len)) {
 		/*
-		 * The request size is known at build time, and
-		 * the entire request can be satisfied from the cache,
-		 * so let the compiler unroll the fixed length copy loop.
+		 * The entire request can be satisfied from the cache.
+		 * If the request size is known at build time,
+		 * the compiler unrolls the fixed length copy loop.
 		 */
 		cache->len -= n;
 		for (index = 0; index < n; index++)
@@ -1547,31 +1547,13 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
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
@@ -1592,11 +1574,10 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	cache_objs = &cache->objs[cache->size + remaining];
+	cache->len = cache->size;
 	for (index = 0; index < remaining; index++)
 		*obj_table++ = *--cache_objs;
 
-	cache->len = cache->size;
-
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
-- 
2.43.0

