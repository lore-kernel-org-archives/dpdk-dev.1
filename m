Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E25C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 10:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7868D42D0B;
	Wed, 18 Jun 2025 12:37:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3322140151
 for <dev@dpdk.org>; Wed, 18 Jun 2025 12:37:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CE32820462;
 Wed, 18 Jun 2025 12:37:28 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 6/6] trace: add PMU
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 18 Jun 2025 12:37:25 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD0E@smartserver.smartshare.dk>
In-Reply-To: <20250618102320.97107-1-tduszynski@marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 6/6] trace: add PMU
Thread-Index: AdvgOwmmZ92y7pYiRKKV1HjEKRPZ7wAAZjtw
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
 <20250618102320.97107-1-tduszynski@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Tomasz Duszynski" <tduszynski@marvell.com>
Cc: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <thomas@monjalon.net>
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
> Sent: Wednesday, 18 June 2025 12.23
>=20
> >> diff --git a/lib/meson.build b/lib/meson.build
> >> index 1934cb4a29..87b567f01b 100644
> >> --- a/lib/meson.build
> >> +++ b/lib/meson.build
> >> @@ -13,7 +13,7 @@ libraries =3D [
> >>          'kvargs', # eal depends on kvargs
> >>          'argparse',
> >>          'telemetry', # basic info querying
> >> -        'pmu',
> >> +        'pmu', # trace depends on pmu
> >>          'eal', # everything depends on eal
> >>          'ptr_compress',
> >>          'ring',
> >
> >@Tomasz,
> >
> >Please re-read my v1 review feedback [1]:
> >The PMU library should depend on the EAL, not the other way around!
> >How else is the PMU library supposed to use EAL functions like
> rte_mem_page_size()?
>=20
> Hi Morten,
>=20
> Not addressing your comments wasn't intentional - just missed your =
reply prior
> to sending
> v2.
>=20
> Tracing is tightly tied to eal right now so adding anything "external" =
there
> brings in extra
> deps. That's why I can't move pmu further down in the lib hierarchy - =
dpdk
> won't build if I do.
>=20
> Once tracing is moved out into its own library, that kind of change =
should be
> possible.

OK. Thomas seems to agree with this approach, so I will accept it too. =
:-)

>=20
> >
> >@Jerin or @Bruce, do any of you have some suggestions for how to =
achieve the
> proper dependency chain here?
> >
> >Worst case, we will have to move PMU into EAL. :-(
> >
> >[1]:
> =
https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FCFA@smartse=
rver.
> smartshare.dk/T/#u
> >
> >Besides that, good stuff. :-)
