Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82384CD343F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 15:45:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAE7B4027F;
	Tue,  5 May 2026 17:45:40 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 182294026C
 for <dev@dpdk.org>; Tue,  5 May 2026 17:45:39 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g92sG2Sx8zJ46BM;
 Tue,  5 May 2026 23:45:22 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id F082740569;
 Tue,  5 May 2026 23:45:37 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 May 2026 16:45:37 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 5 May 2026 16:45:37 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "wathsala.vithanage@arm.com" <wathsala.vithanage@arm.com>
Subject: RE: [PATCH v4 2/2] ring: introduce peek API for soring
Thread-Topic: [PATCH v4 2/2] ring: introduce peek API for soring
Thread-Index: AQHc0wIOAZEwwMj2T0WO4zR5EthNt7X0ZgOAgAs76SA=
Date: Tue, 5 May 2026 15:45:37 +0000
Message-ID: <9cd42a60e340484da836f14bafe275fd@huawei.com>
References: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-1-konstantin.ananyev@huawei.com>
 <20260423091625.123642-3-konstantin.ananyev@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65828@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65828@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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


> > +static inline uint32_t
> > +soring_enqueue_start(struct rte_soring *r, uint32_t num,
> > +	enum rte_ring_queue_behavior behavior, uint32_t *free_space)
> > +{
> > +	enum rte_ring_sync_type st;
> > +	uint32_t free, head, n, next;
> > +
> > +	RTE_ASSERT(r !=3D NULL && r->nb_stage > 0);
> > +
> > +	st =3D r->prod.ht.sync_type;
> > +
> > +	switch (st) {
> > +	case RTE_RING_SYNC_ST:
> > +		n =3D __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
> > +			r->capacity, RTE_RING_SYNC_ST, num, behavior,
> > +			&head, &next, &free);
> > +		break;
> > +	case RTE_RING_SYNC_MT_HTS:
> > +		n =3D __rte_ring_hts_move_head(&r->prod.hts, &r->cons.ht,
> > +			r->capacity, num, behavior, &head, &free);
> > +		break;
> > +	default:
> > +		/* unsupported mode, shouldn't be here */
> > +		RTE_ASSERT(0);
>=20
> Is RTE_ASSERT(0) the right choice for failure here?
> Unless built with assertions enabled, RTE_ASSERT(0) does nothing, and thi=
s
> function also does nothing but returns 0 as free_space, which may not be
> correct.
>=20
> Maybe rte_panic() instead.
> It's an application bug to call this with the wrong SORING sync type.
> We cannot handle it gracefully, so better to fail early.

Yep, it is a bug in application in such case, but as rule of thumb we avoid=
 panics in
the libs, even when user provided incorrect input.
At least, all lib/ring API function work like that - if given sync type is =
not supported,
then function doesn't touch the ring contents and fills 'free/available'
parameter with zero. So ring is sort-of unusable to the caller.

> Just an idea; I have no strong preference.

Ok, then I leave it like that.
Thanks for the review.
Konstantin

> > +		free =3D 0;
> > +		n =3D 0;
> > +	}
> > +
> > +	if (free_space !=3D NULL)
> > +		*free_space =3D free - n;
> > +	return n;
> > +}
> > +
