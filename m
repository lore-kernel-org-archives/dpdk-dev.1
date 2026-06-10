Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B7CD98CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE3E427B5;
	Wed, 10 Jun 2026 20:47:11 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 0DB7E427AC
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:47:08 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso1316506eec.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781117227;
 x=1781722027; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmgN98Dnj95drkIagyxjlf0DMwP8R9rq3Bky1l1vcgk=;
 b=eg3RVNJwCXr3zDMT4QAZ9x11pgvrOvyL9nJs+KnAN3KVwh9EG7tfElPz/Z433IT95k
 bmVzGQ0ijMe26jc3g45pgzzQOkIb6TeOLnhHJXX3eY1cmrcYRXsvfGkkBs7D87jgAa0h
 Rrpf8G3lY2BjNtzkH/yZZ+UXIFDTFvi7PJPHG2f24rqftxsCTdbF/mnXQxCo42MztUXQ
 a2q4nN2Za7nBHHOLCheo0p39bQIQVc1ejNinWt3xn9+oxmIpQOISyQjtCGHodaGRQKPT
 +l/P4LNMmuEM/USL28rjvTrVjfP6XhSvdknlAlntCAQi1z0v/AgNBgN62Io9rjAee9bh
 s1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781117227; x=1781722027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmgN98Dnj95drkIagyxjlf0DMwP8R9rq3Bky1l1vcgk=;
 b=Cl/2V8XRJmRIbt4D7Xe2AuDNfmeRDLYjA43ahPHm+FsUt5SYYBWBJgT40fh73XMv+m
 qhOQkmNnMe2Qb97KrMIyolXUWnqTTs1CIsFt6A3SScqQp1XOie/3daaiVoI6UbeA4BvO
 xLwDxuMwURmlZ7ahmqi+6whSEj8TNfr+DI49ymxaUedIEqAxpHS1lVeTImQ3po4DhJK2
 B+8HqEnwevxMK9p3RwAzLRHawggAt9Ozdbla6ZVKLJtWT+pQMD/7WEj5kQOX8dOx16+2
 +E3tlwxriCEbP9s5+T7wfJertYB791T5TuuzO6WFKUNh52peeTVrQNpL0mLRaM9GUPKd
 SF+w==
X-Gm-Message-State: AOJu0Yx/rEq2GJGV8EFZYr07odA+XTmpG1H0wHikXUsljhSCc6PhOp1c
 l3ZyT89OLibfZmZlQINaa0V1LcjjswdQV85WteRWxoAhOUfkHuV7cmpQwS8d5zhftjvez4QSYt9
 AUoVm
X-Gm-Gg: Acq92OGoiPn81atxmJ7V6tMguu0SmI0l4PAzP6hq+iaEMtaL8K0y5nmBOKSUMgU3LHm
 KlDCu26v2YgozS/J481G9lfTi47Y2yRepS4e5wj5Rw5IjNXdpWHBaQYzhEsYnvXSBUOU0upGF0Z
 ghKgtSs2nU8qvOPSVzYhvvDHUskoqXsrgRrI9nvRDZWFITdY6Hd0CdKL/okfFsiF9aefx31AQSn
 vI58pLyrUypo0pk2XiIOJ4abkeKKnUBt5cd/UQhbHyfrF3F2jMIYwWWVk3FNUglJZ5pArPD0TX6
 muuw9zWB0+dQthO9RhHz1+BUN6T0kxW5RU7fVTXKX0iKWoVRFSlQ9PBWAo5P95C1nljWlM+qShu
 olDku0ON+nMGPv2yCg9YVWMBuMxcY7mYGvjFS3p3rL2h5T44M8FMfL+Aw1LZyD1oUFvYCbprqhH
 oPWZfd3e6rrp94v62vYunWYKKRtx2S8vmiWmqQoHxmCfivWmWFgnknJpSikxlOmOAFxsAsiPna
X-Received: by 2002:a05:7300:54d:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-307ff61c78cmr247302eec.29.1781117226904; 
 Wed, 10 Jun 2026 11:47:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm37799844eec.5.2026.06.10.11.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 11:47:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v3 2/2] ring: replace rte_atomic32 with __sync builtin
Date: Wed, 10 Jun 2026 11:43:08 -0700
Message-ID: <20260610184701.657769-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610184701.657769-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260610184701.657769-1-stephen@networkplumber.org>
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

Replaces use of the deprecated rte_atomic32 code with GCC builtin
atomic operations on x86. The C11 version used on other architectures
is unchanged.

Although it would be preferable to use C11 on all architectures,
there is a performance loss if we do it that way.

On x86 i9-13900H, two physical cores MP/MC (cycles/elem),
ring_perf test with GCC 14.2:

  n      asm    sync     c11
  8    72.86   72.12   89.01
  32   18.74   18.80   24.62
  64   10.07    9.86   12.41
  128   6.99    6.74    9.01
  256   6.38    6.20    7.34

Pure C11 regresses 15-30% due to __atomic_compare_exchange_n's
failure-writeback semantic.

Drop the now-unused enqueue argument.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/meson.build                          |   2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  25 ----
 lib/ring/rte_ring_elem_pvt.h                  |  37 +++--
 ..._ring_generic_pvt.h => rte_ring_gcc_pvt.h} | 141 ++++++++----------
 lib/ring/rte_ring_hts_elem_pvt.h              |   8 +-
 lib/ring/soring.c                             |  10 +-
 6 files changed, 99 insertions(+), 124 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_gcc_pvt.h} (81%)

diff --git a/lib/ring/meson.build b/lib/ring/meson.build
index 21f2c12989..2ba160b178 100644
--- a/lib/ring/meson.build
+++ b/lib/ring/meson.build
@@ -9,7 +9,7 @@ indirect_headers += files (
         'rte_ring_elem.h',
         'rte_ring_elem_pvt.h',
         'rte_ring_c11_pvt.h',
-        'rte_ring_generic_pvt.h',
+        'rte_ring_gcc_pvt.h',
         'rte_ring_hts.h',
         'rte_ring_hts_elem_pvt.h',
         'rte_ring_peek.h',
diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 5afc14dec9..a6c14921d3 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -19,31 +19,6 @@
  * For more information please refer to <rte_ring.h>.
  */
 
-/**
- * @internal This function updates tail values.
- */
-static __rte_always_inline void
-__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
-		uint32_t new_val, uint32_t single, uint32_t enqueue)
-{
-	RTE_SET_USED(enqueue);
-
-	/*
-	 * If there are other enqueues/dequeues in progress that preceded us,
-	 * we need to wait for them to complete
-	 */
-	if (!single)
-		rte_wait_until_equal_32((uint32_t *)(uintptr_t)&ht->tail, old_val,
-			rte_memory_order_relaxed);
-
-	/*
-	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
-	 * Ensures that memory effects by this thread on ring elements array
-	 * is observed by a different thread of the other type.
-	 */
-	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
-}
-
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *    optimized for single threaded case
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index a0fdec9812..29758d0bb8 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -299,17 +299,36 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 			cons_head & r->mask, esize, num);
 }
 
-/* Between load and load. there might be cpu reorder in weak model
- * (powerpc/arm).
- * There are 2 choices for the users
- * 1.use rmb() memory barrier
- * 2.use one-direction load_acquire/store_release barrier
- * It depends on performance test results.
+static __rte_always_inline void
+__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
+		       uint32_t new_val, uint32_t single)
+{
+	/*
+	 * If there are other enqueues/dequeues in progress that preceded us,
+	 * we need to wait for them to complete
+	 */
+	if (!single)
+		rte_wait_until_equal_32((uint32_t *)(uintptr_t)&ht->tail, old_val,
+			rte_memory_order_relaxed);
+
+	/*
+	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
+	 * Ensures that memory effects by this thread on ring elements array
+	 * is observed by a different thread of the other type.
+	 */
+	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
+}
+
+/*
+ * The function __rte_ring_headtail_move_head_mt,st has two versions
+ * based on what is most efficient on a given architecture.
+ *
+ * The C11 is preferred but on x86 GCC has 10% performance drop.
  */
 #ifdef RTE_USE_C11_MEM_MODEL
 #include "rte_ring_c11_pvt.h"
 #else
-#include "rte_ring_generic_pvt.h"
+#include "rte_ring_gcc_pvt.h"
 #endif
 
 /**
@@ -426,7 +445,7 @@ __rte_ring_do_enqueue_elem(struct rte_ring *r, const void *obj_table,
 
 	__rte_ring_enqueue_elems(r, prod_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp, 1);
+	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp);
 end:
 	if (free_space != NULL)
 		*free_space = free_entries - n;
@@ -473,7 +492,7 @@ __rte_ring_do_dequeue_elem(struct rte_ring *r, void *obj_table,
 
 	__rte_ring_dequeue_elems(r, cons_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc, 0);
+	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc);
 
 end:
 	if (available != NULL)
diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
similarity index 81%
rename from lib/ring/rte_ring_generic_pvt.h
rename to lib/ring/rte_ring_gcc_pvt.h
index c044b0824f..340ece28c7 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -7,42 +7,21 @@
  * Used as BSD-3 Licensed with permission from Kip Macy.
  */
 
-#ifndef _RTE_RING_GENERIC_PVT_H_
-#define _RTE_RING_GENERIC_PVT_H_
+#ifndef _RTE_RING_GCC_PVT_H_
+#define _RTE_RING_GCC_PVT_H_
 
 /**
- * @file rte_ring_generic_pvt.h
+ * @file rte_ring_gcc_pvt.h
  * It is not recommended to include this file directly,
  * include <rte_ring.h> instead.
  * Contains internal helper functions for MP/SP and MC/SC ring modes.
  * For more information please refer to <rte_ring.h>.
  */
 
-/**
- * @internal This function updates tail values.
- */
-static __rte_always_inline void
-__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
-		uint32_t new_val, uint32_t single, uint32_t enqueue)
-{
-	if (enqueue)
-		rte_smp_wmb();
-	else
-		rte_smp_rmb();
-	/*
-	 * If there are other enqueues/dequeues in progress that preceded us,
-	 * we need to wait for them to complete
-	 */
-	if (!single)
-		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
-			rte_memory_order_relaxed);
-
-	ht->tail = new_val;
-}
 
 /**
  * @internal This is a helper function that moves the producer/consumer head
- *    for use in multi-thread safe path
+ *    optimized for single threaded case
  *
  * @param d
  *   A pointer to the headtail structure with head value to be moved
@@ -67,52 +46,43 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int n, enum rte_ring_queue_behavior behavior,
+		unsigned int n,
+		enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
-	unsigned int max = n;
-	int success;
-
-	do {
-		/* Reset n to the initial burst count */
-		n = max;
 
-		*old_head = d->head;
+	*old_head = d->head;
 
-		/* add rmb barrier to avoid load/load reorder in weak
-		 * memory model. It is noop on x86
-		 */
-		rte_smp_rmb();
+	/* add rmb barrier to avoid load/load reorder in weak
+	 * memory model. It is noop on x86
+	 */
+	rte_smp_rmb();
 
-		/*
-		 *  The subtraction is done between two unsigned 32bits value
-		 * (the result is always modulo 32 bits even if we have
-		 * *old_head > s->tail). So 'entries' is always between 0
-		 * and capacity (which is < size).
-		 */
-		*entries = (capacity + s->tail - *old_head);
+	/*
+	 *  The subtraction is done between two unsigned 32bits value
+	 * (the result is always modulo 32 bits even if we have
+	 * *old_head > s->tail). So 'entries' is always between 0
+	 * and capacity (which is < size).
+	 */
+	*entries = capacity + s->tail - *old_head;
 
-		/* check that we have enough room in ring */
-		if (unlikely(n > *entries))
-			n = (behavior == RTE_RING_QUEUE_FIXED) ?
-					0 : *entries;
+	/* check that we have enough room in ring */
+	if (unlikely(n > *entries))
+		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
 
-		if (n == 0)
-			return 0;
+	if (n == 0)
+		return 0;
 
-		*new_head = *old_head + n;
-		success = rte_atomic32_cmpset(
-				(uint32_t *)(uintptr_t)&d->head,
-				*old_head, *new_head);
-	} while (unlikely(success == 0));
+	*new_head = *old_head + n;
+	d->head = *new_head;
 	return n;
 }
 
 /**
  * @internal This is a helper function that moves the producer/consumer head
- *    optimized for single threaded case
+ *    for use in multi-thread safe path
  *
  * @param d
  *   A pointer to the headtail structure with head value to be moved
@@ -137,36 +107,49 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int n,
-		enum rte_ring_queue_behavior behavior,
+		unsigned int n, enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
-	*old_head = d->head;
+	unsigned int max = n;
+	bool success;
 
-	/* add rmb barrier to avoid load/load reorder in weak
-	 * memory model. It is noop on x86
-	 */
-	rte_smp_rmb();
+	do {
+		/* Reset n to the initial burst count */
+		n = max;
 
-	/*
-	 *  The subtraction is done between two unsigned 32bits value
-	 * (the result is always modulo 32 bits even if we have
-	 * *old_head > s->tail). So 'entries' is always between 0
-	 * and capacity (which is < size).
-	 */
-	*entries = (capacity + s->tail - *old_head);
+		*old_head = d->head;
 
-	/* check that we have enough room in ring */
-	if (unlikely(n > *entries))
-		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
+		/* add fence to avoid load/load reorder in weak
+		 * memory model. It is noop on x86
+		 */
+		__atomic_thread_fence(__ATOMIC_ACQUIRE);
+
+		/*
+		 *  The subtraction is done between two unsigned 32bits value
+		 * (the result is always modulo 32 bits even if we have
+		 * *old_head > s->tail). So 'entries' is always between 0
+		 * and capacity (which is < size).
+		 */
+		*entries = (capacity + s->tail - *old_head);
+
+		/* check that we have enough room in ring */
+		if (unlikely(n > *entries))
+			n = (behavior == RTE_RING_QUEUE_FIXED) ?
+					0 : *entries;
+
+		if (n == 0)
+			return 0;
 
-	if (likely(n > 0)) {
 		*new_head = *old_head + n;
-		d->head = *new_head;
-	}
+
+		success = __sync_bool_compare_and_swap(
+				(uint32_t *)(uintptr_t)&d->head,
+				*old_head, *new_head);
+	} while (unlikely(!success));
+
 	return n;
 }
 
-#endif /* _RTE_RING_GENERIC_PVT_H_ */
+#endif /* _RTE_RING_GCC_PVT_H_ */
diff --git a/lib/ring/rte_ring_hts_elem_pvt.h b/lib/ring/rte_ring_hts_elem_pvt.h
index a01089d15d..97ae240e2e 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -25,12 +25,10 @@
  */
 static __rte_always_inline void
 __rte_ring_hts_update_tail(struct rte_ring_hts_headtail *ht, uint32_t old_tail,
-	uint32_t num, uint32_t enqueue)
+			   uint32_t num)
 {
 	uint32_t tail;
 
-	RTE_SET_USED(enqueue);
-
 	tail = old_tail + num;
 
 	/*
@@ -217,7 +215,7 @@ __rte_ring_do_hts_enqueue_elem(struct rte_ring *r, const void *obj_table,
 
 	if (n != 0) {
 		__rte_ring_enqueue_elems(r, head, obj_table, esize, n);
-		__rte_ring_hts_update_tail(&r->hts_prod, head, n, 1);
+		__rte_ring_hts_update_tail(&r->hts_prod, head, n);
 	}
 
 	if (free_space != NULL)
@@ -258,7 +256,7 @@ __rte_ring_do_hts_dequeue_elem(struct rte_ring *r, void *obj_table,
 
 	if (n != 0) {
 		__rte_ring_dequeue_elems(r, head, obj_table, esize, n);
-		__rte_ring_hts_update_tail(&r->hts_cons, head, n, 0);
+		__rte_ring_hts_update_tail(&r->hts_cons, head, n);
 	}
 
 	if (available != NULL)
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 22f9c60e9c..45292c0f78 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -202,21 +202,21 @@ __rte_soring_move_cons_head(struct rte_soring *r, uint32_t stage, uint32_t num,
 
 static __rte_always_inline void
 __rte_soring_update_tail(struct __rte_ring_headtail *rht,
-	enum rte_ring_sync_type st, uint32_t head, uint32_t next, uint32_t enq)
+		 enum rte_ring_sync_type st, uint32_t head, uint32_t next)
 {
 	uint32_t n;
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
 	case RTE_RING_SYNC_MT:
-		__rte_ring_update_tail(&rht->ht, head, next, st, enq);
+		__rte_ring_update_tail(&rht->ht, head, next, st);
 		break;
 	case RTE_RING_SYNC_MT_RTS:
 		__rte_ring_rts_update_tail(&rht->rts);
 		break;
 	case RTE_RING_SYNC_MT_HTS:
 		n = next - head;
-		__rte_ring_hts_update_tail(&rht->hts, head, n, enq);
+		__rte_ring_hts_update_tail(&rht->hts, head, n);
 		break;
 	default:
 		/* unsupported mode, shouldn't be here */
@@ -295,7 +295,7 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 			&prod_head, &prod_next, &nb_free);
 	if (n != 0) {
 		__enqueue_elems(r, objs, meta, prod_head, n);
-		__rte_soring_update_tail(&r->prod, st, prod_head, prod_next, 1);
+		__rte_soring_update_tail(&r->prod, st, prod_head, prod_next);
 	}
 
 	if (free_space != NULL)
@@ -401,7 +401,7 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	/* we have some elems to consume */
 	if (n != 0) {
 		__dequeue_elems(r, objs, meta, cons_head, n);
-		__rte_soring_update_tail(&r->cons, st, cons_head, cons_next, 0);
+		__rte_soring_update_tail(&r->cons, st, cons_head, cons_next);
 	}
 
 	if (available != NULL)
-- 
2.53.0

