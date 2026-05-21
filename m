Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A6CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15C9240661;
	Thu, 21 May 2026 06:20:53 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 0A2CF4042F
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:50 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2ee990e8597so14203744eec.1
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337249;
 x=1779942049; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIVYl+uBGRZGTVS/khnzfaLwaCESFaDhD2HYlU/ho5g=;
 b=P/OlR8oy1QgKbuaEELuNRSpbvj2mTBJa7/BAVf2bHZOkaghMynfS3L7itoZ32iNSem
 fG4v85h/Ay6VN/QO4PJ3dtjep7/NVbCh1ZgQlmJzMGmPJyO8AZ+IunI2ZWC3Hx/f2aj5
 MvrnFwl3MaAm8sdmGvuLUUhX7A9VGOLSmAS0UBPVDxkACBzyPVySMhy+M0oYRGT8kXgh
 H70T0elX2PCRmjOhN11bh2BWBSdA7IHfKFvl6sR2pqwHc2fGVYeY+WOc8rnYxxUujPWN
 dxtfhHu+7zab8SIfVWkLCtp9jJul0VXEyULBSt6q0LQz4NA1v/Qz67aqI+VcZhH5Ctv7
 Yc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337249; x=1779942049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tIVYl+uBGRZGTVS/khnzfaLwaCESFaDhD2HYlU/ho5g=;
 b=qf8UL7oheuxcmQYsNx6nSHA8BW+wJ9FSKbFXtooBJqcjY8Z6VhkMIRxL4Y5hdfws0Q
 piJYlglxICPKLCsh0R5X+Fm9/dbr/ECHYh/F0FX1MMlod3LFFQpiT7swap+1PpQ5StGP
 TbG4RkMTVYTwIS3G++alsdraLHJUHnt1Qsu4xHsoCCVr8yPhjwD2wLGcnKaXDRet+Jxv
 fwMUpJyehahHuSX5pOPzFXmQtfnSHSMwNzA8w/pF8mbmCMlHHJgJLA+t6FOAvoBliiaa
 5gLab+SNgkG3NJpoe7qN2VVsL2TssLIrVk5AH9g5PxlbJ0nasUF1nBEecvJeMAgC4qS2
 YMDQ==
X-Gm-Message-State: AOJu0YzzUbBdx7niM551Eq4cp+jz8JgKm/xk5QwXmcLsrBAwu4nhMSD7
 osR0yFuNYhssb7HRcaHgghV1VhDa55Wf6WOa7+8HGrL0sZEQC8N7075/qFve3A0PsjFBN4FBUrr
 0paiw
X-Gm-Gg: Acq92OFMkdD7zjOpWAVsbHGjStO2SFIeSTgdMC6SPpGd2IjiwqOy9+++MjhzfZp18Xk
 o+rNq+I8tb6TDSR5rwWzkRafsgQhgnzNO0mYZ0WzA6razLjMQ/5q63RWrwuis32H3aaJphOunb9
 rgwt2ZJ4LYUU5ikUideIBZ7Kpjq12NAGO4br0Fi5GxeGyBbGStWdKaKYtw2G482IfXcGYYIKxzS
 HZEf4But5hbIBLmKSJVmDf8agHfLsgyVSRDKDtTyA8/IlfcL0oGpb3GV4Vi26DPEcT4ZwmkgVAT
 lbFElqhc0kPLmsdzfBrOB4vnjduINSq61zV3uNm8CIDQlYV7AL5ie5w+XLwoWNH58E6xUbRp9wq
 SWiyiMA6rt+AOwSsTD7ZntW74r0kWc6X2HAoLNU3UgE3nlSGgk6KcCW7DPoApiprNEUmv4tDSiI
 qSAzNgfZgHH8zx/lC0qQBXU+1mgkKTBFCmQeBknzdylhypPbE+E1gy3KpyKFlXhw==
X-Received: by 2002:a05:7301:9f0b:b0:2ff:c5b1:2d6b with SMTP id
 5a478bee46e88-3042fad5bf3mr733277eec.32.1779337249075; 
 Wed, 20 May 2026 21:20:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC 3/7] ring: use C11 atomic operations for MP/SP head/tail
Date: Wed, 20 May 2026 21:17:03 -0700
Message-ID: <20260521042043.1590536-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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
 lib/ring/rte_ring_generic_pvt.h | 64 +++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_generic_pvt.h
index affd2d5ba7..9497f6737b 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_generic_pvt.h
@@ -23,21 +23,25 @@
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
+		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail,
+			old_val, rte_memory_order_relaxed);
 
-	ht->tail = new_val;
+	/*
+	 * Release ordering on the tail store ensures that the slot reads
+	 * (dequeue) or writes (enqueue) performed by this thread are visible
+	 * to the other side before the new tail value is observed.
+	 * Pairs with the acquire load of the counterpart's tail in
+	 * __rte_ring_headtail_move_head().
+	 */
+	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
 }
 
 /**
@@ -76,25 +80,35 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 {
 	unsigned int max = n;
 	int success;
+	uint32_t tail;
 
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
 
-		*old_head = d->head;
+		/*
+		 * Acquire load: orders this load before the load of s->tail
+		 * below (replaces rte_smp_rmb() in the previous version) and
+		 * re-establishes ordering after a failed CAS on retry.
+		 */
+		*old_head = rte_atomic_load_explicit(&d->head,
+				rte_memory_order_acquire);
 
-		/* add rmb barrier to avoid load/load reorder in weak
-		 * memory model. It is noop on x86
+		/*
+		 * Acquire load on the counterpart's tail pairs with the
+		 * release store in __rte_ring_update_tail() on the other
+		 * side, ensuring slot operations performed there are visible
+		 * before the caller accesses the reserved slots.
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
@@ -106,12 +120,24 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 
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

