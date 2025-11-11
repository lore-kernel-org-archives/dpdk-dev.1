Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57A7CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6C5440280;
	Tue, 11 Nov 2025 19:37:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id AED414026D;
 Tue, 11 Nov 2025 19:37:27 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA3D497;
 Tue, 11 Nov 2025 10:37:19 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2D0B3F63F;
 Tue, 11 Nov 2025 10:37:26 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ola Liljedahl <ola.liljedahl@arm.com>, Steve Capper <steve.capper@arm.com>,
 Gavin Hu <gahu@nvidia.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 stable@dpdk.org, Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: [PATCH v5 1/3] ring: safe partial ordering for head/tail update
Date: Tue, 11 Nov 2025 18:37:17 +0000
Message-ID: <20251111183720.833295-1-wathsala.vithanage@arm.com>
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

The function __rte_ring_headtail_move_head() assumes that the barrier
(fence) between the load of the head and the load-acquire of the
opposing tail guarantees the following: if a first thread reads tail
and then writes head and a second thread reads the new value of head
and then reads tail, then it should observe the same (or a later)
value of tail.

This assumption is incorrect under the C11 memory model. If the barrier
(fence) is intended to establish a total ordering of ring operations,
it fails to do so. Instead, the current implementation only enforces a
partial ordering, which can lead to unsafe interleavings. In particular,
some partial orders can cause underflows in free slot or available
element computations, potentially resulting in data corruption.

The issue manifests when a CPU first acts as a producer and later as a
consumer. In this scenario, the barrier assumption may fail when another
core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
this violation. The problem has not been widely observed so far because:
  (a) on strong memory models (e.g., x86-64) the assumption holds, and
  (b) on relaxed models with RCsc semantics the ordering is still strong
      enough to prevent hazards.
The problem becomes visible only on weaker models, when load-acquire is
implemented with RCpc semantics (e.g. some AArch64 CPUs which support
the LDAPR and LDAPUR instructions).

Three possible solutions exist:
  1. Strengthen ordering by upgrading release/acquire semantics to
     sequential consistency. This requires using seq-cst for stores,
     loads, and CAS operations. However, this approach introduces a
     significant performance penalty on relaxed-memory architectures.

  2. Establish a safe partial order by enforcing a pair-wise
     happens-before relationship between thread of same role by changing
     the CAS and the preceding load of the head by converting them to
     release and acquire respectively. This approach makes the original
     barrier assumption unnecessary and allows its removal.

  3. Retain partial ordering but ensure only safe partial orders are
     committed. This can be done by detecting underflow conditions
     (producer < consumer) and quashing the update in such cases.
     This approach makes the original barrier assumption unnecessary
     and allows its removal.

This patch implements solution (2) to preserve the “enqueue always
succeeds” contract expected by dependent libraries (e.g., mempool).
While solution (3) offers higher performance, adopting it now would
break that assumption.

Fixes: 49594a63147a9 ("ring/c11: relax ordering for load and store of the head")
Cc: stable@dpdk.org

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index b9388af0da..07b6efc416 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -36,6 +36,11 @@ __rte_ring_update_tail(struct rte_ring_headtail *ht, uint32_t old_val,
 		rte_wait_until_equal_32((uint32_t *)(uintptr_t)&ht->tail, old_val,
 			rte_memory_order_relaxed);
 
+	/*
+	 * R0: Establishes a synchronizing edge with load-acquire of tail at A1.
+	 * Ensures that memory effects by this thread on ring elements array
+	 * is observed by a different thread of the other type.
+	 */
 	rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_order_release);
 }
 
@@ -77,17 +82,24 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 	int success;
 	unsigned int max = n;
 
+	/*
+	 * A0: Establishes a synchronizing edge with R1.
+	 * Ensure that this thread observes same values
+	 * to stail observed by the thread that updated
+	 * d->head.
+	 * If not, an unsafe partial order may ensue.
+	 */
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
+		 * A1: Establishes a synchronizing edge with R0.
+		 * Ensures that other thread's memory effects on
+		 * ring elements array is observed by the time
+		 * this thread observes its tail update.
 		 */
 		stail = rte_atomic_load_explicit(&s->tail,
 					rte_memory_order_acquire);
@@ -113,10 +125,19 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			success = 1;
 		} else
 			/* on failure, *old_head is updated */
+			/*
+			 * R1/A2.
+			 * R1: Establishes a synchronizing edge with A0 of a
+			 * different thread.
+			 * A2: Establishes a synchronizing edge with R1 of a
+			 * different thread to observe same value for stail
+			 * observed by that thread on CAS failure (to retry
+			 * with an updated *old_head).
+			 */
 			success = rte_atomic_compare_exchange_strong_explicit(
 					&d->head, old_head, *new_head,
-					rte_memory_order_relaxed,
-					rte_memory_order_relaxed);
+					rte_memory_order_release,
+					rte_memory_order_acquire);
 	} while (unlikely(success == 0));
 	return n;
 }
-- 
2.43.0

