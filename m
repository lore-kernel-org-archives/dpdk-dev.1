Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56092606C83D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pog7cThh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F4E4111B;
	Tue,  3 Nov 2026 15:53:23 +0100 (CET)
Received: from mta1.migadu.com (out-95.mta1.migadu.com [95.215.58.95])
 by mails.dpdk.org (Postfix) with ESMTPS id B62234042F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:22 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Ob8NNTXHtWG1/kpkwoK4Vm5/5hLLKUl7R0Yl+NrJU6Y=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717602; v=1; x=1794322402;
 b=Pog7cThhLxSijOABhQKDYb2Wm7tRRjHrGFoACWlmdQq/zerAQrNB0fNf5wxWa/pLOm6L7gbV
 dVeJ4rXo/nIZEcten58WOZBPoT3FgMA3u1PWFlvXfj0QB+AwwkyAI7mHNlufI/MieuOa3jHhR07
 WFEJnOXiVqJGFinDE5SNOEMo=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id c0b3751c12765671;
 Tue, 03 Nov 2026 14:53:21 +0000
X-Mizu-Trace-ID: c0b3751c12765671
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 001/227] eal: add NUMA-aware APIs
Date: Tue,  3 Nov 2026 22:49:19 +0800
Message-ID: <20261103145306.487255-2-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,WEIRD_QUOTING autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

DPDK has long used socket_id terminology for NUMA allocation,
which conflates CPU sockets with NUMA memory nodes.

Add NUMA-named APIs while keeping the legacy socket-named ones
as functional aliases (to be deprecated once the in-tree
migration completes):

- rte_numa_id(), rte_numa_count(), rte_numa_id_by_idx()
- rte_lcore_to_numa_id()
- rte_cpu_numa_id() (renamed from experimental rte_cpu_socket_id())
- rte_malloc_numa(), rte_zmalloc_numa(), rte_calloc_numa(),
  rte_realloc_numa()
- rte_malloc_get_numa_stats() and struct rte_malloc_numa_stats
- rte_malloc_heap_get_numa_id(), rte_malloc_heap_numa_is_external()
- RTE_NUMA_ID_ANY constant (legacy SOCKET_ID_ANY kept as alias)

Convert EAL internals, comments, log messages and telemetry keys
to the NUMA node terminology, and update the EAL programmer guide
accordingly.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-flow-perf/main.c                     |   4 +-
 app/test-pmd/cmdline.c                        |   4 +-
 app/test-pmd/testpmd.c                        |   4 +-
 app/test/test_external_mem.c                  |   6 +-
 app/test/test_malloc.c                        |  22 +-
 app/test/test_memzone.c                       |   4 +-
 .../prog_guide/env_abstraction_layer.rst      |  32 +--
 doc/guides/rel_notes/release_26_11.rst        |  16 +-
 lib/eal/common/eal_common_dynmem.c            | 172 +++++++--------
 lib/eal/common/eal_common_lcore.c             |  85 +++++---
 lib/eal/common/eal_common_memalloc.c          |  38 ++--
 lib/eal/common/eal_common_memory.c            |  44 ++--
 lib/eal/common/eal_common_memzone.c           |  34 +--
 lib/eal/common/eal_common_options.c           |  12 +-
 lib/eal/common/eal_common_thread.c            |  34 +--
 lib/eal/common/eal_hugepages.h                |   2 +-
 lib/eal/common/eal_internal_cfg.h             |   2 +-
 lib/eal/common/eal_memalloc.h                 |  10 +-
 lib/eal/common/eal_memcfg.h                   |   2 +-
 lib/eal/common/eal_private.h                  |  12 +-
 lib/eal/common/eal_thread.h                   |   6 +-
 lib/eal/common/malloc_heap.c                  | 200 +++++++++--------
 lib/eal/common/malloc_heap.h                  |  12 +-
 lib/eal/common/malloc_mp.c                    |  10 +-
 lib/eal/common/malloc_mp.h                    |   4 +-
 lib/eal/common/rte_malloc.c                   | 156 +++++++++-----
 lib/eal/freebsd/eal.c                         |  12 +-
 lib/eal/freebsd/eal_lcore.c                   |   2 +-
 lib/eal/freebsd/eal_memalloc.c                |   4 +-
 lib/eal/freebsd/eal_memory.c                  |   2 +-
 lib/eal/include/eal_trace_internal.h          |  16 +-
 lib/eal/include/rte_lcore.h                   |  66 +++++-
 lib/eal/include/rte_malloc.h                  | 201 ++++++++++++++++--
 lib/eal/include/rte_memory.h                  |   8 +-
 lib/eal/include/rte_memzone.h                 |  12 +-
 lib/eal/linux/eal.c                           |  16 +-
 lib/eal/linux/eal_hugepage_info.c             |  40 ++--
 lib/eal/linux/eal_lcore.c                     |   2 +-
 lib/eal/linux/eal_memalloc.c                  |  38 ++--
 lib/eal/linux/eal_memory.c                    |  76 +++----
 lib/eal/windows/eal_hugepages.c               |  12 +-
 lib/eal/windows/eal_lcore.c                   |  42 ++--
 lib/eal/windows/eal_memalloc.c                |  38 ++--
 lib/eal/windows/eal_memory.c                  |  10 +-
 lib/eal/windows/eal_windows.h                 |  18 +-
 45 files changed, 927 insertions(+), 615 deletions(-)

diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 6636d1517f..db7269315c 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -1006,7 +1006,7 @@ args_parse(int argc, char **argv)
 static size_t
 dump_socket_mem(FILE *f)
 {
-	struct rte_malloc_socket_stats socket_stats;
+	struct rte_malloc_numa_stats socket_stats;
 	unsigned int i = 0;
 	size_t total = 0;
 	size_t alloc = 0;
@@ -1017,7 +1017,7 @@ dump_socket_mem(FILE *f)
 
 
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
-		if (rte_malloc_get_socket_stats(i, &socket_stats) ||
+		if (rte_malloc_get_numa_stats(i, &socket_stats) ||
 		    !socket_stats.heap_totalsz_bytes)
 			continue;
 		active_nodes = true;
diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 51078a2a73..cdf73540ec 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -9367,7 +9367,7 @@ dump_struct_sizes(void)
 static void
 dump_socket_mem(FILE *f)
 {
-	struct rte_malloc_socket_stats socket_stats;
+	struct rte_malloc_numa_stats socket_stats;
 	unsigned int i;
 	size_t total = 0;
 	size_t alloc = 0;
@@ -9378,7 +9378,7 @@ dump_socket_mem(FILE *f)
 	static size_t last_total;
 
 	for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
-		if (rte_malloc_get_socket_stats(i, &socket_stats) ||
+		if (rte_malloc_get_numa_stats(i, &socket_stats) ||
 		    !socket_stats.heap_totalsz_bytes)
 			continue;
 		total += socket_stats.heap_totalsz_bytes;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index d6211a9a8a..c99b54a003 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1086,7 +1086,7 @@ setup_extmem(uint32_t nb_mbufs, uint32_t mbuf_sz, bool huge)
 	memset(&param, 0, sizeof(param));
 
 	/* check if our heap exists */
-	socket_id = rte_malloc_heap_get_socket(EXTMEM_HEAP_NAME);
+	socket_id = rte_malloc_heap_get_numa_id(EXTMEM_HEAP_NAME);
 	if (socket_id < 0) {
 		/* create our heap */
 		ret = rte_malloc_heap_create(EXTMEM_HEAP_NAME);
@@ -1327,7 +1327,7 @@ mbuf_pool_create(uint16_t mbuf_seg_size, unsigned nb_mbuf,
 				rte_exit(EXIT_FAILURE, "Could not create external memory\n");
 
 			heap_socket =
-				rte_malloc_heap_get_socket(EXTMEM_HEAP_NAME);
+				rte_malloc_heap_get_numa_id(EXTMEM_HEAP_NAME);
 			if (heap_socket < 0)
 				rte_exit(EXIT_FAILURE, "Could not get external memory socket ID\n");
 
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 2c8d0d8e00..8e6313f4e9 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -103,7 +103,7 @@ test_malloc_invalid_param(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 			goto fail;
 		}
 
-		if (rte_malloc_heap_get_socket(name) >= 0 ||
+		if (rte_malloc_heap_get_numa_id(name) >= 0 ||
 				rte_errno != EINVAL) {
 			printf("%s():%i: Found socket for heap with invalid name\n",
 					__func__, __LINE__);
@@ -145,7 +145,7 @@ test_malloc_invalid_param(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 			__func__, __LINE__);
 		goto fail;
 	}
-	if (rte_malloc_heap_get_socket(valid_name) >= 0 ||
+	if (rte_malloc_heap_get_numa_id(valid_name) >= 0 ||
 			rte_errno != ENOENT) {
 		printf("%s():%i: Found socket for heap with invalid name\n",
 				__func__, __LINE__);
@@ -296,7 +296,7 @@ test_malloc_basic(void *addr, size_t len, size_t pgsz, rte_iova_t *iova,
 	}
 
 	/* get socket ID corresponding to this heap */
-	socket_id = rte_malloc_heap_get_socket(heap_name);
+	socket_id = rte_malloc_heap_get_numa_id(heap_name);
 	if (socket_id < 0) {
 		printf("%s():%i: cannot find socket for external heap\n",
 			__func__, __LINE__);
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 151d1a3f2c..3674dc3f7f 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -278,7 +278,7 @@ test_multi_alloc_statistics(void)
 {
 	int ret = -1;  /* default return is error, cleared at end on success */
 	int socket = 0;
-	struct rte_malloc_socket_stats pre_stats, post_stats ,first_stats, second_stats;
+	struct rte_malloc_numa_stats pre_stats, post_stats, first_stats, second_stats;
 	size_t size = 2048;
 	int align = 1024;
 	int overhead = 0;
@@ -313,7 +313,7 @@ test_multi_alloc_statistics(void)
 		printf("Failed to add memory to heap\n");
 		goto cleanup_allocated_memory;
 	}
-	socket = rte_malloc_heap_get_socket(__func__);
+	socket = rte_malloc_heap_get_numa_id(__func__);
 	if (socket < 0) {
 		printf("Failed to get socket for test malloc heap.\n");
 		goto cleanup_all;
@@ -322,13 +322,13 @@ test_multi_alloc_statistics(void)
 	/* Dynamically calculate the overhead by allocating one cacheline and
 	 * then comparing what was allocated from the heap.
 	 */
-	rte_malloc_get_socket_stats(socket, &pre_stats);
+	rte_malloc_get_numa_stats(socket, &pre_stats);
 
 	void *dummy = rte_malloc_socket(NULL, RTE_CACHE_LINE_SIZE, 0, socket);
 	if (dummy == NULL)
 		goto cleanup_all;
 
-	rte_malloc_get_socket_stats(socket, &post_stats);
+	rte_malloc_get_numa_stats(socket, &post_stats);
 
 	/* after subtracting cache line, remainder is overhead */
 	overhead = post_stats.heap_allocsz_bytes - pre_stats.heap_allocsz_bytes;
@@ -337,7 +337,7 @@ test_multi_alloc_statistics(void)
 	rte_free(dummy);
 
 	/* Now start the real tests */
-	rte_malloc_get_socket_stats(socket, &pre_stats);
+	rte_malloc_get_numa_stats(socket, &pre_stats);
 
 	void *p1 = rte_malloc_socket("stats", size , align, socket);
 	if (!p1)
@@ -346,7 +346,7 @@ test_multi_alloc_statistics(void)
 	rte_free(p1);
 	rte_malloc_dump_stats(stdout, "stats");
 
-	rte_malloc_get_socket_stats(socket,&post_stats);
+	rte_malloc_get_numa_stats(socket, &post_stats);
 	/* Check statistics reported are correct */
 	/* All post stats should be equal to pre stats after alloc freed */
 	if ((post_stats.heap_totalsz_bytes != pre_stats.heap_totalsz_bytes) ||
@@ -360,23 +360,23 @@ test_multi_alloc_statistics(void)
 	/* Check two consecutive allocations */
 	size = 1024;
 	align = 0;
-	rte_malloc_get_socket_stats(socket,&pre_stats);
+	rte_malloc_get_numa_stats(socket, &pre_stats);
 	void *p2 = rte_malloc_socket("add", size ,align, socket);
 	if (!p2)
 		goto cleanup_all;
-	rte_malloc_get_socket_stats(socket,&first_stats);
+	rte_malloc_get_numa_stats(socket, &first_stats);
 
 	void *p3 = rte_malloc_socket("add2", size,align, socket);
 	if (!p3)
 		goto cleanup_all;
 
-	rte_malloc_get_socket_stats(socket,&second_stats);
+	rte_malloc_get_numa_stats(socket, &second_stats);
 
 	rte_free(p2);
 	rte_free(p3);
 
 	/* After freeing both allocations check stats return to original */
-	rte_malloc_get_socket_stats(socket, &post_stats);
+	rte_malloc_get_numa_stats(socket, &post_stats);
 
 	if(second_stats.heap_totalsz_bytes != first_stats.heap_totalsz_bytes) {
 		printf("Incorrect heap statistics: Total size \n");
@@ -704,7 +704,7 @@ test_realloc(void)
 		ret = -1;
 		goto end;
 	}
-	realloc_heap_socket = rte_malloc_heap_get_socket(heap_name);
+	realloc_heap_socket = rte_malloc_heap_get_numa_id(heap_name);
 
 	mem = mmap(NULL, mem_sz, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 8712690561..1b6555df55 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -493,10 +493,10 @@ test_memzone_reserve_flags(void)
 static size_t
 find_max_block_free_size(unsigned int align, unsigned int socket_id)
 {
-	struct rte_malloc_socket_stats stats;
+	struct rte_malloc_numa_stats stats;
 	size_t len, overhead;
 
-	if (rte_malloc_get_socket_stats(socket_id, &stats) < 0)
+	if (rte_malloc_get_numa_stats(socket_id, &stats) < 0)
 		return 0;
 
 	len = stats.greatest_free_size;
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index 2f13ee846e..4119a0ebd5 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -374,10 +374,10 @@ manual memory management.
 
 Using a set of malloc heap API's is the recommended way to use externally
 allocated memory in DPDK. In this way, support for externally allocated memory
-is implemented through overloading the socket ID - externally allocated heaps
-will have socket ID's that would be considered invalid under normal
+is implemented through overloading the NUMA node ID - externally allocated heaps
+will have NUMA node IDs that would be considered invalid under normal
 circumstances. Requesting an allocation to take place from a specified
-externally allocated memory is a matter of supplying the correct socket ID to
+externally allocated memory is a matter of supplying the correct NUMA node ID to
 DPDK allocator, either directly (e.g. through a call to ``rte_malloc``) or
 indirectly (through data structure-specific allocation API's such as
 ``rte_ring_create``). Using these API's also ensures that mapping of externally
@@ -399,12 +399,12 @@ The expected workflow is as follows:
     - If IOVA table is not specified, IOVA addresses will be assumed to be
       unavailable, and DMA mappings will not be performed
     - Other processes must attach to the memory area before they can use it
-* Get socket ID used for the heap
-* Use normal DPDK allocation procedures, using supplied socket ID
+* Get NUMA node ID used for the heap
+* Use normal DPDK allocation procedures, using supplied NUMA node ID
 * If memory area is no longer needed, it can be removed from the heap
     - Other processes must detach from this memory area before it can be removed
 * If heap is no longer needed, remove it
-    - Socket ID will become invalid and will not be reused
+    - NUMA node ID will become invalid and will not be reused
 
 For more information, please refer to ``rte_malloc`` API documentation,
 specifically the ``rte_malloc_heap_*`` family of function calls.
@@ -790,11 +790,11 @@ Public Thread API
 There are two public APIs ``rte_thread_set_affinity()`` and ``rte_thread_get_affinity()`` introduced for threads.
 When they're used in any pthread context, the Thread Local Storage(TLS) will be set/get.
 
-Those TLS include *_cpuset* and *_socket_id*:
+Those TLS include *_cpuset* and *_numa_id*:
 
 *	*_cpuset* stores the CPUs bitmap to which the pthread is affinitized.
 
-*	*_socket_id* stores the NUMA node of the CPU set. If the CPUs in CPU set belong to different NUMA node, the *_socket_id* will be set to SOCKET_ID_ANY.
+*	*_numa_id* stores the NUMA node of the CPU set. If the CPUs in CPU set belong to different NUMA node, the *_numa_id* will be set to RTE_NUMA_ID_ANY.
 
 
 Control Thread API
@@ -948,16 +948,16 @@ Signal Safety
    rte_lcore_index
    rte_lcore_is_enabled
    rte_lcore_to_cpu_id
-   rte_lcore_to_socket_id
+   rte_lcore_to_numa_id
    rte_log_get_global_level
    rte_log_get_level
    rte_memory_get_nchannel
    rte_memory_get_nrank
+   rte_numa_count
+   rte_numa_id
+   rte_numa_id_by_idx
    rte_reciprocal_value
    rte_reciprocal_value_u64
-   rte_socket_count
-   rte_socket_id
-   rte_socket_id_by_idx
    rte_strerror
    rte_strscpy
    rte_strsplit
@@ -1018,9 +1018,9 @@ The rte_malloc() takes an align argument that can be used to request a memory
 area that is aligned on a multiple of this value (which must be a power of two).
 
 On systems with NUMA support, a call to the rte_malloc() function will return
-memory that has been allocated on the NUMA socket of the core which made the call.
+memory that has been allocated on the NUMA node of the core which made the call.
 A set of APIs is also provided, to allow memory to be explicitly allocated on a
-NUMA socket directly, or by allocated on the NUMA socket where another core is
+NUMA node directly, or by allocated on the NUMA node where another core is
 located, in the case where the memory is to be used by a logical core other than
 on the one doing the memory allocation.
 
@@ -1041,7 +1041,7 @@ Data Structures
 
 There are two data structure types used internally in the malloc library:
 
-*   struct malloc_heap - used to track free space on a per-socket basis
+*   struct malloc_heap - used to track free space on a per-NUMA-node basis
 
 *   struct malloc_elem - the basic element of allocation and free-space
     tracking inside the library.
@@ -1049,7 +1049,7 @@ There are two data structure types used internally in the malloc library:
 Structure: malloc_heap
 """"""""""""""""""""""
 
-The malloc_heap structure is used to manage free space on a per-socket basis.
+The malloc_heap structure is used to manage free space on a per-NUMA-node basis.
 Internally, there is one heap structure per NUMA node, which allows us to
 allocate memory to a thread based on the NUMA node on which this thread runs.
 While this does not guarantee that the memory will be used on that NUMA node,
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..0298d7bb36 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,10 +68,20 @@ New Features
   and use pointer arithmetic instead of integer casts to enable compiler optimizations.
   See API changes below.
 
-* **Added API to get CPU socket ID.**
+* **Added NUMA-aware APIs.**
 
-  Added the experimental ``rte_cpu_socket_id()`` function
-  to map an OS logical CPU ID to the NUMA socket containing that CPU.
+  Introduced NUMA terminology APIs to replace the socket-named ones:
+  ``rte_numa_id()``, ``rte_numa_count()``, ``rte_numa_id_by_idx()``,
+  ``rte_lcore_to_numa_id()``, the experimental ``rte_cpu_numa_id()``,
+  ``rte_malloc_numa()`` with the ``rte_zmalloc_numa()``,
+  ``rte_calloc_numa()`` and ``rte_realloc_numa()`` variants,
+  and the ``RTE_NUMA_ID_ANY`` constant.
+  The legacy socket-named APIs are kept as aliases pending deprecation.
+
+* **Added API to get CPU NUMA node ID.**
+
+  Added the experimental ``rte_cpu_numa_id()`` function
+  to map an OS logical CPU ID to the NUMA node containing that CPU.
 
 * **Added pile stack and mempool driver.**
 
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 868d274dc0..56fa190280 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -23,7 +23,7 @@ eal_dynmem_memseg_lists_init(void)
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct memtype {
 		uint64_t page_sz;
-		int socket_id;
+		int numa_id;
 		unsigned int hpi_idx;
 		unsigned int n_segs;
 		size_t mem_sz;
@@ -45,7 +45,7 @@ eal_dynmem_memseg_lists_init(void)
 	 * figuring out amount of memory we're going to have is a long and very
 	 * involved process. the basic element we're operating with is a memory
 	 * type, defined as a combination of NUMA node ID and page size (so that
-	 * e.g. 2 sockets with 2 page sizes yield 4 memory types in total).
+	 * e.g. 2 NUMA nodes with 2 page sizes yield 4 memory types in total).
 	 *
 	 * deciding amount of memory going towards each memory type is a
 	 * balancing act between maximum segments per type, maximum memory per
@@ -57,7 +57,7 @@ eal_dynmem_memseg_lists_init(void)
 	 */
 
 	/* maximum number of memtypes we're ever going to get */
-	n_memtypes = internal_conf->num_hugepage_sizes * rte_socket_count();
+	n_memtypes = internal_conf->num_hugepage_sizes * rte_numa_count();
 
 	/* can we fit all memtypes into the memseg lists? */
 	if (n_memtypes > RTE_MAX_MEMSEG_LISTS) {
@@ -76,21 +76,21 @@ eal_dynmem_memseg_lists_init(void)
 		hpi = &internal_conf->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
 
-		for (i = 0; i < (int) rte_socket_count(); i++, cur_type++) {
-			int socket_id = rte_socket_id_by_idx(i);
+		for (i = 0; i < (int) rte_numa_count(); i++, cur_type++) {
+			int numa_id = rte_numa_id_by_idx(i);
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
-			/* we can still sort pages by socket in legacy mode */
-			if (!internal_conf->legacy_mem && socket_id > 0)
+			/* we can still sort pages by NUMA node in legacy mode */
+			if (!internal_conf->legacy_mem && numa_id > 0)
 				break;
 #endif
 			memtypes[cur_type].page_sz = hugepage_sz;
-			memtypes[cur_type].socket_id = socket_id;
+			memtypes[cur_type].numa_id = numa_id;
 			memtypes[cur_type].hpi_idx = hpi_idx;
 
 			EAL_LOG(DEBUG, "Detected memory type: "
-				"socket_id:%u hugepage_sz:%" PRIu64,
-				socket_id, hugepage_sz);
+				"numa_id:%u hugepage_sz:%" PRIu64,
+				numa_id, hugepage_sz);
 		}
 	}
 	/* number of memtypes could have been lower due to no NUMA support */
@@ -144,21 +144,21 @@ eal_dynmem_memseg_lists_init(void)
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
 		struct memtype *type = &memtypes[cur_type];
 		uint64_t pagesz;
-		int socket_id;
+		int numa_id;
 
 		/* skip page sizes with zero memory limit */
 		if (type->n_segs == 0)
 			continue;
 
 		pagesz = type->page_sz;
-		socket_id = type->socket_id;
+		numa_id = type->numa_id;
 
-		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
-			type->n_segs, socket_id, pagesz);
+		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u numa_id:%i hugepage_sz:%" PRIu64,
+			type->n_segs, numa_id, pagesz);
 
 		msl = &mcfg->memsegs[msl_idx];
 
-		if (eal_memseg_list_init(msl, pagesz, type->n_segs, socket_id, msl_idx, true))
+		if (eal_memseg_list_init(msl, pagesz, type->n_segs, numa_id, msl_idx, true))
 			goto out;
 
 		if (eal_memseg_list_assign(msl,
@@ -196,9 +196,9 @@ hugepage_count_walk(const struct rte_memseg_list *msl, void *arg)
 }
 
 static int
-limits_callback(int socket_id, size_t cur_limit, size_t new_len)
+limits_callback(int numa_id, size_t cur_limit, size_t new_len)
 {
-	RTE_SET_USED(socket_id);
+	RTE_SET_USED(numa_id);
 	RTE_SET_USED(cur_limit);
 	RTE_SET_USED(new_len);
 	return -1;
@@ -209,7 +209,7 @@ eal_dynmem_hugepage_init(void)
 {
 	struct hugepage_info used_hp[MAX_HUGEPAGE_SIZES];
 	uint64_t memory[RTE_MAX_NUMA_NODES];
-	int hp_sz_idx, socket_id;
+	int hp_sz_idx, numa_id;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -228,7 +228,7 @@ eal_dynmem_hugepage_init(void)
 		used_hp[hp_sz_idx].hugepage_sz = hpi->hugepage_sz;
 
 #ifndef RTE_ARCH_64
-		/* for 32-bit, limit number of pages on socket to whatever we've
+		/* for 32-bit, limit number of pages on NUMA node to whatever we've
 		 * preallocated, as we cannot allocate more.
 		 */
 		memset(&dummy, 0, sizeof(dummy));
@@ -251,7 +251,7 @@ eal_dynmem_hugepage_init(void)
 		memory[hp_sz_idx] = internal_conf->numa_mem[hp_sz_idx];
 
 	/* calculate final number of pages */
-	if (eal_dynmem_calc_num_pages_per_socket(memory,
+	if (eal_dynmem_calc_num_pages_per_numa_node(memory,
 			internal_conf->hugepage_info, used_hp,
 			internal_conf->num_hugepage_sizes) < 0)
 		return -1;
@@ -259,11 +259,11 @@ eal_dynmem_hugepage_init(void)
 	for (hp_sz_idx = 0;
 			hp_sz_idx < (int)internal_conf->num_hugepage_sizes;
 			hp_sz_idx++) {
-		for (socket_id = 0; socket_id < RTE_MAX_NUMA_NODES;
-				socket_id++) {
+		for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES;
+				numa_id++) {
 			struct rte_memseg **pages;
 			struct hugepage_info *hpi = &used_hp[hp_sz_idx];
-			unsigned int num_pages = hpi->num_pages[socket_id];
+			unsigned int num_pages = hpi->num_pages[numa_id];
 			unsigned int num_pages_alloc;
 
 			if (num_pages == 0)
@@ -271,8 +271,8 @@ eal_dynmem_hugepage_init(void)
 
 			EAL_LOG(DEBUG,
 				"Allocating %u pages of size %" PRIu64 "M "
-				"on socket %i",
-				num_pages, hpi->hugepage_sz >> 20, socket_id);
+				"on NUMA node %i",
+				num_pages, hpi->hugepage_sz >> 20, numa_id);
 
 			/* we may not be able to allocate all pages in one go,
 			 * because we break up our memory map into multiple
@@ -296,7 +296,7 @@ eal_dynmem_hugepage_init(void)
 				/* do not request exact number of pages */
 				cur_pages = eal_memalloc_alloc_seg_bulk(pages,
 						needed, hpi->hugepage_sz,
-						socket_id, false);
+						numa_id, false);
 				if (cur_pages <= 0) {
 					free(pages);
 					return -1;
@@ -315,16 +315,16 @@ eal_dynmem_hugepage_init(void)
 		}
 	}
 
-	/* if socket limits were specified, set them */
+	/* if NUMA node limits were specified, set them */
 	if (internal_conf->force_numa_limits) {
 		unsigned int i;
 		for (i = 0; i < RTE_MAX_NUMA_NODES; i++) {
 			uint64_t limit = internal_conf->numa_limit[i];
 			if (limit == 0)
 				continue;
-			if (rte_mem_alloc_validator_register("socket-limit",
+			if (rte_mem_alloc_validator_register("numa-limit",
 					limits_callback, i, limit))
-				EAL_LOG(ERR, "Failed to register socket limits validator callback");
+				EAL_LOG(ERR, "Failed to register NUMA node limits validator callback");
 		}
 	}
 	return 0;
@@ -332,7 +332,7 @@ eal_dynmem_hugepage_init(void)
 
 __rte_unused /* function is unused on 32-bit builds */
 static inline uint64_t
-get_socket_mem_size(int socket)
+get_numa_node_mem_size(int numa_id)
 {
 	uint64_t size = 0;
 	unsigned int i;
@@ -341,18 +341,18 @@ get_socket_mem_size(int socket)
 
 	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
 		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
-		size += hpi->hugepage_sz * hpi->num_pages[socket];
+		size += hpi->hugepage_sz * hpi->num_pages[numa_id];
 	}
 
 	return size;
 }
 
 int
-eal_dynmem_calc_num_pages_per_socket(
+eal_dynmem_calc_num_pages_per_numa_node(
 	uint64_t *memory, struct hugepage_info *hp_info,
 	struct hugepage_info *hp_used, unsigned int num_hp_info)
 {
-	unsigned int socket, j, i = 0;
+	unsigned int numa_id, j, i = 0;
 	unsigned int requested, available;
 	int total_num_pages = 0;
 	uint64_t remaining_mem, cur_mem;
@@ -363,107 +363,107 @@ eal_dynmem_calc_num_pages_per_socket(
 	if (num_hp_info == 0)
 		return -1;
 
-	/* if specific memory amounts per socket weren't requested */
+	/* if specific memory amounts per numa_id weren't requested */
 	if (internal_conf->force_numa == 0) {
 		size_t total_size;
 #ifdef RTE_ARCH_64
-		int cpu_per_socket[RTE_MAX_NUMA_NODES];
+		int cpu_per_numa_node[RTE_MAX_NUMA_NODES];
 		size_t default_size;
 		unsigned int lcore_id;
 
-		/* Compute number of cores per socket */
-		memset(cpu_per_socket, 0, sizeof(cpu_per_socket));
+		/* Compute number of cores per NUMA node */
+		memset(cpu_per_numa_node, 0, sizeof(cpu_per_numa_node));
 		RTE_LCORE_FOREACH(lcore_id) {
-			cpu_per_socket[rte_lcore_to_socket_id(lcore_id)]++;
+			cpu_per_numa_node[rte_lcore_to_numa_id(lcore_id)]++;
 		}
 
 		/*
 		 * Automatically spread requested memory amongst detected
-		 * sockets according to number of cores from CPU mask present
-		 * on each socket.
+		 * NUMA nodes according to number of cores from CPU mask present
+		 * on each NUMA node.
 		 */
 		total_size = internal_conf->memory;
-		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
-				socket++) {
+		for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES && total_size != 0;
+				numa_id++) {
 
-			/* Set memory amount per socket */
+			/* Set memory amount per NUMA node */
 			default_size = internal_conf->memory *
-				cpu_per_socket[socket] / rte_lcore_count();
+				cpu_per_numa_node[numa_id] / rte_lcore_count();
 
-			/* Limit to maximum available memory on socket */
+			/* Limit to maximum available memory on NUMA node */
 			default_size = RTE_MIN(
-				default_size, get_socket_mem_size(socket));
+				default_size, get_numa_node_mem_size(numa_id));
 
 			/* Update sizes */
-			memory[socket] = default_size;
+			memory[numa_id] = default_size;
 			total_size -= default_size;
 		}
 
 		/*
 		 * If some memory is remaining, try to allocate it by getting
-		 * all available memory from sockets, one after the other.
+		 * all available memory from NUMA nodes, one after the other.
 		 */
-		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
-				socket++) {
+		for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES && total_size != 0;
+				numa_id++) {
 			/* take whatever is available */
 			default_size = RTE_MIN(
-				get_socket_mem_size(socket) - memory[socket],
+				get_numa_node_mem_size(numa_id) - memory[numa_id],
 				total_size);
 
 			/* Update sizes */
-			memory[socket] += default_size;
+			memory[numa_id] += default_size;
 			total_size -= default_size;
 		}
 #else
 		/* in 32-bit mode, allocate all of the memory only on main
-		 * lcore socket
+		 * lcore NUMA node
 		 */
 		total_size = internal_conf->memory;
-		for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_size != 0;
-				socket++) {
+		for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES && total_size != 0;
+				numa_id++) {
 			struct rte_config *cfg = rte_eal_get_configuration();
-			unsigned int main_lcore_socket;
+			unsigned int main_lcore_numa_node;
 
-			main_lcore_socket =
-				rte_lcore_to_socket_id(cfg->main_lcore);
+			main_lcore_numa_node =
+				rte_lcore_to_numa_id(cfg->main_lcore);
 
-			if (main_lcore_socket != socket)
+			if (main_lcore_numa_node != numa_id)
 				continue;
 
 			/* Update sizes */
-			memory[socket] = total_size;
+			memory[numa_id] = total_size;
 			break;
 		}
 #endif
 	}
 
-	for (socket = 0; socket < RTE_MAX_NUMA_NODES && total_mem != 0;
-			socket++) {
-		/* skips if the memory on specific socket wasn't requested */
-		for (i = 0; i < num_hp_info && memory[socket] != 0; i++) {
+	for (numa_id = 0; numa_id < RTE_MAX_NUMA_NODES && total_mem != 0;
+			numa_id++) {
+		/* skips if the memory on specific NUMA node was not requested */
+		for (i = 0; i < num_hp_info && memory[numa_id] != 0; i++) {
 			rte_strscpy(hp_used[i].hugedir, hp_info[i].hugedir,
 				sizeof(hp_used[i].hugedir));
-			hp_used[i].num_pages[socket] = RTE_MIN(
-					memory[socket] / hp_info[i].hugepage_sz,
-					hp_info[i].num_pages[socket]);
+			hp_used[i].num_pages[numa_id] = RTE_MIN(
+					memory[numa_id] / hp_info[i].hugepage_sz,
+					hp_info[i].num_pages[numa_id]);
 
-			cur_mem = hp_used[i].num_pages[socket] *
+			cur_mem = hp_used[i].num_pages[numa_id] *
 					hp_used[i].hugepage_sz;
 
-			memory[socket] -= cur_mem;
+			memory[numa_id] -= cur_mem;
 			total_mem -= cur_mem;
 
-			total_num_pages += hp_used[i].num_pages[socket];
+			total_num_pages += hp_used[i].num_pages[numa_id];
 
 			/* check if we have met all memory requests */
-			if (memory[socket] == 0)
+			if (memory[numa_id] == 0)
 				break;
 
 			/* Check if we have any more pages left at this size,
 			 * if so, move on to next size.
 			 */
-			if (hp_used[i].num_pages[socket] ==
-					hp_info[i].num_pages[socket])
+			if (hp_used[i].num_pages[numa_id] ==
+					hp_info[i].num_pages[numa_id])
 				continue;
 			/* At this point we know that there are more pages
 			 * available that are bigger than the memory we want,
@@ -473,29 +473,29 @@ eal_dynmem_calc_num_pages_per_socket(
 			remaining_mem = 0;
 			for (j = i+1; j < num_hp_info; j++)
 				remaining_mem += hp_info[j].hugepage_sz *
-				hp_info[j].num_pages[socket];
+				hp_info[j].num_pages[numa_id];
 
 			/* Is there enough other memory?
 			 * If not, allocate another page and quit.
 			 */
-			if (remaining_mem < memory[socket]) {
+			if (remaining_mem < memory[numa_id]) {
 				cur_mem = RTE_MIN(
-					memory[socket], hp_info[i].hugepage_sz);
-				memory[socket] -= cur_mem;
+					memory[numa_id], hp_info[i].hugepage_sz);
+				memory[numa_id] -= cur_mem;
 				total_mem -= cur_mem;
-				hp_used[i].num_pages[socket]++;
+				hp_used[i].num_pages[numa_id]++;
 				total_num_pages++;
-				break; /* we are done with this socket*/
+				break; /* we are done with this numa_id*/
 			}
 		}
 
-		/* if we didn't satisfy all memory requirements per socket */
-		if (memory[socket] > 0 &&
-				internal_conf->numa_mem[socket] != 0) {
-			requested = internal_conf->numa_mem[socket] / 0x100000;
-			available = requested - (memory[socket] / 0x100000);
-			EAL_LOG(ERR, "Not enough memory available on socket %u! Requested: %uMB, available: %uMB",
-				socket, requested, available);
+		/* if we didn't satisfy all memory requirements per numa_id */
+		if (memory[numa_id] > 0 &&
+				internal_conf->numa_mem[numa_id] != 0) {
+			requested = internal_conf->numa_mem[numa_id] / 0x100000;
+			available = requested - (memory[numa_id] / 0x100000);
+			EAL_LOG(ERR, "Not enough memory available on numa_id %u! Requested: %uMB, available: %uMB",
+				numa_id, requested, available);
 			return -1;
 		}
 	}
diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_common_lcore.c
index 3ddacdb8ce..f569307e51 100644
--- a/lib/eal/common/eal_common_lcore.c
+++ b/lib/eal/common/eal_common_lcore.c
@@ -124,25 +124,32 @@ unsigned int rte_get_next_lcore(unsigned int i, int skip_main, int wrap)
 	return i;
 }
 
+RTE_EXPORT_SYMBOL(rte_lcore_to_numa_id)
+unsigned int
+rte_lcore_to_numa_id(unsigned int lcore_id)
+{
+	return lcore_config[lcore_id].numa_id;
+}
+
 RTE_EXPORT_SYMBOL(rte_lcore_to_socket_id)
 unsigned int
 rte_lcore_to_socket_id(unsigned int lcore_id)
 {
-	return lcore_config[lcore_id].numa_id;
+	return rte_lcore_to_numa_id(lcore_id);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cpu_socket_id, 26.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_cpu_numa_id, 26.11)
 unsigned int
-rte_cpu_socket_id(unsigned int cpu_id)
+rte_cpu_numa_id(unsigned int cpu_id)
 {
 	if (eal_cpu_detected(cpu_id) == 0)
-		return (unsigned int)SOCKET_ID_ANY;
+		return (unsigned int)RTE_NUMA_ID_ANY;
 
-	return eal_cpu_socket_id(cpu_id);
+	return eal_cpu_numa_id(cpu_id);
 }
 
 static int
-socket_id_cmp(const void *a, const void *b)
+numa_id_cmp(const void *a, const void *b)
 {
 	const int *lcore_id_a = a;
 	const int *lcore_id_b = b;
@@ -166,11 +173,11 @@ rte_eal_cpu_init(void)
 	struct rte_config *config = rte_eal_get_configuration();
 	unsigned lcore_id;
 	unsigned count = 0;
-	unsigned int socket_id, prev_socket_id;
+	unsigned int numa_id, prev_numa_id;
 #if CPU_SETSIZE > RTE_MAX_LCORE
-	int lcore_to_socket_id[CPU_SETSIZE] = {0};
+	int lcore_to_numa_id[CPU_SETSIZE] = {0};
 #else
-	int lcore_to_socket_id[RTE_MAX_LCORE] = {0};
+	int lcore_to_numa_id[RTE_MAX_LCORE] = {0};
 #endif
 
 	/*
@@ -183,9 +190,9 @@ rte_eal_cpu_init(void)
 		/* init cpuset for per lcore config */
 		CPU_ZERO(&lcore_config[lcore_id].cpuset);
 
-		/* find socket first */
-		socket_id = eal_cpu_socket_id(lcore_id);
-		lcore_to_socket_id[lcore_id] = socket_id;
+		/* find NUMA node first */
+		numa_id = eal_cpu_numa_id(lcore_id);
+		lcore_to_numa_id[lcore_id] = numa_id;
 
 		if (eal_cpu_detected(lcore_id) == 0) {
 			config->lcore_role[lcore_id] = RTE_LCORE_ROLE_OFF;
@@ -203,7 +210,7 @@ rte_eal_cpu_init(void)
 		config->lcore_role[lcore_id] = RTE_LCORE_ROLE_RTE;
 		lcore_config[lcore_id].core_role = RTE_LCORE_ROLE_RTE;
 		lcore_config[lcore_id].core_id = eal_cpu_core_id(lcore_id);
-		lcore_config[lcore_id].numa_id = socket_id;
+		lcore_config[lcore_id].numa_id = numa_id;
 		EAL_LOG(DEBUG, "Detected lcore %u as "
 				"core %u on NUMA node %u",
 				lcore_id, lcore_config[lcore_id].core_id,
@@ -213,11 +220,11 @@ rte_eal_cpu_init(void)
 	for (; lcore_id < CPU_SETSIZE; lcore_id++) {
 		if (eal_cpu_detected(lcore_id) == 0)
 			continue;
-		socket_id = eal_cpu_socket_id(lcore_id);
-		lcore_to_socket_id[lcore_id] = socket_id;
+		numa_id = eal_cpu_numa_id(lcore_id);
+		lcore_to_numa_id[lcore_id] = numa_id;
 		EAL_LOG(DEBUG, "Skipped lcore %u as core %u on NUMA node %u",
 			lcore_id, eal_cpu_core_id(lcore_id),
-			socket_id);
+			numa_id);
 	}
 
 	/* Set the count of enabled logical cores of the EAL configuration */
@@ -227,17 +234,17 @@ rte_eal_cpu_init(void)
 			RTE_MAX_LCORE);
 	EAL_LOG(INFO, "Detected CPU lcores: %u", config->lcore_count);
 
-	/* sort all socket id's in ascending order */
-	qsort(lcore_to_socket_id, RTE_DIM(lcore_to_socket_id),
-			sizeof(lcore_to_socket_id[0]), socket_id_cmp);
+	/* sort all NUMA node IDs in ascending order */
+	qsort(lcore_to_numa_id, RTE_DIM(lcore_to_numa_id),
+			sizeof(lcore_to_numa_id[0]), numa_id_cmp);
 
-	prev_socket_id = -1;
+	prev_numa_id = -1;
 	config->numa_node_count = 0;
-	for (lcore_id = 0; lcore_id < RTE_DIM(lcore_to_socket_id); lcore_id++) {
-		socket_id = lcore_to_socket_id[lcore_id];
-		if (socket_id != prev_socket_id)
-			config->numa_nodes[config->numa_node_count++] =	socket_id;
-		prev_socket_id = socket_id;
+	for (lcore_id = 0; lcore_id < RTE_DIM(lcore_to_numa_id); lcore_id++) {
+		numa_id = lcore_to_numa_id[lcore_id];
+		if (numa_id != prev_numa_id)
+			config->numa_nodes[config->numa_node_count++] =	numa_id;
+		prev_numa_id = numa_id;
 		if (config->numa_node_count >= RTE_MAX_NUMA_NODES)
 			break;
 	}
@@ -246,17 +253,24 @@ rte_eal_cpu_init(void)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_socket_count)
+RTE_EXPORT_SYMBOL(rte_numa_count)
 unsigned int
-rte_socket_count(void)
+rte_numa_count(void)
 {
 	const struct rte_config *config = rte_eal_get_configuration();
 	return config->numa_node_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
+RTE_EXPORT_SYMBOL(rte_socket_count)
+unsigned int
+rte_socket_count(void)
+{
+	return rte_numa_count();
+}
+
+RTE_EXPORT_SYMBOL(rte_numa_id_by_idx)
 int
-rte_socket_id_by_idx(unsigned int idx)
+rte_numa_id_by_idx(unsigned int idx)
 {
 	const struct rte_config *config = rte_eal_get_configuration();
 	if (idx >= config->numa_node_count) {
@@ -266,6 +280,13 @@ rte_socket_id_by_idx(unsigned int idx)
 	return config->numa_nodes[idx];
 }
 
+RTE_EXPORT_SYMBOL(rte_socket_id_by_idx)
+int
+rte_socket_id_by_idx(unsigned int idx)
+{
+	return rte_numa_id_by_idx(idx);
+}
+
 static rte_rwlock_t lcore_lock = RTE_RWLOCK_INITIALIZER;
 struct lcore_callback {
 	TAILQ_ENTRY(lcore_callback) next;
@@ -527,8 +548,8 @@ lcore_dump_cb(unsigned int lcore_id, void *arg)
 		}
 	}
 	cpuset = eal_cpuset_to_str(&lcore_config[lcore_id].cpuset);
-	fprintf(f, "lcore %u, socket %u, role %s, cpuset %s\n", lcore_id,
-		rte_lcore_to_socket_id(lcore_id),
+	fprintf(f, "lcore %u, numa node %u, role %s, cpuset %s\n", lcore_id,
+		rte_lcore_to_numa_id(lcore_id),
 		lcore_role_str(cfg->lcore_role[lcore_id]),
 		cpuset != NULL ? cpuset : "<unknown>");
 	free(cpuset);
@@ -594,7 +615,7 @@ lcore_telemetry_info_cb(unsigned int lcore_id, void *arg)
 
 	rte_tel_data_start_dict(info->d);
 	rte_tel_data_add_dict_int(info->d, "lcore_id", lcore_id);
-	rte_tel_data_add_dict_int(info->d, "socket", rte_lcore_to_socket_id(lcore_id));
+	rte_tel_data_add_dict_int(info->d, "numa_id", rte_lcore_to_numa_id(lcore_id));
 	rte_tel_data_add_dict_string(info->d, "role", lcore_role_str(cfg->lcore_role[lcore_id]));
 	cpuset = rte_tel_data_alloc();
 	if (cpuset == NULL)
diff --git a/lib/eal/common/eal_common_memalloc.c b/lib/eal/common/eal_common_memalloc.c
index 47e782f395..42f90148e5 100644
--- a/lib/eal/common/eal_common_memalloc.c
+++ b/lib/eal/common/eal_common_memalloc.c
@@ -25,7 +25,7 @@ struct mem_alloc_validator_entry {
 	TAILQ_ENTRY(mem_alloc_validator_entry) next;
 	char name[RTE_MEM_ALLOC_VALIDATOR_NAME_LEN];
 	rte_mem_alloc_validator_t clb;
-	int socket_id;
+	int numa_id;
 	size_t limit;
 };
 
@@ -54,12 +54,12 @@ find_mem_event_callback(const char *name, void *arg)
 }
 
 static struct mem_alloc_validator_entry *
-find_mem_alloc_validator(const char *name, int socket_id)
+find_mem_alloc_validator(const char *name, int numa_id)
 {
 	struct mem_alloc_validator_entry *r;
 
 	TAILQ_FOREACH(r, &mem_alloc_validator_list, next) {
-		if (!strcmp(r->name, name) && r->socket_id == socket_id)
+		if (!strcmp(r->name, name) && r->numa_id == numa_id)
 			break;
 	}
 	return r;
@@ -252,11 +252,11 @@ eal_memalloc_mem_event_notify(enum rte_mem_event event, const void *start,
 
 int
 eal_memalloc_mem_alloc_validator_register(const char *name,
-		rte_mem_alloc_validator_t clb, int socket_id, size_t limit)
+		rte_mem_alloc_validator_t clb, int numa_id, size_t limit)
 {
 	struct mem_alloc_validator_entry *entry;
 	int ret, len;
-	if (name == NULL || clb == NULL || socket_id < 0) {
+	if (name == NULL || clb == NULL || numa_id < 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
@@ -270,7 +270,7 @@ eal_memalloc_mem_alloc_validator_register(const char *name,
 	}
 	rte_rwlock_write_lock(&mem_alloc_validator_rwlock);
 
-	entry = find_mem_alloc_validator(name, socket_id);
+	entry = find_mem_alloc_validator(name, numa_id);
 	if (entry != NULL) {
 		rte_errno = EEXIST;
 		ret = -1;
@@ -286,15 +286,15 @@ eal_memalloc_mem_alloc_validator_register(const char *name,
 
 	/* callback successfully created and is valid, add it to the list */
 	entry->clb = clb;
-	entry->socket_id = socket_id;
+	entry->numa_id = numa_id;
 	entry->limit = limit;
 	strlcpy(entry->name, name, RTE_MEM_ALLOC_VALIDATOR_NAME_LEN);
 	TAILQ_INSERT_TAIL(&mem_alloc_validator_list, entry, next);
 
 	ret = 0;
 
-	EAL_LOG(DEBUG, "Mem alloc validator '%s' on socket %i with limit %zu registered",
-		name, socket_id, limit);
+	EAL_LOG(DEBUG, "Mem alloc validator '%s' on NUMA node %i with limit %zu registered",
+		name, numa_id, limit);
 
 unlock:
 	rte_rwlock_write_unlock(&mem_alloc_validator_rwlock);
@@ -302,12 +302,12 @@ eal_memalloc_mem_alloc_validator_register(const char *name,
 }
 
 int
-eal_memalloc_mem_alloc_validator_unregister(const char *name, int socket_id)
+eal_memalloc_mem_alloc_validator_unregister(const char *name, int numa_id)
 {
 	struct mem_alloc_validator_entry *entry;
 	int ret, len;
 
-	if (name == NULL || socket_id < 0) {
+	if (name == NULL || numa_id < 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
@@ -321,7 +321,7 @@ eal_memalloc_mem_alloc_validator_unregister(const char *name, int socket_id)
 	}
 	rte_rwlock_write_lock(&mem_alloc_validator_rwlock);
 
-	entry = find_mem_alloc_validator(name, socket_id);
+	entry = find_mem_alloc_validator(name, numa_id);
 	if (entry == NULL) {
 		rte_errno = ENOENT;
 		ret = -1;
@@ -332,8 +332,8 @@ eal_memalloc_mem_alloc_validator_unregister(const char *name, int socket_id)
 
 	ret = 0;
 
-	EAL_LOG(DEBUG, "Mem alloc validator '%s' on socket %i unregistered",
-		name, socket_id);
+	EAL_LOG(DEBUG, "Mem alloc validator '%s' on NUMA node %i unregistered",
+		name, numa_id);
 
 unlock:
 	rte_rwlock_write_unlock(&mem_alloc_validator_rwlock);
@@ -341,7 +341,7 @@ eal_memalloc_mem_alloc_validator_unregister(const char *name, int socket_id)
 }
 
 int
-eal_memalloc_mem_alloc_validate(int socket_id, size_t new_len)
+eal_memalloc_mem_alloc_validate(int numa_id, size_t new_len)
 {
 	struct mem_alloc_validator_entry *entry;
 	int ret = 0;
@@ -349,11 +349,11 @@ eal_memalloc_mem_alloc_validate(int socket_id, size_t new_len)
 	rte_rwlock_read_lock(&mem_alloc_validator_rwlock);
 
 	TAILQ_FOREACH(entry, &mem_alloc_validator_list, next) {
-		if (entry->socket_id != socket_id || entry->limit > new_len)
+		if (entry->numa_id != numa_id || entry->limit > new_len)
 			continue;
-		EAL_LOG(DEBUG, "Calling mem alloc validator '%s' on socket %i",
-			entry->name, entry->socket_id);
-		if (entry->clb(socket_id, entry->limit, new_len) < 0)
+		EAL_LOG(DEBUG, "Calling mem alloc validator '%s' on NUMA node %i",
+			entry->name, entry->numa_id);
+		if (entry->clb(numa_id, entry->limit, new_len) < 0)
 			ret = -1;
 	}
 
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 33681e7a37..cd22c254a1 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -204,7 +204,7 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
 
 int
 eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
-		uint64_t page_sz, int n_segs, int socket_id, bool heap)
+		uint64_t page_sz, int n_segs, int numa_id, bool heap)
 {
 	if (rte_fbarray_init(&msl->memseg_arr, name, n_segs,
 			sizeof(struct rte_memseg))) {
@@ -214,26 +214,26 @@ eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
 	}
 
 	msl->page_sz = page_sz;
-	msl->socket_id = socket_id;
+	msl->socket_id = numa_id;
 	msl->base_va = NULL;
 	msl->heap = heap;
 
 	EAL_LOG(DEBUG,
-		"Memseg list allocated at socket %i, page size 0x%"PRIx64"kB",
-		socket_id, page_sz >> 10);
+		"Memseg list allocated at NUMA node %i, page size 0x%"PRIx64"kB",
+		numa_id, page_sz >> 10);
 
 	return 0;
 }
 
 int
 eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
-		int n_segs, int socket_id, int msl_idx, bool heap)
+		int n_segs, int numa_id, int msl_idx, bool heap)
 {
 	char name[RTE_FBARRAY_NAME_LEN];
 
-	snprintf(name, sizeof(name), MEMSEG_LIST_FMT, page_sz >> 10, socket_id, msl_idx);
+	snprintf(name, sizeof(name), MEMSEG_LIST_FMT, page_sz >> 10, numa_id, msl_idx);
 
-	return eal_memseg_list_init_named(msl, name, page_sz, n_segs, socket_id, heap);
+	return eal_memseg_list_init_named(msl, name, page_sz, n_segs, numa_id, heap);
 }
 
 int
@@ -477,7 +477,7 @@ dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 
 	fd = eal_memalloc_get_seg_fd(msl_idx, ms_idx);
 	fprintf(f, "Segment %i-%i: IOVA:0x%"PRIx64", len:%zu, "
-			"virt:%p, socket_id:%"PRId32", "
+			"virt:%p, numa_id:%"PRId32", "
 			"hugepage_sz:%"PRIu64", nchannel:%"PRIx32", "
 			"nrank:%"PRIx32" fd:%i\n",
 			msl_idx, ms_idx,
@@ -533,7 +533,7 @@ rte_mem_event_callback_unregister(const char *name, void *arg)
 RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_register)
 int
 rte_mem_alloc_validator_register(const char *name,
-		rte_mem_alloc_validator_t clb, int socket_id, size_t limit)
+		rte_mem_alloc_validator_t clb, int numa_id, size_t limit)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -544,13 +544,13 @@ rte_mem_alloc_validator_register(const char *name,
 		rte_errno = ENOTSUP;
 		return -1;
 	}
-	return eal_memalloc_mem_alloc_validator_register(name, clb, socket_id,
+	return eal_memalloc_mem_alloc_validator_register(name, clb, numa_id,
 			limit);
 }
 
 RTE_EXPORT_SYMBOL(rte_mem_alloc_validator_unregister)
 int
-rte_mem_alloc_validator_unregister(const char *name, int socket_id)
+rte_mem_alloc_validator_unregister(const char *name, int numa_id)
 {
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -561,7 +561,7 @@ rte_mem_alloc_validator_unregister(const char *name, int socket_id)
 		rte_errno = ENOTSUP;
 		return -1;
 	}
-	return eal_memalloc_mem_alloc_validator_unregister(name, socket_id);
+	return eal_memalloc_mem_alloc_validator_unregister(name, numa_id);
 }
 
 /* Dump the physical memory layout on console */
@@ -966,7 +966,7 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	unsigned int socket_id, n;
+	unsigned int numa_id, n;
 	int ret = 0;
 
 	if (va_addr == NULL || page_sz == 0 || len == 0 ||
@@ -986,10 +986,10 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 		goto unlock;
 	}
 
-	/* get next available socket ID */
-	socket_id = mcfg->next_socket_id;
-	if (socket_id > INT32_MAX) {
-		EAL_LOG(ERR, "Cannot assign new socket ID's");
+	/* get next available NUMA node ID */
+	numa_id = mcfg->next_numa_id;
+	if (numa_id > INT32_MAX) {
+		EAL_LOG(ERR, "Cannot assign new NUMA node IDs");
 		rte_errno = ENOSPC;
 		ret = -1;
 		goto unlock;
@@ -998,13 +998,13 @@ rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
 	/* we can create a new memseg */
 	n = len / page_sz;
 	if (malloc_heap_create_external_seg(va_addr, iova_addrs, n,
-			page_sz, "extmem", socket_id) == NULL) {
+			page_sz, "extmem", numa_id) == NULL) {
 		ret = -1;
 		goto unlock;
 	}
 
-	/* memseg list successfully created - increment next socket ID */
-	mcfg->next_socket_id++;
+	/* memseg list successfully created - increment next NUMA node ID */
+	mcfg->next_numa_id++;
 unlock:
 	rte_mcfg_mem_write_unlock();
 	return ret;
@@ -1193,7 +1193,7 @@ handle_eal_heap_info_request(const char *cmd __rte_unused, const char *params,
 			     struct rte_tel_data *d)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	struct rte_malloc_socket_stats sock_stats;
+	struct rte_malloc_numa_stats sock_stats;
 	struct malloc_heap *heap;
 	unsigned int heap_id;
 
@@ -1230,7 +1230,7 @@ handle_eal_heap_list_request(const char *cmd __rte_unused,
 				struct rte_tel_data *d)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	struct rte_malloc_socket_stats sock_stats;
+	struct rte_malloc_numa_stats sock_stats;
 	unsigned int heap_id;
 
 	rte_tel_data_start_array(d, RTE_TEL_INT_VAL);
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index db43af13a8..d325193b9d 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -102,7 +102,7 @@ memzone_lookup_thread_unsafe(const char *name)
 
 static const struct rte_memzone *
 memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
-		int socket_id, unsigned int flags, unsigned int align,
+		int numa_id, unsigned int flags, unsigned int align,
 		unsigned int bound)
 {
 	struct rte_memzone *mz;
@@ -171,7 +171,7 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 		return NULL;
 	}
 
-	if ((socket_id != SOCKET_ID_ANY) && socket_id < 0) {
+	if ((numa_id != RTE_NUMA_ID_ANY) && numa_id < 0) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -181,11 +181,11 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 		return NULL;
 	}
 
-	/* only set socket to SOCKET_ID_ANY if we aren't allocating for an
+	/* only set NUMA node to RTE_NUMA_ID_ANY if we are not allocating for an
 	 * external heap.
 	 */
-	if (!rte_eal_has_hugepages() && socket_id < RTE_MAX_NUMA_NODES)
-		socket_id = SOCKET_ID_ANY;
+	if (!rte_eal_has_hugepages() && numa_id < RTE_MAX_NUMA_NODES)
+		numa_id = RTE_NUMA_ID_ANY;
 
 	contig = (flags & RTE_MEMZONE_IOVA_CONTIG) != 0;
 	/* malloc only cares about size flags, remove contig flag from flags */
@@ -194,12 +194,12 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 	if (len == 0 && bound == 0) {
 		/* no size constraints were placed, so use malloc elem len */
 		requested_len = 0;
-		mz_addr = malloc_heap_alloc_biggest(socket_id, flags, align, contig);
+		mz_addr = malloc_heap_alloc_biggest(numa_id, flags, align, contig);
 	} else {
 		if (len == 0)
 			requested_len = bound;
 		/* allocate memory on heap */
-		mz_addr = malloc_heap_alloc(requested_len, socket_id, flags, align, bound, contig);
+		mz_addr = malloc_heap_alloc(requested_len, numa_id, flags, align, bound, contig);
 	}
 	if (mz_addr == NULL) {
 		rte_errno = ENOMEM;
@@ -239,7 +239,7 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 }
 
 static const struct rte_memzone *
-rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
+rte_memzone_reserve_thread_safe(const char *name, size_t len, int numa_id,
 		unsigned int flags, unsigned int align, unsigned int bound)
 {
 	struct rte_mem_config *mcfg;
@@ -251,9 +251,9 @@ rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
 	rte_rwlock_write_lock(&mcfg->mlock);
 
 	mz = memzone_reserve_aligned_thread_unsafe(
-		name, len, socket_id, flags, align, bound);
+		name, len, numa_id, flags, align, bound);
 
-	rte_eal_trace_memzone_reserve(name, len, socket_id, flags, align,
+	rte_eal_trace_memzone_reserve(name, len, numa_id, flags, align,
 		bound, mz);
 
 	rte_rwlock_write_unlock(&mcfg->mlock);
@@ -268,10 +268,10 @@ rte_memzone_reserve_thread_safe(const char *name, size_t len, int socket_id,
  */
 RTE_EXPORT_SYMBOL(rte_memzone_reserve_bounded)
 const struct rte_memzone *
-rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
+rte_memzone_reserve_bounded(const char *name, size_t len, int numa_id,
 			    unsigned flags, unsigned align, unsigned bound)
 {
-	return rte_memzone_reserve_thread_safe(name, len, socket_id, flags,
+	return rte_memzone_reserve_thread_safe(name, len, numa_id, flags,
 					       align, bound);
 }
 
@@ -281,10 +281,10 @@ rte_memzone_reserve_bounded(const char *name, size_t len, int socket_id,
  */
 RTE_EXPORT_SYMBOL(rte_memzone_reserve_aligned)
 const struct rte_memzone *
-rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
+rte_memzone_reserve_aligned(const char *name, size_t len, int numa_id,
 			    unsigned flags, unsigned align)
 {
-	return rte_memzone_reserve_thread_safe(name, len, socket_id, flags,
+	return rte_memzone_reserve_thread_safe(name, len, numa_id, flags,
 					       align, 0);
 }
 
@@ -294,10 +294,10 @@ rte_memzone_reserve_aligned(const char *name, size_t len, int socket_id,
  */
 RTE_EXPORT_SYMBOL(rte_memzone_reserve)
 const struct rte_memzone *
-rte_memzone_reserve(const char *name, size_t len, int socket_id,
+rte_memzone_reserve(const char *name, size_t len, int numa_id,
 		    unsigned flags)
 {
-	return rte_memzone_reserve_thread_safe(name, len, socket_id,
+	return rte_memzone_reserve_thread_safe(name, len, numa_id,
 					       flags, RTE_CACHE_LINE_SIZE, 0);
 }
 
@@ -388,7 +388,7 @@ dump_memzone(const struct rte_memzone *mz, void *arg)
 	info->total_size += mz->len;
 
 	fprintf(f, "Zone %u: name:<%s>, len:0x%zx, virt:%p, "
-				"socket_id:%"PRId32", flags:%"PRIx32"\n",
+				"numa_id:%"PRId32", flags:%"PRIx32"\n",
 			mz_idx,
 			mz->name,
 			mz->len,
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b2c0744447..a84af3b66b 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -1855,7 +1855,7 @@ eal_parse_log_options(void)
 }
 
 static int
-eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
+eal_parse_numa_arg(char *strval, volatile uint64_t *numa_arg)
 {
 	char *arg[RTE_MAX_NUMA_NODES];
 	char *end;
@@ -1871,7 +1871,7 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 	if (!isdigit(strval[len-1]))
 		return -1;
 
-	/* split the optarg into separate socket values */
+	/* split the optarg into separate NUMA node values */
 	arg_num = rte_strsplit(strval, len,
 			arg, RTE_MAX_NUMA_NODES, ',');
 
@@ -1879,7 +1879,7 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 	if (arg_num <= 0)
 		return -1;
 
-	/* parse each defined socket option */
+	/* parse each defined NUMA node option */
 	errno = 0;
 	for (i = 0; i < arg_num; i++) {
 		uint64_t val;
@@ -1891,7 +1891,7 @@ eal_parse_socket_arg(char *strval, volatile uint64_t *socket_arg)
 				(arg[i][0] == '\0') || (end == NULL) || (*end != '\0'))
 			return -1;
 		val <<= 20;
-		socket_arg[i] = val;
+		numa_arg[i] = val;
 	}
 
 	return 0;
@@ -2282,14 +2282,14 @@ eal_parse_args(void)
 		}
 	}
 	if (args.numa_mem != NULL) {
-		if (eal_parse_socket_arg(args.numa_mem, int_cfg->numa_mem) < 0) {
+		if (eal_parse_numa_arg(args.numa_mem, int_cfg->numa_mem) < 0) {
 			EAL_LOG(ERR, "invalid numa-mem parameter: '%s'", args.numa_mem);
 			return -1;
 		}
 		int_cfg->force_numa = 1;
 	}
 	if (args.numa_limit != NULL) {
-		if (eal_parse_socket_arg(args.numa_limit, int_cfg->numa_limit) < 0) {
+		if (eal_parse_numa_arg(args.numa_limit, int_cfg->numa_limit) < 0) {
 			EAL_LOG(ERR, "invalid numa-limit parameter: '%s'", args.numa_limit);
 			return -1;
 		}
diff --git a/lib/eal/common/eal_common_thread.c b/lib/eal/common/eal_common_thread.c
index dcd81f9e32..e654a57e9a 100644
--- a/lib/eal/common/eal_common_thread.c
+++ b/lib/eal/common/eal_common_thread.c
@@ -28,41 +28,47 @@ RTE_DEFINE_PER_LCORE(unsigned int, _lcore_id) = LCORE_ID_ANY;
 RTE_EXPORT_SYMBOL(per_lcore__thread_id)
 RTE_DEFINE_PER_LCORE(int, _thread_id) = -1;
 static RTE_DEFINE_PER_LCORE(unsigned int, _numa_id) =
-	(unsigned int)SOCKET_ID_ANY;
+	(unsigned int)RTE_NUMA_ID_ANY;
 static RTE_DEFINE_PER_LCORE(rte_cpuset_t, _cpuset);
 
+RTE_EXPORT_SYMBOL(rte_numa_id)
+unsigned int rte_numa_id(void)
+{
+	return RTE_PER_LCORE(_numa_id);
+}
+
 RTE_EXPORT_SYMBOL(rte_socket_id)
 unsigned rte_socket_id(void)
 {
-	return RTE_PER_LCORE(_numa_id);
+	return rte_numa_id();
 }
 
 static int
-eal_cpuset_socket_id(rte_cpuset_t *cpusetp)
+eal_cpuset_numa_id(rte_cpuset_t *cpusetp)
 {
 	unsigned cpu = 0;
-	int socket_id = SOCKET_ID_ANY;
+	int numa_id = RTE_NUMA_ID_ANY;
 	int sid;
 
 	if (cpusetp == NULL)
-		return SOCKET_ID_ANY;
+		return RTE_NUMA_ID_ANY;
 
 	do {
 		if (!CPU_ISSET(cpu, cpusetp))
 			continue;
 
-		if (socket_id == SOCKET_ID_ANY)
-			socket_id = eal_cpu_socket_id(cpu);
+		if (numa_id == RTE_NUMA_ID_ANY)
+			numa_id = eal_cpu_numa_id(cpu);
 
-		sid = eal_cpu_socket_id(cpu);
-		if (socket_id != sid) {
-			socket_id = SOCKET_ID_ANY;
+		sid = eal_cpu_numa_id(cpu);
+		if (numa_id != sid) {
+			numa_id = RTE_NUMA_ID_ANY;
 			break;
 		}
 
 	} while (++cpu < CPU_SETSIZE);
 
-	return socket_id;
+	return numa_id;
 }
 
 static void
@@ -72,7 +78,7 @@ thread_update_affinity(rte_cpuset_t *cpusetp)
 
 	/* store numa_id in TLS for quick access */
 	RTE_PER_LCORE(_numa_id) =
-		eal_cpuset_socket_id(cpusetp);
+		eal_cpuset_numa_id(cpusetp);
 
 	/* store cpuset in TLS for quick access */
 	memmove(&RTE_PER_LCORE(_cpuset), cpusetp,
@@ -240,10 +246,10 @@ static int control_thread_init(void *arg)
 	struct control_thread_params *params = arg;
 
 	__rte_thread_init(rte_lcore_id(), cpuset);
-	/* Set control thread socket ID to SOCKET_ID_ANY
+	/* Set control thread NUMA node ID to RTE_NUMA_ID_ANY
 	 * as control threads may be scheduled on any NUMA node.
 	 */
-	RTE_PER_LCORE(_numa_id) = SOCKET_ID_ANY;
+	RTE_PER_LCORE(_numa_id) = RTE_NUMA_ID_ANY;
 	params->ret = rte_thread_set_affinity_by_id(rte_thread_self(), cpuset);
 	if (params->ret != 0) {
 		rte_atomic_store_explicit(&params->status,
diff --git a/lib/eal/common/eal_hugepages.h b/lib/eal/common/eal_hugepages.h
index 1b560d3379..2b14ed3a86 100644
--- a/lib/eal/common/eal_hugepages.h
+++ b/lib/eal/common/eal_hugepages.h
@@ -20,7 +20,7 @@ struct hugepage_file {
 	void *final_va;     /**< virtual addr of 2nd mmap() */
 	uint64_t physaddr;  /**< physical addr */
 	size_t size;        /**< the page size */
-	int socket_id;      /**< NUMA socket ID */
+	int numa_id;        /**< NUMA node ID */
 	int file_id;        /**< the '%d' in HUGEFILE_FMT */
 	char filepath[MAX_HUGEPAGE_PATH]; /**< path to backing file on filesystem */
 };
diff --git a/lib/eal/common/eal_internal_cfg.h b/lib/eal/common/eal_internal_cfg.h
index 07cd35167d..b7727a4bcf 100644
--- a/lib/eal/common/eal_internal_cfg.h
+++ b/lib/eal/common/eal_internal_cfg.h
@@ -30,7 +30,7 @@ struct hugepage_info {
 	uint64_t hugepage_sz;   /**< size of a huge page */
 	char hugedir[PATH_MAX];    /**< dir where hugetlbfs is mounted */
 	uint32_t num_pages[RTE_MAX_NUMA_NODES];
-	/**< number of hugepages of that size on each socket */
+	/**< number of hugepages of that size on each NUMA node */
 	int lock_descriptor;    /**< file descriptor for hugepage dir */
 };
 
diff --git a/lib/eal/common/eal_memalloc.h b/lib/eal/common/eal_memalloc.h
index 0c267066d9..d176bbd21a 100644
--- a/lib/eal/common/eal_memalloc.h
+++ b/lib/eal/common/eal_memalloc.h
@@ -13,7 +13,7 @@
  * Allocate segment of specified page size.
  */
 struct rte_memseg *
-eal_memalloc_alloc_seg(size_t page_sz, int socket);
+eal_memalloc_alloc_seg(size_t page_sz, int numa_id);
 
 /*
  * Allocate `n_segs` segments.
@@ -26,7 +26,7 @@ eal_memalloc_alloc_seg(size_t page_sz, int socket);
  */
 int
 eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
-		int socket, bool exact);
+		int numa_id, bool exact);
 
 /*
  * Deallocate segment
@@ -67,13 +67,13 @@ eal_memalloc_mem_event_notify(enum rte_mem_event event, const void *start,
 
 int
 eal_memalloc_mem_alloc_validator_register(const char *name,
-		rte_mem_alloc_validator_t clb, int socket_id, size_t limit);
+		rte_mem_alloc_validator_t clb, int numa_id, size_t limit);
 
 int
-eal_memalloc_mem_alloc_validator_unregister(const char *name, int socket_id);
+eal_memalloc_mem_alloc_validator_unregister(const char *name, int numa_id);
 
 int
-eal_memalloc_mem_alloc_validate(int socket_id, size_t new_len);
+eal_memalloc_mem_alloc_validate(int numa_id, size_t new_len);
 
 /* returns fd or -errno */
 int
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 2b3b3b62ba..6a0427b7b3 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -62,7 +62,7 @@ struct rte_mem_config {
 	struct malloc_heap malloc_heaps[RTE_MAX_HEAPS];
 	/**< DPDK malloc heaps */
 
-	int next_socket_id; /**< Next socket ID for external malloc heap */
+	int next_numa_id; /**< Next NUMA node ID for external malloc heap */
 
 	/* rte_mem_config has to be mapped at the exact same address in all
 	 * processes, so we need to store it.
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 8905464f64..72595930fd 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -32,7 +32,7 @@ struct lcore_config {
 
 	volatile RTE_ATOMIC(enum rte_lcore_state_t) state; /**< lcore state */
 	unsigned int numa_id;      /**< NUMA node ID for this lcore */
-	unsigned int core_id;      /**< core number on socket for this lcore */
+	unsigned int core_id;      /**< core number on NUMA node for this lcore */
 	int core_index;            /**< relative index, starting from 0 */
 	uint8_t core_role;         /**< role of core eg: OFF, RTE, SERVICE */
 
@@ -273,8 +273,8 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
  *  Size of segment pages in the MSL.
  * @param n_segs
  *  Number of segments.
- * @param socket_id
- *  Socket ID. Must not be SOCKET_ID_ANY.
+ * @param numa_id
+ *  Socket ID. Must not be RTE_NUMA_ID_ANY.
  * @param heap
  *  Mark MSL as pointing to a heap.
  * @return
@@ -282,7 +282,7 @@ eal_get_virtual_area(void *requested_addr, size_t *size,
  */
 int
 eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
-	uint64_t page_sz, int n_segs, int socket_id, bool heap);
+	uint64_t page_sz, int n_segs, int numa_id, bool heap);
 
 /**
  * Initialize memory segment list and create its backing storage
@@ -295,7 +295,7 @@ eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
  */
 int
 eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
-		int n_segs, int socket_id, int msl_idx, bool heap);
+		int n_segs, int numa_id, int msl_idx, bool heap);
 
 /**
  * Reserve VA space for a memory segment list
@@ -372,7 +372,7 @@ eal_dynmem_hugepage_init(void);
  *  0 on success, (-1) on failure.
  */
 int
-eal_dynmem_calc_num_pages_per_socket(
+eal_dynmem_calc_num_pages_per_numa_node(
 		uint64_t *memory, struct hugepage_info *hp_info,
 		struct hugepage_info *hp_used, unsigned int num_hp_info);
 
diff --git a/lib/eal/common/eal_thread.h b/lib/eal/common/eal_thread.h
index 586de05081..dcd3af5d2a 100644
--- a/lib/eal/common/eal_thread.h
+++ b/lib/eal/common/eal_thread.h
@@ -17,15 +17,15 @@
 __rte_noreturn uint32_t eal_thread_loop(void *arg);
 
 /**
- * Get the NUMA socket id from cpu id.
+ * Get the NUMA node ID from CPU ID.
  * This function is private to EAL.
  *
  * @param cpu_id
  *   The logical process id.
  * @return
- *   socket_id or SOCKET_ID_ANY
+ *   numa_id or RTE_NUMA_ID_ANY
  */
-unsigned eal_cpu_socket_id(unsigned cpu_id);
+unsigned int eal_cpu_numa_id(unsigned int cpu_id);
 
 /**
  * Default buffer size to use with eal_thread_dump_affinity()
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..eb92ebc9b7 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -27,9 +27,9 @@
 #include "malloc_heap.h"
 #include "malloc_mp.h"
 
-/* start external socket ID's at a very high number */
+/* start external NUMA node IDs at a very high number */
 #define CONST_MAX(a, b) (a > b ? a : b) /* RTE_MAX is not a constant */
-#define EXTERNAL_HEAP_MIN_SOCKET_ID (CONST_MAX((1 << 8), RTE_MAX_NUMA_NODES))
+#define EXTERNAL_HEAP_MIN_NUMA_ID (CONST_MAX((1 << 8), RTE_MAX_NUMA_NODES))
 
 static unsigned
 check_hugepage_sz(unsigned flags, uint64_t hugepage_sz)
@@ -69,7 +69,7 @@ check_hugepage_sz(unsigned flags, uint64_t hugepage_sz)
 }
 
 int
-malloc_socket_to_heap_id(unsigned int socket_id)
+malloc_numa_to_heap_id(unsigned int numa_id)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int i;
@@ -77,7 +77,7 @@ malloc_socket_to_heap_id(unsigned int socket_id)
 	for (i = 0; i < RTE_MAX_HEAPS; i++) {
 		struct malloc_heap *heap = &mcfg->malloc_heaps[i];
 
-		if (heap->socket_id == socket_id)
+		if (heap->numa_id == numa_id)
 			return i;
 	}
 	return -1;
@@ -115,9 +115,9 @@ malloc_add_seg(const struct rte_memseg_list *msl,
 	if (msl->external)
 		return 0;
 
-	heap_idx = malloc_socket_to_heap_id(msl->socket_id);
+	heap_idx = malloc_numa_to_heap_id(msl->socket_id);
 	if (heap_idx < 0) {
-		EAL_LOG(ERR, "Memseg list has invalid socket id");
+		EAL_LOG(ERR, "Memseg list has invalid NUMA node ID");
 		return -1;
 	}
 	heap = &mcfg->malloc_heaps[heap_idx];
@@ -135,7 +135,7 @@ malloc_add_seg(const struct rte_memseg_list *msl,
 
 	heap->total_size += len;
 
-	EAL_LOG(DEBUG, "Added %zuM to heap on socket %i", len >> 20,
+	EAL_LOG(DEBUG, "Added %zuM to heap on NUMA node %i", len >> 20,
 			msl->socket_id);
 	return 0;
 }
@@ -291,7 +291,7 @@ rollback_expand_heap(struct rte_memseg **ms, int n_segs,
 /* this function is exposed in malloc_mp.h */
 struct malloc_elem *
 alloc_pages_on_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
-		int socket, unsigned int flags, size_t align, size_t bound,
+		int numa_id, unsigned int flags, size_t align, size_t bound,
 		bool contig, struct rte_memseg **ms, int n_segs)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
@@ -305,14 +305,14 @@ alloc_pages_on_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
 	alloc_sz = (size_t)pg_sz * n_segs;
 
 	/* first, check if we're allowed to allocate this memory */
-	if (eal_memalloc_mem_alloc_validate(socket,
+	if (eal_memalloc_mem_alloc_validate(numa_id,
 			heap->total_size + alloc_sz) < 0) {
 		EAL_LOG(DEBUG, "User has disallowed allocation");
 		return NULL;
 	}
 
 	allocd_pages = eal_memalloc_alloc_seg_bulk(ms, n_segs, pg_sz,
-			socket, true);
+			numa_id, true);
 
 	/* make sure we've allocated our pages... */
 	if (allocd_pages < 0)
@@ -391,7 +391,7 @@ alloc_pages_on_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
 
 static int
 try_expand_heap_primary(struct malloc_heap *heap, uint64_t pg_sz,
-		size_t elt_size, int socket, unsigned int flags, size_t align,
+		size_t elt_size, int numa_id, unsigned int flags, size_t align,
 		size_t bound, bool contig)
 {
 	struct malloc_elem *elem;
@@ -411,7 +411,7 @@ try_expand_heap_primary(struct malloc_heap *heap, uint64_t pg_sz,
 		return -1;
 	memset(ms, 0, sizeof(*ms) * n_segs);
 
-	elem = alloc_pages_on_heap(heap, pg_sz, elt_size, socket, flags, align,
+	elem = alloc_pages_on_heap(heap, pg_sz, elt_size, numa_id, flags, align,
 			bound, contig, ms, n_segs);
 
 	if (elem == NULL)
@@ -439,8 +439,8 @@ try_expand_heap_primary(struct malloc_heap *heap, uint64_t pg_sz,
 	}
 	heap->total_size += alloc_sz;
 
-	EAL_LOG(DEBUG, "Heap on socket %d was expanded by %zdMB",
-		socket, alloc_sz >> 20ULL);
+	EAL_LOG(DEBUG, "Heap on NUMA node %d was expanded by %zdMB",
+		numa_id, alloc_sz >> 20ULL);
 
 	free(ms);
 
@@ -462,7 +462,7 @@ try_expand_heap_primary(struct malloc_heap *heap, uint64_t pg_sz,
 
 static int
 try_expand_heap_secondary(struct malloc_heap *heap, uint64_t pg_sz,
-		size_t elt_size, int socket, unsigned int flags, size_t align,
+		size_t elt_size, int numa_id, unsigned int flags, size_t align,
 		size_t bound, bool contig)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
@@ -478,7 +478,7 @@ try_expand_heap_secondary(struct malloc_heap *heap, uint64_t pg_sz,
 	req.alloc_req.flags = flags;
 	req.alloc_req.elt_size = elt_size;
 	req.alloc_req.page_sz = pg_sz;
-	req.alloc_req.socket = socket;
+	req.alloc_req.numa_id = numa_id;
 	req.alloc_req.malloc_heap_idx = heap - mcfg->malloc_heaps;
 
 	req_result = request_to_primary(&req);
@@ -494,7 +494,7 @@ try_expand_heap_secondary(struct malloc_heap *heap, uint64_t pg_sz,
 
 static int
 try_expand_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
-		int socket, unsigned int flags, size_t align, size_t bound,
+		int numa_id, unsigned int flags, size_t align, size_t bound,
 		bool contig)
 {
 	int ret;
@@ -502,10 +502,10 @@ try_expand_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
 	rte_mcfg_mem_write_lock();
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		ret = try_expand_heap_primary(heap, pg_sz, elt_size, socket,
+		ret = try_expand_heap_primary(heap, pg_sz, elt_size, numa_id,
 				flags, align, bound, contig);
 	} else {
-		ret = try_expand_heap_secondary(heap, pg_sz, elt_size, socket,
+		ret = try_expand_heap_secondary(heap, pg_sz, elt_size, numa_id,
 				flags, align, bound, contig);
 	}
 
@@ -531,7 +531,7 @@ compare_pagesz(const void *a, const void *b)
 }
 
 static int
-alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int socket,
+alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int numa_id,
 		unsigned int flags, size_t align, size_t bound, bool contig)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
@@ -559,7 +559,7 @@ alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int socket,
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
 		struct rte_memseg_list *msl = &mcfg->memsegs[i];
 
-		if (msl->socket_id != socket)
+		if (msl->socket_id != numa_id)
 			continue;
 
 		if (msl->base_va == NULL)
@@ -611,7 +611,7 @@ alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int socket,
 		 * do not pass the size hint here, as user expects other page
 		 * sizes first, before resorting to best effort allocation.
 		 */
-		if (!try_expand_heap(heap, pg_sz, size, socket, size_flags,
+		if (!try_expand_heap(heap, pg_sz, size, numa_id, size_flags,
 				align, bound, contig))
 			return 0;
 	}
@@ -630,7 +630,7 @@ alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int socket,
 	for (i = 0; i < n_other_pg_sz; i++) {
 		uint64_t pg_sz = other_pg_sz[i];
 
-		if (!try_expand_heap(heap, pg_sz, size, socket, flags,
+		if (!try_expand_heap(heap, pg_sz, size, numa_id, flags,
 				align, bound, contig))
 			return 0;
 	}
@@ -645,7 +645,7 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct malloc_heap *heap = &mcfg->malloc_heaps[heap_id];
 	unsigned int size_flags = flags & ~RTE_MEMZONE_SIZE_HINT_ONLY;
-	int socket_id;
+	int numa_id;
 	void *ret;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -666,26 +666,26 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 	 * we just need to request more memory first.
 	 */
 
-	socket_id = rte_socket_id_by_idx(heap_id);
+	numa_id = rte_numa_id_by_idx(heap_id);
 	/*
-	 * if socket ID is negative, we cannot find a socket ID for this heap -
+	 * if NUMA node ID is negative, we cannot find a NUMA node ID for this heap -
 	 * which means it's an external heap. those can have unexpected page
 	 * sizes, so if the user asked to allocate from there - assume user
 	 * knows what they're doing, and allow allocating from there with any
 	 * page size flags.
 	 */
-	if (socket_id < 0)
+	if (numa_id < 0)
 		size_flags |= RTE_MEMZONE_SIZE_HINT_ONLY;
 
 	ret = heap_alloc(heap, size, size_flags, align, bound, contig);
 	if (ret != NULL)
 		goto alloc_unlock;
 
-	/* if socket ID is invalid, this is an external heap */
-	if (socket_id < 0)
+	/* if NUMA node ID is invalid, this is an external heap */
+	if (numa_id < 0)
 		goto alloc_unlock;
 
-	if (!alloc_more_mem_on_socket(heap, size, socket_id, flags, align,
+	if (!alloc_more_mem_on_socket(heap, size, numa_id, flags, align,
 			bound, contig)) {
 		ret = heap_alloc(heap, size, flags, align, bound, contig);
 
@@ -699,68 +699,66 @@ malloc_heap_alloc_on_heap_id(size_t size, unsigned int heap_id, unsigned int fla
 }
 
 static unsigned int
-malloc_get_numa_socket(void)
+malloc_get_default_numa_id(void)
 {
 	const struct internal_config *conf = eal_get_internal_configuration();
-	unsigned int socket_id = rte_socket_id();
+	unsigned int numa_id = rte_numa_id();
 	unsigned int idx;
 
-	if (socket_id != (unsigned int)SOCKET_ID_ANY)
-		return socket_id;
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY)
+		return numa_id;
 
-	/* for control threads, return first socket where memory is available */
-	for (idx = 0; idx < rte_socket_count(); idx++) {
-		int ret = rte_socket_id_by_idx(idx);
-		socket_id = (unsigned int)ret;
-		if (ret != -1 && conf->numa_mem[socket_id] != 0)
-			return socket_id;
+	/* for control threads, return first numa_id where memory is available */
+	for (idx = 0; idx < rte_numa_count(); idx++) {
+		int ret = rte_numa_id_by_idx(idx);
+		numa_id = (unsigned int)ret;
+		if (ret != -1 && conf->numa_mem[numa_id] != 0)
+			return numa_id;
 	}
 	/* We couldn't quickly find a NUMA node where memory was available,
-	 * so fall back to using main lcore socket ID.
+	 * so fall back to using main lcore NUMA node ID.
 	 */
-	socket_id = rte_lcore_to_socket_id(rte_get_main_lcore());
-	/* Main lcore socket ID may be SOCKET_ID_ANY
+	numa_id = rte_lcore_to_numa_id(rte_get_main_lcore());
+	/* Main lcore NUMA node ID may be RTE_NUMA_ID_ANY
 	 * when main lcore thread is affinitized to multiple NUMA nodes.
 	 */
-	if (socket_id != (unsigned int)SOCKET_ID_ANY)
-		return socket_id;
-	/* Failed to find meaningful socket ID, so use the first one available. */
-	return rte_socket_id_by_idx(0);
+	if (numa_id != (unsigned int)RTE_NUMA_ID_ANY)
+		return numa_id;
+	/* Failed to find meaningful NUMA node ID, so use the first one available. */
+	return rte_numa_id_by_idx(0);
 }
 
 void *
-malloc_heap_alloc(size_t size, int socket_arg, unsigned int flags,
+malloc_heap_alloc(size_t size, int numa_id, unsigned int flags,
 		  size_t align, size_t bound, bool contig)
 {
-	int socket, heap_id, i;
+	int heap_id, i;
 	void *ret;
 
 	/* return NULL if size is 0 or alignment is not power-of-2 */
 	if (size == 0 || (align && !rte_is_power_of_2(align)))
 		return NULL;
 
-	if (!rte_eal_has_hugepages() && socket_arg < RTE_MAX_NUMA_NODES)
-		socket_arg = SOCKET_ID_ANY;
+	if (!rte_eal_has_hugepages() && numa_id < RTE_MAX_NUMA_NODES)
+		numa_id = RTE_NUMA_ID_ANY;
 
-	if (socket_arg == SOCKET_ID_ANY)
-		socket = malloc_get_numa_socket();
-	else
-		socket = socket_arg;
+	if (numa_id == RTE_NUMA_ID_ANY)
+		numa_id = malloc_get_default_numa_id();
 
-	/* turn socket ID into heap ID */
-	heap_id = malloc_socket_to_heap_id(socket);
-	/* if heap id is negative, socket ID was invalid */
+	/* turn NUMA node ID into heap ID */
+	heap_id = malloc_numa_to_heap_id(numa_id);
+	/* if heap id is negative, NUMA node ID was invalid */
 	if (heap_id < 0)
 		return NULL;
 
 	ret = malloc_heap_alloc_on_heap_id(size, heap_id, flags, align, bound, contig);
-	if (ret != NULL || socket_arg != SOCKET_ID_ANY)
+	if (ret != NULL || numa_id != RTE_NUMA_ID_ANY)
 		return ret;
 
-	/* try other heaps. we are only iterating through native DPDK sockets,
+	/* try other heaps. we are only iterating through native DPDK NUMA nodes,
 	 * so external heaps won't be included.
 	 */
-	for (i = 0; i < (int) rte_socket_count(); i++) {
+	for (i = 0; i < (int) rte_numa_count(); i++) {
 		if (i == heap_id)
 			continue;
 		ret = malloc_heap_alloc_on_heap_id(size, i, flags, align, bound, contig);
@@ -790,9 +788,9 @@ heap_alloc_biggest_on_heap_id(unsigned int heap_id,
 }
 
 void *
-malloc_heap_alloc_biggest(int socket_arg, unsigned int flags, size_t align, bool contig)
+malloc_heap_alloc_biggest(int numa_id, unsigned int flags, size_t align, bool contig)
 {
-	int socket, i, cur_socket, heap_id;
+	int i, cur_numa_id, heap_id;
 	void *ret;
 
 	/* return NULL if align is not power-of-2 */
@@ -800,27 +798,25 @@ malloc_heap_alloc_biggest(int socket_arg, unsigned int flags, size_t align, bool
 		return NULL;
 
 	if (!rte_eal_has_hugepages())
-		socket_arg = SOCKET_ID_ANY;
+		numa_id = RTE_NUMA_ID_ANY;
 
-	if (socket_arg == SOCKET_ID_ANY)
-		socket = malloc_get_numa_socket();
-	else
-		socket = socket_arg;
+	if (numa_id == RTE_NUMA_ID_ANY)
+		numa_id = malloc_get_default_numa_id();
 
-	/* turn socket ID into heap ID */
-	heap_id = malloc_socket_to_heap_id(socket);
-	/* if heap id is negative, socket ID was invalid */
+	/* turn NUMA node ID into heap ID */
+	heap_id = malloc_numa_to_heap_id(numa_id);
+	/* if heap id is negative, NUMA node ID was invalid */
 	if (heap_id < 0)
 		return NULL;
 
 	ret = heap_alloc_biggest_on_heap_id(heap_id, flags, align, contig);
-	if (ret != NULL || socket_arg != SOCKET_ID_ANY)
+	if (ret != NULL || numa_id != RTE_NUMA_ID_ANY)
 		return ret;
 
 	/* try other heaps */
-	for (i = 0; i < (int) rte_socket_count(); i++) {
-		cur_socket = rte_socket_id_by_idx(i);
-		if (cur_socket == socket)
+	for (i = 0; i < (int) rte_numa_count(); i++) {
+		cur_numa_id = rte_numa_id_by_idx(i);
+		if (cur_numa_id == numa_id)
 			continue;
 		ret = heap_alloc_biggest_on_heap_id(i, flags, align, contig);
 		if (ret != NULL)
@@ -1034,7 +1030,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	/* we didn't exit early, meaning we have unmapped some pages */
 	unmapped = true;
 
-	EAL_LOG(DEBUG, "Heap on socket %d was shrunk by %zdMB",
+	EAL_LOG(DEBUG, "Heap on NUMA node %d was shrunk by %zdMB",
 		msl->socket_id, aligned_len >> 20ULL);
 
 	rte_mcfg_mem_write_unlock();
@@ -1098,7 +1094,7 @@ malloc_heap_resize(struct malloc_elem *elem, size_t size)
  */
 int
 malloc_heap_get_stats(struct malloc_heap *heap,
-		struct rte_malloc_socket_stats *socket_stats)
+		struct rte_malloc_numa_stats *numa_stats)
 {
 	size_t idx;
 	struct malloc_elem *elem;
@@ -1106,26 +1102,26 @@ malloc_heap_get_stats(struct malloc_heap *heap,
 	rte_spinlock_lock(&heap->lock);
 
 	/* Initialise variables for heap */
-	socket_stats->free_count = 0;
-	socket_stats->heap_freesz_bytes = 0;
-	socket_stats->greatest_free_size = 0;
+	numa_stats->free_count = 0;
+	numa_stats->heap_freesz_bytes = 0;
+	numa_stats->greatest_free_size = 0;
 
 	/* Iterate through free list */
 	for (idx = 0; idx < RTE_HEAP_NUM_FREELISTS; idx++) {
 		for (elem = LIST_FIRST(&heap->free_head[idx]);
 			!!elem; elem = LIST_NEXT(elem, free_list))
 		{
-			socket_stats->free_count++;
-			socket_stats->heap_freesz_bytes += elem->size;
-			if (elem->size > socket_stats->greatest_free_size)
-				socket_stats->greatest_free_size = elem->size;
+			numa_stats->free_count++;
+			numa_stats->heap_freesz_bytes += elem->size;
+			if (elem->size > numa_stats->greatest_free_size)
+				numa_stats->greatest_free_size = elem->size;
 		}
 	}
 	/* Get stats on overall heap and allocated memory on this heap */
-	socket_stats->heap_totalsz_bytes = heap->total_size;
-	socket_stats->heap_allocsz_bytes = (socket_stats->heap_totalsz_bytes -
-			socket_stats->heap_freesz_bytes);
-	socket_stats->alloc_count = heap->alloc_count;
+	numa_stats->heap_totalsz_bytes = heap->total_size;
+	numa_stats->heap_allocsz_bytes = (numa_stats->heap_totalsz_bytes -
+			numa_stats->heap_freesz_bytes);
+	numa_stats->alloc_count = heap->alloc_count;
 
 	rte_spinlock_unlock(&heap->lock);
 	return 0;
@@ -1175,7 +1171,7 @@ destroy_elem(struct malloc_elem *elem, size_t len)
 struct rte_memseg_list *
 malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz, const char *seg_name,
-		unsigned int socket_id)
+		unsigned int numa_id)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	char fbarray_name[RTE_FBARRAY_NAME_LEN];
@@ -1221,13 +1217,13 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		ms->len = page_sz;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
-		ms->socket_id = socket_id;
+		ms->socket_id = numa_id;
 	}
 
 	/* set up the memseg list */
 	msl->base_va = va_addr;
 	msl->page_sz = page_sz;
-	msl->socket_id = socket_id;
+	msl->socket_id = numa_id;
 	msl->len = seg_len;
 	msl->version = 0;
 	msl->external = 1;
@@ -1346,11 +1342,11 @@ int
 malloc_heap_create(struct malloc_heap *heap, const char *heap_name)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
-	uint32_t next_socket_id = mcfg->next_socket_id;
+	uint32_t next_numa_id = mcfg->next_numa_id;
 
 	/* prevent overflow. did you really create 2 billion heaps??? */
-	if (next_socket_id > INT32_MAX) {
-		EAL_LOG(ERR, "Cannot assign new socket ID's");
+	if (next_numa_id > INT32_MAX) {
+		EAL_LOG(ERR, "Cannot assign new NUMA node IDs");
 		rte_errno = ENOSPC;
 		return -1;
 	}
@@ -1362,10 +1358,10 @@ malloc_heap_create(struct malloc_heap *heap, const char *heap_name)
 	LIST_INIT(heap->free_head);
 	rte_spinlock_init(&heap->lock);
 	heap->total_size = 0;
-	heap->socket_id = next_socket_id;
+	heap->numa_id = next_numa_id;
 
 	/* we hold a global mem hotplug writelock, so it's safe to increment */
-	mcfg->next_socket_id++;
+	mcfg->next_numa_id++;
 
 	/* set up name */
 	strlcpy(heap->name, heap_name, RTE_HEAP_NAME_MAX_LEN);
@@ -1408,19 +1404,19 @@ rte_eal_malloc_heap_init(void)
 		EAL_LOG(DEBUG, "Hugepages will be freed exactly as allocated.");
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		/* assign min socket ID to external heaps */
-		mcfg->next_socket_id = EXTERNAL_HEAP_MIN_SOCKET_ID;
+		/* assign min NUMA node ID to external heaps */
+		mcfg->next_numa_id = EXTERNAL_HEAP_MIN_NUMA_ID;
 
 		/* assign names to default DPDK heaps */
-		for (i = 0; i < rte_socket_count(); i++) {
+		for (i = 0; i < rte_numa_count(); i++) {
 			struct malloc_heap *heap = &mcfg->malloc_heaps[i];
 			char heap_name[RTE_HEAP_NAME_MAX_LEN];
-			int socket_id = rte_socket_id_by_idx(i);
+			int numa_id = rte_numa_id_by_idx(i);
 
 			snprintf(heap_name, sizeof(heap_name),
-					"socket_%i", socket_id);
+					"numa_%i", numa_id);
 			strlcpy(heap->name, heap_name, RTE_HEAP_NAME_MAX_LEN);
-			heap->socket_id = socket_id;
+			heap->numa_id = numa_id;
 		}
 	}
 
diff --git a/lib/eal/common/malloc_heap.h b/lib/eal/common/malloc_heap.h
index dfc56d4ae3..7a75cce7c4 100644
--- a/lib/eal/common/malloc_heap.h
+++ b/lib/eal/common/malloc_heap.h
@@ -28,17 +28,17 @@ struct __rte_cache_aligned malloc_heap {
 	struct malloc_elem *volatile last;
 
 	unsigned int alloc_count;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	size_t total_size;
 	char name[RTE_HEAP_NAME_MAX_LEN];
 };
 
 void *
-malloc_heap_alloc(size_t size, int socket, unsigned int flags, size_t align,
+malloc_heap_alloc(size_t size, int numa_id, unsigned int flags, size_t align,
 		  size_t bound, bool contig);
 
 void *
-malloc_heap_alloc_biggest(int socket, unsigned int flags, size_t align, bool contig);
+malloc_heap_alloc_biggest(int numa_id, unsigned int flags, size_t align, bool contig);
 
 int
 malloc_heap_create(struct malloc_heap *heap, const char *heap_name);
@@ -49,7 +49,7 @@ malloc_heap_destroy(struct malloc_heap *heap);
 struct rte_memseg_list *
 malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		unsigned int n_pages, size_t page_sz, const char *seg_name,
-		unsigned int socket_id);
+		unsigned int numa_id);
 
 struct rte_memseg_list *
 malloc_heap_find_external_seg(void *va_addr, size_t len);
@@ -73,13 +73,13 @@ malloc_heap_resize(struct malloc_elem *elem, size_t size);
 
 int
 malloc_heap_get_stats(struct malloc_heap *heap,
-		struct rte_malloc_socket_stats *socket_stats);
+		struct rte_malloc_numa_stats *numa_stats);
 
 void
 malloc_heap_dump(struct malloc_heap *heap, FILE *f);
 
 int
-malloc_socket_to_heap_id(unsigned int socket_id);
+malloc_numa_to_heap_id(unsigned int numa_id);
 
 int
 rte_eal_malloc_heap_init(void);
diff --git a/lib/eal/common/malloc_mp.c b/lib/eal/common/malloc_mp.c
index 9765277f5d..e0086ec679 100644
--- a/lib/eal/common/malloc_mp.c
+++ b/lib/eal/common/malloc_mp.c
@@ -232,7 +232,7 @@ handle_alloc_request(const struct malloc_mp_req *m,
 		return -1;
 	}
 
-	/* heap idx is index into the heap array, not socket ID */
+	/* heap idx is index into the heap array, not NUMA node ID */
 	if (ar->malloc_heap_idx >= RTE_MAX_HEAPS) {
 		EAL_LOG(ERR, "Attempting to allocate from invalid heap");
 		return -1;
@@ -242,11 +242,11 @@ handle_alloc_request(const struct malloc_mp_req *m,
 
 	/*
 	 * for allocations, we must only use internal heaps, but since the
-	 * rte_malloc_heap_socket_is_external() is thread-safe and we're already
+	 * rte_malloc_heap_numa_is_external() is thread-safe and we're already
 	 * read-locked, we'll have to take advantage of the fact that internal
-	 * socket ID's are always lower than RTE_MAX_NUMA_NODES.
+	 * NUMA node IDs are always lower than RTE_MAX_NUMA_NODES.
 	 */
-	if (heap->socket_id >= RTE_MAX_NUMA_NODES) {
+	if (heap->numa_id >= RTE_MAX_NUMA_NODES) {
 		EAL_LOG(ERR, "Attempting to allocate from external heap");
 		return -1;
 	}
@@ -263,7 +263,7 @@ handle_alloc_request(const struct malloc_mp_req *m,
 	}
 	memset(ms, 0, sizeof(*ms) * n_segs);
 
-	elem = alloc_pages_on_heap(heap, ar->page_sz, ar->elt_size, ar->socket,
+	elem = alloc_pages_on_heap(heap, ar->page_sz, ar->elt_size, ar->numa_id,
 			ar->flags, ar->align, ar->bound, ar->contig, ms,
 			n_segs);
 
diff --git a/lib/eal/common/malloc_mp.h b/lib/eal/common/malloc_mp.h
index 43dc2a81a2..a540ec627b 100644
--- a/lib/eal/common/malloc_mp.h
+++ b/lib/eal/common/malloc_mp.h
@@ -31,7 +31,7 @@ struct malloc_req_alloc {
 	uint32_t malloc_heap_idx;
 	uint64_t page_sz;
 	size_t elt_size;
-	int socket;
+	int numa_id;
 	unsigned int flags;
 	size_t align;
 	size_t bound;
@@ -75,7 +75,7 @@ malloc_heap_free_pages(void *aligned_start, size_t aligned_len);
 
 struct malloc_elem *
 alloc_pages_on_heap(struct malloc_heap *heap, uint64_t pg_sz, size_t elt_size,
-		int socket, unsigned int flags, size_t align, size_t bound,
+		int numa_id, unsigned int flags, size_t align, size_t bound,
 		bool contig, struct rte_memseg **ms, int n_segs);
 
 void
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 388e5a63b6..90ccded02d 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -70,8 +70,8 @@ eal_free_no_trace(void *addr)
 }
 
 static void *
-malloc_socket(const char *type, size_t size, unsigned int align,
-		int socket_arg, const bool trace_ena)
+malloc_numa(const char *type, size_t size, unsigned int align,
+		int numa_id, const bool trace_ena)
 {
 	void *ptr;
 
@@ -80,37 +80,45 @@ malloc_socket(const char *type, size_t size, unsigned int align,
 		return NULL;
 
 	/* if there are no hugepages and if we are not allocating from an
-	 * external heap, use memory from any socket available. checking for
-	 * socket being external may return -1 in case of invalid socket, but
+	 * external heap, use memory from any NUMA node available. checking for
+	 * NUMA node being external may return -1 in case of invalid NUMA node ID, but
 	 * that's OK - if there are no hugepages, it doesn't matter.
 	 */
-	if (rte_malloc_heap_socket_is_external(socket_arg) != 1 &&
+	if (rte_malloc_heap_numa_is_external(numa_id) != 1 &&
 				!rte_eal_has_hugepages())
-		socket_arg = SOCKET_ID_ANY;
+		numa_id = RTE_NUMA_ID_ANY;
 
-	ptr = malloc_heap_alloc(size, socket_arg, 0,
+	ptr = malloc_heap_alloc(size, numa_id, 0,
 			align == 0 ? 1 : align, 0, false);
 
 	if (trace_ena)
-		rte_eal_trace_mem_malloc(type, size, align, socket_arg, ptr);
+		rte_eal_trace_mem_malloc(type, size, align, numa_id, ptr);
 	return ptr;
 }
 
 /*
  * Allocate memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_malloc_numa)
+void *
+rte_malloc_numa(const char *type, size_t size, unsigned int align,
+		int numa_id)
+{
+	return malloc_numa(type, size, align, numa_id, true);
+}
+
 RTE_EXPORT_SYMBOL(rte_malloc_socket)
 void *
 rte_malloc_socket(const char *type, size_t size, unsigned int align,
-		int socket_arg)
+		int socket)
 {
-	return malloc_socket(type, size, align, socket_arg, true);
+	return rte_malloc_numa(type, size, align, socket);
 }
 
 void *
 eal_malloc_no_trace(const char *type, size_t size, unsigned int align)
 {
-	return malloc_socket(type, size, align, SOCKET_ID_ANY, false);
+	return malloc_numa(type, size, align, RTE_NUMA_ID_ANY, false);
 }
 
 /*
@@ -120,17 +128,17 @@ RTE_EXPORT_SYMBOL(rte_malloc)
 void *
 rte_malloc(const char *type, size_t size, unsigned align)
 {
-	return rte_malloc_socket(type, size, align, SOCKET_ID_ANY);
+	return rte_malloc_numa(type, size, align, RTE_NUMA_ID_ANY);
 }
 
 /*
  * Allocate zero'd memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_zmalloc_socket)
+RTE_EXPORT_SYMBOL(rte_zmalloc_numa)
 void *
-rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
+rte_zmalloc_numa(const char *type, size_t size, unsigned int align, int numa_id)
 {
-	void *ptr = rte_malloc_socket(type, size, align, socket);
+	void *ptr = rte_malloc_numa(type, size, align, numa_id);
 
 	if (ptr != NULL) {
 		struct malloc_elem *elem = malloc_elem_from_data(ptr);
@@ -149,10 +157,17 @@ rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
 		}
 	}
 
-	rte_eal_trace_mem_zmalloc(type, size, align, socket, ptr);
+	rte_eal_trace_mem_zmalloc(type, size, align, numa_id, ptr);
 	return ptr;
 }
 
+RTE_EXPORT_SYMBOL(rte_zmalloc_socket)
+void *
+rte_zmalloc_socket(const char *type, size_t size, unsigned int align, int socket)
+{
+	return rte_zmalloc_numa(type, size, align, socket);
+}
+
 /*
  * Allocate zero'd memory on default heap.
  */
@@ -160,17 +175,24 @@ RTE_EXPORT_SYMBOL(rte_zmalloc)
 void *
 rte_zmalloc(const char *type, size_t size, unsigned align)
 {
-	return rte_zmalloc_socket(type, size, align, SOCKET_ID_ANY);
+	return rte_zmalloc_numa(type, size, align, RTE_NUMA_ID_ANY);
 }
 
 /*
  * Allocate zero'd memory on specified heap.
  */
+RTE_EXPORT_SYMBOL(rte_calloc_numa)
+void *
+rte_calloc_numa(const char *type, size_t num, size_t size, unsigned int align, int numa_id)
+{
+	return rte_zmalloc_numa(type, num * size, align, numa_id);
+}
+
 RTE_EXPORT_SYMBOL(rte_calloc_socket)
 void *
-rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int socket)
+rte_calloc_socket(const char *type, size_t num, size_t size, unsigned int align, int socket)
 {
-	return rte_zmalloc_socket(type, num * size, align, socket);
+	return rte_calloc_numa(type, num, size, align, socket);
 }
 
 /*
@@ -186,14 +208,14 @@ rte_calloc(const char *type, size_t num, size_t size, unsigned align)
 /*
  * Resize allocated memory on specified heap.
  */
-RTE_EXPORT_SYMBOL(rte_realloc_socket)
+RTE_EXPORT_SYMBOL(rte_realloc_numa)
 void *
-rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
+rte_realloc_numa(void *ptr, size_t size, unsigned int align, int numa_id)
 {
 	size_t user_size;
 
 	if (ptr == NULL)
-		return rte_malloc_socket(NULL, size, align, socket);
+		return rte_malloc_numa(NULL, size, align, numa_id);
 
 	struct malloc_elem *elem = malloc_elem_from_data(ptr);
 	if (elem == NULL) {
@@ -205,25 +227,25 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	size = RTE_CACHE_LINE_ROUNDUP(size);
 	align = RTE_CACHE_LINE_ROUNDUP(align);
 
-	/* check requested socket id and alignment matches first, and if ok,
+	/* check requested NUMA node ID and alignment matches first, and if ok,
 	 * see if we can resize block
 	 */
-	if ((socket == SOCKET_ID_ANY ||
-	     (unsigned int)socket == elem->heap->socket_id) &&
+	if ((numa_id == RTE_NUMA_ID_ANY ||
+	     (unsigned int)numa_id == elem->heap->numa_id) &&
 			RTE_PTR_ALIGN(ptr, align) == ptr &&
 			malloc_heap_resize(elem, size) == 0) {
-		rte_eal_trace_mem_realloc(size, align, socket, ptr);
+		rte_eal_trace_mem_realloc(size, align, numa_id, ptr);
 
 		asan_set_redzone(elem, user_size);
 
 		return ptr;
 	}
 
-	/* either requested socket id doesn't match, alignment is off
+	/* either requested NUMA node ID does not match, alignment is off
 	 * or we have no room to expand,
 	 * so move the data.
 	 */
-	void *new_ptr = rte_malloc_socket(NULL, size, align, socket);
+	void *new_ptr = rte_malloc_numa(NULL, size, align, numa_id);
 	if (new_ptr == NULL)
 		return NULL;
 	/* elem: |pad|data_elem|data|trailer| */
@@ -231,10 +253,17 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	rte_memcpy(new_ptr, ptr, old_size < size ? old_size : size);
 	rte_free(ptr);
 
-	rte_eal_trace_mem_realloc(size, align, socket, new_ptr);
+	rte_eal_trace_mem_realloc(size, align, numa_id, new_ptr);
 	return new_ptr;
 }
 
+RTE_EXPORT_SYMBOL(rte_realloc_socket)
+void *
+rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
+{
+	return rte_realloc_numa(ptr, size, align, socket);
+}
+
 /*
  * Resize allocated memory.
  */
@@ -242,7 +271,7 @@ RTE_EXPORT_SYMBOL(rte_realloc)
 void *
 rte_realloc(void *ptr, size_t size, unsigned int align)
 {
-	return rte_realloc_socket(ptr, size, align, SOCKET_ID_ANY);
+	return rte_realloc_numa(ptr, size, align, RTE_NUMA_ID_ANY);
 }
 
 RTE_EXPORT_SYMBOL(rte_malloc_validate)
@@ -258,22 +287,30 @@ rte_malloc_validate(const void *ptr, size_t *size)
 }
 
 /*
- * Function to retrieve data for heap on given socket
+ * Function to retrieve data for heap on given NUMA node
  */
-RTE_EXPORT_SYMBOL(rte_malloc_get_socket_stats)
+RTE_EXPORT_SYMBOL(rte_malloc_get_numa_stats)
 int
-rte_malloc_get_socket_stats(int socket,
-		struct rte_malloc_socket_stats *socket_stats)
+rte_malloc_get_numa_stats(int numa_id,
+		struct rte_malloc_numa_stats *numa_stats)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int heap_idx;
 
-	heap_idx = malloc_socket_to_heap_id(socket);
+	heap_idx = malloc_numa_to_heap_id(numa_id);
 	if (heap_idx < 0)
 		return -1;
 
 	return malloc_heap_get_stats(&mcfg->malloc_heaps[heap_idx],
-			socket_stats);
+			numa_stats);
+}
+
+RTE_EXPORT_SYMBOL(rte_malloc_get_socket_stats)
+int
+rte_malloc_get_socket_stats(int socket,
+		struct rte_malloc_numa_stats *socket_stats)
+{
+	return rte_malloc_get_numa_stats(socket, socket_stats);
 }
 
 /*
@@ -292,9 +329,9 @@ rte_malloc_dump_heaps(FILE *f)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_get_numa_id)
 int
-rte_malloc_heap_get_socket(const char *name)
+rte_malloc_heap_get_numa_id(const char *name)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	struct malloc_heap *heap = NULL;
@@ -319,7 +356,7 @@ rte_malloc_heap_get_socket(const char *name)
 	}
 
 	if (heap != NULL) {
-		ret = heap->socket_id;
+		ret = heap->numa_id;
 	} else {
 		rte_errno = ENOENT;
 		ret = -1;
@@ -329,24 +366,30 @@ rte_malloc_heap_get_socket(const char *name)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external)
+RTE_EXPORT_SYMBOL(rte_malloc_heap_get_socket)
 int
-rte_malloc_heap_socket_is_external(int socket_id)
+rte_malloc_heap_get_socket(const char *name)
+{
+	return rte_malloc_heap_get_numa_id(name);
+}
+
+RTE_EXPORT_SYMBOL(rte_malloc_heap_numa_is_external)
+int
+rte_malloc_heap_numa_is_external(int numa_id)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	unsigned int idx;
 	int ret = -1;
 
-	if (socket_id == SOCKET_ID_ANY)
+	if (numa_id == RTE_NUMA_ID_ANY)
 		return 0;
-
 	rte_mcfg_mem_read_lock();
 	for (idx = 0; idx < RTE_MAX_HEAPS; idx++) {
 		struct malloc_heap *tmp = &mcfg->malloc_heaps[idx];
 
-		if ((int)tmp->socket_id == socket_id) {
-			/* external memory always has large socket ID's */
-			ret = tmp->socket_id >= RTE_MAX_NUMA_NODES;
+		if ((int)tmp->numa_id == numa_id) {
+			/* external memory always has large NUMA node IDs */
+			ret = tmp->numa_id >= RTE_MAX_NUMA_NODES;
 			break;
 		}
 	}
@@ -355,6 +398,13 @@ rte_malloc_heap_socket_is_external(int socket_id)
 	return ret;
 }
 
+RTE_EXPORT_SYMBOL(rte_malloc_heap_socket_is_external)
+int
+rte_malloc_heap_socket_is_external(int socket_id)
+{
+	return rte_malloc_heap_numa_is_external(socket_id);
+}
+
 /*
  * Print stats on memory type. If type is NULL, info on all types is printed
  */
@@ -364,7 +414,7 @@ rte_malloc_dump_stats(FILE *f, __rte_unused const char *type)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	unsigned int heap_id;
-	struct rte_malloc_socket_stats sock_stats;
+	struct rte_malloc_numa_stats sock_stats;
 
 	/* Iterate through all initialised heaps */
 	for (heap_id = 0; heap_id < RTE_MAX_HEAPS; heap_id++) {
@@ -456,7 +506,7 @@ rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 		ret = -1;
 		goto unlock;
 	}
-	if (heap->socket_id < RTE_MAX_NUMA_NODES) {
+	if (heap->numa_id < RTE_MAX_NUMA_NODES) {
 		/* cannot add memory to internal heaps */
 		rte_errno = EPERM;
 		ret = -1;
@@ -465,7 +515,7 @@ rte_malloc_heap_memory_add(const char *heap_name, void *va_addr, size_t len,
 	n = len / page_sz;
 
 	msl = malloc_heap_create_external_seg(va_addr, iova_addrs, n, page_sz,
-			heap_name, heap->socket_id);
+			heap_name, heap->numa_id);
 	if (msl == NULL) {
 		ret = -1;
 		goto unlock;
@@ -505,7 +555,7 @@ rte_malloc_heap_memory_remove(const char *heap_name, void *va_addr, size_t len)
 		ret = -1;
 		goto unlock;
 	}
-	if (heap->socket_id < RTE_MAX_NUMA_NODES) {
+	if (heap->numa_id < RTE_MAX_NUMA_NODES) {
 		/* cannot remove memory from internal heaps */
 		rte_errno = EPERM;
 		ret = -1;
@@ -556,7 +606,7 @@ sync_memory(const char *heap_name, void *va_addr, size_t len, bool attach)
 		goto unlock;
 	}
 	/* we shouldn't be able to sync to internal heaps */
-	if (heap->socket_id < RTE_MAX_NUMA_NODES) {
+	if (heap->numa_id < RTE_MAX_NUMA_NODES) {
 		rte_errno = EPERM;
 		ret = -1;
 		goto unlock;
@@ -680,7 +730,7 @@ rte_malloc_heap_destroy(const char *heap_name)
 	}
 	rte_mcfg_mem_write_lock();
 
-	/* start from non-socket heaps */
+	/* start from non-external heaps */
 	heap = find_named_heap(heap_name);
 	if (heap == NULL) {
 		EAL_LOG(ERR, "Heap %s not found", heap_name);
@@ -689,7 +739,7 @@ rte_malloc_heap_destroy(const char *heap_name)
 		goto unlock;
 	}
 	/* we shouldn't be able to destroy internal heaps */
-	if (heap->socket_id < RTE_MAX_NUMA_NODES) {
+	if (heap->numa_id < RTE_MAX_NUMA_NODES) {
 		rte_errno = EPERM;
 		ret = -1;
 		goto unlock;
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index faf5f0e911..de4918f954 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -351,12 +351,12 @@ eal_get_hugepage_mem_size(void)
 static int
 check_socket(const struct rte_memseg_list *msl, void *arg)
 {
-	int *socket_id = arg;
+	int *numa_id = arg;
 
 	if (msl->external)
 		return 0;
 
-	if (msl->socket_id == *socket_id && msl->memseg_arr.count != 0)
+	if (msl->socket_id == *numa_id && msl->memseg_arr.count != 0)
 		return 1;
 
 	return 0;
@@ -365,13 +365,13 @@ check_socket(const struct rte_memseg_list *msl, void *arg)
 static void
 eal_check_mem_on_local_socket(void)
 {
-	int socket_id;
+	int numa_id;
 	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	numa_id = rte_lcore_to_numa_id(config->main_lcore);
 
-	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
-		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
+	if (rte_memseg_list_walk(check_socket, &numa_id) == 0)
+		EAL_LOG(WARNING, "WARNING: Main lcore has no memory on local NUMA node!");
 }
 
 
diff --git a/lib/eal/freebsd/eal_lcore.c b/lib/eal/freebsd/eal_lcore.c
index 1d3d1b67b9..a1a3b88bc9 100644
--- a/lib/eal/freebsd/eal_lcore.c
+++ b/lib/eal/freebsd/eal_lcore.c
@@ -36,7 +36,7 @@ eal_get_ncpus(void)
 }
 
 unsigned
-eal_cpu_socket_id(__rte_unused unsigned cpu_id)
+eal_cpu_numa_id(__rte_unused unsigned int cpu_id)
 {
 	return 0;
 }
diff --git a/lib/eal/freebsd/eal_memalloc.c b/lib/eal/freebsd/eal_memalloc.c
index 49faf0c6aa..bfaba725b5 100644
--- a/lib/eal/freebsd/eal_memalloc.c
+++ b/lib/eal/freebsd/eal_memalloc.c
@@ -14,14 +14,14 @@
 int
 eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms __rte_unused,
 		int __rte_unused n_segs, size_t __rte_unused page_sz,
-		int __rte_unused socket, bool __rte_unused exact)
+		int __rte_unused numa_id, bool __rte_unused exact)
 {
 	EAL_LOG(ERR, "Memory hotplug not supported on FreeBSD");
 	return -1;
 }
 
 struct rte_memseg *
-eal_memalloc_alloc_seg(size_t __rte_unused page_sz, int __rte_unused socket)
+eal_memalloc_alloc_seg(size_t __rte_unused page_sz, int __rte_unused numa_id)
 {
 	EAL_LOG(ERR, "Memory hotplug not supported on FreeBSD");
 	return NULL;
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index d87e479863..f03e2ad44c 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -238,7 +238,7 @@ rte_eal_hugepage_init(void)
 			seg->len = page_sz;
 			seg->nchannel = mcfg->nchannel;
 			seg->nrank = mcfg->nrank;
-			seg->socket_id = 0;
+			seg->numa_id = 0;
 
 			rte_fbarray_set_used(arr, ms_idx);
 
diff --git a/lib/eal/include/eal_trace_internal.h b/lib/eal/include/eal_trace_internal.h
index 50f91d0929..62c6811f90 100644
--- a/lib/eal/include/eal_trace_internal.h
+++ b/lib/eal/include/eal_trace_internal.h
@@ -93,32 +93,32 @@ RTE_TRACE_POINT(
 RTE_TRACE_POINT(
 	rte_eal_trace_mem_zmalloc,
 	RTE_TRACE_POINT_ARGS(const char *type, size_t size, unsigned int align,
-		int socket, void *ptr),
+		int numa_id, void *ptr),
 	rte_trace_point_emit_string(type);
 	rte_trace_point_emit_size_t(size);
 	rte_trace_point_emit_u32(align);
-	rte_trace_point_emit_int(socket);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_ptr(ptr);
 )
 
 RTE_TRACE_POINT(
 	rte_eal_trace_mem_malloc,
 	RTE_TRACE_POINT_ARGS(const char *type, size_t size, unsigned int align,
-		int socket, void *ptr),
+		int numa_id, void *ptr),
 	rte_trace_point_emit_string(type);
 	rte_trace_point_emit_size_t(size);
 	rte_trace_point_emit_u32(align);
-	rte_trace_point_emit_int(socket);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_ptr(ptr);
 )
 
 RTE_TRACE_POINT(
 	rte_eal_trace_mem_realloc,
-	RTE_TRACE_POINT_ARGS(size_t size, unsigned int align, int socket,
+	RTE_TRACE_POINT_ARGS(size_t size, unsigned int align, int numa_id,
 		void *ptr),
 	rte_trace_point_emit_size_t(size);
 	rte_trace_point_emit_u32(align);
-	rte_trace_point_emit_int(socket);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_ptr(ptr);
 )
 
@@ -131,12 +131,12 @@ RTE_TRACE_POINT(
 /* Memzone */
 RTE_TRACE_POINT(
 	rte_eal_trace_memzone_reserve,
-	RTE_TRACE_POINT_ARGS(const char *name, size_t len, int socket_id,
+	RTE_TRACE_POINT_ARGS(const char *name, size_t len, int numa_id,
 		unsigned int flags, unsigned int align, unsigned int bound,
 		const void *mz),
 	rte_trace_point_emit_string(name);
 	rte_trace_point_emit_size_t(len);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 	rte_trace_point_emit_u32(flags);
 	rte_trace_point_emit_u32(align);
 	rte_trace_point_emit_u32(bound);
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 1b192a6727..904d80fe28 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -8,7 +8,7 @@
 /**
  * @file
  *
- * API for lcore and socket manipulation
+ * API for lcore and NUMA node manipulation
  */
 #include <stdio.h>
 
@@ -117,8 +117,21 @@ unsigned int rte_lcore_count(void);
  */
 int rte_lcore_index(int lcore_id);
 
+/**
+ * Return the ID of the NUMA node of the logical core we are running on.
+ *
+ * For non EAL threads, RTE_NUMA_ID_ANY is returned.
+ *
+ * @return
+ *   the ID of current lcore's NUMA node
+ */
+unsigned int rte_numa_id(void);
+
 /**
  * Return the ID of NUMA node of the logical core we are running on.
+ *
+ * This is a legacy alias of rte_numa_id().
+ *
  * @return
  *   the ID of current lcoreid's NUMA node
  */
@@ -135,13 +148,24 @@ unsigned int rte_socket_id(void);
  *   the number of NUMA ID's as recognized by EAL
  */
 unsigned int
+rte_numa_count(void);
+
+/**
+ * Return number of NUMA nodes detected on the system.
+ *
+ * This is a legacy alias of rte_numa_count().
+ *
+ * @return
+ *   the number of NUMA ID's as recognized by EAL
+ */
+unsigned int
 rte_socket_count(void);
 
 /**
- * Return socket id with a particular index.
+ * Return NUMA node ID with a particular index.
  *
- * This will return socket id at a particular position in list of all detected
- * NUMA node ID's.
+ * This will return NUMA node ID at a particular position in list of all
+ * detected NUMA node ID's.
  * For example, on a machine with NUMA nodes [0, 8],
  * passing 1 as a parameter will return 8.
  *
@@ -153,6 +177,21 @@ rte_socket_count(void);
  *   - -1 on error, with errno set to EINVAL
  */
 int
+rte_numa_id_by_idx(unsigned int idx);
+
+/**
+ * Return NUMA node ID with a particular index.
+ *
+ * This is a legacy alias of rte_numa_id_by_idx().
+ *
+ * @param idx
+ *   index of NUMA node ID to return
+ *
+ * @return
+ *   - NUMA node ID as recognized by EAL
+ *   - -1 on error, with errno set to EINVAL
+ */
+int
 rte_socket_id_by_idx(unsigned int idx);
 
 /**
@@ -161,6 +200,19 @@ rte_socket_id_by_idx(unsigned int idx);
  * @param lcore_id
  *   the targeted lcore, which MUST be between 0 and RTE_MAX_LCORE-1.
  * @return
+ *   the ID of lcore's NUMA node
+ */
+unsigned int
+rte_lcore_to_numa_id(unsigned int lcore_id);
+
+/**
+ * Get the ID of the NUMA node of the specified lcore
+ *
+ * This is a legacy alias of rte_lcore_to_numa_id().
+ *
+ * @param lcore_id
+ *   the targeted lcore, which MUST be between 0 and RTE_MAX_LCORE-1.
+ * @return
  *   the ID of lcoreid's NUMA node
  */
 unsigned int
@@ -177,13 +229,13 @@ rte_lcore_to_socket_id(unsigned int lcore_id);
  *
  * @param cpu_id
  *   The OS logical CPU ID. If cpu_id does not identify a detected CPU, the
- *   function returns SOCKET_ID_ANY.
+ *   function returns RTE_NUMA_ID_ANY.
  * @return
- *   The ID of cpu_id's NUMA node, or SOCKET_ID_ANY if cpu_id is not valid.
+ *   The ID of cpu_id's NUMA node, or RTE_NUMA_ID_ANY if cpu_id is not valid.
  */
 __rte_experimental
 unsigned int
-rte_cpu_socket_id(unsigned int cpu_id);
+rte_cpu_numa_id(unsigned int cpu_id);
 
 /**
  * Return the id of the lcore on a socket starting from zero.
diff --git a/lib/eal/include/rte_malloc.h b/lib/eal/include/rte_malloc.h
index 0a397e7723..9d5d582e1a 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -20,9 +20,9 @@ extern "C" {
 #endif
 
 /**
- *  Structure to hold heap statistics obtained from rte_malloc_get_socket_stats function.
+ *  Structure to hold heap statistics obtained from rte_malloc_get_numa_stats function.
  */
-struct rte_malloc_socket_stats {
+struct rte_malloc_numa_stats {
 	size_t heap_totalsz_bytes; /**< Total bytes on heap */
 	size_t heap_freesz_bytes;  /**< Total free bytes on heap */
 	size_t greatest_free_size; /**< Size in bytes of largest free block */
@@ -77,7 +77,7 @@ rte_free_sensitive(void *ptr);
 /**
  * This function allocates memory from the huge-page area of memory. The memory
  * is not cleared. In NUMA systems, the memory allocated resides on the same
- * NUMA socket as the core that calls this function.
+ * NUMA node as the core that calls this function.
  *
  * @param type
  *   A string identifying the type of allocated objects (useful for tracing).
@@ -105,7 +105,7 @@ rte_malloc(const char *type, size_t size, unsigned align)
  *
  * Equivalent to rte_malloc() except that the memory zone is
  * initialised with zeros. In NUMA systems, the memory allocated resides on the
- * same NUMA socket as the core that calls this function.
+ * same NUMA node as the core that calls this function.
  *
  * @param type
  *   A string identifying the type of allocated objects (useful for tracing).
@@ -131,7 +131,7 @@ rte_zmalloc(const char *type, size_t size, unsigned align)
 /**
  * Replacement function for calloc(), using huge-page memory. Memory area is
  * initialised with zeros. In NUMA systems, the memory allocated resides on the
- * same NUMA socket as the core that calls this function.
+ * same NUMA node as the core that calls this function.
  *
  * @param type
  *   A string identifying the type of allocated objects (useful for tracing).
@@ -184,7 +184,36 @@ rte_realloc(void *ptr, size_t size, unsigned int align)
 /**
  * Replacement function for realloc(), using huge-page memory. Reserved area
  * memory is resized, preserving contents. In NUMA systems, the new area
- * resides on requested NUMA socket.
+ * resides on requested NUMA node.
+ *
+ * @param ptr
+ *   Pointer to already allocated memory
+ * @param size
+ *   Size (in bytes) of new area. If this is 0, memory is freed.
+ * @param align
+ *   If 0, the return is a pointer that is suitably aligned for any kind of
+ *   variable (in the same manner as malloc()).
+ *   Otherwise, the return is a pointer that is a multiple of *align*. In
+ *   this case, it must obviously be a power of two. (Minimum alignment is the
+ *   cacheline size, i.e. 64-bytes)
+ * @param numa_id
+ *   NUMA node ID to allocate memory on.
+ * @return
+ *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
+ *     align is not a power of two).
+ *   - Otherwise, the pointer to the reallocated memory.
+ */
+void *
+rte_realloc_numa(void *ptr, size_t size, unsigned int align, int numa_id)
+	__rte_alloc_size(2) __rte_alloc_align(3)
+	__rte_malloc __rte_dealloc_free;
+
+/**
+ * Replacement function for realloc(), using huge-page memory. Reserved area
+ * memory is resized, preserving contents. In NUMA systems, the new area
+ * resides on requested NUMA node.
+ *
+ * This is a legacy alias of rte_realloc_numa().
  *
  * @param ptr
  *   Pointer to already allocated memory
@@ -223,8 +252,38 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
  *   Otherwise, the return is a pointer that is a multiple of *align*. In
  *   this case, it must be a power of two. (Minimum alignment is the
  *   cacheline size, i.e. 64-bytes)
+ * @param numa_id
+ *   NUMA node ID to allocate memory on. If RTE_NUMA_ID_ANY is used, this
+ *   function will behave the same as rte_malloc().
+ * @return
+ *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
+ *     align is not a power of two).
+ *   - Otherwise, the pointer to the allocated object.
+ */
+void *
+rte_malloc_numa(const char *type, size_t size, unsigned int align, int numa_id)
+	__rte_alloc_size(2) __rte_alloc_align(3)
+	__rte_malloc __rte_dealloc_free;
+
+/**
+ * This function allocates memory from the huge-page area of memory. The memory
+ * is not cleared.
+ *
+ * This is a legacy alias of rte_malloc_numa().
+ *
+ * @param type
+ *   A string identifying the type of allocated objects (useful for tracing).
+ *   Can be NULL.
+ * @param size
+ *   Size (in bytes) to be allocated.
+ * @param align
+ *   If 0, the return is a pointer that is suitably aligned for any kind of
+ *   variable (in the same manner as malloc()).
+ *   Otherwise, the return is a pointer that is a multiple of *align*. In
+ *   this case, it must be a power of two. (Minimum alignment is the
+ *   cacheline size, i.e. 64-bytes)
  * @param socket
- *   NUMA socket to allocate memory on. If SOCKET_ID_ANY is used, this function
+ *   NUMA socket to allocate memory on. If RTE_NUMA_ID_ANY is used, this function
  *   will behave the same as rte_malloc().
  * @return
  *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
@@ -232,7 +291,37 @@ rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
-rte_malloc_socket(const char *type, size_t size, unsigned align, int socket)
+rte_malloc_socket(const char *type, size_t size, unsigned int align, int socket)
+	__rte_alloc_size(2) __rte_alloc_align(3)
+	__rte_malloc __rte_dealloc_free;
+
+/**
+ * Allocate zeroed memory from the heap.
+ *
+ * Equivalent to rte_malloc() except that the memory zone is
+ * initialised with zeros.
+ *
+ * @param type
+ *   A string identifying the type of allocated objects (useful for tracing).
+ *   Can be NULL.
+ * @param size
+ *   Size (in bytes) to be allocated.
+ * @param align
+ *   If 0, the return is a pointer that is suitably aligned for any kind of
+ *   variable (in the same manner as malloc()).
+ *   Otherwise, the return is a pointer that is a multiple of *align*. In
+ *   this case, it must obviously be a power of two. (Minimum alignment is the
+ *   cacheline size, i.e. 64-bytes)
+ * @param numa_id
+ *   NUMA node ID to allocate memory on. If RTE_NUMA_ID_ANY is used, this
+ *   function will behave the same as rte_zmalloc().
+ * @return
+ *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
+ *     align is not a power of two).
+ *   - Otherwise, the pointer to the allocated object.
+ */
+void *
+rte_zmalloc_numa(const char *type, size_t size, unsigned int align, int numa_id)
 	__rte_alloc_size(2) __rte_alloc_align(3)
 	__rte_malloc __rte_dealloc_free;
 
@@ -242,6 +331,8 @@ rte_malloc_socket(const char *type, size_t size, unsigned align, int socket)
  * Equivalent to rte_malloc() except that the memory zone is
  * initialised with zeros.
  *
+ * This is a legacy alias of rte_zmalloc_numa().
+ *
  * @param type
  *   A string identifying the type of allocated objects (useful for tracing).
  *   Can be NULL.
@@ -254,7 +345,7 @@ rte_malloc_socket(const char *type, size_t size, unsigned align, int socket)
  *   this case, it must obviously be a power of two. (Minimum alignment is the
  *   cacheline size, i.e. 64-bytes)
  * @param socket
- *   NUMA socket to allocate memory on. If SOCKET_ID_ANY is used, this function
+ *   NUMA socket to allocate memory on. If RTE_NUMA_ID_ANY is used, this function
  *   will behave the same as rte_zmalloc().
  * @return
  *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
@@ -262,7 +353,7 @@ rte_malloc_socket(const char *type, size_t size, unsigned align, int socket)
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
-rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
+rte_zmalloc_socket(const char *type, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2) __rte_alloc_align(3)
 	__rte_malloc __rte_dealloc_free;
 
@@ -283,8 +374,40 @@ rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
  *   Otherwise, the return is a pointer that is a multiple of *align*. In
  *   this case, it must obviously be a power of two. (Minimum alignment is the
  *   cacheline size, i.e. 64-bytes)
+ * @param numa_id
+ *   NUMA node ID to allocate memory on. If RTE_NUMA_ID_ANY is used, this
+ *   function will behave the same as rte_calloc().
+ * @return
+ *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
+ *     align is not a power of two).
+ *   - Otherwise, the pointer to the allocated object.
+ */
+void *
+rte_calloc_numa(const char *type, size_t num, size_t size, unsigned int align, int numa_id)
+	__rte_alloc_size(2, 3)	__rte_alloc_align(4)
+	__rte_malloc __rte_dealloc_free;
+
+/**
+ * Replacement function for calloc(), using huge-page memory. Memory area is
+ * initialised with zeros.
+ *
+ * This is a legacy alias of rte_calloc_numa().
+ *
+ * @param type
+ *   A string identifying the type of allocated objects (useful for tracing).
+ *   Can be NULL.
+ * @param num
+ *   Number of elements to be allocated.
+ * @param size
+ *   Size (in bytes) of a single element.
+ * @param align
+ *   If 0, the return is a pointer that is suitably aligned for any kind of
+ *   variable (in the same manner as malloc()).
+ *   Otherwise, the return is a pointer that is a multiple of *align*. In
+ *   this case, it must obviously be a power of two. (Minimum alignment is the
+ *   cacheline size, i.e. 64-bytes)
  * @param socket
- *   NUMA socket to allocate memory on. If SOCKET_ID_ANY is used, this function
+ *   NUMA socket to allocate memory on. If RTE_NUMA_ID_ANY is used, this function
  *   will behave the same as rte_calloc().
  * @return
  *   - NULL on error. Not enough memory, or invalid arguments (size is 0,
@@ -292,7 +415,7 @@ rte_zmalloc_socket(const char *type, size_t size, unsigned align, int socket)
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
-rte_calloc_socket(const char *type, size_t num, size_t size, unsigned align, int socket)
+rte_calloc_socket(const char *type, size_t num, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2, 3)	__rte_alloc_align(4)
 	__rte_malloc __rte_dealloc_free;
 
@@ -322,6 +445,23 @@ rte_malloc_validate(const void *ptr, size_t *size);
  * @note This function is not thread-safe with respect to
  *    ``rte_malloc_heap_create()``/``rte_malloc_heap_destroy()`` functions.
  *
+ * @param numa_id
+ *   An unsigned integer specifying the NUMA node ID to get heap statistics for
+ * @param numa_stats
+ *   A structure which provides memory to store statistics
+ * @return
+ *   Null on error
+ *   Pointer to structure storing statistics on success
+ */
+int
+rte_malloc_get_numa_stats(int numa_id,
+		struct rte_malloc_numa_stats *numa_stats);
+
+/**
+ * Get heap statistics for the specified heap.
+ *
+ * This is a legacy alias of rte_malloc_get_numa_stats().
+ *
  * @param socket
  *   An unsigned integer specifying the socket to get heap statistics for
  * @param socket_stats
@@ -332,7 +472,7 @@ rte_malloc_validate(const void *ptr, size_t *size);
  */
 int
 rte_malloc_get_socket_stats(int socket,
-		struct rte_malloc_socket_stats *socket_stats);
+		struct rte_malloc_numa_stats *socket_stats);
 
 /**
  * Add memory chunk to a heap with specified name.
@@ -459,7 +599,7 @@ rte_malloc_heap_memory_detach(const char *heap_name, void *va_addr, size_t len);
  * Creates a new empty malloc heap with a specified name.
  *
  * @note Heaps created via this call will automatically get assigned a unique
- *   socket ID, which can be found using ``rte_malloc_heap_get_socket()``
+ *   NUMA node ID, which can be found using ``rte_malloc_heap_get_numa_id()``
  *
  * @param heap_name
  *   Name of the heap to create.
@@ -497,9 +637,25 @@ rte_malloc_heap_create(const char *heap_name);
 int
 rte_malloc_heap_destroy(const char *heap_name);
 
+/**
+ * Find NUMA node ID corresponding to a named heap.
+ *
+ * @param name
+ *   Heap name to find NUMA node ID for
+ * @return
+ *   NUMA node ID in case of success (a non-negative number)
+ *   -1 in case of error, with rte_errno set to one of the following:
+ *     EINVAL - ``name`` was NULL
+ *     ENOENT - heap identified by the name ``name`` was not found
+ */
+int
+rte_malloc_heap_get_numa_id(const char *name);
+
 /**
  * Find socket ID corresponding to a named heap.
  *
+ * This is a legacy alias of rte_malloc_heap_get_numa_id().
+ *
  * @param name
  *   Heap name to find socket ID for
  * @return
@@ -511,10 +667,25 @@ rte_malloc_heap_destroy(const char *heap_name);
 int
 rte_malloc_heap_get_socket(const char *name);
 
+/**
+ * Check if a given NUMA node ID refers to externally allocated memory.
+ *
+ * @note Passing RTE_NUMA_ID_ANY will return 0.
+ *
+ * @param numa_id
+ *   NUMA node ID to check
+ * @return
+ *   1 if NUMA node ID refers to externally allocated memory
+ *   0 if NUMA node ID refers to internal DPDK memory
+ *   -1 if NUMA node ID is invalid
+ */
+int
+rte_malloc_heap_numa_is_external(int numa_id);
+
 /**
  * Check if a given socket ID refers to externally allocated memory.
  *
- * @note Passing SOCKET_ID_ANY will return 0.
+ * This is a legacy alias of rte_malloc_heap_numa_is_external().
  *
  * @param socket_id
  *   Socket ID to check
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index 940770f1eb..2633550524 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -36,7 +36,13 @@ extern "C" {
 #define RTE_PGSIZE_4G   (1ULL << 32)
 #define RTE_PGSIZE_16G  (1ULL << 34)
 
-#define SOCKET_ID_ANY -1                    /**< Any NUMA socket. */
+/** Any NUMA node ID. */
+#define RTE_NUMA_ID_ANY -1
+
+/**
+ * Legacy alias of RTE_NUMA_ID_ANY.
+ */
+#define SOCKET_ID_ANY RTE_NUMA_ID_ANY
 
 /** Prevent this segment from being freed back to the OS. */
 #define RTE_MEMSEG_FLAG_DO_NOT_FREE RTE_BIT32(0)
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 5a0e1b8a15..125241c538 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -98,7 +98,7 @@ size_t rte_memzone_max_get(void);
  *   new allocations.
  *
  * @note: When reserving memzones with len set to 0, it is preferable to also
- *   set a valid socket_id. Setting socket_id to SOCKET_ID_ANY is supported, but
+ *   set a valid socket_id. Setting socket_id to RTE_NUMA_ID_ANY is supported, but
  *   will likely not yield expected results. Specifically, the resulting memzone
  *   may not necessarily be the biggest memzone available, but rather biggest
  *   memzone available on socket id corresponding to an lcore from which
@@ -112,7 +112,7 @@ size_t rte_memzone_max_get(void);
  *   is 0, the biggest contiguous zone will be reserved.
  * @param socket_id
  *   The socket identifier in the case of
- *   NUMA. The value can be SOCKET_ID_ANY if there is no NUMA
+ *   NUMA. The value can be RTE_NUMA_ID_ANY if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   The flags parameter is used to request memzones to be
@@ -161,7 +161,7 @@ const struct rte_memzone *rte_memzone_reserve(const char *name,
  *   new allocations.
  *
  * @note: When reserving memzones with len set to 0, it is preferable to also
- *   set a valid socket_id. Setting socket_id to SOCKET_ID_ANY is supported, but
+ *   set a valid socket_id. Setting socket_id to RTE_NUMA_ID_ANY is supported, but
  *   will likely not yield expected results. Specifically, the resulting memzone
  *   may not necessarily be the biggest memzone available, but rather biggest
  *   memzone available on socket id corresponding to an lcore from which
@@ -175,7 +175,7 @@ const struct rte_memzone *rte_memzone_reserve(const char *name,
  *   is 0, the biggest contiguous zone will be reserved.
  * @param socket_id
  *   The socket identifier in the case of
- *   NUMA. The value can be SOCKET_ID_ANY if there is no NUMA
+ *   NUMA. The value can be RTE_NUMA_ID_ANY if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   The flags parameter is used to request memzones to be
@@ -229,7 +229,7 @@ const struct rte_memzone *rte_memzone_reserve_aligned(const char *name,
  *   new allocations.
  *
  * @note: When reserving memzones with len set to 0, it is preferable to also
- *   set a valid socket_id. Setting socket_id to SOCKET_ID_ANY is supported, but
+ *   set a valid socket_id. Setting socket_id to RTE_NUMA_ID_ANY is supported, but
  *   will likely not yield expected results. Specifically, the resulting memzone
  *   may not necessarily be the biggest memzone available, but rather biggest
  *   memzone available on socket id corresponding to an lcore from which
@@ -243,7 +243,7 @@ const struct rte_memzone *rte_memzone_reserve_aligned(const char *name,
  *   is 0, the biggest contiguous zone will be reserved.
  * @param socket_id
  *   The socket identifier in the case of
- *   NUMA. The value can be SOCKET_ID_ANY if there is no NUMA
+ *   NUMA. The value can be RTE_NUMA_ID_ANY if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   The flags parameter is used to request memzones to be
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 278504237d..0d26c780f2 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -434,24 +434,24 @@ eal_hugedirs_unlock(void)
 static int
 check_socket(const struct rte_memseg_list *msl, void *arg)
 {
-	int *socket_id = arg;
+	int *numa_id = arg;
 
 	if (msl->external)
 		return 0;
 
-	return *socket_id == msl->socket_id;
+	return *numa_id == msl->socket_id;
 }
 
 static void
 eal_check_mem_on_local_socket(void)
 {
-	int socket_id;
+	int numa_id;
 	const struct rte_config *config = rte_eal_get_configuration();
 
-	socket_id = rte_lcore_to_socket_id(config->main_lcore);
+	numa_id = rte_lcore_to_numa_id(config->main_lcore);
 
-	if (rte_memseg_list_walk(check_socket, &socket_id) == 0)
-		EAL_LOG(WARNING, "WARNING: Main core has no memory on local socket!");
+	if (rte_memseg_list_walk(check_socket, &numa_id) == 0)
+		EAL_LOG(WARNING, "WARNING: Main lcore has no memory on local NUMA node!");
 }
 
 static int
@@ -526,8 +526,8 @@ eal_worker_thread_create(unsigned int lcore_id)
 	stack_size = eal_get_internal_configuration()->huge_worker_stack_size;
 	if (stack_size != 0) {
 		/* Allocate NUMA aware stack memory and set pthread attributes */
-		stack_ptr = rte_zmalloc_socket("lcore_stack", stack_size,
-			RTE_CACHE_LINE_SIZE, rte_lcore_to_socket_id(lcore_id));
+		stack_ptr = rte_zmalloc_numa("lcore_stack", stack_size,
+			RTE_CACHE_LINE_SIZE, rte_lcore_to_numa_id(lcore_id));
 		if (stack_ptr == NULL) {
 			rte_eal_init_alert("Cannot allocate worker lcore stack memory");
 			rte_errno = ENOMEM;
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 05c5b3f613..9eec3789f0 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -136,29 +136,29 @@ get_num_hugepages(const char *subdir, size_t sz, unsigned int reusable_pages)
 }
 
 static uint32_t
-get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
+get_num_hugepages_on_node(const char *subdir, unsigned int numa_id, size_t sz)
 {
-	char *path = NULL, *socketpath = NULL;
-	DIR *socketdir;
+	char *path = NULL, *numapath = NULL;
+	DIR *numadir;
 	unsigned long num_pages = 0;
 	const char *nr_hp_file = "free_hugepages";
 
-	if (asprintf(&socketpath, "%s/node%u/hugepages", sys_pages_numa_dir_path, socket) < 0) {
+	if (asprintf(&numapath, "%s/node%u/hugepages", sys_pages_numa_dir_path, numa_id) < 0) {
 		EAL_LOG(ERR, "Can not format node huge page path");
-		socketpath = NULL;
+		numapath = NULL;
 		goto nopages;
 	}
 
-	socketdir = opendir(socketpath);
-	if (socketdir) {
+	numadir = opendir(numapath);
+	if (numadir) {
 		/* Keep calm and carry on */
-		closedir(socketdir);
+		closedir(numadir);
 	} else {
-		/* Can't find socket dir, so ignore it */
+		/* Cannot find NUMA node dir, so ignore it */
 		goto nopages;
 	}
 
-	if (asprintf(&path, "%s/%s/%s", socketpath, subdir, nr_hp_file) < 0) {
+	if (asprintf(&path, "%s/%s/%s", numapath, subdir, nr_hp_file) < 0) {
 		EAL_LOG(ERR, "Can not format free hugepages path");
 		path = NULL;
 		goto nopages;
@@ -169,7 +169,7 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 
 	if (num_pages == 0)
 		EAL_LOG(WARNING, "No free %zu kB hugepages reported on node %u",
-				sz >> 10, socket);
+				sz >> 10, numa_id);
 
 	/*
 	 * we want to return a uint32_t and more than this looks suspicious
@@ -180,7 +180,7 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 
 nopages:
 	free(path);
-	free(socketpath);
+	free(numapath);
 
 	return num_pages;
 }
@@ -406,9 +406,9 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 		eal_get_internal_configuration();
 
 	/*
-	 * first, try to put all hugepages into relevant sockets, but
+	 * first, try to put all hugepages into relevant NUMA nodes, but
 	 * if first attempts fails, fall back to collecting all pages
-	 * in one socket and sorting them later
+	 * in one NUMA node and sorting them later
 	 */
 	total_pages = 0;
 
@@ -420,13 +420,13 @@ calc_num_pages(struct hugepage_info *hpi, struct dirent *dirent,
 	 * but it is precisely what hugepage file reuse is trying to avoid.
 	 */
 	if (!internal_conf->legacy_mem && reusable_pages == 0)
-		for (i = 0; i < rte_socket_count(); i++) {
-			int socket = rte_socket_id_by_idx(i);
+		for (i = 0; i < rte_numa_count(); i++) {
+			int numa_id = rte_numa_id_by_idx(i);
 			unsigned int num_pages =
 					get_num_hugepages_on_node(
-						dirent->d_name, socket,
+						dirent->d_name, numa_id,
 						hpi->hugepage_sz);
-			hpi->num_pages[socket] = num_pages;
+			hpi->num_pages[numa_id] = num_pages;
 			total_pages += num_pages;
 		}
 	/*
@@ -555,7 +555,7 @@ hugepage_info_init(void)
 
 	/* now we have all info, check we have at least one valid size */
 	for (i = 0; i < num_sizes; i++) {
-		/* pages may no longer all be on socket 0, so check all */
+		/* pages may no longer all be on NUMA node 0, so check all */
 		unsigned int j, num_pages = 0;
 		struct hugepage_info *hpi = &internal_conf->hugepage_info[i];
 
@@ -571,7 +571,7 @@ hugepage_info_init(void)
 
 /*
  * when we initialize the hugepage info, everything goes
- * to socket 0 by default. it will later get sorted by memory
+ * to NUMA node 0 by default. it will later get sorted by memory
  * initialization procedure.
  */
 int
diff --git a/lib/eal/linux/eal_lcore.c b/lib/eal/linux/eal_lcore.c
index 29b36dd610..ce2c28b591 100644
--- a/lib/eal/linux/eal_lcore.c
+++ b/lib/eal/linux/eal_lcore.c
@@ -38,7 +38,7 @@ eal_cpu_detected(unsigned lcore_id)
  * found on any numa node, returns zero.
  */
 unsigned
-eal_cpu_socket_id(unsigned lcore_id)
+eal_cpu_numa_id(unsigned int lcore_id)
 {
 	unsigned socket;
 
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 8bfcbb1469..6003f04bd7 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -136,7 +136,7 @@ check_numa(void)
 }
 
 static void
-prepare_numa(int *oldpolicy, struct bitmask *oldmask, int socket_id)
+prepare_numa(int *oldpolicy, struct bitmask *oldmask, int numa_id)
 {
 	EAL_LOG(DEBUG, "Trying to obtain current memory policy.");
 	if (get_mempolicy(oldpolicy, oldmask->maskp,
@@ -147,9 +147,9 @@ prepare_numa(int *oldpolicy, struct bitmask *oldmask, int socket_id)
 		*oldpolicy = MPOL_DEFAULT;
 	}
 	EAL_LOG(DEBUG,
-		"Setting policy MPOL_PREFERRED for socket %d",
-		socket_id);
-	numa_set_preferred(socket_id);
+		"Setting policy MPOL_PREFERRED for NUMA node %d",
+		numa_id);
+	numa_set_preferred(numa_id);
 }
 
 static void
@@ -498,7 +498,7 @@ resize_hugefile(int fd, uint64_t fa_offset, uint64_t page_sz, bool grow,
 }
 
 static int
-alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
+alloc_seg(struct rte_memseg *ms, void *addr, int numa_id,
 		struct hugepage_info *hi, unsigned int list_idx,
 		unsigned int seg_idx)
 {
@@ -615,7 +615,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	/*
 	 * If the kernel has been built without NUMA support, get_mempolicy()
 	 * will return an error. If check_numa() returns false, memory
-	 * allocation is not NUMA aware and the socket_id should not be
+	 * allocation is not NUMA aware and the numa_id should not be
 	 * checked.
 	 */
 	if (check_numa()) {
@@ -625,15 +625,15 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 			EAL_LOG(DEBUG, "%s(): get_mempolicy: %s",
 				__func__, strerror(errno));
 			goto mapped;
-		} else if (cur_socket_id != socket_id) {
+		} else if (cur_socket_id != numa_id) {
 			EAL_LOG(DEBUG,
-					"%s(): allocation happened on wrong socket (wanted %d, got %d)",
-				__func__, socket_id, cur_socket_id);
+					"%s(): allocation happened on wrong NUMA node (wanted %d, got %d)",
+				__func__, numa_id, cur_socket_id);
 			goto mapped;
 		}
 	}
 #else
-	if (rte_socket_count() > 1)
+	if (rte_numa_count() > 1)
 		EAL_LOG(DEBUG, "%s(): not checking hugepage NUMA node.",
 				__func__);
 #endif
@@ -646,7 +646,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 	ms->nchannel = rte_memory_get_nchannel();
 	ms->nrank = rte_memory_get_nrank();
 	ms->iova = iova;
-	ms->socket_id = socket_id;
+	ms->socket_id = numa_id;
 	ms->flags = dirty ? RTE_MEMSEG_FLAG_DIRTY : 0;
 
 	return 0;
@@ -762,7 +762,7 @@ struct alloc_walk_param {
 	size_t page_sz;
 	unsigned int segs_allocated;
 	unsigned int n_segs;
-	int socket;
+	int numa_id;
 	bool exact;
 };
 static int
@@ -779,7 +779,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
-	if (msl->socket_id != wa->socket)
+	if (msl->socket_id != wa->numa_id)
 		return 0;
 
 	page_sz = (size_t)msl->page_sz;
@@ -854,7 +854,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 		map_addr = RTE_PTR_ADD(cur_msl->base_va,
 				cur_idx * page_sz);
 
-		if (alloc_seg(cur, map_addr, wa->socket, wa->hi,
+		if (alloc_seg(cur, map_addr, wa->numa_id, wa->hi,
 				msl_idx, cur_idx)) {
 			EAL_LOG(DEBUG, "attempted to allocate %i segments, but only %i were allocated",
 				need, i);
@@ -970,7 +970,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 int
 eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
-		int socket, bool exact)
+		int numa_id, bool exact)
 {
 	int i, ret = -1;
 #ifdef RTE_EAL_NUMA_AWARE_HUGEPAGES
@@ -1005,7 +1005,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 #ifdef RTE_EAL_NUMA_AWARE_HUGEPAGES
 	if (check_numa()) {
 		oldmask = numa_allocate_nodemask();
-		prepare_numa(&oldpolicy, oldmask, socket);
+		prepare_numa(&oldpolicy, oldmask, numa_id);
 		have_numa = true;
 	}
 #endif
@@ -1015,7 +1015,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 	wa.ms = ms;
 	wa.n_segs = n_segs;
 	wa.page_sz = page_sz;
-	wa.socket = socket;
+	wa.numa_id = numa_id;
 	wa.segs_allocated = 0;
 
 	/* memalloc is locked, so it's safe to use thread-unsafe version */
@@ -1036,10 +1036,10 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs, size_t page_sz,
 }
 
 struct rte_memseg *
-eal_memalloc_alloc_seg(size_t page_sz, int socket)
+eal_memalloc_alloc_seg(size_t page_sz, int numa_id)
 {
 	struct rte_memseg *ms;
-	if (eal_memalloc_alloc_seg_bulk(&ms, 1, page_sz, socket, true) < 0)
+	if (eal_memalloc_alloc_seg_bulk(&ms, 1, page_sz, numa_id, true) < 0)
 		return NULL;
 	/* return pointer to newly allocated memseg */
 	return ms;
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 614f31a308..601173c188 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -431,7 +431,7 @@ map_all_hugepages(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi,
 static int
 find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 {
-	int socket_id;
+	int numa_id;
 	char *end, *nodestr;
 	unsigned i, hp_count = 0;
 	uint64_t virt_addr;
@@ -443,7 +443,7 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 	f = fopen("/proc/self/numa_maps", "r");
 	if (f == NULL) {
 		EAL_LOG(NOTICE, "NUMA support not available"
-			" consider that all memory is in socket_id 0");
+			" consider that all memory is in numa_id 0");
 		return 0;
 	}
 
@@ -487,22 +487,22 @@ find_numasocket(struct hugepage_file *hugepg_tbl, struct hugepage_info *hpi)
 		end[0] = '\0';
 		end = NULL;
 
-		socket_id = strtoul(nodestr, &end, 0);
+		numa_id = strtoul(nodestr, &end, 0);
 		if ((nodestr[0] == '\0') || (end == NULL) || (*end != '\0')) {
 			EAL_LOG(ERR, "%s(): error in numa_maps parsing", __func__);
 			goto error;
 		}
 
-		/* if we find this page in our mappings, set socket_id */
+		/* if we find this page in our mappings, set numa_id */
 		for (i = 0; i < hpi->num_pages[0]; i++) {
 			void *va = (void *)(unsigned long)virt_addr;
 			if (hugepg_tbl[i].orig_va == va) {
-				hugepg_tbl[i].socket_id = socket_id;
+				hugepg_tbl[i].numa_id = numa_id;
 				hp_count++;
 #ifdef RTE_EAL_NUMA_AWARE_HUGEPAGES
 				EAL_LOG(DEBUG,
 					"Hugepage %s is on socket %d",
-					hugepg_tbl[i].filepath, socket_id);
+					hugepg_tbl[i].filepath, numa_id);
 #endif
 			}
 		}
@@ -649,7 +649,7 @@ unmap_unneeded_hugepages(struct hugepage_file *hugepg_tbl,
 
 				/* find a page that matches the criteria */
 				if ((hp->size == hpi[size].hugepage_sz) &&
-						(hp->socket_id == (int) socket)) {
+						(hp->numa_id == (int) socket)) {
 
 					/* if we skipped enough pages, unmap the rest */
 					if (pages_found == hpi[size].num_pages[socket]) {
@@ -691,17 +691,17 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	int ms_idx;
 	uint64_t page_sz;
 	size_t memseg_len;
-	int socket_id;
+	int numa_id;
 #ifndef RTE_ARCH_64
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 #endif
 	page_sz = hugepages[seg_start].size;
-	socket_id = hugepages[seg_start].socket_id;
+	numa_id = hugepages[seg_start].numa_id;
 	seg_len = seg_end - seg_start;
 
 	EAL_LOG(DEBUG, "Attempting to map %" PRIu64 "M on socket %i",
-			(seg_len * page_sz) >> 20ULL, socket_id);
+			(seg_len * page_sz) >> 20ULL, numa_id);
 
 	/* find free space in memseg lists */
 	for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS; msl_idx++) {
@@ -712,7 +712,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 
 		if (msl->page_sz != page_sz)
 			continue;
-		if (msl->socket_id != socket_id)
+		if (msl->socket_id != numa_id)
 			continue;
 
 		/* leave space for a hole if array is not empty */
@@ -813,7 +813,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		ms->hugepage_sz = page_sz;
 		ms->len = memseg_len;
 		ms->iova = hfile->physaddr;
-		ms->socket_id = hfile->socket_id;
+		ms->socket_id = hfile->numa_id;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
 
@@ -825,7 +825,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 				rte_strerror(rte_errno));
 	}
 	EAL_LOG(DEBUG, "Allocated %" PRIu64 "M on socket %i",
-			(seg_len * page_sz) >> 20, socket_id);
+			(seg_len * page_sz) >> 20, numa_id);
 	return seg_len;
 }
 
@@ -877,10 +877,10 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 		uint64_t page_sz =
 			internal_conf->hugepage_info[hpi_idx].hugepage_sz;
 
-		for (i = 0; i < rte_socket_count(); i++) {
+		for (i = 0; i < rte_numa_count(); i++) {
 			struct rte_memseg_list *msl;
 
-			socket = rte_socket_id_by_idx(i);
+			socket = rte_numa_id_by_idx(i);
 			n_contig_segs = 0;
 			n_segs = 0;
 			seg_start_page = -1;
@@ -898,7 +898,7 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 
 				if (cur->size == 0)
 					end_seg = 1;
-				else if (cur->socket_id != (int) socket)
+				else if (cur->numa_id != (int) socket)
 					end_seg = 1;
 				else if (cur->size != page_sz)
 					end_seg = 1;
@@ -1024,7 +1024,7 @@ remap_needed_hugepages(struct hugepage_file *hugepages, int n_pages)
 
 		if (cur_page == 0)
 			new_memseg = 1;
-		else if (cur->socket_id != prev->socket_id)
+		else if (cur->numa_id != prev->numa_id)
 			new_memseg = 1;
 		else if (cur->size != prev->size)
 			new_memseg = 1;
@@ -1362,7 +1362,7 @@ eal_legacy_hugepage_init(void)
 
 	/* get hugepages for each socket */
 	for (i = 0; i < nr_hugefiles; i++) {
-		int socket = tmp_hp[i].socket_id;
+		int socket = tmp_hp[i].numa_id;
 
 		/* find a hugepage info with right size and increment num_pages */
 		const int nb_hpsizes = RTE_MIN(MAX_HUGEPAGE_SIZES,
@@ -1380,7 +1380,7 @@ eal_legacy_hugepage_init(void)
 		memory[i] = internal_conf->numa_mem[i];
 
 	/* calculate final number of pages */
-	nr_hugepages = eal_dynmem_calc_num_pages_per_socket(memory,
+	nr_hugepages = eal_dynmem_calc_num_pages_per_numa_node(memory,
 			internal_conf->hugepage_info, used_hp,
 			internal_conf->num_hugepage_sizes);
 
@@ -1706,7 +1706,7 @@ memseg_primary_init_32(void)
 	const uint64_t mem32_max_mem = 2ULL << 30;
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int active_sockets, hpi_idx, msl_idx = 0;
-	unsigned int socket_id, i;
+	unsigned int numa_id, i;
 	struct rte_memseg_list *msl;
 	uint64_t extra_mem_per_socket, total_extra_mem, total_requested_mem;
 	struct internal_config *internal_conf =
@@ -1736,11 +1736,11 @@ memseg_primary_init_32(void)
 	active_sockets = 0;
 	total_requested_mem = 0;
 	if (internal_conf->force_numa)
-		for (i = 0; i < rte_socket_count(); i++) {
+		for (i = 0; i < rte_numa_count(); i++) {
 			uint64_t mem;
 
-			socket_id = rte_socket_id_by_idx(i);
-			mem = internal_conf->numa_mem[socket_id];
+			numa_id = rte_numa_id_by_idx(i);
+			mem = internal_conf->numa_mem[numa_id];
 
 			if (mem == 0)
 				continue;
@@ -1774,7 +1774,7 @@ memseg_primary_init_32(void)
 	 */
 
 	/* create memseg lists */
-	for (i = 0; i < rte_socket_count(); i++) {
+	for (i = 0; i < rte_numa_count(); i++) {
 		int hp_sizes = (int) internal_conf->num_hugepage_sizes;
 		uint64_t max_socket_mem, cur_socket_mem;
 		unsigned int main_lcore_socket;
@@ -1782,37 +1782,37 @@ memseg_primary_init_32(void)
 		bool skip;
 		int ret;
 
-		ret = rte_socket_id_by_idx(i);
+		ret = rte_numa_id_by_idx(i);
 		if (ret == -1) {
 			EAL_LOG(ERR, "Cannot get socket ID for socket index %u", i);
 			return -1;
 		}
-		socket_id = (unsigned int)ret;
+		numa_id = (unsigned int)ret;
 
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
 		/* we can still sort pages by socket in legacy mode */
-		if (!internal_conf->legacy_mem && socket_id > 0)
+		if (!internal_conf->legacy_mem && numa_id > 0)
 			break;
 #endif
 
 		/* if we didn't specifically request memory on this socket */
 		skip = active_sockets != 0 &&
-				internal_conf->numa_mem[socket_id] == 0;
+				internal_conf->numa_mem[numa_id] == 0;
 		/* ...or if we didn't specifically request memory on *any*
 		 * socket, and this is not main lcore
 		 */
-		main_lcore_socket = rte_lcore_to_socket_id(cfg->main_lcore);
-		skip |= active_sockets == 0 && socket_id != main_lcore_socket;
+		main_lcore_socket = rte_lcore_to_numa_id(cfg->main_lcore);
+		skip |= active_sockets == 0 && numa_id != main_lcore_socket;
 
 		if (skip) {
 			EAL_LOG(DEBUG, "Will not preallocate memory on socket %u",
-					socket_id);
+					numa_id);
 			continue;
 		}
 
 		/* max amount of memory on this socket */
 		max_socket_mem = (active_sockets != 0 ?
-					internal_conf->numa_mem[socket_id] :
+					internal_conf->numa_mem[numa_id] :
 					internal_conf->memory) +
 					extra_mem_per_socket;
 		cur_socket_mem = 0;
@@ -1827,7 +1827,7 @@ memseg_primary_init_32(void)
 			hugepage_sz = hpi->hugepage_sz;
 
 			/* check if pages are actually available */
-			if (hpi->num_pages[socket_id] == 0)
+			if (hpi->num_pages[numa_id] == 0)
 				continue;
 
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
@@ -1843,7 +1843,7 @@ memseg_primary_init_32(void)
 
 			EAL_LOG(DEBUG, "Attempting to preallocate "
 					"%" PRIu64 "M on socket %i",
-					max_pagesz_mem >> 20, socket_id);
+					max_pagesz_mem >> 20, numa_id);
 
 			while (cur_pagesz_mem < max_pagesz_mem) {
 				uint64_t rem_mem;
@@ -1862,7 +1862,7 @@ memseg_primary_init_32(void)
 					msl = &mcfg->memsegs[msl_idx];
 
 					if (eal_memseg_list_init(msl, hugepage_sz,
-							n_segs, socket_id, msl_idx, true) < 0) {
+							n_segs, numa_id, msl_idx, true) < 0) {
 						/* failing to allocate a memseg list is a serious error. */
 						EAL_LOG(ERR, "Cannot allocate memseg list");
 						return -1;
@@ -1889,7 +1889,7 @@ memseg_primary_init_32(void)
 		}
 		if (cur_socket_mem == 0) {
 			EAL_LOG(ERR, "Cannot allocate VA space on socket %u",
-				socket_id);
+				numa_id);
 			return -1;
 		}
 	}
@@ -1947,7 +1947,7 @@ memseg_secondary_init_dynmem(void)
 			return -1;
 		}
 
-		EAL_LOG(DEBUG, "Attaching segment list: n_segs:%u socket_id:%d hugepage_sz:%" PRIu64,
+		EAL_LOG(DEBUG, "Attaching segment list: n_segs:%u numa_id:%d hugepage_sz:%" PRIu64,
 			msl->memseg_arr.len, msl->socket_id, msl->page_sz);
 	}
 
@@ -2025,7 +2025,7 @@ rte_eal_memseg_init(void)
 		EAL_LOG(ERR, "Cannot get current resource limits");
 	}
 #ifndef RTE_EAL_NUMA_AWARE_HUGEPAGES
-	if (!internal_conf->legacy_mem && rte_socket_count() > 1) {
+	if (!internal_conf->legacy_mem && rte_numa_count() > 1) {
 		EAL_LOG(WARNING, "DPDK is running on a NUMA system, but is compiled without NUMA support.");
 		EAL_LOG(WARNING, "This will have adverse consequences for performance and usability.");
 		EAL_LOG(WARNING, "Please use --legacy-mem option, or recompile with NUMA support.");
diff --git a/lib/eal/windows/eal_hugepages.c b/lib/eal/windows/eal_hugepages.c
index ff72b8ee38..c48c93da0c 100644
--- a/lib/eal/windows/eal_hugepages.c
+++ b/lib/eal/windows/eal_hugepages.c
@@ -60,7 +60,7 @@ static int
 hugepage_info_init(void)
 {
 	struct hugepage_info *hpi;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	int ret = 0;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -77,21 +77,21 @@ hugepage_info_init(void)
 	 * because Windows neither advertises additional limits,
 	 * nor provides an API to query them.
 	 */
-	for (socket_id = 0; socket_id < rte_socket_count(); socket_id++) {
+	for (numa_id = 0; numa_id < rte_numa_count(); numa_id++) {
 		ULONGLONG bytes;
 		unsigned int numa_node;
 
-		numa_node = eal_socket_numa_node(socket_id);
+		numa_node = eal_socket_numa_node(numa_id);
 		if (!GetNumaAvailableMemoryNodeEx(numa_node, &bytes)) {
 			RTE_LOG_WIN32_ERR("GetNumaAvailableMemoryNodeEx(%u)",
 				numa_node);
 			continue;
 		}
 
-		hpi->num_pages[socket_id] = bytes / hpi->hugepage_sz;
+		hpi->num_pages[numa_id] = bytes / hpi->hugepage_sz;
 		EAL_LOG(DEBUG,
-			"Found %u hugepages of %zu bytes on socket %u",
-			hpi->num_pages[socket_id], hpi->hugepage_sz, socket_id);
+			"Found %u hugepages of %zu bytes on NUMA node %u",
+			hpi->num_pages[numa_id], hpi->hugepage_sz, numa_id);
 	}
 
 	/* No hugepage filesystem on Windows. */
diff --git a/lib/eal/windows/eal_lcore.c b/lib/eal/windows/eal_lcore.c
index d2a2c2d091..71c7cfccae 100644
--- a/lib/eal/windows/eal_lcore.c
+++ b/lib/eal/windows/eal_lcore.c
@@ -31,21 +31,21 @@
 #endif
 
 struct lcore_map {
-	unsigned int socket_id;
+	unsigned int numa_id;
 	unsigned int core_id;
 };
 
-struct socket_map {
+struct numa_map {
 	uint16_t node_id;
 	unsigned int lcore_count;
 };
 
 struct cpu_map {
 	unsigned int lcore_count;
-	unsigned int socket_count;
+	unsigned int numa_count;
 	unsigned int cpu_count;
 	struct lcore_map lcores[RTE_MAX_LCORE];
-	struct socket_map sockets[RTE_MAX_NUMA_NODES];
+	struct numa_map nodes[RTE_MAX_NUMA_NODES];
 	GROUP_AFFINITY cpus[CPU_SETSIZE];
 };
 
@@ -128,7 +128,7 @@ eal_create_lcore_map(const SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *info)
 	const unsigned int node_id = info->NumaNode.NodeNumber;
 	const GROUP_AFFINITY *group_masks = EAL_NUMA_GROUP_MASKS(info->NumaNode);
 	struct lcore_map *lcore;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	unsigned int group_count;
 	unsigned int group_no;
 	unsigned int i;
@@ -141,17 +141,17 @@ eal_create_lcore_map(const SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *info)
 	 * of a physical processor comprise one NUMA node, but two
 	 * processor groups, because group size is limited by 32/64.
 	 */
-	for (socket_id = 0; socket_id < cpu_map.socket_count; socket_id++)
-		if (cpu_map.sockets[socket_id].node_id == node_id)
+	for (numa_id = 0; numa_id < cpu_map.numa_count; numa_id++)
+		if (cpu_map.nodes[numa_id].node_id == node_id)
 			break;
 
-	if (socket_id == cpu_map.socket_count) {
-		if (socket_id == RTE_DIM(cpu_map.sockets))
+	if (numa_id == cpu_map.numa_count) {
+		if (numa_id == RTE_DIM(cpu_map.nodes))
 			return true;
 
-		cpu_map.sockets[socket_id].node_id = node_id;
-		cpu_map.sockets[socket_id].lcore_count = 0;
-		cpu_map.socket_count++;
+		cpu_map.nodes[numa_id].node_id = node_id;
+		cpu_map.nodes[numa_id].lcore_count = 0;
+		cpu_map.numa_count++;
 	}
 
 	/* Old Windows versions report NUMA nodes with GroupCount == 0 */
@@ -170,11 +170,11 @@ eal_create_lcore_map(const SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX *info)
 				return true;
 
 			lcore = &cpu_map.lcores[cpu_map.lcore_count];
-			lcore->socket_id = socket_id;
+			lcore->numa_id = numa_id;
 
-			/* core_id within the socket */
-			lcore->core_id = cpu_map.sockets[socket_id].lcore_count;
-			cpu_map.sockets[socket_id].lcore_count++;
+			/* core_id within the NUMA node */
+			lcore->core_id = cpu_map.nodes[numa_id].lcore_count;
+			cpu_map.nodes[numa_id].lcore_count++;
 			cpu_map.lcore_count++;
 		}
 	}
@@ -247,7 +247,7 @@ eal_create_cpu_map(void)
 	if (full) {
 		/* Not a fatal error, but important for troubleshooting. */
 		log_early("Enumerated maximum of %u NUMA nodes and %u cores\n",
-			cpu_map.socket_count, cpu_map.lcore_count);
+			cpu_map.numa_count, cpu_map.lcore_count);
 	}
 
 	free(infos);
@@ -262,9 +262,9 @@ eal_cpu_detected(unsigned int lcore_id)
 }
 
 unsigned
-eal_cpu_socket_id(unsigned int lcore_id)
+eal_cpu_numa_id(unsigned int lcore_id)
 {
-	return cpu_map.lcores[lcore_id].socket_id;
+	return cpu_map.lcores[lcore_id].numa_id;
 }
 
 unsigned
@@ -274,9 +274,9 @@ eal_cpu_core_id(unsigned int lcore_id)
 }
 
 unsigned int
-eal_socket_numa_node(unsigned int socket_id)
+eal_socket_numa_node(unsigned int numa_id)
 {
-	return cpu_map.sockets[socket_id].node_id;
+	return cpu_map.nodes[numa_id].node_id;
 }
 
 PGROUP_AFFINITY
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 232749573a..2f956adc1a 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -32,7 +32,7 @@ eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 }
 
 static int
-alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
+alloc_seg(struct rte_memseg *ms, void *requested_addr, int numa_id,
 	struct hugepage_info *hi)
 {
 	HANDLE current_process;
@@ -46,33 +46,33 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
 	if (ms->len > 0) {
 		/* If a segment is already allocated as needed, return it. */
 		if ((ms->addr == requested_addr) &&
-			(ms->socket_id == socket_id) &&
+			(ms->socket_id == numa_id) &&
 			(ms->hugepage_sz == hi->hugepage_sz)) {
 			return 0;
 		}
 
 		/* Bugcheck, should not happen. */
 		EAL_LOG(DEBUG, "Attempted to reallocate segment %p "
-			"(size %zu) on socket %d", ms->addr,
+			"(size %zu) on NUMA node %d", ms->addr,
 			ms->len, ms->socket_id);
 		return -1;
 	}
 
 	current_process = GetCurrentProcess();
-	numa_node = eal_socket_numa_node(socket_id);
+	numa_node = eal_socket_numa_node(numa_id);
 	alloc_sz = hi->hugepage_sz;
 
 	if (requested_addr == NULL) {
 		/* Request a new chunk of memory from OS. */
-		addr = eal_mem_alloc_socket(alloc_sz, socket_id);
+		addr = eal_mem_alloc_socket(alloc_sz, numa_id);
 		if (addr == NULL) {
 			EAL_LOG(DEBUG, "Cannot allocate %zu bytes "
-				"on socket %d", alloc_sz, socket_id);
+				"on NUMA node %d", alloc_sz, numa_id);
 			return -1;
 		}
 	} else {
 		/* Requested address is already reserved, commit memory. */
-		addr = eal_mem_commit(requested_addr, alloc_sz, socket_id);
+		addr = eal_mem_commit(requested_addr, alloc_sz, numa_id);
 
 		/* During commitment, memory is temporary freed and might
 		 * be allocated by different non-EAL thread. This is a fatal
@@ -87,8 +87,8 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
 
 		if (addr == NULL) {
 			EAL_LOG(DEBUG, "Cannot commit reserved memory %p "
-				"(size %zu) on socket %d",
-				requested_addr, alloc_sz, socket_id);
+				"(size %zu) on NUMA node %d",
+				requested_addr, alloc_sz, numa_id);
 			return -1;
 		}
 	}
@@ -120,8 +120,8 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
 	}
 	if (page->Node != numa_node) {
 		EAL_LOG(DEBUG,
-			"NUMA node hint %u (socket %d) not respected, got %u",
-			numa_node, socket_id, page->Node);
+			"NUMA node hint %u (numa_id %d) not respected, got %u",
+			numa_node, numa_id, page->Node);
 		goto error;
 	}
 
@@ -131,7 +131,7 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int socket_id,
 	ms->nchannel = rte_memory_get_nchannel();
 	ms->nrank = rte_memory_get_nrank();
 	ms->iova = iova;
-	ms->socket_id = socket_id;
+	ms->socket_id = numa_id;
 
 	return 0;
 
@@ -171,7 +171,7 @@ struct alloc_walk_param {
 	size_t page_sz;
 	unsigned int segs_allocated;
 	unsigned int n_segs;
-	int socket;
+	int numa_id;
 	bool exact;
 };
 
@@ -187,7 +187,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
-	if (msl->socket_id != wa->socket)
+	if (msl->socket_id != wa->numa_id)
 		return 0;
 
 	page_sz = (size_t)msl->page_sz;
@@ -237,7 +237,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 		cur = rte_fbarray_get(&cur_msl->memseg_arr, cur_idx);
 		map_addr = RTE_PTR_ADD(cur_msl->base_va, cur_idx * page_sz);
 
-		if (alloc_seg(cur, map_addr, wa->socket, wa->hi)) {
+		if (alloc_seg(cur, map_addr, wa->numa_id, wa->hi)) {
 			EAL_LOG(DEBUG, "attempted to allocate %i segments, "
 				"but only %i were allocated", need, i);
 
@@ -313,7 +313,7 @@ free_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 int
 eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
-		size_t page_sz, int socket, bool exact)
+		size_t page_sz, int numa_id, bool exact)
 {
 	unsigned int i;
 	int ret = -1;
@@ -345,7 +345,7 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 	wa.ms = ms;
 	wa.n_segs = n_segs;
 	wa.page_sz = page_sz;
-	wa.socket = socket;
+	wa.numa_id = numa_id;
 	wa.segs_allocated = 0;
 
 	/* memalloc is locked, so it's safe to use thread-unsafe version */
@@ -361,10 +361,10 @@ eal_memalloc_alloc_seg_bulk(struct rte_memseg **ms, int n_segs,
 }
 
 struct rte_memseg *
-eal_memalloc_alloc_seg(size_t page_sz, int socket)
+eal_memalloc_alloc_seg(size_t page_sz, int numa_id)
 {
 	struct rte_memseg *ms = NULL;
-	eal_memalloc_alloc_seg_bulk(&ms, 1, page_sz, socket, true);
+	eal_memalloc_alloc_seg_bulk(&ms, 1, page_sz, numa_id, true);
 	return ms;
 }
 
diff --git a/lib/eal/windows/eal_memory.c b/lib/eal/windows/eal_memory.c
index 9f85191016..67aba17d24 100644
--- a/lib/eal/windows/eal_memory.c
+++ b/lib/eal/windows/eal_memory.c
@@ -317,21 +317,21 @@ eal_mem_reserve(void *requested_addr, size_t size, int flags)
 }
 
 void *
-eal_mem_alloc_socket(size_t size, int socket_id)
+eal_mem_alloc_socket(size_t size, int numa_id)
 {
 	DWORD flags = MEM_RESERVE | MEM_COMMIT;
 	void *addr;
 
 	flags = MEM_RESERVE | MEM_COMMIT | MEM_LARGE_PAGES;
 	addr = VirtualAllocExNuma(GetCurrentProcess(), NULL, size, flags,
-		PAGE_READWRITE, eal_socket_numa_node(socket_id));
+		PAGE_READWRITE, eal_socket_numa_node(numa_id));
 	if (addr == NULL)
 		rte_errno = ENOMEM;
 	return addr;
 }
 
 void *
-eal_mem_commit(void *requested_addr, size_t size, int socket_id)
+eal_mem_commit(void *requested_addr, size_t size, int numa_id)
 {
 	HANDLE process;
 	MEM_EXTENDED_PARAMETER param;
@@ -374,11 +374,11 @@ eal_mem_commit(void *requested_addr, size_t size, int socket_id)
 		}
 	}
 
-	if (socket_id != SOCKET_ID_ANY) {
+	if (numa_id != RTE_NUMA_ID_ANY) {
 		param_count = 1;
 		memset(&param, 0, sizeof(param));
 		param.Type = MemExtendedParameterNumaNode;
-		param.ULong = eal_socket_numa_node(socket_id);
+		param.ULong = eal_socket_numa_node(numa_id);
 	}
 
 	flags = MEM_RESERVE | MEM_COMMIT | MEM_LARGE_PAGES;
diff --git a/lib/eal/windows/eal_windows.h b/lib/eal/windows/eal_windows.h
index 91cf15eaaa..a07fc086c9 100644
--- a/lib/eal/windows/eal_windows.h
+++ b/lib/eal/windows/eal_windows.h
@@ -38,14 +38,14 @@
 int eal_create_cpu_map(void);
 
 /**
- * Get system NUMA node number for a socket ID.
+ * Get system NUMA node number for a NUMA node ID.
  *
- * @param socket_id
- *  Valid EAL socket ID.
+ * @param numa_id
+ *  Valid EAL NUMA node ID.
  * @return
  *  NUMA node number to use with Win32 API.
  */
-unsigned int eal_socket_numa_node(unsigned int socket_id);
+unsigned int eal_socket_numa_node(unsigned int numa_id);
 
 /**
  * Get pointer to the group affinity for the cpu.
@@ -98,12 +98,12 @@ int eal_mem_win32api_init(void);
  *
  * @param size
  *  Number of bytes to allocate. Must be a multiple of huge page size.
- * @param socket_id
+ * @param numa_id
  *  Socket ID.
  * @return
  *  Address of the memory allocated on success or NULL on failure.
  */
-void *eal_mem_alloc_socket(size_t size, int socket_id);
+void *eal_mem_alloc_socket(size_t size, int numa_id);
 
 /**
  * Commit memory previously reserved with eal_mem_reserve()
@@ -113,13 +113,13 @@ void *eal_mem_alloc_socket(size_t size, int socket_id);
  *  Address within a reserved region. Must not be NULL.
  * @param size
  *  Number of bytes to commit. Must be a multiple of page size.
- * @param socket_id
- *  Socket ID to allocate on. Can be SOCKET_ID_ANY.
+ * @param numa_id
+ *  Socket ID to allocate on. Can be RTE_NUMA_ID_ANY.
  * @return
  *  On success, address of the committed memory, that is, requested_addr.
  *  On failure, NULL and rte_errno is set.
  */
-void *eal_mem_commit(void *requested_addr, size_t size, int socket_id);
+void *eal_mem_commit(void *requested_addr, size_t size, int numa_id);
 
 /**
  * Put allocated or committed memory back into reserved state.
-- 
2.55.0

