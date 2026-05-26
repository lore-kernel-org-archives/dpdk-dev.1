Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38227CD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 17:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B24402AC;
	Tue, 26 May 2026 19:45:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 37CDE4021F
 for <dev@dpdk.org>; Tue, 26 May 2026 19:45:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 099E020A2F;
 Tue, 26 May 2026 19:45:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] mempool: improve cache behaviour and performance
Date: Tue, 26 May 2026 19:45:24 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6589F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6589D@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mempool: improve cache behaviour and performance
Thread-Index: Adzs86HXJvpiiJkpQY+O50DCJxToAgAAiuJAAA1CALA=
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260419095526.39526-1-mb@smartsharesystems.com>
 <ahCAPT1LEn_Rc7Pk@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589A@smartserver.smartshare.dk>
 <ahVqYpVXMn59Tl2d@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6589D@smartserver.smartshare.dk>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Jingjing Wu" <jingjing.wu@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@oss.nxp.com>
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

> From: Morten Br=F8rup [mailto:mb@smartsharesystems.com]
> Sent: Tuesday, 26 May 2026 12.37
>=20
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 26 May 2026 11.40
> >

[...]

> > [In all this, I am making the assumption that burst size is well =
less
> > than
> > cache size. Also, similar logic would be applicable for the inverse
> > scenario, e.g. flush to empty (and fill burst) and fill to 75%]
>=20
> I'm not so sure about this assumption.
> With a cache size of 512 and a bursts of 64, the cache only holds 8
> bursts.
> 50% is 4 bursts, and 25% is only 2 bursts.
>=20
> Using a replenish/drain level in the middle requires 5 bursts in =
either
> direction to pass the edge (and trigger replenish/flush).
> Using a replenish/drain level 25% from the edge requires only 3 bursts
> in the wrong direction to pass the edge (and trigger replenish/flush).
> Much higher probability with random get/put.
>=20
> >
> > Now, all said, I tend to agree that we want to leave space for a
> decent
> > size burst after a fill. That is why I think that filling to 75% is
> > reasonable. After an alloc that triggers a fill, I don't want the
> cache
> > less than 50% full, but not completely full so there is room for a
> free
> > without a flush, and similarly for a free that triggers a flush, the
> > cache
> > should not be empty, but also should not be more than half full.
> >
> > One suggestion - we could always add a simple tunable that specifies
> > the
> > margin, or reserved entries for alloc and free. We can then guide in
> > the
> > docs that the value should be e.g. "zero for apps where alloc and
> free
> > take
> > place on different cores. 20%-50% of cache is recommended where =
alloc
> > and
> > free take place on the same core"
>=20
> Yes, a simple tunable is a really good idea.
>=20
> At this point, I think we should optimize for use case #1, and go for
> the 50% fill level.
> Then we can add a tunable to optimize for use case #2 later. I will =
try
> to come up with a draft for such a follow-up patch within the next few
> days.

Adding a tunable is not so simple...
The choice of mempool cache algorithm (drain/replenish to 50% vs. =
drain/replenish completely) should be passed via the "flags" parameter =
in rte_mempool_create(), but rte_pktmbuf_pool_create() is missing the =
"flags" parameter.
We can add it at the next ABI breaking release.
WDYT?

We should use that addition as an opportunity to move the case where the =
objects are not entirely handled by the cache into non-inlined =
functions, so the inlined functions don't grow too much in size, when =
they need to handle two different algorithms.

>=20
> The 50% fill level in this patch is not as bad for use case #2 =
(roughly
> doubling the burst miss rate from 1/8 to 1/4), compared to how bad the
> original algorithm is for use case #1 (very high miss probability -
> only two ops in the wrong direction - after drain/replenish).
>=20
> -Morten

