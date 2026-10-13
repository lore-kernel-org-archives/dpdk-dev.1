Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D7CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E46A40DF5;
	Wed, 14 Oct 2026 00:35:19 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id DACFF40DDC
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:16 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e915887d9dso8386385ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930916;
 x=1792535716; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAs7diCg1jXneplOLpOBu/ZLVgYMfpNkriw4g3Vjx7k=;
 b=0yCZT4anQVjCflVOdESInWt9NGOOV1bHlHOdbvh6GPD7Th50noB1PqDaalflG53DM1
 t4GL4Fl6aXrifkCxiG/wAdfGWlnM9M2HwlJAyVlV+jQ1sM4NsaVFVbaoUO+i6YhLumZ1
 y2Qb0JKh7Yb7LJ23Y1L9sLZtEf3NMq9BoMv//4Ld5aiCBj7klnABrRrMrN1vRo2iVFF3
 l1d/rba3KgVmczke3J9PO3Ns9BvZo20E62mtUfpzRUlb+QpjjQ5TD5pgxaJY6/N1uai/
 qRT6KqStg6rgs6uwV7BecUFCDWYIxchAQSucf4Y05suA1kYsciem2k157zIRz2OPlFcK
 JUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930916; x=1792535716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lAs7diCg1jXneplOLpOBu/ZLVgYMfpNkriw4g3Vjx7k=;
 b=OnVv6lf/7iYmWngbA9u5jQAhoRzIXWL4uhx4SFLCxz4Ya2PjV7CpfMhdNQ+HxZa8Qt
 H1/+gBsj60vd1xaEOafzeoBIkGs0llzqqS6CdEW4j+bT7iLYwjdxLgIQiZ6FYhjJFA5o
 oQbRbEjqMnMGRrnASdDdsBsssyvTMFRzwqnjQhPlOXuu6bKcJh9/mmKmCYuTgwUhSM3M
 Yc/OtFTz5hcJ7HPnZekXbG9FixgxEk30/Q09/6QGVBQRosG1Ab6AcshFZ//RQ4qMbA1c
 wfQ0YIkYwOaL36zm/Hq6q1GMp1tx1ChEDt81TqWnYrp2Y5UXIliqxuKvYiamIfLlPmlZ
 PTIg==
X-Gm-Message-State: AFq9FYJNjWk18IdBzDc7jfUlON6rxShUiwa4lXFnpxJhr/pSXHKCNJ+P
 +ZVbNNKXuSIXlEaf1KWrrl51iGg04iES9NqREGIPdLUjrA1tDXo/frA/0NQBL5Ha9LdGRP21ToQ
 MrWCFktQ=
X-Gm-Gg: AYBFou3ChO5CBAjJwialxmEA/JTq3Ry8UurAG5Ml95nA6dckUtTWr/qndLJwMrLdM69
 Jd4xIRVpmCXZ0Faa4nsTyjClmQnfmK8VS130ahzn7bA9L2iXC8vGhgczI9N7PyqC1NQ4w/A+/V2
 0+tWj1+fK88oMJPyXM528SrDst+NRubxKpxPYo5WWaL2ilnOtN+QzY1qiCQgacyQ1TnaixWr9aV
 QS8NJ1UkPafjAFS4I4rr77ruq4MKbUZO5YJvOFcwz2teMDRhHL+XTzJuJbrnYCpXw2sHYpXFGVC
 qUF5PUfHanYj3xBWXcujGVmE6r9fmIMkXiqWPde4kqsf8vQfxiBDs5GZgGT8DVa6nGzzkrH9mU1
 qLO8NrNOy46MR3B0ySqRWFftDT8YnolwO6q9Ic5r4Ar7Uy2/iwWfIbMmZkCjvY/omQdIVfU4dT2
 Q2HLhR0or8wqcn48UfYOIZmwvT3G0ARsV4TmWCDZopufpU0J/UkzozEjjEa0pEyQ/h/3IXa9UzN
 8r7PMpHrrH0je2a6knpqfStljYg2ifTvB1+qg==
X-Received: by 2002:a17:902:f550:b0:2e8:4bb0:21ff with SMTP id
 d9443c01a7336-2e84bb02397mr117088825ad.68.1791930915988; 
 Tue, 13 Oct 2026 15:35:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 19/29] test/barrier: convert to C11 atomics
Date: Tue, 13 Oct 2026 15:22:32 -0700
Message-ID: <20261013222410.2257622-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

rte_smp_mb() is removed by this series, so the barrier test loses one
of its two cases. Replace it with
rte_atomic_thread_fence(rte_memory_order_seq_cst), which on x86 is the
hand written lock add that Konstantin pointed out is worth keeping
covered. rte_mb() stays as the other case: the test cannot prove much
about a barrier on any one architecture, but it does keep each one
compiled and executed.

Convert the Peterson lock to explicit atomic accesses. The loads in
the spin loop are relaxed, leaving the barrier under test as the only
thing that keeps them after the stores. The store of victim needs
release and not relaxed: the algorithm requires flag[self] to be
visible before victim, and two relaxed stores let a weakly ordered CPU
commit victim first, which admits both lcores into the critical
section with nothing wrong in the barrier.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Tested-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Acked-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
Tested-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 app/test/test_barrier.c | 71 ++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/app/test/test_barrier.c b/app/test/test_barrier.c
index 925a88b68a..29024f4242 100644
--- a/app/test/test_barrier.c
+++ b/app/test/test_barrier.c
@@ -2,35 +2,35 @@
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
+ * Functional test for the full barriers rte_mb() and
+ * rte_atomic_thread_fence(rte_memory_order_seq_cst).
+ * I.E. make sure that LOAD and STORE operations that precede the barrier
+ * are globally visible across the lcores before the LOAD and STORE
+ * operations that follow it.
+ * The test uses a simple implementation of Peterson's lock algorithm
+ * (https://en.wikipedia.org/wiki/Peterson%27s_algorithm)
+ * for two execution units, since that algorithm only works if
+ * store-load reordering is prevented.
+ * Also when executed on a single lcore it can be used as an approximate
+ * estimate of the number of cycles a particular barrier takes.
+ */
 
+#include <errno.h>
 #include <stdio.h>
-#include <string.h>
 #include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 
-#include <rte_memory.h>
-#include <rte_per_lcore.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
 #include <rte_lcore.h>
+#include <rte_memory.h>
 #include <rte_pause.h>
 #include <rte_random.h>
 #include <rte_cycles.h>
-#include <rte_vect.h>
-#include <rte_debug.h>
+#include <rte_stdatomic.h>
 
 #include "test.h"
 
@@ -39,13 +39,13 @@
 
 enum plock_use_type {
 	USE_MB,
-	USE_SMP_MB,
+	USE_FENCE,
 	USE_NUM
 };
 
 struct plock {
-	volatile uint32_t flag[2];
-	volatile uint32_t victim;
+	RTE_ATOMIC(uint32_t) flag[2];
+	RTE_ATOMIC(uint32_t) victim;
 	enum plock_use_type utype;
 };
 
@@ -70,18 +70,20 @@ struct lcore_plock_test {
 };
 
 static inline void
-store_load_barrier(uint32_t utype)
+store_load_barrier(enum plock_use_type utype)
 {
 	if (utype == USE_MB)
 		rte_mb();
-	else if (utype == USE_SMP_MB)
-		rte_smp_mb();
 	else
-		RTE_VERIFY(0);
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 }
 
 /*
  * Peterson lock implementation.
+ * The loads in the spin loop are relaxed on purpose: the barrier under
+ * test is the only thing keeping them after the stores above, so a
+ * barrier that fails to prevent store-load reordering shows up as two
+ * lcores in the critical section at once.
  */
 static void
 plock_lock(struct plock *l, uint32_t self)
@@ -90,22 +92,27 @@ plock_lock(struct plock *l, uint32_t self)
 
 	other = self ^ 1;
 
-	l->flag[self] = 1;
-	rte_smp_wmb();
-	l->victim = self;
+	rte_atomic_store_explicit(&l->flag[self], 1, rte_memory_order_relaxed);
+
+	/* Release so that the other lcore cannot see this lcore claim to be
+	 * the victim while its flag still reads zero, which would let both
+	 * lcores through.
+	 */
+	rte_atomic_store_explicit(&l->victim, self, rte_memory_order_release);
 
 	store_load_barrier(l->utype);
 
-	while (l->flag[other] == 1 && l->victim == self)
+	while (rte_atomic_load_explicit(&l->flag[other], rte_memory_order_relaxed) == 1 &&
+			rte_atomic_load_explicit(&l->victim, rte_memory_order_relaxed) == self)
 		rte_pause();
-	rte_smp_rmb();
+
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 }
 
 static void
 plock_unlock(struct plock *l, uint32_t self)
 {
-	rte_smp_wmb();
-	l->flag[self] = 0;
+	rte_atomic_store_explicit(&l->flag[self], 0, rte_memory_order_release);
 }
 
 static void
-- 
2.53.0

