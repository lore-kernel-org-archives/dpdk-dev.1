Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93637C36018
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 15:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B579140E2F;
	Tue,  1 Apr 2025 17:01:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DB4C540275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 17:00:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B520831722;
 Tue,  1 Apr 2025 17:00:56 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Apr 2025 17:00:56 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 2/4] mempool perf test: test default mempool with cache
Date: Tue,  1 Apr 2025 15:00:46 +0000
Message-ID: <20250401150049.4968-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401150049.4968-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250401150049.4968-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Apr 2025 15:00:56.0428 (UTC)
 FILETIME=[DF0C12C0:01DBA316]
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

Added test for the "default" mempool with cache.

Skip the tests for the "default" mempool, if it happens to use the same
driver (i.e. operations) as already tested.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test/test_mempool_perf.c | 84 +++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index d4271a5ef9..3594d81888 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -354,7 +354,10 @@ do_all_mempool_perf_tests(unsigned int cores)
 {
 	struct rte_mempool *mp_cache = NULL;
 	struct rte_mempool *mp_nocache = NULL;
-	struct rte_mempool *default_pool = NULL;
+	struct rte_mempool *default_pool_cache = NULL;
+	struct rte_mempool *default_pool_nocache = NULL;
+	const char *mp_cache_ops;
+	const char *mp_nocache_ops;
 	const char *default_pool_ops;
 	int ret = -1;
 
@@ -368,6 +371,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 		printf("cannot allocate mempool (without cache)\n");
 		goto err;
 	}
+	mp_nocache_ops = rte_mempool_get_ops(mp_nocache->ops_index)->name;
 
 	/* create a mempool (with cache) */
 	mp_cache = rte_mempool_create("perf_test_cache", MEMPOOL_SIZE,
@@ -380,47 +384,76 @@ do_all_mempool_perf_tests(unsigned int cores)
 		printf("cannot allocate mempool (with cache)\n");
 		goto err;
 	}
+	mp_cache_ops = rte_mempool_get_ops(mp_cache->ops_index)->name;
 
 	default_pool_ops = rte_mbuf_best_mempool_ops();
-	/* Create a mempool based on Default handler */
-	default_pool = rte_mempool_create_empty("default_pool",
-						MEMPOOL_SIZE,
-						MEMPOOL_ELT_SIZE,
-						0, 0,
-						SOCKET_ID_ANY, 0);
-
-	if (default_pool == NULL) {
-		printf("cannot allocate %s mempool\n", default_pool_ops);
+
+	/* Create a mempool (without cache) based on Default handler */
+	default_pool_nocache = rte_mempool_create_empty("default_pool_nocache",
+			MEMPOOL_SIZE,
+			MEMPOOL_ELT_SIZE,
+			0, 0,
+			SOCKET_ID_ANY, 0);
+	if (default_pool_nocache == NULL) {
+		printf("cannot allocate %s mempool (without cache)\n", default_pool_ops);
 		goto err;
 	}
-
-	if (rte_mempool_set_ops_byname(default_pool, default_pool_ops, NULL)
-				       < 0) {
+	if (rte_mempool_set_ops_byname(default_pool_nocache, default_pool_ops, NULL) < 0) {
 		printf("cannot set %s handler\n", default_pool_ops);
 		goto err;
 	}
-
-	if (rte_mempool_populate_default(default_pool) < 0) {
+	if (rte_mempool_populate_default(default_pool_nocache) < 0) {
 		printf("cannot populate %s mempool\n", default_pool_ops);
 		goto err;
 	}
+	rte_mempool_obj_iter(default_pool_nocache, my_obj_init, NULL);
+
+	/* Create a mempool (with cache) based on Default handler */
+	default_pool_cache = rte_mempool_create_empty("default_pool_cache",
+			MEMPOOL_SIZE,
+			MEMPOOL_ELT_SIZE,
+			RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
+			SOCKET_ID_ANY, 0);
+	if (default_pool_cache == NULL) {
+		printf("cannot allocate %s mempool (with cache)\n", default_pool_ops);
+		goto err;
+	}
+	if (rte_mempool_set_ops_byname(default_pool_cache, default_pool_ops, NULL) < 0) {
+		printf("cannot set %s handler\n", default_pool_ops);
+		goto err;
+	}
+	if (rte_mempool_populate_default(default_pool_cache) < 0) {
+		printf("cannot populate %s mempool\n", default_pool_ops);
+		goto err;
+	}
+	rte_mempool_obj_iter(default_pool_cache, my_obj_init, NULL);
 
-	rte_mempool_obj_iter(default_pool, my_obj_init, NULL);
-
-	printf("start performance test (without cache)\n");
+	printf("start performance test (using %s, without cache)\n",
+	       mp_nocache_ops);
 	if (do_one_mempool_test(mp_nocache, cores, 0) < 0)
 		goto err;
 
-	printf("start performance test for %s (without cache)\n",
-	       default_pool_ops);
-	if (do_one_mempool_test(default_pool, cores, 0) < 0)
-		goto err;
+	if (strcmp(default_pool_ops, mp_nocache_ops) != 0) {
+		printf("start performance test for %s (without cache)\n",
+		       default_pool_ops);
+		if (do_one_mempool_test(default_pool_nocache, cores, 0) < 0)
+			goto err;
+	}
 
-	printf("start performance test (with cache)\n");
+	printf("start performance test (using %s, with cache)\n",
+	       mp_cache_ops);
 	if (do_one_mempool_test(mp_cache, cores, 0) < 0)
 		goto err;
 
-	printf("start performance test (with user-owned cache)\n");
+	if (strcmp(default_pool_ops, mp_cache_ops) != 0) {
+		printf("start performance test for %s (with cache)\n",
+		       default_pool_ops);
+		if (do_one_mempool_test(default_pool_cache, cores, 0) < 0)
+			goto err;
+	}
+
+	printf("start performance test (using %s, with user-owned cache)\n",
+	       mp_nocache_ops);
 	if (do_one_mempool_test(mp_nocache, cores, 1) < 0)
 		goto err;
 
@@ -431,7 +464,8 @@ do_all_mempool_perf_tests(unsigned int cores)
 err:
 	rte_mempool_free(mp_cache);
 	rte_mempool_free(mp_nocache);
-	rte_mempool_free(default_pool);
+	rte_mempool_free(default_pool_cache);
+	rte_mempool_free(default_pool_nocache);
 	return ret;
 }
 
-- 
2.43.0

