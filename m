Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4330ECCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 17:39:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44A4640280;
	Tue, 11 Nov 2025 18:39:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 391614026D;
 Tue, 11 Nov 2025 18:39:00 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8413497;
 Tue, 11 Nov 2025 09:38:51 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 574273F5A1;
 Tue, 11 Nov 2025 09:38:59 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Steve Capper <steve.capper@arm.com>, Gavin Hu <gahu@nvidia.com>,
 Phil Yang <phil.yang@arm.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 stable@dpdk.org, Ola Liljedahl <ola.liljedahl@arm.com>
Subject: [PATCH v2 1/1] eal: correct memory ordering in MCS lock
Date: Tue, 11 Nov 2025 17:38:50 +0000
Message-ID: <20251111173850.790254-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix incorrect memory ordering in the MCS lock implementation by
adding proper synchronizing edges to establish clear happens-before
relationships between threads invoking lock() and unlock(). These
synchronizing edges prevent potential deadlocks caused by improper
ordering and are documented in detail through in-code comments.

The previously relaxed load of the successor’s lock object pointer
in unlock() has been upgraded to a load-acquire operation. This
change ensures that the successor’s initialization does not
overwrite the current lock holder’s update to the locked field,
which could otherwise lead to deadlocks.

Remove two unnecessary fences:

The acquire fence in unlock() had no matching release fence, making
it ineffective for enforcing memory order. The associated comment
suggested it prevented speculative reordering, but such fences (data
memory barriers) only establish memory ordering and do not control
instruction speculation.

The release-acquire fence pair in lock() was previously justified as
preventing reordering between the load-acquire loop of me->locked
and the store-release of prev->next. This is no longer needed, as the
new synchronizing edges ensure a chain of happens-before
relationships between memory operations of threads calling lock() and
unlock().

Fixes: 2173f3333b61d ("mcslock: add MCS queued lock implementation")
Cc: stable@dpdk.org

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Reviewed-by: Ola Liljedahl <ola.liljedahl@arm.com>
---
 lib/eal/include/rte_mcslock.h | 100 ++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 36 deletions(-)

diff --git a/lib/eal/include/rte_mcslock.h b/lib/eal/include/rte_mcslock.h
index bb218d2e50..0af7a94a06 100644
--- a/lib/eal/include/rte_mcslock.h
+++ b/lib/eal/include/rte_mcslock.h
@@ -57,11 +57,21 @@ rte_mcslock_lock(RTE_ATOMIC(rte_mcslock_t *) *msl, rte_mcslock_t *me)
 	rte_atomic_store_explicit(&me->locked, 1, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&me->next, NULL, rte_memory_order_relaxed);
 
-	/* If the queue is empty, the exchange operation is enough to acquire
-	 * the lock. Hence, the exchange operation requires acquire semantics.
-	 * The store to me->next above should complete before the node is
-	 * visible to other CPUs/threads. Hence, the exchange operation requires
-	 * release semantics as well.
+	/*
+	 * A0/R0: Queue might be empty, perform the exchange (RMW) with both acquire and
+	 * release semantics:
+	 * A0: Acquire — synchronizes with both R0 and R2.
+	 *     Must synchronize with R0 to ensure that this thread observes predecessor's
+	 *     initialization of its lock object or risk them overwriting this thread's
+	 *     update to the next of the same object via store to prev->next.
+	 *
+	 *     Must synchronize with R2 the releasing CAS in unlock(), this will ensure
+	 *     that all prior critical-section writes become visible to this thread.
+	 *
+	 * R0: Release — ensures the successor observes our initialization of me->next;
+	 *     without it, me->next could be overwritten to NULL after the successor
+	 *     sets its own address, causing deadlock. This release synchronizes with
+	 *     A0 above.
 	 */
 	prev = rte_atomic_exchange_explicit(msl, me, rte_memory_order_acq_rel);
 	if (likely(prev == NULL)) {
@@ -70,24 +80,26 @@ rte_mcslock_lock(RTE_ATOMIC(rte_mcslock_t *) *msl, rte_mcslock_t *me)
 		 */
 		return;
 	}
-	/* The store to me->next above should also complete before the node is
-	 * visible to predecessor thread releasing the lock. Hence, the store
-	 * prev->next also requires release semantics. Note that, for example,
-	 * on ARM, the release semantics in the exchange operation is not
-	 * strong as a release fence and is not sufficient to enforce the
-	 * desired order here.
+
+	/*
+	 * R1: With the relaxed memory model of C/C++, it's essential that after
+	 * we link ourselves by storing prev->next = me, the owner of prev must
+	 * observe our prior initialization of me->locked. Otherwise it could
+	 * clear me->locked before we set it to 1, which may deadlock.
+	 * Perform a releasing store so the predecessor's acquire loads A2 and A3
+	 * observes our initialization, establishing a happens-before from those
+	 * writes.
 	 */
 	rte_atomic_store_explicit(&prev->next, me, rte_memory_order_release);
 
-	/* The while-load of me->locked should not move above the previous
-	 * store to prev->next. Otherwise it will cause a deadlock. Need a
-	 * store-load barrier.
-	 */
-	rte_atomic_thread_fence(rte_memory_order_acq_rel);
-	/* If the lock has already been acquired, it first atomically
+	/*
+	 * A1: If the lock has already been acquired, it first atomically
 	 * places the node at the end of the queue and then proceeds
 	 * to spin on me->locked until the previous lock holder resets
-	 * the me->locked using mcslock_unlock().
+	 * the me->locked in rte_mcslock_unlock().
+	 * This load must synchronize with store-release R3 to ensure that
+	 * all updates to critical section by previous lock holder is visible
+	 * to this thread after acquiring the lock.
 	 */
 	rte_wait_until_equal_32((uint32_t *)(uintptr_t)&me->locked, 0, rte_memory_order_acquire);
 }
@@ -103,30 +115,46 @@ rte_mcslock_lock(RTE_ATOMIC(rte_mcslock_t *) *msl, rte_mcslock_t *me)
 static inline void
 rte_mcslock_unlock(RTE_ATOMIC(rte_mcslock_t *) *msl, RTE_ATOMIC(rte_mcslock_t *) me)
 {
-	/* Check if there are more nodes in the queue. */
-	if (likely(rte_atomic_load_explicit(&me->next, rte_memory_order_relaxed) == NULL)) {
+	/*
+	 * A2: Check whether a successor is already queued.
+	 * Load me->next with acquire semantics so it can synchronize with the
+	 * successor’s release store R1. This guarantees that the successor’s
+	 * initialization of its lock object (me) is completed before we observe
+	 * it here, preventing a race between this thread’s store-release to
+	 * me->next->locked and the successor’s store to me->locked.
+	 */
+	if (likely(rte_atomic_load_explicit(&me->next, rte_memory_order_acquire) == NULL)) {
 		/* No, last member in the queue. */
-		rte_mcslock_t *save_me = rte_atomic_load_explicit(&me, rte_memory_order_relaxed);
+		rte_mcslock_t *save_me = me;
 
-		/* Release the lock by setting it to NULL */
+		/*
+		 * R2: Try to release the lock by swinging *msl from save_me to NULL.
+		 * Use release semantics so all critical section writes become
+		 * visible to the next lock acquirer.
+		 */
 		if (likely(rte_atomic_compare_exchange_strong_explicit(msl, &save_me, NULL,
 				rte_memory_order_release, rte_memory_order_relaxed)))
 			return;
 
-		/* Speculative execution would be allowed to read in the
-		 * while-loop first. This has the potential to cause a
-		 * deadlock. Need a load barrier.
-		 */
-		rte_atomic_thread_fence(rte_memory_order_acquire);
-		/* More nodes added to the queue by other CPUs.
-		 * Wait until the next pointer is set.
+		/*
+		 * A3: Another thread was enqueued concurrently, so the CAS and the lock
+		 * release failed. Wait until the successor sets our 'next' pointer.
+		 * This load must synchronize with the successor’s release store (R1) to
+		 * ensure that the successor’s initialization completes before we observe
+		 * it here. This ordering prevents a race between this thread’s later
+		 * store-release to me->next->locked and the successor’s store to me->locked.
 		 */
 		RTE_ATOMIC(uintptr_t) *next;
 		next = (__rte_atomic uintptr_t *)&me->next;
-		RTE_WAIT_UNTIL_MASKED(next, UINTPTR_MAX, !=, 0, rte_memory_order_relaxed);
+		RTE_WAIT_UNTIL_MASKED(next, UINTPTR_MAX, !=, 0, rte_memory_order_acquire);
 	}
 
-	/* Pass lock to next waiter. */
+	/*
+	 * R3: Pass the lock to the successor.
+	 * Use a release store to synchronize with A1 when clearing me->next->locked
+	 * so the successor observes our critical section writes after it sees locked
+	 * become 0.
+	 */
 	rte_atomic_store_explicit(&me->next->locked, 0, rte_memory_order_release);
 }
 
@@ -149,11 +177,11 @@ rte_mcslock_trylock(RTE_ATOMIC(rte_mcslock_t *) *msl, rte_mcslock_t *me)
 	/* Try to lock */
 	rte_mcslock_t *expected = NULL;
 
-	/* The lock can be taken only when the queue is empty. Hence,
-	 * the compare-exchange operation requires acquire semantics.
-	 * The store to me->next above should complete before the node
-	 * is visible to other CPUs/threads. Hence, the compare-exchange
-	 * operation requires release semantics as well.
+	/*
+	 * A4/R4: The lock can be acquired only when the queue is empty.
+	 * The compare-and-exchange operation must use acquire and release
+	 * semantics for the same reasons described in the rte_mcslock_lock()
+	 * function’s empty-queue case (see A0/R0 for details).
 	 */
 	return rte_atomic_compare_exchange_strong_explicit(msl, &expected, me,
 			rte_memory_order_acq_rel, rte_memory_order_relaxed);
-- 
2.43.0

