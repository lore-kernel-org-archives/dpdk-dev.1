Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A1ACD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D00140650;
	Fri, 29 May 2026 19:14:27 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 015B840662
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:24 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3045c195251so8120717eec.1
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074864;
 x=1780679664; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXfyDhLM2GXfmRn0PxZkfQwZaB1smm0qmpGSfdU5zGw=;
 b=HM9/yWZNxuRpcFOHQBoVkQXZVXcSTrA7fhlpLaxchw1S3vhwZd3iqllUgsC5Pmn9q8
 xdKknJXi3NuYPxRK5TuKGcoMgC98TS2K0/WD9romnFJSLbVlb9G44cDGFTnEUpKNP2qE
 Zciq/75J0KIV2NJFPes7lYSnd3PFYKkuWO04uk/51flAe4Dw79wvs+p3O4GX1Ltet9R4
 mNB/ZW/pppRjtV9OALAPj+eJTIGoz23lO+ymf5E8Lsmh3BDNuGqpZuSN9Cjt+UsKxI0d
 cECBxj8lof+SmKRcS1uIKvIlJgWroAZGAXbpsBGI0JtIwf3QdcKhin25BCeQlWGNW9Jb
 hUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074864; x=1780679664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VXfyDhLM2GXfmRn0PxZkfQwZaB1smm0qmpGSfdU5zGw=;
 b=cxD72476eCR3mEbbSFSCly/tGKSjMJfX+hvf1LtEZwofpbz0Dy2Pb5aIwwaMdccfH9
 MT+XUoeomhBZZ5+vHdlk8yvZr8W717qagHXiIoQQfxahE/+ebfsXy6+h/Aa8CEvZbqwv
 sh51Bu308C5gD7weCnZjz7KAKhv0Sv3ppxv4T6kNH29JFQF21n++W7an7qU2krizYBhJ
 mS4v1vcIb3SSzVCaOOJfbPlRs11OWcZoT4M/e+CDUCLLSz/bGoRCpRRra4k6H7duRc2u
 9jAuAeXT5FT9+3gXhU5EXEeRx56Xrnl1bzHIksyb5syOYOhnVexWeJpRjl3x1N2yEyKQ
 Y8MQ==
X-Gm-Message-State: AOJu0Yw23UKOnHGQ4H9rZMenc51m7slo8hj1nunh6TFuydSlnzdYEBB1
 UAeKxlhymr9Hn3AG3q7k5/eCAVuLk83gBmudQ4yddsUqxrB41l3RtUu5wlJ2n3ZCHcOyvURv81C
 maMPP
X-Gm-Gg: Acq92OG4ABb8oRnKDhF7FCFa6JqY2Dd+QyxsEsjIq2P6wZCmuVj2llFmUG/XU7ywy0W
 u4OPPkMWcqZylxbslitaPYnYf111m5WIPvFzW5zY2OwQYLMEiXQD+UyxghN5RgDjWeRPewNpsth
 1AhjaQ0DqATwdRSw8auqQoSpHxFuG4Qzxs0KHMKMWi+A4AhBABIyoI03Fi6bJpvDoUgsU6iQEAv
 YiyzMmCsXNLf4C4FjEvPZwC2zLFfQSmhUNo1L3BK/qS/RyRIeS4obSdHNluBdPPgfW9nOFxepoJ
 l7lvnYojvIap7lD9KZOh2OsumMwvL7sjK8EjAe0X/ogKPTKdPMg6WrRAZdkQEwH5+p6hIprfw5a
 /vfYVa7eYRLbPhYO0ScMBN1L5KXpPc9BllITegpLE+xrck+nGY0s3FxZ5yWaQspyKD3wzogVj+B
 zaYczo1SWl6s7BnU/wPEN/hbVAU7UqSIM9EoxyqXeshDR8NnjsrzT/ilHYC+uho0apuvsEnecC
X-Received: by 2002:a05:7300:e683:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-304fa61a258mr379069eec.25.1780074863772; 
 Fri, 29 May 2026 10:14:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 3/7] app/test/mempool_perf: size mempool by tested cores
Date: Fri, 29 May 2026 10:10:56 -0700
Message-ID: <20260529171417.526892-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

The mempool size is computed from rte_lcore_count() so on systems
with many lcores the test requires multiple GB of hugepages even
for the single-core and dual-core variants.  On a 20 lcore system
with 2 GB of hugepages the test fails with:

  cannot populate ring_mp_mc mempool
  Test Failed

Size the four mempools by the number of cores actually exercised.

Return TEST_SKIPPED rather than -1 when allocation or populate of
a mempool fails, so insufficient memory is reported as a skip and
not as a test failure.  Propagate the skip through the combined
mempool_perf_autotest wrapper.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_mempool_perf.c | 44 +++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index e164eca788..19591ad0c9 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -84,7 +84,6 @@
 #define MEMPOOL_ELT_SIZE 2048
 #define MAX_KEEP 32768
 #define N (128 * MAX_KEEP)
-#define MEMPOOL_SIZE ((rte_lcore_count()*(MAX_KEEP+RTE_MEMPOOL_CACHE_MAX_SIZE*2))-1)
 
 /* Number of pointers fitting into one cache line. */
 #define CACHE_LINE_BURST (RTE_CACHE_LINE_SIZE / sizeof(uintptr_t))
@@ -330,7 +329,7 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 		       n_get_bulk, n_put_bulk,
 		       use_constant_values);
 
-	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
+	if (rte_mempool_avail_count(mp) != mp->size) {
 		printf("mempool is not full\n");
 		return -1;
 	}
@@ -449,22 +448,25 @@ do_all_mempool_perf_tests(unsigned int cores)
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
@@ -472,6 +474,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 				      SOCKET_ID_ANY, 0);
 	if (mp_cache == NULL) {
 		printf("cannot allocate mempool (with cache)\n");
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	mp_cache_ops = rte_mempool_get_ops(mp_cache->ops_index)->name;
@@ -480,12 +483,13 @@ do_all_mempool_perf_tests(unsigned int cores)
 
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
@@ -494,18 +498,20 @@ do_all_mempool_perf_tests(unsigned int cores)
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
@@ -514,6 +520,7 @@ do_all_mempool_perf_tests(unsigned int cores)
 	}
 	if (rte_mempool_populate_default(default_pool_cache) < 0) {
 		printf("cannot populate %s mempool\n", default_pool_ops);
+		ret = TEST_SKIPPED;
 		goto err;
 	}
 	rte_mempool_obj_iter(default_pool_cache, my_obj_init, NULL);
@@ -584,27 +591,22 @@ test_mempool_perf_allcores(void)
 static int
 test_mempool_perf(void)
 {
-	int ret = -1;
+	int ret;
 
 	/* performance test with 1, 2 and max cores */
-	if (do_all_mempool_perf_tests(1) < 0)
-		goto err;
+	ret = do_all_mempool_perf_tests(1);
+	if (ret != 0)
+		return ret;
 	if (rte_lcore_count() == 1)
-		goto done;
+		return 0;
 
-	if (do_all_mempool_perf_tests(2) < 0)
-		goto err;
+	ret = do_all_mempool_perf_tests(2);
+	if (ret != 0)
+		return ret;
 	if (rte_lcore_count() == 2)
-		goto done;
-
-	if (do_all_mempool_perf_tests(rte_lcore_count()) < 0)
-		goto err;
+		return 0;
 
-done:
-	ret = 0;
-
-err:
-	return ret;
+	return do_all_mempool_perf_tests(rte_lcore_count());
 }
 
 REGISTER_PERF_TEST(mempool_perf_autotest, test_mempool_perf);
-- 
2.53.0

