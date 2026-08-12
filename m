Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC28C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 15:01:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C85E40298;
	Wed, 12 Aug 2026 17:01:46 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 891CC40298
 for <dev@dpdk.org>; Wed, 12 Aug 2026 17:01:44 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5D52F20FD2;
 Wed, 12 Aug 2026 17:01:44 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: mempool cache change
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:01:42 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659DA@smartserver.smartshare.dk>
In-Reply-To: <al8317iuWn7_MpJQ@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mempool cache change
Thread-Index: Ad0Y8QBJtuHThoi0RhWV4rfCaI3uEgRdWndg
References: <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
 <CAOaVG17Ay+b1Hio90Mgq0jrYwFegxOmQ-+2ezXF_cSrk1Zi90g@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65984@smartserver.smartshare.dk>
 <al8317iuWn7_MpJQ@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
 "fengchengwen" <fengchengwen@huawei.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, "dev" <dev@dpdk.org>,
 "Wisam Jaddo" <wisamm@nvidia.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
> Sent: Tuesday, 21 July 2026 11.12
>=20
> On Tue, Jul 21, 2026 at 11:02:34AM +0200, Morten Br=F8rup wrote:
> >    The mempool cache size is configurable.
> >
> >    The application developer should configure it to strike a balance
> >    between the two performance parameters:
> >
> >    - Throughput: Large mempool cache reduces the number of backend
> >    transfers.
> >
> >    - Latency: Large mempool cache causes latency spikes (CPU cache
> misses)
> >    when transferring objects from/to cold backend memory.
> >
> >
> Since 26.11 is an ABI break release, perhaps we can reconsider the
> option
> to have the "keep" value configurable for the mempool caches, i.e. for
> random alloc/free's set it to 50% like you have, or 25% as proposed by
> my
> patch, while for pipeline apps it should be set to 0%. Rather than us
> constantly arguing^H^H^H discussing what the value should be, we can
> make
> it tunable for the developer?
>=20
> As an alternative version of that proposal, we can simplify and just
> have a
> couple of predefined simple profiles for 2 or 3 values, one for
> pipeline
> apps, and one or two for run-to-completion, rather than exposing the
> whole
> range of possibilities to the user.

At this time, I'm not planning major changes to the mempool cache =
algorithm.

I have sent a patch [DIV32] requiring the mempool cache size to be =
divisible by 32.
This opens a road towards operating on the mempool cache in chunks of 32 =
objects.

Bruce strongly hinted that the ring driver might not be optimal for mbuf =
pools,
so I played around with the lock-free stack mempool driver, and it is =
extremely slow.
To address this issue, I developed a faster stack-like "pile" =
[PILE-STACK] and a mempool driver [PILE-MEMPOOL] on top of it.

All this playing around and working with the details got me thinking. =
Which leads back to the subject of 32-object chunks...
The current mempool cache algorithm is targeting large flush/replenish =
operations.
If the mempool driver is slow (and its runtime scales with the number of =
objects), large operations will cause latency spikes.

A new algorithm could take a different approach to address latency =
spikes, targeting small driver operations instead of large driver =
operations:
When pulling objects from a cache with insufficient objects, only refill =
the necessary number of objects to satisfy the request, rounded up to =
32-object chunks.
When pushing objects from a cache with insufficient space, only flush =
the necessary number of objects to satisfy the request, rounded up to =
32-object chunks.

As a further optimization, instead of moving objects down in the stack =
when flushing from the bottom, we could use an integer offset to point =
at the bottom of the stack, and wrap around the index at size when =
accessing the array. E.g. for push:
for (i =3D 0; i < num; i++) cache->objs[(cache->bottom + cache->len + i) =
% size] =3D obj_table[i];

I don't have plans to implement such an algorithm (or the bottom offset) =
for DPDK 26.11.
Just sharing my thoughts.

[DIV32]: =
https://patchwork.dpdk.org/project/dpdk/patch/20260812120626.1772120-1-mb=
@smartsharesystems.com/
[PILE-STACK]: =
https://patchwork.dpdk.org/project/dpdk/patch/20260812134756.1829613-1-mb=
@smartsharesystems.com/
[PILE-MEMPOOL]: =
https://patchwork.dpdk.org/project/dpdk/patch/20260812141511.1854348-1-mb=
@smartsharesystems.com/

