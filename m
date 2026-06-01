Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D84CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8873402F1;
	Mon,  1 Jun 2026 20:15:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3036C402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:15:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gThts2sY7zJ4678;
 Tue,  2 Jun 2026 02:14:29 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id B5EE640584;
 Tue,  2 Jun 2026 02:15:29 +0800 (CST)
Received: from localhost (10.220.239.45) by dubpeml500001.china.huawei.com
 (7.214.147.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 19:15:29 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>
Subject: [PATCH] ring: avoid extra store at move head
Date: Mon, 1 Jun 2026 19:15:09 +0100
Message-ID: <20260601181509.71007-1-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500003.china.huawei.com (7.182.19.114) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

C11 __rte_ring_headtail_move_head_mt() uses output
parameter: 'uint32_t *old_head' directly within CAS operation.
In x86_64 that cause gcc to generate extra instructions to
store return value of CAS (eax) within 'old_head' memory location,
even when CAS was not successful and another attempt should be
performed. In some cases, even extra branch can be observed.
To be more specific the code like that is generated:
// start of 'do { } while();' loop
.L2
        ...
        lock cmpxchgl   %r8d, (%rdi)
        jne     .L17  //
.L1: // <---- successful completion of CAS, finish
        movl    %edx, %eax
        ret
.L17: // <---- unsuccessful completion of CAS, repeat
        movl    %eax, (%r9)
        jmp     .L2

In constrast, x86 specific version that uses
__sync_bool_compare_and_swap() doesn't exibit such problem,
as __sync_bool_compare_and_swap() doesn't update the 'old_head'
with new value, and we have to re-read it explicitly on each iteration.

Overcome that problem by using local variable 'head' inside the loop,
and updaing '*old_head' value only at exit.
With such change gcc manages to avoid extra store(/branch).

Depends-on: series-38225 ("deprecate rte_atomicNN family")

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h  | 19 +++++++++++--------
 lib/ring/rte_ring_elem_pvt.h |  5 -----
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 3efe011f08..ee98155bea 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -52,6 +52,7 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		unsigned int n,	enum rte_ring_queue_behavior behavior,
 		uint32_t *old_head, uint32_t *new_head, uint32_t *entries)
 {
+	uint32_t head;
 	unsigned int max = n;
 
 	/*
@@ -61,7 +62,7 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 	 * d->head.
 	 * If not, an unsafe partial order may ensue.
 	 */
-	*old_head = rte_atomic_load_explicit(&d->head, rte_memory_order_acquire);
+	head = rte_atomic_load_explicit(&d->head, rte_memory_order_acquire);
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
@@ -76,10 +77,10 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 
 		/* The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
-		 * *old_head > s->tail). So 'entries' is always between 0
+		 * head > s->tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = capacity + stail - *old_head;
+		*entries = capacity + stail - head;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -87,11 +88,11 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 					0 : *entries;
 
 		if (n == 0)
-			return 0;
+			break;
 
-		*new_head = *old_head + n;
+		*new_head = head + n;
 
-		/* on failure, *old_head is updated */
+		/* on failure, head is updated */
 		/*
 		 * R1/A2.
 		 * R1: Establishes a synchronizing edge with A0 of a
@@ -99,11 +100,13 @@ __rte_ring_headtail_move_head_mt(struct rte_ring_headtail *d,
 		 * A2: Establishes a synchronizing edge with R1 of a
 		 * different thread to observe same value for stail
 		 * observed by that thread on CAS failure (to retry
-		 * with an updated *old_head).
+		 * with an updated head).
 		 */
 	} while (unlikely(!rte_atomic_compare_exchange_strong_explicit(
-				  &d->head, old_head, *new_head,
+				  &d->head, &head, *new_head,
 				  rte_memory_order_release, rte_memory_order_acquire)));
+
+	*old_head = head;
 	return n;
 }
 
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 9d1da12a92..51176b0405 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -396,12 +396,7 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 	return n;
 }
 
-/* There are two choices because GCC optimizer does poorly on atomic_compare_exchange */
-#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
-#include "rte_ring_x86_pvt.h"
-#else
 #include "rte_ring_c11_pvt.h"
-#endif
 
 /**
  * @internal This function updates the producer head for enqueue
-- 
2.51.0

