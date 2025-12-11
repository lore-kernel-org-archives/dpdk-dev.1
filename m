Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1024D43357
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 21:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7139840289;
	Thu, 11 Dec 2025 22:45:28 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E63D64026F
 for <dev@dpdk.org>; Thu, 11 Dec 2025 22:45:26 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 96D4820B75;
 Thu, 11 Dec 2025 22:45:26 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/i40e: Fast release optimizations
Date: Thu, 11 Dec 2025 22:45:25 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655DC@smartserver.smartshare.dk>
In-Reply-To: <aTmnOwyh2u75Y3qp@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/i40e: Fast release optimizations
Thread-Index: Adxp9pNTDjvLgLDbQYevuLGXNddypwA7WSXg
References: <20250624061238.89259-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE25@smartserver.smartshare.dk>
 <aTmnOwyh2u75Y3qp@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	"Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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
> Sent: Wednesday, 10 December 2025 18.01
>=20
> On Mon, Aug 11, 2025 at 02:47:17PM +0200, Morten Br=F8rup wrote:
> > > From: Morten Br=F8rup [mailto:mb@smartsharesystems.com]
> > > Sent: Tuesday, 24 June 2025 08.13
> > >
> > > When fast releasing mbufs, the mbufs are not accessed, so do not
> prefetch
> > > them.
> > > This saves a mbuf load operation for each fast released TX mbuf.
> > >
> > > When fast release of mbufs is enabled for a TX queue, cache the
> mbuf
> > > mempool pointer in the TX queue structure.
> > > This saves one mbuf load operation for each burst of fast released
> TX
> > > mbufs.
> > >
> > > The txep->mbuf pointer is not used after the mbuf has been freed,
> so do
> > > not reset the pointer.
> > > This saves a txep store operation for each TX mbuf freed.
> > >
> > > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > ---
> >
> > After further consideration, I think this patch should be split in
> two:
> > 1. Remove superfluous code: prefetching mbufs and resetting txep-
> >mbuf pointers.
> > 2. Cache the mbuf mempool pointer for FAST_FREE.
> >
> Hi Morten,
>=20
> any plans for a new version of this patch (split or otherwise)? This =
is
> popped up again on my list in patchwork and want to decide what to do
> with
> it for this release. :-)
>=20
> /Bruce

I'll give it another shot.

I took another look at it today, and it looks like the txep->mbuf (i.e. =
sw_ring[].mbuf) is used by other cleanup functions, so not NULL'ing it =
needs more detailed review.

Anyway, prefetching the mbufs is a complete waste for fast free, where =
the mbufs are not being accessed at all. So there's still something to =
gain here.

Also, my assumption that txq->offloads is hotter than txq->fast_free_mp =
seems not to hold either, so I'll play around with that too.

I'm considering sending a series of patches with very small steps, so =
the individual changes are easy to review.

-Morten

