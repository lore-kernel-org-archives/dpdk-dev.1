Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025BC55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 15:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CE5940269;
	Sun,  2 Aug 2026 17:22:45 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id F2FAF400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 17:22:40 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-81e69a2db34so38185607b3.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785684160;
 x=1786288960; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWFYBK4LZChu+hNhC+m56Svdt+I4Al4Zl7usH0oFdnM=;
 b=QagvC4RtMdCVci7vyr3ECA7bshV2RTxMA7OgbDaiG3FRxsdhxjMdC5dDaDSzYIRlS9
 l69b+pB8ifBLbR6ICg39LwVuvM7zl65RTtjevJ2JpTUw2OhyrZ884KAk0E8PzBh5t64M
 /vhpvHpYXRKnqJJFkBktBiPDURVYamgLv5KV6bLooxOq1Lxm2uZ57r8VnCxrfclxOQ6H
 EkZH6rDH48axXeH+5V3MltsHmwFVxDEX9lxelrtd9S8ZEXMK/cHlhX/RoCc6LwmSKb4d
 GQfYEdvgZ/llojiBFhKkwiVLijhIK1sDh5YvG4tx8LSAONcectLP+RCW8ENeCfiXFlKn
 yNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785684160; x=1786288960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWFYBK4LZChu+hNhC+m56Svdt+I4Al4Zl7usH0oFdnM=;
 b=Nt7ZPVNclRXYpsDfn4rG1djKyN/ivwtEUn85KsBlZGRsR9w7c7mPRIVo57Qe+pK5EK
 SJzH+anqguZQpbtAH7l3VUhsGVR2skTJFyUyVuEaF9srxbrfBGM+TptQ6larDmrMkz5J
 V9+jLOV3k50yG/Yie3M5RiKwwn6zDVcOK5xEhYLgZ8KmbLxXQAcmCIq3P33DNTSyC1rR
 3HCZMzCHo5d2YmYLI0eEu2GNmuIwNh6BnIxD6i/rj/fo6kFFl1SaLDgMFwNFDW95kDv9
 lnkqNuVz5iGQjV0cR/59+64WW3y2VNMxipDpftr+YNNYrJB6OHAfruSYAYnxive6VA0b
 mRlw==
X-Gm-Message-State: AOJu0Yw2PqKyW8JAQLgFWLh0jwCuNCFV3QC4vqCb0aA3qfAFS7PjEsQO
 ivOMMY5LSTLDICTwCbJ77QWttMAwUUSgb51dYZQGAFmyywP+o44MpvEynd9f5CKOM3iT+yIjfWs
 g7aCTh/A=
X-Gm-Gg: AR+sD12lOyOnNyzo/8ASnMqR6XJ2fq+Fgtvk3vc7eUuL3Gxpg/y7iV2MNC+QbS2WlYH
 BJJyX8MefGvvKBBCpgQ+7ezNEg+61C956Z5p6fW30iLAp+RRsKzaapP2LjSr/jKGhEU066tnxgW
 W3dYoUUCIfJ9His7eduQxTIxtAlvOjdTF1bTilqQvPx+oEcBbts3WFTEO/bDvJZGP9+oedqMDnB
 NzG2F9k9BiC2nKzUoSts7ZFd1qt97frypSqhaoH4/+QukaH3EHfbXQAHAMvwTkEZGQgAPlh5t78
 IbjLkGjqhL69MGxCq4T9K9IeXlNOPOdxKh95/lCXVTgrRD+olyeQzMRRbOqva1mEl4OqWlV0hFs
 LCHRaU3dy5hYeL+mi7mYD3Hemz/H6GpxStTBHwC4GrbvCAAEAKr3KOkNWsDy9y1YMYzCCfk+T1v
 4cxf9dDXD8OEf0tBUsp9ahyFGW0RW8yf8R52+kItJ/eXYMMy/REoDrJk1uEeAUMxBQVF396Ou8C
 bdbGL+NxtBY1RJEiIiA6IMJ2SvfvlhaYXMQdA+G
X-Received: by 2002:a05:690c:450a:b0:809:9422:8c47 with SMTP id
 00721157ae682-81fd4b5a2e1mr94118407b3.22.1785684159758; 
 Sun, 02 Aug 2026 08:22:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fccf2e4f5sm42080887b3.3.2026.08.02.08.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 08:22:39 -0700 (PDT)
Date: Sun, 2 Aug 2026 08:22:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v6] pile stack and mempool driver
Message-ID: <20260802082235.3aef3964@phoenix.local>
In-Reply-To: <20260802095954.1098479-1-mb@smartsharesystems.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
 <20260802095954.1098479-1-mb@smartsharesystems.com>
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

On Sun,  2 Aug 2026 09:59:54 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Early submission of:
> - some mempool optimizations,
> - a new mempool "pile" driver, and
> - its underlying "pile" stack implementation.
>=20
> For community feedback and CI test.
>=20
> Needless to say, this must be separated into a series of patches.
> For now, I'm submitting a snapshot of work in progress.
>=20
> Some performance numbers from mempool_perf_autotest_2cores, all
> with cache=3D1024 cores=3D2 n_keep=3D32768:
>=20
> start performance test (using ring_mp_mc, with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D 753985338
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D 755805913
>=20
> start performance test for lf_stack (with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D  29132352
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D  29276708
>=20
> start performance test for pile (with cache)
> n_get_bulk=3D 64 n_put_bulk=3D 64 constant_n=3D0 rate_persec=3D 560159479
> n_get_bulk=3D256 n_put_bulk=3D256 constant_n=3D0 rate_persec=3D 557910933
>=20
> Hat tip to Bruce for bringing attention to the ring not being the
> optimal mempool driver.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Since relatively complex, did AI review with more advanced model.

Review of [RFC PATCH v6] pile stack and mempool driver

Errors

1. lib/stack/rte_stack_pile.h, __rte_stack_pile_pop()

The bulk retry loop breaks the invariant that the fragmentation path
depends on (n_solo < RTE_STACK_PILE_BULK_SIZE):

	n_solo +=3D RTE_STACK_PILE_BULK_SIZE;
	n_bulk--;
	if (n_bulk > 0)
		goto bulk;
	else
		goto solo;

Each retry adds a whole bulk worth of objects to n_solo, so control can
reach the "solo:" label with n_solo >=3D RTE_STACK_PILE_BULK_SIZE (up to n).
If the solo pop then fails and the fragmentation path is taken, four
things go wrong:

 - __rte_assume(n_solo < RTE_STACK_PILE_BULK_SIZE) is false, which is
   undefined behavior.

 - the copy loop

	for (i =3D 0; i < n_solo; i++)
		obj_table[n_bulk * RTE_STACK_PILE_BULK_SIZE + i] =3D obj_frag[i];

   reads past the end of obj_frag[RTE_STACK_PILE_BULK_SIZE] whenever
   n_solo > RTE_STACK_PILE_BULK_SIZE.

 - RTE_STACK_PILE_BULK_SIZE - n_solo underflows for n_solo > BULK_SIZE,
   so free_solo is asked for ~4 billion elements.

 - for n_solo =3D=3D RTE_STACK_PILE_BULK_SIZE exactly, the request becomes
   a zero-element pop:

	solo_first =3D __rte_stack_lf_pop_elems(&pile->free_solo, 0, NULL, &solo_l=
ast);

   __rte_stack_lf_pop_elems() with num =3D=3D 0 never enters the traversal
   loop, so it leaves *last untouched and returns old_head.top, which is
   non-NULL whenever free_solo is not empty. solo_last is therefore still
   NULL when

	__rte_stack_lf_push_elems(&pile->solo, solo_first, solo_last, 0);

   executes "last->next =3D old_head.top", i.e. a NULL pointer write.  It
   also splices free_solo's current head onto pile->solo.

Reachable path with BULK_SIZE 32: pop of 64 objects, pile->bulk holds
one element, pile->solo empty, free_solo non-empty.  The pop of 2 bulks
fails (n_solo becomes 32, n_bulk 1), the pop of 1 bulk succeeds, the
solo pop of 32 fails, and the fragmentation path is entered with
n_solo =3D=3D 32.

The fragmentation path only makes sense for a partial bulk.  After the
retry loop, split n_solo back into whole bulks plus a remainder and
service the whole-bulk part from pile->solo (or fail), keeping the
fragmentation path bounded to n_solo < RTE_STACK_PILE_BULK_SIZE.

2. lib/stack/rte_stack_pile.h, __rte_stack_pile_pop()

	__rte_assume(RTE_STACK_PILE_BULK_SIZE - n_solo < RTE_STACK_PILE_BULK_SIZE =
- 1);

Off by one: with n_solo =3D=3D 1 the left side is BULK_SIZE - 1, and
"BULK_SIZE - 1 < BULK_SIZE - 1" is false.  A false __rte_assume() is
undefined behavior.  Should be "< RTE_STACK_PILE_BULK_SIZE".

3. app/test/test_stack.c, test_stack_push_pop()

	if (memcmp(&obj_table[i],
			&popped_objs[STACK_SIZE - RTE_STACK_PILE_BULK_SIZE - i],
			RTE_STACK_PILE_BULK_SIZE) !=3D 0) {

memcmp() takes a byte count, but RTE_STACK_PILE_BULK_SIZE is an object
count.  Only the first 4 pointers of each 32-pointer bulk are compared
on a 64-bit build.  Needs
"RTE_STACK_PILE_BULK_SIZE * sizeof(void *)".

4. lib/mempool/rte_mempool.h, rte_mempool_do_generic_put()

	const size_t move =3D RTE_ALIGN_MUL_CEIL(
			sizeof(void *) * (cache->len - cache->size / 2), 32);
	rte_memcpy(cache->objs, __rte_assume_cache_aligned(&cache->objs[cache->siz=
e / 2]),
			move);

Both the alignment hint and the rounded-up length are only valid when
cache->size is a multiple of 32.  rte_mempool_create_empty() now enforces
that, but rte_mempool_cache_create() is unchanged and still accepts any
size in 1..RTE_MEMPOOL_CACHE_MAX_SIZE.  A user cache of, say, size 100
gives &objs[50] at a 400-byte offset, and __builtin_assume_aligned() is
then told a false precondition - the compiler may emit aligned vector
loads and fault.  Either apply the same rounding/rejection in
rte_mempool_cache_create(), or drop the alignment hint.

Warnings

5. ABI and API changes without deprecation notices

deprecation.rst currently covers only the flushthresh field and the
oversize objs array.  The patch additionally changes:

 - struct rte_mempool: local_cache from pointer to inline
   local_cache[RTE_MAX_LCORE] array
 - removal of the RTE_MEMPOOL_HEADER_SIZE() macro
 - RTE_MEMPOOL_CACHE_MAX_SIZE 512 -> 1024
 - RTE_MEMPOOL_MAX_OPS_IDX 16 -> 32, which changes the size of the
   exported rte_mempool_ops_table variable
 - cache_size must now be a multiple of 32

The two existing deprecation entries should also be removed by this
patch once they are implemented.

6. lib/mempool/rte_mempool.h - mempool header footprint

With local_cache[] inline and RTE_MEMPOOL_CACHE_MAX_SIZE at 1024, the
header is roughly RTE_MAX_LCORE * 8.3 KB, i.e. about 1 MB per mempool,
and it is now allocated (and memset) unconditionally.  Previously
RTE_MEMPOOL_HEADER_SIZE(mp, 0) omitted the array entirely for mempools
created with cache_size =3D=3D 0, which is common for control-object pools.

7. lib/mempool/rte_mempool.c, rte_mempool_create_empty()

	if (cache_size & 31) {
		unsigned int rounded =3D RTE_ALIGN_MUL_FLOOR(cache_size, 32);

Any requested cache_size below 32 is silently rounded to 0, disabling
the cache.  The doxygen change in rte_mempool.h says the argument "must
be divisible by 32", which reads as a rejection, not a silent rounding -
doc and code disagree.  The log messages should also print the requested
and effective values, and "divisble" is misspelled.

8. app/test/test_stack.c

The excess-push test is wrapped in "#if 0 /* FIXME ... */".  That
removes coverage for the standard and lock-free stacks as well, and it
is exactly the test that would exercise the pile capacity behavior in
item 9.  Dead code should not be committed; either fix the
-Warray-bounds trigger (a runtime-computed size in a volatile variable
is usually enough) or drop the block and note the gap in the commit
message.

9. lib/stack/rte_stack_pile.c, rte_stack_pile_init()

The pile is initialized with ceil(count / BULK_SIZE) bulk elements plus
count solo elements, so it can hold up to roughly 2 * count objects,
above the declared capacity.  __rte_stack_pile_count() only hides this
by clamping with RTE_MIN(s->capacity, ...).  rte_stack_push() is
documented to fail when there is insufficient space; either enforce the
capacity or document that the pile does not.

10. lib/stack/rte_stack_pile.c

rte_stack_pile_init() derives the element base from
"(&s->stack_pile + 1)" while rte_stack_pile_get_memsize() sizes it from
"sizeof(struct rte_stack)".  These agree only because rte_stack_pile
happens to be the largest member of the union in struct rte_stack.  If
another member grows, init() writes past the memzone with no diagnostic.
Use the same expression in both places, or give struct rte_stack_pile a
flexible array member as rte_stack_lf has.

11. lib/stack/rte_stack_pile.h - doxygen

Both __rte_stack_pile_push() and __rte_stack_pile_pop() document
"@param pile", but the parameter is "struct rte_stack *s".  Doxygen with
-Dwerror will flag the undocumented parameter.

12. Missing release notes

doc/guides/rel_notes/release_26_11.rst is not updated for the new pile
stack type, the new "pile" mempool driver, the mempool ABI changes, or
the new __rte_assume_aligned() / __rte_assume_cache_aligned() EAL
macros.

13. doc/guides/mempool/stack.rst

The driver guide lists the "stack" and "lf_stack" modes; the new "pile"
mode is not added.  PMD/driver documentation must match the registered
ops.

14. lib/mempool/mempool_trace.h

Dropping rte_trace_point_emit_u32(cache->flushthresh) changes the
recorded trace format for that trace point.  Worth a release note entry
for consumers parsing the trace output.

15. app/test/test_stack_perf.c

	#define MAX_BURST (RTE_MEMPOOL_CACHE_MAX_SIZE / 2)

A stack library test should not take its burst size from a mempool
configuration constant.  Use a stack-specific value (or
RTE_STACK_PILE_BULK_SIZE multiples).

Info

16. lib/eal/x86/include/rte_memcpy.h

The new constant-size block allows n <=3D 512 for AVX-512 and for SSE, but
only n <=3D 256 for AVX2 - is the asymmetry intended?  Splitting a single
"if (" across #if/#elif/#else with the body outside is also hard to
read; a per-ISA RTE_MEMCPY_CONST_MAX define and one "if" would be
clearer.  This change and the __rte_assume_aligned() addition are
independent of the pile work and are good candidates for their own
patches when the series is split.

17. drivers/net/sxe2/sxe2_txrx_vec_avx512.c

The hunk adds an unrelated blank line before "goto done;".

18. lib/stack/rte_stack_pile.h, __rte_stack_pile_bulk_pop_elems()

The element list is traversed twice: once inside
__rte_stack_lf_pop_elems() (to find the new head and set *last) and
again to copy the bulk contents.  For a pop of 8 bulk elements that is
two dependent pointer chases over the same cache lines.

19. drivers/mempool/stack/rte_mempool_stack.c

pile_enqueue() returns -ENOBUFS when the push fails, but
rte_mempool_ops_enqueue_bulk() returns void and callers do not recover,
so a failed put loses objects.  This is the same hazard the lock-free
stack already has, but the pile has two independent free lists, so the
window in which a concurrent pop leaves neither free_bulk nor free_solo
able to satisfy a push is wider.  Worth calling out in stack_lib.rst.

20. doc/guides/prog_guide/stack_lib.rst

"performaing" -> "performing".  The trailing "Note:" paragraph would
render better as a ".. note::" directive.

21. The series mixes at least five independent changes (EAL assume-aligned
macro, x86 rte_memcpy fast path, mempool cache/header rework, the pile
stack, the pile mempool driver).  You already noted this; those look
like the natural split points, and the mempool cache rework in
particular deserves its own review thread given the ABI impact.
