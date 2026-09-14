Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B1C88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 15:59:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B5040E64;
	Mon, 14 Sep 2026 17:59:15 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 62B8140E2F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 17:59:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4396620750;
 Mon, 14 Sep 2026 17:59:13 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 14 Sep 2026 17:59:12 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v7 2/2] mempool: introduce pile driver
Date: Mon, 14 Sep 2026 15:59:01 +0000
Message-ID: <20260914155901.943571-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914155901.943571-1-mb@smartsharesystems.com>
References: <20260901064331.594276-1-mb@smartsharesystems.com>
 <20260914155901.943571-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Sep 2026 15:59:12.0162 (UTC)
 FILETIME=[FC040020:01DD4461]
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

Added a new "pile" mempool driver, based on the high-performance lock-free
"pile" stack variant.
With this driver added, the max number of mempool drivers
(RTE_MEMPOOL_MAX_OPS_IDX) would be exceeded, so it was increased from 16
to 32.

Changed the other stack drivers to call their specific push/pop functions,
instead of calling the generic stack push/pop API.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v7:
* Actually moved increase of max number of mempool drivers from
  stack patch to mempool driver patch, where it belongs.
v6:
* No changes.
v5:
* Added release note. (AI advanced model)
* Moved increase of max number of mempool drivers from stack patch to
  mempool driver patch, where it belongs.
* Mentioned increase of max number of mempool drivers in patch
  description.
* Removed the rte_mempool_register_ops() and rte_mempool_set_ops_byname()
  changes.
  They are included in the "mempool: various cleanups" patch in the
  "mempool: cleanup, fixes, improvements and optimizations" series.
v4:
* No changes.
v3:
* Call other stack types' specific push/pop functions.
v2:
* There is no v2.
---
 doc/guides/mempool/stack.rst              | 12 ++-
 doc/guides/rel_notes/release_26_11.rst    |  1 +
 drivers/mempool/stack/rte_mempool_stack.c | 90 ++++++++++++++++++++---
 lib/mempool/rte_mempool.h                 |  2 +-
 4 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/doc/guides/mempool/stack.rst b/doc/guides/mempool/stack.rst
index 80ea07e65d..c06ab2dc56 100644
--- a/doc/guides/mempool/stack.rst
+++ b/doc/guides/mempool/stack.rst
@@ -1,5 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2020 Intel Corporation.
+    Copyright(c) 2026 SmartShare Systems.
 
 Stack Mempool Driver
 ====================
@@ -28,6 +29,12 @@ can be selected as described in :ref:`Mempool_Handlers`:
   The underlying **rte_stack** operates in lock-free mode. For more
   information please refer to :ref:`Stack_Library_LF_Stack`.
 
+- ``pile``
+
+  The underlying **rte_stack** operates in lock-free mode,
+  and is optimized for bulks of objects.
+  For more information please refer to :ref:`Stack_Library_Pile`.
+
 The standard stack outperforms the lock-free stack on average, however the
 standard stack is non-preemptive: if a mempool user is preempted while holding
 the stack lock, that thread will block all other mempool accesses until it
@@ -35,9 +42,12 @@ returns and releases the lock. As a result, an application using the standard
 stack whose threads can be preempted can suffer from brief, infrequent
 performance hiccups.
 
-The lock-free stack, by design, is not susceptible to this problem; one thread can
+The lock-free stack and the pile, by design, are not susceptible to this problem; one thread can
 be preempted at any point during a push or pop operation and will not impede
 the progress of any other thread.
 
+The pile is not LIFO per object, but per bulk of objects.
+Although the pile is optimized for bulks of objects, it can handle any request size.
+
 For a more detailed description of the stack implementations, please refer to
 :doc:`/prog_guide/stack_lib`.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 572e579ed5..17a1219222 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -61,6 +61,7 @@ New Features
   pushed and popped in LIFO manner, but objects within each bulk are not ordered
   as expected by a stack.
   Furthermore, it is not strictly bounded by its size, but might hold more objects.
+* mempool: Added "pile" driver, using the lock-free "pile" stack-like implementation.
 
 Removed Items
 -------------
diff --git a/drivers/mempool/stack/rte_mempool_stack.c b/drivers/mempool/stack/rte_mempool_stack.c
index 1476905227..11c1243bec 100644
--- a/drivers/mempool/stack/rte_mempool_stack.c
+++ b/drivers/mempool/stack/rte_mempool_stack.c
@@ -30,7 +30,7 @@ __stack_alloc(struct rte_mempool *mp, uint32_t flags)
 }
 
 static int
-stack_alloc(struct rte_mempool *mp)
+std_stack_alloc(struct rte_mempool *mp)
 {
 	return __stack_alloc(mp, 0);
 }
@@ -42,21 +42,81 @@ lf_stack_alloc(struct rte_mempool *mp)
 }
 
 static int
-stack_enqueue(struct rte_mempool *mp, void * const *obj_table,
+pile_alloc(struct rte_mempool *mp)
+{
+	return __stack_alloc(mp, RTE_STACK_F_PILE);
+}
+
+static int
+std_stack_enqueue(struct rte_mempool *mp, void * const *obj_table,
+	      unsigned int n)
+{
+	struct rte_stack *s = mp->pool_data;
+
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_std_push(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+}
+
+static int
+std_stack_dequeue(struct rte_mempool *mp, void **obj_table,
+	      unsigned int n)
+{
+	struct rte_stack *s = mp->pool_data;
+
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_std_pop(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+}
+
+static int
+lf_stack_enqueue(struct rte_mempool *mp, void * const *obj_table,
+	      unsigned int n)
+{
+	struct rte_stack *s = mp->pool_data;
+
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_lf_push(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+}
+
+static int
+lf_stack_dequeue(struct rte_mempool *mp, void **obj_table,
 	      unsigned int n)
 {
 	struct rte_stack *s = mp->pool_data;
 
-	return rte_stack_push(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_lf_pop(s, obj_table, n) == 0 ? -ENOBUFS : 0;
 }
 
 static int
-stack_dequeue(struct rte_mempool *mp, void **obj_table,
+pile_enqueue(struct rte_mempool *mp, void * const *obj_table,
 	      unsigned int n)
 {
 	struct rte_stack *s = mp->pool_data;
 
-	return rte_stack_pop(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_pile_push(s, obj_table, n) == 0 ? -ENOBUFS : 0;
+}
+
+static int
+pile_dequeue(struct rte_mempool *mp, void **obj_table,
+	      unsigned int n)
+{
+	struct rte_stack *s = mp->pool_data;
+
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	return __rte_stack_pile_pop(s, obj_table, n) == 0 ? -ENOBUFS : 0;
 }
 
 static unsigned
@@ -77,10 +137,10 @@ stack_free(struct rte_mempool *mp)
 
 static struct rte_mempool_ops ops_stack = {
 	.name = "stack",
-	.alloc = stack_alloc,
+	.alloc = std_stack_alloc,
 	.free = stack_free,
-	.enqueue = stack_enqueue,
-	.dequeue = stack_dequeue,
+	.enqueue = std_stack_enqueue,
+	.dequeue = std_stack_dequeue,
 	.get_count = stack_get_count
 };
 
@@ -88,10 +148,20 @@ static struct rte_mempool_ops ops_lf_stack = {
 	.name = "lf_stack",
 	.alloc = lf_stack_alloc,
 	.free = stack_free,
-	.enqueue = stack_enqueue,
-	.dequeue = stack_dequeue,
+	.enqueue = lf_stack_enqueue,
+	.dequeue = lf_stack_dequeue,
+	.get_count = stack_get_count
+};
+
+static struct rte_mempool_ops ops_pile = {
+	.name = "pile",
+	.alloc = pile_alloc,
+	.free = stack_free,
+	.enqueue = pile_enqueue,
+	.dequeue = pile_dequeue,
 	.get_count = stack_get_count
 };
 
 RTE_MEMPOOL_REGISTER_OPS(ops_stack);
 RTE_MEMPOOL_REGISTER_OPS(ops_lf_stack);
+RTE_MEMPOOL_REGISTER_OPS(ops_pile);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..3e161bfdb9 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -718,7 +718,7 @@ struct __rte_cache_aligned rte_mempool_ops {
 	rte_mempool_dequeue_contig_blocks_t dequeue_contig_blocks;
 };
 
-#define RTE_MEMPOOL_MAX_OPS_IDX 16  /**< Max registered ops structs */
+#define RTE_MEMPOOL_MAX_OPS_IDX 32  /**< Max registered ops structs */
 
 /**
  * Structure storing the table of registered ops structs, each of which contain
-- 
2.43.0

