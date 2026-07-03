Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39569C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 16:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 581274026F;
	Fri,  3 Jul 2026 18:30:29 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 80AF34026A
 for <dev@dpdk.org>; Fri,  3 Jul 2026 18:30:27 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-66493875766so1007182d50.0
 for <dev@dpdk.org>; Fri, 03 Jul 2026 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783096227;
 x=1783701027; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h15GgS62BlGYCB6/FF95BLegONlkUBS6KHGZoawaldc=;
 b=oaF8InYGjluZJpgvQXeL/GMsKZ6ME1X5arim40JXKP3wdEMdjXDjyst5i0j/E/ihPQ
 5P8g3fWIgjBCanRdoixcpajmfsWch8cozdewVXwKtJ9aNlORin/jFJdnt7DC/I2YVot9
 jrCWI3S+OyC9kttV/98CaGs7hopWX6wBJucaOKoR8nn+9uC4nW73bUyjqsZLsgfuIHpb
 KuDm5+zyeKB1MCs4Z+RA/fl4lx2c/oUPK1mQyr+RPvPzgia+1yeGOWNvzuO2zKfgiSmN
 2C1q9Doei5O6dF+2i2tI2wf28P5PhwhQF3r/uSfRHRq6Ekv0INGhnB7BDOzk2VdiiaW+
 MFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096227; x=1783701027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h15GgS62BlGYCB6/FF95BLegONlkUBS6KHGZoawaldc=;
 b=BAhaZTdbMve1qm3anr9v6ezpHqIwzGNxldKi1cYVYJ2uqxa1/gqXSqQ95hNy8GiPFq
 HrXeEhhEbUYVFj83H3CGSbWO2/SD3mIZTrG9FsljNZ0hFo/eZwrGYhiycSib0KH9yN4Q
 cIBTd2vO8g0yn6CUZaqEHubKOWV3dfpm5i0KHJ9xY81CX9ClMnY4zg79aPHmXMcTR6XX
 +fUPNszaSnu57CBZo9jb1kzChlPsLgqSc8wDHr0y0PQBaDeS0HpCKVOyVUzI8T47K6Rk
 2J3QhCE63MkqXj5bFQSX9GAnlU4AGyuytPsVM5t9HB+tlYOJw5aoUk+buJ/2JMCNxmkv
 zUVw==
X-Gm-Message-State: AOJu0YwdJyM/TCE2mS4MWuuvZxOuutdTxnaH2hhXcFDmOY0s9nT/qD90
 VwQK+B3NnKbTJuBYp+OontV6d4bsZ39qh2LOs64VZ4GyHDE5Ce8nVn57acvNGP4W86I8TAhB4/E
 IC6C5
X-Gm-Gg: AfdE7cl0cQvggC5+PI9ESHj6ZfXfCn+iyYnrPK6uZQl+Xazp0FSGRhZ4LTD7XVOHpdY
 QiTxOB6nDh/SR2QaxrCyFeRyRSr57KeGTDRQE6gbvK51+1SpYmhlosLUzAVoBNllE/IXiBXKnx+
 9cdgEz0EmK+GSph10R84tq3/YX2Ddsx0c/YivlHsdv3EIuB0LbyOekCaEr+03dXb7x+DHVVCYyk
 eS/t5U6w+qBG/ZDtwzBS8wrCMKiIM93Oa9jQy0kw9Ga9iyD8POY6l04DQ1rfczGzhrCvu201dU1
 NLJCkhJfOUNJLMApnYN65lYYvNhwhVq7cFCNnRzWfw65RlscgijXZOxi2hYcFADUExr3LVBZYuB
 1kEVLqEe4FpGFRtAwEMnSqz+gBddr0FUYHc/E03cEL16KNl+lENa/CotmQSlIK0LoOHUKHBuH6D
 QsWW3mj12mKz8C0ldeDQZpyR/oFpZV0022J5X9fBE6xKN59IBNViwW4Q==
X-Received: by 2002:a53:acc7:0:20b0:665:2100:990 with SMTP id
 956f58d0204a3-66650d04ff3mr485510d50.28.1783096226358; 
 Fri, 03 Jul 2026 09:30:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6664080fd56sm988475d50.15.2026.07.03.09.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 09:30:26 -0700 (PDT)
Date: Fri, 3 Jul 2026 09:30:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <hofors@lysator.liu.se>, <mb@smartsharesystems.com>
Subject: Re: [RFC] memtank: add memtank library
Message-ID: <20260703093023.703e545f@phoenix.local>
In-Reply-To: <20260610103918.96857-1-konstantin.ananyev@huawei.com>
References: <20260610103918.96857-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 10 Jun 2026 11:39:17 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> Introduce memtank, highly customizable fixed sized object allocator
> for DPDK applications. It offers close to the mempool level performance
> on the fast path.
> Main difference with the mempool is the ability to grow/shrink at runtime
> with user provided grow/shirnk threshold values, plus some extra
> features for higher flexibility.
> 
> Key properties:
> 
> - relies on user to provide callbacks for actual memory reservations.
>   User is free to choose whatever is most suitable way for his scenario,
>   i.e: via malloc/rte_malloc/mmap/some custom memory allocator.
> - user defined constructor callback for newly allocated objects.
> - bulk alloc and free APIs.
> - different alloc/free policies (specified by user via flags parameter):
>   * lightweight as possible, but can fail
>   * more robust, but heavyweight - causes call to user-provided backing
>     memory allocator.
> - backing memory grows/shrinks on demand, special API extensions
>   to allow user control grow/shrink size, frequency and when/where it
>   is going to happen (DP, CP, both, etc.).
> - ability to pre-allocate all objects at memtank creation time
>   (mempool like behavior).
> - custom object size and alignment.
> - per object runtime statistics and sanity-checks (boundary violation,
>   double free, etc.) can be enabled/disabled at memtank creation time.
> 
> Known limitations (subject for further improvements):
> 
> - scalability:
>   after 8+ lcores conventional mempool (with FIFO) starts to outperform
>   memtank (which uses LIFO inside).
> - mempool_cache integration is not part of the library and right now
>   has to be implemented by used manually on top of memtank API.
> 
> Envisioned usage scenarios within DPDK-based apps:
> various flow/session control structures (TCP PCB, CT, NAT sessions, etc.)
> that needs to be allocated/freed at the data-path.
> Also can be used by 'semi-fastpath' allocations:
> TBL-8 blocks for LPM, hash buckets, etc.
> 
> Initial idea is inspired by Linux/Solaris SLAB allocators.
> Also re-used some ideas from my previous work for TLDK project:
> https://github.com/FDio/tldk
> Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

Lots of good feedback from Fable AI review. Still needs more work.


Thanks for bringing memtank into DPDK proper - dynamic grow/shrink
fills a real gap between mempool and malloc for session-type
structures. The API shape holds up well against the new-library
criteria: handle-based create/destroy, single installed header,
RTE_EXPORT_EXPERIMENTAL_SYMBOL used correctly (26.11 for the next
merge window), and the three callbacks in rte_memtank_prm are the
point of the design rather than a framework smell.

That said, I applied the RFC on 26.07-rc2 and found real bugs.
Items 1-3 were verified at runtime with ASAN/UBSan harnesses
against the applied tree, item 4 with a build.

Errors:

1. Heap buffer overflow in rte_memtank_create() metadata sizing.

memtank_meta_size() reserves no headroom for aligning the user
allocator's return pointer, unlike memchunk_size() which adds
"algn - 1" for exactly this reason. create() then does:

	mt = RTE_PTR_ALIGN_CEIL(p, alignof(typeof(*mt)));

which can advance p by up to 63 bytes into an allocation that only
has 48 bytes of slack (the gap between the offset of mtf.free[]
and sizeof(struct memtank_free)). Nothing documents an alignment
contract for prm->alloc(); with any allocator returning less than
16-byte-aligned memory (32-bit glibc malloc guarantees only 8),
put_free() writes the tail of the free[] cache past the end of
the allocation. Verified with ASAN and an 8-byte-aligned alloc
callback:

  WRITE of size 7680 ...
    #2 copy_objs lib/memtank/memtank.c:101
    #3 put_free lib/memtank/memtank.c:131
    #4 rte_memtank_free lib/memtank/memtank.c:627
  located 0 bytes after 8520-byte region

Fix: mirror memchunk_size(),

	sz = sizeof(*mt) + nb_free * sizeof(mt->mtf.free[0]);
	sz = RTE_ALIGN_CEIL(sz + alignof(typeof(*mt)) - 1,
		alignof(typeof(*mt)));

and document minimum alignment expectations for alloc().

2. Shrink is a no-op: the loop in shrink_chunk() never executes.

memtank.c:234-239:

	k = 0;
	n = 0;
	for (i = 0; i != num && n != k; i += k) {

"n != k" is evaluated before the first iteration with both
variables zero, so the body never runs and the function always
returns 0. Consequently rte_memtank_shrink() and the
RTE_MTANK_FREE_SHRINK flag never release memory. Verified at
runtime: with all chunks on the FULL list and nb_free == max_free,
rte_memtank_shrink() returns 0 and the free() callback is never
invoked; memory is only released by destroy(). The condition
should presumably be "n == k" (continue while the previous batch
was fully satisfied, stop when _shrink_chunk() drains the FULL
list). Note this also means the stress test exercises none of the
shrink paths, despite reporting shrink statistics.

3. Misaligned struct memobj access when obj_align < 8.

check_param() accepts any power-of-two obj_align including 1 and
2, but the per-object trailer (two uint64_t red zones plus a
pointer) is placed at obj + obj_sz - sizeof(struct memobj), which
is only 8-byte aligned when the object stride is. With obj_align=2
and obj_size=5, UBSan traps on the first grow:

  memtank.c:86: runtime error: store to misaligned address ...
  for type 'struct memobj', which requires 8 byte alignment

Undefined behavior, and a fault on strict-alignment targets. Fix:
round obj_align up to alignof(struct memobj) inside create(), or
reject smaller values in check_param(). The shipped unit test uses
obj_align=2 and only avoids the trap because obj_size=0 keeps the
stride a multiple of 8.

4. Build failure: VLA in the stress test.

test_memtank_stress.c:425:

	uint8_t buf[sz];

DPDK's default warning flags include -Wvla, so CI builds with
werror=true fail here. sz can also reach OBJ_SZ_MAX (1MB), which
is unfriendly to thread stacks regardless. Use a fixed-size buffer
with a bounded compare loop, or allocate once per worker.

Warnings:

5. mt->obj_size truncation for very large objects. memobj_size()
returns size_t but is stored into uint32_t (memtank.c:561). With
obj_size near UINT32_MAX the padded per-object size wraps, so
init_chunk() strides with a truncated value while chunk_size is
computed with the full one - corruption instead of EINVAL.
check_param() should bound obj_size.

6. Deprecated API in new test code: rte_atomic64_t/rte_atomic64_*
(test_memtank_stress.c:33-39) and rte_smp_rmb()/rte_smp_mb()
(:542, :616, :678, :686). New code should use
rte_atomic_*_explicit() with rte_memory_order_*. Related: wrk_cmd
(:127) is a plain uint32_t shared between the control lcore and
workers; it should be RTE_ATOMIC(uint32_t) with release store /
acquire load rather than bare access plus full barriers.

7. master/slave terminology throughout the stress test
(struct master_args, MASTER_FLAG_*, test_memtank_master, "launch
on all slaves"). DPDK uses main/worker; this was purged tree-wide
in 20.11 and must not be reintroduced.

8. __rte_cache_aligned placement. memtank.h:40,48,62 and
test_memtank_stress.c:97 use the old trailing form
"} __rte_cache_aligned;"; current convention is
"struct __rte_cache_aligned foo {" (MSVC-compatible position, see
rte_mempool.h). wrk_cmd applies the attribute to a variable - use
"static alignas(RTE_CACHE_LINE_SIZE) uint32_t" there.

9. meson.build declares deps += ['ring', 'telemetry'] but the
library uses neither (the ring is only in the test app, which has
its own dep entry). The empty extra_flags loop is dead boilerplate.

10. Callback contracts are undocumented. alloc/free/init can be
invoked concurrently from multiple lcores (any thread can trigger
grow or shrink), so they must be MT-safe. Worth stating in the
rte_memtank_prm doxygen, along with alignment expectations and
that alloc() need not zero memory.

11. Documentation needs a pass before leaving RFC:
- memtank_lib.rst uses markdown triple backticks (22 occurrences),
  which RST renders literally; use ``inline literals``.
- The create/destroy example does not compile: "sruct", semicolons
  instead of commas inside the designated initializer, and
  "user_define_free" vs the defined "user_defined_free".
- Typos in the rst and header doxygen: "Same a s mempool", "Aled
  public API", "ret_memtank_free", "rte_memetank_destroy",
  "memntank", "pooll", "susbystem", "udnerlying", "thershold",
  "maximimum", "statisitics", "insteance", "intitialize".
- rte_memtank.h:32 says the lists are "(USED, FREE)" but the
  code's states are FULL and USED.
- misc.c:233 dump output has a stray comma: "[USED]={,".
- rte_memtank_chunk_free() doxygen for nb_obj says "Number of
  objects to allocate".

12. Missing MAINTAINERS entry and release notes for a new library
(fine to defer for an RFC, needed for the real submission).

Info:

13. extern "C" opens before the #includes in rte_memtank.h;
current convention wraps only the declarations, after all includes
(see rte_mempool.h, rte_argparse.h). Include order is also
inverted (stdio.h after the rte_ headers).

14. RTE_MTANK_ALLOC_CHUNK is never tested by the implementation -
rte_memtank_alloc() gates the chunk path on "flags != 0", so any
future flag silently implies chunk allocation. Either test the
flag explicitly or document that any flag enables the chunk path.
