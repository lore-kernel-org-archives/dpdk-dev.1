Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B61E6BF00
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:16:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F4E340274;
	Fri, 30 Jan 2026 12:16:48 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5D4D340150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:16:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 845AA2081A;
 Fri, 30 Jan 2026 12:16:46 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 1/2] net: ethernet address comparison optimizations
Date: Fri, 30 Jan 2026 12:16:43 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656D4@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] net: ethernet address comparison optimizations
Thread-Index: AdyR1p+6T9C2PyZbRXmpQGMhQmhi4AAAEPrQ
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Friday, 30 January 2026 11.53
>=20
> On Fri, Jan 30, 2026 at 10:46:16AM +0000, Morten Br=F8rup wrote:
> > For CPU architectures without strict alignment requirements,
> operations on
> > 6-byte Ethernet addresses using three 2-byte operations were =
replaced
> by a
> > 4-byte and a 2-byte operation, i.e. two operations instead of three.
> >
> > Comparison functions are pure, so added __rte_pure.
> >
> > Removed superfluous parentheses. (No functional change.)
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  lib/net/rte_ether.h | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> > index c9a0b536c3..5552d3c1f6 100644
> > --- a/lib/net/rte_ether.h
> > +++ b/lib/net/rte_ether.h
> > @@ -99,13 +99,19 @@ static_assert(alignof(struct rte_ether_addr) =
=3D=3D
> 2,
> >   *  True  (1) if the given two ethernet address are the same;
> >   *  False (0) otherwise.
> >   */
> > +__rte_pure
> >  static inline int rte_is_same_ether_addr(const struct =
rte_ether_addr
> *ea1,
> >  				     const struct rte_ether_addr *ea2)
> >  {
> > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const
> unaligned_uint32_t *)ea2)[0]) |
> > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t
> *)ea2)[2])) =3D=3D 0;
> > +#else
> >  	const uint16_t *w1 =3D (const uint16_t *)ea1;
> >  	const uint16_t *w2 =3D (const uint16_t *)ea2;
> >
> >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) =
=3D=3D
> 0;
> > +#endif
> >  }
>=20
> Is this actually faster?

It's a simple micro-optimization, so I haven't benchmarked it.
On x86, the compiled function is simplified and reduced in size from 34 =
to 24 bytes:

00000000004ed650 <review_rte_is_same_ether_addr>:
  4ed650:	0f b7 07             	movzwl (%rdi),%eax
  4ed653:	0f b7 57 02          	movzwl 0x2(%rdi),%edx
  4ed657:	66 33 06             	xor    (%rsi),%ax
  4ed65a:	66 33 56 02          	xor    0x2(%rsi),%dx
  4ed65e:	09 d0                	or     %edx,%eax
  4ed660:	0f b7 57 04          	movzwl 0x4(%rdi),%edx
  4ed664:	66 33 56 04          	xor    0x4(%rsi),%dx
  4ed668:	66 09 d0             	or     %dx,%ax
  4ed66b:	0f 94 c0             	sete   %al
  4ed66e:	0f b6 c0             	movzbl %al,%eax
  4ed671:	c3                   	ret
  4ed672:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  4ed679:	00 00 00 00=20
  4ed67d:	0f 1f 00             	nopl   (%rax)

00000000004ed680 <rte_is_same_ether_addr_improved>:
  4ed680:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
  4ed684:	66 33 46 04          	xor    0x4(%rsi),%ax
  4ed688:	8b 17                	mov    (%rdi),%edx
  4ed68a:	33 16                	xor    (%rsi),%edx
  4ed68c:	0f b7 c0             	movzwl %ax,%eax
  4ed68f:	09 c2                	or     %eax,%edx
  4ed691:	0f 94 c0             	sete   %al
  4ed694:	0f b6 c0             	movzbl %al,%eax
  4ed697:	c3                   	ret
  4ed698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  4ed69f:	00

For reference, memcpy() of 6 bytes (compile time constant) also compiles =
to a 4-byte and a 2-byte operation, not three 2-byte operations.

> For architectures that support strict alignment,
> this looks like something that the compilers should be doing using
> proper
> cost-benefit evaluation based on target architecture, rather than us
> doing
> it in our code.

I agree with the high level message in your comment.
DPDK contains some manual optimizations from back in the days, and the =
evolvement of compilers have made some of them obsolete.

In this case, GCC doesn't optimize it, so I did it manually.
I haven't checked if other compilers are clever enough to do it.

