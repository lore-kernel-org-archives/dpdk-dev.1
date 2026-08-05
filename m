Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBCEC55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 15:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4FEC402AC;
	Wed,  5 Aug 2026 17:37:12 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 704F94021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 17:37:11 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so793489a91.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785944230;
 x=1786549030; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K39ZmB9aUyQUiCGL3RuVHTtoteZAuSa3Luip5BZWscQ=;
 b=jVT5+hIH8JdlW09hx689JnxWm34r0oMD5DmZ2s/drMoeAQL0ijDdxoSwrzhc8ejQMK
 X99L/DsBL58SHaqH/7pRIg9vZS8XS3X0ogvSRojiP88OLhgNK4GzokyhV4sCfTSVvZgh
 pKCDJg92ErJtvbgoPWLR5By9A9yVq/HMvbq5YPMj7EQxnm7Di7ioRH3fhBuuVJU8Zjgv
 lwJGdih8n17uHUi8FJe8TQF58yeKJ9jBhFDoOJbHhONDCmaMFa5Iui1qFXdMQzMhlRwM
 dGnqN/hRiGGdbVr95zzR0qAbknrzDBvWBnmGZSx1O+uAWenNdXTercQ1483Bilfxnnxi
 f7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944230; x=1786549030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K39ZmB9aUyQUiCGL3RuVHTtoteZAuSa3Luip5BZWscQ=;
 b=eI5R7EX9jUPrT049Lvj6nEzblQTt3luyFrS1fzfm9M1fvRlBQPR4Uydr8BvbGdSVpO
 Fx3HSaXgyUVn6LqmhQ9uMstN0psy5+KMe8vOs07FustxCYgsjV14d7A6WNjVCx8ftqf2
 TMBzYQH1Eb84GMgmWDwukpBUujaDK+0FUpBxTf6l707YEWSFzXoemXBDE8I+ml+FeKKi
 6iS+HlM7FNzVQbQ4pNKfyuyW+3slgnDgokoIdKhu5ZFLSVCOQdKn4rWTQedf1SNT787s
 O6h9s4AY06VVGKPinGybjkZ8l4Rwj8fnD1hmEZgim4HasWTT12knIeBpjTyIm8kRPkGu
 f7yA==
X-Gm-Message-State: AOJu0Yw6+lXSI3xIUYeEQ11rb/6iYAQV5eWtWmRFL3haocBFq90yO2WM
 3pCBPvJmGJswNUKIPO/ItKCHykhonX4L4BXoPCYYigQIpm60lpfYTqNivBPetw63DZ24rcKuRsY
 mMXSz
X-Gm-Gg: AR+sD1128xBXdVScgcfEm9JvnPr8VsgBktbpXNFnYoH1uoPuJBl+vfGohFFvWfv8LVk
 tu4qAeQP7M0+8D6GxEZUhPyTwss4KSL9YkSiTt6LdBOPtFNxh+0BwLWPUbxuUUO+NcKRoMf67VS
 JzNyIiDvSoSwSk86d3F8E3ewMFWgCWb2jUl7AtyHHgCNQXk+8xzytv4dJM9EFEAykflNxQAiWix
 BNvcz6Nqvh/Z78T5NwserZ2wtPDBG9MNP5H1hphPB1PluiZHCl6AWt95vF4gFDPDfcBAHHdPUsY
 iFe8NySM6ICecijW1tzEQlrPNchu10xYwRKhXRjFZjPSnjuAiMFZeLjWApqiFMq4ZCVEvO/uibI
 qJpltwfKn0wF/cuzMdcsVrUDLgU5PXiG4rwP/fC5/VZnG/E2CTk3zuff1PVjf58QgNB6xG1HmOk
 nN796TwlLKTo/eDGaS6MzxCcvxZWsLgCgO8mlVBYphw9R6PK/7wHOFGUW18Kf7OLcd9oLdtR+8r
 72dRWvS995Md6ipsFFzWvSkdgsXRJo=
X-Received: by 2002:a17:90b:2d50:b0:38f:1f8:1fa with SMTP id
 98e67ed59e1d1-3903c5ca8c2mr8256289a91.15.1785944230053; 
 Wed, 05 Aug 2026 08:37:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673b7b2sm18011404eec.19.2026.08.05.08.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:37:09 -0700 (PDT)
Date: Wed, 5 Aug 2026 08:37:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <mattias.ronnblom@ericsson.com>
Subject: Re: [RFC v2] memtank: add memtank library
Message-ID: <20260805083704.005d1c76@phoenix.local>
In-Reply-To: <20260805123305.90059-1-konstantin.ananyev@huawei.com>
References: <0260610103918.96857-1-konstantin.ananyev@huawei.com>
 <20260805123305.90059-1-konstantin.ananyev@huawei.com>
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

On Wed, 5 Aug 2026 13:33:01 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> v2:
> - Addressed majority of AI review comments (except 11, 12,14):
>   https://patchwork.dpdk.org/project/dpdk/patch/20260610103918.96857-1-konstantin.ananyev@huawei.com/#185014
> - Still missing integration/common tests with fastmem RFC:
>   https://patchwork.dpdk.org/project/dpdk/list/?series=38273
> 
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

More detailed AI review (Claude Opus 5):

Review of [RFC v2] memtank: add memtank library

Errors

lib/memtank/memtank.h
  TAILQ_ENTRY/TAILQ_HEAD and friends are used without including
  <sys/queue.h>.  This only compiles because rte_common.h pulls in
  rte_os.h, and only the Linux and FreeBSD rte_os.h include <sys/queue.h>.
  The Windows rte_os.h does not; it only defines the RTE_TAILQ_* wrappers.
  As written the library will not build on Windows, and nothing in
  lib/memtank/meson.build excludes it there.
  Use RTE_TAILQ_HEAD(), RTE_TAILQ_ENTRY(), RTE_TAILQ_FIRST() and
  RTE_TAILQ_NEXT() as the rest of DPDK does, and add an explicit
  #include <sys/queue.h> for the macros that have no RTE_ wrapper
  (TAILQ_INIT, TAILQ_REMOVE, TAILQ_INSERT_*, TAILQ_CONCAT, TAILQ_LAST).

lib/memtank/memtank.h
  struct memtank_free ends in a flexible array member and is then embedded
  as struct rte_memtank::mtf.  C11 6.7.2.1p3 forbids a structure containing
  a flexible array member from being a member of another structure.  GCC and
  clang accept it as an extension, MSVC warns (C4200).  Either move the
  free[] array out of the struct and store a pointer plus the trailing
  allocation, or make memtank_free the outer object.

lib/memtank/rte_memtank.h
  The object constructor callback returns void:

      void (*init)(void *obj[], uint32_t num, void *udata);

  Object construction can fail (sub-allocation, lock init, device handle),
  and there is no way for the user to report that.  init() is also called
  from init_chunk() with no error path back to grow_chunk().  Give it an
  int return and propagate the failure out of rte_memtank_grow() /
  rte_memtank_chunk_alloc().

  Related: there is no destructor callback to pair with init().  Objects
  constructed in init_chunk() are silently discarded when _shrink_chunk()
  or rte_memtank_destroy() hands the raw chunk back to prm.free(), so any
  per-object resource the constructor acquired is leaked.  For a library
  whose selling point is runtime shrink, this needs an answer.

lib/memtank/memtank.c
  rte_memtank_grow() and rte_memtank_shrink() read mt->mtf.nb_free without
  holding mtf.lock:

      k = t->min_free - t->nb_free;
      ...
      if (t->nb_free < t->max_free)

  nb_free is written under that lock in get_free()/put_free().  This is a
  data race; the effect is benign (a threshold heuristic) but it is
  undefined behaviour and TSan will flag it.  Either take the lock for the
  read or make nb_free an RTE_ATOMIC() with a relaxed load.

lib/memtank/memtank.c
  rte_memtank_alloc() gates the chunk path on "flags != 0" rather than on
  RTE_MTANK_ALLOC_CHUNK:

      if (n != num && flags != 0)

  RTE_MTANK_ALLOC_CHUNK is defined in the public header and never
  referenced anywhere in lib/.  Any undefined flag bit therefore behaves as
  ALLOC_CHUNK.  Test the flag explicitly, and reject unknown bits.

app/test/test_memtank_stress.c, test_memtank_cleanup()
  The accumulated worker exit codes are discarded:

      rc = 0;
      RTE_LCORE_FOREACH_WORKER(lc) {
              rc |= rte_eal_wait_lcore(lc);
              ...
      }
      ...
      rc = rte_memtank_sanity_check(mt, 0);   /* overwrites */

  A worker that failed its content check during cleanup is reported as
  success.  Should be "rc |=".

app/test/test_memtank_stress.c, test_memtank_worker()
  rc is declared uninitialized and only assigned inside the two
  "if (num != 0)" blocks.  num is rte_rand() % BULK_NUM and can be zero for
  both alloc and free on a given iteration.  If the loop exits after such
  an iteration, the function returns an uninitialized value.  Initialize
  rc = 0.

doc/api/doxy-api-index.md
  [memcpy](@ref rte_memcpy.h) was the last entry in the memory group and
  has no trailing comma.  The new line is appended after it without adding
  one, so the two entries run together in the rendered index.  Add the
  comma to the memcpy line.

doc/guides/prog_guide/memtank_lib.rst
  Markdown triple backticks are used throughout instead of RST inline
  literals, e.g. ```rte_memtank_create()``` and one instance of
  ```RTE_MTANK_FREE_SHRINK````.  RST wants double backticks; as written
  Sphinx emits inline-markup warnings and the extra backticks appear in the
  output.  With -Dwerror this fails the docs build.

  Several bullet continuations are not indented, which terminates the list
  and produces a block quote instead:

      * ```rte_memtank_create()```/... are responsible for
      creation/destroying the memntank.

  Same at the rte_memtank_grow() and rte_memtank_shrink() bullets.

doc/guides/prog_guide/memtank_lib.rst, Create/Destroy example
  The example does not compile and would not work if it did:
   - "sruct user_defined_type;"
   - .obj_size and .obj_align initializers are terminated with ';' instead
     of ','
   - .free = user_define_free, but the function is user_defined_free
   - .max_obj is never set, so it is 0, while .max_free is 1024 * 1024.
     check_param() rejects max_free > max_obj, so rte_memtank_create()
     returns NULL with EINVAL.

Warnings

Process
  No entry added to doc/guides/rel_notes/release_26_11.rst.  A new library
  needs a "New Features" item.

  No MAINTAINERS entry for lib/memtank; devtools/check-maintainers.sh will
  report it as unmaintained.

lib/memtank/memtank.c, misc.c
  The advertised double-free and boundary detection does not cover the
  fast path.  obj_dbg_alloc()/obj_dbg_free() are only called from
  rte_memtank_chunk_alloc()/rte_memtank_chunk_free().  Objects that go out
  through get_free() and come back through put_free() never touch the
  nb_alloc/nb_free counters, so an application that frees the same object
  twice simply gets it into mtf.free[] twice, and both copies still satisfy
  memobj_verify(mo, 1).  The commit message and the doc both claim double
  free detection without qualification.  Either extend the checks to the
  cache path or scope the claim.

lib/memtank/memtank.h
  struct memobj is 32 bytes and is appended to every object unconditionally.
  With RTE_MTANK_OBJ_DBG clear, only the 8-byte chunk pointer is used; the
  two red zones and the dbg counters are pure overhead.  The stated use case
  is "relatively small objects" and flow/session structures, where 32 bytes
  per object is a large tax.  Consider making the layout depend on the flag.

lib/memtank/memtank.c
  nb_chunks uses rte_memory_order_acq_rel on both fetch_add and fetch_sub.
  It is a plain counter with no data published through it; relaxed is
  sufficient and is what rte_memtank_dump()/sanity_check() already use for
  the load.

lib/memtank/memtank.c, put_chunk()
  The only bound on the write into ch->free[] is RTE_ASSERT(), which is
  compiled out unless RTE_ENABLE_ASSERT.  In a normal build a double free,
  or a pointer that is not from this memtank, overruns the chunk's free
  array into object memory with no diagnostic.  Since OBJ_DBG does not
  catch the cache path either (above), there is no configuration in which
  this is reliably detected.

lib/memtank/memtank.c, check_param()
  prm->obj_size is not validated.  A memtank with obj_size 0 is accepted;
  test_memtank.c's create_invalid case relies on that.  Reject 0, or
  document that it is meaningful.

  Also, obj_align must be a non-zero power of two, but rte_memtank_prm's
  Doxygen does not say so; 0 is a natural "don't care" value for a caller
  and is rejected.

app/test/test_memtank_stress.c, update_global_cfg()
  max_obj = wrk_max_obj * rte_lcore_count() = 64 * nb_lcores by default,
  while mtnk_prm.max_free is 32 * BULK_NUM = 1024.  check_param() rejects
  max_free > max_obj, so rte_memtank_create() fails and the stress test
  reports -ENOMEM on any host with fewer than 16 lcores.  Derive max_obj
  from max_free, or clamp.

app/test/test_memtank_stress.c
  - struct memtank_arg arg[RTE_MAX_LCORE] is on the stack; 256 bytes per
    entry, and RTE_MAX_LCORE is configurable well above the default 128.
  - rte_ring_enqueue_bulk() and rte_ring_dequeue_bulk() return values are
    ignored in test_memtank_worker() and test_worker_cleanup().
  - test_memtank_mt() returns early when fill_worker_args() fails partway
    through the loop, leaking the rings created for earlier lcores.
  - parse_opt() lets a later successful option overwrite an earlier
    parse failure, so bad input is silently accepted.

app/test/test_memtank.c
  memtank_alloc_test() and test_memtank_create_invalid() return via
  RTE_TEST_ASSERT_* without calling rte_memtank_destroy(), leaking the
  memtank (and its chunks) on every failure path.

lib/memtank/meson.build
  extra_flags is empty and the foreach over it is dead code.  Drop both.
  sources and headers are short lists; DPDK style puts those on one line.

doc/guides/prog_guide/memtank_lib.rst
  - ".. figure:: img/memtank_internal.svg" should use the wildcard form
    "img/memtank_internal.*".
  - The figure has no caption, and the _figure_memtank-internals label is
    never referenced.
  - The doc calls the two chunk lists USED and FREE; the code calls them
    MC_USED and MC_FULL.  Pick one.
  - The min_free / max_free bullets and the alloc-flag bullets are
    term/description pairs and read better as RST definition lists.
  - Non-ASCII en-dash on the "built-in per object runtime verify" line.
  - Typos: "Same a s mempool", "memntank" (x4), "rte_memetank_destroy",
    "ret_memtank_free", "pooll", "miscelanneous", "cheking", "Aled public
    API", "relased", "shrinked", "statisitics", "maximimum", "thershold",
    "theshold", "udnerlying", "susbystem", "It's internals", "how many
    memory", "by used manually", "As used needs".

doc/guides/prog_guide/img/memtank_internal.svg
  No newline at end of file.  It is also a single 9.8 KB line exported from
  Office, referencing Calibri and Wingdings with private-use glyphs that
  will not render off Windows.

lib/memtank/misc.c
  %zx is used to print uintptr_t values (p[i], align) in mobj_bulk_check().
  Use PRIxPTR.

lib/memtank/rte_memtank.h, memtank.c
  Include ordering: rte_memtank.h has <stdio.h> after the rte_ headers, and
  memtank.c puts the local "memtank.h" before the rte_ headers.  DPDK order
  is system, EAL, DPDK libs, local.

lib/memtank/rte_memtank.h
  Doxygen typos in the public header: "Same a s mempool", "intitialize",
  "insteance", "initialiaze", "A pinter to the file", "concurently"
  (x2), "inconsitency".  These land in the published API docs.
  The commit message has "shirnk".

Info

lib/memtank/memtank.c
  memtank_meta_size(), memchunk_meta_size(), memobj_size() and
  memchunk_size() each declare an unused "static const struct X *p" purely
  to feed sizeof/alignof.  Use the type directly and drop the statics.

  ALIGN_MUL_CEIL(v, mul) is a ceiling divide, but RTE_ALIGN_MUL_CEIL in
  rte_common.h rounds up to a multiple.  Same name, different meaning, in
  the same translation unit.  Rename it, e.g. CEIL_DIV().

  rte_memtank_grow(): "k = t->min_free - t->nb_free; if ((int32_t)k <= 0)"
  is an unsigned subtract cast back to signed.  "if (t->nb_free >=
  t->min_free) return 0;" says the same thing.

  rte_memtank_shrink() only reclaims chunks from the MC_FULL list and never
  drains the free cache, so a memtank whose objects are all parked in
  mtf.free[] will sit at nb_free == max_free and return 0 forever.  The
  limitation is noted in the doc; worth also noting on the API.

  max_chunk = ceil(max_obj / nb_obj_chunk), so the actual object ceiling is
  max_obj rounded up to a chunk boundary.  Document that max_obj is
  approximate.

  rte_memtank_alloc()/free() do not check for a NULL tank while dump() and
  sanity_check() do.  Fine either way, but be consistent and say which in
  the Doxygen.

lib/memtank/misc.c
  mobj_bulk_check(): "k = ((mt->flags & RTE_MTANK_OBJ_DBG) != 0) & fmsk;"
  uses bitwise & on two logical values.

  rte_memtank_dump() prints "\t[USED]={,\n" - stray comma.

  mfree_stat_collect() returns silently when malloc() fails, and the caller
  then prints an all-zero free_stat block as if it were real.

  ptr_cmp() is correct but obscure; qsort on uintptr_t is clearer as
  "(v1 > v2) - (v1 < v2)".

lib/memtank/rte_memtank.h
  RTE_MTANK_DUMP_END is an implementation detail ("first not used power of
  two") exposed in a public enum.  Compute RTE_MTANK_DUMP_ALL from the
  named flags instead.

app/test/test_memtank_stress.c
  check_fill_objs() passes the lcore id into a uint8_t fill pattern, so
  lcores above 255 collide.  Its static rte_spinlock_t dump_lock is never
  rte_spinlock_init()'d; it works because zero is unlocked, but say so or
  initialize it.

app/test/test_memtank.c
  test_free() does "return free(buf);" from a void function.  The comment
  "min_obj is 0 so this is expected to fail" refers to a field that does
  not exist.

No Reviewed-by: this is an RFC and there are open errors above.

General comment on direction: the design is sound and the chunk/LIFO split
is clean, but the two things that most need settling before a non-RFC
posting are (1) the init callback contract - a void constructor with no
destructor cannot support the flow/session use case the cover letter aims
at, and (2) what the OBJ_DBG mode actually guarantees, given that the fast
path bypasses it entirely.
