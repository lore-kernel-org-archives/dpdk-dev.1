Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13401CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 17:30:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26D9B4026C;
	Wed, 27 May 2026 19:30:49 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 711024014F
 for <dev@dpdk.org>; Wed, 27 May 2026 19:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779903047;
 bh=VHpaDCoOa4etv/i06uqmkchQtUr8+Df5O1meeHoUlsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hZBw98DAsJKfg+hhHioYsAEGf7O495cDsLB8/oUYf2ApMgsUzWtFlfZ1Djzw3lc38
 OTrwv+SJ1srVPHNljMMfYdP0LlZhKJoZqb1J/fB6cSSDKtzc3j45XVn87MZ0LExjK3
 c/yHwxskCCaDv5T69+e92qlfuuxlT1TQOttfacfHjZjKLN1a6WVKOu16O1TAte3GgX
 7dUVPXLcBbX1+qe4SR29p2gxz2SN9d3t/qMujr+NRtVpkCumgYxupGNb6sqKxiNEoQ
 insNzMDJ8uAUvXmU/8Qm2IjQVIxFH7K/Gzjtel9031xOTkZrIo1Ufj/dGfneMsWS9S
 stt18X94ee2iw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 1B56A331C
 for <dev@dpdk.org>; Wed, 27 May 2026 19:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779903047;
 bh=VHpaDCoOa4etv/i06uqmkchQtUr8+Df5O1meeHoUlsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hZBw98DAsJKfg+hhHioYsAEGf7O495cDsLB8/oUYf2ApMgsUzWtFlfZ1Djzw3lc38
 OTrwv+SJ1srVPHNljMMfYdP0LlZhKJoZqb1J/fB6cSSDKtzc3j45XVn87MZ0LExjK3
 c/yHwxskCCaDv5T69+e92qlfuuxlT1TQOttfacfHjZjKLN1a6WVKOu16O1TAte3GgX
 7dUVPXLcBbX1+qe4SR29p2gxz2SN9d3t/qMujr+NRtVpkCumgYxupGNb6sqKxiNEoQ
 insNzMDJ8uAUvXmU/8Qm2IjQVIxFH7K/Gzjtel9031xOTkZrIo1Ufj/dGfneMsWS9S
 stt18X94ee2iw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 01749331B; Wed, 27 May 2026 19:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779903045;
 bh=VHpaDCoOa4etv/i06uqmkchQtUr8+Df5O1meeHoUlsM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZjAAVm+6z5bYLv7+ub+bPIQ1y3fS0+CftIkGoBXxwHSIJmltqcJuM8gINJmVLQpiD
 d0G85y+yC0hDKu49NV973wo9DQnvIgYXl+fzj/rGB4uR1Acqx3CHOciyiURa1p7R2l
 IsmZPI2omP32spru3qLwu6RUzfk/sIC0I5TjyekEGxCN1bpb9Au6TK1VOAlZvRbWUl
 SkBaj+S/DrXpkRr+A1q5o5Pw3iCw7AQevF16OMK62GJ1W3ffYbpnrDpNIgpk6rAdl7
 hx5+qcpEYuMaPm41O2NjO5ibPlat24ozAbXzjTUmgdYfZtX0R7kK2vWXvAoXEXwLKh
 2BRi/vwBMmoIA==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id A25CB31C7;
 Wed, 27 May 2026 19:30:44 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC v3 0/3] lib/fastmem: fast small-object allocator
Date: Wed, 27 May 2026 19:30:39 +0200
Message-ID: <20260527173042.93867-1-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526085743.64396-4-hofors@lysator.liu.se>
References: <20260526085743.64396-4-hofors@lysator.liu.se>
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

 app/test/meson.build                  |    3 +
 app/test/test_fastmem.c               | 1801 +++++++++++++++++++++++++
 app/test/test_fastmem_perf.c          | 1040 ++++++++++++++
 app/test/test_fastmem_profile.c       |  157 +++
 doc/api/doxy-api-index.md             |    1 +
 doc/api/doxy-api.conf.in              |    1 +
 doc/guides/prog_guide/fastmem_lib.rst |  328 +++++
 doc/guides/prog_guide/index.rst       |    1 +
 lib/fastmem/meson.build               |    6 +
 lib/fastmem/rte_fastmem.c             | 1748 ++++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h             |  815 +++++++++++
 lib/meson.build                       |    1 +
 12 files changed, 5902 insertions(+)
 create mode 100644 app/test/test_fastmem.c
 create mode 100644 app/test/test_fastmem_perf.c
 create mode 100644 app/test/test_fastmem_profile.c
 create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
 create mode 100644 lib/fastmem/meson.build
 create mode 100644 lib/fastmem/rte_fastmem.c
 create mode 100644 lib/fastmem/rte_fastmem.h

-- 
2.43.0

