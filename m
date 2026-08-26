Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E4C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0690540678;
	Wed, 26 Aug 2026 04:01:58 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id F2B6240693
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:55 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so1844185ad.0
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709715;
 x=1788314515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YEorfpKWVl7XtPmhsG2u9y75UNxKlwA/2cDufQAMfgQ=;
 b=zS/ak6ymdGK1ynS8lc92JweKEuihUxBhrd7goleLYTLUSvNhJyXGF/Dro8o7yRMrTr
 hrqVn+atku9dDut594KjoWS9h+ifdAXyEYAjhc849hde45MC3RjVdNrqsSU0ioFdW8h1
 afpRRQn1r+w2LeH05rX7klPIk+yaEUR354qXLF2mrxzQAnkOJ0GV+pLRtvDJVHFSTwbO
 eMohBicqevgIX1Tfa288X14hHlJRP7XCfMPQzL3BGubAdXN7MMNaxHawNSVBgO+lONFE
 RCyowa2T346bCHyxC9yTUyZwrrfzs++2N6B0oiR+hvpNEB6Gpf2HuYqQM8HY2a6PUkFu
 vRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709715; x=1788314515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YEorfpKWVl7XtPmhsG2u9y75UNxKlwA/2cDufQAMfgQ=;
 b=IPidBGHn99FRGwZsssD5nR00z+hgJ2DDyZyeueBBdL/YkHzHktIVuvO/TCuVhP7vHx
 PrhzNrPJOoppXiCz/nhp1zRSY5rxfQJjtH2slLwKLAu8yKNyiZYbePAmcSBtaTcNAOjP
 psOGsaoXOIohIWdIXKJcLSRJ+rqI6jYV7IkVnVthdC+q/3oKfmSCCgNRagjG1Rh9OyFE
 Uq+VXJFzYvovadq4Ndpc5ZsF1uwGmhyF1PstM33XaDkFpebo2vSkCr6EstPqaMR7a+8I
 Vw2pWdyt1QSS4XYC7YZWhc2VtqgJqINEACOJpzOfJ8e//2Wat6VQ9IQps4dMXLdTSLl6
 4y7A==
X-Gm-Message-State: AFuF++k4QrZn+MwlEwrso2mmtkYPrjeSXUcBdBUSmyYpYQaS0mmH83cg
 EnPkkDzE4usQaN+UiySWjC7X4lNs7CK/TPUKpM+e9lZhRAICijd4UFQI2UvK1aFHVHfcDwIwsFz
 Hw4ask90=
X-Gm-Gg: AR+sD10Aelvpk9+SQB9DNNvfbfGU1g8aCH4zUdrs5E/QCOFFVPjBZpjwrHaeysTF5wJ
 8TdwVU7oiML3xIJZPSE5Ss7vrwsD6v3ZvmyOTSiC4zUpByJiSlsarCnF+BdORBK+5CCt/gruNAq
 TZ1zjmMsXQCp5G+lbAn1iwoL561ObKKOtBanS+oaQgo1FbD5FtLeiWC/M2J+TYilpaDiVSKRBf2
 jiqhjR71wEak6xuoM8+i/SxfEcV6sZtPQQAytThxbC1uNE1FIWyEAzN3rX3xqzOIDQUD5ZbTO/1
 bg0VkNTH6NX4ujDjnkVSFezlFft6dCspZhqR3uxqCqQZOeBUJ6PcFw49dtpeFDl2I/+0VhBlrNw
 6GlpRuYkhvhqcxU8f0Nbm6QJdbF9qt2bDeGHerXKbWPRXbF0+1i6s/t2LFjbLNsVas0/jSNa+Cd
 TYj5JEEM3F+qvuDoJcZXFxSmzCLKlZxu++jxXjcN7HnCLpW/bPIrhYMiVH1bN5Rz4jJR5yHbvrK
 qcn2S/XKG1SwJ64PX+aCKuH7QVRZ8Ez3EUzFQ==
X-Received: by 2002:a17:90b:280a:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-3966d1e226bmr7225040a91.4.1787709714886; 
 Tue, 25 Aug 2026 19:01:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 5/5] app/test/mempool_perf: adjust test to work with many
 cores
Date: Tue, 25 Aug 2026 18:56:47 -0700
Message-ID: <20260826020133.2644805-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826020133.2644805-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On a system with many lcores this test both fails to allocate on a
machine with modest memory and runs far past the 10 minute perf-test
timeout.  With enough hugepages for the largest mempool, all four
variants time out, including the single core one.

Size the four mempools by the number of cores actually exercised
rather than by rte_lcore_count(), and report a shortfall as
TEST_SKIPPED rather than a failure.  Run the largest core count
first in the combined test, so a machine which cannot fit it skips
immediately instead of spending minutes on the smaller runs.

Reduce the time per test point from 1 second to 200 ms and drop the
n_keep values which do not mark a change in behaviour, keeping 32,
512 and 32768.  For bulk sizes keep 1, 4, CACHE_LINE_BURST, 32, 64,
RTE_MEMPOOL_CACHE_MAX_SIZE / 2 and RTE_MEMPOOL_CACHE_MAX_SIZE; the
second to last is the bounce buffer limit above which requests
bypass the cache.  Replay a subset of those with compile time
constant values rather than the whole get/put diagonal, since
mempools are commonly used with constant request sizes and those
paths still need covering.

The elapsed time is only checked between calls to test_loop(), and
one call did a fixed number of objects.  A small bulk size needs
many more mempool operations for those objects, and each operation
is much more expensive when many cores contend for the ring, so with
bulk size 1 on 32 cores a single call took over 50 seconds and
TIME_MS could not bound anything:

  n_keep=32768 n_get_bulk=1 n_put_bulk=1 elapsed_ms=53431

Limit the mempool operations per call instead of the objects, and
return the number of objects handled so the reported rate stays
correct.

Each test point also launches and joins every lcore, which costs
about 2 ms on one core but over a second on 32, so use a reduced set
of get/put bulk sizes above two cores.

Print the elapsed time of each point and flush before measuring, so
a run killed by a timeout shows where it got to.

On a 32 lcore system with 10 GB of hugepages:

  mempool_perf_autotest           timeout -> 414s
  mempool_perf_autotest_1core     timeout ->  83s
  mempool_perf_autotest_2cores    timeout ->  84s
  mempool_perf_autotest_allcores  timeout -> 200s

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mempool_perf.c | 179 +++++++++++++++++++++++------------
 1 file changed, 120 insertions(+), 59 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index e164eca788..8313bdc1fc 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -43,7 +43,7 @@
  *    Each core get *n_keep* objects per bulk of *n_get_bulk*. Then,
  *    objects are put back in the pool per bulk of *n_put_bulk*.
  *
- *    This sequence is done during TIME_S seconds.
+ *    This sequence is done during TIME_MS milliseconds.
  *
  *    This test is done on the following configurations:
  *
@@ -61,30 +61,32 @@
  *
  *    - Pseudorandom max bulk size (*n_max_bulk*)
  *
- *      - Max bulk from CACHE_LINE_BURST to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE,
- *        where CACHE_LINE_BURST is the number of pointers fitting into one CPU cache line.
+ *      - Max bulk: CACHE_LINE_BURST, 32, 64, RTE_MEMPOOL_CACHE_MAX_SIZE / 2
+ *        and RTE_MEMPOOL_CACHE_MAX_SIZE, where CACHE_LINE_BURST is the
+ *        number of pointers fitting into one CPU cache line.
  *
  *    - Fixed bulk size (*n_get_bulk*, *n_put_bulk*)
  *
- *      - Bulk get from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
- *      - Bulk put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE
- *      - Bulk get and put from 1 to 256, and RTE_MEMPOOL_CACHE_MAX_SIZE, compile time constant
+ *      - Bulk get: 1, 4, CACHE_LINE_BURST, 32, 64,
+ *        RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE
+ *      - Bulk put: 1, 4, CACHE_LINE_BURST, 32, 64,
+ *        RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE
+ *      - Bulk get and put of 1, CACHE_LINE_BURST, 32 and
+ *        RTE_MEMPOOL_CACHE_MAX_SIZE, compile time constant
  *
  *    - Number of kept objects (*n_keep*)
  *
- *      - 32
- *      - 128
- *      - 512
- *      - 2048
- *      - 8192
- *      - 32768
+ *      - 32, 512, 32768
  */
 
-#define TIME_S 1
+#define TIME_MS 200
+/* above this many cores, use the reduced bulk size tables */
+#define MANYCORE_THRESHOLD 2
 #define MEMPOOL_ELT_SIZE 2048
 #define MAX_KEEP 32768
 #define N (128 * MAX_KEEP)
-#define MEMPOOL_SIZE ((rte_lcore_count()*(MAX_KEEP+RTE_MEMPOOL_CACHE_MAX_SIZE*2))-1)
+/* max mempool operations per call to test_loop() */
+#define MAX_OPS (256 * 1024)
 
 /* Number of pointers fitting into one cache line. */
 #define CACHE_LINE_BURST (RTE_CACHE_LINE_SIZE / sizeof(uintptr_t))
@@ -147,9 +149,21 @@ test_loop(struct rte_mempool *mp, struct rte_mempool_cache *cache,
 	alignas(RTE_CACHE_LINE_SIZE) void *obj_table[MAX_KEEP];
 	unsigned int idx;
 	unsigned int i;
+	unsigned int iter;
 	int ret;
 
-	for (i = 0; likely(i < (N / x_keep)); i++) {
+	/*
+	 * The elapsed time is only checked between calls to this function,
+	 * so bound the work done by one call.  A small bulk size means many
+	 * more mempool operations for the same number of objects, and each
+	 * operation is far more expensive when many cores contend, so limit
+	 * the operations rather than the objects.
+	 */
+	iter = MAX_OPS / (x_keep / x_get_bulk + x_keep / x_put_bulk);
+	if (iter == 0)
+		iter = 1;
+
+	for (i = 0; likely(i < iter); i++) {
 		/* get x_keep objects by bulk of x_get_bulk */
 		for (idx = 0; idx < x_keep; idx += x_get_bulk) {
 			ret = rte_mempool_generic_get(mp,
@@ -171,7 +185,7 @@ test_loop(struct rte_mempool *mp, struct rte_mempool_cache *cache,
 		}
 	}
 
-	return 0;
+	return iter * x_keep;
 }
 
 static __rte_always_inline int
@@ -215,7 +229,7 @@ test_loop_random(struct rte_mempool *mp, struct rte_mempool_cache *cache,
 		}
 	}
 
-	return 0;
+	return N;
 }
 
 static int
@@ -258,7 +272,7 @@ per_lcore_mempool_test(void *arg)
 
 	start_cycles = rte_get_timer_cycles();
 
-	while (time_diff/hz < TIME_S) {
+	while (time_diff < hz * TIME_MS / 1000) {
 		if (n_max_bulk != 0)
 			ret = test_loop_random(mp, cache, n_keep, n_max_bulk);
 		else if (!use_constant_values)
@@ -289,7 +303,7 @@ per_lcore_mempool_test(void *arg)
 
 		end_cycles = rte_get_timer_cycles();
 		time_diff = end_cycles - start_cycles;
-		stats[lcore_id].enq_count += N;
+		stats[lcore_id].enq_count += ret;
 	}
 
 	stats[lcore_id].duration_cycles = time_diff;
@@ -312,6 +326,7 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 	int ret;
 	unsigned int cores_save = cores;
 	double hz = rte_get_timer_hz();
+	uint64_t start = rte_get_timer_cycles();
 
 	rte_atomic_store_explicit(&synchro, 0, rte_memory_order_relaxed);
 
@@ -330,7 +345,10 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 		       n_get_bulk, n_put_bulk,
 		       use_constant_values);
 
-	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
+	/* show progress if test is killed by timeout */
+	fflush(stdout);
+
+	if (rte_mempool_avail_count(mp) != mp->size) {
 		printf("mempool is not full\n");
 		return -1;
 	}
@@ -368,7 +386,8 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 			rate += (double)stats[lcore_id].enq_count * hz /
 					(double)stats[lcore_id].duration_cycles;
 
-	printf("rate_persec=%10" PRIu64 "\n", rate);
+	printf("rate_persec=%10" PRIu64 " elapsed_ms=%4.0f\n", rate,
+	       (rte_get_timer_cycles() - start) * 1000.0 / hz);
 
 	return 0;
 }
@@ -377,19 +396,34 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 static int
 do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cache)
 {
-	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64, 128, 256,
-			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
+	unsigned int bulk_tab_max[] = { CACHE_LINE_BURST, 32, 64,
+			RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int bulk_tab_get[] = { 1, 4, CACHE_LINE_BURST, 32, 64,
+			RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64,
+			RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	/* launch overhead dominates with many cores, so test fewer sizes */
+	unsigned int bulk_tab_get_manycore[] = { 1, 32,
+			RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	unsigned int bulk_tab_put_manycore[] = { 1, 32,
+			RTE_MEMPOOL_CACHE_MAX_SIZE / 2, RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
+	/* subset of the get/put bulk sizes, replayed with constant values */
+	unsigned int bulk_tab_const[] = { 1, CACHE_LINE_BURST, 32,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
-			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
-	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
+	unsigned int keep_tab[] = { 32, 512, 32768, 0 };
 	unsigned int *max_bulk_ptr;
 	unsigned int *get_bulk_ptr;
 	unsigned int *put_bulk_ptr;
 	unsigned int *keep_ptr;
+	unsigned int *get_tab = bulk_tab_get;
+	unsigned int *put_tab = bulk_tab_put;
 	int ret;
 
+	if (cores > MANYCORE_THRESHOLD) {
+		get_tab = bulk_tab_get_manycore;
+		put_tab = bulk_tab_put_manycore;
+	}
+
 	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
 		for (max_bulk_ptr = bulk_tab_max; *max_bulk_ptr; max_bulk_ptr++) {
 
@@ -409,8 +443,8 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 	}
 
 	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
-		for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
-			for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
+		for (get_bulk_ptr = get_tab; *get_bulk_ptr; get_bulk_ptr++) {
+			for (put_bulk_ptr = put_tab; *put_bulk_ptr; put_bulk_ptr++) {
 
 				if (*keep_ptr < *get_bulk_ptr || *keep_ptr < *put_bulk_ptr)
 					continue;
@@ -424,18 +458,34 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 				ret = launch_cores(mp, cores);
 				if (ret < 0)
 					return -1;
-
-				/* replay test with constant values */
-				if (n_get_bulk == n_put_bulk) {
-					use_constant_values = 1;
-					ret = launch_cores(mp, cores);
-					if (ret < 0)
-						return -1;
-				}
 			}
 		}
 	}
 
+	/*
+	 * Replay a subset of the bulk sizes with compile time constant
+	 * values, to cover the inlined constant bulk paths.  Only the
+	 * n_get_bulk == n_put_bulk diagonal is valid here, and a subset
+	 * of it is enough to catch a regression in those paths.
+	 */
+	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
+		for (get_bulk_ptr = bulk_tab_const; *get_bulk_ptr; get_bulk_ptr++) {
+
+			if (*keep_ptr < *get_bulk_ptr)
+				continue;
+
+			use_external_cache = external_cache;
+			use_constant_values = 1;
+			n_max_bulk = 0;
+			n_get_bulk = *get_bulk_ptr;
+			n_put_bulk = *get_bulk_ptr;
+			n_keep = *keep_ptr;
+			ret = launch_cores(mp, cores);
+			if (ret < 0)
+				return -1;
+		}
+	}
+
 	return 0;
 }
 
@@ -449,22 +499,25 @@ do_all_mempool_perf_tests(unsigned int cores)
 	const char *mp_cache_ops;
 	const char *mp_nocache_ops;
 	const char *default_pool_ops;
+	unsigned int mempool_size = cores *
+		(MAX_KEEP + RTE_MEMPOOL_CACHE_MAX_SIZE * 2) - 1;
 	int ret = -1;
 
 	/* create a mempool (without cache) */
-	mp_nocache = rte_mempool_create("perf_test_nocache", MEMPOOL_SIZE,
+	mp_nocache = rte_mempool_create("perf_test_nocache", mempool_size,
 					MEMPOOL_ELT_SIZE, 0, 0,
 					NULL, NULL,
 					my_obj_init, NULL,
 					SOCKET_ID_ANY, 0);
 	if (mp_nocache == NULL) {
 		printf("cannot allocate mempool (without cache)\n");
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	mp_nocache_ops = rte_mempool_get_ops(mp_nocache->ops_index)->name;
 
 	/* create a mempool (with cache) */
-	mp_cache = rte_mempool_create("perf_test_cache", MEMPOOL_SIZE,
+	mp_cache = rte_mempool_create("perf_test_cache", mempool_size,
 				      MEMPOOL_ELT_SIZE,
 				      RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 				      NULL, NULL,
@@ -472,6 +525,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 				      SOCKET_ID_ANY, 0);
 	if (mp_cache == NULL) {
 		printf("cannot allocate mempool (with cache)\n");
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	mp_cache_ops = rte_mempool_get_ops(mp_cache->ops_index)->name;
@@ -480,12 +534,13 @@ do_all_mempool_perf_tests(unsigned int cores)
 
 	/* Create a mempool (without cache) based on Default handler */
 	default_pool_nocache = rte_mempool_create_empty("default_pool_nocache",
-			MEMPOOL_SIZE,
+			mempool_size,
 			MEMPOOL_ELT_SIZE,
 			0, 0,
 			SOCKET_ID_ANY, 0);
 	if (default_pool_nocache == NULL) {
 		printf("cannot allocate %s mempool (without cache)\n", default_pool_ops);
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	if (rte_mempool_set_ops_byname(default_pool_nocache, default_pool_ops, NULL) < 0) {
@@ -494,18 +549,20 @@ do_all_mempool_perf_tests(unsigned int cores)
 	}
 	if (rte_mempool_populate_default(default_pool_nocache) < 0) {
 		printf("cannot populate %s mempool\n", default_pool_ops);
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	rte_mempool_obj_iter(default_pool_nocache, my_obj_init, NULL);
 
 	/* Create a mempool (with cache) based on Default handler */
 	default_pool_cache = rte_mempool_create_empty("default_pool_cache",
-			MEMPOOL_SIZE,
+			mempool_size,
 			MEMPOOL_ELT_SIZE,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 			SOCKET_ID_ANY, 0);
 	if (default_pool_cache == NULL) {
 		printf("cannot allocate %s mempool (with cache)\n", default_pool_ops);
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	if (rte_mempool_set_ops_byname(default_pool_cache, default_pool_ops, NULL) < 0) {
@@ -514,6 +571,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 	}
 	if (rte_mempool_populate_default(default_pool_cache) < 0) {
 		printf("cannot populate %s mempool\n", default_pool_ops);
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	rte_mempool_obj_iter(default_pool_cache, my_obj_init, NULL);
@@ -584,27 +642,30 @@ test_mempool_perf_allcores(void)
 static int
 test_mempool_perf(void)
 {
-	int ret = -1;
-
-	/* performance test with 1, 2 and max cores */
-	if (do_all_mempool_perf_tests(1) < 0)
-		goto err;
-	if (rte_lcore_count() == 1)
-		goto done;
-
-	if (do_all_mempool_perf_tests(2) < 0)
-		goto err;
-	if (rte_lcore_count() == 2)
-		goto done;
+	unsigned int cores = rte_lcore_count();
+	int ret;
 
-	if (do_all_mempool_perf_tests(rte_lcore_count()) < 0)
-		goto err;
+	/*
+	 * Performance test with max, 1 and 2 cores.
+	 *
+	 * The largest configuration needs the most memory, so run it
+	 * first: on a system which cannot fit it, the mempool allocation
+	 * fails right away and the test is skipped without first spending
+	 * minutes on the smaller core counts.
+	 */
+	if (cores > 2) {
+		ret = do_all_mempool_perf_tests(cores);
+		if (ret != 0)
+			return ret;
+	}
 
-done:
-	ret = 0;
+	ret = do_all_mempool_perf_tests(1);
+	if (ret != 0)
+		return ret;
+	if (cores == 1)
+		return 0;
 
-err:
-	return ret;
+	return do_all_mempool_perf_tests(2);
 }
 
 REGISTER_PERF_TEST(mempool_perf_autotest, test_mempool_perf);
-- 
2.53.0

