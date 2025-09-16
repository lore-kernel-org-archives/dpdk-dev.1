Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42567CAC592
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 23:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17A384027A;
	Wed, 17 Sep 2025 01:08:10 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 43F6E40268
 for <dev@dpdk.org>; Wed, 17 Sep 2025 01:08:09 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRHb070DPz6L56F;
 Wed, 17 Sep 2025 07:06:36 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 3DC0B1400CB;
 Wed, 17 Sep 2025 07:08:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Sep 2025 01:08:07 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 17 Sep 2025 01:08:07 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <honnappa.nagarahalli@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Ola Liljedahl <ola.liljedahl@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>
Subject: RE: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Topic: [PATCH 1/1] ring: safe partial ordering for head/tail update
Thread-Index: AQHcJnJlB2Gj2xn6O0SOJRCJl7cS/rSWYP5wgAAO3ZA=
Date: Tue, 16 Sep 2025 23:08:07 +0000
Message-ID: <96a93e5a616e47ec8dbf08d97a73745e@huawei.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
In-Reply-To: <a5fae8a9edc947fdbaf4e2519c39f93e@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.102]
Content-Type: text/plain; charset="us-ascii"
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



>=20
>=20
> > The function __rte_ring_headtail_move_head() assumes that the barrier
> > (fence) between the load of the head and the load-acquire of the
> > opposing tail guarantees the following: if a first thread reads tail
> > and then writes head and a second thread reads the new value of head
> > and then reads tail, then it should observe the same (or a later)
> > value of tail.
> >
> > This assumption is incorrect under the C11 memory model. If the barrier
> > (fence) is intended to establish a total ordering of ring operations,
> > it fails to do so. Instead, the current implementation only enforces a
> > partial ordering, which can lead to unsafe interleavings. In particular=
,
> > some partial orders can cause underflows in free slot or available
> > element computations, potentially resulting in data corruption.
>=20
> Hmm... sounds exactly like the problem from the patch we discussed earlie=
r that
> year:
> https://patchwork.dpdk.org/project/dpdk/patch/20250521111432.207936-4-
> konstantin.ananyev@huawei.com/
> In two words:
> "... thread can see 'latest' 'cons.head' value, with 'previous' value for=
 'prod.tail' or
> visa-versa.
> In other words: 'cons.head' value depends on 'prod.tail', so before makin=
g latest
> 'cons.head'
> value visible to other threads, we need to ensure that latest 'prod.tail'=
 is also visible."
> Is that the one?
>=20
> > The issue manifests when a CPU first acts as a producer and later as a
> > consumer. In this scenario, the barrier assumption may fail when anothe=
r
> > core takes the consumer role. A Herd7 litmus test in C11 can demonstrat=
e
> > this violation. The problem has not been widely observed so far because=
:
> >   (a) on strong memory models (e.g., x86-64) the assumption holds, and
> >   (b) on relaxed models with RCsc semantics the ordering is still stron=
g
> >       enough to prevent hazards.
> > The problem becomes visible only on weaker models, when load-acquire is
> > implemented with RCpc semantics (e.g. some AArch64 CPUs which support
> > the LDAPR and LDAPUR instructions).
> >
> > Three possible solutions exist:
> >   1. Strengthen ordering by upgrading release/acquire semantics to
> >      sequential consistency. This requires using seq-cst for stores,
> >      loads, and CAS operations. However, this approach introduces a
> >      significant performance penalty on relaxed-memory architectures.
> >
> >   2. Establish a safe partial order by enforcing a pair-wise
> >      happens-before relationship between thread of same role by changin=
g
> >      the CAS and the preceding load of the head by converting them to
> >      release and acquire respectively. This approach makes the original
> >      barrier assumption unnecessary and allows its removal.
>=20
> For the sake of clarity, can you outline what would be exact code changes=
 for
> approach #2? Same as in that patch:
> https://patchwork.dpdk.org/project/dpdk/patch/20250521111432.207936-4-
> konstantin.ananyev@huawei.com/
> Or something different?
>=20
> >   3. Retain partial ordering but ensure only safe partial orders are
> >      committed. This can be done by detecting underflow conditions
> >      (producer < consumer) and quashing the update in such cases.
> >      This approach makes the original barrier assumption unnecessary
> >      and allows its removal.
>=20
> > This patch implements solution (3) for performance reasons.
> >
> > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> > Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com>
> > Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
> > Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>
> > ---
> >  lib/ring/rte_ring_c11_pvt.h | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
> > index b9388af0da..e5ac1f6b9e 100644
> > --- a/lib/ring/rte_ring_c11_pvt.h
> > +++ b/lib/ring/rte_ring_c11_pvt.h
> > @@ -83,9 +83,6 @@ __rte_ring_headtail_move_head(struct rte_ring_headtai=
l
> > *d,
> >  		/* Reset n to the initial burst count */
> >  		n =3D max;
> >
> > -		/* Ensure the head is read before tail */
> > -		rte_atomic_thread_fence(rte_memory_order_acquire);
> > -
> >  		/* load-acquire synchronize with store-release of ht->tail
> >  		 * in update_tail.
> >  		 */
>=20
> But then cons.head can be read a before prod.tail (and visa-versa), right=
?
s/before/after/
=20
>=20
> > @@ -99,6 +96,13 @@ __rte_ring_headtail_move_head(struct rte_ring_headta=
il
> > *d,
> >  		 */
> >  		*entries =3D (capacity + stail - *old_head);
> >
> > +		/*
> > +		 * Ensure the entries calculation was not based on a stale
> > +		 * and unsafe stail observation that causes underflow.
> > +		 */
> > +		if ((int)*entries < 0)
> > +			*entries =3D 0;
> > +
> >  		/* check that we have enough room in ring */
> >  		if (unlikely(n > *entries))
> >  			n =3D (behavior =3D=3D RTE_RING_QUEUE_FIXED) ?
> > --
> > 2.43.0
> >

