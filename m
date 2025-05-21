Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F38C54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9A3B427BD;
	Wed, 21 May 2025 13:15:16 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5B8B0427BD
 for <dev@dpdk.org>; Wed, 21 May 2025 13:15:15 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TJz5y15z6H6rX;
 Wed, 21 May 2025 19:12:03 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 038ED140519;
 Wed, 21 May 2025 19:15:15 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:15:14 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: [PATCH v1 3/4] ring: fix potential sync issue between head and tail
 values
Date: Wed, 21 May 2025 12:14:31 +0100
Message-ID: <20250521111432.207936-4-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

This patch aims several purposes:
- provide an alternative (and I think a better) way to fix the
  issue discussed in previous patch:
  "ring/soring: fix synchronization issue between head and tail values"
- make sure that such problem wouldn’t happen within other usages of
  __rte_ring_headtail_move_head() – both current rte_ring
  implementation and possible future use-cases.
- step towards unification of move_head() implementations and
  removing rte_ring_generic_pvt.h
It uses Acquire-Release memory ordering for CAS operation in move_head().
That guarantees that corresponding ‘tail’ updates will be visible
before current ‘head’ is updated.
As I said before: I think that in theory the problem described in
previous patch might happen with our conventional rte_ring too
(when RTE_USE_C11_MEM_MODEL enabled).
But, so far I didn’t manage to reproduce it in reality.
For that reason and also because it touches a critical rte_ring code-path,
I put these changes into a separate patch. Expect all interested
stakeholders to come-up with their comments and observations.
Regarding performance impact – on my boxes both ring_perf_autotest and
ring_stress_autotest – show a mixed set of results: some of them become
few cycles faster, another few cycles slower.
But so far, I didn’t notice any real degradations with that patch.

Fixes: b5458e2cc483 ("ring: introduce staged ordered ring")
Fixes: 1cc363b8ce06 ("ring: introduce HTS ring mode")
Fixes: e6ba4731c0f3 ("ring: introduce RTS ring mode")
Fixes: 49594a63147a ("ring/c11: relax ordering for load and store of the head")

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h      | 27 +++++++++++++++++----------
 lib/ring/rte_ring_hts_elem_pvt.h |  6 ++++--
 lib/ring/rte_ring_rts_elem_pvt.h |  6 ++++--
 lib/ring/soring.c                |  5 -----
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index 0845cd6dcf..6d1c46df9a 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -77,20 +77,19 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 	int success;
 	unsigned int max = n;
 
+	/* Ensure the head is read before tail */
 	*old_head = rte_atomic_load_explicit(&d->head,
-			rte_memory_order_relaxed);
+			rte_memory_order_acquire);
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
 
-		/* Ensure the head is read before tail */
-		rte_atomic_thread_fence(rte_memory_order_acquire);
-
-		/* load-acquire synchronize with store-release of ht->tail
-		 * in update_tail.
+		/*
+		 * Read s->tail value. Note that it will be loaded after
+		 * d->head load, but before CAS operation for the d->head.
 		 */
 		stail = rte_atomic_load_explicit(&s->tail,
-					rte_memory_order_acquire);
+					rte_memory_order_relaxed);
 
 		/* The subtraction is done between two unsigned 32bits value
 		 * (the result is always modulo 32 bits even if we have
@@ -112,11 +111,19 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			d->head = *new_head;
 			success = 1;
 		} else
-			/* on failure, *old_head is updated */
+			/*
+			 * on failure, *old_head is updated.
+			 * this CAS(ACQ_REL, ACQUIRE) serves as a hoist
+			 * barrier to prevent:
+			 *  - OOO reads of cons tail value
+			 *  - OOO copy of elems from the ring
+			 *  Also RELEASE guarantees that latest tail value
+			 *  will become visible before the new head value.
+			 */
 			success = rte_atomic_compare_exchange_strong_explicit(
 					&d->head, old_head, *new_head,
-					rte_memory_order_relaxed,
-					rte_memory_order_relaxed);
+					rte_memory_order_acq_rel,
+					rte_memory_order_acquire);
 	} while (unlikely(success == 0));
 	return n;
 }
diff --git a/lib/ring/rte_ring_hts_elem_pvt.h b/lib/ring/rte_ring_hts_elem_pvt.h
index c59e5f6420..cc593433b9 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -116,13 +116,15 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 		np.pos.head = op.pos.head + n;
 
 	/*
-	 * this CAS(ACQUIRE, ACQUIRE) serves as a hoist barrier to prevent:
+	 * this CAS(ACQ_REL, ACQUIRE) serves as a hoist barrier to prevent:
 	 *  - OOO reads of cons tail value
 	 *  - OOO copy of elems from the ring
+	 *   Also RELEASE guarantees that latest tail value
+	 *   will become visible before the new head value.
 	 */
 	} while (rte_atomic_compare_exchange_strong_explicit(&d->ht.raw,
 			(uint64_t *)(uintptr_t)&op.raw, np.raw,
-			rte_memory_order_acquire,
+			rte_memory_order_acq_rel,
 			rte_memory_order_acquire) == 0);
 
 	*old_head = op.pos.head;
diff --git a/lib/ring/rte_ring_rts_elem_pvt.h b/lib/ring/rte_ring_rts_elem_pvt.h
index 509fa674fb..860b13cc61 100644
--- a/lib/ring/rte_ring_rts_elem_pvt.h
+++ b/lib/ring/rte_ring_rts_elem_pvt.h
@@ -131,13 +131,15 @@ __rte_ring_rts_move_head(struct rte_ring_rts_headtail *d,
 		nh.val.cnt = oh.val.cnt + 1;
 
 	/*
-	 * this CAS(ACQUIRE, ACQUIRE) serves as a hoist barrier to prevent:
+	 * this CAS(ACQ_REL, ACQUIRE) serves as a hoist barrier to prevent:
 	 *  - OOO reads of cons tail value
 	 *  - OOO copy of elems to the ring
+	 *  Also RELEASE guarantees that latest tail value
+	 *  will become visible before the new head value.
 	 */
 	} while (rte_atomic_compare_exchange_strong_explicit(&d->head.raw,
 			(uint64_t *)(uintptr_t)&oh.raw, nh.raw,
-			rte_memory_order_acquire,
+			rte_memory_order_acq_rel,
 			rte_memory_order_acquire) == 0);
 
 	*old_head = oh.val.pos;
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 7bcbf35516..21a1a27e24 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -123,8 +123,6 @@ __rte_soring_stage_finalize(struct soring_stage_headtail *sht, uint32_t stage,
 	rte_atomic_store_explicit(&sht->tail.raw, ot.raw,
 			rte_memory_order_release);
 
-	/* make sure that new tail value is visible */
-	rte_atomic_thread_fence(rte_memory_order_release);
 	return i;
 }
 
@@ -219,9 +217,6 @@ __rte_soring_update_tail(struct __rte_ring_headtail *rht,
 		/* unsupported mode, shouldn't be here */
 		RTE_ASSERT(0);
 	}
-
-	/* make sure that new tail value is visible */
-	rte_atomic_thread_fence(rte_memory_order_release);
 }
 
 static __rte_always_inline uint32_t
-- 
2.43.0

