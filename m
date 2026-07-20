Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD5C44525
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80F05402A7;
	Mon, 20 Jul 2026 12:09:34 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id EDC644028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 12:09:32 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-92e4fd65b2bso516715885a.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 03:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784542172; cv=none;
 d=google.com; s=arc-20260327;
 b=GI3A7JU3dZv3qgx4IdHx5hxaolIHqWmioZWfL2YQbP9qbTuSseAE7PPlvKyf0124Sq
 953wnuR5Qjc15voEv872kR36MmRoGMxj/kqGJR+8m6A3nQVNNMAo/MQ8zCQ5mZULxCZg
 9/ibpaEtifSeFwjQ4CQ15omnqZptp4NJQydXYWYez21j6p6FphM/wzL267RYtWMXbKJo
 LXiMLbm3aLV6HkwXTgUPaij+wIIuRQNsQ+E8ZYhgNMuwcnbRHP6wJS2F63dgYc0X9ZdZ
 EShum5tvS5qki9gq48USeG8iWg2L1k6YqkMENowhUGFTehrH4cxeME3GfYvg2ydhJNvx
 l5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=r+jHvXcUMbGyxNH6X6jCl/RvAS06oP/kuXXtTS3b4Qw=;
 fh=zjAH4xYAJegMBwOtu+H4UUCRrscHniBvyzjh5hdy0QM=;
 b=UKBo9nyyGPU3CAR29KCgPVQAt+Rhr2GBtI/+DrbEzJti9kI6qGryNn8D6f8irK8qhs
 GdnAmp6t7J90+YA+9JhWZuTW1io0vKka/lquoqLQFAcxoZiGDD06t+nq6sZiXl4f26mc
 pbITmzJ/LYgIiyiSsRXi9h9w6w3Z6mojEFTnWLPBCXvU6GRrQOjmPK79CliCGZwdlli4
 lS24DsqyPg+nLvhCERKwkbZQ27aRNXU77Fz5hC/e6pTZ3VYm4DLTEN/vFnvnZKtfE/JB
 OOcB0kcGuvoyPuvOJ2ELxgDammjrm1qsWLZ98FCJi7Stol6MA8mEIv9rDfqLxXzXYLLd
 hL6w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784542172; x=1785146972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r+jHvXcUMbGyxNH6X6jCl/RvAS06oP/kuXXtTS3b4Qw=;
 b=rBBQFflI1ykxnLmCy+/1IjhEoso7imEEw/7RZ+6z1OnY/sv2yUi/S0/fVw2l1w4bWl
 EMXUSd+s/au/700PSX9thnUr2GgFi4JUdk/sutcR7s/SGOhg4TbIkYlEHIwx5tJuKBPL
 Lh81xNXjsHz2Y0mSnq8u08CulT4Zd2JBhJGgaBP/40NsuYjeIJqkFCm2QCx6cZfofEac
 eXP39gU7E/m1PcyCLhAOeuptIuoQMN3n27HodvPFeBbk7WKS2XL6kvHxLMksGuUEiJdS
 6qW7AhTXY43h0ow/qeTa1WsDTc2wPm3kK/viNzXdl6GY5+xDVemJPwtsZIcFrnv2MhwL
 BqtA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEEokDJwQFxlT3pXW70XzyCaOm9gEovvpZMi/YwW+v3kfU7bDr8k7dfJk9lrbO49fckLo=@dpdk.org
X-Gm-Message-State: AOJu0YyzkhDNHbOWq7ldDDEIuZRMFAe3b6Qvulpc9U+0T7UnnxJmbRCz
 bOaXQu8ia5Mi+JUgjJhlK7fjma9gX3ss6dr27JWe+Dkh/21N4KKqbWpZgsbGcuSzz/8R1ZSmWza
 twcqLCuEX1HH6j+IufGh0Sh4vor8kF4E=
X-Gm-Gg: AfdE7ckzHw4bES1wAeC7OpZlhZkHeRCY09hjRDyi9hFGZLIYj0Kbg3EPUplJ1v5EvEL
 8YohBdYhWOVTjrcoHgO9g1f9qdGyG7fmt8Z0CbgKIHKflFsRU6G2V23HHovmUTZx99FryYFbc36
 5y6Mr2szupJDNtcHznzL1tyLvl7Q8aIzjQo5GzW+nnhI58XcARag/lhxaEhJ+b9/qONWNBaJ2P8
 tGumLCUbQ65rwEKk18t1XETNTR/W+Ep4ibG0wtsfF9Jqrz04SXRehEfU2g=
X-Received: by 2002:a05:620a:2602:b0:92e:d0de:ad9b with SMTP id
 af79cd13be357-930b430c2admr1315137685a.51.1784542172214; Mon, 20 Jul 2026
 03:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260331214117.142495-1-maxime@leroys.fr>
 <CAHHRULXktNXUawidOa7PFkL_q-Mns1SU7GVxhMQxLPd4sx9ieg@mail.gmail.com>
 <BL0PR11MB2993F871DC00713CA2ABF51296C72@BL0PR11MB2993.namprd11.prod.outlook.com>
In-Reply-To: <BL0PR11MB2993F871DC00713CA2ABF51296C72@BL0PR11MB2993.namprd11.prod.outlook.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 20 Jul 2026 12:09:21 +0200
X-Gm-Features: AUfX_mxmUQrvjqNr-TnvEwvuiEwwxMLYh15t19jcBkSlvAeq6UJ5oCw3gLcbSsA
Message-ID: <CAHHRULVZ+PruRQ0Sgi22uKxY3UijcMrXtGcCyiC2j2xGD8_68Q@mail.gmail.com>
Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Cc: "rjarry@redhat.com" <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Vladimir,

On Thu, Jul 16, 2026 at 4:25=E2=80=AFPM Medvedkin, Vladimir
<vladimir.medvedkin@intel.com> wrote:
>
> Hi Maxime,
>
> Thanks for working on this RFC. I have mixed feelings about the series. H=
ere some conceptual thoughts:
>
> On the positive side, I like the consolidation of the common tbl8 code be=
tween the ipv4 dir24_8 and ipv6 trie implementations. Removing duplicated c=
ode is always good. General approach to the implementation is good too, no =
extra indirection for TBL8 on lookup, backward compatibility with the curre=
nt "legacy" way to allocate tbl8 (although needs to carefully zero-init con=
fig).
>
> However, I have concerns about both the scope of the public API and the r=
esizing implementation.
>
> First, I am not yet convinced that this feature belongs in the public FIB=
 API, TBL8 is an implementation detail of the currently supported dir24_8 a=
nd trie backends. This series exposes part of internal algorithms to a publ=
ic as a generic FIB resource, although a future FIB algorithm may have noth=
ing to do with 8-bit stride trie level.

tbl8 is already public and users already have to reason about it:
num_tbl8 is in the merged config (rte_fib.h / rte_fib6.h) and must be
sized at create, and sizing it from a route count is not possible
(only routes longer than /24 consume groups, nested routes share
levels, byte-aligned prefixes need one extra transient group; for the
same route count the need ranges from 0 to 13 * disjoint deep routes
for IPv6).

Robin Jarry's in-flight RFC adding tbl8 usage statistics is there for
the same reason. So the resizable pool makes an already-public,
unsizable knob usable, which stands even for a single FIB.

> As discussed in the other thread, the main use case appears to be sharing=
 tbl8 capacity between many VRFs represented by separate FIB instances. In =
my view, separate FIB instance per VRF is not necessarily the best design. =
A shared TBL8 pool mitigates part of a problem, but does not solve the prob=
lem entirely. I understand that the previous RFC for multiVRF support in FI=
B, while having shared TBL8 internally, have problems with high memory cons=
umption. I am currently working on v2, so I suggest returning to the shared=
 pool discussion after that series is available.

Separate FIB instance per VRF is a legitimate model (isolation,
per-VRF lifecycle and config) and is what applications use today; and
a shared tbl8 pool is the mechanism both designs need underneath, your
previous multi-VRF RFC already had shared TBL8 internally.

To concede a point: a single-FIB multi-VRF lookup could be useful to
grout, but its advantage is an AVX-512 optimization on x86, not what
grout relies on, and an architecture-specific performance optimization
should not define the FIB API.

I would also rather not hold a ready, opt-in feature indefinitely on a
v2 with no posted schedule. Being able to size a FIB correctly,
without silently running out of or leaking tbl8, is a foundational
need for any real router, not a niche one; a single known user only
reflects that the capability does not exist upstream yet.

> So, on one hand, it addresses a real use case, and a useful feature shoul=
d not be rejected merely because it initially has only one known user. On t=
he other hand, if the feature remains specific to a single application, the=
 additional API and implementation complexity will be carried by the librar=
y and exposed to every FIB user. It may also make the API more difficult to=
 understand by presenting TBL8 pools as a general FIB concept. Maybe, if we=
 decide to add this after multi VRF rework, it is worth to add this as an i=
nternal API (not as a generic FIB API)? I'd like to hear more opinions on t=
his.
>
> Second, regarding resizing, I don't think the current implementation is a=
pplicable.
> For example, build_common_root() computes tbl_ptr from its local cur_tbl.=
 After the first level, cur_tbl can point into the current tbl8. A subseque=
nt tbl8_alloc() may resize the pool, publish the new base, wait for an RCU =
grace period, and free the old allocation. Control then returns to build_co=
mmon_root(), which writes through the old tbl_ptr. Same problem exists in o=
ther places like in write_edge().

Correct, the mid-insert resize is a use-after-free:
build_common_root() and write_edge() cache raw pointers into
pool->tbl8 across tbl8_alloc(), which can realloc and free the old
base.

But it is one symptom of a wider gap that is already in upstream,
independent of this series: the trie install is not safe against a
tbl8 allocation failure at all.

On current main, when tbl8_alloc() fails mid install_to_dp(), the
group already taken is leaked and the tbl24 entry is left dangling;
trie_modify() rolls back only the RIB node, never the dataplane. A
failed byte-aligned add on a tight pool then wrongly refuses a later
add that would fit. I filed it with a reproducer (fib6 autotest, fails
on main): https://bugs.dpdk.org/show_bug.cgi?id=3D1970

Two consequences for the resize discussion:
- the mid-install-failure fragility is not introduced by the shared or
resizable pool, it predates it.
- memory is finite, so a resizable pool eventually cannot grow and
hits the very same mid-install failure at max_tbl8 or on -ENOMEM.
Moving growth before the insert removes the UAF, but not this.

So the correct fix is to make the install atomic, not to reserve a
guessed amount: install_to_dp() should allocate every group it needs
before publishing any of them (freeing the unpublished ones on
failure), or reserve the exact peak up front.

That closes bug 1970 and removes the mid-insert resize hazard for the
pool in the same place. A rollback-after-publish approach is not
viable: readers are lock-free (RCU), so undoing already-published
writes would expose an inconsistent dataplane during the rollback
window.

I would rather see 1970 fixed in the trie first; the pool resize then
sits cleanly on top instead of trying to work around a non-atomic
install.

> I'm also not convinced in grow-only resizing without shrinking.
>

Grow-only is deliberate and already a significant improvement on its
own: today the only way to enlarge a FIB's tbl8 capacity is to destroy
and recreate it and reinsert every route, which is not usable on a
live dataplane. Grow-only removes that, at runtime, without
disruption.

Shrink is intentionally out of scope, as the cover letter states. With
the current LIFO free-list the freed groups do not form a contiguous
tail, so shrinking would be best-effort at best: a single in-use group
near the top pins the whole tail. Doing it properly needs a different
allocation strategy to avoid those holes (e.g. a min-heap of free
indices) plus compaction, and compaction relocates live groups and
rewrites every reference to them, i.e. the same pointer-invalidation
hazard as above. That is future work, an addition on top, not a
prerequisite for grow-only to be useful.

Regards,

Maxime

>
> -----Original Message-----
> From: Maxime Leroy <maxime@leroys.fr>
> Sent: Thursday, July 16, 2026 8:31 AM
> To: Medvedkin, Vladimir <vladimir.medvedkin@intel.com>
> Cc: rjarry@redhat.com; dev@dpdk.org
> Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
>
> Hi Vladimir,
>
> On Tue, Mar 31, 2026 at 11:41=E2=80=AFPM Maxime Leroy <maxime@leroys.fr> =
wrote:
> >
> > This RFC proposes an optional shared tbl8 pool for FIB/FIB6, to
> > address the difficulty of sizing num_tbl8 upfront.
> >
> > In practice, tbl8 usage depends on prefix distribution and evolves
> > over time. In multi-VRF environments, some VRFs are elephants (full
> > table, thousands of tbl8 groups) while others consume very little
> > (mostly /24 or shorter). Per-FIB sizing forces each instance to
> > provision for its worst case, leading to significant memory waste.
> >
> > A shared pool solves this: all FIBs draw from the same tbl8 memory, so
> > elephant VRFs use what they need while light VRFs cost almost nothing.
> > The sharing granularity is flexible: one pool per VRF, per address
> > family, a global pool, or no sharing at all.
> >
> > This series adds:
> >
> >   - A shared tbl8 pool, replacing per-backend allocation
> >     (bitmap in dir24_8, stack in trie) with a common
> >     refcounted O(1) stack allocator.
> >   - An optional resizable mode (grow via alloc + copy + QSBR
> >     synchronize), removing the need to guess peak usage at
> >     creation time.
> >   - A stats API (rte_fib_tbl8_pool_get_stats()) exposing
> >     used/total/max counters.
> >
> > All features are opt-in:
> >
> >   - Existing per-FIB allocation remains the default.
> >   - Shared pool is enabled via the tbl8_pool config field.
> >   - Resize is enabled by setting max_tbl8 > 0 with QSBR.
> >
> > Shrinking (reducing pool capacity after usage drops) is not part of
> > this series. It would always be best-effort since there is no
> > compaction: if any tbl8 group near the end of the pool is still in
> > use, the pool cannot shrink. The current LIFO free-list makes this
> > less likely by immediately reusing freed high indices, which prevents
> > a contiguous free tail from forming. A different allocation strategy
> > (e.g. a min-heap favoring low indices) could improve shrink
> > opportunities, but is better addressed separately.
> >
> > A working integration in Grout is available:
> > https://github.com/DPDK/grout/pull/581 (still a draft)
> >
> > Maxime Leroy (5):
> >   test/fib6: zero-initialize config struct
> >   fib: share tbl8 definitions between fib and fib6
> >   fib: add shared tbl8 pool
> >   fib: add resizable tbl8 pool
> >   fib: add tbl8 pool stats API
> >
> >  app/test/test_fib6.c        |  10 +-
> >  lib/fib/dir24_8.c           | 234 ++++++++++---------------
> >  lib/fib/dir24_8.h           |  17 +-
> >  lib/fib/fib_tbl8.h          |  50 ++++++
> >  lib/fib/fib_tbl8_pool.c     | 337 ++++++++++++++++++++++++++++++++++++
> >  lib/fib/fib_tbl8_pool.h     | 113 ++++++++++++
> >  lib/fib/meson.build         |   5 +-
> >  lib/fib/rte_fib.h           |   3 +
> >  lib/fib/rte_fib6.h          |   3 +
> >  lib/fib/rte_fib_tbl8_pool.h | 149 ++++++++++++++++
> >  lib/fib/trie.c              | 230 +++++++++---------------
> >  lib/fib/trie.h              |  15 +-
> >  12 files changed, 844 insertions(+), 322 deletions(-)  create mode
> > 100644 lib/fib/fib_tbl8.h  create mode 100644 lib/fib/fib_tbl8_pool.c
> > create mode 100644 lib/fib/fib_tbl8_pool.h  create mode 100644
> > lib/fib/rte_fib_tbl8_pool.h
> >
>
> I=E2=80=99m following up on this RFC, which I sent at the end of March. C=
ould you please review it and let me know whether you have any feedback or =
concerns?
>
> Thanks,
>
> -------------------------------
> Maxime Leroy
> maxime@leroys.fr



--=20
-------------------------------
Maxime Leroy
maxime@leroys.fr
