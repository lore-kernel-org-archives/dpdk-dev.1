Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C1C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 06:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 754494060F;
	Tue,  1 Sep 2026 08:43:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DA9744027E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 08:43:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C626620A99;
 Tue,  1 Sep 2026 08:43:34 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Sep 2026 08:43:34 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v4 1/2] stack: introduce pile
Date: Tue,  1 Sep 2026 06:43:30 +0000
Message-ID: <20260901064331.594276-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901064331.594276-1-mb@smartsharesystems.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <20260901064331.594276-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Sep 2026 06:43:34.0463 (UTC)
 FILETIME=[35D414F0:01DD39DD]
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

Added a new high-performance lock-free "pile", using the Stack API.
The pile behaves roughly like a stack, but is not strictly LIFO.

The pile is optimized for pushing/popping bulks of objects, which
it does significantly faster than the lock-free stack.

Pushing/popping a number of objects not divisible by the compile time
configurable bulk size is handled gracefully, but not as fast as
complete bulks.

Performance examples, stack_pile_perf_autotest vs. stack_lf_autotest:

On a single core, pushing/popping 1 or 8 objects is similar speed.
On a single core, pushing/popping 32 objects is 2x faster.
On a single core, pushing/popping 512 objects is 10x faster.

On four cores, pushing/popping 1, 8 or 32 objects is slightly faster.
On four cores, pushing/popping 512 objects is 4x faster.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
v4:
* Use inline instead of __rte_always_inline for push/pop functions,
  and let the compiler decide. (Konstantin, Stephen)
* Use inline instead of __rte_noinline for fragmentation (in pop
  function), and let the compiler decide.
v3:
* Embedded rte_stack_lf_elem parent class as first field in
  rte_stack_pile_bulk_elem inherited class, instead of copying all its
  fields. (Konstantin)
* Moved fragmentation (in pop function) into separate inline function.
  (Konstantin)
* Removed memory model #ifdefs by adding __rte_stack_lf_elems_count()
  function to the lock-free stack.
* Added TODO about potential improvement of bulk pop retry by implementing
  burst variant of pop_elems().
* Improved bulk pop retry algorithm by peeking at availability.
v2:
* There is no v2.
---
 app/test/test_stack.c               |  71 +++++-
 app/test/test_stack_perf.c          |  15 +-
 config/rte_config.h                 |   3 +
 doc/guides/prog_guide/stack_lib.rst |  67 +++++-
 lib/mempool/rte_mempool.h           |   2 +-
 lib/stack/meson.build               |   3 +-
 lib/stack/rte_stack.c               |  18 +-
 lib/stack/rte_stack.h               |  65 +++++
 lib/stack/rte_stack_lf.h            |  22 ++
 lib/stack/rte_stack_lf_c11.h        |  20 +-
 lib/stack/rte_stack_lf_generic.h    |  19 +-
 lib/stack/rte_stack_lf_stubs.h      |   4 +-
 lib/stack/rte_stack_pile.c          |  35 +++
 lib/stack/rte_stack_pile.h          | 359 ++++++++++++++++++++++++++++
 14 files changed, 647 insertions(+), 56 deletions(-)
 create mode 100644 lib/stack/rte_stack_pile.c
 create mode 100644 lib/stack/rte_stack_pile.h

diff --git a/app/test/test_stack.c b/app/test/test_stack.c
index 5517982774..928f63e9e0 100644
--- a/app/test/test_stack.c
+++ b/app/test/test_stack.c
@@ -11,8 +11,8 @@
 
 #include "test.h"
 
-#define STACK_SIZE 4096
-#define MAX_BULK 32
+#define STACK_SIZE 65536
+#define MAX_BULK 512
 
 static int
 test_stack_push_pop(struct rte_stack *s, void **obj_table, unsigned int bulk_sz)
@@ -81,13 +81,37 @@ test_stack_push_pop(struct rte_stack *s, void **obj_table, unsigned int bulk_sz)
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
+		/* Normal stack. */
+lifo:
+		for (i = 0; i < STACK_SIZE; i++) {
+			if (obj_table[i] != popped_objs[STACK_SIZE - i - 1]) {
+				printf("[%s():%u] Incorrect value %p at index 0x%x\n",
+				       __func__, __LINE__,
+				       popped_objs[STACK_SIZE - i - 1], i);
+				rte_free(popped_objs);
+				return -1;
+			}
+		}
+	} else {
+		/* Pile. Ordering not strictly LIFO. */
+		if (bulk_sz < RTE_STACK_PILE_BULK_SIZE)
+			goto lifo;
+		if ((bulk_sz & (RTE_STACK_PILE_BULK_SIZE - 1)) == 0) {
+			for (i = 0; i < STACK_SIZE; i += RTE_STACK_PILE_BULK_SIZE) {
+				if (memcmp(&obj_table[i],
+						&popped_objs[STACK_SIZE - RTE_STACK_PILE_BULK_SIZE -
+						i],
+						sizeof(void *) * RTE_STACK_PILE_BULK_SIZE) != 0) {
+					printf("[%s():%u] Incorrect values %p at 0x%x, bulk %u\n",
+					       __func__, __LINE__,
+					       popped_objs[STACK_SIZE - RTE_STACK_PILE_BULK_SIZE -
+					       i],
+					       i, bulk_sz);
+					rte_free(popped_objs);
+					return -1;
+				}
+			}
 		}
 	}
 
@@ -152,12 +176,24 @@ test_stack_basic(uint32_t flags)
 		goto fail_test;
 	}
 
-	ret = rte_stack_push(s, obj_table, 2 * STACK_SIZE);
+	ret = rte_stack_push(s, obj_table, STACK_SIZE);
+	if (ret == 0) {
+		printf("[%s():%u] All objects push failed\n",
+		       __func__, __LINE__);
+		goto fail_test;
+	}
+	ret = rte_stack_push(s, obj_table, STACK_SIZE);
 	if (ret != 0) {
 		printf("[%s():%u] Excess objects push succeeded\n",
 		       __func__, __LINE__);
 		goto fail_test;
 	}
+	ret = rte_stack_pop(s, obj_table, STACK_SIZE);
+	if (ret == 0) {
+		printf("[%s():%u] All objects pop failed\n",
+		       __func__, __LINE__);
+		goto fail_test;
+	}
 
 	ret = rte_stack_pop(s, obj_table, 1);
 	if (ret != 0) {
@@ -167,8 +203,12 @@ test_stack_basic(uint32_t flags)
 	}
 
 	ret = 0;
+	goto done;
 
 fail_test:
+	ret = -1;
+
+done:
 	rte_stack_free(s);
 
 	rte_free(obj_table);
@@ -384,5 +424,16 @@ test_lf_stack(void)
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
index 3f17a2606c..e46251d687 100644
--- a/app/test/test_stack_perf.c
+++ b/app/test/test_stack_perf.c
@@ -14,14 +14,14 @@
 #include "test.h"
 
 #define STACK_NAME "STACK_PERF"
-#define MAX_BURST 32
+#define MAX_BURST 512
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
index 0447cdf2ad..907140fc6a 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
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
index fdf056730c..d5a498e778 100644
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
+solo elements, and then performing two lock-free push operations,
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
+.. note::
+    The pile is designed and optimized for use with bulks of objects.
+    Bursts not a multiple of the bulk size are still handled in a lock-free,
+    forward-progress-guaranteed manner. However, pop operations may exhibit
+    significantly lower performance in instances where the optimal number of
+    bulk elements is unavailable, and it is necessary to retry (fetching
+    increasingly fewer bulk elements and correspondingly more solo elements).
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
index fd17ac791d..1c48b89f46 100644
--- a/lib/stack/rte_stack.h
+++ b/lib/stack/rte_stack.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2026 SmartShare Systems
  */
 
 /**
@@ -28,11 +29,33 @@
 #define RTE_STACK_NAMESIZE (RTE_MEMZONE_NAMESIZE - \
 			   sizeof(RTE_STACK_MZ_PREFIX) + 1)
 
+static_assert(((sizeof(void *) * RTE_STACK_PILE_BULK_SIZE) & RTE_CACHE_LINE_MASK) == 0,
+		"Pile bulk size must be divisible by CPU cache line size");
+static_assert(RTE_IS_POWER_OF_2(RTE_STACK_PILE_BULK_SIZE),
+		"Pile bulk size must be power of 2");
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
+	struct rte_stack_lf_elem elem;
+	/* The second part differs. */
+	alignas(RTE_CACHE_LINE_SIZE)
+	void *objs[RTE_STACK_PILE_BULK_SIZE];   /**< Bulk (multi-object) pointers */
+};
+
+static_assert(offsetof(struct rte_stack_pile_bulk_elem, elem) == 0,
+		"Inherited type mismatch");
+
 struct __rte_aligned(16) rte_stack_lf_head {
 	struct rte_stack_lf_elem *top; /**< Stack top */
 	uint64_t cnt; /**< Modification counter for avoiding ABA problem */
@@ -51,12 +74,36 @@ struct rte_stack_lf_list {
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
+	alignas(RTE_CACHE_LINE_SIZE) void *elems[];
+};
+
 /* Structure containing the LIFO, its current length, and a lock for mutual
  * exclusion.
  */
@@ -78,6 +125,7 @@ struct __rte_cache_aligned rte_stack {
 	uint32_t flags; /**< Flags supplied at creation. */
 	union {
 		struct rte_stack_lf stack_lf; /**< Lock-free LIFO structure. */
+		struct rte_stack_pile stack_pile; /**< Lock-free pile (LIFO-like) structure. */
 		struct rte_stack_std stack_std;	/**< LIFO structure. */
 	};
 };
@@ -88,8 +136,19 @@ struct __rte_cache_aligned rte_stack {
  */
 #define RTE_STACK_F_LF 0x0001
 
+/**
+ * The stack-like pile uses lock-free push and pop functions.
+ * It is optimized for bulks of objects, and is not strictly LIFO.
+ * This flag is only supported on x86_64 or arm64 platforms, currently.
+ *
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ */
+#define RTE_STACK_F_PILE 0x0002
+
 #include "rte_stack_std.h"
 #include "rte_stack_lf.h"
+#include "rte_stack_pile.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -115,6 +174,8 @@ rte_stack_push(struct rte_stack *s, void * const *obj_table, unsigned int n)
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_push(s, obj_table, n);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_push(s, obj_table, n);
 	else
 		return __rte_stack_std_push(s, obj_table, n);
 }
@@ -139,6 +200,8 @@ rte_stack_pop(struct rte_stack *s, void **obj_table, unsigned int n)
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_pop(s, obj_table, n);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_pop(s, obj_table, n);
 	else
 		return __rte_stack_std_pop(s, obj_table, n);
 }
@@ -158,6 +221,8 @@ rte_stack_count(struct rte_stack *s)
 
 	if (s->flags & RTE_STACK_F_LF)
 		return __rte_stack_lf_count(s);
+	else if (s->flags & RTE_STACK_F_PILE)
+		return __rte_stack_pile_count(s);
 	else
 		return __rte_stack_std_count(s);
 }
diff --git a/lib/stack/rte_stack_lf.h b/lib/stack/rte_stack_lf.h
index f2b012cd0e..e9c28a4c96 100644
--- a/lib/stack/rte_stack_lf.h
+++ b/lib/stack/rte_stack_lf.h
@@ -20,6 +20,27 @@
 #define RTE_STACK_LF_SUPPORTED
 #endif
 
+static __rte_always_inline unsigned int
+__rte_stack_lf_count(struct rte_stack *s)
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
+	return __rte_stack_lf_elems_count(&s->stack_lf.used);
+}
+
 /**
  * @internal Push several objects on the lock-free stack (MT-safe).
  *
@@ -79,6 +100,7 @@ __rte_stack_lf_pop(struct rte_stack *s, void **obj_table, unsigned int n)
 		return 0;
 
 	/* Pop n used elements */
+	__rte_assume(obj_table != NULL);
 	first = __rte_stack_lf_pop_elems(&s->stack_lf.used,
 					 n, obj_table, &last);
 	if (unlikely(first == NULL))
diff --git a/lib/stack/rte_stack_lf_c11.h b/lib/stack/rte_stack_lf_c11.h
index b97e02d6a1..1533d36fc7 100644
--- a/lib/stack/rte_stack_lf_c11.h
+++ b/lib/stack/rte_stack_lf_c11.h
@@ -36,25 +36,9 @@ rte_atomic128_cmp_exchange(rte_int128_t *dst,
 #endif /* RTE_TOOLCHAIN_MSVC */
 
 static __rte_always_inline unsigned int
-__rte_stack_lf_count(struct rte_stack *s)
+__rte_stack_lf_elems_count(struct rte_stack_lf_list *list)
 {
-	/* stack_lf_push() and stack_lf_pop() do not update the list's contents
-	 * and stack_lf->len atomically, which can cause the list to appear
-	 * shorter than it actually is if this function is called while other
-	 * threads are modifying the list.
-	 *
-	 * However, given the inherently approximate nature of the get_count
-	 * callback -- even if the list and its size were updated atomically,
-	 * the size could change between when get_count executes and when the
-	 * value is returned to the caller -- this is acceptable.
-	 *
-	 * The stack_lf->len updates are placed such that the list may appear to
-	 * have fewer elements than it does, but will never appear to have more
-	 * elements. If the mempool is near-empty to the point that this is a
-	 * concern, the user should consider increasing the mempool size.
-	 */
-	return (unsigned int)rte_atomic_load_explicit(&s->stack_lf.used.len,
-					     rte_memory_order_relaxed);
+	return (unsigned int)rte_atomic_load_explicit(&list->len, rte_memory_order_relaxed);
 }
 
 static __rte_always_inline void
diff --git a/lib/stack/rte_stack_lf_generic.h b/lib/stack/rte_stack_lf_generic.h
index cc69e4d168..4d2243b938 100644
--- a/lib/stack/rte_stack_lf_generic.h
+++ b/lib/stack/rte_stack_lf_generic.h
@@ -9,25 +9,10 @@
 #include <rte_prefetch.h>
 
 static __rte_always_inline unsigned int
-__rte_stack_lf_count(struct rte_stack *s)
+__rte_stack_lf_elems_count(struct rte_stack_lf_list *list)
 {
-	/* stack_lf_push() and stack_lf_pop() do not update the list's contents
-	 * and stack_lf->len atomically, which can cause the list to appear
-	 * shorter than it actually is if this function is called while other
-	 * threads are modifying the list.
-	 *
-	 * However, given the inherently approximate nature of the get_count
-	 * callback -- even if the list and its size were updated atomically,
-	 * the size could change between when get_count executes and when the
-	 * value is returned to the caller -- this is acceptable.
-	 *
-	 * The stack_lf->len updates are placed such that the list may appear to
-	 * have fewer elements than it does, but will never appear to have more
-	 * elements. If the mempool is near-empty to the point that this is a
-	 * concern, the user should consider increasing the mempool size.
-	 */
 	/* NOTE: review for potential ordering optimization */
-	return rte_atomic_load_explicit(&s->stack_lf.used.len, rte_memory_order_seq_cst);
+	return (unsigned int)rte_atomic_load_explicit(&list->len, rte_memory_order_seq_cst);
 }
 
 static __rte_always_inline void
diff --git a/lib/stack/rte_stack_lf_stubs.h b/lib/stack/rte_stack_lf_stubs.h
index a05abf1f1c..4384c82fb7 100644
--- a/lib/stack/rte_stack_lf_stubs.h
+++ b/lib/stack/rte_stack_lf_stubs.h
@@ -8,9 +8,9 @@
 #include <rte_common.h>
 
 static __rte_always_inline unsigned int
-__rte_stack_lf_count(struct rte_stack *s)
+__rte_stack_lf_elems_count(struct rte_stack_lf_list *list)
 {
-	RTE_SET_USED(s);
+	RTE_SET_USED(list);
 
 	return 0;
 }
diff --git a/lib/stack/rte_stack_pile.c b/lib/stack/rte_stack_pile.c
new file mode 100644
index 0000000000..5884163313
--- /dev/null
+++ b/lib/stack/rte_stack_pile.c
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 SmartShare Systems
+ */
+
+#include "rte_stack.h"
+
+void
+rte_stack_pile_init(struct rte_stack *s, unsigned int count)
+{
+	unsigned int bulk = (count + RTE_STACK_PILE_BULK_SIZE - 1) / RTE_STACK_PILE_BULK_SIZE;
+	struct rte_stack_pile_bulk_elem *bulk_elems =
+			(struct rte_stack_pile_bulk_elem *)(s->stack_pile.elems);
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
+ssize_t
+rte_stack_pile_get_memsize(unsigned int count)
+{
+	unsigned int bulk = (count + RTE_STACK_PILE_BULK_SIZE - 1) / RTE_STACK_PILE_BULK_SIZE;
+	ssize_t sz = offsetof(struct rte_stack, stack_pile.elems);
+	sz += bulk * sizeof(struct rte_stack_pile_bulk_elem);
+	sz += count * sizeof(struct rte_stack_lf_elem);
+	sz = RTE_CACHE_LINE_ROUNDUP(sz);
+	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
+
+	return sz;
+}
diff --git a/lib/stack/rte_stack_pile.h b/lib/stack/rte_stack_pile.h
new file mode 100644
index 0000000000..9766b6243b
--- /dev/null
+++ b/lib/stack/rte_stack_pile.h
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 SmartShare Systems
+ */
+
+#ifndef _RTE_STACK_PILE_H_
+#define _RTE_STACK_PILE_H_
+
+#include <rte_memcpy.h>
+
+#include "rte_stack_lf.h"
+#ifdef RTE_STACK_LF_SUPPORTED
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
+	return RTE_MIN((unsigned int)s->capacity,
+			__rte_stack_lf_elems_count(&s->stack_pile.bulk) * RTE_STACK_PILE_BULK_SIZE +
+			__rte_stack_lf_elems_count(&s->stack_pile.solo));
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
+		void **obj_table,
+		struct rte_stack_pile_bulk_elem **last)
+{
+	struct rte_stack_lf_elem *first =
+			__rte_stack_lf_pop_elems(list, num, NULL,
+			(struct rte_stack_lf_elem **)last);
+	if (first == NULL)
+		return NULL;
+
+	if (obj_table != NULL) {
+		/*
+		 * Traverse the list to copy the bulks.
+		 * Note:
+		 * Done here to minimize the time spent in the retry loop in
+		 * __rte_stack_lf_pop_elems(),
+		 * and to avoid modifying __rte_stack_lf_pop_elems().
+		 */
+		struct rte_stack_lf_elem *tmp = first;
+		for (unsigned int i = 0; i < num; i++, tmp = tmp->next)
+			rte_memcpy(&obj_table[i * RTE_STACK_PILE_BULK_SIZE],
+					((struct rte_stack_pile_bulk_elem *)tmp)->objs,
+					sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+	}
+
+	return (struct rte_stack_pile_bulk_elem *)first;
+}
+
+/**
+ * Push several objects on the pile (lock-free, MT-safe).
+ *
+ * @param s
+ *   A pointer to the stack structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to push on the pile from the obj_table.
+ * @return
+ *   Actual number of objects pushed (either 0 or *n*).
+ */
+static inline unsigned int
+__rte_stack_pile_push(struct rte_stack *s,
+		void * const *obj_table,
+		unsigned int n)
+{
+	RTE_ASSERT(s != NULL);
+	RTE_ASSERT(obj_table != NULL);
+
+	struct rte_stack_pile *pile = &s->stack_pile;
+	struct rte_stack_pile_bulk_elem *bulk_first = NULL, *bulk_last = NULL;
+	struct rte_stack_lf_elem *solo_first = NULL, *solo_last = NULL;
+	struct rte_stack_lf_elem *tmp;
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
+	 * Copy objects in reverse order.
+	 */
+	tmp = solo_first;
+	__rte_assume(n_solo > 0);
+	__rte_assume(n_solo < RTE_STACK_PILE_BULK_SIZE);
+	for (i = 0; i < n_solo; i++, tmp = tmp->next)
+		tmp->data = obj_table[n_bulk * RTE_STACK_PILE_BULK_SIZE + n_solo - i - 1];
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
+	tmp = (struct rte_stack_lf_elem *)bulk_first;
+	__rte_assume(n_bulk > 0);
+	for (i = 0; i < n_bulk; i++, tmp = tmp->next)
+		rte_memcpy(((struct rte_stack_pile_bulk_elem *)tmp)->objs,
+				&obj_table[(n_bulk - i - 1) * RTE_STACK_PILE_BULK_SIZE],
+				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+
+	/* Push them to the bulk list. */
+	__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, n_bulk);
+
+	return n;
+}
+
+/**
+ * @internal Pop objects from the pile using fragmentation of a bulk element.
+ *
+ * @param pile
+ *   A pointer to the pile structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to pull.
+ *   Must be non-zero and less than RTE_STACK_PILE_BULK_SIZE.
+ * @return
+ *   Actual number of objects popped (either 0 or *n*).
+ */
+static inline unsigned int
+__rte_stack_pile_pop_frag(struct rte_stack_pile * const pile,
+		void **obj_table,
+		unsigned int n)
+{
+	alignas(RTE_CACHE_LINE_SIZE) void *obj_frag[RTE_STACK_PILE_BULK_SIZE];
+	struct rte_stack_pile_bulk_elem *frag = NULL;
+	struct rte_stack_lf_elem *solo_first = NULL, *solo_last = NULL, *tmp;
+	unsigned int i;
+
+	RTE_ASSERT(n > 0);
+	RTE_ASSERT(n < RTE_STACK_PILE_BULK_SIZE);
+
+	/* Fetch a bulk element for fragmentation. */
+	frag = __rte_stack_pile_bulk_pop_elems(&pile->bulk, 1, obj_frag, NULL);
+	if (unlikely(frag == NULL))
+		return 0; /* Not available. */
+
+	/* Get n objects from the bulk element. */
+	__rte_assume(n > 0);
+	__rte_assume(n < RTE_STACK_PILE_BULK_SIZE);
+	for (i = 0; i < n; i++)
+		obj_table[i] = obj_frag[i];
+
+	/* Fetch free solo elements for the excess objects. */
+	__rte_assume(RTE_STACK_PILE_BULK_SIZE - n > 0);
+	__rte_assume(RTE_STACK_PILE_BULK_SIZE - n < RTE_STACK_PILE_BULK_SIZE);
+	solo_first = __rte_stack_lf_pop_elems(&pile->free_solo,
+			RTE_STACK_PILE_BULK_SIZE - n, NULL, &solo_last);
+	if (unlikely(solo_first == NULL)) {
+		/*
+		 * Failed. Roll back.
+		 * No further action is required to roll the bulk element
+		 * back into the pile of bulk elements, as the objects in
+		 * the bulk element are intact.
+		 */
+		__rte_stack_pile_bulk_push_elems(&pile->bulk, frag, frag, 1);
+		return 0;
+	}
+
+	/* Construct the solo elements from the excess objects. */
+	tmp = solo_first;
+	__rte_assume(n > 0);
+	__rte_assume(n < RTE_STACK_PILE_BULK_SIZE);
+	for (i = n; i < RTE_STACK_PILE_BULK_SIZE; i++, tmp = tmp->next)
+		tmp->data = obj_frag[i];
+
+	/* Push the excess objects as solo elements. */
+	__rte_stack_lf_push_elems(&pile->solo, solo_first, solo_last,
+			RTE_STACK_PILE_BULK_SIZE - n);
+
+	/* Free the bulk element. */
+	__rte_stack_pile_bulk_push_elems(&pile->free_bulk, frag, frag, 1);
+
+	return n;
+}
+
+/**
+ * Pop several objects from the pile (lock-free, MT-safe).
+ *
+ * @param s
+ *   A pointer to the stack structure.
+ * @param obj_table
+ *   A pointer to a table of void * pointers (objects).
+ * @param n
+ *   The number of objects to pull from the pile.
+ * @return
+ *   Actual number of objects popped (either 0 or *n*).
+ */
+static inline unsigned int
+__rte_stack_pile_pop(struct rte_stack *s,
+		void **obj_table,
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
+		 * Determine how many are available, and retry with fewer than before.
+		 * Remaining objects are to be fetched as solo elements instead.
+		 * TODO: Retry could be avoided if pop_elems() had a burst variant.
+		 */
+		unsigned int delta_bulk = n_bulk - __rte_stack_lf_elems_count(&pile->bulk);
+
+		if (unlikely((int)delta_bulk <= 0)) {
+			/*
+			 * Another thread raced to add bulk elements; more are available now.
+			 * Retry with one less than before.
+			 * Note: By only retrying with fewer, progress is guaranteed.
+			 */
+			delta_bulk = 1;
+		}
+		n_bulk -= delta_bulk;
+		n_solo += RTE_STACK_PILE_BULK_SIZE * delta_bulk;
+
+		if (n_bulk == 0)
+			goto solo; /* No bulk elements available. Stop retrying. */
+
+		goto bulk;
+	}
+
+	obj_table += n_bulk * RTE_STACK_PILE_BULK_SIZE;
+
+	if (likely(n_solo == 0))
+		goto done;
+
+solo:
+	/* Fetch n_solo objects as solo elements. */
+	solo_first = __rte_stack_lf_pop_elems(&pile->solo, n_solo,
+			obj_table, &solo_last);
+	if (solo_first != NULL)
+		goto done;
+
+	/* Solo elements not available. Try fetching objects by fragmentation of a bulk element. */
+	if (unlikely(n_solo >= RTE_STACK_PILE_BULK_SIZE))
+		goto fail; /* Ran out of bulk elements above. Don't try to fetch one more. */
+
+	if (unlikely(__rte_stack_pile_pop_frag(pile, obj_table, n_solo) == 0))
+		goto fail; /* Fragmentation failed. */
+
+done:
+	/* Success. Free the elements. */
+	if (bulk_first != NULL)
+		__rte_stack_pile_bulk_push_elems(&pile->free_bulk, bulk_first, bulk_last, n_bulk);
+	if (solo_first != NULL)
+		__rte_stack_lf_push_elems(&pile->free_solo, solo_first, solo_last, n_solo);
+
+	return n;
+
+fail:
+	/* Failed. Roll back. */
+	if (bulk_first != NULL)
+		__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, n_bulk);
+
+	return 0;
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
+ssize_t
+rte_stack_pile_get_memsize(unsigned int count);
+
+#endif /* _RTE_STACK_PILE_H_ */
-- 
2.43.0

