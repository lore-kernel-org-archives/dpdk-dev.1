Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D050C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 09:57:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA2F2402ED;
	Mon, 26 May 2025 11:57:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 97C2C40280
 for <dev@dpdk.org>; Mon, 26 May 2025 11:57:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4F74B20748;
 Mon, 26 May 2025 11:57:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v1 1/4] ring: introduce extra run-time checks
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 26 May 2025 11:57:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC8F@smartserver.smartshare.dk>
In-Reply-To: <66f8dbc7d5fc492ba2ecf6fe61e86ed5@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v1 1/4] ring: introduce extra run-time checks
Thread-Index: AQHbykGpsQqK+1TaqEarZz25/dQkMLPc3a4AgAAkv/CAAGJtoIAAFfLggAAe4pCABv2XgIAADCqA
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com><20250521111432.207936-2-konstantin.ananyev@huawei.com><98CBD80474FA8B44BF855DF32C47DC35E9FC7E@smartserver.smartshare.dk><1e3bcd254b7d4aba8fced00d76b70cee@huawei.com><98CBD80474FA8B44BF855DF32C47DC35E9FC80@smartserver.smartshare.dk><2a514cea0f8f413eba6c85585cc149a9@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC85@smartserver.smartshare.dk>
 <66f8dbc7d5fc492ba2ecf6fe61e86ed5@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
	<dev@dpdk.org>
Cc: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Monday, 26 May 2025 10.39
>=20
> > > > > From: Konstantin Ananyev =
[mailto:konstantin.ananyev@huawei.com]
> > > > > Sent: Wednesday, 21 May 2025 14.35
> > > > >
> > > > > > > From: Konstantin Ananyev
> [mailto:konstantin.ananyev@huawei.com]
> > > > > > > Sent: Wednesday, 21 May 2025 13.14
> > > > > > >
> > > > > > > Add RTE_ASSERT() to check that different move_tail()
> flavors
> > > > > > > return meaningful  *entries value.
> > > > > > > It also helps to ensure that inside move_tail(), it uses
> > > correct
> > > > > > > head/tail values.
> > > > > > >
> > > > > > > Signed-off-by: Konstantin Ananyev
> > > <konstantin.ananyev@huawei.com>
> > > > > > > ---
> > > > > > >  lib/ring/rte_ring_c11_pvt.h      | 2 +-
> > > > > > >  lib/ring/rte_ring_elem_pvt.h     | 8 ++++++--
> > > > > > >  lib/ring/rte_ring_hts_elem_pvt.h | 8 ++++++--
> > > > > > >  lib/ring/rte_ring_rts_elem_pvt.h | 8 ++++++--
> > > > > > >  lib/ring/soring.c                | 2 ++
> > > > > > >  5 files changed, 21 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/lib/ring/rte_ring_c11_pvt.h
> > > > > b/lib/ring/rte_ring_c11_pvt.h
> > > > > > > index b9388af0da..0845cd6dcf 100644
> > > > > > > --- a/lib/ring/rte_ring_c11_pvt.h
> > > > > > > +++ b/lib/ring/rte_ring_c11_pvt.h
> > > > > > > @@ -104,10 +104,10 @@ __rte_ring_headtail_move_head(struct
> > > > > > > rte_ring_headtail *d,
> > > > > > >  			n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ?
> > > > > > >  					0 : *entries;
> > > > > > >
> > > > > > > +		*new_head =3D *old_head + n;
> > > > > > >  		if (n =3D=3D 0)
> > > > > > >  			return 0;
> > > > > > >
> > > > > > > -		*new_head =3D *old_head + n;
> > > > > > >  		if (is_st) {
> > > > > > >  			d->head =3D *new_head;
> > > > > > >  			success =3D 1;
> > > > > >
> > > > > > Is there a need to assign a value to *new_head if n=3D=3D0?
> > > > >
> > > > > Not really, main reason I just moved this line up - to keep
> > > compiler
> > > > > happy.
> > > > > Otherwise it complained that *new_head might be left
> uninitialized.
> > > >
> > > > Your change might give the impression that *new_head is used by =
a
> > > caller. (Like I asked about.)
> > > > To please the compiler, you could mark new_head __rte_unused, =
or:
> > > >
> > > > -		if (n =3D=3D 0)
> > > > +		if (n =3D=3D 0) {
> > > > +			RTE_SET_USED(new_head);
> > > > 			return 0;
> > > > +		}
>=20
> Actually, that wouldn't help.
> By some reason, after introducing RTE_ASSERT()  gcc13 believes that =
now
> cons_next can
> be used (stored) unfinalized here:
>=20
>         n =3D __rte_ring_move_cons_head(r, (int)is_sc, n, behavior,
>                         &cons_head, &cons_next, &entries);
>         if (n =3D=3D 0)
>                 goto end;
>=20
>         __rte_ring_dequeue_elems(r, cons_head, obj_table, esize, n);
>=20
>         __rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc,
> 0);
>=20
> end:
>    ...
>=20
> For me it is a false positive, somehow it missed that if (n=3D=3D0) =
then
> update_table()
> wouldn't be called  at all. Full error message below.
> So making new_head always initialized, even if we are not going to =
use,
> seems
> like the simplest and cleanest way to fix it.

NAK.
Initializing new_head with potential garbage will prevent the compiler =
from detecting that it is being used uninitialized afterwards.

If the compiler is too stupid to understand "goto end", then please =
rewrite the affected code instead:
-	if (n =3D=3D 0)
-		goto end;
+	if (n !=3D 0) {
	__rte_ring_dequeue_elems();
	__rte_ring_update_tail();
-end:
+	}
	...

>=20
> est-pipeline_runtime.c.o -c ../app/test-pipeline/runtime.c
> In file included from ../lib/eal/include/rte_bitops.h:24,
>                  from ../lib/eal/include/rte_memory.h:18,
>                  from ../app/test-pipeline/runtime.c:19:
> In function '__rte_ring_update_tail',
>     inlined from '__rte_ring_do_dequeue_elem' at
> ../lib/ring/rte_ring_elem_pvt.h:472:2,
>     inlined from 'rte_ring_sc_dequeue_bulk_elem' at
> ../lib/ring/rte_ring_elem.h:344:9,
>     inlined from 'rte_ring_sc_dequeue_bulk' at
> ../lib/ring/rte_ring.h:402:9,
>     inlined from 'app_main_loop_worker' at ../app/test-
> pipeline/runtime.c:91:10:
> ../lib/eal/include/rte_stdatomic.h:139:9: error: 'cons_next' may be
> used uninitialized [-Werror=3Dmaybe-uninitialized]
>   139 |         __atomic_store_n(ptr, val, memorder)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/ring/rte_ring_c11_pvt.h:39:9: note: in expansion of macro
> 'rte_atomic_store_explicit'
>    39 |         rte_atomic_store_explicit(&ht->tail, new_val,
> rte_memory_order_release);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../lib/ring/rte_ring_elem.h:20,
>                  from ../lib/ring/rte_ring.h:38,
>                  from ../lib/mempool/rte_mempool.h:49,
>                  from ../lib/mbuf/rte_mbuf.h:38,
>                  from ../lib/net/rte_ether.h:20,
>                  from ../app/test-pipeline/runtime.c:31:
> ../lib/ring/rte_ring_elem_pvt.h: In function 'app_main_loop_worker':
> ../lib/ring/rte_ring_elem_pvt.h:462:29: note: 'cons_next' was declared
> here
>   462 |         uint32_t cons_head, cons_next;
>       |                             ^~~~~~~~~
> In function '__rte_ring_update_tail',
>     inlined from '__rte_ring_do_enqueue_elem' at
> ../lib/ring/rte_ring_elem_pvt.h:425:2,
>     inlined from 'rte_ring_sp_enqueue_bulk_elem' at
> ../lib/ring/rte_ring_elem.h:159:9,
>     inlined from 'rte_ring_sp_enqueue_bulk' at
> ../lib/ring/rte_ring.h:267:9,
>     inlined from 'app_main_loop_worker' at ../app/test-
> pipeline/runtime.c:101:11
>=20
> > > >
> > > > >
> > >
> > > Makes sense, will re-spin.
>=20
>=20
> > I'm having second thoughts about treating this compiler warning as a
> false positive!
> >
> > Are you 100 % sure that no caller uses *new_head?
>=20
> Yes, I believe so. If not, then we do have a severe bug in our =
rt_ring,
>=20
> > I suppose you are, because it wasn't set before this patch either, =
so
> the existing code would have a bug if some caller uses it.
> > But the documentation does not mention that *new_head is not set if
> the function returns 0.
> > So, some future caller might use *new_head, thus introducing a bug
> when n=3D=3D0.
> >
> > But most importantly for the performance discussion, the costly CAS
> is only pointless when n=3D=3D0.
> > So, if n=3D=3D0 is very unlikely, we could accept this pointless =
cost.
> > And it would save us the cost of "if (n=3D=3D0) return 0;" in the =
hot
> code path.
> >
> > And, as a consequence, some of the callers of this function could
> also remove their special handing of
> > __rte_ring_headtail_move_head() returning 0. (Likewise, only if a
> return value of 0 is unlikely, and the special handling has a cost in
> > the hot cod path for non-zero return values.)
>=20
> I don't think it is a good idea.
> First of all about the cost - I suppose that situation when 'n=3D=3D0' =
is
> not so uncommon:
> There is a contention on the ring (many threads try to =
enqueue/dequeue)
> to/from it.
> Doing unnecessary CAS() (when n=3D=3D0) we introduce extra =
cache-snooping
> to already busy memory sub-system,
> i.e. we slowing down not only current threads, but all other
> producers/consumers of the ring.
> About removing extra branches: I don't think there would be many to
> remove.
> Usually after move_head() finishes we have to do two operations:
> __rte_ring_dequeue_elems() ;
> __rte_ring_update_tail();
> Both have to be performed only when 'n !=3D 0'.

OK, thank you for the analysis.
You convinced me my suggestion was not a good idea.

> Regarding the doc for the move_head() function - sure it can be =
updated
> to note explicitly
> that both *old_head and *new_head will contain up-to-date values only
> when return value
> is not zero.

Maybe there's a ripple-down effect regarding documentation...
Some of the output parameters of the functions calling =
__rte_ring_headtail_move_head() are also conditionally valid.

And if any of these output parameters are used anyway, your patch series =
might have uncovered a bug.

Note:
For the multi-threaded rings, the output parameter *entries is only =
up-to-date when the return value is non-zero.
If d->head was fetched into *old_head, and another thread raced to =
update d->head before the CAS() (which is not called when n=3D=3D0, but =
would have failed), then *entries was set based on the old *old_head.
But that race might as well occur when returning from the function, so =
it shouldn't be a problem.
Your added RTE_ASSERT(*entries <=3D r->capacity)'s should be valid, =
regardless if *entries is up-to-date or based on the old *old_head.
This also means that the documentation needs no update regarding the =
validity of the *entries output parameter.

>=20
> > > > > > I don't think your suggestion is multi-thread safe.
> > > > > > If d->head moves, the value in *new_head will be incorrect.
> > > > >
> > > > > If d->head moves, then *old_head will also be incorrect.
> > > > > For that case we do have CAS() below, it will return zero if
> (d-
> > > >head
> > > > > !=3D *old_head)
> > > > > and we shall go to the next iteration (attempt).
> > > >
> > > > Exactly.
> > > > And with my suggestion the same will happen if n=3D=3D0, and the =
next
> > > attempt will update them both, until they are both correct.
> > > >
> > > > > Basically - if n =3D=3D 0, your *old_head and *new_head might =
be
> > > invalid
> > > > > and should not be used
> > > > > (and they are not used).
> > > > >
> > > > > > Instead, suggest:
> > > > > >
> > > > > > -		if (n =3D=3D 0)
> > > > > > -			return 0;
> > > > > >
> > > > > > 		*new_head =3D *old_head + n;
> > > > > > 		if (is_st) {
> > > > > > 			d->head =3D *new_head;
> > > > > > 			success =3D 1;
> > > > > > 		} else
> > > > > > 			/* on failure, *old_head is updated */
> > > > > > 			success =3D
> > > > > rte_atomic_compare_exchange_strong_explicit(
> > > > > > 					&d->head, old_head, *new_head,
> > > > > > 					rte_memory_order_relaxed,
> > > > > > 					rte_memory_order_relaxed);
> > > > > > 	} while (unlikely(success =3D=3D 0));
> > > > >
> > > > > That's possible, but if (n =3D=3D0) we probably don't want to
> update
> > > the
> > > > > head -
> > > > > as we are not moving head - it is pointless, while still
> expensive.
> > > >
> > > > Agree. Let's avoid unnecessary cost!
> > > > My suggestion was only relevant if *new_head needed to be =
updated
> > > when n=3D=3D0.
> > > >
> >

