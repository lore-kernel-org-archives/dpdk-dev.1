Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1BBC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:39:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCB0740430;
	Mon, 26 May 2025 10:39:19 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 156DE40299
 for <dev@dpdk.org>; Mon, 26 May 2025 10:39:18 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b5TcQ2hZkz6L5Yg;
 Mon, 26 May 2025 16:35:50 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id EC8421402ED;
 Mon, 26 May 2025 16:39:16 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 10:39:16 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 26 May 2025 10:39:16 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "jerinj@marvell.com" <jerinj@marvell.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "drc@linux.ibm.com" <drc@linux.ibm.com>
Subject: RE: [PATCH v1 1/4] ring: introduce extra run-time checks
Thread-Topic: [PATCH v1 1/4] ring: introduce extra run-time checks
Thread-Index: AQHbykGpsQqK+1TaqEarZz25/dQkMLPc3a4AgAAkv/CAAGJtoIAAFfLggAAe4pCABv2XgA==
Date: Mon, 26 May 2025 08:39:16 +0000
Message-ID: <66f8dbc7d5fc492ba2ecf6fe61e86ed5@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
 <20250521111432.207936-2-konstantin.ananyev@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC7E@smartserver.smartshare.dk>
 <1e3bcd254b7d4aba8fced00d76b70cee@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC80@smartserver.smartshare.dk>
 <2a514cea0f8f413eba6c85585cc149a9@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC85@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC85@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> > > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > > Sent: Wednesday, 21 May 2025 14.35
> > > >
> > > > > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > > > > Sent: Wednesday, 21 May 2025 13.14
> > > > > >
> > > > > > Add RTE_ASSERT() to check that different move_tail() flavors
> > > > > > return meaningful  *entries value.
> > > > > > It also helps to ensure that inside move_tail(), it uses
> > correct
> > > > > > head/tail values.
> > > > > >
> > > > > > Signed-off-by: Konstantin Ananyev
> > <konstantin.ananyev@huawei.com>
> > > > > > ---
> > > > > >  lib/ring/rte_ring_c11_pvt.h      | 2 +-
> > > > > >  lib/ring/rte_ring_elem_pvt.h     | 8 ++++++--
> > > > > >  lib/ring/rte_ring_hts_elem_pvt.h | 8 ++++++--
> > > > > >  lib/ring/rte_ring_rts_elem_pvt.h | 8 ++++++--
> > > > > >  lib/ring/soring.c                | 2 ++
> > > > > >  5 files changed, 21 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/lib/ring/rte_ring_c11_pvt.h
> > > > b/lib/ring/rte_ring_c11_pvt.h
> > > > > > index b9388af0da..0845cd6dcf 100644
> > > > > > --- a/lib/ring/rte_ring_c11_pvt.h
> > > > > > +++ b/lib/ring/rte_ring_c11_pvt.h
> > > > > > @@ -104,10 +104,10 @@ __rte_ring_headtail_move_head(struct
> > > > > > rte_ring_headtail *d,
> > > > > >  			n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ?
> > > > > >  					0 : *entries;
> > > > > >
> > > > > > +		*new_head =3D *old_head + n;
> > > > > >  		if (n =3D=3D 0)
> > > > > >  			return 0;
> > > > > >
> > > > > > -		*new_head =3D *old_head + n;
> > > > > >  		if (is_st) {
> > > > > >  			d->head =3D *new_head;
> > > > > >  			success =3D 1;
> > > > >
> > > > > Is there a need to assign a value to *new_head if n=3D=3D0?
> > > >
> > > > Not really, main reason I just moved this line up - to keep
> > compiler
> > > > happy.
> > > > Otherwise it complained that *new_head might be left uninitialized.
> > >
> > > Your change might give the impression that *new_head is used by a
> > caller. (Like I asked about.)
> > > To please the compiler, you could mark new_head __rte_unused, or:
> > >
> > > -		if (n =3D=3D 0)
> > > +		if (n =3D=3D 0) {
> > > +			RTE_SET_USED(new_head);
> > > 			return 0;
> > > +		}

Actually, that wouldn't help.
By some reason, after introducing RTE_ASSERT()  gcc13 believes that now con=
s_next can
be used (stored) unfinalized here:

        n =3D __rte_ring_move_cons_head(r, (int)is_sc, n, behavior,
                        &cons_head, &cons_next, &entries);
        if (n =3D=3D 0)
                goto end;

        __rte_ring_dequeue_elems(r, cons_head, obj_table, esize, n);

        __rte_ring_update_tail(&r->cons, cons_head, cons_next, is_sc, 0);

end:
   ...

For me it is a false positive, somehow it missed that if (n=3D=3D0) then up=
date_table()
wouldn't be called  at all. Full error message below.
So making new_head always initialized, even if we are not going to use, see=
ms
like the simplest and cleanest way to fix it.

est-pipeline_runtime.c.o -c ../app/test-pipeline/runtime.c
In file included from ../lib/eal/include/rte_bitops.h:24,
                 from ../lib/eal/include/rte_memory.h:18,
                 from ../app/test-pipeline/runtime.c:19:
In function '__rte_ring_update_tail',
    inlined from '__rte_ring_do_dequeue_elem' at ../lib/ring/rte_ring_elem_=
pvt.h:472:2,
    inlined from 'rte_ring_sc_dequeue_bulk_elem' at ../lib/ring/rte_ring_el=
em.h:344:9,
    inlined from 'rte_ring_sc_dequeue_bulk' at ../lib/ring/rte_ring.h:402:9=
,
    inlined from 'app_main_loop_worker' at ../app/test-pipeline/runtime.c:9=
1:10:
../lib/eal/include/rte_stdatomic.h:139:9: error: 'cons_next' may be used un=
initialized [-Werror=3Dmaybe-uninitialized]
  139 |         __atomic_store_n(ptr, val, memorder)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/ring/rte_ring_c11_pvt.h:39:9: note: in expansion of macro 'rte_atomi=
c_store_explicit'
   39 |         rte_atomic_store_explicit(&ht->tail, new_val, rte_memory_or=
der_release);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../lib/ring/rte_ring_elem.h:20,
                 from ../lib/ring/rte_ring.h:38,
                 from ../lib/mempool/rte_mempool.h:49,
                 from ../lib/mbuf/rte_mbuf.h:38,
                 from ../lib/net/rte_ether.h:20,
                 from ../app/test-pipeline/runtime.c:31:
../lib/ring/rte_ring_elem_pvt.h: In function 'app_main_loop_worker':
../lib/ring/rte_ring_elem_pvt.h:462:29: note: 'cons_next' was declared here
  462 |         uint32_t cons_head, cons_next;
      |                             ^~~~~~~~~
In function '__rte_ring_update_tail',
    inlined from '__rte_ring_do_enqueue_elem' at ../lib/ring/rte_ring_elem_=
pvt.h:425:2,
    inlined from 'rte_ring_sp_enqueue_bulk_elem' at ../lib/ring/rte_ring_el=
em.h:159:9,
    inlined from 'rte_ring_sp_enqueue_bulk' at ../lib/ring/rte_ring.h:267:9=
,
    inlined from 'app_main_loop_worker' at ../app/test-pipeline/runtime.c:1=
01:11=20

> > >
> > > >
> >
> > Makes sense, will re-spin.


> I'm having second thoughts about treating this compiler warning as a fals=
e positive!
>=20
> Are you 100 % sure that no caller uses *new_head?
=20
Yes, I believe so. If not, then we do have a severe bug in our rt_ring,

> I suppose you are, because it wasn't set before this patch either, so the=
 existing code would have a bug if some caller uses it.
> But the documentation does not mention that *new_head is not set if the f=
unction returns 0.
> So, some future caller might use *new_head, thus introducing a bug when n=
=3D=3D0.
>=20
> But most importantly for the performance discussion, the costly CAS is on=
ly pointless when n=3D=3D0.
> So, if n=3D=3D0 is very unlikely, we could accept this pointless cost.
> And it would save us the cost of "if (n=3D=3D0) return 0;" in the hot cod=
e path.
>=20
> And, as a consequence, some of the callers of this function could also re=
move their special handing of
> __rte_ring_headtail_move_head() returning 0. (Likewise, only if a return =
value of 0 is unlikely, and the special handling has a cost in
> the hot cod path for non-zero return values.)

I don't think it is a good idea.
First of all about the cost - I suppose that situation when 'n=3D=3D0' is n=
ot so uncommon:
There is a contention on the ring (many threads try to enqueue/dequeue) to/=
from it.
Doing unnecessary CAS() (when n=3D=3D0) we introduce extra cache-snooping t=
o already busy memory sub-system,
i.e. we slowing down not only current threads, but all other producers/cons=
umers of the ring.
About removing extra branches: I don't think there would be many to remove.
Usually after move_head() finishes we have to do two operations:
__rte_ring_dequeue_elems() ;
__rte_ring_update_tail();
Both have to be performed only when 'n !=3D 0'.
Regarding the doc for the move_head() function - sure it can be updated to =
note explicitly
that both *old_head and *new_head will contain up-to-date values only when =
return value
is not zero.=20

> > > > > I don't think your suggestion is multi-thread safe.
> > > > > If d->head moves, the value in *new_head will be incorrect.
> > > >
> > > > If d->head moves, then *old_head will also be incorrect.
> > > > For that case we do have CAS() below, it will return zero if (d-
> > >head
> > > > !=3D *old_head)
> > > > and we shall go to the next iteration (attempt).
> > >
> > > Exactly.
> > > And with my suggestion the same will happen if n=3D=3D0, and the next
> > attempt will update them both, until they are both correct.
> > >
> > > > Basically - if n =3D=3D 0, your *old_head and *new_head might be
> > invalid
> > > > and should not be used
> > > > (and they are not used).
> > > >
> > > > > Instead, suggest:
> > > > >
> > > > > -		if (n =3D=3D 0)
> > > > > -			return 0;
> > > > >
> > > > > 		*new_head =3D *old_head + n;
> > > > > 		if (is_st) {
> > > > > 			d->head =3D *new_head;
> > > > > 			success =3D 1;
> > > > > 		} else
> > > > > 			/* on failure, *old_head is updated */
> > > > > 			success =3D
> > > > rte_atomic_compare_exchange_strong_explicit(
> > > > > 					&d->head, old_head, *new_head,
> > > > > 					rte_memory_order_relaxed,
> > > > > 					rte_memory_order_relaxed);
> > > > > 	} while (unlikely(success =3D=3D 0));
> > > >
> > > > That's possible, but if (n =3D=3D0) we probably don't want to updat=
e
> > the
> > > > head -
> > > > as we are not moving head - it is pointless, while still expensive.
> > >
> > > Agree. Let's avoid unnecessary cost!
> > > My suggestion was only relevant if *new_head needed to be updated
> > when n=3D=3D0.
> > >
>=20

