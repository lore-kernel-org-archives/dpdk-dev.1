Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4AECD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF4940280;
	Mon, 25 May 2026 20:36:54 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id C3A1B40144
 for <dev@dpdk.org>; Mon, 25 May 2026 20:36:52 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso18259619eec.0
 for <dev@dpdk.org>; Mon, 25 May 2026 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779734212;
 x=1780339012; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/75Unxk6rID4Ydx2XvZRiU/lmxDLqz9esVI9Ejf9Fi8=;
 b=VmvpRel/nuv2nMMcCEC0uc/ZrfhRwhKj9ifPOF/2z/PZS1yi9SWlKicZiH/exgEcgT
 WegxFFfbiOe7szGOu9e1vEVlh3WWS5Q53kuM+gtSzNOvsA83wFroBBP395LO/oWqa04i
 NL7yLekAe2bwyb39n1TUBFwyRoSbFs0u4+au2uSYvTYdV/+ER114IBmg9CaseDw4w/9S
 NOst31Fs2D45TEPD6ORrMHJkICOqiF8j3lyTvJNMHNt9Zk7++i6L3oaztWnTZ7oHP9fG
 ptlKU9sj7GGzNPNVHx3BKAt1tI7ah43bMzYScE+mkBYnVPV/kFReGxoAK84OmrKSg/Ib
 xcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779734212; x=1780339012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/75Unxk6rID4Ydx2XvZRiU/lmxDLqz9esVI9Ejf9Fi8=;
 b=Ra/Qm6FapytEBE0ML08XkYvOIi30rgiZdIzmb2e1IgNKJtK7j7c3tHBDBQa6J18zh0
 ifSsPGGza8WsknyE/oBW8nx893gHLqPuu1nPvE6cuqFQLAPt99MXr4M8betRAADk5+pb
 ZsI1ESnqJq3SvVQlN38eHlv+5GFkXLRZd7HuAUrPl2aFVu3kPJIReGj+FeuajIT5p/RO
 RCGFbD6HpDJEudP9lZ+mpxUhCfqCKnk36W9vtp7C8BQFLzR18hPe/2bkHnATxLbP078R
 GY+vxMbplSg/l9WCUAXIbDjrtmi6UPP7Xnet1qUKivvjAZzNJKFVqe/c4/7g2ILecyrn
 Y6Hg==
X-Gm-Message-State: AOJu0YyWITiqzSI9ZzaGPxK4z7NdT4sbmpbH6vcO69Swg2RkAtzKoToy
 Vg84zSdDq2/HIfZBwCI7Xvc9UZTjmMr1a4/KfLFkHY/qwqSqKRDwim1vMCxs8bMF9wI=
X-Gm-Gg: Acq92OEGZ/PlTcQvbbc11XsdN8/Wc2UMykO4SzGGl4dEJMmY6yzKYh2kAhmbDvKe+Da
 qDw3sdZNdrgmHlWbCg0txHHK0pag2WEnb++WPhjTk6s07LXmdwKhsh7udvv2EnLHdcw9h3Ar1up
 dtXizQ9g+nSEqsFAwgAxuBod4bBx6/M0Lxqy5V+UD6xxXU8O9LvfO4vIxMDWCsEoKtvffJIQ6Up
 q0+P7SDxCp4K/9QyX3uT0CwaUPfUtk4TBuJsLBfP83EQ72M+HOg45JcQ94pb2Td2XIgrR/HF2ae
 YBYt+jo93sEcPKyPi5RNMr2IRVlqJTNtJ7O/+KnYYTGf0iKedVq0Yz/sOOjjPab+GN4BbXqF9zh
 tC1RlnkKxh1w2nWqLrRFKA2MJH04eSxIJerrT0oT9UiBntujBzHNvcMOlEVecsWFAdNQTbpqDOg
 ENMyctBDCpZy9nKcHs4vOB+onaVd+ouF5CGWnTDbUirakI2CfvveYBF3NKrQqisK9x
X-Received: by 2002:a05:7301:2b06:b0:2d9:6373:ad10 with SMTP id
 5a478bee46e88-304490383d1mr7270987eec.7.1779734211313; 
 Mon, 25 May 2026 11:36:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef5492sm8256309eec.6.2026.05.25.11.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 11:36:51 -0700 (PDT)
Date: Mon, 25 May 2026 11:36:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>, Yogaraj Baskaravel
 <yogaraj.baskaravel@ericsson.com>
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
Message-ID: <20260525113648.5bf540ca@phoenix.local>
In-Reply-To: <20260525103642.55255-1-hofors@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 25 May 2026 12:36:39 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> This RFC introduces fastmem, a general-purpose small-object allocator
> for DPDK. It is intended to replace per-type mempools with a single
> allocator that handles arbitrary sizes, grows on demand, and matches
> mempool-level performance on the hot path.
>=20
> Motivation
> ----------
>=20
> DPDK applications commonly maintain many mempools =E2=80=94 one per object
> type (connections, sessions, timers, work items). Each must be sized
> up front, wastes memory when over-provisioned, and cannot serve
> objects of a different size. Fastmem eliminates this by accepting
> arbitrary sizes at runtime, backed by a slab allocator that
> repurposes memory across size classes as demand shifts.
>=20
> Design
> ------
>=20
> Three-layer architecture:
>=20
> 1. Backing memory: 128 MiB IOVA-contiguous memzones from EAL,
>    reserved lazily (or pre-reserved for deterministic latency).
>=20
> 2. Slabs: 2 MiB, 2 MiB-aligned regions carved from memzones.
>    The alignment enables O(1) slab lookup from any object pointer
>    via bitmask =E2=80=94 no radix tree or index structure. Slabs move
>    freely between 18 power-of-2 size classes (8 B to 1 MiB).
>=20
> 3. Per-lcore caches: bounded LIFO stacks (no locks on the hot
>    path). Cache misses trigger bulk transfers to/from the shared
>    bin under a spinlock.
>=20
> Key properties:
>=20
> - Zero per-object metadata in the production build.
> - NUMA-aware, with per-socket bins and free-slab pools.
> - DMA-usable memory with O(1) virt-to-IOVA translation.
> - Bulk alloc/free with all-or-nothing semantics.
> - Backing memory never returned during lifetime (slabs recycled).
> - Non-EAL threads supported (bypass cache, take bin lock).
>=20
> API surface
> -----------
>=20
>   rte_fastmem_init / deinit
>   rte_fastmem_reserve
>   rte_fastmem_set_limit / get_limit
>   rte_fastmem_alloc / alloc_socket
>   rte_fastmem_alloc_bulk / alloc_bulk_socket
>   rte_fastmem_free / free_bulk
>   rte_fastmem_virt2iova
>   rte_fastmem_cache_flush
>   rte_fastmem_max_size / classes
>   rte_fastmem_stats / stats_class / stats_lcore / stats_lcore_class
>   rte_fastmem_stats_reset
>=20
> All APIs are marked __rte_experimental.
>=20
> Performance
> -----------
>=20
> The single-object hot path is roughly 2-3x the cost of mempool
> and an order of magnitude faster than rte_malloc. Under
> multi-lcore contention, fastmem scales similarly to mempool,
> while rte_malloc collapses.
>=20
> Limitations
> -----------
>=20
> - Maximum allocation: 1 MiB. Larger requests should use rte_malloc.
> - Power-of-2 classes only; worst-case internal fragmentation ~50%.
> - Backing memory not reclaimable short of deinit.
>=20
> Future work
> -----------
>=20
> - Lcore-affine allocations (false-sharing-free by construction).
> - Mempool ops driver for transparent drop-in use.
> - Pre-resolved allocator handle binding size class and socket,
>   eliminating per-call class lookup and enabling an inline
>   cache-hit fast path.
> - Debug mode (cookies, double-free detection, poison-on-free).
> - Telemetry integration.
> - EAL integration, allowing EAL-internal subsystems to use
>   fastmem for their small-object allocations.
>=20
> Mattias R=C3=B6nnblom (3):
>   doc: add fastmem programming guide
>   lib: add fastmem library
>   app/test: add fastmem test suite
>=20
>  app/test/meson.build                  |    3 +
>  app/test/test_fastmem.c               | 1682 +++++++++++++++++++++++++
>  app/test/test_fastmem_perf.c          |  997 +++++++++++++++
>  app/test/test_fastmem_profile.c       |  157 +++
>  doc/api/doxy-api-index.md             |    1 +
>  doc/api/doxy-api.conf.in              |    1 +
>  doc/guides/prog_guide/fastmem_lib.rst |  301 +++++
>  doc/guides/prog_guide/index.rst       |    1 +
>  lib/fastmem/meson.build               |    6 +
>  lib/fastmem/rte_fastmem.c             | 1486 ++++++++++++++++++++++
>  lib/fastmem/rte_fastmem.h             |  644 ++++++++++
>  lib/meson.build                       |    1 +
>  12 files changed, 5280 insertions(+)
>  create mode 100644 app/test/test_fastmem.c
>  create mode 100644 app/test/test_fastmem_perf.c
>  create mode 100644 app/test/test_fastmem_profile.c
>  create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
>  create mode 100644 lib/fastmem/meson.build
>  create mode 100644 lib/fastmem/rte_fastmem.c
>  create mode 100644 lib/fastmem/rte_fastmem.h
>=20

Largish patchset so did AI review with full claude model.

Series review: [RFC 0/3] add fastmem allocator
Reviewed against the v1 RFC posted 2026-05-25.


[RFC 1/3] doc: add fastmem programming guide

Info: doc/guides/prog_guide/fastmem_lib.rst -- "\ No newline at end of file"
   The new RST file does not end with a newline.


[RFC 2/3] lib: add fastmem library

Error: lib/fastmem/rte_fastmem.c -- use-after-free during rte_fastmem_deini=
t()
   when caches were allocated cross-socket.

   cache_create() places the cache struct on the *calling thread's* socket,
   not on the socket the cache serves:

       unsigned int own_socket =3D rte_socket_id();
       ...
       alloc_socket =3D &fastmem->sockets[own_socket];
       cache =3D bin_alloc_one(&alloc_socket->bins[cache_class]);
       ...
       *slot =3D cache;          /* slot is in socket K's caches[][] */

   So an lcore on socket S that calls rte_fastmem_alloc_socket(..., K) with
   S !=3D K creates a cache whose memory lives in socket S's memzone but is
   reachable through socket K's caches[lcore][class].

   rte_fastmem_deinit() then walks sockets in index order:

       for (i =3D 0; i < RTE_MAX_NUMA_NODES; i++)
               release_socket(&fastmem->sockets[i]);

   and release_socket() does, in this order:

       socket_release_caches(socket);            /* (1) */
       for (c...) bin_release(&socket->bins[c], socket);  /* (2) */
       for (i...) rte_memzone_free(socket->memzones[i]);  /* (3) */

   When i =3D S, step (3) frees socket S's memzones. When i =3D K (K > S),
   socket_release_caches(K) runs:

       cache_slab =3D slab_of(cache);             /* in socket S's freed mz=
 */
       bin_free_one(cache_slab->bin, cache);    /* reads cache_slab->bin */

   cache_slab points into a freed memzone, so cache_slab->bin and the
   subsequent push (slab->free_head =3D obj; slab->free_count++; in
   bin_push_locked()) read and write released memory. slab_release() may
   then re-attach the slab to socket S's free_head, which was zeroed and
   whose backing is gone.

   This is triggered by any application that allocates from a non-local
   socket via SOCKET_ID_ANY fallback or explicit socket_id, which the
   programming guide describes as a normal mode of operation. The
   existing test_alloc_socket and test_alloc_socket_numa_placement use
   rte_socket_id_by_idx(0) (the local socket) so the bug is not
   exercised by the test suite.

   Either order the teardown in three phases (all caches across all
   sockets first, then all bins, then all memzones), or allocate the
   cache struct from the socket it serves rather than the calling
   thread's socket.

Warning: lib/fastmem/rte_fastmem.c -- non-atomic access to shared 64-bit
   statistics counters.

   cache->alloc_cache_hits, alloc_cache_misses, alloc_nomem,
   free_cache_hits, free_cache_misses, and the bin counters
   slab_acquires, slab_releases, slabs_partial, slabs_full are
   incremented as plain C reads/writes by the owning lcore and read
   from another thread via rte_fastmem_stats(), rte_fastmem_stats_class(),
   rte_fastmem_stats_lcore(), and rte_fastmem_stats_lcore_class(). On
   architectures where uint64_t is not naturally atomic (and per the C
   standard generally) this is a data race; even on x86-64 it is
   undefined behavior under -fsanitize=3Dthread.

   Use rte_atomic_fetch_add_explicit() with rte_memory_order_relaxed on
   the producer side and rte_atomic_load_explicit() with relaxed
   ordering on the reader side. Per AGENTS.md / the DPDK convention,
   relaxed ordering is appropriate for these counters.

Warning: lib/fastmem/rte_fastmem.c -- pointer publish in cache_create()
   without release ordering.

       *slot =3D cache;
       return cache;

   The struct fields (count, capacity, target, the stats counters) are
   written before this store but with no fence or release barrier. A
   concurrent stats reader doing socket->caches[l][c] followed by
   cache->* could observe the pointer but not all initialized fields.
   Even ignoring the stats reader, rte_fastmem_cache_flush() invoked
   from a different lcore on the same cache (not currently possible by
   API contract, but the field is technically reachable) would race.
   Pair with rte_atomic_store_explicit(..., rte_memory_order_release)
   and a matching acquire load on the reader path.

Warning: lib/fastmem/rte_fastmem.c -- spurious ENOMEM window during slab
   release.

   bin_push_locked() removes a fully-drained slab from bin->partial
   before bin_free_one() drops the bin lock; slab_release() then puts
   it on socket->free_head under the socket lock. Between the unlock
   and slab_release(), another lcore allocating in any class on the
   same socket can see free_head =3D=3D NULL, hit the memory_limit (or
   FASTMEM_MAX_MEMZONES_PER_SOCKET) check in grow_socket(), and return
   ENOMEM even though the slab is about to become available. Not a
   correctness issue but visible to applications that pin tightly to
   their limit.

Info: lib/fastmem/rte_fastmem.c local_socket_id() final fallback:

       return (unsigned int)rte_socket_id_by_idx(0);

   rte_socket_id_by_idx() returns int and is documented to return -1 on
   error. If there are zero configured sockets the cast yields UINT_MAX
   and fastmem->sockets[UINT_MAX] is out of bounds. Realistically there
   is always at least one socket, but a defensive check (return 0, or
   fail allocation explicitly) would avoid the corner case.

Info: lib/fastmem/rte_fastmem.c cache_pop() refills to cache->target
   (half capacity) rather than to capacity. Subsequent single-object
   allocs only get target-1 hits before the next bin trip. Likely
   intentional for fairness with bulk callers, but worth a comment.

Info: lib/meson.build inserts 'fastmem' between 'dispatcher' and
   'gpudev'. The natural alphabetical position is between 'efd' and
   'fib'; fastmem has no dependency on dispatcher.


[RFC 3/3] app/test: add fastmem test suite

Warning: app/test/test_fastmem.c -- REGISTER_FAST_TEST uses NOHUGE_OK
   but the functional tests need real memzone-backed memory.

       REGISTER_FAST_TEST(fastmem_autotest, NOHUGE_OK, ASAN_OK,
                          test_fastmem);

   test_fastmem runs both the lifecycle suite (no allocations) and the
   functional suite, which requests 128 MiB IOVA-contiguous memzones.
   In --no-huge mode IOVA-contiguous reservation of that size is not
   reliable, so NOHUGE_SKIP is more honest. If you want the lifecycle
   tests to remain no-huge-friendly, register them as a separate
   test command.

Warning: app/test/test_fastmem.c -- the suite never exercises
   cross-socket cache allocation.

   test_alloc_socket and test_alloc_socket_numa_placement both use
   rte_socket_id_by_idx(0) (the local socket). Add a test that runs on
   a worker lcore whose rte_socket_id() differs from the target
   socket_id passed to rte_fastmem_alloc_socket(), then calls
   rte_fastmem_deinit(). This would have caught the deinit UAF above.

Info: app/test/test_fastmem.c -- several test functions declare an
   uninitialized `int rc;` that is never read or written (e.g.
   test_alloc_too_big, test_alloc_invalid_align, test_alloc_free_small,
   test_alloc_alignment, test_alloc_socket, test_alloc_block_repurposing
   and others). Drop the declarations.

Info: app/test/test_fastmem.c trailing blank-line clusters (two blank
   lines before "return TEST_SUCCESS;" in test_reserve_multiple_memzones,
   test_reserve_cumulative, test_reserve_invalid_socket,
   test_reserve_any_socket, test_alloc_too_big, ...). Drop the extra
   blank line.
