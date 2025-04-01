Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576AC36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 15:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA5A40E36;
	Tue,  1 Apr 2025 17:01:02 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2D5B040275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 17:00:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2FA4431724;
 Tue,  1 Apr 2025 17:00:57 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Apr 2025 17:00:56 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 4/4] mempool perf test: test random bulk sizes
Date: Tue,  1 Apr 2025 15:00:48 +0000
Message-ID: <20250401150049.4968-5-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401150049.4968-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250401150049.4968-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Apr 2025 15:00:56.0881 (UTC)
 FILETIME=[DF513210:01DBA316]
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

Bulk requests to get or put objects in a mempool often vary in size.
A series of tests with pseudo random request sizes, to mitigate the
benefits of the CPU's dynamic branch predictor, was added.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test/test_mempool_perf.c | 102 ++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index c252f1968a..40ecaa5049 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -33,6 +33,13 @@
  * Mempool performance
  * =======
  *
+ *    Each core get *n_keep* objects per bulk of a pseudorandom number
+ *    between 1 and *n_max_bulk*.
+ *    Objects are put back in the pool per bulk of a similar pseudorandom number.
+ *    Note: The very low entropy of the randomization algorithm is harmless, because
+ *          the sole purpose of randomization is to prevent the CPU's dynamic branch
+ *          predictor from enhancing the test results.
+ *
  *    Each core get *n_keep* objects per bulk of *n_get_bulk*. Then,
  *    objects are put back in the pool per bulk of *n_put_bulk*.
  *
@@ -52,7 +59,12 @@
  *      - Two cores with user-owned cache
  *      - Max. cores with user-owned cache
  *
- *    - Bulk size (*n_get_bulk*, *n_put_bulk*)
+ *    - Pseudorandom max bulk size (*n_max_bulk*)
+ *
+ *      - Max bulk from CACHE_LINE_BURST to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE,
+ *        where CACHE_LINE_BURST is the number of pointers fitting into one CPU cache line.
+ *
+ *    - Fixed bulk size (*n_get_bulk*, *n_put_bulk*)
  *
  *      - Bulk get from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
  *      - Bulk put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
@@ -93,6 +105,9 @@ static unsigned int external_cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
 
 static RTE_ATOMIC(uint32_t) synchro;
 
+/* max random number of objects in one bulk operation (get and put) */
+static unsigned int n_max_bulk;
+
 /* number of objects in one bulk operation (get or put) */
 static unsigned int n_get_bulk;
 static unsigned int n_put_bulk;
@@ -159,6 +174,50 @@ test_loop(struct rte_mempool *mp, struct rte_mempool_cache *cache,
 	return 0;
 }
 
+static __rte_always_inline int
+test_loop_random(struct rte_mempool *mp, struct rte_mempool_cache *cache,
+	  unsigned int x_keep, unsigned int x_max_bulk)
+{
+	alignas(RTE_CACHE_LINE_SIZE) void *obj_table[MAX_KEEP];
+	unsigned int idx;
+	unsigned int i;
+	unsigned int r = 0;
+	unsigned int x_bulk;
+	int ret;
+
+	for (i = 0; likely(i < (N / x_keep)); i++) {
+		/* get x_keep objects by bulk of random [1 .. x_max_bulk] */
+		for (idx = 0; idx < x_keep; idx += x_bulk, r++) {
+			/* Generate a pseudorandom number [1 .. x_max_bulk]. */
+			x_bulk = ((r ^ (r >> 2) ^ (r << 3)) & (x_max_bulk - 1)) + 1;
+			if (unlikely(idx + x_bulk > x_keep))
+				x_bulk = x_keep - idx;
+			ret = rte_mempool_generic_get(mp,
+						      &obj_table[idx],
+						      x_bulk,
+						      cache);
+			if (unlikely(ret < 0)) {
+				rte_mempool_dump(stdout, mp);
+				return ret;
+			}
+		}
+
+		/* put the objects back by bulk of random [1 .. x_max_bulk] */
+		for (idx = 0; idx < x_keep; idx += x_bulk, r++) {
+			/* Generate a pseudorandom number [1 .. x_max_bulk]. */
+			x_bulk = ((r ^ (r >> 2) ^ (r << 3)) & (x_max_bulk - 1)) + 1;
+			if (unlikely(idx + x_bulk > x_keep))
+				x_bulk = x_keep - idx;
+			rte_mempool_generic_put(mp,
+						&obj_table[idx],
+						x_bulk,
+						cache);
+		}
+	}
+
+	return 0;
+}
+
 static int
 per_lcore_mempool_test(void *arg)
 {
@@ -181,9 +240,9 @@ per_lcore_mempool_test(void *arg)
 	}
 
 	/* n_get_bulk and n_put_bulk must be divisors of n_keep */
-	if (((n_keep / n_get_bulk) * n_get_bulk) != n_keep)
+	if (n_max_bulk == 0 && (((n_keep / n_get_bulk) * n_get_bulk) != n_keep))
 		GOTO_ERR(ret, out);
-	if (((n_keep / n_put_bulk) * n_put_bulk) != n_keep)
+	if (n_max_bulk == 0 && (((n_keep / n_put_bulk) * n_put_bulk) != n_keep))
 		GOTO_ERR(ret, out);
 	/* for constant n, n_get_bulk and n_put_bulk must be the same */
 	if (use_constant_values && n_put_bulk != n_get_bulk)
@@ -200,7 +259,9 @@ per_lcore_mempool_test(void *arg)
 	start_cycles = rte_get_timer_cycles();
 
 	while (time_diff/hz < TIME_S) {
-		if (!use_constant_values)
+		if (n_max_bulk != 0)
+			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
+		else if (!use_constant_values)
 			ret = test_loop(mp, cache, n_keep, n_get_bulk, n_put_bulk);
 		else if (n_get_bulk == 1)
 			ret = test_loop(mp, cache, n_keep, 1, 1);
@@ -261,9 +322,13 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 	       use_external_cache ? external_cache_size : (unsigned int) mp->cache_size,
 	       cores,
 	       n_keep);
-	printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
-	       n_get_bulk, n_put_bulk,
-	       use_constant_values);
+	if (n_max_bulk != 0)
+		printf("n_max_bulk=%3u ",
+		       n_max_bulk);
+	else
+		printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
+		       n_get_bulk, n_put_bulk,
+		       use_constant_values);
 
 	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
 		printf("mempool is not full\n");
@@ -312,16 +377,37 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 static int
 do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cache)
 {
+	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64, 128, 256,
+			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
 	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
 	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
 	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
+	unsigned int *max_bulk_ptr;
 	unsigned int *get_bulk_ptr;
 	unsigned int *put_bulk_ptr;
 	unsigned int *keep_ptr;
 	int ret;
 
+	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
+		for (max_bulk_ptr = bulk_tab_max; *max_bulk_ptr; max_bulk_ptr++) {
+
+			if (*keep_ptr < *max_bulk_ptr)
+				continue;
+
+			use_external_cache = external_cache;
+			use_constant_values = 0;
+			n_max_bulk = *max_bulk_ptr;
+			n_get_bulk = 0;
+			n_put_bulk = 0;
+			n_keep = *keep_ptr;
+			ret = launch_cores(mp, cores);
+			if (ret < 0)
+				return -1;
+		}
+	}
+
 	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
 		for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
 			for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
@@ -331,6 +417,7 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 
 				use_external_cache = external_cache;
 				use_constant_values = 0;
+				n_max_bulk = 0;
 				n_get_bulk = *get_bulk_ptr;
 				n_put_bulk = *put_bulk_ptr;
 				n_keep = *keep_ptr;
@@ -348,6 +435,7 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 			}
 		}
 	}
+
 	return 0;
 }
 
-- 
2.43.0

