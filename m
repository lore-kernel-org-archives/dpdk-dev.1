Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9FC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 16:28:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E0D840264;
	Wed, 12 Aug 2026 18:28:40 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 33D214025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 18:28:39 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0C10520FD2;
 Wed, 12 Aug 2026 18:28:39 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] stack: introduce pile
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 18:28:36 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659DC@smartserver.smartshare.dk>
In-Reply-To: <anycOPsfQs2cbZLf@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] stack: introduce pile
Thread-Index: Ad0qdeEhuyqJYJ9XRNm4T9MUmnPEfgAAGMaA
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <anyEWVXfFEHBbsAJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659DB@smartserver.smartshare.dk>
 <anycOPsfQs2cbZLf@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Wednesday, 12 August 2026 18.16
>=20
> On Wed, Aug 12, 2026 at 06:01:31PM +0200, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Wednesday, 12 August 2026 16.34
> > >
> > > On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Br=F8rup wrote:
> > > > Added a new high-performance lock-free "pile", using the Stack
> API.
> > > > The pile behaves roughly like a stack, but is not strictly LIFO.
> > > >
> > > > The pile is optimized for pushing/popping bulks of objects, =
which
> > > > it does significantly faster than the lock-free stack.
> > > >
> > > > Pushing/popping a number of objects not divisible by the compile
> time
> > > > configurable bulk size is handled gracefully, but not as fast as
> > > > complete bulks.
> > > >
> > > > Performance examples, stack_pile_perf_autotest vs.
> stack_lf_autotest:
> > > >
> > > > On a single core, pushing/popping 1 or 8 objects is similar
> speed.
> > > > On a single core, pushing/popping 32 objects is 2x faster.
> > > > On a single core, pushing/popping 512 objects is 10x faster.
> > > >
> > > > On four cores, pushing/popping 1, 8 or 32 objects is slightly
> faster.
> > > > On four cores, pushing/popping 512 objects is 4x faster.
> > > >
> > > How does it differ, or what are the benefits vs the standard =
stack.
> >
> > The standard stack is generally faster on single core.
> > Only pushing/popping 512 objects is slightly faster than the =
standard
> stack, but maybe the standard stack could be microoptimized to fix
> that.
> >
> > On four cores, it is slightly faster than the standard stack with
> multiple objects:
> >
> > stack_perf_autotest
> > Average cycles per object push/pop (bulk size: 1): 3806.65
> > Average cycles per object push/pop (bulk size: 8): 554.77
> > Average cycles per object push/pop (bulk size: 32): 144.70
> > Average cycles per object push/pop (bulk size: 512): 13.52
> >
> > stack_pile_perf_autotest
> > Average cycles per object push/pop (bulk size: 1): 4012.39
> > Average cycles per object push/pop (bulk size: 8): 459.82
> > Average cycles per object push/pop (bulk size: 32): 122.40
> > Average cycles per object push/pop (bulk size: 512): 9.60
> >
> >
> > > The
> > > LF
> > > stack I'd view as a strange edge case, since even with the =
standard
> > > MP/MC
> > > ring mempool driver you still have atomics on the fast-path and =
you
> > > will
> > > still get stalls if a thread gets context switched out in the
> middle of
> > > a
> > > mempool operation.
> >
> > Yes, the no-stall guarantee is a key benefit of the lock-free stack
> and the pile.
> >
>=20
> Ok, that is good. Next question, rather than adding a whole new =
mempool
> driver implementation, can we use this to replace one of the existing
> stack
> implementations? Do we need to have so many mempool stack drivers
> generally?

We could consider replacing the lock-free stack implementation by the =
pile implementation, but the pile is not strictly LIFO, so it seems =
risky.

For a mempool holding mbufs, there's probably no harm in the difference.
But for a mempool holding some other object type, it could be harmful. I =
don't know.
IMO, not worth the risk.

Good idea, though!
I'm usually in favor of cleaning up. Just not this one. :-)

