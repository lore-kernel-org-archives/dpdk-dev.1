Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9770ED358E4
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 09:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 648054026F;
	Thu, 29 Jan 2026 10:00:20 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 043824026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 10:00:18 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 21C18206C2;
 Thu, 29 Jan 2026 10:00:18 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive path
Date: Thu, 29 Jan 2026 10:00:15 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656C7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260128170612.648cd657@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 4/4] net/af_packet: add VPP-style prefetching to receive
 path
Thread-Index: AdyQu38PanCuamB9T468veLh0Ufw6QAP+TJg
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-5-stephen@networkplumber.org>
 <20260128170612.648cd657@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "John W. Linville" <linville@tuxdriver.com>
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
> Sent: Thursday, 29 January 2026 02.06
>=20
> On Wed, 28 Jan 2026 09:30:20 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
>=20
> > Implement the single/dual/quad loop design pattern from FD.IO VPP to
> > improve cache efficiency in the af_packet PMD receive path.
> >
> > The original implementation processes packets one at a time in a
> simple
> > loop, which can result in cache misses when accessing frame headers
> and
> > packet data. The new implementation:
> >
> > - Processes packets in batches of 4 (quad), 2 (dual), and 1 (single)
> > - Prefetches next batch of frame headers while processing current
> batch
> > - Prefetches packet data before memcpy to hide memory latency
> > - Reduces loop overhead through partial unrolling
> >
> > Two helper functions are introduced:
> > - af_packet_get_frame(): Returns frame pointer at index with
> wraparound
> > - af_packet_rx_one(): Common per-packet processing (mbuf alloc,
> memcpy,
> >   VLAN handling, timestamp offload)
> >
> > The quad loop checks availability of all 4 frames before processing,
> > falling through to dual/single loops when fewer frames are ready.
> Early
> > exit paths (out_advance1/2/3) ensure correct frame index tracking
> when
> > mbuf allocation fails mid-batch.
> >
> > Prefetch strategy:
> > - Frame headers: prefetch N+4..N+7 while processing N..N+3
> > - Packet data: prefetch at tp_mac offset before memcpy
> >
> > This pattern is well-established in high-performance packet
> processing
> > and should improve throughput by better utilizing CPU cache
> hierarchy,
> > particularly beneficial when processing bursts of packets.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>=20
>=20
> This and previous proposal to prefetch have no impact on performance.
> Rolled a simple perf test and all three versions come out the same.

Please be aware that many test cases are inadvertently designed in a way =
where mbufs unintendedly are hot in the cache, so prefetching does not =
provide the expected performance gain.
E.g. when working on a newly allocated mbuf, the mbuf should be cold.
But if it came from the mempool cache, and was recently worked on and =
then freed into the mempool cache, then it will be hot.

> The bottleneck is not here, probably at system call and copies now.

The most important bottleneck might be elsewhere.
But this optimization might not be as irrelevant as the test results =
indicate.

Anyway, I agree that dropping the patch (for now) makes sense.

>=20
> 	Original	Prefetch	Quad/Dual
> TX	1.427 Mpps	1.426 Mpps	1.426 Mpps
>=20
> RX	0.529 Mpps	0.530 Mpps	0.533 Mpps
>  loss	87.93%		87.98%		88.0%
>=20
>=20
> 	Original	Prefetch	Quad/Dual
> TX	1.427 Mpps	1.426 Mpps	1.426 Mpps
>=20
> RX	0.529 Mpps	0.530 Mpps	0.533 Mpps
>  loss	87.93%		87.98%		88.0%
>=20
>=20
> Will put the test in the next version of this series, and
> drop this patch.

