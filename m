Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D57ECD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 10:37:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D886402F2;
	Mon, 25 May 2026 12:37:10 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id B75A5402EE
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705429;
 bh=pmer2y1PWOYxObidaJoPNb9g37zaS8Gu54NhAHvJULs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hxe/nRc3L8afpa6E4d/jAFC1XXlOkb24svTwJ4ORoYqivoPph5ydMHlUjqb2WiqkA
 SDRaUtLGO6WnnltoZc/yhOUcGPU1wR+IuMW1MGDxlD0CvIQDDS7wd2pLl/NCn4sZhx
 yHvngSBeu10GbV1aZY/V7J4QyaxrJGJ98Cfze/pwyAX+iPIWsBATNLa4eDgoE/x/lM
 XeMf2iBQyw560LCJLCX2V8XeMhHoOAB/YdVi87V1s5t1v1hYrIqZvCr5ob4DA7JZgD
 hRYb5h9rDN5dBzhPRalyj33go77i1EsG9KQDueJQ8Ls3RiDCCVaxuFSGTB8+iDYB7E
 yjXstVvEsm1lw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 52B231905C
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705429;
 bh=pmer2y1PWOYxObidaJoPNb9g37zaS8Gu54NhAHvJULs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Hxe/nRc3L8afpa6E4d/jAFC1XXlOkb24svTwJ4ORoYqivoPph5ydMHlUjqb2WiqkA
 SDRaUtLGO6WnnltoZc/yhOUcGPU1wR+IuMW1MGDxlD0CvIQDDS7wd2pLl/NCn4sZhx
 yHvngSBeu10GbV1aZY/V7J4QyaxrJGJ98Cfze/pwyAX+iPIWsBATNLa4eDgoE/x/lM
 XeMf2iBQyw560LCJLCX2V8XeMhHoOAB/YdVi87V1s5t1v1hYrIqZvCr5ob4DA7JZgD
 hRYb5h9rDN5dBzhPRalyj33go77i1EsG9KQDueJQ8Ls3RiDCCVaxuFSGTB8+iDYB7E
 yjXstVvEsm1lw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 364CD1905B; Mon, 25 May 2026 12:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705415;
 bh=pmer2y1PWOYxObidaJoPNb9g37zaS8Gu54NhAHvJULs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H872qAQmI0k4X91XJVvebeHBL5isi2ZnD7LMdFdgHFcCbtG1BuWrymFXH66GKeBhD
 b60F9Q4hwlLSFxAmM3pVbfxcyVNUIvPW4ASURcGRBgJstTFG8CfzMC6IYn2+WMCkZJ
 yl6p8JXYc5fU0+4/bEIi1A976fyv5LVPVq1QYCIrUKCT+jNhGXWFlYlHXtgv8FY7ix
 R4FVlh/Y10z1NuMZBgvk3FADppJqqdiPPAw1XmhBD7zdftrJF7dvT62hjhpcn2ZVaZ
 Np5+KKJeDuPWrpgHiTlvC3yfj8PqTbMykIF0low8ZJii29S9O9voxn5d6loJn2l+K4
 i4kDJ26BB7UMA==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id E7BB819126;
 Mon, 25 May 2026 12:36:54 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC 2/3] lib: add fastmem library
Date: Mon, 25 May 2026 12:36:41 +0200
Message-ID: <20260525103642.55255-3-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525103642.55255-1-hofors@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

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

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 doc/api/doxy-api-index.md |    1 +
 doc/api/doxy-api.conf.in  |    1 +
 lib/fastmem/meson.build   |    6 +
 lib/fastmem/rte_fastmem.c | 1486 +++++++++++++++++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h |  644 ++++++++++++++++
 lib/meson.build           |    1 +
 6 files changed, 2139 insertions(+)
 create mode 100644 lib/fastmem/meson.build
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
diff --git a/lib/fastmem/rte_fastmem.c b/lib/fastmem/rte_fastmem.c
new file mode 100644
index 0000000000..f605c538fc
--- /dev/null
+++ b/lib/fastmem/rte_fastmem.c
@@ -0,0 +1,1486 @@
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
+#include <rte_common.h>
+#include <rte_debug.h>
+#include <eal_export.h>
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
+};
+
+/* Per-(lcore, class, socket) bounded LIFO of free object pointers. */
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
+};
+
+struct fastmem {
+	struct fastmem_socket_state sockets[RTE_MAX_NUMA_NODES];
+};
+
+static struct fastmem *fastmem;
+static const struct rte_memzone *fastmem_mz;
+
+static inline unsigned int
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
+static inline size_t
+class_size(unsigned int class_idx)
+{
+	return (size_t)1 << (class_idx + FASTMEM_MIN_CLASS_LOG2);
+}
+
+static_assert(sizeof(struct fastmem_slab) == FASTMEM_SLAB_HEADER_SIZE,
+	"fastmem slab header must fit in exactly one cache line");
+static_assert(sizeof(struct fastmem_slab) <= FASTMEM_SLAB_SIZE,
+	"slab header larger than a slab makes no sense");
+
+static __rte_always_inline struct fastmem_slab *
+slab_of(void *obj)
+{
+	return (struct fastmem_slab *)
+		((uintptr_t)obj & ~(uintptr_t)FASTMEM_SLAB_MASK);
+}
+
+static inline size_t
+slab_slot0_offset(size_t class_size)
+{
+	return class_size < FASTMEM_SLAB_HEADER_SIZE ?
+		FASTMEM_SLAB_HEADER_SIZE : class_size;
+}
+
+static inline uint32_t
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
+ * The lock may be dropped and re-acquired internally.
+ */
+static int
+bin_ensure_partial_locked(struct fastmem_bin *bin,
+		struct fastmem_socket_state *socket)
+{
+	struct fastmem_slab *slab;
+
+	if (TAILQ_FIRST(&bin->partial) != NULL)
+		return 0;
+
+	rte_spinlock_unlock(&bin->lock);
+
+	slab = slab_acquire(socket, bin->socket_id);
+	if (slab == NULL) {
+		rte_spinlock_lock(&bin->lock);
+		return -ENOMEM;
+	}
+
+	rte_spinlock_lock(&bin->lock);
+
+	/* Another thread may have added a partial slab meanwhile. */
+	if (TAILQ_FIRST(&bin->partial) != NULL) {
+		rte_spinlock_unlock(&bin->lock);
+		slab_release(socket, slab);
+		rte_spinlock_lock(&bin->lock);
+		return 0;
+	}
+
+	slab_init(bin, slab);
+	TAILQ_INSERT_HEAD(&bin->partial, slab, list);
+	bin->slabs_partial++;
+	bin->slab_acquires++;
+
+	return 0;
+}
+
+static void *
+bin_alloc_one(struct fastmem_bin *bin)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[bin->socket_id];
+	void *obj;
+
+	rte_spinlock_lock(&bin->lock);
+
+	while (bin_pop_locked(bin, &obj, 1) == 0) {
+		int rc = bin_ensure_partial_locked(bin, socket);
+
+		if (rc < 0) {
+			rte_spinlock_unlock(&bin->lock);
+			rte_errno = -rc;
+			return NULL;
+		}
+	}
+
+	rte_spinlock_unlock(&bin->lock);
+
+	return obj;
+}
+
+static unsigned int
+bin_alloc_bulk(struct fastmem_bin *bin, void **objs, unsigned int n)
+{
+	struct fastmem_socket_state *socket = &fastmem->sockets[bin->socket_id];
+	unsigned int got = 0;
+
+	rte_spinlock_lock(&bin->lock);
+
+	while (got < n) {
+		got += bin_pop_locked(bin, objs + got, n - got);
+		if (got == n)
+			break;
+
+		if (bin_ensure_partial_locked(bin, socket) < 0)
+			break;
+	}
+
+	rte_spinlock_unlock(&bin->lock);
+
+	return got;
+}
+
+static void
+bin_free_one(struct fastmem_bin *bin, void *obj)
+{
+	unsigned int n_release;
+	struct fastmem_slab *slab_to_release = NULL;
+	struct fastmem_socket_state *socket;
+
+	rte_spinlock_lock(&bin->lock);
+	n_release = bin_push_locked(bin, &obj, 1, &slab_to_release);
+	rte_spinlock_unlock(&bin->lock);
+
+	if (n_release > 0) {
+		socket = &fastmem->sockets[bin->socket_id];
+		slab_release(socket, slab_to_release);
+	}
+}
+
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
+static inline unsigned int
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
+static inline struct fastmem_cache **
+cache_slot(struct fastmem_socket_state *socket, unsigned int class_idx,
+		unsigned int lcore_id)
+{
+	if (lcore_id >= RTE_MAX_LCORE)
+		return NULL;
+	return &socket->caches[lcore_id][class_idx];
+}
+
+static struct fastmem_cache *
+cache_create(struct fastmem_socket_state *socket,
+		unsigned int class_idx, unsigned int lcore_id)
+{
+	struct fastmem_cache **slot = cache_slot(socket, class_idx, lcore_id);
+	struct fastmem_cache *cache;
+	unsigned int capacity;
+	size_t cache_size;
+
+	if (slot == NULL)
+		return NULL;
+
+	cache = *slot;
+	if (cache != NULL)
+		return cache;
+
+	capacity = cache_capacity(class_idx);
+	cache_size = sizeof(*cache) + capacity * sizeof(void *);
+
+	/*
+	 * Allocate the cache struct from fastmem on the calling
+	 * lcore's socket (NUMA-local to the writer). Bypasses the
+	 * cache layer to avoid recursion.
+	 */
+	{
+		unsigned int cache_class =
+			size_to_class(cache_size, RTE_CACHE_LINE_SIZE);
+		unsigned int own_socket = rte_socket_id();
+		struct fastmem_socket_state *alloc_socket;
+
+		if (cache_class >= FASTMEM_N_CLASSES) {
+			FASTMEM_LOG(ERR,
+				"cache size %zu exceeds max size class",
+				cache_size);
+			return NULL;
+		}
+
+		if (own_socket >= RTE_MAX_NUMA_NODES)
+			own_socket = (unsigned int)socket->bins[0].socket_id;
+
+		alloc_socket = &fastmem->sockets[own_socket];
+
+		cache = bin_alloc_one(&alloc_socket->bins[cache_class]);
+		if (cache == NULL) {
+			FASTMEM_LOG(ERR,
+				"failed to allocate cache for class %u on socket %u",
+				class_idx, own_socket);
+			return NULL;
+		}
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
+	*slot = cache;
+
+	return cache;
+}
+
+static __rte_always_inline struct fastmem_cache *
+cache_get(struct fastmem_socket_state *socket, unsigned int class_idx,
+		unsigned int lcore_id)
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
+	return cache_create(socket, class_idx, lcore_id);
+}
+
+static __rte_always_inline void *
+cache_pop(struct fastmem_cache *cache, struct fastmem_bin *bin)
+{
+	if (cache->count > 0) {
+		cache->alloc_cache_hits++;
+		return cache->objs[--cache->count];
+	}
+
+	cache->count = bin_alloc_bulk(bin, cache->objs, cache->target);
+	if (cache->count == 0)
+		return NULL;
+
+	cache->alloc_cache_misses++;
+	return cache->objs[--cache->count];
+}
+
+static __rte_always_inline void
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
+	 * Drain the oldest (bottom) half to the bin, keeping the
+	 * newest (top) half for temporal reuse.
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
+			bin_free_one(cache_slab->bin, cache);
+
+			socket->caches[lcore][c] = NULL;
+		}
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_init, 25.07)
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
+	memset(fastmem, 0, sizeof(*fastmem));
+
+	for (s = 0; s < RTE_MAX_NUMA_NODES; s++) {
+		struct fastmem_socket_state *socket = &fastmem->sockets[s];
+
+		rte_spinlock_init(&socket->lock);
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
+release_socket(struct fastmem_socket_state *socket)
+{
+	unsigned int c;
+	unsigned int i;
+
+	socket_release_caches(socket);
+
+	for (c = 0; c < FASTMEM_N_CLASSES; c++)
+		bin_release(&socket->bins[c], socket);
+
+	for (i = 0; i < socket->n_memzones; i++)
+		rte_memzone_free(socket->memzones[i]);
+
+	socket->free_head = NULL;
+	socket->reserved_bytes = 0;
+	socket->n_memzones = 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_deinit, 25.07)
+void
+rte_fastmem_deinit(void)
+{
+	unsigned int i;
+
+	if (fastmem == NULL)
+		return;
+
+	for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
+		release_socket(&fastmem->sockets[i]);
+
+	rte_memzone_free(fastmem_mz);
+	fastmem_mz = NULL;
+	fastmem = NULL;
+}
+
+/* Same resolution order as rte_malloc's malloc_get_numa_socket(). */
+static __rte_always_inline unsigned int
+local_socket_id(void)
+{
+	unsigned int sid = rte_socket_id();
+
+	if (likely(sid < RTE_MAX_NUMA_NODES))
+		return sid;
+
+	sid = rte_lcore_to_socket_id(rte_get_main_lcore());
+	if (likely(sid < RTE_MAX_NUMA_NODES))
+		return sid;
+
+	return (unsigned int)rte_socket_id_by_idx(0);
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_reserve, 25.07)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_set_limit, 25.07)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_get_limit, 25.07)
+size_t
+rte_fastmem_get_limit(int socket_id)
+{
+	if (fastmem == NULL || socket_id < 0 || socket_id >= RTE_MAX_NUMA_NODES)
+		return 0;
+
+	return fastmem->sockets[socket_id].memory_limit;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_max_size, 25.07)
+size_t
+rte_fastmem_max_size(void)
+{
+	return FASTMEM_MAX_ALLOC_SIZE;
+}
+
+static __rte_always_inline void *
+alloc_from_socket(struct fastmem_socket_state *socket,
+		unsigned int class_idx, unsigned int lcore_id)
+{
+	struct fastmem_cache *cache;
+
+	cache = cache_get(socket, class_idx, lcore_id);
+	if (likely(cache != NULL))
+		return cache_pop(cache, &socket->bins[class_idx]);
+	return bin_alloc_one(&socket->bins[class_idx]);
+}
+
+static __rte_always_inline void
+do_free(void *ptr)
+{
+	struct fastmem_slab *slab;
+	struct fastmem_bin *bin;
+	struct fastmem_socket_state *socket;
+	unsigned int lcore_id;
+	struct fastmem_cache *cache;
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
+		bin_free_one(bin, ptr);
+}
+
+static __rte_always_inline int
+do_alloc_bulk(void **ptrs, unsigned int n, size_t size, size_t align,
+		unsigned int flags, unsigned int lcore_id,
+		int socket_id, bool fallback)
+{
+	unsigned int class_idx;
+	struct fastmem_socket_state *socket;
+	struct fastmem_cache *cache;
+	unsigned int got = 0;
+
+	RTE_ASSERT(fastmem != NULL);
+
+	if (align == 0)
+		align = RTE_CACHE_LINE_SIZE;
+	else if (unlikely((align & (align - 1)) != 0)) {
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
+					cache->objs, want);
+				if (filled > 0) {
+					cache->alloc_cache_misses += RTE_MIN(filled, need);
+				}
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
+				/* n exceeds cache capacity; pull directly. */
+				unsigned int direct = bin_alloc_bulk(
+					&socket->bins[class_idx],
+					ptrs + got, need);
+				if (direct > 0)
+					cache->alloc_cache_misses += direct;
+				got += direct;
+			}
+		}
+	} else {
+		got = bin_alloc_bulk(&socket->bins[class_idx], ptrs, n);
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
+				unsigned int direct = bin_alloc_bulk(
+					&socket->bins[class_idx],
+					ptrs + got, n - got);
+				if (direct > 0 && cache != NULL)
+					cache->alloc_cache_misses += direct;
+				got += direct;
+			}
+		}
+	}
+
+	if (unlikely(got < n)) {
+		/* All-or-nothing: return what we got. */
+		struct fastmem_cache **slot;
+		unsigned int i;
+
+		for (i = 0; i < got; i++)
+			do_free(ptrs[i]);
+
+		slot = cache_slot(
+			&fastmem->sockets[socket_id], class_idx,
+			lcore_id);
+		if (slot != NULL && *slot != NULL)
+			(*slot)->alloc_nomem++;
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
+static __rte_always_inline void *
+do_alloc(size_t size, size_t align, unsigned int flags,
+		unsigned int lcore_id, int socket_id, bool fallback)
+{
+	unsigned int class_idx;
+	struct fastmem_cache **slot;
+	void *obj;
+
+	RTE_ASSERT(fastmem != NULL);
+
+	if (align == 0)
+		align = RTE_CACHE_LINE_SIZE;
+	else if (unlikely((align & (align - 1)) != 0)) {
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
+	slot = cache_slot(
+		&fastmem->sockets[socket_id], class_idx, lcore_id);
+	if (slot != NULL && *slot != NULL)
+		(*slot)->alloc_nomem++;
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
+void *
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc, 25.07)
+rte_fastmem_alloc(size_t size, size_t align, unsigned int flags)
+{
+	return do_alloc(size, align, flags, rte_lcore_id(),
+			local_socket_id(), false);
+}
+
+void *
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_socket, 25.07)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_free, 25.07)
+void
+rte_fastmem_free(void *ptr)
+{
+	if (unlikely(ptr == NULL))
+		return;
+
+	do_free(ptr);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_bulk, 25.07)
+int
+rte_fastmem_alloc_bulk(void **ptrs, unsigned int n, size_t size, size_t align,
+		unsigned int flags)
+{
+	return do_alloc_bulk(ptrs, n, size, align, flags,
+			rte_lcore_id(), local_socket_id(), false);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_alloc_bulk_socket, 25.07)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_free_bulk, 25.07)
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
+		for (i = 1; i < n; i++) {
+			if (slab_of(ptrs[i])->bin != bin)
+				goto slow;
+		}
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
+		for (i = 1; i < n; i++) {
+			if (slab_of(ptrs[i])->bin != bin)
+				goto slow;
+		}
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_virt2iova, 25.07)
+rte_iova_t
+rte_fastmem_virt2iova(const void *ptr)
+{
+	struct fastmem_slab *slab;
+
+	RTE_ASSERT(fastmem != NULL);
+
+	slab = slab_of((void *)(uintptr_t)ptr);
+
+	return slab->iova_base + ((uintptr_t)ptr - (uintptr_t)slab);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_cache_flush, 25.07)
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
+			bin_free_one(cache_slab->bin, cache);
+
+			socket->caches[lcore_id][c] = NULL;
+		}
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats, 25.07)
+int
+rte_fastmem_stats(struct rte_fastmem_stats *stats)
+{
+	if (stats == NULL || fastmem == NULL)
+		return -EINVAL;
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
+			uint64_t class_allocs = 0, class_frees = 0;
+
+			for (unsigned int l = 0; l < RTE_MAX_LCORE; l++) {
+				struct fastmem_cache *cache =
+					socket->caches[l][c];
+				if (cache == NULL)
+					continue;
+				class_allocs += cache->alloc_cache_hits +
+					cache->alloc_cache_misses;
+				class_frees += cache->free_cache_hits +
+					cache->free_cache_misses;
+				stats->alloc_nomem += cache->alloc_nomem;
+			}
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
+static inline unsigned int
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_class, 25.07)
+int
+rte_fastmem_stats_class(size_t class_size_arg,
+		struct rte_fastmem_class_stats *stats)
+{
+	unsigned int c;
+	uint64_t allocs, frees;
+
+	if (stats == NULL || fastmem == NULL)
+		return -EINVAL;
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
+			if (cache == NULL)
+				continue;
+			stats->alloc_cache_hits += cache->alloc_cache_hits;
+			stats->alloc_cache_misses += cache->alloc_cache_misses;
+			stats->alloc_nomem += cache->alloc_nomem;
+			stats->free_cache_hits += cache->free_cache_hits;
+			stats->free_cache_misses += cache->free_cache_misses;
+		}
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_lcore, 25.07)
+int
+rte_fastmem_stats_lcore(unsigned int lcore_id,
+		struct rte_fastmem_lcore_stats *stats)
+{
+	if (stats == NULL || fastmem == NULL)
+		return -EINVAL;
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
+			if (cache == NULL)
+				continue;
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_lcore_class, 25.07)
+int
+rte_fastmem_stats_lcore_class(unsigned int lcore_id, size_t class_size_arg,
+		struct rte_fastmem_lcore_class_stats *stats)
+{
+	unsigned int c;
+
+	if (stats == NULL || fastmem == NULL)
+		return -EINVAL;
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
+		if (cache == NULL)
+			continue;
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_stats_reset, 25.07)
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
+			bin->slab_acquires = 0;
+			bin->slab_releases = 0;
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
+		}
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fastmem_classes, 25.07)
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
index 0000000000..cd1abf9844
--- /dev/null
+++ b/lib/fastmem/rte_fastmem.h
@@ -0,0 +1,644 @@
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
+ * Threads and per-lcore caches:
+ *   Allocate and free calls from EAL threads are served through a
+ *   per-lcore cache, which makes the common path lock-free.
+ *   Unregistered non-EAL threads do not use a cache; their
+ *   allocate and free calls go directly to shared state, take an
+ *   internal lock, and cost more per call.
+ *
+ * Non-preemptible caller:
+ *   Callers should not be preemptible while inside a fastmem call.
+ *   Fastmem uses internal spinlocks; if a caller is preempted
+ *   while holding one, any other thread that subsequently needs
+ *   the same lock stalls until the preempted caller resumes.
+ */
+
+#include <stddef.h>
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
+	__rte_alloc_size(1) __rte_alloc_align(2);
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
+	__rte_alloc_size(1) __rte_alloc_align(2);
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
+ *  The IOVA corresponding to @p ptr.
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
+ * The call has no effect when invoked from a non-EAL thread.
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
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL or fastmem is not initialized.
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
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, fastmem is not initialized, or
+ *    @p class_size does not match any size class.
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
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, fastmem is not initialized, or
+ *    @p lcore_id is invalid.
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
+ * @return
+ *  - 0: Success.
+ *  - -EINVAL: @p stats is NULL, fastmem is not initialized,
+ *    @p lcore_id is invalid, or @p class_size does not match any
+ *    size class.
+ */
+__rte_experimental
+int
+rte_fastmem_stats_lcore_class(unsigned int lcore_id, size_t class_size,
+		struct rte_fastmem_lcore_class_stats *stats);
+
+/**
+ * Reset all statistics counters to zero.
+ *
+ * Zeroes per-lcore cache counters and per-bin counters. Does not
+ * affect the allocator's operational state.
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
index 8f5cfd28a5..98ec28a901 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -40,6 +40,7 @@ libraries = [
         'efd',
         'eventdev',
         'dispatcher', # dispatcher depends on eventdev
+        'fastmem',
         'gpudev',
         'gro',
         'gso',
-- 
2.43.0

