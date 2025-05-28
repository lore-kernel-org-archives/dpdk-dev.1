Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DEAC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 09:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BD09402A8;
	Wed, 28 May 2025 11:14:30 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D163640279
 for <dev@dpdk.org>; Wed, 28 May 2025 11:14:29 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6kN12b21z6GFRS;
 Wed, 28 May 2025 17:14:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B63AF1402FE;
 Wed, 28 May 2025 17:14:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 May 2025 11:14:27 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 28 May 2025 11:14:27 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, "skori@marvell.com"
 <skori@marvell.com>
CC: Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>, "Igor
 Russkikh" <irusskikh@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>, Hyong Youb Kim
 <hyonkim@cisco.com>, Ian Stokes <ian.stokes@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Chaoyong He <chaoyong.he@corigine.com>, Jiawen Wu
 <jiawenwu@trustnetic.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, "Jian
 Wang" <jianwang@trustnetic.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Thomas Monjalon <thomas@monjalon.net>, "Ferruh
 Yigit" <ferruh.yigit@amd.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Thread-Topic: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Thread-Index: AQHbw0/AjHqMNRGXNUegkZRPaA3HnbPmidiAgAAVuwCAASoo4IAAAtRwgAAAsvCAAAy/wA==
Date: Wed, 28 May 2025 09:14:27 +0000
Message-ID: <581e7a5389f842a9824a365a46c470ad@huawei.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250527080701.712af797@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9B@smartserver.smartshare.dk>
 <211102eb85854ab2b64f34e72603587c@huawei.com>
 <e15717945ee34a748436e7cc7fecbde4@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC9D@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC9D@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.172.111]
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



>=20
> > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > Sent: Wednesday, 28 May 2025 10.24
> >
> > > >
> > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > Sent: Tuesday, 27 May 2025 17.07
> > > > >
> > > > > On Mon, 12 May 2025 20:37:19 +0530
> > > > > <skori@marvell.com> wrote:
> > > > >
> > > > > >  /**@{@name Rx hardware descriptor states
> > > > > > diff --git a/lib/ethdev/rte_ethdev_core.h
> > > > > b/lib/ethdev/rte_ethdev_core.h
> > > > > > index e55fb42996..4ffae4921a 100644
> > > > > > --- a/lib/ethdev/rte_ethdev_core.h
> > > > > > +++ b/lib/ethdev/rte_ethdev_core.h
> > > > > > @@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
> > > > > >
> > > > > >
> > > > > >  /** @internal Get number of used descriptors on a receive
> > queue. */
> > > > > > -typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
> > > > > > +typedef int (*eth_rx_queue_count_t)(void *rxq);
> > > > > >
> > > > > >  /** @internal Check the status of a Rx descriptor */
> > > > > >  typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t
> > > > > offset);
> > > > >
> > > > >
> > > > > This gets reported as ABI breakage. The change will have to wait
> > until
> > > > > next LTS (25.11)
> > > >
> > > > The return type was weird (wrong) to begin with.
> > > > When used, it gets cast to int:
> > > >
> > https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L
> > 6404
> > >
> > > Personally, I don't see anything strange here.
> > > devops rx_queue_count() supposed to return uint, because it should
> > never failed for
> > > valid queue.
>=20
> The main thing wrong is inconsistency with its sibling API for TX queue c=
ount:
> /** @internal Get number of used descriptors on a receive queue. */
> typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
> /** @internal Get number of used descriptors on a transmit queue. */
> typedef int (*eth_tx_queue_count_t)(void *txq);
>=20
> > > While rte_eth_rx_queue_count() itself can fail - wrong port/queue id,
> > etc.
> >
> > BTW, rx_queue_setup() accepts only uint16_t for number of rx
> > descritoirs:
> > int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
> >                 uint16_t nb_rx_desc, unsigned int socket_id,
> >                 const struct rte_eth_rxconf *rx_conf,
> >                 struct rte_mempool *mb_pool);
> >
> > shouldn't dev->rx_queue_count() then also return uitn16_t (for
> > consistency)?
>=20
> If neither the RX or TX queue count callbacks can fail, then yes, both AP=
Is could be updated to return uint16_t.
> But it would be more future proof to allow these callbacks to fail, even =
on a valid queue.
> The public APIs rte_eth_rx/tx_queue_count() can fail, so passing on failu=
res from the callbacks would not be a change of the public
> API. (Assuming no new error codes are allowed.)
>=20
> And the "future" already arrived:
> The return type must be int (or have the same size as int), for the perfo=
rmance patch [1] replacing the ops->callback=3D=3DNULL check
> with dummy callbacks returning -ENOTSUP.
>=20
> [1]: https://inbox.dpdk.org/dev/20250512150732.65743-2-skori@marvell.com/

So what we are saving with that patch: one cmp and one un-taken branch:
@@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t que=
ue_id)
 		return -EINVAL;
 #endif
=20
-	if (p->rx_queue_count =3D=3D NULL)
-		return -ENOTSUP;
 	return p->rx_queue_count(qd);
 }

I wonder is how realistic (and measurable) is the gain?

>  =20
> >
> > > >
> > > > You are right that it formally changes the ABI, and we should go
> > through the LTS motions.
> > > > But, for this change, I'd favor an exception.
> > >
> > > Again, from my opinion, there is nothing that urgent/important why
> > such changes (if needed)
> > > can't wait till next LTS.
> > > For now, we can simply do type conversion explicitly at
> > rte_eth_rx_queue_count().
>=20
> OK. No objections from me. Just trying to accelerate some cleanup work.
>=20
> > >
> > > > PS: As a consequence of this change, a patch to update the return
> > type of the callback in all the ethdev drivers should be provided.
> > > >
> > > > >
> > > > >
> > > > >   [C] 'rte_eth_fp_ops rte_eth_fp_ops[32]' was changed at
> > > > > rte_ethdev.c:47:1:
> > > > >     type of variable changed:
> > > > >       array element type 'struct rte_eth_fp_ops' changed:
> > > > >         type size hasn't changed
> > > > >         1 data member change:
> > > > >           type of 'eth_rx_queue_count_t rx_queue_count' changed:
> > > > >             underlying type 'uint32_t (*)(void*)' changed:
> > > > >               in pointed to type 'function type uint32_t
> > (void*)':
> > > > >                 return type changed:
> > > > >                   entity changed from 'typedef uint32_t' to 'int'
> > > > >                   type size hasn't changed
> > > > >       type size hasn't changed

