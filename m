Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360BCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FDEB4066D;
	Fri, 26 Sep 2025 14:34:17 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C7BB54025D;
 Fri, 26 Sep 2025 14:34:15 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 8FBFE202CC;
 Fri, 26 Sep 2025 14:34:15 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Date: Fri, 26 Sep 2025 14:34:14 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6547A@smartserver.smartshare.dk>
In-Reply-To: <aNZHCww6m8NJ_BHN@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Index: AdwuuwYNMhiSHlG8TOOQuN2e8UdYmwAI3KGw
References: <20250925102223.145471-1-kai.ji@intel.com>
 <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <3819475.yaVYbkx8dN@thomas>
 <aNZHCww6m8NJ_BHN@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, "Akhil Goyal" <gakhil@marvell.com>
Cc: "Kai Ji" <kai.ji@intel.com>, <dev@dpdk.org>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <stable@dpdk.org>,
 "David Marchand" <david.marchand@redhat.com>,
 "Pablo de Lara" <pablo.de.lara.guarch@intel.com>,
 "Fan Zhang" <fanzhang.oss@gmail.com>
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
> Sent: Friday, 26 September 2025 09.56
>=20
> On Thu, Sep 25, 2025 at 10:47:42PM +0200, Thomas Monjalon wrote:
> > 25/09/2025 12:33, Akhil Goyal:
> > > > +/**
> > > > + * Constant-time memory comparison for cryptographic use.
> > > > + * Returns 0 if the memory regions are equal, nonzero =
otherwise.
> > > > + * Runs in constant time with respect to the length to prevent
> timing attacks.
> > > > + *
> > > > + * @param a
> > > > + *   Pointer to the first memory region.
> > > > + * @param b
> > > > + *   Pointer to the second memory region.
> > > > + * @param n
> > > > + *   Number of bytes to compare.
> > > > + * @return
> > > > + *   0 if memory regions are equal, nonzero otherwise.
> > > > + */
> > > > +#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
> > > > +	const volatile uint8_t *__pa =3D (const volatile uint8_t
> *)(a); \
> > > > +	const volatile uint8_t *__pb =3D (const volatile uint8_t
> *)(b); \
> > > > +	uint8_t __result =3D 0; \
> > > > +	for (size_t __i =3D 0; __i < (n); __i++) \
> > > > +		__result |=3D __pa[__i] ^ __pb[__i]; \
> > > > +	__result; \
> > > > +})
> > >
> > > I believe this is not the right place to add this define.
> > > It should be somewhere in common eal if it is already not there.
> >
> > Yes indeed.
> > cryptodev is the API for managing crypto devices.
> > A new memcmp function would be better hosted in libc,
> > and in EAL for compatibility with all supported libc.
> >
> > I mean please add it in EAL, and propose it to glibc as well.
> >
>=20
> Just for reference, there is a good discussion of such functions and
> reference code under MIT license at [1]. After reading that, I note
> that
> the proposed macro above it not strictly a memcmp function because it
> just
> returns a zero/non-zero value, rather than a value indicating which
> array
> value is greater. Therefore some feedback on this code:
> * Use an inline function returning bool rather than a macro
> * A more accurate name might be rte_consttime_memneq, since the code
>   returns 0 (false) if equal.
>=20
> Regars,
> /Bruce
>=20
> [1] https://github.com/chmike/cst_time_memcmp

When deciding on the function name and location:
Can we foresee other consttime or crypto-purpose functions that should =
reside in the EAL?

There's already rte_memzero_explicit() in rte_memory.h:
https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/rte_memory.=
h#L747

Please use the same naming convention, i.e. put the function purpose =
first, and append the special behavior as postfix:
rte_memneq_consttime(), e.g.:
bool rte_memneq_consttime(const void *s1, const void *s2, size_t n);

IMHO, eal/include/rte_memory.h is a good location for this too.

Should it be an inline or normal function?
If it's primarily for fast path, inline is preferable.

You could also add the inverse function, i.e. add both memneq and memeq.

