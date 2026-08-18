Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D72C5DF81
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 08:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26F004027C;
	Tue, 18 Aug 2026 10:50:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C23E140269
 for <dev@dpdk.org>; Tue, 18 Aug 2026 10:50:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 74E1D20E0F;
 Tue, 18 Aug 2026 10:50:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] stack: introduce pile
Date: Tue, 18 Aug 2026 10:50:54 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659EA@smartserver.smartshare.dk>
In-Reply-To: <898dbda9dea547649b1ad6781a356090@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] stack: introduce pile
Thread-Index: AQHdKmHxOTsi6KhTAk+e68voB41GrLaiLgIAgAFLs5CAAApIEA==
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <aoMIQo7y_DyafUDg@bricha3-mobl1.ger.corp.intel.com>
 <898dbda9dea547649b1ad6781a356090@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

> From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> Sent: Tuesday, 18 August 2026 10.12
>=20
> > On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Br=F8rup wrote:
> > > Added a new high-performance lock-free "pile", using the Stack =
API.
> > > The pile behaves roughly like a stack, but is not strictly LIFO.
> > >
> > > The pile is optimized for pushing/popping bulks of objects, which
> > > it does significantly faster than the lock-free stack.
> > >
> > > Pushing/popping a number of objects not divisible by the compile
> time
> > > configurable bulk size is handled gracefully, but not as fast as
> > > complete bulks.
> > >
> > > Performance examples, stack_pile_perf_autotest vs.
> stack_lf_autotest:
> > >
> > > On a single core, pushing/popping 1 or 8 objects is similar speed.
> > > On a single core, pushing/popping 32 objects is 2x faster.
> > > On a single core, pushing/popping 512 objects is 10x faster.
> > >
> > > On four cores, pushing/popping 1, 8 or 32 objects is slightly
> faster.
> > > On four cores, pushing/popping 512 objects is 4x faster.
> > >
> > > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > ---
> > >  app/test/test_stack.c               |  71 +++++-
> > >  app/test/test_stack_perf.c          |  15 +-
> > >  config/rte_config.h                 |   3 +
> > >  doc/guides/prog_guide/stack_lib.rst |  67 +++++-
> > >  lib/mempool/rte_mempool.h           |   2 +-
> > >  lib/stack/meson.build               |   3 +-
> > >  lib/stack/rte_stack.c               |  18 +-
> > >  lib/stack/rte_stack.h               |  79 +++++++
> > >  lib/stack/rte_stack_lf.h            |   1 +
> > >  lib/stack/rte_stack_pile.c          |  35 +++
> > >  lib/stack/rte_stack_pile.h          | 334
> ++++++++++++++++++++++++++++
> > >  11 files changed, 609 insertions(+), 19 deletions(-)
> > >  create mode 100644 lib/stack/rte_stack_pile.c
> > >  create mode 100644 lib/stack/rte_stack_pile.h
> > >
> > Looking at this a little closer, and thinking some more, here are
> some of
> > my further thoughts/ideas on this:
> >
> > * For most cases using a mempool, I can't see having non-strict LIFO
> >   behaviour being an issue, and there is nothing in the mempool API
> that
> >   makes any ordering guarantees about what buffers get given by
> get/put,
> >   and in fact we can't make any guarantees because of the fact of
> multiple
> >   cores doing allocs and frees. Therefore, for the mempool driver, I
> >   believe one pre-emptible implementation is enough, so therefore =
the
> pile
> >   mempool driver should just replace the current LF one.
> > * For apps which may want to use the stack structs directly, not
> through a
> >   mempool, I can see that having defined ordering behaviour may be
> >   beneficial. However, if multiple cores are involved, then we can
> never
> >   guarantee ordering, I believe, so I'm not sure its worth trying to
> >   enforce strict LIFO for such cases. [If you need the same elements
> back
> >   in the correct order from a core, then use a regular stack without
> sharing
> >   it].
> > * IF we decide that we really, really want LIFO ordering across
> multiple
> >   cores - despite the likely random ordering of allocs/frees between
> those
> >   cores, I still think that this implementation should replace the =
LF
> >   stack. If we reverse the order of elements on enqueue (or dequeue)
> then
> >   we should be closer to correct LIFO ordering - and fully lifo if
> allocs
> >   and frees are based on multiples of the burst size.
> >
> > I suppose for me the main question to be resolved is - do we have
> scenarios
> > where we a) have multi-core operation on the stacks and b) =
absolutely
> must
> > have strict LIFO ordering? In the absense of that, I'd very much be
> in
> > favour of replacing the existing LF implementation completely with
> this
> > one.
>=20
> I am agree with Bruce - it is probably worth to replace current =
lfstack
> implementation with this new one,
> as new one is proved to be way much faster.

I agree too.

> One more observation: instead of making RTE_STACK_PILE_BULK_SIZE
> compile time constant,
> why not to make it configurable variable (at lfstack instance creation
> time)?

Build time constant allows compiler optimization (e.g. loop unrolling).

> Then in theory we can support current behavior too - user can create a
> pile with no bulks,
> and all requests will go via solo code-path.
> That way we'll have good perf improvement, while preserving old-
> behavior compatibility for those
> who needs it.

I'd rather have two purpose-built variants than one variant with an =
integer parameter which only actual purpose is being used as a Boolean =
parameter to switch between two different modes of operation.

> Though have to admit, I don't know any off-hand who will need it :)

Exactly!
DPDK has many questionable knobs for runtime configurability.
E.g. a lot of the thresholds in the drivers are configurable.
For which purposes?
If they were fixed (or build time configurable), the compiler could =
optimize more.
If there are use case driven needs for different modes of operation, a =
Boolean or enum (or an array of flags) would suffice.
Like we have discussed for the mempool cache algorithm; the number of =
use cases with different requirements is limited.

