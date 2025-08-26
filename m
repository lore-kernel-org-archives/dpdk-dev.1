Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E94CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 06:55:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 989244021E;
	Tue, 26 Aug 2025 08:55:25 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8EB6840156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 08:55:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3C58D2071D;
 Tue, 26 Aug 2025 08:55:24 +0200 (CEST)
Subject: RE: [PATCH v2 3/4] hash: reduce architecture special cases
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 08:55:23 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE6C@smartserver.smartshare.dk>
Content-class: urn:content-classes:message
In-Reply-To: <20250822182110.27599-4-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 3/4] hash: reduce architecture special cases
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwTkZq5RrPTkRzrSkSB8nruUgp0EACv6+pw
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-4-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <mattias.ronnblom@ericsson.com>
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
> Sent: Friday, 22 August 2025 20.20
>=20
> Make comparison of sizes compatible across platforms.
> Keep the special case code for 16 bytes for x86 and arm64 but
> also add simple xor for others.
>=20
> Need to keep rte_hash_k32_cmp_eq() exposed because ip_frag
> code poaches it.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/hash/rte_cmp_arm64.h   | 56 +------------------------
>  lib/hash/rte_cmp_generic.h | 35 ++++++++++++++++
>  lib/hash/rte_cmp_x86.h     | 60 ++------------------------
>  lib/hash/rte_cuckoo_hash.c | 86 =
+++++++++++++++++++++++++++++++++-----
>  4 files changed, 116 insertions(+), 121 deletions(-)
>  create mode 100644 lib/hash/rte_cmp_generic.h
>=20
> diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
> index a3e85635eb..2b2a37ebd2 100644
> --- a/lib/hash/rte_cmp_arm64.h
> +++ b/lib/hash/rte_cmp_arm64.h
> @@ -2,7 +2,7 @@
>   * Copyright(c) 2015 Cavium, Inc
>   */
>=20
> -/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +/* Functions to compare multiple of 16 byte keys */
>  static inline int
>  rte_hash_k16_cmp_eq(const void *key1, const void *key2,
>  		    size_t key_len __rte_unused)
> @@ -27,59 +27,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void
> *key2,
>  static inline int
>  rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
>  {
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
>  		rte_hash_k16_cmp_eq((const char *) key1 + 16,
>  				(const char *) key2 + 16, key_len);
>  }

Agree with the change from "||" to "|", to compare in blocks of 32 bytes =
instead of 16.

Another potential improvement:
Consider passing the actual length, instead of passing key_len, i.e.:
	return rte_hash_k16_cmp_eq(key1, key2, 16) |
		rte_hash_k16_cmp_eq((const char *) key1 + 16,
				(const char *) key2 + 16, 16);

[...]

> diff --git a/lib/hash/rte_cmp_x86.h b/lib/hash/rte_cmp_x86.h
> index ddfbef462f..e7a38c8fcd 100644
> --- a/lib/hash/rte_cmp_x86.h
> +++ b/lib/hash/rte_cmp_x86.h
> @@ -4,7 +4,7 @@
>=20
>  #include <rte_vect.h>
>=20
> -/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +/* Function to compare multiple of 16 byte keys */
>  static inline int
>  rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t =
key_len
> __rte_unused)
>  {
> @@ -18,59 +18,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void
> *key2, size_t key_len __rte_unu
>  static inline int
>  rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
>  {
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> -				(const char *) key2 + 16, key_len);
> -}
> -
> -static inline int
> -rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> -{
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> -				(const char *) key2 + 16, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> -{
> -	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t
> key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 96,
> -				(const char *) key2 + 96, key_len);
> -}
> -
> -static inline int
> -rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t
> key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k64_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
> +				(const uint8_t *) key2 + 16, key_len);

You should use "const char *" (not "const uint8_t *") here too.
Or add RTE_CONST_PTR_ADD() to rte_common.h:
/**
 * add a byte-value offset to a const pointer
 */
#define RTE_CONST_PTR_ADD(ptr, x) ((const void*)((uintptr_t)(ptr) + =
(x)))

>  }
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index 619fe0c691..199cb62bf0 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -42,13 +42,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
>  #define RETURN_IF_TRUE(cond, retval)
>  #endif
>=20
> -#if defined(RTE_ARCH_X86)
> -#include "rte_cmp_x86.h"
> -#endif
> -
> -#if defined(RTE_ARCH_ARM64)
> -#include "rte_cmp_arm64.h"
> -#endif
>=20
>  /*
>   * All different options to select a key compare function,
> @@ -57,7 +50,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
>   */
>  enum cmp_jump_table_case {
>  	KEY_CUSTOM =3D 0,
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>  	KEY_16_BYTES,
>  	KEY_32_BYTES,
>  	KEY_48_BYTES,
> @@ -66,11 +58,85 @@ enum cmp_jump_table_case {
>  	KEY_96_BYTES,
>  	KEY_112_BYTES,
>  	KEY_128_BYTES,
> -#endif
>  	KEY_OTHER_BYTES,
>  	NUM_KEY_CMP_CASES,
>  };
>=20
> +/*
> + * Comparison functions for different key sizes.
> + * Each function is only called with a specific fixed key size.
> + *
> + * Return value is 0 on equality to allow direct use of memcmp.
> + * Recommend using XOR and | operator to avoid branching
> + * as long as key is smaller than cache line size.
> + *
> + * Key1 always points to key[] in rte_hash_key which is aligned.
> + * Key2 is parameter to insert which might not be.
> + *
> + * Special case for 16 and 32 bytes to allow for architecture
> + * specific optimizations.
> + */
> +
> +#if defined(RTE_ARCH_X86)
> +#include "rte_cmp_x86.h"
> +#elif defined(RTE_ARCH_ARM64)
> +#include "rte_cmp_arm64.h"
> +#else
> +#include "rte_cmp_generic.h"
> +#endif
> +
> +static int
> +rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> +{
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
> +				    (const uint8_t *) key2 + 16, key_len) ||
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
> +				    (const uint8_t *) key2 + 32, key_len);
> +}
> +
> +static int
> +rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> +{
> +	return rte_hash_k32_cmp_eq(key1, key2, key_len) |

Is the "|" instead of "||", to compare in blocks of 64 bytes instead of =
32, intentional?

> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 32,
> +				    (const uint8_t *) key2 + 32, key_len);
> +}
> +
> +static int
> +rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len);
> +}
> +
> +static int
> +rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t =
key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len);
> +}
> +
> +static int
> +rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t
> key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len) ||
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
> +				    (const uint8_t *) key2 + 96, key_len);
> +}
> +
> +static int
> +rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t
> key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k64_cmp_eq((const uint8_t *) key1 + 64,
> +				(const uint8_t *) key2 + 64, key_len);
> +}
> +
>  /* Enum used to select the implementation of the signature comparison
> function to use
>   * eg: a system supporting SVE might want to use a NEON or scalar
> implementation.
>   */
> @@ -160,7 +226,6 @@ void rte_hash_set_cmp_func(struct rte_hash *h,
> rte_hash_cmp_eq_t func)
>   */
>  static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] =3D =
{
>  	[KEY_CUSTOM] =3D NULL,
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>  	[KEY_16_BYTES] =3D rte_hash_k16_cmp_eq,
>  	[KEY_32_BYTES] =3D rte_hash_k32_cmp_eq,
>  	[KEY_48_BYTES] =3D rte_hash_k48_cmp_eq,
> @@ -169,7 +234,6 @@ static const rte_hash_cmp_eq_t
> cmp_jump_table[NUM_KEY_CMP_CASES] =3D {
>  	[KEY_96_BYTES] =3D rte_hash_k96_cmp_eq,
>  	[KEY_112_BYTES] =3D rte_hash_k112_cmp_eq,
>  	[KEY_128_BYTES] =3D rte_hash_k128_cmp_eq,
> -#endif
>  	[KEY_OTHER_BYTES] =3D memcmp,
>  };
>=20
> --
> 2.47.2

With or without suggested changes...
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

