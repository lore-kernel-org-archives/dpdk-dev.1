Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F69CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 10:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6AAD4042F;
	Mon, 25 May 2026 12:37:05 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 54E91402E5
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705423;
 bh=zvd4OfDUYTenJRS0KwV0JdOKMQkI/GzlH1hqvC+OH5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9fF4LS7g7eLwRZscprHW3smtmuKX01hKhxj66f1pp78FA8ahlupPvqI2F+it5vPu
 MrwMO5trkggDlf3G94zwcBhUJlrrOWcDcmxutCSuLzBeCM9gXFhdkYgcXD1SGyWYB6
 rUrmhXAvzOz5QPHgJ+aqnDwBrpaXekekUHZgIc7vE/SIxxG+PhXDri86MwA73WB/F+
 ZXGA9ObC1HMxXGC2DgZQ83gsF9z9BYNQGYA8LEVsNQ+fythHNcA6B/wXcXCHV3ItLg
 GHMbLTsSeDDNJ3Nj23sNPGYuHErYbIFlXdhFq7AhwQgSnWGB2IDDDB+Znc6KhdCMNX
 YoVL5yls7AlzA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id CC01519052
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705423;
 bh=zvd4OfDUYTenJRS0KwV0JdOKMQkI/GzlH1hqvC+OH5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9fF4LS7g7eLwRZscprHW3smtmuKX01hKhxj66f1pp78FA8ahlupPvqI2F+it5vPu
 MrwMO5trkggDlf3G94zwcBhUJlrrOWcDcmxutCSuLzBeCM9gXFhdkYgcXD1SGyWYB6
 rUrmhXAvzOz5QPHgJ+aqnDwBrpaXekekUHZgIc7vE/SIxxG+PhXDri86MwA73WB/F+
 ZXGA9ObC1HMxXGC2DgZQ83gsF9z9BYNQGYA8LEVsNQ+fythHNcA6B/wXcXCHV3ItLg
 GHMbLTsSeDDNJ3Nj23sNPGYuHErYbIFlXdhFq7AhwQgSnWGB2IDDDB+Znc6KhdCMNX
 YoVL5yls7AlzA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9B22119051; Mon, 25 May 2026 12:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705414;
 bh=zvd4OfDUYTenJRS0KwV0JdOKMQkI/GzlH1hqvC+OH5M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kz8/byr0dwlGEfHe4gJ6Htsd5v5c/q89G1WlPoTdJTTfcwvl9AYZJU9ijwXMdfag/
 v4zJzzANKz9JVELrwRbm19iCMDLMO9gUbC0kwS/rRGIAr7h3yJmXC+GMUx4CSk1vvH
 MztJnLxhErxZo5oAUXunulkzjyWW+A0l60KQ3LGLw94HWJTalOBfFjC244uJUH0aa/
 1DA0TnnCegpKeHcoTMYDH0piqsa1/VjV14QQXX6TE1+UdtsK3K+qKSJeVbmu+FDq1Z
 3k3KA3z0ndaY/2w+SOd27k3K/TUVlTC3AsX4q2nPnHYPsIZ+qDrFrqH62vYku+9Cdt
 ndGC13bmJ4fTw==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id AB59E19048;
 Mon, 25 May 2026 12:36:54 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC 1/3] doc: add fastmem programming guide
Date: Mon, 25 May 2026 12:36:40 +0200
Message-ID: <20260525103642.55255-2-hofors@lysator.liu.se>
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

Add a programming guide for the fastmem library covering usage,
API overview, design, and implementation details.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 doc/guides/prog_guide/fastmem_lib.rst | 301 ++++++++++++++++++++++++++
 doc/guides/prog_guide/index.rst       |   1 +
 2 files changed, 302 insertions(+)
 create mode 100644 doc/guides/prog_guide/fastmem_lib.rst

diff --git a/doc/guides/prog_guide/fastmem_lib.rst b/doc/guides/prog_guide/fastmem_lib.rst
new file mode 100644
index 0000000000..142408c3c2
--- /dev/null
+++ b/doc/guides/prog_guide/fastmem_lib.rst
@@ -0,0 +1,301 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Ericsson AB
+
+Fastmem Library
+===============
+
+The fastmem library is a fast, general-purpose small-object
+allocator for DPDK applications. It lets an application replace
+its many per-type mempools — each sized for a single object type
+— with a single allocator that handles arbitrary object sizes,
+grows on demand, and offers mempool-level performance for the
+common allocation and free paths.
+
+Like mempool, fastmem is backed by huge pages, is NUMA-aware,
+supports bulk operations, and uses per-lcore caches to reduce
+shared-state contention. Unlike mempool, it does not require the
+caller to declare object sizes or counts up front.
+
+
+When to use fastmem
+-------------------
+
+Use fastmem when:
+
+* Small objects (up to 1 MiB) are allocated and freed on the
+  data path with low, predictable latency requirements.
+
+* Many object types of varying sizes exist and maintaining a
+  separate mempool for each is impractical.
+
+* DMA-usable memory with efficient virtual-to-IOVA translation
+  is needed.
+
+Do not use fastmem for allocations larger than 1 MiB. Use
+``rte_malloc()`` instead.
+
+
+Initialization and teardown
+----------------------------
+
+.. code-block:: c
+
+   /* At startup, after rte_eal_init(). */
+   rte_fastmem_init();
+
+   /* Optional: pre-reserve backing memory to avoid latency
+    * spikes from on-demand memzone reservation. */
+   rte_fastmem_reserve(64 * 1024 * 1024, SOCKET_ID_ANY);
+
+   /* ... application runs ... */
+
+   /* At shutdown, after all allocations have been freed. */
+   rte_fastmem_deinit();
+
+Neither ``rte_fastmem_init()`` nor ``rte_fastmem_deinit()`` is
+thread-safe; call them from the main lcore during startup and
+shutdown.
+
+
+Allocation and free
+-------------------
+
+.. code-block:: c
+
+   void *obj = rte_fastmem_alloc(128, 0, 0);
+   /* Use obj... */
+   rte_fastmem_free(obj);
+
+``rte_fastmem_alloc()`` allocates on the calling lcore's NUMA
+socket. Use ``rte_fastmem_alloc_socket()`` to target a specific
+socket or to enable cross-socket fallback with ``SOCKET_ID_ANY``.
+
+Alignment
+~~~~~~~~~
+
+When ``align`` is 0, the returned pointer is aligned to at least
+``RTE_CACHE_LINE_SIZE``. A non-zero ``align`` must be a power of
+two. Specifying an alignment smaller than ``RTE_CACHE_LINE_SIZE``
+is permitted but the returned object may then share a cache line
+with an adjacent allocation, risking false sharing.
+
+Zeroing
+~~~~~~~
+
+Pass ``RTE_FASTMEM_F_ZERO`` to receive zero-initialized memory:
+
+.. code-block:: c
+
+   void *obj = rte_fastmem_alloc(256, 0, RTE_FASTMEM_F_ZERO);
+
+
+Bulk allocation and free
+-------------------------
+
+.. code-block:: c
+
+   void *ptrs[32];
+
+   if (rte_fastmem_alloc_bulk(ptrs, 32, 64, 0, 0) < 0)
+       /* handle error */;
+
+   /* Use objects... */
+
+   rte_fastmem_free_bulk(ptrs, 32);
+
+Bulk allocation has all-or-nothing semantics: either all
+requested objects are returned, or none are (and ``rte_errno``
+is set to ``ENOMEM``).
+
+Bulk free is most efficient when all objects belong to the same
+size class; in that case the objects are pushed into the
+per-lcore cache in a single operation.
+
+
+IOVA translation
+----------------
+
+Memory returned by fastmem is DMA-usable. To obtain the IOVA
+for use in device descriptors:
+
+.. code-block:: c
+
+   rte_iova_t iova = rte_fastmem_virt2iova(obj);
+
+The translation is O(1). The returned IOVA is valid for the
+lifetime of the allocation.
+
+
+NUMA awareness
+--------------
+
+``rte_fastmem_alloc()`` allocates on the calling lcore's socket.
+``rte_fastmem_alloc_socket()`` accepts an explicit socket ID or
+``SOCKET_ID_ANY``:
+
+* Explicit socket: allocate only from that socket; fail with
+  ``ENOMEM`` if exhausted.
+
+* ``SOCKET_ID_ANY``: try the caller's local socket first, then
+  fall back to other sockets.
+
+
+Per-lcore caches
+----------------
+
+Each EAL thread has a private cache per size class. The common
+allocation and free paths operate entirely within this cache,
+avoiding locks. Cache misses (empty on alloc, full on free)
+trigger a bulk transfer to/from the shared bin under a lock.
+
+Non-EAL threads bypass the cache and take the bin lock on every
+operation.
+
+``rte_fastmem_cache_flush()`` drains the calling lcore's caches
+back to the shared bins. This is useful after bursty phases to
+release idle cached memory.
+
+
+Threading
+---------
+
+All allocation and free functions are thread-safe and may be
+called from any thread. An allocation made on one thread may be
+freed on any other.
+
+Fastmem uses internal spinlocks. A thread preempted while
+holding one delays other threads contending for the same lock
+(correctness is not affected, only latency).
+
+
+Pre-reserving memory
+--------------------
+
+By default, fastmem reserves backing memory lazily on first
+allocation. ``rte_fastmem_reserve(size, socket_id)`` forces
+reservation up front, ensuring subsequent allocations do not
+incur memzone-reservation latency:
+
+.. code-block:: c
+
+   /* Reserve 128 MiB on socket 0. */
+   rte_fastmem_reserve(128 * 1024 * 1024, 0);
+
+Once reserved, backing memory is never returned to the system
+during the allocator's lifetime.
+
+Memory limits
+~~~~~~~~~~~~~
+
+``rte_fastmem_set_limit(socket_id, max_bytes)`` caps how much
+backing memory may be reserved on a given socket. Once the limit is
+reached, allocations that would require new backing memory fail with
+``ENOMEM``. The default is ``SIZE_MAX`` (unlimited).
+``rte_fastmem_get_limit()`` returns the current limit for a socket.
+
+.. code-block:: c
+
+   /* Allow at most 256 MiB on socket 0. */
+   rte_fastmem_set_limit(0, 256 * 1024 * 1024);
+
+   /* Block all growth on socket 1. */
+   rte_fastmem_set_limit(1, 0);
+
+Pass ``SOCKET_ID_ANY`` to apply the same limit to all sockets.
+
+
+Size classes
+------------
+
+Fastmem uses power-of-two size classes from 8 bytes to 1 MiB
+(18 classes). A request for N bytes is served from the smallest
+class >= N. The maximum supported size is queryable via
+``rte_fastmem_max_size()``.
+
+With power-of-two classes, worst-case internal fragmentation is
+just under 50% (e.g., a 33-byte request occupies a 64-byte
+slot). Assuming a uniform distribution of request sizes, the
+average waste is 25%. In practice, DPDK workloads tend to
+cluster at or near powers of two, so typical waste is lower.
+
+Requests exceeding the maximum are rejected with ``E2BIG``.
+
+
+Implementation
+--------------
+
+Fastmem organizes memory in three layers: backing memzones, slabs,
+and per-lcore caches.
+
+Backing memory and slabs
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Backing memory is obtained from EAL as 128 MiB IOVA-contiguous
+memzones, each aligned to 2 MiB. A memzone is partitioned into
+64 fixed-size, 2 MiB **slabs**. Slabs are the unit of memory
+that moves between size classes: a free slab can be assigned to
+any bin on demand, and an empty slab (all objects freed) returns
+to the free-slab pool for reuse by another size class.
+
+The 2 MiB slab alignment is the key structural property. Given
+any object pointer, the allocator recovers the owning slab by
+masking off the low 21 bits — no radix tree, hash table, or
+memzone lookup is needed. This makes the free path fast: a
+single pointer-mask load reaches the slab header, which
+identifies the size class and bin.
+
+Each slab reserves 64 bytes at offset 0 for its header. The
+remaining space is divided into fixed-size slots equal to the
+size class. Allocated objects carry no per-object metadata; the
+full slot is available to the caller.
+
+Three-level allocation hierarchy
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. **Per-lcore cache** — a bounded LIFO stack of free object
+   pointers, one per (lcore, size class, socket). Allocation
+   pops; free pushes. No lock is needed because only the owning
+   lcore accesses its cache.
+
+2. **Bin** — one per (size class, socket). Owns the partial and
+   full slab lists. A spinlock serializes bulk transfers between
+   the bin and per-lcore caches. Most traffic is absorbed by the
+   caches, so bin-lock contention is low.
+
+3. **Free-slab pool** — one per socket. A spinlock protects slab
+   acquisition and release. These events are rare relative to
+   object-level operations (a single small-object slab serves
+   thousands of allocations).
+
+On a cache miss (empty on alloc, full on free), the cache
+exchanges objects with the bin in bulk, targeting half-full to
+maximize headroom in both directions.
+
+Cache sizing
+~~~~~~~~~~~~
+
+Cache capacity varies by size class to bound per-lcore memory
+footprint:
+
+* Classes 8 B through 4 KiB: capacity 64.
+* Larger classes: capacity halves per class (32, 16, 8, 4),
+  flooring at 4.
+
+Even the largest classes remain cached. The capacity curve
+ensures that small, frequent allocations get the highest cache
+hit rate, while large allocations still avoid the bin lock on
+most operations.
+
+
+Statistics
+----------
+
+Fastmem maintains always-on, per-lcore counters that track
+allocation and free activity. Statistics are queryable at four
+levels of granularity: global summary, per size class, per lcore,
+and per lcore per class.
+
+``rte_fastmem_classes()`` returns the number of size classes and
+optionally fills an array with their sizes.
+
+See ``rte_fastmem.h`` for the full statistics API.
\ No newline at end of file
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index e6f24945b0..c85196c85e 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -28,6 +28,7 @@ Memory Management
     mempool_lib
     mbuf_lib
     multi_proc_support
+    fastmem_lib
 
 
 CPU Management
-- 
2.43.0

