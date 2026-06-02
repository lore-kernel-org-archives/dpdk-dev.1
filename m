Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E874CD6E60
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6BA940663;
	Tue,  2 Jun 2026 19:15:59 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 60A5640658
 for <dev@dpdk.org>; Tue,  2 Jun 2026 19:15:58 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137f27712fdso299620c88.0
 for <dev@dpdk.org>; Tue, 02 Jun 2026 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780420557;
 x=1781025357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+awK2McfrAd/SVy+XqBTY7Z9i2GZ31hAL330gs5CdTc=;
 b=xOhEwSkONPBNd1kpbnQT9Csh4GSCgWPsVE1wI7MOsYY+0Ejjuo2tI69Xbz7ncEYDLY
 DYlBQrszfwwEhDv2MxdM1pksV4Bo2BTRdmPhSm/i9M+L3/cliEc0guAcRiIyptDViESe
 PCJfQTEgyNK+aM8Gdx8+Q1Jxz2IIckNYtSJxvLulqTvfvkVzLfliyVCp3RVEu7v8DRdw
 ISYSiBajQ2HZbhT9xQKXESpgoKEM1vmxyG2OF346SnURZ4By7DH70ELQl7yA6N/7YMG9
 /B7sPHrmghtzotH4nbe6K2ibPGjIFKufzEOFdv5IuCvfFz4G6xD7gpqBBEc6RyMZzZzB
 BOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420557; x=1781025357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+awK2McfrAd/SVy+XqBTY7Z9i2GZ31hAL330gs5CdTc=;
 b=YBJkVkgy1Qq7o405m85lXvA+pXWP6QmAoCPnmiUViVAGWjG2f2e61JfWWuFP7NW1WK
 ruWHulUDjVPwpfSSwRTyLTm9Ltdbgaive/dvE6ADegTjJP02LvmWTs44ag6MQMenQEZ+
 MaJTU5/2XydCVDuYOGJaEmYK7/EhyVRP7UbWsb9L1OvDB0MuTI7tNO25LA0Y24jzaTRE
 knfwH2IfU2M+uSQkODMarUvDvn5zy+0cX8YgheY9lH+rRmSDpEHp5RL494Ia9sJrfMBc
 +gq/v98qUiu/0VFapujQBtDPqyjKO/i/zwjoTRMHIl1Ka9R8/b6r0mgbwKJDCqaxyJgE
 QuBw==
X-Gm-Message-State: AOJu0Yzd9qKj6Dzv8qs1QscWumqpjOa5f/8Uix4ucHZqwclQoKEnpk8m
 ImVzhPgSiY/Ldzoo7c1Q5qsYW6VGSFfx+CfQ1sCV6Xlg9N/bArOJeLwNRCKXPzOIB46VG0P9uN4
 5lrff
X-Gm-Gg: Acq92OFkXIUqP/gxEp56xxqEMEVfWHf4A3clfcJ/Rt5HMgJfZ6PZXtykSHpL42iNYju
 UZk2obkrdmJN0Ztv71MCnIbhjMGhi21yqJvmxLc/ptwTvyb2TyxAQTbiV3QlKQ3gMd36dGiLQD5
 PIEpeMdO0kycGV+eTOQJLc5TUPeDMkGnyI0lBigQkFySwu+TBMmQPnrlruu8h1YuYiRT5FhpiA4
 HvUUt4dFU/8mmYWhuz26VbPLWrFSPHeXFx3AknyEBwmmSBRoTSwkCXaSOoKL8fELTIjiS0IMWpK
 BMDI6nTGFru3YJLjxp+CsFRlDQWddZc6ZMc+rIrmyy+db9wW/0dzDu3La0oTwdUo6cqWIf+GZA1
 Xfoq/DXmNi/0Qpga6hkTDQhzEDJQJQzt7kgcYx6Xxsj5fY06qWvdqPyCuyfOkmPfSNP/qjIaLnA
 aY2drC6BIMFAojI9YfFf9aqj8n1bmyszzpNU9bB3WPixznosySPOnepMf4WmoRbDCGK9/LfLj11
 WSUB0EgPcA=
X-Received: by 2002:a05:7022:f314:b0:137:f4ec:2a2c with SMTP id
 a92af1059eb24-137f4ec2cc4mr280258c88.41.1780420557276; 
 Tue, 02 Jun 2026 10:15:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5539432sm256095c88.9.2026.06.02.10.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 10:15:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Date: Tue,  2 Jun 2026 10:07:28 -0700
Message-ID: <20260602171552.686349-3-stephen@networkplumber.org>
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

This patch replaces use of the deprecated rte_atomic32 code with
GCC builtin atomic operations.

Although it would be preferable to use C11 version on all architectures,
there is a performance loss if we do it that way:

Measured on i9-13900H, two physical cores MP/MC bulk n=128, 10 runs:
  with C11 builtin:           5.86 cycles/elem
  with __sync builtin:        5.36 cycles/elem  (-9.4%)

The C11 __atomic_compare_exchange_n builtin writes the actual value back
to its expected pointer on failure. On x86 this forces GCC
to emit extra instructions on the critical path between the CAS
and the success-test.

__sync_bool_compare_and_swap returns a plain bool with no pointer
writeback, allowing GCC to emit tighter code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ring/meson.build                          |  2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  3 +-
 lib/ring/rte_ring_elem_pvt.h                  |  2 +-
 ..._ring_generic_pvt.h => rte_ring_gcc_pvt.h} | 37 +++++++++++--------
 4 files changed, 24 insertions(+), 20 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_gcc_pvt.h} (87%)

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
index 5afc14dec9..8358b0f21f 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -43,7 +43,6 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 	 */
 	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
 }
-
 /**
  * @internal This is a helper function that moves the producer/consumer head
  *    optimized for single threaded case
@@ -82,7 +81,7 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 	/* Single producer: only this thread writes d->head,
 	 * so a relaxed load is sufficient.
 	 */
-	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_relaxed);
+	*old_head = rte_atomic_load_explicit(&d->head,	rte_memory_order_acquire);
 
 	/* Acquire pairs with the consumer's release-store of tail in __rte_ring_update_tail,
 	 * ensuring the consumer's ring-element reads are complete before
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index a0fdec9812..9a0170c4f0 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -309,7 +309,7 @@ __rte_ring_dequeue_elems(struct rte_ring *r, uint32_t cons_head,
 #ifdef RTE_USE_C11_MEM_MODEL
 #include "rte_ring_c11_pvt.h"
 #else
-#include "rte_ring_generic_pvt.h"
+#include "rte_ring_gcc_pvt.h"
 #endif
 
 /**
diff --git a/lib/ring/rte_ring_generic_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
similarity index 87%
rename from lib/ring/rte_ring_generic_pvt.h
rename to lib/ring/rte_ring_gcc_pvt.h
index c044b0824f..9033a15647 100644
--- a/lib/ring/rte_ring_generic_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -7,11 +7,11 @@
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
@@ -25,10 +25,8 @@ static __rte_always_inline void
 __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 		uint32_t new_val, uint32_t single, uint32_t enqueue)
 {
-	if (enqueue)
-		rte_smp_wmb();
-	else
-		rte_smp_rmb();
+	RTE_SET_USED(enqueue);
+
 	/*
 	 * If there are other enqueues/dequeues in progress that preceded us,
 	 * we need to wait for them to complete
@@ -37,7 +35,12 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 		rte_wait_until_equal_32((volatile uint32_t *)(uintptr_t)&ht->tail, old_val,
 			rte_memory_order_relaxed);
 
-	ht->tail = new_val;
+	/*
+	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
+	 * Ensures that memory effects by this thread on ring elements array
+	 * is observed by a different thread of the other type.
+	 */
+	__atomic_store_n(&ht->tail, new_val, __ATOMIC_RELEASE);
 }
 
 /**
@@ -72,8 +75,8 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		unsigned int n, enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
+	bool success;
 	unsigned int max = n;
-	int success;
 
 	do {
 		/* Reset n to the initial burst count */
@@ -81,10 +84,10 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 
 		*old_head = d->head;
 
-		/* add rmb barrier to avoid load/load reorder in weak
+		/* add fence to avoid load/load reorder in weak
 		 * memory model. It is noop on x86
 		 */
-		rte_smp_rmb();
+		__atomic_thread_fence(__ATOMIC_ACQUIRE);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
@@ -92,7 +95,7 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		 * *old_head > s->tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = (capacity + s->tail - *old_head);
+		*entries = capacity + s->tail - *old_head;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -100,13 +103,15 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 					0 : *entries;
 
 		if (n == 0)
-			return 0;
+			break;
 
 		*new_head = *old_head + n;
-		success = rte_atomic32_cmpset(
+
+		success = __sync_bool_compare_and_swap(
 				(uint32_t *)(uintptr_t)&d->head,
 				*old_head, *new_head);
-	} while (unlikely(success == 0));
+	} while (unlikely(!success));
+
 	return n;
 }
 
@@ -169,4 +174,4 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 	return n;
 }
 
-#endif /* _RTE_RING_GENERIC_PVT_H_ */
+#endif /* _RTE_RING_GCC_PVT_H_ */
-- 
2.53.0

