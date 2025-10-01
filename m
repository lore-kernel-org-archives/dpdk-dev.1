Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF4CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 18:57:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAB5A40BA0;
	Wed,  1 Oct 2025 20:57:04 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C3125400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 20:57:03 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A618F209B9;
 Wed,  1 Oct 2025 20:57:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based on
 OpenBSD API
Date: Wed, 1 Oct 2025 20:57:02 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6548B@smartserver.smartshare.dk>
In-Reply-To: <20251001153242.55987-1-kai.ji@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based
 on OpenBSD API
Thread-Index: Adwy6KYSeY7Xv/vGRaGEd4AitL9zLAAGs04Q
References: <20250929145049.153078-1-kai.ji@intel.com>
 <20251001153242.55987-1-kai.ji@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Kai Ji" <kai.ji@intel.com>, <dev@dpdk.org>, <stephen@networkplumber.org>
Cc: <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>,
 <bruce.richardson@intel.com>, <thomas@monjalon.net>
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
> Sent: Wednesday, 1 October 2025 17.33
>=20
> Bugzilla ID: 1773
> https://bugs.dpdk.org/show_bug.cgi?id=3D1773
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  lib/eal/include/rte_memory.h | 38 =
++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/lib/eal/include/rte_memory.h
> b/lib/eal/include/rte_memory.h
> index dcc0e69cfe..6939c1caad 100644
> --- a/lib/eal/include/rte_memory.h
> +++ b/lib/eal/include/rte_memory.h
> @@ -746,6 +746,44 @@ __rte_experimental
>  void
>  rte_memzero_explicit(void *dst, size_t sz);
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Constant-time memory comparison.
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
> + *   0 if the memory regions are identical, non-zero if they differ
> + */
> +__rte_experimental
> +static inline int
> +rte_timingsafe_memcmp(const void *a, const void *b, size_t n)
> +{
> +	const volatile uint8_t *pa =3D (const volatile uint8_t *)a;
> +	const volatile uint8_t *pb =3D (const volatile uint8_t *)b;
> +	uint8_t result =3D 0;
> +	size_t i;
> +
> +	for (i =3D 0; i < n; i++)
> +		result |=3D pa[i] ^ pb[i];
> +
> +	return result;
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.34.1

NAK.
This returns (binary) non-equality only. It does not return (tri-state) =
<0, 0, or >0, so it's not like memcmp or FreeBSD timingsafe_memcmp.

Also, please put the function ("memeq") first in the name, and then the =
extra property ("timingsafe") last, like rte_memzero_explicit.
Like this:
__rte_experimental
static inline bool
rte_memeq_timingsafe(const void *a, const void *b, size_t n)
{
	const volatile uint8_t *pa =3D (const volatile uint8_t *)a;
	const volatile uint8_t *pb =3D (const volatile uint8_t *)b;
	uint8_t result =3D 0;
	size_t i;

	for (i =3D 0; i < n; i++)
		result |=3D pa[i] ^ pb[i];

	return result =3D=3D UINT8_C(0);
}

Stephen, agree?

