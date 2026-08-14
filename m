Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE4C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 03:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9B604013F;
	Fri, 14 Aug 2026 05:04:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 211A6400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 05:04:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DAEA5206DF;
 Fri, 14 Aug 2026 05:04:23 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 14 Aug 2026 05:04:23 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mempool: introduce pile driver
Date: Fri, 14 Aug 2026 03:04:20 +0000
Message-ID: <20260814030421.27430-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2026 03:04:23.0585 (UTC)
 FILETIME=[9BDBD910:01DD2B99]
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

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
Depends-on: series-38942 ("stack: introduce pile")
---
 doc/guides/mempool/stack.rst              | 12 ++++++-
 drivers/mempool/stack/rte_mempool_stack.c | 40 +++++++++++++++++++++++
 lib/mempool/rte_mempool.h                 |  2 ++
 lib/mempool/rte_mempool_ops.c             | 27 +++++++++++----
 4 files changed, 74 insertions(+), 7 deletions(-)

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
diff --git a/drivers/mempool/stack/rte_mempool_stack.c b/drivers/mempool/stack/rte_mempool_stack.c
index 1476905227..7467b8b39e 100644
--- a/drivers/mempool/stack/rte_mempool_stack.c
+++ b/drivers/mempool/stack/rte_mempool_stack.c
@@ -41,6 +41,36 @@ lf_stack_alloc(struct rte_mempool *mp)
 	return __stack_alloc(mp, RTE_STACK_F_LF);
 }
 
+static int
+pile_alloc(struct rte_mempool *mp)
+{
+	return __stack_alloc(mp, RTE_STACK_F_PILE);
+}
+
+static int
+pile_enqueue(struct rte_mempool *mp, void * const *obj_table,
+	      unsigned int n)
+{
+	struct rte_stack *s = mp->pool_data;
+
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
+}
+
 static int
 stack_enqueue(struct rte_mempool *mp, void * const *obj_table,
 	      unsigned int n)
@@ -93,5 +123,15 @@ static struct rte_mempool_ops ops_lf_stack = {
 	.get_count = stack_get_count
 };
 
+static struct rte_mempool_ops ops_pile = {
+	.name = "pile",
+	.alloc = pile_alloc,
+	.free = stack_free,
+	.enqueue = pile_enqueue,
+	.dequeue = pile_dequeue,
+	.get_count = stack_get_count
+};
+
 RTE_MEMPOOL_REGISTER_OPS(ops_stack);
 RTE_MEMPOOL_REGISTER_OPS(ops_lf_stack);
+RTE_MEMPOOL_REGISTER_OPS(ops_pile);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 3e161bfdb9..db7def9096 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -979,6 +979,8 @@ rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
  *   - >=0: Success; return the index of the ops struct in the table.
  *   - -EINVAL - some missing callbacks while registering ops struct.
  *   - -ENOSPC - the maximum number of ops structs has been reached.
+ *   - -ENAMETOOLONG - the name of the ops is too long.
+ *   - -EEXIST - the name of the ops is already registered.
  */
 int rte_mempool_register_ops(const struct rte_mempool_ops *ops);
 
diff --git a/lib/mempool/rte_mempool_ops.c b/lib/mempool/rte_mempool_ops.c
index 066bec36fc..261ad217ee 100644
--- a/lib/mempool/rte_mempool_ops.c
+++ b/lib/mempool/rte_mempool_ops.c
@@ -27,7 +27,7 @@ int
 rte_mempool_register_ops(const struct rte_mempool_ops *h)
 {
 	struct rte_mempool_ops *ops;
-	int16_t ops_index;
+	unsigned int ops_index;
 
 	rte_spinlock_lock(&rte_mempool_ops_table.sl);
 
@@ -47,12 +47,21 @@ rte_mempool_register_ops(const struct rte_mempool_ops *h)
 		return -EINVAL;
 	}
 
-	if (strlen(h->name) >= sizeof(ops->name) - 1) {
+	if (strlen(h->name) > sizeof(ops->name) - 1) {
 		rte_spinlock_unlock(&rte_mempool_ops_table.sl);
-		RTE_MEMPOOL_LOG(DEBUG, "%s(): mempool_ops <%s>: name too long",
+		RTE_MEMPOOL_LOG(ERR, "%s(): mempool_ops <%s>: name too long",
 				__func__, h->name);
-		rte_errno = EEXIST;
-		return -EEXIST;
+		return -ENAMETOOLONG;
+	}
+
+	for (ops_index = 0; ops_index < rte_mempool_ops_table.num_ops; ops_index++) {
+		if (!strcmp(h->name,
+				rte_mempool_ops_table.ops[ops_index].name)) {
+			rte_spinlock_unlock(&rte_mempool_ops_table.sl);
+			RTE_MEMPOOL_LOG(ERR, "%s(): mempool_ops <%s>: name exists",
+					__func__, h->name);
+			return -EEXIST;
+		}
 	}
 
 	ops_index = rte_mempool_ops_table.num_ops++;
@@ -68,6 +77,9 @@ rte_mempool_register_ops(const struct rte_mempool_ops *h)
 	ops->get_info = h->get_info;
 	ops->dequeue_contig_blocks = h->dequeue_contig_blocks;
 
+	RTE_MEMPOOL_LOG(DEBUG,
+		"Registered mempool_ops[%u] <%s>", ops_index, h->name);
+
 	rte_spinlock_unlock(&rte_mempool_ops_table.sl);
 
 	return ops_index;
@@ -185,8 +197,11 @@ rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
 		}
 	}
 
-	if (ops == NULL)
+	if (ops == NULL) {
+		RTE_MEMPOOL_LOG(ERR,
+			"Unknown mempool_ops <%s>, of %u ops registered", name, i);
 		return -EINVAL;
+	}
 
 	mp->ops_index = i;
 	mp->pool_config = pool_config;
-- 
2.43.0

