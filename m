Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBECAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 14:12:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FFEE40288;
	Thu, 18 Sep 2025 16:12:26 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id AAFE34027A;
 Thu, 18 Sep 2025 16:12:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cSHcZ6DPwztTmH;
 Thu, 18 Sep 2025 22:11:26 +0800 (CST)
Received: from kwepemk200009.china.huawei.com (unknown [7.202.194.75])
 by mail.maildlp.com (Postfix) with ESMTPS id 94E83180B62;
 Thu, 18 Sep 2025 22:12:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 kwepemk200009.china.huawei.com (7.202.194.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 22:12:19 +0800
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 18 Sep 2025 16:12:17 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
CC: Ajit Khaparde <ajit.khaparde@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@oss.nxp.com>, Shai Brandes <shaibran@amazon.com>, "Evgeny
 Schemeilin" <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>, "Amit
 Bernstein" <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 "Gaetan Rivet" <grive@u256.net>, yangxingui <yangxingui@h-partners.com>,
 Fengchengwen <fengchengwen@huawei.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao"
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Wenbo Cao
 <caowenbo@mucse.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>,
 Ivan Malov <ivan.malov@arknetworks.am>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: Fixing MBUF_FAST_FREE TX offload requirements?
Thread-Topic: Fixing MBUF_FAST_FREE TX offload requirements?
Thread-Index: AdwoeT4kzGDKcdJWQM+eShxAfVQ/Zf//48WAgAAOcwD//5mvMA==
Date: Thu, 18 Sep 2025 14:12:17 +0000
Message-ID: <f3d8956d80814d82a450abc263349ea7@huawei.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65446@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65446@smartserver.smartshare.dk>
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



> Subject: RE: Fixing MBUF_FAST_FREE TX offload requirements?
>=20
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Thursday, 18 September 2025 11.09
> >
> > On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Br=F8rup wrote:
> > > Dear NIC driver maintainers (CC: DPDK Tech Board),
> > >
> > > The DPDK Tech Board has discussed that patch [1] (included in DPDK
> > 25.07) extended the documented requirements to the
> > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > These changes put additional limitations on applications' use of the
> > MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive
> > with MULTI_SEGS (which is typically used for jumbo frame support).
> > > The Tech Board discussed that these changes do not reflect the
> > intention of the MBUF_FAST_FREE TX offload, and wants to fix it.
> > > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
> > exclusive.
> > >
> > > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> > > When set, application must guarantee that
> > > 1) per-queue all mbufs come from the same mempool, and
> > > 2) mbufs have refcnt =3D 1.
> > >
> > > The patch added the following requirements to the MBUF_FAST_FREE
> > offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > > 3) mbufs are direct,
> > > 4) mbufs have next =3D NULL and nb_segs =3D 1.
> > >
> > > Now, the key question is:
> > > Can we roll back to the original two requirements?
> > > Or do the drivers also depend on the third and/or fourth
> > requirements?
> > >
> > > <advertisement>
> > > Drivers freeing mbufs directly to a mempool should use the new
> > rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so the
> > preconditions for freeing mbufs directly into a mempool are validated
> > in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> > > Similarly, rte_mbuf_raw_alloc_bulk() should be used instead of
> > rte_mempool_get_bulk().
> > > </advertisement>
> > >
> > > PS: The feature documentation [2] still reflects the original
> > requirements.
> > >
> > > [1]:
> >
> https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b7139188487
> 6
> > 673c1
> > > [2]:
> > https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
> > rst#L125
> > >
> > >
> > > Venlig hilsen / Kind regards,
> > > -Morten Br=F8rup
> > >
> > I'm a little torn on this question, because I can see benefits for both
> > approaches. Firstly, it would be nice if we made FAST_FREE as
> > accessible
> > for driver use as it was originally, with minimal requirements.
> > However, on
> > looking at the code, I believe that many drivers actually took it to
> > mean
> > that scattered packets couldn't occur in that case either, so the use
> > was
> > incorrect.
>=20
> I primarily look at Intel drivers, and that's how I read the driver code =
too.
>=20
> > Similarly, and secondly, if we do have the extra
> > requirements
> > for FAST_FREE, it does mean that any use of it can be very, very
> > minimal
> > and efficient, since we don't need to check anything before freeing the
> > buffers.
> >
> > Given where we are now, I think keeping the more restrictive definition
> > of
> > FAST_FREE is the way to go - keeping it exclusive with MULTI_SEGS -
> > because
> > it means that we are less likely to have bugs. If we look to change it
> > back, I think we'd have to check all drivers to ensure they are using
> > the
> > flag safely.
>=20
> However, those driver bugs are not new.
> If we haven't received bug reports from users affected by them, maybe we =
can
> disregard them (in this discussion about pros and cons).
> I prefer we register them as driver bugs, instead of changing the API to
> accommodate bugs in the drivers.
>=20
> From an application perspective, here's an idea for consideration:
> Assuming that indirect mbufs are uncommon, we keep requirement #3.
> To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of requirem=
ent
> #4.

Do we really need to enable FAST_FREE for jumbo-frames?
Jumbo-frames usually means much smaller PPS number and actual RX/TX overhea=
d
becomes really tiny.=20

> Since the driver knows that refcnt =3D=3D 1, the driver can set next =3D =
NULL and
> nb_segs =3D 1 at any time, either when writing the TX descriptor (when it=
 reads the
> mbuf anyway), or when freeing the mbuf.
> Regarding performance, this means that the driver's TX code path has to w=
rite to
> the mbufs (i.e. adding the performance cost of memory store operations) w=
hen
> segmented - but that is a universal requirement when freeing segmented mb=
ufs
> to the mempool.

It might work, but I think it will become way too complicated.
Again I don't know who is going to inspect/fix all the drivers.
Just not allowing FAST_FREE for mulsti-seg seems like a much more simpler a=
nd safer approach.
=20
> For even more optimized driver performance, as Bruce mentions...
> If a port is configured for FAST_FREE and not MULTI_SEGS, the driver can =
use a
> super lean transmit function.
> Since the driver's transmit function pointer is per port (not per queue),=
 this would
> require the driver to provide the MULTI_SEGS capability only per port, an=
d not
> per queue. (Or we would have to add a NOT_MULTI_SEGS offload flag, to ens=
ure
> that no queue is configured for MULTI_SEGS.)
>=20

