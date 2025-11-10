Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C5CCFA1E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 10:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6DE4064C;
	Mon, 10 Nov 2025 11:17:58 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 89659400D6;
 Mon, 10 Nov 2025 11:17:56 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4lwN3XBdzHnHL2;
 Mon, 10 Nov 2025 18:17:40 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 6C6ED1402FF;
 Mon, 10 Nov 2025 18:17:55 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 10:17:54 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>, <honnappa.nagarahalli@arm.com>,
 <ola.liljedahl@arm.com>, <dhruv.tripathi@arm.com>,
 <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: [PATCH v3 1/1] ring: fix unsafe ordering for head/tail update
Date: Mon, 10 Nov 2025 10:17:17 +0000
Message-ID: <20251110101717.233685-2-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110101717.233685-1-konstantin.ananyev@huawei.com>
References: <20251002174137.3612042-1-wathsala.vithanage@arm.com>
 <20251110101717.233685-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100006.china.huawei.com (7.182.19.111) To
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

From: Wathsala Vithanage <wathsala.vithanage@arm.com>

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

Fixes: b5458e2cc483 ("ring: introduce staged ordered ring")
Fixes: 1cc363b8ce06 ("ring: introduce HTS ring mode")
Fixes: e6ba4731c0f3 ("ring: introduce RTS ring mode")
Fixes: 49594a63147a ("ring/c11: relax ordering for load and store of the head")
Cc: stable@dpdk.org

Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h      | 9 +++------
 lib/ring/rte_ring_hts_elem_pvt.h | 6 ++++--
 lib/ring/rte_ring_rts_elem_pvt.h | 6 ++++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index b9388af0da..98c6584edb 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -78,14 +78,11 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 	unsigned int max = n;
 
 	*old_head = rte_atomic_load_explicit(&d->head,
-			rte_memory_order_relaxed);
+			rte_memory_order_acquire);
 	do {
 		/* Reset n to the initial burst count */
 		n = max;
 
-		/* Ensure the head is read before tail */
-		rte_atomic_thread_fence(rte_memory_order_acquire);
-
 		/* load-acquire synchronize with store-release of ht->tail
 		 * in update_tail.
 		 */
@@ -115,8 +112,8 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			/* on failure, *old_head is updated */
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
index e2b82dd1e6..1c1569e7e2 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -116,13 +116,15 @@ __rte_ring_hts_move_head(struct rte_ring_hts_headtail *d,
 		np.pos.head = op.pos.head + n;
 
 	/*
-	 * this CAS(ACQUIRE, ACQUIRE) serves as a hoist barrier to prevent:
+	 * this CAS(ACQ_REL, ACQUIRE) serves as a hoist barrier to prevent:
 	 *  - OOO reads of cons tail value
 	 *  - OOO copy of elems from the ring
+	 *  Also RELEASE guarantees that latest tail value
+	 *  will become visible before the new head value.
 	 */
 	} while (rte_atomic_compare_exchange_strong_explicit(&d->ht.raw,
 			(uint64_t *)(uintptr_t)&op.raw, np.raw,
-			rte_memory_order_acquire,
+			rte_memory_order_acq_rel,
 			rte_memory_order_acquire) == 0);
 
 	*old_head = op.pos.head;
diff --git a/lib/ring/rte_ring_rts_elem_pvt.h b/lib/ring/rte_ring_rts_elem_pvt.h
index 96825931f8..b270998683 100644
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
-- 
2.51.0

