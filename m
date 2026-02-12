Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C857FEB491B
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0304F4027A;
	Thu, 12 Feb 2026 13:38:24 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7FBCA40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:38:22 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4816E208FB;
 Thu, 12 Feb 2026 13:38:22 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 23/35] net/intel: use separate array for desc status
 tracking
Date: Thu, 12 Feb 2026 13:38:18 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65712@smartserver.smartshare.dk>
In-Reply-To: <aY2aFd52IkCRO2x6@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 23/35] net/intel: use separate array for desc status
 tracking
Thread-Index: AdycAB1d37wYLXBQSdWNkxM5LLTaswAG9T5Q
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-24-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65711@smartserver.smartshare.dk>
 <aY2aFd52IkCRO2x6@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
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
> Sent: Thursday, 12 February 2026 10.15
>=20
> On Wed, Feb 11, 2026 at 10:51:56PM +0100, Morten Br=F8rup wrote:
> > > Rather than writing a last_id for each individual descriptor, we
> can
> > > write one only for places where the "report status" (RS) bit is
> set,
> > > i.e. the descriptors which will be written back when done. The
> method
> > > used for marking what descriptors are free is also changed in the
> > > process, even if the last descriptor with the "done" bits set is
> past
> > > the expected point, we only track up to the expected point, and
> leave
> > > the rest to be counted as freed next time. This means that we
> always
> > > have the RS/DD bits set at fixed intervals, and we always track
> free
> > > slots in units of the same tx_free_thresh intervals.
> >
> > I'm not saying it's good or bad, I'm simply trying to understand the
> performance tradeoff...
> > I'm wondering if spreading fields over two separate arrays is
> beneficial when considering cache misses.
> >
> > This patch introduces a separate array, uint16_t txq->rs_last_id[],
> which is not in the same cache line as the txe array.
> >
> > So now, two separate cache lines must be updated, rs_last_id and =
txe.
> >
> > Previously, only txe needed updating.
> >
> > Assuming both rings are cold, how many cache misses would a burst of
> 32 (single-segment) packets cause...
> > Number of cache misses in the txe ring (before this patch, and
> after)?
> > Number of cache misses in the rs_last_id ring (after this patch)?
> >
>=20
> The main txe ring has 4 elements per cacheline both before and after
> this
> patch. As an aside, 6 bytes of each 16 is wasted, and I have tried a
> couple of
> times to get us down to an 8 byte ring element and each time
> performance
> has dropped, presumably due to extra computation and branching for =
ring
> wraparound when we remove the precomputed next index values.
>=20
> Anyway, for 32 single-segment packets, we obviously touch 8 cachelines
> both
> before an after this patch in the txe array. In the next_rs array, we
> should just read a single index, of 16 bytes, so the overall array has
> a
> fairly small cache footprint, 2 bytes per 32 ring entries. [Or one
> cacheline for a 1024-sized ring]
>=20
> However, the performance improvements given by the rework of the
> cleanup
> handling are very noticible and not really to do with memory/cache
> footprint so much as doing less work, and less branching. For example:
>=20
> * before this patch, on transmit we stored the index of the last
> descriptor
>   for each segment of each packet. It was to a hot cacheline, but it
> was still
>   (if no coalescing) potentially 32 stores per burst. After this =
patch,
> we
>   instead only store the index of the last segment for the packet
> crossing
>   the next multiple of 32 boundary. Going from potentially 32 stores =
to
> 1.
>=20
> * When doing cleanup post transmit, we still have an array lookup to
>   determine the location of the NIC write back to indicate descriptor
> done.
>   However, while before this was being done to the txe array - which
> was
>   written (ring_size - 32) packets ago - it's now done by reading the
> new,
>   tiny rs_next_id array which is more likely to be in cache.
>=20
> * finally, when doing the actual buffer freeing, before we would have
> an
>   arbitrary number of buffers - though normally 32 - to be freed from
> the
>   ring starting at an arbitrary location. After this patch, we always
> have
>   exactly 32 (or more correctly rs_thresh, which must divide evenly
> into
>   ring_size) buffers to be freed starting at an index which is a
> multiple of
>   32, and which therefore, most importantly, guarantees that we do not
> have
>   any wraparound as part of the buffer free process. This means no
> branches
>   for idx >=3D ring_size etc., and that we are free to treat the =
buffers
> to
>   be freed as being stored in a linear array.

OK.
Thank you for the detailed explanation.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

>=20
> >
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > ---

