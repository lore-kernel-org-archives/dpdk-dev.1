Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07045CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 13:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1927B40276;
	Wed, 22 Oct 2025 15:53:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1F57A4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 15:53:25 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E05D92041E;
 Wed, 22 Oct 2025 15:53:24 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] mbuf: optimize segment prefree
Date: Wed, 22 Oct 2025 15:53:21 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654EE@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aPifDTMMaD2FRMun@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] mbuf: optimize segment prefree
Thread-Index: AdxDM3kjO7gBiTKGSjiT+GTjKxT8WwAJNM+g
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251020120202.80114-1-mb@smartsharesystems.com>
 <aPifDTMMaD2FRMun@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>
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
> Sent: Wednesday, 22 October 2025 11.08
>=20
> On Mon, Oct 20, 2025 at 12:02:01PM +0000, Morten Br=F8rup wrote:
> > Refactored rte_pktmbuf_prefree_seg() for both performance and
> readability.
> >
> > With the optimized RTE_MBUF_DIRECT() macro, the common likely code
> path
> > now fits within one instruction cache line on x86-64 when built with
> GCC.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
>=20
> Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
>=20

[...]

> >  #define RTE_MBUF_DIRECT(mb) \
> >  	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
> >
> > +#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
> > +/* Optimization for code size.
> > + * GCC only optimizes single-bit MSB tests this way, so we do it by
> hand with multi-bit.
> > + *
> > + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both =
in
> the MSB of the
> > + * 64-bit ol_flags field, so we only compare this one byte instead
> of all 64 bits.
> > + * On little endian architecture, the MSB of a 64-bit integer is at
> byte offest 7.
> > + *
> > + * Note: Tested using GCC version 16.0.0 20251019 (experimental).
> > + *
> > + * Without this optimization, GCC generates 17 bytes of
> instructions:
> > + *      movabs rax,0x6000000000000000       // 10 bytes
> > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > + *      sete   al                           // 3 bytes
> > + * With this optimization, GCC generates only 7 bytes of
> instructions:
> > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > + *      sete   al                           // 3 bytes
> > + */
> > +#undef RTE_MBUF_DIRECT
> > +#define RTE_MBUF_DIRECT(mb) \
> > +	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) +
> 7] & \
> > +	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> 8))))
> > +static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> 8)) << (7 * 8) =3D=3D
> > +	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
> > +	"RTE_MBUF_F_INDIRECT and/or RTE_MBUF_F_EXTERNAL are not in
> MSB.");
> > +#endif
> > +
> Couple of comments/thoughts/questions here.
>=20
> * This looks like a compiler limitation that should be fixed in GCC. =
IF
> we
>   put this optimization in, how will we know when/if we can remove it
> again
>   in future? I'm not sure we want this hanging around forever.

Agree.
There are plenty of hand crafted optimizations in DPDK, which are =
already obsolete;
it seems no one has found a good way of identifying them. Including =
myself.

> * Can the static_assert - which just checks flags are in the MSB - be
> * simplified to e.g.
>   "((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) << CHAR_BIT) =3D=3D 0"
>   or "__builtin_ctzll(...) > (7 * CHAR_BIT)"
> * As in prev bullet, I tend to prefer use of CHAR_BIT over hard-coded
> 8.

In v3, I have simplified both the static_assert and the optimized macro =
as you suggested on Slack,
with some minor improvements.

> * Is it necessary to limit this to just GCC and x86? If it leads to =
the
>   best code on x86, why not include for all compilers? What about non-
> x86
>   LE platforms?

I had already tested ARM64, where it didn't make a difference; now I =
have added a note about it.
I also tested ARM32, which doesn't benefit either, but I didn't add a =
note about it.
I also tested Loongarch (on Godbolt), which does benefit from it, so I =
added it.

Now, as I'm writing this email, Godbolt shows that RISC-V and POWER =
could also benefit.
Maybe we should just replace the standard macro with the optimized =
macro. WDYT?

> * Does the actual macro need to be that long and complex? If we
> simplify a
>   bit, does the compiler go back to generating bad code? For example:
>   using "(mb->ol_flags >> 56) & ((RTE_MBUF_F_INDIRECT | ..) >> 56)"

Simplified in v3.

> * If the above is true, do we need to actually put this in in =
assembler
> to
>   guarantee compiler generates good code in all situations?

No need for assembler.

