Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3190CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB43A4021E;
	Thu, 23 Oct 2025 18:24:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7D7B540151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:24:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5362B2041E;
 Thu, 23 Oct 2025 18:24:11 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5] mbuf: optimize segment prefree
Date: Thu, 23 Oct 2025 18:24:07 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654FF@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aPpR4jZtBvDM42pL@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5] mbuf: optimize segment prefree
Thread-Index: AdxENrDrjX2d9lTTSJS/qZbWKPTppAAAhFfw
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023080136.165513-1-mb@smartsharesystems.com>
 <c556ea7b92a24bc09ac5240da39bc36c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654F7@smartserver.smartshare.dk>
 <6a26d57153714d04865753fd557978dd@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654FB@smartserver.smartshare.dk>
 <e12aa6583cb34a3595fd518c187bf144@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654FE@smartserver.smartshare.dk>
 <aPpR4jZtBvDM42pL@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <thomas@monjalon.net>
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Fengchengwen" <fengchengwen@huawei.com>
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
> Sent: Thursday, 23 October 2025 18.04
>=20
> On Thu, Oct 23, 2025 at 05:46:49PM +0200, Morten Br=F8rup wrote:
> > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > Sent: Thursday, 23 October 2025 17.27
> > >
> > > > > From: Konstantin Ananyev =
[mailto:konstantin.ananyev@huawei.com]
> > > > > Sent: Thursday, 23 October 2025 16.05
> > > > >
> > > > > > > From: Konstantin Ananyev
> [mailto:konstantin.ananyev@huawei.com]
> > > > > > > Sent: Thursday, 23 October 2025 10.51
> > > > > > >
> > > > > > > > -#define RTE_MBUF_DIRECT(mb) \
> > > > > > > > -	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > > + *
> > > > > > > > + * Note: Macro optimized for code size.
> > > > > > > > + *
> > > > > > > > + * The plain macro would be:
> > > > > > > > + *      #define RTE_MBUF_DIRECT(mb) \
> > > > > > > > + *          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > > + *
> > > > > > > > + * The flags RTE_MBUF_F_INDIRECT and =
RTE_MBUF_F_EXTERNAL
> are
> > > > > both in
> > > > > > > the
> > > > > > > > MSB (most significant
> > > > > > > > + * byte) of the 64-bit ol_flags field, so we only
> compare
> > > this
> > > > > one
> > > > > > > byte instead of all
> > > > > > > > 64 bits.
> > > > > > > > + *
> > > > > > > > + * E.g., GCC version 16.0.0 20251019 (experimental)
> > > generates
> > > > > the
> > > > > > > following code
> > > > > > > > for x86-64.
> > > > > > > > + *
> > > > > > > > + * With the plain macro, 17 bytes of instructions:
> > > > > > > > + *      movabs rax,0x6000000000000000       // 10 bytes
> > > > > > > > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > > + * With this optimized macro, only 7 bytes of
> instructions:
> > > > > > > > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > > + */
> > > > > > > > +#if RTE_BYTE_ORDER =3D=3D RTE_LITTLE_ENDIAN
> > > > > > > > +/* On little endian architecture, the MSB of a 64-bit
> > > integer is
> > > > > at
> > > > > > > byte offset 7. */
> > > > > > > > +#define RTE_MBUF_DIRECT(mb)     !(((const char =
*)(&(mb)-
> > > > > > > >ol_flags))[7] & 0x60)
> > > > > > > > +#elif RTE_BYTE_ORDER =3D=3D RTE_BIG_ENDIAN
> > > > > > > > +/* On big endian architecture, the MSB of a 64-bit
> integer
> > > is at
> > > > > > > byte offset 0. */
> > > > > > > > +#define RTE_MBUF_DIRECT(mb)     !(((const char =
*)(&(mb)-
> > > > > > > >ol_flags))[0] & 0x60)
> > > > > > >
> > > > > > > A stupid q: why then not simply do:
> > > > > > > (mb->ol_flags >> 56) & 0x60
> > > > > > > then?
> > > > > > > Should help to all these LE/BE casts, etc.
> > > > > >
> > > > > > GCC is too stupid for that too.
> > > > > >
> > > > > > Playing around with Godbolt shows that
> > > > > > 	return !((char)(p[3] >> 56) & 0x60);
> > > > > > becomes
> > > > > > 	movzx  eax,BYTE PTR [rdi+0x1f]	// 4 bytes
> > > > > > 	test   al,0x60				// 2 bytes
> > > > > > Instead of simply
> > > > > > 	test   BYTE PTR [rdi+0x1f],0x60	// 4 bytes
> > > > >
> > > > > And these 2 extra bytes in instructions, are that really that
> > > critical?
> > > > > My guess, we wouldn't notice any real diff here.
> > > >
> > > > The optimized macro made the common code path of the refactored
> > > > rte_pktmbuf_prefree_seg() fit into one cache line.
> > > > IIRC, all 10 bytes saving were required for this.
> > >
> > > I understand that. but is that change will provide a measurable
> impact,
> > > in terms of cycles/op or pps or so?
> >
> > L1 instruction cache is important; reducing code size of a =
per-packet
> function might have an effect in some cases.
> > I don't have other metrics than code size for this optimization.
> >
> > I just tested to see if I recalled correctly, and here's the
> generated code with the two different macros:
> >
> > #define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)-
> >ol_flags))[7] & 0x60)
> >
> > 0000000000000670 <review_rte_pktmbuf_prefree_seg>:
> >      670:       f3 0f 1e fa             endbr64
> >      674:       41 57                   push   %r15
> >      676:       41 56                   push   %r14
> >      678:       41 55                   push   %r13
> >      67a:       41 54                   push   %r12
> >      67c:       55                      push   %rbp
> >      67d:       53                      push   %rbx
> >      67e:       48 89 fb                mov    %rdi,%rbx
> >      681:       48 83 ec 18             sub    $0x18,%rsp
> >      685:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
> >      68c:       00 00
> >      68e:       48 89 44 24 08          mov    %rax,0x8(%rsp)
> >      693:       31 c0                   xor    %eax,%eax
> >      695:       0f b7 6f 12             movzwl 0x12(%rdi),%ebp
> >      699:       66 83 fd 01             cmp    $0x1,%bp
> >      69d:       75 51                   jne    6f0
> <review_rte_pktmbuf_prefree_seg+0x80>
> > ** Look here {
> >      69f:       f6 47 1f 60             testb  $0x60,0x1f(%rdi)
> >      6a3:       75 6b                   jne    710
> <review_rte_pktmbuf_prefree_seg+0xa0>
> > ** }
> >      6a5:       66 83 7b 14 01          cmpw   $0x1,0x14(%rbx)
> >      6aa:       74 09                   je     6b5
> <review_rte_pktmbuf_prefree_seg+0x45>
> >      6ac:       b8 01 00 00 00          mov    $0x1,%eax
> >      6b1:       66 89 43 14             mov    %ax,0x14(%rbx)
> >      6b5:       48 83 7b 40 00          cmpq   $0x0,0x40(%rbx)
> >      6ba:       74 08                   je     6c4
> <review_rte_pktmbuf_prefree_seg+0x54>
> >      6bc:       48 c7 43 40 00 00 00    movq   $0x0,0x40(%rbx)
> >      6c3:       00
> >      6c4:       48 89 d8                mov    %rbx,%rax
> >      6c7:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
> >      6cc:       64 48 2b 14 25 28 00    sub    %fs:0x28,%rdx
> >      6d3:       00 00
> >      6d5:       0f 85 3a 02 00 00       jne    915
> <review_rte_pktmbuf_prefree_seg+0x2a5>
> >      6db:       48 83 c4 18             add    $0x18,%rsp
> >      6df:       5b                      pop    %rbx
> >      6e0:       5d                      pop    %rbp
> >      6e1:       41 5c                   pop    %r12
> >      6e3:       41 5d                   pop    %r13
> >      6e5:       41 5e                   pop    %r14
> >      6e7:       41 5f                   pop    %r15
> >      6e9:       c3                      ret
> >
> > #define RTE_MBUF_DIRECT(mb) \
> > 	!((char)((mb)->ol_flags >> (7 * CHAR_BIT)) & \
> > 	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> CHAR_BIT)))
> >
> > 0000000000000690 <review_rte_pktmbuf_prefree_seg>:
> >      690:       f3 0f 1e fa             endbr64
> >      694:       41 57                   push   %r15
> >      696:       41 56                   push   %r14
> >      698:       41 55                   push   %r13
> >      69a:       41 54                   push   %r12
> >      69c:       55                      push   %rbp
> >      69d:       53                      push   %rbx
> >      69e:       48 89 fb                mov    %rdi,%rbx
> >      6a1:       48 83 ec 18             sub    $0x18,%rsp
> >      6a5:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
> >      6ac:       00 00
> >      6ae:       48 89 44 24 08          mov    %rax,0x8(%rsp)
> >      6b3:       31 c0                   xor    %eax,%eax
> >      6b5:       0f b7 6f 12             movzwl 0x12(%rdi),%ebp
> >      6b9:       66 83 fd 01             cmp    $0x1,%bp
> >      6bd:       75 59                   jne    718
> <review_rte_pktmbuf_prefree_seg+0x88>
> > ** Look here {
> >      6bf:       48 8b 47 18             mov    0x18(%rdi),%rax
> >      6c3:       48 89 c2                mov    %rax,%rdx
> >      6c6:       48 c1 ea 38             shr    $0x38,%rdx
> >      6ca:       83 e2 60                and    $0x60,%edx
> >      6cd:       75 71                   jne    740
> <review_rte_pktmbuf_prefree_seg+0xb0>
> > * }
> >      6cf:       66 83 7b 14 01          cmpw   $0x1,0x14(%rbx)
> >      6d4:       74 09                   je     6df
> <review_rte_pktmbuf_prefree_seg+0x4f>
> >      6d6:       b8 01 00 00 00          mov    $0x1,%eax
> >      6db:       66 89 43 14             mov    %ax,0x14(%rbx)
> >      6df:       48 83 7b 40 00          cmpq   $0x0,0x40(%rbx)
> >      6e4:       74 08                   je     6ee
> <review_rte_pktmbuf_prefree_seg+0x5e>
> >      6e6:       48 c7 43 40 00 00 00    movq   $0x0,0x40(%rbx)
> >      6ed:       00
> >      6ee:       48 89 d8                mov    %rbx,%rax
> >      6f1:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
> >      6f6:       64 48 2b 14 25 28 00    sub    %fs:0x28,%rdx
> >      6fd:       00 00
> >      6ff:       0f 85 50 02 00 00       jne    955
> <review_rte_pktmbuf_prefree_seg+0x2c5>
> >      705:       48 83 c4 18             add    $0x18,%rsp
> >      709:       5b                      pop    %rbx
> >      70a:       5d                      pop    %rbp
> >      70b:       41 5c                   pop    %r12
> >      70d:       41 5d                   pop    %r13
> >      70f:       41 5e                   pop    %r14
> >      711:       41 5f                   pop    %r15
> >      713:       c3                      ret
> >
> > >
> > > > > But if it really is, can I ask you to create a new define for
> 0x60,
> > > > > to avoid hardcoded constants in the code?
> > > > > Might be something  like
> > > > > #define RTE_MBUF_F_INDIRECT_EXTERNAL_1B ...
> > > > > or so.
> > > >
> > > > I started out using the field names, but Bruce suggested using
> 0x60
> > > for
> > > > readability, making the macros shorter, which IMO looks good.
> > > >
> > > > I don't like adding special names just for this, so either we
> stick
> > > with 0x60 or go for
> > > > "(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > > CHAR_BIT))", something like this:
> > >
> > > My vote would be to use the construction above.
> > > Might be put it in a new macro for readability.
> > > Konstantin
> >
> > The optimization requires casting ol_flags as a byte array and then
> reading the MSB; otherwise GCC and some other compilers are too stupid
> to perform the optimization.
> > So, should I post a v7 with the code proposed below (to get rid of
> the 0x60 numerical value)?
> >
> While I'm not going to massively complain about removing it, I think
> using
> the numeric value is absolutely fine because we check its validity
> using a
> static_assert, which also serves to document where the constant comes
> from.
>=20
> /Bruce

I have posted a v7 patch, so you can all see how it looks with long =
names vs. numerical value.

I just want the optimization, and have no strong preference of one or =
the other.

If none of you have any strong opinions, let's let @Thomas choose. :-)

