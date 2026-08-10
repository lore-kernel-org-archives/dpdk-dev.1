Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F8C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 16:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2694040272;
	Mon, 10 Aug 2026 18:15:11 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 1B54740144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 18:15:09 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38f0f132f56so59100a91.0
 for <dev@dpdk.org>; Mon, 10 Aug 2026 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786378509;
 x=1786983309; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8njzODMb/uzziM1Hke/tz9/Kna9WeqvQoTfs4qoBjeU=;
 b=sG6D+2F0NK65Q3Z0RS6VhBNGS/dDdmidH7dESb0b/tVOZ6Uw5rPS4Z01y1COSYCLlU
 pUmzcJ8LGUziq6Vfyz42zB1lDfAZni9zYI6MvluG/rAl7OPuVkkosHq+NSNviWfqN72S
 wPdfrHM8hjfoy7RgbnZJkzUaCwWNzAc3s+gD9nll5Qa53gQcggirk0XIVjOsg51Y55EW
 fVPrapihGtwEkyWoWZaM1cnRxzVUUeV73QBMBIBGzHhEi2a+oJ8VosUhhLQRX5uA2TRZ
 LitqM337r8SXWWQOv4txils+nUJqcvJcJF9vB+DB1rlTEzF2sRo6db6ghg6K3cxQ3Kha
 8zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786378509; x=1786983309;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8njzODMb/uzziM1Hke/tz9/Kna9WeqvQoTfs4qoBjeU=;
 b=iEj5W5xDsCJX+ZLXnjsj2+Zd2WRO5rDkGZyzvzHatJC16vun6fik5emTYP61d8vciw
 Zo/Vdq4BDwSmtWxy/TDdGlYuBm9abGBvyYYONHO4Q2CVjoqsQB5Hw6UURcpb6TpqeanG
 DAvCcgYxx626WmpklQl9t8+fFDtPDQC6equKmMwG4WfuMacRhRRQlVJoswDsKwRD8E9a
 PAwU0KLmnWbA8iT0HmrtffpjIoGV3N+eU7WRTe32aChXrYrxsXbfVBS3b+9OQ/KkCGxj
 WbAZAwpf9rMyyVUrIbLgClILtTuYe6l7wRhtSMpLSAc4Q09W55KYgqjHHFQ9lIQAPIhE
 svJw==
X-Gm-Message-State: AOJu0YzLZWFKYK5L7zB6O+s2fME6dw0AQtQRcmhEPg0WM27tMYIUNZoh
 13//KWjlBvJVU1n3q4YZl0x2HM0i5QGYCLX1DhYEVJyWFBYO3Gw0M6EpmHQy7Q0I6bkNEap8px6
 BtZpF
X-Gm-Gg: AR+sD10PEVlIfKCfvLxycZpdp4Yb7aobjLLmux+9dU7njlPOtb/cE8uBMfd20Gv9qd8
 cU9LzYm59u0swEOeJpv+9XQybzt/QyYv1ve3wSV74tXzw7YeCbNXIMExWcEaUiatEc8YHdxvj7L
 d4nOMmrm1DmSLkMJrjcPS7K/TbhPg1mZLTpP8m2VAWu+MAUX8a8IVqxqmPVJmxjzdBYap48k6EB
 gmp78EWVg0rlxbkq5ZD+TSsTeL+7umFh/CbS5eq1frfrruTK5l0T0sbTZhNW2BDI3GhYzGInNwh
 c+fjkkeQqAMo/vGEDgeW0ctslRudB98CfQ/lu/NcKWvgOdqtetIlSAHU0W7vRKlrxr8hIwR15dL
 hTHXdU+3g1AJNkElQ4DMmNue/TK4ICgYVke+fwYY/b2KQYIrPaGf7F4PcbZPzZ14pHWxhSZsDWI
 Gilak4ikmO1N6tdXCm5H7tv8ZF3L5YQbcXOd5h7CiNqgw1XQbe24h6GdO1nsz/o3Izg6vyBEIbZ
 4BemGVvomPo8BAb+LP1CwIBJ6AVBSW0/BCXbR2RDl+VomLxYMzy
X-Received: by 2002:a05:6a20:7487:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3cbd37eeb43mr18045556637.1.1786378508597; 
 Mon, 10 Aug 2026 09:15:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec2ec20sm52946091eec.28.2026.08.10.09.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:15:08 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:15:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v10] pile stack and mempool driver
Message-ID: <20260810091505.264a248e@phoenix.local>
In-Reply-To: <20260810151214.1606363-1-mb@smartsharesystems.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F659AB@smartserver.smartshare.dk>
 <20260810151214.1606363-1-mb@smartsharesystems.com>
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

On Mon, 10 Aug 2026 15:12:14 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Early submission of:
> - A new "pile" stack-like implementation using the Stack API, and
> - an accompanying "pile" mempool driver.
> And:
> - Some mempool optimizations.
>=20
> For CI test and community feedback.
>=20
> Needless to say, this must be separated into multiple independent
> series of patches.
> And release notes must be added.
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
> Note: The GitHub "mini" tests don't include the "pile" mempool driver,
> and are expected to fail.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

AI review with Claude Fable showed:

Applied to main (c1a46b9), clean build with gcc 13.3 and -Dwerror=3Dtrue.
No remaining references to the removed flushthresh field or the
RTE_MEMPOOL_HEADER_SIZE macro anywhere in the tree. Ran the stack,
stack_lf, stack_pile and mempool autotests plus a standalone harness
exercising the pile push/pop paths directly.

Errors:

1. test_stack.c: the pile fill loop in test_stack_basic() assumes an
   effective capacity of RTE_STACK_PILE_BULK_SIZE * STACK_SIZE, but the
   pile only has ceil(count / 32) free bulk elements, i.e. exactly
   count objects via the bulk path. The first push(STACK_SIZE) consumes
   all 2048 bulk elements; the second iteration fails. Confirmed at
   runtime:

       [test_stack_basic():193] Fill objects push failed

   The drain loop below it has the mirrored assumption. The loop bound
   should reflect the actual capacity model (one full-bulk fill, or
   fill bulk and solo separately).

2. test_stack.c: the failure above is masked -- the test still reports
   "Test OK". In all four new branches ("All objects push failed",
   "Fill objects push failed", "All objects pop failed", "Drain objects
   pop failed"), ret holds the return value of the failed push/pop,
   which is 0, and "goto fail_test" then does "return ret;", returning
   0 =3D success to __test_stack(). Each of these branches needs
   "ret =3D -1;" before the goto. Confirmed at runtime: the failure
   message prints, then the suite reports Test OK. This is presumably
   why CI never surfaced error 1.

Warnings:

3. Pile capacity contract: a pile created with count N accepts up to
   2*N objects (N via bulk elements plus N via solo elements). Verified
   empirically: after a full-bulk fill of 65536, another 65536 solo
   pushes were accepted, while rte_stack_count() clamps at s->capacity
   and under-reports the real content. Either size the solo free list
   so total capacity is N, or document the 2x behavior; the current
   state makes count/free_count inconsistent for raw stack API users.
   (Not reachable through mempool usage, where the object total is
   conserved.)

4. Cache sizes 1..31 now fail pool creation outright: rounding down to
   a multiple of 32 yields 0 and EINVAL. Verified:
   rte_mempool_create(cache=3D4) and rte_mempool_cache_create(4) both
   fail; 250 is silently rounded to 224 with only a DEBUG log. This
   breaks existing applications at runtime (the in-tree tap driver
   needed fixing from 4 to 32; out-of-tree apps get no warning).
   Consider rounding up for small sizes instead of failing, and this
   needs a prominent release notes entry either way. The rte_mempool.h
   doc says cache_size "must be divisible by 32" while the code accepts
   and rounds -- doc and behavior should agree.

5. struct rte_mempool now embeds local_cache[RTE_MAX_LCORE]
   unconditionally, so cache-less (cache_size=3D0) mempools grow by
   RTE_MAX_LCORE * sizeof(struct rte_mempool_cache) -- roughly 1 MB of
   memzone per pool at the default RTE_MAX_LCORE=3D128 with the enlarged
   objs[1024] array plus cache guard. Applications creating many small
   cache-less pools pay this in hugepage memory. Deliberate trade-off
   for removing the hot-path branch, but it should be called out in the
   release notes.

6. tap: raising TAP_GSO_MBUF_CACHE_SIZE from 4 to 32 also multiplies
   TAP_GSO_MBUFS_NUM (defined as PER_CORE * CACHE_SIZE) from 512 to
   4096 mbufs, an 8x larger GSO pool. If the change is only to satisfy
   the divisibility constraint, decouple MBUFS_NUM from CACHE_SIZE.

7. The two FIXME test-only settings (RTE_MBUF_DEFAULT_MEMPOOL_OPS
   "pile", RTE_USE_C11_MEM_MODEL in config/x86/meson.build) must be
   reverted before merge, as the FIXMEs already note.

Info:

8. RTE_MEMPOOL_DRIVER_REPRESENTOR_MZ_PREFIX: "representor" collides
   with the port-representor concept; "representative" or "worst-case"
   would read better.

9. rte_mempool_register_ops(): the old name-too-long path set rte_errno
   before returning; the new -ENAMETOOLONG and -EEXIST paths return the
   negative errno without setting rte_errno. Consistent with the other
   error returns in this function, but a small change in error
   reporting.

10. test_stack_push_pop() skips content verification entirely when
    bulk_sz >=3D RTE_STACK_PILE_BULK_SIZE but not a multiple of it.
    Latent (only 1 and MAX_BULK=3D512 are used today), but worth a
    comment or coverage.

Runtime verification that passed: the fragmentation pop path (push 64,
pop 40 as 1 bulk + 8 via a fragmented bulk element, then pop 24)
conserves all objects with no duplication or loss; the retry path with
odd sizes (push 33+31+32, pop 96) likewise; bulk-level LIFO ordering
matches the memcmp formula in the test; the pile mempool handler passes
populate/get/put/audit and a 1000-iteration uneven get/put churn
through the per-lcore cache; mempool_autotest (which now defaults to
pile) and the std/lf stack autotests all pass. The rounded-up
rte_memcpy in rte_mempool_do_generic_put stays within objs[] bounds
given the divisible-by-32 cache size enforced at creation.
