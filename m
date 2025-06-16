Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F012C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 13:18:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA10402B5;
	Mon, 16 Jun 2025 15:18:09 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 09862402AF
 for <dev@dpdk.org>; Mon, 16 Jun 2025 15:18:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BC199200E2;
 Mon, 16 Jun 2025 15:18:07 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 6/6] trace: add PMU
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 16 Jun 2025 15:18:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FCFA@smartserver.smartshare.dk>
In-Reply-To: <20250616094903.3236231-1-tduszynski@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 6/6] trace: add PMU
Thread-Index: Adveo+sp60LwyMTMTlOyK5jZd5dY9QAGz+4g
References: <21436140.jiFIW2sfyF@thomas>
 <20250616094903.3236231-1-tduszynski@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Tomasz Duszynski" <tduszynski@marvell.com>,
	<thomas@monjalon.net>
Cc: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <roretzla@linux.microsoft.com>, <skori@marvell.com>
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

> From: Tomasz Duszynski [mailto:tduszynski@marvell.com]
> Sent: Monday, 16 June 2025 11.49
>=20
> >16/06/2025 08:53, Tomasz Duszynski:
> >> @@ -86,6 +86,7 @@ always_enable =3D [
> >>          'ring',
> >>          'stack',
> >>          'telemetry',
> >> +        'pmu',
> >>  ]
> >
> >This list is alphabetically sorted.
>=20
> Right, missed that.
>=20
> >
> >What is the justification for always enabling PMU lib?
> >Is it a good idea to always enable an experimental library?
>=20
> Well, since on Linux eal depends on pmu, disabling pmu ends up =
disabling
> eal, which breaks minimal build.
>=20
> As for the second question - no. I think ideally lib should remain
> optional. However, since trace is part of eal, that indirectly forces
> pmu to be built.

Trace is optional, controlled by RTE_TRACE in /config/rte_config.h.

>=20
> Alternatively, I guess we could make the library explicitly optional =
by
> extra meson option. But given that there are already options for
> controlling libraries that approach is not perfect either.

PMU should depend on EAL, not the other way around.

Please refer to this fix, where pmu.c is updated to call =
rte_mem_page_size(), which includes error handling, instead of directly =
calling sysconf(_SC_PAGE_SIZE) without handling errors from it:
https://patchwork.dpdk.org/project/dpdk/patch/20250612140657.313785-1-mb@=
smartsharesystems.com/

If there are cross dependency issues due to integration between PMU and =
Trace, adding the PMU related trace directly in the Trace library is a =
much better solution than making EAL depend on PMU.

Also, I agree with Thomas that PMU should not be considered a mandatory =
core library (always_enable).

