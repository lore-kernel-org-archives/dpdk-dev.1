Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CFC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:02:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98BD340272;
	Tue,  4 Aug 2026 01:02:36 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8062340269
 for <dev@dpdk.org>; Tue,  4 Aug 2026 01:02:35 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so46401725ad.2
 for <dev@dpdk.org>; Mon, 03 Aug 2026 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785798154;
 x=1786402954; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YjJjRpOzgXIdgM/WlDGu39+OkJ9x+KVz0Pyq2OFRkF4=;
 b=zytWoMaaoRWD8PuUfyrNa6itNmAkxkH/iefVPdvZ477i+j8+cVxRd8sYNs35Oevk8/
 ms7RE328h9NSz9XfvWWqLlQ2uizrimPQKbHe2XqO+e/9CLRHjStJ9IAN+5r+NuCZsCor
 9W2o51jpQWU+3WUCB+lGZm3inU86iL0hsDy3keKPX2neYtAQIX9VxGKsW39D6LCVcjnC
 89Zp6OjfMn1YqXa/aKt2DOHb9r3sWBsV6K0aNxRcuAO3owRU0CbxUNoLGgM/DBScbyeC
 bauV11Jl026wynnxSrg2Q7PsINa8lMCxPzlDSL/lUzBzuOb40rkrdYahcuWIydQXLVXZ
 gYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785798154; x=1786402954;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YjJjRpOzgXIdgM/WlDGu39+OkJ9x+KVz0Pyq2OFRkF4=;
 b=V4QloW8B2qT84f2mnCtoKGoOxud3gAvmKF/VQ7B1rVuIaZUcz65MxMDdgm48kTPcnl
 8QbGbNx8NYBM9nOkUqRdEtSL/8hiKeqj+M2nre17GsAM4I0/bglKLcz930pbEd2m5CED
 oVc+IhotmUVOA0T9oGCrEKQXSgjdnaJhEbP/35Y6rKJnlSF1SB9ydfOAEkU9XIucfGPh
 kdDRN5U/ndu6U+0a+Yb/5l3d70LLWJiGWfU3vGUSv1ovQOzvRiEbTT6j8sXm1MpdDWYL
 eW1UosH6iyCs+Pcrsr9+F01YGxnZbF/rCWIWCAFssf845mx0je5Vul7QNxKrb20nYJ64
 0kKA==
X-Gm-Message-State: AOJu0YzjZbplpDwmkmAEOVMTZSko0lLmYNjS/dhfSHHClsRXULgQLYIp
 59iZjWxqMmQdSdcMZ614qGsfxTUGROU+pPrdngDc93JW6cP9FHP1AOCuPrUnmshonAqF7wtUlAs
 hBb+l
X-Gm-Gg: AR+sD13rmVvh3YUZxAXZSBMIz5PYqxsnbBbEmN0B4zNVPmfJin0jsR39bYpA6551RSQ
 dl68f4qz4mCGVtzbUotSYjZpI8JwWOdhQ28cITcwCy5B3NlZiHYuZlWRZ0fJ+u1DXAjQ5jLb5hA
 9VruM1di3AyijM1U3J+LNS6tc2Wo4jfJbRwUjpPY4cIC6luPBcsopHtZ8aIP/J2+a4/Gnl1ZWol
 46Dmp1RcFwUIelQZ37/uvKBXR89h42w0V+to7YoCngE+a64ZvFQI+Btetv7ON1W3BVui4KQmV58
 6Qsgcx0vswWJPEiEMHcuhA3yxMvRdDrSl6cfIRz+EjVN5RpMJOOhC24JJWFd8hu255DzII5KZtM
 vD2YE6ml3kiyr5VRGq1sfGeddg/U4Zv8iw9S5Gl6UocXutmSh3gHjJkkUPdu5XmIsK51oDlJb+7
 QLWGDDw/QTBc2EJmPKrXwsepd8sz2d/jzlQbxS52IzOA4ttunO0Gu1KlNYkQlcE89VrW+elkRso
 /R+VUHX3V2kk8cyfVApR23BQ5+exg==
X-Received: by 2002:a05:6300:48e:b0:3cb:708b:7d47 with SMTP id
 adf61e73a8af0-3cb708bb69amr633842637.69.1785798153904; 
 Mon, 03 Aug 2026 16:02:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4f197sm43574688eec.6.2026.08.03.16.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:02:29 -0700 (PDT)
Date: Mon, 3 Aug 2026 16:02:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v7] pile stack and mempool driver
Message-ID: <20260803160225.79c9e725@phoenix.local>
In-Reply-To: <20260803081446.1292377-1-mb@smartsharesystems.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
 <20260803081446.1292377-1-mb@smartsharesystems.com>
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

On Mon,  3 Aug 2026 08:14:46 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Early submission of:
> - A new "pile" stack-like implementation using the Stack API, and
> - an accompanying "pile" mempool driver.
> And:
> - Some mempool optimizations.
> - Deprecating "__rte_restrict" in favor of keyword "__restrict",
>   supported by all relevant C/C++ compilers.
> - An x86 rte_memcpy() optimization for some compile time known sizes
>   (64-byte blocks up to 512 or 256 bytes).
> - Decorating the object tables in the Stack API with "restrict".
>=20
> For CI test and community feedback.
>=20
> Needless to say, this must be separated into a series of patches,
> or multiple independent series of patches.
> For now, I'm submitting a snapshot of work in progress.
>=20
> The "pile" somewhat resembles the lock-free stack, but operates on
> bulks (arrays) of objects, to significantly reduce linked list
> traversal.
> With the pile's default bulk size of 32 objects, a mempool cache
> flush/refill traverses a linked list of only 16 elements, whereas
> the lock-free stack would traverse a linked list of 512 elements.
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
> optimal mempool driver!
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

Claude Opus AI review still finds lots of issues.

Review of [RFC PATCH v7] pile stack and mempool driver

Fixed since v6: memcmp() size in test_stack_push_pop(), the off-by-one
__rte_assume() in the fragmentation path, the n_solo >=3D BULK_SIZE
overrun (now guarded), rte_mempool_cache_create() alignment
precondition, the init/get_memsize base-address mismatch (flexible
array member), the @param names, the rte_memcpy #if/#elif split, the
sxe2 stray blank line, the doc typo and the note directive.

Errors

1. lib/stack/rte_stack_pile.h, __rte_stack_pile_pop(), "fail:" label

	if (n_bulk > 0) {
		/* Attach the fragmentation element after the bulk elements. */
		bulk_last->next =3D frag;
	} else {
		bulk_first =3D frag;
		bulk_last =3D frag;
	}
	n_bulk +=3D 1;
	...
	__rte_stack_pile_bulk_push_elems(&pile->bulk, bulk_first, bulk_last, n_bul=
k);

In the n_bulk > 0 branch, frag is linked after bulk_last but bulk_last
is not advanced to frag.  __rte_stack_lf_push_elems() then executes
"last->next =3D old_head.top" on the old bulk_last, overwriting the link
to frag.  frag is dropped from every list, while list->len is
incremented by n_bulk + 1.

Two consequences: the bulk element and its RTE_STACK_PILE_BULK_SIZE
objects are leaked permanently, and pile->bulk.len is now one higher
than the number of linked elements.  A later pop that reserves that
phantom element will succeed in the CAS on len, then walk off the end
of the list, hit "i !=3D num", re-read list->head and retry - forever.
The inflated len never recovers, so this is a hang, not a transient
retry.

This is not new in v7; it was present in v6 and I missed it.

Easiest fix is to mirror what the success path already does correctly
and prepend instead of append:

	if (frag !=3D NULL) {
		if (n_bulk > 0)
			frag->next =3D bulk_first;
		else
			bulk_last =3D frag;
		bulk_first =3D frag;
		n_bulk++;
	}

2. lib/stack/rte_stack_pile.c, rte_stack_pile_get_memsize()

	sz +=3D count * sizeof(struct rte_stack_lf_elem);
	sz +=3D RTE_CACHE_LINE_ROUNDUP(sz);

RTE_CACHE_LINE_ROUNDUP() returns the rounded value, it does not return
the padding, so "+=3D" roughly doubles the allocation instead of rounding
it up.  Every pile stack, and therefore every pile mempool, reserves
about twice the memzone it needs.  Should be:

	sz =3D RTE_CACHE_LINE_ROUNDUP(sz);

3. doc/guides/mempool/stack.rst

	For more information please refer to :ref:`_Stack_Library_Pile`.

The leading underscore belongs to the label definition, not the
reference; compare the existing ":ref:`Stack_Library_LF_Stack`" two
paragraphs above.  As written, Sphinx cannot resolve the reference,
which fails the docs build with -Dwerror=3Dtrue.

Warnings

4. __rte_restrict deprecation

Replacing __rte_restrict with the raw __restrict compiler extension and
adding a checkpatches.sh rule against the RTE macro is a project-wide
policy change and should be a separate patch on its own thread, not a
side effect of the pile work.  Specific problems as posted:

 - The tree still has about 150 uses of __rte_restrict in 10 files that
   this patch does not convert, 98 of them in drivers/net/mlx5/mlx5_tx.h.
   The new checkpatch rule will fire on unrelated patches that touch any
   of those lines.
 - The deprecation is announced only in a doxygen comment.  There is no
   entry in doc/guides/rel_notes/deprecation.rst, no release note, and
   the macro is not marked with RTE_DEPRECATED, so nothing warns at
   compile time.
 - The checkpatch message says "prefer restrict", but the patch uses
   "__restrict".  "restrict" is the C99/C11 keyword; "__restrict" is a
   compiler extension.  Picking between the two per language mode is
   exactly what the macro existed for, since C++ has no "restrict".  If
   the intent is to standardise on the extension, the message and the
   doxygen text should say so.

5. Test-only configuration changes

config/rte_config.h sets RTE_MBUF_DEFAULT_MEMPOOL_OPS to "pile" and
config/x86/meson.build sets RTE_USE_C11_MEM_MODEL.  Both are marked
FIXME/test-only, noting them so they are not forgotten before the
series is split and reposted.

6. lib/stack/rte_stack_pile.h

The "return 0;" after the fail label is indented with four spaces
instead of a tab.

7. rte_mempool_cache_create() and rte_mempool_create_empty() now
disagree

Both round cache_size down to a multiple of 32, but for a request below
32 rte_mempool_cache_create() returns EINVAL while
rte_mempool_create_empty() logs a warning and silently creates the
mempool with no cache at all.  Same input, two different outcomes.  The
doxygen for the cache_size argument says it "must be divisible by 32",
which reads as a rejection in both cases.

The silent path is the risky one: any existing caller passing a small
cache size loses caching entirely with no error.  The TAP change in this
patch (TAP_GSO_MBUF_CACHE_SIZE 4 -> 32) is one instance that was caught;
call sites passing literals are not.  Consider rejecting in both places,
or rounding up to 32 rather than down to 0.  The log messages should
also print the requested and effective values.

8. ABI and API changes still without deprecation notices

deprecation.rst is untouched.  Still outstanding from v6:

 - struct rte_mempool: local_cache pointer -> inline
   local_cache[RTE_MAX_LCORE] array
 - removal of RTE_MEMPOOL_HEADER_SIZE()
 - RTE_MEMPOOL_CACHE_MAX_SIZE 512 -> 1024
 - RTE_MEMPOOL_MAX_OPS_IDX 16 -> 32, which changes the size of the
   exported rte_mempool_ops_table
 - the new divisible-by-32 requirement on cache_size

The two entries that this patch does implement (flushthresh, oversize
objs array) should be deleted from deprecation.rst by the patch that
implements them.

9. Mempool header footprint (unchanged from v6)

With local_cache[] inline and RTE_MEMPOOL_CACHE_MAX_SIZE at 1024 the
header is roughly 1 MB per mempool, now allocated and memset
unconditionally.  Previously RTE_MEMPOOL_HEADER_SIZE(mp, 0) omitted the
array entirely for mempools created with cache_size =3D=3D 0.

10. app/test/test_stack.c (unchanged from v6)

The excess-push test is still inside "#if 0 /* FIXME ... */", which
removes the check for the standard and lock-free stacks as well.

11. Pile capacity exceeds the requested count (unchanged from v6)

rte_stack_pile_init() creates ceil(count / BULK_SIZE) bulk elements plus
count solo elements, so the pile can hold roughly 2 * count objects.
__rte_stack_pile_count() hides this with RTE_MIN(s->capacity, ...).
rte_stack_push() is documented to fail when there is insufficient space.
Either enforce the capacity or document that the pile does not.

12. Missing release notes

doc/guides/rel_notes/release_26_11.rst is still not updated for the new
pile stack type, the new "pile" mempool driver, the mempool ABI changes,
the new __rte_assume_aligned()/__rte_assume_cache_aligned() macros, or
the __rte_restrict deprecation.

13. lib/mempool/mempool_trace.h (unchanged from v6)

Dropping the flushthresh field changes the recorded format of that trace
point; worth a release note for consumers parsing trace output.

14. app/test/test_stack_perf.c (unchanged from v6)

MAX_BURST is still derived from RTE_MEMPOOL_CACHE_MAX_SIZE.  A stack
library test should not take its burst size from a mempool
configuration constant.

Info

15. lib/stack/rte_stack_pile.c

	(struct rte_stack_pile_bulk_elem *)(&s->stack_pile.elems)

"&array" where "array" is meant; the cast hides the type mismatch.
s->stack_pile.elems (or &s->stack_pile.elems[0]) is clearer.

16. lib/stack/rte_stack_pile.h

Hoisting obj_frag[] to the top of __rte_stack_pile_pop() (for the C23
label/declaration issue) puts 256 bytes at cache-line alignment in the
frame of a function that is __rte_always_inline into the mempool
dequeue fast path, whether or not fragmentation is reached.  A nested
block around the fragmentation code would keep it off the fast path
while still avoiding a declaration after a label.

17. lib/stack/rte_stack_pile.h, __rte_stack_pile_bulk_pop_elems()

The element chain is still traversed twice: once inside
__rte_stack_lf_pop_elems() to find the new head, and again to copy the
bulk contents.

18. drivers/mempool/stack/rte_mempool_stack.c

pile_enqueue() returns -ENOBUFS on failure, but
rte_mempool_ops_enqueue_bulk() returns void, so a failed put loses
objects.  The lock-free stack has the same hazard, but the pile draws
from two independent free lists, so the window in which a concurrent pop
leaves neither able to satisfy a push is wider.  Worth documenting in
stack_lib.rst.

19. The series still mixes independent changes (the __rte_restrict and
x86 rte_memcpy work, the mempool cache/header rework, the pile stack,
the pile mempool driver).  The mempool cache rework in particular
deserves its own thread given the ABI impact.
