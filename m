Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3807427BC;
	Thu, 10 Sep 2026 12:36:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A2F914028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:22 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 83C4720630;
 Thu, 10 Sep 2026 12:36:22 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:21 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 5/6] mempool: optimize access to private data
Date: Thu, 10 Sep 2026 10:36:12 +0000
Message-ID: <20260910103613.808038-6-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:21.0692 (UTC)
 FILETIME=[38A9D7C0:01DD4110]
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

Swapped the location of the private data and the local cache,
so the private data is located immediately after the mempool header,
and the local cache after that.
This way, getting the address of the private data is as simple as
adding a constant to the address of the mempool.

The local cache is accessed by dereferencing a pointer to it anyway, so
the performance of accessing it is not affected by moving its location.

Note:
The mempool private data API describes the private data as following the
mempool header; but it has been implemented differently for a long time
without causing problems, so this is considered an optimization,
not a bugfix.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
Supersedes: patch-169235
("[v2] mempool: no cache size limit")
---
 app/test/test_mempool.c   |  3 +--
 lib/mempool/rte_mempool.c | 17 +++++++++++++----
 lib/mempool/rte_mempool.h | 20 ++++++--------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0bb051cb31..6ff8746474 100644
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
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 04766f55d6..211763aced 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -873,6 +873,13 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	 * cache-aligned
 	 */
 	private_data_size = RTE_CACHE_LINE_ROUNDUP(private_data_size);
+	/*
+	 * If any private data, add padding, to guard against false sharing-like
+	 * effects on systems with a next-N-lines hardware prefetcher, when
+	 * accessing private data.
+	 */
+	if (private_data_size != 0)
+		private_data_size += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
 
 	/* try to allocate tailq entry */
 	te = rte_zmalloc("MEMPOOL_TAILQ_ENTRY", sizeof(*te), 0);
@@ -881,8 +888,10 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	mempool_size = RTE_MEMPOOL_HEADER_SIZE(mp, cache_size);
+	mempool_size = sizeof(struct rte_mempool);
 	mempool_size += private_data_size;
+	if (cache_size != 0)
+		mempool_size += RTE_MAX_LCORE * sizeof(struct rte_mempool_cache);
 
 	ret = snprintf(mz_name, sizeof(mz_name), RTE_MEMPOOL_MZ_FORMAT, name);
 	if (ret < 0 || ret >= (int)sizeof(mz_name)) {
@@ -896,7 +905,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/* init the mempool structure */
 	mp = mz->addr;
-	memset(mp, 0, RTE_MEMPOOL_HEADER_SIZE(mp, cache_size));
+	memset(mp, 0, mempool_size);
 	ret = strlcpy(mp->name, name, sizeof(mp->name));
 	if (ret < 0 || ret >= (int)sizeof(mp->name)) {
 		rte_errno = ENAMETOOLONG;
@@ -935,10 +944,10 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/*
 	 * local_cache pointer is set even if cache_size is zero.
-	 * The local_cache points to just past the elt_pa[] array.
+	 * The local_cache points to just past the private data.
 	 */
 	mp->local_cache = (struct rte_mempool_cache *)
-		RTE_PTR_ADD(mp, RTE_MEMPOOL_HEADER_SIZE(mp, 0));
+		RTE_PTR_ADD(mp, sizeof(struct rte_mempool) + private_data_size);
 
 	/* Init all default caches. */
 	if (cache_size != 0) {
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 4cdbb3f778..5a81e53a9f 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -278,6 +278,11 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	struct rte_mempool_debug_stats stats[RTE_MAX_LCORE + 1];
 #endif
+
+	/*
+	 * Private data, if any, is located after the mempool header.
+	 * Per-lcore local cache, if any, is located after the private data.
+	 */
 };
 
 /** Spreading among memory channels not required. */
@@ -369,18 +374,6 @@ struct __rte_cache_aligned rte_mempool {
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
@@ -1902,8 +1895,7 @@ void rte_mempool_audit(struct rte_mempool *mp);
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

