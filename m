Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B3C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A25C840ED8;
	Sun, 20 Sep 2026 20:14:21 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 0C8AE40E45
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:15 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1870199a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928054;
 x=1790532854; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbUtLFZBIC7noh0JLsLKeokkHCwiGfEneA/s6iwBmRk=;
 b=erNcJc2zBQvp8NzySA5aktVh8+IseLN67xT2ceKjkVzY20kh5MTQCT46kjPVVcHAQV
 R2OmaiLGt7nVyceFPlvoMI1DCRl/EwV3pPScM+H/OJqnF3H6wzSVzJ3MgGk5/8WaSsu9
 NDaFhxMEBZsmEX4FrLqE/f7XlXG18i0dtXgOfTBxg+uElpUUftgIiNu4PJ1rHA5tsFDP
 MIwHumN4TSjfOMes7kEAPxmbl+5rExiGtkxkmt/80N3xjBFIPild7LMRQ6oLz6qOSirg
 33IREbkLUdZbteWvk8DvKXOJptHK5wmf/ejhFXscosdWjUgtNF7LfUa8ewlOhLDbcIUB
 UVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928054; x=1790532854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbUtLFZBIC7noh0JLsLKeokkHCwiGfEneA/s6iwBmRk=;
 b=JbH36N6hylk47utq1Z8YNy4Ol5wK2ZXV5It8FEFXF/V9AaWkieW4a3QFKvOm7YubEL
 5SPo5vvs+xfSMeNcMz8n/iBqyHtanNYouokspw3GafcMDpgrp6yC1KJcSVfS5/ltVZCf
 I+p8/cszJAkBjopXDZbBPKGwfyT7LFupg/aYbwa71qV54gpS+tI50K4GfQsTIQj14g+5
 z3lDl5jWDYjCdgUehVvdmMOvlEyDb1qpliwHq9gb15TOOMHM1U2861FUUHLKjwK9CjC1
 /ljY0KAdE2HbTr9uIgZaKEcHh3HwixCTXt+j2GG2FGZf7fDYauIXl9uC65Isv1M0SQhz
 z91A==
X-Gm-Message-State: AFuF++k7Md4cU/Dlb+xmese81Q431mNMm4fjIfDt56E8ofw61XI5kwIL
 zCURiBDvRznS1yMLAoZgBoc/LQC/rI4EvQ1qp7dvpcMV8+B/sSg+u4kKIhpp8ZCpHkdVgUf4+Yq
 +U0hR
X-Gm-Gg: AYBFou2MxnQEAzuAHyehoQlH+e7mNzzFVhXeJ+7GedkRgzw328MJQXzIRurbuotEJvz
 N9dE4ix0mgaG1i56C0roM+KjAI+bFSdupuvNDQra5czKpPFVZqNRbjqy0BcJ9ngjOEH27K6wOT4
 4IXSEKErIZ76kovXNO9tR2ydAJttQ/W4/6WGsyZpJ5OYvzeJq9WOlrZNjzyVQs/pNk6RKhY7O18
 SPLsXFXBDREIp+/fOwY8GOdcmzX5BxLQJgd7QeGxCnkpI0CTj/HEWhknuaa2wni5A/uhaDaCvfS
 ScUnM6FLFGGcKLVy20uvBK1uL8ZfDfFcUDIxOsXSlUlyI4wjSP/6bGpNsqNJHMUDV0hHJX7Xhx6
 exq3kGmJJGpyUIQqUGUpG6O7jg20vf4HkMQnNxTHDr6nKCEx/nKLM9pwpnT0R+mp9HPmEqqiNBi
 i09NNJQWKomtAAo9u0RTg1LtWPCeBRF0XiAwVICv6jR+9fr4wPV8XFyhsYaiyAQBsQgx2O0rW0K
 nttrlhfPk5FhneGXKev6GKGaDHTDn92+SXKNw==
X-Received: by 2002:a17:90b:2fce:b0:3a0:3888:a3f with SMTP id
 98e67ed59e1d1-3a038880bd4mr2930865a91.16.1789928053963; 
 Sun, 20 Sep 2026 11:14:13 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 19/33] test/barrier: test sequentially consistent fence only
Date: Sun, 20 Sep 2026 11:10:11 -0700
Message-ID: <20260920181347.747210-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

rte_smp_mb() is removed by this series, leaving the barrier test with
one case instead of two.  Drop the use type enum and the barrier
selector wrapper.

Convert the Peterson lock to explicit atomic accesses with relaxed
ordering, leaving rte_atomic_thread_fence(rte_memory_order_seq_cst)
as the only thing preventing store-load reordering.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_barrier.c | 105 +++++++++++++---------------------------
 1 file changed, 34 insertions(+), 71 deletions(-)

diff --git a/app/test/test_barrier.c b/app/test/test_barrier.c
index 925a88b68a..cb876d8fda 100644
--- a/app/test/test_barrier.c
+++ b/app/test/test_barrier.c
@@ -2,51 +2,41 @@
  * Copyright(c) 2010-2018 Intel Corporation
  */
 
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
+/*
+ * Functional test for rte_atomic_thread_fence(rte_memory_order_seq_cst).
+ * I.E. make sure that LOAD and STORE operations that precede the fence
+ * are globally visible across the lcores before the LOAD and STORE
+ * operations that follow it.
+ * The test uses a simple implementation of Peterson's lock algorithm
+ * (https://en.wikipedia.org/wiki/Peterson%27s_algorithm)
+ * for two execution units, since that algorithm only works if
+ * store-load reordering is prevented.
+ * Also when executed on a single lcore it can be used as an approximate
+ * estimate of the number of cycles a sequentially consistent fence takes.
+ */
 
+#include <errno.h>
 #include <stdio.h>
-#include <string.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <inttypes.h>
 
-#include <rte_memory.h>
-#include <rte_per_lcore.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
 #include <rte_pause.h>
 #include <rte_random.h>
 #include <rte_cycles.h>
-#include <rte_vect.h>
-#include <rte_debug.h>
+#include <rte_stdatomic.h>
 
 #include "test.h"
 
 #define ADD_MAX		8
 #define ITER_MAX	0x1000000
 
-enum plock_use_type {
-	USE_MB,
-	USE_SMP_MB,
-	USE_NUM
-};
-
 struct plock {
-	volatile uint32_t flag[2];
-	volatile uint32_t victim;
-	enum plock_use_type utype;
+	RTE_ATOMIC(uint32_t) flag[2];
+	RTE_ATOMIC(uint32_t) victim;
 };
 
 /*
@@ -69,19 +59,11 @@ struct lcore_plock_test {
 	uint32_t lc;              /* given lcore id */
 };
 
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
 /*
  * Peterson lock implementation.
+ * The stores below are relaxed on purpose: the sequentially consistent
+ * fence is the only thing keeping them ahead of the loads in the spin
+ * loop, so a broken fence shows up as two lcores in the critical section.
  */
 static void
 plock_lock(struct plock *l, uint32_t self)
@@ -90,29 +72,22 @@ plock_lock(struct plock *l, uint32_t self)
 
 	other = self ^ 1;
 
-	l->flag[self] = 1;
-	rte_smp_wmb();
-	l->victim = self;
+	rte_atomic_store_explicit(&l->flag[self], 1, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&l->victim, self, rte_memory_order_relaxed);
 
-	store_load_barrier(l->utype);
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
 
-	while (l->flag[other] == 1 && l->victim == self)
+	while (rte_atomic_load_explicit(&l->flag[other], rte_memory_order_relaxed) == 1 &&
+			rte_atomic_load_explicit(&l->victim, rte_memory_order_relaxed) == self)
 		rte_pause();
-	rte_smp_rmb();
-}
 
-static void
-plock_unlock(struct plock *l, uint32_t self)
-{
-	rte_smp_wmb();
-	l->flag[self] = 0;
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 }
 
 static void
-plock_reset(struct plock *l, enum plock_use_type utype)
+plock_unlock(struct plock *l, uint32_t self)
 {
-	memset(l, 0, sizeof(*l));
-	l->utype = utype;
+	rte_atomic_store_explicit(&l->flag[self], 0, rte_memory_order_release);
 }
 
 /*
@@ -186,7 +161,7 @@ plock_test1_lcore(void *data)
  * and local data are the same.
  */
 static int
-plock_test(uint64_t iter, enum plock_use_type utype)
+plock_test(uint64_t iter)
 {
 	int32_t rc;
 	uint32_t i, lc, n;
@@ -201,8 +176,7 @@ plock_test(uint64_t iter, enum plock_use_type utype)
 	lpt = calloc(n, sizeof(*lpt));
 	sum = calloc(n + 1, sizeof(*sum));
 
-	printf("%s(iter=%" PRIu64 ", utype=%u) started on %u lcores\n",
-		__func__, iter, utype, n);
+	printf("%s(iter=%" PRIu64 ") started on %u lcores\n", __func__, iter, n);
 
 	if (pt == NULL || lpt == NULL || sum == NULL) {
 		printf("%s: failed to allocate memory for %u lcores\n",
@@ -213,9 +187,6 @@ plock_test(uint64_t iter, enum plock_use_type utype)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i != n + 1; i++)
-		plock_reset(&pt[i].lock, utype);
-
 	i = 0;
 	RTE_LCORE_FOREACH(lc) {
 
@@ -263,26 +234,18 @@ plock_test(uint64_t iter, enum plock_use_type utype)
 	free(lpt);
 	free(sum);
 
-	printf("%s(utype=%u) returns %d\n", __func__, utype, rc);
+	printf("%s returns %d\n", __func__, rc);
 	return rc;
 }
 
 static int
 test_barrier(void)
 {
-	int32_t i, ret, rc[USE_NUM];
-
-	for (i = 0; i != RTE_DIM(rc); i++)
-		rc[i] = plock_test(ITER_MAX, i);
+	int rc = plock_test(ITER_MAX);
 
-	ret = 0;
-	for (i = 0; i != RTE_DIM(rc); i++) {
-		printf("%s for utype=%d %s\n",
-			__func__, i, rc[i] == 0 ? "passed" : "failed");
-		ret |= rc[i];
-	}
+	printf("%s %s\n", __func__, rc == 0 ? "passed" : "failed");
 
-	return ret;
+	return rc;
 }
 
 REGISTER_PERF_TEST(barrier_autotest, test_barrier);
-- 
2.53.0

