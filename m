Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B490CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:37:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 538F9406FF;
	Thu,  4 Jun 2026 18:37:05 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 25A45406FF
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:37:03 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-137335bc3caso1168901c88.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780591022;
 x=1781195822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90VCqSKkIeSRZ8rUhLVp8iu5D1YZ19NQaAqA9iJ4eJ8=;
 b=Gshg6X3Vv/+CAVDkNBtHspithWYeEiJKS/LmJwphNldK7vusQUPaJomDSdDGaDwA0Z
 JfY156qvzvhwLoeMQ6AsFKCAqxC7wcMecx3Q0/SaDiu69Hl+E9Ut6BQSU4RYccTmNVOw
 KXb9UVLIX6x7J3inG0Svwa08ao8VhyZe3SXEQUWPDgJxb8eah3fs1LB9yiyfYKfXLHd4
 AzwZprrHeIjZQ9JjRFVYMevvFNc1f4XMIFUFi5inyyy82xgZPjgaaXkAD2+tLpO4D+8b
 XqvyDFm2pXhLVpzLMkZAtDkriSZlwf7EI55RJbq/ILESX7fRkIenojGBTdcGc0m2wum7
 /4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591022; x=1781195822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90VCqSKkIeSRZ8rUhLVp8iu5D1YZ19NQaAqA9iJ4eJ8=;
 b=XWLdzLeVqmCvpXFbK4byxSVejb4qKVv0cSrjGdLLcVrEtDByNY4Exs7rccXjmOZ/Ca
 s4ih/5bT6kiAf9PViqYolwkd3JCiOmeXleptH6tA7W/TmsPkhelAch3cxsUVTy+WmP3r
 A1bIgsnInHnvLNxcEyx7BV9XBK1mkjZEfkhDijvqi5gp+wOGgaKTbubcMziC49NomiGe
 3h1durrQAK3tEJDDK8bEWQw2m9ZD0xypOivqT0R91LwM/qF2eJw5gf0tQtzSZh+SvPdX
 AX4QAS7YbPH1j+vEzLl1TdhJdMaBfMazLokCIyLsB908kcfgVc8VUAq4+dy5DPSOpxpf
 K0Jg==
X-Gm-Message-State: AOJu0YxvT7LkBX0DzXd+nQA2ZJ6hmimWUYdygiiSOeORjYNCTuSpfNdd
 z0SvnbMtYUIF9npnhuQMCsu1dL7C59iuMEYW75l3QC7G+sS6CF2Ybal447G6IVV9/dw49NqIjLL
 U1nvE
X-Gm-Gg: Acq92OEMUqn2xPrV0cDRWe9/pBa9Hz0vLsN64PAvgmeoQlVmk6SXZnesSrkqwsD2l9U
 8bE8z9ArE7jFHPonm3nZ8vG7P5I4FN6tqimheztMqFHIB0teLkhYiJEa5tctEtW0TD/LL5167CB
 FRjBps4nxHQYruTROZB0eTa7fxrlFq4RXwc4hukXr/wQSHecvCqTw6w287zjLUsPcWKiwPDertH
 34f4o3hE0XktG6k060SGNU/P1qyOH2BXLKlko5eCT1usjfxIyTTyrZ5ofKw7I2nSNZkeBhPTxmY
 3RFk4piaZl0mDsB+jqaAlsO6uzssjyFTO8ab68PtcL9D4SS/AJ2lnHqtD8EUKJcpZgVg4pvkQS8
 hBSLfd8CxP83veUW+29FgJffNyp3lPP/MZTpoO570uIxcdSji8AGmclwEWxUnREuk+7dnCVKsYM
 H5LhM7LYEbGM8G3ygKNqdegrUpesq358fVKqP1TldTnePfNX6JWmlbtjYC1qVVfiXfmMyJUamh
X-Received: by 2002:a05:7301:4592:b0:304:d788:ac5 with SMTP id
 5a478bee46e88-3074fcb2470mr4898775eec.35.1780591021922; 
 Thu, 04 Jun 2026 09:37:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db56697sm5427951eec.2.2026.06.04.09.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:37:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 3/3] ring: cleanup the C11 code
Date: Thu,  4 Jun 2026 09:32:28 -0700
Message-ID: <20260604163656.1226902-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604163656.1226902-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260604163656.1226902-1-stephen@networkplumber.org>
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

Put the C11 code in the rte_ring_elem_pvt.h file
and only have the GCC vs C11 code split in separate includes.

The internal functions to update tail of ring no longer use
the enqueue flag argument.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h      | 88 ----------------------------
 lib/ring/rte_ring_elem_pvt.h     | 98 +++++++++++++++++++++++++++++---
 lib/ring/rte_ring_gcc_pvt.h      | 84 ---------------------------
 lib/ring/rte_ring_hts_elem_pvt.h |  8 +--
 lib/ring/soring.c                | 10 ++--
 5 files changed, 98 insertions(+), 190 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 5afc14dec9..d232e5ac34 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -19,94 +19,6 @@
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
-/**
- * @internal This is a helper function that moves the producer/consumer head
- *    optimized for single threaded case
- *
- * @param d
- *   A pointer to the headtail structure with head value to be moved
- * @param s
- *   A pointer to the counter-part headtail structure. Note that this
- *   function only reads tail value from it
- * @param capacity
- *   Either ring capacity value (for producer), or zero (for consumer)
- * @param n
- *   The number of elements we want to move head value on
- * @param behavior
- *   RTE_RING_QUEUE_FIXED:    Move on a fixed number of items
- *   RTE_RING_QUEUE_VARIABLE: Move on as many items as possible
- * @param old_head
- *   Returns head value as it was before the move
- * @param new_head
- *   Returns the new head value
- * @param entries
- *   Returns the number of ring entries available BEFORE head was moved
- * @return
- *   Actual number of objects the head was moved on
- *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
- */
-static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
-		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int n,
-		enum rte_ring_queue_behavior behavior,
-		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
-{
-	uint32_t stail;
-
-	/* Single producer: only this thread writes d->head,
-	 * so a relaxed load is sufficient.
-	 */
-	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_relaxed);
-
-	/* Acquire pairs with the consumer's release-store of tail in __rte_ring_update_tail,
-	 * ensuring the consumer's ring-element reads are complete before
-	 * we observe the updated tail.
-	 */
-	stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
-
-	/* Unsigned subtraction is modulo 2^32, so entries is always in
-	 * [0, capacity) even if old_head > stail.
-	 */
-	*entries = capacity + stail - *old_head;
-
-	/* check that we have enough room in ring */
-	if (unlikely(n > *entries))
-		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
-
-	if (n > 0) {
-		*new_head = *old_head + n;
-		rte_atomic_store_explicit(&d->head, *new_head, rte_memory_order_relaxed);
-	}
-
-	return n;
-}
-
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *    for use in multi-thread safe path
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 9a0170c4f0..17ec450b8a 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -299,12 +299,94 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
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
+/**
+ * @internal This is a helper function that moves the producer/consumer head
+ *    optimized for single threaded case
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
+		unsigned int n,
+		enum rte_ring_queue_behavior behavior,
+		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
+{
+	uint32_t stail;
+
+	/* Single producer: only this thread writes d->head,
+	 * so a relaxed load is sufficient.
+	 */
+	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_relaxed);
+
+	/* Acquire pairs with the consumer's release-store of tail in __rte_ring_update_tail,
+	 * ensuring the consumer's ring-element reads are complete before
+	 * we observe the updated tail.
+	 */
+	stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
+
+	/* Unsigned subtraction is modulo 2^32, so entries is always in
+	 * [0, capacity) even if old_head > stail.
+	 */
+	*entries = capacity + stail - *old_head;
+
+	/* check that we have enough room in ring */
+	if (unlikely(n > *entries))
+		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
+
+	if (n > 0) {
+		*new_head = *old_head + n;
+		rte_atomic_store_explicit(&d->head, *new_head, rte_memory_order_relaxed);
+	}
+
+	return n;
+}
+
+/*
+ * The function __rte_ring_headtail_move_head_mt has two versions
+ * based on what is most efficient on a given architecture.
+ *
+ * The C11 is preferred but on x86 GCC has 10% performance drop.
  */
 #ifdef RTE_USE_C11_MEM_MODEL
 #include "rte_ring_c11_pvt.h"
@@ -426,7 +508,7 @@ __rte_ring_do_enqueue_elem(struct rte_ring *r, const void *obj_table,
 
 	__rte_ring_enqueue_elems(r, prod_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp, 1);
+	__rte_ring_update_tail(&r->prod, prod_head, prod_next, is_sp);
 end:
 	if (free_space != NULL)
 		*free_space = free_entries - n;
@@ -473,7 +555,7 @@ __rte_ring_do_dequeue_elem(struct rte_ring *r, void *obj_table,
 
 	__rte_ring_dequeue_elems(r, cons_head, obj_table, esize, n);
 
-	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc, 0);
+	__rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc);
 
 end:
 	if (available != NULL)
diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 68ab1355e8..70fb4c3fcb 100644
--- a/lib/ring/rte_ring_gcc_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -18,31 +18,6 @@
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
-		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
-			rte_memory_order_relaxed);
-
-	/*
-	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
-	 * Ensures that memory effects by this thread on ring elements array
-	 * is observed by a different thread of the other type.
-	 */
-	__atomic_store_n(&ht->tail, new_val, __ATOMIC_RELEASE);
-}
-
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *    for use in multi-thread safe path
@@ -115,63 +90,4 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 	return n;
 }
 
-/**
- * @internal This is a helper function that moves the producer/consumer head
- *    optimized for single threaded case
- *
- * @param d
- *   A pointer to the headtail structure with head value to be moved
- * @param s
- *   A pointer to the counter-part headtail structure. Note that this
- *   function only reads tail value from it
- * @param capacity
- *   Either ring capacity value (for producer), or zero (for consumer)
- * @param n
- *   The number of elements we want to move head value on
- * @param behavior
- *   RTE_RING_QUEUE_FIXED:    Move on a fixed number of items
- *   RTE_RING_QUEUE_VARIABLE: Move on as many items as possible
- * @param old_head
- *   Returns head value as it was before the move
- * @param new_head
- *   Returns the new head value
- * @param entries
- *   Returns the number of ring entries available BEFORE head was moved
- * @return
- *   Actual number of objects the head was moved on
- *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
- */
-static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
-		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int n,
-		enum rte_ring_queue_behavior behavior,
-		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
-{
-	*old_head = d->head;
-
-	/* add rmb barrier to avoid load/load reorder in weak
-	 * memory model. It is noop on x86
-	 */
-	rte_smp_rmb();
-
-	/*
-	 *  The subtraction is done between two unsigned 32bits value
-	 * (the result is always modulo 32 bits even if we have
-	 * *old_head > s->tail). So 'entries' is always between 0
-	 * and capacity (which is < size).
-	 */
-	*entries = (capacity + s->tail - *old_head);
-
-	/* check that we have enough room in ring */
-	if (unlikely(n > *entries))
-		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
-
-	if (likely(n > 0)) {
-		*new_head = *old_head + n;
-		d->head = *new_head;
-	}
-	return n;
-}
-
 #endif /* _RTE_RING_GCC_PVT_H_ */
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

