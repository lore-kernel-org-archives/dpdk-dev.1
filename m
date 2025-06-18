Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF9C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42FD042D76;
	Wed, 18 Jun 2025 13:30:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C7B64427E6
 for <dev@dpdk.org>; Wed, 18 Jun 2025 13:30:05 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9779A20462;
 Wed, 18 Jun 2025 13:30:05 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 6/6] trace: add PMU
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 18 Jun 2025 13:30:01 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD0F@smartserver.smartshare.dk>
In-Reply-To: <aFKUtWpSaOBpfkMP@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 6/6] trace: add PMU
Thread-Index: AdvgO7X/X8N3Za6sQHunFddR1GJKPQAAi2TQ
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-7-tduszynski@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
 <3793563.K4a6FZZPjd@thomas>
 <aFKUtWpSaOBpfkMP@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Tomasz Duszynski" <tduszynski@marvell.com>, <jerinj@marvell.com>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, <dev@dpdk.org>
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
> Sent: Wednesday, 18 June 2025 12.28
>=20
> On Wed, Jun 18, 2025 at 11:47:13AM +0200, Thomas Monjalon wrote:
> > 18/06/2025 09:16, Morten Br=F8rup:
> > > > diff --git a/lib/meson.build b/lib/meson.build
> > > > index 1934cb4a29..87b567f01b 100644
> > > > --- a/lib/meson.build
> > > > +++ b/lib/meson.build
> > > > @@ -13,7 +13,7 @@ libraries =3D [
> > > >          'kvargs', # eal depends on kvargs
> > > >          'argparse',
> > > >          'telemetry', # basic info querying
> > > > -        'pmu',
> > > > +        'pmu', # trace depends on pmu
> > > >          'eal', # everything depends on eal
> > > >          'ptr_compress',
> > > >          'ring',
> > >
> > > @Tomasz,
> > >
> > > Please re-read my v1 review feedback [1]:
> > > The PMU library should depend on the EAL, not the other way =
around!
> >
> > It should depend on the low-level EAL, yes.
> > But as of now, EAL is not split so it is better to avoid EAL =
dependency if
> possible.
> >
> > > How else is the PMU library supposed to use EAL functions like
> rte_mem_page_size()?
> > >
> > > @Jerin or @Bruce, do any of you have some suggestions for how to =
achieve
> the proper dependency chain here?
> >
> > I propose we don't use rte_mem_page_size() in PMU lib for now,
> > so we keep not depending on EAL, to avoid mixing all in future.
> > Later we could fix it if we manage to have high level EAL as a =
separate
> library.
> >
> For cases where we only need a single small function or snippet, there =
is
> no problem with circular dependencies if it can be made an inline =
function
> in a header file. We just need to add the appropriate include path to =
the
> build of the PMU library to pick up any EAL headers with inlines.

Thanks for the suggestion, Bruce.
For the next version of my patch [2], I will consider if inlining the =
function is viable.
It's an O/S dependent function, so it might be too ugly putting it in a =
header file. We'll see.

[2]: =
https://patchwork.dpdk.org/project/dpdk/patch/20250612140657.313785-1-mb@=
smartsharesystems.com/

