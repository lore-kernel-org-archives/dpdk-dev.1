Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A53ECA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3713D402D4;
	Tue, 26 Aug 2025 16:36:43 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 72407402AE
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:36:42 +0200 (CEST)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 0DBB32E67
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:36:41 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id E3CE62F4C; Tue, 26 Aug 2025 16:36:41 +0200 (CEST)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 6684C2F4B;
 Tue, 26 Aug 2025 16:36:39 +0200 (CEST)
Message-ID: <05cd927d-e4e9-441f-b247-0bdc138c8de0@lysator.liu.se>
Date: Tue, 26 Aug 2025 16:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hash: reduce architecture special cases
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
 <20250822182110.27599-4-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250822182110.27599-4-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-08-22 20:19, Stephen Hemminger wrote:
> Make comparison of sizes compatible across platforms.
> Keep the special case code for 16 bytes for x86 and arm64 but
> also add simple xor for others.
> 
> Need to keep rte_hash_k32_cmp_eq() exposed because ip_frag
> code poaches it.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   lib/hash/rte_cmp_arm64.h   | 56 +------------------------
>   lib/hash/rte_cmp_generic.h | 35 ++++++++++++++++
>   lib/hash/rte_cmp_x86.h     | 60 ++------------------------
>   lib/hash/rte_cuckoo_hash.c | 86 +++++++++++++++++++++++++++++++++-----
>   4 files changed, 116 insertions(+), 121 deletions(-)
>   create mode 100644 lib/hash/rte_cmp_generic.h
> 
> diff --git a/lib/hash/rte_cmp_arm64.h b/lib/hash/rte_cmp_arm64.h
> index a3e85635eb..2b2a37ebd2 100644
> --- a/lib/hash/rte_cmp_arm64.h
> +++ b/lib/hash/rte_cmp_arm64.h
> @@ -2,7 +2,7 @@
>    * Copyright(c) 2015 Cavium, Inc
>    */
>   
> -/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +/* Functions to compare multiple of 16 byte keys */
>   static inline int
>   rte_hash_k16_cmp_eq(const void *key1, const void *key2,
>   		    size_t key_len __rte_unused)
> @@ -27,59 +27,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2,
>   static inline int
>   rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
>   {
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
>   		rte_hash_k16_cmp_eq((const char *) key1 + 16,
>   				(const char *) key2 + 16, key_len);
>   }
> -
> -static inline int
> -rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> -				(const char *) key2 + 16, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 96,
> -				(const char *) key2 + 96, key_len);
> -}
> -
> -static inline int
> -rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k64_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> diff --git a/lib/hash/rte_cmp_generic.h b/lib/hash/rte_cmp_generic.h
> new file mode 100644
> index 0000000000..f846d562e3
> --- /dev/null
> +++ b/lib/hash/rte_cmp_generic.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Stephen Hemminger
> + */
> +
> +#ifndef _RTE_CMP_GENERIC_H_
> +#define _RTE_CMP_GENERIC_H_
> +
> +/* Function to compare 16 byte keys */
> +static inline int
> +rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
> +{
> +#ifdef RTE_ARCH_64
> +	const uint64_t *k1 = key1;
> +	const unaligned_uint64_t *k2 = key2;
> +
> +	return ((k1[0] ^ k2[0]) | (k1[1] ^ k2[1])) != 0;

Remove '!= 0'.

> +#else
> +	const uint32_t *k1 = key1;
> +	const unaligned_uint32_t *k2 = key2;
> +
> +	return (k1[0] ^ k2[0]) | (k1[1] ^ k2[1]) |
> +	       (k1[2] ^ k2[2]) | (k1[3] ^ k2[3]);
> +#endif
> +}
> +
> +/* Function to compare 32 byte keys */
> +static inline int
> +rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)

eq -> neq not worth the trouble. Correct? Some other patch set.

> +{
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
> +				(const uint8_t *) key2 + 16, key_len);
> +}
> +
> +#endif
> diff --git a/lib/hash/rte_cmp_x86.h b/lib/hash/rte_cmp_x86.h
> index ddfbef462f..e7a38c8fcd 100644
> --- a/lib/hash/rte_cmp_x86.h
> +++ b/lib/hash/rte_cmp_x86.h
> @@ -4,7 +4,7 @@
>   
>   #include <rte_vect.h>
>   
> -/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
> +/* Function to compare multiple of 16 byte keys */
>   static inline int
>   rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
>   {
> @@ -18,59 +18,7 @@ rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unu
>   static inline int
>   rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
>   {
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> -				(const char *) key2 + 16, key_len);
> -}
> -
> -static inline int
> -rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 16,
> -				(const char *) key2 + 16, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 32,
> -				(const char *) key2 + 32, key_len);
> -}
> -
> -static inline int
> -rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> -}
> -
> -static inline int
> -rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k32_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len) ||
> -		rte_hash_k16_cmp_eq((const char *) key1 + 96,
> -				(const char *) key2 + 96, key_len);
> -}
> -
> -static inline int
> -rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
> -{
> -	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> -		rte_hash_k64_cmp_eq((const char *) key1 + 64,
> -				(const char *) key2 + 64, key_len);
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
> +				(const uint8_t *) key2 + 16, key_len);
>   }
> diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> index 619fe0c691..199cb62bf0 100644
> --- a/lib/hash/rte_cuckoo_hash.c
> +++ b/lib/hash/rte_cuckoo_hash.c
> @@ -42,13 +42,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
>   #define RETURN_IF_TRUE(cond, retval)
>   #endif
>   
> -#if defined(RTE_ARCH_X86)
> -#include "rte_cmp_x86.h"
> -#endif
> -
> -#if defined(RTE_ARCH_ARM64)
> -#include "rte_cmp_arm64.h"
> -#endif
>   
>   /*
>    * All different options to select a key compare function,
> @@ -57,7 +50,6 @@ RTE_LOG_REGISTER_DEFAULT(hash_logtype, INFO);
>    */
>   enum cmp_jump_table_case {
>   	KEY_CUSTOM = 0,
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>   	KEY_16_BYTES,
>   	KEY_32_BYTES,
>   	KEY_48_BYTES,
> @@ -66,11 +58,85 @@ enum cmp_jump_table_case {
>   	KEY_96_BYTES,
>   	KEY_112_BYTES,
>   	KEY_128_BYTES,
> -#endif
>   	KEY_OTHER_BYTES,
>   	NUM_KEY_CMP_CASES,
>   };
>   
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
> +rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k16_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 16,
> +				    (const uint8_t *) key2 + 16, key_len) ||

'||' -> '|'?

> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 32,
> +				    (const uint8_t *) key2 + 32, key_len);
> +}
> +
> +static int
> +rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k32_cmp_eq(key1, key2, key_len) |
> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 32,
> +				    (const uint8_t *) key2 + 32, key_len);
> +}
> +
> +static int
> +rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||

'||' -> '|'

Same in many of the below _eq functions.

> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len);
> +}
> +
> +static int
> +rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len);
> +}
> +
> +static int
> +rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k32_cmp_eq((const uint8_t *) key1 + 64,
> +				    (const uint8_t *) key2 + 64, key_len) ||
> +		rte_hash_k16_cmp_eq((const uint8_t *) key1 + 96,
> +				    (const uint8_t *) key2 + 96, key_len);
> +}
> +
> +static int
> +rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
> +{
> +	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
> +		rte_hash_k64_cmp_eq((const uint8_t *) key1 + 64,
> +				(const uint8_t *) key2 + 64, key_len);
> +}
> +
>   /* Enum used to select the implementation of the signature comparison function to use
>    * eg: a system supporting SVE might want to use a NEON or scalar implementation.
>    */
> @@ -160,7 +226,6 @@ void rte_hash_set_cmp_func(struct rte_hash *h, rte_hash_cmp_eq_t func)
>    */
>   static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
>   	[KEY_CUSTOM] = NULL,
> -#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>   	[KEY_16_BYTES] = rte_hash_k16_cmp_eq,
>   	[KEY_32_BYTES] = rte_hash_k32_cmp_eq,
>   	[KEY_48_BYTES] = rte_hash_k48_cmp_eq,
> @@ -169,7 +234,6 @@ static const rte_hash_cmp_eq_t cmp_jump_table[NUM_KEY_CMP_CASES] = {
>   	[KEY_96_BYTES] = rte_hash_k96_cmp_eq,
>   	[KEY_112_BYTES] = rte_hash_k112_cmp_eq,
>   	[KEY_128_BYTES] = rte_hash_k128_cmp_eq,
> -#endif
>   	[KEY_OTHER_BYTES] = memcmp,
>   };
>   

