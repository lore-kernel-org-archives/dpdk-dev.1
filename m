Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD0CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A70AE402DD;
	Fri,  9 Oct 2026 01:37:39 +0200 (CEST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 108DF40615
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:37 +0200 (CEST)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-88bc25fcd0eso4740999b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502656;
 x=1792107456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAs7diCg1jXneplOLpOBu/ZLVgYMfpNkriw4g3Vjx7k=;
 b=dTEKc3cmNAEAOTxPuINZOhmnJkTKIv3QwMISdG+F1UjAkGcE4xwTPaJDaPEjgkblzd
 MBzSfMWyIdnbMehCO/lQHqo/fAUE56bFhrE1KYN45ch4O32VT8Fl58UiBKKxhsxt8Raq
 uUsywoEEEShbXN31jJoujJHvIPyGWS3UfUpQw8vBB0iKQ6CrY4gzib9pK0VYtRjYsGf7
 lMcWOLhpeRuOVWmIlk8DOq6mGd+EzvMBxDYh1nbqSiEgVbms5a55XhuXTk+nuN1963eI
 B1IiHQaL461aWL+CAblwEUSb5wUBmZDfezlTtMGGHP3cLf6P6LQcbfrGA+H5lKPbqNjd
 BeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502656; x=1792107456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lAs7diCg1jXneplOLpOBu/ZLVgYMfpNkriw4g3Vjx7k=;
 b=TueWleZ6omy/vtaL4tKjM7nrE0pMZdwTRqxvjFw1WqqyHKz9zewaF0p0AD/JO6/RPe
 zIuY2WM1AjsZuxlYlMlZDpzCwxsZxek9dOuGKTYhHDYPYtP0ApsAdCQeqwjI8TqN9qsc
 zc8YQLqmkfAhIT+CT9TWt2bocgYWOL/AUIIsKyf6uLzuCZPzOpXii1VZ176ttFs04fUI
 ALh+By6ELESZgJpsSUMhU0axNzhzQghuYYHAfXFfY9+PptbBmymKOXi+TEpJD7hVJpUK
 5ixz5Gz1B9L0DdCzd+jxE/aRPJjZFkcM/ar20tN1PEuMmvg/WraWQNzMKKYUywMkKE2t
 CPfQ==
X-Gm-Message-State: AFq9FYJMSSRK6Pzh139qieTwnwfXNP66IWmr6dgnE+fAFRpuTV+f+6JY
 7pv0kEq+OLHpmoFTlrInaxfyWShNRCYa9DpbdDb8UsCe4ArpaT/u1X4jQ7I3tOISUDWH9kMzamI
 po6cbVR4=
X-Gm-Gg: AYBFou0PmC7nefmF+usyTkhTyGNI+P4z33+7BK1gzGo4bEA3UzWhzCGxLvfRhiJezvc
 Mbn1sfgwdN3G8cvdbFM2V/MsEz6yeVYPAMhfmlAGHmAaN5uWAg/diFFXKnf4iL//l2RP9rfosX6
 7NAHd7LXIrQKMFT9t//p7bmaCUDPs9QV5RPfzacNQTrDzrv5HlFhJJ5SE1N0JmCER8s48YwyVng
 LvBM69TBa/K4uL2u/q6yCiQCoB6d20o4phbkfzDcYv3nuysgB+pcG/jAeT70hD+18HZ1AkkJV18
 iN81oTyIjaKJfiTzo59Knl/fHP1VrgWfYV4dcidxBFFIOi9BdACzMaXITi2lEiID70dE3zQlOWG
 3R6l3N7JbSCOO9RNtXzKjFT6fhsv92xyA1zc5HhUnQj4bvLhzrqg3afdrgwkR4yQ1ALZjiqaLSH
 r0fFMGxfO35EFDgl9OB/nOOep/vUoIvO73J2NlnxJFhRcYGfOHtT76VpRXIgDaGunagmZG91XJ5
 AuHhfr+MXkgRpV6WRQvgOo9gCMfksEB9ZjB7g==
X-Received: by 2002:a05:6a00:330f:b0:886:65e6:a35e with SMTP id
 d2e1a72fcca58-897c78dd6e2mr46868b3a.31.1791502656121; 
 Thu, 08 Oct 2026 16:37:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v3 19/29] test/barrier: convert to C11 atomics
Date: Thu,  8 Oct 2026 16:35:12 -0700
Message-ID: <20261008233649.1260843-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

