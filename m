Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C5CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:26:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D84A840659;
	Wed, 27 May 2026 01:25:52 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 301E840649
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:50 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so36365184eec.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837949;
 x=1780442749; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XLlNurtI/Ouc3Jmtf8aMHpY8DnXHdHcNFbBmwXotYg=;
 b=VlEq0rGdGPqTXrDlxe5VsPW5ea6eQhf300tLzRimniAMrhXyxtTZogiGCKRK/GP0L+
 t0GJTy/5HO1nFrhwVc8RlREGzlRqdHm0/QNh9OPQ97HLdpnpwAkggus8eT/U78VEJF95
 +OaPIX8UVVy8GmT+wV0nCgc8Q56gQCHk8DKZEBczDeJeLwXgEXBvOaZnQOYIecpU8HIq
 35KLVdsKZWl1Sg4yIz0VNmHgqAXhevMgH1nPTnV/K7wIAkG5Wo9fXhIY9RC1z25N3fc/
 tLlfKUh5IQfc3OXs2wC7E3Rl5/D62ZQhBmpuGhjQW0SIdhMhyw1A8njjh0BwMHZukJkR
 qWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837949; x=1780442749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4XLlNurtI/Ouc3Jmtf8aMHpY8DnXHdHcNFbBmwXotYg=;
 b=ns9XxiDnpr/CANo2FHosrnJtKkLDZtO62iCHrGhaObspkWWKLYnz3qPaJZRVzEG2H4
 SSD+wBoXedmi9ktwRTGlUQ7Mo0q6PxGuiTPzdd8UUHmmXlM8viuibC5ce0JI3Rocqe0W
 S6Q0jlMRXZaqrwvSQkH44SvKZzFIqDu3XwjLVFOe2z6i5JmaVBrmSU4xYbzWGkHkMduJ
 4pr+rsWM1s0HEGCzlueVCyZFL6T4as30wwiK21SJ+5bMPybnntdRif3gSbLRe0ZJajQ8
 RZQ32F/W+/4aVxht7CMFCW6h99m+u4vTNHyJV0mrjMly6jbQdXC71nJYk8NBzSzwfucp
 lVWA==
X-Gm-Message-State: AOJu0YxtrGkaVSGflpM2ePy/w7oqDAhzkXNz8ROSEqMyS2MSZ5EgA/Ud
 0CScA0fNniFM4XU0UJTYn8GkG9k9vTHnNleColrIPHHPaMNjEsUtDf378O5gIH+edKEfe6Gbq9Q
 Qcqig
X-Gm-Gg: Acq92OHNZ0p4TKoOPulrIvK4FFHrDHQZwysFhaNkw4elkvMI2XOQwR1Mn7534a4458F
 b7IbLN+/PvETFLS2d425GnVsuAyf1jF/8yRCF4pi4T3erixN51btD82deHde6HQhXjQW09LVgYW
 tBPgRkr/soh2tA02AzVLUtFyNU9INZe307gcJRY58VlOW0gCXuXTwVYTqaj01cBVnx7StZh91/X
 S5wLhM0Cui1vCtYLI77/xQN342u2esRFJSNm/7P4eKB4nFKjZMBY0/ig0IUicqR287bMiUUt+TB
 Puu6UWB1yYmNwtA2c7mphX4X2hmn2PN6vP4lT7afcAcaD+Hd1/DxpucL5t8Imzy4MLG/YTnVeAv
 wEOt5/O0uQJ2Onwz4Ua1tt/NlLZx1wEWKPOEhEiTJ9qd5s1tbtqhIxu8NKRXhXV7kk8rWjgd28g
 tRm0q+ekAGHjtILLSlIiAkqDCVXA3724BpMTeANplkmPFZlpIsTvgXrOsyPSV0Kw==
X-Received: by 2002:a05:693c:2285:b0:2f1:6252:f8ef with SMTP id
 5a478bee46e88-30448fbf20cmr10533692eec.1.1779837949147; 
 Tue, 26 May 2026 16:25:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v4 03/27] ring: unify memory model on C11, remove atomic32
Date: Tue, 26 May 2026 16:23:53 -0700
Message-ID: <20260526232542.620966-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

Remove the RTE_USE_C11_MEM_MODEL build switch; C11 atomics are now
the default for all platforms. Unifies __rte_ring_update_tail into
the C11 form (atomic_store_release replaces the older rte_smp_wmb +
plain store on the generic path) and renames rte_ring_generic_pvt.h
to rte_ring_x86_pvt.h to reflect its new scope.

Also splits the head-move helper into separate ST and MT variants,
removing the runtime is_st branch from the MT retry loop.
This gets small boost and scopes the following exception
more tightly.

Exception: on x86 with GCC, atomic_compare_exchange on the head CAS
regresses MP/MC contended throughput by ~20% existing hand-written
cmpxchg. As a workaround, GCC-on-x86 builds use the older
__sync_bool_compare_and_swap builtin, which generates equivalent
code to the original asm. Can be reverted if/when GCC gets
fixed; similar issue was observed in Linux kernel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/meson.build                          |   2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  75 +++--------
 lib/ring/rte_ring_elem_pvt.h                  | 125 ++++++++++++++++--
 ..._ring_generic_pvt.h => rte_ring_x86_pvt.h} |  61 ++-------
 lib/ring/soring.c                             |  15 ++-
 5 files changed, 158 insertions(+), 120 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_x86_pvt.h} (60%)

diff --git a/lib/ring/meson.build b/lib/ring/meson.build
index 21f2c12989..b178c963b8 100644
--- a/lib/ring/meson.build
+++ b/lib/ring/meson.build
@@ -9,7 +9,7 @@ indirect_headers += files (
         'rte_ring_elem.h',
         'rte_ring_elem_pvt.h',
         'rte_ring_c11_pvt.h',
-        'rte_ring_generic_pvt.h',
+        'rte_ring_x86_pvt.h',
         'rte_ring_hts.h',
         'rte_ring_hts_elem_pvt.h',
         'rte_ring_peek.h',
diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 07b6efc416..3efe011f08 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -15,35 +15,10 @@
  * @file rte_ring_c11_pvt.h
  * It is not recommended to include this file directly,
  * include <rte_ring.h> instead.
- * Contains internal helper functions for MP/SP and MC/SC ring modes.
+ * Contains internal helper functions for MP and MC ring modes.
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
  *
@@ -72,14 +47,11 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int is_st, unsigned int n,
-		enum rte_ring_queue_behavior behavior,
+		unsigned int n,	enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
-	uint32_t stail;
-	int success;
 	unsigned int max = n;
 
 	/*
@@ -89,8 +61,7 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 	 * d->head.
 	 * If not, an unsafe partial order may ensue.
 	 */
-	*old_head = rte_atomic_load_explicit(&d->head,
-			rte_memory_order_acquire);
+	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_acquire);
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
@@ -101,15 +72,14 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 		 * ring elements array is observed by the time
 		 * this thread observes its tail update.
 		 */
-		stail = rte_atomic_load_explicit(&s->tail,
-					rte_memory_order_acquire);
+		uint32_t stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
 
 		/* The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
 		 * *old_head > s->tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = (capacity + stail - *old_head);
+		*entries = capacity + stail - *old_head;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -120,25 +90,20 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			return 0;
 
 		*new_head = *old_head + n;
-		if (is_st) {
-			d->head = *new_head;
-			success = 1;
-		} else
-			/* on failure, *old_head is updated */
-			/*
-			 * R1/A2.
-			 * R1: Establishes a synchronizing edge with A0 of a
-			 * different thread.
-			 * A2: Establishes a synchronizing edge with R1 of a
-			 * different thread to observe same value for stail
-			 * observed by that thread on CAS failure (to retry
-			 * with an updated *old_head).
-			 */
-			success = rte_atomic_compare_exchange_strong_explicit(
-					&d->head, old_head, *new_head,
-					rte_memory_order_release,
-					rte_memory_order_acquire);
-	} while (unlikely(success == 0));
+
+		/* on failure, *old_head is updated */
+		/*
+		 * R1/A2.
+		 * R1: Establishes a synchronizing edge with A0 of a
+		 * different thread.
+		 * A2: Establishes a synchronizing edge with R1 of a
+		 * different thread to observe same value for stail
+		 * observed by that thread on CAS failure (to retry
+		 * with an updated *old_head).
+		 */
+	} while (unlikely(!rte_atomic_compare_exchange_strong_explicit(
+				  &d->head, old_head, *new_head,
+				  rte_memory_order_release, rte_memory_order_acquire)));
 	return n;
 }
 
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 6eafae121f..9d1da12a92 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -299,17 +299,108 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 			cons_head & r->mask, esize, num);
 }
 
-/* Between load and load. there might be cpu reorder in weak model
- * (powerpc/arm).
- * There are 2 choices for the users
- * 1.use rmb() memory barrier
- * 2.use one-direction load_acquire/store_release barrier
- * It depends on performance test results.
+/**
+ * @internal This function updates tail values.
  */
-#ifdef RTE_USE_C11_MEM_MODEL
-#include "rte_ring_c11_pvt.h"
+static __rte_always_inline void
+__rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
+		uint32_t new_val, uint32_t single, uint32_t enqueue)
+{
+	RTE_SET_USED(enqueue);
+
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
+/**
+ * @internal This is a helper function that moves the producer/consumer head
+ *
+ *
+ * This optimized version for single threaded case.
+ *
+ * @param d
+ *   A pointer to the headtail structure with head value to be moved
+ * @param s
+ *   A pointer to the counter-part headtail structure. Note that this
+ *   function only reads tail value from it
+ * @param capacity
+ *   Either ring capacity value (for producer), or zero (for consumer)
+ * @param n
+ *   The number of elements we want to move head value on
+ * @param behavior
+ *   RTE_RING_QUEUE_FIXED:    Move on a fixed number of items
+ *   RTE_RING_QUEUE_VARIABLE: Move on as many items as possible
+ * @param old_head
+ *   Returns head value as it was before the move
+ * @param new_head
+ *   Returns the new head value
+ * @param entries
+ *   Returns the number of ring entries available BEFORE head was moved
+ * @return
+ *   Actual number of objects the head was moved on
+ *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
+ */
+static __rte_always_inline unsigned int
+__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
+		const struct rte_ring_headtail *s, uint32_t capacity,
+		unsigned int n, enum rte_ring_queue_behavior behavior,
+		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
+{
+	uint32_t stail;
+
+	/*
+	 * A0: Establishes a synchronizing edge with R1.
+	 * Ensure that this thread observes same values
+	 * to stail observed by the thread that updated
+	 * d->head.
+	 * If not, an unsafe partial order may ensue.
+	 */
+	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_acquire);
+
+	/*
+	 * A1: Establishes a synchronizing edge with R0.
+	 * Ensures that other thread's memory effects on
+	 * ring elements array is observed by the time
+	 * this thread observes its tail update.
+	 */
+	stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
+
+	/* The subtraction is done between two unsigned 32bits value
+	 * (the result is always modulo 32 bits even if we have
+	 * *old_head > s->tail). So 'entries' is always between 0
+	 * and capacity (which is < size).
+	 */
+	*entries = capacity + stail - *old_head;
+
+	/* check that we have enough room in ring */
+	if (unlikely(n > *entries))
+		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
+
+	if (n > 0) {
+		*new_head = *old_head + n;
+		d->head = *new_head;
+	}
+
+	return n;
+}
+
+/* There are two choices because GCC optimizer does poorly on atomic_compare_exchange */
+#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
+#include "rte_ring_x86_pvt.h"
 #else
-#include "rte_ring_generic_pvt.h"
+#include "rte_ring_c11_pvt.h"
 #endif
 
 /**
@@ -341,8 +432,12 @@ __rte_ring_move_prod_head(struct rte_ring *r, unsigned int is_sp,
 		uint32_t *old_head, uint32_t *new_head,
 		uint32_t *free_entries)
 {
-	return __rte_ring_headtail_move_head(&r->prod, &r->cons, r->capacity,
-			is_sp, n, behavior, old_head, new_head, free_entries);
+	if (is_sp)
+		return __rte_ring_headtail_move_head_st(&r->prod, &r->cons, r->capacity,
+				n, behavior, old_head, new_head, free_entries);
+	else
+		return __rte_ring_headtail_move_head_mt(&r->prod, &r->cons, r->capacity,
+				n, behavior, old_head, new_head, free_entries);
 }
 
 /**
@@ -374,8 +469,12 @@ __rte_ring_move_cons_head(struct rte_ring *r, unsigned int is_sc,
 		uint32_t *old_head, uint32_t *new_head,
 		uint32_t *entries)
 {
-	return __rte_ring_headtail_move_head(&r->cons, &r->prod, 0,
-			is_sc, n, behavior, old_head, new_head, entries);
+	if (is_sc)
+		return __rte_ring_headtail_move_head_st(&r->cons, &r->prod, 0,
+				n, behavior, old_head, new_head, entries);
+	else
+		return __rte_ring_headtail_move_head_mt(&r->cons, &r->prod, 0,
+				n, behavior, old_head, new_head, entries);
 }
 
 /**
diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_x86_pvt.h
similarity index 60%
rename from lib/ring/rte_ring_generic_pvt.h
rename to lib/ring/rte_ring_x86_pvt.h
index affd2d5ba7..c8de108bbd 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_x86_pvt.h
@@ -7,39 +7,19 @@
  * Used as BSD-3 Licensed with permission from Kip Macy.
  */
 
-#ifndef _RTE_RING_GENERIC_PVT_H_
-#define _RTE_RING_GENERIC_PVT_H_
+#ifndef _RTE_RING_X86_PVT_H_
+#define _RTE_RING_X86_PVT_H_
 
 /**
- * @file rte_ring_generic_pvt.h
+ * @file rte_ring_x86_pvt.h
  * It is not recommended to include this file directly,
  * include <rte_ring.h> instead.
- * Contains internal helper functions for MP/SP and MC/SC ring modes.
- * For more information please refer to <rte_ring.h>.
+ *
+ * Contains internal helper functions for MP and MC ring modes.
+ * It is GCC specific to workaround poor optimizer handling of C11 atomic
+ * compare_exchange.
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
-
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *
@@ -50,8 +30,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   function only reads tail value from it
  * @param capacity
  *   Either ring capacity value (for producer), or zero (for consumer)
- * @param is_st
- *   Indicates whether multi-thread safe path is needed or not
  * @param n
  *   The number of elements we want to move head value on
  * @param behavior
@@ -68,14 +46,13 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int is_st, unsigned int n,
+		unsigned int n,
 		enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
 	unsigned int max = n;
-	int success;
 
 	do {
 		/* Reset n to the initial burst count */
@@ -83,18 +60,13 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 
 		*old_head = d->head;
 
-		/* add rmb barrier to avoid load/load reorder in weak
-		 * memory model. It is noop on x86
-		 */
-		rte_smp_rmb();
-
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
 		 * *old_head > s->tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = (capacity + s->tail - *old_head);
+		*entries = capacity + s->tail - *old_head;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -105,15 +77,10 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			return 0;
 
 		*new_head = *old_head + n;
-		if (is_st) {
-			d->head = *new_head;
-			success = 1;
-		} else
-			success = rte_atomic32_cmpset(
-					(uint32_t *)(uintptr_t)&d->head,
-					*old_head, *new_head);
-	} while (unlikely(success == 0));
+	} while (unlikely(!__sync_bool_compare_and_swap(
+				  (uint32_t *)(uintptr_t)&d->head,
+				  *old_head, *new_head)));
 	return n;
 }
 
-#endif /* _RTE_RING_GENERIC_PVT_H_ */
+#endif /* _RTE_RING_X86_PVT_H_ */
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 3b90521bdb..0e8bbc03c1 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -135,9 +135,12 @@ __rte_soring_move_prod_head(struct rte_soring *r, uint32_t num,
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
+		n = __rte_ring_headtail_move_head_st(&r->prod.ht, &r->cons.ht,
+				r->capacity, num, behavior, head, next, free);
+		break;
 	case RTE_RING_SYNC_MT:
-		n = __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
-			r->capacity, st, num, behavior, head, next, free);
+		n = __rte_ring_headtail_move_head_mt(&r->prod.ht, &r->cons.ht,
+				r->capacity, num, behavior, head, next, free);
 		break;
 	case RTE_RING_SYNC_MT_RTS:
 		n = __rte_ring_rts_move_head(&r->prod.rts, &r->cons.ht,
@@ -168,9 +171,13 @@ __rte_soring_move_cons_head(struct rte_soring *r, uint32_t stage, uint32_t num,
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
+		n = __rte_ring_headtail_move_head_st(&r->cons.ht,
+			&r->stage[stage].ht, 0, num, behavior,
+			head, next, avail);
+		break;
 	case RTE_RING_SYNC_MT:
-		n = __rte_ring_headtail_move_head(&r->cons.ht,
-			&r->stage[stage].ht, 0, st, num, behavior,
+		n = __rte_ring_headtail_move_head_mt(&r->cons.ht,
+			&r->stage[stage].ht, 0, num, behavior,
 			head, next, avail);
 		break;
 	case RTE_RING_SYNC_MT_RTS:
-- 
2.53.0

