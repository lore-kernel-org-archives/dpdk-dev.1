Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3791C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 16:24:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61DBE402B3;
	Tue, 27 May 2025 18:24:52 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B1B84402A0
 for <dev@dpdk.org>; Tue, 27 May 2025 18:24:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 61D512076F;
 Tue, 27 May 2025 18:24:50 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 27 May 2025 18:24:48 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC9B@smartserver.smartshare.dk>
In-Reply-To: <20250527080701.712af797@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Thread-Index: AdvPGRCZ/IYnQ7/yTcad5XQ1Ah1e2gACG4Jg
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
 <20250527080701.712af797@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<skori@marvell.com>
Cc: "Shepard Siegel" <shepard.siegel@atomicrules.com>,
 "Ed Czeck" <ed.czeck@atomicrules.com>,
 "John Miller" <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>,
 "Ajit Khaparde" <ajit.khaparde@broadcom.com>,
 "Somnath Kotur" <somnath.kotur@broadcom.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, "John Daley" <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, "Jie Hai" <haijie1@huawei.com>,
 "Ian Stokes" <ian.stokes@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Ori Kam" <orika@nvidia.com>,
 "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad" <matan@nvidia.com>,
 "Long Li" <longli@microsoft.com>, "Wei Hu" <weh@microsoft.com>,
 "Chaoyong He" <chaoyong.he@corigine.com>,
 "Jiawen Wu" <jiawenwu@trustnetic.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, "Maciej Czekaj" <mczekaj@marvell.com>,
 "Jian Wang" <jianwang@trustnetic.com>,
 "Maxime Coquelin" <maxime.coquelin@redhat.com>,
 "Chenbo Xia" <chenbox@nvidia.com>,
 "Jochen Behrens" <jochen.behrens@broadcom.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>, <dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Tuesday, 27 May 2025 17.07
>=20
> On Mon, 12 May 2025 20:37:19 +0530
> <skori@marvell.com> wrote:
>=20
> >  /**@{@name Rx hardware descriptor states
> > diff --git a/lib/ethdev/rte_ethdev_core.h
> b/lib/ethdev/rte_ethdev_core.h
> > index e55fb42996..4ffae4921a 100644
> > --- a/lib/ethdev/rte_ethdev_core.h
> > +++ b/lib/ethdev/rte_ethdev_core.h
> > @@ -45,7 +45,7 @@ typedef uint16_t (*eth_tx_prep_t)(void *txq,
> >
> >
> >  /** @internal Get number of used descriptors on a receive queue. */
> > -typedef uint32_t (*eth_rx_queue_count_t)(void *rxq);
> > +typedef int (*eth_rx_queue_count_t)(void *rxq);
> >
> >  /** @internal Check the status of a Rx descriptor */
> >  typedef int (*eth_rx_descriptor_status_t)(void *rxq, uint16_t
> offset);
>=20
>=20
> This gets reported as ABI breakage. The change will have to wait until
> next LTS (25.11)

The return type was weird (wrong) to begin with.
When used, it gets cast to int:
https://elixir.bootlin.com/dpdk/v25.03/source/lib/ethdev/rte_ethdev.h#L64=
04

You are right that it formally changes the ABI, and we should go through =
the LTS motions.
But, for this change, I'd favor an exception.

PS: As a consequence of this change, a patch to update the return type =
of the callback in all the ethdev drivers should be provided.

>=20
>=20
>   [C] 'rte_eth_fp_ops rte_eth_fp_ops[32]' was changed at
> rte_ethdev.c:47:1:
>     type of variable changed:
>       array element type 'struct rte_eth_fp_ops' changed:
>         type size hasn't changed
>         1 data member change:
>           type of 'eth_rx_queue_count_t rx_queue_count' changed:
>             underlying type 'uint32_t (*)(void*)' changed:
>               in pointed to type 'function type uint32_t (void*)':
>                 return type changed:
>                   entity changed from 'typedef uint32_t' to 'int'
>                   type size hasn't changed
>       type size hasn't changed
