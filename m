Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91751CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8E5D4067B;
	Tue, 11 Nov 2025 19:16:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7CF1B4026D;
 Tue, 11 Nov 2025 19:16:47 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F2C1655;
 Tue, 11 Nov 2025 10:16:39 -0800 (PST)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F20E3F63F;
 Tue, 11 Nov 2025 10:16:46 -0800 (PST)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 stable@dpdk.org, Ola Liljedahl <ola.liljedahl@arm.com>
Subject: [PATCH v4 3/3] ring: establish a safe partial order in rts-ring
Date: Tue, 11 Nov 2025 18:16:39 +0000
Message-ID: <20251111181639.830527-3-wathsala.vithanage@arm.com>
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
happens-before relationship between threads of the same kind
(i.e. between consumers or between producers).

Combine the two load-acquire operations of ht->head.raw, which were
previously split across the two paths of a conditional branch, into
__rte_ring_rts_head_wait. This simplifies the branching logic and makes
the synchronization behavior easier to understand.

Add comments to explain synchronizes with edges in detail.

Fixes: e6ba4731c0f3a ("ring: introduce RTS ring mode")
Cc: stable@dpdk.org

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
---
 lib/ring/rte_ring_rts_elem_pvt.h | 67 +++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/lib/ring/rte_ring_rts_elem_pvt.h b/lib/ring/rte_ring_rts_elem_pvt.h
index 96825931f8..0280369b21 100644
--- a/lib/ring/rte_ring_rts_elem_pvt.h
+++ b/lib/ring/rte_ring_rts_elem_pvt.h
@@ -31,6 +31,17 @@ __rte_ring_rts_update_tail(struct rte_ring_rts_headtail *ht)
 	 * might preceded us, then don't update tail with new value.
 	 */
 
+	/*
+	 * A0 = {A0.a, A0.b}: Synchronizes with the CAS at R0.
+	 * The CAS at R0 in same typed thread establishes a happens-before
+	 * relationship with this load acquire. Ensures that this thread
+	 * observes the same or later values for h.raw/h.val.cnt
+	 * observed by the other thread when it updated ht->tail.raw.
+	 * If not, ht->tail.raw may get updated out of sync (e.g. getting
+	 * updated to the same value twice). A0.a makes sure this condition
+	 * holds when CAS succeeds and A0.b when it fails.
+	 */
+	/* A0.a */
 	ot.raw = rte_atomic_load_explicit(&ht->tail.raw, rte_memory_order_acquire);
 
 	do {
@@ -40,7 +51,11 @@ __rte_ring_rts_update_tail(struct rte_ring_rts_headtail *ht)
 		nt.raw = ot.raw;
 		if (++nt.val.cnt == h.val.cnt)
 			nt.val.pos = h.val.pos;
-
+	/*
+	 * R0: Synchronizes with A2 of a different thread of the opposite type and A0.b
+	 * of a different thread of the same type.
+	 */
+	/* A0.b */
 	} while (rte_atomic_compare_exchange_strong_explicit(&ht->tail.raw,
 			(uint64_t *)(uintptr_t)&ot.raw, nt.raw,
 			rte_memory_order_release, rte_memory_order_acquire) == 0);
@@ -50,18 +65,21 @@ __rte_ring_rts_update_tail(struct rte_ring_rts_headtail *ht)
  * @internal This function waits till head/tail distance wouldn't
  * exceed pre-defined max value.
  */
-static __rte_always_inline void
+static __rte_always_inline union __rte_ring_rts_poscnt
 __rte_ring_rts_head_wait(const struct rte_ring_rts_headtail *ht,
-	union __rte_ring_rts_poscnt *h)
+			 rte_memory_order memorder)
 {
-	uint32_t max;
+	union __rte_ring_rts_poscnt h;
+	uint32_t max = ht->htd_max;
 
-	max = ht->htd_max;
+	h.raw = rte_atomic_load_explicit(&ht->head.raw, memorder);
 
-	while (h->val.pos - ht->tail.val.pos > max) {
+	while (h.val.pos - ht->tail.val.pos > max) {
 		rte_pause();
-		h->raw = rte_atomic_load_explicit(&ht->head.raw, rte_memory_order_acquire);
+		h.raw = rte_atomic_load_explicit(&ht->head.raw, memorder);
 	}
+
+	return h;
 }
 
 /**
@@ -94,12 +112,9 @@ __rte_ring_rts_move_head(struct rte_ring_rts_headtail *d,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *entries)
 {
-	uint32_t n;
+	uint32_t n, stail;
 	union __rte_ring_rts_poscnt nh, oh;
 
-	oh.raw = rte_atomic_load_explicit(&d->head.raw,
-			rte_memory_order_acquire);
-
 	do {
 		/* Reset n to the initial burst count */
 		n = num;
@@ -109,7 +124,20 @@ __rte_ring_rts_move_head(struct rte_ring_rts_headtail *d,
 		 * make sure that we read prod head *before*
 		 * reading cons tail.
 		 */
-		__rte_ring_rts_head_wait(d, &oh);
+		/*
+		 * A1 Synchronizes with the CAS at R1.
+		 * Establishes a happens-before relationship with a thread of the same
+		 * type that released the ht.raw, ensuring this thread observes all of
+		 * its memory effects needed to maintain a safe partial order.
+		 */
+		oh = __rte_ring_rts_head_wait(d, rte_memory_order_acquire);
+
+		/*
+		 * A2: Establish a synchronizes-with edge using a store-release at R0.
+		 * This ensures that all memory effects from the preceding opposing
+		 * thread are observed.
+		 */
+		stail = rte_atomic_load_explicit(&s->tail, rte_memory_order_acquire);
 
 		/*
 		 *  The subtraction is done between two unsigned 32bits value
@@ -117,7 +145,7 @@ __rte_ring_rts_move_head(struct rte_ring_rts_headtail *d,
 		 * *old_head > cons_tail). So 'entries' is always between 0
 		 * and capacity (which is < size).
 		 */
-		*entries = capacity + s->tail - oh.val.pos;
+		*entries = capacity + stail - oh.val.pos;
 
 		/* check that we have enough room in ring */
 		if (unlikely(n > *entries))
@@ -131,14 +159,17 @@ __rte_ring_rts_move_head(struct rte_ring_rts_headtail *d,
 		nh.val.cnt = oh.val.cnt + 1;
 
 	/*
-	 * this CAS(ACQUIRE, ACQUIRE) serves as a hoist barrier to prevent:
-	 *  - OOO reads of cons tail value
-	 *  - OOO copy of elems to the ring
+	 * R1: Establishes a synchronizes-with edge with the load-acquire
+	 * of ht.raw at A1. Ensures that the store-release to the tail by
+	 * this thread, if it was of the opposite type, becomes
+	 * visible to another thread of the current type. That thread will
+	 * then observe the updates in the same order, keeping a safe
+	 * partial order.
 	 */
 	} while (rte_atomic_compare_exchange_strong_explicit(&d->head.raw,
 			(uint64_t *)(uintptr_t)&oh.raw, nh.raw,
-			rte_memory_order_acquire,
-			rte_memory_order_acquire) == 0);
+			rte_memory_order_release,
+			rte_memory_order_relaxed) == 0);
 
 	*old_head = oh.val.pos;
 	return n;
-- 
2.43.0

