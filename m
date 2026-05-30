Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFFCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 09:26:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0C664028C;
	Sat, 30 May 2026 11:26:44 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id B56354027F
 for <dev@dpdk.org>; Sat, 30 May 2026 11:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133203;
 bh=e2G2Ii8q6zv5ja3W7573D3IITBdo+ooH74ksuRbubcU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RimptVt+rQmp1xlNmNMkniTGVEQ72+oll4hodqjq7PERJ6JaHAHQBtGpnluW1iAKA
 kcbq1v6SCIcQv+2O8DhS+FEgsxbbsJvKiy+Hj8z9BlSES+l93v2iesgEbWIkE9HZBj
 TsLaUVVKtdALgioD7cEcdGrXm7gr7tQ+Ub60QllD/YY7IA3zLRUK8rICEUGhoY3P87
 IjIkZwH66TjOdLlQF1HLhAkvqtIFUjnjuRsGOIkdNz+asLDcc2hfU6BUDp9xWruUxX
 w4Hdxo4FeVHNbdflnQd+q0G4xkRhTVS8HIYvQyzSS3iF+/k05nCcrvcJV3PVBgTk8B
 hlVMRwFOeLu+w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 0C9D5EAB7
 for <dev@dpdk.org>; Sat, 30 May 2026 11:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133202;
 bh=e2G2Ii8q6zv5ja3W7573D3IITBdo+ooH74ksuRbubcU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=he2oUTuwmhYJmDi5ZssBmhd6KJqKEyiiQOiRmxO376Aj/s6mJTMlvGDY2+yiVWnas
 tYJPJubE22Q6JkQjLaX+iRGeIFBSVgmlKlZiv5IM1a9aqzUjOFg/xHdXCv6zYcvxN7
 Wa2fMAAGBJT+oH2JaVsx7uGO3hASK9pUJ9cpPRS4woCCsAQ+gILJqTY4M0f30cXK00
 e4OSJRRMSlvUydxKvvoUlB9ev03OTqIXqMZKi/EkMk+WroYx1ANGdCM2oUgaHyAqwU
 zWoJIR1J2hOPWE95e0uoy14w2RbAruIijQuxocd+joDQlJ6f3u0aviCwi301D/W1BK
 p7q9F2keeQv5g==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id E2BD1EB0C; Sat, 30 May 2026 11:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1780133197;
 bh=e2G2Ii8q6zv5ja3W7573D3IITBdo+ooH74ksuRbubcU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hX9arJMbvNwl9tQnW8jdKAiWUzKLLY6T29MjRV/MYDiLUbR954Pq59Alc3oEIIsOB
 ZUdp2h4SGcI7KP3Jxbr21VtppATtqyHKliIB3cAL5+htGl3zc1N2xfs+LT6gSDNlTm
 zUsmd+AfZLN4iL5LJRyj7m0+9X9OwxzQDa1+ROpq2ryjADWrktFG89OZ+ODnBhHVZZ
 d6MiPaX1hr3e9bxwHF8LJ6aZQ9dkZ5e3nkKliMSWFRJRh1TFQz0Vh4P4877Z8csU/3
 0uwgJZZX1gTLsCxV8sD78UBi8naxN8tQMyhKScyMOfzra9fwXX5eOvvt28WoCeOSVj
 V0jwo1z2/Rmcw==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id C8550EA7D;
 Sat, 30 May 2026 11:26:36 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC v4 0/3] lib/fastmem: fast small-object allocator
Date: Sat, 30 May 2026 11:26:31 +0200
Message-ID: <20260530092634.46218-1-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527173042.93867-2-hofors@lysator.liu.se>
References: <20260527173042.93867-2-hofors@lysator.liu.se>
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

This RFC introduces fastmem, a general-purpose small-object allocator
for DPDK. It is intended to replace per-type mempools with a single
allocator that handles arbitrary sizes, grows on demand, and matches
mempool-level performance on the hot path.

Motivation
----------

DPDK applications commonly maintain many mempools — one per object
type (connections, sessions, timers, work items). Each must be sized
up front, wastes memory when over-provisioned, and cannot serve
objects of a different size. Fastmem eliminates this by accepting
arbitrary sizes at runtime, backed by a slab allocator that
repurposes memory across size classes as demand shifts.

Design
------

Three-layer architecture:

1. Backing memory: 128 MiB IOVA-contiguous memzones from EAL,
   reserved lazily (or pre-reserved for deterministic latency).

2. Slabs: 2 MiB, 2 MiB-aligned regions carved from memzones.
   The alignment enables O(1) slab lookup from any object pointer
   via bitmask — no radix tree or index structure. Slabs move
   freely between 18 power-of-2 size classes (8 B to 1 MiB).

3. Per-lcore caches: bounded LIFO stacks (no locks on the hot
   path). Cache misses trigger bulk transfers to/from the shared
   bin under a spinlock.

Key properties:

- Zero per-object metadata in the production build.
- NUMA-aware, with per-socket bins and free-slab pools.
- DMA-usable memory with O(1) virt-to-IOVA translation.
- Bulk alloc/free with all-or-nothing semantics.
- Backing memory never returned during lifetime (slabs recycled).
- Non-EAL threads supported (bypass cache, take bin lock).
- Secondary process support (lazy attach, no per-lcore caches).

API surface
-----------

  rte_fastmem_init / deinit
  rte_fastmem_reserve
  rte_fastmem_set_limit / get_limit
  rte_fastmem_alloc / alloc_socket
  rte_fastmem_realloc
  rte_fastmem_alloc_bulk / alloc_bulk_socket
  rte_fastmem_free / free_bulk
  rte_fastmem_hlookup / halloc / halloc_bulk / hfree / hfree_bulk
  rte_fastmem_virt2iova
  rte_fastmem_cache_flush
  rte_fastmem_max_size / classes
  rte_fastmem_stats / stats_class / stats_lcore / stats_lcore_class
  rte_fastmem_stats_reset

All APIs are marked __rte_experimental.

Performance
-----------

The single-object hot path is roughly 2–3× the cost of mempool
and an order of magnitude faster than rte_malloc. Under
multi-lcore contention, fastmem scales similarly to mempool,
while rte_malloc collapses.

Limitations
-----------

- Maximum allocation: 1 MiB. Larger requests should use rte_malloc.
- Power-of-2 classes only; worst-case internal fragmentation ~50%.
- Backing memory not reclaimable short of deinit.

Future work
-----------

- Lcore-affine allocations (false-sharing-free by construction).
- Mempool ops driver for transparent drop-in use.
- Debug mode (cookies, double-free detection, poison-on-free).
- Telemetry integration.
- EAL integration, allowing EAL-internal subsystems to use
  fastmem for their small-object allocations.

Changes in RFC v4:
- Fix crash in halloc/hfree on lcores without hlookup: fall back
  to shared bin on NULL cache.
- Keep per-lcore statistics across rte_fastmem_cache_flush().
- Guard free and IOVA paths against uninitialized state.
- Lazy-attach stats readers in secondary processes; distinguish
  -ENODEV from -EINVAL.
- Protect bin statistics with the bin lock.
- Trim verbose comments.
- Add shared cache for callers without a private cache (non-EAL
  threads, secondary processes). Add rte_fastmem_stats_shared()
  and rte_fastmem_stats_shared_class().
- Document rte_fastmem_stats_reset() quiescence requirement.
- Add tests for handle alloc/free from uncached lcores, stats
  survival across flush, and shared-cache statistics.
- Update programming guide (shared cache, stats sections).

Changes in RFC v3:
- Add rte_fastmem_realloc() with full test coverage.
- Add __rte_malloc/__rte_dealloc compiler attributes; remove
  incorrect __rte_alloc_size/__rte_alloc_align.
- Extract normalize_align() helper; remove redundant inline
  directives.
- Merge lifecycle and functional test suites.
- Add realloc subsection to programming guide.

Changes in RFC v2:
- Fix cross-socket deinit use-after-free.
- Add secondary process support.
- Add handle-based allocation API.
- Fix clang warnings; misc cleanup.

Mattias Rönnblom (3):
  doc: add fastmem programming guide
  lib: add fastmem library
  app/test: add fastmem test suite

 doc/guides/prog_guide/fastmem_lib.rst | ...
 lib/fastmem/                          | ...
 app/test/test_fastmem*.c              | ...

Mattias Rönnblom (3):
  doc: add fastmem programming guide
  lib: add fastmem library
  app/test: add fastmem test suite

 app/test/meson.build                  |    3 +
 app/test/test_fastmem.c               | 2111 ++++++++++++++++++++++++
 app/test/test_fastmem_perf.c          | 1040 ++++++++++++
 app/test/test_fastmem_profile.c       |  157 ++
 doc/api/doxy-api-index.md             |    1 +
 doc/api/doxy-api.conf.in              |    1 +
 doc/guides/prog_guide/fastmem_lib.rst |  351 ++++
 doc/guides/prog_guide/index.rst       |    1 +
 lib/fastmem/meson.build               |    6 +
 lib/fastmem/rfc-cover-letter.txt      |  128 ++
 lib/fastmem/rte_fastmem.c             | 2123 +++++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h             |  908 +++++++++++
 lib/meson.build                       |    1 +
 13 files changed, 6831 insertions(+)
 create mode 100644 app/test/test_fastmem.c
 create mode 100644 app/test/test_fastmem_perf.c
 create mode 100644 app/test/test_fastmem_profile.c
 create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
 create mode 100644 lib/fastmem/meson.build
 create mode 100644 lib/fastmem/rfc-cover-letter.txt
 create mode 100644 lib/fastmem/rte_fastmem.c
 create mode 100644 lib/fastmem/rte_fastmem.h

-- 
2.43.0

