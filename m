Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA37ECD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 10:37:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1C5A402AC;
	Mon, 25 May 2026 12:37:03 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 286B640276
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705421;
 bh=pPmC6xtUTSYGnKYNa6FXPwypcp+6glqb9qUoqq0J358=;
 h=From:To:Cc:Subject:Date:From;
 b=fyPHCcMByducQLEw6fbpwswhA12GsKrmYNWNOiL+sIJK5H0J1IXSU8Hf9khHgK2ip
 Ej0FXNPNlQSBqRQjpBbO5Yt/VFlxjBk249BFzxTJ0mSIKs491wJnH9NacCA8YlNWKo
 2si7HeGnCl6TPsrMVWNqBb450t7H3AEqzMICdV+6pn6qaegTIR5ThtFUQ5Q91E2fV1
 9bIoJJGj4Ka1Cbi0DMl87HA8alg5+CcA6XvzwAO43/RlTX6froov/6FH4ODeu3N3++
 RjXsLYx1SSbD/hO8+XB5p139KTCfpGvhJ2F8FaWaOO3gtp+lIYMLesQQ1Wr9uMQ6zs
 yrTotXKKs/3Ag==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 9450B19194
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705421;
 bh=pPmC6xtUTSYGnKYNa6FXPwypcp+6glqb9qUoqq0J358=;
 h=From:To:Cc:Subject:Date:From;
 b=fyPHCcMByducQLEw6fbpwswhA12GsKrmYNWNOiL+sIJK5H0J1IXSU8Hf9khHgK2ip
 Ej0FXNPNlQSBqRQjpBbO5Yt/VFlxjBk249BFzxTJ0mSIKs491wJnH9NacCA8YlNWKo
 2si7HeGnCl6TPsrMVWNqBb450t7H3AEqzMICdV+6pn6qaegTIR5ThtFUQ5Q91E2fV1
 9bIoJJGj4Ka1Cbi0DMl87HA8alg5+CcA6XvzwAO43/RlTX6froov/6FH4ODeu3N3++
 RjXsLYx1SSbD/hO8+XB5p139KTCfpGvhJ2F8FaWaOO3gtp+lIYMLesQQ1Wr9uMQ6zs
 yrTotXKKs/3Ag==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 7687B19049; Mon, 25 May 2026 12:37:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705414;
 bh=pPmC6xtUTSYGnKYNa6FXPwypcp+6glqb9qUoqq0J358=;
 h=From:To:Cc:Subject:Date:From;
 b=FH6lZEmfZgqMGVUNlF5DWK/FhcSVauhW3STEmGQYLd6LxSnckois3PN+bkrHoRd4e
 ZsjlNrPRBGZeVTlh2Plz5N5o42iYlpy7ZTckAC7dDA+JwnaEPt2PtYcp50RtWB/OKs
 RMl7xsRuRU2ev86gPhJbUl2b/+PNgqjavhAr9eBWwwXQcUbSpGLseKSFYPCxeQzRCJ
 sMBrr/ovBJoRixVNiDZug7z6Vy9B83W2AHffRlPE5ezfHa/7mekpwIkbztycziMs/R
 NTKRH5acJZphxb55noe4ckSpc1LMfUeyO1UqygV421bfzF0vpKGlgUsSNbg4kpWeCt
 Fx0VBhdrYxjGA==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id F1007190BA;
 Mon, 25 May 2026 12:36:53 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC 0/3] lib/fastmem: fast small-object allocator
Date: Mon, 25 May 2026 12:36:39 +0200
Message-ID: <20260525103642.55255-1-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
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

API surface
-----------

  rte_fastmem_init / deinit
  rte_fastmem_reserve
  rte_fastmem_set_limit / get_limit
  rte_fastmem_alloc / alloc_socket
  rte_fastmem_alloc_bulk / alloc_bulk_socket
  rte_fastmem_free / free_bulk
  rte_fastmem_virt2iova
  rte_fastmem_cache_flush
  rte_fastmem_max_size / classes
  rte_fastmem_stats / stats_class / stats_lcore / stats_lcore_class
  rte_fastmem_stats_reset

All APIs are marked __rte_experimental.

Performance
-----------

The single-object hot path is roughly 2-3x the cost of mempool
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
- Pre-resolved allocator handle binding size class and socket,
  eliminating per-call class lookup and enabling an inline
  cache-hit fast path.
- Debug mode (cookies, double-free detection, poison-on-free).
- Telemetry integration.
- EAL integration, allowing EAL-internal subsystems to use
  fastmem for their small-object allocations.

Mattias Rönnblom (3):
  doc: add fastmem programming guide
  lib: add fastmem library
  app/test: add fastmem test suite

 app/test/meson.build                  |    3 +
 app/test/test_fastmem.c               | 1682 +++++++++++++++++++++++++
 app/test/test_fastmem_perf.c          |  997 +++++++++++++++
 app/test/test_fastmem_profile.c       |  157 +++
 doc/api/doxy-api-index.md             |    1 +
 doc/api/doxy-api.conf.in              |    1 +
 doc/guides/prog_guide/fastmem_lib.rst |  301 +++++
 doc/guides/prog_guide/index.rst       |    1 +
 lib/fastmem/meson.build               |    6 +
 lib/fastmem/rte_fastmem.c             | 1486 ++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h             |  644 ++++++++++
 lib/meson.build                       |    1 +
 12 files changed, 5280 insertions(+)
 create mode 100644 app/test/test_fastmem.c
 create mode 100644 app/test/test_fastmem_perf.c
 create mode 100644 app/test/test_fastmem_profile.c
 create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
 create mode 100644 lib/fastmem/meson.build
 create mode 100644 lib/fastmem/rte_fastmem.c
 create mode 100644 lib/fastmem/rte_fastmem.h

-- 
2.43.0

