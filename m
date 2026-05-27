Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF1CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0AAF40674;
	Wed, 27 May 2026 13:17:49 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B45A340653
 for <dev@dpdk.org>; Wed, 27 May 2026 13:17:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 842F0208E7;
 Wed, 27 May 2026 13:17:48 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC v2 2/3] lib: add fastmem library
Date: Wed, 27 May 2026 13:17:45 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658A1@smartserver.smartshare.dk>
In-Reply-To: <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC v2 2/3] lib: add fastmem library
Thread-Index: AdztwioTDSwFgRj0Tfi9oqXfmSlkLwAAeqqg
References: <20260525103642.55255-4-hofors@lysator.liu.se>
 <20260526085743.64396-1-hofors@lysator.liu.se>
 <20260526085743.64396-3-hofors@lysator.liu.se>
 <20260526062312.33f76fcc@phoenix.local>
 <b3982582-3023-4f2c-9c62-10d4af20d4e2@lysator.liu.se>
 <ahbE6KvlgzG_XkSY@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <hofors@lysator.liu.se>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <mattias.ronnblom@ericsson.com>,
 "Yogaraj Baskaravel" <yogaraj.baskaravel@ericsson.com>
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
> Sent: Wednesday, 27 May 2026 12.18
>=20
> On Wed, May 27, 2026 at 12:12:19PM +0200, Mattias R=F6nnblom wrote:
> > On 5/26/26 15:23, Stephen Hemminger wrote:
> > > On Tue, 26 May 2026 10:57:42 +0200
> > > Mattias R=F6nnblom <hofors@lysator.liu.se> wrote:
> > >
> > > > +__rte_experimental
> > > > +void *
> > > > +rte_fastmem_alloc(size_t size, size_t align, unsigned int =
flags)
> > > > +	__rte_alloc_size(1) __rte_alloc_align(2);
> > >
> > > Should also add attribute __rte_malloc which tells compiler
> > > that pointer returned cannot alias other memory
> > >
> > > And add __rte_dealloc(rte_fastmem_free, 1)
> > > which tells compiler that the returned pointer should only go
> > > back to fastmem (not free, rte_free, etc).
> >
> > Done. Only works for the single-object ops (not bulk) though.
> >
> > I've had a look at how to extend fastmem to support larger
> allocations
> > (without suggesting this is the way to go).
> >
> > Seems to me that implementation should be something like
> > a) slab allocator for small objects.
> > b) a cache-less per-socket page run allocator for mid-sized objects.
> > c) per-object memzones for large objects.

All allocations through the library should somehow build on memzones.
If an application wants "normal" memory, it can use libc =
free()/malloc().

> >
> > If one would implement that, you would essentially have a plug-in
> > replacement for rte_malloc.h (maybe minus some debug and some more
> esoteric
> > DPDK heap features).
> >
> > Should fastmem be an outright replacement, or something that at =
least
> > initially lives alongside the regular heap, maybe with a run- or
> > compile-time option to make rte_malloc.h functions delegate to
> fastmem? This
> > is unclear to me at this point. I fear the more ambitious, cleaner
> and more
> > risky DPDK heap replacement path will go they way my attempts to
> replace
> > rte_memcpy or rte_timer went.
> >
> > I would agree with anyone saying that we should have only one heap-
> like API
> > for memory allocations. rte_malloc.h obviously needs to stay, for
> backward
> > compatibility reason, if nothing else. I would like to add bulk
> alloc/free,
> > and allow for smaller alignments than 64, since slabs can do that
> > efficiently (DPDK heap per-object header is 128 bytes!). One could
> either go
> > about that by extending rte_malloc.h or deprecating that API and
> starting
> > anew. In the latter case, one could do many more minor tweaks, like
> removing
> > the type pointers (only a nuance), remove the validate function,
> change and
> > extend the stats interface, etc.
> >
> +1 for replacing rte_malloc. For a replacement, I'd tend towards =
aiming
> for
> compatibilty over trying to fix too many little things at once. While
> changing a couple of things is ok, I'd rather not force applications =
to
> make too many updates to their code when moving from one DPDK version
> to
> another.
>=20
> /Bruce

+1 for taking the path that begins with starting anew.
The new heap library can be designed specifically for the fast path, =
based on years of DPDK experience with what the fast path really needs.
It will allow much broader experimentation along the way.
We can easily get rid of all slow path legacy stuff in rte_malloc, like =
the "type" parameter.

I think we all agree that replacing rte_malloc should be the end game.
But IMO, it very important that the properties of rte_malloc do not =
impose any limits on the new heap library.

Someday, when the new library has sufficiently matured, we can discuss =
how it can replace the rte_malloc library.
Maybe some parts of rte_malloc are not replaceable, and need to be =
deprecated and removed.
Maybe we all have switched to using the new heap, and nobody is using =
rte_malloc anymore, so it can simply be removed. ;-)

Suggestion regarding naming:
The prefix could be "rte_mem_" instead of "rte_fastmem_" - it is =
shorter, and most libraries are "fast".
And then it could live in /lib/memory instead of /lib/fastmem.

