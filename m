Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED7C021A0
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 15:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 569EE400D7;
	Sat, 15 Feb 2025 16:21:37 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D16C840041
 for <dev@dpdk.org>; Sat, 15 Feb 2025 16:21:35 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 937442077A;
 Sat, 15 Feb 2025 16:21:35 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v6 01/11] eal: introduce new secure memory fill
Date: Sat, 15 Feb 2025 16:21:33 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FA3E@smartserver.smartshare.dk>
In-Reply-To: <20250213221819.1856769-2-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v6 01/11] eal: introduce new secure memory fill
Thread-Index: Adt+ZTstXACeqUsiSwGaDlDPV9goqgBVpQvQ
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
 <20250213221819.1856769-2-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Tyler Retzlaff" <roretzla@linux.microsoft.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 13 February 2025 23.16
>=20
> When memset() is used before a release function such as free,
> the compiler if allowed to optimize the memset away under
> the as-if rules. This is normally ok, but in certain cases such
> as passwords or security keys it is problematic.
>=20
> Introduce a DPDK wrapper which is equivalent to the
> C23 memset_explicit function.

I agree that zeroing is better than passing the fill character as a =
parameter.

After switching to zeroing, it's no longer like C23 memset_explicit.

> Name ot the new function chosen to be similar to

Typo: ot -> of

> Linux kernel internal memzero_explicit().

Just merge these last two sentences into one, e.g.:

Introduce a DPDK wrapper which is equivalent to the Linux kernel =
internal memzero_explicit().

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/include/rte_string_fns.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/lib/eal/include/rte_string_fns.h
> b/lib/eal/include/rte_string_fns.h
> index 702bd81251..93aae66614 100644
> --- a/lib/eal/include/rte_string_fns.h
> +++ b/lib/eal/include/rte_string_fns.h
> @@ -15,6 +15,7 @@
>  #include <stdio.h>
>  #include <string.h>
>=20
> +#include <rte_atomic.h>
>  #include <rte_common.h>
>  #include <rte_compat.h>
>=20
> @@ -149,6 +150,29 @@ rte_str_skip_leading_spaces(const char *src)
>  	return p;
>  }
>=20
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Fill memory with with zero's (e.g. sensitive keys)
> + * Normally using memset() is fine. But in cases where clearing
> + * out local data before going out of scope or freeing,
> + * use rte_memzero_explicit() to preven the compiler from optimizing

Typo: preven -> prevent

> + * away the zeroing.
> + *
> + * @param dst
> + *   target buffer
> + * @param sz
> + *   number of bytes to fill
> + */
> +__rte_experimental
> +static inline void
> +rte_memzero_explicit(void *dst, size_t sz)
> +{
> +	memset(dst, 0, sz);
> +	rte_compiler_barrier();
> +}
> +
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 2.47.2

With description and typos fixed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

