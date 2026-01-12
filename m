Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD613C9EC90
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 13:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9376F40A8A;
	Mon, 12 Jan 2026 14:28:33 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BB63C40156
 for <dev@dpdk.org>; Mon, 12 Jan 2026 14:28:31 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C10FC206E5;
 Mon, 12 Jan 2026 14:28:30 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v14 1/2] eal: add __rte_may_alias to unaligned typedefs
Date: Mon, 12 Jan 2026 14:28:28 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65654@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260112120411.27314-2-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v14 1/2] eal: add __rte_may_alias to unaligned typedefs
Thread-Index: AdyDu5QsI28YBo9bQDyAEV8VPenifgACY7lA
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260112120411.27314-2-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> Add __rte_may_alias attribute to unaligned_uint{16,32,64}_t typedefs
> to prevent GCC strict-aliasing optimization bugs. GCC has a bug where
> it incorrectly elides struct initialization when strict aliasing is
> enabled, causing reads from uninitialized memory.
>=20
> The __rte_may_alias attribute signals to the compiler that these types
> can alias other types, preventing the incorrect optimization.

I'm wondering if this is the right place to add __rte_may_alias, i.e. if =
the scope of the workaround is correct.

Are the unaligned_uintNN_t types only used in a way where they are =
affected by the GCC bug?
If not, adding __rte_may_alias to the types themselves may be too broad.

Does the GCC bug only affect the unaligned_uintNN_t types?
Or does it occur elsewhere or for other types too? Then this workaround =
only solves the problem for parts of the code.

Minor detail:
If the bug only occurs on GCC, not Clang, please make the workaround =
GCC-only, using the preprocessor.

>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  lib/eal/include/rte_common.h | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>=20
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 9e7d84f929..ac70270cfb 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -121,14 +121,27 @@ extern "C" {
>  #define __rte_aligned(a) __attribute__((__aligned__(a)))
>  #endif
>=20
> +/**
> + * Macro to mark a type that is not subject to type-based aliasing
> rules
> + */
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __rte_may_alias
> +#else
> +#define __rte_may_alias __attribute__((__may_alias__))
> +#endif
> +
> +/**
> + * __rte_may_alias avoids compiler bugs (GCC) that elide
> initialization
> + * of memory when strict-aliasing is enabled.
> + */
>  #ifdef RTE_ARCH_STRICT_ALIGN
> -typedef uint64_t unaligned_uint64_t __rte_aligned(1);
> -typedef uint32_t unaligned_uint32_t __rte_aligned(1);
> -typedef uint16_t unaligned_uint16_t __rte_aligned(1);
> +typedef uint64_t unaligned_uint64_t __rte_may_alias __rte_aligned(1);
> +typedef uint32_t unaligned_uint32_t __rte_may_alias __rte_aligned(1);
> +typedef uint16_t unaligned_uint16_t __rte_may_alias __rte_aligned(1);
>  #else
> -typedef uint64_t unaligned_uint64_t;
> -typedef uint32_t unaligned_uint32_t;
> -typedef uint16_t unaligned_uint16_t;
> +typedef uint64_t unaligned_uint64_t __rte_may_alias;
> +typedef uint32_t unaligned_uint32_t __rte_may_alias;
> +typedef uint16_t unaligned_uint16_t __rte_may_alias;
>  #endif
>=20
>  /**
> @@ -159,15 +172,6 @@ typedef uint16_t unaligned_uint16_t;
>  #define __rte_packed_end __attribute__((__packed__))
>  #endif
>=20
> -/**
> - * Macro to mark a type that is not subject to type-based aliasing
> rules
> - */
> -#ifdef RTE_TOOLCHAIN_MSVC
> -#define __rte_may_alias
> -#else
> -#define __rte_may_alias __attribute__((__may_alias__))
> -#endif
> -
>  /******* Macro to mark functions and fields scheduled for removal
> *****/
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_deprecated
> --
> 2.39.5 (Apple Git-154)

