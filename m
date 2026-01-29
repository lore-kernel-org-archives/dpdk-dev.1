Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DDD358DB
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 08:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94784026F;
	Thu, 29 Jan 2026 09:28:08 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2F8BA4026A;
 Thu, 29 Jan 2026 09:28:07 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 69771206C2;
 Thu, 29 Jan 2026 09:28:06 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v18 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Date: Thu, 29 Jan 2026 09:28:02 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656C5@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260128194141.90018-2-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v18 1/2] eal: add __rte_may_alias and __rte_aligned to
 unaligned typedefs
Thread-Index: AdyQjl+q1yF6aQExRKub1QuzUopF3wAaNLKA
References: <20260128180516.76786-1-scott.k.mitch1@gmail.com>
 <20260128194141.90018-1-scott.k.mitch1@gmail.com>
 <20260128194141.90018-2-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, "Cyril Chemparathy" <cchemparathy@ezchip.com>,
 <stable@dpdk.org>
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

> @@ -199,7 +199,7 @@ verify_jhash_32bits(void)
>  				hash =3D rte_jhash(key, hashtest_key_lens[i],
>  						hashtest_initvals[j]);
>  				/* Divide key length by 4 in rte_jhash for 32
> bits */
> -				hash32 =3D rte_jhash_32b((const
> unaligned_uint32_t *)key,
> +				hash32 =3D rte_jhash_32b((const uint32_t *)key,
>  						hashtest_key_lens[i] >> 2,
>  						hashtest_initvals[j]);
>  				if (hash !=3D hash32) {

rte_jhash_32b() correctly takes a pointer to (aligned) uint32_t, not =
unaligned, so casting to unaligned might be introducing a bug. (The =
automatically aligned allocation of the local "key" variable prevents =
this bug from occurring, but anyway.)
Instead of changing the type cast, I'd prefer fixing this as follows:
Add a local variable uint32_t key32[sizeof(key)/sizeof(uint32_t)], and =
memcpy(key32,key,sizeof(key)), and then call rte_jhash_32b(key32,...) =
without type casting.

> +/**
> + * Types for potentially unaligned access.
> + *
> + * __rte_aligned(1) - Reduces alignment requirement to 1 byte,
> allowing
> + *                    these types to safely access memory at any
> address.
> + *                    Without this, accessing a uint16_t at an odd
> address
> + *                    is undefined behavior (even on x86 where
> hardware
> + *                    handles it).
> + *
> + * __rte_may_alias  - Prevents strict-aliasing optimization bugs =
where
> + *                    compilers may incorrectly elide memory
> operations
> + *                    when casting between pointer types.
> + */
> +#ifdef RTE_TOOLCHAIN_MSVC
> +typedef __rte_may_alias __rte_aligned(1) uint64_t unaligned_uint64_t;
> +typedef __rte_may_alias __rte_aligned(1) uint32_t unaligned_uint32_t;
> +typedef __rte_may_alias __rte_aligned(1) uint16_t unaligned_uint16_t;
> +#else
> +typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
> +typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
> +typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
>  #endif

Skimming GCC documentation, it looks like older versions required =
placing such attributes after the type, but newer versions seem to =
recommend placing them before, like qualifiers (const, volatile, ...).
Placing them before the type, like qualifiers, seems more natural to me.
And apparently, MSVC requires it.
Does it work for GCC and Clang if they are placed before, like MSVC?
Then we can get rid of the #ifdef RTE_TOOLCHAIN_MSVC.

