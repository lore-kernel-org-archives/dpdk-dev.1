Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5433AC55172
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 10:17:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95D2A402BB;
	Sat,  1 Aug 2026 12:09:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 32EE240299
 for <dev@dpdk.org>; Sat,  1 Aug 2026 12:09:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D493B207AB
 for <dev@dpdk.org>; Sat,  1 Aug 2026 12:09:26 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 1 Aug 2026 12:09:26 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH v2] NEW: pile stack and mempool driver
Date: Sat,  1 Aug 2026 10:09:19 +0000
Message-ID: <20260801100919.981700-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Aug 2026 10:09:26.0539 (UTC)
 FILETIME=[D56F0DB0:01DD219D]
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

Early submission of:
- some mempool optimizations,
- a new mempool "pile" driver, and
- its underlying "pile" stack implementation.

For community feedback and CI test.

Needless to say, this must be separated into a series of patches.
For now, I'm submitting a snapshot of work in progress.

Some performance numbers from mempool_perf_autotest_2cores, all
with cache=1024 cores=2 n_keep=32768:

start performance test (using ring_mp_mc, with cache)
n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec= 753985338
n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec= 755805913

start performance test for lf_stack (with cache)
n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec=  29132352
n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec=  29276708

start performance test for pile (with cache)
n_get_bulk= 64 n_put_bulk= 64 constant_n=0 rate_persec= 560159479
n_get_bulk=256 n_put_bulk=256 constant_n=0 rate_persec= 557910933

Hat tip to Bruce for bringing attention to the ring not being the
optimal mempool driver.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Fix indentation, long lines, etc. (checkpatch)
* Fix label followed by a declaration is a C23 extension.
* Added __rte_internal to pile init and get_memsize. (AI)
* Fix roll back bulk elements in wrong order with fragmentation. (AI)
* Minor changes suggested by AI.
---
 app/test/test_mempool.c                   |   3 +-
 app/test/test_stack.c                     |  67 ++++-
 app/test/test_stack_perf.c                |  15 +-
 config/rte_config.h                       |   5 +-
 doc/guides/prog_guide/stack_lib.rst       |  67 ++++-
 drivers/mempool/stack/rte_mempool_stack.c |  40 +++
 drivers/net/bonding/rte_eth_bond_pmd.c    |   2 +-
 drivers/net/intel/cpfl/cpfl_rxtx.h        |   2 +-
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c   |   3 +-
 drivers/net/tap/rte_eth_tap.c             |   2 +-
 lib/eal/include/rte_common.h              |  12 +
 lib/eal/x86/include/rte_memcpy.h          |  29 ++
 lib/mempool/mempool_trace.h               |   1 -
 lib/mempool/rte_mempool.c                 |  52 ++--
 lib/mempool/rte_mempool.h                 |  74 +++--
 lib/stack/meson.build                     |   3 +-
 lib/stack/rte_stack.c                     |  18 +-
 lib/stack/rte_stack.h                     |  79 +++++-
 lib/stack/rte_stack_lf.h                  |   6 +-
 lib/stack/rte_stack_lf_c11.h              |   2 +-
 lib/stack/rte_stack_lf_generic.h          |   2 +-
 lib/stack/rte_stack_lf_stubs.h            |   2 +-
 lib/stack/rte_stack_pile.c                |  36 +++
 lib/stack/rte_stack_pile.h                | 328 ++++++++++++++++++++++
 lib/stack/rte_stack_std.h                 |  37 ++-
 25 files changed, 771 insertions(+), 116 deletions(-)
 create mode 100644 lib/stack/rte_stack_pile.c
 create mode 100644 lib/stack/rte_stack_pile.h

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..76d45cea2a 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -112,8 +112,7 @@ test_mempool_basic(struct rte_mempool *mp, int use_external_cache)
 		GOTO_ERR(ret, out);
 
 	printf("get private data\n");
-	if (rte_mempool_get_priv(mp) != (char *)mp +
-			RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size))
+	if (rte_mempool_get_priv(mp) != (char *)mp + sizeof(struct rte_mempool))
 		GOTO_ERR(ret, out);
 
 #ifndef RTE_EXEC_ENV_FREEBSD /* rte_mem_virt2iova() not supported on bsd */
diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index 5517982774..f8c8f0971c 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -81,13 +81,30 @@ test_stack_push_pop(struct rte_stack *s, void **obj_table, unsigned int bulk_sz)
 		}
 	}
 
-	for (i = 0; i < STACK_SIZE; i++) {
-		if (obj_table[i] != popped_objs[STACK_SIZE - i - 1]) {
-			printf("[%s():%u] Incorrect value %p at index 0x%x\n",
-			       __func__, __LINE__,
-			       popped_objs[STACK_SIZE - i - 1], i);
-			rte_free(popped_objs);
-			return -1;
+	if (!(s->flags & RTE_STACK_F_PILE)) {
+		for (i = 0; i < STACK_SIZE; i++) {
+			if (obj_table[i] != popped_objs[STACK_SIZE - i - 1]) {
+				printf("[%s():%u] Incorrect value %p at index 0x%x\n",
+				       __func__, __LINE__,
+				       popped_objs[STACK_SIZE - i - 1], i);
+				rte_free(popped_objs);
+				return -1;
+			}
+		}
+	}
+
+	if ((s->flags & RTE_STACK_F_PILE) && (bulk_sz & (RTE_STACK_PILE_BULK_SIZE - 1)) == 0) {
+		for (i = 0; i < STACK_SIZE; i += RTE_STACK_PILE_BULK_SIZE) {
+			if (memcmp(&obj_table[i],
+					&popped_objs[STACK_SIZE - RTE_STACK_PILE_BULK_SIZE - i],
+					RTE_STACK_PILE_BULK_SIZE) != 0) {
+				printf("[%s():%u] Incorrect values %p at index 0x%x with bulk size %u\n",
+				       __func__, __LINE__,
+				       popped_objs[STACK_SIZE - RTE_STACK_PILE_BULK_SIZE - i],
+				       i, bulk_sz);
+				rte_free(popped_objs);
+				return -1;
+			}
 		}
 	}
 
@@ -152,12 +169,27 @@ test_stack_basic(uint32_t flags)
 		goto fail_test;
 	}
 
-	ret = rte_stack_push(s, obj_table, 2 * STACK_SIZE);
-	if (ret != 0) {
-		printf("[%s():%u] Excess objects push succeeded\n",
-		       __func__, __LINE__);
-		goto fail_test;
+__rte_diagnostic_push
+#pragma GCC diagnostic ignored "-Warray-bounds"
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#pragma GCC diagnostic ignored "-Werror=array-bounds"
+	if (!(s->flags & RTE_STACK_F_PILE)) {
+		ret = rte_stack_push(s, obj_table, 2 * STACK_SIZE);
+		if (ret != 0) {
+			printf("[%s():%u] Excess objects push succeeded\n",
+			       __func__, __LINE__);
+			goto fail_test;
+		}
 	}
+	if (s->flags & RTE_STACK_F_PILE) {
+		ret = rte_stack_push(s, obj_table, STACK_SIZE * RTE_STACK_PILE_BULK_SIZE + 1);
+		if (ret != 0) {
+			printf("[%s():%u] Excess objects push succeeded\n",
+			       __func__, __LINE__);
+			goto fail_test;
+		}
+	}
+__rte_diagnostic_pop
 
 	ret = rte_stack_pop(s, obj_table, 1);
 	if (ret != 0) {
@@ -384,5 +416,16 @@ test_lf_stack(void)
 #endif
 }
 
+static int
+test_pile(void)
+{
+#if defined(RTE_STACK_PILE_SUPPORTED)
+	return __test_stack(RTE_STACK_F_PILE);
+#else
+	return TEST_SKIPPED;
+#endif
+}
+
 REGISTER_FAST_TEST(stack_autotest, NOHUGE_SKIP, ASAN_OK, test_stack);
 REGISTER_FAST_TEST(stack_lf_autotest, NOHUGE_SKIP, ASAN_OK, test_lf_stack);
+REGISTER_FAST_TEST(stack_pile_autotest, NOHUGE_SKIP, ASAN_OK, test_pile);
diff --git a/app/test/test_stack_perf.c b/app/test/test_stack_perf.c
index 3f17a2606c..a15f3719c2 100644
--- a/app/test/test_stack_perf.c
+++ b/app/test/test_stack_perf.c
@@ -14,14 +14,14 @@
 #include "test.h"
 
 #define STACK_NAME "STACK_PERF"
-#define MAX_BURST 32
+#define MAX_BURST (RTE_MEMPOOL_CACHE_MAX_SIZE / 2)
 #define STACK_SIZE (RTE_MAX_LCORE * MAX_BURST)
 
 /*
  * Push/pop bulk sizes, marked volatile so they aren't treated as compile-time
  * constants.
  */
-static volatile unsigned int bulk_sizes[] = {8, MAX_BURST};
+static volatile unsigned int bulk_sizes[] = {1, 8, 32, MAX_BURST};
 
 static RTE_ATOMIC(uint32_t) lcore_barrier;
 
@@ -354,5 +354,16 @@ test_lf_stack_perf(void)
 #endif
 }
 
+static int
+test_pile_perf(void)
+{
+#if defined(RTE_STACK_PILE_SUPPORTED)
+	return __test_stack_perf(RTE_STACK_F_PILE);
+#else
+	return TEST_SKIPPED;
+#endif
+}
+
 REGISTER_PERF_TEST(stack_perf_autotest, test_stack_perf);
 REGISTER_PERF_TEST(stack_lf_perf_autotest, test_lf_stack_perf);
+REGISTER_PERF_TEST(stack_pile_perf_autotest, test_pile_perf);
diff --git a/config/rte_config.h b/config/rte_config.h
index 0447cdf2ad..03350660e4 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -56,7 +56,7 @@
 #define RTE_CONTIGMEM_DEFAULT_BUF_SIZE (512*1024*1024)
 
 /* mempool defines */
-#define RTE_MEMPOOL_CACHE_MAX_SIZE 512
+#define RTE_MEMPOOL_CACHE_MAX_SIZE 1024
 /* RTE_LIBRTE_MEMPOOL_STATS is not set */
 /* RTE_LIBRTE_MEMPOOL_DEBUG is not set */
 
@@ -64,6 +64,9 @@
 #define RTE_MBUF_DEFAULT_MEMPOOL_OPS "ring_mp_mc"
 /* RTE_MBUF_HISTORY_DEBUG is not set */
 
+/* stack defines */
+#define RTE_STACK_PILE_BULK_SIZE 32
+
 /* ether defines */
 #define RTE_MAX_QUEUES_PER_PORT 1024
 #define RTE_ETHDEV_RXTX_CALLBACKS 1
diff --git a/doc/guides/prog_guide/stack_lib.rst b/doc/guides/prog_guide/stack_lib.rst
index fdf056730c..fe3a29ffb0 100644
--- a/doc/guides/prog_guide/stack_lib.rst
+++ b/doc/guides/prog_guide/stack_lib.rst
@@ -1,5 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2019 Intel Corporation.
+    Copyright(c) 2026 SmartShare Systems.
 
 Stack Library
 =============
@@ -9,9 +10,10 @@ stack of pointers.
 
 The stack library provides the following basic operations:
 
-*  Create a uniquely named stack of a user-specified size and using a
+*  Create a uniquely named stack (or pile) of a user-specified size and using a
    user-specified socket, with either standard (lock-based) or lock-free
    behavior.
+   The pile resembles a lock-free stack, but is not strictly LIFO.
 
 *  Push and pop a burst of one or more stack objects (pointers).
    These functions are multi-thread safe.
@@ -25,8 +27,9 @@ The stack library provides the following basic operations:
 Implementation
 --------------
 
-The library supports two types of stacks: standard (lock-based) and lock-free.
-Both types use the same set of interfaces, but their implementations differ.
+The library supports three types of stacks: standard (lock-based), lock-free,
+and pile (lock-free, not strictly LIFO, optimized for bulk operations).
+All types use the same set of interfaces, but their implementations differ.
 
 .. _Stack_Library_Std_Stack:
 
@@ -64,7 +67,7 @@ The linked list elements themselves are maintained in a lock-free LIFO, and are
 allocated before stack pushes and freed after stack pops. Since the stack has a
 fixed maximum depth, these elements do not need to be dynamically created.
 
-The lock-free behavior is selected by passing the *RTE_STACK_F_LF* flag to
+The lock-free behavior is selected by passing the ``RTE_STACK_F_LF`` flag to
 ``rte_stack_create()``.
 
 Preventing the ABA problem
@@ -86,3 +89,59 @@ both pop stale data and incorrectly change the head pointer. By adding a
 modification counter that is updated on every push and pop as part of the
 compare-and-swap, the algorithm can detect when the list changes even if the
 head pointer remains the same.
+
+.. _Stack_Library_Pile:
+
+Pile
+~~~~
+
+The pile is a stack-like implementation, optimized for bulk operations.
+It is only LIFO on bulk level, not on object level; i.e. arrays of bulks are
+pushed and popped in LIFO manner, but objects within each bulk are not ordered
+as expected by a stack.
+
+The pile implementation generally resembles that of the lock-free stack.
+In addition to the lock-free stack's linked list of solo (single-object) elements,
+it also contains a linked list of bulk (multi-object) elements.
+And similar to the linked list of free elements, it contains two linked lists of
+free elements, one for each element type (bulk and solo).
+The lock-free property means that multiple threads can push and pop simultaneously.
+One thread being preempted/delayed in a push or pop operation will not
+impede the forward progress of any other thread.
+
+Push operations are performed by splitting the burst in two: objects fitting into
+bulk elements, and any remaining objects (after filling bulk elements) into
+solo elements, and then performaing two lock-free push operations,
+one for each element type (solo and bulk).
+
+Pop operations are performed by splitting the burst in two: objects fitting into
+bulk elements, and any remaining objects (not filling a bulk element) into
+solo elements. Two lock-free pop operations are performed,
+first for bulk elements, and then for solo elements.
+If the pop operation for bulk elements fails, it keeps retrying, requesting one
+less bulk element. The number of solo elements in the following request is
+correspondingly increased.
+
+The pile's lock-free list push and pop operations use the lock-free stack's
+implementations (and uses type casting to mimic C++ class inheritance).
+
+The linked list elements themselves are maintained in two lock-free LIFOs,
+one for bulk elements and one for solo elements, and are
+allocated before pushes and freed after pops. Since the pile has a
+fixed maximum depth, these elements do not need to be dynamically created.
+
+The pile behavior is selected by passing the ``RTE_STACK_F_PILE`` flag to
+``rte_stack_create()``.
+
+The pile bulk size can be changed by modifying ``RTE_STACK_PILE_BULK_SIZE`` in
+``config/rte_config.h``.
+For optimal performance when using the pile mempool driver, the
+mempool cache size / 2 should be divisible by the pile bulk size.
+
+Note:
+The pile is designed and optimized for use with bulks of objects.
+Bursts not a multiple of the bulk size are still handled in a lock-free,
+forward-progress-guaranteed manner. However, pop operations may exhibit
+significantly lower performance in instances where the optimal number of
+bulk elements is unavailable, and it is necessary to retry (fetching
+increasingly fewer bulk elements and correspondingly more solo elements).
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
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..92d7f4f4ef 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1702,7 +1702,7 @@ member_configure_slow_queue(struct rte_eth_dev *bonding_eth_dev,
 		snprintf(mem_name, RTE_DIM(mem_name), "member_port%u_slow_pool",
 				member_id);
 		port->slow_pool = rte_pktmbuf_pool_create(mem_name, 8191,
-			250, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+			256, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
 			member_eth_dev->data->numa_node);
 
 		/* Any memory allocation failure in initialization is critical because
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.h b/drivers/net/intel/cpfl/cpfl_rxtx.h
index 52cdecac88..faf28fd489 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.h
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.h
@@ -25,7 +25,7 @@
 #define CPFL_P2P_QUEUE_GRP_ID	1
 #define CPFL_P2P_DESC_LEN	16
 #define CPFL_P2P_NB_MBUF	4096
-#define CPFL_P2P_CACHE_SIZE	250
+#define CPFL_P2P_CACHE_SIZE	256
 #define CPFL_P2P_MBUF_SIZE	2048
 #define CPFL_P2P_RING_BUF	128
 
diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
index a830c7a33b..4ded5cb63e 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -67,11 +67,12 @@ static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_q
 		}
 		cache->len += rs_thresh;
 
-		if (cache->len >= cache->flushthresh) {
+		if (cache->len >= cache->size) {
 			(void)rte_mempool_ops_enqueue_bulk(mp,
 					&cache->objs[cache->size], cache->len - cache->size);
 			cache->len = cache->size;
 		}
+
 		goto done;
 	}
 
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index b93452f168..b3142561c2 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -61,7 +61,7 @@
 #define TAP_MAX_MAC_ADDRS	16
 #define TAP_GSO_MBUFS_PER_CORE	128
 #define TAP_GSO_MBUF_SEG_SIZE	128
-#define TAP_GSO_MBUF_CACHE_SIZE	4
+#define TAP_GSO_MBUF_CACHE_SIZE	32
 #define TAP_GSO_MBUFS_NUM \
 	(TAP_GSO_MBUFS_PER_CORE * TAP_GSO_MBUF_CACHE_SIZE)
 
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 79d2a0ab93..0fd0906506 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -567,6 +567,15 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_assume(condition) __assume(condition)
 #endif
 
+/**
+ * Alignment hint precondition
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_assume_aligned(ptr, alignment) (ptr)
+#else
+#define __rte_assume_aligned(ptr, alignment) __builtin_assume_aligned(ptr, alignment)
+#endif
+
 /**
  * Disable AddressSanitizer on some code
  */
@@ -775,6 +784,9 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
 /** Force minimum cache line alignment. */
 #define __rte_cache_min_aligned __rte_aligned(RTE_CACHE_LINE_MIN_SIZE)
 
+/** Cache alignment hint precondition */
+#define __rte_assume_cache_aligned(ptr) __rte_assume_aligned(ptr, RTE_CACHE_LINE_SIZE)
+
 #define _RTE_CACHE_GUARD_HELPER2(unique) \
 	alignas(RTE_CACHE_LINE_SIZE) \
 	char cache_guard_ ## unique[RTE_CACHE_LINE_SIZE * RTE_CACHE_GUARD_LINES]
diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 8ed8c55010..3fe1e8d247 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -707,6 +707,35 @@ rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 #endif
 		return dst;
 	}
+	/* Common way for small copy size of 64-byte blocks */
+#if defined __AVX512F__ && defined RTE_MEMCPY_AVX512
+	if (__rte_constant(n) && (n & 63) == 0 && n <= 512) {
+#elif defined RTE_MEMCPY_AVX
+	if (__rte_constant(n) && (n & 63) == 0 && n <= 256) {
+#else /* SSE implementation */
+	if (__rte_constant(n) && (n & 63) == 0 && n <= 512) {
+#endif
+		void *ret = dst;
+
+		if (n & 512) {
+			rte_mov256((uint8_t *)dst + 0 * 256, (const uint8_t *)src + 0 * 256);
+			rte_mov256((uint8_t *)dst + 1 * 256, (const uint8_t *)src + 1 * 256);
+		}
+		if (n & 256) {
+			rte_mov256((uint8_t *)dst, (const uint8_t *)src);
+			src = (const uint8_t *)src + 256;
+			dst = (uint8_t *)dst + 256;
+		}
+		if (n & 128) {
+			rte_mov128((uint8_t *)dst, (const uint8_t *)src);
+			src = (const uint8_t *)src + 128;
+			dst = (uint8_t *)dst + 128;
+		}
+		if (n & 64)
+			rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+
+		return ret;
+	}
 
 	/* Implementation for size > 64 bytes depends on alignment with vector register size. */
 	if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
diff --git a/lib/mempool/mempool_trace.h b/lib/mempool/mempool_trace.h
index 23cda1473c..60e47cf67b 100644
--- a/lib/mempool/mempool_trace.h
+++ b/lib/mempool/mempool_trace.h
@@ -119,7 +119,6 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_i32(socket_id);
 	rte_trace_point_emit_ptr(cache);
 	rte_trace_point_emit_u32(cache->len);
-	rte_trace_point_emit_u32(cache->flushthresh);
 )
 
 RTE_TRACE_POINT(
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..9e3415dbfe 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -753,14 +753,13 @@ static void
 mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
 {
 	cache->size = size;
-	cache->flushthresh = size; /* Obsolete; for API/ABI compatibility purposes only */
 	cache->len = 0;
 }
 
 /*
  * Create and initialize a cache for objects that are retrieved from and
  * returned to an underlying mempool. This structure is identical to the
- * local_cache[lcore_id] pointed to by the mempool structure.
+ * local_cache[lcore_id] entry in the mempool structure.
  */
 RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
@@ -838,9 +837,22 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		return NULL;
 	}
 
+	/*
+	 * Alignment requirement for performance optimized move within the mempool cache.
+	 * @ref rte_mempool_do_generic_put() implementation.
+	 */
+	RTE_BUILD_BUG_ON((RTE_MEMPOOL_CACHE_MAX_SIZE & 31) != 0);
+	if (cache_size & 31) {
+		unsigned int rounded = RTE_ALIGN_MUL_CEIL(cache_size, 32);
+		RTE_MEMPOOL_LOG(WARNING, "%s cache size %u not divisible by 32, using %u instead.",
+				name, cache_size, rounded);
+		cache_size = rounded;
+	}
+
 	/* asked cache too big */
 	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE ||
 	    cache_size > n) {
+		RTE_MEMPOOL_LOG(ERR, "Cache size too big.");
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -884,7 +896,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	mempool_size = RTE_MEMPOOL_HEADER_SIZE(mp, cache_size);
+	mempool_size = sizeof(struct rte_mempool);
 	mempool_size += private_data_size;
 	mempool_size = RTE_ALIGN_CEIL(mempool_size, RTE_MEMPOOL_ALIGN);
 
@@ -900,7 +912,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	/* init the mempool structure */
 	mp = mz->addr;
-	memset(mp, 0, RTE_MEMPOOL_HEADER_SIZE(mp, cache_size));
+	memset(mp, 0, mempool_size);
 	ret = strlcpy(mp->name, name, sizeof(mp->name));
 	if (ret < 0 || ret >= (int)sizeof(mp->name)) {
 		rte_errno = ENAMETOOLONG;
@@ -937,13 +949,6 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	/*
-	 * local_cache pointer is set even if cache_size is zero.
-	 * The local_cache points to just past the elt_pa[] array.
-	 */
-	mp->local_cache = (struct rte_mempool_cache *)
-		RTE_PTR_ADD(mp, RTE_MEMPOOL_HEADER_SIZE(mp, 0));
-
 	/* Init all default caches. */
 	if (cache_size != 0) {
 		for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++)
@@ -1197,6 +1202,7 @@ mempool_obj_audit(struct rte_mempool *mp, __rte_unused void *opaque,
 	RTE_MEMPOOL_CHECK_COOKIES(mp, &obj, 1, 2);
 }
 
+/* check cookies before and after objects */
 static void
 mempool_audit_cookies(struct rte_mempool *mp)
 {
@@ -1213,23 +1219,28 @@ mempool_audit_cookies(struct rte_mempool *mp)
 #define mempool_audit_cookies(mp) do {} while(0)
 #endif
 
-/* check cookies before and after objects */
+/* check cache size consistency */
 static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
-	/* check cache size consistency */
 	unsigned lcore_id;
+	const uint32_t cache_size = mp->cache_size;
 
-	if (mp->cache_size == 0)
-		return;
+	if (cache_size > RTE_MEMPOOL_CACHE_MAX_SIZE) {
+		RTE_MEMPOOL_LOG(CRIT, "badness on cache size");
+		rte_panic("MEMPOOL: invalid cache size\n");
+	}
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		const struct rte_mempool_cache *cache;
 		cache = &mp->local_cache[lcore_id];
-		if (cache->len > RTE_DIM(cache->objs)) {
-			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u]",
-				lcore_id);
-			rte_panic("MEMPOOL: invalid cache len\n");
+		if (cache->size != cache_size) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] size", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] size\n", lcore_id);
+		}
+		if (cache->len > cache_size) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] len", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] len\n", lcore_id);
 		}
 	}
 }
@@ -1241,9 +1252,6 @@ rte_mempool_audit(struct rte_mempool *mp)
 {
 	mempool_audit_cache(mp);
 	mempool_audit_cookies(mp);
-
-	/* For case where mempool DEBUG is not set, and cache size is 0 */
-	RTE_SET_USED(mp);
 }
 
 /* dump the status of the mempool on the console */
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..49e8401280 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -89,14 +89,14 @@ struct __rte_cache_aligned rte_mempool_debug_stats {
  */
 struct __rte_cache_aligned rte_mempool_cache {
 	uint32_t size;	      /**< Size of the cache */
-	uint32_t flushthresh; /**< Obsolete; for API/ABI compatibility purposes only */
 	uint32_t len;	      /**< Current cache count */
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
-	uint32_t unused;
 	/*
 	 * Alternative location for the most frequently updated mempool statistics (per-lcore),
 	 * providing faster update access when using a mempool cache.
+	 * Note: 16-byte aligned for optimal SIMD access, when updating pairs of counters.
 	 */
+	alignas(16)
 	struct {
 		uint64_t put_bulk;          /**< Number of puts. */
 		uint64_t put_objs;          /**< Number of objects successfully put. */
@@ -104,15 +104,9 @@ struct __rte_cache_aligned rte_mempool_cache {
 		uint64_t get_success_objs;  /**< Objects successfully allocated. */
 	} stats;                        /**< Statistics */
 #endif
-	/**
-	 * Cache objects
-	 *
-	 * Note:
-	 * Cache is allocated at double size for API/ABI compatibility purposes only.
-	 * When reducing its size at an API/ABI breaking release,
-	 * remember to add a cache guard after it.
-	 */
-	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
+	/** Cache objects */
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
+	RTE_CACHE_GUARD;
 };
 
 /**
@@ -240,8 +234,7 @@ struct __rte_cache_aligned rte_mempool {
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
-	uint32_t cache_size;
-	/**< Size of per-lcore default local cache. */
+	uint32_t cache_size;             /**< Size of per-lcore default local cache. */
 
 	uint32_t elt_size;               /**< Size of an element. */
 	uint32_t header_size;            /**< Size of header (before elt). */
@@ -257,13 +250,13 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	int32_t ops_index;
 
-	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
-
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
 	uint32_t nb_mem_chunks;          /**< Number of memory chunks */
 	struct rte_mempool_memhdr_list mem_list; /**< List of memory chunks */
 
+	struct rte_mempool_cache local_cache[RTE_MAX_LCORE]; /**< Per-lcore local cache */
+
 #ifdef RTE_LIBRTE_MEMPOOL_STATS
 	/** Per-lcore statistics.
 	 *
@@ -271,6 +264,8 @@ struct __rte_cache_aligned rte_mempool {
 	 */
 	struct rte_mempool_debug_stats stats[RTE_MAX_LCORE + 1];
 #endif
+
+	/* Private data are located immediately after the mempool structure. */
 };
 
 /** Spreading among memory channels not required. */
@@ -362,18 +357,6 @@ struct __rte_cache_aligned rte_mempool {
 #define RTE_MEMPOOL_CACHE_STAT_ADD(cache, name, n) do {} while (0)
 #endif
 
-/**
- * @internal Calculate the size of the mempool header.
- *
- * @param mp
- *   Pointer to the memory pool.
- * @param cs
- *   Size of the per-lcore cache.
- */
-#define RTE_MEMPOOL_HEADER_SIZE(mp, cs) \
-	(sizeof(*(mp)) + (((cs) == 0) ? 0 : \
-	(sizeof(struct rte_mempool_cache) * RTE_MAX_LCORE)))
-
 /* return the header of a mempool object (internal) */
 static inline struct rte_mempool_objhdr *
 rte_mempool_get_header(void *obj)
@@ -718,7 +701,7 @@ struct __rte_cache_aligned rte_mempool_ops {
 	rte_mempool_dequeue_contig_blocks_t dequeue_contig_blocks;
 };
 
-#define RTE_MEMPOOL_MAX_OPS_IDX 16  /**< Max registered ops structs */
+#define RTE_MEMPOOL_MAX_OPS_IDX 32  /**< Max registered ops structs */
 
 /**
  * Structure storing the table of registered ops structs, each of which contain
@@ -1049,7 +1032,7 @@ rte_mempool_free(struct rte_mempool *mp);
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
  *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n.
+ *   RTE_MEMPOOL_CACHE_MAX_SIZE and n, and it must be divisible by 32.
  *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
@@ -1368,15 +1351,16 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
 static __rte_always_inline struct rte_mempool_cache *
 rte_mempool_default_cache(struct rte_mempool *mp, unsigned lcore_id)
 {
-	if (unlikely(mp->cache_size == 0))
+	if (unlikely(lcore_id == LCORE_ID_ANY))
 		return NULL;
 
-	if (unlikely(lcore_id == LCORE_ID_ANY))
+	struct rte_mempool_cache *cache = &mp->local_cache[lcore_id];
+
+	if (unlikely(cache->size == 0))
 		return NULL;
 
-	rte_mempool_trace_default_cache(mp, lcore_id,
-		&mp->local_cache[lcore_id]);
-	return &mp->local_cache[lcore_id];
+	rte_mempool_trace_default_cache(mp, lcore_id, cache);
+	return cache;
 }
 
 /**
@@ -1445,9 +1429,22 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 		 * are more hot, from the upper half of the cache.
 		 */
 		__rte_assume(cache->len > cache->size / 2);
-		rte_mempool_ops_enqueue_bulk(mp, &cache->objs[0], cache->size / 2);
-		rte_memcpy(&cache->objs[0], &cache->objs[cache->size / 2],
-				sizeof(void *) * (cache->len - cache->size / 2));
+		rte_mempool_ops_enqueue_bulk(mp, cache->objs, cache->size / 2);
+		/*
+		 * For improved rte_memcpy() performance, move down objects
+		 * from CPU cache line aligned address in chunks of 32 bytes.
+		 * Note: For cache->objs[cache->size / 2] to be cache line aligned, cache->size
+		 * must be divisible by 32 on 32-bit architecture with 64-byte cache line,
+		 * divisible by 32 on 64-bit architecture with 128-byte cache line, and
+		 * be divisible by 16 on 64-bit architecture with 64-byte cache line.
+		 * For API consistency, require mempool cache size is divisible by 32.
+		 */
+		const size_t move = RTE_ALIGN_MUL_CEIL(
+				sizeof(void *) * (cache->len - cache->size / 2), 32);
+		__rte_assume(move >= 32);
+		__rte_assume((move & 31) == 0);
+		rte_memcpy(cache->objs, __rte_assume_cache_aligned(&cache->objs[cache->size / 2]),
+				move);
 		cache_objs = &cache->objs[cache->len - cache->size / 2];
 		cache->len = cache->len - cache->size / 2 + n;
 	} else {
@@ -1892,8 +1889,7 @@ void rte_mempool_audit(struct rte_mempool *mp);
  */
 static inline void *rte_mempool_get_priv(struct rte_mempool *mp)
 {
-	return (char *)mp +
-		RTE_MEMPOOL_HEADER_SIZE(mp, mp->cache_size);
+	return (char *)mp + sizeof(struct rte_mempool);
 }
 
 /**
diff --git a/lib/stack/meson.build b/lib/stack/meson.build
index 18177a742f..50e688522e 100644
--- a/lib/stack/meson.build
+++ b/lib/stack/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2019 Intel Corporation
 
-sources = files('rte_stack.c', 'rte_stack_std.c', 'rte_stack_lf.c')
+sources = files('rte_stack.c', 'rte_stack_std.c', 'rte_stack_lf.c', 'rte_stack_pile.c')
 headers = files('rte_stack.h')
 # subheaders, not for direct inclusion by apps
 indirect_headers += files(
@@ -10,4 +10,5 @@ indirect_headers += files(
         'rte_stack_lf_generic.h',
         'rte_stack_lf_c11.h',
         'rte_stack_lf_stubs.h',
+        'rte_stack_pile.h',
 )
diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index 4c78fe4b4b..a4bbf8a4d7 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2026 SmartShare Systems
  */
 
 #include <stdalign.h>
@@ -32,6 +33,8 @@ rte_stack_init(struct rte_stack *s, unsigned int count, uint32_t flags)
 
 	if (flags & RTE_STACK_F_LF)
 		rte_stack_lf_init(s, count);
+	else if (flags & RTE_STACK_F_PILE)
+		rte_stack_pile_init(s, count);
 	else
 		rte_stack_std_init(s);
 }
@@ -41,6 +44,8 @@ rte_stack_get_memsize(unsigned int count, uint32_t flags)
 {
 	if (flags & RTE_STACK_F_LF)
 		return rte_stack_lf_get_memsize(count);
+	else if (flags & RTE_STACK_F_PILE)
+		return rte_stack_pile_get_memsize(count);
 	else
 		return rte_stack_std_get_memsize(count);
 }
@@ -58,7 +63,11 @@ rte_stack_create(const char *name, unsigned int count, int socket_id,
 	unsigned int sz;
 	int ret;
 
-	if (flags & ~(RTE_STACK_F_LF)) {
+	if (flags & ~(RTE_STACK_F_LF | RTE_STACK_F_PILE)) {
+		STACK_LOG_ERR("Unsupported stack flags %#x", flags);
+		return NULL;
+	}
+	if ((flags & RTE_STACK_F_LF) && (flags & RTE_STACK_F_PILE)) {
 		STACK_LOG_ERR("Unsupported stack flags %#x", flags);
 		return NULL;
 	}
@@ -73,6 +82,13 @@ rte_stack_create(const char *name, unsigned int count, int socket_id,
 		return NULL;
 	}
 #endif
+#if !defined(RTE_STACK_PILE_SUPPORTED)
+	if (flags & RTE_STACK_F_PILE) {
+		STACK_LOG_ERR("Pile is not supported on your platform");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+#endif
 
 	sz = rte_stack_get_memsize(count, flags);
 
diff --git a/lib/stack/rte_stack.h b/lib/stack/rte_stack.h
index fd17ac791d..92b40891d1 100644
--- a/lib/stack/rte_stack.h
+++ b/lib/stack/rte_stack.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2026 SmartShare Systems
  */
 
 /**
@@ -28,11 +29,45 @@
 #define RTE_STACK_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
 			   sizeof(RTE_STACK_MZ_PREFIX) + 1)
 
+static_assert(((sizeof(void *) * RTE_STACK_PILE_BULK_SIZE) & RTE_CACHE_LINE_MASK) == 0,
+		"Pile bulk size must be divisible by CPU cache line size");
+
+/* Note: Also used as solo (single-object) pile element. */
 struct rte_stack_lf_elem {
 	void *data;			/**< Data pointer */
 	struct rte_stack_lf_elem *next;	/**< Next pointer */
 };
 
+/*
+ * Bulk (multi-object) pile element.
+ * Inherited from the rte_stack_lf_elem (single-object) class,
+ * and extended with an array for holding a bulk of object pointers.
+ */
+struct rte_stack_pile_bulk_elem {
+	/* The first part must be ABI compatible with the rte_stack_lf_elem parent class. */
+	void *unused;                               /**< For rte_stack_lf_elem compatibility only */
+	struct rte_stack_pile_bulk_elem *next;      /**< Next pointer */
+	/* The second part differs. */
+	alignas(RTE_CACHE_LINE_SIZE)
+	void *objs[RTE_STACK_PILE_BULK_SIZE];       /**< Bulk (multi-object) pointers */
+};
+
+static_assert(sizeof(struct rte_stack_lf_elem) ==
+		sizeof(struct rte_stack_lf_elem *) + sizeof(void *),
+		"Parent type has changed");
+static_assert(RTE_SIZEOF_FIELD(struct rte_stack_lf_elem, next) ==
+		RTE_SIZEOF_FIELD(struct rte_stack_pile_bulk_elem, next),
+		"Inherited type mismatch");
+static_assert(offsetof(struct rte_stack_lf_elem, next) ==
+		offsetof(struct rte_stack_pile_bulk_elem, next),
+		"Inherited type mismatch");
+static_assert(RTE_SIZEOF_FIELD(struct rte_stack_lf_elem, data) ==
+		RTE_SIZEOF_FIELD(struct rte_stack_pile_bulk_elem, data),
+		"Inherited type mismatch");
+static_assert(offsetof(struct rte_stack_lf_elem, data) ==
+		offsetof(struct rte_stack_pile_bulk_elem, data),
+		"Inherited type mismatch");
+
 struct __rte_aligned(16) rte_stack_lf_head {
 	struct rte_stack_lf_elem *top; /**< Stack top */
 	uint64_t cnt; /**< Modification counter for avoiding ABA problem */
@@ -51,12 +86,35 @@ struct rte_stack_lf_list {
 struct rte_stack_lf {
 	/** LIFO list of elements */
 	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list used;
+	RTE_CACHE_GUARD;
 	/** LIFO list of free elements */
 	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list free;
+	RTE_CACHE_GUARD;
 	/** LIFO elements */
 	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_elem elems[];
 };
 
+/* Pile structure containing three lock-free LIFO-like lists:
+ *  - A list of elements, each element holding a bulk of pointers to objects.
+ *  - A list of elements, each element holding one pointer to an object.
+ *  - A list of free linked-list elements.
+ */
+struct rte_stack_pile {
+	/** LIFO list of bulk (multi-object) elements */
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list bulk;
+	RTE_CACHE_GUARD;
+	/** LIFO list of solo (single-object) elements */
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list solo;
+	RTE_CACHE_GUARD;
+	/** LIFO list of free bulk elements */
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list free_bulk;
+	RTE_CACHE_GUARD;
+	/** LIFO list of free solo elements */
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_stack_lf_list free_solo;
+	RTE_CACHE_GUARD;
+	/** LIFO elements follow, first bulk, then solo */
+};
+
 /* Structure containing the LIFO, its current length, and a lock for mutual
  * exclusion.
  */
@@ -78,6 +136,7 @@ struct __rte_cache_aligned rte_stack {
 	uint32_t flags; /**< Flags supplied at creation. */
 	union {
 		struct rte_stack_lf stack_lf; /**< Lock-free LIFO structure. */
+		struct rte_stack_pile stack_pile; /**< Lock-free pile (LIFO-like) structure. */
 		struct rte_stack_std stack_std;	/**< LIFO structure. */
 	};
 };
@@ -88,8 +147,18 @@ struct __rte_cache_aligned rte_stack {
  */
 #define RTE_STACK_F_LF 0x0001
 
+/**
+ * The stack-like pile uses lock-free push and pop functions.
+ * It is optimized for bulks of objects, and is not strictly LIFO.
+ * This flag is only supported on x86_64 or arm64 platforms, currently.
+ *
+ * @experimental
+ */
+#define RTE_STACK_F_PILE 0x0002
+
 #include "rte_stack_std.h"
 #include "rte_stack_lf.h"
+#include "rte_stack_pile.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -108,13 +177,15 @@ extern "C" {
  *   Actual number of objects pushed (either 0 or *n*).
  */
 static __rte_always_inline unsigned int
-rte_stack_push(struct rte_stack *s, void * const *obj_table, unsigned int n)
+rte_stack_push(struct rte_stack *s, void * const * __rte_restrict obj_table, unsigned int n)
 {
 	RTE_ASSERT(s != NULL);
 	RTE_ASSERT(obj_table != NULL);
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_push(s, obj_table, n);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_push(s, obj_table, n);
 	else
 		return __rte_stack_std_push(s, obj_table, n);
 }
@@ -132,13 +203,15 @@ rte_stack_push(struct rte_stack *s, void * const *obj_table, unsigned int n)
  *   Actual number of objects popped (either 0 or *n*).
  */
 static __rte_always_inline unsigned int
-rte_stack_pop(struct rte_stack *s, void **obj_table, unsigned int n)
+rte_stack_pop(struct rte_stack *s, void ** __rte_restrict obj_table, unsigned int n)
 {
 	RTE_ASSERT(s != NULL);
 	RTE_ASSERT(obj_table != NULL);
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_pop(s, obj_table, n);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_pop(s, obj_table, n);
 	else
 		return __rte_stack_std_pop(s, obj_table, n);
 }
@@ -158,6 +231,8 @@ rte_stack_count(struct rte_stack *s)
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_count(s);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_count(s);
 	else
 		return __rte_stack_std_count(s);
 }
diff --git a/lib/stack/rte_stack_lf.h b/lib/stack/rte_stack_lf.h
index f2b012cd0e..655620aaa9 100644
--- a/lib/stack/rte_stack_lf.h
+++ b/lib/stack/rte_stack_lf.h
@@ -34,7 +34,7 @@
  */
 static __rte_always_inline unsigned int
 __rte_stack_lf_push(struct rte_stack *s,
-		    void * const *obj_table,
+		    void * const * __rte_restrict obj_table,
 		    unsigned int n)
 {
 	struct rte_stack_lf_elem *tmp, *first, *last = NULL;
@@ -71,7 +71,8 @@ __rte_stack_lf_push(struct rte_stack *s,
  *   - Actual number of objects popped.
  */
 static __rte_always_inline unsigned int
-__rte_stack_lf_pop(struct rte_stack *s, void **obj_table, unsigned int n)
+__rte_stack_lf_pop(struct rte_stack *s, void ** __rte_restrict obj_table,
+		   unsigned int n)
 {
 	struct rte_stack_lf_elem *first, *last = NULL;
 
@@ -79,6 +80,7 @@ __rte_stack_lf_pop(struct rte_stack *s, void **obj_table, unsigned int n)
 		return 0;
 
 	/* Pop n used elements */
+	__rte_assume(obj_table != NULL);
 	first = __rte_stack_lf_pop_elems(&s->stack_lf.used,
 					 n, obj_table, &last);
 	if (unlikely(first == NULL))
diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
index b97e02d6a1..501e985a49 100644
--- a/lib/stack/rte_stack_lf_c11.h
+++ b/lib/stack/rte_stack_lf_c11.h
@@ -99,7 +99,7 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
 static __rte_always_inline struct rte_stack_lf_elem *
 __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 			 unsigned int num,
-			 void **obj_table,
+			 void ** __rte_restrict obj_table,
 			 struct rte_stack_lf_elem **last)
 {
 	struct rte_stack_lf_head old_head;
diff --git a/lib/stack/rte_stack_lf_generic.h b/lib/stack/rte_stack_lf_generic.h
index cc69e4d168..c4cc4d2c03 100644
--- a/lib/stack/rte_stack_lf_generic.h
+++ b/lib/stack/rte_stack_lf_generic.h
@@ -74,7 +74,7 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
 static __rte_always_inline struct rte_stack_lf_elem *
 __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 			 unsigned int num,
-			 void **obj_table,
+			 void ** __rte_restrict obj_table,
 			 struct rte_stack_lf_elem **last)
 {
 	struct rte_stack_lf_head old_head;
diff --git a/lib/stack/rte_stack_lf_stubs.h b/lib/stack/rte_stack_lf_stubs.h
index a05abf1f1c..457a415ccf 100644
--- a/lib/stack/rte_stack_lf_stubs.h
+++ b/lib/stack/rte_stack_lf_stubs.h
@@ -30,7 +30,7 @@ __rte_stack_lf_push_elems(struct rte_stack_lf_list *list,
 static __rte_always_inline struct rte_stack_lf_elem *
 __rte_stack_lf_pop_elems(struct rte_stack_lf_list *list,
 			 unsigned int num,
-			 void **obj_table,
+			 void ** __rte_restrict obj_table,
 			 struct rte_stack_lf_elem **last)
 {
 	RTE_SET_USED(obj_table);
diff --git a/lib/stack/rte_stack_pile.c b/lib/stack/rte_stack_pile.c
new file mode 100644
index 0000000000..aa2901c926
--- /dev/null
+++ b/lib/stack/rte_stack_pile.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 SmartShare Systems
+ */
+
+#include "rte_stack.h"
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_stack_pile_init)
+void
+rte_stack_pile_init(struct rte_stack *s, unsigned int count)
+{
+	unsigned int bulk = (count + RTE_STACK_PILE_BULK_SIZE - 1) / RTE_STACK_PILE_BULK_SIZE;
+	struct rte_stack_pile_bulk_elem *bulk_elems =
+			(struct rte_stack_pile_bulk_elem *)(&s->stack_pile + 1);
+	struct rte_stack_lf_elem *solo_elems = (struct rte_stack_lf_elem *)&bulk_elems[bulk];
+	unsigned int i;
+
+	for (i = 0; i < bulk; i++)
+		__rte_stack_pile_bulk_push_elems(&s->stack_pile.free_bulk,
+					  &bulk_elems[i], &bulk_elems[i], 1);
+	for (i = 0; i < count; i++)
+		__rte_stack_lf_push_elems(&s->stack_pile.free_solo,
+					  &solo_elems[i], &solo_elems[i], 1);
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_stack_pile_get_memsize)
+ssize_t
+rte_stack_pile_get_memsize(unsigned int count)
+{
+	unsigned int bulk = (count + RTE_STACK_PILE_BULK_SIZE - 1) / RTE_STACK_PILE_BULK_SIZE;
+	ssize_t sz = sizeof(struct rte_stack); /* Already cache line aligned. */
+	sz += bulk * sizeof(struct rte_stack_pile_bulk_elem); /* Already cache line aligned. */
+	sz += RTE_CACHE_LINE_ROUNDUP(count * sizeof(struct rte_stack_lf_elem));
+	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
+
+	return sz;
+}
diff --git a/lib/stack/rte_stack_pile.h b/lib/stack/rte_stack_pile.h
new file mode 100644
index 0000000000..f45bfcdba6
--- /dev/null
+++ b/lib/stack/rte_stack_pile.h
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 SmartShare Systems
+ */
+
+#ifndef _RTE_STACK_PILE_H_
+#define _RTE_STACK_PILE_H_
+
+#if !(defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64))
+#include "rte_stack_lf_stubs.h"
+#else
+#ifdef RTE_USE_C11_MEM_MODEL
+#include "rte_stack_lf_c11.h"
+#else
+#include "rte_stack_lf_generic.h"
+#endif
+
+/**
+ * Indicates that RTE_STACK_F_PILE is supported.
+ */
+#define RTE_STACK_PILE_SUPPORTED
+#endif
+
+static __rte_always_inline unsigned int
+__rte_stack_pile_count(struct rte_stack *s)
+{
+	/* stack_lf_push() and stack_lf_pop() do not update the list's contents
+	 * and stack_lf->len atomically, which can cause the list to appear
+	 * shorter than it actually is if this function is called while other
+	 * threads are modifying the list.
+	 *
+	 * However, given the inherently approximate nature of the get_count
+	 * callback -- even if the list and its size were updated atomically,
+	 * the size could change between when get_count executes and when the
+	 * value is returned to the caller -- this is acceptable.
+	 *
+	 * The stack_lf->len updates are placed such that the list may appear to
+	 * have fewer elements than it does, but will never appear to have more
+	 * elements. If the mempool is near-empty to the point that this is a
+	 * concern, the user should consider increasing the mempool size.
+	 */
+#ifdef RTE_USE_C11_MEM_MODEL
+	return RTE_MIN((unsigned int)s->capacity,
+			(unsigned int)rte_atomic_load_explicit(&s->stack_pile.bulk.len,
+			rte_memory_order_relaxed) * RTE_STACK_PILE_BULK_SIZE +
+			(unsigned int)rte_atomic_load_explicit(&s->stack_pile.solo.len,
+			rte_memory_order_relaxed));
+#else
+	/* NOTE: review for potential ordering optimization */
+	return RTE_MIN((unsigned int)s->capacity,
+			(unsigned int)rte_atomic_load_explicit(&s->stack_pile.bulk.len,
+			rte_memory_order_seq_cst) * RTE_STACK_PILE_BULK_SIZE +
+			(unsigned int)rte_atomic_load_explicit(&s->stack_pile.solo.len,
+			rte_memory_order_seq_cst));
+#endif
+}
+
+static __rte_always_inline void
+__rte_stack_pile_bulk_push_elems(struct rte_stack_lf_list *list,
+		struct rte_stack_pile_bulk_elem *first,
+		struct rte_stack_pile_bulk_elem *last,
+		unsigned int num)
+{
+	__rte_stack_lf_push_elems(list,
+		(struct rte_stack_lf_elem *)first,
+		(struct rte_stack_lf_elem *)last,
+		num);
+}
+
+static __rte_always_inline struct rte_stack_pile_bulk_elem *
+__rte_stack_pile_bulk_pop_elems(struct rte_stack_lf_list *list,
+		unsigned int num,
+		void ** __rte_restrict obj_table,
+		struct rte_stack_pile_bulk_elem **last)
+{
+	struct rte_stack_pile_bulk_elem *first = (struct rte_stack_pile_bulk_elem *)
+			__rte_stack_lf_pop_elems(list, num, NULL,
+			(struct rte_stack_lf_elem **)last);
+	if (first == NULL)
+		return NULL;
+
+	if (obj_table != NULL) {
+		/* Traverse the list to copy the bulks. */
+		struct rte_stack_pile_bulk_elem *tmp = first;
+		for (unsigned int i = 0; i < num; i++, tmp = tmp->next)
+			rte_memcpy(&obj_table[i * RTE_STACK_PILE_BULK_SIZE], tmp->objs,
+					sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+	}
+
+	return first;
+}
+
+/**
+ * Push several objects on the pile (lock-free, MT-safe).
+ *
+ * @param pile
+ *   A pointer to the pile structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to push on the pile from the obj_table.
+ * @return
+ *   Actual number of objects pushed (either 0 or *n*).
+ */
+static __rte_always_inline unsigned int
+__rte_stack_pile_push(struct rte_stack *s,
+		void * const * __rte_restrict obj_table,
+		unsigned int n)
+{
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	struct rte_stack_pile *pile = &s->stack_pile;
+	struct rte_stack_pile_bulk_elem *bulk_first = NULL, *bulk_last = NULL, *tmp_bulk;
+	struct rte_stack_lf_elem *solo_first = NULL, *solo_last = NULL, *tmp_solo;
+	unsigned int n_bulk = n / RTE_STACK_PILE_BULK_SIZE;
+	unsigned int n_solo = n & (RTE_STACK_PILE_BULK_SIZE - 1);
+	unsigned int i;
+
+	if (unlikely(n_bulk == 0)) {
+		if (unlikely(n_solo == 0))
+			return 0;
+		goto solo;
+	}
+
+	/* Allocate n_bulk elements from the free list. */
+	bulk_first = __rte_stack_pile_bulk_pop_elems(&pile->free_bulk, n_bulk, NULL, &bulk_last);
+	if (unlikely(bulk_first == NULL))
+		return 0; /* Failed. */
+
+	if (likely(n_solo == 0))
+		goto bulk;
+
+solo:
+	/* Allocate n_solo elements from the free list. */
+	solo_first = __rte_stack_lf_pop_elems(&pile->free_solo, n_solo, NULL, &solo_last);
+	if (unlikely(solo_first == NULL)) {
+		/* Failed. Roll back. */
+		if (n_bulk > 0)
+			__rte_stack_pile_bulk_push_elems(&pile->free_bulk,
+					bulk_first, bulk_last, n_bulk);
+		return 0;
+	}
+
+	/*
+	 * Construct the solo elements.
+	 * Copy the objects, but ignore the object order.
+	 */
+	tmp_solo = solo_first;
+	__rte_assume(n_solo > 0);
+	__rte_assume(n_solo < RTE_STACK_PILE_BULK_SIZE);
+	for (i = 0; i < n_solo; i++, tmp_solo = tmp_solo->next)
+		tmp_solo->data = obj_table[n_bulk * RTE_STACK_PILE_BULK_SIZE + i];
+
+	/* Push them to the solo list. */
+	__rte_stack_lf_push_elems(&pile->solo, solo_first, solo_last, n_solo);
+
+	if (unlikely(n_bulk == 0))
+		return n; /* Done. */
+
+bulk:
+	/*
+	 * Construct the bulk elements.
+	 * Copy bulks in reverse order, but ignore the object order within each bulk.
+	 */
+	tmp_bulk = bulk_first;
+	__rte_assume(n_bulk > 0);
+	for (i = 0; i < n_bulk; i++, tmp_bulk = tmp_bulk->next)
+		rte_memcpy(tmp_bulk->objs, &obj_table[(n_bulk - i - 1) * RTE_STACK_PILE_BULK_SIZE],
+				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+
+	/* Push them to the bulk list. */
+	__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, n_bulk);
+
+	return n;
+}
+
+/**
+ * Pop several objects from the pile (lock-free, MT-safe).
+ *
+ * @param pile
+ *   A pointer to the pile structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to pull from the pile.
+ * @return
+ *   Actual number of objects popped (either 0 or *n*).
+ */
+static __rte_always_inline unsigned int
+__rte_stack_pile_pop(struct rte_stack *s,
+		void ** __rte_restrict obj_table,
+		unsigned int n)
+{
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	struct rte_stack_pile *pile = &s->stack_pile;
+	struct rte_stack_pile_bulk_elem *bulk_first = NULL, *bulk_last = NULL;
+	struct rte_stack_lf_elem *solo_first = NULL, *solo_last = NULL;
+	unsigned int n_bulk = n / RTE_STACK_PILE_BULK_SIZE;
+	unsigned int n_solo = n & (RTE_STACK_PILE_BULK_SIZE - 1);
+	unsigned int i;
+
+	if (unlikely(n_bulk == 0)) {
+		if (unlikely(n_solo == 0))
+			return 0;
+		goto solo;
+	}
+
+bulk:
+	/* Fetch n_bulk * RTE_STACK_PILE_BULK_SIZE objects as bulk elements. */
+	bulk_first = __rte_stack_pile_bulk_pop_elems(&pile->bulk, n_bulk, obj_table, &bulk_last);
+	if (unlikely(bulk_first == NULL)) {
+		/*
+		 * Not available.
+		 * Retry with fewer bulk elements; objects to be fetched as solo elements instead.
+		 */
+		n_solo += RTE_STACK_PILE_BULK_SIZE;
+		n_bulk--;
+		if (n_bulk > 0)
+			goto bulk;
+		else
+			goto solo;
+	}
+
+	if (likely(n_solo == 0))
+		goto done;
+
+solo:
+	/* Fetch n_solo objects as solo elements. */
+	solo_first = __rte_stack_lf_pop_elems(&pile->solo, n_solo,
+			&obj_table[n_bulk * RTE_STACK_PILE_BULK_SIZE], &solo_last);
+	if (solo_first != NULL)
+		goto done;
+
+	/* Solo elements not available. Try fragmentation. */
+	alignas(RTE_CACHE_LINE_SIZE) void *obj_frag[RTE_STACK_PILE_BULK_SIZE];
+	struct rte_stack_pile_bulk_elem *frag;
+
+	/* Fetch a fragmentation element as a bulk element. */
+	frag = __rte_stack_pile_bulk_pop_elems(&pile->bulk, 1, obj_frag, NULL);
+	if (unlikely(frag == NULL)) {
+		/* Failed. Roll back. */
+		if (n_bulk > 0)
+			__rte_stack_pile_bulk_push_elems(&pile->bulk,
+					bulk_first, bulk_last, n_bulk);
+		return 0;
+	}
+
+	/* Get n_solo objects from the fragmentation element. */
+	__rte_assume(n_solo > 0);
+	__rte_assume(n_solo < RTE_STACK_PILE_BULK_SIZE);
+	for (i = 0; i < n_solo; i++)
+		obj_table[n_bulk * RTE_STACK_PILE_BULK_SIZE + i] = obj_frag[i];
+
+	/* Fetch free elements for the excess objects. */
+	__rte_assume(RTE_STACK_PILE_BULK_SIZE - n_solo > 0);
+	__rte_assume(RTE_STACK_PILE_BULK_SIZE - n_solo < RTE_STACK_PILE_BULK_SIZE - 1);
+	solo_first = __rte_stack_lf_pop_elems(&pile->free_solo,
+			RTE_STACK_PILE_BULK_SIZE - n_solo, NULL, &solo_last);
+	if (unlikely(solo_first == NULL)) {
+		/* Failed. Roll back. */
+		if (n_bulk > 0) {
+			/* Attach the fragmentation element after the bulk elements. */
+			bulk_last->next = frag;
+		} else {
+			bulk_first = frag;
+			bulk_last = frag;
+		}
+		__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, 1 + n_bulk);
+		return 0;
+	}
+
+	/* Construct the solo elements from the excess objects. */
+	struct rte_stack_lf_elem *tmp = solo_first;
+	__rte_assume(n_solo > 0);
+	__rte_assume(n_solo < RTE_STACK_PILE_BULK_SIZE);
+	for (i = n_solo; i < RTE_STACK_PILE_BULK_SIZE; i++, tmp = tmp->next)
+		tmp->data = obj_frag[i];
+
+	/* Push the excess objects as solo elements. */
+	__rte_stack_lf_push_elems(&pile->solo, solo_first, solo_last,
+			RTE_STACK_PILE_BULK_SIZE - n_solo);
+	n_solo = 0;
+
+	/* Add the fragmentation element in front of the bulk elements, so it can be freed. */
+	if (n_bulk > 0)
+		frag->next = bulk_first;
+	else
+		bulk_last = frag;
+	bulk_first = frag;
+	n_bulk++;
+
+done:
+	/* Success. Free the elements. */
+	if (n_bulk > 0)
+		__rte_stack_pile_bulk_push_elems(&pile->free_bulk, bulk_first, bulk_last, n_bulk);
+	if (n_solo > 0)
+		__rte_stack_lf_push_elems(&pile->free_solo, solo_first, solo_last, n_solo);
+
+	return n;
+}
+
+/**
+ * @internal Initialize a pile stack.
+ *
+ * @param s
+ *   A pointer to the stack structure.
+ * @param count
+ *   The size of the stack.
+ */
+__rte_internal
+void
+rte_stack_pile_init(struct rte_stack *s, unsigned int count);
+
+/**
+ * @internal Return the memory required for a pile stack.
+ *
+ * @param count
+ *   The size of the stack.
+ * @return
+ *   The bytes to allocate for a pile stack.
+ */
+__rte_internal
+ssize_t
+rte_stack_pile_get_memsize(unsigned int count);
+
+#endif /* _RTE_STACK_PILE_H_ */
diff --git a/lib/stack/rte_stack_std.h b/lib/stack/rte_stack_std.h
index ae28add5c4..cb815d6cbe 100644
--- a/lib/stack/rte_stack_std.h
+++ b/lib/stack/rte_stack_std.h
@@ -6,6 +6,7 @@
 #define _RTE_STACK_STD_H_
 
 #include <rte_branch_prediction.h>
+#include <rte_memcpy.h>
 
 /**
  * @internal Push several objects on the stack (MT-safe).
@@ -20,27 +21,24 @@
  *   Actual number of objects pushed (either 0 or *n*).
  */
 static __rte_always_inline unsigned int
-__rte_stack_std_push(struct rte_stack *s, void * const *obj_table,
+__rte_stack_std_push(struct rte_stack *s, void * const * __rte_restrict obj_table,
 		     unsigned int n)
 {
 	struct rte_stack_std *stack = &s->stack_std;
-	unsigned int index;
-	void **cache_objs;
+	void ** __rte_restrict stack_objs;
 
 	rte_spinlock_lock(&stack->lock);
-	cache_objs = &stack->objs[stack->len];
 
-	/* Is there sufficient space in the stack? */
-	if ((stack->len + n) > s->capacity) {
+	if (unlikely((stack->len + n) > s->capacity)) {
+		/* Insufficient room in the stack. */
 		rte_spinlock_unlock(&stack->lock);
 		return 0;
 	}
 
-	/* Add elements back into the cache */
-	for (index = 0; index < n; ++index, obj_table++)
-		cache_objs[index] = *obj_table;
-
+	/* Push objects to the stack */
+	stack_objs = &stack->objs[stack->len];
 	stack->len += n;
+	rte_memcpy(stack_objs, obj_table, sizeof(void *) * n);
 
 	rte_spinlock_unlock(&stack->lock);
 	return n;
@@ -59,28 +57,27 @@ __rte_stack_std_push(struct rte_stack *s, void * const *obj_table,
  *   Actual number of objects popped (either 0 or *n*).
  */
 static __rte_always_inline unsigned int
-__rte_stack_std_pop(struct rte_stack *s, void **obj_table, unsigned int n)
+__rte_stack_std_pop(struct rte_stack *s, void ** __rte_restrict obj_table, unsigned int n)
 {
 	struct rte_stack_std *stack = &s->stack_std;
-	unsigned int index, len;
-	void **cache_objs;
+	unsigned int index;
+	void ** __rte_restrict stack_objs;
 
 	rte_spinlock_lock(&stack->lock);
 
 	if (unlikely(n > stack->len)) {
+		/* Insufficient objects in the stack. */
 		rte_spinlock_unlock(&stack->lock);
 		return 0;
 	}
 
-	cache_objs = stack->objs;
-
-	for (index = 0, len = stack->len - 1; index < n;
-			++index, len--, obj_table++)
-		*obj_table = cache_objs[len];
-
+	/* Pop objects from the stack */
+	stack_objs = &stack->objs[stack->len];
 	stack->len -= n;
-	rte_spinlock_unlock(&stack->lock);
+	for (index = 0; index < n; index++)
+		*obj_table++ = *--stack_objs;
 
+	rte_spinlock_unlock(&stack->lock);
 	return n;
 }
 
-- 
2.43.0

