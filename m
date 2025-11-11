Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E0ECCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B38740663;
	Tue, 11 Nov 2025 19:16:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F332240280;
 Tue, 11 Nov 2025 19:16:46 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B535E1515;
 Tue, 11 Nov 2025 10:16:38 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41D013F63F;
 Tue, 11 Nov 2025 10:16:46 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 stable@dpdk.org, Ola Liljedahl <ola.liljedahl@arm.com>
Subject: [PATCH v4 2/3] ring: establish a safe partial order in hts-ring
Date: Tue, 11 Nov 2025 18:16:38 +0000
Message-ID: <20251111181639.830527-2-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111181639.830527-1-wathsala.vithanage@arm.com>
References: <20251111181639.830527-1-wathsala.vithanage@arm.com>
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

Enforce a safe partial order by making the CAS and the preceding head
load use release and acquire semantics. This creates a pairwise
happens-before relationship between threads of the same role.

Combine the two load-acquire operations of ht.raw, which were previously
split across the two paths of a conditional branch, into
__rte_ring_hts_head_wait. This simplifies the branching logic and makes
the synchronization behavior easier to understand.

Add comments to explain synchronizes with edges in detail.

Fixes: 1cc363b8ce06e ("ring: introduce HTS ring mode")
Cc: stable@dpdk.org

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
---
 lib/ring/rte_ring_hts_elem_pvt.h | 66 ++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/lib/ring/rte_ring_hts_elem_pvt.h b/lib/ring/rte_ring_hts_elem_pvt.h
index e2b82dd1e6..a01089d15d 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -32,22 +32,40 @@ __rte_ring_hts_update_tail(struct rte_ring_hts_headtail *ht, uint32_t old_tail,
 	RTE_SET_USED(enqueue);
 
 	tail = old_tail + num;
+
+	/*
+	 * R0: Release the tail update. Establishes a synchronization edge with
+	 * the load-acquire at A1. This release ensures that all updates to *ht
+	 * and the ring array made by this thread become visible to the opposing
+	 * thread once the tail value written here is observed.
+	 */
 	rte_atomic_store_explicit(&ht->ht.pos.tail, tail, rte_memory_order_release);
 }
 
 /**
- * @internal waits till tail will become equal to head.
- * Means no writer/reader is active for that ring.
- * Suppose to work as serialization point.
+ * @internal
+ * Waits until the tail becomes equal to the head.
+ * This indicates that another thread has finished its transaction, and there
+ * is a chance that we could be the next writer or reader in line.
+ *
+ * Returns ht.raw at this point. The value may be imprecise, since another
+ * thread might change the state before we observe ht.raw, but that does not
+ * matter. The function __rte_ring_hts_move_head() can detect and recall this
+ * function when it reaches the linearization point (CAS).
  */
-static __rte_always_inline void
+static __rte_always_inline union __rte_ring_hts_pos
 __rte_ring_hts_head_wait(const struct rte_ring_hts_headtail *ht,
-		union __rte_ring_hts_pos *p)
+			 rte_memory_order memorder)
 {
-	while (p->pos.head != p->pos.tail) {
+	union __rte_ring_hts_pos p;
+	p.raw = rte_atomic_load_explicit(&ht->ht.raw, memorder);
+
+	while (p.pos.head != p.pos.tail) {
 		rte_pause();
-		p->raw = rte_atomic_load_explicit(&ht->ht.raw, rte_memory_order_acquire);
+		p.raw = rte_atomic_load_explicit(&ht->ht.raw, memorder);
 	}
+
+	return p;
 }
 
 /**
@@ -80,11 +98,9 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *entries)
 {
-	uint32_t n;
+	uint32_t n, stail;
 	union __rte_ring_hts_pos np, op;
 
-	op.raw = rte_atomic_load_explicit(&d->ht.raw, rte_memory_order_acquire);
-
 	do {
 		/* Reset n to the initial burst count */
 		n = num;
@@ -94,7 +110,20 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 		 * make sure that we read prod head/tail *before*
 		 * reading cons tail.
 		 */
-		__rte_ring_hts_head_wait(d, &op);
+		/*
+		 * A0: Synchronizes with the CAS at R1.
+		 * Establishes a happens-before relationship with a thread of the same
+		 * type that released the ht.raw, ensuring this thread observes all of
+		 * its memory effects needed to maintain a safe partial order.
+		 */
+		op = __rte_ring_hts_head_wait(d, rte_memory_order_acquire);
+
+		/*
+		 * A1: Establish a synchronizes-with edge using a store-release at R0.
+		 * This ensures that all memory effects from the preceding opposing
+		 * thread are observed.
+		 */
+		stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
@@ -102,7 +131,7 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 		 * *old_head > cons_tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = capacity + s->tail - op.pos.head;
+		*entries = capacity + stail - op.pos.head;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -116,14 +145,17 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 		np.pos.head = op.pos.head + n;
 
 	/*
-	 * this CAS(ACQUIRE, ACQUIRE) serves as a hoist barrier to prevent:
-	 *  - OOO reads of cons tail value
-	 *  - OOO copy of elems from the ring
+	 * R1: Establishes a synchronizes-with edge with the load-acquire
+	 * of ht.raw at A0. This makes sure that the store-release to the
+	 * tail by this thread, if it was of the opposite type, becomes
+	 * visible to another thread of the current type. That thread will
+	 * then observe the updates in the same order, keeping a safe
+	 * partial order.
 	 */
 	} while (rte_atomic_compare_exchange_strong_explicit(&d->ht.raw,
 			(uint64_t *)(uintptr_t)&op.raw, np.raw,
-			rte_memory_order_acquire,
-			rte_memory_order_acquire) == 0);
+			rte_memory_order_release,
+			rte_memory_order_relaxed) == 0);
 
 	*old_head = op.pos.head;
 	return n;
-- 
2.43.0

