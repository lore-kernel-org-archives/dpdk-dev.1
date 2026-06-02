Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5844FCD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B518A40677;
	Tue,  2 Jun 2026 19:16:02 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 85F3D402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:16:01 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-13721dfd471so11307485c88.1
 for <dev@dpdk.org>; Tue, 02 Jun 2026 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780420561;
 x=1781025361; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbWHI3TiCRHnGL9XrCgSy5RGY/AU4ahPLwMY1ZcOA78=;
 b=l6JdhB1E7K6YJzWJ9RNG6iy/cpTa9KU47lmdFh7ZbemCeaawjq0nsYI5MnwzG832ct
 6h7XHMSYCpCclOeDyZ+GBZFyXOc32oSlxCb++rq0/YVEGlYdNQDVU0Tef4TVocrjVQ+d
 Z2NMiQ/rH2q1LRvctlpb9KcGhRPUixh8ImVzBGLzXKYYkasnC/pByv3MBFLUMemMAdBe
 9Q/DkV1YTqdJlneh/ZQlZlImn53dJS1ShMOy0103gi43uZr4IWPGhrD4HnBgEktswzhf
 9JNTRGxmtcwHTM6EFJE0OQjROz3AYQa11F3TVFWyFLruVkx9AzAYmIISf/azC3azIzgV
 rF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420561; x=1781025361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jbWHI3TiCRHnGL9XrCgSy5RGY/AU4ahPLwMY1ZcOA78=;
 b=Be+uy8DXWgbHE6qewc9y4YWa5EjBcASTaTEFT6X7dp5KnojqS/na0oNM1ZkfjIEirD
 4s+ouMxpd1FNMTuslpdrmkHJyZJ2KS/InIu9EEkb2hMOW0f+GX/ebl7JY4kueLtbcren
 TSIDDQMh7d5pUbnU/bO442PhXjn3FXI1qQn0PkRw9789BFsVy+6p2OLir1RZ7r2zKDez
 cRoYsphIVFQ9wOD1QndNxbzYhpCUgv7xQVPmSLlGC+r7Q1sJKl9xWFu/gfrWvArQa1jU
 yIk1V2XCa9mBf8dkmSMlLOwulCSuzk4fMPdXLdNyMt2J978byEzQC1ghTSAWsmsTsrH7
 GRBA==
X-Gm-Message-State: AOJu0YyNdc2U5BA1ya89oBi40peDCyFWxPNrUEVe4b7oCdOedLU9kgI4
 WriSOazDOgNXlKtinDQvhGu6uweDUWSgMvY3fj/rxWFpUvF5EG/KUwDYyaLnMOfxnKy8hbcVLGN
 8xhU+
X-Gm-Gg: Acq92OES6/DcBuzz3YW0M8n5aImpmylX/l2PyvFSL4mojpkGaH2tYKzSwIwzltjJpa/
 KH3GdKUCYzUv8UvqJECQ26iRVW+GE7dLT2pmsxvDrON+dHxN7FBg9Wd80owa8uoqpsWJORf4KZ7
 Gw8VJ2U2GvcJKYTgZ+gJ2ZRl4io7V01Z1vQl0pV6wFW5MW91btWBJ+3ED+AJpDTgI9Pc/CB6+Qi
 fmspEL5vmc7LWmS1vPF7Xszdu+ri34qCs8GR2YyZX+sb+LSENaxqgvXTmsyUg0z6/FWiX9IJJwl
 MWUJay6qA2Nd4yLvaePUBY09pesXQVvNPLNrb+b631tnhAuPO5+SycaTFqBB1T5Omuh18TkxBfX
 nrf1+kAdq2DIKACTXCyV1hNKZ2UBmz9+RDaMo3YBCHF7SQ5d0M947Xtt/C+9DmdX2phK7K6GWdw
 LT9su52R8eiIu5USDxyOvKj4S3G8r/sms/8t6PBYp2o0z8WVsKfPkThEJUWau9Zk4gdaLESUddN
 J07IPcOS44=
X-Received: by 2002:a05:7022:f909:b0:137:ea7d:a5df with SMTP id
 a92af1059eb24-137ea7da6c3mr1920696c88.37.1780420560393; 
 Tue, 02 Jun 2026 10:16:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm256095c88.9.2026.06.02.10.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:16:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 5/5] ring: use C11 for single thread move head
Date: Tue,  2 Jun 2026 10:07:31 -0700
Message-ID: <20260602171552.686349-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602171552.686349-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
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

The function to move head for single threaded case can always
use the C11 code, there is no performance difference from GCC
intrinsics.

This reduces the exception code to just one function.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_c11_pvt.h  | 62 ------------------------------
 lib/ring/rte_ring_elem_pvt.h | 74 +++++++++++++++++++++++++++++++++---
 lib/ring/rte_ring_gcc_pvt.h  | 59 ----------------------------
 3 files changed, 68 insertions(+), 127 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 3258829696..0ba64379fa 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -19,68 +19,6 @@
  * For more information please refer to <rte_ring.h>.
  */
 
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
-	*old_head = rte_atomic_load_explicit(&d->head,	rte_memory_order_acquire);
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
 
 /**
  * @internal This is a helper function that moves the producer/consumer head
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 74b5fef771..cd77343f38 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -319,12 +319,74 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
 }
 
-/* Between load and load. there might be cpu reorder in weak model
- * (powerpc/arm).
- * There are 2 choices for the users
- * 1.use rmb() memory barrier
- * 2.use one-direction load_acquire/store_release barrier
- * It depends on performance test results.
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
+	*old_head = rte_atomic_load_explicit(&d->head,	rte_memory_order_acquire);
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
diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 6b14c1c822..ec26fe557a 100644
--- a/lib/ring/rte_ring_gcc_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -90,63 +90,4 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
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
-- 
2.53.0

