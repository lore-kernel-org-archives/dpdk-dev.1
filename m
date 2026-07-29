Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA2C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:57:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D30354060A;
	Wed, 29 Jul 2026 19:57:24 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 430A840609
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:21 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cacf197759so19730855ad.2
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347840;
 x=1785952640; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ild0PL9nN4moFYFPXZHkk3OrwDVXJ7RtMHi/waySTNs=;
 b=yW8EXVHYiJ0IE8V75+k64ydFurJUP83pRwcf7Ql57MXAtmRyYgMwjyADlWizcY9aCj
 IQwLRy4GWcKSOQrPwe2O4bRbuQFpOV01ZMbG3sc0BTISJg/nBSe4NHZJNFx+Y4EqYvs9
 RwNundNkmuBflogdVdz7gp6G3Cd3EBWvhCHohtu0rgJxEwBGnh0DRbhVeGWVHkXGUQkw
 UmbxgXl1IkNpa9JNU48OPQ4iBeZ3Nc+729YUcp42qErBU+HsWswYf4aWV15AnbP3R/8a
 IcYoeQ6frD32ERE+GgVCcN7m5Wo0y6X1mNTclYLVsZKIn2ZIYWbksAibp1wxJ0DErJYn
 o3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347840; x=1785952640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ild0PL9nN4moFYFPXZHkk3OrwDVXJ7RtMHi/waySTNs=;
 b=GcCxuNBh7Zl7T49Sz9WVaebgeKuyTCi9W6agABRJxoV5G3ugRivDeCihts7oDbN5G1
 47lVbzgsClShznyylpOmGy2aQ81C9RWKjM81ZPBcy1aXgbAIurisse7SghCH8Hl+QDo/
 obM3ZxzNglglGTe0ybHsrvnyJ4pqBHNwjExS5eZl+0daDR/qbCB/2FbWJeDGtePxALQc
 IWWsU/uEkpF4qe76HuYmogZlGWVKqR3JliyKawm8iK/zFtMycl3WOYMhpDxcGya/fz1e
 IDazosh+111BLeqfcCOQt5+Nn/dYYO43A8GH4qVv9f1fvX/tgMbYQ3MVYudMTMgi8L9G
 qQLQ==
X-Gm-Message-State: AOJu0Yzb5dMyq9M/wK9P6y30Vd9WVMv+aI0WZl578Y7cx9A7hpNWKXKs
 h6NAdYk74JOh7NjPdnEIFkHWuHBqcPJ4YEll+O0SoENYwIoQR57P1se0bGGoHt18GLsF4ugTB+b
 +dFsX
X-Gm-Gg: AR+sD113Sh57cJHcHgpa/UnNxbPVGmBL8lqCZmGJlATxsF3zRMoIjECsa4TX6Jjx7D1
 S09uvECmgyKHYiF+Y3u+F+AU3+zQiI7uknnLMSFdRpJEOjqyJsizRQOhhliYYQpWQCQKlDF+8sJ
 0F06DnXtsfOdxOoOTcRGs2PyHEHN9qEHuUkraWiMn9fcNm28PrTTLRsLE+vrli2XHH5KGWNEFpB
 01Z5vN6M0O1BN8LP5faalZH9QgGSC0czgVc73GFbq9OrRcjreuSm0rUOWug3iMZxgMf149kQoHy
 KlMOzU4WW6WjuRvAJOFB+7wevGSFnnPXTuiD+ELa+vdjPbfK8HjK+NvcIkSh9evnp3VYaFHNkQJ
 4w0oE0pVgAf3ZAhI6TUa/aQ8YuiDHt8qFzpeaNjrEi6ejuZdyNFquhUIMsZb+Jt0P83wR9MsESr
 r4RFSLMwMcIYCCxFOCHOvUK4I44tHHVKpjsKHdYs20sXMUfp4lU55fuk+FZJUl7wpGPq87DDSYq
 VpyfSXi3tdzGs6bnlwnptMaO3A=
X-Received: by 2002:a17:903:32ce:b0:2cc:fd6c:c5ae with SMTP id
 d9443c01a7336-2d01605016emr81711195ad.38.1785347840180; 
 Wed, 29 Jul 2026 10:57:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 02/32] test: remove test for rte_smp_mb
Date: Wed, 29 Jul 2026 10:53:55 -0700
Message-ID: <20260729175715.165120-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

The DPDK version of SMP barriers is deprecated and
being removed. Drop the test as no longer relevant.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build    |   1 -
 app/test/test_barrier.c | 288 ----------------------------------------
 2 files changed, 289 deletions(-)
 delete mode 100644 app/test/test_barrier.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..6df9dfa222 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -28,7 +28,6 @@ source_file_deps = {
     'test_alarm.c': [],
     'test_argparse.c': ['argparse'],
     'test_atomic.c': ['hash'],
-    'test_barrier.c': [],
     'test_bitcount.c': [],
     'test_bitmap.c': [],
     'test_bitops.c': [],
diff --git a/app/test/test_barrier.c b/app/test/test_barrier.c
deleted file mode 100644
index 925a88b68a..0000000000
--- a/app/test/test_barrier.c
+++ /dev/null
@@ -1,288 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2018 Intel Corporation
- */
-
- /*
-  * This is a simple functional test for rte_smp_mb() implementation.
-  * I.E. make sure that LOAD and STORE operations that precede the
-  * rte_smp_mb() call are globally visible across the lcores
-  * before the LOAD and STORE operations that follows it.
-  * The test uses simple implementation of Peterson's lock algorithm
-  * (https://en.wikipedia.org/wiki/Peterson%27s_algorithm)
-  * for two execution units to make sure that rte_smp_mb() prevents
-  * store-load reordering to happen.
-  * Also when executed on a single lcore could be used as a approximate
-  * estimation of number of cycles particular implementation of rte_smp_mb()
-  * will take.
-  */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdint.h>
-#include <inttypes.h>
-
-#include <rte_memory.h>
-#include <rte_per_lcore.h>
-#include <rte_launch.h>
-#include <rte_eal.h>
-#include <rte_lcore.h>
-#include <rte_pause.h>
-#include <rte_random.h>
-#include <rte_cycles.h>
-#include <rte_vect.h>
-#include <rte_debug.h>
-
-#include "test.h"
-
-#define ADD_MAX		8
-#define ITER_MAX	0x1000000
-
-enum plock_use_type {
-	USE_MB,
-	USE_SMP_MB,
-	USE_NUM
-};
-
-struct plock {
-	volatile uint32_t flag[2];
-	volatile uint32_t victim;
-	enum plock_use_type utype;
-};
-
-/*
- * Lock plus protected by it two counters.
- */
-struct plock_test {
-	struct plock lock;
-	uint64_t val;
-	uint64_t iter;
-};
-
-/*
- * Each active lcore shares plock_test struct with it's left and right
- * neighbours.
- */
-struct lcore_plock_test {
-	struct plock_test *pt[2]; /* shared, lock-protected data */
-	uint64_t sum[2];          /* local copy of the shared data */
-	uint64_t iter;            /* number of iterations to perform */
-	uint32_t lc;              /* given lcore id */
-};
-
-static inline void
-store_load_barrier(uint32_t utype)
-{
-	if (utype == USE_MB)
-		rte_mb();
-	else if (utype == USE_SMP_MB)
-		rte_smp_mb();
-	else
-		RTE_VERIFY(0);
-}
-
-/*
- * Peterson lock implementation.
- */
-static void
-plock_lock(struct plock *l, uint32_t self)
-{
-	uint32_t other;
-
-	other = self ^ 1;
-
-	l->flag[self] = 1;
-	rte_smp_wmb();
-	l->victim = self;
-
-	store_load_barrier(l->utype);
-
-	while (l->flag[other] == 1 && l->victim == self)
-		rte_pause();
-	rte_smp_rmb();
-}
-
-static void
-plock_unlock(struct plock *l, uint32_t self)
-{
-	rte_smp_wmb();
-	l->flag[self] = 0;
-}
-
-static void
-plock_reset(struct plock *l, enum plock_use_type utype)
-{
-	memset(l, 0, sizeof(*l));
-	l->utype = utype;
-}
-
-/*
- * grab the lock, update both counters, release the lock.
- */
-static void
-plock_add(struct plock_test *pt, uint32_t self, uint32_t n)
-{
-	plock_lock(&pt->lock, self);
-	pt->iter++;
-	pt->val += n;
-	plock_unlock(&pt->lock, self);
-}
-
-static int
-plock_test1_lcore(void *data)
-{
-	uint64_t tm;
-	uint32_t lc, ln;
-	uint64_t i, n;
-	struct lcore_plock_test *lpt;
-
-	lpt = data;
-	lc = rte_lcore_id();
-
-	/* find lcore_plock_test struct for given lcore */
-	for (ln = rte_lcore_count(); ln != 0 && lpt->lc != lc; lpt++, ln--)
-		;
-
-	if (ln == 0) {
-		printf("%s(%u) error at init\n", __func__, lc);
-		return -1;
-	}
-
-	n = rte_rand() % ADD_MAX;
-	tm = rte_get_timer_cycles();
-
-	/*
-	 * for each iteration:
-	 * - update shared, locked protected data in a safe manner
-	 * - update local copy of the shared data
-	 */
-	for (i = 0; i != lpt->iter; i++) {
-
-		plock_add(lpt->pt[0], 0, n);
-		plock_add(lpt->pt[1], 1, n);
-
-		lpt->sum[0] += n;
-		lpt->sum[1] += n;
-
-		n = (n + 1) % ADD_MAX;
-	}
-
-	tm = rte_get_timer_cycles() - tm;
-
-	printf("%s(%u): %" PRIu64 " iterations finished, in %" PRIu64
-		" cycles, %#Lf cycles/iteration, "
-		"local sum={%" PRIu64 ", %" PRIu64 "}\n",
-		__func__, lc, i, tm, (long double)tm / i,
-		lpt->sum[0], lpt->sum[1]);
-	return 0;
-}
-
-/*
- * For N active lcores we allocate N+1 lcore_plock_test structures.
- * Each active lcore shares one lcore_plock_test structure with its
- * left lcore neighbor and one lcore_plock_test structure with its
- * right lcore neighbor.
- * During the test each lcore updates data in both shared structures and
- * its local copies. Then at validation phase we check that our shared
- * and local data are the same.
- */
-static int
-plock_test(uint64_t iter, enum plock_use_type utype)
-{
-	int32_t rc;
-	uint32_t i, lc, n;
-	uint64_t *sum;
-	struct plock_test *pt;
-	struct lcore_plock_test *lpt;
-
-	/* init phase, allocate and initialize shared data */
-
-	n = rte_lcore_count();
-	pt = calloc(n + 1, sizeof(*pt));
-	lpt = calloc(n, sizeof(*lpt));
-	sum = calloc(n + 1, sizeof(*sum));
-
-	printf("%s(iter=%" PRIu64 ", utype=%u) started on %u lcores\n",
-		__func__, iter, utype, n);
-
-	if (pt == NULL || lpt == NULL || sum == NULL) {
-		printf("%s: failed to allocate memory for %u lcores\n",
-			__func__, n);
-		free(pt);
-		free(lpt);
-		free(sum);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i != n + 1; i++)
-		plock_reset(&pt[i].lock, utype);
-
-	i = 0;
-	RTE_LCORE_FOREACH(lc) {
-
-		lpt[i].lc = lc;
-		lpt[i].iter = iter;
-		lpt[i].pt[0] = pt + i;
-		lpt[i].pt[1] = pt + i + 1;
-		i++;
-	}
-
-	lpt[i - 1].pt[1] = pt;
-
-	for (i = 0; i != n; i++)
-		printf("lpt[%u]={lc=%u, pt={%p, %p},};\n",
-			i, lpt[i].lc, lpt[i].pt[0], lpt[i].pt[1]);
-
-
-	/* test phase - start and wait for completion on each active lcore */
-
-	rte_eal_mp_remote_launch(plock_test1_lcore, lpt, CALL_MAIN);
-	rte_eal_mp_wait_lcore();
-
-	/* validation phase - make sure that shared and local data match */
-
-	for (i = 0; i != n; i++) {
-		sum[i] += lpt[i].sum[0];
-		sum[i + 1] += lpt[i].sum[1];
-	}
-
-	sum[0] += sum[i];
-
-	rc = 0;
-	for (i = 0; i != n; i++) {
-		printf("%s: sum[%u]=%" PRIu64 ", pt[%u].val=%" PRIu64 ", pt[%u].iter=%" PRIu64 ";\n",
-			__func__, i, sum[i], i, pt[i].val, i, pt[i].iter);
-
-		/* race condition occurred, lock doesn't work properly */
-		if (sum[i] != pt[i].val || 2 * iter != pt[i].iter) {
-			printf("error: local and shared sums don't match\n");
-			rc = -1;
-		}
-	}
-
-	free(pt);
-	free(lpt);
-	free(sum);
-
-	printf("%s(utype=%u) returns %d\n", __func__, utype, rc);
-	return rc;
-}
-
-static int
-test_barrier(void)
-{
-	int32_t i, ret, rc[USE_NUM];
-
-	for (i = 0; i != RTE_DIM(rc); i++)
-		rc[i] = plock_test(ITER_MAX, i);
-
-	ret = 0;
-	for (i = 0; i != RTE_DIM(rc); i++) {
-		printf("%s for utype=%d %s\n",
-			__func__, i, rc[i] == 0 ? "passed" : "failed");
-		ret |= rc[i];
-	}
-
-	return ret;
-}
-
-REGISTER_PERF_TEST(barrier_autotest, test_barrier);
-- 
2.53.0

