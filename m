Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7541BCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 19:17:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72E4040277;
	Fri, 26 Sep 2025 21:17:09 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E6FCE40262
 for <dev@dpdk.org>; Fri, 26 Sep 2025 21:17:08 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A7C74202CC;
 Fri, 26 Sep 2025 21:17:08 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [dpdk-dev v3 1/2] eal: Add rte_consttime_memneq() to prevent
 timing attacks memcmp.
Date: Fri, 26 Sep 2025 21:17:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6547B@smartserver.smartshare.dk>
In-Reply-To: <20250926160209.56496-1-kai.ji@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v3 1/2] eal: Add rte_consttime_memneq() to prevent
 timing attacks memcmp.
Thread-Index: Adwu/u8WxgrtXvLPTGmHQknwBCJMqQAGp0zQ
References: <20250926154905.54416-1-kai.ji@intel.com>
 <20250926160209.56496-1-kai.ji@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Kai Ji" <kai.ji@intel.com>,
	<dev@dpdk.org>
Cc: <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>,
 <bruce.richardson@intel.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
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

> From: Kai Ji [mailto:kai.ji@intel.com]
> Sent: Friday, 26 September 2025 18.02
>=20
> Bugzilla ID: 1773
> https://bugs.dpdk.org/show_bug.cgi?id=3D1773
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  lib/eal/include/rte_common.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 9e7d84f929..ddbba083be 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -700,6 +700,40 @@ rte_is_aligned(const void * const __rte_restrict
> ptr, const unsigned int align)
>  	return ((uintptr_t)ptr & (align - 1)) =3D=3D 0;
>  }
>=20
> +/**
> + * Constant-time memory inequality comparison.
> + *
> + * This function compares two memory regions in constant time, making
> it
> + * resistant to timing side-channel attacks. The execution time
> depends only
> + * on the length parameter, not on the actual data values being
> compared.
> + *
> + * This is particularly important for cryptographic operations where
> timing
> + * differences could leak information about secret keys, passwords, =
or
> other
> + * sensitive data.
> + *
> + * @param a
> + *   Pointer to the first memory region to compare
> + * @param b
> + *   Pointer to the second memory region to compare
> + * @param n
> + *   Number of bytes to compare
> + * @return
> + *   false if the memory regions are identical, true if they differ
> + */
> +static inline bool
> +rte_consttime_memneq(const void *a, const void *b, size_t n)
> +{
> +	const volatile uint8_t *pa =3D (const volatile uint8_t *)a;
> +	const volatile uint8_t *pb =3D (const volatile uint8_t *)b;
> +	uint8_t result =3D 0;
> +	size_t i;
> +
> +	for (i =3D 0; i < n; i++)
> +		result |=3D pa[i] ^ pb[i];
> +
> +	return result !=3D 0;
> +}
> +
>  /*********** Macros for compile type checks ********/
>=20
>  /* Workaround for toolchain issues with missing C11 macro in FreeBSD
> */
> --
> 2.34.1

My comments here still apply:
https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F6547A@smartse=
rver.smartshare.dk/

Also, this is certainly not a common function, so don't put it in =
rte_commo.h. Put it in rte_memory.h as suggested.

-Morten

