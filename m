Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E91C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 10:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 674994021F;
	Thu, 22 Jan 2026 11:49:53 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B789440156
 for <dev@dpdk.org>; Thu, 22 Jan 2026 11:49:51 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B8A3E20AD6;
 Thu, 22 Jan 2026 11:49:50 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 6/6] ring: use inline instead of always inline in soring
Date: Thu, 22 Jan 2026 11:49:46 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6568B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4228c7fda1614bea9e37d87bfdb84b1d@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 6/6] ring: use inline instead of always inline in
 soring
Thread-Index: AQHcikag8bMJdWJ7zUuHT+fw9FxQE7Vd9MYAgAAOwIA=
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
 <20260120195418.466318-7-stephen@networkplumber.org>
 <4228c7fda1614bea9e37d87bfdb84b1d@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Cc: "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>
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

> > When LTO is enabled, GCC inlines through the entire soring call =
chain
> > from test code into the ring element copy functions. With
> always_inline,
> > the compiler is forced to inline __rte_ring_dequeue_elems_128() =
which
> > copies 32 bytes per element. GCC's static analysis then warns about
> > potential buffer overflow because it cannot prove the 128-bit =
element
> > path is unreachable when the ring is configured for 4-byte elements:
> >
> >   warning: writing 32 bytes into a region of size 0 [-Wstringop-
> overflow=3D]
> >
> > By using plain inline instead of always_inline on the soring enqueue
> > and dequeue functions, the compiler regains discretion over inlining
> > decisions. This introduces an analysis boundary that prevents GCC
> from
> > connecting the test's buffer sizes to the unreachable 128-bit code
> path,
> > eliminating the false positive warning.
> >
> > Performance impact is expected to be negligible. At -O2/-O3, the
> > compiler will still inline these small, hot functions based on its
> > own heuristics. The difference only matters in debug builds or with
> > -Os, where slightly less aggressive inlining is acceptable.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/ring/soring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/ring/soring.c b/lib/ring/soring.c
> > index 797484d6bf..3b90521bdb 100644
> > --- a/lib/ring/soring.c
> > +++ b/lib/ring/soring.c
> > @@ -249,7 +249,7 @@ __rte_soring_stage_move_head(struct
> > soring_stage_headtail *d,
> >  	return n;
> >  }
> >
> > -static __rte_always_inline uint32_t
> > +static inline uint32_t
> >  soring_enqueue(struct rte_soring *r, const void *objs,
> >  	const void *meta, uint32_t n, enum rte_ring_queue_behavior
> behavior,
> >  	uint32_t *free_space)
> > @@ -278,7 +278,7 @@ soring_enqueue(struct rte_soring *r, const void
> *objs,
> >  	return n;
> >  }
> >
> > -static __rte_always_inline uint32_t
> > +static inline uint32_t
> >  soring_dequeue(struct rte_soring *r, void *objs, void *meta,
> >  	uint32_t num, enum rte_ring_queue_behavior behavior,
> >  	uint32_t *available)
> > --
>=20
> Run quick test, no perf degradation noticed.
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

We want LTO to work, and the alternatives discussed in another thread =
[1] are not popular.
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

[1]: =
https://inbox.dpdk.org/dev/20260116064646.224254-2-stephen@networkplumber=
.org/

