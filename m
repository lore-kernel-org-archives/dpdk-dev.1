Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BA0108E1E6
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 10:55:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40A8F402D1;
	Thu, 19 Mar 2026 11:55:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 456A34013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 11:55:13 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 14BD8205CA;
 Thu, 19 Mar 2026 11:55:13 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] doc: remove obsolete mempool creation advice
Date: Thu, 19 Mar 2026 11:55:11 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657A4@smartserver.smartshare.dk>
In-Reply-To: <abvEoELb6QIAHBnW@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH] doc: remove obsolete mempool creation advice
Thread-Index: Ady3hICDkVm203z9QUyg89TD98sObAAAYo8g
References: <20260319091300.652853-1-mb@smartsharesystems.com>
 <abvEoELb6QIAHBnW@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
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
> Sent: Thursday, 19 March 2026 10.41
>=20
> On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Br=F8rup wrote:
> > The descriptions for the mempool creation functions contained advice
> for
> > choosing the optimum (in terms of memory usage) number of elements
> and
> > cache size.
> > The advice was based on implementation details, which was changed
> long
> > ago, making the advice completely irrelevant.
> >
>=20
> The comment is still correct in most cases, since the default backing
> storage remains an rte_ring. If passing a power-of-2 size to mempool
> create
> one will get a backing rte_ring store which is twice as large as
> requested,
> leading to lots of ring slots being wasted. For example, for a pool
> with
> 16k elements, the actual ring size allocated will be 32k, leading to
> wasting 128k of RAM, and also potentially cache too. The latter will
> occur
> because of the nature of the ring to iterate through all mempool/ring
> entries, meaning that even if only 16k of the 32k slots will ever be
> used,
> all 32k slots will be passed through the cpu cache if it works on the
> mempool directly and not just from the per-core cache.

You are right about the waste of memory in the ring driver. And good =
point about the CPU cache!

However, only pointer entries (8 byte each) are being wasted, not object =
entries (which are much larger). This is not 100 % clear from the =
advice.

Furthermore, with 16k mbufs of 2368 byte each, the mempool itself =
consumes 37 MB worth of memory, so do we really care about wasting 128 =
KB?

IMHO, removing the advice improves the quality of the documentation.
I don't think a detail about saving 0.3 % of the memory used by the =
mempool should be presented so prominently in the documentation.

Obviously, the memory waste percentage for a mempool holding smaller =
objects will be larger.
With 64 byte objects (+64 byte object header), the waste is 8 bytes in =
the ring driver per 128 bytes in the mempool itself, ca. 6 %.
Still relatively small.

Alternatively, we could keep the advice and change the wording. =
Something like:

If the mempool uses a ring driver, the optimum size (in terms of memory) =
is when n is a power of two minus one, n =3D (2^q - 1); otherwise the =
ring's array of pointers to the objects will be larger, as it's size is =
aligned to the next power of 2.

It's difficult to keep the advice short, if we add the fine print to it.

But then the advice is still missing for all the other mempool drivers =
using nonlinear memory allocation.
I'm not sure, but I think the "bucket" driver also uses nonlinear memory =
allocation.

Another alternative:
The mempool drivers or underlying libraries could log a debug message =
when allocating an oversize array for alignment reasons.

>=20
> On the other hand, I'd be in favour of removing this text if we
> switched
> the default mempool in DPDK to being stack-based. While the stack may
> not
> be lock-free like the ring, with per-lcore caches the number of
> accesses to
> the stack should be small, and it gives much better cache utilization
> overall - especially in cases where buffers are allocated on one core
> and
> freed on a different one! Even in cases where we are not transferring
> between cores, in a single-core case we still will get better reuse of
> "hot" buffers than in an rte_ring-backed case.

<jokingly>
The lock free stack driver's reference to each object uses 2 pointers, =
so guaranteed waste of memory here.
</jokingly>

Let's discuss changing the default mempool driver some other day, and =
focus on the documentation for now.

I get your point, though.
It makes sense that the documentation for a library considers the =
underlying default implementation.

But if it does, the advice should come with a disclaimer mentioning when =
it applies.

