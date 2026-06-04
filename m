Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83308CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:37:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 969B0406B6;
	Thu,  4 Jun 2026 18:37:02 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id EB61F4066E
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:37:00 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304545f5206so1132623eec.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780591020;
 x=1781195820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eu7PHiXiMeMZMYRLH7WbA+X5uwffmn5N67w7j8CXaOs=;
 b=c6TTsWn7+JJOlKoR79ILfuYZ0dYxltRP24v1b5vqWoIcO7Aybzag9dv7TC+mzkT7fq
 Cn3mJzYhMdNvCW8pGBVEQOwoQarLPAvUJpL7GoE1+4no7iWOuIhdlBhaal/S2b+yoVfh
 ZrxiRMLVCVjDBJS6IMMhuuENH8fEt/h9qgXlemQBvk+jv9K84yPeCbEjqx/+wPrL7vs3
 FWg2aX2TobAQlw/nRSe8F2q32E1ww6CubdfSroA8wJ49Z8hVadGUTy7sWZCfaRh/XNVd
 EFzUcwN0ny7ZdVkfEIU7rhp3R5esPjETgCV2tMoJqqnIVdTfIG+CYZpdruKojoi8Uejr
 U0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591020; x=1781195820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eu7PHiXiMeMZMYRLH7WbA+X5uwffmn5N67w7j8CXaOs=;
 b=WSZCyRQzEdNdeH/WJeRrLDQPgBxQ1A3Mrh9OF6s2pgRY+ACFjqnTfInClQhEvWZkQY
 5rcjbCX6O6lK4a8jEj6SuGGNg+t4xNEXuyLAYUEB83+fLG7R1zn7rpadZSGNpRNTvuJF
 cHJTCJqea3sWqO2onlaBp18jAAHYkERfsO1jnaaih8jz6ORQ7ciRmD2We/qCzX9Urw9Y
 Fnoz9ZGseQvqYtdX9WYK2x5gRebmJmKhkWSOc0WerS1rsOHcriI8j0hXkWbasCNRkL3V
 eb/hBAan4XI59lFAu9f+G05gEqqWm8hjEAUoGHO0yJe4+3FoSLx5q42wUb5rRVQHkfBE
 Vh9A==
X-Gm-Message-State: AOJu0Yz0hbezXTqvcsqHn8brff00CXwm9a41gEmR3Irwdton9eyUJDcm
 cp4H3VOPyZM73+AdY+n6N35PD4ZawkB+jEB5y/TkTPzkPdFcM2/gfDmXn5KZfxnSY59DRNF9xaG
 4ToSV
X-Gm-Gg: Acq92OFcGOB+x46v4fNe8G7APLWVYh2YTTW+uQka2aVZ4eiyH2PCMebMBrKNmXTUaAO
 YAWtKF5cj5YZi5dnzGtkIhruVpVXm5Fh0fEOqFfW1woGpQhe7FpTNdcLHwRA8vqrUQFEs710rL8
 Anw09/iY09CkPzSSdLqX/4Im/ug0QmENZuF3UacNPuIXA2d5kUjR1HyDV5aaGUinC8nubrWEqKl
 mLsILZkGOFTqd1l0smiVFFJAexm+z+Lzm8B3UMt9YGSAOcfWSXoK3zcb2TBa35brT5ar83Px2WJ
 VtaCnbZCPDAMNx9wVI9LQ6hFnJUU1niT1gKE+jqJi7QQQ9zF3WPJ1qAHryKMHm1jwEEcb7XkWfi
 TwGwvwOraZlhp1C5MX4pLlyw1rLjLplBwkxBo3hd2cXEFwHbGybSevimsnKwpYFiLGP/keck17E
 L8cW1hNh0M/N6IwRke5HcAqfv+zyAF8uAByUEA48fMfK9q20OtWYCaOs2HOzoFp1wgJL6LY/iF
X-Received: by 2002:a05:7300:2205:b0:306:f474:738c with SMTP id
 5a478bee46e88-3074fa889c2mr4661592eec.13.1780591019640; 
 Thu, 04 Jun 2026 09:36:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db56697sm5427951eec.2.2026.06.04.09.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:36:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 1/3] ring: split single thread vs multi-thread cases
Date: Thu,  4 Jun 2026 09:32:26 -0700
Message-ID: <20260604163656.1226902-2-stephen@networkplumber.org>
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

The move head function has optimization for updating when
being used on single threaded ring. Code is cleaner if the two
cases are split into separate functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h     | 100 +++++++++++++++++++++++++-------
 lib/ring/rte_ring_elem_pvt.h    |  16 +++--
 lib/ring/rte_ring_generic_pvt.h |  77 ++++++++++++++++++++----
 lib/ring/soring.c               |  24 +++++---
 4 files changed, 171 insertions(+), 46 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 07b6efc416..5afc14dec9 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -46,6 +46,7 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 
 /**
  * @internal This is a helper function that moves the producer/consumer head
+ *    optimized for single threaded case
  *
  * @param d
  *   A pointer to the headtail structure with head value to be moved
@@ -54,8 +55,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   function only reads tail value from it
  * @param capacity
  *   Either ring capacity value (for producer), or zero (for consumer)
- * @param is_st
- *   Indicates whether multi-thread safe path is needed or not
  * @param n
  *   The number of elements we want to move head value on
  * @param behavior
@@ -72,14 +71,77 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int is_st, unsigned int n,
+		unsigned int n,
 		enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
 	uint32_t stail;
-	int success;
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
+/**
+ * @internal This is a helper function that moves the producer/consumer head
+ *    for use in multi-thread safe path
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
+__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
+		const struct rte_ring_headtail *s, uint32_t capacity,
+		unsigned int n,
+		enum rte_ring_queue_behavior behavior,
+		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
+{
+	uint32_t stail;
+	bool success;
 	unsigned int max = n;
 
 	/*
@@ -120,25 +182,21 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
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
+		success = rte_atomic_compare_exchange_strong_explicit(
 					&d->head, old_head, *new_head,
 					rte_memory_order_release,
 					rte_memory_order_acquire);
-	} while (unlikely(success == 0));
+	} while (unlikely(!success));
 	return n;
 }
 
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 6eafae121f..a0fdec9812 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -341,8 +341,12 @@ __rte_ring_move_prod_head(struct rte_ring *r, unsigned int is_sp,
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
@@ -374,8 +378,12 @@ __rte_ring_move_cons_head(struct rte_ring *r, unsigned int is_sc,
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
diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
index affd2d5ba7..c044b0824f 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -42,6 +42,7 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 
 /**
  * @internal This is a helper function that moves the producer/consumer head
+ *    for use in multi-thread safe path
  *
  * @param d
  *   A pointer to the headtail structure with head value to be moved
@@ -50,8 +51,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   function only reads tail value from it
  * @param capacity
  *   Either ring capacity value (for producer), or zero (for consumer)
- * @param is_st
- *   Indicates whether multi-thread safe path is needed or not
  * @param n
  *   The number of elements we want to move head value on
  * @param behavior
@@ -68,10 +67,9 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
  *   If behavior == RTE_RING_QUEUE_FIXED, this will be 0 or n only
  */
 static __rte_always_inline unsigned int
-__rte_ring_headtail_move_head(struct rte_ring_headtail *d,
+__rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		const struct rte_ring_headtail *s, uint32_t capacity,
-		unsigned int is_st, unsigned int n,
-		enum rte_ring_queue_behavior behavior,
+		unsigned int n, enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
 	unsigned int max = n;
@@ -105,15 +103,70 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			return 0;
 
 		*new_head = *old_head + n;
-		if (is_st) {
-			d->head = *new_head;
-			success = 1;
-		} else
-			success = rte_atomic32_cmpset(
-					(uint32_t *)(uintptr_t)&d->head,
-					*old_head, *new_head);
+		success = rte_atomic32_cmpset(
+				(uint32_t *)(uintptr_t)&d->head,
+				*old_head, *new_head);
 	} while (unlikely(success == 0));
 	return n;
 }
 
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
+	*old_head = d->head;
+
+	/* add rmb barrier to avoid load/load reorder in weak
+	 * memory model. It is noop on x86
+	 */
+	rte_smp_rmb();
+
+	/*
+	 *  The subtraction is done between two unsigned 32bits value
+	 * (the result is always modulo 32 bits even if we have
+	 * *old_head > s->tail). So 'entries' is always between 0
+	 * and capacity (which is < size).
+	 */
+	*entries = (capacity + s->tail - *old_head);
+
+	/* check that we have enough room in ring */
+	if (unlikely(n > *entries))
+		n = (behavior == RTE_RING_QUEUE_FIXED) ? 0 : *entries;
+
+	if (likely(n > 0)) {
+		*new_head = *old_head + n;
+		d->head = *new_head;
+	}
+	return n;
+}
+
 #endif /* _RTE_RING_GENERIC_PVT_H_ */
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index e9c75619fe..22f9c60e9c 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -135,9 +135,12 @@ __rte_soring_move_prod_head(struct rte_soring *r, uint32_t num,
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
+		n = __rte_ring_headtail_move_head_st(&r->prod.ht, &r->cons.ht,
+			r->capacity, num, behavior, head, next, free);
+		break;
 	case RTE_RING_SYNC_MT:
-		n = __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
-			r->capacity, st, num, behavior, head, next, free);
+		n = __rte_ring_headtail_move_head_mt(&r->prod.ht, &r->cons.ht,
+			r->capacity, num, behavior, head, next, free);
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
@@ -309,9 +316,8 @@ soring_enqueue_start(struct rte_soring *r, uint32_t num,
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
-		n = __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
-			r->capacity, RTE_RING_SYNC_ST, num, behavior,
-			&head, &next, &free);
+		n = __rte_ring_headtail_move_head_st(&r->prod.ht, &r->cons.ht,
+			r->capacity, num, behavior, &head, &next, &free);
 		break;
 	case RTE_RING_SYNC_MT_HTS:
 		n = __rte_ring_hts_move_head(&r->prod.hts, &r->cons.ht,
@@ -419,8 +425,8 @@ soring_dequeue_start(struct rte_soring *r, void *objs, void *meta,
 
 	switch (st) {
 	case RTE_RING_SYNC_ST:
-		n = __rte_ring_headtail_move_head(&r->cons.ht, &r->stage[ns].ht,
-			0, RTE_RING_SYNC_ST, num, behavior, &head, &next,
+		n = __rte_ring_headtail_move_head_st(&r->cons.ht, &r->stage[ns].ht,
+			0, num, behavior, &head, &next,
 			&avail);
 		break;
 	case RTE_RING_SYNC_MT_HTS:
-- 
2.53.0

