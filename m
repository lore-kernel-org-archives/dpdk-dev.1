Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53798C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:54:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FFBA4028E;
	Mon, 20 Jul 2026 12:54:51 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 66CB24028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 12:54:50 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 04FEA20534;
 Mon, 20 Jul 2026 12:54:50 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mempool cache change
Date: Mon, 20 Jul 2026 12:54:49 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6597F@smartserver.smartshare.dk>
In-Reply-To: <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mempool cache change
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0YH5SjfsFXjlU0QKq/8M95XJ0KeAAEYyLw
References: <b54ad1f1692a0274da705d446972efd1@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596D@smartserver.smartshare.dk>
 <e0b59e0b-1fb7-4a7b-84bb-9fc47f4feb5a@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6596E@smartserver.smartshare.dk>
 <CA+BST0kV0w7teE2h8OVZ5Ont-BCrf6rSxw9+t+Bbn8hx6xUwtA@mail.gmail.com>
 <aliq6kqGI2TfyFoH@bricha3-mobl1.ger.corp.intel.com>
 <00fe4a299adc03ff7d39ef943e62b921@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65979@smartserver.smartshare.dk>
 <al3YgIWkXNihHGMv@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Kishore Padmanabha" <kishore.padmanabha@broadcom.com>,
 "fengchengwen" <fengchengwen@huawei.com>, <dev@dpdk.org>,
 "Wisam Jaddo" <wisamm@nvidia.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
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
> Sent: Monday, 20 July 2026 10.13
>=20
> On Sat, Jul 18, 2026 at 04:07:05PM +0200, Morten Br=F8rup wrote:
> > > From: Kishore Padmanabha [mailto:kishore.padmanabha@broadcom.com]
> > > Sent: Friday, 17 July 2026 19.10
> > >
> > > Hi Bruce,
> > >
> > > The below patch works fine for us. We tested all the different
> packet
> > > sizes.
> > > Thanks for the patch. Do you want to push this patch since it is
> not
> > > changing the ABI/API?
> >
> > Too late in the release process.
> >
> > Let's postpone the discussion for DPDK 26.11, where API/ABI breakage
> is allowed.
>=20
> Agreed. Let's not unnecessarily rush this.
>=20
> >
> > I'm not strongly opposed to Bruce's algorithm, targeting a fill =
level
> of 25 % from the edges and flushing/refilling up to 75 % of the cache
> when necessary. It does have its advantages for some mempool access
> patterns (which are not exotic).
> > I just prefer the current algorithm, targeting a fill level of 50 %
> and only flushing/refilling up to 50 % of the cache when necessary. It
> performs better at random get/put access patterns, and the backend
> transactions are smaller.
> >
> > For DPDK 26.11, where we can break the API/ABI, we can simply double
> RTE_MEMPOOL_CACHE_MAX_SIZE to 1024, to compensate for reducing the
> effective cache size from 150 % to 100 %.
> > The mempool cache objs array will no longer be
> [RTE_MEMPOOL_CACHE_MAX_SIZE * 2], but only
> [RTE_MEMPOOL_CACHE_MAX_SIZE], so doubling RTE_MEMPOOL_CACHE_MAX_SIZE
> will not increase the memory footprint, but allow using a cache size =
up
> to 1024.
>=20
> My concern with this approach is that it won't automatically fix the
> problem if we have users who experience a performance regression due =
to
> the
> mempool changes. While testpmd allows the mbcache size to be provided
> via
> parameter, end applications are likely to have it hardcoded. That =
means
> that if an app does experience a regression, the author/user has to be
> either aware of the mempool changes, or has to debug it down to the
> mempool
> and then know to increase the mempool cache size in the app.
>=20
> It's not an insurmountable problem, but one that needs to be very
> clearly
> called out in our documentation, what the change is, how it may affect
> things and how to fix it.

The release notes [1] do mention that the mempool algorithm has changed, =
and how some applications should adapt to it.
They also do mention that the effective mempool cache size has changed, =
but not that applications can restore the previously 50 % larger =
effective cache size by simply requesting a 50 % larger cache.

Maybe we should move the notes about the mempool changes from the New =
Features section to the API Changes section, and mention how to increase =
the cache size to regain the reduction in effective size?

[1]: =
https://github.com/DPDK/dpdk/blob/v26.07-rc4/doc/guides/rel_notes/release=
_26_07.rst?plain=3D1#L80

>=20
> On the other hand, in realworld, i.e. not just testpmd/l3fwd cases
> doing
> little packet processesing, I would be fairly hopeful that regressions
> are
> going to be few and very small.

Yes.
And some real world applications (most run-to-completion applications?) =
will get fewer mempool cache misses with the new algorithm.
Best case a performance improvement exceeding the performance cost of =
the reduced effective cache size.

>=20
> >
> > Please also note that the current implementation is carefully
> designed to keep the transfers to/from the mempool backend CPU cache
> aligned (assuming cache->size is 2^N and large enough).
> > Refer to the parameters passed to
> rte_mempool_ops_enqueue/dequeue_bulk().
> > E.g. with mempool cache size 256, backend transfers are 128 objects,
> 16 full cache lines.
> > Using CPU cache aligned transfers has a few advantages:
> > - There are no cache line ownership issues across different CPU =
cores
> repeatedly accessing the backend.
> > - The mempool backend drivers can be performance optimized for
> transferring full CPU cache lines. (Both source and destination
> addresses, and number of objects copied, are CPU cache aligned.
> Assuming all transfers go via the mempool cache.)
> >
> > These details should be fine tuned in the implementation, if we do
> proceed with Bruce's algorithm.
> >
> Yep, good points.
>=20
> /Bruce

PS:
I have some API/ABI breaking mempool optimizations in the pipeline for =
DPDK 26.11.
But let's try to concentrate on DPDK 26.07 for now. ;-)

