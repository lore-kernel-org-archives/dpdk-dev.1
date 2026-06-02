Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F93CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:16:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6E844066D;
	Tue,  2 Jun 2026 19:16:00 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 7D9074065E
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:15:59 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304c520fe9aso707251eec.0
 for <dev@dpdk.org>; Tue, 02 Jun 2026 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780420558;
 x=1781025358; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MVguW5jlxGQyvgDHD/SVMvGWOfYRIsGHNuPavz7+iA=;
 b=hpzlZyqloKbB1dCD08GxT5bxWFOezEQjrMTDwCcp/zte8PrGUrjwi6d6d3g9dbkQu+
 FHKSs9yEROqT8EP7hGcuGTgHsiQNh/GJyOaLZJ0K9MXjzDw7RqRJjZb5g1dHbIDXggko
 Q1JQJjrEo/mENWQHUg6M8fOAc5o1YN8oZ+N/zbU6u0ASkn2I5zRyVZJACgQR8ZWnNXp2
 UyVRjYiHmkQcMq4gJAiGtTMGm54n3dSy+FznqHVSVeuGX/QFouP4osOMffPFFcq+6MRS
 7BomkySIA34cn3JGx2l5NToSinl4VzHrxPfPW+9wbVpiAtY1pbF30DkQBANhWojVHCSA
 AnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420558; x=1781025358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MVguW5jlxGQyvgDHD/SVMvGWOfYRIsGHNuPavz7+iA=;
 b=bTNe9lz6XhVQRubVhuWYky1qDUfty7nOsUFFTfzgj7aFyN6CAn5WcLZEpMZXwYDg1L
 t2melEFBuIyOgJhpCJm4Wesb2WilhA0IEb2VD52LvxHFrllo0r7rMgs9HpXBXI+JWYai
 cxjU4pDUqBXkTdxojSAqCqJGawQV0IpTWkH2/zAYg7NTYJ5OXKPT/cOTk7SfvvV6/v8i
 siEkRX4Au3J1skW4+xoQyii5Z800HH7mXbg+/AUMpNj5jiDzK6TDaQ42vewm29GLreoa
 84+d9RIxEOJYShYzFcuh79iBrzGNYQs4ikd1UIOGHPyLOz9JbERAKGZv3mtsZOGMMUjy
 F1FA==
X-Gm-Message-State: AOJu0YyaCCCGYV1cF1pyGcBkKmzWLoyzNfs6GXs0qZWUOhswXh87CV+y
 ZDVJlbX4t0DkEt9Mjo9pEAcU4bchQEo2PgySRRn2GIDw824PshwF40bkkSG4rDXZ1a43azvbf4U
 iWhxy
X-Gm-Gg: Acq92OFZGs9uQuKxhk6c5j3yLzTp9WgOD4tdPBmTCE16tVVhY+5YSzaCUIqV1mOgpLe
 CZqSsCVn9I1WEvWrOoi/u3xYVVko4GPNBaRxKRqCwwqepcQP26UngvtqW7/puNUS83VqmmU0IVk
 XKycqZO0N5WkeqVOrLLGbM7UpbOEA1Tr8+aLeFfL6eVJKn5Axlkfgv9XfMZTFZNSj1z82+if80e
 qQTB/qDxPzsv0SjT3giRV472wSAgPlAHHwONd9q25pXczJ3Fn3cbgUXP13Qtn5aJsIR7lHu1KRA
 zsnYS2lE8lM6HWlIsfNHBeYTu/+0t/qRNDcSs235kT2LGAHHu4H0mtuAxALCaBqxqCgRqMvjCro
 z2lAu0+6JNtCIvE9notC1fCDSp6NjshdZ5HVKVheLAYF6+n+aZdemXjqtKgPGot69wqDd65CrgR
 e8ZEU5UOslL7IKyK1+8jXevRucZijcSjZTKj/QURnImBUV7x0aqGaP/D4M3BaVIzdeuajkmgMZ
X-Received: by 2002:a05:7301:129b:b0:304:e58b:cccb with SMTP id
 5a478bee46e88-304fa49e4c9mr7646711eec.2.1780420558329; 
 Tue, 02 Jun 2026 10:15:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm256095c88.9.2026.06.02.10.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:15:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 3/5] ring: use C11 for update_tail
Date: Tue,  2 Jun 2026 10:07:29 -0700
Message-ID: <20260602171552.686349-4-stephen@networkplumber.org>
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

The GCC builtin atomic special case is not needed for updating tail.
The performance is the same with C11 memory model.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/rte_ring_c11_pvt.h  | 24 ------------------------
 lib/ring/rte_ring_elem_pvt.h | 22 ++++++++++++++++++++++
 lib/ring/rte_ring_gcc_pvt.h  | 25 -------------------------
 3 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 8358b0f21f..3258829696 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -19,30 +19,6 @@
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
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *    optimized for single threaded case
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 9a0170c4f0..a7ff76931b 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -299,6 +299,28 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 			cons_head & r->mask, esize, num);
 }
 
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
 /* Between load and load. there might be cpu reorder in weak model
  * (powerpc/arm).
  * There are 2 choices for the users
diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 9033a15647..6b14c1c822 100644
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
-- 
2.53.0

