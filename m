Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2072BCA0EED
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 06:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0784026C;
	Wed, 20 Aug 2025 08:42:49 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4792A40151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 08:42:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1163C20F9E;
 Wed, 20 Aug 2025 08:42:48 +0200 (CEST)
Subject: RE: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Aug 2025 08:42:45 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
In-Reply-To: <20250818093416.057aad97@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Thread-Index: AdwQXfVBKwVkXAJySdimFK/qY8yFmQBPlDqg
X-MimeOLE: Produced By Microsoft Exchange V6.5
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250818093416.057aad97@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Tyler Retzlaff" <roretzla@microsoft.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Monday, 18 August 2025 18.34
>=20
> On Wed, 12 Mar 2025 16:15:29 -0700
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>=20
> > This series adds common macros for safe iteration over lists.
> > It is a subset copy of the macros from FreeBSD that are
> > missing from the Linux header sys/queue.h
> >
> > Chose this over several other options:
> >   - let each driver define their own as needed.
> >     One Intel driver got it wrong, others will as well.
> >   - rename all the queue macros to RTE_XXX variants.
> >     Seems like useless renaming and confusion.
> >   - Several distros have libbsd package with the correct macros.
> >     But adding yet another dependency to DPDK would be annoying
> >     for something this basic.
> >
> > There are more macros in FreeBSD header that could be useful,
> > but we can add those later as needed here.
> >
> >  lib/eal/include/rte_queue.h              | 174 =
+++++++++++++++++++++++
>=20
> Revisiting this and wondering about naming...
> The file rte_queue.h is not really DPDK (ie not related to runtime
> environment).
> Thinking of calling it bsd_queue.h as a compromise

Since it replaces sys/queue.h, then maybe sys_queue.h (or =
rte_sys_queue.h).

But more importantly:
It is not really DPDK, and thus shouldn't really be part of the EAL.
So here's an idea:
As part of de-bloating the EAL, can we somehow add a new directory =
structure for independent "libraries" like this?
And treat this rte_queue.h file as a "header file only" library, and put =
it there.
Then, build wise, the EAL could depend on this "library".

