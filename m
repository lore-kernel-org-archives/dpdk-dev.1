Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB40CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 730F24066B;
	Thu, 21 May 2026 20:07:16 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 0543740658
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:14 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30246cfd41aso36118eec.1
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386833;
 x=1779991633; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dd3L7GODFuE5uziy6hbyzVgAQgZVAriDHCffYhFZKac=;
 b=O+x99bTiOxpGb0tzr+4N85mV3ZMyKUzXyZdwSS1aa3ij0XLnSJcvCW4P/kpvuRwY39
 pi73Fxtdz5EVmcQnuHGWJ/0xtDT78nbyoFc+mghbKwmuUnBvcXSa+k9mfX6HuPpUbxxa
 P/k/hMs/yVdt3IuvVKPwnKRp/Gxx8BAZchQXovcfC4PKVwBqcEP0UrBYJwsh01w+g7Ek
 me4OwwOCp6hhmj5Xat8NTSVKv9u7EOCzClBjhOQmkB6MyqLJLvXBfFB7bebjbNQotG8M
 fRS7AZVe8ry4bQU7/p1FpqTY5EvR2Grv5HSuw/B5B0WEJLMj5V7RZWebWloWXrFm5GaL
 efeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386833; x=1779991633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dd3L7GODFuE5uziy6hbyzVgAQgZVAriDHCffYhFZKac=;
 b=A5OQEpexvQclEJIN/DCbBa+K5aBz/5LOAsWTmyY0byBmCpUO9y8iyeXmq/oDbnt3WZ
 EAFGPm0oIYUhjdCvzkedXOni0viy92Wk7Z0uAmSkrNUN0ZSflaKGpj+kGha7nv7S3QBx
 f0smcWnB8ITwzIkMrJV6tkG6IKcSbMz4+rYTKCjO+mOsi2DTmrRmYO/a5Bk5Xa5QLgBO
 pYoG/hosBhS4WJ8Cl5324BhEHGwRkBJUcd8js/EJi5RnPfVMWpGea6+wckn7ZdFgmTAq
 qRkWEURvGQv23EAaVYuJoDhNafu19t6qoC+qOK4LfUcMdFW+S5M7vwpy+OoQ26/Qezjn
 XaeA==
X-Gm-Message-State: AOJu0YymnlFVL3msMBiwLYRFSXSf6wS6TOpQR7s+zMvzhN1Iyu/eRmHL
 KL4ZSlkLMpv5WAKZ7kQ0s9eZJ26KeU1NioaKYMzpOWVLXvAWFoJb2lGCkZ6hwFJqN6Kabz5hHHb
 REObn
X-Gm-Gg: Acq92OEdT8X9DCHyjuU4d8lfOYkQFMClQvYsEg7T4vf3cfQaM7Uj714U3wEgrcDhB/5
 Fy2SerKOHfyx6AGJ2N5ShbgqP4PjLA+B30VL86WmR22MN+zWXENnBa2F3FpVOtAU+3Xxj9yhgw6
 j8yooUP87oIHHiT4HMPCnCzFyMs0Uv+SIj9qVPG33H6scEyt9mEane19dDB4UI8fy1ZdfO4SoO3
 IWaFeqxtSED4mMyYt8ehruOAVaN2zRLr6b7M5jJLfe5TIWyfDyA5bE2WMYDjRbs3+L+GDTxQ185
 cHwVRT/NmeX7G1apxqhDW2c3kgbOPip2lpMNqb+8doEuYew+qeaeF/U6tTac7RxSmD/Qqm5+OJq
 HfKBW60gy4Hs126n+2TJpYW7/BNRhqAKRxPHRgqadx+CMIVrFAVqYyfdlk+7thss3AtvrawBGrl
 mgARz0VQpgDn6j2Nqixb/nEiXmSbmPYcamUBIhyjZYeG8AVoVWwEHkK6G4bUOYF6xasioaX2am
X-Received: by 2002:a05:7300:e8ae:b0:2dd:6937:79c8 with SMTP id
 5a478bee46e88-30449024b81mr161364eec.5.1779386832939; 
 Thu, 21 May 2026 11:07:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC v2 03/11] ring: use C11 atomic operations for MP/SP head/tail
Date: Thu, 21 May 2026 11:04:15 -0700
Message-ID: <20260521180706.678377-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

Last caller of rte_atomic32_cmpset() in lib/, blocking deprecation
of the rte_atomicNN_*() family.

Replace cmpset with rte_atomic_compare_exchange_weak_explicit(),
and convert head/tail loads/stores from implicit seq_cst to explicit
acquire/release. Matches the HTS/RTS pattern.

Acquire-load of d->head orders the subsequent load of s->tail (was
rte_smp_rmb()). Acquire-load of s->tail pairs with the release-store
of the counterpart tail in __rte_ring_update_tail(), which subsumes
the previous wmb/rmb barriers.

Weak CAS avoids arm64's hidden inner retry; the outer do-while already
loops. CAS orderings relaxed: no data published by the reservation.

The now-unused 'enqueue' parameter of __rte_ring_update_tail() is
removed; both call sites updated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_generic_pvt.h | 65 +++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
index affd2d5ba7..84570fd5fc 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -23,21 +23,24 @@
  */
 static __rte_always_inline void
 __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
-		uint32_t new_val, uint32_t single, uint32_t enqueue)
+		uint32_t new_val, uint32_t single,
+		uint32_t enqueue __rte_unused)
 {
-	if (enqueue)
-		rte_smp_wmb();
-	else
-		rte_smp_rmb();
 	/*
 	 * If there are other enqueues/dequeues in progress that preceded us,
 	 * we need to wait for them to complete
 	 */
 	if (!single)
-		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
-			rte_memory_order_relaxed);
-
-	ht->tail = new_val;
+		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail,
+			old_val, rte_memory_order_relaxed);
+	/*
+	 * R0: Release store on the tail. Pairs with the acquire load of the
+	 * counterpart's tail at A0 in __rte_ring_headtail_move_head() on the
+	 * other side. Ensures slot operations performed by this thread (writes
+	 * for enqueue, reads for dequeue) become visible before the new tail
+	 * value is observed by the other side.
+	 */
+	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
 }
 
 /**
@@ -76,25 +79,35 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 {
 	unsigned int max = n;
 	int success;
+	uint32_t tail;
 
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
 
-		*old_head = d->head;
+		/*
+		 * Acquire on d->head and acquire on s->tail below together prevent
+		 * the two loads from being reordered (was rte_smp_rmb()) and
+		 * re-establish ordering after a failed CAS on retry.
+		 */
+		*old_head = rte_atomic_load_explicit(&d->head,
+				rte_memory_order_acquire);
 
-		/* add rmb barrier to avoid load/load reorder in weak
-		 * memory model. It is noop on x86
+		/*
+		 * A0: Acquire load on the counterpart's tail. Pairs with the
+		 * release store at R0 in __rte_ring_update_tail(), ensuring slot
+		 * operations on the other side are visible before this thread
+		 * accesses the reserved slots.
 		 */
-		rte_smp_rmb();
+		tail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
-		 * *old_head > s->tail). So 'entries' is always between 0
+		 * *old_head > tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = (capacity + s->tail - *old_head);
+		*entries = (capacity + tail - *old_head);
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -106,12 +119,24 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 
 		*new_head = *old_head + n;
 		if (is_st) {
-			d->head = *new_head;
+			rte_atomic_store_explicit(&d->head, *new_head, rte_memory_order_relaxed);
 			success = 1;
-		} else
-			success = rte_atomic32_cmpset(
-					(uint32_t *)(uintptr_t)&d->head,
-					*old_head, *new_head);
+		} else {
+			/*
+			 * Weak CAS: the outer do-while handles spurious
+			 * failures, so we avoid the strong variant's
+			 * internal retry (which on arm64 wraps the LL/SC
+			 * pair in a hidden inner loop).
+			 *
+			 * Relaxed on both success and failure: this CAS
+			 * does not publish data. Slot data visibility is
+			 * provided by the acquire loads above and the
+			 * release store of tail in __rte_ring_update_tail().
+			 */
+			success = rte_atomic_compare_exchange_weak_explicit(
+				&d->head, old_head, *new_head,
+				rte_memory_order_relaxed, rte_memory_order_relaxed);
+		}
 	} while (unlikely(success == 0));
 	return n;
 }
-- 
2.53.0

