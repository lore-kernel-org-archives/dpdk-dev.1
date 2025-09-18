Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E06CAC597
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 10:00:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A30C540288;
	Thu, 18 Sep 2025 12:00:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BD4AB4027A;
 Thu, 18 Sep 2025 12:00:54 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 722EE205C8;
 Thu, 18 Sep 2025 12:00:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Fixing MBUF_FAST_FREE TX offload requirements?
Date: Thu, 18 Sep 2025 12:00:52 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65446@smartserver.smartshare.dk>
In-Reply-To: <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MBUF_FAST_FREE TX offload requirements?
Thread-Index: Adwoe/CW00eYdUKnR0u6xs4ZNoWZMgAAQzyw
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aMvMNUxSslnM68OR@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Ajit Khaparde" <ajit.khaparde@broadcom.com>,
 "Somnath Kotur" <somnath.kotur@broadcom.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 "Kiran Kumar K" <kirankumark@marvell.com>,
 "Sunil Kumar Kori" <skori@marvell.com>,
 "Satha Rao" <skoteshwar@marvell.com>, "Harman Kalra" <hkalra@marvell.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>,
 "Shai Brandes" <shaibran@amazon.com>,
 "Evgeny Schemeilin" <evgenys@amazon.com>,
 "Ron Beider" <rbeider@amazon.com>, "Amit Bernstein" <amitbern@amazon.com>,
 "Wajeeh Atrash" <atrwajee@amazon.com>, "Gaetan Rivet" <grive@u256.net>,
 "Xingui Yang" <yangxingui@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>, "Rosen Xu" <rosen.xu@altera.com>,
 "Andrew Boyer" <andrew.boyer@amd.com>,
 "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Ori Kam" <orika@nvidia.com>,
 "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad" <matan@nvidia.com>,
 "Wenbo Cao" <caowenbo@mucse.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jerin Jacob" <jerinj@marvell.com>, "Maciej Czekaj" <mczekaj@marvell.com>,
 <dev@dpdk.org>, <techboard@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Thomas Monjalon" <thomas@monjalon.net>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 18 September 2025 11.09
>=20
> On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Br=F8rup wrote:
> > Dear NIC driver maintainers (CC: DPDK Tech Board),
> >
> > The DPDK Tech Board has discussed that patch [1] (included in DPDK
> 25.07) extended the documented requirements to the
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > These changes put additional limitations on applications' use of the
> MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually exclusive
> with MULTI_SEGS (which is typically used for jumbo frame support).
> > The Tech Board discussed that these changes do not reflect the
> intention of the MBUF_FAST_FREE TX offload, and wants to fix it.
> > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
> exclusive.
> >
> > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements were:
> > When set, application must guarantee that
> > 1) per-queue all mbufs come from the same mempool, and
> > 2) mbufs have refcnt =3D 1.
> >
> > The patch added the following requirements to the MBUF_FAST_FREE
> offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > 3) mbufs are direct,
> > 4) mbufs have next =3D NULL and nb_segs =3D 1.
> >
> > Now, the key question is:
> > Can we roll back to the original two requirements?
> > Or do the drivers also depend on the third and/or fourth
> requirements?
> >
> > <advertisement>
> > Drivers freeing mbufs directly to a mempool should use the new
> rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so the
> preconditions for freeing mbufs directly into a mempool are validated
> in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> > Similarly, rte_mbuf_raw_alloc_bulk() should be used instead of
> rte_mempool_get_bulk().
> > </advertisement>
> >
> > PS: The feature documentation [2] still reflects the original
> requirements.
> >
> > [1]:
> =
https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b71391884876
> 673c1
> > [2]:
> =
https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
> rst#L125
> >
> >
> > Venlig hilsen / Kind regards,
> > -Morten Br=F8rup
> >
> I'm a little torn on this question, because I can see benefits for =
both
> approaches. Firstly, it would be nice if we made FAST_FREE as
> accessible
> for driver use as it was originally, with minimal requirements.
> However, on
> looking at the code, I believe that many drivers actually took it to
> mean
> that scattered packets couldn't occur in that case either, so the use
> was
> incorrect.

I primarily look at Intel drivers, and that's how I read the driver code =
too.

> Similarly, and secondly, if we do have the extra
> requirements
> for FAST_FREE, it does mean that any use of it can be very, very
> minimal
> and efficient, since we don't need to check anything before freeing =
the
> buffers.
>=20
> Given where we are now, I think keeping the more restrictive =
definition
> of
> FAST_FREE is the way to go - keeping it exclusive with MULTI_SEGS -
> because
> it means that we are less likely to have bugs. If we look to change it
> back, I think we'd have to check all drivers to ensure they are using
> the
> flag safely.

However, those driver bugs are not new.
If we haven't received bug reports from users affected by them, maybe we =
can disregard them (in this discussion about pros and cons).
I prefer we register them as driver bugs, instead of changing the API to =
accommodate bugs in the drivers.

From an application perspective, here's an idea for consideration:
Assuming that indirect mbufs are uncommon, we keep requirement #3.
To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of =
requirement #4.

Since the driver knows that refcnt =3D=3D 1, the driver can set next =3D =
NULL and nb_segs =3D 1 at any time, either when writing the TX =
descriptor (when it reads the mbuf anyway), or when freeing the mbuf.
Regarding performance, this means that the driver's TX code path has to =
write to the mbufs (i.e. adding the performance cost of memory store =
operations) when segmented - but that is a universal requirement when =
freeing segmented mbufs to the mempool.

For even more optimized driver performance, as Bruce mentions...
If a port is configured for FAST_FREE and not MULTI_SEGS, the driver can =
use a super lean transmit function.
Since the driver's transmit function pointer is per port (not per =
queue), this would require the driver to provide the MULTI_SEGS =
capability only per port, and not per queue. (Or we would have to add a =
NOT_MULTI_SEGS offload flag, to ensure that no queue is configured for =
MULTI_SEGS.)

