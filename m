Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFCECD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 19:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3589040280;
	Mon, 25 May 2026 21:43:18 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 071E040144
 for <dev@dpdk.org>; Mon, 25 May 2026 21:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779738196;
 bh=rIzAtlhXzgPtwmRWoeWV7415WnwW25zp6/CEsg25y7I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BClStwUPsi6dx15QwD8hxh3zuQ8cSX9XkC8SO9CTz5+CK8/rKIkKEs2cg1JX6OSKp
 UQ8ltX7zfVpzYs9VborYGgMIFG6nggzSsKOwNMac4kqgN67QUDXG/1UiH5GthYkqcc
 nbyhGU+p9xPdS6o+2LWMGNz6+BtIggvgKt4oovxdqA6jyibJidZXRbRO9pIGqdC8Nm
 c7JgOXa7ugEVkt0wLZVZzBz3gKkrUWJAVwCUKqMfqIPl9VNZVshFl0UxcTPNzqmaAw
 B3SfTu5b2S51K8Ox+uUrRLF39VMiZZhfgznnXWzLY5vdeJegxiNY0QXcfwdgZYYS0O
 R/1tqnGSzIfpA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id B3B271ACFD
 for <dev@dpdk.org>; Mon, 25 May 2026 21:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779738196;
 bh=rIzAtlhXzgPtwmRWoeWV7415WnwW25zp6/CEsg25y7I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BClStwUPsi6dx15QwD8hxh3zuQ8cSX9XkC8SO9CTz5+CK8/rKIkKEs2cg1JX6OSKp
 UQ8ltX7zfVpzYs9VborYGgMIFG6nggzSsKOwNMac4kqgN67QUDXG/1UiH5GthYkqcc
 nbyhGU+p9xPdS6o+2LWMGNz6+BtIggvgKt4oovxdqA6jyibJidZXRbRO9pIGqdC8Nm
 c7JgOXa7ugEVkt0wLZVZzBz3gKkrUWJAVwCUKqMfqIPl9VNZVshFl0UxcTPNzqmaAw
 B3SfTu5b2S51K8Ox+uUrRLF39VMiZZhfgznnXWzLY5vdeJegxiNY0QXcfwdgZYYS0O
 R/1tqnGSzIfpA==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 9A33B1ADA9; Mon, 25 May 2026 21:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779738193;
 bh=rIzAtlhXzgPtwmRWoeWV7415WnwW25zp6/CEsg25y7I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c1GRTfCDmdWEtvKWoEte4fVd0i8Hac1IlC1uSPzviDiENEqBxflZmsjfFjbWK3889
 vo2NLjCaV1HkzatPwNLZNSeD8fuE52WWbrP+cRMwxBaJJWZKprH9SD3zl1w4M2w3WW
 911Be6WVNCPtbVmB8NOEQ/NAhMmRK2uP3NwB8PYtE/l9NZ6++28lNip2FfCcrvMSbz
 y8/Xa+AB/HffPe3/CONQoz+M7RylnjeP6fo+/HmCcKi2p9Uh+lgZMHh0XkMYyXfoDm
 xwR7x7PzvZvoc1oqMo4Zb4aU0n+U7V2ObivYG7iUQ6iRQ2nEebGg0yRem1v5GH9F9n
 4LME4srrOSshg==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 04DB01AE15;
 Mon, 25 May 2026 21:43:13 +0200 (CEST)
Message-ID: <ff282491-89a9-4d41-bc02-7758c8c0208b@lysator.liu.se>
Date: Mon, 25 May 2026 21:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] lib/fastmem: fast small-object allocator
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
 <20260525113648.5bf540ca@phoenix.local>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260525113648.5bf540ca@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/25/26 20:36, Stephen Hemminger wrote:
> On Mon, 25 May 2026 12:36:39 +0200
> Mattias Rönnblom <hofors@lysator.liu.se> wrote:
> 
>> This RFC introduces fastmem, a general-purpose small-object allocator
>> for DPDK. It is intended to replace per-type mempools with a single
>> allocator that handles arbitrary sizes, grows on demand, and matches
>> mempool-level performance on the hot path.
>>
>> Motivation
>> ----------
>>
>> DPDK applications commonly maintain many mempools — one per object
>> type (connections, sessions, timers, work items). Each must be sized
>> up front, wastes memory when over-provisioned, and cannot serve
>> objects of a different size. Fastmem eliminates this by accepting
>> arbitrary sizes at runtime, backed by a slab allocator that
>> repurposes memory across size classes as demand shifts.
>>
>> Design
>> ------
>>
>> Three-layer architecture:
>>
>> 1. Backing memory: 128 MiB IOVA-contiguous memzones from EAL,
>>     reserved lazily (or pre-reserved for deterministic latency).
>>
>> 2. Slabs: 2 MiB, 2 MiB-aligned regions carved from memzones.
>>     The alignment enables O(1) slab lookup from any object pointer
>>     via bitmask — no radix tree or index structure. Slabs move
>>     freely between 18 power-of-2 size classes (8 B to 1 MiB).
>>
>> 3. Per-lcore caches: bounded LIFO stacks (no locks on the hot
>>     path). Cache misses trigger bulk transfers to/from the shared
>>     bin under a spinlock.
>>
>> Key properties:
>>
>> - Zero per-object metadata in the production build.
>> - NUMA-aware, with per-socket bins and free-slab pools.
>> - DMA-usable memory with O(1) virt-to-IOVA translation.
>> - Bulk alloc/free with all-or-nothing semantics.
>> - Backing memory never returned during lifetime (slabs recycled).
>> - Non-EAL threads supported (bypass cache, take bin lock).
>>
>> API surface
>> -----------
>>
>>    rte_fastmem_init / deinit
>>    rte_fastmem_reserve
>>    rte_fastmem_set_limit / get_limit
>>    rte_fastmem_alloc / alloc_socket
>>    rte_fastmem_alloc_bulk / alloc_bulk_socket
>>    rte_fastmem_free / free_bulk
>>    rte_fastmem_virt2iova
>>    rte_fastmem_cache_flush
>>    rte_fastmem_max_size / classes
>>    rte_fastmem_stats / stats_class / stats_lcore / stats_lcore_class
>>    rte_fastmem_stats_reset
>>
>> All APIs are marked __rte_experimental.
>>
>> Performance
>> -----------
>>
>> The single-object hot path is roughly 2-3x the cost of mempool
>> and an order of magnitude faster than rte_malloc. Under
>> multi-lcore contention, fastmem scales similarly to mempool,
>> while rte_malloc collapses.
>>
>> Limitations
>> -----------
>>
>> - Maximum allocation: 1 MiB. Larger requests should use rte_malloc.
>> - Power-of-2 classes only; worst-case internal fragmentation ~50%.
>> - Backing memory not reclaimable short of deinit.
>>
>> Future work
>> -----------
>>
>> - Lcore-affine allocations (false-sharing-free by construction).
>> - Mempool ops driver for transparent drop-in use.
>> - Pre-resolved allocator handle binding size class and socket,
>>    eliminating per-call class lookup and enabling an inline
>>    cache-hit fast path.
>> - Debug mode (cookies, double-free detection, poison-on-free).
>> - Telemetry integration.
>> - EAL integration, allowing EAL-internal subsystems to use
>>    fastmem for their small-object allocations.
>>
>> Mattias Rönnblom (3):
>>    doc: add fastmem programming guide
>>    lib: add fastmem library
>>    app/test: add fastmem test suite
>>
>>   app/test/meson.build                  |    3 +
>>   app/test/test_fastmem.c               | 1682 +++++++++++++++++++++++++
>>   app/test/test_fastmem_perf.c          |  997 +++++++++++++++
>>   app/test/test_fastmem_profile.c       |  157 +++
>>   doc/api/doxy-api-index.md             |    1 +
>>   doc/api/doxy-api.conf.in              |    1 +
>>   doc/guides/prog_guide/fastmem_lib.rst |  301 +++++
>>   doc/guides/prog_guide/index.rst       |    1 +
>>   lib/fastmem/meson.build               |    6 +
>>   lib/fastmem/rte_fastmem.c             | 1486 ++++++++++++++++++++++
>>   lib/fastmem/rte_fastmem.h             |  644 ++++++++++
>>   lib/meson.build                       |    1 +
>>   12 files changed, 5280 insertions(+)
>>   create mode 100644 app/test/test_fastmem.c
>>   create mode 100644 app/test/test_fastmem_perf.c
>>   create mode 100644 app/test/test_fastmem_profile.c
>>   create mode 100644 doc/guides/prog_guide/fastmem_lib.rst
>>   create mode 100644 lib/fastmem/meson.build
>>   create mode 100644 lib/fastmem/rte_fastmem.c
>>   create mode 100644 lib/fastmem/rte_fastmem.h
>>
> 
> Largish patchset so did AI review with full claude model.
> 
> Series review: [RFC 0/3] add fastmem allocator
> Reviewed against the v1 RFC posted 2026-05-25.
> 
> 
> [RFC 1/3] doc: add fastmem programming guide
> 
> Info: doc/guides/prog_guide/fastmem_lib.rst -- "\ No newline at end of file"
>     The new RST file does not end with a newline.
> 
> 
> [RFC 2/3] lib: add fastmem library
> 
> Error: lib/fastmem/rte_fastmem.c -- use-after-free during rte_fastmem_deinit()
>     when caches were allocated cross-socket.
> 
>     cache_create() places the cache struct on the *calling thread's* socket,
>     not on the socket the cache serves:
> 
>         unsigned int own_socket = rte_socket_id();
>         ...
>         alloc_socket = &fastmem->sockets[own_socket];
>         cache = bin_alloc_one(&alloc_socket->bins[cache_class]);
>         ...
>         *slot = cache;          /* slot is in socket K's caches[][] */
> 
>     So an lcore on socket S that calls rte_fastmem_alloc_socket(..., K) with
>     S != K creates a cache whose memory lives in socket S's memzone but is
>     reachable through socket K's caches[lcore][class].
> 
>     rte_fastmem_deinit() then walks sockets in index order:
> 
>         for (i = 0; i < RTE_MAX_NUMA_NODES; i++)
>                 release_socket(&fastmem->sockets[i]);
> 
>     and release_socket() does, in this order:
> 
>         socket_release_caches(socket);            /* (1) */
>         for (c...) bin_release(&socket->bins[c], socket);  /* (2) */
>         for (i...) rte_memzone_free(socket->memzones[i]);  /* (3) */
> 
>     When i = S, step (3) frees socket S's memzones. When i = K (K > S),
>     socket_release_caches(K) runs:
> 
>         cache_slab = slab_of(cache);             /* in socket S's freed mz */
>         bin_free_one(cache_slab->bin, cache);    /* reads cache_slab->bin */
> 
>     cache_slab points into a freed memzone, so cache_slab->bin and the
>     subsequent push (slab->free_head = obj; slab->free_count++; in
>     bin_push_locked()) read and write released memory. slab_release() may
>     then re-attach the slab to socket S's free_head, which was zeroed and
>     whose backing is gone.
> 
>     This is triggered by any application that allocates from a non-local
>     socket via SOCKET_ID_ANY fallback or explicit socket_id, which the
>     programming guide describes as a normal mode of operation. The
>     existing test_alloc_socket and test_alloc_socket_numa_placement use
>     rte_socket_id_by_idx(0) (the local socket) so the bug is not
>     exercised by the test suite.
> 
>     Either order the teardown in three phases (all caches across all
>     sockets first, then all bins, then all memzones), or allocate the
>     cache struct from the socket it serves rather than the calling
>     thread's socket.
> 
> Warning: lib/fastmem/rte_fastmem.c -- non-atomic access to shared 64-bit
>     statistics counters.
> 
>     cache->alloc_cache_hits, alloc_cache_misses, alloc_nomem,
>     free_cache_hits, free_cache_misses, and the bin counters
>     slab_acquires, slab_releases, slabs_partial, slabs_full are
>     incremented as plain C reads/writes by the owning lcore and read
>     from another thread via rte_fastmem_stats(), rte_fastmem_stats_class(),
>     rte_fastmem_stats_lcore(), and rte_fastmem_stats_lcore_class(). On
>     architectures where uint64_t is not naturally atomic (and per the C
>     standard generally) this is a data race; even on x86-64 it is
>     undefined behavior under -fsanitize=thread.
> 
>     Use rte_atomic_fetch_add_explicit() with rte_memory_order_relaxed on
>     the producer side and rte_atomic_load_explicit() with relaxed
>     ordering on the reader side. Per AGENTS.md / the DPDK convention,
>     relaxed ordering is appropriate for these counters.
> 
> Warning: lib/fastmem/rte_fastmem.c -- pointer publish in cache_create()
>     without release ordering.
> 
>         *slot = cache;
>         return cache;
> 
>     The struct fields (count, capacity, target, the stats counters) are
>     written before this store but with no fence or release barrier. A
>     concurrent stats reader doing socket->caches[l][c] followed by
>     cache->* could observe the pointer but not all initialized fields.
>     Even ignoring the stats reader, rte_fastmem_cache_flush() invoked
>     from a different lcore on the same cache (not currently possible by
>     API contract, but the field is technically reachable) would race.
>     Pair with rte_atomic_store_explicit(..., rte_memory_order_release)
>     and a matching acquire load on the reader path.
> 
> Warning: lib/fastmem/rte_fastmem.c -- spurious ENOMEM window during slab
>     release.
> 
>     bin_push_locked() removes a fully-drained slab from bin->partial
>     before bin_free_one() drops the bin lock; slab_release() then puts
>     it on socket->free_head under the socket lock. Between the unlock
>     and slab_release(), another lcore allocating in any class on the
>     same socket can see free_head == NULL, hit the memory_limit (or
>     FASTMEM_MAX_MEMZONES_PER_SOCKET) check in grow_socket(), and return
>     ENOMEM even though the slab is about to become available. Not a
>     correctness issue but visible to applications that pin tightly to
>     their limit.
> 
> Info: lib/fastmem/rte_fastmem.c local_socket_id() final fallback:
> 
>         return (unsigned int)rte_socket_id_by_idx(0);
> 
>     rte_socket_id_by_idx() returns int and is documented to return -1 on
>     error. If there are zero configured sockets the cast yields UINT_MAX
>     and fastmem->sockets[UINT_MAX] is out of bounds. Realistically there
>     is always at least one socket, but a defensive check (return 0, or
>     fail allocation explicitly) would avoid the corner case.
> 
> Info: lib/fastmem/rte_fastmem.c cache_pop() refills to cache->target
>     (half capacity) rather than to capacity. Subsequent single-object
>     allocs only get target-1 hits before the next bin trip. Likely
>     intentional for fairness with bulk callers, but worth a comment.
> 
> Info: lib/meson.build inserts 'fastmem' between 'dispatcher' and
>     'gpudev'. The natural alphabetical position is between 'efd' and
>     'fib'; fastmem has no dependency on dispatcher.
> 
> 
> [RFC 3/3] app/test: add fastmem test suite
> 
> Warning: app/test/test_fastmem.c -- REGISTER_FAST_TEST uses NOHUGE_OK
>     but the functional tests need real memzone-backed memory.
> 
>         REGISTER_FAST_TEST(fastmem_autotest, NOHUGE_OK, ASAN_OK,
>                            test_fastmem);
> 
>     test_fastmem runs both the lifecycle suite (no allocations) and the
>     functional suite, which requests 128 MiB IOVA-contiguous memzones.
>     In --no-huge mode IOVA-contiguous reservation of that size is not
>     reliable, so NOHUGE_SKIP is more honest. If you want the lifecycle
>     tests to remain no-huge-friendly, register them as a separate
>     test command.
> 
> Warning: app/test/test_fastmem.c -- the suite never exercises
>     cross-socket cache allocation.
> 
>     test_alloc_socket and test_alloc_socket_numa_placement both use
>     rte_socket_id_by_idx(0) (the local socket). Add a test that runs on
>     a worker lcore whose rte_socket_id() differs from the target
>     socket_id passed to rte_fastmem_alloc_socket(), then calls
>     rte_fastmem_deinit(). This would have caught the deinit UAF above.
> 
> Info: app/test/test_fastmem.c -- several test functions declare an
>     uninitialized `int rc;` that is never read or written (e.g.
>     test_alloc_too_big, test_alloc_invalid_align, test_alloc_free_small,
>     test_alloc_alignment, test_alloc_socket, test_alloc_block_repurposing
>     and others). Drop the declarations.
> 
> Info: app/test/test_fastmem.c trailing blank-line clusters (two blank
>     lines before "return TEST_SUCCESS;" in test_reserve_multiple_memzones,
>     test_reserve_cumulative, test_reserve_invalid_socket,
>     test_reserve_any_socket, test_alloc_too_big, ...). Drop the extra
>     blank line.

Thanks. I've addressed the above issues and the fixes will be available 
as an RFC v2, except:

#2 - Non-atomic stats counters

     Diagnostic counters read cross-thread. On all DPDK-supported
     architectures, aligned uint64_t stores are atomic in practice;
     a torn read (e.g., on 32-bit x86) at worst yields a slightly
     stale counter value. Not worth the ceremony.

#3 - Pointer publish without release ordering

     On weakly-ordered architectures a stats reader could briefly see
     uninitialized counter values for a newly-created cache. Acceptable
     for diagnostic data.

#4 - Spurious ENOMEM window during slab release

     Narrow timing window, not a correctness bug. Closing it would
     require holding the bin lock across slab_release(), reintroducing
     the contention the design avoids.

