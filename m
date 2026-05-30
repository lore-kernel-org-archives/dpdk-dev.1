Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195AFCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 09:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53A74064F;
	Sat, 30 May 2026 11:26:54 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 454C24060A
 for <dev@dpdk.org>; Sat, 30 May 2026 11:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133213;
 bh=LSyVL7Urhq2kxVr04OS4gJ8kUdrM7thIadP0zKCjiFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PcTIcPZ5Q9nzCOlU4TYWrRerv2C3rkyB2gEjWbIs7dnYPC7v2zbzflwlnPfir+884
 x01KBfDCZgCqlvj5Cqe53HN0DEDVrkwBhCQm1IjpiqW5ebqa4Ps4JGc+P1FBJUcYGu
 aAtp4pcMQDjBEBRk29n2w/Dt+Cip6xyNxBtKERt5DqBe4onOZtdNJquBLd7pURPkjC
 9I2o+fC++dNpTdEP2ATr3bUlu/+MRP7NpDSRk1/RPkva7RjZfGlEm3gfOu7xyHd8wj
 fiafkhYcVCkSOGBdgWtOi7UE73e51b07wAkKC2+gzkk948zI0g1kB0PUdzgSjV6ws6
 8q2oreCkfMxfA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C4001EB8F
 for <dev@dpdk.org>; Sat, 30 May 2026 11:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133212;
 bh=LSyVL7Urhq2kxVr04OS4gJ8kUdrM7thIadP0zKCjiFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DvlYdebTM5Z9z8cqiR5NcOxoJWinHf6pkppdj4oUnJyOSGguVlHhh5pYO9Xw5c2Tv
 6whgMrmUNhmpFyAkFgmpKt7xexXZMl9R9uDiSS0OVeHK+LkrsKe2Jg4kvQZcsPx5Nj
 NDXrOCFrMcRGzMqtBKNiehPb8KiHklmEybcb451aBCcR6JkfRuejuSmGfxr62Jxl5e
 GnfzGkmyz1EQHY3eF8bQOoPKZsTSzIMgxgsOswof1bR1dxc/00GEKAF7lvDOAcw7/z
 FYSJSmRZlRPCUw/Vf8aD8IH/Hd/Yhum2sqdwvRH9Hx9sFBnbgDuKW8ZjPhqNFQEt8a
 IPueqU2TJ9qKg==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id A674CEC0D; Sat, 30 May 2026 11:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133198;
 bh=LSyVL7Urhq2kxVr04OS4gJ8kUdrM7thIadP0zKCjiFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UIYAr+hir2CqFzjZK0JDatkX5UZ9hqqrbRpfN+PZpK0Sej2TYD9d6tgPovT7FUUG3
 hxUltFTBhTN1R3mFRQDfM0Rgj0Xtm5/ugM5J9DGKdUO8cEadtGkcrPUXT41Saz1PKn
 R4pjeZMbkG11IXF3uFOqtbbrgTDwPSGWz4v/GeA4VgW0L1IyAcUx/0W1mPV6TslN8S
 V6s0iVWNYkN9tJ/QyU4EHqI5xo6J7tgMVOzC9ktmO55zuu2guX+qLl8mo+8s6pnOIX
 tnHjzvrO+To/V+kzobO1O7JEDwyznEiyBAJSSePVcrhVLEA6AB0Fqdq2cpNtOVBHZS
 SSaQwDi+ZtVgQ==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 3C4F4EB83;
 Sat, 30 May 2026 11:26:38 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC v4 2/3] lib: add fastmem library
Date: Sat, 30 May 2026 11:26:33 +0200
Message-ID: <20260530092634.46218-3-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530092634.46218-1-hofors@lysator.liu.se>
References: <20260527173042.93867-2-hofors@lysator.liu.se>
 <20260530092634.46218-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Introduce fastmem, a fast general-purpose small-object allocator
for DPDK applications. It allows an application to replace its
many per-type mempools with a single allocator that handles
arbitrary sizes, grows on demand, and offers mempool-level
performance on the hot path.

Applications that manage many object types (connections, sessions,
work items, timers) currently maintain a separate mempool for each,
requiring upfront sizing and wasting memory on over-provisioned
pools. Fastmem removes both constraints.

Key properties:

 * Huge-page-backed, NUMA-aware, DMA-usable.
 * Per-lcore caches for lock-free alloc/free on EAL threads.
 * Bulk alloc and free APIs.
 * Power-of-two size classes from 8 B to 1 MiB.
 * Backing memory grows lazily; rte_fastmem_reserve() allows
   upfront reservation to avoid latency spikes.
 * Always-on per-lcore and per-class statistics.

Bounded to small objects; requests above rte_fastmem_max_size()
are rejected. Replacing rte_malloc is currently not a goal.

--

RFC v4:
 * Fix crash in halloc/hfree on lcores without hlookup: fall
   back to shared bin on NULL cache.
 * Keep per-lcore statistics across rte_fastmem_cache_flush():
   retain the cache struct so counters survive.
 * Guard free and IOVA paths against uninitialized state.
 * Lazy-attach stats readers in secondary processes; distinguish
   -ENODEV from -EINVAL.
 * Add likely() hint to cache-present branch in
   account_alloc_nomem().
 * Protect bin statistics with the bin lock.
 * Trim verbose comments.
 * Add shared cache for callers without a private cache (non-EAL
   threads, secondary processes). Add rte_fastmem_stats_shared()
   and rte_fastmem_stats_shared_class().
 * Document rte_fastmem_stats_reset() quiescence requirement.

RFC v3:
 * Add rte_fastmem_realloc().
 * Add __rte_malloc/__rte_dealloc attributes; remove incorrect
   __rte_alloc_size/__rte_alloc_align.
 * Extract normalize_align() helper.
 * Remove inline directives from static functions.

RFC v2:
 * Fix use-after-free in rte_fastmem_deinit() with cross-socket
   caches: restructure into three-phase teardown.
 * Add secondary process support (lazy attach, safe deinit).
 * Add handle-based allocation API (rte_fastmem_hlookup,
   rte_fastmem_halloc, rte_fastmem_halloc_bulk).
 * Fix clang -Wthread-safety-analysis warnings.

Signed-off-by: Mattias Rönnblom <hofors@lysator.liu.se>
---
 doc/api/doxy-api-index.md        |    1 +
 doc/api/doxy-api.conf.in         |    1 +
 lib/fastmem/meson.build          |    6 +
 lib/fastmem/rfc-cover-letter.txt |  128 ++
 lib/fastmem/rte_fastmem.c        | 2123 ++++++++++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h        |  908 +++++++++++++
 lib/meson.build                  |    1 +
 7 files changed, 3168 insertions(+)
 create mode 100644 lib/fastmem/meson.build
 create mode 100644 lib/fastmem/rfc-cover-letter.txt
 create mode 100644 lib/fastmem/rte_fastmem.c
 create mode 100644 lib/fastmem/rte_fastmem.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 9296042119..7ebf1201ce 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -70,6 +70,7 @@ The public API headers are grouped by topics:
   [memzone](@ref rte_memzone.h),
   [mempool](@ref rte_mempool.h),
   [malloc](@ref rte_malloc.h),
+  [fastmem](@ref rte_fastmem.h),
   [memcpy](@ref rte_memcpy.h)
 
 - **timers**:
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index bedd944681..4355e9fb2d 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -43,6 +43,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/lib/efd \
                           @TOPDIR@/lib/ethdev \
                           @TOPDIR@/lib/eventdev \
+                          @TOPDIR@/lib/fastmem \
                           @TOPDIR@/lib/fib \
                           @TOPDIR@/lib/gpudev \
                           @TOPDIR@/lib/graph \
diff --git a/lib/fastmem/meson.build b/lib/fastmem/meson.build
new file mode 100644
index 0000000000..6c7834608f
--- /dev/null
+++ b/lib/fastmem/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Ericsson AB
+
+sources = files('rte_fastmem.c')
+headers = files('rte_fastmem.h')
+deps += ['eal']
diff --git a/lib/fastmem/rfc-cover-letter.txt b/lib/fastmem/rfc-cover-letter.txt
new file mode 100644
index 0000000000..53752c7e8b
--- /dev/null
+++ b/lib/fastmem/rfc-cover-letter.txt
@@ -0,0 +1,128 @@
+Subject: [RFC] lib/fastmem: fast small-object allocator
+
+This RFC introduces fastmem, a general-purpose small-object allocator
+for DPDK. It is intended to replace per-type mempools with a single
+allocator that handles arbitrary sizes, grows on demand, and matches
+mempool-level performance on the hot path.
+
+Motivation
+----------
+
+DPDK applications commonly maintain many mempools — one per object
+type (connections, sessions, timers, work items). Each must be sized
+up front, wastes memory when over-provisioned, and cannot serve
+objects of a different size. Fastmem eliminates this by accepting
+arbitrary sizes at runtime, backed by a slab allocator that
+repurposes memory across size classes as demand shifts.
+
+Design
+------
+
+Three-layer architecture:
+
+1. Backing memory: 128 MiB IOVA-contiguous memzones from EAL,
+   reserved lazily (or pre-reserved for deterministic latency).
+
+2. Slabs: 2 MiB, 2 MiB-aligned regions carved from memzones.
+   The alignment enables O(1) slab lookup from any object pointer
+   via bitmask — no radix tree or index structure. Slabs move
+   freely between 18 power-of-2 size classes (8 B to 1 MiB).
+
+3. Per-lcore caches: bounded LIFO stacks (no locks on the hot
+   path). Cache misses trigger bulk transfers to/from the shared
+   bin under a spinlock.
+
+Key properties:
+
+- Zero per-object metadata in the production build.
+- NUMA-aware, with per-socket bins and free-slab pools.
+- DMA-usable memory with O(1) virt-to-IOVA translation.
+- Bulk alloc/free with all-or-nothing semantics.
+- Backing memory never returned during lifetime (slabs recycled).
+- Non-EAL threads supported (bypass cache, take bin lock).
+- Secondary process support (lazy attach, no per-lcore caches).
+
+API surface
+-----------
+
+  rte_fastmem_init / deinit
+  rte_fastmem_reserve
+  rte_fastmem_set_limit / get_limit
+  rte_fastmem_alloc / alloc_socket
+  rte_fastmem_realloc
+  rte_fastmem_alloc_bulk / alloc_bulk_socket
+  rte_fastmem_free / free_bulk
+  rte_fastmem_hlookup / halloc / halloc_bulk / hfree / hfree_bulk
+  rte_fastmem_virt2iova
+  rte_fastmem_cache_flush
+  rte_fastmem_max_size / classes
+  rte_fastmem_stats / stats_class / stats_lcore / stats_lcore_class
+  rte_fastmem_stats_reset
+
+All APIs are marked __rte_experimental.
+
+Performance
+-----------
+
+The single-object hot path is roughly 2–3× the cost of mempool
+and an order of magnitude faster than rte_malloc. Under
+multi-lcore contention, fastmem scales similarly to mempool,
+while rte_malloc collapses.
+
+Limitations
+-----------
+
+- Maximum allocation: 1 MiB. Larger requests should use rte_malloc.
+- Power-of-2 classes only; worst-case internal fragmentation ~50%.
+- Backing memory not reclaimable short of deinit.
+
+Future work
+-----------
+
+- Lcore-affine allocations (false-sharing-free by construction).
+- Mempool ops driver for transparent drop-in use.
+- Debug mode (cookies, double-free detection, poison-on-free).
+- Telemetry integration.
+- EAL integration, allowing EAL-internal subsystems to use
+  fastmem for their small-object allocations.
+
+Changes in RFC v4:
+- Fix crash in halloc/hfree on lcores without hlookup: fall back
+  to shared bin on NULL cache.
+- Keep per-lcore statistics across rte_fastmem_cache_flush().
+- Guard free and IOVA paths against uninitialized state.
+- Lazy-attach stats readers in secondary processes; distinguish
+  -ENODEV from -EINVAL.
+- Protect bin statistics with the bin lock.
+- Trim verbose comments.
+- Add shared cache for callers without a private cache (non-EAL
+  threads, secondary processes). Add rte_fastmem_stats_shared()
+  and rte_fastmem_stats_shared_class().
+- Document rte_fastmem_stats_reset() quiescence requirement.
+- Add tests for handle alloc/free from uncached lcores, stats
+  survival across flush, and shared-cache statistics.
+- Update programming guide (shared cache, stats sections).
+
+Changes in RFC v3:
+- Add rte_fastmem_realloc() with full test coverage.
+- Add __rte_malloc/__rte_dealloc compiler attributes; remove
+  incorrect __rte_alloc_size/__rte_alloc_align.
+- Extract normalize_align() helper; remove redundant inline
+  directives.
+- Merge lifecycle and functional test suites.
+- Add realloc subsection to programming guide.
+
+Changes in RFC v2:
+- Fix cross-socket deinit use-after-free.
+- Add secondary process support.
+- Add handle-based allocation API.
+- Fix clang warnings; misc cleanup.
+
+Mattias Rönnblom (3):
+  doc: add fastmem programming guide
+  lib: add fastmem library
+  app/test: add fastmem test suite
+
+ doc/guides/prog_guide/fastmem_lib.rst | ...
+ lib/fastmem/                          | ...
+ app/test/test_fastmem*.c              | ...
diff --git a/lib/fastmem/rte_fastmem.c b/lib/fastmem/rte_fastmem.c
new file mode 100644
index 0000000000..4add00ce80
--- /dev/null
+++ b/lib/fastmem/rte_fastmem.c
@@ -0,0 +1,2123 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/queue.h>
+
+#include <eal_export.h>
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_lcore.h>
+#include <rte_log.h>
+#include <rte_memory.h>
+#include <rte_memzone.h>
+#include <rte_spinlock.h>
+
+#include <rte_fastmem.h>
+
+RTE_LOG_REGISTER_DEFAULT(fastmem_logtype, NOTICE);
+
+#define RTE_LOGTYPE_FASTMEM fastmem_logtype
+
+#define FASTMEM_LOG(level, ...) \
+	RTE_LOG_LINE(level, FASTMEM, "" __VA_ARGS__)
+
+#define FASTMEM_MEMZONE_SIZE_LOG2 27                            /* 128 MiB */
+#define FASTMEM_MEMZONE_SIZE ((size_t)1 << FASTMEM_MEMZONE_SIZE_LOG2)
+
+#define FASTMEM_SLAB_SIZE_LOG2 21                               /*   2 MiB */
+#define FASTMEM_SLAB_SIZE ((size_t)1 << FASTMEM_SLAB_SIZE_LOG2)
+#define FASTMEM_SLAB_MASK (FASTMEM_SLAB_SIZE - 1)
+
+#define FASTMEM_SLABS_PER_MEMZONE (FASTMEM_MEMZONE_SIZE / FASTMEM_SLAB_SIZE)
+
+#define FASTMEM_MAX_MEMZONES_PER_SOCKET 64
+
+#define FASTMEM_MIN_CLASS_LOG2 3                                /*   8 B */
+#define FASTMEM_MAX_CLASS_LOG2 20                               /*   1 MiB */
+#define FASTMEM_N_CLASSES (FASTMEM_MAX_CLASS_LOG2 - FASTMEM_MIN_CLASS_LOG2 + 1)
+
+#define FASTMEM_MIN_SIZE ((size_t)1 << FASTMEM_MIN_CLASS_LOG2)
+#define FASTMEM_MAX_ALLOC_SIZE ((size_t)1 << FASTMEM_MAX_CLASS_LOG2)
+
+#define FASTMEM_SLAB_HEADER_SIZE RTE_CACHE_LINE_SIZE
+
+#define FASTMEM_CACHE_BASE_CAPACITY 64
+#define FASTMEM_CACHE_FLOOR_CAPACITY 4
+#define FASTMEM_CACHE_BASE_CLASS_LOG2 12                        /* 4 KiB */
+
+struct fastmem_bin;
+
+/*
+ * Slab header at offset 0 of each 2 MiB slab. Either free (linked
+ * via next_free) or assigned to a bin (linked via list).
+ */
+struct fastmem_slab {
+	struct fastmem_bin *bin;
+	void *free_head;
+	uint32_t free_count;
+	uint32_t n_slots;
+	struct fastmem_slab *next_free;
+	TAILQ_ENTRY(fastmem_slab) list;
+	rte_iova_t iova_base;
+} __rte_aligned(FASTMEM_SLAB_HEADER_SIZE);
+
+TAILQ_HEAD(fastmem_slab_list, fastmem_slab);
+
+struct fastmem_bin {
+	rte_spinlock_t lock;
+	uint32_t slot_size;
+	uint32_t slots_per_slab;
+	uint32_t class_idx;
+	struct fastmem_slab_list partial;
+	struct fastmem_slab_list full;
+	int socket_id;
+	uint64_t slab_acquires;
+	uint64_t slab_releases;
+	uint32_t slabs_partial;
+	uint32_t slabs_full;
+	/*
+	 * Traffic served straight from the bin, with no cache of any kind
+	 * backing it. Reached only on the fallback where a caller has no
+	 * private per-lcore cache and the shared cache could not be created
+	 * either (cache-struct allocation failed, e.g. under a memory limit
+	 * or in an under-provisioned secondary). The normal cache-less path
+	 * goes through the shared cache and is counted there, not here.
+	 * Written under bin->lock, read locklessly by the stats functions.
+	 * Not attributable to an lcore, so it appears only in the global and
+	 * per-class statistics.
+	 */
+	uint64_t nocache_allocs;
+	uint64_t nocache_frees;
+	uint64_t nocache_nomem;
+};
+
+/*
+ * Bounded LIFO of free object pointers, holding statistics counters
+ * alongside the hot-path fields so alloc and free stay on one cache line.
+ *
+ * Used in two ways: as a private per-(lcore, class, socket) cache for
+ * lcore-id-equipped primary threads (written only by its owning lcore, so
+ * lock-free), and as a per-(class, socket) cache shared by all other
+ * callers (serialized by the socket's shared_cache_lock).
+ *
+ * Never freed once created (rte_fastmem_cache_flush() drains the objects
+ * but keeps the struct), so the counters survive a flush and stats readers
+ * may touch it safely.
+ */
+struct fastmem_cache {
+	uint32_t count;
+	uint32_t capacity;
+	uint32_t target;
+	uint64_t alloc_cache_hits;
+	uint64_t alloc_cache_misses;
+	uint64_t alloc_nomem;
+	uint64_t free_cache_hits;
+	uint64_t free_cache_misses;
+	void *objs[];
+} __rte_cache_aligned;
+
+struct fastmem_socket_state {
+	rte_spinlock_t lock;
+	struct fastmem_slab *free_head;
+	size_t reserved_bytes;
+	size_t memory_limit;
+	unsigned int n_memzones;
+	unsigned int memzone_seq;
+	const struct rte_memzone *memzones[FASTMEM_MAX_MEMZONES_PER_SOCKET];
+	struct fastmem_bin bins[FASTMEM_N_CLASSES];
+	struct fastmem_cache *caches[RTE_MAX_LCORE][FASTMEM_N_CLASSES];
+	/*
+	 * Cache shared by all callers lacking a private per-lcore cache
+	 * (lcore-less primary threads and every secondary-process thread),
+	 * guarded by one spinlock for the whole socket.
+	 */
+	rte_spinlock_t shared_cache_lock;
+	struct fastmem_cache *shared_caches[FASTMEM_N_CLASSES];
+};
+
+struct fastmem {
+	struct fastmem_socket_state sockets[RTE_MAX_NUMA_NODES];
+};
+
+static struct fastmem *fastmem;
+static const struct rte_memzone *fastmem_mz;
+static bool fastmem_is_primary; /* cached; avoids function call on hot path */
+
+/*
+ * Ensure the global fastmem state is available to this process,
+ * lazily attaching a secondary to the shared memzone on first use.
+ * Returns false (rte_errno = ENODEV) if the primary has not
+ * initialized the library.
+ */
+static bool
+fastmem_assure(void)
+{
+	const struct rte_memzone *mz;
+
+	if (likely(fastmem != NULL))
+		return true;
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		rte_errno = ENODEV;
+		return false;
+	}
+
+	mz = rte_memzone_lookup("fastmem_state");
+	if (mz == NULL) {
+		rte_errno = ENODEV;
+		return false;
+	}
+
+	fastmem_mz = mz;
+	fastmem = mz->addr;
+	return true;
+}
+
+static unsigned int
+size_to_class(size_t size, size_t align)
+{
+	size_t effective;
+	unsigned int log2;
+
+	effective = size < FASTMEM_MIN_SIZE ? FASTMEM_MIN_SIZE : size;
+	if (align > effective)
+		effective = align;
+
+	log2 = 64u - rte_clz64(effective - 1);
+
+	if (log2 < FASTMEM_MIN_CLASS_LOG2)
+		log2 = FASTMEM_MIN_CLASS_LOG2;
+	if (log2 > FASTMEM_MAX_CLASS_LOG2)
+		return FASTMEM_N_CLASSES;
+
+	return log2 - FASTMEM_MIN_CLASS_LOG2;
+}
+
+static size_t
+class_size(unsigned int class_idx)
+{
+	return (size_t)1 << (class_idx + FASTMEM_MIN_CLASS_LOG2);
+}
+
+/**
+ * Normalize and validate the alignment argument.
+ * Returns true on success (align updated in place), false on invalid input.
+ */
+static bool
+normalize_align(size_t *align)
+{
+	if (*align == 0) {
+		*align = RTE_CACHE_LINE_SIZE;
+		return true;
+	}
+	return rte_is_power_of_2(*align);
+}
+
+static_assert(sizeof(struct fastmem_slab) == FASTMEM_SLAB_HEADER_SIZE,
+	"fastmem slab header must fit in exactly one cache line");
+static_assert(sizeof(struct fastmem_slab) <= FASTMEM_SLAB_SIZE,
+	"slab header larger than a slab makes no sense");
+
+static struct fastmem_slab *
+slab_of(void *obj)
+{
+	return (struct fastmem_slab *)
+		((uintptr_t)obj & ~(uintptr_t)FASTMEM_SLAB_MASK);
+}
+
+static size_t
+slab_slot0_offset(size_t class_size)
+{
+	return class_size < FASTMEM_SLAB_HEADER_SIZE ?
+		FASTMEM_SLAB_HEADER_SIZE : class_size;
+}
+
+static uint32_t
+slab_slot_count(size_t class_size)
+{
+	size_t offset = slab_slot0_offset(class_size);
+
+	return (uint32_t)((FASTMEM_SLAB_SIZE - offset) / class_size);
+}
+
+/* Must be called with bin->lock held. */
+static void
+slab_init(struct fastmem_bin *bin, struct fastmem_slab *slab)
+{
+	size_t slot_size = bin->slot_size;
+	size_t offset = slab_slot0_offset(slot_size);
+	uint32_t n = bin->slots_per_slab;
+	void *prev = NULL;
+	uint32_t i;
+
+	slab->bin = bin;
+	slab->n_slots = n;
+	slab->free_count = n;
+
+	/* Build in reverse so pops yield sequential addresses. */
+	for (i = 0; i < n; i++) {
+		void *slot = RTE_PTR_ADD(slab, offset + i * slot_size);
+		*(void **)slot = prev;
+		prev = slot;
+	}
+	slab->free_head = prev;
+}
+
+static int
+grow_socket(struct fastmem_socket_state *socket, int socket_id)
+{
+	char name[RTE_MEMZONE_NAMESIZE];
+	const struct rte_memzone *mz;
+	unsigned int i;
+
+	if (socket->reserved_bytes + FASTMEM_MEMZONE_SIZE > socket->memory_limit) {
+		FASTMEM_LOG(ERR,
+			"reserve would exceed memory_limit (%zu) on socket %d",
+			socket->memory_limit, socket_id);
+		return -ENOMEM;
+	}
+
+	if (socket->n_memzones == FASTMEM_MAX_MEMZONES_PER_SOCKET) {
+		FASTMEM_LOG(ERR,
+			"reached per-socket memzone cap (%u) on socket %d",
+			FASTMEM_MAX_MEMZONES_PER_SOCKET, socket_id);
+		return -ENOMEM;
+	}
+
+	snprintf(name, sizeof(name), "fastmem_%d_%u", socket_id,
+			socket->memzone_seq++);
+
+	mz = rte_memzone_reserve_aligned(name, FASTMEM_MEMZONE_SIZE,
+			socket_id, RTE_MEMZONE_IOVA_CONTIG,
+			FASTMEM_SLAB_SIZE);
+	if (mz == NULL) {
+		FASTMEM_LOG(ERR,
+			"failed to reserve %zu-byte memzone '%s' on socket %d: %s",
+			(size_t)FASTMEM_MEMZONE_SIZE, name, socket_id,
+			rte_strerror(rte_errno));
+		return -ENOMEM;
+	}
+
+	socket->memzones[socket->n_memzones++] = mz;
+	socket->reserved_bytes += FASTMEM_MEMZONE_SIZE;
+
+	for (i = 0; i < FASTMEM_SLABS_PER_MEMZONE; i++) {
+		struct fastmem_slab *slab = RTE_PTR_ADD(mz->addr,
+				i * FASTMEM_SLAB_SIZE);
+
+		slab->iova_base = mz->iova + i * FASTMEM_SLAB_SIZE;
+		slab->next_free = socket->free_head;
+		socket->free_head = slab;
+	}
+
+	FASTMEM_LOG(DEBUG,
+		"reserved memzone '%s' (%zu bytes) on socket %d; %zu slabs added",
+		name, (size_t)FASTMEM_MEMZONE_SIZE, socket_id,
+		(size_t)FASTMEM_SLABS_PER_MEMZONE);
+
+	return 0;
+}
+
+static struct fastmem_slab *
+slab_acquire(struct fastmem_socket_state *socket, int socket_id)
+{
+	struct fastmem_slab *slab;
+
+	rte_spinlock_lock(&socket->lock);
+
+	if (socket->free_head == NULL) {
+		int rc = grow_socket(socket, socket_id);
+
+		if (rc < 0) {
+			rte_spinlock_unlock(&socket->lock);
+			return NULL;
+		}
+	}
+
+	slab = socket->free_head;
+	socket->free_head = slab->next_free;
+	slab->next_free = NULL;
+
+	rte_spinlock_unlock(&socket->lock);
+
+	return slab;
+}
+
+static void
+slab_release(struct fastmem_socket_state *socket,
+		struct fastmem_slab *slab)
+{
+	rte_spinlock_lock(&socket->lock);
+
+	slab->next_free = socket->free_head;
+	socket->free_head = slab;
+
+	rte_spinlock_unlock(&socket->lock);
+}
+
+static void
+bin_init(struct fastmem_bin *bin, unsigned int class_idx, int socket_id)
+{
+	size_t slot_size = class_size(class_idx);
+
+	rte_spinlock_init(&bin->lock);
+	bin->slot_size = (uint32_t)slot_size;
+	bin->slots_per_slab = slab_slot_count(slot_size);
+	bin->class_idx = class_idx;
+	TAILQ_INIT(&bin->partial);
+	TAILQ_INIT(&bin->full);
+	bin->socket_id = socket_id;
+	bin->slab_acquires = 0;
+	bin->slab_releases = 0;
+	bin->slabs_partial = 0;
+	bin->slabs_full = 0;
+}
+
+static void
+bin_release(struct fastmem_bin *bin, struct fastmem_socket_state *socket)
+{
+	struct fastmem_slab *slab;
+
+	while ((slab = TAILQ_FIRST(&bin->partial)) != NULL) {
+		TAILQ_REMOVE(&bin->partial, slab, list);
+		slab_release(socket, slab);
+	}
+	while ((slab = TAILQ_FIRST(&bin->full)) != NULL) {
+		TAILQ_REMOVE(&bin->full, slab, list);
+		slab_release(socket, slab);
+	}
+}
+
+static unsigned int
+bin_pop_locked(struct fastmem_bin *bin, void **objs, unsigned int n)
+{
+	unsigned int got = 0;
+
+	while (got < n) {
+		struct fastmem_slab *slab = TAILQ_FIRST(&bin->partial);
+		void *obj;
+
+		if (slab == NULL)
+			break;
+
+		obj = slab->free_head;
+		slab->free_head = *(void **)obj;
+		slab->free_count--;
+		objs[got++] = obj;
+
+		if (slab->free_count == 0) {
+			TAILQ_REMOVE(&bin->partial, slab, list);
+			TAILQ_INSERT_HEAD(&bin->full, slab, list);
+			bin->slabs_partial--;
+			bin->slabs_full++;
+		}
+	}
+
+	return got;
+}
+
+/*
+ * Fully-drained slabs are accumulated in @p to_release for the
+ * caller to return after dropping the lock.
+ */
+static unsigned int
+bin_push_locked(struct fastmem_bin *bin, void **objs, unsigned int n,
+		struct fastmem_slab **to_release)
+{
+	unsigned int n_release = 0;
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		void *obj = objs[i];
+		struct fastmem_slab *slab = (struct fastmem_slab *)
+			((uintptr_t)obj & ~(uintptr_t)FASTMEM_SLAB_MASK);
+		bool was_full = slab->free_count == 0;
+
+		*(void **)obj = slab->free_head;
+		slab->free_head = obj;
+		slab->free_count++;
+
+		if (was_full) {
+			TAILQ_REMOVE(&bin->full, slab, list);
+			TAILQ_INSERT_HEAD(&bin->partial, slab, list);
+			bin->slabs_full--;
+			bin->slabs_partial++;
+		}
+
+		if (slab->free_count == slab->n_slots) {
+			TAILQ_REMOVE(&bin->partial, slab, list);
+			bin->slabs_partial--;
+			bin->slab_releases++;
+			to_release[n_release++] = slab;
+		}
+	}
+
+	return n_release;
+}
+
+/*
+ * Allocate a single object from the bin. Pass @p nocache true only on the
+ * no-cache fallback (a user allocation that has neither a private nor a
+ * shared cache); it counts the alloc against the bin's no-cache statistics.
+ * Internal cache machinery (refills) passes false.
+ */
+static void *
+bin_alloc_one(struct fastmem_bin *bin, bool nocache)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[bin->socket_id];
+	void *obj;
+
+	rte_spinlock_lock(&bin->lock);
+
+	while (bin_pop_locked(bin, &obj, 1) == 0) {
+		struct fastmem_slab *slab;
+
+		if (TAILQ_FIRST(&bin->partial) != NULL)
+			continue;
+
+		rte_spinlock_unlock(&bin->lock);
+
+		slab = slab_acquire(socket, bin->socket_id);
+		if (slab == NULL) {
+			rte_errno = ENOMEM;
+			return NULL;
+		}
+
+		rte_spinlock_lock(&bin->lock);
+
+		if (unlikely(TAILQ_FIRST(&bin->partial) != NULL)) {
+			/* Release surplus slab without holding bin->lock. */
+			rte_spinlock_unlock(&bin->lock);
+			slab_release(socket, slab);
+			rte_spinlock_lock(&bin->lock);
+		} else {
+			slab_init(bin, slab);
+			TAILQ_INSERT_HEAD(&bin->partial, slab, list);
+			bin->slabs_partial++;
+			bin->slab_acquires++;
+		}
+	}
+
+	if (nocache)
+		bin->nocache_allocs++;
+
+	rte_spinlock_unlock(&bin->lock);
+
+	return obj;
+}
+
+/*
+ * Allocate up to @p n objects from the bin. Pass @p nocache true only on the
+ * no-cache fallback (a user allocation that has neither a private nor a
+ * shared cache); it counts the allocs against the bin's no-cache statistics.
+ * Internal cache machinery (e.g. a cache refill) passes false.
+ */
+static unsigned int
+bin_alloc_bulk(struct fastmem_bin *bin, void **objs, unsigned int n,
+		bool nocache)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[bin->socket_id];
+	unsigned int got = 0;
+
+	rte_spinlock_lock(&bin->lock);
+
+	while (got < n) {
+		struct fastmem_slab *slab;
+
+		got += bin_pop_locked(bin, objs + got, n - got);
+		if (got == n)
+			break;
+
+		if (TAILQ_FIRST(&bin->partial) != NULL)
+			continue;
+
+		rte_spinlock_unlock(&bin->lock);
+
+		slab = slab_acquire(socket, bin->socket_id);
+		if (slab == NULL) {
+			rte_spinlock_lock(&bin->lock);
+			break;
+		}
+
+		rte_spinlock_lock(&bin->lock);
+
+		if (unlikely(TAILQ_FIRST(&bin->partial) != NULL)) {
+			/* Release surplus slab without holding bin->lock. */
+			rte_spinlock_unlock(&bin->lock);
+			slab_release(socket, slab);
+			rte_spinlock_lock(&bin->lock);
+		} else {
+			slab_init(bin, slab);
+			TAILQ_INSERT_HEAD(&bin->partial, slab, list);
+			bin->slabs_partial++;
+			bin->slab_acquires++;
+		}
+	}
+
+	if (nocache)
+		bin->nocache_allocs += got;
+
+	rte_spinlock_unlock(&bin->lock);
+
+	return got;
+}
+
+/*
+ * Free a single object to the bin. Pass @p nocache true only on the no-cache
+ * fallback (a user free that has neither a private nor a shared cache); it
+ * counts the free against the bin's no-cache statistics. Internal cache
+ * machinery (drain, teardown, flush) passes false.
+ */
+static void
+bin_free_one(struct fastmem_bin *bin, void *obj, bool nocache)
+{
+	unsigned int n_release;
+	struct fastmem_slab *slab_to_release = NULL;
+	struct fastmem_socket_state *socket;
+
+	rte_spinlock_lock(&bin->lock);
+	n_release = bin_push_locked(bin, &obj, 1, &slab_to_release);
+	if (nocache)
+		bin->nocache_frees++;
+	rte_spinlock_unlock(&bin->lock);
+
+	if (n_release > 0) {
+		socket = &fastmem->sockets[bin->socket_id];
+		slab_release(socket, slab_to_release);
+	}
+}
+
+/*
+ * Free a batch of objects to the bin. Always internal cache machinery
+ * (drain, teardown, flush), never a no-cache user free, so unlike
+ * bin_free_one() it has no nocache flag and is never counted against the
+ * bin's no-cache statistics.
+ */
+static void
+bin_free_bulk(struct fastmem_bin *bin, void **objs, unsigned int n)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[bin->socket_id];
+	struct fastmem_slab *to_release[FASTMEM_CACHE_BASE_CAPACITY];
+	unsigned int n_release;
+	unsigned int i;
+
+	RTE_VERIFY(n <= RTE_DIM(to_release));
+
+	rte_spinlock_lock(&bin->lock);
+	n_release = bin_push_locked(bin, objs, n, to_release);
+	rte_spinlock_unlock(&bin->lock);
+
+	for (i = 0; i < n_release; i++)
+		slab_release(socket, to_release[i]);
+}
+
+static unsigned int
+cache_capacity(unsigned int class_idx)
+{
+	unsigned int class_log2 = class_idx + FASTMEM_MIN_CLASS_LOG2;
+	unsigned int shift;
+	unsigned int cap;
+
+	if (class_log2 <= FASTMEM_CACHE_BASE_CLASS_LOG2)
+		return FASTMEM_CACHE_BASE_CAPACITY;
+
+	shift = class_log2 - FASTMEM_CACHE_BASE_CLASS_LOG2;
+	cap = FASTMEM_CACHE_BASE_CAPACITY >> shift;
+
+	return cap < FASTMEM_CACHE_FLOOR_CAPACITY ?
+		FASTMEM_CACHE_FLOOR_CAPACITY : cap;
+}
+
+static struct fastmem_cache **
+cache_slot(struct fastmem_socket_state *socket, unsigned int class_idx,
+		unsigned int lcore_id)
+{
+	if (lcore_id >= RTE_MAX_LCORE)
+		return NULL;
+	return &socket->caches[lcore_id][class_idx];
+}
+
+/*
+ * Allocate and initialize a cache struct, itself drawn from fastmem on the
+ * calling lcore's socket, bypassing the cache layer to avoid recursion.
+ */
+static struct fastmem_cache *
+cache_alloc(struct fastmem_socket_state *socket, unsigned int class_idx)
+{
+	struct fastmem_cache *cache;
+	unsigned int capacity = cache_capacity(class_idx);
+	size_t cache_size = sizeof(*cache) + capacity * sizeof(void *);
+	unsigned int cache_class = size_to_class(cache_size, RTE_CACHE_LINE_SIZE);
+	unsigned int own_socket = rte_socket_id();
+	struct fastmem_socket_state *alloc_socket;
+
+	if (cache_class >= FASTMEM_N_CLASSES) {
+		FASTMEM_LOG(ERR,
+			"cache size %zu exceeds max size class",
+			cache_size);
+		return NULL;
+	}
+
+	if (own_socket >= RTE_MAX_NUMA_NODES)
+		own_socket = (unsigned int)socket->bins[0].socket_id;
+
+	alloc_socket = &fastmem->sockets[own_socket];
+
+	cache = bin_alloc_one(&alloc_socket->bins[cache_class], false);
+	if (cache == NULL) {
+		FASTMEM_LOG(ERR,
+			"failed to allocate cache for class %u on socket %u",
+			class_idx, own_socket);
+		return NULL;
+	}
+
+	cache->count = 0;
+	cache->capacity = capacity;
+	cache->target = capacity / 2;
+	cache->alloc_cache_hits = 0;
+	cache->alloc_cache_misses = 0;
+	cache->alloc_nomem = 0;
+	cache->free_cache_hits = 0;
+	cache->free_cache_misses = 0;
+
+	return cache;
+}
+
+static struct fastmem_cache *
+cache_create(struct fastmem_socket_state *socket,
+		unsigned int class_idx, unsigned int lcore_id)
+{
+	struct fastmem_cache **slot = cache_slot(socket, class_idx, lcore_id);
+	struct fastmem_cache *cache;
+
+	if (slot == NULL)
+		return NULL;
+
+	cache = *slot;
+	if (cache != NULL)
+		return cache;
+
+	cache = cache_alloc(socket, class_idx);
+	if (cache == NULL)
+		return NULL;
+
+	*slot = cache;
+
+	return cache;
+}
+
+/*
+ * Get-or-create the private per-lcore cache. Returns NULL for callers that
+ * have no private cache (secondary process, or no lcore id), which then use
+ * the shared cache instead.
+ */
+static struct fastmem_cache *
+cache_get(struct fastmem_socket_state *socket, unsigned int class_idx,
+		unsigned int lcore_id)
+{
+	struct fastmem_cache **slot;
+	struct fastmem_cache *cache;
+
+	if (unlikely(!fastmem_is_primary))
+		return NULL;
+
+	slot = cache_slot(socket, class_idx, lcore_id);
+
+	if (slot == NULL)
+		return NULL;
+
+	cache = *slot;
+	if (cache != NULL)
+		return cache;
+
+	return cache_create(socket, class_idx, lcore_id);
+}
+
+static void *
+cache_pop(struct fastmem_cache *cache, struct fastmem_bin *bin)
+{
+	if (cache->count > 0) {
+		cache->alloc_cache_hits++;
+		return cache->objs[--cache->count];
+	}
+
+	cache->count = bin_alloc_bulk(bin, cache->objs, cache->target, false);
+	if (cache->count == 0)
+		return NULL;
+
+	cache->alloc_cache_misses++;
+	return cache->objs[--cache->count];
+}
+
+static void
+cache_push(struct fastmem_cache *cache, struct fastmem_bin *bin, void *obj)
+{
+	unsigned int drain;
+
+	if (cache->count < cache->capacity) {
+		cache->free_cache_hits++;
+		cache->objs[cache->count++] = obj;
+		return;
+	}
+
+	cache->free_cache_misses++;
+
+	/*
+	 * Drain the oldest (bottom) half to the bin, keep the newest
+	 * (top) half for temporal reuse.
+	 */
+	drain = cache->count - cache->target;
+	bin_free_bulk(bin, cache->objs, drain);
+	memmove(cache->objs, cache->objs + drain,
+		cache->target * sizeof(cache->objs[0]));
+	cache->count = cache->target;
+
+	cache->objs[cache->count++] = obj;
+}
+
+/* Get-or-create the shared cache; call with shared_cache_lock held. */
+static struct fastmem_cache *
+shared_cache_get(struct fastmem_socket_state *socket, unsigned int class_idx)
+{
+	struct fastmem_cache *cache = socket->shared_caches[class_idx];
+
+	if (cache != NULL)
+		return cache;
+
+	cache = cache_alloc(socket, class_idx);
+	if (cache == NULL)
+		return NULL;
+
+	socket->shared_caches[class_idx] = cache;
+
+	return cache;
+}
+
+/* Allocate one object via the shared cache, or straight from the bin if the
+ * cache cannot be created. */
+static void *
+shared_alloc_one(struct fastmem_socket_state *socket, unsigned int class_idx)
+{
+	struct fastmem_bin *bin = &socket->bins[class_idx];
+	struct fastmem_cache *cache;
+	void *obj;
+
+	rte_spinlock_lock(&socket->shared_cache_lock);
+
+	cache = shared_cache_get(socket, class_idx);
+	if (likely(cache != NULL)) {
+		obj = cache_pop(cache, bin);
+		rte_spinlock_unlock(&socket->shared_cache_lock);
+		return obj;
+	}
+
+	rte_spinlock_unlock(&socket->shared_cache_lock);
+
+	return bin_alloc_one(bin, true);
+}
+
+/* Allocate up to @p n objects via the shared cache; returns the count got. */
+static unsigned int
+shared_alloc_bulk(struct fastmem_socket_state *socket, unsigned int class_idx,
+		void **objs, unsigned int n)
+{
+	struct fastmem_bin *bin = &socket->bins[class_idx];
+	struct fastmem_cache *cache;
+	unsigned int got = 0;
+
+	rte_spinlock_lock(&socket->shared_cache_lock);
+
+	cache = shared_cache_get(socket, class_idx);
+	if (likely(cache != NULL)) {
+		while (got < n) {
+			void *obj = cache_pop(cache, bin);
+
+			if (obj == NULL)
+				break;
+			objs[got++] = obj;
+		}
+		rte_spinlock_unlock(&socket->shared_cache_lock);
+		return got;
+	}
+
+	rte_spinlock_unlock(&socket->shared_cache_lock);
+
+	return bin_alloc_bulk(bin, objs, n, true);
+}
+
+/* Free one object via the shared cache. */
+static void
+shared_free_one(struct fastmem_socket_state *socket, unsigned int class_idx,
+		void *obj)
+{
+	struct fastmem_bin *bin = &socket->bins[class_idx];
+	struct fastmem_cache *cache;
+
+	rte_spinlock_lock(&socket->shared_cache_lock);
+
+	cache = shared_cache_get(socket, class_idx);
+	if (likely(cache != NULL)) {
+		cache_push(cache, bin, obj);
+		rte_spinlock_unlock(&socket->shared_cache_lock);
+		return;
+	}
+
+	rte_spinlock_unlock(&socket->shared_cache_lock);
+
+	bin_free_one(bin, obj, true);
+}
+
+/* Record an alloc failure against the per-lcore cache, the shared cache, or
+ * the bin's no-cache counter, in that order of preference. */
+static void
+account_alloc_nomem(struct fastmem_socket_state *socket,
+		unsigned int class_idx, unsigned int lcore_id)
+{
+	struct fastmem_cache *cache = cache_get(socket, class_idx, lcore_id);
+
+	if (likely(cache != NULL)) {
+		cache->alloc_nomem++;
+		return;
+	}
+
+	rte_spinlock_lock(&socket->shared_cache_lock);
+	cache = shared_cache_get(socket, class_idx);
+	if (likely(cache != NULL)) {
+		cache->alloc_nomem++;
+		rte_spinlock_unlock(&socket->shared_cache_lock);
+		return;
+	}
+	rte_spinlock_unlock(&socket->shared_cache_lock);
+
+	struct fastmem_bin *bin = &socket->bins[class_idx];
+
+	rte_spinlock_lock(&bin->lock);
+	bin->nocache_nomem++;
+	rte_spinlock_unlock(&bin->lock);
+}
+
+static void
+socket_release_caches(struct fastmem_socket_state *socket)
+{
+	unsigned int lcore;
+	unsigned int c;
+
+	for (lcore = 0; lcore < RTE_MAX_LCORE; lcore++) {
+		for (c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_cache *cache = socket->caches[lcore][c];
+			struct fastmem_slab *cache_slab;
+
+			if (cache == NULL)
+				continue;
+
+			if (cache->count > 0) {
+				bin_free_bulk(&socket->bins[c],
+					cache->objs, cache->count);
+				cache->count = 0;
+			}
+
+			cache_slab = slab_of(cache);
+			bin_free_one(cache_slab->bin, cache, false);
+
+			socket->caches[lcore][c] = NULL;
+		}
+	}
+
+	for (c = 0; c < FASTMEM_N_CLASSES; c++) {
+		struct fastmem_cache *cache = socket->shared_caches[c];
+		struct fastmem_slab *cache_slab;
+
+		if (cache == NULL)
+			continue;
+
+		if (cache->count > 0) {
+			bin_free_bulk(&socket->bins[c],
+				cache->objs, cache->count);
+			cache->count = 0;
+		}
+
+		cache_slab = slab_of(cache);
+		bin_free_one(cache_slab->bin, cache, false);
+
+		socket->shared_caches[c] = NULL;
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_init, 24.11)
+int
+rte_fastmem_init(void)
+{
+	unsigned int s, c;
+
+	if (fastmem != NULL)
+		return -EBUSY;
+
+	fastmem_mz = rte_memzone_reserve_aligned("fastmem_state",
+			sizeof(*fastmem), SOCKET_ID_ANY, 0,
+			RTE_CACHE_LINE_SIZE);
+	if (fastmem_mz == NULL)
+		return -ENOMEM;
+
+	fastmem = fastmem_mz->addr;
+	fastmem_is_primary = true;
+	memset(fastmem, 0, sizeof(*fastmem));
+
+	for (s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		rte_spinlock_init(&socket->lock);
+		rte_spinlock_init(&socket->shared_cache_lock);
+		socket->memory_limit = SIZE_MAX;
+
+		for (c = 0; c < FASTMEM_N_CLASSES; c++)
+			bin_init(&socket->bins[c], c, (int)s);
+	}
+
+	return 0;
+}
+
+static void
+release_socket_caches(struct fastmem_socket_state *socket)
+{
+	socket_release_caches(socket);
+}
+
+static void
+release_socket_bins(struct fastmem_socket_state *socket)
+{
+	unsigned int c;
+
+	for (c = 0; c < FASTMEM_N_CLASSES; c++)
+		bin_release(&socket->bins[c], socket);
+}
+
+static void
+release_socket_memzones(struct fastmem_socket_state *socket)
+{
+	unsigned int i;
+
+	for (i = 0; i < socket->n_memzones; i++)
+		rte_memzone_free(socket->memzones[i]);
+
+	socket->free_head = NULL;
+	socket->reserved_bytes = 0;
+	socket->n_memzones = 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_deinit, 24.11)
+void
+rte_fastmem_deinit(void)
+{
+	unsigned int i;
+
+	if (fastmem == NULL)
+		return;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		fastmem = NULL;
+		fastmem_mz = NULL;
+		return;
+	}
+
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		release_socket_caches(&fastmem->sockets[i]);
+
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		release_socket_bins(&fastmem->sockets[i]);
+
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		release_socket_memzones(&fastmem->sockets[i]);
+
+	rte_memzone_free(fastmem_mz);
+	fastmem_mz = NULL;
+	fastmem = NULL;
+}
+
+/* Same resolution order as rte_malloc's malloc_get_numa_socket(). */
+static unsigned int
+local_socket_id(void)
+{
+	int sid = (int)rte_socket_id();
+
+	if (likely(sid >= 0 && sid < RTE_MAX_NUMA_NODES))
+		return sid;
+
+	sid = (int)rte_lcore_to_socket_id(rte_get_main_lcore());
+	if (likely(sid >= 0 && sid < RTE_MAX_NUMA_NODES))
+		return sid;
+
+	sid = rte_socket_id_by_idx(0);
+	if (likely(sid >= 0 && sid < RTE_MAX_NUMA_NODES))
+		return sid;
+
+	return 0;
+}
+
+static int
+reserve_on_socket(int sid, size_t size)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[sid];
+	int rc = 0;
+
+	rte_spinlock_lock(&socket->lock);
+
+	while (socket->reserved_bytes < size) {
+		rc = grow_socket(socket, sid);
+		if (rc < 0)
+			break;
+	}
+
+	rte_spinlock_unlock(&socket->lock);
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_reserve, 24.11)
+int
+rte_fastmem_reserve(size_t size, int socket_id)
+{
+	unsigned int i;
+	int rc;
+
+	if (fastmem == NULL)
+		return -EINVAL;
+
+	if (socket_id != SOCKET_ID_ANY) {
+		if (socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)
+			return -EINVAL;
+		return reserve_on_socket(socket_id, size);
+	}
+
+	rc = reserve_on_socket(local_socket_id(), size);
+	if (rc == 0)
+		return 0;
+
+	for (i = 0; i < rte_socket_count(); i++) {
+		int sid = rte_socket_id_by_idx(i);
+
+		if (sid < 0 || (unsigned int)sid == local_socket_id())
+			continue;
+
+		rc = reserve_on_socket(sid, size);
+		if (rc == 0)
+			return 0;
+	}
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_set_limit, 24.11)
+int
+rte_fastmem_set_limit(int socket_id, size_t max_bytes)
+{
+	if (fastmem == NULL)
+		return -EINVAL;
+
+	if (socket_id == SOCKET_ID_ANY) {
+		for (unsigned int i = 0; i < RTE_MAX_NUMA_NODES; i++)
+			fastmem->sockets[i].memory_limit = max_bytes;
+		return 0;
+	}
+
+	if (socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)
+		return -EINVAL;
+
+	fastmem->sockets[socket_id].memory_limit = max_bytes;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_get_limit, 24.11)
+size_t
+rte_fastmem_get_limit(int socket_id)
+{
+	if (fastmem == NULL || socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)
+		return 0;
+
+	return fastmem->sockets[socket_id].memory_limit;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_max_size, 24.11)
+size_t
+rte_fastmem_max_size(void)
+{
+	return FASTMEM_MAX_ALLOC_SIZE;
+}
+
+static void *
+alloc_from_socket(struct fastmem_socket_state *socket,
+		unsigned int class_idx, unsigned int lcore_id)
+{
+	struct fastmem_cache *cache;
+	struct fastmem_bin *bin = &socket->bins[class_idx];
+
+	cache = cache_get(socket, class_idx, lcore_id);
+	if (likely(cache != NULL))
+		return cache_pop(cache, bin);
+
+	return shared_alloc_one(socket, class_idx);
+}
+
+static void
+do_free(void *ptr)
+{
+	struct fastmem_slab *slab;
+	struct fastmem_bin *bin;
+	struct fastmem_socket_state *socket;
+	unsigned int lcore_id;
+	struct fastmem_cache *cache;
+
+	if (unlikely(!fastmem_assure()))
+		return;
+
+	slab = slab_of(ptr);
+	bin = slab->bin;
+	socket = &fastmem->sockets[bin->socket_id];
+
+	lcore_id = rte_lcore_id();
+	cache = cache_get(socket, bin->class_idx, lcore_id);
+	if (likely(cache != NULL))
+		cache_push(cache, bin, ptr);
+	else
+		shared_free_one(socket, bin->class_idx, ptr);
+}
+
+static int
+do_alloc_bulk(void **ptrs, unsigned int n, size_t size, size_t align,
+		unsigned int flags, unsigned int lcore_id,
+		int socket_id, bool fallback)
+{
+	unsigned int class_idx;
+	struct fastmem_socket_state *socket;
+	struct fastmem_cache *cache;
+	unsigned int got = 0;
+
+	if (unlikely(!fastmem_assure()))
+		return -rte_errno;
+
+	if (unlikely(!normalize_align(&align))) {
+		rte_errno = EINVAL;
+		return -EINVAL;
+	}
+
+	class_idx = size_to_class(size, align);
+	if (unlikely(class_idx >= FASTMEM_N_CLASSES)) {
+		rte_errno = E2BIG;
+		return -E2BIG;
+	}
+
+	socket = &fastmem->sockets[socket_id];
+	cache = cache_get(socket, class_idx, lcore_id);
+
+	if (likely(cache != NULL)) {
+		/* Drain from cache. */
+		unsigned int avail = RTE_MIN(cache->count, n);
+
+		cache->count -= avail;
+		memcpy(ptrs, &cache->objs[cache->count],
+			avail * sizeof(void *));
+		got = avail;
+		cache->alloc_cache_hits += avail;
+
+		if (got < n) {
+			unsigned int need = n - got;
+			unsigned int want = RTE_MAX(need, cache->target);
+			unsigned int filled;
+
+			if (want <= cache->capacity) {
+				/* Refill into cache, give caller their share. */
+				filled = bin_alloc_bulk(
+					&socket->bins[class_idx],
+					cache->objs, want, false);
+				if (filled > 0)
+					cache->alloc_cache_misses += RTE_MIN(filled, need);
+				if (filled >= need) {
+					memcpy(ptrs + got,
+						cache->objs + filled - need,
+						need * sizeof(void *));
+					cache->count = filled - need;
+					got = n;
+				} else {
+					memcpy(ptrs + got, cache->objs,
+						filled * sizeof(void *));
+					got += filled;
+					cache->count = 0;
+				}
+			} else {
+				/*
+				 * n exceeds cache capacity; pull directly,
+				 * but count as cache misses since the caller
+				 * has a cache.
+				 */
+				unsigned int pulled = bin_alloc_bulk(
+					&socket->bins[class_idx],
+					ptrs + got, need, false);
+				if (pulled > 0)
+					cache->alloc_cache_misses += pulled;
+				got += pulled;
+			}
+		}
+	} else {
+		got = shared_alloc_bulk(socket, class_idx, ptrs, n);
+	}
+
+	if (unlikely(got < n) && fallback) {
+		unsigned int i;
+
+		for (i = 0; i < rte_socket_count() && got < n; i++) {
+			int sid = rte_socket_id_by_idx(i);
+
+			if (sid < 0 || sid == socket_id)
+				continue;
+
+			socket = &fastmem->sockets[sid];
+			cache = cache_get(socket, class_idx, lcore_id);
+			if (likely(cache != NULL)) {
+				unsigned int avail =
+					RTE_MIN(cache->count, n - got);
+				cache->count -= avail;
+				memcpy(ptrs + got,
+					&cache->objs[cache->count],
+					avail * sizeof(void *));
+				cache->alloc_cache_hits += avail;
+				got += avail;
+			}
+			if (got < n) {
+				if (cache != NULL) {
+					unsigned int pulled = bin_alloc_bulk(
+						&socket->bins[class_idx],
+						ptrs + got, n - got, false);
+					if (pulled > 0)
+						cache->alloc_cache_misses += pulled;
+					got += pulled;
+				} else {
+					got += shared_alloc_bulk(socket,
+						class_idx, ptrs + got, n - got);
+				}
+			}
+		}
+	}
+
+	if (unlikely(got < n)) {
+		/* All-or-nothing: return what we got. */
+		unsigned int i;
+
+		for (i = 0; i < got; i++)
+			do_free(ptrs[i]);
+
+		account_alloc_nomem(&fastmem->sockets[socket_id], class_idx,
+			lcore_id);
+		rte_errno = ENOMEM;
+		return -ENOMEM;
+	}
+
+	if (flags & RTE_FASTMEM_F_ZERO) {
+		size_t cs = class_size(class_idx);
+		unsigned int i;
+
+		for (i = 0; i < n; i++)
+			memset(ptrs[i], 0, cs);
+	}
+
+	return 0;
+}
+
+static void *
+do_alloc(size_t size, size_t align, unsigned int flags,
+		unsigned int lcore_id, int socket_id, bool fallback)
+{
+	unsigned int class_idx;
+	void *obj;
+
+	if (unlikely(!fastmem_assure()))
+		return NULL;
+
+	if (unlikely(!normalize_align(&align))) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	class_idx = size_to_class(size, align);
+	if (unlikely(class_idx >= FASTMEM_N_CLASSES)) {
+		rte_errno = E2BIG;
+		return NULL;
+	}
+
+	obj = alloc_from_socket(&fastmem->sockets[socket_id],
+			class_idx, lcore_id);
+
+	if (likely(obj != NULL))
+		goto out;
+
+	if (fallback) {
+		unsigned int i;
+
+		for (i = 0; i < rte_socket_count(); i++) {
+			int sid = rte_socket_id_by_idx(i);
+
+			if (sid < 0 || sid == socket_id)
+				continue;
+
+			obj = alloc_from_socket(&fastmem->sockets[sid],
+					class_idx, lcore_id);
+			if (obj != NULL)
+				goto out;
+		}
+	}
+
+	account_alloc_nomem(&fastmem->sockets[socket_id], class_idx, lcore_id);
+	rte_errno = ENOMEM;
+	return NULL;
+
+out:
+	if (flags & RTE_FASTMEM_F_ZERO)
+		memset(obj, 0, class_size(class_idx));
+
+	return obj;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc, 24.11)
+void *
+rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
+{
+	return do_alloc(size, align, flags, rte_lcore_id(),
+			local_socket_id(), false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_socket, 24.11)
+void *
+rte_fastmem_alloc_socket(size_t size, size_t align, unsigned int flags,
+		int socket_id)
+{
+	if (socket_id == SOCKET_ID_ANY)
+		return do_alloc(size, align, flags, rte_lcore_id(),
+				local_socket_id(), true);
+
+	if (unlikely(socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return do_alloc(size, align, flags, rte_lcore_id(), socket_id, false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_free, 24.11)
+void
+rte_fastmem_free(void *ptr)
+{
+	if (unlikely(ptr == NULL))
+		return;
+
+	do_free(ptr);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_realloc, 24.11)
+void *
+rte_fastmem_realloc(void *ptr, size_t size, size_t align)
+{
+	struct fastmem_slab *slab;
+	unsigned int old_class, new_class;
+	size_t old_size;
+	void *new_ptr;
+
+	if (ptr == NULL)
+		return rte_fastmem_alloc(size, align, 0);
+
+	if (size == 0) {
+		rte_fastmem_free(ptr);
+		return NULL;
+	}
+
+	if (unlikely(!normalize_align(&align))) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	new_class = size_to_class(size, align);
+	if (unlikely(new_class >= FASTMEM_N_CLASSES)) {
+		rte_errno = E2BIG;
+		return NULL;
+	}
+
+	slab = slab_of(ptr);
+	old_class = slab->bin->class_idx;
+
+	if (new_class == old_class)
+		return ptr;
+
+	new_ptr = rte_fastmem_alloc(size, align, 0);
+	if (unlikely(new_ptr == NULL))
+		return NULL;
+
+	old_size = class_size(old_class);
+	memcpy(new_ptr, ptr, RTE_MIN(old_size, size));
+	rte_fastmem_free(ptr);
+
+	return new_ptr;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_bulk, 24.11)
+int
+rte_fastmem_alloc_bulk(void **ptrs, unsigned int n, size_t size, size_t align,
+		unsigned int flags)
+{
+	return do_alloc_bulk(ptrs, n, size, align, flags,
+			rte_lcore_id(), local_socket_id(), false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_bulk_socket, 24.11)
+int
+rte_fastmem_alloc_bulk_socket(void **ptrs, unsigned int n, size_t size,
+		size_t align, unsigned int flags, int socket_id)
+{
+	if (socket_id == SOCKET_ID_ANY)
+		return do_alloc_bulk(ptrs, n, size, align, flags,
+				rte_lcore_id(), local_socket_id(), true);
+
+	if (unlikely(socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)) {
+		rte_errno = EINVAL;
+		return -EINVAL;
+	}
+
+	return do_alloc_bulk(ptrs, n, size, align, flags,
+			rte_lcore_id(), socket_id, false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_free_bulk, 24.11)
+void
+rte_fastmem_free_bulk(void **ptrs, unsigned int n)
+{
+	unsigned int lcore_id;
+	struct fastmem_slab *slab;
+	struct fastmem_bin *bin;
+	struct fastmem_socket_state *socket;
+	struct fastmem_cache *cache;
+	unsigned int space;
+	unsigned int i;
+
+	if (unlikely(n == 0))
+		return;
+
+	if (unlikely(!fastmem_assure()))
+		return;
+
+	lcore_id = rte_lcore_id();
+
+	/* Fast path: check if first object gives us the bin. */
+	slab = slab_of(ptrs[0]);
+	bin = slab->bin;
+	socket = &fastmem->sockets[bin->socket_id];
+	cache = cache_get(socket, bin->class_idx, lcore_id);
+
+	if (unlikely(cache == NULL)) {
+		for (i = 0; i < n; i++)
+			do_free(ptrs[i]);
+		return;
+	}
+
+	/*
+	 * Try to push all objects into the cache in one memcpy.
+	 * If any object belongs to a different bin, fall back to
+	 * per-object free for the remainder.
+	 */
+	space = cache->capacity - cache->count;
+	if (likely(n <= space)) {
+		/* Verify all same bin (common case). */
+		for (i = 1; i < n; i++)
+			if (slab_of(ptrs[i])->bin != bin)
+				goto slow;
+		cache->free_cache_hits += n;
+		memcpy(&cache->objs[cache->count], ptrs,
+			n * sizeof(void *));
+		cache->count += n;
+		return;
+	}
+
+	/* Would overflow cache — drain first, then push. */
+	if (n <= cache->capacity) {
+		unsigned int drain;
+
+		for (i = 1; i < n; i++)
+			if (slab_of(ptrs[i])->bin != bin)
+				goto slow;
+
+		cache->free_cache_misses += n;
+		drain = cache->count - cache->target + n;
+		if (drain > cache->count)
+			drain = cache->count;
+		if (drain > 0) {
+			bin_free_bulk(bin, cache->objs, drain);
+			cache->count -= drain;
+			memmove(cache->objs, cache->objs + drain,
+				cache->count * sizeof(cache->objs[0]));
+		}
+		memcpy(&cache->objs[cache->count], ptrs,
+			n * sizeof(void *));
+		cache->count += n;
+		return;
+	}
+
+slow:
+	for (i = 0; i < n; i++)
+		do_free(ptrs[i]);
+}
+
+#define fastmem_handle_class_BITS 8
+
+static rte_fastmem_handle_t
+fastmem_handle_pack(unsigned int class_idx, int socket_id)
+{
+	return (uint32_t)class_idx |
+		((uint32_t)socket_id << fastmem_handle_class_BITS);
+}
+
+static unsigned int
+fastmem_handle_class(rte_fastmem_handle_t h)
+{
+	return h & ((1U << fastmem_handle_class_BITS) - 1);
+}
+
+static int
+fastmem_handle_socket(rte_fastmem_handle_t h)
+{
+	return (int)(h >> fastmem_handle_class_BITS);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_hlookup, 24.11)
+int
+rte_fastmem_hlookup(size_t size, size_t align, int socket_id,
+		rte_fastmem_handle_t *handle)
+{
+	unsigned int class_idx;
+	struct fastmem_socket_state *socket;
+
+	if (handle == NULL)
+		return -EINVAL;
+
+	if (!normalize_align(&align))
+		return -EINVAL;
+
+	if (socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)
+		return -EINVAL;
+
+	class_idx = size_to_class(size, align);
+	if (class_idx >= FASTMEM_N_CLASSES)
+		return -E2BIG;
+
+	/* Pre-create the cache for the calling lcore. */
+	socket = &fastmem->sockets[socket_id];
+	cache_create(socket, class_idx, rte_lcore_id());
+
+	*handle = fastmem_handle_pack(class_idx, socket_id);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_halloc, 24.11)
+void *
+rte_fastmem_halloc(rte_fastmem_handle_t handle, unsigned int flags)
+{
+	unsigned int class_idx = fastmem_handle_class(handle);
+	int socket_id = fastmem_handle_socket(handle);
+	unsigned int lcore_id = rte_lcore_id();
+	struct fastmem_socket_state *socket;
+	struct fastmem_bin *bin;
+	struct fastmem_cache *cache;
+	void *obj;
+
+	if (unlikely(!fastmem_assure()))
+		return NULL;
+
+	socket = &fastmem->sockets[socket_id];
+	bin = &socket->bins[class_idx];
+
+	cache = cache_get(socket, class_idx, lcore_id);
+	if (likely(cache != NULL))
+		obj = cache_pop(cache, bin);
+	else
+		obj = shared_alloc_one(socket, class_idx);
+
+	if (unlikely(obj == NULL)) {
+		account_alloc_nomem(socket, class_idx, lcore_id);
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	if (flags & RTE_FASTMEM_F_ZERO)
+		memset(obj, 0, class_size(class_idx));
+
+	return obj;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_halloc_bulk, 24.11)
+int
+rte_fastmem_halloc_bulk(rte_fastmem_handle_t handle,
+		void **ptrs, unsigned int n, unsigned int flags)
+{
+	unsigned int class_idx = fastmem_handle_class(handle);
+	int socket_id = fastmem_handle_socket(handle);
+
+	return do_alloc_bulk(ptrs, n, class_size(class_idx),
+			RTE_CACHE_LINE_SIZE, flags, rte_lcore_id(),
+			socket_id, false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_hfree, 24.11)
+void
+rte_fastmem_hfree(rte_fastmem_handle_t handle, void *ptr)
+{
+	unsigned int class_idx = fastmem_handle_class(handle);
+	int socket_id = fastmem_handle_socket(handle);
+	unsigned int lcore_id = rte_lcore_id();
+	struct fastmem_socket_state *socket;
+	struct fastmem_bin *bin;
+	struct fastmem_cache *cache;
+
+	if (unlikely(ptr == NULL))
+		return;
+
+	if (unlikely(!fastmem_assure()))
+		return;
+
+	socket = &fastmem->sockets[socket_id];
+	bin = &socket->bins[class_idx];
+
+	cache = cache_get(socket, class_idx, lcore_id);
+	if (likely(cache != NULL))
+		cache_push(cache, bin, ptr);
+	else
+		shared_free_one(socket, class_idx, ptr);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_hfree_bulk, 24.11)
+void
+rte_fastmem_hfree_bulk(rte_fastmem_handle_t handle,
+		void **ptrs, unsigned int n)
+{
+	unsigned int class_idx = fastmem_handle_class(handle);
+	int socket_id = fastmem_handle_socket(handle);
+	struct fastmem_socket_state *socket;
+	struct fastmem_bin *bin;
+	unsigned int lcore_id;
+	struct fastmem_cache *cache;
+	unsigned int i;
+
+	if (unlikely(n == 0))
+		return;
+
+	if (unlikely(!fastmem_assure()))
+		return;
+
+	socket = &fastmem->sockets[socket_id];
+	bin = &socket->bins[class_idx];
+
+	lcore_id = rte_lcore_id();
+	cache = cache_get(socket, class_idx, lcore_id);
+
+	if (likely(cache != NULL)) {
+		for (i = 0; i < n; i++)
+			cache_push(cache, bin, ptrs[i]);
+	} else {
+		for (i = 0; i < n; i++)
+			shared_free_one(socket, class_idx, ptrs[i]);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_virt2iova, 24.11)
+rte_iova_t
+rte_fastmem_virt2iova(const void *ptr)
+{
+	struct fastmem_slab *slab;
+
+	if (unlikely(!fastmem_assure()))
+		return RTE_BAD_IOVA;
+
+	slab = slab_of((void *)(uintptr_t)ptr);
+
+	return slab->iova_base + ((uintptr_t)ptr - (uintptr_t)slab);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_cache_flush, 24.11)
+void
+rte_fastmem_cache_flush(void)
+{
+	unsigned int lcore_id;
+	unsigned int s, c;
+
+	if (fastmem == NULL)
+		return;
+
+	lcore_id = rte_lcore_id();
+	if (lcore_id >= RTE_MAX_LCORE)
+		return;
+
+	for (s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		for (c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_cache *cache =
+				socket->caches[lcore_id][c];
+
+			if (cache == NULL)
+				continue;
+
+			/*
+			 * Drain the objects back to the bin, but keep the
+			 * cache struct: it holds the lcore's statistics,
+			 * which must survive the flush.
+			 */
+			if (cache->count > 0) {
+				bin_free_bulk(&socket->bins[c],
+					cache->objs, cache->count);
+				cache->count = 0;
+			}
+		}
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats, 24.11)
+int
+rte_fastmem_stats(struct rte_fastmem_stats *stats)
+{
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+
+	*stats = (struct rte_fastmem_stats){0};
+	stats->n_classes = FASTMEM_N_CLASSES;
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		stats->bytes_backing += socket->reserved_bytes;
+
+		for (unsigned int c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_bin *bin = &socket->bins[c];
+			uint64_t class_allocs, class_frees;
+
+			class_allocs = bin->nocache_allocs;
+			class_frees = bin->nocache_frees;
+			stats->alloc_nomem += bin->nocache_nomem;
+
+			for (unsigned int l = 0; l < RTE_MAX_LCORE; l++) {
+				struct fastmem_cache *cache =
+					socket->caches[l][c];
+
+				if (cache == NULL)
+					continue;
+
+				class_allocs += cache->alloc_cache_hits +
+					cache->alloc_cache_misses;
+				class_frees += cache->free_cache_hits +
+					cache->free_cache_misses;
+				stats->alloc_nomem += cache->alloc_nomem;
+			}
+
+			struct fastmem_cache *shared = socket->shared_caches[c];
+
+			if (shared != NULL) {
+				class_allocs += shared->alloc_cache_hits +
+					shared->alloc_cache_misses;
+				class_frees += shared->free_cache_hits +
+					shared->free_cache_misses;
+				stats->alloc_nomem += shared->alloc_nomem;
+			}
+
+			stats->alloc_total += class_allocs;
+			stats->free_total += class_frees;
+			if (class_allocs > class_frees)
+				stats->bytes_in_use += class_size(c) *
+					(class_allocs - class_frees);
+		}
+	}
+
+	return 0;
+}
+
+static unsigned int
+exact_class_idx(size_t sz)
+{
+	unsigned int log2;
+
+	if (sz < FASTMEM_MIN_SIZE || sz > FASTMEM_MAX_ALLOC_SIZE)
+		return FASTMEM_N_CLASSES;
+	if ((sz & (sz - 1)) != 0)
+		return FASTMEM_N_CLASSES;
+
+	log2 = (unsigned int)rte_ctz64(sz);
+	if (log2 < FASTMEM_MIN_CLASS_LOG2 || log2 > FASTMEM_MAX_CLASS_LOG2)
+		return FASTMEM_N_CLASSES;
+
+	return log2 - FASTMEM_MIN_CLASS_LOG2;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_class, 24.11)
+int
+rte_fastmem_stats_class(size_t class_size_arg,
+		struct rte_fastmem_class_stats *stats)
+{
+	unsigned int c;
+	uint64_t allocs, frees;
+
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+
+	c = exact_class_idx(class_size_arg);
+	if (c >= FASTMEM_N_CLASSES)
+		return -EINVAL;
+
+	*stats = (struct rte_fastmem_class_stats){0};
+	stats->class_size = class_size(c);
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+		struct fastmem_bin *bin = &socket->bins[c];
+
+		for (unsigned int l = 0; l < RTE_MAX_LCORE; l++) {
+			struct fastmem_cache *cache = socket->caches[l][c];
+
+			if (cache == NULL)
+				continue;
+
+			stats->alloc_cache_hits += cache->alloc_cache_hits;
+			stats->alloc_cache_misses += cache->alloc_cache_misses;
+			stats->alloc_nomem += cache->alloc_nomem;
+			stats->free_cache_hits += cache->free_cache_hits;
+			stats->free_cache_misses += cache->free_cache_misses;
+		}
+
+		struct fastmem_cache *shared = socket->shared_caches[c];
+
+		if (shared != NULL) {
+			stats->alloc_cache_hits += shared->alloc_cache_hits;
+			stats->alloc_cache_misses += shared->alloc_cache_misses;
+			stats->alloc_nomem += shared->alloc_nomem;
+			stats->free_cache_hits += shared->free_cache_hits;
+			stats->free_cache_misses += shared->free_cache_misses;
+		}
+
+		/* No-cache fallback traffic; fold into the miss counters. */
+		stats->alloc_cache_misses += bin->nocache_allocs;
+		stats->free_cache_misses += bin->nocache_frees;
+		stats->alloc_nomem += bin->nocache_nomem;
+
+		stats->slab_acquires += bin->slab_acquires;
+		stats->slab_releases += bin->slab_releases;
+		stats->slabs_partial += bin->slabs_partial;
+		stats->slabs_full += bin->slabs_full;
+	}
+
+	allocs = stats->alloc_cache_hits + stats->alloc_cache_misses;
+	frees = stats->free_cache_hits + stats->free_cache_misses;
+	if (allocs > frees)
+		stats->in_use = allocs - frees;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_lcore, 24.11)
+int
+rte_fastmem_stats_lcore(unsigned int lcore_id,
+		struct rte_fastmem_lcore_stats *stats)
+{
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+	if (lcore_id >= RTE_MAX_LCORE)
+		return -EINVAL;
+
+	*stats = (struct rte_fastmem_lcore_stats){0};
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		for (unsigned int c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_cache *cache =
+				socket->caches[lcore_id][c];
+
+			if (cache == NULL)
+				continue;
+
+			stats->alloc_cache_hits += cache->alloc_cache_hits;
+			stats->alloc_cache_misses += cache->alloc_cache_misses;
+			stats->alloc_nomem += cache->alloc_nomem;
+			stats->free_cache_hits += cache->free_cache_hits;
+			stats->free_cache_misses += cache->free_cache_misses;
+		}
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_lcore_class, 24.11)
+int
+rte_fastmem_stats_lcore_class(unsigned int lcore_id, size_t class_size_arg,
+		struct rte_fastmem_lcore_class_stats *stats)
+{
+	unsigned int c;
+
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+	if (lcore_id >= RTE_MAX_LCORE)
+		return -EINVAL;
+
+	c = exact_class_idx(class_size_arg);
+	if (c >= FASTMEM_N_CLASSES)
+		return -EINVAL;
+
+	*stats = (struct rte_fastmem_lcore_class_stats){0};
+	stats->class_size = class_size(c);
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_cache *cache =
+			fastmem->sockets[s].caches[lcore_id][c];
+
+		if (cache == NULL)
+			continue;
+
+		stats->alloc_cache_hits += cache->alloc_cache_hits;
+		stats->alloc_cache_misses += cache->alloc_cache_misses;
+		stats->alloc_nomem += cache->alloc_nomem;
+		stats->free_cache_hits += cache->free_cache_hits;
+		stats->free_cache_misses += cache->free_cache_misses;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_shared, 24.11)
+int
+rte_fastmem_stats_shared(struct rte_fastmem_lcore_stats *stats)
+{
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+
+	*stats = (struct rte_fastmem_lcore_stats){0};
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		for (unsigned int c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_cache *cache = socket->shared_caches[c];
+
+			if (cache == NULL)
+				continue;
+
+			stats->alloc_cache_hits += cache->alloc_cache_hits;
+			stats->alloc_cache_misses += cache->alloc_cache_misses;
+			stats->alloc_nomem += cache->alloc_nomem;
+			stats->free_cache_hits += cache->free_cache_hits;
+			stats->free_cache_misses += cache->free_cache_misses;
+		}
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_shared_class, 24.11)
+int
+rte_fastmem_stats_shared_class(size_t class_size_arg,
+		struct rte_fastmem_lcore_class_stats *stats)
+{
+	unsigned int c;
+
+	if (stats == NULL)
+		return -EINVAL;
+	if (!fastmem_assure())
+		return -ENODEV;
+
+	c = exact_class_idx(class_size_arg);
+	if (c >= FASTMEM_N_CLASSES)
+		return -EINVAL;
+
+	*stats = (struct rte_fastmem_lcore_class_stats){0};
+	stats->class_size = class_size(c);
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_cache *cache =
+			fastmem->sockets[s].shared_caches[c];
+
+		if (cache == NULL)
+			continue;
+
+		stats->alloc_cache_hits += cache->alloc_cache_hits;
+		stats->alloc_cache_misses += cache->alloc_cache_misses;
+		stats->alloc_nomem += cache->alloc_nomem;
+		stats->free_cache_hits += cache->free_cache_hits;
+		stats->free_cache_misses += cache->free_cache_misses;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_reset, 24.11)
+void
+rte_fastmem_stats_reset(void)
+{
+	if (fastmem == NULL)
+		return;
+
+	for (unsigned int s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		for (unsigned int c = 0; c < FASTMEM_N_CLASSES; c++) {
+			struct fastmem_bin *bin = &socket->bins[c];
+
+			rte_spinlock_lock(&bin->lock);
+			bin->slab_acquires = 0;
+			bin->slab_releases = 0;
+			bin->nocache_allocs = 0;
+			bin->nocache_frees = 0;
+			bin->nocache_nomem = 0;
+			rte_spinlock_unlock(&bin->lock);
+
+			for (unsigned int l = 0; l < RTE_MAX_LCORE; l++) {
+				struct fastmem_cache *cache =
+					socket->caches[l][c];
+				if (cache == NULL)
+					continue;
+				cache->alloc_cache_hits = 0;
+				cache->alloc_cache_misses = 0;
+				cache->alloc_nomem = 0;
+				cache->free_cache_hits = 0;
+				cache->free_cache_misses = 0;
+			}
+
+			rte_spinlock_lock(&socket->shared_cache_lock);
+			struct fastmem_cache *shared = socket->shared_caches[c];
+			if (shared != NULL) {
+				shared->alloc_cache_hits = 0;
+				shared->alloc_cache_misses = 0;
+				shared->alloc_nomem = 0;
+				shared->free_cache_hits = 0;
+				shared->free_cache_misses = 0;
+			}
+			rte_spinlock_unlock(&socket->shared_cache_lock);
+		}
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_classes, 24.11)
+unsigned int
+rte_fastmem_classes(size_t *sizes)
+{
+	if (sizes != NULL)
+		for (unsigned int i = 0; i < FASTMEM_N_CLASSES; i++)
+			sizes[i] = class_size(i);
+	return FASTMEM_N_CLASSES;
+}
diff --git a/lib/fastmem/rte_fastmem.h b/lib/fastmem/rte_fastmem.h
new file mode 100644
index 0000000000..8526d2a001
--- /dev/null
+++ b/lib/fastmem/rte_fastmem.h
@@ -0,0 +1,908 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+#ifndef _RTE_FASTMEM_H_
+#define _RTE_FASTMEM_H_
+
+/**
+ * @file
+ *
+ * RTE Fastmem
+ *
+ * @warning
+ * @b EXPERIMENTAL:
+ * All functions in this file may be changed or removed without prior notice.
+ *
+ * The fastmem library is a fast, general-purpose small-object
+ * allocator for DPDK applications. It is intended to allow an
+ * application to replace its many per-type mempools — each sized
+ * for a single object type (a connection, a session, a work item,
+ * a timer, etc.) — with a single allocator that handles arbitrary
+ * object sizes, grows on demand, and offers mempool-level
+ * performance for the common allocation and free paths.
+ *
+ * Like mempool, fastmem is backed by huge pages, is NUMA-aware,
+ * supports bulk operations, and uses per-lcore caches to reduce
+ * shared-state contention. Unlike mempool, it does not require the
+ * caller to declare object sizes or counts up front.
+ *
+ * There is a single, global fastmem instance per process. The
+ * instance is brought up with rte_fastmem_init() and torn down with
+ * rte_fastmem_deinit(). Allocations are made with
+ * rte_fastmem_alloc() and freed with rte_fastmem_free().
+ *
+ * The allocator is bounded to small-object allocations. Requests
+ * larger than rte_fastmem_max_size() are rejected; callers with
+ * such needs should use rte_malloc() directly.
+ *
+ * Backing memory is reserved from DPDK memzones. Once reserved,
+ * backing memory is not returned to the system during the
+ * allocator's lifetime. Callers that need predictable latency may
+ * pre-reserve backing memory up front using rte_fastmem_reserve(),
+ * avoiding memzone-reservation overhead during steady-state
+ * operation.
+ *
+ * Alignment argument, @c align:
+ *   If non-zero, @c align specifies an exact minimum alignment and
+ *   must be a power of 2. If zero, the default alignment is
+ *   @c RTE_CACHE_LINE_SIZE, so that objects obtained from distinct
+ *   calls cannot false-share a cache line.
+ *
+ * Threads and caches:
+ *   Only threads with an lcore id running in the primary process
+ *   get a private per-lcore cache, which makes their common path
+ *   lock-free. Every other caller — unregistered non-EAL threads
+ *   (which have no lcore id), and all threads in a secondary
+ *   process — instead shares a single spinlock-protected cache per
+ *   (size class, socket). These callers still benefit from caching,
+ *   but pay for the shared lock and so cost more per call than a
+ *   private-cache thread.
+ *
+ * Non-preemptible caller:
+ *   Callers should not be preemptible while inside a fastmem call.
+ *   Fastmem uses internal spinlocks; if a caller is preempted
+ *   while holding one, any other thread that subsequently needs
+ *   the same lock stalls until the preempted caller resumes.
+ */
+
+#include <stddef.h>
+#include <stdint.h>
+
+#include <rte_bitops.h>
+#include <rte_common.h>
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Flag for rte_fastmem_alloc() and its variants: initialize the
+ * returned memory to zero before returning it to the caller.
+ */
+#define RTE_FASTMEM_F_ZERO RTE_BIT32(0)
+
+/**
+ * Initialize the fastmem allocator.
+ *
+ * Sets up the library's internal state. Must be called before any
+ * allocation call. Typically called once per process, after
+ * rte_eal_init() and before the application's worker threads begin
+ * making allocations.
+ *
+ * Initialization does not pre-reserve any backing memory; memzones
+ * are reserved lazily as allocations require. An application that
+ * wants to avoid memzone-reservation latency on the allocation
+ * path should follow rte_fastmem_init() with one or more calls to
+ * rte_fastmem_reserve().
+ *
+ * This function is not thread-safe and must not be called
+ * concurrently with any other fastmem function.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EBUSY: The allocator is already initialized.
+ *  - -ENOMEM: Unable to allocate internal state.
+ */
+__rte_experimental
+int
+rte_fastmem_init(void);
+
+/**
+ * Tear down the fastmem allocator.
+ *
+ * Releases the library's internal state and frees all backing
+ * memzones. After this call, no fastmem allocations or frees may
+ * be made until rte_fastmem_init() is called again.
+ *
+ * The caller is responsible for ensuring that no fastmem-allocated
+ * objects remain in use. Outstanding allocations at deinit time
+ * result in undefined behavior.
+ *
+ * This function is not thread-safe and must not be called
+ * concurrently with any other fastmem function.
+ */
+__rte_experimental
+void
+rte_fastmem_deinit(void);
+
+/**
+ * Pre-reserve backing memory.
+ *
+ * Ensures that at least @p size bytes of memzone-backed memory are
+ * available to the allocator on @p socket_id, reserving additional
+ * memzones from EAL as needed to reach that total. Subsequent
+ * allocations served from the pre-reserved memory do not incur
+ * memzone-reservation cost.
+ *
+ * The reservation is cumulative: repeated calls to
+ * rte_fastmem_reserve() with the same @p socket_id grow the
+ * reservation monotonically. Reserved memory is never returned to
+ * the system during the allocator's lifetime.
+ *
+ * A typical use is to call rte_fastmem_reserve() once at
+ * application startup, with a size chosen to cover the expected
+ * steady-state working set. Allocations and frees during
+ * steady-state operation then avoid memzone reservations entirely.
+ *
+ * @param size
+ *  The minimum amount of backing memory, in bytes, to make
+ *  available on @p socket_id. The allocator may reserve more than
+ *  the requested amount due to internal rounding (e.g., to memzone
+ *  or block granularity).
+ *
+ * @param socket_id
+ *  The NUMA socket on which to reserve memory, or SOCKET_ID_ANY
+ *  to leave the choice to the allocator. With SOCKET_ID_ANY, the
+ *  allocator starts on the calling lcore's socket (or the first
+ *  configured socket if the caller is not bound to one) and falls
+ *  back to other sockets if the preferred socket cannot satisfy
+ *  the reservation.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -ENOMEM: Insufficient huge-page memory to satisfy the request.
+ *  - -EINVAL: Invalid @p socket_id.
+ */
+__rte_experimental
+int
+rte_fastmem_reserve(size_t size, int socket_id);
+
+/**
+ * Set the maximum backing memory that may be reserved on a socket.
+ *
+ * Once the limit is reached, allocations that would require new
+ * backing memory on the constrained socket fail with ENOMEM.
+ * Already-reserved memory is not released.
+ *
+ * Setting a limit below the current reserved amount is allowed and
+ * prevents further growth.
+ *
+ * @param socket_id
+ *  The NUMA socket to constrain, or SOCKET_ID_ANY to apply the
+ *  limit to all sockets.
+ * @param max_bytes
+ *  Maximum backing memory in bytes, or SIZE_MAX for unlimited (the default).
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: Fastmem not initialized, or invalid @p socket_id.
+ */
+__rte_experimental
+int
+rte_fastmem_set_limit(int socket_id, size_t max_bytes);
+
+/**
+ * Get the maximum backing memory limit for a socket.
+ *
+ * @param socket_id
+ *  The NUMA socket to query.
+ * @return
+ *  The limit in bytes, or SIZE_MAX if unlimited.
+ */
+__rte_experimental
+size_t
+rte_fastmem_get_limit(int socket_id);
+
+/**
+ * Retrieve the largest allocation size the allocator supports.
+ *
+ * Requests larger than this size are rejected by the allocation
+ * functions. The returned value is a property of the allocator
+ * implementation and does not change across the lifetime of the
+ * process.
+ *
+ * @return
+ *  The largest supported allocation size, in bytes.
+ */
+__rte_experimental
+size_t
+rte_fastmem_max_size(void);
+
+/* Forward declaration for __rte_dealloc attribute. */
+void rte_fastmem_free(void *ptr);
+
+/**
+ * Allocate an object from the fastmem allocator.
+ *
+ * Allocates at least @p size bytes, aligned to at least @p align
+ * bytes. The returned memory is backed by huge pages and is
+ * DMA-usable; its IOVA can be obtained via rte_fastmem_virt2iova().
+ *
+ * On NUMA systems, the memory is allocated on the socket of the
+ * calling lcore. Use rte_fastmem_alloc_socket() to target a
+ * specific socket.
+ *
+ * The allocated memory must be freed with rte_fastmem_free(). An
+ * allocation may be freed from any lcore, not only the lcore that
+ * made the allocation.
+ *
+ * This function is MT-safe.
+ *
+ * @param size
+ *  Requested allocation size, in bytes. Must not exceed
+ *  rte_fastmem_max_size().
+ *
+ * @param align
+ *  If 0, the returned pointer will be aligned to at least
+ *  @c RTE_CACHE_LINE_SIZE. Otherwise, the returned pointer will
+ *  be aligned on a multiple of @p align, which must be a power of
+ *  2.
+ *
+ * @param flags
+ *  A bitwise OR of zero or more RTE_FASTMEM_F_* flags. Use
+ *  RTE_FASTMEM_F_ZERO to obtain zero-initialized memory.
+ *
+ * @return
+ *  - A pointer to the allocated object on success.
+ *  - NULL on failure, with @c rte_errno set:
+ *    - E2BIG: @p size exceeds rte_fastmem_max_size().
+ *    - EINVAL: Invalid @p align (not a power of two).
+ *    - ENOMEM: Allocation could not be served from existing
+ *      backing memory and no additional memzone could be reserved.
+ */
+__rte_experimental
+void *
+rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
+	__rte_malloc __rte_dealloc(rte_fastmem_free, 1);
+
+/**
+ * Allocate an object on a specific NUMA socket.
+ *
+ * Like rte_fastmem_alloc(), but targets the specified NUMA socket
+ * rather than the socket of the calling lcore. Use this variant
+ * when the lifetime or access pattern of the allocation is not
+ * tied to the calling lcore's socket.
+ *
+ * This function is MT-safe.
+ *
+ * @param size
+ *  Requested allocation size, in bytes. Must not exceed
+ *  rte_fastmem_max_size().
+ *
+ * @param align
+ *  If 0, the returned pointer will be aligned to at least
+ *  @c RTE_CACHE_LINE_SIZE. Otherwise, the returned pointer will
+ *  be aligned on a multiple of @p align, which must be a power of
+ *  2.
+ *
+ * @param flags
+ *  A bitwise OR of zero or more RTE_FASTMEM_F_* flags.
+ *
+ * @param socket_id
+ *  The NUMA socket on which to allocate, or SOCKET_ID_ANY to
+ *  leave the choice to the allocator. With SOCKET_ID_ANY, the
+ *  allocator starts on the calling lcore's socket (or the first
+ *  configured socket if the caller is not bound to one) and falls
+ *  back to other sockets if the preferred socket cannot satisfy
+ *  the request.
+ *
+ * @return
+ *  - A pointer to the allocated object on success.
+ *  - NULL on failure, with @c rte_errno set (see rte_fastmem_alloc()).
+ */
+__rte_experimental
+void *
+rte_fastmem_alloc_socket(size_t size, size_t align, unsigned int flags,
+		int socket_id)
+	__rte_malloc __rte_dealloc(rte_fastmem_free, 1);
+
+/**
+ * Resize a fastmem allocation, preserving existing contents.
+ *
+ * If @p ptr is NULL, equivalent to rte_fastmem_alloc(size, align, 0).
+ * If @p size is 0, frees @p ptr and returns NULL.
+ *
+ * If the existing allocation can already satisfy the new size and
+ * alignment, the original pointer may be returned unchanged.
+ * Otherwise, a new allocation is made, the contents are copied
+ * (up to the minimum of old and new sizes), and the old allocation
+ * is freed.
+ *
+ * This function is MT-safe.
+ *
+ * @param ptr
+ *  Pointer to an existing fastmem allocation, or NULL.
+ *
+ * @param size
+ *  New requested size in bytes. If 0, the allocation is freed.
+ *
+ * @param align
+ *  If 0, alignment is at least @c RTE_CACHE_LINE_SIZE. Otherwise,
+ *  must be a power of 2.
+ *
+ * @return
+ *  - A pointer to the resized allocation on success.
+ *  - NULL on failure, with @c rte_errno set:
+ *    - E2BIG: @p size exceeds rte_fastmem_max_size().
+ *    - EINVAL: Invalid @p align.
+ *    - ENOMEM: Allocation could not be served.
+ *  On failure, the original allocation at @p ptr remains valid.
+ */
+__rte_experimental
+void *
+rte_fastmem_realloc(void *ptr, size_t size, size_t align)
+	__rte_dealloc(rte_fastmem_free, 1);
+
+/**
+ * Free an object previously allocated by the fastmem allocator.
+ *
+ * @p ptr must have been returned by a prior call to any fastmem
+ * allocation function, or be NULL. If @p ptr is NULL, no operation
+ * is performed.
+ *
+ * Free may be called from any lcore, regardless of which lcore
+ * made the original allocation.
+ *
+ * This function is MT-safe.
+ *
+ * @param ptr
+ *  Pointer to an object previously allocated by fastmem, or NULL.
+ */
+__rte_experimental
+void
+rte_fastmem_free(void *ptr);
+
+/**
+ * Allocate multiple objects in bulk.
+ *
+ * Allocates @p n objects, each of size at least @p size and aligned
+ * to at least @p align bytes, and stores the resulting pointers
+ * into @p ptrs. All @p n objects have the same size and alignment.
+ *
+ * On NUMA systems, the memory is allocated on the socket of the
+ * calling lcore. Use rte_fastmem_alloc_bulk_socket() to target a
+ * specific socket.
+ *
+ * The bulk path amortizes per-object overhead and is typically
+ * faster than @p n individual calls to rte_fastmem_alloc().
+ *
+ * On failure no objects are allocated and @p ptrs is left
+ * untouched.
+ *
+ * This function is MT-safe.
+ *
+ * @param ptrs
+ *  An array of at least @p n pointers into which the newly
+ *  allocated object pointers are written.
+ *
+ * @param n
+ *  The number of objects to allocate.
+ *
+ * @param size
+ *  Requested size of each object, in bytes. Must not exceed
+ *  rte_fastmem_max_size().
+ *
+ * @param align
+ *  If 0, returned pointers will be aligned to at least
+ *  @c RTE_CACHE_LINE_SIZE. Otherwise, returned pointers will be
+ *  aligned on a multiple of @p align, which must be a power of 2.
+ *
+ * @param flags
+ *  A bitwise OR of zero or more RTE_FASTMEM_F_* flags.
+ *
+ * @return
+ *  - 0: All @p n objects were allocated and stored in @p ptrs.
+ *  - -E2BIG: @p size exceeds rte_fastmem_max_size().
+ *  - -EINVAL: Invalid @p align.
+ *  - -ENOMEM: Not enough objects could be allocated to fill the
+ *    request.
+ */
+__rte_experimental
+int
+rte_fastmem_alloc_bulk(void **ptrs, unsigned int n, size_t size, size_t align,
+		unsigned int flags);
+
+/**
+ * Allocate multiple objects in bulk on a specific NUMA socket.
+ *
+ * Like rte_fastmem_alloc_bulk(), but targets the specified NUMA
+ * socket rather than the socket of the calling lcore.
+ *
+ * This function is MT-safe.
+ *
+ * @param ptrs
+ *  An array of at least @p n pointers into which the newly
+ *  allocated object pointers are written.
+ *
+ * @param n
+ *  The number of objects to allocate.
+ *
+ * @param size
+ *  Requested size of each object, in bytes. Must not exceed
+ *  rte_fastmem_max_size().
+ *
+ * @param align
+ *  If 0, returned pointers will be aligned to at least
+ *  @c RTE_CACHE_LINE_SIZE. Otherwise, returned pointers will be
+ *  aligned on a multiple of @p align, which must be a power of 2.
+ *
+ * @param flags
+ *  A bitwise OR of zero or more RTE_FASTMEM_F_* flags.
+ *
+ * @param socket_id
+ *  The NUMA socket on which to allocate, or SOCKET_ID_ANY to
+ *  leave the choice to the allocator. With SOCKET_ID_ANY, the
+ *  allocator starts on the calling lcore's socket (or the first
+ *  configured socket if the caller is not bound to one) and falls
+ *  back to other sockets if the preferred socket cannot satisfy
+ *  the request.
+ *
+ * @return
+ *  - 0: All @p n objects were allocated and stored in @p ptrs.
+ *  - Negative errno on failure (see rte_fastmem_alloc_bulk()).
+ */
+__rte_experimental
+int
+rte_fastmem_alloc_bulk_socket(void **ptrs, unsigned int n, size_t size,
+		size_t align, unsigned int flags, int socket_id);
+
+/**
+ * Free multiple objects in bulk.
+ *
+ * Frees the @p n objects pointed to by @p ptrs. Each pointer in
+ * the array must have been returned by a prior fastmem allocation
+ * call and must not have been freed. The objects need not have
+ * the same size, alignment, or socket.
+ *
+ * The bulk path amortizes per-object overhead and is typically
+ * faster than @p n individual calls to rte_fastmem_free().
+ *
+ * This function is MT-safe.
+ *
+ * @param ptrs
+ *  An array of @p n pointers to fastmem-allocated objects.
+ *
+ * @param n
+ *  The number of objects to free.
+ */
+__rte_experimental
+void
+rte_fastmem_free_bulk(void **ptrs, unsigned int n);
+
+/**
+ * Opaque handle encoding a (size class, NUMA socket) pair.
+ *
+ * Obtained via rte_fastmem_hlookup(). Passing a handle to
+ * rte_fastmem_halloc() avoids the per-call size-class
+ * lookup and socket resolution, improving allocation throughput
+ * for fixed-size objects.
+ */
+typedef uint32_t rte_fastmem_handle_t;
+
+/**
+ * Look up a handle for a given object size and NUMA socket.
+ *
+ * The returned handle encodes the size class and socket, and can
+ * be passed to rte_fastmem_halloc() to allocate objects
+ * without repeating the class lookup.
+ *
+ * @param size
+ *  Object size in bytes. Must not exceed rte_fastmem_max_size().
+ *
+ * @param align
+ *  Alignment requirement (power of two), or 0 for the default
+ *  (RTE_CACHE_LINE_SIZE).
+ *
+ * @param socket_id
+ *  NUMA socket to allocate from.
+ *
+ * @param[out] handle
+ *  On success, set to the resolved handle.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: Invalid alignment or socket_id.
+ *  - -E2BIG: @p size exceeds rte_fastmem_max_size().
+ */
+__rte_experimental
+int
+rte_fastmem_hlookup(size_t size, size_t align, int socket_id,
+		rte_fastmem_handle_t *handle);
+
+/**
+ * Allocate an object using a pre-resolved handle.
+ *
+ * Equivalent to rte_fastmem_alloc() but skips the size-class
+ * lookup and socket resolution, using the pre-resolved handle
+ * instead.
+ *
+ * A handle is not tied to the lcore that produced it: it may be
+ * shared across threads and used from any thread, including from
+ * lcores that never called rte_fastmem_hlookup() and from non-EAL
+ * threads. As with rte_fastmem_alloc(), callers without a private
+ * per-lcore cache use the shared cache instead.
+ *
+ * This function is MT-safe.
+ *
+ * @param handle
+ *  A handle previously obtained from rte_fastmem_hlookup().
+ *
+ * @param flags
+ *  Allocation flags (e.g., RTE_FASTMEM_F_ZERO).
+ *
+ * @return
+ *  A pointer to the allocated object, or NULL on failure
+ *  (rte_errno is set).
+ */
+__rte_experimental
+void *
+rte_fastmem_halloc(rte_fastmem_handle_t handle, unsigned int flags)
+	__rte_malloc __rte_dealloc(rte_fastmem_free, 1);
+
+/**
+ * Bulk-allocate objects using a pre-resolved handle.
+ *
+ * Equivalent to rte_fastmem_alloc_bulk() but uses a pre-resolved
+ * handle. All-or-nothing semantics apply.
+ *
+ * @param handle
+ *  A handle previously obtained from rte_fastmem_hlookup().
+ *
+ * @param[out] ptrs
+ *  Array to receive @p n allocated pointers.
+ *
+ * @param n
+ *  Number of objects to allocate.
+ *
+ * @param flags
+ *  Allocation flags (e.g., RTE_FASTMEM_F_ZERO).
+ *
+ * @return
+ *  - 0: All @p n objects allocated successfully.
+ *  - -ENOMEM: Allocation failed; no objects were allocated.
+ */
+__rte_experimental
+int
+rte_fastmem_halloc_bulk(rte_fastmem_handle_t handle,
+		void **ptrs, unsigned int n, unsigned int flags);
+
+/**
+ * Free an object using a pre-resolved handle.
+ *
+ * Equivalent to rte_fastmem_free() but skips the slab-header
+ * lookup by using the class and socket encoded in the handle.
+ *
+ * Like rte_fastmem_halloc(), this may be called from any thread,
+ * regardless of which thread produced the handle or the object.
+ *
+ * This function is MT-safe.
+ *
+ * @param handle
+ *  A handle previously obtained from rte_fastmem_hlookup().
+ *
+ * @param ptr
+ *  A pointer previously returned by a fastmem allocation function.
+ *  Must belong to the same size class and socket as @p handle.
+ *  NULL is permitted (no-op).
+ */
+__rte_experimental
+void
+rte_fastmem_hfree(rte_fastmem_handle_t handle, void *ptr);
+
+/**
+ * Bulk-free objects using a pre-resolved handle.
+ *
+ * Equivalent to rte_fastmem_free_bulk() but skips per-object
+ * slab-header lookups.
+ *
+ * All objects must belong to the same size class and socket as
+ * @p handle.
+ *
+ * @param handle
+ *  A handle previously obtained from rte_fastmem_hlookup().
+ *
+ * @param ptrs
+ *  An array of @p n pointers to fastmem-allocated objects.
+ *
+ * @param n
+ *  The number of objects to free.
+ */
+__rte_experimental
+void
+rte_fastmem_hfree_bulk(rte_fastmem_handle_t handle,
+		void **ptrs, unsigned int n);
+
+/**
+ * Obtain the IOVA for a fastmem-allocated pointer.
+ *
+ * Translates a virtual address returned by a fastmem allocation
+ * function into the corresponding IOVA, suitable for use in device
+ * DMA descriptors.
+ *
+ * The returned IOVA is valid for the lifetime of the allocation.
+ *
+ * @p ptr must have been returned by a prior fastmem allocation
+ * function. Passing any other pointer results in undefined
+ * behavior.
+ *
+ * @param ptr
+ *  A pointer previously returned by a fastmem allocation
+ *  function.
+ *
+ * @return
+ *  The IOVA corresponding to @p ptr, or ``RTE_BAD_IOVA`` if the
+ *  library is not initialized (and could not be attached to).
+ */
+__rte_experimental
+rte_iova_t
+rte_fastmem_virt2iova(const void *ptr);
+
+/**
+ * Flush the calling lcore's per-lcore caches.
+ *
+ * Drains every cached object from the calling lcore's
+ * per-(size class, NUMA socket) caches back to their shared
+ * bins, and releases the cache state itself. A subsequent
+ * allocation or free on this lcore lazily recreates any caches
+ * it needs.
+ *
+ * This is useful in applications that have finished a bursty
+ * phase and want to release memory that would otherwise sit idle
+ * in caches. It is also useful in tests that want to observe
+ * bin-level state without per-lcore caching hiding activity.
+ *
+ * Only private per-lcore caches are flushed. The call has no
+ * effect when invoked from a thread that has no private cache (a
+ * lcore-less thread, or any thread in a secondary process); the
+ * shared cache is never flushed.
+ *
+ * This function is not thread-safe with respect to concurrent
+ * allocations or frees on the calling lcore; call it only when
+ * the calling lcore is not making other fastmem calls.
+ */
+__rte_experimental
+void
+rte_fastmem_cache_flush(void);
+
+/**
+ * Global summary statistics.
+ */
+struct rte_fastmem_stats {
+	uint64_t bytes_backing;  /**< Bytes of backing memory (memzones) reserved from EAL. */
+	uint64_t bytes_in_use;   /**< Approximate bytes in live objects. */
+	uint64_t alloc_total;    /**< Total successful alloc operations (hits + misses). */
+	uint64_t free_total;     /**< Total free operations (hits + misses). */
+	uint64_t alloc_nomem;    /**< Alloc attempts that failed with ENOMEM. */
+	unsigned int n_classes;  /**< Number of size classes. */
+};
+
+/**
+ * Per-size-class statistics (aggregated across all lcores).
+ *
+ * Allocation and free counters count individual objects, not
+ * operations. A bulk allocation of 32 objects that hits the cache
+ * increments alloc_cache_hits by 32.
+ */
+struct rte_fastmem_class_stats {
+	size_t class_size;             /**< Usable size of this class (bytes). */
+	uint64_t in_use;               /**< Objects currently live (allocs - frees). */
+	uint64_t alloc_cache_hits;     /**< Allocs served from a per-lcore cache. */
+	uint64_t alloc_cache_misses;   /**< Allocs that triggered a bin refill. */
+	uint64_t alloc_nomem;          /**< Alloc attempts that failed with ENOMEM. */
+	uint64_t free_cache_hits;      /**< Frees absorbed by a per-lcore cache. */
+	uint64_t free_cache_misses;    /**< Frees that triggered a bin drain. */
+	uint64_t slab_acquires;        /**< Slabs pulled from the free pool. */
+	uint64_t slab_releases;        /**< Slabs returned to the free pool. */
+	uint32_t slabs_partial;        /**< Current partial slab count. */
+	uint32_t slabs_full;           /**< Current full slab count. */
+};
+
+/**
+ * Per-lcore statistics (aggregated across all classes).
+ *
+ * Covers activity served through the lcore's private per-lcore
+ * cache, which exists only for lcore-id-equipped threads in the
+ * primary process. Allocations and frees made without a private
+ * cache (lcore-less threads, and any thread in a secondary
+ * process) are not attributed to any lcore and so do not appear
+ * here; they are visible in the global and per-class statistics,
+ * and in the shared-cache statistics retrieved with
+ * rte_fastmem_stats_shared().
+ *
+ * This structure is also used to report the shared cache; see
+ * rte_fastmem_stats_shared().
+ */
+struct rte_fastmem_lcore_stats {
+	uint64_t alloc_cache_hits;     /**< Allocs served from this lcore's caches. */
+	uint64_t alloc_cache_misses;   /**< Allocs that missed this lcore's caches. */
+	uint64_t alloc_nomem;          /**< Alloc attempts that failed with ENOMEM. */
+	uint64_t free_cache_hits;      /**< Frees absorbed by this lcore's caches. */
+	uint64_t free_cache_misses;    /**< Frees that bypassed this lcore's caches. */
+};
+
+/**
+ * Per-lcore, per-class statistics (no aggregation).
+ *
+ * Also used to report the shared cache for a single class; see
+ * rte_fastmem_stats_shared_class().
+ */
+struct rte_fastmem_lcore_class_stats {
+	size_t class_size;             /**< Usable size of this class (bytes). */
+	uint64_t alloc_cache_hits;     /**< Allocs served from cache. */
+	uint64_t alloc_cache_misses;   /**< Allocs that triggered a bin refill. */
+	uint64_t alloc_nomem;          /**< Alloc attempts that failed with ENOMEM. */
+	uint64_t free_cache_hits;      /**< Frees absorbed by cache. */
+	uint64_t free_cache_misses;    /**< Frees that triggered a bin drain. */
+};
+
+/**
+ * Get the number of size classes and optionally their sizes.
+ *
+ * @param[out] sizes
+ *   If non-NULL, filled with the size (in bytes) of each class.
+ *   The caller must provide space for at least the returned number
+ *   of entries.
+ *
+ * @return
+ *   The number of size classes.
+ */
+__rte_experimental
+unsigned int
+rte_fastmem_classes(size_t *sizes);
+
+/**
+ * Retrieve global summary statistics.
+ *
+ * @param[out] stats
+ *   Structure to fill.
+ *
+ * May be called from a secondary process, which lazily attaches to
+ * the shared state on first use.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats(struct rte_fastmem_stats *stats);
+
+/**
+ * Retrieve statistics for a single size class.
+ *
+ * @param class_size
+ *   Exact size of the class to query (must match one of the values
+ *   returned by rte_fastmem_classes()).
+ * @param[out] stats
+ *   Structure to fill.
+ *
+ * May be called from a secondary process, which lazily attaches to
+ * the shared state on first use.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, or @p class_size does not match any
+ *    size class.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_class(size_t class_size,
+		struct rte_fastmem_class_stats *stats);
+
+/**
+ * Retrieve per-lcore statistics (aggregated across all classes).
+ *
+ * @param lcore_id
+ *   The lcore to query.
+ * @param[out] stats
+ *   Structure to fill.
+ *
+ * May be called from a secondary process, which lazily attaches to
+ * the shared state on first use.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, or @p lcore_id is invalid.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_lcore(unsigned int lcore_id,
+		struct rte_fastmem_lcore_stats *stats);
+
+/**
+ * Retrieve per-lcore, per-class statistics.
+ *
+ * @param lcore_id
+ *   The lcore to query.
+ * @param class_size
+ *   Exact size of the class to query.
+ * @param[out] stats
+ *   Structure to fill.
+ *
+ * May be called from a secondary process, which lazily attaches to
+ * the shared state on first use.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, @p lcore_id is invalid, or
+ *    @p class_size does not match any size class.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_lcore_class(unsigned int lcore_id, size_t class_size,
+		struct rte_fastmem_lcore_class_stats *stats);
+
+/**
+ * Retrieve statistics for the shared cache (aggregated across all
+ * classes).
+ *
+ * The shared cache serves every caller without a private per-lcore
+ * cache: threads without an lcore id, and all threads in a
+ * secondary process (where private per-lcore caches are never
+ * used). Its activity is reported here rather than under any
+ * single lcore.
+ *
+ * @param[out] stats
+ *   Structure to fill. The per-lcore stats layout is reused.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_shared(struct rte_fastmem_lcore_stats *stats);
+
+/**
+ * Retrieve shared-cache statistics for a single size class.
+ *
+ * @param class_size
+ *   Exact size of the class to query.
+ * @param[out] stats
+ *   Structure to fill. The per-lcore-per-class stats layout is reused.
+ *
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, or @p class_size does not match any
+ *    size class.
+ *  - -ENODEV: fastmem is not initialized.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_shared_class(size_t class_size,
+		struct rte_fastmem_lcore_class_stats *stats);
+
+/**
+ * Reset all statistics counters to zero.
+ *
+ * Zeroes the per-lcore, shared-cache, and per-bin counters. Does
+ * not affect the allocator's operational state.
+ *
+ * For an accurate reset, call when no other threads are
+ * actively allocating or freeing.
+ */
+__rte_experimental
+void
+rte_fastmem_stats_reset(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_FASTMEM_H_ */
diff --git a/lib/meson.build b/lib/meson.build
index 8f5cfd28a5..10906d4d53 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -38,6 +38,7 @@ libraries = [
         'distributor',
         'dmadev',  # eventdev depends on this
         'efd',
+        'fastmem',
         'eventdev',
         'dispatcher', # dispatcher depends on eventdev
         'gpudev',
-- 
2.43.0

