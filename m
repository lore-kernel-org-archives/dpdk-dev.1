Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6488FC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 19:39:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63EA842E0C;
	Wed, 21 May 2025 21:39:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 4A10D402CD
 for <dev@dpdk.org>; Wed, 21 May 2025 21:39:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2hSH5QqSz6GDn2;
 Thu, 22 May 2025 03:34:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 977E314020A;
 Thu, 22 May 2025 03:38:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 21:38:59 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 21 May 2025 21:38:59 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "jerinj@marvell.com" <jerinj@marvell.com>, "hemant.agrawal@nxp.com"
 <hemant.agrawal@nxp.com>, "drc@linux.ibm.com" <drc@linux.ibm.com>
Subject: RE: [PATCH v1 1/4] ring: introduce extra run-time checks
Thread-Topic: [PATCH v1 1/4] ring: introduce extra run-time checks
Thread-Index: AQHbykGpsQqK+1TaqEarZz25/dQkMLPc3a4AgAAkv/CAAGJtoIAAFfLg
Date: Wed, 21 May 2025 19:38:59 +0000
Message-ID: <2a514cea0f8f413eba6c85585cc149a9@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
 <20250521111432.207936-2-konstantin.ananyev@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC7E@smartserver.smartshare.dk>
 <1e3bcd254b7d4aba8fced00d76b70cee@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC80@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC80@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.143]
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



> > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > Sent: Wednesday, 21 May 2025 14.35
> >
> > > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > > Sent: Wednesday, 21 May 2025 13.14
> > > >
> > > > Add RTE_ASSERT() to check that different move_tail() flavors
> > > > return meaningful  *entries value.
> > > > It also helps to ensure that inside move_tail(), it uses correct
> > > > head/tail values.
> > > >
> > > > Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > > > ---
> > > >  lib/ring/rte_ring_c11_pvt.h      | 2 +-
> > > >  lib/ring/rte_ring_elem_pvt.h     | 8 ++++++--
> > > >  lib/ring/rte_ring_hts_elem_pvt.h | 8 ++++++--
> > > >  lib/ring/rte_ring_rts_elem_pvt.h | 8 ++++++--
> > > >  lib/ring/soring.c                | 2 ++
> > > >  5 files changed, 21 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/lib/ring/rte_ring_c11_pvt.h
> > b/lib/ring/rte_ring_c11_pvt.h
> > > > index b9388af0da..0845cd6dcf 100644
> > > > --- a/lib/ring/rte_ring_c11_pvt.h
> > > > +++ b/lib/ring/rte_ring_c11_pvt.h
> > > > @@ -104,10 +104,10 @@ __rte_ring_headtail_move_head(struct
> > > > rte_ring_headtail *d,
> > > >  			n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ?
> > > >  					0 : *entries;
> > > >
> > > > +		*new_head =3D *old_head + n;
> > > >  		if (n =3D=3D 0)
> > > >  			return 0;
> > > >
> > > > -		*new_head =3D *old_head + n;
> > > >  		if (is_st) {
> > > >  			d->head =3D *new_head;
> > > >  			success =3D 1;
> > >
> > > Is there a need to assign a value to *new_head if n=3D=3D0?
> >
> > Not really, main reason I just moved this line up - to keep compiler
> > happy.
> > Otherwise it complained that *new_head might be left uninitialized.
>=20
> Your change might give the impression that *new_head is used by a caller.=
 (Like I asked about.)
> To please the compiler, you could mark new_head __rte_unused, or:
>=20
> -		if (n =3D=3D 0)
> +		if (n =3D=3D 0) {
> +			RTE_SET_USED(new_head);
> 			return 0;
> +		}
>=20
> >

Makes sense, will re-spin.
Do you have any comments for other patches in the series?
Thanks
Konstantin=20


> > > I don't think your suggestion is multi-thread safe.
> > > If d->head moves, the value in *new_head will be incorrect.
> >
> > If d->head moves, then *old_head will also be incorrect.
> > For that case we do have CAS() below, it will return zero if (d->head
> > !=3D *old_head)
> > and we shall go to the next iteration (attempt).
>=20
> Exactly.
> And with my suggestion the same will happen if n=3D=3D0, and the next att=
empt will update them both, until they are both correct.
>=20
> > Basically - if n =3D=3D 0, your *old_head and *new_head might be invali=
d
> > and should not be used
> > (and they are not used).
> >
> > > Instead, suggest:
> > >
> > > -		if (n =3D=3D 0)
> > > -			return 0;
> > >
> > > 		*new_head =3D *old_head + n;
> > > 		if (is_st) {
> > > 			d->head =3D *new_head;
> > > 			success =3D 1;
> > > 		} else
> > > 			/* on failure, *old_head is updated */
> > > 			success =3D
> > rte_atomic_compare_exchange_strong_explicit(
> > > 					&d->head, old_head, *new_head,
> > > 					rte_memory_order_relaxed,
> > > 					rte_memory_order_relaxed);
> > > 	} while (unlikely(success =3D=3D 0));
> >
> > That's possible, but if (n =3D=3D0) we probably don't want to update th=
e
> > head -
> > as we are not moving head - it is pointless, while still expensive.
>=20
> Agree. Let's avoid unnecessary cost!
> My suggestion was only relevant if *new_head needed to be updated when n=
=3D=3D0.
>=20

