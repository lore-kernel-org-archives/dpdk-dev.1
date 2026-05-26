Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E2CCD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 08:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD524065C;
	Tue, 26 May 2026 10:57:56 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 08E9B40280
 for <dev@dpdk.org>; Tue, 26 May 2026 10:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779785874;
 bh=lFb7YvxLzhwgl4Og0vFlCZKdSQMqNRoG1MHwJ1tIAM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MWWlsrN1fI7cYuVoE5HbfUHghoIayQjFNrUkgv7H1G5VxJ+qspB6NjRmTY2ebsJYF
 skT4e4Pf4II/k+Ljq4wsiI0ZImgmJyG1uTlFboMHnabIWRktRMdMAnPCJtiLZXgffo
 VWwnJtPwzlj04VhcELTzGyZzmY/RkphKoGCTq0GksluftR13UcoNEYJnQ0/3fLumFu
 N+C7OwvgJlayZYrent2aXCwREum2KjOO4z4fwuCBfhQFP//56V4mVRQLCazx9gdumX
 2qywcPm2bQOMLLnCoNLq9LUD4WFv5IZrVrh6cmxn7+7UlMdRDzLubAlW+hrysI9Dlw
 ycEohrURjGBtw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 741EB1D02C
 for <dev@dpdk.org>; Tue, 26 May 2026 10:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779785874;
 bh=lFb7YvxLzhwgl4Og0vFlCZKdSQMqNRoG1MHwJ1tIAM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MWWlsrN1fI7cYuVoE5HbfUHghoIayQjFNrUkgv7H1G5VxJ+qspB6NjRmTY2ebsJYF
 skT4e4Pf4II/k+Ljq4wsiI0ZImgmJyG1uTlFboMHnabIWRktRMdMAnPCJtiLZXgffo
 VWwnJtPwzlj04VhcELTzGyZzmY/RkphKoGCTq0GksluftR13UcoNEYJnQ0/3fLumFu
 N+C7OwvgJlayZYrent2aXCwREum2KjOO4z4fwuCBfhQFP//56V4mVRQLCazx9gdumX
 2qywcPm2bQOMLLnCoNLq9LUD4WFv5IZrVrh6cmxn7+7UlMdRDzLubAlW+hrysI9Dlw
 ycEohrURjGBtw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 56E281D02B; Tue, 26 May 2026 10:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779785871;
 bh=lFb7YvxLzhwgl4Og0vFlCZKdSQMqNRoG1MHwJ1tIAM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q7hYeMk1jwbE4rjauuLEy+gVtJH+ZMXNkw6KT1QUVRZfrO8LIhCR0gUDnhJU+eEER
 0+td0MZbreNsObk5xpBT8xFeYI6++1ggbc3IjFpPWxoP14ZQR/jFsBEBHR0/iOeo9k
 aJVs6f1ZeAliS/X3J/lyqLoZukNSiED37ivyEDn7xbqX5HmzAiDZ/WYvXZnX1NPFhN
 20urrIU6VtXbCqyxNwJeB2wUgd4Y7YCkRdZ0Nv+qq7J2ymoUbtmr/r8cWJHEqm1h9u
 i2xmnYsLh5lFl7bffqX4Klv2Tlurfu12qwKYJXazeDN2YCgC9gtmrz/hR5jzny5v6O
 A3OZi5VL9TPfg==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 4B4D81CF62;
 Tue, 26 May 2026 10:57:50 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC v2 0/3] lib/fastmem: fast small-object allocator
Date: Tue, 26 May 2026 10:57:40 +0200
Message-ID: <20260526085743.64396-1-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525103642.55255-4-hofors@lysator.liu.se>
References: <20260525103642.55255-4-hofors@lysator.liu.se>
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


Mattias Rönnblom (3):
  doc: add fastmem programming guide
  lib: add fastmem library
  app/test: add fastmem test suite

 app/test/meson.build                  |    3 +
 app/test/test_fastmem.c               | 1673 ++++++++++++++++++++++++
 app/test/test_fastmem_perf.c          | 1040 +++++++++++++++
 app/test/test_fastmem_profile.c       |  157 +++
 doc/api/doxy-api-index.md             |    1 +
 doc/api/doxy-api.conf.in              |    1 +
 doc/guides/prog_guide/fastmem_lib.rst |  314 +++++
 doc/guides/prog_guide/index.rst       |    1 +
 lib/fastmem/meson.build               |    6 +
 lib/fastmem/rte_fastmem.c             | 1694 +++++++++++++++++++++++++
 lib/fastmem/rte_fastmem.h             |  774 +++++++++++
 lib/meson.build                       |    1 +
 12 files changed, 5665 insertions(+)
 create mode 100644 app/test/test_fastmem.c
 create mode 100644 app/test/test_fastmem_perf.c
 create mode 100644 app/test/test_fastmem_profile.c
 create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
 create mode 100644 lib/fastmem/meson.build
 create mode 100644 lib/fastmem/rte_fastmem.c
 create mode 100644 lib/fastmem/rte_fastmem.h

-- 
2.43.0

