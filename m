Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A21CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:43:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAD9C402CC;
	Thu,  4 Jun 2026 17:43:35 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 10169402B6
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:43:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gWTNH2PFzzHnGdM;
 Thu,  4 Jun 2026 23:42:39 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B33540570;
 Thu,  4 Jun 2026 23:43:33 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 16:43:32 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 4 Jun 2026 16:43:32 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
Subject: RE: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Thread-Topic: [PATCH 2/5] ring: use GCC builtin as alternative to rte_atomic32
Thread-Index: AQHc8rN+Xems5YrDdEu55QdJffq1xrYue25w///5qwCAABalQA==
Date: Thu, 4 Jun 2026 15:43:32 +0000
Message-ID: <d2adf4776a53494292bc038d85153d66@huawei.com>
References: <20260602171552.686349-1-stephen@networkplumber.org>
 <20260602171552.686349-3-stephen@networkplumber.org>
 <d65ce1df239445e0bb795c852e075b1a@huawei.com>
 <20260604082010.1fe8a27d@phoenix.local>
In-Reply-To: <20260604082010.1fe8a27d@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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


> On Thu, 4 Jun 2026 15:11:25 +0000
> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
>=20
> > >  /**
> > >   * @internal This is a helper function that moves the producer/consu=
mer
> head
> > >   *    optimized for single threaded case
> > > @@ -82,7 +81,7 @@ __rte_ring_headtail_move_head_st(struct
> rte_ring_headtail
> > > *d,
> > >  	/* Single producer: only this thread writes d->head,
> > >  	 * so a relaxed load is sufficient.
> > >  	 */
> > > -	*old_head =3D rte_atomic_load_explicit(&d->head,
> > > rte_memory_order_relaxed);
> > > +	*old_head =3D rte_atomic_load_explicit(&d->head,
> > > 	rte_memory_order_acquire);
> >
> > Not sure, why it had changed to 'acquire' here?
> > Looks like just patch splitting mistake, no?
>=20
> I should have kept it as relaxed for the first load.

Yes, I believe so.
In fact, I reverted it back to 'relaxed' in final version (after applying a=
ll 5 patches)
and run both stress_ring_autotest and stress_soring_autotest on ARM box in =
our lab.
All passed.
Konstantin
